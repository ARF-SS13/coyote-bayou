// A subsystem? For recoil? In MY BYOND? It'datum/mob_recoils more likely than you think.
#define RECOIL_DTIME_SHIFT 5 // 2^5 = 32*2 = 64 deciseconds 
#define RECOIL_MOB_SHIFT 3 // 2^3 = 8*2 = 16 deciseconds of shooting to average recoil over
/// Arg definitions:
/// gun_recoil = the gun_recoil datum that is being used
/// recoil_tag = tag relating to the gun recoil
/// recoil_list = 2-item list of the recoil_tag that can be converted to a tag
/// recoil_in = the base amount of recoil to be processed
/// my_recoil = the mob_recoil datum that is being processed

#define RECOIL_MOVED (1 << 0)
#define RECOIL_SHOT (1 << 1)

SUBSYSTEM_DEF(recoil)
	name = "Recoil"
	flags = SS_BACKGROUND
	wait = 0.2 SECONDS // Fast processing! But, not too fast. Like a medium rare steak.
	/// Time to datumize the recoil system.
	/// Format: list("ckey" = /datum/mob_recoil, ...)
	var/list/mob_recoils = list()
	/// Neato cached list of recoils to process
	/// Format: list("ckey" = /datum/mob_recoil, ...)
	var/list/current_mob_recoils = list()
	/// The last number of mob_recoils processed
	var/last_recoil_count = 0
	/// The last number of mob_recoils moved
	var/last_move_count = 0
	/// The last number of mob_recoils shot
	var/last_shoot_count = 0
	/// The last sixteen times the recoil system was processed, in deciseconds, for making a rolling average for delta-time shenanigoates
	var/list/delta_time_list = list()
	/// The time it took to tick the last process
	var/last_fire_start = 0
	/// The time it took to tick the last process
	var/last_fire_end = 0
	/// Delta Time -- compensates for lag
	var/delta_time = 1

	/// The inputs for the Weighted Spread Recoil Table (WSRT)
	/// ^^ that was a terrible idea
	// var/recoil_equation_start = 100
	// var/recoil_equation_subtract = 0
	// var/recoil_equation_multiply = 0.98
	// var/recoil_equation_exponent = 0.98
	// var/recoil_equation_frick_it_just_gauss_it = 1
	// var/list/recoil_equation = list()
	// var/recoil_index = 1
	/// forewarning: statistics are hard
	var/recoil_equation_gauss_mean_mult = 0.5 // recoil of 20 has a mean of 10 degree total offset
	var/recoil_equation_gauss_std_mult = 0.5 // recoil of 20 has a 68% chance to be within +-10 deg offset, 95% chance to be between +-20

	/// Item recoil datums (cus I am tired of them just floating around in the 'nowhere')
	/// Define how much recoil an item gives when fired, in various ways.
	/// Format: list("tag" = /datum/recoil, ...)
	var/list/gun_recoils = list()

	/// Global recoil reduction per second
	var/recoil_reduction_per_second = 4
	/// Global exponent to a mob's two recoils per tick, used to remove a scaling portion of the mob's recoil
	/// Only applied to shoot recoil if they arent shooting, and move recoil if they arent moving
	/// Every tick (0.2 seconds), reduces current recoil by (current recoil ** this var)
	/// Without the above var, it'll never hit zero!
	var/recoil_reduction_exponent_per_tick = 0.8
	var/recoil_softcap = 30
	var/recoil_movement_spread_cap = 10

	var/kick_to_recoil_mult = 1

	var/use_movement_recoil = TRUE
	var/use_shoot_recoil = TRUE

	var/recoil_min_movement = -40
	var/recoil_max_movement = 15
	var/recoil_max_shoot = 40
	var/recoil_max_spread = MAX_ACCURACY_OFFSET

	var/recoil_movement_increase_multiplier = 1
	var/recoil_shoot_increase_multiplier = 1

	var/recoil_movement_heaviness_mult = 1
	var/recoil_movement_heaviness_scoot_bonus_mult = 1
	var/recoil_movement_slowest_speed = 3
	var/recoil_movement_speed_mult = 1

	var/recoil_offset_low_spread_threshold = 3
	var/recoil_offset_premult = 80
	var/recoil_offset_postmult = 0.01

	var/recoil_wielded_reward = 0.85

	var/turbofrick_threshold = 5

	/// GLobal multiplier to converting recoil into spread
	var/recoil_to_spread_mult = 1
	/// Time a human has to not move before they can move without recoil
	var/recoil_scooch_time = RECOIL_SCOOCH_TIME
	/// Distance humans can move without movement recoil if they havent moved in a bit
	var/scooch_distance = 2
	/// Time after shooting that the recoil system applies exponential decay to recoil
	var/recoil_post_shoot_fast_decay_delay = RECOIL_SHOOT_TIME
	/// Time between adding/recording average firing rate
	var/recoil_average_shots_per_second_ticklength = 1 SECONDS

	var/debug_recoil = FALSE

/datum/controller/subsystem/recoil/stat_entry(msg)
	msg = "R:[last_recoil_count]([last_move_count]:[last_shoot_count])/[LAZYLEN(mob_recoils)]-C:[round(cost,0.005)]"
	return ..()

/datum/controller/subsystem/recoil/Initialize(start_timeofday)
	if(!generate_recoil_datum()) // generate a recoil datum we can rely on always being there for us
		message_admins("Recoil system failed to initialize! shoot's broken!")
	for(var/i in 1 to (1 << RECOIL_DTIME_SHIFT))
		delta_time_list += wait
	//generate_recoil_equation()
	. = ..()

/datum/controller/subsystem/recoil/fire(resumed)
	if(!resumed)
		last_fire_start = world.timeofday
		current_mob_recoils = mob_recoils.Copy()
		last_recoil_count = 0
		last_move_count = 0
		last_shoot_count = 0
	//cache for sanic speed (lists are references anyways)
	/// yeah this is copied from processing.dm
	var/list/recoil_list = current_mob_recoils
	var/iterations_left = 200 // surely we'll never have over 200 players
	while(recoil_list.len && iterations_left--)
		var/ckey = LAZYACCESS(recoil_list, LAZYLEN(recoil_list))
		var/datum/mob_recoil/my_recoil = LAZYACCESS(recoil_list, ckey)
		recoil_list.len--
		var/r_flag = my_recoil.tick_recoil(recoil_reduction_per_second, wait, delta_time)
		if(CHECK_BITFIELD(r_flag, RECOIL_MOVED))
			last_move_count++
		if(CHECK_BITFIELD(r_flag, RECOIL_SHOT))
			last_shoot_count++
		if(r_flag)
			last_recoil_count++
		if(MC_TICK_CHECK)
			return
	last_fire_end = world.timeofday
	update_delta_time()

/datum/controller/subsystem/recoil/proc/update_delta_time()
	delta_time_list.Cut(1,2)
	delta_time_list += (last_fire_end - last_fire_start)
	var/new_time = 0
	for(var/time in delta_time_list)
		new_time += time
	var/avg = max((new_time >> RECOIL_DTIME_SHIFT), wait) // bit shift is faster than division i think
	delta_time = round(avg / wait, 0.5)

/datum/controller/subsystem/recoil/proc/generate_recoil_datum()
	var/datum/gun_recoil/gun_recoil = new /datum/gun_recoil(RECOIL_LIST_DEFAULT)
	LAZYSET(gun_recoils, gun_recoil.index, gun_recoil)
	return LAZYACCESS(gun_recoils, gun_recoil.index)

/datum/controller/subsystem/recoil/proc/get_output_offset(spread, mob/living/shotter, obj/item/gun/shoot)
	spread += get_offset(shotter, FALSE, TRUE)
	spread = clamp(spread, 0, recoil_max_spread)
	var/mean = spread * recoil_equation_gauss_mean_mult
	var/std = spread * recoil_equation_gauss_std_mult
	var/turbofrick_unwielded_spread = FALSE
	var/turboreward_wielded_spread = FALSE
	var/pro_shooter = isatom(shotter) && HAS_TRAIT(shotter,TRAIT_NICE_SHOT)
	if(istype(shoot))
		var/datum/gun_recoil/gunshoot = get_gun_recoil_datum(shoot.recoil_tag)
		if(!pro_shooter && !shoot.wielded && gunshoot.unwielded_recoil_mod > 1 && gunshoot.scoot > 0)
			turbofrick_unwielded_spread = TRUE // hodl it right
			mean = spread
			std = spread //frick you wield it
		else if(shoot.wielded) // yay you wielded it!
			turboreward_wielded_spread = TRUE
	if(!recoil_max_spread && spread <= recoil_offset_low_spread_threshold) // low spread is tightened up a bit
		return (rand(-spread * recoil_offset_premult, spread * recoil_offset_premult) * recoil_offset_postmult)
	if(pro_shooter && !turbofrick_unwielded_spread)
		std /= 4 // lucky number 7
		mean *= 0.5
	/// turns out this proc is cheap as frick
	var/my_angle = gaussian(mean, std) * pick(1, -1)
	if(!pro_shooter && turbofrick_unwielded_spread) // and tack on some extra spread, just for good measure
		my_angle += (rand(1,15) * SIGN(my_angle))
	if(turboreward_wielded_spread) // give em a boost for wielding it
		my_angle *= recoil_wielded_reward
		my_angle -= (rand(1,my_angle) * SIGN(my_angle))
	if(istype(shotter))
		if(shotter.InCritical())
			my_angle += rand(5,10) * SIGN(my_angle)
			my_angle *= 2 // good luck! uwu
		if(HAS_TRAIT(shotter,TRAIT_NEARSIGHT)) //Yes.
			my_angle *= 2 //You're much less accurate because you can't see well - as an upside, lasers don't suffer these penalties! - jk they do
		if(HAS_TRAIT(shotter,TRAIT_POOR_AIM)) //You really shouldn't try this at home.
			my_angle *= 3 //This is cripplingly bad. Trust me.
		if(HAS_TRAIT(shotter,TRAIT_LIGHT_SENSITIVITY)) // Light hurts!
			my_angle *= 4 // Pack tactics wont save your aim here.
		if(HAS_TRAIT(shotter,TRAIT_FEV)) //You really shouldn't try this at home.
			my_angle *= 5 //YOU AINT HITTING shoot BROTHA. REALLY.
		if(HAS_TRAIT(shotter,TRAIT_PHOBIC)) // Panicking!
			my_angle *= 6 // RUN OR SHOOT?!?1
		if(istype(shotter.loc, /obj/item/clothing/head/mob_holder) && isliving(shotter.loc.loc))
			my_angle += (abs(get_offset(shotter.loc.loc, FALSE, TRUE)) * SIGN(my_angle))
			my_angle *= 1.5 // just a little bit more

	return round(clamp(my_angle, -recoil_max_spread, recoil_max_spread), 0.1)

////////////// MOB RECOIL STUFF //////////////
/datum/controller/subsystem/recoil/proc/kickback(mob/living/user, atom/my_weapon, recoil_tag = RECOIL_TAG_DEFAULT, recoil_in = 1)
	if(!user)
		return
	if(!user.ckey)
		return
	var/datum/mob_recoil/my_recoil = get_mob_recoil(user)
	if(!my_recoil)
		return FALSE
	var/recoil = recoil_in
	var/datum/gun_recoil/gun_recoil = get_gun_recoil_datum(recoil_tag)
	var/recoil_mod = gun_recoil ? gun_recoil.get_recoil_mod(user, my_weapon) : 1
	recoil *= recoil_mod
	recoil *= kick_to_recoil_mult
	my_recoil.add_shoot_recoil(user, my_weapon, recoil, TRUE)
	return TRUE

/datum/controller/subsystem/recoil/proc/get_mob_recoil(mob/living/user)
	if(!user)
		return
	if(!user.ckey)
		return
	var/datum/mob_recoil/my_recoil = LAZYACCESS(mob_recoils, user.ckey)
	if(!my_recoil)
		grant_mob_recoil(user)
	return LAZYACCESS(mob_recoils, user.ckey)

/datum/controller/subsystem/recoil/proc/grant_mob_recoil(mob/living/user)
	var/datum/mob_recoil/my_recoil = new /datum/mob_recoil(user)
	LAZYSET(mob_recoils, user.ckey, my_recoil)
	return my_recoil

/datum/controller/subsystem/recoil/proc/get_offset(mob/living/user, rounded, allow_negatives = FALSE)
	var/datum/mob_recoil/my_recoil = get_mob_recoil(user)
	return my_recoil?.get_offset(rounded, rounded, allow_negatives)

/datum/controller/subsystem/recoil/proc/incur_movement_recoil(mob/living/user)
	var/datum/mob_recoil/my_recoil = get_mob_recoil(user)
	if(!my_recoil)
		return
	my_recoil.add_movement_recoil(user)

////////////// GUN RECOIL DATUM STUFF //////////////
/datum/controller/subsystem/recoil/proc/give_recoil_tag(list/recoil_args = RECOIL_LIST_DEFAULT)
	var/datum/gun_recoil/gun_recoil = get_gun_recoil_datum(RECOIL_LIST2TAG(recoil_args))
	return gun_recoil.index

/datum/controller/subsystem/recoil/proc/get_gun_recoil_datum(recoil_tag = RECOIL_TAG_DEFAULT)
	if(istype(recoil_tag, /obj/item/gun))
		var/obj/item/gun/my_gun = recoil_tag
		recoil_tag = my_gun?.recoil_tag
	if(IS_RECOIL_LIST(recoil_tag))
		recoil_tag = RECOIL_LIST2TAG(recoil_tag)
	if(!IS_RECOIL_TAG(recoil_tag))
		recoil_tag = RECOIL_ARGS2TAG(1,1,1,1)
	var/datum/gun_recoil/gun_recoil = LAZYACCESS(gun_recoils, recoil_tag)
	if(!gun_recoil)
		gun_recoil = create_gun_recoil(recoil_tag)
	recoil_tag = gun_recoil.index
	return LAZYACCESS(gun_recoils, recoil_tag)

/datum/controller/subsystem/recoil/proc/create_gun_recoil(list/recoil_list = RECOIL_LIST_DEFAULT)
	if(IS_RECOIL_TAG(recoil_list))
		recoil_list = RECOIL_TAG2LIST(recoil_list)
	var/unwielded = LAZYACCESS(recoil_list, RECOIL_INDEX_UNWIELDED) ? text2num(LAZYACCESS(recoil_list, RECOIL_INDEX_UNWIELDED)) : 1
	var/wielded = LAZYACCESS(recoil_list, RECOIL_INDEX_WIELDED) ? text2num(LAZYACCESS(recoil_list, RECOIL_INDEX_WIELDED)) : 1
	var/scoot = LAZYACCESS(recoil_list, RECOIL_INDEX_SCOOT) ? text2num(LAZYACCESS(recoil_list, RECOIL_INDEX_SCOOT)) : 1
	var/spray = LAZYACCESS(recoil_list, RECOIL_INDEX_SPRAY) ? text2num(LAZYACCESS(recoil_list, RECOIL_INDEX_SPRAY)) : 1
	var/datum/gun_recoil/gun_recoil = LAZYACCESS(gun_recoils, RECOIL_ARGS2TAG(unwielded, wielded, scoot, spray))
	if(!istype(gun_recoil))
		gun_recoil = new /datum/gun_recoil(text2num(unwielded), text2num(wielded), text2num(scoot), text2num(spray))
	LAZYSET(gun_recoils, gun_recoil.index, gun_recoil)
	return gun_recoil

/datum/controller/subsystem/recoil/proc/modify_gun_recoil(recoil_tag = RECOIL_TAG_DEFAULT, list/modifiers = RECOIL_LIST_DEFAULT)
	if(!recoil_tag)
		return give_recoil_tag()
	if(LAZYLEN(modifiers) != 2)
		modifiers = RECOIL_LIST_DEFAULT
	var/list/item_recoil_args = RECOIL_TAG2LIST(recoil_tag)
	if(!IS_RECOIL_LIST(item_recoil_args)) // "UNWIELD" "WIELD"
		item_recoil_args = RECOIL_LIST_DEFAULT
	var/my_one_handed_recoil = text2num(item_recoil_args[RECOIL_INDEX_UNWIELDED])
	var/my_two_handed_recoil = text2num(item_recoil_args[RECOIL_INDEX_WIELDED])
	var/my_scoot = text2num(item_recoil_args[RECOIL_INDEX_SCOOT])
	var/my_spray = text2num(item_recoil_args[RECOIL_INDEX_SPRAY])
	var/mod_one_handed_mult = isnum(modifiers[RECOIL_INDEX_UNWIELDED]) ? modifiers[RECOIL_INDEX_UNWIELDED] : text2num(modifiers[RECOIL_INDEX_UNWIELDED])
	var/mod_two_handed_mult = isnum(modifiers[RECOIL_INDEX_WIELDED]) ? modifiers[RECOIL_INDEX_WIELDED] : text2num(modifiers[RECOIL_INDEX_WIELDED])
	var/new_one_handed_recoil = round((my_one_handed_recoil * mod_one_handed_mult), 0.01)
	var/new_two_handed_recoil = round((my_two_handed_recoil * mod_two_handed_mult), 0.01)
	var/list/output_list = list(new_one_handed_recoil, new_two_handed_recoil, my_scoot, my_spray)
	return give_recoil_tag(output_list)

/datum/controller/subsystem/recoil/proc/get_recoil_examine(recoil_tag = RECOIL_TAG_DEFAULT)
	var/datum/gun_recoil/gun_recoil = get_gun_recoil_datum(recoil_tag)
	return gun_recoil.get_recoil_examine()

/datum/controller/subsystem/recoil/proc/get_tgui_data(recoil_tag = RECOIL_TAG_DEFAULT)
	var/datum/gun_recoil/recoil = get_gun_recoil_datum(recoil_tag)
	return (recoil?.tgui_recoil_data()) || list("recoil_unwielded" = 1, "recoil_wielded" = 1, "recoil_scoot" = 1, "recoil_spray" = 1, "recoil_should_wield" = FALSE)

/// DATUMIZED RECOIL SYSTEM (for items)
/// Gun recoil is a glorified recoil modifier, really.
/// Lets guns modify how much recoil ammo gives the player
/// Todo: rate it allows recoil to recover
/// Todo: weapons that give a massive recoil penalty if used standing up or moving
/datum/gun_recoil
	var/index
	/// How much the gun amplifies recoil when unwielded
	var/unwielded_recoil_mod = 1
	/// How much the gun amplifies recoil when wielded
	var/wielded_recoil_mod = 1
	/// Should the gun be wielded? If not, the gun'll complain at you
	var/should_be_wielded = TRUE
	/// How the gun handles moving and shooting
	var/scoot = FALSE
	/// How the gun handles spraying and shooting
	var/spray = FALSE
	/// list of ckeys we complained at and when we complained at them
	/// Format: list("ckey" = time, ...)
	var/list/complained_at_them = list()

/datum/gun_recoil/New(unwielded_recoil_mod, wielded_recoil_mod, scootable, sprayable)
	src.unwielded_recoil_mod = text2num(unwielded_recoil_mod)
	src.wielded_recoil_mod = text2num(wielded_recoil_mod)
	src.scoot = text2num(scootable)
	src.spray = text2num(sprayable)
	should_be_wielded = should_it_be_wielded()
	index = "[unwielded_recoil_mod]%[wielded_recoil_mod]%[scootable]%[sprayable]"

/datum/gun_recoil/proc/should_it_be_wielded()
	return (wielded_recoil_mod > (unwielded_recoil_mod))

/datum/gun_recoil/proc/get_recoil_mod(mob/living/user, obj/item/held)
	if(!user || !held)
		return 1 // Not TRUE cus this isnt a boolean
	if(!user.client)
		return 1
	if(held.wielded)
		return wielded_recoil_mod
	complain(user, held)
	return unwielded_recoil_mod

/datum/gun_recoil/proc/get_scoot()
	return scoot

/datum/gun_recoil/proc/get_spray()
	return spray

/datum/gun_recoil/proc/complain(mob/living/user, obj/item/held)
	if(!should_be_wielded)
		return
	if(!user || !held)
		return
	if(!user.client || !user.ckey)
		return
	if(held.wielded)
		return
	var/complained_at_them_then = LAZYACCESS(complained_at_them, user.ckey)
	if(complained_at_them_then + GUN_HOLD_IT_RIGHT_MESSAGE_ANTISPAM_TIME > world.time)
		return
	LAZYSET(complained_at_them, user.ckey, world.time)
	to_chat(user, span_warning("[held] kicks around in your meager grip!"))

/datum/gun_recoil/proc/get_recoil_examine()
	. = list()
	var/one_handed_recoil = round((unwielded_recoil_mod * 100), 0.01)
	var/two_handed_recoil = round((wielded_recoil_mod * 100), 0.01)
	if(one_handed_recoil == two_handed_recoil)
		. += span_notice("It'll kick the same no matter how you hold it.")
	else
		var/one_h_more = (one_handed_recoil > two_handed_recoil) ? span_alert("more") : span_green("less")
		. += span_notice("It'll kick [one_h_more] when held one-handed.")
	if(scoot > 1)
		. += span_alert("It'll kick more when moving.")
	else if(scoot < 1 && scoot > 0)
		. += span_notice("It'll kick less when moving.")
	else if(scoot == 0)
		. += span_notice("Movement doesn't affect aim.")
	else
		. += span_notice("Movement improves aim.")

/datum/gun_recoil/proc/tgui_recoil_data()
	return list(
		"recoil_unwielded" = round(unwielded_recoil_mod, 0.1),
		"recoil_wielded" = round(wielded_recoil_mod, 0.1),
		"recoil_scoot" = round(scoot, 0.1),
		"recoil_spray" = round(spray, 0.1),
		"recoil_should_wield" = should_be_wielded)

/// DATUMIZED RECOIL SYSTEM
/// Just a datum with a number innit, really.
/datum/mob_recoil
	/// the ckey of the user experiencing recoil
	var/ckey
	/// the mob experiencing recoil
	/// The thing that did recoil last
	var/datum/weakref/user
	/// the amount of shootment recoil the user has
	var/shoot_recoil = 0
	/// The amount of *movement* recoil the user has
	var/movement_recoil = 0
	var/ticks_per_second
	var/shots_did_this_tick = 0
	var/list/firing_rate_to_average[1 << RECOIL_MOB_SHIFT]
	// /// roughly 1 second
	// COOLDOWN_DECLARE(average_shots_per_second)
	/// last time recoil was added
	COOLDOWN_DECLARE(last_shoot_time)
	/// Prevents movement recoil from being added if you just scooched a little bit
	COOLDOWN_DECLARE(last_movement_time)
	/// Number of tiles you can move without incurring movement recoil
	var/scooches_left = 0
	var/debug_mode = FALSE

/datum/mob_recoil/New(ckey)
	src.ckey = ckey
	var/client/maybeclient = LAZYACCESS(GLOB.directory, ckey)
	if(maybeclient?.mob)
		user = WEAKREF(maybeclient.mob)

/datum/mob_recoil/proc/add_shoot_recoil(mob/living/shooter, obj/item/gun/my_gun, recoil_buildup)
	if(isliving(shooter))
		if(!shooter.ckey)
			return
		user = WEAKREF(shooter) // update our mob ref
	COOLDOWN_START(src, last_shoot_time, SSrecoil.recoil_post_shoot_fast_decay_delay)
	var/recoil_before = shoot_recoil
	shots_did_this_tick++
	var/mult = get_shoot_recoil_mult(shooter, my_gun)
	var/modify_by_this_much = round(recoil_buildup * mult * SSrecoil.recoil_shoot_increase_multiplier, 0.1)
	shoot_recoil = clamp(shoot_recoil + modify_by_this_much, 0, SSrecoil.recoil_max_shoot)
	update_mob(shooter)
	if(debug_mode)
		to_chat(shooter, "Added shoot [recoil_buildup] * [mult] * [SSrecoil.recoil_shoot_increase_multiplier] = [modify_by_this_much]. Recoil: [recoil_before] -> [shoot_recoil]")
	return TRUE

/datum/mob_recoil/proc/get_shoot_recoil_mult(mob/living/shooter, obj/item/gun/my_gun)
	var/mult = 1
	if(!isliving(shooter))
		return mult
	if(HAS_TRAIT(shooter,TRAIT_PANICKED_ATTACKER))
		return 100 // lol
	if(HAS_TRAIT(shooter, SPREAD_CONTROL))
		mult *= 0.75 // Spread control! used by power armor
	return mult

/datum/mob_recoil/proc/get_scoot_factor()
	/// If they're just scooching, then they are not scoot n shooting
	if(!is_on_the_move(FALSE))
		return SCOOT_FACTOR(1)
	var/mob/living/scooter = GET_WEAKREF(user)
	if(!isliving(scooter))
		return SCOOT_FACTOR(1)
	var/obj/item/gun/scootgun = scooter.get_active_held_item()
	if(!istype(scootgun))
		return SCOOT_FACTOR(1)
	var/datum/gun_recoil/recoilgun = SSrecoil.get_gun_recoil_datum(scootgun.recoil_tag)
	if(!recoilgun)
		return SCOOT_FACTOR(1)
	/// okay we've confirmed they have been moving and have a gun that has a recoil datum, lets get the scoot factor
	var/scoot_factor = recoilgun.get_scoot() // that was easy
	if(!scootgun.wielded && !HAS_TRAIT(scooter, TRAIT_NICE_SHOT)) // Gotta wield it! Unless you're a pro
		scoot_factor = abs(scoot_factor) // wield it!
	return scoot_factor

/datum/mob_recoil/proc/get_spray_factor()
	var/mob/living/sprayer = GET_WEAKREF(user)
	if(!isliving(sprayer))
		return SPRAY_FACTOR(1)
	var/obj/item/gun/spraygun = sprayer.get_active_held_item() || sprayer.get_inactive_held_item()
	if(!spraygun || !istype(spraygun))
		return SPRAY_FACTOR(1)
	var/datum/gun_recoil/recoilgun = SSrecoil.get_gun_recoil_datum(spraygun.recoil_tag)
	if(!recoilgun)
		return SPRAY_FACTOR(1)
	/// okay we've confirmed they have been moving and have a gun that has a recoil datum, lets get the scoot factor
	var/spray_factor = recoilgun.get_scoot() // that was easy
	var/list/shoot_stats = get_shots_per_second()
	if(LAZYACCESS(shoot_stats, 2) > SPRAY_SHOTS_PER_SECOND_THRESHOLD)
		var/spray_mult = ((LAZYACCESS(shoot_stats, 2) / SPRAY_SHOTS_PER_SECOND_THRESHOLD) * spray_factor)
		if(debug_mode)
			to_chat(sprayer, "Spray factor increased by [spray_mult] due to [LAZYACCESS(shoot_stats, 2)] shots per second. Fired [LAZYACCESS(shoot_stats, 1)] shots in [SSrecoil.wait << RECOIL_MOB_SHIFT] seconds.")
		return spray_mult
	return SPRAY_FACTOR(1)

/datum/mob_recoil/proc/get_shots_per_second()
	var/shots_did = 0
	for(var/spt in firing_rate_to_average)
		shots_did += spt
	var/shots_per_second = (shots_did / (1 << RECOIL_MOB_SHIFT)) / SSrecoil.wait
	return list(shots_per_second, shots_did)

/datum/mob_recoil/proc/get_shoot_recoil(mob/living/shooter)
	if(!isliving(shooter))
		return 0
	var/recout = min(shoot_recoil, SSrecoil.recoil_max_shoot)
	return recout

/datum/mob_recoil/proc/get_movement_recoil(mob/living/shooter, hide_it)
	if(hide_it)
		return 0
	if(!isliving(shooter))
		return 0
	return clamp(round(movement_recoil), SSrecoil.recoil_min_movement, SSrecoil.recoil_max_movement)

/datum/mob_recoil/proc/get_offset(rounded, hide_crud, allow_negatives = TRUE)
	var/mob/living/shooter = GET_WEAKREF(user)
	var/shootcoil = get_shoot_recoil(shooter)
	var/movecoil = get_movement_recoil(shooter, hide_crud)
	var/out = shootcoil + movecoil
	/// TO DO: Make the spray factor a function of the gun's spray factor
	out *= SSrecoil.recoil_to_spread_mult
	if(rounded)
		out = round(out, 1)
	out = clamp(out, -SSrecoil.recoil_max_spread * allow_negatives, SSrecoil.recoil_max_spread)
	return out

/datum/mob_recoil/proc/tick_recoil(amount, ticklength, deltatime)
	. = reduce_recoil(amount, ticklength, deltatime)
	if(.)
		tick_shots()
	update_mob()

/datum/mob_recoil/proc/tick_shots()
	firing_rate_to_average.Cut(1,2)
	firing_rate_to_average += shots_did_this_tick
	shots_did_this_tick = 0
	if(!debug_mode)
		return
	if(world.time % 2 SECONDS)
		return
	var/mob/living/tickie = GET_WEAKREF(user)
	if(!isliving(tickie))
		return
	var/list/shootverage = get_shots_per_second()
	var/average_shoots = LAZYACCESS(shootverage, 1)
	var/total_shoots = LAZYACCESS(shootverage, 2)
	if(total_shoots > 0)
		to_chat(tickie, "Average shots per second: [average_shoots] over [SSrecoil.wait << RECOIL_MOB_SHIFT] seconds. Total shots: [total_shoots].")

/datum/mob_recoil/proc/reduce_recoil(amount, ticklength, deltatime)
	if(shoot_recoil == 0 && movement_recoil == 0)
		return FALSE
	. = 0
	var/mob/living/shooter = GET_WEAKREF(user)
	var/base_reduction = RECOIL_REDUCTION_TICK2SECOND(amount, ticklength, deltatime)
	if(reduce_movement_recoil(base_reduction, shooter))
		. |= RECOIL_MOVED
	if(reduce_shoot_recoil(base_reduction, shooter))
		. |= RECOIL_SHOT

/datum/mob_recoil/proc/reduce_movement_recoil(base_reduction, mob/living/shooter)
	if(!SSrecoil.use_movement_recoil)
		movement_recoil = 0
		return
	var/movement_recoil_before = movement_recoil
	var/recoil_exponent = SSrecoil.recoil_reduction_exponent_per_tick
	var/movement_sign = SIGN(movement_recoil)
	var/movement_out = movement_recoil_before * movement_sign // ensures positivity
	var/done_moving = !is_on_the_move(FALSE)
	if(done_moving)
		movement_out = movement_out ** recoil_exponent
	movement_out -= base_reduction
	movement_out = round(movement_out, 0.1)
	movement_out = max(movement_out, 0)
	movement_out *= movement_sign // restores possible negativity
	movement_recoil = clamp(movement_out, SSrecoil.recoil_min_movement, SSrecoil.recoil_max_movement)
	if(debug_mode && shooter)
		to_chat(shooter, "Reduced movement recoil from [movement_recoil_before] to [movement_recoil]. Was not moving: [done_moving]")
	return movement_recoil > 0

/datum/mob_recoil/proc/reduce_shoot_recoil(base_reduction, mob/living/shooter)
	if(!SSrecoil.use_shoot_recoil)
		shoot_recoil = 0
		return
	var/shoot_recoil_before = round(shoot_recoil, 0.1)
	var/done_shooting = COOLDOWN_FINISHED(src, last_shoot_time)
	var/recoil_exponent = SSrecoil.recoil_reduction_exponent_per_tick
	if(done_shooting)
		shoot_recoil = shoot_recoil ** recoil_exponent
	shoot_recoil -= base_reduction
	shoot_recoil = round(shoot_recoil, 0.1)
	shoot_recoil = clamp(shoot_recoil, 0, SSrecoil.recoil_max_shoot)
	if(debug_mode && shooter)
		to_chat(shooter, "Reduced shoot recoil from [shoot_recoil_before] to [shoot_recoil]. Was not shooting: [done_shooting].")
	return shoot_recoil > 0

/datum/mob_recoil/proc/update_mob(mob/living/updateme)
	if(isliving(updateme))
		user = WEAKREF(updateme)
	var/mob/living/shooter = GET_WEAKREF(user)
	if(!isliving(shooter))
		return
	if(!shooter.client)
		return
	var/obj/item/gun/G = shooter.get_active_held_item()
	if(istype(G))
		G.check_safety_cursor(shooter)
		return
	shooter.remove_cursor()

/datum/mob_recoil/proc/is_on_the_move(tick_scooch = TRUE)
	/// first check if we moved before the cooldown finished
	var/mob/living/walker = GET_WEAKREF(user)
	if(HAS_TRAIT(walker, TRAIT_NICE_SHOT))
		return TRUE // scooches actually work against SMGs when you're a pro
	var/stood_still = COOLDOWN_FINISHED(src, last_movement_time)
	COOLDOWN_START(src, last_movement_time, SSrecoil.recoil_scooch_time)
	if(scooches_left > 0)
		if(tick_scooch)
			scooches_left--
		if(debug_mode)
			to_chat(walker, "Still scooching. [scooches_left] tile(s) remaining. Not adding recoil.")
		return FALSE
	if(stood_still && !scooches_left) // If we stood still and we're out of scooches, we're not moving
		if(tick_scooch)
			scooches_left = SSrecoil.scooch_distance
		if(debug_mode)
			to_chat(walker, "Scooched. Not adding recoil. [scooches_left] tile(s) remaining.")
		return FALSE
	return TRUE

/datum/mob_recoil/proc/add_movement_recoil(mob/living/walker)
	if(!SSrecoil.use_movement_recoil)
		movement_recoil = 0
		return
	if(isliving(walker))
		user = WEAKREF(walker)
	if(!isliving(walker))
		walker = GET_WEAKREF(user)
	if(!isliving(walker))
		return
	if(!is_on_the_move())
		return
	var/scoot_factor = get_scoot_factor()
	if(scoot_factor == 0)
		return // ez
	var/base_recoil = 1
	/// The lower your move delay (the faster you move), the more recoil you get.
	var/movement_speed_recoil = get_movement_speed_recoil(walker)
	var/movement_gun_recoil = get_movement_gun_recoil(walker, scoot_factor)
	var/movement_stiffness_recoil = 0 // stiffness suxness //get_movement_stiffness_recoil(walker)
	var/output_recoil = movement_speed_recoil + movement_gun_recoil + movement_stiffness_recoil
	output_recoil *= scoot_factor
	output_recoil *= SSrecoil.recoil_movement_increase_multiplier
	movement_recoil += round(output_recoil, 0.05)
	update_mob(walker)
	if(debug_mode)
		to_chat(walker, "Adding [base_recoil] move, \
				[movement_speed_recoil] speed, \
				[movement_gun_recoil] gun, \
				[movement_stiffness_recoil] stiffness recoil. \
				scoot factor = [scoot_factor]. \
				Total recoil: [output_recoil]. \
				Total movement recoil: [movement_recoil].")
	return TRUE

/datum/mob_recoil/proc/get_movement_speed_recoil(mob/living/walker)
	if(!isliving(walker))
		return 0
	if(walker.last_move_delay > SSrecoil.recoil_movement_slowest_speed)
		return 0
	var/move_penalty = SSrecoil.recoil_movement_slowest_speed - walker.last_move_delay
	move_penalty *= SSrecoil.recoil_movement_speed_mult
	return max(move_penalty, 0)

/datum/mob_recoil/proc/get_movement_gun_recoil(mob/living/walker, scoot_factor = 1)
	if(!isliving(walker))
		return 0
	var/obj/item/gun/G = walker.get_active_held_item()
	if(!istype(G))
		return 0
	if(scoot_factor > 0 && G.wielded)
		return 0 // wielding it with both hands keeps it steady! unless its an SMG
	var/heaviness = G.slowdown
	if(scoot_factor > 0) // negative scoot factor means its improving your aim
		if(HAS_TRAIT(walker, TRAIT_NICE_SHOT))
			return 0 // Nice shot! more like steady aim
		heaviness *= scoot_factor * SSrecoil.recoil_movement_heaviness_mult
	else if(scoot_factor < 0)
		heaviness *= scoot_factor * SSrecoil.recoil_movement_heaviness_scoot_bonus_mult
	return heaviness

/datum/mob_recoil/proc/get_movement_stiffness_recoil(mob/living/walker)
	if(!isliving(walker))
		return 0
	var/total_stffness = 0
	var/num_stiff = 0
	for(var/obj/item/maybeworn in walker.contents)
		var/stif = maybeworn.stiffness
		if(!stif)
			continue
		total_stffness += stif
		num_stiff++
	var/stiffness_recoil = 0
	if(num_stiff >= 1 && total_stffness >= 1)
		stiffness_recoil = (total_stffness / num_stiff)
	return stiffness_recoil

/obj/item/storage/debug/debug_gun_sack
	name = "Bag of Debug Gun Mods"
	desc = "A cool bag of upgrades and guns for devs to test weapon mods, recoil, etc!"

/obj/item/storage/debug/debug_gun_sack/PopulateContents()
	. = ..()
	new /obj/item/storage/debug_box/guns_ballistic_1(src)
	new /obj/item/storage/debug_box/ammo_ballistic_1(src)
	new /obj/item/storage/debug_box/guns_energy_1(src)
	new /obj/item/storage/debug_box/ammo_energy_1(src)
	new /obj/item/storage/debug_box/tools(src)

/obj/item/storage/debug_box/guns_ballistic_1
	name = "Debug Guns"
	desc = "A box of debug guns for devs to test weapon mods, recoil, etc!"

/obj/item/storage/debug_box/guns_ballistic_1/PopulateContents()
	. = ..()
	var/list/spawned = list()
	spawned += new /obj/item/gun/ballistic/automatic/smg/american180(src)
	spawned += new /obj/item/gun/ballistic/automatic/assault_rifle(src)
	spawned += new /obj/item/gun/ballistic/automatic/shotgun/pancor(src)
	spawned += new /obj/item/gun/ballistic/automatic/pistol/beretta(src)
	spawned += new /obj/item/gun/ballistic/automatic/smg/mini_uzi(src)
	spawned += new /obj/item/gun/ballistic/automatic/smg/p90(src)
	spawned += new /obj/item/gun/ballistic/automatic/famas(src)
	spawned += new /obj/item/gun/ballistic/automatic/sportcarbine(src)
	spawned += new /obj/item/gun/ballistic/automatic/delisle(src)
	for(var/obj/item/thingy in spawned)
		SEND_SIGNAL(thingy, COMSIG_GUN_MAG_ADMIN_RELOAD)

/obj/item/storage/debug_box/ammo_ballistic_1
	name = "Debug Ammo"
	desc = "A box of debug ammo for devs to test weapon mods, recoil, etc!"

/obj/item/storage/debug_box/ammo_ballistic_1/PopulateContents()
	. = ..()
	var/list/spawned = list()
	spawned += new /obj/item/ammo_box/magazine/m22smg(src)
	spawned += new /obj/item/ammo_box/magazine/m22smg(src)
	spawned += new /obj/item/ammo_box/magazine/m556/rifle/extended(src)
	spawned += new /obj/item/ammo_box/magazine/m556/rifle/extended(src)
	spawned += new /obj/item/ammo_box/magazine/m556/rifle/extended/hobo(src)
	spawned += new /obj/item/ammo_box/magazine/m556/rifle/extended/hobo(src)
	spawned += new /obj/item/ammo_box/magazine/d12g/buck(src)
	spawned += new /obj/item/ammo_box/magazine/d12g/buck(src)
	spawned += new /obj/item/ammo_box/magazine/d12g/buck(src)
	spawned += new /obj/item/ammo_box/magazine/d12g/buck(src)
	spawned += new /obj/item/ammo_box/magazine/m10mm_p90(src)
	spawned += new /obj/item/ammo_box/magazine/m10mm_p90(src)
	spawned += new /obj/item/ammo_box/magazine/m10mm_p90(src)
	spawned += new /obj/item/ammo_box/magazine/m10mm_p90(src)
	spawned += new /obj/item/ammo_box/magazine/uzim9mm(src)
	spawned += new /obj/item/ammo_box/magazine/uzim9mm(src)
	spawned += new /obj/item/ammo_box/magazine/uzim9mm(src)
	spawned += new /obj/item/ammo_box/magazine/uzim9mm(src)
	for(var/obj/item/thingy in spawned)
		SEND_SIGNAL(thingy, COMSIG_GUN_MAG_ADMIN_RELOAD)

/obj/item/storage/debug_box/guns_energy_1
	name = "Debug Energy Guns"
	desc = "A box of debug energy guns for devs to test weapon mods, recoil, etc!"

/obj/item/storage/debug_box/guns_energy_1/PopulateContents()
	. = ..()
	new /obj/item/gun/energy/laser/wattz2k(src)
	new /obj/item/gun/energy/laser/wattz2ks(src)
	new /obj/item/gun/energy/laser/aer9(src)
	new /obj/item/gun/energy/laser/aer9(src)
	new /obj/item/gun/energy/laser/wattz(src)
	new /obj/item/gun/energy/laser/wattz(src)
	new /obj/item/gun/energy/laser/wattzs(src)
	new /obj/item/gun/energy/laser/pistol(src)
	new /obj/item/gun/energy/laser/pistol(src)
	new /obj/item/gun/energy/laser/wattz/magneto(src)
	new /obj/item/gun/energy/laser/wattz/magneto(src)
	new /obj/item/gun/energy/laser/auto(src)
	new /obj/item/gun/energy/laser/auto(src)
	new /obj/item/gun/energy/laser/auto/oasis(src)
	new /obj/item/gun/energy/laser/auto/oasis(src)
	new /obj/item/gun/energy/laser/rcw(src)

/obj/item/storage/debug_box/ammo_energy_1
	name = "Debug Energy Ammo"
	desc = "A box of debug energy ammo for devs to test weapon mods, recoil, etc!"

/obj/item/storage/debug_box/ammo_energy_1/PopulateContents()
	. = ..()
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)

/obj/item/storage/debug_box/tools
	name = "Debug Tools"
	desc = "A box of debug tools for devs to test stuff!"

/obj/item/storage/debug_box/tools/PopulateContents()
	. = ..()
	new /obj/item/screwdriver/power(src)
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/advanced(src)
	new /obj/item/weldingtool/advanced(src)
	new /obj/item/multitool/advanced(src)
	new /obj/item/multitool/advanced(src)
	new /obj/item/stack/cable_coil/thirty(src)
	new /obj/item/stack/cable_coil/thirty(src)

#undef RECOIL_MOVED
#undef RECOIL_SHOT








// /datum/controller/subsystem/recoil/proc/generate_recoil_equation()
// 	recoil_equation = list()
// 	if(recoil_equation_frick_it_just_gauss_it)
// 		possibly_the_worst_implementation_of_gaussian_distribution_known_to_furries()
// 		return
// 	for(var/offset in 1 to MAX_ACCURACY_OFFSET)
// 		var/list/fricksmall_list_of_numbers = list()
// 		for(var/i in 1 to offset)
// 			var/random_ass_angle = (offset + 1) - i
// 			random_ass_angle -= recoil_equation_subtract
// 			random_ass_angle *= recoil_equation_multiply
// 			random_ass_angle = random_ass_angle ** recoil_equation_exponent
// 			fricksmall_list_of_numbers += random_ass_angle
// 			fricksmall_list_of_numbers += -random_ass_angle
// 		recoil_equation += fricksmall_list_of_numbers

// /// Generates a frickton of numbers through gaussian distribution, truncates the result to, oh, a decimal, and arranges them in a list
// /// Then, stuffs them into a list to be used as a weighted probability bullshoot. Numbers above the list will be clamped to the list of the list
// /datum/controller/subsystem/recoil/proc/possibly_the_worst_implementation_of_gaussian_distribution_known_to_furries()
// 	var/time_now = world.time
// 	message_admins("Running an expensive gaussian distribution proc, like, a million times.")
// 	recoil_equation = list()
// 	recoil_equation.len = MAX_ACCURACY_OFFSET
// 	for(var/offset in 1 to MAX_ACCURACY_OFFSET)
// 		var/list/frickhuge_list_of_numbers = list()
// 		for(var/i in 1 to (2000)) // lol
// 			var/randum_number = gaussian(offset * recoil_equation_gauss_mean_mult, offset * recoil_equation_gauss_std_mult)
// 			frickhuge_list_of_numbers += randum_number
// 			frickhuge_list_of_numbers += -randum_number
// 		recoil_equation[offset] = frickhuge_list_of_numbers
// 	message_admins("That fricking proc took [(world.time - time_now)*0.1] seconds.") // wow it only took 0.3 seconds, I am legit impresed byond



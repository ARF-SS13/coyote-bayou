// A subsystem? For recoil? In MY BYOND? It'datum/mob_recoils more likely than you think.
#define RECOIL_DTIME_SHIFT 4
/// Arg definitions:
/// gun_recoil = the gun_recoil datum that is being used
/// recoil_tag = tag relating to the gun recoil
/// recoil_list = 2-item list of the recoil_tag that can be converted to a tag
/// recoil_in = the base amount of recoil to be processed
/// my_recoil = the mob_recoil datum that is being processed
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
	/// The last sixteen times the recoil system was processed, in deciseconds, for making a rolling average for delta-time shenanigoates
	var/list/delta_time_list = list()
	/// The time it took to tick the last process
	var/last_fire_start = 0
	/// The time it took to tick the last process
	var/last_fire_end = 0
	/// Delta Time -- compensates for lag
	var/delta_time = 1

	/// Item recoil datums (cus I am tired of them just floating around in the 'nowhere')
	/// Define how much recoil an item gives when fired, in various ways.
	/// Format: list("tag" = /datum/recoil, ...)
	var/list/gun_recoils = list()

	var/debug_recoil = FALSE

/datum/controller/subsystem/recoil/stat_entry(msg)
	var/time_taken = last_fire_end - last_fire_start
	msg = "R:[last_recoil_count]/[LAZYLEN(mob_recoils)]-T:[time_taken]ds"
	return ..()

/datum/controller/subsystem/recoil/Initialize(start_timeofday)
	if(!generate_recoil_datum()) // generate a recoil datum we can rely on always being there for us
		message_admins("Recoil system failed to initialize! Shit's broken!")
	for(var/i in 1 to (1 << RECOIL_DTIME_SHIFT))
		delta_time_list += wait
	. = ..()

/datum/controller/subsystem/recoil/fire(resumed)
	if(!resumed)
		last_fire_start = world.timeofday
		current_mob_recoils = mob_recoils.Copy()
		last_recoil_count = 0
	//cache for sanic speed (lists are references anyways)
	/// yeah this is copied from processing.dm
	var/list/recoil_list = current_mob_recoils
	while(LAZYLEN(recoil_list))
		var/ckey = LAZYACCESS(recoil_list, LAZYLEN(recoil_list))
		var/datum/mob_recoil/my_recoil = LAZYACCESS(recoil_list, ckey)
		recoil_list.len--
		if(my_recoil.tick_recoil(wait, delta_time))
			last_recoil_count++
		if (MC_TICK_CHECK)
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
	my_recoil.add_recoil(user, my_weapon, recoil)
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

/datum/controller/subsystem/recoil/proc/get_offset(mob/living/user, rounded)
	var/datum/mob_recoil/my_recoil = get_mob_recoil(user)
	return max(my_recoil?.get_offset(rounded), 0)

/datum/controller/subsystem/recoil/proc/movement_recoil(mob/living/user)
	var/datum/mob_recoil/my_recoil = get_mob_recoil(user)
	if(!my_recoil)
		return
	my_recoil.movement_recoil(user)

////////////// GUN RECOIL DATUM STUFF //////////////
/datum/controller/subsystem/recoil/proc/give_recoil_tag(list/recoil_args = RECOIL_LIST_DEFAULT)
	var/datum/gun_recoil/gun_recoil = get_gun_recoil_datum(RECOIL_LIST2TAG(recoil_args))
	return gun_recoil.index

/datum/controller/subsystem/recoil/proc/get_gun_recoil_datum(recoil_tag = RECOIL_TAG_DEFAULT)
	if(IS_RECOIL_LIST(recoil_tag))
		recoil_tag = RECOIL_LIST2TAG(recoil_tag)
	if(!IS_RECOIL_TAG(recoil_tag))
		recoil_tag = RECOIL_ARGS2TAG(1,1)
	var/datum/gun_recoil/gun_recoil = LAZYACCESS(gun_recoils, recoil_tag)
	if(!gun_recoil)
		gun_recoil = create_gun_recoil(recoil_tag)
	recoil_tag = gun_recoil.index
	return LAZYACCESS(gun_recoils, recoil_tag)

/datum/controller/subsystem/recoil/proc/create_gun_recoil(list/recoil_list = RECOIL_LIST_DEFAULT)
	if(IS_RECOIL_TAG(recoil_list))
		recoil_list = RECOIL_TAG2LIST(recoil_list)
	var/unwielded = LAZYACCESS(recoil_list, 1) ? text2num(LAZYACCESS(recoil_list, 1)) : 1
	var/wielded = LAZYACCESS(recoil_list, 2) ? text2num(LAZYACCESS(recoil_list, 2)) : 1
	var/datum/gun_recoil/gun_recoil = LAZYACCESS(gun_recoils, RECOIL_ARGS2TAG(unwielded, wielded))
	if(!istype(gun_recoil))
		gun_recoil = new /datum/gun_recoil(text2num(unwielded), text2num(wielded))
	LAZYSET(gun_recoils, gun_recoil.index, gun_recoil)
	return gun_recoil

/datum/controller/subsystem/recoil/proc/modify_gun_recoil(recoil_tag = RECOIL_TAG_DEFAULT, list/modifiers = RECOIL_LIST_DEFAULT)
	if(!recoil_tag || LAZYLEN(modifiers) != 2)
		return give_recoil_tag()
	var/list/item_recoil_args = RECOIL_TAG2LIST(recoil_tag)
	if(LAZYLEN(item_recoil_args) != 2) // "UNWIELD" "WIELD"
		return give_recoil_tag()
	for(var/index in modifiers)
		item_recoil_args[index] = text2num(item_recoil_args[index])
		item_recoil_args[index] = round((item_recoil_args[index] * modifiers[index]), 0.05)
	return give_recoil_tag(item_recoil_args)

/datum/controller/subsystem/recoil/proc/get_recoil_examine(recoil_tag = RECOIL_TAG_DEFAULT)
	var/datum/gun_recoil/gun_recoil = get_gun_recoil_datum(recoil_tag)
	return gun_recoil.get_recoil_examine()

/datum/controller/subsystem/recoil/proc/get_tgui_data(recoil_tag = RECOIL_TAG_DEFAULT)
	var/datum/gun_recoil/recoil = get_gun_recoil_datum(recoil_tag)
	return (recoil?.tgui_recoil_data()) || list("recoil_unwielded" = 1, "recoil_wielded" = 1, "recoil_should_wield" = FALSE)











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
	/// list of ckeys we complained at and when we complained at them
	/// Format: list("ckey" = time, ...)
	var/list/complained_at_them = list()

/datum/gun_recoil/New(unwielded_recoil_mod, wielded_recoil_mod)
	src.unwielded_recoil_mod = text2num(unwielded_recoil_mod)
	src.wielded_recoil_mod = text2num(wielded_recoil_mod)
	should_be_wielded = should_it_be_wielded()
	index = "[unwielded_recoil_mod]%[wielded_recoil_mod]"

/datum/gun_recoil/proc/should_it_be_wielded()
	return (unwielded_recoil_mod > wielded_recoil_mod)

/datum/gun_recoil/proc/get_recoil_mod(mob/living/user, obj/item/held)
	if(!user || !held)
		return 1 // Not TRUE cus this isnt a boolean
	if(!user.client)
		return 1
	if(held.wielded)
		return wielded_recoil_mod
	complain(user, held)
	return unwielded_recoil_mod

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
	to_chat(user, span_warning("[src] kicks around in your meager grip!"))

/datum/gun_recoil/proc/get_recoil_examine()
	. = list()
	switch(wielded_recoil_mod)
		if(-INFINITY to 0.5)
			. += span_warning("It'll kick much less when wielded.")
		if(0.5 to 1)
			. += span_warning("It'll kick less when wielded.")
		if(1 to 1.5)
			. += span_warning("It'll kick more when wielded.")
		if(1.5 to INFINITY)
			. += span_warning("It'll kick much more when wielded.")
	switch(unwielded_recoil_mod)
		if(-INFINITY to 0.5)
			. += span_warning("It'll kick much less in one hand.")
		if(0.5 to 1)
			. += span_warning("It'll kick less in one hand.")
		if(1 to 1.5)
			. += span_warning("It'll kick more in one hand.")
		if(1.5 to INFINITY)
			. += span_warning("It'll kick much more in one hand.")

/datum/gun_recoil/proc/tgui_recoil_data()
	return list("recoil_unwielded" = unwielded_recoil_mod, "recoil_wielded" = wielded_recoil_mod, "recoil_should_wield" = should_be_wielded)

/// DATUMIZED RECOIL SYSTEM
/// Just a datum with a number innit, really.
/datum/mob_recoil
	/// the ckey of the user experiencing recoil
	var/ckey
	/// the mob experiencing recoil
	var/datum/weakref/user
	/// The thing that did recoil last
	/// the amount of recoil the user has
	var/recoil = 0
	/// last time recoil was added
	COOLDOWN_DECLARE(last_recoil_time)
	/// Prevents movement recoil from being added if you just scooched a little bit
	COOLDOWN_DECLARE(last_movement_time)
	var/debug_mode = FALSE

/datum/mob_recoil/New(ckey)
	src.ckey = ckey
	var/client/maybeclient = LAZYACCESS(GLOB.directory, ckey)
	if(maybeclient?.mob)
		user = WEAKREF(maybeclient.mob)

/datum/mob_recoil/proc/add_recoil(mob/living/shooter, obj/item/gun/my_gun, recoil_buildup)
	if(isliving(shooter))
		if(!shooter.ckey)
			return
		user = WEAKREF(shooter) // update our mob ref
	var/recoil_before = recoil
	var/mult = get_recoil_mods(shooter, my_gun)
	recoil += recoil_buildup * mult
	update_mob(shooter)
	if(debug_mode)
		to_chat(shooter, "Added [recoil_buildup] * [mult] = [recoil] Recoil: [recoil_before] -> [recoil]")
	return TRUE

/datum/mob_recoil/proc/get_recoil_mods(mob/living/shooter, obj/item/gun/my_gun)
	var/mult = 1
	if(isliving(shooter))
		if(HAS_TRAIT(shooter, SPREAD_CONTROL))
			mult *= 0.5
	return mult

/datum/mob_recoil/proc/get_offset(rounded)
	var/out = recoil
	if(rounded)
		out = round(RECOIL_SPREAD_CALC(out))
	out = CLAMP(out, 0, MAX_ACCURACY_OFFSET)
	return out

/datum/mob_recoil/proc/tick_recoil(ticklength, deltatime)
	var/mob/living/shooter = GET_WEAKREF(user)
	if(!shooter)
		return FALSE
	. = reduce_recoil(ticklength, deltatime)
	update_mob(shooter)

/datum/mob_recoil/proc/reduce_recoil(ticklength, deltatime, mob/living/shooter)
	if(recoil <= 0)
		recoil = 0
		return FALSE
	var/recoil_before = recoil
	. = TRUE
	var/reduction = RECOIL_REDUCTION_TICK2SECOND(ticklength, deltatime)
	if(isliving(shooter))
		if(HAS_TRAIT(shooter, SPREAD_CONTROL))
			reduction *= 2
	recoil -= reduction
	recoil *= 0.9
	if(recoil < 0)
		recoil = 0
	if(debug_mode)
		to_chat(shooter, "Reduced recoil from [recoil_before] to [recoil].")

/datum/mob_recoil/proc/update_mob(mob/living/shooter)
	if(!isliving(shooter))
		shooter = GET_WEAKREF(user)
		if(!shooter)
			return
	var/obj/item/gun/G = shooter.get_active_held_item()
	if(istype(G))
		G.check_safety_cursor(shooter)
		return
	shooter.remove_cursor()

/datum/mob_recoil/proc/movement_recoil()
	var/mob/living/walker = GET_WEAKREF(user)
	if(!isliving(walker))
		return
	var/scooch_check = COOLDOWN_FINISHED(src, last_movement_time) // Little scooches wont incur recoil
	COOLDOWN_START(src, last_movement_time, RECOIL_MOVEMENT_GRACE) // but if you keep moving, you'll get recoil
	if(scooch_check)
		if(debug_mode)
			to_chat(walker, "Scooched. Not adding recoil.")
		return
	var/base_recoil = 1
	/// The lower your move delay (the faster you move), the more recoil you get.
	var/move_recoil = max(2 - walker.last_move_delay, 0)
	var/gun_heaviness_recoil = 0
	var/obj/item/gun/G = walker.get_active_held_item()
	if(istype(G) && !G.wielded)
		/// Heavier guns add more recoil, if not wielded with both hands.
		gun_heaviness_recoil = max(G.slowdown - GUN_SLOWDOWN_PISTOL_MEDIUM, 0)
	var/highest_stiffness = 0
	var/total_stffness = 0
	var/num_stiff = 0
	for(var/obj/item/maybeworn in walker.contents)
		var/stif = maybeworn.stiffness
		if(!stif)
			continue
		if(stif > highest_stiffness)
			highest_stiffness = stif
		total_stffness += stif
		num_stiff++
	var/stiffness_recoil = 0
	if(num_stiff >= 1 && total_stffness >= 1)
		stiffness_recoil = ((total_stffness + highest_stiffness) / num_stiff)
	base_recoil += move_recoil + stiffness_recoil + gun_heaviness_recoil
	if(debug_mode)
		to_chat(walker, "Adding [base_recoil] movement recoil.")
		to_chat(walker, "Move recoil: [move_recoil] max(2 - [walker.last_move_delay]). Stiffness: [total_stffness] + [highest_stiffness] / [num_stiff]. Gun heaviness: [gun_heaviness_recoil] max([G?.slowdown] - 0.10).")
	add_recoil(walker, null, base_recoil)

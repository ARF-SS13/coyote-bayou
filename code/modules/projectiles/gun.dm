/// Format: list("/obj/item/gun/thegun" = list("/obj/item/projectile/bullet", "/obj/item/projectile/bullet2", ...))
GLOBAL_LIST_EMPTY(gun2projectile)
/// Format: list("/obj/item/projectile/bullet/9mm" = list(fuckhuge statblock)
GLOBAL_LIST_EMPTY(casing2stats)

/*
IN THIS DOCUMENT: Universal Gun system rules/keywords. Universal gun template and procs/vars.

ATTACHMENTS

	BURST CAM
	burst_size + 1
	spread + 5 (recoil)
	burst_shot_delay + 0.5 (recoil managment)

	RECOIL COMPENSATOR
	spread above 10 = -4 spread
	spread under 10 = -2 spread

	AUTO SEAR
	Enables fire select automatic
	burst_size + 1
	recoil = +0.1
	spread + 6 (to bring it into the automatic template range)
*/

/obj/item/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "detective"
	inhand_icon_state = "gun"
	flags_1 =  CONDUCT_1
	slot_flags = null
	custom_materials = list(/datum/material/iron=2000)
	w_class = null
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = null
	item_flags = NEEDS_PERMIT | SLOWS_WHILE_IN_HAND
	attack_verb = list("struck", "hit", "bashed")
	hud_actions = list()
	var/weapon_class = null //assigns w_class, slot_flags, draw_time, slowdown, and force, based on a template
	var/fire_sound = "gunshot"
	/// Time it takes between drawing the gun and shooting the gun
	var/draw_time = null

	var/clumsy_check = TRUE
	var/obj/item/ammo_casing/chambered = null
	trigger_guard = TRIGGER_GUARD_NORMAL	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	var/sawn_desc = null				//description change if weapon is sawn-off
	var/sawn_off = FALSE

	slowdown = null

	var/damage_multiplier = 1 //Multiplies damage of projectiles fired from this gun
	var/penetration_multiplier = 1 //Multiplies armor penetration of projectiles fired from this gun

	/// can we be put into a turret
	var/can_turret = TRUE
	/// can we be put in a circuit
	var/can_circuit = TRUE
	/// can we be put in an emitter
	var/can_emitter = TRUE

	/// the following is controlled almost entirely by the firemode, changing it here wouldnt do anything meaningful
	/// Weapon is burst fire if this is above 1
	var/burst_size = 1
	/// The time between shots in burst.
	var/burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	/// The time between firing actions, this means between bursts if this is burst weapon. The reason this is 0 is because you are still, by default, limited by clickdelay.
	var/fire_delay = GUN_FIRE_DELAY_NORMAL
	/// Time between individual shots when firing full-auto.
	var/autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	var/automatic = 0 // Does the gun fire when the clicker's held down?

	/// Last world.time this was fired
	var/last_fire = 0
	/// Currently firing, whether or not it's a burst or not.
	var/firing = FALSE
	/// Used when its busy
	var/busy_action = FALSE
	/// used for inaccuracy and wielding requirements/penalties
	var/weapon_weight = GUN_ONE_HAND_AKIMBO
	/// Adds this speed to the bullet, in pixels per second
	var/extra_speed = 0

	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

	var/obj/item/firing_pin/pin = /obj/item/firing_pin //standard firing pin for most guns
	var/no_pin_required = FALSE //whether the gun can be fired without a pin

	var/can_flashlight = FALSE //if a flashlight can be added or removed if it already has one.
	var/obj/item/flashlight/seclite/gun_light
	var/datum/action/item_action/toggle_gunlight/alight
	var/gunlight_state = "flight"

	var/can_bayonet = FALSE
	var/obj/item/melee/onehanded/knife/bayonet/bayonet
	var/mutable_appearance/knife_overlay
	var/bayonet_state = "bayonetstraight"

	var/can_paint = TRUE

	var/can_scope = FALSE
	var/mutable_appearance/scope_overlay
	var/scope_state = "scope"

	var/mutable_appearance/flashlight_overlay

	var/can_suppress = FALSE
	var/mutable_appearance/suppressor_overlay
	var/suppressor_state = null

	var/ammo_x_offset = 0 //used for positioning ammo count overlay on sprite
	var/ammo_y_offset = 0
	var/flight_x_offset = 0
	var/flight_y_offset = 0
	var/knife_x_offset = 0
	var/knife_y_offset = 0
	var/scope_x_offset = 0
	var/scope_y_offset = 0
	var/suppressor_x_offset = 0
	var/suppressor_y_offset = 0

	equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'

	//Zooming
	var/zoomable = FALSE //whether the gun generates a Zoom action on creation
	var/zoomed = FALSE //Zoom toggle
	var/zoom_amt = 3 //Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_out_amt = 0

	var/worn_out = FALSE	//If true adds overlay with suffix _worn, and a slight malus to stats
	var/dryfire_sound = "gun_dry_fire"
	var/dryfire_text = ""

	/// Time that much pass between cocking your gun, if it supports it
	var/cock_delay = GUN_COCK_SHOTGUN_BASE //haha cock

	/// Gun's inherent inaccuracy, basically the minimum spread
	var/added_spread = GUN_SPREAD_NONE
	/// The tag pointing to the appropriate recoil datum in SSrecoil. Automatically generated~
	var/recoil_tag
	/// List of args to be fed into SSrecoil to generate the appropriate recoil tag
	var/list/init_recoil = list(1,1) // For updating weapon mods
	var/braced = FALSE
	var/braceable = 1 //can the gun be used for gun_brace proc, modifies recoil. If the gun has foregrip mod installed, it's not braceable. Bipod mod increases value by 1.

	var/safety = FALSE
	var/restrict_safety = FALSE //To restrict the users ability to toggle the safety

	var/sel_mode = 1 //index of the currently selected mode
	var/list/firemodes = list()
	var/list/init_firemodes = list(/datum/firemode/semi_auto)

	var/list/gun_tags = list() //Attributes of the gun, used to see if an upgrade can be applied to this weapon.
	var/gilded = FALSE
	/*	SILENCER HANDLING */
	var/silenced = FALSE
	var/fire_sound_silenced = 'modular_coyote/eris/sound/Gunshot_silenced.ogg' //Firing sound used when silenced
	var/zoom_factor = 0 //How much to scope in when using weapons
	var/rigged = FALSE
	var/vision_flags = 0
	var/projectile_speed_multiplier = 1
	/// How should this gun prefer to weight what limbs they hit
	var/gun_accuracy_zone_type = ZONE_WEIGHT_SEMI_AUTO
	/// What kind of traits should this gun be affected by
	var/gun_skill_check
	/// What kind of temporary refire delay modifiers do we have?
	var/cooldown_delay_mods
	/// What kind of misfires can this thing do? Check out combat.dm for details
	var/list/misfire_possibilities = list()
	/// What power of cartridge does this gun prefer? Mostly used for hoboguns that explode
	var/prefered_power
	/// Does the gun use the bullet's sounds, instead of its own?
	var/use_casing_sounds
	/// Is one of Kelp's wands?
	var/is_kelpwand = FALSE
	/// Allow quickdraw (delay to draw the gun is 0s)
	var/allow_quickdraw = FALSE
	/// This variable is used by crankable laser guns {/obj/item/gun/energy/laser/cranklasergun}
	var/recharge_queued = 1
	/// Cooldown between times the gun will tell you it shot, 0.5 seconds cus its not super duper important
	COOLDOWN_DECLARE(shoot_message_antispam)

	/// Is the player currently reloading this gun?
	var/reloading = FALSE
	/// This is the base reload speed, which is modified by things like the size of the magazine in use.
	var/reloading_time = 1 SECONDS
	maptext_width = 48 //prevents ammo count from wrapping down into two lines
	maptext_x = 4
	maptext_y = 2

/obj/item/gun/Initialize()
	recoil_tag = SSrecoil.give_recoil_tag(init_recoil)
	if(!recoil_tag)
		stack_trace("[src] has no recoil tag!")
	else if(!findtext(recoil_tag, "%"))
		stack_trace("[src] has an invalid recoil tag! It is: '[recoil_tag]'")
	. = ..()
	if(no_pin_required)
		pin = null
	else if(pin)
		pin = new pin(src)
	if(gun_light)
		alight = new (src)
	if(!restrict_safety)
		var/atom/movable/screen/item_action/action = new /atom/movable/screen/item_action/top_bar/gun/safety
		action.owner = src
		hud_actions += action

	var/atom/movable/screen/item_action/action = new /atom/movable/screen/item_action/top_bar/weapon_info
	action.owner = src
	hud_actions += action
	initialize_firemodes()
	initialize_scope()
	if(LAZYLEN(firemodes))
		set_firemode(sel_mode)
	generate_guntags()

	//writes in standard values for the weapon's class, if left null
	if(islist(weapon_class))
		if(isnull(w_class))
			w_class = weapon_class["w_class"]
		if(isnull(slot_flags))
			slot_flags = weapon_class["slot_flags"]
		if(isnull(slowdown))
			slowdown = weapon_class["slowdown"]
		if(isnull(force))
			force = weapon_class["force"]
		if(isnull(draw_time))
			draw_time = weapon_class["draw_time"]

/obj/item/gun/proc/initialize_firemodes()
	QDEL_LIST(firemodes)

	///prefiltering
	for(var/i in 1 to LAZYLEN(init_firemodes))
		if(!ispath(init_firemodes[i], /datum/firemode))
			init_firemodes.Cut(i, i+1)


	if(!LAZYLEN(init_firemodes)) // Nothing passed the filter
		init_firemodes = list(/datum/firemode/semi_auto) // good enough

	for(var/i in 1 to LAZYLEN(init_firemodes))
		var/datum/firemode/FM = init_firemodes[i]
		firemodes.Add(new FM(src))
	update_firemode_hud()

/obj/item/gun/proc/update_firemode_hud() // this has never worked -- actually no it works just fine
	var/atom/movable/screen/item_action/action = locate(/atom/movable/screen/item_action/top_bar/gun/fire_mode) in hud_actions
	if(firemodes.len > 1)
		if(!action)
			action = new /atom/movable/screen/item_action/top_bar/gun/fire_mode
			action.owner = src
			hud_actions += action
	else
		qdel(action)
		hud_actions -= action

/obj/item/gun/proc/initialize_scope()
	var/atom/movable/screen/item_action/action = locate(/atom/movable/screen/item_action/top_bar/gun/scope) in hud_actions
	if(zoom_factor > 0)
		if(!action)
			action = new /atom/movable/screen/item_action/top_bar/gun/scope
			action.owner = src
			hud_actions += action
	else
		hud_actions -= action
		qdel(action)

/obj/item/gun/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_POST_ADMIN_SPAWN,PROC_REF(admin_fill_gun))
	RegisterSignal(src, COMSIG_GUN_MAG_ADMIN_RELOAD,PROC_REF(admin_fill_gun))

/obj/item/gun/proc/admin_fill_gun()
	return

/obj/item/gun/Destroy()
	if(pin)
		QDEL_NULL(pin)
	if(gun_light)
		QDEL_NULL(gun_light)
	if(bayonet)
		QDEL_NULL(bayonet)
	if(chambered)
		QDEL_NULL(chambered)
	QDEL_LIST(firemodes)
	return ..()

/obj/item/gun/handle_atom_del(atom/A)
	if(A == chambered)
		chambered = null
		update_icon()
	if(A == gun_light)
		clear_gunlight()

/obj/item/gun/CheckParts(list/parts_list)
	..()
	var/obj/item/gun/G = locate(/obj/item/gun) in contents
	if(G)
		G.forceMove(loc)
		QDEL_NULL(G.pin)
		visible_message("[G] can now fit a new pin, but the old one was destroyed in the process.", null, null, 3)
		qdel(src)

/obj/item/gun/examine(mob/user)
	. = ..()
	if(!no_pin_required)
		if(pin)
			. += "It has \a [pin] installed."
		else
			. += "It doesn't have a firing pin installed, and won't fire."
	if(gun_light)
		. += "It has \a [gun_light] [can_flashlight ? "" : "permanently "]mounted on it."
		if(can_flashlight) //if it has a light and this is false, the light is permanent.
			. += "<span class='info'>[gun_light] looks like it can be <b>unscrewed</b> from [src].</span>"
	else if(can_flashlight)
		. += "It has a mounting point for a <b>seclite</b>."
	. |= SSrecoil.get_recoil_examine(recoil_tag)

//called after the gun has successfully fired its chambered ammo.
/obj/item/gun/proc/process_chamber(mob/living/user)
	return FALSE

//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/gun/proc/can_shoot()
	return TRUE

/obj/item/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	to_chat(user, span_danger("[dryfire_text]"))
	playsound(src, dryfire_sound, 30, 1)
	update_firemode()
	update_icon()

/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0, obj/item/projectile/P, casing_sound)
	if(stam_cost && istype(user)) //CIT CHANGE - makes gun recoil cause staminaloss
		var/safe_cost = clamp(stam_cost, 0, STAMINA_NEAR_CRIT - user.getStaminaLoss())*(firing && burst_size >= 2 ? 1/burst_size : 1)
		user.adjustStaminaLossBuffered(safe_cost) //CIT CHANGE - ditto

	var/datum/ammo_sound_properties/soundies = GLOB.casing_sound_properties[casing_sound]
	if(!soundies)
		return
	var/list/shootprops = soundies.shootlist(silenced)
	if(!isnull(fire_sound))
		shootprops[CSP_INDEX_SOUND_OUT] = silenced ? fire_sound_silenced : fire_sound

	playsound(
		src,
		shootprops[CSP_INDEX_SOUND_OUT],
		shootprops[CSP_INDEX_VOLUME],
		shootprops[CSP_INDEX_VARY],
		shootprops[CSP_INDEX_DISTANCE],
		ignore_walls = shootprops[CSP_INDEX_IGNORE_WALLS],
		distant_sound = shootprops[CSP_INDEX_DISTANT_SOUND],
		distant_range = shootprops[CSP_INDEX_DISTANT_RANGE]
		)
//	if(!silenced && message && COOLDOWN_FINISHED(src, shoot_message_antispam))
//		COOLDOWN_START(src, shoot_message_antispam, GUN_SHOOT_MESSAGE_ANTISPAM_TIME)
//		if(pointblank)
//			user.visible_message(span_danger("[user] fires [src] point blank at [pbtarget]!"), null, null, COMBAT_MESSAGE_RANGE)
//		else
//			user.visible_message(span_danger("[user] fires [src]!"), null, null, COMBAT_MESSAGE_RANGE)
	SSrecoil.kickback(user, src, recoil_tag, P?.recoil)

//Adds logging to the attack log whenever anyone draws a gun, adds a pause after drawing a gun before you can do anything based on it's size
/obj/item/gun/pickup(mob/living/user)
	. = ..()
	weapondraw(src, user)

/obj/item/gun/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		for(var/obj/O in contents)
			O.emp_act(severity)
	update_icon()

/obj/item/gun/attack(mob/living/M, mob/user)
	if(bayonet && user.a_intent == INTENT_HARM)
		M.attackby(bayonet, user) // handles cooldown
		return
	. = ..()
	if(!(. & DISCARD_LAST_ACTION))
		user.DelayNextAction(attack_speed)
	update_icon()

/obj/item/gun/attack_obj(obj/O, mob/user)
	if(bayonet && user.a_intent == INTENT_HARM) // Must run BEFORE parent call, so we don't smack them with the gun body too.
		O.attackby(bayonet, user) // handles cooldown
		return
	. = ..()
	if(!(. & DISCARD_LAST_ACTION))
		user.DelayNextAction(attack_speed)
	update_icon()

/obj/item/gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if(!CheckAttackCooldown(user, target))
		return
	process_afterattack(target, user, flag, params)

/obj/item/gun/proc/process_afterattack(atom/target, mob/living/user, flag, params)
	if(!target)
		return
	if(firing)
		return
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.a_intent == INTENT_HARM) //melee attack
			return
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH && (user.a_intent != INTENT_DISARM)) //so we can't shoot ourselves (unless mouth selected or disarm intent)
			return
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			for(var/i in C.all_wounds)
				var/datum/wound/W = i
				if(W.try_treating(src, user))
					return // another coward cured!
	if(user && user.incapacitated(allow_crit = TRUE))
		to_chat(user, span_danger("You're too messed up to shoot [src]!"))
		return

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	//Exclude lasertag guns from the TRAIT_CLUMSY check.
	if(clumsy_check)
		if(istype(user))
			if (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
				to_chat(user, span_userdanger("You shoot yourself in the foot with [src]!"))
				var/shot_leg = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
				process_fire(user, user, FALSE, params, shot_leg)
				user.dropItemToGround(src, TRUE)
				return

	// if(weapon_weight == GUN_TWO_HAND_ONLY && !wielded)
	// 	wield(user)
	// 	if(!wielded)
	// 		to_chat(user, span_userdanger("You need both hands free to fire \the [src]!"))
	// 		return

	if(rigged)
		user.visible_message(
			span_danger("As \the [user] pulls the trigger on \the [src], a bullet fires backwards out of it"),
			span_danger("Your \the [src] fires backwards, shooting you in the face!")
		)
		process_fire(user, user, FALSE, params, BODY_ZONE_HEAD)
		if(rigged > TRUE)
			explosion(get_turf(src),0,0,2,1)
		return

	if (automatic == 0)
		user.DelayNextAction(1)
	if (automatic == 1)
		user.DelayNextAction(fire_delay)

	//DUAL (or more!) WIELDING
	var/loop_counter = 0

	if(ishuman(user) && user.a_intent == INTENT_HARM && weapon_weight <= GUN_ONE_HAND_AKIMBO)
		var/mob/living/carbon/human/H = user
		for(var/obj/item/gun/G in H.held_items)
			if(G == src || G.weapon_weight == GUN_TWO_HAND_ONLY)
				continue
			else if(G.can_trigger_gun(user))
				loop_counter++
				var/stam_cost = G.getstamcost(user)
				addtimer(CALLBACK(G, TYPE_PROC_REF(/obj/item/gun,process_fire), target, user, TRUE, params, null, stam_cost), loop_counter)

	var/stam_cost = getstamcost(user)

	process_fire(target, user, TRUE, params, null, stam_cost)
	update_icon()


/obj/item/gun/can_trigger_gun(mob/living/user)
	. = ..()
	if(!.)
		return
	if(!handle_pins(user))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && chambered?.harmful) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
		to_chat(user, span_notice(" [src] is lethally chambered! You don't want to risk harming anyone..."))
		return FALSE

/obj/item/gun/CanItemAutoclick(object, location, params) // fuck you why wasnt this here to begin with
	if(automatic)
		. = get_clickcd()

/obj/item/gun/CheckAttackCooldown(mob/user, atom/target)
	if(user.Adjacent(target)) //melee
		return user.CheckActionCooldown(CLICK_CD_MELEE)
	return user.CheckActionCooldown(get_clickcd())

/obj/item/gun/proc/get_clickcd()
	if (automatic == 0)
		return 1
		//return isnull(chambered?.click_cooldown_override)? get_fire_delay(user) : chambered.click_cooldown_override
	if (automatic == 1)
		return isnull(chambered?.click_cooldown_override)? fire_delay : chambered.click_cooldown_override

/obj/item/gun/GetEstimatedAttackSpeed(mob/user)
	return get_clickcd()

/obj/item/gun/proc/handle_pins(mob/living/user)
	if(no_pin_required)
		return TRUE
	if(pin)
		if(pin.pin_auth(user) || (pin.obj_flags & EMAGGED))
			return TRUE
		else
			pin.auth_fail(user)
			return FALSE
	else
		to_chat(user, span_warning("[src]'s trigger is locked. This weapon doesn't have a firing pin installed!"))
	return FALSE

/obj/item/gun/proc/recharge_newshot()
	return

/obj/item/gun/proc/on_cooldown(mob/user)
	if (automatic == 0)
		return reloading || busy_action || firing || ((last_fire + get_fire_delay(user)) > world.time)
	if (automatic == 1)
		return reloading || busy_action || firing

/*
 * So here is the list of proc calls that happen when you fire a gun:
 * You click on something with a gun in your hand
 * The game calls ClickOn() on the gun
 * ClickOn() calls the gun's afterattack() proc
 * afterattack() first checks if the gun is on cooldown, if it is, it returns
 * afterattack() then checks if the gun is empty, if it is, it calls shoot_with_empty_chamber()
 * afterattack() then calls process_fire() on the gun with the target as an argument
 * process_fire() first checks if the gun is on cooldown, if it is, it returns
 * process_fire() then checks if the gun is on safety, if it is, it calls shoot_with_empty_chamber()
 * process_fire() then sets the gun's firing variable to TRUE
 * process_fire() then calls do_fire() on the gun with the target as an argument
 * do_fire() first tries to misfire the gun, if possible. Doesnt really change anything whether it does or not
 * do_fire() then checks if the gun has a chambered round, if it doesnt, it calls shoot_with_empty_chamber()
 * do_fire() then gets the user's recoil amount and adds it to the gun's spread
 * do_fire() then calls chambered's fire_casing() proc with a bunch of args
 * If fire_casing fails, shoot_with_empty_chamber() is called
 * Otherwise, call shoot_live_shot() with the same args
 * If the gun has burst mode, and hasn't fired all of its shots, sleep for the burst delay right now
 * Then call process_chamber() on the gun with the user as an argument
 * Congratulation, you just shot someone probably
 * Then we return to process_fire()
 * process_fire() then sets the gun's firing variable to FALSE
 * process_fire() then sets the gun's last_fire variable to the current world time
 * (last_fire is used to check if the gun is on cooldown, comparing it to the current world time)
 * THen we return to afterattack()
 * Then what happens next is up to the wierdass attack chain system that i barely understand
 * (props to github's copilot for more or less writing this comment)
 */

/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", stam_cost = 0)
	add_fingerprint(user)

	if(on_cooldown(user))
		return
	clear_cooldown_mods()

	if(is_kelpwand)
		if(isliving(user))
			if(type == /obj/item/gun/magic/wand/kelpmagic/magicmissile)
				if(HAS_TRAIT(user, TRAIT_MARTIAL_A))
					to_chat(user, span_danger("You don't know how to use magic wands!"))
					return
			else
				if(HAS_TRAIT(user, TRAIT_MARTIAL_A) || !HAS_TRAIT(user, TRAIT_WAND_PROFICIENT))
					to_chat(user, span_danger("You don't know how to use magic wands!"))
					return

	if(safety)
		to_chat(user, span_danger("The gun's safety is on!"))
		shoot_with_empty_chamber(user)
		return
	var/time_till_draw = user.AmountWeaponDrawDelay()
	if(time_till_draw)
		to_chat(user, span_notice("You're still drawing your [src]! It'll take another <u>[time_till_draw*0.1] seconds</u> until it's ready!"))
		return
	if(pre_fire(user, target, params, zone_override, stam_cost))
		return TRUE // pre_fire will handle what comes next~ (like firing at your mouse cursor after a delay)
	firing = TRUE
	. = do_fire(target, user, message, params, zone_override, stam_cost)
	firing = FALSE
	last_fire = world.time

	if(user)
		user.update_inv_hands()
		SEND_SIGNAL(user, COMSIG_LIVING_GUN_PROCESS_FIRE, target, params, zone_override, stam_cost)

/obj/item/gun/proc/pre_fire(mob/user, atom/target, params, zone_override, stam_cost, message = TRUE)
	return FALSE

/obj/item/gun/proc/do_fire(atom/target, mob/living/user, message = TRUE, params, zone_override = "", stam_cost = 0)
	/// recoil is read before a burst, so all subsequent shots in a burst will have the same recoil
	/// This is the mob shooting's aggregate recoil
	var/sprd = SSrecoil.get_offset(user) /// its still *added* with each shot, so the next burst will be higher
	for(var/i in 1 to burst_size)
		misfire_act(user)
		if(chambered)
			LAZYOR(GLOB.gun2projectile["[type]"], "[chambered.type]")
			before_firing(target,user)
			var/BB = chambered.BB
			var/casing_sound = chambered.sound_properties
			if(!chambered.fire_casing(target, user, params, added_spread, silenced, zone_override, sprd, damage_multiplier, penetration_multiplier, projectile_speed_multiplier, src))
				shoot_with_empty_chamber(user)
				update_icon()
				return
			else
				if(get_dist((user || get_turf(src)), target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, 1, target, message, stam_cost, BB, casing_sound)
				else
					shoot_live_shot(user, 0, target, message, stam_cost, BB, casing_sound)
				user?.in_crit_HP_penalty = 25
		else
			shoot_with_empty_chamber(user)
			update_icon()
			return
		if(i < burst_size)
			sleep(burst_shot_delay)
		process_chamber(user)
		update_icon()
	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE

/obj/item/gun/attackby(obj/item/I, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()

	if(istype(I, /obj/item/flashlight/seclite))
		if(!can_flashlight)
			return ..()
		var/obj/item/flashlight/seclite/S = I
		if(!gun_light)
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, span_notice("You click [S] into place on [src]."))
			set_gun_light(S)
			update_gunlight()
			alight = new(src)
			if(loc == user)
				alight.Grant(user)
		return

	if(istype(I, /obj/item/melee/onehanded/knife/bayonet))
		var/obj/item/melee/onehanded/knife/bayonet/K = I
		if(!can_bayonet || !K.bayonet || bayonet) //ensure the gun has an attachment point available, and that the knife is compatible with it.
			return ..()
		if(!user.transferItemToLoc(I, src))
			return
		to_chat(user, span_notice("You attach \the [K] to the front of \the [src]."))
		bayonet = K
		update_icon()
		update_overlays()
		return
	return ..()


/obj/item/gun/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	if(can_flashlight && gun_light)
		I.play_tool_sound(src)
		var/obj/item/flashlight/seclite/S = gun_light
		to_chat(user, span_notice("You unscrew the seclite from \the [src]."))
		S.forceMove(get_turf(user))
		clear_gunlight()
		return TRUE

	if(can_bayonet && bayonet)
		I.play_tool_sound(src)
		to_chat(user, span_notice("You unscrew the bayonet from \the [src]."))
		var/obj/item/melee/onehanded/knife/bayonet/K = bayonet
		K.forceMove(get_turf(user))
		bayonet = null
		update_icon()
		return TRUE

/obj/item/gun/proc/clear_gunlight()
	if(!gun_light)
		return
	var/obj/item/flashlight/seclite/removed_light = gun_light
	set_gun_light(null)
	update_gunlight()
	removed_light.update_brightness()
	QDEL_NULL(alight)
	return TRUE


/**
 * Swaps the gun's seclight, dropping the old seclight if it has not been qdel'd.
 *
 * Returns the former gun_light that has now been replaced by this proc.
 * Arguments:
 * * new_light - The new light to attach to the weapon. Can be null, which will mean the old light is removed with no replacement.
 */
/obj/item/gun/proc/set_gun_light(obj/item/flashlight/seclite/new_light)
	// Doesn't look like this should ever happen? We're replacing our old light with our old light?
	if(gun_light == new_light)
		CRASH("Tried to set a new gun light when the old gun light was also the new gun light.")

	. = gun_light

	// If there's an old gun light that isn't being QDELETED, detatch and drop it to the floor.
	if(!QDELETED(gun_light))
		gun_light.set_light_flags(gun_light.light_flags & ~LIGHT_ATTACHED)
		if(gun_light.loc == src)
			gun_light.forceMove(get_turf(src))

	// If there's a new gun light to be added, attach and move it to the gun.
	if(new_light)
		new_light.set_light_flags(new_light.light_flags | LIGHT_ATTACHED)
		if(new_light.loc != src)
			new_light.forceMove(src)

	gun_light = new_light

/obj/item/gun/proc/toggle_gunlight()
	if(!gun_light)
		return

	var/mob/living/carbon/human/user = usr
	gun_light.on = !gun_light.on
	gun_light.update_brightness()
	to_chat(user, span_notice("You toggle the gunlight [gun_light.on ? "on":"off"]."))

	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_gunlight()

/obj/item/gun/proc/update_gunlight(mob/user = null)
	update_icon()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(user.get_active_held_item() != src) //we can only stay zoomed in if it's in our hands	//yeah and we only unzoom if we're actually zoomed using the gun!!
		remove_hud_actions(user)
		zoom(user, FALSE)
	if(HAS_TRAIT(user, TRAIT_WEAK_OF_MUSCLES))  //we obviously need to check if the user HAS the trait.... DUH! (thank you a lot Blue and Dan)
		if(weapon_class > WEAPON_CLASS_NORMAL)
			user.dropItemToGround(src, TRUE)
			to_chat(user, span_alert("The [src] is too heavy for you!"))

/obj/item/gun/dropped(mob/user)
	. = ..()
	if(zoomed)
		zoom(user,FALSE)
	if(alight)
		alight.Remove(user)

/obj/item/gun/update_overlays()
	. = ..()
	if(gun_light)
		var/state = "[gunlight_state][gun_light.on? "_on":""]"	//Generic state.
		if(gun_light.icon_state in icon_states('icons/fallout/objects/guns/attachments.dmi'))	//Snowflake state?
			state = gun_light.icon_state
		flashlight_overlay = mutable_appearance('icons/fallout/objects/guns/attachments.dmi', state)
		flashlight_overlay.pixel_x = flight_x_offset
		flashlight_overlay.pixel_y = flight_y_offset
		. += flashlight_overlay
	else
		flashlight_overlay = null

	if(bayonet)
		if(bayonet.icon_state in icon_states('icons/fallout/objects/guns/attachments.dmi'))		//Snowflake state?
			knife_overlay = bayonet.icon_state
		var/icon/bayonet_icons = 'icons/fallout/objects/guns/attachments.dmi'
		knife_overlay = mutable_appearance(bayonet_icons, bayonet_state)
		knife_overlay.pixel_x = knife_x_offset
		knife_overlay.pixel_y = knife_y_offset
		. += knife_overlay
	else
		knife_overlay = null
	/*
	if(scope)
		if(scope.icon_state in icon_states('icons/fallout/objects/guns/attachments.dmi'))
			scope_overlay = scope.icon_state
		var/icon/scope_icons = 'icons/fallout/objects/guns/attachments.dmi'
		scope_overlay = mutable_appearance(scope_icons, scope_state)
		scope_overlay.pixel_x = scope_x_offset
		scope_overlay.pixel_y = scope_y_offset
		. += scope_overlay
	else
		scope_overlay = null
	*/
	if(silenced)
		var/icon/suppressor_icons = 'icons/fallout/objects/guns/attachments.dmi'
		suppressor_overlay = mutable_appearance(suppressor_icons, suppressor_state)
		suppressor_overlay.pixel_x = suppressor_x_offset
		suppressor_overlay.pixel_y = suppressor_y_offset
		. += suppressor_overlay
	else
		suppressor_overlay = null

	if(worn_out)
		. += ("[initial(icon_state)]_worn")

/obj/item/gun/proc/unlock() //used in summon guns and as a convience for admins
	if(pin)
		qdel(pin)
	pin = new /obj/item/firing_pin

//Happens before the actual projectile creation
/obj/item/gun/proc/before_firing(atom/target,mob/user)
	return

/////////////
// ZOOMING //
/////////////

/obj/item/gun/proc/zoom(mob/living/user, forced_zoom)
	if(!(user?.client))
		return

	if(!isnull(forced_zoom))
		if(zoomed == forced_zoom)
			return
		zoomed = forced_zoom
	else
		zoomed = !zoomed

	if(zoomed)//if we need to be zoomed in
		user.add_movespeed_modifier(/datum/movespeed_modifier/scoped_in)
		var/_x = 0
		var/_y = 0
		switch(user.dir)
			if(NORTH)
				_y = zoom_amt
			if(EAST)
				_x = zoom_amt
			if(SOUTH)
				_y = -zoom_amt
			if(WEST)
				_x = -zoom_amt

		user.client.change_view(zoom_out_amt)
		user.client.pixel_x = world.icon_size*_x
		user.client.pixel_y = world.icon_size*_y
		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE,PROC_REF(rotate))
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED) //pls don't conflict with anything else using this signal
		user.visible_message(span_notice("[user] looks down the scope of [src]."), span_notice("You look down the scope of [src]."))
	else
		user.remove_movespeed_modifier(/datum/movespeed_modifier/scoped_in)
		user.client.change_view(CONFIG_GET(string/default_view))
		user.client.pixel_x = 0
		user.client.pixel_y = 0
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		user.visible_message(span_notice("[user] looks up from the scope of [src]."), span_notice("You look up from the scope of [src]."))
		RegisterSignal(user, COMSIG_MOVABLE_MOVED,PROC_REF(on_walk)) //Extra proc to make sure your zoom resets for bug where you don't unzoom when toggling while moving

/obj/item/gun/proc/on_walk(mob/living/user)
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	user.client.change_view(CONFIG_GET(string/default_view))
	user.client.pixel_x = 0
	user.client.pixel_y = 0

/obj/item/gun/proc/rotate(mob/living/user, old_dir, direction = FALSE)
	var/_x = 0
	var/_y = 0
	switch(direction)
		if(NORTH)
			_y = zoom_amt
		if(EAST)
			_x = zoom_amt
		if(SOUTH)
			_y = -zoom_amt
		if(WEST)
			_x = -zoom_amt
	user.client.change_view(zoom_out_amt)
	user.client.pixel_x = world.icon_size*_x
	user.client.pixel_y = world.icon_size*_y

/obj/item/gun/proc/getstamcost(mob/living/carbon/user)
	. = 0 //get_per_shot_recoil()
	if(user && !user.has_gravity())
		. *= 5

/obj/item/gun/proc/weapondraw(obj/item/gun/G, mob/living/user) // Eventually, this will be /obj/item/weapon and guns will be /obj/item/weapon/gun/etc. SOON.tm
	user.visible_message(span_danger("[user] grabs \a [G]!")) // probably could code in differences as to where you're picking it up from and so forth. later.
	var/time_till_gun_is_ready = max(draw_time,(user.AmountWeaponDrawDelay()))
	if(allow_quickdraw)
		allow_quickdraw = FALSE
		time_till_gun_is_ready = 0
	user.SetWeaponDrawDelay(time_till_gun_is_ready)
	if(safety && user.a_intent == INTENT_HARM)
		toggle_safety(user, ignore_held = TRUE)
	// TODO: Define where you're grabbing it from, assign numbers to them, and then divide the paralyze total by that. Tables/holster/belt/back/container.
	user.log_message("[user] pulled a [G]", LOG_ATTACK)
	spawn(time_till_gun_is_ready)
		if(user.get_active_held_item() == src)
			user.show_message(span_notice("\The [src] is ready to fire."))
			playsound(get_turf(user), "sound/weapons/lockedandloaded.ogg", 100, 1)


/*
/// Takes the current recoil, adds on some more recoil from the bullet and modded by the gun
/// and returns a value for its adjusted spread
/// Also clears the recoil if its been long enough
/obj/item/gun/proc/process_recoil(mob/user)
	if(world.time <= 1)
		return
	if(recoil_cooldown_schedule <= 1)
		recoil_cooldown_schedule = 1

	var/current_time = world.time
	var/current_recoil = recoil
	var/current_recoil_schedule = recoil_cooldown_schedule
	var/current_recoil_cooldown_time = recoil_cooldown_time

	if(current_time >= current_recoil_schedule) // it cooled down
		current_recoil = 0
	else if(current_recoil_cooldown_time > 0) // no zero divides plz
		current_recoil *= (current_recoil_schedule - current_time) / current_recoil_cooldown_time // Partial recoil cooldown

	/// Calculate a new spread, basically recoil to spread, clamped
	var/new_spread = 0
	new_spread = clamp(0, GUN_RECOIL_MAX_SPREAD, current_recoil)

	/// Set a new time to clear recoil
	recoil_cooldown_schedule = world.time + recoil_cooldown_time

	/// Add on more recoil
	var/recoil_to_add = get_per_shot_recoil()

	///Check if there's something in their other hand
	if(user)
		var/obj/thing_in_their_other_hand = user.get_item_for_held_index(user.get_inactive_hand_index())
		if(istype(thing_in_their_other_hand)) // Other hand cant steady the gun?
			recoil_to_add *= GUN_FULL_OTHER_HAND_RECOIL_MOD
		if(istype(thing_in_their_other_hand, /obj/item/gun) && user.a_intent == INTENT_HARM) // Akimbo!
			recoil_to_add *= GUN_AKIMBO_RECOIL_MOD // Bit more than 2x cus that other hand isnt steadying the gun

	current_recoil += recoil_to_add
	recoil = current_recoil

	/// And shake shake shake the camera
	if(user)
		shake_camera(user, min(recoil + 1, 3), min((recoil * 0.5), 3)) // its gonna get bad
	return new_spread

/// Gets the base amount of recoil one shot would do
/obj/item/gun/proc/get_per_shot_recoil()
	. = 0
	if(chambered?.BB)
		. = chambered.BB.recoil * recoil_multiplier

/// Gets the spread this current shot should have
/// Factors in base gun spread too
/obj/item/gun/proc/get_per_shot_spread(extra_spread, mob/user)
	/// Recoil based spread
	. = round(((rand(-100,100) * 0.01) * process_recoil(user)), 0.1)
	/// Add in the gun's spread
	. += round(((rand(-100,100) * 0.01) * extra_spread), 0.1)
*/


/obj/item/gun/proc/switch_firemodes()
	if(!LAZYLEN(firemodes))
		initialize_firemodes()
	update_firemode(FALSE) //Disable the old firing mode before we switch away from it
	sel_mode++
	if(sel_mode > LAZYLEN(firemodes))
		sel_mode = 1
	return set_firemode(sel_mode)

/obj/item/gun/proc/set_firemode(index)
	if(!LAZYLEN(firemodes))
		initialize_firemodes()
	if(index > LAZYLEN(firemodes))
		index = 1
	var/datum/firemode/new_mode = firemodes[sel_mode]
	new_mode.apply_firemode()
	new_mode.update()
	update_hud_actions()
	return new_mode

/obj/item/gun/proc/toggle_firemode(mob/living/user)
	if(firing) // Prevents a bug with swapping fire mode while burst firing.
		return
	var/datum/firemode/new_mode = switch_firemodes()
	if(new_mode)
		playsound(src.loc, 'sound/weapons/selector.ogg', 100, 1)
		to_chat(user, span_notice("\The [src] is now set to [new_mode.name]."))

/obj/item/gun/proc/toggle_safety(mob/living/user, ignore_held = FALSE)
	if((restrict_safety || src != user.get_active_held_item()) && !ignore_held)
		return
	safety = !safety
	playsound(user, 'sound/weapons/selector.ogg', 50, 1)
	to_chat(user, span_notice("You toggle the safety [safety ? "on":"off"]."))
	if(!safety)
		user.visible_message(span_danger("[user] toggles the safety of [user.p_their()] \a [src] off!"))
	//Update firemode when safeties are toggled
	update_firemode()
	update_hud_actions()
	check_safety_cursor(user)

/obj/item/gun/proc/check_safety_cursor(mob/living/user)
	if(safety)
		user.remove_cursor()
	else
		user.update_cursor(src)

/obj/item/gun/proc/gun_brace(mob/living/user, atom/target)
	if(braceable && !braced)
		var/atom/original_loc = user.loc
		var/brace_direction = get_dir(user, target)
		to_chat(user, span_notice("You brace your weapon on \the [target]."))
		braced = TRUE
		while(user.loc == original_loc && user.dir == brace_direction)
			sleep(2)
		to_chat(user, span_notice("You stop bracing your weapon."))
		braced = FALSE
	else
		if(braced)
			to_chat(user, span_notice("You are already bracing your weapon!"))
		else
			to_chat(user, span_notice("You can\'t properly place your weapon on \the [target] because of the foregrip!"))

/obj/item/gun/swapped_from()
	.=..()
	update_firemode(FALSE)
	remove_hud_actions(usr)
	if(isliving(loc))
		check_safety_cursor(loc)

/obj/item/gun/swapped_to()
	.=..()
	update_firemode()
	add_hud_actions(usr)
	if(isliving(loc))
		check_safety_cursor(loc)

/obj/item/gun/ui_action_click(mob/living/user, action_name)
	switch(action_name)
		if("fire mode")
			toggle_firemode(user)
		if("scope")
			toggle_scope(user)
		if("safety")
			toggle_safety(user)
		if("Weapon Info")
			ui_interact(user)

/// Updates the ammo count number that renders on top of the icon
/obj/item/gun/proc/UpdateAmmoCountOverlay()
	return

/obj/item/gun/doMove(atom/destination)
	. = ..()
	UpdateAmmoCountOverlay()

/obj/item/gun/update_icon()
	. = ..()
	UpdateAmmoCountOverlay()

/obj/item/gun/proc/toggle_scope(mob/living/user)
	//looking through a scope limits your periphereal vision
	//still, increase the view size by a tiny amount so that sniping isn't too restricted to NSEW
	if(!zoom_factor)
		zoomed = FALSE
		return
	var/zoom_offset = round(world.view * zoom_factor)

	zoom_amt = zoom_offset
	if(zoom_factor >= 1)
		zoom_out_amt = zoom_amt + 1
	else
		zoom_out_amt = world.view

	zoom(user)

	if(safety)
		user.remove_cursor()
	else
		user.update_cursor(src)
	if(user.get_active_held_item() == src)
		update_hud_actions()

/obj/item/gun/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "WeaponInfo", "[capitalize(name)]")
		ui.open()

/obj/item/gun/ui_data(mob/user)
	var/list/data = list()
	data["gun_name"] = name || "Unknown"
	data["gun_damage_multiplier"] = damage_multiplier || 1
	data["gun_penetration_multiplier"] = penetration_multiplier || 1
	data["gun_melee"] = force_unwielded || force || 0
	data["gun_melee_wielded"] = force_wielded || round(force * FALLBACK_FORCE) || 0
	data["gun_armor_penetration"] = armour_penetration || 0
	var/list/chambered_data = istype(chambered) ? chambered.get_statblock(TRUE) : ui_data_projectile(get_dud_projectile())
	data["gun_chambered"] = chambered_data || list()
	data["gun_is_chambered"] = istype(chambered) || FALSE
	data["gun_chambered_loaded"] = chambered ? !!chambered.BB : 0
	var/list/unmodded_recoil_data = SSrecoil.get_tgui_data(init_recoil)
	var/list/modded_recoil_data = SSrecoil.get_tgui_data(recoil_tag)
	data["unmodded_recoil_wielded"] = LAZYACCESS(unmodded_recoil_data, "recoil_wielded") || 1
	data["unmodded_recoil_unwielded"] = LAZYACCESS(unmodded_recoil_data, "recoil_unwielded") || 1
	data["modded_recoil_wielded"] = LAZYACCESS(modded_recoil_data, "recoil_wielded") || 1
	data["modded_recoil_unwielded"] = LAZYACCESS(modded_recoil_data, "recoil_unwielded") || 1
	var/scoot_title = "Scoot"
	var/scoot_stats = "1"
	var/recoil_scoot = LAZYACCESS(modded_recoil_data, "recoil_scoot") || 1
	switch(recoil_scoot)
		if(0)
			scoot_title = "Unaffected by movement"
			scoot_stats = "Movement does not affect aim."
		if(1)
			scoot_title = "Affected by movement"
			scoot_stats = "Movement applies its full recoil amount."
		else
			switch(recoil_scoot)
				if(-INFINITY to 0)
					scoot_title = "Steadied by movement"
					scoot_stats = "Movement reduces overall recoil by [round(-recoil_scoot * 100, 10)]% while running."
				if(0 to 1)
					scoot_title = "Less affected by movement"
					scoot_stats = "Movement recoil is reduced by [round(1-recoil_scoot * 100, 10)]%."
				if(1 to INFINITY)
					scoot_title = "Greatly affected by movement"
					scoot_stats = "Movement recoil is increased by [round(1-recoil_scoot * 100, 10)]%. Move slowly to reduce recoil."
				else
					scoot_title = "Unknown"
					scoot_stats = "Unknown"
	data["gun_recoil_scoot_title"] = scoot_title
	data["gun_recoil_scoot_stats"] = scoot_stats
	data["gun_spread"] = added_spread || 0

	var/datum/firemode/my_firemode = LAZYACCESS(firemodes, sel_mode)
	var/action_kind = "Unknown"
	switch(my_firemode.fire_type)
		if(GUN_FIREMODE_SEMIAUTO)
			action_kind = "Single Shot"
		if(GUN_FIREMODE_BURST)
			var/burstcount = my_firemode.burst_count || "Multi" // || resolves to the first thing it resolves to
			action_kind = "[burstcount]-Round Burst"
		if(GUN_FIREMODE_AUTO)
			action_kind = "Automatic"
	data["firemode_current"] = list(
		"action_kind" = action_kind || "Single-Fire",
		"fire_rate" = "[my_firemode.get_fire_delay(TRUE)] RPM" || "Unspecified RPM",
		"desc" = "[my_firemode.desc] [my_firemode.extra_tip]" || "Some kind of firing method. Supposedly shoots.",
	)

	if(LAZYLEN(firemodes))
		var/list/firemodes_info = list()
		for(var/i = 1 to LAZYLEN(firemodes))
			data["firemode_count"] += 1
			var/datum/firemode/F = LAZYACCESS(firemodes, i)
			var/list/firemode_info = list(
				"index" = i,
				"current" = (i == sel_mode),
				"name" = F.name,
				"desc" = "[F.desc] [F.extra_tip]",
				"burst" = F.burst_count,
				"fire_rate" = F.get_fire_delay(TRUE),
				"fire_delay" = F.get_fire_delay(TRUE),
			)
			firemodes_info += list(firemode_info)
		data["firemode_info"] = firemodes_info
	else
		// stack_trace("No firemodes found for [src]!")
		// message_admins("No firemodes found for [src]!")
		data["firemode_count"] = 1
		data["firemode_info"] = list(list(
			"index" = 1,
			"current" = TRUE,
			"name" = "Single Shot",
			"desc" = "Single shot firing mode. Fires one shot at a time.",
			"burst" = 1,
			"fire_delay" = 1,
			"fire_rate" = 1,
		))

	data["attachments"] = list()
	var/attindex = 1
	for(var/atom/A in item_upgrades)
		data["attachments"] += list(list("name" = A.name, "desc" = A.desc, "attachment_index" = attindex))
		attindex += 1
	return data

/obj/item/gun/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(action == "firemode")
		var/new_firemode = params["firemode"]
		sel_mode = new_firemode
		set_firemode(sel_mode)
		playsound(src.loc, 'sound/weapons/selector.ogg', 100, 1)
		var/mob/living/carbon/human/user = usr
		var/datum/firemode/new_mode = firemodes[sel_mode]
		to_chat(user, span_notice("\The [src] is now set to [new_mode.name]."))
		. = TRUE
	if(action == "ExamineAttachment")
		var/obj/item/attachmentmaybe = LAZYACCESS(item_upgrades, params["AttachmentID"])
		if(!attachmentmaybe || !ismob(usr))
			return
		var/mob/user = usr
		user.true_examinate(attachmentmaybe, TRUE)
		. = TRUE
	update_icon()

// If the gun isnt chambered, get what the gun would normally fire if it was chambered
/obj/item/gun/proc/get_dud_projectile()
	var/list/proj
	if(istype(chambered))
		proj = LAZYACCESS(GLOB.casing2stats, "[chambered.type]")
	else if(LAZYLEN(GLOB.gun2projectile["[type]"]))
		var/myprojectile = pick(GLOB.gun2projectile["[type]"])
		proj = LAZYACCESS(GLOB.casing2stats, "[myprojectile]")
	if(!proj)
		return list()
	return proj

/obj/item/gun/proc/ui_data_projectile()
	var/list/data = get_dud_projectile()
	if(!LAZYLEN(data))
		return data
	var/dmg = data["projectile_damage"] || 0
	data["projectile_damage_total"] = dmg * damage_multiplier
	var/ap = data["projectile_armor_penetration"] || 0
	data["projectile_armor_penetration_total"] = (ap * penetration_multiplier)
	return data

//Finds the current firemode and calls update on it. This is called from a few places:
//When firemode is changed
//When safety is toggled
//When gun is picked up
//When gun is readied
/obj/item/gun/proc/update_firemode(force_state = null)
	if(!LAZYLEN(firemodes))
		initialize_firemodes()
	sel_mode = clamp(sel_mode, 1, LAZYLEN(firemodes))
	var/datum/firemode/new_mode = firemodes[sel_mode]
	new_mode.update(force_state)
	new_mode.apply_firemode()

/obj/item/gun/proc/generate_guntags()
	gun_tags |= GUN_GRIP
	if(can_scope)
		gun_tags |= GUN_SCOPE
	if(can_suppress)
		gun_tags |= GUN_SILENCABLE
	if(can_paint)
		gun_tags |= GUN_PAINTABLE
	//if(!get_sharpness())
	//	gun_tags |= SLOT_BAYONET

/obj/item/gun/refresh_upgrades()
	//First of all, lets reset any var that could possibly be altered by an upgrade
	penetration_multiplier = initial(penetration_multiplier)
	projectile_speed_multiplier = initial(projectile_speed_multiplier)
	silenced = initial(silenced)
	restrict_safety = initial(restrict_safety)
	added_spread = initial(added_spread)
	restrict_safety = initial(restrict_safety)
	rigged = initial(rigged)
	zoom_factor = initial(zoom_factor)
	vision_flags = initial(vision_flags)
	force = initial(force)
	if(isnull(force))
		force = LAZYACCESS(weapon_class, "force")
		if(isnull(force))
			force = WEAPON_FORCE_BLUNT_SMALL
	armour_penetration = initial(armour_penetration)
	sharpness = initial(sharpness)
	braced = initial(braced)
	recoil_tag = SSrecoil.give_recoil_tag(init_recoil)

	//attack_verb = list()
	//initialize_firemodes()

	//Now lets have each upgrade reapply its modifications
	SEND_SIGNAL(src, COMSIG_UPGRADE_ADDVAL, src)
	SEND_SIGNAL(src, COMSIG_UPGRADE_APPVAL, src)

	initialize_scope()
	update_firemode_hud()
	update_hud_actions()

	if(LAZYLEN(firemodes))
		set_firemode(sel_mode) // Reset the firemode so it gets the new changes

	update_icon()
	//then update any UIs with the new stats

/obj/item/gun/proc/get_zone_accuracy_type()
	if(automatic == TRUE)
		return ZONE_WEIGHT_AUTOMATIC
	if(burst_size > 1)
		return ZONE_WEIGHT_AUTOMATIC
	if(gun_accuracy_zone_type)
		return gun_accuracy_zone_type
	return ZONE_WEIGHT_SEMI_AUTO

/obj/item/gun/proc/get_fire_delay(mob/user)
	var/datum/firemode/my_mode = LAZYACCESS(firemodes, sel_mode)
	if(!my_mode)
		return fire_delay // shrug
	. = my_mode.get_fire_delay()
	if(CHECK_BITFIELD(gun_skill_check, AFFECTED_BY_FAST_PUMP) && user)
		if(HAS_TRAIT(user, TRAIT_FAST_PUMP))
			. *= GUN_RIFLEMAN_REFIRE_DELAY_MULT
	if(CHECK_BITFIELD(cooldown_delay_mods, GUN_AUTO_PUMPED) && user)
		if(!HAS_TRAIT(user, TRAIT_FAST_PUMP))
			. *= GUN_AUTOPUMP_REFIRE_DELAY_MULT

/obj/item/gun/proc/apply_cooldown_modifier(new_mod)
	ENABLE_BITFIELD(cooldown_delay_mods, new_mod)

/obj/item/gun/proc/clear_cooldown_mods()
	cooldown_delay_mods = null

/// your stupid gun shits itself
/obj/item/gun/proc/misfire_act(mob/user)
	if(!user)
		return FALSE
	if(!LAZYLEN(misfire_possibilities))
		return FALSE
	if(!islist(misfire_possibilities))
		return FALSE
	if(prefered_power <= 0)
		return FALSE
	var/misfire_mod = 1
	if(istype(chambered) && chambered.BB)
		if(chambered.fire_power <= 0)
			return FALSE
		if(chambered.fire_power <= prefered_power)
			return FALSE
		if(chambered.fire_power > prefered_power)
			misfire_mod = chambered.fire_power / prefered_power
	else
		return FALSE

	for(var/gun_jank in misfire_possibilities)
		if(!prob(misfire_mod * misfire_possibilities[gun_jank][GUN_MF_CHANCE]))
			continue
		switch(gun_jank)
			if(GUN_MF_HURTS_YOU)
				if(misfire_hurt_user(user, misfire_mod))
					. = TRUE
					break
			if(GUN_MF_DUMP)
				if(misfire_dump_ammo(user, misfire_mod))
					. = TRUE
					break
			if(GUN_MF_YEET)
				if(misfire_yeet_gun(user, misfire_mod))
					. = TRUE
					break
	if(prob(50)) // cus ur gun suxorz
		do_sparks(1, FALSE, src)
	if(.) // do MORE sparks!!
		do_sparks(3, FALSE, src)
	return TRUE

/obj/item/gun/proc/misfire_hurt_user(mob/living/user, extra_hurt)
	if(!user || !isliving(user))
		return FALSE

	var/is_pow = extra_hurt > 1.5 ? TRUE : FALSE
	extra_hurt = clamp(extra_hurt, 1, 2.5) // lets not literally kill whoever's using this thing

	var/damage_divisor = 0
	for(var/dmg in DAMAGES_LIST)
		if(CHECK_BITFIELD(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE], dmg))
			damage_divisor += 1
	hurt_the_holder(user, extra_hurt, damage_divisor)

	/// "The Shitgun misfires,"
	var/what_happen_to_you = list()
	var/what_happen_to_them = list()
	if(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & BRUTELOSS)
		if(is_pow)
			what_happen_to_you += "clobbering you into next week"
			what_happen_to_them += "clobbering [user.p_them()] into next week"
		else
			what_happen_to_you += "slamming itself into you"
			what_happen_to_them += "slamming itself into [user.p_them()]"
		playsound(src, 'sound/weapons/genhit2.ogg', 50, 1)
	if(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & FIRELOSS)
		if(is_pow)
			what_happen_to_you += "searing you well done"
			what_happen_to_them += "searing [user.p_them()] well done"
		else
			what_happen_to_you += "burning your flesh"
			what_happen_to_them += "burning [user.p_their()] flesh"
		playsound(src, 'sound/items/welder.ogg', 50, 1)
	if(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & TOXLOSS)
		if(is_pow)
			what_happen_to_you += "hosing you down with deadly grime"
			what_happen_to_them += "hosing [user.p_them()]down with deadly grimt"
		else
			what_happen_to_you += "blasting you with toxic fumes"
			what_happen_to_them += "blasting [user.p_them()] with toxic fumes"
		playsound(src, 'sound/effects/zzzt.ogg', 50, 1)
	if(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & OXYLOSS)
		what_happen_to_you += "knocking the wind out of you"
		what_happen_to_them += "knocking the wind out of [user.p_them()]"
		playsound(src, 'sound/weapons/genhit1.ogg', 50, 1)
	if(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & CLONELOSS)
		if(is_pow)
			what_happen_to_you += "shredding your genetics"
			what_happen_to_them += "shredding [user.p_their()] genetics"
		else
			what_happen_to_you += "damaging your genes"
			what_happen_to_them += "damaging [user.p_their()] genes"
		playsound(src, 'sound/weapons/ParticleBlaster.ogg', 50, 1)
	if(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & RADIATIONLOSS)
		user.rad_act(extra_hurt * rand(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_LOW], misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_HIGH]))
		if(is_pow)
			what_happen_to_you += "just about guaranteeing you'll never have kids"
			what_happen_to_them += "nuking [user.p_them()] in a sickly green glow"
		else
			what_happen_to_you += "zapping you with radiation"
			what_happen_to_them += "zapping [user.p_them()] with radiation"
		playsound(src, 'sound/weapons/resonator_blast.ogg', 50, 1)
	if(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & EMPLOSS)
		user.emp_act(extra_hurt * rand(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_LOW], misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_HIGH]))
		if(is_pow)
			what_happen_to_you += "frying the daylights out of you with EMP"
			what_happen_to_them += "frying [user.p_them()] with EMP"
		else
			what_happen_to_you += "frying you with EMP"
			what_happen_to_them += "frying [user.p_them()] with EMP"
		playsound(src, 'sound/weapons/ZapBang.ogg', 50, 1)
	var/you_are_so_lucky = span_warning("[src] misfires, [english_list(what_happen_to_you)]!")
	var/god_i_wish_i_was_them = span_alert("[user]'s [src] misfires, [english_list(what_happen_to_them)]!")
	user.visible_message(
		god_i_wish_i_was_them,
		you_are_so_lucky,
		span_alert("You hear a loud bang!")
		)
	/// Everyone gets to hear how shitty your gun is
	var/datum/ammo_sound_properties/soundies = GLOB.casing_sound_properties[chambered?.sound_properties]
	if(!soundies)
		return
	var/list/shootprops = soundies.shootlist(FALSE)
	if(!isnull(fire_sound))
		shootprops[CSP_INDEX_SOUND_OUT] = fire_sound

	playsound(
		user,
		shootprops[CSP_INDEX_SOUND_OUT],
		shootprops[CSP_INDEX_VOLUME] * extra_hurt * 2,
		shootprops[CSP_INDEX_VARY],
		shootprops[CSP_INDEX_DISTANCE] * extra_hurt * 2,
		ignore_walls = shootprops[CSP_INDEX_IGNORE_WALLS],
		distant_sound = shootprops[CSP_INDEX_DISTANT_SOUND],
		distant_range = shootprops[CSP_INDEX_DISTANT_RANGE]
		)

	return TRUE

/obj/item/gun/proc/hurt_the_holder(mob/living/user, extra_hurt, dmg_divisor)
	if(dmg_divisor <= 0)
		dmg_divisor = 1
	var/damage = rand(misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_LOW], misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_HIGH]) * extra_hurt
	var/obj/item/bodypart/affecting = user.get_bodypart(ran_zone(user.get_active_hand()))
	if(!affecting)
		affecting = user.get_bodypart(BODY_ZONE_CHEST)
	var/armor = user.run_armor_check(affecting, "melee")
	var/dt = max(user.run_armor_check(affecting, "damage_threshold"), 0)
	user.apply_damages(
		misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & BRUTELOSS ? damage / dmg_divisor : 0,
		misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & FIRELOSS ? damage / dmg_divisor : 0,
		misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & TOXLOSS ? damage / dmg_divisor : 0,
		misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & OXYLOSS ? damage / dmg_divisor : 0,
		misfire_possibilities[GUN_MF_HURTS_YOU][GUN_MF_HURTS_YOU_DAMAGE_TYPE] & CLONELOSS ? damage / dmg_divisor : 0,
		def_zone = affecting,
		blocked = armor,
		damagethreshold = dt
	)

GLOBAL_LIST_INIT(gun_yeet_words, list(
	"prefix" = list(
		"frightened",
		"zoomy",
		"excited",
		"coked-up",
		"methed-up",
		"antsy",
		"screaming",
		"whiny",
		"exploding",
		"rocket-propelled",
		"spinning"
	),
	"suffix" = list(
		"weasel",
		"cat",
		"gecko",
		"molerat",
		"catgirl",
		"eyebot",
		"rat",
		"ferret",
		"crackgoblin",
		"fox",
		"foxgirl"
	)
))

/obj/item/gun/proc/misfire_dump_ammo(mob/user, dump_harder)
	if(!user)
		return FALSE

	var/obj/item/thing_2_yeet
	/// subtypes that do everything differnt suuuuuuuck
	if(istype(src, /obj/item/gun/energy))
		var/obj/item/gun/energy/zappergun = src
		thing_2_yeet = zappergun.cell
		if(!zappergun.eject_cell(user, FALSE, FALSE))
			thing_2_yeet = null
	else if(istype(src, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/gungun = src
		thing_2_yeet = gungun.magazine
		if(!gungun.eject_magazine(user, gungun.en_bloc, FALSE, FALSE))
			thing_2_yeet = null
		//and your little chambered round as well! huahahaha!
		gungun.eject_chambered_round(user, FALSE)
	if(!thing_2_yeet)
		return FALSE
	var/falls_or_flies = "falls"
	if(prob(misfire_possibilities[GUN_MF_DUMP][GUN_MF_DUMP_THROW]))
		falls_or_flies = "flies"
		var/turf/throw_it_here = get_ranged_target_turf(get_turf(src), pick(GLOB.alldirs), rand(1,6) * dump_harder, 3 * dump_harder)
		if(!isturf(throw_it_here))
			return FALSE
		thing_2_yeet.throw_at(throw_it_here, 10 * dump_harder, rand(1,3) * dump_harder)
	user.visible_message(
		span_alert("[user]'s [thing_2_yeet] [falls_or_flies] out of [user.p_their()] [src] like \a [pick(GLOB.gun_yeet_words["prefix"])] [pick(GLOB.gun_yeet_words["suffix"])]!")
		)
	playsound(src, "sound/f13weapons/garand_ping.ogg", 70, 1)
	return TRUE

/obj/item/gun/proc/misfire_yeet_gun(mob/user, throw_harder)
	if(!user)
		return FALSE

	user.dropItemToGround(src)
	var/turf/throw_it_here = get_ranged_target_turf(get_turf(src), pick(GLOB.alldirs), rand(1,6) * throw_harder, 3 * throw_harder)
	if(!isturf(throw_it_here))
		return FALSE
	src.throw_at(throw_it_here, 10 * throw_harder, rand(1,3) * throw_harder)
	user.visible_message(
		span_alert("[user]'s [src] flies out of [user.p_their()] grip like \a [pick(GLOB.gun_yeet_words["prefix"])] [pick(GLOB.gun_yeet_words["suffix"])]!")
		)
	playsound(src, "sound/weapons/punchmiss.ogg", 100, 1)
	return TRUE

/obj/item/gun/proc/post_modify_projectile(obj/item/projectile/BB)
	return

/obj/item/storage/backpack/debug_gun_hobo
	name = "Bag of Gunstuff 4 hobos"
	desc = "Cool shit for testing various guns!"

/obj/item/storage/backpack/debug_gun_hobo/PopulateContents()
	. = ..()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/weldingtool/advanced(src)
	new /obj/item/stack/crafting/metalparts/five(src)
	new /obj/item/melee/onehanded/knife/bayonet(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/gun/ballistic/automatic/autopipe(src)
	new /obj/item/gun/ballistic/revolver/hobo/piperifle(src)
	new /obj/item/gun/ballistic/revolver/winchesterrebored(src)
	new /obj/item/gun/ballistic/automatic/hobo/zipgun(src)
	new /obj/item/ammo_box/magazine/zipgun(src)
	new /obj/item/gun/ballistic/revolver/hobo/knucklegun(src)
	new /obj/item/gun/ballistic/revolver/hobo/knifegun(src)
	new /obj/item/gun/ballistic/revolver/hobo/single_shotgun(src)
	new /obj/item/ammo_box/m5mmbox(src)
	new /obj/item/ammo_box/a308box(src)
	new /obj/item/ammo_box/a3006box(src)
	new /obj/item/ammo_box/a50MGbox(src)
	new /obj/item/ammo_box/shotgun/slug(src)
	new /obj/item/ammo_box/shotgun/buck(src)
	new /obj/item/ammo_box/shotgun/improvised(src)
	new /obj/item/ammo_box/m22(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c10mm(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m14mm(src)

/obj/item/storage/backpack/debug_gun_multical
	name = "Bag of Gunstuff"
	desc = "Cool shit for testing various guns!"

/obj/item/storage/backpack/debug_gun_multical/PopulateContents()
	. = ..()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/weldingtool/advanced(src)
	new /obj/item/melee/onehanded/knife/bayonet(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/gun/ballistic/automatic/smg/sidewinder(src)
	new /obj/item/gun/ballistic/automatic/pistol/beretta(src)
	new /obj/item/gun/ballistic/automatic/pistol/pistol14(src)
	new /obj/item/ammo_box/magazine/uzim9mm(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/ext(src)
	new /obj/item/ammo_box/magazine/m10mm/adv(src)
	new /obj/item/ammo_box/magazine/m10mm_p90(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45/socom(src)
	new /obj/item/ammo_box/magazine/tommygunm45(src)
	new /obj/item/ammo_box/magazine/tommygunm45/stick(src)
	new /obj/item/ammo_box/magazine/greasegun(src)
	new /obj/item/ammo_box/magazine/m22(src)
	new /obj/item/ammo_box/magazine/m22/extended(src)
	new /obj/item/ammo_box/magazine/m22smg(src)

/obj/item/storage/backpack/debug_gun_kit_accuracy
	name = "Bag of Gunstuff"
	desc = "Cool shit for testing various guns!"

/obj/item/storage/backpack/debug_gun_kit_accuracy/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/smg/american180(src)
	new /obj/item/ammo_box/magazine/m22smg(src)
	new /obj/item/ammo_box/magazine/m22smg(src)
	new /obj/item/ammo_box/magazine/m22smg(src)
	new /obj/item/gun/ballistic/automatic/assault_rifle(src)
	new /obj/item/ammo_box/magazine/m556/rifle/extended(src)
	new /obj/item/ammo_box/magazine/m556/rifle/extended/hobo(src)
	new /obj/item/gun/ballistic/automatic/shotgun/pancor(src)
	new /obj/item/ammo_box/magazine/d12g/buck(src)
	new /obj/item/ammo_box/magazine/d12g/buck(src)

//Reload hotkey stuff
/obj/item/gun/proc/Reload(mob/user)
	return FALSE

/mob/proc/ReloadGun()
	return FALSE

/mob/living/carbon/human/ReloadGun(throw_if_no_gun_in_active_hand)
	var/I = get_active_held_item()
	var/obj/item/gun/G
	if(istype(I, /obj/item/gun))
		G = I
	if(throw_if_no_gun_in_active_hand && isnull(G))
		src.toggle_throw_mode()
		return TRUE
	var/I2 = get_inactive_held_item()
	var/obj/item/gun/G2
	if(istype(I2, /obj/item/gun))
		G2 = I2
	if(!G && !G2)
		to_chat(src, span_warning("You aren't holding a gun you can reload!"))
		return FALSE
	G?.Reload(src)
	if(get_inactive_held_item() == G2)//recheck this again because it might have changed since we reloaded the active hand gun.
		G2?.Reload(src)
	return TRUE

///////////////////
//GUNCODE ARCHIVE//
///////////////////

/*
STICK GUN PICKUP WEIRDNESS
/obj/item/gun/ballistic/automatic/pistol/stickman/pickup(mob/living/user)
	. = ..()
	to_chat(user, span_notice("As you try to pick up [src], it slips out of your grip.."))
	if(prob(50))
		to_chat(user, span_notice("..and vanishes from your vision! Where the hell did it go?"))
		qdel(src)
		user.update_icons()
	else
		to_chat(user, span_notice("..and falls into view. Whew, that was a close one."))
		user.dropItemToGround(src)

/obj/item/gun/ballistic/automatic/pistol/deagle/update_overlays()
	. = ..()
	if(magazine)
		. += "deagle_magazine"

CITADEL MODULAR PISTOL CODE
/obj/item/gun/ballistic/automatic/pistol/modular
	name = "modular pistol"
	desc = "A small, easily concealable 10mm handgun. Has a threaded barrel for suppressors."
	icon = 'modular_citadel/icons/obj/guns/cit_guns.dmi'
	icon_state = "cde"
	can_unsuppress = TRUE
	automatic_burst_overlay = FALSE
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Default" = "cde",
						"N-99" = "n99",
						"Stealth" = "stealthpistol",
						"HKVP-78" = "vp78",
						"Luger" = "p08b",
						"Mk.58" = "secguncomp",
						"PX4 Storm" = "px4"
						)

/obj/item/gun/ballistic/automatic/pistol/modular/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/pistol/modular/update_overlays()
	. = ..()
	if(magazine && suppressed)
		. += "[unique_reskin[current_skin]]-magazine-sup"	//Yes, this means the default iconstate can't have a magazine overlay
	else if (magazine)
		. += "[unique_reskin[current_skin]]-magazine"


SOME SORT OF  BOLT ACTION CODE UNUSED
/obj/item/gun/ballistic/shotgun/boltaction/pump(mob/M)
	playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
	if(bolt_open)
		pump_reload(M)
	else
		pump_unload(M)
	bolt_open = !bolt_open
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/shotgun/boltaction/pump(mob/M)
	playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/shotgun/boltaction/attackby(obj/item/A, mob/user, params)
	if(!bolt_open)
		to_chat(user, span_notice("The bolt is closed!"))
		return
	. = ..()

/obj/item/gun/ballistic/shotgun/boltaction/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_open ? "open" : "closed"]."


CODE FOR RESKIN
	unique_reskin = list("Tactical" = "cshotgun",
						"Slick" = "cshotgun_slick"
						)


DUAL TUBE PUMP ACTION (seems redundant with neostead but why not keep it.)
/obj/item/gun/ballistic/shotgun/automatic/dual_tube/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to pump it.")

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/attack_self(mob/living/user)
	if(!chambered && magazine.contents.len)
		pump()
	else
		toggle_tube(user)

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	pump()
	return TRUE


ATTACHING SLING
/obj/item/gun/ballistic/shotgun/boltaction/improvised/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/cable_coil) && !sawn_off)
		if(A.use_tool(src, user, 0, 10, skill_gain_mult = EASY_USE_TOOL_MULT))
			slot_flags = INV_SLOTBIT_BACK
			to_chat(user, span_notice("You tie the lengths of cable to the rifle, making a sling."))
			slung = TRUE
			update_icon()
		else
			to_chat(user, span_warning("You need at least ten lengths of cable if you want to make a sling!"))

/obj/item/gun/ballistic/shotgun/boltaction/improvised/update_overlays()
	. = ..()
	if(slung)
		. += "[icon_state]sling"


HOOK GUN CODE. Bizarre but could be made into something useful.
/obj/item/gun/ballistic/shotgun/doublebarrel/hook
	name = "hook modified sawn-off shotgun"
	desc = "Range isn't an issue when you can bring your user to you."
	icon_state = "hookshotgun"
	inhand_icon_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/bounty
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = GUN_ONE_HAND_ONLY
	force = 16 //it has a hook on it
	attack_verb = list("slashed", "hooked", "stabbed")
	hitsound = 'sound/weapons/bladeslice.ogg'
	//our hook gun!
	var/obj/item/gun/magic/hook/bounty/hook
	var/toggled = FALSE

CODE FOR ASSAULT RIFE WITH GRENADE LAUNCHER ATTACHED
/obj/item/gun/ballistic/automatic/m90
	name = "\improper M-90gl Carbine"
	desc = "A three-round burst 5.56 toploading carbine, designated 'M-90gl'. Has an attached underbarrel grenade launcher which can be toggled on and off."
	icon_state = "m90"
	inhand_icon_state = "m90"
	mag_type = /obj/item/ammo_box/magazine/m556
	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel

/obj/item/gun/ballistic/automatic/m90/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher(src)
	update_icon()

/obj/item/gun/ballistic/automatic/m90/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/m90/unrestricted/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted(src)
	update_icon()

/obj/item/gun/ballistic/automatic/m90/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		. = ..()
		return
/obj/item/gun/ballistic/automatic/m90/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user, params)
	else
		..()
/obj/item/gun/ballistic/automatic/m90/update_overlays()
	. = ..()
	switch(select)
		if(0)
			. += "[initial(icon_state)]semi"
		if(1)
			. += "[initial(icon_state)]burst"
		if(2)
			. += "[initial(icon_state)]gren"

/obj/item/gun/ballistic/automatic/m90/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"

LONG SCOPE
	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 13


MAG ICON CODE
/obj/item/gun/ballistic/automatic/surplus/update_icon_state()
	if(magazine)
		icon_state = "surplus"
	else
		icon_state = "surplus-e"

SPREAD UPON BURST TOGGLE
/obj/item/gun/ballistic/automatic/wt550/enable_burst()
	. = ..()
	spread = 15

/obj/item/gun/ballistic/automatic/wt550/disable_burst()
	. = ..()
	spread = 0

ICON UPDATE FOR GRADUAL DEPLETION, PLASTIC MAGS ETC
/obj/item/gun/ballistic/automatic/c20r/update_icon_state()
	icon_state = "c20r[magazine ? "-[CEILING(get_ammo(0)/4, 1)*4]" : ""][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/wt550/update_icon_state()
	icon_state = "wt550[magazine ? "-[CEILING(((get_ammo(FALSE) / magazine.max_ammo) * 20) /4, 1)*4]" : "-0"]" //Sprites only support up to 20.
*/

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
	item_state = "gun"
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=2000)
	w_class = WEIGHT_CLASS_NORMAL
	var/icon_prefix = null
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = 5
	item_flags = NEEDS_PERMIT | SLOWS_WHILE_IN_HAND
	attack_verb = list("struck", "hit", "bashed")
	hud_actions = list()
	var/fire_sound = "gunshot"
	/// Time it takes between drawing the gun and shooting the gun
	var/draw_time = GUN_DRAW_NORMAL 

	var/clumsy_check = TRUE
	var/obj/item/ammo_casing/chambered = null
	trigger_guard = TRIGGER_GUARD_NORMAL	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	var/sawn_desc = null				//description change if weapon is sawn-off
	var/sawn_off = FALSE

	slowdown = GUN_SLOWDOWN_NONE

	var/damage_multiplier = 1 //Multiplies damage of projectiles fired from this gun
	var/penetration_multiplier = 1 //Multiplies armor penetration of projectiles fired from this gun

	/// can we be put into a turret
	var/can_turret = TRUE
	/// can we be put in a circuit
	var/can_circuit = TRUE
	/// can we be put in an emitter
	var/can_emitter = TRUE

	/// Weapon is burst fire if this is above 1
	var/burst_size = 1
	/// The time between shots in burst.
	var/burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	/// The time between firing actions, this means between bursts if this is burst weapon. The reason this is 0 is because you are still, by default, limited by clickdelay.
	var/fire_delay = GUN_FIRE_DELAY_NORMAL
	/// Time between individual shots when firing full-auto.
	var/autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	/// Last world.time this was fired
	var/last_fire = 0
	/// Currently firing, whether or not it's a burst or not.
	var/firing = FALSE
	/// Used in gun-in-mouth execution/suicide and similar, while TRUE nothing should work on this like firing or modification and so on and so forth.
	var/busy_action = FALSE
	/// used for inaccuracy and wielding requirements/penalties
	var/weapon_weight = GUN_ONE_HAND_AKIMBO
	/// Adds this speed to the bullet, in pixels per second
	var/extra_speed = 0

	var/obj/item/attachments/scope
	var/obj/item/attachments/recoil_decrease
	var/obj/item/attachments/burst_improvement
	var/obj/item/attachments/auto_sear

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

	var/can_scope = FALSE
	var/mutable_appearance/scope_overlay
	var/scope_state = "scope"

	var/can_attachments = FALSE
	var/can_automatic = FALSE
	var/mutable_appearance/flashlight_overlay

	var/can_suppress = FALSE
	var/can_unsuppress = TRUE
	var/suppressed = null					//whether or not a message is displayed when fired
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

	var/equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'

	//Zooming
	var/zoomable = FALSE //whether the gun generates a Zoom action on creation
	var/zoomed = FALSE //Zoom toggle
	var/zoom_amt = 3 //Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_out_amt = 0
	var/datum/action/item_action/toggle_scope_zoom/azoom

	var/dualwield_spread_mult = 2		//dualwield spread multiplier

	var/worn_out = FALSE	//If true adds overlay with suffix _worn, and a slight malus to stats
	var/dryfire_sound = "gun_dry_fire"
	var/dryfire_text = "*click*"

	/// Time that much pass between cocking your gun, if it supports it
	var/cock_delay = GUN_COCK_SHOTGUN_BASE

	var/automatic = 0 // Does the gun fire when the clicker's held down?

	var/init_offset = 0
	var/datum/recoil/recoil_dat // Reference to the recoil datum in datum/recoil.dm
	var/list/init_recoil = list(0, 0, 0) // For updating weapon mods
	var/braced = FALSE
	var/braceable = 1 //can the gun be used for gun_brace proc, modifies recoil. If the gun has foregrip mod installed, it's not braceable. Bipod mod increases value by 1.

	var/safety = FALSE
	var/restrict_safety = FALSE //To restrict the users ability to toggle the safety

	var/sel_mode = 1 //index of the currently selected mode
	var/list/firemodes = list()
	var/list/init_firemodes = list()

	var/list/gun_tags = list() //Attributes of the gun, used to see if an upgrade can be applied to this weapon.

/obj/item/gun/Initialize()
	if(!recoil_dat && islist(init_recoil))
		recoil_dat = getRecoil(arglist(init_recoil))
	else if(!islist(init_recoil))
		recoil_dat = getRecoil()
	. = ..()
	if(no_pin_required)
		pin = null
	else if(pin)
		pin = new pin(src)
	if(gun_light)
		alight = new (src)
	if(!restrict_safety)
		var/obj/screen/item_action/action = new /obj/screen/item_action/top_bar/gun/safety
		action.owner = src
		hud_actions += action

	var/obj/screen/item_action/action = new /obj/screen/item_action/top_bar/weapon_info
	action.owner = src
	hud_actions += action
	initialize_firemodes()
	build_zooming()
	if(firemodes.len)
		set_firemode(sel_mode)

/obj/item/gun/proc/initialize_firemodes()
	QDEL_LIST(firemodes)

	for(var/i in 1 to init_firemodes.len)
		var/list/L = init_firemodes[i]
		add_firemode(L)

	var/obj/screen/item_action/action = locate(/obj/screen/item_action/top_bar/gun/fire_mode) in hud_actions
	if(firemodes.len > 1)
		if(!action)
			action = new /obj/screen/item_action/top_bar/gun/fire_mode
			action.owner = src
			hud_actions += action
	else
		qdel(action)
		hud_actions -= action

/obj/item/gun/Destroy()
	if(pin)
		QDEL_NULL(pin)
	if(gun_light)
		QDEL_NULL(gun_light)
	if(bayonet)
		QDEL_NULL(bayonet)
	if(chambered)
		QDEL_NULL(chambered)
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
	if(recoil_dat.getRating(RECOIL_TWOHAND) > 0.4)
		. += span_warning("This gun needs to be braced against something to be used effectively.")
	else if(recoil_dat.getRating(RECOIL_ONEHAND) > 0.6)
		. += span_warning("This gun needs to be wielded in both hands to be used most effectively.")

//called after the gun has successfully fired its chambered ammo.
/obj/item/gun/proc/process_chamber(mob/living/user)
	return FALSE

/obj/item/gun/update_icon_state()
	icon_state = "[icon_prefix]"

//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/gun/proc/can_shoot()
	return TRUE

/obj/item/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	to_chat(user, "<span class='danger'>[dryfire_text]</span>")
	playsound(src, dryfire_sound, 30, 1)
	update_firemode()

/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0, obj/item/projectile/P)
	if(stam_cost) //CIT CHANGE - makes gun recoil cause staminaloss
		var/safe_cost = clamp(stam_cost, 0, STAMINA_NEAR_CRIT - user.getStaminaLoss())*(firing && burst_size >= 2 ? 1/burst_size : 1)
		user.adjustStaminaLossBuffered(safe_cost) //CIT CHANGE - ditto

	if(suppressed)
		playsound(user, fire_sound, 10, 1)
	else
		playsound(user, fire_sound, 50, 1)
		if(message)
			if(pointblank)
				user.visible_message("<span class='danger'>[user] fires [src] point blank at [pbtarget]!</span>", null, null, COMBAT_MESSAGE_RANGE)
			else
				user.visible_message("<span class='danger'>[user] fires [src]!</span>", null, null, COMBAT_MESSAGE_RANGE)
	kickback(user, P)

//Adds logging to the attack log whenever anyone draws a gun, adds a pause after drawing a gun before you can do anything based on it's size
/obj/item/gun/pickup(mob/living/user)
	. = ..()
	weapondraw(src, user)
	play_equip_sound(src)

/obj/item/gun/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		for(var/obj/O in contents)
			O.emp_act(severity)

/obj/item/gun/attack(mob/living/M, mob/user)
	. = ..()
	if(bayonet && user.a_intent == INTENT_HARM)
		M.attackby(bayonet, user) // handles cooldown
		return
	if(!(. & DISCARD_LAST_ACTION))
		user.DelayNextAction(attack_speed)

/obj/item/gun/attack_obj(obj/O, mob/user)
	. = ..()
	if(bayonet && user.a_intent == INTENT_HARM)
		O.attackby(bayonet, user) // handles cooldown
		return
	if(!(. & DISCARD_LAST_ACTION))
		user.DelayNextAction(attack_speed)

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

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	if(flag)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			handle_suicide(user, target, params)
			return

	//Exclude lasertag guns from the TRAIT_CLUMSY check.
	if(clumsy_check)
		if(istype(user))
			if (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
				to_chat(user, "<span class='userdanger'>You shoot yourself in the foot with [src]!</span>")
				var/shot_leg = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
				process_fire(user, user, FALSE, params, shot_leg)
				user.dropItemToGround(src, TRUE)
				return

	if(weapon_weight == GUN_TWO_HAND_ONLY && !wielded)
		to_chat(user, "<span class='userdanger'>You need both hands free to fire \the [src]!</span>")
		return

	if (automatic == 0)
		user.DelayNextAction(fire_delay)
	if (automatic == 1)
		user.DelayNextAction(autofire_shot_delay)

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
				addtimer(CALLBACK(G, /obj/item/gun.proc/process_fire, target, user, TRUE, params, null, stam_cost), loop_counter)

	var/stam_cost = getstamcost(user)

	process_fire(target, user, TRUE, params, null, stam_cost)

/obj/item/gun/can_trigger_gun(mob/living/user)
	. = ..()
	if(!.)
		return
	if(!handle_pins(user))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && chambered?.harmful) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
		to_chat(user, "<span class='notice'> [src] is lethally chambered! You don't want to risk harming anyone...</span>")
		return FALSE

/obj/item/gun/CheckAttackCooldown(mob/user, atom/target)
	if((user.a_intent == INTENT_HARM || INTENT_HELP) && user.Adjacent(target))		//melee
		return user.CheckActionCooldown(CLICK_CD_MELEE)
	return user.CheckActionCooldown(get_clickcd())

/obj/item/gun/proc/get_clickcd()
	if (automatic == 0)
		return isnull(chambered?.click_cooldown_override)? fire_delay : chambered.click_cooldown_override
	if (automatic == 1)
		return isnull(chambered?.click_cooldown_override)? autofire_shot_delay : chambered.click_cooldown_override

/obj/item/gun/GetEstimatedAttackSpeed()
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
		to_chat(user, "<span class='warning'>[src]'s trigger is locked. This weapon doesn't have a firing pin installed!</span>")
	return FALSE

/obj/item/gun/proc/recharge_newshot()
	return

/obj/item/gun/proc/on_cooldown()
	if (automatic == 0)
		return busy_action || firing || ((last_fire + fire_delay) > world.time)
	if (automatic == 1)
		return busy_action || firing

/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", stam_cost = 0)
	add_fingerprint(user)

	if(on_cooldown())
		return
	if(safety)
		to_chat(user, span_danger("The gun's safety is on!"))
		shoot_with_empty_chamber(user)
		return
	var/time_till_draw = user.AmountWeaponDrawDelay()
	if(time_till_draw)
		to_chat(user, "<span class='notice'>You're still drawing your [src]! It'll take another <u>[time_till_draw*0.1] seconds</u> until it's ready!</span>")
		return
	firing = TRUE
	. = do_fire(target, user, message, params, zone_override, stam_cost)
	firing = FALSE
	last_fire = world.time

	if(user)
		user.update_inv_hands()
		SEND_SIGNAL(user, COMSIG_LIVING_GUN_PROCESS_FIRE, target, params, zone_override, stam_cost)

/obj/item/gun/proc/do_fire(atom/target, mob/living/user, message = TRUE, params, zone_override = "", stam_cost = 0)
	var/sprd = 0
	if(HAS_TRAIT(user, SPREAD_CONTROL))
		//nothing for now
	for(var/i in 1 to burst_size)
		if(chambered)
			sprd = user.calculate_offset(init_offset)
			sprd = roll(2, sprd) - (sprd + 1)
			before_firing(target,user)
			var/BB = chambered.BB
			if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, damage_multiplier, penetration_multiplier, src))
				shoot_with_empty_chamber(user)
				return
			else
				if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, 1, target, message, stam_cost, BB)
				else
					shoot_live_shot(user, 0, target, message, stam_cost, BB)
		else
			shoot_with_empty_chamber(user)
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
			to_chat(user, "<span class='notice'>You click [S] into place on [src].</span>")
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
		to_chat(user, "<span class='notice'>You attach \the [K] to the front of \the [src].</span>")
		bayonet = K
		update_icon()
		update_overlays()
		return

	if(istype(I, /obj/item/attachments/scope))
		if(!can_scope)
			return ..()
		var/obj/item/attachments/scope/C = I
		if(!scope)
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, "<span class='notice'>You attach \the [C] to the top of \the [src].</span>")
			scope = C
			src.zoomable = TRUE
			src.zoom_amt = 10
			src.zoom_out_amt = 13
			src.build_zooming()
			update_overlays()
			update_icon()
		return
	/*
	if(istype(I, /obj/item/attachments/recoil_decrease))
		var/obj/item/attachments/recoil_decrease/R = I
		if(!recoil_decrease && can_attachments)
			if(!user.transferItemToLoc(I, src))
				return
			recoil_decrease = R
			src.desc += " It has a recoil compensator installed."
			recoil_multiplier *= 0.5
			recoil_cooldown_time *= 0.5
			to_chat(user, "<span class='notice'>You attach \the [R] to \the [src].</span>")
			return
	*/
	/*
	if(istype(I, /obj/item/attachments/burst_improvement))
		var/obj/item/attachments/burst_improvement/T = I
		if(!burst_improvement && burst_size > 1 && can_attachments)
			if(!user.transferItemToLoc(I, src))
				return
			burst_improvement = T
			src.desc += " It has a modified burst cam installed."
			src.burst_size += 2
			src.spread += 5
			src.burst_shot_delay += 0.25
			to_chat(user, "<span class='notice'>You attach \the [T] to \the [src].</span>")
			update_icon()
			return*/
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
		to_chat(user, "<span class='notice'>You unscrew the seclite from \the [src].</span>")
		S.forceMove(get_turf(user))
		clear_gunlight()
		return TRUE

	if(can_bayonet && bayonet)
		I.play_tool_sound(src)
		to_chat(user, "<span class='notice'>You unscrew the bayonet from \the [src].</span>")
		var/obj/item/melee/onehanded/knife/bayonet/K = bayonet
		K.forceMove(get_turf(user))
		bayonet = null
		update_icon()
		return TRUE

	if(scope)
		I.play_tool_sound(src)
		to_chat(user, "<span class='notice'>You unscrew the scope from \the [src].</span>")
		var/obj/item/attachments/scope/C = scope
		C.forceMove(get_turf(user))
		src.zoomable = FALSE
		azoom.Remove(user)
		scope = null
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

/*
/obj/item/gun/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_scope_zoom))
		zoom(user)
	else if(istype(action, alight))
		toggle_gunlight()
*/

/obj/item/gun/proc/toggle_gunlight()
	if(!gun_light)
		return

	var/mob/living/carbon/human/user = usr
	gun_light.on = !gun_light.on
	gun_light.update_brightness()
	to_chat(user, "<span class='notice'>You toggle the gunlight [gun_light.on ? "on":"off"].</span>")

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
		if(zoomable == TRUE)
			azoom.Remove(user)

/obj/item/gun/dropped(mob/user)
	. = ..()
	if(zoomed)
		zoom(user,FALSE)
	if(azoom)
		azoom.Remove(user)
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

	if(suppressed)
		var/icon/suppressor_icons = 'icons/fallout/objects/guns/attachments.dmi'
		suppressor_overlay = mutable_appearance(suppressor_icons, suppressor_state)
		suppressor_overlay.pixel_x = suppressor_x_offset
		suppressor_overlay.pixel_y = suppressor_y_offset
		. += suppressor_overlay
	else
		suppressor_overlay = null

	if(worn_out)
		. += ("[initial(icon_state)]_worn")


/obj/item/gun/item_action_slot_check(slot, mob/user, datum/action/A)
	if(istype(A, /datum/action/item_action/toggle_scope_zoom) && slot != SLOT_HANDS)
		return FALSE
	return ..()

/obj/item/gun/proc/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return

	if(on_cooldown())
		return

	if(user == target)
		target.visible_message("<span class='warning'>[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger...</span>", \
			"<span class='userdanger'>You stick [src] in your mouth, ready to pull the trigger...</span>")
	else
		target.visible_message("<span class='warning'>[user] points [src] at [target]'s head, ready to pull the trigger...</span>", \
			"<span class='userdanger'>[user] points [src] at your head, ready to pull the trigger...</span>")

	busy_action = TRUE

	if(!bypass_timer && (!do_mob(user, target, 120) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message("<span class='notice'>[user] decided not to shoot.</span>")
			else if(target && target.Adjacent(user))
				target.visible_message("<span class='notice'>[user] has decided to spare [target]</span>", "<span class='notice'>[user] has decided to spare your life!</span>")
		busy_action = FALSE
		return

	busy_action = FALSE

	target.visible_message("<span class='warning'>[user] pulls the trigger!</span>", "<span class='userdanger'>[user] pulls the trigger!</span>")

	playsound('sound/weapons/dink.ogg', 30, 1)

	if(chambered && chambered.BB)
		chambered.BB.damage *= 5

	process_fire(target, user, TRUE, params, stam_cost = getstamcost(user))

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

/datum/action/item_action/toggle_scope_zoom
	name = "Toggle Scope"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_RESTRAINED|AB_CHECK_STUN|AB_CHECK_LYING
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"

/datum/action/item_action/toggle_scope_zoom/Trigger()
	var/obj/item/gun/gun = target
	gun.zoom(owner)

/datum/action/item_action/toggle_scope_zoom/IsAvailable(silent = FALSE)
	. = ..()
	if(!. && target)
		var/obj/item/gun/gun = target
		gun.zoom(owner, FALSE)

/datum/action/item_action/toggle_scope_zoom/Remove(mob/living/L)
	var/obj/item/gun/gun = target
	gun.zoom(L, FALSE)
	..()

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
		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE, .proc/rotate)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED) //pls don't conflict with anything else using this signal
		user.visible_message("<span class='notice'>[user] looks down the scope of [src].</span>", "<span class='notice'>You look down the scope of [src].</span>")
	else
		user.remove_movespeed_modifier(/datum/movespeed_modifier/scoped_in)
		user.client.change_view(CONFIG_GET(string/default_view))
		user.client.pixel_x = 0
		user.client.pixel_y = 0
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		user.visible_message("<span class='notice'>[user] looks up from the scope of [src].</span>", "<span class='notice'>You look up from the scope of [src].</span>")
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/on_walk) //Extra proc to make sure your zoom resets for bug where you don't unzoom when toggling while moving

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

//Proc, so that gun accessories/scopes/etc. can easily add zooming.
/obj/item/gun/proc/build_zooming()
	if(azoom)
		return

	if(zoomable)
		azoom = new(src)

/obj/item/gun/proc/getstamcost(mob/living/carbon/user)
	. = 0 //get_per_shot_recoil()
	if(user && !user.has_gravity())
		. *= 5

/obj/item/gun/proc/weapondraw(obj/item/gun/G, mob/living/user) // Eventually, this will be /obj/item/weapon and guns will be /obj/item/weapon/gun/etc. SOON.tm
	user.visible_message("<span class='danger'>[user] grabs \a [G]!</span>") // probably could code in differences as to where you're picking it up from and so forth. later.
	var/time_till_gun_is_ready = max(draw_time,(user.AmountWeaponDrawDelay()))
	user.SetWeaponDrawDelay(time_till_gun_is_ready)
	if(safety && user.a_intent == INTENT_HARM)
		toggle_safety(user, ignore_held = TRUE)
	// TODO: Define where you're grabbing it from, assign numbers to them, and then divide the paralyze total by that. Tables/holster/belt/back/container.
	user.log_message("[user] pulled a [G]", INDIVIDUAL_ATTACK_LOG)
	spawn(time_till_gun_is_ready)
		if(user.get_active_held_item() == src)
			user.show_message(span_notice("\The [src] is ready to fire."))

/obj/item/gun/proc/play_equip_sound(src, volume=50)
	if(src && equipsound && volume)
		var/played_sound = equipsound

		if(islist(equipsound))
			played_sound = pick(equipsound)

		playsound(src, played_sound, volume, 1)

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

/obj/item/gun/proc/kickback(mob/living/user, obj/item/projectile/P)
	var/base_recoil = recoil_dat.getRating(RECOIL_BASE)
	var/brace_recoil = 0
	var/unwielded_recoil = 0

	/*if(!braced)
		brace_recoil = recoil_dat.getRating(RECOIL_TWOHAND)
	else if(braceable > 1)
		base_recoil /= 4 // With a bipod, you can negate most of your recoil
	*/
	if(!wielded)
		unwielded_recoil = recoil_dat.getRating(RECOIL_ONEHAND)

	if(unwielded_recoil)
		switch(recoil_dat.getRating(RECOIL_ONEHAND_LEVEL))
			if(0.6 to 0.8)
				if(prob(25)) // Don't need to tell them every single time
					to_chat(user, span_warning("Your aim wavers slightly."))
			if(0.8 to 1)
				if(prob(50))
					to_chat(user, span_warning("Your aim wavers as you fire \the [src] with just one hand."))
			if(1 to 1.5)
				to_chat(user, span_warning("You have trouble keeping \the [src] on target with just one hand."))
			if(1.5 to INFINITY)
				to_chat(user, span_warning("You struggle to keep \the [src] on target with just one hand!"))

	else if(brace_recoil)
		switch(recoil_dat.getRating(RECOIL_BRACE_LEVEL))
			if(0.6 to 0.8)
				if(prob(25))
					to_chat(user, span_warning("Your aim wavers slightly."))
			if(0.8 to 1)
				if(prob(50))
					to_chat(user, span_warning("Your aim wavers as you fire \the [src] while carrying it."))
			if(1 to 1.2)
				to_chat(user, span_warning("You have trouble keeping \the [src] on target while carrying it!"))
			if(1.2 to INFINITY)
				to_chat(user, span_warning("You struggle to keep \the [src] on target while carrying it!"))

	user.handle_recoil(src, (base_recoil + brace_recoil + unwielded_recoil) * P.recoil)

/obj/item/gun/proc/add_firemode(list/firemode)
	//If this var is set, it means spawn a specific subclass of firemode
	if (firemode["mode_type"])
		var/newtype = firemode["mode_type"]
		firemodes.Add(new newtype(src, firemode))
	else
		firemodes.Add(new /datum/firemode(src, firemode))

/obj/item/gun/proc/switch_firemodes()
	if(firemodes.len <= 1)
		return null
	update_firemode(FALSE) //Disable the old firing mode before we switch away from it
	sel_mode++
	if(sel_mode > firemodes.len)
		sel_mode = 1
	return set_firemode(sel_mode)

/obj/item/gun/proc/set_firemode(index)
	//refresh_upgrades()
	if(index > firemodes.len)
		index = 1
	var/datum/firemode/new_mode = firemodes[sel_mode]
	new_mode.apply_to(src)
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
			//toggle_scope(user)
		if("safety")
			toggle_safety(user)
		if("Weapon Info")
			ui_interact(user)

/obj/item/gun/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "WeaponInfo", "Weapon Info")
    	ui.open()

/obj/item/gun/ui_data(mob/user)
	var/list/data = list()
	data["damage_multiplier"] = damage_multiplier
	//data["pierce_multiplier"] = pierce_multiplier
	//data["ricochet_multiplier"] = ricochet_multiplier
	data["penetration_multiplier"] = penetration_multiplier

	data["fire_delay"] = fire_delay //time between shot, in ms
	data["burst"] = burst_size //How many shots are fired per click
	data["burst_delay"] = burst_shot_delay //time between shot in burst mode, in ms

	data["force"] = force
	data["force_max"] = initial(force)*10
	data["armor_penetration"] = armour_penetration
	//data["muzzle_flash"] = muzzle_flash

	var/total_recoil = 0
	var/list/recoilList = recoil_dat.getFancyList()
	if(recoilList.len)
		var/list/recoil_vals = list()
		for(var/i in recoilList)
			if(recoilList[i])
				recoil_vals += list(list(
					"name" = i,
					"value" = recoilList[i]
					))
				total_recoil += recoilList[i]
		data["recoil_info"] = recoil_vals

	data["total_recoil"] = total_recoil

	data += ui_data_projectile(get_dud_projectile())

	if(firemodes.len)
		var/list/firemodes_info = list()
		for(var/i = 1 to firemodes.len)
			data["firemode_count"] += 1
			var/datum/firemode/F = firemodes[i]
			var/list/firemode_info = list(
				"index" = i,
				"current" = (i == sel_mode),
				"name" = F.name,
				"desc" = F.desc,
				"burst" = F.settings["burst_size"],
				"fire_delay" = F.settings["fire_delay"],
				//"move_delay" = F.settings["move_delay"],
				)
			if(F.settings["projectile_type"])
				var/proj_path = F.settings["projectile_type"]
				var/list/proj_data = ui_data_projectile(new proj_path)
				firemode_info += proj_data
			firemodes_info += list(firemode_info)
		data["firemode_info"] = firemodes_info

	/*if(item_upgrades.len)
		data["attachments"] = list()
		for(var/atom/A in item_upgrades)
			data["attachments"] += list(list("name" = A.name, "icon" = getAtomCacheFilename(A)))*/
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
	update_icon()

//Returns a projectile that's not for active usage.
/obj/item/gun/proc/get_dud_projectile()
	return null

/obj/item/gun/proc/ui_data_projectile(obj/item/projectile/P)
	if(!P)
		return list()
	var/list/data = list()
	data["projectile_name"] = P.name
	data["projectile_damage"] = (P.damage * damage_multiplier)
	data["projectile_AP"] = P.armour_penetration * penetration_multiplier
	data["projectile_recoil"] = P.recoil
	qdel(P)
	return data

//Finds the current firemode and calls update on it. This is called from a few places:
//When firemode is changed
//When safety is toggled
//When gun is picked up
//When gun is readied
/obj/item/gun/proc/update_firemode(force_state = null)
	if (sel_mode && firemodes && firemodes.len)
		var/datum/firemode/new_mode = firemodes[sel_mode]
		new_mode.update(force_state)



///////////////////
//GUNCODE ARCHIVE//
///////////////////

/*
STICK GUN PICKUP WEIRDNESS
/obj/item/gun/ballistic/automatic/pistol/stickman/pickup(mob/living/user)
	. = ..()
	to_chat(user, "<span class='notice'>As you try to pick up [src], it slips out of your grip..</span>")
	if(prob(50))
		to_chat(user, "<span class='notice'>..and vanishes from your vision! Where the hell did it go?</span>")
		qdel(src)
		user.update_icons()
	else
		to_chat(user, "<span class='notice'>..and falls into view. Whew, that was a close one.</span>")
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
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
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
	. += "<span class='notice'>Alt-click to pump it.</span>"

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
			slot_flags = ITEM_SLOT_BACK
			to_chat(user, "<span class='notice'>You tie the lengths of cable to the rifle, making a sling.</span>")
			slung = TRUE
			update_icon()
		else
			to_chat(user, "<span class='warning'>You need at least ten lengths of cable if you want to make a sling!</span>")

/obj/item/gun/ballistic/shotgun/boltaction/improvised/update_overlays()
	. = ..()
	if(slung)
		. += "[icon_state]sling"


HOOK GUN CODE. Bizarre but could be made into something useful.
/obj/item/gun/ballistic/shotgun/doublebarrel/hook
	name = "hook modified sawn-off shotgun"
	desc = "Range isn't an issue when you can bring your victim to you."
	icon_state = "hookshotgun"
	item_state = "shotgun"
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
	item_state = "m90"
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

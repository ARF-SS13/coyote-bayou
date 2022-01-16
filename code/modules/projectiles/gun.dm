/*
IN THIS DOCUMENT: Universal Gun system rules/keywords. Universal gun template and procs/vars.

/////////////////////////////////////
//UNIVERSAL GUN KEYWORDS AND SYSTEM//
/////////////////////////////////////

GENERAL

	Bonuses should not go far from this framework, for non-unique stuff plus minus one or two is enough to give a good spread, considering its compounded by tinkering and attachments and ammo.
	A reduction of 1 in burst shot delay gives a lot more effect than adding 1 damage.

KEYWORDS

	SINGLE ACTION REVOLVER
	fire_delay = 6
	spread = 1

	DOUBLE ACTION REVOLVER
	fire_delay = 5	
	spread = 1

	SEMI-AUTOMATIC PISTOL
	fire_delay = 3-5	
	spread = 2

	SEMI-AUTOMATIC RIFLE
	fire_delay = 3-6
	spread = 1

	AUTOMATIC SMG
	fire_delay = 2.5-6
	burst_shot_delay = 2.75
	spread = 8-14

	AUTOMATIC RIFLE
	fire_delay = 3-6
	burst_shot_delay = 3
	spread = 7-12

	REPEATER	
	fire_delay = 6
	spread = 0

	DOUBLE BARREL
	fire_delay = 0.5
	extra damage = 1

	PUMP-ACTION
	fire_delay = 7
	extra damage = 1
	spread = 1 (to avoid slugs being too good snipers, might need to be set to 2 for all shotguns)
	(requires manual action to cycle)

	BOLT-ACTION
	fire_delay = 10-15
	extra damage = 6
	extra_speed = 800
	spread = 0
	(requires manual action to cycle)

	PISTOL GRIP/FOLDED STOCK MALUS (For rifles, not pistols obviously)
	recoil = 0.5
	spread = +2 (not for shotguns)
	w_class = WEIGHT_CLASS_NORMAL

	SAWN OFF
	recoil = 1
	spread = 10
	weapon_weight = WEAPON_LIGHT

	LONG BARREL/LASERSIGHT
	extra_damage = +2
	spread = -1

	SHORT BARREL
	extra_damage = -2
	spread = +2

	HEAVY
	recoil = 0.1
	weapon_weight = WEAPON_MEDIUM at least (no dual wield)

GENERAL RULES

	SMALL GUNS
	slowdown = 0.1-0.2
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT - MEDIUM		

	MEDIUM GUNS
	slowdown = 0.3-0.4
	w_class = WEIGHT_CLASS_NORMAL - BULKY
	weapon_weight = WEAPON_MEDIUM - HEAVY	

	RIFLES 
	slowdown = 0.5
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

	AMMO RECOIL BASE VALUES
	.50  recoil = 1
	.45/70  recoil = 0.25

	2-ROUND BURST
	recoil = 0.1

	3-ROUND BURST
	recoil = 0.25

	FORCE
	Delicate, clumsy or small gun force 10
	Pistol whip force 12
	Rifle type force 15
	Unusually sturdy clublike 20

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

#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.4

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
	var/ranged_attack_speed = CLICK_CD_RANGE
	var/fire_sound = "gunshot"
	var/recoil = 0						//boom boom shake the room
	var/clumsy_check = TRUE
	var/obj/item/ammo_casing/chambered = null
	trigger_guard = TRIGGER_GUARD_NORMAL	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	var/sawn_desc = null				//description change if weapon is sawn-off
	var/sawn_off = FALSE

	/// can we be put into a turret
	var/can_turret = TRUE
	/// can we be put in a circuit
	var/can_circuit = TRUE
	/// can we be put in an emitter
	var/can_emitter = TRUE

	/// Weapon is burst fire if this is above 1
	var/burst_size = 1
	/// The time between shots in burst.
	var/burst_shot_delay = 3
	/// The time between firing actions, this means between bursts if this is burst weapon. The reason this is 0 is because you are still, by default, limited by clickdelay.
	var/fire_delay = 0
	/// Last world.time this was fired
	var/last_fire = 0
	/// Currently firing, whether or not it's a burst or not.
	var/firing = FALSE
	/// Used in gun-in-mouth execution/suicide and similar, while TRUE nothing should work on this like firing or modification and so on and so forth.
	var/busy_action = FALSE
	var/weapon_weight = WEAPON_LIGHT	//used for inaccuracy and wielding requirements/penalties
	var/spread = 0						//Spread induced by the gun itself.
	var/burst_spread = 0				//Spread induced by the gun itself during burst fire per iteration. Only checked if spread is 0.
	var/randomspread = 1				//Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.
	var/inaccuracy_modifier = 1
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

	var/obj/item/melee/onehanded/knife/bayonet/bayonet
	var/mutable_appearance/knife_overlay
	var/can_bayonet = FALSE
	var/bayonet_state = "bayonetstraight"

	var/mutable_appearance/scope_overlay
	var/can_scope = FALSE
	var/scope_state = "scope"

	var/mutable_appearance/flashlight_overlay
	var/can_attachments = FALSE
	var/can_automatic = FALSE

	var/mutable_appearance/suppressor_overlay
	var/suppressor_state = null
	var/suppressed = null					//whether or not a message is displayed when fired
	var/can_suppress = FALSE
	var/can_unsuppress = TRUE

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
	var/isenergy = null
	var/isbow = null
	var/extra_damage = 0				//Number to add to individual bullets.
	var/extra_penetration = 0			//Number to add to armor penetration of individual bullets.

	//Zooming
	var/zoomable = FALSE //whether the gun generates a Zoom action on creation
	var/zoomed = FALSE //Zoom toggle
	var/zoom_amt = 3 //Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_out_amt = 0
	var/datum/action/item_action/toggle_scope_zoom/azoom

	var/dualwield_spread_mult = 1		//dualwield spread multiplier

	var/worn_out = FALSE	//If true adds overlay with suffix _worn, and a slight malus to stats
	/// Just 'slightly' snowflakey way to modify projectile damage for projectiles fired from this gun.
//	var/projectile_damage_multiplier = 1

/*
	var/automatic = 0 //can gun use it, 0 is no, anything above 0 is the delay between clicks in ds 
*/ //Disabled because automatic fire is buggy and a bit OP.

/obj/item/gun/Initialize()
	. = ..()
	if(no_pin_required)
		pin = null
	else if(pin)
		pin = new pin(src)
	if(gun_light)
		alight = new (src)
	build_zooming()

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
	if (isenergy == TRUE)
		to_chat(user, "<span class='danger'>*power failure*</span>")
		playsound(src, 'sound/f13weapons/noammoenergy.ogg', 30, 1)
		return
	if (isbow == TRUE)
		to_chat(user, "<span class='danger'>*no arrows*</span>") //Insert cool plink plink sound here
		return
	to_chat(user, "<span class='danger'>*click*</span>")
	playsound(src, "gun_dry_fire", 30, 1)

/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	if(recoil)
		shake_camera(user, recoil + 1, recoil)

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

//Adds logging to the attack log whenever anyone draws a gun, adds a pause after drawing a gun before you can do anything based on it's size
/obj/item/gun/pickup(mob/living/user)
	. = ..()
	weapondraw(src, user)

/obj/item/gun/pickup(mob/living/user)
	. = ..()
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
	var/stamloss = user.getStaminaLoss()
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

	if(weapon_weight == WEAPON_HEAVY && user.get_inactive_held_item())
		to_chat(user, "<span class='userdanger'>You need both hands free to fire \the [src]!</span>")
		return

	user.DelayNextAction(ranged_attack_speed)

	//DUAL (or more!) WIELDING
	var/bonus_spread = 0
	var/loop_counter = 0

	if(user)
		bonus_spread = getinaccuracy(user, bonus_spread, stamloss) //CIT CHANGE - adds bonus spread while not aiming
	if(ishuman(user) && user.a_intent == INTENT_HARM && weapon_weight <= WEAPON_LIGHT)
		var/mob/living/carbon/human/H = user
		for(var/obj/item/gun/G in H.held_items)
			if(G == src || G.weapon_weight >= WEAPON_MEDIUM)
				continue
			else if(G.can_trigger_gun(user))
				bonus_spread += 24 * G.weapon_weight * G.dualwield_spread_mult
				loop_counter++
				var/stam_cost = G.getstamcost(user)
				addtimer(CALLBACK(G, /obj/item/gun.proc/process_fire, target, user, TRUE, params, null, bonus_spread, stam_cost), loop_counter)

	var/stam_cost = getstamcost(user)
	process_fire(target, user, TRUE, params, null, bonus_spread, stam_cost)

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
	return isnull(chambered?.click_cooldown_override)? CLICK_CD_RANGE : chambered.click_cooldown_override

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
	return busy_action || firing || ((last_fire + fire_delay) > world.time)

/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	add_fingerprint(user)

	if(on_cooldown())
		return
	if(user.IsWeaponDrawDelayed())
		to_chat(user, "<span class='notice'>[src] is not yet ready to fire!</span>")
		return
	firing = TRUE
	. = do_fire(target, user, message, params, zone_override, bonus_spread, stam_cost)
	firing = FALSE
	last_fire = world.time

	if(user)
		user.update_inv_hands()
		SEND_SIGNAL(user, COMSIG_LIVING_GUN_PROCESS_FIRE, target, params, zone_override, bonus_spread, stam_cost)

/obj/item/gun/proc/do_fire(atom/target, mob/living/user, message = TRUE, params, zone_override = "", bonus_spread = 0, stam_cost = 0)
	var/sprd = 0
	var/randomized_gun_spread = 0
	var/rand_spr = rand()
	if(spread)
		randomized_gun_spread = rand(0, spread)
	else if(burst_size > 1 && burst_spread)
		randomized_gun_spread = rand(0, burst_spread)
	var/randomized_bonus_spread = rand(0, bonus_spread)

	if(burst_size > 1)
		do_burst_shot(user, target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, 1)
		for(var/i in 2 to burst_size)
			sleep(burst_shot_delay)
			if(QDELETED(src))
				break
			do_burst_shot(user, target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, i, stam_cost)
	else
		if(chambered)
			sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))
			before_firing(target,user)
			if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, extra_damage, extra_penetration, src))
				shoot_with_empty_chamber(user)
				return
			else
				if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, 1, target, message, stam_cost)
				else
					shoot_live_shot(user, 0, target, message, stam_cost)
		else
			shoot_with_empty_chamber(user)
			return
		process_chamber(user)
		update_icon()

	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE

/obj/item/gun/proc/do_burst_shot(mob/living/user, atom/target, message = TRUE, params=null, zone_override = "", sprd = 0, randomized_gun_spread = 0, randomized_bonus_spread = 0, rand_spr = 0, iteration = 0, stam_cost = 0)
	if(!user || !firing)
		firing = FALSE
		return FALSE
	if(!issilicon(user))
		if(iteration > 1 && !(user.is_holding(src))) //for burst firing
			firing = FALSE
			return FALSE
	if(chambered && chambered.BB)
		if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
			if(chambered.harmful) // Is the bullet chambered harmful?
				to_chat(user, "<span class='notice'> [src] is lethally chambered! You don't want to risk harming anyone...</span>")
				return
		if(randomspread)
			sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread), 1)
		else //Smart spread
			sprd = round((((rand_spr/burst_size) * iteration) - (0.5 + (rand_spr * 0.25))) * (randomized_gun_spread + randomized_bonus_spread), 1)
		before_firing(target,user)
		if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, extra_damage, extra_penetration, src))
			shoot_with_empty_chamber(user)
			firing = FALSE
			return FALSE
		else
			if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
				shoot_live_shot(user, 1, target, message, stam_cost)
			else
				shoot_live_shot(user, 0, target, message, stam_cost)
			if (iteration >= burst_size)
				firing = FALSE
	else
		shoot_with_empty_chamber(user)
		firing = FALSE
		return FALSE
	process_chamber(user)
	update_icon()
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

	if(istype(I, /obj/item/attachments/recoil_decrease))
		var/obj/item/attachments/recoil_decrease/R = I
		if(!recoil_decrease && can_attachments)
			if(!user.transferItemToLoc(I, src))
				return
			recoil_decrease = R
			src.desc += " It has a recoil compensator installed."
			if (src.spread > 10)
				src.spread -= 4
			else
				src.spread -= 2
			to_chat(user, "<span class='notice'>You attach \the [R] to \the [src].</span>")
			return

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


/obj/item/gun/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_scope_zoom))
		zoom(user)
	else if(istype(action, alight))
		toggle_gunlight()

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

/obj/item/gun/pickup(mob/user)
	..()
	if(azoom)
		azoom.Grant(user)
	if(alight)
		alight.Grant(user)

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(user.get_active_held_item() != src) //we can only stay zoomed in if it's in our hands	//yeah and we only unzoom if we're actually zoomed using the gun!!
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
		src.fire_delay += 0.1
		src.spread += 2
		src.extra_damage -= 1


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

/obj/item/gun/proc/getinaccuracy(mob/living/user, bonus_spread, stamloss)
	if(inaccuracy_modifier == 0)
		return bonus_spread
	var/base_inaccuracy = weapon_weight * 25 * inaccuracy_modifier //+ 50 + (-user.special_p*5)//SPECIAL Integration
	var/aiming_delay = 0 //Otherwise aiming would be meaningless for slower guns such as sniper rifles and launchers.
	if(fire_delay)
		var/penalty = (last_fire + GUN_AIMING_TIME + fire_delay) - world.time
		if(penalty > 0) //Yet we only penalize users firing it multiple times in a haste. fire_delay isn't necessarily cumbersomeness.
			aiming_delay = penalty
	if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE) || HAS_TRAIT(user, TRAIT_INSANE_AIM)) //To be removed in favor of something less tactless later.
		base_inaccuracy /= 1.5
	if(stamloss > STAMINA_NEAR_SOFTCRIT) //This can null out the above bonus.
		base_inaccuracy *= 1 + (stamloss - STAMINA_NEAR_SOFTCRIT)/(STAMINA_NEAR_CRIT - STAMINA_NEAR_SOFTCRIT)*0.5
	if(HAS_TRAIT(user, TRAIT_POOR_AIM)) //nice shootin' tex
		if(!HAS_TRAIT(user, TRAIT_INSANE_AIM))
			bonus_spread += 60
		else
			//you have both poor aim and insane aim, why?
			bonus_spread += rand(0,50)
	var/mult = max((GUN_AIMING_TIME + aiming_delay + user.last_click_move - world.time)/GUN_AIMING_TIME, -0.5) //Yes, there is a bonus for taking time aiming.
	if(mult < 0) //accurate weapons should provide a proper bonus with negative inaccuracy. the opposite is true too.
		mult *= 1/inaccuracy_modifier
	return max(bonus_spread + (base_inaccuracy * mult), 0) //no negative spread.

/obj/item/gun/proc/getstamcost(mob/living/carbon/user)
	. = recoil
	if(user && !user.has_gravity())
		. = recoil*5

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
	weapon_weight = WEAPON_MEDIUM
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

/obj/item/gun/ballistic/automatic/m90/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 1
			burst_size = initial(burst_size)
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>You switch to grenades.</span>")
		if(2)
			select = 0
			burst_size = 1
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return


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


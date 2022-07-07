//IN THIS DOCUMENT: Automatic template, SMGs, Carbines, Semi-auto rifles, Assault rifles, Machineguns and Misc.
// See gun.dm for keywords and the system used for gun balance



//////////////////////
//AUTOMATIC TEMPLATE//
//////////////////////


/obj/item/gun/ballistic/automatic
	name = "automatic gun template"
	desc = "should not be here, bugreport."
	w_class = WEIGHT_CLASS_BULKY

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	slot_flags = SLOT_BACK
	force = 15
	burst_size = 1
	burst_shot_delay = 3
	var/automatic_burst_overlay = TRUE
	var/semi_auto = FALSE
	var/auto_eject = 0
	var/auto_eject_sound = null
	var/alarmed = 0
	var/select = 1
	var/is_automatic = FALSE
	can_suppress = FALSE
	equipsound = 'sound/f13weapons/equipsounds/riflequip.ogg'

/obj/item/gun/ballistic/automatic/attackby(obj/item/I, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()
	else if(istype(I, /obj/item/attachments/auto_sear))
		var/obj/item/attachments/auto_sear/A = I
		if(!auto_sear && can_automatic && semi_auto)
			if(!user.transferItemToLoc(I, src))
				return
			auto_sear = A
			desc += " It has an automatic sear installed."
			//src.burst_size += 1
			semi_auto = FALSE
			automatic = TRUE
			spread = (spread + 1) * 1.5
			recoil_multiplier = (max(recoil_multiplier, 1)) * 2
			recoil_cooldown_schedule = (max(recoil_cooldown_schedule, GUN_RECOIL_TIMEOUT_LONG)) * 2
			//automatic_burst_overlay = TRUE
			to_chat(user, "<span class='notice'>You attach \the [A] to \the [src].</span>")
			update_icon()
	else
		return ..()

/obj/item/gun/ballistic/automatic/update_overlays()
	. = ..()
	if(automatic_burst_overlay)
		if(!select)
			. += ("[initial(icon_state)]semi")
		if(select == 1)
			. += "[initial(icon_state)]burst"

/obj/item/gun/ballistic/automatic/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/AM = A
		if(istype(AM, mag_type))
			var/obj/item/ammo_box/magazine/oldmag = magazine
			if(user.transferItemToLoc(AM, src))
				magazine = AM
				if(oldmag)
					to_chat(user, "<span class='notice'>You perform a tactical reload on \the [src], replacing the magazine.</span>")
					oldmag.forceMove(get_turf(src.loc))
					oldmag.update_icon()
				else
					to_chat(user, "<span class='notice'>You insert the magazine into \the [src].</span>")

				playsound(user, 'sound/weapons/autoguninsert.ogg', 60, 1)
				chamber_round()
				A.update_icon()
				update_icon()
				return 1
			else
				to_chat(user, "<span class='warning'>You cannot seem to get \the [src] out of your hands!</span>")

/obj/item/gun/ballistic/automatic/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_firemode))
		if(is_automatic == FALSE)
			burst_select()
		if(is_automatic == TRUE)
			auto_select()
	else
		return ..()

/obj/item/gun/ballistic/automatic/proc/burst_select()
	var/mob/living/carbon/human/user = usr
	if(semi_auto)
		to_chat(user, "<span class = 'notice'>This weapon is semi-automatic only.</span>")
		return
	else
		select = !select
		if(!select)
			disable_burst()
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
		else
			enable_burst()
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		playsound(user, 'sound/weapons/empty.ogg', 100, 1)
		update_icon()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/gun/ballistic/automatic/proc/auto_select()
	var/mob/living/carbon/human/user = usr
	if(semi_auto)
		to_chat(user, "<span class = 'notice'>This weapon is semi-automatic only.</span>")
		return
	else
		select = !select
		if(!select)
			disable_auto()
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
		else
			enable_auto()
			to_chat(user, "<span class='notice'>You switch to automatic fire.</span>")
		playsound(user, 'sound/weapons/empty.ogg', 100, 1)
		update_icon()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/gun/ballistic/automatic/proc/enable_burst()
	burst_size = initial(burst_size)
	if(auto_sear)
		burst_size += initial(burst_size)
	if(burst_improvement)
		burst_size += initial(burst_size)
	if(burst_improvement && auto_sear)
		burst_size += 1 + initial(burst_size)

/obj/item/gun/ballistic/automatic/proc/disable_burst()
	burst_size = initial(burst_size)

/obj/item/gun/ballistic/automatic/proc/enable_auto()
	automatic = 1

/obj/item/gun/ballistic/automatic/proc/disable_auto()
	automatic = 0

/obj/item/gun/ballistic/automatic/can_shoot()
	return get_ammo()

/obj/item/gun/ballistic/automatic/proc/empty_alarm()
	if(!chambered && !get_ammo() && !alarmed)
		playsound(src.loc, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
		update_icon()
		alarmed = 1
	return

/obj/item/gun/ballistic/automatic/afterattack(atom/target, mob/living/user)
	..()
	if(auto_eject && magazine && magazine.stored_ammo && !magazine.stored_ammo.len && !chambered)
		magazine.dropped()
		user.visible_message(
			"[magazine] falls out and clatters on the floor!",
			"<span class='notice'>[magazine] falls out and clatters on the floor!</span>"
		)
		if(auto_eject_sound)
			playsound(user, auto_eject_sound, 40, 1)
		magazine.forceMove(get_turf(src.loc))
		magazine.update_icon()
		magazine = null
		update_icon()



/* * * * *
 * SMGs  *
 * * * * */

/* * * * * * * * * * *
 * Pistols, but faster
 * More magazine space
 * One handed
 * Some can be akimboed
 * Generally poor accuracy
 * Lot of recoil
 * Long recoil cooldown
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/
	name = "SMG TEMPLATE"
	desc = "should not exist"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_prefix = "uzi"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	actions_types = list(/datum/action/item_action/toggle_firemode)

/* * * * * * * * * * *
 * American 180 SMG
 * Spraycan SMG
 * .22LC
 * Huge magazine
 * Low damage
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/american180
	name = "American 180"
	desc = "An integrally suppressed submachinegun chambered in the common .22 long rifle. Top loaded drum magazine."
	icon_state = "smg22"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/m22smg

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_INSTANT
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T2 // -15%
	cock_delay = GUN_COCK_RIFLE_BASE

	can_unsuppress = FALSE
	is_automatic = TRUE
	suppressed = 1
	actions_types = null
	fire_sound = 'sound/f13weapons/american180.ogg'

/* * * * * * * * * * *
 * 14mm SMG
 * Heavy SMG
 * 14mm
 * Massive damage
 * Massive recoil
 * Slower shooting
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/smg14
	name = "14mm SMG"
	desc = "A heavy-duty SMG designed to tear through most forms of armor."
	icon_state = "14smg"
	item_state = "14toploader"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/smg14

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	can_suppress = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'

/* * * * * * * * * * *
 * Greasegun SMG
 * Baseline 9mm SMG
 * 9mm
 * One-handed
 * No akimbo
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/greasegun
	name = "9mm submachine gun"
	desc = "An inexpensive submachine gun, chambered in 9mm. Very high rate of fire in bursts."
	icon_state = "grease_gun"
	item_state = "smg9mm"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/greasegun

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 19
	//actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/f13weapons/greasegun.ogg'

/* /obj/item/gun/ballistic/automatic/smg/greasegun/auto_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			automatic = 1
			spread = 14
			fire_delay = 3.25
			recoil = 0.1
			weapon_weight = GUN_TWO_HAND_ONLY
			to_chat(user, "<span class='notice'>You switch to automatic fire.</span>")
			enable_burst()
		if(1)
			select = 0
			automatic = 0
			fire_delay = 3.25
			spread = 2
			weapon_weight = GUN_ONE_HAND_ONLY
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return */

/* * * * * * * * * * *
 * Worn greasegun SMG
 * Cruddy 9mm SMG
 * 9mm
 * One-handed
 * No akimbo
 * Less accuracy
 * Less damage
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/greasegun/worn
	name = "beat up 9mm submachine gun"
	desc = "What was once an inexpensive, but reliable submachine gun is now an inexpensive piece of shit. It's impressive this thing still fires at all."

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

	can_attachments = FALSE


/* /obj/item/gun/ballistic/automatic/smg/greasegun/worn/auto_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			automatic = 1
			spread = 16.5
			fire_delay = 3.75
			recoil = 0.3
			weapon_weight = GUN_TWO_HAND_ONLY
			to_chat(user, "<span class='notice'>You switch to automatic fire.</span>")
			enable_burst()
		if(1)
			select = 0
			automatic = 0
			fire_delay = 3.75
			spread = 2
			weapon_weight = GUN_TWO_HAND_ONLY
			recoil = 0.2
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return */

/* * * * * * * * * * *
 * 10mm SMG
 * Baseline 10mm SMG
 * 10mm
 * Slower firing
 * Heavier recoil
 * One-handed
 * No akimbo
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/smg10mm
	name = "10mm submachine gun"
	desc = "One of the most common personal-defense weapons of the Great War, a sturdy and reliable open-bolt 10mm submachine gun."
	icon_state = "smg10mm"
	item_state = "smg10mm"
	icon_prefix = "smg10mm"
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv
	init_mag_type = /obj/item/ammo_box/magazine/m10mm_adv/ext

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	suppressor_state = "10mm_suppressor" //activate if sprited
	suppressor_x_offset = 30
	suppressor_y_offset = 16
	//actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

/* * * * * * * * * * *
 * Worn 10mm SMG
 * Poor Baseline 10mm SMG
 * 10mm
 * Slower firing
 * Less damage
 * One-handed
 * No akimbo
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/smg10mm/worn
	name = "worn-out 10mm submachine gun"
	desc = "Mass-produced weapon from the Great War, this one has seen use ever since. Grip is wrapped in tape to keep the plastic from crumbling, the metals are oxidizing, but the gun still works."
	init_mag_type = /obj/item/ammo_box/magazine/m10mm_adv/ext
	worn_out = TRUE

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

/* /obj/item/gun/ballistic/automatic/smg/smg10mm/auto_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			automatic = 1
			spread = 12
			fire_delay = 3.25
			recoil = 0.1
			weapon_weight = GUN_TWO_HAND_ONLY
			to_chat(user, "<span class='notice'>You switch to automatic fire.</span>")
			enable_burst()
		if(1)
			select = 0
			automatic = 0
			fire_delay = 3.25
			spread = 2
			weapon_weight = GUN_ONE_HAND_ONLY
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return */

/* * * * * * * * * * *
 * Uzi 9mm SMG
 * Light 9mm SMG
 * 9mm
 * Faster firing
 * Less damage
 * One-handed
 * Akimbo!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/mini_uzi
	name = "Uzi"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	item_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

	automatic = 1
	is_automatic = TRUE
	can_suppress = TRUE
	can_attachments = TRUE
	spread = 10
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16
	//actions_types = list(/datum/action/item_action/toggle_firemode)

/* /obj/item/gun/ballistic/automatic/smg/mini_uzi/auto_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			automatic = 1
			spread = 16
			fire_delay = 3
			recoil = 0.1
			weapon_weight = GUN_TWO_HAND_ONLY
			to_chat(user, "<span class='notice'>You switch to automatic fire.</span>")
			enable_burst()
		if(1)
			select = 0
			automatic = 0
			fire_delay = 3
			spread = 3
			weapon_weight = GUN_ONE_HAND_ONLY
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return */

/* * * * * * * * * * *
 * Carl Gustaf 10mm SMG
 * Another 10mm SMG
 * 10mm
 * Slower firing
 * Less damage
 * One-handed
 * No akimbo
 * Common? ive never seen one
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/cg45
	name = "Carl Gustaf 10mm"
	desc = "Post-war submachine gun made in workshops in Phoenix, a copy of a simple old foreign design."
	icon_state = "cg45"
	item_state = "cg45"
	mag_type = /obj/item/ammo_box/magazine/cg45

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

/* * * * * * * * * * *
 * Thompson SMG
 * Baseline .45 SMG
 * .45ACP
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/tommygun
	name = "Thompson SMG"
	desc = "A powerful submachinegun chambered in .45 ACP, this weapon fires at a blistering rate with a heavy pistol cartridge, and can accept very high capacity magazines, to boot."
	icon_state = "tommygun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/tommygunm45
	init_mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	is_automatic = TRUE
	automatic = 1

/* * * * * * * * * * *
 * Whitelegs Thompson SMG
 * Tribal .45 SMG
 * .45ACP
 * More damage
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/tommygun/whitelegs
	name = "Storm Drum"
	desc = "A recovered ancient Thompson from an armory far up North. Commonly used by raiders of the White Legs tribe."
	mag_type = /obj/item/ammo_box/magazine/tommygunm45

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

/* * * * * * * * * * *
 * P90c SMG
 * Light 10mm SMG
 * 10mm
 * Huge magazine
 * Less damage
 * One-handed
 * Akimbo!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/p90
	name = "FN P90c"
	desc = "The Fabrique Nationale P90c was just coming into use at the time of the war. The weapon's bullpup layout, and compact design, make it easy to control. The durable P90c is prized for its reliability, and high firepower in a ruggedly-compact package. Chambered in 10mm."
	icon_state = "p90"
	item_state = "m90"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m10mm_p90

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_suppress = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

/* * * * * * * * * * *
 * Worn P90c SMG
 * Light 10mm SMG
 * 10mm
 * Huge magazine
 * Even Less damage
 * Less accurate
 * One-handed
 * Akimbo!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/p90/worn
	name = "Worn FN P90c"
	desc = "A FN P90 manufactured by Fabrique Nationale. This one is beat to hell but still works."

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE

/* * * * * * * * * * *
 * MP-5 SD SMG
 * Silent 9mm SMG
 * 9mm
 * Quiet
 * Accurate
 * Slightly more damage
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/mp5
	name = "MP-5 SD"
	desc = "An integrally suppressed submachinegun chambered in 9mm."
	icon_state = "mp5"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm

	slowdown = GUN_SLOWDOWN_SMG_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	can_suppress = FALSE
	can_unsuppress = FALSE
	fire_sound = 'sound/weapons/Gunshot_silenced.ogg'

/* * * * * * * * * * *
 * PPSh SMG
 * Spraycan 9mm SMG
 * 9mm
 * Huge magazine
 * Low damage
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/ppsh
	name = "Ppsh-41"
	desc = "An extremely fast firing, inaccurate submachine gun from World War 2. Low muzzle velocity. Uses 9mm rounds."
	icon_state = "pps"
	slowdown = 0.3
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/pps9mm

	slowdown = GUN_SLOWDOWN_SMG_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_SMG_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTEST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 9
	scope_y_offset = 21

/* * * * * * *
 * Carbines  *
 * * * * * * */

/* * * * * * * * * * *
 * Pistols, but longer
 * Two handed
 * Generally good accuracy
 * Lower recoil
 * Slightly higher damage
 * Common
 * * * * * * * * * * */

/* * * * * * * * * * *
 * M1 Carbine
 * 10mm
 * Can take extendomags
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1carbine
	name = "M1 carbine"
	desc = "The M1 Carbine was mass produced during some old war, and at some point NCR found stockpiles and rechambered them to 10mm to make up for the fact their service rifle production can't keep up with demand."
	icon_state = "m1carbine"
	item_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv

	slowdown = GUN_SLOWDOWN_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_CARBINE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	automatic_burst_overlay = FALSE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 5
	scope_y_offset = 14
	can_attachments = TRUE
	can_automatic = TRUE
	semi_auto = TRUE
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/* * * * * * * * * * *
 * M1/N Carbine
 * 10mm
 * Higher damage
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1carbine/m1n
	name = "M1/N carbine"
	desc = "An M1 Carbine with markings identifying it as issued to the NCR Mojave Expedtionary Force. Looks beat up but functional."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "ncr-m1carbine"
	item_state = "rifle"

	slowdown = GUN_SLOWDOWN_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_CARBINE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

/* * * * * * * * * * *
 * M1A1 Carbine
 * 10mm
 * Folds up!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1carbine/compact
	name = "M1A1 carbine"
	desc = "The M1A1 carbine is an improvement of the original, with this particular model having a folding stock allowing for greater mobility. Chambered in 10mm."
	icon_state = "m1a1carbine"
	var/stock = FALSE
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_CARBINE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

/obj/item/gun/ballistic/automatic/m1carbine/compact/AltClick(mob/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	toggle_stock(user)

/obj/item/gun/ballistic/automatic/m1carbine/compact/examine(mob/user)
	. = ..()
	. += "<br><span class='notice'>The stock is [stock ? "open" : "folded"].</span>"
	. += "<br><span class='notice'>Alt-click to toggle the stock.</span>"

/obj/item/gun/ballistic/automatic/m1carbine/compact/proc/toggle_stock(mob/living/user)
	stock = !stock
	if(stock)
		w_class = WEIGHT_CLASS_BULKY
		to_chat(user, "You unfold the stock.")
		spread = GUN_SPREAD_ACCURATE
	else
		w_class = WEIGHT_CLASS_NORMAL
		to_chat(user, "You fold the stock.")
		spread = GUN_SPREAD_AWFUL
	update_icon()

/obj/item/gun/ballistic/automatic/m1carbine/compact/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"][stock ? "" : "-f"]"

/* * * * * * * * * * *
 * De Lisle Carbine
 * Silent 9mm carbine
 * Silent!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/delisle
	name = "De Lisle carbine"
	desc = "A integrally suppressed carbine, known for being one of the quietest firearms ever made. Chambered in 9mm."
	icon_state = "delisle"
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m9mmds

	slowdown = GUN_SLOWDOWN_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_CARBINE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_scope = TRUE
	can_unsuppress = FALSE
	suppressed = 1
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * Commando Carbine
 * Silent .45 carbine
 * Silent!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/delisle/commando
	name = "commando carbine"
	desc = "A integrally suppressed carbine, known for being one of the quietest firearms ever made. This modified version is often used by the Brotherhood of Steel. Its stock has been replaced by post-war polymer furniture, with space to mount a scope. Chambered in .45 ACP."
	icon_state = "commando"
	item_state = "commando"
	mag_type = /obj/item/ammo_box/magazine/m45exp

	slowdown = GUN_SLOWDOWN_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_CARBINE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	suppressed = 1
	can_scope = TRUE
	semi_auto = TRUE
	automatic_burst_overlay = FALSE
	scope_state = "scope_medium"
	scope_x_offset = 6
	scope_y_offset = 14


/* * * * * * * * * * *
 * Combat Carbine
 * Baseline .45 carbine
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/combat
	name = "Combat Carbine"
	desc = "A .45 semi-automatic combat carbine, produced pre-war for National Guard forces."
	icon_state = "combat_rifle"
	item_state = "combatrifle"
	icon_prefix = "combatrifle"
	mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick

	slowdown = GUN_SLOWDOWN_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_CARBINE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_attachments = FALSE
	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	fire_sound = 'sound/f13weapons/combatrifle.ogg'

/* * * * * * * * * * *
 * Semi-auto Rifles  *
 * * * * * * * * * * */

/* * * * * * * * * * *
 * Long arms
 * Two handed
 * Generally good accuracy
 * Lower recoil
 * Common
 * * * * * * * * * * */

/* * * * * * * * * * *
 * Varmint Rifle
 * Light semi-auto rifle
 * .223 / 5.56mm
 * Slow to fire
 * 
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/varmint
	name = "varmint rifle"
	desc = "A simple bolt action rifle in 5.56mm calibre. Easy to use and maintain."
	icon_state = "varmint"
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/small

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_bayonet = FALSE
	semi_auto = TRUE
	automatic_burst_overlay = FALSE
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	can_scope = TRUE

/* * * * * * * * * * *
 * Verminkiller Rifle
 * Tricked out semi-auto rifle
 * .223 / 5.56mm
 * Scoped
 * Silent
 * More damage 
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/varmint/verminkiller
	name = "verminkiller rifle"
	desc = "Legends are told of the \"Ratslayer\", a custom-made souped-up varmint rifle with a sick paintjob. This is a pale imitation, made of chopped-up bits of other guns."
	icon_state = "verminrifle"
	item_state = "ratslayer"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

	suppressed = 1
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_unsuppress = FALSE
	suppressor_state = "none"
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * Ratslayer Rifle
 * Tricked out semi-auto rifle
 * .223 / 5.56mm
 * Scoped
 * Silent
 * More damage 
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/varmint/ratslayer
	name = "Ratslayer"
	desc = "A modified varmint rifle with better stopping power, a scope, and suppressor. Oh, don't forget the sick paint job."
	icon_state = "ratslayer"
	item_state = "ratslayer"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

	suppressed = 1
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * Service Rifle
 * Baseline semi-auto rifle
 * .223 / 5.56mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/service
	name = "service rifle"
	desc = "A 5.56x45 semi-automatic service rifle manufactured by the NCR and issued to all combat personnel."
	icon_state = "service_rifle"
	item_state = "servicerifle"
	icon_prefix = "servicerifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_attachments = TRUE
	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/* * * * * * * * * * *
 * ALR15 Rifle
 * Tacticool semi-auto rifle
 * .223 / 5.56mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/service/alr
	name = "ALR15"
	desc = "A 5.56x45mm rifle custom built off of a reproduction model AR15-style weapon. Sports a fancy holographic sight picture, forward grip, and a comfortable synthetic thumbhole stock. Bang bang."
	icon_state = "alr15"
	item_state = "alr15"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_attachments = FALSE
	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/* * * * * * * * * * *
 * Scout carbine
 * Scopeable semi-auto rifle
 * .223 / 5.56mm
 * Scope!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/service/carbine
	name = "scout carbine"
	desc = "A cut down version of the standard-issue service rifle tapped with mounting holes for a scope. Shorter barrel, lower muzzle velocity."
	icon_state = "scout_carbine"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_scope = TRUE
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 15
	suppressor_x_offset = 26
	suppressor_y_offset = 28

/* * * * * * * * * * *
 * Marksman carbine
 * Scoped semi-auto rifle
 * .223 / 5.56mm
 * Scope!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/marksman
	name = "marksman carbine"
	desc = "A marksman carbine built off the AR platform chambered in 5.56x45. Seen heavy usage in pre-war conflicts. This particular model is a civilian version and is semi-auto only."
	icon_state = "marksman_rifle"
	item_state = "marksman"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_attachments = TRUE
	semi_auto = TRUE
	automatic_burst_overlay = FALSE
	can_scope = FALSE
	zoomable = TRUE
	zoom_amt = 6
	zoom_out_amt = 9
	can_bayonet = FALSE
	bayonet_state = "rifles"
	knife_x_offset = 22
	knife_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "suppressor"
	suppressor_x_offset = 31
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/marksman_rifle.ogg'

/* * * * * * * * * * *
 * Police Rifle
 * Cool semi-auto rifle
 * .223 / 5.56mm
 * Scope!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/marksman/policerifle
	name = "Police Rifle"
	desc = "A pre-war Rifle that has been constantly repaired and rebuilt by the Oasis Police Department. Held together by duct tape and prayers, it somehow still shoots."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_prefix = "assault_carbine"
	icon_state = "rifle-police"
	item_state = "assault_carbine"
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_suppress = FALSE
	can_scope = TRUE
	zoomable = FALSE

/* * * * * * * * * * *
 * Rangemaster Rifle
 * Baseline semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/rangemaster
	name = "Colt Rangemaster"
	desc = "A Colt Rangemaster semi-automatic rifle, chambered for 7.62x51. Single-shot only."
	icon_state = "rangemaster"
	item_state = "308"
	icon_prefix = "308"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/m762

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_attachments = TRUE
	can_scope = TRUE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 21
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 11
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/* * * * * * * * * * *
 * Enfield SLR Rifle
 * Baseline semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/slr
	name = "Enfield SLR"
	desc = "A self-loading rifle in 7.62mm NATO. Semi-auto only."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "slr"
	item_state = "slr"
	mag_type = /obj/item/ammo_box/magazine/m762

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_attachments = TRUE
	can_scope = TRUE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 21
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 11
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/* * * * * * * * * * *
 * M1 Garand Rifle
 * Heavy semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * More damage
 * Scope!
 * Bayonet!
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1garand
	name = "M1 Garand"
	desc = "The WWII American Classic. Still has that satisfiying ping."
	icon_state = "m1garand"
	item_state = "rifle"
	icon_prefix = "308"
	mag_type = /obj/item/ammo_box/magazine/garand308

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	en_bloc = 1
	auto_eject = 1
	semi_auto = TRUE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 5
	scope_y_offset = 14
	auto_eject_sound = 'sound/f13weapons/garand_ping.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/m1garand/update_icon()
	..()
	icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/automatic/m1garand/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return

/* * * * * * * * * * *
 * Old Glory Rifle
 * Heavier semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Even more damage
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1garand/oldglory
	name = "Old Glory"
	desc = "This Machine kills communists!"
	icon_state = "oldglory"

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE

/* * * * * * * * * * *
 * Republic's Pride Rifle
 * Heavy semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * More damage
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1garand/republicspride
	name = "Republic's Pride"
	desc = "A well-tuned scoped M1C rifle crafted by master gunsmith from the Gunrunners. Chambered in 7.62x51."
	icon_state = "republics_pride"
	item_state = "scoped308"

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_delay = 0.5
	can_scope = FALSE

/* * * * * * * * * * *
 * SKS Rifle
 * Soviet semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1garand/sks
	name = "SKS"
	desc = "Old hunting rifle taken from disovered stockpiles and refurbished in Phoenix workshops. The standard heavy rifle of the Legion, still rare. .308, semi-auto only, internal magazine."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "sks"
	item_state = "sks"
	mag_type = /obj/item/ammo_box/magazine/sks

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 23
	scope_state = "scope_mosin"
	scope_x_offset = 4
	scope_y_offset = 12
	auto_eject_sound = 'sound/weapons/magout.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/* * * * * * * * * * *
 * Sniper Rifle
 * Sniper semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Sloooow to fire
 * Lot more damage
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/marksman/sniper
	name = "sniper rifle"
	desc = "A DKS 501, chambered in .308 Winchester.  With a light polymer body, it's suited for long treks through the desert."
	icon_prefix = "sniperrifle"
	icon_state = "sniper_rifle"
	item_state = "sniper_rifle"
	mag_type = /obj/item/ammo_box/magazine/w308

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T4
	cock_delay = GUN_COCK_RIFLE_BASE

	zoom_amt = 10
	zoom_out_amt = 13
	semi_auto = TRUE
	can_automatic = FALSE
	can_bayonet = FALSE
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/* * * * * * * * * * *
 * Gold Sniper Rifle
 * Pretty Sniper semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Stylish!
 * Scope!
 * Bayonet!
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/marksman/sniper/gold
	name = "golden sniper rifle"
	desc = "A DKS 501, chambered in .308 Winchester. This one has a gold trim and the words 'Old Cassius' engraved into the stock."
	icon_state = "gold_sniper"
	item_state = "gold_sniper"

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T4
	cock_delay = GUN_COCK_RIFLE_BASE

/* * * * * * * * * * *
 * Explorer Sniper Rifle
 * Legion Sniper semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Less damage
 * Less slowdown
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/marksman/sniper/snipervenator
	name = "Explorer sniper rifle"
	desc = "The customized sniper rifle, fitted with a telescopic sight for extreme accuracy and chambered for a high-ballistic performance centerfire cartridge. It is a superior version of the regular sniper rifle and is decorated with the flag of the bull and tokens of a hunt."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "venator_sniper"
	item_state = "venator_sniper"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	zoom_amt = 8
	zoom_out_amt = 8

/* * * * * * * * * * *
 * Compact Sniper Rifle
 * Sniper semi-auto 7.62mm rifle
 * .308 / 7.62mm
 * Less damage
 * Less slowdown
 * Scope!
 * Bayonet!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/marksman/sniper/sniperranger
	name = "compact sniper rifle"
	desc = "A DKS 501, chambered in .308 Winchester.  With a light polymer body, it's suited for long treks through the desert. This particular model is lighter and faster."

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_SEMI
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

/* * * * * * * * * * *
 * Automatic Rifles  *
 * * * * * * * * * * */

/* * * * * * * * * * *
 * Long rifles, but faster
 * Two handed
 * Generally poor accuracy
 * Lot more recoil
 * Lot harder to control
 * Deadly in the right hands
 * Common
 * * * * * * * * * * */

/* * * * * * * * * * *
 * R82 heavy service rifle
 * Baseline 5.56mm autorifle
 * .223 / 5.56mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/service/r82
	name = "R82 heavy service rifle"
	desc = "The assault rifle variant of the R84, based off the pre-war FN FNC. Issued to high-ranking troopers and specialized units. Chambered in 5.56."
	icon_state = "R82"
	item_state = "R84"
	icon_prefix = "r82"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 28

/* * * * * * * * * * *
 * R91 assault rifle
 * Baseline 5.56mm autorifle
 * .223 / 5.56mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/assault_rifle
	name = "r91 assault rifle"
	desc = "The R91 was the standard US Army assault rifle, and so saw wide-spread use after the war. Most are worn out by now."
	icon_state = "assault_rifle"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	can_bayonet = FALSE
	bayonet_state = "rifles"
	knife_x_offset = 23
	knife_y_offset = 11
	can_suppress = TRUE
	suppressor_x_offset = 32
	suppressor_y_offset = 15
	suppressor_state = "ar_suppressor"
	actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/* * * * * * * * * * *
 * Infiltrator service rifle
 * Quiet 5.56mm autorifle
 * .223 / 5.56mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	name = "infiltrator"
	desc = "A customized R91 assault rifle, with an integrated suppressor, small scope, cut down stock and polymer furniture."
	icon_state = "infiltrator"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_suppress = FALSE
	can_unsuppress = FALSE
	suppressed = 1
	can_bayonet = FALSE
	can_scope = FALSE
	zoomable = TRUE
	zoom_amt = 6
	zoom_out_amt = 9
	actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * R93 PDW rifle
 * Baseline 5.56mm autorifle
 * .223 / 5.56mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/r93
	name = "R93 PDW"
	desc = "A lightweight assault rifle manufactured by the Brotherhood of Steel with a folding stock, based on weapons from the R-series platforms. It is generally issued to Brotherhood Knights for scouting missions."
	icon_state = "r93"
	item_state = "r93"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_attachments = FALSE
	semi_auto = TRUE
	automatic_burst_overlay = FALSE
	can_scope = FALSE
	zoomable = TRUE
	zoom_amt = 6
	zoom_out_amt = 9
	can_bayonet = FALSE
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * Type 93 assault rifle
 * Chinese 5.56mm autorifle
 * .223 / 5.56mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/type93
	name = "type 93 assault rifle"
	desc = "The Type 93 Chinese assault rifle was designed and manufactured by a Chinese industrial conglomerate for the People's Liberation Army during the Resource Wars, for the purpose of equipping the Chinese infiltrators and American fifth-columnists. Chambered in 5.56x45."
	icon_state = "type93"
	item_state = "handmade_rifle"
	icon_prefix = "handmade_rifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 27
	actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/* * * * * * * * * * *
 * Worn Type 93 assault rifle
 * Chinese 5.56mm autorifle
 * .223 / 5.56mm
 * Less damage
 * Less accuracy
 * Slower to shoot
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/type93/worn //24dmg
	name = "\improper Worn Type 93"
	desc = "This Type 93 Chinese assault rifle looks like it has been made in a garage. The bore is shot to hell, the threading is destroyed, but atleast it works."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "type93"
	item_state = "handmade_rifle"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

	can_suppress = FALSE

/* * * * * * * * * * *
 * BOZAR
 * Heavy 5.56mm autorifle
 * .223 / 5.56mm
 * More damage
 * More accurate
 * Scope!
 * Slower to shoot
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/bozar
	name = "Bozar"
	desc = "The ultimate refinement of the sniper's art, the Bozar is a scoped, accurate, light machine gun that will make nice big holes in your enemy. Uses 5.56."
	icon_state = "bozar"
	item_state = "sniper"
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = FALSE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/bozar_fire.ogg'

/* * * * * * * * * * *
 * Assault Carbine Rifle
 * Baseline 5mm autorifle
 * 5mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/assault_carbine
	name = "assault carbine"
	desc = "The U.S. army carbine version of the R91, made by Colt and issued to special forces."
	icon_state = "assault_carbine"
	item_state = "assault_carbine"
	icon_prefix = "assault_carbine"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m5mm

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	can_scope = TRUE
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 15
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 28
	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 21
	flight_y_offset = 21
	actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/f13weapons/assault_carbine.ogg'

/* * * * * * * * * * *
 * Police Assault Rifle
 * Baseline 5mm autorifle
 * 5mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/assault_carbine/policerifle
	name = "Police Assault Rifle"
	desc = "A pre-war Rifle that has been constantly repaired and rebuilt by the Oasis Police Department. Held together by duct tape and prayers, it somehow still shoots."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "rifle-police"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	can_scope = TRUE

/* * * * * * * * * * *
 * Police Assault Rifle
 * Baseline 5mm autorifle
 * 5mm
 * Less damage
 * Less accurate
 * Slower to shoot
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/assault_carbine/worn
	name = "worn assault carbine"
	desc = "The U.S. army carbine version of the R91, made by Colt and issued to special forces. This one is beat-up and falling apart."
	icon_state = "assault_carbine"

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE

/* * * * * * * * * * *
 * FN FAL Rifle
 * Baseline 7.62 autorifle
 * .308 / 7.62
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/fnfal
	name = "FN FAL"
	desc = "This rifle has been more widely used by armed forces than any other rifle in history. It's a reliable assault weapon for any terrain or tactical situation."
	icon_state = "fnfal"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m762

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/* * * * * * * * * * *
 * Browning Automatic BAR Rifle
 * Baseline 7.62 autorifle
 * .308 / 7.62
 * Uncommon
 * * * * * * * * * * */

obj/item/gun/ballistic/automatic/bar
	name = "automatic rifle (.308)"
	desc = "An ancient machine gun that looks like outdated even by pre-war standards. It has Colt etched on one-side and Sierra Madre on the other. It is alarmingly heavy for a rifle."
	icon = 'icons/fallout/objects/guns/bar.dmi'
	slot_flags = ITEM_SLOT_BACK
	icon_state = "BAR"
	item_state = "BAR"
	icon_prefix = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m762/ext

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	automatic = 1
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/* * * * * * * * * * *
 * G11 Rifle
 * Fancy 4.73mm autorifle
 * 4.73mm caseless
 * Fast firing!
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/g11
	name = "G11"
	desc = "This experimental gun fires a caseless cartridge consisting of a block of propellant with a bullet buried inside. The weight and space savings allows for a very high magazine capacity. Chambered in 4.73mm."
	icon_state = "g11"
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/m473

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTEST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = TRUE
	semi_auto = TRUE
	can_scope = FALSE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	actions_types = list(/datum/action/item_action/toggle_firemode)
	select = 0

/* * * * * * * * * * *
 * WT-550 Carbine
 * 4.73mm caseless
 * Spaceman gun
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/wt550
	name = "4.73mm carbine"
	desc = "A WT-550 Personal Defense Weapon, manufactured by West Tek. It fires 4.73mm caseless rounds."
	item_state = "m90"
	icon_state = "WT550"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m473/small

	slowdown = GUN_SLOWDOWN_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_CARBINE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = TRUE
	can_bayonet = TRUE
	knife_x_offset = 25
	knife_y_offset = 12

/* * * * *
 * LMGs  *
 * * * * */

/* * * * * * * * * * *
 * Automatic rifles, but bigger
 * Two handed
 * Generally poor accuracy
 * Lot more recoil
 * Lot harder to control
 * Deadly in the right hands
 * Quick to cool down recoil
 * Rare
 * * * * * * * * * * */

/* * * * * * * * * * *
 * R84 LMG
 * Baseline 5.56mm LMG
 * .223 / 5.56mm
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/r84
	name = "R84 LMG"
	desc = "A light machinegun using 60 round belts fed from an ammobox, its one of the few heavy weapons designs NCR has produced."
	icon_state = "R84"
	item_state = "R84"
	mag_type = /obj/item/ammo_box/magazine/lmg

	slowdown = GUN_SLOWDOWN_RIFLE_LMG
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LMG
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = FALSE
	actions_types = null
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/* * * * * * * * * * *
 * LSW LMG
 * Mobile 5.56mm LMG
 * .223 / 5.56mm
 * Lighter!
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/lsw
	name = "Light Support Weapon"
	desc = "This squad-level support weapon has a bullpup design. The bullpup design makes it difficult to use while lying down. Because of this it was remanded to National Guard units. It, however, earned a reputation as a reliable weapon that packs a lot of punch for its size."
	icon = 'icons/obj/guns/projectile.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "lsw"
	item_state = "lsw"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 0.8
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LMG
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	spawnwithmagazine = TRUE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_attachments = TRUE
	can_scope = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/* * * * * * * * * * *
 * Browning M1919 MMG
 * Big 7.62mm LMG
 * .308 / 7.62mm
 * The big gun
 * Terrible overall
 * Except that it shoots a lot of 7.62
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1919
	name = "Browning M1919"
	desc = "This ancient machine gun has been dug up and put into working order by the Legion Forgemasters. It's loud, heavy and terrifying."
	icon_state = "M38"
	item_state = "M38"
	slot_flags = 0
	slowdown = 1.25
	mag_type = /obj/item/ammo_box/magazine/mm762

	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG * 2
	recoil_multiplier = GUN_RECOIL_RIFLE_LMG * 2
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL * 2
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	automatic = 1
	can_attachments = FALSE
	var/cover_open = FALSE
	var/require_twohands = FALSE
	actions_types = null
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/m1919/update_icon()
	icon_state = "M38[cover_open ? "open" : "closed"][magazine ? CEILING(get_ammo(0)/20, 1)*20 : "-empty"]"
	item_state = "M38[cover_open ? "open" : "closed"][magazine ? "mag" : "nomag"]"

/obj/item/gun/ballistic/automatic/m1919/examine(mob/user)
	. = ..()
	if(cover_open && magazine)
		. += "<span class='notice'>It seems like you could use an <b>empty hand</b> to remove the magazine.</span>"

/obj/item/gun/ballistic/automatic/m1919/attack_self(mob/user)
	cover_open = !cover_open
	to_chat(user, "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>")
	if(cover_open)
		playsound(user, 'sound/weapons/sawopen.ogg', 60, 1)
	else
		playsound(user, 'sound/weapons/sawclose.ogg', 60, 1)
	update_icon()

/obj/item/gun/ballistic/automatic/m1919/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is open! Close it before firing!</span>")
	else
		. = ..()
		update_icon()

/obj/item/gun/ballistic/automatic/m1919/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc != user)
		..()
		return	//let them pick it up
	if(!cover_open || (cover_open && !magazine))
		..()
	else if(cover_open && magazine)
		//drop the mag
		magazine.update_icon()
		magazine.forceMove(drop_location())
		user.put_in_hands(magazine)
		magazine = null
		update_icon()
		to_chat(user, "<span class='notice'>You remove the magazine from [src].</span>")
		playsound(user, 'sound/weapons/magout.ogg', 60, 1)

/obj/item/gun/ballistic/automatic/m1919/attackby(obj/item/A, mob/user, params)
	if(!cover_open && istype(A, mag_type))
		to_chat(user, "<span class='warning'>[src]'s cover is closed! You can't insert a new mag.</span>")
		return
	..()



////////
//MISC//
////////

/* * * * * * * * * * *
 * M72 Gauss Rifle
 * Biggest Baddest Superrifle
 * 2mmEC
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m72
	name = "\improper M72 gauss rifle"
	desc = "The M72 rifle is of German design. It uses an electromagnetic field to propel rounds at tremendous speed... and pierce almost any obstacle. Its range, accuracy and stopping power is almost unparalleled."
	icon_state = "m72"
	item_state = "sniper"
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/m2mm

	slowdown = GUN_SLOWDOWN_RIFLE_GAUSS
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_GAUSS
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	recoil = 2
	semi_auto = TRUE
	fire_sound = 'sound/f13weapons/gauss_rifle.ogg'

/* * * * * * * * * * *
 * xl70e3
 * Fancy 5.56mm autorifle
 * .308 / 5.56mm
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/xl70e3
	name = "xl70e3"
	desc = "This was an experimental weapon at the time of the war. Manufactured, primarily, from high-strength polymers, the weapon is almost indestructible. It's light, fast firing, accurate, and can be broken down without the use of any tools. Chamebered in 5.56mm."
	icon_state = "xl70e3"
	item_state = "xl70e3"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_AUTO
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE

	is_automatic = TRUE
	spawnwithmagazine = TRUE
	can_attachments = TRUE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE

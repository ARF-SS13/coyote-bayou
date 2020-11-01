/obj/item/gun/ballistic/automatic
	w_class = WEIGHT_CLASS_NORMAL
	var/alarmed = 0
	var/select = 1
	var/automatic_burst_overlay = TRUE
	can_suppress = TRUE
	burst_size = 3
	burst_shot_delay = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/gun/ballistic/automatic/proto
	name = "\improper Nanotrasen Saber SMG"
	desc = "A prototype three-round burst 9mm submachine gun, designated 'SABR'. Has a threaded barrel for suppressors."
	icon_state = "saber"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm
	pin = null

/obj/item/gun/ballistic/automatic/proto/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/update_overlays()
	. = ..()
	if(automatic_burst_overlay)
		if(!select)
			. += ("[initial(icon_state)]semi")
		if(select == 1)
			. += "[initial(icon_state)]burst"

/obj/item/gun/ballistic/automatic/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

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
		burst_select()
	else
		return ..()

/obj/item/gun/ballistic/automatic/proc/burst_select()
	var/mob/living/carbon/human/user = usr
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

/obj/item/gun/ballistic/automatic/proc/enable_burst()
	burst_size = initial(burst_size)

/obj/item/gun/ballistic/automatic/proc/disable_burst()
	burst_size = 1

/obj/item/gun/ballistic/automatic/can_shoot()
	return get_ammo()

/obj/item/gun/ballistic/automatic/proc/empty_alarm()
	if(!chambered && !get_ammo() && !alarmed)
		playsound(src.loc, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
		update_icon()
		alarmed = 1
	return

/obj/item/gun/ballistic/automatic/c20r
	name = "\improper C-20r SMG"
	desc = "A bullpup two-round burst .45 SMG, designated 'C-20r'. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp."
	icon_state = "c20r"
	item_state = "c20r"
	mag_type = /obj/item/ammo_box/magazine/smgm45
	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	burst_shot_delay = 2
	burst_size = 2
	pin = /obj/item/firing_pin/implant/pindicate
	can_bayonet = TRUE
	knife_x_offset = 26
	knife_y_offset = 12

/obj/item/gun/ballistic/automatic/c20r/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/c20r/Initialize()
	. = ..()
	update_icon()

/obj/item/gun/ballistic/automatic/c20r/afterattack()
	. = ..()
	empty_alarm()

/obj/item/gun/ballistic/automatic/c20r/update_icon_state()
	icon_state = "c20r[magazine ? "-[CEILING(get_ammo(0)/4, 1)*4]" : ""][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/wt550
	name = "security semi-auto smg"
	desc = "An outdated personal defence weapon. Uses 4.6x30mm rounds and is designated the WT-550 Semi-Automatic SMG."
	icon_state = "wt550"
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/wt550m9
	can_suppress = FALSE
	burst_size = 2
	burst_shot_delay = 1
	can_bayonet = TRUE
	knife_x_offset = 25
	knife_y_offset = 12
	automatic_burst_overlay = FALSE

/obj/item/gun/ballistic/automatic/wt550/enable_burst()
	. = ..()
	spread = 15

/obj/item/gun/ballistic/automatic/wt550/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/wt550/update_icon_state()
	icon_state = "wt550[magazine ? "-[CEILING(((get_ammo(FALSE) / magazine.max_ammo) * 20) /4, 1)*4]" : "-0"]" //Sprites only support up to 20.

/obj/item/gun/ballistic/automatic/mini_uzi
	name = "\improper Type U3 Uzi"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "mini-uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	burst_size = 2

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
	burst_size = 3
	burst_shot_delay = 2
	pin = /obj/item/firing_pin/implant/pindicate

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

/obj/item/gun/ballistic/automatic/tommygun
	name = "\improper Thompson SMG"
	desc = "Based on the classic 'Chicago Typewriter'."
	icon_state = "tommygun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/tommygunm45
	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	can_suppress = FALSE
	burst_size = 4
	burst_shot_delay = 1

/obj/item/gun/ballistic/automatic/ar
	name = "\improper NT-ARG 'Boarder'"
	desc = "A robust assault rifle used by Nanotrasen fighting forces."
	icon_state = "arg"
	item_state = "arg"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m556
	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	can_suppress = FALSE
	burst_size = 3
	burst_shot_delay = 1

// Bulldog shotgun //

/obj/item/gun/ballistic/automatic/shotgun/bulldog
	name = "\improper Bulldog Shotgun"
	desc = "A semi-auto, mag-fed shotgun for combat in narrow corridors, nicknamed 'Bulldog' by boarding parties. Compatible only with specialized 8-round drum magazines."
	icon_state = "bulldog"
	item_state = "bulldog"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	mag_type = /obj/item/ammo_box/magazine/m12g
	fire_sound = 'sound/weapons/gunshot.ogg'
	automatic_burst_overlay = FALSE
	can_suppress = FALSE
	burst_size = 1
	pin = /obj/item/firing_pin/implant/pindicate
	actions_types = list()

/obj/item/gun/ballistic/automatic/shotgun/bulldog/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/shotgun/bulldog/Initialize()
	. = ..()
	update_icon()

/obj/item/gun/ballistic/automatic/shotgun/bulldog/update_icon_state()
	return

/obj/item/gun/ballistic/automatic/shotgun/bulldog/update_overlays()
	. = ..()
	if(magazine)
		. += "[magazine.icon_state]"
	icon_state = "bulldog[chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/shotgun/bulldog/afterattack()
	. = ..()
	empty_alarm()
	return

// L6 SAW //

/obj/item/gun/ballistic/automatic/lmg
	name = "\improper L6 SAW"
	desc = "A heavily modified 1.95x129mm light machine gun, designated 'L6 SAW'. Has 'Aussec Armoury - 2531' engraved on the receiver below the designation."
	icon_state = "l6closed100"
	item_state = "l6closedmag"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/mm195x129
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	var/cover_open = FALSE
	can_suppress = FALSE
	burst_size = 3
	burst_shot_delay = 1
	spread = 7
	automatic_burst_overlay = FALSE

/obj/item/gun/ballistic/automatic/lmg/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/lmg/examine(mob/user)
	. = ..()
	if(cover_open && magazine)
		. += "<span class='notice'>It seems like you could use an <b>empty hand</b> to remove the magazine.</span>"

/obj/item/gun/ballistic/automatic/lmg/attack_self(mob/user)
	cover_open = !cover_open
	to_chat(user, "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>")
	if(cover_open)
		playsound(user, 'sound/weapons/sawopen.ogg', 60, 1)
	else
		playsound(user, 'sound/weapons/sawclose.ogg', 60, 1)
	update_icon()

/obj/item/gun/ballistic/automatic/lmg/update_icon_state()
	icon_state = "l6[cover_open ? "open" : "closed"][magazine ? CEILING(get_ammo(0)/12.5, 1)*25 : "-empty"][suppressed ? "-suppressed" : ""]"
	item_state = "l6[cover_open ? "openmag" : "closedmag"]"

/obj/item/gun/ballistic/automatic/lmg/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is open! Close it before firing!</span>")
	else
		. = ..()
		update_icon()

/obj/item/gun/ballistic/automatic/lmg/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
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

/obj/item/gun/ballistic/automatic/lmg/attackby(obj/item/A, mob/user, params)
	if(!cover_open && istype(A, mag_type))
		to_chat(user, "<span class='warning'>[src]'s cover is closed! You can't insert a new mag.</span>")
		return
	..()

// SNIPER //

/obj/item/gun/ballistic/automatic/sniper_rifle
	name = "sniper rifle"
	desc = "A long ranged weapon that does significant damage. No, you can't quickscope."
	icon_state = "sniper"
	item_state = "sniper"
	recoil = 2
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 40
	burst_size = 1
	can_unsuppress = TRUE
	can_suppress = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	inaccuracy_modifier = 0.5
	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 13
	slot_flags = ITEM_SLOT_BACK
	automatic_burst_overlay = FALSE
	actions_types = list()

/obj/item/gun/ballistic/automatic/sniper_rifle/update_icon_state()
	if(magazine)
		icon_state = "sniper-mag"
	else
		icon_state = "sniper"

/obj/item/gun/ballistic/automatic/sniper_rifle/syndicate
	name = "syndicate sniper rifle"
	desc = "An illegally modified .50 cal sniper rifle with suppression compatibility. Quickscoping still doesn't work."
	pin = /obj/item/firing_pin/implant/pindicate

// Old Semi-Auto Rifle //

/obj/item/gun/ballistic/automatic/surplus
	name = "Surplus Rifle"
	desc = "One of countless obsolete ballistic rifles that still sees use as a cheap deterrent. Uses 10mm ammo and its bulky frame prevents one-hand firing."
	icon_state = "surplus"
	item_state = "moistnugget"
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/m10mm/rifle
	fire_delay = 30
	burst_size = 1
	can_unsuppress = TRUE
	can_suppress = TRUE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	automatic_burst_overlay = FALSE
	actions_types = list()

/obj/item/gun/ballistic/automatic/surplus/update_icon_state()
	if(magazine)
		icon_state = "surplus"
	else
		icon_state = "surplus-e"

// Laser rifle (rechargeable magazine) //

/obj/item/gun/ballistic/automatic/laser
	name = "laser rifle"
	desc = "Though sometimes mocked for the relatively weak firepower of their energy weapons, the logistic miracle of rechargeable ammunition has given Nanotrasen a decisive edge over many a foe."
	icon_state = "oldrifle"
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/recharge
	automatic_burst_overlay = FALSE
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1
	actions_types = list()
	fire_sound = 'sound/weapons/laser.ogg'
	casing_ejector = FALSE

/obj/item/gun/ballistic/automatic/laser/update_icon_state()
	icon_state = "oldrifle[magazine ? "-[CEILING(get_ammo(0)/4, 1)*4]" : ""]"

// Fallout 13 //

/obj/item/gun/ballistic/automatic/greasegun
	name = "m3a1 grease gun"
	desc = "An inexpensive submachine gun chambered in .45 ACP. Slow fire rate allows the operator conserve ammunition in controllable bursts."
	icon_state = "grease_gun"
	item_state = "smg9mm"
	mag_type = /obj/item/ammo_box/magazine/greasegun
	fire_sound = 'sound/f13weapons/greasegun.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	force = 15
	burst_size = 2
	fire_delay = 3
	burst_shot_delay = 3
	can_suppress = FALSE
	can_attachments = TRUE
	spawnwithmagazine = FALSE
	extra_damage = -5
	extra_penetration = -5

/obj/item/gun/ballistic/automatic/greasegun/enable_burst()
	. = ..()
	spread = 10

/obj/item/gun/ballistic/automatic/greasegun/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/smg10mm
	spawnwithmagazine = FALSE
	name = "10mm submachine gun"
	desc = "One of the most common personal-defense weapons of the Great War, a sturdy and reliable open-bolt 10mm submachine gun."
	icon_state = "smg10mm"
	item_state = "smg10mm"
	mag_type = /obj/item/ammo_box/magazine/m10mm_auto
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM //You should be able to dual-wield these.
	force = 15
	burst_size = 2
	fire_delay = 4
	burst_shot_delay = 3
	can_suppress = FALSE //we dont have sprites therefore cease
	can_attachments = TRUE
	spawnwithmagazine = FALSE
	extra_damage = -6
	extra_penetration = -6

/obj/item/gun/ballistic/automatic/smg10mm/enable_burst()
	. = ..()
	spread = 18

/obj/item/gun/ballistic/automatic/smg10mm/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/pps
	name = "ppsh-41"
	desc = "An extremely fast firing, inaccurate submachine gun from World War 2. Low muzzle velocity. Uses 9mm rounds."
	icon_state = "pps"
	mag_type = /obj/item/ammo_box/magazine/pps9mm
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_HEAVY
	force = 15
	burst_size = 3
	fire_delay = 6
	burst_shot_delay = 2
	can_suppress = FALSE
	can_attachments = TRUE
	spawnwithmagazine = FALSE
	extra_damage = -14
	extra_penetration = -5
	can_scope = TRUE
	scopestate = "AEP7_scope"
	scope_x_offset = 9
	scope_y_offset = 21

/obj/item/gun/ballistic/automatic/pps/enable_burst()
	. = ..()
	spread = 20

/obj/item/gun/ballistic/automatic/pps/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/mini_uzi
	name = "uzi"
	desc = "A lightweight, burst-fire submachien gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "mini-uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	force = 15
	burst_size = 2
	fire_delay = 5
	burst_shot_delay = 2
	can_suppress = FALSE
	can_attachments = TRUE
	spawnwithmagazine = FALSE
	extra_damage = -5
	extra_penetration = -5
	can_scope = TRUE
	scopestate = "AEP7_scope"
	scope_x_offset = 9
	scope_y_offset = 21

/obj/item/gun/ballistic/automatic/mini_uzi/enable_burst()
	. = ..()
	spread = 10

/obj/item/gun/ballistic/automatic/mini_uzi/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/assault_rifle
	name = "r91 assault rifle"
	desc = "A standard R91 assault rifle, out of use around the time of the Great War."
	icon_state = "assault_rifle"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	force = 25
	burst_size = 2
	fire_delay = 4
	burst_shot_delay = 3
	can_suppress = FALSE
	can_attachments = TRUE
	spawnwithmagazine = FALSE
	extra_damage = -6
	extra_penetration = -6
	can_bayonet = TRUE
	knife_x_offset = 23
	knife_y_offset = 11
	automatic = 1

/obj/item/gun/ballistic/automatic/assault_rifle/enable_burst()
	. = ..()
	spread = 8

/obj/item/gun/ballistic/automatic/assault_rifle/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	name = "infiltrator"
	desc = "A customized R91 assault rifle, with an integrated suppressor, cut down stock and polymer furniture."
	icon_state = "infiltrator"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	suppressed = 1
	fire_delay = 3
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'
	can_bayonet = FALSE
	force = 15

/obj/item/gun/ballistic/automatic/assault_rifle/enable_burst()
	. = ..()
	spread = 1

/obj/item/gun/ballistic/automatic/assault_rifle/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/service
	name = "service rifle"
	desc = "A 5.56x45 semi-automatic service rifle manufactured by the NCR and issued to all combat personnel."
	icon_state = "service_rifle"
	item_state = "servicerifle"
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 5
	extra_damage = -6
	extra_penetration = -6
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	spawnwithmagazine = FALSE
	can_bayonet = TRUE
	can_attachments = TRUE
	knife_x_offset = 22
	knife_y_offset = 12
	burst_size = 1
	automatic_burst_overlay = FALSE
	actions_types = list()
	automatic = 0

/obj/item/gun/ballistic/automatic/marksman
	name = "marksman carbine"
	desc = "A marksman carbine built off the AR platform chambered in 5.56x45. Seen heavy usage in pre-war conflicts. This particular model is a civilian version and lacks select fire.automatic = "
	icon_state = "marksman_rifle"
	item_state = "marksman"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_HEAVY
	fire_delay = 6
	can_attachments = TRUE
	spawnwithmagazine = FALSE
	can_bayonet = TRUE
	knife_x_offset = 22
	knife_y_offset = 12
	burst_size = 1
	automatic_burst_overlay = FALSE
	actions_types = list()
	automatic = 0
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13

/obj/item/gun/ballistic/automatic/varmint
	name = "varmint rifle"
	desc = "A low powered 5.56, easy to use rifle."
	icon_state = "varmint_rifle"
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	extra_damage = -7
	extra_penetration = -7
	fire_delay = 8
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	spawnwithmagazine = FALSE
	can_bayonet = FALSE
	can_suppress = TRUE
	can_attachments = TRUE
	burst_size = 1
	automatic_burst_overlay = FALSE
	actions_types = list()
	automatic = 0

/obj/item/gun/ballistic/automatic/varmint/ratslayer
	name = "Ratslayer"
	desc = "A modified varmint rifle with better stopping power, a scope, and suppressor. Oh, don't forget the sick paint job."
	icon_state = "rat_slayer"
	item_state = "ratslayer"
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'
	extra_damage = 0
	extra_penetration = 0
	suppressed = 1
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE
	suppressed = 1
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/bozar
	name = "Bozar"
	desc = "The ultimate refinement of the sniper's art, the Bozar is a scoped, accurate, light machine gun that will make nice big holes in your enemy. Uses 5.56."
	icon_state = "bozar"
	item_state = "sniper"
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	burst_size = 2
	fire_delay = 3
	automatic = 1
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'sound/f13weapons/bozar_fire.ogg'
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_attachments = TRUE
	can_scope = FALSE

/obj/item/gun/ballistic/automatic/rangemaster
	name = "colt rangemaster"
	desc = "A Colt Rangemaster semi-automatic rifle, chambered for 7.62x51. Single-shot only."
	icon_state = "rangemaster"
	item_state = "308"
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	mag_type = /obj/item/ammo_box/magazine/m762
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	fire_delay = 5
	extra_penetration = -10
	extra_damage = -10
	can_attachments = TRUE
	can_scope = TRUE
	can_bayonet = TRUE
//	bayonetstate = "lasmusket"
	spawnwithmagazine = FALSE
	knife_x_offset = 24
	knife_y_offset = 21
	burst_size = 1
	automatic_burst_overlay = FALSE
	actions_types = list()
	automatic = 0

/obj/item/gun/ballistic/automatic/rangemaster/scoped
	name = "scoped rangemaster"
	desc = "Nothing's better than seeing that surprised look on your target's face. The Loophole x20 Scope on this hunting rifle makes it easier than ever before. Accurate from first shot to last, no matter what kind of game you're gunning for."
	icon_state = "rangemaster"
	item_state = "scoped308"
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE

/obj/item/gun/ballistic/automatic/type93
	name = "type 93 assault rifle"
	desc = "The Type 93 Chinese assault rifle was designed and manufactured by a Chinese industrial conglomerate for the People's Liberation Army during the Resource Wars, for the purpose of equipping the Chinese infiltrators and American fifth-columnists. Chambered in 5.56x45."
	icon_state = "type93"
	item_state = "handmade_rifle"
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	burst_size = 2
	fire_delay = 3
	spread = 10
	weapon_weight = WEAPON_HEAVY
	extra_damage = 2

/obj/item/gun/ballistic/automatic/type93/enable_burst()
	. = ..()
	spread = 10

/obj/item/gun/ballistic/automatic/type93/disable_burst()
	. = ..()
	spread = 0

/obj/item/gun/ballistic/automatic/m1garand
	name = "battle rifle"
	desc = "The WWII American Classic. Still has that satisfiying ping."
	icon_state = "m1garand"
	item_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/garand308
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	fire_delay = 6
	burst_size = 1
//	en_bloc = 1
//	auto_eject = 1
//	auto_eject_sound = 'sound/f13weapons/garand_ping.ogg'
	can_bayonet = TRUE
//	bayonetstate = "lasmusket"
	knife_x_offset = 22
	knife_y_offset = 21

/obj/item/gun/ballistic/automatic/m1garand/update_icon()
	..()
	icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/automatic/m1garand/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return

/obj/item/gun/ballistic/automatic/m1garand/oldglory
	name = "Old Glory"
	desc = "This Machine kills communists!"
	icon_state = "oldglory"
	extra_damage = 10

/obj/item/gun/ballistic/automatic/marksman/sniper
	name = "sniper rifle"
	desc = "A DKS 501, chambered in .308 Winchester.  With a light polymer body, it's suited for long treks through the desert."
	icon_state = "sniper_rifle"
	item_state = "sniper_rifle"
	mag_type = /obj/item/ammo_box/magazine/w308
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	fire_delay = 10
	burst_size = 1
//	projectile_speed = 0 //basically hitscan
	can_bayonet = FALSE

/obj/item/gun/ballistic/automatic/m1garand/republicspride
	name = "Republic's Pride"
	desc = "A well-tuned scoped M1C rifle crafted by master gunsmith from the Gunrunners. Proudly issued to Scout Captains and packs a mean punch. Chambered in 7.62x51."
	icon_state = "republics_pride"
	item_state = "scoped308"
	extra_damage = 8
	extra_penetration = 5
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE


/obj/item/gun/ballistic/automatic/lmg
	name = "R84 LMG"
	desc = "A post war lmg, traditionally manufactured by NCR forces. It is designed as a suppressive support weapon, generally granted to Heavy Troopers to compliment their stripped power armor."
	icon_state = "R84"
	item_state = "R84"
	slot_flags = 0
	automatic = 1
	mag_type = /obj/item/ammo_box/magazine/lmg
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 3
	burst_shot_delay = 3
	slowdown = 1.0
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	spread = 25
	randomspread = 1

/obj/item/gun/ballistic/automatic/lmg/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 35
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select += 1
			burst_size = 3
			spread = 45
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(2)
			select = 0
			burst_size = 1
			spread = 25
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

/obj/item/gun/ballistic/automatic/assault_carbine
	name = "assault carbine"
	desc = "A variant of the R81 with increased rate of fire and a matte black exterior."
	icon_state = "assault_carbine"
	item_state = "assault_carbine"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
//	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_sound = 'sound/f13weapons/assault_carbine.ogg'
	burst_size = 2
	fire_delay = 3
	burst_shot_delay = 2.0
	spread = 16
	automatic = 1
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	can_attachments = TRUE

/obj/item/gun/ballistic/automatic/assault_carbine/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 14
			if (recoil_decrease)
				spread = 6
			if (burst_improvement)
				burst_size = 3
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select = 0
			burst_size = 1
			spread = 1
			if (recoil_decrease)
				spread = 0
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

/obj/item/gun/ballistic/automatic/marksman/servicerifle/r82
	name = "R82 heavy service rifle"
	desc = "A top of the line 5.56x45 automatic service rifle manufactured by the NCR and issued to high ranking personnel."
	fire_delay = 1 //faster ROF, superior to regular service rifle
//	projectile_speed = 0.6 //faster velocity, superior to regular service rifle
//	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	icon_state = "R82"
	item_state = "R82"
	automatic = 1
	burst_size = 2
	can_bayonet = FALSE

/obj/item/gun/ballistic/automatic/m72
	name = "\improper M72 gauss rifle"
	desc = "The M72 rifle is of German design. It uses an electromagnetic field to propel rounds at tremendous speed... and pierce almost any obstacle. Its range, accuracy and stopping power is almost unparalleled."
	icon_state = "m72"
	item_state = "shotgun"
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/m2mm
	fire_sound = 'sound/f13weapons/gauss_rifle.ogg'
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 15
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
//	projectile_speed = 0
	recoil = 2

/obj/item/gun/ballistic/automatic/marksman/sniper/gold
	name = "golden sniper rifle"
	desc = "A DKS 501, chambered in .308 Winchester. This one has a gold trim and the words 'Old Cassius' engraved into the stock."
	icon_state = "gold_sniper"
	item_state = "gold_sniper"

/obj/item/gun/ballistic/automatic/autopipe
	name = "\improper auto pipe rifle"
	desc = "An improvised rifle improved with automatic capability, highly innacurate and slow to fire"
	icon_state = "auto_pipe_rifle"
	item_state = "improvshotgun"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/autopipe
	fire_sound = 'sound/weapons/Gunshot.ogg'
	can_suppress = FALSE
	burst_size = 4
	fire_delay = 30
	burst_shot_delay = 3
	automatic = 1
	spread = 24

/obj/item/gun/ballistic/automatic/autopipe/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 4
			spread = 24
			fire_delay = 25
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select = 0
			burst_size = 1
			spread = 5
			fire_delay = 8
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

/obj/item/gun/ballistic/automatic/shotgun/riot
	name = "breacher shotgun" //name changed to distinguish from /obj/item/gun/ballistic/shotgun/riot
	desc = "A compact riot shotgun designed to fight in close quarters."
	icon_state = "riot_shotgun"
	item_state = "huntingshotgun"
	fire_sound = 'sound/f13weapons/riot_shotgun.ogg'
	burst_size = 1
	fire_delay = 4
	mag_type = /obj/item/ammo_box/magazine/d12g
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	force = 40

/obj/item/gun/ballistic/automatic/lmg/m1919
	name = "Browning M1919"
	desc = "An old pre-war machine gun used in service by the US Military around the time of the war. Rechambered in 7.62x51."
	icon_state = "M38"
	item_state = "M38"
	slot_flags = 0
	automatic = 1
	mag_type = /obj/item/ammo_box/magazine/mm762
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 3
	slowdown = 1
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	spread = 20

/obj/item/gun/ballistic/automatic/lmg/m1919/update_icon()
	icon_state = "M38[cover_open ? "open" : "closed"][magazine ? CEILING(get_ammo(0)/20, 1)*20 : "-empty"][suppressed ? "-suppressed" : ""]"
	item_state = "M38[cover_open ? "open" : "closed"][magazine ? "mag" : "nomag"]"

/obj/item/gun/ballistic/automatic/lmg/m1919/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 30
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select += 1
			burst_size = 3
			spread = 40
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(2)
			select += 1
			burst_size = 4
			spread = 50
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(3)
			select = 0
			burst_size = 1
			spread = 20
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return
	

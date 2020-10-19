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

/obj/item/gun/ballistic/automatic/l6_saw
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
	pin = /obj/item/firing_pin/implant/pindicate
	automatic_burst_overlay = FALSE

/obj/item/gun/ballistic/automatic/l6_saw/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/l6_saw/examine(mob/user)
	. = ..()
	if(cover_open && magazine)
		. += "<span class='notice'>It seems like you could use an <b>empty hand</b> to remove the magazine.</span>"

/obj/item/gun/ballistic/automatic/l6_saw/attack_self(mob/user)
	cover_open = !cover_open
	to_chat(user, "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>")
	if(cover_open)
		playsound(user, 'sound/weapons/sawopen.ogg', 60, 1)
	else
		playsound(user, 'sound/weapons/sawclose.ogg', 60, 1)
	update_icon()

/obj/item/gun/ballistic/automatic/l6_saw/update_icon_state()
	icon_state = "l6[cover_open ? "open" : "closed"][magazine ? CEILING(get_ammo(0)/12.5, 1)*25 : "-empty"][suppressed ? "-suppressed" : ""]"
	item_state = "l6[cover_open ? "openmag" : "closedmag"]"

/obj/item/gun/ballistic/automatic/l6_saw/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is open! Close it before firing!</span>")
	else
		. = ..()
		update_icon()

/obj/item/gun/ballistic/automatic/l6_saw/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
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

/obj/item/gun/ballistic/automatic/l6_saw/attackby(obj/item/A, mob/user, params)
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

/////////////////////////SHOTGUNS/////////////////////////
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

/obj/item/gun/ballistic/automatic/greasegun
	spawnwithmagazine = FALSE
	name = "M3A1 Grease Gun (standard)"
	desc = "An inexpensive .45 ACP submachine gun. Slow fire rate means less waste of ammo and controllable bursts."
	icon_state = "grease_gun"
	item_state = "smg9mm"
	mag_type = /obj/item/ammo_box/magazine/greasegun
	fire_sound = 'sound/f13weapons/greasegun.ogg'
	can_suppress = FALSE
	weapon_weight = WEAPON_MEDIUM
	burst_size = 2
	fire_delay = 3
	burst_shot_delay = 3
	extra_damage = -5
	extra_penetration = -5
	force = 15
	spread = 10
	randomspread = 10
	can_attachments = TRUE
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/greasegun/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m45
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/low
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()


/obj/item/gun/ballistic/automatic/greasegun/mid
	name = "M3A1 Grease Gun (improved)"
	randomspread = 0
	fire_delay = 3
	burst_shot_delay = 3

/obj/item/gun/ballistic/automatic/greasegun/mid/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m45
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/mid
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/greasegun/high
	name = "M3A1 Grease Gun (masterwork)"
	fire_delay = 2
	burst_shot_delay = 2
	extra_penetration = 5
	extra_damage = 5
	randomspread = 0
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/greasegun/high/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m45
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/high
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/greasegun/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 18
			if (recoil_decrease)
				spread = 10
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




/obj/item/gun/ballistic/automatic/greasegun/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 18
			if (recoil_decrease)
				spread = 10
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

/obj/item/gun/ballistic/automatic/rangemaster
	name = "Colt Rangemaster (standard)"
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
	knife_x_offset = 24
	knife_y_offset = 21
	randomspread = 10

/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	name = "infiltrator"
	desc = "A customized R91 assault rifle, with an integrated suppressor, cut down stock and polymer furniture."
	icon_state = "infiltrator"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	suppressed = 1
	burst_size = 1
	fire_delay = 3
	spread = 1
	automatic = 1
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'
	weapon_weight = WEAPON_HEAVY
	can_attachments = TRUE
	can_bayonet = FALSE
	force = 15


/obj/item/gun/ballistic/automatic/infiltrator/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 0
			burst_size = 1
			spread = 1
			if (recoil_decrease)
				spread = 0
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

/obj/item/gun/ballistic/automatic/pistol/ninemil/maria
	name = "Maria"
	desc = "An ornately-decorated pre-war Browning Hi-power 9mm pistol with pearl grips and a polished nickel finish. The firing mechanism has been upgraded, so for anyone on the receiving end, it must seem like an eighteen-karat run of bad luck."
	icon_state = "maria"
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0
	extra_damage = 10 //40 damage, 20 AP- hits like a 7.62 and fires faster
	extra_penetration = 20
	can_attachments = TRUE

/obj/item/gun/ballistic/automatic/marksman/servicerifle
	spawnwithmagazine = FALSE
	name = "service rifle (standard)"
	desc = "A 5.56x45 semi-automatic service rifle manufactured by the NCR and issued to all combat personnel."
	icon_state = "service_rifle"
	item_state = "servicerifle"
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	fire_delay = 5
	extra_damage = -6
	extra_penetration = -6
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	zoomable = FALSE
	weapon_weight = WEAPON_HEAVY
	//bayonetstate = "rifles"
	randomspread = 10
	knife_x_offset = 22
	knife_y_offset = 12

/obj/item/gun/ballistic/automatic/marksman/servicerifle/mid
	name = "service rifle (improved)"
	randomspread = 0
	fire_delay = 4
	extra_damage = 0
	extra_penetration = 0

/obj/item/gun/ballistic/automatic/marksman/servicerifle/mid/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/simple
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m556
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/mid
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/marksman/servicerifle/high
	name = "service rifle (masterwork)"
	randomspread = 0
	fire_delay = 3
	extra_damage = 10
	extra_penetration = 10
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/marksman/servicerifle/high/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/simple
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m556
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/high
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/pps
	spawnwithmagazine = FALSE
	name = "\improper ancient SMG (standard)"
	desc = "An extremely fast firing, innacurate SMG from past wars. Low fire rate and low damage. Uses 9mm rounds."
	icon_state = "pps"
	mag_type = /obj/item/ammo_box/magazine/pps9mm
	w_class = WEIGHT_CLASS_NORMAL
	//can_scope = TRUE
	//scopestate = "AEP7_scope"
	//scope_x_offset = 9
	//scope_y_offset = 21
	burst_size = 3
	burst_shot_delay = 2
	fire_delay = 6
	force = 15
	spread = 20
	can_attachments = TRUE
	randomspread = 10
	extra_damage = -14
	extra_penetration = -5

/obj/item/gun/ballistic/automatic/pps/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm9
		var/obj/item/F = new /obj/item/prefabs/complex/stock/low
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/low
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/pps/mid
	name = "\improper ancient SMG (improved)"
	burst_shot_delay = 1.5
	fire_delay = 5
	can_attachments = TRUE
	extra_damage = -9
	extra_penetration = 0
	randomspread = 0


/obj/item/gun/ballistic/automatic/pps/mid/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm9
		var/obj/item/F = new /obj/item/prefabs/complex/stock/low
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/mid
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/pps/high
	name = "\improper ancient SMG (masterwork)"
	burst_size = 3
	extra_damage = 0
	extra_penetration = 5
	burst_shot_delay = 1.5
	randomspread = 0
	can_attachments = TRUE
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/pps/high/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm9
		var/obj/item/F = new /obj/item/prefabs/complex/stock/low
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/high
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/pps/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 3
			spread = 28
			if (burst_improvement)
				burst_size = 4
			if (recoil_decrease)
				spread = 20
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select = 0
			burst_size = 1
			spread = 10
			if (recoil_decrease)
				spread = 2
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

/obj/item/gun/ballistic/automatic/smg10mm
	spawnwithmagazine = FALSE
	name = "10mm submachine gun (standard)"
	desc = "A select fire open bolt 10mm submachine gun. The serial number and manufactuer markings have been scratched off."
	icon_state = "smg10mm"
	item_state = "smg10mm"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m10mm_auto
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM //You should be able to dual-wield these.
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'
	burst_size = 2
	fire_delay = 4
	burst_shot_delay = 3
	extra_damage = -6
	extra_penetration = -6
	randomspread = 10
	can_suppress = FALSE //we dont have sprites therefore cease
	force = 15
	spread = 18
	can_attachments = TRUE

/obj/item/gun/ballistic/automatic/smg10mm/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm10
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/low
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/smg10mm/mid
	name = "10mm submachine gun (improved)"
	randomspread = 0
	extra_penetration = 0
	extra_damage = 0

/obj/item/gun/ballistic/automatic/smg10mm/mid/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm10
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/mid
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()


/obj/item/gun/ballistic/automatic/smg10mm/high
	name = "10mm submachine gun (masterwork)"
	randomspread = 0
	burst_size = 2
	fire_delay = 2
	burst_shot_delay = 2
	extra_damage = 6
	extra_penetration = 6
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/smg10mm/high/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm10
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/high
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()


/obj/item/gun/ballistic/automatic/smg10mm/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 18
			if (recoil_decrease)
				spread = 10
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

/obj/item/gun/ballistic/automatic/mini_uzi
	spawnwithmagazine = FALSE
	name = "\improper Type U3 Uzi (standard)"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "mini-uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	can_scope = TRUE
	scopestate = "AEP7_scope"
	scope_x_offset = 9
	scope_y_offset = 21
	burst_size = 2
	burst_shot_delay = 2
	fire_delay = 5
	force = 15
	extra_damage = -5
	extra_penetration = -5
	randomspread = 10
	spread = 10
	can_attachments = TRUE
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/mini_uzi/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm9
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/low
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/mini_uzi/mid
	name = "\improper Type U3 Uzi (improved)"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT
	fire_delay = 4
	extra_penetration = 0
	extra_damage = 0
	randomspread = 0

/obj/item/gun/ballistic/automatic/mini_uzi/mid/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm9
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/mid
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/mini_uzi/high
	name = "\improper Type U3 Uzi (masterwork)"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT
	fire_delay = 3
	extra_damage = 5
	extra_penetration = 5
	randomspread = 0

/obj/item/gun/ballistic/automatic/mini_uzi/high/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/mm9
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/high
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/mini_uzi/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 18
			if (burst_improvement)
				burst_size = 3
			if (recoil_decrease)
				spread = 10
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

/obj/item/gun/ballistic/automatic/rangemaster/scoped
	name = "Scoped Colt Rangemaster (standard)"
	desc = "Nothing's better than seeing that surprised look on your target's face. The Loophole x20 Scope on this hunting rifle makes it easier than ever before. Accurate from first shot to last, no matter what kind of game you're gunning for."
	icon_state = "rangemaster"
	item_state = "scoped308"
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	spawnwithmagazine = FALSE
	can_scope = FALSE

/obj/item/gun/ballistic/automatic/rangemaster/scoped/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/high
		var/obj/item/D = new /obj/item/prefabs/complex/action/simple
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m762
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/low
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		var/obj/item/Z = new /obj/item/advanced_crafting_components/assembly
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		Z.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/rangemaster/scoped/mid
	name = "Scoped Colt Rangemaster (improved)"
	randomspread = 0
	extra_penetration = 0
	extra_damage = 0

/obj/item/gun/ballistic/automatic/rangemaster/scoped/mid/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/high
		var/obj/item/D = new /obj/item/prefabs/complex/action/simple
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m762
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/mid
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		var/obj/item/Z = new /obj/item/advanced_crafting_components/assembly
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		Z.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/rangemaster/scoped/high
	name = "Scoped Colt Rangemaster (masterwork)"
	randomspread = 0
	fire_delay = 4
	extra_penetration = 7
	extra_damage = 7

/obj/item/gun/ballistic/automatic/rangemaster/scoped/high/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/high
		var/obj/item/D = new /obj/item/prefabs/complex/action/simple
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m762
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/high
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		var/obj/item/Z = new /obj/item/advanced_crafting_components/assembly
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		Z.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()


/obj/item/gun/ballistic/automatic/assault_rifle
	spawnwithmagazine = FALSE
	name = "assault rifle (standard)"
	desc = "A standard R91 assault rifle, out of use around the time of the Great War."
	icon_state = "assault_rifle"
	item_state = "fnfal"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	burst_size = 2
	automatic = 1
	fire_delay = 4
	burst_shot_delay = 3
	extra_damage = -6
	extra_penetration = -6
	spread = 8
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	can_attachments = TRUE
	randomspread = 10

//	bayonetstate = "rifles"
	can_bayonet = TRUE
	knife_x_offset = 23
	knife_y_offset = 11

/obj/item/gun/ballistic/automatic/assault_rifle/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/high
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m556
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/low
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		var/obj/item/Z = new /obj/item/advanced_crafting_components/assembly
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		Z.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/assault_rifle/mid
	name = "assault rifle (improved)"
	randomspread = 0
	fire_delay = 3
	extra_penetration = 0
	extra_damage = 0
	burst_shot_delay = 2

/obj/item/gun/ballistic/automatic/assault_rifle/mid/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m556
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/low
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		var/obj/item/Z = new /obj/item/advanced_crafting_components/assembly
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		Z.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/assault_rifle/high
	name = "assault rifle (masterwork)"
	randomspread = 0
	fire_delay = 3
	extra_damage = 6
	extra_penetration = 6
	burst_shot_delay = 2
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/assault_rifle/high/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/screwdriver))
		var/obj/item/A = new /obj/item/prefabs/complex/screw
		var/obj/item/B = new /obj/item/prefabs/complex/trigger
		var/obj/item/C = new /obj/item/prefabs/complex/bolt/simple
		var/obj/item/D = new /obj/item/prefabs/complex/action/auto
		var/obj/item/E = new /obj/item/prefabs/complex/barrel/m556
		var/obj/item/F = new /obj/item/prefabs/complex/stock/mid
		var/obj/item/G = new /obj/item/prefabs/complex/complexWeaponFrame/high
		var/obj/item/H = new /obj/item/advanced_crafting_components/receiver
		var/obj/item/Z = new /obj/item/advanced_crafting_components/assembly
		A.forceMove(usr.loc)
		B.forceMove(usr.loc)
		C.forceMove(usr.loc)
		D.forceMove(usr.loc)
		E.forceMove(usr.loc)
		F.forceMove(usr.loc)
		G.forceMove(usr.loc)
		H.forceMove(usr.loc)
		Z.forceMove(usr.loc)
		qdel(src)
		to_chat(usr,"You dissasemble the [src].")
	. = ..()

/obj/item/gun/ballistic/automatic/assault_rifle/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 8
			if (recoil_decrease)
				spread = 0
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

/obj/item/gun/ballistic/automatic/marksman/servicerifle/varmint
	name = "varmint rifle"
	desc = "A low powered 5.56, easy to use rifle."
	icon_state = "varmint_rifle"
	item_state = "varmintrifle"
	fire_delay = 8
	mag_type = /obj/item/ammo_box/magazine/m556/rifle/small
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	can_bayonet = FALSE

/obj/item/gun/ballistic/automatic/marksman/servicerifle/varmint/ratslayer
	name = "ratslayer"
	desc = "A modified Varmint Rifle with better stopping power, a scope, and suppressor. Oh, don't forget the sick paint job."
	icon_state = "rat_slayer"
	item_state = "ratslayer"
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'

/obj/item/gun/ballistic/automatic/type93
	name = "type 93 assault rifle"
	desc = "The Type 93 Chinese assault rifle was designed and manufactured by a Chinese industrial conglomerate for the People's Liberation Army during the Resource Wars, for the purpose of equipping the Chinese infiltrators and American fifth-columnists. Chambered in 5.56x45."
	icon_state = "type93"
	item_state = "handmade_rifle"
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE
	mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	burst_size = 2
	fire_delay = 3
	spread = 10
	weapon_weight = WEAPON_HEAVY
	extra_damage = 2
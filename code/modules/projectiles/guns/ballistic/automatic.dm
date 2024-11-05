//IN THIS DOCUMENT: Automatic template, SMGs, Carbines, Semi-auto rifles, Assault rifles, Machineguns and Misc.
// See gun.dm for keywords and the system used for gun balance



//////////////////////
//AUTOMATIC TEMPLATE//
//////////////////////


/obj/item/gun/ballistic/automatic
	name = "automatic gun template"
	desc = "should not be here, bugreport."
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	var/auto_eject = 0 //for en blocs
	var/auto_eject_sound = null
	//var/alarmed = 0 //for a funky, annoying sound when ammo runs out. broken code
	can_suppress = FALSE
	equipsound = 'sound/f13weapons/equipsounds/riflequip.ogg'
	init_recoil = SMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)

	/* code for digitally displaying fire select. ancient code
	var/automatic_burst_overlay = TRUE
	var/select = 1
	/obj/item/gun/ballistic/automatic/update_overlays()
		. = ..()
		if(automatic_burst_overlay)
			if(!select)
				. += ("[initial(icon_state)]semi")
			if(select == 1)
				. += "[initial(icon_state)]burst"
	*/

/obj/item/gun/ballistic/automatic/update_icon_state()
	if(SEND_SIGNAL(src, COMSIG_ITEM_UPDATE_RESKIN))
		return // all done!
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"

/* /obj/item/gun/ballistic/automatic/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/new_mag = A
		if(istype(new_mag, mag_type))
			var/obj/item/ammo_box/magazine/oldmag = magazine
			if(user.transferItemToLoc(new_mag, src))
				magazine = new_mag
				if(oldmag)
					to_chat(user, span_notice("You perform a tactical reload on \the [src], replacing the magazine."))
					oldmag.forceMove(get_turf(src.loc))
					oldmag.update_icon()
				else
					to_chat(user, span_notice("You insert the magazine into \the [src]."))

				playsound(user, 'sound/weapons/autoguninsert.ogg', 60, 1)
				chamber_round()
				A.update_icon()
				update_icon()
				return 1
			else
				to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!")) */

/obj/item/gun/ballistic/automatic/can_shoot()
	return get_ammo()

/*
/obj/item/gun/ballistic/automatic/proc/empty_alarm()
	if(!chambered && !get_ammo() && !alarmed)
		playsound(src.loc, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
		update_icon()
		alarmed = 1
	return
*/
/obj/item/gun/ballistic/automatic/afterattack(atom/target, mob/living/user)
	..()
	if(auto_eject && magazine && magazine.stored_ammo && !magazine.stored_ammo.len && !chambered)
		magazine.dropped()
		user.visible_message(
			"[magazine] falls out and clatters on the floor!",
			span_notice("[magazine] falls out and clatters on the floor!")
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
	icon_state = "uzi"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_CARBINE
	init_recoil = SMG_RECOIL(1, 1)

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
	inhand_icon_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/m22smg
	init_mag_type = /obj/item/ammo_box/magazine/m22smg
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/faster
	)
	silenced = TRUE
	fire_sound_silenced = 'sound/f13weapons/american180.ogg'

/obj/item/gun/ballistic/automatic/smg/american180/dp27
	name = "Mini DP-27"
	desc = "A tiny replica DP-27, with a .22 pan magazine."
	icon = 'modular_coyote/icons/objects/mgs.dmi'
	icon_state = "dp"
	silenced = FALSE

/obj/item/gun/ballistic/automatic/smg/american180/dp27/Initialize()
	.=..()
	transform *= 0.6
	special_transform = transform

/obj/item/gun/ballistic/automatic/smg/american180/b180
	name = "American 18-bee"
	desc = "They used to call the gun a swarm of angry bees. In this case, it's literal."
	mag_type = /obj/item/ammo_box/magazine/b180
	extra_mag_types = /obj/item/ammo_box/magazine/m22smg //lets you use it as a standard .22 when you run out of unobtainable bees.
	init_mag_type = /obj/item/ammo_box/magazine/b180

/* * * * * * * * * * *
 * VSS Vintorez
 * 9mm
 * suppressed
 * two handed
 * fast shooting
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/vss
	name = "AS-VAL Supressed rifle"
	desc = "An integrally suppressed compact chambered in the rare 9x39. Used by the Spetnaz and other Russian special forces, this 9mm assault carbine is quite the gun. Rack that charging handle and remember, no gecko."
	icon_state = "vss"
	inhand_icon_state = "vss"
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	mag_type = /obj/item/ammo_box/magazine/vss
	init_mag_type = /obj/item/ammo_box/magazine/vss
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T4
	init_recoil = AUTOCARBINE_RECOIL(1.2, 1.3)
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/faster
	)
	silenced = TRUE
	fire_sound_silenced = 'sound/f13weapons/american180.ogg'


/obj/item/gun/ballistic/automatic/c96auto
	name = "Mauser M712"
	desc = "A late model of the classic Mauser C96, featuring a removable box magazine and automatic fire select. takes 20 round stick magazines."
	icon_state = "c96"
	inhand_icon_state = "p38"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(0.6, 0.6)
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/uzim9mm/rockwell
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm/rockwell
	init_firemodes = list(
		/datum/firemode/automatic/rpm200 ,
		/datum/firemode/semi_auto/fast
	)

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
	inhand_icon_state = "14toploader"
	mag_type = /obj/item/ammo_box/magazine/smg14
	init_mag_type = /obj/item/ammo_box/magazine/smg14
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTOCARBINE_RECOIL(2, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/burst/three/slow,
		/datum/firemode/semi_auto
	)
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'

/* * * * * * * * * * *
 * Greasegun SMG!
 * Easy-handle .45ACP SMG
 * .45 ACP
 * One-handed
 * No akimbo
 * Slowish autofire
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/greasegun
	name = "m3a1 greasegun"
	desc = "This submachine gun filled National Guard arsenals after the Army replaced it with newer weapons."
	icon_state = "grease_gun"
	inhand_icon_state = "smg9mm"
	fire_sound = 'sound/f13weapons/greasegun.ogg'
	mag_type = /obj/item/ammo_box/magazine/greasegun
	init_mag_type = /obj/item/ammo_box/magazine/greasegun
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	can_suppress = TRUE
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/faster
	)
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 19

/* * * * * * * * * * *
 * Worn greasegun SMG
 * Cruddy .45 SMG
 * .45
 * One-handed
 * No akimbo
 * Less accuracy
 * Less damage
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/greasegun/worn
	name = "beat up .45ACP submachine gun"
	desc = "What was once an inexpensive, but reliable submachine gun is now an inexpensive piece of shit. It's impressive this thing still fires at all."
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = AUTOCARBINE_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150
	)

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
	inhand_icon_state = "smg10mm"
	mag_type = /obj/item/ammo_box/magazine/m10mm
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/ext
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	can_suppress = TRUE
	init_recoil = SMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	suppressor_state = "10mm_suppressor" //activate if sprited
	suppressor_x_offset = 30
	suppressor_y_offset = 16
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
	desc = "Mass-produced weapon from the Great War, this one has seen use ever since. Its grip is wrapped in tape to keep the plastic from crumbling, the metals are oxidizing, but the gun still works."
	worn_out = TRUE //a lazy way to overlay the worn sprite variant onto the gun
	damage_multiplier = GUN_LESS_DAMAGE_T3
	init_recoil = SMG_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/faster
	)


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
	name = "9mm Uzi"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	inhand_icon_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/uzim9mm/rockwell) //so I don't have to assign a ton of new sprite names
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	can_suppress = TRUE
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16

/* * * * * * * * * * *
 * Uzi .22 SMG
 * Lighter .22 SMG
 * .22
 * Faster firing
 * Less damage
 * One-handed
 * Akimbo!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22
	name = ".22 Uzi"
	desc = "A very lightweight submachine gun, for when you really want to politely ask someone to be dead. Uses .22LR rounds."
	icon_state = "uzi22"
	inhand_icon_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/m22/extended
	init_mag_type = /obj/item/ammo_box/magazine/m22/extended
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	can_suppress = TRUE
	init_recoil = SMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	can_suppress = TRUE
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16

/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/mp22
	name = ".22 MP5"
	desc = "A commercial version of the MP5 chambered in .22LR."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp5"

/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/ppsh
	name = "Mini PPSh"
	desc = "A tiny replica SMG, fed from .22 magazines. It's so small!"
	icon_state = "pps"
	inhand_icon_state = "uzi"
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/ppsh/Initialize()
	.=..()
	transform *= 0.6
	special_transform = transform

//tec-9 but in .22, compared to .22 pistol, is automatic, but less damage, not silenced
/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22
	name = ".22 machine pistol"
	desc = "A compact, lightweight way to put a lot of bullets downrange."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "tec9"
	mag_type = /obj/item/ammo_box/magazine/m22
	init_mag_type = /obj/item/ammo_box/magazine/m22
	disallowed_mags = list(/obj/item/ammo_box/magazine/m22/extended, /obj/item/ammo_box/magazine/m22/extended/empty)
	weapon_class = WEAPON_CLASS_SMALL
	damage_multiplier = GUN_LESS_DAMAGE_T1
	can_suppress = TRUE

//MP40: a uzi but with different flavor
/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp40
	name = "Maschinenpistole 40"
	desc = "An open bolt blowback submachine gun that served in the German Army. It's a long way from home."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp40"
	inhand_icon_state = "smg9mm"

//compact modernize MP5
/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5
	name = "HK MP-5"
	desc = "A lightweight submachine gun that earned its place as one of the most popular SMGs in the world"
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp5"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	weapon_class = WEAPON_CLASS_NORMAL //high class, one of the few smol smgs
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Accurate semiauto fire

//rockwell: starter tier bad quality 9mm smg
/obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell
	name = "9mm Rockwell SMG"
	desc = "A crudely handmade reincarnation of the Australian Owen gun. It shoots, at least."
	icon_state = "rockwell"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm/rockwell
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm/rockwell
	disallowed_mags = null
	weapon_class = WEAPON_CLASS_NORMAL
	damage_multiplier = GUN_LESS_DAMAGE_T1
	can_suppress = TRUE
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/fast
	)
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/smg/mini_uzi/rockworse
	name = "9mm Rockwell Pistol"
	desc = "A crude modification of the 9mm Rockwell SMG, affectionately named the \"Rockworse\". Uses Doublestack 9mm magazines."
	icon_state = "rockworse"
	mag_type = /obj/item/ammo_box/magazine/m9mm
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	disallowed_mags = /obj/item/ammo_box/magazine/uzim9mm/rockwell
	weapon_class = WEAPON_CLASS_NORMAL
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = SMG_RECOIL(2, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150
	)
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/smg/mini_uzi/owengun
	name = "9mm Owen Gun"
	desc = "A genuine Australian machine carbine! It's favored due to its portability, weight, and reliability."
	icon_state = "owengun"
	inhand_icon_state = "rockwell"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm/rockwell
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm/rockwell
	disallowed_mags = null
	weapon_class = WEAPON_CLASS_NORMAL
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/fast
	)
	can_suppress = FALSE


//mac-10: uzi, but compact, softer hitting, harder to control. needs suppressor location adjusted
/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10
	name = "Ingram Model 10" //I like naming things quirkily
	desc = "A compact machine pistol with a blistering fire rate."
	icon = 	'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "mac10"
	weapon_class = WEAPON_CLASS_NORMAL //kinda bulky for a compact gun
	damage_multiplier = GUN_LESS_DAMAGE_T1 //this spits lots of bullets and is compact and can be dual wielded
	init_recoil = SMG_RECOIL(2, 2)
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/faster
	)

//mac-10 but shit.
/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10/worn
	name = "Knockoff Ingram Model 10" //I like naming things quirkily
	desc = "A compact machine pistol with a blistering fire rate. Or so they claim."
	icon = 	'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "mac10"
	weapon_class = WEAPON_CLASS_NORMAL //kinda bulky for a compact gun
	damage_multiplier = GUN_LESS_DAMAGE_T2 //this spits lots of bullets and is compact and can be dual wielded
	init_recoil = SMG_RECOIL(2.3, 2.3)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)

/* * * * * * * * * * *
 * Carl Gustaf 10mm SMG
 * Another 10mm SMG
 * 10mm
 * Slower firing
 * Less damage
 * No akimbo
 * Common? ive never seen one
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/cg45
	name = "Carl Gustaf 10mm"
	desc = "Post-war submachine gun made in workshops in Phoenix, a copy of a simple old foreign design."
	icon_state = "cg45"
	inhand_icon_state = "cg45"
	mag_type = /obj/item/ammo_box/magazine/cg45
	init_mag_type = /obj/item/ammo_box/magazine/cg45
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = SMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

/* * * * * * * * * * *
 * Worn Carl Gustaf 10mm SMG
 * Poor Baseline 10mm SMG
 * 10mm
 * Slower firing
 * Less damage
 * One-handed
 * No akimbo
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/cg45/worn
	name = "Worn Carl Gustaf 10mm"
	desc = "Post-war submachine gun made in workshops in Phoenix, a copy of a simple old foreign design. This one has seen better days"
	damage_multiplier = GUN_LESS_DAMAGE_T3 //234 DPS
	init_recoil = SMG_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/faster
	)

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
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "tommygun"
	inhand_icon_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/tommygunm45
	init_mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)

	fire_sound = 'sound/weapons/gunshot_smg.ogg'

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
	init_mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	damage_multiplier = GUN_LESS_DAMAGE_T1


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
	inhand_icon_state = "m90"
	mag_type = /obj/item/ammo_box/magazine/m10mm_p90
	init_mag_type = /obj/item/ammo_box/magazine/m10mm_p90
	weapon_class = WEAPON_CLASS_CARBINE
	w_class = WEIGHT_CLASS_NORMAL // Kelp again, it's Normal once more but no more akimbo. Please actually edit relevant comments when you tweak pls.
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 //260 dps
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three/fast,
		/datum/firemode/semi_auto/fast
	)
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
 * Less damage
 * One-handed
 * Akimbo!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/p90/worn
	name = "Worn FN P90c"
	desc = "A FN P90 manufactured by Fabrique Nationale. This one is beat to hell but still works."
	damage_multiplier = GUN_EXTRA_DAMAGE_0 //208 dps

/* * * * * * * * * * *
* M22 SMG
*-weak damage
*+fast fire rate
*- takes only uzi magazines
* - high recoil
* + comes supressed
* * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/m22
	name = "M22 Night Ops SMG"
	desc = "An integrally suppressed submachinegun chambered in 9mm. Produced by Jaeger Company, this special version of the M22 SMG was in use by Pre-Fall UNMC troopers when parachuting behind enemy lines. Now it falls in the hands of the wasteland, itching for the trigger to be pulled. Comes with a built in holographic sight."
	icon_state = "m22so"
	inhand_icon_state = "m22so"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	disallowed_mags = list (/obj/item/ammo_box/magazine/m9mm/doublestack,/obj/item/ammo_box/magazine/m9mm/doublestack/empty , /obj/item/ammo_box/magazine/uzim9mm/rockwell )
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC
	init_recoil = AUTORIFLE_RECOIL(1.2 , 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fastest
	)
	silenced = TRUE
	fire_sound = 'sound/weapons/Gunshot_silenced.ogg'
	fire_sound_silenced = 'sound/weapons/Gunshot_silenced.ogg'


/* * * * * * * * * * *
 * MP-5 SD SMG
 * Silent 9mm SMG
 * 9mm
 * Quiet
 * Accurate
 * Slightly more damage
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/mp5sd //hello world
	name = "MP-5 SD"
	desc = "An integrally suppressed submachinegun chambered in 9mm."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp5"
	inhand_icon_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Accurate semiauto fire
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	silenced = TRUE
	fire_sound = 'sound/weapons/Gunshot_silenced.ogg'
	fire_sound_silenced = 'sound/weapons/Gunshot_silenced.ogg'

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
	mag_type = /obj/item/ammo_box/magazine/pps9mm
	init_mag_type = /obj/item/ammo_box/magazine/pps9mm
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fast
	)
	scope_state = "AEP7_scope"
	scope_x_offset = 9
	scope_y_offset = 21
	can_scope = TRUE

/* * * * * * * * * * *
 * Sidewinder SMG
 * Multiammo SMG
 * 9mm / 10mm / .45 / .22
 * Click a button while its empty to change what mags it accepts!
 * Low damage
 * Two-handed
 * Slow firing
 * Inaccurate
 * Uncommon?
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/smg/sidewinder
	name = "multi-caliber smg"
	desc = "The answer to all your ammo-scrounging problems! The TwisTactical Spindoctor SMMG (sub-machine multi-gun) integrates \
			rotation-reactive metalmers in the upper assembly to change what ammunition it accepts, from .22LR to .45ACP with a \
			simple twist of the mechanism. Surprisingly easy to maintain and assemble, given the right high-tech Rotosteel parts, \
			making it a common sight for Boxcar Vixens in the Heap, where the short sightlines more than make up for the gun's \
			inherently poor accuracy. Doesn't accept awkwardly shaped magazines, though. That's for the PRO model, which isn't \
			available out here. ++To change ammunition type, unload the weapon and press the button on the top left corner of your screen."
	icon_state = "sidewinder"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	extra_mag_types = /obj/item/ammo_box/magazine/m9mm
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	var/current_caliber = "9mm"
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/fast,
		/datum/firemode/burst/three/fast
	)

	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 10
	scope_y_offset = 22
	can_flashlight = TRUE

	can_flashlight = TRUE
	scope_state = "flight"
	flight_x_offset = 16
	flight_y_offset = 18

	can_suppress = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 31
	suppressor_y_offset = 17

	actions_types = list(/datum/action/item_action/toggle_sidewinder)
	//fire_sound = 'sound/f13weapons/9mm.ogg'
	use_casing_sounds = TRUE

/obj/item/gun/ballistic/automatic/smg/sidewinder/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[current_caliber]" : ""][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/smg/sidewinder/proc/change_ammo(mob/user)
	if(user)
		if(magazine)
			user.show_message(span_alert("[src] needs to be completely unloaded before working the TwistForm mechanism!"))
			return
		if(chambered)
			user.show_message(span_alert("[src] needs to be <u>completely</u> unloaded before working the TwistForm mechanism!"))
			return

	allowed_mags = list()
	change_the_ammo(user)

/obj/item/gun/ballistic/automatic/smg/sidewinder/proc/change_the_ammo(mob/user)
	var/message2self = "You wrench the upper receiver of [src] out of its socket and give it one full turn."
	var/message2everyone = "[user] spins [user.p_their()] their gun around. It makes a wierd click."
	switch(current_caliber)
		if("22LR")
			current_caliber = "9mm"
			allowed_mags |= typesof(/obj/item/ammo_box/magazine/m9mm, /obj/item/ammo_box/magazine/uzim9mm)
			message2self += "The panel on the side now reads: \"9mm Mode\""

		if("9mm")
			current_caliber = "10mm"
			allowed_mags |= typesof(/obj/item/ammo_box/magazine/m10mm, /obj/item/ammo_box/magazine/cg45)
			message2self += "The panel on the side now reads: \"10mm Mode\""

		if("10mm")
			current_caliber = "45ACP"
			allowed_mags |= typesof(/obj/item/ammo_box/magazine/greasegun, /obj/item/ammo_box/magazine/m45, /obj/item/ammo_box/magazine/tommygunm45/stick)
			message2self += "The panel on the side now reads: \".45ACP Mode\""

		if("45ACP")
			current_caliber = "22LR"
			allowed_mags |= typesof(/obj/item/ammo_box/magazine/m22)
			message2self += "The panel on the side now reads: \".22LR Mode\""

	playsound(get_turf(src), 'sound/f13weapons/equipsounds/riflequip.ogg', 60, 1)
	if(user)
		user.visible_message(message2everyone,span_notice(message2self))

/obj/item/gun/ballistic/automatic/smg/sidewinder/examine(mob/user)
	. = ..()
	switch(current_caliber)
		if("22LR")
			. += "<br><span class='notice'>The readout displays \".22LR Mode\", indicating it'll accept most .22 SMG and pistol mags.</span>"
		if("9mm")
			. += "<br><span class='notice'>The readout displays \"9mm Mode\", indicating it'll accept most 9mm SMG and pistol mags.</span>"
		if("10mm")
			. += "<br><span class='notice'>The readout displays \"10mm Mode\", indicating it'll accept most 10mm SMG and pistol mags.</span>"
		if("45ACP")
			. += "<br><span class='notice'>The readout displays \".45ACP Mode\", indicating it'll accept most .45 SMG and pistol mags.</span>"
	. += "<br><span class='notice'>Unload the gun and click the action button to change the caliber.</span>"

//worn sidewinder

/obj/item/gun/ballistic/automatic/smg/sidewinder/worn
	name = "multi-caliber carbine"
	desc = "The answer to all your ammo-scrounging problems! The TwisTactical Spindoctor MGC (multi-gun carbine) integrates \
			rotation-reactive metalmers in the upper assembly to change what ammunition it accepts, from .22LR to .45ACP with a \
			simple twist of the mechanism. Surprisingly easy to maintain and assemble, given the right high-tech Rotosteel parts, \
			making it a common sight for Boxcar Vixens in the Heap, where the short sightlines more than make up for the gun's \
			inherently poor accuracy. Doesn't accept awkwardly shaped magazines, though. That's for the PRO model, which isn't \
			available out here. This model is locked to semi-auto!  ++To change ammunition type, unload the weapon and press the \
			button on the top left corner of your screen."
	icon_state = "sidewinder"
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/// multical-magnum
/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum
	name = "multi-caliber magnum"
	desc = "A heavier, more robust multi-caliber carbine! The TwisTactical Magnum uses a thicker-walled roto-mechanism that allows its \
			rotation-reactive metalmers to withstand higher pressures, now able to safely fire anything from .45ACP to 14mm with a \
			simple twist of the mechanism. Surprisingly easy to maintain and assemble, given the right high-tech Rotosteel parts, \
			making it a common sight for Boxcar Vixens in the Heap, where the short sightlines more than make up for the gun's \
			inherently poor accuracy. Only accepts small magazines. This model is locked to semi-auto! ++To change ammunition type,\
			unload the weapon and press the button on the top left corner of your screen."
	icon_state = "sidewinder-magnum"
	mag_type = /obj/item/ammo_box/magazine/m44
	extra_mag_types = /obj/item/ammo_box/magazine/m44/automag
	init_mag_type = /obj/item/ammo_box/magazine/m44
	current_caliber = "44"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	//fire_sound = 'sound/f13weapons/44mag.ogg'

/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum/change_the_ammo(mob/user)
	var/message2self = "You wrench the upper receiver of [src] out of its socket and give it one full turn. "
	var/message2everyone = "[user] spins [user.p_their()] their gun around. It makes a wierd click."
	switch(current_caliber)
		if("44")
			current_caliber = "14mm"
			allowed_mags |= typesof(/obj/item/ammo_box/magazine/m14mm)
			//fire_sound = 'sound/f13weapons/magnum_fire.ogg'
			message2self += "The panel on the side now reads: \"14mm Mode\""

		if("14mm")
			current_caliber = "45ACP"
			allowed_mags |= typesof(/obj/item/ammo_box/magazine/m45)
			//fire_sound = 'sound/weapons/gunshot_smg.ogg'
			message2self += "The panel on the side now reads: \".45ACP Mode\""

		if("45ACP")
			current_caliber = "44"
			allowed_mags |= typesof(/obj/item/ammo_box/magazine/m44)
			//fire_sound = 'sound/f13weapons/44mag.ogg'
			message2self += "The panel on the side now reads: \".44 Magnum Mode\""

	playsound(get_turf(src), 'sound/f13weapons/revolverspin.ogg', 60, 1)
	if(user)
		user.visible_message(message2everyone,span_notice(message2self))


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
	desc = "Once used by the US Army, it found its way into police and National Guard armories, though it's since been rechambered in a more common caliber. It looks like it can accept a bayonet."
	icon_state = "m1carbine"
	inhand_icon_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m10mm
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE) //need to check what this do
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION

	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 5
	scope_y_offset = 14
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'


/obj/item/gun/ballistic/automatic/m1carbine/covcarbine
	name = "T25 Assault Carbine"
	desc = "A T25 Assault Carbine. This unique futuristic looking carbine comes from a company known as Latos Systems."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "covdmr"
	inhand_icon_state = "covrifle"
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	fire_sound = 'sound/f13weapons/aep7fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/m10mm
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE) //need to check what this do
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	auto_eject = 1
	can_bayonet = FALSE
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 5
	scope_y_offset = 14
	can_suppress = FALSE
	auto_eject_sound = 'sound/f13weapons/garand_ping.ogg'

/* * * * * * * * * * *
 * M2 Carbine
 * 10mm
 * lower fire rate than a 10mm smg, but scope and bayonet compatible
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/m1carbine/m2
	name = "M2 carbine"
	desc = "A variant of the M1 carbine that's capable of full auto. Popular with Pre-Fall police, a few of these have managed to survive even today. Looks like it has a lug for a bayonet."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "ncr-m1carbine"
	inhand_icon_state = "rifle"
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/ext
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)

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
	weapon_class = WEAPON_CLASS_CARBINE
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1.5, 1.5)

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
		w_class = WEIGHT_CLASS_NORMAL
		to_chat(user, "You unfold the stock.")
		recoil_tag = SSrecoil.give_recoil_tag(RIFLE_RECOIL(1, 1))
	else
		w_class = WEIGHT_CLASS_SMALL
		to_chat(user, "You fold the stock.")
		recoil_tag = SSrecoil.give_recoil_tag(init_recoil)
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
	inhand_icon_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m9mm
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // tacticool
	can_scope = TRUE
	silenced = TRUE
	fire_sound_silenced = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * Commando Carbine
 * Silent .45 carbine
 * Silent!
 * Common?
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/delisle/commando
	name = "commando carbine"
	desc = "A integrally suppressed carbine, known for being one of the quietest firearms ever made. Its stock has been replaced by polymer furniture, with space to mount a scope. Chambered in .45 ACP."
	icon_state = "commando"
	inhand_icon_state = "commando"
	mag_type = /obj/item/ammo_box/magazine/m45
	init_mag_type = /obj/item/ammo_box/magazine/m45/socom
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(0.8, 0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	silenced = TRUE
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 6
	scope_y_offset = 14

/* * * * * * * * * * *
 * Combat Carbine
 * Baseline .45 carbine
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/combat
	name = "American Commonwealth Carbine"
	desc = "A .45 semi-automatic combat carbine, produced Pre-Fall for National Guard forces."
	icon_state = "combat_rifle"
	inhand_icon_state = "combatrifle"
	mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	init_mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_tags = list(GUN_FA_MODDABLE)
	fire_sound = 'sound/f13weapons/combatrifle.ogg'

/* * * * * * * * * * *
 * Trusty Combat Carbine
 * Slightly softer .45 carbine
 * Less damage
 * less accurate
 * Powerful melee
 * With love
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/combat/worn/brim
	name = "Blessed Trusty Combat Carbine"
	desc = "A well loved .45 semi-automatic combat carbine, with so many parts replaced and fixed up that it wouldn't give the artisan who \
		maintained this thing enough credit to say it's a Pre-Fall design. Covered in forge marks where repairs were needed. While everything \
		looks to be of high-quality crafting, the precision of such parts look a bit... off, like a master swordsmith were asked to forge a \
		gun by hand. As such, the internal mechanisms and rifling are not <i>quite</i> the right size for a .45ACP round, and the sight \
		picture is a bit <i>Fuzzy</i>. Every part is, however, built as rugged as its maker, and can be used as a very effective melee \
		weapon without any risk of damaging it. Engraved at the stock is a shimmering green snake within a triangle"
	icon_state = "combat_rifle"
	inhand_icon_state = "combatrifle"
	mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	init_mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	weapon_class = WEAPON_CLASS_CARBINE
	force = GUN_MELEE_FORCE_RIFLE_HEAVIER
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = CARBINE_RECOIL(1, 1)
	added_spread = GUN_SPREAD_POOR

/* * * * * * * * * * *
 * Worn Combat Carbine
 * Slightly softer .45 carbine
 * Less damage
 * less accurate
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/combat/worn
	name = "Combat Carbine"
	desc = "A .45 semi-automatic combat carbine, produced Pre-Fall for National Guard forces. This one seems aged..."
	icon_state = "combat_rifle"
	inhand_icon_state = "combatrifle"
	mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	init_mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)

/* * * * * * * * * * *
 * 10/22ish carbine
 * .22 LR
 * Higher damage
 * Found all over the place
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/sportcarbine
	name = "sport carbine"
	desc = "One of the many .22 LR carbines that were all the rage before the war. While lacking in firepower, it more than makes up for it with its modularity and cheapness to fire."
	icon_state = "surplus"
	inhand_icon_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m22
	init_mag_type = /obj/item/ammo_box/magazine/m22/extended
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 // its a weakass cartridge
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_bayonet = TRUE
	bayonet_state = "bayonetstraight"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "leveraction_scope"
	scope_x_offset = 5
	scope_y_offset = 14
	can_suppress = TRUE
	suppressor_state = "suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/weapons/Gunshot2.ogg'

/* * * * * * * * * * *
 * M1-22 carbine
 * .22 LR
 * Higher damage
 * One, owned by a fox
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/sportcarbine/m1_22
	name = "M1-22 carbine"
	desc = "A one-of-a-kind M1 carbine chambered in .22 LR. Where it lacks in stopping power, it more than makes up for it with modularity and full auto support. Looks well cared for, if a bit fuzzy."
	icon_state = "m1carbine"
	inhand_icon_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m22
	init_mag_type = /obj/item/ammo_box/magazine/m22/extended
	weapon_class = WEAPON_CLASS_CARBINE
	damage_multiplier = GUN_EXTRA_DAMAGE_T1 // its a weakass cartridge
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto,
		/datum/firemode/automatic/rpm200
	)
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 5
	scope_y_offset = 14
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

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
	inhand_icon_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/small
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	can_scope = TRUE



/* * * * * * * * * * * *
* Matilda Rifle
* Lightweight low damage dealing rifle with a 20 mag only
* - 308 capacity mags
* - Unable to be modified with bayonets, flashlights or a scope
* * * * * * * * * * */

/obj/item/gun/ballistic/automatic/matildar
	name = "A11 'Matilda' Rifle"
	desc = "A Latos Systems A11 Matilda battle rifle. Was rarely used in Pre-Fall times but was issued to Canadian based PMC groups. Chambered in .308 ammunition."
	icon_state = "matilda"
	inhand_icon_state = "matilda"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 2)
	init_firemodes = list(/datum/firemode/semi_auto ,
	/datum/firemode/burst/two/fast
	)
	can_scope = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/* * * * * * * * * * *
 * Varmint Rifle w/ 20rd mag
 * Light semi-auto rifle
 * .223 / 5.56mm
 * Slow to fire
 * Literally the above, but it spawns with a bigger magazine
 *
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/varmint/extended
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle

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
	inhand_icon_state = "ratslayer"
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	gun_tags = list()
	silenced = TRUE
	can_scope = FALSE
	zoom_factor = 1.5
	suppressor_state = "none"
	fire_sound_silenced = 'sound/weapons/Gunshot_large_silenced.ogg'

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
	inhand_icon_state = "ratslayer"
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 //some extra oomf
	gun_tags = list()
	silenced = TRUE
	can_scope = FALSE
	zoom_factor = 1.5
	fire_sound_silenced = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * Knockoff ALR15
 * Tacticool, literally just a varmint
 * .223 / 5.56mm
 * Scopeable maybe?
 * Same damage, literally GUN_EXTRA_DAMAGE_0
 * Homie just wanted a resprite
 * Unique, doesn't have to be, throw it in the loot pool if you wanna be goofy
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/varmint/knockoffalr
	name = "ALR15"
	desc = "A 5.56x45mm rifle custom built off of a... plastic- that's not polymer, that's just straight-up plastic. What the fuck?"
	icon_state = "alr15"
	inhand_icon_state = "alr15"

/* * * * * * * * * * *
 * Bushmaster Arm Gun
 * Light semi-auto rifle... pistol thing
 * .223 / 5.56mm
 * Slow to fire
 * Inaccurate
 * Kicks all over the place
 * Suuuuuucks
 * But it makes a click!
 * And is tactical!
 * Unique (thankfully)
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun
	name = ".223 arm pistol"
	desc = "Be the envy of your platoon with comfortable firepower in a compact form factor, \
		the Operator's Choice Arm Pistol tactically molds its bullpup feed system to the user's physique, \
		able to swivel the patented Twistical Receivest to accommodate being held with its recommended \
		Point'N'Clik SwampWarrior stance. Arm yourself with the Arm Pistol!"
	icon_state = "arm_rifle"
	inhand_icon_state = "m90"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	/// sets if the gun is turnt
	var/turnt = FALSE
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_SEMI_AUTO

	gun_tags = list(GUN_SCOPE)
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 18
	knife_y_offset = 17

	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12

	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 22
	suppressor_y_offset = 24

	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 12
	flight_y_offset = 16
	actions_types = list(/datum/action/item_action/toggle_armgun)
	fire_sound = 'sound/f13weapons/ServiceRifle.ogg'

/// Silly proc that makes a click
/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun/proc/rotate_the_stupid_gun(mob/user)
	if(user)
		if(turnt)
			user.visible_message(
				"[user] snaps [user.p_their()] [src.name] back into place.",
				span_notice("With a quick, professional slap of the base of your palm, you deliver a precise karate-chop to the rear of your Arm Gun and snap that sucker back into place!")
			)
		else
			user.visible_message(
				"[user] clicks [user.p_their()] [src.name] to the side.",
				span_notice("With a tactical flourish, you grip the rear assembly of your Arm Gun and wrench that sucker to the side, snapping the receiver into comfortable operator mode!")
			)
	playsound(get_turf(src), 'sound/f13weapons/equipsounds/riflequip.ogg', 60, 1)
	turnt = !turnt

/* * * * * * * * * * *
 * Service Rifle
 * Baseline semi-auto rifle
 * .223 / 5.56mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/service
	name = "service rifle"
	desc = "A Pre-Fall semi-automatic rifle that saw extensive use with the US military. Chambered in 5.56x45 and capable of accepting bayonets, these rifles remain popular with militas and caravans alike."
	icon_state = "service_rifle"
	inhand_icon_state = "servicerifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	reskinnable_component = /datum/component/reskinnable/service_rifle

/* * * * * * * * * * * * * * * *
* Famas G80{generation}
* Whole generation of them. Upgrades in tier for their loot spawns. Worn spawn famas, Famas G1, P47, M41
* * * * * * * * * * * */
/obj/item/gun/ballistic/automatic/famas
	name = " Worn fusil assaut G80"
	desc = "An assault rifle,resembling a FAMAS, used by the Pre-Fall GIGN.Very worn down it seems but it was produced by the GIAT or now known as, before the bombs dropped, as Nexter systems. Features a somewhat fast fire rate for the burst, but deals less damage due to a lower caliber. Also it's bullpup."
	icon_state = "famas"
	inhand_icon_state = "famas"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	disallowed_mags = list (/obj/item/ammo_box/magazine/m556/rifle/extended, /obj/item/ammo_box/magazine/m556/rifle/extended/empty, /obj/item/ammo_box/magazine/m556/rifle/assault , /obj/item/ammo_box/magazine/m556/rifle/assault/empty )
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1.3, 1.3)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_bayonet = FALSE
	can_scope = FALSE
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/famas/pristine
	name = "Fusil D'assaut F1"
	desc = "A Famas, restored to a brand new state. Used heavily by french forces and the GIGN before the war."
	icon_state = "famas"
	inhand_icon_state = "famas"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1.5, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast ,
		/datum/firemode/burst/three
	)
	can_bayonet = FALSE
	can_scope = FALSE
	can_suppress = TRUE

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
	inhand_icon_state = "alr15"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
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
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = CARBINE_RECOIL(1, 1)
	can_scope = TRUE
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 15
	suppressor_x_offset = 26
	suppressor_y_offset = 28
	reskinnable_component = null

/* * * * * * * * * * *
 * Marksman carbine
 * Scoped semi-auto rifle
 * .223 / 5.56mm
 * Scope!
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/marksman
	name = "marksman carbine"
	desc = "A marksman carbine built off the AR platform chambered in 5.56x45. Seen heavy usage in Pre-Fall conflicts. This particular model is a civilian version and is semi-auto only."
	icon_state = "marksman_rifle"
	inhand_icon_state = "marksman"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	gun_tags = list(GUN_FA_MODDABLE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = FALSE
	zoom_factor = 1
	can_bayonet = FALSE
	bayonet_state = "rifles"
	knife_x_offset = 22
	knife_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "suppressor"
	suppressor_x_offset = 31
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/marksman_rifle.ogg'



// * * * * *
// * G43 rifle *
// + Heavy hitter for .308 with a buff of T1-T2, will adjust accordingly.
// + 10 round capacity, ok firerate.
// + can use as a crutch, this is a joke.
/* * * * * * * * * * * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/gewehr43
	name = "2100 G10 Rifle"
	desc = "A 2100s renditon of the G43 rifle, which was produced in the 1940s. Sturdy, reliable, it was quite the rifle back in the day. Now it seeks new purpose in the cold and decrypt wastelands of Texarka. Features a detatchable 10 round magazine, the bigger brother to its civilian counterpart."
	icon_state = "g43"
	inhand_icon_state = "g43"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	disallowed_mags = list(/obj/item/ammo_box/magazine/m308/ext , /obj/item/ammo_box/magazine/m308/ext/empty )
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = CARBINE_RECOIL(1.5, 1.6)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_suppress = TRUE
	can_bayonet = FALSE
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/ww1selfloader // tier above the G43 rifle. Powerful yet slow.
	name = "Selbstlader 1906 Rifle"
	desc = "A Selbstlader 1906 self-loading rifle. This rifle was patented back in the Great War. It now seeks service in the hands of the user. It seems the wood is a bit worn down but the caliber packs one hell of a punch."
	icon_state = "lugerrifle"
	inhand_icon_state = "lugerrifle"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/selfloaderinternal
	init_mag_type = /obj/item/ammo_box/magazine/internal/selfloaderinternal
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1.6, 1.7)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

// Civilian version of the G43, uses 5mm and has a 15 round capacity, faster firerate.
/obj/item/gun/ballistic/automatic/gewehr41civ
	name = "5mm Civilian G10 Rifle"
	desc = "A 2150 made rifle, this version is a more modern rendition of a Gewehr 41. A fixed magazine with a internal capacity of 15 rounds. It fires faster than its bigger brother but hits far less. Reliable and sturdy, it was a popular hunting rifle by East Germans for weaker game like turkey. Chambered in 5mm."
	icon_state = "g41"
	inhand_icon_state = "g41"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/gewehrinternal
	init_mag_type = /obj/item/ammo_box/magazine/internal/gewehrinternal
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1.2, 1.4)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_suppress = TRUE
	can_bayonet = FALSE
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/gewehr41civ/tox
	name = "Custom G41 rifle"
	desc = "A customized G41 rifle. While it can not hold a suppressor, it's still just as sturdy as before. The rifle itself is made of a lovingly made and polished maple wood. A scene of a moth and cat is etched into the stock of the rifle. The metal is engraved with baroque motifs. A weapon fit, for the Queen."
	icon_state = "g41"
	inhand_icon_state = "g41"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/gewehrinternal/tox
	init_mag_type = /obj/item/ammo_box/magazine/internal/gewehrinternal/tox
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1.2, 1.4)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_suppress = FALSE
	can_bayonet = FALSE
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

// Worn Marksman Carbine

/obj/item/gun/ballistic/automatic/marksman/worn
	name = "battle-worn marksman carbine"
	desc = "A marksman carbine built off the AR platform chambered in 5.56x45. Seen heavy usage in Pre-Fall conflicts. This particular model is a civilian version and is semi-auto only. This one seems worn with time..."
	icon_state = "marksman_rifle"
	inhand_icon_state = "marksman"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = RIFLE_RECOIL(1.4, 1.4)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_tags = list(GUN_FA_MODDABLE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = FALSE
	zoom_factor = 1
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
	desc = "A Pre-Fall Rifle that has been constantly repaired and rebuilt by the Nash Police Department. Held together by duct tape and prayers, it somehow still shoots."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "rifle-police"
	inhand_icon_state = "assault_carbine"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)
	can_suppress = FALSE
	can_scope = TRUE
	zoomable = FALSE
	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 21
	flight_y_offset = 21

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
	desc = "A Colt Rangemaster semi-automatic rifle, chambered for .30-06. Single-shot only."
	icon_state = "rangemaster"
	inhand_icon_state = "308"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/w3006
	init_mag_type = /obj/item/ammo_box/magazine/w3006
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1.6)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
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
	desc = "A self-loading rifle in .308. Semi-auto only."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "slr"
	inhand_icon_state = "slr"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 21
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 11
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/slr/stinki
	name = "Custom Enfield SLR"
	desc = "A custom self-loading rifle in .308. Semi-auto only."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "slr"
	inhand_icon_state = "slr"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
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
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "m1garand"
	inhand_icon_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/garand3006
	init_mag_type = /obj/item/ammo_box/magazine/garand3006
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	gun_tags = list(GUN_SCOPE)
	en_bloc = 1
	auto_eject = 1
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

// /obj/item/gun/ballistic/automatic/m1garand/attackby(obj/item/A, mob/user, params)
// 	. = ..()
// 	if(.)
// 		return

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
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)

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
	desc = "A meticulously restored, scoped M1C Garand. This one is rumored to have originated from some republic out west."
	icon_state = "republics_pride"
	inhand_icon_state = "scoped308"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)

	zoom_factor = 1.2
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
	desc = "An old, semi-automatic rifle of communist origin. Still, it packs a punch and has a bayonet lug."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "sks"
	inhand_icon_state = "sks"
	mag_type = /obj/item/ammo_box/magazine/sks
	init_mag_type = /obj/item/ammo_box/magazine/sks
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)

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
	desc = "A DKS 501, chambered in .30-06 Springfield.  With a light polymer body, it's suited for long treks through the desert."
	icon_state = "sniper_rifle"
	inhand_icon_state = "sniper_rifle"
	mag_type = /obj/item/ammo_box/magazine/w3006
	init_mag_type = /obj/item/ammo_box/magazine/w3006
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T4
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(/datum/firemode/semi_auto/slower)

	can_bayonet = FALSE
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	zoom_factor = 2

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
	desc = "A DKS 501, chambered in .30-06 Springfield. This one has a gold trim and the words 'Old Cassius' engraved into the stock."
	icon_state = "gold_sniper"
	inhand_icon_state = "gold_sniper"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5

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
	desc = "A customized sniper rifle, fitted with a telescopic sight for extreme accuracy and chambered for a high-ballistic performance centerfire cartridge."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "venator_sniper"
	inhand_icon_state = "venator_sniper"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0

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
	desc = "A DKS 501, chambered in .30-06.  With a light polymer body, it's suited for long treks through the desert. This particular model is lighter and faster."
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0

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
	desc = "The assault rifle variant of the R84, based off the Pre-Fall FN FNC. It saw use with Pre-Fall special forces and assault troops, now it's often used by the richest militas and the lucky few to survive looting Pre-Fall depots."
	icon_state = "R82"
	inhand_icon_state = "R84"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = LMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 28
	reskinnable_component = null

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
	inhand_icon_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)
	can_bayonet = FALSE
	bayonet_state = "rifles"
	knife_x_offset = 23
	knife_y_offset = 11
	can_suppress = TRUE
	suppressor_x_offset = 32
	suppressor_y_offset = 15
	suppressor_state = "ar_suppressor"
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/* * * * * * * * * * *
 * Infiltrator service rifle
 * Quiet 5.56mm autorifle
 * .223 / 5.56mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	name = "infiltrator"
	desc = "A customized R91 assault rifle, with an integrated suppressor, small scope, cut down stock and polymer furniture. Quiet, but deadly."
	icon_state = "infiltrator"
	inhand_icon_state = "fnfal"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2 //needs a lil edge at least
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1.5, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)
	can_suppress = FALSE
	silenced = TRUE
	can_bayonet = FALSE
	can_scope = FALSE
	fire_sound_silenced = 'sound/weapons/Gunshot_large_silenced.ogg'
	zoom_factor = 0.8

/* * * * * * * * * * *
 * R93 PDW rifle
 * Baseline 5.56mm autorifle
 * .223 / 5.56mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/r93
	name = "R93 PDW"
	desc = "A lightweight, post-war successor of the R91 assault rifle. Exactly who made these is unknown, but it's perfect for a shooter on the move."
	icon_state = "r93"
	inhand_icon_state = "r93"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)
	can_scope = FALSE
	can_bayonet = FALSE
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'

/* * * * * * * * * * *
 * Type 93 assault rifle
 * Chinese 5.56mm AN-94-like rifle
 * .223 / 5.56mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/type93
	name = "type 93 assault rifle"
	desc = "The Type 93 Chinese assault rifle was designed and manufactured by a Chinese industrial conglomerate for the People's Liberation Army during the Resource Wars. Has a unique burst-fire mechanism, where it fires two bullets very quickly, staying accurate, but leading to an increased pause between follow-up shots. Chambered in 5.56x45."
	icon_state = "type93"
	inhand_icon_state = "handmade_rifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1, 1.5)
	init_firemodes = list(
		/datum/firemode/burst/two/fastest,
	)
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 27
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

/obj/item/gun/ballistic/automatic/type93/worn //156 dps
	name = "\improper Worn Type 93"
	desc = "This Type 93 Chinese assault rifle looks like it has been restored in a garage. The bore is shot to hell, the threading is destroyed, and so is the burst fire mechanism- it seems to fire unevenly, spraying more bullets than before."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "type93"
	inhand_icon_state = "handmade_rifle"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/burst/two/fastest
	)

	can_suppress = FALSE

///////////////////////////////
//// M41 Battle Rifle ///////
/// + fast burst fire rate////
// + .308 ammunition. //////
// + Has zoom built in /////
// -Takes only 10 round magazines/////
// - Burns ammo like a ford pickup does gas ///
///////////////////////////////////////

/obj/item/gun/ballistic/automatic/m41br
	name = "m41 battle rifle"
	desc = "This rifle is a Jaeger company battle rifle. This battle rifle comes with a built in scope, ammo counter. This rifle is chambered in 7.62 but can use .308. It seems the magazines it can use is only small .308 magazines."
	icon_state = "m41r"
	inhand_icon_state = "m41r"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	disallowed_mags = list (/obj/item/ammo_box/magazine/m308/ext, /obj/item/ammo_box/magazine/m308/ext/empty)
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 1.5)
	init_firemodes = list(/datum/firemode/burst/three/fast
	)
	can_suppress = FALSE
	can_scope = FALSE
	can_flashlight = FALSE
	zoom_factor = 1.2
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'


/* * * * * * * * * *
* P47 Battle rifle
* + Uncommon version of the M41 BR
* - Lower damage and caliber
* + Takes 20 and 10 round magazines compared to M41 10 round standard
* + Less recoil
* + Takes modifications unlike the M41 BR
* * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/p47
	name = "P47 Battle rifle"
	desc = "A P47 Battle Rifle or 'P47BR'. A collaboration between Jaeger company and Leo Armaments to appeal to the civilian and hunter markets, this rifle is chambered in .308 UNMC NATO rounds. The rifle has a bullpup configuration and has a built in ammo counter. It's also lightweight, allowing it to be holstered around the hip or the back for ease of carry."
	icon_state = "p47"
	inhand_icon_state = "p47"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1.6, 1.4)
	init_firemodes = list(/datum/firemode/burst/three/slower ,
	/datum/firemode/semi_auto/slow
	)
	can_suppress = TRUE
	can_scope = TRUE
	can_flashlight = FALSE
	zoom_factor = 0.9
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/p47merek
	name = "Custom P47 Rifle"
	desc = "A personalized P47 battle rifle, the firemode has been changed to become much slower while missing a built in scope which has to be replaced. The ammo counter still works."
	icon_state = "p47"
	inhand_icon_state = "p47"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	disallowed_mags = list(/obj/item/ammo_box/magazine/m556/rifle/extended, /obj/item/ammo_box/magazine/m556/rifle/extended/empty, /obj/item/ammo_box/magazine/m556/rifle/assault ,/obj/item/ammo_box/magazine/m556/rifle/assault/empty)
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/burst/two/slower,
		/datum/firemode/semi_auto/slower
	)
	can_suppress = FALSE
	can_scope = TRUE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

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
	desc = "The ultimate refinement of the sniper's art, the Bozar is a scoped, accurate, light machine gun that will make nice big holes in your enemy. Uses 5.56x45."
	icon_state = "bozar"
	inhand_icon_state = "sniper"
	slot_flags = INV_SLOTBIT_BACK
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/burst/two/fast
	)
	zoomable = TRUE
	fire_sound = 'sound/f13weapons/bozar_fire.ogg' // to be replaced with the honking noise
	zoom_factor = 1.2

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
	inhand_icon_state = "assault_carbine"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three,
		/datum/firemode/semi_auto
	)
	can_scope = FALSE
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
	fire_sound = 'sound/f13weapons/assault_carbine.ogg'
	reskinnable_component = /datum/component/reskinnable/auto_556

/* * * * * * * * * * *
 * Police Assault Rifle
 * Baseline 5mm autorifle
 * 5mm
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/assault_carbine/policerifle
	name = "Police Assault Rifle"
	desc = "A Pre-Fall Rifle that has been constantly repaired and rebuilt by the Nash Police Department. Held together by duct tape and prayers, it somehow still shoots."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "rifle-police"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTORIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)
	can_scope = FALSE
	reskinnable_component = null

/////////////////////////
/// M5A1 Assault rifle////
/////////////////////////

/obj/item/gun/ballistic/automatic/assault_carbine/m5a1 //faster by a small amount , 5mm AR.
	name = "M5A1 rifle"
	desc = "A pristine looking assault rifle created by Leo Arments for PMC companies and squadrons, named after a WW2 tank.It comes with a built in ammo counter. It's made in a bullpup configuration and takes a rifle version of 5mm but makes up for such a odd ordeal with an increased fire rate."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "m5a1"
	inhand_icon_state = "m5a1"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = AUTOCARBINE_RECOIL(1.7, 1.3)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE
	reskinnable_component = null

/obj/item/gun/ballistic/automatic/assault_carbine/m5a1/woof //slightly slower than the m5a1
	name = "Custom Standard Issue M5A1 rifle"
	desc = "A pristine looking assault rifle created by Leo Arments for PMC companies and squadrons, named after a WW2 tank.It comes with a built in ammo counter. It's made in a bullpup configuration and takes a rifle version of 5mm but makes up for such a odd ordeal with an increased fire rate. This particular m5a1 has particular work done to its stabilizer to prevent a good chunk of the recoil, at the cost of its fire rate."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "m5a1"
	inhand_icon_state = "m5a1"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = AUTOCARBINE_RECOIL(1.4 , 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100,
		/datum/firemode/semi_auto
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE
	reskinnable_component = null


/obj/item/gun/ballistic/automatic/assault_carbine/scarrifle
	name = "Scar-L rifle"
	desc = "A Scar-L assault rifle. This assault rifle, produced in 5mm than 5.56x45 NATO, was manufactured by FN Herstal in the early 2100s. Versitile, functional, and good. It comes witha a slow ROF and a lovely stock, albeit this one seems fixed sadly. Why change a design that works? As FN says!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "scarl"
	inhand_icon_state = "scarl"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = AUTOCARBINE_RECOIL(1.5, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100,
		/datum/firemode/semi_auto
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE


/obj/item/gun/ballistic/automatic/assault_carbine/aug5mm
	name = "AUG A10 rifle"
	desc = "A AUG A10 assault rifle. This assault rifle, produced in 5mm than 5.56x45 NATO, was manufactured by Steyr in the 2100s. This rifle saw extensive usage by the Pre-Fall Austrian forces. Comes with a built in scope."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "aug"
	inhand_icon_state = "aug"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = AUTOCARBINE_RECOIL(1.5, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100,
		/datum/firemode/semi_auto
	)
	zoom_factor = 0.8
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE

/obj/item/gun/ballistic/automatic/assault_carbine/aug5mm/aldric
	name = "AUG P-Skulljack"
	desc = "A AUG A10 assault rifle. Comes with a built in scope. It seems to be custom owned by someone."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/assault_carbine/aug5mm/custom
	name = "R-varlden mock bullpup "
	desc = "A modified Aug 5mm rifle, it's rate of fire has been altered compared to a stock rifle of it's kind, this one has some alien letters painted in a teal blue on it, with their english counter parts underneath it reading 'Erik CDXCII'"
	init_recoil = AUTOCARBINE_RECOIL(1.4, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75,
		/datum/firemode/semi_auto
	)
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "augc"
	inhand_icon_state = "augc"

/obj/item/gun/ballistic/automatic/assault_carbine/aug5mm/asvalcustom
	name = "Custom 'Cold Whisper'Assault Carbine "
	desc = "A modified 9mm AS-VAL assault carbine. Rechambered to be in 5mm, this rifle fires much slower than its little, but older, brother which is in 9mm. The gun seems custom built and produced for someone."
	init_recoil = AUTOCARBINE_RECOIL(1.3, 1.1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75,
		/datum/firemode/semi_auto
	)
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "vss"
	inhand_icon_state = "vss"
	silenced = TRUE
	can_scope = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE

/obj/item/gun/ballistic/automatic/assault_carbine/psg5mm
	name = "PSG-5 rifle"
	desc = "A PSG-5 battle rifle. This battle rifle, produced in 5mm than 7.62 NATO, was manufactured by Heckler & Koch in the 2100s. This rifle saw extensive usage by the Pre-Fall West German forces. Comes with a upgradable scope."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "psg1"
	inhand_icon_state = "psg1"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = AUTOCARBINE_RECOIL(1.5, 1.4)
	init_firemodes = list(/datum/firemode/semi_auto/slow)
	zoom_factor = 1.3
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE

/* * * * * * * * * * *
* AK74
* + fast firerate
* - 5mm
* * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/ak556 // faster 5mm rifle, base damage.
	name = "Ak-74 assault rifle"
	desc = "A AK74 assault rifle. Rechambered in 5mm Rifle NATO , this assault rifle was the answer for a more lighter and far more easier to carry. Even allows for being able to be slung around or against the back or hip of someone. This one seems to be an all black version, no wooden furniture in sight it seems."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	inhand_icon_state = "ak74"
	icon_state = "ak74"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(1.4, 1.6)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200 ,
		/datum/firemode/semi_auto
		)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/ak556/custom // Custom
	name = "Custom Ak-74 assault rifle"
	desc = "A AK74 assault rifle. Rechambered in 5mm Rifle NATO , this assault rifle was the answer for a more lighter and far more easier to carry. Even allows for being able to be slung around or against the back or hip of someone. This one seems to be an all black version, no wooden furniture in sight it seems."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	inhand_icon_state = "ak74"
	icon_state = "ak74"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(1.4, 1.6)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100 ,
		/datum/firemode/semi_auto
		)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

//Saiga 12 shotgun
/obj/item/gun/ballistic/automatic/saiga12k
	name = "Saiga-12 Assault shotgun"
	desc = "A 12g Saiga-12 shotgun. Manufactured in Russia, this shotgun is as reliable as they get. 8 shot capacity, decent firerate. It's good for hunting stags!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	inhand_icon_state = "saiga"
	icon_state = "saiga"
	mag_type = /obj/item/ammo_box/magazine/saiga
	init_mag_type = /obj/item/ammo_box/magazine/saiga
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(2, 1.8)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75 ,
		/datum/firemode/semi_auto/slow
	)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_scope = FALSE
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/aksmol
	name = "Ak74u"
	desc = "A AK74u assault rifle. Rechambered in 5.56x45 NATO, this assault rifle was the answer for a more lighter assault rifle. This one comes with wood furniture and has no stock, hits a shy bit harder, slower firerate, and allows much easier carry at the cost of higher recoil."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	inhand_icon_state = "ak74utest"
	icon_state = "ak74utest"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = AUTORIFLE_RECOIL(1.5, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_scope = TRUE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/aksmol/aldric //custom weapon, unused.
	name = "Ak74u Custom"
	desc = "A customized AK74u assault rifle. Rechambered in 5.45x39 NATO, this assault rifle was the answer for a more lighter assault rifle. This one comes with wood furniture and has no stock, allowing much easier carry at the cost of higher recoil."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	inhand_icon_state = "ak74utest"
	icon_state = "ak74utest"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = AUTORIFLE_RECOIL(1.3, 1.3)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100,
		/datum/firemode/semi_auto
	)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_scope = TRUE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

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
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/burst/five/fast,
		/datum/firemode/semi_auto
	)
	reskinnable_component = null

/* * * * * * * * * * *
 * FN FAL Rifle
 * Baseline 7.62 autorifle
 * .308 / 7.62
 * Uncommon
 * 207 dps
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/fnfal
	name = "FN FAL"
	desc = "This rifle has been more widely used by armed forces than any other rifle in history. It's a reliable weapon for any terrain or tactical situation."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "fnfal"
	inhand_icon_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

//259 dps pristine version
/obj/item/gun/ballistic/automatic/fnfal/pristine
	damage_multiplier = GUN_EXTRA_DAMAGE_T2


/* * * * * * * * * * * *
* Zastava Rifle
* + takes all 308 magazines
* + spawn tier.
* - slowest firerate
* + built in scope
* - unable to be heavily modified like any else rifle
* * * * * * * * * * * * * * * * * * * * * * * * * * * */
/obj/item/gun/ballistic/automatic/z34rifle
	name = "Z34 Battle Rifle"
	desc = "The Soviet Z34 battle rifle. Based off the SLR or FN FAL, it is chambered in 7.62 Soviet. Now rechambered in .308, the weapon itself comes with a scope and seems to have a much heavier trigger than most rifles."
	icon_state = "zastava"
	inhand_icon_state = "zastava"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2.5, 2.5)
	init_firemodes = list (
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_flashlight = FALSE
	zoom_factor = 1.1
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/z34rifle/needlercustom
	name = "The People's Rifle"
	desc = "A Chinese-made Type 79 marksman rifle, a knockoff of the soviet Dragunov SVD produced for the PRC's army units and special forces. This one appears to be particularly weathered from time in the wastes, a faded red cloth wrapped around a scuffed stock, some scratches on the gun metal, and some text etched onto the PSO-1 scope in Chinese."
	icon_state = "zastava"
	inhand_icon_state = "zastava"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/needlesvd
	init_mag_type = /obj/item/ammo_box/magazine/internal/needlesvd
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 1.9)
	init_firemodes = list (
		/datum/firemode/semi_auto/slower
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_flashlight = FALSE
	zoom_factor = 0.9
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/z34rifle/custom
	name = "Z34 Battle Rifle"
	desc = "The Soviet Z34 battle rifle. Based off the SLR or FN FAL, it is chambered in 7.62 Soviet. Now rechambered in .308, the weapon itself comes with a scope and seems to have a much heavier trigger than most rifles."
	icon_state = "zastava"
	inhand_icon_state = "zastava"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(3, 3)
	init_firemodes = list (
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	can_suppress = TRUE
	can_flashlight = FALSE
	zoom_factor = 1
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/fnfal/ak47 //slow ROF, hits like a truck. Slow counterpart to the G3
	name = "Retro AK-47"
	desc = "This rifle is modeled after an older, reliable, and mass produced version of the AK-47. Comes with wood furniture and a Warsaw pact rail, which was mainly used for the PSO-1 sight. Sadly it seems to take only extended .308 magazines."
	icon_state = "trueak"
	inhand_icon_state = "trueak"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2.0, 2.0)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75,
		/datum/firemode/semi_auto/slow
	)
	can_scope = TRUE
	can_suppress = FALSE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'


/obj/item/gun/ballistic/automatic/fnfal/ak47/custom
	name = "Engraved Zastava M70"
	desc = "A custom AK platform weapon. This Zastava M70 is gold plated with faint traces of a black tigerstripe alongside the magazine and reciever. The wood furniture is made of the best and most pristine wood there is. Albeit it hits less and can not take a select few modifications. On the pistol grip is a red star in the middle."
	icon_state = "goldak"
	inhand_icon_state = "goldak"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2.5, 2.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75,
		/datum/firemode/semi_auto/slow
	)
	can_scope = FALSE
	can_suppress = TRUE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/rifle47mm
	name = "Sig Rifle 550"
	desc = "A SIG SG 550 rechambered in 4.7mm caseless ammo. Despite the new caliber type, it performs as one would expect which is precise, quick, and customizable. The gun fires a bit quicker and feels a tad bit lighter to carry."
	icon_state = "sigrifle"
	inhand_icon_state = "R82"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/rifle47mm
	init_mag_type = /obj/item/ammo_box/magazine/rifle47mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1.7, 1.6)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150 ,
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_flashlight = FALSE

/obj/item/gun/ballistic/automatic/rifle47mm/china
	name = "Chinese 4.7mm assault rifle"
	desc = "A QBZ-95-1 assault rifle rechambered in 4.7mm caseless ammo, a odd collab between West Germany's 4.7mm cartridge and the PLA. Despite the new caliber type, it performs like its own original caliber. The gun seems to fire quicker and is a shy bit more accurate with lesser recoil!"
	icon_state = "chinarifle"
	inhand_icon_state = "famas"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/rifle47mm
	init_mag_type = /obj/item/ammo_box/magazine/rifle47mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1.5, 1.4)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200 ,
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_flashlight = FALSE



/obj/item/gun/ballistic/automatic/fnfal/g3battlerifle // Less damage dealing than the AK47 but has a high ROF and good recoil.
	name = "G3M99"
	desc = "A battle rifle chambered in 7.62 NATO, this revised battle rifle was used extensively by West Germany and still in use today by wasters, wasteland PMCs, and raiders for being quite reliable. The charging handle needs to be pulled back after emptying a whole magazine. Rechambered for .308 ammunition."
	icon_state = "g3"
	inhand_icon_state = "g3"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1.3, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto ,
		/datum/firemode/automatic/rpm200
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/* * * * * * * * * * *
 * AR-10 Armalite
 * .308 semi-auto rifle
 * .308 / 7.62
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/armalite
	name = "AR-10 Armalite"
	desc = "A blast from the past as a ruggled, reliable rifle. Accurate and packs a punch, but recoil picks up quick, and it's heavy. Makes it suitable for bashing skulls, at least..."
	icon_state = "armalite"
	inhand_icon_state = "assault_carbine"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1.5, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)


/* * * * * * * * * * *
 * L1A1 Self Loading Rifle
 * .308 semi-auto rifle
 * .308 / 7.62
 * Uncommoner
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/l1a1
	name = "L1A1"
	desc = "The L1A1 Self-Loading Rifle, The standard issue rifle of All Commonwealth Nations."
	icon_state = "l1a1"
	inhand_icon_state = "l1a1"
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1, 0.9)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//custom gun
/obj/item/gun/ballistic/automatic/fg42tox
	name = "Custom FG-42 rifle"
	desc = "A customized FG-42 rifle. This rifle was developed for paratroopers during WW2. A rather nifty and reliable rifle if not unbalanced due to a heavier magazine located on the left side. Comes witha a right-sided charging handle and a foldable bipod. This one seems to come with a scope! The rifle itself is made of a lovingly made and polished maple wood. A scene of a moth and cat is etched into the stock of the rifle. The metal is engraved with baroque motifs. A weapon fit, for the Queen."
	icon_state = "fg42"
	inhand_icon_state = "fg42"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/fallschirm
	init_mag_type = /obj/item/ammo_box/magazine/fallschirm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_C1
	init_recoil = CARBINE_RECOIL(1, 0.9)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast ,
		/datum/firemode/automatic/rpm100
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_suppress = FALSE
	can_bayonet = FALSE
	zoom_factor = 0.9
	fire_sound = 'sound/f13weapons/fg42.ogg'



/obj/item/gun/ballistic/automatic/democracy
	name = "M36 'Justice' battle rifle"
	desc = "A M36 battle rifle, nicknamed 'Justice' by the company that produced it. Manufactured by an American division of Leo Armaments, which was quite patriotic. This rfle is chambered in .308. It seems to have a slow RPM and fast semi-automatic"
	icon_state = "m36"
	inhand_icon_state = "m36"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1.8, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto ,
		/datum/firemode/automatic/rpm100
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_suppress = TRUE
	can_bayonet = FALSE

/* * * * * * * * * * *
 * Browning Automatic BAR Rifle
 * Baseline 7.62 autorifle
 * .308 / 7.62
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/bar
	name = "browning automatic rifle"
	desc = "An ancient machine gun that looks like outdated even by Pre-Fall standards. It has Colt etched on one-side and Sierra Madre on the other. It is alarmingly heavy for a rifle."
	icon = 'icons/fallout/objects/guns/bar.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "BAR"
	inhand_icon_state = "BAR"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/* * * * * * * * * * *
 * G11 Rifle
 * Fancy 4.73mm autorifle
 * 4.73mm caseless
 * Fast firing!
 * Uncommon unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/g11
	name = "G11"
	desc = "This experimental gun fires a caseless cartridge consisting of a block of propellant with a bullet buried inside. The weight and space savings allows for a very high magazine capacity. Chambered in 4.73mm."
	icon_state = "g11"
	inhand_icon_state = "g11"
	mag_type = /obj/item/ammo_box/magazine/m473
	init_mag_type = /obj/item/ammo_box/magazine/m473
	disallowed_mags = list(/obj/item/ammo_box/magazine/m473/small, /obj/item/ammo_box/magazine/m473/small/empty)
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T4
	init_recoil = SMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/burst/three/fastest,
		/datum/firemode/semi_auto/fast
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE

// Custom rifle, loadout only. ETA to becoming a 5mm or 5.56 rifle TBA
/obj/item/gun/ballistic/automatic/g36 //unused, note from Tox: Will redo entirely eventually
	name = " G36C Assault rifle"
	desc = "A G36C base"
	icon_state = "g36"
	inhand_icon_state = "g36"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m556
	init_mag_type = /obj/item/ammo_box/magazine/m556
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1.5, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC
	can_suppress = TRUE
	can_bayonet = FALSE

//worn g11

/obj/item/gun/ballistic/automatic/g11/tox
	name = "Tox's G11M"
	desc = "A unique G11. With a built in scope, this G11 was bought and repurposed by a wealthy felid named Tox Mckit. Etched on the reciever is a lovely motif of moths and felines surrounding one singular feline under a full moon. On the scope is an engraving that says 'To the sands we stride on'."
	icon_state = "g11c"
	inhand_icon_state = "g11"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m473custom
	init_mag_type = /obj/item/ammo_box/magazine/m473custom
	disallowed_mags = list(/obj/item/ammo_box/magazine/m473/small, /obj/item/ammo_box/magazine/m473/small/empty)
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow ,
		/datum/firemode/burst/three/slower
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = FALSE
	zoom_factor = 1

/* * * * * * * * * * *
 * WT-550 Carbine
 * 4.73mm caseless
 * Spaceman gun
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/wt550
	name = "WT-550 PDW"
	desc = "The WT-550 is a Personal Defense Weapon manufactured by West-Tek. Similar to the P90, it was intended to be a concealable weapon able to penetrate body armor. Considering how rare this weapon is, it seems it wasn't very popular."
	inhand_icon_state = "m90"
	icon_state = "wt550"
	mag_type = /obj/item/ammo_box/magazine/m10mm_p90
	init_mag_type = /obj/item/ammo_box/magazine/m10mm_p90
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = CARBINE_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)
	can_bayonet = TRUE
	knife_x_offset = 25
	knife_y_offset = 12

/obj/item/gun/ballistic/automatic/wt550/worn
	name = "WT-550 Sporting Carbine"
	desc = "A WT-550 locked to semi-automatic and marketed for sport shooting or home defense. This one looks like it has seen better days."
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/* * * * *
* LMGs*
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
	desc = "A light machinegun using 60 round belts fed from an ammobox, its one of the few heavy weapons designs still commonly found."
	icon_state = "R84"
	inhand_icon_state = "R84"
	mag_type = /obj/item/ammo_box/magazine/lmg
	init_mag_type = /obj/item/ammo_box/magazine/lmg
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = LMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200
	)
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
	inhand_icon_state = "lsw"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/extended
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = LMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200
	)
	zoom_factor = 1
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

//hefty and clonky
/obj/item/gun/ballistic/automatic/lewis
	name = "Lewis automatic rifle"
	desc = "A relic of a gun, featuring an obscenely heavy watercooled barrel and a high capacity pan magazine."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	icon_state = "lewis"
	inhand_icon_state = "lewis"
	mag_type = /obj/item/ammo_box/magazine/lewis
	init_mag_type = /obj/item/ammo_box/magazine/lewis/l47
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = LMG_RECOIL(1.2, 1.2)
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	init_firemodes = list(
		/datum/firemode/automatic/rpm150
	)

/obj/item/gun/ballistic/automatic/lewis/dp27
	name = "DP-27"
	desc = "An old Soviet light machinegun with a high capacity pan magazine."
	icon = 'modular_coyote/icons/objects/mgs.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "dp"
	inhand_icon_state = "R84"
	mag_type = /obj/item/ammo_box/magazine/lewis/l47
	init_mag_type = /obj/item/ammo_box/magazine/lewis/l47


//less damage than the M1919, but more compact magazines that hold more
/obj/item/gun/ballistic/automatic/lewis/lanoe
	name = "Lewis Mark II"
	desc = "This machinegun came right off a fightercraft from the first World War. It trades an extra heavy cooling system for an extra heavy magazine."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	icon_state = "lanoe"
	inhand_icon_state = "lanoe"
	mag_type = /obj/item/ammo_box/magazine/lewis
	init_mag_type = /obj/item/ammo_box/magazine/lewis
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = LMG_RECOIL(1.2, 1.2)
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	init_firemodes = list(
		/datum/firemode/automatic/rpm150
	)

/obj/item/gun/ballistic/automatic/bren
	name = "Bren gun"
	desc = "A rather heavy gun that served as the primary British infantry LMG throughout the second world war."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	icon_state = "bren"
	inhand_icon_state = "bren"
	mag_type = /obj/item/ammo_box/magazine/bren
	init_mag_type = /obj/item/ammo_box/magazine/bren
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = LMG_RECOIL(1.2, 1.2)
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	init_firemodes = list(
		/datum/firemode/automatic/rpm200
	)

/obj/item/gun/ballistic/automatic/bren/custom
	name = "Custom Bren gun"
	desc = "A rather heavy gun that served as the primary British infantry LMG throughout the second world war."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	icon_state = "bren"
	inhand_icon_state = "bren"
	mag_type = /obj/item/ammo_box/magazine/bren
	init_mag_type = /obj/item/ammo_box/magazine/bren
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T3
	init_recoil = LMG_RECOIL(1.2, 1.2)
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	init_firemodes = list(
		/datum/firemode/automatic/rpm75 ,
		/datum/firemode/semi_auto/slower
	)


/* * * * * * * * * * *
 * Ratling Gun
 * A getto minigun
 * Terrible overall
 * Except that it shoots a lot of ammo and fast
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/ratling_gun
	name = "Ratling Gun"
	desc = "This 'machinegun' looks like junk, some one took a old gatling gun and bolted on a motor of some kind and box hooked on the side with welded on 'grips'. Some how it seems to work."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "ratling"
	inhand_icon_state = "minigun"
	mag_type = /obj/item/ammo_box/magazine/ratling
	init_mag_type = /obj/item/ammo_box/magazine/ratling
	weapon_class = WEAPON_CLASS_RIFLE
	added_spread = GUN_SPREAD_SUPERAWFUL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T6
	init_recoil = LMG_RECOIL(1.2, 1.2)
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 2
	init_firemodes = list(
		/datum/firemode/automatic/rpm150
	)


/* * * * * * * * * * *
* RPD-72
* 7.62 russian LMG
* - custom magazine capacity only, takes nothing else.
* - low ROF
* - debuffed damage to compensate it having high drum capacity
* - Rare LMG
* - High recoil with slowdown
* * * * * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/rpd
	name = "Russian RPK LMG"
	desc = "A soviet made Russian LMG. Known as the RPK, ths LMG was champered in 7.62 Soviet. Now rechambered to .308 with a 40 drum mag, it has quite the kick for recoil and a bit heavy."
	icon_state = "rpd"
	inhand_icon_state = "rpd"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/rpd
	init_mag_type = /obj/item/ammo_box/magazine/rpd
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = LMG_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE

/* * * * * * * * * * *
* Oststrauß
* 5.56 German LMG
* - 60rnd Box only
* - Fast and Faster RoF
* - Harder Hitting
* - Unique
* - High recoil with slowdown
* * * * * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/fastlmg
	name = "Oststrauß"
	desc = "A OstStrauss LMG, this LMG is chambered in 5.56x45 NATO. The gun itself was created as the great great grandson of the distant past MG3, which was derived from the MG-42 which was derived from the MG-34. With a fast fire rate and a toggle between 'slow' and 'fast', it is a LMG perfect for squad cover. Albiet it eats ammo like no tomorrow."
	inhand_icon_state = "mg3"
	icon_state = "mg3"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/lmg
	init_mag_type = /obj/item/ammo_box/magazine/lmg
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.7
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = LMG_RECOIL(1.6, 1.6)
	init_firemodes = list(
		/datum/firemode/automatic/rpm300 ,
		/datum/firemode/automatic/rpm75
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE


/obj/item/gun/ballistic/automatic/concussive
	name = "Latos Systems Cromwell-55 shotgun rifle"
	desc = "A 40mm buckshot Cromwell-55 shotgun rifle manufactured by Latos Systems. The rifle itself is quite a chunky one but the rifle itself seems to be quite alien in appearance, a prototype rifle if anything."
	inhand_icon_state = "crifle"
	icon_state = "crifle"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/grenadeshotgun
	init_mag_type = /obj/item/ammo_box/magazine/internal/grenadeshotgun
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = SHOTGUN_RECOIL (1.3 , 1.3)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE

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
	desc = "This ancient machine gun has been dug up and put into working order by the Dallas Militia. It's loud, heavy and terrifying."
	icon_state = "M38"
	inhand_icon_state = "M38"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/mm308
	init_mag_type = /obj/item/ammo_box/magazine/mm308
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = LMG_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200
	)
	var/cover_open = FALSE
	var/require_twohands = FALSE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/m1919/update_icon()
	icon_state = "M38[cover_open ? "open" : "closed"][magazine ? CEILING(get_ammo(0)/20, 1)*20 : "-empty"]"
	inhand_icon_state = "M38[cover_open ? "open" : "closed"][magazine ? "mag" : "nomag"]"

/obj/item/gun/ballistic/automatic/m1919/examine(mob/user)
	. = ..()
	if(cover_open && magazine)
		. += span_notice("It seems like you could use an <b>empty hand</b> to remove the magazine.")

/obj/item/gun/ballistic/automatic/m1919/attack_self(mob/user)
	cover_open = !cover_open
	to_chat(user, span_notice("You [cover_open ? "open" : "close"] [src]'s cover."))
	if(cover_open)
		playsound(user, 'sound/weapons/sawopen.ogg', 60, 1)
	else
		playsound(user, 'sound/weapons/sawclose.ogg', 60, 1)
	update_icon()

/obj/item/gun/ballistic/automatic/m1919/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		to_chat(user, span_warning("[src]'s cover is open! Close it before firing!"))
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
		to_chat(user, span_notice("You remove the magazine from [src]."))
		playsound(user, 'sound/weapons/magout.ogg', 60, 1)

/obj/item/gun/ballistic/automatic/m1919/attackby(obj/item/A, mob/user, params)
	if(!cover_open && istype(A, mag_type))
		to_chat(user, span_warning("[src]'s cover is closed! You can't insert a new mag."))
		return
	..()



////////
//MISC//
////////

/obj/item/gun/ballistic/automatic/needlerrifle
	name = "Worn NR-43 Turán"
	desc = "A old albeit well aged NR-43 prototype needle rifle also known as the 'Turan' in its country of origin. Manufactured by Latos Systems in a facility in Miskolc,Hungary. While this carbine is quick and lightweight, what it likes in firepower, it makes up for a rather peculiar design, built in scope, and expansive ammo capsules. A wise soldier once said.. 'Tell 'em to make it count.' Sadly the user of this weapon is a big dork."
	icon_state = "needles"
	inhand_icon_state = "needles"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/needlerammo
	init_mag_type = /obj/item/ammo_box/magazine/internal/needlerammo
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	draw_time = GUN_DRAW_NORMAL
	init_recoil = CARBINE_RECOIL (1 , 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	zoom_factor = 1
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = TRUE
	fire_sound = 'sound/f13weapons/needler.ogg'

/obj/item/gun/ballistic/automatic/needlerrifle/custom
	name = "Advanced Violet Needler Rifle"
	desc = "A custom and violet colored NR-43 prototype needle rifle also known as the 'Turan' in its country of origin. Manufactured by Latos Systems in a facility in Miskolc,Hungary. While this carbine is quick and lightweight, what it likes in firepower, it makes up for a rather peculiar design, built in scope, and expansive ammo capsules. A wise soldier once said.. 'Tell 'em to make it count.'."
	icon_state = "needles"
	inhand_icon_state = "needles"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/needlerammo
	init_mag_type = /obj/item/ammo_box/magazine/internal/needlerammo
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	draw_time = GUN_DRAW_NORMAL
	init_recoil = CARBINE_RECOIL (1 , 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	zoom_factor = 0.9
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = TRUE
	fire_sound = 'sound/f13weapons/needler.ogg'


/obj/item/gun/ballistic/automatic/needlerhmg
	name = "KF-21 Black Panther Needler LMG"
	desc = "A heavy 30 pound KF-21 Black Panther LMG. This prototype needler weapon was created by Latos Systems in collaboration with the South Korean government. It fires heavier needle projectiles at the cost of recoil and weight. Let the pink mist blot out the sun."
	icon_state = "needlelmg"
	inhand_icon_state = "needlelmg"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/needleshmg
	init_mag_type = /obj/item/ammo_box/magazine/internal/needleshmg
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_REPEATER
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	draw_time = GUN_DRAW_LONG
	init_recoil = HMG_RECOIL (1.4 , 4.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast ,
		/datum/firemode/automatic/rpm200
	)
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/needler.ogg'


/obj/item/gun/ballistic/automatic/needlersmg
	name = "Worn S-27 Akula Needler SMG"
	desc = "A lightweight, albeit old and worn, Akula Needler SMG. A prototype created and supplied to the Kazakhstan by Latos Systems. The gun itself is lightweight, easy to use, low recoil, but unable to take silencers or scopes. The design was a prototype and never took off, rejected in favor of the AK series rifles."
	icon_state = "needlesmg"
	inhand_icon_state = "needlesmg"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/needlessmg
	init_mag_type = /obj/item/ammo_box/magazine/internal/needlessmg
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	draw_time = GUN_DRAW_NORMAL
	init_recoil = SMG_RECOIL (1.2 , 0.9)
	init_firemodes = list(
		/datum/firemode/semi_auto,
		/datum/firemode/automatic/rpm100
	)
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/needler.ogg'

/obj/item/gun/ballistic/automatic/stg44custom
	name = "Custom Engraved STG-44"
	desc = "A customized and engraved STG-44. The STG-44 is a German assault rifle, champered in 8mm kurz, or .30-06 for similiar caliber, it is a striking piece of creation. The wood stock is replaced with proper and sturdy birch wood, the metal engraved with baroque motifs. On the barrel is the name 'Freyja'. Seems this gun is able to have a scope on it alongside supressor."
	icon_state = "stg"
	inhand_icon_state = "stg"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/stg
	init_mag_type = /obj/item/ammo_box/magazine/stg
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_C1
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC
	casing_ejector = TRUE
	handedness = GUN_EJECTOR_RIGHT
	cock_delay = GUN_COCK_RIFLE_BASE
	draw_time = GUN_DRAW_NORMAL
	init_recoil = CARBINE_RECOIL (1.7 , 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast ,
		/datum/firemode/automatic/rpm100
	)
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = TRUE
	fire_sound = 'sound/f13weapons/fg42.ogg'

/* * * * * * * * * *
* TG78 Anti Material Rifle.
* Uses .50 cal
* Semi-automatic
* Buffed damage, will mess up someone's day.
* * * * * * * * * * */

/obj/item/gun/ballistic/automatic/unmcamr
	name = "Unktehila"
	desc = "A green colored TG78 anti material rifle or 'tank gewehr-78' is a .50 cal anti material rifle. This one has odd native american themed imprints on the reciever and stock. The scope on top has an imprint of some odd serpent creature..how peculiar"
	icon_state = "tg78"
	inhand_icon_state = "tg78"
	mag_type = /obj/item/ammo_box/magazine/highcaliber
	init_mag_type = /obj/item/ammo_box/magazine/highcaliber
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1

	init_recoil = HMG_RECOIL (4 , 4)
	cock_delay = GUN_COCK_RIFLE_BASE
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	zoom_factor = 1.5
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE




//custom ptrs rifle

/obj/item/gun/ballistic/automatic/sovietantimaterial
	name = "Big Bienvenue"
	desc = "An old, Pre-Fall American knockoff of an even older Soviet anti-tank rifle, sold as a big game hunting rifle before the bombs fell. This one appears to be well-maintained, and has what appear to be tally marks etched into the stock."
	icon_state = "ptrs"
	inhand_icon_state = "ptrs"
	mag_type = /obj/item/ammo_box/magazine/internal/ptrs
	init_mag_type = /obj/item/ammo_box/magazine/internal/ptrs
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/objects/guns/ww2gunsleft.dmi'
	righthand_file = 'icons/fallout/objects/guns/ww2gunsright.dmi'
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T4
	init_recoil = HMG_RECOIL (1.4 , 1.5)
	cock_delay = GUN_COCK_RIFLE_BASE
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	zoom_factor = 0.9
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = TRUE

// Bolter Assault rifle.
// Has insane recoil but makes up for extreme damage
// low ROF but the damage makes up for it witha T2. Unique tier, might be too stronk
/obj/item/gun/ballistic/automatic/compact14mmrifle
	name = "T55E1 Assault Rifle"
	desc = "A T55E1 assault compact assault rifle. Chambered in 12.7mm, ok recoil, compactness, a slow firerate, this rifle was developed by an American arms division before the third war began. It was meant to replace the AR-15 but proved too bulky, low modificationa ability, high costs in ammo,and bad ergonomics."
	icon_state = "bolter"
	inhand_icon_state = "bolter"
	mag_type = /obj/item/ammo_box/magazine/smg14
	init_mag_type = /obj/item/ammo_box/magazine/smg14
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = LMG_RECOIL (1.9 , 2)
	cock_delay = GUN_COCK_RIFLE_BASE
	init_firemodes = list(
		/datum/firemode/automatic/rpm100
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE

/obj/item/gun/ballistic/automatic/compact14mmrifle/custom
	name = "Custom T55E1 Assault Carbine"
	desc = "A T55E1 assault compact assault rifle. Chambered in 10mm, it seems to be a custom assault carbine. It is much lighter than its bigger counterpart."
	icon_state = "bolter"
	inhand_icon_state = "bolter"
	mag_type = /obj/item/ammo_box/magazine/m10mm/adv
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = SMG_RECOIL (1.3 , 1.4)
	cock_delay = GUN_COCK_RIFLE_BASE
	init_firemodes = list(
		/datum/firemode/automatic/rpm100 ,
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE



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
	inhand_icon_state = "sniper"
	slot_flags = INV_SLOTBIT_BACK
	mag_type = /obj/item/ammo_box/magazine/m2mm
	init_mag_type = /obj/item/ammo_box/magazine/m2mm
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // obviously

	can_scope = FALSE
	zoom_factor = 1.2
	fire_sound = 'sound/f13weapons/gauss_rifle.ogg'

/* * * * * * * * * * *
 * xl70e3
 * Fancy 5.56mm autorifle
 * .308 / 5.56mm
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/xl70e3
	name = "xl70e3"
	desc = "This was an experimental weapon at the time of the war. Manufactured, primarily, from high-strength polymers, the weapon is almost indestructible. It's light, fast firing, accurate, and can be broken down without the use of any tools. Chambered in 5.56x45mm."
	icon_state = "xl70e3"
	inhand_icon_state = "xl70e3"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 0.8)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three,
		/datum/firemode/semi_auto
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	zoom_factor = 1.2
	can_scope = FALSE

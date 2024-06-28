//IN THIS DOCUMENT: Pistol template, Light pistols, Heavy pistols
// See gun.dm for keywords and the system used for gun balance



///////////////////
//PISTOL TEMPLATE//
///////////////////


/obj/item/gun/ballistic/automatic/pistol
	name = "pistol template"
	desc = "should not be here. Bugreport."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	item_state = "gun"
	weapon_class = WEAPON_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	can_suppress = TRUE
	trigger_guard = TRIGGER_GUARD_NORMAL
	equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/ballistic/automatic/pistol/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"


/* * * * * * * * *
 * LIGHT PISTOLS *
 * * * * * * * * */

/* * * * * * * * * * *
 * .22 pistol
 * Extra light pistol
 * .22LC
 * Accurate
 * Quiet
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/pistol22
	name = ".22 pistol"
	desc = "The silenced .22 pistol is a sporting handgun with an integrated silencer."
	icon_state = "silenced22"
	mag_type = /obj/item/ammo_box/magazine/m22
	disallowed_mags = list(/obj/item/ammo_box/magazine/m22/extended)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // plug em in the skull!
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_suppress = FALSE
	silenced = TRUE
	fire_sound_silenced = 'sound/f13weapons/22pistol.ogg'

	ammo_kind = /datum/ammo_kind/compact/q_22lr
	ammo_capacity = 16

/obj/item/gun/ballistic/automatic/pistol/pistol22/val
	name = "Mini VAL"
	desc = "An absurdly tiny VAL rifle. You can barely reach its trigger."
	icon_state = "vss"
	item_state = "vss"
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'

/obj/item/gun/ballistic/automatic/pistol/pistol22/val/update_icon_state()
	if(SEND_SIGNAL(src, COMSIG_ITEM_UPDATE_RESKIN))
		return // all done!
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/pistol22/val/Initialize()
	.=..()
	transform *= 0.6
	special_transform = transform

/* * * * * * * *
* Derringers
* Usually compact and easy to use.
* * * * * * * * */
/obj/item/gun/ballistic/automatic/pistol/derringercustom
	name = "Custom engraved derringer"
	desc = "A custom and engraved, albeit desert eagle sized, derringer. With 14mm in mind, four barrels, and modern mechanisms, it's a gun fit for the luxurious bunch. Enscribed on the top right barrel is the name 'Roses are forever'. It bears baroque like motifs around the barrels and reciever while also having a pearl ivory grip."
	icon_state = "customderringer"
	item_state = "customderringer"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/derringer
	init_mag_type = /obj/item/ammo_box/magazine/internal/shot/derringer
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = LMG_RECOIL(1.7,1.7)
	gun_accuracy_zone_type = ZONE_WEIGHT_SEMI_AUTO
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_suppress = FALSE
	can_scope = FALSE
	can_bayonet = FALSE

	ammo_kind = /datum/ammo_kind/medium/q_14mm
	ammo_capacity = 4
	is_revolver = TRUE

/* * * * * * * * * * *
 * Browning Hi-Power
 * Baseline Light pistol
 * 9mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/ninemil
	name = "Browning Hi-power"
	desc = "A mass produced pre-war Browning Hi-power 9mm pistol."
	icon_state = "ninemil"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

	ammo_kind = /datum/ammo_kind/compact/q_9mm
	ammo_capacity = 15

//M3 common 9mm pistol. Same as the browning but as a M3 series pistol. Slightly better damager at T1
/obj/item/gun/ballistic/automatic/pistol/ninemil/m3civ
	name = "M3 Civillian Pistol"
	desc = "This pistol is the civillian version of the M3 Magnum, which uses common and abundant 9mm ammunition."
	icon_state = "m3civ"
	item_state = "m3civ"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

//9mm automatic pistol. smol magazine, zippy gun
/obj/item/gun/ballistic/automatic/pistol/ninemil/auto
	name = "9mm autopistol"
	desc = "A compact 9mm pistol with an autoseer installed. only accepts single stack magazines."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "pistol"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm
	mag_type = /obj/item/ammo_box/magazine/m9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/m9mm/doublestack)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/fast
	)

//scorpion machine pistol. like the M93R, but full auto instead of burst, for better or worse
/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion
	name = "Skorpion 9mm"
	desc = "A Czech machine pistol developed in the 60s."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "skorpion"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion/update_icon_state()
	if(SEND_SIGNAL(src, COMSIG_ITEM_UPDATE_RESKIN))
		return // all done!
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"

//ruby pistol. single stack bootgun, otherwise unexceptional
/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby
	name = "Ruby"
	desc = "A petite pocket pistol designed by Colt and used extensively by the French Army until the late '50s."
	icon = 'modular_coyote/icons/objects/pistols.dmi'
	icon_state = "ruby"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm
	mag_type = /obj/item/ammo_box/magazine/m9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/m9mm/doublestack)
	weapon_class = WEAPON_CLASS_TINY

/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby/basic99
	name = "Colt N104 Defender"
	desc = "A compact variant of the gas operated Colt N99 10mm pistol. Small, reliable and durable. Made for civilian and police self defence for the old world, it still fills its role as a high-calibre compact well."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "Pocket10"
	item_state = "glock"
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	mag_type = /obj/item/ammo_box/magazine/m10mm // load any 10mm pistol ammos
	disallowed_mags = list(
		/obj/item/ammo_box/magazine/m10mm/adv/ext,
		/obj/item/ammo_box/magazine/m10mm/adv/ext/empty,
		/obj/item/ammo_box/magazine/m10mm/rifle)
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_recoil = HANDGUN_RECOIL(1.3, 1)

/obj/item/gun/ballistic/automatic/pistol/ninemil/rare99
	name = "Colt N104-D 'Warden Ten'"
	desc = " A sub-compact 10mm pistol. A shorter version of the Colt N104, it is tiny compared to its bigger brothers and packs a punch. This pistol gets its name from the snub-nose police revolvers of old. "
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "Warden10"
	item_state = "glock"
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	mag_type = /obj/item/ammo_box/magazine/m10mm // load any 10mm pistol ammos
	disallowed_mags = list(
		/obj/item/ammo_box/magazine/m10mm/adv/ext,
		/obj/item/ammo_box/magazine/m10mm/adv/ext/empty,
		/obj/item/ammo_box/magazine/m10mm/rifle)
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_recoil = HANDGUN_RECOIL(1.5, 1.1)

/obj/item/gun/ballistic/automatic/pistol/ninemil/makarov
	name = "9mm Makarov pistol"
	desc = "A easy to conceal Makarov pistol chambered in 9mm. Compact, easy to use, and stylish. This gun likes her enemies shaken, not stirred."
	icon_state = "makarov"
	item_state = "glock"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	weapon_class = WEAPON_CLASS_TINY

/obj/item/gun/ballistic/automatic/pistol/fivemilimeterpistol //5mm caliber pistol. flat 5mm viarable damage, but slower ROF
	name = "5mm Equalizer pistol"
	desc = "A not so well known 5mm chambered pistol. The Taurus 'Equalizer' is a pistol with a 20 round 5mm capacity and a decent hitting catridge."
	icon_state = "5mm"
	item_state = "handgonne"
	init_mag_type = /obj/item/ammo_box/magazine/m5mmcustom
	mag_type = /obj/item/ammo_box/magazine/m5mmcustom
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.4, 1.4)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_5728mm
	ammo_capacity = 20

//loadout 5mms, mirrored but with different names.
/obj/item/gun/ballistic/automatic/pistol/fivemilimeterpistol/custom1 //5mm caliber pistol. flat 5mm viarable damage, but slower ROF
	name = "Ensamvarg "
	desc = "A 5mm Taurus pistol. This one seems custom!"
	icon_state = "5mm"
	item_state = "handgonne"
	init_mag_type = /obj/item/ammo_box/magazine/m5mmcustom
	mag_type = /obj/item/ammo_box/magazine/m5mmcustom
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.4, 1.4)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

/obj/item/gun/ballistic/automatic/pistol/fivemilimeterpistol/custom2 //5mm caliber pistol. flat 5mm viarable damage, but slower ROF
	name = "Fuil"
	desc = "A 5mm custom Taurus pistol!"
	icon_state = "5mm"
	item_state = "handgonne"
	init_mag_type = /obj/item/ammo_box/magazine/m5mmcustom
	mag_type = /obj/item/ammo_box/magazine/m5mmcustom
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.4, 1.4)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby/rubee
	name = "RuBee"
	desc = "A petite pocket pistol that has been modified to accept some rather unique ammunition."
	init_mag_type = /obj/item/ammo_box/magazine/rubee
	mag_type = /obj/item/ammo_box/magazine/rubee
	extra_mag_types = /obj/item/ammo_box/magazine/m9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/m9mm/doublestack)

/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby/mousegun
	name = "mouse gun"
	desc = "Did that gun just squeak?"
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "aps"
	init_mag_type = /obj/item/ammo_box/magazine/mousegun
	mag_type = /obj/item/ammo_box/magazine/mousegun
	extra_mag_types = /obj/item/ammo_box/magazine/m9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/m9mm/doublestack)

//C93 pistol. damage bonus but single stack magazine. not the best gun, but hey, it's old
/obj/item/gun/ballistic/automatic/pistol/ninemil/c93
	name = "9mm Borchardt"
	desc = "The first mass produced semiautomatic pistol, designed before doublestack magazines existed."
	icon = 'modular_coyote/icons/objects/pistols.dmi'
	icon_state = "c93"
	item_state = "p38"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m9mm
	mag_type = /obj/item/ammo_box/magazine/m9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/m9mm/doublestack)
	damage_multiplier = GUN_EXTRA_DAMAGE_T3

	ammo_kind = /datum/ammo_kind/compact/q_9mm
	ammo_capacity = 10

//Luger. pretty much the same as a C93, same smol magazine, same semi-auto old gun
/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger
	name = "9mm Luger"
	desc = "A classy german 9mm pistol, which takes single stack magazines."
	icon_state = "p08"
	item_state = "p38"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

//9mm coldwar-modern sidearms. Same as the browning hipower pistol
/obj/item/gun/ballistic/automatic/pistol/ninemil/glock
	name = "Glock 19"
	desc = "The GLOCK 19, Chambered in 9mm, is a versatile compact pistol. It fits comfortably in the hand or a chest rig, and its solid design lets it survive mud, sand, and sometimes even peanut butter."
	icon_state = "glock"
	item_state = "glock"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	reskinnable_component = /datum/component/reskinnable/glock

/obj/item/gun/ballistic/automatic/pistol/ninemil/pinkglock
	name = "Pink glock Pistol"
	desc = "The GLOCK 19, Chambered in 9mm, is a versatile compact pistol. It fits comfortably in the hand or a chest rig. This one hasnt seen much mud or sand, but it has fallen victim to a rather unusual colour choice. Is pink really 'tacticool?'"
	icon_state = "plock"
	item_state = "plock"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/* * * * * * * * * * *
 * Maria
 * Gaudy Light pistol
 * 9mm
 * +10% damage
 * Accurate
 * No recoil
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/ninemil/maria
	name = "Maria"
	desc = "An ornately-decorated pre-war Browning Hi-power 9mm pistol with pearl grips and a polished nickel finish. The firing mechanism has been upgraded, so for anyone on the receiving end, it must seem like an eighteen-karat run of bad luck."
	icon_state = "maria"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)

/* * * * * * * * * * *
 * Beretta M9FS Semi-Auto
 * Another Light pistol
 * 9mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/beretta
	name = "Beretta M9FS"
	desc = "One of the more common 9mm pistols, the Beretta is popular due to its reliability, 15 round magazine and good looks."
	icon_state = "beretta"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_suppress = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/9mm.ogg'

	reskinnable_component = /datum/component/reskinnable/beretta9

	ammo_kind = /datum/ammo_kind/compact/q_9mm
	ammo_capacity = 15

//9mm carbine: pistol capacity, but two shot burst. needs suppressor set correctly
/obj/item/gun/ballistic/automatic/pistol/beretta/carbine
	name = "9mm carbine"
	desc = "A lightweight carbine manufactured by Hi-Point, takes pistol magazines."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "citykiller" //old citykiller sprite looks close enough to a hi-point carbine
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/burst/two/fast,
		/datum/firemode/semi_auto/fast
	)

/* * * * * * * * * * *
 * Beretta M9R Burst
 * Burst Light pistol
 * 9mm
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/beretta/automatic
	name = "Beretta M93R"
	desc = "An uncommon model of the M9 pistol that's capable of burst fire. It has a built in foregrip allowing for incredibly accurate shots."
	icon_state = "m93r"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	//extra_mag_types = list(/obj/item/ammo_box/magazine/uzim9mm) //as sad as it is to remove, want to bring the power level down slightly so it can be common
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTOPISTOL_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster,
		/datum/firemode/burst/three/faster,
	)

/* * * * * * * * * * *
 * Worn Beretta M9R Burst
 * Burst Light pistol
 * 9mm
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/beretta/automatic/worn
	name = "Trusty Beretta M93R"
	desc = "A rare select fire variant of the M93R. Aged and reliable, but still with that strong punch!"
	icon_state = "m93r"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	//extra_mag_types = list(/obj/item/ammo_box/magazine/uzim9mm) // let it take smg mags
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTOPISTOL_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster,
		/datum/firemode/burst/three/faster
	)

/* * * * * * * * *
* VG77 Pistol
* + Common burst pistol
* - lower damage
* + burst fire
* - slowest burst fire rate but normal semi-automatic
* - Unreskinnable due to lack of sprites
* + Able to be dual wielded
* * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/vg77
	name = "MP77 Pistol"
	desc = "A MP77 pistol from the H&K company. This pistol is based off the VP70, a pistol created by the same company. Made for much more cheaper markets, it's chambered in 9mm and comes with a three burst fire mode. Albeit it seems to be slow in such a ROF. Quite stylish however."
	icon_state = "mp77"
	item_state = "mp77"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = AUTOPISTOL_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast,
		/datum/firemode/burst/three/slower,
	)
	can_bayonet = FALSE
	can_suppress = TRUE
	can_scope = FALSE

	ammo_kind = /datum/ammo_kind/compact/q_9mm
	ammo_capacity = 15

/* * * * * * * * * *
* MEDIUM PISTOLS
* * * * * * * * * */

/* * * * * * * * * * *
* N99 Pistol Semi-Auto
* Baseline Medium pistol
* 10mm
* Common
* * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/n99
	name = "Colt N99 pistol"
	desc = "A large, pre-war styled, gas-operated 10mm pistol manufactured by Colt."
	icon_state = "n99"
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	mag_type = /obj/item/ammo_box/magazine/m10mm // load any 10mm pistol ammos
	disallowed_mags = list(
		/obj/item/ammo_box/magazine/m10mm/adv/ext,
		/obj/item/ammo_box/magazine/m10mm/adv/ext/empty,
		/obj/item/ammo_box/magazine/m10mm/rifle)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_10mm
	ammo_capacity = 12

/* * * * * * * * * * *
 * Executive Pistol Burst Only
 * Burst Medium pistol
 * 10mm
 * Burst
 * +10% damage
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/n99/executive
	name = "the Executive"
	desc = "A modified N99 pistol with an accurate two-round-burst and a blue Vault-Tec finish, a status symbol for some Overseers."
	icon_state = "executive"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = AUTOPISTOL_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto,
		/datum/firemode/burst/three
	)

/obj/item/gun/ballistic/automatic/pistol/n99/executive/worn
	name = "the Executive"
	desc = "A modified N99 pistol with an accurate two-round-burst and a blue Vault-Tec finish, a status symbol for some Overseers."
	icon_state = "executive"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/* * * * * * * * * * *
 * Crusader Pistol Semi-Auto
 * Cool Medium pistol
 * 10mm
 * Flavorful
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/n99/crusader
	name = "\improper Crusader pistol"
	desc = "A large-framed N99 pistol emblazoned with the colors and insignia of the Brotherhood of Steel. It feels heavy in your hand."
	icon_state = "crusader"
	item_state = "crusader"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/ballistic/automatic/pistol/n99/crusader/thingpony
	name = "\improper Painted pistol"
	desc = "A variant of the n99 with a custom paint job done on it. The paint used is of the highest quality!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "ponycrusader"
	item_state = "ponycrusader"

/* * * * * * * * * * *
 * Type 17 Semi-Auto
 * Cheap Medium pistol
 * 10mm
 * Less accurate
 * Less damage
 * Common
 * * * * * * * * * * */
/obj/item/gun/ballistic/automatic/pistol/type17
	name = "Type 17"
	desc = "Chinese military sidearm at the time of the Great War. The ones around are old and worn, but somewhat popular due to the long barrel and rechambered in 10mm after the original ammo ran dry decades ago."
	icon_state = "chinapistol"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(0.6, 0.6)

	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = TRUE

	ammo_kind = /datum/ammo_kind/medium/q_10mm
	ammo_capacity = 10

// Tox's C96. slightly less damage for a 9mm pistol, but bigger magazine and better recoil ----> Updated note: Uses 10 magazine only now, can be buffed slightly.
/obj/item/gun/ballistic/automatic/pistol/type17/tox //custom
	name = "Tox's C96"
	desc = "A unique C96 Mauser found and maintained by a sand-cat named Tox Mckit. The C96 depicted is engraved with silver Baroque Motifs. The handle is made of ivory and on the bolt is an engraving that says 'Ange'."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "toxpistol"
	item_state = "toxpistol"
	init_recoil = HANDGUN_RECOIL(0.4, 0.4)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast ,
		/datum/firemode/automatic/rpm75
	)
	init_mag_type = /obj/item/ammo_box/magazine/internal/mauserinternal
	mag_type = /obj/item/ammo_box/magazine/internal/mauserinternal
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	can_scope = TRUE
	can_suppress = TRUE

/obj/item/gun/ballistic/automatic/pistol/no3pistoltox //custom
	name = "Tox's No.3 Pistol "
	desc = "A unique Bergmann 1896, also known as a 'No.3 pistol', found and maintained by a sand-cat named Tox Mckit. The No.3 pistol seems to have a luxury finish to it. With baroque engravings and a ivory handle. The pistol seems to have only 5 rounds in a internal magazine. A etching of a moth's head is on the ivory handles while the side loading plate has an engraved picture of a cat's head. Below the cat's head, a text in Icelandic reads 'My love'. A pistol that is niche, forgotten, but now repurposed. "
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "no3custom"
	item_state = "no3custom"
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	init_mag_type = /obj/item/ammo_box/magazine/internal/no3pistol
	mag_type = /obj/item/ammo_box/magazine/internal/no3pistol

	ammo_kind = /datum/ammo_kind/medium/q_10mm
	ammo_capacity = 10

/* * * * * * * * * * *
 * Sig P220
 * Light Mediumer pistol
 * .45
 * Less recoil
 * faster shooting
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/sig //wiggles
	name = "Sig P220"
	desc = "The P220 Sig Sauer. A Swiss designed pistol that is compact and has an average rate of fire for a pistol."
	icon_state = "newsig"
	item_state = "gun"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.1, 1.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

	ammo_kind = /datum/ammo_kind/compact/q_45
	ammo_capacity = 8

/obj/item/gun/ballistic/automatic/pistol/sig/trusty //wiggles x 2
	name = "Trusty Sig P220"
	desc = "The P220 Sig Sauer. A Swiss designed pistol that is compact and has an average rate of fire for a pistol. A trusty copy valued for its reliability."
	icon_state = "sig"
	init_mag_type = /obj/item/ammo_box/magazine/m45/rubber
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.1, 1.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

/obj/item/gun/ballistic/automatic/pistol/sig/worn //wiggles x 3
	name = "Sig P220"
	desc = "The P220 Sig Sauer. A Swiss designed pistol that is compact and has an average rate of fire for a pistol."
	icon_state = "sig"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(1.1, 1.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

/obj/item/gun/ballistic/automatic/pistol/sig/blackkite
	name = "Black Kite"
	desc = "These large Sig Sauer pistols have seen much wear, and have been kept maintained with parts from the more common P220, necessitating the rechambering to .45ACP."
	icon_state = "pistol14"
	item_state = "gun"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)

	auto_eject_sound = 'sound/weapons/gun_magazine_remove_full.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/combatrifle.ogg'



/* * * * * * * * * * *
 * Schmeisser
 * Mid-tier auto pistol
 * 10mm
 * No accuracy
 * Less damage
 * Mid rarity
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/schmeisser
	name = "Schmeisser Classic"
	desc = "An obscure pistol that fits a 10mm magazine and is capable of full auto. Fires from an open bolt. Innacurate on the first shot, but it doesn't get much worse. Or better."
	icon_state = "bornheim"
	item_state = "pistolchrome"
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	mag_type = /obj/item/ammo_box/magazine/m10mm // load any 10mm pistol ammos
	init_recoil = HANDGUN_RECOIL(2.3, 2.3)
	disallowed_mags = list(
		/obj/item/ammo_box/magazine/m10mm/adv/ext,
		/obj/item/ammo_box/magazine/m10mm/adv/ext/empty,
		/obj/item/ammo_box/magazine/m10mm/rifle)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast,
	)

	ammo_kind = /datum/ammo_kind/medium/q_10mm
	ammo_capacity = 12

/* * * * * * * * * * *
 * M1911 Semi-Auto
 * Light Medium pistol
 * .45ACP
 * Less melee force
 * More accurate
 * Common
 * Muh three world wars
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "M1911"
	desc = "A classic .45 handgun with a small magazine capacity."
	icon_state = "m1911"
	item_state = "pistolchrome"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

	ammo_kind = /datum/ammo_kind/compact/q_45
	ammo_capacity = 8

/* * * * * * * * * * *
 * M1911 Custom Semi-Auto
 * Lighter Medium pistol
 * .45ACP
 * Lighter
 * Less recoil
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/m1911/custom
	name = "M1911 Custom"
	desc = "A well-maintained stainless-steel frame 1911, with genuine wooden grips."
	icon_state = "m1911_custom"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

///////////////////
//// M6 (renammed) SOCOM pistol///////////////
/// Uses M1911 custom as a base ////
////////////////////////////////////

/obj/item/gun/ballistic/automatic/pistol/m1911/custom/m6socom
	name = "M3 Special Operations."
	desc = "A variant of the M3 series of pistols. This version is made for United Nations Marine Corps Spec Ops as their main service pistol."
	icon_state = "M6SOCOM"
	item_state = "M6SOCOM"
	damage_multiplier = GUN_LESS_DAMAGE_T1

/obj/item/gun/ballistic/automatic/pistol/m1911/custom/jackal
	name = "Santa Muerte"
	desc = "A custom built 1911 with a brushed brass plated grip, a shiny chrome finish, and a custom muzzle brake.. It has an excerpt of a prayer to lady death etched neatly in it's slide, evoking her protection from evil forces."
	icon_state = "santa_muerte"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
/* * * * * * * * * * *
 * Mk. 23 Semi-Auto
 * Tacticool Medium pistol
 * .45ACP
 * More accurate
 * Lighter
 * Less recoil
 * Faster to shoot
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/mk23
	name = "Mk. 23"
	desc = "A very tactical pistol chambered in .45 ACP with a built in laser sight and attachment point for a seclite."
	icon_state = "mk23"
	init_mag_type = /obj/item/ammo_box/magazine/m45/socom
	mag_type = /obj/item/ammo_box/magazine/m45 // load any .45 pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(0.8, 0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_flashlight = TRUE
	gunlight_state = "flight"
	flight_x_offset = 16
	flight_y_offset = 13
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Tacticool

	ammo_kind = /datum/ammo_kind/compact/q_45
	ammo_capacity = 8

/* * * * * * * * * * * * * *
 * HEAVY SEMI-AUTO PISTOLS *
 * * * * * * * * * * * * * */

/* * * * * * * * * * *
 * Desert Eagle Semi-Auto
 * Baseline Heavy pistol
 * .44 Magnum
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/deagle
	name = "Desert Eagle"
	desc = "A robust .44 magnum semi-automatic handgun."
	icon_state = "deagle"
	item_state = "deagle"
	init_mag_type = /obj/item/ammo_box/magazine/m44
	mag_type = /obj/item/ammo_box/magazine/m44 // load any .44 pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/* * * * * * * * * * *
 * El Capitan Semi-Auto
 * Big Heavy pistol
 * 14mm
 * More damage
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan
	name = "El Capitan"
	desc = "The Captain loves his gun, despite some silly gunsmith adding some gas venting to the barrel after his second visit to the surgeon for recoil-related wrist injuries."
	icon_state = "elcapitan"
	item_state = "deagle"
	mag_type = /obj/item/ammo_box/magazine/m14mm
	init_mag_type = /obj/item/ammo_box/magazine/m14mm
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T2 //T3 might've been a lil much. will see
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/* * * * * * * * * * *
 * Automag Semi-Auto
 * Cooler Heavy pistol
 * .44 magnum
 * More accurate
 * Less recoil
 * More damage
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/automag
	name = "Automag"
	desc = "A long-barreled .44 magnum semi-automatic handgun."
	icon_state = "automag"
	item_state = "deagle"
	init_mag_type = /obj/item/ammo_box/magazine/m44/automag
	mag_type = /obj/item/ammo_box/magazine/m44/automag
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/* * * * * * * * * *
* .44 automag copycats. same as the original one with or without added flavor *
* * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/automag/m6 //weaker .44, spawn tier.
	name = "M3 Magnum"
	desc = "Another M3 series pistol. This one is akin to the M3 magnums used by Leo Arments. The magnum is chambered in .44 and comes with a built in 2x holo-scope."
	icon_state = "m3magnum"
	item_state = "m3magnum"
	zoom_factor = 1.1
	damage_multiplier = GUN_LESS_DAMAGE_T1

/obj/item/gun/ballistic/automatic/pistol/goldendeag
	name = "Aureum Tactum"
	desc = "The golden gun, er..well somewhat. Chambered in a lesser form of .44 magnum, the Aureum Tactum golden desert eagle is fully automatic. Albeit it requires a good grip for obvious reasons."
	icon_state = "uniquedeag"
	item_state = "uniquedeag"
	init_mag_type = /obj/item/ammo_box/magazine/m44/automag
	mag_type = /obj/item/ammo_box/magazine/m44/automag
	init_recoil = HMG_RECOIL (8, 8)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_firemodes = list(
	/datum/firemode/automatic/rpm300
	)
	can_suppress = FALSE
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/* * * * * * * * * * *
 * 14mm Semi-Auto
 * Super Heavy pistol
 * 14mm
 * Less accurate
 * Shoots slower
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/pistol14
	name = "14mm pistol"
	desc = "A Swiss SIG-Sauer 14mm handgun, powerful but a little inaccurate"
	icon_state = "pistol14"
	mag_type = /obj/item/ammo_box/magazine/m14mm
	init_mag_type = /obj/item/ammo_box/magazine/m14mm
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/* * * * * * * * * * *
 * 14mm Compact Semi-Auto
 * super Heavy pistol
 * 14mm
 * Even less accurate
 * Shoots slower
 * Slower to recover recoil
 * Less melee damage
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/pistol14/compact
	name = "compact 14mm pistol"
	desc = "A Swiss SIG-Sauer 14mm handgun, this one is a compact model for concealed carry."
	icon_state = "pistol14_compact"
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/* * * * * * * * * * * *
* K8 Assault Pistol
* Custom gun for Seerman
* Based off the Hello Cutie Cyberpunk Red pistol
* placeholder for much heavier caliber pistols
* New sound file
* Muh frontal mag
* Muh 14mm
* * * * * * * * * * * * */

//Custom pistol for a player, see above.
/obj/item/gun/ballistic/automatic/pistol/hellocutiepistol
	name = "Custom P-36 Assault Pistol"
	desc = "A custom P-36 Assault pistol manufactured by the Latos Systems company which was based in pre-war Tokyo. This heavy caliber firearm isn't easily concealable, comes chambered in a odd pistol conversion of a .577 nitro express round, and has a odd frontal magazine configuration but what it lacks in concealment and firerate, it makes up for in punch and 'kawaii' asthetic. The owner of this has engraved their name where the gun's name would be, a 'Tox Mckit'."
	icon_state = "toxcyberplaceholder"
	item_state = "toxcybergun"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m14mmcustom
	mag_type = /obj/item/ammo_box/magazine/m14mmcustom
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/cyberbang.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 15

/obj/item/gun/ballistic/automatic/pistol/lugerrevolver
	name = "Zünder-14 Pistol"
	desc = "A Zünder-14 pistol. Zunder means 'detonator' in German. Comes with a side-mounted rail mount for scopes. Manufactured by Leo Armaments, this over engineered pistol is a literal toggle-lock semi-automatic pistol/revolver hybrid. Chambered in a heavy .44, the trigger is slightly lighter and easy to press. What were Leo Armaments thinking?"
	icon_state = "lugermagnum"
	item_state = "judge"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m44/automag
	mag_type = /obj/item/ammo_box/magazine/m44/automag
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(1.4, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = TRUE
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/cyberbang.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 6

/obj/item/gun/ballistic/automatic/pistol/lugerrevolver/tox
	name = "Custom Zünder-14 Pistol"
	desc = "A customized Z-14 pistol from Leo Armaments. This semi-automatic pistol-revolver toggle lock action piece of iron comes rechambered in a bigger cartridge, sacrificing capacity for heavy hitting fun. Alongside this,The gun's plating is a silver like material and for the grips, custom black colored wooden grips. The ebony grip has a scene of a moth fluttering on it. Adorning the uniquely made pistol is baroque motifs. On the very end of the barrel is the name of someone who is called 'Tox'. A piece made for an executioner."
	icon_state = "toxrevolver"
	item_state = "judge"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m14mmcustom
	mag_type = /obj/item/ammo_box/magazine/m14mmcustom
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = HANDGUN_RECOIL(1.3, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = TRUE
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/cyberbang.ogg'

/obj/item/gun/ballistic/automatic/pistol/ticon
	name = "Latos Systems P-36 Assault Pistol"
	desc = "A heavy caliber pistol manufactured by Latos Systems. Chambered in 12.7mm or 14mm in pistol caliber, this heavy hitting pistol packs a wallop but requires two hands to even remotely handle the insane recoil. Comes with a built in Smart-Tek mini-dot sight. The gun itself has the ability to take in a custom ammo counter should one choose."
	icon_state = "ticon"
	item_state = "ticon"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m14mmcustom
	mag_type = /obj/item/ammo_box/magazine/m14mmcustom
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/cyberbang.ogg'

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 10

//4.7mm caseless pistol. Alternative ammo type to the 5mm with slight differences. Spawn tier with shy less damage than a baseline 5mm firearm.
/obj/item/gun/ballistic/automatic/pistol/pistol47mm
	name = "4.7mm A39 Pistol"
	desc = "A rather strange caliber having pistol. Chambered in 4.7mm caseless ammo, this pistol seems to be a bit heavier to hold but is generally still the same as any pistol of its size and caliber range."
	icon_state = "jericho"
	item_state = "pistolchrome"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m47pistol
	mag_type = /obj/item/ammo_box/magazine/m47pistol
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1.4, 1.7)
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	can_scope = FALSE
	can_suppress = TRUE

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/obj/item/gun/ballistic/automatic/pistol/needlerpistol
	name = "NP-149/40"
	desc = "A NP-149/40 pistol. This unique and odd prototype of a pistol was manufactured by Latos Systems before the way. It uses a peculiar type of ammunition. The ammo itself, when inserted, somehow turns into a set of pink glowing needles. How does Latos Systems do it? Who knows!"
	icon_state = "needlerpistol"
	item_state = "needlerpistol"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/internal/needlerammo
	mag_type = /obj/item/ammo_box/magazine/internal/needlerammo
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150
	)
	can_scope = FALSE
	can_suppress = FALSE
	force_unwielded = 30
	force = 30
	force_wielded = 35
	fire_sound = 'sound/f13weapons/needler.ogg'

/* * * * * * * * * * *
 * Little Devil Semi-Auto
 * Super Duper Heavy pistol
 * 14mm
 * More accurate
 * Shoots slower
 * More damage
 * Less recoil
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/pistol14/lildevil
	name= "Little Devil 14mm pistol"
	desc = "A Swiss SIG-Sauer 14mm handgun, this one is a finely tuned custom firearm from the Gunrunners."
	icon_state = "lildev"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	ammo_kind = /datum/ammo_kind/medium/q_44
	ammo_capacity = 8

/////////////////////////////////
// TEMPORARY REMOVE AFTER BETA //
/////////////////////////////////obsolete

/obj/item/gun/ballistic/automatic/pistol/pistoltesting
	name = "pistol"
	damage_multiplier = 18
	mag_type = /obj/item/ammo_box/magazine/testbullet

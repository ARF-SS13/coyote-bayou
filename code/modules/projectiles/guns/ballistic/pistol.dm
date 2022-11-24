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
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0

	select = FALSE
	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_suppress = TRUE
	equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'
	init_recoil = HANDGUN_RECOIL(1)
	init_firemodes = list(
		SEMI_AUTO_NODELAY
	)
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_LIGHT_RANGE_DISTANT)
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
	w_class = WEIGHT_CLASS_SMALL

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(0.6)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // plug em in the skull!

	can_suppress = FALSE
	silenced = TRUE
	fire_sound_silenced = 'sound/f13weapons/22pistol.ogg'

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
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(0.8)

	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

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

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1

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
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(0.8)

	can_suppress = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/9mm.ogg'

/* * * * * * * * * * *
 * Beretta M9R Burst
 * Burst Light pistol
 * 9mm
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/beretta/automatic
	name = "Beretta M93R"
	desc = "A rare select fire variant of the M93R."
	icon_state = "m93r"
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	extra_mag_types = list(/obj/item/ammo_box/magazine/uzim9mm) // let it take smg mags

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(1.2)
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_3_ROUND
	)

	automatic_burst_overlay = TRUE
	semi_auto = FALSE

/* * * * * * * * * *
 * MEDIUM PISTOLS  *
 * * * * * * * * * */

/* * * * * * * * * * *
 * N99 Pistol Semi-Auto
 * Baseline Medium pistol
 * 10mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/n99
	name = "10mm pistol"
	desc = "A large, pre-war styled, gas-operated 10mm pistol."
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "n99"
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	mag_type = /obj/item/ammo_box/magazine/m10mm // load any 10mm pistol ammos
	disallowed_mags = list(
		/obj/item/ammo_box/magazine/m10mm/adv/ext,
		/obj/item/ammo_box/magazine/m10mm/adv/ext/empty,
		/obj/item/ammo_box/magazine/m10mm/rifle)

	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)

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

	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 2
	semi_auto = FALSE
	damage_multiplier = GUN_EXTRA_DAMAGE_T1

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

	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	init_recoil = HANDGUN_RECOIL(0.8)


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
	w_class = WEIGHT_CLASS_NORMAL

	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(0.6)

	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)

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
	icon_state = "sig"
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(0.7)

	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

/obj/item/gun/ballistic/automatic/pistol/sig/trusty //wiggles x 2
	name = "Trusty Sig P220"
	desc = "The P220 Sig Sauer. A Swiss designed pistol that is compact and has an average rate of fire for a pistol. A trusty copy valued for its reliability."
	icon_state = "sig"
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m45/rubber
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(0.7)

	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

/obj/item/gun/ballistic/automatic/pistol/sig/worn //wiggles x 3
	name = "Sig P220"
	desc = "The P220 Sig Sauer. A Swiss designed pistol that is compact and has an average rate of fire for a pistol."
	icon_state = "sig"
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(0.8)
	damage_multiplier = GUN_LESS_DAMAGE_T1

	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

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
	icon_prefix = "bornheim"
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	mag_type = /obj/item/ammo_box/magazine/m10mm // load any 10mm pistol ammos
	init_recoil = HANDGUN_RECOIL(2.3)
	disallowed_mags = list(
		/obj/item/ammo_box/magazine/m10mm/adv/ext,
		/obj/item/ammo_box/magazine/m10mm/adv/ext/empty,
		/obj/item/ammo_box/magazine/m10mm/rifle)

	fire_delay = GUN_FIRE_DELAY_FASTER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 3

	init_firemodes = list(
		FULL_AUTO_200,
		SEMI_AUTO_NODELAY
	)

/* * * * * * * * * * *
 * M1911 Semi-Auto
 * Light Medium pistol
 * .45ACP
 * Less melee force
 * More accurate
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "M1911"
	desc = "A classic .45 handgun with a small magazine capacity."
	icon_state = "m1911"
	item_state = "pistolchrome"
	w_class = WEIGHT_CLASS_SMALL
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)

	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL

	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 21
	fire_sound = 'sound/f13weapons/45revolver.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)

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

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	damage_multiplier = GUN_EXTRA_DAMAGE_T1

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
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(0.8)

	can_flashlight = TRUE
	gunlight_state = "flight"
	flight_x_offset = 16
	flight_y_offset = 13
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Tacticool
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)


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
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(1.2)

	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_HEAVY_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_HEAVY_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_HEAVY_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_HEAVY_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_HEAVY_RANGE_DISTANT)
	)

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
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 // POW

	fire_sound = 'sound/f13weapons/magnum_fire.ogg'

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
	mag_type = /obj/item/ammo_box/magazine/m44 // load any .44 pistol ammos
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1

	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_HEAVY_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_HEAVY_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_HEAVY_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_HEAVY_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_HEAVY_RANGE_DISTANT)
	)

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
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_HEAVY_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_HEAVY_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_HEAVY_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_HEAVY_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_HEAVY_RANGE_DISTANT)
	)

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
	w_class = WEIGHT_CLASS_SMALL

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_recoil = HANDGUN_RECOIL(1.2)

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
	w_class = WEIGHT_CLASS_SMALL

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(0.8)

/////////////////////////////////
// TEMPORARY REMOVE AFTER BETA //
/////////////////////////////////obsolete

/obj/item/gun/ballistic/automatic/pistol/pistoltesting
	name = "pistol"
	damage_multiplier = 18
	mag_type = /obj/item/ammo_box/magazine/testbullet

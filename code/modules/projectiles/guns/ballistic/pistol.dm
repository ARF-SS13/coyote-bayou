//IN THIS DOCUMENT: Pistol template, Light pistols, Heavy pistols
// See gun.dm for keywords and the system used for gun balance



///////////////////
//PISTOL TEMPLATE//
///////////////////


/obj/item/gun/ballistic/automatic/pistol
	slowdown = 0
	name = "pistol template"
	desc = "should not be here. Bugreport."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	item_state = "gun"
	w_class = WEIGHT_CLASS_NORMAL //How much space it takes in a bag
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv/simple

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0

	select = FALSE
	automatic_burst_overlay = FALSE
	can_automatic = FALSE
	semi_auto = TRUE
	can_suppress = TRUE
	equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'

/obj/item/gun/ballistic/automatic/pistol/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/suppressed/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/S = new(src)
	install_suppressor(S)



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
	w_class = WEIGHT_CLASS_TINY
	
	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_attachments = TRUE
	can_suppress = FALSE
	can_unsuppress = FALSE
	suppressed = 1
	fire_sound = 'sound/f13weapons/22pistol.ogg'

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
	mag_type = /obj/item/ammo_box/magazine/m9mmds
	
	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_attachments = TRUE
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
	recoil_multiplier = GUN_RECOIL_NONE
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_INSTANT
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1

/* * * * * * * * * * *
 * Sig P220
 * Another Light pistol
 * 9mm
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/pistol/sig
	name = "Sig P220"
	desc = "The P220 Sig Sauer. A Swiss designed pistol that is compact and has an average rate of fire for a pistol."
	icon_state = "sig"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m9mm

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_attachments = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/9mm.ogg'


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
	mag_type = /obj/item/ammo_box/magazine/m9mmds

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_attachments = TRUE
	can_suppress = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/9mm.ogg'

#define BERETTA_BURST_1 1
#define BERETTA_BURST_3 3
#define BERETTA_SPREAD_SEMI GUN_SPREAD_POOR
#define BERETTA_SPREAD_BURST GUN_SPREAD_POOR * 2
#define BERETTA_RECOIL_SEMI GUN_RECOIL_PISTOL_LIGHT
#define BERETTA_RECOIL_BURST GUN_RECOIL_PISTOL_LIGHT * 2
#define BERETTA_RECOIL_COOLDOWN_SEMI GUN_RECOIL_TIMEOUT_QUICK
#define BERETTA_RECOIL_COOLDOWN_BURST GUN_RECOIL_TIMEOUT_LONG

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

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FAST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FAST
	burst_size = 1

	actions_types = list(/datum/action/item_action/toggle_firemode)
	automatic_burst_overlay = TRUE
	can_attachments = FALSE
	semi_auto = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/gun/ballistic/automatic/pistol/beretta/automatic/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(1)
			select = 2
			burst_size = BERETTA_BURST_3
			spread = BERETTA_SPREAD_BURST
			recoil_multiplier = BERETTA_RECOIL_BURST
			recoil_cooldown_time = BERETTA_RECOIL_COOLDOWN_BURST
			to_chat(user, "<span class='notice'>You switch to burst fire.</span>")
		if(2)
			select = 1
			burst_size = BERETTA_BURST_1
			spread = BERETTA_SPREAD_SEMI
			recoil_multiplier = BERETTA_RECOIL_SEMI
			recoil_cooldown_time = BERETTA_RECOIL_COOLDOWN_SEMI
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return

#undef BERETTA_BURST_1
#undef BERETTA_BURST_3
#undef BERETTA_SPREAD_SEMI
#undef BERETTA_SPREAD_BURST
#undef BERETTA_RECOIL_SEMI
#undef BERETTA_RECOIL_BURST
#undef BERETTA_RECOIL_COOLDOWN_SEMI
#undef BERETTA_RECOIL_COOLDOWN_BURST

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
	icon_state = "n99"
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv/simple
	
	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_MEDIUM
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_attachments = TRUE
	can_automatic = TRUE
	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'

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
	recoil_multiplier = GUN_RECOIL_PISTOL_MEDIUM
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 2
	semi_auto = FALSE
	can_automatic = FALSE
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1

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
	recoil_multiplier = GUN_RECOIL_PISTOL_MEDIUM
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL

	can_attachments = FALSE
	can_automatic = FALSE


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
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv/simple

	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_MEDIUM
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	gun_damage_multiplier = GUN_LESS_DAMAGE_T1

	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'

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
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m45

	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_MEDIUM
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL

	can_attachments = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 21
	fire_sound = 'sound/f13weapons/45revolver.ogg'

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
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1

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
	mag_type = /obj/item/ammo_box/magazine/m45exp

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_QUICK
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FAST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1

	can_flashlight = TRUE
	gunlight_state = "flight"
	flight_x_offset = 16
	flight_y_offset = 13
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'



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
	mag_type = /obj/item/ammo_box/magazine/m44

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'

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

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T3 // POW

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
	mag_type = /obj/item/ammo_box/magazine/automag
	
	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1

	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'


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

	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_POOR
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'

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
	recoil_multiplier = GUN_RECOIL_PISTOL_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1

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
	draw_time = GUN_DRAW_NORMAL
	recoil_multiplier = GUN_RECOIL_PISTOL_MEDIUM
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1

/////////////////////////////////
// TEMPORARY REMOVE AFTER BETA //
/////////////////////////////////obsolete

/obj/item/gun/ballistic/automatic/pistol/pistoltesting
	name = "pistol"
	gun_damage_multiplier = 18
	mag_type = /obj/item/ammo_box/magazine/testbullet

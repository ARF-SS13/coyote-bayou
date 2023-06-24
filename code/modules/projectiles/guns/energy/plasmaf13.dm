
//////////////////
//PLASMA WEAPONS//
//////////////////

//Plasma pistol
/obj/item/gun/energy/laser/plasma/pistol
	name ="plasma pistol"
	item_state = "plasma-pistol"
	icon_state = "plasma-pistol"
	desc = "A pistol-sized miniaturized plasma caster built by REPCONN. It fires a bolt of superhot ionized gas."
	ammo_type = list(/obj/item/ammo_casing/energy/fifty)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
//Plasma pistol: Eve
/obj/item/gun/energy/laser/plasma/pistol/eve
	name ="eve"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	item_state = "plasma-pistol"
	icon_state = "eve"
	desc = "A Plasmophiles wet dream. This meticulously modified pistol has seen every part serviced or improved in some manner."
	ammo_type = list(/obj/item/ammo_casing/energy/sixty)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//Eve, Worn version
/obj/item/gun/energy/laser/plasma/pistol/eve/worn
	name ="eve"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	item_state = "plasma-pistol"
	icon_state = "eve"
	desc = "A Plasmophiles wet dream. This meticulously modified pistol has seen every part serviced or improved in some manner. This one has seen some age..."
	ammo_type = list(/obj/item/ammo_casing/energy/sixty)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T3

//Plasma pistol: Adam
/obj/item/gun/energy/laser/plasma/pistol/adam
	name ="adam"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	item_state = "plasma-pistol"
	icon_state = "adam"
	desc = "Love is fundamentally about looking forward, not backward. It's a committment to becoming, not merely being. It's an enlistment in togetherness, not aloneness."
	ammo_type = list(/obj/item/ammo_casing/energy/sixty)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

//BoS knight craftable plasma pistol
/obj/item/gun/energy/laser/plasma/pistol/light
	name = "lightweight plasma pistol"
	icon_state = "light-plasma-pistol"
	desc = "A lightweight modification of the common REPCONN-built plasma pistol. Fires heavy low penetration plasma clots at a slower rate than the regular design due to reduced cooling."
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/*
/obj/item/gun/energy/laser/plasma/pistol/worn
	name ="shoddy plasma pistol"
	desc = "A pistol-sized miniaturized plasma caster built by REPCONN. It fires a bolt of superhot ionized gas. This one's internal parts have loose seals and corroded electronics."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/worn)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)*/

//Glock 86 Plasma pistol
/obj/item/gun/energy/laser/plasma/glock
	name = "glock defender"
	desc = "A plasma pistol that boasts an instantanious velocity plasma stream, allowing better precision than a standard pistol at the cost of damage. Powered by a small energy cell."
	item_state = "plasma-pistol"
	icon_state = "glock86"
	ammo_type = list(/obj/item/ammo_casing/energy/fifty/hitscan)
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//Glock 86 A Plasma pistol
/obj/item/gun/energy/laser/plasma/glock/extended
	name ="glock 86"
	item_state = "plasma-pistol"
	icon_state = "glock86a"
	desc = "An advanced plasma pistol boasting extra bang for its buck, compared to the earlier plasma defender model."
	ammo_type = list(/obj/item/ammo_casing/energy/fifty/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

//Plasma Rifle
/obj/item/gun/energy/laser/plasma
	name ="plasma rifle"
	item_state = "plasma"
	icon_state = "plasma"
	desc = "A miniaturized plasma caster that fires bolts of magnetically accelerated toroidal plasma towards an unlucky target."
	ammo_type = list(/obj/item/ammo_casing/energy/fifty)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

//Plasma carbine
/obj/item/gun/energy/laser/plasma/carbine
	name ="plasma carbine"
	item_state = "plasma"
	icon_state = "plasmacarbine"
	desc = "A burst-fire energy weapon that fires a steady stream of toroidal plasma towards an unlucky target."
	ammo_type = list(/obj/item/ammo_casing/energy/fifty)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T3
	init_firemodes = list(
		/datum/firemode/burst/two/slow
	)
//Multiplas rifle
/obj/item/gun/energy/laser/plasma/scatter
	name = "multiplas rifle"
	item_state = "multiplas"
	icon_state = "multiplas"
	desc = "A modified A3-20 plasma caster built by REPCONN equipped with a multicasting kit that creates multiple weaker clots."
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/scatter)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

//I'm not touching this hot mess right now
/obj/item/gun/energy/laser/plasma/spear
	name = "ergonomic plasmacaster"
	icon = 'icons/fallout/objects/melee/twohanded.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee2h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee2h_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	item_state = "plasma"
	icon_state = "plasma"
	desc = "An ergonomic pre-war plasmacaster designed for precision mining work. This one appears to be built into a single thick staff, with a bulbous hilt and sharp saturnite alloy blades ringing the caster assembly- strongly resembling sort of spear."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/miner)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	sharpness = SHARP_EDGED
	scope_y_offset = 16
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	force_unwielded = GUN_MELEE_FORCE_RIFLE_LIGHT
	force_wielded = GUN_MELEE_FORCE_RIFLE_LIGHT * 2
	wielded_icon = "plasma2"
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	weapon_special_component = /datum/component/weapon_special/ranged_spear

/obj/item/gun/energy/laser/plasma/spear/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

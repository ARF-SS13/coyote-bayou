/obj/item/gun/energy/plasma //Not intended to be used, use its children instead.
	name = "plasma gun"
	desc = "A high-power plasma gun. You shouldn't ever see this."
	icon_state = "xray"
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	ammo_type = list(/obj/item/ammo_casing/energy/plasmagun)
	cell_type = "/obj/item/stock_parts/cell/pulse/carbine"
	ammo_x_offset = 2
	shaded_charge = 1
	lefthand_file = 'modular_citadel/icons/mob/citadel/guns_lefthand.dmi'
	righthand_file = 'modular_citadel/icons/mob/citadel/guns_righthand.dmi'


/obj/item/gun/energy/plasma/rifle
	name = "plasma cannon"
	desc = "A state of the art cannon utilizing plasma in a uranium-235 lined core to output hi-power, radiating bolts of energy."
	icon_state = "alienrifle"
	inhand_icon_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	ammo_type = list(/obj/item/ammo_casing/energy/plasmagun/rifle)
	ammo_x_offset = 4



/obj/item/gun/energy/plasma/light
	name = "plasma rifle"
	desc = "A state of the art rifle utilizing plasma in a uranium-235 lined core to output radiating bolts of energy."
	icon_state = "lightalienrifle"
	inhand_icon_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/plasmagun/light)
	ammo_x_offset = 2
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/plasma/MP40k
	name = "Plasma MP40k"
	desc = "A plasma MP40k. Ich liebe den geruch von plasma am morgen."
	icon_state = "PlasMP"
	inhand_icon_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/plasmagun/MP40k)
	ammo_x_offset = 3
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

//Laser rifles, technically lazer, but w/e

/obj/item/gun/energy/laser/rifle
	name = "laser rifle"
	desc = "A laser rifle issued to high ranking members of a certain shadow corporation."
	icon_state = "xcomlasergun"
	inhand_icon_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	cell_type = "/obj/item/stock_parts/cell/pulse/carbine"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 4
	lefthand_file = 'modular_citadel/icons/mob/citadel/guns_lefthand.dmi'
	righthand_file = 'modular_citadel/icons/mob/citadel/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

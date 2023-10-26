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
	item_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	ammo_type = list(/obj/item/ammo_casing/energy/plasmagun/rifle)
	ammo_x_offset = 4



/obj/item/gun/energy/plasma/light
	name = "plasma rifle"
	desc = "A state of the art rifle utilizing plasma in a uranium-235 lined core to output radiating bolts of energy."
	icon_state = "lightalienrifle"
	item_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/plasmagun/light)
	ammo_x_offset = 2
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/plasma/MP40k
	name = "Plasma MP40k"
	desc = "A plasma MP40k. Ich liebe den geruch von plasma am morgen."
	icon_state = "PlasMP"
	item_state = null
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
	item_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	cell_type = "/obj/item/stock_parts/cell/pulse/carbine"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 4
	lefthand_file = 'modular_citadel/icons/mob/citadel/guns_lefthand.dmi'
	righthand_file = 'modular_citadel/icons/mob/citadel/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/LaserAK
	name = "Laser AK470"
	desc = "An experimental soviet energy weapon with an integrated uranium based breeder cell. Death solves all problems -- No man, no problem."
	can_remove = 0
	can_charge = 0
	selfcharge = 1
	icon_state = "LaserAK"
	item_state = null
	selfchargerate = 30 // It's a hardspawn gun that's apparently very easy to get
	max_upgrades = 4 // +1 mod to make up for the AEP damage; +50% damage potentially and enough mods to negate the downsides should make it a good invest gun
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	cell_type = "/obj/item/stock_parts/cell/ammo/breeder"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/AK470M)
	ammo_x_offset = 4
	lefthand_file = 'modular_citadel/icons/mob/citadel/guns_lefthand.dmi'
	righthand_file = 'modular_citadel/icons/mob/citadel/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_firemodes = list(
	/datum/firemode/semi_auto,
	/datum/firemode/automatic/rpm200
	)
	init_recoil = LASER_AUTORIFLE_RECOIL(2, 1)

/obj/item/ammo_box/magazine/mm195x129
	name = "box magazine (1.95x129mm)"
	icon_state = "a762-50"
	ammo_type = /obj/item/ammo_casing/mm195x129
	caliber = list(CALIBER_195)
	max_ammo = 50

/obj/item/ammo_box/magazine/mm195x129/hollow
	name = "box magazine (Hollow-Point 1.95x129mm)"
	ammo_type = /obj/item/ammo_casing/mm195x129/hollow

/obj/item/ammo_box/magazine/mm195x129/ap
	name = "box magazine (Armor Penetrating 1.95x129mm)"
	ammo_type = /obj/item/ammo_casing/mm195x129/ap

/obj/item/ammo_box/magazine/mm195x129/incen
	name = "box magazine (Incendiary 1.95x129mm)"
	ammo_type = /obj/item/ammo_casing/mm195x129/incen

/obj/item/ammo_box/magazine/mm195x129/update_icon()
	..()
	icon_state = "a762-[round(ammo_count(),10)]"

/obj/item/ammo_box/magazine/mm712x82/match
	name = "box magazine (Match 7.12x82mm)"
	ammo_type = /obj/item/ammo_casing/mm712x82/match
	caliber = list(CALIBER_712)

/obj/item/ammo_box/magazine/w3006
	name = "sniper rifle magazine (.30-06)"
	icon_state = "sniper_mag"
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_3006)
	max_ammo = 7
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_SMALL_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/w3006/empty
	start_empty = 1

/obj/item/ammo_box/magazine/lmg
	name = "ammo box (5.56)"
	icon_state = "r80"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = list(CALIBER_556)
	max_ammo = 60
	w_class = WEIGHT_CLASS_NORMAL // suffer
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_BRICK_RIFLE_MAGAZINE)

/obj/item/ammo_box/magazine/lmg/empty
	start_empty = 1


/obj/item/ammo_box/magazine/rpd
	name = "rpd drum magazine"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "rpdm"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_BRICK_RIFLE_MAGAZINE)

/obj/item/ammo_box/magazine/rpd/empty
	start_empty = 1



/obj/item/ammo_box/magazine/ratling
	name = "Ratling box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "ammobox"
	ammo_type = /obj/item/ammo_casing/caseless/flintlock
	caliber = list(CALIBER_FLINTLOCK)
	max_ammo = 100
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = MATS_LIGHT_MEGA_CAN_MAGAZINE)

/obj/item/ammo_box/magazine/ratling/empty
	start_empty = 1

/obj/item/ammo_box/magazine/lewis
	name = "extended pan magazine (.308)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "lanoe"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 97
	w_class = WEIGHT_CLASS_NORMAL // suffer
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_MEGA_CAN_MAGAZINE)

/obj/item/ammo_box/magazine/lewis/empty
	start_empty = 1

/obj/item/ammo_box/magazine/lewis/l47
	name = "pan magazine (.308)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "lewis"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 47
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_BRICK_RIFLE_MAGAZINE)

/obj/item/ammo_box/magazine/lewis/l47/empty
	start_empty = 1

/obj/item/ammo_box/magazine/bren
	name = "bren magazine (.308)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "bren"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 30
	w_class = WEIGHT_CLASS_SMALL
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_EXTENDED_RIFLE_MAGAZINE)

/obj/item/ammo_box/magazine/bren/empty
	start_empty = 1

/obj/item/ammo_box/magazine/cz53
	name = "ammo box (5mm)"
	icon_state = "cz53"
	ammo_type = /obj/item/ammo_casing/m5mm
	caliber = list(CALIBER_5MM)
	max_ammo = 240
	w_class = WEIGHT_CLASS_GIGANTIC // agony
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_MEGA_CAN_MAGAZINE)

/obj/item/ammo_box/magazine/cz53/empty
	start_empty = 1

/obj/item/ammo_box/magazine/mg34
	name = "ammo box (.308)"
	icon_state = "r80"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 60
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_BELT_MAGAZINE)

/obj/item/ammo_box/magazine/mg34/empty
	start_empty = 1

/obj/item/ammo_box/magazine/mm308
	name = "ammo belt (.308)"
	icon_state = "762belt"
	ammo_type = /obj/item/ammo_casing/a308
	max_ammo = 80
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK | INV_SLOTBIT_NECK //sling these big belts all over your fuckin self
	caliber = list(CALIBER_308)
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_BELT_MAGAZINE)

/obj/item/ammo_box/magazine/mm308/empty
	start_empty = 1

/* I think we want to be able to load up belts of the stuff
/obj/item/ammo_box/magazine/mm308/can_load()
	return 0
*/

/obj/item/ammo_box/magazine/mm308/update_icon()
	..()
	icon_state = "762belt-[round(ammo_count(),20)]"

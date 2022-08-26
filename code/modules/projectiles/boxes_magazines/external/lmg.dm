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

/obj/item/ammo_box/magazine/w308
	name = "sniper rifle magazine (7.62x51)"
	icon_state = "sniper_mag"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = list(CALIBER_762)
	max_ammo = 7
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_SMALL_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/w308/empty
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
	name = "ammo box (7.62)"
	icon_state = "r80"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = list(CALIBER_762)
	max_ammo = 60
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_BELT_MAGAZINE)

/obj/item/ammo_box/magazine/mg34/empty
	start_empty = 1

/obj/item/ammo_box/magazine/mm762
	name = "ammo belt (.308)"
	icon_state = "762belt"
	ammo_type = /obj/item/ammo_casing/a762/sport
	max_ammo = 80
	w_class = WEIGHT_CLASS_NORMAL
	caliber = list(CALIBER_762)
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_BELT_MAGAZINE)

/obj/item/ammo_box/magazine/mm762/empty
	start_empty = 1

/obj/item/ammo_box/magazine/mm762/can_load()
	return 0

/obj/item/ammo_box/magazine/mm762/update_icon()
	..()
	icon_state = "762belt-[round(ammo_count(),20)]"

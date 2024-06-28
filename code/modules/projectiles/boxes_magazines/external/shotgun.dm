/obj/item/ammo_box/magazine/m12g
	name = "shotgun magazine (12g buckshot)"
	desc = "A drum magazine."
	icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 8
	custom_materials = list(/datum/material/iron = MATS_SHOTGUN_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m12g/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(0)/8, 1)*8]"

/obj/item/ammo_box/magazine/m12g/stun
	name = "shotgun magazine (12g taser slugs)"
	icon_state = "m12gs"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/stunslug

/obj/item/ammo_box/magazine/m12g/slug
	name = "shotgun magazine (12g slugs)"
	icon_state = "m12gsl"
	ammo_type = /obj/item/ammo_casing/generic/shotgun

/obj/item/ammo_box/magazine/m12g/dragon
	name = "shotgun magazine (12g dragon's breath)"
	icon_state = "m12gf"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/m12g/bioterror
	name = "shotgun magazine (12g bioterror)"
	icon_state = "m12gt"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g/meteor
	name = "shotgun magazine (12g meteor slugs)"
	icon_state = "m12gbc"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/meteorslug

/obj/item/ammo_box/magazine/m12g/scatter
	name = "shotgun magazine (12g scatter laser shot slugs)"
	icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/laserslug

/*
---Fallout 13---
*/

/obj/item/ammo_box/magazine/d12g
	name = "shotgun drum magazine"
	desc = "A 12g drum magazine."
	icon_state = "riotmag"
	ammo_type = /obj/item/ammo_casing/generic/shotgun
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 12
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SHOTGUN_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/d12g/buck
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot

/obj/item/ammo_box/magazine/d12g/empty
	start_empty = 1

/obj/item/ammo_box/magazine/saiga
	name = "shotgun magazine"
	desc = "A 12g magazine."
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "shotgunmag"
	ammo_type = /obj/item/ammo_casing/generic/shotgun
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 8
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SHOTGUN_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/saiga/empty
	start_empty = 1

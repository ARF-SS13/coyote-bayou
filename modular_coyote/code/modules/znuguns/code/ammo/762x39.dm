
//////////////////// MAGAZINES ////////////////////

/obj/item/ammo_box/magazine/sks
	name = ".308 SKS clip"
	icon_state = "enbloc-8"
	randomize_ammo_count = FALSE
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 8
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

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

	fixed_mag = TRUE

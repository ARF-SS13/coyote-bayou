/obj/item/ammo_box/magazine/m10mm/rifle
	name = "rifle magazine (10mm)"
	desc = "A well-worn magazine fitted for the surplus rifle."
	icon_state = "75-8"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = list(CALIBER_COMPACT)
	max_ammo = 10
	custom_materials = list(/datum/material/iron = MATS_LIGHT_SMALL_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m10mm/rifle/update_icon()
	if(ammo_count())
		icon_state = "75-8"
	else
		icon_state = "75-0"

/obj/item/ammo_box/magazine/m556
	name = "toploader magazine (5.56mm)"
	icon_state = "5.56m"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = list(CALIBER_MEDIUM)
	max_ammo = 30
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/*
---Fallout 13---
*/

/obj/item/ammo_box/magazine/autopipe
	name = "pipe rifle ammo belt (.357-ish)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "autopipe_belt"
	caliber = CALIBER_COMPACT
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 18
	multiple_sprites = 2
	custom_materials = list(/datum/material/cardboard = 20000)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/autopipe/empty
	start_empty = 1

/obj/item/ammo_box/magazine/autopipe/update_icon()
	..()
	icon_state = "autopipe_belt-[round(ammo_count(),9)]"

/obj/item/ammo_box/magazine/m556/rifle
	name = "rifle magazine (5.56mm)"
	icon_state = "r20"
	caliber = list(CALIBER_MEDIUM)
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m556/rifle/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m556/rifle/small
	name = "small rifle magazine (5.56mm)"
	icon_state = "r10"
	max_ammo = 10
	custom_materials = list(/datum/material/iron = MATS_LIGHT_SMALL_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m556/rifle/small/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m556/rifle/assault
	name = "rifle magazine (5.56mm)"
	icon_state = "r30"
	max_ammo = 30
	ammo_type = /obj/item/ammo_casing/a556
	custom_materials = list(/datum/material/iron = MATS_LIGHT_LARGE_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m556/rifle/assault/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m556/rifle/extended
	name = "extended rifle magazine (5.56mm)"
	icon_state = "r50"
	max_ammo = 50
	ammo_type = /obj/item/ammo_casing/a556
	custom_materials = list(/datum/material/iron = MATS_LIGHT_EXTENDED_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL

// for testing
/obj/item/ammo_box/magazine/m556/rifle/extended/hobo
	ammo_type = /obj/item/ammo_casing/a556/improvised

/obj/item/ammo_box/magazine/m556/rifle/extended/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m5mm
	name = "Assault Rifle Magazine (5mm)"
	icon_state = "r30"
	caliber = list(CALIBER_MEDIUM)
	ammo_type = /obj/item/ammo_casing/m5mm
	max_ammo = 30
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_LARGE_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m5mm/empty
	start_empty = 1

/obj/item/ammo_box/magazine/garand3006
	name = "en-bloc clip (.30-06)"
	icon_state = "enbloc-8"
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_LONG)
	randomize_ammo_count = FALSE
	max_ammo = 8
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)

/obj/item/ammo_box/magazine/garand3006/update_icon()
	..()
	if (ammo_count() >= 8)
		icon_state = "enbloc-8"
	else
		icon_state = "enbloc-[ammo_count()]"

/obj/item/ammo_box/magazine/garand3006/empty
	start_empty = 1

/obj/item/ammo_box/magazine/sks
	name = ".308 SKS clip"
	icon_state = "enbloc-8"
	randomize_ammo_count = FALSE
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_LONG)
	max_ammo = 8
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/sks/update_icon()
	..()
	if (ammo_count() >= 10)
		icon_state = "enbloc-8"
	else
		icon_state = "enbloc-[ammo_count()]"

/obj/item/ammo_box/magazine/sks/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m308
	name = "rifle magazine (.308)"
	icon_state = "mag308"
	ammo_type = /obj/item/ammo_casing/a308
	randomize_ammo_count = FALSE
	caliber = list(CALIBER_LONG)
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m308/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m308/ext
	name = "extended rifle magazine (.308)"
	icon_state = "extmag308"
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_EXTENDED_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m308/ext/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m473
	name = "g11 magazine (4.73mm)"
	icon_state = "473mm"
	caliber = list(CALIBER_MEDIUM)
	ammo_type = /obj/item/ammo_casing/caseless/g11
	max_ammo = 50
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/m473custom
	name = "g11 magazine (4.73mm)"
	icon_state = "473mmc"
	caliber = list(CALIBER_MEDIUM)
	ammo_type = /obj/item/ammo_casing/caseless/g11
	max_ammo = 30
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/fallout/objects/guns/ammo.dmi'

/obj/item/ammo_box/magazine/m473custom/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m473/explosive
	name = "g11 magazine (4.73mm explosive)"
	icon_state = "473mm"
	ammo_type = /obj/item/ammo_casing/caseless/g11/explosive
	max_ammo = 50
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m473/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m473/small
	name = "4.7mm carbine magazine"
	icon_state = "473small"
	max_ammo = 40 // Less than the P90 despite same damage
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m473/small/empty
	start_empty = 1

/obj/item/ammo_box/magazine/machinegundrummag
	name = "Custom OstStrauss magazine"
	icon_state = "mg3"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = list(CALIBER_MEDIUM)
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 35
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/rifle47mm
	name = "4.7mm magazine"
	icon_state = "47mm"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = list(CALIBER_MEDIUM)
	ammo_type = /obj/item/ammo_casing/caseless/g11
	max_ammo = 35
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/rifle47mm/empty
	start_empty = 1

/obj/item/ammo_box/magazine/stg
	name = "Stg-44 magazine chambered in 8mm kurz (.30-06)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "stgmag"
	caliber = list(CALIBER_LONG)
	ammo_type = /obj/item/ammo_casing/a3006
	max_ammo = 30
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_SMALL_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/stg/empty
	start_empty = 1


/obj/item/ammo_box/magazine/fallschirm
	name = "FG-42 magazine chambered in 8mm kurz (.30-06)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "fg42"
	caliber = list(CALIBER_LONG)
	ammo_type = /obj/item/ammo_casing/a3006
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_SMALL_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/fallschirm/empty
	start_empty = 1


/obj/item/ammo_box/magazine/geight
	name = "patrone 88 cartridge (30-06)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "3006"
	caliber = list(CALIBER_LONG)
	ammo_type = /obj/item/ammo_casing/a3006
	max_ammo = 5
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_SMALL_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/geight/update_icon()
	..()
	if (ammo_count() >= 5)
		icon_state = "3006-5"
	else
		icon_state = "3006-[ammo_count()]"

/obj/item/ammo_box/magazine/geight/empty
	start_empty = 1


/obj/item/ammo_box/magazine/pzb39magazne
	name = "Pzb39 Box magazine"
	icon_state = "pzb39"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = list(CALIBER_LONG)
	ammo_type = /obj/item/ammo_casing/a50MG
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL
	multiload = FALSE

/obj/item/ammo_box/magazine/pzb39magazine/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m2mm
	name = "2mm electromagnetic magazine"
	icon_state = "2mm"
	ammo_type = /obj/item/ammo_casing/c2mm
	caliber = list(CALIBER_MEDIUM)
	randomize_ammo_count = FALSE
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MISC)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m2mm/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/m2mm/blender
	name = "2mm \"Blender\" electromagnetic magazine"
	ammo_type = /obj/item/ammo_casing/c2mm/blender
	max_ammo = 10
	multiple_sprites = 2

/obj/item/ammo_box/magazine/amr
	name = "Anti-material rifle magazine (.50)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "50mag"
	max_ammo = 8
	randomize_ammo_count = FALSE
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_LONG)
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/amr/bifrost
	name = "\improper MK-18 MOD 1 Mjolnir 8 round Aluminum magazine"
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_LONG)

/obj/item/ammo_box/magazine/spaagrifle
	name = "reloadable recoiless rifle magazine"
	ammo_type = /obj/item/ammo_casing/a50MG
	icon_state = "spaagrocket"
	caliber = list(CALIBER_LONG)
	max_ammo = 1
	custom_materials = list(/datum/material/iron = MATS_MISC)
	w_class = WEIGHT_CLASS_HUGE
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	multiple_sprites = 2


/obj/item/ammo_box/magazine/spaagrifle/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/highcaliber
	name = ".50 cal magazine"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "hcmag"
	max_ammo = 4
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_LONG)
	multiple_sprites= 2
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/highcaliber/empty
	start_empty= TRUE
/obj/item/ammo_box/magazine/amr/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/amr/incindiary
	name = "Anti-material magazine (Incindiary)"
	desc = "A .50 anti-material rifle magazine loaded with incindiary ammo."
	special_ammo = TRUE
	ammo_type = /obj/item/ammo_casing/a50MG/incendiary

/obj/item/ammo_box/magazine/amr/penetrator
	name = "Anti-material magazine (penetrator)"
	desc = "A .50 anti-material rifle magazine loaded with wall-penetrating ammo."
	special_ammo = TRUE
	ammo_type = /obj/item/ammo_casing/a50MG/penetrator

/obj/item/ammo_box/magazine/boys
	name = "Boys magazine (.50)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "boys"
	max_ammo = 5
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_LONG)
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/boys/empty
	start_empty = TRUE

/*
/obj/item/ammo_box/magazine/amr/uranium
	name = "Anti-material magazine (uranium)"
	desc = "A .50 anti-material rifle magazine loaded with crimes against god."
	special_ammo = TRUE
	ammo_type = /obj/item/ammo_casing/a50MG/uraniumtipped

/obj/item/ammo_box/magazine/sniper_rounds/soporific
	name = "sniper rounds (Zzzzz)"
	desc = "Soporific sniper rounds, designed for happy days and dead quiet nights..."
	icon_state = "soporific"
	max_ammo = 3
	caliber = ".50"

/obj/item/ammo_box/magazine/sniper_rounds/penetrator
	name = "sniper rounds (penetrator)"
	desc = "An extremely powerful round capable of passing straight through cover and anyone unfortunate enough to be behind it."
	max_ammo = 5
*/


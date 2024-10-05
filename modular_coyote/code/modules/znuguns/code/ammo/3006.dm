// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/s3006 // smokeless
	name = ".30-06 bullet"
	damage = 90
	damage_list = list("45" = 20, "90" = 60, "180" = 20)
	stamina = list("45" = 20, "90" = 60, "180" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_3006

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_3006
	damage_falloff = 0

/obj/item/projectile/bullet/m3006 // military
	name = ".30-06 bullet"
	damage = 95
	damage_list = list("45" = 10, "95" = 60, "190" = 30)
	stamina = list("45" = 10, "95" = 60, "190" = 30)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_3006

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_3006
	damage_falloff = 0

/obj/item/ammo_casing/s3006
	name = "smokeless .30-06 cartridge"
	desc = "A smokeless powder load for a .30-06 cartridge."
	icon_state = "762-casing"
	caliber = CALIBER_3006
	projectile_type = /obj/item/projectile/bullet/s3006
	material_class = BULLET_IS_HEAVY_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/smokelesspowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

/obj/item/ammo_casing/m3006
	name = "military .30-06 cartridge"
	desc = "Factory spec smokeless powder load for a .30-06 cartridge. Easily worth its weight in coins."
	icon_state = "762-casing"
	caliber = CALIBER_3006
	projectile_type = /obj/item/projectile/bullet/m3006
	material_class = BULLET_IS_HEAVY_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/smokelesspowder = MATS_RIFLE_HEAVY_POWDER * 1.5)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

//Smokeless
/obj/item/ammo_box/s3006
	name = "smokeless .30-06 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "3006box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s3006
	caliber = list(CALIBER_3006)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s3006/crate
	name = "smokeless .30-06 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Military
/obj/item/ammo_box/m3006
	name = "military .30-06 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "3006box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/m3006
	caliber = list(CALIBER_308)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/m3006/crate
	name = "military .30-06 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/internal/gras
	name = "Mardi-Gras breech"
	ammo_type = /obj/item/ammo_casing/s3006
	caliber = list(CALIBER_3006)
	max_ammo = 1

/obj/item/ammo_box/magazine/internal/shot/tube4570
	name = ".30-06 internal tube magazine" //brush gun
	ammo_type = /obj/item/ammo_casing/s3006
	caliber = list(CALIBER_3006)
	max_ammo = 8
	multiload = 0

/obj/item/ammo_box/magazine/internal/boltaction/hunting
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_3006)
	max_ammo = 5
	multiload = 0

/obj/item/ammo_box/magazine/internal/boltaction/hunting/enfield
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/boltaction/hunting/enfield/bar
	max_ammo = 20

/obj/item/ammo_box/magazine/boys
	name = "handmade .30-06 magazine"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "boys"
	max_ammo = 3
	ammo_type = /obj/item/ammo_casing/s3006
	caliber = list(CALIBER_3006)
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/garand3006
	name = "en-bloc clip (.30-06)"
	icon_state = "enbloc-8"
	ammo_type = /obj/item/ammo_casing/s3006
	caliber = list(CALIBER_3006)
	randomize_ammo_count = FALSE
	max_ammo = 8
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)

	fixed_mag = TRUE

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/s3006
	name = "smokeless .30-06 box"
	id = "smokeless3006box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/s3006
	category = list("initial", "Smokeless Loads")

/datum/design/ammolathe/s3006/crate
	name = "smokeless .30-06 crate"
	id = "smokeless3006crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/s3006/crate

/datum/design/ammolathe/m3006
	name = "military .30-06 box"
	id = "military3006box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/m3006
	category = list("initial", "Military Loads")

/datum/design/ammolathe/m3006/crate
	name = "military .30-06 crate"
	id = "military3006crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 1 SHEETS)
	build_path = /obj/item/ammo_box/m3006/crate

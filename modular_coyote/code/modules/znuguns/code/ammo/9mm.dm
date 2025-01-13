// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

////////////////// Ammo ////////////////////
/obj/item/projectile/bullet/b9mm
	name = "9mm bullet"
	damage = 20
	damage_list = list("10" = 20, "20" = 60, "40" = 20)
	stamina = list("10" = 20, "20" = 60, "40" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/s9mm
	name = "9mm bullet"
	damage = 25
	damage_list = list("12.5" = 20, "25" = 60, "50" = 20)
	stamina = list("12.5" = 20, "25" = 60, "50" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/m9mm
	name = "9mm bullet"
	damage = 30
	damage_list = list("15" = 20, "30" = 60, "60" = 20)
	stamina = list("15" = 20, "30" = 60, "60" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/ammo_casing/b9mm
	name = "blackpowder 9mm cartridge"
	desc = "A standard blackpowder load for a 9mm cartridge."
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/b9mm
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_9MM

/obj/item/ammo_casing/s9mm
	name = "smokeless 9mm cartridge"
	desc = "A standard smokeless powder load for a 9mm cartridge."
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/s9mm
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/smokelesspowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_9MM

/obj/item/ammo_casing/m9mm
	name = "military 9mm cartridge"
	desc = "A factory spec smokeless powder load for a 9mm cartridge, fit for service."
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/m9mm
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/smokelesspowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_9MM


//Ammo boxes and crates
//Black Powder
/obj/item/ammo_box/b9mm
	name = "blackpowder 9mm box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 90
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/b9mm/crate
	name = "Black powder 9mm ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 360

//Smokeless
/obj/item/ammo_box/s9mm
	name = "smokeless 9mm box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 90
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s9mm/crate
	name = "smokeless 9mm ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 360

//Military
/obj/item/ammo_box/m9mm
	name = "smokeless 9x19 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/m9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 90
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/m9mm/crate
	name = "smokeless 9x19 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 360

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmp"
	ammo_type = /obj/item/ammo_casing/s9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMALL_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/zipgun
	name = "Zip gun clip (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "zip"
	ammo_type = /obj/item/ammo_casing/c9mm/improvised
	caliber = ZIPGUN_AMMO_CALIBERS
	max_ammo = 5
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SPEEDLOADER)
	w_class = WEIGHT_CLASS_TINY

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/m9mm/doublestack
	name = "doublestack pistol magazine (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m9mmds"
	ammo_type = /obj/item/ammo_casing/s9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 15
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/m1carbine
	name = "9mm carbine magazine"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m10mm"
	ammo_type = /obj/item/ammo_casing/s9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 12
	multiple_sprites = 2

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/uzim9mm
	name = "stick mag (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "uzi9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 30
	custom_materials = list(/datum/material/iron = MATS_SMG)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/b9mm
	name = "black powder 9mm box"
	id = "blackpowder9mmbox"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/blackpowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/b9mm
	category = list("initial", "Blackpowder Loads")

/datum/design/ammolathe/b9mm/crate
	name = "black powder 9mm crate"
	id = "blackpowder9mmcrate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/blackpowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/b9mm/crate

/datum/design/ammolathe/s9mm
	name = "smokeless 9mm box"
	id = "smokeless9mmbox"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/s9mm
	category = list("initial", "Smokeless Loads")

/datum/design/ammolathe/s9mm/crate
	name = "smokeless 9mm crate"
	id = "smokeless9mmcrate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/s9mm/crate

/datum/design/ammolathe/m9mm
	name = "military 9mm box"
	id = "military9mmbox"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/m9mm
	category = list("initial", "Military Loads")

/datum/design/ammolathe/m9mm/crate
	name = "military 9mm crate"
	id = "military9mmcrate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 1 SHEETS)
	build_path = /obj/item/ammo_box/m9mm/crate

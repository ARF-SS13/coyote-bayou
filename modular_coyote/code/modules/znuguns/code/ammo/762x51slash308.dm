// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/s308 // smokeless
	name = ".308 bullet"
	damage = 60
	damage_list = list("30" = 20, "60" = 60, "120" = 20)
	stamina = list("30" = 20, "60" = 60, "120" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_308
	damage_falloff = 0

	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/m308 // military
	name = "7.62x51mm bullet"
	damage = 65
	damage_list = list("32.5" = 20, "65" = 60, "130" = 20)
	stamina = list("32.5" = 20, "65" = 60, "130" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_308
	damage_falloff = 0

	eyeblur = 1 SECONDS

/obj/item/ammo_casing/s308
	name = "smokeless .308 cartridge"
	desc = "A smokeless powder load for a .308 cartridge. Fits just fine in 7.62x51mm rifles."
	icon_state = "762-casing"
	caliber = CALIBER_308
	projectile_type = /obj/item/projectile/bullet/s308
	material_class = BULLET_IS_MEDIUM_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

/obj/item/ammo_casing/m308
	name = "military 7.62x51mm cartridge"
	desc = "A factory spec smokeless powder load for a 7.62x51mm cartridge, fit for service. Fits just fine in .308 rifles."
	icon_state = "762-casing"
	caliber = CALIBER_308
	projectile_type = /obj/item/projectile/bullet/m308
	material_class = BULLET_IS_MEDIUM_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

///////////////////// Ammo Box ///////////////////

/obj/item/ammo_box/s308
	name = "smokeless 7.62x39 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "762box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s308
	caliber = list(CALIBER_308)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s308/crate
	name = "smokeless 7.62x39 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//////////////////// AMMO BOX + CRATE ////////////////////

//Smokeless
/obj/item/ammo_box/s308
	name = "smokeless .308 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "308box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s308
	caliber = list(CALIBER_308)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s308/crate
	name = "smokeless .308 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Military
/obj/item/ammo_box/m308
	name = "smokeless 7.62x51 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "308box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/m308
	caliber = list(CALIBER_308)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/m308/crate
	name = "smokeless 7.62x51 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/m308/ext
	name = "extended rifle magazine (.308)"
	icon_state = "extmag308"
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_EXTENDED_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/s308
	name = ".308 box"
	id = "smokeless308box"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/s308
	category = list("initial", "Simple Ammo")

/datum/design/ammolathe/s308/crate
	name = ".308 crate"
	id = "smokeless308crate"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/s308/crate

/datum/design/ammolathe/m308
	name = "military .308 box"
	id = "military308box"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/m308
	category = list("initial", "Simple Ammo")

/datum/design/ammolathe/mbuckshot/crate
	name = "military .308 crate"
	id = "military308crate"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/mbuckshot/crate

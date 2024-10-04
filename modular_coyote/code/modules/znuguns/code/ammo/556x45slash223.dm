// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/s556 // smokeless
	name = "5.56 bullet"
	damage = 45
	damage_list = list("22.5" = 20, "45" = 60, "90" = 20)
	stamina = list("22.5" = 20, "45" = 60, "90" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_223

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_223
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/m556 // military
	name = "5.56 bullet"
	damage = 50
	damage_list = list("25" = 20, "50" = 60, "100" = 20)
	stamina = list("25" = 20, "50" = 60, "100" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_223

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_223
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/ammo_casing/s556
	name = "smokeless .223 cartridge"
	desc = "A smokeless powder load for a .223 cartridge. Fits just fine in 5.56x45mm rifles."
	caliber = CALIBER_556
	projectile_type = /obj/item/projectile/bullet/s556
	material_class = BULLET_IS_LIGHT_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/smokelesspowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_casing/m556
	name = "military 5.56x45mm cartridge"
	desc = "A factory spec smokeless powder load for a 5.56x45mm cartridge, fit for service. Fits just fine in .223 rifles."
	caliber = CALIBER_556
	projectile_type = /obj/item/projectile/bullet/s556
	material_class = BULLET_IS_LIGHT_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/smokelesspowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_LIGHT

//////////////////// AMMO BOX + CRATE ////////////////////

//Smokeless
/obj/item/ammo_box/s556
	name = "smokeless .223 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "556box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s556
	caliber = list(CALIBER_556)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s556/crate
	name = "smokeless .223 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Military
/obj/item/ammo_box/m556
	name = "smokeless 5.56x45 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "556box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/m556
	caliber = list(CALIBER_556)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/m556/crate
	name = "smokeless 5.56x45 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/m556/rifle
	name = "rifle magazine (.223/5.56mm)"
	icon_state = "r20"
	caliber = list(CALIBER_556)
	max_ammo = 20
	ammo_type = /obj/item/ammo_casing/s556
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/m556/rifle/assault
	name = "rifle magazine (.223/5.56mm)"
	icon_state = "r30"
	max_ammo = 30
	custom_materials = list(/datum/material/iron = MATS_LIGHT_LARGE_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE


///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/s556
	name = "smokeless .223 box"
	id = "smokeless556box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/s556
	category = list("initial", "Smokeless Loads")

/datum/design/ammolathe/s556/crate
	name = "smokeless .223 crate"
	id = "smokeless556crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/s556/crate

/datum/design/ammolathe/m556
	name = "military 5.56x45 box"
	id = "military556box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/m556
	category = list("initial", "Military Loads")

/datum/design/ammolathe/m556/crate
	name = "military 5.56x45 crate"
	id = "military556crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 1 SHEETS)
	build_path = /obj/item/ammo_box/m556/crate

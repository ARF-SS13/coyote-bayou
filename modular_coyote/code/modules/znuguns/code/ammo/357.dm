// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/b357 // blackpowder load
	name = ".357 bullet"
	damage = 20
	damage_list = list("10" = 20, "20" = 60, "40" = 20)
	stamina = list("10" = 20, "20" = 60, "40" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/s357 // smokeless powder load
	name = ".357 bullet"
	damage = 20
	damage_list = list("12.5" = 20, "25" = 60, "50" = 20)
	stamina = list("12.5" = 20, "25" = 60, "50" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/m357 // military powder load
	name = ".357 bullet"
	damage = 20
	damage_list = list("15" = 20, "30" = 60, "60" = 20)
	stamina = list("15" = 20, "30" = 60, "60" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/ammo_casing/b357
	name = "blackpowder .357 cartridge"
	desc = "A blackpowder load for a .357 cartridge."
	caliber = CALIBER_357
	projectile_type = /obj/item/projectile/bullet/b357
	material_class = BULLET_IS_MEDIUM_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_357

/obj/item/ammo_casing/s357
	name = "smokeless .357 cartridge"
	desc = "A smokeless powder load for a .357 cartridge."
	caliber = CALIBER_357
	projectile_type = /obj/item/projectile/bullet/s357
	material_class = BULLET_IS_MEDIUM_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_357

/obj/item/ammo_casing/m357
	name = "military .357 cartridge"
	desc = "A factory spec smokeless powder load for a .357 cartridge, fit for service."
	caliber = CALIBER_357
	projectile_type = /obj/item/projectile/bullet/m357
	material_class = BULLET_IS_MEDIUM_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_357

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/internal/cylinder/rev357
	name = "357 magnum cylinder"
	ammo_type = /obj/item/ammo_casing/s357
	caliber = list(CALIBER_357)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot/tube357
	name = ".357 magnum internal tube magazine" //cowboy repeater
	ammo_type = /obj/item/ammo_casing/s357
	caliber = list(CALIBER_357)
	max_ammo = 12
	multiload = 0

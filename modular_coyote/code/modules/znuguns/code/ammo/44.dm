// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/b44 // blackpowder
	name = ".44 FMJ bullet"
	damage = 35
	damage_list = list("17.5" = 20, "35" = 60, "70" = 20)
	stamina = list("17.5" = 20, "35" = 60, "70" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_44
	damage_falloff = 0

	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/s44 // smokeless
	name = ".44 FMJ bullet"
	damage = 40
	damage_list = list("20" = 20, "40" = 60, "80" = 20)
	stamina = list("20" = 20, "40" = 60, "80" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_44
	damage_falloff = 0

	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/m44 // military
	name = ".44 FMJ bullet"
	damage = 45
	damage_list = list("22.5" = 20, "45" = 60, "90" = 20)
	stamina = list("22.5" = 20, "45" = 60, "90" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_44
	damage_falloff = 0

	eyeblur = 1 SECONDS

/obj/item/ammo_casing/b44
	name = "blackpowder .44 cartridge"
	desc = "A blackpowder load for a .44 cartridge."
	caliber = CALIBER_44
	projectile_type = /obj/item/projectile/bullet/b44
	material_class = BULLET_IS_HEAVY_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_44

/obj/item/ammo_casing/s44
	name = "smokeless .44 cartridge"
	desc = "A smokeless powder load for a .44 cartridge."
	caliber = CALIBER_44
	projectile_type = /obj/item/projectile/bullet/s44
	material_class = BULLET_IS_HEAVY_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_44

/obj/item/ammo_casing/m44
	name = "military .44 cartridge"
	desc = "A factory spec smokeless powder load for a .45 cartridge, fit for service."
	caliber = CALIBER_44
	projectile_type = /obj/item/projectile/bullet/m44
	material_class = BULLET_IS_HEAVY_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_44

/obj/item/ammo_box/magazine/internal/cylinder/rev44
	name = ".44 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/s44
	caliber = list(CALIBER_44)
	max_ammo = 6

/obj/item/ammo_box/magazine/m44
	name = "handgun magazine (.44 magnum)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/s44
	caliber = list(CALIBER_44)
	max_ammo = 8
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_HEAVY_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m44/empty
	start_empty = 1

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

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/m308/ext
	name = "extended rifle magazine (.308)"
	icon_state = "extmag308"
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_EXTENDED_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

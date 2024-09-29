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
	damage = 45
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
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
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
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_box/magazine/m556/rifle
	name = "rifle magazine (.223/5.56mm)"
	icon_state = "r20"
	caliber = list(CALIBER_556)
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m556/rifle/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m556/rifle/assault
	name = "rifle magazine (.223/5.56mm)"
	icon_state = "r30"
	max_ammo = 30
	ammo_type = /obj/item/ammo_casing/s556
	custom_materials = list(/datum/material/iron = MATS_LIGHT_LARGE_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m556/rifle/assault/empty
	start_empty = 1

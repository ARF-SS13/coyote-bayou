#define CALIBER_762 "7.62x39 rounds"

/obj/item/projectile/bullet/s762by39 // smokeless
	name = "7.62 bullet"
	damage = 45
	damage_list = list("22.5" = 20, "45" = 60, "90" = 20)
	stamina = list("22.5" = 20, "45" = 60, "90" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_308
	damage_falloff = 0

	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/m762by39// military
	name = "7.62 bullet"
	damage = 50
	damage_list = list("25" = 20, "50" = 60, "100" = 20)
	stamina = list("25" = 20, "50" = 60, "100" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_RIFLE_308
	damage_falloff = 0

	eyeblur = 1 SECONDS

/obj/item/ammo_casing/s762by39
	name = "smokeless 7.62x39mm cartridge"
	desc = "A smokeless powder load for a 7.62x39mm cartridge."
	icon_state = "762-casing"
	caliber = CALIBER_762
	projectile_type = /obj/item/projectile/bullet/s308
	material_class = BULLET_IS_MEDIUM_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

/obj/item/ammo_casing/m762by39
	name = "military 7.62x39mm cartridge"
	desc = "A factory spec smokeless powder load for a 7.62x39mm cartridge, fit for service."
	icon_state = "762-casing"
	caliber = CALIBER_762
	projectile_type = /obj/item/projectile/bullet/m308
	material_class = BULLET_IS_MEDIUM_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM


//////////////////// MAGAZINES ////////////////////

/obj/item/ammo_box/magazine/sks
	name = ".308 SKS clip"
	icon_state = "enbloc-8"
	randomize_ammo_count = FALSE
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 8
	custom_materials = list(/datum/material/iron = MATS_STRIPPER)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/rpd
	name = "rpd drum magazine"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "rpdm"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_BRICK_RIFLE_MAGAZINE)

	fixed_mag = TRUE

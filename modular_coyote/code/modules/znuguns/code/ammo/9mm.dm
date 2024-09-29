// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

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
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
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
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_9MM

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

/obj/item/ammo_box/magazine/m9mm/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m9mm/doublestack
	name = "doublestack pistol magazine (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m9mmds"
	ammo_type = /obj/item/ammo_casing/s9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 15
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

/obj/item/ammo_box/magazine/m9mm/doublestack/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m1carbine
	name = "9mm carbine magazine"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m10mm"
	ammo_type = /obj/item/ammo_casing/s9mm
	max_ammo = 12
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m1carbine/empty
	start_empty = 1

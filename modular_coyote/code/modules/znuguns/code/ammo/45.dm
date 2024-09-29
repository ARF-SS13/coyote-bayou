// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/b45 // blackpowder
	name = ".45 FMJ bullet"
	damage = 25
	damage_list = list("12.5" = 20, "25" = 60, "50" = 20)
	stamina = list("12.5" = 20, "25" = 60, "50" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/s45 // smokeless
	name = ".45 FMJ bullet"
	damage = 35
	damage_list = list("17.5" = 20, "35" = 60, "70" = 20)
	stamina = list("17.5" = 20, "35" = 60, "70" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/projectile/bullet/m45 // military
	name = ".45 FMJ bullet"
	damage = 40
	damage_list = list("20" = 20, "40" = 60, "80" = 20)
	stamina = list("20" = 20, "40" = 60, "80" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/ammo_casing/b45
	name = "blackpowder .45 cartridge"
	desc = "A blackpowder load for a .45 cartridge."
	caliber = CALIBER_45ACP
	projectile_type = /obj/item/projectile/bullet/b45
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_45

/obj/item/ammo_casing/s45
	name = "smokeless .45 cartridge"
	desc = "A smokeless powder load for a .45 cartridge."
	caliber = CALIBER_45ACP
	projectile_type = /obj/item/projectile/bullet/s45
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_45

/obj/item/ammo_casing/m45
	name = "military .45 cartridge"
	desc = "A factory spec smokeless powder load for a .45 cartridge, fit for service."
	caliber = CALIBER_45ACP
	projectile_type = /obj/item/projectile/bullet/m45
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_45

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/internal/cylinder/rev45
	name = ".45 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev45/empty
	start_empty = 1

/obj/item/ammo_box/magazine/internal/cylinder/rev45/gunslinger
	name = ".45 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev45/gunslinger/empty
	start_empty = 1

/obj/item/ammo_box/magazine/internal/cylinder/rev45/two
	name = ".45 revolver breech"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/cylinder/rev45/two/empty
	start_empty = 1

/obj/item/ammo_box/magazine/cg45
	name = "handmade .45 stick magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "cg45"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMG)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/cg45/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m45
	name = "handgun magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 8
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

/obj/item/ammo_box/magazine/m45/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m45/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),4)]"


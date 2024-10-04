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

//Ammo boxes and crates
//Black Powder
/obj/item/ammo_box/b357
	name = "blackpowder .357 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "357box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/b357
	caliber = list(CALIBER_357)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/b357/crate
	name = "Black powder .357 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Smokeless
/obj/item/ammo_box/s357
	name = "smokeless .357 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "357box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s357
	caliber = list(CALIBER_357)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s357/crate
	name = "smokeless .357 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Military
/obj/item/ammo_box/m357
	name = "smokeless .357 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "357box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/m357
	caliber = list(CALIBER_357)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/m357/crate
	name = "smokeless .357 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240


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

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/b357
	name = "black powder .357 box"
	id = "blackpowder357box"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/b357
	category = list("initial", "Simple Ammo")

/datum/design/ammolathe/b357/crate
	name = "black powder .357 crate"
	id = "blackpowder357crate"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/b357/crate

/datum/design/ammolathe/s357
	name = ".357 box"
	id = "smokeless357box"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/s357
	category = list("initial", "Simple Ammo")

/datum/design/ammolathe/s357/crate
	name = ".357 crate"
	id = "smokeless357crate"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/s357/crate

/datum/design/ammolathe/m357
	name = "military .357 box"
	id = "military357box"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/m357
	category = list("initial", "Simple Ammo")

/datum/design/ammolathe/m357/crate
	name = "military .357 crate"
	id = "military357crate"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/m357/crate

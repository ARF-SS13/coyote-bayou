// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/b22 // blackpowder load
	name = ".22lr bullet"
	damage = 10
	damage_list = list("5" = 30, "10" = 60, "20" = 10)
	stamina = list("5" = 30, "10" = 60, "20" = 10)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22
	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/ammo_casing/b22
	name = "blackpowder .22LR cartridge"
	desc = "A blackpowder load for a .22LR cartridge."
	caliber = CALIBER_22LR
	projectile_type = /obj/item/projectile/bullet/b22
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_PISTOL_22

/obj/item/projectile/bullet/s22 // smokeless load
	name = ".22lr bullet"
	damage = 15
	damage_list = list("7.5" = 30, "15" = 60, "30" = 10)
	stamina = list("7.5" = 30, "15" = 60, "30" = 10)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22
	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = 0
	eyeblur = 1 SECONDS

/obj/item/ammo_casing/s22
	name = "smokeless .22LR cartridge"
	desc = "A standard smokeless load for a .22LR cartridge."
	caliber = CALIBER_22LR
	projectile_type = /obj/item/projectile/bullet/s22
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_PISTOL_22

///////////////////// Ammo Boxes ///////////////////

//Black Powder
/obj/item/ammo_box/b22
	name = "blackpowder .22 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "22box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/b22
	caliber = list(CALIBER_22LR)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/b22/crate
	name = "Black powder .22 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Smokeless
/obj/item/ammo_box/s22
	name = "smokeless .22 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = ".22box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s22
	caliber = list(CALIBER_22LR)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s22/crate
	name = "smokeless .22 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/m22
	name = "pistol magazine (.22LR)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "pistol22"
	ammo_type = /obj/item/ammo_casing/s22
	caliber = list(CALIBER_22LR)
	max_ammo = 16
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = 1 SHEETS)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/m22/extended
	name = "carbine magazine (.22LR)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "22carbine"
	ammo_type = /obj/item/ammo_casing/s22
	caliber = list(CALIBER_22LR)
	max_ammo = 32
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = 2 SHEETS)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/internal/cylinder/rev22
	name = ".22 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/s22
	caliber = list(CALIBER_22LR)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot/long22
	name = ".22LR Long internal tube magazine" //baby repeater
	ammo_type = /obj/item/ammo_casing/s22
	caliber = list(CALIBER_22LR)
	max_ammo = 16
	multiload = 1

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/b22
	name = "black powder .22 box"
	id = "b22"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/b22
	category = list("initial", "Simple Ammo")

/datum/design/ammolathe/b22/crate
	name = "black powder .22 crate"
	id = "b22crate"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/b22/crate

/datum/design/ammolathe/s22
	name = ".22 box"
	id = "s22"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/s22
	category = list("initial", "Simple Ammo")

/datum/design/ammolathe/s22/crate
	name = ".22 crate"
	id = "s22"
	materials = list(/datum/material/iron = 8 SHEETS, /datum/material/blackpowder = 10 SHEETS)
	build_path = /obj/item/ammo_box/s22/crate

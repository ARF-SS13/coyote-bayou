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
		/datum/material/smokelesspowder = MATS_PISTOL_HEAVY_POWDER)
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
		/datum/material/smokelesspowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_44

//Ammo boxes and crates
//Black Powder
/obj/item/ammo_box/b44
	name = "blackpowder .44 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "44box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/b44
	caliber = list(CALIBER_44)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/b44/crate
	name = "Black powder .44 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Smokeless
/obj/item/ammo_box/s44
	name = "smokeless .44 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "44box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s44
	caliber = list(CALIBER_44)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s44/crate
	name = "smokeless .44 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Military
/obj/item/ammo_box/m44
	name = "smokeless .44 box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "44box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/m44
	caliber = list(CALIBER_44)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/m44/crate
	name = "smokeless .44 ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

///////////////////// Magazines///////////////////

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

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/internal/shot/tube44
	name = ".44 magnum internal tube magazine" //trail carbine
	ammo_type = /obj/item/ammo_casing/s44
	caliber = list(CALIBER_44)
	max_ammo = 12
	multiload = 1

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/b44
	name = "black powder .44 box"
	id = "blackpowder44box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/blackpowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/b44
	category = list("initial", "Blackpowder Loads")

/datum/design/ammolathe/b44/crate
	name = "black powder .44 crate"
	id = "blackpowder44crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/blackpowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/b44/crate

/datum/design/ammolathe/s44
	name = "smokeless .44 box"
	id = "smokeless44box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/s44
	category = list("initial", "Smokeless Loads")

/datum/design/ammolathe/s44/crate
	name = "smokeless .44 crate"
	id = "smokeless44crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/s9mm/crate

/datum/design/ammolathe/m44
	name = "military .44 box"
	id = "military44box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/m44
	category = list("initial", "Military Loads")

/datum/design/ammolathe/m44/crate
	name = "military .44 crate"
	id = "military44crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 1 SHEETS)
	build_path = /obj/item/ammo_box/m44/crate

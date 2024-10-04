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
		/datum/material/smokelesspowder = MATS_PISTOL_MEDIUM_POWDER)
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
		/datum/material/smokelesspowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_45

//Ammo boxes and crates
//Black Powder
/obj/item/ammo_box/b45
	name = "blackpowder .45 ACP box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/b45
	caliber = list(CALIBER_45ACP)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/b45/crate
	name = "Black powder .45 ACP ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Smokeless
/obj/item/ammo_box/s45
	name = "smokeless .45 ACP box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/s45/crate
	name = "smokeless .45 ACP ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Military
/obj/item/ammo_box/m45
	name = "smokeless .45 ACP box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45box"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/m45
	caliber = list(CALIBER_45ACP)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/m45/crate
	name = "smokeless .45 ACP ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

///////////////////// Magazines///////////////////

/obj/item/ammo_box/magazine/internal/cylinder/rev45
	name = "revolver cylinder (.45)"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev45/empty
	start_empty = 1

/obj/item/ammo_box/magazine/internal/cylinder/rev45/gunslinger
	name = "revolver cylinder (.45)"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev45/gunslinger/empty
	start_empty = 1

/obj/item/ammo_box/magazine/internal/cylinder/rev45/two
	name = "two shot breech (.45)"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/cylinder/rev45/two/empty
	start_empty = 1

/obj/item/ammo_box/magazine/cg45
	name = "handmade stick magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "cg45"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMG)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/m45
	name = "handgun magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45"
	ammo_type = /obj/item/ammo_casing/s45
	caliber = list(CALIBER_45ACP)
	max_ammo = 8
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/m45/socom
	name = "tactical handgun magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45socom"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 12
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

	fixed_mag = TRUE

/obj/item/ammo_box/magazine/greasegun
	name = "stick magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "grease"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = list(CALIBER_45ACP)
	max_ammo = 30
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMG)
	w_class = WEIGHT_CLASS_SMALL

	fixed_mag = TRUE

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/b45
	name = "blackpowder .45 box"
	id = "blackpowder45box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/blackpowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/b45
	category = list("initial", "Blackpowder Loads")

/datum/design/ammolathe/b45/crate
	name = "blackpowder .45 crate"
	id = "blackpowder45crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/blackpowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/b45/crate

/datum/design/ammolathe/s45
	name = "smokeless .45 box"
	id = "smokeless45box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/s45
	category = list("initial", "Smokeless Loads")

/datum/design/ammolathe/s45/crate
	name = "smokeless .45 crate"
	id = "smokeless45crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/s45/crate

/datum/design/ammolathe/m45
	name = "military .45 box"
	id = "military45box"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/m45
	category = list("initial", "Military Loads")

/datum/design/ammolathe/m45/crate
	name = "military .45 crate"
	id = "military45crate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 1 SHEETS)
	build_path = /obj/item/ammo_box/m45/crate

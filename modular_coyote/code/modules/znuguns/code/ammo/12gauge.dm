// Put projectiles, casings, magazines here. Guns go in their respective tiers somewhere around modular_coyote/code/modules/znuguns/code/guns .

/obj/item/projectile/bullet/pellet/bbuckshot // blackpowder
	name = "buckshot pellet"
	damage = 50
	damage_list = list("10" = 20, "12.5" = 60, "15" = 20)
	stamina = list("10" = 20, "12.5" = 60, "15" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = 0

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

	eyeblur = 0.5 SECONDS

/obj/item/ammo_casing/shotgun/bbuckshot
	name = "blackpowder buckshot shell"
	desc = "A 12 gauge shell filled with blackpowder and buckshot."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet/sbuckshot
	pellets = 4
	variance = SHOTGUN_SPREAD_BASE
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_PISTOL_LIGHT_BULLET),
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)

/obj/item/projectile/bullet/pellet/sbuckshot // smokeless
	name = "buckshot pellet"
	damage = 60
	damage_list = list("15" = 20, "20" = 60, "25" = 20)
	stamina = list("15" = 20, "20" = 60, "25" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = 0

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

	eyeblur = 0.5 SECONDS

/obj/item/ammo_casing/shotgun/sbuckshot
	name = "smokeless powder buckshot shell"
	desc = "A 12 gauge shell filled with smokeless powder and buckshot."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet/sbuckshot
	pellets = 3
	variance = SHOTGUN_SPREAD_BASE
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_PISTOL_LIGHT_BULLET),
		/datum/material/smokelesspowder = MATS_RIFLE_LIGHT_POWDER)

/obj/item/projectile/bullet/pellet/mbuckshot // military
	name = "buckshot pellet"
	damage = 65
	damage_list = list("16.25" = 20, "32.5" = 60, "65" = 20)
	stamina = list("16.25" = 20, "32.5" = 60, "65" = 20)
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = 0

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

	eyeblur = 0.5 SECONDS

/obj/item/ammo_casing/shotgun/mbuckshot
	name = "military buckshot shell"
	desc = "A 12 gauge shell filled with smokeless powder fit for a soldier and buckshot."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet/sbuckshot
	pellets = 2
	variance = SHOTGUN_SPREAD_BASE
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_PISTOL_LIGHT_BULLET),
		/datum/material/smokelesspowder = MATS_RIFLE_MEDIUM_POWDER)

//Ammo boxes and crates
//Black Powder
/obj/item/ammo_box/bbuckshot
	name = "blackpowder buckshot box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "gbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/shotgun/bbuckshot
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/bbuckshot/crate
	name = "Black powder buckshot ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Smokeless
/obj/item/ammo_box/sbuckshot
	name = "smokeless buckshot box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "gbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/shotgun/sbuckshot
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/sbuckshot/crate
	name = "smokeless buckshot ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240

//Military
/obj/item/ammo_box/mbuckshot
	name = "smokeless 12 gauge box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "gbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/shotgun/mbuckshot
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/mbuckshot/crate
	name = "smokeless 12 gauge ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 240


///////////////// Magazines ////////////////////

/obj/item/ammo_box/magazine/internal/shot
	name = "shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/sbuckshot
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 4
	multiload = 0

/obj/item/ammo_box/magazine/internal/shot/single
	name = "single-barrel shotgun breech"
	max_ammo = 1

/obj/item/ammo_box/magazine/internal/shot/dual
	name = "double-barrel shotgun breech"
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/shot/trench
	ammo_type = /obj/item/ammo_casing/shotgun/sbuckshot
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot/police
	name = "police shotgun tube"
	max_ammo = 8

/obj/item/ammo_box/magazine/saiga
	name = "shotgun magazine"
	desc = "A 12g magazine."
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "shotgunmag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 8
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SHOTGUN_MAGAZINE)
	w_class = WEIGHT_CLASS_NORMAL

	fixed_mag = TRUE

///////////////// DESIGNS / CRAFTING RECIPES ////////////////////

/datum/design/ammolathe/bbuckshot
	name = "blackpowder shotgun box"
	id = "blackpowderbuckshotbox"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/blackpowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/bbuckshot
	category = list("initial", "Blackpowder Loads")

/datum/design/ammolathe/bbuckshot/crate
	name = "blackpowder shotgun crate"
	id = "blackpowderbuckshotcrate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/blackpowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/bbuckshot/crate

/datum/design/ammolathe/sbuckshot
	name = "smokeless shotgun box"
	id = "smokelessbuckshotbox"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.1 SHEETS)
	build_path = /obj/item/ammo_box/sbuckshot
	category = list("initial", "Smokeless Loads")

/datum/design/ammolathe/sbuckshot/crate
	name = "smokeless shotgun crate"
	id = "smokelessbuckshotcrate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/sbuckshot/crate

/datum/design/ammolathe/mbuckshot
	name = "military shotgun box"
	id = "militarybuckshotbox"
	materials = list(/datum/material/iron = 0.1 SHEETS, /datum/material/smokelesspowder = 0.5 SHEETS)
	build_path = /obj/item/ammo_box/mbuckshot
	category = list("initial", "Military Loads")

/datum/design/ammolathe/mbuckshot/crate
	name = "military shotgun crate"
	id = "militarybuckshotcrate"
	materials = list(/datum/material/iron = 0.5 SHEETS, /datum/material/smokelesspowder = 1 SHEETS)
	build_path = /obj/item/ammo_box/mbuckshot/crate

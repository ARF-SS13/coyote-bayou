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

/obj/item/ammo_box/magazine/saiga/empty
	start_empty = 1

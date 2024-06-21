// C M L S / Hunt Showdown-fication

// sorting is as follows
// basetype
// example
// actual bullets

/obj/item/projectile/bullet/generic/compact
	name = "generic compact bullet"
	damage = BULLET_DAMAGE_COMPACT // 30
	damage_list = list("30" = 60, "45" = 30, "60" = 9, "200" = 1)
	stamina = BULLET_STAMINA_COMPACT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_COMPACT

	wound_bonus = BULLET_WOUND_COMPACT
	bare_wound_bonus = BULLET_WOUND_COMPACT_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_COMPACT
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/generic/compact/cexample
	name = "this is an example compact projectile! the template goes (type)(caliber). so, for example, this one would be c(example)!"

/obj/item/projectile/bullet/generic/compact/c22
	name = ".22LR bullet"

/obj/item/projectile/bullet/generic/compact/c9mm
	name = "9mm bullet"

/obj/item/projectile/bullet/generic/compact/cneedle
	name = "amethyst needle"

/obj/item/projectile/bullet/generic/compact/c10mm
	name = "10mm bullet"

/obj/item/projectile/bullet/generic/compact/c45
	name = ".45 bullet"

/obj/item/projectile/bullet/generic/compact/c357
	name = ".357 bullet"

/obj/item/ammo_casing/generic/compact/generic
	name = "generic compact bullet casing"
	desc = "A generic compact bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/generic/compact/cexample
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_10MM

/obj/item/ammo_casing/generic/compact/cexample
	name = "compact template bullet casing"
	desc = "A compact template bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/compact/cexample

/obj/item/ammo_casing/generic/compact/c22
	name = ".22 LR bullet casing"
	desc = "A .22 LR bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/compact/c22

/obj/item/ammo_casing/generic/compact/c9mm
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/compact/c9mm

/obj/item/ammo_casing/caseless/cneedle
	name = "A needler round."
	desc = "A dart for use in needler pistols."
	icon_state = "needlecasing"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = CALIBER_COMPACT
	force = 2
	throwforce = 1
	embedding = list("embed_chance"= 25)
	projectile_type = /obj/item/projectile/bullet/generic/compact/cneedle

/obj/item/ammo_casing/generic/compact/c10mm
	name = "10mm bullet casing"
	desc = "A 10mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/compact/c10mm

/obj/item/ammo_casing/generic/compact/c357
	name = ".357 bullet casing"
	desc = "A 10mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/compact/c357

/obj/item/ammo_box/generic/compact
	name = "(COMPACT / Generic) ammo box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "10mmbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/generic/compact
	caliber = list(CALIBER_COMPACT)
	max_ammo = 60
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_PISTOL_MEDIUM_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/generic/compact/template
	name = "(COMPACT / Template) ammo box"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/generic/compact/cexample

/obj/item/ammo_box/generic/compact/c22
	name = "(COMPACT / .22LR) ammo box"
	icon_state = "22box"
	ammo_type = /obj/item/ammo_casing/generic/compact/c22

/obj/item/ammo_box/generic/compact/c9mm
	name = "(COMPACT / 9mm) ammo box"
	icon_state = "9mmbox"
	ammo_type = /obj/item/ammo_casing/generic/compact/c9mm

/obj/item/ammo_box/generic/compact/cneedle
	name = "(COMPACT / Amethyst Needle) ammo box"
	icon_state = "9mmbox"
	ammo_type = /obj/item/ammo_casing/caseless/cneedle

/obj/item/ammo_box/generic/compact/c10mm
	name = "(COMPACT / 10mm) ammo box"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/generic/compact/c10mm

/obj/item/ammo_box/generic/compact/c357
	name = "(COMPACT / .357) ammo box"
	icon_state = "357box"
	ammo_type = /obj/item/ammo_casing/generic/compact/c357

/obj/item/ammo_box/generic/compact/crate
	name = "(COMPACT / Generic) ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 300

/obj/item/ammo_box/generic/compact/crate/template
	name = "(COMPACT / Template) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/compact/cexample

/obj/item/ammo_box/generic/compact/crate/c22
	name = "(COMPACT / .22LR) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/compact/c22

/obj/item/ammo_box/generic/compact/crate/c9mm
	name = "(COMPACT / 9mm) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/compact/c9mm

/obj/item/ammo_box/generic/compact/crate/cneedle
	name = "(COMPACT / Amethyst Needle) ammo crate"
	ammo_type = /obj/item/ammo_casing/caseless/cneedle

/obj/item/ammo_box/generic/compact/crate/c10mm
	name = "(COMPACT / 10mm) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/compact/c10mm

/obj/item/ammo_box/generic/compact/crate/c357
	name = "(COMPACT / .357) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/compact/c357

/obj/item/projectile/bullet/generic/medium
	name = "generic medium bullet"
	damage = BULLET_DAMAGE_MEDIUM // 45
	damage_list = list("30" = 25, "45" = 50, "60" = 20, "75" = 4, "200" = 1)
	stamina = BULLET_STAMINA_MEDIUM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_MEDIUM

	wound_bonus = BULLET_WOUND_MEDIUM
	bare_wound_bonus = BULLET_WOUND_MEDIUM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_MEDIUM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/generic/medium/mexample
	name = "this is an example medium projectile! the template goes (type)(caliber). so, for example, this one would be m(example)!"

/obj/item/projectile/bullet/generic/medium/m44
	name = ".44 bullet"

/obj/item/projectile/bullet/generic/medium/m14mm
	name = "14mm bullet"

/obj/item/projectile/bullet/generic/medium/m45lc
	name = ".45LC bullet"

/obj/item/projectile/bullet/generic/medium/m473
	name = "4.73 bullet"

/obj/item/projectile/bullet/generic/medium/m556
	name = "5.56 bullet"

/obj/item/projectile/bullet/generic/medium/m5mm
	name = "5mm bullet"

/obj/item/projectile/bullet/generic/medium/m2mm
	name = "2mm gauss projectile"

/obj/item/ammo_casing/generic/medium
	name = "generic medium bullet casing"
	desc = "A generic medium bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/generic/medium/mexample
	material_class = BULLET_IS_LIGHT_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_casing/generic/medium/template
	name = "medium bullet casing template"
	desc = "A medium bullet casing template. Follow me if you want to live."
	projectile_type = /obj/item/projectile/bullet/generic/medium/mexample

/obj/item/ammo_casing/generic/medium/m44
	name = ".44 bullet casing"
	desc = "A .44 bullet casing"
	projectile_type = /obj/item/projectile/bullet/generic/medium/m44

/obj/item/ammo_casing/generic/medium/m14mm
	name = "14mm bullet casing"
	desc = "A 14mm bullet casing"
	projectile_type = /obj/item/projectile/bullet/generic/medium/m14mm

/obj/item/ammo_casing/generic/medium/m45lc
	name = ".45 Long Colt bullet casing"
	desc = "A .45 Long Colt bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/medium/m45lc

/obj/item/ammo_casing/generic/medium/m473
	name = "4.73mm caseless bullet casing"
	desc = "A chalky brick of propellent with a bullet inside."
	projectile_type = /obj/item/projectile/bullet/generic/medium/m473

/obj/item/ammo_casing/generic/medium/m556
	name = "5.56 bullet casing"
	desc = "A 5.56 bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/medium/m556

/obj/item/ammo_casing/generic/medium/m5mm
	name = "5mm bullet casing"
	desc = "A 5mm bullet casing template."
	projectile_type = /obj/item/projectile/bullet/generic/medium/m5mm

/obj/item/ammo_casing/generic/medium/m2mm
	name = "2mm electromagnetic cartridge"
	desc = "A 2mm electromagnetic cartridge."
	projectile_type = /obj/item/projectile/bullet/generic/medium/m2mm

/obj/item/ammo_box/generic/medium
	name = "(MEDIUM / Generic) ammo box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "308box"
	multiple_sprites = 2
	caliber = list(CALIBER_LONG)
	ammo_type = /obj/item/ammo_casing/generic/medium
	max_ammo = 40
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_MEDIUM_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/generic/medium/template
	name = "(MEDIUM / Template) ammo box"
	icon_state = "556box"
	ammo_type = /obj/item/ammo_casing/generic/medium/template

/obj/item/ammo_box/generic/medium/m44
	name = "(MEDIUM / .44) ammo box"
	icon_state = "556box"
	ammo_type = /obj/item/ammo_casing/generic/medium/m44

/obj/item/ammo_box/generic/medium/m14mm
	name = "(MEDIUM / 14mm) ammo box"
	icon_state = "14mmbox"
	ammo_type = /obj/item/ammo_casing/generic/medium/m14mm

/obj/item/ammo_box/generic/medium/m45lc
	name = "(MEDIUM / .45 Long Colt) ammo box"
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/generic/medium/m45lc

/obj/item/ammo_box/generic/medium/m473
	name = "(MEDIUM / 4.73mm) ammo box"
	icon_state = "47box"
	ammo_type = /obj/item/ammo_casing/generic/medium/m473

/obj/item/ammo_box/generic/medium/m556
	name = "(MEDIUM / 5.56mm) ammo box"
	icon_state = "556box"
	ammo_type = /obj/item/ammo_casing/generic/medium/m556

/obj/item/ammo_box/generic/medium/m5mm
	name = "(MEDIUM / 5mm) ammo box"
	icon_state = "5mmbox"
	ammo_type = /obj/item/ammo_casing/generic/medium/m5mm

/obj/item/ammo_box/generic/medium/m2mm
	name = "(MEDIUM / 2mm Electromagnetic Cartridge) ammo box"
	icon_state = "5mmbox"
	ammo_type = /obj/item/ammo_casing/generic/medium/m2mm

/obj/item/ammo_box/generic/medium/crate
	name = "(MEDIUM / Generic) ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 200

/obj/item/ammo_box/generic/medium/crate/m44
	name = "(MEDIUM / .44) ammo crate"

/obj/item/ammo_box/generic/medium/crate/m14mm
	name = "(MEDIUM / 14mm) ammo crate"

/obj/item/ammo_box/generic/medium/crate/m45lc
	name = "(MEDIUM / .45 Long Colt) ammo crate"

/obj/item/ammo_box/generic/medium/crate/m473
	name = "(MEDIUM / 4.73mm) ammo crate"

/obj/item/ammo_box/generic/medium/crate/m556
	name = "(MEDIUM / 5.56mm) ammo crate"

/obj/item/ammo_box/generic/medium/crate/m5mm
	name = "(MEDIUM / 5mm) ammo crate"

/obj/item/ammo_box/generic/medium/crate/m5mm
	name = "(MEDIUM / 2mm Electromagnetic Cartridge) ammo crate"

/obj/item/projectile/bullet/generic/long
	name = "generic long bullet"
	damage = BULLET_DAMAGE_LONG // 60
	damage_list = list("45" = 35, "60" = 50, "75" = 14, "200" = 1)
	stamina = BULLET_STAMINA_LONG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_LONG

	wound_bonus = BULLET_WOUND_LONG
	bare_wound_bonus = BULLET_WOUND_LONG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_LONG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/generic/long/lexample
	name = "this is an example long projectile! the template goes (type)(caliber). so, for example, this one would be lexample!"

/obj/item/projectile/bullet/generic/long/l308
	name = ".308 bullet"

/obj/item/projectile/bullet/generic/long/l3006
	name = ".30-06 bullet"

/obj/item/projectile/bullet/generic/long/lheavyneedle
	name = "ruby needle"

/obj/item/projectile/bullet/generic/long/l50mg
	name = ".50MG bullet"

/obj/item/projectile/bullet/generic/long/l4570
	name = ".45-70 bullet"

/obj/item/ammo_casing/generic/long
	name = "generic long ammo casing"
	desc = "A generic long ammo casing."
	icon_state = "762-casing"
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/generic/long
	material_class = BULLET_IS_HEAVY_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

/obj/item/ammo_casing/generic/long/template
	name = "template long ammo casing"
	desc = "A template long ammo casing. Follow the Leader"
	projectile_type = /obj/item/projectile/bullet/generic/long/lexample

/obj/item/ammo_casing/generic/long/l308
	name = ".308 bullet casing"
	desc = "A .308 bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/long/l308

/obj/item/ammo_casing/generic/long/l3006
	name = ".30-06 bullet casing"
	desc = "A .30-06 bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/long/l3006

/obj/item/ammo_casing/generic/long/l4570
	name = ".45-70 bullet casing"
	desc = "A .45-70 bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/long/l4570

/obj/item/ammo_casing/generic/long/l50mg
	name = ".50MG bullet casing"
	desc = "A .50MG bullet casing."
	projectile_type = /obj/item/projectile/bullet/generic/long/l50mg

/obj/item/ammo_casing/caseless/needle/heavy
	name = "A ruby needler round."
	desc = "A heavy and long dart for use in needler heavy weaponary."
	icon_state = "heavyneedlecase"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/generic/long/lheavyneedle

/obj/item/ammo_box/generic/long
	name = "(LONG / Generic) ammo box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "box30"
	multiple_sprites = 2
	caliber = list(CALIBER_LONG)
	ammo_type = /obj/item/ammo_casing/generic/long
	max_ammo = 30
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_MEDIUM_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/generic/long/l308
	name = "(LONG / .308) ammo box"
	icon_state = "308box"
	ammo_type = /obj/item/ammo_casing/generic/long/l308

/obj/item/ammo_box/generic/long/l3006
	name = "(LONG / .30-06) ammo box"
	icon_state = "308box"
	ammo_type = /obj/item/ammo_casing/generic/long/l3006

/obj/item/ammo_box/generic/long/l4570
	name = "(LONG / .45-70) ammo box"
	icon_state = "308box"
	ammo_type = /obj/item/ammo_casing/generic/long/l4570

/obj/item/ammo_box/generic/long/l50mg
	name = "(LONG / .50MG) ammo box"
	icon_state = "308box"
	ammo_type = /obj/item/ammo_casing/generic/long/l50mg

/obj/item/ammo_box/generic/long/lheavyneedle
	name = "(LONG / Ruby Needle) ammo box"
	icon_state = "308box"
	ammo_type = /obj/item/ammo_casing/caseless/needle/heavy

/obj/item/ammo_box/generic/long/crate
	name = "(LONG / Generic) ammo crate"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 150

/obj/item/ammo_box/generic/long/crate/l308
	name = "(LONG / .308) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/long/l308

/obj/item/ammo_box/generic/long/crate/l3006
	name = "(LONG / .30-06) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/long/l3006

/obj/item/ammo_box/generic/long/crate/l4570
	name = "(LONG / .45-70) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/long/l4570

/obj/item/ammo_box/generic/long/crate/l50mg
	name = "(LONG / .50MG) ammo crate"
	ammo_type = /obj/item/ammo_casing/generic/long/l50mg

/obj/item/ammo_box/generic/long/crate/lheavyneedle
	name = "(LONG / Ruby Needle) ammo crate"
	ammo_type = /obj/item/ammo_casing/caseless/needle/heavy

/obj/item/projectile/bullet/shotgun/sbuck
	name = "generic buckshot pellet"
	damage = BULLET_DAMAGE_SHOTGUN_PELLET
	damage_list = list("8" = 50, "10" = 25, "12" = 25)
	stamina = BULLET_STAMINA_SHOTGUN_PELLET
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/obj/item/projectile/bullet/shotgun/buck/s12ga
	name = "12 gauge buckshot pellet"

/obj/item/ammo_casing/generic/shotgun/buck
	name = "buckshot shell"
	desc = "A generic buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/shotgun/buck
	pellets = SHOTGUN_PELLET_BASE
	variance = SHOTGUN_SPREAD_BASE
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/generic/shotgun/buck/s12ga
	name = "12 gauge buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/shotgun/buck/s12ga

/obj/item/ammo_casing/generic/shotgun
	name = "generic shotgun slug"
	desc = "A generic shotgun slug."
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "bbshell"
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun_slug
	material_class = BULLET_IS_SHOTGUN
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_SHOTGUN

/obj/item/projectile/bullet/shotgun/s12ga
	name = "12 gauge slug"

/obj/item/projectile/bullet/shotgun/explosive
	name = "generic explosive slug"
	damage = BULLET_DAMAGE_SHOTGUN_SLUG * BULLET_DAMAGE_EXPLOSIVE
	stamina = BULLET_STAMINA_SHOTGUN_SLUG * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_SLUG

	wound_bonus = BULLET_WOUND_SHOTGUN_SLUG * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT * BULLET_NAKED_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SEMI_AUTO

	knockdown = 50

/obj/item/projectile/bullet/shotgun/sexplosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/shotgun/explosive/s12ga
	name = "12 gauge explosive slug"

/obj/item/ammo_casing/generic/shotgun/sexplosive
	name = "explosive shotgun round template"
	desc = "A high explosive template."
	icon_state = "heshell"
	projectile_type = /obj/item/projectile/bullet/shotgun/sexplosive
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_box/generic/shotgun
	name = "(SHOTGUN / Generic Buckshot) ammo box"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	max_ammo = 24
	custom_materials = list(/datum/material/iron = MATS_SHOTGUN_BOX)
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	multiple_sprites = 2
	caliber = list(CALIBER_SHOTGUN)
	w_class = WEIGHT_CLASS_SMALL
	randomize_ammo_count = FALSE

/obj/item/ammo_box/generic/shotgun/slug
	name = "(SHOTGUN / Generic Slug) ammo box"
	desc = "A box full of shotgun shells."
	ammo_type = /obj/item/ammo_casing/generic/shotgun
	icon_state = "lbox"

/obj/item/ammo_box/generic/shotgun/slug/crate
	name = "(SHOTGUN / Generic Slug) ammo crate"
	desc = "A wooden crate full of shotgun shells."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 120

/obj/item/ammo_box/generic/shotgun/buck
	name = "(SHOTGUN / Generic Buckshot) ammo box"
	desc = "A box full of shotgun shells."
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	icon_state = "12gbox"

/obj/item/ammo_box/generic/shotgun/buck/s12ga
	name = "(SHOTGUN / 12 Gauge Buckshot) ammo box"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buck/s12ga

/obj/item/ammo_box/generic/shotgun/buck/crate
	name = "(SHOTGUN / Generic Buckshot) ammo crate"
	desc = "A wooden crate full of shotgun shells."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 120

/obj/item/ammo_box/generic/shotgun/buck/s12ga/crate
	name = "(SHOTGUN / 12 Gauge Buckshot) ammo crate"
	desc = "A wooden crate full of shotgun shells."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = 4
	max_ammo = 120

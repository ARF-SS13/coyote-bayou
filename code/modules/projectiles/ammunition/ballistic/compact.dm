// 10mm
/obj/item/ammo_casing/c10mm
	name = "10mm FMJ bullet casing"
	desc = "A 10mm FMJ bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/c10mm
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_10MM

/obj/item/ammo_casing/c10mm/improvised
	name = "shoddy 10mm bullet casing"
	desc = "A homemade 10mm FMJ bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/c10mm/improvised
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c10mm/rubber
	name = "A 10mm rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/c10mm/rubber
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c10mm/incendiary
	name = "A 10mm incendiary bullet casing."
	projectile_type = /obj/item/projectile/bullet/c10mm/incendiary
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

// 9mm
/obj/item/ammo_casing/c9mm
	name = "9mm FMJ bullet casing"
	desc = "A 9mm FMJ bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/c9mm
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_9MM

/obj/item/ammo_casing/c9mm/improvised
	name = "homemade 9mm bullet casing"
	desc = "A homemade 9mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/c9mm/improvised
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c9mm/rubber
	name = "9mm rubber bullet casing"
	desc = "A 9mm rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/c9mm/rubber
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c9mm/incendiary
	name = "9mm incendiary bullet casing"
	desc = "A 9mm incendiary bullet casing."
	projectile_type = /obj/item/projectile/bullet/c9mm/incendiary
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

// .357
/obj/item/ammo_casing/a357
	name = ".357 FMJ bullet casing"
	desc = "A .357 FMJ bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/a357
	material_class = BULLET_IS_MEDIUM_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_357

/obj/item/ammo_casing/a357/ratshot
	name = ".357 ratshot shell casing"
	desc = "A .357 ratshot shell casing."
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_ratshot
	pellets = 6 //6 pellets for 6 damage is 36 total, same as base cartridge, but less effective against armor, more effective against rats
	variance = SHOTGUN_SPREAD_BASE

/obj/item/ammo_casing/a357/ricochet
	name = ".357 ricochet bullet casing"
	desc = "A .357 ricochet bullet casing."
	projectile_type = /obj/item/projectile/bullet/a357/ricochet
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a357/incendiary
	name = ".357 incendiary bullet casing"
	desc = "A .357 incendiary bullet casing."
	projectile_type = /obj/item/projectile/bullet/a357/incendiary
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a357/improvised
	name = "shoddy .357 bullet casing"
	desc = "A handmade .357 magnum bullet casing."
	projectile_type = /obj/item/projectile/bullet/a357/improvised
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

// 22lr
/obj/item/ammo_casing/a22
	name = ".22lr bullet casing"
	desc = "A .22lr bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/c22
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_PISTOL_22

/obj/item/ammo_casing/a22/rubber
	name = ".22lr rubber bullet casing"
	desc = "A .22lr rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/c22/rubber
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a22/shock
	name = ".22lr shock bullet casing"
	desc = "A .22lr shock bullet casing."
	projectile_type = /obj/item/projectile/bullet/c22/shock
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/bee
	name = ".22lr beellet casing"
	desc = "A hybernating bee inside a capsule."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/bee
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_PISTOL_22

/obj/item/ammo_casing/mouse
	name = ".22lr mouseshot casing"
	desc = "A tiny mouse nestled inside a capsule."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/mouse
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_PISTOL_22

/obj/item/ammo_casing/a22/ratshot
	name = ".22lr ratshot casing"
	desc = "A .22lr ratshot casing."
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_ratshot // My headcanon is its lead BBs
	pellets = 4 // 4 for now, maybe 3 if its overboard
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

// .45 

/obj/item/ammo_casing/c45
	name = ".45 FMJ bullet casing"
	desc = "A .45 FMJ bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/c45
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_45

/obj/item/ammo_casing/c45/improvised
	name = "shoddy .45 bullet casing"
	desc = "A handmade .45 bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/c45
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c45/incendiary
	name = ".45 incendiary bullet casing"
	desc = "A .45 incendiary bullet casing."
	projectile_type = /obj/item/projectile/bullet/c45/incendiary
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c45/rubber
	name = ".45 rubber bullet casing"
	desc = "A .45 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/c45/rubber
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

// needler pistol
/obj/item/ammo_casing/caseless/needle
	name = "A needler round."
	desc = "A dart for use in needler pistols."
	icon_state = "needlecasing"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = CALIBER_COMPACT
	force = 2
	throwforce = 1
	embedding = list("embed_chance"= 25)
	projectile_type = /obj/item/projectile/bullet/needle

/obj/item/ammo_casing/caseless/needle/improvised
	name = "A jade needler round."
	desc = "A dart for use in needler pistols."
	icon_state = "needleimprovcase"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = CALIBER_COMPACT
	force = 2
	throwforce = 1
	projectile_type = /obj/item/projectile/bullet/needle/improvised

//throwin' rock, for throwin'. obtained via *rocks
/obj/item/ammo_casing/caseless/rock
	name = "rock"
	desc = "a nice hefty rock, for bashing over someone's head or throwing at someone's head. You can get your own with *rocks!"
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	item_state = "rock"
	force = 15
	throwforce = 20
	throw_speed = 1 // you can see it comin'
	throw_range = 10 //you can chuck a rock pretty far. good luck hitting anything though
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_SMALL_ITEM
	attack_verb = list("attacked", "bashed", "brained", "thunked", "clobbered")
	attack_speed = CLICK_CD_MELEE
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/rock
	is_pickable = TRUE
	custom_materials = list(/datum/material/glass = 50) //rocks are made of silicon, same as sand
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_ROCK



// BETA AMMO // Obsolete
/obj/item/ammo_casing/testcasing
	name = "casing"
	desc = "casing."
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/test

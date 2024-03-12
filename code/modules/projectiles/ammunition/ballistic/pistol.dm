// 10mm
/obj/item/ammo_casing/c10mm
	name = "10mm FMJ bullet casing"
	desc = "A 10mm FMJ bullet casing."
	caliber = CALIBER_10MM
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
	caliber = CALIBER_10MM
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
	caliber = CALIBER_9MM
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

//14mm
/obj/item/ammo_casing/p14mm
	name = "14mm FMJ bullet casing"
	desc = "A 14mm FMJ bullet casing."
	caliber = CALIBER_14MM
	projectile_type = /obj/item/projectile/bullet/mm14
	material_class = BULLET_IS_HEAVY_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVIER_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_14MM

/obj/item/ammo_casing/p14mm/improvised
	name = "shoddy 14mm bullet casing"
	desc = "A handloaded 14mm bullet casing."
	caliber = CALIBER_14MM
	projectile_type = /obj/item/projectile/bullet/mm14
	material_class = BULLET_IS_HEAVY_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVIER_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/p14mm/contam
	name = "14mm contaminated bullet casing"
	desc = "A 14mm contaminated bullet casing."
	projectile_type = /obj/item/projectile/bullet/mm14/contam
	fire_power = CASING_POWER_HEAVIER_PISTOL * CASING_POWER_MOD_SURPLUS

/*
/obj/item/ammo_casing/p14mm/uraniumtipped
	name = "14mm uranium-tipped bullet casing"
	desc = "A 14mm uranium-tipped bullet casing."
	caliber = "14"
	projectile_type = /obj/item/projectile/bullet/mm14/uraniumtipped
*/

// 22lr
/obj/item/ammo_casing/a22
	name = ".22lr bullet casing"
	desc = "A .22lr bullet casing."
	caliber = CALIBER_22LR
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
	caliber = CALIBER_BEE
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
	caliber = CALIBER_MOUSE
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

// BETA AMMO // Obsolete
/obj/item/ammo_casing/testcasing
	name = "casing"
	desc = "casing."
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/test

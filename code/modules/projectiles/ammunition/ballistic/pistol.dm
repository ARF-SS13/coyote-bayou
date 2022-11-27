// 10mm
/obj/item/ammo_casing/c10mm
	name = "10mm FMJ bullet casing"
	desc = "A 10mm FMJ bullet casing."
	caliber = CALIBER_10MM
	projectile_type = /obj/item/projectile/bullet/c10mm
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/c10mm/improvised
	name = "shoddy 10mm bullet casing"
	desc = "A homemade 10mm FMJ bullet casing."
	caliber = CALIBER_10MM
	projectile_type = /obj/item/projectile/bullet/c10mm/improvised
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c10mm/rubber
	name = "A 10mm rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/c10mm/rubber
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
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
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/c9mm/improvised
	name = "homemade 9mm bullet casing"
	desc = "A homemade 9mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/c9mm/improvised
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c9mm/rubber
	name = "9mm rubber bullet casing"
	desc = "A 9mm rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/c9mm/rubber
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
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
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVIER_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/p14mm/improvised
	name = "shoddy 14mm bullet casing"
	desc = "A handloaded 14mm bullet casing."
	caliber = CALIBER_14MM
	projectile_type = /obj/item/projectile/bullet/mm14
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
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
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a22/rubber
	name = ".22lr rubber bullet casing"
	desc = "A .22lr rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/c22/rubber
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a22/shock
	name = ".22lr shock bullet casing"
	desc = "A .22lr shock bullet casing."
	projectile_type = /obj/item/projectile/bullet/c22/shock
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

// BETA AMMO // Obsolete
/obj/item/ammo_casing/testcasing
	name = "casing"
	desc = "casing."
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/test

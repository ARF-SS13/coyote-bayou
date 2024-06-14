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

/*
// .38 special
/obj/item/ammo_casing/c38
	name = ".38 special bullet casing"
	desc = "A .38 special bullet casing."
	caliber = CALIBER_38
	projectile_type = /obj/item/projectile/bullet/c38
	material_class = BULLET_IS_MEDIUM_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c38/improvised
	name = "shoddy .38 special bullet casing"
	desc = "A homemade .38 bullet casing."
	projectile_type = /obj/item/projectile/bullet/c38/improvised
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c38/rubber
	name = ".38 special rubber bullet casing"
	desc = "A .38 special rubber bullet casing. Some might call these useless, up until they're hit by em."
	projectile_type = /obj/item/projectile/bullet/c38/rubber
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c38/incendiary
	name = ".38 special incendiary bullet casing"
	desc = "A .38 special incendiary bullet casing. For when you want to be slightly less useless."
	projectile_type = /obj/item/projectile/bullet/c38/incendiary
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
*/
// .44 magnum
/obj/item/ammo_casing/m44
	name = ".44 magnum FMJ bullet casing"
	desc = "A .44 magnum full metal jacket bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/m44
	material_class = BULLET_IS_HEAVY_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_44

/obj/item/ammo_casing/m44/improvised
	name = "shoddy .44 magnum bullet casing"
	desc = "A homemade .44 magnum bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/m44/improvised
	material_class = BULLET_IS_HEAVY_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/m44/incendiary
	name = ".44 magnum incendiary bullet casing"
	desc = "A .44 magnum incendiary bullet casing."
	projectile_type = /obj/item/projectile/bullet/c45/incendiary
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_HANDLOAD

// .45-70 Gov't
/obj/item/ammo_casing/c4570
	name = ".45-70 FMJ bullet casing"
	desc = "A .45-70 full metal jacket bullet casing."
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/c4570
	material_class = BULLET_IS_HEAVY_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

/obj/item/ammo_casing/c4570/ratshot
	name = ".45-70 forager shell casing"
	desc = "A .45-70 forager shell casing."
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_ratshot
	pellets = 10 //10 pellets for 6 damage is 60 total, same as base cartridge, but less effective against armor, more effective against rats
	variance = SHOTGUN_SPREAD_BASE

/obj/item/ammo_casing/c4570/improvised
	name = "shoddy .45-70 bullet casing"
	desc = "A homemade .45-70 bullet casing."
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/c4570/improvised
	material_class = BULLET_IS_HEAVY_RIFLE
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD
/*
/obj/item/ammo_casing/c4570/surplus
	name = ".45-70 bullet casing"
	desc = "A .45-70 bullet casing."
	caliber = CALIBER_4570
	projectile_type = /obj/item/projectile/bullet/c4570/surplus
	material_class = BULLET_IS_HEAVY_RIFLE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD
*/
/obj/item/ammo_casing/c4570/explosive
	name = ".45-70 explosive bullet casing"
	desc = "A .45-70 explosive bullet casing."
	projectile_type = /obj/item/projectile/bullet/c4570/explosive
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/c4570/knockback
	name = ".45-70 ultradense bullet casing"
	desc = "A .45-70 ultradense bullet casing."
	projectile_type = /obj/item/projectile/bullet/c4570/knockback
	material_class = BULLET_IS_HEAVY_RIFLE
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

//.45 Long Colt bouncing
/obj/item/ammo_casing/a45lc
	name = ".45 Long Colt bullet casing"
	desc = "An archaic .45 long colt bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/a45lc
	material_class = BULLET_IS_MEDIUM_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_MATCH
	sound_properties = CSP_PISTOL_357

/obj/item/ammo_casing/a45lc/improvised
	name = "shoddy .45 LC bullet casing"
	desc = "An archaic .45 long colt bullet casing. Now about 25% worse."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/a45lc/improvised
	material_class = BULLET_IS_MEDIUM_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS


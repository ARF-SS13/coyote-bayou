// .357
/obj/item/ammo_casing/a357
	name = ".357 FMJ bullet casing"
	desc = "A .357 FMJ bullet casing."
	caliber = CALIBER_357
	projectile_type = /obj/item/projectile/bullet/a357
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a357/ricochet
	name = ".357 ricochet bullet casing"
	desc = "A .357 ricochet bullet casing."
	projectile_type = /obj/item/projectile/bullet/a357/ricochet
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a357/incendiary
	name = ".357 incendiary bullet casing"
	desc = "A .357 incendiary bullet casing."
	projectile_type = /obj/item/projectile/bullet/a357/incendiary
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a357/improvised
	name = "shoddy .357 bullet casing"
	desc = "A handmade .357 magnum bullet casing."
	projectile_type = /obj/item/projectile/bullet/a357/improvised
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_HANDLOAD


// .38 special
/obj/item/ammo_casing/c38
	name = ".38 special bullet casing"
	desc = "A .38 special bullet casing."
	caliber = CALIBER_38
	projectile_type = /obj/item/projectile/bullet/c38
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c38/improvised
	name = "shoddy .38 special bullet casing"
	desc = "A homemade .38 bullet casing."
	projectile_type = /obj/item/projectile/bullet/c38/improvised
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c38/rubber
	name = ".38 special rubber bullet casing"
	desc = "A .38 specia rubber bullet casing. For when you want to be extra useless."
	projectile_type = /obj/item/projectile/bullet/c38/rubber
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c38/incendiary
	name = ".38 special incendiary bullet casing"
	desc = "A .38 special incendiary bullet casing. For when you want to be slightly less useless."
	projectile_type = /obj/item/projectile/bullet/c38/incendiary
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD

// .44 magnum
/obj/item/ammo_casing/m44
	name = ".44 magnum FMJ bullet casing"
	desc = "A .44 magnum full metal jacket bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/item/projectile/bullet/m44
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/m44/improvised
	name = "shoddy .44 magnum bullet casing"
	desc = "A homemade .44 magnum bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/item/projectile/bullet/m44/improvised
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
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
	caliber = CALIBER_4570
	projectile_type = /obj/item/projectile/bullet/c4570
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/c4570/improvised
	name = "shoddy .45-70 bullet casing"
	desc = "A homemade .45-70 bullet casing."
	caliber = CALIBER_4570
	projectile_type = /obj/item/projectile/bullet/c4570/improvised
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/c4570/explosive
	name = ".45-70 explosive bullet casing"
	desc = "A .45-70 explosive bullet casing."
	projectile_type = /obj/item/projectile/bullet/c4570/explosive
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/c4570/knockback
	name = ".45-70 ultradense bullet casing"
	desc = "A .45-70 ultradense bullet casing."
	projectile_type = /obj/item/projectile/bullet/c4570/knockback
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

//.45 Long Colt bouncing
/obj/item/ammo_casing/a45lc
	name = ".45 Long Colt bullet casing"
	desc = "An archaic .45 long colt bullet casing."
	caliber = CALIBER_45LC
	projectile_type = /obj/item/projectile/bullet/a45lc
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a45lc/improvised
	name = "shoddy .45 LC bullet casing"
	desc = "An archaic .45 long colt bullet casing. Now about 25% worse."
	caliber = CALIBER_45LC
	projectile_type = /obj/item/projectile/bullet/a45lc/improvised
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_PISTOL * CASING_POWER_MOD_SURPLUS


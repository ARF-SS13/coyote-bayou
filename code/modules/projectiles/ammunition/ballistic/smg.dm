// .45 

/obj/item/ammo_casing/c45
	name = ".45 FMJ bullet casing"
	desc = "A .45 FMJ bullet casing."
	caliber = CALIBER_45ACP
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
	caliber = CALIBER_45ACP
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


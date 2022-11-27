// 7.62
/obj/item/ammo_casing/a762
	name = "7.62 FMJ bullet casing"
	desc = "A 7.62 FMJ bullet casing."
	icon_state = "762-casing"
	caliber = CALIBER_762
	projectile_type = /obj/item/projectile/bullet/a762
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER * MATS_AMMO_POWDER_MATCH_MULT)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a762/improvised
	name = "shoddy .308 bullet casing"
	desc = "A handmade .308 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a762/improvised
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a762/sport
	name = ".308 bullet casing"
	desc = "A .308 sporting bullet casing."
	projectile_type = /obj/item/projectile/bullet/a762/sport
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a762/microshrapnel
	name = "7.62mm microshrapnel bullet casing"
	desc = "Like shrapnel, but smaller, and thus more annoying."
	projectile_type = /obj/item/projectile/bullet/a762/microshrapnel
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_MATCH

/*
/obj/item/ammo_casing/a762/uraniumtipped
	name = "7.62 uranium tipped bullet casing"
	desc = "Not depleted uranium. Regular uranium."
	projectile_type = /obj/item/projectile/bullet/a762/uraniumtipped
*/

/obj/item/ammo_casing/a762/rubber
	name = "7.62 rubber bullet casing"
	desc = "A 7.62 rubber bullet casing, for training purposes."
	projectile_type = /obj/item/projectile/bullet/a762/rubber
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_HANDLOAD

// 5.56mm
/obj/item/ammo_casing/a556
	name = "5.56mm FMJ bullet casing"
	desc = "A 5.56mm bullet casing."
	caliber = CALIBER_556
	projectile_type = /obj/item/projectile/bullet/a556
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_SMALL_CASING + MATS_RIFLE_SMALL_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_SMALL_POWDER * MATS_AMMO_POWDER_MATCH_MULT)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a556/rubber
	name = "5.56mm rubber bullet casing"
	desc = "A 5.56mm rubber bullet casing, for training purposes."
	projectile_type = /obj/item/projectile/bullet/a556/rubber
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_SMALL_CASING + MATS_RIFLE_SMALL_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a556/microshrapnel
	name = "5.56mm microshrapnel bullet casing"
	desc = "Like shrapnel, but smaller, and thus more annoying."
	projectile_type = /obj/item/projectile/bullet/a556/microshrapnel
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH

/*
/obj/item/ammo_casing/a556/uranium_tipped
	name = "5.56 uranium-tipped bullet casing"
	desc = "Tax money well spent."
	projectile_type = /obj/item/projectile/bullet/a556/uraniumtipped
*/

/obj/item/ammo_casing/a556/sport //.223
	name = ".223 bullet casing"
	desc = "A .223 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a556/sport
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_SMALL_CASING + MATS_RIFLE_SMALL_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_SMALL_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a556/improvised
	name = "shoddy .223 bullet casing"
	desc = "A handmade .223 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a556/improvised
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_SMALL_CASING + MATS_RIFLE_SMALL_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

//5mm

/obj/item/ammo_casing/m5mm
	name = "5mm FMJ bullet casing"
	desc = "A 5mm bullet casing."
	caliber = CALIBER_5MM
	projectile_type = /obj/item/projectile/bullet/m5mm
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_SMALL_CASING + MATS_RIFLE_SMALL_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_SMALL_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/m5mm/improvised
	name = "shoddy 5mm bullet casing"
	desc = "A handmade 5mm bullet casing."
	caliber = CALIBER_5MM
	projectile_type = /obj/item/projectile/bullet/m5mm/improvised
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_SMALL_CASING + MATS_RIFLE_SMALL_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_SMALL_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/m5mm/shock
	name = "5mm shock bullet casing"
	desc = "A 5mm shock bullet casing."
	projectile_type = /obj/item/projectile/bullet/m5mm/shock
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

// 40mm (Grenade Launcher)
/obj/item/ammo_casing/a40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_40MM
	icon_state = "40mmHE"
	projectile_type = /obj/item/projectile/bullet/a40mm
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_GRENADE_BULLET,
		/datum/material/blackpowder = MATS_GRENADE_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_SURPLUS

// 2mm EC
/obj/item/ammo_casing/c2mm
	name = "2mm gauss projectile casing"
	desc = "A 2mm gauss projectile casing."
	caliber = CALIBER_2MM
	projectile_type = /obj/item/projectile/bullet/c2mm
	custom_materials = list(
		/datum/material/iron = MATS_GAUSS_CASING + MATS_GAUSS_BULLET,
		/datum/material/blackpowder = MATS_GAUSS_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/c2mm/blender
	name = "2mm gauss blender projectile casing"
	desc = "A 2mm gauss projectile casing, \"Blender\" variant. Bounces off walls at hypersonic speeds."
	projectile_type = /obj/item/projectile/bullet/c2mm/blender
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

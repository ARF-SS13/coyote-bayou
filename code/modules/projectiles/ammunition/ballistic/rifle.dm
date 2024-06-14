// 7.62
/obj/item/ammo_casing/a308
	name = ".308 FMJ bullet casing"
	desc = "A .308 FMJ bullet casing."
	icon_state = "762-casing"
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/a308
	material_class = BULLET_IS_MEDIUM_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

/obj/item/ammo_casing/a308/improvised
	name = "shoddy .308 bullet casing"
	desc = "A handmade .308 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a308/improvised
	material_class = BULLET_IS_MEDIUM_RIFLE
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_HANDLOAD
/*
/obj/item/ammo_casing/a762/sport
	name = ".308 bullet casing"
	desc = "A .308 sporting bullet casing."
	projectile_type = /obj/item/projectile/bullet/a308/improvised
	material_class = BULLET_IS_MEDIUM_RIFLE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_MEDIUM_CASING + MATS_RIFLE_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS
*/
/obj/item/ammo_casing/a308/microshrapnel
	name = ".308 microshrapnel bullet casing"
	desc = "Like shrapnel, but smaller, and thus more annoying."
	projectile_type = /obj/item/projectile/bullet/a308/microshrapnel
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_MATCH

/*
/obj/item/ammo_casing/a762/uraniumtipped
	name = "7.62 uranium tipped bullet casing"
	desc = "Not depleted uranium. Regular uranium."
	projectile_type = /obj/item/projectile/bullet/a762/uraniumtipped
*/

/obj/item/ammo_casing/a308/rubber
	name = ".308 rubber bullet casing"
	desc = "A .308 rubber bullet casing, for training purposes."
	projectile_type = /obj/item/projectile/bullet/a308/rubber
	material_class = BULLET_IS_MEDIUM_RIFLE
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_MEDIUM_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_MEDIUM_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_MEDIUM_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_HANDLOAD

// .30-06
/obj/item/ammo_casing/a3006
	name = ".30-06 FMJ bullet casing"
	desc = "A .30-06 FMJ bullet casing."
	icon_state = "762-casing"
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/a3006
	material_class = BULLET_IS_HEAVY_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_MEDIUM

/obj/item/ammo_casing/a3006/rubber
	name = ".30-06 FMJ bullet casing"
	desc = "A .30-06 FMJ bullet casing."
	icon_state = "762-casing"
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/a3006/rubber
	material_class = BULLET_IS_HEAVY_RIFLE
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_RIFLE_MEDIUM


/obj/item/ammo_casing/a3006/improvised
	name = "shoddy .30-06 bullet casing"
	desc = "A handmade .30-06 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a3006/improvised
	material_class = BULLET_IS_HEAVY_RIFLE
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD

// 5.56mm
/obj/item/ammo_casing/a556
	name = "5.56mm FMJ bullet casing"
	desc = "A 5.56mm bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/a556
	material_class = BULLET_IS_LIGHT_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_casing/a556/rubber
	name = "5.56mm rubber bullet casing"
	desc = "A 5.56mm rubber bullet casing, for training purposes."
	projectile_type = /obj/item/projectile/bullet/a556/rubber
	material_class = BULLET_IS_LIGHT_RIFLE
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
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
/*
/obj/item/ammo_casing/a556/sport //.223
	name = ".223 bullet casing"
	desc = "A .223 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a556/sport
	material_class = BULLET_IS_LIGHT_RIFLE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
*/
/obj/item/ammo_casing/a556/improvised
	name = "shoddy 5.56 bullet casing"
	desc = "A handmade 6.56 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a556/improvised
	material_class = BULLET_IS_LIGHT_RIFLE
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

//5mm (no match)

/obj/item/ammo_casing/m5mm
	name = "5mm FMJ bullet casing"
	desc = "A 5mm bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/m5mm
	material_class = BULLET_IS_LIGHT_RIFLE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_casing/m5mm/improvised
	name = "shoddy 5mm bullet casing"
	desc = "A handmade 5mm bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/m5mm/improvised
	material_class = BULLET_IS_LIGHT_RIFLE
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
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
	caliber = CALIBER_SHOTGUN
	icon_state = "40mmHE"
	projectile_type = /obj/item/projectile/bullet/a40mm/he
	material_class = BULLET_IS_GRENADE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_GRENADE_BULLET,
		/datum/material/blackpowder = MATS_GRENADE_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_MATCH
	sound_properties = CSP_40MM

/obj/item/ammo_casing/a40mm/hedp
	name = "40mm HEDP shell"
	desc = "A cased dual purpose grenade that can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_SHOTGUN
	icon_state = "40mmHEDP"
	projectile_type = /obj/item/projectile/bullet/a40mm/hedp

/obj/item/ammo_casing/a40mm/buck
	name = "40mm buckshot shell"
	desc = "A large caliber buckshot round, designed to be fired out of a grenade launcher."
	caliber = CALIBER_SHOTGUN
	icon_state = "40mmbuck"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_buckshot
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	pellets = 12 //96 damage. can't complain
	variance = SHOTGUN_SPREAD_BASE

// 2mm EC
/obj/item/ammo_casing/c2mm
	name = "2mm gauss projectile casing"
	desc = "A 2mm gauss projectile casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/c2mm
	material_class = BULLET_IS_GAUSS
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_GAUSS_CASING + MATS_GAUSS_BULLET,
		/datum/material/blackpowder = MATS_GAUSS_POWDER,
		/datum/material/titanium = MATS_GAUSS_BULLET)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH
	sound_properties = CSP_GAUSS

/obj/item/ammo_casing/c2mm/blender
	name = "2mm gauss blender projectile casing"
	desc = "A 2mm gauss projectile casing, \"Blender\" variant. Bounces off walls at hypersonic speeds."
	projectile_type = /obj/item/projectile/bullet/c2mm/blender
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH
	custom_materials = list(
		/datum/material/iron = MATS_GAUSS_CASING + MATS_GAUSS_BULLET * 1.1,
		/datum/material/blackpowder = MATS_GAUSS_POWDER,
		/datum/material/titanium = MATS_GAUSS_BULLET * 1.1)

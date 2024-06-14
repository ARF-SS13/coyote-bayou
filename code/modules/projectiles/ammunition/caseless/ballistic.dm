/obj/item/ammo_casing/caseless/g11
	name = "4.73mm caseless cartridge"
	desc = "An 4.73 self-contained caseless rifle cartridge."
	caliber = CALIBER_MEDIUM
	icon_state = "762-casing"
	projectile_type = /obj/item/projectile/bullet/a473
	material_class = BULLET_IS_LIGHT_RIFLE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_casing/caseless/g11/rubber
	name = "4.73mm polyurethane cartridge"
	projectile_type  = /obj/item/projectile/bullet/a473/rubber
	material_class = BULLET_IS_LIGHT_RIFLE
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_LIGHT_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_LIGHT_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/caseless/g11/incendiary
	name = "4.73mm tracer cartridge"
	projectile_type  = /obj/item/projectile/bullet/a473/incendiary
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

/*
/obj/item/ammo_casing/caseless/g11/uraniumtipped
	name = "4.73mm U-235 cartridge"
	projectile_type  = /obj/item/projectile/bullet/a473/uraniumtipped
*/

/obj/item/ammo_casing/caseless/g11/dumdum
	name = "4.73mm flat-nose cartridge"
	projectile_type  = /obj/item/projectile/bullet/a473/dumdum
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/caseless/g11/explosive
	name = "4.73mm explosive caseless cartridge"
	desc = "An explosive 4.73 self-contained caseless rifle cartridge."
	projectile_type = /obj/item/projectile/bullet/a473/explosive
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/caseless/g11/shock
	name = "4.73mm electro-static discharge cartridge"
	projectile_type  = /obj/item/projectile/bullet/a473/shock
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/caseless/g11/hv
	name = "4.73mm highvelocity cartridge"
	projectile_type  = /obj/item/projectile/bullet/a473/hv
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH

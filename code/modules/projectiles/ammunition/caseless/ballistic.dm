/obj/item/ammo_casing/caseless/g11
	name = "4.73mm caseless cartridge"
	desc = "An 4.73 self-contained caseless rifle cartridge."
	caliber = CALIBER_CASELESS
	icon_state = "762-casing"
	projectile_type = /obj/item/projectile/bullet/a473
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/caseless/g11/rubber
	name = "4.73mm polyurethane cartridge"
	projectile_type  = /obj/item/projectile/bullet/a473/rubber
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

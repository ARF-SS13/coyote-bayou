//.50 BMG

/obj/item/ammo_casing/a50MG
	name = ".50MG bullet casing"
	desc = "A .50MG bullet casing."
	caliber = CALIBER_LONG
	icon_state = "50mg2"
	projectile_type = /obj/item/projectile/bullet/a50MG
	material_class = BULLET_IS_HEAVY_RIFLE
	casing_quality = BULLET_IS_MATCH
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_HEAVY_CASING * MATS_AMMO_CASING_MATCH_MULT) + (MATS_RIFLE_HEAVY_BULLET * MATS_AMMO_BULLET_MATCH_MULT),
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER * MATS_AMMO_POWDER_MATCH_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH
	sound_properties = CSP_RIFLE_HEAVY

/obj/item/ammo_casing/a50MG/improvised
	name = "shoddy .50MG bullet casing"
	desc = "A handmade .50MG bullet casing."
	caliber = CALIBER_LONG
	icon_state = "50mg2"
	projectile_type = /obj/item/projectile/bullet/a50MG/improvised
	material_class = BULLET_IS_HEAVY_RIFLE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a50MG/incendiary
	name = ".50 MG incendiary bullet casing"
	desc = "A .50 MG incendiary bullet casing."
	icon_state = "50in2"
	projectile_type = /obj/item/projectile/bullet/a50MG/incendiary
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a50MG/explosive
	name = ".50 MG explosive bullet casing"
	desc = "Comes in 5 bullet racks...more then enough to kill anything that moves.."
	icon_state = "50ex2"
	projectile_type = /obj/item/projectile/bullet/a50MG/explosive
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a50MG/rubber
	name = ".50 MG rubber bullet casing"
	desc = "Who makes .50 in rubber? This is going to kill someone."
	projectile_type = /obj/item/projectile/bullet/a50MG/rubber
	material_class = BULLET_IS_HEAVY_RIFLE
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_RIFLE_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_RIFLE_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/a50MG/penetrator
	name = ".50 MG penetrator bullet casing"
	desc = "This titanium-reinforced highpower bullet will penetrate anything. Yes. Anything."
	projectile_type = /obj/item/projectile/bullet/a50MG/penetrator
	icon_state = "50ap2"
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a50MG/contam
	name = "12.7mm contaminated bullet casing"
	desc = "A 12.7mm explosive round where the explosive has been replaced with a chemical smoke payload."
	icon_state = "50ex2"
	projectile_type = /obj/item/projectile/bullet/a50MG/contam
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

/*
/obj/item/ammo_casing/a50MG/uraniumtipped
	name = "12.7mm uranium-tipped bullet casing"
	desc = "Enriched uranium-tipped 12.7mm rifle rounds."
	projectile_type = /obj/item/projectile/bullet/a50MG/uraniumtipped
	icon_state = "50ap2"
*/

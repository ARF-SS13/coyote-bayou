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

// heavy needler
/obj/item/ammo_casing/caseless/needle/heavy
	name = "A ruby needler round."
	desc = "A heavy and long dart for use in needler heavy weaponary."
	icon_state = "heavyneedlecase"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = CALIBER_LONG
	projectile_type = /obj/item/projectile/bullet/heavyneedle

// plasma
/obj/item/ammo_casing/caseless/plasmacaster
	name = "Plasma can"
	desc = "A single use can of plasma for the plasma musket."
	caliber = CALIBER_LONG
	icon_state = "plasmacan"
	projectile_type = /obj/item/projectile/f13plasma/plasmacaster
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy

// flintlock minie
/obj/item/ammo_casing/caseless/flintlock/minie
	name = "packed blackpowder minie cartridge"
	desc = "A conical bullet designed to give flintlocks a bit more of a modern edge."
	caliber = CALIBER_LONG
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "flintlock_casing_minie"
	projectile_type = /obj/item/projectile/flintlock/minie
	sound_properties = CSP_FLINTLOCK
	custom_materials = list(
		/datum/material/iron = MATS_FLINTLOCK_LIGHT_POWDER, // what casing? ~ uwu ~
		/datum/material/blackpowder = MATS_FLINTLOCK_HEAVY_POWDER)
	w_class = WEIGHT_CLASS_SMALL
	variance = CASING_SPREAD_SURPLUS

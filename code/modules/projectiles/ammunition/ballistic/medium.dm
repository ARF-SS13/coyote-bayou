// 1.95x129mm (SAW)

/obj/item/ammo_casing/mm195x129
	name = "1.95x129mm bullet casing"
	desc = "A 1.95x129mm bullet casing."
	icon_state = "762-casing"
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/mm195x129
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_casing/mm195x129/ap
	name = "1.95x129mm armor-piercing bullet casing"
	desc = "A 1.95x129mm bullet casing designed with a hardened-tipped core to help penetrate armored targets."
	projectile_type = /obj/item/projectile/bullet/mm195x129_ap

/obj/item/ammo_casing/mm195x129/hollow
	name = "1.95x129mm hollow-point bullet casing"
	desc = "A 1.95x129mm bullet casing designed to cause more damage to unarmored targets."
	projectile_type = /obj/item/projectile/bullet/mm195x129_hp

/obj/item/ammo_casing/mm195x129/incen
	name = "1.95x129mm incendiary bullet casing"
	desc = "A 1.95x129mm bullet casing designed with a chemical-filled capsule on the tip that when bursted, reacts with the atmosphere to produce a fireball, engulfing the target in flames."
	projectile_type = /obj/item/projectile/bullet/incendiary/mm195x129

/obj/item/ammo_casing/mm712x82/match
	name = "7.12x82mm match bullet casing"
	desc = "A 7.12x82mm bullet casing manufactured to unfailingly high standards, you could pull off some cool trickshots with this."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/mm712x82_match

/obj/item/projectile/bullet/mm712x82_match
	name = "7.12x82mm match bullet"
	damage = 40
	ricochets_max = 2
	ricochet_chance = 60
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 35

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

//14mm
/obj/item/ammo_casing/p14mm
	name = "14mm FMJ bullet casing"
	desc = "A 14mm FMJ bullet casing."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/mm14
	material_class = BULLET_IS_HEAVY_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_HEAVY_CASING + MATS_PISTOL_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVIER_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_14MM

/obj/item/ammo_casing/p14mm/improvised
	name = "shoddy 14mm bullet casing"
	desc = "A handloaded 14mm bullet casing."
	caliber = CALIBER_COMPACT
	projectile_type = /obj/item/projectile/bullet/mm14
	material_class = BULLET_IS_HEAVY_PISTOL
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_PISTOL_HEAVY_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_PISTOL_HEAVY_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
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

// deprecated musketball
/obj/item/ammo_casing/caseless/musketball
	name = "Musketball"
	desc = "This is a lead ball for a musket."
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/bullet/F13/musketball

// laser musket ammo
/obj/item/ammo_casing/caseless/lasermusket
	name = "Battery"
	desc = "A single use battery for the lasmusket."
	caliber = CALIBER_MEDIUM
	icon_state = "lasmusketbat"
	projectile_type = /obj/item/projectile/beam/laser/musket
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy

// brick
/obj/item/ammo_casing/caseless/brick
	name = "brick"
	desc = "a weighty brick for bashing heads. You too might find some laying around with *brick"
	icon = 'modular_coyote/icons/objects/brick.dmi'
	icon_state = "brick"
	item_state = "brick"
	force = 15
	throwforce = 20
	throw_speed = 1
	throw_range = 10
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_SMALL_ITEM
	attack_verb = list("attacked", "bashed", "brained", "thunked", "clobbered")
	attack_speed = CLICK_CD_MELEE
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	caliber = CALIBER_MEDIUM
	projectile_type = /obj/item/projectile/brick
	is_pickable = TRUE
	custom_materials = list(/datum/material/glass = 50)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_ROCK
	hitsound = 'sound/effects/brickthrow.ogg'

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

// balls
/obj/item/ammo_casing/caseless/flintlock
	name = "packed blackpowder cartridge"
	desc = "a measure of blackpowder and round musket ball."
	caliber = CALIBER_MEDIUM
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "flintlock_casing"
	projectile_type = /obj/item/projectile/flintlock
	custom_materials = list(
		/datum/material/iron = MATS_FLINTLOCK_LIGHT_BULLET, // what casing? ~ uwu ~
		/datum/material/blackpowder = MATS_FLINTLOCK_LIGHT_POWDER)
	sound_properties = CSP_FLINTLOCK
	custom_materials = list(/datum/material/blackpowder = 500)
	w_class = WEIGHT_CLASS_SMALL
	variance = CASING_SPREAD_FLINTLOCK

/obj/item/ammo_casing/caseless/flintlock/rubber
	name = "packed blackpowder rubber cartridge"
	desc = "A superball mashed into a blackpowder cartridge. It's not very effective, but it's fun to shoot. Less than lethal?"
	caliber = CALIBER_FLINTLOCK
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "flintlock_casing_rubber"
	projectile_type = /obj/item/projectile/flintlock/rubber
	sound_properties = CSP_FLINTLOCK
	variance = CASING_SPREAD_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_FLINTLOCK_LIGHT_POWDER, // what casing? ~ uwu ~
		/datum/material/blackpowder = MATS_FLINTLOCK_HEAVY_POWDER)
	w_class = WEIGHT_CLASS_SMALL

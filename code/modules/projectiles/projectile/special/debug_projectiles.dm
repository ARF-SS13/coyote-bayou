/// Unbirths a mob into a nest (if it's a hostile mob) when it hits it (or when it's hit by it) (or when it's hit by it and it hits it)
/obj/item/gun/ballistic/automatic/pistol/ninemil/unbirth
	name = "Browning Unbirther"
	desc = "A wretched gun used to stuff mobs into holes."
	icon_state = "ninemil"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack/unbirth
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(0.8, 0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto/fastest
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

/obj/item/ammo_casing/c9mm/unbirth
	name = "9mm FMJ unbirther casing"
	desc = "A wretched casing for unmaking mobs."
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/unbirth
	material_class = BULLET_IS_LIGHT_PISTOL
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_PISTOL_9MM

//9mm doublestack
/obj/item/ammo_box/magazine/m9mm/doublestack/unbirth
	name = "doublestack unbirth magazine (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m9mmds"
	ammo_type = /obj/item/ammo_casing/c9mm/unbirth
	caliber = list(CALIBER_9MM)
	max_ammo = 15
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

/// Makes a mob go and crawl into a nest
/obj/item/projectile/bullet/unbirth
	name = "unbirth bullet"
	damage = 0
	stamina = BULLET_STAMINA_PISTOL_22
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22

	wound_bonus = BULLET_WOUND_PISTOL_22
	bare_wound_bonus = BULLET_WOUND_PISTOL_22_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/unbirth/on_hit(atom/target, blocked = FALSE)
	..()
	if(istype(target, /mob/living/simple_animal/hostile))
		var/mob/living/simple_animal/hostile/B = target
		B.unbirth_self(TRUE) // this gun noncon vores people into holes
	return BULLET_ACT_HIT

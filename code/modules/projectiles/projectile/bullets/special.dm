/obj/item/projectile/rock
	name = "rock"
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	damage = BULLET_DAMAGE_PISTOL_10MM
	stamina = BULLET_STAMINA_PISTOL_10MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_10MM
	
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	range = 50
	damage_type = BRUTE
	nodamage = FALSE
	candink = TRUE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect

/obj/item/projectile/brick
	name = "brick"
	icon = 'modular_coyote/icons/objects/brick.dmi'
	icon_state = "brick"
	damage = BULLET_DAMAGE_PISTOL_44
	stamina = BULLET_STAMINA_PISTOL_44
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44
	
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	range = 50
	damage_type = BRUTE
	nodamage = FALSE
	candink = TRUE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect

/obj/item/projectile/flintlock
	name = "musket ball"
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "musketball_pistol"
	damage =  BULLET_DAMAGE_SHOTGUN_SLUG
	stamina = BULLET_STAMINA_SHOTGUN_SLUG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_SLUG
	
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	range = 50
	damage_type = BRUTE
	nodamage = FALSE
	candink = TRUE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect

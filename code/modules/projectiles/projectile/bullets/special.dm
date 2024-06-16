/obj/item/projectile/rock
	name = "rock"
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	damage = BULLET_DAMAGE_PISTOL_10MM //30
	damage_list = list("5" = 5, "8" = 5, "10" = 5, "12" = 5, "15" = 10, "25" = 30, "30" = 40)
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
	damage = BULLET_DAMAGE_PISTOL_44 //45
	damage_list = list("5" = 5, "8" = 5, "10" = 5, "15" = 5, "25" = 5, "35" = 45, "45" = 30)
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
	icon_state = "musket"
	damage = BULLET_DAMAGE_FLINTLOCK_MATCH //87.5
	damage_list = list("40" = 10, "60" = 10, "70" = 10, "87.5" = 60, "100" = 9, "200" = 1)
	stamina = BULLET_STAMINA_FLINTLOCK
	spread = BULLET_SPREAD_FLINTLOCK
	recoil = BULLET_RECOIL_FLINTLOCK
	wound_bonus = BULLET_WOUND_FLINTLOCK_MATCH

	pixels_per_second = BULLET_SPEED_FLINTLOCK_MATCH
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BRUTE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	icon_state = "musket"

/obj/item/projectile/flintlock/minie
	name = "minie ball"
	damage = BULLET_DAMAGE_FLINTLOCK //70
	damage_list = list("40" = 10, "60" = 10, "70" = 70, "120" = 9, "150" = 1)
	stamina = BULLET_STAMINA_FLINTLOCK
	spread = BULLET_SPREAD_SURPLUS // shockingly accurate
	recoil = BULLET_RECOIL_FLINTLOCK
	wound_bonus = BULLET_WOUND_FLINTLOCK

	pixels_per_second = BULLET_SPEED_FLINTLOCK
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	range = 50
	damage_type = BRUTE
	nodamage = FALSE
	candink = TRUE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect

/obj/item/projectile/flintlock/rubber
	name = "superball"
	icon_state = "musket_rubber"
	damage = RUBBERY_DAMAGE_FLINTLOCK
	stamina = RUBBERY_STAMINA_FLINTLOCK
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_FLINTLOCK
	wound_bonus = RUBBERY_WOUND_FLINTLOCK
	pixels_per_second = BULLET_SPEED_FLINTLOCK_RUBBER

	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect

	ricochets_max = 10
	ricochet_incidence_leeway = 0
	ricochet_decay_damage = 0.9
	ricochet_decay_chance = 11
	ricochet_chance = 100
	ricochet_auto_aim_range = 0


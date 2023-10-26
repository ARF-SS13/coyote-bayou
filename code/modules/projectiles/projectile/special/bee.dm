/obj/item/projectile/bullet/bee
	name = ".22lr beellet"
	damage = 0 //we don't have a var for this low of damage, but any higher would cause mass friendly fire by hitting the bees
	stamina = BULLET_STAMINA_PISTOL_22
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22

	wound_bonus = BULLET_WOUND_PISTOL_22
	bare_wound_bonus = BULLET_WOUND_PISTOL_22_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/bee/on_hit(atom/target, blocked = FALSE)
	..()
	spawn_and_random_walk(/mob/living/simple_animal/hostile/poison/bees/short/frenly, target, 1, walk_chance = 100, max_walk = 3, admin_spawn = FALSE)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/mouse
	name = ".22lr mouseshot"
	damage = 0
	stamina = BULLET_STAMINA_PISTOL_22
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22

	wound_bonus = BULLET_WOUND_PISTOL_22
	bare_wound_bonus = BULLET_WOUND_PISTOL_22_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/mouse/on_hit(atom/target, blocked = FALSE)
	..()
	spawn_and_random_walk(/mob/living/simple_animal/hostile/rat/skitter/curious/frenly, target, 1, walk_chance = 100, max_walk = 3, admin_spawn = FALSE)
	return BULLET_ACT_HIT

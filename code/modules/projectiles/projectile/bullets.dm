/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = FALSE
	candink = TRUE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	sharpness = SHARP_POINTY
	var/anti_armour_damage = 0

/obj/item/projectile/bullet/smite
	name = "divine retribution"
	damage = 10

/obj/item/projectile/bullet/on_hit(atom/target)
	if(ismecha(target))
		var/obj/mecha/M = target
		M.take_damage(anti_armour_damage)
	return BULLET_ACT_HIT

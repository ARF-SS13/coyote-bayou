// 40mm (Grenade Launcher

/obj/item/projectile/bullet/a40mm
	name ="40mm grenade"
	desc = "Oh no."
	icon_state= "bolter"
	damage = 5
	pixels_per_second = TILES_TO_PIXELS(10) //slower than bullets

/obj/item/projectile/bullet/a40mm/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, -1, 3, 3, 0, flame_range = 3)
	new /obj/effect/temp_visual/explosion(get_turf(target))
	return BULLET_ACT_HIT

/*/ .50 (Sniper)
/obj/item/projectile/bullet/a50MG
	damage = 55
	armour_penetration = 0.85
	pixels_per_second = 5000

/obj/item/projectile/bullet/a50MG/incendiary
	damage = 40
	armour_penetration = 0.5
	var/fire_stacks = 4

/obj/item/projectile/bullet/a50MG/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/*
	/obj/item/projectile/bullet/a50MG/AP
	damage = 35
	armour_penetration = 65 will punch through anything short of Enclave power armor*/

/obj/item/projectile/bullet/a50MG/explosive
	damage = 30
	armour_penetration = 0.6

/obj/item/projectile/bullet/a50MG/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 1, 1, 1)
*/

/obj/item/projectile/ion
	name = "ion bolt"
	icon_state = "ion"
	damage = 32 // Same as the AER, but you get 5 to 8 less shots for the EMP effect
	damage_list = list("28" = 30, "32" = 50, "37" = 20)
	damage_type = BURN
	flag = "energy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/ion
	var/emp_radius = 2

/obj/item/projectile/ion/on_hit(atom/target, blocked = FALSE)
	..()
	empulse_using_range(target, emp_radius)
	return BULLET_ACT_HIT

/obj/item/projectile/ion/weak
	emp_radius = 1
	damage = 20
	damage_list = list("18" = 30, "20" = 50, "25" = 20)

/obj/item/projectile/ion/renegade
	name = "ion bolt"
	icon_state = "ion"
	damage = 0 // being stunlocked AND shot to death isn't fun gameplay
	damage_list = list("0" = 100)
	damage_type = BURN
	flag = "energy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/ion
	emp_radius = 3

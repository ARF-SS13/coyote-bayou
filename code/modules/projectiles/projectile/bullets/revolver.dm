// .38 special

/obj/item/projectile/bullet/c38
	name = ".38 bullet"
	damage = 25
/*
	ricochets_max = 2
	ricochet_chance = 50
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 3
	wound_bonus = -20
	bare_wound_bonus = 10
	embedding = list(embed_chance=15, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=3, jostle_pain_mult=5, rip_time=10)
*/

// .357 magnum
/obj/item/projectile/bullet/a357
	name = ".357 FMJ bullet"
	damage = 35
	armour_penetration = 0

/obj/item/projectile/bullet/a357/jhp
	name = ".357 JHP bullet"
	damage = 40
	armour_penetration = -25

/obj/item/projectile/bullet/a357/jfp
	name = ".357 JFP bullet"

// .44 Magnum
/obj/item/projectile/bullet/m44
	damage = 41 //35
	armour_penetration = -5 //5

/obj/item/projectile/bullet/m44/jhp
	damage = 60 //40
	armour_penetration = -40 //-15

/obj/item/projectile/bullet/m44/swc
	damage = 40
	armour_penetration = 5

//45-70
/obj/item/projectile/bullet/c4570
	damage = 50
	armour_penetration = 15//10

/obj/item/projectile/bullet/c4570/jhp
	damage = 55
	armour_penetration = -10

/obj/item/projectile/bullet/c4570/swc
	damage = 55
	armour_penetration = 10

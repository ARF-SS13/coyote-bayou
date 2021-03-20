// .38 special

/obj/item/projectile/bullet/c38
	name = ".38 bullet"
	damage = 28
	armour_penetration = 0.05
	wound_bonus = 7
	bare_wound_bonus = -7
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
	armour_penetration = 0.15
	wound_bonus = 14
	bare_wound_bonus = -14

/obj/item/projectile/bullet/a357/jhp
	name = ".357 JHP bullet"
	damage = 40
	armour_penetration = -0.56
	wound_bonus = -28
	bare_wound_bonus = 28

/obj/item/projectile/bullet/a357/jfp
	name = ".357 JFP bullet"
	damage = 42
	armour_penetration = 0.35
	wound_bonus = 14
	bare_wound_bonus = 14

// .44 Magnum
/obj/item/projectile/bullet/m44
	name = ".44 FMJ bullet"
	damage = 41
	armour_penetration = 0.22
	wound_bonus = 20
	bare_wound_bonus = -20

/obj/item/projectile/bullet/m44/jhp
	name = ".44 JHP bullet"
	damage = 49
	armour_penetration = -0.75
	wound_bonus = -40
	bare_wound_bonus = 40

/obj/item/projectile/bullet/m44/swc
	name = ".44 SWC bullet"
	damage = 49
	armour_penetration = 0.22
	wound_bonus = 40
	bare_wound_bonus = 40

/obj/item/projectile/bullet/m44/simple //for simple mobs, separate to allow balancing
	name = ".44 bullet"

//45-70
/obj/item/projectile/bullet/c4570
	name = ".45-70 FMJ bullet"
	damage = 50
	armour_penetration = 0.3
	wound_bonus = 24
	bare_wound_bonus = -24

/obj/item/projectile/bullet/c4570/jhp
	name = ".45-70 JHP bullet"
	damage = 60
	armour_penetration = -0.75
	wound_bonus = -48
	bare_wound_bonus = 48

/obj/item/projectile/bullet/c4570/swc
	name = ".45-70 SWC bullet"
	damage = 58 //60
	armour_penetration = 0.18 //0.22
	wound_bonus = 48
	bare_wound_bonus = 48

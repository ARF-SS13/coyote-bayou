// .38 special

/obj/item/projectile/bullet/c38
	name = ".38 bullet"
	damage = 35
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
	damage = 38
	armour_penetration = 0.15
	wound_bonus = 14
	bare_wound_bonus = -14

/obj/item/projectile/bullet/a357/jhp
	name = ".357 JHP bullet"
	damage = 45
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
	damage = 43
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


//45 Long Colt. Bouncy ammo but less damage then the Sequoia. It's in one of the Vet Ranger kits
/obj/item/projectile/bullet/a45lc
	name = ".45 LC bullet"
	damage = 43 //44 mag damage
	armour_penetration = 0.3
	wound_bonus = 15
	bare_wound_bonus = -15
	ricochets_max = 3
	ricochet_incidence_leeway = 130
	ricochet_decay_damage = 1.3 
	ricochet_decay_chance = 1
	ricochet_chance = 80 //100% if you have the vet's trait
	ricochet_auto_aim_range = 4


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

/obj/item/projectile/bullet/c4570/explosive
	damage = 10
	armour_penetration = 1
	pixels_per_second = TILES_TO_PIXELS(500)
	name = ".45-70 explosive bullet"

/obj/item/projectile/bullet/c4570/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 1, 1, flame_range = 1)

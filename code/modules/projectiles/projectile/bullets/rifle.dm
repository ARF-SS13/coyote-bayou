// 7.62
/obj/item/projectile/bullet/a762
	name = "7.62 FMJ bullet"
	damage = 44 //42
	armour_penetration = 0.25 //0.22
	wound_bonus = 20
	bare_wound_bonus = -20

/obj/item/projectile/bullet/a762/ap
	name = "7.62 AP bullet"
	damage = 37 //32
	armour_penetration = 0.6
	wound_bonus = 30
	bare_wound_bonus = -30

/obj/item/projectile/bullet/a762/jhp
	name = "7.62 JHP bullet"
	damage = 55 //48
	armour_penetration = -1
	wound_bonus = -40
	bare_wound_bonus = 40

/obj/item/projectile/bullet/a762/sport //.308 Winchester
	name = ".308 bullet"
	damage = 35
	armour_penetration = 0.08
	wound_bonus = 10
	bare_wound_bonus = -10

/obj/item/projectile/bullet/a762/match
	name = "7.62 match bullet"
	damage = 47 //50
	armour_penetration = 0.4
	wound_bonus = 25
	bare_wound_bonus = 25

/obj/item/projectile/bullet/a762/sport/simple //for simple mobs, separate to allow balancing
	name = ".308 bullet"

//5.56x45mm
/obj/item/projectile/bullet/a556
	name = "5.56 FMJ bullet"
	damage = 37
	armour_penetration = 0.2 //0.2
	wound_bonus = 18
	bare_wound_bonus = -18

/obj/item/projectile/bullet/a556/ap
	name = "5.56 AP bullet"
	damage = 28
	armour_penetration = 0.6 //0.65
	wound_bonus = 30
	bare_wound_bonus = -18

/obj/item/projectile/bullet/a556/jhp
	name = "5.56 JHP bullet"
	damage = 45
	armour_penetration = -1
	wound_bonus = -36
	bare_wound_bonus = 36

/obj/item/projectile/bullet/a556/match
	name = "5.56 match bullet"
	damage = 39 //46
	armour_penetration = 0.4 //0.45
	wound_bonus = 18
	bare_wound_bonus = 18

/obj/item/projectile/bullet/a556/sport
	name = ".223 FMJ bullet"
	damage = 28
	armour_penetration = 0.08
	wound_bonus = 10
	bare_wound_bonus = -10

/obj/item/projectile/bullet/a556/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"

/obj/item/projectile/bullet/a556/ap/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"

/obj/item/projectile/bullet/a473
	name = "4.73 FMJ bullet"
	damage = 38
	armour_penetration = 0.2
	wound_bonus = 20
	bare_wound_bonus = -20

/obj/item/projectile/bullet/a473/explosive
	name = "4.73 explosive bullet"

/obj/item/projectile/bullet/a473/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 1, 0, adminlog = FALSE, flame_range = 1)

//2mm Electromagnetic
/obj/item/projectile/bullet/c2mm
	damage = 55
	armour_penetration = 0.85
	pixels_per_second = TILES_TO_PIXELS(100)

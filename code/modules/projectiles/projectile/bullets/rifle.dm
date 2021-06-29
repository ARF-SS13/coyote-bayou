//In this document: Rifle calibre cartridges values for damage and penetration.

//////////////////////
// AMMUNITION TYPES //
//////////////////////
/*
FMJ (full metal jacket)		=	Baseline
AP (armor piercing)			=	-10% damage. AP increased by 0.2. Wound bonus -50%
JHP (jacketed hollow point)	=	+10% damage. AP reduced by 0.2. Wound bonus + 50%
SWC (semi wadcutter)		=	AP reduced by 0.1. Wound bonus +50%
P+ (overpressure)			=	extra speed 500. AP + 01. Wound bonus -25%
Match						=	extra speed 200. AP +0.05. Wound bonus -10%
Civilian round				=	-10% damage. AP reduced by 50% 
*/


////////////////////
// 5.56 MM & .223 //
////////////////////		- Moderate damage, pretty good AP. .223 civilian version for hunting/sport.

/obj/item/projectile/bullet/a556
	name = "5.56 FMJ bullet"
	damage = 35
	armour_penetration = 0.25
	wound_bonus = 18
	bare_wound_bonus = -18

/obj/item/projectile/bullet/a556/ap
	name = "5.56 AP bullet"
	damage = 31
	armour_penetration = 0.45
	wound_bonus = 9
	bare_wound_bonus = -9

/obj/item/projectile/bullet/a556/jhp
	name = "5.56 JHP bullet"
	damage = 39
	armour_penetration = 0.05
	wound_bonus = -25
	bare_wound_bonus = 25

/obj/item/projectile/bullet/a556/match
	name = "5.56 match bullet"
	damage = 35
	armour_penetration = 0.3
	wound_bonus = 16
	bare_wound_bonus = -16
	var/extra_speed = 200

/obj/item/projectile/bullet/a556/sport
	name = ".223 FMJ bullet"
	damage = 32
	armour_penetration = 0.12
	wound_bonus = 18
	bare_wound_bonus = -18

/obj/item/projectile/bullet/a556/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"

/obj/item/projectile/bullet/a556/ap/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"


////////////////////
// 7.62 MM & .308 //
////////////////////		- heavy rifle round, powerful but high recoil and less rof in the guns that can use it. .308 civilian version for hunting.

/obj/item/projectile/bullet/a762
	name = "7.62 FMJ bullet"
	damage = 42
	armour_penetration = 0.3
	wound_bonus = 20
	bare_wound_bonus = -20

/obj/item/projectile/bullet/a762/ap
	name = "7.62 AP bullet"
	damage = 38
	armour_penetration = 0.5
	wound_bonus = 10
	bare_wound_bonus = -10

/obj/item/projectile/bullet/a762/jhp
	name = "7.62 JHP bullet"
	damage = 47
	armour_penetration = 0.1
	wound_bonus = -30
	bare_wound_bonus = 30

/obj/item/projectile/bullet/a762/match
	name = "7.62 match bullet"
	damage = 42
	armour_penetration = 0.35
	wound_bonus = 18
	bare_wound_bonus = -18
	var/extra_speed = 200

//.308 Winchester
/obj/item/projectile/bullet/a762/sport 
	name = ".308 bullet"
	damage = 38
	armour_penetration = 0.15
	wound_bonus = 20
	bare_wound_bonus = -20

/obj/item/projectile/bullet/a762/sport/simple //for simple mobs, separate to allow balancing
	name = ".308 bullet"


/////////
// .50 //
/////////			-Very heavy rifle round.

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

/obj/item/projectile/bullet/a50MG/explosive
	damage = 30
	armour_penetration = 0.6

/obj/item/projectile/bullet/a50MG/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 1, 1, 1)


//////////////////////
// 4.73 MM CASELESS //
//////////////////////			-Small rifle bullet

/obj/item/projectile/bullet/a473
	name = "4.73 FMJ bullet"
	damage = 34
	armour_penetration = 0.25
	wound_bonus = 10
	bare_wound_bonus = -10

/obj/item/projectile/bullet/a473/explosive
	name = "4.73 explosive bullet"

/obj/item/projectile/bullet/a473/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 1, 0, adminlog = FALSE, flame_range = 1)


//////////////////////////
// 5 MM minigun special //
//////////////////////////

/obj/item/projectile/bullet/c5mm
	damage = 19
	armour_penetration = 0.5


/////////////////////////
//2 MM ELECTROMAGNETIC //
/////////////////////////			- Gauss rifle

/obj/item/projectile/bullet/c2mm
	damage = 55
	armour_penetration = 0.85
	pixels_per_second = TILES_TO_PIXELS(100)

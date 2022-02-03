//In this document: Rifle calibre cartridges values for damage and penetration.

//////////////////////
// AMMUNITION TYPES //
//////////////////////
/*
FMJ (full metal jacket)		=	Baseline
AP (armor piercing)			=	-20% damage. AP increased by 0.2. Wound bonus -50%
JHP (jacketed hollow point)	=	+15% damage. AP reduced by 0.2 (not below zero). Wound bonus + 50%
SWC (semi wadcutter)		=	AP reduced by 0.1. Wound bonus +50%
P+ (overpressure)			=	extra speed 500. AP +25%
Match						=	extra speed 200. AP +10%. Wound bonus -10%
Civilian round				=	-10% damage for .223. AP reduced by 50%
*/

// Explanation: Two major ammo stats, AP and Damage. Bullets placed in classes. Light rounds for example balanced with each other, one more AP, one more Damage.
// Balance between classes mostly done on the gun end, bigger rounds typically fire slower and have more recoil. They are not supposed to be totally equal either.

////////////////////
// 5.56 MM & .223 //
////////////////////		- Moderate damage .223 civilian version for hunting/sport.

/obj/item/projectile/bullet/a556
	name = "5.56 FMJ bullet"
	damage = 0
	wound_bonus = 15
	bare_wound_bonus = -18

/obj/item/projectile/bullet/a556/match
	name = "5.56 match bullet"
	damage = 29
	armour_penetration = 0.21
	wound_bonus = 15
	bare_wound_bonus = -16
	var/extra_speed = 200

/obj/item/projectile/bullet/a556/sport
	name = ".223 FMJ bullet"
	damage = -4
	wound_bonus = 18
	bare_wound_bonus = -18

/obj/item/projectile/bullet/a556/rubber
	name = "5.56 rubber bullet"
	damage = -21
	stamina = 30
	sharpness = SHARP_NONE
	armour_penetration = 0
	wound_bonus = 0
	bare_wound_bonus = 0

/obj/item/projectile/bullet/a556/uraniumtipped
	name = "5.56 uranium-tipped bullet"
	damage = -5
	armour_penetration = 0.1
	irradiate = 300

/obj/item/projectile/bullet/a556/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"
	damage = 25

/obj/item/projectile/bullet/a556/ap/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"
	damage = 19
	armour_penetration = 0.1

////////////////////
// 7.62 MM & .308 //
////////////////////			- heavy rifle round, powerful but high recoil and less rof in the guns that can use it. .308 civilian version for hunting.

/obj/item/projectile/bullet/a762
	name = "7.62 FMJ bullet"
	damage = 0
	wound_bonus = 18
	bare_wound_bonus = -20

//.308 Winchester
/obj/item/projectile/bullet/a762/sport
	name = ".308 bullet"
	damage = -4

/obj/item/projectile/bullet/a762/rubber
	name = "7.62 rubber bullet"
	damage = -30
	stamina = 30
	sharpness = SHARP_NONE
	armour_penetration = 0
	wound_bonus = 0
	bare_wound_bonus = 0

/obj/item/projectile/bullet/a762/sport/simple //for simple mobs, separate to allow balancing
	name = ".308 bullet"
	damage = 35
	armour_penetration = 0.2

/obj/item/projectile/bullet/a762/uraniumtipped
	name = "7.62 uranium-tipped bullet"
	damage = -4
	armour_penetration = 0.18
	irradiate = 300

/////////
// .50 //
/////////			-Very heavy rifle round.

/obj/item/projectile/bullet/a50MG
	damage = 0
	pixels_per_second = 4000
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a50MG/incendiary
	damage = -10
	var/fire_stacks = 4
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a50MG/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/obj/item/projectile/bullet/a50MG/explosive
	damage = -20

/obj/item/projectile/bullet/a50MG/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 1, 1, 1)

/obj/item/projectile/bullet/a50MG/rubber
	name = ".50 rubber bullet"
	damage = -50
	stamina = 80
	armour_penetration = 0
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/a50MG/penetrator
	name = ".50 penetrator round"
	damage = -10
	movement_type = FLYING | UNSTOPPABLE


//////////////////////
// 4.73 MM CASELESS //
//////////////////////			-Small rifle bullet

/obj/item/projectile/bullet/a473
	name = "4.73 FMJ bullet"
	damage = 0
	wound_bonus = 10
	bare_wound_bonus = -10

/obj/item/projectile/bullet/a473/rubber
	name = "4.73 polyurethane bullet "
	damage = 5
	stamina = 18
	sharpness = SHARP_NONE
	armour_penetration = 0.05
	wound_bonus = 0
	bare_wound_bonus = 0

/obj/item/projectile/bullet/a473/incendiary
	name = "4.73 tracer bullet"
	damage = 15
	armour_penetration = 0.1
	var/fire_stacks = 3
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a473/uraniumtipped
	name = "4.73 U-235 bullet"
	damage = 15
	armour_penetration = 0.3
	irradiate = 300

/obj/item/projectile/bullet/a473/dumdum
	name = "4.73 flat-nose bullet"
	damage = 20
	armour_penetration = 0.1
	wound_bonus = 20
	bare_wound_bonus = 30

/obj/item/projectile/bullet/a473/explosive
	name = "4.73 explosive bullet"

/obj/item/projectile/bullet/a473/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 1, 0, adminlog = FALSE, flame_range = 1)


//////////////////////////
// 5 MM rifle			 //
//////////////////////////

/obj/item/projectile/bullet/m5mm  //for rifles// one of the only bullets to have integral AP
	damage = 0
	wound_bonus = 10
	bare_wound_bonus = -10
	var/extra_speed = 200

/obj/item/projectile/bullet/m5mm/simple //for simple mobs, separate to allow balancing
	name = "5mm bullet"
	damage = 19
	armour_penetration = 0.19

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
	damage = 0
	armour_penetration = 0.9 //if only one bullet has built in AP, its this one
	pixels_per_second = TILES_TO_PIXELS(100)

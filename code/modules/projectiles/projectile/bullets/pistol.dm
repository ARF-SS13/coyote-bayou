// 10mm 
/obj/item/projectile/bullet/c10mm
	name = "10mm bullet"
	damage = 36
	armour_penetration = -5

/obj/item/projectile/bullet/c10mm/ap
	name = "10mm armor-piercing bullet"
	damage = 25
	armour_penetration = 30

/obj/item/projectile/bullet/c10mm/hp
	name = "10mm hollow-point bullet"
	damage = 47
	armour_penetration = -30
	wound_bonus = -20
	bare_wound_bonus = 10

// 9mm 
/obj/item/projectile/bullet/c9mm
	name = "9mm bullet"
	damage = 29

/obj/item/projectile/bullet/c9mm/ap
	name = "9mm armor-piercing bullet"
	damage = 23
	armour_penetration = 27

/obj/item/projectile/bullet/c9mm/jhp
	name = "9mm hollow-point bullet"
	damage = 40
	armour_penetration = -30
	wound_bonus = -20
	bare_wound_bonus = 10

/obj/item/projectile/bullet/c9mm/op
	name = "9mm overpressure bullet"
	damage = 35
	wound_bonus = -10
	bare_wound_bonus = 5

// 12.7mm
/obj/item/projectile/bullet/a127mm
	name = "12.7mm FMJ bullet"
	damage = 55
	armour_penetration = 20

/obj/item/projectile/bullet/a127mm/jhp
	name = "12.7mm JHP bullet"
	damage = 70
	armour_penetration = -30
	wound_bonus = -20
	bare_wound_bonus = 10

// 22 long rifle (lmao)
/obj/item/projectile/bullet/c22
	name = ".22lr bullet"
	damage = 15
	armour_penetration = 0

/obj/item/projectile/bullet/c22/hp
	name = ".22lr hollow-point bullet"
	damage = 25
	armour_penetration = -20
	wound_bonus = -20
	bare_wound_bonus = 10

/obj/item/projectile/bullet/c22/plinking
	name = ".22lr plinking bullet"
	damage = 11
	armour_penetration = 0

// Needler
/obj/item/projectile/bullet/needle
    name = "needle"
    icon_state = "cbbolt"
    damage = 40
    armour_penetration = 15

/obj/item/projectile/bullet/needle/ap
    name = "armour piercing needle"
    damage = 30
    armour_penetration = 35

/obj/item/projectile/bullet/needle/ultra
    name = "ultracite needle"
    damage = 50
    armour_penetration = 25

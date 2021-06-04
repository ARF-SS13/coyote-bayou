// 10mm
/obj/item/projectile/bullet/c10mm
	name = "10mm FMJ bullet"
	damage = 29 //36
	armour_penetration = 0.1 //0.2
	wound_bonus = 18
	bare_wound_bonus = -18

/obj/item/projectile/bullet/c10mm/ap
	name = "10mm AP bullet"
	damage = 24
	armour_penetration = 0.5 //0.45
	wound_bonus = 30
	bare_wound_bonus = -36

/obj/item/projectile/bullet/c10mm/hp
	name = "10mm JHP bullet"
	damage = 43 //45
	armour_penetration = -0.7
	wound_bonus = -36
	wound_bonus = 36

// 9mm
/obj/item/projectile/bullet/c9mm
	name = "9mm FMJ bullet"
	damage = 26
	armour_penetration = 0.05 //0.15
	wound_bonus = 15
	bare_wound_bonus = -15

/obj/item/projectile/bullet/c9mm/ap
	name = "9mm AP bullet"
	damage = 20
	armour_penetration = 0.5 //0.4
	wound_bonus = 30
	bare_wound_bonus = -30

/obj/item/projectile/bullet/c9mm/jhp
	name = "9mm JHP bullet"
	damage = 36
	armour_penetration = -0.6
	wound_bonus = -30
	bare_wound_bonus = 30

/obj/item/projectile/bullet/c9mm/op
	name = "9mm +P bullet"
	damage = 30 //39
	armour_penetration = 0.35 //0.4
	wound_bonus = 30
	bare_wound_bonus = 30

/obj/item/projectile/bullet/c9mm/simple //for simple mobs, separate to allow balancing
	name = "9mm bullet"

// 12.7mm
/obj/item/projectile/bullet/a127mm
	name = "12.7mm FMJ bullet"
	damage = 60
	armour_penetration = 0.4
	wound_bonus = 28
	bare_wound_bonus = -28

/obj/item/projectile/bullet/a127mm/jhp
	name = "12.7mm JHP bullet"
	damage = 70
	armour_penetration = -1
	wound_bonus = -56
	bare_wound_bonus = 56

// 22 long rifle (lmao)
/obj/item/projectile/bullet/c22
	name = ".22lr bullet"
	damage = 15
	armour_penetration = 0.05
	wound_bonus = 6
	bare_wound_bonus = -6

/obj/item/projectile/bullet/c22/hp
	name = ".22lr HP bullet"
	damage = 18
	armour_penetration = -0.2
	wound_bonus = -12
	bare_wound_bonus = 12

/obj/item/projectile/bullet/c22/plinking
	name = ".22lr plinking bullet"
	damage = 12
	armour_penetration = 0.05
	wound_bonus = 4
	bare_wound_bonus = -4

// Needler
/obj/item/projectile/bullet/needle
	name = "needle"
	icon_state = "cbbolt"
	damage = 35
	armour_penetration = 0.8
	//makes the needler a dedicated armor piercing weapon instead of useless
	var/piercing = FALSE
/*
/obj/item/projectile/bullet/needle/Initialize()
	. = ..()
	create_reagents(50, NO_REACT, NO_REAGENTS_VALUE)

/obj/item/projectile/bullet/needle/on_hit(atom/target, blocked = FALSE, skip = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				if(skip == TRUE)
					return BULLET_ACT_HIT
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return TRUE
			else
				blocked = 100
				target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
									   "<span class='userdanger'>You were protected against \the [src]!</span>")

	..(target, blocked)
	DISABLE_BITFIELD(reagents.reagents_holder_flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT
*/
/obj/item/projectile/bullet/needle/ap
	name = "armour piercing needle"
	damage = 34
	armour_penetration = 1
	wound_bonus = 0
	bare_wound_bonus = 0
	piercing = TRUE

/obj/item/projectile/bullet/needle/ultra
	name = "ultracite needle"
	damage = 50
	armour_penetration = 0.4
	piercing = TRUE

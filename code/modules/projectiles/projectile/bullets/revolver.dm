/*/ .38 special light revolver calibre, slight damage focus
/obj/item/projectile/bullet/c38
	name = ".38 bullet"
	damage = 30
	armour_penetration = 0.05
	wound_bonus = 10


	ricochets_max = 2
	ricochet_chance = 50
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 3
	wound_bonus = -20
	bare_wound_bonus = 10
	embedding = list(embed_chance=15, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=3, jostle_pain_mult=5, rip_time=10)


// 9mm light semi calibre, fairly weak
/obj/item/projectile/bullet/c9mm
	name = "9mm FMJ bullet"
	damage = 28
	armour_penetration = 0.05
	wound_bonus = 15

/obj/item/projectile/bullet/c9mm/ap
	name = "9mm AP bullet"
	damage = 25
	armour_penetration = 0.35
	wound_bonus = 8
	bare_wound_bonus = -8

/obj/item/projectile/bullet/c9mm/jhp
	name = "9mm JHP bullet"
	damage = 31
	armour_penetration = -0.45
	wound_bonus = -23
	bare_wound_bonus = 23

/obj/item/projectile/bullet/c9mm/op
	name = "9mm +P bullet"
	damage = 27
	armour_penetration = 0.15
	wound_bonus = 10
	bare_wound_bonus = -10
	extra_speed = 500

/obj/item/projectile/bullet/c9mm/simple //for simple mobs, separate to allow balancing
	name = "9mm bullet"

// 10mm heavy semi calibre, slight AP focus
/obj/item/projectile/bullet/c10mm
	name = "10mm FMJ bullet"
	damage = 30
	armour_penetration = 0.12
	wound_bonus = 18

/obj/item/projectile/bullet/c10mm/ap
	name = "10mm AP bullet"
	damage = 27
	armour_penetration = 0.42
	wound_bonus = 9
	bare_wound_bonus = -9

/obj/item/projectile/bullet/c10mm/hp
	name = "10mm JHP bullet"
	damage = 33
	armour_penetration = -0.38
	wound_bonus = -27
	bare_wound_bonus = 27

//.45 ACP heavy semi calibre, slight damage/wound focus
/obj/item/projectile/bullet/c45
	name = ".45 FMJ bullet"
	damage = 33
	armour_penetration = 0.1
	wound_bonus = 20

/obj/item/projectile/bullet/c45/jhp
	name = ".45 JHP bullet"
	damage = 36
	armour_penetration = -0.4
	wound_bonus = -30
	bare_wound_bonus = 30

/obj/item/projectile/bullet/c45/op
	name = ".45 +P bullet"
	damage = 30
	armour_penetration = 0.2
	wound_bonus = 15
	bare_wound_bonus = -15
	extra_speed = 500

// .357 magnum  revolvers, heavy damage, decent AP
/obj/item/projectile/bullet/a357
	name = ".357 FMJ bullet"
	damage = 37
	armour_penetration = 0.15
	wound_bonus = 14
	bare_wound_bonus = -14

/obj/item/projectile/bullet/a357/jhp
	name = ".357 JHP bullet"
	damage = 41
	armour_penetration = -0.35
	wound_bonus = -21
	bare_wound_bonus = 21

/obj/item/projectile/bullet/a357/jfp
	name = ".357 JFP bullet"
	damage = 39
	armour_penetration = 0.05
	wound_bonus = 18
	bare_wound_bonus = 18

// .44 Magnum  revolver heavy damage, decent AP
/obj/item/projectile/bullet/m44
	name = ".44 FMJ bullet"
	damage = 40
	armour_penetration = 0.2
	wound_bonus = 20
	bare_wound_bonus = -20

/obj/item/projectile/bullet/m44/jhp
	name = ".44 JHP bullet"
	damage = 44
	armour_penetration = -0.3
	wound_bonus = -30
	bare_wound_bonus = 30

/obj/item/projectile/bullet/m44/swc
	name = ".44 SWC bullet"
	damage = 40
	armour_penetration = 0.1
	wound_bonus = 30
	bare_wound_bonus = 30


/obj/item/projectile/bullet/m44/simple //for simple mobs, separate to allow balancing
	name = ".44 bullet"

//45-70  huge round, great damage, pretty good AP
/obj/item/projectile/bullet/c4570
	name = ".45-70 FMJ bullet"
	damage = 48
	armour_penetration = 0.3
	wound_bonus = 24
	bare_wound_bonus = -24

/obj/item/projectile/bullet/c4570/jhp
	name = ".45-70 JHP bullet"
	damage = 53
	armour_penetration = -0.2
	wound_bonus = -36
	bare_wound_bonus = 36

/obj/item/projectile/bullet/c4570/swc
	name = ".45-70 SWC bullet"
	damage = 48
	armour_penetration = 0.15
	wound_bonus = 36
	bare_wound_bonus = 36

/obj/item/projectile/bullet/c4570/explosive
	damage = 10
	armour_penetration = 1
	pixels_per_second = TILES_TO_PIXELS(500)
	name = ".45-70 explosive bullet"

/obj/item/projectile/bullet/c4570/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 1, 1, flame_range = 1)

// 14mm  huge round, best damage, pretty good AP
/obj/item/projectile/bullet/a127mm
	name = "14mm FMJ bullet"
	damage = 60
	armour_penetration = 0.35
	wound_bonus = 28
	bare_wound_bonus = -28

/obj/item/projectile/bullet/a127mm/jhp
	name = "14mm JHP bullet"
	damage = 66
	armour_penetration = -0.15
	wound_bonus = -42
	bare_wound_bonus = 42

// Needler
/obj/item/projectile/bullet/needle
	name = "needle"
	icon_state = "cbbolt"
	damage = 35
	armour_penetration = 0.8
	//makes the needler a dedicated armor piercing weapon instead of useless
	var/piercing = FALSE

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
*/
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

////////////////////
// .22 LONG RIFLE //
////////////////////

/* * * * * * * *
 * Light Light Pistol Bullet
 * Surplus only
 * Shock
 * * * * * * * */

#define BULLET_22LR_DAMAGE_MULT 0.75
#define BULLET_22LR_STAMINA_MULT 0.75
#define BULLET_22LR_WOUND_MULT 0.25 // Any kind of armor's gonna block it
#define BULLET_22LR_NAKED_WOUND_MULT 1.5 // Skin though? different story
#define BULLET_22LR_SPEED_MULT 2 // Speedy round

/obj/item/projectile/bullet/c22
	name = ".22lr bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_22LR_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_22LR_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_22LR_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_22LR_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_22LR_SPEED_MULT

/obj/item/projectile/bullet/c22/rubber
	name = ".22lr rubber bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * RUBBERY_DAMAGE_MULT * BULLET_22LR_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_22LR_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = RUBBERY_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_22LR_WOUND_MULT
	bare_wound_bonus = RUBBERY_WOUND_PISTOL_LIGHT * BULLET_NAKED_RUBBERY_WOUND_MULT * BULLET_22LR_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_22LR_SPEED_MULT
	sharpness = SHARP_NONE

// EMP, also weaker rubber
/obj/item/projectile/bullet/c22/shock
	name = ".22lr shock bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * RUBBERY_DAMAGE_MULT * BULLET_DAMAGE_SHOCK * BULLET_22LR_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_SHOCK * BULLET_22LR_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS
	damage_type = BURN // still checks bullet resist

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_SHOCK * BULLET_22LR_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_NAKED_WOUND_SHOCK * BULLET_22LR_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_22LR_SPEED_MULT
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c22/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

#undef BULLET_22LR_DAMAGE_MULT
#undef BULLET_22LR_STAMINA_MULT
#undef BULLET_22LR_WOUND_MULT
#undef BULLET_22LR_NAKED_WOUND_MULT
#undef BULLET_22LR_SPEED_MULT

//////////
// 9 MM //
//////////

/* * * * * * * *
 * Baseline Light Pistol Bullet
 * Surplus, improvised, no match (yet)
 * Acid rounds
 * Fire rounds
 * * * * * * * */

/obj/item/projectile/bullet/c9mm
	name = "9mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT

/obj/item/projectile/bullet/c9mm/improv
	name = "9mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_HANDLOAD
	spread = BULLET_SPREAD_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_SPREAD_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT

/obj/item/projectile/bullet/c9mm/rubber
	name = "9mm rubber bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = RUBBERY_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = RUBBERY_WOUND_PISTOL_LIGHT * BULLET_NAKED_RUBBERY_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c9mm/acid
	name = "9mm acid-tipped bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_ACID
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_ACID
	spread = BULLET_SPREAD_MATCH
	damage_type = BURN // still checks bullet resist

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_ACID // acid~
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_ACID
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT
	sharpness = SHARP_NONE
	var/acid_type = /datum/reagent/toxin/acid/fluacid

/obj/item/projectile/bullet/c9mm/acid/Initialize()
	. = ..()
	create_reagents(2.5, NO_REACT, NO_REAGENTS_VALUE)
	reagents.add_reagent(acid_type, 2.5)

/obj/item/projectile/bullet/c9mm/acid/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		reagents.reaction(M, TOUCH)
		reagents.trans_to(M, reagents.total_volume)

/obj/item/projectile/bullet/c9mm/incendiary
	name = "9mm incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_MATCH
	damage_type = BURN // still checks bullet resist

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT
	sharpness = SHARP_NONE
	var/fire_stacks = 1

/obj/item/projectile/bullet/c9mm/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/obj/item/projectile/bullet/c9mm/op //for simple mobs, separate to allow balancing
	name = "9mm +P bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_MATCH
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_MATCH
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT

/obj/item/projectile/bullet/c9mm/simple //also for simple mobs, separate to allow balancing
	name = "9mm bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT


/////////////////
// .38 SPECIAL //
/////////////////

/* * * * * * * *
 * Wound-focused Light Pistol Bullet
 * Surplus
 * Improvised, no match (yet)
 * Rubber
 * Fire rounds
 * * * * * * * */

#define BULLET_38SPECIAL_DAMAGE_MULT 1
#define BULLET_38SPECIAL_STAMINA_MULT 1
#define BULLET_38SPECIAL_WOUND_MULT 1.2 // Better at not overpenetrating than 9mm
#define BULLET_38SPECIAL_NAKED_WOUND_MULT 1.2
#define BULLET_38SPECIAL_SPEED_MULT 1.1

/obj/item/projectile/bullet/c38
	name = ".38 bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_38SPECIAL_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_38SPECIAL_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_38SPECIAL_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_38SPECIAL_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_38SPECIAL_SPEED_MULT

/obj/item/projectile/bullet/c38/rubber
	name = ".38 rubber bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * RUBBERY_DAMAGE_MULT * BULLET_38SPECIAL_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_38SPECIAL_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = RUBBERY_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_38SPECIAL_WOUND_MULT
	bare_wound_bonus = RUBBERY_WOUND_PISTOL_LIGHT * BULLET_NAKED_RUBBERY_WOUND_MULT * BULLET_38SPECIAL_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_38SPECIAL_SPEED_MULT
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c38/improv
	name = ".38 improvised bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_HANDLOAD * BULLET_38SPECIAL_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_HANDLOAD * BULLET_38SPECIAL_STAMINA_MULT
	spread = BULLET_SPREAD_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_HANDLOAD * BULLET_38SPECIAL_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_38SPECIAL_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_38SPECIAL_SPEED_MULT

/obj/item/projectile/bullet/c38/acid
	name = ".38 acid-tipped bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_ACID * BULLET_38SPECIAL_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_ACID * BULLET_38SPECIAL_STAMINA_MULT
	spread = BULLET_SPREAD_MATCH
	damage_type = BURN // still checks bullet resist

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_ACID * BULLET_38SPECIAL_WOUND_MULT // acid~
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_ACID * BULLET_38SPECIAL_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_38SPECIAL_SPEED_MULT
	sharpness = SHARP_NONE
	var/acid_type = /datum/reagent/toxin/acid/fluacid

/obj/item/projectile/bullet/c38/acid/Initialize()
	. = ..()
	create_reagents(5, NO_REACT, NO_REAGENTS_VALUE)
	reagents.add_reagent(acid_type, 5)

/obj/item/projectile/bullet/c38/acid/on_hit(atom/target, blocked = FALSE)
	..()
	if(isliving(target))
		var/mob/living/M = target
		reagents.reaction(M, TOUCH)
		reagents.trans_to(M, reagents.total_volume)

/obj/item/projectile/bullet/c38/incendiary
	name = ".38 incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_FIRE * BULLET_38SPECIAL_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_FIRE * BULLET_38SPECIAL_STAMINA_MULT
	spread = BULLET_SPREAD_MATCH
	damage_type = BURN // still checks bullet resist

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_FIRE * BULLET_38SPECIAL_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE * BULLET_38SPECIAL_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_38SPECIAL_SPEED_MULT
	sharpness = SHARP_NONE
	var/fire_stacks = 1

/obj/item/projectile/bullet/c38/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

#undef BULLET_38SPECIAL_DAMAGE_MULT
#undef BULLET_38SPECIAL_STAMINA_MULT
#undef BULLET_38SPECIAL_WOUND_MULT
#undef BULLET_38SPECIAL_NAKED_WOUND_MULT
#undef BULLET_38SPECIAL_SPEED_MULT

/////////////
// NEEDLER //
/////////////

/* * * * * * * *
 * TBD Light Pistol Bullet
 * Needle that... I guess does a fuckload of wounding?
 * TBD for sure
 * * * * * * * */

#define BULLET_NEEDLE_DAMAGE_MULT 0.2 // 2 damage~
#define BULLET_NEEDLE_STAMINA_MULT 0.2 // Its a needle
#define BULLET_NEEDLE_WOUND_MULT 10 // That RIPS AND TEARS
#define BULLET_NEEDLE_NAKED_WOUND_MULT 15 // Okay maybe a flechette then
#define BULLET_NEEDLE_SPEED_MULT 0.8

/obj/item/projectile/bullet/needle
	name = "needle"
	icon_state = "cbbolt"
	damage = BULLET_DAMAGE_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_NEEDLE_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_NEEDLE_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_DAMAGE_SURPLUS * BULLET_NEEDLE_WOUND_MULT // terrible idea I know
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NEEDLE_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_PISTOL_LIGHT * BULLET_NEEDLE_SPEED_MULT
	var/piercing = FALSE // not sure what this does

#undef BULLET_NEEDLE_DAMAGE_MULT
#undef BULLET_NEEDLE_STAMINA_MULT
#undef BULLET_NEEDLE_WOUND_MULT
#undef BULLET_NEEDLE_NAKED_WOUND_MULT
#undef BULLET_NEEDLE_SPEED_MULT

///////////
// 10 MM //
///////////

/* * * * * * * *
 * Baseline Medium Pistol Bullet
 * Surplus
 * Improvised, no match (yet)
 * Acid rounds
 * Fire rounds
 * * * * * * * */

/obj/item/projectile/bullet/c10mm
	name = "10mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM

/obj/item/projectile/bullet/c10mm/improv
	name = "10mm handloaded bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_HANDLOAD
	spread = BULLET_SPREAD_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM

/obj/item/projectile/bullet/c10mm/simple
	name = "10mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_HANDLOAD
	spread = BULLET_SPREAD_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM

/obj/item/projectile/bullet/c10mm/rubber
	name = "10mm rubber bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = RUBBERY_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = RUBBERY_WOUND_PISTOL_MEDIUM * BULLET_NAKED_RUBBERY_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c10mm/incendiary
	name = "10mm incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_FIRE
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM
	sharpness = SHARP_NONE
	var/fire_stacks = 1

/obj/item/projectile/bullet/c10mm/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.fire_stacks < 1)
			M.adjust_fire_stacks(fire_stacks - M.fire_stacks)
			M.IgniteMob()


/////////////
// .45 ACP //
/////////////

/* * * * * * * *
 * Punchy Medium Pistol Bullet
 * Surplus, no match (yet)
 * Acid rounds
 * Fire rounds
 * * * * * * * */

#define BULLET_45ACP_DAMAGE_MULT 1
#define BULLET_45ACP_STAMINA_MULT 1.3
#define BULLET_45ACP_WOUND_MULT 1.3
#define BULLET_45ACP_NAKED_WOUND_MULT 1.3
#define BULLET_45ACP_SPEED_MULT 1.2

/obj/item/projectile/bullet/c45
	name = ".45 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_45ACP_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_45ACP_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_45ACP_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT * BULLET_45ACP_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM * BULLET_45ACP_SPEED_MULT

/obj/item/projectile/bullet/c45/simple
	name = ".45 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * 1.2
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT * 1.2
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM

/obj/item/projectile/bullet/c45/op
	name = ".45 +P bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * 1.2
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT * 1.2
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM * 1.2

/obj/item/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = RUBBERY_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = RUBBERY_WOUND_PISTOL_MEDIUM * BULLET_NAKED_RUBBERY_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c45/incendiary
	name = ".45 incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_FIRE
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_MEDIUM * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_MEDIUM
	
	pixels_per_second = BULLET_SPEED_PISTOL_MEDIUM
	sharpness = SHARP_NONE
	var/fire_stacks = 1

/obj/item/projectile/bullet/c45/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.fire_stacks < 1)
			M.adjust_fire_stacks(fire_stacks - M.fire_stacks)
			M.IgniteMob()

#undef BULLET_45ACP_DAMAGE_MULT
#undef BULLET_45ACP_STAMINA_MULT
#undef BULLET_45ACP_WOUND_MULT
#undef BULLET_45ACP_NAKED_WOUND_MULT
#undef BULLET_45ACP_SPEED_MULT

/////////////////
// .357 MAGNUM //
/////////////////

/* * * * * * * *
 * Baseline Heavy Pistol Bullet
 * Improvised, no match (yet)
 * Ricochet
 * Acid rounds
 * Fire rounds
 * * * * * * * */

/obj/item/projectile/bullet/a357
	name = ".357 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY

// 3 ricochets, more than enough to kill anything that moves

/obj/item/projectile/bullet/a357/improv
	name = "handloaded .357 bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_HANDLOAD
	spread = BULLET_SPREAD_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY

/obj/item/projectile/bullet/a357/ricochet
	name = ".357 ricochet bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY
	ricochets_max = 3
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80

/obj/item/projectile/bullet/a357/acid
	name = ".357 acid-tipped bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_ACID
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_ACID
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_ACID
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_ACID
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY
	sharpness = SHARP_NONE
	var/acid_type = /datum/reagent/toxin/acid/fluacid

/obj/item/projectile/bullet/a357/acid/Initialize()
	. = ..()
	create_reagents(5, NO_REACT, NO_REAGENTS_VALUE)
	reagents.add_reagent(acid_type, 5)

/obj/item/projectile/bullet/a357/acid/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		reagents.reaction(M, TOUCH)
		reagents.trans_to(M, reagents.total_volume)

/obj/item/projectile/bullet/a357/incendiary
	name = ".357 incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY
	sharpness = SHARP_NONE
	var/fire_stacks = 2

/obj/item/projectile/bullet/a357/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.fire_stacks < 2)
			M.adjust_fire_stacks(fire_stacks - M.fire_stacks)
			M.IgniteMob()

////////////////
// .44 MAGNUM //
////////////////

/* * * * * * * *
 * Heavy Heavy Pistol Bullet
 * Improvised, no match (yet)
 * Fire rounds
 * * * * * * * */

#define BULLET_44MAG_DAMAGE_MULT 1.3 // 26
#define BULLET_44MAG_STAMINA_MULT 1.3
#define BULLET_44MAG_WOUND_MULT 2
#define BULLET_44MAG_NAKED_WOUND_MULT 2
#define BULLET_44MAG_SPEED_MULT 2

/obj/item/projectile/bullet/m44
	name = ".44 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_44MAG_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_44MAG_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_44MAG_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_44MAG_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY * BULLET_44MAG_SPEED_MULT

/obj/item/projectile/bullet/m44/simple //for simple mobs, separate to allow balancing
	name = ".44 bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_44MAG_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_44MAG_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_44MAG_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_44MAG_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY * BULLET_44MAG_SPEED_MULT

/obj/item/projectile/bullet/m44/incendiary
	name = ".44 incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_FIRE * BULLET_44MAG_DAMAGE_MULT
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_FIRE * BULLET_44MAG_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_FIRE * BULLET_44MAG_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE * BULLET_44MAG_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY * BULLET_44MAG_SPEED_MULT
	sharpness = SHARP_NONE
	var/fire_stacks = 3

/obj/item/projectile/bullet/m44/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

#undef BULLET_44MAG_DAMAGE_MULT
#undef BULLET_44MAG_STAMINA_MULT
#undef BULLET_44MAG_WOUND_MULT
#undef BULLET_44MAG_NAKED_WOUND_MULT
#undef BULLET_44MAG_SPEED_MULT

///////////
// 14 MM //
///////////

/* * * * * * * *
 * Ultra Heavy Pistol Bullet
 * Improvised, no match (yet)
 * Poison spray?
 * * * * * * * */

#define BULLET_14MM_DAMAGE_MULT 2 // 40 damage
#define BULLET_14MM_STAMINA_MULT 2
#define BULLET_14MM_WOUND_MULT 2
#define BULLET_14MM_NAKED_WOUND_MULT 2
#define BULLET_14MM_SPEED_MULT 2

/obj/item/projectile/bullet/mm14
	name = "14mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_14MM_DAMAGE_MULT // BIG FUCKIN BULLET
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_14MM_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_14MM_WOUND_MULT // haha get fuckt
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_14MM_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY * BULLET_14MM_SPEED_MULT

/obj/item/projectile/bullet/mm14/contam
	name = "14mm contaiminated bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_DAMAGE_POISON * BULLET_14MM_DAMAGE_MULT 
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_STAMINA_POISON * BULLET_14MM_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS * BULLET_WOUND_POISON * BULLET_14MM_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_POISON * BULLET_14MM_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY * 2
	var/smoke_radius = 1

/obj/item/projectile/bullet/mm14/contam/Initialize()
	. = ..()
	create_reagents(15, NO_REACT, NO_REAGENTS_VALUE)
	reagents.add_reagent(/datum/reagent/toxin/metabtoxin, 15)

/obj/item/projectile/bullet/mm14/contam/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/location = get_turf(src)
	var/datum/effect_system/smoke_spread/chem/S = new
	S.attach(location)
	playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
	if(S)
		S.set_up(src.reagents, smoke_radius, location, 0)
		S.start()

/*
/obj/item/projectile/bullet/mm14/uraniumtipped
	name = "14mm uranium-tipped bullet"
	damage = -5
	armour_penetration = 0.1
	irradiate = 300
*/

#undef BULLET_14MM_DAMAGE_MULT
#undef BULLET_14MM_STAMINA_MULT
#undef BULLET_14MM_WOUND_MULT
#undef BULLET_14MM_NAKED_WOUND_MULT
#undef BULLET_14MM_SPEED_MULT

//////////////////////
//SPECIAL AMMO TYPES//
//////////////////////

/* * * * * * * *
 * Bouncy Heavy Pistol Bullet
 * Surplus only
 * Just bouncy 357
 * * * * * * * */

/obj/item/projectile/bullet/a45lc
	name = ".45 LC bullet"
	damage = BULLET_DAMAGE_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	stamina = BULLET_STAMINA_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

	wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_DAMAGE_SURPLUS
	bare_wound_bonus = BULLET_WOUND_PISTOL_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_HEAVY
	
	pixels_per_second = BULLET_SPEED_PISTOL_HEAVY
	ricochets_max = 3
	ricochet_incidence_leeway = 130
	ricochet_decay_damage = 1.1 //48 damage on first bounce, 53 on second, 58 on third. Unless you bounce, the DPS dual wielding is lower then a single M29
	ricochet_decay_chance = 11
	ricochet_chance = 80 //100% if you have the vet's trait
	ricochet_auto_aim_range = 4

////////////////
//CODE ARCHIVE//
////////////////

/*
SYNDIE AMMO
/obj/item/projectile/bullet/p50
	name =".50 bullet"
	pixels_per_second = TILES_TO_PIXELS(25)
	damage = 70
	knockdown = 100
	dismemberment = 50
	armour_penetration = 0.85
	zone_accuracy_factor = 100		//guarunteed 100%
	var/breakthings = TRUE

/obj/item/projectile/bullet/p50/on_hit(atom/target, blocked = 0)
	if(isobj(target) && (blocked != 100) && breakthings)
		var/obj/O = target
		O.take_damage(80, BRUTE, "bullet", FALSE)
	return ..()

/obj/item/projectile/bullet/p50/soporific
	name =".50 soporific bullet"
	armour_penetration = 0
	damage = 0
	dismemberment = 0
	knockdown = 0
	breakthings = FALSE

/obj/item/projectile/bullet/p50/soporific/on_hit(atom/target, blocked = FALSE)
	if((blocked != 100) && isliving(target))
		var/mob/living/L = target
		L.Sleeping(400)
	return ..()

/obj/item/projectile/bullet/p50/penetrator
	name =".50 penetrator bullet"
	icon_state = "gauss"
	name = "penetrator round"
	damage = 60
	movement_type = FLYING | UNSTOPPABLE
	dismemberment = 0 //It goes through you cleanly.
	knockdown = 0
	breakthings = FALSE

/obj/item/projectile/bullet/p50/penetrator/shuttle //Nukeop Shuttle Variety
	icon_state = "gaussstrong"
	damage = 25
	pixels_per_second = TILES_TO_PIXELS(33.33)
	range = 16

NEEDLE INJECTION CODE
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

BOUNCING BULLET CODE
	ricochets_max = 2
	ricochet_chance = 50
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 3
	wound_bonus = -20
	bare_wound_bonus = 10
	embedding = list(embed_chance=15, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=3, jostle_pain_mult=5, rip_time=10)


SOPORIFIC ROUND CODE
/obj/item/projectile/bullet/p50/soporific/on_hit(atom/target, blocked = FALSE)
	if((blocked != 100) && isliving(target))
		var/mob/living/L = target
		L.Sleeping(400)
	return ..()
*/

// BETA STUFF // Obsolete
/obj/item/projectile/bullet/test
	name = "testing bullet"
	damage = 0

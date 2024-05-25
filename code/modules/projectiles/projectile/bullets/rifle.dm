////////////////////
// 5.56 MM & .223 //
////////////////////

/* * * * * * * *
 * Baseline Light Rifle Bullet
 * Match
 * Surplus
 * Improvised
 * Rubber
 * Microshapnel
 * * * * * * * */

/* 5.56 match
 * DAMAGE: 37
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/a556
	name = "5.56 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_223 //36
	damage_list = list("30" = 30, "36" = 30, "40" = 30, "41" = 2, "42" = 2, "43" = 2, "44" = 2, "45" = 1, "50" = 0.5, "55" = 0.5)
	stamina = BULLET_STAMINA_RIFLE_223
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_223

	wound_bonus = BULLET_WOUND_RIFLE_223
	bare_wound_bonus = BULLET_WOUND_RIFLE_223_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_223
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 5.56 sport
 * DAMAGE: 30
 * STAMIN: 5
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75

/obj/item/projectile/bullet/a556/sport
	name = "surplus .223 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_223
	stamina = BULLET_STAMINA_RIFLE_223
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_223

	wound_bonus = BULLET_WOUND_RIFLE_223
	bare_wound_bonus = BULLET_WOUND_RIFLE_223_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_223
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
*/
/* 5.56 handload
 * DAMAGE: 22
 * STAMIN: 3.75
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/a556/improvised
	name = "handloaded .223 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_223_HANDLOAD
	damage_list = list("25" = 30, "32" = 30, "38" = 30, "35" = 2, "38" = 2, "40" = 2, "42" = 2, "44" = 1, "47" = 0.5, "55" = 0.5)
	stamina = BULLET_STAMINA_RIFLE_223
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_223_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_223_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_223_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_223_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 5.56 rubber
 * DAMAGE: 2.5
 * STAMIN: 60
 * RECOIL: 1
 * WOUNDS: 7.5
 * WNAKED: 5.6
 */
/obj/item/projectile/bullet/a556/rubber
	name = "5.56 rubber bullet"
	damage = RUBBERY_DAMAGE_RIFLE_223
	stamina = RUBBERY_STAMINA_RIFLE_223
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_RIFLE_223

	wound_bonus = RUBBERY_WOUND_RIFLE_223
	bare_wound_bonus = BULLET_WOUND_RIFLE_223_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_223
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* 5.56 embed
 * DAMAGE: 12.5
 * STAMIN: 2.5
 * RECOIL: 1
 * WOUNDS: 12.5
 * WNAKED: 9
 */
/obj/item/projectile/bullet/a556/microshrapnel
	name = "5.56 microshrapnel bullet"
	damage = BULLET_DAMAGE_RIFLE_223 * BULLET_DAMAGE_MICROSHRAPNEL
	stamina = BULLET_STAMINA_RIFLE_223 * BULLET_STAMINA_MICROSHRAPNEL
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_223

	wound_bonus = BULLET_WOUND_RIFLE_223 * BULLET_WOUND_MICROSHRAPNEL
	bare_wound_bonus = BULLET_WOUND_RIFLE_223_NAKED_MULT * BULLET_NAKED_WOUND_MICROSHRAPNEL
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_223
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	embed_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	embedding = list(
		embed_chance=5,
		fall_chance=1,
		jostle_chance=1,
		ignore_throwspeed_threshold=TRUE,
		pain_stam_pct=0.5,
		pain_mult=5,
		jostle_pain_mult=6,
		rip_time=10,
		embed_chance_turf_mod=100,
		projectile_payload = /obj/item/shrapnel/bullet/a556/microshrapnel
		)

/* 5.56 simple
 * DAMAGE: 25
 * STAMIN: 5
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/a556/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"
	damage = BULLET_DAMAGE_RIFLE_223_HANDLOAD
	stamina = BULLET_STAMINA_RIFLE_223
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_223_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_223_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_223_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_223_HANDLOAD * 0.3
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/*
/obj/item/projectile/bullet/a556/uraniumtipped
	name = "5.56 uranium-tipped bullet"
	damage = -9
	irradiate = 300
*/

//////////////////////
// 4.73 MM CASELESS //
//////////////////////

/* * * * * * * *
 * Light Rifle Bullet that ive never seen ingame
 * Match - no surplus / improvised
 * Rubber
 * Incendiary
 * Anti-mob?
 * Explosive
 * High velocity?
 * * * * * * * */

/* 4.73 fmj
 * DAMAGE: 31.25
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/a473
	name = "4.73 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_473 //30
	damage_list = list("25" = 25, "30" = 35, "35" = 30, "40" = 5, "41" = 1, "42" = 1, "43" = 1, "44" = 1, "45" = 1,)
	stamina = BULLET_STAMINA_RIFLE_473
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_473

	wound_bonus = BULLET_WOUND_RIFLE_473
	bare_wound_bonus = BULLET_WOUND_RIFLE_473_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_473
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 4.73 rubber
 * DAMAGE: 2.5
 * STAMIN: 12
 * RECOIL: 1
 * WOUNDS: 7.5
 * WNAKED: 5.7
 */
/obj/item/projectile/bullet/a473/rubber
	name = "4.73 polyurethane bullet"
	damage = RUBBERY_DAMAGE_RIFLE_473
	stamina = RUBBERY_STAMINA_RIFLE_473
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_RIFLE_473

	wound_bonus = RUBBERY_WOUND_RIFLE_473
	bare_wound_bonus = BULLET_WOUND_RIFLE_473_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_473
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* 4.73 fire
 * DAMAGE: 12.5
 * STAMIN: 12
 * RECOIL: 1
 * WOUNDS: 6.25
 * WNAKED: 0
 */
/obj/item/projectile/bullet/a473/incendiary
	name = "4.73 tracer bullet"
	damage = BULLET_DAMAGE_RIFLE_473 * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_RIFLE_473 * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_473

	wound_bonus = BULLET_WOUND_RIFLE_473 * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_RIFLE_473_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_473
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE
	var/fire_stacks = 3

/obj/item/projectile/bullet/a473/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/*
/obj/item/projectile/bullet/a473/uraniumtipped
	name = "4.73 U-235 bullet"
	damage = -2
	irradiate = 300
*/

/* 4.73 dumdum
 * DAMAGE: 31.25 * 2 vs mobs
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/a473/dumdum
	name = "4.73 flat-nose bullet"
	damage = BULLET_DAMAGE_RIFLE_473
	stamina = BULLET_STAMINA_RIFLE_473
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_473

	wound_bonus = BULLET_WOUND_RIFLE_473
	bare_wound_bonus = BULLET_WOUND_RIFLE_473_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_473
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	supereffective_damage = BULLET_DAMAGE_RIFLE_473 * 2
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot")

/* 4.73 explosive
 * DAMAGE: 15
 * STAMIN: 3
 * RECOIL: 1
 * WOUNDS: 12
 * WNAKED: 7
 */
/obj/item/projectile/bullet/a473/explosive
	name = "4.73 explosive bullet"
	damage = BULLET_DAMAGE_RIFLE_473 * BULLET_DAMAGE_EXPLOSIVE
	stamina = BULLET_STAMINA_RIFLE_473 * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_473

	wound_bonus = BULLET_WOUND_RIFLE_473 * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_RIFLE_473_NAKED_MULT * BULLET_NAKED_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_473
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/a473/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	if(prob(10))
		explosion(target, 0, 0, 1, 1, adminlog = FALSE, flame_range = 0)
	else
		explosion(target, 0, 0, 0, 1, adminlog = FALSE, flame_range = 1) //no boom, just flame and flash

/* 4.73 fmj
 * DAMAGE: 12
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/a473/shock
	name = "4.73mm shock bullet"
	damage = BULLET_DAMAGE_RIFLE_473 * BULLET_DAMAGE_SHOCK
	stamina = BULLET_STAMINA_RIFLE_473 * BULLET_STAMINA_SHOCK
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_473

	wound_bonus = BULLET_WOUND_RIFLE_473 * BULLET_WOUND_SHOCK
	bare_wound_bonus = BULLET_WOUND_RIFLE_473_NAKED_MULT * BULLET_NAKED_WOUND_SHOCK
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_473
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/a473/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

/* 4.73 fmj
 * DAMAGE: 31.25
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/a473/hv
	name = "4.73mm highvelocity bullet"
	damage = BULLET_DAMAGE_RIFLE_473
	stamina = BULLET_STAMINA_RIFLE_473
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_473

	wound_bonus = BULLET_WOUND_RIFLE_473
	bare_wound_bonus = BULLET_WOUND_RIFLE_473_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_473
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	hitscan = TRUE

////////////////
// 5 MM rifle //
////////////////

/* * * * * * * *
 * High Velocity Light Rifle Bullet
 * Match - no surplus / improvised
 * Shock
 * * * * * * * */

/* 5mm fmj
 * DAMAGE: 30
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/m5mm
	name = "5mm bullet"
	damage = BULLET_DAMAGE_RIFLE_5MM //30
	damage_list = list("25" = 30, "30" = 30, "35" = 30, "40" = 5, "45" = 3, "50" = 2)
	stamina = BULLET_STAMINA_RIFLE_5MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_5MM

	wound_bonus = BULLET_WOUND_RIFLE_5MM
	bare_wound_bonus = BULLET_WOUND_RIFLE_5MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_5MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 5mm fmj
 * DAMAGE: more
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/*
/obj/item/projectile/bullet/m5mm/match
	name = "5mm bullet"
	damage = BULLET_DAMAGE_RIFLE_5MM_MATCH
	stamina = BULLET_STAMINA_RIFLE_5MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_5MM_MATCH

	wound_bonus = BULLET_WOUND_RIFLE_5MM_MATCH
	bare_wound_bonus = BULLET_WOUND_RIFLE_5MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_5MM_MATCH
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
*/
/* 5mm fmj
 * DAMAGE: less
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/m5mm/improvised
	name = "handload 5mm bullet"
	damage = BULLET_DAMAGE_RIFLE_5MM_HANDLOAD
	damage_list = list("22" = 30, "27" = 30, "30" = 30, "37" = 5, "41" = 3, "50" = 2)
	stamina = BULLET_STAMINA_RIFLE_5MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_5MM_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_5MM_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_5MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_5MM_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 5mm simple
 * DAMAGE: 31.25
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/m5mm/simple //for simple mobs, separate to allow balancing
	name = "5mm bullet"

/* 5mm shock
 * DAMAGE: 12
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/m5mm/shock
	name = "5mm shock bullet"
	damage = BULLET_DAMAGE_RIFLE_5MM * BULLET_DAMAGE_SHOCK
	stamina = BULLET_STAMINA_RIFLE_5MM * BULLET_STAMINA_SHOCK
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_5MM

	wound_bonus = BULLET_WOUND_RIFLE_5MM * BULLET_WOUND_SHOCK
	bare_wound_bonus = BULLET_WOUND_RIFLE_5MM_NAKED_MULT * BULLET_NAKED_WOUND_SHOCK
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_5MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/m5mm/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

//////////////////////////
// 5 MM minigun special //
//////////////////////////

/* 5mm fmj
 * DAMAGE: 20
 * STAMIN: 6.25
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 3.75
 */
// Miniguns are gonna *fuck* --turns out yup, they do
/obj/item/projectile/bullet/c5mm
	name = "5mm bullet"
	damage = BULLET_DAMAGE_RIFLE_5MM
	damage_list = list("25" = 30, "30" = 30, "35" = 30, "40" = 5, "45" = 3, "50" = 2)
	stamina = BULLET_STAMINA_RIFLE_5MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_5MM

	wound_bonus = BULLET_WOUND_RIFLE_5MM
	bare_wound_bonus = BULLET_WOUND_RIFLE_5MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_5MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT


////////////////////
// 7.62 MM & .308 //
////////////////////

/* * * * * * * *
 * Baseline Medium Rifle Bullet (and... only)
 * Match
 * Surplus
 * Improvised
 * Rubber
 * Microshrapnel
 * * * * * * * */

/* 7.62mm fmj
 * DAMAGE: 56
 * STAMIN: 56
 * RECOIL: 2
 * WOUNDS: 25
 * WNAKED: 15
 */
/*
/obj/item/projectile/bullet/a762
	name = "7.62 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_308_MATCH
	stamina = BULLET_STAMINA_RIFLE_308
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308_MATCH

	wound_bonus = BULLET_WOUND_RIFLE_308_MATCH
	bare_wound_bonus = BULLET_WOUND_RIFLE_308_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_308_MATCH
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
*/
/* 7.62mm surplus
 * DAMAGE: 45
 * STAMIN: 45
 * RECOIL: 2
 * WOUNDS: 25
 * WNAKED: 15
 */
/obj/item/projectile/bullet/a308
	name = ".308 bullet"
	damage = BULLET_DAMAGE_RIFLE_308 //45
	damage_list = list("30" = 20, "40" = 50, "48" = 30, "50" = 5, "52" = 3, "55"= 2)
	stamina = BULLET_STAMINA_RIFLE_308
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308

	wound_bonus = BULLET_WOUND_RIFLE_308
	bare_wound_bonus = BULLET_WOUND_RIFLE_308_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_308
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 7.62mm handloaded
 * DAMAGE: 33
 * STAMIN: 33
 * RECOIL: 2
 * WOUNDS: 15
 * WNAKED: 15
 */
/obj/item/projectile/bullet/a308/improvised
	name = "handloaded .308 bullet"
	damage = BULLET_DAMAGE_RIFLE_308_HANDLOAD
	damage_list = list("22" = 40, "28" = 45, "45" = 30, "48" = 5, "50" = 3, "55" = 2)
	stamina = BULLET_STAMINA_RIFLE_308
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_308_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_308_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_308_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 7.62mm simple mob projectile
 * DAMAGE: 45
 * STAMIN: 45
 * RECOIL: 2
 * WOUNDS: 25
 * WNAKED: 15
 */
/obj/item/projectile/bullet/a308/improvised/simple //for simple mobs, separate to allow balancing
	name = ".308 bullet"
	damage_list = list("22" = 40, "28" = 45, "45" = 30, "48" = 5, "50" = 3, "55" = 2)
	spread = BULLET_SPREAD_HANDLOAD*15 //30 degree firing arc, might miss at long range
	pixels_per_second = BULLET_SPEED_PISTOL_45ACP_HANDLOAD * 0.7

/* 7.62mm rubber
 * DAMAGE: 4.5
 * STAMIN: 135
 * RECOIL: 2
 * WOUNDS: 40
 * WNAKED: 30
 */
/obj/item/projectile/bullet/a308/rubber
	name = ".308 rubber bullet"
	damage = RUBBERY_DAMAGE_RIFLE_308
	stamina = RUBBERY_STAMINA_RIFLE_308
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_RIFLE_308

	wound_bonus = RUBBERY_WOUND_RIFLE_308
	bare_wound_bonus = BULLET_WOUND_RIFLE_308_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_308
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* 7.62mm embed
 * DAMAGE: 12
 * STAMIN: 2.5
 * RECOIL: 2
 * WOUNDS: 12
 * WNAKED: 9
 */
/obj/item/projectile/bullet/a308/microshrapnel
	name = ".308 microshrapnel bullet"
	damage = BULLET_DAMAGE_RIFLE_308 * BULLET_DAMAGE_MICROSHRAPNEL
	stamina = BULLET_STAMINA_RIFLE_308 * BULLET_STAMINA_MICROSHRAPNEL
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_308

	wound_bonus = BULLET_WOUND_RIFLE_308 * BULLET_WOUND_MICROSHRAPNEL
	bare_wound_bonus = BULLET_WOUND_RIFLE_308_NAKED_MULT * BULLET_NAKED_WOUND_MICROSHRAPNEL
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_308
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	embed_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	embedding = list(embed_chance=12, fall_chance=1, jostle_chance=1, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.3, pain_mult=5, jostle_pain_mult=6, rip_time=10, embed_chance_turf_mod=100, projectile_payload = /obj/item/shrapnel/bullet/a762/microshrapnel)

/*
/obj/item/projectile/bullet/a762/uraniumtipped
	name = "7.62 uranium-tipped bullet"
	damage = -10
	armour_penetration = 0
	irradiate = 300
*/
/* .30-06
	60 base damage
*/

/obj/item/projectile/bullet/a3006
	name = ".30-06 bullet"
	damage = BULLET_DAMAGE_RIFLE_3006 //60
	damage_list = list("45" = 40, "60" = 45, "65" = 5, "68" = 5, "70" = 5)
	stamina = BULLET_STAMINA_RIFLE_3006
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_3006

	wound_bonus = BULLET_WOUND_RIFLE_3006
	bare_wound_bonus = BULLET_WOUND_RIFLE_3006_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_3006
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/a3006/improvised
	name = "handloaded .3006 bullet"
	damage = BULLET_DAMAGE_RIFLE_3006_HANDLOAD
	damage_list = list("52" = 40, "56" = 45, "61" = 5, "64" = 5, "70" = 5)
	stamina = BULLET_STAMINA_RIFLE_3006
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_3006_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_3006_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_3006_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_3006_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/a3006/rubber
	name = ".3006 rubber bullet"
	damage = RUBBERY_DAMAGE_RIFLE_3006
	stamina = RUBBERY_STAMINA_RIFLE_3006
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_RIFLE_3006

	wound_bonus = RUBBERY_WOUND_RIFLE_3006
	bare_wound_bonus = BULLET_WOUND_RIFLE_3006_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_3006
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/obj/item/projectile/bullet/heavyneedle //Heavy duty PVE-PVP round. 65 damage. superb bane, used with very low capacity needle guns. Think 1-4 capacity firearms.
	name = " Ruby needle shard"
	icon_state = "heavyneedle"
	damage = BULLET_DAMAGE_RIFLE_HEAVYNEEDLE
	damage_list = list("65" = 55, "70" = 15, "75" = 0.5)
	stamina = BULLET_STAMINA_RIFLE_50MG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_50MG

	wound_bonus = BULLET_WOUND_RIFLE_50MG
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	pixels_per_second = BULLET_SPEED_RIFLE_50MG

	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	supereffective_damage = 90
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/////////
// .50 //
/////////

/* * * * * * * *
* Heavy Rifle Bullet
* Match
* Surplus
* Improvised
* Incendiary
* Explosive
* Rubber
* Penetrator
* Poison
* * * * * * * */
/obj/item/projectile/bullet/a50MG
	name = ".50MG slug"
	damage = BULLET_DAMAGE_RIFLE_50MG //75
	damage_list = list("85" = 15, "96" = 55, "110" = 15, "120" = 10, "140" = 5)
	stamina = BULLET_STAMINA_RIFLE_50MG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_50MG

	wound_bonus = BULLET_WOUND_RIFLE_50MG
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* .50MG surplus
 * DAMAGE: 75
 * STAMIN: 140
 * RECOIL: 2
 * WOUNDS: 40
 * WNAKED: 30
 */
/*
/obj/item/projectile/bullet/a50MG/surplus
	name = "surplus .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_50MG
	stamina = BULLET_STAMINA_RIFLE_50MG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_50MG

	wound_bonus = BULLET_WOUND_RIFLE_50MG
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
*/
/* .50MG handloaded
 * DAMAGE: 56
 * STAMIN: 84
 * RECOIL: 2
 * WOUNDS: 30
 * WNAKED: 30
 */
/obj/item/projectile/bullet/a50MG/improvised
	name = "handloaded .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_50MG_HANDLOAD
	damage_list = list("20" = 15, "30" = 30, "75" = 40, "77" = 5, "80" = 5, "100" = 5)
	stamina = BULLET_STAMINA_RIFLE_50MG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_50MG_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_50MG_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* .50MG fire
 * DAMAGE: 37
 * STAMIN: 25
 * RECOIL: 2
 * WOUNDS: 40
 * WNAKED: 0
 */
/obj/item/projectile/bullet/a50MG/incendiary
	name = "incendiary .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_50MG * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_RIFLE_50MG * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_50MG

	wound_bonus = BULLET_WOUND_RIFLE_50MG * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE
	var/fire_stacks = 4

/obj/item/projectile/bullet/a50MG/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/* .50MG explode
 * DAMAGE: 37
 * STAMIN: 25
 * RECOIL: 2
 * WOUNDS: 80
 * WNAKED: 60
 */
/obj/item/projectile/bullet/a50MG/explosive
	name = "explosive .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_50MG * BULLET_DAMAGE_EXPLOSIVE
	stamina = BULLET_STAMINA_RIFLE_50MG * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_50MG

	wound_bonus = BULLET_WOUND_RIFLE_50MG * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT * BULLET_NAKED_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/a50MG/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 1, 1, 1)

/* .50MG rubber
 * DAMAGE: 7
 * STAMIN: 225 gnight
 * RECOIL: 2
 * WOUNDS: 200
 * WNAKED: 150
 */
/obj/item/projectile/bullet/a50MG/rubber
	name = "rubber .50MG slug"
	damage = RUBBERY_DAMAGE_RIFLE_50MG
	stamina = RUBBERY_STAMINA_RIFLE_50MG
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_RIFLE_50MG

	wound_bonus = RUBBERY_WOUND_RIFLE_50MG
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* .50MG rubber-penetrator
 * DAMAGE: 7
 * STAMIN: 225
 * RECOIL: 2
 * WOUNDS: 200
 * WNAKED: 150
 */
/obj/item/projectile/bullet/a50MG/penetrator
	name = "penetrator .50MG slug"
	damage = RUBBERY_DAMAGE_RIFLE_50MG
	stamina = RUBBERY_STAMINA_RIFLE_50MG
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_RIFLE_50MG

	wound_bonus = RUBBERY_WOUND_RIFLE_50MG
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want
	movement_type = FLYING | UNSTOPPABLE

/*
/obj/item/projectile/bullet/a50MG/uraniumtipped
	name = "12.7mm uranium-tipped bullet"
	damage = -15
	armour_penetration = 0.2
	irradiate = 500
*/

/* .50MG poison
 * DAMAGE: 30
 * STAMIN: 25
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/a50MG/contam
	name = "contaminated .50MG bullet"
	damage = BULLET_DAMAGE_RIFLE_50MG * BULLET_DAMAGE_POISON
	stamina = BULLET_STAMINA_RIFLE_50MG * BULLET_STAMINA_POISON
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_50MG

	wound_bonus = BULLET_WOUND_RIFLE_50MG * BULLET_WOUND_POISON
	bare_wound_bonus = BULLET_WOUND_RIFLE_50MG_NAKED_MULT * BULLET_NAKED_WOUND_POISON
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_50MG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	var/smoke_radius = 3

/obj/item/projectile/bullet/a50MG/contam/Initialize()
	. = ..()
	create_reagents(15, NO_REACT, NO_REAGENTS_VALUE)
	reagents.add_reagent(/datum/reagent/toxin/metabtoxin, 15)

/obj/item/projectile/bullet/a50MG/contam/on_hit(atom/target, blocked = FALSE)
	var/location = get_turf(src)
	var/datum/effect_system/smoke_spread/chem/S = new
	S.attach(location)
	playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
	if(S)
		S.set_up(src.reagents, smoke_radius, location, 0)
		S.start()
	..()

////////////
// .45-70 //
////////////

/* * * * * * * *
 * Light Heavy Rifle Bullet
 * Match
 * Surplus
 * Improvised
 * Explosive
 * Improvised
 * Rubber
 * Microshrapnel
 * * * * * * * */

/* .45-70 match
 * DAMAGE: 70
 * STAMIN: 70
 * RECOIL: 1
 * WOUNDS: 25
 * WNAKED: 15
 */
/obj/item/projectile/bullet/c4570
	name = ".45-70 bullet"
	damage = BULLET_DAMAGE_RIFLE_4570 //60
	damage_list = list("40" = 20, "50" = 25, "60" = 40, "70" = 10, "80" = 10)
	stamina = BULLET_STAMINA_RIFLE_4570
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_4570

	wound_bonus = BULLET_WOUND_RIFLE_4570
	bare_wound_bonus = BULLET_WOUND_RIFLE_4570_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_4570
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* .45-70 surplus
 * DAMAGE: 56
 * STAMIN: 56
 * RECOIL: 1
 * WOUNDS: 25
 * WNAKED: 15
 */
/*
/obj/item/projectile/bullet/c4570/surplus
	name = ".45-70 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_4570
	stamina = BULLET_STAMINA_RIFLE_4570
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_4570

	wound_bonus = BULLET_WOUND_RIFLE_4570
	bare_wound_bonus = BULLET_WOUND_RIFLE_4570_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_4570
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
*/
/* .45-70 handloaded
 * DAMAGE: 42 // cant kill a ghoul
 * STAMIN: 33
 * RECOIL: 1
 * WOUNDS: 15
 * WNAKED: 15
 */
/obj/item/projectile/bullet/c4570/improvised
	name = ".45-70 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_4570_HANDLOAD
	damage_list = list("30" = 35, "40" = 30, "60" = 40, "70" = 5)
	stamina = BULLET_STAMINA_RIFLE_4570
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_4570_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_4570_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_4570_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_4570_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* .45-70 explode
 * DAMAGE: 35
 * STAMIN: 28
 * RECOIL: 1
 * WOUNDS: 50
 * WNAKED: 30
 */
/obj/item/projectile/bullet/c4570/explosive
	name = ".45-70 explosive bullet"
	damage = BULLET_DAMAGE_RIFLE_4570 * BULLET_DAMAGE_EXPLOSIVE
	stamina = BULLET_STAMINA_RIFLE_4570 * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_4570

	wound_bonus = BULLET_WOUND_RIFLE_4570 * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_RIFLE_4570_NAKED_MULT * BULLET_NAKED_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_4570
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c4570/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 1, 1, flame_range = 1)

/* .45-70 acid
 * DAMAGE: 35
 * STAMIN: 28
 * RECOIL: 1
 * WOUNDS: 50
 * WNAKED: 30
 */
/obj/item/projectile/bullet/c4570/acid
	name = ".45-70 acid-tipped bullet"
	damage = BULLET_DAMAGE_RIFLE_4570 * BULLET_DAMAGE_ACID
	stamina = BULLET_STAMINA_RIFLE_4570 * BULLET_STAMINA_ACID
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_4570

	wound_bonus = BULLET_WOUND_RIFLE_4570 * BULLET_WOUND_ACID
	bare_wound_bonus = BULLET_WOUND_RIFLE_4570_NAKED_MULT * BULLET_NAKED_WOUND_ACID
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_4570
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE
	var/acid_type = /datum/reagent/toxin/acid/fluacid

/obj/item/projectile/bullet/c4570/acid/Initialize()
	. = ..()
	create_reagents(10, NO_REACT, NO_REAGENTS_VALUE)
	reagents.add_reagent(acid_type, 10)

/obj/item/projectile/bullet/c4570/acid/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		reagents.reaction(M, TOUCH)
		reagents.trans_to(M, reagents.total_volume)

/* .45-70 rubber
 * DAMAGE: 7
 * STAMIN: 281
 * RECOIL: 1
 * WOUNDS: 125
 * WNAKED: 75
 */
/obj/item/projectile/bullet/c4570/knockback
	name = ".45-70 ultradense bullet"
	damage = RUBBERY_DAMAGE_RIFLE_4570
	stamina = RUBBERY_STAMINA_RIFLE_4570
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_RIFLE_4570

	wound_bonus = RUBBERY_WOUND_RIFLE_4570
	bare_wound_bonus = BULLET_WOUND_RIFLE_4570_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_4570
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/obj/item/projectile/bullet/c4570/knockback/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target) && prob(50))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 2, 3)

/////////////////////////
//2 MM ELECTROMAGNETIC //
/////////////////////////

/* * * * * * * *
 * Super duper fast hitscan penetrator knockback painbeam
 * Wall piercing
 * Bouncy (and player piercing)
 * * * * * * * */

#define BULLET_GAUSS_SPEED_MULT 10 // lol

/* 2mmEC match
 * DAMAGE: 37
 * STAMIN: 7
 * RECOIL: 4.5
 * WOUNDS: 6
 * WNAKED: 3
 * Does 93 extra damage to mobs. rip~
 */

/obj/item/projectile/bullet/c2mm
	name = "2mm gauss projectile"
	damage = BULLET_DAMAGE_RIFLE_GAUSS //20
	damage_list = list("1" = 0.5, "10" = 33, "20" = 33, "25" = 33, "999" = 0.5)
	stamina = BULLET_STAMINA_RIFLE_GAUSS
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_GAUSS

	wound_bonus = BULLET_WOUND_RIFLE_GAUSS
	bare_wound_bonus = BULLET_WOUND_RIFLE_GAUSS_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_GAUSS
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	movement_type = FLYING | UNSTOPPABLE
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/blue
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue
	supereffective_damage = BULLET_DAMAGE_RIFLE_50MG_MATCH // hmm
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")
	/// Reduces damage by this much when it hits a thing
	var/per_wall_mult = 0.8

/obj/item/projectile/bullet/c2mm/process_hit(turf/T, atom/target, qdel_self, hit_something = FALSE)
	if(isliving(target) && damage >= (initial(damage) * 0.5))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 2, 3)
	if(isclosedturf(T) || ismovable(target))
		damage = max(damage * per_wall_mult, 0.5)
	..()

/* 2mmEC blender
 * DAMAGE: 37
 * STAMIN: 7
 * RECOIL: 4.5
 * WOUNDS: 6
 * WNAKED: 3
 * Does 93 extra damage to mobs. rip~
 * Also guaranteed to kill you and your friends
 */
/obj/item/projectile/bullet/c2mm/blender //welcome to pain town
	name = "2mm blender projectile"

	movement_type = FLYING

	pass_flags = PASSTABLE
	ricochets_max = 9 //ain't called the 'blender' for nothin'
	ricochet_incidence_leeway = 0
	ricochet_decay_damage = 1
	ricochet_decay_chance = 11
	ricochet_chance = 100

/obj/item/projectile/bullet/c2mm/blender/process_hit(turf/T, atom/target, qdel_self, hit_something = FALSE)
	if(ismovable(target) || ismovable(T))
		temporary_unstoppable_movement = TRUE
		ENABLE_BITFIELD(movement_type, UNSTOPPABLE)
	..()

#undef BULLET_GAUSS_SPEED_MULT

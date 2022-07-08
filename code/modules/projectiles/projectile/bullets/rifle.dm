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

/obj/item/projectile/bullet/a556
	name = "5.56 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT

/obj/item/projectile/bullet/a556/match // used by mobs currently
	name = "5.56 match bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT * 2

/obj/item/projectile/bullet/a556/sport
	name = "surplus .223 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT


/obj/item/projectile/bullet/a556/improv
	name = "handloaded .223 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_HANDLOAD_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_HANDLOAD_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_HANDLOAD_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT

/obj/item/projectile/bullet/a556/rubber
	name = "5.56 rubber bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = RUBBERY_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	bare_wound_bonus = RUBBERY_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/a556/microshrapnel
	name = "5.56 microshrapnel bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_DAMAGE_MICROSHRAPNEL
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_STAMINA_MICROSHRAPNEL
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_WOUND_MICROSHRAPNEL
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_MICROSHRAPNEL
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT

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
	
/obj/item/projectile/bullet/a556/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT

/obj/item/projectile/bullet/a556/ap/simple //for simple mobs, separate to allow balancing
	name = "5.56 bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT
/*
/obj/item/projectile/bullet/a556/uraniumtipped
	name = "5.56 uranium-tipped bullet"
	damage = -9
	armour_penetration = 0
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

/obj/item/projectile/bullet/a473
	name = "4.73 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT

/obj/item/projectile/bullet/a473/rubber
	name = "4.73 polyurethane bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = RUBBERY_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT
	bare_wound_bonus = RUBBERY_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/a473/incendiary
	name = "4.73 tracer bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_DAMAGE_FIRE
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_SURPLUS_MULT * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT
	sharpness = SHARP_NONE
	var/fire_stacks = 3
	zone_accuracy_factor = 100

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
	armour_penetration = 0.3
	irradiate = 300
*/

/obj/item/projectile/bullet/a473/dumdum
	name = "4.73 flat-nose bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT
	supereffective_damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot")

/obj/item/projectile/bullet/a473/explosive
	name = "4.73 explosive bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT * BULLET_DAMAGE_EXPLOSIVE
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT

/obj/item/projectile/bullet/a473/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	if(prob(10))
		explosion(target, 0, 0, 1, 1, adminlog = FALSE, flame_range = 0)
	else
		explosion(target, 0, 0, 0, 1, adminlog = FALSE, flame_range = 1) //no boom, just flame and flash

/obj/item/projectile/bullet/a473/shock
	name = "4.73mm shock bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_DAMAGE_SHOCK
	stamina = RUBBERY_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_STAMINA_SHOCK
	spread = BULLET_SPREAD_SURPLUS
	damage_type = BURN // still checks bullet resist
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_WOUND_SHOCK
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_NAKED_WOUND_SHOCK
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/a473/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

/obj/item/projectile/bullet/a473/hv
	name = "4.73mm highvelocity bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT	
	hitscan = TRUE

////////////////
// 5 MM rifle //
////////////////

/* * * * * * * *
 * High Velocity Light Rifle Bullet
 * Match - no surplus / improvised
 * Shock
 * * * * * * * */

/obj/item/projectile/bullet/m5mm  //for rifles// one of the only bullets to have integral AP
	name = "5mm bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT * 2

/obj/item/projectile/bullet/m5mm/simple //for simple mobs, separate to allow balancing
	name = "5mm bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT * 2

/obj/item/projectile/bullet/m5mm/shock
	name = "5mm shock bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_DAMAGE_SHOCK
	stamina = RUBBERY_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_STAMINA_SHOCK
	spread = BULLET_SPREAD_SURPLUS
	damage_type = BURN // still checks bullet resist
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_WOUND_SHOCK
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_NAKED_WOUND_SHOCK
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT * 2
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/m5mm/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

//////////////////////////
// 5 MM minigun special //
//////////////////////////

// Miniguns are gonna *fuck*
/obj/item/projectile/bullet/c5mm
	name = "5mm bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LIGHT

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	
	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT * 2


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

/obj/item/projectile/bullet/a762
	name = "7.62 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_MEDIUM * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_MEDIUM * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_MEDIUM

	wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_MEDIUM
	
	pixels_per_second = BULLET_SPEED_RIFLE_MEDIUM

//.308 Winchester
/obj/item/projectile/bullet/a762/sport
	name = "surplus .308 bullet"
	damage = BULLET_DAMAGE_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	stamina = BULLET_STAMINA_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_MEDIUM

	wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_MEDIUM
	
	pixels_per_second = BULLET_SPEED_RIFLE_MEDIUM

/obj/item/projectile/bullet/a762/improv
	name = "handloaded .308 bullet"
	damage = BULLET_DAMAGE_RIFLE_MEDIUM * BULLET_HANDLOAD_MULT
	stamina = BULLET_STAMINA_RIFLE_MEDIUM * BULLET_HANDLOAD_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_MEDIUM

	wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_HANDLOAD_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_MEDIUM
	
	pixels_per_second = BULLET_SPEED_RIFLE_MEDIUM

/obj/item/projectile/bullet/a762/rubber
	name = "7.62 rubber bullet"
	damage = BULLET_DAMAGE_RIFLE_MEDIUM * BULLET_SURPLUS_MULT * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_MEDIUM

	wound_bonus = RUBBERY_WOUND_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	bare_wound_bonus = RUBBERY_WOUND_RIFLE_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_MEDIUM
	
	pixels_per_second = BULLET_SPEED_RIFLE_MEDIUM
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/a762/microshrapnel
	name = "7.62 microshrapnel bullet"
	damage = BULLET_DAMAGE_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_DAMAGE_MICROSHRAPNEL
	stamina = BULLET_STAMINA_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_STAMINA_MICROSHRAPNEL
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_MEDIUM

	wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_SURPLUS_MULT * BULLET_WOUND_MICROSHRAPNEL
	bare_wound_bonus = BULLET_WOUND_RIFLE_LIGHT * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_MICROSHRAPNEL
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_LIGHT

	embed_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT
	embedding = list(embed_chance=12, fall_chance=1, jostle_chance=1, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.3, pain_mult=5, jostle_pain_mult=6, rip_time=10, embed_chance_turf_mod=100, projectile_payload = /obj/item/shrapnel/bullet/a762/microshrapnel)

/obj/item/projectile/bullet/a762/sport/simple //for simple mobs, separate to allow balancing
	name = ".308 bullet"
	damage = BULLET_DAMAGE_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	stamina = BULLET_STAMINA_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_MEDIUM

	wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_SURPLUS_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_MEDIUM * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_MEDIUM
	
	pixels_per_second = BULLET_SPEED_RIFLE_MEDIUM

/*
/obj/item/projectile/bullet/a762/uraniumtipped
	name = "7.62 uranium-tipped bullet"
	damage = -10
	armour_penetration = 0
	irradiate = 300
*/

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
	name = "match .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_MATCH_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_MATCH_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_MATCH_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a50MG/surplus
	name = "surplus .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_SURPLUS_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_SURPLUS_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a50MG/improv
	name = "handloaded .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_HANDLOAD_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_HANDLOAD_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_HANDLOAD_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a50MG/incendiary
	name = "incendiary .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_DAMAGE_FIRE
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_SURPLUS_MULT * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY
	sharpness = SHARP_NONE
	var/fire_stacks = 4
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a50MG/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/obj/item/projectile/bullet/a50MG/explosive
	name = "explosive .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_DAMAGE_EXPLOSIVE
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_SURPLUS_MULT * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY

/obj/item/projectile/bullet/a50MG/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 1, 1, 1)

/obj/item/projectile/bullet/a50MG/rubber
	name = "rubber .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_SURPLUS_MULT * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_RIFLE_HEAVY * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = RUBBERY_WOUND_RIFLE_HEAVY * BULLET_SURPLUS_MULT
	bare_wound_bonus = RUBBERY_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/a50MG/penetrator
	name = "penetrator .50MG slug"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_SURPLUS_MULT * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_RIFLE_HEAVY * BULLET_SURPLUS_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = RUBBERY_WOUND_RIFLE_HEAVY * BULLET_SURPLUS_MULT
	bare_wound_bonus = RUBBERY_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY
	sharpness = SHARP_NONE
	movement_type = FLYING | UNSTOPPABLE

/*
/obj/item/projectile/bullet/a50MG/uraniumtipped
	name = "12.7mm uranium-tipped bullet"
	damage = -15
	armour_penetration = 0.2
	irradiate = 500
*/

/obj/item/projectile/bullet/a50MG/contam
	name = "contaminated .50MG bullet"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_DAMAGE_POISON
	stamina = RUBBERY_STAMINA_PISTOL_MEDIUM * BULLET_SURPLUS_MULT * BULLET_STAMINA_POISON
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_WOUND_POISON
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_NAKED_WOUND_POISON
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY
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

#define BULLET_4570_DAMAGE_MULT 0.75 //30 damage, 4 hits, but it slaps
#define BULLET_4570_STAMINA_MULT 0.50
#define BULLET_4570_WOUND_MULT 0.50
#define BULLET_4570_NAKED_WOUND_MULT 0.50
#define BULLET_4570_SPEED_MULT 0.50
#define BULLET_4570_RECOIL_MULT 0.50

/obj/item/projectile/bullet/c4570
	name = ".45-70 match bullet"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_DAMAGE_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_STAMINA_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_HEAVY * BULLET_4570_RECOIL_MULT

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_4570_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_4570_SPEED_MULT

/obj/item/projectile/bullet/c4570/surplus
	name = ".45-70 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_4570_DAMAGE_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_4570_STAMINA_MULT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_HEAVY * BULLET_4570_RECOIL_MULT

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_SURPLUS_MULT * BULLET_4570_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_4570_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_4570_SPEED_MULT

/obj/item/projectile/bullet/c4570/improv
	name = ".45-70 FMJ bullet"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_HANDLOAD_MULT * BULLET_4570_DAMAGE_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_HANDLOAD_MULT * BULLET_4570_STAMINA_MULT
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_HEAVY * BULLET_4570_RECOIL_MULT

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_HANDLOAD_MULT * BULLET_4570_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_4570_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_4570_SPEED_MULT

/obj/item/projectile/bullet/c4570/explosive
	name = ".45-70 explosive bullet"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_DAMAGE_MULT * BULLET_DAMAGE_EXPLOSIVE
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_STAMINA_MULT * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_HEAVY * BULLET_4570_RECOIL_MULT

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_WOUND_MULT * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_4570_NAKED_WOUND_MULT * BULLET_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_4570_SPEED_MULT

/obj/item/projectile/bullet/c4570/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 1, 1, flame_range = 1)

/obj/item/projectile/bullet/c4570/acid
	name = ".45-70 acid-tipped bullet"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_DAMAGE_MULT * BULLET_DAMAGE_ACID
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_STAMINA_MULT * BULLET_STAMINA_ACID
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_HEAVY * BULLET_4570_RECOIL_MULT

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_WOUND_MULT * BULLET_WOUND_ACID
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_4570_NAKED_WOUND_MULT * BULLET_WOUND_ACID
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_4570_SPEED_MULT
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

/obj/item/projectile/bullet/c4570/knockback
	name = ".45-70 ultradense bullet"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_DAMAGE_MULT * RUBBERY_DAMAGE_MULT
	stamina = RUBBERY_STAMINA_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_STAMINA_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_HEAVY * BULLET_4570_RECOIL_MULT

	wound_bonus = RUBBERY_WOUND_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_4570_WOUND_MULT
	bare_wound_bonus = RUBBERY_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_4570_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_4570_SPEED_MULT
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c4570/knockback/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target) && prob(50))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 2, 3)

#undef BULLET_4570_DAMAGE_MULT
#undef BULLET_4570_STAMINA_MULT
#undef BULLET_4570_WOUND_MULT
#undef BULLET_4570_NAKED_WOUND_MULT
#undef BULLET_4570_SPEED_MULT

/////////////////////////
//2 MM ELECTROMAGNETIC //
/////////////////////////

/* * * * * * * *
 * Ultra Deadly Super Death Pellet
 * Overkill
 * Extremely Overkill
 * * * * * * * */

#define BULLET_GAUSS_DAMAGE_MULT 2 // 150 damage get rekt (LAGG NOTE: MIGHT BE TOO MUCH I THINK)
#define BULLET_GAUSS_STAMINA_MULT 2
#define BULLET_GAUSS_WOUND_MULT 5 // gonna feel that blender
#define BULLET_GAUSS_NAKED_WOUND_MULT 10 // lol
#define BULLET_GAUSS_SPEED_MULT 10 // lol

/obj/item/projectile/bullet/c2mm
	name = "2mm gauss projectile"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_GAUSS_DAMAGE_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_GAUSS_STAMINA_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_GAUSS_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_GAUSS_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_GAUSS_SPEED_MULT

/obj/item/projectile/bullet/c2mm/blender //welcome to pain town
	name = "2mm blender projectile"
	damage = BULLET_DAMAGE_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_GAUSS_DAMAGE_MULT
	stamina = BULLET_STAMINA_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_GAUSS_STAMINA_MULT
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_HEAVY

	wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_MATCH_MULT * BULLET_GAUSS_WOUND_MULT
	bare_wound_bonus = BULLET_WOUND_RIFLE_HEAVY * BULLET_NAKED_WOUND_MULT * BULLET_GAUSS_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY
	
	pixels_per_second = BULLET_SPEED_RIFLE_HEAVY * BULLET_GAUSS_SPEED_MULT

	pass_flags = PASSTABLE
	ricochets_max = 9 //ain't called the 'blender' for nothin'
	ricochet_incidence_leeway = 130
	ricochet_decay_damage = 1
	ricochet_decay_chance = 11
	ricochet_chance = 100
	var/collats = 3

/obj/item/projectile/bullet/c2mm/blender/process_hit(turf/T, atom/target, qdel_self, hit_something = FALSE)
	if(isliving(target) && collats)
		collats--
		temporary_unstoppable_movement = TRUE
		ENABLE_BITFIELD(movement_type, UNSTOPPABLE)
	..()

#undef BULLET_GAUSS_DAMAGE_MULT
#undef BULLET_GAUSS_STAMINA_MULT
#undef BULLET_GAUSS_WOUND_MULT
#undef BULLET_GAUSS_NAKED_WOUND_MULT
#undef BULLET_GAUSS_SPEED_MULT

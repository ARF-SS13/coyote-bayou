////////////////////
// .22 LONG RIFLE //
////////////////////

/* * * * * * * *
 * Light Light Pistol Bullet
 * Surplus only
 * Shock
 * * * * * * * */

/* .22 bullet
 * DAMAGE: 15
 * STAMIN: 7.5
 * RECOIL: 0
 * WOUNDS: 1.25
 * WNAKED: 5.6
 */

/obj/item/projectile/bullet/c22
	name = ".22lr bullet"
	damage = BULLET_DAMAGE_PISTOL_22
	damage_list = list("10" = 5, "12" = 25, "15" = 50, "20" = 20)
	stamina = BULLET_STAMINA_PISTOL_22
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22

	wound_bonus = BULLET_WOUND_PISTOL_22
	bare_wound_bonus = BULLET_WOUND_PISTOL_22_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* .22 rubber
 * DAMAGE: 1.5
 * STAMIN: 30
 * RECOIL: 0
 * WOUNDS: 1.25
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c22/rubber
	name = ".22lr rubber bullet"
	damage = RUBBERY_DAMAGE_PISTOL_22
	stamina = RUBBERY_STAMINA_PISTOL_22
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_PISTOL_22

	wound_bonus = RUBBERY_WOUND_PISTOL_22
	bare_wound_bonus = BULLET_WOUND_PISTOL_22_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* .22 EMP
 * DAMAGE: 0.75
 * STAMIN: 15
 * RECOIL: 0
 * WOUNDS: 1.25
 * WNAKED: 0
 */
/obj/item/projectile/bullet/c22/shock
	name = ".22lr shock bullet"
	damage = BULLET_DAMAGE_PISTOL_22 * BULLET_DAMAGE_SHOCK
	stamina = BULLET_STAMINA_PISTOL_22 * BULLET_STAMINA_SHOCK
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22

	wound_bonus = BULLET_WOUND_PISTOL_22 * BULLET_WOUND_SHOCK
	bare_wound_bonus = BULLET_WOUND_PISTOL_22_NAKED_MULT * BULLET_NAKED_WOUND_SHOCK
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_22
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE

/obj/item/projectile/bullet/c22/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

//////////
// 9 MM //
//////////

/* * * * * * * *
 * Baseline Light Pistol Bullet
 * Surplus, improvised, no match (yet)
 * Acid rounds
 * Fire rounds
 * * * * * * * */

/* 9mm surplus
 * DAMAGE: 20
 * STAMIN: 10
 * RECOIL: 0.5
 * WOUNDS: 5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c9mm
	name = "9mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_9MM
	damage_list = list("20" = 10, "23" = 10, "25" = 50, "26" = 15, "30" = 15)
	stamina = BULLET_STAMINA_PISTOL_9MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = BULLET_WOUND_PISTOL_9MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 9mm handload
 * DAMAGE: 15
 * STAMIN: 7.5
 * RECOIL: 0.5
 * WOUNDS: 3.75
 * WNAKED: 3.75
 */

/obj/item/projectile/bullet/c9mm/improvised
	name = "handloaded 9mm bullet"
	damage = BULLET_DAMAGE_PISTOL_9MM_HANDLOAD
	damage_list = list("14" = 10, "17" = 10, "23" = 50, "25" = 10, "27" = 6, "30" = 15)
	stamina = BULLET_STAMINA_PISTOL_9MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_9MM_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_9MM_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 9mm rubber
 * DAMAGE: 2
 * STAMIN: 40
 * RECOIL: 0.5
 * WOUNDS: 5
 * WNAKED: 2.5
 */
/obj/item/projectile/bullet/c9mm/rubber
	name = "9mm rubber bullet"
	damage = RUBBERY_DAMAGE_PISTOL_9MM
	stamina = RUBBERY_STAMINA_PISTOL_9MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_PISTOL_9MM

	wound_bonus = RUBBERY_WOUND_PISTOL_9MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* 9mm acid
 * DAMAGE: 10
 * STAMIN: 5
 * RECOIL: 0.5
 * WOUNDS: 10
 * WNAKED: 7.5
 */
/obj/item/projectile/bullet/c9mm/acid
	name = "9mm acid-tipped bullet"

	damage = BULLET_DAMAGE_PISTOL_9MM * BULLET_DAMAGE_ACID
	stamina = BULLET_STAMINA_PISTOL_9MM * BULLET_STAMINA_ACID
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = BULLET_WOUND_PISTOL_9MM * BULLET_WOUND_ACID
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT * BULLET_NAKED_WOUND_ACID
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
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

/* 9mm fire
 * DAMAGE: 10
 * STAMIN: 5
 * RECOIL: 0.5
 * WOUNDS: 5
 * WNAKED: 0
 */
/obj/item/projectile/bullet/c9mm/incendiary
	name = "9mm incendiary bullet"

	damage = BULLET_DAMAGE_PISTOL_9MM * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_9MM * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = BULLET_WOUND_PISTOL_9MM * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE
	var/fire_stacks = 1

/obj/item/projectile/bullet/c9mm/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/* 9mm op
 * DAMAGE: 20
 * STAMIN: 12.5
 * RECOIL: 0.5
 * WOUNDS: 5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c9mm/op //for simple mobs, separate to allow balancing
	name = "9mm +P bullet"

/* 9mm simple
 * DAMAGE: 20
 * STAMIN: 10
 * RECOIL: 0.5
 * WOUNDS: 5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c9mm/simple //also for simple mobs, separate to allow balancing
	name = "9mm bullet"
	damage = BULLET_DAMAGE_PISTOL_9MM_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_9MM
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = BULLET_WOUND_PISTOL_9MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM * 0.3
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT



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

/* .38
 * DAMAGE: 36
 * STAMIN: 10
 * RECOIL: 0.5
 * WOUNDS: 5
 * WNAKED: 3.75
 */
/* //needless extra ammo type
/obj/item/projectile/bullet/c38
	name = ".38 bullet"
	damage = BULLET_DAMAGE_PISTOL_38
	stamina = BULLET_STAMINA_PISTOL_38
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = BULLET_WOUND_PISTOL_38
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/c38/rubber
	name = ".38 rubber bullet"
	damage = RUBBERY_DAMAGE_PISTOL_38
	stamina = RUBBERY_STAMINA_PISTOL_38
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_PISTOL_38

	wound_bonus = RUBBERY_WOUND_PISTOL_38
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/obj/item/projectile/bullet/c38/improvised
	name = "handloaded .38 bullet"
	damage = BULLET_DAMAGE_PISTOL_38_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_38
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_38_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/c38/acid
	name = ".38 acid-tipped bullet"
	damage = BULLET_DAMAGE_PISTOL_38 * BULLET_DAMAGE_ACID
	stamina = BULLET_STAMINA_PISTOL_38 * BULLET_STAMINA_ACID
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = BULLET_WOUND_PISTOL_38 * BULLET_WOUND_ACID
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT * BULLET_NAKED_WOUND_ACID
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
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
	damage = BULLET_DAMAGE_PISTOL_38 * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_38 * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = BULLET_WOUND_PISTOL_38 * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE
	var/fire_stacks = 1

/obj/item/projectile/bullet/c38/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()
*/
/////////////
// NEEDLER //
/////////////

/* * * * * * * *
 * TBD Light Pistol Bullet
 * Needle that... I guess does a fuckload of wounding?
 * TBD for sure
 * * * * * * * */

/* needle
 * DAMAGE: 10
 * STAMIN: 5
 * RECOIL: 0
 * WOUNDS: 50
 * WNAKED: 58
 */
/obj/item/projectile/bullet/needle
	name = "needle"
	icon_state = "needle"
	damage_list = list("16" = 80, "18" = 20, "20" = 5)
	damage = BULLET_DAMAGE_PISTOL_NEEDLE
	stamina = BULLET_STAMINA_PISTOL_NEEDLE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_NEEDLE

	wound_bonus = BULLET_WOUND_PISTOL_NEEDLE
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	pixels_per_second = BULLET_SPEED_PISTOL_NEEDLE
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	supereffective_damage = 14
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/projectile/bullet/needle/improvised
	name = "Jade needle"
	icon_state = "needleimprov"
	damage_list = list("12" = 80, "14" = 20, "16" = 5)
	supereffective_damage = 8
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")
	damage = BULLET_DAMAGE_PISTOL_NEEDLE_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_NEEDLE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_NEEDLE

	wound_bonus = BULLET_WOUND_PISTOL_NEEDLE
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_NEEDLE_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

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

/* 10mm
 * DAMAGE: 30
 * STAMIN: 30
 * RECOIL: 1
 * WOUNDS: 5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c10mm
	name = "10mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_10MM //30
	damage_list = list("20" = 8, "25" = 8, "30" = 55, "35" = 10, "40" = 19)
	stamina = BULLET_STAMINA_PISTOL_10MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_10MM

	wound_bonus = BULLET_WOUND_PISTOL_10MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_10MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 10mm handload
 * DAMAGE: 22
 * STAMIN: 10
 * RECOIL: 1
 * WOUNDS: 3.75
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c10mm/improvised
	name = "handloaded 10mm bullet"
	damage = BULLET_DAMAGE_PISTOL_10MM_HANDLOAD
	damage_list = list("17" = 15, "20" = 10, "25" = 10, "28" = 50, "35" = 10, "40" = 20)
	stamina = BULLET_STAMINA_PISTOL_10MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_10MM_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_10MM_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_10MM_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/c10mm/improvised/simple
	name = "handloaded 10mm bullet"
	damage = BULLET_DAMAGE_PISTOL_10MM_HANDLOAD
	damage_list = list("17" = 15, "20" = 10, "25" = 10, "28" = 50, "35" = 10, "40" = 20)
	stamina = BULLET_STAMINA_PISTOL_10MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_10MM_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_10MM_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_10MM_HANDLOAD * 0.5
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 10mm simplemob
 * DAMAGE: 18
 * STAMIN: 18
 * RECOIL: 1
 * WOUNDS: 3.75
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c10mm/simple
	name = "10mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_10MM_HANDLOAD
	stamina = BULLET_STAMINA_PISTOL_10MM
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_PISTOL_10MM_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_10MM_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_10MM_HANDLOAD * 0.5
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 10mm rubber
 * DAMAGE: 2.5
 * STAMIN: 90
 * RECOIL: 1
 * WOUNDS: 7.5
 * WNAKED: 3.75
 */
/obj/item/projectile/bullet/c10mm/rubber
	name = "10mm rubber bullet"
	damage = RUBBERY_DAMAGE_PISTOL_10MM
	stamina = RUBBERY_STAMINA_PISTOL_10MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_PISTOL_10MM

	wound_bonus = RUBBERY_WOUND_PISTOL_10MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_10MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* 10mm fire
 * DAMAGE: 12.5
 * STAMIN: 25
 * RECOIL: 1
 * WOUNDS: 5
 * WNAKED: 0
 */
/obj/item/projectile/bullet/c10mm/incendiary
	name = "10mm incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_10MM * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_10MM * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_10MM

	wound_bonus = BULLET_WOUND_PISTOL_10MM * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_10MM_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_10MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
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

/* 45
 * DAMAGE: 30
 * STAMIN: 39
 * RECOIL: 3
 * WOUNDS: 6.5
 * WNAKED: 5
 */
/obj/item/projectile/bullet/c45
	name = ".45 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_45ACP //36
	damage_list = list("25" = 5, "30" = 10, "33" = 15, "36" = 50, "40" = 5, "45" = 15)
	stamina = BULLET_STAMINA_PISTOL_45ACP
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP

	wound_bonus = BULLET_WOUND_PISTOL_45ACP
	bare_wound_bonus = BULLET_WOUND_PISTOL_45ACP_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 45 handload
 * DAMAGE: less
 * STAMIN: also less
 * RECOIL: 3
 * WOUNDS: 6.5
 * WNAKED: 5
 */
/obj/item/projectile/bullet/c45/improvised
	name = "handloaded .45 bullet"
	damage = BULLET_DAMAGE_PISTOL_45ACP_HANDLOAD
	damage_list = list("20" = 5, "25" = 5, "28" = 15, "32" = 60, "36" = 5, "45" = 10)
	stamina = BULLET_STAMINA_PISTOL_45ACP
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_45ACP_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_45ACP_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/c45/improvised
	pixels_per_second = BULLET_SPEED_PISTOL_45ACP_HANDLOAD * 0.5
/obj/item/projectile/bullet/c45/simple
	name = ".45 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_45ACP_HANDLOAD
	damage_list = list("20" = 5, "25" = 5, "28" = 15, "32" = 60, "36" = 5, "45" = 10)
	stamina = BULLET_STAMINA_PISTOL_45ACP
	spread = BULLET_SPREAD_HANDLOAD * 2
	recoil = BULLET_RECOIL_PISTOL_45ACP_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_45ACP_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_45ACP_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP_HANDLOAD * 0.65
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/c45/op
	name = ".45 +P bullet"

/* 45 rubber
 * DAMAGE: 3
 * STAMIN: 117
 * RECOIL: 1
 * WOUNDS: 9.75
 * WNAKED: 4.8
 */
/obj/item/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = RUBBERY_DAMAGE_PISTOL_45ACP
	stamina = RUBBERY_STAMINA_PISTOL_45ACP
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_PISTOL_45ACP

	wound_bonus = RUBBERY_WOUND_PISTOL_45ACP
	bare_wound_bonus = BULLET_WOUND_PISTOL_45ACP_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_PRECISION // Rubbers go where you want

/* 45 fire
 * DAMAGE: 18
 * STAMIN: 58
 * RECOIL: 1
 * WOUNDS: 6.5
 * WNAKED: 0
 */
/obj/item/projectile/bullet/c45/incendiary
	name = ".45 incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_45ACP * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_45ACP * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP

	wound_bonus = BULLET_WOUND_PISTOL_45ACP * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_45ACP_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE
	var/fire_stacks = 1

/obj/item/projectile/bullet/c45/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.fire_stacks < 1)
			M.adjust_fire_stacks(fire_stacks - M.fire_stacks)
			M.IgniteMob()

/////////////////
// .357 MAGNUM //
/////////////////

/* * * * * * * *
 * Baseline Heavy Pistol Bullet (even though it has medium pistol recoil =3)
 * Improvised, no match (yet)
 * Technically its 38 match
 * Handload
 * Ricochet
 * Acid rounds
 * Fire rounds
 * * * * * * * */

/* 357 fmj
 * DAMAGE: 45
 * STAMIN: 40
 * RECOIL: 1
 * WOUNDS: 10
 * WNAKED: 7.5
 */
/obj/item/projectile/bullet/a357
	name = ".357 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_38 //36
	damage_list = list("30" = 5, "32" = 5, "33" = 10, "34" = 10, "36" = 50, "44" = 20)
	stamina = BULLET_STAMINA_PISTOL_38
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = BULLET_WOUND_PISTOL_38
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 357 handload
 * DAMAGE: 30
 * STAMIN: 30
 * RECOIL: 1
 * WOUNDS: 7.5
 * WNAKED: 7.5
 */
/obj/item/projectile/bullet/a357/improvised
	name = "handloaded .357 bullet"
	damage = BULLET_DAMAGE_PISTOL_38_HANDLOAD
	damage_list = list("28" = 5, "30" = 5, "31" = 10, "32" = 10, "34" = 50, "44" = 20)
	stamina = BULLET_STAMINA_PISTOL_38
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_38_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 357 bounce
 * DAMAGE: 40
 * STAMIN: 40
 * RECOIL: 1
 * WOUNDS: 10
 * WNAKED: 7.5
 */
/obj/item/projectile/bullet/a357/ricochet
	name = ".357 ricochet bullet"
	damage = BULLET_DAMAGE_PISTOL_38
	stamina = BULLET_STAMINA_PISTOL_38
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38

	wound_bonus = BULLET_WOUND_PISTOL_38
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	ricochets_max = 3
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80

/* 357 acid
 * DAMAGE: 20
 * STAMIN: 20
 * RECOIL: 1
 * WOUNDS: 20
 * WNAKED: 15
 */
/obj/item/projectile/bullet/a357/acid
	name = ".357 acid-tipped bullet"
	damage = BULLET_DAMAGE_PISTOL_38_MATCH * BULLET_DAMAGE_ACID
	stamina = BULLET_STAMINA_PISTOL_38 * BULLET_STAMINA_ACID
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38_MATCH

	wound_bonus = BULLET_WOUND_PISTOL_38_MATCH * BULLET_WOUND_ACID
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT * BULLET_NAKED_WOUND_ACID
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38_MATCH
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

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

/* 357 fire
 * DAMAGE: 20
 * STAMIN: 20
 * RECOIL: 1
 * WOUNDS: 10
 * WNAKED: 0
 */
/obj/item/projectile/bullet/a357/incendiary
	name = ".357 incendiary bullet"
	damage = BULLET_DAMAGE_PISTOL_38_MATCH * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_38 * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_38_MATCH

	wound_bonus = BULLET_WOUND_PISTOL_38_MATCH * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_38_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_38_MATCH
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

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

/* 44 fmj
 * DAMAGE: 44
 * STAMIN: 52
 * RECOIL: 1
 * WOUNDS: 20
 * WNAKED: 15
 */
/obj/item/projectile/bullet/m44
	name = ".44 FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_44 //45
	damage_list = list("25" = 5, "35" = 5, "42" = 10, "37" = 60, "45" = 5, "47" = 15)
	stamina = BULLET_STAMINA_PISTOL_44
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44

	wound_bonus = BULLET_WOUND_PISTOL_44
	bare_wound_bonus = BULLET_WOUND_PISTOL_44_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_44
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 44 handload
 * DAMAGE: less
 * STAMIN: also less
 * RECOIL: 1
 * WOUNDS: 20
 * WNAKED: 15
 */
/obj/item/projectile/bullet/m44/improvised
	name = "handloaded .44 bullet"
	damage = BULLET_DAMAGE_PISTOL_44_HANDLOAD
	damage_list = list("27" = 7, "37" = 8, "39" = 10, "42" = 60, "47" = 5, "48" = 10)
	stamina = BULLET_STAMINA_PISTOL_44
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_44_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_44_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_44_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 44 simple
 * DAMAGE: 44
 * STAMIN: 52
 * RECOIL: 1
 * WOUNDS: 20
 * WNAKED: 15
 */
/obj/item/projectile/bullet/m44/simple //for simple mobs, separate to allow balancing
	name = ".44 bullet"
	damage = BULLET_DAMAGE_PISTOL_44_HANDLOAD
	damage_list = list("27" = 10, "37" = 15, "39" = 60, "40" = 15)
	stamina = BULLET_STAMINA_PISTOL_44
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_44_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_44_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_44_HANDLOAD * 0.4
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 44 fire
 * DAMAGE: 22
 * STAMIN: 26
 * RECOIL: 1
 * WOUNDS: 20
 * WNAKED: 0
 */
/obj/item/projectile/bullet/m44/incendiary
	name = ".44 incendiary bullet"

	damage = BULLET_DAMAGE_PISTOL_44 * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_PISTOL_44 * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_44

	wound_bonus = BULLET_WOUND_PISTOL_44 * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_PISTOL_44_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_44
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	damage_type = BURN // still checks bullet resist
	sharpness = SHARP_NONE
	var/fire_stacks = 3

/obj/item/projectile/bullet/m44/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

///////////
// 14 MM //
///////////

/* * * * * * * *
 * Ultra Heavy Pistol Bullet
 * Surplus, Improvised, no match (yet)
 * Poison spray?
 * * * * * * * */

/* 14mm fmj
 * DAMAGE: 50
 * STAMIN: 80
 * RECOIL: 3
 * WOUNDS: 20
 * WNAKED: 15
 */
/obj/item/projectile/bullet/mm14
	name = "14mm FMJ bullet"
	damage = BULLET_DAMAGE_PISTOL_14MM //50, gott damn
	damage_list = list("40" = 5, "45" = 5, "50" = 60, "58" = 15, "60" = 15)
	stamina = BULLET_STAMINA_PISTOL_14MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_14MM

	wound_bonus = BULLET_WOUND_PISTOL_14MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_14MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_14MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 14mm handloaded
 * DAMAGE: less
 * STAMIN: lesser
 * RECOIL: 3
 * WOUNDS: 20
 * WNAKED: 15
 */
/obj/item/projectile/bullet/mm14/improvised
	name = "handloaded 14mm bullet"
	damage = BULLET_DAMAGE_PISTOL_14MM_HANDLOAD
	damage_list = list("30" = 5, "35" = 5, "45" = 60, "52" = 10, "58" = 10, "60" = 10)
	stamina = BULLET_STAMINA_PISTOL_14MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_14MM_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_14MM_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_14MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_14MM_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 14mm poison
 * DAMAGE: 24
 * STAMIN: 24
 * RECOIL: 3
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/mm14/contam
	name = "14mm contaiminated bullet"
	damage = BULLET_DAMAGE_PISTOL_14MM * BULLET_DAMAGE_POISON
	stamina = BULLET_STAMINA_PISTOL_14MM * BULLET_STAMINA_POISON
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_14MM

	wound_bonus = BULLET_WOUND_PISTOL_14MM * BULLET_WOUND_POISON
	bare_wound_bonus = BULLET_WOUND_PISTOL_14MM_NAKED_MULT * BULLET_NAKED_WOUND_POISON
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_14MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
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

//////////////////////
//SPECIAL AMMO TYPES//
//////////////////////

/* * * * * * * *
 * Bouncy Heavy Pistol Bullet
 * Surplus only
 * Just bouncy 357
 * * * * * * * */
/* .45LC fmj
 * DAMAGE: 40
 * STAMIN: 40
 * RECOIL: 1
 * WOUNDS: 10
 * WNAKED: 7.5
 */
/obj/item/projectile/bullet/a45lc
	name = ".45 LC bullet"
	damage = BULLET_DAMAGE_PISTOL_45ACP
	damage_list = list("20" = 5, "26" = 5, "29" = 15, "34" = 50, "37" = 5, "41" = 5, "52" = 15)
	stamina = BULLET_STAMINA_PISTOL_45ACP
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP

	wound_bonus = BULLET_WOUND_PISTOL_45ACP
	bare_wound_bonus = BULLET_WOUND_PISTOL_45ACP_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	ricochets_max = 3
	ricochet_incidence_leeway = 130
	ricochet_decay_damage = 1.1 //48 damage on first bounce, 53 on second, 58 on third. Unless you bounce, the DPS dual wielding is lower then a single M29
	ricochet_decay_chance = 11
	ricochet_chance = 80 //100% if you have the vet's trait
	ricochet_auto_aim_range = 4

/* .45LC handload
 * DAMAGE: 40
 * STAMIN: 40
 * RECOIL: 1
 * WOUNDS: 10
 * WNAKED: 7.5
 */
/obj/item/projectile/bullet/a45lc/improvised
	name = "handloaded .45 LC bullet"
	damage = BULLET_DAMAGE_PISTOL_45ACP_HANDLOAD
	damage_list = list("17" = 5, "23" = 5, "25" = 15, "30" = 50, "33" = 5, "38" = 5, "50" = 15)
	stamina = BULLET_STAMINA_PISTOL_45ACP
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_45ACP_HANDLOAD

	wound_bonus = BULLET_WOUND_PISTOL_45ACP_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_PISTOL_45ACP_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_45ACP_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/* 69mm rock
 * DAMAGE: 5
 * STAMIN: 7.5
 * RECOIL: 0
 * WOUNDS: 1.25
 * WNAKED: 5.6
 */

/// Sharp fuckin rock
/obj/item/projectile/bullet/ghoul_rock
	name = "sharp rock"
	damage = BULLET_DAMAGE_GHOUL_ROCK
	stamina = BULLET_STAMINA_GHOUL_ROCK
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_GHOUL_ROCK

	wound_bonus = BULLET_WOUND_GHOUL_ROCK
	bare_wound_bonus = BULLET_WOUND_GHOUL_ROCK_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_GHOUL_ROCK
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/// Rock, but smoove
/obj/item/projectile/bullet/ghoul_rock/blunt_rock
	name = "heavy rock"
	sharpness = SHARP_NONE

/// Embeds, but they rarely throw them
/obj/item/projectile/bullet/ghoul_rock/jagged_scrap
	name = "jagged hunk of scrap"
	embedding = list(
		embed_chance = 75,
		fall_chance = 25,
		jostle_chance = 5,
		jostle_pain_mult = 1,
		pain_chance = 10,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 5,
		rip_time = 10,
		embed_chance_turf_mod = 100,
		projectile_payload = /obj/item/shrapnel
		)

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
				target.visible_message(span_danger("\The [src] was deflected!"), \
									   span_userdanger("You were protected against \the [src]!"))

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

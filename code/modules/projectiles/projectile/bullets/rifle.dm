//In this document: Rifle calibre cartridges values for damage and penetration.

//////////////////////
// AMMUNITION TYPES //
//////////////////////
/*
FMJ (full metal jacket)		=	Baseline
+P/+P+ = used by simplemobs
SHOCK = low-severity emp, -damage base, bonus burn damage (5-10)
Incin = -damage, sets target on fire
Acid = Heavy -damage, coats target in small amount of acid (1-5u)
Uranium = Irradiates, high AP, lower damage
Micro-Shrapnel = Wound bonus, embed bonus, high falloff for both
Contaminated = -damage, spawns a gas cloud that heavily reduces healing efficiency
Improvised = -1 to -4 damage
Civilian round				=	-10% damage. AP reduced by 50%
*/

/*
Ammo groupings for specialty:
5mm/22lr: Shock
Small Pistol calibers (38 357 9mm): Acid/Incin
Large Pistol Calibers (44 45 10mm): Incin
Very Large pistol (45-70): Knockback, Acid
autorifle calibers (5.56 7.62): Micro-Shrapnel (wound/embed)
heavy rifle calibers (12.7, 14mm, 7.62): Uranium, Contaminated, Incin
*/

// Explanation: Two major ammo stats, AP and Damage. Bullets placed in classes. Light rounds for example balanced with each other, one more AP, one more Damage.
// Balance between classes mostly done on the gun end, bigger rounds typically fire slower and have more recoil. They are not supposed to be totally equal either.


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

/obj/item/projectile/bullet/a556/microshrapnel
	name = "5.56 microshrapnel bullet"
	damage = -5
	wound_bonus = 15
	bare_wound_bonus = 15
	wound_falloff_tile = 0.5
	embed_falloff_tile = 0.5
	embedding = list(embed_chance=5, fall_chance=1, jostle_chance=1, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.5, pain_mult=5, jostle_pain_mult=6, rip_time=10, embed_chance_turf_mod=100, projectile_payload = /obj/item/shrapnel/bullet/a556/microshrapnel)

/obj/item/projectile/bullet/a556/uraniumtipped
	name = "5.56 uranium-tipped bullet"
	damage = -9
	armour_penetration = 0
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
	damage = -10
	armour_penetration = 0
	irradiate = 300

/obj/item/projectile/bullet/a762/microshrapnel
	name = "7.62 microshrapnel bullet"
	damage = -7
	wound_bonus = 15
	bare_wound_bonus = 15
	wound_falloff_tile = 0.5
	embed_falloff_tile = 0.5
	embedding = list(embed_chance=12, fall_chance=1, jostle_chance=1, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.3, pain_mult=5, jostle_pain_mult=6, rip_time=10, embed_chance_turf_mod=100, projectile_payload = /obj/item/shrapnel/bullet/a762/microshrapnel)

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

/obj/item/projectile/bullet/a50MG/uraniumtipped
	name = "12.7mm uranium-tipped bullet"
	damage = -15
	armour_penetration = 0.2
	irradiate = 500

/obj/item/projectile/bullet/a50MG/contam
	name = "12.7mm contaminated bullet"
	damage = -10
	var/smoke_radius = 1

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

//////////////////////
// 4.73 MM CASELESS //
//////////////////////			-Small rifle bullet

/obj/item/projectile/bullet/a473
	name = "4.73 FMJ bullet"
	damage = 0
	wound_bonus = 10
	bare_wound_bonus = -10

/obj/item/projectile/bullet/a473/rubber
	name = "4.73 polyurethane bullet"
	damage = -20
	stamina = 18
	sharpness = SHARP_NONE
	armour_penetration = 0.05
	wound_bonus = 0
	bare_wound_bonus = 0

/obj/item/projectile/bullet/a473/incendiary
	name = "4.73 tracer bullet"
	damage = -8
	armour_penetration = 0.1
	var/fire_stacks = 3
	zone_accuracy_factor = 100

/obj/item/projectile/bullet/a473/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/obj/item/projectile/bullet/a473/uraniumtipped
	name = "4.73 U-235 bullet"
	damage = -2
	armour_penetration = 0.3
	irradiate = 300

/obj/item/projectile/bullet/a473/dumdum
	name = "4.73 flat-nose bullet"
	damage = 5
	supereffective_damage = 10
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot")
	armour_penetration = -0.2
	wound_bonus = 20
	bare_wound_bonus = 30

/obj/item/projectile/bullet/a473/explosive
	name = "4.73 explosive bullet"
	damage = 0

/obj/item/projectile/bullet/a473/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	if(prob(10))
		explosion(target, 0, 0, 1, 1, adminlog = FALSE, flame_range = 0)
	else
		explosion(target, 0, 0, 0, 1, adminlog = FALSE, flame_range = 1) //no boom, just flame and flash

/obj/item/projectile/bullet/a473/shock
	name = "4.73mm shock bullet"
	wound_bonus = 0
	sharpness = SHARP_NONE
	var/energy_damage = 4

/obj/item/projectile/bullet/a473/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(5)//5 severity is very, very low
	if(blocked != 100 && isliving(target))
		var/mob/living/L = target
		L.electrocute_act(energy_damage, "shock bullet", 1, SHOCK_NOGLOVES | SHOCK_NOSTUN)

/obj/item/projectile/bullet/a473/hv
	name = "4.73mm highvelocity bullet"
	damage = -6 //the g11 is now just straight up 16 damage so this makes it 10
	hitscan = TRUE
	wound_bonus = 0

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

/obj/item/projectile/bullet/m5mm/shock
	name = "5mm shock bullet"
	damage = -6 //about -30% damage
	wound_bonus = 0
	sharpness = SHARP_NONE
	var/energy_damage = 5

/obj/item/projectile/bullet/m5mm/shock/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(5)//5 severity is very, very low
	if(blocked != 100 && isliving(target))
		var/mob/living/L = target
		L.electrocute_act(energy_damage, "shock bullet", 1, SHOCK_NOGLOVES | SHOCK_NOSTUN) //this might be spammy todo: check
		//if it is, use O.take_damage(energy_damage, BURN, "energy", FALSE)

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

/obj/item/projectile/bullet/c2mm/blender //welcome to pain town
	name = "2mm blender projectile"
	damage = -20
	hitscan = TRUE
	pass_flags = PASSTABLE
	armour_penetration = 1
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

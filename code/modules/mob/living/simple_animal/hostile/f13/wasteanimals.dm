///////////
// GECKO //
///////////

/mob/living/simple_animal/hostile/gecko
	name = "gecko"
	desc = "A large mutated reptile with sharp teeth."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "gekko"
	icon_living = "gekko"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 2,
		/obj/item/stack/sheet/animalhide/gecko = 1,
		/obj/item/stack/sheet/sinew = 1,
		/obj/item/stack/sheet/bone = 1
		)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	low_health_threshold = 0.5
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 12
	move_to_delay = 3.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	// emote_see = list(
	// 	"screeches",
	// 	"licks its eyes",
	// 	"twitches",
	// 	"scratches its frills",
	// 	"gonks",
	// 	"honks",
	// 	"scronks",
	// 	"sniffs",
	// 	"gecks"
	// 	)
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko", "critter-friend") // critter-friend is a flag for related beast friend/master quirk. Makes hostile mob passive for quirk holder.
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE // not a bad idea at all
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"
	loot = list()
	loot_drop_amount = 2
	loot_amount_random = TRUE

	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(30, 35, 40,),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 5, 7, 9),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 0, 2, 4),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/gecko/become_the_mob(mob/user)
	make_a_nest = /obj/effect/proc_holder/mob_common/make_nest/gecko
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/small_critter
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	. = ..()

/mob/living/simple_animal/hostile/gecko/Aggro()
	..()
	summon_backup(15)


/mob/living/simple_animal/hostile/gecko/summon //untameable
	faction = list("gecko")
	can_ghost_into = FALSE
	guaranteed_butcher_results = list()
	butcher_results = list()
	del_on_death = TRUE
	var/die_at_this_time = 0
	var/lifetime = 1 MINUTES

/mob/living/simple_animal/hostile/gecko/summon/Initialize()
	die_at_this_time = world.time + lifetime
	. = ..()

/mob/living/simple_animal/hostile/gecko/summon/BiologicalLife(seconds, times_fired)
	. = ..()
	if(world.time >= die_at_this_time)
		if(prob(5))
			explosion(get_turf(src), -1, -1, 2, 0, FALSE, FALSE, 2, FALSE, TRUE) // why do we explode dood
		dust()

/mob/living/simple_animal/hostile/gecko/make_low_health()
	melee_damage_lower *= 0.5
	melee_damage_upper *= 0.7
	see_in_dark += 8
	sound_pitch += 25
	alternate_attack_prob = 75
	is_low_health = TRUE
	vary = FALSE
	retreat_distance = 12
	minimum_distance = 10

/// Override this with what should happen when going from low health to high health
/mob/living/simple_animal/hostile/gecko/make_high_health()
	melee_damage_lower = initial(melee_damage_lower)
	melee_damage_upper = initial(melee_damage_upper)
	see_in_dark = initial(see_in_dark)
	alternate_attack_prob = initial(alternate_attack_prob)
	is_low_health = FALSE
	vary = TRUE
	retreat_distance = initial(retreat_distance)
	minimum_distance = initial(minimum_distance)


//Fire Geckos//

/mob/living/simple_animal/hostile/gecko/fire
	name = "fire spitter gecko"
	desc = "A large mutated reptile with sharp teeth and a warm disposition. Sorta smells like sulphur."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "gekko"
	icon_living = "gekko"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 12
	move_to_delay = 3.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	// emote_see = list(
	// 	"screeches",
	// 	"licks its eyes",
	// 	"twitches",
	// 	"scratches its frills",
	// 	"gonks",
	// 	"honks",
	// 	"scronks",
	// 	"sniffs",
	// 	"gecks"
	// 	)
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	ranged = TRUE
	check_friendly_fire = TRUE
	projectiletype = /obj/item/projectile/geckofire
	projectilesound = 'sound/magic/fireball.ogg'

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE // not a bad idea at all
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(200, 40, 40, 255, 45, 45),
		MOB_SPEED_LIST(, 3.3, 3.7),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(28, 30, 32),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(1, 2, 3),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/gecko/fire/Initialize()
	.=..()
	resize = 0.8
	update_transform()

//rad Geckos//

/mob/living/simple_animal/hostile/gecko/fire/rads
	name = "rad spitting gecko"
	desc = "A large mutated reptile with sharp teeth and a warm disposition. Sorta smells like ozone."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "gekko"
	icon_living = "gekko"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 12
	move_to_delay = 3.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	// emote_see = list(
	// 	"screeches",
	// 	"licks its eyes",
	// 	"twitches",
	// 	"scratches its frills",
	// 	"gonks",
	// 	"honks",
	// 	"scronks",
	// 	"sniffs",
	// 	"gecks"
	// 	)
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	ranged = TRUE
	check_friendly_fire = TRUE
	projectiletype = /obj/item/projectile/radiation_thing/neurothing
	projectilesound = 'sound/weapons/etherealhit.ogg'

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE // not a bad idea at all
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(40, 40, 200, 45, 45, 255),
		MOB_SPEED_LIST(3.3, 3.7),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(28, 30, 32),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(1, 2, 3),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/gecko/fire/Initialize()
	.=..()
	resize = 0.8
	update_transform()

/* firey gecko spit
 * DAMAGE: 5
 * STAMIN: 5
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/geckofire
	name = "flaming gecko spit"
	icon = 'icons/effects/fire.dmi'
	icon_state = "3"
	range = 4
	light_range = LIGHT_RANGE_FIRE
	light_color = LIGHT_COLOR_FIRE
	damage = BULLET_DAMAGE_SHOTGUN_PELLET * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_SHOTGUN_PELLET * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET * 0.35
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/obj/item/projectile/geckofire/on_hit(atom/target)
	. = ..()
	if(prob(1))
		name = "flaming gecko yartz"
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(2)
		if(M.fire_stacks > 2)
			M.IgniteMob()


//Smaller Legacy Geckos//
//Faster and more aggressive than normal geckos, but also easier even squishier.

/mob/living/simple_animal/hostile/gecko/legacy
	name = "newt"
	desc = "A large dog sized amphibious biped with an oddly large mouth for its size. Probably related to geckos in some way."
	icon = 'icons/fallout/mobs/legacymobs.dmi'
	icon_state = "legacy_gecko"
	icon_living = "legacy_gecko"
	icon_dead = "legacy_gecko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	randpixel = 8
	density = FALSE
	sidestep_per_cycle = 2
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 7
	melee_damage_upper = 18
	move_to_delay = 3.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 7
	waddle_amount = 5
	waddle_up_time = 1
	waddle_side_time = 1
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	// emote_see = list(
	// 	"screeches",
	// 	"licks its eyes",
	// 	"twitches",
	// 	"scratches its frills",
	// 	"gonks",
	// 	"honks",
	// 	"scronks",
	// 	"sniffs",
	// 	"gecks"
	// 	)
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW

	sound_pitch = 70
	vary_pitches = list(40, 80)
	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE // not a bad idea at all
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"


/mob/living/simple_animal/hostile/gecko/legacy/alpha
	name = "alpha newt"
	desc = "A large dog sized amphibious biped with an oddly large mouth for its size. Probably related to geckos in some way. This one's drooling a lot and looks sort of tired."
	icon = 'icons/fallout/mobs/legacymobs.dmi'
	icon_state = "legacy_gecko2"
	icon_living = "legacy_gecko2"
	icon_dead = "legacy_gecko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 7
	melee_damage_upper = 18
	move_to_delay = 3.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 9

	faction = list("gecko")
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE // not a bad idea at all
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(180, 255, 255, 255, 255, 255), //Rmin, Gmin, Bmin, Rmax, Gmax, Bmax
		MOB_SPEED_LIST(2.4, 2.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(80),
		MOB_HEALTH_LIST(30, 35, 38),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		)

/mob/living/simple_animal/hostile/gecko/legacy/alpha/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin/staminatoxin, 1)

/mob/living/simple_animal/hostile/gecko/big
	name = "big gecko"
	name = "big gecko"
	desc = "A large mutated reptile with sharp teeth. This one's pretty big, but its eyes seem clouded and it moves a bit clumsily."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "gekko"
	icon_living = "gekko"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 12
	melee_damage_upper = 24
	move_to_delay = 3.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 4
	vision_range = 4


	faction = list("gecko")
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_HEAVY

	sound_pitch = -75
	vary_pitches = list(-100, -80)
	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE // not a bad idea at all
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(120, 80, 80, 250, 100, 100), //Rmin, Gmin, Bmin, Rmax, Gmax, Bmax
		MOB_SPEED_LIST(3.0, 3.2),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(80),
		MOB_HEALTH_LIST(100, 110, 120),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
	)

/mob/living/simple_animal/hostile/gecko/big/Initialize()
	.=..()
	resize = 1.5
	update_transform()

/mob/living/simple_animal/hostile/gecko/playable
	health = 40
	maxHealth = 40
	speed = 0
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 8
	melee_damage_upper = 12
	footstep_type = FOOTSTEP_MOB_CLAW

/// Testing its randomness
/mob/living/simple_animal/hostile/gecko/debug
	sound_pitch = 100
	vary_pitches = list(-200, 200)
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_MALE, 2),\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_LIZARD_FEMALE, 1),\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_ALL_OF_THEM, 5)\
		),
		MOB_COLOR_VARIATION(20, 190, 0, 255, 2, 0),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(100),
		MOB_HEALTH_LIST(2, 3, 5, 7, 30, 35, 37, 38, 40, 45, 48, 49, 49, 49, 49, 2000),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 5, 7, 9),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 4, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/// Testing its randomness
/mob/living/simple_animal/hostile/gecko/debug/stamcrit
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(MOB_RANDOM_NAME(MOB_NAME_RANDOM_LIZARD_FEMALE, 1)),
		MOB_HEALTH_LIST(50),
		MOB_RETREAT_DISTANCE_LIST(4),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/// Testing its randomness
/mob/living/simple_animal/hostile/gecko/debug/stamcrit/Initialize()
	. = ..()
	new /obj/item/gun/energy/disabler/debug(get_turf(src))

/mob/living/simple_animal/hostile/gecko/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(15)

//////////////////////////
// NIGHTSTALKERS & PELT //
//////////////////////////

/mob/living/simple_animal/hostile/stalker
	name = "greater hellhound"
	desc = "A hellhound is a fierce, supernatural canine often associated with the underworld, known for its fiery eyes and ominous presence."
	icon = 'modular_coyote/icons/mob/paramob.dmi'
	icon_state = "hellhoundgreater"
	icon_living = "hellhoundgreater"
	icon_dead = "hellhound_dead"
	icon_gib = null
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	move_to_delay = 3
	// m2d 3 = standard, less is fast, more is slower.

	retreat_distance = 0
	//how far they pull back

	minimum_distance = 0
	// how close you can get before they try to pull back

	aggro_vision_range = 7
	//tiles within they start attacking, doesn't count the mobs tile

	vision_range = 8
	//tiles within they start making noise, does count the mobs tile

	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 2,
		/obj/item/stack/sheet/sinew = 2,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 3
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "bites"
	emote_taunt = list("growls")
	taunt_chance = 30
	speed = 1
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 4
	melee_damage_upper = 12
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/nightstalker_bite.ogg'
	speak_emote = list("growls")
	faction = list("nightstalkers")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	footstep_type = FOOTSTEP_MOB_CLAW
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 1

/mob/living/simple_animal/hostile/stalker/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/hostile/stalker/playable
	health = 80
	maxHealth = 80
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 10
	melee_damage_upper = 15

/mob/living/simple_animal/hostile/stalker/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin/rattler_venom, 5)

/mob/living/simple_animal/hostile/stalker/playable/legion
	name = "legionstalker"
	desc = "A nightstalker bred specifically for the legion under the use of combat and companionship. legionstalkers have the body and loyalty of a canine but the agility and deadlyness of rattlesnake."
	icon_state = "nightstalker-legion"
	icon_living = "nightstalker-legion"
	icon_dead = "nightstalker-legion-dead"

/mob/living/simple_animal/hostile/stalkeryoung
	name = "hellhound"
	desc = "A hellhound is a fierce, supernatural canine often associated with the underworld, known for its fiery eyes and ominous presence."
	icon = 'modular_coyote/icons/mob/paramob.dmi'
	icon_state = "hellhound"
	icon_living = "hellhound"
	icon_dead = "hellhound_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	retreat_distance = 8
	minimum_distance = 6
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 1,
		/obj/item/stack/sheet/sinew = 1,
		/obj/item/stack/sheet/bone = 1
		)
	response_help_simple = "pets"
	response_disarm_simple = "pushes aside"
	response_harm_simple = "kicks"
	taunt_chance = 30
	speed = 1
	maxHealth = 50
	health = 50
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 5
	melee_damage_upper = 10
	attack_verb_simple = "bites"
	speak_emote = list("howls")
	faction = list("nightstalkers", "critter-friend")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	footstep_type = FOOTSTEP_MOB_CLAW

	emote_taunt_sound = list('sound/f13npc/nightstalker/taunt1.ogg', 'sound/f13npc/nightstalker/taunt2.ogg')
	emote_taunt = list("growls", "snarls")
	emote_taunt_sound = list('sound/f13npc/nightstalker/aggro1.ogg', 'sound/f13npc/nightstalker/aggro2.ogg', 'sound/f13npc/nightstalker/aggro3.ogg')
	idlesound = list('sound/f13npc/nightstalker/idle1.ogg')
	death_sound = 'sound/f13npc/nightstalker/death.ogg'
	attack_sound = 'sound/f13npc/nightstalker/attack1.ogg'
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2

/mob/living/simple_animal/hostile/stalkeryoung/playable
	health = 80
	maxHealth = 80
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 5
	melee_damage_upper = 10
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/hostile/stalker/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin/rattler_venom, 2)

/datum/reagent/toxin/rattler_venom
	name = "rattler venom"
	description = "A dangerous venom that causes intense pain and internal bleeding."
	reagent_state = LIQUID
	color = "#801E28" // rgb: 128, 30, 40
	toxpwr = 0.5
	taste_description = "pain"
	taste_mult = 1.3
	var/base_bleed = 15
	var/bleed_tier_divisor = 3 //increasing this number makes the effect weaker
	var/blood_loss_tier = 250 // Losing a multiple of this much will stack on an extra divisor

/datum/reagent/toxin/rattler_venom/on_mob_life(mob/living/carbon/M)
	var/divisor = 1
	var/blood_i_lost = clamp(BLOOD_VOLUME_NORMAL - M.get_blood(), 0, BLOOD_VOLUME_NORMAL)
	while(blood_i_lost > blood_loss_tier)
		blood_i_lost -= blood_loss_tier
		divisor *= bleed_tier_divisor
	var/blood_to_lose = max(round(base_bleed / max(divisor,1)), 1)
	M.bleed(blood_to_lose)
	var/concentration = M.reagents.get_reagent_amount(/datum/reagent/toxin/rattler_venom)
	M.damageoverlaytemp = concentration * 10
	M.update_damage_hud()
	if (M.eye_blurry < 5)
		M.adjust_blurriness(1)
	if(prob(10))
		var/pain_message = pick("You feel horrible pain.", "It burns like a red hot iron", "You can hardly bear the agony")
		to_chat(M, span_warning("[pain_message]"))
	..()

/datum/reagent/toxin/rattler_venom/on_mob_life_synth(mob/living/M)
	M.adjustStaminaLoss(10, 0)
	if (M.eye_blurry < 5)
		M.adjust_blurriness(1)
	if(prob(5))
		var/pain_message = pick("Your electronics can't handle the potent venom.", "Your pain sensors are overloaded.", "Invasive chemicals are making you short curcuit.")
		to_chat(M, span_notice("[pain_message]"))
	..()

/obj/item/clothing/head/f13/stalkerpelt
	name = "nightstalker pelt"
	desc = "A hat made from nightstalker pelt which makes the wearer feel both comfortable and elegant."
	icon_state = "stalkerpelt"
	item_state = "stalkerpelt"

/obj/structure/stalkeregg
	name = "hellhound egg"
	desc = "A shiny egg coming from a hellhound. They lay eggs?"
	icon = 'icons/mob/wastemobsdrops.dmi'
	icon_state = "stalker-egg"
	density = 1
	anchored = 0

/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat
	name = "hellhound meat"
	desc = "Could taste like rich red meat or flavorful chicken, depending on where the cut comes from."
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	bitesize = 4 //Average animal
	filling_color = "#FA8072"
	tastes = list("rich meat" = 3)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/nightstalker_meat
	slice_path = null
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/steak/nightstalker_meat
	name = "hellhound steak"
	desc = "A surprisingly high quality steak that could come in a variety of textures and may taste of either good chicken or rich beef"

/////////////
// MOLERAT //  It's time ~TK
/////////////

/mob/living/simple_animal/hostile/molerat
	name = "giant rat"
	desc = "A large mutated rat that finds its way everywhere. Common in caves and underground areas."
	icon = 'modular_coyote/icons/mob/rat.dmi'
	icon_state = "rat"
	icon_living = "rat"
	icon_dead = "rat_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	can_ghost_into = TRUE
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
						/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 2,
						/obj/item/stack/sheet/sinew = 1,
						/obj/item/stack/sheet/animalhide/molerat = 1,
						/obj/item/stack/sheet/bone = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 2
	maxHealth = 25
	health = 25
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 4
	melee_damage_upper = 10
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/molerat_attack.ogg'
	speak_emote = list("chitters")

	faction = list("rat", "rat-friend")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM

	emote_taunt_sound = list('sound/f13npc/molerat/taunt.ogg')
	emote_taunt = list("hisses")
	emote_taunt_sound = list('sound/f13npc/molerat/aggro1.ogg', 'sound/f13npc/molerat/aggro2.ogg',)
	idlesound = list('sound/f13npc/molerat/idle.ogg')
	death_sound = 'sound/f13npc/molerat/death.ogg'
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	desc_short = "Small, squishy, and numerous."
	pop_required_to_jump_into = SMALL_MOB_MIN_PLAYERS
	randpixel = 8

	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3.6, 3.9, 4),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(25),
		MOB_HEALTH_LIST(15, 20, 25, 26),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(5),
	)

/mob/living/simple_animal/hostile/molerat/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/hostile/molerat/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/small_critter
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	make_a_nest = /obj/effect/proc_holder/mob_common/make_nest/molerat
	. = ..()

/mob/living/simple_animal/hostile/molerat/Initialize()
	.=..()
	resize = 0.8
	update_transform()


/mob/living/simple_animal/hostile/molerat/micro
	name = "Swarmling"
	maxHealth = 10
	density = FALSE
	randpixel = 16
	health = 15
	melee_damage_lower = 2
	melee_damage_upper = 6
	variation_list = list(
		MOB_COLOR_VARIATION(200, 200, 200, 250, 250, 250), //Rmin, Gmin, Bmin, Rmax, Gmax, Bmax
		MOB_SPEED_LIST(3, 4, 5),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(80),
		MOB_HEALTH_LIST(10, 13, 15),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
	) //same as a newt for how they attack

/mob/living/simple_animal/hostile/molerat/micro/Initialize()
	.=..()
	resize = 0.75
	update_transform()

/mob/living/simple_animal/hostile/molerat/leader
	name = "Giant Rat Broodmother"
	maxHealth = 40
	health = 40
	melee_damage_lower = 20
	melee_damage_upper = 30
	retreat_distance = 9
	minimum_distance = 7
	aggro_vision_range = 7
	vision_range = 9
	ranged = TRUE
	can_glow_revive = FALSE
	variation_list = list(
		MOB_COLOR_VARIATION(245, 215, 0, 255, 220, 5), //Rmin, Gmin, Bmin, Rmax, Gmax, Bmax
		MOB_SPEED_LIST(3, 4),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(80),
		MOB_HEALTH_LIST(70, 75, 80),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
	) //same as a newt for how they attack

/mob/living/simple_animal/hostile/molerat/leader/Initialize()
	.=..()
	resize = 2.0
	pixel_y = 10
	pixel_x = 12
	update_transform()



/mob/living/simple_animal/hostile/molerat/leader/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/molerat, allow_revival = FALSE, restrict_faction = null, type_healing = BRUTELOSS)

/obj/item/projectile/giantratsummon
	name = "giant rat summoning"
	icon_state = "spark"
	range = 10
	light_range = LIGHT_RANGE_FIRE
	light_color = LIGHT_COLOR_FIRE
	damage = 0
	stamina = 20
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

	pixels_per_second = BULLET_SPEED_BASE
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/obj/item/projectile/moleratsummon/on_hit(atom/target, blocked = FALSE)
	..()
	spawn_and_random_walk(/mob/living/simple_animal/hostile/molerat/micro/summon, target, 10, walk_chance = 100, max_walk = 10, admin_spawn = FALSE)
	//		break
	return BULLET_ACT_HIT

/mob/living/simple_animal/hostile/molerat/micro/summon //untameable
	can_ghost_into = FALSE
	guaranteed_butcher_results = list()
	butcher_results = list()
	del_on_death = TRUE

/mob/living/simple_animal/hostile/molerat/leader/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/molerat, allow_revival = TRUE, restrict_faction = null, type_healing = BRUTELOSS)



//GELCUBE

/mob/living/simple_animal/hostile/gelcube
	name = "gelatinous cube"
	desc = "A big green radioactive cube creature, it jiggles with menacing wiggles and is making some sort of goofy face at you."
	icon = 'modular_coyote/icons/mob/vatgrowing.dmi'
	icon_state = "gelatinous"
	icon_living = "gelatinous"
	icon_dead = "gelatinous_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	can_ghost_into = TRUE
	speak_chance = 0
	turns_per_move = 10
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/soup/amanitajelly = 3)
	butcher_difficulty = 1.5
	loot = list()
	/// How many things to drop on death? Set to MOB_LOOT_ALL to just drop everything in the list
	loot_drop_amount = 10
	/// Drop 1 - loot_drop_amount? False always drops loot_drop_amount items
	loot_amount_random = TRUE
	/// slots in a list of trash loot
	var/random_trash_loot = TRUE
	response_help_simple = "jiggles"
	response_disarm_simple = "wiggles"
	response_harm_simple = "shakes"
	taunt_chance = 30
	speed = 12
	maxHealth = 850
	health = 850
	harm_intent_damage = 30
	obj_damage = 15
	melee_damage_lower = 35
	melee_damage_upper = 45
	move_to_delay = 12
	attack_verb_simple = "goops"
	attack_sound = 'sound/effects/attackblob.ogg'
	speak_emote = list("glorbles")
	faction = list("slime") //at last, I am at peace ~TK
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM

	emote_taunt_sound = list('sound/effects/bubbles.ogg')
	emote_taunt = list("blorgles")
	emote_taunt_sound = list('sound/misc/splort.ogg')
	idlesound = list('sound/vore/prey/squish_01.ogg') //God forgive me for what I must do. Its just a perfect sound. ~TK
	death_sound = 'sound/misc/crack.ogg'
	waddle_amount = 4
	waddle_up_time = 3
	waddle_side_time = 2
	desc_short = "Big, squishy, and gelatinous."

/mob/living/simple_animal/hostile/gelcube/Initialize()
	. = ..()
	if(random_trash_loot)
		loot = GLOB.trash_ammo + GLOB.trash_chem + GLOB.trash_clothing + GLOB.trash_craft + GLOB.trash_gun + GLOB.trash_misc + GLOB.trash_money + GLOB.trash_mob + GLOB.trash_part + GLOB.trash_tool


////////////
//T-Birds//
//////////

/mob/living/simple_animal/hostile/bloodbird
	name = "Blood Bird"
	desc = "A large mutated turkey vulture."
	icon = 'icons/fallout/mobs/animals/bloodbird.dmi'
	icon_state = "bloodbird"
	icon_living = "bloodbird"
	icon_dead = "bloodbird_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 4,
		/obj/item/feather = 3,
		/obj/item/stack/sheet/bone = 2)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 25
	melee_damage_upper = 35
	move_to_delay = 3.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 9
	vision_range = 8
	waddle_amount = 5
	waddle_up_time = 1
	waddle_side_time = 1
	pass_flags = PASSTABLE
	speak_emote = list(
		"cackles",
		"squawks",
		"clacks",
		)
	// emote_see = list(
	// 	"screeches",
	// 	"gonks"
	// 	)
	attack_verb_simple = list(
		"bites",
		"claws",
		"rends",
		"mutilates"
		)
	faction = list("terror bird")
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_HEAVY
	idlesound = list(
		'sound/creatures/terrorbird/clack1.ogg',
		'sound/creatures/terrorbird/clack2.ogg',
		'sound/creatures/terrorbird/clack3.ogg',
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/creatures/terrorbird/hoot1.ogg',
		'sound/creatures/terrorbird/hoot2.ogg',
		'sound/creatures/terrorbird/hoot3.ogg',
		'sound/creatures/terrorbird/hoot4.ogg',
		)

	can_ghost_into = FALSE //One day Kotetsu will return to us. ~TK
	desc_short = "What a terrifying bird."


	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(1.5, 1.8, 2.0, 2.2),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(80, 90, 100, 110),
		MOB_RETREAT_DISTANCE_LIST(0, 0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(90),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(90),
	)

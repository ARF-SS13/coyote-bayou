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
		/obj/item/stack/sheet/animalhide/gecko = 1)
	butcher_results = list(/obj/item/stack/sheet/bone = 1)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 1
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 5
	melee_damage_upper = 15
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
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
	emote_see = list(
		"screeches",
		"licks its eyes",
		"twitches",
		"scratches its frills",
		"gonks",
		"honks",
		"scronks",
		"sniffs",
		"gecks"
		)
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
	atmos_requirements = list(
		"min_oxy" = 5,
		"max_oxy" = 0,
		"min_tox" = 0,
		"max_tox" = 1,
		"min_co2" = 0,
		"max_co2" = 5,
		"min_n2" = 0,
		"max_n2" = 0
		)
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
	aggrosound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'



	variation_list = list(
		MOB_COLOR_VARIATION(200, 200, 200, 255, 255, 255),
		MOB_SPEED_LIST(1.5, 1.8, 2.0, 2.2, 2.6, 3.0, 3.3, 3.7),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(30, 35, 40, 45),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 5, 7, 9),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 4, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/gecko/playable
	health = 200
	maxHealth = 200
	speed = 0
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 20
	melee_damage_upper = 45
	footstep_type = FOOTSTEP_MOB_CLAW

/// Testing its randomness
/mob/living/simple_animal/hostile/gecko/debug
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_MALE, 2),\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_LIZARD_FEMALE, 1),\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_ALL_OF_THEM, 5)\
		),
		MOB_COLOR_VARIATION(20, 190, 0, 255, 2, 0),
		MOB_SPEED_LIST(1.5, 1.8, 2.0, 2.2, 2.6, 3.0, 3.3, 3.7),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(100),
		MOB_HEALTH_LIST(2, 3, 5, 7, 30, 35, 37, 38, 40, 45, 48, 49, 49, 49, 49, 2000),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 5, 7, 9),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 4, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)


//////////////////////////
// NIGHTSTALKERS & PELT //
//////////////////////////

/mob/living/simple_animal/hostile/stalker
	name = "nightstalker"
	desc = "A crazed genetic hybrid of rattlesnake and coyote DNA."
	icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon_state = "nightstalker"
	icon_living = "nightstalker"
	icon_dead = "nightstalker-dead"
	icon_gib = null
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	move_to_delay = 2
	// m2d 3 = standard, less is fast, more is slower.

	retreat_distance = 8
	//how far they pull back
	
	minimum_distance = 0
	// how close you can get before they try to pull back

	aggro_vision_range = 7
	//tiles within they start attacking, doesn't count the mobs tile

	vision_range = 8
	//tiles within they start making noise, does count the mobs tile

	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 2)
	butcher_results = list(/obj/item/clothing/head/f13/stalkerpelt = 1, /obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 1)
	butcher_difficulty = 3
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "bites"
	emote_taunt = list("growls")
	taunt_chance = 30
	speed = -1
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 6
	melee_damage_upper = 15
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/nightstalker_bite.ogg'
	speak_emote = list("growls")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	footstep_type = FOOTSTEP_MOB_CLAW
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 1

/mob/living/simple_animal/hostile/stalker/playable
	health = 300
	maxHealth = 300
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 20
	melee_damage_upper = 45

/mob/living/simple_animal/hostile/stalker/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		H.reagents.add_reagent(/datum/reagent/toxin/cazador_venom, 6)

/mob/living/simple_animal/hostile/stalker/playable/legion				
	name = "legionstalker"
	desc = "A nightstalker bred specifically for the legion under the use of combat and companionship. legionstalkers have the body and loyalty of a canine but the agility and deadlyness of rattlesnake."
	icon_state = "nightstalker-legion"
	icon_living = "nightstalker-legion"
	icon_dead = "nightstalker-legion-dead"

// NIGHTSTALKER CUB
/mob/living/simple_animal/hostile/stalkeryoung
	name = "young nightstalker"
	desc = "A juvenile crazed genetic hybrid of rattlesnake and coyote DNA."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "nightstalker_cub"
	icon_living = "nightstalker_cub"
	icon_dead = "nightstalker_cub_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 2, /obj/item/stack/sheet/sinew = 1, /obj/item/stack/sheet/bone = 1)
	butcher_results = list(/obj/item/clothing/head/f13/stalkerpelt = 1, /obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 1)
	response_help_simple = "pets"
	response_disarm_simple = "pushes aside"
	response_harm_simple = "kicks"
	taunt_chance = 30
	speed = -1
	maxHealth = 50
	health = 50
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 5
	melee_damage_upper = 10
	attack_verb_simple = "bites"
	speak_emote = list("howls")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	footstep_type = FOOTSTEP_MOB_CLAW

	emote_taunt_sound = list('sound/f13npc/nightstalker/taunt1.ogg', 'sound/f13npc/nightstalker/taunt2.ogg')
	emote_taunt = list("growls", "snarls")
	aggrosound = list('sound/f13npc/nightstalker/aggro1.ogg', 'sound/f13npc/nightstalker/aggro2.ogg', 'sound/f13npc/nightstalker/aggro3.ogg')
	idlesound = list('sound/f13npc/nightstalker/idle1.ogg')
	death_sound = 'sound/f13npc/nightstalker/death.ogg'
	attack_sound = 'sound/f13npc/nightstalker/attack1.ogg'
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2

/mob/living/simple_animal/hostile/stalkeryoung/playable
	health = 250
	maxHealth = 250
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 20
	melee_damage_upper = 45
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/hostile/stalker/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		H.reagents.add_reagent(/datum/reagent/toxin/cazador_venom, 2)

/obj/item/clothing/head/f13/stalkerpelt
	name = "nightstalker pelt"
	desc = "A hat made from nightstalker pelt which makes the wearer feel both comfortable and elegant."
	icon_state = "stalkerpelt"
	item_state = "stalkerpelt"

/obj/structure/stalkeregg
	name = "nightstalker egg"
	desc = "A shiny egg coming from a nightstalker."
	icon = 'icons/mob/wastemobsdrops.dmi'
	icon_state = "stalker-egg"
	density = 1
	anchored = 0

/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat
	name = "nightstalker meat"
	desc = "Could taste like rich red meat or flavorful chicken, depending on where the cut comes from."
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	bitesize = 4 //Average animal
	filling_color = "#FA8072"
	tastes = list("rich meat" = 3)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/nightstalker_meat
	slice_path = null
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/steak/nightstalker_meat
	name = "nightstalker steak"
	desc = "A surprisingly high quality steak that could come in a variety of textures and may taste of either good chicken or rich beef"

/////////////
// MOLERAT //
/////////////

/mob/living/simple_animal/hostile/molerat
	name = "molerat"
	desc = "A large mutated rat-mole hybrid that finds its way everywhere. Common in caves and underground areas."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "molerat"
	icon_living = "molerat"
	icon_dead = "molerat_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 2, /obj/item/stack/sheet/sinew = 1,/obj/item/stack/sheet/animalhide/molerat = 1, /obj/item/stack/sheet/bone = 1)
	butcher_results = list(/obj/item/stack/sheet/bone = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = -1
	maxHealth = 25
	health = 25
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 4
	melee_damage_upper = 12
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/molerat_attack.ogg'
	speak_emote = list("chitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("hostile", "gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM

	emote_taunt_sound = list('sound/f13npc/molerat/taunt.ogg')
	emote_taunt = list("hisses")
	aggrosound = list('sound/f13npc/molerat/aggro1.ogg', 'sound/f13npc/molerat/aggro2.ogg',)
	idlesound = list('sound/f13npc/molerat/idle.ogg')
	death_sound = 'sound/f13npc/molerat/death.ogg'
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2


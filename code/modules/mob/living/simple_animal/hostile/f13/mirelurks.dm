// In this document: Mirelurks


///////////////
// MIRELURKS //
///////////////

// MIRELURK ADULT
/mob/living/simple_animal/hostile/mirelurk
	bounty = 15
	name = "mirelurk"
	desc = "A giant mutated crustacean, with a hardened exo-skeleton."
	icon = 'icons/fallout/mobs/animals/mirelurks.dmi'
	icon_state = "mirelurk"
	icon_living = "mirelurk"
	icon_dead = "mirelurk_d"
	faction = "crabs"
	speed = 1
	can_ghost_into = TRUE
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
		/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 2,
		/obj/item/stack/sheet/sinew = 1
		)
	speak_emote = list("foams", "clacks", "chitters", "snips", "snaps")
	// emote_see = list("clack its claws", "foam at the mouth", "woobs", "extends its eyestalks")
	attack_verb_simple = list ("pinches", "rends", "snips", "snaps", "snibbity-snaps", "clonks", "disects")
	maxHealth = 120
	health = 120
	melee_damage_lower = 5
	melee_damage_upper = 18
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	gold_core_spawnable = HOSTILE_SPAWN
	blood_volume = 0
	footstep_type = FOOTSTEP_MOB_CLAW
	pop_required_to_jump_into = MED_MOB_MIN_PLAYERS
	variation_list = list(
		MOB_COLOR_VARIATION(100, 100, 100, 255, 255, 255),
		MOB_SPEED_LIST(3.3, 3.4, 3.5),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(100),
		MOB_HEALTH_LIST(110, 115, 120, 130),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 2),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(70),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(70),
	)
	loot = list(/obj/effect/gibspawner/xeno/bodypartless)
	loot_drop_amount = 1
	loot_amount_random = TRUE

// MIRELURK HUNTER MALES
/mob/living/simple_animal/hostile/mirelurk/hunter
	bounty = 18
	name = "mirelurk hunter"
	desc = "A giant mutated crustacean, with a hardened exoskeleton. Its appearance makes you shudder in fear. This one has giant, razor sharp claw pincers."
	icon_state = "mirelurkhunter"
	icon_living = "mirelurkhunter"
	speed = 1
	icon_dead = "mirelurkhunter_d"
	icon_gib = "gib"
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 4,
		/obj/item/stack/sheet/sinew = 2
		)
	maxHealth = 160
	health = 160
	melee_damage_lower = 15
	melee_damage_upper = 28
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	pop_required_to_jump_into = BIG_MOB_MIN_PLAYERS
	variation_list = list(
		MOB_COLOR_VARIATION(100, 100, 100, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.1, 3.2),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(100),
		MOB_HEALTH_LIST(140, 150, 160, 170),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 2),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(70),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(70),
	)
	loot = list(/obj/effect/gibspawner/xeno/bodypartless)
	loot_drop_amount = 3
	loot_amount_random = TRUE

// MIRELURK BABY
/mob/living/simple_animal/hostile/mirelurk/baby
	bounty = 5
	name = "mirelurk baby"
	desc = "A neophyte mirelurk baby, mostly harmless. Adults respond to their chittering if distressed."
	icon_state = "mirelurkbaby"
	icon_living = "mirelurkbaby"
	icon_dead = "mirelurkbaby_d"
	icon_gib = "gib"
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 1)
	speed = 1
	maxHealth = 40
	health = 40
	melee_damage_lower = 5
	melee_damage_upper = 10
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 1
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	pop_required_to_jump_into = 0
	variation_list = list(
		MOB_COLOR_VARIATION(100, 100, 100, 255, 255, 255),
		MOB_SPEED_LIST(2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(100),
		MOB_HEALTH_LIST(35, 39, 40, 41),
		MOB_RETREAT_DISTANCE_LIST(5, 6, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(3, 4, 5),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)
	loot = list(/obj/effect/gibspawner/xeno/bodypartless)
	loot_drop_amount = 1
	loot_amount_random = TRUE


/mob/living/simple_animal/hostile/mirelurk/baby/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/mirelurk/baby/Aggro()
	..()
	summon_backup(10)

// OBSOLETE MARKED FOR DEATH, YOU HAVE 3 DAYS
/obj/structure/mirelurkegg
	name = "mirelurk eggs"
	desc = "A fresh clutch of mirelurk eggs."
	icon = 'icons/mob/wastemobsdrops.dmi'
	icon_state = "mirelurkeggs"
	density = 1
	anchored = 0

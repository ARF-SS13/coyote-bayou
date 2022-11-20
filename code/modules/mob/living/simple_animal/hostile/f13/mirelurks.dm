// In this document: Mirelurks


///////////////
// MIRELURKS //
///////////////

// MIRELURK ADULT
/mob/living/simple_animal/hostile/mirelurk
	name = "mirelurk"
	desc = "A giant mutated crustacean, with a hardened exo-skeleton."
	icon = 'icons/fallout/mobs/animals/mirelurks.dmi'
	icon_state = "mirelurk"
	icon_living = "mirelurk"
	icon_dead = "mirelurk_d"
	speed = 1
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

	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 2, /obj/item/stack/sheet/sinew = 1)
	speak_emote = list("foams", "clacks", "chitters", "snips", "snaps")
	emote_see = list("clack its claws", "foam at the mouth", "woobs", "extends its eyestalks")
	attack_verb_simple = list ("pinches", "rends", "snips", "snaps", "snibbity-snaps", "clonks", "disects")
	maxHealth = 120
	health = 120
	melee_damage_lower = 5
	melee_damage_upper = 20
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	gold_core_spawnable = HOSTILE_SPAWN
	blood_volume = 0
	footstep_type = FOOTSTEP_MOB_CLAW

// MIRELURK HUNTER MALES
/mob/living/simple_animal/hostile/mirelurk/hunter
	name = "mirelurk hunter"
	desc = "A giant mutated crustacean, with a hardened exoskeleton. Its appearance makes you shudder in fear. This one has giant, razor sharp claw pincers."
	icon_state = "mirelurkhunter"
	icon_living = "mirelurkhunter"
	speed = 1
	icon_dead = "mirelurkhunter_d"
	icon_gib = "gib"
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 4, /obj/item/stack/sheet/sinew = 2)
	maxHealth = 200
	health = 200
	melee_damage_lower = 15
	melee_damage_upper = 35
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW

// MIRELURK BABY
/mob/living/simple_animal/hostile/mirelurk/baby
	name = "mirelurk baby"
	desc = "A neophyte mirelurk baby, mostly harmless. Adults respond to their chittering if distressed."
	icon_state = "mirelurkbaby"
	icon_living = "mirelurkbaby"
	icon_dead = "mirelurkbaby_d"
	icon_gib = "gib"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 1)
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

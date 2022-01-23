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
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 2, /obj/item/stack/sheet/sinew = 1)
	maxHealth = 150
	health = 150
	melee_damage_lower = 10
	melee_damage_upper = 20
	gold_core_spawnable = HOSTILE_SPAWN
	blood_volume = 0

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
	maxHealth = 250
	health = 250
	melee_damage_lower = 30
	melee_damage_upper = 45
	gold_core_spawnable = HOSTILE_SPAWN

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
	maxHealth = 50
	health = 50
	melee_damage_lower = 5
	melee_damage_upper = 10
	gold_core_spawnable = HOSTILE_SPAWN

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

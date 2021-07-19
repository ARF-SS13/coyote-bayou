/*East Coast "Friendly" Animals
-	Goat 		/mob/living/simple_animal/hostile/retaliate/goat
-	Brahmin		/mob/living/simple_animal/cow/brahmin
-	Radstag		/mob/living/simple_animal/radstag
-	Chicken		/mob/living/simple_animal/chicken

-	Pet Dog		/mob/living/simple_animal/pet/dog/kaiser	unique BoS pet
-	Pet Snake	/mob/living/simple_animal/pet/hognose		unique Enclave pet
-	Pet Skolf	/mob/living/simple_animal/pet/dog/skolf		unique Talon pet
*/


/mob/living/simple_animal/cow/brahmin
	name = "brahmin"
	desc = "Brahmin or brahma are mutated cattle with two heads and looking udderly ridiculous.<br>Known for their milk, just don't tip them over."
	icon = 'icons/fallout/mob/mob_friendly.dmi'
	icon_state = "brahmin"
	icon_living = "brahmin"
	icon_dead = "brahmin_dead"
	icon_gib = "brahmin_gib"
	speak = list("moo?","moo","MOOOOOO")
	speak_emote = list("moos","moos hauntingly")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	young_type = /mob/living/simple_animal/cow/brahmin/calf
	emote_hear = list("brays.")
	speak_chance = 0.4
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/reagent_containers/food/snacks/rawbrahminliver = 1, /obj/item/reagent_containers/food/snacks/rawbrahmintongue = 2, /obj/item/stack/sheet/animalhide/brahmin = 3, /obj/item/stack/sheet/bone = 2)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2)
	butcher_difficulty = 1

/mob/living/simple_animal/cow/brahmin/calf
	name = "brahmin calf"
	is_calf = 1

/mob/living/simple_animal/cow/brahmin/calf/Initialize()
	. = ..()
	resize = 0.7
	update_transform()



/mob/living/simple_animal/radstag
	name = "radstag"
	desc = "a two headed dear that will run at the first sight of danger."
	icon = 'icons/fallout/mob/mob_friendly.dmi'
	icon_state = "radstag"
	icon_living = "radstag"
	icon_dead = "radstag_dead"
	icon_gib = "radstag_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	turns_per_move = 5
	see_in_dark = 6
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/animalhide/radstag = 2, /obj/item/stack/sheet/bone = 2)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2)
	butcher_difficulty = 1

	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "kicks"
	attack_verb_simple = "kicks"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 50
	maxHealth = 50
	gold_core_spawnable = FRIENDLY_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	faction = list("neutral")


/*Faction pets
Kaiser for BoS East
Skolf for Talon East
Snek for Enclave East*/
/mob/living/simple_animal/pet/dog/kaiser
	name = "Kaiser"
	desc = "A rare pure breed rottweiler, named Kaiser."
	icon = 'icons/fallout/mob/mob_friendly.dmi'
	icon_state = "rottweiler"
	icon_living = "rottweiler"
	icon_dead = "rottweiler_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	speak = list("Grrfff!", "Woof!", "Bark!", "Awoo?")
	speak_emote = list("barks", "woofs")
	emote_hear = list("barks!", "woofs!", "whines.","pants.")
	emote_see = list("stares at nothing.", "sniffs the air.","licks its paw.")
	faction = list("dog")
	see_in_dark = 5
	speak_chance = 1
	turns_per_move = 10
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/dog/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "growls happily!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "growls!", EMOTE_AUDIBLE)
	AddElement(/datum/element/mob_holder, held_icon)

/mob/living/simple_animal/pet/hognose
	name = "Hognose snake"
	desc = "A small pet snake."
	icon = 'icons/fallout/mob/mob_friendly.dmi'
	icon_state = "snake"
	icon_living = "snake"
	icon_dead = "snake_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	speak = list("Tsssss!", "Fsssss!", "Hisssss!", "Mssss?")
	speak_emote = list("hisses")
	emote_hear = list("slithers", "sways.")
	emote_see = list("stares blankly.", "tastes the air.","coils around the nearest object.")
	faction = list("dog")
	see_in_dark = 5
	speak_chance = 1
	turns_per_move = 10
	var/held_icon = "corgi"

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/dog/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "growls happily!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "growls!", EMOTE_AUDIBLE)
	AddElement(/datum/element/mob_holder, held_icon)


/mob/living/simple_animal/pet/dog/skolf
	name = "Placeholder"
	desc = "Somehow, this Skolf has been tamed by the mercenaries. Kind of. Looks terrifying with its cranium exposed but it acts sort of like a dog."
	icon = 'icons/fallout/mob/hostile_east.dmi'
	icon_state = "skolf"
	icon_living = "skolf"
	icon_dead = "skolf_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	speak = list("Grrfff!", "Woof!", "Bark!", "Awoo?")
	speak_emote = list("barks", "woofs")
	emote_hear = list("barks!", "growls", "whines.","pants.")
	emote_see = list("stares at nothing.", "sniffs the air.","drools on the ground")
	faction = list("dog")
	see_in_dark = 5
	speak_chance = 1
	turns_per_move = 10
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/dog/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "growls happily", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "growls!", EMOTE_AUDIBLE)
	AddElement(/datum/element/mob_holder, held_icon)
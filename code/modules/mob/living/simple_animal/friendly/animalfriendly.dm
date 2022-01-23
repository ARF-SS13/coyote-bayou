/*East Coast "Friendly" Animals
-	Pet Dog		/mob/living/simple_animal/pet/dog/kaiser	unique BoS pet
-	Pet Snake	/mob/living/simple_animal/pet/hognose		unique Enclave pet
-	Pet Skolf	/mob/living/simple_animal/pet/dog/skolf		unique Talon pet
*/

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

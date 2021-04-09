/datum/reagent/compost
	name = "compost"
	description = "A mixture of waste and rotten plant matter that nurtures plants and keeps them free of pests."
	reagent_state = "SOLID"
	color = "#44341F"
	taste_description = "rot"

/datum/reagent/compost/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(0.5*REAGENTS_EFFECT_MULTIPLIER, 0)
	. = TRUE
	..()

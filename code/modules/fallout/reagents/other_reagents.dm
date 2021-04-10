/datum/reagent/compost
	name = "compost"
	description = "A mixture of waste and rotten plant matter that nurtures plants and keeps them free of pests."
	reagent_state = "SOLID"
	color = "#44341F"
	taste_description = "rot"

//Compost when used on soil
/datum/reagent/compost/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(chems.has_reagent(src.type, 1))
		mytray.adjustPests(-1)
		if(myseed && chems.has_reagent(src.type, 1))
			myseed.adjust_yield(round(chems.get_reagent_amount(src.type) * 0.1))
			myseed.adjust_potency(round(chems.get_reagent_amount(src.type) * 0.25))
// Compost when drunk..?
/datum/reagent/compost/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(0.5*REAGENTS_EFFECT_MULTIPLIER, 0)
	. = TRUE
	..()

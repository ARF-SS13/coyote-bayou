/datum/reagent/consumable/mutjuice
	name = "Mutfruit Juice"
	description = "The sweet-salty juice of the mutfruit."
	color = "#660099"
	taste_description = "sweet and salty"
	glass_name = "glass of mutfruit juice"
	glass_desc = "A glass of sweet-salty mutfruit juice."

/datum/reagent/consumable/mutjuice/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() && prob(50))
		M.heal_bodypart_damage(0,1*REM, 0)
		. = TRUE
	..()

/datum/reagent/consumable/yuccajuice
	name = "Yucca Juice"
	description = "The raw essence of a	banana yucca."
	color = "#863333" // rgb: 175, 175, 0
	taste_description = "sand and bunker-air"
	glass_icon_state = "banana"
	glass_name = "glass of yucca juice"
	glass_desc = "A wastelanders favourite."

/datum/reagent/consumable/tato_juice
	name = "Tato Juice"
	description = "Juice of the tato. Smells like bad eggs."
	nutriment_factor = 3 * REAGENTS_METABOLISM
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "rotten ketchup"
	glass_icon_state = "glass_brown"
	glass_name = "glass of tato juice"
	glass_desc = "Juice of the tato. Smells like bad eggs."

/datum/reagent/consumable/fever_blossom_juice
	name = "Fever Blossom Juice"
	description = "The concentrated juice and nectar of a fever blossom. It has soothing, relaxing effects."
	nutriment_factor = 1 * REAGENTS_METABOLISM
	color = "#000000" //same purple
	taste_description = "pleasant flowers"

/datum/reagent/consumable/fever_blossom_juice/on_mob_life(mob/living/carbon/M)
	M.jitteriness = max(0,M.jitteriness - 5)
	M.dizziness = max(0,M.dizziness - 5)
	M.drowsyness += 3
	. = TRUE
	..()

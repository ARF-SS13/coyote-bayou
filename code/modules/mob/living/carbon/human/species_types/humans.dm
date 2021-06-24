/datum/species/human
	name = "Human"
	id = "human"
	default_color = "FFFFFF"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,MUTCOLORS_PARTSONLY,WINGCOLOR,HAS_FLESH,HAS_BONE)
	mutant_bodyparts = list("mcolor" = "FFFFFF", "mcolor2" = "FFFFFF","mcolor3" = "FFFFFF","tail_human" = "None", "ears" = "None", "taur" = "None", "deco_wings" = "None")
	use_skintones = USE_SKINTONES_GRAYSCALE_CUSTOM
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | LONGPORK
	liked_food = JUNKFOOD | FRIED

	tail_type = "tail_human"
	wagging_type = "waggingtail_human"
	species_type = "human"

/datum/species/human/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/human/spec_life(mob/living/carbon/human/H)
	if (H.radiation>2500 && prob(10))
		to_chat(H, "<span class='danger'>Your skin becomes to peel and fall off from radiation, also turning your voice into a rasp...</span>")
		H.set_species(/datum/species/ghoul)
		H.Stun(40)
		H.radiation = 0

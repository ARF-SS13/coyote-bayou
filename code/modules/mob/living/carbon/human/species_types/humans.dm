/datum/species/human
	name = "Human"
	id = SPECIES_HUMAN
	default_color = "FFFFFF"

	species_traits = list(
		EYECOLOR,
		HAIR,
		FACEHAIR,
		LIPS,
		MUTCOLOR_PARTSONLY,
		WINGCOLOR,
		HAS_FLESH,
		HAS_BONE
	)
	mutant_bodyparts = list(MBP_COLOR1 = "FFFFFF",
		MBP_COLOR2 = "FFFFFF",
		MBP_COLOR3 = "FFFFFF",
		MBP_SNOUT = "Husky",
		MBP_TAIL = "Husky",
		MBP_EARS = "Husky",
		MBP_WINGS_DECORATIVE = "None",
		MBP_BODY_MARKINGS = "Husky",
		MBP_TAUR = "None",
		MBP_HORNS = "None",
		MBP_LEGS = LEGS_PLANTIGRADE,
		MBP_MEAT_TYPE = MEAT_MAMMAL
	)
	use_skintones = USE_SKINTONES_GRAYSCALE_CUSTOM
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | LONGPORK
	liked_food = JUNKFOOD | FRIED

	tail_type = MBP_TAIL_HUMAN
	wagging_type = MBP_TAIL_WAGGING_HUMAN
	species_type = SPECIES_TYPE_HUMAN

/datum/species/human/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/human/spec_life(mob/living/carbon/human/H)

	if (H.radiation>2500 && prob(10) && !(HAS_TRAIT(H,TRAIT_FEV)||HAS_TRAIT(H,TRAIT_RADIMMUNE)))
		to_chat(H, span_danger("Your skin becomes to peel and fall off from radiation, also turning your voice into a rasp..."))
		H.set_species(/datum/species/ghoul)
		H.Stun(40)
		H.radiation = 0

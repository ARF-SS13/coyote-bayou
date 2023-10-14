/datum/species/human
	name = "Human"
	id = "human"
	default_color = "FFFFFF"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,MUTCOLORS_PARTSONLY,WINGCOLOR,HAS_FLESH,HAS_BONE)
	mutant_bodyparts = list("mcolor" = "FFFFFF", "mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_snouts" = "Husky", "mam_tail" = "Husky", "mam_ears" = "Husky", "deco_wings" = "None",
						"mam_body_markings" = "Husky", "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	use_skintones = USE_SKINTONES_GRAYSCALE_CUSTOM
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | LONGPORK
	liked_food = JUNKFOOD | FRIED

	tail_type = "mam_tail"
	wagging_type = "mam_waggingtail"
	species_type = "furry"

/datum/species/human/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/human/spec_life(mob/living/carbon/human/H)

	if (H.radiation>2500 && prob(10) && !(HAS_TRAIT(H,TRAIT_FEV)||HAS_TRAIT(H,TRAIT_RADIMMUNE)))
		to_chat(H, span_danger("Your skin begins to peel and fall off from radiation! Meanwhile you feel your vocal cords burn and twist your voice into a horrible rasping growl!"))
		H.set_species(/datum/species/ghoul)
		H.Stun(40)
		H.radiation = 0

/datum/species/dwarf //not to be confused with the genetic manlets
	name = "Dwarf"
	id = "dwarf" //Also called Homo sapiens pumilionis
	default_color = "FFFFFF"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,MUTCOLORS,HORNCOLOR,WINGCOLOR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_DWARF)
	limbs_id = "human"
	mutant_bodyparts = list("mcolor" = "FFFFFF","mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_snouts" = "Husky", "mam_tail" = "Husky", "mam_ears" = "Husky", "deco_wings" = "None", "mam_body_markings" = "Husky", "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | TOXIC
	liked_food = JUNKFOOD | FRIED

	tail_type = "tail_human"
	wagging_type = "waggingtail_human"
	species_type = "human"

	allowed_limb_ids = list("human","mammal","aquatic","avian")


/mob/living/carbon/human/species/dwarf //species admin spawn path
	race = /datum/species/dwarf //and the race the path is set to.

/datum/species/dwarf/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	var/mob/living/carbon/human/H = C
	H.AddElement(/datum/element/dwarfism, COMSIG_SPECIES_LOSS, src)

/datum/species/dwarf/on_species_loss(mob/living/carbon/H, datum/species/new_species)
	. = ..()


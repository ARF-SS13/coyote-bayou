
#define SPECIES_TAJARAN	"tajaran"

/datum/species/mammal/tajaran
	name = "Tajaran"
	icon = 'modular_coyote/icons/mob/races/tajaran.dmi'
	id = SPECIES_TAJARAN
	say_mod = "says"
	mutant_bodyparts = list("mcolor" = "FFFFFF", "mcolor2" = "FFFFFF", "mcolor3" = "FFFFFF", "mam_tail" = "Shadekin", "mam_ears" = "Shadekin", "deco_wings" = "None",
						"taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	allowed_limb_ids = list("mammal","aquatic","avian","shadekin")
	limbs_id = "tajaran"
	species_type = "furry"

/mob/living/carbon/human/species/mammal/tajaran
	race = /datum/species/mammal/tajaran
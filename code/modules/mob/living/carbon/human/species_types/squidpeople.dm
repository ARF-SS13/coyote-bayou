// Gob's squidwardian species
// made for splurt, ported by han
#define SPECIES_SQUID	"squid"

/datum/species/squid
	name = "Squidperson"
	id = SPECIES_SQUID
	mutant_bodyparts = list("mcolor" = "FFFFFF", "mcolor2" = "FFFFFF", "mcolor3" = "FFFFFF", "mam_tail" = "None", "mam_ears" = "None", "deco_wings" = "None",
						"taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	allowed_limb_ids = list("mammal","aquatic","avian","shadekin")
	limbs_id = "squid"
	disliked_food = FRIED
	no_equip = list(SLOT_SHOES)

/mob/living/carbon/human/species/squid
	race = /datum/species/squid
	
/datum/species/squid/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_moth_name()

	var/randname = squid_name()

	if(lastname)
		randname += " [lastname]"

	return randname

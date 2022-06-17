// Gat1Day's powerless shadekin
// yoinked from splurt, ported into by gremling.
#define SPECIES_SHADEKIN	"shadekin"

/datum/species/mammal/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	say_mod = "mars"
	mutant_bodyparts = list("mcolor" = "FFFFFF", "mcolor2" = "FFFFFF", "mcolor3" = "FFFFFF", "mam_tail" = "Shadekin", "mam_ears" = "Shadekin", "deco_wings" = "None",
						"taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	allowed_limb_ids = list("mammal","aquatic","avian","shadekin")
	mutanteyes = /obj/item/organ/eyes/shadekin
	limbs_id = "shadekin"

/obj/item/organ/eyes/shadekin
	name = "ipc eyes"
	icon = 'icons/mob/shadekin/eyes.dmi'
	icon_state = "cybernetic_eyeballs"


/mob/living/carbon/human/species/mammal/shadekin
	race = /datum/species/mammal/shadekin

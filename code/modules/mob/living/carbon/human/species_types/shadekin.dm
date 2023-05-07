// Gat1Day's powerless shadekin
// yoinked from splurt, ported into by gremling.

/datum/species/mammal/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	limbs_id = BODYTYPE_SHADEKIN
	say_mod = "mars"
	mutant_bodyparts = list(
		MBP_COLOR1 = "FFFFFF",
		MBP_COLOR2 = "FFFFFF",
		MBP_COLOR3 = "FFFFFF",
		MBP_TAIL = "Shadekin",
		MBP_EARS = "Shadekin",
		MBP_WINGS_DECORATIVE = "None",
		MBP_TAUR = "None",
		MBP_HORNS = "None",
		MBP_LEGS = LIMB_PLANTIGRADE,
		MBP_MEAT_TYPE = MEAT_MAMMAL
	)
	allowed_limb_ids = list(
		BODYTYPE_FURRY,
		BODYTYPE_AVIAN,
		BODYTYPE_AQUATIC,
		BODYTYPE_SHADEKIN
	)
	mutanteyes = /obj/item/organ/eyes/shadekin
	species_type = SPECIES_TYPE_FURRY

/obj/item/organ/eyes/shadekin
	name = "ipc eyes"
	icon = 'icons/mob/mam/shadekin/shadekin_eyes.dmi'
	icon_state = "cybernetic_eyeballs"


/mob/living/carbon/human/species/mammal/shadekin
	race = /datum/species/mammal/shadekin

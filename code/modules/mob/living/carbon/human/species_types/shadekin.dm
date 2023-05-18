// Gat1Day's powerless shadekin
// yoinked from splurt, ported into by gremling.

/datum/species/mammal/shadekin
	name = BODYTYPE_SHADEKIN
	id = SPECIES_SHADEKIN
	limbs_id = BODYTYPE_SHADEKIN
	allowed_limb_ids = list(
		BODYTYPE_FURRY,
		BODYTYPE_AVIAN,
		BODYTYPE_AQUATIC,
		BODYTYPE_SHADEKIN
	)
	say_mod = "mars"
	mutant_bodyparts = list(
		FEATURE_COLOR_1 = "FFFFFF",
		FEATURE_COLOR_2 = "FFFFFF",
		FEATURE_COLOR_3 = "FFFFFF",
		MBP_TAIL = BODYTYPE_SHADEKIN,
		MBP_EARS = BODYTYPE_SHADEKIN,
		MBP_WINGS_DECORATIVE = ACCESSORY_NONE,
		MBP_TAUR = ACCESSORY_NONE,
		MBP_HORNS = ACCESSORY_NONE,
		MBP_LEGS = LEGS_PLANTIGRADE,
		MBP_MEAT_TYPE = MEAT_MAMMAL
	)

	mutanteyes = /obj/item/organ/eyes/shadekin
	species_type = SPECIES_TYPE_FURRY

/obj/item/organ/eyes/shadekin
	name = "ipc eyes"
	icon = 'icons/mob/mam/shadekin/shadekin_eyes.dmi'
	icon_state = "cybernetic_eyeballs"


/mob/living/carbon/human/species/mammal/shadekin
	race = /datum/species/mammal/shadekin

/datum/sprite_accessory/frills
	icon = 'icons/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_ADJ_LAYER)
	mutant_part_string = MBP_FRILLS

/datum/sprite_accessory/frills/is_not_visible(mob/living/carbon/human/H, tauric)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features[MBP_FRILLS] || H.dna.features[MBP_FRILLS] == ACCESSORY_NONE || H.head && (H.head.flags_inv & HIDEEARS) || !HD || HD.status == BODYPART_ROBOTIC)

/datum/sprite_accessory/frills/none
	name = ACCESSORY_NONE
	icon_state = ACCESSORY_ICON_STATE_NONE
	relevant_layers = null

/datum/sprite_accessory/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/frills/short
	name = "Short"
	icon_state = "short"

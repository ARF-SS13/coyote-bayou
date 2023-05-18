/datum/sprite_accessory/spines
	icon = 'icons/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)
	mutant_part_string = MBP_TAIL_SPINES

/datum/sprite_accessory/spines/is_not_visible(mob/living/carbon/human/H, tauric)
	return (!H.dna.features[MBP_TAIL_SPINES] || H.dna.features[MBP_TAIL_SPINES] == ACCESSORY_NONE || H.wear_suit && (H.wear_suit.flags_inv & HIDETAUR))

/datum/sprite_accessory/spines_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'
	mutant_part_string = MBP_TAIL_WAGGING_SPINES
	transformed_part_string = MBP_TAIL_SPINES
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)

/datum/sprite_accessory/spines_animated/is_not_visible(mob/living/carbon/human/H, tauric)
	return ((!H.dna.features[MBP_TAIL_SPINES] || H.dna.features[MBP_TAIL_SPINES] == ACCESSORY_NONE || H.wear_suit && (H.wear_suit.flags_inv & HIDETAUR)) || H.dna.species.mutant_bodyparts["tail"])

/datum/sprite_accessory/spines/none
	name = ACCESSORY_NONE
	icon_state = ACCESSORY_ICON_STATE_NONE
	relevant_layers = null

/datum/sprite_accessory/spines_animated/none
	name = ACCESSORY_NONE
	icon_state = ACCESSORY_ICON_STATE_NONE

/datum/sprite_accessory/spines/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/spines_animated/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/spines/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines_animated/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines_animated/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines_animated/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/spines_animated/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

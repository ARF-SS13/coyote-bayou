//MAIN BODY
/datum/sprite_accessory/derg_body
	icon = 'icons/mob/dragon/dragon_body.dmi'	
	relevant_layers = list(BODY_BEHIND_LAYER)
	color_src = MUTCOLORS2
	mutant_part_string = "derg_body"
	dimension_x = 128
	center = TRUE

/datum/sprite_accessory/derg_body/smooth
	name = "Smooth Dragon Body"	
	icon_state = "dragon_bodySmooth"

/datum/sprite_accessory/derg_body/scaled
	name = "Scaled Dragon Body"	
	icon_state = "dragon_bodyScaled"


//BELLY
/datum/sprite_accessory/derg_belly
	icon = 'icons/mob/dragon/dragon_belly.dmi'	
	relevant_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	color_src = MUTCOLORS2
	mutant_part_string = "derg_belly"
	dimension_x = 128
	center = TRUE

/datum/sprite_accessory/derg_belly/none
	name = "None"	
	icon_state = "none"
	relevant_layers = null
	dimension_x = 32
	center = FALSE

/datum/sprite_accessory/derg_belly/smooth
	name = "Dragon Under Smooth"	
	icon_state = "dragon_underSmooth"

/datum/sprite_accessory/derg_belly/smooth_two
	name = "Dragon Under Smooth 2"	
	icon_state = "dragon_underSmooth-2"

/datum/sprite_accessory/derg_belly/plated
	name = "Dragon Under Plated"	
	icon_state = "dragon_underPlated"

/datum/sprite_accessory/derg_belly/plated_two
	name = "Dragon Under Plated 2"	
	icon_state = "dragon_underPlated-2"

//HORNS
/datum/sprite_accessory/derg_horns
	icon = 'icons/mob/dragon/dragon_horns.dmi'	
	relevant_layers = list(HORNS_LAYER)
	color_src = MUTCOLORS
	mutant_part_string = "derg_horns"
	recommended_species = list("dragon")
	dimension_x = 128
	center = TRUE

/datum/sprite_accessory/derg_horns/smooth
	name = "None"	
	icon_state = "none"
	relevant_layers = null
	dimension_x = 32
	center = FALSE

/datum/sprite_accessory/derg_horns/pointy
	name = "Pointy"
	icon_state = "dragon_hornsPointy"

/datum/sprite_accessory/derg_horns/curved
	name = "Curved"
	icon_state = "dragon_hornsCurved"

/datum/sprite_accessory/derg_horns/curved_two
	name = "Curved 2"
	icon_state = "dragon_hornsCurved2"

/datum/sprite_accessory/derg_horns/jagged
	name = "Jagged"
	icon_state = "dragon_hornsJagged"

/datum/sprite_accessory/derg_horns/crown
	name = "Crown"
	icon_state = "dragon_hornsCrown"

/datum/sprite_accessory/derg_horns/skull
	name = "Skull"
	icon_state = "dragon_hornsSkull"

//MANES
/datum/sprite_accessory/derg_mane
	icon = 'icons/mob/dragon/dragon_manes.dmi'
	color_src = MUTCOLORS
	mutant_part_string = "derg_mane"
	dimension_x = 128
	center = TRUE
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/derg_mane/none
	name = "None"
	icon_state = "dragon_maneNone"	
	relevant_layers = null
	dimension_x = 32
	center = FALSE
	
/datum/sprite_accessory/derg_mane/shaggy
	name = "Shaggy"
	icon_state = "dragon_maneShaggy"	
	
/datum/sprite_accessory/derg_mane/dorsalfin
	name = "Dorsal Fin"
	icon_state = "dragon_maneDorsalfin"	

//EARS
/datum/sprite_accessory/derg_ears
	icon = 'icons/mob/dragon/dragon_ears.dmi'
	relevant_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	color_src = MUTCOLORS
	mutant_part_string = "derg_ears"
	dimension_x = 128
	center = TRUE

/datum/sprite_accessory/derg_ears/none
	name = "None"
	icon_state = "none"
	relevant_layers = null
	dimension_x = 32
	center = FALSE

/datum/sprite_accessory/derg_ears/normal
	name = "Normal"
	icon_state = "dragon_earsNormal"

//EYES
/datum/sprite_accessory/derg_eyes
	icon = 'icons/mob/dragon/dragon_eyes.dmi'
	color_src = MUTCOLORS3
	mutant_part_string = "derg_eyes"
	dimension_x = 128
	center = TRUE
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/derg_eyes/none
	name = "None"
	icon_state = "none"
	relevant_layers = null
	dimension_x = 32
	center = FALSE

/datum/sprite_accessory/derg_eyes/normal
	name = "Normal"
	icon_state = "dragon_eyesNormal"

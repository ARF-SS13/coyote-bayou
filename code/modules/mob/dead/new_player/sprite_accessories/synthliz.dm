//Synth snouts (This is the most important part)
/datum/sprite_accessory/snouts/mam_snouts/synthliz
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	icon = 'icons/mob/mam/citadel/synthliz_snouts.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Snout"
	icon_state = "synthliz_basic"

/datum/sprite_accessory/snouts/mam_snouts/synthliz/synthliz_under
	icon = 'icons/mob/mam/citadel/synthliz_snouts.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Snout Under"
	icon_state = "synthliz_under"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/synthliz/synthliz_tert
	icon = 'icons/mob/mam/citadel/synthliz_snouts.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Snout Tertiary"
	icon_state = "synthliz_tert"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/snouts/mam_snouts/synthliz/synthliz_tertunder
	icon = 'icons/mob/mam/citadel/synthliz_snouts.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Snout Tertiary Under"
	icon_state = "synthliz_tertunder"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/snouts/mam_snouts/synthliz/synthliz_comm
	icon = 'icons/mob/mam/citadel/synthliz_snouts.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Legacy Systems"
	icon_state = "synthliz_commodore"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/snouts/mam_snouts/synthliz/synthliz_communder
	icon = 'icons/mob/mam/citadel/synthliz_snouts.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Legacy Systems Under"
	icon_state = "synthliz_commodoreunder"
	matrixed_sections = MATRIX_ALL

//-->Protogen Snouts
//Spriter: Ekizius

/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MUTCOLORS
	name = "Protogen - Snout"
	icon_state = "proto_basic"

/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen/protogen_under
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MATRIXED
	name = "Protogen - Snout Under"
	icon_state = "proto_under"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen/protogen_tert
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MATRIXED
	name = "Protogen - Snout Tertiary"
	icon_state = "proto_tert"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen/protogen_tertunder
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MATRIXED
	name = "Protogen - Snout Tertiary Under"
	icon_state = "proto_tertunder"
	matrixed_sections = MATRIX_ALL
//<--

//-->Pointy protogen snouts
//Spriter: sampletex
/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen_beak
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MUTCOLORS
	name = "Protogen with Beak - Snout"
	icon_state = "proto_beak_basic"

/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen_beak/protogen_under
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MATRIXED
	name = "Protogen with Beak - Snout Under"
	icon_state = "proto_beak_under"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen_beak/protogen_tert
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MATRIXED
	name = "Protogen with Beak - Snout Tertiary"
	icon_state = "proto_beak_tert"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/snouts/mam_snouts/synthliz/protogen_beak/protogen_tertunder
	icon = 'icons/mob/mam/citadel/proto_snouts.dmi'
	color_src = MATRIXED
	name = "Protogen with Beak - Snout Tertiary Under"
	icon_state = "proto_beak_tertunder"
	matrixed_sections = MATRIX_ALL

//<--

//Synth body markings
/datum/sprite_accessory/mam_body_markings/synthliz/synthliz_pecs
	icon = 'icons/mob/mam/citadel/synthliz_body_markings.dmi'
	name = "Synthetic Lizard - Pecs"
	icon_state = "synthlizpecs"
	covered_limbs = list("Chest" = MATRIX_GREEN)

/datum/sprite_accessory/mam_body_markings/synthliz/synthliz_pecslight
	icon = 'icons/mob/mam/citadel/synthliz_body_markings.dmi'
	name = "Synthetic Lizard - Pecs Light"
	icon_state = "synthlizpecslight"
	covered_limbs = list("Chest" = MATRIX_GREEN_BLUE)

/datum/sprite_accessory/mam_body_markings/synthliz
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	icon = 'icons/mob/mam/citadel/synthliz_body_markings.dmi'
	name = "Synthetic Lizard - Plates"
	icon_state = "synthlizscutes"
	covered_limbs = list("Chest" = MATRIX_GREEN)

//Synth tails
/datum/sprite_accessory/tails/mam_tails/synthliz
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	icon = 'icons/mob/mam/citadel/synthliz_tails.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard"
	icon_state = "synthliz"

/datum/sprite_accessory/tails_animated/mam_tails_animated/synthliz
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	icon = 'icons/mob/mam/citadel/synthliz_tails.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard"
	icon_state = "synthliz"

//Synth Antennae
/datum/sprite_accessory/antenna/synthliz
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Antennae"
	icon_state = "synth_antennae"

/datum/sprite_accessory/antenna/synthliz/synthliz_curled
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Curled"
	icon_state = "synth_curled"

/datum/sprite_accessory/antenna/synthliz/synth_horns
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Horns"
	icon_state = "synth_horns"

/datum/sprite_accessory/antenna/synthliz/synth_hornslight
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Horns Light"
	icon_state = "synth_hornslight"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/antenna/synthliz/synth_short
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Short"
	icon_state = "synth_short"

/datum/sprite_accessory/antenna/synthliz/synth_sharp
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Sharp"
	icon_state = "synth_sharp"

/datum/sprite_accessory/antenna/synthliz/synth_sharplight
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Sharp Light"
	icon_state = "synth_sharplight"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/antenna/synthliz/synth_nub
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Nub"
	icon_state = "synth_nub"

/datum/sprite_accessory/antenna/synthliz/synth_nublight
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Nub Light"
	icon_state = "synth_nublight"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/antenna/synthliz/synthliz_thick
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Synthetic Lizard - Thick"
	icon_state = "synth_thick"

/datum/sprite_accessory/antenna/synthliz/synth_thicklight
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MATRIXED
	name = "Synthetic Lizard - Thick Light"
	icon_state = "synth_thicklight"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/antenna/synthliz/eartenna
	icon = 'icons/mob/mam/citadel/synthliz_antennas.dmi'
	color_src = MUTCOLORS
	name = "Protogen - Eartennas"
	icon_state = "synth_eartenna"

//Synth Taurs (Ported from Virgo)
/datum/sprite_accessory/taur/synthliz
	name = "Virgo - Synthetic Lizard"
	icon_state = "synthlizard"
	taur_mode = STYLE_PAW_TAURIC
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/synthliz/inv
	name = "Virgo - Synthetic Lizard (Inverted)"
	icon_state = "synthlizardinv"

/datum/sprite_accessory/taur/synthliz/feline
	name = "Virgo - Synthetic Feline"
	icon_state = "synthfeline"

/datum/sprite_accessory/taur/synthliz/feline/inv
	name = "Virgo - Synthetic Feline (Inverted)"
	icon_state = "synthfelineinv"

/datum/sprite_accessory/taur/synthliz/horse
	name = "Virgo - Synthetic Horse"
	icon_state = "synthhorse"
	taur_mode = STYLE_HOOF_TAURIC
	alt_taur_mode = STYLE_PAW_TAURIC

/datum/sprite_accessory/taur/synthliz/horse/inv
	name = "Virgo - Synthetic Horse (Inverted)"
	icon_state = "synthhorseinv"

/datum/sprite_accessory/taur/synthliz/wolf
	name = "Virgo - Synthetic Wolf"
	icon_state = "synthwolf"

/datum/sprite_accessory/taur/synthliz/wolf/inv
	name = "Virgo - Synthetic Wolf (Inverted)"
	icon_state = "synthwolfinv"

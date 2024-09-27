/datum/sprite_accessory/legs 	//legs are a special case, they aren't actually sprite_accessories but are updated with them. -- OR SO THEY USED TO BE
	icon = null					//These datums exist for selecting legs on preference, and little else

/******************************************
***************** Leggy *******************
*******************************************/

/datum/sprite_accessory/legs/none
	name = "Plantigrade"

/datum/sprite_accessory/legs/digitigrade_lizard
	name = "Digitigrade"

/datum/sprite_accessory/legs/digitigrade_bird
	name = "Avian"


/******************************************
************** Taur Bodies ****************
*******************************************/

/datum/sprite_accessory/taur
	icon = 'icons/mob/mam/citadel/mam_taur.dmi'
	center = TRUE
	dimension_x = 64
	color_src = MATRIXED
	recommended_species = list("human", "mammal", "xeno", "insect", "slimeperson", "jelly", "podweak", "shadekin", "ghoul", "synthfurry", "synthliz", "lizard", "ipc")
	relevant_layers = list(BODY_ADJ_UPPER_LAYER, BODY_FRONT_LAYER)
	var/taur_mode = NONE //Must be a single specific tauric suit variation bitflag. Don't do FLAG_1|FLAG_2
	var/alt_taur_mode = NONE //Same as above.
	var/hide_legs = USE_QUADRUPED_CLIP_MASK
	mutant_part_string = "taur"

/datum/sprite_accessory/taur/is_not_visible(mob/living/carbon/human/H, tauric)
	return (!tauric || (H.wear_suit && (H.wear_suit.flags_inv & HIDETAUR)))

/datum/sprite_accessory/taur/New()
	switch(hide_legs)
		if(USE_QUADRUPED_CLIP_MASK)
			alpha_mask_state = "taur_mask_def"
		if(USE_SNEK_CLIP_MASK)
			alpha_mask_state = "taur_mask_naga"

/datum/sprite_accessory/taur/none
	name = "None"
	icon_state = "None"
	dimension_x = 32
	center = FALSE
	recommended_species = null
	relevant_layers = null
	hide_legs = FALSE

/datum/sprite_accessory/taur/canine
	name = "Canine"
	icon_state = "canine"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = TRUE

/datum/sprite_accessory/taur/cow
	name = "Cow"
	icon_state = "cow"
	taur_mode = STYLE_HOOF_TAURIC
	alt_taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS

/datum/sprite_accessory/taur/cow/spotted
	name = "Cow (Spotted)"
	icon_state = "cow_spotted"
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/deer
	name = "Deer"
	icon_state = "deer"
	taur_mode = STYLE_HOOF_TAURIC
	alt_taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = TRUE

/datum/sprite_accessory/taur/drake
	name = "Drake"
	icon_state = "drake"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = TRUE

/datum/sprite_accessory/taur/drake/old
	name = "Drake (Old)"
	icon_state = "drake_old"
	color_src = MATRIXED
	extra = FALSE
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/drider
	name = "Drider"
	icon_state = "drider"
	color_src = MUTCOLORS
	extra = TRUE

/datum/sprite_accessory/taur/eevee
	name = "Eevee"
	icon_state = "eevee"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = TRUE

/datum/sprite_accessory/taur/feline
	name = "Feline"
	icon_state = "feline"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = TRUE

/datum/sprite_accessory/taur/horse
	name = "Horse"
	icon_state = "horse"
	taur_mode = STYLE_HOOF_TAURIC
	alt_taur_mode = STYLE_PAW_TAURIC
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/naga
	name = "Naga"
	icon_state = "naga"
	taur_mode = STYLE_SNEK_TAURIC
	hide_legs = USE_SNEK_CLIP_MASK
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/otie
	name = "Otie"
	icon_state = "otie"
	taur_mode = STYLE_PAW_TAURIC
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/pede
	name = "Scolipede"
	icon_state = "pede"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = TRUE
	extra2 = TRUE

/datum/sprite_accessory/taur/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	taur_mode = STYLE_SNEK_TAURIC
	color_src = MUTCOLORS
	hide_legs = USE_SNEK_CLIP_MASK

/datum/sprite_accessory/taur/frog
	name = "Frog"
	icon_state = "frog"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = FALSE

/datum/sprite_accessory/taur/wasp
	name = "Wasp"
	icon_state = "wasp"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = FALSE

/datum/sprite_accessory/taur/mermaid
	name = "Mermaid"
	icon_state = "mermaid"
	taur_mode = STYLE_SNEK_TAURIC
	color_src = MUTCOLORS
	extra = FALSE

/datum/sprite_accessory/taur/skunk
	name = "Skunk"
	icon_state = "skunk"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/rat
	name = "Rat"
	icon_state = "rat"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/noodle
	name = "Noodle"
	icon_state = "noodle"
	taur_mode = STYLE_SNEK_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/leopardseal
	name = "Leopard Seal"
	icon_state = "leopardseal"
	taur_mode = STYLE_SNEK_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/moth
	name = "Moth"
	icon_state = "moth"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = FALSE

/datum/sprite_accessory/taur/catslug
	name = "catslug"
	icon_state = "scug"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = FALSE

/datum/sprite_accessory/taur/bigcat
	name = "Big Cat"
	icon_state = "bigcat"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = TRUE

/datum/sprite_accessory/taur/teppi
	name = "Teppi"
	icon = 'icons/mob/mam/coyote/taurs128x64_vr.dmi'
	icon_state = "teppi"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MUTCOLORS
	extra = FALSE
	dimension_x = -32
	dimension_y= 11

/datum/sprite_accessory/taur/spiderlong
	name = "Long spider"
	icon_state = "spiderlong"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/fox
	name = "Fox"
	icon_state = "fox"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/drone
	name = "Sect Drone"
	icon_state = "drone"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/redpanda
	name = "Red Panda"
	icon_state = "redpanda"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/nightstalker
	name = "nightstalker"
	icon_state = "stalker"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/leopard
	name = "leopard"
	icon_state = "leopard"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/taur/sergal
	name = "sergal"
	icon_state = "sergal"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/taur/bunny
	name = "bunny"
	icon_state = "bunny"
	taur_mode = STYLE_PAW_TAURIC
	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL










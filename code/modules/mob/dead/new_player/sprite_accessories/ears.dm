/datum/sprite_accessory/ears
	icon = 'icons/mob/mutant_bodyparts.dmi'
	mutant_part_string = "ears"
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/ears/is_not_visible(mob/living/carbon/human/H, tauric)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["ears"] || H.dna.features["ears"] == "None" || H.head && (H.head.flags_inv & HIDEEARS) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEEARS)) || !HD || (HD.status == BODYPART_ROBOTIC && !HD.render_like_organic))

/datum/sprite_accessory/ears/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/******************************************
*************** Human Ears ****************
*******************************************/


/datum/sprite_accessory/ears/human/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/bat
	name = "Bat"
	icon_state = "bat"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/bear
	name = "Bear"
	icon_state = "bear"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/bigwolf
	name = "Big Wolf"
	icon_state = "bigwolf"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/human/bigwolfsplayed
	name = "Big Wolf - Splayed"
	icon_state = "bigwolfsplayed"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/human/bigwolfinner
	name = "Big Wolf (ALT)"
	icon_state = "bigwolfinner"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	extra = TRUE
	extra_color_src = NONE
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/bigwolfdark //alphabetical sort ignored here for ease-of-use
	name = "Dark Big Wolf"
	icon_state = "bigwolfdark"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/human/bigwolfinnerdark
	name = "Dark Big Wolf (ALT)"
	icon_state = "bigwolfinnerdark"
	extra = TRUE
	extra_color_src = NONE
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/bunny
	name = "Bunny"
	icon_state = "bunny"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/bunnyalt
	name = "Bunny (ALT)"
	icon_state = "bunnyalt"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/cat
	name = "Cat"
	icon_state = "cat"
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = HAIR
	extra = TRUE
	extra_color_src = NONE

/datum/sprite_accessory/ears/human/catbig
	name = "Cat, Big"
	icon_state = "catbig"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/catbigsplayed
	name = "Cat, Big - Splayed"
	icon_state = "catbigsplayed"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN


/datum/sprite_accessory/ears/human/cobra
	name = "Cobra Hood"
	icon_state = "cobra"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/ears/human/cow
	name = "Cow"
	icon_state = "cow"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/curled
	name = "Curled Horn"
	icon_state = "horn1"
	color_src = MUTCOLORS3

/datum/sprite_accessory/ears/human/deer
	name = "Deer"
	icon_state = "deer"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/dog
	name = "Dog"
	icon_state = "lab"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/eevee
	name = "Eevee"
	icon_state = "eevee"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/elf
	name = "Elf"
	icon_state = "elf"
	color_src = MUTCOLORS3

/datum/sprite_accessory/ears/human/elephant
	name = "Elephant"
	icon_state = "elephant"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/fennec
	name = "Fennec"
	icon_state = "fennec"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/human/fennecsplayed
	name = "Fennec - Splayed"
	icon_state = "fennecsplayed"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/human/fennec2
	name = "Fennec (ALT)"
	icon_state = "fennec2"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/human/fish
	name = "Fish"
	icon_state = "fish"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/human/fox
	name = "Fox"
	icon_state = "fox"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/fox/foxsplayed
	name = "Fox - Splayed"
	icon_state = "foxsplayed"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/husky
	name = "Husky"
	icon_state = "wolf"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/human/jellyfish
	name = "Jellyfish"
	icon_state = "jellyfish"
	color_src = HAIR

/datum/sprite_accessory/ears/human/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/murid
	name = "Murid"
	icon_state = "murid"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/otie
	name = "Otusian"
	icon_state = "otie"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/rabbitalt
	name = "Rabbit (ALT)"
	icon_state = "rabbitalt"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/ears/human/pede
	name = "Scolipede"
	icon_state = "pede"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/sergal
	name = "Sergal"
	icon_state = "sergal"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/skunk
	name = "Skunk"
	icon_state = "skunk"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/human/wolf
	name = "Wolf"
	icon_state = "wolf"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE


/******************************************
*************** Furry Ears ****************
*******************************************/

/datum/sprite_accessory/ears/mam_ears
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	color_src = MATRIXED
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/ears/mam_ears/is_not_visible(mob/living/carbon/human/H, tauric)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["mam_ears"] || H.dna.features["mam_ears"] == "None" || H.head && (H.head.flags_inv & HIDEEARS) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEEARS)) || !HD || (HD.status == BODYPART_ROBOTIC && !HD.render_like_organic))

/datum/sprite_accessory/ears/mam_ears/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/ears/mam_ears/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/bat
	name = "Bat"
	icon_state = "bat"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/bear
	name = "Bear"
	icon_state = "bear"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/bigwolf
	name = "Big Wolf"
	icon_state = "bigwolf"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/bigwolfsplayed
	name = "Big Wolf - Splayed"
	icon_state = "bigwolfsplayed"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/bigwolfinner
	name = "Big Wolf (ALT)"
	icon_state = "bigwolfinner"
	extra = TRUE
	extra_color_src = NONE
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/bigwolfdark //alphabetical sort ignored here for ease-of-use
	name = "Dark Big Wolf"
	icon_state = "bigwolfdark"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/bigwolfinnerdark
	name = "Dark Big Wolf (ALT)"
	icon_state = "bigwolfinnerdark"
	extra = TRUE
	extra_color_src = NONE
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/bunny
	name = "Bunny"
	icon_state = "bunny"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/bunnyalt
	name = "Bunny (ALT)"
	icon_state = "bunnyalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/cat
	name = "Cat"
	icon_state = "cat"
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = HAIR
	extra = TRUE
	extra_color_src = NONE

/datum/sprite_accessory/ears/mam_ears/catbig
	name = "Cat, Big"
	icon_state = "catbig"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/catbigsplayed
	name = "Cat, Big - Splayed"
	icon_state = "catbigsplayed"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/cobra
	name = "Cobra Hood"
	icon_state = "cobra"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/ears/mam_ears/cow
	name = "Cow"
	icon_state = "cow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/curled
	name = "Curled Horn"
	icon_state = "horn1"
	color_src = MUTCOLORS3

/datum/sprite_accessory/ears/mam_ears/deer
	name = "Deer"
	icon_state = "deer"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/dog
	name = "Dog"
	icon_state = "lab"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/eevee
	name = "Eevee"
	icon_state = "eevee"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/elf
	name = "Elf"
	icon_state = "elf"
	color_src = MUTCOLORS3

/datum/sprite_accessory/ears/mam_ears/elephant
	name = "Elephant"
	icon_state = "elephant"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/fennec
	name = "Fennec"
	icon_state = "fennec"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/fennecsplayed
	name = "Fennec - Splayed"
	icon_state = "fennecsplayed"
	matrixed_sections = MATRIX_RED_BLUE


/datum/sprite_accessory/ears/mam_ears/fennec2
	name = "Fennec (ALT)"
	icon_state = "fennec2"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/fish
	name = "Fish"
	icon_state = "fish"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/foldedback
	name = "Folded Back"
	icon_state = "foldedback"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/ears/mam_ears/fox
	name = "Fox"
	icon_state = "fox"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/foxsplayed
	name = "Fox - Splayed"
	icon_state = "foxsplayed"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/husky
	name = "Husky"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/jellyfish
	name = "Jellyfish"
	icon_state = "jellyfish"
	color_src = HAIR

/datum/sprite_accessory/ears/mam_ears/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/murid
	name = "Murid"
	icon_state = "murid"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/otie
	name = "Otusian"
	icon_state = "otie"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/rabbitalt
	name = "Rabbit (ALT)"
	icon_state = "rabbitalt"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/ears/mam_ears/pede
	name = "Scolipede"
	icon_state = "pede"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/sergal
	name = "Sergal"
	icon_state = "sergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/skunk
	name = "Skunk"
	icon_state = "skunk"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/wolf
	name = "Wolf"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/pig
	name = "Pig"
	icon_state = "pig"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/human
	name = "Human ears"
	icon_state = "human"
	icon = 'icons/mob/mam/coyote/mam_ears.dmi'
	color_src = MUTCOLORS3

/datum/sprite_accessory/ears/mam_ears/umbreon
	name = "Umbreon"
	icon = 'icons/mob/mam/coyote/32x64_mam_ears.dmi'
	icon_state = "umbreon"
	matrixed_sections = MATRIX_RED_GREEN


//Fenny makes insane earringed ears

/datum/sprite_accessory/ears/mam_ears/bigwolflp
	name = "Big Wolf - left piercing"
	icon_state = "bigwolflp"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/ears/mam_ears/bigwolfrp
	name = "Big Wolf - right piercing"
	icon_state = "bigwolfrp"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/ears/mam_ears/bigwolfbp
	name = "Big Wolf - both piercings"
	icon_state = "bigwolfbp"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/ears/mam_ears/fennec2bp
	name = "Fennec (ALT) - both piercings"
	icon_state = "fennec2bp"
	matrixed_sections = MATRIX_ALL
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

/datum/sprite_accessory/ears/mam_ears/fennec2lp
	name = "Fennec (ALT) - left piercing"
	icon_state = "fennec2lp"
	matrixed_sections = MATRIX_ALL
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

/datum/sprite_accessory/ears/mam_ears/fennec2rp
	name = "Fennec (ALT) - right piercing"
	icon_state = "fennec2rp"
	matrixed_sections = MATRIX_ALL
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'

/datum/sprite_accessory/ears/mam_ears/draconic
	name = "Draconic Spikes"
	icon_state = "draconicspikes"
	icon = 'icons/mob/mam/citadel/mam_ears.dmi'
	matrixed_sections = MATRIX_ALL

//Two tone ears

/datum/sprite_accessory/ears/mam_ears/catbigtwo
	name = "Cat, Big Duel Color"
	icon_state = "catbigtwo"
	matrixed_sections = MATRIX_ALL

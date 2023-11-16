//Pokemon Start
/datum/species/feral
	name = "REPORT THIS AS A BUG"
	id = "eevee"
	//The id is the living and standing icon state of the creature.
	//The dead icon state must be "id_d" in the .dmi file
	//The resting icon state must be "id_rest" in the .dmi file
	simple_icon = 'modular_coyote/icons/mob/pokemon64.dmi'
	mutant_bodyparts = list("legs" = "Digitigrade", "meat_type" = "Mammalian")//Lets you select digitgrade legs if you want the claw footstep sound.
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_r"
	/// The width of the icon_limbs file. Used to auto-center your sprite.
	icon_width = 64
	roundstart = FALSE
	species_traits = list(HAS_FLESH,HAS_BONE,NOZOMBIE,NO_UNDERWEAR,FERAL,NOEYES,CAN_SCAR)
	inherent_biotypes = MOB_ORGANIC|MOB_BEAST
	meat = /obj/item/reagent_containers/food/snacks/meat/slab
	gib_types = list(/obj/effect/gibspawner/human/bodypartless)
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	rotate_on_lying = FALSE
	//We need this so that our limbs don't have null sprites when they get thrown off. (Should almost never happen because I glued them on, but just in case.)
	limbs_id = "mammal"

//Start Pokemon//
//Alphabetical Please//

/datum/species/feral/pokemon
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/pokemon
	roundstart = FALSE
	liked_food = FRUIT
	disliked_food = TOXIC | GROSS
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_r"

/datum/species/feral/pokemon/absol
	name = "Feral Absol"
	id = "absol"
	roundstart = TRUE
/mob/living/carbon/human/species/absol
	race = /datum/species/feral/pokemon/absol

/datum/species/feral/pokemon/megaabsol
	name = "Feral Mega Absol"
	id = "megaabsol"
	roundstart = TRUE
/mob/living/carbon/human/species/megaabsol
	race = /datum/species/feral/pokemon/megaabsol

/datum/species/feral/pokemon/aggron
	name = "Feral Aggron"
	id = "aggron"
	roundstart = TRUE
/mob/living/carbon/human/species/aggron
	race = /datum/species/feral/pokemon/aggron

/datum/species/feral/pokemon/alolanvulpix
	name = "Feral Alolan Vulpix"
	id = "alolanvulpix"
	roundstart = TRUE
/mob/living/carbon/human/species/alolanvulpix
	race = /datum/species/feral/pokemon/alolanvulpix

/datum/species/feral/pokemon/ampharos
	name = "Feral Ampharos"
	id = "ampharos"
	roundstart = TRUE
/mob/living/carbon/human/species/ampharos
	race = /datum/species/feral/pokemon/ampharos

/datum/species/feral/pokemon/articuno
	name = "Feral Articuno"
	id = "articuno"
	roundstart = TRUE
	simple_icon = 'modular_coyote/icons/mob/pokemon96.dmi'
	icon_width = 96
/mob/living/carbon/human/species/articuno
	race = /datum/species/feral/pokemon/articuno

/datum/species/feral/pokemon/arcanine
	name = "Feral Acanine"
	id = "arcanine"
	roundstart = TRUE
/mob/living/carbon/human/species/arcanine
	race = /datum/species/feral/pokemon/arcanine

/datum/species/feral/pokemon/blastoise
	name = "Feral Blastoise"
	id = "blastoise"
	roundstart = TRUE
/mob/living/carbon/human/species/blastoise
	race = /datum/species/feral/pokemon/blastoise

/datum/species/feral/pokemon/braixen
	name = "Feral Braixen"
	id = "braixen"
	roundstart = TRUE
/mob/living/carbon/human/species/braixen
	race = /datum/species/feral/pokemon/braixen

/datum/species/feral/pokemon/celebi
	name = "Feral Celebi"
	id = "celebi"
	roundstart = TRUE
/mob/living/carbon/human/species/celebi
	race = /datum/species/feral/pokemon/celebi

/datum/species/feral/pokemon/charmander
	name = "Feral Charmander"
	id = "charmander"
	roundstart = TRUE
/mob/living/carbon/human/species/charmander
	race = /datum/species/feral/pokemon/charmander

/datum/species/feral/pokemon/charizard
	name = "Feral Charizard"
	id = "charizard"
	roundstart = TRUE
/mob/living/carbon/human/species/charizard
	race = /datum/species/feral/pokemon/charizard

/datum/species/feral/pokemon/ditto
	name = "Feral Ditto"
	id = "ditto"
	roundstart = TRUE
/mob/living/carbon/human/species/ditto
	race = /datum/species/feral/pokemon/ditto

/datum/species/feral/pokemon/dragonair
	name = "Feral Dragonair"
	id = "dragonair"
	roundstart = TRUE
/mob/living/carbon/human/species/dragonair
	race = /datum/species/feral/pokemon/dragonair

/datum/species/feral/pokemon/shinydragonair
	name = "Feral Shiny Dragonair"
	id = "shinydragonair"
	roundstart = TRUE
/mob/living/carbon/human/species/shinydragonair
	race = /datum/species/feral/pokemon/shinydragonair

/datum/species/feral/pokemon/dunsparce
	name = "Feral Dunsparce"
	id = "dunsparce"
	roundstart = TRUE
/mob/living/carbon/human/species/dunsparce
	race = /datum/species/feral/pokemon/dunsparce

/datum/species/feral/pokemon/dragonite
	name = "Feral Dragonite"
	id = "dragonite"
	roundstart = TRUE
/mob/living/carbon/human/species/dragonite
	race = /datum/species/feral/pokemon/dragonite

/datum/species/feral/pokemon/dratini
	name = "Feral Dratini"
	id = "dratini"
	roundstart = TRUE
/mob/living/carbon/human/species/dratini
	race = /datum/species/feral/pokemon/dratini

/datum/species/feral/pokemon/eevee
	name = "Feral Eevee"
	id = "eevee"
/mob/living/carbon/human/species/eevee
	race = /datum/species/feral/pokemon/eevee

/datum/species/feral/pokemon/espeon
	name = "Feral Espeon"
	id = "espeon"
	roundstart = TRUE
/mob/living/carbon/human/species/espeon
	race = /datum/species/feral/pokemon/espeon

/datum/species/feral/pokemon/fennekin
	name = "Feral Fennekin"
	id = "fennekin"
	roundstart = TRUE
/mob/living/carbon/human/species/fennekin
	race = /datum/species/feral/pokemon/fennekin

/datum/species/feral/pokemon/flaaffy
	name = "Feral flaaffy"
	id = "flaaffy"
	roundstart = TRUE
/mob/living/carbon/human/species/flaaffy
	race = /datum/species/feral/pokemon/flaaffy

/datum/species/feral/pokemon/flareon
	name = "Feral flareon"
	id = "flareon"
	roundstart = TRUE
/mob/living/carbon/human/species/flareon
	race = /datum/species/feral/pokemon/flareon

/datum/species/feral/pokemon/flygon
	name = "Feral Flygon"
	id = "flygon"
	roundstart = TRUE
/mob/living/carbon/human/species/flygon
	race = /datum/species/feral/pokemon/flygon

/datum/species/feral/pokemon/furret
	name = "Feral Furret"
	id = "furret"
	roundstart = TRUE
/mob/living/carbon/human/species/furret
	race = /datum/species/feral/pokemon/furret

/datum/species/feral/pokemon/glaceon
	name = "Feral Glaceon"
	id = "glaceon"
	roundstart = TRUE
/mob/living/carbon/human/species/glaceon
	race = /datum/species/feral/pokemon/glaceon

/datum/species/feral/pokemon/lycanroc
	name = "Feral Lycanroc"
	id = "lycanroc"
	roundstart = TRUE
/mob/living/carbon/human/species/lycanroc
	race = /datum/species/feral/pokemon/lycanroc

/datum/species/feral/pokemon/umbreon
	name = "Feral Umbreon"
	id = "umbreon"
	roundstart = TRUE
/mob/living/carbon/human/species/umbreon
	race = /datum/species/feral/pokemon/umbreon

//^^^ Please keep these alphabetical. Don't just add to the bottom of the list. ^^^//
//End Pokemon//

//Start Other//

/datum/species/feral/nightstalker
	name = "Feral Nightstalker"
	id = "nightstalker"
	simple_icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon_width = 64
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/nightstalker
	race = /datum/species/feral/nightstalker

/datum/species/feral/cat
	name = "Feral Cat"
	id = "cat2"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/cat
	race = /datum/species/feral/cat

/datum/species/feral/black_cat
	name = "Feral Black Cat"
	id = "cat"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/black_cat
	race = /datum/species/feral/black_cat

/datum/species/feral/striped_cat
	name = "Feral Striped Cat"
	id = "pancake"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/striped_cat
	race = /datum/species/feral/striped_cat

/datum/species/feral/space_cat
	name = "Feral Space Cat"
	id = "spacecat"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/space_cat
	race = /datum/species/feral/space_cat

/datum/species/feral/wolf
	name = "Feral Wolf"
	id = "wolf"
	simple_icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = TRUE
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/wolf
	race = /datum/species/feral/wolf

/datum/species/feral/dog
	name = "Feral Dog"
	id = "dog_feral"
	simple_icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = TRUE
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/dog
	race = /datum/species/feral/dog

/datum/species/feral/hyotie
	name = "Feral Hyotie"
	id = "andrews"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/hyotie
	race = /datum/species/feral/hyotie

/datum/species/feral/mousebrown
	name = "Feral Brown Mouse"
	id = "mouse_brown"
	simple_icon = 'icons/mob/animal.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = VEGETABLES
/mob/living/carbon/human/species/mousebrown
	race = /datum/species/feral/mousebrown

/datum/species/feral/bat
	name = "Feral Bat"
	id = "bat"
	simple_icon = 'modular_coyote/icons/mob/bat.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = FRUIT
/mob/living/carbon/human/species/bat
	race = /datum/species/feral/bat

/datum/species/feral/gecko
	name = "Feral Gecko"
	id = "gekko"
	simple_icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/gecko
	race = /datum/species/feral/gecko

/datum/species/feral/gecko_villager
	name = "Feral Gecko Villager"
	id = "gekko_tribe_villager"
	simple_icon = 'icons/fallout/mobs/animals/gecktribe.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/gecko_villager
	race = /datum/species/feral/gecko_villager

//End Other//

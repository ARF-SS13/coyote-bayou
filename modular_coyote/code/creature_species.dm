/datum/species/feral
	name = "REPORT THIS AS A BUG"
	//The id is the living and standing icon state of the creature.
	//The dead icon state must be "id_d" in the .dmi file
	//The resting icon state must be "id_rest" in the .dmi file
	simple_icon = 'modular_coyote/icons/mob/pokemon64.dmi'
	mutant_bodyparts = list("legs" = "Digitigrade", "meat_type" = "Mammalian")
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	/// The width of the icon_limbs file. Used to auto-center your sprite.
	icon_width = 64
	roundstart = FALSE
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,LIPS,NOEYES,CAN_SCAR,HAS_FLESH,HAS_BONE,NO_INHAND)
	inherent_biotypes = MOB_ORGANIC|MOB_BEAST
	meat = /obj/item/reagent_containers/food/snacks/meat/slab
	gib_types = list(/obj/effect/gibspawner/human/bodypartless)
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	rotate_on_lying = FALSE
	//We need this so that our limbs don't have null sprites when they get thrown off. (Should almost never happen because I glued them on, but just in case.)
	limbs_id = "mammal"
	damage_overlay_type = null
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	tail_type = "mam_tail"
	wagging_type = "mam_waggingtail"
	footstep_type = FOOTSTEP_MOB_CLAW

//Start Pokemon//
//Alphabetical Please//

/datum/species/feral/pokemon
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/pokemon
	roundstart = FALSE
	liked_food = FRUIT | MEAT //berries
	disliked_food = TOXIC | GROSS
	icon_dead_suffix = "_d"
	icon_rest_suffix = "_rest"
	icon_width = 64

/datum/species/feral/pokemon/aerodactyl
	name = "Feral Aerodactyl"
	id = "Aerodactyl"//randomly has a capital letter i guess
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/aerodactyl
	race = /datum/species/feral/pokemon/aerodactyl

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
	footstep_type = FOOTSTEP_MOB_CRAWL
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

/datum/species/feral/pokemon/cubone
	name = "Feral Cubone"
	id = "cubone"
	roundstart = TRUE
/mob/living/carbon/human/species/cubone
	race = /datum/species/feral/pokemon/cubone

/datum/species/feral/pokemon/ditto
	name = "Feral Ditto"
	id = "ditto"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/ditto
	race = /datum/species/feral/pokemon/ditto

/datum/species/feral/pokemon/dragonair
	name = "Feral Dragonair"
	id = "dragonair"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/dragonair
	race = /datum/species/feral/pokemon/dragonair

/datum/species/feral/pokemon/shinydragonair
	name = "Feral Shiny Dragonair"
	id = "shinydragonair"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
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
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/dratini
	race = /datum/species/feral/pokemon/dratini

/datum/species/feral/pokemon/eevee
	name = "Feral Eevee"
	id = "eevee"
	roundstart = TRUE
	alt_prefixes = list("Old Color" = "old")
/mob/living/carbon/human/species/eevee
	race = /datum/species/feral/pokemon/eevee

/datum/species/feral/pokemon/espeon
	name = "Feral Espeon"
	id = "espeon"
	roundstart = TRUE
	alt_prefixes = list("Old Color" = "old")
/mob/living/carbon/human/species/espeon
	race = /datum/species/feral/pokemon/espeon

/datum/species/feral/pokemon/fennekin
	name = "Feral Fennekin"
	id = "fennekin"
	roundstart = TRUE
/mob/living/carbon/human/species/fennekin
	race = /datum/species/feral/pokemon/fennekin

/datum/species/feral/pokemon/flaaffy
	name = "Feral Flaaffy"
	id = "flaaffy"
	roundstart = TRUE
/mob/living/carbon/human/species/flaaffy
	race = /datum/species/feral/pokemon/flaaffy

/datum/species/feral/pokemon/flareon
	name = "Feral Flareon"
	id = "flareon"
	roundstart = TRUE
	alt_prefixes = list("Old Color" = "old")
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

/datum/species/feral/pokemon/gallade
	name = "Feral Gallade"
	id = "gallade"
	roundstart = TRUE
/mob/living/carbon/human/species/gallade
	race = /datum/species/feral/pokemon/gallade

/datum/species/feral/pokemon/gardevoir
	name = "Feral Gardevoir"
	id = "gardevoir"
	roundstart = TRUE
/mob/living/carbon/human/species/gardevoir
	race = /datum/species/feral/pokemon/gardevoir

/datum/species/feral/pokemon/gastly
	name = "Feral Gastly"
	id = "gastly"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/gastly
	race = /datum/species/feral/pokemon/gastly

/datum/species/feral/pokemon/gengar
	name = "Feral Gengar"
	id = "gengar"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/gengar
	race = /datum/species/feral/pokemon/gengar

/datum/species/feral/pokemon/glaceon
	name = "Feral Glaceon"
	id = "glaceon"
	roundstart = TRUE
/mob/living/carbon/human/species/glaceon
	race = /datum/species/feral/pokemon/glaceon

/datum/species/feral/pokemon/growlithe
	name = "Feral Growlithe"
	id = "growlithe"
	roundstart = TRUE
	alt_prefixes = list("Old Color" = "old")
/mob/living/carbon/human/species/growlithe
	race = /datum/species/feral/pokemon/growlithe

/datum/species/feral/pokemon/haunter
	name = "Feral Haunter"
	id = "haunter"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/haunter
	race = /datum/species/feral/pokemon/haunter

/datum/species/feral/pokemon/jirachi
	name = "Feral Jirachi"
	id = "jirachi"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/jirachi
	race = /datum/species/feral/pokemon/jirachi

/datum/species/feral/pokemon/jolteon
	name = "Feral Jolteon"
	id = "jolteon"
	roundstart = TRUE
/mob/living/carbon/human/species/jolteon
	race = /datum/species/feral/pokemon/jolteon

/datum/species/feral/pokemon/kabuto
	name = "Feral Kabuto"
	id = "Kabuto"
	roundstart = TRUE
/mob/living/carbon/human/species/kabuto
	race = /datum/species/feral/pokemon/kabuto

/datum/species/feral/pokemon/kirlia
	name = "Feral Kirlia"
	id = "kirlia"
	roundstart = TRUE
/mob/living/carbon/human/species/kirlia
	race = /datum/species/feral/pokemon/kirlia

/datum/species/feral/pokemon/larvitar
	name = "Feral Larvitar"
	id = "larvitar"
	roundstart = TRUE
/mob/living/carbon/human/species/larvitar
	race = /datum/species/feral/pokemon/larvitar

/datum/species/feral/pokemon/lapras
	name = "Feral Lapras"
	id = "lapras"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/lapras
	race = /datum/species/feral/pokemon/lapras

/datum/species/feral/pokemon/leafeon
	name = "Feral Leafeon"
	id = "leafeon"
	roundstart = TRUE
/mob/living/carbon/human/species/leafeon
	race = /datum/species/feral/pokemon/leafeon

/datum/species/feral/pokemon/liepard
	name = "Feral Liepard"
	id = "liepard"
	roundstart = TRUE
/mob/living/carbon/human/species/liepard
	race = /datum/species/feral/pokemon/liepard

/datum/species/feral/pokemon/lickitung
	name = "Feral Lickitung"
	id = "lickitung"
	roundstart = TRUE
/mob/living/carbon/human/species/lickitung
	race = /datum/species/feral/pokemon/lickitung

/datum/species/feral/pokemon/lugia
	name = "Feral Lugia"
	id = "lugia"
	roundstart = TRUE
	simple_icon = 'modular_coyote/icons/mob/pokemon96.dmi'
	icon_width = 96
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/lugia
	race = /datum/species/feral/pokemon/lugia

/datum/species/feral/pokemon/lycanroc
	name = "Feral Lycanroc"
	id = "lycanroc"
	roundstart = TRUE
/mob/living/carbon/human/species/lycanroc
	race = /datum/species/feral/pokemon/lycanroc

/datum/species/feral/pokemon/magicarp
	name = "Feral Magicarp"
	id = "magicarp"
	roundstart = TRUE
/mob/living/carbon/human/species/magicarp
	race = /datum/species/feral/pokemon/magicarp

/datum/species/feral/pokemon/magmar
	name = "Feral Magmar"
	id = "magmar"
	roundstart = TRUE
/mob/living/carbon/human/species/magmar
	race = /datum/species/feral/pokemon/magmar

/datum/species/feral/pokemon/mareep
	name = "Feral Mareep"
	id = "mareep"
	roundstart = TRUE
/mob/living/carbon/human/species/mareep
	race = /datum/species/feral/pokemon/mareep

/datum/species/feral/pokemon/mew
	name = "Feral Mew"
	id = "mew"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/mew
	race = /datum/species/feral/pokemon/mew

/datum/species/feral/pokemon/mewtwo
	name = "Feral Mewtwo"
	id = "mewtwo"
	roundstart = TRUE
/mob/living/carbon/human/species/mewtwo
	race = /datum/species/feral/pokemon/mewtwo

/datum/species/feral/pokemon/mightyena
	name = "Feral Mightyena"
	id = "mightyena"
	roundstart = TRUE
/mob/living/carbon/human/species/mightyena
	race = /datum/species/feral/pokemon/mightyena

/datum/species/feral/pokemon/miltank
	name = "Feral Miltank"
	id = "miltank"
	roundstart = TRUE
/mob/living/carbon/human/species/miltank
	race = /datum/species/feral/pokemon/miltank

/datum/species/feral/pokemon/ninetales
	name = "Feral ninetales"
	id = "ninetales"
	roundstart = TRUE
/mob/living/carbon/human/species/ninetales
	race = /datum/species/feral/pokemon/ninetales

/datum/species/feral/pokemon/omanyte
	name = "Feral Omanyte"
	id = "omanyte"
	roundstart = TRUE
/mob/living/carbon/human/species/omanyte
	race = /datum/species/feral/pokemon/omanyte

/datum/species/feral/pokemon/pikachu
	name = "Feral Pikachu"
	id = "pikachu"
	roundstart = TRUE
	alt_prefixes = list("Female" = "f")
	simple_icon = 'modular_coyote/icons/mob/pmon/pikachu.dmi'
/mob/living/carbon/human/species/pikachu
	race = /datum/species/feral/pokemon/pikachu

/datum/species/feral/pokemon/ponyta
	name = "Feral Ponyta"
	id = "ponyta"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_HOOF
/mob/living/carbon/human/species/ponyta
	race = /datum/species/feral/pokemon/ponyta

/datum/species/feral/pokemon/poochyena
	name = "Feral Poochyena"
	id = "poochyena"
	roundstart = TRUE
/mob/living/carbon/human/species/poochyena
	race = /datum/species/feral/pokemon/poochyena

/datum/species/feral/pokemon/purrloin
	name = "Feral Purrloin"
	id = "purrloin"
	roundstart = TRUE
/mob/living/carbon/human/species/purrloin
	race = /datum/species/feral/pokemon/purrloin

/datum/species/feral/pokemon/raichu
	name = "Feral Raichu"
	id = "raichu"
	roundstart = TRUE
	alt_prefixes = list("Female" = "f")
	simple_icon = 'modular_coyote/icons/mob/pmon/raichu.dmi'
/mob/living/carbon/human/species/raichu
	race = /datum/species/feral/pokemon/raichu

/datum/species/feral/pokemon/alolanraichu
	name = "Feral Alolan Raichu"
	id = "alolanraichu"
	roundstart = TRUE
	simple_icon = 'modular_coyote/icons/mob/pmon/raichu.dmi'
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/alolanraichu
	race = /datum/species/feral/pokemon/alolanraichu

/datum/species/feral/pokemon/ralts
	name = "Feral Ralts"
	id = "ralts"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/ralts
	race = /datum/species/feral/pokemon/ralts

/datum/species/feral/pokemon/raticate
	name = "Feral Raticate"
	id = "raticate"
	roundstart = TRUE
/mob/living/carbon/human/species/raticate
	race = /datum/species/feral/pokemon/raticate

/datum/species/feral/pokemon/rattata
	name = "Feral Rattata"
	id = "rattata"
	roundstart = TRUE
/mob/living/carbon/human/species/rattata
	race = /datum/species/feral/pokemon/rattata

/datum/species/feral/pokemon/rayquaza
	name = "Feral Rayquaza"
	id = "rayquaza"
	roundstart = TRUE
	simple_icon = 'modular_coyote/icons/mob/pokemon96.dmi'
	icon_width = 96
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/rayquaza
	race = /datum/species/feral/pokemon/rayquaza

/datum/species/feral/pokemon/salazzle
	name = "Feral Salazzle"
	id = "salazzle"
	roundstart = TRUE
	simple_icon = 'modular_coyote/icons/mob/pmon/salazzle.dmi'
/mob/living/carbon/human/species/salazzle
	race = /datum/species/feral/pokemon/salazzle

/datum/species/feral/pokemon/skuntank
	name = "Feral Skuntank"
	id = "skuntank"
	roundstart = TRUE
/mob/living/carbon/human/species/skuntank
	race = /datum/species/feral/pokemon/skuntank

/datum/species/feral/pokemon/snivy
	name = "Feral Snivy"
	id = "snivy"
	roundstart = TRUE
/mob/living/carbon/human/species/snivy
	race = /datum/species/feral/pokemon/snivy

/datum/species/feral/pokemon/snorlax
	name = "Feral Snorlax"
	id = "snorlax"
	roundstart = TRUE
/mob/living/carbon/human/species/snorlax
	race = /datum/species/feral/pokemon/snorlax

/datum/species/feral/pokemon/sprigatito
	name = "Feral Sprigatito"
	id = "sprigatito"
	roundstart = TRUE
/mob/living/carbon/human/species/sprigatito
	race = /datum/species/feral/pokemon/sprigatito

/datum/species/feral/pokemon/sylveon
	name = "Feral Sylveon"
	id = "sylveon"
	roundstart = TRUE
/mob/living/carbon/human/species/sylveon
	race = /datum/species/feral/pokemon/sylveon

/datum/species/feral/pokemon/tentacruel
	name = "Feral Tentacruel"
	id = "tentacruel"
	roundstart = TRUE
/mob/living/carbon/human/species/tentacruel
	race = /datum/species/feral/pokemon/tentacruel

/datum/species/feral/pokemon/thievul
	name = "Feral Thievul"
	id = "thievul"
	roundstart = TRUE
/mob/living/carbon/human/species/thievul
	race = /datum/species/feral/pokemon/thievul

/datum/species/feral/pokemon/umbreon
	name = "Feral Umbreon"
	id = "umbreon"
	roundstart = TRUE
	alt_prefixes = list("Old Color" = "old")
/mob/living/carbon/human/species/umbreon
	race = /datum/species/feral/pokemon/umbreon

/datum/species/feral/pokemon/vulpix
	name = "Feral Vulpix"
	id = "vulpix"
	roundstart = TRUE
/mob/living/carbon/human/species/vulpix
	race = /datum/species/feral/pokemon/vulpix

/datum/species/feral/pokemon/alolanvulpix
	name = "Feral Alolan Vulpix"
	id = "alolanvulpix"
	roundstart = TRUE
/mob/living/carbon/human/species/alolanvulpix
	race = /datum/species/feral/pokemon/alolanvulpix

/datum/species/feral/pokemon/vaporeon
	name = "Feral Vaporeon"
	id = "vaporeon"
	roundstart = TRUE
/mob/living/carbon/human/species/vaporeon
	race = /datum/species/feral/pokemon/vaporeon

/datum/species/feral/pokemon/zigzagoon
	name = "Feral Zigzagoon"
	id = "zigzagoon"
	roundstart = TRUE
/mob/living/carbon/human/species/zigzagoon
	race = /datum/species/feral/pokemon/zigzagoon

/datum/species/feral/pokemon/zorua
	name = "Feral Zorua"
	id = "zorua"
	roundstart = TRUE
/mob/living/carbon/human/species/zorua
	race = /datum/species/feral/pokemon/zorua

/datum/species/feral/pokemon/zorua_hisuian
	name = "Feral Hisuian Zorua"
	id = "zorua_hisuian"
	roundstart = TRUE
/mob/living/carbon/human/species/zorua_hisuian
	race = /datum/species/feral/pokemon/zorua_hisuian

/datum/species/feral/pokemon/zoroark
	name = "Feral Zoroark"
	id = "zoroark"
	roundstart = TRUE
/mob/living/carbon/human/species/zoroark
	race = /datum/species/feral/pokemon/zoroark

/datum/species/feral/pokemon/zubat
	name = "Feral Zubat"
	id = "zubat"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/zubat
	race = /datum/species/feral/pokemon/zubat

//^^^ Please keep these alphabetical. Don't just add to the bottom of the list. ^^^//
//End Pokemon//

//Start Other//

/datum/species/feral/catslug
	name = "Catslug"
	id = "catslug"
	simple_icon = 'modular_coyote/icons/mob/slugcat.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
	default_color = "FFFFFF"
	mutant_bodyparts = list("mcolor" = "FFFFFF", "legs" = "Digitigrade", "meat_type" = "Mammalian")
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,LIPS,NOEYES,CAN_SCAR,HAS_FLESH,HAS_BONE,MUTCOLORS)
/mob/living/carbon/human/species/catslug
	race = /datum/species/feral/catslug

/datum/species/feral/chocobo
	name = "Feral Chocobo"
	id = "chocobo"
	simple_icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = ""
	rotate_on_lying = TRUE
	roundstart = TRUE
	liked_food = MEAT | RAW
	default_color = "FFFFFF"
	mutant_bodyparts = list("mcolor" = "FFFFFF", "legs" = "Digitigrade", "meat_type" = "Mammalian")
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,LIPS,NOEYES,CAN_SCAR,HAS_FLESH,HAS_BONE,MUTCOLORS)
/mob/living/carbon/human/species/chocobo
	race = /datum/species/feral/chocobo

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

/datum/species/feral/direwolf
	name = "Feral Direwolf"
	id = "direwolf"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/direwolf
	race = /datum/species/feral/direwolf

/datum/species/feral/giantrat
	name = "Feral Giant Rat"
	id = "rous"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/giantrat
	race = /datum/species/feral/giantrat

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

/datum/species/feral/mousegrey
	name = "Feral Grey Mouse"
	id = "mouse_gray"
	simple_icon = 'icons/mob/animal.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = VEGETABLES
/mob/living/carbon/human/species/mousegrey
	race = /datum/species/feral/mousegrey

/datum/species/feral/mousewhite
	name = "Feral White Mouse"
	id = "mouse_white"
	simple_icon = 'icons/mob/animal.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = VEGETABLES
/mob/living/carbon/human/species/mousewhite
	race = /datum/species/feral/mousewhite

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

//start aliens

/datum/species/feral/xeno
	roundstart = FALSE //This is just the parent type, don't let players actually select it.
	exotic_blood_color = BLOOD_COLOR_XENO
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/xeno
	gib_types = list(/obj/effect/gibspawner/xeno/xenoperson, /obj/effect/gibspawner/xeno/xenoperson/bodypartless)
	skinned_type = /obj/item/stack/sheet/animalhide/xeno
	exotic_bloodtype = "X*"
	liked_food = MEAT | RAW
	default_color = "00FF00"
	species_type = "alien"
	say_mod = "hisses"
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"

/datum/species/feral/xeno/drone
	name = "Feral Xenomorph Drone"
	id = "aliend"
	simple_icon = 'icons/mob/alien.dmi'
	icon_width = 32
	roundstart = TRUE
	rotate_on_lying = TRUE
	icon_rest_suffix = "_sleep"
/mob/living/carbon/human/species/xenodrone
	race = /datum/species/feral/xeno/drone

/datum/species/feral/xeno/hunter
	name = "Feral Xenomorph Hunter"
	id = "alienh"
	simple_icon = 'icons/mob/alien.dmi'
	icon_width = 32
	roundstart = TRUE
	rotate_on_lying = TRUE
	icon_rest_suffix = "_sleep"
/mob/living/carbon/human/species/alienh
	race = /datum/species/feral/xeno/hunter

/datum/species/feral/xeno/sentry
	name = "Feral Xenomorph Sentry"
	id = "aliens"
	simple_icon = 'icons/mob/alien.dmi'
	icon_width = 32
	roundstart = TRUE
	rotate_on_lying = TRUE
	icon_rest_suffix = "_sleep"
/mob/living/carbon/human/species/xenosentry
	race = /datum/species/feral/xeno/sentry

/datum/species/feral/xeno/praetorian
	name = "Feral Xenomorph Praetorian"
	id = "alienp"
	simple_icon = 'icons/mob/alienqueen.dmi'
	icon_width = 64
	roundstart = TRUE
/mob/living/carbon/human/species/alienp
	race = /datum/species/feral/xeno/praetorian

/datum/species/feral/xeno/queen
	name = "Feral Xenomorph Queen"
	id = "alienq"
	simple_icon = 'icons/mob/alienqueen.dmi'
	icon_width = 64
	roundstart = TRUE
	alt_prefixes = list("TGMC Queen" = "tgmc_")
/mob/living/carbon/human/species/queen
	race = /datum/species/feral/xeno/queen

/datum/species/feral/xeno/maid
	name = "Feral Xenomorph Maid"
	id = "maid"
	simple_icon = 'icons/mob/alien.dmi'
	icon_width = 32
	roundstart = TRUE
/mob/living/carbon/human/species/maid
	race = /datum/species/feral/xeno/maid

//tgmc aliens
/datum/species/feral/xeno/beetle
	name = "Feral Xenomorph Beetle"
	id = "xeno_beetle"
	roundstart = TRUE
	default_color = "302239"
	simple_icon = 'modular_coyote/icons/mob/tgmc/beetle.dmi'
	icon_width = 64
/mob/living/carbon/human/species/beetle
	race = /datum/species/feral/xeno/beetle

/datum/species/feral/xeno/bull
	name = "Feral Xenomorph Bull"
	id = "xeno_bull"
	roundstart = TRUE
	default_color = "710E13"
	simple_icon = 'modular_coyote/icons/mob/tgmc/bull.dmi'
	icon_width = 64
/mob/living/carbon/human/species/bull
	race = /datum/species/feral/xeno/bull

/datum/species/feral/xeno/crusher
	name = "Feral Xenomorph Crusher"
	id = "xeno_crusher"
	roundstart = TRUE
	default_color = "710E13"
	simple_icon = 'modular_coyote/icons/mob/tgmc/crusher.dmi'
	icon_width = 64
/mob/living/carbon/human/species/crusher
	race = /datum/species/feral/xeno/crusher

/datum/species/feral/xeno/defender
	name = "Feral Xenomorph Defender"
	id = "xeno_defender"
	roundstart = TRUE
	default_color = "302239"
	simple_icon = 'modular_coyote/icons/mob/tgmc/defender.dmi'
	icon_width = 64
/mob/living/carbon/human/species/defender
	race = /datum/species/feral/xeno/defender

/datum/species/feral/xeno/defiler
	name = "Feral Xenomorph Defiler"
	id = "xeno_defiler"
	roundstart = TRUE
	default_color = "2C212B"
	simple_icon = 'modular_coyote/icons/mob/tgmc/defiler.dmi'
	icon_width = 64
/mob/living/carbon/human/species/defiler
	race = /datum/species/feral/xeno/defiler

/datum/species/feral/xeno/nymph
	name = "Feral Xenomorph Nymph"
	id = "xeno_nymph"
	roundstart = TRUE
	default_color = "710E13"
	simple_icon = 'modular_coyote/icons/mob/tgmc/nymph.dmi'
	icon_width = 64
/mob/living/carbon/human/species/nymph
	race = /datum/species/feral/xeno/nymph

/datum/species/feral/xeno/runner
	name = "Feral Xenomorph Runner"
	id = "xeno_runner"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/runner.dmi'
	icon_width = 64
/mob/living/carbon/human/species/runner
	race = /datum/species/feral/xeno/runner

/datum/species/feral/xeno/warlock
	name = "Feral Xenomorph Warlock"
	id = "xeno_warlock"
	roundstart = TRUE
	default_color = "514643"
	simple_icon = 'modular_coyote/icons/mob/tgmc/warlock.dmi'
	icon_width = 64
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/warlock
	race = /datum/species/feral/xeno/warlock

/datum/species/feral/xeno/warrior
	name = "Feral Xenomorph Warrior"
	id = "xeno_warrior"
	roundstart = TRUE
	default_color = "302239"
	simple_icon = 'modular_coyote/icons/mob/tgmc/warrior.dmi'
	icon_width = 64
/mob/living/carbon/human/species/warrior
	race = /datum/species/feral/xeno/warrior

/datum/species/feral/xeno/widow
	name = "Feral Xenomorph Widow"
	id = "xeno_widow"
	roundstart = TRUE
	default_color = "514643"
	simple_icon = 'modular_coyote/icons/mob/tgmc/widow.dmi'
	icon_width = 64
/mob/living/carbon/human/species/widow
	race = /datum/species/feral/xeno/widow

/datum/species/feral/xeno/wraith
	name = "Feral Xenomorph Wraith"
	id = "xeno_wraith"
	roundstart = TRUE
	default_color = "302239"
	simple_icon = 'modular_coyote/icons/mob/tgmc/wraith.dmi'
	icon_width = 64
/mob/living/carbon/human/species/wraith
	race = /datum/species/feral/xeno/wraith

//end aliens

/datum/species/feral/bigwolfblack
	name = "Feral Giant Black Wolf"
	id = "blackwolf"
	simple_icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_width = 128
	roundstart = TRUE
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
/mob/living/carbon/human/species/bigwolfblack
	race = /datum/species/feral/bigwolfblack

/datum/species/feral/bigwolfsilver
	name = "Feral Giant Silver Wolf"
	id = "sifwolf"
	simple_icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_width = 128
	roundstart = TRUE
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
/mob/living/carbon/human/species/bigwolfsilver
	race = /datum/species/feral/bigwolfsilver

/datum/species/feral/bigwolfwhite
	name = "Feral Giant White Wolf"
	id = "whitewolf"
	simple_icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_width = 128
	roundstart = TRUE
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
/mob/living/carbon/human/species/bigwolfblack
	race = /datum/species/feral/bigwolfblack

//start deathclaws
/datum/species/feral/deathclaw
	roundstart = FALSE //This is just the parent type, don't let players actually select it.
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/deathclaw
	gib_types = list(/obj/effect/gibspawner/generic)
	skinned_type = /obj/item/stack/sheet/animalhide/deathclaw
	liked_food = MEAT | RAW
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	simple_icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_width = 64
	footstep_type = FOOTSTEP_MOB_HEAVY

/datum/species/feral/deathclaw/original
	name = "Feral Deathclaw"
	id = "deathclaw"
	roundstart = TRUE
	icon_rest_suffix = ""
	rotate_on_lying = TRUE
	simple_icon = 'icons/mob/deathclaw.dmi'
/mob/living/carbon/human/species/deathclaw_original
	race = /datum/species/feral/deathclaw/original

/datum/species/feral/deathclaw/purple
	name = "Purple Cloaked Deathclaw"
	id = "pur"
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_purple
	race = /datum/species/feral/deathclaw/purple

/datum/species/feral/deathclaw/white
	name = "White Cloaked Deathclaw"
	id = "whi"
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_whi
	race = /datum/species/feral/deathclaw/white

/datum/species/feral/deathclaw/red
	name = "Red Cloaked Deathclaw"
	id = "red"
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_red
	race = /datum/species/feral/deathclaw/red

/datum/species/feral/deathclaw/grey
	name = "Grey Cloaked Deathclaw"
	id = "gry"
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_grey
	race = /datum/species/feral/deathclaw/grey

/datum/species/feral/deathclaw/black
	name = "Black Cloaked Deathclaw"
	id = "hub"
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_black
	race = /datum/species/feral/deathclaw/black

/datum/species/feral/deathclaw/brown
	name = "Brown Cloaked Deathclaw"
	id = "bro"
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_brown
	race = /datum/species/feral/deathclaw/brown

/datum/species/feral/deathclaw/maid
	name = "Maid Deathclaw"
	id = "maidclaw"
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_maid
	race = /datum/species/feral/deathclaw/maid

/datum/species/feral/deathclaw/queen
	name = "Queen Deathclaw"
	id = "deathclaw_queen"
	rotate_on_lying = TRUE
	icon_rest_suffix = ""
	roundstart = TRUE
/mob/living/carbon/human/species/deathclaw_queen
	race = /datum/species/feral/deathclaw/queen

//End Other//

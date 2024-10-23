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

/datum/species/feral/pokemon/furret/shiny
	name = "Feral Shiny Furret"
	id = "furret_shiny"
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
/*
/datum/species/feral/pokemon/kirlia
	name = "Feral Kirlia"
	id = "kirlia"
	roundstart = TRUE
/mob/living/carbon/human/species/kirlia
	race = /datum/species/feral/pokemon/kirlia
*/
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
/*
/datum/species/feral/pokemon/ralts
	name = "Feral Ralts"
	id = "ralts"
	roundstart = TRUE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/ralts
	race = /datum/species/feral/pokemon/ralts
*/
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

/datum/species/feral/werewolf
	name = "Feral Werewolf"
	id = "playerwolf"
	simple_icon = 'modular_splurt/icons/mob/werewolf.dmi'
	icon_width = 64
	alt_prefixes = list("Skull Headed" = "skull_", "Ice" = "ice_")
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
	default_color = "FFFFFF"
	mutant_bodyparts = list("mcolor" = "FFFFFF", "legs" = "Digitigrade", "meat_type" = "Mammalian")
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,LIPS,NOEYES,CAN_SCAR,HAS_FLESH,HAS_BONE,MUTCOLORS)
/mob/living/carbon/human/species/werewolf
	race = /datum/species/feral/werewolf

/datum/species/feral/chocobo
	name = "Feral Chocobo"
	id = "chocobo"
	simple_icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = FALSE
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

/datum/species/feral/shepard
	name = "Feral Shepard"
	id = "shepherd"
	simple_icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_dead_suffix = "_dead"
	icon_width = 32
	icon_rest_suffix = "_rest"
	rotate_on_lying = TRUE
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/shepard
	race = /datum/species/feral/shepard

/datum/species/feral/raccoon
	name = "Feral Raccoon"
	id = "raccoon_darkgrey"
	simple_icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead_suffix = "_dead"
	icon_width = 32
	icon_rest_suffix = "_rest"
	rotate_on_lying = FALSE
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/raccoon
	race = /datum/species/feral/raccoon

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

/datum/species/feral/otie
	name = "Feral Otie"
	id = "otie"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "_rest"
	alt_prefixes = list("Collared Otie" = "c_", "Security Otie" = "s_", "Security Hyotie" = "sech_", "Hyotie" = "h_", "Fat Otie" = "fat_")
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/otie
	race = /datum/species/feral/otie

/datum/species/feral/scrotie
	name = "Feral Scrotie"
	id = "scrotie"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "_rest"
	alt_prefixes = list("Collared Scrotie" = "c_", "Security Scrotie" = "s_", "Fat Scrotie" = "fat_", "Fyrotie" = "h_", "Fun Sized" = "cup_", "Fun Sized Security" = "scup_")
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/scrotie
	race = /datum/species/feral/scrotie

/datum/species/feral/otiepede
	name = "Feral Otiepede"
	id = "otiepede"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "_rest"
	alt_prefixes = list()
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/otiepede
	race = /datum/species/feral/otiepede

/datum/species/feral/snotie
	name = "Feral Snotie"
	id = "snotie"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "_rest"
	alt_prefixes = list()
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/snotie
	race = /datum/species/feral/snotie

/datum/species/feral/scrotiepede
	name = "Feral Scrotiepede"
	id = "scrotiepede"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "_rest"
	alt_prefixes = list()
	roundstart = TRUE
	liked_food = MEAT | RAW
/mob/living/carbon/human/species/scrotiepede
	race = /datum/species/feral/scrotiepede

/datum/species/feral/direwolf
	name = "Feral Direwolf"
	id = "direwolf"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	alt_prefixes = list("Armored" = "armored_")
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT | RAW
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,LIPS,NOEYES,CAN_SCAR,HAS_FLESH,HAS_BONE,NO_INHAND,MUTCOLORS)
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

/datum/species/feral/wisp
	name = "Feral Wisp"
	id = "wisp"
	simple_icon = 'modular_roguetown/items/lighting.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = VEGETABLES
	footstep_type = FOOTSTEP_MOB_CRAWL
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,LIPS,NOEYES,CAN_SCAR,HAS_FLESH,HAS_BONE,NO_INHAND,MUTCOLORS)
/mob/living/carbon/human/species/wisp
	race = /datum/species/feral/wisp

/datum/species/feral/slime
	name = "Feral Slime"
	id = "player slime"
	simple_icon = 'icons/mob/slimes.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = VEGETABLES
	footstep_type = FOOTSTEP_MOB_CRAWL
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,LIPS,NOEYES,CAN_SCAR,HAS_FLESH,HAS_BONE,NO_INHAND,MUTCOLORS)
/mob/living/carbon/human/species/slime
	race = /datum/species/feral/slime

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

/datum/species/feral/featherraptor
	name = "Feral Feathered Raptor"
	id = "fraptor"
	simple_icon = 'modular_coyote/icons/mob/raptor_big_56x32.dmi'
	icon_width = 56
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_dead"
	alt_prefixes = list("Black Feathers" = "black_", 
	"White Feathers" = "white_", 
	"Purple Feathers" = "purple_", 
	"Red Feathers" = "red_", 
	"Green Feathers" = "green_", 
	"Blue Feathers" = "blue_")
	roundstart = TRUE
	liked_food = MEAT
/mob/living/carbon/human/species/featherraptor
	race = /datum/species/feral/featherraptor

/datum/species/feral/plantmouth
	name = "Venus Human Trap"
	id = "venus_human_trap"
	simple_icon = 'icons/effects/spacevines.dmi'
	icon_width = 32
	icon_dead_suffix = "_rest"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT
/mob/living/carbon/human/species/plantmouth
	race = /datum/species/feral/plantmouth

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
	alt_prefixes = list("TGMC Praetorian" = "tgmc_")
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

/datum/species/feral/xeno/behemoth
	name = "Feral Xenomorph Behemoth"
	id = "xeno_behemoth"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/behemoth.dmi'
	icon_width = 96
/mob/living/carbon/human/species/behemoth
	race = /datum/species/feral/xeno/behemoth

/datum/species/feral/xeno/boiler
	name = "Feral Xenomorph Boiler"
	id = "xeno_boiler"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/boiler.dmi'
	icon_width = 64
/mob/living/carbon/human/species/boiler
	race = /datum/species/feral/xeno/boiler

/datum/species/feral/xeno/puppeteer
	name = "Feral Xenomorph Puppeteer"
	id = "xeno_puppeteer"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/puppeteer.dmi'
	icon_width = 64
/mob/living/carbon/human/species/puppeteer
	race = /datum/species/feral/xeno/puppeteer

/datum/species/feral/xeno/carrier
	name = "Feral Xenomorph Carrier"
	id = "xeno_carrier"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/carrier.dmi'
	icon_width = 64
/mob/living/carbon/human/species/carrier
	race = /datum/species/feral/xeno/carrier

/datum/species/feral/xeno/ravager
	name = "Feral Xenomorph Ravager"
	id = "xeno_ravager"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/ravager.dmi'
	icon_width = 64
/mob/living/carbon/human/species/ravager
	race = /datum/species/feral/xeno/ravager

/datum/species/feral/xeno/gorger
	name = "Feral Xenomorph Gorger"
	id = "xeno_gorger"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/gorger.dmi'
	icon_width = 64
/mob/living/carbon/human/species/gorger
	race = /datum/species/feral/xeno/gorger

/datum/species/feral/xeno/hivelord
	name = "Feral Xenomorph Hivelord"
	id = "xeno_hivelord"
	roundstart = TRUE
	default_color = "BC2929"
	simple_icon = 'modular_coyote/icons/mob/tgmc/hivelord.dmi'
	icon_width = 64
/mob/living/carbon/human/species/hivelord
	race = /datum/species/feral/xeno/hivelord

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

//Mimics! No special code here, I wish I could make the morph mob's gimmick a trait, but this is for all you crate pilled people
/datum/species/feral/mimic
	name = "Mimic Chest"
	simple_icon = 'modular_roguetown/topadd/takyon/Mimics.dmi'
	id = "newmimic"
	roundstart = TRUE
	icon_width = 64
	alt_prefixes = list(
		"Inverted" = "oginvert_",
		"Hybrid" = "gnorm_",
		"Hybrid Inverted" = "gnorminvert_",
		"Subtle" = "gsubtle_",
		"Silver" = "os_",
		"Silver Inverted" = "osinvert_",
		"Silver Hybrid" = "snorm_",
		"Silver Hybrid Inverted" = "snorminvert_",
		"Silver Subtle" = "ssubtle_") //Yeah I went a little wild with how many alt sprites they have
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = FALSE
	footstep_type = FOOTSTEP_MOB_HEAVY
/mob/living/carbon/human/species/mimic
	race = /datum/species/feral/mimic

// No more mimics

/datum/species/feral/scel
	name = "Feral Scel"
	id = "scel"
	simple_icon = 'modular_coyote/icons/mob/vore_scel.dmi'
	alt_prefixes = list(
		"Blue" = "blue_",
		"Purple" = "purple_",
		"Red" = "red_",
		"Green" = "green_",)
	icon_width = 128
	roundstart = TRUE
	rotate_on_lying = FALSE
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "-rest"
/mob/living/carbon/human/species/scel
	race = /datum/species/feral/scel

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
 
/datum/species/feral/darkgreytanuki
	name = "Tanuki"
	id = "tanuki"
	simple_icon = 'modular_coyote/icons/mob/tanuki.dmi'
	alt_prefixes = list("Dark Brown" = "dark_")
	icon_width = 128
	roundstart = TRUE
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
/mob/living/carbon/human/species/darkgreytanuki
	race = /datum/species/feral/darkgreytanuki

//start deathclaws
/datum/species/feral/deathclaw
//start aethergiests
/datum/species/feral/aethergiest
	roundstart = FALSE //This is just the parent type, don't let players actually select it.
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/aethergiest
	gib_types = list(/obj/effect/gibspawner/generic)
	skinned_type = /obj/item/stack/sheet/animalhide/aethergiest
	liked_food = MEAT | RAW
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	simple_icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_width = 64
	footstep_type = FOOTSTEP_MOB_HEAVY

/datum/species/feral/aethergiest/original
	name = "Feral Deathclaw"
	id = "aethergiest"
	roundstart = TRUE
	icon_rest_suffix = ""
	rotate_on_lying = TRUE
	simple_icon = 'icons/mob/deathclaw.dmi'
/mob/living/carbon/human/species/aethergiest_original
	race = /datum/species/feral/aethergiest/original

/datum/species/feral/aethergiest/purple
	name = "Purple Cloaked Deathclaw"
	id = "pur"
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_purple
	race = /datum/species/feral/aethergiest/purple

/datum/species/feral/aethergiest/white
	name = "White Cloaked Deathclaw"
	id = "whi"
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_whi
	race = /datum/species/feral/aethergiest/white

/datum/species/feral/aethergiest/red
	name = "Red Cloaked Deathclaw"
	id = "red"
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_red
	race = /datum/species/feral/aethergiest/red

/datum/species/feral/aethergiest/grey
	name = "Grey Cloaked Deathclaw"
	id = "gry"
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_grey
	race = /datum/species/feral/aethergiest/grey

/datum/species/feral/aethergiest/black
	name = "Black Cloaked Deathclaw"
	id = "hub"
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_black
	race = /datum/species/feral/aethergiest/black

/datum/species/feral/aethergiest/brown
	name = "Brown Cloaked Deathclaw"
	id = "bro"
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_brown
	race = /datum/species/feral/aethergiest/brown

/datum/species/feral/aethergiest/maid
	name = "Maid Deathclaw"
	id = "maidclaw"
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_maid
	race = /datum/species/feral/aethergiest/maid

/datum/species/feral/aethergiest/queen
	name = "Queen Deathclaw"
	id = "deathclaw_queen"
	rotate_on_lying = TRUE
	icon_rest_suffix = ""
	roundstart = TRUE
/mob/living/carbon/human/species/aethergiest_queen
	race = /datum/species/feral/aethergiest/queen

/datum/species/feral/aethergiest/geist
	name = "Cavern Geist"
	id = "geist"
	rotate_on_lying = FALSE
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	alt_prefixes = list("Cyber" = "cyber_")
	roundstart = TRUE
/mob/living/carbon/human/species/geist
	race = /datum/species/feral/aethergiest/geist

/datum/species/feral/aethergiest/broodmother
	name = "Brood Mother"
	id = "broodmother"
	rotate_on_lying = TRUE
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
/mob/living/carbon/human/species/broodmother
	race = /datum/species/feral/aethergiest/broodmother

/datum/species/feral/femdigo
	name = "Female Wendigo"
	id = "femdigo"
	simple_icon = 'icons/mob/wendigo.dmi'
	icon_width = 32
	rotate_on_lying = TRUE
	roundstart = TRUE
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_r"

/mob/living/carbon/human/species/femdigo
	race = /datum/species/feral/femdigo

/datum/species/feral/bugs
	name = "Feral Sectdrone"
	id = "bug"
	simple_icon = 'modular_coyote/icons/mob/sectdrones.dmi'
	icon_width = 64
	rotate_on_lying = FALSE
	roundstart = TRUE
	alt_prefixes = list("Queen" = "queen_")
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"

/mob/living/carbon/human/species/bugs
	race = /datum/species/feral/bugs

//End Other//

//Start Synthetic Creatures//
/datum/species/adapted
	name = "REPORT THIS AS A BUG"
	//The id is the living and standing icon state of the creature.
	simple_icon = 'icons/mob/splurtbot.dmi'
	say_mod = "beeps"
	mutant_bodyparts = list("legs" = "Digitigrade", "meat_type" = "Mammalian")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc
	gib_types = list(/obj/effect/gibspawner/ipc, /obj/effect/gibspawner/ipc/bodypartless)
	icon_dead_suffix = "_dead"
	icon_rest_suffix = ""
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,MUTCOLORS,NOTRANSSTING,EYECOLOR,ROBOTIC_LIMBS,NO_DNA_COPY,NOEYES,LIPS,)
	inherent_traits = list(TRAIT_NODISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_RADIMMUNE,TRAIT_NOBREATH,TRAIT_CLONEIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_MUTATION_STASIS,)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID|MOB_BEAST|MOB_SYNTH
	//Just robo looking parts.
	mutant_heart = /obj/item/organ/heart/ipc
	mutantlungs = /obj/item/organ/lungs/ipc
	mutantliver = /obj/item/organ/liver/ipc
	mutantstomach = /obj/item/organ/stomach/ipc
	mutanteyes = /obj/item/organ/eyes/ipc
	mutantears = /obj/item/organ/ears/ipc
	mutanttongue = /obj/item/organ/tongue/robot/ipc
	mutant_brain = /obj/item/organ/brain/ipc
	icon_width = 32
	roundstart = FALSE
	footstep_type = FOOTSTEP_MOB_CLAW
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	tail_type = "mam_tail"
	wagging_type = "mam_waggingtail"
	allowed_limb_ids = list("mammal","aquatic","avian", "human", "shadekin")
	rotate_on_lying = TRUE
	damage_overlay_type = null
	exotic_bloodtype = "S"
	exotic_blood_color = BLOOD_COLOR_OIL
	species_type = "robotic" // It was just missing this little thing, I found it in ipc.dm. Hopefully this stops mechs from bleeding/getting wounds

/datum/species/adapted/handle_mutations_and_radiation(mob/living/carbon/human/H)
	return TRUE

/datum/species/adapted/spec_life(mob/living/carbon/human/H)
	/*if(H.nutrition < NUTRITION_LEVEL_FED)
		H.nutrition = NUTRITION_LEVEL_FED
	if(H.nutrition > NUTRITION_LEVEL_FED)
		H.nutrition = NUTRITION_LEVEL_FED*/
	if(H.losebreath != 0)
		H.losebreath = 0 // just in case
	if(H.toxloss)
		H.adjustToxLoss(-H.toxloss)

/datum/species/adapted/thicktron_standard
	name = "Adapted Assaultron(modified)"
	id = "assaultronstandard"
	roundstart = TRUE
/mob/living/carbon/human/species/thicktron_standard
	race = /datum/species/adapted/thicktron_standard

/datum/species/adapted/simplebot
	name = "REPORT THIS AS A BUG"
	simple_icon = 'icons/mob/robots.dmi'
	roundstart = FALSE

/datum/species/adapted/simplebot/handy
	name = "Adapted Handy Unit"
	id = "robot"
	roundstart = TRUE
/mob/living/carbon/human/species/handy
	race = /datum/species/adapted/simplebot/handy

/datum/species/adapted/simplebot/assaultron_med
	name = "Adapted Meditron"
	id = "assaultron_sase"
	roundstart = TRUE
/mob/living/carbon/human/species/assaultron_med
	race = /datum/species/adapted/simplebot/assaultron_med

/datum/species/adapted/simplebot/robobrain
	name = "Adapted Robobrain"
	id = "robobrain"
	icon_dead_suffix = "_d"
	roundstart = TRUE
/mob/living/carbon/human/species/robobrain
	race = /datum/species/adapted/simplebot/robobrain

/datum/species/adapted/simplebot/sentrybot
	name = "Adapted Sentrybot"
	id = "sentrybot"
	icon_rest_suffix = "_rest"
	rotate_on_lying = FALSE
	simple_icon = 'icons/fallout/mobs/robots/wasterobots.dmi'
	roundstart = TRUE
/mob/living/carbon/human/species/sentrybot
	race = /datum/species/adapted/simplebot/sentrybot

/datum/species/adapted/simplebot/flyingfortress
	name = "Adapted Flying Fortress"
	id = "netguardian"
	icon_rest_suffix = "-rest"
	icon_dead_suffix = "-crash"
	alt_prefixes = list("No Scanner" = "noscan_")
	rotate_on_lying = FALSE
	simple_icon = 'icons/mob/netguardian.dmi'
	icon_width = 48
	roundstart = TRUE
/mob/living/carbon/human/species/flyingfortress
	race = /datum/species/adapted/simplebot/flyingfortress

/datum/species/adapted/simplebot/swarmer
	name = "Adapted Swarmer"
	simple_icon = 'icons/mob/playerswarmer.dmi'
	id = "swarmer"
	roundstart = TRUE
	alt_prefixes = list("Ranged" = "ranged_", "Melee" = "melee_")
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "-rest"
	rotate_on_lying = FALSE
	attack_sound = 'sound/weapons/sear.ogg'
/mob/living/carbon/human/species/swarmer
	race = /datum/species/adapted/simplebot/swarmer

/datum/species/adapted/simplebot/swarmer/hivebot
	name = "Adapted Hivebot"
	id = "hivebot"
	alt_prefixes = list(
		"Small" = "small_",
		"Small Alt" = "smallarm_",
		"Medium" = "medium_",
		"Medium Alt" = "mediumarm_",
		"Ranged" = "ranged_",
		"Ranged Elite" = "rangedarm_",
		"Factory" = "factory_",
		"Hunter Killer" = "hunter_",
		"Custodian" = "keeper_",
		"Mythical" = "crystal_",
		"Cephalopod" = "cepha_",)
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = FALSE
	attack_sound = 'sound/weapons/sear.ogg'
/mob/living/carbon/human/species/hivebot
	race = /datum/species/adapted/simplebot/swarmer/hivebot

/datum/species/adapted/simplebot/probe
	name = "Adapted Probe"
	simple_icon = 'icons/obj/mining.dmi'
	id = "constructiondrone"
	roundstart = TRUE
	icon_dead_suffix = "-wreck"
	icon_rest_suffix = "_off"
	rotate_on_lying = FALSE
	footstep_type = FOOTSTEP_MOB_CRAWL
/mob/living/carbon/human/species/probe
	race = /datum/species/adapted/simplebot/probe

/datum/species/adapted/simplebot/swoopie
	name = "Adapted Swoopie"
	simple_icon = 'icons/mob/swoopie64x64_ch.dmi'
	id = "swoopie"
	roundstart = TRUE
	icon_width = 64
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = FALSE
	footstep_type = FOOTSTEP_MOB_HEAVY
/mob/living/carbon/human/species/swoopie
	race = /datum/species/adapted/simplebot/swoopie

/datum/species/adapted/simplebot/tallborg
	name = "Adapted Tall Synthetic"
	id = "tallborg"
	simple_icon = 'icons/mob/tallrobot.dmi'
// This is going to be quite long... Theres alot
	alt_prefixes = list(
		"Default Feminine" = "fem_",
		"Default Alt Fem" = "femalt_",
		"Default K4T" = "k4t_",
		"Cargo" = "cargo_",
		"Feminine Cargo" = "femcargo_",
		"Alt Fem Cargo" = "altfemcargo_",
		"K4T Cargo" = "k4tcargo_",
		"Alt K4T Cargo" = "altk4tcargo_",
		"Advanced Cargo" = "dullahancargo_",
		"Miner" = "mine_",
		"Feminine Miner" = "femmine_",
		"Alt Fem Miner" = "altfemmine_",
		"K4T Miner" = "k4tmine_",
		"Alt K4T Miner" = "altk4tmine_",
		"Advanced Miner" = "dullahanmine_",
		"Medical" = "medi_",
		"Feminine Medical" = "femmedi_",
		"Alt Fem Medical" = "altfemmedi_",
		"K4T Medical" = "k4tmedi_",
		"Alt K4T Medical" = "altk4tmed_",
		"Advanced Medical" = "dullahanmed_",
		"Janitor" = "jani_",
		"Feminine Janitor" = "femjani_",
		"Alt Fem Janitor" = "altfemjani_",
		"K4T Janitor" = "k4tjani_",
		"Alt K4T Janitor" = "altk4tjani_",
		"Advanced Janitor" = "dullahanjani_",
		"Engineer" = "engi_",
		"Feminine Engineer" = "engifem_",
		"Alt Fem Engineer" = "altengifem_",
		"K4T Engineer" = "k4tengi_",
		"Alt K4T Engineer" = "altk4tengi_",
		"Advanced Engineer" = "dullahaneng_",
		"Security" = "sec_",
		"Feminine Security" = "femsec_",
		"Alt Fem Security" = "femsecalt_",
		"K4T Security" = "k4tsec_",
		"Advanced Security" = "dullahansec_",
		"Service" = "serve_",
		"Feminine Service" = "femserve_",
		"Alt Fem Service" = "altfemserve_",
		"K4T Service" = "k4tserve_",
		"Alt K4T Service" = "altk4tserve_",
		"Advanced Service" = "dullahanserv_",
		"Advanced Religious" = "dullahanchurch_",
		"Ninja" = "ninja_",
		"Feminine Ninja" = "femninja_",
		"Alt Fem Ninja" = "altfemninja_",
		"K4T Ninja" = "k4tninja_",
		"Advanced Ninja" = "dullahanexplo_",
		"Syndicate" = "syndi_",
		"Feminine Syndicate" = "femsyndi_",
		"Alt Fem Syndicate" = "realv1fromultrakill_",
		"K4T Syndicate" = "k4tsyndi_",
		"Advanced Syndicate" = "dullahansyndi_",
	)
	icon_dead_suffix = "-wreck"
	icon_rest_suffix = "-rest"
	roundstart = TRUE
	rotate_on_lying = FALSE
	attack_sound = 'sound/weapons/sear.ogg'
/mob/living/carbon/human/species/tallborg
	race = /datum/species/adapted/simplebot/tallborg

// Lets just seperate all the feral robot animal robots from the pure, normal robots this time that totally arent thicc

/datum/species/adapted/dogborg
	name = "REPORT THIS AS A BUGGY"
	simple_icon = 'modular_coyote/icons/mob/dogborg.dmi'
	roundstart = FALSE
	rotate_on_lying = FALSE
	icon_width = 62
	icon_rest_suffix = "_rest"
	icon_dead_suffix = "-wreck"

/datum/species/adapted/dogborg/zoid
	name = "Adapted Zoid"
	id = "zoid"
	simple_icon = 'modular_coyote/icons/mob/zoids.dmi'
	roundstart = TRUE
	alt_prefixes = list("Zaber" = "zaber_")
	icon_width = 32
	icon_rest_suffix = "_rest"
	icon_dead_suffix = "_dead"
/mob/living/carbon/human/species/zoid
	race = /datum/species/adapted/dogborg/zoid

/datum/species/adapted/dogborg/sechound
	name = "Adapted Sechound"
	id = "valesec"
	alt_prefixes = list("Blocky" = "blocky_", "Dark" = "dark_")
	roundstart = TRUE
/mob/living/carbon/human/species/sechound
	race = /datum/species/adapted/dogborg/sechound

/datum/species/adapted/dogborg/medihound
	name = "Adapted Medhound"
	id = "valemed"
	alt_prefixes = list("Light" = "light_", "Dark" = "dark_")
	roundstart = TRUE
/mob/living/carbon/human/species/medihound
	race = /datum/species/adapted/dogborg/medihound

/datum/species/adapted/dogborg/scrubpup
	name = "Adapted Scrubhound"
	id = "scrubpup"
	roundstart = TRUE
/mob/living/carbon/human/species/scrubpup
	race = /datum/species/adapted/dogborg/scrubpup

/datum/species/adapted/dogborg/engihound
	name = "Adapted Engihound"
	id = "valeeng"
	alt_prefixes = list("Blocky" = "pupdozer_")
	roundstart = TRUE
/mob/living/carbon/human/species/engihound
	race = /datum/species/adapted/dogborg/engihound

/datum/species/adapted/dogborg/minehound
	name = "Adapted Minehound"
	id = "valemine"
	roundstart = TRUE
/mob/living/carbon/human/species/minehound
	race = /datum/species/adapted/dogborg/minehound

/datum/species/adapted/dogborg/scihound
	name = "Adapted Scihound"
	id = "valesci"
	roundstart = TRUE
/mob/living/carbon/human/species/scihound
	race = /datum/species/adapted/dogborg/scihound

/datum/species/adapted/dogborg/servihound
	name = "Adapted Servihound"
	id = "valeserv"
	alt_prefixes = list("Blocky" = "blocky_", "Dark" = "dark_")
	roundstart = TRUE
/mob/living/carbon/human/species/servihound
	race = /datum/species/adapted/dogborg/servihound

/datum/species/adapted/dogborg/badboi
	name = "Adapted Corrupted Hound"
	id = "badboi"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	alt_prefixes = list("Girly" = "pretty_")
	icon_dead_suffix = "-dead"
	roundstart = TRUE
/mob/living/carbon/human/species/badboi
	race = /datum/species/adapted/dogborg/badboi

/datum/species/adapted/dogborg/otieborg
	name = "Fenny please be nice to them"
	simple_icon = 'modular_splurt/icons/mob/widerobot.dmi'
	icon_rest_suffix = "-rest"
	icon_dead_suffix = "-wreck"
	roundstart = FALSE

/datum/species/adapted/dogborg/otieborg/otiee
	name = "Engineering Otieborg"
	id = "otiee"
	roundstart = TRUE
/mob/living/carbon/human/species/otiee
	race = /datum/species/adapted/dogborg/otieborg/otiee

/datum/species/adapted/dogborg/otieborg/otiej
	name = "Janitor Otieborg"
	id = "otiej"
	roundstart = TRUE
/mob/living/carbon/human/species/otiej
	race = /datum/species/adapted/dogborg/otieborg/otiej

/datum/species/adapted/dogborg/otieborg/otiec
	name = "Cargo Otieborg"
	id = "otiec"
	roundstart = TRUE
/mob/living/carbon/human/species/otiec
	race = /datum/species/adapted/dogborg/otieborg/otiec

/datum/species/adapted/dogborg/otieborg/oties
	name = "Security Otieborg"
	id = "oties"
	roundstart = TRUE
/mob/living/carbon/human/species/oties
	race = /datum/species/adapted/dogborg/otieborg/oties

/datum/species/adapted/raptorborg
	name = "REPORT THIS AS A BUG"
	simple_icon = 'modular_coyote/icons/mob/newraptorborg.dmi'
	roundstart = FALSE
	rotate_on_lying = FALSE
	icon_width = 64
	icon_rest_suffix = "-rest"
	icon_dead_suffix = "-wreck"

/datum/species/adapted/raptorborg/secraptor
	name = "Adapted Secraptor"
	id = "secraptor"
	roundstart = TRUE
	alt_prefixes = list("White Sec" = "white_")
/mob/living/carbon/human/species/secraptor
	race = /datum/species/adapted/raptorborg/secraptor

/datum/species/adapted/raptorborg/sciraptor
	name = "Adapted Sciraptor"
	id = "sciraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/sciraptor
	race = /datum/species/adapted/raptorborg/sciraptor

/datum/species/adapted/raptorborg/medraptor
	name = "Adapted Medraptor"
	id = "medraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/medraptor
	race = /datum/species/adapted/raptorborg/medraptor

/datum/species/adapted/raptorborg/syndiraptor
	name = "Adapted Syndiraptor"
	id = "syndiraptor"
	roundstart = TRUE
	alt_prefixes = list("Medical" = "medi_", "Mech" = "mech_")
/mob/living/carbon/human/species/syndiraptor
	race = /datum/species/adapted/raptorborg/syndiraptor

/datum/species/adapted/raptorborg/engiraptor
	name = "Adapted Engiraptor"
	id = "engiraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/engiraptor
	race = /datum/species/adapted/raptorborg/engiraptor

/datum/species/adapted/raptorborg/energyraptor
	name = "Adapted Energyraptor"
	id = "energyraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/energyraptor
	race = /datum/species/adapted/raptorborg/energyraptor

/datum/species/adapted/raptorborg/mineraptor
	name = "Adapted Mineraptor"
	id = "mineraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/mineraptor
	race = /datum/species/adapted/raptorborg/mineraptor

/datum/species/adapted/raptorborg/churchraptor
	name = "Adapted Churchraptor"
	id = "churchraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/churchraptor
	race = /datum/species/adapted/raptorborg/churchraptor

/datum/species/adapted/raptorborg/janiraptor
	name = "Adapted Janiraptor"
	id = "janiraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/janiraptor
	race = /datum/species/adapted/raptorborg/janiraptor

/datum/species/adapted/raptorborg/serviraptor
	name = "Adapted Serviraptor"
	id = "serviraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/serviraptor
	race = /datum/species/adapted/raptorborg/serviraptor

/datum/species/adapted/raptorborg/fancyraptor
	name = "Adapted Fancyraptor"
	id = "fancyraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/fancyraptor
	race = /datum/species/adapted/raptorborg/fancyraptor

/datum/species/adapted/raptorborg/wreckraptor
	name = "Adapted Wreckedraptor"
	id = "wreckraptor"
	roundstart = TRUE
/mob/living/carbon/human/species/wreckraptor
	race = /datum/species/adapted/raptorborg/wreckraptor

/datum/species/adapted/raptorborg/smolraptor
	name = "Adapted Smolraptor"
	id = "smolraptor"
	simple_icon = 'modular_coyote/icons/mob/microraptor.dmi'
	roundstart = TRUE
	rotate_on_lying = TRUE
	alt_prefixes = list(
	"Central Command" = "cc_", 
	"Science" = "sci_", 
	"White" = "white_", 
	"Mining" = "mine_", 
	"Medical" = "med_",
	"White" = "white_",
	"Janitor" = "jani_",
	"Engineer" = "eng_",
	"Service" = "serv_",
	"Cargo" = "car_")
/mob/living/carbon/human/species/smolraptor
	race = /datum/species/adapted/raptorborg/smolraptor

/datum/species/adapted/raptorborg/microraptor
	name = "Adapted Microraptor"
	id = "raptor"
	simple_icon = 'modular_coyote/icons/mob/paramob.dmi'
	roundstart = TRUE
	icon_width = 32
	icon_rest_suffix = "_rest"
	icon_dead_suffix = "_dead"
	alt_prefixes = list("Blue" = "blue_", "Red" = "red_", "White" = "white_")
/mob/living/carbon/human/species/microraptor
	race = /datum/species/adapted/raptorborg/microraptor

// End of the silly raptors

/datum/species/adapted/drakeborg
	name = "REPORT THIS AS A BUGGY"
	simple_icon = 'modular_coyote/code/drakeborgs/drakeborg_vr.dmi'
	roundstart = FALSE
	rotate_on_lying = FALSE
	icon_width = 64
	icon_rest_suffix = "_rest"
	icon_dead_suffix = "-wreck"

/datum/species/adapted/drakeborg/drakesec //haha more like adapted/drakeborg/drakesex am I right
	name = "Adapted Sec Drake"
	id = "drakesec"
	roundstart = TRUE
/mob/living/carbon/human/species/drakesec
	race = /datum/species/adapted/drakeborg/drakesec

/datum/species/adapted/drakeborg/drakemed
	name = "Adapted Med Drake"
	id = "drakemed"
	roundstart = TRUE
/mob/living/carbon/human/species/drakemed
	race = /datum/species/adapted/drakeborg/drakemed

/datum/species/adapted/drakeborg/drakeeng
	name = "Adapted Eng Drake"
	id = "drakeeng"
	roundstart = TRUE
/mob/living/carbon/human/species/drakeeng
	race = /datum/species/adapted/drakeborg/drakeeng

/datum/species/adapted/drakeborg/drakemine
	name = "Adapted Mine Drake"
	id = "drakemine"
	roundstart = TRUE
/mob/living/carbon/human/species/drakemine
	race = /datum/species/adapted/drakeborg/drakemine

/datum/species/adapted/drakeborg/drakesci
	name = "Adapted Sci Drake"
	id = "drakesci"
	roundstart = TRUE
/mob/living/carbon/human/species/drakesci
	race = /datum/species/adapted/drakeborg/drakesci

/datum/species/adapted/drakeborg/drakejanit
	name = "Adapted Janitor Drake"
	id = "drakejanit"
	roundstart = TRUE
/mob/living/carbon/human/species/drakejanit
	race = /datum/species/adapted/drakeborg/drakejanit


//get in the mech, shinji
/datum/species/adapted/mechs
	name = "REPORT THIS AS A BUG"
	simple_icon = 'icons/mecha/mecha.dmi'
	icon_dead_suffix = "-broken"
	footstep_type = FOOTSTEP_MOB_HEAVY
	roundstart = FALSE

/datum/species/adapted/mechs/gygax
	name = "Adapted Gygax"
	id = "gygax"
	roundstart = TRUE
/mob/living/carbon/human/species/gygax
	race = /datum/species/adapted/mechs/gygax

/datum/species/adapted/mechs/darkgygax
	name = "Adapted Darkgygax"
	id = "darkgygax"
	roundstart = TRUE
/mob/living/carbon/human/species/darkgygax
	race = /datum/species/adapted/mechs/darkgygax

/datum/species/adapted/mechs/ripley
	name = "Adapted Ripley"
	id = "ripley"
	roundstart = TRUE
/mob/living/carbon/human/species/ripley
	race = /datum/species/adapted/mechs/ripley

/datum/species/adapted/mechs/marauder
	name = "Adapted Marauder"
	id = "marauder"
	roundstart = TRUE
/mob/living/carbon/human/species/marauder
	race = /datum/species/adapted/mechs/marauder

/datum/species/adapted/mechs/seraph
	name = "Adapted Seraph"
	id = "seraph"
	roundstart = TRUE
/mob/living/carbon/human/species/seraph
	race = /datum/species/adapted/mechs/seraph

/datum/species/adapted/mechs/phazon
	name = "Adapted Phazon"
	id = "phazon"
	roundstart = TRUE
/mob/living/carbon/human/species/phazon
	race = /datum/species/adapted/mechs/phazon //This one is for you, Nioha

/datum/species/adapted/mechs/mauler
	name = "Adapted Mauler"
	id = "mauler"
	roundstart = TRUE
/mob/living/carbon/human/species/mauler
	race = /datum/species/adapted/mechs/mauler

/datum/species/adapted/mechs/odysseus
	name = "Adapted Odysseus"
	id = "odysseus"
	roundstart = TRUE
/mob/living/carbon/human/species/odysseus
	race = /datum/species/adapted/mechs/odysseus

/datum/species/adapted/mechs/durand
	name = "Adapted Durand"
	id = "durand"
	roundstart = TRUE
/mob/living/carbon/human/species/durand
	race = /datum/species/adapted/mechs/durand

/datum/species/adapted/mechs/medigax
	name = "Adapted Medigax"
	id = "medigax"
	roundstart = TRUE
/mob/living/carbon/human/species/medigax
	race = /datum/species/adapted/mechs/medigax

/datum/species/adapted/mechs/tachi
	name = "Adapted Tachi"
	id = "tachi"
	roundstart = TRUE
/mob/living/carbon/human/species/tachi
	race = /datum/species/adapted/mechs/tachi


//End Synthetic Creatures

//Angel Wings

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/wings/is_not_visible(mob/living/carbon/human/H, tauric)
	return (!H.dna.features["wings"] || H.dna.features["wings"] == "None" || (H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(src, H.wear_suit.species_exception))))

/datum/sprite_accessory/wings_open
	icon = 'icons/mob/wings.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings_open/is_not_visible(mob/living/carbon/human/H, tauric)
	return (H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(src, H.wear_suit.species_exception)) || H.dna.species.mutant_bodyparts["wings"])

/datum/sprite_accessory/wings_open/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34

/datum/sprite_accessory/wings
	icon = 'icons/mob/wings.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE

// Decorative wings

/datum/sprite_accessory/deco_wings
	icon = 'icons/mob/wings.dmi'
	color_src = WINGCOLOR
	mutant_part_string = "insect_wings"
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/deco_wings/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/deco_wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/deco_wings/bat
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/deco_wings/batmini
	name = "Bat Mini"
	icon_state = "minibat"

/datum/sprite_accessory/deco_wings/battiny
	name = "Bat Tiny"
	icon_state = "tinybat"

/datum/sprite_accessory/deco_wings/bee
	name = "Bee"
	icon_state = "bee2"

/datum/sprite_accessory/deco_wings/beetle
	name = "Beetle"
	icon_state = "beetle"

/datum/sprite_accessory/deco_wings/butterfly
	name = "Butterfly"
	icon_state = "bee"

/datum/sprite_accessory/deco_wings/cyber
	name = "Cybernetic"
	icon_state = "cyber"

/datum/sprite_accessory/deco_wings/cyber2
	name = "Cybernetic - Alternate Back"
	icon_state = "cyber2"

/datum/sprite_accessory/deco_wings/demon
	name = "Demon"
	icon_state = "demon"

/datum/sprite_accessory/deco_wings/dragon
	name = "Dragon"
	icon_state = "dragon"

/datum/sprite_accessory/deco_wings/dragonfly
	name = "Dragonfly"
	icon_state = "dragonfly"

/datum/sprite_accessory/deco_wings/eyestalks
	name = "Eyestalks"
	icon_state = "eyestalks"

/datum/sprite_accessory/deco_wings/fairy
	name = "Fairy"
	icon_state = "fairy"

/datum/sprite_accessory/deco_wings/fairy2
	name = "Fairy - No Sparkle"
	icon_state = "fairy2"

/datum/sprite_accessory/deco_wings/feathery
	name = "Feathered"
	icon_state = "feathery"

/datum/sprite_accessory/deco_wings/feathery2
	name = "Feathered Medium"
	icon_state = "featherym"

/datum/sprite_accessory/deco_wings/feathery3
	name = "Feathered Large"
	icon_state = "featheryl"

/datum/sprite_accessory/deco_wings/feathermini
	name = "Feathered Mini"
	icon_state = "minifeather"

/datum/sprite_accessory/deco_wings/feathertiny
	name = "Feathered Tiny"
	icon_state = "tinyfeather"

/datum/sprite_accessory/deco_wings/harpy
	name = "Harpy"
	icon_state = "harpy"

/datum/sprite_accessory/deco_wings/insect
	name = "Insect"
	icon_state = "insect"

/datum/sprite_accessory/deco_wings/mantis
	name = "Mantis Arms"
	icon_state = "mantis"

/datum/sprite_accessory/deco_wings/moth_atlas
	name = "Moth - Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/deco_wings/moth_brown
	name = "Moth - Brown"
	icon_state = "brown"

/datum/sprite_accessory/deco_wings/moth_burnt
	name = "Moth - Burnt"
	icon_state = "punished"

/datum/sprite_accessory/deco_wings/moth_deathhead
	name = "Moth - Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/deco_wings/moth_feathery
	name = "Moth - Feathery"
	icon_state = "featherymoth"

/datum/sprite_accessory/deco_wings/moth_firewatch
	name = "Moth - Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/deco_wings/moth_gothic
	name = "Moth - Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/deco_wings/moth_jungle
	name = "Moth - Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/deco_wings/moth_lover
	name = "Moth - Lover"
	icon_state = "lovers"

/datum/sprite_accessory/deco_wings/moth_luna
	name = "Moth - Luna"
	icon_state = "luna"

/datum/sprite_accessory/deco_wings/moth_monarch
	name = "Moth - Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/deco_wings/moth_moonfly
	name = "Moth - Moonfly"
	icon_state = "moonfly"

/datum/sprite_accessory/deco_wings/moth_oakworm
	name = "Moth - Oakworm"
	icon_state = "oakworm"

/datum/sprite_accessory/deco_wings/moth_plain
	name = "Moth - Plain"
	icon_state = "plain"

/datum/sprite_accessory/deco_wings/moth_plasmafire
	name = "Moth - Plasmafire"
	icon_state = "plasmafire"

/datum/sprite_accessory/deco_wings/moth_poison
	name = "Moth - Poison"
	icon_state = "poison"

/datum/sprite_accessory/deco_wings/moth_red
	name = "Moth - Red"
	icon_state = "redish"

/datum/sprite_accessory/deco_wings/moth_ragged
	name = "Moth - Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/deco_wings/moth_rosy
	name = "Moth - Rosy"
	icon_state = "rosy"

/datum/sprite_accessory/deco_wings/moth_royal
	name = "Moth - Royal"
	icon_state = "royal"

/datum/sprite_accessory/deco_wings/moth_snow
	name = "Moth - Snow"
	icon_state = "snow"

/datum/sprite_accessory/deco_wings/moth_whitefly
	name = "Moth - Whitefly"
	icon_state = "whitefly"

/datum/sprite_accessory/deco_wings/moth_witchwing
	name = "Moth - Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/deco_wings/nevrean
	name = "Nevrean"
	icon_state = "nevrean"

/datum/sprite_accessory/deco_wings/nevrean2
	name = "Nevrean - No Tail"
	icon_state = "nevrean2"

/datum/sprite_accessory/deco_wings/robotic
	name = "Robotic"
	icon_state = "shock"

/datum/sprite_accessory/deco_wings/robotic2
	name = "Robotic - No Tail"
	icon_state = "shock2"

/datum/sprite_accessory/deco_wings/sepulchre
	name = "Sepulchre"
	icon_state = "sepulchre"

/datum/sprite_accessory/deco_wings/succubusblack
	name = "Succubus - Black"
	icon_state = "succubusblack"

/datum/sprite_accessory/deco_wings/succubusblack2
	name = "Succubus - Black No Tail"
	icon_state = "succubusblack2"

/datum/sprite_accessory/deco_wings/succubuspurple
	name = "Succubus - Purple"
	icon_state = "succubuspurple"

/datum/sprite_accessory/deco_wings/succubuspurple2
	name = "Succubus - Purple No Tail"
	icon_state = "succubuspurple2"

/datum/sprite_accessory/deco_wings/succubusred
	name = "Succubus - Red"
	icon_state = "succubusred"

/datum/sprite_accessory/deco_wings/succubusred2 //six succubus wings? this truly is erp central
	name = "Succubus - Red No Tail"
	icon_state = "succubusred2"

/datum/sprite_accessory/deco_wings/spider
	name = "Spider Legs"
	icon_state = "spider"

/datum/sprite_accessory/deco_wings/xeno
	name = "Xeno Backplate"
	icon_state = "backplate"

//INSECT WINGS

/datum/sprite_accessory/insect_wings
	icon = 'icons/mob/wings.dmi'
	color_src = WINGCOLOR
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)


/datum/sprite_accessory/insect_wings/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/insect_wings/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/insect_wings/brown
	name = "Brown"
	icon_state = "brown"

/datum/sprite_accessory/insect_wings/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/insect_wings/featherymoth
	name = "Feathery Moth Wings"
	icon_state = "featherymoth"

/datum/sprite_accessory/insect_wings/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/insect_wings/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/insect_wings/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/insect_wings/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/insect_wings/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/insect_wings/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/insect_wings/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/insect_wings/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/insect_wings/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/insect_wings/plasmafire
	name = "Plasma Fire"
	icon_state = "plasmafire"

/datum/sprite_accessory/insect_wings/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/insect_wings/punished
	name = "Burnt Off"
	icon_state = "punished"

/datum/sprite_accessory/insect_wings/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/insect_wings/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/insect_wings/rosy
	name = "Rosy"
	icon_state = "rosy"

/datum/sprite_accessory/insect_wings/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/insect_wings/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/insect_wings/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/insect_wings/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/insect_wings/bee
	name = "Bee"
	icon_state = "bee2"

/datum/sprite_accessory/insect_wings/beetle
	name = "Beetle"
	icon_state = "beetle"

/datum/sprite_accessory/insect_wings/dragonfly
	name = "Dragonfly"
	icon_state = "dragonfly"

/datum/sprite_accessory/insect_wings/insect
	name = "Insect"
	icon_state = "insect"

//insect markings
/datum/sprite_accessory/insect_markings // Extra markings for insects ported from tg.
	icon = 'icons/mob/insect_markings.dmi'
	color_src = null
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/insect_markings/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/insect_markings/reddish
	name = "Reddish"
	icon_state = "reddish"

/datum/sprite_accessory/insect_markings/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/insect_markings/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/insect_markings/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/insect_markings/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/insect_markings/punished
	name = "Punished"
	icon_state = "punished"

/datum/sprite_accessory/insect_markings/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/insect_markings/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/insect_markings/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/insect_markings/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/insect_markings/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/insect_markings/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/insect_markings/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/insect_markings/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

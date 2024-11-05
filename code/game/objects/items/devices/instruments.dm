//copy pasta of the space piano, don't hurt me -Pete
/obj/item/instrument
	name = "generic instrument"
	resistance_flags = FLAMMABLE
	force = 20
	max_integrity = 100
	icon = 'icons/obj/musician.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/instruments_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/instruments_righthand.dmi'
	var/datum/song/handheld/song
	var/instrumentId = "generic"
	var/instrumentExt = "mid"

/obj/item/instrument/Initialize()
	. = ..()
	song = new(instrumentId, src, instrumentExt)

/obj/item/instrument/Destroy()
	qdel(song)
	song = null
	return ..()

/obj/item/instrument/Initialize(mapload)
	. = ..()
	if(mapload)
		song.tempo = song.sanitize_tempo(song.tempo) // tick_lag isn't set when the map is loaded

/obj/item/instrument/interact(mob/user)
	ui_interact(user)

/obj/item/instrument/ui_interact(mob/user)
	if(!user)
		return

	if(!isliving(user) || user.stat || user.restrained() || user.lying)
		return

	user.set_machine(src)
	song.interact(user)

/obj/item/instrument/violin
	name = "violin"
	desc = "A wooden musical instrument with four strings and a bow."
	icon_state = "violin"
	inhand_icon_state = "violin"
	hitsound = "swing_hit"
	force_wielded = 35
	instrumentId = "violin"
	instrumentExt = "mid"

/obj/item/instrument/violin/golden
	name = "golden violin"
	desc = "A golden musical instrument with four strings and a bow."
	force_wielded = 45
	icon_state = "golden_violin"
	inhand_icon_state = "golden_violin"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/instrument/piano_synth
	name = "synthesizer"
	desc = "An advanced electronic synthesizer that can be used as various instruments."
	force_wielded = 40
	icon_state = "synth"
	inhand_icon_state = "synth"
	instrumentId = "piano"
	instrumentExt = "ogg"
	var/static/list/insTypes = list("accordion" = "mid", "bikehorn" = "ogg", "glockenspiel" = "mid", "guitar" = "ogg", "harmonica" = "mid", "piano" = "ogg", "recorder" = "mid", "saxophone" = "mid", "trombone" = "mid", "violin" = "mid", "xylophone" = "mid")	//No eguitar you ear-rapey fuckers.
	actions_types = list(/datum/action/item_action/synthswitch)

/obj/item/instrument/piano_synth/proc/changeInstrument(name = "piano")
	song.instrumentDir = name
	song.instrumentExt = insTypes[name]

/obj/item/instrument/guitar
	name = "guitar"
	desc = "It's made of wood and has bronze strings."
	icon_state = "guitar"
	inhand_icon_state = "guitar"
	force_wielded = 40
	instrumentExt = "ogg"
	attack_verb = list("played metal on", "serenaded", "crashed", "smashed")
	hitsound = 'sound/weapons/stringsmash.ogg'
	instrumentId = "guitar"

/obj/item/instrument/eguitar
	name = "electric guitar"
	desc = "Makes all your shredding needs possible."
	icon_state = "eguitar"
	inhand_icon_state = "eguitar"
	force = 30
	force_wielded = 47 //Rock on, mother fucker. ~TK
	attack_verb = list("played metal on", "shredded", "crashed", "smashed")
	hitsound = 'sound/weapons/stringsmash.ogg'
	instrumentId = "eguitar"
	instrumentExt = "ogg"

/obj/item/instrument/glockenspiel
	name = "glockenspiel"
	desc = "Smooth metal bars perfect for any marching band."
	force_wielded = 35
	icon_state = "glockenspiel"
	inhand_icon_state = "glockenspiel"
	instrumentId = "glockenspiel"
	instrumentExt = "mid"

/obj/item/instrument/accordion
	name = "accordion"
	desc = "Pun-Pun not included."
	force_wielded = 40
	icon_state = "accordion"
	inhand_icon_state = "accordion"
	instrumentId = "accordion"
	instrumentExt = "mid"

/obj/item/instrument/trumpet
	name = "trumpet"
	desc = "To announce the arrival of the king!"
	force_wielded = 35
	icon_state = "trumpet"
	inhand_icon_state = "trombone"
	instrumentId = "trombone"
	instrumentExt = "mid"

/obj/item/instrument/trumpet/spectral
	name = "spectral trumpet"
	desc = "Things are about to get spooky!"
	force_wielded = 35
	icon_state = "trumpet"
	inhand_icon_state = "trombone"
	force = 0
	instrumentId = "trombone"
	attack_verb = list("played","jazzed","trumpeted","mourned","dooted","spooked")

/obj/item/instrument/trumpet/spectral/Initialize()
	. = ..()
	AddComponent(/datum/component/spooky)

/obj/item/instrument/trumpet/spectral/attack(mob/living/carbon/C, mob/user)
	playsound (loc, 'sound/runtime/instruments/trombone/En4.mid', 100,1,-1)
	..()

/obj/item/instrument/saxophone
	name = "saxophone"
	desc = "This soothing sound will be sure to leave your audience in tears."
	force_wielded = 40
	icon_state = "saxophone"
	inhand_icon_state = "saxophone"
	instrumentId = "saxophone"
	instrumentExt = "mid"

/obj/item/instrument/saxophone/spectral
	name = "spectral saxophone"
	desc = "This spooky sound will be sure to leave mortals in bones."
	icon_state = "saxophone"
	inhand_icon_state = "saxophone"
	instrumentId = "saxophone"
	force = 20
	attack_verb = list("played","jazzed","saxxed","mourned","dooted","spooked")

/obj/item/instrument/saxophone/spectral/Initialize()
	. = ..()
	AddComponent(/datum/component/spooky)

/obj/item/instrument/saxophone/spectral/attack(mob/living/carbon/C, mob/user)
	playsound (loc, 'sound/runtime/instruments/saxophone/En4.mid', 100,1,-1)
	..()

/obj/item/instrument/trombone
	name = "trombone"
	desc = "How can any pool table ever hope to compete?"
	force_wielded = 35
	icon_state = "trombone"
	inhand_icon_state = "trombone"
	instrumentId = "trombone"
	instrumentExt = "mid"

/obj/item/instrument/trombone/spectral
	name = "spectral trombone"
	desc = "A skeleton's favorite instrument. Apply directly on the mortals."
	force_wielded = 40
	instrumentId = "trombone"
	icon_state = "trombone"
	inhand_icon_state = "trombone"
	force = 20
	attack_verb = list("played","jazzed","tromboned","mourned","dooted","spooked")

/obj/item/instrument/trombone/spectral/Initialize()
	. = ..()
	AddComponent(/datum/component/spooky)

/obj/item/instrument/trombone/spectral/attack(mob/living/carbon/C, mob/user)
	playsound (loc, 'sound/runtime/instruments/trombone/Cn4.mid', 100,1,-1)
	..()

/obj/item/instrument/recorder
	name = "recorder"
	desc = "Just like in school, playing ability and all."
	force = 5
	force_wielded = 20 //Don't worry about it. ~TK
	icon_state = "recorder"
	inhand_icon_state = "recorder"
	instrumentId = "recorder"
	instrumentExt = "mid"

/obj/item/instrument/harmonica
	name = "harmonica"
	desc = "For when you get a bad case of the blues."
	icon_state = "harmonica"
	inhand_icon_state = "harmonica"
	instrumentId = "harmonica"
	instrumentExt = "mid"
	slot_flags = INV_SLOTBIT_MASK
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/instrument)


/obj/item/instrument/harmonica/speechModification(message)
	if(song.playing && ismob(loc))
		to_chat(loc, span_warning("You stop playing the harmonica to talk..."))
		song.playing = FALSE
	return message

/obj/item/instrument/bikehorn
	name = "gilded bike horn"
	desc = "An exquisitely decorated bike horn, capable of honking in a variety of notes."
	icon_state = "bike_horn"
	inhand_icon_state = "bike_horn"
	lefthand_file = 'icons/mob/inhands/equipment/horns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/horns_righthand.dmi'
	attack_verb = list("beautifully honks")
	instrumentId = "bikehorn"
	instrumentExt = "ogg"
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throw_speed = 3
	throw_range = 15
	hitsound = 'sound/items/bikehorn.ogg'

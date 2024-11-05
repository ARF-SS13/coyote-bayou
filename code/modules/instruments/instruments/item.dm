//copy pasta of the space piano, don't hurt me -Pete
/obj/item/instrument
	name = "generic instrument"
	force = 10
	max_integrity = 100
	resistance_flags = FLAMMABLE
	icon = 'icons/obj/musician.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/instruments_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/instruments_righthand.dmi'
	var/datum/song/handheld/song
	var/list/allowed_instrument_ids
	var/tune_time_left = 0
	COOLDOWN_DECLARE(good_music_heal)
	var/good_music_heal_cd = 1 SECONDS

/obj/item/instrument/Initialize(mapload)
	. = ..()
	song = new(src, allowed_instrument_ids)
	allowed_instrument_ids = null			//We don't need this clogging memory after it's used.

/obj/item/instrument/Destroy()
	QDEL_NULL(song)
	if(tune_time_left)
		STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/instrument/proc/should_stop_playing(mob/user)
	return !user.can_reach(src) || !user.canUseTopic(src, FALSE, TRUE, FALSE, FALSE)

/obj/item/instrument/process(wait)
	if(is_tuned())
		if (song.playing)
			var/mob/living/player = recursive_loc_path_search(src, /mob/living)
			var/goodmusic = (player && HAS_TRAIT(player, TRAIT_MUSICIAN))
			if(goodmusic)
				make_a_sparkle(player)
			for (var/mob/living/M in song.hearing_mobs)
				M.dizziness = max(0,M.dizziness-2)
				M.jitteriness = max(0,M.jitteriness-2)
				M.confused = max(M.confused-1)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "goodmusic", /datum/mood_event/goodmusic)
				if(ishuman(M))
					var/mob/living/carbon/human/lstnr = M
					var/datum/reagents/R = lstnr.reagents
					var/list/payload = list(
						"songer" = player.real_name,
						"kind" = song.name,
					)
					R.add_reagent(/datum/reagent/medicine/music, 1, payload)
		tune_time_left -= wait
	else
		tune_time_left = 0
		if (song.playing)
			loc.visible_message(span_warning("[src] starts sounding a little off..."))
		STOP_PROCESSING(SSprocessing, src)

/obj/item/instrument/proc/make_a_sparkle(mob/living/carbon/C)
	if(!C)
		return
	var/obj/effect/temp_visual/music/H = new /obj/effect/temp_visual/music(get_turf(C))
	SSeffects.floaterize(H, C.dir, rand(1,2), rand(1,3) SECONDS)

/obj/effect/temp_visual/music
	name = "lovely music"
	icon_state = "music"
	duration = 3 SECONDS
	color = "#8591ff"

/obj/item/instrument/attack_self(mob/user)
	//if(!user.IsAdvancedToolUser())
	//	to_chat(user, span_warning("You don't have the dexterity to do this!"))
	//	return TRUE
	interact(user)

/obj/item/instrument/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/musicaltuner))
		var/mob/living/carbon/human/H = user
		if (HAS_TRAIT(H, TRAIT_MUSICIAN))
			if (!is_tuned())
				H.visible_message("[H] tunes the [src] to perfection!", span_notice("You tune the [src] to perfection!"))
				tune_time_left = 30 MINUTES
				START_PROCESSING(SSprocessing, src)
			else
				to_chat(H, span_notice("[src] is already well tuned!"))
		else
			to_chat(H, span_warning("You have no idea how to use this."))

/obj/item/instrument/proc/is_tuned()
	return tune_time_left > 0

/obj/item/instrument/dropped(mob/user)
	. = ..()
	if((loc != user) && (user.machine == src))
		user.unset_machine()

/obj/item/instrument/interact(mob/user)
	ui_interact(user)

/obj/item/instrument/ui_interact(mob/living/user)
	if(!isliving(user) || user.stat || user.restrained())
		return

	user.set_machine(src)
	song.ui_interact(user)

/obj/item/instrument/violin
	name = "swamp violin"
	desc = "A wooden musical instrument with four strings and a bow. \"The devil went down to space, he was looking for an assistant to grief.\""
	icon_state = "violin"
	inhand_icon_state = "violin"
	force = 24
	force_unwielded = 24
	force_wielded = 30
	weapon_special_component = /datum/component/weapon_special/single_turf
	hitsound = "swing_hit"
	allowed_instrument_ids = "violin"

/obj/item/instrument/violin/upgraded
	name = "the devils toothpicker"
	color = "#FF5555"
	desc = "A violin infused with the hatred of all things 'out of tune.'  Warning: That may include you."
	force = 20
	force_unwielded = 20
	force_wielded = 28

/obj/item/instrument/violin/golden
	name = "golden violin"
	desc = "A golden musical instrument with four strings and a bow. \"The devil went down to Georgia, he was looking for a soul to steal...\""
	force = 24
	force_unwielded = 24
	force_wielded = 30
	weapon_special_component = /datum/component/weapon_special/single_turf
	icon_state = "golden_violin"
	inhand_icon_state = "golden_violin"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/instrument/piano_synth
	name = "synthesizer"
	desc = "An advanced electronic synthesizer that can be used as various instruments."
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf
	icon_state = "synth"
	inhand_icon_state = "synth"
	allowed_instrument_ids = "piano"


/obj/item/instrument/piano_synth/Initialize()
	. = ..()
	song.allowed_instrument_ids = get_allowed_instrument_ids()

/obj/item/instrument/piano_synth/upgraded
	name = "keytar to the soul"
	alpha = 155
	color = "#4444BB"
	desc = "An advanced soul powered synthesizer that can be used as various instruments. Or just screaming. It's good at screaming."
	force = 24
	force_unwielded = 24
	force_wielded = 30

/obj/item/instrument/guitar
	name = "guitar"
	desc = "It's made of wood and has bronze strings."
	icon_state = "guitar"
	inhand_icon_state = "guitar"
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf
	attack_verb = list("played metal on", "serenaded", "crashed", "smashed")
	hitsound = 'sound/weapons/stringsmash.ogg'
	allowed_instrument_ids = "guitar"

/obj/item/instrument/guitar/upgraded
	name = "Donkey Ho-Tay's Bane"
	desc = "It's made of wood and dreams."
	alpha = 200
	color = "#BB9999"
	icon_state = "guitar"
	inhand_icon_state = "guitar"
	force = 24
	force_unwielded = 24
	force_wielded = 30

/obj/item/instrument/eguitar
	name = "electric guitar"
	desc = "Makes all your shredding needs possible."
	icon_state = "eguitar"
	inhand_icon_state = "eguitar"
	force = 12
	attack_verb = list("played metal on", "shredded", "crashed", "smashed")
	hitsound = 'sound/weapons/stringsmash.ogg'
	allowed_instrument_ids = "eguitar"

/obj/item/instrument/glockenspiel
	name = "glockenspiel"
	desc = "Smooth metal bars perfect for any marching band."
	icon_state = "glockenspiel"
	inhand_icon_state = "glockenspiel"
	allowed_instrument_ids = "glockenspiel"
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/instrument/glockenspiel/upgraded
	name = "Mr. Bones Wild Ride"
	desc = "Smooth ghostly blackened bone bars perfect for any marching band of the dead."
	icon_state = "glockenspiel"
	inhand_icon_state = "glockenspiel"
	alpha = 120
	color = "#000000"
	allowed_instrument_ids = "glockenspiel"
	force = 24
	force_unwielded = 24
	force_wielded = 30
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/instrument/accordion
	name = "accordion"
	desc = "Pun-Pun not included."
	icon_state = "accordion"
	inhand_icon_state = "accordion"
	allowed_instrument_ids = "accordion"
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/instrument/accordion/upgraded
	name = "accordion d'love"
	desc = "Spaghetto not included. Why does this smell like marinara though?"
	color = "#883333"
	allowed_instrument_ids = "accordion"
	force = 24
	force_unwielded = 24
	force_wielded = 30
	weapon_special_component = /datum/component/weapon_special/single_turf


/obj/item/instrument/trumpet
	name = "trumpet"
	desc = "To announce the arrival of the king!"
	icon_state = "trumpet"
	inhand_icon_state = "trombone"
	allowed_instrument_ids = "trombone"
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/instrument/trumpet/spectral
	name = "Dooter"
	desc = "Things are about to get spooky!"
	alpha = 200
	color = "#777777"
	force = 24
	force_unwielded = 24
	force_wielded = 30
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
	icon_state = "saxophone"
	inhand_icon_state = "saxophone"
	allowed_instrument_ids = "saxophone"
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/instrument/saxophone/upgraded
	name = "Sweet Lovin'"
	desc = "This soothing sound will be sure to leave your audience under your presidential desk."
	allowed_instrument_ids = "saxophone"
	force = 24
	force_unwielded = 24
	force_wielded = 30

/obj/item/instrument/saxophone/spectral
	name = "spectral saxophone"
	desc = "This spooky sound will be sure to leave mortals in bones."
	icon_state = "saxophone"
	inhand_icon_state = "saxophone"
	force = 0
	attack_verb = list("played","jazzed","saxxed","mourned","dooted","spooked")

/obj/item/instrument/saxophone/spectral/Initialize()
	. = ..()
	AddComponent(/datum/component/spooky)

/obj/item/instrument/saxophone/spectral/attack(mob/living/carbon/C, mob/user)
	playsound(loc, 'sound/runtime/instruments/saxophone/En4.mid', 100,1,-1)
	..()

/obj/item/instrument/trombone
	name = "trombone"
	desc = "How can any pool table ever hope to compete?"
	icon_state = "trombone"
	inhand_icon_state = "trombone"
	allowed_instrument_ids = "trombone"
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/instrument/trombone/spectral
	name = "Trom-Bone"
	desc = "A skeleton's favorite instrument. Apply directly on the mortals."
	alpha = 150
	force = 24
	force_unwielded = 24
	force_wielded = 30
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
	icon_state = "recorder"
	inhand_icon_state = "recorder"
	allowed_instrument_ids = "recorder"

/obj/item/instrument/harmonica
	name = "harmonica"
	desc = "For when you get a bad case of the space blues."
	icon_state = "harmonica"
	inhand_icon_state = "harmonica"
	allowed_instrument_ids = "harmonica"
	slot_flags = INV_SLOTBIT_MASK
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/instrument)

/obj/item/instrument/harmonica/proc/handle_speech(datum/source, datum/rental_mommy/chat/mom)
	if(song.playing && ismob(loc))
		to_chat(loc, span_warning("You stop playing the harmonica to talk..."))
		song.playing = FALSE

/obj/item/instrument/harmonica/equipped(mob/M, slot)
	. = ..()
	RegisterSignal(M, COMSIG_MOB_SAY,PROC_REF(handle_speech))

/obj/item/instrument/harmonica/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/instrument/bikehorn
	name = "gilded bike horn"
	desc = "An exquisitely decorated bike horn, capable of honking in a variety of notes."
	icon_state = "bike_horn"
	inhand_icon_state = "bike_horn"
	lefthand_file = 'icons/mob/inhands/equipment/horns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/horns_righthand.dmi'
	attack_verb = list("beautifully honks")
	allowed_instrument_ids = "bikehorn"
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throw_speed = 3
	throw_range = 15
	hitsound = 'sound/items/bikehorn.ogg'

/obj/item/instrument/banjo
	name = "banjo"
	desc = "A 'Mura' brand banjo. It's pretty much just a drum with a neck and strings."
	icon_state = "banjo"
	inhand_icon_state = "banjo"
	force = 18
	force_unwielded = 18
	force_wielded = 28
	weapon_special_component = /datum/component/weapon_special/single_turf
	attack_verb = list("scruggs-styled", "hum-diggitied", "shin-digged", "clawhammered")
	hitsound = 'sound/weapons/banjoslap.ogg'
	allowed_instrument_ids = "banjo"

/obj/item/instrument/banjo/upgraded
	name = "Finger Licker"
	desc = "A cursed banjo said to lick your ear holes and call you its brother-uncle. Hits pretty hard though."
	icon_state = "banjo"
	inhand_icon_state = "banjo"
	force = 24
	force_unwielded = 24
	force_wielded = 30
	weapon_special_component = /datum/component/weapon_special/single_turf
	attack_verb = list("scruggs-styled", "hum-diggitied", "shin-digged", "clawhammered")
	hitsound = 'sound/weapons/banjoslap.ogg'
	allowed_instrument_ids = "banjo"

/obj/item/musicaltuner
	name = "musical tuner"
	desc = "A device for tuning musical instruments both manual and electronic alike."
	icon = 'icons/obj/device.dmi'
	icon_state = "musicaltuner"
	slot_flags = INV_SLOTBIT_BELT
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'

/obj/item/choice_beacon/music
	name = "instrument delivery beacon"
	desc = "Summon your tool of art."
	icon_state = "gangtool-red"

/obj/item/choice_beacon/music/generate_display_names()
	var/static/list/instruments
	if(!instruments)
		instruments = list()
		var/list/templist = list(/obj/item/instrument/violin,
							/obj/item/instrument/piano_synth,
							/obj/item/instrument/guitar,
							/obj/item/instrument/eguitar,
							/obj/item/instrument/glockenspiel,
							/obj/item/instrument/accordion,
							/obj/item/instrument/trumpet,
							/obj/item/instrument/saxophone,
							/obj/item/instrument/trombone,
							/obj/item/instrument/recorder,
							/obj/item/instrument/harmonica,
							/obj/item/instrument/musicalmoth,
							/obj/structure/piano/fancy
							)
		for(var/V in templist)
			var/atom/A = V
			instruments[initial(A.name)] = A
	return instruments

/obj/item/instrument/musicalmoth
	name = "musical moth"
	desc = "Despite its popularity, this controversial musical toy was eventually banned due to its unethically sampled sounds of moths screaming in agony."
	icon_state = "mothsician"
	allowed_instrument_ids = "mothscream"
	attack_verb = list("fluttered", "flaped")
	w_class = WEIGHT_CLASS_SMALL
	force = 0
	hitsound = 'sound/voice/moth/mothchitter.ogg'

/obj/item/instrument/shamisen
	name = "Shamisen"
	desc = "A japanese shamisen."
	icon_state = "shamisen"
	allowed_instrument_ids = "shamisen"
	w_class = WEIGHT_CLASS_SMALL
	force = 0
	hitsound = 'sound/weapons/stringsmash.ogg'


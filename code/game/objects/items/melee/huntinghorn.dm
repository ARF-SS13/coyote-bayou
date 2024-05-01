#define HH_WIELD_TIME (3 SECONDS)
#define HH_PERFORMANCE_RANGE 8 //tiles
#define LOW_NOTE 1
#define MID_NOTE 2
#define HIGH_NOTE 3

/obj/item/huntinghorn
	name = "hunting horn"
	icon_state = "guitar"
	icon = 'icons/obj/musician.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/instruments_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/instruments_righthand.dmi'

	desc = "An instrument designed for entertainment, combat, and combat entertainment. You could examine it closer (by examining it twice quickly) to get an idea of its capabilities."

	slot_flags = INV_SLOTBIT_BACK | INV_SLOTBIT_SUITSTORE
	w_class = WEIGHT_CLASS_BULKY

	//weapon stats
	force = 20
	throwforce = 20
	force_unwielded = 20
	force_wielded = 40
	attack_speed = 1 SECONDS
	attack_unwieldlyness = 5
	sharpness = SHARP_NONE
	weapon_special_component = /datum/component/weapon_special/single_turf

	// should we start tracking notes and songs? set to TRUE after a delay when wielding
	var/readytoplay = FALSE
	// the notes we've recently played
	var/list/notes = list()
	// the note we'll add if we attack right now
	var/currentnote = LOW_NOTE
	// all the songs this horn can play
	var/list/datum/huntinghornsong/songlist = newlist(/datum/huntinghornsong,)
	// the songs we've recently prepared
	var/list/datum/huntinghornsong/currentsongs = list()
	// the datum that lets us play the horn like an instrument
	var/datum/song/huntinghorn/instrument
	// the type(s) of instrument that the song datum plays
	var/instrument_types = list("banjo", "eguitar", "guitar", "shamisen")

/obj/item/huntinghorn/Initialize()
	..()
	instrument = new(src, instrument_types)

/obj/item/huntinghorn/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=20, force_wielded=40, require_twohands=TRUE)

/obj/item/huntinghorn/Destroy()
	. = ..()

/obj/item/huntinghorn/examine_more()
	// damage info
	. = list(span_notice("This thing does [force_unwielded] damage, and [force_wielded] in two hands. You can swing it about [1 SECONDS / attack_speed] times a second."))
	// list songs
	. += span_notice("It could play...")
	for(var/datum/huntinghornsong/song in songlist)
		. += span_notice("A [song.name], which [song.effect_desc]. Notes: [song.notes_to_string()]")

	// explain mechanics
	. += span_notice("Use in-hand to play like an instrument. Wield it while in combat mode and harm intent to get ready for a real show.")
	. += span_notice("Then if you use it in-hand you can choose a note to play or start a performance!")
	. += span_notice("To get a song ready, play its notes in order. Your chosen note will play when you attack.")
	. += span_notice("Once at least one song is ready, all you need to do is perform! You'll have to stand still while performing.")


/// If we're in combat mode, we can set the note we're playing. Or we can perform!
/obj/item/huntinghorn/attack_self(mob/user)
	if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		// yeah, show_radial_menu calls look messy. I know.
		var/choice = show_radial_menu(
			user,
			src,
			list(
				"low" = image(icon = 'icons/misc/mark.dmi', icon_state = "b1"),
				"medium" = image(icon = 'icons/misc/mark.dmi', icon_state = "b2"),
				"high" = image(icon = 'icons/misc/mark.dmi', icon_state = "b3"),
				"performance" = image(icon = 'icons/misc/mark.dmi', icon_state = "X"),
			),
			"huntinghornradial",
			CALLBACK(src, PROC_REF(radial_check), user),
			radius = 42,
			require_near = TRUE,
			tooltips = TRUE,
		)
		switch(choice)
			if("low")
				set_note(user, LOW_NOTE)
				return
			if("medium")
				set_note(user, MID_NOTE)
				return
			if("high")
				set_note(user, HIGH_NOTE)
				return
			else
				perform(user)
				return
	// howre you gonna play a song if youre dead huh
	if(!isliving(user) || user.stat || user.restrained())
		return
	// if we're not in combat i guess we're just trying to play music.
	user.set_machine(src)
	instrument.ui_interact(user)

/// When are we allowed to use the radial menu?
/obj/item/huntinghorn/proc/radial_check(mob/user)
	if(!isliving(user) || user.stat || user.restrained())
		return FALSE
	if(QDELETED(src) || user.is_holding(src))
		return FALSE

/// It's just easier to separate this out.
/obj/item/huntinghorn/proc/set_note(mob/user, to_set)
	currentnote = to_set
	if(currentnote > HIGH_NOTE)
		currentnote = LOW_NOTE
	switch(currentnote)
		if(LOW_NOTE)
			to_chat(user, span_info("You prepare a low note."))
			return
		if(MID_NOTE)
			to_chat(user, span_info("You prepare a middle note."))
			return
		if(HIGH_NOTE)
			to_chat(user, span_info("You prepare a high note."))
			return

/// When we wield a HH, wait for a delay before starting to record notes.
/obj/item/huntinghorn/pickup(mob/user)
	. = ..()
	var/delay = HH_WIELD_TIME
	if(HAS_TRAIT(user, TRAIT_HH_DRAW_SPEED))
		delay *= 0.1
	spawn(delay)
		if(user.get_active_held_item() == src)
			set_ready_to_play(user, TRUE)

/// Stop recording notes when we're not wielding the HH anymore.
/obj/item/huntinghorn/dropped(mob/user)
	. = ..()
	set_ready_to_play(user, FALSE)

/// Handles the actual setting of readytoplay
/obj/item/huntinghorn/proc/set_ready_to_play(mob/user, set_to)
	if(readytoplay == set_to)
		return
	readytoplay = set_to
	if(readytoplay)
		to_chat(user, span_info("You're ready to perform!"))
	else
		to_chat(user, span_info("You relax, finished with your performance for now."))
	currentsongs.Cut()
	notes.Cut()

/obj/item/huntinghorn/pre_attack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	// only if we're ready to play a note
	if(!readytoplay || !CheckAttackCooldown(user, target))
		return
	// and in harm intent
	if(user.a_intent != INTENT_HARM)
		return
	// play a note!
	notes.Add(currentnote)
	play_audio(user)
	// make sure we're only tracking 3 at a time
	if(length(notes) > 3)
		notes.Cut(1,length(notes)-2)
	// does this mean we prepared a song now?
	for(var/datum/huntinghornsong/song in songlist)
		if(song.check_notes(notes))
			add_song_effect(user, song)

	// make sure we go on cooldown.
	ApplyAttackCooldown(user, target, null)

/// actually plays a note. like in your ears.
/obj/item/huntinghorn/proc/play_audio(mob/user)
	//instrument.playkey_legacy(rand(1,7), pick("b", "n"), currentnote + 3)
	var/chord = list(list(pick(1, 2, 3, 4, 5, 6), pick("b", "n", "#"), (currentnote + 3)), 0.5)
	instrument.play_chord(chord)



	// SONG HANDLING //

/// we've prepped a song! let's keep track of that.
/obj/item/huntinghorn/proc/add_song_effect(mob/user, datum/huntinghornsong/song)
	if(currentsongs.Find(song))
		return
	currentsongs += song
	to_chat(user, span_info("You've prepared the [capitalize(song.name)]!"))

/// it's time for the show!
/obj/item/huntinghorn/proc/perform(mob/user)
	// or maybe not?
	if(!currentsongs.len)
		to_chat(user, "You haven't prepared any songs!")
		return
	// Okay, let's get started.
	if(do_after(user, 4 SECONDS, needhand = FALSE, target = src, public_progbar = TRUE))
		// We did it! let's apply all the effects now.
		for(var/datum/huntinghornsong/song in currentsongs)
			to_chat(user, span_info("You play the [capitalize(song.name)]!"))
			// and play the audio.
			var/sound/performsound = sound('sound/huntinghorn/guitarrifshort.wav')
			performsound.volume = 50
			for(var/mob/living/L in range(HH_PERFORMANCE_RANGE, user))
				if(L.client)
					L.apply_status_effect(song.effect)
					if(L.client.prefs.toggles & SOUND_HUNTINGHORN)
						L << performsound
		// it begins anew.
		currentsongs = list()
		notes = list()



	/// HUNTING HORN SUBTYPES ///
	
// for aggressive melee combat.
/obj/item/huntinghorn/offense
	name = "hunting horn - offense"
	songlist = newlist(/datum/huntinghornsong/attack_up_xs, /datum/huntinghornsong/speed_up, /datum/huntinghornsong/cooldown_ignore)
	color = rgb(161, 0, 0)
	
// for toughening up your party.
/obj/item/huntinghorn/defense
	name = "hunting horn - defense"
	songlist = newlist(/datum/huntinghornsong/iron_skin, /datum/huntinghornsong/knockdown_res, /datum/huntinghornsong/divine_blessing)
	color = rgb(0, 17, 252)

// for getting silly with it.
/obj/item/huntinghorn/utility
	name = "hunting horn - utility"
	songlist = newlist(/datum/huntinghornsong/draw_speed, /datum/huntinghornsong/fast_actions, /datum/huntinghornsong/stamina_up)
	color = rgb(224, 209, 0)

// for keeping everyone in the fight.
/obj/item/huntinghorn/healing
	name = "hunting horn - healing"
	songlist = newlist(/datum/huntinghornsong/instaheal, /datum/huntinghornsong/recovery, /datum/huntinghornsong/maxhp_up)
	color = rgb(0, 145, 0)



/// THE ACTUAL INSTRUMENT DATUM ///

/datum/song/huntinghorn
	name = "song"
	var/musician = FALSE
	allowed_instrument_ids = list("banjo", "eguitar", "guitar", "shamisen")

/datum/song/huntinghorn/start_playing(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_MUSICIAN))
		musician = TRUE
	else
		musician = FALSE

/datum/song/huntinghorn/should_stop_playing(mob/user)
	. = ..()
	var/obj/item/huntinghorn/horn = parent
	if(!isliving(user) || user.stat || user.restrained())
		return TRUE
	if(QDELETED(horn) || !user.is_holding(horn))
		return TRUE
	return FALSE

/datum/song/huntinghorn/process(mob/user)
	. = ..()
	if(musician)
		for (var/mob/living/M in hearing_mobs)
			M.dizziness = max(0,M.dizziness-2)
			M.jitteriness = max(0,M.jitteriness-2)
			M.confused = max(M.confused-1)
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "goodmusic", /datum/mood_event/goodmusic)
			if(ishuman(M))
				var/mob/living/carbon/human/lstnr = M
				var/datum/reagents/R = lstnr.reagents
				var/list/payload = list(
					"songer" = user.real_name,
					"kind" = name,
				)
				R.add_reagent(/datum/reagent/medicine/music, 1, payload)


/// SONG DATUMS ///

/// this thing stores the required notes as well as the status to apply when played.
/datum/huntinghornsong
	var/name = "indescribable song"
	var/list/required_notes = list(LOW_NOTE, LOW_NOTE, LOW_NOTE)
	var/datum/status_effect/music/effect = /datum/status_effect/music
	var/effect_desc = "has a strange and nebulous effect"

/datum/huntinghornsong/proc/check_notes(list/notes)
	if(notes ~= required_notes)
		return TRUE
	return FALSE

/datum/huntinghornsong/proc/notes_to_string()
	. = note_to_string(required_notes[1])
	. += ", [note_to_string(required_notes[2])]"
	. += ", [note_to_string(required_notes[3])]"


/datum/huntinghornsong/proc/note_to_string(note)
	switch(note)
		if(LOW_NOTE)
			return "low"
		if(MID_NOTE)
			return "mid"
		if(HIGH_NOTE)
			return "high"
		else
			return "what?"


	// OFFENSE //

/datum/huntinghornsong/attack_up_xs
	name = "song of strength"
	required_notes = list(MID_NOTE, MID_NOTE, MID_NOTE)
	effect = /datum/status_effect/music/attack_up_xs
	effect_desc = "empowers melee attacks"

/datum/huntinghornsong/speed_up
	name = "song of agility"
	required_notes = list(HIGH_NOTE, MID_NOTE, LOW_NOTE)
	effect = /datum/status_effect/music/speed_up
	effect_desc = "encourages quickness"

/datum/huntinghornsong/cooldown_ignore
	name = "song of ruthlessness"
	required_notes = list(LOW_NOTE, LOW_NOTE, LOW_NOTE)
	effect = /datum/status_effect/music/cooldown_ignore
	effect_desc = "sometimes allows for quick successive melee attacks"

	// DEFENSE //

/datum/huntinghornsong/iron_skin
	name = "song of endurance"
	required_notes = list(MID_NOTE, LOW_NOTE, MID_NOTE)
	effect = /datum/status_effect/music/iron_skin
	effect_desc = "strengthens resistances"

/datum/huntinghornsong/knockdown_res
	name = "song of steadiness"
	required_notes = list(LOW_NOTE, MID_NOTE, LOW_NOTE)
	effect = /datum/status_effect/music/knockdown_res
	effect_desc = "sometimes prevents you from getting knocked on your butt"

/datum/huntinghornsong/divine_blessing
	name = "song of luck"
	required_notes = list(HIGH_NOTE, MID_NOTE, LOW_NOTE)
	effect = /datum/status_effect/music/divine_blessing
	effect_desc = "sometimes lets you shrug off some of the pain from being hit"

	// UTILITY //

/datum/huntinghornsong/draw_speed
	name = "song of alertness"
	required_notes = list(MID_NOTE, MID_NOTE, HIGH_NOTE)
	effect = /datum/status_effect/music/draw_speed
	effect_desc = "encourages deftness when drawing weapons"

/datum/huntinghornsong/fast_actions
	name = "song of dexterity"
	required_notes = list(LOW_NOTE, MID_NOTE, HIGH_NOTE)
	effect = /datum/status_effect/music/fast_actions
	effect_desc = "enhances quickness when performing tedious tasks"

/datum/huntinghornsong/stamina_up
	name = "song of persistence"
	required_notes = list(HIGH_NOTE, MID_NOTE, HIGH_NOTE)
	effect = /datum/status_effect/music/stamina_up
	effect_desc = "boosts stamina"


	// HEALING //

/datum/huntinghornsong/instaheal
	name = "song of health"
	required_notes = list(HIGH_NOTE, HIGH_NOTE, HIGH_NOTE)
	effect = /datum/status_effect/music/instaheal
	effect_desc = "gives an instant kick to natural healing"

/datum/huntinghornsong/recovery
	name = "song of recovery"
	required_notes = list(LOW_NOTE, MID_NOTE, HIGH_NOTE)
	effect = /datum/status_effect/music/recovery
	effect_desc = "encourages the body's healing over time"

/datum/huntinghornsong/maxhp_up
	name = "song of vigor"
	required_notes = list(LOW_NOTE, LOW_NOTE, LOW_NOTE)
	effect = /datum/status_effect/music/maxhp_up
	effect_desc = "increases maximum pain tolerance for a time"

#undef HH_WIELD_TIME
#undef HH_PERFORMANCE_RANGE
#undef LOW_NOTE
#undef MID_NOTE
#undef HIGH_NOTE

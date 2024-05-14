	// Author Gremling
// by request of the overlord FennyKong, I have granted his wish by designing a method to allow users to have a sound play when typing, or finished typing.
#define NO_SOUND				1
#define PLAY_STARTING			2
//#define PLAY_TYPING			3
#define PLAY_FINISHED			3
#define PLAY_ANIMALCROSSING_TI	4	// Animal crossing like typing indicator

GLOBAL_LIST_INIT(play_methods, list("No Sound",
									"Play sound when you begin typing",
//									"Loop sound while you type",
									"Play sound after you type",
									"Play Animal Crossing-like sound after you type"))

GLOBAL_LIST_INIT(typing_indicator_speeds, list(
									"Speed: Faster (4)" = 0,
									"Speed: Fast (3)" = 1,
									"Speed: Average (2)" = 2,
									"Speed: Slow (1)" = 3))

GLOBAL_LIST_INIT(typing_indicator_pitches, list(			//these are simply frequencies
									"Pitch: Annoyingly high (4)" = 67000,
									"Pitch: High (3)" = 55000,
									"Pitch: Average (2)" = 43000,
									"Pitch: Deep (1)" = 28000))

GLOBAL_LIST_INIT(typing_indicator_variances, list(
									"Tone: Varies a lot (4)" = 30000,
									"Tone: Varies normally (3)" = 18000,
									"Tone: Varies a little (2)" = 9000,
									"Tone: Does not vary (1)" = 0))

GLOBAL_LIST_INIT(typing_indicator_volumes, list(
									"Volume: Loud (3)" = 15,
									"Volume: Average (2)" = 10,
									"Volume: Quiet and polite (1)" = 5))

GLOBAL_LIST_INIT(typing_indicator_max_words_spoken_list, list(
									"Max words spoken: 8" = 8,
									"Max words spoken: 7" = 7,
									"Max words spoken: 6" = 6,
									"Max words spoken: 5" = 5,
									"Max words spoken: 4" = 4,
									"Max words spoken: 3" = 3,
									"Max words spoken: 2" = 2,
									"Max words spoken: 1" = 1))

//lmfao at lizard ~TK420634

/* // Old and laggy, commenting out to discourage usage - Gremling
/datum/looping_sound/typing_indicator
	mid_sounds = list('modular_coyote/sound/typing/default.ogg')
	mid_length = 30
	volume = 10

/datum/looping_sound/typing_indicator/start(atom/add_thing)
	output_atoms = get_hearers_in_view(7,usr)
	output_atoms -= usr

	return ..()
*/

/datum/preferences
	var/list/features_speech = list("typing_indicator_sound" = "Default", "typing_indicator_sound_play" = "No Sound")

/* // Disabled for now - It's been a year and it's still gone >:)
/mob
	var/datum/looping_sound/typing_indicator/typing_sound

/mob/Initialize()
	typing_sound = new(list(src), FALSE)
	return ..()

/mob/Destroy()
	QDEL_NULL(typing_sound)
	return ..()
*/


// ============--- GETTERS ---============

/mob/proc/get_typing_indicator_sound(statick)
	if(client)
		var/client/C = client
		var/datum/typing_sound/soundDatum = GLOB.typing_sounds[C.prefs.features["typing_indicator_sound"]]
		if(soundDatum)
			return soundDatum.GetSound(statick)
	return GLOB.typing_sounds["Default"]

/mob/proc/get_typing_indicator_sound_name()
	if(client)
		var/client/C = client
		return C.prefs.features["typing_indicator_sound"]
	return "Default"

/mob/proc/get_typing_indicator_pref()
	if(client)
		var/client/C = client
		return C.prefs.features["typing_indicator_sound_play"]
	return NO_SOUND

/mob/proc/get_typing_indicator_speed()
	if(client)
		var/client/C = client
		return GLOB.typing_indicator_speeds[C.prefs.features["typing_indicator_speed"]]
	return 2

/mob/proc/get_typing_indicator_pitch()
	if(client)
		var/client/C = client
		return GLOB.typing_indicator_pitches[C.prefs.features["typing_indicator_pitch"]]
	return 2

/mob/proc/get_typing_indicator_variance()
	if(client)
		var/client/C = client
		return GLOB.typing_indicator_variances[C.prefs.features["typing_indicator_variance"]]
	return 2

/mob/proc/get_typing_indicator_volume(statick)
	if(client)
		var/client/C = client
		if(statick)
			return GLOB.typing_indicator_volumes[C.prefs.features["typing_indicator_volume"]] * 2
		return GLOB.typing_indicator_volumes[C.prefs.features["typing_indicator_volume"]]
	return 2

/mob/proc/get_typing_indicator_max_words_spoken()
	if(client)
		var/client/C = client
		return GLOB.typing_indicator_max_words_spoken_list[C.prefs.features["typing_indicator_max_words_spoken"]]
	return 4



// ============--- CODERS ---============

/mob/display_typing_indicator(timeout_override = TYPING_INDICATOR_TIMEOUT, state_override = generate_typing_indicator(), force = FALSE)
	if(((!typing_indicator_enabled || (stat != CONSCIOUS)) && !force) || typing_indicator_current)
		return

	if(get_typing_indicator_pref() == GLOB.play_methods[PLAY_STARTING])
		play_AC_typing_indicator()

// Disabling this unfortunately for now as I think this is causing too much perf hit on things.
/*	if(get_typing_indicator_pref() == GLOB.play_methods[PLAY_TYPING])
		if(typing_sound)
			typing_sound.mid_sounds = list(GLOB.typing_indicator_sounds[client.prefs.features["typing_indicator_sound"]])
			typing_sound.start()
*/

	return ..()


/mob/clear_typing_indicator()
//	if(typing_sound)
//		typing_sound.stop()
	
	if(stat != CONSCIOUS)
		return ..()
	
	if(get_typing_indicator_pref() == GLOB.play_methods[PLAY_FINISHED])
		play_AC_typing_indicator()

	return ..()

/mob/proc/play_AC_typing_indicator(txt, atom/playfrom, mob/whoprefs, do_static)		//Animal Crossing typing indicator macro. It takes a text, it butchers it and converts the words used in audible sounds.
	if(stat > SOFT_CRIT)
		return
	if(!playfrom)
		playfrom = src
	if(!whoprefs)
		whoprefs = src

	var/prefdo = get_typing_indicator_pref()

	if(!prefdo || prefdo == GLOB.play_methods[NO_SOUND])	//If the preference is set to "No Sound", don't play anything
		return

	if(!txt && prefdo == GLOB.play_methods[PLAY_ANIMALCROSSING_TI])//If the message is empty, play nothing
		return
	
	// if(whoprefs != src && !CHECK_PREFS(whoprefs, RADIOPREF_HEAR_RADIO_BLURBLES)) // chances are you approve of the settings you set yourself
	// 	return
	
	if(prefdo != GLOB.play_methods[PLAY_ANIMALCROSSING_TI])
		playsound(playfrom, get_typing_indicator_sound(do_static), get_typing_indicator_volume(do_static), FALSE)
		return

	var/datum/typing_sound/TS = GLOB.typing_sounds[get_typing_indicator_sound_name()]
	
	var/list/word_count = splittext(txt," ")
	var/counter = word_count.len

	if(counter > get_typing_indicator_max_words_spoken())		//If the message length is made out of [NUMBER] characters or more, set it as maximum length (so it won't play for ever an annoying sound)
		counter = get_typing_indicator_max_words_spoken()		

	if(get_typing_indicator_pref() == GLOB.play_methods[PLAY_ANIMALCROSSING_TI])		//we are checking if they actually have this preference turned on 
		var/TI_frequency
		if (!isnum(counter))                                                            //something went wrong with the counter and it needs to be fixed. Quick, do SOMETHING!
			counter = 4
		if(!TS || !TS.permitAnimalCrossing)
			counter = 1
		if(do_static)
			counter++ // one last on the endge
		var/timecounter = 0
		var/static_pause = do_static
		for(var/i in 1 to counter)
			timecounter += (rand(get_typing_indicator_speed(), get_typing_indicator_speed() + 2))		// adding an extra +2 to add a little spice to the voice, hehe yea boiii
			if(static_pause)
				timecounter += 3
				static_pause = FALSE
				// if(do_static && i == counter)
				// 	spawn(timecounter * 2)
				// 		playsound(src, 'sound/effects/counter_terrorists_win.ogg', 20, FALSE, SOUND_DISTANCE(2), ignore_walls = TRUE)
				// else
			spawn(timecounter)
				TI_frequency = rand(get_typing_indicator_pitch() - get_typing_indicator_variance(),  get_typing_indicator_pitch() + get_typing_indicator_variance())
				playsound(playfrom, get_typing_indicator_sound(do_static), get_typing_indicator_volume(do_static), FALSE, null, SOUND_FALLOFF_EXPONENT, TI_frequency)

// Moved this to preferences_savefile.dm as we're having issues with overriding the function I think.
// My speculation is that us trying to open the save file multiple times with multiple users is causing a memory overflow on the server end and refusing to open it
// Though surely it would alteast warn us?? IDK. There's no way to debug this live. That's atleast what I think is happening, as it's strange that it works locally, but not server side.

/*
/datum/preferences/load_character(slot)
	. = ..()
	if(!(. == 1))
		return . // There's an error!!

	var/savefile/S = new /savefile(path)
	S.cd = "/character[slot]"

	S["typing_indicator_sound"]			>> features_speech["typing_indicator_sound"]
	S["typing_indicator_sound_play"]	>> features_speech["typing_indicator_sound_play"]

	features_speech["typing_indicator_sound"]				= sanitize_inlist(features_speech["typing_indicator_sound"], GLOB.typing_indicator_sounds, "Default")
	features_speech["typing_indicator_sound_play"]			= sanitize_inlist(features_speech["typing_indicator_sound_play"], GLOB.play_methods, "No Sound")

	return 1


/datum/preferences/save_character()
	. = ..()

	if(!(. == TRUE))
		return . // erroooooooooooorrrrrrrrrrr

	var/savefile/S = new /savefile(path)
	if(!S)
		return 0

	S.cd = "/character[default_slot]"

	//Character
	WRITE_FILE(S["typing_indicator_sound"]				, features_speech["typing_indicator_sound"])
	WRITE_FILE(S["typing_indicator_sound_play"]			, features_speech["typing_indicator_sound_play"])

	return 1
*/

/datum/preferences/process_link(mob/user, list/href_list)
	switch(href_list["task"])
		if("input")
			switch(href_list["preference"])
				if("typing_indicator_sound")
					var/new_sound = input(user, "Choose your typing sound:", "Character Pogerenfe") as null|anything in GLOB.typing_sounds
					if(new_sound)
						features_speech["typing_indicator_sound"] = new_sound

				if("typing_indicator_sound_play")
					var/new_input = input(user, "Choose your typing sound behaviour", "You stink c:") as null|anything in GLOB.play_methods
					if(new_input)
						features_speech["typing_indicator_sound_play"] = new_input
				
				if("typing_indicator_speed")
					var/new_input
					new_input = input(user, "Choose your typing sound speed:", "Sound Indicator") as null|anything in GLOB.typing_indicator_speeds
					if(new_input)
						features_speech["typing_indicator_speed"] = new_input

				if("typing_indicator_pitch")
					var/new_input = input(user, "Choose your typing sound pitch:", "Sound Indicator") as null|anything in GLOB.typing_indicator_pitches
					if(new_input)
						features_speech["typing_indicator_pitch"] = new_input

				if("typing_indicator_variance")
					var/new_input
					new_input = input(user, "Choose your typing sound variance:", "Sound Indicator") as null|anything in GLOB.typing_indicator_variances
					if(new_input)
						features_speech["typing_indicator_variance"] = new_input
	
				if("typing_indicator_volume")
					var/new_input
					new_input = input(user, "Choose your typing sound volume:", "Sound Indicator") as null|anything in GLOB.typing_indicator_volumes
					if(new_input)
						features_speech["typing_indicator_volume"] = new_input

				if("typing_indicator_max_words_spoken")
					var/new_input
					new_input = input(user, "Choose your maximum number of audible words: (Only animal crossing speech uses this)", "Sound Indicator") as null|anything in GLOB.typing_indicator_max_words_spoken_list
					if(new_input)
						features_speech["typing_indicator_max_words_spoken"] = new_input
	..()

/datum/preferences/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, initial_spawn = FALSE, sans_underpants = FALSE)
	features += features_speech
	..()

/datum/map_template/shelter/debug_telecomms
	shelter_id = "debug_telecomms"
	description	= "A debug telecomms room for testing purposes."
	mappath = "_maps/templates/telecomms.dmm"


/datum/map_template/shelter/debug_telecomms/New()
	. = ..()
	blacklisted_turfs = list()
	whitelisted_turfs = list()
	banned_areas = list()
	banned_objects = list()

/obj/item/survivalcapsule/debug_telecomms
	name = "Pocket telecomms"
	template_id = "debug_telecomms"
	nuke = TRUE


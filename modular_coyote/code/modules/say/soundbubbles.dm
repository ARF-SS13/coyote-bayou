	// Author Gremling
// by request of the overlord FennyKong, I have granted his wish by designing a method to allow users to have a sound play when typing, or finished typing.
#define NO_SOUND				1
#define PLAY_STARTING			2
//#define PLAY_TYPING			3
#define PLAY_FINISHED			3
#define PLAY_ANIMALCROSSING_TI	4	// Animal crossing like typing indicator

#define MAX_ITERATIONS_TI		24	// maximum number of character allowed to be vocal, keep it around this number so... it doesn't become a pain for anyone else to listen to. Love -Gin

GLOBAL_LIST_INIT(play_methods, list("No Sound",
									"Play sound when you begin typing",
//									"Loop sound while you type",
									"Play sound after you type",
									"Play Animal Crossing-like sound after you type"))

GLOBAL_LIST_INIT(typing_indicator_speeds, list(
									"4-Faster" = 0,
									"3-Fast" = 1,
									"2-Average" = 2,
									"1-Slow" = 3))

GLOBAL_LIST_INIT(typing_indicator_pitches, list(			//these are simply frequencies
									"4-Annoyingly high" = 67000,
									"3-High" = 55000,
									"2-Average" = 43000,
									"1-Deep" = 28000))

GLOBAL_LIST_INIT(typing_indicator_variances, list(
									"4-Voice varies a lot between words" = 30000,
									"3-Voice varies between words" = 18000,
									"2-Voice varies a little between words" = 9000,
									"1-Voice does not vary between words" = 0))

GLOBAL_LIST_INIT(typing_indicator_volumes, list(
									"3-Loud" = 20,
									"2-Average" = 15,
									"1-Quiet and polite" = 10))

GLOBAL_LIST_INIT(typing_indicator_sounds, list(
		"Default"	= 'modular_coyote/sound/typing/default.ogg',
		"FB Messenger"	= 'modular_coyote/sound/typing/facebookMessenger.ogg',
		"Deep"	= 'modular_coyote/sound/typing/deepspeak.ogg',
		"Soft"	= 'modular_coyote/sound/typing/softspeak.ogg',
		"Light"	= 'modular_coyote/sound/typing/lightspeak.ogg',
		"Jackal" = 'modular_coyote/sound/typing/arfs1sounds/anubis1.ogg',
		"Bat Chitter" = 'modular_coyote/sound/typing/arfs1sounds/bat1.ogg',
		"Bear" = 'modular_coyote/sound/typing/arfs1sounds/bear1.ogg',
		"Beaver" = 'modular_coyote/sound/typing/arfs1sounds/beaver1.ogg',
		"Jackal" = 'modular_coyote/sound/typing/arfs1sounds/anubis1.ogg',
		"Horrible Bird Kyaa" = 'modular_coyote/sound/typing/arfs1sounds/bird1.ogg',
		"Horrible Bird Call 2" = 'modular_coyote/sound/typing/arfs1sounds/bird2.ogg',
		"Boar" = 'modular_coyote/sound/typing/arfs1sounds/boar1.ogg',
		"Goat" = 'modular_coyote/sound/typing/arfs1sounds/capra1.ogg',
		"Corgi (Cody)" = 'modular_coyote/sound/typing/arfs1sounds/corgi1.ogg',
		"Corgi" = 'modular_coyote/sound/typing/arfs1sounds/corgi2.ogg',
		"Cougar" = 'modular_coyote/sound/typing/arfs1sounds/cougar1.ogg',
		"Cow" = 'modular_coyote/sound/typing/arfs1sounds/cow1.ogg',
		"Coyote Howl" = 'modular_coyote/sound/typing/arfs1sounds/coyote1.ogg',
		"Coyote" = 'modular_coyote/sound/typing/arfs1sounds/coyote2.ogg',
		"Crocodile" = 'modular_coyote/sound/typing/arfs1sounds/croc1.ogg',
		"Deer" = 'modular_coyote/sound/typing/arfs1sounds/deer1.ogg',
		"Drider" = 'modular_coyote/sound/typing/arfs1sounds/drider1.ogg',
		"Eevee" = 'modular_coyote/sound/typing/arfs1sounds/eevee1.ogg',
		"Elephant" = 'modular_coyote/sound/typing/arfs1sounds/elephant1.ogg',
		"Fennec Bark" = 'modular_coyote/sound/typing/arfs1sounds/fennec1.ogg',
		"Fennec Squeak" = 'modular_coyote/sound/typing/arfs1sounds/fennec2.ogg',
		"Fox Bark" = 'modular_coyote/sound/typing/arfs1sounds/fox1.ogg',
		"Husky Bark-bark" = 'modular_coyote/sound/typing/arfs1sounds/husky1.ogg',
		"Husky Howl" = 'modular_coyote/sound/typing/arfs1sounds/husky2.ogg',
		"Hyena Laugh" = 'modular_coyote/sound/typing/arfs1sounds/hyena1.ogg',
		"Lizard?" = 'modular_coyote/sound/typing/arfs1sounds/lizard1.ogg',
		"Lynx Growl" = 'modular_coyote/sound/typing/arfs1sounds/lynx1.ogg',
		"Orca" = 'modular_coyote/sound/typing/arfs1sounds/orca1.ogg',
		"Panda" = 'modular_coyote/sound/typing/arfs1sounds/panda1.ogg',
		"Pig Grunt" = 'modular_coyote/sound/typing/arfs1sounds/pig1.ogg',
		"Porcupine" = 'modular_coyote/sound/typing/arfs1sounds/porcupine1.ogg',
		"Possum Hiss" = 'modular_coyote/sound/typing/arfs1sounds/possum1.ogg',
		"Miserable Bark" = 'modular_coyote/sound/typing/arfs1sounds/pug1.ogg',
		"Rabbit Squeal" = 'modular_coyote/sound/typing/arfs1sounds/rabbit1.ogg',
		"Raccoon Chitter" = 'modular_coyote/sound/typing/arfs1sounds/raccoon1.ogg',
		"Red Panda Chitter" = 'modular_coyote/sound/typing/arfs1sounds/redpanda1.ogg',
		"Dial Up" = 'modular_coyote/sound/typing/arfs1sounds/robot1.ogg',
		"Yappy Dog" = 'modular_coyote/sound/typing/arfs1sounds/shihtzu1.ogg',
		"Cat Mrowl" = 'modular_coyote/sound/typing/arfs1sounds/siamese1.ogg',
		"Cat Meow" = 'modular_coyote/sound/typing/catmeow.ogg',
		"Cat Trill" = 'modular_coyote/sound/typing/cattrill.ogg',
		"Skunk Chitter" = 'modular_coyote/sound/typing/arfs1sounds/skunk1.ogg',
		"Big Cat Chuff" = 'modular_coyote/sound/typing/arfs1sounds/tiger1.ogg',
		"Vulture" = 'modular_coyote/sound/typing/arfs1sounds/vulture1.ogg',
		"Wolf Howl" = 'modular_coyote/sound/typing/arfs1sounds/wolf1.ogg'
				))

//lmfao at lizard ~TK420634

/datum/looping_sound/typing_indicator
	mid_sounds = list('modular_coyote/sound/typing/default.ogg')
	mid_length = 30
	volume = 10

/datum/looping_sound/typing_indicator/start(atom/add_thing)
	output_atoms = get_hearers_in_view(7,usr)
	output_atoms -= usr

	return ..()


/datum/preferences
	var/list/features_speech = list("typing_indicator_sound" = 'modular_coyote/sound/typing/default.ogg', "typing_indicator_sound_play" = "No Sound")
/* // Disabled for now
/mob
	var/datum/looping_sound/typing_indicator/typing_sound

/mob/Initialize()
	typing_sound = new(list(src), FALSE)
	return ..()

/mob/Destroy()
	QDEL_NULL(typing_sound)
	return ..()
*/
/mob/proc/get_typing_indicator_sound()
	if(client)
		var/client/C = client
		return GLOB.typing_indicator_sounds[C.prefs.features["typing_indicator_sound"]]
	return 'modular_coyote/sound/typing/default.ogg'

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

/mob/proc/get_typing_indicator_volume()
	if(client)
		var/client/C = client
		return GLOB.typing_indicator_volumes[C.prefs.features["typing_indicator_volume"]]
	return 2

/mob/display_typing_indicator(timeout_override = TYPING_INDICATOR_TIMEOUT, state_override = generate_typing_indicator(), force = FALSE)
	if(((!typing_indicator_enabled || (stat != CONSCIOUS)) && !force) || typing_indicator_current)
		return

	if(get_typing_indicator_pref() == GLOB.play_methods[PLAY_STARTING])
		playsound(get_turf(src), get_typing_indicator_sound(), 15, FALSE)

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
		playsound(get_turf(src), get_typing_indicator_sound(), 15, FALSE)

	return ..()

/mob/proc/play_AC_typing_indicator(message_length)		//Animal Crossing typing indicator macro
	if(stat != CONSCIOUS)
		return

	if(!message_length)			//If the message is empty, play nothing
		return

	if(message_length > MAX_ITERATIONS_TI)		//If the message length is made out of [NUMBER] characters or more, set it as maximum length (so it won't play for ever an annoying sound)
		message_length = MAX_ITERATIONS_TI		

	if(get_typing_indicator_pref() == GLOB.play_methods[PLAY_ANIMALCROSSING_TI])		//we are checking if they actually have this preference turned on 
		var/TI_frequency
		for(var/i in 1 to (round(message_length/4 + 1)))		//Adding one in case the massage is a simple "hi!", so it will play at least one iteration
			TI_frequency = rand(get_typing_indicator_pitch() - get_typing_indicator_variance(),  get_typing_indicator_pitch() + get_typing_indicator_variance())
			playsound(get_turf(src), get_typing_indicator_sound(), get_typing_indicator_volume(), FALSE, null, SOUND_FALLOFF_EXPONENT, TI_frequency)
			sleep(rand(get_typing_indicator_speed(), get_typing_indicator_speed() + 2))		// adding an extra +2 to add a little spice to the voice, hehe yea boiii

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
					var/new_sound
					new_sound = input(user, "Choose your typing sound:", "Character Pogerenfe") as null|anything in GLOB.typing_indicator_sounds
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
	..()

/datum/preferences/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, initial_spawn = FALSE)
	features += features_speech
	..()

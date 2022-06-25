// Author Gremling
// by request of the overlord FennyKong, I have granted his wish by designing a method to allow users to have a sound play when typing, or finished typing.
#define NO_SOUND		1
#define PLAY_STARTING	2
#define PLAY_TYPING		3
#define PLAY_FINISHED	4

GLOBAL_LIST_INIT(play_methods, list("No Sound",
									"Play sound when you begin typing",
									"Loop sound while you type",
									"Play sound after you type"))

GLOBAL_LIST_INIT(typing_indicator_sounds, list(
		"Default"	= 'modular_coyote/sound/typing/default.ogg',
		"FB Messenger"	= 'modular_coyote/sound/typing/facebookMessenger.ogg'
		))


/datum/looping_sound/typing_indicator
	mid_length = 30
	volume = 15

/datum/looping_sound/typing_indicator/start(atom/add_thing)
	output_atoms = get_hearers_in_view(7,usr)
	output_atoms -= usr

	return ..()


/datum/preferences
	var/typing_indicator_sound = 'modular_coyote/sound/typing/default.ogg'
	var/typing_indicator_sound_play = PLAY_STARTING

/mob
	var/datum/looping_sound/typing_indicator/typing_sound

/mob/Initialize()
	typing_sound = new(list(src), FALSE)
	return ..()

/mob/Destroy()
	QDEL_NULL(typing_sound)
	return ..()

/mob/proc/get_typing_indicator_sound()
	if(client)
		var/client/C = client
		return C.prefs.typing_indicator_sound
	return

/mob/proc/get_typing_indicator_pref()
	if(client)
		var/client/C = client
		return C.prefs.typing_indicator_sound_play
	return 


/mob/display_typing_indicator(timeout_override = TYPING_INDICATOR_TIMEOUT, state_override = generate_typing_indicator(), force = FALSE)
	if(((!typing_indicator_enabled || (stat != CONSCIOUS)) && !force) || typing_indicator_current)
		return

	if(client?.prefs.typing_indicator_sound_play == GLOB.play_methods[PLAY_STARTING])
		playsound_local(src, GLOB.typing_indicator_sounds[client.prefs.typing_indicator_sound], 15, FALSE)

	if(client?.prefs.typing_indicator_sound_play == GLOB.play_methods[PLAY_TYPING])
		if(typing_sound)
			typing_sound.mid_sounds = list(GLOB.typing_indicator_sounds[client.prefs.typing_indicator_sound])
			typing_sound.start()

	return ..()


/mob/clear_typing_indicator()
	if(typing_sound)
		typing_sound.stop()

	if(client?.prefs.typing_indicator_sound_play == GLOB.play_methods[PLAY_FINISHED])
		playsound_local(src, GLOB.typing_indicator_sounds[client.prefs.typing_indicator_sound], 15, FALSE)

	return ..()

/datum/preferences/load_character(slot)
	. = ..(slot)
	if(!(. == TRUE))
		return . // There's an error!!
	
	var/savefile/S = new /savefile(path)
	S.cd = "/"
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))

	S.cd = "/character[slot]"

	S["typing_indicator_sound"]			>> typing_indicator_sound
	S["typing_indicator_sound_play"]	>> typing_indicator_sound_play

	typing_indicator_sound				= sanitize_inlist(typing_indicator_sound, GLOB.typing_indicator_sounds)
	typing_indicator_sound_play			= sanitize_inlist(typing_indicator_sound_play, GLOB.play_methods)

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
	WRITE_FILE(S["typing_indicator_sound"]				, typing_indicator_sound)
	WRITE_FILE(S["typing_indicator_sound_play"]			, typing_indicator_sound_play)

	return 1

/datum/preferences/process_link(mob/user, list/href_list)
	switch(href_list["task"])
		if("input")
			switch(href_list["preference"])
				if("typing_indicator_sound")
					var/new_sound
					new_sound = input(user, "Choose your typing sound:", "Character Pogerenfe") as null|anything in GLOB.typing_indicator_sounds
					if(new_sound)
						typing_indicator_sound = new_sound
				
				if("typing_indicator_sound_play")

					var/new_input = input(user, "Choose your typing sound behaviour", "You stink c:") as null|anything in GLOB.play_methods
					if(new_input)
						typing_indicator_sound_play = new_input
	..()


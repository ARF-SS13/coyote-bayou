/mob/living/proc/Ellipsis(original_msg, chance = 50, keep_words)
	if(chance <= 0)
		return "..."
	if(chance >= 100)
		return original_msg

	var/list/words = splittext(original_msg," ")
	var/list/new_words = list()

	var/new_msg = ""

	for(var/w in words)
		if(prob(chance))
			new_words += "..."
			if(!keep_words)
				continue
		new_words += w

	new_msg = jointext(new_words," ")

	return new_msg

/mob/living/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, just_chat)
	/* var/static/list/crit_allowed_modes = list(
		MODE_WHISPER = TRUE,
		MODE_CUSTOM_SAY = TRUE,
		MODE_SING = TRUE,
		MODE_HEADSET = TRUE,
		MODE_ROBOT = TRUE,
		MODE_CHANGELING = TRUE,
		MODE_ALIEN = TRUE
		) */
	var/static/list/unconscious_allowed_modes = list(MODE_CHANGELING = TRUE, MODE_ALIEN = TRUE)
	var/talk_key = get_key(message)

	var/static/list/one_character_prefix = list(MODE_HEADSET = TRUE, MODE_ROBOT = TRUE, MODE_WHISPER = TRUE, MODE_SING = TRUE, "$" = TRUE, "#" = TRUE)

	var/ic_blocked = FALSE

	if(client && !forced && CHAT_FILTER_CHECK(message))
		//The filter doesn't act on the sanitized message, but the raw message.
		ic_blocked = TRUE

	if(sanitize)
		message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message || message == "")
		return

	if(ic_blocked)
		//The filter warning message shows the sanitized message though.
		to_chat(src, span_warning("That message contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[message]\"</span>"))
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		return

	var/datum/saymode/saymode = SSradio.saymodes[talk_key]
	var/message_mode = get_message_mode(message)
	var/original_message = message
	var/in_critical = InCritical()

	if(one_character_prefix[message_mode])
		message = copytext_char(message, 2)
	else if(message_mode || saymode)
		message = copytext_char(message, 3)
	message = trim_left(message)
	if(!message)
		return
	if(message_mode == MODE_ADMIN)
		if(client)
			client.cmd_admin_say(message)
		return

	// if(message_mode == MODE_DEADMIN)
	// 	if(client)
	// 		client.dsay(message)
	// 	return

	if(stat == DEAD)
		say_dead(original_message)
		return

	if(check_emote(original_message, just_runechat = just_chat) || !can_speak_basic(original_message, ignore_spam))
		return

	//if(in_critical)
	//	if(!(crit_allowed_modes[message_mode]))
	//		return
	if(stat == UNCONSCIOUS && !(unconscious_allowed_modes[message_mode]))
		return

	// language comma detection.
	var/datum/language/message_language = get_message_language(message)
	if(message_language)
		// No, you cannot speak in xenocommon just because you know the key
		if(can_speak_language(message_language))
			language = message_language
		message = copytext_char(message, 3)

		// Trim the space if they said ",0 I LOVE LANGUAGES"
		message = trim_left(message)

	if(!language)
		language = get_selected_language()

	// Detection of language needs to be before inherent channels, because
	// AIs use inherent channels for the holopad. Most inherent channels
	// ignore the language argument however.

	if(saymode && !saymode.handle_message(src, message, language))
		return

	if(!can_speak_vocal(message))
		to_chat(src, span_warning("You find yourself unable to speak!"))
		return

	var/message_range = SSchat.base_say_distance

	//var/succumbed = FALSE

	//var/fullcrit = InFullCritical()
	if(in_critical || message_mode == MODE_WHISPER)
		if(!in_critical)
			message_range = SSchat.base_whisper_distance
		spans |= SPAN_ITALICS
		src.log_talk(message, LOG_WHISPER)
	else
		src.log_talk(message, LOG_SAY, forced_by=forced)

	message = treat_message(message) // unfortunately we still need this
	var/sigreturn = SEND_SIGNAL(src, COMSIG_MOB_SAY, args)
	if (sigreturn & COMPONENT_UPPERCASE_SPEECH)
		message = uppertext(message)
	if(!message)
		return

	last_words = message

	spans |= speech_span

	if(language)
		var/datum/language/L = GLOB.language_datum_instances[language]
		spans |= L.spans

	if(message_mode == MODE_SING)
		var/randomnote = pick("\u2669", "\u266A", "\u266B")
		message = "[randomnote] [message] [randomnote]"
		spans |= SPAN_SINGING
	
	if(message_mode == MODE_YELL)
		spans |= SPAN_YELL
	
	var/radio_return = radio(message, message_mode, spans, language)
	if(radio_return & ITALICS)
		spans |= SPAN_ITALICS
	if(radio_return & REDUCE_RANGE)
		message_range = 3
	if(radio_return & NOPASS)
		return 1
/*Optimisation as we don't use space
	//No screams in space, unless you're next to someone.
	var/turf/T = get_turf(src)
	var/datum/gas_mixture/environment = T.return_air()
	var/pressure = (environment)? environment.return_pressure() : 0
	if(pressure < SOUND_MINIMUM_PRESSURE)
		message_range = 1

	if(pressure < ONE_ATMOSPHERE*0.4) //Thin air, let's italicise the message
		spans |= SPAN_ITALICS
*/
	send_speech(message, message_range, src, bubble_type, spans, language, message_mode, just_chat)

	/* if(succumbed)
		succumb()
		to_chat(src, compose_message(src, language, message, null, spans, message_mode)) */

	return 1

/mob/living/compose_message(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode, face_name = FALSE, atom/movable/source)
	. = ..()
	if(isliving(speaker))
		var/turf/sourceturf = get_turf(source)
		var/turf/T = get_turf(src)
		if(sourceturf && T && !(sourceturf in get_hear(5, T)))
			. = span_small("[.]")

/mob/living/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source, just_chat = FALSE, list/data = list())
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args) //parent calls can't overwrite the current proc args.
	if(!client)
		return
	var/deaf_message
	var/deaf_type
	if(speaker != src)
		if(!radio_freq) //These checks have to be seperate, else people talking on the radio will make "You can't hear yourself!" appear when hearing people over the radio while deaf.
			deaf_message = "<span class='name'>[speaker]</span> [get_random_if_list(speaker.verb_say)] something but you cannot hear [speaker.p_them()]."
			deaf_type = 1
	else
		deaf_message = span_notice("You can't hear yourself!")
		deaf_type = 2 // Since you should be able to hear yourself without looking

	// Create map text prior to modifying message for goonchat
	if (client?.prefs?.chat_on_map && stat != UNCONSCIOUS && (client.prefs.see_chat_non_mob || ismob(speaker)) && can_hear())
		data["message_mode"] = message_mode
		create_chat_message(speaker, message_language, raw_message, spans, NONE, data)

	if(just_chat)
		return
	// Recompose message for AI hrefs, language incomprehension.
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mode, FALSE, source)
	if(client.prefs.color_chat_log)
		var/sanitizedsaycolor = client.sanitize_chat_color(speaker.get_chat_color())
		message = color_for_chatlog(message, sanitizedsaycolor, speaker.name)
	show_message(message, MSG_AUDIBLE, deaf_message, deaf_type)
	if(islist(data) && LAZYACCESS(data, "is_radio") && (data["ckey"] in GLOB.directory) && !SSchat.debug_block_radio_blurbles)
		if(CHECK_PREFS(src, RADIOPREF_HEAR_RADIO_STATIC))
			playsound(src, RADIO_STATIC_SOUND, 20, FALSE, SOUND_DISTANCE(2), ignore_walls = TRUE)
		if(CHECK_PREFS(src, RADIOPREF_HEAR_RADIO_BLURBLES))
			var/mob/blurbler = ckey2mob(data["ckey"])
			if(blurbler && blurbler != src)
				blurbler.play_AC_typing_indicator(raw_message, src, src, TRUE)
	return message

/mob/living/send_speech(
	message,
	message_range = 6,
	obj/source = src,
	bubble_type = bubble_icon,
	list/spans,
	datum/language/message_language=null,
	message_mode,
	just_chat
)
	var/max_range = 15
	var/static/list/eavesdropping_modes = list(MODE_WHISPER = TRUE, MODE_WHISPER_CRIT = TRUE)
	var/quietness = eavesdropping_modes[message_mode]
	// okay just throw out the message range
	switch(message_mode)
		if(MODE_WHISPER)
			quietness = TRUE
			message_range = SSchat.base_whisper_distance
			max_range = SSchat.extended_whisper_distance
		if(MODE_YELL)
			quietness = FALSE
			message_range = SSchat.base_yell_distance
			max_range = SSchat.extended_yell_distance
		if(MODE_SING)
			quietness = FALSE
			message_range = SSchat.base_sing_distance
			max_range = SSchat.extended_sing_distance
		else
			quietness = FALSE
			message_range = SSchat.base_say_distance
			max_range = SSchat.extended_say_distance

	var/list/listening = get_hearers_in_view(message_range, src, TRUE)
	var/datum/chatchud/CC = get_listening(src, message_range, max_range, quietness)
	var/list/visible_close = CC.visible_close.Copy()
	var/list/visible_far = CC.visible_far.Copy()
	var/list/hidden_close_pathable = CC.hidden_close_pathable.Copy()
	CC.putback()


	var/list/the_dead = list()
	// var/list/yellareas	//CIT CHANGE - adds the ability for yelling to penetrate walls and echo throughout areas
	// if(!eavesdrop_range && say_test(message) == "2")	//CIT CHANGE - ditto
	// 	yellareas = get_areas_in_range(message_range*0.5, source)	//CIT CHANGE - ditto
	for(var/_M in GLOB.player_list)
		var/mob/M = _M
		if(QDELETED(M)) //Some times nulls and deleteds stay in this list. This is a workaround to prevent ic chat breaking for everyone when they do.
			continue
		if(M.stat != DEAD) //not dead, not important
			continue
		if(!M.client || !client) //client is so that ghosts don't have to listen to mice
			continue
		if(get_dist(M, source) > 7 || M.z != z) //they're out of range of normal hearing
			if(eavesdropping_modes[message_mode] && !(M.client?.prefs.chat_toggles & CHAT_GHOSTWHISPER)) //they're whispering and we have hearing whispers at any range off
				continue
			if(!(M.client?.prefs.chat_toggles & CHAT_GHOSTEARS)) //they're talking normally and we have hearing at any range off
				continue
		CC.visible_close[M] = TRUE
		the_dead[M] = TRUE
	
	var/eavesdropping
	var/eavesrendered
	if(!quietness)
		eavesdropping = dots(message)
		eavesrendered = compose_message(src, message_language, eavesdropping, null, spans, message_mode, FALSE, source)

	var/rendered = compose_message(src, message_language, message, null, spans, message_mode, FALSE, source)
	/// non-players
	for(var/_AM in listening)
		var/atom/movable/AM = _AM
		if(!quietness && get_dist(source, AM) > message_range && !(the_dead[AM]))
			AM.Hear(eavesrendered, src, message_language, eavesdropping, null, spans, message_mode, source, just_chat)
		else
			AM.Hear(rendered, src, message_language, message, null, spans, message_mode, source, just_chat)

	var/list/sblistening = list()
	/// players
	for(var/mob/mvc in visible_close)
		mvc.Hear(rendered, src, message_language, message, null, spans, message_mode, source, just_chat)
		sblistening |= mvc.client
	for(var/mob/mvf in visible_far)
		var/list/coolspans = spans
		coolspans += SPAN_SMALL
		var/list/data = list()
		data["is_eaves"] = TRUE
		data["is_far"] = TRUE
		mvf.Hear(eavesrendered, src, message_language, eavesdropping, null, coolspans, message_mode, source, just_chat, data)
		sblistening |= mvf.client
	for(var/mob/mhp in hidden_close_pathable)
		var/turf/hearfrom = hidden_close_pathable[mhp]
		var/list/cooler_spans = spans
		cooler_spans += SPAN_SMALLER
		var/list/data = list()
		data["is_eaves"] = TRUE
		data["display_turf"] = hearfrom
		mhp.Hear(eavesrendered, src, message_language, eavesdropping, null, cooler_spans, message_mode, source, just_chat, data)
		sblistening |= mhp.client

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_LIVING_SAY_SPECIAL, src, message)

	//speech bubble
	var/list/speech_bubble_recipients = list()
	for(var/mob/M in sblistening)
		if(M.client?.prefs && !M.client.prefs.chat_on_map)
			speech_bubble_recipients.Add(M.client)

	var/image/I = image('icons/mob/talk.dmi', src, "[bubble_type][say_test(message)]", FLY_LAYER)
	I.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flick_overlay), I, speech_bubble_recipients, 30)

/mob/living/simple_animal/debug_chatterboy
	name = "Chatterboy"
	desc = "A debug chatterboy. He's here to help you debug your chatterboys. He's not actually a chatterboy, though. He's just a rock."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	maxHealth = 1
	wander = FALSE
	var/speak_cooldown = 0

/mob/living/simple_animal/debug_chatterboy/BiologicalLife(seconds, times_fired)
	. = ..()
	// if(speak_cooldown > world.time)
	// 	return
	// speak_cooldown = world.time + 2 SECONDS
	/// various longwinded "RPer" messages
	var/speech = pick(
		"Hello, I am a chatterboy. I am here to help you debug your chatterboys. I am not actually a chatterboy, though. I am just a rock.",
		"Wow! I am a chatterboy! Your chatterboys are so cool! I wish I was a chatterboy! But I am just a rock. :(",
		"$AAAAAAAAAAAAAAAA I AM A CHATTERBOY I AM HERE TO HELP YOU DEBUG YOUR CHATTERBOYS I AM NOT ACTUALLY A CHATTERBOY THOUGH I AM JUST A ROCK",
		"$NOOOOOOOOO, NO NO NO NO, MY MOTHER WAS A CHATTERBOY, MY FATHER WAS A CHATTERBOY, I AM A CHATTERBOY, I AM HERE TO HELP YOU DEBUG YOUR CHATTERBOYS, I AM NOT ACTUALLY A CHATTERBOY THOUGH, I AM JUST A ROCK",
		"I gave away our wikipedia article to the chatterboys. Citations needed.",
		"#My character would actually screw over the party and steal the loot. It's what my character would do.",
		"#Actually, my character is a pacifist. They would never kill anyone. They would just steal the loot and run away.",
		"We dong have any brass windows.",
		"%Big fat dongs, i wanna devour them all.",
		"%Hey, heeeeyyy, wow",
		"I dont know what to say, I'm just a rock.",
		"SCREW OFF, CORRY YOU WANNA BE CHATTERBOY",
		"I stuff all the cheeseburgers in my mouth and swallow them whole.",
	)
	playsound(src, 'sound/effects/bwoing.ogg', 100, TRUE)
	say(speech)

/mob/proc/binarycheck()
	return FALSE

/mob/living/can_speak(message) //For use outside of Say()
	if(can_speak_basic(message) && can_speak_vocal(message))
		return 1

/mob/living/proc/can_speak_basic(message, ignore_spam = FALSE) //Check BEFORE handling of xeno and ling channels
	if(client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, span_danger("You cannot speak in IC (muted)."))
			return 0
		if(!ignore_spam && client.handle_spam_prevention(message,MUTE_IC))
			return 0

	return 1

/mob/living/proc/can_speak_vocal(message) //Check AFTER handling of xeno and ling channels
	var/obj/item/bodypart/leftarm = get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/rightarm = get_bodypart(BODY_ZONE_R_ARM)
	if(HAS_TRAIT(src, TRAIT_MUTE) && get_selected_language() != /datum/language/signlanguage)
		return 0

	if (get_selected_language() == /datum/language/signlanguage)
		var/left_disabled = FALSE
		var/right_disabled = FALSE
		if (istype(leftarm)) // Need to check if the arms exist first before checking if they are disabled or else it will runtime
			if (leftarm.is_disabled())
				left_disabled = TRUE
		else
			left_disabled = TRUE
		if (istype(rightarm))
			if (rightarm.is_disabled())
				right_disabled = TRUE
		else
			right_disabled = TRUE
		if (left_disabled && right_disabled) // We want this to only return false if both arms are either missing or disabled since you could technically sign one-handed.
			return 0


	if(is_muzzled())
		return 0

	if(!IsVocal())
		return 0

	return 1

/mob/living/proc/get_key(message)
	var/key = message[1]
	if(key in GLOB.department_radio_prefixes)
		return lowertext(message[1 + length(key)])

/mob/living/proc/get_message_language(message)
	if(message[1] == ",")
		var/key = message[1 + length(message[1])]
		for(var/ld in GLOB.all_languages)
			var/datum/language/LD = ld
			if(initial(LD.key) == key)
				return LD
	return null

/mob/living/proc/treat_message(message)
	if(!LAZYLEN(message))
		return message

	if(HAS_TRAIT(src, TRAIT_UNINTELLIGIBLE_SPEECH))
		message = unintelligize(message)

	if(derpspeech)
		message = derpspeech(message, stuttering)

	if(stuttering)
		message = stutter(message)

	if(slurring)
		message = slur(message,slurring)

	if(cultslurring)
		message = cultslur(message)

/*	if(clockcultslurring)
		message = CLOCK_CULT_SLUR(message)*/

	var/end_char = copytext(message, length(message), length(message) + 1)
	if(!(end_char in list(".", "?", "!", "-", "~", ",", "_", "+", "|", "*")))
		message += "."

	message = capitalize(message)

	return message

/mob/living/proc/radio(message, message_mode, list/spans, language)
	var/obj/item/implant/radio/imp = locate() in implants
	if(imp?.radio.on)
		if(message_mode == MODE_HEADSET)
			imp.radio.talk_into(src, message, , spans, language)
			return ITALICS | REDUCE_RANGE
		if(message_mode == MODE_DEPARTMENT || (message_mode in GLOB.radiochannels))
			imp.radio.talk_into(src, message, message_mode, spans, language)
			return ITALICS | REDUCE_RANGE

	switch(message_mode)
		if(MODE_WHISPER)
			return ITALICS
		if(MODE_R_HAND)
			for(var/obj/item/r_hand in get_held_items_for_side("r", all = TRUE))
				if (r_hand)
					return r_hand.talk_into(src, message, , spans, language)
				return ITALICS | REDUCE_RANGE
		if(MODE_L_HAND)
			for(var/obj/item/l_hand in get_held_items_for_side("l", all = TRUE))
				if (l_hand)
					return l_hand.talk_into(src, message, , spans, language)
				return ITALICS | REDUCE_RANGE

		if(MODE_INTERCOM)
			for (var/obj/item/radio/intercom/I in view(1, null))
				I.talk_into(src, message, , spans, language)
			return ITALICS | REDUCE_RANGE

		if(MODE_BINARY)
			return ITALICS | REDUCE_RANGE //Does not return 0 since this is only reached by humans, not borgs or AIs.

	return 0

/mob/living/say_mod(input, message_mode)
	. = ..()
	if(message_mode != MODE_CUSTOM_SAY)
		if(stuttering)
			. = "stammers"
		else if(derpspeech)
			. = "gibbers"
		else if(InCritical())
			. = get_random_if_list(verb_whisper)

/mob/living/whisper(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	say("#[message]", bubble_type, spans, sanitize, language, ignore_spam, forced)

/mob/living/get_language_holder(get_minds = TRUE)
	if(get_minds && mind)
		return mind.get_language_holder()
	. = ..()

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

#define RETURN_MOM momchat?.checkin();return
/mob/living/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, only_overhead, mob/direct_to_mob = null)
	if(!SSrentaldatums.initialized)
		return
	/* var/static/list/crit_allowed_modes = list(
		MODE_WHISPER = TRUE,
		MODE_CUSTOM_SAY = TRUE,
		MODE_SING = TRUE,
		MODE_HEADSET = TRUE,
		MODE_ROBOT = TRUE,
		MODE_CHANGELING = TRUE,
		MODE_ALIEN = TRUE
		) */
	var/datum/rental_mommy/chat/momchat = SSrentaldatums.CheckoutChatMommy() // hi mom
	momchat.original_message = message
	momchat.message = message
	momchat.source = src
	momchat.message_mode = MODE_SAY
	momchat.spans = spans
	momchat.sanitize = TRUE
	momchat.bubble_type = bubble_type
	momchat.language = language
	momchat.only_overhead = only_overhead
	momchat.source_quid = extract_quid(src)
	momchat.source_ckey = ckey
	momchat.direct_to_mob = direct_to_mob

	// var/static/list/unconscious_allowed_modes = list(MODE_CHANGELING = TRUE, MODE_ALIEN = TRUE)
	var/talk_key = get_key(momchat.message)
	momchat.message_key = talk_key

	// var/static/list/one_character_prefix = list(MODE_HEADSET = TRUE, MODE_ROBOT = TRUE, MODE_WHISPER = TRUE, MODE_SING = TRUE, MODE_YELL = TRUE, MODE_WHISPER = TRUE)

	var/ic_blocked = FALSE

	if(client && !forced && CHAT_FILTER_CHECK(momchat.message))
		//The filter doesn't act on the sanitized message, but the raw message.
		ic_blocked = TRUE

	if(sanitize)
		momchat.message = trim(copytext_char(sanitize(momchat.message), 1, MAX_MESSAGE_LEN))
	if((!momchat.message || momchat.message == "") && !momchat.pulse_verb)
		RETURN_MOM

	if(ic_blocked)
		//The filter warning message shows the sanitized message though.
		to_chat(src, span_warning("That message contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[momchat.message]\"</span>"))
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		RETURN_MOM

	if(check_emote(momchat.original_message, just_runechat = only_overhead))
		RETURN_MOM
	var/datum/saymode/saymode = SSradio.saymodes[talk_key]
	SSchat.ExtractCustomVerb(momchat)
	get_message_mode(momchat)
	momchat.original_message = momchat.message
	var/in_critical = InCritical()
	momchat.in_critical = in_critical
	if(!momchat.mode_trimmed)
		// if(SSchat.one_character_prefix[momchat.message_mode])
		// 	momchat.message = copytext_char(momchat.message, 2)
		if(saymode)
			momchat.message = copytext_char(momchat.message, 2)
	momchat.message = trim(momchat.message)
	if(!momchat.message && !momchat.pulse_verb)
		RETURN_MOM
	if(momchat.message_mode == MODE_ADMIN)
		if(client)
			client.cmd_admin_say(momchat.message)
		RETURN_MOM

	// if(momchat.message_mode == MODE_DEADMIN)
	// 	if(client)
	// 		client.dsay(momchat.message)
	// 	RETURN_MOM

	if(stat == DEAD)
		say_dead(momchat.original_message)
		RETURN_MOM

	if(!can_speak_basic(momchat.original_message, ignore_spam))
		RETURN_MOM

	//if(in_critical)
	//	if(!(crit_allowed_modes[momchat.message_mode]))
	//		RETURN_MOM
	if(stat == UNCONSCIOUS && !(SSchat.unconscious_allowed_modes[momchat.message_mode]))
		RETURN_MOM

	// language comma detection.
	var/datum/language/message_language = get_message_language(momchat.message)
	if(message_language)
		// No, you cannot speak in xenocommon just because you know the key
		if(can_speak_language(message_language))
			momchat.language = message_language
		momchat.message = copytext_char(momchat.message, 3)

		// Trim the space if they said ",0 I LOVE LANGUAGES"
		momchat.message = trim(momchat.message)

	if(!momchat.language)
		momchat.language = get_selected_language()

	// Detection of language needs to be before inherent channels, because
	// AIs use inherent channels for the holopad. Most inherent channels
	// ignore the language argument however.

	if(saymode && !saymode.handle_message(src, momchat.message, momchat.language))
		RETURN_MOM

	if(!can_speak_vocal(momchat.message))
		to_chat(src, span_warning("You find yourself unable to speak!"))
		RETURN_MOM

	set_speech_range(momchat)

	//var/succumbed = FALSE

	//var/fullcrit = InFullCritical()
	if(in_critical || momchat.message_mode == MODE_WHISPER)
		spans |= SPAN_ITALICS
		src.log_talk(momchat.message, LOG_WHISPER)
	else
		src.log_talk(momchat.message, LOG_SAY, forced_by=forced)

	treat_message(momchat) // unfortunately we still need this
	var/sigreturn = SEND_SIGNAL(src, COMSIG_MOB_SAY, momchat) // signal ffgneriugvnbiresgniuer
	if (sigreturn & COMPONENT_UPPERCASE_SPEECH)
		momchat.message = uppertext(momchat.message)
	if(!momchat.message && !momchat.pulse_verb)
		RETURN_MOM

	last_words = momchat.message

	momchat.spans |= speech_span

	if(momchat.language && LAZYLEN(GLOB.language_datum_instances))
		var/datum/language/L = GLOB.language_datum_instances[momchat.language]
		momchat.spans |= L.spans

	if(momchat.message_mode == MODE_SING)
		var/randomnote = pick("\u2669", "\u266A", "\u266B")
		momchat.msg_decor_left = randomnote
		momchat.msg_decor_right = randomnote
		momchat.message = "[momchat.msg_decor_left] [momchat.message] [momchat.msg_decor_right]"
		momchat.spans |= SPAN_SINGING
	
	if(momchat.message_mode == MODE_YELL)
		momchat.spans |= SPAN_YELL
	
	radio(momchat)
	if(momchat.radio_no_pass) // love that anime
		RETURN_MOM
	if(momchat.radio_returns & ITALICS)
		momchat.spans |= SPAN_ITALICS
	if(momchat.radio_returns & REDUCE_RANGE)
		momchat.close_message_range = SSchat.base_radio_reduced_distance
		momchat.far_message_range = SSchat.extended_radio_reduced_distance

	send_speech(momchat)
	if(momchat.direct_to_mob)
		return momchat // make sure to put her back (wet or otherwise)
	RETURN_MOM // please

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

	/* if(succumbed)
		succumb()
		to_chat(src, compose_message(src, language, message, null, spans, momchat.message_mode)) */

/mob/proc/set_speech_range(datum/rental_mommy/chat/momchat)
	if(!momchat)
		CRASH("set_speech_range called with no momchat!!!!!!!!!!!!!!!!!!!")
	// if(momchat.in_critical)
	// 	momchat.is_quiet = TRUE
	// 	momchat.close_message_range = SSchat.base_whisper_distance
	// 	momchat.far_message_range = SSchat.extended_whisper_distance
	// else
	// var/static/list/eavesdropping_modes = list(MODE_WHISPER = TRUE, MODE_WHISPER_CRIT = TRUE)
	switch(momchat.message_mode)
		if(MODE_WHISPER, MODE_WHISPER_CRIT)
			momchat.is_quiet = TRUE
			momchat.close_message_range = SSchat.base_whisper_distance
			momchat.far_message_range = SSchat.extended_whisper_distance
		if(MODE_EXCLAIM)
			momchat.is_quiet = FALSE
			momchat.close_message_range = SSchat.base_exclaim_distance
			momchat.far_message_range = SSchat.extended_exclaim_distance
		if(MODE_YELL)
			momchat.is_quiet = FALSE
			momchat.close_message_range = SSchat.base_yell_distance
			momchat.far_message_range = SSchat.extended_yell_distance
		if(MODE_SING)
			momchat.is_quiet = FALSE
			momchat.close_message_range = SSchat.base_sing_distance
			momchat.far_message_range = SSchat.extended_sing_distance
		else
			momchat.is_quiet = FALSE
			momchat.close_message_range = SSchat.base_say_distance
			momchat.far_message_range = SSchat.extended_say_distance
	momchat.speech_range_set = TRUE

// /mob/living/compose_message(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode, face_name = FALSE, atom/movable/source, list/data = list())
// 	. = ..()
	// if(isliving(speaker))
	// 	var/turf/sourceturf = get_turf(source)
	// 	var/turf/T = get_turf(src)
	// 	if(sourceturf && T && !(sourceturf in get_hear(5, T)))
	// 		. = span_small("[.]")

/mob/Hear(
	message,
	atom/movable/speaker,
	datum/language/message_language,
	raw_message,
	radio_freq,
	list/spans,
	message_mode,
	atom/movable/source,
	only_overhead = FALSE,
	list/data = list(),
) // TEN ARGUMENTS !! FIVE BUTTS! SECRET THIRD LEG!
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args) //parent calls can't overwrite the current proc args.
	if(!client)
		return
	var/datum/rental_mommy/chat/momchat = data["momchat"]
	var/deaf_message
	var/deaf_type
	if(speaker != src)
		if(!radio_freq) //These checks have to be seperate, else people talking on the radio will make "You can't hear yourself!" appear when hearing people over the radio while deaf.
			deaf_message = "<span class='name'>[speaker]</span> [get_random_if_list(speaker.verb_say)] something but you cannot hear [speaker.p_them()]."
			deaf_type = 1
	else
		deaf_message = span_notice("You can't hear yourself!")
		deaf_type = 2 // Since you should be able to hear yourself without looking
	

	if(only_overhead)
		return
	// Recompose message for AI hrefs, language incomprehension.
	if(momchat?.cant_language)
		var/msg = momchat ? momchat.original_message : raw_message
		message = compose_message(speaker, message_language, msg, radio_freq, spans, message_mode, FALSE, source, data)
	/// abject misery - replaces doubled double quotes with single double quotes
	message = replacetext(message, "\"\"", "\"")
	// Create map text prior to modifying message for goonchat
	if (!isdummy(source) && client?.prefs?.chat_on_map && stat != UNCONSCIOUS && (client.prefs.see_chat_non_mob || ismob(speaker)) && can_hear())
		if(momchat)
			// if(momchat.runechat_mode == "hidden_pathable")
			// 	/// make one that's just normal, to display at the real source
			// 	var/datum/rental_mommy/chat/mom3 = SSrentaldatums.CheckoutChatMommy()
			// 	mom3.copy_mommy(momchat)
			// 	mom3.runechat_mode = "visible_close"
			// 	mom3.display_turf = null
			// 	mom3.is_eavesdropping = FALSE
			// 	create_chat_message(speaker, message_language, raw_message, spans, NONE, null, mom3)
			// 	if(!mom3.available)
			// 		mom3.checkin()
			// else // oh god please beat me with a crowbar, make me cum so hard to the sound of my broken kneecaps, cmon it'll be fun
			if(!momchat.pulse_verb)
				create_chat_message(speaker, message_language, message, spans, NONE, null, momchat)
		else
			data["message_mode"] = message_mode
			// make a second one, for in case we go from not seeing them to seeing them
			if(data["is_eaves"] || data["is_far"] || data["display_turf"])
				var/list/cooldata = data.Copy()
				cooldata["is_eaves"] = FALSE
				cooldata["is_far"] = FALSE
				cooldata["display_turf"] = null
				create_chat_message(speaker, message_language, message, spans, NONE, cooldata)
			else
				create_chat_message(speaker, message_language, message, spans, NONE, data)
	var/client/C = client
	if(C.prefs.color_chat_log)
		var/base_chat_color = speaker.get_chat_color()
		var/sanitizedsaycolor = C.sanitize_chat_color(base_chat_color)
		if(momchat)
			momchat.chat_color_base = base_chat_color
			momchat.chat_color_sanitized = sanitizedsaycolor
		message = color_for_chatlog(message, sanitizedsaycolor, speaker.name, momchat)
	if(momchat && should_hornify(momchat))
		momchat.furry_dating_sim = TRUE
	if(momchat && isdummy(momchat.source))
		momchat.message = message
		return momchat
	show_message(message, MSG_AUDIBLE, deaf_message, deaf_type, null, momchat)
	if(islist(data) && LAZYACCESS(data, "is_radio") && (data["ckey"] in GLOB.directory) && !SSchat.debug_block_radio_blurbles)
		if(CHECK_PREFS(src, RADIOPREF_HEAR_RADIO_STATIC))
			playsound(src, RADIO_STATIC_SOUND, 20, FALSE, SOUND_DISTANCE(2), ignore_walls = TRUE)
		if(CHECK_PREFS(src, RADIOPREF_HEAR_RADIO_BLURBLES))
			var/mob/blurbler = ckey2mob(data["ckey"])
			if(blurbler && blurbler != src)
				blurbler.play_AC_typing_indicator(raw_message, src, src, TRUE)
	return message

/mob/living/send_speech(datum/rental_mommy/chat/momchat)
	var/datum/chatchud/CC = null
	if(!momchat.direct_to_mob)
		CC = get_listening(momchat)
	var/list/visible_close = CC ? CC.visible_close.Copy() : list(momchat.direct_to_mob)
	var/list/visible_far = CC ? CC.visible_far.Copy() : list()
	var/list/hidden_pathable = CC ? CC.hidden_pathable.Copy() : list()
	CC?.putback()

	// var/list/the_dead = list()
	if(!momchat.direct_to_mob)
		for(var/_M in GLOB.player_list)
			var/mob/M = _M
			if(QDELETED(M)) //Some times nulls and deleteds stay in this list. This is a workaround to prevent ic chat breaking for everyone when they do.
				continue
			if(M.stat != DEAD) //not dead, not important
				continue
			if(isnewplayer(M)) //quit hearing stuff from the lobby!
				continue
			if(!M.client || !client) //client is so that ghosts don't have to listen to mice
				continue
			if(get_dist(M, momchat.source) > 7 || M.z != z) //they're out of range of normal hearing
				if(momchat.is_quiet && !(M.client?.prefs.chat_toggles & CHAT_GHOSTWHISPER)) //they're whispering and we have hearing whispers at any range off
					continue
				if(!(M.client?.prefs.chat_toggles & CHAT_GHOSTEARS)) //they're talking normally and we have hearing at any range off
					continue
			CC.visible_close[M] = TRUE
			// the_dead[M] = TRUE
	
	. = momchat
	var/list/rental_data = list("momchat" = momchat) // mommy is very disappointed
	var/rendered = compose_message(src, momchat.language, momchat.message, null, momchat.spans, momchat.message_mode, FALSE, momchat.source, rental_data)
	if(momchat.direct_to_mob)
		momchat.recipiant = momchat.direct_to_mob
		momchat.recipiant.Hear(rendered, src, momchat.language, momchat.message, null, momchat.spans, momchat.message_mode, momchat.source, momchat.only_overhead, list("momchat" = momchat))
		return
	var/list/sblistening = list()
	/// players
	for(var/mob/mvc in visible_close)
		var/datum/rental_mommy/chat/mom2 = SSrentaldatums.CheckoutChatMommy()
		mom2.copy_mommy(momchat)
		mom2.runechat_mode = "visible_close"
		mom2.recipiant = mvc
		mvc.Hear(rendered, src, momchat.language, momchat.message, null, mom2.spans, momchat.message_mode, momchat.source, momchat.only_overhead, list("momchat" = mom2))
		sblistening |= mvc.client
		if(!mom2.available)
			mom2.checkin()
	// for(var/mob/mvf in visible_far)
	// 	var/list/coolspans = momchat.spans
	// 	coolspans += SPAN_SMALL
	// 	var/list/data = list()
	// 	data["is_eaves"] = TRUE
	// 	data["display_turf"] = src
	// 	mvf.Hear(eavesrendered, src, momchat.language, eavesdropping, null, coolspans, momchat.message_mode, momchat.source, momchat.only_overhead, data)
	// 	sblistening |= mvf.client
	for(var/mob/mhp in hidden_pathable|visible_far)
		var/turf/hearfrom = hidden_pathable[mhp]
		var/datum/rental_mommy/chat/mom3 = SSrentaldatums.CheckoutChatMommy()
		mom3.copy_mommy(momchat)
		mom3.spans |= SPAN_SMALL
		mom3.is_eavesdropping = TRUE
		mom3.display_turf = hearfrom
		mom3.recipiant = mhp
		var/msg_dotted = dots(mom3.message, distance = get_dist(get_turf(src), get_turf(mhp)), maxdistance = momchat.far_message_range)
		var/msg_rerendered = compose_message(src, mom3.language, msg_dotted, null, momchat.spans | mom3.spans, momchat.message_mode, FALSE, momchat.source, list("momchat" = mom3))
		/// and cus the spans dont get frindly right, here it s again
		msg_rerendered = span_small(msg_rerendered)
		mom3.message = msg_rerendered
		mom3.runechat_mode = "hidden_pathable"
		mhp.Hear(msg_rerendered, src, momchat.language, msg_rerendered, null, momchat.spans | mom3.spans, momchat.message_mode, momchat.source, momchat.only_overhead, list("momchat" = mom3))
		sblistening |= mhp.client
		if(!mom3.available)
			mom3.checkin()
	/// non-players
	/// only sends the momchat.message to things like radios and toasters
	var/list/listening = get_hearers_in_view(momchat.close_message_range, src, TRUE)
	var/list/date = list()
	date["momchat"] = momchat
	for(var/_AM in listening)
		var/atom/movable/AM = _AM
		// if(momchat.is_quiet && get_dist(momchat.source, AM) > momchat.close_message_range && !(the_dead[AM]))
		// 	var/eavesdropping = dots(momchat.message)
		// 	var/eavesrendered = compose_message(src, momchat.language, eavesdropping, null, momchat.spans, momchat.message_mode, FALSE, momchat.source, rental_data)
		// 	AM.Hear(eavesrendered, src, momchat.language, eavesdropping, null, momchat.spans, momchat.message_mode, momchat.source, momchat.only_overhead, date)
		// else
		AM.Hear(rendered, src, momchat.language, momchat.original_message, null, momchat.spans, momchat.message_mode, momchat.source, momchat.only_overhead, date)

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_LIVING_SAY_SPECIAL, src, momchat.message)

	//speech bubble
	var/list/speech_bubble_recipients = list()
	for(var/mob/M in sblistening)
		if(M.client?.prefs && !M.client.prefs.chat_on_map)
			speech_bubble_recipients.Add(M.client)

	var/image/I = image('icons/mob/talk.dmi', src, "[momchat.bubble_type][say_test(momchat.message)]", FLY_LAYER)
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

/mob/living/simple_animal/debug_chatterboy/radiolad
	name = "Chatterboy w/ radio"
	desc = "A debug chatterboy w a radoi. He's here to help you debug your chatterboys. He's not actually a chatterboy, though. He's just a rock."

/mob/living/simple_animal/debug_chatterboy/radiolad/Initialize()
	var/obj/item/radio/R = new(get_turf(src))
	R.broadcasting = TRUE
	R.listening = TRUE
	R.become_hearing_sensitive(INNATE_TRAIT)
	R.name = "CHATTERBOY CHATPIECE"
	. = ..()

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

/mob/living/proc/treat_message(datum/rental_mommy/chat/momchat)
	if(!momchat)
		CRASH("treat_message called with no momchat!!!!!!!!!!!!!!!!!!!")
	if(!LAZYLEN(momchat.message))
		return
	if(HAS_TRAIT(src, TRAIT_UNINTELLIGIBLE_SPEECH))
		momchat.message = unintelligize(momchat.message)
	if(derpspeech)
		momchat.message = derpspeech(momchat.message, stuttering)
	if(stuttering)
		momchat.message = stutter(momchat.message)
	if(slurring)
		momchat.message = slur(momchat.message,slurring)
	if(cultslurring)
		momchat.message = cultslur(momchat.message)
/*	if(clockcultslurring)
		momchat.message = CLOCK_CULT_SLUR(momchat.message)*/
	var/end_char = copytext(momchat.message, length(momchat.message), length(momchat.message) + 1)
	if(!(end_char in list(".", "?", "!", "-", "~", ",", "_", "+", "|", "*")))
		momchat.message += "."
	momchat.message = capitalize(momchat.message)

/mob/living/proc/radio(datum/rental_mommy/chat/momchat)
	if(!momchat)
		CRASH("radio called with no momchat!!!!!!!!!!!!!!!!!!!")
	var/obj/item/implant/radio/imp = locate() in implants
	if(imp?.radio.on)
		if(momchat.message_mode == MODE_HEADSET)
			imp.radio.talk_into(src, momchat.message, , momchat.spans, momchat.language, momchat)
			momchat.radio_returns = ITALICS | REDUCE_RANGE
		if(momchat.message_mode == MODE_DEPARTMENT || (momchat.message_mode in GLOB.radiochannels))
			imp.radio.talk_into(src, momchat.message, momchat.message_mode, momchat.spans, momchat.language, momchat)
			momchat.radio_returns = ITALICS | REDUCE_RANGE
	if(!momchat.radio_returns)
		switch(momchat.message_mode)
			if(MODE_WHISPER)
				momchat.radio_returns = ITALICS
			if(MODE_R_HAND)
				for(var/obj/item/r_hand in get_held_items_for_side("r", all = TRUE))
					if (r_hand)
						momchat.radio_returns = r_hand.talk_into(src, momchat.message, , momchat.spans, momchat.language, momchat)
						break
					momchat.radio_returns = ITALICS | REDUCE_RANGE
			if(MODE_L_HAND)
				for(var/obj/item/l_hand in get_held_items_for_side("l", all = TRUE))
					if (l_hand)
						momchat.radio_returns = l_hand.talk_into(src, momchat.message, , momchat.spans, momchat.language, momchat)
						break
					momchat.radio_returns = ITALICS | REDUCE_RANGE

			if(MODE_INTERCOM)
				for (var/obj/item/radio/intercom/I in view(1, null))
					I.talk_into(src, momchat.message, , momchat.spans, momchat.language, momchat)
				momchat.radio_returns = ITALICS | REDUCE_RANGE

			if(MODE_BINARY)
				momchat.radio_returns = ITALICS | REDUCE_RANGE //Does not return 0 since this is only reached by humans, not borgs or AIs.

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

/atom/proc/should_hornify(datum/rental_mommy/chat/mommy)
	return FALSE // quit seducing ghosts in the lobby, wacky

/mob/living/should_hornify(datum/rental_mommy/chat/mommy)
	if(!mommy)
		return FALSE
	if(isdummy(mommy.source))
		return TRUE // previews n such
	// if(istype(mommy.source, /atom/movable/virtualspeaker)) // radios n such
	// 	if(!CHECK_PREFS(src, RADIOPREF_HEAR_RADIO_BLURBLES))
	// 		return FALSE
	// 	return TRUE
	if(mommy.is_actually_radio)
		return FALSE // to do: make this work good
	if(!ishuman(mommy.source))
		return FALSE
	var/mob/living/carbon/human/H = mommy.source
	if(!H.client)
		return FALSE
	if(z != H.z)
		return FALSE
	if(get_dist(H, src) > SSchat.max_horny_distance) //If they're not right next to you, don't hornify them
		return FALSE
	return TRUE // lets get yiffy



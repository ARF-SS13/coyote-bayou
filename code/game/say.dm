/*
Miauw's big Say() rewrite.
This file has the basic atom/movable level speech procs.
And the base of the send_speech() proc, which is the core of saycode.
*/
/* 
Dan's even bigger Say() rewrite.
 */

/// takes in a chunk of data and constructs a mommy chat object
/atom/movable/proc/MovableSay2Mommy(message, language, list/spans = list(), sanitize, forced, only_overhead)
	var/datum/rental_mommy/chat/momchat = SSrentaldatums.CheckoutChatMommy()
	momchat.original_message = message
	momchat.message = momchat.original_message
	momchat.original_speakername = GetVoice()
	momchat.speakername = momchat.original_speakername
	momchat.source = src
	momchat.message_mode = MODE_SAY
	momchat.message_key = ""
	momchat.spans = spans.Copy()
	momchat.sanitize = sanitize
	momchat.language = language
	momchat.forced = forced
	momchat.only_overhead = only_overhead
	momchat.close_message_range = SSchat.base_say_distance
	momchat.far_message_range = SSchat.extended_say_distance
	momchat.source_quid = extract_quid(src)
	momchat.source_ckey = extract_ckey(src)
	return momchat

/atom/movable/proc/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, only_overhead)
	if(!SSrentaldatums.initialized)
		return
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_selected_language()
	var/datum/rental_mommy/chat/momchat = MovableSay2Mommy(message, language, spans, sanitize, forced, only_overhead)
	send_speech(momchat)
	if(momchat)
		momchat.checkin()

/atom/movable/proc/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source, only_overhead, list/data)
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args)

/atom/movable/proc/can_speak()
	return 1

/atom/movable/proc/send_speech(datum/rental_mommy/chat/momchat)
	if(!momchat)
		CRASH("send_speech() called with no momchat")
	var/rendered = compose_message(src, momchat.language, momchat.message, , momchat.spans, momchat.message_mode, momchat.source, list("momchat" = momchat))
	for(var/_AM in get_hearers_in_view(momchat.close_message_range, momchat.source))
		var/atom/movable/AM = _AM
		AM.Hear(rendered, src, momchat.language, momchat.message, , momchat.spans, momchat.message_mode, momchat.source, momchat.only_overhead)

/atom/movable/proc/compose_message(
	atom/movable/speaker,
	datum/language/message_language,
	raw_message,
	radio_freq,
	list/spans= list(),
	message_mode,
	face_name = FALSE,
	atom/movable/source,
	list/data = list()
) // 9 ARGS! 15 BUTTS!!!! SECRET THIRD LEG!!!!!!!!
	if(!source)
		source = speaker
	var/datum/rental_mommy/chat/momchat = LAZYACCESS(data, "momchat")
	if(!momchat)
		momchat = SSrentaldatums.CheckoutChatMommy()
		momchat.original_message = raw_message
		momchat.message = momchat.original_message
		momchat.message_mode = message_mode
		momchat.radio_freq = radio_freq
		momchat.spans = spans.Copy()
		momchat.sanitize = TRUE
		momchat.source = source
		momchat.language = message_language
		momchat.face_name = face_name
		data["momchat"] = null //Prevent infinite recursion
		momchat.data = data.Copy()
	//This proc uses text() because it is faster than appending strings. Thanks BYOND.
	//Basic span
	var/outer_span = "[radio_freq ? get_radio_span(radio_freq) : "game say"]"
	var/spanpart1 = "<span class='[outer_span]'>"
	if(momchat)
		momchat.outer_span_class = outer_span
		momchat.outer_span = spanpart1
	//Start name span.
	var/spanpart2 = "<span class='name'>"
	if(momchat)
		momchat.name_span_class = "name"
		momchat.name_span = spanpart2
	//Radio freq/name display
	var/freqpart = radio_freq ? "\[[get_radio_name(radio_freq)]\] " : ""
	if(momchat)
		momchat.freqpart = freqpart
	//Speaker name
	var/namepart = "[speaker.GetVoice()][speaker.get_alt_name()]"
	if(face_name && ishuman(speaker))
		var/mob/living/carbon/human/H = speaker
		namepart = "[H.get_face_name()]" //So "fake" speaking like in hallucinations does not give the speaker away if disguised
	if(momchat)
		momchat.speakername = namepart
		momchat.original_speakername = namepart
	//End name span.
	var/endspanpart = "</span>"
	
	//Message
	var/messagepart = " <span class='message'>[lang_treat(speaker, message_language, raw_message, spans, message_mode, null, momchat)]</span></span>"

	var/languageicon = ""
	var/datum/language/D = GLOB.language_datum_instances[message_language]
	if(istype(D) && D.display_icon(src))
		languageicon = "[D.get_icon()] "
	if(momchat)
		momchat.language_icon = languageicon

	return "[spanpart1][spanpart2][freqpart][languageicon][compose_track_href(speaker, namepart)][namepart][compose_job(speaker, message_language, raw_message, radio_freq)][endspanpart][messagepart]"

/atom/movable/proc/compose_track_href(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/say_mod(input, message_mode)
	var/ending = copytext_char(input, -1)
	var/beginning = copytext_char(input, 1)
	if(message_mode == MODE_WHISPER || beginning == "#")
		. = verb_whisper
	else if(message_mode == MODE_SING)
		. = verb_sing
	else if(message_mode == MODE_YELL || copytext_char(input, -2) == "!!" || beginning == "$")
		. = verb_yell
	else if(message_mode == MODE_ASK || ending == "?")
		. = verb_ask
	else if(message_mode == MODE_EXCLAIM || ending == "!")
		. = verb_exclaim
	else
		. = verb_say
	return get_random_if_list(.)

/atom/movable/proc/say_quote(input, list/spans=list(speech_span), message_mode, datum/rental_mommy/chat/momchat)
	if(!input)
		input = "..."

	if(copytext_char(input, -2) == "!!")
		spans |= SPAN_YELL
		if(momchat)
			momchat.spans |= SPAN_YELL

	var/spanned = attach_spans(input, spans)
	var/saymod = say_mod(input, momchat ? momchat.message_mode : message_mode)
	if(momchat)
		if(!momchat.message_langtreated_spanned)
			momchat.message_langtreated_spanned = spanned
		if(!momchat.message_langtreated_spanned_quotes)
			momchat.message_langtreated_spanned_quotes = "\"[spanned]\""
			momchat.message = momchat.message_langtreated_spanned_quotes
		momchat.message_saymod = saymod
		if(spanned)
			momchat.message_saymod_comma = "[saymod], "
	return "[saymod][spanned ? ", \"[spanned]\"" : ""]"
	// Citadel edit [spanned ? ", \"[spanned]\"" : ""]"

#define ENCODE_HTML_EPHASIS(input, char, html, varname) \
	var/static/regex/##varname = regex("[char]{2}(.+?)[char]{2}", "g");\
	input = varname.Replace_char(input, "<[html]>$1</[html]>")

/// Converts specific characters, like +, |, and _ to formatted output.
/atom/movable/proc/say_emphasis(input)
	var/static/regex/italics = regex(@"\|((?=\S)[\w\W]*?(?<=\S))\|", "g")
	input = italics.Replace_char(input, "<i>$1</i>")
	var/static/regex/bold = regex(@"\+((?=\S)[\w\W]*?(?<=\S))\+", "g")
	input = bold.Replace_char(input, "<b>$1</b>")
	var/static/regex/underline = regex(@"_((?=\S)[\w\W]*?(?<=\S))_", "g")
	input = underline.Replace_char(input, "<u>$1</u>")
	return input

/atom/movable/proc/say_narrate_replace(input, atom/thing)
	if(!istype(thing))
		return
	if(findtext(input, "@"))
		. = replacetext(input, "@", "<b>[thing.name]</b>")
	return

/// Quirky citadel proc for our custom sayverbs to strip the verb out. Snowflakey as hell, say rewrite 3.0 when?
/atom/movable/proc/quoteless_say_quote(input, list/spans = list(speech_span), message_mode, datum/rental_mommy/chat/momchat)
	if((input[1] == "!") && (length_char(input) > 1))
		if(momchat)
			momchat.message_langtreated_quoteless = input
			momchat.message = input
		return ""
	var/pos = findtext(input, "*")
	var/message = pos? copytext(input, 1, pos - 1) : input
	if(momchat)
		momchat.message_langtreated_quoteless = message
		momchat.message = message
	return message

/// This proc is used to treat the language of a message. It will either scramble the message or leave it as is.
/// it will also do like 5 other things totally unrelated to language, because why not.
/atom/movable/proc/lang_treat(
	atom/movable/speaker,
	datum/language/language,
	raw_message,
	list/spans,
	message_mode,
	no_quote = FALSE,
	datum/rental_mommy/chat/momchat,
)
	if(has_language(language))
		var/atom/movable/AM = speaker.GetSource()
		raw_message = say_emphasis(raw_message)
		var/msg_out
		if(AM) //Basically means "if the speaker is virtual"
			if(no_quote)
				msg_out = AM.quoteless_say_quote(raw_message, spans, message_mode, momchat)
			else // ^ V these used to be ternary operators that were so long they burst out of my sweatpants
				msg_out = AM.say_quote(raw_message, spans, message_mode, momchat)
			if(momchat)
				momchat.message_langtreated_with_verb = msg_out
			return msg_out
		else
			if(no_quote)
				msg_out = speaker.quoteless_say_quote(raw_message, spans, message_mode, momchat)
			else
				msg_out = speaker.say_quote(raw_message, spans, message_mode, momchat)
			if(momchat)
				momchat.message_langtreated_with_verb = msg_out
			return msg_out
	else if(language)
		var/atom/movable/AM = speaker.GetSource()
		var/datum/language/D = GLOB.language_datum_instances[language]
		raw_message = D.scramble(raw_message)
		var/msg_out
		if(AM)
			if(no_quote)
				msg_out = AM.quoteless_say_quote(raw_message, spans, message_mode, momchat)
			else
				msg_out = AM.say_quote(raw_message, spans, message_mode, momchat)
			if(momchat)
				momchat.message_langtreated_with_verb = msg_out
			return msg_out
		else
			if(no_quote)
				msg_out = speaker.quoteless_say_quote(raw_message, spans, message_mode, momchat)
			else
				msg_out = speaker.say_quote(raw_message, spans, message_mode, momchat)
			if(momchat)
				momchat.message_langtreated_with_verb = msg_out
			return msg_out
	else
		return "makes a strange sound."

/proc/get_radio_span(freq)
	var/returntext = GLOB.freqtospan["[freq]"]
	if(returntext)
		return returntext
	return "radio"

/proc/get_radio_name(freq)
	var/returntext = GLOB.reverseradiochannels["[freq]"]
	if(returntext)
		return returntext
	return make_radio_name(freq)
	//return "[copytext_char("[freq]", 1, 4)].[copytext_char("[freq]", 4, 5)]"

/proc/make_radio_name(freq)
	if(freq in GLOB.reverseradiochannels)
		return GLOB.reverseradiochannels["[freq]"]
	var/channel_number = rand(1,9999)
	GLOB.reverseradiochannels["[freq]"] = "CH-[channel_number]"
	return GLOB.reverseradiochannels["[freq]"]
	

/atom/movable/proc/attach_spans(input, list/spans)
	var/customsayverb = findtext(input, "*")
	if(customsayverb)
		input = capitalize(copytext(input, customsayverb + length(input[customsayverb])))

	if((input[1] == "!") && (length(input) > 2))
		return
	if(!length(spans) || isnull(spans[1]) && !customsayverb)
		return input
	if(input)
		return "[message_spans_start(spans)][input]</span>"
	else
		return

/proc/message_spans_start(list/spans)
	var/output = "<span class='"
	for(var/S in spans)
		output = "[output][S] "
	output = "[output]'>"
	return output

/proc/say_test(text)
	var/ending = copytext_char(text, -1)
	if (ending == "?")
		return "1"
	else if (ending == "!")
		return "2"
	return "0"

/atom/movable/proc/GetVoice()
	return "[src]"	//Returns the atom's name, prepended with 'The' if it's not a proper noun

/atom/movable/proc/IsVocal()
	return 1

/atom/movable/proc/get_alt_name()

//HACKY VIRTUALSPEAKER STUFF BEYOND THIS POINT
//these exist mostly to deal with the AIs hrefs and job stuff.

/atom/movable/proc/GetJob() //Get a job, you lazy butte

/atom/movable/proc/GetSource()

/atom/movable/proc/GetRadio()

//VIRTUALSPEAKERS
/atom/movable/virtualspeaker
	var/job
	var/atom/movable/source
	var/obj/item/radio/radio
	var/chatcolor

INITIALIZE_IMMEDIATE(/atom/movable/virtualspeaker)
/atom/movable/virtualspeaker/Initialize(mapload, atom/movable/M, radio)
	. = ..()
	radio = radio
	source = M
	if (istype(M))
		name = M.GetVoice()
		verb_say = M.verb_say
		verb_ask = M.verb_ask
		verb_exclaim = M.verb_exclaim
		verb_yell = M.verb_yell
		chatcolor = M.get_chat_color()

	// The mob's job identity
	if(ishuman(M))
		// Humans use their job as seen on the crew manifest. This is so the AI
		// can know their job even if they don't carry an ID.
		var/datum/data/record/findjob = find_record("name", name, GLOB.data_core.general)
		if(findjob)
			job = findjob.fields["rank"]
		else
			job = "Unknown"
	else if(iscarbon(M))  // Carbon nonhuman
		job = "No ID"
	else if(isAI(M))  // AI
		job = "AI"
	else if(iscyborg(M))  // Cyborg
		var/mob/living/silicon/robot/B = M
		job = "[B.designation] Cyborg"
	else if(istype(M, /mob/living/silicon/pai))  // Personal AI (pAI)
		job = "Personal AI"
	else if(isobj(M))  // Cold, emotionless machines
		job = "Machine"
	else  // Unidentifiable mob
		job = "Unknown"

/atom/movable/virtualspeaker/GetJob()
	return job

/atom/movable/virtualspeaker/GetSource()
	return source

/atom/movable/virtualspeaker/GetRadio()
	return radio

//To get robot span classes, stuff like that.
/atom/movable/proc/get_spans()
	return list()

/atom/movable/virtualspeaker/get_chat_color()
	return chatcolor

/**
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

SUBSYSTEM_DEF(chat)
	name = "Chat"
	flags = SS_TICKER
	wait = 1
	priority = FIRE_PRIORITY_CHAT
	init_order = INIT_ORDER_CHAT

	var/list/payload_by_client = list()
	/// All the lookups for translating emotes to say prefixes
	var/list/emoticon_cache = list()

/datum/controller/subsystem/chat/Initialize(start_timeofday)
	setup_emoticon_cache()
	. = ..()
	spawn(5 SECONDS)
		to_chat(world, span_boldnotice("Initialized [LAZYLEN(emoticon_cache)] emoticons! ;D"))

/datum/controller/subsystem/chat/proc/setup_emoticon_cache()
	emoticon_cache.Cut()
	var/json_emoticons = file2text("strings/sausage_rolls.json") // am hungy
	/* 
	 * FORMAT:
	":)" = list(
		"SAY" = list(
			"MESSAGE" = list(
				"smiles, and SAYVERBS"
			),
			"EMOTE" = list(
				"smiles."
			),
		),
		"WHISPER" = list(
			"MESSAGE" = list(
				"smiles, and WHISPERVERBS"
			),
			"EMOTE" = list(
				"smiles."
			),
		),
		"SING" = list(
			"MESSAGE" = list(
				"smiles, and SINGVERBS"
			),,
			"EMOTE" = list(
				"smiles."
			),
		),
		"ASK" = list(
			"MESSAGE" = list(
				"smiles, and ASKVERBS"
			),
			"EMOTE" = list(
				"smiles?"
			),
		),
		"EXCLAIM" = list(
			"MESSAGE" = list(
				"smiles, and EXCLAIMVERBS"
			),
			"EMOTE" = list(
				"smiles!"
			),
		),
		"YELL" = list(
			"MESSAGE" = list(
				"smiles, and YELLVERBS"
			),
			"EMOTE" = list(
				"<b>smiles!!!</b>"
			),
		),
		"ALIASES": [
			":-)",
			"'u'"
		),
	),
	*/
	var/list/emoticons = safe_json_decode(json_emoticons)
	if(!LAZYLEN(emoticons))
		return // :(
	for(var/emo in emoticons)
		var/list/emotilist = emoticons[emo]
		var/list/emoties = list()
		emoties |= emo
		for(var/emotie in emotilist["ALIASES"])
			emoties |= emotie
		for(var/emotie in emoties)
			var/datum/emoticon_bank/E = new(emo, emotilist)
			emoticon_cache[html_decode(emotie)] = E

/datum/controller/subsystem/chat/proc/emoticonify(atom/movable/sayer, message, messagemode, list/spans)
	if(!sayer)
		return
	if(istype(sayer, /mob))
		var/mob/they = sayer
		if(!they.client)
			return
	var/out
	var/datum/emoticon_bank/E
	for(var/key in emoticon_cache) // if this gets laggy, lol idk
		if(findtext(message, key))
			E = LAZYACCESS(emoticon_cache, key)
			if(!E)
				continue
			out = E.verbify(sayer, message, messagemode, spans)
			if(out)
				break
	if(!out)
		return
	for(var/key in emoticon_cache)
		out = replacetext(out, key, "") // remove the rest of the emoticons
	return out

/datum/controller/subsystem/chat/fire()
	for(var/key in payload_by_client)
		var/client/client = key
		var/payload = payload_by_client[key]
		payload_by_client -= key
		if(client)
			if(payload["prefCheck"] && CHECK_PREFS(client, payload["prefCheck"]))
				continue // we dont want to see it
			// Send to tgchat
			client.tgui_panel?.window.send_message("chat/message", payload)
			// Send to old chat
			for(var/message in payload)
				SEND_TEXT(client, message_to_html(message))
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/chat/proc/queue(target, message)
	if(islist(target))
		for(var/_target in target)
			var/client/client = CLIENT_FROM_VAR(_target)
			if(client)
				LAZYADD(payload_by_client[client], list(message))
		return
	var/client/client = CLIENT_FROM_VAR(target)
	if(client)
		LAZYADD(payload_by_client[client], list(message))

/datum/emoticon_bank
	var/key = ""
	var/list/say_messages = list()
	var/list/say_emotes = list()
	var/list/whisper_messages = list()
	var/list/whisper_emotes = list()
	var/list/sing_messages = list()
	var/list/sing_emotes = list()
	var/list/ask_messages = list()
	var/list/ask_emotes = list()
	var/list/exclaim_messages = list()
	var/list/exclaim_emotes = list()
	var/list/yell_messages = list()
	var/list/yell_emotes = list()

/datum/emoticon_bank/New(smiley, list/emot)
	. = ..()
	if(!islist(emot))
		return
	key = smiley
	var/list/saychunk = LAZYACCESS(emot, "SAY")
	say_messages = LAZYACCESS(saychunk, "MESSAGE")
	say_emotes = LAZYACCESS(saychunk, "EMOTE")
	var/list/whisperchunk = LAZYACCESS(emot, "WHISPER")
	whisper_messages = LAZYACCESS(whisperchunk, "MESSAGE")
	whisper_emotes = LAZYACCESS(whisperchunk, "EMOTE")
	var/list/singchunk = LAZYACCESS(emot, "SING")
	sing_messages = LAZYACCESS(singchunk, "MESSAGE")
	sing_emotes = LAZYACCESS(singchunk, "EMOTE")
	var/list/askchunk = LAZYACCESS(emot, "ASK")
	ask_messages = LAZYACCESS(askchunk, "MESSAGE")
	ask_emotes = LAZYACCESS(askchunk, "EMOTE")
	var/list/exclaimchunk = LAZYACCESS(emot, "EXCLAIM")
	exclaim_messages = LAZYACCESS(exclaimchunk, "MESSAGE")
	exclaim_emotes = LAZYACCESS(exclaimchunk, "EMOTE")
	var/list/yellchunk = LAZYACCESS(emot, "YELL")
	yell_messages = LAZYACCESS(yellchunk, "MESSAGE")
	yell_emotes = LAZYACCESS(yellchunk, "EMOTE")

	var/list/newsay_messages = list()
	for(var/msg in say_messages)
		newsay_messages += html_decode(msg)
	say_messages = newsay_messages
	var/list/newsay_emotes = list()
	for(var/msg in say_emotes)
		newsay_emotes += html_decode(msg)
	say_emotes = newsay_messages
	var/list/newwhisper_messages = list()
	for(var/msg in whisper_messages)
		newwhisper_messages += html_decode(msg)
	whisper_messages = newsay_messages
	var/list/newwhisper_emotes = list()
	for(var/msg in whisper_emotes)
		newwhisper_emotes += html_decode(msg)
	whisper_emotes = newsay_messages
	var/list/newsing_messages = list()
	for(var/msg in sing_messages)
		newsing_messages += html_decode(msg)
	sing_messages = newsay_messages
	var/list/newsing_emotes = list()
	for(var/msg in sing_emotes)
		newsing_emotes += html_decode(msg)
	sing_emotes = newsay_messages
	var/list/newask_messages = list()
	for(var/msg in ask_messages)
		newask_messages += html_decode(msg)
	ask_messages = newsay_messages
	var/list/newask_emotes = list()
	for(var/msg in ask_emotes)
		newask_emotes += html_decode(msg)
	ask_emotes = newsay_messages
	var/list/newexclaim_messages = list()
	for(var/msg in exclaim_messages)
		newexclaim_messages += html_decode(msg)
	exclaim_messages = newsay_messages
	var/list/newexclaim_emotes = list()
	for(var/msg in exclaim_emotes)
		newexclaim_emotes += html_decode(msg)
	exclaim_emotes = newsay_messages
	var/list/newyell_messages = list()
	for(var/msg in yell_messages)
		newyell_messages += html_decode(msg)
	yell_messages = newsay_messages
	var/list/newyell_emotes = list()
	for(var/msg in yell_emotes)
		newyell_emotes += html_decode(msg)
	yell_emotes = newsay_messages

/// takes in a message, extracts what the intent of the message is (say, ask, etc)
/// removes the emoticon, and returns a prefix to be used in the message
/// Also checks if its just the emoticon, and if so, return the emote message
/datum/emoticon_bank/proc/verbify(atom/movable/emoter, message, messagemode, list/spans = list())
	if(messagemode == MODE_CUSTOM_SAY)
		return // they'll handle it
	if(!emoter)
		return
	if(!findtext(message, key))
		return
	/// first lets check if its just the emoticon
	var/msg_sample = ckey(replacetext(message, key, ""))
	var/is_msg = msg_sample != ""
	var/is_emote = !is_msg
	var/foreverb = "smiles and nods"
	var/msgs = say_messages
	var/emts = say_emotes
	/// find the message mode / intent, if it isnt given (often isnt)
	if(!messagemode)
		/// okay now lets scan this message for intent
		var/list/characters = splittext(replacetext(message, key, ""), "") // minus the emoticon
		messagemode = MODE_SAY
		for(var/i in 1 to LAZYLEN(characters))
			var/char = characters[i]
			switch(char)
				if("?")
					messagemode = MODE_ASK
					if(LAZYACCESS(characters, i+1) == "!") // ?!
						break
				if("!")
					messagemode = MODE_EXCLAIM
					if(LAZYACCESS(characters, i+1) == "!") // !!
						messagemode = MODE_YELL
						break
					if(LAZYACCESS(characters, i+1) == "?" && LAZYACCESS(characters, i-1) != "!") // !?
						messagemode = MODE_ASK
						break

	switch(messagemode)
		if(MODE_SAY)
			msgs = say_messages
			emts = say_emotes
		if(MODE_WHISPER)
			msgs = whisper_messages
			emts = whisper_emotes
		if(MODE_SING)
			msgs = sing_messages
			emts = sing_emotes
		if(MODE_ASK)
			msgs = ask_messages
			emts = ask_emotes
		if(MODE_EXCLAIM)
			msgs = exclaim_messages
			emts = exclaim_emotes
		if(MODE_YELL)
			msgs = yell_messages
			emts = yell_emotes
			spans |= SPAN_YELL
	if(is_msg)
		if(LAZYLEN(msgs))
			foreverb = pick(msgs)
		else
			switch(messagemode)
				if(MODE_SAY)
					foreverb = emoter.verb_say
				if(MODE_WHISPER)
					foreverb = emoter.verb_whisper
				if(MODE_SING)
					foreverb = emoter.verb_sing
				if(MODE_ASK)
					foreverb = emoter.verb_ask
				if(MODE_EXCLAIM)
					foreverb = emoter.verb_exclaim
				if(MODE_YELL)
					foreverb = emoter.verb_yell
		foreverb = "[foreverb]," // the comma is important
	if(is_emote)
		if(LAZYLEN(emts))
			foreverb = pick(emts)
		else
			switch(messagemode)
				if(MODE_SAY)
					foreverb = emoter.verb_say
				if(MODE_WHISPER)
					foreverb = emoter.verb_whisper
				if(MODE_SING)
					foreverb = emoter.verb_sing
				if(MODE_ASK)
					foreverb = emoter.verb_ask
				if(MODE_EXCLAIM)
					foreverb = emoter.verb_exclaim
				if(MODE_YELL)
					foreverb = emoter.verb_yell
		foreverb = "[foreverb]" // the dot is important
	foreverb = replacify(emoter, foreverb, messagemode)
	/// foreverv is built! now lets tidy up the message block.
	if(is_emote)
		return emoter.attach_spans(foreverb, spans) // sike

	/// so we need to surgically extract our emoticon from the message. Easy? sorta, but we need to clean ourself up
	/// lets say the message is "hi :) how are you?" and the emoticon is ":)"
	/// we need to remove the emoticon, but that would leave us with "hi  how are you?", with two spaces
	/// so we need to remove the emoticon, and then remove any extra spaces, but not too many spaces!
	/// also this case: "hi how are you? :)" would leave us with "hi how are you? ", with a space at the end
	var/list/frontback = splittext(message, key) // split the message into two parts, before and after the emoticon
	if(LAZYLEN(frontback) != 2)
		return /// RRRRGH
	if(LAZYLEN(ckey(frontback[1])) < 1) // if the emoticon is at the start of the message, we need to remove the space at the start
		frontback[1] = ckey(frontback[1]) // remove the space
	if(LAZYLEN(ckey(frontback[2])) < 1) // if the emoticon is at the end of the message, we need to remove the space and punctuation at the end
		frontback[2] = ckey(frontback[2]) // remove the space and punctuation
	var/middlepart = "[frontback[1]][frontback[2]]"
	// clean up any extra spaces
	middlepart = replacetext(middlepart, "  ", " ") // remove double spaces
	// clean up any extra spaces at the end
	middlepart = trim(middlepart)
	if(isliving(emoter))
		var/mob/living/emo = emoter
		middlepart = emo.treat_message(middlepart)
	/// if the message now has a space and a period at the end, remove the space
	/// Now assemble the message! We have our prefix, and our middlepart, and we need to put them together
	/// add spans, add quotes, and that's it!
	middlepart = emoter.attach_spans("\"[middlepart]\"", spans)
	return "[foreverb] [middlepart]"

/datum/emoticon_bank/proc/replacify(atom/movable/emoter, message, messagemode)
	if(!emoter)
		return
	switch(messagemode)
		if(MODE_SAY)
			message = replacetext(message, "SAYVERBS", emoter.verb_say)
		if(MODE_WHISPER)
			message = replacetext(message, "WHISPERVERBS", emoter.verb_whisper)
		if(MODE_SING)
			message = replacetext(message, "SINGVERBS", emoter.verb_sing)
		if(MODE_ASK)
			message = replacetext(message, "ASKVERBS", emoter.verb_ask)
		if(MODE_EXCLAIM)
			message = replacetext(message, "EXCLAIMVERBS", emoter.verb_exclaim)
		if(MODE_YELL)
			message = replacetext(message, "YELLVERBS", emoter.verb_yell)
	message = replacetext(message, "THEIR", emoter.p_their())
	return message

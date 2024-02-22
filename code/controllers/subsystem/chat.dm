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

	/// all the wacky ass flirt datums we have in existence
	var/list/flirts = list()
	/// A cached mass of jsonified flirt datums, for TGUI
	var/list/flirt_for_tgui = list() // flirt for me, flirt for me, flirt flirt

	/// list of flirt ckey things so that we can store their target or something
	/// format: list("flirterckey" = "targetckey")
	var/list/active_flirters = list()

/datum/controller/subsystem/chat/Initialize(start_timeofday)
	setup_emoticon_cache()
	build_flirt_datums()
	. = ..()
	spawn(5 SECONDS)
		to_chat(world, span_boldnotice("Initialized [LAZYLEN(emoticon_cache)] emoticons! ;D"))
		to_chat(world, span_boldnotice("Initialized [LAZYLEN(flirts)] flirty messages! <3"))


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
	if(!(messagemode in list(MODE_SAY, MODE_WHISPER, MODE_SING, MODE_ASK, MODE_EXCLAIM, MODE_YELL)))
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

/datum/controller/subsystem/chat/proc/build_flirt_datums()
	flirts = list()
	var/list/jsonafex = safe_json_decode(file2text("strings/flirts.json"))
	if(!LAZYLEN(jsonafex))
		return
	for(var/list/flirtz in jsonafex)
		if(!LAZYACCESS(flirtz, "key"))
			continue
		new /datum/flirt(flirtz) // it knows what to do

/datum/controller/subsystem/chat/proc/run_directed_flirt(mob/living/flirter, mob/living/target, flirtkey)
	if(!istype(flirter) ||!istype(target) || !flirtkey)
		return
	var/datum/flirt/flirt = LAZYACCESS(flirts, flirtkey)
	if(!flirt)
		return
	return flirt.flirt_directed(flirter, target)

/datum/controller/subsystem/chat/proc/run_aoe_flirt(mob/living/flirter, flirtkey)
	if(!istype(flirter) ||!flirtkey)
		return
	var/datum/flirt/flirt = LAZYACCESS(flirts, flirtkey)
	if(!flirt)
		return
	return flirt.flirt_aoe(flirter)

/datum/controller/subsystem/chat/proc/add_flirt_target(mob/living/flirter, mob/living/target)
	if(!istype(flirter) ||!istype(target))
		return
	if(!flirter.ckey ||!target.ckey)
		return
	if(!flirter.client ||!target.client)
		return
	active_flirters[flirter.ckey] = target.ckey
	return TRUE

/datum/controller/subsystem/chat/proc/remove_flirt_target(mob/living/flirter)
	if(!istype(flirter))
		return
	if(!flirter.ckey)
		return
	if(!flirter.client)
		return
	active_flirters -= flirter.ckey
	return TRUE

/datum/controller/subsystem/chat/proc/get_flirt_target(mob/living/flirter)
	if(!istype(flirter))
		return
	if(!flirter.ckey)
		return
	if(!flirter.client)
		return
	var/target_ckey = LAZYACCESS(active_flirters, flirter.ckey)
	if(!target_ckey)
		return
	return ckey2mob(target_ckey)

/// YES IM BLOWING CHAT'S TGUI LOAD ON FLIRTING, FIGHT ME
/datum/controller/subsystem/chat/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Flirt")
		ui.open()

/// just holds the reader's target, if any
/datum/controller/subsystem/chat/ui_data(mob/user)
	var/list/data = list()
	var/mob/living/heart = get_flirt_target(user)
	data["flirt_target"] = heart? heart.name : "Nobody in particular"
	return data

/// holds the whole enchilada
/datum/controller/subsystem/chat/ui_static_data(mob/user)
	var/list/static_data = list()
	static_data |= flirt_for_tgui
	return static_data

/datum/controller/subsystem/chat/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/datum/flirt/F = LAZYACCESS(flirts, params["flirt_key"])
	if(!F)
		return TRUE // no flirt found
	var/mob/living/flirter = ckey2mob(params["flirter_ckey"])
	if(!flirter)
		return // nobody flirted
	var/mob/living/target = ckey2mob(params["flirttarget_ckey"])
	var/give_item = !!target // no target, give them an item to flirt at someone with
	switch(action)
		if("do_directed_flirt")
			if(give_item)
				return F.give_item(flirter, target)
			else
				return F.flirt_directed(flirter, target)
		if("do_aoe_flirt")
			return F.flirt_aoe(flirter)

/datum/controller/subsystem/chat/proc/can_usr_flirt_with_this(atom/A)
	var/mob/flirter = usr // fight me
	if(!isliving(usr)) 
		to_chat(usr, span_hypnophrase("Touch grass, you ghostly fucker. Spawn in to swap spit with them."))
		return
	if(isanimal(A) && !A.client)
		if(prob(1))
			to_chat(usr, span_hypnophrase("You're having a white woman moment."))
		else if(prob(10))
			to_chat(usr, span_hypnophrase("They probably wouldn't pass the Harkness test."))
		else
			to_chat(usr, span_hypnophrase("They're not in the right mood for flirting."))
		return
	if(A == usr)
		to_chat(usr, span_hypnophrase("You take a deep breath and psyche yourself up to flirt with someone other than yourself for a change. You got this, tiger!"))
		return
	return TRUE

/mob/verb/check_out(mob/A as mob in view())
	set name = "Flirt with"
	set category = "IC"

	if(!SSchat.can_usr_flirt_with_this(A))
		return
	to_chat(src, span_notice("You get ready to flirt with [A]. What will you do?"))
	SSchat.ui_interact(src)

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


/datum/flirt
	var/key = "hi"
	var/flirtname = "Loveletter to Coderbus"
	var/flirtdesc = "I am a coderbus, and I love you!"
	/// What it looks like in ur hand
	var/flirticon = "icons/mob/actions.dmi"
	var/flirticon_state = "velvet_chords"
	/// What it says when its put in ur hand
	var/give_message = "You get ready to flirt!"
	var/give_message_span = "love"
	/// displayed to the flirted self
	var/self_message = "You flirt with %TARGET%! How sweet."
	var/self_message_span = "love" // check them out in spans.dm!
	/// displayed to the flirted target
	var/target_message = "You notice %FLIRTER% flirting with you! How sweet."
	var/target_message_span = "love"
	/// displayed when you use the emote item in hand to broadcast a general flirt
	var/aoe_message
	var/aoe_message_span
	/// what category is this thing?
	var/category = "I need a category!! uwu"
	/// sound it makes to us bolth
	var/sound_to_do = "sound/items/bikehorn.ogg"


/datum/flirt/New(list/json_flirt)
	. = ..()
	if(!LAZYLEN(json_flirt))
		qdel(src)
		return
	if(!get_flirty(json_flirt))
		qdel(src)
		return
	SSchat.flirts[key] = src
	SSchat.flirt_for_tgui |= list(format_for_tgui())

/// turns this thing into a differentiated flort
/datum/flirt/proc/get_flirty(list/json_flirt)
	key = LAZYACCESS(json_flirt["key"])
	if(!key)
		return
	flirtname = LAZYACCESS(json_flirt["name"]) || "Loveletter to Coderbus"
	flirtdesc = LAZYACCESS(json_flirt["desc"]) || "Send them a cute little letter asking if they'd like to file a bug report with you!"
	flirticon = LAZYACCESS(json_flirt["icon"]) || "icons/mob/actions.dmi"
	flirticon_state = LAZYACCESS(json_flirt["icon_state"]) || "velvet_chords"
	give_message = LAZYACCESS(json_flirt["give_message"]) || "You get out your GitHub issues!"
	give_message_span = LAZYACCESS(json_flirt["give_message_span"]) || "love"
	self_message = LAZYACCESS(json_flirt["self_message"]) || "You ask %TARGET% if they'd like to file a bug report with you!"
	self_message_span = LAZYACCESS(json_flirt["self_message_span"]) || "love"
	target_message = LAZYACCESS(json_flirt["target_message"]) || "You notice %FLIRTER% asking if they'd like to file a bug report with you!"
	target_message_span = LAZYACCESS(json_flirt["target_message_span"]) || "love"
	aoe_message = LAZYACCESS(json_flirt["aoe_message"]) || "" // this one can be null and a-okay
	aoe_message_span = LAZYACCESS(json_flirt["aoe_message_span"]) || "love"
	category = LAZYACCESS(json_flirt["category"]) || "I need a category!! uwu"
	sound_to_do = LAZYACCESS(json_flirt["sound_to_do"]) || "" // this one can also be null and a-okay
	return TRUE




/datum/flirt/proc/flirt_directed(mob/living/flirter, mob/living/target)
	/// flirting for me~
	var/msg_to_me = "<span class='[self_message_span]'>[self_message]</span>"
	/// flirting for you~
	var/msg_to_you = "<span class='[target_message_span]'>[target_message]</span>"
	// I'll have a flirt, you have one too!
	msg_to_me = replacetextEx(msg_to_me, "%FLIRTER%", "[flirter]")
	msg_to_you = replacetextEx(msg_to_you, "%FLIRTER%", "[target]")

	msg_to_me = replacetextEx(msg_to_me, "%TARGET%", "[target]")
	msg_to_you = replacetextEx(msg_to_you, "%TARGET%", "[flirter]")
	/// dooesnt support pronouns cus idk
	to_chat(flirter, msg_to_me)
	to_chat(target, msg_to_you)
	return TRUE

/datum/flirt/proc/flirt_aoe(mob/living/flirter)
	if(!aoe_message)
		to_chat(flirter, span_warning("That flirt doesnt really work without a specific person in mind, try it on that cutie over there!"))
		return FALSE
	var/msg_to_everyone = "<span class='[aoe_message_span]'>[aoe_message]</span>"
	msg_to_everyone = replacetextEx(msg_to_everyone, "%FLIRTER%", "[flirter]")
	flirter.visible_message(
		msg_to_everyone,
		blind_message = msg_to_everyone, // love is blind
	)
	return TRUE

/datum/flirt/proc/give_flirter(mob/living/flirter)
	if(flirter.get_active_held_item() && flirter.get_inactive_held_item())
		to_chat(flirter, span_warning("Your hands are too full to flirt! Yes, you need your hands to flirt."))
		return

	var/obj/item/hand_item/flirter/hiya = new(flirter)
	if(!hiya.flirtify(src))
		to_chat(flirter, span_warning("Something went wrong! Try a different approach~"))
		return

	if(flirter.put_in_hands(hiya)) // NOTE: put_in_hand is MUCH different from put_in_hands - NOTE THE S
		to_chat(flirter, span_notice("[give_message]"))
		return TRUE
	else
		to_chat(flirter, span_warning("Something went wrong! Try a different approach~"))
		qdel(hiya)

/datum/flirt/proc/format_for_tgui()
	var/list/data = list()
	data["key"] = key
	data["name"] = flirtname
	data["desc"] = flirtdesc
	var/msg_me = "<span class='[self_message_span]'>[self_message]</span>"
	msg_me = replacetextEx(msg_me, "%FLIRTER%", "YOU")
	msg_me = replacetextEx(msg_me, "%TARGET%", "THEM")
	data["message_me"] = msg_me
	var/msg_you = "<span class='[target_message_span]'>[target_message]</span>"
	msg_you = replacetextEx(msg_you, "%FLIRTER%", "THEM")
	msg_you = replacetextEx(msg_you, "%TARGET%", "YOU")
	data["message_you"] = msg_you
	var/msg_everyone = "<span class='[aoe_message_span]'>[aoe_message]</span>"
	msg_everyone = replacetextEx(msg_everyone, "%FLIRTER%", "THEM")
	data["message_everyone"] = msg_everyone
	return data


///////////////////////////////////////////////////
//// FLIRT ITEM ///////////////////////////////////
/obj/item/hand_item/flirter
	name = "Flirtification Device"
	desc = "This thing is used to flirt with people! Or it would if it initialized properly. Oops."
	icon = 'icons/obj/flirt.dmi'
	icon_state = "flirt"
	max_reach = 30 // love knows no bounds
	var/flirtkey = "hi"

/obj/item/hand_item/flirter/proc/flirtify(datum/flirt/F) // Fs in chat
	if(!istype(F))
		qdel(src) // dies of illiteracy
		return
	flirtkey = F.key
	name = F.flirtname
	desc = F.flirtdesc
	icon = F.flirticon
	icon_state = F.flirticon_state
	return TRUE

/obj/item/hand_item/flirter/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = STOP_ATTACK_PROC_CHAIN // never let this thing hit anyone ever for any ever anytime
	if(!isliving(A))
		return
	if(!SSchat.run_directed_flirt(user, A, flirtkey))
		return
	qdel(src)

/obj/item/hand_item/flirter/attack_self(mob/user)
	. = STOP_ATTACK_PROC_CHAIN // never let this thing hit anyone ever for any ever anytime
	if(!isliving(A))
		return
	if(!SSchat.run_aoe_flirt(user, A, flirtkey))
		return
	qdel(src)


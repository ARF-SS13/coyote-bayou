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
	var/list/flirtsByNumbers = list()
	/// A cached mass of jsonified flirt datums, for TGUI
	var/list/flirt_for_tgui = list() // flirt for me, flirt for me, flirt flirt
	var/list/flirts_all_categories = list() // flirt for me, flirt for me, flirt flirt

	var/flirt_debug = TRUE
	var/debug_block_radio_blurbles = FALSE

	/// Format: list("quid" = /datum/character_inspection)
	var/list/inspectors = list()

	/// list of flirt ckey things so that we can store their target or something
	/// format: list("flirterckey" = "targetckey")
	var/list/active_flirters = list()
	/// format: list("targetckey" = "flirterckey")
	var/list/active_flirtees = list()
	/// list of flirters who flirted so we can prevent spum
	/// format: list("flirterckey" = 21049190587190581)
	var/list/flirt_cooldowns = list()
	/// how long between flirts can we flirt
	var/flirt_cooldown_time = 5 SECONDS
	var/debug_character_directory = 0

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
	/// there was a comment here, but it was fucking enormous and made it hard to read
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
		var/list/payload = payload_by_client[key]
		payload_by_client -= key
		if(client)
			// for(var/pl_badwater in 1 to LAZYLEN(payload))
			// 	// Check if we should block this message
			// 	var/list/control_point = LAZYACCESS(payload, pl_badwater)
			// 	if(control_point["prefCheck"] && !CHECK_PREFS(client, control_point["prefCheck"]))
			// 		payload.Cut(pl_badwater, pl_badwater-1) // Failmate
			// 		continue // we dont want to see it
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
				if(message["prefCheck"] && !CHECK_PREFS(client, message["prefCheck"]))
					continue
				LAZYADD(payload_by_client[client], list(message))
		return
	var/client/client = CLIENT_FROM_VAR(target)
	if(client)
		if(message["prefCheck"] && !CHECK_PREFS(client, message["prefCheck"]))
			return
		LAZYADD(payload_by_client[client], list(message))

/datum/controller/subsystem/chat/proc/build_flirt_datums()
	if(LAZYLEN(flirts))
		QDEL_LIST_ASSOC_VAL(flirts)
	flirts = list()
	flirts_all_categories = list()
	for(var/flt in subtypesof(/datum/flirt))
		new flt() // it knows what its do
	flirts_all_categories.Insert(1, "All Flirts")

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

/datum/controller/subsystem/chat/proc/flirt_occurred(mob/living/flirter, mob/living/target)
	add_flirt_target(flirter, target) // flirter FLIRTED with target
	add_flirt_recipient(flirter, target) // target WAS FLIRTED BY flirter
	ui_interact(flirter)
	// ui_interact(target)

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
	var/TargetCkey = LAZYACCESS(active_flirters, flirter.ckey)
	if(!TargetCkey)
		return
	return ckey2mob(TargetCkey)

/datum/controller/subsystem/chat/proc/add_flirt_recipient(mob/living/flirter, mob/living/recipient)
	if(!istype(flirter) ||!istype(recipient))
		return
	if(!flirter.ckey ||!recipient.ckey)
		return
	if(!flirter.client ||!recipient.client)
		return
	active_flirtees[recipient.ckey] = flirter.ckey
	return TRUE

/datum/controller/subsystem/chat/proc/remove_flirt_recipient(mob/living/flirter)
	if(!istype(flirter))
		return
	if(!flirter.ckey)
		return
	if(!flirter.client)
		return
	active_flirtees -= flirter.ckey
	return TRUE

/datum/controller/subsystem/chat/proc/get_flirt_recipient(mob/living/flirter)
	if(!istype(flirter))
		return
	if(!flirter.ckey)
		return
	if(!flirter.client)
		return
	var/TargetCkey = LAZYACCESS(active_flirtees, flirter.ckey)
	if(!TargetCkey)
		return
	return ckey2mob(TargetCkey)

/// YES IM BLOWING CHAT'S TGUI LOAD ON FLIRTING, FIGHT ME
/datum/controller/subsystem/chat/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FlirtyFlirty")
		ui.open()
		ui.set_autoupdate(FALSE)

/// just holds the reader's target, if any
/datum/controller/subsystem/chat/ui_data(mob/user)
	var/list/data = list()
	var/mob/living/heart = get_flirt_target(user)
	var/mob/living/hearted = get_flirt_recipient(user)
	data["DP"] = SSquirks.dp
	data["FlirterCkey"] = user ? user.ckey : "AAAGOOD" // nulls are falsy
	data["FlirterName"] = user ? user.name : "Some Dope"
	/// who WE last flirted with
	data["TargetCkey"] = heart ? heart.ckey : "AAAGOOD" // balls are nullsy
	data["TargetName"] = heart ? heart.name : "AAABAD"
	/// who last flirted with US
	data["LastFlirtedByCkey"] = hearted ? hearted.ckey : "AAAGOOD" // balls are nullsy
	data["LastFlirtedByName"] = hearted ? hearted.name : "AAABAD"
	return data

/// holds the whole enchilada
/datum/controller/subsystem/chat/ui_static_data(mob/user)
	var/list/static_data = list()
	static_data["AllFlirts"] = flirt_for_tgui
	static_data["AllCategories"] = flirts_all_categories
	return static_data

/datum/controller/subsystem/chat/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/living/flirter = ckey2mob(params["ReturnFlirterCkey"])
	if(!flirter)
		return // nobody flirted
	var/datum/flirt/F = LAZYACCESS(flirts, params["ReturnFlirtKey"])
	flirt_cooldowns[flirter.ckey] = world.time + flirt_cooldown_time
	var/mob/living/target = ckey2mob(params["ReturnTargetCkey"] || get_flirt_target(flirter))
	switch(action)
		if("ClearFlirtTarget")
			return remove_flirt_target(flirter)
		if("GiveFlirtTargetItem")
			return give_flirt_targetter_item(flirter)
		if("PreviewFlirt")
			if(!F)
				return
			return F.preview_flirt(flirter, target)
		if("PreviewSound")
			if(!F)
				return
			return F.preview_sound(flirter, target)
		if("ClickedFlirtButton")
			if(!F)
				return
			if(LAZYACCESS(flirt_cooldowns, flirter.ckey) < world.time)
				to_chat(flirter, span_warning("Hold your horses! You're still working on that last flirt!"))
				return
			return F.give_flirter(flirter)

/datum/controller/subsystem/chat/ui_state(mob/user)
	return GLOB.always_state

/datum/controller/subsystem/chat/proc/start_page(mob/sender, mob/reciever)
	if(!sender || !reciever)
		return
	sender = extract_mob(sender)
	if(!sender || !sender.client)
		return
	reciever = extract_mob(reciever)
	if(!reciever || !reciever.client)
		to_chat(sender, span_alert("Unable to contact user, please try again later!"))
		return
	if(is_blocked(sender, reciever))
		to_chat(sender, span_warning("Module failed to load."))
		return
	var/theirname = name_or_shark(reciever) || "some jerk" // stop. naming. your. ckeys. after. your characcteres!!!!!!!!!!!!!!!!!!
	var/sender_should_see_ckey = check_rights_for(extract_client(sender), R_ADMIN)
	if(sender_should_see_ckey)
		theirname = "[theirname] - [extract_ckey(reciever)]"  // we're an admin, we can see their name
	var/mesage = input(
		sender,
		"Enter your message to [theirname]. This will send a direct message to them, which they can reply to! Be sure to respect their OOC preferences, don't be a creep (unless they like it), and <i>have fun!</i>",
		"Direct OOC Message",
		""
	) as message|null
	if(!mesage)
		return
	var/myname = name_or_shark(sender) || "Anonymouse"
	var/recipient_should_see_ckey = check_rights_for(extract_client(reciever), R_ADMIN)
	if(recipient_should_see_ckey)
		myname = "[myname] - [extract_ckey(sender)]"  // we're an admin, we can see their name

	var/payload2them = "<u><b>From [dm_linkify(reciever, sender, myname)]</u></b>: [mesage]<br>"
	payload2them = span_private(payload2them)
	to_chat(reciever, span_private("<br><U>You have a new message from [name_or_shark(sender) || "Some jerk"]!</U><br>"))
	to_chat(reciever, payload2them)
	reciever.playsound_local(reciever, 'sound/effects/direct_message_recieved.ogg', 75, FALSE)

	var/payload2me = "<u><b>To [dm_linkify(sender, reciever, theirname)]</u></b>: [mesage]<br>"
	payload2me = span_private_sent(payload2me)
	to_chat(sender, span_private_sent("<br><U>Your message to [theirname] has been sent!</U><br>"))
	to_chat(sender, payload2me)
	sender.playsound_local(sender, 'sound/effects/direct_message_setn.ogg', 75, FALSE)

	log_ooc("[sender.real_name] ([sender.ckey]) -> [reciever.real_name] ([reciever.ckey]): [mesage]")
	message_admins("[ADMIN_TPMONTY(sender)] -DM-> [ADMIN_TPMONTY(reciever)]: [mesage]", ADMIN_CHAT_FILTER_DMS, list(sender, reciever))

/// takes in a sencer, a reciever, and an optional name, and turns it into a clickable link to send a DM
/datum/controller/subsystem/chat/proc/dm_linkify(mob/sender, mob/reciever, optional_name)
	if(!sender || !reciever)
		return
	sender = extract_mob(sender)
	if(!sender || !sender.client)
		return
	reciever = extract_mob(reciever)
	if(!reciever || !reciever.client)
		return
	var/theirname = optional_name || name_or_shark(reciever) || "Anonymouse" // stop. naming. your. ckeys. after. your characcteres!!!!!!!!!!!!!!!!!!
	
	return "<a href='?src=[REF(src)];DM=1;sender_quid=[REF(sender)];reciever_quid=[REF(reciever)]'>[theirname]</a>"

/datum/controller/subsystem/chat/Topic(href, list/href_list)
	. = ..()
	if(href_list["DM"])
		start_page(href_list["sender_quid"], href_list["reciever_quid"])

/datum/controller/subsystem/chat/proc/is_blocked(mob/sender, mob/reciever)
	return FALSE // todo: this

/datum/controller/subsystem/chat/proc/name_or_shark(mob/they)
	if(!istype(they))
		return "Nobody"
	if(check_rights(R_ADMIN, FALSE))
		return they.name || they.real_name
	if(ckey(they.real_name) == ckey(they.ckey) || ckey(they.name) == ckey(they.ckey))
		if(they.client)
			var/test_name = they.client.prefs.real_name
			if(ckey(test_name) == ckey(they.ckey))
				if(strings("data/super_special_ultra_instinct.json", "[ckey(test_name)]", TRUE, TRUE))
					return test_name
				if(strings("data/super_special_ultra_instinct.json", "[ckey(they.name)]", TRUE, TRUE))
					return test_name
				if(strings("data/super_special_ultra_instinct.json", "[ckey(they.real_name)]", TRUE, TRUE))
					return test_name
				if(they.ckey == "aldrictavalin") // tired of this not working
					return test_name
				return they.client.prefs.my_shark
			return test_name
		return safepick(GLOB.cow_names + GLOB.megacarp_first_names + GLOB.megacarp_last_names)
	return they.real_name

/datum/controller/subsystem/chat/proc/inspect_character(mob/viewer, list/payload)
	if(!viewer)
		return
	viewer = extract_mob(viewer)
	if(!viewer || !viewer.client)
		return
	var/datum/character_inspection/chai = LAZYACCESS(inspectors, viewer.client.prefs.quester_uid)
	if(!chai)
		chai = new()
		inspectors[viewer.client.prefs.quester_uid] = chai
	chai.update(viewer, payload)
	chai.show_to(viewer)
	return TRUE

/datum/controller/subsystem/chat/proc/flirt_debug_toggle()
	TOGGLE_VAR(flirt_debug)
	build_flirt_datums()
	message_admins("Flirt debug [flirt_debug?"on":"off"]")

/datum/controller/subsystem/chat/proc/give_flirt_targetter_item(mob/living/flirter)
	if(!isliving(flirter))
		return
	if(flirter.get_active_held_item() && flirter.get_inactive_held_item())
		to_chat(flirter, span_warning("Your hands are too full to flirt! Yes, you need your hands to flirt."))
		return

	var/obj/item/hand_item/flirt_targetter/hiya = new(flirter)

	if(flirter.put_in_hands(hiya)) // NOTE: put_in_hand is MUCH different from put_in_hands - NOTE THE S
		to_chat(flirter, span_notice("Pick someone you want to flirt with! Just click on them while holding this, and it'll target them."))
		return TRUE
	else
		to_chat(flirter, span_warning("Something went wrong! Try a different approach~"))
		qdel(hiya)

/datum/controller/subsystem/chat/proc/can_usr_flirt_with_this(mob/A)
	if(!isliving(usr)) // fight me
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
	// if(A == usr)
	// 	to_chat(usr, span_hypnophrase("You take a deep breath and psyche yourself up to flirt with someone other than yourself for a change. You got this, tiger!"))
	// 	return
	return TRUE

/mob/verb/check_out(mob/A as mob in view())
	set name = "Flirt with"
	set category = "IC"

	if(!SSchat.can_usr_flirt_with_this(A))
		return
	to_chat(src, span_notice("You get ready to flirt with [A]. What will you do?"))
	to_chat(src, span_notice("HOW TO USE: Click on the emote you want to use, and it'll direct a flirtatious message toward them! That's it! \
		Be sure to respect their OOC preferences, don't be a creep (unless they like it), and <i>have fun!</i>"))
	SSchat.add_flirt_target(src, A)
	SSchat.ui_interact(src)

/datum/emote/living/flirtlord
	key = "flirt"
	no_message = TRUE // we'll handle it from here =3

/datum/emote/living/flirtlord/run_emote(mob/user, params) //Player triggers the emote
	if(isdead(user))
		to_chat(user, span_warning("Nobody is interested in your cold dead heart, try rising from the grave with a fistful of flowers, should impress someone."))
		return
	if(user.stat == DEAD)
		to_chat(user, span_warning("You've got better things to do than flirt, such as being dead."))
		return
	if(LAZYLEN(params))
		var/whichm = text2num(params)
		if(isnum(whichm) && whichm > 0 && whichm <= LAZYLEN(SSchat.flirtsByNumbers))
			var/datum/flirt/F = LAZYACCESS(SSchat.flirtsByNumbers, whichm)
			if(F)
				return F.give_flirter(user)
	to_chat(user, span_notice("You get ready to flirt. What will you do? And who with?"))
	to_chat(user, span_notice("HOW TO USE: Click on the emote you want to use, and it'll give you a thing in your hand! Just click on whoever you want to send a flirtatious message to, or just use it in hand to send a message to everyone nearby. That's it! \
		Be sure to respect their OOC preferences, don't be a creep (unless they like it), and <i>have fun!</i>"))
	SSchat.ui_interact(user)


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

////////////// so those datums were awful, maybe this one will be better
/datum/character_inspection // DROP YOUR PANTS, ITS CHARACTER INSPECTION DAY
	var/gender
	var/species
	var/vorepref
	var/erppref
	var/kisspref
	var/flink
	var/ad
	var/notes
	var/flavor
	var/their_quid
	var/looking_for_friends
	var/dms_r_open
	var/name
	var/profile_pic

	/// update the character inspection with new data
/datum/character_inspection/proc/update(mob/viewer, list/payload)
	if(!payload)
		return
	gender = payload["gender"]
	species = payload["species"]
	vorepref = payload["tag"]
	erppref = payload["erptag"]
	kisspref = payload["whokisser"]
	flink = payload["flist"]
	ad = payload["character_ad"]
	notes = payload["ooc_notes"]
	flavor = payload["flavor_text"]
	their_quid = payload["quid"]
	looking_for_friends = payload["looking_for_friends"]
	dms_r_open = TRUE
	name = payload["name"]
	profile_pic = payload["profile_pic"]
	if(viewer && viewer.client)
		show_to(viewer)

	/// show the character inspection to the viewer
/datum/character_inspection/proc/show_to(mob/viewer)
	ui_interact(viewer)

/datum/character_inspection/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CharacterInspection")
		ui.open()
		ui.set_autoupdate(FALSE)

/datum/character_inspection/ui_static_data(mob/user)
	var/list/static_data = list()
	static_data["gender"] = gender
	static_data["species"] = species
	static_data["vorepref"] = vorepref
	static_data["erppref"] = erppref
	static_data["kisspref"] = kisspref
	static_data["flink"] = flink
	static_data["ad"] = html_decode(ad)
	static_data["notes"] = html_decode(notes)
	static_data["flavor"] = html_decode(flavor)
	static_data["their_quid"] = their_quid
	static_data["name"] = name
	static_data["looking_for_friends"] = looking_for_friends
	static_data["dms_r_open"] = TRUE
	static_data["profile_pic"] = profile_pic
	if(user && user.client) // dont know why they wouldnt, but whatever
		static_data["viewer_quid"] = user.client.prefs.quester_uid
	return static_data

/datum/character_inspection/ui_act(action, list/params)
	. = ..()
	if(!params["viewer_quid"])
		return
	var/mob/viower = extract_mob(params["viewer_quid"])
	if(!viower) // warning: sum of dis chapta is extremely scray
		return // viower excretion advisd
	var/mob/viowed = extract_mob(params["their_quid"])
	if(!viowed)
		return
	if(action == "pager")
		SSchat.start_page(viower, viowed)
		return TRUE
	if(action == "show_pic")
		var/dat = {"
			<img src='[profile_pic]' width='100%' height='100%' 'object-fit: scale-down;'>
			<br>
			[profile_pic] <- Copy this link to your browser to view the full sized image.
		"}
		var/datum/browser/popup = new(viower, "enlargeImage", "Full Sized Picture!",1024,768)
		popup.set_content(dat)
		popup.open()
		return TRUE
	if(action == "view_flist")
		if(viowed)
			to_chat(viower, span_notice("Opening F-list..."))
			SEND_SIGNAL(viowed, COMSIG_FLIST, viower)
			return TRUE
		else
			to_chat(viower, span_alert("Couldn't find that character's F-list!"))
			return TRUE
	return TRUE

/datum/character_inspection/ui_state(mob/user)
	return GLOB.always_state

/mob/verb/direct_message(mob/A as mob in view(10, src))
	set name = "Direct Message"
	set category = "OOC"
	set desc = "Send a direct message to this character."
	set popup_menu = TRUE

	SSchat.start_page(src, A)



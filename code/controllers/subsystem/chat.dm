/**
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */
#define CHANGED_SETTINGS 1
#define CHANGED_IMAGES 2
#define CHANGED_NOTHING 3 // COOL

/// hosts, and their respective tags
GLOBAL_LIST_INIT(supported_img_hosts, list(
	"https://files.catbox.moe" = list("catbox"),
	"https://i.gyazo.com" = list("gyazo"),
))

GLOBAL_LIST_INIT(supported_img_exts, list(
	"PNG",
	"JPG",
	"GIF",
	"WEBP",
	"JPEG",
	"JFIF",
))
#define GRAD_1 "#1d1d2f"
#define GRAD_2 "#1b1b30"
#define BORDR "#1c1c39"
GLOBAL_LIST_INIT(default_horny_settings, list(
	"TopBoxGradient1" = "#303075",
	"TopBoxGradient2" = "#1b1b30",
	"TopBoxBorderColor" = "#0c0c23",
	"TopBoxBorderWidth" = 1,
	"TopBoxBorderStyle" = "solid",
	"TopBoxGradientAngle" = 315,
	"BottomBoxGradient1" = "#303075",
	"BottomBoxGradient2" = "#1b1b30",
	"BottomBoxBorderColor" = "#0c0c23",
	"BottomBoxBorderWidth" = 1,
	"BottomBoxBorderStyle" = "solid",
	"BottomBoxGradientAngle" = 225,
	"ButtonGradient1" = "#0F485F",
	"ButtonGradient2" = "#12303C",
	"ButtonBorderColor" = "#0c0c23",
	"ButtonBorderWidth" = 2,
	"ButtonBorderStyle" = "groove",
	"ButtonGradientAngle" = 0,
	"ImageBorderBorderColor" = BORDR,
	"ImageBorderBorderWidth" = 1,
	"ImageBorderBorderStyle" = "solid",
	"OuterBoxBorderColor" = "#0c0c23",
	"OuterBoxBorderWidth" = 2,
	"OuterBoxBorderStyle" = "ridge",
))
#undef GRAD_1
#undef GRAD_2
#undef BORDR

SUBSYSTEM_DEF(chat)
	name = "Chat"
	flags = SS_TICKER
	wait = 1
	priority = FIRE_PRIORITY_CHAT
	init_order = INIT_ORDER_CHAT

	var/forbid_ghosting = FALSE
	var/chat_display_plane = RUNECHAT_PLANE
	/* 
	** Base 
	 */
	var/base_say_distance = 7
	var/extended_say_distance = 16

	var/base_whisper_distance = 1
	var/extended_whisper_distance = 3
	
	var/base_radio_reduced_distance = 2
	var/extended_radio_reduced_distance = 3
	
	var/base_sing_distance = 500
	var/extended_sing_distance = 600

	var/base_yell_distance = 500
	var/extended_yell_distance = 600

	var/base_exclaim_distance = 14
	var/extended_exclaim_distance = 21
	
	var/far_distance = 6 // how far until they're considered offscreen

	var/static/list/unconscious_allowed_modes = list(
		MODE_CHANGELING = TRUE,
		MODE_ALIEN = TRUE,
	)
	var/static/list/one_character_prefix = list(
		MODE_HEADSET = TRUE,
		MODE_ROBOT = TRUE,
		MODE_WHISPER = TRUE,
		MODE_SING = TRUE,
		MODE_YELL = TRUE,
		MODE_WHISPER = TRUE,
	)


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

	var/list/horny_tguis = list()

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
	var/same_mode_timeout = 0 //1 MINUTES
	var/max_horny_distance = 2

	var/list/stock_image_packs = list() // see: [code\__DEFINES\mommychat_image_packs.dm]
	var/list/mandatory_modes = list(MODE_PROFILE_PIC, MODE_SAY, MODE_WHISPER, MODE_SING, MODE_ASK, MODE_EXCLAIM, MODE_YELL)

	var/list/test_pics = list( // warning: boobs
		MODE_SAY = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "4m71t6.jpg",
		),
		MODE_ASK = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "jm3f2c.jpg",
		),
		MODE_SING = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "em5bgb.jpg",
		),
		MODE_EXCLAIM = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "3ggp5e.jpg",
		),
		MODE_YELL = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "1dmlu5.jpg",
		),
		MODE_WHISPER = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "t040sg.jpg",
		),
		MODE_CUSTOM_SAY = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "fcm6yw.jpg",
		),
		":example:" = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "fcm6yw.jpg",
		),
	)

	var/list/default_pfps = list(
		MALE = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "1i1zom.png",
		),
		FEMALE = list(
			"Host" = "https://files.catbox.moe",
			"URL" = "jgxtpe.png",
		)
	)

	var/img_size = 125
	var/headspace = 4
	var/debug_chud = FALSE
	var/debug_use_cool_los_proc = FALSE
	var/list/colorable_keys = list(
		"TopBoxGradient1",
		"TopBoxGradient2",
		"TopBoxBorderColor",
		"BottomBoxGradient1",
		"BottomBoxGradient2",
		"BottomBoxBorderColor",
		"ButtonGradient1",
		"ButtonGradient2",
		"ButtonBorderColor",
		"ImageBorderBorderColor",
		"OuterBoxBorderColor",
	)
	var/list/angleable_keys = list(
		"TopBoxGradientAngle",
		"BottomBoxGradientAngle",
		"ButtonGradientAngle",
	)
	var/list/numberable_keys = list(
		"TopBoxBorderWidth",
		"BottomBoxBorderWidth",
		"ButtonBorderWidth",
		"ImageBorderBorderWidth",
		"OuterBoxBorderWidth",
	)
	var/list/selectable_keys = list(
		"TopBoxBorderStyle",
		"BottomBoxBorderStyle",
		"ButtonBorderStyle",
		"ImageBorderBorderStyle",
		"OuterBoxBorderStyle",
	)
	var/list/borderstyles = list(
		"solid",
		"dotted",
		"dashed",
		"double",
		"groove",
		"ridge",
		"inset",
		"outset",
		"none",
		"hidden",
	)
	var/numbermal_min = 0
	var/numbermal_max = 5
	var/numbermal_default = 1

/datum/controller/subsystem/chat/Initialize(start_timeofday)
	setup_emoticon_cache()
	build_flirt_datums()
	// build_stock_image_packs()
	. = ..()
	spawn(5 SECONDS)
		to_chat(world, span_boldnotice("Initialized [LAZYLEN(emoticon_cache)] (non-functional) emoticons! ;D"))
		to_chat(world, span_boldnotice("Initialized [LAZYLEN(flirts)] flirty messages! <3"))
		to_chat(world, span_boldnotice("VisualChat engaged! Have a very visual day! <3"))
		// to_chat(world, span_boldnotice("Initialized [LAZYLEN(stock_image_packs)] stock image packs! 'w'"))

// /datum/controller/subsystem/chat/proc/build_stock_image_packs()
// 	stock_image_packs.Cut()
// 	for(var/paq in subtypesof(/datum/horny_image_pack))
// 		var/datum/horny_image_pack/P = new(paq)
// 		stock_image_packs += list(P.ListifyPack())

/datum/controller/subsystem/chat/proc/setup_emoticon_cache()
	emoticon_cache.Cut()
	var/json_emoticons = file2text("strings/sausage_rolls.json") // am hungy
	/// there was a comment here, but it was fukcing enormous and made it hard to read
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

/datum/controller/subsystem/chat/proc/emoticonify(atom/movable/sayer, message, messagemode, list/spans, datum/rental_mommy/chat/momchat)
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

/datum/controller/subsystem/chat/proc/SanitizeUserImages(someone)
	if(!someone)
		return
	var/datum/preferences/P = extract_prefs(someone)
	if(!P)
		return
	var/list/PP = P.ProfilePics // this is my PP
	// testing stuff
	// PP.Cut()
	var/list/mandated = list()
	var/list/extras = list()
	/// first, setup the mandated modes with the defaults
	for(var/emotimode in mandatory_modes)
		var/list/tentry = list()
		tentry["Mode"] = emotimode
		tentry["Host"] = default_pfps[MALE]["Host"]
		tentry["URL"] = default_pfps[MALE]["URL"]
		tentry["Suppress"] = emotimode == MODE_PROFILE_PIC
		var/defverb = "says,"
		var/defblank = "gestures!"
		switch(emotimode)
			if(MODE_SAY)
				defverb = P.features["custom_say"] || "says,"
				defblank = "speaks."
			if(MODE_WHISPER)
				defverb = P.features["custom_whisper"] || "whispers,"
				defblank = "whispers."
			if(MODE_SING)
				defverb = P.features["custom_sing"] || "sings,"
				defblank = "sings!"
			if(MODE_ASK)
				defverb = P.features["custom_ask"] || "asks,"
				defblank = "asks."
			if(MODE_EXCLAIM)
				defverb = P.features["custom_exclaim"] || "exclaims,"
				defblank = "exclaims!"
			if(MODE_YELL)
				defverb = P.features["custom_yell"] || "yells,"
				defblank = "yells!"
		tentry["CustomMessageVerb"] = defverb
		tentry["CustomBlankVerb"] = defblank
		tentry["Modifiable"] = FALSE
		mandated += list(tentry)
	/// now go through their profile pics and copy over what they have, if its valid
	for(var/list/bepis in PP)
		var/emode = bepis["Mode"]
		var/ehost = bepis["Host"]
		var/eurl = bepis["URL"]
		var/valid = FALSE
		if(!(ehost in GLOB.supported_img_hosts))
			valid = FALSE
		else
			var/list/dott = splittext(eurl, ".")
			if(LAZYLEN(dott) != 2)
				valid = FALSE
			else
				var/extension = uppertext(dott[2])
				if(!(extension in GLOB.supported_img_exts))
					valid = FALSE
				else // look for any characters that probably shouldnt be in a normal URL
					if(findtext(eurl, " "))
						valid = FALSE
					else
						// keep looking for anything that might indicate malicious intent
						if(findtext(eurl, ".."))
							valid = FALSE
						else
							if(findtext(eurl, "/"))
								valid = FALSE
							else
								valid = TRUE // good enough, i guess
		for(var/hoste in GLOB.supported_img_hosts)
			if(findtext(eurl, "[hoste]/"))
				eurl = replacetext(eurl, "[hoste]/", "") // for convenience
		if(valid)
			eurl = html_encode(eurl) // this probably sanitizes it and makes the above checks redundant, but I belive in belt and suspenders (even if neither fit around my big fat blubbery fox breasts) // dan // I mean, it is, isnt it?
		else
			ehost = default_pfps[FEMALE]["Host"]
			eurl = default_pfps[FEMALE]["URL"]
		if(emode in mandatory_modes)
			for(var/list/emotimode in mandated)
				if(emotimode["Mode"] == emode)
					emotimode["Host"] = ehost
					emotimode["URL"] = eurl
					emotimode["Modifiable"] = FALSE
					var/defverb = "says,"
					var/defblank = "gestures!"
					switch(emotimode)
						if(MODE_SAY)
							defverb = P.features["custom_say"] || "says,"
							defblank = "speaks."
						if(MODE_WHISPER)
							defverb = P.features["custom_whisper"] || "whispers,"
							defblank = "whispers."
						if(MODE_SING)
							defverb = P.features["custom_sing"] || "sings,"
							defblank = "sings!"
						if(MODE_ASK)
							defverb = P.features["custom_ask"] || "asks,"
							defblank = "asks."
						if(MODE_EXCLAIM)
							defverb = P.features["custom_exclaim"] || "exclaims,"
							defblank = "exclaims!"
						if(MODE_YELL)
							defverb = P.features["custom_yell"] || "yells,"
							defblank = "yells!"
					emotimode["CustomMessageVerb"] = bepis["CustomMessageVerb"] || defverb || "says,"
					emotimode["CustomBlankVerb"] = bepis["CustomBlankVerb"] || defblank || "gestures!" // unused, but here for good luck
					break
		else
			var/list/newPP = list(
				"Mode" = emode,
				"Host" = ehost,
				"URL" = eurl,
				"Modifiable" = TRUE,
				"CustomMessageVerb" = bepis["CustomMessageVerb"] || "says,",
				"CustomBlankVerb" = bepis["CustomBlankVerb"] || "gestures!",
			)
			extras += list(newPP)
	var/list/newlist = mandated + extras // sorting!
	// So, we didnt really catch their gender when they first made their character
	// so we'll just set any default images to whatever they are now
	var/list/defaulturls = list(
		default_pfps[MALE]["URL"],
		default_pfps[FEMALE]["URL"],
	)
	for(var/list/PPentry in newlist)
		if(PPentry["URL"] in defaulturls)
			switch(P.gender)
				if(MALE)
					PPentry["Host"] = default_pfps[MALE]["Host"]
					PPentry["URL"] = default_pfps[MALE]["URL"]
				if(FEMALE)
					PPentry["Host"] = default_pfps[FEMALE]["Host"]
					PPentry["URL"] = default_pfps[FEMALE]["URL"]
				else
					if(prob(50))
						PPentry["Host"] = default_pfps[MALE]["Host"]
						PPentry["URL"] = default_pfps[MALE]["URL"]
					else
						PPentry["Host"] = default_pfps[FEMALE]["Host"]
						PPentry["URL"] = default_pfps[FEMALE]["URL"]
	P.ProfilePics = newlist.Copy()
	P.save_character()

/// makes sure that the user has a properly filled out set of preferences lists for their hornychat
/datum/controller/subsystem/chat/proc/SanitizeUserPreferences(someone)
	if(!someone) // You'll be able to set colors and such for each of the message modes!
		return // So you could, say, have your I AM YELLING block look more YELLY
	var/datum/preferences/P = extract_prefs(someone) // and, hm, maybe not today, probably tomorrow
	if(!P)
		return
	var/list/HP = P.mommychat_settings // this is my PP
	if(!islist(HP) || !LAZYLEN(HP) || (LAZYLEN(HP) < LAZYLEN(mandatory_modes)))
		var/list/backups = list()
		for(var/list/modu in HP)
			if(modu in mandatory_modes)
				continue
			backups[modu] = HP[modu]
		HP = list()
		for(var/modu in mandatory_modes)
			HP[modu] = GLOB.default_horny_settings.Copy()
		for(var/modu in backups)
			HP[modu] = backups[modu]
		P.mommychat_settings = HP
		P.save_character()
	var/list/ProfilePics = P.ProfilePics // this is my PP
	if(LAZYLEN(ProfilePics) != LAZYLEN(HP)) // the settings isnt the same length as the profile pics, update ours to fit theirs
		for(var/list/PPc in ProfilePics)
			if(!HP[PPc["Mode"]])
				HP[PPc["Mode"]] = GLOB.default_horny_settings.Copy()
	///  P.mommychat_settings[mmode]["ImageBorderBorderWidth"] = "2px" // the settings look like this
	for(var/mode in mandatory_modes)
		if(!islist(HP[mode]))
			HP[mode] = list()
		// check if the entries have a valid value
		for(var/key in colorable_keys)
			var/vale = HP[mode][key]
			if(!vale || (LAZYACCESS(vale, 1) != "#"))
				HP[mode][key] = GLOB.default_horny_settings[key]
		for(var/key in numberable_keys)
			var/vale = HP[mode][key]
			if(!isnum(vale) || (vale < numbermal_min) || (vale > numbermal_max))
				HP[mode][key] = GLOB.default_horny_settings[key]
		for(var/key in angleable_keys)
			var/vale = HP[mode][key]
			if(!isnum(vale) || (vale < 0) || (vale > 360))
				HP[mode][key] %= 360
		for(var/key in selectable_keys)
			var/vale = HP[mode][key]
			if(!vale || !(vale in borderstyles))
				HP[mode][key] = GLOB.default_horny_settings[key]
		if(mode == MODE_PROFILE_PIC)
			HP[mode]["Suppress"] = TRUE
	P.mommychat_settings = HP
	P.save_character()

/datum/controller/subsystem/chat/proc/HornyPreferences(someone)
	if(!someone)
		return
	var/client/C = extract_client(someone)
	if(!C)
		return
	if(!SSprefbreak.initialized || !SSrentaldatums.initialized)
		to_chat(C, span_alert("Hold your horses! Parts of the game that this thing relies on hasn't initialized yet! Everything should be ready when the round starts. =3"))
		return
	var/datum/horny_tgui_holder/HTH = LAZYACCESS(horny_tguis, C.ckey)
	if(!HTH)
		HTH = new(C.ckey)
		horny_tguis[C.ckey] = HTH
	HTH.OpenPrefsMenu()

/// GEE DAN, LETS MAKE PROFILE PICS AND SETTINGS BE TWO ENTIRELY SEPARATE LISTS
/// WHAT A GREAT IDEA, NO WAY THIS WOULD CAUSE DISCREPANCIES you fukcking dikc
/// This proc comapres mommychat_settings to ProfilePics and updates the two to match
/datum/controller/subsystem/chat/proc/CoordinateSettingsAndPics(someone, whichchanged)
	var/datum/preferences/P = extract_prefs(someone)
	if(!P)
		return
	if(whichchanged != CHANGED_IMAGES && whichchanged != CHANGED_SETTINGS)
		return
	var/list/horny_settings = P.mommychat_settings
	var/list/ProfilePics = P.ProfilePics
	if(whichchanged == CHANGED_IMAGES)
		// The images were changed, time to go through the settings and make sure it has this mode		for(var/list/PPc in ProfilePics)
		for(var/list/PPc in ProfilePics)
			var/foundit = LAZYLEN(LAZYACCESS(P.mommychat_settings, PPc["Mode"]))
			if(!foundit)
				P.mommychat_settings[PPc["Mode"]] = GLOB.default_horny_settings.Copy()
		P.mommychat_settings = horny_settings

/datum/controller/subsystem/chat/proc/TestHorny()
	var/mob/user = usr
	to_chat(user, "Testing the horny")
	for(var/mmode in test_pics)
		PreviewHornyFurryDatingSimMessage(user, mmode)
	to_chat(user, "Test complete")

/datum/controller/subsystem/chat/proc/GetPicForMode(whosit, mode)
	if(!mode)
		return
	var/datum/preferences/P = extract_prefs(whosit)
	if(!P)
		return
	SanitizeUserImages(P)
	var/list/PP = P.ProfilePics
	for(var/PPentry in PP)
		if(PPentry["Mode"] == mode)
			var/Host = PPentry["Host"]
			var/URL = PPentry["URL"]
			return Host + "/" + URL
	return "https://files.catbox.moe/jgxtpe.png"

/datum/controller/subsystem/chat/proc/PreviewHornyFurryDatingSimMessage(mob/target, message_mode, message, print)
	if(!istype(target))
		CRASH("PreviewHornyFurryDatingSimMessage called with invalid arguments! [target]!")
	var/mob/living/carbon/human/dummy/D = SSdummy.get_a_dummy()
	var/datum/preferences/P = extract_prefs(target)
	if(!P)
		CRASH("PreviewHornyFurryDatingSimMessage called with invalid arguments! [P]!")
	P.copy_to(D)
	D.dummyckey = target.ckey
	D.invisibility = INVISIBILITY_ABSTRACT
	D.forceMove(get_turf(target))
	var/msg = message ? message : "Hey there! How's it going? I was thinking we could go on a date sometime. I'm a vampire and"
	if(message_mode)
		switch(message_mode) // dan // I mean, it is, isnt it?
			if(MODE_SAY)
				msg = msg
			if(MODE_WHISPER)
				msg = "#[msg]"
			if(MODE_SING)
				msg = "%[msg]"
			if(MODE_ASK)
				msg = "[msg]?"
			if(MODE_EXCLAIM)
				msg = "[msg]!"
			if(MODE_YELL)
				msg = "$[msg]"
			else
				msg = "[msg][message_mode]" // to catch any custom modes

	var/datum/rental_mommy/chat/mommy = D.say(msg, direct_to_mob = D) // silent screaming (??)
	D.moveToNullspace()
	D.invisibility = initial(D.invisibility)
	if(!mommy)
		SSdummy.return_dummy(D)
		CRASH("PreviewHornyFurryDatingSimMessage called, but Mommy was not created!")
	mommy.prefs_override = P
	mommy.dummy = TRUE
	var/mommess = BuildHornyFurryDatingSimMessage(mommy, TRUE)
	mommy.checkin()
	SSdummy.return_dummy(D)
	if(print)
		to_chat(target, mommess)
	else
		return mommess

/datum/controller/subsystem/chat/proc/mode2string(mode)
	switch(mode)
		if(MODE_SAY)
			return "Say"
		if(MODE_WHISPER)
			return "Whisper"
		if(MODE_SING)
			return "Sing"
		if(MODE_ASK)
			return "Ask"
		if(MODE_EXCLAIM)
			return "Exclaim"
		if(MODE_YELL)
			return "Yell"
	return "[mode]"

/// takes in a rental mommy and extracts the custom verb from the message, and sets it up for u
/datum/controller/subsystem/chat/proc/ExtractCustomVerb(datum/rental_mommy/chat/momchat)
	if(!istype(momchat))
		CRASH("ExtractCustomVerb called with invalid arguments! [momchat]!")
	if(momchat.verb_pretreated)
		return // we already did this
	var/mob/living/speaker = momchat.source
	var/datum/preferences/P = momchat.prefs_override || extract_prefs(speaker)
	if(!P)
		momchat.verb_pretreated = TRUE // we did it?
		return 
	var/list/m_images = P ? P.ProfilePics.Copy() : test_pics
	if(LAZYLEN(momchat.original_message) && istext(momchat.original_message))
		var/list/splittify = splittext(momchat.original_message, ":")
		if(LAZYLEN(splittify) > 1)
			math:
				for(var/splut in splittify)
					var/testpart = ":[splut]:"
					for(var/list/moud in m_images)
						if(moud["Mode"] == testpart)
							momchat.message_mode = testpart
							momchat.coloned_word = testpart
							var/list/quicksplit = splittext(momchat.original_message, testpart)
							if(LAZYLEN(quicksplit) == 2 && ckey(quicksplit[2]) == "") // the token was at the end... probably
								momchat.original_message = trim(quicksplit[1])
								momchat.message = trim(quicksplit[1])
							else
								// now the fun part, surgically remove the custom mode from the message, *and* remove any spaces around it
								momchat.original_message = PurgeWord(momchat.original_message, testpart)
								// now the fun part, surgically remove the custom mode from the message, *and* remove any spaces around it
								momchat.message = PurgeWord(momchat.message, testpart)
							if(!LAZYLEN(ckey(momchat.message)) || !LAZYLEN(ckey(momchat.original_message))) // the whole message was the thing then!
								momchat.pulse_verb = TRUE // I never got into Pulse by Lightfoot, even though I probably shouldve
								momchat.original_message = moud["CustomBlankVerb"]
								momchat.message = momchat.original_message // all for runechat, yiff yiff
							break math // mathematical
	momchat.verb_pretreated = TRUE // we did it!

/datum/controller/subsystem/chat/proc/PurgeWord(message, word)
	. = message
	. = replacetext(., " [word] ", "")
	. = replacetext(., "[word] ", "")
	. = replacetext(., " [word]", "")
	. = replacetext(., "[word]", "")

/datum/controller/subsystem/chat/proc/BuildHornyFurryDatingSimMessage(datum/rental_mommy/chat/mommy)
	if(!istype(mommy))
		CRASH("BuildHornyFurryDatingSimMessage called with invalid arguments! [mommy]!")
	var/mob/living/target = mommy.recipiant
	if(!istype(mommy.recipiant))
		CRASH("BuildHornyFurryDatingSimMessage called with invalid arguments! [target]!!")
	if(!mommy.source)
		CRASH("BuildHornyFurryDatingSimMessage called with invalid arguments! [mommy.source]!!!!")
	var/datum/preferences/P = mommy.prefs_override || extract_prefs(mommy.source)
	if(!P)
		CRASH("BuildHornyFurryDatingSimMessage called with invalid arguments! [P]!")
	/// SO. now we need a few things from the speaker (mommy)
	/// - Name
	/// - Spoken Verb
	/// - Rendered message, with quotes
	/// - The message mode, for reasons i'll get into later
	/// - A list of profile images
	/// - A link to their chardir profile
	/// - A link to DM them
	/// - A link to flirt with them
	/// - A link to "interact" with them
	/// - A color for the text background
	/// - A color for the header background
	/// and from this, we will make a furry dating sim style message that will be sent to the target *and* the speaker
	ExtractCustomVerb(mommy)
	var/m_name       = mommy.speakername || mommy.source.name
	var/m_verb       = mommy.message_saymod_comma || "says, "
	var/m_rawmessage = mommy.original_message
	var/m_message    = mommy.message
	var/m_mode       = mommy.message_mode || MODE_SAY
	var/m_radio	     = mommy.is_radio
	if(!LAZYLEN(P.mommychat_settings[m_mode]))
		SanitizeUserPreferences(mommy.source)

	/// look for something in m_rawmessage formatted as :exammple: and extract that to look up a custom image
	/// We'll extract this, store it as a var, and use it as an override for the profile image
	var/list/m_images = P ? P.ProfilePics.Copy() : test_pics
	var/list/hidden_toe = list() // critical
	var/m_pfp = get_horny_pfp(m_rawmessage, m_images, m_mode, hidden_toe)
	var/list/set4mode = P.mommychat_settings["[m_mode]"]
	if(!LAZYLEN(set4mode))
		set4mode = P.mommychat_settings["[MODE_SAY]"]
	
	/// now all the many many colors for everything!
	// first the background gradients (and their angles)
	var/tgc_2 =   set4mode["TopBoxGradient1"]
	var/tgc_1 =   set4mode["TopBoxGradient2"]
	var/tgangle = set4mode["TopBoxGradientAngle"]
	var/tbc =     set4mode["TopBoxBorderColor"]
	var/tbs =     set4mode["TopBoxBorderWidth"]
	var/tbt =     set4mode["TopBoxBorderStyle"]

	var/bgc_2 =   set4mode["ButtonGradient1"]
	var/bgc_1 =   set4mode["ButtonGradient2"]
	// var/bgangle = set4mode["ButtonGradientAngle"]
	// var/bbc =     set4mode["ButtonBorderColor"]
	// var/bbs =     set4mode["ButtonBorderWidth"]
	// var/bbt =     set4mode["ButtonBorderStyle"]

	var/bbc_2 =   set4mode["BottomBoxGradient1"]
	var/bbc_1 =   set4mode["BottomBoxGradient2"]
	var/bbangle = set4mode["BottomBoxGradientAngle"]
	var/bbbc =    set4mode["BottomBoxBorderColor"]
	var/bbbs =    set4mode["BottomBoxBorderWidth"]
	var/bbbt =    set4mode["BottomBoxBorderStyle"]

	var/obc =     set4mode["OuterBoxBorderColor"]
	var/obs =     set4mode["OuterBoxBorderWidth"]
	var/obt =     set4mode["OuterBoxBorderStyle"]

	// var/ibc =     set4mode["ImageBorderBorderColor"]
	// var/ibs =     set4mode["ImageBorderBorderWidth"]
	// var/ibt =     set4mode["ImageBorderBorderStyle"]

	// now the text colors
	// most are defined by mommy, but some arent, so we'll need to get a color that contrasts with the average of the top and bottom gradient colors
	var/tgc_to_num = hex2num(replacetext(tgc_1,"#", "")) + hex2num(replacetext(tgc_2,"#", ""))
	var/bgc_to_num = hex2num(replacetext(bgc_1,"#", "")) + hex2num(replacetext(bgc_2,"#", ""))
	var/avg_color = (tgc_to_num + bgc_to_num) / 4
	/// now we need to get the contrast color
	var/contrast_color = num2hex(16777215 - avg_color)
	var/dtc = "#[contrast_color]"

	var/mommyquid = mommy.source_quid
	// var/targetquid = SSeconomy.extract_quid(target)

	/// OFF WITH THEIR HEADS if we've already heard them speak with the same mode in the last, uh, minute?
	/// Listener (target) has a list of the quids they've heard from, along with the last time they heard them, and their last message mode
	/// If the message mode is the same, and the time is less than a minute or so ago, we'll lop off their head
	var/giv_head = TRUE
	var/giv_body = TRUE
	var/list/heard_em = LAZYACCESS(target.heard_data, mommyquid)
	if(LAZYLEN(heard_em) && !isdummy(mommy.source))
		var/message_mode = heard_em["message_mode"]
		if(message_mode == m_mode)
			var/timecheck = heard_em["last_heard"] + same_mode_timeout
			if(timecheck > world.time)
				giv_head = FALSE // (get them) OFF WITH YOUR HEADS!
	if(m_radio)
		giv_head = FALSE
	target.heard_data[mommyquid] = list("last_heard" = world.time, "message_mode" = m_mode)
	var/nomessage = FALSE
	var/nobold_verb = FALSE
	var/no_boober_period = FALSE // the name and verb
	if(mommy.is_emote || mommy.hide_name_n_verb)
		no_boober_period = TRUE // message is self-contained, just show it raw without the head or the verb
		if(mommy.partial) // for *scream stuff
			giv_head = FALSE
	else
		if(LAZYLEN(hidden_toe))
			if(!LAZYLEN(ckey(m_rawmessage)) || mommy.pulse_verb)
				m_rawmessage = ""
				// so see if they have a CustomBlankVerb and CustomMessageVerb
				// if they do, use that instead of the default message and verb
				var/vess = hidden_toe["CustomBlankVerb"]
				if(vess)
					m_verb = vess
				else
					m_verb = "does something!"
				nobold_verb = TRUE
				nomessage = TRUE
				if(mommy.pulse_verb || ismob(mommy.source))
					var/mob/M = mommy.source
					var/themess = "[m_name] [m_verb]"
					M.create_chat_message(M, mommy.language, themess, list(), NONE, list(), mommy)
			else if(hidden_toe["CustomMessageVerb"])
				if(findtext(hidden_toe["CustomMessageVerb"], "|"))
					var/list/verblist = splittext(hidden_toe["CustomMessageVerb"], "|")
					if(LAZYLEN(verblist) > 1)
						m_verb = pick(verblist)
					else
						m_verb = hidden_toe["CustomMessageVerb"]
					// nobold_verb = TRUE
				else
					m_verb = hidden_toe["CustomMessageVerb"]
					// nobold_verb = TRUE

	/// Character Directory link
	// var/m_charlink = "<a href='?src=[REF(src)];CHARDIR=1;reciever_quid=[mommyquid];sender_quid=[targetquid]'>
	// <div text-align: center; style='width: 100%; padding: 3px; background: linear-gradient([bgangle]deg, [bgc_1], [bgc_2]);
	// border: [bbs]px [bbt] [bbc];'>
	// Examine</div></a>"
	// /// DM link
	// var/m_dmlink = "<a href='?src=[REF(src)];DM=1;reciever_quid=[mommyquid];sender_quid=[targetquid]'>
	// <div text-align: center; style='width: 100%; padding: 3px; background: linear-gradient([bgangle]deg, [bgc_1], [bgc_2]);
	// border: [bbs]px [bbt] [bbc];'>
	// DM</div></a>"
	// /// Flirt link
	// var/m_flirtlink = "<a href='?src=[REF(src)];FLIRT=1;reciever_quid=[mommyquid];sender_quid=[targetquid]'>
	// <div text-align: center; style='width: 100%; padding: 3px; background: linear-gradient([bgangle]deg, [bgc_1], [bgc_2]);
	// border: [bbs]px [bbt] [bbc];'>
	// Flirt</div></a>"
	// /// Interact link
	// var/m_interactlink = "<a href='?src=[REF(src)];INTERACT=1;reciever_quid=[mommyquid];sender_quid=[targetquid]'>
	// <div text-align: center; style='width: 100%; padding: 3px; background: linear-gradient([bgangle]deg, [bgc_1], [bgc_2]);
	// border: [bbs]px [bbt] [bbc];'>
	// Interact</div></a>"


/* 
	<button style='width: 100%; background: linear-gradient(0deg, #FFFFFF, #FFFFFF);border: 2px solid #000000;'><a href='?src=[0x21000073];CHARDIR=1;reciever_quid=superlagg-numbering-crossly-5964-6337;sender_quid=superlagg'>Profile</a></button>
	<button style='width: 100%; background: linear-gradient(0deg, #FFFFFF, #FFFFFF);border: 2px solid #000000;'><a href='?src=[0x21000073];DM=1;reciever_quid=superlagg;sender_quid=superlagg'>DM</a></button>
	<button style='width: 100%; background: linear-gradient(0deg, #FFFFFF, #FFFFFF);border: 2px solid #000000;'><a href='?src=[0x21000073];FLIRT=1;reciever_quid=superlagg-numbering-crossly-5964-6337;sender_quid=superlagg'>Flirt</a></button>
	<button style='width: 100%; background: linear-gradient(0deg, #FFFFFF, #FFFFFF);border: 2px solid #000000;'><a href='?src=[0x21000073];INTERACT=1;reciever_quid=superlagg-numbering-crossly-5964-6337;sender_quid=superlagg'>Interact</a></button>
 */

	/// now we need to build the message
	var/list/cum = list()
	// First, the full body container
	cum += "<div style='width: 100%; border: [obs]px [obt] [obc]; display: flex; flex-direction: row;'>"
	// first the head
	if(giv_head)
		cum += "<div style='width: auto; background: linear-gradient([tgangle]deg, [tgc_1], [tgc_2]); border: [tbs]px [tbt] [tbc]; display: flex; flex-direction: row;'>"
		// now the profile picture
		// cum += "<div style='width: auto; margin: 5px; padding: 5px;'>"
		cum += "<img src='[m_pfp]' alt='x.x;' style='height: [img_size]px; width: [img_size]px; border-radius: 10px; margin-left: auto; margin-right: auto; margin-bottom: auto; text-align: center; object-fit: contain; padding: 7px'>"
		// cum += "</div>"
		cum += "</div>"

	// now the body - the BottomBox
	if(giv_body)
		cum += "<div style='width: 100%; background: linear-gradient([bbangle]deg, [bbc_1], [bbc_2]); border: [bbbs]px [bbbt] [bbbc]; padding: 2px; display: flex; flex-direction: column;'>"
		if(!no_boober_period)
			cum += "<p style='font-weight: bold; margin: 0;'>[m_name] <span style='[nobold_verb? "font-weight: normal;" : ""] font-style: italic; color: [dtc];'>[m_verb]</span></p>"
		if(!nomessage)
			cum += "<p style='margin: 0; color: [dtc]; id='Message'>[m_message]</p>"
		cum += "</div>"
	cum += "</div>"
	var/egg_surrounded_by_sperm = cum.Join() // the full message
	if(P.visualchat_use_contrasting_color)
		var/ccolr = get_contrasting_color(bbc_1, bbc_2)
		egg_surrounded_by_sperm = "<span style='color: [ccolr];'>" + egg_surrounded_by_sperm + "</span>"
	// now we need to send it to the target
	return egg_surrounded_by_sperm // ya know, how *is* babby formed?


/datum/controller/subsystem/chat/proc/get_horny_pfp(m_rawmessage, list/m_images, m_mode, list/imglist)
	// two-stace bytch of a process: First extract any custom modes, then dive in for modes, then just dump something
	var/modeimal = m_mode
	// now we have the modeimal, we can get the image!
	// they've already been sanitized, maybe
	var/fallback_boy = "[default_pfps[MALE]["Host"]]/[default_pfps[MALE]["URL"]]"
	for(var/list/maud in m_images)
		if(maud["Mode"] == MODE_SAY)
			fallback_boy = "[maud["Host"]]/[maud["URL"]]"
		if(maud["Mode"] == modeimal)
			imglist |= maud
			return "[maud["Host"]]/[maud["URL"]]" // eat my shorts, Jon
	// if we get here, we have an unsupported message mode, so just use Say
	return fallback_boy // the boy is back in town

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
	if(href_list["FLIRT"])
		var/mob/living/flirter = SSeconomy.quid2mob(href_list["sender_quid"])
		if(!flirter)
			return
		var/mob/living/target = SSeconomy.quid2mob(href_list["reciever_quid"])
		if(!target)
			return
		if(!flirter.client || !target.client)
			return
		SSchat.add_flirt_target(flirter, target)
		SSchat.ui_interact(flirter)
	if(href_list["INTERACT"])
		var/mob/living/fricker = SSeconomy.quid2mob(href_list["sender_quid"])
		if(!fricker)
			return
		var/mob/living/frackee = SSeconomy.quid2mob(href_list["reciever_quid"])
		if(!frackee)
			return
		if(!fricker.client || !frackee.client)
			return
		SEND_SIGNAL(frackee, COMSIG_CLICK_CTRL_SHIFT, fricker)
	if(href_list["CHARDIR"])
		var/mob/living/looker = SSeconomy.quid2mob(href_list["sender_quid"])
		if(!looker)
			return
		var/mob/living/lookee = SSeconomy.quid2mob(href_list["reciever_quid"])
		if(!lookee)
			return
		if(!looker.client || !lookee.client)
			return
		looker.true_examinate(lookee) // TRUE examinate EX

/datum/controller/subsystem/chat/proc/is_blocked(mob/sender, mob/reciever)
	return FALSE // if youre enough of a pest to need this, you're probably gonna get banned anyway

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
					return test_name // good news it still doesnt work, fml
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

/mob/verb/setup_coolchat()
	set name = "Setup VisualChat"
	set category = "Preferences"
	SSchat.HornyPreferences(src)

/mob/verb/setup_profilepics()
	set name = "Setup Profile Pics"
	set category = "Preferences"
	SSchat.HornyPreferences(src)

/mob/verb/check_out(mob/A as mob in view())
	set name = "Flirt with"
	set category = "Roleplaying"

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

/// Hi! I'm the thing that holds the stuff for the horny mommychat setup thing
/datum/horny_tgui_holder
	var/ownerkey
	/// HornyChat supports copypasting! Rejoice!
	var/list/clipboard = list()
	// var/datum/horny_stock_image_tgui_holder/hsith // dewit // on second thought, no


/datum/horny_tgui_holder/New(okey)
	. = ..()
	ownerkey = okey
	// hsith = new(ownerkey)

/datum/horny_tgui_holder/proc/OpenPrefsMenu()
	var/mob/M = ckey2mob(ownerkey)
	if(!M)
		return
	ui_interact(M)

/datum/horny_tgui_holder/ui_state(mob/user)
	return GLOB.always_state

/datum/horny_tgui_holder/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HornyChat") // yes Im calling it that // sike, its VisualChat now
		ui.open()


/datum/horny_tgui_holder/ui_static_data(mob/user)
	var/list/data = list()
	var/datum/preferences/P = extract_prefs(user)
	/// first, the stock images
	/// not using em lol
	/// then, the user's images
	SSchat.SanitizeUserImages(P)
	SSchat.SanitizeUserPreferences(P)
	data["AutoContrast"] = CHECK_PREFS(P, USE_AUTO_CONTRAST)
	data["SeeOthers"] = CHECK_PREFS(P, SHOW_ME_HORNY_FURRIES)
	data["UserImages"] = P.ProfilePics
	data["UserCKEY"] = user.ckey
	data["Clipboard"] = clipboard.Copy()
	data["imgsize"] = SSchat.img_size
	data["UserName"] = P.real_name
	var/list/vhosts = assoc_list_strip_value(GLOB.supported_img_hosts)
	data["ValidHosts"] = vhosts
	/// Also all the previews
	var/list/previewmsgs = list()
	/// Anatomy of a msgmode entry in ProfilePics:
	/// list(
	///      "NameOfTheMode" = list(
	///           "Host" = "www.catbox.moe", // or something
	///           "URL" = "image.png",
	///      ),
	/// etc
	/// )
	/// Anatomy of a preview message:
	/// list(
	///      list(
	///           "[msgmode]" = "long html thing"
	///      ),
	/// etc
	for(var/list/modus in P.ProfilePics)
		var/msgmode = modus["Mode"]
		var/message2say = "Hi."
		var/message2say2
		switch(msgmode)
			if(MODE_SAY)
				message2say = "Hello! You are hearing me talk. I am saying words. I am saying words to you. \
				I am saying words to you in a friendly manner. I am not yelling, I am not whispering, I am not singing, \
				I am not asking, I am not exclaiming. I am saying words to you, and you are hearing them. And now I am done. Hi."
			if(MODE_WHISPER)
				message2say = "#Psst, hey! Wanna know a secret? I'm whispering to you. This is what its like for you to \
				whisper, and what other people will see when you whisper to them. Does it look like I'm whispering? \
				You can tell by my profile picture that whispering is taking place. And now I'm done. Hi."
			if(MODE_SING)
				message2say = "%Allow me to sing the song of my people: ACK ACAKCHA AKGH CKCKHHGN YIP YIP YAKCGH EE EI EEI \
				GEKKER GEKKER ACK GACK AKCH TCHOFF AHC IA IA TEKALI-LI RLYEA CTHULHU FTAGHN YIPYIP! And now I'm done. Hi."
			if(MODE_ASK)
				message2say = "Hello? Is this thing on? So tell me, how many licks does it take to get to the center of a vixen? \
				Can you help me find out? Wanna go on a date and help em find out how many licks it takes to get to the center of a vixen? \
				What if it's more than one? What if it's less than one? What if it's exactly one? And now I'm done? Hi?"
			if(MODE_EXCLAIM)
				message2say = "Wow! I'm so excited! I'm so excited to be here! I'm so excited to be talking to you! \
				This is so exciting! I'm so excited! I'm so excited! I'm so excited! I'm so excited! I'm so excited! \
				I'm so excited! I'm so excited! I'm so excited! I'm so excited! I'm so excited! I'm so excited! \
				And now I'm done! Hi!"
			if(MODE_YELL)
				message2say = "$AAAAAAAAAAAAAAAAAAAAAAAA AAAAAA AAAAAAAAAA A AAAAAAAAAA AAAAAAAAAAAAAAAAAAAA AAAAAAAAA \
				AAAAAAAAA A AAA AAAAAAAAAAA AAAAAAAAAA AAAAAAAAAA AAA AAAAAAA AAAAAA AAAA A A AA AAAAAAAA AAA AAAA AAAA \
				AA A A AA A AAA A A AAAAAAAAAAAAAA AAA A A AAA  AAAAAAAAAAAA A AAAA A A A AA AAAAAAAAAAAAAAAAA AAAAAA \
				AND NOW IM DONE!! HI!!"
			if(MODE_PROFILE_PIC)
				continue // hi
			else
				message2say = "Hi, this is a test of a custom message mode that has been set by you to be used to display \
				a custom message mode. The mode is set to [replacetext(msgmode, ":","")]. If the previous sentence was \
				cut off, please make a note of it. Cool huh? And now I'm done. Hi. [msgmode]"
				message2say2 = "[msgmode]"
		var/msgmess = SSchat.PreviewHornyFurryDatingSimMessage(user, null, message2say, FALSE)
		if(message2say2)
			msgmess += "<p>[SSchat.PreviewHornyFurryDatingSimMessage(user, null, message2say2, FALSE)]</p>"
		previewmsgs += list(list("Mode" = msgmode, "Message" = msgmess))
	data["NumbermalMin"] = SSchat.numbermal_min
	data["NumbermalMax"] = SSchat.numbermal_max
	data["AnglemalMin"] = 0
	data["AnglemalMax"] = 360
	data["PreviewHTMLs"] = previewmsgs
	/// Then, the message appearance settings, its a mmouthful (just like your mom)
	/// arranged by tab of course of course
	data["TopBox"] = list()
	data["BottomBox"] = list()
	data["Buttons"] = list()
	data["OuterBox"] = list()
	data["ImageBox"] = list()
	for(var/mmode in P.mommychat_settings)
		if(mmode == MODE_PROFILE_PIC)
			continue // tchia uncle chuck
		// First, the top box settings
		var/list/topfox = list()
		topfox["Mode"] = mmode
		topfox["Name"] = "Top Box"
		topfox["Settings"] = list()
		topfox["Settings"] += list(
			list(
				"Name" = "Image Box Top Gradient Color",
				"Val" = P.mommychat_settings[mmode]["TopBoxGradient1"],
				"Type" = "COLOR",
				"Loc" = "L",
				"PKey" = "TopBoxGradient1",
				"Desc" = "The first color of the gradient for the section that contains the image for this message mode.",
				"Default" = "000000"
			),
			list(
				"Name" = "Image Box Bottom Gradient Color",
				"Val" = P.mommychat_settings[mmode]["TopBoxGradient2"],
				"Type" = "COLOR",
				"Loc" = "L",
				"PKey" = "TopBoxGradient2",
				"Desc" = "The second color of the gradient for the section that contains the image for this message mode.",
				"Default" = "000000"
			),
			list(
				"Name" = "Image Box Gradient Direction",
				"Val" = P.mommychat_settings[mmode]["TopBoxGradientAngle"],
				"Type" = "ANGLE",
				"Loc" = "L",
				"PKey" = "TopBoxGradientAngle",
				"Desc" = "The angle of the gradient for the section that contains the image for this message mode.",
				"Default" = "0"
			),
			list(
				"Name" = "Image Box Outer Border Color",
				"Val" = P.mommychat_settings[mmode]["TopBoxBorderColor"],
				"Type" = "COLOR",
				"Loc" = "R",
				"PKey" = "TopBoxBorderColor",
				"Desc" = "The color of the border for the section that contains the image for this message mode.",
				"Default" = "000000"
			),
			list(
				"Name" = "Image Box Outer Border Width",
				"Val" = P.mommychat_settings[mmode]["TopBoxBorderWidth"],
				"Type" = "NUMBER",
				"Loc" = "R",
				"PKey" = "TopBoxBorderWidth",
				"Desc" = "The width of the border for the section that contains the image for this message mode. Set to 0 to disable.",
				"Default" = "1"
			),
			list(
				"Name" = "Image Box Outer Border Style",
				"Val" = P.mommychat_settings[mmode]["TopBoxBorderStyle"],
				"Type" = "SELECT",
				"Loc" = "R",
				"PKey" = "TopBoxBorderStyle",
				"Desc" = "The style of the border for the section that contains the image for this message mode.",
				"Default" = "solid",
				"Options" = SSchat.borderstyles
			),
		)
		data["TopBox"] += list(topfox)
		// Then, the bottom box settings
		var/list/bottomfox = list()
		bottomfox["Mode"] = mmode
		bottomfox["Name"] = "Message Box"
		bottomfox["Settings"] = list()
		bottomfox["Settings"] += list(
			list(
				"Name" = "Message Box Top Gradient Color",
				"Val" = P.mommychat_settings[mmode]["BottomBoxGradient1"],
				"Type" = "COLOR",
				"Loc" = "L",
				"PKey" = "BottomBoxGradient1",
				"Desc" = "The first color of the gradient for the box that will contain your message.",
				"Default" = "000000"
			),
			list(
				"Name" = "Message Box Bottom Gradient Color",
				"Val" = P.mommychat_settings[mmode]["BottomBoxGradient2"],
				"Type" = "COLOR",
				"Loc" = "L",
				"PKey" = "BottomBoxGradient2",
				"Desc" = "The second color of the gradient for the box that will contain your message.",
				"Default" = "000000"
			),
			list(
				"Name" = "Message Box Gradient Direction",
				"Val" = P.mommychat_settings[mmode]["BottomBoxGradientAngle"],
				"Type" = "ANGLE",
				"Loc" = "L",
				"PKey" = "BottomBoxGradientAngle",
				"Desc" = "The angle of the gradient for the box that will contain your message.",
				"Default" = "0"
			),
			list(
				"Name" = "Message Box Outer Border Color",
				"Val" = P.mommychat_settings[mmode]["BottomBoxBorderColor"],
				"Type" = "COLOR",
				"Loc" = "R",
				"PKey" = "BottomBoxBorderColor",
				"Desc" = "The color of the border for the box that will contain your message.",
				"Default" = "000000"
			),
			list(
				"Name" = "Message Box Outer Border Width",
				"Val" = P.mommychat_settings[mmode]["BottomBoxBorderWidth"],
				"Type" = "NUMBER",
				"Loc" = "R",
				"PKey" = "BottomBoxBorderWidth",
				"Desc" = "The width of the border for the box that will contain your message. Set to 0 to disable.",
				"Default" = "1"
			),
			list(
				"Name" = "Message Box Outer Border Style",
				"Val" = P.mommychat_settings[mmode]["BottomBoxBorderStyle"],
				"Type" = "SELECT",
				"Loc" = "R",
				"PKey" = "BottomBoxBorderStyle",
				"Desc" = "The style of the border for the box that will contain your message.",
				"Default" = "solid",
				"Options" = SSchat.borderstyles
			),
		)
		data["BottomBox"] += list(bottomfox)
		// Then, the button settings
		var/list/buttonfox = list()
		buttonfox["Mode"] = mmode
		buttonfox["Name"] = "Buttons"
		buttonfox["Settings"] = list()
		buttonfox["Settings"] += list(
			list(
				"Name" = "Gradient 1",
				"Val" = P.mommychat_settings[mmode]["ButtonGradient1"],
				"Type" = "COLOR",
				"Loc" = "L",
				"PKey" = "ButtonGradient1",
				"Desc" = "The first color of the gradient for the buttons.",
				"Default" = "000000"
			),
			list(
				"Name" = "Gradient 2",
				"Val" = P.mommychat_settings[mmode]["ButtonGradient2"],
				"Type" = "COLOR",
				"Loc" = "L",
				"PKey" = "ButtonGradient2",
				"Desc" = "The second color of the gradient for the buttons.",
				"Default" = "000000"
			),
			list(
				"Name" = "Gradient Angle",
				"Val" = P.mommychat_settings[mmode]["ButtonGradientAngle"],
				"Type" = "ANGLE",
				"Loc" = "L",
				"PKey" = "ButtonGradientAngle",
				"Desc" = "The angle of the gradient for the buttons.",
				"Default" = "0"
			),
			list(
				"Name" = "Border Color",
				"Val" = P.mommychat_settings[mmode]["ButtonBorderColor"],
				"Type" = "COLOR",
				"Loc" = "R",
				"PKey" = "ButtonBorderColor",
				"Desc" = "The color of the border for the buttons.",
				"Default" = "000000"
			),
			list(
				"Name" = "Border Width",
				"Val" = P.mommychat_settings[mmode]["ButtonBorderWidth"],
				"Type" = "NUMBER",
				"Loc" = "R",
				"PKey" = "ButtonBorderWidth",
				"Desc" = "The width of the border for the buttons.",
				"Default" = "1"
			),
			list(
				"Name" = "Border Style",
				"Val" = P.mommychat_settings[mmode]["ButtonBorderStyle"],
				"Type" = "SELECT",
				"Loc" = "R",
				"PKey" = "ButtonBorderStyle",
				"Desc" = "The style of the border for the buttons.",
				"Default" = "solid",
				"Options" = SSchat.borderstyles
			),
		)
		data["Buttons"] += list(buttonfox) // unused
		/// Then, the Image Border settings
		var/list/imagefox = list()
		imagefox["Mode"] = mmode
		imagefox["Name"] = "Image Border"
		imagefox["Settings"] = list()
		imagefox["Settings"] += list(
			list(
				"Name" = "Border Color",
				"Val" = P.mommychat_settings[mmode]["ImageBorderBorderColor"],
				"Type" = "COLOR",
				"Loc" = "R",
				"PKey" = "ImageBorderBorderColor",
				"Desc" = "The color of the border for the images.",
				"Default" = "000000"
			),
			list(
				"Name" = "Border Width",
				"Val" = P.mommychat_settings[mmode]["ImageBorderBorderWidth"],
				"Type" = "NUMBER",
				"Loc" = "R",
				"PKey" = "ImageBorderBorderWidth",
				"Desc" = "The width of the border for the images.",
				"Default" = "1"
			),
			list(
				"Name" = "Border Style",
				"Val" = P.mommychat_settings[mmode]["ImageBorderBorderStyle"],
				"Type" = "SELECT",
				"Loc" = "R",
				"PKey" = "ImageBorderBorderStyle",
				"Desc" = "The style of the border for the images.",
				"Default" = "solid",
				"Options" = SSchat.borderstyles
			),
		)
		data["ImageBox"] += list(imagefox) // unused
		/// And finally the Outer Box settings
		var/list/outerfox = list()
		outerfox["Mode"] = mmode
		outerfox["Name"] = "Outer Box"
		outerfox["Settings"] = list()
		outerfox["Settings"] += list(
			list(
				"Name" = "Outer Box Border Color",
				"Val" = P.mommychat_settings[mmode]["OuterBoxBorderColor"],
				"Type" = "COLOR",
				"Loc" = "R",
				"PKey" = "OuterBoxBorderColor",
				"Desc" = "The color of the border that will go around the entire message box.",
				"Default" = "000000"
			),
			list(
				"Name" = "Outer Box Border Width",
				"Val" = P.mommychat_settings[mmode]["OuterBoxBorderWidth"],
				"Type" = "NUMBER",
				"Loc" = "R",
				"PKey" = "OuterBoxBorderWidth",
				"Desc" = "The width of the border that will go around the entire message box. Set to 0 to disable.",
				"Default" = "1"
			),
			list(
				"Name" = "Outer Box Border Style",
				"Val" = P.mommychat_settings[mmode]["OuterBoxBorderStyle"],
				"Type" = "SELECT",
				"Loc" = "R",
				"PKey" = "OuterBoxBorderStyle",
				"Desc" = "The style of the border that will go around the entire message box.",
				"Default" = "solid",
				"Options" = SSchat.borderstyles
			),
		)
		data["OuterBox"] += list(outerfox)
	return data

/* 
 * IMPORTANT NAMING CONVENTIONS
 * Strings sent TO TGUI are in the format "ModeName" (e.g. "TopBoxGradient1")
 * Strings sent FROM TGUI are in the format "ModeName" (e.g. "TopBoxGradient1")
 * Clipboard VALUES STORED in the format "lowercase_name" (e.g. "profilepic")
 * Clipboard are SENT TO TGUI in the format "ModeName" (e.g. "ProfilePic")
 * Horny Images are stored as BYOND sees them in the code (e.g. "say" or "%")
 * screw it, everything is in ModeName format
 * 
 *  */
/datum/horny_tgui_holder/ui_act(action, list/params)
	. = ..()
	if(!params["UserCkey"])
		return
	var/mob/M = ckey2mob(params["UserCkey"])
	if(!M)
		return
	var/datum/preferences/P = extract_prefs(M)
	if(!P)
		return
	switch(action)
		if("ToggleWhinyLittleBazingaMode")
			TOGGLE_BITFIELD(P.chat_toggles, CHAT_SEE_COOLCHAT)
			if(CHECK_BITFIELD(P.chat_toggles, CHAT_SEE_COOLCHAT))
				to_chat(M, span_notice("You will now see VisualChat messages!"))
			else
				to_chat(M, span_notice("You will now see boring normal chat messages!"))
			. = CHANGED_NOTHING
		if("OpenPerchance")
			var/yiffme = alert(
				M,
				"This link will take you to an AI furry profile picture generator, hosted at https://perchance.org/furry-ai . \
				Be aware that the site will happily generate NSFW images, so be careful when using it. \
				Proceed?",
				"Okay",
				"Okay",
				"Cancel",
			)
			if(yiffme == "Okay")
				M << link("https://perchance.org/furry-ai")
				to_chat(M, span_notice("Opening Perchance..."))
				to_chat(M, span_notice("If you're not redirected, please click here: <a href='https://perchance.org/furry-ai'>Perchance</a>"))
				. = CHANGED_NOTHING
			else
				to_chat(M, span_alert("Never mind!!"))
				. = CHANGED_NOTHING
		if("OpenCatbox")
			var/yiffme = alert(
				M,
				"This link will take you to Catbox.moe, an image hosting site that is popular with the furry community. \
				You can upload images here and use them as profile pictures. Do note that you'll need to write down the \
				URL of the image you upload, as Catbox won't be able to provide it for you after you close the tab. \
				Proceed?",
				"Okay",
				"Okay",
				"Cancel"
			)
			if(yiffme == "Okay")
				M << link("https://catbox.moe")
				to_chat(M, span_notice("Opening Catbox..."))
				to_chat(M, span_notice("If you're not redirected, please click here: <a href='https://catbox.moe'>Catbox</a>"))
				. = CHANGED_NOTHING
			else
				to_chat(M, span_alert("Never mind!!"))
				. = CHANGED_NOTHING
		if("OpenGyazo")
			var/yiffme = alert(
				M,
				"This link will take you to Gyazo, an image hosting site that both hosts images and also exists. \
				You can upload images here and use them as profile pictures. Proceed?",
				"Okay",
				"Okay",
				"Cancel"
			)
			if(yiffme == "Okay")
				M << link("https://gyazo.com")
				to_chat(M, span_notice("Opening Gyazo..."))
				to_chat(M, span_notice("If you're not redirected, please click here: <a href='https://gyazo.com'>Gyazo</a>"))
				. = CHANGED_NOTHING
			else
				to_chat(M, span_alert("Never mind!!"))
				. = CHANGED_NOTHING
		if("SaveEverything")
			to_chat(M, span_notice("Saving all changes..."))
			// all the settings are autosaved, so this is just to make you feel better
		if("ChangeTextColor")
			to_chat(M, span_notice("Change your Runechat color! Neat!"))
			. = CHANGED_NOTHING
			M.change_chat_color(TRUE)
		if("ToggleAutoContrast")
			TOGGLE_VAR(P.visualchat_use_contrasting_color)
			if(P.visualchat_use_contrasting_color)
				to_chat(M, span_notice("AutoContrast is now enabled! The non-personalized text in your messages (emotes, etc) will now attempt to use a contrasting color."))
			else
				to_chat(M, span_notice("AutoContrast is now disabled! The non-personalized text in your messages (emotes, etc) will follow the light/dark mode settings of the VIEWER! This could get ugly, so, yeah."))
			. = CHANGED_NOTHING
		if("ToggleRadioHorny")
			TOGGLE_VAR(P.visualchat_see_horny_radio)
			if(P.visualchat_see_horny_radio)
				to_chat(M, span_notice("You will see a (smallified) VisualChat message when people use the radio!"))
			else
				to_chat(M, span_notice("You will no longer see VisualChat messages when people use the radio!"))
			. = CHANGED_NOTHING
		if("ModifyHost")
			var/mode = params["Mode"]
			var/newhost = params["NewHost"]
			if(!(newhost in GLOB.supported_img_hosts))
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], host is not supported! :c"))
				return FALSE
			for(var/list/PPc in P.ProfilePics)
				if(PPc["Mode"] != mode)
					continue
				PPc["Host"] = newhost
				to_chat(M, span_notice("Host for [SSchat.mode2string(mode)] has been updated to [newhost]!"))
				. = CHANGED_IMAGES
				break
			if(!.)
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
			else
				to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been updated!"))
		if("ModifyURL")
			var/mode = params["Mode"]
			var/newurl = params["NewURL"]
			/// rudimar, we need to check if the URL is valid
			/// rudimar: we can do that by checking if the URL is a valid URL
			if(!newurl || !istext(newurl) || !LAZYLEN(newurl))
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], URL cannot be empty! :c"))
				return FALSE
			var/valid = TRUE
			var/list/splittest = splittext(newurl, ".")
			if(!(uppertext(LAZYACCESS(splittest,LAZYLEN(splittest))) in GLOB.supported_img_exts))
				valid = FALSE
			if(!valid)
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], URL is not valid! :c"))
				return FALSE
			/// rudimar, we need to check if the URL is a valid URL
			/// actually we dont, but im just gonna filter out any domains that got pasted in
			/// rudimar: oh, okay // also extract the domain from the URL, if it exists
			var/newhost
			spank:
				for(var/hoste in GLOB.supported_img_hosts)
					var/list/checkemup = list(hoste) + GLOB.supported_img_hosts[hoste]
					for(var/checc in checkemup)
						if(findtext(newurl, checc))
							var/list/splup = splittext(newurl, "/")
							newurl = LAZYACCESS(splup, LAZYLEN(splup)) // get the last part of the URL
							newhost = hoste
							break spank // thats going in the spank break
			for(var/list/PPc in P.ProfilePics)
				if(PPc["Mode"] != mode)
					continue
				PPc["URL"] = newurl
				if(!isnull(newhost))
					PPc["Host"] = newhost // UX SUPREME
				if(mode == MODE_PROFILE_PIC)
					PPc["Suppress"] = TRUE
				to_chat(M, span_notice("URL for [SSchat.mode2string(mode)] has been updated to [newurl]!"))
				. = CHANGED_IMAGES
				break
			if(!.)
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
			else
				to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been updated!"))
		if("ModifyModename")
			var/mode = params["Mode"]
			var/newname = params["NewName"]
			if(mode in SSchat.mandatory_modes)
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], mode is not renamable! :c"))
				return FALSE
			newname = ckey(newname)
			if(newname == "" || !istext(newname) || !LAZYLEN(newname))
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], mode name cannot be empty! :c"))
				return FALSE
			var/firstie = newname[1] // liek, zomg firstie^^;
			var/lastie = newname[LAZYLEN(newname)]
			if(firstie != ":")
				newname = ":"+newname
			if(lastie != ":")
				newname = newname+":"
			for(var/list/PPc in P.ProfilePics)
				if(PPc["Mode"] != mode)
					continue
				PPc["Mode"] = newname
				to_chat(M, span_notice("Mode name for [SSchat.mode2string(mode)] has been updated to [newname]!"))
				. = CHANGED_IMAGES
				break
			if(!.)
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
			else
				to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been updated!"))
		if("ModifyCustomBlankVerb") // if someone just types :bazinga:, show this message instead
			var/mode = params["Mode"]
			var/newmsg = params["NewMessage"]
			// if(mode in SSchat.mandatory_modes)
			// 	to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], mode is not modifiable! :c"))
			// 	return FALSE
			newmsg = replacetext(newmsg, @"\n", "")
			if(!newmsg || !istext(newmsg) || !LAZYLEN(newmsg))
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], message cannot be empty! :c"))
				return FALSE
			for(var/list/PPc in P.ProfilePics)
				if(PPc["Mode"] != mode)
					continue
				PPc["CustomBlankVerb"] = newmsg
				to_chat(M, span_notice("Custom default message for [SSchat.mode2string(mode)] has been updated!"))
				. = CHANGED_IMAGES
				break
			if(!.)
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
			else
				to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been updated!"))
		if("ModifyCustomMessageVerb") // if someone just types :bazinga:, show this verb as the message mode instead
			var/mode = params["Mode"]
			var/newverb = params["NewVerb"]
			// if(mode in SSchat.mandatory_modes) // not that they can use it anyway
			// 	to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], mode is not modifiable! :c"))
			// 	return FALSE
			if(!newverb || !istext(newverb) || !LAZYLEN(newverb))
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], verb cannot be empty! :c"))
				return FALSE
			for(var/list/PPc in P.ProfilePics)
				if(PPc["Mode"] != mode)
					continue
				PPc["CustomMessageVerb"] = newverb
				to_chat(M, span_notice("Custom default verb for [SSchat.mode2string(mode)] has been updated!"))
				. = CHANGED_IMAGES
				break
			if(!.)
				to_chat(M, span_alert("Unable to modify profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
			else
				to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been updated!"))
		if("AddProfileEntry")
			var/list/new_entry = list(
				"Mode" = ":[safepick(GLOB.ing_verbs)][safepick(GLOB.adverbs)]:",
				"Host" = params["Host"],
				"URL" = params["URL"],
				"Modifiable" = TRUE,
			)
			P.ProfilePics += list(new_entry)
			to_chat(M, span_notice("Profile entry for [SSchat.mode2string(new_entry["Mode"])] has been added!"))
			. = CHANGED_IMAGES
		if("ClearProfileEntry")
			var/mode = params["Mode"]
			for(var/i in 1 to LAZYLEN(P.ProfilePics))
				var/list/PPc = P.ProfilePics[i]
				if(PPc["Mode"] != mode)
					continue
				if(mode in SSchat.mandatory_modes)
					// just reset it
					switch(P.gender)
						if(MALE)
							PPc["Host"] = SSchat.default_pfps[MALE]["Host"]
							PPc["URL"] = SSchat.default_pfps[MALE]["URL"]
						if(FEMALE)
							PPc["Host"] = SSchat.default_pfps[FEMALE]["Host"]
							PPc["URL"] = SSchat.default_pfps[FEMALE]["URL"]
						else
							if(prob(50))
								PPc["Host"] = SSchat.default_pfps[MALE]["Host"]
								PPc["URL"] = SSchat.default_pfps[MALE]["URL"]
							else
								PPc["Host"] = SSchat.default_pfps[FEMALE]["Host"]
								PPc["URL"] = SSchat.default_pfps[FEMALE]["URL"]
					to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been reset!"))
					. = CHANGED_IMAGES
					break
				else
					P.ProfilePics.Cut(i, i+1) // surgical and sexy
					to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been removed!"))
					. = CHANGED_IMAGES
					break
			if(!.)
				to_chat(M, span_alert("Unable to clear profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
		/// hey github copilot, what is your favorite color of fox?
		/// "I like
		/// the color of
		/// the fox
		/// that is
		/// the color
		/// of the
		/// fox that
		/// is the
		/// color of
		/// the fox // good talking to you, copilot
		if("CopyImage")
			var/mode = params["Mode"]
			var/list/ProfilePics = P.ProfilePics
			var/list/fount
			for(var/list/entry in ProfilePics)
				if(entry["Mode"] == mode)
					fount = entry
			if(fount) //
				var/list/clip = list(
					"Mode" = fount["Mode"],
					"Host" = fount["Host"],
					"URL" = fount["URL"],
				)
				clipboard["ProfilePic"] = clip
				to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been copied to the clipboard!"))
				. = CHANGED_IMAGES
			else
				to_chat(M, span_alert("Unable to copy profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
		if("PasteImage")
			var/mode = params["Mode"] // the mode it will be pasted to
			var/list/clip = clipboard["ProfilePic"]
			if(clip)
				for(var/i in 1 to LAZYLEN(P.ProfilePics))
					var/list/entry = P.ProfilePics[i]
					if(entry["Mode"] != mode) // find the entry to replace, and overwrite it
						continue
					P.ProfilePics[i]["Host"] = clip["Host"]
					P.ProfilePics[i]["URL"] = clip["URL"]
					to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been pasted from the clipboard!"))
					. = CHANGED_IMAGES
				if(. != CHANGED_IMAGES)
					to_chat(M, span_alert("Unable to paste profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
					return FALSE
			else
				to_chat(M, span_alert("Unable to paste profile entry for [SSchat.mode2string(mode)], clipboard is empty! :c"))
				return FALSE
		if("ClearProfileEntry")
			var/mode = params["Mode"]
			var/list/ProfilePics = P.ProfilePics
			var/list/fount
			for(var/list/entry in ProfilePics)
				if(entry["Mode"] == mode)
					fount = entry
			if(fount)
				if(mode in SSchat.mandatory_modes)
					// just reset it
					fount["Host"] = "www.catbox.moe"
					switch(mode)
						if(MODE_SAY)
							fount["URL"] = "say.png" // replace these
						if(MODE_WHISPER)
							fount["URL"] = "whisper.png" // with the actual
						if(MODE_SING)
							fount["URL"] = "sing.png" // images
						if(MODE_ASK)
							fount["URL"] = "ask.png" // for the
						if(MODE_EXCLAIM)
							fount["URL"] = "exclaim.png" // modes
						if(MODE_YELL)
							fount["URL"] = "yell.png" // you yiff
						else
							fount["URL"] = "say.png" // you lose
					to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been reset!"))
				else
					ProfilePics -= fount
					to_chat(M, span_notice("Profile entry for [SSchat.mode2string(mode)] has been removed!"))
				. = CHANGED_IMAGES
			else
				to_chat(M, span_alert("Unable to clear profile entry for [SSchat.mode2string(mode)], entry not found! :c"))
				return FALSE
		if("EditColor") // we'll handle this one
			var/pisskey = params["PKey"]
			var/mode = params["Mode"]
			var/current = params["Current"]
			if(!(pisskey in SSchat.colorable_keys))
				to_chat(M, span_alert("Unable to edit color for [SSchat.mode2string(mode)], mode is not colorable! This is probably a bug :c"))
				return FALSE
			var/list/geosites = list(
				"Tripod like a real AngelFire",
				"Lycos like a real Tripod",
				"Your free website from Geocities",
				"MySpace up your webring",
				"Your free trial of Dreamweaver 4 has expired",
				"Navigate this Netscape in style",
				"Your free trial of FrontPage 98 has expired",
				"Web 2.0 like a real Web 1.0",
				"Altavista like a real AskJeeves",
				"Dear LiveJournal, I'm sorry I left you for Tumblr",
				"Eudora like a real Outlook Express",
				"Welcome to the World Wide Web",
				"You're the 1,000,000th visitor to this site!",
				"Website under construction",
				"Guaranteed websafe colors",
				"Best viewed in Internet Explorer 4",
				"Best viewed in Netscape Navigator 4",
				"VCL like a real Elfwood",
			) // Gradually, the web 1.0 sites are disappearing. But they're still here, in our hearts and yiffy posts
			var/val = input(
				M,
				"Enter a new color for the [pisskey] of the [SSchat.mode2string(mode)]!",
				"[safepick(geosites)]",
				current
			) as color|null
			if(!istext(val))
				to_chat(M, span_alert("Nevermind!!"))
				return FALSE
			P.mommychat_settings[mode][pisskey] = val
			to_chat(M, span_notice("Color for [SSchat.mode2string(mode)] [pisskey] has been updated to [val]!"))
			. = CHANGED_SETTINGS
		if("EditNumber") // TGUI handled this one
			var/pisskey = params["PKey"]
			var/mode = params["Mode"]
			var/newval = params["Val"]
			if(!(pisskey in SSchat.numberable_keys) && !(pisskey in SSchat.angleable_keys))
				to_chat(M, span_alert("Unable to edit number for [SSchat.mode2string(mode)], mode is not numberable! This is probably a bug :c"))
				return FALSE
			if(pisskey in SSchat.angleable_keys)
				// sanitize the angle to be between 0 and 360, even if its negative
				var/firstbulk = 360 * 100
				var/secondbulk = newval + firstbulk
				if(secondbulk < 0)
					secondbulk = abs(secondbulk) // we
				var/thirdbulk = secondbulk % firstbulk
				newval = thirdbulk
			P.mommychat_settings[mode][pisskey] = newval
			to_chat(M, span_notice("Number for [SSchat.mode2string(mode)] [pisskey] has been updated to [newval]!"))
			. = CHANGED_SETTINGS
		if("EditSelect") // TGUI handled this one
			var/pisskey = params["PKey"]
			var/mode = params["Mode"]
			var/newval = params["Val"]
			if(!(pisskey in SSchat.selectable_keys))
				to_chat(M, span_alert("Unable to edit select for [SSchat.mode2string(mode)], mode is not selectable! This is probably a bug :c"))
				return FALSE
			P.mommychat_settings[mode][pisskey] = newval
			to_chat(M, span_notice("Select for [SSchat.mode2string(mode)] [pisskey] has been updated to [newval]!"))
			. = CHANGED_SETTINGS
		if("CopySetting")
			var/pisskey = params["PKey"] // the setting key
			var/mode = params["Mode"]
			var/typekind = params["Type"]
			var/list/horny_settings = P.mommychat_settings
			var/list/hornier_settings = LAZYACCESS(horny_settings, mode)
			var/found_value = LAZYACCESS(hornier_settings, pisskey)
			if(!isnull(found_value))
				var/list/clip = list(
					"Mode" = "[mode]",
					"PKey" = "[pisskey]",
					"Type" = "[typekind]",
					"Val" = found_value,
				)
				clipboard["MsgSetting"] = clip
				to_chat(M, span_notice("Setting for [SSchat.mode2string(mode)] [pisskey] has been copied to the clipboard!"))
				. = CHANGED_SETTINGS
			else
				to_chat(M, span_alert("Unable to copy setting for [SSchat.mode2string(mode)] [pisskey], setting not found! :c"))
				return FALSE
		if("PasteSetting")
			var/pisskey = params["PKey"]
			var/mode = params["Mode"]
			var/list/horny_settings = P.mommychat_settings
			var/list/clip = clipboard["MsgSetting"]
			if(clip)
				// first check if this setting can accept the value
				if((clip["PKey"] in SSchat.colorable_keys) && (pisskey in SSchat.colorable_keys)\
				|| (clip["PKey"] in SSchat.numberable_keys) && (pisskey in SSchat.numberable_keys)\
				|| (clip["PKey"] in SSchat.selectable_keys) && (pisskey in SSchat.selectable_keys)\
				|| (clip["PKey"] in SSchat.angleable_keys) && (pisskey in SSchat.angleable_keys))
					horny_settings[mode][pisskey] = clip["Val"]
					to_chat(M, span_notice("Setting for [SSchat.mode2string(mode)] [pisskey] has been pasted from the clipboard!"))
					. = CHANGED_SETTINGS
				else
					to_chat(M, span_alert("Unable to paste setting for [SSchat.mode2string(mode)] [pisskey], setting type mismatch! :c"))
					return FALSE
			else
				to_chat(M, span_alert("Unable to paste setting for [SSchat.mode2string(mode)] [pisskey], clipboard is empty! :c"))
				return FALSE
		if("CopyModeSettings")
			var/mode = params["Mode"]
			var/list/horny_settings = P.mommychat_settings
			var/list/hornier_settings = LAZYACCESS(horny_settings, mode)
			if(LAZYLEN(hornier_settings)) // dont need to check too hard, just make sure its valid
				clipboard["MessageAppearance"] = mode
				to_chat(M, span_notice("Settings for [SSchat.mode2string(mode)] have been copied to the clipboard!"))
				. = CHANGED_SETTINGS
			else
				to_chat(M, span_alert("Unable to copy settings for [SSchat.mode2string(mode)], mode not found! :c"))
				return FALSE
		if("PasteModeSettings")
			var/mode = params["Mode"] // mode that will be pasted to
			var/list/horny_settings = P.mommychat_settings
			var/clipmode = clipboard["MessageAppearance"]
			if(clipmode)
				var/list/clipsettings = LAZYACCESS(horny_settings, clipmode)
				if(LAZYLEN(clipsettings) == LAZYLEN(horny_settings[mode]))
					horny_settings[mode] = clipsettings
					to_chat(M, span_notice("Settings for [SSchat.mode2string(mode)] have been pasted from the clipboard!"))
					. = CHANGED_SETTINGS
				else
					to_chat(M, span_alert("Unable to paste settings for [SSchat.mode2string(mode)], setting verification can mismatch! :c"))
					return FALSE
			else
				to_chat(M, span_alert("Unable to paste settings for [SSchat.mode2string(mode)], clipboard is empty! :c"))
				return FALSE
	if(.)
		update_static_data(M)
		if(. != CHANGED_NOTHING)
			// we need to update the settings and pics to match
			SSchat.CoordinateSettingsAndPics(P, .)
		P.save_character()


#undef CHANGED_SETTINGS
#undef CHANGED_IMAGES
#undef CHANGED_NOTHING

/* todo: this
/// Say it with me, "Anything a frickhuge list can do, a datum can do better"
/datum/horny_setting
	var/title // the title of the setting
	var/tooltip // the description of the setting
	var/group // the group of the setting
	var/location // the location of the setting
	var/setting_key // the key of the setting
	var/setting_type // the type of the setting
	var/setting_default // the default value of the setting
	var/setting_options // the options for the setting
	var/num_max // the maximum number for the setting
	var/num_min // the minimum number for the setting
	var/default // the default value of the setting

/datum/horny_setting/New()
	. = ..()
	SSchat.horny_settings[group] = src

/datum/horny_setting/proc/tgui_slug(list/mommy, mode)
	if(!LAZYLEN(mommy) || !mode)
		return
	var/list/data = list()
	var/list/setformode = LAZYACCESS(mommy, mode)
	var/current = LAZYACCESS(setformode, setting_key)
	data["Name"] = title
	data["Tooltip"] = tooltip
	data["Group"] = group
	data["Loc"] = location
	data["PKey"] = setting_key
	data["Type"] = setting_type
	data["Default"] = setting_default
	data["Options"] = setting_options
	data["NumMax"] = num_max
	data["NumMin"] = num_min
	data["Val"] = current
	return data
 */





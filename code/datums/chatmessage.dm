#define CHAT_MESSAGE_SPAWN_TIME		0.5 SECONDS
#define CHAT_MESSAGE_LIFESPAN		12 SECONDS
#define CHAT_MESSAGE_EOL_FADE		5.0 SECONDS
#define CHAT_MESSAGE_EXP_DECAY		0.5 // Messages decay at pow(factor, idx in stack)
#define CHAT_MESSAGE_HEIGHT_DECAY	0.4 // Increase message decay based on the height of the message
#define CHAT_MESSAGE_APPROX_LHEIGHT	11 // Approximate height in pixels of an 'average' line, used for height decay
#define CHAT_MESSAGE_WIDTH			150 // pixels
#define CHAT_MESSAGE_MAX_WIDTH		9999 // pixels
#define CHAT_MESSAGE_MAX_LENGTH		9999 // characters
#define CHAT_MESSAGE_LENGTH_DEFAULT	300 // characters

// GLOBAL_LIST_EMPTY(verbal_punch_lasers)

/**
 * # Chat Message Overlay
 *
 * Datum for generating a message overlay on the map
 */
/datum/chatmessage
	/// The visual element of the chat messsage
	var/image/message
	/// The location in which the message is appearing
	var/atom/message_loc
	/// The client who heard this message
	var/client/owned_by
	/// Contains the scheduled destruction time
	var/scheduled_destruction
	/// Contains the approximate amount of lines for height decay
	var/approx_lines
	/// is offscreen? put it somewhere they can see it then
	var/offscreen
	/// is eavesdrop? if so, make it smaller
	var/eavesdrop
	/// an alternative turf to display the message at
	var/turf/alt_display

/**
 * Constructs a chat message overlay
 *
 * Arguments:
 * * text - The text content of the overlay
 * * target - The target atom to display the overlay at
 * * owner - The mob that owns this overlay, only this mob will be able to view it
 * * extra_classes - Extra classes to apply to the span that holds the text
 * * lifespan - The lifespan of the message in deciseconds
 */
/datum/chatmessage/New(text, atom/target, mob/owner, list/extra_classes = list(), lifespan = CHAT_MESSAGE_LIFESPAN, list/data = list(), datum/rental_mommy/chat/mommy = null)
	. = ..()
	if (!istype(target))
		CRASH("Invalid target given for chatmessage")
	if(QDELETED(owner) || !istype(owner) || !owner.client)
		stack_trace("/datum/chatmessage created with [isnull(owner) ? "null" : "invalid"] mob owner")
		qdel(src)
		return
	if(CHECK_PREFS(owner, SEE_FANCY_OFF_SCREEN_RUNECHAT))
		if(mommy)
			if(mommy.display_turf && mommy.display_turf != target)
				alt_display = mommy.display_turf
				offscreen = TRUE
		else
			alt_display = data["display_turf"] || null
			if((get_dist(owner, (alt_display || target)) > 6 || data["is_far"])) // SD screens are 7 radius, but the UI covers a bit of that
				offscreen = TRUE
	eavesdrop = data["is_eaves"] || FALSE
	INVOKE_ASYNC(src,PROC_REF(generate_image), text, target, owner, extra_classes, lifespan)

/datum/chatmessage/Destroy()
	if (owned_by)
		if (owned_by.seen_messages)
			LAZYREMOVEASSOC(owned_by.seen_messages, message_loc, src)
		owned_by.images.Remove(message)
	owned_by = null
	message_loc = null
	message = null
	alt_display = null
	return ..()

/**
 * Calls qdel on the chatmessage when its parent is deleted, used to register qdel signal
 */
/datum/chatmessage/proc/on_parent_qdel()
	qdel(src)

/**
 * Generates a chat message image representation
 *
 * Arguments:
 * * text - The text content of the overlay
 * * target - The target atom to display the overlay at
 * * owner - The mob that owns this overlay, only this mob will be able to view it
 * * extra_classes - Extra classes to apply to the span that holds the text
 * * lifespan - The lifespan of the message in deciseconds
 */
/datum/chatmessage/proc/generate_image(text, atom/target, mob/owner, list/extra_classes, lifespan)
	// Register client who owns this message
	owned_by = owner.client
	RegisterSignal(owned_by, COMSIG_PARENT_QDELETING,PROC_REF(on_parent_qdel))

	// Clip message
	var/maxlen = owned_by.prefs.max_chat_length
	if (length_char(text) > maxlen)
		text = copytext_char(text, 1, maxlen + 1) + "..." // BYOND index moment

	// Calculate target color if not already present
	if (!target.chat_color || target.chat_color_name != target.name)
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/chatcolor = C.dna.features["chat_color"]
			if(chatcolor == "whoopsie")
				target.chat_color = colorize_string(target.name)
				target.chat_color_darkened = colorize_string(target.name, 0.85, 0.85)
				target.chat_color_name = target.name
			else
				target.chat_color = "#[chatcolor]"
				target.chat_color_darkened = "#[chatcolor]"
				target.chat_color_name = target.name
		else
			target.chat_color = colorize_string(target.name)
			target.chat_color_darkened = colorize_string(target.name, 0.85, 0.85)
			target.chat_color_name = target.name

	// Get rid of any URL schemes that might cause BYOND to automatically wrap something in an anchor tag
	var/static/regex/url_scheme = new(@"[A-Za-z][A-Za-z0-9+-\.]*:\/\/", "g")
	text = replacetext(text, url_scheme, "")

	// Reject whitespace
	var/static/regex/whitespace = new(@"^\s*$")
	if (whitespace.Find(text))
		qdel(src)
		return

	// Non mobs speakers can be small
	if (!ismob(target))
		extra_classes |= "small"
	
	var/list/prefixes

	// Append radio icon if from a virtual speaker
	if (extra_classes.Find("virtual-speaker"))
		var/image/r_icon = image('icons/ui_icons/chat/chat_icons.dmi', icon_state = "radio")
		LAZYADD(prefixes, "\icon[r_icon]")
	else if (extra_classes.Find("emote"))
		var/image/r_icon = image('icons/ui_icons/chat/chat_icons.dmi', icon_state = "emote")
		LAZYADD(prefixes, "\icon[r_icon]")

	if(prefixes)
		text = "[prefixes.Join("&nbsp;")][text]"

	// We dim italicized text to make it more distinguishable from regular text
	var/tgt_color = extra_classes.Find("italics") ? target.chat_color_darkened : target.chat_color
	// Approximate text height
	// Note we have to replace HTML encoded metacharacters otherwise MeasureText will return a zero height
	// BYOND Bug #2563917
	// Construct text
	var/static/regex/html_metachars = new(@"&[A-Za-z]{1,7};", "g")
	var/complete_text = "<span class='center maptext [extra_classes.Join(" ")]' style='color: [tgt_color]'>[owner.say_emphasis(text)]</span>"
	var/mheight = WXH_TO_HEIGHT(owned_by?.MeasureText(replacetext(complete_text, html_metachars, "m"), null, CHAT_MESSAGE_WIDTH))
	approx_lines = max(1, mheight / CHAT_MESSAGE_APPROX_LHEIGHT)

	// Translate any existing messages upwards, apply exponential decay factors to timers
	var/atom/remembered_location = alt_display || target
	message_loc = alt_display || target
	// if(offscreen && get_dist(owner, target) > 6) // SD screens are 7 radius, but the UI covers a bit of that
	// 	var/turf/ownerturf = get_turf(owner)
	// 	var/turf/targetturf = get_turf(message_loc)
	// 	var/westest = max(ownerturf.x - 7, 1)
	// 	var/eastest = min(ownerturf.x + 7, world.maxx)
	// 	var/northest = max(ownerturf.y - 7, 1)
	// 	var/southest = min(ownerturf.y + 6, world.maxy)
	// 	var/list/turfe = getline(targetturf, ownerturf)
	// 	var/turf/where = null
	// 	for(var/turf/check in turfe)
	// 		if(SSchat.debug_chud)
	// 			new /obj/effect/temp_visual/monkeyify(check)
	// 		if(!TURF_IN_RECTANGLE(check, westest, northest, eastest, southest))
	// 			continue
	// 		if(!(check in view(10, ownerturf)))
	// 			continue
	// 		message_loc = check
	// 		where = check
	// 		if(SSchat.debug_chud)
	// 			new /obj/effect/temp_visual/love_heart(message_loc)
	// 		break
	// 	if(!where)
	// 		message_loc = ownerturf // whatevs
	if(!owned_by)
		return
	if (owned_by.seen_messages)
		var/idx = 1
		var/combined_height = approx_lines
		for(var/msg in owned_by.seen_messages[remembered_location])
			var/datum/chatmessage/m = msg
			if(m.message)
				animate(m.message, pixel_y = m.message.pixel_y + mheight, time = CHAT_MESSAGE_SPAWN_TIME)
				combined_height += m.approx_lines
				var/sched_remaining = m.scheduled_destruction - world.time
				if (sched_remaining > CHAT_MESSAGE_SPAWN_TIME)
					var/remaining_time = (sched_remaining) * (CHAT_MESSAGE_EXP_DECAY ** idx++) * (CHAT_MESSAGE_HEIGHT_DECAY ** combined_height)
					m.scheduled_destruction = world.time + remaining_time
					addtimer(CALLBACK(m,PROC_REF(end_of_life)), remaining_time, TIMER_UNIQUE|TIMER_OVERRIDE)

	if(SSchat.debug_chud)
		var/turf/ownerturf = get_turf(owner)
		var/turf/targetturf = get_turf(message_loc)
		ownerturf.Beam(targetturf, icon_state = "g_beam", time = 3 SECONDS)
		ownerturf.Beam(get_turf(target), icon_state = "1-full", time = 3 SECONDS)

	// Build message image
	message = image(loc = message_loc, layer = CHAT_LAYER)
	message.plane = SSchat.chat_display_plane
	message.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	message.alpha = 0
	var/hight = (alt_display || offscreen) ? 0 : owner.bound_height
	message.pixel_y = hight * 0.95

	message.maptext_width = CHAT_MESSAGE_WIDTH
	message.maptext_height = mheight
	message.maptext_x = (CHAT_MESSAGE_WIDTH - owner.bound_width) * -0.5
	message.maptext = complete_text
	var/alphatomakeit = 255
	if(eavesdrop)
		alphatomakeit /= 3
	if(offscreen)
		alphatomakeit /= 2
		message.pixel_x = rand(-40, 40)
		message.pixel_y = rand(-40, 40)
	if((SPAN_SMALL in extra_classes) || (SPAN_SMALLER in extra_classes))
		alphatomakeit /= 2

	// View the message
	LAZYADDASSOC(owned_by.seen_messages, remembered_location, src)
	owned_by.images |= message
	animate(message, alpha = alphatomakeit, time = CHAT_MESSAGE_SPAWN_TIME)

	// Prepare for destruction
	scheduled_destruction = world.time + (lifespan - CHAT_MESSAGE_EOL_FADE)
	addtimer(CALLBACK(src,PROC_REF(end_of_life)), lifespan - CHAT_MESSAGE_EOL_FADE, TIMER_UNIQUE|TIMER_OVERRIDE)
	if(offscreen)
		new /obj/effect/buildmode_line(owner.client, get_turf(owner), message_loc, "I'm a line!", lifespan - CHAT_MESSAGE_EOL_FADE)

/**
 * Applies final animations to overlay CHAT_MESSAGE_EOL_FADE deciseconds prior to message deletion
 */
/datum/chatmessage/proc/end_of_life(fadetime = CHAT_MESSAGE_EOL_FADE)
	animate(message, alpha = 0, time = fadetime, flags = ANIMATION_PARALLEL)
	QDEL_IN(src, fadetime)

/**
 * Creates a message overlay at a defined location for a given speaker
 *
 * Arguments:
 * * speaker - The atom who is saying this message
 * * message_language - The language that the message is said in
 * * raw_message - The text content of the message
 * * spans - Additional classes to be added to the message
 */
/mob/proc/create_chat_message(atom/movable/speaker, datum/language/message_language, raw_message, list/spans, runechat_flags = NONE, list/data = list(), datum/rental_mommy/chat/mommy = null)
	// Ensure the list we are using, if present, is a copy so we don't modify the list provided to us
	spans = spans ? spans.Copy() : list()

	// Check for virtual speakers (aka hearing a message through a radio)
	var/atom/movable/originalSpeaker = speaker
	if (istype(speaker, /atom/movable/virtualspeaker))
		var/atom/movable/virtualspeaker/v = speaker
		speaker = v.source
		spans |= "virtual-speaker"

	// Ignore virtual speaker (most often radio messages) from ourself
	if (originalSpeaker != src && speaker == src)
		return

	var/datum/preferences/P = extract_prefs(speaker)
	if(P)
		var/list/m_images = P.ProfilePics.Copy()
		if(LAZYLEN(raw_message) && istext(raw_message))
			var/list/splittify = splittext(raw_message, ":")
			if(LAZYLEN(splittify) > 1)
				math:
					for(var/splut in splittify)
						var/testpart = ":[splut]:"
						for(var/list/moud in m_images)
							if(moud["Mode"] == testpart)
								raw_message = replacetext(raw_message, testpart, "") // remove the custom mode from the message
								break math // mathematical
	// Display visual above source
	if(runechat_flags & EMOTE_MESSAGE)
		new /datum/chatmessage(raw_message, speaker, src, list("emote", "italics"), null, data, mommy)
	else
		new /datum/chatmessage(lang_treat(speaker, message_language, raw_message, spans, null, TRUE), speaker, src, spans, null, data, mommy)


// Tweak these defines to change the available color ranges
#define CM_COLOR_SAT_MIN	0.6
#define CM_COLOR_SAT_MAX	0.7
#define CM_COLOR_LUM_MIN	0.65
#define CM_COLOR_LUM_MAX	0.75

/**
 * Gets a color for a name, will return the same color for a given string consistently within a round.atom
 *
 * Note that this proc aims to produce pastel-ish colors using the HSL colorspace. These seem to be favorable for displaying on the map.
 *
 * Arguments:
 * * name - The name to generate a color for
 * * sat_shift - A value between 0 and 1 that will be multiplied against the saturation
 * * lum_shift - A value between 0 and 1 that will be multiplied against the luminescence
 */
/datum/chatmessage/proc/colorize_string(name, sat_shift = 1, lum_shift = 1)
	// seed to help randomness
	var/static/rseed = rand(1,26)

	// get hsl using the selected 6 characters of the md5 hash
	var/hash = copytext(md5(name + GLOB.round_id), rseed, rseed + 6)
	var/h = hex2num(copytext(hash, 1, 3)) * (360 / 255)
	var/s = (hex2num(copytext(hash, 3, 5)) >> 2) * ((CM_COLOR_SAT_MAX - CM_COLOR_SAT_MIN) / 63) + CM_COLOR_SAT_MIN
	var/l = (hex2num(copytext(hash, 5, 7)) >> 2) * ((CM_COLOR_LUM_MAX - CM_COLOR_LUM_MIN) / 63) + CM_COLOR_LUM_MIN

	// adjust for shifts
	s *= clamp(sat_shift, 0, 1)
	l *= clamp(lum_shift, 0, 1)

	// convert to rgb
	var/h_int = round(h/60) // mapping each section of H to 60 degree sections
	var/c = (1 - abs(2 * l - 1)) * s
	var/x = c * (1 - abs((h / 60) % 2 - 1))
	var/m = l - c * 0.5
	x = (x + m) * 255
	c = (c + m) * 255
	m *= 255
	switch(h_int)
		if(0)
			return "#[num2hex(c, 2)][num2hex(x, 2)][num2hex(m, 2)]"
		if(1)
			return "#[num2hex(x, 2)][num2hex(c, 2)][num2hex(m, 2)]"
		if(2)
			return "#[num2hex(m, 2)][num2hex(c, 2)][num2hex(x, 2)]"
		if(3)
			return "#[num2hex(m, 2)][num2hex(x, 2)][num2hex(c, 2)]"
		if(4)
			return "#[num2hex(x, 2)][num2hex(m, 2)][num2hex(c, 2)]"
		if(5)
			return "#[num2hex(c, 2)][num2hex(m, 2)][num2hex(x, 2)]"

/mob/verb/mess_with_runechat()
	set name = "Configure Runechat"
	set category = "Preferences"
	set desc = "Configure your runechat preferences!"

	var/datum/preferences/P = extract_prefs(src)
	if(!P)
		to_chat("How in the world are you missing preferences?!")
		return
	var/list/choices = list("Configure Length", "Configure Width", "Configure Off-Screen Messages")
	var/my_choose = input(
		src,
		"Welcome to Runechat! Here you can modify your preferences for how Runechat looks to you!\n\
		> Configure Length: Change the maximum length of Runechat messages.\n\
		> Configure Width: Change the width of Runechat messages.\n\
		> Configure Off-Screen Messages: Change whether or not Runechat will chase you out of rooms to find you.\n\
		\n\
		What would you like to do, cutie?",
		"Runechat Configuration",
	) as null|anything in choices
	if(!my_choose)
		to_chat("Alright, have a good day!")
		return
	switch(my_choose)
		if("Configure Length")
			var/lenf = input(
				src,
				"Please enter the maximum length of Runechat messages you would like to see.\n\
				You may enter a number between 1 and [CHAT_MESSAGE_MAX_LENGTH].\n\
				\n\
				Current maximum length: [P.max_chat_length]",
				"Runechat Length Configuration",
				P.max_chat_length,
			) as null|num
			if(isnull(lenf))
				to_chat("Alright, have a good day!")
				return
			lenf = clamp(lenf, 1, CHAT_MESSAGE_MAX_LENGTH)
			P.max_chat_length = lenf
			to_chat("Runechat message length set to [lenf]!")
		if("Configure Width")
			var/lenf = input(
				src,
				"Please enter the width of Runechat messages you would like to see.\n\
				Note that all Runechat messages will be this width, regardless of content.\n\
				You may enter a number between 1 and [CHAT_MESSAGE_MAX_WIDTH].\n\
				\n\
				Current width: [P.chat_width]",
				"Runechat Girth Configuration",
				P.chat_width,
			) as null|num
			if(isnull(lenf))
				to_chat("Alright, have a good day!")
				return
			lenf = clamp(lenf, 1, CHAT_MESSAGE_MAX_WIDTH)
			P.chat_width = lenf
			to_chat("Runechat message width set to [lenf]!")
		if("Configure Off-Screen Messages")
			var/doof = alert(
				src,
				"Runechat had the ability to use advanced pathfinding algorithms to display themselves even while the speaker isn't in view, \
				granted that there is a non-opaque path from you to the speaker. This allows you to see runechat for people who are \
				around corners, in other rooms, or even on the other side of the map (if they yell loud enough).\n\
				\n\
				Do you want to enable this feature? It is currently [P.see_fancy_offscreen_runechat ? "ON" : "OFF"].",
				"Runechat Off-Screen Configuration",
				"YES",
				"NO",
			)
			if(doof == "YES")
				P.see_fancy_offscreen_runechat = TRUE
				to_chat("Runechat will now chase you out of rooms to find you!")
			else
				P.see_fancy_offscreen_runechat = FALSE
				to_chat("Runechat will no longer chase you out of rooms to find you!")
		if("Change Color")
			if(!iscarbon(src)) // eat me
				to_chat("You can't change your color, you're not a carbon!") // eat me
				return // bye!
			var/mob/living/carbon/C = src // eat me
			C.change_runechat_color() // eat me
			return // bye!
		else
			to_chat("Alright, have a good day!")
			return
	P.save_character()
	P.save_preferences()

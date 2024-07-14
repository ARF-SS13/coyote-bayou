#define CHAT_MESSAGE_SPAWN_TIME		0.5 SECONDS
#define CHAT_MESSAGE_LIFESPAN		12 SECONDS
#define CHAT_MESSAGE_EOL_FADE		5.0 SECONDS
#define CHAT_MESSAGE_EXP_DECAY		0.5 // Messages decay at pow(factor, idx in stack)
#define CHAT_MESSAGE_HEIGHT_DECAY	0.4 // Increase message decay based on the height of the message
#define CHAT_MESSAGE_APPROX_LHEIGHT	11 // Approximate height in pixels of an 'average' line, used for height decay
#define CHAT_MESSAGE_WIDTH			100 // pixels
#define CHAT_MESSAGE_MAX_LENGTH		200 // characters

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
/datum/chatmessage/New(text, atom/target, mob/owner, list/extra_classes = list(), lifespan = CHAT_MESSAGE_LIFESPAN, list/data = list())
	. = ..()
	if (!istype(target))
		CRASH("Invalid target given for chatmessage")
	if(QDELETED(owner) || !istype(owner) || !owner.client)
		stack_trace("/datum/chatmessage created with [isnull(owner) ? "null" : "invalid"] mob owner")
		qdel(src)
		return
	alt_display = data["display_turf"] || null
	if((get_dist(owner, (alt_display || target)) > 6 || data["is_far"]) && CHECK_PREFS(owner, SEE_FANCY_OFF_SCREEN_RUNECHAT)) // SD screens are 7 radius, but the UI covers a bit of that
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
	if(offscreen) // if its offscreen, put it somewhere they can see it
		var/turf/ownerturf = get_turf(owner)
		message_loc = ownerturf
		var/angle_to_source = Get_Angle(ownerturf, message_loc)
		// cus the damn angles are rotated 90 degrees clockwise, gotta change the angle 90 degrees counter
		// // get us a verbal punch laser
		// var/i = 1
		// var/datum/point/vector/punch_laser
		// while(!punch_laser)
		// 	punch_laser = GLOB.verbal_punch_lasers[i]
		// 	if(!punch_laser)
		// 		punch_laser = new /datum/point/vector()
		// 		GLOB.verbal_punch_lasers[i] = punch_laser
		// 	else if(punch_laser.inuse)
		// 		i++
		// 		punch_laser = null
		// punch_laser.initialize_location(ownerturf.x, ownerturf.y, ownerturf.z, 0, 0)
		// punch_laser.initialize_trajectory(32*6, angle_to_source) // 32 pixels per tile, 6 tiles away
		// punch_laser.increment(1)
		var/turf/displayloc = get_turf_in_angle(angle_to_source, ownerturf, 6)
		if(!displayloc)
			displayloc = ownerturf // whatevs
		message_loc = displayloc
		if(SSchat.debug_chud)
			ownerturf.Beam(displayloc, icon_state = "g_beam", time = 3 SECONDS)

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
		message.alpha /= 2
	if(offscreen)
		message.alpha /= 2
		// message.pixel_x = rand(-40, 40)
		// message.pixel_y = rand(-40, 40)

	// View the message
	LAZYADDASSOC(owned_by.seen_messages, remembered_location, src)
	owned_by.images |= message
	animate(message, alpha = alphatomakeit, time = CHAT_MESSAGE_SPAWN_TIME)

	// Prepare for destruction
	scheduled_destruction = world.time + (lifespan - CHAT_MESSAGE_EOL_FADE)
	addtimer(CALLBACK(src,PROC_REF(end_of_life)), lifespan - CHAT_MESSAGE_EOL_FADE, TIMER_UNIQUE|TIMER_OVERRIDE)

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
/mob/proc/create_chat_message(atom/movable/speaker, datum/language/message_language, raw_message, list/spans, runechat_flags = NONE, list/data = list())
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

	// Display visual above source
	if(runechat_flags & EMOTE_MESSAGE)
		new /datum/chatmessage(raw_message, speaker, src, list("emote", "italics"), null, data)
	else
		new /datum/chatmessage(lang_treat(speaker, message_language, raw_message, spans, null, TRUE), speaker, src, spans, null, data)


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

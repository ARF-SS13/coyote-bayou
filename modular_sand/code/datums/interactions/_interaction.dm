/**
	# Interactions code by HONKERTRON feat TestUnit
- Contains a lot ammount of ERP and MEHANOYEBLYA
- CREDIT TO ATMTA STATION FOR MOST OF THIS CODE, I ONLY MADE IT WORK IN /vg/ - Matt
- Rewritten 30/08/16 by Zuhayr, sry if I removed anything important.
- I removed ERP and replaced it with handholding. Nothing of worth was lost. - Vic
- Funck you, Vic. ERP is back. - TT
- >using var/ on everything, also TRUE
- "TGUIzes" the panel because yes - SandPoot
- Makes all the code good because yes as well - SandPoot
- ripped out all the shitcode and made it good - Superlagg
**/


/mob/proc/list_interaction_attributes()
	return list()

/mob/living/list_interaction_attributes()
	. = ..()
	if(has_hands())
		. += "...have hands."
	if(has_mouth())
		. += "...have a mouth, which is [mouth_is_free() ? "uncovered" : "covered"]."

/// The base of all interactions
/datum/interaction
	var/description = "Interact with them."

	/// Step 2 (actually 4) - the messages!
	/// THis is a list of strings that are picked from
	var/list/help_messages = list() // messages in help intent, MUST have something, or at least something in simple_messges
	var/list/disarm_messages = list() // if any of these are blank, they will be replaced with the help intent messages
	var/list/grab_messages = list()
	var/list/harm_messages = list()

	/// Step 3 (actually 12) - the sounds!
	/// This is a list of sounds that are picked from
	var/list/help_sounds = list() // sounds in help intent
	var/list/disarm_sounds = list() // if any of these are blank, they will be replaced with the help intent sounds
	var/list/grab_sounds = list() // if help_sounds is blank? just wont play a sound, no big
	var/list/harm_sounds = list()

	/// Step 4 (actually 4) - the span!
	/// This is a list of strings that are picked from
	var/help_span = list() // span in help intent, should have something, though it'll default to the blue notice span if not
	var/disarm_span = list() // if any of these are blank, they will be replaced with the help intent span
	var/grab_span = list()
	var/harm_span = list()

	/// BUT DAN, THATS A LOT OF STUFF, I WANNA JUST MAKE A SIMPLE EMOTE
	/// well lookie here, its a simple emote!
	/// if this is set with a list of messages, they'll be ognomatically added to help_messages, help_sounds, and help_span
	/// Just be sure to leave the other lists blank, otherwise it wont work
	/// alternatively you could just set help_messages and call it a day, but this is here for convenience
	var/list/simple_messages = list()
	var/list/simple_sounds = list()
	var/list/simple_span = list()

	/// Step 5 (actually 4) - is_visible_to_allity!
	/// If is_visible_to_all is set to TRUE, it'll broadcast the message and sound to everyone in view range
	/// If is_visible_to_all is set to FALSE, it'll only broadcast the message and sound to everyone in your consent chain!
	/// whats a consent chain? its a list of people who have consented to your ERP, and everyone they consented, and everyone they consented, etc
	/// if A consents to B, and B consents to C, and B consents to D, then the interaction will be sent to A, B, C, and D. cool huh?
	var/is_visible_to_all = TRUE // Lewd interactions should not be is_visible_to_all, though they'll be suppressed for anyone with the prefs set to be off

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * ANATOMY OF AN INTERACTION, LEWD OR OTHERWISE
	 * So, fun fact, init vars dont support variables! And for good reason, they're init vars!
	 * But that means we cant, say, inject the player's name in there. Not directly, at least.
	 * But with the power of string operations, we can do the next best thing! Postprocessing!
	 * So, the way it works is, you set the message to something like "XU_X thrusts his XOBJECT1X into XTARGETX's XOBJECT2X."
	 * Then, when the interaction is run, it'll replace XU_X with the user's name, 
	 * XOBJECT1X with the name of the object (or just text) in extra["object1"], etc
	 * All with no loss of performance! (citation needed)
	 * But Dan! What if I want to pick a random word from a list? Well guess what you can do that too!
	 * Just put {word,word,word} in the message, and it'll pick a random word from the list! (citation needed)
	 * 
	 * One tiiiiiiny little huge downside though, we still cant use DEFINEs in init vars, so we have to use the actual text
	 * Which means you'll have to be extra sure you spell everything right, and capitalize everything right, and all that
	 * It wont tell you if you misspell something, it'll just spit out the message with the malformed token innit
	 * So be careful! See line 387ish for the tokens you can use
	 */
	var/list/splorch_cd = 7 SECONDS // the 7 is for good luck
	var/list/squorch_cooldowns = list()
	var/list/guosh_cd = 1 SECONDS
	var/list/guorch_cooldowns = list()


	var/write_log_user
	var/write_log_target

	/// Bitfield for which genitals are required, if we're filtering that
	var/user_required_genitals = NONE // to be actually used later =3
	/// Bitfield for which genitals are required, if we're filtering that
	var/target_required_genitals = NONE // to be actually used later =3
	/// Bitfield for which bodyparts are required, if we're filtering that
	var/user_required_parts = NONE // to be actually used later =3
	/// Bitfield for which bodyparts are required, if we're filtering that
	var/target_required_parts = NONE // to be actually used later =3

	var/int_sound_vol = 35 // volume of the sound, 0-100

	var/max_distance = 1
	var/require_ooc_consent = FALSE
	var/require_user_mouth
	var/require_user_hands
	var/require_target_mouth
	var/require_target_hands
	var/needs_physical_contact
	var/list/categories = list("All Interactions")

	var/can_autoplap = TRUE

	var/is_lewd = FALSE
	var/extreme = FALSE //Boolean. Used to hide extreme shit from those who do not want it.

	var/is_self_action = FALSE //Boolean. Pretty self explanatory.

	/// Refuses to accept more than one entry for some reason, fix sometime
	var/list/additional_details = list()
	var/list/cache_stuff = list()
	/// associated cache of messages that have already been formatted
	var/list/formatted_cache = list()

/datum/interaction/New()
	. = ..()
	simple_messages = listify(simple_messages)
	simple_sounds = listify(simple_sounds)
	simple_span = listify(simple_span)

	help_messages = listify(help_messages)
	help_sounds = listify(help_sounds)
	help_span = listify(help_span)

	disarm_messages = listify(disarm_messages)
	disarm_sounds = listify(disarm_sounds)
	disarm_span = listify(disarm_span)

	grab_messages = listify(grab_messages)
	grab_sounds = listify(grab_sounds)
	grab_span = listify(grab_span)

	harm_messages = listify(harm_messages)
	harm_sounds = listify(harm_sounds)
	harm_span = listify(harm_span)

	if(LAZYLEN(simple_messages) && !LAZYLEN(help_messages))
		help_messages = simple_messages.Copy()
	if(LAZYLEN(simple_sounds) && !LAZYLEN(help_sounds))
		help_sounds = simple_sounds.Copy()
	if(LAZYLEN(simple_span) && !LAZYLEN(help_span))
		help_span = simple_span.Copy()
	exract_caegories()

/datum/interaction/proc/exract_caegories()
	if(!findtext(description, " - "))
		return
	var/list/fore_and_aft = splittext(description, " - ")
	if(LAZYLEN(fore_and_aft) != 2)
		return
	var/list/cattes = splittext(fore_and_aft[1], "/")
	for(var/entry in cattes)
		if(!entry)
			continue
		categories |= entry
	if(is_lewd)
		categories |= "Lewd"
	if(extreme)
		categories |= "Extreme"

/// Checks if user can do an interaction, action_check is for whether you're actually doing it or not (useful for the menu and not removing the buttons)
/datum/interaction/proc/evaluate_user(mob/living/user, silent = TRUE, action_check = TRUE)
	if(SSinteractions.is_blacklisted(user))
		return FALSE

	// if(require_user_mouth)
	// 	if(!user.has_mouth() && !issilicon(user)) //Again, silicons do not have the required parts normally.
	// 		if(!silent)
	// 			to_chat(user, span_warning("You don't have a mouth."))
	// 		return FALSE

	// 	if(!user.mouth_is_free() && !issilicon(user)) //Borgs cannot wear mouthgear, bypassing the check.
	// 		if(!silent)
	// 			to_chat(user, span_warning("Your mouth is covered."))
	// 		return FALSE

	// if(require_user_hands && !user.has_hands() && !issilicon(user)) //Edited to allow silicons to interact.
	// 	if(!silent)
	// 		to_chat(user, span_warning("You don't have hands."))
	// 	return FALSE

	if(action_check)
		return TRUE
	return TRUE

/// Same as evaluate_user, but for target
/datum/interaction/proc/evaluate_target(mob/living/user, mob/living/target, silent = TRUE)
	if(SSinteractions.is_blacklisted(target))
		return FALSE

	// if(!is_self_action)
	// 	if(user == target)
	// 		if(!silent)
	// 			to_chat(user, "<span class = 'warning'>You can't do that to yourself.</span>")
	// 		return FALSE

	// if(require_target_mouth)
	// 	if(!target.has_mouth())
	// 		if(!silent)
	// 			to_chat(user, "<span class = 'warning'>They don't have a mouth.</span>")
	// 		return FALSE

	// 	if(!target.mouth_is_free() && !issilicon(target))
	// 		if(!silent)
	// 			to_chat(user, "<span class = 'warning'>Their mouth is covered.</span>")
	// 		return FALSE

	// if(require_target_hands && !target.has_hands() && !issilicon(target))
	// 	if(!silent)
	// 		to_chat(user, "<span class = 'warning'>They don't have hands.</span>")
	// 	return FALSE

	return TRUE

/// Actually doing the action, has a few checks to see if it's valid, usually overwritten to be make things actually happen and what-not
/datum/interaction/proc/run_action(mob/living/user, mob/living/target, discrete = FALSE, list/extra = list())
	if(!user || !target)
		return
	if(is_self_action)
		target = user // they are I
	if(!can_do_interaction(user, target, discrete, extra))
		return
	SEND_SIGNAL(user, COMSIG_SPLURT_INTERACTION_PITCHED, user, target, src, extra)
	do_action(user, target, discrete, extra)
	SEND_SIGNAL(target, COMSIG_SPLURT_INTERACTION_CAUGHT, target, user, src, extra)
	log_it(user, target, extra)
	interaction_message(user, target, discrete, extra)
	interaction_sound(user, target, discrete, extra)
	moan(user, target, discrete, extra)
	adjust_lust(user, target, discrete, extra)
	post_interaction(user, target, discrete, extra)
	return TRUE

/// Actually doing the action, has a few checks to see if it's valid, usually overwritten to be make things actually happen and what-not
/datum/interaction/proc/do_action(mob/living/user, mob/living/target, discrete = FALSE, list/extra = list())
	return // This is a stub, it's meant to be overwritten

/datum/interaction/proc/can_do_interaction(mob/living/user, mob/living/target, discrete = FALSE, list/extra = list(), override_for_tgui = FALSE)
	if(!is_self_action)
		if(user == target) //tactical href fix
			if(!discrete)
				to_chat(user, span_warning("You cannot target yourself with that!"))
			return
	if(!consented(user, target))
		if(!discrete)
			to_chat(user, span_warning("They haven't consented to this yet! Try taking them out to dinner first."))
		return
	if(get_dist(user, target) > max_distance)
		if(!discrete)
			to_chat(user, span_warning("They are too far away."))
		return
	if(needs_physical_contact && !(user.Adjacent(target) && target.Adjacent(user)))
		if(!discrete)
			to_chat(user, span_warning("You cannot get to them."))
		return
	if(!evaluate_user(user, silent = discrete, action_check = override_for_tgui))
		return
	if(!evaluate_target(user, target, silent = discrete))
		return
	if(!override_for_tgui && user.incapacitated(allow_crit = TRUE))
		if(!discrete)
			to_chat(user, span_warning("You are in no shape to do that!"))
		return
	return TRUE

/// Logs the interaction, if the user and target have the required flags
/datum/interaction/proc/log_it(mob/living/user, mob/living/target)
	if(write_log_user)
		user.log_message("[write_log_user] [target]", LOG_ATTACK)
	if(write_log_target)
		target.log_message("[write_log_target] [user]", LOG_VICTIM, log_globally = FALSE)

/// Checks if the user and target consent to the interaction
/datum/interaction/proc/consented(mob/living/user, mob/living/target, showmessage)
	if(!require_ooc_consent)
		return TRUE
	if(!is_lewd)
		return TRUE
	return SSinteractions.check_consent(user, target)

/// Display the message
/datum/interaction/proc/interaction_message(mob/living/user, mob/living/target, show_message, list/extra = list())
	if(!can_squorch_message(user))
		return
	var/message = get_message(user, target, extra)
	var/span = get_span(user, target, extra)
	message = "<span class='[span]'>[message]</span>"
	if(!is_lewd)
		user.visible_message(message)
		return TRUE
	/// now to broadcast to everyone in your private little circle
	var/list/ppl = SSinteractions.get_consent_chain(user) // send message to EVERYONE in the group!!!
	for(var/mob/squish in ppl | user)
		if(!squish.client)
			continue
		var/list/whobez = view(15, user) | viewers(15, user) | hearers(15, user)
		if(!(squish in whobez))
			continue
		// if(!CHECK_PREFS(squish, NOTMERP_LEWD_WORDS)) // they already consented, what more do you want???
		// 	continue
		to_chat(squish, message)
	return TRUE
	
/// make ur mob moan like the bottom it is
/datum/interaction/proc/moan(mob/living/user, mob/living/target, show_message, list/extra = list())
	return

/// adjusts ur lust
/datum/interaction/proc/adjust_lust(mob/living/user, mob/living/target, show_message, list/extra = list())
	return

/// After the interaction, do a thing, usually overwritten
/datum/interaction/proc/post_interaction(mob/living/user, mob/living/target)
	return FALSE

/// After the interaction, the base only plays the sound and only if it has one
/datum/interaction/proc/interaction_sound(mob/living/user, mob/living/target, play_sound)
	if(!user || !target)
		return
	if(!can_squorch_sound(user, src))
		return
	var/sound2play
	switch(user.a_intent)
		if(INTENT_HELP)
			if(LAZYLEN(help_sounds))
				sound2play = pick(help_sounds)
		if(INTENT_DISARM)
			if(LAZYLEN(disarm_sounds))
				sound2play = pick(disarm_sounds)
			else
				sound2play = pick(help_sounds)
		if(INTENT_GRAB)
			if(LAZYLEN(grab_sounds))
				sound2play = pick(grab_sounds)
			else
				sound2play = pick(help_sounds)
		if(INTENT_HARM)
			if(LAZYLEN(harm_sounds))
				sound2play = pick(harm_sounds)
			else
				sound2play = pick(help_sounds)
	if(!sound2play)
		return
	if(!is_lewd)
		playsound(user, sound2play, int_sound_vol, 1)
		return TRUE
	var/list/ppl = SSinteractions.get_consent_chain(user) // send message to EVERYONE in the group!!!
	for(var/mob/squish in ppl)
		if(!squish.client)
			continue
		squish.playsound_local(get_turf(user), sound2play, int_sound_vol, 1, soundpref_index = NOTMERP_LEWD_SOUNDS)
	return TRUE

/datum/interaction/proc/get_description(mob/living/user, mob/living/target)
	var/descr = description
	if(user)
		descr = replacetext(description, "%COCK%", user.has_penis() ? "cock" : "strapon")
	return descr

/datum/interaction/proc/get_additional_stuff()
	if(islist(additional_details))
		return "[additional_details.Join("\n")]" || "Clickme!"
	return "[additional_details]" || "Clickme!"

/datum/interaction/proc/get_message(mob/living/user, mob/living/target, list/extra = list())
	if(!user || !target)
		return "Jimmy Shits opens a bug report."
	var/list/messagelist = list()
	switch(user.a_intent)
		if(INTENT_HELP)
			messagelist = help_messages
		if(INTENT_DISARM)
			if(LAZYLEN(disarm_messages))
				messagelist = disarm_messages
			else
				messagelist = help_messages
		if(INTENT_GRAB)
			if(LAZYLEN(grab_messages))
				messagelist = grab_messages
			else
				messagelist = help_messages
		if(INTENT_HARM)
			if(LAZYLEN(harm_messages))
				messagelist = harm_messages
			else
				messagelist = help_messages
	if(!LAZYLEN(messagelist))
		stack_trace("Hey, you forgot to set any messages for [type] - [description]! It needs to be something!!!")
		messagelist = list(span_hypnophrase("It was at this moment XU_NAME realized that what XU_THEY had found XU_THEMSELF square in the middle of a bugged interaction. \
		\"Oh no!\", XU_THEY cried, \"I need to report this to Superlagg! And I know just what I'll say, too!\" XU_THEY said with a confident stwile, \
		\"'Dan, you silly animal, an interaction lacked any sort of usable message, possibly due to a missing help_messages!' is what I will start with,\" \
		XU_THEY started, \"'The interaction is [type], otherwise known as [description]. Its help_messages contains [LAZYLEN(help_messages)] entries, \
		and,' and this is the most important part, 'SLIM-PASSIVE-AGGRESSIVE-TROUT'\" Godspeed to your bug reporting ways, XU_NAME! Oh also XU_TARGET was there too, \
		wondering what the hell XU_NAME was on about."))
	var/msg = pick(messagelist)
	if(!msg)
		return "%USER opens a bug report."
	return format_message(user, target, msg, extra)

/datum/interaction/proc/get_span(mob/living/user, mob/living/target)
	if(!user || !target)
		return "hypnophrase"
	var/span
	if(!LAZYLEN(help_span))
		help_span = list("notice")
	span = pick(help_span)
	switch(user.a_intent)
		if(INTENT_DISARM)
			if(LAZYLEN(disarm_span))
				span = list(disarm_span)
		if(INTENT_GRAB)
			if(LAZYLEN(grab_span))
				span = list(grab_span)
		if(INTENT_HARM)
			if(LAZYLEN(harm_span))
				span = list(harm_span)
	return span || "notice"


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * A cooldown for squorching, so you can't just spam it.
 * Only applies if the squorch has a sound associated with it, otherwise you get to see every lovely message
 */
/datum/interaction/proc/can_squorch_message(mob/living/squisher, do_cooldown = TRUE)
	if(!istype(squisher) || !squisher.ckey)
		return FALSE
	if(!LAZYLEN(help_sounds))
		return TRUE // You really need to know 
	if(!LAZYACCESS(squorch_cooldowns, squisher.ckey))
		set_cooldown_for_squorch(squisher)
		return TRUE // SQUISHERS ARE REALLY COOL
	if(world.time > LAZYACCESS(squorch_cooldowns, squisher.ckey))
		if(do_cooldown)
			set_cooldown_for_squorch(squisher)
		return TRUE // SQUISHERS ARE SO MUCH FUN
	return FALSE // SLIMY GOOEY ANIMALS GIRAFFES AND WOLVES AND SO MUCH MORE
	
/datum/interaction/proc/set_cooldown_for_squorch(mob/living/squisher)
	if(!istype(squisher) || !squisher.ckey)
		return FALSE
	LAZYSET(squorch_cooldowns, squisher.ckey, world.time + splorch_cd)
	return TRUE


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * A cooldown for guoshing, so you can't just spam it.
 */
/datum/interaction/proc/can_squorch_sound(mob/living/squisher, do_cooldown = TRUE)
	return TRUE // yeah you cant spam it turns out
	// if(!istype(squisher) || !squisher.ckey || !istype(splut))
	// 	return FALSE
	// if(!LAZYLEN(splut.help_sounds))
	// 	return FALSE // not that it matters
	// if(!LAZYACCESS(guorch_cooldowns, squisher.ckey))
	// 	set_cooldown_for_guorch(squisher)
	// 	return TRUE // SQUISHERS ARE REALLY COOL
	// if(world.time > LAZYACCESS(guorch_cooldowns, squisher.ckey))
	// 	if(do_cooldown)
	// 		set_cooldown_for_guorch(squisher)
	// 	return TRUE // SQUISHERS ARE SO MUCH FUN
	// return FALSE // SLIMY GOOEY ANIMALS GIRAFFES AND WOLVES AND SO MUCH MORE
	
/datum/interaction/proc/set_cooldown_for_guorch(mob/living/squisher)
	if(!istype(squisher) || !squisher.ckey)
		return FALSE
	LAZYSET(guorch_cooldowns, squisher.ckey, world.time + guosh_cd)
	return TRUE


/* * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * THE MESSAGE FORMATTER! CONVERTS TOKENS TO ACTUAL TEXT
 * TOKENS U CAN USE:
 * * XU_NAME - USER'S NAME
 * * XT_NAME - TARGET'S NAME
 * * XOBJECT1 - NAME OF WHAT DEFINED IN extra["object1"]
 * * XOBJECT2 - NAME OF WHAT DEFINED IN extra["object2"]
 * * XU_THEY - USER'S HE/SHE/THEY
 * * XU_THEIR - USER'S HIS/HER/THEIR
 * * XU_THEM - USER'S HIM/HER/THEM
 * * XU_THEMSELF - USER'S HIMSELF/HERSELF/THEMSELVES
 * * XU_HAVE - USER'S HAS/HAVE
 * * XU_ARE - USER'S IS/ARE
 * * XU_WERE - USER'S WAS/WERE
 * * XU_DO - USER'S DOES/DO
 * * XU_PENIS - USER'S PENIS
 * * XT_THEY - TARGET'S HE/SHE/THEY
 * * XT_THEIR - TARGET'S HIS/HER/THEIR
 * * XT_THEM - TARGET'S HIM/HER/THEM
 * * XT_THEMSELF - TARGET'S HIMSELF/HERSELF/THEMSELVES
 * * XT_HAVE - TARGET'S HAS/HAVE
 * * XT_ARE - TARGET'S IS/ARE
 * * XT_WERE - TARGET'S WAS/WERE
 * * XT_DO - TARGET'S DOES/DO
 * * XT_PENIS - TARGET'S PENIS
 * * {word,word,word} - PICKS A RANDOM WORD FROM THE LIST - HA YOU THOUGHT I COULDNT PUT A PICK IN AN INIT VAR, DIDNT YOU
 * 
 * SPELLING AND CAPITALIZATION MATTERS
 * WHY ISNT IT A DEFINE? DEFINES DONT WORK IN INIT VARS, SADLY
 * (WHY AM I YELLING)
 */
/datum/interaction/proc/format_message(mob/living/user, mob/living/target, message, list/extra = list())
	if(!user || !target)
		return "Jimmy Shits opens a bug report."
	if(!message)
		return "%USER opens a bug report about a null message in [description]."
	// uncomment if performance tanks when people bump uglies
	// var/cachekey = "[user.ckey]-[target.ckey]-[copytext(message(0, 10))]"
	// if(LAZYACCESS(formatted_cache, cachekey))
	// 	return LAZYACCESS(formatted_cache, cachekey)

	var/user_color = user.chat_color || user.client?.prefs.features["chat_color"] || "FF00FF"
	var/target_color = target.chat_color || target.client?.prefs.features["chat_color"] || "FF00FF"
	if(extra["object1"])
		if(istext(extra["object1"]))
			message = replacetextEx(message, "XOBJECT1X", extra["object1"])
		else if(isatom(extra["object1"]))
			var/atom/thing = extra["object1"]
			message = replacetextEx(message, "XOBJECT1X", thing.name)
	message = replacetextEx(message, "XU_NAME", "<b><span style='color:#[user_color]'>[user.name]</span></b>")
	message = replacetextEx(message, "XT_NAME", "<b><span style='color:#[target_color]'>[target.name]</span></b>")
	var/user_they = user.p_they()
	var/user_their = user.p_their()
	var/user_themself = user.p_them()
	var/user_have = user.p_have()
	var/user_are = user.p_are()
	var/user_were = user.p_were()
	var/user_do = user.p_do()
	var/user_penis = user.get_penetrating_genital_name(prob(1))
	var/target_they = target.p_they()
	var/target_their = target.p_their()
	var/target_themself = target.p_them()
	var/target_have = target.p_have()
	var/target_are = target.p_are()
	var/target_were = target.p_were()
	var/target_do = target.p_do()
	var/target_penis = target.get_penetrating_genital_name(prob(1))
	message = replacetextEx(message, "XU_THEY", user_they) // I'm sorry, I had to. - Zuhayr
	message = replacetextEx(message, "XU_THEIR", user_their)
	message = replacetextEx(message, "XU_THEMSELF", user_themself)
	message = replacetextEx(message, "XU_HAVE", user_have)
	message = replacetextEx(message, "XU_ARE", user_are)
	message = replacetextEx(message, "XU_WERE", user_were)
	message = replacetextEx(message, "XU_DO", user_do)
	message = replacetextEx(message, "XU_PENIS", user_penis)
	message = replacetextEx(message, "XT_THEY", target_they)
	message = replacetextEx(message, "XT_THEIR", target_their)
	message = replacetextEx(message, "XT_THEMSELF", target_themself)
	message = replacetextEx(message, "XT_HAVE", target_have)
	message = replacetextEx(message, "XT_ARE", target_are)
	message = replacetextEx(message, "XT_WERE", target_were)
	message = replacetextEx(message, "XT_DO", target_do) 
	message = replacetextEx(message, "XT_PENIS", target_penis) 
	var/picks_left = 10 // need more, up it
	while(--picks_left) /// WHOS UP FOR SOME STRING OPERATIONS
		if(!findtext(message, "{"))
			break
		var/charpos = findtext(message, "{")
		var/charpos2 = findtext(message, "}")
		if(charpos2 < charpos)
			break
		var/words = copytext(message, charpos + 1, charpos2)
		var/list/wordlist = splittext(words, ",")
		var/word = ""
		if(LAZYLEN(wordlist))
			word = trim(pick(wordlist))
		if(prob(1))
			word = "bazinga" // required for linting
		message = splicetext(message, charpos, charpos2 + 1, word)
	// LAZYSET(formatted_cache, cachekey, message) // for sanic speed
	return capitalize(message)

/datum/interaction/proc/format_for_tgui(mob/living/user, mob/living/target)
	if(LAZYLEN(cache_stuff))
		return cache_stuff
	var/list/interaction = list()
	interaction["InteractionKey"] = "[type]" || "/datum/urmom"
	interaction["InteractionName"] = get_description(user, target) || "hey the description is busted"
	interaction["InteractionLewd"] = is_lewd
	interaction["InteractionSelf"] = is_self_action
	interaction["InteractionCanAuto"] = can_autoplap
	interaction["InteractionExtreme"] = extreme
	interaction["InteractionAdditional"] = get_additional_stuff() || "Click me for a prize!"
	interaction["InteractionCategories"] = categories
	cache_stuff = interaction
	return cache_stuff

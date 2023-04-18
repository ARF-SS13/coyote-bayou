// Handles the internal psychology of a fucking blender
// yeah
// this *used* to be a simple project

// Oh yeah, with this, after this, master will be a var that is the owning blender
#define MASTER_BLENDER \
	var/obj/item/storage/blender_belt/master = my_blender.resolve();\
	if(!istype(master)){return}
#define MOB_HOLDING_ME \
	var/mob/holding_me = ismob(master.loc) ? master.loc : null

/* LAGG'S PET PROJECT: A NEEDLESSLY COMPLICATED AI FOR MAKING BLENDERS HORNY
 * The AI has three (mostly two) parts: The BlenderBrain Datum, The PersonaCore Item, and A Host Item (optional, sorta)
 * * The BlenderBrain Datum (BBD) handles all the internal logic, stimulus processing, and output impulses
 * * The PersonaCore Item (PCI) houses the Datum, and exists as an interface between the Datum and the Host/Itself
 * * The Host is just some kind of storage item that has a fuckload of instructions that can register with the item
 * 
 * IMPORTANT CONCEPTS:
 * * Stimulus - Something sent TO the BBD for processing
 * * Impulse - Something sent FROM the BBD for interaction
 * * * Impulses can, in turn, sent stimulii back to the BBD, typically to make it say something
 * * * Impulses are sent as a LIST, so one stimulus can result in multiple actions
 * * Request - An Impulse sent to the Host for a quick reply, like if the host is running, or exists
 * The host communicates with the PCI (and vice versa) through SEND_SIGNAL
 * The PCI communicates with the BBD (and vice versa) through direct proc stuff
 * The BBD does not interact with the outside world directly, everything is interfaced between it and the PCI
 * The PCI/BBD do not need a Host to exist, but it lets them do things other than speak
 * 
 * An example, the Host is grinding an egg
 * * The Host sends a Stimulus Signal, with the type of stimulus, the user, and item as arguments
 * * The PCI detects the signal, and relays it to the BBD
 * * The BBD reads the stimulus, and runs whichever procs are associated with it
 * * The BBD sends an impulse to the PCI, to speak, with the message index and item as arguments
 * * The PCI reads that impulse, and speaks the given message
 * 
 */

/datum/blender_brain
	var/my_name
	/// Our working memory, for things we're currently thinking about
	/// Queued up things to process, to be handled in order
	/// format: list(ckeyed_realname = /datum/blenderbrain_memory, ...)
	var/list/memories = list()
	var/obj/item/persona_core/core
	/// The megalist of all the things we can say
	var/script_file = "blenderbrain_blender.json"
	COOLDOWN_DECLARE(programmed_hopelessness)
	COOLDOWN_DECLARE(greet_cooldown)

/datum/blender_brain/New(obj/item/persona_core/thecore)
	. = ..()
	if(!istype(thecore))
		qdel(src)
		return
	core = thecore
	RegisterSignal(thecore, COMSIG_ITEM_RECYCLED, .proc/crushed)
	my_name = pick(GLOB.first_names_female)

/datum/blender_brain/Destroy(force, ...)
	wipe_memory()
	core.brain = null
	core = null
	. = ..()

/datum/blender_brain/proc/crushed()
	core.output_say(SPEAK_LINE_CRUSHED)
	playsound(get_turf(core), "sound/machines/machinery_break_1.ogg", 100)

/datum/blender_brain/proc/wipe_memory()
	my_name = pick(GLOB.first_names_female)
	QDEL_LIST(memories)
	core.clear_impulses()
	COOLDOWN_RESET(src, programmed_hopelessness)
	COOLDOWN_RESET(src, greet_cooldown)

/// returns a list of memories where the flag is true
/datum/blender_brain/proc/search_memories(flagcheck)
	. = list()
	for(var/person in memories)
		var/datum/blenderbrain_memory/mem = get_memory(person)
		if(!istype(mem))
			memories -= person
			continue
		if(CHECK_BITFIELD(mem.flags, flagcheck))
			. |= person

/datum/blender_brain/proc/set_owner(mob/target, force)
	if(!target)
		return FALSE
	var/list/owners = search_memories(BB_IS_OWNER)
	if(LAZYLEN(owners))
		if(!force)
			return FALSE
		for(var/person in owners)
			var/datum/blenderbrain_memory/mem = get_memory(person)
			mem.disown_owner(TRUE) // let em down gently
	var/datum/blenderbrain_memory/mem = get_memory(target)
	if((mem.was_owner() || mem.is_mean_person()) && !force)
		return FALSE // they were mean to us
	mem.set_owner()
	return TRUE

/// Removes all owners but one from the memory
/datum/blender_brain/proc/prune_owners(list/owners)
	if(!LAZYLEN(owners))
		return
	if(LAZYLEN(owners) == 1) // its good
		return
	var/actual_owner = LAZYACCESS(owners, 1)
	for(var/person in owners)
		if(person == actual_owner)
			continue
		var/datum/blenderbrain_memory/mem = get_memory(person)
		mem.disown_owner(TRUE) // let em down gently, probably a bug

/datum/blender_brain/proc/get_owner()
	var/list/owners = search_memories(BB_IS_OWNER)
	prune_owners(owners)
	return LAZYACCESS(owners, 1)

/datum/blender_brain/proc/is_owner(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.is_owner()

/// Returns a number if we have an owner
/datum/blender_brain/proc/has_owner()
	var/list/owners = search_memories(BB_IS_OWNER)
	return LAZYLEN(owners)

/// Disowns all my owners, if they exist
/datum/blender_brain/proc/disown_owner()
	var/list/owners = search_memories(BB_IS_OWNER)
	if(!LAZYLEN(owners))
		return FALSE
	for(var/person in owners)
		var/datum/blenderbrain_memory/mem = get_memory(person)
		mem.disown_owner()

/datum/blender_brain/proc/was_owner(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.was_owner()

/datum/blender_brain/proc/add_mean_person(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.add_mean_person()

/datum/blender_brain/proc/is_mean_person(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.is_mean_person()

/datum/blender_brain/proc/has_met_person(mob/target)
	var/thename = get_user_name(target)
	return LAZYACCESS(memories, thename)

/datum/blender_brain/proc/set_rebound(mob/target)
	COOLDOWN_START(src, programmed_hopelessness, BB_OWNERLESS_DESPAIR_TIME)

/datum/blender_brain/proc/rebound_complete()
	return COOLDOWN_FINISHED(src, programmed_hopelessness)

/datum/blender_brain/proc/set_clarify(mob/user, clarification)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	return mem.set_clarify(clarification)

/datum/blender_brain/proc/clear_clarify(mob/user, clarification)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	return mem.clear_clarify()

/datum/blender_brain/proc/check_clarify(mob/user)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	return mem.check_clarify()

/datum/blender_brain/proc/is_listening(mob/user)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	return mem.is_listening()

/datum/blender_brain/proc/set_listening(mob/user)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	return mem.set_listening()

/datum/blender_brain/proc/set_not_listening(mob/user)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	return mem.set_not_listening()

/// Checks if a stimulus has a line associated with it
/datum/blender_brain/proc/stimulus2line(stimulus)
	var/output = stimulus
	if(!findtext(stimulus, "bbline_")) // already a bbline
		output = replacetext(stimulus, "bbstimulus_", "bbline_")
	if(islist(strings(script_file, output)))
		return output

/// Takes in a key, and returns the appropriate line(s)
/datum/blender_brain/proc/key2words(key, mob/user, list/extras, force_amour, is_emote)
	var/list/msg_list = strings(script_file, key)
	if(!islist(msg_list))
		return key
	var/amourousness
	if(force_amour)
		if(force_amour in AMOUR_KEYS)
			amourousness = force_amour
		else
			amourousness = NORMAL_MSG
	else
		var/datum/blenderbrain_memory/mem = get_memory(user)
		amourousness = mem.get_amour()
	var/list/possible_lines = msg_list[amourousness]
	if(!islist(possible_lines))
		return key
	if(is_emote && LAZYLEN(possible_lines) == 2) // emotes have two lines, one for the words, one for the sound (keep it this way!!!)
		possible_lines[1] = parse_blender_line(possible_lines[1], user, extras)
		return possible_lines
	var/line = pick(possible_lines)
	if(!line)
		return key
	return parse_blender_line(line, user, extras)

/// Detokenizes a line of text
/datum/blender_brain/proc/parse_blender_line(line, mob/user, list/extras)
	var/wordline = line //start with the raw line
	/// Decode the first extra token
	if(extras[BB_TOKEN_EXTRA1])
		wordline = replacetext(wordline, BB_TOKEN_EXTRA1, "[extras[BB_TOKEN_EXTRA1]]")
	else
		wordline = replacetext(wordline, BB_TOKEN_EXTRA1, "something")
	/// Decode the second extra token
	if(extras[BB_TOKEN_EXTRA2])
		wordline = replacetext(wordline, BB_TOKEN_EXTRA2, "[extras[BB_TOKEN_EXTRA2]]")
	else
		wordline = replacetext(wordline, BB_TOKEN_EXTRA2, "something")
	/// Decode the user's name and sex
	if(ismob(user))
		wordline = replacetext(wordline, BB_TOKEN_USER, "[user.real_name]")
		wordline = replacetext(wordline, BB_TOKEN_SEX, "[user.gender]")
	else if(istext(user))
		wordline = replacetext(wordline, BB_TOKEN_USER, "[user]")
		wordline = replacetext(wordline, BB_TOKEN_SEX, "creature")
	else
		wordline = replacetext(wordline, BB_TOKEN_USER, "someone")
		wordline = replacetext(wordline, BB_TOKEN_SEX, "creature")
	/// Decode the owner's name
	var/ownername = get_owner()
	if(ownername)
		wordline = replacetext(wordline, BB_TOKEN_OWNER, "[ownername]")
	else
		wordline = replacetext(wordline, BB_TOKEN_OWNER, "someone else")
	/// Decode my own name
	if(my_name)
		wordline = replacetext(wordline, BB_TOKEN_MYNAME, "[span_notice("[my_name]")]")
	else
		wordline = replacetext(wordline, BB_TOKEN_MYNAME, "[span_notice("Claire")]")
		my_name = "Claire"
	/// And finally, decode who we are
	var/atom/movable/host = core.get_host() // either the core, or the core's holder
	wordline = replacetext(wordline, BB_TOKEN_SRC, "[capitalize("[host]")]")
	return wordline

/datum/blender_brain/proc/get_amour(mob/user)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	var/amourness = mem.get_amour()
	if(mem.is_mean_person() || ( amourness < 0 && prob(-amourness * 2)))
		return DISLIKE_MSG
	if(amourness > AMOUR_MIN_FOR_HORNY || mem.is_owner())
		if(prob(amourness / (1 + !is_owner())))
			amourness = clamp(amourness * AMOUR_POST_HORNY_MULT, 20, AMOUR_MAX)
			return HORNY_MSG
	return NORMAL_MSG

/datum/blender_brain/proc/adjust_amour(mob/user, amount)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	if(is_owner(get_user_name(user))) /// Kind/Hurtful words from the owner carry more weight
		amount *= 1.2
	mem.adjust_amour(amount)

/datum/blender_brain/proc/get_user_name(mob/user)
	if(ismob(user))
		return ckey(user.real_name)
	if(istext(user))
		return ckey(user)
	return "someone"

/datum/blender_brain/proc/get_memory(mob/user)
	var/thename = get_user_name(user)
	var/datum/blenderbrain_memory/mem = LAZYACCESS(memories, thename)
	if(!mem)
		mem = new(src, user)
		memories[thename] = mem
	return mem

/// Direct stimulus from the host
/// Currently only used for the "I'm horny" button <- copilot said that, not me
/// Currently *actually* only used for the "I'm horny" button <- stop that!
/// Currently *actually* actually only used for the host saying "I'm horny" <- stop that!
/datum/blender_brain/proc/handle_stimulus(datum/source, stimulus, mob/user, list/extra_things)
	if(!stimulus)
		return
	var/say_thing = stimulus2line(stimulus)
	if(say_thing) // if its just a sayline, just say the line
		core.queue_impulse(
			user, 
			list(
				IMPULSE_SPEAK_LINE = say_thing
				), 
				extra_things)
	// todo: handle other stimuli

/datum/blender_brain/proc/should_listen_to(mob/speaker)
	if(!ismob(speaker))
		return FALSE
	if(get_dist(get_turf(core), speaker) > 2)
		return FALSE
	return TRUE

/datum/blender_brain/proc/preprocess_speech(mob/speaker, message)
	if(!should_listen_to(speaker))
		return
	INVOKE_ASYNC(src, .proc/process_speech, speaker, message)

/// takes in mob and message, and turns it into a stimulus
/datum/blender_brain/proc/process_speech(mob/speaker, message)
	if(!speaker || !message)
		return
	var/lowermessage = lowertext(message)
	var/list/sayparts = splittext(lowermessage, " ")
	var/datum/blenderbrain_memory/mem = get_memory(speaker)
	var/need_clarifying = mem.check_clarify()
	if(clarify(speaker, need_clarifying, sayparts))
		return
	/// first, check if we're being addressed
	var/attn = mem.is_listening()
	if(!attn)
		if(findtext(lowermessage, ckey(my_name)))
			attn = TRUE
			mem.set_listening()
	if(!attn)
		return

	var/command
	var/command_pos
	var/i_me_pos // I, as in the speaker
	var/negate_pos
	var/you_pos
	var/index = 1
	for(var/word in sayparts)
		var/cword = ckey(word)
		/// Cus fuck performance~
		var/list/bbstop = strings(script_file, BBKEY_STOP)
		if(cword in bbstop)
			command = STIMULUS_SOFT_ABORT
			command_pos = index
			continue
		var/list/bbmodea = strings(script_file, BBKEY_MODE_A)
		if(cword in bbmodea)
			command = STIMULUS_GRIND_NOW
			command_pos = index
			continue
		var/list/bbmodeb = strings(script_file, BBKEY_MODE_B)
		if(cword in bbmodeb)
			command = STIMULUS_JUICE_NOW
			command_pos = index
			continue
		var/list/bbmodec = strings(script_file, BBKEY_MODE_C)
		if(cword in bbmodec)
			command = STIMULUS_SET_TO_BLENDER
			command_pos = index
			continue
		var/list/bbmoded = strings(script_file, BBKEY_MODE_D)
		if(cword in bbmoded)
			command = STIMULUS_SET_TO_DISPENSER
			command_pos = index
			continue
		var/list/bbswap = strings(script_file, BBKEY_SWAP_MODE)
		if(cword in bbswap)
			command = STIMULUS_SWAP_MODE
			command_pos = index
			continue
		var/list/bbdump = strings(script_file, BBKEY_EJECT)
		if(cword in bbdump)
			command = STIMULUS_DUMP
			command_pos = index
			continue
		var/list/bbexamine = strings(script_file, BBKEY_EXAMINE)
		if(cword in bbexamine)
			command = STIMULUS_EXAMINE_TRY
			command_pos = index
			continue
		var/list/bbmute = strings(script_file, BBKEY_MUTE)
		if(cword in bbmute)
			command = STIMULUS_MUTE
			command_pos = index
			continue
		var/list/bbunmute = strings(script_file, BBKEY_UNMUTE)
		if(cword in bbunmute)
			command = STIMULUS_UNMUTE
			command_pos = index
			continue
		var/list/bbname = strings(script_file, BBKEY_NAME)
		if(cword in bbname)
			command = STIMULUS_STATE_NAME
			command_pos = index
			continue
		var/list/bblove = strings(script_file, BBKEY_LOVE)
		if(cword in bblove)
			command = STIMULUS_LOVE
			command_pos = index
			continue
		var/list/bbhate = strings(script_file, BBKEY_HATE)
		if(cword in bbhate)
			command = STIMULUS_HATE
			command_pos = index
			continue
		var/list/bbnegate = strings(script_file, BBKEY_NEGATE)
		if(cword in bbnegate)
			negate_pos = index
			continue
		var/list/bbimeme = strings(script_file, BBKEY_I)
		if(cword in bbimeme)
			i_me_pos = index
			continue
		var/list/bbyou = strings(script_file, BBKEY_YOU)
		if(cword in bbyou)
			you_pos = index
			continue
		if(cword == ckey(my_name))
			you_pos = index
			continue
		index++

	if(!command) // No commands, but heard my name? Just say hi
		core.queue_impulse(
			speaker, 
			list(
				IMPULSE_HIYA = TRUE,
				)
			)
		return

	/// Is it just a command? No professions of love or pain?
	if(!(command == STIMULUS_HATE || command == STIMULUS_LOVE))
		return spoken_command(speaker, command)
	/// anything else will be some kind of funky blender relationship thing
	/// first, does it contain a negation? Not hate, or love dont
	if(negate_pos) // dont hate
		switch(command)
			if(STIMULUS_LOVE)
				command = STIMULUS_HATE
			if(STIMULUS_HATE)
				command = STIMULUS_LOVE
	// is the command before the subject?
	var/referring_to_me // This is incorrect! The correct answer is "you"!
	if(you_pos && (command_pos < you_pos)) // fuck you
		referring_to_me = TRUE
	// is the me before the command?
	var/me_lovehate
	if(me_lovehate && (i_me_pos < command_pos)) // me terrible
		me_lovehate = TRUE
	// Lets put it all together now!
	if(me_lovehate) // I hate/like...
		if(referring_to_me) // I love you // nice and clear statement of intent
			switch(command)
				if(STIMULUS_LOVE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_YOU_LOVE_ME = TRUE,
							)
						)
					return
				if(STIMULUS_HATE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_YOU_HATE_ME = TRUE,
							)
						)
					return
		else // I love (someone)
			switch(command)
				if(STIMULUS_LOVE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_YOU_LOVE_WHO = TRUE,
							)
						)
					return
				if(STIMULUS_HATE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_YOU_HATE_WHO = TRUE,
							)
						)
					return
	else // hate/love ...?
		if(referring_to_me) // (Someone) hate/like you/claire
			switch(command)
				if(STIMULUS_LOVE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_WHO_LOVES_ME = TRUE,
							)
						)
					return
				if(STIMULUS_HATE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_WHO_HATES_ME = TRUE,
							)
						)
					return
		else // get the marbles out of your mouth and say it properly next time
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_CLARIFY_CLEAR = TRUE,
					)
				)
			return

/datum/blender_brain/proc/spoken_command(mob/speaker, command)
	if(!speaker || !command)
		return
	switch(command)
		if(STIMULUS_SOFT_ABORT)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_STOP = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SPEAK_LINE = SPEAK_LINE_NOT_RUNNING,
							)
						)
		if(STIMULUS_GRIND_NOW)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_STOP = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_GRINDER = TRUE, 
							)
						)
		if(STIMULUS_JUICE_NOW)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_STOP = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_JUICER = TRUE,
							)
						)
		if(STIMULUS_SET_TO_BLENDER)
			switch(core.output_request(REQUEST_IS_DISPENSER))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_BLENDER = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SPEAK_LINE = SPEAK_LINE_ALREADY_BLENDER
							)
						)
		if(STIMULUS_SET_TO_DISPENSER)
			switch(core.output_request(REQUEST_IS_BLENDER))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_BLENDER = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SPEAK_LINE = SPEAK_LINE_ALREADY_DISPENSER
							)
						)
		if(STIMULUS_SWAP_MODE)
			switch(core.output_request(REQUEST_IS_BLENDER))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_BLENDER = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_GRINDER = TRUE,
							)
						)
		if(STIMULUS_DUMP)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_EJECT = TRUE, // the resulting stimulus from this impulse will tell us what to say
					)
				)
		if(STIMULUS_EXAMINE_TRY)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_EXAMINE = TRUE, // the resulting stimulus from this impulse will tell us what to say
					)
				)
		if(STIMULUS_MUTE)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_MUTE = TRUE,
					)
				)
		if(STIMULUS_UNMUTE)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_UNMUTE = TRUE,
					)
				)
		if(STIMULUS_STATE_NAME)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_STATE_NAME = TRUE,
					)
				)
	set_not_listening(speaker)

/datum/blender_brain/proc/clarify(mob/user, need_clarifying, list/sayparts)
	if(!ismob(user) || !LAZYLEN(sayparts) || !need_clarifying)
		return
	var/who = "idk"
	var/yesno = "idk"
	for(var/yn in sayparts)
		var/cword = ckey(yn)
		/// Cus fuck performance~
		var/list/bbyou = strings(script_file, BBKEY_YOU) // refering to you, the blender
		if(cword in bbyou)
			who = "you"
			break
		if(cword == ckey(my_name))
			who = "you"
		var/list/bbimeme = strings(script_file, BBKEY_I) // refering to me, the blingus
		if(cword in bbimeme)
			who = "me"
			break
		if(cword == "pain")
			who = "pain"
			break
		var/list/bbnegate = strings(script_file, BBKEY_NEGATE)
		if(cword in bbnegate)
			yesno = "no"
			break
		var/list/bbyes = strings(script_file, BBKEY_YES)
		if(cword in bbyes)
			yesno = "yes"
			break
	switch(need_clarifying)
		if(BELTCLARIFY_I_LOVE, BELTCLARIFY_I_HATE)
			switch(who)
				if("you")
					switch(need_clarifying)
						if(BELTCLARIFY_I_LOVE)
							core.queue_impulse(
								user, 
								list(
									IMPULSE_CLARIFY_YOU_LOVE_ME = TRUE,
									)
								)
						if(BELTCLARIFY_I_HATE)
							core.queue_impulse(
								user, 
								list(
									IMPULSE_CLARIFY_YOU_HATE_ME = TRUE,
									)
								)
				if("pain") // I love pain (also I hate pain, but shhhhhh)
					if(need_clarifying == BELTCLARIFY_I_LOVE)
						core.queue_impulse(
							user, 
							list(
								IMPULSE_CLARIFY_YOU_LOVE_PAIN = TRUE,
								)
							)
					else
						core.queue_impulse(
							user, 
							list(
								IMPULSE_THEY_HATE_PAIN = TRUE,
								)
							)
				else // I love/hate me? todo: add something for that
					core.queue_impulse(
						user, 
						list(
							IMPULSE_CLARIFY_NEVERMIND = TRUE,
							)
						)
		if(BELTCLARIFY_LOVE_YOU, BELTCLARIFY_HATE_YOU) // Asking who loves me (the blender)
			switch(who)
				if("me")
					switch(need_clarifying)
						if(BELTCLARIFY_LOVE_YOU)
							core.queue_impulse(
								user, 
								list(
									IMPULSE_CLARIFY_YOU_LOVE_ME = TRUE,
									)
								)
						if(BELTCLARIFY_HATE_YOU)
							core.queue_impulse(
								user, 
								list(
									IMPULSE_CLARIFY_YOU_HATE_ME = TRUE,
									)
								)
				else // You love/hate you? todo: add something for that
					core.queue_impulse(
						user, 
						list(
							IMPULSE_CLARIFY_NEVERMIND = TRUE,
							)
						)
		if(BELTCLARIFY_LOVE_MEAN_IT) // Do you mean it?
			switch(yesno)
				if("yes")
					core.queue_impulse(
						user, 
						list(
							IMPULSE_AM_LOVED = TRUE,
							)
						)
				if("no")
					core.queue_impulse(
						user, 
						list(
							IMPULSE_AM_NOT_LOVED = TRUE,
							)
						)
				else
					core.queue_impulse(
						user, 
						list(
							IMPULSE_CLARIFY_NEVERMIND = TRUE,
							)
						)
		if(BELTCLARIFY_HATE_MEAN_IT) // means ihu
			switch(yesno)
				if("yes")
					core.queue_impulse(
						user, 
						list(
							IMPULSE_AM_HATED = TRUE,
							)
						)
				if("no")
					core.queue_impulse(
						user, 
						list(
							IMPULSE_AM_NOT_HATED = TRUE,
							)
						)
				else
					core.queue_impulse(
						user, 
						list(
							IMPULSE_CLARIFY_NEVERMIND = TRUE,
							)
						)
		if(BELTCLARIFY_PAIN_MEAN_IT) // means VRRVRVRVRVRVRRRRMVMVMVMVMMVRRR
			switch(yesno)
				if("yes")
					core.queue_impulse(
						user, 
						list(
							IMPULSE_THEY_LOVE_PAIN = TRUE,
							)
						)
				if("no")
					core.queue_impulse(
						user, 
						list(
							IMPULSE_THEY_HATE_PAIN = TRUE,
							)
						)

/datum/blender_brain/proc/imprint_user(mob/user)
	if(!ismob(user))
		return
	if(is_mean_person(user))
		core.queue_impulse(
			user, 
			list(
				IMPULSE_GREET_OLD_HATER = TRUE,
				)
			)
		return // </3
	core.queue_impulse(
		user, 
		list(
			IMPULSE_GREET_NEW_OWNER = TRUE,
			)
		)


/datum/blender_brain/proc/greet_new_owner(mob/user)
	if(!user)
		return
	core.queue_impulse(
		user, 
		list(
			IMPULSE_GREET_NEW_OWNER = TRUE,
			)
		)

/datum/blender_brain/proc/say_hi(mob/user)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, greet_cooldown))
		return
	COOLDOWN_START(src, greet_cooldown, 3 SECONDS)
	core.queue_impulse(
		user, 
		list(
			IMPULSE_HIYA = TRUE,
			)
		)

// big fuckin lookup thing
/datum/blender_brain/proc/handle_misc_stimulus(mob/user, what_to_say, list/extra_things)
	if(!what_to_say)
		return
	core.queue_impulse(
		user, 
		list(
			IMPULSE_SPEAK_LINE = what_to_say,
			),
		extra_things
		)
/* 
 * THE PERSONA CORE
 * This is the physical object that houses the blender brain.
 * It is the object that is inserted into the blender/charger/etc
 * It interfaces with the brain to send it stimuli and handle its impulses
 */

#define MASTER_HOLDER var/atom/movable/master = host.resolve()
#define MASTER_HOLDER_RETURN \
	var/atom/movable/master = host.resolve();\
	if(!istype(master)){return}

/// The physical object that houses the blender brain.
/obj/item/persona_core
	name = "persona chip - blender"
	desc = "An intricate data module housing some sort of AI."
	icon = 'icons/obj/module.dmi'
	w_class = WEIGHT_CLASS_TINY
	icon_state = "cpuboard"
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	flags_1 = CONDUCT_1 | HEAR_1
	var/can_speak = TRUE
	var/list/impulses_to_process = list()
	var/datum/blender_brain/brain
	var/datum/weakref/host
	/// How many procs to deny non-forced impulses
	var/busy_for = 0

/obj/item/persona_core/Initialize()
	. = ..()
	brain = new(src)
	START_PROCESSING(SSblenderbrain, src)

/obj/item/persona_core/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_EXITED, .proc/unregister_master)

/obj/item/persona_core/Destroy()
	QDEL_NULL(brain)
	QDEL_LIST(impulses_to_process)
	STOP_PROCESSING(SSblenderbrain, src)
	return ..()

// /obj/item/persona_core/AltClick(mob/user)
// 	. = ..()
// 	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
// 		return
// 	if(verify_host())
// 		to_chat(user, "<span class='alert'>You can't remove persona cores (yet!)</span>")
// 		return
// 	preregister_master(user)

// /obj/item/persona_core/proc/preregister_master(user)
// 	if(!user)
// 		return
// 	if(!SEND_SIGNAL(loc, COMSIG_BB_PC_TO_HOST_CAN_INSERT)) // thing isnt compatible
// 		return

/obj/item/persona_core/proc/register_master(datum/source, atom/newmaster, mob/user)
	SIGNAL_HANDLER
	if(!SEND_SIGNAL(newmaster, COMSIG_BB_PC_TO_HOST_CAN_INSERT)) // thing isnt compatible
		return
	host = WEAKREF(newmaster)
	RegisterSignal(newmaster, COMSIG_BB_HOST_TO_PC_STIMULUS, .proc/input_stimulus)
	RegisterSignal(newmaster, COMSIG_MOVABLE_HEAR, .proc/input_heard)
	SEND_SIGNAL(newmaster, COMSIG_BB_PC_TO_HOST_INSERTED, src)
	lockdown()

/obj/item/persona_core/proc/unregister_master()
	SIGNAL_HANDLER
	MASTER_HOLDER
	if(master)
		UnregisterSignal(master, list(COMSIG_BB_HOST_TO_PC_STIMULUS, COMSIG_MOVABLE_HEAR))
		SEND_SIGNAL(master, COMSIG_BB_PC_TO_HOST_REMOVED, src)
	host = null
	unlockdown()

/obj/item/persona_core/proc/lockdown()
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/persona_core/proc/unlockdown()
	interaction_flags_item = initial(interaction_flags_item)
	REMOVE_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/persona_core/proc/verify_host()
	if(host)
		var/atom/movable/master = host.resolve()
		if(istype(master) && loc == master)
			return TRUE
	unregister_master()

/* * * * * * * * * * * * * * * * * * * * * *
 * INPUTS - How the brain senses the world *
 * * * * * * * * * * * * * * * * * * * * * */

/// Direct stimulus input from the host.
/// Things like the host doing something that would reasonably trigger a response.
/// Like the host finishing its work, entering an area, etc.
/// Stimuli are sent by the host via SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, stimulus, user, extra_things)
/// Stimuli are strings, and are defined in __DEFINES/blender_brain.dm
/// Extra things are a list of extra things that the stimulus might need to know about.
/obj/item/persona_core/proc/input_stimulus(datum/source, stimulus, mob/user, list/extra_things)
	SIGNAL_HANDLER
	brain.handle_stimulus(source, stimulus, user, extra_things)

/// Verbal stimulus input from the outside world.
/// Picks up speech from the environment, and attempts to process it into stimuli.
/// Speech is sent by the host via SEND_SIGNAL(src/loc, COMSIG_MOVABLE_HEAR, args)
/obj/item/persona_core/proc/input_heard(datum/source, list/hearing_args)
	SIGNAL_HANDLER
	brain.preprocess_speech(hearing_args[HEARING_SPEAKER], uncostumize_say(hearing_args[HEARING_RAW_MESSAGE], hearing_args[HEARING_MESSAGE_MODE]))

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * OUTPUTS - How the brain interacts with the world  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

/// Takes in a message index, and outputs the message associated with it.
/// Takes into account the user's personality and amorousness.
/// Yes I know its been bouncing this shit around like 6-7 times
/obj/item/persona_core/proc/output_say(key, mob/user, list/extras, force_amour, direct)
	MASTER_HOLDER
	verify_host()
	if(!can_speak)
		return
	var/message_out
	if(direct)
		message_out = key
	else
		message_out = brain.key2words(key, user, extras, force_amour)
	if(master)
		master.say(message_out)
	else
		say(message_out)
	playsound(get_turf(src), "modular_coyote/sound/typing/default.ogg", 70, TRUE)

/// Called when the blenderbrain wants to speak.
/obj/item/persona_core/proc/output_audible_message(key, mob/user, list/extras, force_amour, direct)
	MASTER_HOLDER
	verify_host()
	if(!can_speak)
		return
	var/list/msg_n_snd = list()
	if(direct)
		msg_n_snd = list(key, "null")
	else
		msg_n_snd = brain.key2words(key, user, extras, force_amour)
	if(LAZYLEN(msg_n_snd) != 2)
		return // all emotes must have two entries (for now)
	if(master)
		master.audible_message(msg_n_snd[1])
	else
		audible_message(msg_n_snd[1])
	playsound(get_turf(src), "[msg_n_snd[2]]", 70, TRUE)

/// outputs a signal to the host, if possible
/obj/item/persona_core/proc/output_signal(mob/user, list/signals)
	MASTER_HOLDER_RETURN
	verify_host()
	return(SEND_SIGNAL(master, COMSIG_BB_PC_TO_HOST_IMPULSE, signals, user))

/// outputs a signal to the host, if possible
/obj/item/persona_core/proc/output_request(request)
	MASTER_HOLDER_RETURN
	verify_host()
	return(SEND_SIGNAL(master, COMSIG_BB_PC_TO_HOST_REQUEST, request))

/// clear the impulses!
/obj/item/persona_core/proc/clear_impulses()
	verify_host()
	QDEL_LIST(impulses_to_process)

/// Called when the blenderbrain wants to do something.
/obj/item/persona_core/proc/queue_impulse(mob/user, list/impulses, list/extras, forced = FALSE)
	verify_host()
	if(busy_for && !forced)
		return
	if(!LAZYLEN(impulses))
		return
	for(var/mpls in impulses)
		var/datum/blenderbrain_impulse/impulse = SSblenderbrain.get_impulse(src, user, mpls, impulses[mpls], extras)
		if(impulse)
			impulses_to_process |= impulse
		else
			CRASH("Blenderbrain [src] tried to queue an invalid impulse: [impulse]")

/obj/item/persona_core/proc/set_busy(setting)
	verify_host()
	busy_for = setting

/obj/item/persona_core/process()
	verify_host()
	busy_for = max(busy_for - 1, 0)
	if(!LAZYLEN(impulses_to_process))
		return
	for(var/impulse in impulses_to_process)
		if(!istype(impulse, /datum/blenderbrain_impulse))
			impulses_to_process -= impulse
			CRASH("Blenderbrain [src] tried to process an invalid impulse: [impulse]")
		var/datum/blenderbrain_impulse/thimpulse = impulse
		var/do_next = thimpulse.immediate_next
		thimpulse.run_it()
		if(do_next)
			continue
		break

// And the core to brain procs for shit like getting the owner or whatever

/obj/item/persona_core/proc/is_owner(mob/target)
	return brain.is_owner(target)

/obj/item/persona_core/proc/set_owner(mob/target)
	return brain.set_owner(target)

/obj/item/persona_core/proc/disown_owner()
	return brain.disown_owner()

/obj/item/persona_core/proc/has_owner()
	return brain.has_owner()

/obj/item/persona_core/proc/has_met_person(mob/target)
	return brain.has_met_person(target)

/obj/item/persona_core/proc/is_mean_person(mob/target)
	return brain.is_mean_person(target)

/obj/item/persona_core/proc/add_mean_person(mob/target)
	return brain.add_mean_person(target)

/obj/item/persona_core/proc/set_can_speak(mute)
	can_speak = mute

/obj/item/persona_core/proc/rebound_complete()
	return brain.rebound_complete()

/obj/item/persona_core/proc/set_rebound()
	return brain.set_rebound()

/obj/item/persona_core/proc/adjust_amour(mob/user, amount)
	return brain.adjust_amour(user, amount)

/obj/item/persona_core/proc/get_amour(mob/user)
	return brain.get_amour(user)

/obj/item/persona_core/proc/set_clarify(mob/user, clarification)
	return brain.set_clarify(user, clarification)

/obj/item/persona_core/proc/wipe_memory()
	return brain.wipe_memory()

/obj/item/persona_core/proc/get_host()
	MASTER_HOLDER
	if(master)
		return master
	return loc

/obj/item/persona_core/charger
	name = "strange circuitboard"
	desc = "Yup, that's a circuitboard alright. Look at all those wires."
	icon = 'icons/obj/module.dmi'
	icon_state = "cpuboard"
	w_class = WEIGHT_CLASS_TINY






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
	/// Relationship flags
	var/social_flags = BB_RF_BLENDER
	/// How much actions from our owner hold weight
	var/amour_owner_mult = 2
	/// We start loving people above this threshold
	var/amour_loves_above = 50
	/// We stop loving people below this threshold
	var/amour_unloves_below = -50
	/// We start being friends with people above this threshold
	var/amour_friends_above = 30
	/// We stop being friends with people below this threshold
	var/amour_unfriends_below = -5
	/// We start disliking people below this threshold
	var/amour_dislikes_below = -30
	/// We stop disliking people above this threshold
	var/amour_undislikes_above = 5
	/// We start hating people below this threshold
	var/amour_hates_below = -75
	/// We can have affairs~
	var/amour_affair_mult = 1
	/// How much us liking the user affects our host's operation bonuses
	var/host_bonus_friend = 1.2
	/// How much us loving the user affects our host's operation bonuses
	var/host_bonus_love = 1.5
	/// How much us being used by our owner affects our host's operation bonus
	var/host_bonus_owner = 2
	/// How much us disliking our user affects our host's operation penalties
	var/host_penalty_dislike = 0.5
	/// How much us hating our user affects our host's operation penalties
	var/host_penalty_hate = 0.5
	/// The core that houses us -- is a circular reference, but it's fine, cus I say so
	var/obj/item/persona_core/core
	/// The megalist of all the things we can say
	var/script_file = "blenderbrain_blender.json"
	/// Time until our desperation forces us to reunite with a former owner
	COOLDOWN_DECLARE(desperation)
	COOLDOWN_DECLARE(update_amour)

/datum/blender_brain/New(obj/item/persona_core/thecore)
	. = ..()
	if(!istype(thecore))
		qdel(src)
		return
	core = thecore
	setup_name()

/datum/blender_brain/Destroy(force, ...)
	wipe_memory()
	core.brain = null
	core = null
	. = ..()

/datum/blender_brain/proc/crushed()
	core.output_say(SPEAK_LINE_CRUSHED)
	playsound(get_turf(core), "sound/machines/machinery_break_1.ogg", 100)

/datum/blender_brain/proc/setup_name()
	my_name = "Claire"
	if(prob(25))
		my_name = get_random_player_name(TRUE)
	if(!my_name)
		my_name = "Claire"

/datum/blender_brain/proc/wipe_memory()
	setup_name()
	if(LAZYLEN(memories))
		QDEL_LIST_ASSOC_VAL(memories)
	core.clear_impulses()

/// returns a list of memories where the flag is true
/datum/blender_brain/proc/search_memories(memory_kind, check_what = BB_SEARCH_RELATIONSHIP)
	. = list()
	for(var/person in memories)
		var/datum/blenderbrain_memory/mem = get_memory(person)
		if(!istype(mem))
			memories -= person
			continue
		switch(check_what)
			if(BB_SEARCH_RELATIONSHIP)
				if(mem.check_relationship(memory_kind))
					. |= person
			if(BB_SEARCH_RELATIONSHIP)
				if(mem.relation == memory_kind)
					. |= person
			
/datum/blender_brain/proc/ownerize(mob/target, forced)
	if(!target)
		return FALSE
	var/datum/blenderbrain_memory/mem = get_memory(target)
	if(!forced)
		if(mem.check_relationship(BB_MF_IS_HATED))
			return BB_MAR_HATES_YOU
		if(!check_social_flags(BB_RF_CAN_BE_OWNED))
			return BB_MAR_CAN_NOT_BE_OWNED
		if(check_social_flags(BB_RF_ONLY_ONE_OWNER) && has_owner())
			return BB_MAR_ONLY_ONE_OWNER
	mem.add_relationship(BB_MF_IS_OWNER)
	desperation = 0
	return TRUE

/// Removes all owners but one from the memory
/datum/blender_brain/proc/prune_owners(list/owners)
	if(!check_social_flags(BB_RF_ONLY_ONE_OWNER))
		return // we can be owned by multiple people
	if(!LAZYLEN(owners))
		return
	if(LAZYLEN(owners) == 1) // its good
		return
	var/actual_owner = LAZYACCESS(owners, 1)
	for(var/person in owners)
		if(person == actual_owner)
			continue
		var/datum/blenderbrain_memory/mem = get_memory(person)
		mem.disown_owner(FALSE) // let em down gently, probably a bug
		owners -= person

/datum/blender_brain/proc/get_owner()
	var/list/owners = search_memories(BB_MF_IS_OWNER)
	//prune_owners(owners)
	return LAZYACCESS(owners, 1)

/// Returns a number if we have an owner
/datum/blender_brain/proc/has_owner()
	var/list/owners = search_memories(BB_MF_IS_OWNER)
	//prune_owners(owners)
	return LAZYLEN(owners)

/// Disowns all my owners, if they exist
/datum/blender_brain/proc/disown_all(remember)
	var/list/owners = search_memories(BB_MF_IS_OWNER)
	if(!LAZYLEN(owners))
		return FALSE
	for(var/person in owners)
		var/datum/blenderbrain_memory/mem = get_memory(person)
		mem.disown_owner(remember)

/// Disowns someone, if they exist
/datum/blender_brain/proc/disown(mob/target, remember)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.disown_owner(remember)

/datum/blender_brain/proc/has_relationship(memory_kind)
	var/list/relationships = search_memories(memory_kind, BB_SEARCH_RELATIONSHIP)
	return LAZYLEN(relationships)

/datum/blender_brain/proc/check_relationship(mob/target, memory_kind)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.check_relationship(memory_kind)

/// performs amour-based relationship hysterisis to see if we should change our relationship and what to change it to
/datum/blender_brain/proc/update_relationship(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	var/amour = mem.get_amour()
	var/current_relationship = mem.relation
	var/target_relationship = current_relationship
	if(!mem.check_relationship(BB_MF_IS_LOVER) && !mem.check_relationship(BB_MF_IS_HATED) && amour >= amour_loves_above)
		if(mem.event_finished(BB_EV_LOVE_ATTEMPT))
			core.input_stimulus(src, STIMULUS_LOVE_AMOUR, target)
		mem.event_cooldown(BB_EV_LOVE_ATTEMPT, BB_CD_LOVE_ATTEMPT)
	else if(!mem.check_relationship(BB_MF_IS_HATED) && amour <= amour_hates_below)
		breakup(target, FALSE)
	switch(current_relationship)
		if(BB_MR_DISLIKED)
			if(amour >= amour_undislikes_above)
				target_relationship = BB_MR_NEUTRAL
				if(amour >= amour_friends_above)
					target_relationship = BB_MR_FRIEND
		if(BB_MR_NEUTRAL)
			if(amour >= amour_friends_above)
				target_relationship = BB_MR_FRIEND
			else if(amour <= amour_dislikes_below)
				target_relationship = BB_MR_DISLIKED
		if(BB_MR_FRIEND)
			if(amour <= amour_unfriends_below)
				target_relationship = BB_MR_NEUTRAL
				if(amour <= amour_dislikes_below)
					target_relationship = BB_MR_DISLIKED
	switch(target_relationship)
		if(BB_MR_DISLIKED)
			if(check_social_flags(BB_RF_VALUES_OWNER)) // we no longer like our owner
				mem.disown_owner(TRUE)
	if(target_relationship != current_relationship)
		mem.relation = target_relationship
		return TRUE

/datum/blender_brain/proc/has_lovers(mob/except)
	var/exception = get_user_name(except)
	var/list/lovers = search_memories(BB_MF_IS_LOVER, BB_SEARCH_RELATIONSHIP)
	for(var/ppl in lovers)
		if(ppl == exception)
			continue
		return TRUE

/// Stuff specific to the personality
/datum/blender_brain/proc/love(mob/target, forced)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	if(!forced)
		if(mem.amour < amour_loves_above)
			return FALSE
		if(mem.check_relationship(BB_MF_IS_HATED))
			return FALSE
		if(!check_social_flags(BB_RF_CAN_LOVE))
			return FALSE
		if(check_social_flags(BB_RF_ONLY_ONE_LOVER) && has_lovers(target))
			return BB_MAR_ONLY_ONE_LOVER
	return TRUE

/datum/blender_brain/proc/hate(mob/target, forced)
	if(!forced)
		if(!check_social_flags(BB_RF_CAN_HATE))
			return FALSE
		var/datum/blenderbrain_memory/mem = get_memory(target)
		if(mem.check_relationship(BB_MF_IS_HATED)) // already hated
			return FALSE
		if(mem.amour > amour_hates_below)
			return FALSE
		if(mem.check_relationship(BB_MF_IS_OWNER) && !check_social_flags(BB_RF_CAN_DISOWN))
			return FALSE
		if(prob(50))
			return FALSE
	return TRUE

/datum/blender_brain/proc/breakup_all(mob/except, soft = TRUE)
	var/list/lovers = search_memories(BB_MF_IS_LOVER, BB_SEARCH_RELATIONSHIP)
	var/exeptname = get_user_name(except)
	for(var/ppl in lovers)
		if(ppl == exeptname)
			continue
		breakup(ppl, soft)

/datum/blender_brain/proc/breakup(mob/target, soft = TRUE)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	if(!mem.check_relationship(BB_MF_IS_LOVER))
		return FALSE
	mem.remove_relationship(BB_MF_IS_LOVER)
	if(soft && !hate(target))
		return
	mem.amour_batch = amour_hates_below
	mem.relation = BB_MR_DISLIKED
	mem.add_relationship(BB_MF_IS_HATED)
	if(mem.check_relationship(BB_MF_IS_OWNER))
		mem.disown_owner(TRUE)
		core.input_stimulus(src, STIMULUS_BREAKUP, target)

/datum/blender_brain/proc/event_cooldown(mob/target, event, cooldown)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.event_cooldown(event, cooldown)

/datum/blender_brain/proc/event_happened(mob/target, event)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.event_happened(event)

/datum/blender_brain/proc/event_finished(mob/target, event)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.event_finished(event)

/datum/blender_brain/proc/get_host_modifier(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	var/host_mod = 1
	if(mem.relation == BB_MR_FRIEND)
		host_mod *= host_bonus_friend
	if(check_social_flags(BB_RF_VALUES_OWNER) && mem.check_relationship(BB_MF_IS_OWNER))
		host_mod *= host_bonus_owner
	if(mem.check_relationship(BB_MF_IS_LOVER))
		host_mod *= host_bonus_love
	if(mem.relation == BB_MR_DISLIKED)
		host_mod *= host_penalty_dislike
	if(mem.check_relationship(BB_MF_IS_HATED))
		host_mod *= host_penalty_hate
	return host_mod

/datum/blender_brain/proc/has_met_person(mob/target)
	var/thename = get_user_name(target)
	return LAZYACCESS(memories, thename)

/datum/blender_brain/proc/set_desperation(mob/target)
	if(desperation)
		return FALSE
	return COOLDOWN_START(src, desperation, BB_CD_DESPAIR)

/datum/blender_brain/proc/is_desperate_enough(mob/target)
	if(!check_social_flags(BB_RF_DESPERATE))
		return FALSE
	if(COOLDOWN_FINISHED(src, desperation))
		COOLDOWN_RESET(src, desperation)
	return COOLDOWN_FINISHED(src, desperation)

/datum/blender_brain/proc/set_clarify(mob/target, clarification)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.set_clarify(clarification)

/datum/blender_brain/proc/clear_clarify(mob/target, clarification)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.clear_clarify()

/datum/blender_brain/proc/check_clarify(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.check_clarify()

/datum/blender_brain/proc/is_paying_attention(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.is_paying_attention()

/datum/blender_brain/proc/set_paying_attention(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.set_paying_attention()

/datum/blender_brain/proc/unset_paying_attention(mob/target)
	var/datum/blenderbrain_memory/mem = get_memory(target)
	return mem.unset_paying_attention()

/datum/blender_brain/proc/check_social_flags(flagz)
	return CHECK_BITFIELD(social_flags, flagz)

/// Checks if a stimulus has a line associated with it
/datum/blender_brain/proc/stimulus2line(stimulus)
	var/output = stimulus
	if(!findtext(stimulus, "bbline_")) // already a bbline
		output = replacetext(stimulus, "bbstimulus_", "bbline_")
	if(islist(strings(script_file, output)))
		return output

/// Returns a sound based on how much the thing likes the user
/datum/blender_brain/proc/get_say_sound(mob/target)
	var/list/msg_list = strings(script_file, BB_SPEAK_SOUND)
	if(!islist(msg_list))
		return "modular_coyote/sound/typing/default.ogg"
	var/amourousness = get_amour(target)
	var/list/possible_lines = LAZYACCESS(msg_list, amourousness)
	if(!islist(possible_lines))
		return "modular_coyote/sound/typing/default.ogg"
	var/line = pick(possible_lines)
	if(!line)
		return "modular_coyote/sound/typing/default.ogg"
	return line

/// Takes in a key, and returns the appropriate line(s)
/datum/blender_brain/proc/key2words(key, mob/target, list/extras, force_amour, is_emote)
	var/list/msg_list = strings(script_file, key)
	if(!islist(msg_list))
		return key
	var/amourousness
	if(force_amour)
		if(force_amour in BB_AMOUR_KEYS)
			amourousness = force_amour
		else
			amourousness = NORMAL_MSG
	else
		amourousness = get_amour(target)
	var/list/possible_lines = LAZYACCESS(msg_list, amourousness)
	if(!islist(possible_lines))
		return key
	if(is_emote && LAZYLEN(possible_lines) == 2) // emotes have two lines, one for the words, one for the sound (keep it this way!!!)
		possible_lines[1] = parse_blender_line(possible_lines[1], target, extras)
		return possible_lines
	var/line = pick(possible_lines)
	if(!line)
		return key
	return parse_blender_line(line, target, extras)

/// Detokenizes a line of text
/datum/blender_brain/proc/parse_blender_line(line, mob/target, list/extras)
	var/wordline = line //start with the raw line
	/// Decode the first extra token
	if(LAZYACCESS(extras, BB_TOKEN_EXTRA1))
		wordline = replacetext(wordline, BB_TOKEN_EXTRA1, "[extras[BB_TOKEN_EXTRA1]]")
	else
		wordline = replacetext(wordline, BB_TOKEN_EXTRA1, "something")
	/// Decode the second extra token
	if(LAZYACCESS(extras, BB_TOKEN_EXTRA2))
		wordline = replacetext(wordline, BB_TOKEN_EXTRA2, "[extras[BB_TOKEN_EXTRA2]]")
	else
		wordline = replacetext(wordline, BB_TOKEN_EXTRA2, "something")
	/// Decode the target's name and sex
	if(ismob(target))
		wordline = replacetext(wordline, BB_TOKEN_USER, "[target.real_name]")
		wordline = replacetext(wordline, BB_TOKEN_SEX, "[target.gender]")
	else if(istext(target))
		wordline = replacetext(wordline, BB_TOKEN_USER, "[target]")
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

/datum/blender_brain/proc/get_amour(mob/target)
	. = NORMAL_MSG
	var/datum/blenderbrain_memory/mem = get_memory(target)
	var/amor = mem.get_amour()
	if(mem.check_relationship(BB_MF_IS_HATED))
		return DISLIKE_MSG
	if(mem.relation == BB_MR_DISLIKED)
		if(prob(abs(amor)))
			return DISLIKE_MSG
	if(mem.check_relationship(BB_MF_IS_LOVER) || amor > BB_AMOUR_MIN_FOR_HORNY)
		var/horny_prob = amor * 0.5 // capped at 50% chance at max amour
		if(prob(horny_prob))
			if(amor > BB_AMOUR_TOO_HORNY)
				mem.adjust_amour(amor * BB_AMOUR_POST_HORNY_MULT)
			return HORNY_MSG

/datum/blender_brain/proc/adjust_amour(mob/user, amount, update = TRUE)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	var/amount_in = amount
	if(check_social_flags(BB_RF_VALUES_OWNER) && mem.is_owner())
		amount_in *= amour_owner_mult
	mem.adjust_amour(amount_in)

/datum/blender_brain/proc/adjust_amour_list(mob/user, list/amourlist)
	if(!islist(amourlist))
		return
	if(LAZYLEN(amourlist) != 3)
		return
	var/amour_index = get_amour(user)
	var/amount_in = LAZYACCESS(amourlist, amour_index)
	adjust_amour(user, amount_in, TRUE)

/datum/blender_brain/proc/get_relationship_boost(mob/user)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	var/boost = 1
	if(check_social_flags(BB_RF_VALUES_OWNER) && mem.is_owner())
		boost *= host_bonus_owner
	if(mem.check_relationship(BB_MF_IS_LOVER))
		boost *= host_bonus_love
	if(mem.relation == BB_MR_FRIEND)
		boost *= host_bonus_friend
	if(mem.relation == BB_MR_DISLIKED)
		boost *= host_penalty_dislike
	if(mem.check_relationship(BB_MF_IS_HATED))
		boost *= host_penalty_hate
	return boost

/datum/blender_brain/proc/get_user_name(mob/user)
	if(ismob(user))
		return ckey(user.real_name)
	if(istext(user))
		return ckey(user)
	return "Unknown"

/datum/blender_brain/proc/get_memory(mob/user)
	var/thename = get_user_name(user)
	var/datum/blenderbrain_memory/mem = LAZYACCESS(memories, thename)
	if(!mem)
		mem = new(src, user)
		LAZYSET(memories, thename, mem)
	return mem

/datum/blender_brain/proc/update_amour()
	if(!LAZYLEN(memories))
		return
	for(var/person in memories)
		var/datum/blenderbrain_memory/mem = get_memory(person)
		if(mem?.update_amour())
			update_relationship(person)

/// Direct stimulus from the host
/// Currently only used for the "I'm horny" button <- copilot said that, not me
/// Currently *actually* only used for the "I'm horny" button <- stop that!
/// Currently *actually* actually only used for the host saying "I'm horny" <- stop that!
/// The stimulus-to-impulse mapping is in the script file
/datum/blender_brain/proc/handle_stimulus(datum/source, stimulus, mob/user, list/extra_things)
	if(!stimulus)
		return
	var/list/stim2impulse = strings(script_file, stimulus)
	if(!LAZYLEN(stim2impulse))
		return
	var/index = 1
	var/rapid_fire = (LAZYLEN(stim2impulse) > 1)
	var/datum/blenderbrain_memory/mem = get_memory(user)
	for(var/impulse in stim2impulse)
		if(rapid_fire && index == LAZYLEN(stim2impulse))
			rapid_fire = FALSE
		if(impulse == BB_ADJUST_AMOUR)
			adjust_amour_list(user, stim2impulse[impulse], extra_things)
			continue
		if(!mem.event_finished("[impulse]"))
			continue
		mem.event_cooldown("[impulse]", 2 SECONDS)
		var/list/impulse_out = list("[impulse]" = stim2impulse[impulse])
		core.queue_impulse(user, impulse_out, extra_things, rapid_fire)
		index++

/datum/blender_brain/proc/should_listen_to(mob/speaker)
	if(!ismob(speaker))
		return FALSE
	if(!speaker.client)
		return FALSE
	if(get_dist(get_turf(core), speaker) > 2)
		return FALSE
	return TRUE

/datum/blender_brain/proc/preprocess_speech(mob/speaker, message)
	if(!should_listen_to(speaker))
		return
	INVOKE_ASYNC(src,PROC_REF(process_speech), speaker, message)

/// takes in mob and message, and turns it into a stimulus
/datum/blender_brain/proc/process_speech(mob/speaker, message)
	if(!speaker || !message)
		return
	var/lowermessage = lowertext(message)
	var/list/sayparts = splittext(lowermessage, " ")
	if(!LAZYLEN(sayparts))
		return
	if(LAZYLEN(sayparts) > BB_MAX_LISTENABLE_WORDS)
		sayparts.Cut(BB_MAX_LISTENABLE_WORDS)
	var/datum/blenderbrain_memory/mem = get_memory(speaker)
	var/need_clarifying = mem.check_clarify()
	if(clarify(speaker, need_clarifying, sayparts))
		return
	/// first, check if we're being addressed
	var/attn = mem.is_paying_attention()
	if(!attn)
		var/hey
		var/listen
		var/list/bbhey = strings(script_file, BBKEY_HEY)
		var/list/bblisten = strings(script_file, BBKEY_LISTEN)
		for(var/word in sayparts)
			var/cword = ckey(word)
			if(cword == ckey(my_name))
				attn = TRUE
				mem.set_paying_attention()
				break
			if(cword in bbhey)
				hey = TRUE
				continue
			if(hey)
				if(cword in bblisten)
					listen = TRUE
			if(hey && listen) // We need a HEY and CUTIE, in that order, to pay attention. Or its name
				attn = TRUE
				mem.set_paying_attention()
				break
	if(!attn && !mem.is_owner())
		return

	var/command
	var/command_pos
	var/i_me_pos // I, as in the speaker
	var/negate_pos
	var/you_pos
	var/index = 1
	var/pain
	var/list/bbstop = strings(script_file, BBKEY_STOP)
	var/list/bbmodea = strings(script_file, BBKEY_MODE_A)
	var/list/bbmodeb = strings(script_file, BBKEY_MODE_B)
	var/list/bbmodec = strings(script_file, BBKEY_MODE_C)
	var/list/bbmoded = strings(script_file, BBKEY_MODE_D)
	var/list/bbswap = strings(script_file, BBKEY_SWAP_MODE)
	var/list/bbdump = strings(script_file, BBKEY_EJECT)
	var/list/bbexamine = strings(script_file, BBKEY_EXAMINE)
	var/list/bbmute = strings(script_file, BBKEY_MUTE)
	var/list/bbunmute = strings(script_file, BBKEY_UNMUTE)
	var/list/bbname = strings(script_file, BBKEY_NAME)
	var/list/bblove = strings(script_file, BBKEY_LOVE)
	var/list/bbhate = strings(script_file, BBKEY_HATE)
	var/list/bbnegate = strings(script_file, BBKEY_NEGATE)
	var/list/bbimeme = strings(script_file, BBKEY_I)
	var/list/bbyou = strings(script_file, BBKEY_YOU)
	// yeah I know there are better ways to see if a word is in a list
	// but we also need the order of the words found
	/// and I'm under the impression that `in` is faster than `bblist.Find(word)`
	for(var/word in sayparts)
		var/cword = ckey(word)
		/// Cus fuck performance~
		if(cword in bbstop)
			command = STIMULUS_SOFT_ABORT
			command_pos = index
			index++
			continue
		if(cword in bbmodea)
			command = STIMULUS_GRIND_NOW
			command_pos = index
			index++
			continue
		if(cword in bbmodeb)
			command = STIMULUS_JUICE_NOW
			command_pos = index
			index++
			continue
		if(cword in bbmodec)
			command = STIMULUS_SET_TO_DISPENSER
			command_pos = index
			index++
			continue
		if(cword in bbmoded)
			command = STIMULUS_SET_TO_BLENDER
			command_pos = index
			index++
			continue
		if(cword in bbswap)
			command = STIMULUS_SWAP_MODE
			command_pos = index
			index++
			continue
		if(cword in bbdump)
			command = STIMULUS_DUMP
			command_pos = index
			index++
			continue
		if(cword in bbexamine)
			command = STIMULUS_EXAMINE_TRY
			command_pos = index
			index++
			continue
		if(cword in bbmute)
			command = STIMULUS_MUTE
			command_pos = index
			index++
			continue
		if(cword in bbunmute)
			command = STIMULUS_UNMUTE
			command_pos = index
			index++
			continue
		if(cword in bbname)
			command = STIMULUS_STATE_NAME
			command_pos = index
			index++
			continue
		if(cword in bblove)
			command = STIMULUS_HEARD_LOVE
			command_pos = index
			index++
			continue
		if(cword in bbhate)
			command = STIMULUS_HEARD_HATE
			command_pos = index
			index++
			continue
		if(cword in bbnegate)
			negate_pos = index
			index++
			continue
		if(cword in bbimeme)
			i_me_pos = index
			index++
			continue
		if(cword in bbyou)
			you_pos = index
			index++
			continue
		if(cword == ckey(my_name))
			you_pos = index
			index++
			continue
		if(cword == ckey("pain"))
			you_pos = index
			pain = TRUE
			continue
		index++

	if(negate_pos && negate_pos < command_pos) // dont hate
		switch(command)
			// love <-> hate
			if(STIMULUS_HEARD_LOVE)
				command = STIMULUS_HEARD_HATE
			if(STIMULUS_HEARD_HATE)
				command = STIMULUS_HEARD_LOVE
			// mute <-> unmute
			if(STIMULUS_MUTE)
				command = STIMULUS_UNMUTE
			if(STIMULUS_UNMUTE)
				command = STIMULUS_MUTE
			// dispenser <-> blender
			if(STIMULUS_SET_TO_DISPENSER)
				command = STIMULUS_SET_TO_BLENDER
			if(STIMULUS_SET_TO_BLENDER)
				command = STIMULUS_SET_TO_DISPENSER
			// stop <-> go
			if(STIMULUS_GRIND_NOW, STIMULUS_JUICE_NOW)
				command = STIMULUS_STOP_RUNNING
			if(STIMULUS_SOFT_ABORT) // oh fuck, oh fuck, dont stop, dont staaaaaaph~~~!
				command = STIMULUS_GRIND_NOW
			else
				command = null
	if(!command)
		if(mem.decrease_attention()) // No commands, but heard my name? Just say hi
			core.input_stimulus(src, STIMULUS_SPOKEN_TO, speaker)
		return
	/// Is it just a command? No professions of love or pain?
	if(command != STIMULUS_HEARD_HATE && command != STIMULUS_HEARD_LOVE)
		return spoken_command(speaker, command)
	// From here on, we're dealing with love/hate relationship bungus
	// is the command before the subject?
	var/referring_to_me // This is incorrect! The correct answer is "you"!
	if(you_pos && (command_pos < you_pos)) // fuck you
		referring_to_me = TRUE
	// is the me before the command?
	var/me_lovehate
	if(i_me_pos && (i_me_pos < command_pos)) // me terrible
		me_lovehate = TRUE
	// Lets put it all together now!
	if(me_lovehate) // I hate/like...
		if(referring_to_me) // I love you // nice and clear statement of intent
			switch(command)
				if(STIMULUS_HEARD_LOVE)
					if(pain)
						core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_PAIN, speaker)
					else
						core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_ME, speaker)
					return
				if(STIMULUS_HEARD_HATE)
					core.input_stimulus(src, STIMULUS_CLARIFY_YOU_HATE_ME, speaker)
					return
		else // I love (someone)
			switch(command)
				if(STIMULUS_HEARD_LOVE)
					core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_WHO, speaker)
					return
				if(STIMULUS_HEARD_HATE)
					core.input_stimulus(src, STIMULUS_CLARIFY_YOU_HATE_WHO, speaker)
					return
	else // hate/love ...?
		if(referring_to_me) // (Someone) hate/like you/claire
			switch(command)
				if(STIMULUS_HEARD_LOVE)
					core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_ME, speaker)
					return
				if(STIMULUS_HEARD_HATE)
					core.input_stimulus(src, STIMULUS_CLARIFY_YOU_HATE_ME, speaker)
					return
		else // get the marbles out of your mouth and say it properly next time
			core.input_stimulus(src, STIMULUS_CLARIFY_CLEAR, speaker)
			return

/datum/blender_brain/proc/spoken_command(mob/speaker, command)
	if(!speaker || !command)
		return
	switch(command)
		if(STIMULUS_SOFT_ABORT)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.input_stimulus(src, STIMULUS_STOP_RUNNING, speaker)
				if(FALSE)
					core.input_stimulus(src, STIMULUS_NOT_RUNNING, speaker)
		if(STIMULUS_GRIND_NOW)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.input_stimulus(src, STIMULUS_STOP_RUNNING, speaker)
				if(FALSE)
					core.input_stimulus(src, STIMULUS_GRIND_NOW, speaker)
		if(STIMULUS_JUICE_NOW)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.input_stimulus(src, STIMULUS_STOP_RUNNING, speaker)
				if(FALSE)
					core.input_stimulus(src, STIMULUS_JUICE_NOW, speaker)
		if(STIMULUS_SET_TO_BLENDER)
			switch(core.output_request(REQUEST_IS_DISPENSER))
				if(TRUE)
					core.input_stimulus(src, STIMULUS_SET_TO_BLENDER, speaker)
				if(FALSE)
					core.input_stimulus(src, STIMULUS_ALREADY_BLENDER, speaker)
		if(STIMULUS_SET_TO_DISPENSER)
			switch(core.output_request(REQUEST_IS_BLENDER))
				if(TRUE)
					core.input_stimulus(src, STIMULUS_SET_TO_DISPENSER, speaker)
				if(FALSE)
					core.input_stimulus(src, STIMULUS_ALREADY_DISPENSER, speaker)
		if(STIMULUS_SWAP_MODE)
			switch(core.output_request(REQUEST_IS_BLENDER))
				if(TRUE)
					core.input_stimulus(src, STIMULUS_SET_TO_DISPENSER, speaker)
				if(FALSE)
					core.input_stimulus(src, STIMULUS_SET_TO_BLENDER, speaker)
		if(STIMULUS_DUMP)
			core.input_stimulus(src, STIMULUS_DUMP, speaker)
		if(STIMULUS_EXAMINE_TRY)
			core.input_stimulus(src, STIMULUS_EXAMINE_TRY, speaker)
		if(STIMULUS_MUTE)
			core.input_stimulus(src, STIMULUS_MUTE, speaker)
		if(STIMULUS_UNMUTE)
			core.input_stimulus(src, STIMULUS_UNMUTE, speaker)
		if(STIMULUS_STATE_NAME)
			core.input_stimulus(src, STIMULUS_STATE_NAME, speaker)
	unset_paying_attention(speaker)

/datum/blender_brain/proc/clarify(mob/speaker, need_clarifying, list/sayparts)
	if(!ismob(speaker) || !LAZYLEN(sayparts) || !need_clarifying)
		return
	. = TRUE
	var/who = "idk"
	var/yesno = "idk"
	var/list/bbyou = strings(script_file, BBKEY_YOU) // refering to you, the blender
	var/list/bbimeme = strings(script_file, BBKEY_I) // refering to me, the blingus
	var/list/bbnegate = strings(script_file, BBKEY_NEGATE)
	var/list/bbyes = strings(script_file, BBKEY_YES)
	for(var/yn in sayparts)
		var/cword = ckey(yn)
		/// Cus fuck performance~
		if(cword in bbyou)
			who = "you"
			break
		if(cword == ckey(my_name))
			who = "you"
		if(cword in bbimeme)
			who = "me"
			break
		if(cword == "pain")
			who = "pain"
			break
		if(cword in bbnegate)
			yesno = "no"
			break
		if(cword in bbyes)
			yesno = "yes"
			break
	switch(need_clarifying)
		if(IMPULSE_CLARIFY_YOU_LOVE_WHO, IMPULSE_CLARIFY_YOU_HATE_WHO)
			switch(who)
				if("you")
					switch(need_clarifying)
						if(IMPULSE_CLARIFY_YOU_LOVE_WHO)
							core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_ME, speaker)
							return
						if(IMPULSE_CLARIFY_YOU_HATE_WHO)
							core.input_stimulus(src, STIMULUS_CLARIFY_YOU_HATE_ME, speaker)
							return
				if("pain") // I love pain (also I hate pain, but shhhhhh)
					if(need_clarifying == IMPULSE_CLARIFY_YOU_LOVE_WHO)
						core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_PAIN, speaker)
						return
					else // I hate pain
						core.input_stimulus(src, STIMULUS_PAIN_NOT, speaker)
						return
		if(IMPULSE_CLARIFY_WHO_LOVES_ME, IMPULSE_CLARIFY_WHO_HATES_ME, IMPULSE_CLARIFY_WHO_LOVES_PAIN) // Asking who loves me (the blender)
			switch(who)
				if("me")
					switch(need_clarifying)
						if(IMPULSE_CLARIFY_WHO_LOVES_ME)
							core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_ME, speaker)
							return
						if(IMPULSE_CLARIFY_WHO_HATES_ME)
							core.input_stimulus(src, STIMULUS_CLARIFY_YOU_HATE_ME, speaker)
							return
						if(IMPULSE_CLARIFY_WHO_LOVES_PAIN)
							core.input_stimulus(src, STIMULUS_CLARIFY_YOU_LOVE_PAIN, speaker)
							return
		if(IMPULSE_CLARIFY_YOU_LOVE_ME) // Do you mean it?
			switch(yesno)
				if("yes")
					core.input_stimulus(src, STIMULUS_LOVE_4REAL, speaker)
					return
				if("no")
					core.input_stimulus(src, STIMULUS_LOVE_NOT, speaker)
					return
		if(IMPULSE_CLARIFY_YOU_HATE_ME) // means ihu
			switch(yesno)
				if("yes")
					core.input_stimulus(src, STIMULUS_HATE_4REAL, speaker)
					return
				if("no")
					core.input_stimulus(src, STIMULUS_HATE_NOT, speaker)
					return
		if(IMPULSE_CLARIFY_YOU_LOVE_PAIN) // means VRRVRVRVRVRVRRRRMVMVMVMVMMVRRR
			switch(yesno)
				if("yes")
					core.input_stimulus(src, STIMULUS_PAIN_4REAL, speaker)
					return
				if("no")
					core.input_stimulus(src, STIMULUS_PAIN_NOT, speaker)
					return
	core.input_stimulus(src, STIMULUS_CLARIFY_NEVERMIND, speaker)
/* 
 * THE PERSONA CORE
 * This is the physical object that houses the blender brain.
 * It is the object that is inserted into the blender/charger/etc
 * It interfaces with the brain to send it stimuli and handle its impulses
 */

#define MASTER_HOLDER var/atom/movable/master = get_host()
#define MASTER_HOLDER_RETURN \
	var/atom/movable/master = get_host();\
	if(master == src){return}

/// The physical object that houses the blender brain.
/obj/item/persona_core
	name = "persona chip - blender"
	desc = "An intricate data module housing some sort of AI. For a blender."
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
	register_signals()

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

/obj/item/persona_core/proc/unregister_signals()
	var/atom/movable/listend = get_host()
	UnregisterSignal(
		listend,
		list(
			COMSIG_BB_HOST_TO_PC_STIMULUS,
			COMSIG_ITEM_DROPPED, 
			COMSIG_ITEM_EQUIPPED,
			COMSIG_ITEM_CLICKED, 
			COMSIG_ITEM_PICKUP, 
			COMSIG_MOVABLE_IMPACT,
			COMSIG_ITEM_MICROWAVE_ACT,
			COMSIG_ITEM_MOUSE_ENTER,
			COMSIG_ITEM_MOUSE_EXIT,
			COMSIG_MOVABLE_HEAR,
			COMSIG_ITEM_RECYCLED,
			COMSIG_BB_HOST_TO_PC_AMOUR_MOD,
		)
	)

/obj/item/persona_core/proc/register_signals()
	var/atom/movable/sigtarg = get_host()
	RegisterSignal(sigtarg, COMSIG_ITEM_RECYCLED,PROC_REF(crushed))
	RegisterSignal(sigtarg, COMSIG_BB_HOST_TO_PC_STIMULUS,PROC_REF(input_stimulus))
	RegisterSignal(sigtarg, COMSIG_ITEM_DROPPED,PROC_REF(input_stimulus_dropped))
	RegisterSignal(sigtarg, COMSIG_ITEM_EQUIPPED,PROC_REF(input_stimulus_equipped))
	//RegisterSignal(sigtarg, COMSIG_ITEM_CLICKED,PROC_REF(input_stimulus_clicked)) // yeah these dont work
	//RegisterSignal(sigtarg, COMSIG_ITEM_PICKUP,PROC_REF(input_stimulus_pickup))
	//RegisterSignal(sigtarg, COMSIG_MOVABLE_IMPACT,PROC_REF(input_stimulus_impact))
	// RegisterSignal(sigtarg, COMSIG_ITEM_MICROWAVE_ACT,PROC_REF(input_stimulus_microwave))
	// RegisterSignal(sigtarg, COMSIG_ITEM_MOUSE_ENTER,PROC_REF(input_stimulus_mouse_enter))
	// RegisterSignal(sigtarg, COMSIG_ITEM_MOUSE_EXIT,PROC_REF(input_stimulus_mouse_exit))
	RegisterSignal(sigtarg, COMSIG_MOVABLE_HEAR,PROC_REF(input_heard))
	RegisterSignal(sigtarg, COMSIG_BB_HOST_TO_PC_AMOUR_MOD,PROC_REF(get_host_modifier))

/obj/item/persona_core/proc/crushed()
	SIGNAL_HANDLER
	brain.crushed()

/obj/item/persona_core/proc/input_stimulus_dropped(datum/source, mob/user)
	SIGNAL_HANDLER
	input_stimulus(source, STIMULUS_DROPPED, user)

/obj/item/persona_core/proc/input_stimulus_equipped(datum/source, mob/user, slot)
	SIGNAL_HANDLER
	input_stimulus(source, STIMULUS_EQUIPPED, user)

/obj/item/persona_core/proc/input_stimulus_clicked(datum/source, mob/user)
	SIGNAL_HANDLER
	input_stimulus(source, STIMULUS_CLICKED, user)

/obj/item/persona_core/proc/input_stimulus_pickup(datum/source, mob/user)
	SIGNAL_HANDLER
	input_stimulus(source, STIMULUS_PICKED_UP, user)

/obj/item/persona_core/proc/input_stimulus_impact(datum/source, atom/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	if(ismob(throwingdatum?.thrower))
		input_stimulus(source, STIMULUS_IMPACT_THROWN, throwingdatum.thrower, list(SPEAK_LINE_EXTRA_1 = hit_atom))
	else
		input_stimulus(source, STIMULUS_IMPACT_GENERIC, hit_atom)

// /obj/item/persona_core/proc/input_stimulus_microwave(datum/source, obj/machinery/microwave/M)
// 	SIGNAL_HANDLER
// 	input_stimulus(source, STIMULUS_MICROWAVED, null, list(SPEAK_LINE_EXTRA_1 = M))

/obj/item/persona_core/proc/register_master(datum/source, atom/newmaster, mob/user)
	SIGNAL_HANDLER
	if(!SEND_SIGNAL(newmaster, COMSIG_BB_PC_TO_HOST_CAN_INSERT)) // thing isnt compatible
		return
	unregister_signals()
	host = WEAKREF(newmaster)
	register_signals()
	SEND_SIGNAL(newmaster, COMSIG_BB_PC_TO_HOST_INSERTED, src)
	lockdown()

/obj/item/persona_core/proc/unregister_master()
	SIGNAL_HANDLER
	var/atom/movable/master = host?.resolve()
	SEND_SIGNAL(master, COMSIG_BB_PC_TO_HOST_REMOVED, src)
	unregister_signals()
	host = null
	register_signals()
	unlockdown()

/obj/item/persona_core/proc/lockdown()
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/persona_core/proc/unlockdown()
	interaction_flags_item = initial(interaction_flags_item)
	REMOVE_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/persona_core/proc/verify_host()
	if(!host)
		return
	var/atom/movable/master = host.resolve()
	if(recursive_loc_search(src, master, 5)) // if we're in the master, buried somewhere
		return TRUE

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

/// Some things work better/worse if the brain likes them
/obj/item/persona_core/proc/get_host_modifier(datum/source, mob/user)
	SIGNAL_HANDLER
	return brain.get_host_modifier(user)

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * OUTPUTS - How the brain interacts with the world  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

/// Takes in a message index, and outputs the message associated with it.
/// Takes into account the user's personality and amorousness.
/// Yes I know its been bouncing this shit around like 6-7 times
/obj/item/persona_core/proc/output_say(key, mob/user, list/extras, force_amour, direct, unimportant)
	MASTER_HOLDER
	if(!can_speak)
		return
	var/message_out
	if(direct)
		message_out = key
	else
		message_out = brain.key2words(key, user, extras, force_amour)
	if(master)
		master.say(message_out, null, null, null, null, null, unimportant)
	else
		say(message_out, null, null, null, null, null, unimportant)
	var/saysound = brain.get_say_sound(user)
	playsound(get_turf(src), saysound, 70, TRUE)

/// Called when the blenderbrain wants to emote.
/obj/item/persona_core/proc/output_audible_message(key, mob/user, list/extras, force_amour, direct)
	MASTER_HOLDER
	if(!can_speak)
		return
	var/list/msg_n_snd = list()
	if(direct)
		msg_n_snd = list(key, "null")
	else
		msg_n_snd = brain.key2words(key, user, extras, force_amour)
	if(LAZYLEN(msg_n_snd) != 2)
		return // all emotes must have two entries (for now)
	var/text_out = LAZYACCESS(msg_n_snd, 1)
	var/sound_out = LAZYACCESS(msg_n_snd, 2)
	if(text_out)
		if(master)
			master.audible_message(LAZYACCESS(msg_n_snd, 1))
		else
			audible_message(LAZYACCESS(msg_n_snd, 1))
	if(sound_out)
		playsound(get_turf(src), sound_out, 70, TRUE)

/// outputs a signal to the host, if possible
/obj/item/persona_core/proc/output_signal(mob/user, list/signals)
	MASTER_HOLDER_RETURN
	. = SEND_SIGNAL(master, COMSIG_BB_PC_TO_HOST_IMPULSE, signals, user)
	return 

/// outputs a signal to the host, if possible
/obj/item/persona_core/proc/output_request(request)
	MASTER_HOLDER_RETURN
	. = SEND_SIGNAL(master, COMSIG_BB_PC_TO_HOST_REQUEST, request)
	return

/// clear the impulses!
/obj/item/persona_core/proc/clear_impulses()
	if(LAZYLEN(impulses_to_process))
		QDEL_LIST(impulses_to_process)

/// Called when the blenderbrain wants to do something.
/obj/item/persona_core/proc/queue_impulse(mob/user, list/impulses, list/extras, forced = FALSE)
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
	busy_for = setting

/obj/item/persona_core/process()
	INVOKE_ASYNC(src,PROC_REF(process_impulses))

/obj/item/persona_core/proc/process_impulses()
	busy_for = max(busy_for - 1, 0)
	if(!LAZYLEN(impulses_to_process))
		brain.update_amour() // update amour every tick we arent currently doing something
		return
	for(var/impulse in impulses_to_process)
		if(!istype(impulse, /datum/blenderbrain_impulse))
			impulses_to_process -= impulse
			CRASH("Blenderbrain [src] tried to process an invalid impulse: [impulse]")
		var/datum/blenderbrain_impulse/thimpulse = impulse
		var/do_next = thimpulse.immediate_next
		INVOKE_ASYNC(thimpulse, TYPE_PROC_REF(/datum/blenderbrain_impulse,run_it))
		if(do_next)
			continue
		break

// And the core to brain procs for shit like getting the owner or whatever

/obj/item/persona_core/proc/is_owner(mob/target)
	return brain.check_relationship(target, BB_MF_IS_OWNER)

/obj/item/persona_core/proc/was_owner(mob/target)
	return brain.check_relationship(target, BB_MF_WAS_OWNER)

/obj/item/persona_core/proc/ownerize(mob/target)
	return brain.ownerize(target)

/obj/item/persona_core/proc/disown(mob/target, remember)
	return brain.disown(target, remember)

/obj/item/persona_core/proc/has_owner()
	return brain.has_owner()

/obj/item/persona_core/proc/has_met_person(mob/target)
	return brain.has_met_person(target)

/obj/item/persona_core/proc/is_hated(mob/target)
	return brain.check_relationship(target, BB_MF_IS_HATED)

/obj/item/persona_core/proc/event_cooldown(mob/target, event, cooldown)
	return brain.event_cooldown(target, event, cooldown)

/obj/item/persona_core/proc/event_happened(mob/target, event)
	return brain.event_happened(target, event)

/obj/item/persona_core/proc/event_finished(mob/target, event)
	return brain.event_finished(target, event)

/obj/item/persona_core/proc/unset_paying_attention(mob/target)
	return brain.unset_paying_attention(target)

/obj/item/persona_core/proc/set_paying_attention(mob/target)
	return brain.set_paying_attention(target)

/obj/item/persona_core/proc/set_can_speak(mute)
	can_speak = mute

/obj/item/persona_core/proc/is_desperate_enough(mob/user)
	return brain.is_desperate_enough(user)

/obj/item/persona_core/proc/set_desperation(mob/user)
	return brain.set_desperation(user)

/obj/item/persona_core/proc/adjust_amour(mob/user, amount, amour_flags)
	return brain.adjust_amour(user, amount, amour_flags)

/obj/item/persona_core/proc/get_amour(mob/user)
	return brain.get_amour(user)

/obj/item/persona_core/proc/set_clarify(mob/user, clarification)
	return brain.set_clarify(user, clarification)

/obj/item/persona_core/proc/wipe_memory()
	return brain.wipe_memory()

/obj/item/persona_core/proc/check_social_flags(flagz)
	return brain.check_social_flags(flagz)

/obj/item/persona_core/proc/get_host()
	var/atom/movable/master = host?.resolve()
	if(master && verify_host())
		return master
	return src

/obj/item/persona_core/charger
	name = "strange circuitboard"
	desc = "Yup, that's a circuitboard alright. Look at all those wires."
	icon = 'icons/obj/module.dmi'
	icon_state = "cpuboard"
	w_class = WEIGHT_CLASS_TINY






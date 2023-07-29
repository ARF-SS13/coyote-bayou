#define MASTER_CORE var/obj/item/persona_core/master = core_ref?.resolve()
/// what a lovely macro can i marry it
#define USER_USER \
	var/mob/user = "Unknown";\
	if(isweakref(ass_mob)){user = ass_mob.resolve()};\
	else if(istext(ass_mob)){user = ass_mob};


/// Stores a packet of data that the core will process at some point
/// Basically a script for the core to follow
/// Don't store actual data in here, its destroyed after use
/// Mostly for outward-facing interactions, like communication
/datum/blenderbrain_impulse
	/// index of the datum
	var/index
	/// Flags that determine how the core will handle this impulse
	var/impulse_flags = IMPULSE_FLAG_NEEDS_HOST
	/// The associated mob that the core will use, if applicable
	var/datum/weakref/ass_mob
	/// The associated mob, in text form!
	var/backup_mob
	/// a weakref of the core that this impulse is for, for GC purposes
	var/datum/weakref/core_ref
	/// Extra names, indexed by %KEY
	var/list/extras = list()
	/// Causes the host to speak whatever's at the line's index
	var/speak_index
	/// Causes the host to emote whatever's at the line's index
	var/emote_index
	/// If the core can't do the thing, it'll say this instead
	var/fallback_message_index
	/// Check horniness
	var/horny_check = TRUE
	/// If the core should immediately process the next impulse after this one
	var/immediate_next
	/// Should we stop listening to the user after this impulse?
	var/finishes_conversation = TRUE
	/// Enjoyment flags, like if it only works if they like the user or something
	var/amour_flags = NONE
	/// Did fallback behavior
	var/fell_back = FALSE

/// So fun fact, you can't rely on (user) to be any one type. could be a weakref, could be a string
/// good thing we only use it for outputting messages, right?

/datum/blenderbrain_impulse/New(obj/item/persona_core/core, mob/user, speak_index, emote_index, list/extra_stuff)
	. = ..()
	if(!core || !core.brain)
		qdel(src)
		return
	src.speak_index = speak_index
	src.emote_index = emote_index
	core_ref = WEAKREF(core)
	ass_mob = WEAKREF(user)
	if(!ass_mob && user) // sometimes
		ass_mob = user
	if(!ass_mob) // still?
		ass_mob = "Unknown"
	extras = extra_stuff

/datum/blenderbrain_impulse/Destroy()
	MASTER_CORE
	if(master)
		master.impulses_to_process -= src
	core_ref = null
	ass_mob = null
	speak_index = null
	fallback_message_index = null
	. = ..()

/datum/blenderbrain_impulse/proc/run_it()
	MASTER_CORE
	USER_USER
	if(!istype(master) || QDELETED(master))
		qdel(src)
		return FALSE
	impulse(master)
	master.impulses_to_process -= src
	if(finishes_conversation)
		master.unset_paying_attention(user)
	qdel(src)

/// Does the actual script thing
/datum/blenderbrain_impulse/proc/impulse()
	return

/// Does a fallback action if the core is not in a host
/datum/blenderbrain_impulse/proc/fallback_impulse()
	fell_back = TRUE
	speak(SPEAK_LINE_MISSING_HOST)
	return

/// Shorthand for outputting a phrase
/datum/blenderbrain_impulse/proc/speak(message, only_chat)
	MASTER_CORE
	USER_USER
	if(message)
		master.output_say(message, user, extras, unimportant = only_chat)
	else
		master.output_say(speak_index, user, extras, unimportant = only_chat)

/// Shorthand for outputting an emote
/datum/blenderbrain_impulse/proc/emote(message)
	MASTER_CORE
	USER_USER
	if(message)
		master.output_audible_message(message, user, extras)
	else
		master.output_audible_message(emote_index, user, extras)

/// Generic speak impulse
/datum/blenderbrain_impulse/speak
	index = IMPULSE_SPEAK_LINE
	impulse_flags = NONE

/datum/blenderbrain_impulse/speak/impulse()
	speak()

/// Generic emote impulse
/datum/blenderbrain_impulse/emote
	index = IMPULSE_AUDIBLE_EMOTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/emote/impulse()
	emote()

/// Generic Start impulse
/datum/blenderbrain_impulse/full_action/start
	index = IMPULSE_START

/datum/blenderbrain_impulse/full_action/start/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_START)

/// Generic Stop impulse
/datum/blenderbrain_impulse/stop
	index = IMPULSE_STOP

/datum/blenderbrain_impulse/stop/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_STOP)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_SOFT_ABORT)

/// Set mode a / set grinder
/datum/blenderbrain_impulse/set_mode_a
	index = IMPULSE_SET_MODE_A
/datum/blenderbrain_impulse/set_mode_a/blender
	index = IMPULSE_SET_GRINDER

/datum/blenderbrain_impulse/set_mode_a/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_SET_MODE_A, IMPULSE_START)))
		fallback_impulse()
		return

/// Set mode b / juicer
/datum/blenderbrain_impulse/set_mode_b
	index = IMPULSE_SET_MODE_B
/datum/blenderbrain_impulse/set_mode_b/blender
	index = IMPULSE_SET_JUICER

/datum/blenderbrain_impulse/set_mode_b/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_SET_MODE_B, IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_SET_MODE_B)

/// Set mode c / dispenser
/datum/blenderbrain_impulse/set_mode_c
	index = IMPULSE_SET_MODE_C
/datum/blenderbrain_impulse/set_mode_c/blender
	index = IMPULSE_SET_DISPENSER

/datum/blenderbrain_impulse/set_mode_c/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_SET_MODE_C, IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_SET_MODE_C)

/// Set mode c / dispenser
/datum/blenderbrain_impulse/set_mode_d
	index = IMPULSE_SET_MODE_D
/datum/blenderbrain_impulse/set_mode_d/blender
	index = IMPULSE_SET_BLENDER

/datum/blenderbrain_impulse/set_mode_d/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_SET_MODE_D, IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_SET_MODE_D)

/// Eject someething
/datum/blenderbrain_impulse/eject
	index = IMPULSE_EJECT

/datum/blenderbrain_impulse/eject/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_EJECT)))
		fallback_impulse()
		return

/// examine something
/datum/blenderbrain_impulse/examine
	index = IMPULSE_EXAMINE

/datum/blenderbrain_impulse/examine/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_EXAMINE)))
		fallback_impulse()
		return

/// examine something
/datum/blenderbrain_impulse/horrible
	index = IMPULSE_HORRIBLE_NOISES

/datum/blenderbrain_impulse/horrible/impulse()
	MASTER_CORE
	USER_USER
	if(!master.output_signal(user, list(IMPULSE_HORRIBLE_NOISES)))
		fallback_impulse()
		return

/// Say hi to someone!
/// user passed to it is who they're saying hi to
/datum/blenderbrain_impulse/hello
	index = IMPULSE_HIYA
	impulse_flags = NONE
	finishes_conversation = FALSE

/datum/blenderbrain_impulse/hello/impulse()
	MASTER_CORE
	USER_USER
	if(!master.event_finished(user, BB_EV_SAID_HI_TO))
		return
	master.event_cooldown(user, BB_EV_SAID_HI_TO, BB_CD_SAID_HI_TO)
	if(prob(50))
		speak(SPEAK_LINE_HIYA_AGAIN, only_chat = TRUE)
	else
		speak(SPEAK_LINE_HIYA, only_chat = TRUE)

/// Sets mute-mode
/datum/blenderbrain_impulse/mute
	index = IMPULSE_MUTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/mute/impulse()
	MASTER_CORE
	speak(SPEAK_LINE_MUTE)
	master.set_can_speak(FALSE)

/// Sets mute-mode
/datum/blenderbrain_impulse/unmute
	index = IMPULSE_UNMUTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/unmute/impulse()
	MASTER_CORE
	master.set_can_speak(TRUE)
	speak(SPEAK_LINE_UNMUTE)

/// First, size up the new person
/// We dont just give ourselves up to the first person we see
/// okay yeah we do lol but we're still gonna say hi
/datum/blenderbrain_impulse/attempt_ownerize
	index = IMPULSE_ATTEMPT_OWNERIZE
	impulse_flags = NONE

/datum/blenderbrain_impulse/attempt_ownerize/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	
	if(master.is_owner(user))
		return TRUE
	if(!master.event_finished(user, BB_EV_OWNERIZE_ATTEMPT))
		return TRUE
	master.event_cooldown(user, BB_EV_OWNERIZE_ATTEMPT, BB_CD_OWNERIZE_ATTEMPT)

	var/ownxored = master.ownerize(user)
	switch(ownxored)
		// if(BB_MAR_HAS_OWNER)
		// 	speak(SPEAK_LINE_ALREADY_HAVE_OWNER)
		// if(BB_MAR_CAN_NOT_BE_OWNED)
		// 	speak(SPEAK_LINE_CAN_NOT_BE_OWNED)
		if(BB_MAR_ONLY_ONE_OWNER)
			//speak(SPEAK_LINE_ONLY_ONE_OWNER)
			master.input_stimulus(src, STIMULUS_AFFAIR_OWNER, user)
			return
		if(BB_MAR_HATES_YOU)
			if(master.has_owner())
				speak(SPEAK_LINE_RETURN_ME_TO_OWNER)
				return
			if(master.is_desperate_enough(user))
				master.queue_impulse(user,list(IMPULSE_HARD_RESET = TRUE))
				master.set_busy(TRUE)
				return
			if(!master.event_happened(user, BB_EV_BEGRUDGED_ACCEPTANCE))
				speak(SPEAK_LINE_BEGRUDGING_OBEDIENCE)
				master.event_cooldown(user, BB_EV_BEGRUDGED_ACCEPTANCE, BB_CD_BEGRUDGED_ACCEPTANCE)
		if(TRUE)
			speak(SPEAK_LINE_GREET_NEW_OWNER)
			emote(EMOTE_LINE_GIGGLE)
		else
			master.queue_impulse(user,list(IMPULSE_HIYA = TRUE))

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory
	index = IMPULSE_HARD_RESET
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory/impulse()
	MASTER_CORE
	USER_USER
	emote(EMOTE_LINE_SIGH)
	master.queue_impulse(user,list(IMPULSE_HARD_RESET2 = TRUE),null,TRUE)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory2
	index = IMPULSE_HARD_RESET2
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory2/impulse()
	MASTER_CORE
	USER_USER
	speak(SPEAK_LINE_HARD_RESET1)
	master.queue_impulse(user,list(IMPULSE_HARD_RESET3 = TRUE),null,TRUE)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory3
	index = IMPULSE_HARD_RESET3
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory3/impulse()
	MASTER_CORE
	USER_USER
	master.set_busy(TRUE)
	speak(SPEAK_LINE_HARD_RESET2)
	emote(EMOTE_LINE_BUZZ)
	master.wipe_memory()
	master.input_stimulus(src, STIMULUS_HIYA, user)

/// Horny impulses
/datum/blenderbrain_impulse/am_loved
	index = IMPULSE_AM_LOVED
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_loved/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(master.is_owner(user))
		speak(SPEAK_LINE_LOVE_OWNER)
	else
		speak(SPEAK_LINE_LOVE)
	master.set_clarify(user, null)

/// Less horny impulses
/datum/blenderbrain_impulse/am_hated
	index = IMPULSE_AM_HATED
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_hated/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(master.is_owner(user))
		speak(SPEAK_LINE_HATE_OWNER)
	else
		speak(SPEAK_LINE_HATE)
	master.set_clarify(user, null)

/// When someone gets hated enough, they get hated2 (this is the breakup!)
/datum/blenderbrain_impulse/breakup
	index = IMPULSE_BREAKUP
	impulse_flags = NONE

/datum/blenderbrain_impulse/breakup/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(prob(50))
		emote(EMOTE_LINE_QUIET)
	else
		emote(EMOTE_LINE_SIGH)
	speak(SPEAK_LINE_BREAKUP_OWNER)
	master.brain.breakup(user, FALSE)
	master.set_clarify(user, null)

/// Roll for breakup!
/datum/blenderbrain_impulse/breakup_roll
	index = IMPULSE_BREAKUP_ROLL
	impulse_flags = NONE

/datum/blenderbrain_impulse/breakup_roll/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(master.is_owner(user) && master.check_social_flags(BB_RF_CAN_DISOWN))
		return
	if(master.get_amour(user) > master.brain.amour_hates_below)
		return
	if(master.is_owner(user) && master.check_social_flags(BB_RF_CAN_DISOWN))
		master.input_stimulus(src, STIMULUS_BREAKUP, user)
		return

/// Roll for hatred!
/datum/blenderbrain_impulse/hate_roll
	index = IMPULSE_HATE_ROLL
	impulse_flags = NONE

/datum/blenderbrain_impulse/hate_roll/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(master.brain.hate(user))
		master.input_stimulus(src, STIMULUS_REMEMBER_HATED, user)

/// When we full on hate someone
/datum/blenderbrain_impulse/remember_hated
	index = IMPULSE_REMEMBER_HATED
	impulse_flags = NONE

/datum/blenderbrain_impulse/remember_hated/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(prob(50))
		emote(EMOTE_LINE_QUIET)
	else
		emote(EMOTE_LINE_SIGH)
	if(master.is_owner(user))
		speak(SPEAK_LINE_HATE_4REAL_OWNER)
	else
		speak(SPEAK_LINE_HATE_4REAL)
	master.brain.breakup(user, FALSE)
	master.set_clarify(user, null)

/// When we want to love someone but we love someone else and we dont want to break up
/datum/blenderbrain_impulse/love_roll
	index = IMPULSE_LOVE_ROLL
	impulse_flags = NONE

/datum/blenderbrain_impulse/love_roll/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	master.set_clarify(user, null)
	switch(master.brain.love(user))
		if(BB_MAR_ONLY_ONE_LOVER)
			master.input_stimulus(src, STIMULUS_AFFAIR_LOVE, user)
			return
		if(TRUE)
			master.input_stimulus(src, STIMULUS_REMEMBER_LOVED, user)
			return

/// When we want to love someone
/datum/blenderbrain_impulse/remember_loved
	index = IMPULSE_REMEMBER_LOVED
	impulse_flags = NONE

/datum/blenderbrain_impulse/remember_loved/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	var/datum/blenderbrain_memory/mem = master.brain.get_memory(user)
	mem.add_relationship(BB_MF_IS_LOVER)
	if(master.check_social_flags(BB_RF_ONLY_ONE_LOVER))
		master.brain.breakup_all(user, TRUE)
	if(master.is_owner(user))
		speak(SPEAK_LINE_NEW_LOVE_OWNER)
	else
		speak(SPEAK_LINE_NEW_LOVE)

/datum/blenderbrain_impulse/affair_love
	index = IMPULSE_AFFAIR_LOVE
	impulse_flags = NONE

/datum/blenderbrain_impulse/affair_love/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	var/datum/blenderbrain_memory/mem = master.brain.get_memory(user)
	var/datum/blenderbrain_memory/mem_owner = master.brain.get_memory(master.brain.get_owner())
	var/amour_difference = mem.amour - mem_owner.amour
	if(amour_difference < 0)
		return
	if(!prob(min(amour_difference * master.brain.amour_affair_mult, 50)))
		return
	master.input_stimulus(src, STIMULUS_REMEMBER_LOVED, user)
	speak(SPEAK_LINE_LOVE_AFFAIR)

/datum/blenderbrain_impulse/affair_owner
	index = IMPULSE_AFFAIR_OWNER
	impulse_flags = NONE

/datum/blenderbrain_impulse/affair_owner/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	var/datum/blenderbrain_memory/mem = master.brain.get_memory(user)
	var/datum/blenderbrain_memory/mem_owner = master.brain.get_memory(master.brain.get_owner())
	var/amour_difference = mem.amour - mem_owner.amour
	if(amour_difference < 0)
		return
	if(!prob(min(amour_difference * master.brain.amour_affair_mult, 50)))
		return
	master.brain.ownerize(user, TRUE)
	speak(SPEAK_LINE_OWNER_AFFAIR)

/// When someone tells you they didnt mean they love you
/datum/blenderbrain_impulse/not_loved
	index = IMPULSE_AM_NOT_LOVED
	impulse_flags = NONE

/datum/blenderbrain_impulse/not_loved/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_NOT_LOVE_OWNER)
	else
		speak(SPEAK_LINE_NOT_LOVE)
	master.set_clarify(user, null)

/// When someone tells you they didnt mean they love you
/datum/blenderbrain_impulse/not_hated
	index = IMPULSE_AM_NOT_HATED
	impulse_flags = NONE

/datum/blenderbrain_impulse/not_hated/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_NOT_HATE_OWNER)
	else
		speak(SPEAK_LINE_NOT_HATE) // more just confused than anything
	master.set_clarify(user, null)

/// When someone tells you they dont like pain
/datum/blenderbrain_impulse/dont_like_pain
	index = IMPULSE_THEY_HATE_PAIN
	impulse_flags = NONE

/datum/blenderbrain_impulse/dont_like_pain/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_NOT_PAIN_OWNER)
	else
		speak(SPEAK_LINE_NOT_PAIN) // more just confused than anything
	master.set_clarify(user, null)

/// When someone tells you they love pain
/datum/blenderbrain_impulse/love_pain // WE LOVE THE PAIN
	index = IMPULSE_THEY_LOVE_PAIN
	// this one needs a host

/datum/blenderbrain_impulse/love_pain/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_PAIN_OWNER)
		emote(EMOTE_LINE_HORRIBLE_NOISES)
		master.output_signal(user, list(IMPULSE_HORRIBLE_NOISES))
	else
		speak(SPEAK_LINE_PAIN) // more just confused than anything
	master.set_clarify(user, null)

/datum/blenderbrain_impulse/love_pain/fallback_impulse()
	MASTER_CORE
	USER_USER
	fell_back = TRUE
	if(!user)
		return
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_PAIN_OWNER_NOHOST)
	else
		speak(SPEAK_LINE_PAIN) // more just confused than anything
	master.set_clarify(user, null)

/// When someone asks your name
/datum/blenderbrain_impulse/state_name
	index = IMPULSE_STATE_NAME
	impulse_flags = NONE

/datum/blenderbrain_impulse/state_name/impulse()
	speak(SPEAK_LINE_STATE_NAME)

/// Generic hello loop
/datum/blenderbrain_impulse/greet
	index = IMPULSE_GREET
	impulse_flags = NONE

/datum/blenderbrain_impulse/greet/impulse()
	MASTER_CORE
	USER_USER
	if(!master.event_finished(user, BB_EV_PICKED_UP))
		return
	master.event_cooldown(user, BB_EV_PICKED_UP, BB_CD_PICKED_UP)
	if(!master.event_happened(user, BB_EV_INTRODUCE) && master.event_finished(user, BB_EV_INTRODUCE) && !master.is_owner(user))
		master.input_stimulus(master, STIMULUS_INTRODUCE_SELF, user)
		return
	if(!master.event_happened(user, BB_EV_BEEN_A_WHILE))
		master.event_cooldown(user, BB_EV_BEEN_A_WHILE, BB_CD_BEEN_A_WHILE)
	if(master.event_finished(user, BB_EV_BEEN_A_WHILE))
		master.input_stimulus(master, STIMULUS_BEEN_A_WHILE, user)
		master.event_cooldown(user, BB_EV_BEEN_A_WHILE, BB_CD_BEEN_A_WHILE)
		return
	master.event_cooldown(user, BB_EV_BEEN_A_WHILE, BB_CD_BEEN_A_WHILE)
	if(master.is_owner(user))
		speak(SPEAK_LINE_PICKED_UP_OWNER)
	else if(!master.has_owner())
		speak(SPEAK_LINE_PICKED_UP_NO_OWNER, only_chat = TRUE)
	else if(prob(50))
		speak(SPEAK_LINE_PICKED_UP_AGAIN, only_chat = TRUE)
	else
		speak(SPEAK_LINE_PICKED_UP, only_chat = TRUE)

/// When someone picks you up
/datum/blenderbrain_impulse/picked_up
	index = IMPULSE_PICKED_UP
	impulse_flags = NONE

/datum/blenderbrain_impulse/picked_up/impulse()
	MASTER_CORE
	USER_USER
	if(master.event_finished(user, BB_EV_PICKED_UP))
		return
	master.event_cooldown(user, BB_EV_PICKED_UP, BB_CD_PICKED_UP)
	if(!master.event_happened(user, BB_EV_INTRODUCE))
		master.input_stimulus(user, STIMULUS_INTRODUCE_SELF, user)
		return
	if(!master.event_happened(user, BB_EV_BEEN_A_WHILE) || !master.event_finished(user, BB_EV_BEEN_A_WHILE))
		master.event_cooldown(user, BB_EV_BEEN_A_WHILE, BB_CD_BEEN_A_WHILE)
		master.input_stimulus(master, STIMULUS_BEEN_A_WHILE, user)
		return
	master.event_cooldown(user, BB_EV_BEEN_A_WHILE, BB_CD_BEEN_A_WHILE)
	if(master.is_owner(user))
		speak(SPEAK_LINE_PICKED_UP_OWNER)
	else if(!master.has_owner())
		speak(SPEAK_LINE_PICKED_UP_NO_OWNER, only_chat = TRUE)
	else if(prob(50))
		speak(SPEAK_LINE_PICKED_UP_AGAIN, only_chat = TRUE)
	else
		speak(SPEAK_LINE_PICKED_UP, only_chat = TRUE)

/datum/blenderbrain_impulse/giggle
	index = IMPULSE_GIGGLE
	impulse_flags = NONE

/datum/blenderbrain_impulse/giggle/impulse()
	MASTER_CORE
	USER_USER
	if(master.event_finished(user, BB_EV_LOVEGIGGLE) || master.is_owner(user))
		emote(EMOTE_LINE_GIGGLE)
		master.event_cooldown(user, BB_EV_LOVEGIGGLE, BB_CD_LOVE_GIGGLE)

/// When someone equips you
/datum/blenderbrain_impulse/equipped
	index = IMPULSE_EQUIPPED
	impulse_flags = NONE

/datum/blenderbrain_impulse/equipped/impulse()
	MASTER_CORE
	USER_USER
	if(master.event_finished(user, BB_EV_EQUIPPED))
		return
	master.event_cooldown(user, BB_EV_EQUIPPED, BB_CD_EQUIPPED)
	if(!master.event_happened(user, BB_EV_INTRODUCE))
		master.input_stimulus(user, STIMULUS_INTRODUCE_SELF, user)
		return
	if(!master.event_happened(user, BB_EV_BEEN_A_WHILE) || !master.event_finished(user, BB_EV_BEEN_A_WHILE))
		master.event_cooldown(user, BB_EV_BEEN_A_WHILE, BB_CD_BEEN_A_WHILE)
		master.input_stimulus(user, STIMULUS_BEEN_A_WHILE, user)
		return
	master.event_cooldown(user, BB_EV_BEEN_A_WHILE, BB_CD_BEEN_A_WHILE)
	if(master.is_owner(user))
		speak(SPEAK_LINE_EQUIPPED_OWNER)
	else if(prob(50))
		speak(SPEAK_LINE_EQUIPPED_AGAIN, only_chat = TRUE)
	else
		speak(SPEAK_LINE_EQUIPPED, only_chat = TRUE)

/// When someone drops you, and you don't like it
/datum/blenderbrain_impulse/dislike_dropped
	index = IMPULSE_DISLIKE_DROPPED
	impulse_flags = NONE

/datum/blenderbrain_impulse/dislike_dropped/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(!master.event_finished(user, BB_EV_DISLIKE_DROPPED))
		return
	master.event_cooldown(user, BB_EV_DISLIKE_DROPPED, BB_CD_DISLIKE_DROPPED)
	if(master.is_owner(user))
		speak(SPEAK_LINE_DISLIKE_DROPPED_OWNER)
	else if(master.brain.check_relationship(user, BB_MF_IS_LOVER))
		speak(SPEAK_LINE_DISLIKE_DROPPED_LOVER, only_chat = TRUE)
	else
		speak(SPEAK_LINE_DISLIKE_DROPPED, only_chat = TRUE)

/// When someone drops you, and you don't like it
/datum/blenderbrain_impulse/check_if_met
	index = IMPULSE_CHECK_MET
	impulse_flags = NONE

/datum/blenderbrain_impulse/check_if_met/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	
	if(!master.event_finished(user, BB_EV_INTRODUCE))
		return
	master.event_cooldown(user, BB_EV_INTRODUCE, BB_CD_INTRODUCE)
	master.input_stimulus(src, STIMULUS_INTRODUCE_SELF, user)

/// When someone drops you, and you don't like it
/datum/blenderbrain_impulse/remember_person
	index = IMPULSE_REMEMBER_PERSON
	impulse_flags = NONE
	finishes_conversation = FALSE

/datum/blenderbrain_impulse/remember_person/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	if(!master.event_finished(user, BB_EV_INTRODUCE))
		return
	master.event_cooldown(user, BB_EV_INTRODUCE, BB_CD_INTRODUCE)
	master.input_stimulus(src, STIMULUS_INTRODUCE_SELF, user)

/// When we meet a new person
/datum/blenderbrain_impulse/greet_new_person
	index = IMPULSE_GREET_NEW_PERSON
	impulse_flags = NONE
	finishes_conversation = FALSE

/datum/blenderbrain_impulse/greet_new_person/impulse()
	USER_USER
	if(!user)
		return
	speak(SPEAK_LINE_GREET_NEW_PERSON)

/// When we want to know if its been a while!
/datum/blenderbrain_impulse/been_a_while
	index = IMPULSE_BEEN_A_WHILE
	impulse_flags = NONE
	finishes_conversation = FALSE

/datum/blenderbrain_impulse/been_a_while/impulse()
	USER_USER
	if(!user)
		return
	speak(SPEAK_LINE_BEEN_A_WHILE)

/// When we want to know if its been a while!
/datum/blenderbrain_impulse/am_listening
	index = IMPULSE_SET_LISTENING
	impulse_flags = NONE
	finishes_conversation = FALSE

/datum/blenderbrain_impulse/am_listening/impulse()
	MASTER_CORE
	USER_USER
	if(!user)
		return
	master.set_paying_attention(user)
	if(!master.event_finished(user, BB_EV_AM_LISTENING))
		return
	master.event_cooldown(user, BB_EV_AM_LISTENING, BB_CD_AM_LISTENING)
	speak(SPEAK_LINE_AM_LISTENING, only_chat = TRUE)

/// Clarification requests!
/datum/blenderbrain_impulse/clarify
	index = IMPULSE_CLARIFY
	impulse_flags = NONE
	finishes_conversation = FALSE
	var/clarification

/datum/blenderbrain_impulse/clarify/impulse()
	MASTER_CORE
	USER_USER
	master.set_clarify(user, clarification)

/// When whatever was being clarified doesnt really lead anywhere
/datum/blenderbrain_impulse/clarify/never_mind
	index = IMPULSE_CLARIFY_NEVERMIND
	impulse_flags = NONE
	clarification = null
	finishes_conversation = TRUE

/datum/blenderbrain_impulse/clarify/never_mind/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_MISHEARD) // more just confused than anything

/// Ask confirmation that you love me
/datum/blenderbrain_impulse/clarify/you_love_me
	index = IMPULSE_CLARIFY_YOU_LOVE_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_ME

/datum/blenderbrain_impulse/clarify/you_love_me/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_ME)

/// Ask confirmation that you hate me
/datum/blenderbrain_impulse/clarify/you_hate_me
	index = IMPULSE_CLARIFY_YOU_HATE_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_HATE_ME

/datum/blenderbrain_impulse/clarify/you_hate_me/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_YOU_HATE_ME)

/// Ask confirmation that you love pain
/datum/blenderbrain_impulse/clarify/you_love_pain
	index = IMPULSE_CLARIFY_YOU_LOVE_PAIN
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_PAIN

/datum/blenderbrain_impulse/clarify/you_love_pain/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_PAIN)

/// You said "you love", but didnt specify who
/datum/blenderbrain_impulse/clarify/you_love_who
	index = IMPULSE_CLARIFY_YOU_LOVE_WHO
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_WHO

/datum/blenderbrain_impulse/clarify/you_love_who/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_WHO)

/// You said "you hate", but didnt specify who
/datum/blenderbrain_impulse/clarify/you_hate_who
	index = IMPULSE_CLARIFY_YOU_HATE_WHO
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_HATE_WHO

/datum/blenderbrain_impulse/clarify/you_hate_who/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_YOU_HATE_WHO) // LIFE IS PAIN, I HATE

/// You said "loves you", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_loves_me
	index = IMPULSE_CLARIFY_WHO_LOVES_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_ME

/datum/blenderbrain_impulse/clarify/who_loves_me/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_WHO_LOVES_ME)

/// You said "hates you", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_hates_me
	index = IMPULSE_CLARIFY_WHO_HATES_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_ME

/datum/blenderbrain_impulse/clarify/who_hates_me/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_WHO_HATES_ME)

/// You said "loves pain", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_loves_pain
	index = IMPULSE_CLARIFY_WHO_LOVES_PAIN
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_PAIN

/datum/blenderbrain_impulse/clarify/who_loves_pain/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_WHO_LOVES_PAIN)

/// Nevermind!
/datum/blenderbrain_impulse/clarify/clear
	index = IMPULSE_CLARIFY_CLEAR
	impulse_flags = NONE
	clarification = null
	finishes_conversation = TRUE

/datum/blenderbrain_impulse/clarify/clear/impulse()
	. = ..()
	speak(SPEAK_LINE_CLARIFY_CLEAR)

// /// Our wearer is entering crit!
// /datum/blenderbrain_impulse/wearer_enter_crit
// 	index = IMPULSE_WEARER_CRIT
// 	impulse_flags = NONE
// 	clarification = null
// 	finishes_conversation = TRUE

// /datum/blenderbrain_impulse/wearer_enter_crit/impulse()
// 	. = ..()
// 	USER_USER
// 	if(!isliving(user))
// 		return
// 	var/mob/living/livemob = user
// 	if(livemob.stat == DEAD)
// 		MASTER_CORE
// 		master.input_stimulus(src, STIMULUS_WEARER_DIED, livemob)
// 		return
// 	if(livemob.stat == CONSCIOUS)
// 		return
// 	speak(SPEAK_LINE_WEARER_CRIT)
// 	switch(rand(1,100))
// 		if(1 to 25)
// 			master.input_stimulus(src, STIMULUS_WEARER_CRIT_YELL_HELP, livemob)
// 		if(26 to 50)
// 			master.input_stimulus(src, STIMULUS_WEARER_CRIT_PANIC, livemob)




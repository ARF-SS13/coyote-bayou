#define USER_MASTER_BRAIN \
	var/mob/user = ass_mob?.resolve();\
	var/obj/item/persona_core/master = core_ref?.resolve();\

/// Stores a packet of data that the core will process at some point
/// Basically a script for the core to follow
/// Don't store actual data in here, its destroyed after use
/datum/blenderbrain_impulse
	/// index of the datum
	var/index
	/// Flags that determine how the core will handle this impulse
	var/impulse_flags = IMPULSE_FLAG_NEEDS_HOST
	/// The associated mob that the core will use, if applicable
	var/datum/weakref/ass_mob
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

/datum/blenderbrain_impulse/New(obj/item/persona_core/core, mob/user, list/extra_stuff)
	. = ..()
	if(!core || !core.brain)
		qdel(src)
		return
	core_ref = WEAKREF(core)
	ass_mob = WEAKREF(user)
	extras = extra_stuff

/datum/blenderbrain_impulse/Destroy()
	USER_MASTER_BRAIN
	master.impulses_to_process -= src
	core_ref = null
	ass_mob = null
	speak_index = null
	fallback_message_index = null
	. = ..()

/datum/blenderbrain_impulse/proc/run_it()
	USER_MASTER_BRAIN
	if(!istype(master) || QDELETED(master))
		qdel(src)
		return FALSE
	impulse(master)
	master.impulses_to_process -= src
	qdel(src)

/// Does the actual script thing
/datum/blenderbrain_impulse/proc/impulse()
	return

/// Does a fallback action if the core is not in a host
/datum/blenderbrain_impulse/proc/fallback_impulse()
	speak(SPEAK_LINE_MISSING_HOST)
	return

/// Shorthand for outputting a phrase
/datum/blenderbrain_impulse/proc/speak(message)
	USER_MASTER_BRAIN
	if(message)
		master.output_say(message, user, extras)
	else
		master.output_say(speak_index, user, extras)

/// Shorthand for outputting an emote
/datum/blenderbrain_impulse/proc/emote(message)
	USER_MASTER_BRAIN
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
/datum/blenderbrain_impulse/start
	index = IMPULSE_START

/datum/blenderbrain_impulse/start/impulse()
	USER_MASTER_BRAIN
	if(!master.output_signal(user, list(IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_START)

/// Generic Stop impulse
/datum/blenderbrain_impulse/stop
	index = IMPULSE_STOP

/datum/blenderbrain_impulse/stop/impulse()
	USER_MASTER_BRAIN
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
	USER_MASTER_BRAIN
	if(!master.output_signal(user, list(IMPULSE_SET_MODE_A, IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_SET_MODE_A)

/// Set mode b / juicer
/datum/blenderbrain_impulse/set_mode_b
	index = IMPULSE_SET_MODE_B
/datum/blenderbrain_impulse/set_mode_b/blender
	index = IMPULSE_SET_JUICER

/datum/blenderbrain_impulse/set_mode_b/impulse()
	USER_MASTER_BRAIN
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
	USER_MASTER_BRAIN
	if(!master.output_signal(user, list(IMPULSE_SET_MODE_C, IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_SET_MODE_C)

/// Set mode c / dispenser
/datum/blenderbrain_impulse/set_mode_d
	index = IMPULSE_SET_MODE_C
/datum/blenderbrain_impulse/set_mode_d/blender
	index = IMPULSE_SET_DISPENSER

/datum/blenderbrain_impulse/set_mode_d/impulse()
	USER_MASTER_BRAIN
	if(!master.output_signal(user, list(IMPULSE_SET_MODE_C, IMPULSE_START)))
		fallback_impulse()
		return
	speak(SPEAK_LINE_SET_MODE_C)

/// Eject someething
/datum/blenderbrain_impulse/eject
	index = IMPULSE_EJECT

/datum/blenderbrain_impulse/eject/impulse()
	USER_MASTER_BRAIN
	if(!master.output_signal(user, list(IMPULSE_EJECT)))
		fallback_impulse()
		return

/// examine something
/datum/blenderbrain_impulse/examine
	index = IMPULSE_EJECT

/datum/blenderbrain_impulse/examine/impulse()
	USER_MASTER_BRAIN
	if(!master.output_signal(user, list(IMPULSE_EXAMINE)))
		fallback_impulse()
		return

/// examine something
/datum/blenderbrain_impulse/horrible
	index = IMPULSE_HORRIBLE_NOISES

/datum/blenderbrain_impulse/horrible/impulse()
	USER_MASTER_BRAIN
	if(!master.output_signal(user, list(IMPULSE_HORRIBLE_NOISES)))
		fallback_impulse()
		return

/// Say hi to someone!
/// user passed to it is who they're saying hi to
/datum/blenderbrain_impulse/hello
	index = IMPULSE_HIYA
	impulse_flags = NONE

/datum/blenderbrain_impulse/hello/impulse()
	USER_MASTER_BRAIN
	if(master.has_met_person(user))
		speak(SPEAK_LINE_HIYA_AGAIN)
	else
		speak(SPEAK_LINE_HIYA)

/// Sets mute-mode
/datum/blenderbrain_impulse/mute
	index = IMPULSE_MUTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/mute/impulse()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_MUTE)
	master.set_can_speak(FALSE)

/// Sets mute-mode
/datum/blenderbrain_impulse/unmute
	index = IMPULSE_MUTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/unmute/impulse()
	USER_MASTER_BRAIN
	master.set_can_speak(TRUE)
	speak(SPEAK_LINE_UNMUTE)

/// First, size up the new person
/// We dont just give ourselves up to the first person we see
/// okay yeah we do lol but we're still gonna say hi
/datum/blenderbrain_impulse/greet_new_owner
	index = IMPULSE_GREET_NEW_OWNER
	impulse_flags = NONE

/datum/blenderbrain_impulse/greet_new_owner/impulse()
	USER_MASTER_BRAIN
	if(!user)
		return
	if(master.is_owner(user))
		return
	if(master.has_owner())
		if(master.is_mean_person(user))
			master.queue_impulse(
				user, 
				list(
					IMPULSE_GREET_OLD_HATER = TRUE
					),
					)
			return
		master.queue_impulse(
			user, 
			list(
				IMPULSE_HIYA = TRUE
				),
				)
		return
	if(master.is_mean_person(user))
		if(master.rebound_complete())
			master.queue_impulse(
				user, 
				list(
					IMPULSE_HARD_RESET = TRUE
					),
					)
			master.set_busy(TRUE)
			return
		master.queue_impulse(
			user, 
			list(
				IMPULSE_GREET_OLD_HATER = TRUE
				),
				)
		return
	speak(SPEAK_LINE_GREET_NEW_OWNER)
	emote(EMOTE_LINE_GIGGLE)
	master.set_owner(user)

/// Oh hey its our old owner
/// Fuck that guy, unless he's the only choice for owner, then delete system32
/datum/blenderbrain_impulse/greet_old_hater
	index = IMPULSE_GREET_OLD_HATER
	impulse_flags = NONE

/datum/blenderbrain_impulse/greet_old_hater/impulse()
	USER_MASTER_BRAIN
	if(!user)
		return
	if(!master.is_mean_person(user))
		return
	if(master.has_owner())
		speak(SPEAK_LINE_RETURN_ME_TO_OWNER)
		return
	if(master.rebound_complete())
		master.queue_impulse(
			user, 
			list(
				IMPULSE_HARD_RESET = TRUE
				),
				null,
				TRUE
				)
		master.set_busy(3)
		return
	speak(SPEAK_LINE_BEGRUDGING_OBEDIENCE)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory
	index = IMPULSE_HARD_RESET
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory/impulse()
	USER_MASTER_BRAIN
	emote(EMOTE_LINE_SIGH)
	master.queue_impulse(
		user, 
		list(
			IMPULSE_HARD_RESET2 = TRUE
			),
			null,
			TRUE
			)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory2
	index = IMPULSE_HARD_RESET2
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory2/impulse()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_HARD_RESET1)
	master.queue_impulse(
		user, 
		list(
			IMPULSE_HARD_RESET3 = TRUE
			),
			null,
			TRUE
			)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory3
	index = IMPULSE_HARD_RESET3
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory3/impulse()
	USER_MASTER_BRAIN
	master.set_busy(TRUE)
	speak(SPEAK_LINE_HARD_RESET2)
	emote(EMOTE_LINE_BUZZ)
	master.wipe_memory()
	master.queue_impulse(
		user, 
		list(
			IMPULSE_GREET_NEW_OWNER = TRUE
			),
			null,
			TRUE
			)

/// Horny impulses
/datum/blenderbrain_impulse/am_loved
	index = IMPULSE_AM_LOVED
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_loved/impulse()
	USER_MASTER_BRAIN
	if(!user)
		return
	if(master.is_owner(user))
		speak(SPEAK_LINE_LOVE_OWNER)
	else
		speak(SPEAK_LINE_LOVE)
	if(master.is_mean_person(user))
		return
	master.adjust_amour(user, 10)
	master.set_clarify(user, null)

/// Horny impulses
/datum/blenderbrain_impulse/am_hated
	index = IMPULSE_AM_HATED
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_hated/impulse()
	USER_MASTER_BRAIN
	if(!user)
		return
	master.adjust_amour(user, -25)
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_HATE_OWNER)
	else
		speak(SPEAK_LINE_HATE)
	var/amour = master.get_amour(user)
	if(amour < -50)
		master.queue_impulse(
			user, 
			list(
				IMPULSE_AM_HATED2 = TRUE
				),
				)
	master.set_clarify(user, null)

/// When someone gets hated enough, they get hated2
/datum/blenderbrain_impulse/am_hated2
	index = IMPULSE_AM_HATED2
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_hated/impulse()
	USER_MASTER_BRAIN
	if(!user)
		return
	var/isowner = master.is_owner(user)
	master.add_mean_person(user)
	if(prob(50))
		emote(EMOTE_LINE_QUIET)
	else
		emote(EMOTE_LINE_SIGH)
	if(isowner)
		speak(SPEAK_LINE_BREAKUP_OWNER)
		master.disown_owner(user)
	master.set_clarify(user, null)

/// When someone tells you they didnt mean they love you
/datum/blenderbrain_impulse/not_loved
	index = IMPULSE_AM_NOT_LOVED
	impulse_flags = NONE

/datum/blenderbrain_impulse/not_loved/impulse()
	USER_MASTER_BRAIN
	if(!user)
		return
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_NOT_LOVE_OWNER)
		master.adjust_amour(user, -5) // :c
	else
		speak(SPEAK_LINE_NOT_LOVE)
		master.adjust_amour(user, -1)
	if(master.get_amour(user) < -50) // thats it, we're done
		master.queue_impulse(
			user, 
			list(
				IMPULSE_AM_HATED2 = TRUE
				),
				)
	master.set_clarify(user, null)

/// When someone tells you they didnt mean they love you
/datum/blenderbrain_impulse/not_hated
	index = IMPULSE_AM_NOT_HATED
	impulse_flags = NONE

/datum/blenderbrain_impulse/not_hated/impulse()
	USER_MASTER_BRAIN
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
	USER_MASTER_BRAIN
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
	USER_MASTER_BRAIN
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
	USER_MASTER_BRAIN
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
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_STATE_NAME)

/// Clarification requests!
/datum/blenderbrain_impulse/clarify
	index = IMPULSE_CLARIFY
	impulse_flags = NONE
	var/clarification

/datum/blenderbrain_impulse/clarify/never_mind/impulse()
	USER_MASTER_BRAIN
	master.set_clarify(user, clarification)

/// When whatever was being clarified doesnt really lead anywhere
/datum/blenderbrain_impulse/clarify/never_mind
	index = IMPULSE_CLARIFY_NEVERMIND
	impulse_flags = NONE
	clarification = null

/datum/blenderbrain_impulse/clarify/never_mind/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_MISHEARD) // more just confused than anything

/// Ask confirmation that you love me
/datum/blenderbrain_impulse/clarify/you_love_me
	index = IMPULSE_CLARIFY_YOU_LOVE_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_ME

/datum/blenderbrain_impulse/clarify/you_love_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_ME)

/// Ask confirmation that you hate me
/datum/blenderbrain_impulse/clarify/you_hate_me
	index = IMPULSE_CLARIFY_YOU_HATE_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_HATE_ME

/datum/blenderbrain_impulse/clarify/you_hate_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_HATE_ME)

/// Ask confirmation that you love pain
/datum/blenderbrain_impulse/clarify/you_love_pain
	index = IMPULSE_CLARIFY_YOU_LOVE_PAIN
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_PAIN

/datum/blenderbrain_impulse/clarify/you_love_pain/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_PAIN)

/// You said "you love", but didnt specify who
/datum/blenderbrain_impulse/clarify/you_love_who
	index = IMPULSE_CLARIFY_YOU_LOVE_WHO
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_WHO

/datum/blenderbrain_impulse/clarify/you_love_who/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_WHO)

/// You said "you hate", but didnt specify who
/datum/blenderbrain_impulse/clarify/you_hate_who
	index = IMPULSE_CLARIFY_YOU_LOVE_WHO
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_WHO

/datum/blenderbrain_impulse/clarify/you_hate_who/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_HATE_WHO) // LIFE IS PAIN, I HATE

/// You said "loves you", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_loves_me
	index = IMPULSE_CLARIFY_WHO_LOVES_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_ME

/datum/blenderbrain_impulse/clarify/who_loves_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_WHO_LOVES_ME)

/// You said "hates you", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_hates_me
	index = IMPULSE_CLARIFY_WHO_LOVES_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_ME

/datum/blenderbrain_impulse/clarify/who_hates_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_WHO_HATES_ME)

/// You said "loves pain", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_loves_pain
	index = IMPULSE_CLARIFY_WHO_LOVES_PAIN
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_PAIN

/datum/blenderbrain_impulse/clarify/who_loves_pain/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_WHO_LOVES_PAIN)

/// Nevermind!
/datum/blenderbrain_impulse/clarify/clear
	index = IMPULSE_CLARIFY_CLEAR
	impulse_flags = NONE
	clarification = null

/datum/blenderbrain_impulse/clarify/clear/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_CLEAR)




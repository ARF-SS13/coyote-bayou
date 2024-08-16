/datum/emote
	var/key = "" //What calls the emote
	var/key_third_person = "" //This will also call the emote
	var/no_message = FALSE
	var/message = "" //Message displayed when emote is used
	var/original_message = "" //Original message before any changes
	var/message_alien = "" //Message displayed if the user is a grown alien
	var/message_larva = "" //Message displayed if the user is an alien larva
	var/message_robot = "" //Message displayed if the user is a robot
	var/message_AI = "" //Message displayed if the user is an AI
	var/message_monkey = "" //Message displayed if the user is a monkey
	var/message_simple = "" //Message to display if the user is a simple_animal
	var/message_param = "" //Message to display if a param was given
	var/emote_type = EMOTE_VISIBLE //Whether the emote is visible or audible
	var/restraint_check = FALSE //Checks if the mob is restrained before performing the emote
	var/muzzle_ignore = FALSE //Will only work if the emote is EMOTE_AUDIBLE
	var/list/mob_type_allowed_typecache = /mob //Types that are allowed to use that emote
	var/list/mob_type_blacklist_typecache //Types that are NOT allowed to use that emote
	var/list/mob_type_ignore_stat_typecache
	var/stat_allowed = SOFT_CRIT
	var/mommychat = TRUE
	var/mommychat_partial = TRUE
	var/static/list/emote_list = list()
	var/static/regex/stop_bad_mime = regex(@"says|exclaims|yells|asks")
	/// Sound to play when emote is called.
	var/sound
	/// Volume of the sound we play
	var/sound_volume = 50
	/// If the sound varies in pitch, set to true
	var/sound_vary = FALSE
	/// Can only play sound when forced
	var/only_forced_audio = FALSE
	/// The cooldown between the uses of the emote.
	var/cooldown = 0.8 SECONDS
	/// Does this message have a message that can be modified by the user?
	var/can_message_change = FALSE
	/// How long is the cooldown on the audio of the emote, if it has one?
	var/audio_cooldown = 2 SECONDS
	/// emote does not have the player's name on the left.
	var/omit_left_name = FALSE
	var/message_range = 7

/datum/emote/New()
	if(restraint_check)
		stat_allowed = CONSCIOUS // just to be safe!
	if(key_third_person)
		emote_list[key_third_person] = src
	if (ispath(mob_type_allowed_typecache))
		switch (mob_type_allowed_typecache)
			if (/mob)
				mob_type_allowed_typecache = GLOB.typecache_mob
			if (/mob/living)
				mob_type_allowed_typecache = GLOB.typecache_living
			else
				mob_type_allowed_typecache = typecacheof(mob_type_allowed_typecache)
	else
		mob_type_allowed_typecache = typecacheof(mob_type_allowed_typecache)
	mob_type_blacklist_typecache = typecacheof(mob_type_blacklist_typecache)
	mob_type_ignore_stat_typecache = typecacheof(mob_type_ignore_stat_typecache)

/datum/emote/proc/run_emote(mob/user, params, type_override, intentional = FALSE, only_overhead, forced)
	. = TRUE
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if(no_message)
		return
	var/msg = select_message_type(user)
	if(params && message_param)
		msg = select_param(user, params)

	msg = replace_pronoun(user, msg)

	if(isliving(user))
		var/mob/living/L = user
		for(var/obj/item/implant/I in L.implants)
			I.trigger(key, L)

	if(!msg)
		return

	user.log_message(msg, LOG_EMOTE)

	var/tmp_sound = get_sound(user)
	if(tmp_sound && (forced || (should_play_sound(user, intentional) && (!intentional || !(TIMER_COOLDOWN_CHECK(user, type))))))
		playsound(user, tmp_sound, sound_volume, sound_vary)
		TIMER_COOLDOWN_START(user, type, audio_cooldown)

	if(user.ckey && !only_overhead)
		user.emote_for_ghost_sight("<b>[user]</b> [msg]")

	var/message_flags = (only_overhead ? (EMOTE_MESSAGE | ONLY_OVERHEAD) : (EMOTE_MESSAGE))


	msg = "<span class='emote'>[msg]</span>"
	var/datum/rental_mommy/chat/mommy = (mommychat || mommychat_partial) && (user && user.client) && BuildMommy(user, msg)
	if(!omit_left_name)
		ENABLE_BITFIELD(message_flags, PUT_NAME_IN)

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message(msg, deaf_message = msg, audible_message_flags = message_flags, hearing_distance = message_range, data = list("mom" = mommy))
	else
		user.visible_message(msg, blind_message = msg, visible_message_flags = message_flags, vision_distance = message_range, data = list("mom" = mommy))
	if(mommy)
		mommy.checkin()

// OI WHAT IF YE MUM WERE BUILT ON BA'REYS
/datum/emote/proc/BuildMommy(mob/user, message)
	if(!user || !user.client)
		return
	var/datum/rental_mommy/chat/mommy = SSrentaldatums.CheckoutMommy("chat_datums")
	if(!mommy)
		return
	mommy.original_message = message
	mommy.message = message
	mommy.original_speakername = user.name
	mommy.speakername = user.name
	mommy.source = user
	mommy.message_mode = null // it'll be set by the chat system
	mommy.message_key = null // it'll be set by the chat system
	mommy.is_emote = TRUE
	mommy.partial = mommychat_partial
	if(mommy.partial)
		mommy.hide_name_n_verb = TRUE
	mommy.furry_dating_sim = TRUE
	return mommy

/// Sends the given emote message for all ghosts with ghost sight enabled, excluding close enough to listen normally.
/mob/proc/emote_for_ghost_sight(message, admin_only, message_range)
	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		if(QDELETED(ghost))
			continue
		if(!ghost.client || isnewplayer(ghost))
			continue
		if(!(ghost.client.prefs.chat_toggles & CHAT_GHOSTSIGHT))
			continue
		if(client && client.ckey && (client.ckey in ghost.client.prefs.aghost_squelches)) // We cannot assume they have a client.
			continue
		if(admin_only && !check_rights_for(ghost.client, R_ADMIN))
			continue
		if(message_range)
			if(get_dist(src, ghost) < message_range)
				continue
		else
			var/ghost_view = ghost.client.view
			if(ghost.z == z)
				if(isnum(ghost_view))
					if(get_dist(src, ghost) < ghost_view)
						continue
				else
					var/list/view_range_list = splittext(ghost_view, "x")
					if(abs(x - ghost.x) < ((text2num(view_range_list[1]) - 1) / 2))
						if(abs(y - ghost.y) < ((text2num(view_range_list[2]) - 1) / 2))
							continue
		ghost.show_message("<span class='emote'>[FOLLOW_LINK(ghost, src)] [message]</span>")


/datum/emote/proc/replace_pronoun(mob/user, message)
	if(findtext(message, "their"))
		message = replacetext(message, "their", user.p_their())
	if(findtext(message, "them"))
		message = replacetext(message, "them", user.p_them())
	if(findtext(message, "%s"))
		message = replacetext(message, "%s", user.p_s())
	return message

/datum/emote/proc/select_message_type(mob/user)
	. = message
	if(!muzzle_ignore && user.is_muzzled() && emote_type == EMOTE_AUDIBLE)
		return "makes a [pick("strong ", "weak ", "")]noise."
	if(isalienadult(user) && message_alien)
		. = message_alien
	else if(islarva(user) && message_larva)
		. = message_larva
	else if(iscyborg(user) && message_robot)
		. = message_robot
	else if(isAI(user) && message_AI)
		. = message_AI
	else if(ismonkey(user) && message_monkey)
		. = message_monkey
	else if(isanimal(user) && message_simple)
		. = message_simple

/datum/emote/proc/select_param(mob/user, params)
	return replacetext(message_param, "%t", params)

/datum/emote/proc/can_run_emote(mob/user, status_check = TRUE, intentional = FALSE)
	. = TRUE
	if(mob_type_allowed_typecache) //empty list = anyone can use it unless specifically blacklisted
		if(!is_type_in_typecache(user, mob_type_allowed_typecache))
			return FALSE
	if(is_type_in_typecache(user, mob_type_blacklist_typecache))
		return FALSE
	if(status_check && !is_type_in_typecache(user, mob_type_ignore_stat_typecache))
		if(user.stat > stat_allowed)
			if(!intentional)
				return FALSE
			switch(user.stat)
				if(SOFT_CRIT)
					to_chat(user, span_notice("You cannot [key] while in a critical condition."))
				if(UNCONSCIOUS)
					to_chat(user, span_notice("You cannot [key] while unconscious."))
				if(DEAD)
					to_chat(user, span_notice("You cannot [key] while dead."))
			return FALSE
		var/mob/living/L = user
		if(restraint_check && (istype(L) && !CHECK_MOBILITY(L, MOBILITY_USE)))
			if(!intentional)
				return FALSE
			to_chat(user, span_notice("You cannot [key] while stunned."))
			return FALSE
		if(restraint_check && user.restrained())
			if(!intentional)
				return FALSE
			to_chat(user, span_notice("You cannot [key] while restrained."))
			return FALSE

	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_EMOTEMUTE))
			return FALSE

/**
 * To get the sound that the emote plays, for special sound interactions depending on the mob.
 *
 * Arguments:
 * * user - Person that is trying to send the emote.
 *
 * Returns the sound that will be made while sending the emote.
 */
/datum/emote/proc/get_sound(mob/living/user)
	return pick(sound) //by default just return this var.

/**
 * Check to see if the user should play a sound when performing the emote.
 *
 * Arguments:
 * * user - Person that is doing the emote.
 * * intentional - Bool that says whether the emote was forced (FALSE) or not (TRUE).
 *
 * Returns a bool about whether or not the user should play a sound when performing the emote.
 */
/datum/emote/proc/should_play_sound(mob/user, intentional = FALSE)
	if(only_forced_audio && intentional)
		return FALSE
	return TRUE

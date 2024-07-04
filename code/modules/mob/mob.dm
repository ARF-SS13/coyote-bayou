/mob/Destroy()//This makes sure that mobs with clients/keys are not just deleted from the game.
	remove_from_mob_list()
	remove_from_dead_mob_list()
	remove_from_alive_mob_list()
	GLOB.all_clockwork_mobs -= src
	focus = null
	LAssailant = null
	movespeed_modification = null
	for (var/alert in alerts)
		clear_alert(alert, TRUE)
	if(observers && observers.len)
		for(var/M in observers)
			var/mob/dead/observe = M
			observe.reset_perspective(null)
	qdel(hud_used)
	if(LAZYLEN(client_colours)) // frick 'u'
		QDEL_LIST(client_colours)
	clear_client_in_contents()
	ghostize()
	QDEL_LIST(actions)
	QDEL_LIST(mob_spell_list)
	if(mind && mind.current == src) //Let's just be safe yeah? This will occasionally be cleared, but not always. Can't do it with ghostize without changing behavior
		mind.current = null
	return ..() // Coyote Modify, Mobs wont lag the server when gibbed :o

/mob/Initialize()
	add_to_mob_list()
	if(stat == DEAD)
		add_to_dead_mob_list()
	else
		add_to_alive_mob_list()
	set_focus(src)
	prepare_huds()
	for(var/v in GLOB.active_alternate_appearances)
		if(!v)
			continue
		var/datum/atom_hud/alternate_appearance/AA = v
		AA.onNewMob(src)
	set_nutrition(rand(NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_START_MAX))
	. = ..()
	update_config_movespeed()
	update_movespeed(TRUE)
	become_hearing_sensitive()

/mob/ComponentInitialize()
	. = ..()
	if(!isnull(waddle_amount) && !isnull(waddle_up_time) && !isnull(waddle_side_time))
		AddComponent(/datum/component/waddling, waddle_amount, waddle_up_time, waddle_side_time)

/mob/GenerateTag()
	tag = "mob_[next_mob_id++]"

/// Prepare, or re-prepare
/atom/proc/prepare_huds()
	if(!islist(hud_list))
		hud_list = list()
	for(var/hud in hud_possible)
		var/hint = hud_possible[hud]
		if(hud_list[hud])
			continue
		switch(hint)
			if(HUD_LIST_LIST)
				hud_list[hud] = list()
			else
				var/image/I = image('icons/mob/hud.dmi', src, "")
				I.appearance_flags = RESET_COLOR|RESET_TRANSFORM
				hud_list[hud] = I

/mob/proc/Cell()
	set category = "Admin"
	set hidden = 1

	if(!loc)
		return 0

	// var/datum/gas_mixture/environment = loc.return_air()

	// var/t =	span_notice("Coordinates: [x],[y] \n")
	// t +=	span_danger("Temperature: [environment.return_temperature()] \n")
	// for(var/id in environment.get_gases())
	// 	if(environment.get_moles(id))
	// 		t+=span_notice("[GLOB.gas_data.names[id]]: [environment.get_moles(id)] \n")

	// to_chat(usr, t)

/mob/proc/get_photo_description(obj/item/camera/camera)
	return "a ... thing?"

/mob/proc/show_message(msg, type, alt_msg, alt_type, pref_check)//Message, type of message (1 or 2), alternative message, alt message type (1 or 2)
	if(audiovisual_redirect)
		audiovisual_redirect.show_message(msg ? "<avredirspan class='small'>[msg]</avredirspan>" : null, type, alt_msg ? "<avredirspan class='small'>[alt_msg]</avredirspan>" : null, alt_type)

	if(!client)
		return
	
	if(pref_check && !CHECK_PREFS(src, pref_check))
		return

	msg = copytext_char(msg, 1, MAX_MESSAGE_LEN)

	if(type)
		if(type & MSG_VISUAL && eye_blind )//Vision related
			if(!alt_msg)
				return
			else
				msg = alt_msg
				type = alt_type

		if(type & MSG_AUDIBLE && !can_hear())//Hearing related
			if(!alt_msg)
				return
			else
				msg = alt_msg
				type = alt_type
				if(type & MSG_VISUAL && eye_blind)
					return
	// voice muffling
	if(stat == UNCONSCIOUS)
		if(type & MSG_AUDIBLE) //audio
			to_chat(src, "<I>... You can almost hear something ...</I>")
		return
	to_chat(src, msg)

/**
 * Generate a visible message from this atom
 *
 * Show a message to all player mobs who sees this atom
 *
 * Show a message to the src mob (if the src is a mob)
 *
 * Use for atoms performing visible actions
 *
 * message is output to anyone who can see, e.g. "The [src] does something!"
 *
 * Vars:
 * * self_message (optional) is what the src mob sees e.g. "You do something!"
 * * blind_message (optional) is what blind people will hear e.g. "You hear something!"
 * * vision_distance (optional) define how many tiles away the message can be seen.
 * * ignored_mobs (optional) doesn't show any message to any given mob in the list.
 * * target (optional) is the other mob involved with the visible message. For example, the attacker in many combat messages.
 * * target_message (optional) is what the target mob will see e.g. "[src] does something to you!"
 */
/atom/proc/visible_message(
		message,
		self_message,
		blind_message,
		vision_distance = DEFAULT_MESSAGE_RANGE,
		ignored_mobs,
		mob/target,
		target_message,
		visible_message_flags = NONE,
		pref_check
		)
	var/turf/T = get_turf(src)
	if(!T)
		return
	var/list/hearers = get_hearers_in_view(vision_distance, src) //caches the hearers and then removes ignored mobs.
	if(!length(hearers)) // yes, hearers is correct
		return
	hearers -= ignored_mobs

	var/saycolor = src.get_chat_color()
	var/targetsaycolor = null
	if(!!target)
		targetsaycolor = target.get_chat_color()
	if(!self_message)
		self_message = message

	if(target_message && target && istype(target) && target.client)
		hearers -= target
		//This entire if/else chain could be in two lines but isn't for readabilty's sake.
		var/msg = target_message
		if(target.see_invisible<invisibility || target.is_blind()) //if src is invisible to us,
			msg = blind_message
		//the light object is dark and not invisible to us, darkness does not matter if you're directly next to the target
		else if(T.lighting_object && T.lighting_object.invisibility <= target.see_invisible && T.is_softly_lit() && !in_range(T,target))
			msg = blind_message
		if(msg && !CHECK_BITFIELD(visible_message_flags, ONLY_OVERHEAD))
			if(CHECK_BITFIELD(visible_message_flags, PUT_NAME_IN))
				msg = "<b>[src.name]</b> [msg]"
			if(target.client.prefs.color_chat_log)
				var/sanitizedsaycolor = target.client.sanitize_chat_color(saycolor)
				var/sanitizedtargetsaycolor = target.client.sanitize_chat_color(targetsaycolor)
				msg = color_for_chatlog(msg, sanitizedsaycolor, src.name)
				msg = color_keyword(msg, sanitizedtargetsaycolor, target.name)
			target.show_message(msg, MSG_VISUAL,msg, MSG_AUDIBLE)
	//if(self_message)
		//hearers -= src

	//var/raw_msg = message
	//if(visible_message_flags & EMOTE_MESSAGE)
	//	message = "<span class='emote'><b>[src]</b> [message]</span>"

	for(var/mob/M in hearers)
		if(!M.client)
			continue
		if(pref_check && !CHECK_PREFS(M, pref_check))
			continue
		//This entire if/else chain could be in two lines but isn't for readabilty's sake.
		var/blind = M.is_blind()
		var/msg = message
		//if(M == src)
		//	msg = self_message
		if(M.see_invisible<invisibility || (T != loc && T != src) || blind)//if src is invisible to us or is inside something (and isn't a turf),
			msg = blind_message

		if(visible_message_flags & EMOTE_MESSAGE && runechat_prefs_check(M, visible_message_flags)) // blind people can see emotes, sorta
			M.create_chat_message(src, raw_message = msg, runechat_flags = visible_message_flags)
		if(msg && !CHECK_BITFIELD(visible_message_flags, ONLY_OVERHEAD))
			if(CHECK_BITFIELD(visible_message_flags, PUT_NAME_IN))
				msg = "<b>[src]</b> [msg]"
			if(M.client.prefs.color_chat_log)
				var/sanitizedsaycolor = M.client.sanitize_chat_color(saycolor)
				msg = color_for_chatlog(msg, sanitizedsaycolor, src.name)
				if(!!target)
					var/sanitizedtargetsaycolor = M.client.sanitize_chat_color(targetsaycolor)
					msg = color_keyword(msg, sanitizedtargetsaycolor, target.name)
			M.show_message(msg, MSG_VISUAL, msg, MSG_AUDIBLE)

///Adds the functionality to self_message.
/mob/visible_message(message, self_message, blind_message, vision_distance = DEFAULT_MESSAGE_RANGE, list/ignored_mobs, mob/target, target_message, visible_message_flags = NONE, pref_check)
	. = ..()
	// if(self_message && target != src)
	// 	show_message(self_message, null, blind_message, null, pref_check)

/**
 * Show a message to all mobs in earshot of this atom
 *
 * Use for objects performing audible actions
 *
 * vars:
 * * message is the message output to anyone who can hear.
 * * deaf_message (optional) is what deaf people will see.
 * * hearing_distance (optional) is the range, how many tiles away the message can be heard.
 * * ignored_mobs (optional) doesn't show any message to any given mob in the list.
 */
/atom/proc/audible_message(
		message,
		deaf_message,
		hearing_distance = DEFAULT_MESSAGE_RANGE,
		self_message,
		ignored_mobs,
		audible_message_flags = NONE,
		pref_check
		)
	var/turf/T = get_turf(src)
	if(!T)
		return
	var/list/hearers = get_hearers_in_view(hearing_distance, src)
	if(!length(hearers))
		return
	hearers -= ignored_mobs
	if(!self_message)
		self_message = message
	//if(self_message)
		//hearers -= src
//	var/raw_msg = message
	if(CHECK_BITFIELD(audible_message_flags, PUT_NAME_IN))
		message = "<b>[src]</b> [message]"
	//if(audible_message_flags & EMOTE_MESSAGE)
	//	message = "<span class='emote'><b>[src]</b> [message]</span>"

	var/saycolor = src.get_chat_color()

	for(var/mob/M in hearers)
		if(pref_check && !CHECK_PREFS(M, pref_check))
			continue
		var/msg = message
		//if(M == src)
		//	msg = self_message
		if(!M.can_hear())
			msg = deaf_message
		if(M.client?.prefs.color_chat_log)
			var/sanitizedsaycolor = M.client.sanitize_chat_color(saycolor)
			msg = color_for_chatlog(msg, sanitizedsaycolor, src.name)
		if(audible_message_flags & EMOTE_MESSAGE && runechat_prefs_check(M, audible_message_flags))
			M.create_chat_message(src, raw_message = msg, runechat_flags = audible_message_flags)
		if(!CHECK_BITFIELD(audible_message_flags, ONLY_OVERHEAD))
			M.show_message(msg, MSG_AUDIBLE, msg, MSG_VISUAL)

/**
 * Show a message to all mobs in earshot of this one
 *
 * This would be for audible actions by the src mob
 *
 * vars:
 * * message is the message output to anyone who can hear.
 * * self_message (optional) is what the src mob hears.
 * * deaf_message (optional) is what deaf people will see.
 * * hearing_distance (optional) is the range, how many tiles away the message can be heard.
 * * ignored_mobs (optional) doesn't show any message to any given mob in the list.
 */
/mob/audible_message(message, deaf_message, hearing_distance = DEFAULT_MESSAGE_RANGE, self_message, list/ignored_mobs, audible_message_flags = NONE, pref_check)
	. = ..()
	// if(self_message)
	// 	show_message(self_message, null, deaf_message, null, pref_check)


///Returns the client runechat visible messages preference according to the message type.
/atom/proc/runechat_prefs_check(mob/target, visible_message_flags = NONE)
	if(!target.client?.prefs)
		return FALSE
	if(!target.client.prefs.chat_on_map || !target.client.prefs.see_chat_non_mob)
		return FALSE
	if(visible_message_flags & EMOTE_MESSAGE && !target.client.prefs.see_rc_emotes)
		return FALSE
	return TRUE

/mob/runechat_prefs_check(mob/target, visible_message_flags = NONE)
	if(!target.client?.prefs?.chat_on_map)
		return FALSE
	if(visible_message_flags & EMOTE_MESSAGE && !target.client.prefs.see_rc_emotes)
		return FALSE
	return TRUE


/mob/proc/get_item_by_slot(slot_id)
	return null

/mob/proc/restrained(ignore_grab)
	return

/mob/proc/incapacitated(ignore_restraints = FALSE, ignore_grab = FALSE, check_immobilized = FALSE, allow_crit = FALSE)
	return

//This proc is called whenever someone clicks an inventory ui slot.
/mob/proc/attack_ui(slot)
	var/obj/item/W = get_active_held_item()

	if(istype(W))
		if(equip_to_slot_if_possible(W, slot, FALSE, FALSE, FALSE, FALSE, TRUE))
			return TRUE

	if(!W)
		// Activate the item
		var/obj/item/I = get_item_by_slot(slot)
		if(istype(I))
			if(slot in check_obscured_slots())
				to_chat(src, span_warning("You are unable to unequip that while wearing other garments over it!"))
				return FALSE
			I.attack_hand(src)

	return FALSE

/// Checks for slots that are currently obscured by other garments.
/mob/proc/check_obscured_slots()
	return

// reset_perspective(thing) set the eye to the thing (if it's equal to current default reset to mob perspective)
// reset_perspective() set eye to common default : mob on turf, loc otherwise
/mob/proc/reset_perspective(atom/A)
	if(!client)
		return
	if(A)
		if(ismovable(A))
			//Set the the thing unless it's us
			if(A != src)
				client.perspective = EYE_PERSPECTIVE
				client.eye = A
			else
				client.eye = client.mob
				client.perspective = MOB_PERSPECTIVE
		else if(isturf(A))
			//Set to the turf unless it's our current turf
			if(A != loc)
				client.perspective = EYE_PERSPECTIVE
				client.eye = A
			else
				client.eye = client.mob
				client.perspective = MOB_PERSPECTIVE
		else
			//Do nothing
	else
		//Reset to common defaults: mob if on turf, otherwise current loc
		if(isturf(loc))
			client.eye = client.mob
			client.perspective = MOB_PERSPECTIVE
		else
			client.perspective = EYE_PERSPECTIVE
			client.eye = loc
	SEND_SIGNAL(src, COMSIG_MOB_RESET_PERSPECTIVE, A)
	return TRUE

/mob/proc/show_inv(mob/user)
	return

//view() but with a signal, to allow blacklisting some of the otherwise visible atoms.
/mob/proc/fov_view(dist = world.view)
	. = view(dist, src)
	SEND_SIGNAL(src, COMSIG_MOB_FOV_VIEW, .)

/**
 * Examine a mob
 *
 * mob verbs are faster than object verbs. See
 * [this byond forum post](https://secure.byond.com/forum/?post=1326139&page=2#comment8198716)
 * for why this isn't atom/verb/examine()
 */
/mob/verb/examinate(atom/A as mob|obj|turf in view()) //It used to be oview(12), but I can't really say why
	set name = "Examine"
	set category = "IC"

	if(isturf(A) && !(sight & SEE_TURFS) && !(A in view(client ? client.view : world.view, src)))
		// shift-click catcher may issue examinate() calls for out-of-sight turfs
		return

	if(is_blind())
		to_chat(src, span_warning("Something is there but you can't see it!"))
		return
	return true_examinate(A)

/// Splits the examine verb into two parts, one to determine if examining is possible, and one to actually do the examining.
/// Allows code to force an examination without checking if its visible.
/mob/proc/true_examinate(atom/A)
	if(!A)
		return
	face_atom(A)
	var/list/result
	if(client)
		LAZYINITLIST(client.recent_examines)
		if(isnull(client.recent_examines[A]) || client.recent_examines[A] < world.time)
			result = A.examine(src)
			client.recent_examines[A] = world.time + EXAMINE_MORE_TIME // set the value to when the examine cooldown ends
			RegisterSignal(A, COMSIG_PARENT_QDELETING,PROC_REF(clear_from_recent_examines), override=TRUE) // to flush the value if deleted early
			addtimer(CALLBACK(src,PROC_REF(clear_from_recent_examines), A), EXAMINE_MORE_TIME)
			handle_eye_contact(A)
		else
			result = A.examine_more(src)
	else
		result = A.examine(src) // if a tree is examined but no client is there to see it, did the tree ever really exist?

	if(!result)
		return
	if(LAZYLEN(result) <= 0) // A robot tried to examine their health bar and it runtimed cus it returned an empty list. Darn robot.
		return
	to_chat(src, result.Join("\n"))
	SEND_SIGNAL(src, COMSIG_MOB_EXAMINATE, A)

/mob/proc/clear_from_recent_examines(atom/A)
	if(!client)
		return
	UnregisterSignal(A, COMSIG_PARENT_QDELETING)
	LAZYREMOVE(client.recent_examines, A)

/**
 * handle_eye_contact() is called when we examine() something. If we examine an alive mob with a mind who has examined us in the last second within 5 tiles, we make eye contact!
 *
 * Note that if either party has their face obscured, the other won't get the notice about the eye contact
 * Also note that examine_more() doesn't proc this or extend the timer, just because it's simpler this way and doesn't lose much.
 *	The nice part about relying on examining is that we don't bother checking visibility, because we already know they were both visible to each other within the last second, and the one who triggers it is currently seeing them
 */
/mob/proc/handle_eye_contact(mob/living/examined_mob)
	return

/mob/living/handle_eye_contact(mob/living/examined_mob)
	if(!istype(examined_mob) || src == examined_mob || examined_mob.stat >= UNCONSCIOUS || !client || !examined_mob.client?.recent_examines || !(src in examined_mob.client.recent_examines))
		return

	if(get_dist(src, examined_mob) > EYE_CONTACT_RANGE)
		return

	var/mob/living/carbon/examined_carbon = examined_mob
	// check to see if their face is blocked (or if they're not a carbon, in which case they can't block their face anyway)
	if(!istype(examined_carbon) || (!(examined_carbon.wear_mask && examined_carbon.wear_mask.flags_inv & HIDEFACE) && !(examined_carbon.head && examined_carbon.head.flags_inv & HIDEFACE)))
		if(SEND_SIGNAL(src, COMSIG_MOB_EYECONTACT, examined_mob, TRUE) != COMSIG_BLOCK_EYECONTACT)
			var/msg = span_smallnotice("You make eye contact with [examined_mob].")
			addtimer(CALLBACK(usr, GLOBAL_PROC_REF(to_chat), src, msg), 3) // so the examine signal has time to fire and this will print after

	var/mob/living/carbon/us_as_carbon = src // i know >casting as subtype, but this isn't really an inheritable check
	if(!istype(us_as_carbon) || (!(us_as_carbon.wear_mask && us_as_carbon.wear_mask.flags_inv & HIDEFACE) && !(us_as_carbon.head && us_as_carbon.head.flags_inv & HIDEFACE)))
		if(SEND_SIGNAL(examined_mob, COMSIG_MOB_EYECONTACT, src, FALSE) != COMSIG_BLOCK_EYECONTACT)
			var/msg = span_smallnotice("[src] makes eye contact with you.")
			addtimer(CALLBACK(usr, GLOBAL_PROC_REF(to_chat), examined_mob, msg), 3)

//same as above
//note: ghosts can point, this is intended
//visible_message will handle invisibility properly
//overridden here and in /mob/dead/observer for different point span classes and sanity checks
/mob/verb/pointed(atom/A as mob|obj|turf in fov_view())
	set name = "Point To"
	set category = "Object"

	if(!src || !isturf(src.loc) || !(A in view(src.loc)))
		return FALSE
	if(istype(A, /obj/effect/temp_visual/point))
		return FALSE

	var/tile = get_turf(A)
	if (!tile)
		return FALSE

	new /obj/effect/temp_visual/point(A,invisibility)
	SEND_SIGNAL(src, COMSIG_MOB_POINTED, A)
	return TRUE

/mob/proc/can_resist()
	return FALSE		//overridden in living.dm

/mob/proc/spin(spintime, speed)
	set waitfor = 0
	var/D = dir
	if((spintime < 1)||(speed < 1)||!spintime||!speed)
		return
	while(spintime >= speed)
		sleep(speed)
		switch(D)
			if(NORTH)
				D = EAST
			if(SOUTH)
				D = WEST
			if(EAST)
				D = SOUTH
			if(WEST)
				D = NORTH
		setDir(D)
		spintime -= speed

/mob/proc/update_pull_hud_icon()
	hud_used?.pull_icon?.update_icon()

/mob/proc/update_rest_hud_icon()
	hud_used?.rest_icon?.update_icon()

/mob/verb/mode()
	set name = "Activate Held Object"
	set category = "Object"
	set src = usr

	if(ismecha(loc))
		return

	if(incapacitated(allow_crit = TRUE))
		return

	var/obj/item/I = get_active_held_item()
	if(I)
		I.attack_self(src)
		update_inv_hands()

/mob/verb/memory()
	set name = "Notes"
	set category = "IC"
	set desc = "View your character's notes memory."
	if(mind)
		mind.show_memory(src)
	else
		to_chat(src, "You don't have a mind datum for some reason, so you can't look at your notes, if you had any.")

/mob/verb/add_memory(msg as message)
	set name = "Add Note"
	set category = "IC"

	msg = copytext_char(msg, 1, MAX_MESSAGE_LEN)
	msg = sanitize(msg)

	if(mind)
		mind.store_memory(msg)
	else
		to_chat(src, "You don't have a mind datum for some reason, so you can't add a note to it.")

/mob/verb/abandon_mob()
	set name = "Respawn"
	set category = "OOC"

	/* check respawn is on */
	if(CONFIG_GET(flag/norespawn))
		return
	/* check player is actually dead */
	if((stat != DEAD || !( SSticker )))
		to_chat(usr, span_boldnotice("You must be dead to use this!"))
		return

	var/is_admin = check_rights_for(src.client, R_ADMIN)
	var/test = world.time - src.timeofdeath //How long dead for in deciseconds -- src can either be the corpse or ghost
	/* check if the respawn cooldown has expired, and check for admin override if not */
	if(test < RESPAWN_TIMER)
		to_chat(src, "You've been dead for [test / 10] seconds. You must be dead for at least [RESPAWN_TIMER / 600] minute\s to respawn.")
		if(is_admin) /* if player is an admin, and cancels the override, return */
			if(alert("Normal players must wait at least [RESPAWN_TIMER / 600] minute\s to respawn! Continue?","Warning", "Respawn", "Cancel") == "Cancel")
				return
			else /* admin chose to override, so log it rather than returning */
				log_game("[key_name(usr)] used abandon mob while bypassing the regular death cooldown VIA admin prompt.")
		else /* if player is not an admin, they can't override, so return */
			return
	/*end src.mind.current - we survived the various checks, so perform the actual respawn */
	log_game("[key_name(usr)] used abandon mob.")

	to_chat(usr, span_boldnotice("Please roleplay correctly!"))

	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return
	client.screen.Cut()
	client.screen += client.void
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return

	var/mob/dead/new_player/M = new /mob/dead/new_player()
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		qdel(M)
		return

	M.key = key


/mob/proc/transfer_ckey(mob/new_mob, send_signal = TRUE)
	if(!new_mob || (!ckey && new_mob.ckey))
		CRASH("transfer_ckey() called [new_mob ? "on ckey-less mob with a player mob as target" : "without a valid mob target"]!")
	if(!ckey)
		return
	SEND_SIGNAL(new_mob, COMSIG_MOB_PRE_PLAYER_CHANGE, new_mob, src)
	if (client)
		if(client.prefs?.auto_ooc)
			client.prefs.chat_toggles |= CHAT_OOC
	new_mob.ckey = ckey
	if(send_signal)
		SEND_SIGNAL(src, COMSIG_MOB_KEY_CHANGE, new_mob, src)
	return TRUE

/mob/verb/cancel_camera()
	set name = "Cancel Camera View"
	set category = "OOC"
	reset_perspective(null)
	unset_machine()

GLOBAL_VAR_INIT(exploit_warn_spam_prevention, 0)

//suppress the .click/dblclick macros so people can't use them to identify the location of items or aimbot
/mob/verb/DisClick(argu = null as anything, sec = "" as text, number1 = 0 as num  , number2 = 0 as num)
	set name = ".click"
	set hidden = TRUE
	set category = null
	if(GLOB.exploit_warn_spam_prevention < world.time)
		var/msg = "[key_name_admin(src)]([ADMIN_KICK(src)]) attempted to use the .click macro!"
		log_admin(msg)
		message_admins(msg)
		GLOB.exploit_warn_spam_prevention = world.time + 10

/mob/verb/DisDblClick(argu = null as anything, sec = "" as text, number1 = 0 as num  , number2 = 0 as num)
	set name = ".dblclick"
	set hidden = TRUE
	set category = null
	if(GLOB.exploit_warn_spam_prevention < world.time)
		var/msg = "[key_name_admin(src)]([ADMIN_KICK(src)]) attempted to use the .dblclick macro!"
		log_admin(msg)
		message_admins(msg)
		GLOB.exploit_warn_spam_prevention = world.time + 10

/mob/Topic(href, href_list)
	if(href_list["mach_close"])
		var/t1 = text("window=[href_list["mach_close"]]")
		unset_machine()
		src << browse(null, t1)

	if(href_list["refresh"])
		if(machine && in_range(src, usr))
			show_inv(machine)

	if(usr.canUseTopic(src, BE_CLOSE, NO_DEXTERY))
		if(href_list["item"])
			var/slot = text2num(href_list["item"])
			var/hand_index = text2num(href_list["hand_index"])
			var/obj/item/what
			if(hand_index)
				what = get_item_for_held_index(hand_index)
				slot = list(slot,hand_index)
			else
				what = get_item_by_slot(slot)
			if(what)
				if(!(what.item_flags & ABSTRACT))
					usr.stripPanelUnequip(what,src,slot)
			else
				usr.stripPanelEquip(what,src,slot)
	//Coyote Add
	if(href_list["flavor_more"])
		usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", name, replacetext(flavortext, "\n", "<BR>")), text("window=[];size=500x200", name))
		onclose(usr, "[name]")
	if(href_list["oocnotes"])
		usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", name, replacetext(oocnotes, "\n", "<BR>")), text("window=[];size=500x200", name))
		onclose(usr, "[name]")
	if(href_list["enlargeImageCreature"])
		var/followers_clinic_full_of_big_strong_gay_dogs_in_it = PfpHostLink(profilePicture)
		var/dat = {"
			<img src='[followers_clinic_full_of_big_strong_gay_dogs_in_it]' width='100%' height='100%' 'object-fit: scale-down;'>
			<br>
			[followers_clinic_full_of_big_strong_gay_dogs_in_it] <- Copy this link to your browser to view the full sized image.
		"}
		var/datum/browser/popup = new(usr, "enlargeImage", "Full Sized Picture!",1024,768)
		popup.set_content(dat)
		popup.open()

	if(usr.machine == src)
		if(Adjacent(usr))
			show_inv(usr)
		else
			usr << browse(null,"window=mob[REF(src)]")

// The src mob is trying to strip an item from someone
// Defined in living.dm
/mob/proc/stripPanelUnequip(obj/item/what, mob/who)
	return

// The src mob is trying to place an item on someone
// Defined in living.dm
/mob/proc/stripPanelEquip(obj/item/what, mob/who)
	return

/mob/MouseDrop(mob/M)
	. = ..()
	if(M != usr)
		return
	if(usr == src)
		return
	if(!Adjacent(usr))
		return
	if(isAI(M))
		return

/mob/MouseDrop_T(atom/dropping, atom/user)
	. = ..()
	if(ismob(dropping) && dropping != user)
		var/mob/M = dropping
		M.show_inv(user)

/mob/proc/is_muzzled()
	return FALSE

/// Adds this list to the output to the stat browser
/mob/proc/get_status_tab_items()
	. = list()

/// Gets all relevant proc holders for the browser statpenl
/mob/proc/get_proc_holders()
	. = list()
	if(mind)
		. += get_spells_for_statpanel(mind.spell_list)
	. += get_spells_for_statpanel(mob_spell_list)

/**
 * Convert a list of spells into a displyable list for the statpanel
 *
 * Shows charge and other important info
 */
/mob/proc/get_spells_for_statpanel(list/spells)
	var/list/L = list()
	for(var/obj/effect/proc_holder/spell/S in spells)
		if((!S.mobs_blacklist || !S.mobs_blacklist[src]) && (!S.mobs_whitelist || S.mobs_whitelist[src]))
			switch(S.charge_type)
				if("recharge")
					L[++L.len] = list("[S.panel]", "[S.charge_counter/10.0]/[S.charge_max/10]", S.name, REF(S))
				if("charges")
					L[++L.len] = list("[S.panel]", "[S.charge_counter]/[S.charge_max]", S.name, REF(S))
				if("holdervar")
					L[++L.len] = list("[S.panel]", "[S.holder_var_type] [S.holder_var_amount]", S.name, REF(S))
	return L

/mob/proc/add_stings_to_statpanel(list/stings)
	for(var/obj/effect/proc_holder/changeling/S in stings)
		if(S.chemical_cost >=0 && S.can_be_used_by(src))
			statpanel("[S.panel]",((S.chemical_cost > 0) ? "[S.chemical_cost]" : ""),S)

#define MOB_FACE_DIRECTION_DELAY 1

// facing verbs
/mob/proc/canface()
	if(world.time < client.last_turn)
		return FALSE
	if(stat == DEAD || stat == UNCONSCIOUS)
		return FALSE
	if(anchored)
		return FALSE
	if(mob_transforming)
		return FALSE
	if(restrained())
		return FALSE
	return TRUE

/mob/proc/fall(forced)
	drop_all_held_items()

/mob/verb/eastface()
	set hidden = TRUE
	if(!canface())
		return FALSE
	setDir(EAST)
	client.last_turn = world.time + MOB_FACE_DIRECTION_DELAY
	return TRUE

/mob/verb/westface()
	set hidden = TRUE
	if(!canface())
		return FALSE
	setDir(WEST)
	client.last_turn = world.time + MOB_FACE_DIRECTION_DELAY
	return TRUE

/mob/verb/northface()
	set hidden = TRUE
	if(!canface())
		return FALSE
	setDir(NORTH)
	client.last_turn = world.time + MOB_FACE_DIRECTION_DELAY
	return TRUE

/mob/verb/southface()
	set hidden = TRUE
	if(!canface())
		return FALSE
	setDir(SOUTH)
	client.last_turn = world.time + MOB_FACE_DIRECTION_DELAY
	return TRUE

/mob/verb/eastshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_x <= 16)
		pixel_x++
		is_shifted = TRUE

/mob/verb/westshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_x >= -16)
		pixel_x--
		is_shifted = TRUE

/mob/verb/northshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_y <= 16)
		pixel_y++
		is_shifted = TRUE

/mob/verb/southshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_y >= -16)
		pixel_y--
		is_shifted = TRUE

//-->Pixel sliding on steroids
/mob
	var/pixel_slide_allow = FALSE //if 1, initiate pixel sliding into another tile occupied by another mob 
	var/pixel_slide_target_has_help_int = FALSE  //we are going to store here the pixel sliding's target variable, specifically if they are in help intent
	var/pixel_slide_memory_x    //memory of previous x position before moving
	var/pixel_slide_memory_y    //memory of previous y position before moving
	var/pixel_slide_memory_dir  //memory of previous direction before moving

/mob/living/eastshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_x <= (16 + get_standard_pixel_x_offset()))
		pixel_x++
		is_shifted = TRUE
	if((pixel_x > (16 + get_standard_pixel_x_offset())) && !is_blocked_turf(get_step(src, EAST), 1))
		if(!pixel_slide_allow)
			pixel_slide_allow = TRUE
			pixel_slide_memory_x = pixel_x
			pixel_slide_memory_y = pixel_y
			pixel_slide_memory_dir = dir
			step(src, EAST)
			if(pixel_slide_target_has_help_int)
				pixel_x = pixel_slide_memory_x - 32
				pixel_y = pixel_slide_memory_y
				dir = pixel_slide_memory_dir
			pixel_slide_allow = FALSE
			is_shifted = TRUE

/mob/living/westshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_x >= -(16 + get_standard_pixel_x_offset()))
		pixel_x--
		is_shifted = TRUE
	if((pixel_x < -(16 + get_standard_pixel_x_offset())) && !is_blocked_turf(get_step(src, WEST), 1))
		if(!pixel_slide_allow)
			pixel_slide_allow = TRUE
			pixel_slide_memory_x = pixel_x
			pixel_slide_memory_y = pixel_y
			pixel_slide_memory_dir = dir
			step(src, WEST)
			if(pixel_slide_target_has_help_int)
				pixel_x = pixel_slide_memory_x + 32
				pixel_y = pixel_slide_memory_y
				dir = pixel_slide_memory_dir
			pixel_slide_allow = FALSE
			is_shifted = TRUE

/mob/living/northshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_y <= (16 + get_standard_pixel_y_offset()))
		pixel_y++
		is_shifted = TRUE
	if((pixel_y > (16 + get_standard_pixel_y_offset())) && !is_blocked_turf(get_step(src, NORTH), 1))
		if(!pixel_slide_allow)
			pixel_slide_allow = TRUE
			pixel_slide_memory_x = pixel_x
			pixel_slide_memory_y = pixel_y
			pixel_slide_memory_dir = dir
			step(src, NORTH)
			if(pixel_slide_target_has_help_int)
				pixel_x = pixel_slide_memory_x
				pixel_y = pixel_slide_memory_y - 32
				dir = pixel_slide_memory_dir
			pixel_slide_allow = FALSE
			is_shifted = TRUE

/mob/living/southshift()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_y >= -(16 + get_standard_pixel_y_offset()))
		pixel_y--
		is_shifted = TRUE
	if((pixel_y < -(16 + get_standard_pixel_y_offset())) && !is_blocked_turf(get_step(src, SOUTH), 1))
		if(!pixel_slide_allow)
			pixel_slide_allow = TRUE
			pixel_slide_memory_x = pixel_x
			pixel_slide_memory_y = pixel_y
			pixel_slide_memory_dir = dir
			step(src, SOUTH)
			if(pixel_slide_target_has_help_int)
				pixel_x = pixel_slide_memory_x
				pixel_y = pixel_slide_memory_y + 32
				dir = pixel_slide_memory_dir
			pixel_slide_allow = FALSE
			is_shifted = TRUE

/mob/proc/IsAdvancedToolUser()//This might need a rename but it should replace the can this mob use things check
	return FALSE

/mob/proc/swap_hand()
	var/obj/item/held_item = get_active_held_item()
	var/obj/item/new_item = get_inactive_held_item()
	if((SEND_SIGNAL(src, COMSIG_MOB_SWAP_HANDS, held_item) & COMPONENT_BLOCK_SWAP))
		return FALSE
	if(istype(new_item,/obj/item/twohanded/offhand))
		held_item.attempt_wield(src)
	return TRUE

/mob/proc/activate_hand(selhand)
	return

/mob/proc/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null) //For sec bot threat assessment
	return 0

/mob/proc/get_ghost(even_if_they_cant_reenter = 0)
	if(mind)
		return mind.get_ghost(even_if_they_cant_reenter)

/mob/proc/grab_ghost(force)
	if(mind)
		return mind.grab_ghost(force = force)

/mob/proc/notify_ghost_cloning(message = "Someone is trying to revive you. Re-enter your corpse if you want to be revived!", sound = 'sound/effects/genetics.ogg', atom/source = null, flashwindow)
	var/mob/dead/observer/ghost = get_ghost()
	if(ghost)
		ghost.notify_cloning(message, sound, source, flashwindow)
		return ghost

/mob/proc/AddSpell(obj/effect/proc_holder/spell/S)
	LAZYINITLIST(mob_spell_list)
	mob_spell_list += S
	S.action.Grant(src)

/mob/proc/RemoveSpell(obj/effect/proc_holder/spell/spell)
	if(!spell)
		return
	for(var/X in mob_spell_list)
		var/obj/effect/proc_holder/spell/S = X
		if(istype(S, spell))
			mob_spell_list -= S
			qdel(S)
	if(client)
		client << output(null, "statbrowser:check_spells")

/mob/proc/anti_magic_check(magic = TRUE, holy = FALSE, tinfoil = FALSE, chargecost = 1, self = FALSE)
	if(!magic && !holy && !tinfoil)
		return
	var/list/protection_sources = list()
	if(SEND_SIGNAL(src, COMSIG_MOB_RECEIVE_MAGIC, src, magic, holy, tinfoil, chargecost, self, protection_sources) & COMPONENT_BLOCK_MAGIC)
		if(protection_sources.len)
			return pick(protection_sources)
		else
			return src
	if((magic && HAS_TRAIT(src, TRAIT_ANTIMAGIC)) || (holy && HAS_TRAIT(src, TRAIT_HOLY)))
		return src

//You can buckle on mobs if you're next to them since most are dense
/mob/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE)
	if(M.buckled)
		return FALSE
	var/turf/T = get_turf(src)
	if(M.loc != T)
		var/old_density = density
		density = FALSE
		var/can_step = step_towards(M, T)
		density = old_density
		if(!can_step)
			return FALSE
	return ..()

//Default buckling shift visual for mobs
/mob/post_buckle_mob(mob/living/M)
	var/height = M.get_mob_buckling_height(src)
	M.pixel_y = initial(M.pixel_y) + height
	if(M.layer < layer)
		M.layer = layer + 0.1

/mob/post_unbuckle_mob(mob/living/M)
	M.layer = initial(M.layer)
	M.pixel_y = initial(M.pixel_y)

//returns the height in pixel the mob should have when buckled to another mob.
/mob/proc/get_mob_buckling_height(mob/seat)
	if(isliving(seat))
		var/mob/living/L = seat
		if(L.mob_size <= MOB_SIZE_SMALL) //being on top of a small mob doesn't put you very high.
			return 0
	return 9

//can the mob be buckled to something by default?
/mob/proc/can_buckle()
	return TRUE

//can the mob be unbuckled from something by default?
/mob/proc/can_unbuckle()
	return TRUE

/mob/proc/can_buckle_others(mob/living/target, atom/buckle_to)
	return TRUE

//Can the mob interact() with an atom?
/mob/proc/can_interact_with(atom/A)
	return IsAdminGhost(src) || Adjacent(A) || A.hasSiliconAccessInArea(src)

//Can the mob use Topic to interact with machines
/mob/proc/canUseTopic(atom/movable/M, be_close=FALSE, no_dextery=FALSE, no_tk=FALSE)
	return

/mob/proc/canUseStorage()
	return FALSE

/mob/proc/faction_check_mob(mob/target, exact_match, list/override)
	if(exact_match) //if we need an exact match, we need to do some bullfuckery.
		var/list/faction_src = faction.Copy()
		var/list/faction_target = target.faction.Copy()
		if(!("[REF(src)]" in faction_target)) //if they don't have our ref faction, remove it from our factions list.
			faction_src -= "[REF(src)]" //if we don't do this, we'll never have an exact match.
		if(!("[REF(target)]" in faction_src))
			faction_target -= "[REF(target)]" //same thing here.
		return faction_check(faction_src, faction_target, TRUE)
	return faction_check(faction, target.faction, FALSE)

/proc/faction_check(list/faction_A, list/faction_B, exact_match)
	if(!islist(faction_A))
		faction_A = list(faction_A)
	if(!islist(faction_B))
		faction_B = list(faction_B)
	var/list/match_list
	if(exact_match)
		match_list = faction_A&faction_B //only items in both lists
		var/length = LAZYLEN(match_list)
		if(length)
			return (length == LAZYLEN(faction_A)) //if they're not the same len(gth) or we don't have a len, then this isn't an exact match.
	else
		match_list = faction_A&faction_B
		return LAZYLEN(match_list)
	return FALSE


//This will update a mob's name, real_name, mind.name, GLOB.data_core records, pda, id and traitor text
//Calling this proc without an oldname will only update the mob and skip updating the pda, id and records ~Carn
/mob/proc/fully_replace_character_name(oldname,newname)
	log_message("[src] name changed from [oldname] to [newname]", LOG_OWNERSHIP)
	if(!newname)
		return 0
	real_name = newname
	name = newname
	if(mind)
		mind.name = newname

	if(oldname)
		//update the datacore records! This is goig to be a bit costly.
		replace_records_name(oldname,newname)

		//update our pda and id if we have them on our person
		replace_identification_name(oldname,newname)

		for(var/datum/mind/T in SSticker.minds)
			for(var/datum/objective/obj in T.get_all_objectives())
				// Only update if this player is a target
				if(obj.target && obj.target.current && obj.target.current.real_name == name)
					obj.update_explanation_text()
	return 1

//Updates GLOB.data_core records with new name , see mob/living/carbon/human
/mob/proc/replace_records_name(oldname,newname)
	return

/mob/proc/replace_identification_name(oldname,newname)
	var/list/searching = GetAllContents()
	var/search_id = 1
	var/search_pda = 1

	for(var/A in searching)
		if( search_id && istype(A, /obj/item/card/id) )
			var/obj/item/card/id/ID = A
			if(ID.registered_name == oldname)
				ID.registered_name = newname
				ID.update_label()
				if(!search_pda)
					break
				search_id = 0

		else if( search_pda && istype(A, /obj/item/pda) )
			var/obj/item/pda/PDA = A
			if(PDA.owner == oldname)
				PDA.owner = newname
				PDA.update_label()
				if(!search_id)
					break
				search_pda = 0

/mob/proc/update_stat()
	return

/mob/proc/update_health_hud()
	return

/mob/proc/update_sight()
	SEND_SIGNAL(src, COMSIG_MOB_UPDATE_SIGHT)

	sync_lighting_plane_alpha()

/mob/proc/sync_lighting_plane_alpha()
	if(hud_used)
		var/atom/movable/screen/plane_master/lighting/L = hud_used.plane_masters["[LIGHTING_PLANE]"]
		if (L)
			L.alpha = lighting_alpha


/mob/proc/is_literate()
	return 0

/mob/proc/can_hold_items()
	return FALSE

/mob/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---------")
	VV_DROPDOWN_OPTION(VV_HK_GIB, "Gib")
	VV_DROPDOWN_OPTION(VV_HK_GIVE_SPELL, "Give Spell")
	VV_DROPDOWN_OPTION(VV_HK_REMOVE_SPELL, "Remove Spell")
	VV_DROPDOWN_OPTION(VV_HK_GIVE_DISEASE, "Give Disease")
	VV_DROPDOWN_OPTION(VV_HK_GODMODE, "Toggle Godmode")
	VV_DROPDOWN_OPTION(VV_HK_DROP_ALL, "Drop Everything")
	VV_DROPDOWN_OPTION(VV_HK_REGEN_ICONS, "Regenerate Icons")
	VV_DROPDOWN_OPTION(VV_HK_PLAYER_PANEL, "Show player panel")
	VV_DROPDOWN_OPTION(VV_HK_BUILDMODE, "Toggle Buildmode")
	VV_DROPDOWN_OPTION(VV_HK_DIRECT_CONTROL, "Assume Direct Control")
	VV_DROPDOWN_OPTION(VV_HK_OFFER_GHOSTS, "Offer Control to Ghosts")

/mob/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_REGEN_ICONS])
		if(!check_rights(NONE))
			return
		regenerate_icons()
	if(href_list[VV_HK_PLAYER_PANEL])
		if(!check_rights(NONE))
			return
		usr.client.holder.show_player_panel(src)
	if(href_list[VV_HK_GODMODE])
		if(!check_rights(R_ADMIN))
			return
		usr.client.cmd_admin_godmode(src)
	if(href_list[VV_HK_GIVE_SPELL])
		if(!check_rights(NONE))
			return
		usr.client.give_spell(src)
	if(href_list[VV_HK_REMOVE_SPELL])
		if(!check_rights(NONE))
			return
		usr.client.remove_spell(src)
	if(href_list[VV_HK_GIVE_DISEASE])
		if(!check_rights(NONE))
			return
		usr.client.give_disease(src)
	if(href_list[VV_HK_GIB])
		if(!check_rights(R_FUN))
			return
		usr.client.cmd_admin_gib(src)
	if(href_list[VV_HK_BUILDMODE])
		if(!check_rights(R_BUILDMODE))
			return
		togglebuildmode(src)
	if(href_list[VV_HK_DROP_ALL])
		if(!check_rights(NONE))
			return
		usr.client.cmd_admin_drop_everything(src)
	if(href_list[VV_HK_DIRECT_CONTROL])
		if(!check_rights(NONE))
			return
		usr.client.cmd_assume_direct_control(src)
	if(href_list[VV_HK_OFFER_GHOSTS])
		if(!check_rights(NONE))
			return
		offer_control(src)

/mob/vv_get_var(var_name)
	switch(var_name)
		if("logging")
			LAZYINITLIST(logging)
			return debug_variable(var_name, logging, 0, src, FALSE)
	. = ..()

/mob/vv_auto_rename(new_name)
	//Do not do parent's actions, as we *usually* do this differently.
	fully_replace_character_name(real_name, new_name)

/mob/verb/open_language_menu()
	set name = "Open Language Menu"
	set category = "IC"

	var/datum/language_holder/H = get_language_holder()
	H.open_language_menu(usr)

/mob/verb/set_taste()
	set name = "Set how you taste"
	set category = "IC"

	var/list/taste = SSlistbank.get_tastes(src)
	var/myflavor = "Bingus"
	for(var/i in taste)
		myflavor = i
	var/message = stripped_input(usr, "Yum", "How do you taste?", "[myflavor]", 100, FALSE)
	if(message)
		var/list/newflavor = list("[message]" = 1)
		SSlistbank.catalogue_tastes(src, newflavor, TRUE)
		to_chat(usr, span_notice("You now taste like [message]"))

///Adjust the nutrition of a mob
/mob/proc/adjust_nutrition(change, max = INFINITY) //Honestly FUCK the oldcoders for putting nutrition on /mob someone else can move it up because holy hell I'd have to fix SO many typechecks
	nutrition = clamp(nutrition + change, 0, max)

///Force set the mob nutrition
/mob/proc/set_nutrition(change) //Seriously fuck you oldcoders.
	nutrition = max(0, change)

/mob/setMovetype(newval)
	. = ..()
	update_movespeed(FALSE)

/mob/proc/getLAssailant()
	return LAssailant?.resolve()

/// Updates the grab state of the mob and updates movespeed
/mob/setGrabState(newstate)
	. = ..()
	switch(grab_state)
		if(GRAB_PASSIVE)
			remove_movespeed_modifier(MOVESPEED_ID_MOB_GRAB_STATE)
		if(GRAB_AGGRESSIVE)
			add_movespeed_modifier(/datum/movespeed_modifier/grab_slowdown/aggressive)
		if(GRAB_NECK)
			add_movespeed_modifier(/datum/movespeed_modifier/grab_slowdown/neck)
		if(GRAB_KILL)
			add_movespeed_modifier(/datum/movespeed_modifier/grab_slowdown/kill)

/mob/proc/update_equipment_speed_mods()
	var/speedies = equipped_speed_mods()
	if(!speedies)
		remove_movespeed_modifier(/datum/movespeed_modifier/equipment_speedmod, update=TRUE)
	else
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/equipment_speedmod, multiplicative_slowdown = speedies)

/// Gets the combined speed modification of all worn items
/// Except base mob type doesnt really wear items
/mob/proc/equipped_speed_mods()
	for(var/obj/item/I in held_items)
		if(I.item_flags & SLOWS_WHILE_IN_HAND)
			. += I.slowdown


/mob/proc/set_stat(new_stat)
	if(new_stat == stat)
		return
	SEND_SIGNAL(src, COMSIG_MOB_STATCHANGE, new_stat)
	. = stat
	stat = new_stat


/**
 * Mostly called by doUnEquip()
 * Like item dropped() on mob side.
 */
/mob/proc/on_item_dropped(obj/item/I)
	return


/mob/verb/tilt_leftward()
	set hidden = FALSE
	tilt_left()

/mob/proc/tilt_left()
	if(!canface() || is_tilted < -360)
		return FALSE
	transform = transform.Turn(-1)
	is_tilted--

/mob/verb/tilt_rightward()
	set hidden = FALSE
	tilt_right()

/mob/proc/tilt_right()
	if(!canface() || is_tilted > 360)
		return FALSE
	transform = transform.Turn(1)
	is_tilted++

/mob/proc/clear_client_in_contents()
	if(client?.movingmob) //In the case the client was transferred to another mob and not deleted.
		client.movingmob.client_mobs_in_contents -= src
		UNSETEMPTY(client.movingmob.client_mobs_in_contents)
		client.movingmob = null

//Fenny goes insane thanks to kruger, thanks you deepfried twinkie <3

#define FLIRT_HEADER_TEXT "\
	----------Coyote Semi-OOC Flirt/Tease System--\n\
	Remember to do your homework and check the other persons OOC notes before you send a flirt request. \n\
	\n\
	Every single one of these actions is worded as an ATTEMPT to do said thing on the recieving parties end.\n\
	Roleplay accordingly. \n\
	\n\
	- If someone sends you a message and you reject them please remember not to be overly cruel ICly.\n\
	Unless they're into that, and its part of a bit. \n\
	- With understanding that rejection is sometimes a part of flirting, the 3. Option exists, use it specifically to play 'hard to get'. \n\
	\n\
	-- There are different categories of flirt. These exist to help the flirter figure out what approach they're using. \n\
	- Leer is generally you looking at them in some way. \n\
	-- React is generally you having some sort of reaction to them, like making a noise or a reflexive physical reactions like biting your own lower lip. \n\
	--- Touch is generally you attempting to touch them in some manner, like coping a feel or brushing a cheek. \n\
	\n\
	-- So lets try to hold onto your charm, shall we?\n\
	\n\
	- On the off chance that you DO find out someone is using your advance to stir pointless OOC drama please ahelp and let us know, don't assume we're aware. \n\
	"
/* 
/mob/verb/check_out(mob/A as mob in view())
	set name = "Flirt with"
	set category = "IC"

	if(!isliving(src)) 
		to_chat(src, span_hypnophrase("Touch grass, you ghostly fucker. Spawn in to swap spit with them."))
		return
	if(!A.client)
		to_chat(src, span_hypnophrase("You're having a white woman moment."))
		return

	var/list/choices = list(
	"1. Flirt/Physical Touch Accept",
	"2. Flirt/Physical Reject",
	"3. Play Hard to get",
	"Leer - Check them out.",
	"React - Blush at them.",
	"Touch - Sniff them.",
	"React - Coo at them.",
	"Touch - Pinch them.",
	"Touch - Caress them.",
	"Touch - Brush against them.",
	"Touch - Grope them generically.",
	"Touch - Grope their bottom.",
	"Touch - Grope their side.",
	"React - Kissy face at them.",
	"React - Offer a kiss to them.",
	"React - Wink at them.",
	"React - Waggle fingers at them.",
	"Touch - Lean on them.",
	"Touch - Snuggle into them.",
	"Touch - Kiss them lightly on the cheek.",
	"Touch - Try to steal a deep kiss.",
	"Touch - Try to steal a light kiss.",
	"Leer - Smile at them subtly.",
	"Leer - Smile at them provocatively",
	"React - Play with your hair",
	"React - Bite your own lower lip.",
	"Leer - Give them the side-eye.",
	"Touch - Push your backside into them.",
	"Touch - Touch them on accident.",
	"Touch - Softly bite their ear.",
	"Touch - Nuzzle their neck.",
	"Touch - Bite their neck.",
	"Touch - Hold hands with them.",
	"Touch - Fondle their chest/breasts.",
	"Touch - Touch their crotch.",
	"Touch - Heavy pet them.",
	"Leer - Stare at them.",
	"React - Avoid looking at them.",
	"Leer - Openly look at their assets.",
	"Touch - Fail to pickpocket.",
	"Leer - Raise an eyebrow at them.",
	"React - Loom over them.",
	"Touch - Grab their wrist.",
	"Touch - Corner them.",
	"Leer - Check them for wounds.",
	"Touch - Play with their hair.",
	"Touch - Squeeze them.",
	"Touch - Shove them.",
	"Leer - Sneer at them.",
	"Leer - Pay them more attention.",
	"React - Appear more demure to them.",
	"React - Bend over for them.",
	"React - Look heroic for them.",
	"React - Look like you need their help.",
	"Touch - Grab their arm.",
	"Touch - Pull their hair.",
	"Touch - Grab their belt.",
	"React - Whine needily.",
	"React - Tongue in cheek.",
	"React - Mouth an object.",
	"React - Play with your nipples openly.",
	"React - Play with your nipples sneakily.",
	"React - Draw attention to your breasts.",
	"React - Fold your arms under your breasts.",
	"React - Squish your breasts together.",
	"Touch - Touch their cheek.",
	"Touch - Pet them.",
	"Touch - Sooth them.",
	"React - Rub your thighs together.",
	"React - Try to hide your arousal.",
	"React - Touch your hand to your bosom.",
	"Leer - Arms akimbo.",
	"Touch - Press your breasts against them.",
	"Touch - Press your crotch against them.",
	"Touch - Grind on their lap.",
	"Touch - Poke their nose.",
	"Touch - Poke their Chest.",
	"Touch - Poke their breast.",
	"Touch - Poke their tummy.",
	"Touch - Poke their thigh.",
	"Touch - Grab their hips.",
	"Touch - Put a finger over their mouth.",
	"React - Dare them to 'make you' do something.",
	"Leer - Stare defiantly.",
	"React - Ask them to touch you.",
	"React - Ask them to take you.",
	"React - Ask them to kiss you.",
	"React - Verbally let them know you want them.",
	"React - Verbally let them know you need them.",
	"React - Flutter your eyelashes at them.",
	"Touch - Tickle their nose with your tail.",
	"React - Lose your breath.",
	"React - Heave your bosom.",
	"Leer - Grin deviously.",
	"Leer - Stare at their crotch.",
	"React - Lick your lips.",
	"React - Purse your lips.",
	"React - Shake from their touch.",
	"React - Shudder from overstimulation.",
	"React - Gasp from something they did.",
	"React - Moan at them.",
	"Leer - Lid your eyes and watch them.",
	"Leer - Sneak a peak at their assets.",
	"React - Want to tell them something.",
	"Touch - Pull their tail."
	)
	choices = sortList(choices)


	var/choice = input(FLIRT_HEADER_TEXT) as null|anything in choices
	var/user = usr 
	

	switch(choice)
		if("1. Flirt/Physical Touch Accept")
			to_chat(A, span_notice("[src] is greenlighting your <span class='love'>advance.</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You greenlight [A]\'s attention, however you do that is up to you.  Maybe make an emote for it?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("2. Flirt/Physical Reject")
			to_chat(A, span_notice("[src] is <span class='danger'>redlighting</span> your advance. Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You redlight [A]\'s' attention, howevery ou that is up to you but they know for sure now that no is no. Maybe make an emote for it?")
			SEND_SOUND(A, 'sound/effects/boowomp.ogg')

		if("3. Play Hard to get")
			to_chat(A, span_notice("[src] is <span class='danger'>playing hard to get towards</span> your advance. Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You play hard to get with [A], hopefully they will chase!")
			SEND_SOUND(A, 'sound/effects/boowomp.ogg')

		if("Leer - Check them out.",)
			to_chat(A, span_notice("[src] is maybe trying to <span class='love'>check you out?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You really check [A] out, maybe you should make a small emote for it too?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Blush at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>blushing at you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You can't help it but [A] is making you blush, hopefully they noticed and maybe you should make a short emote?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Sniff them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>sniff you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You can't help it, [A] smells so good that you try to Touch - Sniff them.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Coo at them.")
			to_chat(A, span_notice("[src] sounds like they're <span class='cooing at you?'>advance.</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You make soft noises at [A], trying to dote on them with words. Maybe make an emote for it?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Pinch them.")
			to_chat(A, span_notice("[src] is reaching to <span class='love'>pinch you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to pinch [A], maybe they'll notice you trying to be frisky!")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Caress them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>caress you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to caress [A], if they let you maybe you should clarify where in a small emote?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Brush against them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>brush closely up against you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to brush up against [A], hopefully they'll let you. Maybe clarify in what way?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grope them generically.")
			to_chat(A, span_notice("[src] is seemingly trying to <span class='love'>grope you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?")) 
			to_chat(user, "You attempt to be handsy and grope [A], if they let you maybe clarify where?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grope their bottom.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your ass?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?")) 
			to_chat(user, "You try to play grabass with [A], if they let you. ")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grope their side.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grope your side playfully?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?")) 
			to_chat(user, "You try to grab [A]\'s' side brisky.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Kissy face at them.")
			to_chat(A, span_notice("[src] is making a <span class='love'>kissy face at you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You make a goofy kissy face at [A], maybe they'll take the bait?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Offer a kiss to them.")
			to_chat(A, span_notice("[src] is pursing their lips, <span class='love'>maybe they want you to kiss them?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You offer [A] a kiss, maybe they'll take the bait?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Wink at them.")
			to_chat(A, span_notice("[src] is <span class='love'>winking at you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You wink at [A], hopefully they noticed your forwardness.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Waggle fingers at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>waggling their fingers at you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You waggle a finger at [A] teasingly.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Lean on them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>lean on you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to lean on [A], maybe make an emote if they let you?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Snuggle into them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>snuggle up against you?</span> Remember to honor their OOC preferences and maybe give them a response?"))
			to_chat(user, "You try to snuggle up against [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Kiss them lightly on the cheek.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>lightly kiss your cheek?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to kiss [A] lightly on the cheek.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Try to steal a deep kiss.")
			to_chat(A, span_notice("[src] is trying to steel <span class='love'>a deep kiss?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to go in for a deep kiss on [A]!")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Try to steal a light kiss.")
			to_chat(A, span_notice("[src] is trying <span class='love'>to steal a light kiss?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to steal a light kiss from [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Smile at them subtly.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>smiling at you subtly?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> but <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You smile at [A] subtly. Hopefully they noticed.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Smile at them provocatively.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>giving you a rakish smile?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You smile at [A] provocatively, hopefully they noticed.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Play with your hair.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>playing with their hair as they watch you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "Something about [A] makes you feel the need to play with your hair, maybe they'll notice the effect they have on you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Bite your own lower lip.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>biting their lower lip while watching you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You can't help it but [A] made you bite your lower lip, maybe they'll notice the effect they have on you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Give them the side-eye.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>watching you intently but trying to hide it?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You look at [A] sideways, smiling a bit as you do so. Maybe they'll notice your attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Push your backside into them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>press their backside to you?</span> Remember to honor their OOC preference sbut <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try press your rump against [A], hopefully they want it.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Touch them on 'accident.'")
			to_chat(A, span_notice("[src] is trying to <span class='love'>touch you and make it look like an accident to get your attention?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to touch [A] and make it look like an accident. Hopefully they realize it wasn't one.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Softly bite their ear.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>nibble your ear!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to playfully nibble [A]\'s' ear. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Nuzzle their neck.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>nuzzle into your neck!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to nuzzle into [A]\'s' neck. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Bite their neck.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>bite your neck!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to bite [A]\'s' neck. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Hold hands with them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>hold your hand</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to hold [A]\'s hand. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Fondle their chest/breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>fondle your chest, or breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to fondle [A]\'s chest or breasts. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Touch their crotch.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>lay a hand on your lap.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to lay a hand on [A]\'s' crotch. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Heavy pet them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>rub your lap.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to rub [A]\'s' crotch. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Stare at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>staring at you openly and with clear interest.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You can't help but stare at [A], maybe they'll notice.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Avoid looking at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>trying a little too hard not to look at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You desperately try to not look at [A], hopefully they won't notice \<Lie.\>.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Openly look at their assets.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>staring a bit too hard at whatever assets you have on display</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try but can't pull your eyes away from [A]\'s visible assets', hopefully they won't notice \<Lie.\>.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Fail to pickpocket.")
			to_chat(A, span_notice("[src] is trying to put a hand in one of your pockets <span class='love'>but is going to grab you somewhere instead!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to steal something from [A] but you're about to cop a feel, hopefully they won't notice!")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Raise an eyebrow at them.")
			to_chat(A, span_notice("[src] just <span class='love'>rose an eyebrow at you, clearly they're curious.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You can't help but quirk a brow at [A], maybe they'll notice your curiosity.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Loom over them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>loom over you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to loom over [A], maybe they'll care about it.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Pay them more attention.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>maybe pay you a bit too much attention?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pay [A] more attention, maybe they'll notice you care about them specifically.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Sneer at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>giving you the stink eye but... it feels off?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You sneer at [A] but don't really mean it. Tsundere moment.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Shove them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>shove you playfully.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You playfully shove [A] but don't really mean it. Tsundere moment.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Squeeze them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>give you a BIG hug.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to give [A] a big hug, because you like them more.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Play with their hair.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>play with your hair.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to play with [A]\'s' hair, maybe they'll let you?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Check them for wounds.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>check if you're hurt a little too closely.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to check [A] over, for wounds.  Not because you just want to look at them.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Corner them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>corner you against something.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to corner [A] against something, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their wrist.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your wrist.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to grab [A]\'s wrist, if they let you maybe.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Appear more demure to them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>appear more submissive.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to make yourself appear more submissive for [A], hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Bend over for them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>bend over and get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to bend over and get [A] to look at your behind, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Look heroic for them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>look cool specifically for you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pose a bit and look good for [A], hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Look like you need their help.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>look like they need your help.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to look like you need [A]\'s help, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their arm.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your arm.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to grab [A]\'s arm, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Pull their hair.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>pull your hair.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s hair, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their belt.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your belt or pants.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s to you by the belt or pants, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Squish your breasts together.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention with their cleavage.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention to you by making your cleavage super obvious, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Fold your arms under your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by framing their cleavage with an arm under it.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention to you by making your cleavage super obvious, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Draw attention to your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by doing something with their breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention to you breasts super obvious.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Play with your nipples sneakily.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by playing with their nipples sneakily.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by playing with your own nipples sneakily.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Play with your nipples openly.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by playing with their nipples openly.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by playing with your own nipples openly.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Mouth an object.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by mouthing an object.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by mouthing an object, maybe you should clarify what that object is?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Tongue in cheek.")
			to_chat(A, span_notice("[src] is trying to make you notice when they <span class='love'>press their tongue into their cheek coyly.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by pretending to perform oral.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Whine needily.")
			to_chat(A, span_notice("[src] is trying to make you notice when they <span class='love'>whine needily at them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by whining like a bitch in heat.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Touch their cheek.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>touch your cheek.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to touch [A]\'s cheek.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Pet them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>pet you affectionately.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pet [A]\'s head.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Sooth them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>soothe you by giving touches.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to softly sooth [A] over with soft touches.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Rub your thighs together.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>rubbing their thighs together as they look at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You rub your thighs together while looking at [A], hopefully they notice how they excite you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Try to hide your arousal.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>trying to hide that you have a serious sexual effect on them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try, and possibly fail, at hiding how much [A] is having an effect on your desire.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Touch your hand to your bosom.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>put their hand to their chest, did someting about you cause that?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You reflexively put your hand to your chest because [A] is just too much for you to handle.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Arms akimbo.")
			to_chat(A, span_notice("[src] might be looking at you <span class='love'>with their hands on their hips, and elbows out. Judgey.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You put your hands to your hips and stick your elbows out, judging [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Press your breasts against them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>press their breasts against you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to push your breasts agianst [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Press your crotch against them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>press their crotch against you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to push your crotch up against [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grind on their lap.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grind against your lap.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to grind against [A]\'s lap.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their nose.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your nose cutely, boop even.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly boop [A]\'s nose.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their Chest.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your chest to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s chest.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their breast.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your breast to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s breast.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their tummy.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your tummy to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s tummy.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their thigh.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your thigh to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s thigh.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Put a finger over their mouth.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>put a finger in front of your mouth to hush you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to make [A] hush by putting a finger over their mouth.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Dare them to 'make you' do something.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly mouthed the words \"Make me.\" at you under their breath.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly demand that [A] makes you do something.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Stare defiantly.")
			to_chat(A, span_notice("[src] might be looking at you <span class='love'with open, and sexually tense, defiance.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You stare at [A] defiantly, daring them to do something about it.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Ask them to touch you.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly asked for you to touch them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly ask that [A] touches you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Ask them to take you.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly asked for you to take them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly ask that [A] takes you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Ask them to kiss you.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly asked for you to kiss them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly ask that [A] kisses you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Verbally let them know you want them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly informed you that they \"want\" you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly inform [A] that you want them.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Verbally let them know you need them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly informed you that they \"need\" you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly inform [A] that you need them.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Flutter your eyelashes at them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>fluttered their eyelashes at you cutely.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You cutely flutter your eyelashes at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Tickle their nose with your tail.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>tickle your nose with their tail.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly tickle [A]\'s nose with your tail.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Lose your breath.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>lost their breath looking at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You gently lose your breath from looking at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Heave your bosom.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>heaved, their bosom lifting towards you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You heave your bosom at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Grin deviously.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>grinned at you deviously.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You grin deviously at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Stare at their crotch.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>stared at your crotch.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You stare at [A]\'s crotch.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Lick your lips.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>licked their lips while looking at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you lick your lips.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Purse your lips.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>pursed their lips thoughtfully while looking at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you purse your lips thoughtfully.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Shake from their touch.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>shook a little when you touched them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you shake from their previous touching.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Shudder from overstimulation.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>shuddered. Something you did might have overstimulated them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you shudder from something they did.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Gasp from something they did.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>gasped. Something you did might have had an effect on them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you gasp from something they did.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Moan at them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>moaned quietly. Something you did might have had an effect on them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you moan quietly from something they did.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Lid your eyes and watch them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>watching you behind their lidded eyes.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to watch [A] with your eyes lidded.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Sneak a peak at their assets.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>sneak a peak at your assets.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to look at [A]\'s assets without getting spotted.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Put their HAND between your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>put your HAND between their breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly place [A]\'s hand between your breasts.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Put their HEAD between your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>put your HEAD between their breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly place [A]\'s HEAD between your breasts.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Want to tell them something.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>wants to tell you something.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you make a face, you really want to tell them something important.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their hips.")
			to_chat(A, span_notice("[src] is maybe reaching to <span class='love'>grab your hips?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to grab [A]'s hips, but will they let you catch them so easily?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Pull their hair.")
			to_chat(A, span_notice("[src] is reaching to <span class='love'>pull your tail?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to pull [A]'s tail, maybe they'll notice you trying to be frisky!")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

			return
 */






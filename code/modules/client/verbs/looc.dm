GLOBAL_VAR_INIT(LOOC_COLOR, null)//If this is null, use the CSS for OOC. Otherwise, use a custom colour.
GLOBAL_VAR_INIT(normal_looc_colour, "#6699CC")

/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	/* if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return */

	if(!mob)
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	/* if(!(prefs.chat_toggles & CHAT_OOC))
		to_chat(src, span_danger("You have OOC muted."))
		return
	if(jobban_isbanned(mob, "OOC"))
		to_chat(src, span_danger("You have been banned from OOC."))
		return */

	if(!holder)
		//if(!GLOB.looc_allowed)
		//	to_chat(src, span_danger("LOOC is globally muted"))
		//	return
		//if(prefs.muted & MUTE_OOC)
		//	to_chat(src, span_danger("You cannot use OOC (muted)."))
		//	return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		//if(findtext(msg, "byond://"))
		//	to_chat(src, "<B>Advertising other servers is not allowed.</B>")
		//	log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
		//	return
		//if(mob.stat)
		//	to_chat(src, span_danger("You cannot use LOOC while unconscious or dead."))
		//	return
		//if(isdead(mob))
		//	to_chat(src, span_danger("You cannot use LOOC while ghosting or observing. If you previously died in the round, return to your body to be able to LOOC."))
		//	return
		//if(HAS_TRAIT(mob, TRAIT_LOOC_MUTE))
		//	to_chat(src, span_danger("You cannot use LOOC right now."))
		//	return


	msg = emoji_parse(msg)

	mob.log_talk(msg,LOG_OOC, tag="LOOC")
	var/msg_near = msg
	var/msg_far = span_rlooc(msg)

	var/list/heard = get_hearers_in_view(7, get_top_level_mob(src.mob))
	for(var/mob/M in heard)
		if(!M.client)
			continue
		var/client/C = M.client
		if (C in GLOB.admins)
			continue //they are handled after that

		if (isobserver(M))
			continue //Also handled later.
		//wherever you aaaare

		to_chat(C, span_prefix("<span class='looc'><span class='prefix'>LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg_near]</span></span>"))

	for(var/client/C in GLOB.admins)
		if (C.mob in heard)
			continue // yeah this is kinda scuffed.
		
		if(!(C.prefs.chat_toggles & CHAT_REMOTE_LOOC))
			continue

		to_chat(C, span_prefix("<span class='looc'>[ADMIN_FLW(usr)] <span class='prefix'><span class='rlooc'>>R>: <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg_far]</span></span>"))

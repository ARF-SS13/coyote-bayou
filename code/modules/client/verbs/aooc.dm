GLOBAL_VAR_INIT(AOOC_COLOR, null)//If this is null, use the CSS for OOC. Otherwise, use a custom colour.
GLOBAL_VAR_INIT(normal_aooc_colour, "#ce254f")

/client/verb/aooc(msg as text)
	set name = "AOOC"
	set desc = "An OOC channel exclusive to anonymous communication."
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(src, span_danger("Speech is currently admin-disabled."))
		return

	if(!(prefs.chat_toggles & CHAT_AOOC))
		to_chat(src, span_danger(" You have AnonOOC muted."))
		return

	if(mob && jobban_isbanned(mob, "OOC"))
		to_chat(src, span_danger("You have been banned from OOC."))
		return

	if(!holder)
		if(!GLOB.aooc_allowed)
			to_chat(src, span_danger("AOOC is currently muted."))
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, span_danger("You cannot use AOOC (muted)."))
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return
		if(mob && HAS_TRAIT(mob, TRAIT_AOOC_MUTE))
			to_chat(src, span_danger("You cannot use AOOC right now."))
			return

	if(QDELETED(src))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	var/raw_msg = msg

	if(!msg)
		return

	msg = emoji_parse(msg)

	if(!holder)
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in AOOC: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in AOOC: [msg]")
			return
	mob?.log_talk(raw_msg,LOG_OOC, tag="(AOOC)")

	var/clientstosendto = list()
	for(var/client/C in GLOB.clients)
		if((C.prefs.chat_toggles & CHAT_AOOC))
			clientstosendto |= C

	for(var/client/C in clientstosendto)
		if(!C || !istype(C))
			continue
		if(C.holder && check_rights_for(C, R_ADMIN))//If the listening client is a staff member with admin privs
			if(GLOB.AOOC_COLOR)
				to_chat(C, "<font color='[GLOB.AOOC_COLOR]'><span class='prefix'>AnonOOC:</span> <EM>[GetOOCName()]/[holder?.fakekey ? "/([holder.fakekey])" : "[key]"] [ADMIN_PP(src.mob)]:</EM> <span class='message linkify'>[msg]</span></span></font>")
			else
				to_chat(C, "<span class='antagooc'><span class='prefix'>AnonOOC:</span> <EM>[GetOOCName()]/[holder?.fakekey ? "/([holder.fakekey])" : "[key]"] [ADMIN_PP(src.mob)]:</EM> <span class='message linkify'>[msg]</span></span></font>")
		else
			if(GLOB.AOOC_COLOR)
				to_chat(C, "<font color='[GLOB.AOOC_COLOR]'><b><span class='prefix'>AnonOOC:</span> <EM>Somebody:</EM> <span class='message linkify'>[msg]</span></b></font>")
			else
				to_chat(C, "<span class='antagooc'><span class='prefix'>AnonOOC:</span> <EM>Somebody:</EM> <span class='message linkify'>[msg]</span></span>")

/client/proc/set_aooc(newColor as color)
	set name = "Set AnonOOC Color"
	set desc = "Modifies AnonOOC Color"
	set category = "Fun"
	GLOB.AOOC_COLOR = sanitize_ooccolor(newColor)

/client/proc/reset_aooc()
	set name = "Reset AnonOOC Color"
	set desc = "Returns AnonOOC Color to default"
	set category = "Fun"
	GLOB.AOOC_COLOR = null

/proc/toggle_aooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling ooc
		if(toggle != GLOB.aooc_allowed)
			GLOB.aooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.aooc_allowed = !GLOB.aooc_allowed

	for(var/client/C in GLOB.clients)
		if(!C || !istype(C))
			continue
		to_chat(C, "<B>The Anonymous OOC channel has been [GLOB.aooc_allowed ? "enabled. If you're seeking scenes or just shitposting you can access it through the \"AOOC\" verb." : "disabled"].</B>")

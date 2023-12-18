GLOBAL_VAR_INIT(NEWBIE_COLOR, null)//If this is null, use the CSS for NEWBIE. Otherwise, use a custom colour.
GLOBAL_VAR_INIT(normal_newbie_colour, "#ff00dd")

/client/verb/newbie(msg as text)
	set name = "HELP" 
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	if(!holder)
		if(!GLOB.ooc_allowed)
			to_chat(src, span_danger("NEWBIE is globally muted."))
			return
		if(!GLOB.dooc_allowed && (mob.stat == DEAD))
			to_chat(usr, span_danger("NEWBIE for dead mobs has been turned off."))
			return
		if(prefs.muted & MUTE_NEWBIE)
			to_chat(src, span_danger("You cannot use NEWBIE/HELP (muted)."))
			return
	if(jobban_isbanned(src.mob, "NEWBIE"))
		to_chat(src, span_danger("You have been banned from NEWBIE/HELP."))
		return
	if(QDELETED(src))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	var/raw_msg = msg

	if(!msg)
		return

	msg = emoji_parse(msg)

	if((msg[1] in list(".",";",":","#")) || findtext_char(msg, "say", 1, 5))
		if(alert("Your message \"[raw_msg]\" looks like it was meant for in game communication, say it in NEWBIE?", "Meant for NEWBIE?", "No", "Yes") != "Yes")
			return

	if(!holder)
		if(handle_spam_prevention(msg,MUTE_NEWBIE))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in NEWBIE/HELP: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in NEWBIE/HELP: [msg]")
			return

	if(!(prefs.chat_toggles & CHAT_NEWBIE))
		to_chat(src, span_danger("You have NEWBIE muted."))
		return

	mob.log_talk(raw_msg, LOG_OOC, tag="(NEWBIE)")

//	var/keyname = key // commented it out for people to be aware how to revert it. Just delete the edit below <3

	// main edit here - Changes it to IC name instead of key in NEWBIE messages.
	var/keyname = GetNEWBIEName()

	if(!keyname)
		return
	// edit end here

	if(prefs.unlock_content)
		if(prefs.toggles & MEMBER_PUBLIC)
			keyname = "<font color='[prefs.ooccolor ? prefs.ooccolor : GLOB.normal_newbie_colour]'>[icon2html('icons/member_content.dmi', world, "blag")][keyname]</font>"
	//The linkify span classes and linkify=TRUE below make newbie text get clickable chat href links if you pass in something resembling a url
	for(var/client/C in GLOB.clients)
		if(C.prefs.chat_toggles & CHAT_NEWBIE)
			if(check_rights_for(C, R_ADMIN))
				keyname = "[key]/[GetNEWBIEName()]"
			else
				keyname = GetNEWBIEName()
			
			if(holder)
				if(!holder.fakekey || C.holder)
					if(check_rights_for(src, R_ADMIN))
						to_chat(C, "<span class='adminnewbie'>[CONFIG_GET(flag/allow_admin_ooccolor) && prefs.ooccolor ? "<font color=[prefs.ooccolor]>" :"" ]<span class='prefix'>NEWBIE/HELP:</span> <EM>[holder.fakekey ? "/([holder.fakekey])" : "[key]"]:</EM> <span class='message linkify'>[msg]</span></span></font>")
					else
						to_chat(C, "<span class='adminobservernewbie'><span class='prefix'>NEWBIE/HELP:</span> <EM>[holder.fakekey ? "/([holder.fakekey])" : "[key]"]:</EM> <span class='message linkify'>[msg]</span></span>")
				else
					if(GLOB.NEWBIE_COLOR)
						to_chat(C, "<font color='[GLOB.NEWBIE_COLOR]'><b><span class='prefix'>NEWBIE/HELP:</span> <EM>[holder.fakekey ? holder.fakekey : key]:</EM> <span class='message linkify'>[msg]</span></b></font>")
					else
						to_chat(C, span_purple("<span class='prefix'>NEWBIE/HELP:</span> <EM>[holder.fakekey ? holder.fakekey : key]:</EM> <span class='message linkify'>[msg]</span>"))
			else if(!(key in C.prefs.ignoring))
				if(GLOB.NEWBIE_COLOR)
					to_chat(C, "<font color='[GLOB.NEWBIE_COLOR]'><b><span class='prefix'>NEWBIE/HELP:</span> <EM>[keyname]:</EM> <span class='message linkify'>[msg]</span></b></font>")
				else
					to_chat(C, span_purple("<span class='prefix'>NEWBIE/HELP:</span> <EM>[keyname]:</EM> <span class='message linkify'>[msg]</span>"))

/proc/toggle_newbie(toggle = null)
	if(toggle != null) //if we're specifically en/disabling newbie
		if(toggle != GLOB.ooc_allowed)
			GLOB.ooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.ooc_allowed = !GLOB.ooc_allowed
	to_chat(world, "<B>The NEWBIE channel has been globally [GLOB.ooc_allowed ? "enabled" : "disabled"].</B>")





/client/proc/GetNEWBIEName()
	if(iscarbon(mob)) // If mob is null I'll be very surprised, worse case, add a sanity check if this becomes an issue in the future.
		return mob.real_name
	else
		return prefs.real_name

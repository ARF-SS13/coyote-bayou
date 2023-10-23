// overridden by code\modules\client\verbs\who.dm, don't read this code ;)
// Author: Gremling
// Goal: Redo the who.dm procs to be more up to date with TG + refactored to allow Ckeys to be shown to admins plus some useful buttons to use.
// Relevant Meme: https://youtu.be/8B8On0__AJs
// Unrelated meme: https://youtu.be/2SBMcyZdP0k



/client/who()
	set name = "Who"
	set category = "OOC"

	var/msg = ""

	var/list/Lines = list()
	var/list/assembled = list()
	var/admin_mode = check_rights_for(src, R_ADMIN) // && isobserver(mob)
	if(admin_mode)
		log_admin("[key_name(usr)] checked advanced who in-round")
	if(length(GLOB.admins))
		Lines += "<b>Admins:</b>"
		for(var/X in GLOB.admins)
			var/client/C = X
			if(C && C.holder && !C.holder.fakekey)
				assembled += "\t <font color='#FF0000'>[C.key]</font>[admin_mode? "[show_admin_info(C)]":""]"
		Lines += sortList(assembled)
	assembled.len = 0
	if(length(GLOB.mentors))
		Lines += "<b>Mentors:</b>"
		for(var/X in GLOB.mentors)
			var/client/C = X
			if(C && (!C.holder || (C.holder && !C.holder.fakekey)))			//>using stuff this complex instead of just using if/else lmao
				assembled += "\t <font color='#0033CC'>[C.key]</font>[admin_mode? "[show_admin_info(C)]":""]"
		Lines += sortList(assembled)
	assembled.len = 0
	Lines += "<b>Players:</b>"
	for(var/X in sortList(GLOB.clients))
		var/client/C = X
		if(!C)
			continue
		// Our main changes!
		var/charName = "Error!"
		if(iscarbon(C.mob)) // If C.mob is null I'll be very surprised, worse case, add a sanity check if this becomes an issue in the future.
			charName = C.mob.real_name
		else
			charName = C.prefs.real_name
		
		if(charName == "Error!") // Just some dummy way to make sure charName is atleast not null when used.
			stack_trace("charName did not update with the client's character name!")
			return // Hmm, something really went wrong, lets just not show this guy on the who list.
		


		assembled += "\t [admin_mode? (C.key + " - "):""][charName][show_sum_info(C, admin_mode)] [C.statusMessage? ("@ " + C.statusMessage) : ""]"
	Lines += sortList(assembled)
	
	for(var/line in Lines)
		msg += "[line]\n"

	msg += "<b>Total Players: [length(GLOB.clients)]</b>\n" 
	msg += "You can set your OOC Status with the 'set-status' verb in OOC Tab. Use it to help find roleplay/let people know you're afk!"
	to_chat(src, msg)

/client/proc/show_sum_info(client/C, _adminStatus) // A parody to show_admin_info, except it shows some, but not all. <3 
	if(!C)
		return ""

	var/entry = ""
	if (isnewplayer(C.mob))
		entry += " - <font color='darkgray'><b>In Lobby</b></font>"
	else if(isobserver(C.mob) && !_adminStatus) // I hate making long chains but yea.
		var/mob/dead/observer/O = C.mob
		if(O.started_as_observer)
			entry += " - <font color='gray'>Observing</font>"
		else
			entry += " - Playing" // just cause im lazy and cba trying to find a fix for this.
	else
		entry += " - Playing"
		if(_adminStatus)
			switch(C.mob.stat)
				if(UNCONSCIOUS)
					entry += " - <font color='darkgray'><b>Unconscious</b></font>"
				if(DEAD)
					if(isobserver(C.mob))
						var/mob/dead/observer/O = C.mob
						if(O.started_as_observer)
							entry += " - <font color='gray'>Observing</font>"
						else
							entry += " - <font color='black'><b>DEAD</b></font>"
					else
						entry += " - <font color='black'><b>DEAD</b></font>"
			if(is_special_character(C.mob))
				entry += " - <b><font color='red'>Antagonist</font></b>"

	if(_adminStatus)
		entry += " (<A HREF='?_src_=holder;[HrefToken()];adminmoreinfo=\ref[C.mob]'>?</A>)"
	return entry

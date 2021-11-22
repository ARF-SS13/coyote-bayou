GLOBAL_LIST_INIT(staff_verbs, list(
	/client/proc/cmd_staff_say
	))
GLOBAL_PROTECT(staff_verbs)
GLOBAL_LIST_EMPTY(staff)
GLOBAL_PROTECT(staff)
/client/proc/add_staff_verbs()
	if(is_staff())
		add_verb(src, GLOB.staff_verbs)

/client/proc/remove_staff_verbs()
	remove_verb(src, GLOB.staff_verbs)


/client/proc/cmd_staff_say(msg as text)
	set category = "OOC"
	set name = "Schat" //Gave this shit a shorter name so you only have to time out "msay" rather than "mentor say" to use it --NeoFite
	set hidden = 1
	if(!is_staff())
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	msg = emoji_parse(msg)
	log_mentor("STAFFCHAT: [key_name(src)] : [msg]")

	if(check_rights_for(src, R_ADMIN,0))
		msg = "<span class='mentorsay_admin filter_MSAY'><span class='prefix'>STAFF CHAT:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></span>"
	else
		msg = "<span class='mentorsay filter_MSAY'><span class='prefix'>STAFF CHAT:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></span>"
	to_chat(GLOB.admins | GLOB.staff, msg, confidential = TRUE)

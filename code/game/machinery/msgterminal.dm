/******************** Message Terminal ********************/
/** Ported and condensed version of requests_console.dm using existing telecomms setup. */

GLOBAL_LIST_EMPTY(NCR_req_terminal)

GLOBAL_LIST_EMPTY(LEGION_req_terminal)

GLOBAL_LIST_EMPTY(req_terminal)

GLOBAL_LIST_EMPTY(terminal_info)
GLOBAL_LIST_EMPTY(allTerminals)

#define NO_NEW_MESSAGE				0
#define NORMAL_MESSAGE_PRIORITY 	1
#define HIGH_MESSAGE_PRIORITY		2
#define EXTREME_MESSAGE_PRIORITY	3 // is implimented, does require hacking. everything needs to have a hidden feature in this game.

/obj/machinery/msgterminal
	name = "communications center"
	desc = "Where mail is sent and received."
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"
	plane = ABOVE_WALL_PLANE
	var/terminalid = ""
	var/beepsound = 'sound/effects/printer.ogg'
	var/terminal = "terminal" //The list of all terminals on the station (Determined from this variable on each unit) Set this to the same thing if you want several consoles in one terminal
	var/list/messages = list() //List of all messages
	var/terminalType = 2
		// 1 = unused for now
		// 2 = ncr + legion
	var/newmessagepriority = NO_NEW_MESSAGE
	var/screen = 0
		// 0 = main menu,
		// 1 = req. assistance,
		// 2 = req. supplies
		// 3 = relay information
		// 4 = write msg - not used
		// 5 = choose priority - not used
		// 6 = sent successfully
		// 7 = sent unsuccessfully
		// 8 = view messages
		// 9 = authentication before sending
		// 10 = send announcement
	var/silent = FALSE // set to 1 for it not to beep all the time
	var/hackState = FALSE
	var/announcementConsole = FALSE // FALSE = This console cannot be used to send terminal announcements, TRUE = This console can send terminal announcements
	var/open = FALSE // TRUE if open
	var/message = ""
	var/dpt = "" //the terminal which will be receiving the message
	var/priority = NORMAL_MESSAGE_PRIORITY //Priority of the message being sent. why is the default -1??
	max_integrity = 300
	armor = list("melee" = 70, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)

/obj/machinery/msgterminal/power_change()
	..()
	update_icon()

/obj/machinery/msgterminal/update_icon_state()
	if(CHECK_BITFIELD(stat, NOPOWER))
		set_light(0)
	else
		set_light(1.4, 0.7, "#ffda37")

/obj/machinery/msgterminal/Initialize()
	. = ..()
	GLOB.allTerminals += src
	switch(terminalType)
		if(1)
			if(!("[terminal]" in GLOB.req_terminal))
				GLOB.req_terminal += terminal
		if(2)
			if(!("[terminal]" in GLOB.req_terminal))
				GLOB.req_terminal += terminal
		if(3) // command reply terminals that we dont want listed
			if("[terminal]" in GLOB.req_terminal)
				GLOB.req_terminal -= terminal

/obj/machinery/msgterminal/Destroy()
	GLOB.allTerminals -= "[terminal]"
	GLOB.req_terminal -= "[terminal]"
	return ..()

/obj/machinery/msgterminal/ui_interact(mob/user)
	. = ..()
	if(open) 
		return
	var/dat = ""
	dat += "<head><style>body {padding: 0; margin: 15px; background-color: #062113; color: #4aed92; line-height: 170%;} a, button, a:link, a:visited, a:active, .linkOn, .linkOff {color: #4aed92; text-decoration: none; background: #062113; border: none; padding: 1px 4px 1px 4px; margin: 0 2px 0 0; cursor:default;} a:hover {color: #062113; background: #4aed92; border: 1px solid #4aed92} a.white, a.white:link, a.white:visited, a.white:active {color: #4aed92; text-decoration: none; background: #4aed92; border: 1px solid #161616; padding: 1px 4px 1px 4px; margin: 0 2px 0 0; cursor:default;} a.white:hover {color: #062113; background: #4aed92;} .linkOn, a.linkOn:link, a.linkOn:visited, a.linkOn:active, a.linkOn:hover {color: #4aed92; background: #062113; border-color: #062113;} .linkOff, a.linkOff:link, a.linkOff:visited, a.linkOff:active, a.linkOff:hover{color: #4aed92; background: #062113; border-color: #062113;}</style></head><font face='courier'>"
	dat += "<center><b>ROBCO INDUSTRIES UNIFIED OPERATING SYSTEM v.85</b><br>"
	dat += "<b>COPYRIGHT 2075-2077 ROBCO INDUSTRIES</b><br><br><br><br>"

	
	playsound(src, 'sound/f13machines/terminalkeytap01.ogg', 20, 1)
	switch(screen)
		if(1)	//choose your target
			dat += "Select Recipient<br><br>"
			dat += "<table width='100%'>"
			for(var/dpt in GLOB.req_terminal)
				if(dpt == terminal)
					continue
				dat += "<tr>"
				dat += "<td width='55%'>[dpt]</td>"
				dat += "<td width='45%'>"
				dat += "<a href='?src=[REF(src)];write=[ckey(dpt)];priority=1'>Normal</a>"
				dat += "<a href='?src=[REF(src)];write=[ckey(dpt)];priority=2'>High</a>"
				if(hackState)
					dat += "<a href='?src=[REF(src)];write=[ckey(dpt)];priority=3'>EXTREME</a>"
				dat += "</td>"
				dat += "</tr>"
			dat += "<tr>"
			dat += "<td width='55%'>"
			if(src.terminalid == "brotherhood")	
				dat += "<br>Circle of Steel"
			if(src.terminalid == "legion")	
				dat += "<br>Cohort War Council of Southwestern Arizona"
			if(src.terminalid == "ncr")	
				dat += "<br>Arizona Command Camp Alexander"
			dat += "</td>"
			dat += "<td width='45%'>"
			dat += "<br><A href='?src=[REF(src)];setScreen=11'>Send Message to Command</A><br>"
			dat += "</td>"
			dat += "</tr>"

			dat += "</table>"
			dat += "<br><A href='?src=[REF(src)];setScreen=0'><< Back</A><br>"
			dat += "<br><div class='panel redborder'><span class='redtext'>(( NOTE: Do not misuse this terminal to send harassing, joke or meme messages to other factions or groups in the terminal list. ))</span></div><br>"
			

		if(3)	//relay information
			dat += "Who would you like to send a message to?<br><br>"
			dat += "<table width='100%'>"
			for(var/dpt in GLOB.terminal_info)
				if(dpt == terminal)
					continue
				dat += "<tr>"
				dat += "<td width='55%'>[dpt]</td>"
				dat += "<td width='45%'>"
				dat += "<a href='?src=[REF(src)];write=[ckey(dpt)];priority=1'>Normal</a>"
				dat += "<a href='?src=[REF(src)];write=[ckey(dpt)];priority=2'>High</a>"
				if(hackState)
					dat += "<a href='?src=[REF(src)];write=[ckey(dpt)];priority=3'>EXTREME</a>"
				dat += "</td>"
				dat += "</tr>"
			dat += "</table>"
			dat += "<br><a href='?src=[REF(src)];setScreen=0'><< Back</a><br>"

		if(6)	//sent successfully
			playsound(src, 'sound/f13machines/terminalmenuenter.ogg', 20, 1)
			dat += "<span class='good'>Message delivered.</span><br><br>"
			dat += "<a href='?src=[REF(src)];setScreen=0'>Continue</a><br>"

		if(7)	//unsuccessful; not sent
			dat += "<span class='bad'>An error occurred.</span><br><br>"
			dat += "<a href='?src=[REF(src)];setScreen=0'>Continue</a><br>"

		if(8)	//view messages
			for(var/obj/machinery/msgterminal/Console in GLOB.allTerminals)
				if(Console.terminal == terminal)
					Console.newmessagepriority = NO_NEW_MESSAGE
					Console.update_icon()

			newmessagepriority = NO_NEW_MESSAGE
			update_icon()
			var/messageComposite = ""
			for(var/msg in messages) // This puts more recent messages at the *top*, where they belong.
				messageComposite = "<div class='block'>[msg]</div>" + messageComposite
			dat += messageComposite
			dat += "<br><a href='?src=[REF(src)];setScreen=0'><< Back to Main Menu</a><br>"

		if(9)	//authentication before sending
			dat += "<b>Message Confirmation</b> <br><br>"
			dat += "<b>Message for [uppertext(dpt)]:</b><br><div class='panel redborder'> <font size=1>[message]</font> </div><br><br>"
			dat += "<div class='panel redborder'>Are you sure you want to send this message?</div> <br>"
			dat += "<a href='?src=[REF(src)];terminal=[dpt]'>Send Message</a> <br><br>"
			dat += "<a href='?src=[REF(src)];setScreen=0'><< Discard Message</a> <br>"

		if(10) //unused for now but may be useful later
			dat += "<b>Message to Command</b> <br><br>"
			if(src.terminalid == "ncr")
				dat += "<b>Arizona Command Camp Alexander</b> <br><br>"
			if(src.terminalid == "legion")
				dat += "<b>Cohort War Council of Southwestern Arizona</b> <br><br>"
			if(src.terminalid == "brotherhood")
				dat += "<b>Circle of Steel</b> <br><br>"
			dat += "<a href='?src=[REF(src)];setScreen=11'>Send Message to Command</a> <br><br>"
		if(11)
			var/message = input(usr,"Send a message to command staff. Ensure it makes sense IC.","") as message|null
			if(message)
				message_admins("[ADMIN_LOOKUPFLW(usr)] has sent <font size=2>COMMAND MESSAGE</font> FROM terminal:[ADMIN_LOOKUPFLW(src)]. '[message]' <br>Jump to the reply terminal:[ADMIN_JMP_MSGTERMINAL(src)]")
				log_terminal("[key_name(usr)] sent a COMMAND message, '[message]' from the terminal at [AREACOORD(usr)].")
				screen = 6
				dat += "<span class='good'>Message to Command delivered.</span><br><br>"
				updateUsrDialog()
				playsound(src, 'sound/f13machines/terminalmenuenter.ogg', 20, 1)
			else
				screen = 7
				dat += "<span class='bad'>Message to Command aborted.</span><br><br>"
				updateUsrDialog()
				playsound(src, 'sound/f13machines/terminalmenucancel.ogg', 20, 1)
			dat += "<a href='?src=[REF(src)];setScreen=0'>Continue</a><br>"
		else	//main menu
			screen = 0
			if(newmessagepriority == NORMAL_MESSAGE_PRIORITY)
				dat += "<div class='notice'>There are new messages</div><br>"
			if(newmessagepriority == HIGH_MESSAGE_PRIORITY)
				dat += "<div class='notice'>There are new <b>PRIORITY</b> messages</div><br>"
			if(newmessagepriority == EXTREME_MESSAGE_PRIORITY)
				dat += "<div class='notice'>There are new <b>EXTREME PRIORITY</b> messages</div><br>"

			dat += "<a href='?src=[REF(src)];setScreen=8'>View Messages</a> <br><br>"

			dat += "<a href='?src=[REF(src)];setScreen=1'>Send Message</a> <br>"
			if(silent)
				dat += "(( Sound effects <a href='?src=[REF(src)];setSilent=0'>OFF</a> ))"
			else
				dat += "(( Sound effects <a href='?src=[REF(src)];setSilent=1'>ON</a> ))"

	var/datum/browser/popup = new(user, "req_console", "[terminal]")
	popup.set_content(dat)
	popup.open()

/obj/machinery/msgterminal/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["write"])
		dpt = ckey(reject_bad_text(href_list["write"])) //write contains the string of the receiving terminal's name
		var/new_message = input(usr, "Enter your message for [uppertext(dpt)]. Ensure it makes sense IC.", "Distant Communication", "") as message|null
		if(new_message)
			message = new_message
			screen = 9
			priority = text2num(href_list["priority"])
			log_terminal("[key_name(usr)] sent '[message]' from the terminal at [AREACOORD(usr)].")
		else
			dpt = "";
			screen = 0
			priority = NORMAL_MESSAGE_PRIORITY
		
	if(href_list["terminal"] && message)
		var/sending = message
		sending += "<br>"

		var/workingServer = FALSE
		var/datum/data_rc_msg/log = new(href_list["terminal"], terminal, message, priority)
		for(var/obj/machinery/telecomms/message_server/MS in GLOB.telecomms_list)
			if(MS.on) // message server on
				LAZYADD(MS.rc_msgs, log)
				workingServer = TRUE

		if(!workingServer) //can probably remove this but it currently allows us a framework to potentially make communication outage events in the future
			screen = 7
			say("NOTICE: No server detected! Please contact your local engineering team.")
			updateUsrDialog()
			return

		var/alert = ""
		for(var/obj/machinery/msgterminal/C in GLOB.allTerminals)
			if(ckey(C.terminal) != ckey(href_list["terminal"]))
				continue
			switch(priority)
				if(HIGH_MESSAGE_PRIORITY)		//High priority
					alert = "PRIORITY Alert from [terminal]"
					C.createmessage(src, alert, sending, HIGH_MESSAGE_PRIORITY)
				if(EXTREME_MESSAGE_PRIORITY)	// Extreme Priority
					alert = "EXTREME PRIORITY Alert from [terminal]"
					C.createmessage(src, alert, sending, EXTREME_MESSAGE_PRIORITY)
				else		// Normal priority
					alert = "Message from [terminal]"
					C.createmessage(src, alert, sending, NORMAL_MESSAGE_PRIORITY)
			screen = 6 //if it ever gets here that means (c.terminal == href_ls["dept"])

		//log to (this)
		switch(priority)
			if(HIGH_MESSAGE_PRIORITY)
				messages += "<span class='bad'>High Priority</span><br><b><div class='panel redborder'>To:</b> <font size=1>[uppertext(dpt)]</font><br>[sending]</div>"
			if(EXTREME_MESSAGE_PRIORITY)
				messages += "<span class='bad'>!!!Extreme Priority!!!</span><br><b><div class='panel redborder'>To:</b> <font size=1>[uppertext(dpt)]</font><br>[sending]"
			else
				messages += "<div class='panel greenborder'><b>To:</b> <font size=1>[uppertext(dpt)]</font><br>[sending]</div>"


	//Handle screen switching
	switch(text2num(href_list["setScreen"]))
		if(null)	//skip
			updateUsrDialog()
			return
		if(1)		//send message
			screen = 1
		if(2)		//req. supplies
			screen = 2
		if(3)		//relay information
			screen = 3
//		if(4)		//write message
//			screen = 4
		if(5)		//choose priority
			screen = 5
		if(6)		//sent successfully
			screen = 6
		if(7)		//unsuccessfull; not sent
			screen = 7
		if(8)		//view messages
			screen = 8
		if(9)		//authentication
			screen = 9
		if(10)		//send to command
			screen = 10
		if(11)		//message admins
			screen = 11
		else		//main menu
			dpt = ""
			message = ""
			priority = NORMAL_MESSAGE_PRIORITY // :salt:
			screen = 0

	//Handle silencing the console
	if(href_list["setSilent"] == "1")
		silent = TRUE
	else
		silent = FALSE

	updateUsrDialog()
	return

/obj/machinery/msgterminal/say_mod(input, message_mode)
	if(spantext_char(input, "!", -3))
		return "blares"
	else
		. = ..()

/obj/machinery/msgterminal/createmessage(source, title, message, priority)
	var/linkedsender
	if(istype(source, /obj/machinery/msgterminal))
		var/obj/machinery/msgterminal/sender = source
		linkedsender = "<a href='?src=[REF(src)];write=[ckey(sender.terminal)]'>[sender.terminal]</a>"
	else
		capitalize(source)
		linkedsender = source
	capitalize(title)
	switch(priority)
		if(HIGH_MESSAGE_PRIORITY)		//High priority
			if(newmessagepriority < HIGH_MESSAGE_PRIORITY)
				newmessagepriority = HIGH_MESSAGE_PRIORITY
				update_icon()
			if(!silent)
				playsound(src, beepsound, 50, 1)
				say(title)
			messages += "<span class='bad'>High Priority</span><br><b>From:</b> [linkedsender]<br>[message]" //the fuck is this not being sent

		if(EXTREME_MESSAGE_PRIORITY)		// Extreme Priority
			if(newmessagepriority < EXTREME_MESSAGE_PRIORITY)
				newmessagepriority = EXTREME_MESSAGE_PRIORITY
				update_icon()
			//we ignore the silent option because this is !!!IMPORTANT!!!
			playsound(src, beepsound, 50, 1)
			say(title)
			messages += "<span class='bad'><b>!!!Extreme Priority!!!</span></b><br><b>From:</b> [linkedsender]<br>[message]"

		else		// Normal priority
			if(newmessagepriority < NORMAL_MESSAGE_PRIORITY)
				newmessagepriority = NORMAL_MESSAGE_PRIORITY
				update_icon()
			if(!silent)
				playsound(src, beepsound, 50, 1)
				say(title)
			messages += "<b>From:</b> <font size=1>[linkedsender]<br>[message]</font>"
	return ..()

/obj/machinery/msgterminal/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/wrench))
		if(anchored)
			to_chat(user, "<span class='notice'>You unsecure the terminal.</span>")
			anchored = FALSE
		else
			to_chat(user, "<span class='notice'>You secure the terminal.</span>")
			anchored = TRUE
		update_icon()
		return
	if(istype(O, /obj/item/crowbar))
		if(open)
			to_chat(user, "<span class='notice'>You close the maintenance panel.</span>")
			open = FALSE
		else
			to_chat(user, "<span class='notice'>You open the maintenance panel.</span>")
			open = TRUE
		update_icon()
		return
	if(istype(O, /obj/item/screwdriver))
		if(open)
			hackState = !hackState
			if(hackState)
				to_chat(user, "<span class='notice'>You modify the wiring.</span>")
			else
				to_chat(user, "<span class='notice'>You reset the wiring.</span>")
			update_icon()
		else
			to_chat(user, "<span class='warning'>You must open the maintenance panel first!</span>")
		return

#undef NO_NEW_MESSAGE
#undef NORMAL_MESSAGE_PRIORITY
#undef HIGH_MESSAGE_PRIORITY
#undef EXTREME_MESSAGE_PRIORITY

/obj/machinery/msgterminal/ncr
	terminalid = "ncr"
	terminal = "NCR Terminal"
	terminalType = 2

/obj/machinery/msgterminal/legion
	terminalid = "legion"
	icon = 'icons/obj/computer.dmi'
	icon_state = "pigeoncrate"
	terminal = "Legion Pigeon Carrier"
	terminalType = 2
	beepsound = 'sound/f13effects/pigeons.ogg'
/*
/obj/machinery/msgterminal/pigeon
	icon = 'icons/obj/computer.dmi'
	icon_state = "pigeoncrate"
	terminal = "PigeonCarrier"
	terminalType = 2
	beepsound = 'sound/f13effects/pigeons.ogg'


/obj/machinery/msgterminal/machined
	terminal = "Terminal"
	terminalType = 2
*/
/obj/machinery/msgterminal/oasis
	terminalid = "oasis"
	terminal = "Oasis Terminal"
	terminalType = 2

/obj/machinery/msgterminal/oasis/followers
	terminalid = "follower"
	terminal = "Oasis Followers Terminal"
	terminalType = 2

/obj/machinery/msgterminal/brotherhood
	terminalid = "brotherhood"
	terminal = "Brotherhood Communcations Terminal"
	terminalType = 2
/obj/machinery/msgterminal/command
	terminalid = "command"
	terminal = "COMMAND"
	terminalType = 3



// so admins can easily jump-to-area
/area/f13/commandconsole
	name = "Command Communications"

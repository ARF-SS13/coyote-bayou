/// Some kind of thing that makes people valid
#define VALIDBALL_DIST_FAR 45
#define VALIDBALL_DIST_CLOSE 15

//==========DAT FUKKEN MACGUFFIN===============
/obj/item/validball
	name = "mysterious keycard"
	desc = "At first glance, it looks like your every-day run of the mill old keycard, the kind most folks would slip under a table leg \
		and forget about. But, on closer inspection, it looks clean and well taken care of, not to mention <i>active</i>. \
		You might want to hold onto this thing!"
	icon = 'icons/obj/validball.dmi'
	icon_state = "keycard_gold" // Sarge MacGuffin Keycard
	w_class = WEIGHT_CLASS_NORMAL
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

	max_integrity = 250000
	armor = ARMOR_VALUE_PA
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/datum/weakref/he_who_is_valid
	var/list/valid_ckeys = list()
	var/activated = FALSE
	///weakref in case some goob destroys it
	var/datum/weakref/our_datum_thing
	var/autoreveal_time = 1 HOURS
	important = TRUE

/obj/item/validball/Initialize()
	. = ..()
	register_vb_datum()
	SSvalidball.valid_balls |= src

/obj/item/validball/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/stationloving, TRUE, TRUE, FALSE, COMMON_Z_LEVELS, TRUE)

/obj/item/validball/proc/roundstartify()
	addtimer(CALLBACK(src,PROC_REF(activate_the_validball)), autoreveal_time)

/obj/item/validball/proc/register_vb_datum()
	var/datum/validball_data_report/vb_datum = new
	vb_datum.register_your_product(src)
	our_datum_thing = WEAKREF(vb_datum)
	SSvalidball.vb_reports |= vb_datum

/obj/item/validball/proc/activate_the_validball()
	if(activated)
		return
	activated = TRUE
	START_PROCESSING(SSobj, src)
	visible_message(span_notice("[src]'s transmitter lets out a faint beep. Anyone with a signal divination device can see where this is!"))
	to_chat(world, span_danger("Be it by overheard rumor, or a sudden memory, you realize that the coveted keycards recently sent out their detection information. The hunt is on, for those that want to be a part of it. You can pick up a device to help find it in one of New Boston's shops vending machines. But remember, those who hunt open themselves up to a world of danger."))

/obj/item/validball/proc/update_holders(mob/holder)
	if(!ismob(holder))
		return
	if(!holder.ckey)
		return
	var/turf/right_herehere = get_turf(src)
	if(!our_datum_thing)
		message_admins("[src] at [ADMIN_VERBOSEJMP(right_herehere)] didn't have a validball datum associated!!!!!!. Validball is maybe not go!")
		return
	var/datum/validball_data_report/our_report = our_datum_thing.resolve()
	if(!istype(our_report))
		message_admins("[src] at [ADMIN_VERBOSEJMP(right_herehere)] didn't resolve anything from its validball datum thing weakref!!!!!!. Validball is maybe not go!")
		return
	our_report.update_ownership(holder)
	if(isweakref(he_who_is_valid))
		var/mob/validie = he_who_is_valid.resolve()
		if(validie == holder) // picking it back up
			holder.show_message(span_green("You maintain possession of \the [src]! Protect it at all costs!"))
		else
			holder.show_message(span_green("You've regained possession of \the [src]! Protect it at all costs!"))
			log_validball("[worldtime2text()] - [key_name(holder)] took possession of [src] from [key_name(validie)] in [AREACOORD(right_herehere)].")
	else
		holder.show_message(span_green("You've gained possession of \the [src]! Protect it at all costs!"))
		log_validball("[worldtime2text()] - [key_name(holder)] took possession of [src] for the first time at [AREACOORD(right_herehere)].")
	valid_ckeys |= holder.ckey
	he_who_is_valid = WEAKREF(holder)

/obj/item/validball/equipped(mob/user, slot)
	if(ismob(user))
		update_holders(user)
		activate_the_validball()
	. = ..()

/obj/item/validball/process()
	if(!QDELETED(src) && isturf(get_turf(src)))
		SEND_SIGNAL(src, COMSIG_ITEM_PROCESS)

/obj/item/validball/Destroy(force=FALSE)
	STOP_PROCESSING(SSobj, src)
	var/datum/validball_data_report/our_report = our_datum_thing.resolve()
	var/turf/right_heretwo = get_turf(src)
	if(!istype(our_report))
		message_admins("[src] at [ADMIN_VERBOSEJMP(right_heretwo)] didn't resolve anything from its validball datum thing weakref!!!!!!. Its also being deleted, so Validball is definitely not go!")
	var/mob/toucher = he_who_is_valid?.resolve()
	message_admins("[src] at [ADMIN_VERBOSEJMP(right_heretwo)] was destroyed, last touched by [toucher]! Validball is no longer go!!")
	our_report.set_be_destroyed()
	our_datum_thing = null
	he_who_is_valid = null
	SSvalidball.valid_balls -= src
	. = ..()

// valid valid ball v-valid valid ball finder
/obj/item/pinpointer/validball_finder
	name = "signal divination device"
	desc = "A hobby-made locator device, tuned to a range of proprietary signal frequencies believed to belong to powerful ancient artifacts. \
		While the scanner is able to detect its target through walls, it has a fairly short range, limited to around a square kilometer. \
		Rumor has it, this thing will point its user toward an object of unimaginable wealth, or power, or... something, the rumors were never \
		all too clear, but whatever it is has to be worth it, right?\
		<br>Alt-click to emit an active scan pulse."
	icon = 'icons/obj/device.dmi'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/currently_scanning = FALSE
	var/scan_time = 5 SECONDS
	var/datum/weakref/scan_turf
	var/list/papers = list()
	var/max_paper = 5
	var/start_paper = 5

/obj/item/pinpointer/validball_finder/Initialize()
	. = ..()
	for(var/i in 1 to start_paper)
		papers += new /obj/item/paper(src)

/obj/item/pinpointer/validball_finder/AltClick(mob/user)
	. = ..()
	playsound(src, 'sound/machines/click.ogg', 30, 1)
	send_scan_ping(user)

/obj/item/pinpointer/validball_finder/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/paper))
		add_paper(W, user)

/obj/item/pinpointer/validball_finder/proc/add_paper(obj/item/paper/ppr, mob/user)
	if(!istype(ppr))
		user.show_message(span_alert("That's not paper!"))
		return FALSE
	if(LAZYLEN(papers) >= max_paper)
		user.show_message(span_alert("The paper bin is full!"))
		return FALSE
	if(!ismob(user))
		user.show_message(span_alert("You can't!"))
		return FALSE
	if(!user.canUnEquip(ppr))
		user.show_message(span_alert("You can't seem to get [ppr] out of your hands!"))
		return FALSE
	if(!user.transferItemToLoc(ppr, src))
		user.show_message(span_alert("[ppr] didn't go in!"))
		return FALSE
	papers += ppr
	user.show_message(span_notice("You insert [ppr] into [src]!"))
	playsound(src, 'sound/machines/click.ogg', 30, 1)
	return TRUE

/obj/item/pinpointer/validball_finder/proc/send_scan_ping(mob/user)
	if(!user)
		return
	if(currently_scanning)
		user.show_message("You press the SCAN button, and [src] lets out a patient beep!")
		say(span_robot("Scanning in progress, please wait. Error code 3"))
		return
	if(!has_paper())
		user.show_message("You press the SCAN button, and [src] lets out a hungry beep!")
		say(span_robot("Out of paper. Error code 1"))
		return
	var/turf/scan_here = get_turf(user)
	if(!isturf(scan_here))
		user.show_message("You press the SCAN button, and [src] lets out an existential beep!")
		say(span_robot("Location invalid!!! Error code IM-CODER2"))
		return
	scan_turf = WEAKREF(scan_here)
	if(!scan_turf)
		user.show_message("You press the SCAN button, and [src] lets out a weak beep!")
		say(span_robot("Scan failed, location invalid!!! Error code AM-CODER"))
		return
	playsound(src, 'sound/machines/whistlebeepalert-cb.ogg', 30, 1)
	playsound(src, 'sound/machines/pc_process.ogg', 60, 1)
	user.show_message("You press the SCAN button, and [src] lets out an excited beep!")
	say(span_robot("Scanning for anomalous signals, please wait."))
	currently_scanning = TRUE
	addtimer(CALLBACK(src,PROC_REF(read_scan_ping), user), scan_time)

/obj/item/pinpointer/validball_finder/proc/read_scan_ping()
	if(!isweakref(scan_turf))
		say(span_robot("Scan origin weakref failed! Error code 13"))
		visible_message("[src] lets out a confused beep!")
		return
	var/turf/scan_from_here = scan_turf.resolve()
	if(!isturf(scan_from_here))
		say(span_robot("Scan origin failed! Error code 99-2"))
		visible_message("[src] lets out a frustrated beep!1")
		return
	if(!has_paper())
		say(span_robot("Out of paper. Error code 1"))
		visible_message("[src]'s printer module pings!")
		return
	var/the_report = build_report(scan_from_here)
	if(!the_report)
		say(span_robot("Scan failed! Error code 88-A"))
		visible_message("[src] lets out an annoyed beep!")
		return
	if(!print_report(the_report))
		say(span_robot("Printer failure! Error code 2000"))
		visible_message("[src]'s printer module clicks!")
		return
	playsound(src, 'sound/machines/twobeep.ogg', 50, 1)
	say(span_robot("Scan decoded and printed!"))
	visible_message("[src] prints something!")
	currently_scanning = FALSE

/obj/item/pinpointer/validball_finder/proc/print_report(report_msg)
	var/obj/item/paper/our_paper = papers[LAZYLEN(papers)]
	if(!our_paper)
		return FALSE
	papers -= our_paper
	our_paper.info += "<br>"
	our_paper.info += report_msg
	our_paper.update_icon_state()
	playsound(src, 'sound/machines/printer_thermal.ogg', 50, 1)
	var/turf/the_here = get_turf(src)
	our_paper.forceMove(the_here)
	var/mob/living/carbon/human/someonethere = locate(/mob/living/carbon/human) in the_here
	if(istype(someonethere))
		someonethere.put_in_hands(our_paper)
	return TRUE

/obj/item/pinpointer/validball_finder/proc/build_report(turf/scan_origin)
	if(!isturf(scan_origin))
		return
	var/list/msg_out = list()
	msg_out += "<hr>"
	msg_out += "- START REPORT -"
	msg_out += "- [span_small(uppertext(STATION_TIME_TIMESTAMP(FALSE, world.time)))] -"
	msg_out += "[FOURSPACES]"
	msg_out += "<u><b>FoxEye Anomaly Detector v1.23 PRO</b></u>"
	msg_out += "[FOURSPACES][span_small(readout_fluff("START"))]"
	msg_out += "[FOURSPACES]"
	msg_out += "[FOURSPACES] - Initializing..........DONE!"
	msg_out += "[FOURSPACES]"
	msg_out += "[FOURSPACES] - Scan origin: [z2text(scan_origin)] - ([local_coords(scan_origin)])"
	msg_out += "[FOURSPACES] - Margin of error: 10 meters"
	msg_out += "[FOURSPACES]"
	var/num_things = LAZYLEN(SSvalidball.valid_balls)
	msg_out += "[num_things] anomalous signal(s) detected!"
	var/ball_num = 1
	for(var/obj/item/validball/vb_thing in SSvalidball.valid_balls)
		var/is_close = (scan_origin.z == vb_thing.z)
		msg_out += "[FOURSPACES]Object [ball_num]:"
		msg_out += "[FOURSPACES] - Decrypting frequency..........DONE!"
		msg_out += "[FOURSPACES] - Triangulating signal..........DONE!"
		msg_out += "[FOURSPACES] - Transcribing results..........DONE!"
		msg_out += "[FOURSPACES]"
		msg_out += "[FOURSPACES] - Signal origin: [z2text(vb_thing)]"
		if(is_close)
			msg_out += "[FOURSPACES] - Signal bearing: [which_direction(scan_origin, vb_thing)]"
			msg_out += "[FOURSPACES] - Margin of error: 15 degrees"
		else
			msg_out += "[FOURSPACES]Signal out of range for precision scan, please get closer!"
		if(vb_thing.activated)
			msg_out += "[FOURSPACES]"
			msg_out += "[FOURSPACES]<b>WARNING:</b> Homing frequency detected in signal!"
			msg_out += "[FOURSPACES][FOURSPACES]Object will be visible on all local scanners!"
		msg_out += "[FOURSPACES]"
		msg_out += "[FOURSPACES][readout_fluff("END")]"
		msg_out += "[FOURSPACES]"
	msg_out += "- END OF REPORT -"
	return span_robot(msg_out.Join("<br>"))


/obj/item/pinpointer/validball_finder/proc/z2text(turf/hereturf)
	if(!hereturf)
		return "!!UNKNOWN!!"
	if(!isturf(hereturf))
		hereturf = get_turf(hereturf)
		if(!isturf(hereturf))
			return "??UNKNOWN??"
	switch(hereturf.z)
		if(Z_LEVEL_GARLAND)
			return "Garland City - Common"
		if(Z_LEVEL_REDLICK_UPPER)
			return "Ashdown - Common"
		if(Z_LEVEL_TRANSIT)
			return "Moving along Rail Route 14-2 Delta"
		if(Z_LEVEL_CENTCOM)
			return "Somewhere far away~"
		if(Z_LEVEL_NASH_UNDERGROUND)
			return "Nash Wastes - Underground"
		if(Z_LEVEL_NASH_COMMON)
			return "Nash Wastes - Common"
		if(Z_LEVEL_NASH_LVL2)
			return "Nash Wastes - Second Story"
		if(Z_LEVEL_NASH_LVL3)
			return "Nash Wastes - Third Story"
		if(Z_LEVEL_REDWATER)
			return "Southern Wastes - Common"
		if(Z_LEVEL_REDLICK)
			return "Northern Wastes - Common"
		if(Z_LEVEL_NEWBOSTON)
			return "New Boston - Common"
		if(Z_LEVEL_NEWBOSTON_UPPER)
			return "New Boston - Second Story"
		else
			return "~!UNKNOWN!~"

/obj/item/pinpointer/validball_finder/proc/local_coords(turf/hereturf)
	if(!hereturf)
		return "!!UNKNOWN!!"
	if(!isturf(hereturf))
		hereturf = get_turf(hereturf)
		if(!isturf(hereturf))
			return "??UNKNOWN??"
	var/coord_x = abs(hereturf.x + rand(-5, 5))
	var/coord_y = abs(hereturf.y + rand(-5, 5))
	return "[coord_x], [coord_y]"

/obj/item/pinpointer/validball_finder/proc/which_direction(turf/hereturf, atom/therething)
	if(!hereturf)
		return "!!UNKNOWN!!"
	if(!therething)
		return "!!!UNKNOWN!!!"
	if(!isturf(hereturf))
		hereturf = get_turf(hereturf)
		if(!isturf(hereturf))
			return "??UNKNOWN??"
	var/the_angle = Get_Angle(hereturf, therething)
	the_angle += rand(-15,15)
	if(the_angle > 360)
		the_angle -= 360
	if(the_angle < 0)
		the_angle += 360
	var/the_direction = angle2text(the_angle)
	return "[the_angle] ([the_direction]-ish)"

/obj/item/pinpointer/validball_finder/proc/readout_fluff(typething = "END")
	if(typething == "START")
		switch(rand(1,6))
			if(1)
				return "Shareware edition!"
			if(2)
				return "Unregistered!"
			if(3)
				return "=3"
			if(4)
				return "Rated 4 geckers out of 5"
			if(5)
				return "Now on ThinkDOS!"
			if(6)
				return "100% native!"

	if(typething == "END")
		switch(rand(1,6))
			if(1)
				return "Careful, it may be guarded by dangerous creatures and/or folk!"
			if(2)
				return "Careful, it may attract unwanted attention!"
			if(3)
				return "High-value frequencies detected in the signal, might be something valuable!"
			if(4)
				return "Be sure to register your device with the local Boxcar Vixen!"
			if(5)
				return "Whatever it is, readings are off the charts!"
			if(6)
				return "No hostile readings detected, it's good and safe! =3"

/obj/item/pinpointer/validball_finder/proc/has_paper()
	if(!LAZYLEN(papers))
		return FALSE
	for(var/obj/item/paper/papper in papers)
		if(papper)
			return TRUE

/obj/item/pinpointer/validball_finder/attack_self(mob/living/user)
	if(active)
		active = FALSE
		user.visible_message(span_notice("[user] deactivates [user.p_their()] pinpointer."), span_notice("You deactivate your pinpointer."))
		playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
		target = null //Restarting the pinpointer forces a target reset
		STOP_PROCESSING(SSfastprocess, src)
		update_icon()
		return

	var/list/active_balls = list()
	for(var/obj/item/validball/vball in SSvalidball.valid_balls)
		if(vball.activated)
			active_balls += vball

	if(LAZYLEN(active_balls) < 1)
		user.show_message(span_alert("Nothing detected, try agan later."))
		return

	if(LAZYLEN(SSvalidball.valid_balls) == 1)
		target = SSvalidball.valid_balls[1]
	else
		target = input(user, "Artifact to track", "Pinpoint") in SSvalidball.valid_balls
		if(!target || QDELETED(src) || QDELETED(target) || !user || !user.is_holding(src) || user.incapacitated())
			target = null
			return

	active = TRUE
	user.visible_message(span_notice("[user] activates [user.p_their()] pinpointer."), span_notice("You activate your pinpointer."))
	playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
	START_PROCESSING(SSfastprocess, src)
	update_icon()

/obj/effect/validball_spawner
	name = "validball spawner"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x2"
	color = "#00FF00"
	var/obj/item/validball/the_thing = /obj/item/validball

/obj/effect/validball_spawner/Initialize(mapload)
	. = ..()
	add_spawner_to_list()

/obj/effect/validball_spawner/proc/add_spawner_to_list()
	if(src in SSvalidball.valid_ball_spawners)
		return
	SSvalidball.valid_ball_spawners += src

/obj/effect/validball_spawner/proc/spawn_the_thing()
	var/atom/spawn_here = loc
	var/turf/right_here = get_turf(src)
	if(isturf(right_here) && isatom(spawn_here))
		message_admins("Spawning [src] at [ADMIN_VERBOSEJMP(right_here)]. Validball is go!")
		var/obj/item/validball/thenewvb = new the_thing(spawn_here)
		thenewvb.roundstartify()
		return thenewvb
	return FALSE

/// so when going through a FUCKHUGE list, I realized, fuck it, immma just datumize it
/// Holds all the relephant data about who touched the darn thing
/datum/validball_data_report
	/// weakref to the relevant validball. weakref just in case some goober destroys it
	var/datum/weakref/the_validball
	/// weakref of the last person to touch the validball, what better way to pull their data than from the source? if they still exist
	//var/datum/weakref/last_holder
	/// Validball name!
	var/vb_name
	/// fluff
	var/vb_fluff
	/// The last one to touch the thing
	var/last_holder_name
	/// The last one to touch the thing, in ckey form
	var/last_holder_ckey
	/// Their job
	var/last_holder_job
	/// All the people who touched this thing. Includes the last holder, so, careful
	var/list/prev_holders = list()
	/// Was this thing destroyed?
	var/was_destroyed = "help"

/datum/validball_data_report/proc/register_your_product(obj/item/validball/ball)
	if(!istype(ball)) // wh
		if(src in SSvalidball.vb_reports)
			SSvalidball.vb_reports -= src
		qdel(src)
		return
	the_validball = WEAKREF(ball)
	was_destroyed = FALSE
	vb_name = ball.name
	last_holder_ckey = VB_DUMMY_CKEY

/datum/validball_data_report/proc/set_be_destroyed()
	was_destroyed = TRUE // :c

/datum/validball_data_report/proc/update_ownership(mob/user)
	if(!ismob(user))
		return
	if(!user.ckey)
		return
	//last_holder = WEAKREF(user)
	last_holder_name = user.real_name
	if(!last_holder_name || last_holder_name == "Unknown")
		last_holder_name = "Nobody in particular"
	
	last_holder_job = user.job
	if(!last_holder_job)
		last_holder_job = "resident of the wastes"

	last_holder_ckey = user.ckey
	if(!last_holder_ckey)
		last_holder_ckey = "how"

	prev_holders[last_holder_ckey] = VB_CKEY_UPDATE(user, last_holder_name, last_holder_job)

#undef VALIDBALL_DIST_FAR

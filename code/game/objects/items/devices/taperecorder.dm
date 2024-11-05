/obj/item/taperecorder
	name = "universal recorder"
	desc = "A device that can record to cassette tapes, and play them. It automatically translates the content in playback."
	icon = 'icons/obj/device.dmi'
	icon_state = "taperecorder_empty"
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = HEAR_1
	slot_flags = INV_SLOTBIT_BELT
	custom_materials = list(/datum/material/iron=60, /datum/material/glass=30)
	force = 2
	throwforce = 0
	var/recording = 0
	var/playing = 0
	var/playsleepseconds = 0
	var/obj/item/tape/mytape
	var/starting_tape_type = /obj/item/tape/random
	var/panel_open = FALSE
	var/canprint = 1

/obj/item/taperecorder/Initialize(mapload)
	. = ..()
	if(starting_tape_type)
		mytape = new starting_tape_type(src)
	update_icon()
	wires = new /datum/wires/taperecorder(src)


/obj/item/taperecorder/examine(mob/user)
	. = ..()
	. += "The wire panel is [panel_open ? "opened" : "closed"]."


/obj/item/taperecorder/attackby(obj/item/I, mob/user, params)
	if(!mytape && istype(I, /obj/item/tape))
		if(!user.transferItemToLoc(I,src))
			return
		mytape = I
		to_chat(user, span_notice("You insert [I] into [src]."))
		update_icon()
	else if(is_wire_tool(I) && panel_open)
		wires.interact(user)

/obj/item/taperecorder/screwdriver_act(mob/living/user, obj/item/I)
	I.play_tool_sound(src, 50)
	if(!panel_open)
		panel_open = TRUE
		to_chat(user, span_notice("You open the maintenance hatch of [src]."))
	else
		panel_open = FALSE
		to_chat(user, span_notice("You close the maintenance hatch of [src]."))
	return TRUE

/obj/item/taperecorder/Destroy()
	QDEL_NULL(mytape)
	return ..()


/obj/item/taperecorder/proc/eject(mob/user)
	if(mytape)
		to_chat(user, span_notice("You remove [mytape] from [src]."))
		stop()
		user.put_in_hands(mytape)
		mytape = null
		update_icon()

/obj/item/taperecorder/fire_act(exposed_temperature, exposed_volume)
	mytape.ruin() //Fires destroy the tape
	..()

/obj/item/taperecorder/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc == user)
		if(mytape)
			if(!user.is_holding(src))
				return ..()
			eject(user)
	else
		return ..()

/obj/item/taperecorder/proc/can_use(mob/user)
	if(user && ismob(user))
		if(!user.incapacitated(allow_crit = TRUE))
			return TRUE
	return FALSE

/obj/item/taperecorder/verb/ejectverb()
	set name = "Eject Tape"
	set category = "Object"

	if(!can_use(usr) || !mytape)
		return
	eject(usr)

/obj/item/taperecorder/update_icon_state()
	if(!mytape)
		icon_state = "taperecorder_empty"
	else if(recording)
		icon_state = "taperecorder_recording"
	else if(playing)
		icon_state = "taperecorder_playing"
	else
		icon_state = "taperecorder_idle"


/obj/item/taperecorder/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, spans, message_mode, atom/movable/source)
	. = ..()
	if(mytape && recording)
		mytape.timestamp += mytape.used_capacity
		mytape.storedinfo += "\[[time2text(mytape.used_capacity * 10,"mm:ss")]\] [message]"

/obj/item/taperecorder/verb/record()
	set name = "Start Recording"
	set category = "Object"
	if(!can_use(usr) || !mytape || mytape.ruined || recording || playing)
		return

	if(mytape.used_capacity < mytape.max_capacity)
		to_chat(usr, span_notice("Recording started."))
		recording = 1
		update_icon()
		mytape.timestamp += mytape.used_capacity
		mytape.storedinfo += "\[[time2text(mytape.used_capacity * 10,"mm:ss")]\] Recording started."
		var/used = mytape.used_capacity	//to stop runtimes when you eject the tape
		var/max = mytape.max_capacity
		while(recording && used < max)
			mytape.used_capacity++
			used++
			sleep(10)
		recording = 0
		update_icon()
	else
		to_chat(usr, span_notice("The tape is full."))


/obj/item/taperecorder/verb/stop()
	set name = "Stop"
	set category = "Object"
	if(!can_use(usr))
		return
	if(recording)
		recording = 0
		mytape.timestamp += mytape.used_capacity
		mytape.storedinfo += "\[[time2text(mytape.used_capacity * 10,"mm:ss")]\] Recording stopped."
		to_chat(usr, span_notice("Recording stopped."))
		return
	else if(playing)
		playing = 0
		var/turf/T = get_turf(src)
		T.visible_message("<font color=Maroon><B>Tape Recorder</B>: Playback stopped.</font>")
	update_icon()

/obj/item/taperecorder/AltClick(mob/user)
	. = ..()
	if (recording)
		stop()
	else
		record()

/obj/item/taperecorder/verb/WipeTapeInRecorder()
	set name = "Wipe Tape"
	if(!mytape || mytape.ruined || recording || playing)
		return
	else
		mytape.used_capacity = 0;
		mytape.storedinfo = new;
		mytape.timestamp = new;
		to_chat(usr, "<span class='notice'>You wipe this tape entirely.")

/obj/item/taperecorder/verb/play()
	set name = "Play Tape"
	set category = "Object"
	if(!mytape || mytape.ruined || recording || playing || !can_use(usr))
		return

	playing = 1
	update_icon()
	to_chat(usr, span_notice("Playing started."))
	var/used = mytape.used_capacity	//to stop runtimes when you eject the tape
	var/max = mytape.max_capacity
	for(var/i = 1, used < max, sleep(10 * playsleepseconds))
		if(!mytape || playing == 0 || mytape.storedinfo.len < i)
			break
		say(mytape.storedinfo[i])
		if(mytape.storedinfo.len < i + 1)
			playsleepseconds = 1
			sleep(10)
			say("End of recording.")
		else
			playsleepseconds = mytape.timestamp[i + 1] - mytape.timestamp[i]
		if(playsleepseconds > 14)
			sleep(10)
			say("Skipping [playsleepseconds] seconds of silence")
			playsleepseconds = 1
		i++

	playing = 0
	update_icon()

/obj/item/taperecorder/attack_self(mob/user)
	if(!mytape || mytape.ruined)
		return
	if(recording)
		stop()
	else
		record()

/obj/item/taperecorder/verb/print_transcript()
	set name = "Print Transcript"
	set category = "Object"

	if(!mytape || recording || playing || !can_use(usr))
		return
	if(!canprint)
		to_chat(usr, span_notice("The recorder can't print that fast!"))
		return

	to_chat(usr, span_notice("Transcript printed."))
	var/obj/item/paper/P = new /obj/item/paper(get_turf(src))
	var/t1 = "<B>Transcript:</B><BR><BR>"
	for(var/i = 1, mytape.storedinfo.len >= i, i++)
		t1 += "[mytape.storedinfo[i]]<BR>"
	P.info = t1
	P.name = "paper- 'Transcript'"
	usr.put_in_hands(P)
	canprint = 0
	sleep(300)
	canprint = 1

//empty tape recorders
/obj/item/taperecorder/empty
	starting_tape_type = null

/obj/item/tape
	name = "tape"
	desc = "A magnetic tape that can hold up to ten minutes of content."
	icon_state = "tape_white"
	icon = 'icons/obj/device.dmi'
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron=20, /datum/material/glass=5)
	force = 1
	throwforce = 0
	var/max_capacity = 600
	var/used_capacity = 0
	var/list/storedinfo = list()
	var/list/timestamp = list()
	var/ruined = 0
	var/list/storedinfo_otherside = list()
	var/list/timestamp_otherside = list()
	var/list/used_capacity_otherside = 0
	var/firstFlip = TRUE
	var/originalIconState 

/obj/item/tape/fire_act(exposed_temperature, exposed_volume)
	ruin()
	..()

/obj/item/tape/attack_self(mob/user)
	if(!ruined)
		to_chat(user, span_notice("You pull out all the tape!"))
		ruin()

/obj/item/tape/proc/ruin()
	//Lets not add infinite amounts of overlays when our fireact is called
	//repeatedly
	if(!ruined)
		add_overlay("ribbonoverlay")
	ruined = 1

/obj/item/tape/proc/fix()
	cut_overlay("ribbonoverlay")
	ruined = 0

/obj/item/tape/proc/wipeproc()
	used_capacity = 0;
	storedinfo = new;
	timestamp = new;

/obj/item/tape/verb/wipeverb()
	set name = "Wipe Tape";
	if(ruined)
		to_chat(usr, "<span class='notice'>You scrub the magnetic strip clean of its contents.")
		wipeproc()
	else if(!ruined)
		to_chat(usr, "<span class='notice'>You need to pull out the tape's magnetic strips first.")

/obj/item/tape/attackby(obj/item/I, mob/user, params)
	if(ruined && istype(I, /obj/item/screwdriver) || istype(I, /obj/item/pen))
		to_chat(user, span_notice("You start winding the tape back in..."))
		if(I.use_tool(src, user, 120))
			to_chat(user, span_notice("You wound the tape back in."))
			fix()

/obj/item/tape/Initialize()
	. = ..()
	originalIconState = icon_state

/obj/item/tape/proc/flip()

	//first we save a copy of our current side
	var/list/storedinfo_currentside = storedinfo.Copy()
	var/list/timestamp_currentside = timestamp.Copy()
	var/used_capacity_currentside = used_capacity
	//then we overwite our current side with our other side
	storedinfo = storedinfo_otherside.Copy()
	timestamp = timestamp_otherside.Copy()
	used_capacity = used_capacity_otherside
	//then we overwrite our other side with the saved side
	storedinfo_otherside = storedinfo_currentside.Copy()
	timestamp_otherside = timestamp_currentside.Copy()
	used_capacity_otherside = used_capacity_currentside
	if(icon_state == originalIconState)
		icon_state = "[originalIconState]_flipped"
	else if(icon_state == "[originalIconState]_flipped") //so flipping doesn't overwrite an unexpected icon_state (e.g. an admin's)
		icon_state = originalIconState

/obj/item/tape/AltClick(mob/user)
	. = ..()
	if (firstFlip)
		to_chat(usr, span_notice("You flip the tape so you can record on the clean magnetic strip."))
		firstFlip = FALSE
	else
		to_chat(usr, span_notice("You flip the tape back around."))
	flip()

/obj/item/tape/verb/flipVerb()
//adding this verb too just so players know it's an option.
	set name = "Flip Tape";
	if (firstFlip)
		to_chat(usr, span_notice("You flip the tape so you can record on the clean magnetic strip"))
		firstFlip = FALSE
	else
		to_chat(usr, span_notice("You flip the tape back around."))
	flip()

//Random colour tapes
/obj/item/tape/random
	icon_state = "random_tape"

/obj/item/tape/random/New()
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple")]"
	..()


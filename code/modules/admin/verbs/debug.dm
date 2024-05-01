/client/proc/Debug2()
	set category = "Debug"
	set name = "Debug-Game"
	if(!check_rights(R_DEBUG))
		return

	if(GLOB.Debug2)
		GLOB.Debug2 = 0
		message_admins("[key_name(src)] toggled debugging off.")
		log_admin("[key_name(src)] toggled debugging off.")
	else
		GLOB.Debug2 = 1
		message_admins("[key_name(src)] toggled debugging on.")
		log_admin("[key_name(src)] toggled debugging on.")

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Debug Two") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/Cell()
	set category = "Debug"
	set name = "Air Status in Location"
	if(!mob)
		return
	var/turf/T = get_turf(mob)
	if(!isturf(T))
		return
	show_air_status_to(T, usr)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Air Status In Location") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_robotize(mob/M in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Make Robot"

	if(!SSticker.HasRoundStarted())
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(src)] has robotized [M.key].")
		var/mob/living/carbon/human/H = M
		spawn(0)
			H.Robotize()

	else
		alert("Invalid mob")

/client/proc/cmd_admin_blobize(mob/M in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Make Blob"

	if(!SSticker.HasRoundStarted())
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		log_admin("[key_name(src)] has blobized [M.key].")
		var/mob/living/carbon/human/H = M
		H.become_overmind()
	else
		alert("Invalid mob")


/client/proc/cmd_admin_animalize(mob/M in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Make Simple Animal"

	if(!SSticker.HasRoundStarted())
		alert("Wait until the game starts")
		return

	if(!M)
		alert("That mob doesn't seem to exist, close the panel and try again.")
		return

	if(isnewplayer(M))
		alert("The mob must not be a new_player.")
		return

	log_admin("[key_name(src)] has animalized [M.key].")
	spawn(0)
		M.Animalize()


/client/proc/makepAI(turf/T in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Make pAI"
	set desc = "Specify a location to spawn a pAI device, then specify a key to play that pAI"

	var/list/available = list()
	for(var/mob/C in GLOB.mob_list)
		if(C.key)
			available.Add(C)
	var/mob/choice = input("Choose a player to play the pAI", "Spawn pAI") in available
	if(!choice)
		return 0
	if(!isobserver(choice))
		var/confirm = input("[choice.key] isn't ghosting right now. Are you sure you want to yank him out of them out of their body and place them in this pAI?", "Spawn pAI Confirmation", "No") in list("Yes", "No")
		if(confirm != "Yes")
			return 0
	var/obj/item/paicard/card = new(T)
	var/mob/living/silicon/pai/pai = new(card)
	pai.name = input(choice, "Enter your pAI name:", "pAI Name", "Personal AI") as text
	pai.real_name = pai.name
	choice.transfer_ckey(pai)
	card.setPersonality(pai)
	for(var/datum/paiCandidate/candidate in SSpai.candidates)
		if(candidate.key == choice.key)
			SSpai.candidates.Remove(candidate)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make pAI") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_alienize(mob/M in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Make Alien"

	if(!SSticker.HasRoundStarted())
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		INVOKE_ASYNC(M, /mob/living/carbon/human/proc/Alienize)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Alien") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		log_admin("[key_name(usr)] made [key_name(M)] into an alien at [AREACOORD(M)].")
		message_admins(span_adminnotice("[key_name_admin(usr)] made [ADMIN_LOOKUPFLW(M)] into an alien."))
	else
		alert("Invalid mob")

/client/proc/cmd_admin_slimeize(mob/M in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Make slime"

	if(!SSticker.HasRoundStarted())
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		INVOKE_ASYNC(M, /mob/living/carbon/human/proc/slimeize)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Slime") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		log_admin("[key_name(usr)] made [key_name(M)] into a slime at [AREACOORD(M)].")
		message_admins(span_adminnotice("[key_name_admin(usr)] made [ADMIN_LOOKUPFLW(M)] into a slime."))
	else
		alert("Invalid mob")

//TODO: merge the vievars version into this or something maybe mayhaps
/client/proc/cmd_debug_del_all(object as text)
	set category = "Debug"
	set name = "Del-All"

	var/list/matches = get_fancy_list_of_atom_types()
	if (!isnull(object) && object!="")
		matches = filter_fancy_list(matches, object)

	if(matches.len==0)
		return
	var/hsbitem = input(usr, "Choose an object to delete.", "Delete:") as null|anything in matches
	if(hsbitem)
		hsbitem = matches[hsbitem]
		var/counter = 0
		for(var/atom/O in world)
			if(istype(O, hsbitem))
				counter++
				qdel(O)
			CHECK_TICK
		log_admin("[key_name(src)] has deleted all ([counter]) instances of [hsbitem].")
		message_admins("[key_name_admin(src)] has deleted all ([counter]) instances of [hsbitem].")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Delete All") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/cmd_debug_make_powernets()
	set category = "Debug"
	set name = "Make Powernets"
	SSmachines.makepowernets()
	log_admin("[key_name(src)] has remade the powernet. makepowernets() called.")
	message_admins("[key_name_admin(src)] has remade the powernets. makepowernets() called.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Make Powernets") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_grantfullaccess(mob/M in GLOB.mob_list)
	set category = "Admin"
	set name = "Grant Full Access"

	if(!SSticker.HasRoundStarted())
		alert("Wait until the game starts")
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/worn = H.wear_id
		var/obj/item/card/id/id = null
		if(worn)
			id = worn.GetID()
		if(id)
			id.icon_state = "gold"
			id.access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
		else
			id = new /obj/item/card/id/gold(H.loc)
			id.access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
			id.registered_name = H.real_name
			id.assignment = "Captain"
			id.update_label()

			if(worn)
				if(istype(worn, /obj/item/pda))
					var/obj/item/pda/PDA = worn
					PDA.id = id
					id.forceMove(PDA)
				else if(istype(worn, /obj/item/storage/wallet))
					var/obj/item/storage/wallet/W = worn
					W.front_id = id
					id.forceMove(W)
					W.update_icon()
			else
				H.equip_to_slot(id,SLOT_WEAR_ID)

	else
		alert("Invalid mob")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Grant Full Access") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(src)] has granted [M.key] full access.")
	message_admins(span_adminnotice("[key_name_admin(usr)] has granted [M.key] full access."))

/client/proc/cmd_assume_direct_control(mob/M in GLOB.mob_list)
	set category = "Admin.Game"
	set name = "Assume direct control"
	set desc = "Direct intervention"

	if(M.ckey)
		if(alert("This mob is being controlled by [M.key]. Are you sure you wish to assume control of it? [M.key] will be made a ghost.",,"Yes","No") != "Yes")
			return
		else
			var/mob/dead/observer/ghost = new/mob/dead/observer(get_turf(M), M)
			ghost.ckey = M.ckey
	message_admins(span_adminnotice("[key_name_admin(usr)] assumed direct control of [M]."))
	log_admin("[key_name(usr)] assumed direct control of [M].")
	var/mob/adminmob = src.mob
	adminmob.transfer_ckey(M, send_signal = FALSE)
	if( isobserver(adminmob) )
		qdel(adminmob)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Assume Direct Control") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_give_direct_control(mob/M in GLOB.mob_list)
	set category = "Admin.Game"
	set name = "Give direct control"

	if(!M)
		return
	if(M.ckey)
		if(alert("This mob is being controlled by [M.key]. Are you sure you wish to give someone else control of it? [M.key] will be made a ghost.",,"Yes","No") != "Yes")
			return
	var/client/newkey = input(src, "Pick the player to put in control.", "New player") as null|anything in sortList(GLOB.clients)
	var/mob/oldmob = newkey.mob
	var/delmob = FALSE
	if((isobserver(oldmob) || alert("Do you want to delete [newkey]'s old mob?","Delete?","Yes","No") != "No"))
		delmob = TRUE
	if(!M || QDELETED(M))
		to_chat(usr, span_warning("The target mob no longer exists, aborting."))
		return
	if(M.ckey)
		M.ghostize(FALSE)
	M.ckey = newkey.key
	M.client?.init_verbs()
	if(delmob)
		qdel(oldmob)
	message_admins(span_adminnotice("[key_name_admin(usr)] gave away direct control of [M] to [newkey]."))
	log_admin("[key_name(usr)] gave away direct control of [M] to [newkey].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Give Direct Control") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_admin_test_atmos_controllers()
	set category = "Mapping"
	set name = "Test Atmos Monitoring Consoles"

	var/list/dat = list()

	if(SSticker.current_state == GAME_STATE_STARTUP)
		to_chat(usr, "Game still loading, please hold!")
		return

	message_admins(span_adminnotice("[key_name_admin(usr)] used the Test Atmos Monitor debug command."))
	log_admin("[key_name(usr)] used the Test Atmos Monitor debug command.")

	var/bad_shit = 0
	for(var/obj/machinery/computer/atmos_control/tank/console in GLOB.atmos_air_controllers)
		dat += "<h1>[console] at [AREACOORD(console)]:</h1><br>"
		if(console.input_tag == console.output_tag)
			dat += "Error: input_tag is the same as the output_tag, \"[console.input_tag]\"!<br>"
			bad_shit++
		if(!LAZYLEN(console.input_info))
			dat += "Failed to find a valid outlet injector as an input with the tag [console.input_tag].<br>"
			bad_shit++
		if(!LAZYLEN(console.output_info))
			dat += "Failed to find a valid siphon pump as an outlet with the tag [console.output_tag].<br>"
			bad_shit++
		if(!bad_shit)
			dat += "<B>STATUS:</B> NORMAL"
		else
			bad_shit = 0
		dat += "<br>"
		CHECK_TICK

	var/datum/browser/popup = new(usr, "testatmoscontroller", "Test Atmos Monitoring Consoles", 500, 750)
	popup.set_content(dat.Join())
	popup.open()

/client/proc/cmd_admin_areatest(on_station)
	set category = "Mapping"
	set name = "Test Areas"

	var/list/dat = list()
	var/list/areas_all = list()
	var/list/areas_with_APC = list()
	var/list/areas_with_multiple_APCs = list()
	var/list/sub_areas_APC = list()
	var/list/areas_with_air_alarm = list()
	var/list/sub_areas_air_alarm = list()
	var/list/areas_with_RC = list()
	var/list/areas_with_MT = list()
	var/list/areas_with_light = list()
	var/list/areas_with_LS = list()
	var/list/areas_with_intercom = list()
	var/list/areas_with_camera = list()
	var/list/station_areas_blacklist = typecacheof(list(/area/holodeck/rec_center, /area/shuttle, /area/engine/supermatter, /area/science/test_area, /area/space, /area/solar, /area/mine, /area/ruin, /area/asteroid))

	if(SSticker.current_state == GAME_STATE_STARTUP)
		to_chat(usr, "Game still loading, please hold!")
		return

	var/log_message
	if(on_station)
		dat += "<b>Only checking areas on station z-levels.</b><br><br>"
		log_message = "station z-levels"
	else
		log_message = "all z-levels"

	message_admins(span_adminnotice("[key_name_admin(usr)] used the Test Areas debug command checking [log_message]."))
	log_admin("[key_name(usr)] used the Test Areas debug command checking [log_message].")

	for(var/area/A in world)
		if(on_station)
			var/turf/picked = safepick(get_area_turfs(A.type))
			if(picked && is_station_level(picked.z))
				if(!(A.type in areas_all) && !is_type_in_typecache(A, station_areas_blacklist))
					areas_all.Add(A.type)
		else if(!(A.type in areas_all))
			areas_all.Add(A.type)
		CHECK_TICK

	for(var/obj/machinery/power/apc/APC in GLOB.apcs_list)
		var/area/A = APC.area
		if(!A)
			dat += "Skipped over [APC] in invalid location, [APC.loc]."
			continue
		LAZYSET(sub_areas_APC, A.type, get_sub_areas(A, FALSE))
		if(!(A.type in areas_with_APC))
			areas_with_APC.Add(A.type)
		else if(A.type in areas_all)
			areas_with_multiple_APCs.Add(A.type)
		CHECK_TICK

	for(var/obj/machinery/airalarm/AA in GLOB.machines)
		var/area/A = get_base_area(AA)
		if(!A) //Make sure the target isn't inside an object, which results in runtimes.
			dat += "Skipped over [AA] in invalid location, [AA.loc].<br>"
			continue
		LAZYSET(sub_areas_air_alarm, A.type, get_sub_areas(A, FALSE))
		if(!(A.type in areas_with_air_alarm))
			areas_with_air_alarm.Add(A.type)
		CHECK_TICK

	for(var/obj/machinery/requests_console/RC in GLOB.machines)
		var/area/A = get_area(RC)
		if(!A)
			dat += "Skipped over [RC] in invalid location, [RC.loc].<br>"
			continue
		if(!(A.type in areas_with_RC))
			areas_with_RC.Add(A.type)
		CHECK_TICK

	for(var/obj/machinery/msgterminal/MT in GLOB.machines)
		var/area/A = get_area(MT)
		if(!A)
			dat += "Skipped over [MT] in invalid location, [MT.loc].<br>"
			continue
		if(!(A.type in areas_with_MT))
			areas_with_MT.Add(A.type)
		CHECK_TICK

	for(var/obj/machinery/light/L in GLOB.machines)
		var/area/A = get_area(L)
		if(!A)
			dat += "Skipped over [L] in invalid location, [L.loc].<br>"
			continue
		if(!(A.type in areas_with_light))
			areas_with_light.Add(A.type)
		CHECK_TICK

	for(var/obj/machinery/light_switch/LS in GLOB.machines)
		var/area/A = get_area(LS)
		if(!A)
			dat += "Skipped over [LS] in invalid location, [LS.loc].<br>"
			continue
		if(!(A.type in areas_with_LS))
			areas_with_LS.Add(A.type)
		CHECK_TICK

	for(var/obj/item/radio/intercom/I in GLOB.machines)
		var/area/A = get_area(I)
		if(!A)
			dat += "Skipped over [I] in invalid location, [I.loc].<br>"
			continue
		if(!(A.type in areas_with_intercom))
			areas_with_intercom.Add(A.type)
		CHECK_TICK

	for(var/obj/machinery/camera/C in GLOB.machines)
		var/area/A = get_area(C)
		if(!A)
			dat += "Skipped over [C] in invalid location, [C.loc].<br>"
			continue
		if(!(A.type in areas_with_camera))
			areas_with_camera.Add(A.type)
		CHECK_TICK

	var/list/areas_without_APC = areas_all - (areas_with_APC + flatten_list(sub_areas_APC))
	var/list/areas_without_air_alarm = areas_all - (areas_with_air_alarm + flatten_list(sub_areas_air_alarm))
	var/list/areas_without_RC = areas_all - areas_with_RC
	var/list/areas_without_light = areas_all - areas_with_light
	var/list/areas_without_LS = areas_all - areas_with_LS
	var/list/areas_without_intercom = areas_all - areas_with_intercom
	var/list/areas_without_camera = areas_all - areas_with_camera

	if(areas_without_APC.len)
		dat += "<h1>AREAS WITHOUT AN APC:</h1>"
		for(var/areatype in areas_without_APC)
			dat += "[areatype]<br>"
			CHECK_TICK

	if(areas_with_multiple_APCs.len)
		dat += "<h1>AREAS WITH MULTIPLE APCS:</h1>"
		for(var/areatype in areas_with_multiple_APCs)
			dat += "[areatype]<br>"
			if(sub_areas_APC[areatype])
				dat += "&nbsp;&nbsp;SUB-AREAS:<br>&nbsp;&nbsp;"
				dat += jointext(sub_areas_APC[areatype], "<br>&nbsp;&nbsp;")
			CHECK_TICK

	if(areas_without_air_alarm.len)
		dat += "<h1>AREAS WITHOUT AN AIR ALARM:</h1>"
		for(var/areatype in areas_without_air_alarm)
			dat += "[areatype]<br>"
			if(sub_areas_air_alarm[areatype])
				dat += "&nbsp;&nbsp;SUB-AREAS:<br>&nbsp;&nbsp;"
				dat += jointext(sub_areas_air_alarm[areatype], "<br>&nbsp;&nbsp;")
			CHECK_TICK

	if(areas_without_RC.len)
		dat += "<h1>AREAS WITHOUT A REQUEST CONSOLE:</h1>"
		for(var/areatype in areas_without_RC)
			dat += "[areatype]<br>"
			CHECK_TICK

	if(areas_without_light.len)
		dat += "<h1>AREAS WITHOUT ANY LIGHTS:</h1>"
		for(var/areatype in areas_without_light)
			dat += "[areatype]<br>"
			CHECK_TICK

	if(areas_without_LS.len)
		dat += "<h1>AREAS WITHOUT A LIGHT SWITCH:</h1>"
		for(var/areatype in areas_without_LS)
			dat += "[areatype]<br>"
			CHECK_TICK

	if(areas_without_intercom.len)
		dat += "<h1>AREAS WITHOUT ANY INTERCOMS:</h1>"
		for(var/areatype in areas_without_intercom)
			dat += "[areatype]<br>"
			CHECK_TICK

	if(areas_without_camera.len)
		dat += "<h1>AREAS WITHOUT ANY CAMERAS:</h1>"
		for(var/areatype in areas_without_camera)
			dat += "[areatype]<br>"
			CHECK_TICK

	if(!(areas_with_APC.len || areas_with_multiple_APCs.len || areas_with_air_alarm.len || areas_with_RC.len || areas_with_light.len || areas_with_LS.len || areas_with_intercom.len || areas_with_camera.len))
		dat += "<b>No problem areas!</b>"

	var/datum/browser/popup = new(usr, "testareas", "Test Areas", 500, 750)
	popup.set_content(dat.Join())
	popup.open()


/client/proc/cmd_admin_areatest_station()
	set category = "Mapping"
	set name = "Test Areas (STATION Z)"
	cmd_admin_areatest(TRUE)

/client/proc/cmd_admin_areatest_all()
	set category = "Mapping"
	set name = "Test Areas (ALL)"
	cmd_admin_areatest(FALSE)

/client/proc/cmd_admin_dress(mob/M in GLOB.mob_list)
	set category = "Admin.Events"
	set name = "Select equipment"
	if(!(ishuman(M) || isobserver(M)))
		alert("Invalid mob")
		return

	var/dresscode = robust_dress_shop()

	if(!dresscode)
		return

	var/delete_pocket
	var/mob/living/carbon/human/H
	if(isobserver(M))
		H = M.change_mob_type(/mob/living/carbon/human, null, null, TRUE)
	else
		H = M
		if(alert("Drop Items in Pockets? No will delete them.", "Robust quick dress shop", "Yes", "No") == "No")
			delete_pocket = TRUE

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Select Equipment") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	for (var/obj/item/I in H.get_equipped_items(delete_pocket))
		qdel(I)
	if(dresscode != "Naked")
		H.equipOutfit(dresscode)

	H.regenerate_icons()

	log_admin("[key_name(usr)] changed the equipment of [key_name(H)] to [dresscode].")
	message_admins(span_adminnotice("[key_name_admin(usr)] changed the equipment of [ADMIN_LOOKUPFLW(H)] to [dresscode]."))

/client/proc/robust_dress_shop()
	var/list/outfits = list("Cancel","Naked","Custom","As Job...")
	var/list/paths = subtypesof(/datum/outfit) - typesof(/datum/outfit/job)
	for(var/path in paths)
		var/datum/outfit/O = path //not much to initalize here but whatever
		if(initial(O.can_be_admin_equipped))
			outfits[initial(O.name)] = path

	var/dresscode = input("Select outfit", "Robust quick dress shop") as null|anything in outfits
	if (isnull(dresscode))
		return

	if (outfits[dresscode])
		dresscode = outfits[dresscode]

	if(dresscode == "Cancel")
		return

	if (dresscode == "As Job...")
		var/list/job_paths = subtypesof(/datum/outfit/job)
		var/list/job_outfits = list()
		for(var/path in job_paths)
			var/datum/outfit/O = path
			if(initial(O.can_be_admin_equipped))
				job_outfits[initial(O.name)] = path

		dresscode = input("Select job equipment", "Robust quick dress shop") as null|anything in job_outfits
		dresscode = job_outfits[dresscode]
		if(isnull(dresscode))
			return

	if (dresscode == "Custom")
		var/list/custom_names = list()
		for(var/datum/outfit/D in GLOB.custom_outfits)
			custom_names[D.name] = D
		var/selected_name = input("Select outfit", "Robust quick dress shop") as null|anything in custom_names
		dresscode = custom_names[selected_name]
		if(isnull(dresscode))
			return

	return dresscode

/client/proc/startSinglo()

	set category = "Debug"
	set name = "Start Singularity"
	set desc = "Sets up the singularity and all machines to get power flowing through the station"

	if(alert("Are you sure? This will start up the engine. Should only be used during debug!",,"Yes","No") != "Yes")
		return

	for(var/obj/machinery/power/emitter/E in GLOB.machines)
		if(E.anchored)
			E.active = 1

	for(var/obj/machinery/field/generator/F in GLOB.machines)
		if(F.active == 0)
			F.active = 1
			F.state = 2
			F.power = 250
			F.anchored = TRUE
			F.warming_up = 3
			F.start_fields()
			F.update_icon()

	spawn(30)
		for(var/obj/machinery/the_singularitygen/G in GLOB.machines)
			if(G.anchored)
				var/obj/singularity/S = new /obj/singularity(get_turf(G), 50)
//				qdel(G)
				S.energy = 1750
				S.current_size = 7
				S.icon = 'icons/effects/224x224.dmi'
				S.icon_state = "singularity_s7"
				S.pixel_x = -96
				S.pixel_y = -96
				S.grav_pull = 0
				//S.consume_range = 3
				S.dissipate = 0
				//S.dissipate_delay = 10
				//S.dissipate_track = 0
				//S.dissipate_strength = 10

	for(var/obj/machinery/power/rad_collector/Rad in GLOB.machines)
		if(Rad.anchored)
			if(!Rad.loaded_tank)
				var/obj/item/tank/internals/plasma/Plasma = new/obj/item/tank/internals/plasma(Rad)
				Plasma.air_contents.set_moles(GAS_PLASMA,70)
				Rad.drainratio = 0
				Rad.loaded_tank = Plasma
				Plasma.forceMove(Rad)

			if(!Rad.active)
				Rad.toggle_power()

	for(var/obj/machinery/power/smes/SMES in GLOB.machines)
		if(SMES.anchored)
			SMES.input_attempt = 1

/client/proc/cmd_debug_mob_lists()
	set category = "Debug"
	set name = "Debug Mob Lists"
	set desc = "For when you just gotta know"

	switch(input("Which list?") in list("Players","Admins","Mobs","Living Mobs","Dead Mobs","Clients","Joined Clients"))
		if("Players")
			to_chat(usr, jointext(GLOB.player_list,","))
		if("Admins")
			to_chat(usr, jointext(GLOB.admins,","))
		if("Mobs")
			to_chat(usr, jointext(GLOB.mob_list,","))
		if("Living Mobs")
			to_chat(usr, jointext(GLOB.alive_mob_list,","))
		if("Dead Mobs")
			to_chat(usr, jointext(GLOB.dead_mob_list,","))
		if("Clients")
			to_chat(usr, jointext(GLOB.clients,","))
		if("Joined Clients")
			to_chat(usr, jointext(GLOB.joined_player_list,","))

/client/proc/cmd_display_del_log()
	set category = "Debug"
	set name = "Display del() Log"
	set desc = "Display del's log of everything that's passed through it."

	var/list/dellog = list("<B>List of things that have gone through qdel this round</B><BR><BR><ol>")
	sortTim(SSgarbage.items, cmp=/proc/cmp_qdel_item_time, associative = TRUE)
	for(var/path in SSgarbage.items)
		var/datum/qdel_item/I = SSgarbage.items[path]
		dellog += "<li><u>[path]</u><ul>"
		if (I.failures)
			dellog += "<li>Failures: [I.failures]</li>"
		dellog += "<li>qdel() Count: [I.qdels]</li>"
		dellog += "<li>Destroy() Cost: [I.destroy_time]ms</li>"
		if (I.hard_deletes)
			dellog += "<li>Total Hard Deletes [I.hard_deletes]</li>"
			dellog += "<li>Time Spent Hard Deleting: [I.hard_delete_time]ms</li>"
		if (I.slept_destroy)
			dellog += "<li>Sleeps: [I.slept_destroy]</li>"
		if (I.no_respect_force)
			dellog += "<li>Ignored force: [I.no_respect_force]</li>"
		if (I.no_hint)
			dellog += "<li>No hint: [I.no_hint]</li>"
		dellog += "</ul></li>"

	dellog += "</ol>"

	usr << browse(dellog.Join(), "window=dellog")

/client/proc/cmd_display_overlay_log()
	set category = "Debug"
	set name = "Display overlay Log"
	set desc = "Display SSoverlays log of everything that's passed through it."

	render_stats(SSoverlays.stats, src)

/client/proc/cmd_display_init_log()
	set category = "Debug"
	set name = "Display Initialize() Log"
	set desc = "Displays a list of things that didn't handle Initialize() properly"

	usr << browse(replacetext(SSatoms.InitLog(), "\n", "<br>"), "window=initlog")

/client/proc/debug_huds(i as num)
	set category = "Debug"
	set name = "Debug HUDs"
	set desc = "Debug the data or antag HUDs"

	if(!holder)
		return
	debug_variables(GLOB.huds[i])

/client/proc/jump_to_ruin()
	set category = "Debug"
	set name = "Jump to Ruin"
	set desc = "Displays a list of all placed ruins to teleport to."
	if(!holder)
		return
	var/list/names = list()
	for(var/i in GLOB.ruin_landmarks)
		var/obj/effect/landmark/ruin/ruin_landmark = i
		var/datum/map_template/ruin/template = ruin_landmark.ruin_template

		var/count = 1
		var/name = template.name
		var/original_name = name

		while(name in names)
			count++
			name = "[original_name] ([count])"

		names[name] = ruin_landmark

	var/ruinname = input("Select ruin", "Jump to Ruin") as null|anything in names


	var/obj/effect/landmark/ruin/landmark = names[ruinname]

	if(istype(landmark))
		var/datum/map_template/ruin/template = landmark.ruin_template
		usr.forceMove(get_turf(landmark))
		to_chat(usr, span_name("[template.name]"))
		to_chat(usr, span_italic("[template.description]"))

/client/proc/place_ruin()
	set category = "Debug"
	set name = "Spawn Ruin"
	set desc = "Attempt to randomly place a specific ruin."
	if (!holder)
		return

	var/list/exists = list()
	for(var/landmark in GLOB.ruin_landmarks)
		var/obj/effect/landmark/ruin/L = landmark
		exists[L.ruin_template] = landmark

	var/list/names = list()
	names += "---- Space Ruins ----"
	for(var/name in SSmapping.space_ruins_templates)
		names[name] = list(SSmapping.space_ruins_templates[name], ZTRAIT_SPACE_RUINS, list(/area/space))
	names += "---- Lava Ruins ----"
	for(var/name in SSmapping.lava_ruins_templates)
		names[name] = list(SSmapping.lava_ruins_templates[name], ZTRAIT_LAVA_RUINS, /area/lavaland/surface/outdoors/unexplored)
		names[name] = list(SSmapping.lava_ruins_templates[name], ZTRAIT_LAVA_RUINS, list(/area/lavaland/surface/outdoors/unexplored))
	names += "---- Ice Ruins ----"
	for(var/name in SSmapping.ice_ruins_templates)
		names[name] = list(SSmapping.ice_ruins_templates[name], ZTRAIT_ICE_RUINS, list(/area/icemoon/surface/outdoors/unexplored, /area/icemoon/underground/unexplored))
	names += "---- Ice Underground Ruins ----"
	for(var/name in SSmapping.ice_ruins_underground_templates)
		names[name] = list(SSmapping.ice_ruins_underground_templates[name], ZTRAIT_ICE_RUINS_UNDERGROUND, list(/area/icemoon/underground/unexplored))

	var/ruinname = input("Select ruin", "Spawn Ruin") as null|anything in names
	var/data = names[ruinname]
	if (!data)
		return
	var/datum/map_template/ruin/template = data[1]
	if (exists[template])
		var/response = alert("There is already a [template] in existence.", "Spawn Ruin", "Jump", "Place Another", "Cancel")
		if (response == "Jump")
			usr.forceMove(get_turf(exists[template]))
			return
		else if (response == "Cancel")
			return

	var/len = GLOB.ruin_landmarks.len
	seedRuins(SSmapping.levels_by_trait(data[2]), max(1, template.cost), data[3], list(ruinname = template))
	if (GLOB.ruin_landmarks.len > len)
		var/obj/effect/landmark/ruin/landmark = GLOB.ruin_landmarks[GLOB.ruin_landmarks.len]
		log_admin("[key_name(src)] randomly spawned ruin [ruinname] at [COORD(landmark)].")
		usr.forceMove(get_turf(landmark))
		to_chat(src, span_name("[template.name]"))
		to_chat(src, span_italic("[template.description]"))
	else
		to_chat(src, span_warning("Failed to place [template.name]."))

/client/proc/clear_dynamic_transit()
	set category = "Debug"
	set name = "Clear Dynamic Turf Reservations"
	set desc = "Deallocates all reserved space, restoring it to round start conditions."
	if(!holder)
		return
	var/answer = alert("WARNING: THIS WILL WIPE ALL RESERVED SPACE TO A CLEAN SLATE! ANY MOVING SHUTTLES, ELEVATORS, OR IN-PROGRESS PHOTOGRAPHY WILL BE DELETED!", "Really wipe dynamic turfs?", "YES", "NO")
	if(answer != "YES")
		return
	message_admins(span_adminnotice("[key_name_admin(src)] cleared dynamic transit space."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Clear Dynamic Transit") // If...
	log_admin("[key_name(src)] cleared dynamic transit space.")
	SSmapping.wipe_reservations()				//this goes after it's logged, incase something horrible happens.

/client/proc/toggle_medal_disable()
	set category = "Debug"
	set name = "Toggle Medal Disable"
	set desc = "Toggles the safety lock on trying to contact the medal hub."

	if(!check_rights(R_DEBUG))
		return

	SSmedals.hub_enabled = !SSmedals.hub_enabled

	message_admins(span_adminnotice("[key_name_admin(src)] [SSmedals.hub_enabled ? "disabled" : "enabled"] the medal hub lockout."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Medal Disable") // If...
	log_admin("[key_name(src)] [SSmedals.hub_enabled ? "disabled" : "enabled"] the medal hub lockout.")

/client/proc/view_runtimes()
	set category = "Debug"
	set name = "View Runtimes"
	set desc = "Open the runtime Viewer"

	if(!holder)
		return

	GLOB.error_cache.show_to(src)

/client/proc/pump_random_event()
	set category = "Debug"
	set name = "Pump Random Event"
	set desc = "Schedules the event subsystem to fire a new random event immediately. Some events may fire without notification."
	if(!holder)
		return

	SSevents.scheduled = world.time

	message_admins(span_adminnotice("[key_name_admin(src)] pumped a random event."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Pump Random Event")
	log_admin("[key_name(src)] pumped a random event.")

/client/proc/start_line_profiling()
	set category = "Profile"
	set name = "Start Line Profiling"
	set desc = "Starts tracking line by line profiling for code lines that support it"

	LINE_PROFILE_START

	message_admins(span_adminnotice("[key_name_admin(src)] started line by line profiling."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Start Line Profiling")
	log_admin("[key_name(src)] started line by line profiling.")

/client/proc/stop_line_profiling()
	set category = "Profile"
	set name = "Stops Line Profiling"
	set desc = "Stops tracking line by line profiling for code lines that support it"

	LINE_PROFILE_STOP

	message_admins(span_adminnotice("[key_name_admin(src)] stopped line by line profiling."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Stop Line Profiling")
	log_admin("[key_name(src)] stopped line by line profiling.")

/client/proc/show_line_profiling()
	set category = "Profile"
	set name = "Show Line Profiling"
	set desc = "Shows tracked profiling info from code lines that support it"

	var/sortlist = list(
		"Avg time"		=	/proc/cmp_profile_avg_time_dsc,
		"Total Time"	=	/proc/cmp_profile_time_dsc,
		"Call Count"	=	/proc/cmp_profile_count_dsc
	)
	var/sort = input(src, "Sort type?", "Sort Type", "Avg time") as null|anything in sortlist
	if (!sort)
		return
	sort = sortlist[sort]
	profile_show(src, sort)

/client/proc/reload_configuration()
	set category = "Debug"
	set name = "Reload Configuration"
	set desc = "Force config reload to world default"
	if(!check_rights(R_DEBUG))
		return
	if(alert(usr, "Are you absolutely sure you want to reload the configuration from the default path on the disk, wiping any in-round modificatoins?", "Really reset?", "No", "Yes") == "Yes")
		config.admin_reload()

GLOBAL_LIST_EMPTY(gun_balance_list)

/// Numbers only! The sorting algorithm won't accept text inputs.
#define GUN_BALANCE_SORTING_TPYES list("dps", "dps_with_bane", "avg_dam", "mode_dam", "draw_time_sec", "burst_length_sec", "dam_per_mag", "rpm", "bonus_bane_dam", "loot_chance_%")

GLOBAL_LIST_INIT(gun_loot_tables, list(/obj/effect/spawner/lootdrop/f13/trash_guns,
										/obj/effect/spawner/lootdrop/f13/common_guns,
										/obj/effect/spawner/lootdrop/f13/uncommon_guns,
										/obj/effect/spawner/lootdrop/f13/rare_guns,
										/obj/effect/spawner/lootdrop/f13/common_cowboy,
										/obj/effect/spawner/lootdrop/f13/uncommon_cowboy,
										/obj/effect/spawner/lootdrop/f13/rare_cowboy,
										/obj/effect/spawner/lootdrop/f13/common_energy,
										/obj/effect/spawner/lootdrop/f13/uncommon_energy,
										/obj/effect/spawner/lootdrop/f13/rare_energy
										))

/client/proc/print_gun_debug_information()
	set category = "Debug"
	set name = "Gun Debug Info"
	set desc = "(LAG & MEMORY WARNING) Makes an enormous list of every gun and its stats. Only intended to be used on a local server."
	
	if(!check_rights(R_DEBUG))
		return

	var/safety = alert(usr, "Are you absolutely sure you want to make a giant, laggy, memory-hogging list of every gun's stats? DON'T USE THIS IN A LIVE ROUND. Will create some runtime errors.", "Really do it?", "No", "Yes")
	if(safety == "No")
		return

	var/whatdo = "Use Existing List"
	if(LAZYLEN(GLOB.gun_balance_list))
		whatdo = input(usr, "A gun balance list already exists, what do???", "Do what to the existing gun list", "Use Existing List") as null|anything in list("Clear it & Cancel", "Use Existing List", "Clear it & Continue")
		if(whatdo == "Clear it & Cancel")
			LAZYCLEARLIST(GLOB.gun_balance_list)
			return
		if(whatdo == "Clear it & Continue")
			LAZYCLEARLIST(GLOB.gun_balance_list)

	var/static/prev_loot
	var/loot_table = input(usr, "Use a specific loot table?", "Loot Table", "All Guns") as null|anything in GLOB.gun_loot_tables+list("All Guns")
	if(isnull(loot_table))
		return
	if(loot_table != prev_loot)
		LAZYCLEARLIST(GLOB.gun_balance_list)

	var/sorttype = input(usr, "How would you like to sort the list?", "Sorting Type", "dps") as null|anything in GUN_BALANCE_SORTING_TPYES
	if(isnull(sorttype))
		return

	log_and_message_admins("[ADMIN_PP(usr)] is generating a huge gun balance list. If this is a live round, kill them and then run Gun-Debug-Info and select \"Clear it & Cancel\" after the safety check.")
	
	var/list/all_guns = list()
	var/list/loot_chances = list()
	if(loot_table == "All Guns")
		var/static/list/ballistic_types = list()
		if(!LAZYLEN(ballistic_types))
			ballistic_types = subtypesof(/obj/item/gun/ballistic)
		to_chat(usr, "Found [LAZYLEN(ballistic_types)] ballistic weapons...")
		var/static/list/energy_types = list()
		if(!LAZYLEN(energy_types))
			energy_types = subtypesof(/obj/item/gun/energy)
		to_chat(usr, "Found [LAZYLEN(energy_types)] energy weapons...")
		all_guns = ballistic_types + energy_types

	else if(ispath(loot_table, /obj/effect/spawner/lootdrop))
		var/obj/effect/spawner/lootdrop/ld = new loot_table()
		var/list/looties = ld.loot
		if(!LAZYLEN(looties))
			to_chat("ERROR: [ld]'s loot list was empty!")
			return
		var/tot_weight = 0
		for(var/g in looties)
			tot_weight += looties[g]
			all_guns |= g
		if(tot_weight < 1)
			to_chat("ERROR: [ld] was skipped because it has no weights!")
			return
		for(var/g in looties)
			loot_chances[g] = (looties[g]/tot_weight)*100//% chance for this specific loot drop

	to_chat(usr, "Processing [LAZYLEN(all_guns)] total weapons...")
	if(!LAZYLEN(GLOB.gun_balance_list))
		for(var/gunthing in all_guns)
			gunthing = new gunthing()//We need to instantiate these guns because many of their stats don't exist until they've Init'd
			if(istype(gunthing, /obj/item/gun/ballistic))
				var/obj/item/gun/ballistic/G = gunthing
				///mean (average) damage
				var/avg_dam
				var/min_dam
				var/max_dam
				///Most common (mode) damage
				var/mode_dam
				var/dam_mult = G.damage_multiplier
				var/g_dps
				//Derived from init_mag_type on gun
				var/obj/item/ammo_box/magazine/mag
				var/mag_cap
				var/dam_per_mag
				var/burst_length_seconds
				//Derived from magazine
				var/obj/item/ammo_casing/g_casing
				//Derived from the casing
				var/obj/item/projectile/g_bullet
				//The highest rpm on the weapon divided by 60
				var/g_rps
				var/g_draw_time = G.draw_time
				if(G.init_mag_type)
					mag = new G.init_mag_type()
				if(!mag && G.mag_type)
					mag = new G.mag_type()
				if(mag)
					g_casing = new mag.ammo_type()
					mag_cap = mag.max_ammo
					g_bullet = new g_casing.projectile_type()
				if(!g_casing || !g_bullet)
					to_chat(usr, span_warning("ERROR: [G] ([G.type]) either has no casing, bullet, or magazine defined!"))
					continue
				if(isnull(dam_mult))
					dam_mult = 1
				//Firing speed
				var/list/fire_modes = G.firemodes
				if(!LAZYLEN(fire_modes))
					G.initialize_firemodes()
					fire_modes = G.firemodes
					if(!LAZYLEN(fire_modes))
						to_chat(usr, span_warning("ERROR: [G] ([G.type]) is missing fire modes and has been skipped."))
						continue
				for(var/f in fire_modes)
					var/datum/firemode/fm = f
					var/fm_rps = min((fm.get_fire_delay(TRUE)*fm.burst_count)/60, fm.get_fire_delay(TRUE)/60)// rounds per minute / 60 = rounds per second
					if(fm_rps > g_rps || isnull(g_rps))//We only care about the highest rounds per second achievable
						g_rps = fm_rps
				if(!g_rps)//Fallback to using the first firemode in the list, which is usually the highest rpm one
					var/datum/firemode/fm = fire_modes[1]
					var/fm_rps = fm.get_fire_delay(TRUE)/60// rounds per minute / 60 = rounds per second
					if(fm_rps > g_rps || isnull(g_rps))//We only care about the highest rounds per second achievable
						g_rps = fm_rps
				//Bullet damage calculations
				var/list/dam_list = g_bullet.damage_list
				if(LAZYLEN(dam_list))
					var/tot_dam = 0 //sum of damage
					var/tot_weight = 0 //sum of the weights
					var/chonk = 0 //sum of dam*weight
					var/mode_w = 0
					for(var/d in dam_list)
						var/bdam = (text2num(d)*dam_mult)*g_casing.pellets
						var/bweight = dam_list[d]
						tot_dam += bdam
						tot_weight += bweight
						chonk += (bdam*bweight)
						if(bdam > max_dam || isnull(max_dam))
							max_dam = bdam
						if(bdam < min_dam || isnull(min_dam))
							min_dam = bdam
						if(bweight > mode_w)
							mode_dam = bdam
							mode_w = bweight
					if(tot_dam && chonk)
						avg_dam = chonk / tot_weight //dividing the weighted sum by the total sum of the weights
				else
					var/dd = (initial(g_bullet.damage)*dam_mult)*g_casing.pellets
					avg_dam = dd
					min_dam = dd
					max_dam = dd
					mode_dam = dd
				if(!isnull(g_rps) && !isnull(avg_dam))
					g_dps = avg_dam*g_rps
				if(avg_dam && mag_cap)
					dam_per_mag = avg_dam * mag_cap
				if(mag_cap && g_rps)
					burst_length_seconds = mag_cap / g_rps
				GLOB.gun_balance_list[G.type] = list(
													"name" = G.name,
													"dps" = g_dps,
													"dps_with_bane" = (avg_dam+(g_bullet.supereffective_damage*dam_mult)*g_casing.pellets)*g_rps,
													"rps" = g_rps,
													"rpm" = g_rps*60,
													"avg_dam" = avg_dam,
													"mode_dam" = mode_dam,
													"bullet" = g_bullet.name,
													"draw_time_sec" = g_draw_time/10,
													"mag_capacity" = mag_cap,
													"burst_length_sec" = burst_length_seconds,
													"dam_per_mag" = dam_per_mag,
													"bonus_bane_dam" = (g_bullet.supereffective_damage*dam_mult)*g_casing.pellets,
													"loot_chance_%" = LAZYLEN(loot_chances) ? loot_chances?[G.type] : 0
													)
			//End ballistic code

			////////////////////

			//Start energy code
			//if(istype(gunthing, /obj/item/gun/energy))
			else if(istype(gunthing, /obj/item/gun/energy))
				var/obj/item/gun/energy/G = gunthing
				var/avg_dam
				var/min_dam
				var/max_dam
				var/mode_dam
				var/dam_mult = G.damage_multiplier
				var/g_dps
				//Derived from init_mag_type on gun
				var/obj/item/stock_parts/cell/cell = G.cell
				if(isnull(cell))
					cell = new G.cell_type()
				var/cell_max_charge = cell.maxcharge
				var/charge_per_shot
				var/g_shot_charge_mult = 1
				var/shots_per_cell
				var/dam_per_cell
				var/burst_length_seconds
				//Derived from magazine
				var/obj/item/ammo_casing/g_casing
				//Derived from the casing
				var/obj/item/projectile/g_bullet
				//The highest rpm on the weapon divided by 60
				var/g_rps
				var/g_draw_time = G.draw_time
				if(!LAZYLEN(G.ammo_type))
					to_chat(usr, span_warning("ERROR: [G] ([G.type]) has no ammo types and has been skipped."))
					continue

				//Energy Projectile Damage
				var/mycasing = G.ammo_type[1]//This is probably the right one :)
				if(!isobj(mycasing))
					g_casing = new mycasing(G)
				else
					g_casing = mycasing
				g_bullet = new g_casing.projectile_type(G)

				//RPM & RPS
				var/list/fire_modes = G.firemodes
				if(!LAZYLEN(fire_modes))
					G.initialize_firemodes()
					fire_modes = G.firemodes
					if(!LAZYLEN(fire_modes))
						to_chat(usr, span_warning("ERROR: [G] is missing fire modes and has been skipped."))
						continue
				for(var/f in fire_modes)
					var/datum/firemode/fm = f
					var/fm_rps = fm.get_fire_delay(TRUE)/60// rounds per minute / 60 = rounds per second
					if(fm_rps > g_rps || isnull(g_rps))//We only care about the highest rounds per second achievable
						g_rps = fm_rps
						g_shot_charge_mult = max(G.charge_cost_multiplier * fm.shot_cost_multiplier, 0.1)
				if(!g_rps)//Fallback to using the first firemode in the list, which is usually the highest rpm one
					var/datum/firemode/fm = fire_modes[1]
					var/fm_rps = fm.get_fire_delay(TRUE)/60// rounds per minute / 60 = rounds per second
					if(fm_rps > g_rps || isnull(g_rps))//We only care about the highest rounds per second achievable
						g_rps = fm_rps
						g_shot_charge_mult = max(G.charge_cost_multiplier * fm.shot_cost_multiplier, 0.1)
				charge_per_shot = g_casing.e_cost*(g_shot_charge_mult)

				//Start avg, mode, min, & max calcs
				if(g_bullet && g_rps)
					var/list/dam_list = initial(g_bullet.damage_list)
					if(LAZYLEN(dam_list))
						var/tot_dam = 0 //sum of damage
						var/tot_weight = 0 //sum of the weights
						var/chonk = 0 //sum of dam*weight
						var/mode_w = 0
						for(var/d in dam_list)
							var/bdam = (text2num(d)*dam_mult)*g_casing.pellets
							var/bweight = dam_list[d]
							tot_dam += bdam
							tot_weight += bweight
							chonk += (bdam*bweight)
							if(bdam > max_dam || isnull(max_dam))
								max_dam = bdam
							if(bdam < min_dam || isnull(min_dam))
								min_dam = bdam
							if(bweight > mode_w)
								mode_dam = bdam
								mode_w = bweight
						if(tot_dam && chonk)
							avg_dam = chonk / tot_weight //dividing the weighted sum by the total sum of the weights
					else
						var/dd = (initial(g_bullet.damage)*dam_mult)*g_casing.pellets
						avg_dam = dd
						min_dam = dd
						max_dam = dd
						mode_dam = dd
				else
					to_chat(usr,"ERROR: [G] ([G.type]) either has no bullet, or rps!")
					continue
				// Wrapping up
				if(charge_per_shot > 0)
					shots_per_cell = cell_max_charge / charge_per_shot
				else
					shots_per_cell = 1
				dam_per_cell = shots_per_cell * avg_dam
				burst_length_seconds = shots_per_cell / g_rps
				g_dps = avg_dam * g_rps

				//You made the cut, buddy.
				GLOB.gun_balance_list[G.type] = list(
													"name" = G.name,
													"dps" = g_dps,
													"dps_with_bane" = (avg_dam+(g_bullet.supereffective_damage*dam_mult)*g_casing.pellets)*g_rps,
													"rps" = g_rps,
													"rpm" = g_rps*60,
													"avg_dam" = avg_dam,
													"mode_dam" = mode_dam,
													"bullet" = initial(g_bullet.name),
													"draw_time_sec" = g_draw_time/10,
													"mag_capacity" = shots_per_cell,
													"burst_length_sec" = burst_length_seconds,
													"dam_per_mag" = dam_per_cell,
													"bonus_bane_dam" = (g_bullet.supereffective_damage*dam_mult)*g_casing.pellets,
													"loot_chance_%" = LAZYLEN(loot_chances) ? loot_chances?[G.type] : 0
													)
				//End energy weapons
			else
				to_chat(usr, span_warning("ERROR: [gunthing] is not a supported weapon type and has been skipped."))
				continue

	if(LAZYLEN(GLOB.gun_balance_list))
		to_chat(usr, "Sorting list by [sorttype]...")
		var/list/sortinglist = list()
		for(var/gg in GLOB.gun_balance_list)
			sortinglist[gg] = GLOB.gun_balance_list[gg][sorttype]//Associate the sorting value to the key
		sortTim(sortinglist, GLOBAL_PROC_REF(cmp_numeric_dsc), associative = TRUE)//Sort the DPS associations
		for(var/gs in sortinglist)//Re-add the other variables
			sortinglist[gs] = GLOB.gun_balance_list[gs]
		GLOB.gun_balance_list = LAZYCOPY(sortinglist)//Copy the temporary sorted list into the global list
	to_chat(usr, "[LAZYLEN(GLOB.gun_balance_list)] weapons sacrificed to the guns balance list!")
	to_chat(usr, span_notice("Output saved to global list \"gun_balance_list\". To access, press \"Edit\" next to \"Globals\" in your MC tab \
							and use the search bar. It will also open automatically in 1 second for your convenience, so if it never opens then something broke!"))
	spawn(10) debug_variables(GLOB.gun_balance_list)

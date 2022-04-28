//Keeps track of the time for the ID console. Having it as a global variable prevents people from dismantling/reassembling it to
//increase the slots of many jobs.
GLOBAL_VAR_INIT(time_last_changed_position, 0)

/obj/machinery/computer/card
	name = "identification console"
	desc = "You can use this to manage jobs and ID access."
	icon_screen = "id"
	icon_keyboard = "id_key"
	req_one_access = list(ACCESS_HEADS, ACCESS_CHANGE_IDS)
	circuit = /obj/item/circuitboard/computer/card
	var/mode = 0
	var/target_dept = 0 //Which department this computer has access to. 0=all departments

	//Jobs that you can choose in ID console.
	var/list/job_list

	//Assigned_role that can use it. If empty - everyone can.
	var/list/job_req = list("CentCom Official", "CentCom Commander", "Death")

	var/obj/item/card/id/inserted_scan_id
	var/obj/item/card/id/inserted_modify_id
	var/list/region_access = null
	var/list/head_subordinates = null

	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/card/proc/get_jobs()
	return get_all_jobs()

/obj/machinery/computer/card/centcom/get_jobs()
	return get_all_centcom_jobs()

/obj/machinery/computer/card/Initialize()
	. = ..()
	if(!job_list)
		job_list = get_all_jobs()

/obj/machinery/computer/card/examine(mob/user)
	. = ..()
	if(inserted_scan_id || inserted_modify_id)
		. += "<span class='notice'>Alt-click to eject the ID card.</span>"

/obj/machinery/computer/card/attackby(obj/I, mob/user, params)
	if(isidcard(I))
		if(check_access(I) && !inserted_scan_id)
			if(id_insert(user, I, inserted_scan_id))
				inserted_scan_id = I
				updateUsrDialog()
		else if(id_insert(user, I, inserted_modify_id))
			inserted_modify_id = I
			updateUsrDialog()
	else
		return ..()

/obj/machinery/computer/card/Destroy()
	if(inserted_scan_id)
		qdel(inserted_scan_id)
		inserted_scan_id = null
	if(inserted_modify_id)
		qdel(inserted_modify_id)
		inserted_modify_id = null
	return ..()

/obj/machinery/computer/card/handle_atom_del(atom/A)
	..()
	if(A == inserted_scan_id)
		inserted_scan_id = null
		updateUsrDialog()
	if(A == inserted_modify_id)
		inserted_modify_id = null
		updateUsrDialog()

/obj/machinery/computer/card/on_deconstruction()
	if(inserted_scan_id)
		inserted_scan_id.forceMove(drop_location())
		inserted_scan_id = null
	if(inserted_modify_id)
		inserted_modify_id.forceMove(drop_location())
		inserted_modify_id = null


/obj/machinery/computer/card/proc/id_insert(mob/user, obj/item/inserting_item, obj/item/target)
	var/obj/item/card/id/card_to_insert = inserting_item
	var/holder_item = FALSE

	if(!isidcard(card_to_insert))
		card_to_insert = inserting_item.RemoveID()
		holder_item = TRUE

	if(!card_to_insert || !user.transferItemToLoc(card_to_insert, src))
		return FALSE

	if(target)
		if(holder_item && inserting_item.InsertID(target))
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		else
			id_eject(user, target)

	user.visible_message("<span class='notice'>[user] inserts \the [card_to_insert] into \the [src].</span>",
						"<span class='notice'>You insert \the [card_to_insert] into \the [src].</span>")
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	updateUsrDialog()
	return TRUE

/obj/machinery/computer/card/proc/id_eject(mob/user, obj/target)
	if(!target)
		to_chat(user, "<span class='warning'>That slot is empty!</span>")
		return FALSE
	else
		target.forceMove(drop_location())
		if(!issilicon(user) && Adjacent(user))
			user.put_in_hands(target)
		user.visible_message("<span class='notice'>[user] gets \the [target] from \the [src].</span>", \
							"<span class='notice'>You get \the [target] from \the [src].</span>")
		playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		updateUsrDialog()
		return TRUE

/obj/machinery/computer/card/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, !hasSiliconAccessInArea(user)) || !is_operational())
		return
	if(inserted_modify_id)
		if(id_eject(user, inserted_modify_id))
			inserted_modify_id = null
			updateUsrDialog()
			return TRUE
	if(inserted_scan_id)
		if(id_eject(user, inserted_scan_id))
			inserted_scan_id = null
			updateUsrDialog()
			return TRUE

/obj/machinery/computer/card/ui_interact(mob/user)
	if(LAZYLEN(job_req) && !(user.mind?.assigned_role in job_req))
		to_chat(user, "<span class='warning'>You have no idea how to use it...</span>")
		return
	. = ..()
	var/list/dat = list()

	var/list/header = list()

	var/scan_name = inserted_scan_id ? html_encode(inserted_scan_id.name) : "--------"
	var/target_name = inserted_modify_id ? html_encode(inserted_modify_id.name) : "--------"
	var/target_owner = (inserted_modify_id && inserted_modify_id.registered_name) ? html_encode(inserted_modify_id.registered_name) : "--------"
	var/target_rank = (inserted_modify_id && inserted_modify_id.assignment) ? html_encode(inserted_modify_id.assignment) : "Unassigned"

	if(!authenticated)
		header += {"<br><i>Please insert the cards into the slots</i><br>
			Target: <a href='?src=[REF(src)];choice=inserted_modify_id'>[target_name]</a><br>
			Confirm Identity: <a href='?src=[REF(src)];choice=inserted_scan_id'>[scan_name]</a><br>"}
	else
		header += {"<div align='center'><br>
			Target: <a href='?src=[REF(src)];choice=inserted_modify_id'>Remove [target_name]</a> ||
			Confirm Identity: <a href='?src=[REF(src)];choice=inserted_scan_id'>Remove [scan_name]</a><br>
			<a href='?src=[REF(src)];choice=logout'>Log Out</a></div>"}

	header += "<hr>"

	var/body

	if (authenticated && inserted_modify_id)
		var/list/carddesc = list()
		var/list/jobs = list()
		if (authenticated == 2)
			var/list/jobs_all = list()
			for(var/job in (list("Unassigned") + job_list))
				jobs_all += "<a href='?src=[REF(src)];choice=assign;assign_target=[job]'>[replacetext(job, " ", "&nbsp;")]</a> " //make sure there isn't a line break in the middle of a job
			carddesc += {"<script type="text/javascript">
								function markRed(){
									var nameField = document.getElementById('namefield');
									nameField.style.backgroundColor = "#FFDDDD";
								}
								function markGreen(){
									var nameField = document.getElementById('namefield');
									nameField.style.backgroundColor = "#DDFFDD";
								}
								function showAll(){
									var allJobsSlot = document.getElementById('alljobsslot');
									allJobsSlot.innerHTML = "<a href='#' onclick='hideAll()'>hide</a><br>"+ "[jobs_all.Join()]";
								}
								function hideAll(){
									var allJobsSlot = document.getElementById('alljobsslot');
									allJobsSlot.innerHTML = "<a href='#' onclick='showAll()'>show</a>";
								}
							</script>"}
			carddesc += {"<form name='cardcomp' action='?src=[REF(src)]' method='get'>
				<input type='hidden' name='src' value='[REF(src)]'>
				<input type='hidden' name='choice' value='reg'>
				<b>registered name:</b> <input type='text' id='namefield' name='reg' value='[target_owner]' style='width:250px; background-color:white;' onchange='markRed()'>
				<input type='submit' value='Rename' onclick='markGreen()'>
				</form>
				<b>Assignment:</b> "}

			jobs += "<span id='alljobsslot'><a href='#' onclick='showAll()'>[target_rank]</a></span>" //CHECK THIS

		else
			carddesc += "<b>registered_name:</b> [target_owner]</span>"
			jobs += "<b>Assignment:</b> [target_rank] (<a href='?src=[REF(src)];choice=demote'>Demote</a>)</span>"

		var/list/accesses = list()
		if(istype(src, /obj/machinery/computer/card/centcom)) // REE
			accesses += "<h5>Central Command:</h5>"
			for(var/A in get_all_centcom_access())
				if(A in inserted_modify_id.access)
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=0'><font color=\"6bc473\">[replacetext(get_centcom_access_desc(A), " ", "&nbsp")]</font></a> "
				else
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=1'>[replacetext(get_centcom_access_desc(A), " ", "&nbsp")]</a> "
		else if(istype(src, /obj/machinery/computer/card/ncr)) // Ree, I guess
			accesses += "<h5>New Californian Republic:</h5>"
			for(var/A in get_all_ncr_access())
				if(A in inserted_modify_id.access)
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=0'><font color=\"6bc473\">[replacetext(get_ncr_access_desc(A), " ", "&nbsp")]</font></a> "
				else
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=1'>[replacetext(get_ncr_access_desc(A), " ", "&nbsp")]</a> "
		else if(istype(src, /obj/machinery/computer/card/legion))
			accesses += "<h5>Caesar's Legion:</h5>"
			for(var/A in get_all_legion_access())
				if(A in inserted_modify_id.access)
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=0'><font color=\"6bc473\">[replacetext(get_legion_access_desc(A), " ", "&nbsp")]</font></a> "
				else
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=1'>[replacetext(get_legion_access_desc(A), " ", "&nbsp")]</a> "
		else if(istype(src, /obj/machinery/computer/card/enclave))
			accesses += "<h5>Enclave:</h5>"
			for(var/A in get_all_enclave_access())
				if(A in inserted_modify_id.access)
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=0'><font color=\"6bc473\">[replacetext(get_enclave_access_desc(A), " ", "&nbsp")]</font></a> "
				else
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=1'>[replacetext(get_enclave_access_desc(A), " ", "&nbsp")]</a> "
		else if(istype(src, /obj/machinery/computer/card/bos))
			accesses += "<h5>Brotherhood of Steel:</h5>"
			for(var/A in get_all_bos_access())
				if(A in inserted_modify_id.access)
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=0'><font color=\"6bc473\">[replacetext(get_bos_access_desc(A), " ", "&nbsp")]</font></a> "
				else
					accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=1'>[replacetext(get_bos_access_desc(A), " ", "&nbsp")]</a> "
		else
			accesses += {"<div align='center'><b>Access</b></div>
				<table style='width:100%'>
				<tr>"}
			for(var/i = 1; i <= 7; i++)
				if(authenticated == 1 && !(i in region_access))
					continue
				accesses += "<td style='width:14%'><b>[get_region_accesses_name(i)]:</b></td>"
			accesses += "</tr><tr>"
			for(var/i = 1; i <= 7; i++)
				if(authenticated == 1 && !(i in region_access))
					continue
				accesses += "<td style='width:14%' valign='top'>"
				for(var/A in get_region_accesses(i))
					if(A in inserted_modify_id.access)
						accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=0'><font color=\"6bc473\">[replacetext(get_access_desc(A), " ", "&nbsp")]</font></a> "
					else
						accesses += "<a href='?src=[REF(src)];choice=access;access_target=[A];allowed=1'>[replacetext(get_access_desc(A), " ", "&nbsp")]</a> "
					accesses += "<br>"
				accesses += "</td>"
			accesses += "</tr></table>"
		body = "[carddesc.Join()]<br>[jobs.Join()]<br><br>[accesses.Join()]<hr>" //CHECK THIS

	if(!authenticated)
		body = {"<a href='?src=[REF(src)];choice=auth'>Log In</a><br><hr>"}

	dat = list("<tt>", header.Join(), body, "<br></tt>")
	var/datum/browser/popup = new(user, "id_com", src.name, 900, 620)
	popup.set_content(dat.Join())
	popup.open()

/obj/machinery/computer/card/Topic(href, href_list)
	if(..())
		return

	if(!usr.canUseTopic(src, !hasSiliconAccessInArea(usr)) || !is_operational())
		usr.unset_machine()
		usr << browse(null, "window=id_com")
		return

	usr.set_machine(src)
	switch(href_list["choice"])
		if ("inserted_modify_id")
			if(inserted_modify_id && !usr.get_active_held_item())
				if(id_eject(usr, inserted_modify_id))
					inserted_modify_id = null
					updateUsrDialog()
					return
			if(usr.get_id_in_hand())
				var/obj/item/held_item = usr.get_active_held_item()
				var/obj/item/card/id/id_to_insert = held_item.GetID()
				if(id_insert(usr, held_item, inserted_modify_id))
					inserted_modify_id = id_to_insert
					updateUsrDialog()
		if ("inserted_scan_id")
			if(inserted_scan_id && !usr.get_active_held_item())
				if(id_eject(usr, inserted_scan_id))
					inserted_scan_id = null
					updateUsrDialog()
					return
			if(usr.get_id_in_hand())
				var/obj/item/held_item = usr.get_active_held_item()
				var/obj/item/card/id/id_to_insert = held_item.GetID()
				if(id_insert(usr, held_item, inserted_scan_id))
					inserted_scan_id = id_to_insert
					updateUsrDialog()
		if ("auth")
			if ((!( authenticated ) && (inserted_scan_id || hasSiliconAccessInArea(usr)) || mode))
				if (check_access(inserted_scan_id))
					region_access = list()
					head_subordinates = list()
					if(ACCESS_CHANGE_IDS in inserted_scan_id.access)
						if(target_dept)
							head_subordinates = get_all_jobs()
							region_access |= target_dept
							authenticated = 1
						else
							authenticated = 2
						playsound(src, 'sound/machines/terminal_on.ogg', 50, FALSE)

					else
						if((ACCESS_HOP in inserted_scan_id.access) && ((target_dept==1) || !target_dept))
							region_access |= 1
							get_subordinates("Head of Personnel")
						if((ACCESS_HOS in inserted_scan_id.access) && ((target_dept==2) || !target_dept))
							region_access |= 2
							get_subordinates("Head of Security")
						if((ACCESS_CMO in inserted_scan_id.access) && ((target_dept==3) || !target_dept))
							region_access |= 3
							get_subordinates("Chief Medical Officer")
						if((ACCESS_RD in inserted_scan_id.access) && ((target_dept==4) || !target_dept))
							region_access |= 4
							get_subordinates("Research Director")
						if((ACCESS_CE in inserted_scan_id.access) && ((target_dept==5) || !target_dept))
							region_access |= 5
							get_subordinates("Chief Engineer")
						if((ACCESS_QM in inserted_scan_id.access) && ((target_dept==6) || !target_dept))
							region_access |= 6
							get_subordinates("Quartermaster")
						if(region_access)
							authenticated = 1
			else if ((!( authenticated ) && hasSiliconAccessInArea(usr)) && (!inserted_modify_id))
				to_chat(usr, "<span class='warning'>You can't modify an ID without an ID inserted to modify! Once one is in the modify slot on the computer, you can log in.</span>")
		if ("logout")
			region_access = null
			head_subordinates = null
			authenticated = 0
			playsound(src, 'sound/machines/terminal_off.ogg', 50, FALSE)

		if("access")
			if(href_list["allowed"])
				if(authenticated)
					var/access_type = text2num(href_list["access_target"])
					var/access_allowed = text2num(href_list["allowed"])
					var/list/access_types
					if(istype(src, /obj/machinery/computer/card/centcom))
						access_types = get_all_centcom_access()
					else if(istype(src, /obj/machinery/computer/card/ncr))
						access_types = get_all_ncr_access()
					else if(istype(src, /obj/machinery/computer/card/legion))
						access_types = get_all_legion_access()
					else if(istype(src, /obj/machinery/computer/card/enclave))
						access_types = get_all_enclave_access()
					else if(istype(src, /obj/machinery/computer/card/bos))
						access_types = get_all_bos_access()
					else
						access_types = get_all_accesses()

					if(access_type in access_types)
						inserted_modify_id.access -= access_type
						if(access_allowed == 1)
							inserted_modify_id.access += access_type
						playsound(src, "terminal_type", 50, FALSE)
		if ("assign")
			if (authenticated == 2)
				var/t1 = href_list["assign_target"]
				if(t1 == "Custom")
					var/newJob = reject_bad_text(input("Enter a custom job assignment.", "Assignment", inserted_modify_id ? inserted_modify_id.assignment : "Unassigned"), MAX_NAME_LEN)
					if(newJob)
						t1 = newJob

				else if(t1 == "Unassigned")
					inserted_modify_id.access -= get_all_accesses()

				else
					var/datum/job/jobdatum
					for(var/jobtype in typesof(/datum/job))
						var/datum/job/J = new jobtype
						if(ckey(J.title) == ckey(t1))
							jobdatum = J
							updateUsrDialog()
							break
					if(!jobdatum)
						to_chat(usr, "<span class='alert'>No log exists for this job.</span>")
						updateUsrDialog()
						return
					if(inserted_modify_id.registered_account)
						inserted_modify_id.registered_account.account_job = jobdatum // this is a terrible idea and people will grief but sure whatever
					inserted_modify_id.access = ( istype(src, /obj/machinery/computer/card/centcom) ? get_centcom_access(t1) : jobdatum.get_access() )
				if (inserted_modify_id)
					inserted_modify_id.assignment = t1
					playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)
		if ("demote")
			if(inserted_modify_id.assignment in head_subordinates || inserted_modify_id.assignment == "Assistant")
				inserted_modify_id.assignment = "Unassigned"
				playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)
			else
				to_chat(usr, "<span class='alert'>You are not authorized to demote this position.</span>")
		if ("reg")
			if (authenticated)
				var/t2 = inserted_modify_id
				if ((authenticated && inserted_modify_id == t2 && (in_range(src, usr) || hasSiliconAccessInArea(usr)) && isturf(loc)))
					var/newName = reject_bad_name(href_list["reg"])
					if(newName)
						inserted_modify_id.registered_name = newName
						playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)
					else
						to_chat(usr, "<span class='alert'>Invalid name entered.</span>")
						updateUsrDialog()
						return
		if ("mode")
			mode = text2num(href_list["mode_target"])

		if("return")
			//DISPLAY MAIN MENU
			mode = 3;
			playsound(src, "terminal_type", 25, FALSE)

	if (inserted_modify_id)
		inserted_modify_id.update_label()
	updateUsrDialog()

/obj/machinery/computer/card/proc/get_subordinates(rank)
	for(var/datum/job/job in SSjob.occupations)
		if(rank in job.department_head)
			head_subordinates += job.title

/obj/machinery/computer/card/centcom
	name = "\improper CentCom identification console"
	circuit = /obj/item/circuitboard/computer/card/centcom
	req_access = list(ACCESS_CENT_CAPTAIN)

/obj/machinery/computer/card/minor
	name = "department management console"
	desc = "You can use this to change ID's for specific departments."
	icon_screen = "idminor"
	circuit = /obj/item/circuitboard/computer/card/minor

/obj/machinery/computer/card/minor/Initialize()
	. = ..()
	var/obj/item/circuitboard/computer/card/minor/typed_circuit = circuit
	if(target_dept)
		typed_circuit.target_dept = target_dept
	else
		target_dept = typed_circuit.target_dept
	var/list/dept_list = list("civilian","security","medical","science","engineering","cargo")
	name = "[dept_list[target_dept]] department console"

/obj/machinery/computer/card/minor/hos
	target_dept = 2
	icon_screen = "idhos"

	light_color = LIGHT_COLOR_RED

/obj/machinery/computer/card/minor/cmo
	target_dept = 3
	icon_screen = "idcmo"

/obj/machinery/computer/card/minor/rd
	target_dept = 4
	icon_screen = "idrd"

	light_color = LIGHT_COLOR_PINK

/obj/machinery/computer/card/minor/ce
	target_dept = 5
	icon_screen = "idce"

	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/computer/card/minor/qm
	target_dept = 6
	icon_screen = "idqm"

	light_color = LIGHT_COLOR_ORANGE

/obj/machinery/computer/card/ncr
	name = "\improper NCR identification console"
	circuit = /obj/item/circuitboard/computer/card/ncr
	// The job list is here so only specific titles are allowed.
	job_list = list(
		"NCR Citizen",
		"NCR Trooper",
		"NCR Corporal",
		"NCR Combat Medic",
		"NCR Combat Engineer",
		"NCR Sergeant",
		)
	job_req = list(
		"NCR Colonel",
		"NCR Captain",
		"NCR Lieutenant",
		)

/obj/machinery/computer/card/legion
	name = "\improper Legion identification console"
	circuit = /obj/item/circuitboard/computer/card/legion
	// tl;dr - We don't need more Centurions.
	job_list = list(
		"Legion Slave",
		"Legion Citizen",
		"Recruit Legionnaire",
		"Prime Legionnaire",
		"Veteran Legionnaire",
		)
	job_req = list(
		"Legate",
		"Legion Centurion",
		"Legion Veteran Decanus",
		)

/obj/machinery/computer/card/enclave
	name = "\improper Enclave identification console"
	circuit = /obj/item/circuitboard/computer/card/enclave
	job_list = list(
		"Enclave Sergeant",
		"Enclave Private",
		"Enclave Bunker Duty",
		"American Citizen",
		)
	job_req = list(
		"Enclave Lieutenant",
		"Enclave Master Sergeant",
		)

/obj/machinery/computer/card/bos
	name = "\improper Brotherhood of Steel identification console"
	circuit = /obj/item/circuitboard/computer/card/bos
	job_list = list(
		"Paladin",
		"Scribe",
		"Junior Scribe",
		"Knight",
		"Junior Knight",
		"Initiate",
		)
	job_req = list(
		"Elder",
		"Head Paladin",
		"Head Scribe",
		"Head Knight",
		)

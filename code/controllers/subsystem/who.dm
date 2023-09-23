#define AWHO_RANK "RANK"
#define AWHO_CKEY "CKEY"
#define AWHO_HP "HP"
#define AWHO_SWORD "STATUSWORD"
#define AWHO_SCOLOR "STATUSCOLOR"
#define AWHO_SSPAN "STATUSSPAN"
#define AWHO_COORDS "COORDS"
#define AWHO_ROLE "ROLE"


SUBSYSTEM_DEF(who) // SS who? SS you!
	name = "Who"
	wait = 1 SECONDS
	init_order = INIT_ORDER_WHO
	flags = SS_BACKGROUND

	/// Populated by Region landmarks on Initialize()
	/// Depleted by CatalogueRegionLandmarks() so they can safely be deleted
	var/list/region_landmarks = list()
	var/list/region_hint_solid = list()
	var/list/region_hint_ignore = list()

	/// Populated by CatalogueRegionLandmarks()
	/// format: list("zlvl" = list(/datum/region, /datum/region), ...)
	var/list/regions = list()

	/// For showing coordinates of a player, rounded to the nearest this number
	var/coord_fuzziness = 50
	/// Show coordinates?
	var/show_coords = FALSE

	var/admin_level_to_see_all = R_ADMIN

	var/debug_regions = TRUE

	var/list/save_queue = list()

	var/list/customlist = list()

/datum/controller/subsystem/who/Initialize()
	CatalogueRegionLandmarks()
	..()
	var/numregions = 0
	for(var/zlvl in regions)
		numregions += LAZYLEN(regions[zlvl])
	to_chat(world, span_boldannounce("Initialized [numregions] regions!"))

/datum/controller/subsystem/who/fire(resumed)
	if(!LAZYLEN(save_queue))
		return
	for(var/ck in save_queue)
		var/datum/preferences/P = extract_prefs(ck)
		if(!P)
			save_queue -= ck
			continue // we'll get em when they get back, they aint getting away that easy
		var/which = save_queue[ck]
		if(which == 2)
			P.save_character()
		if(which == 1)
			P.save_preferences()
		which--
		if(which)
			save_queue[ck] = which
		else
			save_queue -= ck
	save_queue.Cut()

/// Initial processing of region landmarks placed by the map
/datum/controller/subsystem/who/proc/CatalogueRegionLandmarks()
	for(var/obj/effect/landmark/region/R in region_landmarks)
		var/datum/region/place = new(R)
		if(!islist(regions["[place.coord_z]"]))
			regions["[place.coord_z]"] = list()
		regions["[place.coord_z]"] |= place
		qdel(R)

/// Post-initialization processing of region landmarks placed by admins or players or something
/datum/controller/subsystem/who/proc/AddRegion(obj/effect/landmark/region/R)
	if(!initialized)
		region_landmarks += R // they'll be batched when we initialize
		return
	var/datum/region/place = new(R)
	if(!islist(regions["[place.coord_z]"]))
		regions["[place.coord_z]"] = list()
	regions["[place.coord_z]"] |= place
	qdel(R)

/// Grabs the player's custom datum thingy, or makes a new one if they don't have one
/datum/controller/subsystem/who/proc/KillCustoms(ckey, why)
	if(!ckey)
		return
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	qdel(WCS)
	customlist -= ckey

/datum/controller/subsystem/who/proc/AdminPanel()
	if(!check_rights(admin_level_to_see_all))
		return
	var/ckey = input(
		usr,
		"Whose custom who info do you want to edit?",
		"TGUI is hard",
	) as null|anything in customlist
	if(!ckey || !(ckey in customlist))
		to_chat(usr, span_notice("Never mind!"))
		return
	var/which_field = input(
		usr,
		"What field do you want to edit?",
		"Name, Role, Where, Pose",
	) as null|anything in list("Name", "Role", "Where", "Pose")
	if(!which_field || !(which_field in list("Name", "Role", "Where", "Pose")))
		to_chat(usr, span_notice("Never mind!"))
		return
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	var/do_what = input(
		usr,
		"What do you want to do?",
		"Set, Clear, Ban, Unban",
	) as null|anything in list("Set", "Clear", "Toggle Ban")
	if(!do_what || !(do_what in list("Set", "Clear", "Toggle Ban")))
		to_chat(usr, span_notice("Never mind!"))
		return
	switch(which_field)
		if("Name")
			if(do_what == "Set")
				SetName(ckey)
			if(do_what == "Clear")
				SetName(ckey, "CLEAR-RESET-DESTROY")
			if(do_what == "Toggle Ban")
				WCS.ToggleLockout(WHO_LOCKOUT_NAME)
		if("Role")
			if(do_what == "Set")
				SetRole(ckey)
			if(do_what == "Clear")
				SetRole(ckey, "CLEAR-RESET-DESTROY")
			if(do_what == "Toggle Ban")
				WCS.ToggleLockout(WHO_LOCKOUT_ROLE)
		if("Where")
			if(do_what == "Set")
				SetWhere(ckey)
			if(do_what == "Clear")
				SetWhere(ckey, "CLEAR-RESET-DESTROY")
			if(do_what == "Toggle Ban")
				WCS.ToggleLockout(WHO_LOCKOUT_WHERE)
		if("Pose")
			if(do_what == "Set")
				SetPose(ckey)
			if(do_what == "Clear")
				SetPose(ckey, "CLEAR-RESET-DESTROY")
			if(do_what == "Toggle Ban")
				WCS.ToggleLockout(WHO_LOCKOUT_POSE)
		else
			to_chat(usr, span_notice("Never mind!"))
			return
	save_queue[ckey] = 2 // its a hack, but im the headdev so its okay

/// Grabs the player's custom datum thingy, or makes a new one if they don't have one
/datum/controller/subsystem/who/proc/GetCustomDatum(ckey)
	if(!ckey)
		return
	var/datum/who_custom_stuff/WCS = LAZYACCESS(customlist, ckey)
	if(!WCS)
		WCS = new(ckey)
		customlist[ckey] = WCS
		customlist = sortNames(customlist)
	return WCS

////////////////////////////////////////////////////////
/// ROLE STUFF
/datum/controller/subsystem/who/proc/SetName(something, override)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	WCS.SetName(override)

/datum/controller/subsystem/who/proc/GetName(something)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	return WCS.GetName(check_rights(admin_level_to_see_all, FALSE))

////////////////////////////////////////////////////////
/// ROLE STUFF
/datum/controller/subsystem/who/proc/SetRole(something, override)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	WCS.SetRole(override)

/datum/controller/subsystem/who/proc/GetRole(something)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	return WCS.GetRole(check_rights(admin_level_to_see_all, FALSE))

////////////////////////////////////////////////////////
/// WHERE STUFF
/datum/controller/subsystem/who/proc/SetWhere(something, override)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	WCS.SetWhere(override)

/datum/controller/subsystem/who/proc/GetWhere(something, override)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	return WCS.GetWhere(check_rights(admin_level_to_see_all, FALSE))

////////////////////////////////////////////////////////
/// POSE STUFF
/datum/controller/subsystem/who/proc/SetPose(something, override)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	WCS.SetPose(override)

/datum/controller/subsystem/who/proc/GetPose(something, parse)
	var/ckey = extract_ckey(something)
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	return WCS.GetPose(check_rights(admin_level_to_see_all, FALSE), parse)

/// cool helper proc that reads something like "QQc3FACE3;Hello, world!" and returns a span with the color and text
/datum/controller/subsystem/who/proc/ParsePoseColor(text)
	if(!text)
		return ""
	var/maybeand = copytext(text, 1, 4)
	if(maybeand != "QQc" || !findtext(text, ";"))
		return text
	text = replacetext(text, maybeand, "")
	var/list/thing_and_text = splittext(text, ";")
	if(LAZYLEN(thing_and_text) != 2)
		return text
	var/colorstring = LAZYACCESS(thing_and_text, 1)
	if(LAZYLEN(colorstring) != 6)
		return text
	var/textstring = LAZYACCESS(thing_and_text, 2)
	var/colo_r1 = copytext(colorstring, 1, 2)
	var/colo_r2 = copytext(colorstring, 2, 3)
	var/colo_g1 = copytext(colorstring, 3, 4)
	var/colo_g2 = copytext(colorstring, 4, 5)
	var/colo_b1 = copytext(colorstring, 5, 6)
	var/colo_b2 = copytext(colorstring, 6, 7)
	return "<span style='color: #[colo_r1][colo_r2][colo_g1][colo_g2][colo_b1][colo_b2]'>[textstring]</span>"

/datum/controller/subsystem/who/proc/WhereAmI(atom/I)
	if(!I)
		return "Your mom's house"
	var/my_z = "[I.z]"
	if(!islist(regions[my_z]))
		regions[my_z] = list()
	var/area/A = get_area(I)
	var/areaname = A ? A.name : "Nowhere"
	if(!areaname || trim(areaname) == "")
		areaname = "the great byond"
	var/my_coords = atom2coords(I)
	var/list/places = list()
	for(var/datum/region/reggie in regions[my_z])
		if(reggie.coord_cache["[my_coords]"])
			places += reggie.name
	var/regs = jointext(places, " / ")
	if(!LAZYLEN(regs))
		var/turf/ceilingcat = get_step_multiz(get_turf(I), UP)
		if(A.outdoors)
			regs = "Outside"
		else if(istype(ceilingcat, /turf/open/transparent/openspace))
			regs = "Under the stars"
		else
			regs = "Indoors"
	return "[A.name] ([regs])"

/datum/controller/subsystem/who/proc/AdminWho(client/whoer)
	return span_alertalien("There are admins online!")

/datum/controller/subsystem/who/proc/WhoPlus(client/whoer)
	Who(whoer, TRUE)

/datum/controller/subsystem/who/proc/Who(client/whoer, verbose)
	var/admeme = check_rights_for(whoer, admin_level_to_see_all) && !(whoer.holder in GLOB.deadmins) // so deadmins can see the normal stuff

	var/list/lines = list()
	///the first line, you!
	lines += Me(whoer)
	/// now, set up the lists of people to show
	var/list/admins = list()
	for(var/client/admn in GLOB.admins)
		var/mob/M = admn.mob
		admins += M // these are mobs
	var/list/mentors = list()
	for(var/client/mntr in GLOB.mentors)
		var/mob/M = mntr.mob
		mentors += M // these are also mobs
	var/list/players = list()
	for(var/mob/plr in GLOB.player_list)
		players += plr // these are also also mobs
	if(admeme) // only admins can see the actual names, so just sort em for them
		admins = sortNames(admins)
		mentors = sortNames(mentors)
	players = sortNames(players)
	lines += "<hr>"
	if(admeme && LAZYLEN(admins))
		lines += span_alertalien("STAFF:")
		for(var/mob/M in admins)
			lines += Mob2Who4AdmemesShort(M)
	else
		lines += span_alertalien("ADMINS: [span_noticealien("PRESENT!")]")
	if(admeme && LAZYLEN(mentors))
		lines += span_alertalien("MENTORS:")
		for(var/mob/M in mentors)
			lines += Mob2Who4AdmemesShort(M)
	else
		lines += span_alertalien("MENTORS: [span_noticealien("PRESENT!")]")
		if(whoer in GLOB.mentors)
			lines += " (And you're one of them! =3)"
	lines += span_alertalien("PLAYERS:")
	for(var/mob/M in players)
		if(verbose)
			if(admeme)
				lines += Mob2Who4Admemes(M)
			else
				lines += Mob2WhoLine(M)
		else
			if(admeme)
				lines += Mob2Who4AdmemesShort(M)
			else
				lines += Mob2WhoLineShort(M)
	lines += "<b>Total Players Online: [length(GLOB.clients)]</b>"
	if(admeme)
		lines += "<b>Total Mobs Played: [length(GLOB.has_played_list)]</b>"
		lines += "<b>NOTE:</b> Count may be inaccurate if admins keep hopping in and out of mobs."
	lines += "You can set your OOC Status with the 'set-status' verb in OOC Tab. Use it to help find roleplay/let people know you're afk!"
	var/datum/preferences/P = whoer.prefs
	var/shown_on_who = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME)
	lines += {"<a href=' ?_src_=[REF(src)];[whoer.ckey]=ToggleWhoVis;>[FOURSPACES]\[[shown_on_who ? "HIDE yourself from who?" : "SHOW yourself on who?"]\]
		</a>"}
	to_chat(whoer, lines.Join("<br>"))

/// it can br a heckload of info for out poor little charpane
/datum/controller/subsystem/who/proc/Mob2WhoLineShort(mob/M)
	var/name = GetName(M)
	var/pose = GetPose(M, TRUE)
	var/where = GetWhere(M)
	return "[span_green("😃 [name]")] in [span_notice(where)] - [pose]"

/// it can br a heckload of info for out poor little charpane
/datum/controller/subsystem/who/proc/Mob2Who4AdmemesShort(mob/M)
	var/name = GetName(M)
	var/pose = GetPose(M, TRUE)
	var/where = GetWhere(M)
	var/coords = atom2coords(M)
	var/msg = "[span_green("🐈 [name]")] in [span_notice(where)]([span_purple(coords)]) - [pose]<br>▲ ([ADMIN_HALFMONTY(M)])"
	var/theyreanadmin = check_rights_for(M.client, admin_level_to_see_all) && !(M.client.holder in GLOB.deadmins)
	if(theyreanadmin)
		msg = "[span_brass("🐈 [name]")] in [span_notice(where)]([span_purple(coords)]) - [pose]<br>▲ ([ADMIN_HALFMONTY(M)])"
	return msg

/datum/controller/subsystem/who/proc/Mob2WhoLine(mob/M)
	var/mobname = GetName(M)
	var/jobname = GetRole(M)
	var/where = GetWhere(M)
	var/pose =  GetPose(M, TRUE)
	var/line1 = "[span_green("😃")] [span_noticealien(mobname)] the [span_alertalien(jobname)]</span>"
	var/line2 = "\tIn [span_notice(where)]. '[pose]'"
	return "[line1]<br>[line2]<br>"

/// Stuff us cool admemes get to see about you =3
/datum/controller/subsystem/who/proc/Mob2Who4Admemes(mob/looking_at)
	var/mobname = GetName(looking_at)
	var/ckey = "[looking_at.ckey]"
	if(looking_at.client.holder.fakekey)
		ckey += " (as [looking_at.client.holder.fakekey])"
	var/role = GetRole(looking_at)
	var/where = GetWhere(looking_at)
	var/list/splitcoords = splittext(atom2coords(looking_at), ":")
	var/coordsout = "[splitcoords[1]],[splitcoords[2]], in [GLOB.z2name[splitcoords[3]]]"
	var/isadmin = check_rights_for(looking_at.client, admin_level_to_see_all)
	var/admin_rank = isadmin ? span_love("[looking_at.client.holder.rank]") : span_brass("(Player)")
	if(looking_at.client.holder && (looking_at.client.holder in GLOB.deadmins))
		admin_rank += span_alertalien(" (Deadmined)")
	var/admin_link = ADMIN_HALFMONTY(looking_at)
	var/pose = GetPose(looking_at, TRUE)
	var/status_color = "green" // color of the name
	var/status_span = "green" // span of the throbber
	var/status_word = "Alive" // the actual status word
	var/status_dot = "🙂" // the throbber // I dont know whaat a throbber is
	var/hp = "very"
	var/maxhp = "dead"
	if(isliving(looking_at))
		var/mob/living/L = looking_at
		hp = L.health
		maxhp = L.maxHealth
	if(isnewplayer(looking_at))
		status_color = "#eaff00"
		status_span = "clown"
		status_word = "sitting in the Lobby."
		status_dot = "🆗"
	else
		switch(looking_at.stat)
			if(SOFT_CRIT)
				status_color = "#FFA500"
				status_span = "brass"
				status_word = "in Softcrit!"
				status_dot = "😱"
			if(UNCONSCIOUS)
				if(hp < HEALTH_THRESHOLD_CRIT)
					status_color = "#ff8800"
					status_span = "hypnophrase" // ack ack ack
					status_word = "in Hardcrit!"
					status_dot = "😵"
				else
					status_color = "#aeaeff"
					status_span = "alloy"
					status_word = "taking a nap!"
					status_dot = "💤"
			if(DEAD)
				if(isobserver(looking_at))
					var/mob/dead/observer/boo = looking_at
					if(boo.started_as_observer)
						status_color = "#ffffff"
						status_span = "deadsay"
						status_word = "observing."
						status_dot = "👻"
					else
						status_color = "#ff0000"
						status_span = "alert"
						status_word = "DEAD, and a ghost!"
						status_dot = "👻"
				else
					status_color = "#ff0000"
					status_span = "phobia"
					status_word = "DEAD!"
					status_dot = "💀"
	var/namerole = "[span_notice("[mobname] ([ckey])")] the [span_notice("[role]")]"
	if(!isadmin)
		namerole = "[span_brass("[mobname] ([ckey])")] the [span_brass("[role]")]"

	var/line1 = "<span class='[status_span]'>[status_dot]</span> [namerole] - '[ParsePoseColor(pose)]'"
	var/line2 = "<span class='[status_span]'>\t</span> Currently in [span_notice(where)], at [span_notice(coordsout)]."
	var/line3 = "<span class='[status_span]'>\t</span> They are <span style='color:[status_color]'>[status_word]</span> ([hp]/[maxhp] HP)."
	var/line4 = "<span class='[status_span]'>\t</span> They are \a [admin_rank]!"
	var/line5 = "<span class='[status_span]'>\t</span> [admin_link]"
	return "[line1]<br>[line2]<br>[line3]<br>[line4]<br>[line5]"

/datum/controller/subsystem/who/proc/Me(client/whoer)
	var/list/dat = list()
	var/mob/M = whoer.mob
	var/myname = GetName(M, TRUE)
	var/myrole = GetRole(M, TRUE)
	var/mywhere = GetWhere(M, TRUE)
	var/mypose = GetPose(M, TRUE)
	var/is_admin = check_rights_for(whoer, admin_level_to_see_all)
	var/is_deadmined = whoer.holder && (whoer.holder in GLOB.deadmins)
	var/fuzzy_x = round(M.x / coord_fuzziness) * coord_fuzziness
	var/fuzzy_y = round(M.y / coord_fuzziness) * coord_fuzziness
	var/datum/preferences/P = whoer.prefs
	var/shows_name = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_NAME)
	var/shows_job = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ROLE)
	var/shows_location = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_REGION)
	var/shows_coords = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_COORDS)
	var/shows_pose = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_POSE)
	var/shows_who = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME)
	dat += "<hr>"
	dat += span_green("You are <a href='?src=[REF(src)];[whoer.ckey]=SetCustomName'>[myname]</a> the <a href='?src=[REF(src)];[whoer.ckey]=SetCustomJob'>[myrole]</a>!<br>")
	dat += span_notice("Your name is <a href='?src=[REF(src)];[whoer.ckey]=ToggleNameVis'>[shows_name ? "VISIBLE to" : "HIDDEN from"] others!</a><br>")
	dat += span_notice("Your role is <a href='?src=[REF(src)];[whoer.ckey]=ToggleRoleVis'>[shows_job ? "VISIBLE to" : "HIDDEN from"] others!</a><br>")
	if(show_coords)
		dat += span_green("You are in [mywhere], within [fuzzy_x], [fuzzy_y] ±[coord_fuzziness]!<br>")
	else
		dat += span_green("You are somewhere in <a href='?src=[REF(src)];[whoer.ckey]=SetCustomLocation'>[mywhere]</a>!<br>")
	dat += span_notice("Your current location is <a href='?src=[REF(src)];[whoer.ckey]=ToggleLocationVis'>[shows_location ? "VISIBLE to" : "HIDDEN from"] others!</a><br>")
	if(show_coords)
		dat += span_notice("Your current Coordinates are <a href='?src=[REF(src)];[whoer.ckey]=ToggleLocationCoordVis'>[shows_coords ? "VISIBLE to" : "HIDDEN from"] others!</a><br>")
	dat += span_notice("Your OOC status is: '[mypose]' <a href='?src=[REF(src)];[whoer.ckey]=SetPose'>\[Change?\]</a><br>")
	dat += span_notice("Your OOC status is <a href='?src=[REF(src)];[whoer.ckey]=TogglePoseVis'>[shows_pose ? "VISIBLE to" : "HIDDEN from"] others!</a><br>")
	dat += span_brass("You are currently <a href='?src=[REF(src)];[whoer.ckey]=ToggleWhoVis'>[shows_who ? "VISIBLE" : "HIDDEN"] on the who list!</a><br>")
	if(is_admin)
		dat += "You are \a [whoer.holder.rank]"
		if(whoer.holder.fakekey)
			dat += " (as [whoer.holder.fakekey])"
		if(is_deadmined)
			dat += " (deadmined)~"
		dat += "!<hr>"
	return dat.Join()

/datum/controller/subsystem/who/Topic(href, list/href_list)
	. = ..()
	var/ckey // I did it backwards~
	for(var/hr in href_list)
		if(hr in GLOB.directory)
			ckey = hr
			break
	if(!ckey)
		return
	var/datum/preferences/P = extract_prefs(ckey)
	var/mob/M = ckey2mob(ckey)
	switch(href_list["[ckey]"])
		if("ToggleLocationVis")
			TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_REGION)
			to_chat(P.parent, span_green("Your location is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_REGION) ? "VISIBLE" : "HIDDEN"] to others!"))
		if("ToggleWhoVis")
			TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_ME)
			to_chat(P.parent, span_green("You are now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME) ? "VISIBLE" : "HIDDEN"] to others!"))
		if("ToggleNameVis")
			TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_NAME)
			to_chat(P.parent, span_green("Your name is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_NAME) ? "VISIBLE" : "HIDDEN"] to others!"))
		if("ToggleRoleVis")
			TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_ROLE)
			to_chat(P.parent, span_green("Your role is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ROLE) ? "VISIBLE" : "HIDDEN"] to others!"))
		if("ToggleLocationCoordVis")
			TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_COORDS)
			to_chat(P.parent, span_green("Your coordinates are now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_COORDS) ? "VISIBLE" : "HIDDEN"] to others!"))
		if("TogglePoseVis")
			TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_POSE)
			to_chat(P.parent, span_green("Your OOC status is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_POSE) ? "VISIBLE" : "HIDDEN"] to others!"))	
		if("SetPose")
			SetPose(M)
		if("SetCustomName")
			SetName(M)
		if("SetCustomJob")
			SetRole(M)
		if("SetCustomLocation")
			SetWhere(M)
	save_queue[ckey] = 2

/// Opens the qho tgui for the agmin
/datum/controller/subsystem/who/proc/OpenWindow(mob/user)
	to_chat(user, span_alert("Coming soon: This feature"))
	// return ui_interact(user) // yeah it doesnt work
/* 
/// Opens the qho tgui for the agmin
/datum/controller/subsystem/who/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "WhoAdminPanel")
		ui.open()

/datum/controller/subsystem/who/ui_state(mob/user)
	return GLOB.admin_state

/datum/controller/subsystem/who/ui_data(mob/user)
	var/list/data = list()
	data["UserName"] = user.real_name
	data["DP"] = SSquirks.dp
	data["AllWhos"] = FormatifyCustoms()
	return data

/datum/controller/subsystem/who/proc/FormatifyCustoms()
	var/list/bois = list()
	for(var/key in customlist)
		var/datum/who_custom_stuff/WCS = customlist[key]
		var/mob/M = ckey2mob(key)
		var/list/buddy = list()

		buddy["WhoCkey"] = WCS.ckey

		var/list/boiname = list()
		boiname["RealVal"] = M?.real_name || "No Name"
		boiname["CustVal"] = WCS.GetName(TRUE)
		boiname["IsBanned"] = CHECK_BITFIELD(WCS.lockouts, WHO_LOCKOUT_NAME)
		buddy["Name"] = list(boiname)

		var/list/boirole = list()
		boirole["RealVal"] = M?.mind?.assigned_role || "No Role"
		boirole["CustVal"] = WCS.GetRole(TRUE)
		boirole["IsBanned"] = CHECK_BITFIELD(WCS.lockouts, WHO_LOCKOUT_ROLE)
		buddy["Role"] = list(boirole)

		var/list/boiwhere = list()
		boiwhere["RealVal"] = WhereAmI(M) || "Nowhere"
		boiwhere["CustVal"] = WCS.GetWhere(TRUE)
		boiwhere["IsBanned"] = CHECK_BITFIELD(WCS.lockouts, WHO_LOCKOUT_WHERE)
		buddy["Where"] = list(boiwhere)

		var/list/boipose = list()
		boipose["RealVal"] = WCS.GetPose(TRUE) || "No Pose"
		boipose["CustVal"] = WCS.GetPose(TRUE)
		boipose["IsBanned"] = CHECK_BITFIELD(WCS.lockouts, WHO_LOCKOUT_POSE)
		buddy["Pose"] = list(boipose)
		bois += list(buddy)
	return bois

/datum/controller/subsystem/who/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/ckey = params["Who"]
	var/datum/who_custom_stuff/WCS = GetCustomDatum(ckey)
	if(!WCS)
		return
	if(action == "ToggleBan")
		switch(params["What"])
			if("Name")
				TOGGLE_BITFIELD(WCS.lockouts, WHO_LOCKOUT_NAME)
			if("Role")
				TOGGLE_BITFIELD(WCS.lockouts, WHO_LOCKOUT_ROLE)
			if("Where")
				TOGGLE_BITFIELD(WCS.lockouts, WHO_LOCKOUT_WHERE)
			if("Pose")
				TOGGLE_BITFIELD(WCS.lockouts, WHO_LOCKOUT_POSE)
	if(action == "SetValue")
		switch(params["What"])
			if("Name")
				var/new_name = params["Value"]
				if(new_name)
					WCS.SetName(new_name || "")
				else
					action = "ClearValue"
			if("Role")
				var/new_role = params["Value"]
				if(new_role)
					WCS.SetRole(new_role || "")
				else
					action = "ClearValue"
			if("Where")
				var/new_where = params["Value"]
				if(new_where)
					WCS.SetWhere(new_where || "")
				else
					action = "ClearValue"
			if("Pose")
				var/new_pose = params["Value"]
				if(new_pose)
					WCS.SetPose(new_pose || "")
				else
					action = "ClearValue"
	if(action == "ClearValue")
		switch(params["What"])
			if("Name")
				WCS.SetName("CLEAR-RESET-DESTROY")
			if("Role")
				WCS.SetRole("CLEAR-RESET-DESTROY")
			if("Where")
				WCS.SetWhere("CLEAR-RESET-DESTROY")
			if("Pose")
				WCS.SetPose("CLEAR-RESET-DESTROY")
	save_queue[ckey] = 2 // its a hack, but im the headdev so its okay
	return TRUE
 */
/obj/effect/hint/region_floodfill_ignore
	name = "Makes the region flood fill thing not consider this as a wall, even if it is one."
	desc = "Fenny, place these on interior doors and windows to make the region flood fill thing include the whole house or dungeon or whatever."
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "floodpassthru"
	anchored = TRUE
	layer = MOB_LAYER

/obj/effect/hint/region_floodfill_ignore/Initialize(mapload)
	. = ..()
	SSwho.region_hint_ignore[atom2coords(src)] = TRUE
	return INITIALIZE_HINT_QDEL // I was never here!

/obj/effect/hint/region_floodfill_solid
	name = "Makes the region flood fill thing consider this tile to be solid, even if it isnt. The flood-fill will fill up to, but not past, this tile."
	desc = "Fenny, place these on exterior doors and windows to make the region flood fill thing not include the whole dang map."
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "floodblocker"
	anchored = TRUE
	layer = MOB_LAYER

/obj/effect/hint/region_floodfill_solid/Initialize(mapload)
	. = ..()
	SSwho.region_hint_solid[atom2coords(src)] = TRUE
	return INITIALIZE_HINT_QDEL // I was never here!

/obj/effect/landmark/region
	name = "Townhole"
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "regionmarker"
	anchored = TRUE
	layer = MOB_LAYER
	var/distance = 1
	var/floodfill = FALSE

/obj/effect/landmark/region/Initialize(mapload)
	. = ..()
	SSwho.AddRegion(src)
	
/obj/effect/landmark/region/Destroy()
	SSwho.region_landmarks -= src
	..()

/obj/effect/landmark/region/floodfill
	name = "Townhole"
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "regionmarkerfloor"
	anchored = TRUE
	layer = MOB_LAYER
	floodfill = TRUE

/datum/region
	var/name = "North Mlrblbingusburg"
	var/areaname = "Building"
	var/distance = 1 // tiles away from the center that this region is valid
	var/coord_cache = list() // list of coords that are valid for this region
	var/coord_z = 0

	var/debug_color = "#FF0000"

/datum/region/New(obj/effect/landmark/region/R)
	if(!istype(R))
		CRASH("LANDMARK REGION DATUM WAS NOT PASSED A REGION LANDMARK!!!!!!!!!!!!!!!!!! [R]")
	var/turf/whereitis = get_turf(R)
	if(!istype(whereitis))
		CRASH("LANDMARK DIDNT HAVE A TURF!!!!!!!!!!!!!!!!!! [whereitis]")
	var/area/areaitis = get_area(R)
	if(!istype(areaitis))
		CRASH("LANDMARK DIDNT HAVE AN AREA!!!!!!!!!!!!!!!!!! [areaitis]")
	if(SSwho.debug_regions)
		debug_color = "#[random_color()]"
	areaname = areaitis.name
	name = R.name
	if(R.floodfill)
		RunFloodFill(whereitis)
	else
		for(var/turf/T in range(distance, whereitis))
			coord_cache += atom2coords(whereitis)
	SSwho.regions["[whereitis.z]"] |= src
	. = ..()

/// A wretched flood-fill proc that spreads out from the landmark to include all the coords of turfs connected to this one
/// This is used for regions that are not a perfect square, but still an enclosed (ish) space.
/// It includes solid walls as valid parts of its region, but will not extend byond a wall.
/// Anything dense, solid, or opaque is considered a wall. This includes windows, doors, and airlocks.
/// Place a /obj/effect/landmark/hint_areaportal on a wall-like thing to let the flood-fill know that it can pass through it.
/datum/region/proc/RunFloodFill(turf/origin)
	if(!isturf(origin))
		CRASH("FLOOD FILL WAS NOT PASSED A TURF!!!!!!!!!!!!!!!!!! [origin]")

	var/list/queue = list(origin)
	var/list/visited = list()
	var/iterations_left = 1000 // any more than that and we have problemos
	while(LAZYLEN(queue) && iterations_left--)
		var/turf/T = LAZYACCESS(queue, 1)
		queue -= T
		if(!isturf(T))
			continue
		visited |= T
		///check if there's anything solid here, and if so, dont add in the adjascents
		if(has_blocker(T))
			continue
		for(var/direction in GLOB.alldirs)
			var/turf/adj = get_step(T, direction)
			if(!isturf(adj))
				continue
			if(adj in visited)
				continue
			if(!T.Adjacent(adj))
				continue
			queue |= adj
	for(var/turf/T in visited)
		coord_cache["[atom2coords(T)]"] = TRUE // typecache! but with coords
		if(SSwho.debug_regions)
			var/obj/effect/temp_visual/debug_highlight/longer/EEE = new(T)
			EEE.color = debug_color

/datum/region/proc/has_blocker(turf/here)
	if(!isturf(here))
		return TRUE
	var/my_coords = atom2coords(here)
	if(LAZYACCESS(SSwho.region_hint_solid, my_coords))
		return TRUE
	if(LAZYACCESS(SSwho.region_hint_ignore, my_coords))
		return FALSE
	if(here.opacity)
		return TRUE
	if(here.density)
		return TRUE
	for(var/atom/A in here)
		if(A.opacity)
			return TRUE
		if(is_type_in_typecache(A, GLOB.room_sealers)) // any kind of sealers
			return TRUE

/obj/effect/temp_visual/debug_highlight/longer
	name = "love heart"
	icon = 'icons/effects/effects.dmi'
	icon_state = "scanlineslow"
	duration = 10 SECONDS

// Make the verb here.
/mob/verb/SetStatusMsg()
	set name = "Set Status"
	set category = "OOC"

	if(!client)
		return
	
	var/input = stripped_input(usr,"This adds a short message on the end of your record in who. Useful for informing if you're in the mood to RP. (Char Limit: [MAX_STATUS_LEN])",max_length=MAX_STATUS_LEN)
	if(length(input))
		SSwho.SetPose(src, input)
		to_chat(usr, "Your status message is now: [input]")

/client/verb/who()
	set name = "Who"
	set category = "OOC"
	set desc = "See who's online!"

	SSwho.Who(src) // hoo

/client/verb/who_verbose()
	set name = "Who Plus"
	set category = "OOC"
	set desc = "See who's online, and get a lot of info about them!"

	SSwho.WhoPlus(src) // hoo

/client/verb/myself()
	set name = "You" // you pressed "You", referring to me
	set category = "OOC" // That is correct!
	set desc = "See info about yourself in relation to 'Who'!"

	to_chat(src, "[SSwho.Me(src)]") // the correct answer is "me"!

// /client/verb/adminwho()
// 	set category = "Admin"
// 	set name = "Adminwho"

/// this whole system relies on usr to differentiate between admin and holder mob
/// why?
/datum/who_custom_stuff
	var/ckey
	var/c_name
	var/c_role
	var/c_where
	var/c_pose

/datum/who_custom_stuff/New(c_key)
	. = ..()
	ckey = c_key

/datum/who_custom_stuff/proc/GetMyMob()
	return ckey2mob(ckey)

/datum/who_custom_stuff/proc/GetMyClient() // gyet mah gun
	return LAZYACCESS(GLOB.directory, ckey)

/// Is the usr an admin, and also not the holder mob?
/datum/who_custom_stuff/proc/IsAdmin()
	var/mob/M = GetMyMob()
	if(isnull(M))
		return FALSE
	if(usr == M)
		return FALSE
	return check_rights_for(usr, SSwho.admin_level_to_see_all)

/datum/who_custom_stuff/proc/LockedOut(lockoutkey)
	var/is_admin = IsAdmin()
	if(is_admin)
		return FALSE
	var/datum/preferences/P = extract_prefs(ckey)
	return CHECK_BITFIELD(P.lockouts, lockoutkey)

/datum/who_custom_stuff/proc/DispenseInfo(oldval, newval, key, cleared)
	var/is_admin = IsAdmin()
	var/mob/M = GetMyMob()
	if(cleared)
		if(is_admin)
			message_admins("[usr.ckey] cleared [M]'s ([ckey]) [key] (Was:[oldval])")
			log_ooc("[usr.ckey] cleared [M]'s ([ckey]) [key] (Was:[oldval])")
			to_chat(usr, "You cleared [M]'s [key] (Was:[oldval])")
			to_chat(M, span_userdanger("Your [key] has been cleared by an admin! (Was:[oldval])"))
		else
			to_chat(usr, "You cleared your [key] (Was:[oldval])")
			to_chat(M, "Your [key] has been cleared (Was:[oldval])")
	else
		if(is_admin)
			message_admins("[usr.ckey] set [M]'s ([ckey]) [key] to: [newval] (Was:[oldval])")
			log_ooc("[usr.ckey] set [M]'s ([ckey]) [key] to: [newval] (Was:[oldval])")
			to_chat(usr, "You set [M]'s [key] to: [newval] (Was: [oldval])")
			to_chat(M, span_userdanger("Your [key] has been changed by an admin! Now: [newval] (Was: [oldval])"))
		else
			to_chat(usr, "You set your [key] to: [newval] (Was: [oldval])")
			to_chat(M, "Your [key] has been set to: [newval] (Was: [oldval])")

/datum/who_custom_stuff/proc/GetName(reveal_always)
	var/datum/preferences/P = extract_prefs(ckey)
	var/mob/M = GetMyMob()
	if(IsAdmin())
		return "[M.real_name][isnull(c_name) ? "" : " - [c_name]"]"
	var/name_vis = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_NAME) && CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME)
	if(!name_vis && !reveal_always)
		return "Unknown"
	if(!isnull(c_name))
		return c_name
	return TrueName()

/datum/who_custom_stuff/proc/TrueName()
	var/mob/M = GetMyMob()
	if(isnull(M))
		return "Unknown"
	if(LAZYLEN(M.real_name) && !findtext(ckey(M.real_name), ckey(ckey)))
		return "[M.real_name]"
	var/datum/preferences/P = extract_prefs(ckey)
	return "[P.real_name]"

/datum/who_custom_stuff/proc/GetRole(reveal_always)
	var/datum/preferences/P = extract_prefs(ckey)
	var/mob/M = GetMyMob()
	if(IsAdmin())
		return "[M.mind.assigned_role][isnull(c_role) ? "" : " - [c_role]"]"
	var/job_vis = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ROLE) && CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME)
	if(!job_vis && !reveal_always)
		return "mysterious stranger"
	if(!isnull(c_role))
		return c_role
	return TrueJob()

/datum/who_custom_stuff/proc/TrueJob()
	var/mob/M = GetMyMob()
	if(isnull(M))
		return "mysterious stranger"
	if(isnewplayer(M))
		return "Lobbyist"
	if(!LAZYLEN(M.mind.assigned_role))
		return "mysterious stranger"
	return "[M.mind.assigned_role]"	

/datum/who_custom_stuff/proc/GetWhere(reveal_always)
	var/datum/preferences/P = extract_prefs(ckey)
	var/mob/M = GetMyMob()
	if(IsAdmin())
		return "[SSwho.WhereAmI(M)][isnull(c_where) ? "" : " - [c_where]"]"
	var/loc_vis = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_REGION) && CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME)
	if(!loc_vis && !reveal_always)
		return "parts unknown"
	if(!isnull(c_where))
		return "[c_where]."
	return "[SSwho.WhereAmI(M)]"

/datum/who_custom_stuff/proc/GetPose(reveal_always, parse)
	var/datum/preferences/P = extract_prefs(ckey)
	if(isnull(c_pose) || trim(c_pose) == "")
		c_pose = "Just vibin', come say hi!"
	if(reveal_always)
		return parse ? SSwho.ParsePoseColor(c_pose) : c_pose
	var/pose_vis = CHECK_BITFIELD(P.whoflags, WHO_SHOWS_POSE) && CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME)
	if(!pose_vis)
		return "???"
	return parse ? SSwho.ParsePoseColor(c_pose) : c_pose

/datum/who_custom_stuff/proc/SetName(clear)
	var/client/C = GetMyClient()
	var/mob/M = GetMyMob()
	if(LockedOut(WHO_LOCKOUT_NAME))
		c_name = null
		to_chat(M, span_alert("You've been locked out from changing your custom name! :c"))
		return
	var/defaultname = GetName(TRUE)
	if(clear)
		c_name = null
		DispenseInfo(defaultname, TrueName(), "name", TRUE)
		return
	var/newname = stripped_input(C, "Set the custom Who name! (Char Limit: [MAX_STATUS_LEN])", "Custom Name", "[defaultname]", max_length=MAX_STATUS_LEN)
	c_name = newname
	if(trim(newname) != "" && !isnull(c_name))
		DispenseInfo(defaultname, newname, "name")
	else
		DispenseInfo(defaultname, newname, "name", TRUE)

/datum/who_custom_stuff/proc/SetRole(clear)
	var/client/C = GetMyClient()
	var/mob/M = GetMyMob()
	if(LockedOut(WHO_LOCKOUT_ROLE))
		c_role = null
		to_chat(M, span_alert("You've been locked out from changing your custom role! :c"))
		return
	var/defaultrole = GetRole(TRUE)
	if(clear)
		c_role = null
		DispenseInfo(defaultrole, TrueJob(), "role", TRUE)
		return
	var/newrole = stripped_input(C, "Set the custom Who role! (Char Limit: [MAX_STATUS_LEN])", "Custom Role", "[defaultrole]", max_length=MAX_STATUS_LEN)
	c_role = newrole
	if(trim(newrole) != "" && !isnull(c_role))
		DispenseInfo(defaultrole, newrole, "role")
	else
		DispenseInfo(defaultrole, newrole, "role", TRUE)

/datum/who_custom_stuff/proc/SetWhere(clear)
	var/client/C = GetMyClient()
	var/mob/M = GetMyMob()
	if(LockedOut(WHO_LOCKOUT_WHERE))
		c_where = null
		to_chat(M, span_alert("You've been locked out from changing your custom location! :c"))
		return
	var/defaultwhere = GetWhere(TRUE)
	if(clear)
		c_where = null
		DispenseInfo(defaultwhere, SSwho.WhereAmI(M), "location", TRUE)
		return
	var/newwhere = stripped_input(C, "Set the custom Who location! (Char Limit: [MAX_STATUS_LEN])", "Custom Location", "[defaultwhere]", max_length=MAX_STATUS_LEN)
	c_where = newwhere
	if(trim(newwhere) != "" && !isnull(c_where))
		DispenseInfo(defaultwhere, newwhere, "location")
	else
		DispenseInfo(defaultwhere, newwhere, "location", TRUE)

/datum/who_custom_stuff/proc/SetPose(clear)
	var/client/C = GetMyClient()
	var/mob/M = GetMyMob()
	if(LockedOut(WHO_LOCKOUT_POSE))
		c_pose = null
		to_chat(M, span_alert("You've been locked out from changing your custom OOC status! :c"))
		return
	var/defaultpose = "Just vibin', come say hi!"
	if(!isnull(c_pose))
		defaultpose = c_pose
	if(clear)
		c_pose = null
		DispenseInfo(defaultpose, "Just vibin', come say hi!", "OOC status", TRUE)
		return
	var/newpose = stripped_input(C, "Set the custom OOC status! (Char Limit: [MAX_STATUS_LEN])\n\
		You can add a color to the OOC status! Just start the line with QQc and then a 6 character hexcode, \
		like 'QQcFF00DD' or 'QQc123456'", "Custom Pose", "[defaultpose]", max_length=MAX_STATUS_LEN)
	c_pose = newpose
	if(trim(newpose) != "" && !isnull(c_pose))
		c_pose = "Just vibin', come say hi!"
		DispenseInfo(defaultpose, c_pose, "OOC status")
	else
		DispenseInfo(defaultpose, SSwho.ParsePoseColor(newpose), "OOC status", TRUE)

/datum/who_custom_stuff/proc/ToggleNameVis()
	var/mob/M = GetMyMob()
	var/datum/preferences/P = extract_prefs(ckey)
	TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_NAME)
	to_chat(M, "Your name is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_NAME) ? "VISIBLE" : "HIDDEN"] to others!")

/datum/who_custom_stuff/proc/ToggleRoleVis()
	var/mob/M = GetMyMob()
	var/datum/preferences/P = extract_prefs(ckey)
	TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_ROLE)
	to_chat(M, "Your role is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ROLE) ? "VISIBLE" : "HIDDEN"] to others!")

/datum/who_custom_stuff/proc/ToggleLocationVis()
	var/mob/M = GetMyMob()
	var/datum/preferences/P = extract_prefs(ckey)
	TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_REGION)
	to_chat(M, "Your location is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_REGION) ? "VISIBLE" : "HIDDEN"] to others!")

/datum/who_custom_stuff/proc/TogglePoseVis()
	var/mob/M = GetMyMob()
	var/datum/preferences/P = extract_prefs(ckey)
	TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_POSE)
	to_chat(M, "Your OOC status is now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_POSE) ? "VISIBLE" : "HIDDEN"] to others!")

/datum/who_custom_stuff/proc/ToggleWhoVis()
	var/mob/M = GetMyMob()
	var/datum/preferences/P = extract_prefs(ckey)
	TOGGLE_BITFIELD(P.whoflags, WHO_SHOWS_ME)
	to_chat(M, "You are now [CHECK_BITFIELD(P.whoflags, WHO_SHOWS_ME) ? "VISIBLE to" : "HIDDEN from"] the Who list!")

/datum/who_custom_stuff/proc/ToggleLockout(lock_key)
	var/was_on
	var/datum/preferences/P = extract_prefs(ckey)
	switch(lock_key)
		if("Name")
			was_on = CHECK_BITFIELD(P.lockouts, WHO_LOCKOUT_NAME)
			TOGGLE_BITFIELD(P.lockouts, WHO_LOCKOUT_NAME)
		if("Role")
			was_on = CHECK_BITFIELD(P.lockouts, WHO_LOCKOUT_ROLE)
			TOGGLE_BITFIELD(P.lockouts, WHO_LOCKOUT_ROLE)
		if("Location")
			was_on = CHECK_BITFIELD(P.lockouts, WHO_LOCKOUT_WHERE)
			TOGGLE_BITFIELD(P.lockouts, WHO_LOCKOUT_WHERE)
		if("Pose")
			was_on = CHECK_BITFIELD(P.lockouts, WHO_LOCKOUT_POSE)
			TOGGLE_BITFIELD(P.lockouts, WHO_LOCKOUT_POSE)
	var/mob/M = GetMyMob()
	/// The admin who did this
	to_chat(usr, "You have [was_on ? span_alert("forbidden") : span_green("allowed")] [M.real_name] ([ckey]) to change their Custom [lock_key]!")
	/// The person who was locked out
	if(was_on)
		to_chat(M, span_alert("You are no longer allowed to change your Custom [lock_key]!"))
	else
		to_chat(M, span_green("You are now allowed to change your Custom [lock_key]!"))
	message_admins("[usr.real_name] ([usr.ckey]) has [was_on ? "forbidden" : "allowed"] [M.real_name] ([ckey]) to change their Custom [lock_key]!")
	log_ooc("[usr.real_name] ([usr.ckey]) has [was_on ? "forbidden" : "allowed"] [M.real_name] ([ckey]) to change their Custom [lock_key]!")

/// cus I know some devlord's gonna read this at some point and complain to their coderbuddies that 2010 called they want their ancient practices back
/// shit makes me hard

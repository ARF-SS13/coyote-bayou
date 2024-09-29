SUBSYSTEM_DEF(statpanels)
	name = "Stat Panels"
	wait = 4
	init_order = INIT_ORDER_STATPANELS
	priority = FIRE_PRIORITY_STATPANEL
	runlevels = RUNLEVELS_DEFAULT | RUNLEVEL_LOBBY
	var/list/currentrun = list()
	var/encoded_global_data
	var/mc_data_encoded
	var/list/cached_images = list()
	var/list/cached_boykissers = list()
	var/list/cached_girlkissers = list()
	var/list/cached_anykissers = list()
	var/list/cached_tops = list()
	var/list/cached_bottoms = list()
	var/list/cached_switches = list()
	var/list/cached_bois = list()
	var/list/cached_girls = list()
	var/list/cached_them = list()
	var/list/cached_herms = list()
	var/the_majority = "Nobody seems to be on!"
	var/nashs_most_wanted = "They want some friends!"

/datum/controller/subsystem/statpanels/fire(resumed = FALSE)
	if (!resumed)
		var/datum/map_config/cached = SSmapping.next_map_config
		var/list/global_data = list(
			//"Map: [SSmapping.config?.map_name || "Loading..."]",
			cached ? "Next Map: [cached.map_name]" : null,
			"Round Number: [GLOB.round_id ? GLOB.round_id : "NULL"]",
			//"Server Time: [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]",
			"Round Time: [ROUND_TIME]",
			//"Station Time: [STATION_TIME_TIMESTAMP(FALSE, world.time)]",
			"Server Anger Level: [SStime_track.get_anger()]",
			"----------------------------",
			"[the_majority]",
			"[nashs_most_wanted]",
		)

		if(SSshuttle.emergency)
			var/ETA = SSshuttle.emergency.getModeStr()
			if(ETA)
				global_data += "[ETA] [SSshuttle.emergency.getTimerStr()]"
		encoded_global_data = url_encode(json_encode(global_data))
		src.currentrun = GLOB.clients.Copy()
		mc_data_encoded = null
	var/list/currentrun = src.currentrun
	while(length(currentrun))
		var/client/target = currentrun[length(currentrun)]
		currentrun.len--
		if(!target.statbrowser_ready)
			continue
		if(target.stat_tab == "Status")
			var/ping_str = url_encode("Ping: [round(target.lastping, 1)]ms (Average: [round(target.avgping, 1)]ms)")
			var/other_str = url_encode(json_encode(target.mob.get_status_tab_items()))
			var/adminstuff = ""
			// if(SStime_track.debug_just_flat_out_lie_to_the_players && check_rights_for(target, R_ADMIN))
			// 	adminstuff = url_encode("The Real TiDi: [round(SStime_track.time_dilation_current,1)]% AVG:([round(SStime_track.time_dilation_avg_fast,1)]%, [round(SStime_track.time_dilation_avg,1)]%, [round(SStime_track.time_dilation_avg_slow,1)]%)")
			target << output("[encoded_global_data];[ping_str];[other_str][adminstuff]", "statbrowser:update")
		if(!target.holder)
			target << output("", "statbrowser:remove_admin_tabs")
		else
			target << output("[!!(target.prefs.toggles & SPLIT_ADMIN_TABS)]", "statbrowser:update_split_admin_tabs")
			if(!("MC" in target.panel_tabs) || !("Tickets" in target.panel_tabs))
				target << output("[url_encode(target.holder.href_token)]", "statbrowser:add_admin_tabs")
			if(target.stat_tab == "MC")
				var/turf/eye_turf = get_turf(target.eye)
				var/coord_entry = url_encode(COORD(eye_turf))
				if(!mc_data_encoded)
					generate_mc_data()
				target << output("[mc_data_encoded];[coord_entry]", "statbrowser:update_mc")
			if(target.stat_tab == "Tickets")
				var/list/ahelp_tickets = GLOB.ahelp_tickets.stat_entry()
				target << output("[url_encode(json_encode(ahelp_tickets))];", "statbrowser:update_tickets")
				var/datum/interview_manager/m = GLOB.interviews

				// get open interview count
				var/dc = 0
				for (var/ckey in m.open_interviews)
					var/datum/interview/I = m.open_interviews[ckey]
					if (I && !I.owner)
						dc++
				var/stat_string = "([m.open_interviews.len - dc] online / [dc] disconnected)"

				// Prepare each queued interview
				var/list/queued = list()
				for (var/datum/interview/I in m.interview_queue)
					queued += list(list(
						"ref" = REF(I),
						"status" = "\[[I.pos_in_queue]\]: [I.owner_ckey][!I.owner ? " (DC)": ""] \[INT-[I.id]\]"
					))

				var/list/data = list(
					"status" = list(
						"Active:" = "[m.open_interviews.len] [stat_string]",
						"Queued:" = "[m.interview_queue.len]",
						"Closed:" = "[m.closed_interviews.len]"),
					"interviews" = queued
				)

				// Push update
				target << output("[url_encode(json_encode(data))];", "statbrowser:update_interviews")
			if(!length(GLOB.sdql2_queries) && ("SDQL2" in target.panel_tabs))
				target << output("", "statbrowser:remove_sdql2")
			else if(length(GLOB.sdql2_queries) && (target.stat_tab == "SDQL2" || !("SDQL2" in target.panel_tabs)))
				var/list/sdql2A = list()
				sdql2A[++sdql2A.len] = list("", "Access Global SDQL2 List", REF(GLOB.sdql2_vv_statobj))
				var/list/sdql2B = list()
				for(var/i in GLOB.sdql2_queries)
					var/datum/sdql2_query/Q = i
					sdql2B = Q.generate_stat()
				sdql2A += sdql2B
				target << output(url_encode(json_encode(sdql2A)), "statbrowser:update_sdql2")
		if(target.mob)
			var/mob/M = target.mob
			if((target.stat_tab in target.spell_tabs) || !length(target.spell_tabs) && (length(M.mob_spell_list) || length(M.mind?.spell_list)))
				var/list/proc_holders = M.get_proc_holders()
				target.spell_tabs.Cut()
				for(var/phl in proc_holders)
					var/list/proc_holder_list = phl
					target.spell_tabs |= proc_holder_list[1]
				var/proc_holders_encoded = ""
				if(length(proc_holders))
					proc_holders_encoded = url_encode(json_encode(proc_holders))
				target << output("[url_encode(json_encode(target.spell_tabs))];[proc_holders_encoded]", "statbrowser:update_spells")
			if(M?.listed_turf)
				var/mob/target_mob = M
				if(!target_mob.TurfAdjacent(target_mob.listed_turf))
					target << output("", "statbrowser:remove_listedturf")
					target_mob.listed_turf = null
				else if(target.stat_tab == M?.listed_turf.name || !(M?.listed_turf.name in target.panel_tabs))
					var/list/overrides = list()
					var/list/turfitems = list()
					for(var/img in target.images)
						var/image/target_image = img
						if(!target_image.loc || target_image.loc.loc != target_mob.listed_turf || !target_image.override)
							continue
						overrides += target_image.loc
					turfitems[++turfitems.len] = list("[target_mob.listed_turf]", REF(target_mob.listed_turf), icon2html(target_mob.listed_turf, target, sourceonly=TRUE))
					for(var/tc in target_mob.listed_turf)
						var/atom/movable/turf_content = tc
						if(turf_content.mouse_opacity == MOUSE_OPACITY_TRANSPARENT)
							continue
						if(turf_content.invisibility > target_mob.see_invisible)
							continue
						if(turf_content in overrides)
							continue
						if(turf_content.IsObscured())
							continue
						if(length(turfitems) < 30) // only create images for the first 30 items on the turf, for performance reasons
							if(!(REF(turf_content) in cached_images))
								cached_images += REF(turf_content)
								turf_content.RegisterSignal(turf_content, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/atom/movable, remove_from_cache)) // we reset cache if anything in it gets deleted
								if(ismob(turf_content) || length(turf_content.overlays) > 2)
									turfitems[++turfitems.len] = list("[turf_content.name]", REF(turf_content), costly_icon2html(turf_content, target, sourceonly=TRUE))
								else
									turfitems[++turfitems.len] = list("[turf_content.name]", REF(turf_content), icon2html(turf_content, target, sourceonly=TRUE))
							else
								turfitems[++turfitems.len] = list("[turf_content.name]", REF(turf_content))
						else
							turfitems[++turfitems.len] = list("[turf_content.name]", REF(turf_content))
					turfitems = url_encode(json_encode(turfitems))
					target << output("[turfitems];", "statbrowser:update_listedturf")
		if(MC_TICK_CHECK)
			return

/// Adds (merges) a player's sexual demographic information to the fucklist (F-List)
/datum/controller/subsystem/statpanels/proc/collect_horny_demographic(someone)
	/// we need two things: a client, and a mob. the mob we can get from the client!
	var/client/C = extract_client(someone)
	if(!C)
		return
	var/mob/M = C.mob
	if(!M)
		return // shouldnt happen, but ya know
	var/CKEY = C.ckey
	if(!CKEY) // no guests
		return
	discard_horny_demographic(C, FALSE)
	var/sex = M.gender // remind me to add in more options than BYOND's default
	var/tbs = C.prefs.tbs // Turner Broadcasting System (RIP the conan show)
	var/who_i_kiss = C.prefs.kisser // smoonch
	switch(sex)
		if(MALE)
			cached_bois |= CKEY
		if(FEMALE)
			cached_girls |= CKEY
		if(PLURAL)
			cached_herms |= CKEY
		else
			cached_them |= CKEY
	switch(tbs)
		if(TBS_BOTTOM)
			cached_bottoms |= CKEY
		if(TBS_TOP)
			cached_tops |= CKEY
		if(TBS_SHOES) // tops, bottoms, shoes
			cached_switches |= CKEY
	switch(who_i_kiss)
		if(KISS_BOYS)
			cached_boykissers |= CKEY
		if(KISS_GIRLS)
			cached_girlkissers |= CKEY
		if(KISS_ANY)
			cached_anykissers |= CKEY
	update_fucklist_tally()

// Removes a player's sexual demographic information from the fucklist (F-List)
/datum/controller/subsystem/statpanels/proc/discard_horny_demographic(someone, update_tally = TRUE)
	var/client/C = extract_client(someone)
	if(!C)
		return
	/// we just need the ckey, to delete it from the fucklist
	var/CKEY = C.ckey
	if(!CKEY) // no guests
		return
	cached_bois -= CKEY
	cached_girls -= CKEY
	cached_herms -= CKEY
	cached_them -= CKEY
	cached_bottoms -= CKEY
	cached_tops -= CKEY
	cached_switches -= CKEY
	cached_boykissers -= CKEY
	cached_girlkissers -= CKEY
	cached_anykissers -= CKEY
	if(update_tally)
		update_fucklist_tally()

/// Updates the fucklist tally, for the fucklist panel
/// Reads the list of our current demographic, and determines what sort of
/// person is currently in demand
/// Used to help players know who to play if they want to be a certain sexual
/datum/controller/subsystem/statpanels/proc/update_fucklist_tally()
	/// first, read the list of sexual orientations.
	/// lets assume that boykissers want to kiss boys, and girlkissers want to kiss girls, etc
	var/list/kisslist = list(
		KISS_BOYS = LAZYLEN(cached_boykissers),
		KISS_GIRLS = LAZYLEN(cached_girlkissers),
		KISS_ANY = LAZYLEN(cached_anykissers),
	)
	var/majority_kisser = highest_number_in_ass_list(kisslist)

	var/list/sexlist = list(
		PLURAL = LAZYLEN(cached_herms),
		FEMALE = LAZYLEN(cached_girls),
		MALE = LAZYLEN(cached_bois),
		THEM = LAZYLEN(cached_them),
	)
	var/majority_sex = highest_number_in_ass_list(sexlist)

	var/list/tbslist = list(
		TBS_BOTTOM = LAZYLEN(cached_bottoms),
		TBS_TOP = LAZYLEN(cached_tops),
		TBS_SHOES = LAZYLEN(cached_switches),
	)
	var/majority_tbs = highest_number_in_ass_list(tbslist)

	/// what sex is most desired?
	var/most_desired_sex = "Anysex"
	switch(majority_kisser)
		if(KISS_BOYS)
			most_desired_sex = "Male"
			majority_kisser = "Boykissers"
		if(KISS_GIRLS)
			most_desired_sex = "Female"
			majority_kisser = "Girlkissers"
		if(KISS_ANY)
			most_desired_sex = "Male and/or Female" // ye
			majority_kisser = "Anykissers"
	
	var/most_desired_tbs = "Top/Bottom/Switch"
	switch(majority_tbs)
		if(TBS_BOTTOM)
			most_desired_tbs = "Switch / Top"
			majority_tbs = "Bottoms"
		if(TBS_TOP)
			most_desired_tbs = "Switch / Bottom"
			majority_tbs = "Tops"
		if(TBS_SHOES)
			most_desired_tbs = "Top / Switch" // ye
			majority_tbs = "Switches"
	
	switch(majority_sex)
		if(MALE)
			majority_sex = "Males"
		if(FEMALE)
			majority_sex = "Females"
		if(PLURAL)
			majority_sex = "Nonbinaries"
		else
			majority_sex = "Anysexes"
	
	/// There are a lot of Boykissing Female Tops on!
	var/majority_string = "The server has a lot of [majority_kisser], and [majority_sex], and [majority_tbs] on!"
	/// milk yeah of course
	var/desired_string = "If you're looking for a good time, you should play \a [most_desired_sex] [most_desired_tbs]!"
	nashs_most_wanted = desired_string
	the_majority = majority_string
	/// all done!
	
	/// hm, what of the majority_sex is relevant here?
	/// how bout this:
	/// we print what is most desired, *and* what is most popular
	/// but, two lines
	/// There are a lot of Straight Female Tops on!
	/// And yeah
	/// and more readable~
	/// Id want to keep the kink demographic to another tab
	/// feels a lot more appropriate
	/// tonight? hm, tgui? tgui is easier, oddly enough, plus ahelp code is fuuuuucked
	/// I like it




/datum/controller/subsystem/statpanels/proc/generate_mc_data()
	var/list/mc_data = list(
		list("CPU:", world.cpu),
		list("Instances:", "[num2text(world.contents.len, 10)]"),
		list("World Time:", "[world.time]"),
		list("Globals:", GLOB.stat_entry(), "\ref[GLOB]"),
		list("[config]:", config.stat_entry(), "\ref[config]"),
		list("Byond:", "(FPS:[world.fps]) (TickCount:[world.time/world.tick_lag]) (TickDrift:[round(Master.tickdrift,1)]([round((Master.tickdrift/(world.time/world.tick_lag))*100,0.1)]%)) (Internal Tick Usage: [round(MAPTICK_LAST_INTERNAL_TICK_USAGE,0.1)]%)"),
		list("Master Controller:", Master.stat_entry(), "\ref[Master]"),
		list("Failsafe Controller:", Failsafe.stat_entry(), "\ref[Failsafe]"),
		list("","")
	)
	for(var/ss in Master.subsystems)
		var/datum/controller/subsystem/sub_system = ss
		mc_data[++mc_data.len] = list("\[[sub_system.state_letter()]][sub_system.name]", sub_system.stat_entry(), "\ref[sub_system]")
	mc_data[++mc_data.len] = list("Camera Net", "Cameras: [GLOB.cameranet.cameras.len] | Chunks: [GLOB.cameranet.chunks.len]", "\ref[GLOB.cameranet]")
	mc_data_encoded = url_encode(json_encode(mc_data))

/atom/proc/remove_from_cache()
	SIGNAL_HANDLER
	SSstatpanels.cached_images -= REF(src)

/// verbs that send information from the browser UI
/client/verb/set_tab(tab as text|null)
	set name = "Set Tab"
	set hidden = TRUE

	stat_tab = tab

/client/verb/send_tabs(tabs as text|null)
	set name = "Send Tabs"
	set hidden = TRUE

	panel_tabs |= tabs

/client/verb/remove_tabs(tabs as text|null)
	set name = "Remove Tabs"
	set hidden = TRUE

	panel_tabs -= tabs

/client/verb/reset_tabs()
	set name = "Reset Tabs"
	set hidden = TRUE

	panel_tabs = list()

/client/verb/panel_ready()
	set name = "Panel Ready"
	set hidden = TRUE

	statbrowser_ready = TRUE
	init_verbs()

/client/verb/update_verbs()
	set name = "Update Verbs"
	set hidden = TRUE

	init_verbs()

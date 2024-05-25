#define LINKIFY_READY(string, value) "<a href='byond://?src=[REF(src)];ready=[value]'>[string]</a>"
/mob/dead/new_player
	flags_1 = NONE
	invisibility = INVISIBILITY_ABSTRACT
	density = FALSE
	stat = DEAD

	//is there a result we want to read from the age gate
	var/age_gate_result

	var/ready = FALSE
	/// Referenced when you want to delete the new_player later on in the code.
	var/spawning = FALSE
	/// For instant transfer once the round is set up
	var/mob/living/new_character
	///Used to make sure someone doesn't get spammed with messages if they're ineligible for roles.
	var/ineligible_for_roles = FALSE



/mob/dead/new_player/Initialize(mapload)
	// if(client && SSticker.state == GAME_STATE_STARTUP)
	// 	var/atom/movable/screen/splash/S = new(null, client, TRUE, TRUE)
	// 	S.Fade(TRUE)

	if(length(GLOB.newplayer_start))
		forceMove(pick(GLOB.newplayer_start))
	else
		forceMove(locate(1,1,1))

	ComponentInitialize()

	. = ..()

	GLOB.new_player_list += src

/mob/dead/new_player/Destroy()
	GLOB.new_player_list -= src

	return ..()

/mob/dead/new_player/prepare_huds()
	return

/mob/dead/new_player/proc/new_player_panel()
	if (client?.interviewee)
		return

	var/datum/asset/asset_datum = get_asset_datum(/datum/asset/simple/lobby)
	asset_datum.send(client)
	var/list/output = list()
	if(client?.prefs)
		output += "<center><p>Welcome, <b>[client.prefs.be_random_name ? "random name player" : client.prefs.real_name]</b></p>"
		output += "<center><p><a href='byond://?src=[REF(src)];show_preferences=1'>Setup Character</a></p>"
		if(SSquirks.initialized)
			if(!(PMC_QUIRK_OVERHAUL_2K23 in client.prefs.current_version))
				output += "<center><p>[span_alert("You have quirks from the old system that haven't been converted!")]</p>"
				output += "<center><p><a href='byond://?src=[REF(src)];quirkconversion=1'>Click here to do something about that!</a></p>"
			else
				output += "<center><p><a href='byond://?src=[REF(src)];quirks=1'>Configure Quirks!</a></p>"

	if(SSticker.current_state <= GAME_STATE_PREGAME)
		output += "<p>Please be patient, the game is starting soon!</p>"
		output += "<p><a href='byond://?src=[REF(src)];refresh=1'>(Refresh)</a></p>"
		output += "<p><a href='byond://?src=[REF(src)];refresh_chat=1)'>(Fix Chat Window)</a></p>"
		output += "<p><a href='byond://?src=[REF(src)];fit_viewport_lobby=1)'>(Fit Viewport)</a></p>"
	else
		output += "<p><a href='byond://?src=[REF(src)];manifest=1'>View the Crew Manifest</a></p>"
		output += "<p><a href='byond://?src=[REF(src)];directory=1'>View Character Directory</a></p>"
		output += "<p><a href='byond://?src=[REF(src)];late_join=1'>Join Game!</a></p>"
		output += "<p>[LINKIFY_READY("Observe", PLAYER_READY_TO_OBSERVE)]</p>"
		output += "<p><a href='byond://?src=[REF(src)];join_as_creature=1'>Join as Simple Creature!</a></p>"
		output += "<p><a href='byond://?src=[REF(src)];refresh_chat=1)'>(Fix Chat Window)</a></p>"
		output += "<p><a href='byond://?src=[REF(src)];fit_viewport_lobby=1)'>(Fit Viewport)</a></p>"

	// if(!IsGuestKey(src.key))
	// 	output += playerpolls()

	output += "</center>"

	var/datum/browser/popup = new(src, "playersetup", "<div align='center'>New Player Options</div>", 250, 400)
	popup.set_window_options("can_close=0")
	popup.set_content(output.Join())
	popup.open(FALSE)

/mob/dead/new_player/proc/playerpolls()
	var/list/output = list()
	if (SSdbcore.Connect())
		var/isadmin = FALSE
		if(client?.holder)
			isadmin = TRUE
		var/datum/db_query/query_get_new_polls = SSdbcore.NewQuery({"
			SELECT id FROM [format_table_name("poll_question")]
			WHERE (adminonly = 0 OR :isadmin = 1)
			AND Now() BETWEEN starttime AND endtime
			AND id NOT IN (
				SELECT pollid FROM [format_table_name("poll_vote")]
				WHERE ckey = :ckey
			)
			AND id NOT IN (
				SELECT pollid FROM [format_table_name("poll_textreply")]
				WHERE ckey = :ckey
			)
		"}, list("isadmin" = isadmin, "ckey" = ckey))
		var/rs = REF(src)
		if(!query_get_new_polls.Execute())
			qdel(query_get_new_polls)
			return
		if(query_get_new_polls.NextRow())
			output += "<p><b><a href='byond://?src=[rs];showpoll=1'>Show Player Polls</A> (NEW!)</b></p>"
		else
			output += "<p><a href='byond://?src=[rs];showpoll=1'>Show Player Polls</A></p>"
		qdel(query_get_new_polls)
		if(QDELETED(src))
			return
		return output

/mob/dead/new_player/Topic(href, href_list[])
	if(src != usr)
		return

	if(!client)
		return

	if(client.interviewee)
		return FALSE

	//don't let people get to this unless they are specifically not verified
	if(href_list["Month"] && (CONFIG_GET(flag/age_verification) && !check_rights_for(client, R_ADMIN) && !(client.ckey in GLOB.bunker_passthrough)))
		var/player_month = text2num(href_list["Month"])
		var/player_year = text2num(href_list["Year"])

		var/current_time = world.realtime
		var/current_month = text2num(time2text(current_time, "MM"))
		var/current_year = text2num(time2text(current_time, "YYYY"))

		var/player_total_months = (player_year * 12) + player_month

		var/current_total_months = (current_year * 12) + current_month

		var/months_in_eighteen_years = 18 * 12

		var/month_difference = current_total_months - player_total_months
		if(month_difference > months_in_eighteen_years)
			age_gate_result = TRUE // they're fine
		else
			if(month_difference < months_in_eighteen_years)
				age_gate_result = FALSE
			else
				//they could be 17 or 18 depending on the /day/ they were born in
				var/current_day = text2num(time2text(current_time, "DD"))
				var/days_in_months = list(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
				if((player_year % 4) == 0) // leap year so february actually has 29 days
					days_in_months[2] = 29
				var/total_days_in_player_month = days_in_months[player_month]
				var/list/days = list()
				for(var/number in 1 to total_days_in_player_month)
					days += number
				var/player_day = input(src, "What day of the month were you born in.") as anything in days
				if(player_day <= current_day)
					//their birthday has passed
					age_gate_result = TRUE
				else
					//it has NOT been their 18th birthday yet
					age_gate_result = FALSE

	//Determines Relevent Population Cap
	var/relevant_cap
	var/hpc = CONFIG_GET(number/hard_popcap)
	var/epc = CONFIG_GET(number/extreme_popcap)
	if(hpc && epc)
		relevant_cap = min(hpc, epc)
	else
		relevant_cap = max(hpc, epc)

	if(href_list["show_preferences"])
		client.prefs.ShowChoices(src)
		return 1

	if(href_list["directory"])
		client.show_character_directory()
		return 1

	if(href_list["quirkconversion"])
		SSquirks.ConvertOldQuirklistToNewQuirklist(client.prefs)
		new_player_panel()
		return 1

	if(href_list["quirks"])
		SSquirks.OpenWindow(src) // cant eat my cool menu if its not there to eat it!
		return 1

	if(href_list["ready"])
		var/tready = text2num(href_list["ready"])
		//Avoid updating ready if we're after PREGAME (they should use latejoin instead)
		//This is likely not an actual issue but I don't have time to prove that this
		//no longer is required
		if(SSticker.current_state <= GAME_STATE_PREGAME)
			if((length_char(client.prefs.features["flavor_text"])) < MIN_FLAVOR_LEN)
				to_chat(client.mob, span_danger("Your flavortext does not meet the minimum of [MIN_FLAVOR_LEN] characters."))
				return
			if((length_char(client.prefs.features["ooc_notes"])) < MIN_OOC_LEN || client.prefs.features["ooc_notes"] == OOC_NOTE_TEMPLATE)
				to_chat(client.mob, span_danger("Your ooc notes is empty, please enter information about your roleplaying preferences."))
				return
			ready = tready
		//if it's post initialisation and they're trying to observe we do the needful
		if(SSticker.current_state >= GAME_STATE_PREGAME && tready == PLAYER_READY_TO_OBSERVE)
			ready = tready
			make_me_an_observer()
			return

	if(href_list["refresh"])
		src << browse(null, "window=playersetup") //closes the player setup window
		new_player_panel()

	if(href_list["refresh_chat"]) //fortuna addition. asset delivery pain
		client.nuke_chat()

	if(href_list["fit_viewport_lobby"])
		client.fit_viewport()

	if(href_list["late_join"])
		if(!SSticker || !SSticker.IsRoundInProgress())
			to_chat(usr, span_danger("The round is either not ready, or has already finished..."))
			return

		if((length_char(client.prefs.features["flavor_text"])) < MIN_FLAVOR_LEN)
			to_chat(client.mob, span_danger("Your flavortext does not meet the minimum of [MIN_FLAVOR_LEN] characters."))
			return

		if((length_char(client.prefs.features["ooc_notes"])) < MIN_OOC_LEN || client.prefs.features["ooc_notes"] == OOC_NOTE_TEMPLATE)
			to_chat(client.mob, span_danger("Your ooc notes is empty, please enter information about your roleplaying preferences."))
			return

		if(href_list["late_join"] == "override")
			LateChoices()
			return

		if(SSticker.queued_players.len || (relevant_cap && living_player_count() >= relevant_cap && !(ckey(key) in GLOB.admin_datums)))
			to_chat(usr, span_danger("[CONFIG_GET(string/hard_popcap_message)]"))

			var/queue_position = SSticker.queued_players.Find(usr)
			if(queue_position == 1)
				to_chat(usr, span_notice("You are next in line to join the game. You will be notified when a slot opens up."))
			else if(queue_position)
				to_chat(usr, span_notice("There are [queue_position-1] players in front of you in the queue to join the game."))
			else
				SSticker.queued_players += usr
				to_chat(usr, span_notice("You have been added to the queue to join the game. Your position in queue is [SSticker.queued_players.len]."))
			return

/* 		if(GLOB.data_core.get_record_by_name(client.prefs.real_name))
			alert(src, "This character name is already in use. Choose another.")
			return */

		PreLateChoices()

	if(href_list["join_as_creature"])
		CreatureSpawn()
	if(href_list["manifest"])
		ViewManifest()

	if(href_list["SelectedJob"])
		if(!SSticker || !SSticker.IsRoundInProgress())
			var/msg = "[key_name(usr)] attempted to join the round using a href that shouldn't be available at this moment!"
			log_admin(msg)
			message_admins(msg)
			to_chat(usr, span_danger("The round is either not ready, or has already finished..."))
			return

		if(!GLOB.enter_allowed)
			to_chat(usr, span_notice("There is an administrative lock on entering the game!"))
			return

		if(SSticker.queued_players.len && !(ckey(key) in GLOB.admin_datums))
			if((living_player_count() >= relevant_cap) || (src != SSticker.queued_players[1]))
				to_chat(usr, span_warning("Server is full."))
				return

		AttemptLateSpawn(href_list["SelectedJob"])
		return

	if(href_list["JoinAsGhostRole"])
		if(!GLOB.enter_allowed)
			to_chat(usr, span_notice(" There is an administrative lock on entering the game!"))

		if(SSticker.queued_players.len && !(ckey(key) in GLOB.admin_datums))
			if((living_player_count() >= relevant_cap) || (src != SSticker.queued_players[1]))
				to_chat(usr, span_warning("Server is full."))
				return

		var/obj/effect/mob_spawn/MS = pick(GLOB.mob_spawners[href_list["JoinAsGhostRole"]])
		if(MS.attack_ghost(src, latejoinercalling = TRUE))
			SSticker.queued_players -= src
			SSticker.queue_delay = 4
			qdel(src)

	else if(!href_list["late_join"] && client)
		new_player_panel()

	if(href_list["showpoll"])
		handle_player_polling()
		return

	if(href_list["pollid"])
		var/pollid = href_list["pollid"]
		if(istext(pollid))
			pollid = text2num(pollid)
		if(isnum(pollid) && ISINTEGER(pollid))
			src.poll_player(pollid)
		return

	if(href_list["votepollid"] && href_list["votetype"])
		var/pollid = text2num(href_list["votepollid"])
		var/votetype = href_list["votetype"]
		//lets take data from the user to decide what kind of poll this is, without validating it
		//what could go wrong
		switch(votetype)
			if(POLLTYPE_OPTION)
				var/optionid = text2num(href_list["voteoptionid"])
				if(vote_on_poll(pollid, optionid))
					to_chat(usr, span_notice("Vote successful."))
				else
					to_chat(usr, span_danger("Vote failed, please try again or contact an administrator."))
			if(POLLTYPE_TEXT)
				var/replytext = href_list["replytext"]
				if(log_text_poll_reply(pollid, replytext))
					to_chat(usr, span_notice("Feedback logging successful."))
				else
					to_chat(usr, span_danger("Feedback logging failed, please try again or contact an administrator."))
			if(POLLTYPE_RATING)
				var/id_min = text2num(href_list["minid"])
				var/id_max = text2num(href_list["maxid"])

				if( (id_max - id_min) > 100 )	//Basic exploit prevention
												//(protip, this stops no exploits)
					to_chat(usr, "The option ID difference is too big. Please contact administration or the database admin.")
					return

				for(var/optionid = id_min; optionid <= id_max; optionid++)
					if(!isnull(href_list["o[optionid]"]))	//Test if this optionid was replied to
						var/rating
						if(href_list["o[optionid]"] == "abstain")
							rating = null
						else
							rating = text2num(href_list["o[optionid]"])
							if(!isnum(rating) || !ISINTEGER(rating))
								return

						if(!vote_on_numval_poll(pollid, optionid, rating))
							to_chat(usr, span_danger("Vote failed, please try again or contact an administrator."))
							return
				to_chat(usr, span_notice("Vote successful."))
			if(POLLTYPE_MULTI)
				var/id_min = text2num(href_list["minoptionid"])
				var/id_max = text2num(href_list["maxoptionid"])

				if( (id_max - id_min) > 100 )	//Basic exploit prevention
					to_chat(usr, "The option ID difference is too big. Please contact administration or the database admin.")
					return

				for(var/optionid = id_min; optionid <= id_max; optionid++)
					if(!isnull(href_list["option_[optionid]"]))	//Test if this optionid was selected
						var/i = vote_on_multi_poll(pollid, optionid)
						switch(i)
							if(0)
								continue
							if(1)
								to_chat(usr, span_danger("Vote failed, please try again or contact an administrator."))
								return
							if(2)
								to_chat(usr, span_danger("Maximum replies reached."))
								break
				to_chat(usr, span_notice("Vote successful."))
			if(POLLTYPE_IRV)
				if (!href_list["IRVdata"])
					to_chat(src, span_danger("No ordering data found. Please try again or contact an administrator."))
					return
				var/list/votelist = splittext(href_list["IRVdata"], ",")
				if (!vote_on_irv_poll(pollid, votelist))
					to_chat(src, span_danger("Vote failed, please try again or contact an administrator."))
					return
				to_chat(src, span_notice("Vote successful."))

//When you cop out of the round (NB: this HAS A SLEEP FOR PLAYER INPUT IN IT)
/mob/dead/new_player/proc/make_me_an_observer()
	if(QDELETED(src) || !src.client)
		ready = PLAYER_NOT_READY
		return FALSE

	// var/this_is_like_playing_right = alert(src,"Are you sure you wish to observe? No current restrictions on observing, you can spawn in as normal.","Player Setup","Yes","No")

	if(QDELETED(src) || !src.client)
		ready = PLAYER_NOT_READY
		src << browse(null, "window=playersetup") //closes the player setup window
		new_player_panel()
		return FALSE

	// if(client.holder && check_rights(R_STEALTH, 0))
	// 	var/do_stealth = alert(src, "You're an admin! Do you want to stealthmin?", "Stealthmin", "Yes", "No")
	// 	if(do_stealth == "Yes")
	// 		client.stealth()

	var/mob/dead/observer/observer = new()
	spawning = TRUE

	observer.started_as_observer = TRUE
	close_spawn_windows()
	var/obj/effect/landmark/observer_start/O = locate(/obj/effect/landmark/observer_start) in GLOB.landmarks_list
	to_chat(src, span_notice("Now teleporting."))
	if (O)
		observer.forceMove(O.loc)
	else
		to_chat(src, span_notice("Teleporting failed. Ahelp an admin please"))
		stack_trace("There's no freaking observer landmark available on this map or you're making observers before the map is initialised")
	if(mind)
		mind.transfer_to(observer, TRUE)
	else
		transfer_ckey(observer, FALSE)
		observer.client = client
	observer.set_ghost_appearance()
	if(observer.client && observer.client.prefs)
		observer.real_name = observer.client.prefs.real_name
		observer.name = observer.real_name
		observer.client.init_verbs()
	observer.update_icon()
	observer.stop_sound_channel(CHANNEL_LOBBYMUSIC)
	QDEL_NULL(mind)
	qdel(src)
	return TRUE

/proc/get_job_unavailable_error_message(retval, jobtitle)
	switch(retval)
		if(JOB_AVAILABLE)
			return "[jobtitle] is available."
		if(JOB_UNAVAILABLE_GENERIC)
			return "[jobtitle] is unavailable."
		if(JOB_UNAVAILABLE_BANNED)
			return "You are currently banned from [jobtitle]."
		if(JOB_UNAVAILABLE_PLAYTIME)
			return "You do not have enough relevant playtime for [jobtitle]."
		if(JOB_UNAVAILABLE_ACCOUNTAGE)
			return "Your account is not old enough for [jobtitle]."
		if(JOB_UNAVAILABLE_SLOTFULL)
			return "[jobtitle] is already filled to capacity."
		if(JOB_UNAVAILABLE_SPECIESLOCK)
			return "Your species cannot play as a [jobtitle]."
		if(JOB_UNAVAILABLE_WHITELIST)
			return "[jobtitle] requires a whitelist."
	return "Error: Unknown job availability."

/mob/dead/new_player/proc/IsJobUnavailable(rank, latejoin = FALSE)
	var/datum/job/job = SSjob.GetJob(rank)
	if(!job)
		return JOB_UNAVAILABLE_GENERIC
	if((job.current_positions >= job.total_positions) && job.total_positions != -1)
		if(job.title == "Assistant")
			if(isnum(client.player_age) && client.player_age <= 14) //Newbies can always be assistants
				return JOB_AVAILABLE
			for(var/datum/job/J in SSjob.occupations)
				if(J && J.current_positions < J.total_positions && J.title != job.title)
					return JOB_UNAVAILABLE_SLOTFULL
		else
			return JOB_UNAVAILABLE_SLOTFULL
	if(jobban_isbanned(src,rank))
		return JOB_UNAVAILABLE_BANNED
	if(QDELETED(src))
		return JOB_UNAVAILABLE_GENERIC
	if(!job.player_old_enough(client))
		return JOB_UNAVAILABLE_ACCOUNTAGE
	if(job.required_playtime_remaining(client))
		return JOB_UNAVAILABLE_PLAYTIME
	if(job.whitelist_locked(client,job.title))  //x check if this user should have access to this job via whitelist
		return JOB_UNAVAILABLE_WHITELIST
	if(latejoin && !job.special_check_latejoin(client))
		return JOB_UNAVAILABLE_GENERIC
	if(!client.prefs.pref_species.qualifies_for_rank(rank, client.prefs.features))
		return JOB_UNAVAILABLE_SPECIESLOCK
	if(LAZYLEN(SSmapping?.config?.removed_jobs))
		for(var/J in SSmapping.config.removed_jobs) //Search through our individual jobs to be removed
			if(job.title == J) //Found one, abort.
				return JOB_UNAVAILABLE_GENERIC
			if(J == "#all#" && LAZYLEN(SSmapping.config.added_jobs)) //Uhoh, remove everything but added jobs
				if(!(job.title in SSmapping.config.added_jobs))
					return JOB_UNAVAILABLE_GENERIC //Not found, get us out of here

	return JOB_AVAILABLE

/mob/dead/new_player/proc/AttemptLateSpawn(rank)
	var/error = IsJobUnavailable(rank)
	if(error != JOB_AVAILABLE)
		alert(src, get_job_unavailable_error_message(error, rank))
		return FALSE

	if(SSticker.late_join_disabled)
		alert(src, "An administrator has disabled late join spawning.")
		return FALSE

	if((length_char(client.prefs.features["flavor_text"])) < MIN_FLAVOR_LEN)
		to_chat(client.mob, span_danger("Your flavortext does not meet the minimum of [MIN_FLAVOR_LEN] characters."))
		return FALSE

	if((length_char(client.prefs.features["ooc_notes"])) < MIN_OOC_LEN || client.prefs.features["ooc_notes"] == OOC_NOTE_TEMPLATE)
		to_chat(client.mob, span_danger("Your ooc notes is empty, please enter information about your roleplaying preferences."))
		return

	var/arrivals_docked = TRUE
	if(SSshuttle.arrivals)
		close_spawn_windows()	//In case we get held up
		if(SSshuttle.arrivals.damaged && CONFIG_GET(flag/arrivals_shuttle_require_safe_latejoin))
			src << alert("The arrivals shuttle is currently malfunctioning! You cannot join.")
			return FALSE

		if(CONFIG_GET(flag/arrivals_shuttle_require_undocked))
			SSshuttle.arrivals.RequireUndocked(src)
		arrivals_docked = SSshuttle.arrivals.mode != SHUTTLE_CALL

	//Remove the player from the join queue if he was in one and reset the timer
	SSticker.queued_players -= src
	SSticker.queue_delay = 4

	SSjob.AssignRole(src, rank, 1)

	var/mob/living/character = create_character(TRUE)	//creates the human and transfers vars and mind
	var/equip = SSjob.EquipRank(character, rank, TRUE)
	if(isliving(equip))	//Borgs get borged in the equip, so we need to make sure we handle the new mob.
		character = equip

	var/datum/job/job = SSjob.GetJob(rank)

	if(job && !job.override_latejoin_spawn(character))
		SSjob.SendToLateJoin(character)
		if(!arrivals_docked)
			var/atom/movable/screen/splash/Spl = new(character.client, TRUE)
			Spl.Fade(TRUE)
			character.playsound_local(get_turf(character), 'sound/voice/ApproachingTG.ogg', 25)

		character.update_parallax_teleport()

	job.standard_assign_skills(character.mind)

	SSticker.minds += character.mind
	character.client.init_verbs() // init verbs for the late join
	var/mob/living/carbon/human/humanc
	if(ishuman(character))
		humanc = character	//Let's retypecast the var to be human,

	if(humanc)	//These procs all expect humans
		GLOB.data_core.manifest_inject(humanc, humanc.client, humanc.client.prefs)
		if(SSshuttle.arrivals)
			SSshuttle.arrivals.QueueAnnounce(humanc, rank)
		else
			AnnounceArrival(humanc, rank)
		AddEmploymentContract(humanc)
		if(GLOB.highlander)
			to_chat(humanc, span_userdanger("<i>THERE CAN BE ONLY ONE!!!</i>"))
			humanc.make_scottish()

		if(GLOB.summon_guns_triggered)
			give_guns(humanc)
		if(GLOB.summon_magic_triggered)
			give_magic(humanc)
		if(GLOB.curse_of_madness_triggered)
			give_madness(humanc, GLOB.curse_of_madness_triggered)
		if(humanc.client)
			humanc.client.prefs.post_copy_to(humanc)

	if(character.client.prefs.waddle_amount > 0)
		character.AddComponent(/datum/component/waddling, character.client.prefs.waddle_amount, character.client.prefs.up_waddle_time, character.client.prefs.side_waddle_time)

	GLOB.joined_player_list += character.ckey
	GLOB.latejoiners += character

	if(CONFIG_GET(flag/allow_latejoin_antagonists) && humanc)	//Borgs aren't allowed to be antags. Will need to be tweaked if we get true latejoin ais.
		if(SSshuttle.emergency)
			switch(SSshuttle.emergency.mode)
				if(SHUTTLE_RECALL, SHUTTLE_IDLE)
					SSticker.mode.make_antag_chance(humanc)
				if(SHUTTLE_CALL)
					if(SSshuttle.emergency.timeLeft(1) > initial(SSshuttle.emergencyCallTime)*0.5)
						SSticker.mode.make_antag_chance(humanc)

	if(humanc && CONFIG_GET(flag/roundstart_traits))
		SSquirks.AssignQuirks(
			humanc,
			humanc.client,
			TRUE,
			FALSE,
			job,
		)
	if(humanc.client && humanc.ckey == "tk420634")
		humanc.client.deadmin()
	log_manifest(character.mind.key,character.mind,character,latejoin = TRUE)
	SSevents.holiday_on_join(humanc)

	if(ishuman(humanc))
		var/mob/living/carbon/human/H = humanc
		var/obj/item/suit = H.get_item_by_slot(SLOT_WEAR_SUIT)
		if(HAS_TRAIT(H, TRAIT_NO_MED_HVY_ARMOR) && (!isnull(suit)))
			if( suit.armor.melee		> (ARMOR_AVERSION_THRESHOLD_MELEE) || \
				suit.armor.bullet		> (ARMOR_AVERSION_THRESHOLD_BULLET) || \
				suit.armor.laser		> (ARMOR_AVERSION_THRESHOLD_LASER) || \
				suit.armor.damage_threshold	> (ARMOR_AVERSION_THRESHOLD_THRES))

				H.dropItemToGround(suit)
				to_chat(H, span_danger("You can't wear this armour, it's too heavy!"))

	character.client.is_in_game = 1
	spawn(5 MINUTES)
		if(character?.client?.is_in_game)
			character?.client?.is_in_game = 2

			for(var/i in GLOB.player_list)
				if(isliving(i))
					if(istype(humanc.get_item_by_slot(SLOT_WEAR_ID), /obj/item/card/id/selfassign))
						var/obj/item/card/id/selfassign/id = humanc.get_item_by_slot(SLOT_WEAR_ID)
						to_chat(i, span_nicegreen("You hear through the grapevine that [humanc.name] the [id.assignment] may be snooping around the county."))

					else if(istype(humanc.get_item_by_slot(SLOT_WEAR_ID), /obj/item/pda))
						var/obj/item/pda/id = humanc.get_item_by_slot(SLOT_WEAR_ID)
						to_chat(i, span_nicegreen("You hear through the grapevine that [humanc.name] the [id.ownjob] may be snooping around the county."))

					else
						to_chat(i, span_nicegreen("You hear through the grapevine that [humanc.name] the [rank] may be snooping around the county."))

/mob/dead/new_player/proc/AddEmploymentContract(mob/living/carbon/human/employee)
	//TODO:  figure out a way to exclude wizards/nukeops/demons from this.
	for(var/C in GLOB.employmentCabinets)
		var/obj/structure/filingcabinet/employment/employmentCabinet = C
		if(!employmentCabinet.virgin)
			employmentCabinet.addFile(employee)

/mob/dead/new_player/proc/CreatureSpawn()
	if(ckey && client && client.prefs.creature_species)
		if(alert(src, "Better creature characters can now be made via the regular Species dropdown menu where you'd normally pick your human race. Are you sure you'd rather play the old-style simple creatures?", "Creature Update!", "I'll try them out!", "I still want to play as a simple creature.") == "I'll try them out!")
			client.prefs.ShowChoices(src)
			return
		var/datum/preferences/P = client.prefs
		if(!P.creature_flavor_text || !P.creature_ooc)
			to_chat(src, span_userdanger("You must set your Creature OOC Notes and Flavor Text before joining as a creature."))
			return FALSE
		var/spawn_selection = input(src, "Select a Creature Spawnpoint", "Spawnpoint Selection") as null|anything in GLOB.creature_spawnpoints
		if(!spawn_selection || QDELETED(src) || !ckey)
			return FALSE

		spawning = 1
		close_spawn_windows()
		var/spawntype = GLOB.creature_spawnpoints["[spawn_selection]"]
		//Create the new mob
		var/creature_type = GLOB.creature_selectable["[P.creature_species]"]
		var/mob/living/simple_animal/C = new creature_type(src)
		//Log their arrival
		log_and_message_admins("[ADMIN_PP(src)] joined as \a [P.creature_species] named [P.creature_name] and spawned at [spawn_selection].")
		//Set up their HUD, hands, and intents.
		C.dextrous_hud_type = /datum/hud/dextrous/drone
		C.dextrous = TRUE
		C.held_items = list(null, null)
		C.possible_a_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, INTENT_HARM)
		//Give them some starting items
		var/obj/item/implant/radio/slime/imp = new//Implant with a radio
		imp.implant(C, src)
		//Give them a backpack and fill it with the starter kit that everyone gets
		var/obj/item/storage/backpack/duffelbag/S = new(C)
		C.equip_to_slot(S, SLOT_GENERIC_DEXTROUS_STORAGE)
		if(S)
			new /obj/item/storage/wallet/stash/low(S)
			new /obj/item/stack/medical/gauze(S)//Give them some gauze for healing
			new /obj/item/flashlight(S)//Give them a flashlight for seeing
			new /obj/item/melee/onehanded/knife/hunting(S)//And a knife for crafting/gutting
			new /obj/item/kit_spawner/townie(S)//And a weapon so they can play the game :tm:
			new /obj/item/kit_spawner/tools(S)//And a toolkit for job stuffs
			new /obj/item/pda(S)//And a PDA since everyone else spawns with one, too
			new /obj/item/card/id/selfassign(S)//And an ID card to swipe into the PDA
		//Assign the mob's information based on the player's client preferences
		switch(P.gender)
			if("male")
				C.gender = MALE
			if("female")
				C.gender = FEMALE
			else
				C.gender = PLURAL
		//Set up their name and what not
		C.name = P.creature_name
		C.real_name = P.creature_name
		C.flavortext = P.creature_flavor_text
		C.oocnotes = P.creature_ooc
		C.profilePicture = P.creature_profilepic
		C.pfphost = P.creature_pfphost
		C.verbose_species = "[P.creature_species]"
		C.special_s = P.special_s
		C.special_p = P.special_p
		C.special_e = P.special_e
		C.special_c = P.special_c
		C.special_i = P.special_i
		C.special_a = P.special_a
		C.special_l = P.special_l
		//C.fuzzy = P.creature_fuzzy
		//C.resize = P.creature_body_size
		//Disable their mob's AI so they don't wander after the player ghosts out of them
		C.AIStatus = AI_OFF
		C.wander = FALSE
		C.can_have_ai = FALSE
		//Set them as a player-character simplemob so examine and such changes to show their character prefs
		C.player_character = ckey
		//Grant them the english language just in case they don't have it.
		C.grant_language(/datum/language/common)
		//Prepare their spawnpoint
		var/list/avail_spawns = list()
		for(var/SP in GLOB.landmarks_list)
			if(istype(SP, spawntype))
				avail_spawns += SP
		var/obj/effect/landmark/rand_spawn = pick(avail_spawns)
		//Move them to the selected spawnpoint and transfer the player into the new mob
		C.forceMove(get_turf(rand_spawn))
		transfer_ckey(C, TRUE)
		//Alert deadchat of their arrival
		var/dsay_message = "<span class='game deadsay'><span class='name'>[C.real_name]</span> ([P.creature_species]) has entered the wasteland at <span class='name'>[spawn_selection]</span>.</span>"
		deadchat_broadcast(dsay_message, follow_target = C, message_type=DEADCHAT_ARRIVALRATTLE)

		//Insert the quirks, do it now
		SSquirks.AssignQuirks(C, C.client, TRUE, FALSE)
		//Then he waddled away, waddle waddle. To the very next day.
		if(P.waddle_amount > 0)
			C.AddComponent(/datum/component/waddling, P.waddle_amount, P.up_waddle_time, P.side_waddle_time)

/mob/dead/new_player/proc/PreLateChoices()
	// if(client.holder && check_rights(R_STEALTH, 0))
	// 	var/do_stealth = alert(src, "You're an admin! Do you want to stealthmin?", "Stealthmin", "Yes", "No")
	// 	if(do_stealth == "Yes")
	// 		client.stealth()
	LateChoices()

/mob/dead/new_player/proc/LateChoices()
	var/list/dat = list()

	dat += "<div class='notice'>Round Duration: [DisplayTimeText(world.time - SSticker.round_start_time)]</div>"

	if(SSshuttle.emergency)
		switch(SSshuttle.emergency.mode)
			if(SHUTTLE_ESCAPE)
				dat += "<div class='notice red'>The area has been evacuated.</div><br>"
			if(SHUTTLE_CALL)
				if(!SSshuttle.canRecall())
					dat += "<div class='notice red'>The area is currently undergoing evacuation procedures.</div><br>"

	dat += "<table><tr><td valign='top'>"
	var/column_counter = 0
	// render each category's available jobs
	for(var/category in GLOB.position_categories)
		// position_categories contains category names mapped to available jobs and an appropriate color
		var/cat_color = GLOB.position_categories[category]["color"]
		dat += "<fieldset style='width: 185px; border: 2px solid [cat_color]; display: inline'>"
		dat += "<legend align='center' style='color: [cat_color]'>[category]</legend>"
		var/list/dept_dat = list()
		for(var/job in GLOB.position_categories[category]["jobs"])
			var/datum/job/job_datum = SSjob.name_occupations[job]
			if(job_datum && IsJobUnavailable(job_datum.title, TRUE) == JOB_AVAILABLE)
				var/command_bold = ""
				if(job in GLOB.command_positions)
					command_bold = " command"
				dept_dat += "<a class='job[command_bold]' href='byond://?src=[REF(src)];SelectedJob=[job_datum.title]'>[job_datum.title] ([job_datum.current_positions])</a>"
		if(!dept_dat.len)
			dept_dat += "<span class='nopositions'>No positions open.</span>"
		dat += jointext(dept_dat, "")
		dat += "</fieldset><br>"
		column_counter++
		if(column_counter > 0 && (column_counter % 3 == 0))
			dat += "</td><td valign='top'>"
	dat += "</td></tr></table></center>"
	dat += "</div></div>"
	var/datum/browser/popup = new(src, "latechoices", "Choose Profession", 680, 580)
	popup.add_stylesheet("playeroptions", 'html/browser/playeroptions.css')
	popup.set_content(jointext(dat, ""))
	popup.open(FALSE) // 0 is passed to open so that it doesn't use the onclose() proc


/mob/dead/new_player/proc/create_character(transfer_after)
	spawning = 1
	close_spawn_windows()

	var/mob/living/carbon/human/H = new(loc)

	var/frn = CONFIG_GET(flag/force_random_names)
	if(!frn)
		frn = jobban_isbanned(src, "appearance")
		if(QDELETED(src))
			return
	if(frn)
		client.prefs.random_character()
		client.prefs.real_name = client.prefs.pref_species.random_name(gender,1)
	var/cur_scar_index = client.prefs.scars_index
	if(client.prefs.persistent_scars && client.prefs.scars_list["[cur_scar_index]"])
		var/scar_string = client.prefs.scars_list["[cur_scar_index]"]
		var/valid_scars = ""
		for(var/scar_line in splittext(scar_string, ";"))
			if(H.load_scar(scar_line))
				valid_scars += "[scar_line];"

		client.prefs.scars_list["[cur_scar_index]"] = valid_scars
		client.prefs.save_character()

	// load permanent tattoos
	if(client.prefs.permanent_tattoos)
		H.load_all_tattoos(client.prefs.permanent_tattoos)

	client.prefs.copy_to(H, initial_spawn = TRUE)
	H.dna.update_dna_identity()
	if(mind)
		if(transfer_after)
			mind.late_joiner = TRUE
		mind.active = 0					//we wish to transfer the key manually
		mind.transfer_to(H)					//won't transfer key since the mind is not active
		mind.original_character = H
	H.name = real_name
	client.init_verbs()
	. = H
	new_character = .
	if(transfer_after)
		transfer_character()
	H.update_pixel_shifting(TRUE)

/mob/dead/new_player/proc/transfer_character()
	. = new_character
	if(.)
		new_character.key = key		//Manually transfer the key to log them in
		new_character.stop_sound_channel(CHANNEL_LOBBYMUSIC)
		new_character = null
		qdel(src)

/mob/dead/new_player/proc/ViewManifest()
	if(!client)
		return
	if(world.time < client.crew_manifest_delay)
		return
	client.crew_manifest_delay = world.time + (1 SECONDS)

	var/dat = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></head><body>"
	dat += "<h4>Crew Manifest</h4>"
	dat += GLOB.data_core.get_manifest_dr(OOC = 1)

	src << browse(dat, "window=manifest;size=387x420;can_close=1")

/mob/dead/new_player/Move()
	return 0


/mob/dead/new_player/proc/close_spawn_windows()

	src << browse(null, "window=latechoices") //closes late choices window
	src << browse(null, "window=playersetup") //closes the player setup window
	src << browse(null, "window=preferences") //closes job selection
	src << browse(null, "window=mob_occupation")
	src << browse(null, "window=latechoices") //closes late job selection

/*	Used to make sure that a player has a valid job preference setup, used to knock players out of eligibility for anything if their prefs don't make sense.
	A "valid job preference setup" in this situation means at least having one job set to low, or not having "return to lobby" enabled
	Prevents "antag rolling" by setting antag prefs on, all jobs to never, and "return to lobby if preferences not availible"
	Doing so would previously allow you to roll for antag, then send you back to lobby if you didn't get an antag role
	This also does some admin notification and logging as well, as well as some extra logic to make sure things don't go wrong
*/

/mob/dead/new_player/proc/check_preferences()
	if(!client)
		return FALSE //Not sure how this would get run without the mob having a client, but let's just be safe.
	if(client.prefs.joblessrole != RETURNTOLOBBY)
		return TRUE
	// If they have antags enabled, they're potentially doing this on purpose instead of by accident. Notify admins if so.
	var/has_antags = FALSE
	if(client.prefs.be_special.len > 0)
		has_antags = TRUE
	if(client.prefs.job_preferences.len == 0)
		if(!ineligible_for_roles)
			to_chat(src, span_danger("You have no jobs enabled, along with return to lobby if job is unavailable. This makes you ineligible for any round start role, please update your job preferences."))
		ineligible_for_roles = TRUE
		ready = PLAYER_NOT_READY
		if(has_antags)
			log_admin("[src.ckey] just got booted back to lobby with no jobs, but antags enabled.")
			message_admins("[src.ckey] just got booted back to lobby with no jobs enabled, but antag rolling enabled. Likely antag rolling abuse.")

		return FALSE //This is the only case someone should actually be completely blocked from antag rolling as well
	return TRUE

/**
 * Prepares a client for the interview system, and provides them with a new interview
 *
 * This proc will both prepare the user by removing all verbs from them, as well as
 * giving them the interview form and forcing it to appear.
 */
/mob/dead/new_player/proc/register_for_interview()
	// First we detain them by removing all the verbs they have on client
	for (var/v in client.verbs)
		var/procpath/verb_path = v
		if (!(verb_path in GLOB.stat_panel_verbs))
			remove_verb(client, verb_path)

	// Then remove those on their mob as well
	for (var/v in verbs)
		var/procpath/verb_path = v
		if (!(verb_path in GLOB.stat_panel_verbs))
			remove_verb(src, verb_path)
	// Then we create the interview form and show it to the client
	var/datum/interview/I = GLOB.interviews.interview_for_client(client)
	if (I)
		I.ui_interact(src)

	// Add verb for re-opening the interview panel, and re-init the verbs for the stat panel
	add_verb(src, /mob/dead/new_player/proc/open_interview)



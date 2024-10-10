//admin verb groups - They can overlap if you so wish. Only one of each verb will exist in the verbs list regardless
//the procs are cause you can't put the comments in the GLOB var define
GLOBAL_LIST_INIT(admin_verbs_default, world.AVerbsDefault())
GLOBAL_PROTECT(admin_verbs_default)
/world/proc/AVerbsDefault()
	return list(
	/client/proc/deadmin,				/*destroys our own admin datum so we can play as a regular player*/
	/client/proc/cmd_admin_say,			/*admin-only ooc chat*/
	/client/proc/dsay,					/*talk in deadchat using our ckey/fakekey*/
	/client/proc/deadchat,
	/client/proc/investigate_show,		/*various admintools for investigation. Such as a singulo grief-log*/
	/client/proc/debug_variables,		/*allows us to -see- the variables of any instance in the game. +VAREDIT needed to modify*/
	/client/proc/toggleprayers,
	/client/proc/toggleadminhelpsound,
	/client/proc/debugstatpanel,
	/client/proc/ignore_as_a_ghost,
	/client/proc/toggle_admin_wire_tap,
	/client/proc/toggle_seeing_ghosts,  /* Toggles whether or not the player can see ghosts */
	/client/proc/RemoteLOOC, 			/*Fuck you I'm a PascaleCase enjoyer when it comes to functions. Fuck you nerds for using your shitty ass underscores like you know what the fuck you're reading why add an extra character and waste a couple milimeters of eye movement for me to read your entire proc name like jesus fucking christ bro. Just literally use PascalCase it looks so much neater, it's modern, industry professionals are taught to use it, C# coding standards state this, C++ coding standards, Unreal Engine developers do this, and so do Unity professionals. Like bruh please. Join me in the revolution to do PascalCase. */ // Welcome to byond~ src.grab_antlers_and_grind(deer_boi)
	)
GLOBAL_LIST_INIT(admin_verbs_admin, world.AVerbsAdmin())
GLOBAL_PROTECT(admin_verbs_admin)
/world/proc/AVerbsAdmin()
	return list(
	/datum/admins/proc/edit_who,				/*toggles the harm intent no-clickdrag thing*/
	/client/proc/toggle_experimental_clickdrag_thing,				/*toggles the harm intent no-clickdrag thing*/
	/client/proc/toggle_radpuddle_disco_vomit_nightmare,				/*makes radpuddles flash and show numbers. please dont use this*/
	/client/proc/show_radpuddle_scores,				/*makes radpuddles flash and show numbers. please dont use this*/
	/client/proc/invisimin,				/*allows our mob to go invisible/visible*/
//	/datum/admins/proc/show_traitor_panel,	/*interface which shows a mob's mind*/ -Removed due to rare practical use. Moved to debug verbs ~Errorage
	/datum/admins/proc/show_player_panel,	/*shows an interface for individual players, with various links (links require additional flags*/
	/datum/verbs/menu/Admin/verb/playerpanel,
	/client/proc/edit_quest_bank,			/*edit quest bank etc*/
	/client/proc/game_panel,			/*game panel, allows to change game-mode etc*/
	/client/proc/getvpt,                /*shows all users who connected from a shady place*/
	/client/proc/check_ai_laws,			/*shows AI and borg laws*/
	/datum/admins/proc/toggleooc,		/*toggles ooc on/off for everyone*/
	/datum/admins/proc/toggleooclocal,	/*toggles looc on/off for everyone*/
	/datum/admins/proc/toggleoocdead,	/*toggles ooc on/off for everyone who is dead*/
	/datum/admins/proc/toggleaooc,		/*toggles antag ooc on/off*/
	/datum/admins/proc/toggleenter,		/*toggles whether people can join the current game*/
	/datum/admins/proc/toggleguests,	/*toggles whether guests can join the current game*/
	/datum/admins/proc/announce,		/*priority announce something to all clients.*/
	/datum/admins/proc/set_admin_notice, /*announcement all clients see when joining the server.*/
	/client/proc/admin_ghost,			/*allows us to ghost/reenter body at will*/
	/client/proc/toggle_view_range,		/*changes how far we can see*/
	/client/proc/getserverlogs,		/*for accessing server logs*/
	/client/proc/cmd_admin_subtle_message,	/*send an message to somebody as a 'voice in their head'*/
	/client/proc/cmd_admin_headset_message,	/*send an message to somebody through their headset as CentCom*/
	/client/proc/cmd_admin_delete,		/*delete an instance/object/mob/etc*/
	/client/proc/cmd_admin_check_contents,	/*displays the contents of an instance*/
	/client/proc/centcom_podlauncher,/*Open a window to launch a Supplypod and configure it or it's contents*/
	/client/proc/check_antagonists,		/*shows all antags*/
	/datum/admins/proc/access_news_network,	/*allows access of newscasters*/
	/client/proc/jumptocoord,			/*we ghost and jump to a coordinate*/
	/client/proc/getcurrentlogs,		/*for accessing server logs for the current round*/
	/client/proc/Getmob,				/*teleports a mob to our location*/
	/client/proc/Getkey,				/*teleports a mob with a certain ckey to our location*/
//	/client/proc/sendmob,				/*sends a mob somewhere*/ -Removed due to it needing two sorting procs to work, which were executed every time an admin right-clicked. ~Errorage
	/client/proc/jumptoarea,
	/client/proc/jumptovalidball,				/*allows us to jump to the location of a mob with a certain ckey*/
	/client/proc/jumptokey,				/*allows us to jump to the location of a mob with a certain ckey*/
	/client/proc/jumptomob,				/*allows us to jump to a specific mob*/
	/client/proc/jumptoturf,			/*allows us to jump to a specific turf*/
	/client/proc/admin_call_shuttle,	/*allows us to call the emergency shuttle*/
	/client/proc/admin_cancel_shuttle,	/*allows us to cancel the emergency shuttle, sending it back to centcom*/
	/client/proc/cmd_admin_direct_narrate,	/*send text directly to a player with no padding. Useful for narratives and fluff-text*/
	/client/proc/cmd_admin_world_narrate,	/*sends text to all players with no padding*/
	/client/proc/cmd_admin_local_narrate,	/*sends text to all mobs within view of atom*/
	/client/proc/cmd_admin_man_up, //CIT CHANGE - adds man up verb
	/client/proc/cmd_admin_man_up_global, //CIT CHANGE - ditto
	/client/proc/cmd_admin_create_centcom_report,
	/client/proc/cmd_admin_make_priority_announcement, //CIT CHANGE
	/client/proc/cmd_change_command_name,
	/client/proc/cmd_admin_check_player_exp, /* shows players by playtime */
	/client/proc/toggle_combo_hud, // toggle display of the combination pizza antag and taco sci/med/eng hud
	/client/proc/toggle_AI_interact, /*toggle admin ability to interact with machines as an AI*/
	/datum/admins/proc/open_shuttlepanel, /* Opens shuttle manipulator UI */
	/client/proc/respawn_character,
	/client/proc/secrets,
	/client/proc/toggle_hear_radio,		/*allows admins to hide all radio output*/
	/client/proc/toggle_split_admin_tabs,
	/client/proc/reload_admins,
	/client/proc/reestablish_db_connection, /*reattempt a connection to the database*/
	/client/proc/cmd_admin_pm_context,	/*right-click adminPM interface*/
	/client/proc/cmd_admin_pm_panel,		/*admin-pm list*/
	/client/proc/adminChangeMoney,
	/client/proc/adminCheckMoney,
	/client/proc/panicbunker,
	/datum/admins/proc/BC_WhitelistKeyVerb,
	/datum/admins/proc/BC_RemoveKeyVerb,
	/datum/admins/proc/BC_ToggleState,
	/client/proc/stop_sounds,
	/client/proc/mark_datum_mapview,
	/client/proc/hide_verbs,			/*hides all our adminverbs*/
	/client/proc/hide_most_verbs,		/*hides all our hideable adminverbs*/
	/datum/admins/proc/open_borgopanel,
	/datum/admins/proc/toggle_sleep,
	/datum/admins/proc/toggle_sleep_area,
	/datum/admins/proc/refill_nearby_ammo,
	/datum/admins/proc/toggle_reviving,
	/datum/admins/proc/give_one_up,
	/datum/admins/proc/change_view_range,
	/datum/admins/proc/print_spans,
	/datum/admins/proc/admin_who,
	/datum/admins/proc/admin_who2,
	/datum/admins/proc/test_dailies,
	/datum/admins/proc/make_cool_payload,
	/client/proc/test_horny_furries,
	/client/proc/show_character_directory,
	/datum/admins/proc/test_hornychat_prefs,
	/datum/admins/proc/kinkshame, //CIT CHANGE - Adds kinkshaming
	/datum/admins/proc/grope_shotglass,
	/datum/admins/proc/edit_commanders,
	/proc/commander_me,
	)
GLOBAL_LIST_INIT(admin_verbs_ban, list(/client/proc/unban_panel, /client/proc/DB_ban_panel, /client/proc/stickybanpanel))
GLOBAL_PROTECT(admin_verbs_ban)
GLOBAL_LIST_INIT(admin_verbs_sounds, list(/client/proc/play_local_sound, /client/proc/play_sound, /client/proc/manual_play_web_sound, /client/proc/set_round_end_sound))
GLOBAL_PROTECT(admin_verbs_sounds)
GLOBAL_LIST_INIT(admin_verbs_fun, list(
	/client/proc/cmd_admin_dress,
	/client/proc/cmd_admin_gib_self,
	/client/proc/drop_bomb,
	/client/proc/set_dynex_scale,
	/client/proc/drop_dynex_bomb,
	/client/proc/cinematic,
	/client/proc/one_click_antag,
	/client/proc/cmd_admin_add_freeform_ai_law,
	/client/proc/object_say,
	/client/proc/toggle_random_events,
	/client/proc/set_ooc,
	/client/proc/reset_ooc,
	/client/proc/forceEvent,
	/client/proc/forceHoliday,
	/client/proc/admin_change_sec_level,
	/client/proc/toggle_nuke,
	/client/proc/run_weather,
	/client/proc/mass_zombie_infection,
	/client/proc/mass_zombie_cure,
	/client/proc/polymorph_all,
	/client/proc/show_tip,
	/client/proc/smite,
	/client/proc/admin_away,
	/client/proc/cmd_admin_toggle_fov,
	/client/proc/roll_dices					//CIT CHANGE - Adds dice verb
	))
GLOBAL_PROTECT(admin_verbs_fun)
GLOBAL_LIST_INIT(admin_verbs_spawn, list(/datum/admins/proc/spawn_atom, /datum/admins/proc/podspawn_atom, /datum/admins/proc/spawn_cargo, /datum/admins/proc/spawn_objasmob, /client/proc/respawn_character))
GLOBAL_PROTECT(admin_verbs_spawn)
GLOBAL_LIST_INIT(admin_verbs_server, world.AVerbsServer())
/world/proc/AVerbsServer()
	return list(
	/datum/admins/proc/startnow,
	/datum/admins/proc/restart,
	/datum/admins/proc/end_round,
	/datum/admins/proc/delay,
	/datum/admins/proc/toggleaban,
	/client/proc/everyone_random,
	/datum/admins/proc/toggleAI,
	/datum/admins/proc/toggleMulticam,		//CIT
	/client/proc/cmd_admin_delete,		/*delete an instance/object/mob/etc*/
	/client/proc/cmd_debug_del_all,
	/client/proc/toggle_random_events,
	/client/proc/forcerandomrotate,
	/client/proc/adminchangemap,
	/client/proc/toggle_hub
	)
GLOBAL_PROTECT(admin_verbs_server)
GLOBAL_LIST_INIT(admin_verbs_debug, world.AVerbsDebug())
/world/proc/AVerbsDebug()
	return list(
	/client/proc/restart_controller,
	/client/proc/cmd_admin_list_open_jobs,
	/client/proc/Debug2,
	/client/proc/cmd_debug_make_powernets,
	/client/proc/cmd_debug_mob_lists,
	/client/proc/cmd_admin_delete,
	/client/proc/cmd_debug_del_all,
	/client/proc/restart_controller,
	/client/proc/enable_debug_verbs,
	/client/proc/callproc,
	/client/proc/callproc_datum,
	/client/proc/SDQL2_query,
	/client/proc/test_movable_UI,
	/client/proc/test_snap_UI,
	/client/proc/debugNatureMapGenerator,
	/client/proc/check_bomb_impacts,
	/proc/machine_upgrade,
	/client/proc/populate_world,
	/client/proc/get_dynex_power,		//*debug verbs for dynex explosions.
	/client/proc/get_dynex_range,		//*debug verbs for dynex explosions.
	/client/proc/set_dynex_scale,
	/client/proc/cmd_display_del_log,
	/client/proc/create_outfits,
	/client/proc/modify_goals,
	/client/proc/debug_huds,
	/client/proc/map_template_load,
	/client/proc/map_template_upload,
	/client/proc/map_template_loadtest,
	/client/proc/jump_to_ruin,
	/client/proc/clear_dynamic_transit,
	/client/proc/toggle_medal_disable,
	/client/proc/view_runtimes,
	/client/proc/pump_random_event,
	/client/proc/cmd_display_init_log,
	/client/proc/cmd_display_overlay_log,
	/client/proc/reload_configuration,
	/client/proc/print_gun_debug_information,
	/client/proc/test_dailies_penalty,
	/client/proc/test_dailies_spree,
	// /client/proc/atmos_control,
	// /client/proc/reload_cards,
	// /client/proc/validate_cards,
	// /client/proc/test_cardpack_distribution,
	// /client/proc/print_cards,
	#ifdef TESTING
	// /client/proc/check_missing_sprites,
	// /client/proc/export_dynamic_json,
	/client/proc/run_dynamic_simulations,
	#endif
	/datum/admins/proc/create_or_modify_area,
	/datum/admins/proc/fixcorruption,
#ifdef REFERENCE_TRACKING
	///datum/admins/proc/view_refs,
	///datum/admins/proc/view_del_failures,
#endif
	/client/proc/generate_wikichem_list, //DO NOT PRESS UNLESS YOU WANT SUPERLAG
	)
GLOBAL_PROTECT(admin_verbs_debug)
//GLOBAL_LIST_INIT(admin_verbs_possess, list(/proc/possess, /proc/release))
//GLOBAL_PROTECT(admin_verbs_possess)
GLOBAL_LIST_INIT(admin_verbs_permissions, list(/client/proc/edit_admin_permissions))
GLOBAL_PROTECT(admin_verbs_permissions)
GLOBAL_LIST_INIT(admin_verbs_poll, list(/client/proc/create_poll))

//verbs which can be hidden - needs work
GLOBAL_PROTECT(admin_verbs_poll)
GLOBAL_LIST_INIT(admin_verbs_hideable, list(
	/client/proc/set_ooc,
	/client/proc/reset_ooc,
	/client/proc/deadmin,
	/datum/admins/proc/show_traitor_panel,
	/datum/admins/proc/toggleenter,
	/datum/admins/proc/toggleguests,
	/datum/admins/proc/announce,
	/datum/admins/proc/set_admin_notice,
	/client/proc/admin_ghost,
	/client/proc/toggle_view_range,
	/client/proc/cmd_admin_subtle_message,
	/client/proc/cmd_admin_headset_message,
	/client/proc/cmd_admin_check_contents,
	/datum/admins/proc/access_news_network,
	/client/proc/admin_call_shuttle,
	/client/proc/admin_cancel_shuttle,
	/client/proc/cmd_admin_direct_narrate,
	/client/proc/cmd_admin_world_narrate,
	/client/proc/cmd_admin_local_narrate,
	/client/proc/play_local_sound,
	/client/proc/play_sound,
	/client/proc/set_round_end_sound,
	/client/proc/cmd_admin_dress,
	/client/proc/cmd_admin_gib_self,
	/client/proc/drop_bomb,
	/client/proc/drop_dynex_bomb,
	/client/proc/get_dynex_range,
	/client/proc/get_dynex_power,
	/client/proc/set_dynex_scale,
	/client/proc/cinematic,
	/client/proc/cmd_admin_add_freeform_ai_law,
	/client/proc/cmd_admin_create_centcom_report,
	/client/proc/cmd_change_command_name,
	/client/proc/object_say,
	/client/proc/toggle_random_events,
	/datum/admins/proc/startnow,
	/datum/admins/proc/restart,
	/datum/admins/proc/delay,
	/datum/admins/proc/toggleaban,
	/client/proc/everyone_random,
	/datum/admins/proc/toggleAI,
	/client/proc/restart_controller,
	/client/proc/cmd_admin_list_open_jobs,
	/client/proc/callproc,
	/client/proc/callproc_datum,
	/client/proc/Debug2,
	/client/proc/reload_admins,
	/client/proc/cmd_debug_make_powernets,
	/client/proc/startSinglo,
	/client/proc/cmd_debug_mob_lists,
	/client/proc/cmd_debug_del_all,
	/client/proc/enable_debug_verbs,
//	/proc/possess,
//	/proc/release,
	/client/proc/reload_admins,
	/client/proc/panicbunker,
	/client/proc/admin_change_sec_level,
	/client/proc/toggle_nuke,
	/client/proc/cmd_display_del_log,
	/client/proc/toggle_combo_hud,
	/client/proc/debug_huds,
	/client/proc/cmd_admin_man_up, //CIT CHANGE - adds man up verb
	/client/proc/cmd_admin_man_up_global //CIT CHANGE - ditto
	))
GLOBAL_PROTECT(admin_verbs_hideable)

/client/proc/add_admin_verbs()
	if(holder)
		control_freak = CONTROL_FREAK_SKIN | CONTROL_FREAK_MACROS

		var/rights = holder.rank.rights
		add_verb(src, GLOB.admin_verbs_default)
		if(rights & R_BUILDMODE)
			add_verb(src, /client/proc/togglebuildmodeself)
		if(rights & R_ADMIN)
			add_verb(src, GLOB.admin_verbs_admin)
		if(rights & R_BAN)
			add_verb(src, GLOB.admin_verbs_ban)
		if(rights & R_FUN)
			add_verb(src, GLOB.admin_verbs_fun)
		if(rights & R_SERVER)
			add_verb(src, GLOB.admin_verbs_server)
		if(rights & R_DEBUG)
			add_verb(src, GLOB.admin_verbs_debug)
		if(rights & R_POSSESS)
//			add_verb(src, GLOB.admin_verbs_possess)
//		if(rights & R_PERMISSIONS)
			add_verb(src, GLOB.admin_verbs_permissions)
		if(rights & R_STEALTH)
			add_verb(src, /client/proc/stealth)
		if(rights & R_ADMIN)
			add_verb(src, GLOB.admin_verbs_poll)
		if(rights & R_SOUNDS)
			add_verb(src, GLOB.admin_verbs_sounds)
			if(CONFIG_GET(string/invoke_youtubedl))
				add_verb(src, /client/proc/play_web_sound)
		if(rights & R_SPAWN)
			add_verb(src, GLOB.admin_verbs_spawn)
			add_verb(src, GLOB.staff_verbs)

/client/proc/remove_admin_verbs()
	remove_verb(src, list(
		GLOB.admin_verbs_default,
		/client/proc/togglebuildmodeself,
		GLOB.admin_verbs_admin,
		GLOB.admin_verbs_ban,
		GLOB.admin_verbs_fun,
		GLOB.admin_verbs_server,
		GLOB.admin_verbs_debug,
//		GLOB.admin_verbs_possess,
		GLOB.admin_verbs_permissions,
		/client/proc/stealth,
		GLOB.admin_verbs_poll,
		GLOB.admin_verbs_sounds,
		/client/proc/play_web_sound,
		GLOB.admin_verbs_spawn,
		/*Debug verbs added by "show debug verbs"*/
		GLOB.admin_verbs_debug_mapping,
		/client/proc/disable_debug_verbs,
		/client/proc/readmin
		))

/client/proc/hide_most_verbs()//Allows you to keep some functionality while hiding some verbs
	set name = "Adminverbs - Hide Most"
	set category = "Admin"

	remove_verb(src, GLOB.admin_verbs_hideable)
	remove_verb(src, /client/proc/hide_most_verbs)
	add_verb(src, /client/proc/show_verbs)

	to_chat(src, span_interface("Most of your adminverbs have been hidden."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Hide Most Adminverbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/hide_verbs()
	set name = "Adminverbs - Hide All"
	set category = "Admin"

	remove_admin_verbs()
	add_verb(src, /client/proc/show_verbs)

	to_chat(src, span_interface("Almost all of your adminverbs have been hidden."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Hide All Adminverbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/show_verbs()
	set name = "Adminverbs - Show"
	set category = "Admin"

	remove_verb(src, /client/proc/show_verbs)
	add_admin_verbs()

	to_chat(src, span_interface("All of your adminverbs are now visible."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Show Adminverbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!




/client/proc/admin_ghost()
	set category = "Admin.Game"
	set name = "Aghost"
	if(!holder)
		return FALSE
	if(isobserver(mob))
		//re-enter
		var/mob/dead/observer/ghost = mob
		if(!ghost.mind || !ghost.mind.current) //won't do anything if there is no body
			return FALSE
		if(!ghost.can_reenter_corpse)
			log_admin("[key_name(usr)] re-entered corpse")
			message_admins("[key_name_admin(usr)] re-entered corpse")
		ghost.can_reenter_corpse = 1 //force re-entering even when otherwise not possible
		ghost.reenter_corpse()
		if(isliving(mob))
			var/mob/living/L = mob
			L.living_flags &= ~HIDE_OFFLINE_INDICATOR
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Admin Reenter") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	else if(isnewplayer(mob))
		to_chat(src, "<font color='red'>Error: Aghost: Can't admin-ghost whilst in the lobby. Join or Observe first.</font>")
		return FALSE
	else
		//ghostize
		log_admin("[key_name(usr)] admin ghosted.")
		message_admins("[key_name_admin(usr)] admin ghosted.")
		var/mob/body = mob
		if(isliving(body))
			var/mob/living/livingbody = body
			livingbody.living_flags |= HIDE_OFFLINE_INDICATOR
		body.ghostize(1, voluntary = TRUE)
		if(body && !body.key)
			body.key = "@[key]"	//Haaaaaaaack. But the people have spoken. If it breaks; blame adminbus
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Admin Ghost") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return TRUE

/client/proc/invisimin()
	set name = "Invisimin"
	set category = "Admin.Game"
	set desc = "Toggles ghost-like invisibility (Don't abuse this)"
	if(holder && mob)
		if(mob.invisibility == INVISIBILITY_OBSERVER)
			mob.invisibility = initial(mob.invisibility)
			to_chat(mob, span_boldannounce("Invisimin off. Invisibility reset."))
		else
			mob.invisibility = INVISIBILITY_OBSERVER
			to_chat(mob, "<span class='adminnotice'><b>Invisimin on. You are now as invisible as a ghost.</b></span>")

/client/proc/test_horny_furries()
	set name = "hornyfurry"
	set category = "Debug"
	set desc = "spams you with horny furries"
	SSchat.TestHorny()

/client/proc/toggle_experimental_clickdrag_thing()
	set name = "Toggle Clickdrag Changes"
	set category = "Debug"
	set desc = "Toggles harm-intent clickdrag disabling. Its experimental, click this if people complain clickdragging being broken, and tell Superlagg what broke."
	GLOB.use_experimental_clickdrag_thing = !GLOB.use_experimental_clickdrag_thing
	log_admin("[key_name(usr)] toggled the harm intent clickdrag disabling thing.")
	message_admins("[key_name_admin(usr)] toggled the harm intent clickdrag disabling thing.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggled clickdrag thing")
	if(alert("Tell everyone the experimental clickdrag thing was [GLOB.use_experimental_clickdrag_thing ? "enabled" : "disabled"]?",,"Yes","No") != "Yes")
		return
	to_chat(world, "<B>The experimental harm-intent clickdrag disable thing has been [GLOB.use_experimental_clickdrag_thing ? "enabled" : "disabled"].</B>")

/// No longer does what it did, but fuck it im keeping the name
/client/proc/toggle_radpuddle_disco_vomit_nightmare()
	set name = "Toggle Radturf Screaming"
	set category = "Debug"
	set desc = "Toggles whether mobs will scream and shout a number when irradiated."
	GLOB.rad_puddle_debug = !GLOB.rad_puddle_debug
	log_admin("[key_name(usr)] toggled Radturf screaming.")
	message_admins("[key_name_admin(usr)] toggled Radturf screaming.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggled Radturf screaming")

/client/proc/show_radpuddle_scores()
	set name = "Show Radpuddle Numbers"
	set category = "Debug"
	set desc = "Makes the redpuddle'd tiles show numbers."
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_RADIATION_SHOW)
	message_admins("[key_name_admin(usr)] <B>pinged radiation.</B>")

/client/proc/check_antagonists()
	set name = "Check Antagonists"
	set category = "Admin.Game"
	if(holder)
		holder.check_antagonists()
		log_admin("[key_name(usr)] checked antagonists.")	//for tsar~
		if(!isobserver(usr) && SSticker.HasRoundStarted())
			message_admins("[key_name_admin(usr)] checked antagonists.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Antagonists") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/unban_panel()
	set name = "Unban Panel"
	set category = "Admin"
	if(holder)
		if(CONFIG_GET(flag/ban_legacy_system))
			holder.unbanpanel()
		else
			holder.DB_ban_panel()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Unban Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/game_panel()
	set name = "Game Panel"
	set category = "Admin.Game"
	if(holder)
		holder.Game()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Game Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/secrets()
	set name = "Secrets"
	set category = "Admin.Game"
	if (holder)
		holder.Secrets()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Secrets Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/findStealthKey(txt)
	if(txt)
		for(var/P in GLOB.stealthminID)
			if(GLOB.stealthminID[P] == txt)
				return P
	txt = GLOB.stealthminID[ckey]
	return txt

/client/proc/createStealthKey()
	var/num = (rand(0,1000))
	var/i = 0
	while(i == 0)
		i = 1
		for(var/P in GLOB.stealthminID)
			if(num == GLOB.stealthminID[P])
				num++
				i = 0
	GLOB.stealthminID["[ckey]"] = "@[num2text(num)]"

/client/proc/getvpt()
	set category = "Admin"
	set name = "Check Clients"
	if(holder)
		if(!check_rights(R_ADMIN, 0))
			return
		for (var/ckey in GLOB.warning_ckeys)
			to_chat(usr, "[ckey] connected from a known [GLOB.warning_ckeys[ckey]].")
		if (GLOB.warning_ckeys.len == 0)
			to_chat(usr, "No ckeys have been flagged.")

/client/proc/stealth()
	set category = "Admin"
	set name = "Stealth Mode"
	if(holder)
		if(!check_rights(R_STEALTH, 0))
			return
		if(holder.fakekey)
			holder.fakekey = null
			if(isobserver(mob))
				mob.invisibility = initial(mob.invisibility)
				mob.alpha = initial(mob.alpha)
				mob.name = initial(mob.name)
				mob.mouse_opacity = initial(mob.mouse_opacity)
		else
			var/new_key = ckeyEx(stripped_input(usr, "Enter your desired display name.", "Fake Key", key, 26))
			if(!new_key)
				return
			holder.fakekey = new_key
			createStealthKey()
			if(isobserver(mob))
				mob.invisibility = INVISIBILITY_MAXIMUM //JUST IN CASE
				mob.alpha = 0 //JUUUUST IN CASE
				mob.name = " "
				mob.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		log_admin("[key_name(usr)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]")
		message_admins("[key_name_admin(usr)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Stealth Mode") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/drop_bomb()
	set category = "Admin.Fun"
	set name = "Drop Bomb"
	set desc = "Cause an explosion of varying strength at your location."

	var/list/choices = list("Small Bomb (1, 2, 3, 3)", "Medium Bomb (2, 3, 4, 4)", "Big Bomb (3, 5, 7, 5)", "Maxcap", "Custom Bomb")
	var/choice = input("What size explosion would you like to produce? NOTE: You can do all this rapidly and in an IC manner (using cruise missiles!) with the Config/Launch Supplypod verb. WARNING: These ignore the maxcap") as null|anything in choices
	var/turf/epicenter = mob.loc

	switch(choice)
		if(null)
			return 0
		if("Small Bomb (1, 2, 3, 3)")
			explosion(epicenter, 1, 2, 3, 3, TRUE, TRUE)
		if("Medium Bomb (2, 3, 4, 4)")
			explosion(epicenter, 2, 3, 4, 4, TRUE, TRUE)
		if("Big Bomb (3, 5, 7, 5)")
			explosion(epicenter, 3, 5, 7, 5, TRUE, TRUE)
		if("Maxcap")
			explosion(epicenter, GLOB.MAX_EX_DEVESTATION_RANGE, GLOB.MAX_EX_HEAVY_RANGE, GLOB.MAX_EX_LIGHT_RANGE, GLOB.MAX_EX_FLASH_RANGE)
		if("Custom Bomb")
			var/devastation_range = input("Devastation range (in tiles):") as null|num
			if(devastation_range == null)
				return
			var/heavy_impact_range = input("Heavy impact range (in tiles):") as null|num
			if(heavy_impact_range == null)
				return
			var/light_impact_range = input("Light impact range (in tiles):") as null|num
			if(light_impact_range == null)
				return
			var/flash_range = input("Flash range (in tiles):") as null|num
			if(flash_range == null)
				return
			if(devastation_range > GLOB.MAX_EX_DEVESTATION_RANGE || heavy_impact_range > GLOB.MAX_EX_HEAVY_RANGE || light_impact_range > GLOB.MAX_EX_LIGHT_RANGE || flash_range > GLOB.MAX_EX_FLASH_RANGE)
				if(alert("Bomb is bigger than the maxcap. Continue?",,"Yes","No") != "Yes")
					return
			epicenter = mob.loc //We need to reupdate as they may have moved again
			explosion(epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range, TRUE, TRUE)
	message_admins("[ADMIN_LOOKUPFLW(usr)] creating an admin explosion at [epicenter.loc].")
	log_admin("[key_name(usr)] created an admin explosion at [epicenter.loc].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Drop Bomb") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/drop_dynex_bomb()
	set category = "Admin.Fun"
	set name = "Drop DynEx Bomb"
	set desc = "Cause an explosion of varying strength at your location."

	var/ex_power = input("Explosive Power:") as null|num
	var/turf/epicenter = mob.loc
	if(ex_power && epicenter)
		dyn_explosion(epicenter, ex_power)
		message_admins("[ADMIN_LOOKUPFLW(usr)] creating an admin explosion at [epicenter.loc].")
		log_admin("[key_name(usr)] created an admin explosion at [epicenter.loc].")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Drop Dynamic Bomb") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/get_dynex_range()
	set category = "Debug"
	set name = "Get DynEx Range"
	set desc = "Get the estimated range of a bomb, using explosive power."

	var/ex_power = input("Explosive Power:") as null|num
	if (isnull(ex_power))
		return
	var/range = round((2 * ex_power)**GLOB.DYN_EX_SCALE)
	to_chat(usr, "Estimated Explosive Range: (Devastation: [round(range*0.25)], Heavy: [round(range*0.5)], Light: [round(range)])")

/client/proc/get_dynex_power()
	set category = "Debug"
	set name = "Get DynEx Power"
	set desc = "Get the estimated required power of a bomb, to reach a specific range."

	var/ex_range = input("Light Explosion Range:") as null|num
	if (isnull(ex_range))
		return
	var/power = (0.5 * ex_range)**(1/GLOB.DYN_EX_SCALE)
	to_chat(usr, "Estimated Explosive Power: [power]")

/client/proc/set_dynex_scale()
	set category = "Debug"
	set name = "Set DynEx Scale"
	set desc = "Set the scale multiplier of dynex explosions. The default is 0.5."

	var/ex_scale = input("New DynEx Scale:") as null|num
	if(!ex_scale)
		return
	GLOB.DYN_EX_SCALE = ex_scale
	log_admin("[key_name(usr)] has modified Dynamic Explosion Scale: [ex_scale]")
	message_admins("[key_name_admin(usr)] has  modified Dynamic Explosion Scale: [ex_scale]")

/client/proc/toggle_seeing_ghosts()
	set category = "Admin.Game"
	set name = "Toggle Seeing Ghosts"
	set desc = "Toggle whether or not you can see guh-guh-guh-ghosts."

	if(!holder)
		return
	var/was_seeing = !isnull(holder.see_invis_override)
	if(was_seeing) // unsee em
		holder.see_invis_override = null
		if(mob)
			mob.update_sight()
		log_admin("[key_name(usr)] can no longer see ghosts.")
		message_admins("[key_name_admin(usr)] can no longer see ghosts.")
	else
		holder.see_invis_override = SEE_INVISIBLE_OBSERVER
		if(mob)
			mob.update_sight()
		log_admin("[key_name(usr)] can now see ghosts!")
		message_admins("[key_name_admin(usr)] can now see ghosts!")

/client/proc/ignore_as_a_ghost()
	set category = "OOC"
	set name = "Block user's emotes"
	set desc = "Blocks hearing emotes, subtles, and subtlers from a specific ckey."

	var/blockem = input(usr, "Who do you want to never hear from while as a ghost?", "Okay thats enough deadvision for one day") as null|anything in GLOB.directory
	if(!blockem)
		to_chat(usr, "Never mind!")
		return
	var/client/C = GLOB.directory[blockem]
	var/mob/dork = C.mob
	var/datum/preferences/P = extract_prefs(usr) // wow even I admit this is cursed
	var/blocked = (blockem in P.aghost_squelches)
	var/usure = alert(usr, "This'll [blocked?"un":""]block [dork]'s emotes while you're a ghost, is this the right person?", "Is it enough deadvision for one day?", "YES", "NO")
	if(usure != "YES")
		to_chat(usr, "Never mind!")
		return
	if(blocked)
		P.aghost_squelches -= blockem
		to_chat(usr, "You can now hear [dork]'s emotes while a ghost.")
	else
		P.aghost_squelches |= blockem
		to_chat(usr, "You will no longer hear [dork]'s emotes while a ghost.")
	P.save_preferences()
	to_chat(usr, "Preferences saved.")

/client/proc/toggle_admin_wire_tap()
	set category = "OOC"
	set name = "Ignore Others' DMs"
	set desc = "Blocks seeing DMs from players to players who arent you."

	TOGGLE_VAR(prefs.admin_wire_tap)
	prefs.save_preferences()
	to_chat(src, span_abductor("You will [prefs.admin_wire_tap ? "now" : "no longer"] eavesdrop on other players' DMs."))
	to_chat(src, "Preferences saved.")

/client/proc/edit_quest_bank()
	set category = "Admin.Game"
	set name = "Edit Questbank"
	set desc = "Modify someone's questbank balance!"

	if(!holder || !check_rights(R_ADMIN, 0))
		to_chat(usr, span_notice("You don't have the rights to do that!"))
		log_admin("[key_name(usr)] tried to edit a questbank without the rights.")
		return
	
	GLOB.qbank_editor.Open(usr)
	to_chat(usr, span_interface("Questbank editor opened. If it hasn't, tell Superlagg."))


/client/proc/test_dailies_spree()
	set category = "Debug"
	set name = "Test Dailies Spree"

	if(!SSeconomy.debug_daily_spawn_in_stuff)
		to_chat(usr, "You need to enable the debug flag SSeconomy.debug_daily_spawn_in_stuff to use this verb. Mainly cus it will utterly wreck your saved data if used.")
		return

	var/datum/preferences/P = extract_prefs(usr) // me!
	P.days_spawned_in = list()
	P.days_spawned_in += REALTIME2QDAYS(-1)
	P.days_spawned_in += REALTIME2QDAYS(-2)
	P.days_spawned_in += REALTIME2QDAYS(-3)
	P.days_spawned_in += REALTIME2QDAYS(-10)
	P.days_spawned_in += REALTIME2QDAYS(-11)
	P.days_spawned_in += REALTIME2QDAYS(-12)
	P.saved_unclaimed_points = COINS_TO_CREDITS(10000)
	P.save_character()
	to_chat(usr, "You have now spawned in on the last 3 days, starting yesterday. Should return 3 bonuses.")

/client/proc/test_dailies_penalty()
	set category = "Debug"
	set name = "Test Dailies penalty"

	if(!SSeconomy.debug_daily_spawn_in_stuff)
		to_chat(usr, "You need to enable the debug flag SSeconomy.debug_daily_spawn_in_stuff to use this verb. Mainly cus it will utterly wreck your saved data if used.")
		return

	var/datum/preferences/P = extract_prefs(usr) // me!
	P.days_spawned_in = list()
	// P.days_spawned_in += REALTIME2QDAYS(-1)
	// P.days_spawned_in += REALTIME2QDAYS(-2)
	// P.days_spawned_in += REALTIME2QDAYS(-3)
	P.days_spawned_in += REALTIME2QDAYS(-4)
	P.days_spawned_in += REALTIME2QDAYS(-5)
	P.days_spawned_in += REALTIME2QDAYS(-10)
	P.days_spawned_in += REALTIME2QDAYS(-11)
	P.days_spawned_in += REALTIME2QDAYS(-30)
	P.saved_unclaimed_points = COINS_TO_CREDITS(10000)
	P.save_character()
	to_chat(usr, "You have now spawned in on the last 4 days ago. Should return 4 penalties.")

/client/proc/give_spell(mob/T in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Give Spell"
	set desc = "Gives a spell to a mob."

	var/list/spell_list = list()
	var/type_length = length_char("/obj/effect/proc_holder/spell") + 2
	for(var/A in GLOB.spells)
		spell_list[copytext_char("[A]", type_length)] = A
	var/obj/effect/proc_holder/spell/S = input("Choose the spell to give to that guy", "ABRAKADABRA") as null|anything in spell_list
	if(!S)
		return

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Give Spell") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(usr)] gave [key_name(T)] the spell [S].")
	message_admins(span_adminnotice("[key_name_admin(usr)] gave [key_name(T)] the spell [S]."))

	S = spell_list[S]
	if(T.mind)
		T.mind.AddSpell(new S)
	else
		T.AddSpell(new S)
		message_admins(span_danger("Spells given to mindless mobs will not be transferred in mindswap or cloning!"))

/client/proc/remove_spell(mob/T in GLOB.mob_list)
	set category = "Admin.Fun"
	set name = "Remove Spell"
	set desc = "Remove a spell from the selected mob."

	if(T && T.mind)
		var/obj/effect/proc_holder/spell/S = input("Choose the spell to remove", "NO ABRAKADABRA") as null|anything in T.mind.spell_list
		if(S)
			T.mind.RemoveSpell(S)
			log_admin("[key_name(usr)] removed the spell [S] from [key_name(T)].")
			message_admins(span_adminnotice("[key_name_admin(usr)] removed the spell [S] from [key_name(T)]."))
			SSblackbox.record_feedback("tally", "admin_verb", 1, "Remove Spell") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/give_disease(mob/living/T in GLOB.mob_living_list)
	set category = "Admin.Fun"
	set name = "Give Disease"
	set desc = "Gives a Disease to a mob."
	if(!istype(T))
		to_chat(src, span_notice("You can only give a disease to a mob of type /mob/living."))
		return
	var/datum/disease/D = input("Choose the disease to give to that guy", "ACHOO") as null|anything in SSdisease.diseases
	if(!D)
		return
	T.ForceContractDisease(new D, FALSE, TRUE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Give Disease") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(usr)] gave [key_name(T)] the disease [D].")
	message_admins(span_adminnotice("[key_name_admin(usr)] gave [key_name(T)] the disease [D]."))

/client/proc/object_say(obj/O in world)
	set category = "Admin.Events"
	set name = "OSay"
	set desc = "Makes an object say something."
	var/message = input(usr, "What do you want the message to be?", "Make Sound") as text | null
	if(!message)
		return
	O.say(message)
	log_admin("[key_name(usr)] made [O] at [AREACOORD(O)] say \"[message]\"")
	message_admins(span_adminnotice("[key_name_admin(usr)] made [O] at [AREACOORD(O)]. say \"[message]\""))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Object Say") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
/client/proc/togglebuildmodeself()
	set name = "Toggle Build Mode Self"
	set category = "Admin.Events"
	if (!(holder.rank.rights & R_BUILDMODE))
		return
	if(src.mob)
		togglebuildmode(src.mob)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Build Mode") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/check_ai_laws()
	set name = "Check AI Laws"
	set category = "Admin.Game"
	if(holder)
		src.holder.output_ai_laws()

/client/proc/deadmin()
	set name = "Deadmin"
	set category = "Admin"
	set desc = "Shed your admin powers."

	if(!holder)
		return

	if(has_antag_hud())
		toggle_combo_hud()

	holder.deactivate()

	to_chat(src, span_interface("You are now a normal player."))
	log_admin("[src] deadmined themself.")
	message_admins("[src] deadmined themself.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Deadmin")

/client/proc/readmin()
	set name = "Readmin"
	set category = "Admin"
	set desc = "Regain your admin powers."

	var/datum/admins/A = GLOB.deadmins[ckey]

	if(!A)
		A = GLOB.admin_datums[ckey]
		if (!A)
			var/msg = " is trying to readmin but they have no deadmin entry"
			message_admins("[key_name_admin(src)][msg]")
			log_admin_private("[key_name(src)][msg]")
			return

	A.associate(src)

	if (!holder)
		return //This can happen if an admin attempts to vv themself into somebody elses's deadmin datum by getting ref via brute force

	to_chat(src, span_interface("You are now an admin."))
	message_admins("[src] re-adminned themselves.")
	log_admin("[src] re-adminned themselves.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Readmin")

/client/proc/populate_world(amount = 50 as num)
	set name = "Populate World"
	set category = "Debug"
	set desc = "(\"Amount of mobs to create\") Populate the world with test mobs."

	if (amount > 0)
		var/area/area
		var/list/candidates
		var/turf/open/floor/tile
		var/j,k

		for (var/i = 1 to amount)
			j = 100

			do
				area = pick(GLOB.the_station_areas)

				if (area)

					candidates = get_area_turfs(area)

					if (candidates.len)
						k = 100

						do
							tile = pick(candidates)
						while ((!tile || !istype(tile)) && --k > 0)

						if (tile)
							var/mob/living/carbon/human/hooman = new(tile)
							hooman.equipOutfit(pick(subtypesof(/datum/outfit)))
							testing("Spawned test mob at [COORD(tile)]")
			while (!area && --j > 0)

/client/proc/toggle_AI_interact()
	set name = "Toggle Admin AI Interact"
	set category = "Admin.Game"
	set desc = "Allows you to interact with most machines as an AI would as a ghost"

	AI_Interact = !AI_Interact
	if(mob && IsAdminGhost(mob))
		mob.silicon_privileges = AI_Interact ? ALL : NONE

	log_admin("[key_name(usr)] has [AI_Interact ? "activated" : "deactivated"] Admin AI Interact")
	message_admins("[key_name_admin(usr)] has [AI_Interact ? "activated" : "deactivated"] their AI interaction")

/client/proc/debugstatpanel()
	set name = "Debug Stat Panel"
	set category = "Debug"

	src << output("", "statbrowser:create_debug")


/datum/admins/proc/toggle_sleep(mob/living/perp in GLOB.mob_living_list)
	set category = null
	set name = "Toggle Sleeping"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use toggle_sleep() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use toggle_sleep() without admin perms.")
		return

	if(perp.IsAdminSleeping())
		perp.ToggleAdminSleep()
	else if(tgui_alert(usr, "Are you sure you want to sleep [key_name(perp)]?", "Toggle Sleeping", list("Yes", "No")) != "Yes")
		return
	else if(QDELETED(perp))
		to_chat(usr, span_warning("Target is no longer valid."))
		return
	else
		perp.ToggleAdminSleep()

	log_admin("[key_name(usr)] has [perp.IsAdminSleeping() ? "enabled" : "disabled"] sleeping on [key_name(perp)].")
	message_admins("[ADMIN_TPMONTY(usr)] has [perp.IsAdminSleeping() ? "enabled" : "disabled"] sleeping on [ADMIN_TPMONTY(perp)].")


/datum/admins/proc/toggle_sleep_area()
	set category = "Admin.Game"
	set name = "Toggle Sleeping Area"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use toggle_sleep_area() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use toggle_sleep_area() without admin perms.")
		return

	switch(tgui_alert(usr, "Sleep or unsleep everyone?", "Toggle Sleeping Area", list("Sleep", "Unsleep", "Cancel")))
		if("Sleep")
			for(var/mob/living/perp in view())
				perp.SetAdminSleep()
			log_admin("[key_name(usr)] has slept everyone in view.")
			message_admins("[ADMIN_TPMONTY(usr)] has slept everyone in view.")
		if("Unsleep")
			for(var/mob/living/perp in view())
				perp.SetAdminSleep(remove = TRUE)
			log_admin("[key_name(usr)] has unslept everyone in view.")
			message_admins("[ADMIN_TPMONTY(usr)] has unslept everyone in view.")

/datum/admins/proc/toggle_reviving()
	set category = "Admin.Game"
	set name = "Toggle Self Reviving"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with toggle_reviving() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with toggle_reviving() without admin perms.")
		return

	var/current_setting
	if(SSsecondwind.master_toggle)
		current_setting = "ENABLED!"
	else
		current_setting = "DISABLED!"

	var/choice = tgui_alert(
		usr,
		"Second Wind is currently [current_setting]. What do you want to set it to?",
		"Toggle Second Wind",
		list(
			"ENABLED",
			"DISABLED",
			"Nevermind",
		),
	)
	switch(choice)
		if("ENABLED")
			SSsecondwind.master_toggle = TRUE
			log_admin("[key_name(usr)] has set Second Wind to ENABLED.")
			message_admins("[ADMIN_TPMONTY(usr)] has set Second Wind to ENABLED.")
		if("DISABLED")
			SSsecondwind.master_toggle = FALSE
			log_admin("[key_name(usr)] has set Second Wind to DISABLED.")
			message_admins("[ADMIN_TPMONTY(usr)] has set Second Wind to DISABLED.")
		else
			to_chat(usr, "Nevermind then.")

/// Never gonna give one up, never gonna give one down
/datum/admins/proc/give_one_up()
	set category = "Admin.Game"
	set name = "Give 1UP"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with give_one_up() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with give_one_up() without admin perms.")
		return

	var/list/ppl = list()
	var/list/pplnames = list()
	for(var/kye in SSsecondwind.second_winders)
		var/datum/second_wind/SW = LAZYACCESS(SSsecondwind.second_winders, kye)
		if(!SW)
			continue
		var/mob/living/perp = SW.get_revivable_body()
		if(!perp)
			continue
		ppl[perp.real_name] = kye
		pplnames += perp.real_name
	
	var/whotorez = input(usr, "Who do you want to give a 1UP to?", "Give 1UP") as null|anything in pplnames
	if(!whotorez)
		to_chat(usr, "Nevermind then.")
		return
	var/keytorez = LAZYACCESS(ppl, whotorez)
	SSsecondwind.grant_one_up(keytorez)
	log_admin("[key_name(usr)] has granted a 1UP to [keytorez].")
	message_admins("[ADMIN_TPMONTY(usr)] has granted a 1UP to [keytorez].")

/// Never gonna give one up, never gonna give one down
/datum/admins/proc/grope_shotglass()
	set category = "Admin.Game"
	set name = "Let people grope wierd things"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with grope_shotglass() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with grope_shotglass() without admin perms.")
		return

	var/list/ppl = list()
	for(var/kye in GLOB.directory)
		var/client/C = GLOB.directory[kye]
		if(!ismob(C.mob))
			continue
		ppl[C.mob.name] = kye
	
	var/whotorez = input(usr, "Who do you want to let grope wierd things?", "Give a hand") as null|anything in ppl
	if(!whotorez)
		to_chat(usr, "Nevermind then.")
		return
	if(whotorez in GLOB.shotglass_gropers)
		GLOB.shotglass_gropers -= ppl[whotorez]
		to_chat(usr, "[whotorez] can no longer grope shotglasses.")
		var/mob/whomst = ckey2mob(ppl[whotorez])
		if(whomst)
			to_chat(whomst, "Oh you can't grope shotglasses anymore. dang")
		log_admin("[key_name(usr)] stopped letting [whotorez] [ppl[whotorez]] grope just about anything.")
	else
		GLOB.shotglass_gropers -= ppl[whotorez]
		to_chat(usr, "[whotorez] can now grope shotglasses. yeah.")
		var/mob/whomst = ckey2mob(ppl[whotorez])
		if(whomst)
			to_chat(whomst, "Hey you can grope shotglasses now.")
		log_admin("[key_name(usr)] let [whotorez] [ppl[whotorez]] grope just about anything.")

/datum/admins/proc/change_view_range()
	set category = "Admin.Game"
	set name = "Change Global View Range"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with toggle_reviving() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with toggle_reviving() without admin perms.")
		return

	var/current_setting = GLOB.view_override || getScreenSize()
	var/msg = "Hi! This will set ~everyone's~ view range to whatever you set. Enter a value in this format: WxH . Leave blank to reset it to default. Yes, everyone will know it was you."
	var/result = input(usr, msg, "Change Global View Range", current_setting) as null|text
	if(!result)
		if(!GLOB.view_override)
			to_chat(usr, span_notice("Okay, leaving the view ranges alone."))
			return
		var/choice_1 = "Yes, clear the view override."
		var/choice_2 = "No, don't clear the view override."
		var/second_offense = alert(usr, "Reset everyone's view range to default (7x7ish)?", "Reset View Range", choice_1, choice_2)
		if(second_offense == choice_1)
			GLOB.view_override = null
			for(var/client/C in GLOB.clients)
				C.view_size.setDefault(GLOB.view_override || getScreenSize(C.prefs.widescreenpref))
			log_admin("[key_name(usr)] has reset the view range to default.")
			message_admins("[ADMIN_TPMONTY(usr)] has reset the view range to default.")
		else
			to_chat(usr, "Okay, leaving the view ranges alone.")
			return
	var/list/precheck = splittext(result, "x")
	var/val1 = text2num(precheck[1])
	var/val2 = text2num(precheck[2])
	if(!isnum(val1) || !isnum(val2))
		to_chat(usr, span_boldannounce("That's not a valid screen dimension! Enter something like 7x7 or 18x20 or 50x100. dont to the last two, it'll probably crash everyone and make the round unplayable."))
		return
	var/choice_1 = "Yes, set the view override to [result]."
	var/choice_2 = "No, don't set the view override."
	var/second_result = alert(usr, "Set everyone's view range to [result]?", "Set View Range", choice_1, choice_2)
	if(second_result == choice_1)
		GLOB.view_override = result
		for(var/client/C in GLOB.clients)
			C.view_size.setDefault(GLOB.view_override || getScreenSize(C.prefs.widescreenpref))
		log_admin("[key_name(usr)] has set the view range to [result].")
		message_admins("[ADMIN_TPMONTY(usr)] has set the view range to [result].")
	else
		to_chat(usr, "Okay, leaving the view ranges alone.")

/datum/admins/proc/edit_who()
	set category = "Admin.Game"
	set name = "Edit Who"
	set desc = "Opens the Who panel to edit peoples' custom stuff."

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with edit_who() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with edit_who() without admin perms.")
		return
	SSwho.AdminPanel() // it'll grab the usr itself, in a cursed curse

/datum/admins/proc/admin_who()
	set category = "Admin"
	set name = "AdminWho"
	set desc = "Opens the who tab, but moreso."

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with edit_who() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with edit_who() without admin perms.")
		return
	SSwho.WhoPlus(usr.client) // it'll grab the usr itself, in a cursed curse

/datum/admins/proc/test_dailies()
	set category = "Debug"
	set name = "Zaptest Dailies"
	set desc = "tells everyone how poorly the daily login bonus works."

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with test_dailies() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with test_dailies() without admin perms.")
		return
	SSeconomy.test_daily_calcs()

/// yay, copied so epople will ever see it!!
/datum/admins/proc/admin_who2()
	set category = "OOC"
	set name = "WhoPlus"
	set desc = "Opens the who tab, but moreso."

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with edit_who() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with edit_who() without admin perms.")
		return
	SSwho.WhoPlus(usr.client) // it'll grab the usr itself, in a cursed curse

/// yay, copied so epople will ever see it!!
/datum/admins/proc/edit_commanders()
	set category = "Admin.Game"
	set name = "Edit Commanders"
	set desc = "Edit who gets to be a commander!"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with edit_commanders() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with edit_commanders() without admin perms.")
		return
	SSrts.EditCommanders(usr)

/datum/admins/proc/print_spans()
	set category = "Debug"
	set name = "Print Spans"
	set desc = "Floods your chat with bullshit."

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with print_spans() without admin perms. even though it just floods their chat with bullshit")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with print_spans() without admin perms.")
		return

	to_chat(usr,
	"\
	[span_abductor("span_abductor")]\n\
	[span_admin("span_admin")]\n\
	[span_adminhelp("span_adminhelp")]\n\
	[span_adminnotice("span_adminnotice")]\n\
	[span_adminobserverooc("span_adminobserverooc")]\n\
	[span_adminooc("span_adminooc")]\n\
	[span_adminsay("span_adminsay")]\n\
	[span_aiprivradio("span_aiprivradio")]\n\
	[span_alert("span_alert")]\n\
	[span_alertalien("span_alertalien")]\n\
	[span_alertsyndie("span_alertsyndie")]\n\
	[span_alertwarning("span_alertwarning")]\n\
	[span_alien("span_alien")]\n\
	[span_alloy("span_alloy")]\n\
	[span_announce("span_announce")]\n\
	[span_average("span_average")]\n\
	[span_bad("span_bad")]\n\
	[span_big("span_big")]\n\
	[span_big_brass("span_big_brass")]\n\
	[span_bigicon("span_bigicon")]\n\
	[span_binarysay("span_binarysay")]\n\
	[span_blinker("span_blinker")]\n\
	[span_blue("span_blue")]\n\
	[span_blueteamradio("span_blueteamradio")]\n\
	[span_bold("span_bold")]\n\
	[span_boldannounce("span_boldannounce")]\n\
	[span_bolddanger("span_bolddanger")]\n\
	[span_boldnotice("span_boldnotice")]\n\
	[span_boldwarning("span_boldwarning")]\n\
	[span_brass("span_brass")]\n\
	[span_caution("span_caution")]\n\
	[span_centcomradio("span_centcomradio")]\n\
	[span_changeling("span_changeling")]\n\
	[span_clown("span_clown")]\n\
	[span_colossus("span_colossus")]\n\
	[span_command_headset("span_command_headset")]\n\
	[span_comradio("span_comradio")]\n\
	[span_cult("span_cult")]\n\
	[span_cultbold("span_cultbold")]\n\
	[span_cultboldtalic("span_cultboldtalic")]\n\
	[span_cultitalic("span_cultitalic")]\n\
	[span_cultlarge("span_cultlarge")]\n\
	[span_danger("span_danger")]\n\
	[span_deadsay("span_deadsay")]\n\
	[span_deconversion_message("span_deconversion_message")]\n\
	[span_disarm("span_disarm")]\n\
	[span_drone("span_drone")]\n\
	[span_engradio("span_engradio")]\n\
	[span_extremelybig("span_extremelybig")]\n\
	[span_ghostalert("span_ghostalert")]\n\
	[span_good("span_good")]\n\
	[span_green("span_green")]\n\
	[span_greenannounce("span_greenannounce")]\n\
	[span_greenteamradio("span_greenteamradio")]\n\
	[span_greentext("span_greentext")]\n\
	[span_header("span_header")]\n\
	[span_hear("span_hear")]\n\
	[span_heavy_brass("span_heavy_brass")]\n\
	[span_hidden("span_hidden")]\n\
	[span_hierophant("span_hierophant")]\n\
	[span_hierophant_warning("span_hierophant_warning")]\n\
	[span_highlight("span_highlight")]\n\
	[span_his_grace("span_his_grace")]\n\
	[span_holoparasite("span_holoparasite")]\n\
	[span_hypnophrase("span_hypnophrase")]\n\
	[span_icon("span_icon")]\n\
	[span_inathneq("span_inathneq")]\n\
	[span_inathneq_large("span_inathneq_large")]\n\
	[span_inathneq_small("span_inathneq_small")]\n\
	[span_info("span_info")]\n\
	[span_infoplain("span_infoplain")]\n\
	[span_interface("span_interface")]\n\
	[span_italic("span_italic")]\n\
	[span_large_brass("span_large_brass")]\n\
	[span_linkOff("span_linkOff")]\n\
	[span_linkOn("span_linkOn")]\n\
	[span_looc("span_looc")]\n\
	[span_love("span_love")]\n\
	[span_medal("span_medal")]\n\
	[span_medradio("span_medradio")]\n\
	[span_memo("span_memo")]\n\
	[span_memoedit("span_memoedit")]\n\
	[span_mind_control("span_mind_control")]\n\
	[span_minorannounce("span_minorannounce")]\n\
	[span_monkey("span_monkey")]\n\
	[span_monkeyhive("span_monkeyhive")]\n\
	[span_monkeylead("span_monkeylead")]\n\
	[span_name("span_name")]\n\
	[span_narsie("span_narsie")]\n\
	[span_narsiesmall("span_narsiesmall")]\n\
	[span_neovgre("span_neovgre")]\n\
	[span_neovgre_large("span_neovgre_large")]\n\
	[span_neovgre_small("span_neovgre_small")]\n\
	[span_nezbere("span_nezbere")]\n\
	[span_nicegreen("span_nicegreen")]\n\
	[span_notice("span_notice")]\n\
	[span_noticealien("span_noticealien")]\n\
	[span_nzcrentr("span_nzcrentr")]\n\
	[span_nzcrentr_large("span_nzcrentr_large")]\n\
	[span_nzcrentr_small("span_nzcrentr_small")]\n\
	[span_ooc("span_ooc")]\n\
	[span_papyrus("span_papyrus")]\n\
	[span_phobia("span_phobia")]\n\
	[span_prefix("span_prefix")]\n\
	[span_purple("span_purple")]\n\
	[span_radio("span_radio")]\n\
	[span_reallybig("span_reallybig")]\n\
	[span_red("span_red")]\n\
	[span_redteamradio("span_redteamradio")]\n\
	[span_redtext("span_redtext")]\n\
	[span_resonate("span_resonate")]\n\
	[span_revenbignotice("span_revenbignotice")]\n\
	[span_revenboldnotice("span_revenboldnotice")]\n\
	[span_revendanger("span_revendanger")]\n\
	[span_revenminor("span_revenminor")]\n\
	[span_revennotice("span_revennotice")]\n\
	[span_revenwarning("span_revenwarning")]\n\
	[span_robot("span_robot")]\n\
	[span_rose("span_rose")]\n\
	[span_sans("span_sans")]\n\
	[span_sciradio("span_sciradio")]\n\
	[span_secradio("span_secradio")]\n\
	[span_servradio("span_servradio")]\n\
	[span_sevtug("span_sevtug")]\n\
	[span_sevtug_small("span_sevtug_small")]\n\
	[span_singing("span_singing")]\n\
	[span_slime("span_slime")]\n\
	[span_small("span_small")]\n\
	[span_smalldanger("span_smalldanger")]\n\
	[span_smallnotice("span_smallnotice")]\n\
	[span_smallnoticeital("span_smallnoticeital")]\n\
	[span_spider("span_spider")]\n\
	[span_subtle("span_subtle")]\n\
	[span_subtler("span_subtler")]\n\
	[span_suppradio("span_suppradio")]\n\
	[span_swarmer("span_swarmer")]\n\
	[span_syndradio("span_syndradio")]\n\
	[span_tape_recorder("span_tape_recorder")]\n\
	[span_tinynotice("span_tinynotice")]\n\
	[span_tinynoticeital("span_tinynoticeital")]\n\
	[span_umbra("span_umbra")]\n\
	[span_unconscious("span_unconscious")]\n\
	[span_userdanger("span_userdanger")]\n\
	[span_userlove("span_userlove")]\n\
	[span_warning("span_warning")]\n\
	[span_yell("span_yell")]\n\
	[span_yellowteamradio("span_yellowteamradio")]\n\
	")

/datum/admins/proc/make_cool_payload()
	set category = "Debug"
	set name = "CoolText Pro"
	set desc = "Opens a big textbox that you can type things in to send to yourself. Used for testing fancy chat message stuff."

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use mess with make_cool_payload() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use mess with make_cool_payload() without admin perms.")
		return
	GLOB.cooltext_pro.Open(usr)

/datum/admins/proc/test_hornychat_prefs()
	set category = "Debug"
	set name = "Access Hornychat"
	set desc = "Opens the Hornychat preferences panel."

	SSchat.HornyPreferences(usr)
	to_chat(usr, "Hornychat preferences opened! Hopefully!")

GLOBAL_DATUM_INIT(cooltext_pro, /datum/shrimpletext, new)

/datum/shrimpletext
	var/list/messages_by_ckey = list()

/datum/shrimpletext/proc/Open(someone)
	var/client/who = extract_mob(someone)
	var/stored_text = messages_by_ckey[who.ckey]
	var/text2send = input(
		who,
		"Enter the text you want to send to yourself. This is a big textbox, so you can type a lot of stuff.",
		"CoolText Pro",
		stored_text
	) as null|message
	if(text2send)
		messages_by_ckey[who.ckey] = text2send
		text2send = replacetext(text2send, "\n", "")
		text2send = replacetext(text2send, "	", "")
		to_chat(who, text2send)

GLOBAL_DATUM_INIT(vap, /datum/visualchat_admin_panel, new)

/datum/admins/proc/kinkshame()
	set category = "Admin"
	set name = "VisualChat Admin Panel"
	set desc = "Opens the VisualChat admin panel."

	GLOB.vap.Open(usr)
	to_chat(usr, "VisualChat admin opened! Hopefully!")

/datum/visualchat_admin_panel
	var/list/cached_monkeys = list()

/datum/visualchat_admin_panel/proc/Open(someone)
	if(!check_rights(R_ADMIN))
		var/mob/user = usr
		message_admins("[ADMIN_TPMONTY(user)] tried to use mess with visualchat_admin_panel without admin perms, kill them.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(user)] tried to use mess with visualchat_admin_panel without admin perms.")
		return
	var/mob/whosit = extract_mob(someone)
	if(!whosit)
		return
	ui_interact(whosit)

/datum/visualchat_admin_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(user)] tried to use mess with visualchat_admin_panel without admin perms, kill them.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(user)] tried to use mess with visualchat_admin_panel without admin perms.")
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HornyAdmin")
		ui.open()
		ui.set_autoupdate(FALSE)

/datum/visualchat_admin_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/visualchat_admin_panel/ui_static_data(mob/user)
	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(user)] tried to use mess with visualchat_admin_panel without admin perms, kill them.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(user)] tried to use mess with visualchat_admin_panel without admin perms.")
		return
	var/list/data = list() // and boy a list it will be!
	data["UserCKEY"] = user.ckey
	get_all_monkeys()
	data["FullMonkey"] = cached_monkeys
	return data

// You're gonna go ape over this one
/datum/visualchat_admin_panel/proc/get_all_monkeys()
	var/list/bananas = list()
	var/mob/user = usr
	if(!user)
		return // no user, no data, no problem!
	/// time to go through every player on the server and grab all their data!
	for(var/client/C in GLOB.clients)
		var/datum/preferences/P = C.prefs
		var/list/perp_images = P.ProfilePics.Copy()
		var/list/perp_settings = P.mommychat_settings.Copy()
		var/their_ckey = C.ckey
		var/their_name = C.prefs.real_name
		var/list/perp_previewmsgs = list()
		for(var/list/modus in perp_images)
			var/msgmode = modus["Mode"]
			var/message2say = "Hi."
			var/message2say2
			switch(msgmode)
				if(MODE_SAY)
					message2say = "This is Say mode. This is what it looks like if this person is talking by default. \
					Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus nec nunc tincidunt \
					cthonique. Donec nec nunc nec nunc nec nunc nec nunc nec nunc nec nunc nec nunc nec nunc nec \
					fhtagn. And now I'm done. Hi."
				if(MODE_WHISPER)
					message2say = "#This is Whisper mode. This is what it looks like if this person is whispering by default. \
					The quick brown fox gets fukced by the lazy dog. The quick brown fox gets fukced by the lazy dog. \
					The quick brown fox gets fukced by the lazy dog. The quick brown fox gets fukced by the lazy dog. \
					The quick brown fox gets fukced by the lazy dog. The quick brown fox gets fukced by the lazy dog. \
					And now I'm done. Hi."
				if(MODE_SING)
					message2say = "%This is Sing mode. This is what it looks like if this person is singing by default. \
					Ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn. And now I'm done. Hi."
				if(MODE_ASK)
					message2say = "Hello? Is this thing on? So tell me, how many licks does it take to get to the center of a vixen? \
					Can you help me find out? Wanna go on a date and help em find out how many licks it takes to get to the center of a vixen? \
					What if it's more than one? What if it's less than one? What if it's exactly one? And now I'm done? Hi?"
				if(MODE_EXCLAIM)
					message2say = "Hi!"
				if(MODE_YELL)
					message2say = "$YELLING!!"
				if(MODE_PROFILE_PIC)
					continue // hi
				else
					message2say = "Hi, this is a test of a custom message mode that has been set by you to be used to display \
					a custom message mode. The mode is set to [replacetext(msgmode, ":","")]. If the previous sentence was \
					cut off, please make a note of it. Cool huh? And now I'm done. Hi. [msgmode]"
					message2say2 = "[msgmode]"
			var/msgmess = SSchat.PreviewHornyFurryDatingSimMessage(C.mob, null, message2say, FALSE)
			if(message2say2)
				msgmess += "<p>[SSchat.PreviewHornyFurryDatingSimMessage(C.mob, null, message2say2, FALSE)]</p>"
			perp_previewmsgs += list(list("Mode" = msgmode, "Message" = msgmess))
		var/list/monkey = list(
			"PerpCKEY" = their_ckey,
			"PerpName" = their_name,
			"PerpImages" = perp_images,
			"PerpSettings" = perp_settings,
			"PerpPreviewMessages" = perp_previewmsgs
		)
		bananas += list(monkey)
	cached_monkeys = bananas

/datum/visualchat_admin_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/user = params["UserCkey"]
	if(!user)
		return
	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(user)] tried to use mess with visualchat_admin_panel without admin perms, kill them.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(user)] tried to use mess with visualchat_admin_panel without admin perms.")
		return
	if(action == "Refresh")
		update_static_data(user, ui)
		return
	var/ckey = params["PerpCKEY"]
	var/mob/M = ckey2mob(ckey)
	var/client/C = M.client
	if(!C)
		to_chat(user, span_alert("That user is not online!"))
		return
	var/datum/preferences/P = C?.prefs
	var/list/pics = P?.ProfilePics.Copy()
	var/flagge = NONE
	if(params["RstPic"])
		flagge |= (1 << 0)
	if(params["RstVerb"])
		flagge |= (1 << 1)
	if(params["RstVerbBlank"])
		flagge |= (1 << 2)
	if(params["RstSettings"])
		flagge |= (1 << 3)
	. = TRUE
	switch(action)
		if("ResetSingle")
			. &= modify_entry(P, params["Mode"], flagge, TRUE)
		if("ResetAll")
			for(var/list/entry in pics)
				. &= modify_entry(P, entry["Mode"], flagge, TRUE)
	if(.)
		SSchat.CoordinateSettingsAndPics(ckey, 2) // eslint-disable-line no-magic-numbers
		SSchat.SanitizeUserImages(ckey)
		SSchat.SanitizeUserPreferences(ckey)
		P.save_character()
		update_static_data(user, ui)
	else
		to_chat(user, span_warning("Something went wrong!!!"))

/datum/visualchat_admin_panel/proc/modify_entry(datum/preferences/P, mode, whatpart, tellem)
	. = TRUE
	var/list/pics = P.ProfilePics
	// var/list/momm = P.mommychat_settings
	for(var/list/bananni in pics)
		if(bananni["Mode"] != mode)
			continue
		if(CHECK_BITFIELD(whatpart, (1 << 0)))
			. &= reset_pic(bananni, tellem)
			if(tellem)
				to_chat(P.parent, span_boldwarning("Your profile picture for [SSchat.mode2string(mode)] has been reset by an admin."))
		if(CHECK_BITFIELD(whatpart, (1 << 1)))
			. &= reset_verb(bananni, tellem)
			if(tellem)
				to_chat(P.parent, span_boldwarning("Your custom message verb for [SSchat.mode2string(mode)] has been reset by an admin."))
		if(CHECK_BITFIELD(whatpart, (1 << 2)))
			. &= reset_verb_blank(bananni, tellem)
			if(tellem)
				to_chat(P.parent, span_boldwarning("Your custom blank verb for [SSchat.mode2string(mode)] has been reset by an admin."))
	if(CHECK_BITFIELD(whatpart, (1 << 3)))
		P.mommychat_settings[mode] = GLOB.default_horny_settings.Copy()
		if(tellem)
			to_chat(P.parent, span_boldwarning("Your settings for [SSchat.mode2string(mode)] have been reset by an admin."))

/datum/visualchat_admin_panel/proc/reset_pic(list/entry)
	entry["Host"] = ""
	entry["URL"] = ""
	return TRUE

/datum/visualchat_admin_panel/proc/reset_verb(list/entry)
	entry["CustomMessageVerb"] = ""
	return TRUE

/datum/visualchat_admin_panel/proc/reset_verb_blank(list/entry)
	entry["CustomBlankVerb"] = ""
	return TRUE

/datum/visualchat_admin_panel/proc/reset_settings(list/settiong, mode)
	settiong = GLOB.default_horny_settings.Copy()
	return TRUE









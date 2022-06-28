/**
 * Run when a client is put in this mob or reconnets to byond and their client was on this mob
 *
 * Things it does:
 * * Adds player to player_list
 * * sets lastKnownIP
 * * sets computer_id
 * * logs the login
 * * tells the world to update it's status (for player count)
 * * create mob huds for the mob if needed
 * * reset next_move to 1
 * * Set statobj to our mob
 * * NOT the parent call. The only unique thing it does is a very obtuse move op, see the comment lower down
 * * if the client exists set the perspective to the mob loc
 * * call on_log on the loc (sigh)
 * * reload the huds for the mob
 * * reload all full screen huds attached to this mob
 * * load any global alternate apperances
 * * sync the mind datum via sync_mind()
 * * call any client login callbacks that exist
 * * grant any actions the mob has to the client
 * * calls [auto_deadmin_on_login](mob.html#proc/auto_deadmin_on_login)
 * * send signal COMSIG_MOB_CLIENT_LOGIN
 * * attaches the ash listener element so clients can hear weather
 * client can be deleted mid-execution of this proc, chiefly on parent calls, with lag
 */
/mob/Login()
	if(!client)
		return FALSE
	GLOB.player_list |= src
	lastKnownIP = client.address
	computer_id = client.computer_id
	log_access("Mob Login: [key_name(src)] was assigned to a [type]")
	world.update_status()
	client.screen = list() //remove hud items just in case
	client.images = list()

	if(!hud_used)
		create_mob_hud()
	if(hud_used)
		hud_used.show_hud(hud_used.hud_version)
		hud_used.update_ui_style(ui_style2icon(client.prefs.UI_style))

	client.statobj = src

	// DO NOT CALL PARENT HERE
	// BYOND's internal implementation of login does two things
	// 1: Set statobj to the mob being logged into (We got this covered)
	// 2: And I quote "If the mob has no location, place it near (1,1,1) if possible"
	// See, near is doing an agressive amount of legwork there
	// What it actually does is takes the area that (1,1,1) is in, and loops through all those turfs
	// If you successfully move into one, it stops
	// Because we want Move() to mean standard movements rather then just what byond treats it as (ALL moves)
	// We don't allow moves from nullspace -> somewhere. This means the loop has to iterate all the turfs in (1,1,1)'s area
	// For us, (1,1,1) is a space tile. This means roughly 200,000! calls to Move()
	// You do not want this

	if(!client)
		return FALSE

	SEND_SIGNAL(src, COMSIG_MOB_LOGIN)

	if (key != client.key)
		key = client.key
	reset_perspective(loc)

	if(loc)
		loc.on_log(TRUE)

	//readd this mob's HUDs (antag, med, etc)
	reload_huds()

	reload_fullscreen() // Reload any fullscreen overlays this mob has.

	add_click_catcher()

	sync_mind()

	//Reload alternate appearances
	for(var/v in GLOB.active_alternate_appearances)
		if(!v)
			continue
		var/datum/atom_hud/alternate_appearance/AA = v
		AA.onNewMob(src)

	update_client_colour()
	update_mouse_pointer()
	if(client)
		client.view_size?.resetToDefault() // Resets the client.view in case it was changed.
		if(client.player_details && istype(client.player_details))
			if(client.player_details.player_actions.len)
				for(var/datum/action/A in client.player_details.player_actions)
					A.Grant(src)

			for(var/foo in client.player_details.post_login_callbacks)
				var/datum/callback/CB = foo
				CB.Invoke()
		log_played_names(client.ckey,name,real_name)

	mind?.hide_ckey = client?.prefs?.hide_ckey

	log_message("Client [key_name(src)] has taken ownership of mob [src]([src.type])", LOG_OWNERSHIP)
	SEND_SIGNAL(src, COMSIG_MOB_CLIENT_LOGIN, client)

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_MOB_LOGGED_IN, src)

	if(has_field_of_vision && CONFIG_GET(flag/use_field_of_vision))
		LoadComponent(/datum/component/field_of_vision, field_of_vision_type)
	return TRUE

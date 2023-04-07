/mob/Logout()
	SEND_SIGNAL(src, COMSIG_MOB_CLIENT_LOGOUT, client)
	log_message("[key_name(src)] is no longer owning mob [src]([src.type])", LOG_OWNERSHIP)
	SStgui.on_logout(src)
	unset_machine()
	GLOB.player_list -= src
	logout_time = world.time

	..()

	var/datum/atom_hud/H = GLOB.huds[GENITAL_PORNHUD]
	H.remove_hud_from(src)
	var/datum/atom_hud/tail_hud = GLOB.huds[TAIL_HUD_DATUM]
	tail_hud.remove_hud_from(src)

	if(loc)
		loc.on_log(FALSE)

	if(client)
		for(var/foo in client.player_details.post_logout_callbacks)
			var/datum/callback/CB = foo
			CB.Invoke()

	return TRUE

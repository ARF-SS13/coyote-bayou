/mob/living/Logout()
	update_z(null)
	SSstatpanels.discard_horny_demographic(src)
	..()
	disconnect_time = world.realtime
	if(!key && mind)	//key and mind have become separated.
		mind.active = 0	//This is to stop say, a mind.transfer_to call on a corpse causing a ghost to re-enter its body.
	hud_client_check()

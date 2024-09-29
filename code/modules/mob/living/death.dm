/mob/living/gib(no_brain, no_organs, no_bodyparts)
	var/prev_lying = lying
	if(stat != DEAD)
		death(1)

	if(!prev_lying)
		gib_animation()

	spill_organs(no_brain, no_organs, no_bodyparts)

	if(!no_bodyparts)
		spread_bodyparts(no_brain, no_organs)

	for(var/X in implants)
		var/obj/item/implant/I = X
		qdel(I)

	spawn_gibs(no_bodyparts)
	qdel(src)

/mob/living/proc/gib_animation()
	return

/mob/living/proc/spawn_gibs(with_bodyparts, atom/loc_override)
	var/location = loc_override ? loc_override.drop_location() : drop_location()
	if(mob_biotypes & MOB_ROBOTIC)
		new /obj/effect/gibspawner/robot(location, src, get_static_viruses())
	else
		new /obj/effect/gibspawner/generic(location, src, get_static_viruses())

/mob/living/proc/spill_organs()
	return

/mob/living/proc/spread_bodyparts()
	return

/mob/living/dust(just_ash, drop_items, force)
	death(TRUE)

	if(drop_items)
		unequip_everything()

	if(buckled)
		buckled.unbuckle_mob(src, force = TRUE)

	dust_animation()
	spawn_dust(just_ash)
	QDEL_IN(src,5) // since this is sometimes called in the middle of movement, allow half a second for movement to finish, ghosting to happen and animation to play. Looks much nicer and doesn't cause multiple runtimes.

/mob/living/proc/dust_animation()
	return

/mob/living/proc/spawn_dust(just_ash = FALSE)
	new /obj/effect/decal/cleanable/ash(loc)


/mob/living/death(gibbed)
	set_stat(DEAD)
	unset_machine()
	timeofdeath = world.time
	tod = STATION_TIME_TIMESTAMP("hh:mm:ss", world.time)
	for(var/obj/item/I in contents)
		I.on_mob_death(src, gibbed)
	if(mind)
		mind.store_memory("Time of death: [tod]", 0)
	remove_from_alive_mob_list()
	if(!gibbed)
		add_to_dead_mob_list()
	// if(ckey)
	// 	var/datum/preferences/P = GLOB.preferences_datums[ckey]
	// 	if(P)
	// 		P.respawn_time_of_death = world.time
	set_drugginess(0)
	set_disgust(0)
	SetSleeping(0, 0)
	blind_eyes(1)
	reset_perspective(null)
	reload_fullscreen()
	update_action_buttons_icon()
	update_damage_hud()
	update_health_hud()
	update_mobility()
	med_hud_set_health()
	med_hud_set_status()
	clear_typing_indicator()
	if(!gibbed && !QDELETED(src))
		addtimer(CALLBACK(src,PROC_REF(med_hud_set_status)), (DEFIB_TIME_LIMIT * 10) + 1)
	stop_pulling()

	var/signal = SEND_SIGNAL(src, COMSIG_MOB_DEATH, gibbed)

	broadcast_death(signal)
	if (client && client.prefs && client.prefs.auto_ooc)
		client.prefs.chat_toggles |= CHAT_OOC
	if (client)
		client.move_delay = initial(client.move_delay)

	for(var/s in ownedSoullinks)
		var/datum/soullink/S = s
		S.ownerDies(gibbed)
	for(var/s in sharedSoullinks)
		var/datum/soullink/S = s
		S.sharerDies(gibbed)
	return TRUE

/mob/living/proc/broadcast_death(signal = NONE)
	if(!mind)
		return
	if(!mind.name)
		return
	if(!mind.active)
		return
	var/turf/T = get_turf(src)
	if(istype(T.loc, /area/ctf))
		return
	if(signal & COMPONENT_BLOCK_DEATH_BROADCAST)
		return

	var/rendered = "<b>[mind.name]</b> has died at <b>[get_area_name(T)]</b>."
	var/penetant = HAS_TRAIT(mind, TRAIT_PENANCE)
	var/very_penetant = HAS_TRAIT(mind, TRAIT_PENANCE_COMPLETE)
	if(penetant && !very_penetant)
		rendered += " [p_they()] [p_were()] unable to bear [p_their()] penance. Perhaps the Gods will have mercy on [p_them()]?"
	else if(penetant && very_penetant)
		rendered += " [p_they()] bore the full brunt of [p_their()] penance to the grave. Perhaps the Gods will have mercy on [p_them()]?"
		message_admins("[src] won the penance game! Tell them what they won! And or grant a wish, or something.")
	else if(!penetant && very_penetant)
		rendered += " [p_they()] bore the full brunt of [p_their()] penance, but did not carry it to [p_their()] grave. Perhaps the Gods will have mercy on them?"
	rendered = span_deadsay("[rendered]")
	deadchat_broadcast(rendered, follow_target = src, turf_target = T, message_type=DEADCHAT_DEATHRATTLE)


GLOBAL_LIST_EMPTY(deathmatch_spawn_points)


/obj/effect/landmark/deathmatch/Initialize()
	. = ..()
	GLOB.deathmatch_spawn_points += loc
	return INITIALIZE_HINT_QDEL


/datum/game_mode/proc/grant_eord_respawn(datum/dcs, mob/source)
	SIGNAL_HANDLER
	source.verbs += /mob/proc/eord_respawn


/// This is only available to mobs once they join EORD.
/mob/proc/eord_respawn()
	set name = "EORD Respawn"
	set category = "OOC"

	if(isliving(usr))
		var/mob/living/liver = usr
		if(liver.stat == CONSCIOUS)
			to_chat(src, "You can only use this when you're dead or unsconscious.")
			return

	var/spawn_location = pick(GLOB.deathmatch_spawn_points)
	if(!spawn_location)
		to_chat(src, "Failed to find a valid deathmatch location to spawn into.")
		return

	var/mob/living/carbon/human/spawned_mob = new (picked)

	var/datum/job/role = SSjob.GetJob(usr.assigned_role)
	if(!role)
		role = SSjob.GetJob(SSjob.overflow_role)
		if(!role)
			CRASH("Failed to get overflow job.")
	spawned_mob.apply_assigned_role_to_spawn(role, usr.client)

	usr.mind.transfer_to(spawned_mob, TRUE)

	to_chat(spawned_mob, "<br><br><h1><span class='danger'>Fight for your life[isliving(src) ? " (again), try not to die this time" : ""]!</span></h1><br><br>")


/datum/game_mode/proc/end_of_round_deathmatch()
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGIN, .proc/grant_eord_respawn) // New mobs can now respawn into EORD
	var/list/spawns = GLOB.deathmatch_spawn_points.Copy()

	if(!length(spawns))
		to_chat(world, "<br><br><h1><span class='danger'>End of Round Deathmatch initialization failed, please do not grief.</span></h1><br><br>")
		return

	for(var/mob/player_mob as anything in GLOB.player_list)
		if(QDELETED(player_mob))
			continue // This loop sleeps.
		if(isnewplayer(player_mob))
			continue
		if(!player_mob.client?.prefs?.end_of_round_deathmatch)
			continue
		if(!player_mob.mind) //This proc is too important to prevent one admin shenanigan from runtiming it entirely
			to_chat(player_mob, "<br><br><h1><span class='danger'>You don't have a mind, if you believe this is not intended, please report it.</span></h1><br><br>")
			continue

		var/turf/picked
		if(length(spawns))
			picked = pick(spawns)
			spawns -= picked
		else
			spawns = GLOB.deathmatch_spawn_points.Copy()
			if(!length(spawns))
				to_chat(world, "<br><br><h1><span class='danger'>End of Round Deathmatch initialization failed, please do not grief.</span></h1><br><br>")
				return
			picked = pick(spawns)
			spawns -= picked

		if(!picked)
			to_chat(player_mob, "<br><br><h1><span class='danger'>Failed to find a valid location for End of Round Deathmatch. Please do not grief.</span></h1><br><br>")
			continue

		var/mob/living/carbon/human/spawned_mob = new (picked)

		var/datum/job/role = SSjob.GetJob(player_mob.assigned_role)
		if(!role)
			role = SSjob.GetJob(SSjob.overflow_role)
			if(!role)
				CRASH("Failed to get overflow job.")
		spawned_mob.apply_assigned_role_to_spawn(role, player_mob.client)

		player_mob.mind.transfer_to(spawned_mob, TRUE)
		to_chat(spawned_mob, "<br><br><h1><span class='danger'>Fight for your life!</span></h1><br><br>")
		CHECK_TICK


/mob/living/carbon/human/proc/apply_assigned_role_to_spawn(datum/job/role, client/preference_source)
	dna.species.before_equip_job(role, src, FALSE)

	var/datum/outfit/job/job_outfit = role.outfit
	if(job_outfit)
		equipOutfit(job_outfit, FALSE, preference_source)

	dna.species.after_equip_job(role, src, FALSE)

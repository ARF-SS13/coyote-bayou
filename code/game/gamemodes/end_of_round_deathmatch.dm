GLOBAL_LIST_EMPTY(deathmatch_spawn_points)
GLOBAL_LIST_INIT(eord_arsenal, list(
	/obj/item/twohanded/spear,
	/obj/item/melee/onehanded/machete,
))

/obj/effect/landmark/deathmatch/Initialize()
	. = ..()
	GLOB.deathmatch_spawn_points += loc
	return INITIALIZE_HINT_QDEL


/datum/controller/subsystem/ticker/proc/grant_eord_respawn(datum/dcs, mob/source)
	SIGNAL_HANDLER
	if(!source.client)
		return
	add_verb(source.client, /client/proc/eord_respawn)


/mob/proc/spawn_at_eord(turf/spawn_location)

	var/datum/job/role = SSjob.GetJob(mind.assigned_role)
	if(!role)
		role = SSjob.GetJob(SSjob.overflow_role)
		if(!role)
			CRASH("Failed to get overflow job.")
	var/client/our_client = client
	var/mob/living/carbon/human/spawned_mob = new (spawn_location)
	mind.transfer_to(spawned_mob, TRUE)
	spawned_mob.apply_assigned_role_to_spawn(role, our_client)

	if(!get_active_held_item() || !get_inactive_held_item()) // At least one hand free, let's give them a weapon.
		var/obj/item/eord_weapon = pick(GLOB.eord_arsenal) // Get the type.
		eord_weapon = new eord_weapon(spawn_location) // Instantiate it.
		spawned_mob.put_in_hands(eord_weapon) // Equip it.

	var/was_dead = ""
	if(isliving(src) && is_centcom_level(z))
		was_dead = " (again), try not to die this time"

	to_chat(spawned_mob, "<br><br><h1><span class='danger'>Fight for your life[was_dead]!</span></h1><br><br>")


/// This is only available to mobs once they join EORD.
/client/proc/eord_respawn()
	set name = "EORD Respawn"
	set category = "OOC"

	if(isnewplayer(mob))
		to_chat(src, "Try observing before using this.")
		return

	if(isliving(mob))
		var/mob/living/liver = mob
		if(liver.stat == CONSCIOUS)
			to_chat(src, "Ghost-up in order to use this verb.")
			return

	var/spawn_location = pick(GLOB.deathmatch_spawn_points)
	if(!spawn_location)
		to_chat(src, "Failed to find a valid deathmatch location to spawn into.")
		return

	mob.spawn_at_eord(spawn_location)


/datum/controller/subsystem/ticker/proc/end_of_round_deathmatch()
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
		if(!player_mob.client)
			continue
		add_verb(player_mob.client, /client/proc/eord_respawn)
		if(!player_mob.client.prefs?.end_of_round_deathmatch)
			continue
		if(isliving(player_mob) && is_centcom_level(player_mob.z))
			continue // Already at CentComm, lets not force them out of their bodies.
		if(!player_mob.mind) // This proc is too important to prevent one admin shenanigan from runtiming it entirely
			to_chat(player_mob, "<br><br><h1><span class='danger'>You don't have a mind, if you believe this is not intended, please report it.</span></h1><br><br>")
			continue

		var/turf/spawn_location
		if(length(spawns))
			spawn_location = pick(spawns)
			spawns -= spawn_location
		else
			spawns = GLOB.deathmatch_spawn_points.Copy()
			if(!length(spawns))
				to_chat(world, "<br><br><h1><span class='danger'>End of Round Deathmatch initialization failed, please do not grief.</span></h1><br><br>")
				return
			spawn_location = pick(spawns)
			spawns -= spawn_location

		if(!spawn_location)
			to_chat(player_mob, "<br><br><h1><span class='danger'>Failed to find a valid location for End of Round Deathmatch. Please do not grief.</span></h1><br><br>")
			continue

		player_mob.spawn_at_eord(spawn_location)
		CHECK_TICK


/mob/living/carbon/human/proc/apply_assigned_role_to_spawn(datum/job/role, client/preference_source)
	dna.species.before_equip_job(role, src, FALSE)

	var/datum/outfit/job/job_outfit = role.outfit
	if(job_outfit)
		equipOutfit(job_outfit, FALSE, preference_source)

	dna.species.after_equip_job(role, src, FALSE)

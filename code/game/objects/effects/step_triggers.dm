/* Simple object type, calls a proc when "stepped" on by something */

/obj/effect/step_trigger
	var/affect_ghosts = 0
	var/stopper = 1 // stops throwers
	var/mobs_only = FALSE
	invisibility = INVISIBILITY_ABSTRACT // nope cant see this shit
	anchored = TRUE

/obj/effect/step_trigger/Initialize()
	. = ..()

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED =PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/step_trigger/proc/Trigger(atom/movable/A)
	return 0

/obj/effect/step_trigger/proc/on_entered(atom/loc, atom/movable/H)
	SIGNAL_HANDLER
	if(!H)
		return

	INVOKE_ASYNC(src,PROC_REF(Trigger), H)


/obj/effect/step_trigger/singularity_act()
	return

/obj/effect/step_trigger/singularity_pull()
	return

/* Sends a message to mob when triggered*/

/obj/effect/step_trigger/message
	var/message	//the message to give to the mob
	var/once = 1
	mobs_only = TRUE

/obj/effect/step_trigger/message/Trigger(mob/M)
	if(!ismob(M))
		return

	if(M.client)
		to_chat(M, span_info("[message]"))
		if(once)
			qdel(src)

/* Tosses things in a certain direction */

/obj/effect/step_trigger/thrower
	var/direction = SOUTH // the direction of throw
	var/tiles = 3	// if 0: forever until atom hits a stopper
	var/immobilize = 1 // if nonzero: prevents mobs from moving while they're being flung
	var/speed = 1	// delay of movement
	var/facedir = 0 // if 1: atom faces the direction of movement
	var/nostop = 0 // if 1: will only be stopped by teleporters
	var/list/affecting = list()

/obj/effect/step_trigger/thrower/Trigger(atom/A)
	if(!A || !ismovable(A))
		return
	var/atom/movable/AM = A
	var/curtiles = 0
	var/stopthrow = 0
	for(var/obj/effect/step_trigger/thrower/T in orange(2, src))
		if(AM in T.affecting)
			return

	if(isliving(AM))
		var/mob/living/M = AM
		if(immobilize)
			ADD_TRAIT(M, TRAIT_MOBILITY_NOMOVE, src)
			M.update_mobility()

	affecting.Add(AM)
	while(AM && !stopthrow)
		if(tiles)
			if(curtiles >= tiles)
				break
		if(AM.z != src.z)
			break

		curtiles++

		sleep(speed)

		// Calculate if we should stop the process
		if(!nostop)
			for(var/obj/effect/step_trigger/T in get_step(AM, direction))
				if(T.stopper && T != src)
					stopthrow = 1
		else
			for(var/obj/effect/step_trigger/teleporter/T in get_step(AM, direction))
				if(T.stopper)
					stopthrow = 1

		if(AM)
			var/predir = AM.dir
			step(AM, direction)
			if(!facedir)
				AM.setDir(predir)



	affecting.Remove(AM)

	if(isliving(AM))
		var/mob/living/M = AM
		if(immobilize)
			REMOVE_TRAIT(M, TRAIT_MOBILITY_NOMOVE, src)
			M.update_mobility()

/* Stops things thrown by a thrower, doesn't do anything */

/obj/effect/step_trigger/stopper

/* Instant teleporter */

/obj/effect/step_trigger/teleporter
	var/teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y = 0
	var/teleport_z = 0
	var/checkPulled = 0

/obj/effect/step_trigger/teleporter/Trigger(atom/movable/A)
	var/zLevel = 0
	
	var/list/z_list = SSmapping.z_list
	for(var/datum/space_level/S in z_list)
		if(S.name == teleport_z)
			zLevel = S.name
			continue

	if(teleport_x && teleport_y && zLevel)
		var/turf/T = locate(teleport_x, teleport_y, zLevel)
		A.forceMove(T)
		if(checkPulled)
			var/atom/movable/AM = A.pulling
			if(AM)
				T = get_step(A.loc,turn(A.dir, 180))
				AM.can_be_z_moved = FALSE
				AM.forceMove(T)
				A.start_pulling(AM)
				AM.can_be_z_moved = TRUE


/* Random teleporter, teleports atoms to locations ranging from teleport_x - teleport_x_offset, etc */

/obj/effect/step_trigger/teleporter/random
	var/teleport_x_offset = 0
	var/teleport_y_offset = 0
	var/teleport_z_offset = 0

/obj/effect/step_trigger/teleporter/random/Trigger(atom/movable/A)
	if(teleport_x && teleport_y && teleport_z)
		if(teleport_x_offset && teleport_y_offset && teleport_z_offset)

			var/turf/T = locate(rand(teleport_x, teleport_x_offset), rand(teleport_y, teleport_y_offset), rand(teleport_z, teleport_z_offset))
			if (T)
				A.forceMove(T)

/* Fancy teleporter, creates sparks and smokes when used */

/obj/effect/step_trigger/teleport_fancy
	var/locationx
	var/locationy
	var/uses = 1	//0 for infinite uses
	var/entersparks = 0
	var/exitsparks = 0
	var/entersmoke = 0
	var/exitsmoke = 0

/obj/effect/step_trigger/teleport_fancy/Trigger(mob/M)
	var/dest = locate(locationx, locationy, z)
	M.Move(dest)

	if(entersparks)
		var/datum/effect_system/spark_spread/s = new
		s.set_up(4, 1, src)
		s.start()
	if(exitsparks)
		var/datum/effect_system/spark_spread/s = new
		s.set_up(4, 1, dest)
		s.start()

	if(entersmoke)
		var/datum/effect_system/smoke_spread/s = new
		s.set_up(4, 1, src, 0)
		s.start()
	if(exitsmoke)
		var/datum/effect_system/smoke_spread/s = new
		s.set_up(4, 1, dest, 0)
		s.start()

	uses--
	if(uses == 0)
		qdel(src)

/* Simple sound player, Mapper friendly! */

/obj/effect/step_trigger/sound_effect
	var/sound //eg. path to the sound, inside '' eg: 'growl.ogg'
	var/volume = 100
	var/freq_vary = 1 //Should the frequency of the sound vary?
	var/extra_range = 0 // eg World.view = 7, extra_range = 1, 7+1 = 8, 8 turfs radius
	var/happens_once = 0
	var/triggerer_only = 0 //Whether the triggerer is the only person who hears this


/obj/effect/step_trigger/sound_effect/Trigger(atom/movable/A)
	var/turf/T = get_turf(A)

	if(!T)
		return

	if(triggerer_only && ismob(A))
		var/mob/B = A
		B.playsound_local(T, sound, volume, freq_vary)
	else
		playsound(T, sound, volume, freq_vary, extra_range)

	if(happens_once)
		qdel(src)

/* Fenny requested this, a steptrigger to prompt a choice, and then alog their choice. Very weird, no fucking idea what he wants it for */

// Rule of thumb. Don't modify these sacred texts. Do it in the map.
// 
// IF YOU NEED A YES/NO ANSWER, LEAVE CHOICES EMPTY!

/obj/effect/step_trigger/player_choice_log
	var/title = "Step has been triggered" // Title of the chat window.
	var/question = "Step Trigger demands an answer" // The text to show to the player along with the choices 
	var/list/choices = list() // List of choices to prompt the player with. If empty, give them a yes/no
	var/adminLogSuffix = "PLAYER_CHOICE" // First word to appear on admin log, useful to highlight the specific step trigger in logs.

	var/list/ckeyList = list() // Don't change this. This is to keep track of who's entered the room


/obj/effect/step_trigger/player_choice_log/Trigger(atom/movable/A)
	if(!ismob(A))
		return
	
	var/mob/M = A
	
	if(M.client)
		if(M.ckey in ckeyList)	return // Already answered and logged. No need for more input.
		if(isobserver(M))	return // Ghosts get no no's
		var/playerInput
		if(choices.len)
			playerInput = input(M, question, title) as null|anything in choices
		else
			playerInput = alert(M, question, title, "Yes", "No")
		
		var/msg = "STEP TRIGGER: [adminLogSuffix] - ERROR! [M] ([M.key]) somehow had not made a choice. (They closed the window? Assuming no then)"

		if(playerInput)
			msg = "STEP TRIGGER: [adminLogSuffix] - [M] ([M.key]) has selected \"[playerInput]\""
		
		message_admins(msg)
		log_admin(msg)

		ckeyList += M.ckey

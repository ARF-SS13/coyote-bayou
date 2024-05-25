/*
/datum/round_event_control/carp_migration
	name = "Carp Migration"
	typepath = /datum/round_event/carp_migration/blowout
	weight = 15
	min_players = 4
	earliest_start = 10 MINUTES
	max_occurrences = 6

/datum/round_event/carp_migration/blowout
	announceWhen	= 3
	startWhen = 50
	var/hasAnnounced = FALSE

/datum/round_event/carp_migration/blowout/setup()
	startWhen = rand(40, 60)

/datum/round_event/carp_migration/announce(fake)
	if(prob(50))
		priority_announce("Unknown biological entities have been detected near [station_name()], please stand-by.", "Lifesign Alert")
	else
		print_command_report("Unknown biological entities have been detected near [station_name()], you may wish to break out arms.", "Biological entities")

/datum/round_event/carp_migration/start()
	var/mob/living/simple_animal/hostile/carp/fish
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if(prob(95))
			fish = new (C.loc)
		else
			fish = new /mob/living/simple_animal/hostile/carp/megacarp(C.loc)
			fishannounce(fish) //Prefer to announce the megacarps over the regular fishies
	fishannounce(fish)

/datum/round_event/carp_migration/proc/fishannounce(atom/fish)
	if (!hasAnnounced)
		announce_to_ghosts(fish) //Only anounce the first fish
		hasAnnounced = TRUE
*/

GLOBAL_LIST_EMPTY(fish_ponds) // actually spawners

/// """Carp""" """Migration"""
/datum/round_event_control/spawn_nests
	name = "Mob Blowout"
	typepath = /datum/round_event/common/spawn_nests
	weight = 15
	min_players = 1
	earliest_start = 0 MINUTES
	infinite_occurances = TRUE
	common_occurrence = TRUE

/datum/round_event/common
	var/start_at = 0
	var/started = FALSE
	var/announce_at = 0
	var/announced = FALSE
	var/stop_at = 0
	var/stopped = FALSE
	var/min_start_delay = 1 MINUTES
	var/max_start_delay = 2 MINUTES
	var/min_announce_delay = 0
	var/max_announce_delay = 0
	var/min_duration = 0
	var/max_duration = 0
	var/announce_then_start = FALSE

/datum/round_event/common/kill()
	. = ..()
	control.active = FALSE

/datum/round_event/common/setup()
	var/start_offset = rand(min_start_delay, max_start_delay)
	var/announce_offset = rand(min_announce_delay, max_announce_delay)
	var/stop_offset = rand(min_duration, max_duration)
	if(announce_then_start)
		start_at = world.time + start_offset + announce_offset
		announce_at = world.time + announce_offset
	else
		start_at = world.time + start_offset
		announce_at = world.time + announce_offset + start_offset
	stop_at = world.time + start_offset + announce_offset + stop_offset
	message_admins("Common event [type] starting in [DisplayTimeText(start_at - world.time)], announcing in [DisplayTimeText(announce_at - world.time)], finishing in [DisplayTimeText(stop_at - world.time)].")
	if(control) // Just to get rid of the unit test error >:(
		control.active = TRUE

/datum/round_event/common/process()
	if(!processing)
		return
	if(!started && COOLDOWN_FINISHED(src, start_at))
		start()
		started = TRUE
		return
	if(!announced && COOLDOWN_FINISHED(src, announce_at))
		announce()
		announced = TRUE
		return
	if(!stopped && COOLDOWN_FINISHED(src, stop_at))
		end()
		stopped = TRUE
		return
	if(started && !stopped)
		tick()
		return
	if(stopped)
		kill()

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/datum/round_event/common/spawn_nests
	min_start_delay = 30 MINUTES
	max_start_delay = 1 HOURS
	min_announce_delay = 0
	max_announce_delay = 0
	min_duration = 5 MINUTES
	max_duration = 10 MINUTES
	var/list/coords_to_spawn_at = list()
	var/max_nests_per_event = 80
	var/list/spawn_holes = list()

/datum/round_event/common/spawn_nests/start()
	// var/time_in = world.time - SSticker.round_start_time
	// var/num_to_spawn = LAZYLEN(GLOB.nest_spawn_points)
	// if(num_to_spawn <= 0)
	// 	return kill()
	// switch(time_in)
	// 	if(-INFINITY to 45 MINUTES)
	// 		num_to_spawn = min(2, num_to_spawn)
	// 	if(45 MINUTES to 1.5 HOURS)
	// 		num_to_spawn *= 0.25
	// 	if(1.5 HOURS to 3 HOURS)
	// 		num_to_spawn *= 0.5
	// 	if(3 HOURS to 4 HOURS)
	// 		num_to_spawn *= 0.75
	// 	else
	// 		num_to_spawn *= 0.90
	// num_to_spawn = round(clamp(num_to_spawn, 0, min(LAZYLEN(GLOB.nest_spawn_points), max_nests_per_event)))
	// var/list/hak = GLOB.nest_spawn_points
	// var/list/spawndidates = hak.Copy()
	// for(var/i in 1 to num_to_spawn)
	// 	if(!LAZYLEN(spawndidates))
	// 		break
	// 	var/coordie = pick(spawndidates)
	// 	spawndidates -= coordie
	// 	var/turf/here = coords2turf(coordie)
	// 	if(locate(/obj/structure/nest) in here)
	// 		continue // already a nest here lol
	// 	coords_to_spawn_at |= coordie
	// 	var/mob/living/simple_animal/nest_spawn_hole_guy/hole = new /mob/living/simple_animal/nest_spawn_hole_guy(here)
	// 	hole.register_event(src)
	// 	spawn_holes |= hole
	// message_admins("Readied [LAZYLEN(coords_to_spawn_at)] nests. Firing soon-ish.")

/datum/round_event/common/spawn_nests/tick()
	if(!LAZYLEN(coords_to_spawn_at))
		kill()
		return
	for(var/coordie in coords_to_spawn_at)
		var/turf/here = coords2turf(coordie)
		if(!isturf(here))
			coords_to_spawn_at -= coordie
			continue

/datum/round_event/common/spawn_nests/end(fake)
	var/list/stuff_spawned = list()
	var/numspawned = 0
	mainloop:
		for(var/C in coords_to_spawn_at)
			var/turf/here = get_turf(coords2turf(C))
			if(!isturf(here))
				continue
			if(locate(/obj/structure/nest) in here)
				continue // already a nest here lol
			if(!(locate(/mob/living/simple_animal/nest_spawn_hole_guy) in here))
				continue // someone killed the hole
			for(var/atom/A in here)
				if(A.density && istype(A, /mob/living/simple_animal/nest_spawn_hole_guy))
					continue mainloop
			for(var/client/clint in GLOB.clients)
				if(!isliving(clint.mob))
					continue
				var/mob/living/L = clint.mob
				if(L.z != here.z)
					continue
				if(L in hearers(10, here))
					continue mainloop // my first labeled loop that ISNT cus of a bad idea!!!
			var/mob/living/spawned = pickweight(GLOB.totally_not_carp)
			if(!spawned)
				stack_trace("Spawner thing broke!")
				continue
			spawned = new spawned(here)
			numspawned++
			if(LAZYLEN(stuff_spawned) <= 10)
				stuff_spawned += "[spawned.name] [ADMIN_FLW(spawned)]"
	if(numspawned > LAZYLEN(stuff_spawned))
		var/andmanymore = numspawned - LAZYLEN(stuff_spawned) // on channel four
		stuff_spawned += "[andmanymore] other lovely pest[andmanymore > 1 ? "s":""]" // and scooby doo, on channel two
	var/report = "No new nests spawned! =3"
	if(LAZYLEN(stuff_spawned))
		report = "[english_list(stuff_spawned)]"
	var/messenge = ""
	switch(LAZYLEN(stuff_spawned))
		if(-INFINITY to 0)
			messenge = "You have a strange feeling for a moment, then it passes."
		if(1 to 10)
			messenge = "You feel a faint ripple, like a rock thrown in a pond."
		if(10 to 20)
			messenge = "You feel a slight tremor in the ground, and... everywhere else too."
		if(20 to 30)
			messenge = "Your vision squeezes in ever so slightly."
		if(30 to 40)
			messenge = "You have a brief feeling as though you're congested, but all over."
		if(40 to 50)
			messenge = "You feel a slight pressure in your ears, like you're underwater."
		else
			messenge = "You feel hemmed in."
	to_chat(world, span_notice(messenge))
	message_admins("[report]")
	QDEL_LIST(spawn_holes)

GLOBAL_LIST_INIT(totally_not_carp, list(
	/obj/structure/nest/ghoul = 8,
	/obj/structure/nest/lesserspider = 5,
	/obj/structure/nest/aethergiest = 3,
	/obj/structure/nest/aethergiest/mother = 1,
	/obj/structure/nest/greaterspider = 3,
	/obj/structure/nest/scorpion = 3,
	/obj/structure/nest/radroach = 5,
	/obj/structure/nest/fireant = 3,
	/obj/structure/nest/wanamingo = 2,
	/obj/structure/nest/rattle = 2,
	/obj/structure/nest/molerat = 8,
	/obj/structure/nest/mirelurk = 3,
	/obj/structure/nest/rat = 5,
	/obj/structure/nest/mouse = 3,
	/obj/structure/nest/raider = 4,
	/obj/structure/nest/raider/melee = 4,
	/obj/structure/nest/raider/ranged = 3,
	/obj/structure/nest/raider/boss = 2,
	/obj/structure/nest/protectron = 3,
	/obj/structure/nest/securitron = 3,
	/obj/structure/nest/assaultron = 2,
	/obj/structure/nest/cazador = 2,
	/obj/structure/nest/gecko = 9,
	/obj/structure/nest/gelcube = 1,
	/obj/structure/nest/wolf = 3,
	/obj/structure/nest/supermutant = 3,
	/obj/structure/nest/supermutant/melee = 3,
	/obj/structure/nest/supermutant/ranged = 3,
	/obj/structure/nest/supermutant/nightkin = 1,
	/obj/structure/nest/nightstalker = 3,
	/obj/structure/nest/zombieghoul = 3,
	/obj/structure/nest/tunneler = 2,
))

GLOBAL_LIST_EMPTY(nest_spawn_points)

/obj/effect/landmark/nest_spawn
	name = "carpspawn"
	icon_state = "carp_spawn"

/obj/effect/landmark/nest_spawn/Initialize()
	. = ..()
	var/turf/here = get_turf(src)
	if(isturf(here))
		GLOB.nest_spawn_points |= atom2coords(here)
	return INITIALIZE_HINT_QDEL


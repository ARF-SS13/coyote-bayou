/datum/map_template/dungeon
	var/description
	/// Used by dynamic mob spawnpoints to assign health, damage, etc
	var/difficulty
	/// Used by dynamic loot objects to assign a loot rarity to each container. See _lootable.dm
	var/loot_abundance
	/// What kinds of enemies spawn in this dungeon? examples: "Robots", "Geckos", "Super-advanced crab-people with quasar cannons"
	var/threat_type
	/// How many of this dungeon can be running at the same time?
	var/max_simultaneous = 1


/datum/map_template/dungeon/proc/spawn_new_dungeon()
	var/datum/turf_reservation/dungeon/reservation = SSmapping.RequestBlockReservation(width, height, type = /datum/turf_reservation/dungeon) 									//Reserve space to spawn our dungeon
	if(!reservation)
		message_admins(span_adminnotice("DEBUG:Failed to reserve space to spawn a dungeon.")) 											//We couldn't reserve a spot.
		return
	var/turf/placement = locate(reservation.bottom_left_coords[1],reservation.bottom_left_coords[2],reservation.bottom_left_coords[3])
	load(placement)																														//Place the dungeon
	loaded++																															//Increment the # of times this dungeon has spawned
	var/turf/center = locate(placement.x + round(width/2),placement.y + round(height/2),placement.z)									//Locate the center turf of the dungeon to spawn a dungeon controller / landmark thing
	new /obj/effect/landmark/dungeon_mark(center, src)
	message_admins(span_adminnotice("DEBUG:Dungeon ([name]) placed at [ADMIN_COORDJMP(center)]"))
	return center

/// Loads a single dungeon of your choice
/client/proc/dungeon_test_load()
	set category = "Debug"
	set name = "spawn dungeon instance"

	var/datum/map_template/dungeon/template

	var/map = input(src, "Choose a dungeon to spawn","Spawn dungeon instance") as null|anything in SSmapping.dungeon_templates

	if(!map)
		return
	template = SSmapping.dungeon_templates[map]

	template.spawn_new_dungeon()

/// Rapidly spawns and despawns dungeons as a test.
/client/proc/dungeon_stress_test()
	set category = "Debug"
	set name = "stress test dungeons"

	SSDungeons.dungeon_stress_test = !SSDungeons.dungeon_stress_test

	if(SSmapping.dungeon_stress_test)
		message_admins(span_adminnotice("STRESS TEST: Stress test started."))
		for(var/i=0, i<30, i++)
			if(!SSmapping.dungeon_stress_test)
				break
			var/datum/map_template/dungeon/template
			var/map = pick(SSmapping.dungeon_templates)
			if(!map)
				message_admins(span_adminnotice("STRESS TEST: No maps found..."))
				continue
			template = SSmapping.dungeon_templates[map]
			message_admins(span_adminnotice("STRESS TEST: Spawning dungeon #[i+1]."))
			template.spawn_new_dungeon()
			sleep(30 SECONDS)
	else
		message_admins(span_adminnotice("STRESS TEST: Stress test canceled."))

/// Dungeon master controller
/datum/dungeon_controller
	/// Unique ID that SSDungeons uses to keep track of this unique dungeon
	var/dungeon_id
	/// Turf reservations that this dungeon needs.
	var/list/reservations = list()
	/// A list of players inside the dungeon. If nobody's inside for a while, we wipe the reservation to save memory.
	var/list/players_inside = list()
	/// After everyone's left a dungeon, we should wait this long before wiping it.
	var/wipe_after = 10 MINUTES
	/// Each dungeon only gets one of these.
	var/entrance
	/// The name of the landmarks that our exits should take you to.
	var/exit_landmarks = list()

/// Click on this to enter a dungeon
/obj/effect/landmark/dungeon_entrance
	/// The typepath of the dungeon we use
	var/dungeon_type

/obj/effect/landmark/dungeon_entrance/debug_1

/// Transition from one dungeon chunk to another without leaving the same dungeon.
/obj/effect/landmark/dungeon_transition

/// This takes you back to the "real" world
/obj/effect/landmark/dungeon_exit


/datum/map_template/dungeon/debug_1
	name = "Debug Dungeon 1"
	description = "I wanna be the very first."
	mappath = "_maps/templates/dungeons/debug_1.dmm"

/datum/map_template/dungeon/debug_2
	name = "Debug Dungeon 2"
	description = "I wanna be the very first."
	mappath = "_maps/templates/dungeons/debug_2.dmm"

/datum/map_template/dungeon/debug_3
	name = "Debug Dungeon 3"
	description = "I wanna be the very first."
	mappath = "_maps/templates/dungeons/debug_3.dmm"

/datum/map_template/dungeon/debug_4
	name = "Debug Dungeon 4"
	description = "I wanna be the very first."
	mappath = "_maps/templates/dungeons/debug_4.dmm"

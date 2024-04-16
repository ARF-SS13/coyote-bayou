/datum/map_template/dungeon
	var/dungeon_id
	var/description


/datum/map_template/dungeon/proc/spawn_new_dungeon(z)
	var/datum/turf_reservation/reservation = SSmapping.RequestBlockReservation(width, height, z) //Make the new level creation work with different traits.
	if(!reservation)
		return
	var/turf/placement = locate(reservation.bottom_left_coords[1],reservation.bottom_left_coords[2],reservation.bottom_left_coords[3])
	load(placement)
	loaded++
	for(var/turf/T in get_affected_turfs(placement))
		T.flags_1 |= NO_RUINS_1
	var/turf/center = locate(placement.x + round(width/2),placement.y + round(height/2),placement.z)
	new /obj/effect/landmark/ruin(center, src)
	message_admins(span_adminnotice("DEBUG:Dungeon ([name]) placed for testing automatically at [ADMIN_COORDJMP(center)]"))
	return center

/datum/map_template/dungeon/debug_1
	name = "Debug Dungeon 1"
	dungeon_id = "debug_dungeon_1"
	description = "I wanna be the very first."
	mappath = "_maps/templates/shelter_1.dmm"

/datum/map_template/dungeon/debug_2
	name = "Debug Dungeon 2"
	dungeon_id = "debug_dungeon_2"
	description = "I wanna be the very first."
	mappath = "_maps/templates/shelter_2.dmm"

/datum/map_template/dungeon/debug_3
	name = "Debug Dungeon 3"
	dungeon_id = "debug_dungeon_3"
	description = "I wanna be the very first."
	mappath = "_maps/templates/shelter_3.dmm"

/datum/map_template/dungeon/debug_4
	name = "Debug Dungeon 4"
	dungeon_id = "debug_dungeon_4"
	description = "I wanna be the very first."
	mappath = "_maps/templates/shelter_4.dmm"

/datum/map_template/dungeon/debug_5
	name = "Debug Dungeon 5"
	dungeon_id = "debug_dungeon_5"
	description = "I wanna be the very first."
	mappath = "_maps/templates/shelter_5.dmm"

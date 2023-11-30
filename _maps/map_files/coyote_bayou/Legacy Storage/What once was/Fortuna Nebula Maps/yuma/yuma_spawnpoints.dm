var/global/list/latejoin_west = list()
var/global/list/latejoin_east = list()
var/global/list/latejoin_south = list()
var/global/list/latejoin_north = list()

/obj/effect/landmark/latejoin/west/add_loc()
	global.latejoin_west |= get_turf(src)
	..()

/obj/effect/landmark/latejoin/east/add_loc()
	global.latejoin_east |= get_turf(src)
	..()

/obj/effect/landmark/latejoin/south/add_loc()
	global.latejoin_south |= get_turf(src)
	..()

/obj/effect/landmark/latejoin/north/add_loc()
	global.latejoin_north |= get_turf(src)
	..()

/datum/map/yuma
	allowed_spawns = list(
		/decl/spawnpoint/arrivals/wastes/west,
		/decl/spawnpoint/arrivals/wastes/east,
		/decl/spawnpoint/arrivals/wastes/south,
		/decl/spawnpoint/arrivals/wastes/north
	)
	default_spawn = /decl/spawnpoint/arrivals/wastes/south

/decl/spawnpoint/arrivals/wastes/west
	name = "West"
	msg = "has arrived from the west"

/decl/spawnpoint/arrivals/wastes/east
	name = "East"
	msg = "has arrived from the east"

/decl/spawnpoint/arrivals/wastes/south
	name = "South"
	msg = "has arrived from the south"

/decl/spawnpoint/arrivals/wastes/north
	name = "North"
	msg = "has arrived from the north"

/decl/spawnpoint/arrivals/wastes/west/Initialize()
	. = ..()
	turfs = global.latejoin_west

/decl/spawnpoint/arrivals/wastes/east/Initialize()
	. = ..()
	turfs = global.latejoin_east

/decl/spawnpoint/arrivals/wastes/south/Initialize()
	. = ..()
	turfs = global.latejoin_south

/decl/spawnpoint/arrivals/wastes/north/Initialize()
	. = ..()
	turfs = global.latejoin_north


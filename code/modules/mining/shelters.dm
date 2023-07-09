/datum/map_template/shelter
	var/shelter_id
	var/description
	var/blacklisted_turfs
	var/whitelisted_turfs
	var/banned_areas
	var/banned_objects

/datum/map_template/shelter/New()
	. = ..()
	blacklisted_turfs = typecacheof(/turf/closed)
	whitelisted_turfs = list()
	banned_areas = typecacheof(/area/shuttle)
	banned_objects = list()

/datum/map_template/shelter/proc/check_deploy(turf/deploy_location)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/T in affected)
		var/area/A = get_area(T)
		if(is_type_in_typecache(A, banned_areas))
			return SHELTER_DEPLOY_BAD_AREA

		var/banned = is_type_in_typecache(T, blacklisted_turfs)
		var/permitted = is_type_in_typecache(T, whitelisted_turfs)
		if(banned && !permitted)
			return SHELTER_DEPLOY_BAD_TURFS

		for(var/obj/O in T)
			if((O.density && O.anchored) || is_type_in_typecache(O, banned_objects))
				return SHELTER_DEPLOY_ANCHORED_OBJECTS
	return SHELTER_DEPLOY_ALLOWED

/datum/map_template/shelter/alpha
	name = "Shelter Alpha"
	shelter_id = "shelter_alpha"
	description = "A small tent, containing the basic ammenities."
	mappath = "_maps/templates/shelter_1.dmm"

/datum/map_template/shelter/alpha/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/beta
	name = "Shelter Beta"
	shelter_id = "shelter_beta"
	description = "A tent containing a small bench and some cooking ammenities."
	mappath = "_maps/templates/shelter_2.dmm"

/datum/map_template/shelter/beta/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/charlie
	name = "Shelter Charlie"
	shelter_id = "shelter_charlie"
	description = "A cosy tent containing space for two."
	mappath = "_maps/templates/shelter_3.dmm"

/datum/map_template/shelter/charlie/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/delta
	name = "Shelter Delta"
	shelter_id = "shelter_delta"
	description = "A shopkeepers arrangement with base starting supplies."
	mappath = "_maps/templates/shelter_4.dmm"

/datum/map_template/shelter/delta/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/echo
	name = "Shelter Echo"
	shelter_id = "shelter_echo"
	description = "A party tent for you and all of your friends."
	mappath = "_maps/templates/shelter_5.dmm"

/datum/map_template/shelter/echo/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/foxtrot
	name = "Shelter Foxtrot"
	shelter_id = "shelter_foxtrot"
	description = "An extremely stocked and well provisioned mass hall kitchen."
	mappath = "_maps/templates/shelter_6.dmm"

/datum/map_template/shelter/foxtrot/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/golf
	name = "Shelter Golf"
	shelter_id = "shelter_golf"
	description = "An out of the box, get started farm."
	mappath = "_maps/templates/shelter_7.dmm"

/datum/map_template/shelter/golf/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/hotel
	name = "Shelter Hotel"
	shelter_id = "shelter_hotel"
	description = "A pen for brahmin."
	mappath = "_maps/templates/shelter_8.dmm"

/datum/map_template/shelter/hotel/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/india
	name = "Shelter India"
	shelter_id = "shelter_india"
	description = "A compact tent for three."
	mappath = "_maps/templates/shelter_9.dmm"

/datum/map_template/shelter/india/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/juliett
	name = "Shelter Juliett"
	shelter_id = "shelter_juliett"
	description = "A tent containing the supplies to get yourself started forging!"
	mappath = "_maps/templates/shelter_10.dmm"

/datum/map_template/shelter/juliett/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/kilo
	name = "Shelter Kilo"
	shelter_id = "shelter_kilo"
	description = "A tent containing the supplies for a medicine man!"
	mappath = "_maps/templates/shelter_11.dmm"

/datum/map_template/shelter/kilo/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

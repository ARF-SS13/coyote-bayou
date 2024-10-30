SUBSYSTEM_DEF(inn)
	name = "Inn"
	flags = SS_BACKGROUND|SS_NO_FIRE

	var/list/instances = list()

	var/list/templates = list(
		"Hotel Room" = /datum/map_template/hilbertshotel,
		"Apartment-1" = /datum/map_template/hilbertshotel/apartment/one,
		"Apartment-2" = /datum/map_template/hilbertshotel/apartment/two,
		"Apartment-3" = /datum/map_template/hilbertshotel/apartment/three,
		"Apartment-4" = /datum/map_template/hilbertshotel/apartment/four,
		"Apartment-Bar" = /datum/map_template/hilbertshotel/apartment/bar,
		"Apartment-Garden" = /datum/map_template/hilbertshotel/apartment/garden,
		"Apartment-Sauna" = /datum/map_template/hilbertshotel/apartment/sauna,
	)

/datum/controller/subsystem/inn/Initialize(start_timeofday)
	. = ..()
	InitRooms()

/datum/controller/subsystem/inn/proc/InitRooms()
	for(var/thingname in templates)
		var/datum/map_template/mate = new templates[thingname]

// /datum/controller/subsystem/inn/proc/InitRooms()





/datum/building_instance
	var/instance_name
	var/owner_quid
	var/is_public
	var/list/allowed_quids
	var/datum/map_template/instance_path
	var/datum/turf_reservation/roomReservation
	var/top_coord
	var/bottom_coord
	var/left_coord
	var/right_coord










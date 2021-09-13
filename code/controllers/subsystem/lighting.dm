GLOBAL_LIST_EMPTY(lighting_update_lights) // List of lighting sources  queued for update.
GLOBAL_LIST_EMPTY(lighting_update_corners) // List of lighting corners  queued for update.
GLOBAL_LIST_EMPTY(lighting_update_objects) // List of lighting objects queued for update.

SUBSYSTEM_DEF(lighting)
	name = "Lighting"
	wait = 6
	init_order = INIT_ORDER_LIGHTING

/datum/controller/subsystem/lighting/stat_entry(msg)
	msg = "L:[length(GLOB.lighting_update_lights)]|C:[length(GLOB.lighting_update_corners)]|O:[length(GLOB.lighting_update_objects)]"
	return ..()


/datum/controller/subsystem/lighting/Initialize(timeofday)
	if(!initialized)
		if (CONFIG_GET(flag/starlight))
			for(var/I in GLOB.sortedAreas)
				var/area/A = I
				if (A.dynamic_lighting == DYNAMIC_LIGHTING_IFSTARLIGHT)
					A.luminosity = 0

		create_all_lighting_objects()
		initialized = TRUE

	fire(FALSE, TRUE)

	return ..()

/datum/controller/subsystem/lighting/fire(resumed, init_tick_checks)
	MC_SPLIT_TICK_INIT(3)
	if(!init_tick_checks)
		MC_SPLIT_TICK
	var/list/queue = GLOB.lighting_update_lights
	while(length(queue))
		var/datum/light_source/light_datum = queue[length(queue)]
		queue.len--

		light_datum.update_corners()

		light_datum.needs_update = LIGHTING_NO_UPDATE

		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break

	if(!init_tick_checks)
		MC_SPLIT_TICK

	queue = GLOB.lighting_update_corners
	while(length(queue))
		var/datum/lighting_corner/corner_datum = queue[length(queue)]
		queue.len--

		corner_datum.update_objects()
		corner_datum.needs_update = FALSE
		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break

	if(!init_tick_checks)
		MC_SPLIT_TICK

	queue = GLOB.lighting_update_objects
	while(length(queue))
		var/atom/movable/lighting_object/lighting_object = queue[length(queue)]
		queue.len--

		if (QDELETED(lighting_object))
			continue

		lighting_object.update()
		lighting_object.needs_update = FALSE
		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break


/datum/controller/subsystem/lighting/Recover()
	initialized = SSlighting.initialized
	..()

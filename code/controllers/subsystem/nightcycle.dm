/*  6:00 AM 	- 	21600
	6:45 AM 	- 	24300
	11:45 AM 	- 	42300
	4:45 PM 	- 	60300
	9:45 PM 	- 	78300
	10:30 PM 	- 	81000 */
#define CYCLE_SUNRISE 	216000
#define CYCLE_MORNING 	243000
#define CYCLE_LATEMORN	333000
#define CYCLE_DAYTIME 	423000
#define CYCLE_AFTERNOON 603000
#define CYCLE_LATEAFTERNOON 653500
#define CYCLE_FULLSUNSET 710000
#define CYCLE_SUNSET 	783000
#define CYCLE_NIGHTTIME 810000

#define SUNRISE 0
#define MORNING 1
#define LATEMORN 2
#define DAYTIME 3
#define AFTERNOON 4
#define LATEAFTERNOON 5
#define SUNSET 6
#define FULLSUNSET 7
#define NIGHTTIME 8
#define DAY_END 9

SUBSYSTEM_DEF(nightcycle)
	name = "Day/Night Cycle"
	wait = 10 SECONDS
	// Control vars
	var/current_time = DAYTIME
	var/current_sun_color = "#bf9292"
	var/current_sun_power = 40

	// Variables for badmining
	var/sunrise_sun_color = "#4ca5f8"
	var/sunrise_sun_power = 95
	var/morning_sun_color = "#4ca5f8"
	var/morning_sun_power = 115
	var/latemorn_sun_color = "#4ca5f8"
	var/latemorn_sun_power = 125
	var/daytime_sun_color = "#4ca5f8"
	var/daytime_sun_power = 155
	var/afternoon_sun_color = "#4ca5f8"
	var/afternoon_sun_power = 120
	var/lateafternoon_sun_color = "#4ca5f8"
	var/lateafternoon_sun_power = 85
	var/sunset_sun_color = "#4ca5f8"
	var/sunset_sun_power = 105
	var/fullsunset_sun_color = "#4ca5f8"
	var/fullsunset_sun_power = 75
	var/nighttime_sun_color = "#4ca5f8"
	var/nighttime_sun_power = 65 

	/// If defined with any number besides null it will determine how long each cycle lasts.
//	var/custom_cycle_wait = 1600 SECONDS
	var/custom_cycle_wait
	var/last_custom_cycle = 0

	// Light objects
	var/atom/movable/sunlight/sunlight_source_object = new()
	var/list/atom/movable/sunlight/sunlight_border_objects = list()


/datum/controller/subsystem/nightcycle/Initialize(start_timeofday)
	. = ..()
	sunlight_source_object.alpha = current_sun_power
	sunlight_source_object.color = current_sun_color


/datum/controller/subsystem/nightcycle/fire(resumed = FALSE)
	var/new_time

	if (!isnull(custom_cycle_wait))
		if(last_custom_cycle + custom_cycle_wait >= world.time)
			return
		last_custom_cycle = world.time
		new_time = (current_time + 1) % DAY_END
	else
		switch (STATION_TIME(FALSE, world.time))
			if (CYCLE_SUNRISE to CYCLE_MORNING)
				new_time = SUNRISE
			if (CYCLE_MORNING to CYCLE_LATEMORN)
				new_time = MORNING
			if (CYCLE_LATEMORN to CYCLE_DAYTIME)
				new_time = LATEMORN
			if (CYCLE_DAYTIME to CYCLE_AFTERNOON)
				new_time = DAYTIME
			if (CYCLE_AFTERNOON to CYCLE_LATEAFTERNOON)
				new_time = AFTERNOON
			if (CYCLE_LATEAFTERNOON to CYCLE_FULLSUNSET)
				new_time = LATEAFTERNOON
			if (CYCLE_FULLSUNSET to CYCLE_SUNSET)
				new_time = SUNSET
			if (CYCLE_SUNSET to CYCLE_NIGHTTIME)
				new_time = FULLSUNSET
			else
				new_time = NIGHTTIME
		if (new_time == current_time)
			return

	switch (new_time)
		if (SUNRISE)
			current_sun_color = sunrise_sun_color
			current_sun_power = sunrise_sun_power
		if (MORNING)
			current_sun_color = morning_sun_color
			current_sun_power = morning_sun_power
			for(var/obj/structure/lamp_post/lamp as anything in GLOB.lamppost)
				lamp.icon_state = "[initial(lamp.icon_state)]"
				lamp.set_light_on(FALSE)
		if (LATEMORN)
			current_sun_color = latemorn_sun_color
			current_sun_power = latemorn_sun_power
		if (DAYTIME)
			current_sun_color = daytime_sun_color
			current_sun_power = daytime_sun_power
		if (AFTERNOON)
			current_sun_color = afternoon_sun_color
			current_sun_power = afternoon_sun_power
		if (LATEAFTERNOON)
			current_sun_color = lateafternoon_sun_color
			current_sun_power = lateafternoon_sun_power
		if (SUNSET)
			current_sun_color = sunset_sun_color
			current_sun_power = sunset_sun_power
		if (FULLSUNSET)
			current_sun_color = fullsunset_sun_color
			current_sun_power = fullsunset_sun_power
			for(var/obj/structure/lamp_post/lamp as anything in GLOB.lamppost)
				lamp.icon_state = "[initial(lamp.icon_state)]-on"
				lamp.set_light_on(TRUE)
		if(NIGHTTIME)
			//message_admins("Transitioning into night...")
			current_sun_color = nighttime_sun_color
			current_sun_power = nighttime_sun_power
		else
			CRASH("Invalid new_time returned from STATION_TIME()")

	current_time = new_time
	INVOKE_ASYNC(src,PROC_REF(AnimateTransition))
	CHECK_TICK

/datum/controller/subsystem/nightcycle/proc/AnimateTransition()
	var/atom/movable/sunlight/light_object = sunlight_source_object
	light_object.alpha = current_sun_power
	light_object.color = current_sun_color
	for(var/key in sunlight_border_objects)
		sunlight_border_objects[key]?.alpha = current_sun_power
		sunlight_border_objects[key]?.color = current_sun_color


/datum/controller/subsystem/nightcycle/proc/get_border_object(object_key)
	. = sunlight_border_objects["[object_key]"]
	if(!.)
		. = new /atom/movable/sunlight(null, current_sun_power, current_sun_color, object_key)
		sunlight_border_objects["[object_key]"] = .


/atom/movable/sunlight
	name = ""
	icon = 'icons/effects/light_overlays/sunlight_source.dmi'
	icon_state = "light"
	move_resist = INFINITY
	plane = O_LIGHTING_VISUAL_PLANE
	layer = SUNLIGHT_LAYER
	appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	invisibility = INVISIBILITY_LIGHTING
	alpha = 0
	vis_flags = NONE


/atom/movable/sunlight/Initialize(mapload, alpha = null, color = null, neighbors = null)
	. = ..()
	if(!isnull(neighbors))
		icon = 'icons/effects/light_overlays/border_lights.dmi'
		icon_state = "[neighbors]"
	if(!isnull(alpha))
		src.alpha = alpha
	if(!isnull(color))
		src.color = color


///Proc to initialize sunlight source turfs and affect non-source neighbors.
/turf/proc/setup_sunlight_source()
	vis_contents += SSnightcycle.sunlight_source_object
	luminosity = 1
	for(var/dir in GLOB.alldirs)
		var/turf/neighbor = get_step(src, dir)
		if(!neighbor || neighbor.sunlight_state != NO_SUNLIGHT)
			continue
		neighbor.sunlight_state = SUNLIGHT_BORDER
		if(neighbor.flags_1 & INITIALIZED_1)
			neighbor.smooth_sunlight_border()

//Proc to update the lighting of a single turf when a new plating is put down on a sunlight source turf
/turf/proc/setup_single_sunlight_source()
	vis_contents += SSnightcycle.sunlight_source_object
	luminosity = 1
	sunlight_state = SUNLIGHT_SOURCE //should be a value of 2

#define SUNLIGHT_ADJ_IN_DIR(source, junction, direction, direction_flag) \
	do { \
		var/turf/neighbor = get_step(source, direction); \
		if(!neighbor || neighbor.sunlight_state != SUNLIGHT_SOURCE) { \
			continue; \
		}; \
		junction |= direction_flag; \
	} while(FALSE)

#define	NORTHEAST_JUNCTION (1<<4)
#define	SOUTHEAST_JUNCTION (1<<5)
#define	SOUTHWEST_JUNCTION (1<<6)
#define	NORTHWEST_JUNCTION (1<<7)

/// Scans neighbors for sunlight sources and sets up the proper object to handle it.
/turf/proc/smooth_sunlight_border()
	var/new_junction = NONE
	for(var/direction in GLOB.cardinals) //Cardinal case first.
		SUNLIGHT_ADJ_IN_DIR(src, new_junction, direction, direction)
	SUNLIGHT_ADJ_IN_DIR(src, new_junction, NORTHWEST, NORTHWEST_JUNCTION)	//This used to be a bitfield but icon smoothing redefined the define into these strings.
	SUNLIGHT_ADJ_IN_DIR(src, new_junction, NORTHEAST, NORTHEAST_JUNCTION)	//NE (1>>4), SE (1>>5), SW (1>>6), NW (1>>7) respectively.
	SUNLIGHT_ADJ_IN_DIR(src, new_junction, SOUTHWEST, SOUTHWEST_JUNCTION)	//See Fortune 13 #5 and TGstation #53906 for this is probably broken.
	SUNLIGHT_ADJ_IN_DIR(src, new_junction, SOUTHEAST, SOUTHEAST_JUNCTION)
	if(new_junction == border_neighbors)
		return // No change.
	if(!isnull(border_neighbors)) // Different and non-null, there was a change.
		vis_contents -= SSnightcycle.get_border_object(border_neighbors)
	if(new_junction == NONE)
		if(sunlight_state == SUNLIGHT_BORDER)
			sunlight_state = NO_SUNLIGHT
		if(lighting_object)
			luminosity = 0 // Luminosity now depends on dynamic lighting.
		return // No longer a sunlight border.
	border_neighbors = new_junction
	luminosity = 1
	var/atom/movable/sunlight/light_object = SSnightcycle.get_border_object(new_junction)
	vis_contents += light_object


#define RE_SMOOTH_BORDER_NEIGHBORS(source) \
	do { \
		for(var/dir in GLOB.alldirs) { \
			var/turf/neighbor = get_step(source, dir); \
			if(!neighbor || neighbor.sunlight_state != SUNLIGHT_BORDER) { \
				continue; \
			} \
			if(neighbor.flags_1 & INITIALIZED_1) { \
				neighbor.smooth_sunlight_border(); \
			} \
		} \
	} while(FALSE)

/// Handles the cases of sunlight_state changing during ChangeTurf()
/turf/proc/handle_sunlight_state_change(old_sunlight_state)
	if(sunlight_state == old_sunlight_state)
		CRASH("handle_sunlight_state_change() called without an actual change.")
	switch(old_sunlight_state)
		if(NO_SUNLIGHT)
			switch(sunlight_state)
				if(SUNLIGHT_SOURCE)
					// The no-sunlight neighbors were turned into border during Initialize() already.
					//RE_SMOOTH_BORDER_NEIGHBORS(src)
					sunlight_state = NO_SUNLIGHT //you're indoors, behave and stop shining light everywhere
				//if(SUNLIGHT_BORDER)
				//	CRASH("Turf changed from no-sunlight to border on ChangeTurf(). No turf should be border by default.")
		if(SUNLIGHT_SOURCE)
			switch(sunlight_state)
				if(NO_SUNLIGHT)
					// Have them decide whether they're still border or not.
					//RE_SMOOTH_BORDER_NEIGHBORS(src)
					setup_single_sunlight_source() //light yourself up, but don't bother your neighbors
				//if(SUNLIGHT_BORDER)
				//	CRASH("Turf changed from sunlight-source to border on ChangeTurf(). No turf should be border by default.")
		if(SUNLIGHT_BORDER)
			switch(sunlight_state)
				if(NO_SUNLIGHT)
					sunlight_state = SUNLIGHT_BORDER
					border_neighbors = null // This is already null by default, but eh.
					smooth_sunlight_border() // Are we still a border neighbor?
				if(SUNLIGHT_SOURCE)
					// Only the no-sunlight neighbors were were updated during Initialize(). Let's update the rest.
					RE_SMOOTH_BORDER_NEIGHBORS(src)


#undef RE_SMOOTH_BORDER_NEIGHBORS
#undef SUNLIGHT_ADJ_IN_DIR
#undef CYCLE_SUNRISE
#undef CYCLE_MORNING
#undef CYCLE_LATEMORN
#undef CYCLE_DAYTIME
#undef CYCLE_AFTERNOON
#undef CYCLE_LATEAFTERNOON
#undef CYCLE_FULLSUNSET
#undef CYCLE_SUNSET
#undef CYCLE_NIGHTTIME
#undef SUNRISE
#undef MORNING
#undef DAYTIME
#undef LATEMORN
#undef AFTERNOON
#undef LATEAFTERNOON
#undef FULLSUNSET
#undef SUNSET
#undef NIGHTTIME
#undef DAY_END

#undef	NORTHEAST_JUNCTION
#undef	SOUTHEAST_JUNCTION
#undef	SOUTHWEST_JUNCTION
#undef	NORTHWEST_JUNCTION

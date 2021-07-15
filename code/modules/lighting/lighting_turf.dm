/turf
	var/dynamic_lighting = TRUE
	luminosity           = 1

	var/tmp/lighting_corners_initialised = FALSE

	var/tmp/list/datum/light_source/affecting_lights       // List of light sources affecting this turf.
	var/tmp/atom/movable/lighting_object/lighting_object // Our lighting object.
	var/tmp/datum/lighting_corner/lc_topleft
	var/tmp/datum/lighting_corner/lc_topright
	var/tmp/datum/lighting_corner/lc_bottomleft
	var/tmp/datum/lighting_corner/lc_bottomright

// counterclockwisse 0 to 360
#define PROC_ON_CORNERS(operation) lc_topright?.##operation;lc_bottomright?.##operation;lc_bottomleft?.##operation;lc_topleft?.##operation

// Causes any affecting light sources to be queued for a visibility update, for example a door got opened.
/turf/proc/reconsider_lights()
	var/datum/light_source/L
	var/thing
	for (thing in affecting_lights)
		L = thing
		L.vis_update()

/turf/proc/lighting_clear_overlay()
	if (lighting_object)
		qdel(lighting_object, TRUE)

	PROC_ON_CORNERS(update_active())

// Builds a lighting object for us, but only if our area is dynamic.
/turf/proc/lighting_build_overlay()
	if (lighting_object)
		qdel(lighting_object,force=TRUE) //Shitty fix for lighting objects persisting after death

	var/area/A = loc
	if (!IS_DYNAMIC_LIGHTING(A) && !light_sources)
		return

	if (!lighting_corners_initialised)
		generate_missing_corners()

	new/atom/movable/lighting_object(src)

	var/datum/light_source/S
	var/i
#define OPERATE(corner) \
	if(corner && !corner.active) { \
		for(i in corner.affecting) { \
			S = i ; \
			S.recalc_corner(corner) \
		} \
		corner.active = TRUE \
	}
	OPERATE(lc_topright)
	OPERATE(lc_bottomright)
	OPERATE(lc_bottomleft)
	OPERATE(lc_topleft)
#undef OPERATE


/// Returns the luminosity scale of the turf, a float beween 0 and 1.
/turf/proc/get_lumcount()
	var/area/turf_loc = loc
	if(!IS_DYNAMIC_LIGHTING(turf_loc))
		return 1 // Non-dynamic lighting is always full bright.

	. = 0

	switch(sunlight_state)
		if (SUNLIGHT_SOURCE)
			. += (SSnightcycle.current_sun_power / 255) // 255 is the maximum alpha value.
		if (SUNLIGHT_BORDER)
			. += ((SSnightcycle.current_sun_power * 0.5) / 255) // Half the intensity if not directly under the sun.

	if (lighting_object)
		. += ( \
			(lc_topright ? (lc_topright.lum_r + lc_topright.lum_g + lc_topright.lum_b) : 0) \
			+ (lc_bottomright ? (lc_bottomright.lum_r + lc_bottomright.lum_g + lc_bottomright.lum_b) : 0) \
			+ (lc_bottomleft ? (lc_bottomleft.lum_r + lc_bottomleft.lum_g + lc_bottomleft.lum_b) : 0) \
			+ (lc_topleft ? (lc_topleft.lum_r + lc_topleft.lum_g + lc_topleft.lum_b) : 0) \
			) / 12 // 4 corners, each with 3 channels, get the average.

	. += dynamic_lumcount

	return CLAMP01(.)


// Returns a boolean whether the turf is on soft lighting.
// Soft lighting being the threshold at which point the overlay considers
// itself as too dark to allow sight and see_in_dark becomes useful.
// So basically if this returns true the tile is unlit black.
/turf/proc/is_softly_lit()
	if (!lighting_object)
		return FALSE

	return !(lighting_object.luminosity || dynamic_lumcount)


/turf/proc/set_base_opacity(new_base_opacity)
	if(base_opacity == new_base_opacity)
		return
	. = base_opacity
	base_opacity = new_base_opacity
	recalculate_directional_opacity()


///Proc to add movable sources of opacity on the turf and let it handle lighting code.
/turf/proc/add_opacity_source(atom/movable/new_source)
	LAZYADD(opacity_sources, new_source)
	if(directional_opacity == ALL_CARDINALS) //Already opaque, no need to worry on updating.
		return
	recalculate_directional_opacity()


///Proc to remove movable sources of opacity on the turf and let it handle lighting code.
/turf/proc/remove_opacity_source(atom/movable/old_source)
	LAZYREMOVE(opacity_sources, old_source)
	if(base_opacity) //Opaque turf, the contents in it are irrelevant.
		return
	recalculate_directional_opacity()


///Calculate on which directions this turfs block view.
/turf/proc/recalculate_directional_opacity()
	. = directional_opacity
	if(base_opacity)
		set_directional_opacity(ALL_CARDINALS)
		return
	var/new_directional_opacity = NONE
	for(var/atom/movable/opacity_source as anything in opacity_sources)
		if(opacity_source.flags_1 & ON_BORDER_1)
			new_directional_opacity |= opacity_source.dir
		else //If fulltile and opaque, then the whole tile blocks view, no need to continue checking.
			new_directional_opacity = ALL_CARDINALS
			break
	set_directional_opacity(new_directional_opacity)


/turf/proc/set_directional_opacity(new_directional_opacity)
	if(directional_opacity == new_directional_opacity)
		return
	. = directional_opacity
	directional_opacity = new_directional_opacity
	if(new_directional_opacity == ALL_CARDINALS)
		set_opacity(TRUE)
		reconsider_lights()
	else
		set_opacity(base_opacity)
		if(. == ALL_CARDINALS)
			reconsider_lights() //The lighting system only cares whether the tile is fully concealed from all directions or not.


/turf/proc/change_area(area/old_area, area/new_area)
	if(SSlighting.initialized)
		if (new_area.dynamic_lighting != old_area.dynamic_lighting)
			if (new_area.dynamic_lighting)
				lighting_build_overlay()
			else
				lighting_clear_overlay()

/turf/proc/generate_missing_corners()
	if (!IS_DYNAMIC_LIGHTING(src) && !light_sources)
		return
	lighting_corners_initialised = TRUE
	// counterclockwise from 0 to 360.
	if(!lc_topright)
		new /datum/lighting_corner(src, NORTHEAST)
	if(!lc_bottomright)
		new /datum/lighting_corner(src, SOUTHEAST)
	if(!lc_bottomleft)
		new /datum/lighting_corner(src, SOUTHWEST)
	if(!lc_topleft)
		new /datum/lighting_corner(src, NORTHWEST)

#undef PROC_ON_CORNERS

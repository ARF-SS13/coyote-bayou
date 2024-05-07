// [NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST] == [1, 2, 4, 8, 5, 9, 6, 10]

/// autoturfs. they check their surroundings for other turfs and add suffixes
///	to their iconstate that denote which sprite to use.
///	i.e. "_N" means the northern turf should be a border.
/turf/open/autoturf
	var/static/list/suffixes = list("_N", "_S", "_E", "_W", "_NE", "_NW", "_SE", "_SW")
	var/iconstate_ext = ""
	var/always_check_diags = FALSE

/turf/open/autoturf/Initialize(mapload)
	var/i = 1
	for(var/tocheck in GLOB.cardinals)
		if(!checkdir(tocheck))
			iconstate_ext += suffixes[i]
		i += 1
	if(always_check_diags || !length(iconstate_ext))
		var/j = 5
		for(var/checkdiag in GLOB.diagonals)
			if(!checkdir(checkdiag))
				iconstate_ext += suffixes[j]
			j += 1
	
	icon_state += iconstate_ext

/turf/open/autoturf/proc/checkdir(tocheck)
	var/turf/open/checkturf = get_step(src, tocheck)
	if(istype(checkturf, src.type))
		return TRUE
	return FALSE

/turf/open/autoturf/sidewalk/clean
	icon = 'code/modules/fallout/turf/autoturficons/sidewalk.dmi'
	icon_state = "clean"

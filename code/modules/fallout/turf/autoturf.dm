// [NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST] == [1, 2, 4, 8, 5, 9, 6, 10]

/// autoturfs. they check their surroundings for other turfs and add suffixes
///	to their iconstate that denote which sprite to use.
/turf/open/autoturf

	// left_corners[i] means that when the border is in the i direction, this corner will be behind and considered "left".
	var/static/list/left_corners = list(10, 5, null, 9, null, null, null, 6)
	// other side of left_corners
	var/static/list/right_corners = list(6, 9, null, 10, null, null, null, 5)
	// opposites[i] is the dir opposite to i
	var/static/list/opposites = list(2, 1, null, 8, 10, 9, null, 4, 6, 5)
	// included_diags[i] means that i is included in both of these diagonals.
	var/static/list/included_diags = list(list(5, 9), list(6, 10), null, list(5, 6), null, null, null, list(9, 10))
	// threeside_conversion[NORTH] = WEST + NORTH + EAST (three adjacent sides, with the index as the middle dir)
	var/static/list/threeside_conversion = list(13, 14, null, 7, null, null, null, 11)
	// twocorner_conversion[NORTH] = NORTHWEST * NORTHEAST
	var/static/list/twocorner_conversion = list(45, 60, null, 30, null, null, null, 90)
	// threecorner_conversion[i] means the diagonal directions for the _threecorners sprite multiply to this number
	var/static/list/threecorner_conversion = list(270, 540, null, 300, null, null, null, 450)
	var/iconstate_ext = ""

/turf/open/autoturf/Initialize(mapload)
	. = ..()

	var/list/foundcardinals = list()
	var/list/founddiags = list()

	for(var/dirtocheck in GLOB.cardinals)
		if(!check_dir(dirtocheck))
			foundcardinals += dirtocheck
			
	if(length(foundcardinals) < 3)
		for(var/diagtocheck in GLOB.diagonals)
			if(!check_dir(diagtocheck))
				var/addit = TRUE
				for(var/cardinal in foundcardinals)
					if(diagtocheck in included_diags[cardinal])
						addit = FALSE
						break
				if(addit)
					founddiags += diagtocheck



	var/numcardinals = foundcardinals.len
	var/cardinalsum = 0
	for(var/X in foundcardinals)
		cardinalsum += X
	
	var/numdiags = founddiags.len
	var/diagmult = 1
	for(var/Y in founddiags)
		diagmult *= Y

	switch(numcardinals)
		if(0)
			switch(numdiags)
				if(1)
					iconstate_ext += "_onecorner"
					dir = diagmult
				if(2)
					if(opposites[founddiags[1]] == founddiags[2])
						iconstate_ext += "_oppcorners"
						dir = founddiags[1]
					else
						iconstate_ext += "_twocorners"
						dir = twocorner_conversion.Find(diagmult)
				if(3)
					iconstate_ext += "_threecorners"
					dir = threecorner_conversion.Find(diagmult)
				if(4)
					iconstate_ext += "_fourcorners"
		if(1)
			iconstate_ext += "_oneside"
			dir = cardinalsum
			switch(numdiags)
				if(1)
					if(left_corners[cardinalsum] == diagmult)
						iconstate_ext += "_leftcorner"
					else if(right_corners[cardinalsum] == diagmult)
						iconstate_ext += "_rightcorner"
				if(2)
					if(included_diags[opposites[cardinalsum]] == founddiags)
						iconstate_ext += "_twocorners"
		if(2)
			if(opposites[foundcardinals[1]] == foundcardinals[2])
				iconstate_ext += "_oppsides"
				dir = foundcardinals[1]
			else
				iconstate_ext += "_twosides"
				dir = cardinalsum
				if(numdiags)
					iconstate_ext += "_onecorner"
		if(3)
			iconstate_ext += "_threesides"
			dir = threeside_conversion.Find(cardinalsum)
		if(4)
			iconstate_ext += "_foursides"
	
	icon_state += iconstate_ext


/// returns TRUE if the checked turf should be connected. returns false otherwise.
/turf/open/autoturf/proc/check_dir(tocheck)
	. = FALSE
	var/turf/open/checkturf = get_step(src, tocheck)
	if(istype(checkturf, src.type))
		. =  TRUE



/turf/open/autoturf/expensive
	var/list/weighted_iconstates
	var/list/connect_whitelist

/turf/open/autoturf/expensive/Initialize(mapload)
	if(weighted_iconstates)
		pickweight(weighted_iconstates)
	. = ..()

// running this extra list iteration is definitely gonna raise overhead.
/turf/open/autoturf/expensive/check_dir(tocheck)
	. = FALSE
	var/turf/checkturf = get_step(src, tocheck)
	if(istype(checkturf, src.type))
		return TRUE
	for(var/whitelistedtype in connect_whitelist)
		if(istype(checkturf, whitelistedtype))
			. = TRUE

/turf/open/autoturf/expensive/sidewalk/clean
	icon = 'code/modules/fallout/turf/autoturficons/sidewalk.dmi'
	icon_state = "clean"
	connect_whitelist = list(/turf/closed/wall)

/turf/open/autoturf/expensive/sidewalk/check_dir(tocheck)
	. = ..()
	var/turf/checkturf = get_step(src, tocheck)
	if(locate(/obj/structure/window) in checkturf)
		return TRUE

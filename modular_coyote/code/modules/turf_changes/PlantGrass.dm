// Refactors plant grass to work on multiple turfs.
// I'm going to grab you by the antlers and stick every point of it up your ass

// pascal deez nuts
/turf/open/proc/spawnRandThing()
	if(locate(/mob) in src)
		return FALSE
	if((locate(/obj/structure) in src))
		return FALSE
	if((locate(/obj/machinery) in src))
		return FALSE

	var/thingtype
	if(spawnPlants && prob(RAND_PLANT_CHANCE))
		thingtype = "plant"
	else if(spawnHiddenStashes && prob(HIDDEN_STASH_CHANCE))
		thingtype = "stash"
	else if(greeble)
		var/area/A = get_area(src)
		if(!A.safe_town)
			if(islist(greeble))
				thingtype = pickweight(greeble)
			else
				thingtype = greeble
		greeble = null //clear this var up since it's never used again
	if(!thingtype)
		return FALSE
	if(thingtype == "junklist")
		thingtype = pickweight(GLOB.junk_type_weighted)		
	var/atom/movable/randThing
	switch(thingtype)
		if("plant")
			thingtype = pickweight(GLOB.plant_type_weighted)
			switch(thingtype)
//				if("medicinal")
//					randThing = pickweight(GLOB.medicinal_plant_list)
				if("tree")
					randThing = pickweight(GLOB.tree_plant_list)
				if("grass")
					randThing = pickweight(GLOB.grass_plant_list)
		if("stash")
			return StashCheck(skip_roll = TRUE, skip_checks = TRUE)
		if("trash")
			randThing = pickweight(GLOB.trash_spawn_list)
		if("dust")
			randThing = pickweight(GLOB.dust_spawn_list)
		if("salvage")
			randThing = pickweight(GLOB.salvage_spawn_list)
		if("nest")
			randThing = pickweight(GLOB.nest_spawn_list)
		if("wreckage_and_nests")
			var/list/nestnwreck = GLOB.nest_spawn_list
			nestnwreck |= GLOB.salvage_spawn_list
			randThing = pickweight(nestnwreck)
	if(randThing)
		new randThing(src)
		return TRUE

///Rolls to spawn a hidden stash on this turf
/turf/open/proc/StashCheck(skip_roll = FALSE, skip_checks = FALSE)
	if(!skip_roll && !prob(HIDDEN_STASH_CHANCE))
		return FALSE
	if(!skip_checks)
		if((locate(/obj/structure) in src))
			return FALSE
		if((locate(/obj/machinery) in src))
			return FALSE
		if((locate(/mob/living) in src))
			return FALSE
	new /obj/structure/lootable/hidden_stash(src)
	return TRUE

/turf/open/
	var/spawnPlants = FALSE
	var/spawnHiddenStashes = FALSE
	/// Type of random stuff to spawn on a turf. Supports weighted lists.
	var/greeble

/turf/open/Initialize(mapload)
	if(mapload && !is_reserved_level(z) && (spawnPlants || greeble || spawnHiddenStashes))
		spawnRandThing()
	. = ..()

/turf/open/ChangeTurf(path, new_baseturf, flags)
	for(var/obj/structure/flora/turfPlant in contents)
		qdel(turfPlant)
	. =  ..()

#define OUTSIDE_JUNK_DISTRIBUTION list("nest" = 1, "salvage" = 2, "trash" = 2, "nothing" = 95)

/turf/open/indestructible/ground/outside/dirt
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE
	greeble = OUTSIDE_JUNK_DISTRIBUTION

/turf/open/indestructible/ground/outside/savannah
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE
	greeble = OUTSIDE_JUNK_DISTRIBUTION

/turf/open/indestructible/ground/outside/dirt_s
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE
	greeble = OUTSIDE_JUNK_DISTRIBUTION

/turf/open/indestructible/ground/outside/grass_s
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE
	greeble = OUTSIDE_JUNK_DISTRIBUTION

/turf/open/indestructible/ground/outside/desert
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE
	greeble = OUTSIDE_JUNK_DISTRIBUTION

/turf/open/floor/plating/f13/outside/desert
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE
	greeble = OUTSIDE_JUNK_DISTRIBUTION

#undef OUTSIDE_JUNK_DISTRIBUTION

// Refactors plant grass to work on multiple turfs.
// I'm going to grab you by the antlers and stick every point of it up your ass

// pascal deez nuts
/turf/open/proc/plantGrass(Plantforce = FALSE)
	if(!prob(RAND_PLANT_CHANCE))
		return FALSE
	if(locate(/obj/structure/flora) in src)
		return FALSE
	if((locate(/obj/structure) in src))
		return FALSE
	if((locate(/obj/machinery) in src))
		return FALSE
	var/atom/movable/randPlant
	var/floratype = greeble ? greeble : pickweight(GLOB.plant_type_weighted)
	if(greeble == "junklist")
		floratype = pickweight(GLOB.junk_type_weighted)
	switch(floratype)
		if("medicinal")
			randPlant = pickweight(GLOB.medicinal_plant_list)
		if("tree")
			randPlant = pickweight(GLOB.tree_plant_list)
		if("grass")
			randPlant = pickweight(GLOB.grass_plant_list)
		if("salvage")
			randPlant = pickweight(GLOB.salvage_spawn_list)
		if("nest")
			randPlant = pickweight(GLOB.nest_spawn_list)
		if("dust")
			randPlant = pickweight(GLOB.dust_spawn_list)
		if("trash")
			randPlant = pickweight(GLOB.trash_spawn_list)
		if("wreckage_and_nests")
			var/list/nestnwreck = GLOB.nest_spawn_list
			nestnwreck |= GLOB.salvage_spawn_list
			randPlant = pickweight(nestnwreck)
	if(randPlant)
		new randPlant(src)
		return TRUE

///Rolls to spawn a hidden stash on this turf
/turf/open/proc/StashCheck()
	if(!prob(HIDDEN_STASH_CHANCE))
		return FALSE
	if((locate(/obj/structure) in src))
		return FALSE
	if((locate(/obj/machinery) in src))
		return FALSE
	
	new /obj/structure/lootable/hidden_stash(src)
	return TRUE

/turf/open/
	var/spawnPlants = FALSE
	var/spawnHiddenStashes = FALSE
	var/greeble

/turf/open/Initialize(mapload)
	if(mapload && (spawnPlants || greeble) && !is_reserved_level(z))
		if(greeble)
			var/area/here = loc
			if(!here.safe_town)
				plantGrass()
		else
			plantGrass()
	if(mapload && spawnHiddenStashes && !is_reserved_level(z))
		StashCheck()
	. = ..()

/turf/open/ChangeTurf(path, new_baseturf, flags)
	for(var/obj/structure/flora/turfPlant in contents)
		qdel(turfPlant)
	. =  ..()

/turf/open/indestructible/ground/outside/dirt
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE

/turf/open/indestructible/ground/outside/savannah
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE

/turf/open/indestructible/ground/outside/dirt_s
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE

/turf/open/indestructible/ground/outside/grass_s
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE

/turf/open/indestructible/ground/outside/desert
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE

/turf/open/floor/plating/f13/outside/desert
	spawnPlants = TRUE
	spawnHiddenStashes = TRUE

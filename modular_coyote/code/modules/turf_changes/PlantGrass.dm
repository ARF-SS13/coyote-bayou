// Refactors plant grass to work on multiple turfs.

/turf/open/proc/plantGrass(Plantforce = FALSE)
	var/Weight = 0
	var/randPlant = null

	//spontaneously spawn grass
	if(Plantforce || prob(GRASS_SPONTANEOUS_GROUND))
		randPlant = pickweight(LUSH_PLANT_SPAWN_LIST_GROUND) //Create a new grass object at this location, and assign var
		turfPlant = new randPlant(src)
		. = TRUE //in case we ever need this to return if we spawned
		return .

	//loop through neighbouring desert turfs, if they have grass, then increase weight
	for(var/turf/open/indestructible/ground/T in RANGE_TURFS(3, src))
		if(istype(T, src))
			if(T.turfPlant)
				Weight += GRASS_WEIGHT

	//use weight to try to spawn grass
	if(prob(Weight))

		//If surrounded on 5+ sides, pick from lush
		if(Weight == (5 * GRASS_WEIGHT))
			randPlant = pickweight(LUSH_PLANT_SPAWN_LIST_GROUND)
		else
			randPlant = pickweight(DESOLATE_PLANT_SPAWN_LIST_GROUND)
		turfPlant = new randPlant(src)
		. = TRUE

/turf/open/
	var/spawnPlants = FALSE
	var/obj/structure/flora/turfPlant = null

/turf/open/Initialize()
	. = ..()
	
	if(spawnPlants)
		if(!((locate(/obj/structure) in src) || (locate(/obj/machinery) in src)))
			plantGrass()

/turf/open/ChangeTurf(path, new_baseturf, flags)
	if(turfPlant)
		qdel(turfPlant)
	. =  ..()

/turf/open/indestructible/ground/outside/dirt
	spawnPlants = TRUE

/turf/open/indestructible/ground/outside/savannah
	spawnPlants = TRUE

/turf/open/indestructible/ground/outside/dirt_s
	spawnPlants = TRUE

/turf/open/indestructible/ground/outside/grass_s
	spawnPlants = TRUE

/turf/open/indestructible/ground/outside/desert
	spawnPlants = TRUE

/turf/open/floor/plating/f13/outside/desert
	spawnPlants = TRUE

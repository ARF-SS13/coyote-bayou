//Fallout 13 floor plating directory

/turf/open/floor/plating/wooden
	name = "house base"
	icon_state = "housebase"
	icon = 'icons/fallout/turfs/ground.dmi'
	intact = 0
	global_lookup = "housebase"
//	step_sounds = list("human" = "woodfootsteps")

/turf/open/floor/plating/wooden/make_plating()
	return src

/turf/open/floor/plating/tunnel
	name = "metal floor"
	icon_state = "tunneldirty"
	icon = 'icons/fallout/turfs/ground.dmi'
	baseturfs = /turf/open/indestructible/ground/inside/mountain

/turf/open/floor/plating/wooden2
	name = "ravaged interior"
	icon_state = "housewood1"
	icon = 'modular_coyote/icons/turfs/ruinfloors.dmi'
	global_lookup = "houseinterior"
	intact = 0
//	step_sounds = list("human" = "woodfootsteps")

/turf/open/floor/plating/wooden3
	name = "ravaged carpet"
	icon_state = "carpet"
	icon = 'modular_coyote/icons/turfs/ruinfloors.dmi'
	intact = 0
	global_lookup = "housecarpet"
//	step_sounds = list("human" = "woodfootsteps")


/turf/open/floor/plating/rockcrete_slab
	name = "rockcrete"
	icon_state = "rockcrete_slab"
	icon = 'modular_coyote/icons/turfs/rockcrete_floors.dmi'
	intact = 0
	global_lookup = "rockcrete"

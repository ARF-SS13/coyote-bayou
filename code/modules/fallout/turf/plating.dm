//Fallout 13 floor plating directory

/turf/open/floor/plating/wooden
	name = "house base"
	icon_state = "housebase"
	icon = 'icons/fallout/turfs/ground.dmi'
	intact = 0
	broken_states = list("housebase1-broken", "housebase2-broken", "housebase3-broken", "housebase4-broken")
	burnt_states = list("housebase_burnt")
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
	intact = 0
	broken_states = list("housewood-dam1", "housewood-dam2", "housewood-dam3", "housewood-dam4", "housewood-dam5")
//	step_sounds = list("human" = "woodfootsteps")

/turf/open/floor/plating/wooden3
	name = "ravaged carpet"
	icon_state = "carpet"
	icon = 'modular_coyote/icons/turfs/ruinfloors.dmi'
	intact = 0
	broken_states = list("torncarpet1", "torncarpet2", "torncarpet3", "torncarpet4", "torncarpet5", "torncarpet6", "torncarpet7", "torncarpet8", "torncarpet9", "torncarpet10", "torncarpet11", "torncarpet12", "torncarpet13", "torncarpet14", "torncarpet15", "torncarpet16", "damaged1")
	burnt_states = list("damaged")
//	step_sounds = list("human" = "woodfootsteps")


/turf/open/floor/plating/rockcrete_slab
	name = "rockcrete"
	icon_state = "rockcrete_slab"
	icon = 'modular_coyote/icons/turfs/rockcrete_floors.dmi'
	intact = 0
	broken_states = list("rockcrete_slab_dmg1", "rockcrete_slab_dmg2", "rockcrete_slab_dmg3", "rockcrete_slab_dmg4")

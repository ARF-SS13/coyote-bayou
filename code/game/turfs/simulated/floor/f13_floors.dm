/* Fallout stuff*/
/* Also, a terrain class or something needs to be used as the common parent  for asteroid and outside */
/* lazy Saturday coding */

/*	Planetary atmos makes the gas infinite basicaly, if you're siphoning it, the world will
	just spawn more.
*/

/turf/open/floor/plating/f13 // don't use this for anything, /f13/ is essentially just the new /unsimulated/ but for planets and should probably be phased out entirely everywhere
	gender = PLURAL
	baseturfs = /turf/open/floor/plating/f13
	attachment_holes = FALSE
	planetary_atmos = TRUE

/* so we can't break this */
/turf/open/floor/plating/f13/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/f13/burn_tile()
	return

/turf/open/floor/plating/f13/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/f13/MakeDry()
	return

/turf/open/floor/plating/f13/outside
	name = "What the fuck mappers? why is this here"
	desc = "If found, scream at the github repo about this"
	icon_state = "wasteland1"
	icon = 'icons/turf/f13desert.dmi'
	sunlight_state = SUNLIGHT_SOURCE

/* Outside turfs get global lighting */
/turf/open/floor/plating/f13/outside/Initialize()
	. = ..()
	flags_2 |= GLOBAL_LIGHT_TURF_2

#define GRASS_SPONTANEOUS 		2
#define GRASS_WEIGHT 			4
#define LUSH_PLANT_SPAWN_LIST list(/obj/structure/flora/grass/wasteland = 10, /obj/structure/flora/wasteplant/wild_broc = 7, /obj/structure/flora/wasteplant/wild_mesquite = 4, /obj/structure/flora/wasteplant/wild_feracactus = 5, /obj/structure/flora/wasteplant/wild_punga = 5, /obj/structure/flora/wasteplant/wild_coyote = 5, /obj/structure/flora/wasteplant/wild_tato = 5, /obj/structure/flora/wasteplant/wild_yucca = 5, /obj/structure/flora/wasteplant/wild_mutfruit = 5, /obj/structure/flora/wasteplant/wild_prickly = 5, /obj/structure/flora/wasteplant/wild_datura = 5, /obj/structure/flora/wasteplant/wild_buffalogourd = 5, /obj/structure/flora/wasteplant/wild_pinyon = 3, /obj/structure/flora/wasteplant/wild_xander = 5, /obj/structure/flora/wasteplant/wild_agave = 5, /obj/structure/flora/tree/joshua = 3, /obj/structure/flora/tree/cactus = 2, /obj/structure/flora/tree/wasteland = 2)
#define DESOLATE_PLANT_SPAWN_LIST list(/obj/structure/flora/grass/wasteland = 1)

/turf/open/floor/plating/f13/outside/desert
	name = "\proper desert"
	desc = "A stretch of desert."
	icon = 'icons/turf/f13desert.dmi'
	icon_state = "wasteland1"

	archdrops = list(/obj/item/stack/ore/glass = list(ARCH_PROB = 100,ARCH_MAXDROP = 5)) //sand
	var/obj/structure/flora/turfPlant = null
	slowdown = 0
	var/dug = FALSE				//FALSE = has not yet been dug, TRUE = has already been dug
	var/pit_sand = 2
	var/storedindex = 0			//amount of stored items
	var/mob/living/gravebody	//is there a body in the pit?
	var/obj/structure/closet/crate/coffin/gravecoffin //or maybe a coffin?
	var/pitcontents = list()
	var/obj/dugpit/mypit
	var/unburylevel = 0

/turf/open/floor/plating/f13/outside/desert/Initialize()
	. = ..()
	icon_state = "wasteland[rand(1,31)]"

//Make sure we delete the plant if we ever change turfs
/turf/open/floor/plating/f13/outside/desert/ChangeTurf(path, new_baseturf, flags)
	if(turfPlant)
		qdel(turfPlant)
	. =  ..()

/turf/open/floor/plating/f13/outside/desert/harsh
	icon_state = "wasteland"
	icon = 'icons/fallout/turfs/ground_harsh.dmi'

/turf/open/floor/plating/f13/outside/desert/harsh/Initialize()
	. = ..()
	icon_state = "wasteland[rand(1,31)]"

/turf/open/floor/plating/f13/outside/road
	name = "\proper road"
	desc = "A stretch of road."
	icon = 'icons/turf/f13road.dmi'
	icon_state = "outermiddle"

/turf/open/floor/plating/f13/outside/road/harsh
	icon = 'icons/fallout/turfs/f13roadharsh.dmi'
	icon_state = "outerpavement"

//GRAVEL INDOORS
/turf/open/floor/plating/f13/inside/gravel
	name = "gravel"
	desc = "Small pebbles, lots of them."
	icon = 'icons/fallout/turfs/ground.dmi'
	icon_state = "gravel"

/turf/open/floor/plating/f13/inside/gravel/edge
	icon_state = "graveledge"

/turf/open/floor/plating/f13/inside/gravel/corner
	icon_state = "gravelcorner"


//GRAVEL OUTDOORS
/turf/open/floor/plating/f13/inside/gravel
	name = "gravel"
	desc = "Small pebbles, lots of them."
	icon = 'icons/fallout/turfs/ground.dmi'
	icon_state = "gravel"
	sunlight_state = SUNLIGHT_SOURCE

/turf/open/floor/plating/f13/inside/gravel/edge
	icon_state = "graveledge"

/turf/open/floor/plating/f13/inside/gravel/corner
	icon_state = "gravelcorner"


//New standard wood floor for most areas, oak for Legion and pure log cabins only, maple for NCR and mayor only, maybe a diner.

#define SHROOM_SPAWN	1

/turf/open/floor/plating/f13/inside/mountain
	name = "mountain"
	desc = "Damp cave flooring."
	icon = 'icons/turf/f13floors2.dmi'
	icon_state = "mountain0"
	var/obj/structure/flora/turfPlant = null

/turf/open/floor/plating/f13/inside/mountain/Initialize()
	. = ..()
	icon_state = "mountain[rand(0,10)]"
	//If no fences, machines, etc. try to plant mushrooms
	if(!(\
			(locate(/obj/structure) in src) || \
			(locate(/obj/machinery) in src) ))
		plantShrooms()

/turf/open/floor/plating/f13/inside/mountain/proc/plantShrooms()
	if(prob(SHROOM_SPAWN))
		turfPlant = new /obj/structure/flora/wasteplant/wild_fungus(src)
		. = TRUE //in case we ever need this to return if we spawned
		return.

/turf/open/floor/plasteel/f13/vault_floor
	name = "vault floor"
	icon = 'icons/turf/f13floors2.dmi'
	icon_state = "vault_floor"
	planetary_atmos = FALSE // They're _inside_ a vault.

/turf/open/floor/plasteel/f13/vault_floor/plating
	icon_state = "plating"

/turf/open/floor/plasteel/f13/vault_floor/floor
	icon_state = "floor"

/turf/open/floor/plasteel/f13/vault_floor/floor/floorsolid
	icon_state = "floorsolid"

	/* DARK TILES */

/turf/open/floor/plasteel/f13/vault_floor/dark
	icon_state = "dark"

/turf/open/floor/plasteel/f13/vault_floor/dark/darksolid
	icon_state = "darksolid"

	/* WHITE TILES */

/turf/open/floor/plasteel/f13/vault_floor/white
	icon_state = "white"

/turf/open/floor/plasteel/f13/vault_floor/white/whitesolid
	icon_state = "whitesolid"

	/* RED TILES */

/turf/open/floor/plasteel/f13/vault_floor/red
	icon_state = "redfull"

/turf/open/floor/plasteel/f13/vault_floor/red/whiteredfull
	icon_state = "whiteredfull"

/turf/open/floor/plasteel/f13/vault_floor/red/side
	icon_state = "red"

/turf/open/floor/plasteel/f13/vault_floor/red/corner
	icon_state = "redcorner"

/turf/open/floor/plasteel/f13/vault_floor/red/redchess
	icon_state = "redchess"

/turf/open/floor/plasteel/f13/vault_floor/red/redchess/redchess2
	icon_state = "redchess2"

/turf/open/floor/plasteel/f13/vault_floor/red/white/side
	icon_state = "whitered"

/turf/open/floor/plasteel/f13/vault_floor/red/white/corner
	icon_state = "whiteredcorner"

/turf/open/floor/plasteel/f13/vault_floor/red/white/whiteredchess
	icon_state = "whiteredchess"

/turf/open/floor/plasteel/f13/vault_floor/red/white/whiteredchess/whiteredchess2
	icon_state = "whiteredchess2"

	/* BLUE TILES */

/turf/open/floor/plasteel/f13/vault_floor/blue
	icon_state = "bluefull"

/turf/open/floor/plasteel/f13/vault_floor/blue/whitebluefull
	icon_state = "whitebluefull"

/turf/open/floor/plasteel/f13/vault_floor/blue/side
	icon_state = "blue"

/turf/open/floor/plasteel/f13/vault_floor/blue/corner
	icon_state = "bluecorner"

/turf/open/floor/plasteel/f13/vault_floor/blue/bluechess
	icon_state = "bluechess"

/turf/open/floor/plasteel/f13/vault_floor/blue/bluechess/bluechess2
	icon_state = "bluechess2"

/turf/open/floor/plasteel/f13/vault_floor/blue/white/side
	icon_state = "whiteblue"

/turf/open/floor/plasteel/f13/vault_floor/blue/white/corner
	icon_state = "whitebluecorner"

/turf/open/floor/plasteel/f13/vault_floor/blue/white/whitebluechess
	icon_state = "whitebluechess"

/turf/open/floor/plasteel/f13/vault_floor/blue/white/whitebluechess/whitebluechess2
	icon_state = "whitebluechess2"

	/* GREEN TILES */

/turf/open/floor/plasteel/f13/vault_floor/green
	icon_state = "greenfull"

/turf/open/floor/plasteel/f13/vault_floor/green/whitegreenfull
	icon_state = "whitegreenfull"

/turf/open/floor/plasteel/f13/vault_floor/green/side
	icon_state = "green"

/turf/open/floor/plasteel/f13/vault_floor/green/corner
	icon_state = "greencorner"

/turf/open/floor/plasteel/f13/vault_floor/green/greenchess
	icon_state = "greenchess"

/turf/open/floor/plasteel/f13/vault_floor/green/greenchess/greenchess2
	icon_state = "greenchess2"

/turf/open/floor/plasteel/f13/vault_floor/green/white/side
	icon_state = "whitegreen"

/turf/open/floor/plasteel/f13/vault_floor/green/white/corner
	icon_state = "whitegreencorner"

/turf/open/floor/plasteel/f13/vault_floor/green/white/whitegreenchess
	icon_state = "whitegreenchess"

/turf/open/floor/plasteel/f13/vault_floor/green/white/whitegreenchess/whitegreenchess2
	icon_state = "whitegreenchess2"

	/* YELLOW TILES */

/turf/open/floor/plasteel/f13/vault_floor/yellow
	icon_state = "yellowfull"

/turf/open/floor/plasteel/f13/vault_floor/yellow/whiteyellowfull
	icon_state = "whiteyellowfull"

/turf/open/floor/plasteel/f13/vault_floor/yellow/side
	icon_state = "yellow"

/turf/open/floor/plasteel/f13/vault_floor/yellow/corner
	icon_state = "yellowcorner"

/turf/open/floor/plasteel/f13/vault_floor/yellow/yellowchess
	icon_state = "yellowchess"

/turf/open/floor/plasteel/f13/vault_floor/yellow/yellowchess/yellowchess2
	icon_state = "yellowchess2"

/turf/open/floor/plasteel/f13/vault_floor/yellow/white/side
	icon_state = "whiteyellow"

/turf/open/floor/plasteel/f13/vault_floor/yellow/white/corner
	icon_state = "whiteyellowcorner"

/turf/open/floor/plasteel/f13/vault_floor/yellow/white/whiteyellowchess
	icon_state = "whiteyellowchess"

/turf/open/floor/plasteel/f13/vault_floor/yellow/white/whiteyellowchess/whiteyellowchess2
	icon_state = "whiteyellowchess2"

	/* PURPLE TILES */

/turf/open/floor/plasteel/f13/vault_floor/purple
	icon_state = "purplefull"

/turf/open/floor/plasteel/f13/vault_floor/purple/whitepurplefull
	icon_state = "whitepurplefull"

/turf/open/floor/plasteel/f13/vault_floor/purple/side
	icon_state = "purple"

/turf/open/floor/plasteel/f13/vault_floor/purple/corner
	icon_state = "purplecorner"

/turf/open/floor/plasteel/f13/vault_floor/purple/purplechess
	icon_state = "purplechess"

/turf/open/floor/plasteel/f13/vault_floor/purple/purplechess/purplechess2
	icon_state = "purplechess2"

/turf/open/floor/plasteel/f13/vault_floor/purple/white/side
	icon_state = "whitepurple"

/turf/open/floor/plasteel/f13/vault_floor/purple/white/corner
	icon_state = "whitepurplecorner"

/turf/open/floor/plasteel/f13/vault_floor/purple/white/whitepurplechess
	icon_state = "whitepurplechess"

/turf/open/floor/plasteel/f13/vault_floor/purple/white/whitepurplechess/whitepurplechess2
	icon_state = "whitepurplechess2"


	/* neutral TILES */

/turf/open/floor/plasteel/f13/vault_floor/neutral
	icon_state = "neutralfull2"

/turf/open/floor/plasteel/f13/vault_floor/neutral/neutralsolid
	icon_state = "neutralsolid"

/turf/open/floor/plasteel/f13/vault_floor/neutral/side
	icon_state = "neutral"

/turf/open/floor/plasteel/f13/vault_floor/neutral/corner
	icon_state = "neutralcorner"

/turf/open/floor/plasteel/f13/vault_floor/neutral/neutralchess
	icon_state = "neutralchess"

/turf/open/floor/plasteel/f13/vault_floor/neutral/neutralchess/neutralchess2
	icon_state = "neutralchess2"

/turf/open/floor/plasteel/f13/vault_floor/neutral/white/side
	icon_state = "whiteneutral"

/turf/open/floor/plasteel/f13/vault_floor/neutral/white/corner
	icon_state = "whiteneutralcorner"

/turf/open/floor/plasteel/f13/vault_floor/neutral/white/whitepurplechess
	icon_state = "whitepurplechess"

/turf/open/floor/plasteel/f13/vault_floor/neutral/white/whitepurplechess/whitepurplechess2
	icon_state = "whitepurplechess2"

	/* MISC TILES */

/turf/open/floor/plasteel/f13/vault_floor/misc/bar
	icon_state = "bar"

/turf/open/floor/plasteel/f13/vault_floor/misc/cafeteria
	icon_state = "cafeteria"

/turf/open/floor/plasteel/f13/vault_floor/misc/cmo
	icon_state = "cmo"

/turf/open/floor/plasteel/f13/vault_floor/misc/rarewhite
	icon_state = "rarewhite"

/turf/open/floor/plasteel/f13/vault_floor/misc/rarewhite/rarecyan
	icon_state = "rarecyan"

/turf/open/floor/plasteel/f13/vault_floor/misc/rarewhite/side
	icon_state = "rare"

/turf/open/floor/plasteel/f13/vault_floor/misc/rarewhite/corner
	icon_state = "rarecorner"

/turf/open/floor/plasteel/f13/vault_floor/misc/recharge
	icon_state = "recharge"

/turf/open/floor/plasteel/f13/vault_floor/misc/plaque
	icon_state = "plaque"

/turf/open/floor/plasteel/f13/vault_floor/misc/vaultrust
	icon_state = "vaultrust"

/turf/open/floor/plasteel/f13/vault_floor/misc/vault1
	icon_state = "vault1"

////Metal Floors////

/turf/open/floor/plasteel/f13/metal
	footstep = FOOTSTEP_PLATING //clonk
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	icon_state = "steel_industrial"
	desc = "Metal flooring."

/turf/open/floor/plasteel/f13/metal/plate
	icon_state = "steel_solid"

/turf/open/floor/plasteel/f13/metal/border
	icon_state = "steel_industrial_b"

/turf/open/floor/plasteel/f13/metal/border/corner
	icon_state = "steel_industrial_b_corner"

/turf/open/floor/plasteel/f13/metal/border/sides
	icon_state = "steel_industrial_b_sides"

/turf/open/floor/plasteel/f13/metal/border/end
	icon_state = "steel_industrial_b_end"

/turf/open/floor/plasteel/f13/metal/grate
	icon_state = "steel_grate"

/turf/open/floor/plasteel/f13/metal/grate/alt
	icon_state = "steel_grate_alt"

/turf/open/floor/plasteel/f13/metal/grate/border
	icon_state = "steel_grate_border"

/turf/open/floor/plasteel/f13/metal/grate/border/warning
	icon_state = "steel_grate_warning"

/turf/open/floor/plasteel/f13/metal/warning
	icon_state = "steel_warning"

/turf/open/floor/plasteel/f13/metal/stayclear
	icon_state = "steel_stayclear"

////Concrete Floors////

/turf/open/floor/plasteel/f13/concrete
	icon_state = "concrete_big"
	desc = "Concrete slabs."

/turf/open/floor/plasteel/f13/concrete/small
	icon_state = "concrete_small"

/turf/open/floor/plasteel/f13/concrete/industrial
	icon_state = "concrete_industrial"
	desc = "Heavy duty concrete slabs." //DAS CONCRETE BABY

/turf/open/floor/plasteel/f13/concrete/industrial/alt
	icon_state = "concrete_industrial_alt"

/turf/open/floor/plasteel/f13/concrete/industrial/split
	icon_state = "concrete_industrial_split"

/turf/open/floor/plasteel/f13/concrete/industrial/walkway
	icon_state = "concrete_walkway"

/turf/open/floor/plasteel/f13/concrete/industrial/walkway/corner
	icon_state = "concrete_walkway_corner"

/turf/open/floor/plasteel/f13/concrete/industrial/walkway/end
	icon_state = "concrete_walkway_end"

/turf/open/floor/plasteel/f13/concrete/industrial/walkway
	icon_state = "concrete_walkway"

/turf/open/floor/plasteel/f13/concrete/industrial/walkway/corner
	icon_state = "concrete_walkway_corner"

/turf/open/floor/plasteel/f13/concrete/industrial/walkway/end
	icon_state = "concrete_walkway_end"

////Hybrid Floors////

/turf/open/floor/plasteel/f13/concrete/cable
	icon_state = "concrete_cable_straight"
	desc = "Heavy duty cabling embedded in industrial grade concrete."

/turf/open/floor/plasteel/f13/concrete/cable/curved
	icon_state = "concrete_cable_curve"

/turf/open/floor/plasteel/f13/concrete/cable/merge
	icon_state = "concrete_cable_merge"

/turf/open/floor/plasteel/f13/concrete/cable/intersection
	icon_state = "concrete_cable_intersection"

/turf/open/floor/plasteel/f13/concrete/cable/box
	icon_state = "concrete_cable_box"

/turf/open/floor/plasteel/f13/concrete/cable/node
	icon_state = "concrete_cable_node"

/turf/open/floor/plasteel/f13/metal/pipe
	icon_state = "pipe_straight"

/turf/open/floor/plasteel/f13/metal/pipe/Entered(mob/living/M)
	. = ..()
	if(!istype(M))
		return

	if(prob(30))
		M.slip(5, M.loc, GALOSHES_DONT_HELP, 0, FALSE)
		playsound(M, 'sound/effects/bang.ogg', 10, 1)
		to_chat(usr, "<span class='warning'>You trip on the pipes!</span>")
		return

/turf/open/floor/plasteel/f13/metal/pipe/corner
	icon_state = "pipe_corner"

/turf/open/floor/plasteel/f13/metal/pipe/intersection
	icon_state = "pipe_intersection"

turf/open/floor/plasteel/f13/tile
	icon_state = "grey"

turf/open/floor/plasteel/f13/tile/broken
	icon_state = "grey_1"

	New()
		..()
		if(icon_state == "grey_1")
			icon_state = "grey_[rand(1,8)]"

/turf/open/floor/plasteel/f13/tile/long
	icon_state = "grey_long"

/turf/open/floor/plasteel/f13/tile/long/broken
	icon_state = "grey_long_1"

	New()
		..()
		if(icon_state == "grey_long1")
			icon_state = "grey_long_[rand(1,6)]"

/turf/open/floor/plasteel/f13/tile/blue
	icon_state = "bluetile"

/turf/open/floor/plasteel/f13/tile/blue/broken
	icon_state = "blue_1"

	New()
		..()
		if(icon_state == "blue_1")
			icon_state = "blue_[rand(1,8)]"

/turf/open/floor/plasteel/f13/tile/blue_long
	icon_state = "blue_long"

/turf/open/floor/plasteel/f13/tile/blue_long/broken
	icon_state = "blue_long_1"

	New()
		..()
		if(icon_state == "blue_long1")
			icon_state = "blue_long_[rand(1,6)]"

/turf/open/floor/plasteel/f13/tile/navy
	icon_state = "navy"

/turf/open/floor/plasteel/f13/tile/navy/broken
	icon_state = "navy_1"

	New()
		..()
		if(icon_state == "navy_1")
			icon_state = "navy_[rand(1,7)]"

/turf/open/floor/plasteel/f13/tile/brown
	icon_state = "browntile"

/turf/open/floor/plasteel/f13/tile/brown/broken
	icon_state = "brown_1"

	New()
		..()
		if(icon_state == "brown_1")
			icon_state = "brown_[rand(1,8)]"

/turf/open/floor/plasteel/f13/tile/fancy
	icon_state = "fancy"

/turf/open/floor/plasteel/f13/tile/fancy/broken
	icon_state = "fancy_1"

	New()
		..()
		if(icon_state == "fancy_1")
			icon_state = "fancy_[rand(1,7)]"



/turf/open/floor/plasteel/f13/stone
	name = "stone floor"
	icon = 'icons/turf/f13floors2.dmi'

/turf/open/floor/plasteel/f13/stone/ornate
	icon_state = "ornate"

/turf/open/floor/plasteel/f13/stone/ornate/broken
	icon_state = "ornate_1"

	New()
		..()
		if(icon_state == "ornate_1")
			icon_state = "ornate_[rand(1,3)]"

/turf/open/floor/plasteel/f13/stone/sierra
	icon_state = "sierra"

/turf/open/floor/plasteel/f13/stone/sierra/broken
	icon_state = "sierra_1"

	New()
		..()
		if(icon_state == "sierra_1")
			icon_state = "ornate_[rand(1,3)]"

/turf/open/floor/plasteel/f13/stone/ceramic
	icon_state = "ceramic"

/turf/open/floor/plasteel/f13/stone/ceramic/broken
	icon_state = "ceramic_1"

	New()
		..()
		if(icon_state == "ceramic_1")
			icon_state = "ceramic_[rand(1,2)]"

/turf/open/floor/plasteel/f13/stone/brick
	icon_state = "brick"

/turf/open/floor/plasteel/f13/stone/brick/broken
	icon_state = "brick_1"

	New()
		..()
		if(icon_state == "brick_1")
			icon_state = "brick_[rand(1,8)]"

/turf/open/floor/plasteel/f13/stone/rugged
	icon_state = "khanstone"

/turf/open/floor/circuit/f13_blue
	icon = 'icons/turf/f13floors2.dmi'
	icon_state = "bcircuit2"
	icon_normal = "bcircuit2"

/turf/open/floor/circuit/f13_blue/off
	icon_state = "bcircuitoff2"
	on = FALSE

/turf/open/floor/circuit/f13_green
	icon = 'icons/turf/f13floors2.dmi'
	icon_state = "gcircuit2"
	icon_normal = "gcircuit2"
	light_color = LIGHT_COLOR_GREEN
	floor_tile = /obj/item/stack/tile/circuit/green

/turf/open/floor/circuit/f13_green/off
	icon_state = "gcircuitoff2"
	on = FALSE

/turf/open/floor/circuit/f13_red
	icon = 'icons/turf/f13floors2.dmi'
	icon_state = "rcircuit1"
	icon_normal = "rcircuit1"
	light_color = LIGHT_COLOR_FLARE
	floor_tile = /obj/item/stack/tile/circuit/red

/turf/open/floor/circuit/f13_red/off
	icon_state = "rcircuitoff1"
	on = FALSE

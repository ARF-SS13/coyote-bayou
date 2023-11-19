//Fallout 13 general indestructible floor directory

/turf
	var/baseturf_icon
	var/baseturf_dir = 0

/turf/open/indestructible/ground
	icon = 'icons/fallout/turfs/ground.dmi'
	name = "\proper ground"
	icon_state = "wasteland1"
	intact = 0
	planetary_atmos = TRUE
	tiled_dirt = FALSE

	var/flags = NONE

/turf/open/indestructible/ground/New()
	..()
	baseturfs = src.type
	baseturf_icon = icon_state
	baseturf_dir = dir

/turf/open/indestructible/ground/attack_paw(mob/user)
	return src.attack_hand(user)

/turf/open/indestructible/ground/attackby(obj/item/C, mob/user, params)
	if(istype(C,/obj/item/stack/tile/plasteel))
		var/obj/item/stack/tile/plasteel/S = C
		if(S.use(1))
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			to_chat(user, span_notice("You build a floor."))
			ChangeTurf(/turf/open/floor/plating)
		else
			to_chat(user, span_warning("You need one floor tile to build a floor!"))
		return
	if(istype(C,/obj/item/stack/tile/wood))
		var/obj/item/stack/tile/wood/S = C
		if(S.use(1))
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			to_chat(user, span_notice("You build a house base."))
			ChangeTurf(/turf/open/floor/plating/wooden)
		else
			to_chat(user, span_warning("You need one floor tile to build a house base!"))
		return
	else
		return ..()
/*
/turf/ground/Entered(go/A)
	..()

/turf/open/indestructible/ground/handle_slip()
	return
*/
/turf/open/indestructible/ground/singularity_act()
	return

/turf/open/indestructible/ground/can_have_cabling()
	return TRUE

//////////////////////////////////////////////////////////////////////

/turf/open/indestructible/ground/outside
	sunlight_state = SUNLIGHT_SOURCE

/turf/open/indestructible/ground/outside/Initialize()
	. = ..()
	flags_2 |= GLOBAL_LIGHT_TURF_2

#define GRASS_SPONTANEOUS 		  2
#define GRASS_WEIGHT			  4
GLOBAL_LIST_INIT(lush_plant_spawn_list, list(
	/obj/structure/flora/grass/wasteland = 1,
	))

GLOBAL_LIST_INIT(desolate_plant_spawn_list, list(
	/obj/structure/flora/grass/wasteland = 2,
	/obj/structure/flora/branch = 1,
	/obj/structure/flora/branch_broken = 1,
	/obj/structure/flora/brushwood = 1,
	/obj/structure/flora/brushwoodalt = 1,
	/obj/structure/flora/tree/med_pine = 2,
	/obj/structure/flora/tree/med_pine_dead = 2,
	/obj/structure/flora/grass/coyote/one = 2,
	/obj/structure/flora/grass/coyote/two = 2,
	/obj/structure/flora/grass/coyote/three = 2,
	/obj/structure/flora/grass/coyote/four = 2,
	/obj/structure/flora/grass/coyote/five = 2,
	/obj/structure/flora/grass/coyote/six = 2,
	/obj/structure/flora/grass/coyote/seven = 2,
	/obj/structure/flora/grass/coyote/eight = 2,
	/obj/structure/flora/grass/coyote/nine = 2,
	/obj/structure/flora/grass/coyote/ten = 2,
	/obj/structure/flora/grass/coyote/eleven = 2,
	/obj/structure/flora/grass/coyote/twelve = 2,
	/obj/structure/flora/grass/coyote/thirteen = 2,
	/obj/structure/flora/grass/coyote/fourteen = 2,
	/obj/structure/flora/grass/coyote/fiveteen = 2,
	/obj/structure/flora/grass/coyote/sixteen = 2,
	/obj/structure/flora/grass/coyote/seventeen = 2,
	/obj/structure/flora/grass/coyote/eighteen = 2,
	/obj/structure/flora/grass/coyote/nineteen = 2,
	/obj/structure/flora/grass/coyote/twenty = 2,
	/obj/structure/flora/grass/coyote/twentyone = 2,
	/obj/structure/flora/grass/coyote/twentytwo = 2,
	/obj/structure/flora/grass/coyote/twentythree = 2,
	/obj/structure/flora/grass/coyote/twentyfour = 2,
	/obj/structure/flora/grass/coyote/twentyfive = 2,
	/obj/structure/flora/grass/coyote/twentysix = 2,
	/obj/structure/flora/grass/coyote/twentyseven = 2,
	/obj/structure/flora/grass/coyote/twentyeight = 2,
	/obj/structure/flora/grass/coyote/twentynine = 2,
	/obj/structure/flora/grass/coyote/thirty = 2,
	/obj/structure/flora/wild_plant/thistle = 1,
	/obj/structure/flora/wild_plant/petunia = 1,
	/obj/structure/flora/wild_plant/petunia/purple = 1,
	/obj/structure/flora/wild_plant/petunia/purplewhite = 1,
	/obj/structure/flora/wild_plant/petunia/redwhite =  1,
	/obj/structure/flora/wild_plant/petunia/bluewhite = 1,
	/obj/structure/flora/ausbushes/ppflowers = 1,
	/obj/structure/flora/ausbushes/ywflowers = 1,
	/obj/structure/flora/ausbushes/brflowers = 1,
	/obj/structure/flora/ausbushes/stalkybush = 1,
	/obj/structure/flora/ausbushes/sunnybush = 1,
	/obj/structure/flora/ausbushes/palebush = 1,
	/obj/structure/flora/ausbushes/pointybush = 1,
	/obj/structure/flora/ausbushes/leafybush = 1,
	/obj/structure/flora/ausbushes/fernybush = 1,
	/obj/structure/flora/tree/med_pine = 1,
	/obj/structure/flora/tree/med_pine_dead = 1,
	/obj/structure/flora/tree_stump = 1,
	/obj/structure/flora/tree/african_acacia_dead = 1,
	/obj/structure/flora/tree/tall = 1,
	/obj/structure/flora/tree/oak_one = 1,
	/obj/structure/flora/tree/oak_two = 1,
	/obj/structure/flora/tree/oak_three = 1,
	/obj/structure/flora/tree/oak_four = 1,
	/obj/structure/flora/tree/oak_five = 1,
	/obj/structure/flora/burnedtree1 = 1,
	/obj/structure/flora/burnedtree2 = 1,
	/obj/structure/flora/burnedtree5 = 1
	))

/turf/open/indestructible/ground/outside/dirthole
	name = "Dirt hole"
	icon_state = "dirthole"
	desc = "A dirt hole."
	slowdown = 3
	flags_1 = ADJACENCIES_OVERLAY

/turf/open/indestructible/ground/outside/river
	name = "river"
	icon_state = "riverwateruhh"
	desc = "A river."
	slowdown = 5
	flags_1 = ADJACENCIES_OVERLAY


//////////////
// SAVANNAH //
//////////////

/turf/open/indestructible/ground/outside/savannah
	name = "savannah"
	desc = "Some savannah."
	icon = 'icons/fallout/turfs/savannah.dmi'
	icon_state = "savannahcenter"
	slowdown = 0.4
	flags_1 = CAN_HAVE_NATURE | ADJACENCIES_OVERLAY
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND

/turf/open/indestructible/ground/outside/savannah/center
	icon_state = "savannahcenter"
/turf/open/indestructible/ground/outside/savannah/bottomright
	icon_state = "savannah1"
/turf/open/indestructible/ground/outside/savannah/bottomcenter
	icon_state = "savannah2"
/turf/open/indestructible/ground/outside/savannah/bottomleft
	icon_state = "savannah3"
/turf/open/indestructible/ground/outside/savannah/leftcenter
	icon_state = "savannah4"
/turf/open/indestructible/ground/outside/savannah/topleft
	icon_state = "savannah5"
/turf/open/indestructible/ground/outside/savannah/topcenter
	icon_state = "savannah6"
/turf/open/indestructible/ground/outside/savannah/topright
	icon_state = "savannah7"
/turf/open/indestructible/ground/outside/savannah/rightcenter
	icon_state = "savannah8"
/turf/open/indestructible/ground/outside/savannah/bottomleftcorner
	icon_state = "savannah9"
/turf/open/indestructible/ground/outside/savannah/bottomrightcorner
	icon_state = "savannah10"
/turf/open/indestructible/ground/outside/savannah/topleftcorner
	icon_state = "savannah11"
/turf/open/indestructible/ground/outside/savannah/toprightcorner
	icon_state = "savannah12"
/turf/open/indestructible/ground/outside/savannah/cornersnew
	icon_state = "savannah13"
/turf/open/indestructible/ground/outside/savannah/edgesnew
	icon_state = "savannah14"

// Savannah merged with dark dirt 1-
/turf/open/indestructible/ground/outside/savannah/dark
	icon_state = "savannah1_dark"



// DESERT

/turf/open/indestructible/ground/outside/desert
	name = "desert"
	icon_state = "wasteland"
//	step_sounds = list("human" = "dirtfootsteps")
//	allowed_plants = list(/obj/item/seeds/poppy/broc, /obj/item/seeds/xander, /obj/item/seeds/mutfruit,
//	/obj/item/seeds/feracactus, /obj/item/seeds/corn,/obj/item/seeds/shroom, /obj/item/seeds/agave)
	slowdown = 0.4
	flags_1 = CAN_HAVE_NATURE | ADJACENCIES_OVERLAY
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	var/dug = FALSE				//FALSE = has not yet been dug, TRUE = has already been dug
	var/pit_sand = 1
	// TODO: REWRITE PITS ENTIRELY
	var/storedindex = 0			//amount of stored items
	var/mob/living/gravebody	//is there a body in the pit?
	var/obj/structure/closet/crate/coffin/gravecoffin //or maybe a coffin?
	var/obj/salvage //or salvage
	var/pitcontents // Lazylist of pit contents. TODO: Replace with mypit.contents?
	var/obj/dugpit/mypit
	var/unburylevel = 0
	var/static/list/loots = list(
						/obj/item/stack/crafting/metalparts/five = 30,
						/obj/item/stack/crafting/goodparts/five = 30,
						/obj/item/stack/ore/blackpowder/twenty = 10,
						//obj/effect/spawner/lootdrop/f13/weapon/wasteland = 6,
						//obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/mid = 3,
						//obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/low = 3
						)

//For sculpting with more precision, the random picking does not work very well. Slowdown 0.5 instead of 1. No random armor or gunpowder or titanium. Use directions for control. - Pebbles
/turf/open/indestructible/ground/outside/desert/sonora
	icon = 'icons/fallout/turfs/wasteland.dmi'
	icon_state = "desertsmooth"
	slowdown = 0.3
	footstep = FOOTSTEP_LOOSE_SAND
	barefootstep = FOOTSTEP_LOOSE_SAND
	clawfootstep = FOOTSTEP_LOOSE_SAND

/turf/open/indestructible/ground/outside/desert/sonora/coarse
	icon_state = "desertcoarse"
	slowdown = 0.6

/turf/open/indestructible/ground/outside/desert/sonora/coarse2
	icon_state = "desertcoarse2"
	slowdown = 0.6

/turf/open/indestructible/ground/outside/desert/sonora/rough
	icon_state = "desertrough"
	slowdown = 0.4

/turf/open/indestructible/ground/outside/desert/harsh
	icon_state = "wasteland"
	icon = 'icons/fallout/turfs/ground_harsh.dmi'

/turf/open/indestructible/ground/outside/desert/Initialize()
	. = ..()
	if(prob(2))
		var/obj/derp = pickweight(loots)
		salvage = new derp()
	if(icon_state != "wasteland")
		icon_state = "wasteland[rand(1,31)]"
	for(var/direction in GLOB.cardinals)
		var/turf/turf_to_check = get_step(src, direction)
		if(istype(turf_to_check, /turf/open/water))
			var/obj/effect/overlay/desert_side/DS = new /obj/effect/overlay/desert_side(src)
			switch(direction)
				if(NORTH)
					DS.pixel_y = 32
				if(SOUTH)
					DS.pixel_y = -32
				if(EAST)
					DS.pixel_x = 32
				if(WEST)
					DS.pixel_x = -32
			DS.dir = dir = turn(direction, 180)

/turf/open/indestructible/ground/outside/desert/harsh/Initialize()
	. = ..()
	if(prob(2))
		var/obj/derp = pickweight(loots)
		salvage = new derp()
	if(icon_state != "wasteland")
		icon_state = "wasteland[rand(1,31)]"

/obj/effect/overlay/desert_side
	name = "desert"
	icon = 'icons/fallout/turfs/smoothing.dmi'
	icon_state = "wasteland_side"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = FLOOR_PLANE
	layer = ABOVE_OPEN_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE

// Two edge smootheners for the new desert turf
/obj/effect/overlay/desert/sonora/edge
	name = "desert edge"
	icon = 'icons/fallout/turfs/wasteland.dmi'
	icon_state = "desertedge"

/obj/effect/overlay/desert/sonora/edge/corner
	icon_state = "desertcorner"

/turf/open/indestructible/ground/outside/desert/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return //I mean, it makes sense that deserts don't get slippery, I guess... :(

/turf/open/indestructible/ground/outside/dirt
	name = "dirt"
	icon = 'icons/fallout/turfs/dirt.dmi'
	icon_state = "dirtfull"
//	step_sounds = list("human" = "dirtfootsteps")
//	allowed_plants = list(/obj/item/seeds/poppy/broc, /obj/item/seeds/xander, /obj/item/seeds/mutfruit,
//	/obj/item/seeds/potato, /obj/item/seeds/carrot, /obj/item/seeds/pumpkin, /obj/item/seeds/corn, /obj/item/seeds/agave)
	slowdown = 0.3
	flags_1 = CAN_HAVE_NATURE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND

/turf/open/indestructible/ground/outside/dirt/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return //same thing here, dirt absorbs the liquid... :(

// DARK DIRT - the legacy one
/turf/open/indestructible/ground/outside/dirt/dark

/turf/open/indestructible/ground/outside/dirt/harsh
	icon = 'icons/fallout/turfs/ground_harsh.dmi'
	icon_state = "dirtfull"

/turf/open/indestructible/ground/outside/dirt/harsh/side
	icon_state = "dirt"

/turf/open/indestructible/ground/outside/dirt/harsh/corner
	icon_state = "dirtcorner"

/turf/open/indestructible/ground/outside/dirt_s
	name = "dirt"
	icon_state = "bottomleft"
	icon = 'icons/fallout/turfs/dirtsnow.dmi'
//	step_sounds = list("human" = "dirtfootsteps")

/turf/open/indestructible/ground/outside/grass_s
	name = "grass"
	icon_state = "bottomleft"
	icon = 'icons/fallout/turfs/snowgrass.dmi'
//	step_sounds = list("human" = "dirtfootsteps")

/turf/open/indestructible/ground/outside/road
	name = "\proper road"
	icon_state = "innermiddle"
	icon = 'icons/fallout/turfs/asphalt.dmi'
	footstep = FOOTSTEP_ROAD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
//	step_sounds = list("human" = "erikafootsteps")

/turf/open/indestructible/ground/outside/road_s
	name = "\proper road"
	icon_state = "innermiddle"
	icon = 'icons/fallout/turfs/asphalt_s.dmi'
//	step_sounds = list("human" = "erikafootsteps")

/turf/open/indestructible/ground/outside/sidewalk
	name = "\proper sidewalk"
	icon_state = "outermiddle"
	icon = 'icons/fallout/turfs/sidewalk.dmi'
	footstep = FOOTSTEP_ROAD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
//	step_sounds = list("human" = "erikafootsteps")

/turf/open/indestructible/ground/outside/sidewalk_s
	name = "\proper sidewalk"
	icon_state = "outermiddle"
	icon = 'icons/fallout/turfs/sidewalk_s.dmi'
//	step_sounds = list("human" = "erikafootsteps")

/turf/open/indestructible/ground/outside/ruins
	name = "ruins"
	desc = "It's just a pile of concrete rubble."
	icon_state = "rubblefull"
	icon = 'icons/fallout/turfs/ground.dmi'
	footstep = FOOTSTEP_ROAD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
//	step_sounds = list("human" = "erikafootsteps")

/turf/open/indestructible/ground/outside/wood
	name = "\proper wood planks"
	icon_state = "housewood1"
	icon = 'icons/turf/floors.dmi'
	//	step_sounds = list("human" = "woodfootsteps")

/turf/open/indestructible/ground/outside/woodalt
	name = "\proper wood planks"
	icon_state = "wood"
	icon = 'icons/turf/floors.dmi'
	//	step_sounds = list("human" = "woodfootsteps")

/turf/open/indestructible/ground/outside/roof
	name = "roof"
	icon_state = "floorrusty"
	icon = 'icons/fallout/turfs/floors.dmi'
	//	step_sounds = list("human" = "woodfootsteps")

/turf/open/indestructible/ground/outside/water
	gender = PLURAL
	name = "river water"
	desc = "Shallow river water."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	slowdown = 2
	depth = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = 'sound/effects/puddlesplash.ogg'
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/indestructible/ground/outside/water/running
	gender = PLURAL
	name = "moving river water"
	desc = "Shallow river water."
	icon = 'icons/fallout/turfs/ground.dmi'
	icon_state = "riverwateruhh"
	slowdown = 6
	depth = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/indestructible/ground/outside/water/Initialize()
	. = ..()
	update_icon()

/turf/open/indestructible/ground/outside/water/Entered(atom/movable/AM, atom/oldloc)
	if(istype(AM, /mob/living))
		var/mob/living/L = AM
		L.update_water()
		if(L.check_submerged() <= 0)
			return
		if(!istype(oldloc, /turf/open/indestructible/ground/outside/water))
			to_chat(L, span_warning("You get drenched in water!"))
	AM.water_act(5)
	..()

/turf/open/indestructible/ground/outside/water/Exited(atom/movable/AM, atom/newloc)
	if(istype(AM, /mob/living))
		var/mob/living/L = AM
		L.update_water()
		if(L.check_submerged() <= 0)
			return
		if(!istype(newloc, /turf/open/indestructible/ground/outside/water))
			to_chat(L, span_warning("You climb out of \the [src]."))
	..()

/turf/open/indestructible/ground/outside/water/update_icon()
	. = ..()

/turf/open/indestructible/ground/outside/water/AltClick(mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/L = user
		L.DelayNextAction(CLICK_CD_MELEE)
		if(!user.incapacitated() && Adjacent(user))
			user.visible_message(span_notice("[L] starts washing in \the [src]."),
								span_notice("You start washing in \the [src]."),
								span_notice("You hear splashing water and scrubbing."))
			playsound(user,"water_wade",100,TRUE)
			if(do_after(user,5 SECONDS, TRUE, src, TRUE,allow_movement=FALSE,stay_close=TRUE))
				give_mob_washies(L)
				user.visible_message(span_notice("[L] finishes washing in \the [src]."),
									span_notice("You finish washing in \the [src]."),
									span_notice("The splashing and scrubbing stops."))
				playsound(user,"water_wade",100,TRUE)

/turf/open/indestructible/ground/outside/water/examine(mob/user)
	. = ..()
	. += span_notice("Alt-Click \the [src] to wash yourself off.")

/turf/open/indestructible/ground/outside/snow
	initial_gas_mix = "o2=22;n2=82;TEMP=285"
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	desc = "Looks cold."
	icon_state = "snow"
	footstep = FOOTSTEP_SNOW
	barefootstep = FOOTSTEP_SNOW
	clawfootstep = FOOTSTEP_SNOW

/turf/open/indestructible/ground/outside/ruins/ex_act(severity, target)
	contents_explosion(severity, target)
	switch(severity)
		if(4)
			if(prob(5))
				ChangeTurf(baseturfs)
		if(3)
			if(prob(25))
				ChangeTurf(baseturfs)
		if(2)
			if(prob(50))
				ChangeTurf(baseturfs)
		if(1)
			ChangeTurf(baseturfs)

/////////////////////////////////////////////////////////

#define SHROOM_SPAWN_GROUND	1

/turf/open/indestructible/ground/inside/mountain
	name = "cave"
	icon_state = "rockfloor1"
	icon = 'icons/fallout/turfs/mining.dmi'
//	allowed_plants = list(/obj/item/seeds/glow)
//	step_sounds = list("human" = "erikafootsteps")

/turf/open/indestructible/ground/inside/mountain/Initialize()
	. = ..()
	//If no fences, machines, etc. try to plant mushrooms
	if(!(\
			(locate(/obj/structure) in src) || \
			(locate(/obj/machinery) in src) ))
		plantShrooms()
	for(var/direction in GLOB.cardinals)
		var/turf/turf_to_check = get_step(src, direction)
		if(istype(turf_to_check, /turf/open/water))
			var/obj/effect/overlay/rockfloor_side/DS = new /obj/effect/overlay/rockfloor_side(src)
			switch(direction)
				if(NORTH)
					DS.pixel_y = 32
				if(SOUTH)
					DS.pixel_y = -32
				if(EAST)
					DS.pixel_x = 32
				if(WEST)
					DS.pixel_x = -32
			DS.dir = turn(direction, 180)

/obj/effect/overlay/rockfloor_side
	name = "cave"
	icon = 'icons/fallout/turfs/smoothing.dmi'
	icon_state = "rockfloor_side"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = FLOOR_PLANE
	layer = ABOVE_OPEN_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE

/turf/open/indestructible/ground/inside/mountain/proc/plantShrooms()
	if(prob(SHROOM_SPAWN_GROUND))
		new /obj/structure/flora/wasteplant/wild_fungus(src)
		return TRUE

/turf/open/indestructible/ground/inside/mountain/New()
	..()
	icon_state = "rockfloor[rand(1,2)]"

/turf/open/indestructible/ground/inside/dirt
	name = "dirt"
	icon_state = "dirtfull"
//	step_sounds = list("human" = "dirtfootsteps")
//	allowed_plants = list(/obj/item/seeds/poppy/broc, /obj/item/seeds/xander, /obj/item/seeds/mutfruit,
//	/obj/item/seeds/potato, /obj/item/seeds/carrot, /obj/item/seeds/pumpkin, /obj/item/seeds/corn, /obj/item/seeds/agave)
	slowdown = 0.2
	flags_1 = CAN_HAVE_NATURE

/turf/open/indestructible/ground/inside/subway
	name = "subway tunnel"
	icon = 'icons/fallout/turfs/ground.dmi'
	icon_state = "railsnone"

/turf/open/indestructible/ground/inside/subway/Initialize()
	. = ..()
	for(var/direction in GLOB.cardinals)
		var/turf/turf_to_check = get_step(src, direction)
		if(istype(turf_to_check, /turf/open))
			var/obj/effect/overlay/railsnone_side/DS = new /obj/effect/overlay/railsnone_side(src)
			switch(direction)
				if(NORTH)
					DS.pixel_y = 32
				if(SOUTH)
					DS.pixel_y = -32
				if(EAST)
					DS.pixel_x = 32
				if(WEST)
					DS.pixel_x = -32
			DS.dir = turn(direction, 180)

/obj/effect/overlay/railsnone_side
	name = "cave"
	icon = 'icons/fallout/turfs/smoothing.dmi'
	icon_state = "railsnone_side"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = FLOOR_PLANE
	layer = ABOVE_OPEN_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE


/turf/open/indestructible/ground/outside/roaddirt
	name = "road"
	icon_state = "innermiddle"
	icon = 'icons/fallout/turfs/asphaltdirt.dmi'
//	step_sounds = list("human" = "erikafootsteps")

/turf/open/indestructible/ground/outside/sidewalkdirt
	name = "sidewalk"
	icon_state = "outermiddle"
	icon = 'icons/fallout/turfs/sidewalkdirt.dmi'
	footstep = FOOTSTEP_ROAD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
//	step_sounds = list("human" = "erikafootsteps")

//Obsolete but used in yucky Pahrump
/turf/open/indestructible/ground/outside/graveldirt
	name = "gravel"
	icon_state = "graveldirt"
	icon = 'icons/fallout/turfs/ground.dmi'
//	step_sounds = list("human" = "erikafootsteps")

// New gravel, organized. Use directions for control. - Pebbles
/turf/open/indestructible/ground/outside/gravel
	name = "gravel"
	icon_state = "gravel"
	icon = 'icons/fallout/turfs/gravel.dmi'
	footstep = FOOTSTEP_GRAVEL
	barefootstep = FOOTSTEP_GRAVEL
	clawfootstep = FOOTSTEP_GRAVEL

/turf/open/indestructible/ground/outside/gravel/alt
	name = "gravel"
	icon_state = "gravel_alt"

/turf/open/indestructible/ground/outside/gravel/path_desert
	name = "gravel path"
	icon_state = "path_desert"

/turf/open/indestructible/ground/outside/gravel/path_desert/intersection
	name = "gravel path"
	icon_state = "path_desert_intersection"

/turf/open/indestructible/ground/outside/gravel/path_desert/end
	name = "gravel path"
	icon_state = "path_desert_end"

/turf/open/indestructible/ground/outside/gravel/path_dirt
	name = "gravel path"
	icon_state = "path_dirt"

/turf/open/indestructible/ground/outside/gravel/path_dirt/intersection
	name = "gravel path"
	icon_state = "path_dirt_intersection"

/turf/open/indestructible/ground/outside/gravel/path_dirt/end
	name = "gravel path"
	icon_state = "path_dirt_end"

// Two edge smootheners for the new gravel turf
/obj/effect/overlay/gravel/edge
	name = "gravel edge"
	icon = 'icons/fallout/turfs/gravel.dmi'
	icon_state = "graveledge"

/obj/effect/overlay/gravel/edge/corner
	icon_state = "gravelcorner"


//New Coyote Dirts
/turf/open/indestructible/ground/outside/dirt/light_grass
	name = "lightly grassed dirt"
	icon = 'modular_coyote/icons/turfs/lightgrass.dmi'
	icon_state = null

/turf/open/indestructible/ground/outside/dirt/bigdirtturf2
	name = "big dirt turf 2"
	icon = 'modular_coyote/icons/turfs/Big_Dirt_Turf_2.dmi'
	icon_state = null

/turf/open/indestructible/ground/outside/dirt/bigdirtturf
	name = "big dirt turf"
	icon = 'modular_coyote/icons/turfs/Big_Dirt_Turfs.dmi'
	icon_state = null

/turf/open/indestructible/ground/outside/dirt/biggrass
	name = "big grass"
	icon = 'modular_coyote/icons/turfs/Big_Grass.dmi'
	icon_state = null

/turf/open/indestructible/ground/outside/dirt/biggrassdirt2
	name = "grassier"
	icon = 'modular_coyote/icons/turfs/Big_Grass_Turf_2.dmi'
	icon_state = null

/turf/open/indestructible/ground/outside/dirt/bigiceturf
	name = "crunchy ice"
	icon = 'modular_coyote/icons/turfs/Big_Ice_Turf.dmi'
	icon_state = null


/turf/open/indestructible/ground/outside/dirt/bigsandturf
	name = "crunchy sand"
	icon = 'modular_coyote/icons/turfs/Big_Sand_Turf.dmi'
	icon_state = null

/turf/open/indestructible/ground/outside/dirt/rockysnow
	name = "snow on rocks"
	icon = 'modular_coyote/icons/turfs/Big_Snow_and_Rock_Turf.dmi'
	icon_state = null


/turf/open/indestructible/ground/outside/dirt/bigsnow
	name = "thick snow"
	icon = 'modular_coyote/icons/turfs/Big_Snow_turf.dmi'
	icon_state = null

//////////////
// 	 gob	//
//////////////

/turf/open/indestructible/ground/outside/dirt/desertsand
	name = "desertsand"
	icon = 'modular_coyote/icons/turfs/desertsand.dmi'
	icon_state = "sand1"

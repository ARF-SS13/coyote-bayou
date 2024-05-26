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

#define GRASS_SPONTANEOUS 		  	2
#define GRASS_WEIGHT			  	8
#define RAND_PLANT_CHANCE			50
#define HIDDEN_STASH_CHANCE			0.2

GLOBAL_LIST_INIT(lush_plant_spawn_list, list(
	/obj/structure/flora/grass/wasteland = 1,
	))

GLOBAL_LIST_INIT(medicinal_plant_list, list(
	/obj/structure/flora/wasteplant/wild_broc = 12,
	/obj/structure/flora/wasteplant/wild_xander = 12,
	/obj/structure/flora/wasteplant/wild_feracactus = 12, //barrel cactus
	/obj/structure/flora/wasteplant/wild_buffalogourd = 10,
	/obj/structure/flora/wasteplant/wild_horsenettle = 10,
	/obj/structure/flora/wasteplant/wild_mesquite = 10,
	/obj/structure/flora/wasteplant/wild_pinyon = 10,
	/obj/structure/flora/wasteplant/wild_prickly = 10,
	/obj/structure/flora/wasteplant/wild_datura = 10,
	/obj/structure/flora/wasteplant/wild_punga = 10,
	/obj/structure/flora/wasteplant/wild_coyote = 10,
	/obj/structure/flora/wasteplant/wild_yucca = 10,
	/obj/structure/flora/wasteplant/wild_tato = 10,
	/obj/structure/flora/wasteplant/wild_mutfruit = 10,
	/obj/structure/flora/wasteplant/wild_fungus = 5,
	/obj/structure/flora/wasteplant/wild_agave = 10,
	/obj/structure/flora/wasteplant/fever_blossom = 10,
	))

GLOBAL_LIST_INIT(grass_plant_list, list(
	/obj/structure/flora/grass/wasteland = 150,
	/obj/structure/flora/branch = 1,
	/obj/structure/flora/branch_broken = 1,
	/obj/structure/flora/brushwood = 1,
	/obj/structure/flora/brushwoodalt = 1,
	/obj/structure/flora/grass/coyote/one = 1,
	/obj/structure/flora/grass/coyote/two = 1,
	/obj/structure/flora/grass/coyote/three = 1,
	/obj/structure/flora/grass/coyote/four = 1,
	/obj/structure/flora/grass/coyote/five = 1,
	/obj/structure/flora/grass/coyote/six = 1,
	/obj/structure/flora/grass/coyote/seven = 1,
	/obj/structure/flora/grass/coyote/eight = 1,
	/obj/structure/flora/grass/coyote/nine = 1,
	/obj/structure/flora/grass/coyote/ten = 1,
	/obj/structure/flora/grass/coyote/eleven = 1,
	/obj/structure/flora/grass/coyote/twelve = 1,
	/obj/structure/flora/grass/coyote/thirteen = 1,
	/obj/structure/flora/grass/coyote/fourteen = 1,
	/obj/structure/flora/grass/coyote/fiveteen = 1,
	/obj/structure/flora/grass/coyote/sixteen = 1,
	/obj/structure/flora/grass/coyote/seventeen = 1,
	/obj/structure/flora/grass/coyote/eighteen = 1,
	/obj/structure/flora/grass/coyote/nineteen = 1,
	/obj/structure/flora/grass/coyote/twenty = 1,
	/obj/structure/flora/grass/coyote/twentyone = 1,
	/obj/structure/flora/grass/coyote/twentytwo = 1,
	/obj/structure/flora/grass/coyote/twentythree = 1,
	/obj/structure/flora/grass/coyote/twentyfour = 1,
	/obj/structure/flora/grass/coyote/twentyfive = 1,
	/obj/structure/flora/grass/coyote/twentysix = 1,
	/obj/structure/flora/grass/coyote/twentyseven = 1,
	/obj/structure/flora/grass/coyote/twentyeight = 1,
	/obj/structure/flora/grass/coyote/twentynine = 1,
	/obj/structure/flora/grass/coyote/thirty = 1,
	/obj/structure/flora/wild_plant/thistle = 2,
	/obj/structure/flora/wild_plant/petunia = 2,
	/obj/structure/flora/wild_plant/petunia/purple = 2,
	/obj/structure/flora/wild_plant/petunia/purplewhite = 2,
	/obj/structure/flora/wild_plant/petunia/redwhite =  2,
	/obj/structure/flora/wild_plant/petunia/bluewhite = 2,
	/obj/structure/flora/ausbushes/ppflowers = 2,
	/obj/structure/flora/ausbushes/ywflowers = 2,
	/obj/structure/flora/ausbushes/brflowers = 2,
	/obj/structure/flora/ausbushes/stalkybush = 2,
	/obj/structure/flora/ausbushes/sunnybush = 2,
	/obj/structure/flora/ausbushes/palebush = 2,
	/obj/structure/flora/ausbushes/pointybush = 2,
	/obj/structure/flora/ausbushes/leafybush = 2,
	/obj/structure/flora/ausbushes/fernybush = 2,
	/obj/structure/flora/burnedtree1 = 2,
	/obj/structure/flora/burnedtree2 = 2,
	/obj/structure/flora/burnedtree5 = 2,
	/obj/structure/flora/wasteplant/berrybush/tinto = 2,
	/obj/structure/flora/wasteplant/berrybush/amar = 2,
	/obj/structure/flora/wasteplant/berrybush/azul = 2,
	/obj/structure/flora/wasteplant/berrybush/majo = 2,
	/obj/structure/flora/wasteplant/berrybush/narco = 2,
	/obj/structure/flora/wasteplant/berrybush/zelenyy = 2,
	/obj/structure/flora/wasteplant/berrybush/marron = 2,
	/obj/structure/flora/wasteplant/berrybush/corcairghorm = 2,
	/obj/structure/flora/wasteplant/sunflower = 2,
	/obj/structure/flora/wasteplant/rose = 2,
	/obj/structure/flora/wasteplant/lily = 2,
	/obj/structure/flora/wasteplant/forgetmenot = 2,
	/obj/structure/flora/wasteplant/geranium =2,
	/obj/structure/flora/wasteplant/tomato = 2,
	/obj/structure/flora/wasteplant/watermelon =2,
	/obj/structure/flora/wasteplant/grape = 2,
	/obj/structure/flora/wasteplant/pumpkin = 2,
	/obj/structure/flora/wasteplant/corn = 2,
	/obj/structure/flora/wasteplant/carrot = 2

	))

GLOBAL_LIST_INIT(tree_plant_list, list(
	/obj/structure/flora/tree/jungle = 15,
	/obj/structure/flora/tree/jungle/small = 15,
	/obj/structure/flora/tree/med_pine = 7,
	/obj/structure/flora/tree/med_pine_dead = 7,
	/obj/structure/flora/tree_stump = 5,
	/obj/structure/flora/tree/african_acacia_dead = 5,
	/obj/structure/flora/tree/tall = 5,
	/obj/structure/flora/tree/oak_one = 5,
	/obj/structure/flora/tree/oak_two = 5,
	/obj/structure/flora/tree/oak_three = 5,
	/obj/structure/flora/tree/oak_four = 5,
	/obj/structure/flora/tree/oak_five = 5,
	/obj/structure/flora/tree/med_pine = 7,
	/obj/structure/flora/tree/med_pine_dead = 7,
	/obj/structure/flora/chomp/bones/lrock = 7,
	/obj/structure/flora/chomp/bones/lrock1 = 7,
	/obj/structure/flora/chomp/bones/lrock2 = 7,
	/obj/structure/flora/chomp/bones/lrock3 = 7,
	/obj/structure/flora/chomp/bones/lrock4 = 7,
	))

GLOBAL_LIST_INIT(plant_type_weighted, list(
	"grass" = 50,
	"medicinal" = 10,
	"tree" = 10,
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


GLOBAL_LIST_INIT(dirt_loots, list(
	/obj/item/stack/crafting/metalparts/five = 30,
	/obj/item/stack/crafting/goodparts/five = 30,
	/obj/item/stack/ore/blackpowder/twenty = 10,))
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
		var/obj/derp = pickweight(GLOB.dirt_loots)
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
		var/obj/derp = pickweight(GLOB.dirt_loots)
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
	greeble = "nest"

/turf/open/indestructible/ground/outside/dirt/Initialize()
	. = ..()
	if(icon_state == "dirtfull")
		if(SSweather.snowy_time)
			name = "snow"
			icon = 'icons/fallout/turfs/dirt.dmi'
			icon_state = "snow[rand(0,12)]"
			update_icon()

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
	greeble = "junklist"


GLOBAL_LIST_INIT(dust_spawn_list, list(
	/obj/effect/decal/cleanable/dirt = 90,
	/obj/effect/decal/remains = 1,
	/obj/effect/decal/cleanable/blood/drip = 1,
	/obj/structure/bonfire/prelit = 1, 
	/obj/effect/decal/waste = 1,
	/obj/structure/barricade/sandbags = 1,
	/obj/item/shard = 1, 
	/obj/effect/decal/cleanable/generic = 1,
	/obj/effect/decal/cleanable/glass = 1,
	/obj/structure/flora/grass/coyote/one = 1,
	/obj/structure/flora/grass/coyote/two = 1,
	/obj/structure/flora/grass/coyote/three = 1,
	/obj/structure/flora/grass/coyote/four = 1,
	/obj/structure/flora/grass/coyote/five = 1,
	/obj/structure/flora/grass/coyote/three = 1,
	))

GLOBAL_LIST_INIT(trash_spawn_list, list(
	/obj/effect/spawner/lootdrop/trash = 5,
	))

GLOBAL_LIST_INIT(salvage_spawn_list, list(
	/obj/effect/decal/cleanable/dirt = 50,
	/obj/structure/car = 10,
	/obj/structure/car/rubbish1 = 10,
	/obj/structure/car/rubbish2 = 10,
	/obj/structure/car/rubbish3 = 10,
	/obj/structure/car/rubbish4 = 10,
	/obj/effect/decal/cleanable/oil/slippery = 10,
	/obj/item/mine/emp = 1,
	/obj/item/mine/shrapnel = 1,
	))

GLOBAL_LIST_INIT(nest_spawn_list, list(
	/obj/effect/decal/cleanable/dirt = 5,
	/obj/structure/nest/gecko = 5,
	/obj/structure/nest/radroach = 5,
	/obj/structure/nest/molerat = 5,
	))

GLOBAL_LIST_INIT(junk_type_weighted, list(
	"dust" = 89,
	"trash" = 5,
	"salvage" = 5,
	"nest" = 1
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
	greeble = "junklist"
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
	. = ..()
	// if(istype(AM, /mob/living))
	// 	var/mob/living/L = AM
	// 	L.update_water()
	// 	if(L.check_submerged() <= 0)
	// 		return
	// 	if(!istype(oldloc, /turf/open/indestructible/ground/outside/water))
	// 		to_chat(L, span_warning("You get drenched in water!"))
	AM.water_act(5)

// /turf/open/indestructible/ground/outside/water/Exited(atom/movable/AM, atom/newloc)
// 	. = ..()
// 	if(istype(AM, /mob/living))
// 		var/mob/living/L = AM
// 		L.update_water()
// 		if(L.check_submerged() <= 0)
// 			return
// 		if(!istype(newloc, /turf/open/indestructible/ground/outside/water))
// 			to_chat(L, span_warning("You climb out of \the [src]."))

/turf/open/indestructible/ground/outside/water/update_icon()
	. = ..()

/turf/open/indestructible/ground/outside/water/AltClick(mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/L = user
		L.DelayNextAction(CLICK_CD_MELEE)
		if(!user.incapacitated(allow_crit = TRUE) && Adjacent(user))
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
	footstep = FOOTSTEP_SAND
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
	footstep = FOOTSTEP_ROAD
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

//Light dirt readded
/turf/open/indestructible/ground/outside/dirt/light
	name = "dirt"
	icon = 'icons/fallout/turfs/dirt.dmi'
	icon_state = "dirt_light"

/turf/open/indestructible/ground/outside/dirt/dirtgrasscorner
	name = "grass"
	icon = 'icons/fallout/turfs/dirt.dmi'
	icon_state = "dirtgrasscorner"

/turf/open/indestructible/ground/outside/dirt/dirtgrassline
	name = "grass"
	icon = 'icons/fallout/turfs/dirt.dmi'
	icon_state = "dirtgrassline"

/turf/open/indestructible/ground/outside/civ/grassdark
	name = "grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "grass_dark"

/turf/open/indestructible/ground/outside/civ/grass0
	name = "grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "grass0"

/turf/open/indestructible/ground/outside/civ/grass1
	name = "grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "grass1"

/turf/open/indestructible/ground/outside/civ/grass2
	name = "grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "grass2"

/turf/open/indestructible/ground/outside/civ/grass3
	name = "grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "grass3"

/turf/open/indestructible/ground/outside/civ/drygrass
	name = "dry grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "dry_grass"

/turf/open/indestructible/ground/outside/civ/drygrass0
	name = "dry grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "dead_grass0"

/turf/open/indestructible/ground/outside/civ/drygrass1
	name = "dry grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "dead_grass1"

/turf/open/indestructible/ground/outside/civ/drygrass2
	name = "dry grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "dead_grass2"

/turf/open/indestructible/ground/outside/civ/drygrass3
	name = "dry grass"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "dead_grass3"

/turf/open/indestructible/ground/outside/civ/woodalt
	name = "wood"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "woodalt"

/turf/open/indestructible/ground/outside/civ/thatch1
	name = "thatch"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "thatch1"

/turf/open/indestructible/ground/outside/civ/thatch2
	name = "thatch"
	icon = 'icons/fallout/turfs/civfloor.dmi'
	icon_state = "thatch2"


//bamboo
/turf/open/floor/bamboo
	desc = "A bamboo mat with a decorative trim."
	icon = 'icons/turf/floors/bamboo_mat.dmi'
	icon_state = "mat-0"
	base_icon_state = "mat"
	floor_tile = /obj/item/stack/tile/bamboo
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_BAMBOO_FLOOR
	canSmoothWith = SMOOTH_GROUP_BAMBOO_FLOOR
	flags_1 = NONE
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/indestructible/ground/bamboo
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-255"

/turf/open/indestructible/ground/bamboo/one
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-0"

/turf/open/indestructible/ground/bamboo/two
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-1"

/turf/open/indestructible/ground/bamboo/three
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-2"

/turf/open/indestructible/ground/bamboo/four
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-3"

/turf/open/indestructible/ground/bamboo/five
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-4"

/turf/open/indestructible/ground/bamboo/six
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-5"

/turf/open/indestructible/ground/bamboo/seven
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-6"

/turf/open/indestructible/ground/bamboo/eight
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-7"

/turf/open/indestructible/ground/bamboo/nine
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-8"

/turf/open/indestructible/ground/bamboo/ten
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-9"

/turf/open/indestructible/ground/bamboo/eleven
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-10"

/turf/open/indestructible/ground/bamboo/twelve
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-11"

/turf/open/indestructible/ground/bamboo/thirteen
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-12"

/turf/open/indestructible/ground/bamboo/fourteen
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-13"

/turf/open/indestructible/ground/bamboo/fifteen
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-14"

/turf/open/indestructible/ground/bamboo/sixteen
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-15"

/turf/open/indestructible/ground/bamboo/seventeen
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-21"

/turf/open/indestructible/ground/bamboo/eighteen
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-23"

/turf/open/indestructible/ground/bamboo/nineteen
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-29"

/turf/open/indestructible/ground/bamboo/twenty
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-31"

/turf/open/indestructible/ground/bamboo/twentyone
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-38"

/turf/open/indestructible/ground/bamboo/twentytwo
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-39"

/turf/open/indestructible/ground/bamboo/twentythree
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-38"

/turf/open/indestructible/ground/bamboo/twentyfour
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-39"

/turf/open/indestructible/ground/bamboo/twentyfive
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-46"

/turf/open/indestructible/ground/bamboo/twentysix
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-47"

/turf/open/indestructible/ground/bamboo/twentyseven
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-55"

/turf/open/indestructible/ground/bamboo/twentyeight
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-63"

/turf/open/indestructible/ground/bamboo/twentynine
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-74"

/turf/open/indestructible/ground/bamboo/thirty
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-38"

/turf/open/indestructible/ground/bamboo/thirtyone
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-39"

/turf/open/indestructible/ground/bamboo/thirtytwo
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-46"

/turf/open/indestructible/ground/bamboo/thirtythree
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-47"

/turf/open/indestructible/ground/bamboo/thirtyfour
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-55"

/turf/open/indestructible/ground/bamboo/thirtyfive
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-63"

/turf/open/indestructible/ground/bamboo/thirtysix
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-74"

/turf/open/indestructible/ground/bamboo/thirtyseven
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-74"

/turf/open/indestructible/ground/bamboo/thirtyeight
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-75"

/turf/open/indestructible/ground/bamboo/thirtynine
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-78"

/turf/open/indestructible/ground/bamboo/fourty
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-79"

/turf/open/indestructible/ground/bamboo/fourtyone
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-95"

/turf/open/indestructible/ground/bamboo/fourtytwo
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-95"

/turf/open/indestructible/ground/bamboo/fourtythree
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-110"

/turf/open/indestructible/ground/bamboo/fourtyfour
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-111"

/turf/open/indestructible/ground/bamboo/fourtyfive
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-127"

/turf/open/indestructible/ground/bamboo/fourtysix
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-137"

/turf/open/indestructible/ground/bamboo/fourtyseven
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-139"

/turf/open/indestructible/ground/bamboo/fourtyeight
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-141"

/turf/open/indestructible/ground/bamboo/fourtynine
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-143"

/turf/open/indestructible/ground/bamboo/fifty
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-157"

/turf/open/indestructible/ground/bamboo/fiftyone
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-159"

/turf/open/indestructible/ground/bamboo/fiftytwo
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-159"

/turf/open/indestructible/ground/bamboo/fiftythree
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-159"

/turf/open/indestructible/ground/bamboo/fiftyfour
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-159"

/turf/open/indestructible/ground/bamboo/fiftyfive
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-175"

/turf/open/indestructible/ground/bamboo/fiftysix
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-191"

/turf/open/indestructible/ground/bamboo/fiftyseven
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-191"

/turf/open/indestructible/ground/bamboo/fiftyeight
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-203"

/turf/open/indestructible/ground/bamboo/fiftynine
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-207"

/turf/open/indestructible/ground/bamboo/sixty
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-223"

/turf/open/indestructible/ground/bamboo/sixtyone
	name = "bamboo"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "mat-239"

/turf/open/indestructible/ground/bamboo/tatamipurple
	name = "tatami"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "tatami_purple"

/turf/open/indestructible/ground/bamboo/tatamigreen
	name = "tatami"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "tatami_green"

/turf/open/indestructible/ground/bamboo/tatamiblack
	name = "tatami"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "tatami_black"

/turf/open/indestructible/ground/stellercarpet
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "steller_carpet-0"

/turf/open/indestructible/ground/stellercarpet/one
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-1"

/turf/open/indestructible/ground/stellercarpet/two
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-2"

/turf/open/indestructible/ground/stellercarpet/three
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-3"

/turf/open/indestructible/ground/stellercarpet/four
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-4"

/turf/open/indestructible/ground/stellercarpet/five
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-5"

/turf/open/indestructible/ground/stellercarpet/six
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-6"

/turf/open/indestructible/ground/stellercarpet/seven
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-7"

/turf/open/indestructible/ground/stellercarpet/eight
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-8"

/turf/open/indestructible/ground/stellercarpet/nine
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-9"

/turf/open/indestructible/ground/stellercarpet/ten
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-10"

/turf/open/indestructible/ground/stellercarpet/eleven
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-11"

/turf/open/indestructible/ground/stellercarpet/twelve
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-12"

/turf/open/indestructible/ground/stellercarpet/thirteen
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-13"

/turf/open/indestructible/ground/stellercarpet/fourteen
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-14"

/turf/open/indestructible/ground/stellercarpet/fiveteen
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-15"

/turf/open/indestructible/ground/stellercarpet/sixteen
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-21"

/turf/open/indestructible/ground/stellercarpet/seventeen
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-23"

/turf/open/indestructible/ground/stellercarpet/eightteen
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-29"

/turf/open/indestructible/ground/stellercarpet/nineteen
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-31"

/turf/open/indestructible/ground/stellercarpet/twenty
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-38"

/turf/open/indestructible/ground/stellercarpet/twentyone
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-39"

/turf/open/indestructible/ground/stellercarpet/twentythree
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-46"

/turf/open/indestructible/ground/stellercarpet/twentyfour
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-47"

/turf/open/indestructible/ground/stellercarpet/twentyfive
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-55"

/turf/open/indestructible/ground/stellercarpet/twentysix
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-63"

/turf/open/indestructible/ground/stellercarpet/twentyseven
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-74"

/turf/open/indestructible/ground/stellercarpet/twentyeight
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-75"

/turf/open/indestructible/ground/stellercarpet/twentynine
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-78"

/turf/open/indestructible/ground/stellercarpet/thirty
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-79"

/turf/open/indestructible/ground/stellercarpet/thirtyone
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-95"

/turf/open/indestructible/ground/stellercarpet/thirtytwo
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-110"

/turf/open/indestructible/ground/stellercarpet/thirtythree
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-111"

/turf/open/indestructible/ground/stellercarpet/thirtyfour
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-127"

/turf/open/indestructible/ground/stellercarpet/thirtyfive
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-127"

/turf/open/indestructible/ground/stellercarpet/thirtysix
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-137"

/turf/open/indestructible/ground/stellercarpet/thirtyseven
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-139"

/turf/open/indestructible/ground/stellercarpet/thirtyeight
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-141"

/turf/open/indestructible/ground/stellercarpet/thirtynine
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-143"

/turf/open/indestructible/ground/stellercarpet/fourty
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-157"

/turf/open/indestructible/ground/stellercarpet/fourtyone
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-159"

/turf/open/indestructible/ground/stellercarpet/fourtytwo
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-175"

/turf/open/indestructible/ground/stellercarpet/fourtythree
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-191"

/turf/open/indestructible/ground/stellercarpet/fourtyfour
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-203"

/turf/open/indestructible/ground/stellercarpet/fourtyfive
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-207"

/turf/open/indestructible/ground/stellercarpet/fourtysix
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-223"

/turf/open/indestructible/ground/stellercarpet/fourtyseven
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-239"

/turf/open/indestructible/ground/stellercarpet/fourtyeight
	name = "steller carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "stellar_carpet-255"

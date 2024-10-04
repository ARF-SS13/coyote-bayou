///////////////////////////
// Diggy hole			//
//////////////////////////

/*/datum/crafting_recipe/trashloot
	name = "Quickly dig up trash"
	result = /obj/effect/spawner/lootdrop/f13/trash
	reqs = list() // This should mean it requires nothing to craft, right?
	tools = list()
	time = 6 SECONDS //Beast master can do the same thing in 10, lowered from 12 initally because this is its singular gimmick
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/trashloot/check_requirements(mob/user, list/collected_requirements)
	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_TREASURE_HUNTER))
			return TRUE
	return FALSE

/datum/crafting_recipe/trashloot/on_finished(atom/a, atom/parent)
	if(!parent)
		return
	parent.visible_message(span_notice("[parent] digs up some stuff!"))
	playsound(get_turf(parent), 'sound/effects/shovel_dig.ogg', 50, 1)
*/// The crafting menu __NEEDS__ to be fixed so you cant queue up recipes multiple times first
/*
/datum/crafting_recipe/trashloot/common
	name = "Dig up common loot"
	reqs = list(/obj/item/pickaxe = 1)  // so you at least have to put SOMETHING in
	result = /obj/effect/spawner/lootdrop/f13/common
	time = 30 SECONDS

/datum/crafting_recipe/trashloot/uncommon
	name = "Slowly dig uncommon loot"
	result = /obj/effect/spawner/lootdrop/f13/uncommon
	reqs = list(/obj/item/pickaxe/drill = 1) // so you at least have to put SOMETHING in
	time = 60 SECONDS 
*/

// if you can give me a valid reason just to be able to spawn free shit besides unicorn horn arguments, do let me know 

/*/datum/crafting_recipe/trashloot/rock
	name = "Excavate a strange rock"
	result = /obj/item/strangerock
	reqs = list(/obj/item/pickaxe = 1) // so you at least have to put SOMETHING in
	time = 60 SECONDS */// The crafting menu __NEEDS__ to be fixed so you cant queue up recipes multiple times first

///////////////////////////
//Electronics and Robots//
///////////////////////////
/datum/crafting_recipe/USAeyebot
	name = "Propaganda eyebot"
	result = /mob/living/simple_animal/pet/dog/eyebot
	reqs = list(/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2)
	tools = list(TOOL_WORKBENCH)
	time = 40
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/trading_machine
	name = "Vending machine"
	result = /obj/machinery/trading_machine
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/cable_coil = 10)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/tile/plasteel = 1,
				/obj/item/stack/cable_coil = 2,
				/obj/item/assembly/igniter = 1)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/mousetrap
	name = "Mousetrap"
	result = /obj/item/assembly/mousetrap
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/rods = 1)
	time = 10
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/igniter
	name = "Igniter"
	result = /obj/item/assembly/igniter
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 1)
	time = 10
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/health_sensor
	name = "Health sensor"
	result = /obj/item/assembly/health
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/timer
	name = "Timer"
	result = /obj/item/assembly/timer
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/signaler
	name = "Remote signaling device"
	result = /obj/item/assembly/signaler
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 2)
	time = 10
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/infrared
	name = "Infrared emitter"
	result = /obj/item/assembly/infra
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/proximity
	name = "Proximity sensor"
	result = /obj/item/assembly/prox_sensor
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/tile/plasteel = 1,
				/obj/item/stack/cable_coil = 2,
				/obj/item/assembly/igniter = 1)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/mousetrap
	name = "Mouse Trap"
	result = /obj/item/assembly/mousetrap
	time = 10
	reqs = list(/obj/item/stack/sheet/cardboard = 1,
				/obj/item/stack/rods = 1)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/////////////////////
//Farming & Cooking//
/////////////////////

/datum/crafting_recipe/barrel //in wooden inhand now
	name = "Wooden Barrel"
	result = /obj/structure/fermenting_barrel
	reqs = 	list(/obj/item/stack/sheet/mineral/wood = 8,
				/obj/item/stack/rods = 1)
	time = 30
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/dryingrack //In sandstone inhand now
	name = "Drying Rack"
	result = /obj/machinery/smartfridge/drying_rack
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/metal = 3)
	time = 30
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/seedextractor //In metal inhand now
	name = "Seed Extractor"
	result = /obj/structure/legion_extractor
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20,
				/obj/item/stack/sheet/metal = 5)
	time = 40
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/television
	name = "Pre-Fall Television"
	result = /obj/structure/junk/small/prefalltv
	reqs = list(/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/metal = 5)
	time = 30
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/stove
	name = "Cook stove"
	result = /obj/machinery/microwave/stove
	reqs = list(/obj/item/stack/crafting/electronicparts = 3,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/cable_coil = 2,
				/obj/item/assembly/igniter = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/bellystove
	name = "Pot belly stove"
	result = /obj/structure/campfire/stove
	reqs = list(/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/metal = 10)
	tools = list(TOOL_WELDER)
	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/fireplace
	name = "Stone fireplace"
	result = /obj/structure/fireplace
	reqs = list(/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/mineral/sandstone = 20)

	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/grill
	name = "Grill"
	result = /obj/machinery/grill
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/goodparts = 5)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/fishingrod
	name = "Fishing Rod"
	result = /obj/item/fishingrod
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/beartrap
	name = "Bear trap"
	result = /obj/item/restraints/legcuffs/beartrap
	reqs = list(/obj/item/stack/crafting/goodparts = 1) //For the mechanism of the bear trap, crafting parts are needed.
	tools = list(TOOL_WORKBENCH)
	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

	
/datum/crafting_recipe/stairsnorth
	name = "North facing stairs"
	result = /obj/structure/stairs/north
	reqs = list(/obj/item/stack/sheet/mineral/wood = 30) 
	tools = list(TOOL_WORKBENCH)
	time = 120
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/stairseast
	name = "East facing stairs"
	result = /obj/structure/stairs/east
	reqs = list(/obj/item/stack/sheet/mineral/wood = 30) 
	tools = list(TOOL_WORKBENCH)
	time = 120
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/stairssouth
	name = "South facing stairs"
	result = /obj/structure/stairs/south
	reqs = list(/obj/item/stack/sheet/mineral/wood = 30) 
	tools = list(TOOL_WORKBENCH)
	time = 120
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/stairswest
	name = "West facing stairs"
	result = /obj/structure/stairs/west
	reqs = list(/obj/item/stack/sheet/mineral/wood = 30) 
	tools = list(TOOL_WORKBENCH)
	time = 120
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/*
/datum/crafting_recipe/msgterminal
	name = "Communications terminal"
	result = /obj/machinery/msgterminal/machined
	reqs = list(/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/assembly/signaler = 1)
	tools = list(TOOL_WORKBENCH)
	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/pigeonterminal
	name = "Pigeon carrier (Communications terminal)"
	result = /obj/machinery/msgterminal/pigeon
	reqs = list(/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/assembly/signaler = 1)
	tools = list(TOOL_WORKBENCH)
	time = 80
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC
*/

/datum/crafting_recipe/brickwall
	name = "Brick Wall"
	result = /turf/closed/wall/mineral/brick
	reqs = list(/obj/item/ammo_casing/caseless/brick = 8)
	time = 60
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/sand
	name = "Crush rocks"
	result = /obj/item/stack/ore/glass/three
	reqs = list(/obj/item/ammo_casing/caseless/rock = 3)
	time = 15
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/duckbot
	name = "Amusing Duck"
	result = /mob/living/simple_animal/hostile/amusing_duck
	reqs = list(/obj/item/multitool = 1,
				/obj/item/flashlight = 1,
				/obj/item/light/bulb = 1,
				/obj/item/storage/fancy/egg_box = 5,
				/obj/item/grenade/f13/dynamite = 1)
	time = 40
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC



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
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

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
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/metal = 1,
				  /obj/item/stack/tile/plasteel = 1,
				  /obj/item/stack/cable_coil = 2,
				  /obj/item/assembly/igniter = 1)
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/mousetrap
	name = "Mousetrap"
	result = /obj/item/assembly/mousetrap
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/igniter
	name = "Igniter"
	result = /obj/item/assembly/igniter
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 1)
	time = 10
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/health_sensor
	name = "Health sensor"
	result = /obj/item/assembly/health
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/timer
	name = "Timer"
	result = /obj/item/assembly/timer
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/signaler
	name = "Remote signaling device"
	result = /obj/item/assembly/signaler
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 2)
	time = 10
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/infrared
	name = "Infrared emitter"
	result = /obj/item/assembly/infra
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/proximity
	name = "Proximity sensor"
	result = /obj/item/assembly/prox_sensor
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/metal = 1,
				  /obj/item/stack/tile/plasteel = 1,
				  /obj/item/stack/cable_coil = 2,
				  /obj/item/assembly/igniter = 1)
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/datum/crafting_recipe/mousetrap
	name = "Mouse Trap"
	result = /obj/item/assembly/mousetrap
	time = 10
	reqs = list(/obj/item/stack/sheet/cardboard = 1,
				/obj/item/stack/rods = 1)
	category = CAT_CRAFTING
	subcategory = CAT_ROBOT

/////////////////////
//Farming & Cooking//
/////////////////////

/datum/crafting_recipe/barrel
	name = "Wooden Barrel"
	result = /obj/structure/fermenting_barrel
	reqs = 	list(/obj/item/stack/sheet/mineral/wood = 8,
				/obj/item/stack/rods = 1)
	time = 30
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/dryingrack
	name = "Drying Rack"
	result = /obj/machinery/smartfridge/drying_rack
	reqs = 	list(/obj/item/stack/sheet/mineral/wood = 10)
	time = 15
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/growbin
	name = "Grow Bin"
	result = /obj/machinery/smartfridge/bottlerack/grownbin
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20)
	time = 40
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/seedbin
	name = "Seed Bin"
	result = /obj/machinery/smartfridge/bottlerack/seedbin
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20)
	time = 40
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/compost
	name = "Compost Bin"
	result = /obj/structure/reagent_dispensers/compostbin
	reqs = list(/obj/item/stack/sheet/mineral/wood = 25)
	time = 40
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/seedextractor
	name = "Seed Extractor"
	result = /obj/structure/legion_extractor
	reqs = list(/obj/item/stack/sheet/mineral/wood = 25)
	time = 40
	subcategory = CAT_FARMING
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
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/bellystove
	name = "Pot belly stove"
	result = /obj/structure/campfire/stove
	reqs = list(/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/metal = 10)
	tools = list(TOOL_WELDER, TOOL_WORKBENCH)
	time = 80
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/grill
	name = "Grill"
	result = /obj/machinery/grill
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/goodparts = 5)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/fishingrod
	name = "Fishing Rod"
	result = /obj/item/fishingrod
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/rollingpin
	name = "Rolling Pin"
	result = /obj/item/kitchen/rollingpin
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2)
	time = 30
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/choppingblock
	name = "Chopping Block"
	result = /obj/item/chopping_block
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2)
	time = 30
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/meatspikeframe
	name = "Meatspike Frame"
	result = /obj/structure/kitchenspike_frame
	reqs = list(/obj/item/stack/sheet/metal = 1)
	time = 25
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/loom
	name = "Weaving Loom"
	result = /obj/structure/loom
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10)
	time = 15
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/honeyapiary
	name = "Apiary"
	result = /obj/structure/beebox
	reqs = list(/obj/item/stack/sheet/mineral/wood = 40)
	time = 50
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/honeyframe
	name = "Honey Frame"
	result = /obj/item/honey_frame
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5)
	time = 10
	subcategory = CAT_FARMING
	category = CAT_MISC
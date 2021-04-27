/datum/crafting_recipe/workbench
	name = "workbench"
	result = /obj/machinery/workbench
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/lighter = 1,
				/obj/item/reagent_containers/glass/beaker = 1,
				/obj/item/screwdriver = 1,
				/obj/item/crowbar = 1,
				/obj/item/wrench = 1,
				/obj/item/wirecutters = 1,
				/obj/item/stack/crafting/metalparts = 5)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/stove
	name = "cook stove"
	result = /obj/machinery/microwave/stove
	reqs = list(/obj/item/stack/crafting/electronicparts = 3,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/cable_coil = 2,
				/obj/item/assembly/igniter = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/bellystove
	name = "pot belly stove"
	result = /obj/structure/campfire/stove
	reqs = list(/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/metal = 10)
	tools = list(TOOL_WELDER, TOOL_WORKBENCH)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/trading_machine
	name = "vending machine"
	result = /obj/machinery/trading_machine
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/cable_coil = 10)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/shower
	name = "shower"
	result = /obj/machinery/shower
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 10)
	tools = list(TOOL_WRENCH, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/grill
	name = "grill"
	result = /obj/machinery/grill
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/goodparts = 5)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/barrelfire
	name = "stoke barrel fire"
	result = /obj/structure/campfire/barrel
	reqs = list(/obj/item/stack/sheet/mineral/wood = 15,
				/obj/item/stack/sheet/metal = 10)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/USAeyebot
	name = "Propaganda eyebot"
	result = /mob/living/simple_animal/pet/dog/eyebot
	reqs = list(/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2)
	tools = list(TOOL_WORKBENCH)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/showercurtain
	name = "Shower Curtains"
	reqs = 	list(/obj/item/stack/sheet/cloth = 2, /obj/item/stack/sheet/plastic = 2, /obj/item/stack/rods = 1)
	result = /obj/structure/curtain
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/metal = 1,
				  /obj/item/stack/tile/plasteel = 1,
				  /obj/item/stack/cable_coil = 2,
				  /obj/item/assembly/igniter = 1)
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/mousetrap
	name = "Mousetrap"
	result = /obj/item/assembly/mousetrap
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/igniter
	name = "Igniter"
	result = /obj/item/assembly/igniter
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 1)
	time = 10
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/health_sensor
	name = "Health sensor"
	result = /obj/item/assembly/health
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/timer
	name = "Timer"
	result = /obj/item/assembly/timer
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/signaler
	name = "Remote signaling device"
	result = /obj/item/assembly/signaler
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 2)
	time = 10
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/infrared
	name = "Infrared emitter"
	result = /obj/item/assembly/infra
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/proximity
	name = "Proximity sensor"
	result = /obj/item/assembly/prox_sensor
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_MISC
	subcategory = CAT_TOOL

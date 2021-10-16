/datum/crafting_recipe/workbench
	name = "Workbench"
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
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/crudewire
	name = "Crude Cutters"
	result = /obj/item/wirecutters/crude
	time = 80
	reqs = list(/obj/item/stack/rods = 2)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/crudeweld
	name = "Crude Welder"
	result = /obj/item/weldingtool/crude
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/rods = 2)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/crudewrench
	name = "Crude Wrench"
	result = /obj/item/wrench/crude
	time = 80
	reqs = list(/obj/item/stack/rods = 2)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/crudebar
	name = "Crude Crowbar"
	result = /obj/item/crowbar/crude
	time = 80
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/metal = 1)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/crudescrew
	name = "Crude Screwdriver"
	result = /obj/item/screwdriver/crude
	time = 80
	reqs = list(/obj/item/stack/rods = 2)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/*
/datum/crafting_recipe/basicvolt
	name = "Crude Voltage Scanner"
	result = /obj/item/multitool/basic
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/glass = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_ASSEM
	subcategory = CAT_TOOLS
*/

/datum/crafting_recipe/basicwire
	name = "Basic Cutters"
	result = /obj/item/wirecutters/basic
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/basicweld
	name = "Basic Welder"
	result = /obj/item/weldingtool/basic
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 4)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/basicwrench
	name = "Basic Wrench"
	result = /obj/item/wrench/basic
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/basicbar
	name = "Basic Crowbar"
	result = /obj/item/crowbar/basic
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/basicscrew
	name = "Basic Screwdriver"
	result = /obj/item/screwdriver/basic
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

/datum/crafting_recipe/lockpick_basic
	name = "Beginner Lockpick Set"
	result = /obj/item/lockpick_set
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CRAFTING
	subcategory = CAT_TOOL

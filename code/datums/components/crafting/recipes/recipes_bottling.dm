/datum/crafting_recipe/bottler
	name = "Bottle Press"
	result = /obj/machinery/workbench/bottler
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/cable_coil = 10,
				/obj/item/wrench = 1)
	tools = list(TOOL_WRENCH, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 80
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/bottle
	name = "brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown
	reqs = list(/obj/item/stack/sheet/glass = 3,
				/obj/item/stack/f13Cash = 1)
	tools = list(TOOL_BOTTLER)
	time = 10
	category = CAT_BOTTLE

/datum/crafting_recipe/bottle/darkbrown
	name = "dark brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/darkbrown

/datum/crafting_recipe/bottle/lightbrown
	name = "light brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/lightbrown

/datum/crafting_recipe/bottle/white
	name = "white bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/white

/datum/crafting_recipe/bottle/green
	name = "green bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/green

/datum/crafting_recipe/bottle/wine
	name = "wine bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/wine

/datum/crafting_recipe/bottle/greenwine
	name = "green wine bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/greenwine

/datum/crafting_recipe/bottle/beerbottle
	name = "beer bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/beer

/datum/crafting_recipe/bottler
	name = "Bottle Press"
	result = /obj/machinery/workbench/bottler
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/crafting/reloader = 1)
	tools = list(TOOL_WRENCH, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_MISC
	subcategory = CAT_BOTTLE

/datum/crafting_recipe/bottle
	reqs = list(/obj/item/stack/sheet/glass = 3,
				/obj/item/stack/f13Cash = 1)
	tools = list(TOOL_BOTTLER)
	time = 10
	category = CAT_MISC
	subcategory = CAT_BOTTLE

/datum/crafting_recipe/bottle/darkbrown
	name = "Rounded brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/darkbrown

/datum/crafting_recipe/bottle/lightbrown
	name = "Square brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/lightbrown

/datum/crafting_recipe/bottle/white
	name = "White bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/white

/datum/crafting_recipe/bottle/green
	name = "Green bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/green

/datum/crafting_recipe/bottle/wine
	name = "Wine bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/wine

/datum/crafting_recipe/bottle/greenwine
	name = "Green wine bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/greenwine

/datum/crafting_recipe/bottle/beerbottle
	name = "Beer bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/beer

/datum/crafting_recipe/bottle/metalflask
	name = "Metal flask"
	result = /obj/item/reagent_containers/food/drinks/flask
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/f13Cash = 1)

/datum/crafting_recipe/bottle/export
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol = 50
				)

/datum/crafting_recipe/bottle/export/gin
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/gin = 50
				)
	result = /obj/item/export/bottle/gin

/datum/crafting_recipe/bottle/export/wine
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/wine = 50
				)
	result = /obj/item/export/bottle/wine

/datum/crafting_recipe/bottle/export/whiskey
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/whiskey = 50
				)
	result = /obj/item/export/bottle/whiskey

/datum/crafting_recipe/bottle/export/vodka
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/vodka = 50
				)
	result = /obj/item/export/bottle/vodka

/datum/crafting_recipe/bottle/export/tequila
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/tequila = 50
				)
	result = /obj/item/export/bottle/tequila

/datum/crafting_recipe/bottle/export/patron
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/patron = 50
				)
	result = /obj/item/export/bottle/patron

/datum/crafting_recipe/bottle/export/rum
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/rum = 50
				)
	result = /obj/item/export/bottle/rum

/datum/crafting_recipe/bottle/export/vermouth
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/vermouth = 50
				)
	result = /obj/item/export/bottle/vermouth

/datum/crafting_recipe/bottle/export/kahlua
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/kahlua = 50
				)
	result = /obj/item/export/bottle/kahlua

/datum/crafting_recipe/bottle/export/goldschlager
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/goldschlager = 50
				)
	result = /obj/item/export/bottle/goldschlager

/datum/crafting_recipe/bottle/export/hcider
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/hcider = 50
				)
	result = /obj/item/export/bottle/hcider

/datum/crafting_recipe/bottle/export/cognac
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/cognac = 50
				)
	result = /obj/item/export/bottle/cognac

/datum/crafting_recipe/bottle/export/absinthe
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/absinthe = 50
				)
	result = /obj/item/export/bottle/absinthe

/datum/crafting_recipe/bottle/export/grappa
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/grappa = 50
				)
	result = /obj/item/export/bottle/grappa

/datum/crafting_recipe/bottle/export/sake
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/sake = 50
				)
	result = /obj/item/export/bottle/sake

/datum/crafting_recipe/bottle/export/fernet
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/fernet = 50
				)
	result = /obj/item/export/bottle/fernet

/datum/crafting_recipe/bottle/export/applejack
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/applejack = 50
				)
	result = /obj/item/export/bottle/applejack

/datum/crafting_recipe/bottle/export/champagne
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/champagne = 50
				)
	result = /obj/item/export/bottle/champagne

/datum/crafting_recipe/bottle/export/blazaam
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/blazaam = 50
				)
	result = /obj/item/export/bottle/blazaam

/datum/crafting_recipe/bottle/export/trappist
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/trappist = 50
				)
	result = /obj/item/export/bottle/trappist

/datum/crafting_recipe/bottle/export/minikeg
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/stack/sheet/metal = 1,
				/datum/reagent/consumable/ethanol/beer = 50
				)
	result = /obj/item/export/bottle/minikeg

/datum/crafting_recipe/bottle/export/nukashine
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/nukashine = 50
				)
	result = /obj/item/export/bottle/nukashine

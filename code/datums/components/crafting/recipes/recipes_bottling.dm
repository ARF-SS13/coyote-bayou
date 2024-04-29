/datum/crafting_recipe/bottler
	name = "Bottle Press"
	result = /obj/machinery/workbench/bottler
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/circuitboard/machine/autolathe/ammo/improvised = 1)
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
				/datum/reagent/consumable/ethanol = 100
				)

/datum/crafting_recipe/bottle/export/gin
	name = "Sealed bottle of gin"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/gin = 100
				)
	result = /obj/item/export/bottle/gin

/datum/crafting_recipe/bottle/export/wine
	name = "Sealed bottle of wine"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/wine = 100
				)
	result = /obj/item/export/bottle/wine

/datum/crafting_recipe/bottle/export/whiskey
	name = "Sealed bottle of whiskey"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/whiskey = 100
				)
	result = /obj/item/export/bottle/whiskey

/datum/crafting_recipe/bottle/export/vodka
	name = "Sealed bottle of vodka"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/vodka = 100
				)
	result = /obj/item/export/bottle/vodka

/datum/crafting_recipe/bottle/export/tequila
	name = "Sealed bottle of tequila"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/tequila = 100
				)
	result = /obj/item/export/bottle/tequila

/datum/crafting_recipe/bottle/export/patron
	name = "Sealed bottle of patron"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/patron = 100
				)
	result = /obj/item/export/bottle/patron

/datum/crafting_recipe/bottle/export/rum
	name = "Sealed bottle of rum"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/rum = 100
				)
	result = /obj/item/export/bottle/rum

/datum/crafting_recipe/bottle/export/vermouth
	name = "Sealed bottle of vermouth"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/vermouth = 100
				)
	result = /obj/item/export/bottle/vermouth

/datum/crafting_recipe/bottle/export/kahlua
	name = "Sealed bottle of kahlua"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/kahlua = 100
				)
	result = /obj/item/export/bottle/kahlua

/datum/crafting_recipe/bottle/export/goldschlager
	name = "Sealed bottle of goldschlager"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/goldschlager = 100
				)
	result = /obj/item/export/bottle/goldschlager

/datum/crafting_recipe/bottle/export/hcider
	name = "Sealed bottle of hcider"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/hcider = 100
				)
	result = /obj/item/export/bottle/hcider

/datum/crafting_recipe/bottle/export/cognac
	name = "Sealed bottle of cognac"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/cognac = 100
				)
	result = /obj/item/export/bottle/cognac

/datum/crafting_recipe/bottle/export/absinthe
	name = "Sealed bottle of absinthe"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/absinthe = 100
				)
	result = /obj/item/export/bottle/absinthe

/datum/crafting_recipe/bottle/export/grappa
	name = "Sealed bottle of grappa"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/grappa = 100
				)
	result = /obj/item/export/bottle/grappa

/datum/crafting_recipe/bottle/export/sake
	name = "Sealed bottle of sake"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/sake = 100
				)
	result = /obj/item/export/bottle/sake

/datum/crafting_recipe/bottle/export/fernet
	name = "Sealed bottle of fernet"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/fernet = 100
				)
	result = /obj/item/export/bottle/fernet

/datum/crafting_recipe/bottle/export/applejack
	name = "Sealed bottle of applejack"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/applejack = 100
				)
	result = /obj/item/export/bottle/applejack

/datum/crafting_recipe/bottle/export/champagne
	name = "Sealed bottle of champagne"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/champagne = 100
				)
	result = /obj/item/export/bottle/champagne

/datum/crafting_recipe/bottle/export/blazaam
	name = "Sealed bottle of blazaam"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/blazaam = 100
				)
	result = /obj/item/export/bottle/blazaam

/datum/crafting_recipe/bottle/export/trappist
	name = "Sealed bottle of trappist"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/trappist = 100
				)
	result = /obj/item/export/bottle/trappist

/datum/crafting_recipe/bottle/export/minikeg
	name = "Sealed minikeg of beer"
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/stack/sheet/metal = 1,
				/datum/reagent/consumable/ethanol/beer = 100
				)
	result = /obj/item/export/bottle/minikeg

/datum/crafting_recipe/bottle/export/nukashine
	name = "Sealed bottle of cosmicshine"
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/f13Cash = 1,
				/datum/reagent/consumable/ethanol/nukashine = 100
				)
	result = /obj/item/export/bottle/nukashine

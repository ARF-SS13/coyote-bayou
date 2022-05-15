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
	var/sealed_type = /datum/reagent/consumable/ethanol
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/f13Cash = 1,
				[sealed_type] = 50
				)

/datum/crafting_recipe/bottle/export/gin
	sealed_type = /datum/reagent/consumable/ethanol/gin
	result = /obj/item/export/bottle/gin

/datum/crafting_recipe/bottle/export/wine
	sealed_type = /datum/reagent/consumable/ethanol/wine
	result = /obj/item/export/bottle/wine

/datum/crafting_recipe/bottle/export/whiskey
	sealed_type = /datum/reagent/consumable/ethanol/whiskey
	result = /obj/item/export/bottle/whiskey

/datum/crafting_recipe/bottle/export/vodka
	sealed_type = /datum/reagent/consumable/ethanol/vodka
	result = /obj/item/export/bottle/vodka

/datum/crafting_recipe/bottle/export/tequila
	sealed_type = /datum/reagent/consumable/ethanol/tequila
	result = /obj/item/export/bottle/tequila

/datum/crafting_recipe/bottle/export/patron
	sealed_type = /datum/reagent/consumable/ethanol/patron
	result = /obj/item/export/bottle/patron

/datum/crafting_recipe/bottle/export/rum
	sealed_type = /datum/reagent/consumable/ethanol/rum
	result = /obj/item/export/bottle/rum

/datum/crafting_recipe/bottle/export/vermouth
	sealed_type = /datum/reagent/consumable/ethanol/vermouth
	result = /obj/item/export/bottle/vermouth

/datum/crafting_recipe/bottle/export/kahlua
	sealed_type = /datum/reagent/consumable/ethanol/kahlua
	result = /obj/item/export/bottle/kahlua

/datum/crafting_recipe/bottle/export/goldschlager
	sealed_type = /datum/reagent/consumable/ethanol/goldschlager
	result = /obj/item/export/bottle/goldschlager

/datum/crafting_recipe/bottle/export/hcider
	sealed_type = /datum/reagent/consumable/ethanol/hcider
	result = /obj/item/export/bottle/hcider

/datum/crafting_recipe/bottle/export/cognac
	sealed_type = /datum/reagent/consumable/ethanol/cognac
	result = /obj/item/export/bottle/cognac

/datum/crafting_recipe/bottle/export/absinthe
	sealed_type = /datum/reagent/consumable/ethanol/absinthe
	result = /obj/item/export/bottle/absinthe

/datum/crafting_recipe/bottle/export/grappa
	sealed_type = /datum/reagent/consumable/ethanol/grappa
	result = /obj/item/export/bottle/grappa

/datum/crafting_recipe/bottle/export/sake
	sealed_type = /datum/reagent/consumable/ethanol/sake
	result = /obj/item/export/bottle/sake

/datum/crafting_recipe/bottle/export/fernet
	sealed_type = /datum/reagent/consumable/ethanol/fernet
	result = /obj/item/export/bottle/fernet

/datum/crafting_recipe/bottle/export/applejack
	sealed_type = /datum/reagent/consumable/ethanol/applejack
	result = /obj/item/export/bottle/applejack

/datum/crafting_recipe/bottle/export/champagne
	sealed_type = /datum/reagent/consumable/ethanol/champagne
	result = /obj/item/export/bottle/champagne

/datum/crafting_recipe/bottle/export/blazaam
	sealed_type = /datum/reagent/consumable/ethanol/blazaam
	result = /obj/item/export/bottle/blazaam

/datum/crafting_recipe/bottle/export/trappist
	sealed_type = /datum/reagent/consumable/ethanol/trappist
	result = /obj/item/export/bottle/trappist

/datum/crafting_recipe/bottle/export/grenadine
	sealed_type = /datum/reagent/consumable/ethanol/grenadine
	result = /obj/item/export/bottle/grenadine

/datum/crafting_recipe/bottle/export/minikeg
	sealed_type = /datum/reagent/consumable/ethanol/beer
	result = /obj/item/export/bottle/minikeg

/datum/crafting_recipe/bottle/export/blooddrop
	sealed_type = /datum/reagent/consumable/ethanol/blooddrop
	result = /obj/item/export/bottle/blooddrop

/datum/crafting_recipe/bottle/export/slim_gold
	sealed_type = /datum/reagent/consumable/ethanol/slim_gold
	result = /obj/item/export/bottle/slim_gold

/datum/crafting_recipe/bottle/export/white_bloodmoon
	sealed_type = /datum/reagent/consumable/ethanol/white_bloodmoon
	result = /obj/item/export/bottle/white_bloodmoon

/datum/crafting_recipe/bottle/export/greenroad
	sealed_type = /datum/reagent/consumable/ethanol/greenroad
	result = /obj/item/export/bottle/greenroad

/datum/crafting_recipe/bottle/export/nukashine
	sealed_type = /datum/reagent/consumable/ethanol/nukashine
	result = /obj/item/export/bottle/nukashine

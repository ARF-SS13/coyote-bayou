/datum/crafting_recipe/upgraded_gauze
	name = "Improved Gauze"
	result = /obj/item/stack/medical/gauze/adv/one
	time = 50
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/space_cleaner/sterilizine = 10)
	category = CAT_MEDICAL
	blacklist = list(/obj/item/stack/medical/gauze/improvised)

/datum/crafting_recipe/brute_pack
	name = "Suture Pack"
	result = /obj/item/stack/medical/suture/five
	time = 50
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/medicine/styptic_powder = 10)
	category = CAT_MEDICAL

/datum/crafting_recipe/burn_pack
	name = "Regenerative Mesh"
	result = /obj/item/stack/medical/mesh/five
	time = 50
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/medicine/silver_sulfadiazine = 10)
	category = CAT_MEDICAL

/datum/crafting_recipe/healpowder
	name = "Healing powder"
	result = /obj/item/reagent_containers/pill/patch/healingpowder
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2)
	time = 50
	category = CAT_MEDICAL

/datum/crafting_recipe/healpoultice
	name = "Healing poultice"
	result = /obj/item/reagent_containers/pill/patch/healpoultice
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2,
				/obj/item/reagent_containers/food/snacks/grown/feracactus = 2,
				/obj/item/reagent_containers/food/snacks/grown/fungus = 1)
	time = 80
	category = CAT_MEDICAL

/datum/crafting_recipe/stimpak
	name = "Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2,
				/obj/item/reagent_containers/syringe = 1)
	tools = list(TOOL_WORKBENCH)
	time = 50
	category = CAT_MEDICAL

/datum/crafting_recipe/superstimpak
	name = "Super Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak/super
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/reagent_containers/food/snacks/grown/mutfruit = 2)
	tools = list(TOOL_WORKBENCH)
	time = 80
	category = CAT_MEDICAL
	blacklist = list(/obj/item/reagent_containers/hypospray/medipen/stimpak/super)

/datum/crafting_recipe/salvage_stimpak
	name = "Salvage injector"
	result = /obj/item/reagent_containers/syringe
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 1)
	time = 20
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL

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

/datum/crafting_recipe/suture
	name = "Improvised Suture"
	result = /obj/item/stack/medical/suture/emergency/five
	time = 30
	reqs = list(/obj/item/stack/medical/gauze/improvised = 1,
				/datum/reagent/consumable/ethanol = 10)
	category = CAT_MEDICAL

/datum/crafting_recipe/ointment
	name = "Improvised Ointment"
	result = /obj/item/stack/medical/ointment/five
	time = 30
	reqs = list(/obj/item/stack/medical/gauze/improvised = 1,
				/obj/item/reagent_containers/food/snacks/grown/agave = 1)
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
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 3,
				/obj/item/reagent_containers/food/snacks/grown/xander = 3)
	time = 35
	category = CAT_MEDICAL

/datum/crafting_recipe/healpoultice
	name = "Healing poultice"
	result = /obj/item/reagent_containers/pill/patch/healpoultice
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2,
				/obj/item/reagent_containers/food/snacks/grown/feracactus = 2,
				/obj/item/reagent_containers/food/snacks/grown/fungus = 2,
				/obj/item/reagent_containers/food/snacks/grown/pungafruit = 2)
	time = 45
	category = CAT_MEDICAL

/datum/crafting_recipe/stimpak
	name = "Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 4,
				/obj/item/reagent_containers/food/snacks/grown/xander = 4,
				/obj/item/reagent_containers/syringe = 1)
	tools = list(TOOL_WORKBENCH)
	time = 45
	category = CAT_MEDICAL

/datum/crafting_recipe/superstimpak
	name = "Super Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak/super
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/reagent_containers/food/snacks/grown/mutfruit = 2)
	tools = list(TOOL_WORKBENCH)
	time = 50
	category = CAT_MEDICAL
	blacklist = list(/obj/item/reagent_containers/hypospray/medipen/stimpak/super)

/datum/crafting_recipe/salvage_stimpak
	name = "Salvage injector"
	result = /obj/item/reagent_containers/syringe
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 1)
	time = 20
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL


/datum/crafting_recipe/jet
	name = "Jet"
	result = /obj/item/reagent_containers/pill/patch/jet
	reqs = list(/obj/item/clothing/mask/cigarette = 2,
				/datum/reagent/consumable/soymilk = 15,
				/obj/item/toy/crayon/spraycan = 1)
	time = 35
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_availible = FALSE

/datum/crafting_recipe/turbo
	name = "Turbo"
	result = /obj/item/reagent_containers/pill/patch/turbo
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/feracactus = 2,
				/obj/item/reagent_containers/food/snacks/grown/agave = 2,
				/datum/reagent/consumable/ethanol/whiskey = 15)
	time = 35
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_availible = FALSE

/datum/crafting_recipe/psycho
	name = "Psycho"
	result = /obj/item/reagent_containers/hypospray/medipen/psycho
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/feracactus = 3,
				/obj/item/reagent_containers/food/snacks/grown/fungus = 3,
				/datum/reagent/consumable/nuka_cola = 10)
	time = 35
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_availible = FALSE

/datum/crafting_recipe/medx
	name = "Med-X"
	result = /obj/item/reagent_containers/syringe/medx
	reqs = list(/obj/item/reagent_containers/syringe = 1,
				/obj/item/reagent_containers/food/snacks/grown/pungafruit = 2,
				/obj/item/reagent_containers/food/snacks/grown/datura = 2,
				/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2,
				/obj/item/reagent_containers/food/snacks/grown/broc = 2)
	time = 35
	tools = list(TOOL_WORKBENCH, TOOL_WELDER)
	category = CAT_MEDICAL
	always_availible = FALSE

/datum/crafting_recipe/buffout
	name = "Buffout"
	result = /obj/item/storage/pill_bottle/chem_tin/buffout
	reqs = list(/obj/item/storage/pill_bottle = 1,
				/obj/item/reagent_containers/food/snacks/grown/buffalogourd = 10,
				/obj/item/reagent_containers/food/snacks/grown/yucca = 10,
				/obj/item/reagent_containers/food/snacks/grown/mutfruit = 5,
				/datum/reagent/consumable/nuka_cola = 60)
	time = 50
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_availible = FALSE

/datum/crafting_recipe/extract_gaia
	name = "Extract gaia"
	result = /obj/item/reagent_containers/glass/bottle/gaia
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ambrosia/gaia  = 6,
	/datum/reagent/water = 50)
	time = 20
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL

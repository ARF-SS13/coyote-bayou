/datum/crafting_recipe/upgraded_gauze
	name = "Improved Gauze"
	result = /obj/item/stack/medical/gauze/adv/one
	time = 50
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/abraxo_cleaner/sterilizine = 10)
	category = CAT_MEDICAL
	blacklist = list(/obj/item/stack/medical/gauze/improvised)

/datum/crafting_recipe/brute_pack
	name = "Suture Pack"
	result = /obj/item/stack/medical/suture/five
	time = 50
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/medicine/styptic_powder = 10)
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

/datum/crafting_recipe/healpowder  //keep the number of plants needed low so picking wild plants is viable. balance botany instead.
	name = "Healing powder"
	result = /obj/item/reagent_containers/pill/healingpowder
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 1,
				/obj/item/reagent_containers/food/snacks/grown/xander = 1)
	time = 5
	category = CAT_MEDICAL

/datum/crafting_recipe/healpowder5
	name = "Batch of healing powders (x5)"
	result = /obj/item/storage/box/medicine/powder5
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 5,
				/obj/item/reagent_containers/food/snacks/grown/xander = 5)
	time = 10
	category = CAT_MEDICAL

/datum/crafting_recipe/bitterdrink
	name = "Bottle bitterdrink"
	result = /obj/item/reagent_containers/pill/bitterdrink
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 1,
				/obj/item/reagent_containers/food/snacks/grown/xander = 1,
				/obj/item/reagent_containers/glass/bottle = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_MEDICAL
	always_available = FALSE // Only the Twin Mothers Tribe knew the secret to making bitter drink prior to legion annexation. Any clever chemist can bootleg the recipe though.

/datum/crafting_recipe/bitterdrink5
	name = "Batch of bitterdrink (x5)"
	result = /obj/item/storage/box/medicine/bitterdrink5
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 5,
				/obj/item/reagent_containers/food/snacks/grown/xander = 5,
				/obj/item/reagent_containers/glass/bottle = 5)
	tools = list(TOOL_WORKBENCH)
	time = 20
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/healpoultice
	name = "Healing poultice"
	result = /obj/item/reagent_containers/pill/patch/healpoultice
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 1,
				/obj/item/reagent_containers/food/snacks/grown/xander = 1,
				/obj/item/reagent_containers/food/snacks/grown/agave = 1,
				/obj/item/reagent_containers/food/snacks/grown/fungus = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_MEDICAL
	always_available = FALSE // only tribals know the secret

/datum/crafting_recipe/healpoultice5
	name = "Batch of healing poultice (x5)"
	result = /obj/item/storage/box/medicine/poultice5
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 5,
				/obj/item/reagent_containers/food/snacks/grown/xander = 5,
				/obj/item/reagent_containers/food/snacks/grown/agave = 5,
				/obj/item/reagent_containers/food/snacks/grown/fungus = 5)
	tools = list(TOOL_WORKBENCH)
	time = 20
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/smell_salts
	name = "Smelling salts"
	result = /obj/item/smelling_salts
	reqs = list(/datum/reagent/ammonia = 10,                                 //Ammonia forces a intake of respiratory breath reflex, which is the foundation of all good smelling salts.
				/obj/item/reagent_containers/food/snacks/onion_slice = 4,    //Sliced onions, 2 total split into 4 slices.
				/obj/item/reagent_containers/food/snacks/grown/garlic = 2,   //Pungent garlic.
				/obj/item/reagent_containers/food/snacks/grown/bee_balm = 2) //Beebalm was a smelling salt utilized in the victorian era for vaporous herbal remedies to things like sore throats.
	time = 50
	category = CAT_MEDICAL

/datum/crafting_recipe/stimpak // Heals the same amount as healing powder and bitters for its material cost, just more refined and faster.
	name = "Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 1,
				/obj/item/reagent_containers/food/snacks/grown/xander = 1,
				/obj/item/reagent_containers/syringe = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/stimpak/chemistry // Purely chemistry recipe
	name = "Stimpak (from chems)"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak
	reqs = list(/datum/reagent/medicine/stimpak = 20,
				/obj/item/reagent_containers/syringe = 1)
	tools = list(TOOL_CHEMMASTER)
	time = 10
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/stimpak5
	name = "Stimpak x5"
	result = /obj/item/storage/box/medicine/stimpaks/stimpaks5
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 5,
				/obj/item/reagent_containers/food/snacks/grown/xander = 5,
				/obj/item/reagent_containers/syringe = 5)
	tools = list(TOOL_WORKBENCH)
	time = 20
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/stimpak5/chemistry // Purely chemistry recipe
	name = "Stimpak x5 (from chems)"
	result = /obj/item/storage/box/medicine/stimpaks/stimpaks5
	reqs = list(/datum/reagent/medicine/stimpak = 100,
				/obj/item/reagent_containers/syringe = 5)
	tools = list(TOOL_CHEMMASTER)
	time = 20
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/superstimpak
	name = "Super Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak/super // Not terribly hard to make once you secure an advanced workbench. a dangerous chem to rely on completely though.
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
				/obj/item/stack/sheet/leather = 1,
				/obj/item/reagent_containers/food/snacks/grown/mutfruit = 1,
				/datum/reagent/consumable/nuka_cola = 25,
				/datum/reagent/radium = 5) // Nuka-Cola bottles have 5u radium in them.
	tools = list(TOOL_AWORKBENCH)
	time = 10
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/superstimpak5
	name = "Super Stimpak (x5)"
	result = /obj/item/storage/box/medicine/stimpaks/superstimpaks5
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 5,
				/obj/item/stack/sheet/leather = 5,
				/obj/item/reagent_containers/food/snacks/grown/mutfruit = 5,
				/datum/reagent/consumable/nuka_cola = 125,
				/datum/reagent/radium = 25)
	tools = list(TOOL_AWORKBENCH)
	time = 20
	category = CAT_MEDICAL
	always_available = FALSE

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
	reqs = list(/obj/item/clothing/mask/cigarette = 1,
				/datum/reagent/consumable/milk = 10,
				/obj/item/toy/crayon/spraycan = 1)
	time = 35
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/turbo
	name = "Turbo"
	result = /obj/item/reagent_containers/pill/patch/turbo
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/feracactus = 2,
				/obj/item/reagent_containers/food/snacks/grown/agave = 2,
				/datum/reagent/consumable/ethanol/whiskey = 15)
	time = 35
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/psycho
	name = "Psycho"
	result = /obj/item/reagent_containers/hypospray/medipen/psycho
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/feracactus = 3,
				/obj/item/reagent_containers/food/snacks/grown/fungus = 3,
				/datum/reagent/consumable/nuka_cola = 10)
	time = 35
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/medx
	name = "Med-X"
	result = /obj/item/reagent_containers/hypospray/medipen/medx
	reqs = list(/obj/item/reagent_containers/syringe = 1,
				/obj/item/reagent_containers/food/snacks/grown/datura = 2,
				/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 2)
	time = 35
	tools = list(TOOL_WORKBENCH, TOOL_WELDER)
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/medx/chemistry
	name = "Med-X (from chems)"
	result = /obj/item/reagent_containers/hypospray/medipen/medx
	reqs = list(/obj/item/reagent_containers/syringe = 1,
				/datum/reagent/medicine/epinephrine = 5,
				/datum/reagent/medicine/morphine = 5)
	time = 10
	tools = list(TOOL_CHEMMASTER)
	category = CAT_MEDICAL
	always_available = FALSE

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
	always_available = FALSE

/datum/crafting_recipe/steady
	name = "Steady"
	result = /obj/item/reagent_containers/hypospray/medipen/steady
	reqs = list(/datum/reagent/consumable/sunset = 15,
				/obj/item/reagent_containers/food/drinks/bottle = 1,
				/obj/item/reagent_containers/food/snacks/grown/horsenettle = 1,
				/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 1)
	time = 35
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	always_available = FALSE

/datum/crafting_recipe/extract_gaia
	name = "Extract gaia"
	result = /obj/item/reagent_containers/glass/bottle/gaia
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ambrosia/gaia  = 6,
	/datum/reagent/water = 50)
	time = 20
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL

/datum/crafting_recipe/primitive_defib
	name = "Improvised Defibrillator"
	result = /obj/item/defibrillator/primitive
	reqs = list(
	/obj/item/wirecutters = 2,
	/obj/item/stock_parts/cell = 6,
	/obj/item/crafting/lunchbox = 1,
	/obj/item/stack/cable_coil = 30
	)
	time = 100
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL

/datum/crafting_recipe/refill_chem_cartridge
	name = "Refill chemical Cartridge"
	result = /obj/item/stock_parts/chem_cartridge/crafted
	reqs = list(
	/obj/item/stock_parts/chem_cartridge/crafted = 1,
	/datum/reagent/consumable/nutriment = 60
	)
	time = 100
	tools = list(TOOL_WORKBENCH, TOOL_SCREWDRIVER, TOOL_CROWBAR)
	category = CAT_MEDICAL

/datum/crafting_recipe/crafted_chem_cartridge
	name = "Crafted chemical Cartridge"
	result = /obj/item/stock_parts/chem_cartridge/crafted
	reqs = list(
	/obj/item/stack/sheet/metal = 10,
	/obj/item/stack/sheet/leather = 10,
	/obj/item/stack/sheet/cloth = 20,
	/obj/item/stack/sheet/mineral/titanium = 5,
	/obj/item/stack/crafting/electronicparts = 5,
	/datum/reagent/consumable/nutriment = 60
	)
	time = 100
	tools = list(TOOL_WORKBENCH, TOOL_SCREWDRIVER, TOOL_CROWBAR)
	category = CAT_MEDICAL

/datum/crafting_recipe/fiery_purgative
	name = "Fiery purgative"
	result = /obj/item/reagent_containers/pill/fiery_purgative
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/horsenettle = 1,
				/obj/item/reagent_containers/food/snacks/grown/feracactus = 1, //this will have to do in lieu of wild jalapenos
				/datum/reagent/consumable/ethanol/vodka = 50) //distill this from fermented punga
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_MEDICAL

/datum/crafting_recipe/fiery_purgative5
	name = "Fiery purgative (x5)"
	result = /obj/item/storage/box/medicine/fiery_purgative5
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/horsenettle = 5,
				/obj/item/reagent_containers/food/snacks/grown/feracactus = 5,
				/datum/reagent/consumable/ethanol/vodka = 250)
	tools = list(TOOL_WORKBENCH)
	time = 20
	category = CAT_MEDICAL

/obj/item/storage/box/medicine/fiery_purgative5
	name = "box of fiery purgative"
	desc = "A box full of fiery purgative."
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "leather_bag"
	illustration = null

/obj/item/storage/box/medicine/fiery_purgative5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/fiery_purgative(src)

/datum/crafting_recipe/antivenom
	name = "Bottle antivenom"
	result = /obj/item/reagent_containers/pill/antivenom
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 1,
				/obj/item/reagent_containers/food/snacks/grown/xander = 1,
				/obj/item/reagent_containers/food/snacks/grown/datura = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_MEDICAL

/datum/crafting_recipe/antivenom
	name = "Bottle antivenom"
	result = /obj/item/reagent_containers/pill/antivenom
	reqs = list(/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 2,
				/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_MEDICAL

/datum/crafting_recipe/antivenom5
	name = "Bottle antivenom (x5)"
	result = /obj/item/storage/box/medicine/antivenom5
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 5,
				/obj/item/reagent_containers/food/snacks/grown/xander = 5,
				/obj/item/reagent_containers/food/snacks/grown/datura = 5)
	tools = list(TOOL_WORKBENCH)
	time = 20
	category = CAT_MEDICAL

/datum/crafting_recipe/antivenom5_2
	name = "Bottle antivenom (x5)"
	result = /obj/item/storage/box/medicine/antivenom5
	reqs = list(/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 10,
				/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 5)
	tools = list(TOOL_WORKBENCH)
	time = 20
	category = CAT_MEDICAL

/obj/item/storage/box/medicine/antivenom5
	name = "box of antivenom"
	desc = "A box full of antivenom flasks."
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "medicinebox_simple"
	illustration = "overlay_bitter" // eventually will be changed to unique

/obj/item/storage/box/medicine/antivenom5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/antivenom(src)

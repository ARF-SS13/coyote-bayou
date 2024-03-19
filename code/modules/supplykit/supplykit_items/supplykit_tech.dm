/* lab and science gear

//primary vars
/datum/supplykit_item/tech/
	name = 
	desc = 
	item = 
	cost = 

//other vars
	surplus = 100 //if set below 100, reduces chances of being in the surplus crate
	cant_discount = FALSE //if set to true, prevents possible discounts
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy. also prevents discounts.
	restricted_roles = list() //for restricting by job type
	*/


/datum/supplykit_item/tech/xenoarch
	name = "Xenoarch Belt"
	desc = "A belt containing all the tools you need for beginner's xenoarcheology."
	item = /obj/item/storage/belt/xenoarch/full
	cost = 20

/datum/supplykit_item/tech/cellcharger
	name = "Cell Charger Circuit"
	desc = "The thinky bits needed to set up your very own cell charger, for enterprising e-gun users."
	item = /obj/item/circuitboard/machine/cell_charger
	cost = 20

/datum/supplykit_item/tech/reloader
	name = "Makeshift Reloader Parts"
	desc = "The pieces needed to start creating low quality handloads. Just attach it to a table or some wood pieces."
	item = /obj/item/circuitboard/machine/autolathe/ammo/improvised
	cost = 5

/datum/supplykit_item/tech/healthanalyzer
	name = "Health Analyzer"
	desc = "A multipurpose scanner that diagnoses the wellbeing of patients."
	item = /obj/item/healthanalyzer
	cost = 5

/datum/supplykit_item/tech/chemmaster
	name = "Chemmaster Circuit"
	desc = "The electronics needed for a machine that synthesizes chemicals, for those adequately knowledgeable."
	item = /obj/item/circuitboard/machine/chem_master
	cost = 5

/datum/supplykit_item/tech/chemcartridge
	name = "Improvised Chem Cartridge"
	desc = "A cartridge containing the base materials used in the chemmaster to produce medicines."
	item = /obj/item/stock_parts/chem_cartridge/crafted
	cost = 5

/datum/supplykit_item/tech/grinder
	name = "Grinder Circuit"
	desc = "The zappy bits required for a grinder, used to mix foods and grind up plants and objects."
	item = /obj/item/circuitboard/machine/reagentgrinder
	cost = 5

/datum/supplykit_item/tech/blenderbelt
	name = "Blender Belt"
	desc = "A self contained belt mounted grinder, with an AI personality."
	item = /obj/item/storage/blender_belt
	cost = 5

/datum/supplykit_item/tech/chemheater
	name = "Chem Heater Circuit"
	desc = "The fragile pieces for a chem heater, used to cook blue meth and other chemicals."
	item = /obj/item/circuitboard/machine/chem_heater
	cost = 5

/datum/supplykit_item/tech/chembag
	name = "Medical Bag"
	desc = "A clean cloth bag used to hold bottles and medical supplies."
	item = /obj/item/storage/bag/chemistry
	cost = 1

/datum/supplykit_item/tech/sciencegoggles
	name = "Science Goggles"
	desc = "A set of purple goggles that analyze the contents of beakers and medical items, for SCIENCE."
	item = /obj/item/clothing/glasses/science
	cost = 10

/datum/supplykit_item/tech/beakerbox
	name = "Beaker Box"
	desc = "A box full of small beakers, for holding all your bubbling chems."
	item = /obj/item/storage/box/beakers
	cost = 5

/datum/supplykit_item/tech/silverbars
	name = "Silver Bars"
	desc = "Two silver bars, just enough to create a clean surgical table, on a table frame."
	item = /obj/item/stack/sheet/mineral/silver/two
	cost = 5
	limited_stock = 2

/datum/supplykit_item/tech/surgerybag
	name = "Surgery Bag"
	desc = "A duffle containing all the gear needed for successful surgery."
	item = /obj/item/storage/backpack/duffelbag/med/surgery
	cost = 15

/datum/supplykit_item/tech/latexgloves
	name = "Latex Gloves"
	desc = "A pair of sterile gloves for clean surgical operations."
	item = /obj/item/clothing/gloves/color/latex
	cost = 1

/datum/supplykit_item/tech/teleiv
	name = "Telescopic IV Drip"
	desc = "A folding IV drip, for applying gradual doses of blood or other chemicals, or for drawing blood donations."
	item = /obj/item/tele_iv
	cost = 10

/datum/supplykit_item/tech/syringe
	name = "Syringe"
	desc = "A hypodermic needle, used for efficient application of chemicals."
	item = /obj/item/reagent_containers/syringe
	cost = 1

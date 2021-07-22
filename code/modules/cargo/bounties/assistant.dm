//Moved Maint Loot and other assorted bounties to silly.dm

/datum/bounty/item/assistant/scooter
	name = "Scooter"
	description = "Nanotrasen has determined walking to be wasteful. Ship a scooter to CentCom to speed operations up."
	reward = 900 // the mat hoffman
	wanted_types = list(/obj/vehicle/ridden/scooter)
	include_subtypes = FALSE

///datum/bounty/item/assistant/skateboard
//	name = "Skateboard"
//	description = "Nanotrasen has determined walking to be wasteful. Ship a skateboard to CentCom to speed operations up."
//	reward = 800 // the tony hawk
//	wanted_types = list(/obj/vehicle/ridden/scooter/skateboard)


/datum/bounty/item/assistant/soap
	name = "Soap"
	description = "Soap has gone missing from CentCom's bathrooms and nobody knows who took it. Replace it and be the hero CentCom needs."
	reward = 1200
	required_count = 3 //You can (apparently) get soap from the mining rewards vendor.
	wanted_types = list(/obj/item/soap)

/datum/bounty/item/assistant/spear
	name = "Spears"
	description = "CentCom's security forces are going through budget cuts. You will be paid if you ship a set of spears."
	reward = 1000
	required_count = 5
	wanted_types = list(/obj/item/twohanded/spear)

/datum/bounty/item/assistant/toolbox
	name = "Toolboxes"
	description = "There's an absence of robustness at Central Command. Hurry up and ship some toolboxes as a solution."
	reward = 1000
	required_count = 6
	wanted_types = list(/obj/item/storage/toolbox)

/datum/bounty/item/assistant/statue
	name = "Statue"
	description = "Central Command would like to commision an artsy statue for the lobby. Ship one out, when possible."
	reward = 2000
	wanted_types = list(/obj/structure/statue)

/datum/bounty/item/assistant/cheesiehonkers
	name = "Cheesie Honkers"
	description = "Apparently the company that makes Cheesie Honkers is going out of business soon. CentCom wants to stock up before it happens!"
	reward = 1000
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/cheesiehonkers)


// /datum/bounty/item/assistant/donut
// 	name = "Donuts"
// 	description = "CentCom's security forces are facing heavy losses against the Syndicate. Ship donuts to raise morale."
// 	reward = 2000
// 	required_count = 10
// 	wanted_types = list(/obj/item/reagent_containers/food/snacks/donut)

// /datum/bounty/item/assistant/donkpocket
// 	name = "Donk-Pockets"
// 	description = "Consumer safety recall: Warning. Donk-Pockets manufactured in the past year contain hazardous lizard biomatter. Return units to CentCom immediately."
// 	reward = 1000
// 	required_count = 10
// 	wanted_types = list(/obj/item/reagent_containers/food/snacks/donkpocket)

/datum/bounty/item/assistant/briefcase
	name = "Briefcase"
	description = "Central Command will be holding a business convention this year. Ship a few briefcases in support."
	reward = 1200
	required_count = 3
	wanted_types = list(/obj/item/storage/briefcase, /obj/item/storage/secure/briefcase)


/datum/bounty/item/assistant/shard
	name = "Shards"
	description = "A killer clown has been stalking CentCom, and staff have been unable to catch her because she's not wearing shoes. Please ship some shards so that a booby trap can be constructed."
	reward = 750
	required_count = 15
	wanted_types = list(/obj/item/shard)

/datum/bounty/item/assistant/comfy_chair
	name = "Comfy Chairs"
	description = "Commander Pat is unhappy with his chair. He claims it hurts his back. Ship some alternatives out to humor him."
	reward = 900
	required_count = 5
	wanted_types = list(/obj/structure/chair/comfy)

// /datum/bounty/item/assistant/geranium
// 	name = "Geraniums"
// 	description = "Commander Zot has the hots for Commander Zena. Send a shipment of geraniums - her favorite flower - and he'll happily reward you."
// 	reward = 1000
// 	required_count = 3
// 	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/poppy/geranium)

// /datum/bounty/item/assistant/poppy
// 	name = "Poppies"
// 	description = "Commander Zot really wants to sweep Security Officer Olivia off her feet. Send a shipment of Poppies - her favorite flower - and he'll happily reward you."
// 	reward = 1000
// 	required_count = 3
// 	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/poppy)
// 	include_subtypes = FALSE

/datum/bounty/item/assistant/shadyjims
	name = "Shady Jim's"
	description = "There's an irate officer at CentCom demanding that he receive a box of Shady Jim's cigarettes. Please ship one. He's starting to make threats."
	reward = 1150
	wanted_types = list(/obj/item/storage/fancy/cigarettes/cigpack_shadyjims)

/datum/bounty/item/assistant/potted_plants
	name = "Potted Plants"
	description = "Central Command is looking to commission a new BirdBoat-class station. You've been ordered to supply the potted plants."
	reward = 2000
	required_count = 8
	wanted_types = list(/obj/item/kirbyplants)

// /datum/bounty/item/assistant/earmuffs
// 	name = "Earmuffs"
// 	description = "Central Command is getting tired of your station's messages. They've ordered that you ship some earmuffs to lessen the annoyance."
// 	reward = 1000
// 	wanted_types = list(/obj/item/clothing/ears/earmuffs)

/datum/bounty/item/assistant/cuffs
	name = "Handcuffs"
	description = "A large influx of escaped convicts have arrived at Central Command. Now is the perfect time to ship out spare handcuffs (or restraints)."
	reward = 1000
	required_count = 5
	wanted_types = list(/obj/item/restraints/handcuffs)
/* I don't like that you can just buy a box of monkey cubes and finish this for -half- of them.
/datum/bounty/item/assistant/monkey_cubes
	name = "Monkey Cubes"
	description = "Due to a recent genetics accident, Central Command is in serious need of monkeys. Your mission is to ship monkey cubes."
	reward = 2000
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/monkeycube)

/datum/bounty/item/assistant/chainsaw
	name = "Chainsaw"
	description = "The chef at CentCom is having trouble butchering her animals. She requests one chainsaw, please."
	reward = 2500
	wanted_types = list(obj/item/twohanded/chainsaw)
*/

/datum/bounty/item/assistant/bonfire
	name = "Lit Bonfire"
	description = "Space heaters are malfunctioning and the cargo crew of Central Command is starting to feel cold. Ship a lit bonfire to warm them up."
	reward = 5000
	wanted_types = list(/obj/structure/bonfire)

/datum/bounty/item/assistant/bonfire/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/structure/bonfire/B = O
	return !!B.burning


/datum/bounty/item/assistant/bolas
	name = "Bolas"
	description = "Centcom's chef has lost their mind. They're streaking naked though the halls, greased up with butter and cooking oil. Send some bola's so we can capture them."
	reward = 1000
	required_count = 3
	wanted_types = list(/obj/item/restraints/legcuffs/bola)

/datum/bounty/item/assistant/toolbelts
	name = "Tool Belts" //Made it 5 so you can't just buy one set of toolbelts to finish the bounty.
	description = "These things always seem to go missing. Ship us a few to help us restock."
	reward = 1350
	required_count = 5
	wanted_types = list(/obj/item/storage/belt/utility)

/datum/bounty/item/assistant/gasmasks
	name = "Gas Masks" 
	description = "The good news is that we have more miasma than we'll ever need. The bad news is, somone opened the release valve on the canisters. Ship us some gas masks!"
	reward = 1250
	required_count = 4
	wanted_types = list(/obj/item/clothing/mask/gas)

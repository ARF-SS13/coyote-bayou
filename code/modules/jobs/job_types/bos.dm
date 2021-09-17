/*
BoS access:
Main doors: ACCESS_CAPTAIN 20
*/

/datum/job/bos //do NOT use this for anything, it's just to store faction datums.
	department_flag = BOS
	selection_color = "#95a5a6"

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	outfit = /datum/outfit/job/bos/
	exp_type = EXP_TYPE_BROTHERHOOD

	objectivesList = list("Leadership recommends the following goal for this week: Establish an outpost at the radio tower","Leadership recommends the following goal for this week: Acquire blueprints for research and preservation", "Leadership recommends the following goal for this week: Acquire or confiscate dangerous tech by any means necessary.")

/datum/outfit/job/bos
	name = "bosdatums"
	jobtype = 	/datum/job/bos
	backpack = 	/obj/item/storage/backpack/explorer
	satchel = 	/obj/item/storage/backpack/satchel/explorer
	ears = 		/obj/item/radio/headset/headset_bos
	uniform =	/obj/item/clothing/under/syndicate/brotherhood
	shoes = 	/obj/item/clothing/shoes/combat/swat
	gloves = 	/obj/item/clothing/gloves/combat
	id = 		/obj/item/card/id/dogtag
	box = 		/obj/item/storage/survivalkit_adv

/datum/outfit/job/bos/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return

/datum/outfit/job/bos/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombatarmor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombathelmet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombatarmormk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombathelmetmk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/set_vrboard/bos)

/*
Elder
*/

/datum/job/bos/f13elder
	title = "Elder"
	flag = F13ELDER
	faction = "BOS"
	head_announce = list("Security")
	supervisors = "the high elders"
	selection_color = "#7f8c8d"
	req_admin_notify = 1

	exp_requirements = 3000

	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/bos/f13elder

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_MINERAL_STOREROOM, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_MINERAL_STOREROOM, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)

/datum/outfit/job/bos/f13elder/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)

/datum/outfit/job/bos/f13elder
	name = "Elder"
	jobtype = /datum/job/bos/f13elder
	pa_wear = TRUE
	suit =	/obj/item/clothing/suit/f13/elder
	glasses =	/obj/item/clothing/glasses/night
	accessory =	/obj/item/clothing/accessory/bos/elder
	suit_store =	/obj/item/gun/energy/laser/laer
	neck =	/obj/item/clothing/neck/mantle/bos/right
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/mfc = 2,
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/gun/ballistic/automatic/pistol/n99 = 1,
	)

/*
Head Paladin
*/

/datum/job/bos/f13sentinel
	title = "Head Paladin"
	flag = F13SENTINEL
	faction = "BOS"
	head_announce = list("Security")
	total_positions = 1
	spawn_positions = 1
	description = "You are the acting field commander until the Brotherhood regains its strength enough to place an Elder for the bunker. You are a veteran of many battles and sorties in pursuit of Brotherhood goals; your only weakness may just be your hubris. Your main goals are defense of the Chapter and surveillance of the surrounding region for technology."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the elder"
	selection_color = "#7f8c8d"

	exp_requirements = 1500

	loadout_options = list(
	/datum/outfit/loadout/sentstand, //Tribeam laser
	/datum/outfit/loadout/sentvet, //xl70e3
	/datum/outfit/loadout/sentheavy, //Gauss + Glock
	/datum/outfit/loadout/sentgat // Gatling
	)

	outfit = /datum/outfit/job/bos/f13sentinel

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)

/datum/outfit/job/bos/f13sentinel/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/datum/outfit/job/bos/f13sentinel/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	if(H.mind)
		var/obj/effect/proc_holder/spell/terrifying_presence/S = new /obj/effect/proc_holder/spell/terrifying_presence
		H.mind.AddSpell(S)

/datum/outfit/job/bos/f13sentinel
	name = "Head Paladin"
	jobtype = /datum/job/bos/f13sentinel
	uniform = 		/obj/item/clothing/under/f13/recon
	accessory = 	/obj/item/clothing/accessory/bos/sentinel
	glasses =       /obj/item/clothing/glasses/night
	suit =			/obj/item/clothing/suit/armor/f13/power_armor/t51b
	head =			/obj/item/clothing/head/helmet/f13/power_armor/t51b
	belt =			/obj/item/storage/belt/military/assault
	mask =			/obj/item/clothing/mask/gas/sechailer/swat
	id = 			/obj/item/card/id/dogtag
	neck = 			/obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 1,
		/obj/item/ammo_box/magazine/m10mm_adv/simple = 2,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		)

/datum/outfit/loadout/sentstand
	name = "Shock Head Paladin"
	l_hand = /obj/item/gun/energy/laser/scatter
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/mfc = 3,
	)

/datum/outfit/loadout/sentvet
	name = "Veteran Head Paladin"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/xl70e3 = 1,
		/obj/item/ammo_box/magazine/m556/rifle/assault = 3,
	)

/datum/outfit/loadout/sentheavy
	name = "Heavy Head Paladin"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/m72 = 1,
		/obj/item/ammo_box/magazine/m2mm = 3,
		/obj/item/gun/energy/laser/plasma/glock = 1,
		/obj/item/stock_parts/cell/ammo/ec = 2,
	)

/datum/outfit/loadout/sentgat
	name = "Gatling Paladin"
	backpack_contents = list(
		/obj/item/minigunpack=1,
	)


/*
Head Scribe
*/

/datum/job/bos/f13headscribe
	title = "Head Scribe"
	flag = F13HEADSCRIBE
	head_announce = list("Security")
	faction = "BOS"
	total_positions = 1
	spawn_positions = 1
	description = "You are the foremost experienced scribe remaining in this bunker. Your role is to ensure the safekeeping and proper usage of technology within the Brotherhood. You are also the lead medical expert in this Chapter. Delegate your tasks to your Scribes."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the elder"
	selection_color = "#7f8c8d"

	exp_requirements = 1500

	loadout_options = list(
	/datum/outfit/loadout/hsstand,
	/datum/outfit/loadout/hspract
	)

	outfit = /datum/outfit/job/bos/f13headscribe

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)

/datum/outfit/job/bos/f13headscribe/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_MEDICALEXPERT, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST_EXPERT, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)

/datum/outfit/job/bos/f13headscribe
	name = "Head Scribe"
	jobtype = /datum/job/bos/f13headscribe
	chemwhiz = TRUE
	uniform = 		/obj/item/clothing/under/syndicate/brotherhood
	accessory = 	/obj/item/clothing/accessory/bos/headscribe
	glasses =       /obj/item/clothing/glasses/night
	suit = 			/obj/item/clothing/suit/armor/f13/headscribe
	belt = 			/obj/item/storage/belt/utility/full/engi
	id = 			/obj/item/card/id/dogtag
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/survival = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		)

/datum/outfit/loadout/hsstand
	name = "Medicinal Expert"
	backpack_contents = list(
		/obj/item/gun/medbeam = 1,
		/obj/item/reagent_containers/hypospray/CMO = 1,
		)

/datum/outfit/loadout/hspract
	name = "Administrative Leader"
	backpack_contents = list(
		/obj/item/gun/energy/laser/plasma/pistol = 1,
		/obj/item/stock_parts/cell/ammo/ec = 2,
		)

/*
Head Knight
*/

/datum/job/bos/f13knightcap
	title = "Head Knight"
	flag = F13KNIGHTCAPTAIN
	head_announce = list("Security")
	faction = "BOS"
	total_positions = 1
	spawn_positions = 1
	description = "You are the Head Knight, leader of your respective division in the Chapter. Your knowledge of pre-war materials and engineering is almost unparalleled, and you have basic combat training and experience. You are in charge of the Chapter's engineering Corps, and your Knights. Delegate to them as necessary. As Chief Armorer, you are also in charge of the armory."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the elder"
	selection_color = "#7f8c8d"

	exp_requirements = 1500

	loadout_options = list(
	/datum/outfit/loadout/capstand, //Wattz 2k
	/datum/outfit/loadout/capsap, //Marksman
	/datum/outfit/loadout/capalt //Neostead with buck because they don't know slugs are better
	)

	outfit = /datum/outfit/job/bos/f13knightcap

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_ARMORY, ACCESS_BRIG)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_ARMORY, ACCESS_BRIG)

/datum/outfit/job/bos/f13knightcap/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/datum/outfit/job/bos/f13knightcap
	name = "Head Knight"
	jobtype = /datum/job/bos/f13knightcap
	gunsmith_one = TRUE
	gunsmith_two = TRUE
	gunsmith_three = TRUE
	gunsmith_four = TRUE
	suit = 			/obj/item/clothing/suit/armor/f13/combat/brotherhood/captain
	glasses =		/obj/item/clothing/glasses/night
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	accessory =		/obj/item/clothing/accessory/bos/knightcaptain
	belt =			/obj/item/storage/belt/security/full
	mask =			/obj/item/clothing/mask/gas/sechailer/swat
	head =			/obj/item/clothing/head/helmet/f13/combat/brotherhood/captain
	id =			/obj/item/card/id/dogtag
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		)

/datum/outfit/loadout/capstand
	name = "Standard"
	backpack_contents = list(
		/obj/item/gun/energy/laser/wattz2k = 1,
		/obj/item/stock_parts/cell/ammo/mfc = 2,
	)

/datum/outfit/loadout/capsap
	name = "Close Support"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/service/alr = 1,
		/obj/item/ammo_box/magazine/m556/rifle/assault = 2,
	)

/datum/outfit/loadout/capalt
	name = "Warden-Defender"
	backpack_contents = list(
		/obj/item/gun/ballistic/shotgun/automatic/combat/neostead = 1,
		/obj/item/ammo_box/shotgun/buck = 2,
	)

/*
Star Paladin
*/

/datum/job/bos/f13seniorpaladin
	title = "Senior Paladin"
	flag = F13SENIORPALADIN
	faction = "BOS"
	total_positions = 1
	spawn_positions = 1
	description = "As the Chapter's senior offensive warrior, you have proven your service and dedication to the Brotherhood over your time as a Paladin. As your skills gained, however, you were deigned to be more useful as a commander and trainer. Your job is to coordinate the Paladins and ensure they work as a team, instilling discipline as you go."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Head Paladin"
	selection_color = "#95a5a6"

	exp_requirements = 750
	exp_type = EXP_TYPE_BROTHERHOOD

	loadout_options = list(
		/datum/outfit/loadout/spaladina, //R91 Assault Rifle
		/datum/outfit/loadout/spaladinc, //AER12
		)

	outfit = /datum/outfit/job/bos/f13seniorpaladin

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/bos/f13paladin,
		),
	)

/datum/outfit/job/bos/f13seniorpaladin/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/datum/outfit/job/bos/f13seniorpaladin/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/datum/outfit/job/bos/f13seniorpaladin
	name =	"Senior Paladin"
	jobtype =	/datum/job/bos/f13seniorpaladin
	suit =	/obj/item/clothing/suit/armor/f13/power_armor/t45d
	head =	/obj/item/clothing/head/helmet/f13/power_armor/t45d
	accessory =	/obj/item/clothing/accessory/bos/seniorpaladin
	uniform =	/obj/item/clothing/under/f13/recon
	mask =	/obj/item/clothing/mask/gas/sechailer/swat
	belt =	/obj/item/storage/belt/military/assault
	neck =	/obj/item/storage/belt/holster

	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/melee/powerfist = 1,
		/obj/item/tank/internals/oxygen = 1,
	)

/datum/outfit/loadout/spaladina
	name = "Firesupport Senior Paladin"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/assault_rifle = 1,
		/obj/item/ammo_box/magazine/m556/rifle/assault = 3,
	)

/datum/outfit/loadout/spaladinc
	name = "Mainline Senior Paladin"
	backpack_contents = list(
		/obj/item/gun/energy/laser/aer12 = 1,
		/obj/item/attachments/scope = 1,
		/obj/item/stock_parts/cell/ammo/mfc = 2,
	)

/*
Paladin
*/

/datum/job/bos/f13paladin
	title = "Paladin"
	flag = F13PALADIN
	faction = "BOS"
	total_positions = 2
	spawn_positions = 2
	description = "You answer directly to the Senior Paladin. You are this Chapter's main line of defense and offense; highly trained in combat and weaponry though with little practical field experience, you are eager to prove your worth to the Brotherhood. Your primary duties are defense and surface operations. You may also be assigned a trainee Initiate."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Senior Paladin and Head Paladin"
	selection_color = "#95a5a6"
	exp_requirements = 450

	loadout_options = list(
	/datum/outfit/loadout/paladina, //R91
	/datum/outfit/loadout/paladinb, //AER9
	/datum/outfit/loadout/paladinc,
	/datum/outfit/loadout/paladind
	)

	outfit = /datum/outfit/job/bos/f13paladin

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/bos/f13initiate,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/bos/f13seniorpaladin,
		),
	)

/datum/outfit/job/bos/f13paladin/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/datum/outfit/job/bos/f13paladin/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/datum/outfit/job/bos/f13paladin
	name =	"Paladin"
	jobtype =	/datum/job/bos/f13paladin
	suit =	/obj/item/clothing/suit/armor/f13/power_armor/t45d
	head =	/obj/item/clothing/head/helmet/f13/power_armor/t45d
	uniform =	/obj/item/clothing/under/f13/recon
	mask =	/obj/item/clothing/mask/gas/sechailer/swat
	belt =	/obj/item/storage/belt/military
	neck =	/obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak= 1,

	)

/datum/outfit/loadout/paladina
	name = "Firesupport Junior Paladin"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/assault_rifle = 1,
		/obj/item/ammo_box/magazine/m556/rifle = 2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/clothing/accessory/bos/juniorpaladin = 1,
	)

/datum/outfit/loadout/paladinb
	name = "Frontline Junior Paladin"
	backpack_contents = list(
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/gun/ballistic/automatic/pistol/mk23=1,
		/obj/item/ammo_box/magazine/m45exp=2,
		/obj/item/clothing/accessory/bos/juniorpaladin=1
		)

/datum/outfit/loadout/paladinc
	name = "Firesupport Paladin"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/assault_rifle=1,
		/obj/item/ammo_box/magazine/m556/rifle=2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/clothing/accessory/bos/paladin=1
		)

/datum/outfit/loadout/paladind
	name = "Frontline Paladin"
	backpack_contents = list(
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/gun/ballistic/automatic/pistol/mk23=1,
		/obj/item/ammo_box/magazine/m45exp=2,
		/obj/item/clothing/accessory/bos/paladin=1
		)

/*
Senior Scribe
*/

/datum/job/bos/f13seniorscribe
	title = "Senior Scribe"
	flag = F13SENIORSCRIBE
	faction = "BOS"
	total_positions = 1
	spawn_positions = 1
	description = "You are the bunker's seniormost medical and scientific expert in the bunker, sans the Head Scribe themselves. You are trained in both medicine and engineering, while also having extensive studies of the old world to assist in pinpointing what technology would be useful to the Brotherhood and its interests."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Head Scribe"
	selection_color = "#95a5a6"

	exp_requirements = 600

	outfit = /datum/outfit/job/bos/f13seniorscribe

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/bos/f13scribe,
		),
	)


/datum/outfit/job/bos/f13seniorscribe/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST, src)

/datum/outfit/job/bos/f13seniorscribe
	name =	"Senior Scribe"
	jobtype =	/datum/job/bos/f13seniorscribe
	chemwhiz =	TRUE
	uniform =	/obj/item/clothing/under/syndicate/brotherhood
	shoes =	/obj/item/clothing/shoes/combat
	belt =	/obj/item/storage/belt/utility/full/engi
	accessory =	/obj/item/clothing/accessory/bos/seniorscribe
	suit =	/obj/item/clothing/suit/f13/seniorscribe
	id =	/obj/item/card/id/dogtag
	glasses =	/obj/item/clothing/glasses/sunglasses/big
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/ec = 2,
		/obj/item/gun/energy/laser/pistol = 1,
		/obj/item/melee/onehanded/knife/survival = 1,
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/reagent_containers/hypospray/CMO = 1,
	)

/*
Scribe
*/

/datum/job/bos/f13scribe
	title = "Scribe"
	flag = F13SCRIBE
	faction = "BOS"
	total_positions = 3
	spawn_positions = 3
	description = "You answer directly to the Senior Scribe, tasked with researching and reverse-engineering recovered technologies from the old world, while maintaining the brotherhoods scientific archives. You may also be given a trainee to assign duties to."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Senior Scribe and Head Scribe"
	selection_color = "#95a5a6"

	exp_requirements = 300

	loadout_options = list(
	/datum/outfit/loadout/scribea,
	/datum/outfit/loadout/scribeb,
	)

	outfit = /datum/outfit/job/bos/f13scribe

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/bos/f13initiate,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/bos/f13seniorscribe,
		),
	)

/datum/outfit/job/bos/f13scribe
	name = "Scribe"
	jobtype = /datum/job/bos/f13scribe
	chemwhiz = TRUE
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	shoes = 		/obj/item/clothing/shoes/combat
	belt = 			/obj/item/storage/belt/utility/full/engi
	suit = 			/obj/item/clothing/suit/f13/scribe
	id = 			/obj/item/card/id/dogtag
	glasses =		/obj/item/clothing/glasses/sunglasses/big
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/melee/onehanded/knife/survival=1,
		/obj/item/storage/firstaid/regular=1,
		)

/datum/outfit/job/bos/f13scribe/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)
	ADD_TRAIT(H, TRAIT_MEDICALGRADUATE, src)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)

/datum/outfit/loadout/scribea
	name = "Junior Scribe"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorscribe=1,
		)

/datum/outfit/loadout/scribeb
	name = "Scribe"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/scribe=1,
		)

/*
Senior Knight
*/

/datum/job/bos/f13seniorknight
	title = "Senior Knight"
	flag = F13SENIORKNIGHT
	faction = "BOS"
	total_positions = 1
	spawn_positions = 1
	description = "You report directly to the Head Knight. You are the Brotherhood Senior Knight. Having served the Knight Caste for some time now, you are versatile and experienced in both basic combat and repairs, and also a primary maintainer of the Bunker's facilities. As your seniormost Knight, you may be assigned initiates or Junior Knights to mentor."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Head Knight"
	selection_color = "#95a5a6"
	exp_requirements = 600

	loadout_options = list(
	/datum/outfit/loadout/sknighta, //AER9
	/datum/outfit/loadout/sknightb, //Browning Auto-5
	)

	outfit = /datum/outfit/job/bos/f13seniorknight

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/bos/f13knight,
		),
	)

/datum/outfit/job/bos/f13seniorknight
	name = "Senior Knight"
	jobtype = /datum/job/bos/f13seniorknight
	suit = 			/obj/item/clothing/suit/armor/f13/combat/brotherhood/senior
	accessory = 	/obj/item/clothing/accessory/bos/seniorknight
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	glasses =       /obj/item/clothing/glasses/night
	mask =			/obj/item/clothing/mask/gas/sechailer/swat
	belt = 			/obj/item/storage/belt/military
	head = 			/obj/item/clothing/head/helmet/f13/combat/brotherhood/senior
	id = 			/obj/item/card/id/dogtag
	gunsmith_one = TRUE
	gunsmith_two = TRUE
	gunsmith_three = TRUE
	gunsmith_four = TRUE
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting=1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak=2
		)

/datum/outfit/loadout/sknighta
	name = "Footknight"
	backpack_contents = list(
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/attachments/scope = 1,
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 1,
		/obj/item/ammo_box/magazine/m45exp = 2,
		)

/datum/outfit/loadout/sknightb
	name = "Knight-Defender"
	backpack_contents = list(
		/obj/item/gun/ballistic/shotgun/police=1,
		/obj/item/ammo_box/shotgun/buck=2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)


/*
Knight
*/

/datum/job/bos/f13knight
	title = "Knight"
	flag = F13KNIGHT
	faction = "BOS"
	total_positions = 3
	spawn_positions = 3
	description = " You are the Brotherhood Knight, the veritable lifeblood of your organization. You are a versatile and adaptably trained person: from your primary duties of weapon & armor repair to basic combat, survival and stealth skills, the only thing you lack is proper experience. You are also in charge of Initiates."
	forbids = "TheBrotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Senior Knight, and Head Knight"
	selection_color = "#95a5a6"

	exp_requirements = 300

	loadout_options = list(
	/datum/outfit/loadout/knighta, //AER9
	/datum/outfit/loadout/knightb, //R82
	/datum/outfit/loadout/knightc,
	/datum/outfit/loadout/knightd
	)

	outfit = /datum/outfit/job/bos/f13knight

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/bos/f13initiate,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/bos/f13seniorknight,
		),
	)

/datum/outfit/job/bos/f13knight
	name = "Knight"
	jobtype = /datum/job/bos/f13knight
	suit = 			/obj/item/clothing/suit/armor/f13/combat/brotherhood
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	mask =			/obj/item/clothing/mask/gas/sechailer/swat
	belt = 			/obj/item/storage/belt/military
	head = 			/obj/item/clothing/head/helmet/f13/combat/brotherhood
	id = 			/obj/item/card/id/dogtag
	gunsmith_one = TRUE
	gunsmith_two = TRUE
	gunsmith_three = TRUE
	gunsmith_four = TRUE
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/survival=1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1,
		)

/datum/outfit/loadout/knighta
	name = "Junior Footknight"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorknight=1,
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		)

/datum/outfit/loadout/knightb
	name = "Junior Knight-Defender"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorknight=1,
		/obj/item/gun/ballistic/automatic/delisle/commando=1,
		/obj/item/ammo_box/magazine/m45exp=2,
		)

/datum/outfit/loadout/knightc
	name = "Footknight"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/knight=1,
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		)

/datum/outfit/loadout/knightd
	name = "Knight-Defender"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/knight=1,
		/obj/item/gun/ballistic/automatic/delisle/commando=1,
		/obj/item/ammo_box/magazine/m45exp=2,
		)
/*
Initiate
*/

/datum/job/bos/f13initiate
	title = "Initiate"
	flag = F13INITIATE
	faction = "BOS"
	total_positions = 3
	spawn_positions = 3
	description = "Either recently inducted or born into the Brotherhood, you have since proven yourself worthy of assignment to the Chapter. You are to assist your superiors and receive training how they deem fit. You are NEVER allowed to leave the bunker without the direct supervision of a superior; doing so may result in exile or transferrence back the Valley."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the scribes, knights, or Paladins"
	selection_color = "#95a5a6"

	exp_type = EXP_TYPE_FALLOUT
	exp_requirements = 300

	loadout_options = list(
	/datum/outfit/loadout/initiatek, //AEP7 and Engibelt with combat armor, no helmet
	/datum/outfit/loadout/initiates, //Medical belt and chem knowledge
	)

	outfit = /datum/outfit/job/bos/f13initiate

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/bos,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/bos/f13knight,
			/datum/job/bos/f13scribe,
		),
	)

/datum/outfit/job/bos/f13initiate
	name = "Initiate"
	jobtype = /datum/job/bos/f13initiate
	backpack = /obj/item/storage/backpack/explorer
	ears = 			/obj/item/radio/headset/headset_bos
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	shoes = 		/obj/item/clothing/shoes/combat/swat
	gloves = 		/obj/item/clothing/gloves/combat
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/survival = 1,
		)

/datum/outfit/job/bos/f13initiate/post_equip(mob/living/carbon/human/H, visualsOnly)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_LOW, src)


/datum/outfit/loadout/initiatek
	name = "Knight-Aspirant"
	belt = 			/obj/item/storage/belt/utility/full/engi
	suit = 			/obj/item/clothing/suit/armor/f13/combat/brotherhood/initiate
	head = 			/obj/item/clothing/head/helmet/f13/combat/brotherhood/initiate
	backpack_contents = list(
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/book/granter/crafting_recipe/gunsmith_one=1,
		/obj/item/book/granter/crafting_recipe/gunsmith_two=1,
		/obj/item/clothing/accessory/bos/initiateK=1,
		)

/datum/outfit/loadout/initiates
	name = "Scribe-Aspirant"
	belt =			/obj/item/storage/belt/medical
	suit =			/obj/item/clothing/suit/toggle/labcoat
	glasses =		/obj/item/clothing/glasses/science
	gloves =		/obj/item/clothing/gloves/color/latex
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1,
		/obj/item/book/granter/trait/chemistry=1,
		/obj/item/clothing/accessory/bos/initiateS=1,
		)

/*
Off-Duty
*/

/datum/job/bos/f13offdutybos
	title = "BoS Off-Duty"
	flag = F13OFFDUTYBOS
	faction = "BOS"
	total_positions = 3
	spawn_positions = 3
	description = "Whether operating in disguise or simply enjoying time from the off-shift, you are still a member of the Brotherhood and must abide by the Codex and follow the orders of your superiors. That being said, while off-duty your orders do not take precedence and you should resist issuing them when another of your rank is currently on duty, and if one does not exist, commit to going on-duty. You have a duty to safeguard what equipment you are given, especially your holotags. Ideally, you should be paired with one or more fellow off-duty members; and you would know where the bunker in the region is."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "your superior rank."
	selection_color = "#95a5a6"

	loadout_options = list(
	/datum/outfit/loadout/offa, //Junior Knight
	/datum/outfit/loadout/offb, //Knight
	/datum/outfit/loadout/offc, //Star Knight
	/datum/outfit/loadout/offd, //Head Knight
	/datum/outfit/loadout/offe, //Junior Scribe
	/datum/outfit/loadout/offf, //Scribe
	/datum/outfit/loadout/offg, //Senior Scribe
	/datum/outfit/loadout/offh, //Head Scribe
	/datum/outfit/loadout/offi, //Junior Paladin
	/datum/outfit/loadout/offj, //Paladin
	/datum/outfit/loadout/offk, //Star Paladin
	/datum/outfit/loadout/offl, //Head Paladin
	)

	outfit = /datum/outfit/job/bos/f13offdutybos

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)

/datum/outfit/job/bos/f13offdutybos
	name = "BoS Off-Duty"
	jobtype = /datum/job/bos/f13offdutybos
	backpack = /obj/item/storage/backpack
	ears = 			/obj/item/radio/headset
	uniform =		/obj/item/clothing/under/syndicate
	belt = 			/obj/item/storage/belt/military/army
	shoes = 		/obj/item/clothing/shoes/combat
	gloves = 		/obj/item/clothing/gloves/combat
	id = 			/obj/item/card/id/dogtag
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1,
		/obj/item/stack/medical/gauze=1,
		/obj/item/encryptionkey/headset_bos=1,
		/obj/item/melee/onehanded/knife/survival=1
		)

/datum/outfit/loadout/offa
	name = "Junior Knight"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorknight=1
		)

/datum/outfit/loadout/offb
	name = "Knight"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/knight=1
		)

/datum/outfit/loadout/offc
	name = "Senior Knight"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/seniorknight=1
		)

/datum/outfit/loadout/offd
	name = "Knight-Captain"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/knightcaptain=1
		)

/datum/outfit/loadout/offe
	name = "Junior Scribe"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorscribe=1
		)

/datum/outfit/loadout/offf
	name = "Scribe"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/scribe=1
		)

/datum/outfit/loadout/offg
	name = "Senior Scribe"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/seniorscribe=1
		)

/datum/outfit/loadout/offh
	name = "Head Scribe"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/headscribe=1
		)

/datum/outfit/loadout/offi
	name = "Junior Paladin"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorpaladin=1
		)

/datum/outfit/loadout/offj
	name = "Paladin"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/paladin=1
		)

/datum/outfit/loadout/offk
	name = "Senior Paladin"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/seniorpaladin=1
		)

/datum/outfit/loadout/offl
	name = "Sentinel"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/sentinel=1
		)

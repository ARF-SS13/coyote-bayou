/*
BoS access:
Main doors: ACCESS_CAPTAIN 20
*/

/datum/job/bos //do NOT use this for anything, it's just to store faction datums.
	department_flag = BOS
	selection_color = "#95a5a6"
	faction = FACTION_BROTHERHOOD

	access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	outfit = /datum/outfit/job/bos/
	exp_type = EXP_TYPE_BROTHERHOOD

	objectivesList = list(
		"Leadership recommends the following goal for this week: enlighten the blinded. Attempt to show them your ways.",
		"Leadership recommends the following goal for this week: seek and destroy those who follow the old brotherhood's foolish ways.",
		"Leadership recommends the following goal for this week: collect artifacts and blueprints from before the annihilation of the Old World.",
		"Leadership recommends the following goal for this week: remember the sacrifice of Elder Wossner. Hold fesitivies or ceremonies in his honor."
		)

/datum/outfit/job/bos
	name = "bosdatums"
	jobtype = 	/datum/job/bos
	backpack = 	/obj/item/storage/backpack/explorer
	belt = /obj/item/kit_spawner/bos
	satchel = 	/obj/item/storage/backpack/satchel/explorer
	ears = 		/obj/item/radio/headset/headset_bos
	uniform =	/obj/item/clothing/under/syndicate/brotherhood
	shoes = 	/obj/item/clothing/shoes/combat/swat
	gloves = 	/obj/item/clothing/gloves/combat
	id = 		/obj/item/card/id/dogtag

/datum/outfit/job/bos/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return

/*
/datum/outfit/job/bos/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombatarmor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombathelmet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombatarmormk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/boscombathelmetmk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/set_vrboard/bos)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/gate_bos)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/bosoutcastlight)
*/

/*
Elder
*/

/datum/job/bos/f13elder
	title = "Elder"
	flag = F13ELDER
	head_announce = list("Security")
	supervisors = "the high elders"
	selection_color = "#7f8c8d"
	req_admin_notify = 1

	exp_requirements = 3000

	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/bos/f13elder

	access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_MINERAL_STOREROOM, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_CHANGE_IDS)
	minimal_access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_MINERAL_STOREROOM, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_CHANGE_IDS)

/*
/datum/outfit/job/bos/f13elder/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/jet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/turbo)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/psycho)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/buffout)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steady)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
*/

/datum/outfit/job/bos/f13elder
	name = "Elder"
	jobtype = /datum/job/bos/f13elder
	pa_wear = TRUE
	belt = /obj/item/kit_spawner/bos/boss
	suit =	/obj/item/clothing/suit/armor/light/duster/bos/scribe/elder
	glasses =	/obj/item/clothing/glasses/night
	accessory =	/obj/item/clothing/accessory/bos/elder
//	suit_store =	/obj/item/gun/energy/laser/laer
	neck =	/obj/item/clothing/neck/mantle/bos/right
	ears = /obj/item/radio/headset/headset_bos/command
//	backpack_contents = list(
//		/obj/item/stock_parts/cell/ammo/mfc = 2,
//		/obj/item/melee/onehanded/knife/hunting = 1,
//		/obj/item/gun/ballistic/automatic/pistol/n99 = 1,
//	)

/*
Head Paladin
*/

/datum/job/bos/f13sentinel
	title = "Head Paladin"
	flag = F13SENTINEL
	head_announce = list("Security")
	total_positions = 0
	spawn_positions = 0
	description = "You are the acting field commander until the Brotherhood regains its strength enough to place an Elder for the bunker. You are a veteran of many battles and sorties in pursuit of Brotherhood goals; your only weakness may just be your hubris. Your main goals are defense of the Chapter and surveillance of the surrounding region for technology."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the elder"
	selection_color = "#7f8c8d"

	exp_requirements = 2400

	loadout_options = list(
	/datum/outfit/loadout/sentstand, //Tribeam laser + Hardened T-51
	/datum/outfit/loadout/sentheavy, //Gauss + Glock + Hardened T-51
	/datum/outfit/loadout/sentgat, // Gatling + Hardened T-51
	/datum/outfit/loadout/sentmini, // Minigun + Hardened T-51
	)

	outfit = /datum/outfit/job/bos/f13sentinel

	access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_CHANGE_IDS)
	minimal_access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_CHANGE_IDS)

/*
/datum/outfit/job/bos/f13sentinel/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)


/datum/outfit/job/bos/f13sentinel/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/jet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/turbo)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/psycho)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/buffout)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steady)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	if(H.mind)
		var/obj/effect/proc_holder/spell/terrifying_presence/S = new /obj/effect/proc_holder/spell/terrifying_presence
		H.mind.AddSpell(S)
*/

/datum/outfit/job/bos/f13sentinel
	name = "Head Paladin"
	jobtype = /datum/job/bos/f13sentinel
	uniform = 		/obj/item/clothing/under/f13/recon
	accessory = 	/obj/item/clothing/accessory/bos/sentinel
	glasses =       /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/kit_spawner/bos/combat
	mask =			/obj/item/clothing/mask/gas/sechailer
	ears =			/obj/item/radio/headset/headset_bos/command
	id = 			/obj/item/card/id/dogtag
	neck = 			/obj/item/clothing/neck/mantle/bos/paladin
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/melee/powerfist/f13 = 1,
		/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 1,
		/obj/item/ammo_box/magazine/m10mm/adv/simple = 2,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/storage/belt/army/assault = 1
		)

/datum/outfit/loadout/sentstand
	name = "Shock Head Paladin"
	suit = /obj/item/clothing/suit/armor/power_armor/midwest/hardened
	head = /obj/item/clothing/head/helmet/f13/power_armor/midwest/hardened
	l_hand = /obj/item/gun/energy/laser/scatter
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/mfc = 3,
	)

/datum/outfit/loadout/sentheavy
	name = "Heavy Head Paladin"
	suit = /obj/item/clothing/suit/armor/power_armor/midwest/hardened
	head = /obj/item/clothing/head/helmet/f13/power_armor/midwest/hardened
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/m72 = 1,
		/obj/item/ammo_box/magazine/m2mm = 3,
		/obj/item/gun/energy/laser/plasma/glock = 1,
		/obj/item/stock_parts/cell/ammo/ec = 2,
	)

/datum/outfit/loadout/sentgat
	name = "Gatling Head Paladin"
	suit = /obj/item/clothing/suit/armor/power_armor/midwest/hardened
	head = /obj/item/clothing/head/helmet/f13/power_armor/midwest/hardened
	backpack_contents = list(
		/obj/item/minigunpack=1,
	)

/datum/outfit/loadout/sentmini
	name = "Minigun Head Paladin"
	suit = /obj/item/clothing/suit/armor/power_armor/midwest/hardened
	head = /obj/item/clothing/head/helmet/f13/power_armor/midwest/hardened
	backpack_contents = list(
		/obj/item/minigunpackbal5mm=1,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
	)


/*
Head Scribe
*/

/datum/job/bos/f13headscribe
	title = "Head Scribe"
	flag = F13HEADSCRIBE
	head_announce = list("Security")
	total_positions = 0
	spawn_positions = 0
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

	access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_CHANGE_IDS)
	minimal_access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_CHANGE_IDS)

/*
/datum/outfit/job/bos/f13headscribe/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/jet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/turbo)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/psycho)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/buffout)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steady)
	ADD_TRAIT(H, TRAIT_MEDICALEXPERT, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST_EXPERT, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)
*/

/datum/outfit/job/bos/f13headscribe
	name = "Head Scribe"
	jobtype = /datum/job/bos/f13headscribe
	chemwhiz = TRUE
	belt = /obj/item/kit_spawner/bos/scientist
	uniform = 		/obj/item/clothing/under/syndicate/brotherhood
	accessory = 	/obj/item/clothing/accessory/bos/headscribe
	glasses =       /obj/item/clothing/glasses/sunglasses
	suit = 			/obj/item/clothing/suit/armor/light/duster/bos/scribe/headscribe
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
	total_positions = 0
	spawn_positions = 0
	description = "You are the Head Knight, one of the leaders of your group of outcasts. After the attempted coup by the late Head Paladin Wossner, you have been wandering the wastes, looking for a new home, and have now found a barely-acceptable place to construct your new chapters' bunker. Your knowledge of Pre-Fall materials and engineering is almost unparalleled, and you have basic combat training and experience. You are in charge of establishing a working foothold, and your Knights and initiates. Delegate to them as necessary. As Chief Armorer, you are also in charge of the armory."
	forbids = "The Brotherhood of Steel Forbids: violence beyond what is needed."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the hands of the blind. Experimentation and research."
	supervisors = "the elder"
	selection_color = "#7f8c8d"

	exp_requirements = 60

/*
	loadout_options = list(
	/datum/outfit/loadout/capstand, //Wattz 2k
	/datum/outfit/loadout/capsap, //Marksman
	/datum/outfit/loadout/capalt //Neostead with buck because they don't know slugs are better
	)
*/

	outfit = /datum/outfit/job/bos/f13knightcap

	access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_ARMORY, ACCESS_BRIG, ACCESS_CHANGE_IDS)
	minimal_access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS, ACCESS_ARMORY, ACCESS_BRIG, ACCESS_CHANGE_IDS)

/*
/datum/outfit/job/bos/f13knightcap/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)
*/


/datum/outfit/job/bos/f13knightcap
	name = "Head Knight"
	jobtype = /datum/job/bos/f13knightcap
	gunsmith_one = TRUE
	gunsmith_two = TRUE
	gunsmith_three = TRUE
	gunsmith_four = TRUE
	suit = 			/obj/item/clothing/suit/armor/medium/combat/brotherhood/captain
	glasses =		/obj/item/clothing/glasses/night
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	accessory =		/obj/item/clothing/accessory/bos/knightcaptain
	belt = /obj/item/kit_spawner/bos/combat
	l_pocket =			/obj/item/storage/belt/shoulderholster
	mask =			/obj/item/clothing/mask/gas/sechailer
	head =			/obj/item/clothing/head/helmet/f13/combat/brotherhood/captain
	id =			/obj/item/card/id/dogtag
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/storage/belt/army/security/full = 1
		)

/*
/datum/outfit/loadout/capstand
	name = "Scout Leader"
	backpack_contents = list(
		/obj/item/gun/energy/laser/wattz2k = 1,
		/obj/item/stock_parts/cell/ammo/mfc = 2,
	)

/datum/outfit/loadout/capsap
	name = "Close Support"
	backpack_contents = list(
		/obj/item/gun/energy/laser/wattz/recharger = 1,
		/obj/item/stock_parts/cell/ammo/ecp = 2,
	)

/datum/outfit/loadout/capalt
	name = "Warden-Defender"
	backpack_contents = list(
		/obj/item/gun/ballistic/shotgun/hunting = 1,
		/obj/item/ammo_box/shotgun/buck = 3,
	)
*/

/*
Star Paladin
*/

/datum/job/bos/f13seniorpaladin
	title = "Senior Paladin"
	flag = F13SENIORPALADIN
	total_positions = 0
	spawn_positions = 0
	description = "As the Chapter's senior offensive warrior, you have proven your service and dedication to the Brotherhood over your time as a Paladin. As your skills gained, however, you were deigned to be more useful as a commander and trainer. Your job is to coordinate the Paladins and ensure they work as a team, instilling discipline as you go."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Head Paladin"
	selection_color = "#95a5a6"

	exp_requirements = 1500 //Not used right now anyways. Slot disabled.
	exp_type = EXP_TYPE_BROTHERHOOD

	loadout_options = list(
		/datum/outfit/loadout/spaladina, //5mm minigun
		/datum/outfit/loadout/spaladinb, //WT-550
		/datum/outfit/loadout/spaladinc,  //Aer9
		/datum/outfit/loadout/spaladind //Sledge and fist
		)

	outfit = /datum/outfit/job/bos/f13seniorpaladin

	access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
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

/datum/outfit/job/bos/f13seniorpaladin
	name =	"Senior Paladin"
	jobtype =	/datum/job/bos/f13seniorpaladin
	suit =	/obj/item/clothing/suit/armor/power_armor/midwest
	head =	/obj/item/clothing/head/helmet/f13/power_armor/midwest
	accessory =	/obj/item/clothing/accessory/bos/seniorpaladin
	uniform =	/obj/item/clothing/under/f13/recon
	mask =	/obj/item/clothing/mask/gas/sechailer
	belt = /obj/item/kit_spawner/bos/combat
	neck =	/obj/item/clothing/neck/mantle/bos/paladin

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/storage/belt/army/assault = 1
	)

/datum/outfit/loadout/spaladina
	name = "Senior Firesupport Paladin"
	backpack_contents = list(
		/obj/item/minigunpackbal5mm = 1,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/clothing/accessory/bos/paladin=1,
	)

/datum/outfit/loadout/spaladinb
	name = "Senior Tactical Paladin"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/wt550 = 1,
		/obj/item/ammo_box/magazine/m473/small = 3,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)

/datum/outfit/loadout/spaladinc
	name = "Senior Frontline Paladin"
	backpack_contents = list(
		/obj/item/gun/energy/laser/aer9 = 1,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/mfc = 2,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)

/datum/outfit/loadout/spaladind
	name = "Senior Melee Specialist"
	backpack_contents = list(
		/obj/item/melee/powerfist/f13 = 1,
		/obj/item/twohanded/sledgehammer/supersledge =1,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)


/*
Paladin
*/

/datum/job/bos/f13paladin
	title = "Paladin"
	flag = F13PALADIN
	total_positions = 0
	spawn_positions = 0
	description = "You answer directly to the Senior Paladin. You are this Chapter's main line of defense and offense; highly trained in combat and weaponry though with little practical field experience, you are eager to prove your worth to the Brotherhood. Your primary duties are defense and surface operations. You may also be assigned a trainee Initiate."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Head Paladin"
	selection_color = "#95a5a6"
	exp_requirements = 1200

	loadout_options = list(
	/datum/outfit/loadout/paladina, //Minigun
	/datum/outfit/loadout/paladinb, //WT-550
	/datum/outfit/loadout/paladinc, //Aer9
	/datum/outfit/loadout/paladind //Sledge and fists
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

/datum/outfit/job/bos/f13paladin
	name =	"Paladin"
	jobtype =	/datum/job/bos/f13paladin
	suit =	/obj/item/clothing/suit/armor/power_armor/midwest
	head =	/obj/item/clothing/head/helmet/f13/power_armor/midwest
	uniform =	/obj/item/clothing/under/f13/recon
	mask =	/obj/item/clothing/mask/gas/sechailer
	belt = /obj/item/kit_spawner/bos/combat
	neck =	/obj/item/clothing/neck/mantle/bos/paladin
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak= 1,
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/storage/belt/army/assault = 1
	)

/datum/outfit/loadout/paladina
	name = "Firesupport Paladin"
	backpack_contents = list(
		/obj/item/minigunpackbal5mm = 1,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/clothing/accessory/bos/paladin=1,
	)

/datum/outfit/loadout/paladinb
	name = "Tactical Paladin"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/wt550 = 1,
		/obj/item/ammo_box/magazine/m473/small = 3,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/clothing/accessory/bos/paladin=1,
		)

/datum/outfit/loadout/paladinc
	name = "Frontline Paladin"
	backpack_contents = list(
		/obj/item/gun/energy/laser/aer9 = 1,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/mfc = 2,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/clothing/accessory/bos/paladin=1
		)

/datum/outfit/loadout/paladind
	name = "Melee Specialist"
	backpack_contents = list(
		/obj/item/melee/powerfist/f13 = 1,
		/obj/item/twohanded/sledgehammer/supersledge =1,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		/obj/item/clothing/accessory/bos/paladin=1
		)

/*
Senior Scribe
*/

/datum/job/bos/f13seniorscribe
	title = "Senior Scribe"
	flag = F13SENIORSCRIBE
	total_positions = 0
	spawn_positions = 0
	description = "You are the bunker's seniormost medical and scientific expert in the bunker, sans the Head Scribe themselves. You are trained in both medicine and engineering, while also having extensive studies of the old world to assist in pinpointing what technology would be useful to the Brotherhood and its interests."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Head Scribe"
	selection_color = "#95a5a6"

	exp_requirements = 900

	outfit = /datum/outfit/job/bos/f13seniorscribe

	access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
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

/*
/datum/outfit/job/bos/f13seniorscribe/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/jet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/turbo)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/psycho)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/buffout)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steady)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST, src)
*/

/datum/outfit/job/bos/f13seniorscribe
	name =	"Senior Scribe"
	jobtype =	/datum/job/bos/f13seniorscribe
	chemwhiz =	TRUE
	uniform =	/obj/item/clothing/under/syndicate/brotherhood
	shoes =	/obj/item/clothing/shoes/combat
	belt = /obj/item/kit_spawner/bos/scientist
	belt =	/obj/item/storage/belt/utility/full/engi
	accessory =	/obj/item/clothing/accessory/bos/seniorscribe
	suit =	/obj/item/clothing/suit/armor/light/duster/bos/scribe/seniorscribe
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
	total_positions = 0
	spawn_positions = 0
	description = "After the attempted coup by the late Head Paladin Wossner, you were outcast along with the rest of your brothers. Even though the location is different, the job is the same. You answer to senior members, tasked with researching and reverse-engineering recovered technologies from the old world, while maintaining the brotherhoods scientific archives. You may also be given a trainee to assign duties to."
	forbids = "The Brotherhood of Steel Forbids: violence beyond what is necessary."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the blind. Experimentation and research."
	supervisors = "the Senior Scribe and Head Scribe"
	selection_color = "#95a5a6"

	exp_requirements = 30

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
	belt = /obj/item/kit_spawner/bos/scientist
	suit = 			/obj/item/clothing/suit/armor/light/duster/bos/scribe
	id = 			/obj/item/card/id/dogtag
	glasses =		/obj/item/clothing/glasses/sunglasses/big
	backpack_contents = list(
//		/obj/item/stock_parts/cell/ammo/ec=2,
//		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/storage/belt/utility/full/engi = 1,
		/obj/item/melee/onehanded/knife/survival=1,
		/obj/item/storage/firstaid/regular=1,
		)

/*
/datum/outfit/job/bos/f13scribe/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak)
*/

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
	total_positions = 0
	spawn_positions = 0
	description = "You report directly to the Head Knight. You are the Brotherhood Senior Knight. Having served the Knight Caste for some time now, you are versatile and experienced in both basic combat and repairs, and also a primary maintainer of the Bunker's facilities. As your seniormost Knight, you may be assigned initiates or Junior Knights to mentor."
	forbids = "The Brotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Head Knight"
	selection_color = "#95a5a6"
	exp_requirements = 900

	loadout_options = list(
//	/datum/outfit/loadout/sknighta, //AER9
	/datum/outfit/loadout/sknightb, //Browning Auto-5
	/datum/outfit/loadout/sknightc, //R93 PDW
	/datum/outfit/loadout/sknightd,
	)

	outfit = /datum/outfit/job/bos/f13seniorknight

	access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_BROTHERHOOD_COMMAND, ACCESS_ROBOTICS, ACCESS_BOS, ACCESS_ENGINE_EQUIP, ACCESS_ENGINE, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_SEC_DOORS)
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

/*
/datum/outfit/job/bos/f13seniorknight/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/AER9)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/AEP7)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/dks)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/R93)
*/

/datum/outfit/job/bos/f13seniorknight
	name = "Senior Knight"
	jobtype = /datum/job/bos/f13seniorknight
	suit = 			/obj/item/clothing/suit/armor/medium/combat/brotherhood/senior
	accessory = 	/obj/item/clothing/accessory/bos/seniorknight
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	glasses =       /obj/item/clothing/glasses/night
	mask =			/obj/item/clothing/mask/gas/sechailer
	belt = /obj/item/kit_spawner/bos/combat
	l_pocket =			/obj/item/storage/belt/shoulderholster
	head = 			/obj/item/clothing/head/helmet/f13/combat/brotherhood/senior
	id = 			/obj/item/card/id/dogtag
	gunsmith_one = TRUE
	gunsmith_two = TRUE
	gunsmith_three = TRUE
	gunsmith_four = TRUE
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/hunting=1,
		/obj/item/storage/belt/army/assault = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak=2,
		// /obj/item/book/granter/crafting_recipe/gunsmith_one=1,
		// /obj/item/book/granter/crafting_recipe/gunsmith_two=1
		)
/*
/datum/outfit/loadout/sknighta
	name = "Footknight"
	backpack_contents = list(
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/gun_upgrade/scope/watchman = 1,
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 1,
		/obj/item/ammo_box/magazine/m45/socom = 2,
		)
*/
/datum/outfit/loadout/sknightb
	name = "Knight-Defender"
	backpack_contents = list(
		/obj/item/gun/ballistic/shotgun/police=1,
		/obj/item/ammo_box/shotgun/buck=2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)

/datum/outfit/loadout/sknightc
	name = "Recon"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/r93=1,
		/obj/item/ammo_box/magazine/m556/rifle=2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)

/datum/outfit/loadout/sknightd
	name = "Senior Knight-Cavalry"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorknight=1,
		/obj/item/melee/powered/ripper/prefall=1,
		/obj/item/shield/riot/bullet_proof=1,
		)
/*
Knight
*/

/datum/job/bos/f13knight
	title = "Knight"
	flag = F13KNIGHT
	total_positions = 0
	spawn_positions = 0
	description = " You are the Brotherhood Knight, the veritable lifeblood of your organization. You are a versatile and adaptably trained person: from your primary duties of weapon & armor repair to basic combat, survival and stealth skills, the only thing you lack is proper experience. You are also in charge of Initiates."
	forbids = "TheBrotherhood of Steel Forbids: Unethical human experimentation. Violence beyond what is needed to accomplish Brotherhood goals, and cruel torture or experiments on the minds or bodies of prisoners."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the wasteland. Experimentation and research."
	supervisors = "the Senior Knight, and Head Knight"
	selection_color = "#95a5a6"

	exp_requirements = 300

	loadout_options = list(
	/datum/outfit/loadout/knighta, //AER9
	/datum/outfit/loadout/knightb, //R82
	/datum/outfit/loadout/knightc, //AER9S
	/datum/outfit/loadout/knightd, //R82 J
	/datum/outfit/loadout/knighte, //Ripper J
	/datum/outfit/loadout/knightf, //Ripper S
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

/*
/datum/outfit/job/bos/f13knight/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/AER9)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/AEP7)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/dks)
*/

/datum/outfit/job/bos/f13knight
	name = "Knight"
	jobtype = /datum/job/bos/f13knight
	suit = 			/obj/item/clothing/suit/armor/medium/combat/brotherhood
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	mask =			/obj/item/clothing/mask/gas/sechailer
	belt = /obj/item/kit_spawner/bos/combat
	l_pocket =			/obj/item/storage/belt/shoulderholster
	head = 			/obj/item/clothing/head/helmet/f13/combat/brotherhood
	id = 			/obj/item/card/id/dogtag
	gunsmith_one = TRUE
	gunsmith_two = TRUE
	gunsmith_three = TRUE
	gunsmith_four = TRUE
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/survival=1,
		/obj/item/storage/belt/army/assault = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1,
		// /obj/item/book/granter/crafting_recipe/gunsmith_one=1,
		// /obj/item/book/granter/crafting_recipe/gunsmith_two=1
		)

/datum/outfit/loadout/knighta
	name = "Junior Footknight"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorknight=1,
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 1,
		/obj/item/ammo_box/magazine/m45/socom = 2,
		)

/datum/outfit/loadout/knightb
	name = "Junior Knight-Defender"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorknight=1,
		/obj/item/gun/ballistic/automatic/r93=1,
		/obj/item/ammo_box/magazine/m556/rifle=2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)

/datum/outfit/loadout/knightc
	name = "Junior Knight-Cavalry"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/juniorknight=1,
		/obj/item/melee/powered/ripper=1,
		/obj/item/shield/riot/bullet_proof=1,
		)


/datum/outfit/loadout/knightd
	name = "Footknight"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/knight=1,
		/obj/item/gun/energy/laser/aer9=1,
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 1,
		/obj/item/ammo_box/magazine/m45/socom = 2,
		)

/datum/outfit/loadout/knighte
	name = "Knight-Defender"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/knight=1,
		/obj/item/gun/ballistic/automatic/smg/mp5sd=1,
		/obj/item/ammo_box/magazine/uzim9mm=2,
		/obj/item/gun/energy/laser/pistol=1,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)

/datum/outfit/loadout/knightf
	name = "Knight-Cavalry"
	backpack_contents = list(
		/obj/item/clothing/accessory/bos/knight=1,
		/obj/item/melee/powered/ripper=1,
		/obj/item/shield/riot/bullet_proof=1,
		)
/*
Initiate
*/

/datum/job/bos/f13initiate
	title = "Initiate"
	flag = F13INITIATE
	total_positions = 0
	spawn_positions = 0
	description = "You are one of the initiates that either attempted to participate in the failed coup by Head Paladin Wossner, or a new recruit inducted after their arrival to Redwater. You are to assist your superiors and receive training how they deem fit. You are allowed a looser chain than a 'normal' iniate, able to leave the bunker as you see fit."
	forbids = "The Brotherhood of Steel Forbids: violence beyond what is needed."
	enforces = "The Brotherhood of Steel Expects: Obeying the Chain That - Binds your direct superior. Collection and safeguarding of technology from the hands of the blind. Experimentation and research."
	supervisors = "the scribes, knights, or Paladins"
	selection_color = "#95a5a6"

	exp_type = EXP_TYPE_FALLOUT
	exp_requirements = 0

	loadout_options = list(
	/datum/outfit/loadout/initiatek, //AEP7 and Engibelt with armor, helmet
	/datum/outfit/loadout/initiates, //chem knowledge
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
	belt = /obj/item/kit_spawner/bos/combat
	shoes = 		/obj/item/clothing/shoes/combat/swat
	gloves = 		/obj/item/clothing/gloves/combat
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/survival = 1,
		)

/*
/datum/outfit/job/bos/f13initiate/post_equip(mob/living/carbon/human/H, visualsOnly)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_LOW, src)
*/

/datum/outfit/loadout/initiatek
	name = "Knight-Aspirant"
	belt = 			/obj/item/storage/belt/utility
	suit = 			/obj/item/clothing/suit/armor/light/duster/bos/outcast
	head = 			/obj/item/clothing/head/helmet/f13/combat/brotherhood/initiate
	backpack_contents = list(
//		/obj/item/gun/energy/laser/wattz=1,
//		/obj/item/stock_parts/cell/ammo/ec=2,
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

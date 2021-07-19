//It looks like var/faction controls what becomes visible on setup. Should likely be fixed or something, but I'm not doing it.
/datum/job/enclave
	department_flag = ENCLAVE
	selection_color = "#aaaaf7"
	forbids = "Enclave taboos: Female front line soldiers. Fraternizing with outsiders beyond what is absolutly necessary. Aiding Brotherhood members in any way no matter how small."
	enforces = "Enclave rules: Stay in uniform. Act mature and respectful. Obey orders and always remember you are fighting for the only true legitimate power in this land of savages. Wearing gasmasks outside the compound is encouraged but not required."
	objectivesList = list("Department of Defense advisory: Collect resources and produce more Patribots, attrition is depleting our reserves.","Department of Defense advisory: Establish checkpoints to show presence, they must not forget who is the legitimate goverment.", "Science Divison advisory: Capture human subjects for experiments, alive. We have some new neurotoxin grenades we wish to do final tests with before field deployment.")

/datum/outfit/job/enclave
	id = null
	ears = 			/obj/item/radio/headset/headset_enclave
	box = 			/obj/item/storage/survivalkit_aid

/datum/outfit/job/enclave/peacekeeper
	id = 			/obj/item/card/id/dogtag/enclave/trooper
	mask =			/obj/item/clothing/mask/gas/enclave
	neck =			/obj/item/storage/belt/holster/legholster
	backpack = 		/obj/item/storage/backpack/enclave
	satchel = 		/obj/item/storage/backpack/satchel/enclave
	belt = 			/obj/item/storage/belt/military/assault/enclave
	uniform = 		/obj/item/clothing/under/f13/enclave/peacekeeper
	r_pocket =		/obj/item/flashlight/seclite
	shoes = 		/obj/item/clothing/shoes/f13/enclave/serviceboots
	gloves =		/obj/item/clothing/gloves/f13/military

/datum/outfit/job/enclave/noncombat
	id = 			/obj/item/card/id/dogtag/enclave/noncombatant
	backpack = 		/obj/item/storage/backpack/satchel/enclave
	satchel = 		/obj/item/storage/backpack/satchel/enclave
	belt = 			/obj/item/storage/belt/military/assault/enclave
	uniform = 		/obj/item/clothing/under/f13/enclave/science
	r_pocket =		/obj/item/flashlight/seclite
	shoes = 		/obj/item/clothing/shoes/f13/enclave/serviceboots

/datum/outfit/job/enclave/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/enclave/peacekeeper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	if(H.gender == FEMALE)
		H.gender = MALE
		H.real_name = random_unique_name(MALE)
		H.name = H.real_name
		if(H.wear_id)
			var/obj/item/card/id/dogtag/L = H.wear_id
			L.registered_name = H.name
			L.update_label()

/*
PEACEKEEPERS
*/

//Peacekeeper Officer
/datum/job/enclave/peacekeeper/officer
	title = "Enclave Officer"
	flag = ENCLAVEOFFICER
	faction = "Enclave"
	total_positions = 1
	spawn_positions = 1
	description = "You are an experienced officer in charge of the local Enclave compound. You have ultimate authority but do not micromanage when not needed, and make sure any executions have a witness and documentation to avoid being court martialed."
	supervisors = "the US goverment."
	display_order = JOB_DISPLAY_ORDER_DECAN
	outfit = /datum/outfit/job/enclave/peacekeeper/officer

	loadout_options = list(
		/datum/outfit/loadout/captain, //head honcho
		/datum/outfit/loadout/lieutenant, //tear gas grenade
		)

/datum/outfit/job/enclave/peacekeeper/officer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/datum/outfit/job/enclave/peacekeeper/officer
	name = "Officer"
	jobtype = /datum/job/enclave/peacekeeper/officer
	id = /obj/item/card/id/dogtag/enclave/officer
	head = /obj/item/clothing/head/helmet/f13/helmet/enclave/officer
	uniform = /obj/item/clothing/under/f13/enclave/officer
	suit = /obj/item/clothing/suit/armor/f13/enclave/officercoat
	backpack_contents = list(
		/obj/item/storage/bag/money/small/legofficers = 1,
		)

/datum/outfit/loadout/captain
	name = "Captain"
	uniform = /obj/item/clothing/under/f13/enclave/officer
	suit = /obj/item/clothing/suit/armor/f13/enclave/officercoat
	neck = /obj/item/clothing/neck/cloak/enclavecaptain
	suit_store = /obj/item/gun/energy/laser/plasma/glock
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/stock_parts/cell/ammo/ec=2,
		)

/datum/outfit/loadout/lieutenant
	name = "Lieutenant"
	uniform = /obj/item/clothing/under/f13/enclave_officer
	backpack_contents = list(
		/obj/item/grenade/chem_grenade/teargas = 1,
		/obj/item/gun/energy/laser/plasma/glock = 1,
		/obj/item/stock_parts/cell/ammo/mfc = 2,
		/obj/item/stock_parts/cell/ammo/ec = 2,
		)

//Peacekeeper Trooper
/datum/job/enclave/peacekeeper/trooper
	title = "Peacekeeper Trooper"
	flag = ENCLAVETROOPER
	faction = "Enclave"
	total_positions = 5
	spawn_positions = 5
	description = "Obey your officer, the lance corporal and defend the United States against all foes, foreign and domestic. "
	supervisors = "Officer first, then Lance Corporals. Scientists and Intel officers has any say over you."
	display_order = JOB_DISPLAY_ORDER_DECANREC
	outfit = /datum/outfit/job/enclave/peacekeeper/trooper

	loadout_options = list(
		/datum/outfit/loadout/lancecorporal, //NCO with NVG and long range stuff
		/datum/outfit/loadout/armored, //power armor
		)

/datum/outfit/job/enclave/peacekeeper/trooper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/datum/outfit/job/enclave/peacekeeper/trooper
	name = "Peacekeeper"
	jobtype = /datum/job/enclave/peacekeeper/trooper
	head = /obj/item/clothing/head/helmet/f13/helmet/enclave/peacekeeper
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/sig = 1,
		/obj/item/ammo_box/magazine/m9mm = 1,
		/obj/item/ammo_box/a762 = 3,
		)

/datum/outfit/loadout/lancecorporal
	name = "Lance Corporal"
	glasses = /obj/item/clothing/glasses/night
	suit = /obj/item/clothing/suit/armor/f13/enclave/armorvest
	suit_store = /obj/item/gun/ballistic/automatic/slr
	backpack_contents = list(
		/obj/item/grenade/smokebomb = 1,
		/obj/item/ammo_box/magazine/m762 = 2,
		)

/datum/outfit/loadout/armored
	name = "Armored Infantry"
	head = /obj/item/clothing/head/helmet/f13/power_armor/enclave/x02helmet
	suit = /obj/item/clothing/suit/armor/f13/power_armor/x02
	backpack_contents = list(
		/obj/item/minigunpack = 1,
		)

//PatriBots - planned 2 slot robots, Peacekeeper module with shotgun and Worker module for building stuff.

//NON-COMBATANTS

//Science Officer
/datum/job/enclave/noncombat/science
	title = "Science Officer"
	flag = ENCLAVESCIENCE
	faction = "Enclave"
	total_positions = 2
	spawn_positions = 2
	description = "Responsible for logistics, surgeries, manufacturing, experiments. May not leave the compound perimeter without express orders from the Officer."
	supervisors = "The peacekeeper Officer."
	display_order = JOB_DISPLAY_ORDER_AUXILIA

/datum/outfit/job/enclave/noncombat/science
	name = "Science Officer"
	jobtype = /datum/job/enclave/noncombat/science
	head = 			/obj/item/clothing/head/helmet/f13/helmet/enclave/science
	uniform = 		/obj/item/clothing/under/f13/enclave/science
	backpack_contents = list(
		/obj/item/reagent_containers/spray/pepper=1)

/datum/outfit/job/enclave/noncombat/science/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_UNETHICAL_PRACTITIONER, src) //enclave scientists can do pretty much everything.
	ADD_TRAIT(H, TRAIT_MEDICALEXPERT, src)          //ditto
	ADD_TRAIT(H, TRAIT_CYBERNETICIST_EXPERT, src)    //ditto
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)
	ADD_TRAIT(H, TRAIT_MASTER_GUNSMITH, src)


//Intelligence Officer
/datum/job/enclave/noncombat/intel
	title = "Intel Officer"
	flag = ENCLAVEINTEL
	faction = "Enclave"
	total_positions = 1
	spawn_positions = 1
	description = "Analyze and gather data, help the Science officers keep the compound running. Secondary duty: support the troops with paramedic duties, scouting. "
	supervisors = "The peacekeeper Officer first, Scienctists second. Troopers have no authority over you."
	display_order = JOB_DISPLAY_ORDER_AUXILIA

/datum/outfit/job/enclave/noncombat/intel
	name = "Intelligence Officer"
	jobtype = /datum/job/enclave/noncombat/intel
	head = 			/obj/item/clothing/head/helmet/f13/helmet/enclave/intel
	mask =			/obj/item/clothing/mask/gas/enclave
	uniform = 		/obj/item/clothing/under/f13/enclave/intel
	suit_store =	/obj/item/gun/ballistic/revolver/needler
	backpack_contents = list(
					/obj/item/ammo_box/needle=1,
					/obj/item/storage/firstaid/regular=1)

/datum/outfit/job/enclave/noncombat/intel/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)

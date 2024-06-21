/datum/job/followers //do NOT use this for anything, it's just to store faction datums
	department_flag = FOLLOWERS
	selection_color = "#ffeeaa"
	exp_type = EXP_TYPE_FOLLOWERS
	access = list(ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_FOLLOWER)
	forbids = null
	enforces = "Generallys peaking it can be assumed that your time spent learning how to be a doctor was for the good of others, but ultimately you are on your own path."
	objectivesList = null

/datum/outfit/job/followers
	name =		"FOLLOWERSdatums"
	jobtype =	/datum/job/followers/
	shoes =		/obj/item/clothing/shoes/sneakers/black
	belt = /obj/item/kit_spawner/follower
	id =		null
	ears =		/obj/item/radio/headset/headset_town/medical
	uniform =	/datum/outfit/job/followers/f13followers

/datum/outfit/job/followers/f13followers
	name =		"Followers"
	uniform =	/obj/item/clothing/under/f13/follower

/datum/outfit/job/followers/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/set_vrboard/followers)

//datum/outfit/job/followers/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
//	..()
//	if(visualsOnly)
//		return
	//ADD_TRAIT(H, TRAIT_TECHNOPHREAK, TRAIT_GENERIC)

/*
Administrator
*/
/datum/job/followers/f13leadpractitioner
	title = "Senior Doctor"
	flag = F13LEADPRACTITIONER
	department_flag = FOLLOWERS
	head_announce = list("Security")
	faction = "Followers"
	total_positions = 0
	spawn_positions = 1
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Mayor. Assuming they're around."
	description = "You are a Senior Doctor. Your rank is given due to your experience in the field compared to regular doctors. Help deal with issues that arise that normal doctors aren't prepared for, and teach those willing to learn more in the clinic."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	selection_color = "#FF95FF"
	exp_requirements = 0

	outfit = /datum/outfit/job/followers/f13leadpractitioner


	access = list(ACCESS_BAR, ACCESS_FOLLOWER, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_BAR, ACCESS_FOLLOWER, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)


/datum/outfit/job/followers/f13leadpractitioner/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
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
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rechargerpistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_MEDICALEXPERT, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_UNETHICAL_PRACTITIONER, src)

/datum/outfit/job/followers/f13leadpractitioner
	name =	"Senior Doctor"
	jobtype =	/datum/job/followers/f13leadpractitioner
	id =	/obj/item/card/id/silver
	chemwhiz =	TRUE
	uniform =	/obj/item/clothing/under/f13/followers
	suit=	/obj/item/clothing/suit/toggle/labcoat/followers
	shoes =	/obj/item/clothing/shoes/f13/brownie
	belt = /obj/item/kit_spawner/follower/admin
	backpack =	/obj/item/storage/backpack/medic
	satchel =	/obj/item/storage/backpack/satchel/med
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	suit_store = /obj/item/gun/medbeam
	backpack_contents = list(
		/obj/item/storage/firstaid/ancient = 1,
		/obj/item/storage/survivalkit/medical/follower = 1,
		/obj/item/reagent_containers/medspray/synthflesh = 2,
		/obj/item/pda = 1,
		/obj/item/book/granter/trait/techno = 1,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/storage/wallet/stash/high = 1,
		/obj/item/hypospray/mkii/CMO = 1,
	)

//Professor

/*/datum/job/followers/f13Professor
	title = "Town Scientist"
	flag = F13PRACTITIONER
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Mayor and Doctors. Assuming they're around."
	description = "You are a Town Scientist. As a Scientist it is your job to teach the wastes- be it teaching them how to make medicine, grow crops or treat toxic water. You are a learned individual in your chosen field, you know how to do research and have all the basic tools to teach others how to handle the technology they will come across. You are free to expand upon what projects you wish to accomplish as long as they align with the principles of the doctors."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	selection_color = "#FFDDFF"
	exp_requirements = 0
	exp_type = EXP_TYPE_FOLLOWERS

	outfit = /datum/outfit/job/followers/f13Professor
	loadout_options = list(
	/datum/outfit/loadout/environmental_scientist,
	/datum/outfit/loadout/medical_specialist
	)

	access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)

/datum/outfit/job/followers/f13Professor/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
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
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rechargerpistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_toolset)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_surgical)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_janitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_service)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_nutriment)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_DNAWHIZ, src)

/datum/outfit/job/followers/f13Professor
	name = "Town Scientist"
	jobtype = /datum/job/followers/f13Professor
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel/tox
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	uniform = /obj/item/clothing/under/f13/followers
	suit= /obj/item/clothing/suit/toggle/labcoat/followers
	belt = /obj/item/kit_spawner/follower/scientist
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/storage/survivalkit/medical/follower = 1,
		/obj/item/storage/belt/utility/full/engi = 1,
		/obj/item/pda = 1,
		/obj/item/storage/firstaid/ancient=1,
		/obj/item/storage/wallet/stash/mid = 1,
		)

/datum/outfit/loadout/environmental_scientist
	name =	"Environmental Scientist"
	neck = /obj/item/clothing/neck/apron/labor
	gloves = /obj/item/clothing/gloves/botanic_leather
	backpack_contents = list(
		/obj/item/book/manual/advice_farming = 1,
		/obj/item/circuitboard/machine/hydroponics = 6,
		/obj/item/storage/bag/plants/portaseeder = 1,
	)

/datum/outfit/loadout/medical_specialist
	name =	"Medical Specialist"
	neck = /obj/item/clothing/neck/stethoscope
	gloves = /obj/item/clothing/gloves/color/latex
	backpack_contents = list(
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/circuitboard/machine/bloodbankgen = 1,
		/obj/item/gun/syringe/dart = 1,
		/obj/item/reagent_containers/syringe/dart = 3,
	)*/

/*
Administrator
*/
/datum/job/followers/f13leadprofessor
	title = "Senior Scientist"
	flag = F13LEADPROFESSOR
	department_flag = FOLLOWERS
	head_announce = list("Security")
	faction = "Followers"
	total_positions = 0
	spawn_positions = 1
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Mayor. Assuming they're around."
	description = "You are a Senior Scientist. Your rank is given due to your experience in the field compared to regular scientists. Help deal with issues that arise that normal scientists aren't prepared for, and teach those willing to learn more in the facility."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	selection_color = "#FF95FF"
	exp_requirements = 0

	outfit = /datum/outfit/job/followers/f13leadprofessor

	access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_FOLLOWER, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)


/datum/outfit/job/followers/f13leadprofessor/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
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
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rechargerpistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_MEDICALEXPERT, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)

/datum/outfit/job/followers/f13leadprofessor
	name =	"Senior Scientist"
	jobtype =	/datum/job/followers/f13leadprofessor
	id =	/obj/item/card/id/silver
	chemwhiz =	TRUE
	uniform =	/obj/item/clothing/under/f13/followers
	suit=	/obj/item/clothing/suit/toggle/labcoat/followers
	shoes =	/obj/item/clothing/shoes/f13/brownie
	belt = /obj/item/kit_spawner/follower/admin
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel/tox
	glasses = /obj/item/clothing/glasses/science
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/book/granter/trait/techno = 1,
		/obj/item/storage/wallet/stash/high = 1,
		/obj/item/storage/belt/utility/full/engi = 1,
		/obj/item/disk/xenobio_console_upgrade/monkey = 1,
		/obj/item/disk/xenobio_console_upgrade/slimeadv = 1,
		)

/*
Practitioner

/datum/job/followers/f13practitioner
	title = "Town Doctor"
	flag = F13PRACTITIONER
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Mayor and Senior Doctors. Assuming they're around."
	description = "You are a Town Doctor. Whether a doctor in training or a less experienced doctor of some form, you are tasked with providing medical aid where and when it's needed."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	selection_color = "#FFDDFF"
	exp_requirements = 0

	outfit = /datum/outfit/job/followers/f13practitioner
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/followers/f13practitioner,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/followers/f13practitioner,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/followers/f13followervolunteer,
		),
	)

	loadout_options = list(
	/datum/outfit/loadout/physician,
	/datum/outfit/loadout/pharmacist,
	/datum/outfit/loadout/paramedic,
	/datum/outfit/loadout/medical_researcher,
	)

/datum/outfit/job/followers/f13practitioner/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
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
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	ADD_TRAIT(H, TRAIT_MEDICALGRADUATE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST, src)

	//the follower practitioner doesn't need access because it's already set in the /datum/job/follower
	//personally, I don't think a practitioner should have more access than a volunteer.


/datum/outfit/job/followers/f13practitioner
	name =	"Town Doctor"
	jobtype =	/datum/job/followers/f13practitioner
	uniform =	/obj/item/clothing/under/f13/followers
	id =	/obj/item/card/id/silver
	chemwhiz =	TRUE
	backpack =	/obj/item/storage/backpack/medic
	belt = /obj/item/kit_spawner/follower/doctor
	satchel =	/obj/item/storage/backpack/satchel/med
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	backpack_contents = list(
		/obj/item/storage/survivalkit/medical/follower = 1,
		/obj/item/pda = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/reagent_containers/medspray/synthflesh = 1,
		/obj/item/storage/firstaid/ancient = 1,
		/obj/item/gun/energy/laser/complianceregulator = 1,
		/obj/item/storage/wallet/stash/mid = 1,
	)

/datum/outfit/loadout/physician
	name =	"Emergency Physician"
	suit =	/obj/item/clothing/suit/toggle/labcoat/followers
	mask =	/obj/item/clothing/mask/surgical
	gloves =	/obj/item/clothing/gloves/color/latex/nitrile
	backpack_contents = list(
		/obj/item/clothing/suit/hooded/surgical = 1,
		/obj/item/reagent_containers/medspray/synthflesh = 1,
		/obj/item/healthanalyzer/advanced = 1,
	)

/datum/outfit/loadout/pharmacist
	name =	"Pharmacist"
	suit =	/obj/item/clothing/suit/toggle/labcoat/chemist
	gloves =	/obj/item/clothing/gloves/color/latex
	glasses =	/obj/item/clothing/glasses/science
	backpack_contents = list(
		/obj/item/flashlight/pen = 1,
		/obj/item/pda/chemist = 1,
	)

/datum/outfit/loadout/paramedic
	name =	"Paramedic"
	head =	/obj/item/clothing/head/soft/emt
	suit =	/obj/item/clothing/suit/toggle/labcoat/emt
	belt =	/obj/item/storage/belt/medical
	backpack_contents = list(
		/obj/item/reagent_containers/medspray/synthflesh = 2,
		/obj/item/pda/medical = 1,
		/obj/item/healthanalyzer=1,
	)

/datum/outfit/loadout/medical_researcher
	name =	"Medical Researcher"
	suit =	/obj/item/clothing/suit/toggle/labcoat/followers
	backpack_contents = list(
		/obj/item/clothing/accessory/pocketprotector/full = 1,
		/obj/item/folder/white = 1,
		/obj/item/pda/medical = 1,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/book/granter/trait/techno = 1,) */

/*
Follower Volunteer
*/

/datum/job/followers/f13followervolunteer
	title = "Nurse"
	flag = F13FOLLOWERVOLUNTEER
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 0
	spawn_positions = 3
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Mayor, Doctors, or anyone with more experience than you. Assuming they're around."
	description = "You are a Nurse. As a Nurse you provide first aid to those that are injured and assist the clinic doctors as needed."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	selection_color = "#FFDDFF"
	outfit = /datum/outfit/job/followers/f13followervolunteer
	loadout_options = list(
	/datum/outfit/loadout/volunteer_emt,
	/datum/outfit/loadout/volunteer_mechanic,
	/datum/outfit/loadout/volunteer_farmer,
	/datum/outfit/loadout/volunteer_student
	)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/followers/f13followervolunteer,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/followers/f13followervolunteer,
		),
	)

	//the follower volunteer doesn't need more access as it is already stored in the /datum/job/followers

/datum/outfit/job/followers/f13followervolunteer
	name = "Nurse"
	jobtype = /datum/job/followers/f13followervolunteer
	id = 		/obj/item/card/id/silver
	belt = /obj/item/kit_spawner/follower
	uniform = 	/obj/item/clothing/under/f13/followers
	shoes = 	/obj/item/clothing/shoes/f13/explorer
	backpack = 	/obj/item/storage/backpack/explorer
	satchel = 	/obj/item/storage/backpack/satchel/explorer
	backpack_contents =  list(
		/obj/item/pda = 1,
		/obj/item/storage/firstaid/ancient = 1,
		/obj/item/storage/wallet/stash/mid = 1,
	)

/datum/outfit/loadout/volunteer_emt
	name = "EMT"
	suit = /obj/item/clothing/suit/toggle/labcoat/emt
	head = /obj/item/clothing/head/soft/emt
	backpack_contents = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/reagent_containers/medspray/synthflesh = 1,
	)

/datum/outfit/loadout/volunteer_mechanic
	name =	"Mechanic"
	neck =	/obj/item/clothing/neck/apron/labor
	head =	/obj/item/clothing/head/hardhat/orange
	belt =	/obj/item/storage/belt/utility/full
	gloves =	/obj/item/clothing/gloves/color/yellow
	glasses =	/obj/item/clothing/glasses/welding
	backpack_contents = list(
		/obj/item/flashlight/pen = 1,
	)

/datum/outfit/loadout/volunteer_farmer
	name =	"Farmer"
	head =	/obj/item/clothing/head/helmet/f13/vaquerohat
	suit =	/obj/item/clothing/suit/armor/outfit/overalls/farmer
	belt =	/obj/item/storage/bag/plants/portaseeder
	backpack_contents = list(
		/obj/item/hatchet = 1,
		/obj/item/cultivator = 1,
		/obj/item/shovel/spade = 1,
	)

/datum/outfit/loadout/volunteer_student
	name = "Student"
	backpack_contents = list(
		/obj/item/taperecorder = 1,
		/obj/item/clothing/accessory/pocketprotector/full = 1,
		/obj/item/clipboard = 1,
		/obj/item/pen/fourcolor = 1,
		/obj/item/pda = 1,
	)


// Follower Guard

/datum/job/followers/f13followerguard
	title = "Town Paramedic"
	flag = F13FOLLOWERGUARD
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 0
	spawn_positions = 3
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Mayor and Doctors. Assuming they're around."
	description = "You are one of the towns Paramedics.  Your job is to prepare parties to go out and try and help those in need that can't make it to the hospital on their own. Be that shooting your way to them or seeking them out with a rescue party."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	selection_color = "#FFDDFF"

	outfit = /datum/outfit/job/followers/f13followerguard

/*
	loadout_options = list(
		/datum/outfit/loadout/guard_ranged,
		/datum/outfit/loadout/guard_close,
		/datum/outfit/loadout/guard_energy
	)
	*/
	access = list(ACCESS_FOLLOWER, ACCESS_MILITARY)
	minimal_access = list(ACCESS_FOLLOWER, ACCESS_MILITARY)

/datum/outfit/job/followers/f13followerguard
	name =	"Town Paramedic"
	jobtype =	/datum/job/followers/f13followerguard
	belt = /obj/item/kit_spawner/follower/guard
	id =	/obj/item/card/id/silver
	uniform =	/obj/item/clothing/under/f13/bodyguard
	suit =	/obj/item/clothing/suit/armor/medium/vest/bulletproof/big
	head =	/obj/item/clothing/head/helmet/riot/vaultsec
	glasses =	/obj/item/clothing/glasses/sunglasses
	shoes =	/obj/item/clothing/shoes/combat
	l_pocket =	/obj/item/storage/belt/shoulderholster
	backpack =	/obj/item/storage/backpack/explorer
	satchel =	/obj/item/storage/backpack/satchel/explorer
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/storage/survivalkit/medical/follower = 1,
		/obj/item/gun/energy/laser/complianceregulator = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/storage/firstaid/ancient = 1,
		/obj/item/stock_parts/cell/ammo/ec = 2,
		/obj/item/storage/belt/army/followers = 1,
		/obj/item/storage/wallet/stash/mid = 1,
	)

/*
/datum/outfit/loadout/guard_ranged
	name = "Followers Ranged Guard"
	suit_store = /obj/item/gun/ballistic/rifle/repeater/cowboy
	backpack_contents = list(
		/obj/item/ammo_box/tube/a357 = 2,
		/obj/item/gun_upgrade/scope/watchman = 1,
	)

/datum/outfit/loadout/guard_close
	name = "Followers Close Protection Guard"
	suit_store = /obj/item/gun/ballistic/shotgun/police
	backpack_contents = list(
		/obj/item/ammo_box/generic/shotgun/bean = 1,
		/obj/item/ammo_box/generic/shotgun/buck = 1,
		/obj/item/ammo_box/generic/shotgun/slug = 1,
	)

/datum/outfit/loadout/guard_energy
	name = "Followers Energy Protection Guard"
	suit_store = /obj/item/gun/energy/laser/wattzs
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/ec = 1,
	)
*/

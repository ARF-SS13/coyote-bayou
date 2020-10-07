/datum/job/followers //do NOT use this for anything, it's just to store faction datums
	department_flag = FOLLOWERS
	selection_color = "#ffeeaa"
	exp_type = EXP_TYPE_FOLLOWERS
	access = list(ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_FOLLOWER)
	forbids = "Aligning oneself with a faction exclusively. Acting in an aggressive and violent way on the offensive, not in defense. Abandoning your facility, peers, and community."
	enforces = "Preaching humanitarianism and valuing human life. Assist and provide medical services to any who require it, regardless of faction. Provide free education for all those who are willing to learn."
	objectivesList = list("Leadership recommends the following goal for this week: Establish medical outposts throughout the wasteland","Leadership recommends the following goal for this week: Experiment with and improve medical techniques and equipment", "Leadership recommends the following goal for this week: Replenish the operation's funds through donations and sales.")

/datum/outfit/job/followers/
	name =		"FOLLOWERSdatums"
	jobtype =	/datum/job/followers/
	shoes =		/obj/item/clothing/shoes/sneakers/black
	id =		null
	ears =		/obj/item/radio/headset/headset_med
	uniform =	/datum/outfit/job/followers/f13followers

/datum/outfit/job/followers/f13followers
	name =		"Followers"
	uniform =	/obj/item/clothing/under/f13/follower

/datum/outfit/job/followers/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return

//datum/outfit/job/followers/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
//	..()
//	if(visualsOnly)
//		return
	//H.add_trait(TRAIT_TECHNOPHREAK, TRAIT_GENERIC)

/*
Administrator
*/
/datum/job/followers/f13leadpractitioner
	title = "Followers Administrator"
	flag = F13LEADPRACTITIONER
	department_flag = FOLLOWERS
	head_announce = list("Security")
	faction = "Followers"
	total_positions = 1
	spawn_positions = 1
	supervisors = "No one."
	description = "You are the Follower Administrator. You are the administrator for the on-site followers. While there is no tradtional chain of command that is used, you have been chosen to lead due to your expert knowledge in the field of medicine and other general knowledges. Make sure that the supplies donated are being put to use, help secure more donations, and fill in as needed whenever short staffed or if the clinic is busy."
	forbids = "Causing harm to others except in times of self-defense."
	enforces = "Followers are not fond of the NCR due to their corruption, but they will help them. They dislike the Brotherhood for hoarding tech, but will make deals to work with them if it furthers the spreading of knowledge. Legion is our mistake and its our job to correct the mistake by speaking of the truth, but recognize that the best way to fight the legion is to teach them and sometimes that can mean helping them.Preaching humanitarianism and valuing human life. Assist and provide medical services to any who require it, regardless of faction. Provide free education for all those who are willing to learn."
	selection_color = "#FF95FF"
	exp_requirements = 1080
	exp_type = EXP_TYPE_FOLLOWERS

	outfit = /datum/outfit/job/followers/f13leadpractitioner

	access = list(ACCESS_FOLLOWER, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_FOLLOWER, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)


/datum/outfit/job/followers/f13leadpractitioner/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.add_trait(TRAIT_TECHNOPHREAK, TRAIT_GENERIC, TRAIT_CHEMWHIZ, TRAIT_PRACTITIONER)

/datum/outfit/job/followers/f13leadpractitioner
	name = "Followers Administrator"
	jobtype = /datum/job/followers/f13leadpractitioner
	id = /obj/item/card/id/silver
	chemwhiz = TRUE
	backpack = /obj/item/storage/backpack/explorer
	uniform = /obj/item/clothing/under/f13/followers
	suit= /obj/item/clothing/suit/toggle/labcoat/cmo
	shoes = /obj/item/clothing/shoes/f13/brownie
	belt = /obj/item/healthanalyzer/advanced
	backpack_contents = list(
		/obj/item/reagent_containers/glass/beaker/bluespace=1,
		/obj/item/storage/firstaid/ancient=1,
		/obj/item/reagent_containers/medspray/synthflesh=2,
		/obj/item/reagent_containers/hypospray/combat=1,
		/obj/item/clothing/glasses/hud/health=1,
		/obj/item/reagent_containers/dropper/SR/NotVault=1,
		/obj/item/book/granter/trait/chemistry=1,
		/obj/item/book/granter/trait/techno=1)

/*
Professor
*/
/datum/job/followers/f13Professor
	title = "Followers Scientist"
	flag = F13PRACTITIONER
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Followers having no strict command structure, don't report to anyone- though they will look to the Administrator for guidance."
	description = "You are a Follower Scientist. As a Scientist it is your job to teach the wastes- be it teaching them how to make medicine, grow crops or treat toxic water. You are a learned individual in your chosen field, you know how to do research and have all the basic tools to teach others how to handle the technology they will come across.Followers are not fond of the NCR due to their corruption, but they will help them. They dislike the Brotherhood for hoarding tech, but will make deals to work with them if it furthers the spreading of knowledge. Legion is our mistake and its our job to correct the mistake by speaking of the truth, but recognize that the best way to fight the legion is to teach them and sometimes that can mean helping them.Preaching humanitarianism and valuing human life, Provide free education for all those who are willing to learn."
	forbids = "Causing harm to others except in times of self-defense."
	enforces = "Followers are not fond of the NCR due to their corruption, but they will help them. They dislike the Brotherhood for hoarding tech, but will make deals to work with them if it furthers the spreading of knowledge. Legion is our mistake and its our job to correct the mistake by speaking of the truth, but recognize that the best way to fight the legion is to teach them and sometimes that can mean helping them.Preaching humanitarianism and valuing human life. Assist and provide medical services to any who require it, regardless of faction. Provide free education for all those who are willing to learn."
	selection_color = "#FFDDFF"
	exp_requirements = 1080
	exp_type = EXP_TYPE_FOLLOWERS

	outfit = /datum/outfit/job/followers/f13Professor

	access = list(ACCESS_FOLLOWER, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_FOLLOWER, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)

/datum/outfit/job/followers/f13Professor/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.add_trait(TRAIT_TECHNOPHREAK, TRAIT_GENERIC, TRAIT_CHEMWHIZ)


/datum/outfit/job/followers/f13Professor
	name = "Followers Scientist"
	jobtype = /datum/job/followers/f13Professor
	backpack = /obj/item/storage/backpack/explorer
	uniform = /obj/item/clothing/under/f13/followers
	suit= /obj/item/clothing/suit/toggle/labcoat/f13/followers
	belt =/obj/item/storage/belt/utility/full/engi
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/storage/firstaid/ancient=1)


/*
Practitioner
*/
/datum/job/followers/f13practitioner
	title = "Followers Doctor"
	flag = F13PRACTITIONER
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Followers having no strict command structure, don't report to anyone- though they will look to the Administrator for guidance."
	description ="You are a Followers Doctor. As a Followers Doctor it is your responsibility to maintain working order in the hospital and to manage its staff and to treat patients who come in regardless of whether or not they can afford care. Some Doctors are known for leaving the hospital to look for injured or those who need help who may not come to a health facility, however it is key that those who do travel around to give aid keep in touch with the rest of staff and if there are no other able physicans or chemist that they stay to offer the best aid possible."
	forbids = "Causing harm to others except in times of self-defense."
	enforces = "Followers are not fond of the NCR due to their corruption, but they will help them. They dislike the Brotherhood for hoarding tech, but will make deals to work with them if it furthers the spreading of knowledge. Legion is our mistake and its our job to correct the mistake by speaking of the truth, but recognize that the best way to fight the legion is to teach them and sometimes that can mean helping them.Preaching humanitarianism and valuing human life. Assist and provide medical services to any who require it, regardless of faction. Provide free education for all those who are willing to learn."
	selection_color = "#FFDDFF"
	exp_requirements = 1080
	exp_type = EXP_TYPE_FOLLOWERS

	outfit = /datum/outfit/job/followers/f13practitioner
	loadout_options = list(
	/datum/outfit/loadout/chemist,
	/datum/outfit/loadout/physician,
	/datum/outfit/loadout/emt
	)

/datum/outfit/job/followers/f13practitioner/pre_equip(mob/living/carbon/human/H, mob/M)
	H.add_trait(TRAIT_PRACTITIONER, TRAIT_GENERIC, TRAIT_CHEMWHIZ)

	//the follower practitioner doesn't need access because it's already set in the /datum/job/follower
	//personally, I don't think a practitioner should have more access than a volunteer.



/datum/outfit/job/followers/f13practitioner
	name = "Followers Doctor"
	jobtype = /datum/job/followers/f13practitioner
	backpack = /obj/item/storage/backpack/explorer
	uniform = /obj/item/clothing/under/f13/followers
	id = /obj/item/card/id/silver
	chemwhiz = TRUE
	backpack_contents = list(
	/obj/item/reagent_containers/hypospray/medipen/stimpak=2,
	/obj/item/reagent_containers/medspray/synthflesh=1,
	/obj/item/storage/firstaid/ancient=1,
	/obj/item/defibrillator/compact/loaded)

/datum/outfit/loadout/chemist
	name = "Chemist"
	backpack_contents = list(
		/obj/item/reagent_containers/glass/beaker/meta=2,
		/obj/item/clothing/glasses/science=1,
		/obj/item/pda/chemist=1,
		/obj/item/clothing/suit/toggle/labcoat/f13/followers=1)

/datum/outfit/loadout/physician
	name = "Physician"
	backpack_contents = list(
		/obj/item/reagent_containers/medspray/synthflesh=1,
		/obj/item/clothing/suit/toggle/labcoat/f13/followers=1,
		/obj/item/reagent_containers/hypospray/CMO=1,
		/obj/item/clothing/glasses/hud/health=1)

/datum/outfit/loadout/emt
	name = "EMT"
	backpack_contents = list(
	    /obj/item/clothing/suit/toggle/labcoat/emt=1,
	    /obj/item/clothing/head/soft/emt=1,
		/obj/item/storage/firstaid/tactical=1,
		/obj/item/reagent_containers/medspray/synthflesh=3)

//datum/outfit/job/followers/practitioner/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
//	..()
//	if(visualsOnly)
//		return
//	H.add_trait(TRAIT_MEDICALEXPERT)

/*
Follower Volunteer
*/

/datum/job/followers/f13followervolunteer
	title = "Followers Volunteer"
	flag = F13FOLLOWERVOLUNTEER
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Followers having no strict command structure, don't report to anyone- though they will look to the Administrator for guidance and the other Doctors as well."
	description = "You are a Follower Volunteer. As a Volunteer, you make sure they get connected to the right people to find treatment, assist in the functions of the hospital, and stepping in for the Doctors when they are not present. Your reason for being here is to provide education and medical services, as well to learn from other Doctors as to better provide medical care for the wastes."
	forbids = "Causing harm to others except in times of self-defense."
	enforces = "Followers are not fond of the NCR due to their corruption, but they will help them. They dislike the Brotherhood for hoarding tech, but will make deals to work with them if it furthers the spreading of knowledge. Legion is our mistake and its our job to correct the mistake by speaking of the truth, but recognize that the best way to fight the legion is to teach them and sometimes that can mean helping them. Preaching humanitarianism and valuing human life. Assist and provide medical services to any who require it, regardless of faction. Provide free education for all those who are willing to learn."
	selection_color = "#FFDDFF"
	exp_type = EXP_TYPE_FOLLOWERS

	outfit = /datum/outfit/job/followers/f13followervolunteer

	//the follower volunteer doesn't need more access as it is already stored in the /datum/job/followers

/datum/outfit/job/followers/f13followervolunteer
	name = "Followers Volunteer"
	jobtype = /datum/job/followers/f13followervolunteer
	backpack = /obj/item/storage/backpack/explorer
	id = /obj/item/card/id/silver
	backpack_contents =  list(
		/obj/item/storage/firstaid/ancient=1)
	uniform = /obj/item/clothing/under/f13/followers
	shoes = /obj/item/clothing/shoes/f13/explorer

/*
Follower Guard
*/

/datum/job/followers/f13followerguard
	title = "Followers Guard"
	flag = F13FOLLOWERGUARD
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Followers having no strict command structure, don't report to anyone- though they will look to the Administrator for guidance and the other Doctors as well."
	description = "You are a Follower Guard. As a Guard for the Followers of Apocalypse, you are responsible for the safety and the maintenance of order in the hospital and among your peers. Your reason for being here is to make sure the other staff can provide education and medical services to those in need, furthering research in non-military matters, as well as helping their communities get access to basic necessities. "
	forbids = "Causing harm to others except in times of self-defense or in defense of other followers."
	enforces = "Followers are not fond of the NCR due to their corruption, but they will help them. They dislike the Brotherhood for hoarding tech, but will make deals to work with them if it furthers the spreading of knowledge. Legion is our mistake and its our job to correct the mistake by speaking of the truth, but recognize that the best way to fight the legion is to teach them and sometimes that can mean helping them. Preaching humanitarianism and valuing human life. Assist and provide medical services to any who require it, regardless of faction. Provide free education for all those who are willing to learn."
	exp_type = EXP_TYPE_FOLLOWERS

	outfit = /datum/outfit/job/followers/f13followerguard

	access = list(ACCESS_FOLLOWER, ACCESS_MILITARY)
	minimal_access = list(ACCESS_FOLLOWER, ACCESS_MILITARY)

/datum/outfit/job/followers/f13followerguard
	name = "Followers Guard"
	jobtype = /datum/job/followers/f13followerguard
	backpack = /obj/item/storage/backpack/explorer
	belt = /obj/item/storage/belt/security/follower
	id = /obj/item/card/id/silver
	uniform = /obj/item/clothing/under/f13/bodyguard
	suit = /obj/item/clothing/suit/armor/vest
	head = /obj/item/clothing/head/helmet/riot/vaultsec
	suit_store = /obj/item/gun/ballistic/shotgun/hunting
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/combat
	neck = 	/obj/item/storage/belt/holster
	backpack_contents = list(
	    /obj/item/gun/ballistic/automatic/pistol/n99=1, \
		/obj/item/flashlight/seclite=1, \
		/obj/item/storage/box/rubbershot/beanbag=1, \
		/obj/item/storage/firstaid/ancient=1)
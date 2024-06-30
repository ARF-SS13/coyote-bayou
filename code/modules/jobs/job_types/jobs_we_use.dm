/* 
 * File:   main.cpp
 * Author: Dr. Mark E. Lehr (modified by John "Starpaws" Ramirez)
 * Created on July 1, 2014, 10:00 AM
 * Purpose: Put all the damn job datums in one place
 * Last Modified: 7/1/2014
 * Last Modified by: John "Starpaws" Ramirez
 * List of Modifications:
 * 1. Added the "Job" structure
 * 2. Added the "Job" structure to the "main" function
 * 3. Added the "Job" structure to the "fillAry" function
 * 4. Added the "Job" structure to the "prntAry" function
 * 5. Fired the "Employee" structure
 * 6. Hired the "Job" structure
 */

//////////////////////////////JOBS//////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
/// WASTELAND FACTION                                                                     //
/// Non-affiliated outsiders who wander the wasteland in search of work and stuff to kill //
////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////
// WASTELANDERS
// Non-affiliated outsiders who wander the wasteland in search of work and stuff to kill
/datum/job/wasteland
	department_flag = WASTELAND
	faction = FACTION_WASTELAND

//////////////////////////////
/// Wastelander
/// As basic as it gets, no masters, no obligations, just you and the wasteland, how fun
/datum/job/wasteland/f13wastelander
	title = "Wastelander"
	flag = F13WASTELANDER
	total_positions = -1
	spawn_positions = -1
	description = "The most broad and open role, you have arrived in the region for purposes known only to you. If you're new, the settlement of Nash to the Midwest may prove a valuable first stop. Try to make a living for yourself - or simply survive - and craft your own unique story."
	supervisors = "fate"
	selection_color = "#dddddd"
	paycheck = 0 // Wastelanders are paid in the form of loot and barter
	outfit = /datum/outfit/wasteland
	access = list()
	minimal_access = list()

//////////////////////////////
/// Radio Operator
/// Some jerkoff who sits in a radio tower and broadcasts their dumb opinions to the world
/datum/job/wasteland/f13radioop
	title = "Radio Operator"
	flag = F13RADIOOP
	// faction = FACTION_OASIS
	total_positions = 2
	spawn_positions = 2
	description = "You are the voice of the wasteland, broadcasting your thoughts and opinions to the world. You have the power to shape the wasteland's future, or simply entertain the masses. The choice is yours."
	supervisors = "the (nonexistent) FCC"
	selection_color = "#dddddd"
	paycheck = COINS_TO_CREDITS(200) // 200 copper per hour
	outfit = /datum/outfit/job/wasteland/f13radioop
	access = list(ACCESS_TCOMSAT)
	minimal_access = list(ACCESS_TCOMSAT)

//////////////////////////////
/// Far-Lands Tribals
/// A wastelander, but with a tribal twist
/datum/job/wasteland/f13tribal
	title = "Far-Lands Tribals"
	flag = F13TRIBAL
	// faction = FACTION_WASTELAND
	social_faction = FACTION_TRIBE
	total_positions = -1
	spawn_positions = -1
	description = "You are a member of the of a tribe who has wandered to this area, but does not belong to the Mountain River tribe.  From where you came is up to you, why you are here is your own, and it is up to you to survive on your own and attempt to thrive."
	supervisors = "the Ways of your own tribe"
	selection_color = "#dddddd"
	outfit = /datum/outfit/job/wasteland/f13tribal
	access = list()
	minimal_access = list()

//////////////////////////////
/// Wasteland Backstage Character
/// Someone who spawned in to mercilessly hump other backstagers
/datum/job/wasteland/backstage
	title = "Backstage Character"
	flag = CBOOCBACKSTAGE
	faction = FACTION_WASTELAND
	total_positions = -1
	spawn_positions = -1
	description = "You are here for one thing and one thing alone: have a good time, either alone, or with others. This role is perfect for someone looking to have a nice private scene with someone, as it is completely safe from the chaos of the main game. Have fun!"
	supervisors = "<i>your throbbing biological urges</i>"
	selection_color = "#dddddd"
	paycheck = 0 // They're likely gonna get Cozy and not get paid anyway
	outfit = /datum/outfit/wasteland
	access = list()
	minimal_access = list()


////////////////////////////////////////////////////////////////////////////////////////////
/// NEW BOSTON TOWNIES FACTION                                                            //
/// The residents of New Boston, here to make a living in this here wasteland, in town    //
////////////////////////////////////////////////////////////////////////////////////////////
/datum/job/townfolk
	exp_type = EXP_TYPE_OASIS
	faction = FACTION_OASIS
	department_flag = DEP_OASIS
	selection_color = "#dcba97"
	total_positions = -1
	spawn_positions = -1
	outfit = /datum/outfit/job/den/f13settler

//////////////////////////////
/// Citizen
/// A basic citizen of New Boston, here to make a living in this here wasteland
/datum/job/townfolk/citizen
	title = "Citizen"
	flag = F13SETTLER
	description = "You are a citizen of New Boston. You have arrived or have been living in the region for purposes known only to you. Try to make a living for yourself - or simply survive - and craft your own unique story."
	supervisors = "the Adventurer's Guild"
	paycheck = COINS_TO_CREDITS(150) // 150 copper per hour
	access = list(ACCESS_BAR)
	minimal_access = list(ACCESS_BAR)


//////////////////////////////
/// Farmer
/// A farmer, here to sit in the fields and grow stuff
/datum/job/townfolk/f13farmer
	title = "Farmer"
	flag = F13FARMER
	description = "You are a farmer, responsible for the cultivation of crops and the care of livestock. You are the backbone of the settlement, providing food and resources for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurer's Guild"
	outfit = /datum/outfit/job/den/f13farmer
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour (they get paid in food) (they can also sell the food) (there's a lot of food)
	access = list(ACCESS_BAR, ACCESS_KITCHEN)
	minimal_access = list(ACCESS_BAR, ACCESS_KITCHEN)

//////////////////////////////
/// Prospector
/// A prospector, here to dig up the ground and find stuff
/datum/job/townfolk/f13prospector
	title = "Prospector"
	flag = F13PROSPECTOR
	description = "You are a prospector, responsible for the extraction of valuable resources from the earth. You are the backbone of the settlement, providing raw materials for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurer's Guild"
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour (they get paid in ore) (they can also sell the ore) (there's a lot of ore)
	outfit = /datum/outfit/job/den/f13prospector
	access = list(ACCESS_BAR, ACCESS_MINING)
	minimal_access = list(ACCESS_BAR, ACCESS_MINING)
	loadout_options = list(
		/datum/outfit/loadout/scavenger,
		/datum/outfit/loadout/miner,
	)

//////////////////////////////
/// Barkeep
/// A barkeep, here to serve drinks and listen to people's problems
/datum/job/townfolk/f13barkeep
	title = "Barkeep"
	flag = F13BARKEEP	
	description = "You are a barkeep, responsible for the operation of the local tavern. You are the backbone of the settlement, providing drinks and entertainment for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild"
	outfit = /datum/outfit/job/den/f13barkeep
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	loadout_options = list(
		/datum/outfit/loadout/diner
	)


//////////////////////////////
/// Club Manager
/// A club manager, here to operate the burlesque bordello house of ill repute and horny furries
/datum/job/townfolk/club_manager
	title = "Club Manager"
	flag = F13MANAGER
	department_head = list("Club Manager")
	faction = FACTION_CLUB
	social_faction = FACTION_CLUB
	total_positions = 1
	spawn_positions = 1
	description = "You are the manager for the Heaven's Night club, responsible for the operation of the establishment. You are the backbone of the settlement, operating the club that provides such sweet relief to survivors of the wasteland. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild, sort of"
	selection_color = "#c94b8a"
	outfit = /datum/outfit/job/heavensnight/f13manager
	access = list(ACCESS_CLUB)
	minimal_access = list(ACCESS_CLUB)

//////////////////////////////
/// Club Worker
/// A club worker, here to provide sweet sweet relief to the horny furries
/datum/job/townfolk/club_worker
	title = "Club Worker"
	flag = F13CLUBWORKER
	department_head = list("Club Worker")
	head_announce = list("Security")
	faction = FACTION_CLUB
	social_faction = FACTION_CLUB
	description = "You are a worker at the Heaven's Night club, providing entertainment and relief to the patrons of the establishment. You are the backbone of the settlement, to provide carnal morale to the hardworking townsfolk. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild, your customers, and the Manager"
	selection_color = "#df80af"
	outfit = /datum/outfit/job/heavensnight/f13clubworker
	access = list(ACCESS_CLUB)
	minimal_access = list(ACCESS_CLUB)

//////////////////////////////
/// Preacher
/// A preacher, here to spread the word of whatever they believe in
/datum/job/townfolk/preacher
	title = "Preacher"
	flag = F13PREACHER
	total_positions = 3
	spawn_positions = 3
	description = "You are a preacher, responsible for the spiritual well-being of the settlement. You are the backbone of the community, providing guidance and comfort to the townsfolk. Your work is essential to the survival of New Boston."
	supervisors = "your god, as well as the Adventurers Guild"
	selection_color = "#dcba97"
	paycheck = COINS_TO_CREDITS(250) // 250 copper per hour
	outfit = /datum/outfit/job/oasis/f13preacher
	access = list(ACCESS_BAR)		//we can expand on this and make alterations as people suggest different loadouts <--I'm doing something about it now!
	minimal_access = list(ACCESS_BAR)

//////////////////////////////
/// Curator (Librarian)
/// A curator, here to collect and organize the knowledge of the wasteland
/datum/job/townfolk/librarian
	title = "Librarian"
	flag = LIBRARIAN
	selection_color = "#dcba97"
	description = "You are the curator of the New Boston Library, responsible for the collection and organization of knowledge. You are the backbone of the settlement, providing access to information and resources for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild"
	paycheck = COINS_TO_CREDITS(200) // 200 copper per hour
	outfit = /datum/outfit/job/den/nashcurator
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)

//////////////////////////////
/// Texarkana Ranger
/// A ranger, here to help out the new folk that roam about
/datum/job/wasteland/ranger
	title = "Texarkana Ranger"
	flag = F13TEACHER
	department_flag = TEACHER
	faction = FACTION_TEACHER
	req_admin_notify = 1
	total_positions = 3
	spawn_positions = 3
	exp_requirements = 0 //10080
	exp_type = EXP_TYPE_LIVING
	description = "Skilled at combat, and hired due to your capabilities, you were given this role to help out the new folk that roam about. Make sure newbies learn the ropes, and offer assistance to any newbie!"
	supervisors = "fate"
	selection_color = "#228c22"
	paycheck = COINS_TO_CREDITS(0) // Nothin!
	outfit = /datum/outfit/job/wasteland/f13ranger
	access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLINIC, ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_CLINIC, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLINIC, ACCESS_FOLLOWER)

//////////////////////////////
/// Adventurer
/// A wastelander, but townie flavored
/datum/job/townfolk/adventurer
	title = "Adventurer"
	flag = DEP_OASIS
	selection_color = "#df80af"
	description = "You are an adventurer, a resident of New Boston who has taken up the call to explore the wasteland. You are the backbone of the settlement, exploring and risking your own (undying) life to bring back resources and knowledge for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild"
	paycheck = COINS_TO_CREDITS(50) // 50 copper per hour
	outfit = /datum/outfit/wasteland
	access = list(ACCESS_BAR)
	minimal_access = list(ACCESS_BAR)


////////////////////////////////////////////////////////////////////////////////////////////
/// RECLAIMERS FACTION                                                                    //
/// The scientists, engineers, and other nerds who are trying to reclaim the wasteland    //
////////////////////////////////////////////////////////////////////////////////////////////

/datum/job/reclaimers
	department_flag = RECLAIMERS
	faction = "Reclaimers"
	total_positions = -1
	spawn_positions = -1
	selection_color = "#a94aa9"
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Doctors. Assuming they're around."
	description = "You are a Town Scientist. As a Scientist it is your job to teach the wastes- be it teaching them how to make medicine, grow crops or treat toxic water. You are a learned individual in your chosen field, you know how to do research and have all the basic tools to teach others how to handle the technology they will come across. You are free to expand upon what projects you wish to accomplish as long as they align with the principles of the doctors."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	outfit = /datum/outfit/job/den/recresearcher
	paycheck = COINS_TO_CREDITS(200) // 200 copper per hour
	access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS, ACCESS_ROBOTICS)
	minimal_access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS, ACCESS_ROBOTICS)

//////////////////////////////
/// Reclaimer Archeologist
/// A reclaimer, here to dig up the past and learn from it
/datum/job/reclaimers/archeologist
	title = "Reclaimer Archeologist"
	flag = RECARCHEOLOGIST
	outfit = /datum/outfit/job/den/recresearcher/archeologist

//////////////////////////////
/// Reclaimer Slimeologist
/datum/job/reclaimers/slimeologist
	title = "Reclaimer Slimeologist"
	flag = RECSLIMEOLOGIST
	outfit = /datum/outfit/job/den/recresearcher/slimeologist

//////////////////////////////
/// Reclaimer Researcher
/// A reclaimer, here to research the wasteland and learn from it
/datum/job/reclaimers/researcher
	title = "Reclaimer Researcher"
	flag = RECRESEARCHER
	outfit = /datum/outfit/job/den/recresearcher

//////////////////////////////
/// Reclaimer Mechanic
/// A reclaimer, here to fix stuff and make stuff
/datum/job/reclaimers/mechanic
	title = "Reclaimer Mechanic"
	flag = RECMECHANIC
	outfit = /datum/outfit/job/den/recresearcher/mechanic

//////////////////////////////
/// Reclaimer Nanite Specialist
/// A reclaimer, here to make tiny robots swim in people's fluids
/datum/job/reclaimers/nanspec
	title = "Reclaimer Nanite Specialist"
	flag = RECNANSPEC
	outfit = /datum/outfit/job/den/recresearcher/nanspec

//////////////////////////////
/// Reclaimer Guard
/// A reclaimer, here to protect the nerds from the wasteland
/datum/job/reclaimers/guard
	title = "Reclaimer Guard"
	flag = RECGUARD
	outfit = /datum/outfit/job/den/recresearcher/guard

//////////////////////////////
/// Reclaimer Healer
/// A reclaimer, here to healslut the unslutted
/datum/job/reclaimers/healer
	title = "Reclaimer Healer"
	flag = RECMEDIC
	outfit = /datum/outfit/job/den/f13practitioner
	paycheck = COINS_TO_CREDITS(250) // 250 copper per hour

////////////////////////////////////////////////////////////////////////////////////////////
/// MOUNTAIN RIVER TRIBE FACTION                                                          //
/// The residents of the local tribe, both of which make sweet subby love to each other   //
////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////
/// Tribal
/// Those who have returned to monke cus why not
/datum/job/tribal
	department_flag = TRIBAL
	selection_color = "#ffeeaa"
	faction = FACTION_TRIBE
	exp_type = EXP_TYPE_TRIBAL
	total_positions = -1
	spawn_positions = -1
	selection_color = "#006666"
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	enforces = "The tribe operate as if they are a part of a singular clan. Any harm dealt upon another member is likened to harm placed upon your brother or sister. Above all things, the tribe comes first."
	objectivesList = list(
		"The Clan has decided to look for fresh blood from the out-peoples.  See if you can find someone to willingly join the tribe and learn our ways.",
		"This week we hunt, gecko's are to be reduced in numbers to a more sustainable level on this land for having murdered too many of our brahmin.",
		"This week we hunt, the Cazador menace is too strong in this land.  Their stingers are dangerous and the elders demand their extinction.",
		"The harvest leaders far off have asked us to find a cursed pre-war weapon that throws burning light at whatever you seek to destroy.  All of them must be found and destroyed, or our crops might fail.",
		"The Village rests, defend it and prosper this week.  Peace is rare, and we should enjoy it with song, dance, and good company.  Feel free to include outsiders if they will follow our ways when on our lands.",
		"The Village rests, defend it and prosper this week.  Peace is rare, but at least we can build defenses and take solitude in our isolation.",
		"The swamp calls the hunters forth, seek out the thing that shines and return it to the spiritual leaders to appease the spirits.  If no spiritual leader can be found then hide the item from the out-peoples.",
		"Something awful happened a bit back and it calls for blood, harass the outlaws of Redwater for their predations of wandering tribesman.  Remember to fortify the southern tunnel to their lands.  We should try to take at least one of them prisoner, and see how they like the collar on their own necks.",
		"The people of tribe of Nash insulted us in recent weeks, harass the people of Nash for their highbrow attitude.  Remember to Fortify the northern entrance to the village, and try to take them down a peg for their witty insolence.",
		"This week is one of rememberance.  Think of the times when our tribe came forth from The Cave of Crying.  Of the friends and loved ones lost.  Remember peace, and cry for what is lost.",
		"This week is one of rememberance.  Think of the times when our tribe has failed at our duties and work together as the family we are to try and solve internal issues. Tomorrow can be better, if only we try today.")

//////////////////////////////
/// Tribal Chief
/// The leader of the tribe, who gets first dibs on the cute tribal furries
/datum/job/tribal/chief
	title = "Chief"
	flag = F13CHIEF
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elders of the tribe."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "The leader and central political figure in this village of the Suplphur Bottom Tribe. You engage in diplomatic meetings with the powers present within the Region to ensure the village's safety and independence."
	outfit = /datum/outfit/job/tribal/f13chief
	paycheck = COINS_TO_CREDITS(150) // 150 copper per hour

//////////////////////////////
/// Tribal Spiritual Leader
/// The spiritual leader of the tribe, who gets first dibs on the other end of those cute tribal furries
/datum/job/tribal/spiritual_leader
	title = "Spiritual Leader"
	flag = F13SHAMAN
	total_positions = 2
	spawn_positions = 2
	supervisors = "The chief.  You are a peer to the harvest leader."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "The spiritual leader and medical leader of the Mountain River Tribe. You aid villagers in their day to day lives but also have access to the spiritual realm via your scrying orb to render assistance on a wider scale."
	outfit = /datum/outfit/job/tribal/f13shaman
	paycheck = COINS_TO_CREDITS(250) // 100 copper per hour

//////////////////////////////
/// Tribal Head Forager
/// The head forager of the tribe, who leads the hunters to find cute tribal furries
/datum/job/tribal/head_forager
	title = "Head Forager"
	flag = F13HHUNTER
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elders of the tribe and the chief."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "You are the village Hunt Master; you organize the hunters of the tribe and are the authority in matters of protecting the tribe and the land of the Mountain River. You lead the Great Hunts and War-Bands in time of conflict."
	outfit = /datum/outfit/job/tribal/f13Hhunter
	paycheck = COINS_TO_CREDITS(100) // 100 copper per hour

//////////////////////////////
/// Tribal Harvest Leader
/// The head farmer of the tribe, who leads the farmers to grow cute tribal furries
/datum/job/tribal/harvest_leader
	title = "Harvest Leader"
	flag = F13DRUID
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Chief"
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "You are a Harvest Leader in the tribe; while you are the one who would be performing rituals for the tribe your usual job is helping the farmers get the most out of our fields."
	outfit = /datum/outfit/job/tribal/f13druid
	paycheck = COINS_TO_CREDITS(100) // 100 copper per hour

//////////////////////////////
/// Tribal Forager
/// A forager of the tribe, who helps the head forager find cute tribal furries
/datum/job/tribal/f13hunter
	title = "Forager"
	flag = F13HUNTER
	supervisors = "The chief and Hunt Master. Failing their appearance you fall back on the Spiritual Leader and Harvest Leader for task management."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "You are a Forager and lowest ranking villager of the tribe; you bring back food and relics, anything that may house a spirit infused from the Time of Crying that can be purified by the Spiritual Leader. While a protector you are also the arm of the tribe in the world, performing tasks from the Spiritual Leaders and Harvest Leaders."
	outfit = /datum/outfit/job/tribal/f13hunter
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour

//////////////////////////////
/// Tribal Guardian
/// A guardian of the tribe, who protects the cute tribal furries
/datum/job/tribal/guardian
	title = "Guardian"
	flag = F13GUARDIAN
	total_positions = 3
	spawn_positions = 3
	supervisors = "All leadership, but the Chief is priority"
	description = "A hand chosen Forager with much promise, you are one of the village Guardians. An elite Hunter given the duty to protect the village, your duty is to ensure your kin are safe at all costs, as well as follow any orders from your superiors and enforce the law of the tribe. You should focus on being available in case of emergencies."
	outfit = /datum/outfit/job/tribal/f13guardian
	paycheck = COINS_TO_CREDITS(200) // 200 copper per hour

//////////////////////////////
/// Tribal Spirit Pledged
/// A cute furry who wants to be part of the tribe
/datum/job/tribal/spirit_pledged
	title = "Spirit-Pledged"
	flag = F13SPIRITPLEDGED
	supervisors = "All other tribals."
	description = "An outsider to the tribe, you have been welcomed in by their higher ups to learn more about the tribes way of life. Perhaps you will attempt to join the tribe, but its not a requirement."
	outfit = /datum/outfit/job/tribal/f13spiritpledged
	paycheck = COINS_TO_CREDITS(50) // 50 copper per hour

//////////////////////////////
/// Tribal Dual Citizen
/// A cute furry who wants to be part of the tribe and the town
/datum/job/tribal/dual_citizen
	title = "Dual Citizen"
	flag = F13VILLAGER
	department_flag = TRIBAL | DEP_OASIS
	supervisors = "New Boston's laws and all tribe members aside from other villagers"
	description = "A proud member of the Mountain River tribe, you do what needs to be done to ensure the survival of yourself and your people while following the laws of the tribe. While it is common to venture out into the wasteland, do not tread far or without informing your kin. You are also a citizen living in Nash. Treat your town with respect and make sure to follow the laws in place, as your premium status may be revoked if you are considered a danger to the populace. One of the local businesses may have work if you require funds."
	outfit = /datum/outfit/job/den/f13dualcitizen
	access = list(ACCESS_TRIBE, ACCESS_BAR)
	minimal_access = list(ACCESS_TRIBE, ACCESS_BAR)
	paycheck = COINS_TO_CREDITS(125) // 125 copper per hour

























GLOBAL_LIST_INIT(tribal_job_recipes, list(
		/datum/crafting_recipe/tribal_pa,
		/datum/crafting_recipe/tribal_pa_helmet,
		/datum/crafting_recipe/tribal_combat_armor,
		/datum/crafting_recipe/tribal_combat_armor_helmet,
		/datum/crafting_recipe/tribal_r_combat_armor,
		/datum/crafting_recipe/tribal_r_combat_armor_helmet,
		/datum/crafting_recipe/tribalwar/chitinarmor,
		/datum/crafting_recipe/tribalwar/lightcloak,
		/datum/crafting_recipe/warmace,
		/datum/crafting_recipe/tribalwar/lighttribe,
		/datum/crafting_recipe/tribalwar/heavytribe,
		/datum/crafting_recipe/tribalwar/legendaryclawcloak,
		/datum/crafting_recipe/tribalwar/aethergiestspear,
		/datum/crafting_recipe/warpaint,
		/datum/crafting_recipe/tribalradio,
		/datum/crafting_recipe/tribalwar/goliathcloak,
		///datum/crafting_recipe/tribalwar/bonebow,
		///datum/crafting_recipe/tribalwar/tribe_bow,
		///datum/crafting_recipe/tribalwar/sturdybow,
		/datum/crafting_recipe/tribalwar/warclub,
		///datum/crafting_recipe/tribalwar/silverbow,
		///datum/crafting_recipe/tribalwar/arrowbone,
		///datum/crafting_recipe/tribalwar/arrowemp,
		/datum/crafting_recipe/tribalwar/bonespear,
		/datum/crafting_recipe/tribalwar/bonecodpiece,
		/datum/crafting_recipe/tribalwar/bracers,
		///datum/crafting_recipe/tribal/bonetalisman,
		/datum/crafting_recipe/spearfisher,
		/datum/crafting_recipe/bitterdrink,
		/datum/crafting_recipe/bitterdrink5,
		/datum/crafting_recipe/healpoultice,
		/datum/crafting_recipe/healpoultice5,
		/datum/crafting_recipe/redambrosia,
		/datum/crafting_recipe/blueambrosia,
		/datum/crafting_recipe/greenambrosia,
		/datum/crafting_recipe/food/pemmican,
		/datum/crafting_recipe/tribal/bonebag,
		/datum/crafting_recipe/horsecream_good))

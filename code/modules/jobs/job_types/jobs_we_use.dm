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
	outfit = /datum/outfit/job/cb

	faction_name = "Wastelanders"
	faction_leader = null
	faction_short_description = {"
		Residents of the wasteland, these wanderers have no masters, no obligations, and no home aside from those they make for themselves. 
		They are free to roam the wasteland as they please, taking on whatever work they can find and making a living for themselves.
	"}
	faction_lore = {"
		Unaligned and untethered to any particular faction, the Wastelanders are a diverse group of individuals who have chosen (or forced) 
		to make their way in the wasteland on their own terms. They are free to roam the wasteland as they please, taking on whatever work 
		they can find and whatever scraps they can scavenge, all in a day's work to see the next sunrise.<br><br>
		While they may not have the resources or the backing of the larger factions, the Wastelanders are a hardy and resourceful bunch, 
		able to make a living for themselves in the harshest of conditions. To be a Wastelander is to be free, to be independent, and to 
		be beholden to no one but yourself. Some may think of their independence as a death sentence, alone to the hellish and often alien 
		forces of the wasteland, but ask any long time Waster and they'll tell you that the wastes fear them more than any other.
	"}
	faction_vibe = {"
		The general vibe of the Wastelanders is one of independence, self-reliance, and a certain degree of lawlessness. 
		Overall, Wastelanders tend to focus on adventuring, scavenging, and survival, often alone or in small groups. 
		It is a great faction for players who want to explore the wasteland, fight monsters, and make it big in the wasteland.
	"}
	faction_goals = {"
		Your goals are whatever you make of them. You are free to roam the wasteland as you please, taking on whatever work you feel like, 
		and making a living for yourself. You can choose to be a hero, a villain, or anything in between. The wasteland is your oyster, 
		though don't be surprised to find a clam instead.
	"}
	faction_rivals = {"
		While the Wastelanders are not officially aligned with any other faction, and by default don't have any official rivals, 
		they are often at odds with the more organized factions of the wasteland. The Wastelanders are a wild card, and their 
		independence and unpredictability can make them a threat to the more established powers of the region. Rivalry is often 
		on a case-by-case basis, and can vary greatly depending on the individual Wastelander and the faction they are dealing with.
	"}
	faction_allies = {"
		While the Wastelanders are not officially aligned with any other faction, and by default don't have any official allies,
		they are often not opposed to working with other factions when it suits their needs. The Wastelanders are a diverse group,
		and their interests can align with those of other factions, even if only temporarily. The Wastelanders are a wild card,
		and their independence and unpredictability can make them valuable allies in the right circumstances.
	"}
	faction_points_of_contention = {"
		Wastelanders are often seen as vagrants, outcasts, and troublemakers by the more established factions of the wasteland. The term 
		'murderhobo' is often used to describe them, and while not all Wastelanders fit this stereotype, many do. Anyone from simple 
		homesteaders to hardened mercenaries to straight up raiders are considered Wastelanders, and being a part of this 'faction' means 
		being associated with all of them. Whether or not this is actually true is up to you to decide.
	"}


//////////////////////////////
/// Wastelander
/// As basic as it gets, no masters, no obligations, just you and the wasteland, how fun
/datum/job/wasteland/f13wastelander
	title = "Wastelander"
	flag = F13WASTELANDER
	total_positions = -1
	spawn_positions = -1
	brief_description = {"
		You are a Wastelander, a wanderer in the wasteland who has arrived in the region for purposes known only to you. 
		Try to make a living for yourself - or simply survive - and craft your own unique story. 
	"}
	description = {"
		You are one of the many Wastelanders who roam the wasteland, making a living out of whatever multi-dimensional horrors 
		and ancient ruins you can find in the wasteland. You could be a scavenger, a mercenary, a raider, or anything in between, 
		but one thing is for sure: you are beholden to no one but yourself. You are free to roam the wasteland as you please,
		taking on whatever work you can find and whatever scraps you can scavenge, all in a day's work!
	"}
	lore = null
	supervisors = "Fate."
	subordinates = "Anyone you can convince to follow you."
	forbids = "Nothing!"
	overall_responsibilities = "Survive, thrive, and make a living for yourself in the wasteland."
	specific_responsibilities = list(
		"Scavenge for supplies and resources.",
		"Explore the wasteland and uncover its secrets.",
		"Take on odd jobs and contracts for pay.",
		"Fight off the various dangers of the wasteland.",
		"Craft and build your own gear and equipment.",
		"Make a name for yourself in the wasteland.",
		"Have fun and make it all up as you go along!",
	)
	day_in_the_life = {"
		As a Wastelander, your day-to-day life is one of adventure, danger, and excitement. You might start your day by scavenging 
		for supplies in the ruins of a pre-war city, then head out to explore a long-forgotten bunker, and end the day by fighting 
		off a horde of mutated creatures. Or you might spend the day building a lovely home in the middle of the swamp for you and 
		that cute radvixen you met this morning. The wasteland is your oyster, and it's up to you to make that oyster a clam!
	"}
	recommended_skills = list(
		REC_SKILL_COMBAT_LVL1,
		REC_SKILL_HEALING_LVL1,
		REC_SKILL_TRAUMA_LVL1,
		REC_SKILL_SURVIVAL_LVL1,
	)
	focus = "Survival, exploration, combat, and crafting, as well as chatting up the various folks you meet in the wasteland."
	difficulty = "Easy to Medium. Most of the challenge comes from combat and survival against monsters and the occasional hostile survivor."
	selection_color = "#dddddd"
	paycheck = 0 // Wastelanders are paid in the form of loot and barter
	access = list()
	minimal_access = list()

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

	brief_description = {"
		You are a member of the of a tribe who has wandered to this area, but does not belong to the Mountain River tribe. 
		From where you came is up to you, why you are here is your own, and it is up to you to survive on your own and attempt to thrive.
	"}
	description = {"
		You are a wastelander who belongs to a tribe that isn't the Mountain River tribe, and may or may not be native to the region. 
		You have your own reasons for being here, and your own goals and ambitions, along with the skills, knowledge, and traditions of 
		your tribe to help you along the way. You are free to roam the wasteland as you please, taking on whatever work you can find and
		whatever scraps you can scavenge. Whether you were born into the tribe or joined later in life, you are a member of this tribe, 
		whatever that may mean to you. Maybe you were cast out for some crime, or maybe you wandered out this way as you were foraging 
		for your camp, or maybe you were just bored and wanted to see what was out past the horizon. Whatever the case, you are here now, 
		and it is up to you to make the most of it.
	"}
	lore = {"
		Most of the tribes in the surrounding regions tend to be nomadic, moving from place to place in search of food, water, and shelter. 
		They are often small, close-knit communities, bound together by blood, tradition, and a shared history. The tribes are often
		led by a chief or elder, who is responsible for making decisions for the tribe and guiding them through the wasteland. The tribes
		often have their own customs, rituals, and beliefs, and are often wary of outsiders, but are not necessarily hostile to them.
		Most tribes tend to favor a simpler set of equipment, often things that can be built out of scavenged materials or parts of the
		land itself, though it is not uncommon for tribes to embrace more advanced technology if they can find it and make use of it.
	"}
	supervisors = "Fate, the Ways of your own tribe, and the whims of whatever god(s) you may or may not believe in."
	subordinates = "Anyone you can convince to follow you and/or your tribe."
	forbids = "Anything that goes against the ways of your tribe, if you have any."
	overall_responsibilities = "Survive, thrive, and make a living for yourself in the wasteland."
	specific_responsibilities = list(
		"Scavenge for supplies and resources.",
		"Explore the wasteland and uncover its secrets.",
		"Take on odd jobs and contracts for pay.",
		"Fight off the various dangers of the wasteland.",
		"Craft and build your own gear and equipment.",
		"Make a name for yourself in the wasteland.",
		"Have fun and make it all up as you go along!",
	)
	day_in_the_life = {"
		As a member of a tribe, your day-to-day life is one of tradition, community, and survival. You might start your day by 
		performing a ritual to honor the spirits of the land, then head out to hunt for food, and end the day by sharing a meal 
		with your tribe around the campfire. Or you might spend the day exploring the ruins of a pre-war city, looking for 
		technology to bring back to your tribe, or fighting off a rival tribe that has encroached on your territory. The wasteland 
		is your home, and it's up to you to protect it and make it thrive!
	"}
	recommended_skills = list(
		REC_SKILL_COMBAT_LVL1,
		REC_SKILL_HEALING_LVL1,
		REC_SKILL_TRAUMA_LVL1,
		REC_SKILL_SURVIVAL_LVL1,
	)
	focus = "Survival, exploration, combat, and crafting, as well as chatting up the various folks you meet in the wasteland."
	difficulty = "Easy to Medium. Most of the challenge comes from combat and survival against monsters and the occasional hostile survivor."
	selection_color = "#dddddd"
	outfit = /datum/outfit/job/cb/tribal
	access = list()
	minimal_access = list()

//////////////////////////////
/// Wasteland Backstage Character Testing Area
/// Someone who spawned in to mercilessly hump other backstagers
/datum/job/wasteland/backstage
	title = "Character Testing Area"
	flag = CBOOCBACKSTAGE
	faction = FACTION_WASTELAND
	total_positions = -1
	spawn_positions = -1

	brief_description = {"
		You are here for one thing and one thing alone: have a good time, either alone, or with others. This role is perfect for someone 
		looking to have a nice private scene with someone, as it is completely safe from the chaos of the main game. Have fun!
	"}
	description = {"
		This is a testing area for characters, where you can try out new builds, test out new mechanics, or just have a good time. 
		As a part of the Backstage, you exist in a state of ambiguous in-character existence, where the canonity of your actions is 
		up to you and whoever you're with. You could be here for any number of reasons, from testing out a new character concept to 
		continuing an RP from last round, to even a multi-hour long session of hard core rutting that cute fox you met in the bar! 
		Whatever the case, you are here to have a good time, and that's all that matters.
	"}
	lore = null
	supervisors = "Your throbbing biological urges."
	subordinates = "Nobody (unless you're into that sort of thing)."
	forbids = "Nothing in particular, as long as it's within the rules of the server, and not disruptive of others trying to do things."
	overall_responsibilities = "Have a good time, either alone, or with others."
	specific_responsibilities = list(
		"Test out new character concepts.",
		"Try out new mechanics and features.",
		"Continue an RP from last round.",
		"Explore the depths of that cute fox you met in the bar.",
		"Have fun and make it all up as you go along!",
	)
	day_in_the_life = {"
		As a Backstage character, your day-to-day life is pretty much whatever you want it to be.
	"}
	recommended_skills = list()
	focus = "Anywhere from testing game mechanics to long-form roleplay in a largely safe area."
	difficulty = "Easy. You can't exactly 'fail' at this role, unless you're trying to."
	selection_color = "#dddddd"
	paycheck = 0 // They're likely gonna get Cozy and not get paid anyway
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
	outfit = /datum/outfit/job/cb

	faction_name = "New Boston Townies"
	faction_leader = "The leader of the New Boston Townies is the Adventurers Guild."
	faction_short_description = {"
		Residents of New Boston, these hardy, ambitious souls have come together to make a living in the harsh wasteland. 
		They are the backbone of the settlement, providing the goods and services that keep the community running.
	"}
	faction_lore = {"
		New Boston, the town on the edge of what could be considered civilization. Situated on the southernmost end of the Corridor, just 
		before the Texarkana Swamp Heap, New Boston exists as the frontier between the known and the unknown, the 'mostly safe' and the 
		'definitely not safe'. Arguably run by the Adventurers Guild, the town serves as a hub for all kinds of folks, those looking for work, 
		adventure, or just something to sate their lust for curiosity and excitement.<br><br>
		The Adventurers Guild is as the name suggests, a loose coalition of adventurers, mercenaries, and other such explorer-salvager folk 
		with a vested interest in taming the multi-dimensional hellscape that is the Wasteland. They're the entire reason that New Boston 
		came to be, as the town was founded by the Guild as a base of operations for their various expeditions and operations in the region. 
		Whether or not you're a part of the Guild, you're a part of New Boston, and that means you're a part of the town's future, for better 
		or for worse.<br><br> Add more lore here as needed.
	"}
	faction_vibe = {"
		The general vibe of the New Boston Townies is one of community, cooperation, and survival. The residents of New Boston are a diverse 
		group of individuals, each with their own skills, talents, and ambitions, but all united in their desire to make a living in the 
		wasteland. The town is a place of opportunity, where hard work and determination can lead to success, and where the bonds of 
		friendship and camaraderie can help you through the toughest of times. It is a great faction for players who want to build a life 
		for themselves in the wasteland, and who are looking for a sense of community and belonging.
	"}
	faction_goals = {"
		Your goals are to make a living for yourself in the wasteland, and to help the town of New Boston thrive. You can choose to be a 
		hero, a villain, or anything in between, but whatever you choose, your actions will have an impact on the town and its residents. 
		Whether you're a farmer, a prospector, a barkeep, or a preacher, you have a role to play in the town's future, and it's up to you 
		to make the most of it.
	"}
	faction_rivals = {"
		The New Boston Townies are not officially aligned with, or against, any other faction, despite being the reason those factions exist 
		in the first place. While new Boston is typically seen as a neutral ground, it is not uncommon for the town to come into conflict 
		with other less savory groups, such as Redwater or the Tunnel Rats. Conflicts are entirely handled outside of the town, and anything 
		that happens in the wastes <b>stays</b> in the wastes.
	"}
	faction_allies = {"
		The New Boston Townies are not officially aligned with any other faction, though they are generally considered to be on good 
		(or at least non-hostile) terms with most of the other factions in the region. The town serves as a hub for all kinds of folks, 
		and the residents of New Boston are known for their hospitality and willingness to work with others, so long as they don't cause 
		too much trouble.
	"}
	faction_points_of_contention = {"
		While the New Boston Townies are generally seen as a friendly and welcoming bunch, they are not without their own internal 
		problems and conflicts. The town is a melting pot of different people, cultures, and beliefs, and tensions can run high at 
		times. Whether it's a dispute over land, resources, or just a good old-fashioned bar fight, the residents of New Boston are 
		not immune to the same problems that plague the rest of the wasteland.
	"}

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
	loadout_options = list(
		/datum/outfit/loadout/farmer
	)
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
	exp_requirements = PLAYTIME_HARD_JOB
	exp_type = EXP_TYPE_LIVING
	access = list(ACCESS_BAR, ACCESS_MINING)
	minimal_access = list(ACCESS_BAR, ACCESS_MINING)
	loadout_options = list(
		/datum/outfit/loadout/miner
	)
	exp_requirements = 1
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// Barkeep
/// A barkeep, here to serve drinks and listen to people's problems
/datum/job/townfolk/f13barkeep
	title = "Barkeep"
	flag = F13BARKEEP	
	description = "You are a barkeep, responsible for the operation of the local tavern. You are the backbone of the settlement, providing drinks and entertainment for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild"
	outfit = /datum/outfit/job/cb/guild/barkeep
	exp_requirements = PLAYTIME_HARD_JOB
	exp_type = EXP_TYPE_LIVING
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	loadout_options = list(
		/datum/outfit/loadout/diner
	)

//////////////////////////////
/// Radio Operator
/// Some jerkoff who sits in a radio tower and broadcasts their dumb opinions to the world
/datum/job/townie/radiooperator
	title = "Radio Operator"
	flag = F13RADIOOP
	// faction = FACTION_OASIS
	total_positions = 2
	spawn_positions = 2
	description = "You are the voice of the wasteland, broadcasting your thoughts and opinions to the world. You have the power to shape the wasteland's future, or simply entertain the masses. The choice is yours."
	supervisors = "the (nonexistent) FCC"
	selection_color = "#dddddd"
	paycheck = COINS_TO_CREDITS(200) // 200 copper per hour
	outfit = /datum/outfit/job/cb/guild/radio
	access = list(ACCESS_TCOMSAT)
	minimal_access = list(ACCESS_TCOMSAT)

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
	exp_requirements = PLAYTIME_HEAD_JOB
	exp_type = EXP_TYPE_LIVING
	description = "You are the manager for the Heaven's Night club, responsible for the operation of the establishment. You are the backbone of the settlement, operating the club that provides such sweet relief to survivors of the wasteland. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild, sort of"
	selection_color = "#c94b8a"
	outfit = /datum/outfit/job/cb/guild/club/manager
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
	outfit = /datum/outfit/job/cb/guild/club
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
	outfit = /datum/outfit/job/cb/guild/preacher
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
	outfit = /datum/outfit/job/cb/guild/curator
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)

//////////////////////////////
/// Banker
/// A banker, here to manage the town's finances and stuff all the cash into their account
/datum/job/townfolk/banker
	title = "Banker"
	flag = F13BANKER
	selection_color = "#dcba97"
	description = "You are the banker of New Boston, responsible for the management of the town's finances. You are the backbone of the settlement, providing financial services and resources for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild"
	total_positions = 2
	spawn_positions = 2
	exp_requirements = PLAYTIME_HARD_JOB
	exp_type = EXP_TYPE_LIVING
	paycheck = COINS_TO_CREDITS(200) // 200 copper per hour
	access = list(ACCESS_BAR, ACCESS_ATMOSPHERICS, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_MINT_VAULT)
	minimal_access = list(ACCESS_BAR, ACCESS_ATMOSPHERICS, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_MINT_VAULT)

//////////////////////////////
/// Shopkeeper
/// A shopkeeper, here to sell stuff for the first hour, then get bored and wander off
/datum/job/townfolk/shopkeeper
	title = "Shopkeeper"
	flag = F13SHOPKEEPER
	selection_color = "#dcba97"
	description = "You are a shopkeeper, responsible for the operation of the local store. You are the backbone of the settlement, providing goods and resources for the community. Your work is essential to the survival of New Boston."
	supervisors = "the Adventurers Guild"
	total_positions = 2
	spawn_positions = 2
	exp_requirements = PLAYTIME_HARD_JOB
	exp_type = EXP_TYPE_LIVING
	paycheck = COINS_TO_CREDITS(200) // 200 copper per hour
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO)

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
	exp_requirements = PLAYTIME_RANGER_JOB
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
	exp_requirements = PLAYTIME_HARD_JOB
	exp_type = EXP_TYPE_LIVING
	paycheck = COINS_TO_CREDITS(50) // 50 copper per hour
	outfit = /datum/outfit/job/cb
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
	exp_requirements = PLAYTIME_HARD_JOB
	exp_type = EXP_TYPE_LIVING
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
	exp_requirements = 0
	exp_type = EXP_TYPE_LIVING

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
	exp_requirements = 0
	exp_type = EXP_TYPE_LIVING

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
	exp_requirements = PLAYTIME_HARD_JOB
	exp_type = EXP_TYPE_LIVING
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
	exp_requirements = PLAYTIME_RANGER_JOB
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// Tribal Spiritual Leader
/// The spiritual leader of the tribe, who gets first dibs on the other end of those cute tribal furries
/datum/job/tribal/spiritual_leader
	title = "Spiritual Leader"
	flag = F13SHAMAN
	total_positions = 2
	spawn_positions = 2
	exp_requirements = PLAYTIME_HEAD_JOB
	exp_type = EXP_TYPE_LIVING
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
	exp_requirements = PLAYTIME_HEAD_JOB
	exp_type = EXP_TYPE_LIVING
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
	exp_requirements = PLAYTIME_HEAD_JOB
	exp_type = EXP_TYPE_LIVING
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
	exp_requirements = PLAYTIME_HEAD_JOB
	exp_type = EXP_TYPE_LIVING
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
	exp_requirements = 0
	exp_type = EXP_TYPE_LIVING

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

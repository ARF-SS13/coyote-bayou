//Contains the Brotherhood
/datum/job/brotherhood
	title = "Brotherhood"
	total_positions = 0
	spawn_positions = 0
	supervisors = "The Elders"
	access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
	)
	minimal_access = list(
		access_brotherhood_general,
		access_brotherhood_armory
	)
	outfit_type = /decl/hierarchy/outfit/job/brotherhood
	department_types = list(/decl/department/brotherhood)

/datum/job/brotherhood/elder
	title = "Elder"
	description = "You lead the local chapter."
	total_positions = 0
	spawn_positions = 0
	supervisors = "You"
	access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	minimal_access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/elder

/datum/job/brotherhood/headpaladin
	title = "Head Paladin"
	description = "You are the acting field commander until the Brotherhood regains its strength enough to place an Elder for the bunker. You are a veteran of many battles and sorties in pursuit of Brotherhood goals; your only weakness may just be your hubris. Your main goals are defense of the Chapter and surveillance of the surrounding region for technology."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elder"
	access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	minimal_access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/headpaladin

/datum/job/brotherhood/headscribe
	title = "Head Scribe"
	description = "You are the foremost experienced scribe remaining in this bunker. Your role is to ensure the safekeeping and proper usage of technology within the Brotherhood. You are also the lead medical expert in this Chapter. Delegate your tasks to your Scribes."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elder"
	access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	minimal_access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/headscribe

/datum/job/brotherhood/headknight
	title = "Head Knight"
	description = "You are the Head Knight, leader of your respective division in the Chapter. Your knowledge of pre-war materials and engineering is almost unparalleled, and you have basic combat training and experience. You are in charge of the Chapter's engineering Corps, and your Knights. Delegate to them as necessary. As Chief Armorer, you are also in charge of the armory."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elder"
	access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	minimal_access = list(
		access_brotherhood_general,
		access_brotherhood_armory,
		access_brotherhood_command
	)
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/headknight

/datum/job/brotherhood/seniorpaladin
	title = "Senior Paladin"
	description = "As the Chapter's senior offensive warrior, you have proven your service and dedication to the Brotherhood over your time as a Paladin. As your skills gained, however, you were deigned to be more useful as a commander and trainer. Your job is to coordinate the Paladins and ensure they work as a team, instilling discipline as you go."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Head Paladin"
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/seniorpaladin

/datum/job/brotherhood/seniorscribe
	title = "Senior Scribe"
	description = "You are the bunker's seniormost medical and scientific expert in the bunker, sans the Head Scribe themselves. You are trained in both medicine and engineering, while also having extensive studies of the old world to assist in pinpointing what technology would be useful to the Brotherhood and its interests."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Head Scribe"
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/seniorscribe

/datum/job/brotherhood/seniorknight
	title = "Senior Knight"
	description = "You report directly to the Head Knight. You are the Brotherhood Senior Knight. Having served the Knight Caste for some time now, you are versatile and experienced in both basic combat and repairs, and also a primary maintainer of the Bunker's facilities. As your seniormost Knight, you may be assigned initiates or Junior Knights to mentor."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Head Knight"
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/seniorknight

/datum/job/brotherhood/paladin
	title = "Paladin"
	description = "You answer directly to the Senior Paladin. You are this Chapter's main line of defense and offense; highly trained in combat and weaponry though with little practical field experience, you are eager to prove your worth to the Brotherhood. Your primary duties are defense and surface operations. You may also be assigned a trainee Initiate."
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Head and Senior Paladin"
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/paladin

/datum/job/brotherhood/scribe
	title = "Scribe"
	description = "You answer directly to the Senior Scribe, tasked with researching and reverse-engineering recovered technologies from the old world, while maintaining the brotherhoods scientific archives. You may also be given a trainee to assign duties to."
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Head and Senior Scribe"
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/scribe

/datum/job/brotherhood/knight
	title = "Knight"
	description = " You are the Brotherhood Knight, the veritable lifeblood of your organization. You are a versatile and adaptably trained person: from your primary duties of weapon & armor repair to basic combat, survival and stealth skills, the only thing you lack is proper experience. You are also in charge of Initiates."
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Head and Senior Knight"
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/knight

/datum/job/brotherhood/initiate
	title = "Initiate"
	description = "Either recently inducted or born into the Brotherhood, you have since proven yourself worthy of assignment to the Chapter. You are to assist your superiors and receive training how they deem fit. You are NEVER allowed to leave the bunker without the direct supervision of a superior; doing so may result in exile or transferrence back the Valley."
	total_positions = 2
	spawn_positions = 2
	supervisors = "Everyone in the Brotherhood"
	access = list(
		access_brotherhood_general
	)
	minimal_access = list(
		access_brotherhood_general
	)
	outfit_type = /decl/hierarchy/outfit/job/brotherhood/initiate

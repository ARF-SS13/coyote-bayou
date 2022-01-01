
GLOBAL_LIST_INIT(engineering_positions, list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician",
	))


GLOBAL_LIST_INIT(medical_positions, list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Virologist",
	"Paramedic",
	"Chemist",
	))


GLOBAL_LIST_INIT(science_positions, list(
	"Research Director",
	"Scientist",
	"Roboticist",
	))

GLOBAL_LIST_INIT(supply_positions, list(
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner",
	))

GLOBAL_LIST_INIT(civilian_positions, list(
	"Head of Personnel",
	"Bartender",
	"Botanist",
	"Cook",
	"Janitor",
	"Curator",
	"Lawyer",
	"Chaplain",
	"Assistant",
	))


GLOBAL_LIST_INIT(nonhuman_positions, list(
	"AI",
	"Cyborg",
	ROLE_PAI,
	))

GLOBAL_LIST_INIT(command_positions, list(
	"Elder",
	"Head Scribe",
	"Head Paladin",
	"Head Knight",

	"Enclave Lieutenant",

	"NCR Captain",
	"NCR Lieutenant",

	"Legate",
	"Legion Centurion",
	"Legion Veteran Decanus",

	"Overseer",
	"Chief of Security",

	"Mayor",
	"Sheriff",

	"Chief",
	"Shaman",
	"Head Hunter",

	"Followers Administrator",

	"Den Mob Boss",
	))

GLOBAL_LIST_INIT(silicon_whitelist_positions, list(
"Mr. Handy"))
//Whitelisted positions list FO13 anything that shows up here requires that the user have an entry in the 'role_whitelist' table of id,ckey,"faction"
//NCR Assistant and Legion Camp Follower re-added to whitelisting.  BoS Initiate removed from whitelist.

GLOBAL_LIST_INIT(faction_whitelist_positions, list(
"Head Scribe",
"Elder",
"Head Paladin",
"Head Knight",
"Head Scribe",
"Senior Paladin",
"Paladin",
"Senior Knight",
"Knight",
"Senior Scribe",
"Scribe",
"BoS Off-Duty",

"Legion Centurion",
"Legion Venator",
"Legion Veteran Decanus",
"Veteran Legionnaire",
"Legion Prime Decanus",
"Prime Legionnaire",
"Legion Recruit Decanus",
"Legion Scout",
"Legion Explorer",
"Legion Auxilia",
"Legion Slave",

"Mayor",
"Sheriff",
"Deputy",
"Shopkeeper",
"Doctor",
"Prospector",
"Detective",

"Chief",
"Shaman",
"Head Hunter",
"Druid",
"Hunter",

"Followers Administrator",
"Followers Doctor",
"Followers Guard",

"Cyborg",
"Overseer",
"Chief of Security",
"Vault-tec Doctor",
"Vault-tec Scientist",
"Vault-tec Security",
"Vault-tec Engineer",
))

GLOBAL_LIST_INIT(brotherhood_positions, list(
	"Head Paladin",
	"Head Knight",
	"Head Scribe",
	"Senior Paladin",
	"Paladin",
	"Senior Knight",
	"Knight",
	"Senior Scribe",
	"Scribe",
	"Initiate",
	"BoS Off-Duty",
))

GLOBAL_LIST_INIT(oasis_positions, list(
	"Mayor",
	"Secretary",
	"Sheriff",
	"Doctor",
	"Citizen",
	"Deputy",
	"Shopkeeper",
	"Farmer",
	"Prospector",
	"Detective",
	"Barkeep",
))

GLOBAL_LIST_INIT(legion_command_positions, list(
	"Legate",
	"Legion Orator",
	"Legion Centurion",
	"Legion Veteran Decanus",
))

GLOBAL_LIST_INIT(legion_positions, list(
	"Legion Orator",
	"Legion Centurion",
	"Legion Veteran Decanus",
	"Legion Prime Decanus",
	"Legion Recruit Decanus",
	"Legion Vexillarius",
	"Legion Explorer",
	"Veteran Legionnaire",
	"Prime Legionnaire",
	"Recruit Legionnaire",
	"Legion Forgemaster",
	"Legion Slavemaster",
	"Legion Auxilia",
	"Legion Slave",
	"Legion Venator",
))

GLOBAL_LIST_INIT(ncr_rangervet_positions, list(
	"NCR Veteran Ranger",
))

GLOBAL_LIST_INIT(ncr_positions, list(
	"NCR Captain",
	"NCR Lieutenant",
	"NCR Veteran Ranger",
	"NCR Representative",
	"NCR Ranger",
	"NCR Sergeant First Class",
	"NCR Heavy Trooper",
	"NCR Military Police",
	"NCR Sergeant",
	"NCR Corporal",
	"NCR Combat Medic",
	"NCR Combat Engineer",
	"NCR Trooper",
	"NCR Medical Officer",
	"NCR Logistics Officer",
	"NCR Rear Echelon",
))

GLOBAL_LIST_INIT(vault_positions, list(
	"Vault-tec Doctor",
	"Vault-tec Scientist",
	"Vault-tec Security",
	"Vault-tec Engineer",
	"Vault Dweller",
	"Cyborg",
))

GLOBAL_LIST_INIT(wasteland_positions, list(
	"Den Mob Boss",
	"Den Mob Enforcer",
	"Den Doctor",
	"Outlaw",
	"Great Khan",
	"Faithful",
	"Vigilante",
	"Preacher",
	"Tribal",
	"Wastelander",
))

GLOBAL_LIST_INIT(enclave_positions, list(
	"Enclave Private",
	"Enclave Sergeant",
	"Enclave Scientist",
	"Enclave Lieutenant",
))

GLOBAL_LIST_INIT(security_positions, list(
	"Vault-tec Security",
	"Deputy",
))
GLOBAL_LIST_INIT(silicon_positions, list(
	"Mr. Handy",
))

GLOBAL_LIST_INIT(tribal_positions, list(
	"Chief",
	"Shaman",
	"Head Hunter",
	"Druid",
	"Villager",
	"Hunter",
	"Spirit-Pledged",
	"Guardian",
))

GLOBAL_LIST_INIT(followers_positions, list(
	"Followers Administrator",
	"Followers Doctor",
	"Followers Guard",
	"Followers Volunteer",
	"Followers Scientist",
))

// job categories for rendering the late join menu
GLOBAL_LIST_INIT(position_categories, list(
	EXP_TYPE_NCR = list("jobs" = ncr_positions, "color" = "#ffeeaa"),
	EXP_TYPE_FOLLOWERS = list("jobs" = followers_positions, "color" = "#ffeeaa"),
	EXP_TYPE_BROTHERHOOD = list("jobs" = brotherhood_positions, "color" = "#95a5a6"),
	EXP_TYPE_LEGION = list("jobs" = legion_positions, "color" = "#ffeeee"),
	EXP_TYPE_WASTELAND = list("jobs" = wasteland_positions, "color" = "#5a5a5a"),
	EXP_TYPE_TRIBAL = list("jobs" = tribal_positions, "color" = "#006666"),
	EXP_TYPE_OASIS = list("jobs" = oasis_positions, "color" = "#d7b088"),
))

GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_CREW = list("titles" = command_positions | engineering_positions | medical_positions | science_positions | supply_positions | security_positions | civilian_positions | list("AI","Cyborg")), // crew positions
	EXP_TYPE_COMMAND = list("titles" = command_positions),
	EXP_TYPE_ENGINEERING = list("titles" = engineering_positions),
	EXP_TYPE_MEDICAL = list("titles" = medical_positions),
	EXP_TYPE_SCIENCE = list("titles" = science_positions),
	EXP_TYPE_SUPPLY = list("titles" = supply_positions),
	EXP_TYPE_SECURITY = list("titles" = security_positions),
	EXP_TYPE_SILICON = list("titles" = list("AI","Cyborg")),
	EXP_TYPE_SERVICE = list("titles" = civilian_positions),

	EXP_TYPE_FALLOUT = list("titles" = brotherhood_positions | oasis_positions | legion_positions | ncr_positions | vault_positions | wasteland_positions | tribal_positions | followers_positions | enclave_positions),

	EXP_TYPE_OUTLAW = list("titles" = list("Outlaw","Den Mob Boss","Den Mob Enforcer","Den Doctor",)),
	EXP_TYPE_BROTHERHOOD = list("titles" = brotherhood_positions),
	EXP_TYPE_OASIS = list("titles" = oasis_positions ),
	EXP_TYPE_LEGION = list("titles" = legion_positions),
	EXP_TYPE_NCR = list("titles" = ncr_positions),
	EXP_TYPE_VAULT = list("titles" = vault_positions),
	EXP_TYPE_WASTELAND = list("titles" = wasteland_positions),
	EXP_TYPE_TRIBAL = list("titles" = tribal_positions),
	EXP_TYPE_FOLLOWERS = list("titles" = followers_positions),
	EXP_TYPE_ENCLAVE = list("titles" = enclave_positions),
	EXP_TYPE_RANGER = list("titles" = list("NCR Veteran Ranger","NCR Ranger")),
	EXP_TYPE_SCRIBE = list("titles" = list("Scribe")),
	EXP_TYPE_DECANUS = list("titles" = list("Legion Decanus")),

	EXP_TYPE_TRIBALCOMMAND = list("titles" = list("Chief","Shaman","Head Hunter")),
	EXP_TYPE_FOLLOWERSCOMMAND = list("titles" = list("Followers Administrator")),
	EXP_TYPE_NCRCOMMAND = list("titles" = list("NCR Lieutenant","NCR Sergeant First Class","NCR Captain", "NCR Veteran Ranger"))
))

GLOBAL_LIST_INIT(exp_specialmap, list(
	EXP_TYPE_LIVING = list(), // all living mobs
	EXP_TYPE_ANTAG = list(),
	EXP_TYPE_SPECIAL = list("Lifebringer","Ash Walker","Exile","Servant Golem","Free Golem","Hermit","Translocated Vet","Escaped Prisoner","Hotel Staff","SuperFriend","Space Syndicate","Ancient Crew","Space Doctor","Space Bartender","Beach Bum","Skeleton","Zombie","Space Bar Patron","Lavaland Syndicate","Ghost Role", "Ghost Cafe Visitor"), // Ghost roles
	EXP_TYPE_GHOST = list() // dead people, observers
))
GLOBAL_PROTECT(exp_jobsmap)
GLOBAL_PROTECT(exp_specialmap)

/proc/guest_jobbans(job)
	return ((job in GLOB.command_positions) || (job in GLOB.nonhuman_positions) || (job in GLOB.security_positions))



//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(job_title)
	if(!job_title)
		return list()

	for(var/datum/job/J in SSjob.occupations)
		if(J.title == job_title)
			return J.department_head //this is a list

/proc/get_full_job_name(job)
	var/static/regex/cap_expand = new("cap(?!tain)")
	var/static/regex/cmo_expand = new("cmo")
	var/static/regex/hos_expand = new("hos")
	var/static/regex/hop_expand = new("hop")
	var/static/regex/rd_expand = new("rd")
	var/static/regex/ce_expand = new("ce")
	var/static/regex/qm_expand = new("qm")
	var/static/regex/sec_expand = new("(?<!security )officer")
	var/static/regex/engi_expand = new("(?<!station )engineer")
	var/static/regex/atmos_expand = new("atmos tech")
	var/static/regex/doc_expand = new("(?<!medical )doctor|medic(?!al)")
	var/static/regex/mine_expand = new("(?<!shaft )miner")
	var/static/regex/chef_expand = new("chef")
	var/static/regex/borg_expand = new("(?<!cy)borg")

	job = lowertext(job)
	job = cap_expand.Replace(job, "captain")
	job = cmo_expand.Replace(job, "chief medical officer")
	job = hos_expand.Replace(job, "head of security")
	job = hop_expand.Replace(job, "head of personnel")
	job = rd_expand.Replace(job, "research director")
	job = ce_expand.Replace(job, "chief engineer")
	job = qm_expand.Replace(job, "quartermaster")
	job = sec_expand.Replace(job, "security officer")
	job = engi_expand.Replace(job, "station engineer")
	job = atmos_expand.Replace(job, "atmospheric technician")
	job = doc_expand.Replace(job, "medical doctor")
	job = mine_expand.Replace(job, "shaft miner")
	job = chef_expand.Replace(job, "cook")
	job = borg_expand.Replace(job, "cyborg")
	return job

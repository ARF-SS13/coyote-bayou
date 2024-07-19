
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
	"Head Paladin",
	"Head Knight",
	"Head Scribe", //Wasn't here before. Still technically command, I put it here - Kitsunemitsu

	"NCR Captain",
	"NCR Veteran Ranger",

	"Pizza Centurion",

	"Chief of Police",

	"Enclave Lieutenant",

	"Noyan",
	"Steward",
	))

GLOBAL_LIST_INIT(silicon_whitelist_positions, list(
"Death Machine"))
//Whitelisted positions list FO13 anything that shows up here requires that the user have an entry in the 'role_whitelist' table of id,ckey,"faction"
//NCR Assistant and Legion Camp Follower re-added to whitelisting.  BoS Initiate removed from whitelist.

GLOBAL_LIST_INIT(faction_whitelist_positions, list(
// "Head Scribe",
// "Elder",
// "Head Paladin",
// "Head Knight",
// "Head Scribe",
// "Senior Paladin",
// "Paladin",
// "Senior Knight",
// "Knight",
// "Senior Scribe",
// "Scribe",
// "BoS Off-Duty",

// "Lil Ceasar's Centurion",
// "Lil Ceasar's Explorer",
// "Lil Ceasar's Middle Manager",
// "Lil Ceasar's Veteran Decanus",
// "Lil Ceasar's Legionnaire",
// "Lil Ceasar's Prime Decanus",
// "Lil Ceasar's Legionnaire",
// "Lil Ceasar's Recruit Decanus",
// "Lil Ceasar's Scout",
// "Lil Ceasar's Cook",
// "Lil Ceasar's Delivery Personel",

// "High Alderperson",
// "Sheriff",
// "Deputy",
// "Deputy Mayor",
// "Texarkana Quartermaster",
// "Texarkana Trade Worker",
// "Doctor",
// "Prospector",
// "Detective",

// "Enclave Lieutenant",
// "Enclave Gunnery Sergeant",
// "Enclave Sergeant",
// "Enclave Armored Infantry",
// "Enclave Specialist",
// "Enclave Scientist",
// "Enclave Private",
// "Enclave Bunker Duty",

// "Chief",
// "Spiritual Leader",
// "Head Forager",
// "Harvest Leader",
// "Forager",

// "Noyan",
// "Steward",
// "Kheshig",
// "Khorchin",
// "Kipchak",

// "Senior Doctor",
// "Town Doctor",
// "Town Paramedic",

// "Cyborg",
// "Overseer",
// "Chief of Security",
// "Vault-tec Doctor",
// "Vault-tec Scientist",
// "Vault-tec Security",
// "Vault-tec Engineer",
))
//Brotherhood
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
))
//Nash/Oasis
GLOBAL_LIST_INIT(oasis_positions, list(
	"Citizen",
	"Radio Operator",
	"Farmer",
	"Shopkeeper",
	"Banker",
	"Prospector",
	"Town Doctor",
	"Town Scientist",
	"Guild Worker",
	"Barkeep",
	"Club Manager",
	"Club Worker",
	"Preacher",
	"Librarian",
	"Texarkana Ranger",
	"Adventurer"
))

//Den Citizenship
GLOBAL_LIST_INIT(den_positions, list(
	"Den Citizen",
	"Den Seeker",
	"Den Siren",
	"Den Miner",
	"Den Tavern Worker",
	"Den Healer",
	"Den Donuteer",
	"Den Keeper",
	"Den Hierophant"
))

//ashdown_positions Citizenship
GLOBAL_LIST_INIT(ashdown_positions, list(
	"Ashdown Artisan",
	"Ashdown Squire",
	"Ashdown Knight",
	"Ashdown Viceroy",
	"Ashdown Canteen Worker",
	"Ashdown Scarlet",
	"Ashdown Apothecary",
	"Ashdown Artiste",
	"Ashdown Silvereye",
))

//Gar Citizenship
//GLOBAL_LIST_INIT(gar_positions, list(
//	"Garland Citizen",
//))

GLOBAL_LIST_INIT(legion_command_positions, list(
	"Legate",
	"Lil' Ceasar's Talking Head",
	"Lil' Ceasar's Centurion",
	"Lil' Ceasar's Veteran Decanus",
))

GLOBAL_LIST_INIT(legion_positions, list(
	"Lil' Ceasar's Talking Head",
	"Lil' Ceasar's Centurion",
	"Lil' Ceasar's Veteran Decanus",
	"Lil' Ceasar's Prime Decanus",
	"Lil' Ceasar's Recruit Decanus",
	"Lil' Ceasar's Vexillarius",
	"Lil' Ceasar's Explorer",
	"Lil' Ceasar's Scout",
	"Lil' Ceasar's Veteran Legionnaire",
	"Lil' Ceasar's Prime Legionnaire",
	"Lil' Ceasar's Recruit Legionnaire",
	"Lil' Ceasar's Legion Forgemaster",
	"Lil' Ceasar's Legion Immune",
	"Lil' Ceasar's Legion Cook",
	"Lil' Ceasar's Delivery Personel",
	"Lil' Ceasar's Middle Manager"
))

GLOBAL_LIST_INIT(ncr_rangervet_positions, list(
	"NCR Veteran Ranger",
))
//NCR
GLOBAL_LIST_INIT(ncr_positions, list(
	"NCR Captain",
	"NCR Lieutenant",
	"NCR Veteran Ranger",
	"NCR Representative",
	"NCR Ranger",
	"NCR Sergeant First Class",
	"NCR Heavy Trooper",
	"NCR Military Police",
	"NCR Senior Enlisted Advisor",
	"NCR Sergeant",
	"NCR Corporal",
	"NCR Combat Medic",
	"NCR Combat Engineer",
	"NCR Trooper",
	"NCR Conscript",
	"NCR Medical Officer",
	"NCR Logistics Officer",
	"NCR Rear Echelon",
))

GLOBAL_LIST_INIT(vault_positions, list(
	"Overseer",
	"Chief of Security",
	"Vault-tec Doctor",
	"Vault-tec Scientist",
	"Vault-tec Security",
	"Vault-tec Engineer",
	"Vault Dweller",
	"Cyborg",
))

GLOBAL_LIST_INIT(wasteland_positions, list(
	// "Den Mob Boss",
	// "Den Mob Enforcer",
	// "Den Doctor",
	"Far-Lands Tribals",
	"Wastelander",
	"Character Testing Area"
))

GLOBAL_LIST_INIT(redwater_positions, list(
	"Redwater Prostitute",
	"Redwater Outrider",
	"Redwater Sawbones",
	"Redwater Cooker",
	"Redwater Bartender",
	"Redwater Townie",
	"Redwater Watcher",
	"Redwater Overboss",
))

GLOBAL_LIST_INIT(tunnelrats_positions, list(
	"Giant Tunnel Rat Supreme", //leader
	"Tunnel Rats Chud", //guard
	"Tunnel Rats Scav", //townie
	"Tunnel Rats Runner", //adventurer
	"Tunnel Rats Swiller", //barkeep
	"Tunnel Rats Techy", //science
	"Tunnel Rats Patcher", //doctor
	"Tunnel Rats Tart", //sex worker
	"Tunnel Rats Digger", //miner
))

GLOBAL_LIST_INIT(khan_positions, list(
	"Noyan",
	"Steward",
	"Kheshig",
	"Khorchin",
	"Kipchak",
	"Mangudai",
))

GLOBAL_LIST_INIT(enclave_positions, list(
	"Enclave Lieutenant",
	"Enclave Gunnery Sergeant",
	"Enclave Sergeant",
	"Enclave Armored Infantry",
	"Enclave Specialist",
	"Enclave Scientist",
	"Enclave Private",
	"Enclave Bunker Duty",
))

GLOBAL_LIST_INIT(security_positions, list(
	"Vault-tec Security",
	"Officer",
))
GLOBAL_LIST_INIT(silicon_positions, list(
	"Sentient Machine",
))
//Tribls
GLOBAL_LIST_INIT(tribal_positions, list(
	"Chief",
	"Shaman",
	"Head Forager",
	"Druid",
	"Forager",
	"Harvest Leader",
	"Spiritual Leader",
	"Spirit-Pledged",
	"Guardian",
	"Dual Citizen"
))
//bikrs
//GLOBAL_LIST_INIT(biker_positions, list(
	//"Overbiker",
	//"Hells Nomad",
	//"Ashdown Citizen",
//))

//bikrs
GLOBAL_LIST_INIT(debug_positions, list(
	"oh my u shouldnt see this uwu~",
	"hi superlagg~",
))
//Followers
GLOBAL_LIST_INIT(followers_positions, list(
	"Senior Doctor",
	"Town Paramedic",
	"Nurse",
	"Senior Scientist",
))

GLOBAL_LIST_INIT(reclaimer_positions, list(
	"Reclaimer Archeologist",
	"Reclaimer Slimeologist",
	"Reclaimer Researcher",
	"Reclaimer Mechanic",
	"Reclaimer Nanite Specialist",
	"Reclaimer Guard",
	"Reclaimer Healer",
))

GLOBAL_LIST_INIT(guild_positions, list(
	"Guild Cataloger",
	"Guild Healer",
	"Guild Shopkeeper",
	"Guild Kitcheneer",
	"Guild Knight",
	"Guild Financier"
))

//Heavens Night
GLOBAL_LIST_INIT(heavensnight_positions, list(
	"Club Manager",
	"Club Worker",
))

/// TODO: Take all these horrible string-based roflcopters and have them 
// job categories for rendering the late join menu
GLOBAL_LIST_INIT(position_categories, list(
	//	EXP_TYPE_NCR = list("jobs" = ncr_positions, "color" = "#ffeeaa"),
	// EXP_TYPE_VAULT = list("jobs" = vault_positions, "color" = "##fdee00"),
	// EXP_TYPE_FOLLOWERS = list("jobs" = followers_positions, "color" = "#ffeeaa"),
	// EXP_TYPE_BROTHERHOOD = list("jobs" = brotherhood_positions, "color" = "#95a5a6"),
	// EXP_TYPE_LEGION = list("jobs" = legion_positions, "color" = "#f81717"),
	EXP_TYPE_WASTELAND = list("jobs" = wasteland_positions, "color" = "#5a5a5a"),
	// EXP_TYPE_ENCLAVE = list("jobs" = enclave_positions, "color" = "#323232"),
	// EXP_TYPE_KHAN = list("jobs" = khan_positions, "color" = "#006666"),
	"New Boston" = list("jobs" = oasis_positions, "color" = "#d7b088"),
	//"Den" = list("jobs" = den_positions, "color" = "#d7b088"),
	"Reclaimers" = list("jobs" = reclaimer_positions, "color" = "#a43dd4"),
	//"Guild" = list("jobs" = guild_positions, "color" = "#d45b3d"),
	//"Garland" = list("jobs" = gar_positions, "color" = "#d7b088"),
	//EXP_TYPE_SILICON = list("jobs" = silicon_positions, "color" = "#4a4a4a"),
	EXP_TYPE_TRIBAL = list("jobs" = tribal_positions, "color" = "#006666"),
	//EXP_TYPE_BIKER = list("jobs" = biker_positions, "color" = "#eb872f"),
	//EXP_TYPE_CLUB = list("jobs" = heavensnight_positions, "color" = "#c94b8a"),
	//"debug" = list("jobs" = debug_positions, "color" = "#ff00ee"),
	"Tunnel Rats" = list("jobs" = tunnelrats_positions, "color" = "#33FF22"),
	"Redwater" = list("jobs" = redwater_positions, "color" = "#FF0000"),
	"Ashdown" = list("jobs" = ashdown_positions, "color" = "#334488"),
	"Den" = list("jobs" = den_positions, "color" = "#884488"),
))

GLOBAL_LIST_INIT(position_ordering, list(
	EXP_TYPE_WASTELAND = list(),
	"New Boston" = list(),
	"Reclaimers" = list(),
	EXP_TYPE_TRIBAL = list(),
	"Guild" = list(),
	"Den" = list(),
	"Ashdown" = list(),
	"Tunnel Rats" = list(),
	"Garland" = list(),
	EXP_TYPE_BROTHERHOOD = list(),
	EXP_TYPE_LEGION = list(),
	EXP_TYPE_NCR = list(),
	EXP_TYPE_VAULT = list(),
	EXP_TYPE_ENCLAVE = list(),
	EXP_TYPE_KHAN = list(),
	EXP_TYPE_FOLLOWERS = list(),
	EXP_TYPE_SILICON = list(),
	EXP_TYPE_CLUB = list(),
	EXP_TYPE_BIKER = list(),
	"debug" = list(),
))

GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_LIVING = list("titles" = tunnelrats_positions | redwater_positions | ashdown_positions | den_positions), // all living mobs
	EXP_TYPE_CREW = list("titles" = command_positions | engineering_positions | medical_positions | science_positions | supply_positions | security_positions | civilian_positions | list("AI","Cyborg")), // crew positions
	EXP_TYPE_COMMAND = list("titles" = command_positions),
	EXP_TYPE_ENGINEERING = list("titles" = engineering_positions),
	EXP_TYPE_MEDICAL = list("titles" = medical_positions),
	EXP_TYPE_SCIENCE = list("titles" = science_positions),
	EXP_TYPE_SUPPLY = list("titles" = supply_positions),
	EXP_TYPE_SECURITY = list("titles" = security_positions),
	EXP_TYPE_SILICON = list("titles" = list("AI","Cyborg")),
	EXP_TYPE_SERVICE = list("titles" = civilian_positions),

	EXP_TYPE_FALLOUT = list("titles" = brotherhood_positions | oasis_positions | legion_positions | ncr_positions | vault_positions | wasteland_positions | tribal_positions | followers_positions | heavensnight_positions | enclave_positions),

	EXP_TYPE_OUTLAW = list("titles" = list("Redwater Townie","Den Mob Boss","Den Mob Enforcer","Den Doctor",)),
	EXP_TYPE_BROTHERHOOD = list("titles" = brotherhood_positions),
	EXP_TYPE_OASIS = list("titles" = oasis_positions ),
	EXP_TYPE_RECLAIMER = list("titles" = reclaimer_positions ),
	EXP_TYPE_GUILD = list("titles" = guild_positions ),
	EXP_TYPE_LEGION = list("titles" = legion_positions),
	EXP_TYPE_NCR = list("titles" = ncr_positions),
	EXP_TYPE_VAULT = list("titles" = vault_positions),
	EXP_TYPE_WASTELAND = list("titles" = wasteland_positions),
	EXP_TYPE_KHAN = list("titles" = khan_positions),
	EXP_TYPE_FOLLOWERS = list("titles" = followers_positions),
	EXP_TYPE_CLUB = list("titles" = heavensnight_positions),
	EXP_TYPE_ENCLAVE = list("titles" = enclave_positions),
	EXP_TYPE_TRIBAL = list("titles" = tribal_positions),
	//EXP_TYPE_BIKER = list("titles" = biker_positions),
	"debug" = list("titles" = debug_positions),
	EXP_TYPE_RANGER = list("titles" = list("NCR Veteran Ranger","NCR Ranger")),
	EXP_TYPE_SCRIBE = list("titles" = list("Scribe")),
	EXP_TYPE_DECANUS = list("titles" = list("Legion Decanus")),

	EXP_TYPE_TRIBALCOMMAND = list("titles" = list("Chief","Shaman","Head Forager")),
	EXP_TYPE_FOLLOWERSCOMMAND = list("titles" = list("Senior Doctor")),
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

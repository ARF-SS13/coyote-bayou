//Contains the Legion

/datum/job/legion/
	title = "Legion"
	total_positions = 0
	spawn_positions = 0
	supervisors = "Caesar"
	access = list(
		access_legion_general,
		access_legion_armory
	)
	minimal_access = list(
		access_legion_general,
		access_legion_armory
	)
	outfit_type = /decl/hierarchy/outfit/job/legion
	department_types = list(/decl/department/legion)

/datum/job/legion/legate
	title = "Legion Legate"
	total_positions = 0
	spawn_positions = 0
	supervisors = "Caesar"
	access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	minimal_access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	outfit_type = /decl/hierarchy/outfit/job/legion/legate

/datum/job/legion/centurion
	title = "Legion Centurion"
	description = "You are the camp commander and strongest soldier. Use your officers, the Decanii, to delegate tasks, make sure you lead and give orders. Take no disrespect, you are the dominus. If you prove a fool or weak, expect to be dispatched by a stronger subordinate."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Legate"
	access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	minimal_access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	outfit_type = /decl/hierarchy/outfit/job/legion/centurion

/datum/job/legion/veterandecanus
	title = "Legion Veteran Decanus"
	description = "You answer directly to the Centurion, his second in command. Lead the camp, ensure its defended, keep track of the Explorers and use your veterans to their full potential."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Centurion"
	access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	minimal_access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	outfit_type = /decl/hierarchy/outfit/job/legion/veterandecanus

/datum/job/legion/primedecanus
	title = "Legion Prime Decanus"
	description = "A experienced officer, often commanding the camp. Give orders, lead patrols."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Veteran Decanus and the Centurion"
	access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	minimal_access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	outfit_type = /decl/hierarchy/outfit/job/legion/primedecanus

/datum/job/legion/recruitdecanus
	title = "Legion Recruit Decanus"
	description = "The junior officer, you must train the recruits and test them, and if a suicide charge is needed, lead them to a glorious death."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Prime/Veteran Decanus and the Centurion"
	access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	minimal_access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	outfit_type = /decl/hierarchy/outfit/job/legion/recruitdecanus

/datum/job/legion/vexillarius
	title = "Legion Vexillarius"
	description = "You are a Veteran of proven bravery. When not fighting, relay orders from the commander and act as a bodyguard."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Veteran Decanus and the Centurion"
	access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	minimal_access = list(
		access_legion_general,
		access_legion_armory,
		access_legion_command
	)
	outfit_type = /decl/hierarchy/outfit/job/legion/vexillarius

/datum/job/legion/explorer
	title = "Legion Explorer"
	description = "Scout the area, secure key points, but do not ignore orders or wordlessly die some place. A good explorer helps his unit by taking initiative and helping the commander without needing micro-managment."
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Veteran Decanus and the Centurion"
	outfit_type = /decl/hierarchy/outfit/job/legion/explorer

/datum/job/legion/vetlegionnaire
	title = "Legion Veteran Legionnaire"
	description = "A hardened warrior, obeying the orders from the Decanus and Centurion is second nature, as is fighting the profligates. If no officers are present, make sure the younger warriors act like proper Legionaires."
	total_positions = 3
	spawn_positions = 3
	supervisors = "The Decani and the Centurion"
	outfit_type = /decl/hierarchy/outfit/job/legion/veteranlegionnaire

/datum/job/legion/primelegionnaire
	title = "Legion Prime Legionnaire"
	description = "A front line soldier who has shown ability to obey and fought in some battles. The Legions muscle, the young men who will build the future with their own blood and sacrifice, for Caesar."
	total_positions = 4
	spawn_positions = 4
	supervisors = "The Decani and the Centurion"
	outfit_type = /decl/hierarchy/outfit/job/legion/primelegionnaire

/datum/job/legion/recruitlegionnaire
	title = "Legion Recruit Legionnaire"
	description = "You have recently come of age or been inducted into Caesar's Legion. You have absolutely no training, and are expected to follow every whim of the Decanii and your Centurion. Respect the soldiers of higher rank."
	total_positions = 5
	spawn_positions = 5
	supervisors = "The Decani and the Centurion"
	outfit_type = /decl/hierarchy/outfit/job/legion/recruitlegionnaire

/datum/job/legion/slavemaster
	title = "Legion Slavemaster"
	description = " The Slavemaster is a legionnaire temporarily assigned to keeping slaves and prisoners in check."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Centurion"
	outfit_type = /decl/hierarchy/outfit/job/legion/slavemaster

/datum/job/legion/forgemaster
	title = "Legion Forgemaster"
	description = "The Forgemaster makes weapons of all sorts and upgrades them, keeping order in the Forge and makes sure the camp is defended."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Centurion"
	outfit_type = /decl/hierarchy/outfit/job/legion/forgemaster

/datum/job/legion/auxilia
	title = "Legion Auxilia"
	description = "A non-combat position in the Legion for free citizens who perform tasks that need special training, such as surgery. They are loyal to the Legion even if they are not treated as equals to warriors."
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Centurion"
	outfit_type = /decl/hierarchy/outfit/job/legion/auxilia

/datum/job/legion/slave
	title = "Legion Slave"
	description = "A slave that survives the breaking camps is given a Legion appropriate name (latin-tribal inspired) and bull tattoo. Be obedient, respectful, stay inside the camp. Work the farm, mine, make food, clean and help injured men. Do NOT escape on your own, up to you how to handle it if forcibly freed by outside forces."
	total_positions = 3
	spawn_positions = 3
	supervisors = "Everyone in the Legion"
	outfit_type = /decl/hierarchy/outfit/job/legion/slave

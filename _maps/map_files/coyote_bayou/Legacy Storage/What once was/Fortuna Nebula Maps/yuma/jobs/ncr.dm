//Contains the NCR

/datum/job/ncr
	title = "NCR"
	total_positions = 0
	spawn_positions = 0
	supervisors = "High Command"
	access = list(
		access_ncr_general,
		access_ncr_armory
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/colonel
	department_types = list(/decl/department/ncr)

/datum/job/ncr/colonel
	title = "NCR Colonel"
	total_positions = 0
	spawn_positions = 0
	supervisors = "High Command"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/colonel

/datum/job/ncr/personalaide
	title = "NCR Personal Aide"
	total_positions = 0
	spawn_positions = 0
	supervisors = "The Colonel"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/personalaide

/datum/job/ncr/captain
	title = "NCR Captain"
	description = "You are the commanding officer of your company and direct superior to the Veteran Ranger and Lieutenant. Coordinating with your staff, you must ensure that the objectives of High Command are completed to the letter. Working closely with your subordinates on logistics, mission planning and special operations with the Rangers, you are here to establish a strong foothold for the NCR within the region."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Colonel"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/captain

/datum/job/ncr/lieutenant
	title = "NCR Lieutenant"
	description = "You are the direct superior to the NCOs and Enlisted, and under special circumstances, Rangers. You are the XO of Camp Miller. You plan patrols, training and missions, working in some cases with Rangers in accomplishing objectives otherwise beyond the capabilities of ordinary enlisted personnel."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Captain"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command,
		access_ncr_vip
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/lieutenant

/datum/job/ncr/medicalofficer
	title = "NCR Medical Officer"
	description = "You are the lead medical professional in Camp Miller, you do not have any command authority unless it is of medical nature. Your duties are to ensure your troopers are in good health and that medical supplies are stocked for troopers."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Captain"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/medicalofficer

/datum/job/ncr/logisticsofficer
	title = "NCR Logistics Officer"
	description = "You are the lead engineering professional in Camp Miller, you do not have any command authority beyond the logistical side. Your duties are to ensure your outpost is well defended, the armory is in order, and you always have supplies. Organize the rear echelon to offload the frontline officers and make things happen."
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Captain"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/logisticsofficer

/datum/job/ncr/representative
	title = "NCR Representative"
	description = "You are a representative for the NCR. You are here to further the objective of the NCR, have been supplied with ample amounts of money to do so."
	total_positions = 1
	spawn_positions = 1
	supervisors = "Lieutenant and Above"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_vip,
		access_ncr_command
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_vip,
		access_ncr_command
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/heavytrooper

/datum/job/ncr/militarypolice
	title = "NCR Military Police"
	description = "You are tasked with the supervision of the NCRA to maintain internal order and disciplice and to prevent any warcrimes from happening."
	total_positions = 2
	spawn_positions = 2
	supervisors = "Lieutenants and above"
	outfit_type = /decl/hierarchy/outfit/job/ncr/militarypolice

/datum/job/ncr/sergeant
	title = "NCR Sergeant"
	description = "You are the direct superior to the enlisted troops, working with the chain of command you echo the orders of your superiors and ensure that the enlisted follow them to the letter. Additionally, you are responsible for the wellbeing of the troops and their ongoing training with the NCR."
	total_positions = 2
	spawn_positions = 2
	supervisors = "Lieutenant and Above"
	outfit_type = /decl/hierarchy/outfit/job/ncr/sergeant

/datum/job/ncr/heavytrooper
	title = "NCR Heavy Trooper"
	description = "You are the most elite of the enlisted, sergeant in rank but forgoing regular command roles to lead in battle only. You are expected to be on the frontlines of every engagement, and to provide firing support for the rank and file. Your power armor lacks the protection the full working sets have, but you have trained with it and can use it in battle well. General Oliver praises you and your other Heavy Troopers, prove to him you're no exception to the rule."
	total_positions = 1
	spawn_positions = 1
	supervisors = "Lieutenant and Above"
	outfit_type = /decl/hierarchy/outfit/job/ncr/heavytrooper

/datum/job/ncr/veteranranger
	title = "NCR Veteran Ranger"
	description = "You answer directly to the Captain, working either independently or in a team to complete your mission objectives however required, operating either alone, in a squad or with the NCR Army. Your primary mission is to improve general opinion of the Republic and to neutralize slavers and raiders operating in the area."
	total_positions = 1
	spawn_positions = 1
	supervisors = "NCRA Captain and High Command"
	access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command
	)
	minimal_access = list(
		access_ncr_general,
		access_ncr_armory,
		access_ncr_command
	)
	outfit_type = /decl/hierarchy/outfit/job/ncr/veteranranger

/datum/job/ncr/ranger
	title = "NCR Ranger"
	description = "As an NCR Ranger, you are the premier special forces unit of the NCR. You are the forward observations and support the Army in it's campaigns, as well as continuing the tradition of stopping slavery in it's tracks."
	total_positions = 2
	spawn_positions = 2
	supervisors = "Veteran Ranger"
	outfit_type = /decl/hierarchy/outfit/job/ncr/ranger

/datum/job/ncr/corporal
	title = "NCR Corporal"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Sergeants and Above"
	outfit_type = /decl/hierarchy/outfit/job/ncr/corporal

/datum/job/ncr/combatengineer
	title = "NCR Combat Engineer"
	description = "You are a senior enlisted trooper with an engineering skill set. You work closely with your squad, taking orders from the officers. You have the authority to command troopers if there are no non-commissioned officers present."
	total_positions = 1
	spawn_positions = 1
	supervisors = "Corporals and Above"
	outfit_type = /decl/hierarchy/outfit/job/ncr/combatengineer

/datum/job/ncr/combatmedic
	title = "NCR Combat Medic"
	description = "You are a senior enlisted with a medical skill set. You work closely with your squad, taking orders from your officers. You have the authority to command troopers if there are no non-commissioned officers present."
	total_positions = 2
	spawn_positions = 2
	supervisors = "Corporals and Above"
	outfit_type = /decl/hierarchy/outfit/job/ncr/combatmedic

/datum/job/ncr/trooper
	title = "NCR Trooper"
	description = "You are the backbone of the NCR Army. Obey your the NCOs and officers, no matter if you are a conscript or a volounteer you are expected to follow military discipline."
	total_positions = 8
	spawn_positions = 8
	supervisors = "Corporals and Above"
	outfit_type = /decl/hierarchy/outfit/job/ncr/trooper

/datum/job/ncr/rearechelon
	title = "NCR Rear Echelon"
	description = "You are the support element sent to assist the Camp Miller garrison. You are essential specialized support staff to help sustain the base via supply or specialized skills. You are not allowed to leave base unless given an explicit order by the CO or the current acting CO."
	total_positions = 4
	spawn_positions = 4
	supervisors = "Logistics/Medical officer first, regular chain of command after that"
	outfit_type = /decl/hierarchy/outfit/job/ncr/rearechelon

//Contains general wastelanders.

/decl/department/wasteland
	name = "Wastelanders"
	display_priority = -1
	display_color = "#04e046"

/datum/job/wastelander
	title = "Wastelander"
	total_positions = -1
	spawn_positions = -1
	supervisors = "You are your own boss in these parts."
	outfit_type = /decl/hierarchy/outfit/job/wastelander
	department_types = list(/decl/department/wasteland)

/datum/job/outlaw
	title = "Outlaw"
	total_positions = 10
	spawn_positions = 10
	supervisors = "You are your own boss in these parts."
	outfit_type = /decl/hierarchy/outfit/job/wastelander/outlaw
	department_types = list(/decl/department/wasteland)

//Contains the Great Khans. They fall under wasteland for now.

/datum/job/khan
	title = "Great Khan"
	description = "You are no common raider or tribal settler, for you are a Great Khan. Your ancestry is that of fierce warriors and noble chieftans, whose rites and sagas tell of blood soaked battlefields and great sacrifice for your tribe. At least, this was once the case: after the massacre at Bitter Springs by the NCR, your people have lost much of their strength - now you and many other Khans travel west of Vegas through Red Rock Canyon in the hopes of settling in the region of Yuma."
	total_positions = 6
	spawn_positions = 6
	supervisors = "Your gang leadership."
	account_allowed = 0
	access = list(
		access_khans_general
	)
	minimal_access = list(
		access_khans_general
	)
	outfit_type = /decl/hierarchy/outfit/job/khan
	department_types = list(/decl/department/wasteland)

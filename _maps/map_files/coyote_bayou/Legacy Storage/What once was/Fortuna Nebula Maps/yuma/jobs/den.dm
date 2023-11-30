//Contains Den jobs. They fall under the wasteland faction for now.

/datum/job/den
	title = "Den"
	total_positions = 0
	spawn_positions = 0
	supervisors = "You are your own boss."
	access = list(
		access_den_general
	)
	minimal_access = list(
		access_den_general
	)
	outfit_type = /decl/hierarchy/outfit/job/den
	department_types = list(/decl/department/wasteland)

/datum/job/den/boss
	title = "Den Mob Boss"
	description = "The mob rules in Yuma, and you're on top. Keeping the loose association of Khans, outlaws, and other no-goods together you maintain order in The Den by force. Ensure that all inhabitants of the Den obey their rules, and spread your influence over the wasteland. Be careful though - even your own men can't be trusted."
	total_positions = 1
	spawn_positions = 1
	supervisors = "You are your own boss."
	outfit_type = /decl/hierarchy/outfit/job/den/boss

/datum/job/den/doctor
	title = "Den Mob Doctor"
	description = "While you prioritize providing medical treatment in emergency situations, you are still trained in combat and have the additional role as a loyal combanteer to the Den."
	total_positions = 2
	spawn_positions = 2
	supervisors = "Den Mob Boss"
	outfit_type = /decl/hierarchy/outfit/job/den/doctor

/datum/job/den/enforcer
	title = "Den Mob Enforcer"
	description = "The mob rules in Yuma. A hitman for the Den's Boss, you are a highly loyal enforcer charged with keeping order among the outlaw groups inhabiting the Den."
	total_positions = 2
	spawn_positions = 2
	supervisors = "Den Mob Boss"
	outfit_type = /decl/hierarchy/outfit/job/den/enforcer

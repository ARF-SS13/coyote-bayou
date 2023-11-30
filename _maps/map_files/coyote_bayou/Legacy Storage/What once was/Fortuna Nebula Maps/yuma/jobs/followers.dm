//Contains Followers

/datum/job/followers
	title = "Followers"
	total_positions = 0
	spawn_positions = 0
	supervisors = "The Administrator"
	access = list(
		access_followers_general
	)
	minimal_access = list(
		access_followers_general
	)
	outfit_type = /decl/hierarchy/outfit/job/followers
	department_types = list(/decl/department/followers)

/datum/job/followers/administrator
	title = "Followers Administrator"
	description = "You are the Follower Administrator. You are the administrator for the on-site followers. While there is no tradtional chain of command that is used, you have been chosen to lead due to your expert knowledge in the field of medicine and other general knowledges. Make sure that the supplies donated are being put to use, help secure more donations, and fill in as needed whenever short staffed or if the clinic is busy."
	total_positions = 1
	spawn_positions = 1
	supervisors = "You are the boss."
	access = list(
		access_followers_general,
		access_followers_command
	)
	minimal_access = list(
		access_followers_general,
		access_followers_command
	)
	outfit_type = /decl/hierarchy/outfit/job/followers/administrator

/datum/job/followers/doctor
	title = "Followers Doctor"
	description ="You are a Followers Doctor. As a Followers Doctor it is your responsibility to maintain working order in the hospital and to manage its staff and to treat patients who come in regardless of whether or not they can afford care. Some Doctors are known for leaving the hospital to look for injured or those who need help who may not come to a health facility, however it is key that those who do travel around to give aid keep in touch with the rest of staff and if there are no other able physicans or chemist that they stay to offer the best aid possible."
	total_positions = 3
	spawn_positions = 3
	supervisors = "The Administrator"
	outfit_type = /decl/hierarchy/outfit/job/followers/doctor

/datum/job/followers/guard
	title = "Followers Guard"
	description = "You are a Follower Guard. As a Guard for the Followers of Apocalypse, you are responsible for the safety and the maintenance of order in the hospital and among your peers. Your reason for being here is to make sure the other staff can provide education and medical services to those in need, furthering research in non-military matters, as well as helping their communities get access to basic necessities. "
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Administrator and Doctors"
	outfit_type = /decl/hierarchy/outfit/job/followers/guard

/datum/job/followers/volunteer
	title = "Followers Volunteer"
	description = "You are a Follower Volunteer. As a Volunteer, you make sure they get connected to the right people to find treatment, assist in the functions of the hospital, learn from senior Followers, and utilize first aid to the best of your capacity when Doctors are not present."
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Administrator and Doctors"
	outfit_type = /decl/hierarchy/outfit/job/followers/volunteer

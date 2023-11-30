//Followers Outfits

/decl/hierarchy/outfit/job/followers
	name = "Role - Followers"
	id_type = /obj/item/card/id/followers
	l_ear = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/followers_uniform
	pda_type = null
	shoes = /obj/item/clothing/shoes/dress

/decl/hierarchy/outfit/job/followers/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_FOLLOWERS

/decl/hierarchy/outfit/job/followers/administrator
	name = "Role - Followers Administrator"

/decl/hierarchy/outfit/job/followers/doctor
	name = "Role - Followers Doctor"

/decl/hierarchy/outfit/job/followers/guard
	name = "Role - Followers Guard"

/decl/hierarchy/outfit/job/followers/volunteer
	name = "Role - Followers Volunteer"

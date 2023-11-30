//Den Outfits

/decl/hierarchy/outfit/job/den
	name = "Role - Den"
	id_type = /obj/item/card/id/den
	uniform = /obj/item/clothing/under/den_uniform
	pda_type = null
	shoes = /obj/item/clothing/shoes/color/brown

/decl/hierarchy/outfit/job/den/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_DEN

/decl/hierarchy/outfit/job/den/enforcer
	name = "Role - Den Enforcer"

/decl/hierarchy/outfit/job/den/doctor
	name = "Role - Den Doctor"

/decl/hierarchy/outfit/job/den/boss
	name = "Role - Den Boss"

//Oasis Outfits

/decl/hierarchy/outfit/job/oasis
	name = "Role - Oasis"
	id_type = /obj/item/card/id/oasis
	pda_type = /obj/item/modular_computer/pda
	l_ear = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/settler_uniform
	pda_type = null
	shoes = /obj/item/clothing/shoes/color/brown

/decl/hierarchy/outfit/job/oasis/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_OASIS

/decl/hierarchy/outfit/job/oasis/mayor
	name = "Role - Mayor"

/decl/hierarchy/outfit/job/oasis/sheriff
	name = "Role - Sheriff"
	id_type = /obj/item/card/id/oasis/sheriff
	uniform = /obj/item/clothing/under/oasis_uniform

/decl/hierarchy/outfit/job/oasis/deputy
	name = "Role - Deputy"
	id_type = /obj/item/card/id/oasis/deputy
	uniform = /obj/item/clothing/under/oasis_uniform

/decl/hierarchy/outfit/job/oasis/shopkeep
	name = "Role - Shopkeep"

/decl/hierarchy/outfit/job/oasis/detective
	name = "Role - Detective"

/decl/hierarchy/outfit/job/oasis/preacher
	name = "Role - Preacher"

/decl/hierarchy/outfit/job/oasis/barkeep
	name = "Role - Barkeep"

/decl/hierarchy/outfit/job/oasis/citizen
	name = "Role - Citizen"

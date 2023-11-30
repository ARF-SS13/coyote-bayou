//Outfits for Brotherhood

/decl/hierarchy/outfit/job/brotherhood
	name = "Role - Brotherhood"
	id_type = /obj/item/card/id/brotherhood
	uniform = /obj/item/clothing/under/bos_uniform
	shoes = /obj/item/clothing/shoes/brotherhoodboots
	pda_type = null

/decl/hierarchy/outfit/job/brotherhood/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_BROTHERHOOD

/decl/hierarchy/outfit/job/brotherhood/elder
	name = "Role - Elder"

/decl/hierarchy/outfit/job/brotherhood/headpaladin
	name = "Role - Head Paladin"

/decl/hierarchy/outfit/job/brotherhood/headscribe
	name = "Role - Head Scribe"

/decl/hierarchy/outfit/job/brotherhood/headknight
	name = "Role - Head Knight"

/decl/hierarchy/outfit/job/brotherhood/seniorpaladin
	name = "Role - Senior Paladin"

/decl/hierarchy/outfit/job/brotherhood/seniorscribe
	name = "Role - Senior Scribe"

/decl/hierarchy/outfit/job/brotherhood/seniorknight
	name = "Role - Senior Knight"

/decl/hierarchy/outfit/job/brotherhood/paladin
	name = "Role - Paladin"

/decl/hierarchy/outfit/job/brotherhood/scribe
	name = "Role - Scribe"

/decl/hierarchy/outfit/job/brotherhood/knight
	name = "Role - Knight"

/decl/hierarchy/outfit/job/brotherhood/initiate
	name = "Role - Initiate"

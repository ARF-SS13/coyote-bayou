//Wastelander Outfits

/decl/hierarchy/outfit/job/wastelander
	name = "Role - Wastelander"
	l_ear = /obj/item/radio/headset
	id_type = null
	uniform = /obj/item/clothing/under/settler_uniform
	pda_type = null
	shoes = /obj/item/clothing/shoes/color/brown

/decl/hierarchy/outfit/job/wastelander/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_WASTELANDER

/decl/hierarchy/outfit/job/wastelander/outlaw
	name = "Role - Outlaw"

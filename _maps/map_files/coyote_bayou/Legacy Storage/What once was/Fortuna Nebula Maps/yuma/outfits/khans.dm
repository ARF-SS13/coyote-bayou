//Khans outfits

/decl/hierarchy/outfit/job/khan
	name = "Role - Great Khan"
	id_type = /obj/item/card/id/khan
	l_ear = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/khans_uniform
	pda_type = null
	shoes = /obj/item/clothing/shoes/color/brown

/decl/hierarchy/outfit/job/khan/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_KHAN

/obj/item/clothing/suit/toggle/labcoat
	name = "labcoat"
	desc = "(I) A suit that protects against minor chemical spills."
	icon_state = "labcoat"
	item_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS

	armor = list("tier" = 1,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	togglename = "buttons"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/toggle/labcoat/cmo
	name = "chief medical officer's labcoat"
	desc = "(I) Bluer than the standard model."
	icon_state = "labcoat_cmo"
	item_state = "labcoat_cmo"

/obj/item/clothing/suit/toggle/labcoat/mad
	name = "\proper The Mad's labcoat"
	desc = "(I) It makes you look capable of konking someone on the noggin and shooting them into space."
	icon_state = "labgreen"
	item_state = "labgreen"

/obj/item/clothing/suit/toggle/labcoat/genetics
	name = "geneticist labcoat"
	desc = "(I) A suit that protects against minor chemical spills. Has a blue stripe on the shoulder."
	icon_state = "labcoat_gen"

/obj/item/clothing/suit/toggle/labcoat/chemist
	name = "chemist labcoat"
	desc = "(I) A suit that protects against minor chemical spills. Has an orange stripe on the shoulder."
	icon_state = "labcoat_chem"

/obj/item/clothing/suit/toggle/labcoat/virologist
	name = "virologist labcoat"
	desc = "(I) A suit that protects against minor chemical spills. Offers slightly more protection against biohazards than the standard model. Has a green stripe on the shoulder."
	icon_state = "labcoat_vir"

/obj/item/clothing/suit/toggle/labcoat/science
	name = "scientist labcoat"
	desc = "(I) A suit that protects against minor chemical spills. Has a purple stripe on the shoulder."
	icon_state = "labcoat_tox"

// Departmental Jackets

/obj/item/clothing/suit/toggle/labcoat/depjacket/sci
	name = "science jacket"
	desc = "(I) A comfortable jacket in science purple."
	icon_state = "sci_dep_jacket"
	item_state = "sci_dep_jacket"
	armor = list("tier" = 1,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/toggle/labcoat/depjacket/med
	name = "medical jacket"
	desc = "(I) A comfortable jacket in medical blue."
	icon_state = "med_dep_jacket"
	item_state = "med_dep_jacket"
	armor = list("tier" = 1, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/toggle/labcoat/depjacket/sec
	name = "security jacket"
	desc = "(III) A comfortable jacket in security red."
	icon_state = "sec_dep_jacket"
	item_state = "sec_dep_jacket"
	armor = list("tier" = 3, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/toggle/labcoat/depjacket/sup
	name = "supply jacket"
	desc = "(I) A comfortable jacket in supply brown."
	icon_state = "supply_dep_jacket"
	item_state = "supply_dep_jacket"

/obj/item/clothing/suit/toggle/labcoat/depjacket/sup/qm
	name = "quartermaster's jacket"
	desc = "(I) A loose covering often warn by station quartermasters."
	icon_state = "qmjacket"
	item_state = "qmjacket"

/obj/item/clothing/suit/toggle/labcoat/depjacket/eng
	name = "engineering jacket"
	desc = "(I) A comfortable jacket in engineering yellow."
	icon_state = "engi_dep_jacket"
	item_state = "engi_dep_jacket"
	armor = list("tier" = 1, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 20, "fire" = 30, "acid" = 45)

/obj/item/clothing/suit/toggle/labcoat/fieldscribe
	name = "fieldscribe suit"
	desc = "(II) A suit that protects against the weather, and looks stylish, but not much else."
	icon_state = "fieldscribe"
	armor = list("tier" = 2, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/toggle/labcoat/scribecoat
	name = "fieldscribe coat"
	desc = "(IV) A heavy-duty coat and chestrig fitted with tons of pockets. Ballistic weave and ceramic inserts are included to substantially increase Field Scribe survival rates."
	icon_state = "scribecoat"
	armor = list("tier" = 4, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

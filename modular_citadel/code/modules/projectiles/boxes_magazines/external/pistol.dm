/datum/design/bolt_clip
	name = "Surplus Rifle Clip"
	desc = "A stripper clip used to quickly load bolt action rifles. Contains 5 rounds."
	id = "bolt_clip"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 8000)
	build_path = /obj/item/ammo_box/a762
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/m45 //Kinda NT in theory
	name = "handgun magazine (.45)"
	id = "m45"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 80000)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/sl357
	name = "revolver speedloader (.357)"
	desc = "A revolver speedloader."
	id = "sl357"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/a357
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/sl357ap
	name = "revolver speedloader (.357 AP)"
	desc = "A revolver speedloader. Cuts through like a hot knife through butter."
	id = "sl357ap"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 30000, /datum/material/titanium = 45000)
	build_path = /obj/item/ammo_box/a357/ap
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

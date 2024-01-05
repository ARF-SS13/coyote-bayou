/datum/design/bluespacespray
	name = "Bluespace Spray"
	desc = "A bluespace sprayer, may be illegal in some places due to honkers."
	id = "bluespacespray"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 2250, /datum/material/plasma = 2250, /datum/material/diamond = 185, /datum/material/bluespace = 185)
	build_path = /obj/item/reagent_containers/spray/bluespace
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/dropper
	name = "Dropper"
	desc = "A dropper. Holds up to 5 units."
	id = "dropper"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/reagent_containers/dropper
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/cyberimp_toolset_advanced
	name = "Advanced Toolset Arm Implant"
	desc = "A very advanced version of the regular toolset implant, has alien stuff!"
	id = "ci-toolset-adv"
	build_type = PROTOLATHE | MECHFAB
	materials = list (/datum/material/iron = 7500, /datum/material/glass = 4500, /datum/material/silver = 4500)
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/toolset/advanced
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/cyberimp_surgical_advanced
	name = "Advanced Surgical Arm Implant"
	desc = "A very advanced version of the regular surgical implant, has alien stuff!"
	id = "ci-surgery-adv"
	build_type = PROTOLATHE | MECHFAB
	materials = list (/datum/material/iron = 7500, /datum/material/glass = 4500, /datum/material/silver = 4500)
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/surgery/advanced
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/shuttle_smoothsail_upgrade
	name = "Shuttle Smooth Sailing Upgrade"
	desc = "A disk that allows for steadier movement without the need of raw force to move. (Makes shuttles not throw stuff around)"
	id = "disk_shuttle_smoothsail"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000)
	build_path = /obj/item/shuttle_smoothsail
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

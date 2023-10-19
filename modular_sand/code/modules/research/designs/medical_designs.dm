/datum/design/ultimatebeaker
	name = "Ultimate Beaker"
	desc = "An ultimate beaker, made by extrapolating on bluespace technology with dark matter combined. Can hold up to 900 units."
	id = "ultimatebeaker"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000,
					/datum/material/glass = 3000,
					/datum/material/plasma = 3000,
					/datum/material/diamond = 500,
					/datum/material/bluespace = 500)
	build_path = /obj/item/reagent_containers/glass/beaker/ultimate
	reagents_list = list(/datum/reagent/liquid_dark_matter = 10)
	category = list("Medical Designs")
	lathe_time_factor = 0.8
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SERVICE

/obj/machinery/chem_lab/drug_lab
	name = "drug chemistry lab"
	desc = "Creates and dispenses drugs. Uses skill checks to function."
	circuit = /obj/item/circuitboard/machine/drug_lab
	basic_chemicals = list(
		/datum/reagent/medicine/morphine = 2,
		/datum/reagent/drug/space_drugs = 4,
		/datum/reagent/drug/crank = 4,
		/datum/reagent/drug/heroin = 4,
		/datum/reagent/medicine/spaceacillin = 3,
		/datum/reagent/medicine/ephedrine = 3,
		/datum/reagent/drug/skooma = 3
	)
	//These become available once upgraded.
	advanced_chemicals = list(
		/datum/reagent/drug/methamphetamine = 5,
		/datum/reagent/drug/heroin = 5,
		/datum/reagent/drug/bath_salts = 4,
		/datum/reagent/drug/aranesp = 4,
		/datum/reagent/drug/happiness = 4,
		/datum/reagent/drug/jet = 6
	)

	expert_chemicals = list(
		/datum/reagent/medicine/medx = 6,
		/datum/reagent/drug/turbo = 6,
		/datum/reagent/drug/psycho = 6,
		/datum/reagent/drug/buffout = 6
	)

	upgraded_chemicals = list(
		/datum/reagent/drug/happiness = 4,
		/datum/reagent/drug/heroin = 5,
		/datum/reagent/drug/aphrodisiac = 3,
		/datum/reagent/drug/anaphrodisiac = 3
	)

	upgraded_chemicals2 = list(
		/datum/reagent/medicine/strange_reagent = 4,
		/datum/reagent/medicine/mentat = 3,
		/datum/reagent/medicine/stimpak = 3
	)

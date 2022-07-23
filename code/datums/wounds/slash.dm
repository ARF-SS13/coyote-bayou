/* * * *
 * Cuts
 * * * */

/datum/wound/bleed/slash
	sound_effect = 'sound/weapons/slice.ogg'
	wound_type = WOUND_SLASH

/datum/wound/bleed/slash/moderate
	name = "Minor Laceration" // Minor. Laceration. Detected.
	desc = "Patient's skin has been badly scraped, generating moderate blood loss."
	treat_text = "Application of clean bandages or first-aid grade sutures, followed by food and rest."
	examine_desc = "has an open cut"
	occur_text = "is cut open, slowly leaking blood"
	sound_effect = 'sound/effects/wounds/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 3
	minimum_flow = 0.375
	max_per_type = 3
	required_bandage_power = 10
	clot_rate = 0.4
	gauzed_clot_rate = 0.8
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	threshold_minimum = 40
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/slash/moderate
	scar_keyword = "slashmoderate"

/datum/wound/bleed/slash/severe
	name = "Major Laceration"
	desc = "Patient's skin is ripped clean open, allowing significant blood loss."
	treat_text = "Speedy application of first-aid grade sutures and clean bandages, followed by vitals monitoring to ensure recovery."
	examine_desc = "has a severe cut"
	occur_text = "is ripped open, veins spurting blood"
	sound_effect = 'sound/effects/wounds/blood2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 6
	minimum_flow = 3
	max_per_type = 3
	required_bandage_power = 20
	clot_rate = 0.3
	gauzed_clot_rate = 0.9
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.25
	threshold_minimum = 40
	threshold_penalty = 25
	demotes_to = /datum/wound/bleed/slash/moderate
	status_effect_type = /datum/status_effect/wound/slash/severe
	scar_keyword = "slashsevere"

/datum/wound/bleed/slash/critical
	name = "Weeping Avulsion"
	desc = "Patient's skin is completely torn open, along with significant loss of tissue. Extreme blood loss will lead to quick death without intervention."
	treat_text = "Immediate bandaging and either suturing or cauterization, followed by supervised resanguination."
	examine_desc = "is carved down to the bone, spraying blood wildly"
	occur_text = "is torn open, spraying blood wildly"
	sound_effect = 'sound/effects/wounds/blood3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 12
	minimum_flow = 6
	max_per_type = 3
	required_bandage_power = 40
	clot_rate = -0.5
	gauzed_clot_rate = 0.8
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 1.25
	threshold_minimum = 60
	threshold_penalty = 45
	demotes_to = /datum/wound/bleed/slash/severe
	status_effect_type = /datum/status_effect/wound/slash/critical
	scar_keyword = "slashcritical"
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | MANGLES_FLESH)

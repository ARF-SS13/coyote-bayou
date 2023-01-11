/* * * *
 * Cuts
 * * * */

// Template, true values will overwrite this
/datum/wound/bleed/slash
	name = "Minor laceration"
	desc = "Patient's skin has been badly scraped, generating moderate blood loss."
	treat_text = "Treat affected site with bandaging or exposure to extreme cold. In dire cases, brief exposure to vacuum may suffice." // space is cold in ss13, so it's like an ice pack!
	examine_desc = "has a small, circular hole, gently bleeding"
	occur_text = "is cut open, slowly leaking blood"
	sound_effect = 'sound/weapons/slice.ogg'
	wound_type = WOUND_SLASH
	severity = WOUND_SEVERITY_TRIVIAL
	initial_flow = 4
	minimum_flow = 2
	clot_rate = 0.5
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 0.50
	threshold_minimum = 20
	threshold_penalty = 15
	low_blood_threshold = WOUND_BLEED_MODERATE_BLOOD_LOSS_THRESHOLD
	low_blood_multiplier = WOUND_BLEED_MODERATE_BLOOD_LOSS_MULTIPLIER
	promotes_to = /datum/wound/bleed/pierce/moderate
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate"

/datum/wound/bleed/slash/moderate
	name = "Minor Laceration" // Minor. Laceration. Detected.
	desc = "Patient's skin has been badly scraped, generating moderate blood loss."
	treat_text = "Application of clean bandages or first-aid grade sutures, followed by food and rest."
	examine_desc = "has an open cut"
	occur_text = "is cut open, slowly leaking blood"
	sound_effect = 'sound/effects/wounds/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 4
	minimum_flow = 2
	clot_rate = 0.5
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 0.50
	threshold_minimum = 20
	threshold_penalty = 15
	low_blood_threshold = WOUND_BLEED_MODERATE_BLOOD_LOSS_THRESHOLD
	low_blood_multiplier = WOUND_BLEED_MODERATE_BLOOD_LOSS_MULTIPLIER
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
	initial_flow = 8
	minimum_flow = 4
	clot_rate = 0.25
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 0.50
	threshold_minimum = 50
	threshold_penalty = 40
	low_blood_threshold = WOUND_BLEED_SEVERE_BLOOD_LOSS_THRESHOLD
	low_blood_multiplier = WOUND_BLEED_SEVERE_BLOOD_LOSS_MULTIPLIER
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
	initial_flow = 10
	minimum_flow = 8
	clot_rate = 0.25
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 0.50
	threshold_minimum = 80
	threshold_penalty = 60
	low_blood_threshold = WOUND_BLEED_CRITICAL_BLOOD_LOSS_THRESHOLD
	low_blood_multiplier = WOUND_BLEED_CRITICAL_BLOOD_LOSS_MULTIPLIER
	demotes_to = /datum/wound/bleed/slash/severe
	status_effect_type = /datum/status_effect/wound/slash/critical
	scar_keyword = "slashcritical"
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | MANGLES_FLESH | ACCEPTS_SUTURE)

/* * * * *
 * Pierce
 * * * * */

/// template, true values will override these
/datum/wound/bleed/pierce
	name = "Minor Puncture"
	desc = "Patient's skin has been broken open, causing severe bruising and minor internal bleeding in affected area."
	treat_text = "Treat affected site with bandaging or exposure to extreme cold. In dire cases, brief exposure to vacuum may suffice." // space is cold in ss13, so it's like an ice pack!
	examine_desc = "has a small, circular hole, gently bleeding"
	occur_text = "spurts out a thin stream of blood"
	sound_effect = 'sound/weapons/slice.ogg'
	wound_type = WOUND_PIERCE
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

/datum/wound/bleed/pierce/moderate
	name = "Minor Puncture"
	desc = "Patient's skin has been broken open, causing severe bruising and minor internal bleeding in affected area."
	treat_text = "Treat affected site with bandaging or exposure to extreme cold. In dire cases, brief exposure to vacuum may suffice." // space is cold in ss13, so it's like an ice pack!
	examine_desc = "has a small, circular hole, gently bleeding"
	occur_text = "spurts out a thin stream of blood"
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
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
	promotes_to = /datum/wound/bleed/pierce/severe
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate"
	stopped_by_bandage = TRUE

/datum/wound/bleed/pierce/severe
	name = "Open Puncture"
	desc = "Patient's internal tissue is penetrated, causing sizeable internal bleeding and reduced limb stability."
	treat_text = "Repair punctures in skin by suture or cautery, extreme cold may also work."
	examine_desc = "is pierced clear through, with bits of tissue obscuring the open hole"
	occur_text = "looses a violent spray of blood, revealing a pierced wound"
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
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
	demotes_to = /datum/wound/bleed/pierce/moderate
	promotes_to = /datum/wound/bleed/pierce/critical
	status_effect_type = /datum/status_effect/wound/pierce/severe
	scar_keyword = "piercesevere"

/datum/wound/bleed/pierce/critical
	name = "Ruptured Cavity"
	desc = "Patient's internal tissue and circulatory system is shredded, causing significant internal bleeding and damage to internal organs."
	treat_text = "Surgical repair of puncture wound, followed by supervised resanguination."
	examine_desc = "is ripped clear through, barely held together by exposed bone"
	occur_text = "blasts apart, sending chunks of viscera flying in all directions"
	sound_effect = 'sound/effects/wounds/pierce3.ogg'
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
	demotes_to = /datum/wound/bleed/pierce/severe
	status_effect_type = /datum/status_effect/wound/pierce/critical
	scar_keyword = "piercecritical"
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | MANGLES_FLESH | ACCEPTS_SUTURE)

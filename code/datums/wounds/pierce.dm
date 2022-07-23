/* * * * *
 * Pierce
 * * * * */

/datum/wound/bleed/pierce
	sound_effect = 'sound/weapons/slice.ogg'
	wound_type = WOUND_PIERCE

/datum/wound/bleed/pierce/moderate
	name = "Minor Puncture"
	desc = "Patient's skin has been broken open, causing severe bruising and minor internal bleeding in affected area."
	treat_text = "Treat affected site with bandaging or exposure to extreme cold. In dire cases, brief exposure to vacuum may suffice." // space is cold in ss13, so it's like an ice pack!
	examine_desc = "has a small, circular hole, gently bleeding"
	occur_text = "spurts out a thin stream of blood"
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
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
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate"

/datum/wound/bleed/pierce/severe
	name = "Open Puncture"
	desc = "Patient's internal tissue is penetrated, causing sizeable internal bleeding and reduced limb stability."
	treat_text = "Repair punctures in skin by suture or cautery, extreme cold may also work."
	examine_desc = "is pierced clear through, with bits of tissue obscuring the open hole"
	occur_text = "looses a violent spray of blood, revealing a pierced wound"
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
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
	demotes_to = /datum/wound/bleed/pierce/moderate
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
	demotes_to = /datum/wound/bleed/pierce/severe
	status_effect_type = /datum/status_effect/wound/pierce/critical
	scar_keyword = "piercecritical"
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | MANGLES_FLESH)

/datum/mood_event/high
	mood_change = 6
	description = span_nicegreen("Woooow duudeeeeee...I'm tripping baaalls...")

/datum/mood_event/smoked
	description = span_nicegreen("I have had a smoke recently.")
	mood_change = 2
	timeout = 3600

/datum/mood_event/used_drugs //for NCR, BOS, Enclave
	description = span_boldwarning("I'm nothing but a filthy junkie...")
	mood_change = -12
	timeout = 2 MINUTES

/datum/mood_event/betrayed_caesar //for Legion, obviously
	description = span_boldwarning("I have betrayed the will of Caesar and defiled my body!")
	mood_change = -25
	timeout = 5 MINUTES

/datum/mood_event/jet_euphoria
	description = span_nicegreen("I feel like i'm flying...")
	mood_change = 25
	timeout = 15 MINUTES

/datum/mood_event/overdose
	mood_change = -8
	timeout = 3000

/datum/mood_event/overdose/add_effects(drug_name)
	description = span_warning("I think I took a bit too much of that [drug_name]")

/datum/mood_event/withdrawal_light
	mood_change = -2

/datum/mood_event/withdrawal_light/add_effects(drug_name)
	description = span_warning("I could use some [drug_name]")

/datum/mood_event/withdrawal_medium
	mood_change = -5

/datum/mood_event/withdrawal_medium/add_effects(drug_name)
	description = span_warning("I really need [drug_name]")

/datum/mood_event/withdrawal_severe
	mood_change = -8

/datum/mood_event/withdrawal_severe/add_effects(drug_name)
	description = span_boldwarning("Oh god I need some [drug_name]")

/datum/mood_event/withdrawal_critical
	mood_change = -10

/datum/mood_event/withdrawal_critical/add_effects(drug_name)
	description = span_boldwarning("[drug_name]! [drug_name]! [drug_name]!")

/datum/mood_event/happiness_drug
	description = span_nicegreen("I can't feel anything and I never want this to end.")
	mood_change = 10

/datum/mood_event/happiness_drug_good_od
	description = span_nicegreen("YES! YES!! YES!!!")
	mood_change = 20
	timeout = 300
	//special_screen_obj = "mood_happiness_good" Originally in tg, but I personally think they look dumb

/datum/mood_event/nuka
	description = "the whole world loves Cosmic-cola!"
	mood_change = 2

/datum/mood_event/happiness_drug_bad_od
	description = span_boldwarning("NO! NO!! NO!!!")
	mood_change = -20
	timeout = 300
	//special_screen_obj = "mood_happiness_bad" Originally in tg

/datum/mood_event/eigenstate
	mood_change = -3
	description = span_warning("Where the hell am I? Is this an alternative dimension ?")

/datum/mood_event/enthrall
	mood_change = 5

/datum/mood_event/enthrall/add_effects(message)
	description = span_nicegreen("[message]")

/datum/mood_event/enthrallpraise
	mood_change = 10
	timeout = 1 MINUTES

/datum/mood_event/enthrallpraise/add_effects(message)
	description = span_nicegreen("[message]")

/datum/mood_event/enthrallscold
	mood_change = -10
	timeout = 1 MINUTES

/datum/mood_event/enthrallscold/add_effects(message)
	description = span_warning("[message]")//aaa I'm not kinky enough for this

/datum/mood_event/enthrallmissing1
	mood_change = -5

/datum/mood_event/enthrallmissing1/add_effects(message)
	description = span_warning("[message]")

/datum/mood_event/enthrallmissing2
	mood_change = -10

/datum/mood_event/enthrallmissing2/add_effects(message)
	description = span_warning("[message]")

/datum/mood_event/enthrallmissing3
	mood_change = -15

/datum/mood_event/enthrallmissing3/add_effects(message)
	description = span_warning("[message]")

/datum/mood_event/enthrallmissing4
	mood_change = -25

/datum/mood_event/enthrallmissing4/add_effects(message)
	description = span_warning("[message]")

/datum/mood_event/InLove
	mood_change = 10

/datum/mood_event/InLove/add_effects(message)
	description = span_nicegreen("[message]")

/datum/mood_event/MissingLove
	mood_change = -10

/datum/mood_event/MissingLove/add_effects(message)
	description = span_warning("[message]")

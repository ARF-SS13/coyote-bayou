
//Stomach-5A  (Version 4)
//	- Touch Belly 5A1 - giving - no intensity
//	- Rub Belly 5A2 - giving - no intensity
//	- Caress Belly 5A3 - giving - no intensity
//	- Lick Bellybutton 5A4 - giving - low intensity

////////////////////
//Touch Belly 5A1//
//////////////////
/datum/interaction/lewd/partner/giving/touch_belly
	description = "Partner/Stomach - Touch their tummy."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently touches XT_NAME's belly.",
	)
	disarm_messages = list(
		"XU_NAME playfully touches XT_NAME's belly.",
	)
	grab_messages = list(
		"XU_NAME possessively touches XT_NAME's belly.",
	)
	harm_messages = list(
		"XU_NAME squeezes XT_NAME's belly!",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	user_lust_mult = 0.5
	lust_go_to = LUST_TARGET | LUST_USER
///////TOUCH BELLY END/////////


////////////////////
//Touch Belly 5A2//
//////////////////
/datum/interaction/lewd/partner/giving/rub_belly
	description = "Partner/Stomach - Rub their tummy."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently rubs XT_NAME's belly.",
	)
	disarm_messages = list(
		"XU_NAME playfully rubs XT_NAME's belly.",
	)
	grab_messages = list(
		"XU_NAME possessively rubs XT_NAME's belly.",
	)
	harm_messages = list(
		"XU_NAME aggressively rubs XT_NAME's belly!",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET 
///////RUB BELLY END/////////

////////////////////
//Caress Belly 5A3//
//////////////////
/datum/interaction/lewd/partner/giving/caress_belly
	description = "Partner/Stomach - Caress their tummy."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME lightly caresses XT_NAME's belly.",
	)
	disarm_messages = list(
		"XU_NAME lovingly caresses XT_NAME's belly.",
	)
	grab_messages = list(
		"XU_NAME possessively caresses XT_NAME's belly.",
	)
	harm_messages = list(
		"XU_NAME aggressively caresses XT_NAME's belly.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg',  
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET 
///////CARESS BELLY END/////////

////////////////////////
//Lick Bellybutton 5A4//
///////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/lick_bellybutton
	description = "Partner/Stomach - Lick their bellybutton."
	require_user_hands = TRUE
	simple_sounds = null
	max_distance = 1
	/// okay copy from here...
	help_messages = list(
		"XU_NAME lightly licks XT_NAME's bellybutton.",
	)
	disarm_messages = list(
		"XU_NAME playfully licks XT_NAME's bellybutton.",
	)
	grab_messages = list(
		"XU_NAME tongues XU_THEIR XT_NAME's bellybutton.",
	)
	harm_messages = list(
		"XU_NAME is going to town licking XT_NAME's bellybutton.",
	)

	simple_sounds = list(
		'sound/effects/lick.ogg'
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET 
///////LICK BELLYBUTTON END/////////


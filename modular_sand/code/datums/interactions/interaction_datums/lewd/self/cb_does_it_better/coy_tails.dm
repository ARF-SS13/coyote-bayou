
//Tail-9A (Version 3)
//	- Brush Tail 9A1 - giving - low intensity
//	- Pull Tail 9A2 - giving - medium intensity
//	- Bite Tail 9A3 - giving - low intensity


////////////////////
//Brush Tail 9A1///
////////////////////
/datum/interaction/lewd/partner/giving/brush_tail
	description = "Partner/Tail - Brush their tail."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently brushes XT_NAME's tail.",
	)
	disarm_messages = list(
		"XU_NAME softly brushes XT_NAME's tail.",
	)
	grab_messages = list(
		"XU_NAME firmly brushes XT_NAME's tail.",
	)
	harm_messages = list(
		"XU_NAME aggressively brushes XT_NAME's tail.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg',
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////BRUSH TAIL END/////////

////////////////////
//Pull Tail 9A2/////
////////////////////
/datum/interaction/lewd/partner/giving/pull_tail
	description = "Partner/Tail - Pull their tail."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently pulls XT_NAME's tail.",
	)
	disarm_messages = list(
		"XU_NAME softly pulls XT_NAME's tail.",
	)
	grab_messages = list(
		"XU_NAME firmly pulls XT_NAME's tail.",
	)
	harm_messages = list(
		"XU_NAME aggressively pulls XT_NAME's tail.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg',
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////PULL TAIL END/////////

////////////////////
//bites Tail 9A2/////
////////////////////
/datum/interaction/lewd/partner/giving/bite_tail
	description = "Partner/Tail - Bite their tail."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently bites XT_NAME's tail.",
	)
	disarm_messages = list(
		"XU_NAME softly bites XT_NAME's tail.",
	)
	grab_messages = list(
		"XU_NAME firmly bites XT_NAME's tail.",
	)
	harm_messages = list(
		"XU_NAME aggressively bites XT_NAME's tail.",
	)

	simple_sounds = list(
		'sound/weapons/bite.ogg' 
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////BITE TAIL END/////////


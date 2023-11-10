
/*Body-3A  (Version 6)
	- Nipple twist 3A1 - Giving - Light to Medium intensity
	- Nipple bite 3A2 - Giving - Light to Medium intensity
	- Nipple lick 3A3 - Giving - Light to Medium intensity
	- Nipple pull 3A4 - Giving - Medium to High intensity
	- Wrap Legs around partner 3A5 - Mutual - Light to Medium intensity
	- Tail Bap 3A6 - Giving - no intensity
	*/


////////////////////
//Nipple Twist 3A1//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_twist
	description = "Partner/Neck - Twist their nipple."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME gently twists XT_NAME's nipple.",
	)
	disarm_messages = list(
		"XU_NAME playfully twists XT_NAME's nipple.",
	)
	grab_messages = list(
		"XU_NAME really twists XT_NAME's nipple.",
	)
	harm_messages = list(
		"XU_NAME aggressively twists XT_NAME's nipple!",
	)

	simple_sounds = list(
		'sound/weapons/thudswoosh.ogg'
	) // frumf, frumf
	user_lust_mult = 0.3
	lust_go_to = LUST_TARGET


///////////////////
//Nipple Bite 3A2//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_bite
	description = "Partner/Neck - Bite their nipple."
	require_user_hands = TRUE
	help_messages = list(
		"XU_NAME gently bites XT_NAME's nipple.",
	)
	disarm_messages = list(
		"XU_NAME playfully bites XT_NAME's nipple.",
	)
	grab_messages = list(
		"XU_NAME really bites XT_NAME's nipple.",
	)
	harm_messages = list(
		"XU_NAME aggressively bites XT_NAME's nipple!",
	)

	help_sounds = list(
		'sound/weapons/thudswoosh.ogg'
	) // frumf, frumf
	grab_sounds = list(
		'sound/weapons/bite.ogg'
	)
	harm_sounds = list(
		'sound/weapons/bite.ogg' // thought you could get rid of the carp bite, huh
	)
	user_lust_mult = 0.3
	lust_go_to = LUST_TARGET



///////////////////
//Nipple Lick 3A3//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_lick
	description = "Partner/Neck - Lick their nipple."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME gently licks XT_NAME's nipple.",
	)
	disarm_messages = list(
		"XU_NAME playfully licks XT_NAME's nipple.",
	)
	grab_messages = list(
		"XU_NAME really licks XT_NAME's nipple.",
	)
	harm_messages = list(
		"XU_NAME aggressively licks XT_NAME's nipple!",
	)

	simple_sounds = list(
		'sound/effects/lick.ogg'
	) // frumf, frumf
	user_lust_mult = 0.3
	lust_go_to = LUST_USER | LUST_TARGET

///////////////////
//Nipple Pull 3A4//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_pull
	description = "Partner/Neck - Pull their nipple."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME gently pulls XT_NAME's nipple.",
	)
	disarm_messages = list(
		"XU_NAME playfully pulls XT_NAME's nipple.",
	)
	grab_messages = list(
		"XU_NAME really yanks XT_NAME's nipple.",
	)
	harm_messages = list(
		"XU_NAME aggressively yanks XT_NAME's nipple!",
	)

	simple_sounds = list(
		'sound/weapons/thudswoosh.ogg' // grab grab throw
	) // frumf, frumf
	user_lust_mult = 0.3

////////////////
// Leg Wrap 3A5//
////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/leg_wrap
	description = "Partner/Body - Wrap your legs around them."
	max_distance = 1
	help_messages = list(
		"XU_NAME lightly wraps XU_THEIR legs around XT_NAME's waist.", 
	)
	disarm_messages = list(
		"XU_NAME playfully wraps XU_THEIR legs around XT_NAME's waist.", 
	)
	grab_messages = list(
		"XU_NAME really wraps XU_THEIR legs around XT_NAME's waist.", 
	)
	harm_messages = list(
		"XU_NAME tightly wraps XU_THEIR legs around XT_NAME's waist.", 
	)

	simple_sounds = list(
		'sound/effects/rustle1.ogg',
		'sound/effects/rustle2.ogg',
		'sound/effects/rustle3.ogg',
		'sound/effects/rustle4.ogg',
		'sound/effects/rustle5.ogg',
	) // frumf, frumf
	user_lust_mult = 0.3
	lust_go_to = LUST_USER | LUST_TARGET

////////////////////
//Tail Bap 3A6//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/tail_bap
	description = "Partner/Body - Bap them with your tail."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME gently whacks XT_NAME's with XU_THEIR tail.",
	)
	disarm_messages = list(
		"XU_NAME playfully whacks XT_NAME's with XU_THEIR tail.",
	)
	grab_messages = list(
		"XU_NAME really whacks XT_NAME's with XU_THEIR tail.",
	)
	harm_messages = list(
		"XU_NAME aggressively whacks XT_NAME's with XU_THEIR tail.",
	)

	simple_sounds = list(
		'sound/effects/rustle1.ogg',
		'sound/effects/rustle2.ogg',
		'sound/effects/rustle3.ogg',
		'sound/effects/rustle4.ogg',
		'sound/effects/rustle5.ogg',
	) // frumf, frumf
	user_lust_mult = 0

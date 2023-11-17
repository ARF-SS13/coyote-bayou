
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
	description = "Partner/Body - Twist their nipple."
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
	description = "Partner/Body - Bite their nipple."
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
	description = "Partner/Body - Lick their nipple."
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
		'sound/effects/lick.ogg',
		'modular_coyote/sound/lewd/sexslide5.wav',
		'modular_coyote/sound/lewd/sexslide7.wav',
		'modular_coyote/sound/lewd/sexslide8.wav',
		'modular_coyote/sound/lewd/sexslide9.wav',
		'modular_coyote/sound/lewd/sexslide10.wav',
	) // frumf, frumf
	user_lust_mult = 0.3
	lust_go_to = LUST_USER | LUST_TARGET

///////////////////
//Nipple Pull 3A4//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_pull
	description = "Partner/Body - Pull their nipple."
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

////////////////
// Titplay 3A7//
////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/titplay
	description = "Partner/Body - Play with their breasts."
	max_distance = 1
	help_messages = list(
		"XU_NAME gently plays with  XT_NAME's breasts.", 
	)
	disarm_messages = list(
		"XU_NAME playfully fondles XT_NAME's breasts.", 
	)
	grab_messages = list(
		"XU_NAME firmly fondles XT_NAME's breasts.", 
	)
	harm_messages = list(
		"XU_NAME squeezes XT_NAME's breasts.", 
	)

	simple_sounds = list(
		'sound/effects/rustle1.ogg',
		'sound/effects/rustle2.ogg',
		'sound/effects/rustle3.ogg',
		'sound/effects/rustle4.ogg',
		'sound/effects/rustle5.ogg',
	) // frumf, frumf
	user_lust_mult = 0.4
	target_lust_mult = 0.4
	lust_go_to = LUST_USER | LUST_TARGET

////////////////
// Titsqueeze 3A7//
////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/titsqueeze
	description = "Partner/Body - Squeeze their breasts."
	max_distance = 1
	help_messages = list(
		"XU_NAME squeezes XT_NAME's breasts gently.", 
	)
	disarm_messages = list(
		"XU_NAME squishes XT_NAME's breasts.", 
	)
	grab_messages = list(
		"XU_NAME smushes XT_NAME's breasts possessively.", 
	)
	harm_messages = list(
		"XU_NAME downright squashes XT_NAME's breasts.", 
	)

	simple_sounds = list(
		'sound/effects/rustle1.ogg',
		'sound/effects/rustle2.ogg',
		'sound/effects/rustle3.ogg',
		'sound/effects/rustle4.ogg',
		'sound/effects/rustle5.ogg',
	) // frumf, frumf
	user_lust_mult = 0.4
	target_lust_mult = 0.4
	lust_go_to = LUST_USER | LUST_TARGET

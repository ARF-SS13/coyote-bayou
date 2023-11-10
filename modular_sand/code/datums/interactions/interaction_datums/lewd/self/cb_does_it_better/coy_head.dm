
//Head-1A (Version 4)
//	- French Kiss 1A1 - Mutual - Low Intensity
//	- Ear Bite 1A2 - Giving - Low to Medium Intensity 
//	- Lip Nibble 1A3 - Mutual - Low Intensity
//	- Face Nuzzle 1A4 - Mutual - Low Intensity

//////////////////////
//French Kissing 1A1//
//////////////////////
/datum/interaction/lewd/partner/giving/french_kiss
	description = "Partner/Head - French Kiss."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently teases XU_THEIR tongue into XT_NAME's mouth.",
	)
	disarm_messages = list(
		"XU_NAME playfully teases XU_THEIR tongue around inside XT_NAME's mouth.",
	)
	grab_messages = list(
		"XU_NAME is downright trying to bully XT_NAME's tongue in a sloppy french kiss.",
	)
	harm_messages = list(
		"XU_NAME might as well be boxing XT_NAME's uvula they're kissing them so deep!",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.5 // set this to how much lust should be given
	target_lust_mult = 0.5
	lust_go_to = LUST_USER | LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////FRENCH KISS END/////////


////////////////////
//Ear Bite 1A2//
////////////////////
/datum/interaction/lewd/partner/giving/ear_bite
	description = "Partner/Head - Bite their ear."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently nibbles XT_NAME's ear.",
	)
	disarm_messages = list(
		"XU_NAME playfully bites XT_NAME's ear.",
	)
	grab_messages = list(
		"XU_NAME bites into XT_NAME's ear!",
	)
	harm_messages = list(
		"XU_NAME really bites down hard onto XT_NAME's ear! Ow!",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	target_lust_mult = 0.8
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////EAR BITE END/////////

////////////////
//Lip Bite 1A3//
////////////////
/datum/interaction/lewd/partner/giving/lip_bite
	description = "Partner/Head - Bite their lower lip."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently nibbles XT_NAME's lower lip.",
	)
	disarm_messages = list(
		"XU_NAME playfully uses XU_THEIR teeth to bite on XT_NAME's lower lip.",
	)
	grab_messages = list(
		"XU_NAME bites down possessively on T's lower lip!",
	)
	harm_messages = list(
		"XU_NAME sinks their teeth into XT_NAME's lower lip hard!",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	target_lust_mult = 0.8
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////LIP BITE END/////////


///////////////////
//Face Nuzzle 1A4//
///////////////////
/datum/interaction/lewd/partner/giving/face_nuzzle
	description = "Partner/Head - Nuzzle their face."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently nuzzles XU_THEIR face against XU_NAME's face.",
	)
	disarm_messages = list(
		"XU_NAME playfully nuzzles XU_THEIR face against XU_NAME's face.",
	)
	grab_messages = list(
		"XU_NAME possessibely nuzzles XU_THEIR face against XU_NAME's face.",
	)
	harm_messages = list(
		"XU_NAME aggressively nuzzles XU_THEIR face against XU_NAME's face!",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.5 // set this to how much lust should be given
	target_lust_mult = 0.5
	lust_go_to = LUST_USER | LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////FACE NUZZLE END/////////

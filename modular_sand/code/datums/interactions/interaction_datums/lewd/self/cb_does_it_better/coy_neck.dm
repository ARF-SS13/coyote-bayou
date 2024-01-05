

//Neck-2A  (Version 4)
//	- Neck Bite 2A1 - Giving - Medium intensity
//	- Throat Grab 2A2 - Mutual - Medium-High intensity
//	- Neck Touch 2A3 - Giving - Low intensity
//	- Neck Sniff 2A4 - Mutual - Low intensity


////////////////////
//Neck Bite 2A2//
////////////////////
/datum/interaction/lewd/partner/giving/neck_bite
	description = "Partner/Neck - Bite their neck."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently nibbles XT_NAME's neck.",
	)
	disarm_messages = list(
		"XU_NAME playfully bites XT_NAME's neck.",
	)
	grab_messages = list(
		"XU_NAME bites into XT_NAME's neck!",
	)
	harm_messages = list(
		"XU_NAME really bites down hard onto XT_NAME's neck! Ow!",
	)

	simple_sounds = list(
		'sound/weapons/bite.ogg' 
	) // frumf, frumf
	target_lust_mult = 1.0
	lust_go_to = LUST_TARGET
///////NECK BITE END/////////


///////////////////
//Throat Grab 2A2//
///////////////////
/datum/interaction/lewd/partner/giving/throat_grab
	description = "Partner/Neck - Grab their throat."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently wraps XU_THEIR fingers around XT_NAME's throat.",
	)
	disarm_messages = list(
		"XU_NAME wraps XU_THEIR fingers around XT_NAME's throat.",
	)
	grab_messages = list(
		"XU_NAME tightly XU_THEIR fingers around XT_NAME's throat.",
	)
	harm_messages = list(
		"XU_NAME is just about choking out XT_NAME's by squeezing XU_THEIR throat!",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg',
	) // frumf, frumf
	target_lust_mult = 1.0
	lust_go_to = LUST_TARGET
///////THROAT GRAB END/////////

////////////////////
//Neck Touch 2A3//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/neck_touch
	description = "Partner/Neck - Touch their Neck."
	require_user_hands = TRUE
	simple_sounds = null
	max_distance = 1
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently touches XT_NAME's neck.",
	)
	disarm_messages = list(
		"XU_NAME playfully touches XT_NAME's neck.",
	)
	grab_messages = list(
		"XU_NAME clasps a hand onto XT_NAME's neck!",
	)
	harm_messages = list(
		"XU_NAME really grabs a hold of XT_NAME's neck!",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////NECK TOUCH END/////////


///////////////////
//Neck Sniff 2A4//
///////////////////
/datum/interaction/lewd/partner/giving/neck_sniff
	description = "Partner/Neck - Sniff their neck."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME hesitantly sniffs at XT_NAME's neck.", 
	)
	disarm_messages = list(
		"XU_NAME playfully sniffs at XT_NAME's neck.",
	)
	grab_messages = list(
		"XU_NAME really sniffs at XT_NAME's neck.",
	)
	harm_messages = list(
		"XU_NAME really sniffs at XT_NAME's neck.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	user_lust_mult = 0.5
	lust_go_to = LUST_TARGET | LUST_USER
///////THROAT GRAB END/////////

////////////////////
//Neck Kiss 2A5//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/neck_kiss
	description = "Partner/Neck - Kiss their Neck."
	require_user_hands = TRUE
	simple_sounds = null
	max_distance = 1
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently {kisses, nibbles, smooches, mouths} on the XT_NAME's neck.",
	)
	disarm_messages = list(
		"XU_NAME playfully {kisses, nibbles, smooches, mouths} on the XT_NAME's neck.",
	)
	grab_messages = list(
		"XU_NAME just adores XT_NAME's neck, covering it in {kisses, nibbles, smooches}!",
	)
	harm_messages = list(
		"XU_NAME is kissing XT_NAME's neck s much they might leave a hickey!",
	)

	simple_sounds = list(
		'sound/effects/kiss.ogg'
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET


//Crotch-6A  (Version 5)
//	- Sniff crotch 6A1 - recieving - low intensity
//	- Grab Balls 6A2 - giving - low-medium intensity
//	- Shake Pussy 6A3 - giving - medium to high intenisty
//	- Tease Pussy With Cock 6A4 - mutual - low intensity
//	- Tease Cock With Pussy 6A5 - mutual - low intensity
//	- Spank Ass 6A6 - giving - low to medium intensity

//////////////////////
//Sniff Crotch 6A1////
//////////////////////

//Remember to change this                 VVVV
/datum/interaction/lewd/partner/recieving/sniff_crotch
	description = "Partner/Crotch - Sniff their crotch."
	max_distance = 1
	/// okay copy from here...
	help_messages = list(
		"XU_NAME lightly sniffs at XT_NAME's crotch.", // in place of this line
	)
	disarm_messages = list(
		"XU_NAME playfully sniffs at XT_NAME's crotch.",
	)
	grab_messages = list(
		"XU_NAME possessively sniffs at XT_NAME's crotch.",
	)
	harm_messages = list(
		"XU_NAME aggressively sniffs at XT_NAME's crotch.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	) // frumf, frumf
	user_lust_mult = 0.5
	lust_go_to = LUST_USER
	// ...to here, this will be where to paste in the interaction stuff // yeah


////////////////////
//Wrist Grab 4A3//
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/grab_balls
	description = "Partner/Crotch - Grab their balls."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently grabs XT_NAME by the balls."
	)
	disarm_messages = list(
		"XU_NAME playfully grabs XT_NAME by the balls.", 
	)
	grab_messages = list(
		"XU_NAME roughly grabs XT_NAME by the balls.",
	)
	harm_messages = list(
		"XU_NAME aggresively grabs XT_NAME by the balls."
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.5 // set this to how much lust should be given
	lust_go_to = LUST_USER // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
	// ...to here, this will be where to paste in the interaction stuff // and, that's it // all of it
	// oh, uh, problem, we copied the grab text t the sniff interaction, lemme fix that // there we go //yeah, its very easy, but
	/// it needs some clever find-replacing yeah! // yup
///////BALL GRAB END/////////

//////////////////// // yeah
//Shake Pussy 6A3///
////////////////////
/datum/interaction/lewd/partner/giving/shake_pussy
	description = "Partner/Crotch - Shake their pussy."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently grabs XT_NAME's pussy, shaking it lightly with XU_THEIR own finger inside.",
	)
	disarm_messages = list(
		"XU_NAME playfully grabs XT_NAME's pussy, shaking it playfully with XU_THEIR own finger inside.",
	)
	grab_messages = list(
		"XU_NAME possessively grabs XT_NAME's pussy, shaking it possessively with XU_THEIR own finger inside.",
	)
	harm_messages = list(
		"XU_NAME aggressively grabs XT_NAME's pussy, shaking it aggressively with XU_THEIR own finger inside.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.5 // set this to how much lust should be given
	lust_go_to = LUST_USER // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////SHAKE PUSSY END/////////

/////////////////////////
// Cocktease Pussy 4A2//
///////////////////////
/datum/interaction/lewd/partner/giving/cocktease_pussy
	description = "Partner/Crotch - Cocktease their pussy."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME teases XU_THEIR cockhead at XT_NAME's lower lips.",
	)
	disarm_messages = list(
		"XU_NAME rubs XU_THEIR cockhead at XT_NAME's lower lips.",
	)
	grab_messages = list(
		"XU_NAME slightly penetrates XU_THEIR cockhead at XT_NAME's lower lips.",
	)
	harm_messages = list(
		"XU_NAME stirs XU_THEIR cockhead just inside XT_NAME's lower lips.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.4 // set this to how much lust should be given
	target_lust_mult = 1.2
	lust_go_to = LUST_USER | LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////COCKTEASE PUSSY END/////////

/////////////////////////
// Pussytease Cock 6A5//
///////////////////////
/datum/interaction/lewd/partner/giving/pussytease_cock
	description = "Partner/Crotch - Pussytease their cock."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME teases XT_NAME's cockhead with XU_THEIR lower lips.",
	)
	disarm_messages = list(
		"XU_NAME rubs XT_NAME's cockhead with XU_THEIR lower lips.",
	)
	grab_messages = list(
		"XU_NAME lets XT_NAME's cockhead barely slide into XU_THEIR lower lips.",
	)
	harm_messages = list(
		"XU_NAME lets XT_NAME's cockhead stir just inside XU_THEIR lower lips.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.4 // set this to how much lust should be given
	target_lust_mult = 1.2
	lust_go_to = LUST_USER | LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////PUSSYTEASE COCK END/////////


////////////////////
//Spank Ass 6A6///
////////////////////
/datum/interaction/lewd/partner/giving/spank_ass
	description = "Partner/Crotch - Spank their ass."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently spanks XT_NAME's butt, shaking it lightly with XU_THEIR blows.",
	)
	disarm_messages = list(
		"XU_NAME playfully spanks XT_NAME's butt, shaking it lightly with XU_THEIR blows.",
	)
	grab_messages = list(
		"XU_NAME aggressively spanks XT_NAME's butt, shaking it lightly with XU_THEIR blows.",
	)
	harm_messages = list(
		"XU_NAME violently spanks XT_NAME's butt, shaking it lightly with XU_THEIR blows.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.4 // set this to how much lust should be given
	target_lust_mult = 0.8
	lust_go_to = LUST_USER | LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////SPANK ASS END/////////


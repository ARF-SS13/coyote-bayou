

//Legs-8A  (Version 4)
//	- Caress Leg 8A1 - giving - low to medium intensity
//	- Footsie 8A2 - mutual - low intensity
//	- Squeeze Leg 8A3 - giving - low to medium intensity
//	- Spread Legs 8A4 - mutual - medium to high intensity

////////////////////
//caress Leg 8A1///
////////////////////
/datum/interaction/lewd/partner/giving/caress_leg
	description = "Partner/Legs - Caress their leg."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently caresses one of XT_NAME's legs.",
	)
	disarm_messages = list(
		"XU_NAME softly caresses one of XT_NAME's legs.",
	)
	grab_messages = list(
		"XU_NAME firmly caresses one of XT_NAME's legs.",
	)
	harm_messages = list(
		"XU_NAME needily caresses one of XT_NAME's legs.",
	)

	simple_sounds = list(
		'sound/weapons/thudswoosh.ogg'
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////CARESS LEG END/////////


/////////////////////////
// Footsie 8A2////////
///////////////////////
/datum/interaction/lewd/partner/giving/play_footsie
	description = "Partner/Legs - Play footsie with them."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently rubs XU_THEIR foot one of XT_NAME's feet.",
	)
	disarm_messages = list(
		"XU_NAME playfully rubs XU_THEIR foot one of XT_NAME's feet.",
	)
	grab_messages = list(
		"XU_NAME possessively rubs XU_THEIR foot one of XT_NAME's feet.",
	)
	harm_messages = list(
		"XU_NAME aggressively rubs XU_THEIR foot one of XT_NAME's feet.",
	)

	simple_sounds = list(
		'sound/weapons/thudswoosh.ogg'
	) // frumf, frumf
	target_lust_mult = 0.3
	user_lust_mult = 0.3
	lust_go_to = LUST_TARGET | LUST_USER 
///////FOOTSIE END/////////


////////////////////
//Squeeze Leg 8A3///
////////////////////
/datum/interaction/lewd/partner/giving/squeeze_leg
	description = "Partner/Legs - Squeeze their leg."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently squeezes one of XT_NAME's legs.",
	)
	disarm_messages = list(
		"XU_NAME softly squeezes one of XT_NAME's legs.",
	)
	grab_messages = list(
		"XU_NAME firmly squeezes one of XT_NAME's legs.",
	)
	harm_messages = list(
		"XU_NAME needily squeezes one of XT_NAME's legs.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET 
///////SQUEEZE LEG END/////////

/////////////////////////
// Spread Legs 8A4////////
///////////////////////
/datum/interaction/lewd/partner/giving/spread_legs
	description = "Partner/Legs - Spread their legs."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently spreads XT_NAME's legs, gaining access to their lap.",
	)
	disarm_messages = list(
		"XU_NAME playfully spreads XT_NAME's legs, gaining access to their lap.",
	)
	grab_messages = list(
		"XU_NAME firmly spreads XT_NAME's legs, gaining access to their lap.",
	)
	harm_messages = list(
		"XU_NAME aggressively spreads XT_NAME's legs, gaining access to their lap.",
	)

	simple_sounds = list(
		'sound/weapons/thudswoosh.ogg'
	) // frumf, frumf
	target_lust_mult = 1.0
	lust_go_to = LUST_TARGET 
///////SPREAD LEGS END/////////



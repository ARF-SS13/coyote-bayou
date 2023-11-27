

//Thighs-7A  (Version 5)
//	- Fuck Thighs 7A1 - recieving - medium to high intensity
//	- Lick Thighs 7A2 - giving - low intensity
//	- Grab Thighs 7A3 - giving - low to medium intensity
//	- Bite Thigh 7A4 - giving - low to medium intensity
//	- Lay Head on Thighs 7A5 - mutual - no intensity

//////////////////////
//Fuck Thighs 7A1////
//////////////////////
/datum/interaction/lewd/partner/giving/hump_thigh
	description = "Partner/Thighs - Hump their thighs."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME lightly humps XT_NAME's thighs.", 
	)
	disarm_messages = list(
		"XU_NAME playfully humps XT_NAME's thighs.",
	)
	grab_messages = list(
		"XU_NAME needily humps XT_NAME's thighs.",
	)
	harm_messages = list(
		"XU_NAME aggressively humps XT_NAME's thighs.",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////FUCK THIGH END/////////

////////////////////
//Lick Thigh 7A2///
////////////////////
/datum/interaction/lewd/partner/giving/lick_thigh
	description = "Partner/Thighs - Lick their thighs."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently licks XT_NAME's thighs.", 
	)
	disarm_messages = list(
		"XU_NAME playfully licks XT_NAME's thighs.",
	)
	grab_messages = list(
		"XU_NAME possessively licks XT_NAME's thighs.",
	)
	harm_messages = list(
		"XU_NAME aggressively licks XT_NAME's thighs.",
	)

	simple_sounds = list(
		'sound/effects/lick.ogg' 
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////LICK THIGH END/////////

////////////////////
//Grab Thigh 7A3///
////////////////////
/datum/interaction/lewd/partner/giving/grab_thigh
	description = "Partner/Thighs - Grab their thighs."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently grabs one of XT_NAME's thighs.",
	)
	disarm_messages = list(
		"XU_NAME playfully grabs one of XT_NAME's thighs.",
	)
	grab_messages = list(
		"XU_NAME possessively grabs one of XT_NAME's thighs.",
	)
	harm_messages = list(
		"XU_NAME aggressively grabs one of XT_NAME's thighs.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg',  
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////GRAB THIGH END/////////

/////////////////////////
// Bite Thigh 7A4////////
///////////////////////
/datum/interaction/lewd/partner/giving/bite_thigh
	description = "Partner/Thighs - Bite their thighs."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently bites one of XT_NAME's thighs.",
	)
	disarm_messages = list(
		"XU_NAME gently bites one of XT_NAME's thighs.",
	)
	grab_messages = list(
		"XU_NAME gently bites one of XT_NAME's thighs.",
	)
	harm_messages = list(
		"XU_NAME gently bites one of XT_NAME's thighs.",
	)

	simple_sounds = list(
		'sound/weapons/bite.ogg'
	) // frumf, frumf
	target_lust_mult = 0.5
	user_lust_mult = 0.5
	lust_go_to = LUST_TARGET | LUST_USER
///////BITE THIGH END/////////

/////////////////////////
// Rest Thigh 7A5////////
///////////////////////
/datum/interaction/lewd/partner/giving/rest_thigh
	description = "Partner/Thighs - Rest your head on their thighs."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently rests XU_THEIR head one of XT_NAME's thighs.",
	)
	disarm_messages = list(
		"XU_NAME comfortably rests XU_THEIR head one of XT_NAME's thighs.",
	)
	grab_messages = list(
		"XU_NAME tiredly rests XU_THEIR head one of XT_NAME's thighs.",
	)
	harm_messages = list(
		"XU_NAME flops XU_THEIR head one of XT_NAME's thighs.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	lust_go_to = LUST_TARGET
///////BITE THIGH END/////////

/////////////////////////
// Fuck Thigh 7A4////////
///////////////////////
/datum/interaction/lewd/partner/giving/fuck_thigh
	description = "Partner/Thighs - Fuck their thighs."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME {gently, eagerly} {humps, fucks, grinds on} XT_NAME's thighs.",
	)
	disarm_messages = list(
		"XU_NAME {playfully, needily} {humps, fucks, grinds on} XT_NAME's thighs.",
	)
	grab_messages = list(
		"XU_NAME {possessively, happily} {humps, fucks, grinds on} XT_NAME's thighs.",
	)
	harm_messages = list(
		"XU_NAME {aggressively, hotly} {humps, fucks, grinds on} XT_NAME's thighs.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/hug.ogg', 
	) // frumf, frumf
	target_lust_mult = 0.5
	user_lust_mult = 0.7
	lust_go_to = LUST_TARGET | LUST_USER

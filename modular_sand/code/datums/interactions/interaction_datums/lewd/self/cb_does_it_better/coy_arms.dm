//datum storage lmao
/datum/interaction/lewd/partner
	description = "PLSNOINIT"

/datum/interaction/lewd/partner/giving
	description = "PLSNOINIT"


/datum/interaction/lewd/partner/recieving
	description = "PLSNOINIT"

/datum/interaction/lewd/partner/mutual
		description = "PLSNOINIT"



//Arms-4A  (Version 4)
//	- Shoulder rub 4B1 - giving - no intensity
//	- Fingerplay 4B2 - mutual - no intensity
//	- Wrist Grab 4B3 - giving - low intensity
//	- Finger Suck 4B4 - giving - low intensity
// 	- Lick Finger 4B5 - giving - low intensity

////////////////////
//Shoulder Rub 4A1//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/shoulder_rub
	description = "Partner/Arms - Rub their shoulders."
	require_user_hands = TRUE
	max_distance = 1
	int_sound_vol = 30
	help_messages = list(
		"XU_NAME gently rubs XT_NAME's shoulders",
		"XU_NAME rubs XT_NAME's shoulders gently",
		"XU_NAME puts XT_THEIR hands on XT_NAME's shoulders and rubs softly",
		"XU_NAME softly rubs at XT_NAME's shoulder blades, trying to slowly ease some tension out"
	)
	disarm_messages = list(
		"XU_NAME tenderly rubs XT_NAME's shoulders",
		"XU_NAME rubs XT_NAME's shoulders to help relax them",
		"XU_NAME puts XT_THEIR hands on XT_NAME's shoulder blades and rubs generously",
		"XU_NAME rubs at XT_NAME's shoulder blades, trying to slowly ease some tension out"
	)
	grab_messages = list(
		"XU_NAME really gets in their rubbing XT_NAME's shoulders",
		"XU_NAME rubs XT_NAME's shoulders vigorously to help relax them",
		"XU_NAME puts XT_THEIR hands on XT_NAME's shoulder blades and rubs with some real force",
		"XU_NAME rubs at XT_NAME's shoulder blades, trying to smush some tension out"
	)
	harm_messages = list(
		"XU_NAME is downright beating the tension out of XT_NAME's shoulders",
		"XU_NAME rubs XT_NAME's shoulders in much the same way a rolling pin 'rubs' dough",
		"XU_NAME puts XT_THEIR hands on XT_NAME's shoulder blades like they're trying to get the demons out",
		"XU_NAME rubs at XT_NAME's shoulder blades like an asphalt roller"
	)

	simple_sounds = list(
		'sound/weapons/thudswoosh.ogg'
	) // frumf, frumf
	user_lust_mult = 0


/////////////////////
// Finger Play 4A2//
///////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/finger_play
	description = "Partner/Arms - Play with their fingers."
	max_distance = 1
	int_sound_vol = 30
	help_messages = list(
		"XU_NAME gently plays with XT_NAME's fingers.",
		"XU_NAME intertwines XU_THEIR fingers into XT_NAME's",
		"XU_NAME softly holds XT_NAME's hand, playing with the digits as they do",
		"XU_NAME is teasing at XT_NAME's fingers"
	)
	disarm_messages = list(
		"XU_NAME toys with XT_NAME's fingers playfully.",
		"XU_NAME intertwines XU_THEIR fingers into XT_NAME's, teasing at their digits as they do so",
		"XU_NAME holds XT_NAME's hand, playing mischeviously with the digits as they do",
		"XU_NAME is teasing at XT_NAME's fingers and playing a bit hard to get"
	)
	grab_messages = list(
		"XU_NAME toys with XT_NAME's fingers playfully.",
		"XU_NAME intertwines XU_THEIR fingers into XT_NAME's, teasing at their digits as they do so",
		"XU_NAME holds XT_NAME's hand, playing mischeviously with the digits as they do",
		"XU_NAME is teasing at XT_NAME's fingers and playing a bit hard to get"
	)
	harm_messages = list(
		"XU_NAME aggressively toys with XT_NAME's fingers playfully. Kind of like a finger-chihuahua",
		"XU_NAME grips XU_THEIR fingers into XT_NAME's hand awkwardly on purpose to mess with them",
		"XU_NAME holds XT_NAME's hand",
		"XU_NAME is teasing at XT_NAME's fingers and playing very hard to get"
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/champ_fingering.ogg',
	) // frumf, frumf
	user_lust_mult = 0.8
	target_lust_mult = 1.2


////////////////////
//Wrist Grab 4A3//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/wrist_grab
	description = "Partner/Arms - Grab their wrists."
	require_user_hands = TRUE
	max_distance = 1
	int_sound_vol = 30
	help_messages = list(
		"XU_NAME gently takes XT_NAME's wrists with XU_THEIR hands",
		"XU_NAME carefully takes XT_NAME's, holding them lightly",
		"XU_NAME holds XT_NAME's by the wrists, barely restraining them",
		"XU_NAME grips XT_NAME's wrists softly"
	)
	disarm_messages = list(
		"XU_NAME playfully takes XT_NAME's wrists with XU_THEIR hands",
		"XU_NAME takes XT_NAME's wrists and holding them in place",
		"XU_NAME holds XT_NAME's by the wrists, mostly restraining them",
		"XU_NAME grips XT_NAME's wrists"
	)
	grab_messages = list(
		"XU_NAME grabs XT_NAME's by wrists with XU_THEIR hands",
		"XU_NAME grips XT_NAME's wrists and holding them in place",
		"XU_NAME snatches XT_NAME's by the wrists, probably restraining them",
		"XU_NAME locks their grip XT_NAME's wrists" // It goes, it goes, it goes, it goes, guillotine
	)
	harm_messages = list(
		"XU_NAME roughly grabs XT_NAME's by wrists with XU_THEIR hands",
		"XU_NAME roughly grips XT_NAME's wrists and holding them in place",
		"XU_NAME snatches XT_NAME's by the wrists, almost certainly restraining them",
		"XU_NAME locks down their grip XT_NAME's wrists"
	)

	simple_sounds = list(
		'sound/weapons/thudswoosh.ogg'
	) // frumf, frumf
	user_lust_mult = 0




////////////////////
//Finger Suck 4A4//
//////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/finger_suck
	description = "Partner/Arms - Suck their fingers."
	require_user_hands = TRUE
	max_distance = 1
	int_sound_vol = 30
	help_messages = list(
		"XU_NAME gently suckles on XT_NAME's fingers.",
		"XU_NAME suckles softly on XT_NAME's fingies",
		"XU_NAME teasingly suckles on XT_NAME's digits",
		"XU_NAME teases XT_NAME's fingers with XU_THEIR mouth"
	)
	disarm_messages = list(
		"XU_NAME playfully suckles on XT_NAME's fingers.",
		"XU_NAME softly sucks on XT_NAME's fingies",
		"XU_NAME puts XT_NAME's fingers in XU_THEIR mouth, suckling them like a tease",
		"XU_NAME teases XT_NAME's by sticking XT_THEIR fingers into XU_THEIR mouth"
	)
	grab_messages = list(
		"XU_NAME really suckles on XT_NAME's fingers.",
		"XU_NAME is really giving XT_NAME's fingers the old suck",
		"XU_NAME drags XU_THEIR tongue around on XT_NAME's fingers: suggestive",
		"XU_NAME sucks on XT_NAME's fingers like a lollipop"
	)
	harm_messages = list(
		"XU_NAME aggressively suckles on XT_NAME's fingers.",
		"XU_NAME is downright giving XT_NAME finger felatio",
		"XU_NAME might as well be going down on XT_NAME's fingers",
		"XU_NAME sure is going to town on XT_NAME's fingers, wew"
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/bj2.ogg',
		'modular_sand/sound/interactions/bj6.ogg',
		'modular_sand/sound/interactions/bj7.ogg',
		'modular_sand/sound/interactions/bj8.ogg',
		'modular_sand/sound/interactions/bj9.ogg',
		'modular_coyote/sound/lewd/sexslide5.wav',
		'modular_coyote/sound/lewd/sexslide7.wav',
		'modular_coyote/sound/lewd/sexslide8.wav',
		'modular_coyote/sound/lewd/sexslide9.wav',
		'modular_coyote/sound/lewd/sexslide10.wav',
	) // frumf, frumf
	user_lust_mult = 0.3
	lust_go_to = LUST_USER | LUST_TARGET

////////////////////
//Finger Lick 4A5//
//////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/finger_lick
	description = "Partner/Arms - Lick their fingers."
	require_user_hands = TRUE
	max_distance = 1
	int_sound_vol = 30
	help_messages = list(
		"XU_NAME gently mlems on one of XT_NAME's fingers.",
		"XU_NAME softly licks on one of XT_NAME's fingies",
		"XU_NAME teasingly blems one of XT_NAME's digits",
		"XU_NAME teases XT_NAME's fingers with XU_THEIR mouth"
	)
	disarm_messages = list(
		"XU_NAME playfully laps at one of XT_NAME's fingers.",
		"XU_NAME teasingly licks on XT_NAME's fingies",
		"XU_NAME puts XT_NAME's fingers against XU_THEIR tongue",
		"XU_NAME teases XT_NAME's by dragging XU_THEIR tongue across XT_THEIR finger"
	)
	grab_messages = list(
		"XU_NAME really just licks all up on XT_NAME's fingers.",
		"XU_NAME is really giving XT_NAME's fingers a cleaning with their tongue",
		"XU_NAME drags XU_THEIR tongue around on XT_NAME's fingers wetly",
		"XU_NAME leaves a bit of drool on XT_NAME's fingers as they lick it like a lollipop"
	)
	harm_messages = list(
		"XU_NAME is drawing little circles around XT_NAME's finger with thier tongue.",
		"XU_NAME is downright giving XT_NAME finger felatio with just their tongue",
		"XU_NAME might as well be trying to figure out how many licks it takes to get to the center of XT_NAME's fingers",
		"XU_NAME sure is going to town on XT_NAME's fingers with their licker"
	)

	simple_sounds = list(
		'sound/effects/lick.ogg'
	) // frumf, frumf
	user_lust_mult = 0.3
	lust_go_to = LUST_USER | LUST_TARGET

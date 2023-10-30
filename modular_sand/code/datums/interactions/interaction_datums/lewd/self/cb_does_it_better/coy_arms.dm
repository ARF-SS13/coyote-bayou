//datum storage lmao
/datum/interaction/lewd/partner
	description = ""

/datum/interaction/lewd/partner/giving
	description = ""


/datum/interaction/lewd/partner/recieving
	description = ""

/datum/interaction/lewd/partner/mutual/
		description = ""



//Arms-4A  (Version 4)
//	- Shoulder rub 4B1 - giving - no intensity
//	- Fingerplay 4B2 - mutual - no intensity
//	- Wrist Grab 4B3 - giving - low intensity
//	- Finger Suck 4B4 - giving - low intensity

////////////////////
//Shoulder Rub 4A1//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/shoulder_rub
	description = "Partner/Arms - Rub their shoulders."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/shoulder_rub/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/t_them = user.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/t_have = user.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/t_are = user.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/t_were = user.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/t_do = user.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'
	
	//A big example of this combined together follows.
	// "[t_they] [t_have] [t_their] work cut out for [t_them]."
	// This can print out as, "He has his work cut out for him." // Or // "She has her work cut out for her." // Or // "They have their work cut out for them."
	//It does require a bit of forethought, but there you have it.
	var/message

	//Message block A
	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP)	//The USER of the verbs intent, only the pitcher gets to determine how hard they throw.
		var/list/lewd = list(
			"gently rubs <b>[partner]'s</b> shoulders",
			"rubs <b>[partner]'s</b> shoulders gently",
			"puts [t_their] hands on <b>[partner]'s</b> shoulders and rubs softly",
			"softly rubs at <b>[partner]'s</b> shoulder blades, trying to slowly ease some tension out"
		)
		message = pick(lewd)


			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		var/list/lewd = list(
			"tenderly rubs <b>[partner]'s</b> shoulders",
			"rubs <b>[partner]'s</b> shoulders to help relax them",
			"puts [t_their] hands on <b>[partner]'s</b> shoulder blades and rubs generously",
			"rubs at <b>[partner]'s</b> shoulder blades, trying to slowly ease some tension out"
		)
		message = pick(lewd)
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		var/list/lewd = list(
			"really gets in their rubbing <b>[partner]'s</b> shoulders",
			"rubs <b>[partner]'s</b> shoulders vigorously to help relax them",
			"puts [t_their] hands on <b>[partner]'s</b> shoulder blades and rubs with some real force",
			"rubs at <b>[partner]'s</b> shoulder blades, trying to smush some tension out"
		)
		message = pick(lewd)

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		var/list/lewd = list(
			"is downright beating the tension out of <b>[partner]'s</b> shoulders",
			"rubs <b>[partner]'s</b> shoulders in much the same way a rolling pin 'rubs' dough",
			"puts [t_their] hands on <b>[partner]'s</b> shoulder blades like they're trying to get the demons out",
			"rubs at <b>[partner]'s</b> shoulder blades like an asphalt roller"
		)
		message = pick(lewd)

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 30, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////SHOULDER RUB END/////////


/////////////////////
// Finger Play 4A2//
///////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/finger_play
	description = "Partner/Arms - Play with their fingers."
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/finger_play/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/t_them = user.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/t_have = user.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/t_are = user.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/t_were = user.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/t_do = user.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'
	

		//To uncomment these vars just remove the first / on the far left!
	//var/p_they = partner.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/p_their = partner.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/p_them = partner.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/p_have = partner.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/p_are = partner.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/p_were = partner.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/p_do = partner.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'


	//A big example of this combined together follows.
	// "[t_they] [t_have] [t_their] work cut out for [t_them]."
	// This can print out as, "He has his work cut out for him." // Or // "She has her work cut out for her." // Or // "They have their work cut out for them."
	//It does require a bit of forethought, but there you have it.
	var/message
	//Message block A
	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP)	//The USER of the verbs intent, only the pitcher gets to determine how hard they throw.
		var/list/lewd = list(
			"gently plays with <b>[partner]'s</b> fingers.",
			"intertwines [p_their] fingers into <b>[partner]'s</b>",
			"softly holds <b>[partner]'s</b> hand, playing with the digits as they do",
			"is teasing at <b>[partner]'s</b> fingers"
		)
		message = pick(lewd)

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		var/list/lewd = list(
			"toys with <b>[partner]'s</b> fingers playfully.",
			"intertwines [p_their] fingers into <b>[partner]'s</b>, teasing at their digits as they do so",
			"holds <b>[partner]'s</b> hand, playing mischeviously with the digits as they do",
			"is teasing at <b>[partner]'s</b> fingers and playing a bit hard to get"
		)
		message = pick(lewd)
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		var/list/lewd = list(
			"toys with <b>[partner]'s</b> fingers playfully.",
			"intertwines [p_their] fingers into <b>[partner]'s</b>, teasing at their digits as they do so",
			"holds <b>[partner]'s</b> hand, playing mischeviously with the digits as they do",
			"is teasing at <b>[partner]'s</b> fingers and playing a bit hard to get"
		)
		message = pick(lewd)

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		var/list/lewd = list(
			"aggressively toys with <b>[partner]'s</b> fingers playfully. Kind of like a finger-chihuahua",
			"grips [p_their] fingers into <b>[partner]'s</b> hand awkwardly on purpose to mess with them",
			"holds <b>[partner]'s</b> hand",
			"is teasing at <b>[partner]'s</b> fingers and playing very hard to get"
		)
		message = pick(lewd)

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 30, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0)
	user.handle_post_sex(lust_amt[user.a_intent]*0)
///////FINGER PLAY END/////////

////////////////////
//Wrist Grab 4A3//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/wrist_grab
	description = "Partner/Arms - Grab their wrists."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/wrist_grab/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/t_them = user.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/t_have = user.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/t_are = user.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/t_were = user.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/t_do = user.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'
	
	//A big example of this combined together follows.
	// "[t_they] [t_have] [t_their] work cut out for [t_them]."
	// This can print out as, "He has his work cut out for him." // Or // "She has her work cut out for her." // Or // "They have their work cut out for them."
	//It does require a bit of forethought, but there you have it.
	var/message

	//Message block A
	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP)	//The USER of the verbs intent, only the pitcher gets to determine how hard they throw.
		var/list/lewd = list(
			"gently takes <b>[partner]'s</b> wrists with [t_their] hands",
			"carefully takes <b>[partner]'s</b>, holding them lightly",
			"holds <b>[partner]'s</b> by the wrists, barely restraining them",
			"grips <b>[partner]'s</b> wrists softly"
		)
		message = pick(lewd)

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		var/list/lewd = list(
			"playfully takes <b>[partner]'s</b> wrists with [t_their] hands",
			"takes <b>[partner]'s</b> wrists and holding them in place",
			"holds <b>[partner]'s</b> by the wrists, mostly restraining them",
			"grips <b>[partner]'s</b> wrists"
		)
		message = pick(lewd)

	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		var/list/lewd = list(
			"grabs <b>[partner]'s</b> by wrists with [t_their] hands",
			"grips <b>[partner]'s</b> wrists and holding them in place",
			"snatches <b>[partner]'s</b> by the wrists, probably restraining them",
			"locks their grip <b>[partner]'s</b> wrists" // It goes, it goes, it goes, it goes, guillotine
				)
		message = pick(lewd)

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		var/list/lewd = list(
			"roughly grabs <b>[partner]'s</b> by wrists with [t_their] hands",
			"roughly grips <b>[partner]'s</b> wrists and holding them in place",
			"snatches <b>[partner]'s</b> by the wrists, almost certainly restraining them",
			"locks down their grip <b>[partner]'s</b> wrists"
				)
		message = pick(lewd)

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 30, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////WRIST GRAB END/////////


////////////////////
//Finger Suck 4A4//
//////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/finger_suck
	description = "Partner/Arms - Suck their fingers."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/finger_suck/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/t_them = user.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/t_have = user.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/t_are = user.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/t_were = user.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/t_do = user.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'
	
	
		//To uncomment these vars just remove the first / on the far left!
	//var/p_they = partner.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/p_their = partner.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/p_them = partner.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/p_have = partner.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/p_are = partner.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/p_were = partner.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/p_do = partner.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'


	//A big example of this combined together follows.
	// "[t_they] [t_have] [t_their] work cut out for [t_them]."
	// This can print out as, "He has his work cut out for him." // Or // "She has her work cut out for her." // Or // "They have their work cut out for them."
	//It does require a bit of forethought, but there you have it.
	var/message

	//Message block A
	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP)	//The USER of the verbs intent, only the pitcher gets to determine how hard they throw.
		var/list/lewd = list(
			"gently suckles on <b>[partner]'s</b> fingers.",
			"suckles softly on <b>[partner]'s</b> fingies",
			"teasingly suckles on <b>[partner]'s</b> digits",
			"teases <b>[partner]'s</b> fingers with [t_their] mouth"
		)
		message = pick(lewd)

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		var/list/lewd = list(
			"playfully suckles on <b>[partner]'s</b> fingers.",
			"softly sucks on <b>[partner]'s</b> fingies",
			"puts <b>[partner]'s</b> fingers in [t_their] mouth, suckling them like a tease",
			"teases <b>[partner]'s</b> by sticking [p_their] fingers into [t_their] mouth"
		)
		message = pick(lewd)
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		var/list/lewd = list(
			"really suckles on <b>[partner]'s</b> fingers.",
			"is really giving <b>[partner]'s</b> fingers the old suck",
			"drags [t_their] tongue around on <b>[partner]'s</b> fingers: suggestive",
			"sucks on <b>[partner]'s</b> fingers like a lollipop"
		)
		message = pick(lewd)

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		var/list/lewd = list(
			"aggressively suckles on <b>[partner]'s</b> fingers.",
			"is downright giving <b>[partner]</b> finger felatio",
			"might as well be going down on <b>[partner]'s</b> fingers",
			"sure is going to town on <b>[partner]'s</b> fingers, wew"
		)
		message = pick(lewd)

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 30, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.3) //s'kinda hot man idk
///////FINGER SUCK END/////////


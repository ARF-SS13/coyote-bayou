
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


/////////////
//VERBOSITY//
/////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/recieving/sniff_crotch/display_interaction(mob/living/user, mob/living/partner, show_message) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	//var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
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
		message = "[pick( //The list of emotes it picks from, preferably stacked vertically
			"lightly sniffs at <b>[partner]'s</b> crotch.", 
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully sniffs at <b>[partner]'s</b> crotch.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively sniffs at <b>[partner]'s</b> crotch.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively sniffs at <b>[partner]'s</b> crotch.",
			)]"

	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	user.handle_post_sex(lust_amt[user.a_intent]*0.5) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner) You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////CROTCH SNIFF END/////////


////////////////////
//Wrist Grab 4A3//
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/grab_balls
	description = "Partner/Crotch - Grab their balls."
	require_user_hands = TRUE

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/grab_balls/display_interaction(mob/living/user, mob/living/partner, show_message) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	//var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
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
		message = "[pick( //The list of emotes it picks from, preferably stacked vertically
			"gently grabs <b>[partner]</b> by the balls.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully grabs <b>[partner]</b> by the balls.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"roughly grabs <b>[partner]</b> by the balls.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggresively grabs <b>[partner]</b> by the balls.",
			)]"

	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.7) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////BALL GRAB END/////////

////////////////////
//Shake Pussy 6A3///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/shake_pussy
	description = "Partner/Crotch - Grab their balls."
	require_user_hands = TRUE
	max_distance = 1
////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/shake_pussy/display_interaction(mob/living/user, mob/living/partner, show_message) //The main interaction system, this populates the information in the tgui window.
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
		message = "[pick( //The list of emotes it picks from, preferably stacked vertically
			"gently grabs <b>[partner]'s</b> pussy, shaking it lightly with [t_their] own finger inside.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully grabs <b>[partner]'s</b> pussy, shaking it playfully with [t_their] own finger inside.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively grabs <b>[partner]'s</b> pussy, shaking it possessively with [t_their] own finger inside.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively grabs <b>[partner]'s</b> pussy, shaking it aggressively with [t_their] own finger inside.",
			)]"

	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////SHAKE PUSSY END/////////

/////////////////////////
// Cocktease Pussy 4A2//
///////////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/tease_kitty
	description = "Partner/Crotch - Tease their pussy with your cock."
	interaction_sound = null
	max_distance = 1

//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/tease_kitty/display_interaction(mob/living/user, mob/living/partner, show_message) //The main interaction system, this populates the information in the tgui window.
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
		message = "[pick( //The list of emotes it picks from, preferably stacked vertically
			"teases [t_their] cockhead at <b>[partner]'s</b> lower lips.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"rubs [t_their] cockhead at <b>[partner]'s</b> lower lips.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"slightly penetrates [t_their] cockhead at <b>[partner]'s</b> lower lips.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"stirs [t_their] cockhead just inside <b>[partner]'s</b> lower lips.",
			)]"

	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	partner.handle_post_sex(lust_amt[user.a_intent]*1.2)
	user.handle_post_sex(lust_amt[user.a_intent]*0.8)
///////COCKTEASE PUSSY END/////////

/////////////////////////
// Pussytease Cock 6A5//
///////////////////////

//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/tease_eggplant
	description = "Partner/Crotch - Tease their cock with your pussy."
	interaction_sound = null
	max_distance = 1

////////////
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/tease_kitty/display_interaction(mob/living/user, mob/living/partner, show_message) //The main interaction system, this populates the information in the tgui window.
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
		message = "[pick( //The list of emotes it picks from, preferably stacked vertically
			"teases <b>[partner]'s cockhead with [t_their] lower lips.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"rubs <b>[partner]'s cockhead with [t_their] lower lips.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"lets <b>[partner]'s cockhead barely slide into [t_their] lower lips.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"lets <b>[partner]'s cockhead stir just inside [t_their] lower lips.",
			)]"

	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*1.2)
	user.handle_post_sex(lust_amt[user.a_intent]*0.8)
///////PUSSYTEASE COCK END/////////


////////////////////
//Spank Ass 6A6///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/spank_ass
	description = "Partner/Crotch - Spank their behind."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/spank_ass/display_interaction(mob/living/user, mob/living/partner, show_message) //The main interaction system, this populates the information in the tgui window.
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
	//var/p_their = partner.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
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
		message = "[pick( //The list of emotes it picks from, preferably stacked vertically
			"gently spanks <b>[partner]'s</b> butt, shaking it lightly with [t_their] blows.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully spanks <b>[partner]'s</b> butt, shaking it lightly with [t_their] blows.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"aggressively spanks <b>[partner]'s</b> butt, shaking it lightly with [t_their] blows.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"violently spanks <b>[partner]'s</b> butt, shaking it lightly with [t_their] blows.",
			)]"

	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*1.2) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////SPANK ASS END/////////


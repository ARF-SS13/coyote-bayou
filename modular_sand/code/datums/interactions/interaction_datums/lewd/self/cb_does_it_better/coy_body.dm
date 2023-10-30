

//Neck-2A  (Version 4)
//	- Neck Bite 2A1 - Giving - Medium intensity
//	- Throat Grab 2A2 - Mutual - Medium-High intensity
//	- Neck Touch 2A3 - Giving - Low intensity
//	- Neck Sniff 2A4 - Mutual - Low intensity


////////////////////
//Neck Bite 2A2//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/neck_bite
	description = "Partner/Neck - Bite their Neck."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/neck_bite/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently nibbles <b>[partner]'s</b> neck.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully bites <b>[partner]'s</b> neck.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"bites into <b>[partner]'s</b> neck!",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		
		message = "[pick(
			"really bites down hard onto <b>[partner]'s</b> neck! Ow!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/1.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////NECK BITE END/////////


///////////////////
//Throat Grab 2A2//
///////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/throat_grab
	description = "Partner/Neck - Grab their throat."
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/throat_grab/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently wraps [t_their] fingers around <b>[partner]'s</b> throat.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"wraps [t_their] fingers around <b>[partner]'s</b> throat.", //An example of pronoun storage usage inside those brackets.
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"tightly [t_their] fingers around <b>[partner]'s</b> throat.", //An example of pronoun storage usage inside those brackets.
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"is just about choking out <b>[partner]'s</b> by squeezing their throat!", //An example of pronoun storage usage inside those brackets.
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]) 
	user.handle_post_sex(lust_amt[user.a_intent]) //These are divided by two to half the amount of lust given
///////THROAT GRAB END/////////

////////////////////
//Neck Touch 2A3//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/neck_touch
	description = "Partner/Neck - Touch their Neck."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/neck_touch/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently touches <b>[partner]'s</b> neck.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully touches <b>[partner]'s</b> neck.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"clasps a hand onto <b>[partner]'s</b> neck!",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"really grabs a hold of <b>[partner]'s</b> neck!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////NECK TOUCH END/////////


///////////////////
//Neck Sniff 2A4//
///////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/neck_sniff
	description = "Partner/Neck - Sniff their neck."
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/neck_sniff/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"hesitantly sniffs at <b>[partner]'s</b> neck.", 
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully sniffs at <b>[partner]'s</b> neck.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really sniffs at <b>[partner]'s</b> neck.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"really sniffs at <b>[partner]'s</b> neck.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) 
	user.handle_post_sex(lust_amt[user.a_intent]/2) //These are divided by two to half the amount of lust given
///////THROAT GRAB END/////////

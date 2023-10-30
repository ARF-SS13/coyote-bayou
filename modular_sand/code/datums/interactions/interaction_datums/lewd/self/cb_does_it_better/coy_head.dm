
//Head-1A (Version 4)
//	- French Kiss 1A1 - Mutual - Low Intensity
//	- Ear Bite 1A2 - Giving - Low to Medium Intensity 
//	- Lip Nibble 1A3 - Mutual - Low Intensity
//	- Face Nuzzle 1A4 - Mutual - Low Intensity

//////////////////////
//French Kissing 1A1//
//////////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/french_kiss
	description = "Partner/Head - French Kiss."
	interaction_sound = null
	max_distance = 1
	write_log_user = "is french kissing someone." //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = "is being french kissed."


////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/french_kiss/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently teases [t_their] tongue into <b>[partner]'s</b> mouth.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully teases [t_their] tongue around inside <b>[partner]'s</b> mouth.", //An example of pronoun storage usage inside those brackets.
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"is downright trying to bully <b>[partner]'s</b> tongue in a sloppy french kiss.", //An example of pronoun storage usage inside those brackets.
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"might as well be boxing <b>[partner]'s</b> uvula they're kissing them so deep!", //An example of pronoun storage usage inside those brackets.
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
					'sound/effects/kiss.ogg', 50, 1, -1))
	partner.handle_post_sex(lust_amt[user.a_intent]/2)
	user.handle_post_sex(lust_amt[user.a_intent]/2) //These are divided by two to half the amount of lust given
///////FRENCH KISS END/////////


////////////////////
//Ear Bite 1A2//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/ear_bite
	description = "Partner/Head - Bite their ear."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/ear_bite/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently nibbles <b>[partner]'s</b> ear.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully bites <b>[partner]'s</b> ear.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"bites into <b>[partner]'s</b> ear!",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		
		message = "[pick(
			"really bites down hard onto <b>[partner]'s</b> ear! Ow!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/1.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////EAR BITE END/////////

////////////////
//Lip Bite 1A3//
////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/lip_bite
	description = "Partner/Head - Bite their lower lip."
	interaction_sound = null
	max_distance = 1



/////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/lip_bite/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently nibbles <b>[partner]'s</b> lower lip.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully uses [t_their] teeth to bite on <b>[partner]'s</b> lower lip.", //An example of pronoun storage usage inside those brackets.
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"bites down possessively on <b>[partner]'s</b> lower lip!", //An example of pronoun storage usage inside those brackets.
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"sinks their teeth into <b>[partner]'s</b> lower lip hard!", //An example of pronoun storage usage inside those brackets.
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/0.8) 
	user.handle_post_sex(lust_amt[user.a_intent]/1.5) //These are divided by two to half the amount of lust given
///////LIP BITE END/////////


///////////////////
//Face Nuzzle 1A4//
///////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/face_nuzzle
	description = "Partner/Head - Face Nuzzle."
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/face_nuzzle/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently nuzzles [t_their] face against <b>[partner]'s</b> face.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully nuzzles [t_their] face against <b>[partner]'s</b> face.", //An example of pronoun storage usage inside those brackets.
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessibely nuzzles [t_their] face against <b>[partner]'s</b> face.", //An example of pronoun storage usage inside those brackets.
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively nuzzles [t_their] face against <b>[partner]'s</b> face!", //An example of pronoun storage usage inside those brackets.
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) 
	user.handle_post_sex(lust_amt[user.a_intent]/2) //These are divided by two to half the amount of lust given
///////FACE NUZZLE END/////////

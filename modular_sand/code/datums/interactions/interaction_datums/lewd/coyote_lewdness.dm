/*
This file is sorted by the list in coyote self_lewdness that follows on the next line.
For those that use Dreammaker for some god awful reason you can search this file using the alphanumeric following the name of the body location.
I also ask that if you add to this list, include what you added in this guide at the top of the page, and cycle up the version number as you move down the list.
While github absolutely will track this PR, it helps whoever comes behind you to know who may have done what, or how many 'versions' their code may or may not be behind without needing to hunt that info down on git.a

Happy MERPING!  ~TK<3

//Prototypes 0A (Version 3)
	- Lick the Tip 0B1   First number is the group its in, 0 is prototype. A is iteration. 1 is the order of creation in the group.
	- Tip To Lip 0B2
	- Eager Reciever 0A3

//Head-1A (Version 4)
	- French Kiss 1A1
	- Ear Bite 1A2
	- Lip Nibble 1A3
	- Face Nuzzle 1A4

//Neck-2A  (Version 4)
	- Neck Bite 2A1
	- Throat Grab 2A2
	- Neck Touch 2A3
	- Neck Sniff 2A4

//Body-3A  (Version 6)
	- Nipple twist 3A1
	- Nipple bite 3A2
	- Nipple lick 3A3
	- Nipple pull 3A4
	- Wrap Legs around partner 3A5
	- Tail Bap 3A6

//Arms-4A  (Version 4)
	- Shoulder rub 4A1
	- Fingerplay 4A2
	- Wrist Grab 4A3
	- Finger Suck 4A4

//Stomach-5A  (Version 4)
	- Touch Belly 5A1
	- Rub Belly 5A2
	- Caress Belly 5A3
	- Lick Bellybutton 5A4

//Crotch-6A  (Version 5)
	- Sniff crotch 6A1
	- Grab Balls 6A2
	- Shake Pussy 6A3
	- Tease Pussy With Cock 6A4
	- Tease Cock With Pussy 6A5
	- Spank Ass 6A6

//Thighs-7A  (Version 5)
	- Fuck Thighs 7A1
	- Lick Thighs 7A2
	- Grab Thighs 7A3
	- Bite Thigh 7A4
	- Lay Head on Thighs 7A5

//Legs-8A  (Version 4)
	- Caress Leg 8A1
	- Footsie 8A2
	- Squeeze Leg 8A3
	- Spread Legs 8A4

//Tail-9A (Version 3)
	- Brush Tail 9A1
	- Pull Tail 9A2
	- Bite Tail 9A3

*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//Prototyping																							//
//  We are going to use three 'concepts' of how to approach a Mechanical ERP Verb in this section here.	//
//  They are as follows.																				//
// ///////////////////////////////////////////////////////////////////////////////////////////////////////
//		Giving Verbs		//				Recieving Verbs				//			Mutual Verbs		//
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Giving Verbs are designed for increasing the partners arousal, but not your own.					//
//	Recieving Verbs are for increaing your own arousal, but not your partners.							//
//	Mutual Verbs increase both partners arousal at the same time.										//
/////////////////////////////////////////////////////////////////////////////////////////////////////////

//Concept Repository
//This section exists to store some examples of things that we can use to make other verbs with. These have been hand picked out of splurts actual verbs to help the concept 
//of design for more advanced users. If you are just attempting to make your first emote then perhaps you should avoid using these, as they do complicate the design process.

//(target.a_intent == INTENT_HELP/DISARM/GRAB/HARM)  This is used to check what the intent of the TARGET is. This is for things such as restraint roleplay, but perhaps has other uses.
// (target.restrained()  Checks if the target is restrained.
// (user.restrained()  Checks if the user is restrained.
// [pick("word-a", "word-b)]  We can use this to create more dynamic language in messages

////////////////////
//Lick the Tip 0A1//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/lick_the_tip
	description = "Partner/Crotch - Lick the Tip"
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/lick_the_tip/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/t_them = user.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/t_have = user.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/t_are = user.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/t_were = user.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/t_do = user.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'
	
		//To uncomment these vars just remove the first / on the far left!
	//var/p_they = partner.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	var/p_their = partner.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	var/p_them = partner.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
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
		message = "[pick(
			"[pick("gently pushes", "softly applies", "tenderly exerts", "delicately presses", "lightly presses", "subtly teases", "carefully nudges", "lightly laps with", "lightly depresses", "tactfully licks", "soothingly mlems", "cautiously tastes with", "affectionately teases")] \
			[t_their] \
			[pick("gentle", "warm", "tender", "soft", "wet", "delicate", "smooth", "velvet", "caressing", "silken")] \
			[pick("tongue", "licker", "flavor finder", "yapper", "talker", "speech maker", "chatterbox", "mouth", "kisser",)] \
			[pick("against", "onto", "upon", "up against", "in contact with", "up to")] \
			<b>[partner]'s</b> \
			cockhead \
			[pick(": moistening it", ": dampening it", ": wetting it", ": saturating it", ": soaking it", ": hydrating it", ": making it wet", ": adding moisture", ": drenching it", ": getting it wet")] \
			[pick("as [t_they] drag [t_their] tongue across it", "as [t_they] lap at it", "as [t_they] mlems it", "as [t_they] suckles on it", "as [t_they] teases it", "as [t_they] play with it")] \
			[pick("playfully", "merrily", "cheerfully", "lightheartedly", "joyfully", "happily", "jovially", "lewdly", "mischievously", "deviously")]")]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"[pick("swirls", "dragss", "twirls", "spirals", "mlems")] \
			[t_their] \
			[pick("tongue", "licker", "flavor finder", "yapper", "talker", "speech maker", "chatterbox", "mouth", "kisser",)] \
			[pick("around", "about", "circling", "all around")] \
			<b>[partner]'s</b> \
			cockhead \
			[pick(": moistening it", ": dampening it", ": wetting it", ": saturating it", ": soaking it", ": hydrating it", ": making it wet", ": adding moisture", ": drenching it", ": getting it wet")] \
			[pick("as [t_they] drag [t_their] tongue across it", "as [t_they] lap at it", "as [t_they] mlems it", "as [t_they] suckles on it", "as [t_they] teases it", "as [t_they] play with it")] \
			[pick("lewdly", "suggestively", "provocatively", "immodestly", "inappropriately", "obscenely", "indecently", "risquély", "enticingly", "salaciously")]")]"
			
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"[pick("takes", "grabs", "snatches", "steals", "buries", "appropriates", "procures", "gains", "gets")] \
			<b>[partner]'s</b> \
			cockhead \
			[pick("into [t_their] mouth", "against [t_their] tongue", "inside [t_their] mouth and lets [t_their] tongue", "within [t_their] lips", "in [t_their] maw", "inside [t_their] gob")] \
			 [pick("swirling", "whirling", "twisting", "spiraling", "whirlpooling", "twirling", "circling", "spinning", "churning")] \
			 [t_their] \
			[pick("tongue", "licker", "flavor finder", "mouth", "kisser",)] \
			as they work to \
			[pick("please [p_them]", "satisfy [p_them]", "gratify [p_them]", "delight [p_them]", "fulfill [p_their] desires", "bring [p_them] pleasure", "make [p_them] happy", "meet [p_them] needs", "give [p_them] satisfaction", "appease [p_them]", "get [p_them] off", "make [p_them] cum", "make [p_them] climax")]")]"


		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"is \
			[pick("suckling on", "nursing on", "slurping on", "drawing everything [t_they] from", "sipping from", "tenderly nursing on", "gently suckling on", "savoring while suckling on")] \
			<b>[partner]'s</b> \
			cockhead \
			like [t_their] life depends on it!)")]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////LICK THE TIP END/////////

////////////////////
//Tip To Lip 0A2////
////////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/recieving/tip_to_lip
	description = "Partner/Head - Rub tip on lips."
	interaction_sound = null
	max_distance = 1
	write_log_user = "rubbed their tip on someones lips." //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.


/////////////
//VERBOSITY//
/////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/recieving/tip_to_lip/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"[pick("gently pushes", "softly applies", "tenderly exerts", "delicately presses", "lightly presses", "subtly teases", "carefully nudges", "lightly laps with", "lightly depresses", "tactfully licks", "soothingly mlems", "cautiously tastes with", "affectionately teases")] \
			[t_their] \
			cockhead to \
			<b>[partner]'s</b> \
			[pick("lips", "kisser", "mouth", "kissing zone", "smoocher")]")]"


			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"[pick("teases the", "playfully taunts the", "teasingly flirts with the", "provocatively tempts the", "coquettishly allures the", "mischievously tantalizes the", "seductively entices the", "flirtatiously beguiles the", "enticingly provokes the", "charmingly lures the")] \
			[pick("tip of", "end of", "point of", "top of", "apex of", "summit of", "vertex of", "peak of", "pinnacle of", "zenith of")] \
			[t_their] \
			cockhead \
			[pick("around", "about", "approximately", "roughly", "circling around", "in the vicinity of", "near", "close to")] \
			and \
			[pick("in", "inside", "within", "within the confines of", "inside of", "amidst")] \
			<b>[partner]'s</b> \
			[pick("soft and wet", "gentle and moist", "tender and damp", "smooth and soaked", "juicy and soft", "delicate and dewy", "silky and saturated", "supple and moist")] \
			[pick("lips", "kisser", "mouth", "kissing zone", "smoocher")]")]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"[pick("firmly pushes", "strongly presses", "forcibly thrusts", "steadily shoves", "powerfully propels", "assertively drives", "solidly propels", "resolutely thrusts", "vigorously moves", "determinedly applies force")] \
			<b>[partner]'s</b> \
			lips apart with \
			[t_their] \
			cockhead: \
			[pick("using their mouth as a playtoy", "playfully employing their lips and tongue to pleasure themselves", "making a game of their oral actions", "using their oral cavity as a source of pleasure", "treating their mouth as a fun toy", "playfully toying with their lips and tongue", "utilizing their mouth for their own sexual pleasures")]")]"


		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"is \
			[pick("forcing", "compelling", "coercing", "pressuring", "driving", "pushing", "obliging", "mandating", "requiring", "imposing")] \
			<b>[partner]</b> \
			[pick("suckle on", "nurse on", "savor on", "lick on", "mlem on", "drool on", "taking")] \
			[t_their] \
			cock \
			by force: \
			[pick("using their mouth as a playtoy", "playfully employing their lips and tongue to pleasure themselves", "making a game of their oral actions", "using their oral cavity as a source of pleasure", "treating their mouth as a fun toy", "playfully toying with their lips and tongue", "utilizing their mouth for their own sexual pleasures")]")]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/effects/lick.ogg', 50, 1, -1) //This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume. 
	user.handle_post_sex(lust_amt[user.a_intent]) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner) You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////TIP TO LIP END/////////


//////////////////////
//Eager Reciever 0A3//
//////////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/eager_reciever
	description = "Partner/Head - Recieve Eagerly."
	interaction_sound = null
	max_distance = 1
	write_log_user = "is really into something someone is doing to them." //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.


////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/eager_reciever/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
		message = "[pick( \
			"is \
			[pick("wiggling", "squirming", "writhing", "twisting", "wriggling", "shimmying", "fidgeting", "jiggling", "swaying", "undulating")] \
			from the \
			[pick("attention being given", "affection being directed", "care being taken", "closeness being heaped on them")] \
			by \
			<b>[partner]'s</b> \
			[pick("actions", "deeds", "activities", "exploits", "undertakings", "feats", "performance")]")]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick( \
			"is \
			[pick("playfully squirming", "merrily wriggling", "gleefully fidgeting", "mischievously wiggling", "cheerfully writhing", "jovially twisting", "joyfully squiggling", "playfully undulating", "lightheartedly squiggling", "merrily fidgeting")] \
			from the \
			[pick("attention being given", "affection being directed", "care being taken", "closeness being heaped on them")] \
			by \
			<b>[partner]'s</b> \
			[pick("actions", "deeds", "activities", "exploits", "undertakings", "feats", "performance")]")]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"is eager about whatever <b>[partner]'s</b> doing to them")]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick("is rapidly losing control because of what <b>[partner]'s</b> doing to them!")]

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
					'modular_sand/sound/interactions/bang1.ogg',
					'modular_sand/sound/interactions/bang2.ogg',
					'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) //For determining that the USERS intent is how much LUST the RECEIVER is getting. You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
	user.handle_post_sex(lust_amt[user.a_intent]/2) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner)
///////EAGER RECIEVER END/////////


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
	playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
					'sound/weapons/bite.ogg', 50, 1, -1))
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
	playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
					'sound/effects/kiss.ogg', 50, 1, -1))
	partner.handle_post_sex(lust_amt[user.a_intent]/2) 
	user.handle_post_sex(lust_amt[user.a_intent]/2) //These are divided by two to half the amount of lust given
///////FACE NUZZLE END/////////




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
	playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
					'sound/effects/kiss.ogg', 50, 1, -1))
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
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
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
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) 
	user.handle_post_sex(lust_amt[user.a_intent]/2) //These are divided by two to half the amount of lust given
///////THROAT GRAB END/////////


/*Body-3A  (Version 6)
	- Nipple twist 3A1 - Giving - Light to Medium intensity
	- Nipple bite 3A2 - Giving - Light to Medium intensity
	- Nipple lick 3A3 - Giving - Light to Medium intensity
	- Nipple pull 3A4 - Giving - Medium to High intensity
	- Wrap Legs around partner 3A5 - Mutual - Light to Medium intensity
	- Tail Bap 3A6 - Giving - no intensity
	*/


////////////////////
//Nipple Twist 3A1//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_twist
	description = "Partner/Neck - Twist their nipple."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/neck_twist/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently twists <b>[partner]'s</b> nipple.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully twists <b>[partner]'s</b> nipple.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really twists <b>[partner]'s</b> nipple.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively twists <b>[partner]'s</b> nipple!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////NIPPLE TWIST END/////////


///////////////////
//Nipple Bite 3A2//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_bite
	description = "Partner/Neck - Bite their nipple."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/nipple_bite/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently bites <b>[partner]'s</b> nipple.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully bites <b>[partner]'s</b> nipple.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really bites <b>[partner]'s</b> nipple.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively bites <b>[partner]'s</b> nipple!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////NIPPLE BITE END/////////

///////////////////
//Nipple Lick 3A3//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_lick
	description = "Partner/Neck - Lick their nipple."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/nipple_lick/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently licks <b>[partner]'s</b> nipple.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully licks <b>[partner]'s</b> nipple.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really licks <b>[partner]'s</b> nipple.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively licks <b>[partner]'s</b> nipple!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////NIPPLE LICK END/////////


///////////////////
//Nipple Pull 3A4//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nipple_pull
	description = "Partner/Neck - Pull their nipple."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/nipple_pull/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently pulls <b>[partner]'s</b> nipple.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully pulls <b>[partner]'s</b> nipple.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really pulls <b>[partner]'s</b> nipple.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively pulls <b>[partner]'s</b> nipple!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////NIPPLE PULL END/////////

////////////////
// Leg Wrap 3A5//
////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/leg_wrap
	description = "Partner/Body - Wrap your legs around them."
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/leg_wrap/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"lightly wraps [t_their] legs around <b>[partner]'s</b> waist.", 
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully wraps [t_their] legs around <b>[partner]'s</b> waist.", 
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really wraps [t_their] legs around <b>[partner]'s</b> waist.", 
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"tightly wraps [t_their] legs around <b>[partner]'s</b> waist.", 
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) 
	user.handle_post_sex(lust_amt[user.a_intent]/2) //These are divided by two to half the amount of lust given
///////LEG WRAP END/////////

////////////////////
//Tail Bap 3A6//
////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/tail_bap
	description = "Partner/Body - Bap them with your tail."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/tail_bap/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently whacks <b>[partner]'s</b> with [t_their] tail.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully whacks <b>[partner]'s</b> with [t_their] tail.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really whacks <b>[partner]'s</b> with [t_their] tail.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively whacks <b>[partner]'s</b> with [t_their] tail.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////TAIL BAP END/////////


//Arms-4A  (Version 4)
//	- Shoulder rub 4A1 - giving - no intensity
//	- Fingerplay 4A2 - mutual - no intensity
//	- Wrist Grab 4A3 - giving - low intensity
//	- Finger Suck 4A4 - giving - low intensity

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
			"gently rubs <b>[partner]'s shoulders.</b>.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"rubs <b>[partner]'s</b> shoulders intently.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"rubs <b>[partner]'s</b> shoulders with vigor.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"rubs <b>[partner]'s</b> shoulders hard!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
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
			"softly plays with <b>[partner]'s</b> fingers.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"gently plays with <b>[partner]'s</b> fingers.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"roughly plays with <b>[partner]'s</b> fingers.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively plays with <b>[partner]'s</b> fingers.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
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
			"gently grabs <b>[partner]</b> by the wrists.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully grabs <b>[partner]</b> by the wrists.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"roughly grabs <b>[partner]</b> by the wrists.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggresively grabs <b>[partner]</b> by the wrists.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
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
			"gently suckles on <b>[partner]'s</b> fingers.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully suckles on <b>[partner]'s</b> fingers.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"really suckles on <b>[partner]'s</b> fingers.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively suckles on <b>[partner]'s</b> fingers.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////FINGER SUCK END/////////



//Stomach-5A  (Version 4)
//	- Touch Belly 5A1 - giving - no intensity
//	- Rub Belly 5A2 - giving - no intensity
//	- Caress Belly 5A3 - giving - no intensity
//	- Lick Bellybutton 5A4 - giving - low intensity

////////////////////
//Touch Belly 5A1//
//////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/touch_belly
	description = "Partner/Stomach - Touch their belly."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/touch_belly/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently touches <b>[partner]'s</b> belly.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully touches <b>[partner]'s</b> belly.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively touches <b>[partner]'s</b> belly.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"squeezes <b>[partner]'s</b> belly!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////TOUCH BELLY END/////////


////////////////////
//Touch Belly 5A2//
//////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/rub_belly
	description = "Partner/Stomach - Rub their belly."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/rub_belly/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently rubs <b>[partner]'s</b> belly.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully rubs <b>[partner]'s</b> belly.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively rubs <b>[partner]'s</b> belly.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively rubs <b>[partner]'s</b> belly!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////RUB BELLY END/////////

////////////////////
//Caress Belly 5A3//
//////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/caress_belly
	description = "Partner/Stomach - Lovingly caress their belly."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/caress_belly/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"lightly caresses <b>[partner]'s</b> belly.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"lovingly caresses <b>[partner]'s</b> belly.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively caresses <b>[partner]'s</b> belly.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively caresses <b>[partner]'s</b> belly.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////CARESS BELLY END/////////

////////////////////////
//Lick Bellybutton 5A4//
///////////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/lick_bellybutton
	description = "Partner/Stomach - Lick their bellybutton."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/lick_bellybutton/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"lightly licks <b>[partner]'s</b> bellybutton.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully licks <b>[partner]'s</b> bellybutton.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"tongues [t_their] <b>[partner]'s</b> bellybutton.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"is going to town licking <b>[partner]'s</b> bellybutton.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////LICK BELLYBUTTON END/////////



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
	interaction_sound = null
	max_distance = 1


/////////////
//VERBOSITY//
/////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/recieving/sniff_crotch/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/effects/lick.ogg', 50, 1, -1) //This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume. 
	user.handle_post_sex(lust_amt[user.a_intent]*0.5) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner) You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////CROTCH SNIFF END/////////


////////////////////
//Wrist Grab 4A3//
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/grab_balls
	description = "Partner/Crotch - Grab their balls."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/grab_balls/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.7) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////BALL GRAB END/////////

////////////////////
//Shake Pussy 6A3///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/shake_pussy
	description = "Partner/Crotch - Grab their balls."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/shake_pussy/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
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

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/tease_kitty/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
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
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/tease_kitty/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
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
/datum/interaction/lewd/partner/giving/spank_ass/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*1.2) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////SPANK ASS END/////////



//Thighs-7A  (Version 5)
//	- Fuck Thighs 7A1 - recieving - medium to high intensity
//	- Lick Thighs 7A2 - giving - low intensity
//	- Grab Thighs 7A3 - giving - low to medium intensity
//	- Bite Thigh 7A4 - giving - low to medium intensity
//	- Lay Head on Thighs 7A5 - mutual - no intensity

//////////////////////
//Fuck Thighs 7A1////
//////////////////////

//Remember to change this                 VVVV
/datum/interaction/lewd/partner/recieving/fuck_thighs
	description = "Partner/Thighs - Fuck their thighs."
	interaction_sound = null
	max_distance = 1


/////////////
//VERBOSITY//
/////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/recieving/sniff_crotch/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"lightly humps <b>[partner]'s</b> thighs.", 
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully humps <b>[partner]'s</b> thighs.", 
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"needily humps <b>[partner]'s</b> thighs.", 
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively humps <b>[partner]'s</b> thighs.", 
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/effects/lick.ogg', 50, 1, -1) //This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume. 
	user.handle_post_sex(lust_amt[user.a_intent]*0.5) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner) You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////FUCK THIGH END/////////

////////////////////
//Lick Thigh 7A2///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/lick_thigh
	description = "Partner/Thigh - Lick their thighs."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/lick_thigh/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently licks <b>[partner]'s</b> thighs.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully licks <b>[partner]'s</b> thighs.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively licks <b>[partner]'s</b> thighs.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively licks <b>[partner]'s</b> thighs.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////LICK THIGH END/////////

////////////////////
//Grab Thigh 7A3///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/grab_thigh
	description = "Partner/Thigh - Grab their thighs."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/grab_thigh/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently grabs one of <b>[partner]'s</b> thighs.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully grabs one of <b>[partner]'s</b> thighs.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively grabs one of <b>[partner]'s</b> thighs.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively grabs one of <b>[partner]'s</b> thighs.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////GRAB THIGH END/////////

/////////////////////////
// Bite Thigh 7A4////////
///////////////////////

//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/bite_thigh
	description = "Partner/Thigh - Bite their thigh."
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/bite_thigh/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently bites one of <b>[partner]'s</b> thighs.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"gently bites one of <b>[partner]'s</b> thighs.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"gently bites one of <b>[partner]'s</b> thighs.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"gently bites one of <b>[partner]'s</b> thighs.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*1.2)
	user.handle_post_sex(lust_amt[user.a_intent]*0.8)
///////BITE THIGH END/////////

/////////////////////////
// Rest Thigh 7A5////////
///////////////////////

//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/rest_thigh
	description = "Partner/Thigh - Rest your head on their thigh."
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/rest_thigh/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently rests [t_their] head one of <b>[partner]'s</b> thighs.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"comfortably rests [t_their] head one of <b>[partner]'s</b> thighs.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"tiredly rests [t_their] head one of <b>[partner]'s</b> thighs.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"flops [t_their] head one of <b>[partner]'s</b> thighs.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0)
	user.handle_post_sex(lust_amt[user.a_intent]*0)
///////BITE THIGH END/////////



//Legs-8A  (Version 4)
//	- Caress Leg 8A1 - giving - low to medium intensity
//	- Footsie 8A2 - mutual - low intensity
//	- Squeeze Leg 8A3 - giving - low to medium intensity
//	- Spread Legs 8A4 - mutual - medium to high intensity

////////////////////
//caress Leg 8A1///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/caress_leg
	description = "Partner/Legs - Lovingly caress their leg."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/caress_leg/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently caresses one of <b>[partner]'s</b> legs.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"softly caresses one of <b>[partner]'s</b> legs.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"firmly caresses one of <b>[partner]'s</b> legs.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"needily caresses one of <b>[partner]'s</b> legs.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////CARESS LEG END/////////


/////////////////////////
// Footsie 8A2////////
///////////////////////

//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/footsie
	description = "Partner/Legs - Play Footsie With."
	interaction_sound = null
	max_distance = 2

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/footsie/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently rubs [t_their] foot one of <b>[partner]'s</b> feet.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully rubs [t_their] foot one of <b>[partner]'s</b> feet.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"possessively rubs [t_their] foot one of <b>[partner]'s</b> feet.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively rubs [t_their] foot one of <b>[partner]'s</b> feet.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.3)
	user.handle_post_sex(lust_amt[user.a_intent]*0.3)
///////FOOTSIE END/////////


////////////////////
//Squeeze Leg 8A3///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/squeeze_leg
	description = "Partner/Legs - Squeeze their leg."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/squeeze_leg/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently sqeuezes one of <b>[partner]'s</b> legs.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"softly sqeuezes one of <b>[partner]'s</b> legs.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"firmly sqeuezes one of <b>[partner]'s</b> legs.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"needily sqeuezes one of <b>[partner]'s</b> legs.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////SQUEEZE LEG END/////////

/////////////////////////
// Spread Legs 8A4////////
///////////////////////

//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/spread_legs
	description = "Partner/Legs - Spread their legs."
	interaction_sound = null
	max_distance = 2

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/spread_legs/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently spreads <b>[partner]'s</b> legs, gaining access to their lap.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"playfully spreads <b>[partner]'s</b> legs, gaining access to their lap.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"firmly spreads <b>[partner]'s</b> legs, gaining access to their lap.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively spreads <b>[partner]'s</b> legs, gaining access to their lap.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	//playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	//				'sound/effects/kiss.ogg'
	//				50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent])
	user.handle_post_sex(lust_amt[user.a_intent])
///////SPREAD LEGS END/////////



//Tail-9A (Version 3)
//	- Brush Tail 9A1 - giving - low intensity
//	- Pull Tail 9A2 - giving - medium intensity
//	- Bite Tail 9A3 - giving - low intensity

////////////////////
//Brush Tail 9A1///
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/brush_tail
	description = "Partner/Tail - Brush their tail."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/brush_tail/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently brushes <b>[partner]'s</b> tail.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"softly brushes <b>[partner]'s</b> tail.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"firmly brushes <b>[partner]'s</b> tail.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively brushes <b>[partner]'s</b> tail.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////BRUSH TAIL END/////////

////////////////////
//Pull Tail 9A2/////
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/pull_tail
	description = "Partner/Tail - Pull their tail."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/pull_tail/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently pulls <b>[partner]'s</b> tail.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"softly pulls <b>[partner]'s</b> tail.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"firmly pulls <b>[partner]'s</b> tail.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively pulls <b>[partner]'s</b> tail.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////PULL TAIL END/////////

////////////////////
//bites Tail 9A2/////
////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/givingbites_tail
	description = "Partner/Tail -bites their tail."
	require_user_hands = TRUE
	interaction_sound = null
	max_distance = 1

////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/bites_tail/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
			"gently bites <b>[partner]'s</b> tail.",
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"softly bites <b>[partner]'s</b> tail.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"firmly bites <b>[partner]'s</b> tail.",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"aggressively bites <b>[partner]'s</b> tail.",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	//playlewdinteractionsound(get_turf(user), 'sound/weapons/bite.ogg', 50, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]*0.5) //You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
///////BITE TAIL END/////////


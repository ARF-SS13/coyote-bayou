////////////////////////
//COYOTE SELF VERBS   //
///////////////////////

//So, you want to make a new ERP emote, in this case, to use on yourself?  Well aren't you in luck. The Rub Crotch emote directly below here is designed to make that process AS EASY AS POSSIBLE.
//You CAN do this.  If you could download the code, and get github desktop running then this is FULLY within YOUR ability.  Just READ the comments.  Take your time, and know that we love you, and want to see your verb pr as soon as possible!

//1. Copy the name brick, put your emotes name in it
//2. Set the new path for /datum/interaction/lewd/self/WHATEVER_NAME_YOU_DESIRE
//3. Set the description text inside the quotes as the comments ask.
//4. Select the options you want for the vars below, but before you get to the 'Verbosity' brick.
//5. Brainstorm what you want the different intents to be doing based off of how they're supposed to be used.
//6. Write a single message = pick for each line, you'll want to add more but lets dial in the basic concept first.
//7. Keep an eye on your writing, see if you could or should use anything in the Pronoun Storage system
//8. Tie up your Wrap Up section, including sound.
//9. Tie off your 'emote end line'
//10. Cry a lot
//11. ??????? 
//12. Compile
//13. Fix the issues you have from testing, or add more message lines!  Rinse and repeat from 10 until you're so dehydrated you blow away like salt in the wind.


//////////////
//Rub Crotch// 
//////////////
//Crotch rub will be our prototype emote, I will comment the shit out of it to make things make the most sense to a newbie.
//Remember to change this VVVV
/datum/interaction/lewd/self/rub_crotch //lewd makes it pink, the name is just what the code calls it.
	description = "Self/Crotch - Rub Crotch." //This naming convention is to help players who want to filter functions. In this case its Self, as in, yourSELF, and a function of the 'area' crotch.  Then it describes what you're doing to the area.
	// Self/Partner for the left hand side.
	// Head/Neck/Body/Arms/Stomach/Crotch/Thighs/Legs/Tail for the right hand side.
	interaction_sound = null //Does this emote have a sound attached?  This defaults to the parent at lewd_interactions.dm line 7 and can be replaced to make this action always make a sound!
	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	user_is_target = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.
	write_log_user = "rubbed their crotch" //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.


////////////
//VERBOSITY//
////////////
//Remember to change this VVVV
/datum/interaction/lewd/self/rub_crotch/display_interaction(mob/living/user) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove both of the /'s' on the far left before var!
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


	var/t_their = user.p_their() //This is an example of creating a var that uses an existing pronoun, this is an inherited example, we should remove it and use the one above eventually.
	var/message //This is the variable that holds the different messages that can play depending on which intent the player has used.

//Message block A
	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP) //Is the player on help intent?  //If your verb is insanely simple, you can remove this user.a_intent check and just do a single block of messages.
		message = pick( //Then pick from these messages!
		"[pick("lightly", "gently")] \
		 [pick("rubs", "brushes")] \
		 [t_their] \
		 [pick("crotch.", "lap.")]")

//Pick System Prototype				 
/*  This system that you see above here is very complex at first glance, but lets take a moment to break it down.  
On line 70 you have the message = pick( call.  This is the call the code will do to figure out what it should put in chat.
On line 71 we've placed the start of the first original message pick options. It's where the " starts at. 
On line 71 we have the SECOND word of the thing that will be said. The first is always your characters name, or unknown.
On line 71 we then have another pick call in brackets.  This pick call then picks between the words lightly and gently.
On the end of line 71 we have a space, then a code line break. The code will read this as there not being an actual break there, it helps keep this legible.
On line 72 we have the next word in the sentence we're building, in this case rubs or brushes.  Then that line break again. Same line break.
On line 73 we have the pronoun call for their. It will be His/Her/Their depending on the character using the verb. Same line break.
On line 74 we have the final word of the sentence, which is why a period is included in the pick calls. No line break here, then we close the original pick from line 70.

What this does is build MULTIPLE possible sentences
"Little Joey Toblerone [lightly] [brushes] his [crotch.]" - Remove the brackets of course
Lightly, brushes, and crotch could all just as equally as gently, rubs, or crotch could have been.
This allows for massively randomized text building!
Enjoy!												*/
//In the nightmare scenario of this post getting moved please feel free to use this Gyazo link for the original layout
//https://gyazo.com/f9c8a8e639a49927976600db54bcbdee



		//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM) //Is the player on disarm intent?
		var/adverb1 = pick("is definitely", "certainly")
		var/action1 = pick("rubbing", "brushing")
		var/place1 = pick("crotch.", "lap.")
		var/msg1 = "[adverb1] [action1] [t_their] [place1]"
		var/action2 = pick("rubs", "brushes")
		var/place2 = pick("crotch", "lap")
		var/brisk = pick("a bit briskly.", "a bit energetically.")
		var/msg2 = "[action2] [t_their] [place2] [brisk]"
		message = pick(msg1, msg2)

// The system above is an example of using on the spot variables that you (yes, you, baby coder.  You can just make them, they don't need any other code elsewhere)
// You make your var/whatevers, then glue them together into a msg var. Then, once you have all your message variations created you plug them into tyour message = Pick() system. 
// This works much the same way as the sytem in Block A, but instead of writing it out long form it just uses variables!


//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB) //Is the player in grab intent?
			message = pick( //Then pick from these messages!
			"rubs [t_their] lap openly!",
			"rubs [t_their] crotch!", //This is how two or more should look, stack them vertically!
			)

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	else if(user.a_intent == INTENT_HARM) //Is the player in harm intent?
		message = pick( //Then pick from these messages!
			"rubs [t_their] lap aggressively!",
			"mauls [t_their] crotch!", //This is how two or more should look, stack them vertically!
			)

//Aftershock Block//  
	if(prob(5 + user.get_lust())) //This is things that happen in chat naturally to show that arousal is being built up.
		user.visible_message(span_love("<b>\The [user]</b> [pick( //The list that is used starts here.
				"shivers in arousal.", //These print to everyone in view range.
				"moans quietly.",
				"breathes out a soft moan.",
				"gasps.",
				"shudders softly.",
				)]"))

					//Wrap up//
	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting()) //I'm not sure what this does fully, but it should make the message visible, and decides if its fucking pink or not!
	playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1) //This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	user.handle_post_sex(lust_amt[user.a_intent]) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner)
///////RUB CROTCH END/////////



//////////////
//Rub Behind// 
//////////////
//Remember to change this VVVV
/datum/interaction/lewd/self/rub_behind //lewd makes it pink, the name is just what the code calls it.
	description = "Self/Crotch - Rub Behind." //This naming convention is to help players who want to filter functions. In this case its Self, as in, yourSELF, and a function of the 'area' crotch.  Then it describes what you're doing to the area.
	// Self/Partner for the left hand side.
	// Head/Neck/Body/Arms/Stomach/Crotch/Thighs/Legs/Tail for the right hand side.
	interaction_sound = null //Does this emote have a sound attached?  This defaults to the parent at lewd_interactions.dm line 7 and can be replaced to make this action always make a sound!
	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	user_is_target = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.
	write_log_user = "rubbed their backside." //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.


////////////
//VERBOSITY//
////////////
//Remember to change this VVVV
/datum/interaction/lewd/self/rub_behind/display_interaction(mob/living/user) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	//var/t_thier = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	//var/t_them = user.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/t_have = user.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/t_are = user.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/t_were = user.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/t_do = user.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'
	
	//A big example of this combined together follows.
	// "[t_they] [t_have] [t_their] work cut out for [t_them]."
	// This can print out as, "He has his work cut out for him." // Or // "She has her work cut out for her." // Or // "They have their work cut out for them."
	//It does require a bit of forethought, but there you have it.


	var/t_their = user.p_their() //This is an example of creating a var that uses an existing pronoun, this is an inherited example, we should remove it and use the one above eventually.
	var/message //This is the variable that holds the different messages that can play depending on which intent the player has used.

//Message block A
	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP) //Is the player on help intent?  //If your verb is insanely simple, you can remove this user.a_intent check and just do a single block of messages.
		message = pick( //Then pick from these messages!
		"lightly rubs [t_their] backside.",
		)

		//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM) //Is the player on disarm intent?
		message = pick( //Then pick from these messages!
			"is really rubbing at [t_their] own rear end.",
		)

//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB) //Is the player in grab intent?
		message = pick( //Then pick from these messages!
			"is rubbing [t_their] backside pretty aggressively!",
		)

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	else if(user.a_intent == INTENT_HARM) //Is the player in harm intent?
		message = pick( //Then pick from these messages!
			"rubs [t_their] butt aggressively!",
			"mauls [t_their] own butt with attention!", //This is how two or more should look, stack them vertically!
			)

//Aftershock Block//  
	if(prob(5 + user.get_lust())) //This is things that happen in chat naturally to show that arousal is being built up.
		user.visible_message(span_love("<b>\The [user]</b> [pick( //The list that is used starts here.
				"shivers in arousal.", //These print to everyone in view range.
				"moans quietly.",
				"breathes out a soft moan.",
				"gasps.",
				"shudders softly.",
				"jiggles their rump.",
				)]"))

					//Wrap up//
	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting()) //I'm not sure what this does fully, but it should make the message visible, and decides if its fucking pink or not!
	//playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1) //This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	user.handle_post_sex(lust_amt[user.a_intent]) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner)
///////RUB BUTT END/////////

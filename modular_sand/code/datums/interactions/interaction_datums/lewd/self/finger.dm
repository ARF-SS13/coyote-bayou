/datum/interaction/lewd/fingerass_self
	description = "Self/Crotch - Finger your own butthole."
	interaction_sound = null
	require_user_hands = TRUE
	require_user_anus = REQUIRE_ANY
	user_is_target = TRUE
	max_distance = 0
	write_log_user = "fingered self"
	write_log_target = null

/datum/interaction/lewd/fingerass_self/display_interaction(mob/living/user)
	var/t_His = user.p_their()
	var/message

	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP)
		message = pick(
		"teases a finger around [t_His] pucker!",
		"rubs [t_His] starfish gently!",
		"very lightly gives [t_His] own butthole a tap!",
		"is gently rubbing [t_His] pucker!", //someone who is more excited about anal sex, please rewrite this for me. <3	~TK
		)

	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = pick(
			"teasingly fingers [t_His] backdoor!",
			"explores [t_His] own backdoor entrance playfully!",
			"spreads [t_His] cheeks, clearly enjoying themselves!",
			"rubs a circle around [t_His] sphincter, teasing themselves!",
		)

	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)

		message = pick(
			"gives [t_His] butthole a playful slap!",
			"fingers [t_His] backdoor thoroughly.",
			"is really getting up in [t_His] own ass!",
			"is absolutely using [t_His] fingers to knock on the back door!",
		)

	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	else if(user.a_intent == INTENT_HARM)
		message = pick(
			"slaps [t_His] asshole hard!",
			"is fingering [t_His] butthole like [t_His] life depends on it!",
			"groans as they fingerfuck their own ass!",
			"fingers [t_His] booty so hard them begins to shake!",
			"is fingering [t_His] butt like it owes them money!",
			)


	if(prob(5 + user.get_lust()))
		user.visible_message(span_love("<b>\The [user]</b> [pick(
				"shivers in arousal.",
				"moans quietly.",
				"breathes out a soft moan.",
				"gasps.",
				"shudders softly.",
				"trembles as [t_His] hands run across bare skin.")]"))

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)
	user.handle_post_sex(lust_amt[user.a_intent], CUM_TARGET_HAND, user, "anus") //SPLURT edit

/datum/interaction/lewd/finger_self
	description = "Self/Crotch - Finger your own pussy."
	require_user_hands = TRUE
	require_user_vagina = REQUIRE_ANY
	interaction_sound = null
	user_is_target = TRUE
	max_distance = 0
	write_log_user = "fingered own pussy"
	write_log_target = null

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)

/datum/interaction/lewd/finger_self/display_interaction(mob/living/user)
	var/t_His = user.p_their()
	var/message
	lust_amt = list(
					INTENT_HELP = LOW_LUST, 
					INTENT_DISARM = SOME_LUST,
					INTENT_GRAB = SOME_MORE_LUST,
					INTENT_HARM = NORMAL_LUST
					)
	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

//help intent should be gentle, downright even loving and probably the opener for situations
		if(user.a_intent == INTENT_HELP)
			message = pick(
			"teases a finger around [t_His] labia!",
			"rubs [t_His] pussy gently!",
			"very lightly gives [t_His] own pussy a tap!",
			"is gently rubbing [t_His] nether lips!",
			)

//disarm intent should be used for being particularly playful with the interaction
		else if(user.a_intent == INTENT_DISARM)
			message = pick(
				"teasingly fingers [t_His] pussy!",
				"explores [t_His] own love canal playfully!",
				"spreads [t_His] pussy lips, clearly enjoying themselves!",
				"rubs a circle around [t_His] labia, teasing themselves!",
			)

//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
		else if(user.a_intent == INTENT_GRAB)

			message = pick(
				"gives [t_His] pussy a playful slap!",
				"fingers [t_His] honeypot thoroughly.",
				"is really getting up in [t_His] own pussy!",
				"is soaking [t_His] fingers in their own juices as they play with themselves!",
			)

//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
		else if(user.a_intent == INTENT_HARM)
			message = pick(
				"slaps [t_His] pussy lips hard!",
				"is fingering [t_His] pussy like [t_His] life depends on it!",
				"groans as they fingerfuck their pussy messily!",
				"fingers [t_His] pussy so hard them begins to shake!",
				"is fingering [t_His] pussy like it owes them money!",
				)

	if(prob(5 + user.get_lust()))
		user.visible_message(span_love("<b>\The [user]</b> [pick(
				"shivers in arousal.",
				"moans quietly.",
				"breathes out a soft moan.",
				"gasps.",
				"shudders softly.",
				"trembles as [t_His] hands run across bare skin.")]"))


	if(!user.is_fucking(user, CUM_TARGET_HAND, user.getorganslot(ORGAN_SLOT_VAGINA)))
		user.set_is_fucking(user, CUM_TARGET_HAND, user.getorganslot(ORGAN_SLOT_VAGINA))

	if(liquid_container)
		message += " over \the [liquid_container]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)
	user.handle_post_sex(lust_amt[user.a_intent],CUM_TARGET_HAND, liquid_container ? liquid_container : user, ORGAN_SLOT_VAGINA)



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
//VEROSITY//
////////////
//Remember to change this VVVV
/datum/interaction/lewd/self/rub_crotch/display_interaction(mob/living/user) //The main interaction system, this populates the information in the tgui window.
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
		"lightly rubs [t_their] crotch.",
		)

		//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM) //Is the player on disarm intent?
		message = pick( //Then pick from these messages!
			"puts a bit of pressure on [t_their] lap.",
		)

//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB) //Is the player in grab intent?
		message = pick( //Then pick from these messages!
			"is really grinding at [t_their] lap!",
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



/*
This file is sorted by the list in coyote self_lewdness that follows on the next line.
For those that use Dreammaker for some god awful reason you can search this file using the alphanumeric following the name of the body location.
I also ask that if you add to this list, include what you added in this guide at the top of the page, and cycle up the version number as you move down the list.
While github absolutely will track this PR, it helps whoever comes behind you to know who may have done what, or how many 'versions' their code may or may not be behind without needing to hunt that info down on git.a

Happy MERPING!  ~TK<3

//Prototypes 0A (Version 3)
	- Lick the Tip 0A1
	- Rub Tip Against Mouth 0A2
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


////////////////////
//Lick the Tip 0A1//
///////////////////
//Giving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/lick_the_tip
	description = "Partner/Crotch - Lick the Tip"
	interaction_sound = null
	max_distance = 1
	write_log_user = "licked the tip" //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.


////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/giving/lick_the_tip/display_interaction(mob/living/user, mob/living/partner) //The main interaction system, this populates the information in the tgui window.
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
	if(user.a_intent == INTENT_HELP)	//The USER of the verbs intent
		message = "[pick( //The list of emotes it picks from, preferably stacked vertically
			"lightly presses [t_their] tongue to <b>[partner]'s</b> cockhead.", //An example of pronoun storage usage inside those brackets.
			)]"

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = "[pick(
			"swirls [t_their] tongue around <b>[partner]'s</b> cockhead.",
			)]"
	
	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = "[pick(
			"takes <b>[partner]'s</b> into their mouth, swirling [t_their] tongue as they work to please them!",
			)]"

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = "[pick(
			"is suckling on <b>[partner]'s</b> cockhead like [t_their] life depends on it!",
			)]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/effects/lick.ogg', 50, 1, -1) //This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the interaction_sound var?  Probably just an improved version. That 50 is volume.
	partner.handle_post_sex(lust_amt[user.a_intent]) //For determining that the USERS intent is how much LUST the RECEIVER is getting.
///////LICK THE TIP END/////////

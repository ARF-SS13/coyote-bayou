/*
This file is sorted by the list in coyote self_lewdness that follows on the next line.
For those that use Dreammaker for some god awful reason you can search this file using the alphanumeric following the name of the body location.
I also ask that if you add to this list, include what you added in this guide at the top of the page, and cycle up the version number as you move down the list.
While github absolutely will track this PR, it helps whoever comes behind you to know who may have done what, or how many 'versions' their code may or may not be behind without needing to hunt that info down on git.a

Happy MERPING!  ~TK<3

//Prototypes 0A (Version 3)
	- Lick the Tip 0B1   First number is the group its in, 0 is prototype. A is iteration. 1 is the order of creation in the group.
	- Tip To Lip 0B2
	- Eager Reciever 0B3

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
	simple_sounds = null
	max_distance = 1

	help_messages = list(
		"XU_NAME gently licks at the tip of XT_NAME's cock.", 
	)
	disarm_messages = list(
		"XU_NAME playfully licks at the tip of XT_NAME's cock.", 
	)
	grab_messages = list(
		"XU_NAME licks at the tip of XT_NAME's cock, laying it on thick.", 
	)
	harm_messages = list(
		"XU_NAME aggressively licks at the tip of XT_NAME's cockhead like a lollipop.", 
	)

	simple_sounds = list('sound/effects/lick.ogg') // frumf, frumf
	user_lust_mult = 1
	lust_go_to = LUST_USER | LUST_TARGET

///////LICK THE TIP END/////////

////////////////////
//Tip To Lip 0A2////
////////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/recieving/tip_to_lip
	description = "Partner/Head - Rub tip on lips."
	simple_sounds = null
	max_distance = 1
	write_log_user = "rubbed their tip on someones lips." //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.


	help_messages = list(
		"XU_NAME gently presses the tip of their cock to XT_NAME's lips.", 
	)
	disarm_messages = list(
		"XU_NAME teasingly presses the tip of their cock to XT_NAME's lips.", 
	)
	grab_messages = list(
		"XU_NAME caresses the tip of their cock to XT_NAME's lips.", 
	)
	harm_messages = list(
		"XU_NAME pushes the tip of their cock to XT_NAME's lips, giving them just the tip.", 
	)

	simple_sounds = list('sound/effects/lick.ogg') // frumf, frumf
	user_lust_mult = 1
	lust_go_to = LUST_USER | LUST_TARGET

//////////////////////
//Eager Reciever 0A3//
//////////////////////
//Recieving Verb Prototype
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/mutual/eager_reciever
	description = "Partner/Head - Recieve Eagerly."
	simple_sounds = null
	max_distance = 1
	write_log_user = "is really into something someone is doing to them." //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.
	help_messages = list(
		"XU_NAME seems to like what XT_NAME's doing to them.", 
		"XU_NAME is eager to recieve what XT_NAME's doing to them.",
		"XU_NAME is seemingly down for whatever XT_NAME's doing",
		"XU_NAME eagerly takes what XT_NAME's is serving up",
	)
	disarm_messages = list(
		"XU_NAME definitely likes what XT_NAME's doing to them.",
		"XU_NAME is very eager to take what XT_NAME's putting down on them.",
		"XU_NAME is totally down for whatever XT_NAME's doing",
		"XU_NAME eagerly takes what XT_NAME's is serving up",
	)
	grab_messages = list(
		"XU_NAME <b>REALLY</b> likes what XT_NAME's doing to them.",
		"XU_NAME is <b>DOWN BAD</b> to take what XT_NAME's putting down on them.",
		"XU_NAME is <b>absolutely losing it</b> for whatever XT_NAME's doing",
		"XU_NAME is taking what XT_NAME is serving up like a <b>CHAMPION</b>",
	)
	harm_messages = list(
		"XU_NAME <b>IS LOSING IT</b> from what XT_NAME's doing to them.",
		"XU_NAME is <b>NOT GONNA LAST LONG</b> taking it like that from XT_NAME",
		"XU_NAME is <b>barely even mentally there</b> for whatever XT_NAME's doing",
		"XU_NAME is <b>gonna checkout</b> quick from XT_NAME actions at this rate",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	) // frumf, frumf
	user_lust_mult = 0.5
	lust_go_to = LUST_USER | LUST_TARGET



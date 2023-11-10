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

	help_messages = list("
		"XU_NAME {gently pushes, softly applies, tenderly exerts, delicately presses, lightly presses, subtly teases, carefully nudges, lightly laps with, lightly depresses, tactfully licks, soothingly mlems, cautiously tastes with, affectionately teases} \
		XU_THEIR \
		{gentle, warm, tender, soft, wet, delicate, smooth, velvet, caressing, silken} \
		{tongue, licker, flavor finder, yapper, talker, speech maker, chatterbox, mouth, kisser} \
		{against, onto, upon, up against, in contact with, up to} \
		's' cockhead, \
		{moistening it, dampening it, wetting it, saturating it, soaking it, hydrating it, making it wet, adding moisture, drenching it, getting it wet}. \
		{as XU_THEY drag XU_THEIR tongue across it, as XU_THEY lap at it, as XU_THEY mlems it, as XU_THEY suckles on it, as XU_THEY teases it, as XU_THEY play with it} \
		{playfully, merrily, cheerfully, lightheartedly, joyfully, happily, jovially, lewdly, mischievously, deviously}"
	)
	disarm_messages = list(
		"XU_NAME {swirls, dragss, twirls, spirals, mlems} \
		XU_THEIR \
		{tongue, licker, flavor finder, yapper, talker, speech maker, chatterbox, mouth, kisser} \
		{around, about, circling, all around} \
		XT_NAME's cockhead, \
		{: moistening it, : dampening it, : wetting it, : saturating it, : soaking it, : hydrating it, : making it wet, : adding moisture, : drenching it, : getting it wet} \
		{as XU_THEY drag XU_THEIR tongue across it, as XU_THEY lap at it, as XU_THEY mlems it, as XU_THEY suckles on it, as XU_THEY teases it, as XU_THEY play with it} \
		{lewdly, suggestively, provocatively, immodestly, inappropriately, obscenely, indecently, risquély, enticingly, salaciously}
	)

	grab_messages = list(
		"XU_NAME {takes, grabs, snatches, steals, buries, appropriates, procures, gains, gets} \
		XT_NAME's cockhead \
		{into XU_THEIR mouth, against XU_THEIR tongue, inside XU_THEIR mouth and lets XU_THEIR tongue, within XU_THEIR lips, in XU_THEIR maw, inside XU_THEIR gob} \
		{swirling, whirling, twisting, spiraling, whirlpooling, twirling, circling, spinning, churning} \
		XU_THEIR \
		{tongue, licker, flavor finder, mouth, kisser,} \
		as they work to \
		{please XT_THEM, satisfy XT_THEM, gratify XT_THEM, delight XT_THEM, fulfill [p_their] desires, bring XT_THEM pleasure, make XT_THEM happy, meet XT_THEM needs, give XT_THEM satisfaction, appease XT_THEM, get XT_THEM off, make XT_THEM cum, make XT_THEM climax}"
	)
	harm_messages = list(
			"XU_NAME is \
			{suckling on, nursing on, slurping on, drawing everything XU_THEY from, sipping from, tenderly nursing on, gently suckling on, savoring while suckling on)]} \
			XT_NAME's \
			cockhead \
			like XU_THEIR life depends on it!"
	)

	simple_sounds = list('modular_sand/sound/interactions/champ_fingering.ogg') // frumf, frumf
	lust_mult = 1

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


	help_messages = list("
		"XU_NAME {gently pushes, softly applies, tenderly exerts, delicately presses, lightly presses, subtly teases, carefully nudges, lightly laps with, lightly depresses, tactfully licks, soothingly mlems, cautiously tastes with, affectionately teases} \
		XU_THEIR \
		cockhead to \
		XT_NAME's \
		{lips, kisser, mouth, kissing zone, smoocher}"
	)
	disarm_messages = list(
		"XU_NAME {teases the, playfully taunts the, teasingly flirts with the, provocatively tempts the, coquettishly allures the, mischievously tantalizes the, seductively entices the, flirtatiously beguiles the, enticingly provokes the, charmingly lures the} \
		{tip of, end of, point of, top of, apex of, summit of, vertex of, peak of, pinnacle of, zenith of} \
		XU_THEIR \
		cockhead \
		{around, about, approximately, roughly, circling around, in the vicinity of, near, close to} \
		and \
		{in, inside, within, within the confines of, inside of, amidst} \
		XT_NAME's \
		{soft and wet, gentle and moist, tender and damp, smooth and soaked, juicy and soft, delicate and dewy, silky and saturated, supple and moist} \
		{lips, kisser, mouth, kissing zone, smoocher}"
	)
	grab_messages = list(
		"XU_NAME {firmly pushes, strongly presses, forcibly thrusts, steadily shoves, powerfully propels, assertively drives, solidly propels, resolutely thrusts, vigorously moves, determinedly applies force} \
		XT_NAME's \
		lips apart with \
		XU_THEIR \
		cockhead: \
		{using their mouth as a playtoy, playfully employing their lips and tongue to pleasure themselves, making a game of their oral actions, using their oral cavity as a source of pleasure, treating their mouth as a fun toy, playfully toying with their lips and tongue, utilizing their mouth for their own sexual pleasures}"
	)
	harm_messages = list(
		"XU_NAME is \
		{forcing, compelling, coercing, pressuring, driving, pushing, obliging, mandating, requiring, imposing} \
		XT_NAME to \
		{suckle on, nurse on, savor on, lick on, mlem on, drool on, taking} \
		XU_THEIR \
		cock \
		by force: \
		{using their mouth as a playtoy, playfully employing their lips and tongue to pleasure themselves, making a game of their oral actions, using their oral cavity as a source of pleasure, treating their mouth as a fun toy, playfully toying with their lips and tongue, utilizing their mouth for their own sexual pleasures}"
	)

	simple_sounds = list('sound/effects/lick.ogg') // frumf, frumf
	lust_mult = 1

///////TIP TO LIP END/////////


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
	help_messages = list("
		"XT_NAME seems to like what XU_NAME's doing to XT_THEM", 
		"XT_NAME is eager to recieve what XU_NAME's doing to XT_THEM",
		"XT_NAME is seemingly down for whatever XU_NAME's doing",
		"XT_NAME eagerly takes what XU_NAME's is serving up",	)
	disarm_messages = list(
		"XT_NAME definitely likes what XU_NAME's doing to XT_THEM", 
		"XT_NAME is very eager to take what XU_NAME's putting down on XT_THEM",
		"XT_NAME is totally down for whatever XU_NAME's doing",
		"XT_NAME eagerly takes what XU_NAME's is serving up",	)
	grab_messages = list(
		"XT_NAME <b>REALLY</b> likes what XU_NAME's doing to XT_THEM", 
		"XT_NAME is <b>DOWN BAD</b> to take what XU_NAME's putting down on XT_THEM",
		"XT_NAME is <b>absolutely losing it</b> for whatever XU_NAME's doing",
		"XT_NAME is taking what XU_NAME is serving up like a <b>CHAMPION</b>",	)
	harm_messages = list(
		"XT_NAME <b>IS LOSING IT</b> from what XU_NAME's doing to XT_THEM", 
		"XT_NAME is <b>NOT GONNA LAST LONG</b> taking it like that from XU_NAME",
		"XT_NAME is <b>barely even mentally there</b> for whatever XU_NAME's doing",
		"XT_NAME is <b>gonna checkout</b> quick from XU_NAME actions at this rate",	)

	simple_sounds = list('sound/effects/lick.ogg') // frumf, frumf
	lust_mult = 1


////////////
//VERBOSITY//
////////////
//Remember to change this                   VVVV
/datum/interaction/lewd/partner/mutual/eager_reciever/interaction_message(mob/living/user, mob/living/partner, show_message) //The main interaction system, this populates the information in the tgui window.
									//Pronoun storage//
//You can comment these back in to use if you need to use them. This is the full list.
//Uses the 'temp_gender' system to determine if he or she, or they, should be used. Defined by characters GENDER, not body model.

			//To uncomment these vars just remove the first / on the far left!
	//var/t_they = user.p_they() 	//example 'They shake their butt', if you use '[user.p_they] shake their butt' the code will print to chat 'He/she/they/it shake their butt.' Not the best example, but hopefully you get the idea.
	// var/t_their = user.p_their() 	//example 'They shake [user.p_their] butt.' becaomes 'They shake his/her/their butt.'
	var/t_them = user.p_them()	 //example 'Them over there' becomes 'Her/him/them over there', probably not the most useful, but who knows.
	//var/t_have = user.p_have() 	// If gender is neuter then this sets 'has' to 'have'.  So you can have 'he/she/them has/have shaken his/her/their butt.'
	//var/t_are = user.p_are() 		// If gender is neuter then this sets is to are. 'He/she/them is/are cooking eggs.'
	//var/t_were = user.p_were()	// If gender is neuter then this sets was to were. 'He/she/them was/were cooking eggs.'
	//var/t_do = user.p_do() 		// If gender is neuter then this sets do to does.  'He/she/they/it do/does not know'
	
	//A big example of this combined together follows.
	// "XU_THEY [t_have] XU_THEIR work cut out for XT_THEM."
	// This can print out as, "He has his work cut out for him." // Or // "She has her work cut out for her." // Or // "They have their work cut out for them."
	//It does require a bit of forethought, but there you have it.
	var/message
	//Message block A
	//help intent should be gentle, downright even loving and probably the opener for situations
	if(user.a_intent == INTENT_HELP)	//The USER of the verbs intent, only the pitcher gets to determine how hard they throw.
		message = pick(

			)

			//Message block B
	//disarm intent should be used for being particularly playful with the interaction
	else if(user.a_intent == INTENT_DISARM)
		message = pick(

			)

	//Message block C
	//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
	else if(user.a_intent == INTENT_GRAB)
		message = pick(

			)

		//Message block D
	//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
	if(user.a_intent == INTENT_HARM)
		message = pick(

			)


	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())	
	playlewdinteractionsound(get_turf(user), pick(//This line lets you pick what sound plays when you use the action, I'm really unsure why it exists along with the simple_sounds var?  Probably just an improved version. That 50 is volume.
					'modular_sand/sound/interactions/bang1.ogg',
					'modular_sand/sound/interactions/bang2.ogg',
					'modular_sand/sound/interactions/bang3.ogg'), 
					70, 1, -1)
	partner.handle_post_sex(lust_amt[user.a_intent]/2) //For determining that the USERS intent is how much LUST the RECEIVER is getting. You can put math before the parenthesis to adjust how much lust you want to give. ie *2), or /2) for twice or half as much.
	
	user.handle_post_sex(lust_amt[user.a_intent]/2) //So, this is included for information purposes.  It determines a lot of different things. (amount of arousal built up (no longer defined here, but we still need this information!), orifice, mob/living/partner)
///////EAGER RECIEVER END/////////

// CB does it better, Doritos(r) Dew(r) it right





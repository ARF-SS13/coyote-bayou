////////////////////////
//COYOTE SELF VERBS   //
///////////////////////

/datum/interaction/lewd/self // hi
	is_self_action = TRUE // is self action

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

//Use ctrl+f to search for the words step 1 thru 9. You can jump directly to where those steps are in the code with that. Realize that 10-13 are actions you'll be taking, not code you're writing.
//////////////
//Rub Crotch// Step 1
//////////////
//Crotch rub will be our prototype emote, I will comment the shit out of it to make things make the most sense to a newbie.
//Remember to change this VVVV
/datum/interaction/lewd/self/rub_crotch //lewd makes it pink, the name is just what the code calls it. Step 2 on this line.  Step 3 is just below it.
	description = "Self/Crotch - Rub Crotch." //This naming convention is to help players who want to filter functions. In this case its Self, as in, yourSELF, and a function of the 'area' crotch.  Then it describes what you're doing to the area.
	/// Step 1.5: Add in the categories its supposed to be in! you can find these in [code\__DEFINES\voreconstants.dm] (srsly)
	/// Include ICAT_LEWD if it is lewd
	// Self/Partner for the left hand side.
	// Head/Neck/Body/Arms/Stomach/Crotch/Thighs/Legs/Tail for the right hand side.
	/// Step 2 (actually 4) - the messages!
	/// THis is a list of strings that are picked from
	help_messages = list(
		"XU_NAME gently rubs at the XU_THEIR own crotch.", 
		// "Hi hey uh {bip, baap, fwiem, weem} BAAAA {du, 63748, .fwrvj, a}Spunk {Q}Scorn{}SCALES"
	)
	disarm_messages = list(
		"XU_NAME teasingly rubs at the XU_THEIR own crotch.", 
	)
	grab_messages = list(
		"XU_NAME heavily rubs at the XU_THEIR own crotch.", 
	)
	harm_messages = list(
		"XU_NAME hornily rubs at the XU_THEIR own crotch.", 
	)


	/// Step 3 (actually 12) - the sounds!
	/// This is a list of sounds that are picked from
	help_sounds = list('modular_sand/sound/interactions/champ_fingering.ogg') // sounds in help intent
	disarm_sounds = list() // if any of these are blank, they will be replaced with the help intent sounds
	grab_sounds = list() // if help_sounds is blank? just wont play a sound, no big
	harm_sounds = list() // So that fingering sound? it'll play on all of these, but you can change it to be different if you want

	/// Step 4 (actually 4) - the span!
	/// This is a list of strings that are picked from
	help_span = "love" // span in help intent, should have something, though it'll default to the blue notice span if not
	disarm_span = "love" // if any of these are blank, they will be replaced with the help intent span
	grab_span = null // this'll be love, cus it defaults to help_span
	harm_span = null // as will this
	/// though, lewd interactions default to "love", cus, thats what it do, it love

	/// BUT DAN, THATS A LOT OF STUFF, I WANNA JUST MAKE A SIMPLE EMOTE
	/// well lookie here, its a simple emote!
	/// if this is set with a list of messages, they'll be ognomatically added to help_messages, help_sounds, and help_span
	/// Just be sure to leave the other lists blank, otherwise it wont work
	/// alternatively you could just set help_messages and call it a day, but this is here for convenience
	simple_messages = list()
	simple_sounds = list()
	simple_span = null

	/// Step 5 (actually 4) - is_visible_to_allity!
	/// If is_visible_to_all is set to TRUE, it'll broadcast the message and sound to everyone in view range
	/// If is_visible_to_all is set to FALSE, it'll only broadcast the message and sound to everyone in your consent chain!
	/// whats a consent chain? its a list of people who have consented to your ERP, and everyone they consented, and everyone they consented, etc
	/// if A consents to B, and B consents to C, and B consents to D, then the interaction will be sent to A, B, C, and D. cool huh?
	is_visible_to_all = FALSE // Lewd interactions should not be is_visible_to_all, though they'll be suppressed for anyone with the prefs set to be off

	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	is_self_action = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.
	write_log_user = "rubbed their crotch" //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.





//////////////
//Rub Behind// 
//////////////
//Remember to change this VVVV
/datum/interaction/lewd/self/rub_behind //lewd makes it pink, the name is just what the code calls it.
	description = "Self/Crotch - Rub Behind." //This naming convention is to help players who want to filter functions. In this case its Self, as in, yourSELF, and a function of the 'area' crotch.  Then it describes what you're doing to the area.
	// Self/Partner for the left hand side.
	// Head/Neck/Body/Arms/Stomach/Crotch/Thighs/Legs/Tail for the right hand side.
	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	is_self_action = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.
	write_log_user = "rubbed their backside." //The log for the interactiont to show admins if, for some insane reason, they need to look up what you have done to yourself/others. Probably not needed with OUR community, but I can see the logic behind wanting it. 
	write_log_target = null //There's no target in this case, because the user is the target. If there was you'd write it out the same as write_log_user, like 'was fingered by someone' or something similar.

	help_messages = list("XU_NAME lightly rubs XU_THEIR backside.")
	disarm_messages = list("XU_NAME is really rubbing at XU_THEIR own rear end.")
	grab_messages = list("XU_NAME is rubbing XU_THEIR backside pretty aggressively!")
	harm_messages = list("XU_NAME rubs XU_THEIR butt aggressively!", "XU_NAME mauls XU_THEIR own butt with attention!")

	simple_sounds = list('sound/weapons/thudswoosh.ogg') // frumf, frumf
	user_lust_mult = 0.4


/////////////////
//Squirm Lewdly//
////////////////
/datum/interaction/lewd/self/lewd_squirm
	description = "Self/Crotch - Squirm lewdly."

	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	is_self_action = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.

	help_messages = list("XU_NAME very lightly squirms.", "XU_NAME squirms ever so slightly.")
	disarm_messages = list("XU_NAME is being a little squirmy.", "XU_NAME squirms a bit.")
	grab_messages = list("XU_NAME is squirming a lot!", "XU_NAME is really squirming!")
	harm_messages = list("XU_NAME is squirming like crazy!", "XU_NAME can't seem to stop themselves from squirming!")

	simple_sounds = list(
		'sound/effects/rustle1.ogg',
		'sound/effects/rustle2.ogg',
		'sound/effects/rustle3.ogg',
		'sound/effects/rustle4.ogg',
		'sound/effects/rustle5.ogg',
	) // frumf, frumf
	user_lust_mult = 0.4

////////////////////
//Dirty Talk - Soft//
////////////////////
/datum/interaction/lewd/self/dirtytalksoft
	description = "Self/Crotch - Talk dirty (tame)."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	is_self_action = TRUE
	max_distance = 0

	help_messages = list(
		"XU_NAME sucks air in as XU_THEY curse softly, \"Shit-\"",
		"XU_NAME gasps for air, letting out a, \"Oh fuck-\"",
		"XU_NAME moans quietly through clenched teeth, \"Yes-\"",
		"XU_NAME softly whispers, \"More-\"",
		"XU_NAME quietly pleads, \"Fuck yes-\"",
		"XU_NAME begs quietly, \"Don't stop-\"",
	)
	disarm_messages = list(
		"XU_NAME eagerly gasps, \"Shit-\"",
		"XU_NAME teasingly growls, \"Oh fuck-\"",
		"XU_NAME moans, \"Yes-\"",
		"XU_NAME brokenly manages to say, \"More-\"",
		"XU_NAME pleads, \"Fuck yes-\"",
		"XU_NAME begs, \"Don't stop-\"",
	)
	grab_messages = list(
		"XU_NAME gasps hard, sucking air before cursing, \"Shit-\"",
		"XU_NAME growls, \"Oh fuck-\"",
		"XU_NAME lets out a barely controlled moan, \"Yes-\"",
		"XU_NAME just about can't even talk as XU_THEY say, \"More-\"",
		"XU_NAME is shaking as XU_THEY exclaim, \"Fuck yes-\"",
		"XU_NAME can't stop from saying, \"Don't stop-\"",
	)
	harm_messages = list(
		"XU_NAME stops themselves short of yelling, \"Shit-\"",
		"XU_NAME doesn't quite bite off the curse as XU_THEY moan, \"Oh fuck-\"",
		"XU_NAME lets out a full body moan of pleasure, \"Yes-\"",
		"XU_NAME can't keep their breath as they plead, \"More-\"",
		"XU_NAME legs shake as they reflexively respond, \"Fuck yes-\"",
		"XU_NAME pleads as if they are nearly broken, \"Don't stop-\"",
	)
	user_lust_mult = 0.4



/////////////////
//Rub Clit//
////////////////
/datum/interaction/lewd/self/rub_clit //lewd makes it pink, the name is just what the code calls it. Step 2 on this line.  Step 3 is just below it.
	description = "Self/Crotch - Rub your clitoris." //This naming convention is to help players who want to filter functions. In this case its Self, as in, yourSELF, and a function of the 'area' crotch.  Then it describes what you're doing to the area.
	// Self/Partner for the left hand side.
	// Head/Neck/Body/Arms/Stomach/Crotch/Thighs/Legs/Tail for the right hand side.
	simple_sounds = null //Does this emote have a sound attached?  This defaults to the parent at lewd_interactions.dm line 7 and can be replaced to make this action always make a sound!
	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	is_self_action = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.
	help_messages = list(
		"XU_NAME is {gently, softly, lovingly, warmly} {rubbing, teasing, playing with} XU_THEIR {clit, love button, butterbean, clitoris, pleasure button}.",
		"XU_NAME {rubs, teases, plays with} XU_THEIR {clit, love button, butterbean, clitoris, pleasure button} {gently, softly, lovingly, warmly} in small circles.",
		"XU_NAME presses {two fingers, their fingers} to XU_THEIR {clit, love button, butterbean, clitoris, pleasure button} and {rubs, teases, plays with} {gently, softly, lovingly, warmly}.",
		"XU_NAME {gently, softly, lovingly, warmly} {rubs, teases, plays with} XU_THEIR {clit, love button, butterbean, clitoris, pleasure button}.",
	)
	disarm_messages = list(
		"XU_NAME rubs XU_THEIR clit teasingly",
		"XU_NAME rubs XU_THEIR little love nub",
		"XU_NAME presses down gently on XU_THEIR pleasure button",
	)
	grab_messages = list(
		"XU_NAME vigoriously rubs XU_THEIR hard clit",
		"XU_NAME rubs XU_THEIR bean like they mean it",
		"XU_NAME is downright bullying XU_THEIR own little happy button",
	)
	harm_messages = list(
		"XU_NAME is downright abusing XU_THEIR clit",
		"XU_NAME rubs XU_THEIR butter bean hard",
		"XU_NAME is rubbing XU_THEIR lovebud aggressively",
	)
	simple_sounds = list('sound/weapons/thudswoosh.ogg') // yes it the use bag sound, eat me
	user_lust_mult = 0.6


/////////////////
//Jerk Hard/////
////////////////
/datum/interaction/lewd/self/jerk_hard //lewd makes it pink, the name is just what the code calls it. Step 2 on this line.  Step 3 is just below it.
	description = "Self/Crotch - Jerk yourself off hard." //This naming convention is to help players who want to filter functions. In this case its Self, as in, yourSELF, and a function of the 'area' crotch.  Then it describes what you're doing to the area.
	// Self/Partner for the left hand side.
	// Head/Neck/Body/Arms/Stomach/Crotch/Thighs/Legs/Tail for the right hand side.
	simple_sounds = null //Does this emote have a sound attached?  This defaults to the parent at lewd_interactions.dm line 7 and can be replaced to make this action always make a sound!
	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	is_self_action = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.
	help_messages = list(
		"XU_NAME is rubbing XU_THEIR cock",
		"XU_NAME rubs XU_THEIR cock excitedly",
		"XU_NAME is cranking XU_THEIR meat",
		"XU_NAME is fucking XU_THEIR fist",
	)
	disarm_messages = list(
		"XU_NAME is really beating XU_THEIR cock",
		"XU_NAME is trying to speedrun jerking off",
		"XU_NAME cranks XU_THEIR rod hard",
		"XU_NAME is fucking XU_THEIR fist like it owes them money",
	)
	grab_messages = list(
		"XU_NAME is gonna hurt themselves beating XU_THEIR cock that hard",
		"XU_NAME is trying to speedrun jerking off, and looks like they're going to get a new best time",
		"XU_NAME cranks XU_THEIR rod hard like they've got a marlin on the other end",
	)
	harm_messages = list(
		"XU_NAME looks like they're having a sidestich from themselves beating XU_THEIR cock so hard",
		"XU_NAME makes a noise as a calf muscle begins to crank from all the extertion they're putting in from just beating their meat",
	)
	simple_sounds = list(
		'sound/effects/rustle1.ogg',
		'sound/effects/rustle2.ogg',
		'sound/effects/rustle3.ogg',
		'sound/effects/rustle4.ogg',
		'sound/effects/rustle5.ogg',
	) // frumf, frumf
	user_lust_mult = 1.2

//////////////////////////
//Play with own nips/////
////////////////////////
/datum/interaction/lewd/self/nip_play //lewd makes it pink, the name is just what the code calls it. Step 2 on this line.  Step 3 is just below it.
	description = "Self/Crotch - Play with your nipples." //This naming convention is to help players who want to filter functions. In this case its Self, as in, yourSELF, and a function of the 'area' crotch.  Then it describes what you're doing to the area.
	// Self/Partner for the left hand side.
	// Head/Neck/Body/Arms/Stomach/Crotch/Thighs/Legs/Tail for the right hand side.
	simple_sounds = null //Does this emote have a sound attached?  This defaults to the parent at lewd_interactions.dm line 7 and can be replaced to make this action always make a sound!
	require_user_hands = TRUE //True or false, you have to have hands to do whatever this action is.
	is_self_action = TRUE //Is the user of this verb the target of it?  This is what defines if the verb is a 'self' verb.  If its for use on others you should set it to false.  Then remember to set range! Some things, like winking, can be done at a distance!
	max_distance = 0 //The max distance you can use this verb on others, starts on the tiles AROUND the player, so thusly it includes the players own tile.
	help_messages = list(
		"XU_NAME is rubbing XU_THEIR nipples in small circles",
		"XU_NAME rubs XU_THEIR nipples softly",
		"XU_NAME gently pulls XU_THEIR own nipples",
		"XU_NAME gently pinches XU_THEIR own nipples",
	)
	disarm_messages = list(
		"XU_NAME playfully pulls at XU_THEIR nipples",
		"XU_NAME arches XU_THEIR back as they pull their own nipples",
		"XU_NAME pinches XU_THEIR own nipples playfully",
		"XU_NAME pinches XU_THEIR own teat",
		"XU_NAME twists at XU_THEIR teats teasingly",
	)
	grab_messages = list(
		"XU_NAME grabs XU_THEIR own nipples and pulls",
		"XU_NAME pinches XU_THEIR nipples hard, their color changing slightly",
		"XU_NAME twists XU_THEIR own nipples to the point of pain",
	)
	harm_messages = list(
		"XU_NAME is playing so rough with XU_THEIR nipples they have to be just as much in pain as they are enjoying it",
		"XU_NAME twists and pulls XU_THEIR nipples aggressively, clearly enjoying the pain",
	)
	simple_sounds = list(
		'sound/effects/rustle1.ogg',
		'sound/effects/rustle2.ogg',
		'sound/effects/rustle3.ogg',
		'sound/effects/rustle4.ogg',
		'sound/effects/rustle5.ogg',
	) // frumf, frumf
	user_lust_mult = 1.2

//////////////////////////
//Autofellate/////
////////////////////////
/datum/interaction/lewd/self/autofellate
	description = "Self/Crotch - Suck yourself off."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	is_self_action = TRUE
	max_distance = 0

	help_messages = list(
		"XU_NAME drags XU_THEIR tongue across the head of XU_THEIR own endowment.",
	)
	disarm_messages = list(
		"XU_NAME fills XU_THEIR cheek out with the shape of XU_THEIR own cock.",
	)
	grab_messages = list(
		"XU_NAME noisily, messily bobs up and down XU_THEIR own length",
	)
	harm_messages = list(
		"XU_NAME gags themselves as XU_THEIR deepthroats XU_THEIR own cock",
	)
	user_lust_mult = 0.8


//Head-1A (Version 4)
//	- French Kiss 1A1 - Mutual - Low Intensity
//	- Ear Bite 1A2 - Giving - Low to Medium Intensity 
//	- Lip Nibble 1A3 - Mutual - Low Intensity
//	- Face Nuzzle 1A4 - Mutual - Low Intensity

//////////////////////
//French Kissing 1A1//
//////////////////////
/datum/interaction/lewd/partner/giving/french_kiss
	description = "Partner/Head - French Kiss."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently teases XU_THEIR tongue into XT_NAME's mouth.",
	)
	disarm_messages = list(
		"XU_NAME playfully teases XU_THEIR tongue around inside XT_NAME's mouth.",
	)
	grab_messages = list(
		"XU_NAME is downright trying to bully XT_NAME's tongue in a sloppy french kiss.",
	)
	harm_messages = list(
		"XU_NAME might as well be boxing XT_NAME's uvula they're kissing them so deep!",
	)

	simple_sounds = list(
		'sound/effects/kiss.ogg'
	) // frumf, frumf
	user_lust_mult = 0.5 // set this to how much lust should be given
	target_lust_mult = 0.5
	lust_go_to = LUST_USER | LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////FRENCH KISS END/////////


////////////////////
//Ear Bite 1A2//
////////////////////
/datum/interaction/lewd/partner/giving/ear_bite
	description = "Partner/Head - Bite their ear."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently nibbles XT_NAME's ear.",
	)
	disarm_messages = list(
		"XU_NAME playfully bites XT_NAME's ear.",
	)
	grab_messages = list(
		"XU_NAME bites into XT_NAME's ear!",
	)
	harm_messages = list(
		"XU_NAME really bites down hard onto XT_NAME's ear! Ow!",
	)

	simple_sounds = list(
		'sound/weapons/bite.ogg'
	)
	target_lust_mult = 0.8
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////EAR BITE END/////////

////////////////
//Lip Bite 1A3//
////////////////
/datum/interaction/lewd/partner/giving/lip_bite
	description = "Partner/Head - Bite their lower lip."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently nibbles XT_NAME's lower lip.",
	)
	disarm_messages = list(
		"XU_NAME playfully uses XU_THEIR teeth to bite on XT_NAME's lower lip.",
	)
	grab_messages = list(
		"XU_NAME bites down possessively on XT_NAME's lower lip!",
	)
	harm_messages = list(
		"XU_NAME sinks their teeth into XT_NAME's lower lip hard!",
	)

	simple_sounds = list(
		'sound/weapons/bite.ogg'
	) // frumf, frumf
	target_lust_mult = 0.8
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////LIP BITE END/////////


///////////////////
//Face Nuzzle 1A4//
///////////////////
/datum/interaction/lewd/partner/giving/face_nuzzle
	description = "Partner/Head - Nuzzle their face."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME gently nuzzles XU_THEIR face against XT_NAME's face.",
	)
	disarm_messages = list(
		"XU_NAME playfully nuzzles XU_THEIR face against XT_NAME's face.",
	)
	grab_messages = list(
		"XU_NAME needily nuzzles XU_THEIR face against XT_NAME's face.",
	)
	harm_messages = list(
		"XU_NAME aggressively nuzzles XU_THEIR face against XT_NAME's face!",
	)

	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg', // then set this to the sound you want to play (its alrady set)
	) // frumf, frumf
	user_lust_mult = 0.5 // set this to how much lust should be given
	target_lust_mult = 0.5
	lust_go_to = LUST_USER | LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
///////FACE NUZZLE END/////////


//////////////////////////////
//Facefuck them (cock)  1A5///
//////////////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/facefuckthem_cock
	description = "Partner/Head - Facefuck them with your cock."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME gently teases the hole in the back of XT_NAME's mouth with their cock.",
	)
	disarm_messages = list(
		"XU_NAME playfully penetrates the hole in the back of XT_NAME's mouth with their cock.",
	)
	grab_messages = list(
		"XU_NAME downright fucks the hole in the back of XT_NAME's mouth with their cock.",
	)
	harm_messages = list(
		"XU_NAME is fucking XT_NAME's mouth like a pussy.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/oral2.ogg',
		'modular_sand/sound/interactions/bj2.ogg',
		'modular_sand/sound/interactions/bj6.ogg',
		'modular_sand/sound/interactions/bj7.ogg',
		'modular_sand/sound/interactions/bj8.ogg',
		'modular_sand/sound/interactions/bj9.ogg',
	) // frumf, frumf
	user_lust_mult = 1.1
	target_lust_mult = 0.2

//////////////////////////////
//Facefuck them (pussy) 1A6///
//////////////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/facefuckthem_pussy
	description = "Partner/Head - Mouthfuck them with your pussy."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME gently teases their feminine hole against XT_NAME's mouth.",
	)
	disarm_messages = list(
		"XU_NAME playfully presses their feminine hole against XT_NAME's mouth.",
	)
	grab_messages = list(
		"XU_NAME grinds their feminine hole against XT_NAME's mouth.",
	)
	harm_messages = list(
		"XU_NAME needily humps XT_NAME's mouth with their feminine hole.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/bj2.ogg',
		'modular_sand/sound/interactions/bj6.ogg',
		'modular_sand/sound/interactions/bj7.ogg',
		'modular_sand/sound/interactions/bj8.ogg',
		'modular_sand/sound/interactions/bj9.ogg',
	) // frumf, frumf
	user_lust_mult = 1.1
	target_lust_mult = 0.2

////////////////////////
//Throatfuck them 1A7///
////////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/throatfuck_them
	description = "Partner/Head - Fuck their throat with your cock."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME presses XU_THEIR cock down XT_NAME's throat for a moment.",
	)
	disarm_messages = list(
		"XU_NAME presses XU_THEIR cock down XT_NAME's throat with force.",
	)
	grab_messages = list(
		"XU_NAME fucks XT_NAME's throat like a toy.",
	)
	harm_messages = list(
		"XU_NAME bobs XT_NAME's head on XU_THEIR cock like they're dribbling a basketball.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/oral2.ogg',
		'modular_sand/sound/interactions/bj2.ogg',
		'modular_sand/sound/interactions/bj6.ogg',
		'modular_sand/sound/interactions/bj7.ogg',
		'modular_sand/sound/interactions/bj8.ogg',
		'modular_sand/sound/interactions/bj9.ogg',
	) // frumf, frumf
	user_lust_mult = 1.1
	target_lust_mult = 0.3

////////////////////////
//Ass to face 1A8///
////////////////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/facesitting
	description = "Partner/Head - Sit on their face."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME softly presses XU_THEIR backside down on XT_NAME's face.",
	)
	disarm_messages = list(
		"XU_NAME teasingly places XU_THEIR backside down on XT_NAME's face.",
	)
	grab_messages = list(
		"XU_NAME grinds XU_THEIR backside on XT_NAME's face.",
	)
	harm_messages = list(
		"XU_NAME is just about smothering XT_NAME with XU_THEIR backside."
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/bj2.ogg',
		'modular_sand/sound/interactions/bj6.ogg',
		'modular_sand/sound/interactions/bj7.ogg',
		'modular_sand/sound/interactions/bj8.ogg',
		'modular_sand/sound/interactions/bj9.ogg',
	) // frumf, frumf
	user_lust_mult = 0.8
	target_lust_mult = 0.3

///////////////
//Kisses 1A9///
///////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/kissing
	description = "Partner/Head - Give them kisses."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME softly presses XU_THEIR lips together with XT_NAME's.",
	)
	disarm_messages = list(
		"XU_NAME teasingly kisses XT_NAME.",
	)
	grab_messages = list(
		"XU_NAME kisses XT_NAME whole heartedly.",
	)
	harm_messages = list(
		"XU_NAME kisses XT_NAME deeply.",
	)

	simple_sounds = list(
		'sound/effects/kiss.ogg'
	) // frumf, frumf
	user_lust_mult = 0.1
	target_lust_mult = 0.1

///////////////
//Teabag 1A9///
///////////////
//Remember to change this                 VVVV
/datum/interaction/lewd/partner/giving/nuts_to_face
	description = "Partner/Head - Put your nuts on their face."
	require_user_hands = TRUE
	max_distance = 1
	help_messages = list(
		"XU_NAME presses XU_THEIR balls to XT_NAME's face softly.",
	)
	disarm_messages = list(
		"XU_NAME smushes XU_THEIR balls against XT_NAME's face playfully.",
	)
	grab_messages = list(
		"XU_NAME presses XU_THEIR balls to XT_NAME's face possessively.",
	)
	harm_messages = list(
		"XU_NAME smushes XU_THEIR balls down hard against XT_NAME's face.",
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/foot_dry1.ogg',
		'modular_sand/sound/interactions/foot_dry2.ogg',
	) // frumf, frumf
	user_lust_mult = 0.1
	target_lust_mult = 0.1

////////////////////
//Good Boy 1A10//
////////////////////
/datum/interaction/lewd/mutual/good_boy
	description = "Partner/Head - Call them a good boy."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	max_distance = 1

	help_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {quietly, softly, gently, needily}, {\"Good boy-\",\"That a boy-\",\"Such a good boy-\",\"Good boy-\"}",
	)
	disarm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {playfully, teasingly}, {\"Good boy-\",\"That a boy-\",\"Such a good boy-\",\"Good boy-\"}",
	)
	grab_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {}, {\"Good boy-\",\"That a boy-\",\"Such a good boy-\",\"Good boy-\"}",
	)
	harm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {loudly, noisily, lustfully, as if begging}, {\"Good boy-\",\"That a boy-\",\"Such a good boy-\",\"Good boy-\"}",
	)
	user_lust_mult = 0.4
	target_lust_mult = 0.4
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)
////////////////////
//Good Girl 1A11//
////////////////////
/datum/interaction/lewd/mutual/good_girl
	description = "Partner/Head - Call them a good girl."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	max_distance = 1

	help_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {quietly, softly, gently, needily}, {\"Good girl-\",\"That a girl-\",\"Such a good girl-\",\"Good girl-\"}",
	)
	disarm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {playfully, teasingly}, {\"Good girl-\",\"That a girl-\",\"Such a good girl-\",\"Good girl-\"}",
	)
	grab_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {}, {\"Good girl-\",\"That a girl-\",\"Such a good girl-\",\"Good girl-\"}",
	)
	harm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {loudly, noisily, lustfully, as if begging}, {\"Good girl-\",\"That a girl-\",\"Such a good girl-\",\"Good girl-\"}",
	)
	user_lust_mult = 0.4
	target_lust_mult = 0.4
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)
////////////////////
//Praise them 1A12//
////////////////////
/datum/interaction/lewd/mutual/praise_them
	description = "Partner/Head - Praise them."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	max_distance = 1

	help_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {quietly, softly, gently, needily}, {\"Good stuff-\",\"That's it-\",\"So good-\",\"Good-\"}",
	)
	disarm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {playfully, teasingly}, {\"Good stuff-\",\"That's it-\",\"So good-\",\"Good-\"}",
	)
	grab_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {}, {\"Good stuff-\",\"That's it-\",\"So good-\",\"Good-\"}",
	)
	harm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {loudly, noisily, lustfully, as if begging}, {\"Good stuff-\",\"That's it-\",\"So good-\",\"Good-\"}",
	)
	user_lust_mult = 0.4
	target_lust_mult = 0.4
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)
////////////////////
//Play with their mouth 1A13//
////////////////////
/datum/interaction/lewd/mutual/mouth_play
	description = "Partner/Head - Play with their mouth."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	max_distance = 1

	help_messages = list(
		"XU_NAME gently teases their fingers into XT_NAME's mouth.",
	)
	disarm_messages = list(
		"XU_NAME gently plays inside XT_NAME's mouth with their fingers.",
	)
	grab_messages = list(
		"XU_NAME pushes their fingers into XT_NAME's mouth.",
	)
	harm_messages = list(
		"XU_NAME is mouth fucking XT_NAME with their fingers.",
	)
	user_lust_mult = 0.4
	target_lust_mult = 0.4
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)
////////////////////
//Beg to be bred, FE 1A14//
////////////////////
/datum/interaction/lewd/mutual/nesting_behavior
	description = "Partner/Head - Beg them to breed you, Feminine Edition."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	max_distance = 1

	help_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {quietly, softly, gently, needily}, {\"Breed me-\",\"Get me pregnant-\",\"Make me a mother-\"}",
	)
	disarm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {playfully, teasingly}, {\"Breed me-\",\"Get me pregnant-\",\"Make me a mother-\"}",
	)
	grab_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {}, {\"Breed me-\",\"Get me pregnant-\",\"Make me a mother-\"}",
	)
	harm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {loudly, noisily, lustfully, as if begging}, {\"Breed me-\",\"Get me pregnant-\",\"Make me a mother-\"}",
	)
	user_lust_mult = 0.6
	target_lust_mult = 0.5
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)

////////////////////
//Beg to be bred, ME 1A15//
////////////////////
/datum/interaction/lewd/mutual/nesting_behavior_butt
	description = "Partner/Head - Beg them to breed you, Butt Edition."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	max_distance = 1

	help_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {quietly, softly, gently, needily}, {\"Breed me-\",\"Get me butt pregnant-\"}",
	)
	disarm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {playfully, teasingly}, {\"Breed me-\",\"Get me butt pregnant-\"}",
	)
	grab_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {}, {\"Breed me-\",\"Get me butt pregnant-\"}",
	)
	harm_messages = list(
		"XU_NAME {praises, urges on} XT_NAME {loudly, noisily, lustfully, as if begging}, {\"Breed me-\",\"Get me butt pregnant-\"}",
	)
	user_lust_mult = 0.6
	target_lust_mult = 0.5
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)
////////////////////
//Play with their hair 1A16//
////////////////////
/datum/interaction/lewd/mutual/hair_play
	description = "Partner/Head - Play with their hair."
	simple_sounds = null
	require_user_hands = FALSE // yap yap
	max_distance = 1

	help_messages = list(
		"XU_NAME gently teases their fingers through XT_NAME's hair.",
	)
	disarm_messages = list(
		"XU_NAME gently plays with XT_NAME's hair.",
	)
	grab_messages = list(
		"XU_NAME pushes their fingers through XT_NAME's hair.",
	)
	harm_messages = list(
		"XU_NAME is absolutely grabbing at XT_NAME hair as they try to find a good hold.",
	)
	user_lust_mult = 0.4
	target_lust_mult = 0.4
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)

////////////////////
//Grab their ears//
////////////////////
/datum/interaction/lewd/partner/giving/ear_grab
	description = "Partner/Head - Grab their ear."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME {gently, playfully, eagerly} {grabs, takes, grips} XT_NAME's ear.",
	)
	disarm_messages = list(
		"XU_NAME {gently, playfully, eagerly} {grabs, takes, grips} XT_NAME's ear.",
	)
	grab_messages = list(
		"XU_NAME {gently, playfully, eagerly} {grabs, takes, grips} XT_NAME's ear.",
	)
	harm_messages = list(
		"XU_NAME {gently, playfully, eagerly} {grabs, takes, grips} XT_NAME's ear.",
	)

	target_lust_mult = 0.8
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)

////////////////////
//Pet their ear//
////////////////////
/datum/interaction/lewd/partner/giving/ear_pet
	description = "Partner/Head - Pet their ear."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME {gently, playfully, eagerly} {pets, touches, rubs, carresses} XT_NAME's ear.",
	)
	disarm_messages = list(
		"XU_NAME {gently, playfully, eagerly} {pets, touches, rubs, carresses} XT_NAME's ear.",
	)
	grab_messages = list(
		"XU_NAME {gently, playfully, eagerly} {pets, touches, rubs, carresses} XT_NAME's ear.",
	)
	harm_messages = list(
		"XU_NAME {gently, playfully, eagerly} {pets, touches, rubs, carresses} XT_NAME's ear.",
	)

	target_lust_mult = 0.6
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)

////////////////////
//Pull their hair//
////////////////////
/datum/interaction/lewd/partner/giving/hair_pull
	description = "Partner/Head - Pull their hair."
	require_user_hands = TRUE
	/// okay copy from here...
	help_messages = list(
		"XU_NAME {gently, playfully, eagerly} {pulls, tugs, grasps} XT_NAME's {hair, locks}.",
	)
	disarm_messages = list(
		"XU_NAME {teasingly, deviously, meanly} {pulls, tugs, grasps} XT_NAME's {hair, locks}.",
	)
	grab_messages = list(
		"XU_NAME possessively {yanks, pulls} XT_NAME's {hair, locks}.",
	)
	harm_messages = list(
		"XU_NAME {pulls, tugs, grasps} XT_NAME's {hair, locks} like a leash.",
	)

	target_lust_mult = 0.6
	lust_go_to = LUST_TARGET // and who should get the lust, its a bitfield! for both, it'd be LUST_USER | LUST_TARGET
	simple_sounds = list(
		'sound/f13effects/sunsetsounds/blush.ogg',
	)

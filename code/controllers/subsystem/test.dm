/* 
 * Filename: GropeKissMERP.dm
 * Author: GropeKiss
 * Date: Next Tuesday
 * Purpose: To make hand items that can grope and kiss and do other things to very specific body parts and such
 * 
 * these are singleton datums that hand items will ask to spit out some lovely text
 * 
 * HELP - mostly rubbing or loving actions
 * DISARM - mostly more playful teasing actions
 * GRAB - things involving more assertive or gropey actions
 * HARM - things that are more aggressive or painful
 * 
 * */

GLOBAL_LIST_EMPTY(gropekissers)
///Welcome to GropeKiss
/datum/grope_kiss_MERP
	/// accessible areas, by part, and by side
	/*
		for action tenses, format is: 
			I "suck" Tia's [toes], (present tense, user performing)
			Dan "sucks" my [toes], (present tense, target recieving)
			I continue "sucking" Tia's [toes] / Dan continues "sucking" my [toes], (continuous/gerundo)
			Dan "sucked" Tia's [toes], (past tense, third person)
	*/
	var/list/head_front = list("head")
	var/list/head_front_action_help = list(
		"pat", 
		"pats", 
		"patting", 
		"patted",
		)
	var/list/head_front_action_disarm = list(
		"stroke", 
		"strokes", 
		"stroking", 
		"stroked",
		)
	var/list/head_front_action_grab = list(
		"grab", 
		"grabs", 
		"grabbing", 
		"grabbed",
		)
	var/list/head_front_action_harm = list(
		"slap", 
		"slaps", 
		"slapping", 
		"slapped",
		)
	var/list/head_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/head_side = list("ear")
	var/list/head_side_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/head_side_action_disarm = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/head_side_action_grab = list(
		"tug on",
		"tugs on",
		"tugging on",
		"tugged on",
	)
	var/list/head_side_action_harm = list(
		"pinch",
		"pinches",
		"pinching",
		"pinched",
	)
	var/list/head_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/head_back = list("neck")
	var/list/head_back_action_help = list(
		"scritch the back of",
		"scritches the back of",
		"scritching the back of",
		"scritched the back of",
	)
	var/list/head_back_action_disarm = list(
		"massage",
		"massages",
		"massaging",
		"massaged",
	)
	var/list/head_back_action_grab = list(
		"squeeze",
		"squeezes",
		"squeezing",
		"squeezed",
	)
	var/list/head_back_action_harm = list(
		"choke",
		"chokes",
		"choking",
		"choked",
	)
	var/list/head_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/head_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	/// eyes are special
	var/list/eyes_front = list("eyes")
	var/list/eyes_front_action_help = list(
		"gaze into",
		"gazes into",
		"gazing into",
		"gazed into",
	)
	var/list/eyes_front_action_disarm = list(
		"blink at",
		"blinks at",
		"blinking at",
		"blinked at",
	)
	var/list/eyes_front_action_grab = list(
		"stare into",
		"stares into",
		"staring into",
		"stared into",
	)
	var/list/eyes_front_action_harm = list(
		"poke",
		"pokes",
		"poking",
		"poked",
	)
	var/list/eyes_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/eyes_side = list("eyebrow")
	var/list/eyes_side_action_help = list(
		"stroke",
		"strokes",
		"stroking",
		"stroked",
	)
	var/list/eyes_side_action_disarm = list(
		"tickle",
		"tickles",
		"tickling",
		"tickled",
	)
	var/list/eyes_side_action_grab = list(
		"furrow",
		"furrows",
		"furrowing",
		"furrowed",
	)
	var/list/eyes_side_action_harm = list(
		"pluck",
		"plucks",
		"plucking",
		"plucked",
	)
	var/list/eyes_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/eyes_back = list("earlobe")
	var/list/eyes_back_action_help = list(
		"dingle",
		"dingles",
		"dingling",
		"dingled",
	)
	var/list/eyes_back_action_disarm = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/eyes_back_action_grab = list(
		"tug on",
		"tugs on",
		"tugging on",
		"tugged on",
	)
	var/list/eyes_back_action_harm = list(
		"flick",
		"flicks",
		"flicking",
		"flicked",
	)
	var/list/eyes_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/eyes_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	/// mouth is also special
	var/list/mouth_front = list("lips")
	var/list/mouth_front_action_help = list(
		"run <DOERS> fingers across",
		"runs <DOERS> fingers across",
		"running <DOERS> fingers across",
		"ran <DOERS> fingers across",
	)
	var/list/mouth_front_action_disarm = list(
		"put <DOERS> finger to",
		"puts <DOERS> finger to",
		"putting <DOERS> finger to",
		"put <DOERS> finger to",
	)
	var/list/mouth_front_action_grab = list(
		"slip <DOERS> fingers into",
		"slips <DOERS> fingers into",
		"slipping <DOERS> fingers into",
		"slipped <DOERS> fingers into",
	)
	var/list/mouth_front_action_harm = list(
		"shove <DOERS> hand into",
		"shoves <DOERS> hand into",
		"shoving <DOERS> hand into",
		"shoved <DOERS> hand into",
	)
	var/list/mouth_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/mouth_side = list("cheek")
	var/list/mouth_side_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/mouth_side_action_disarm = list(
		"place <DOERS> hand on",
		"places <DOERS> hand on",
		"placing <DOERS> hand on",
		"placed <DOERS> hand on",
	)
	var/list/mouth_side_action_grab = list(
		"grab",
		"grabs",
		"grabbing",
		"grabbed",
	)
	var/list/mouth_side_action_harm = list(
		"slap",
		"slaps",
		"slapping",
		"slapped",
	)
	var/list/mouth_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

//back of neck start//
	var/list/mouth_back = list("the back of <TARGETS> neck") // this is the thing that I am doing to Their Thing
	var/list/mouth_back_action_help = list(
		"stroke",
		"strokes",
		"stroking",
		"stroked",
	)
	var/list/mouth_back_action_disarm = list(
		"dig <DOERS> fingers into",
		"digs <DOERS> fingers into",
		"digging <DOERS> fingers into",
		"dug <DOERS> fingers into",
	)
	var/list/mouth_back_action_grab = list(
		"grab", //I [grab] the (back of Tia's neck)
		"grabs", //Dan [grabs] (the back of my neck)
		"grabbing", // Dan continues [grabbing] (the back of my neck)
		"grabbed", // Dan [grabbed] (the back of Tia's neck)
	)
	var/list/mouth_back_action_harm = list(
		"squish", //I squish the back of Tia's neck
		"squishes", //Dan grabs the back of my neck
		"squishing", // Dan continues grabbing the back of my neck
		"squished", // Dan grabbed the back of Tia's neck
	)
	var/list/mouth_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/mouth_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
//back of neck end//

	var/list/chest_front = list("chest")
	var/list/chest_front_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/chest_front_action_disarm = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/chest_front_action_grab = list(
		"grab",
		"grabs",
		"grabbing",
		"grabbed",
	)
	var/list/chest_front_action_harm = list(
		"bap",
		"baps",
		"baping",
		"bapped",
	)
	var/list/chest_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/chest_side = list("underarm")
	var/list/chest_side_action_help = list(
		"feel up",
		"feels up",
		"feeling up",
		"felt up",
	)
	var/list/chest_side_action_disarm = list(
		"tickle",
		"tickles",
		"tickling",
		"tickled",
	)
	var/list/chest_side_action_grab = list(
		"grab",
		"grabs",
		"grabbing",
		"grabbed",
	)
	var/list/chest_side_action_harm = list(
		"pinch",
		"pinches",
		"pinching",
		"pinched",
	)
	var/list/chest_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/chest_back = list("back")
	var/list/chest_back_action_help = list(
		"stroke",
		"strokes",
		"stroking",
		"stroked",
	)
	var/list/chest_back_action_disarm = list(
		"massage",
		"massages",
		"massaging",
		"massaged",
	)
	var/list/chest_back_action_grab = list(
		"scratch",
		"scratches",
		"scratching",
		"scratched",
	)
	var/list/chest_back_action_harm = list(
		"slap",
		"slaps",
		"slapping",
		"slapped",
	)
	var/list/chest_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/chest_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')	
	
	var/list/l_arm_front = list("left arm")
	var/list/l_arm_front_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/l_arm_front_action_disarm = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/l_arm_front_action_grab = list(
		"grab",
		"grabs",
		"grabbing",
		"grabbed",
	)
	var/list/l_arm_front_action_harm = list(
		"poke",
		"pokes",
		"poking",
		"poked",
	)
	var/list/l_arm_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')	
	
	var/list/l_arm_side = list("left shoulder")
	var/list/l_arm_side_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/l_arm_side_action_disarm = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/l_arm_side_action_grab = list(
		"grip",
		"grips",
		"gripping",
		"gripped",
	)
	var/list/l_arm_side_action_harm = list(
		"pinch",
		"pinches",
		"pinching",
		"pinched",
	)
	var/list/l_arm_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/l_arm_back = list("left upper back")
	var/list/l_arm_back_action_help = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/l_arm_back_action_disarm = list(
		"massage",
		"massages",
		"massaging",
		"massaged",
	)
	var/list/l_arm_back_action_grab = list(
		"scratch",
		"scratches",
		"scratching",
		"scratched",
	)
	var/list/l_arm_back_action_harm = list(
		"slap",
		"slaps",
		"slapping",
		"slapped",
	)
	var/list/l_arm_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_arm_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	
	/// right arms are the same as left arms, but on the right side
	var/list/r_arm_front = list("right arm")
	var/list/r_arm_front_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/r_arm_front_action_disarm = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/r_arm_front_action_grab = list(
		"grab",
		"grabs",
		"grabbing",
		"grabbed",
	)
	var/list/r_arm_front_action_harm = list(
		"poke",
		"pokes",
		"poking",
		"poked",
	)
	var/list/r_arm_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/r_arm_side = list("right shoulder")
		var/list/r_arm_side_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/r_arm_side_action_disarm = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/r_arm_side_action_grab = list(
		"grip",
		"grips",
		"gripping",
		"gripped",
	)
	var/list/r_arm_side_action_harm = list(
		"pinch",
		"pinches",
		"pinching",
		"pinched",
	)
	var/list/r_arm_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/r_arm_back = list("right upper back")
	var/list/r_arm_back_action_help = list(
		"rub",
		"rubs",
		"rubbing",
		"rubbed",
	)
	var/list/r_arm_back_action_disarm = list(
		"massage",
		"massages",
		"massaging",
		"massaged",
	)
	var/list/r_arm_back_action_grab = list(
		"scratch",
		"scratches",
		"scratching",
		"scratched",
	)
	var/list/r_arm_back_action_harm = list(
		"slap",
		"slaps",
		"slapping",
		"slapped",
	)
	var/list/r_arm_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_arm_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	/// legs very sensual and demand some "special" attention~
	var/list/l_leg_front = list("left thigh") // the inner thigh
	var/list/l_leg_front_action_help = list(
		"slide <DOERS> hand up against",
		"slides <DOERS> hand up against",
		"sliding <DOERS> hand up against",
		"slid <DOERS> hand up against",
	)
	var/list/l_leg_front_action_disarm = list(
		"rub <DOERS> thumb along",
		"rubs <DOERS> thumb along",
		"rubbing <DOERS> thumb along",
		"rubbed <DOERS> thumb along",
	)
	var/list/l_leg_front_action_grab = list(
		"squeeze <DOERS> fingers into",
		"squeezes <DOERS> fingers into",
		"squeezing <DOERS> fingers into",
		"squeezed <DOERS> fingers into",
	)
	var/list/l_leg_front_action_harm = list(
		"pinch",
		"pinches",
		"pinching",
		"pinched",
	)
	var/list/l_leg_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/l_leg_front = list("left thigh") // the outer thigh
	var/list/l_leg_front_action_help = list(
		"rest <DOERS> hand on top of",
		"rests <DOERS> hand on top of",
		"resting <DOERS> hand on top of",
		"rested <DOERS> hand on top of",
	)
	var/list/l_leg_front_action_disarm = list(
		"rub <DOERS> palm up and down",
		"rubs <DOERS> palm up and down",
		"rubbing <DOERS> palm up and down",
		"rubbed <DOERS> palm up and down",
	)
	var/list/l_leg_front_action_grab = list(
		"grip <DOERS> fingers into",
		"grips <DOERS> fingers into",
		"gripping <DOERS> fingers into",
		"gripped <DOERS> fingers into",
	)
	var/list/l_leg_front_action_harm = list(
		"slap",
		"slaps",
		"slapping",
		"slapped",
	)
	var/list/l_leg_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/l_leg_side = list("left hip") // the side of the hip, not quite the butt yet
	var/list/l_leg_side_action_help = list(
		"place <DOERS> hand on",
		"places <DOERS> hand on",
		"placing <DOERS> hand on",
		"placed <DOERS> hand on",
	)
	var/list/l_leg_side_action_disarm = list(
		"press <DOERS> hand into",
		"presses <DOERS> hand into",
		"pressing <DOERS> hand into",
		"pressed <DOERS> hand into",
	)
	var/list/l_leg_side_action_grab = list(
		"grab a handful of",
		"grabs a handful of",
		"grabbing a handful of",
		"grabbed a handful of",
	)
	var/list/l_leg_side_action_harm = list(
		"smack",
		"smacks",
		"smacking",
		"smacked",
	)
	var/list/l_leg_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')	
	
	var/list/l_leg_back = list("left buttcheek") // the butt, lots of fun here with big fat soft squishy cheeks
	var/list/l_leg_back_action_help = list(
		"slide <DOERS> hand up against",
		"slides <DOERS> hand up against",
		"sliding <DOERS> hand up against",
		"slid <DOERS> hand up against",
	)
	var/list/l_leg_back_action_disarm = list(
		"squish <DOERS> fingers into",
		"squishes <DOERS> fingers into",
		"squishing <DOERS> fingers into",
		"squished <DOERS> fingers into",
	)
	var/list/l_leg_back_action_grab = list(
		"grope a big fat handful of",
		"gropes a big fat handful of",
		"groping a big fat handful of",
		"groped a big fat handful of",
	)
	var/list/l_leg_back_action_harm = list(
		"give a good hard smack to",
		"gives a good hard smack to",
		"giving a good hard smack to",
		"give a good hard smack to",
	)
	var/list/l_leg_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/l_leg_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')	
	
	var/list/r_leg_front = list("right thigh")
	var/list/r_leg_front_action_help = list(
		"slide <DOERS> hand up against",
		"slides <DOERS> hand up against",
		"sliding <DOERS> hand up against",
		"slid <DOERS> hand up against",
	)
	var/list/r_leg_front_action_disarm = list(
		"rub <DOERS> thumb along",
		"rubs <DOERS> thumb along",
		"rubbing <DOERS> thumb along",
		"rubbed <DOERS> thumb along",
	)
	var/list/r_leg_front_action_grab = list(
		"squeeze <DOERS> fingers into",
		"squeezes <DOERS> fingers into",
		"squeezing <DOERS> fingers into",
		"squeezed <DOERS> fingers into",
	)
	var/list/r_leg_front_action_harm = list(
		"pinch",
		"pinches",
		"pinching",
		"pinched",
	)
	var/list/r_leg_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/r_leg_side = list("right hip")
	var/list/r_leg_side_action_help = list(
		"place <DOERS> hand on",
		"places <DOERS> hand on",
		"placing <DOERS> hand on",
		"placed <DOERS> hand on",
	)
	var/list/r_leg_side_action_disarm = list(
		"press <DOERS> hand into",
		"presses <DOERS> hand into",
		"pressing <DOERS> hand into",
		"pressed <DOERS> hand into",
	)
	var/list/r_leg_side_action_grab = list(
		"grab a handful of",
		"grabs a handful of",
		"grabbing a handful of",
		"grabbed a handful of",
	)
	var/list/r_leg_side_action_harm = list(
		"smack",
		"smacks",
		"smacking",
		"smacked",
	)
	var/list/r_leg_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/r_leg_back = list("right buttcheek")
	var/list/r_leg_back_action_help = list(
		"slide <DOERS> hand up against",
		"slides <DOERS> hand up against",
		"sliding <DOERS> hand up against",
		"slid <DOERS> hand up against",
	)
	var/list/r_leg_back_action_disarm = list(
		"squish <DOERS> fingers into",
		"squishes <DOERS> fingers into",
		"squishing <DOERS> fingers into",
		"squished <DOERS> fingers into",
	)
	var/list/r_leg_back_action_grab = list(
		"grope a big fat handful of",
		"gropes a big fat handful of",
		"groping a big fat handful of",
		"groped a big fat handful of",
	)
	var/list/r_leg_back_action_harm = list(
		"give a good hard smack to",
		"gives a good hard smack to",
		"giving a good hard smack to",
		"give a good hard smack to",
	)
	var/list/r_leg_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/r_leg_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	var/list/groin_front = list("crotch") // very forward, very direct, gender neutral for now
	var/list/groin_front_action_help = list(
		"slick <DOERS> fingers across",
		"slicks <DOERS> fingers across",
		"slicking <DOERS> fingers across",
		"slicked <DOERS> fingers across",
	)
	var/list/groin_front_action_disarm = list(
		"rub <DOERS> thumb along",
		"rubs <DOERS> thumb along",
		"rubbing <DOERS> thumb along",
		"rubbed <DOERS> thumb along",
	)
	var/list/groin_front_action_grab = list(
		"squeeze <DOERS> fingers into",
		"squeezes <DOERS> fingers into",
		"squeezing <DOERS> fingers into",
		"squeezed <DOERS> fingers into",
	)
	var/list/groin_front_action_harm = list(
		"sink <DOERS> fingers against",
		"sinks <DOERS> fingers against",
		"sinking <DOERS> fingers against",
		"sunk <DOERS> fingers against",
	)
	var/list/groin_front_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_front_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_front_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_front_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')

	var/list/groin_side = list("love handle") // more fat-focused play
	var/list/groin_side_action_help = list(
		"reach in and feel the softness of",
		"reaches in and feels the softness of",
		"reaching in and feeling the softness of",
		"reached in and felt the softness of",
	)
	var/list/groin_side_action_disarm = list(
		"squish <DOERS> fingers into the fatty flesh of",
		"squishes <DOERS> fingers into the fatty flesh of",
		"squishing <DOERS> fingers into the fatty flesh of",
		"squished <DOERS> fingers into the fatty flesh of",
	)
	var/list/groin_side_action_grab = list(
		"grope a big soft handful of",
		"gropes a big soft handful of",
		"groping a big soft handful of",
		"groped a big soft handful of",
	)
	var/list/groin_side_action_harm = list(
		"pinch a big fat roll of",
		"pinches a big fat roll of",
		"pinching a big fat roll of",
		"pinched a big fat roll of",
	)
	var/list/groin_side_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_side_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_side_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_side_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')


	
	var/list/groin_back = list("butt") // the butt, lots of fun here with big fat soft squishy cheeks
	var/list/groin_back_action_help = list(
		"press <DOERS> hand against",
		"presses <DOERS> hand against",
		"pressing <DOERS> hand against",
		"pressed <DOERS> hand against",
	)
	var/list/groin_back_action_disarm = list(
		"squish <DOERS> fingers into",
		"squishes <DOERS> fingers into",
		"squishing <DOERS> fingers into",
		"squished <DOERS> fingers into",
	)
	var/list/groin_back_action_grab = list(
		"grope a big fat handful of",
		"gropes a big fat handful of",
		"groping a big fat handful of",
		"groped a big fat handful of",
	)
	var/list/groin_back_action_harm = list(
		"give a good hard smack to",
		"gives a good hard smack to",
		"giving a good hard smack to",
		"give a good hard smack to",
	)
	var/list/groin_back_action_help_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_back_action_disarm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_back_action_grab_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	var/list/groin_back_action_harm_sound = list('sound/AAAAAAAAAAAAAAAAAAA.ogg')
	
	
	var/list/l_hand_front = list("left hand")
	
	
	var/list/l_hand_side = list("left wrist")
	
	
	var/list/l_hand_back = list("left forearm")
	
	
	var/list/r_hand_front = list("right hand")
	
	
	var/list/r_hand_side = list("right wrist")
	
	
	var/list/r_hand_back = list("right forearm")
	
	
	var/list/l_foot_front = list("left foot")
	
	
	var/list/l_foot_side = list("left ankle")
	
	
	var/list/l_foot_back = list("left calf")
	
	
	var/list/r_foot_front = list("right foot")
	
	
	var/list/r_foot_side = list("right ankle")
	
	
	var/list/r_foot_back = list("right calf")



/datum/grope_kiss_MERP/proc/make_visible_message(mob/doer, mob/target, list/last_action = list())
	if(!doer || !target)
		return
	/// first get the direction of doer compared to target
	var/direc = calc_dir(doer, target)
	/// then, get the right location
	var/intent = get_grope_intent(doer, target)
	var/part = get_grope_list(part, direc, intent, FALSE, TRUE)
	var/list/actions = get_grope_list(part, direc, intent)
	var/tense = "present"
	if(LAZYLEN(last_action))
		if(LAZYACCESS(last_action, 1) == direc)
			if(LAZYACCESS(last_action, 2) == part)
				if(LAZYACCESS(last_action, 3) == intent)
					tense = "gerundo"
	var/list/sounds = get_grope_list(part, direc, intent, TRUE)
	var/snd = get_sound(doer, target, sounds)
	var/watDsee = make_message_for_doer(doer, target, actions)
	var/watTsee = make_message_for_target(doer, target, actions)
	var/watEsee = make_message_for_everyone(doer, target, actions)
	to_chat(doer, span_love(watDsee))
	to_chat(target, span_love(watTsee))
	doer.visible_message(
		watEsee,
		ignored_mobs = list(doer, target),
		visible_distance = 2,
	)
	return list(direc, part, intent)

/datum/grope_kiss_MERP/proc/get_sound(mob/doer, mob/target, list/sounds)
	if(LAZYLEN(sounds) != 4)
		return
	switch(doer.a_intent)
		if(INTENT_HELP)
			return LAZYACCESS(sounds, 1)
		if(INTENT_DISARM)
			return LAZYACCESS(sounds, 2)
		if(INTENT_GRAB)
			return LAZYACCESS(sounds, 3)
		if(INTENT_HARM)
			return LAZYACCESS(sounds, 4)

/datum/grope_kiss_MERP/proc/make_message_for_doer(mob/doer, mob/target, list/actions, tense)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// you slap Tia's cheek!
	if(tense == "present")
		var/act = actions[1]
		msg_out = "I [act] [target.name]'s [part]!"
	/// you continue slapping Tia's cheek!
	if(tense == "gerundo")
		var/act = actions[2]
		msg_out = "I continue [act] [target.name]'s [part]!"
	msg_out = replace(msg_out, "<DOERS>", "my")
	msg_out = replace(msg_out, "<TARGETS>", "[target.p_their()]")
	return msg_out

/datum/grope_kiss_MERP/proc/make_message_for_target(mob/doer, mob/target, list/actions, tense)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// Tia slaps my cheek!
	if(tense == "present")
		var/act = actions[1]
		msg_out = "[doer.name] [act] my [part]!"
		var/act = replace(act, "<DOERS>", "[doer.p_their()]")
	/// Tia continues slapping my cheek!
	if(tense == "gerundo")
		var/act = actions[2]
		var/act = replace(act, "<DOERS>", "[doer.p_their()]")
		msg_out = "[doer.name] continues [act] my [part]!"
	msg_out = replace(msg_out, "<DOERS>", "[doer.p_their()]")
	msg_out = replace(msg_out, "<TARGETS>", "my")
	return msg_out

/datum/grope_kiss_MERP/proc/make_message_for_everyone(mob/doer, mob/target, list/actions, tense)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// Dan slapped Tia's cheek!
	if(tense == "present")
		var/act = actions[1]
		msg_out = "[doer.name] [act] [target.name]'s [part]!"
	/// Dan continues to slap Tia's cheek!
	if(tense == "gerundo")
		var/act = actions[2]
		msg_out = "[doer.name] continues to [act] [target.name]'s [part]!"
	msg_out = replace(msg_out, "<DOERS>", "[doer.p_their()]")
	msg_out = replace(msg_out, "<TARGETS>", "[target.p_their()]")
	return msg_out

/datum/grope_kiss_MERP/proc/get_grope_target(mob/doer, mob/target, direc)
	var/here = doer.zone_selected
	var/port = vars["[here]_[direc]"]
	return port

/datum/grope_kiss_MERP/proc/get_grope_intent(mob/doer, mob/target)
	switch(doer.a_intent)
		if(INTENT_HELP)
			return "help"
		if(INTENT_DISARM)
			return "disarm"
		if(INTENT_GRAB)
			return "grab"
		if(INTENT_HARM)
			return "harm"

/datum/grope_kiss_MERP/proc/get_grope_list(partname, sidename, intentname, soundpls, just_part)
	var/varname = "[partname]" + "_" + "[sidename]"
	if(!just_part)
		varname += "_action_" + "[intentname]"
		if(soundpls)
			varname += "_sound"
	var/list/ret = list()
	if(vars[varname])
		ret |= vars[varname] // datums re just massive lists that are easier to read
	return ret

// returns if the doer is in front of, behind, or to a side of the target
// The three tiles in front of the target are considered the front, the one tile behind the target is considered the back
// The two tiles to the left and right of the target are considered the sides
/datum/grope_kiss_MERP/proc/calc_dir(mob/doer, mob/target)
	var/dirTarg = target.dir
	var/turf/D = get_turf(doer)
	var/turf/T = get_turf(target)
	if(D == T)
		// simple relative direction check
		var/dirDoer = doer.dir
		if(dirDoer == dirTarg)
			return "front"
		for(var/turnz in 1 to 3) // SPEEN
			var/turnt = turn(dirDoer, 90*turnz)
			if(turnz == 1 || turnz == 3)
				if(turnt == dirTarg)
					return "side"
			else
				if(turnt == dirTarg)
					return "back"
		return "front"
	/// now, check a special ring of turfs around the target
	var/list/turfz = list()
	turfz.len = 8
	/// front
	turfz[1] += get_step(T, dirTarg)
	turfz[2] += get_step(T, turn(dirTarg, 45))
	turfz[3] += get_step(T, turn(dirTarg, -45))
	/// sides
	turfz[4] += get_step(T, turn(dirTarg, 90))
	turfz[5] += get_step(T, turn(dirTarg, -90))
	turfz[6] += get_step(T, turn(dirTarg, 135))
	turfz[7] += get_step(T, turn(dirTarg, -135))
	/// back
	turfz[8] += get_step(T, turn(dirTarg, 180))
	for(var/i in 1 to 8)
		if(D == turfz[i])
			switch(i)
				if(1, 2, 3)
					return "front"
				if(4, 5, 6, 7)
					return "side"
				if(8)
					return "back"
	return "front"

/// a complex algorithm to check which triangular quadrant of the target the doer clicked




















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
GLOBAL_LIST_EMPTY(shotglass_gropers)
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
	var/list/head_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_front_action_harm_sound = list('sound/effects/slap.ogg')

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
	var/list/head_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_side_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')

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
	var/list/head_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/head_back_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')

	///////////////////////////////////////////////////////////////////////////////////
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
		"wink",
		"winks",
		"winking",
		"winked",
	)
	var/list/eyes_front_action_help_sound = list('sound/effects/blink.ogg')
	var/list/eyes_front_action_disarm_sound = list('sound/effects/blink.ogg')
	var/list/eyes_front_action_grab_sound = list('sound/effects/blink.ogg')
	var/list/eyes_front_action_harm_sound = list('sound/effects/blink.ogg')

	var/list/eyes_side = list("eyebrow") // MAKE INTO EARS TOO (insides??????)
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
	var/list/eyes_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/eyes_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/eyes_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/eyes_side_action_harm_sound = list('sound/effects/blink.ogg')

	var/list/eyes_back = list("earlobe")
	var/list/eyes_back_action_help = list(
		"tease",
		"teases",
		"teasing",
		"teased",
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
	var/list/eyes_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/eyes_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/eyes_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/eyes_back_action_harm_sound = list('sound/effects/blink.ogg')

	///////////////////////////////////////////////////////////////////////////////////
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
		"slip <DOERS> fingers between",
		"slips <DOERS> fingers between",
		"slipping <DOERS> fingers between",
		"slipped <DOERS> fingers between",
	)
	var/list/mouth_front_action_harm = list(
		"put a hushing finger",
		"puts a hushing finger",
		"putting a hushing finger",
		"put a hushing finger",
	)
	var/list/mouth_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_front_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')

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
	var/list/mouth_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_side_action_harm_sound = list('sound/effects/slap.ogg')

//back of neck start//
	var/list/mouth_back = list("neck from behind") // this is the thing that I am doing to Their Thing
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
	var/list/mouth_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/mouth_back_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')
//back of neck end//

	///////////////////////////////////////////////////////////////////////////////////
	var/list/chest_front = list("chest")
	var/list/chest_front_action_help = list(
		"caress",
		"caresses",
		"caressing",
		"caressed",
	)
	var/list/chest_front_action_disarm = list(
		"rub",
		"rubs", // Dan rubs my chest
		"rubbing",
		"rubbed", // Dan rubbed Someone's chest
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
	var/list/chest_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_front_action_harm_sound = list("punch")
	
	var/list/chest_side = list("flank") // non blank
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
	var/list/chest_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_side_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')
	
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
	var/list/chest_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/chest_back_action_harm_sound = list('sound/effects/slap.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
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
	var/list/l_arm_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_front_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')
	
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
		"slap",
		"slapss",
		"slapping",
		"slapped",
	)
	var/list/l_arm_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_side_action_harm_sound = list('sound/effects/slap.ogg')
	
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
	var/list/l_arm_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_arm_back_action_harm_sound = list('sound/effects/slap.ogg')

	
	///////////////////////////////////////////////////////////////////////////////////
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
	var/list/r_arm_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_front_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')

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
		"slap",
		"slapes",
		"slaping",
		"slaped",
	)
	var/list/r_arm_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_side_action_harm_sound = list('sound/effects/slap.ogg')

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
	var/list/r_arm_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_arm_back_action_harm_sound = list('sound/effects/slap.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	var/list/l_leg_front = list("left inner thigh") // the outer thigh
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
	var/list/l_leg_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_front_action_harm_sound = list('sound/effects/slap.ogg')
	
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
	var/list/l_leg_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_side_action_harm_sound = list('sound/effects/slap.ogg')
	
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
	var/list/l_leg_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/l_leg_back_action_harm_sound = list('sound/effects/slap.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	var/list/r_leg_front = list("right inner thigh")
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
	var/list/r_leg_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_front_action_harm_sound = list('sound/effects/slap.ogg')
	
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
	var/list/r_leg_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_side_action_harm_sound = list('sound/effects/slap.ogg')
	
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
	var/list/r_leg_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/r_leg_back_action_harm_sound = list('sound/effects/slap.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	var/list/groin_front = list("lap") // very forward, very direct, gender neutral for now
	var/list/groin_front_action_help = list(
		"run <DOERS> fingers across",
		"runs <DOERS> fingers across",
		"running <DOERS> fingers across",
		"ran <DOERS> fingers across",
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
		"rake <DOERS> fingers against",
		"rakes <DOERS> fingers against",
		"raking <DOERS> fingers against",
		"raked <DOERS> fingers against",
	)
	var/list/groin_front_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_front_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_front_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_front_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')

	var/list/groin_side = list("love handle") // more fat-focused play
	var/list/groin_side_action_help = list(
		"reach in and feel the softness of",
		"reaches in and feels the softness of",
		"reaching in and feeling the softness of",
		"reached in and felt the softness of",
	)
	var/list/groin_side_action_disarm = list(
		"squish <DOERS> fingers into the soft flesh of",
		"squishes <DOERS> fingers into the soft flesh of",
		"squishing <DOERS> fingers into the soft flesh of",
		"squished <DOERS> fingers into the soft flesh of",
	)
	var/list/groin_side_action_grab = list(
		"grope a big soft handful of",
		"gropes a big soft handful of",
		"groping a big soft handful of",
		"groped a big soft handful of",
	)
	var/list/groin_side_action_harm = list(
		"pinch a big soft roll of",
		"pinches a big soft roll of",
		"pinching a big soft roll of",
		"pinched a big soft roll of",
	)
	var/list/groin_side_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_side_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_side_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_side_action_harm_sound = list('modular_sand/sound/interactions/hug.ogg')

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
		"grope a big handful of",
		"gropes a big handful of",
		"groping a big handful of",
		"groped a big handful of",
	)
	var/list/groin_back_action_harm = list(
		"give a good hard smack to",
		"gives a good hard smack to",
		"giving a good hard smack to",
		"give a good hard smack to",
	)
	var/list/groin_back_action_help_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_back_action_disarm_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_back_action_grab_sound = list('modular_sand/sound/interactions/hug.ogg')
	var/list/groin_back_action_harm_sound = list('sound/effects/slap.ogg')

	///////////////////////////////////////////////////////////////////////////////////
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
	if(!isliving(target) && !(doer.ckey in GLOB.shotglass_gropers))
		return // you grope the shotglass's butt
	/// first get the direction of doer compared to target
	var/direc = calc_dir(doer, target)
	/// then, get the right location
	var/intent = get_grope_intent(doer, target)
	var/part = get_grope_target(doer, target)
	var/list/partname = get_grope_list(part, direc, intent, FALSE, TRUE)
	var/list/actions = get_grope_list(part, direc, intent)
	var/tense = "present"
	if(LAZYLEN(last_action))
		if(LAZYACCESS(last_action, 1) == direc)
			if(LAZYACCESS(last_action, 2) == part)
				if(LAZYACCESS(last_action, 3) == intent)
					if(LAZYACCESS(last_action, 4) == target.name)
						tense = "gerundo"
	var/snd = get_sound(doer, target, part, direc, intent)
	var/watDsee = make_message_for_doer(doer, target, actions, tense, LAZYACCESS(partname, 1))
	var/watTsee = make_message_for_target(doer, target, actions, tense, LAZYACCESS(partname, 1))
	var/watEsee = make_message_for_everyone(doer, target, actions, tense, LAZYACCESS(partname, 1))
	var/watIsee = make_message_for_myself_to_me(doer, target, actions, tense, LAZYACCESS(partname, 1))
	var/watYEsee = make_message_for_myself_to_others(doer, target, actions, tense, LAZYACCESS(partname, 1)) // catch the wave!
	if(target == doer)
		playsound(doer, snd, 50, TRUE)
		to_chat(doer, span_love(watIsee))
		doer.visible_message(
			watYEsee,
			ignored_mobs = list(doer),
			vision_distance = 2,
		)
	else
		playsound(target, snd, 50, TRUE)
		to_chat(doer, span_love(watDsee))
		to_chat(target, span_love(watTsee))
		doer.visible_message(
			watEsee,
			ignored_mobs = list(doer, target),
			vision_distance = 2,
		)
	return list(direc, part, intent, target.name)

/datum/grope_kiss_MERP/proc/get_sound(mob/doer, mob/target, part, direc, intent)
	var/whichvar = "[part]_[direc]_action_[intent]_sound"
	var/list/snds = list()
	if(vars[whichvar])
		snds |= vars[whichvar]
	return safepick(snds)

/datum/grope_kiss_MERP/proc/make_message_for_doer(mob/doer, mob/target, list/actions, tense, part)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// you slap Tia's cheek!
	if(tense == "present")
		var/act = actions[1]
		msg_out = "I [act] [target.name]'s [part]!"
	/// you continue slapping Tia's cheek!
	if(tense == "gerundo")
		var/act = actions[3]
		msg_out = "I continue [act] [target.name]'s [part]!"
	msg_out = replacetext(msg_out, "<DOERS>", "my")
	msg_out = replacetext(msg_out, "<TARGETS>", "[target.p_their()]")
	return msg_out

/datum/grope_kiss_MERP/proc/make_message_for_target(mob/doer, mob/target, list/actions, tense, part)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// Tia slaps my cheek!
	if(tense == "present")
		var/act = actions[2]
		msg_out = "[doer.name] [act] my [part]!"
	/// Tia continues slapping my cheek!
	if(tense == "gerundo")
		var/act = actions[3]
		msg_out = "[doer.name] continues [act] my [part]!"
	msg_out = replacetext(msg_out, "<DOERS>", "[doer.p_their()]")
	msg_out = replacetext(msg_out, "<TARGETS>", "my")
	return msg_out

/datum/grope_kiss_MERP/proc/make_message_for_everyone(mob/doer, mob/target, list/actions, tense, part)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// Dan slapped Tia's cheek!
	if(tense == "present")
		var/act = actions[4]
		msg_out = "[doer.name] [act] [target.name]'s [part]!"
	/// Dan continues to slap Tia's cheek!
	if(tense == "gerundo")
		var/act = actions[3]
		msg_out = "[doer.name] continues [act] [target.name]'s [part]!"
	msg_out = replacetext(msg_out, "<DOERS>", "[doer.p_their()]")
	msg_out = replacetext(msg_out, "<TARGETS>", "[target.p_their()]")
	return msg_out

/datum/grope_kiss_MERP/proc/make_message_for_myself_to_me(mob/doer, mob/target, list/actions, tense, part)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// I slap my butt!
	if(tense == "present")
		var/act = actions[1]
		msg_out = "I [act] my [part]!"
	/// I continue slapping my butt!
	if(tense == "gerundo")
		var/act = actions[3]
		msg_out = "I continue [act] my [part]!"
	msg_out = replacetext(msg_out, "<DOERS>", "my")
	msg_out = replacetext(msg_out, "<TARGETS>", "my")
	return msg_out

/datum/grope_kiss_MERP/proc/make_message_for_myself_to_others(mob/doer, mob/target, list/actions, tense, part)
	if( LAZYLEN(actions) != 4)
		return
	var/msg_out = ""
	/// Dan slapped her butt!
	if(tense == "present")
		var/act = actions[4]
		msg_out = "[doer.name] [act] [doer.p_their()]'s [part]!"
	/// Dan continues slapping her butt!
	if(tense == "gerundo")
		var/act = actions[3]
		msg_out = "[doer.name] continues [act] [doer.p_their()]'s [part]!"
	msg_out = replacetext(msg_out, "<DOERS>", "[doer.p_their()]")
	msg_out = replacetext(msg_out, "<TARGETS>", "[doer.p_their()]")
	return msg_out

/datum/grope_kiss_MERP/proc/get_grope_target(mob/doer, mob/target, direc)
	var/here = doer.zone_selected
	return here

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
	if(doer == target)
		if(doer.dir == NORTH)
			return "back"
		if(doer.dir == SOUTH)
			return "front"
		return "side"
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
					return "front"
		return "back"
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




//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


/datum/grope_kiss_MERP/kiss
	/*
		for action tenses, format is: 
			I "kiss" Tia's [toes], (present tense, user performing)
			Dan "kisses" my [toes], (present tense, target recieving)
			I continue "kissing" Tia's [toes] / Dan continues "kissing" my [toes], (continuous/gerundo)
			Dan "kissed" Tia's [toes], (past tense, third person)
	*/
	head_front = list("head")
	head_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
		)
	head_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
		)
	head_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
		)
	head_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
		)
	head_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	head_side = list("ear")
	head_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	head_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	head_side_action_grab = list(
		"wetly nibble", //I [grab] the (back of Tia's neck)
		"wetly nibbles", //Dan [grabs] (the back of my neck)
		"wetly nibbling", // Dan continues [grabbing] (the back of my neck)
		"wetly nibbled", // Dan [grabbed] (the back of Tia's neck)
	)
	head_side_action_harm = list(
		"breathily mouth", //I [grab] the (back of Tia's neck)
		"breathily mouths", //Dan [grabs] (the back of my neck)
		"breathily mouthing", // Dan continues [grabbing] (the back of my neck)
		"breathily mouthed", // Dan [grabbed] (the back of Tia's neck)
	)
	head_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	head_back = list("neck from behind")
	head_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	head_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	head_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	head_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	head_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	head_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	/// eyes are special
	eyes_front = list("forehead")
	eyes_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	eyes_side = list("temple") // MAKE INTO EARS TOO (insides??????)
	eyes_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	eyes_back = list("earlobe")
	eyes_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	eyes_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	eyes_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	/// mouth is also special
	mouth_front = list("lips")
	mouth_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	mouth_side = list("cheek")
	mouth_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

//back of neck start//
	mouth_back = list("neck from behind") // this is the thing that I am doing to Their Thing
	mouth_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	mouth_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	mouth_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
//back of neck end//

	///////////////////////////////////////////////////////////////////////////////////
	chest_front = list("chest")
	chest_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	chest_side = list("side") // non blank
	chest_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	chest_back = list("back")
	chest_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	chest_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	chest_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	l_arm_front = list("left hand")
	l_arm_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	l_arm_side = list("left arm")
	l_arm_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	l_arm_back = list("left shoulder blade")
	l_arm_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_arm_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_arm_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	
	///////////////////////////////////////////////////////////////////////////////////
	/// right arms are the same as left arms, but on the right side
	r_arm_front = list("right hand")
	r_arm_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	r_arm_side = list("right arm")
	r_arm_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	r_arm_back = list("right shoulder blade")
	r_arm_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_arm_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_arm_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	l_leg_front = list("left inner thigh") // the outer thigh
	l_leg_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	l_leg_side = list("left hip") // the side of the hip, not quite the butt yet
	l_leg_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	l_leg_back = list("left buttcheek") // the butt, lots of fun here with big fat soft squishy cheeks
	l_leg_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	l_leg_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	l_leg_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	r_leg_front = list("right inner thigh")
	r_leg_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	r_leg_side = list("right hip")
	r_leg_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	r_leg_back = list("right buttcheek")
	r_leg_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	r_leg_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	r_leg_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	groin_front = list("lap") // very forward, very direct, gender neutral for now
	groin_front_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_front_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_front_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_front_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_front_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_front_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_front_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_front_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	groin_side = list("love handle") // more fat-focused play
	groin_side_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_side_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_side_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_side_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_side_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_side_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_side_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_side_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	groin_back = list("butt") // the butt, lots of fun here with big fat soft squishy cheeks
	groin_back_action_help = list(
		"softly kiss", //I [grab] the (back of Tia's neck)
		"softly kisses", //Dan [grabs] (the back of my neck)
		"softly kissing", // Dan continues [grabbing] (the back of my neck)
		"softly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_back_action_disarm = list(
		"teasingly kiss", //I [grab] the (back of Tia's neck)
		"teasingly kisses", //Dan [grabs] (the back of my neck)
		"teasingly kissing", // Dan continues [grabbing] (the back of my neck)
		"teasingly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_back_action_grab = list(
		"firmly kiss", //I [grab] the (back of Tia's neck)
		"firmly kisses", //Dan [grabs] (the back of my neck)
		"firmly kissing", // Dan continues [grabbing] (the back of my neck)
		"firmly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_back_action_harm = list(
		"hotly kiss", //I [grab] the (back of Tia's neck)
		"hotly kisses", //Dan [grabs] (the back of my neck)
		"hotly kissing", // Dan continues [grabbing] (the back of my neck)
		"hotly kissed", // Dan [grabbed] (the back of Tia's neck)
	)
	groin_back_action_help_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_back_action_disarm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_back_action_grab_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')
	groin_back_action_harm_sound = list('modular_splurt/sound/interactions/kiss/kiss3.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	l_hand_front = list("left hand")
	
	
	l_hand_side = list("left wrist")
	
	
	l_hand_back = list("left forearm")
	
	
	r_hand_front = list("right hand")
	
	
	r_hand_side = list("right wrist")
	
	
	r_hand_back = list("right forearm")
	
	
	l_foot_front = list("left foot")
	
	
	l_foot_side = list("left ankle")
	
	
	l_foot_back = list("left calf")
	
	
	r_foot_front = list("right foot")
	
	
	r_foot_side = list("right ankle")
	
	
	r_foot_back = list("right calf")

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////lick///////
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/grope_kiss_MERP/lick
	/*
		for action tenses, format is: 
			I "kiss" Tia's [toes], (present tense, user performing)
			Dan "kisses" my [toes], (present tense, target recieving)
			I continue "kissing" Tia's [toes] / Dan continues "kissing" my [toes], (continuous/gerundo)
			Dan "kissed" Tia's [toes], (past tense, third person)
	*/
	head_front = list("face")
	head_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
		)
	head_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
		)
	head_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
		)
	head_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
		)
	head_front_action_help_sound = list('sound/effects/lick.ogg')
	head_front_action_disarm_sound = list('sound/effects/lick.ogg')
	head_front_action_grab_sound = list('sound/effects/lick.ogg')
	head_front_action_harm_sound = list('sound/effects/lick.ogg')

	head_side = list("ear")
	head_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	head_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",,
	)
	head_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	head_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	head_side_action_help_sound = list('sound/effects/lick.ogg')
	head_side_action_disarm_sound = list('sound/effects/lick.ogg')
	head_side_action_grab_sound = list('sound/effects/lick.ogg')
	head_side_action_harm_sound = list('sound/effects/lick.ogg')

	head_back = list("neck")
	head_back_action_help = list(
		"softly lick the nape of", 
		"softly licks the nape of", 
		"softly licking the nape of", 
		"softly licked the nape of",
	)
	head_back_action_disarm = list(
		"playfully lick the nape of",
		"playfully licks the nape of",
		"playfully licking the nape of",
		"playfully licked the nape of",
	)
	head_back_action_grab = list(
		"tongue the nape of",
		"tongues the nape of",
		"tonguing the nape of",
		"tongued the nape of",
	)
	head_back_action_harm = list(
		"wetly lick the nape of",
		"wetly licks the nape of",
		"wetly licking the nape of",
		"wetly licked the nape of",
	)
	head_back_action_help_sound = list('sound/effects/lick.ogg')
	head_back_action_disarm_sound = list('sound/effects/lick.ogg')
	head_back_action_grab_sound = list('sound/effects/lick.ogg')
	head_back_action_harm_sound = list('sound/effects/lick.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	/// eyes are special
	eyes_front = list("cheek")
	eyes_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	eyes_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	eyes_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	eyes_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	eyes_front_action_help_sound = list('sound/effects/blink.ogg')
	eyes_front_action_disarm_sound = list('sound/effects/blink.ogg')
	eyes_front_action_grab_sound = list('sound/effects/blink.ogg')
	eyes_front_action_harm_sound = list('sound/effects/blink.ogg')

	eyes_side = list("ear") // MAKE INTO EARS TOO (insides??????)
	eyes_side_action_help = list(
		"softly lick the rim of", 
		"softly licks the rim of", 
		"softly licking the rim of", 
		"softly licked the rim of", 
	)
	eyes_side_action_disarm = list(
		"playfully lick the rim of", 
		"playfully licks the rim of", 
		"playfully licking the rim of", 
		"playfully licked the rim of", 
	)
	eyes_side_action_grab = list(
		"tongue the rim of", 
		"tongues the rim of", 
		"tonguing the rim of", 
		"tongued the rim of", 
	)
	eyes_side_action_harm = list(
		"wetly lick the rim of", 
		"wetly licks the rim of", 
		"wetly licking the rim of", 
		"wetly licked the rim of", 
	)
	eyes_side_action_help_sound = list('sound/effects/lick.ogg')
	eyes_side_action_disarm_sound = list('sound/effects/lick.ogg')
	eyes_side_action_grab_sound = list('sound/effects/lick.ogg')
	eyes_side_action_harm_sound = list('sound/effects/lick.ogg')

	eyes_back = list("earlobe")
	eyes_back_action_help = list(
		"softly suckle on", 
		"softly suckles on", 
		"softly sucking on", 
		"softly sucked on",
	)
	eyes_back_action_disarm = list(
		"playfully suckle on", 
		"playfully suckles on", 
		"playfully sucking on", 
		"playfully sucked on",
	)
	eyes_back_action_grab = list(
		"warmly suckle on", 
		"warmly suckles on", 
		"warmly sucking on", 
		"warmly sucked on",
	)
	eyes_back_action_harm = list(
		"lewdly suckle on", 
		"lewdly suckles on", 
		"lewdly sucking on", 
		"lewdly sucked on",
	)
	eyes_back_action_help_sound = list('sound/effects/lick.ogg')
	eyes_back_action_disarm_sound = list('sound/effects/lick.ogg')
	eyes_back_action_grab_sound = list('sound/effects/lick.ogg')
	eyes_back_action_harm_sound = list('sound/effects/lick.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	/// mouth is also special
	mouth_front = list("lips")
	mouth_front_action_help = list(
		"softly mlem", 
		"softly mlems", 
		"softly mleming", 
		"softly mlemed",
	)
	mouth_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	mouth_front_action_grab = list(
		"intimately tongue", 
		"intimately tongues", 
		"intimately tonguing", 
		"intimately tongued",
	)
	mouth_front_action_harm = list(
		"hotly lick", 
		"hotly licks", 
		"hotly licking", 
		"hotly licked",
	)
	mouth_front_action_help_sound = list('sound/effects/lick.ogg')
	mouth_front_action_disarm_sound = list('sound/effects/lick.ogg')
	mouth_front_action_grab_sound = list('sound/effects/lick.ogg')
	mouth_front_action_harm_sound = list('sound/effects/lick.ogg')

	mouth_side = list("cheek")
	mouth_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	mouth_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	mouth_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	mouth_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	mouth_side_action_help_sound = list('sound/effects/lick.ogg')
	mouth_side_action_disarm_sound = list('sound/effects/lick.ogg')
	mouth_side_action_grab_sound = list('sound/effects/lick.ogg')
	mouth_side_action_harm_sound = list('sound/effects/lick.ogg')

//back of neck start//
	mouth_back = list("neck from behind") // this is the thing that I am doing to Their Thing
	mouth_back_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	mouth_back_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	mouth_back_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	mouth_back_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	mouth_back_action_help_sound = list('sound/effects/lick.ogg')
	mouth_back_action_disarm_sound = list('sound/effects/lick.ogg')
	mouth_back_action_grab_sound = list('sound/effects/lick.ogg')
	mouth_back_action_harm_sound = list('sound/effects/lick.ogg')
//back of neck end//

	///////////////////////////////////////////////////////////////////////////////////
	chest_front = list("chest")
	chest_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	chest_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	chest_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	chest_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	chest_front_action_help_sound = list('sound/effects/lick.ogg')
	chest_front_action_disarm_sound = list('sound/effects/lick.ogg')
	chest_front_action_grab_sound = list('sound/effects/lick.ogg')
	chest_front_action_harm_sound = list('sound/effects/lick.ogg')
	
	chest_side = list("flank") // non blank
	chest_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	chest_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	chest_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	chest_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	chest_side_action_help_sound = list('sound/effects/lick.ogg')
	chest_side_action_disarm_sound = list('sound/effects/lick.ogg')
	chest_side_action_grab_sound = list('sound/effects/lick.ogg')
	chest_side_action_harm_sound = list('sound/effects/lick.ogg')
	
	chest_back = list("back")
	chest_back_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	chest_back_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	chest_back_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	chest_back_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	chest_back_action_help_sound = list('sound/effects/lick.ogg')
	chest_back_action_disarm_sound = list('sound/effects/lick.ogg')
	chest_back_action_grab_sound = list('sound/effects/lick.ogg')
	chest_back_action_harm_sound = list('sound/effects/lick.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	l_arm_front = list("left hand's fingers")
	l_arm_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	l_arm_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	l_arm_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	l_arm_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	l_arm_front_action_help_sound = list('sound/effects/lick.ogg')
	l_arm_front_action_disarm_sound = list('sound/effects/lick.ogg')
	l_arm_front_action_grab_sound = list('sound/effects/lick.ogg')
	l_arm_front_action_harm_sound = list('sound/effects/lick.ogg')
	
	l_arm_side = list("left arm")
	l_arm_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	l_arm_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	l_arm_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	l_arm_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	l_arm_side_action_help_sound = list('sound/effects/lick.ogg')
	l_arm_side_action_disarm_sound = list('sound/effects/lick.ogg')
	l_arm_side_action_grab_sound = list('sound/effects/lick.ogg')
	l_arm_side_action_harm_sound = list('sound/effects/lick.ogg')
	
	l_arm_back = list("left shoulder blade")
	l_arm_back_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	l_arm_back_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	l_arm_back_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	l_arm_back_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	l_arm_back_action_help_sound = list('sound/effects/lick.ogg')
	l_arm_back_action_disarm_sound = list('sound/effects/lick.ogg')
	l_arm_back_action_grab_sound = list('sound/effects/lick.ogg')
	l_arm_back_action_harm_sound = list('sound/effects/lick.ogg')

	
	///////////////////////////////////////////////////////////////////////////////////
	/// right arms are the same as left arms, but on the right side
	r_arm_front = list("right hand's fingers")
	r_arm_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	r_arm_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	r_arm_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	r_arm_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	r_arm_front_action_help_sound = list('sound/effects/lick.ogg')
	r_arm_front_action_disarm_sound = list('sound/effects/lick.ogg')
	r_arm_front_action_grab_sound = list('sound/effects/lick.ogg')
	r_arm_front_action_harm_sound = list('sound/effects/lick.ogg')

	r_arm_side = list("right arm")
	r_arm_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	r_arm_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	r_arm_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	r_arm_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	r_arm_side_action_help_sound = list('sound/effects/lick.ogg')
	r_arm_side_action_disarm_sound = list('sound/effects/lick.ogg')
	r_arm_side_action_grab_sound = list('sound/effects/lick.ogg')
	r_arm_side_action_harm_sound = list('sound/effects/lick.ogg')

	r_arm_back = list("right shoulder blade")
	r_arm_back_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	r_arm_back_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	r_arm_back_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	r_arm_back_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	r_arm_back_action_help_sound = list('sound/effects/lick.ogg')
	r_arm_back_action_disarm_sound = list('sound/effects/lick.ogg')
	r_arm_back_action_grab_sound = list('sound/effects/lick.ogg')
	r_arm_back_action_harm_sound = list('sound/effects/lick.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	l_leg_front = list("left inner thigh") // the outer thigh
	l_leg_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	l_leg_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	l_leg_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	l_leg_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	l_leg_front_action_help_sound = list('sound/effects/lick.ogg')
	l_leg_front_action_disarm_sound = list('sound/effects/lick.ogg')
	l_leg_front_action_grab_sound = list('sound/effects/lick.ogg')
	l_leg_front_action_harm_sound = list('sound/effects/lick.ogg')
	
	l_leg_side = list("left hip") // the side of the hip, not quite the butt yet
	l_leg_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	l_leg_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	l_leg_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	l_leg_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	l_leg_side_action_help_sound = list('sound/effects/lick.ogg')
	l_leg_side_action_disarm_sound = list('sound/effects/lick.ogg')
	l_leg_side_action_grab_sound = list('sound/effects/lick.ogg')
	l_leg_side_action_harm_sound = list('sound/effects/lick.ogg')
	
	l_leg_back = list("left buttcheek") // the butt, lots of fun here with big fat soft squishy cheeks
	l_leg_back_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	l_leg_back_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	l_leg_back_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	l_leg_back_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	l_leg_back_action_help_sound = list('sound/effects/lick.ogg')
	l_leg_back_action_disarm_sound = list('sound/effects/lick.ogg')
	l_leg_back_action_grab_sound = list('sound/effects/lick.ogg')
	l_leg_back_action_harm_sound = list('sound/effects/lick.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	r_leg_front = list("right inner thigh")
	r_leg_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	r_leg_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	r_leg_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	r_leg_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	r_leg_front_action_help_sound = list('sound/effects/lick.ogg')
	r_leg_front_action_disarm_sound = list('sound/effects/lick.ogg')
	r_leg_front_action_grab_sound = list('sound/effects/lick.ogg')
	r_leg_front_action_harm_sound = list('sound/effects/lick.ogg')
	
	r_leg_side = list("right hip")
	r_leg_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	r_leg_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	r_leg_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	r_leg_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	r_leg_side_action_help_sound = list('sound/effects/lick.ogg')
	r_leg_side_action_disarm_sound = list('sound/effects/lick.ogg')
	r_leg_side_action_grab_sound = list('sound/effects/lick.ogg')
	r_leg_side_action_harm_sound = list('sound/effects/lick.ogg')
	
	r_leg_back = list("right buttcheek")
	r_leg_back_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	r_leg_back_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	r_leg_back_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	r_leg_back_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	r_leg_back_action_help_sound = list('sound/effects/lick.ogg')
	r_leg_back_action_disarm_sound = list('sound/effects/lick.ogg')
	r_leg_back_action_grab_sound = list('sound/effects/lick.ogg')
	r_leg_back_action_harm_sound = list('sound/effects/lick.ogg')
	
	///////////////////////////////////////////////////////////////////////////////////
	groin_front = list("lap") // very forward, very direct, gender neutral for now
	groin_front_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	groin_front_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	groin_front_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	groin_front_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	groin_front_action_help_sound = list('sound/effects/lick.ogg')
	groin_front_action_disarm_sound = list('sound/effects/lick.ogg')
	groin_front_action_grab_sound = list('sound/effects/lick.ogg')
	groin_front_action_harm_sound = list('sound/effects/lick.ogg')

	groin_side = list("love handle") // more fat-focused play
	groin_side_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	groin_side_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	groin_side_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	groin_side_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	groin_side_action_help_sound = list('sound/effects/lick.ogg')
	groin_side_action_disarm_sound = list('sound/effects/lick.ogg')
	groin_side_action_grab_sound = list('sound/effects/lick.ogg')
	groin_side_action_harm_sound = list('sound/effects/lick.ogg')

	groin_back = list("butt") // the butt, lots of fun here with big fat soft squishy cheeks
	groin_back_action_help = list(
		"softly lick", 
		"softly licks", 
		"softly licking", 
		"softly licked",
	)
	groin_back_action_disarm = list(
		"playfully lick", 
		"playfully licks", 
		"playfully licking", 
		"playfully licked",
	)
	groin_back_action_grab = list(
		"tongue", 
		"tongues", 
		"tonguing", 
		"tongued",
	)
	groin_back_action_harm = list(
		"wetly lick", 
		"wetly licks", 
		"wetly licking", 
		"wetly licked",
	)
	groin_back_action_help_sound = list('sound/effects/lick.ogg')
	groin_back_action_disarm_sound = list('sound/effects/lick.ogg')
	groin_back_action_grab_sound = list('sound/effects/lick.ogg')
	groin_back_action_harm_sound = list('sound/effects/lick.ogg')

	///////////////////////////////////////////////////////////////////////////////////
	l_hand_front = list("left hand")
	
	
	l_hand_side = list("left wrist")
	
	
	l_hand_back = list("left forearm")
	
	
	r_hand_front = list("right hand")
	
	
	r_hand_side = list("right wrist")
	
	
	r_hand_back = list("right forearm")
	
	
	l_foot_front = list("left foot")
	
	
	l_foot_side = list("left ankle")
	
	
	l_foot_back = list("left calf")
	
	
	r_foot_front = list("right foot")
	
	
	r_foot_side = list("right ankle")
	
	
	r_foot_back = list("right calf")




















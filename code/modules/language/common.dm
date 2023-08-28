// 'basic' language; spoken by default.
/datum/language/common
	name = "English"
	desc = "The most popular language in the world before the war, and likely still today."
	speech_verb = "says"
	whisper_verb = "whispers"
	key = "0"
	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_UNDERSTOOD
	default_priority = 100

	icon_state = "galcom"

//Syllable Lists
/*
	This list really long, mainly because I can't make up my mind about which mandarin syllables should be removed,
	and the english syllables had to be duplicated so that there is roughly a 50-50 weighting.

	Sources:
	http://www.sttmedia.com/syllablefrequency-english
	http://www.chinahighlights.com/travelguide/learning-chinese/pinyin-syllables.htm
*/______qdel_list_wrapper(list/L)
	. = ..()

	//New list generated with chatgpt sounding 'vaguely' like english.  Better than it sounding way too much like chinese, lol
/datum/language/common/syllables = list(
"a",
"zib",
"flarg",
"quix",
"snorb",
"plink",
"glup",
"frim",
"jank",
"splosh",
"thwop",
"crax",
"blort",
"skrim",
"squib",
"froth",
"zork",
"clib",
"dax",
"grib",
"trong",
"flimp",
"splork",
"glab",
"splib",
"frink",
"sklop",
"quib",
"thorp",
"smog",
"frib",
"clorsh",
"gliv",
"sworsh",
"chib",
"sprol",
"plax",
"jorf",
"thorp",
"quab",
"splort",
"frax",
"trig",
"zlim",
"plorf",
"glorp",
"sclab",
"flib",
"squax",
"jib",
"blimp",
"sporf",
"thworp",
"grax",
"snib",
"plig",
"frink",
"glap",
"crax",
"swop",
"thwib",
"zlop",
"jank",
"quax",
"sklorsh",
"sprog",
"plorf",
"frib",
"grax",
"blib",
"zlob",
"thwog",
"snorb",
"flong",
"splax",
"sclab",
"gliv",
"frorp",
"sprol",
"gronk",
"splib",
"quib",
"sklim",
"smog",
"chib",
"florg",
"jorf",
"trong",
"glorp",
"squib",
"clorsh",
"plax",
"frax",
"thorp",
"blimp",
"zlim",
"splort",
"swop",
"snib",
"plig",
"grax",
"glap",
"crax",
"thwib",
"frink",
"jank",
"sklorsh",
"frib",
"quax",
"zlop",
"gronk",
"snorb",
"sprog",
"sclab",
"plorf",
"thwog",
"flong",
"splax",
"gliv",
"sprol",
"quib",
"blib",
"zlob",
"smog",
"chib",
"trong",
"glorp",
"thorp",
"jorf",
"sklim",
"splib",
"frib",
"quax",
"florg",
"grax",
"plax",
"zlim",
"swop",
"blimp",
"frax",
"sclab",
"jank",
"sprog",
"thorp",
"snorb",
"glap",
"plig",
"frink",
"gronk",
"splort",
"sprol",
"flong",
"snib",
"quib",
"sklorsh",
"thwib",
"glorp",
"zlop",
"chib",
"sclab",
"grax",
"plax",
"frax",
"jorf",
"trong",
"smog",
"blib",
"quax",
"zlob",
"splax",
"thwog",
"snorb",
"florg",
"gronk",
"sklim",
"frib",
"plig",
"frink",
"sprog",
"glap",
"splort",
"snib",
"jank",
"thorp",
"sclab",
"zlim",
"grax",
"chib",
"frax",
"sclab",
"blib",
"zlob",
"quax",
"glorp",
"thwib",
"gronk",
"sklim",
"splib",
"plax",
"frink",
"trong",
)


//Sign Language


/datum/language/signlanguage
	name = "Sign Language"
	desc = "Those who cannot speak can learn this instead."
	speech_verb = "signs"
	whisper_verb = "gestures"
	key = "9"
	flags = TONGUELESS_SPEECH

	syllables = list(".")

	icon_state = "ssl"
	default_priority = 90

//pokemon language

#define LANGUAGE_POKEMON "Poke-Speak"

/datum/language/pokemon
	name = LANGUAGE_POKEMON
	desc = "The language spoken and understood by all Pokemon. Consists mostly of short syllables"
	speech_verb = "says"
	ask_verb = "asks"
	exclaim_verb = "exclaims"
	whisper_verb = "whispers"
	key = "`"
	icon_state = "poke"
	syllables = list(
		"pika", "chu", "dra", "tini", "vul", "pix", "zora", "glac", "eon", "ee", "vee",
		"quaza", "ray", "jol", "esp", "nite", "nair", "flaa", "ffy", "might", "yena", "pooch",
		"pony", "ta", "zu", "bat", "pin", "cer", "mag", "mar", "magi", "carp", "lap", "ras",
		"kabu", "to", "aero", "dac", "tyl", "licki", "tung", "cu", "bone", "snor", "lax",
		"mew", "two", "syl", "veon", "arti", "cuno"
	)

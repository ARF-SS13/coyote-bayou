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
*/

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
#define LANGUAGE_CANINE "Canine Language"
#define LANGUAGE_SQUIRREL "Squirrel Language"
#define LANGUAGE_SERGAL "Sergal Language"
#define LANGUAGE_MOUSE "Mouse Language"
#define LANGUAGE_BIRDSONG "Birdsong Language"
#define LANGUAGE_RABBIT "Rabbit Language"
#define LANGUAGE_INSECT "Insect Language"
#define LANGUAGE_OLDCOMMONNORSE "fictional norse language"
#define LANGUAGE_SPACER "Fictional Russian language"

/datum/language/pokemon
	name = LANGUAGE_POKEMON
	desc = "The language spoken and understood by all Pokemon. Consists mostly of short syllables"
	speech_verb = "says"
	ask_verb = "asks"
	exclaim_verb = "exclaims"
	whisper_verb = "whispers"
	key = "P"
	icon_state = "poke"
	syllables = list(
		"pika", "chu", "dra", "tini", "vul", "pix", "zora", "glac", "eon", "ee", "vee",
		"quaza", "ray", "jol", "esp", "nite", "nair", "flaa", "ffy", "might", "yena", "pooch",
		"pony", "ta", "zu", "bat", "pin", "cer", "mag", "mar", "magi", "carp", "lap", "ras",
		"kabu", "to", "aero", "dac", "tyl", "licki", "tung", "cu", "bone", "snor", "lax",
		"mew", "two", "syl", "veon", "arti", "cuno"
	)

//Canine
/datum/language/canine
	name = LANGUAGE_CANINE
	desc = "The guttural language spoken by canines, composed of growls, barks, yaps, and heavy utilization of ears and tail movements."
	speech_verb = "rrrfts"
	ask_verb = "rurs"
	exclaim_verb = "barks"
	icon_state = "canine"
	key = "V"
	syllables = list("rur","ya","cen","rawr","bar","kuk","tek","qat","uk","wu","vuh","tah","tch","schz","auch", \
	"ist","ein","entch","zwichs","tut","mir","wo","bis","es","vor","nic","gro","lll","enem","zandt","tzch","noch", \
	"hel","ischt","far","wa","baram","iereng","tech","lach","sam","mak","lich","gen","or","ag","eck","gec","stag","onn", \
	"bin","ket","jarl","vulf","einech","cresthz","azunein","ghzth")

//Squirrel

/datum/language/squirrel
	name = LANGUAGE_SQUIRREL
	desc = "The native tongue squirrels. Squirrelkin and other beastkins can use their ears and tails in addition to speech to communitcate."
	speech_verb = "squeaks"
	whisper_verb = "whispers"
	exclaim_verb = "chitters"
	icon_state = "acorn"
	key = "S"
	syllables = list("sque","sqah","boo","beh","nweh","boopa","nah","wah","een","sweh")

//sergal

/datum/language/sergal
	name = LANGUAGE_SERGAL
	desc = "The dominant language of the Sergals It consists of aggressive low-pitched hissing and throaty growling."
	speech_verb = "snarls"
	key = "T"
	icon_state = "cheese"
	syllables = list ("grr", "gah", "woof", "arf", "arra", "rah", "wor", "sarg")

//scandanavian. Icelandic, Norway, etc etc. A mix of languages to make one fictional one.
/datum/language/fictionalnorse
	name = LANGUAGE_OLDCOMMONNORSE
	desc = "A combination of a few germanic and norse languages. Used in the 2100s as a new and recent language between the Scandinavian countries of the old world."
	speech_verb = "says"
	syllables = list("errð", "rréö", "klúþk", "háðlofmifáéng", "arálúbitae", "stueþming", "infélðming", "jávéþa", "asølo", "chåsørr", "sanæ", "elomøt", "Bluidd", "hvorre", "javoot", "pånseelo", "hanso",
		"sårrð", "ånð", "detðrk", "attalof", "nåbð", "göð", "brað", "inteð", "tyckaeð", "omð", "närð",
		"tvåsa", "måerð", "dag", "sjäk", "viið", "vuð", "eilso", "tunf", "käyt", "teherrok", "vähake",
		"heighð", "huelf", "soðklok", "äsðple", "tenð", "jað", "heust", "sturf", "uhrkree", "könokree", "wekree", "hönsð")
	whisper_verb = "whispers"
	key = "G"
	icon_state = "combinednorse"
	icon = 'icons/misc/language.dmi'

/datum/language/technorussian
	name = LANGUAGE_SPACER
	desc = "An ancient language used by cosmonaut colonists of various colonized planets during the 2100s. How the language ended up here is beyond anyone's guess."
	icon_state = "oldrussian"
	icon = 'icons/misc/language.dmi'
	speech_verb = "proclaims"
	ask_verb = "queries"
	exclaim_verb = "declares"
	whisper_verb = "hushes"
	key = "2"
	space_chance = 70
	default_priority = 98
	syllables = list("zhena", "reb", "kot", "tvoy", "vadka", "byad", "verbovka", "ponimat", "zhit", "kley", "sto", "yat", "si", "det", \
	"re", "be", "nok", "chto", "techo", "kak", "govor", "navernoe", "da", "net", "horosho", "pochemu", "pivet","lubov", \
	"ebat", "krovat", "stol", "za", "ryad", "ka", "voyna", "dumat", "patroni", "tarakanu", "zdorovie", "day", "dengi", \
	"pizdec", "mat", "tvoyu", "suka", "ayblya", "uebok", "sosi", "ebi", "huyar", "trahat", "pizda", "uebu", "zaebal", "zgorela", \
	"pizduy", "srat", "naydu", "ubyi", "uebishe", "blyadina", "priebali", "prosrali", "suche", "voituyay", "tupoy", "daun", "churka", \
	"nelez", "sovershenstvo", "viju", "stradaniye", "smusl", "spaseniye", "pomosh", "zvezdu", "kosmos", "pokorim", "lublu", "bereza",  \
	"zashishu", "luna", "planeta", "voshod", "mercaet", "smeshno", "razum", "trud", "mucheniya", "chudo", "borba", "sudba", "svoboda", \
	"provodimost", "inicializaciya", "compilaciya", "izolaciya", "teplootdacha", "izlucheniye", "osnasheniye", \
	"vidimost", "indukciya", "ionizaciya", "laser", "svyaz", "provodka", "atmosfera", "davleniye", "temperatura", \
	"obyem", "massa", "scorost", "uskoreniye", "radiaciya", "ves", "neobhodimost", "dokozatelstvo", "teorema", "kipeniye", \
	"inovaciya", "proruv", "turbulentnost", "zashita", "pitaniye", "zamukaniye", "korotkoye", "dlennoye", "verticalno", \
	"portal", "systema", "electronika", "nagilizm", "anarhizm", "comustu", "tupuye", "sopla", "obshivka", "obtekaemost", \
	"dinamica", "statica", "oganizacuya", "yeyenet", "rayio", "peredacha", "priem", "slushno", "chastota", "gerts", "stantiya", \
	"suda", "huyar", "odmin", "dva", "tri", "holod", "grata", "ne", "re", "ru", "korabl")

/datum/language/serbian
	name = "Serbian"
	desc = "A language native to the pre-war slavs of the Balkans. How speakers of it got to Texarkana is anyone's guess."
	key = "sr"
	icon_state = "serbian"
	syllables = list("zdravo", "hvala", "dobro jutro", "dobar dan", "laku noć", "molim", "izvinite", "da", "ne", "kako si?", "ime", "grad", "planina", "reka", "more", "sunce", "mesec", "zvezda", "voće", "povrće", "voda", "vino", "kafa", "čaj", "hleb", "mleko", "sir", "meso", "riba", "ptica", "pas", "mačka", "kuća", "stan", "soba", "krevet", "stolica", "sto", "telefon", "računar", "knjiga", "olovka", "papir", "škola", "univerzitet", "profesor", "učenik", "posao", "novac", "trgovina", "restoran", "putovanje", "avion", "autobus", "voz", "automobil", "bicikl", "pesma", "film", "televizija", "internet", "sport", "fudbal", "košarka", "tenis", "plivanje", "planiranje", "poseta", "zabava", "ljubav", "prijatelj", "porodica", "roditelj", "brat", "sestra", "dečko", "devojka", "venčanje", "rođendan", "sreća", "svetlo", "tama", "boja", "crvena", "plava", "zelena", "žuta", "crna", "bela", "cvet", "drvo", "cveće", "trava", "zemlja", "nebo", "vazduh", "vatra", "led", "toplo", "hladno", "brz", "spor", "visok", "nizak", "dugačak", "kratko", "glasan", "tih", "smešno", "tužno", "lepo", "ružno", "srećan", "tužan")


//Mouse

/datum/language/mouse
	name = LANGUAGE_MOUSE
	desc = "A language native to most rodent kind."
	key = "E"
	speech_verb = "squeaks"
	whisper_verb = "squiks"
	exclaim_verb = "squeaks loudly"
	icon_state = "mouse"
	syllables = list ("squeek",
"skweek",
"sqeak",
"squek",
"sqweek",
"skwek",
"skweeq",
"sqeek",
"sqeac",
"sqwek",
"sqeik",
"skwiek",
"squeac",
"sqweek",
"skwique",
"chitter",
"chiter",
"chetter",
"cheeter",
"chiter",
"chitir",
"chitteer",
"cheetur",
"chitter",
"chetter",
"chiteek",
"cheetir",
"chitter",
"chiteer",
"chittir",
"sniffle",
"snifel",
"snifful",
"sniffel",
"sneffle",
"sneeful",
"sniffol",
"snifl",
"sneefle",
"sniffl",
"snifkle",
"sniffeel",
"snifl",
"sneeful",
"sniffil",
"hiss",
"hiz",
"hisss",
"hissle",
"hise",
"hys",
"hess",
"hss",
"hiss",
"hizze",
"hissel",
"hisse",
"hyss",
"hisz",
"hissl",
"chirp",
"chirpp",
"chirpe",
"cheerp",
"chrip",
"churp",
"chrp",
"chirrp",
"cheerpe",
"chhirp",
"churpp",
"cheeerp",
"chirp",
"chhirpe",
"chirpep",)

/datum/language/birdsong
	name = LANGUAGE_BIRDSONG
	desc = "A language primarily spoken by birds"
	speech_verb = "chirps"
	key = "G"
	icon_state = "bird"
	syllables = list ("cheep", "peep", "tweet")

/datum/language/rabbit
	name = LANGUAGE_RABBIT
	desc = "A language primarily spoken by rabbits."
	speech_verb = "squeaks"
	key = "G"
	icon_state = "carrot"
	syllables = list ("scream",
"screeem",
"screem",
"skream",
"skreem",
"scraem",
"skreep",
"skreem",
"skriim",
"screme",
"skreem",
"screm",
"skreim",
"screap",
"skrim",
"purr",
"per",
"puur",
"prrr",
"perre",
"pur",
"prr",
"perri",
"purrr",
"perr",
"purrre",
"puuur",
"prrrr",
"perre",
"purr",
"prre",
"purr",
"prrre",
"perre",
"purr",
"prrr",
"pur",
"puuur",
"prr",
"purrre",
"perri",
"purrr",
"per",
"prrrr",
"pur",
"purr",
"purr",
"prrre",
"pur",
"prr",
"puur",
"purrre",
"per",
"prrr",
"puuur",
"pur",
"perri",
"purr",
"skreep",
"screap",
"skrim",
"screme",
"screm",
"skreem",
"skriim",
"skreim",
"skream",
"screeem",
"screem",
"scraem",
"scream",
"purr",
"per",
"puur",
"prrr",
"perre",
"pur",
"prr",
"perri",
"purrr",
"perr",
"purrre",
"puuur",
"prrrr",
"perre",
"purr",
"prre",
"purr",
"prrre",
"perre",
"purr",
"prrr",
"pur",
"puuur",
"prr",
"purrre",
"perri",
"purrr",
"per",
"prrrr",
"pur",
"growl",
"growle",
"grrrowl",
"groul",
"grrrrowl",
"grrowl",
"grawl",
"growll",
"growlee",
"growlll",
"grwol",
"grrawll",
"growl",
"grrawle",
"grrrrawl",
"grrrwole",
"growle",
"grrrwole",
"grrawl",
"growl",
"growle",
"grrrwole",
"growwll",
"grrwole",
"grrrwole",
"growl",
"grrwol",
"grawwl",
"grrwole",
"growl",
"grrawle",
"grrwawl",
"growl",
"grawwl",
"growl",
"grrwol",
"growle",
"grrwole",
"growl",
"grrawle",
"grrrrawl",
"grrrwole",
"growle",
"grrrwole",
"grrawl",
"growl",
"growle",
"grrrwole",
"growwll",
"grrwole",
"grrrwole",
"growl",
"grrwol",
"grawwl",
"grrwole",
"growl",
"grrawle",
"grrwawl",
"growl",)

/datum/language/bug
	name = LANGUAGE_INSECT
	desc = "A jarring and clicky language developed and used by most bugs, it is designed for use with mouthparts and as a result has become a common language for various arthropod species."
	speech_verb = "clicks"
	ask_verb = "chitters"
	exclaim_verb = "rasps"
	key = "X"
	icon_state = "bug"
	syllables = list("vaur","uyek","uyit","avek","sc'theth","k'ztak","teth","wre'ge","lii","dra'","zo'","ra'","kax'","zz","vh","ik","ak",
	"uhk","zir","sc'orth","sc'er","thc'yek","th'zirk","th'esk","k'ayek","ka'mil","sc'","ik'yir","yol","kig","k'zit","zrk","krg","isk'yet","na'k",
	"sc'azz","th'sc","nil","n'ahk","sc'yeth","aur'sk","iy'it","azzg","a'","i'","o'","u'","a","i","o","u","zz","kr","ak","nrk","tzzk","bz","xic'","k'lax'","histh")

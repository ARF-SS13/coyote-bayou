/*
	Defines for use in saycode and text formatting.
	Currently contains speech spans and message modes
*/



//Spans. Robot speech, italics, etc. Applied in compose_message().
#define SPAN_ROBOT "robot"
#define SPAN_YELL "yell"
#define SPAN_ITALICS "italics"
#define SPAN_SANS "sans"
#define SPAN_PAPYRUS "papyrus"
#define SPAN_REALLYBIG "reallybig"
#define SPAN_COMMAND "command_headset"
#define SPAN_CLOWN "clown"
#define SPAN_SINGING "singing"

//bitflag #defines for return value of the radio() proc.
#define ITALICS 1
#define REDUCE_RANGE 2
#define NOPASS 4

//Eavesdropping
#define EAVESDROP_EXTRA_RANGE 1 //how much past the specified message_range does the message get starred, whispering only

// A link given to ghost alice to follow bob
#define FOLLOW_LINK(alice, bob) "<a href=?src=[REF(alice)];follow=[REF(bob)]>(F)</a>"
#define TURF_LINK(alice, turfy) "<a href=?src=[REF(alice)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(T)</a>"
#define FOLLOW_OR_TURF_LINK(alice, bob, turfy) "<a href=?src=[REF(alice)];follow=[REF(bob)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(F)</a>"

#define LINGHIVE_NONE 0
#define LINGHIVE_OUTSIDER 1
#define LINGHIVE_LING 2
#define LINGHIVE_LINK 3

//whether the emote is visible or audible.
#define EMOTE_VISIBLE 1
#define EMOTE_AUDIBLE 2

//Don't set this very much higher then 1024 unless you like inviting people in to dos your server with message spam //Tk here, why don't you just deal with shitters at the gate?
#define MAX_MESSAGE_LEN			10000		//Citadel edit: What's the WORST that could happen? //Edited to 10,000 by CB.  The worst that could happen is me. ~TK420634
#define MAX_FLAVOR_LEN			4096
#define MIN_FLAVOR_LEN			100
#define MIN_OOC_LEN				20 // Will not allow just smileys to be on OOC notes.
#define MAX_TASTE_LEN			40
#define MAX_NAME_LEN			82 // Kekekkeeke
#define MAX_BROADCAST_LEN		512
#define MAX_CHARTER_LEN			80

// Template for OOC notes.
#define OOC_NOTE_TEMPLATE "Non-ERP Notes\n\
	This exist for things like how to approach this character for IC things such as how to ask for going on adventurers!\n\
	DELETE THIS LINE WHEN DONE. This person hasn't changed the info yet!\n\
	\n\
	Icebreaker!\n\
	This exists for this person to have set a quick way for you to break the IC with their character in a way that may lead to ERP, but this person hasn't changed this text to set one!\n\
	\n\
	ERP Notes\n\
	...............Erotic Roleplay: Ask\n\
	...............Partner Prefs: Ask\n\
	***Roleplay Prefs***\n\
	Character Orientation: Ask\n\
	...Desired Post length: Ask\n\
	\n\
	...Desired RP System: Ask, this is for subtle, subtler, or emote.  Or, when its added, a mechanical erotic roleplay system!  Or some mix inbetween, but this person hasn't changed the text so ASK!\n\
	\n\
	The Gigantic Placeholder Kink List\n\
	We suggest using an 'O' for selecting pref ranking.\n\
	Just delete the space between the brackets and put it in there.\n\
	\n\
	ALSO FEEL FREE TO ADD OR DELETE ANY KINKS YOU WANT, OR ADD A LINE BELOW ONE FOR EXTRA,\n\
	INFORMATION.  THIS LIST IS QUITE LONG, AND NEEDS TO BE DONE IN TGUI.\n\
	\n\
	It's safe to assume if someone has deleted a kink they likely just do not care for it.\n\
	--------------------\n\
	General Kinks\n\
	Ahegao - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Aphrodisiacs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Condoms - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Crotch Sniffing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Drug/Alcohol Use - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Flexibility/Contortionism - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Food Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Foreplay - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Ice - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Inflatables - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Interracial - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Multiple Orgasms - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Natural Musk - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Objectophilia - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Onomatapoeia - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Potions/Injections - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sex Toys - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sexual Exhaustion - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sexual Frustration - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Shaving - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Smoking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Stomach Bulging - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Strap-Ons - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	STuackage - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sweat - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tail Pulling - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Teasing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tickling - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Character Preferences\n\
	Amputees - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anatomicaly Correct - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Androgyny - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Animal Anatomy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anthro Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Barbed Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Body Hair - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Canon Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Chubby - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cut Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Disabilities - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Exotic Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Facial Hair/Beards - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fangs/Sharp Teeth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Femboys - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Femininity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Genital/Nipple Piercings - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hirsute/Hairy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Horns - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Human Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Asses - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Balls - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Breasts - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Fat - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Muscle - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Vaginas - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Voluptous - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Very Intelligent Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Knotted Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Large Asses - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Large Balls - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Large Breasts - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Large Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Large Tails - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Macro Asses - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Macro Balls - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Macro Breasts - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Macrophilia - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Magic Users - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Masculinity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Microphilia - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Moobs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Multi Genitalia - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Multiple Breasts - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Muscular Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Nonsexual Piercings - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Older Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Prehensile Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Pubic Hair - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Quadrupeds - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Rubber/Elastic Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sheaths - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Shorter Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Size Differences (1-3 Feet) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Size Differences (Micro/Macro) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Skinny Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Slime/Goo characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Small Breasts - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Small Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tails - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Taller Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tattoos/Body Art - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tentatcles - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tomboys - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Twinks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Udders - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Uncut Cocks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Very Fat Charactwers - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Very Lithe Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Very Muscular Characters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Voluptuousness - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Wings - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Gender Preferences\n\
	C-boys - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Females - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hermaphrodites - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Male-Herms - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Males - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Nonbinary - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Shemales - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Trans Females - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Transgender - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Trans Males - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Species Preferences\n\
	Amphibians - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Angels - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Animals/Ferals - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Avians - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Bats - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Bovines - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Canines - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Goats/Sheep - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Deer/Elk/Moose - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Demons - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Digimon - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Dinosaurs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Dragons - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Driders - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Elves - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Equines - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Exotic Species - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fae - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Felines - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fish/Sharks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Humanoids - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Humans - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyenas - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Insects/Spiders - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Kemonomimimi/Catgirls - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Lamia/Naga - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Rabbits/Hares/Bnnuys - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Werecreatures - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Mammals - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Marines Mammals - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Marsupials - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Skunks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Molluscs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Monkeys/Primates - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Monsters - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Ferrets/Minks/Weasels - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	My Little Pony - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Orcs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Parasites - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Plants - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Pokemon - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Predator Species - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Prey Species - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Raccoons/Procyonids - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Reptiles - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Robots/Cyborgs/Androids - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Rodents/Murines - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Taurs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Undead - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Bears - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vampires - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vulpines - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Xenos/Aliens - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Anal Sex & Play Prefernces\n\
	Anal Fisting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anal Prolapse - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anal Sex (Giving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anal Sex (Receiving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anal Training - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anal Virginity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Enemas - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fingering (Anal) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Gaping (Anal) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Pegging - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Prostate Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Rimming (Giving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Rimming (Receiving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Vaginal Sex & Play Preferences\n\
	Cervical Penetration - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Clit Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fingering (Vaginal) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Gaping (Vaginal) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Pussy Worship - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Queefing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Squirting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tribadism/Scissoring - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vaginal Fisting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vaginal Prolapse - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vaginal Sex (Giving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vaginal Sex (Receiving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vaginal Virginity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Oral Sex & Play\n\
	Ass To Mouth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Auto-Fellatio - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cunnilingus (Giving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cunnilingus (Receiving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Face-Fucking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Face-Sitting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fellatio (Performing) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fellatio (Receiving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fingers in Mouth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Kissing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Licking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Oral Fixation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Oral Sex (Giving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Oral Sex (Receiving) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Oral Virginity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Saliva - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Teeth Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Throat Penetration - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Cock Play\n\
	Cock/Ball Smothering - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cock/Ball Worship - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cock Fucking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cock Slapping - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cock Warming - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Docking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Flaccid Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Foreskin Worship - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Frotting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sheath Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Cum Related\n\
	Bukkake - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Creampie - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum Bath - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum Enemas - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum From Mouth/Nose - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum Marking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum Milking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum On Clothes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum Vomit - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Excessive Precum - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Excessive Semen - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Felching - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hard Cum Facials - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Heavily Excessive Precum - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Heavily Excessive Semen - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Internal Cumshots - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Premature Ejaculation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Realistic Cum - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Shooting Precum - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sloppy Seconds - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Snowballing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Soft Cum Facials - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Thick/Sticky Cum - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Unusual Semen - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Penetrations & Sexual Themes\n\
	3+ Penetrations - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	All The Way Through - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Double Penetration - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Extreme Tightness - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Gangbangs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Knotting/Tying - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Living Insertions - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Nipple Penetrations - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Somnophilia - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sounding - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tailsex - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Tantric Sex - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Urethra Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vanilla Sex - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Roleplaying Preferences\n\
	Approaching IC - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Approaching OOC - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Instant Hookups - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Nonsexual Roleplay - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Plot Twists - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Public Area Roleplay - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sex Driven Roleplay - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Story Driven Roleplay - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Themes & Setting Preferences\n\
	Adultery - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Affection - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Bad Ends - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Competition - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Consensual Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cuckolding - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Dating RP - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Dub-Con - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fighting/Wrestling Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Horror Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Humor/Comedy Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Incest Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Incest (Siblings) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Incest (Of Age Parental) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Inexperienced Partners - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Informal Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Kidnapping Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Medical Play Scenes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Military Themes - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Multiple Partners - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Non-Con - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Photography/Videotaping - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Polyamory - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Prostitution RP - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Pseudo-NonCon - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Roleplay within Roleplay - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Romance - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sexism - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Small Dom/Big Sub - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Speciesism - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	STDs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Very Experienced Partners - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Voyeurism - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Weapon Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Body Worship & Play\n\
	Armpits - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Ass Worship - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Belly Fucking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Belly Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Body Writing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Breast/Nipple Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Breast/Nipple Worship - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Breast Smothering - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cuddling - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Ear Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fat Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Foot Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Handjobs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hand Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hotdogging - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Lactation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Intercrural Sex - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Lactation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Massages - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Maturbation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Muscle Worship - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Navel Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Nursing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Paw Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Titfucking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Dress Up & Material Preferences\n\
	Clothed Sex - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Clothing Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Crossdressing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Footgear Worship - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Forced Clotheswearing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Glasses - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Latex/Rubber - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Leather - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Masks - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sexy/Slutty Clothing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Socks/Stockings - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Strip Tease - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Underwear - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Underwear Bulges - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Uniforms - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Wardrobe Malfunctions - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Dom/Sub & Psyche Play\n\
	Begging - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Chastity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Coercion/Blackmail - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Corruption - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Degredation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Dirty Talking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Discipline/Reinforcement - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Extreme Humiliation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Fear - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Femdom - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Feminization - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Forced Incest - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Forced Nudity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Force Feeding - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Humiliation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hypnotism/Mind Control - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Impotence - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Lima Syndrome - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Master/Pet Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Master/Slave Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Mental Torture - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	objectification - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Orientation play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Physical Restraints - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Possessiveness/Jealousy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Powerbottoming - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Puppy/Pony/Kitty Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sexual Restraints - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Stockholm Syndrome - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Uppity - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Verbal Abuse - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	BDSM\n\
	Aftercare - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Blindfolds - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Caging - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Coiling - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Crying - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Electric Toys - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Flogging/Whipping - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Gags - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hand Cuffs - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Leash/Collar - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Orgasm Control/Denial - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sensory Deprivation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Roughness/Pain Play\n\
	Abuse - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Ballbusting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Biting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Breath Control - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Choking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Crushing (Living) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Crushing (Objects) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Face Slapping - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hair Pulling - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sadism/Masochism - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Scratching - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sexual Pain - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Spanking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Violence - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Wax Play - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Gore/Torture/Death\n\
	Remember that most of these need to be done in Subtles.  Use with caution.\n\
	Abrasions - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Bloodplay - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Branding - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Breast/Nipple Torture - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Burning - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Castration - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Death - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Emasculation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Execution/Murder - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Genital Torture - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Gore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Impalement - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Mensis - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Mutiliation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Necrophilia - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Nonsexual Pain - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Nonsexual Torture - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Piercing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Sexual Torture - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Swallowing Blood - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Inflation, Growth, & Sizeplay\n\
	Ass Growth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Breast Growth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cock/Ball Growth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cum Inflation (Heavy/Extreme) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Forced Growth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Growth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Growth (Macro) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Muscle Growth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Immobilization - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Inflation (Heavy/Extreme) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Inflation (Light/Medium) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Muscle Growth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Shrinking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Shrinking (Micro) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Weight Gain (Heavy/Extreme) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Weight Loss - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Transformation\n\
	Animal Transformations - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Gender Transformations - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Species Transformations - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Supernatural Transformations - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Transformation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Pregnancy & Breeding\n\
	Alternative Pregnancy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anal Pregnancy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Birthing (On screen) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Birthing (Off screen) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Breeding - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Extreme Pregnancy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Heat/Rut - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Impregnation - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Male Pregnancy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Oviposition - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Pregnancy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Risk of Pregnancy - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Vore & Unbirth\n\
	Absorption - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Alternative Vore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Anal Vore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cannibalism - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cock Vore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Cooking (Vore) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Digestion - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Disposal - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hard Vore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Realistic Vore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Soft Vore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Unbirthing - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Unrealistic Vore - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vore (Being Predator) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vore (Being Prey) - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
	--------------------\n\
	Unclean Themes & Play\n\
	Remember that most of these need to be done in Subtles, use with caution.\n\
	Belching/Burping - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Dirty Feet - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Extreme Musk - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Farting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Filth - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Slob - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Smegma - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Swallowing Vomit - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Unwashed Musk - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Vomiting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	\n\
		--------------------\n\
	Watersports & Scat\n\
	Remember that ALL of these need to be done in Subtles.\n\
	Bathroom Control - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Hyper Scat - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Marking - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Piss Enemas - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Scat - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Scat Torture - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Soiling - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Swallowing feces - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Swallowing Urine - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Watersports - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	Wetting - Fav [ ], Yes [ ], Maybe [ ], No [ ]\n\
	"




	
	



#define BACKGROUND_INFO_NOTE_TEMPLATE "Background Info Template\n\
	Keep in mind that you do not need to have answers for all of these questions from the word go, but having answers for some of them should greatly improve your playing experience due to it solidifying your character more robustly in a very fluid world.\n\
	BiG FeNnys wIdE waRning: So, I'm passing this information to you as a player on my own server with thousands of hours roleplaying here.  While I understand that shy people do absolutely exist and that playing one may be something that you want to do (or maybe you just are shy and your character is as well by extension) understand that the more of these answers you can define the better off you're going to be.  Being shy here is much like being shy in the real world, you often end up spending a lot of time by yourself.  If that is not your long term goal then you should, by all means, do what you can to fight back against your shyness.  Because I can say with all certainty that if its people you want to hang out with standing alone on top of a building wishing that you were talking to someone is about the slowest way to find someone to actually talk to.\n\
	\n\
	1. What is your characters background?  What setting are they from?  How did they get to the Texarkana Area?  What do they think of the place they've found themselves in?\n\
	\n\
	Answer: \n\
	\n\
	\n\
	2. How does your character show themselves to others. Are they straight forward, whimsical, snarky, etc.  Do they have any obvious goals?  Any hidden goals?\n\
	\n\
	Answer: \n\
	\n\
	\n\
	3. How do they feel about strangers?  How do they feel about the different towns in the area?  How do they show friendship or dislike?\n\
	\n\
	Answer: \n\
	\n\
	\n\
	4. What motivates your character to take the actions that they do.  Why do you, or don't you, go out and explore the wasteland?  Why do you, or don't you, hang out with large groups of other people?\n\
	\n\
	Answer: \n\
	\n\
	\n\
	5. How does your character handle stress?  Does your character have any particularly noticeable ticks?  An example would be a twitching eyebrow when angry, or lashing their tail like a cat when upset.  Or maybe even just wagging their tail when happy.  Stuff like that.\n\
	\n\
	Answer: \n\
	\n\
	\n\
	6. What in life matters the absolute most to your character.  Be that possessions, or people, or whatever.  What is it that they just can't either get enough of or love with all of their being.  What do they hate with all of their being as well.\n\
	\n\
	Answer: \n\
	\n\
	\n\ "


// Is something in the IC chat filter? This is config dependent.
#define CHAT_FILTER_CHECK(T) (config.ic_filter_regex && findtext(T, config.ic_filter_regex))

// Audio/Visual Flags. Used to determine what sense are required to notice a message.
#define MSG_VISUAL (1<<0)
#define MSG_AUDIBLE (1<<1)

//Used in visible_message_flags, audible_message_flags and runechat_flags
#define EMOTE_MESSAGE (1<<0)
// Only show the overhead thing
#define ONLY_OVERHEAD (1<<1)
// Append the player's name to the front
#define PUT_NAME_IN (1<<2)

#define EMOTE_HEADER_TEXT "\
	The Following Chat Functions Exist \n\
	- _text_ underlines text, +text+ bolds text, and |text| italicizes text. \n\
	-- Works in Emote, Subtle, Say, Whisper and Radio chat. \n\
	\n\
	- %text lets you siiiing. \n\
	\n\
	- @ moves your name to that position in emotes and subtles. \n\
	\n\
	- ! at the start of a radio comm to emote over the radio \n\

	\n\
	We have added the following emoticons to say, add them to the end of your 'say' messages for say verb variation \n\
	:), :(, :D, ;D, :P, :O, :|, :/, :S, :*, :3, :>, :<, :C, :L, <3, :X, :#, :$,  \n\
	:@, :^), :&, :!, :?, B^U, :B, :J, >:(, >:D, >:P, >:3, >:O, >:|, >:/, >:S,  \n\
	"
//Dan is the best, <3 ~TK
//put space before the \ so it reads properly
// use \ for readability, but one big line. \n for a new line. \n\ for a new line and readability.

//Preferences stuff
	//Hairstyles
GLOBAL_LIST_EMPTY(hair_styles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(hair_styles_male_list)		//stores only hair names
GLOBAL_LIST_EMPTY(hair_styles_female_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hair_styles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
GLOBAL_LIST_EMPTY(facial_hair_styles_male_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hair_styles_female_list)	//stores only hair names
	//Underwear
GLOBAL_LIST_EMPTY_TYPED(underwear_list, /datum/sprite_accessory/underwear/bottom)		//stores bottoms indexed by name
GLOBAL_LIST_EMPTY(underwear_m)	//stores only underwear name
GLOBAL_LIST_EMPTY(underwear_f)	//stores only underwear name
	//Undershirts
GLOBAL_LIST_EMPTY_TYPED(undershirt_list, /datum/sprite_accessory/underwear/top) 	//stores tops indexed by name
GLOBAL_LIST_EMPTY(undershirt_m)	 //stores only undershirt name
GLOBAL_LIST_EMPTY(undershirt_f)	 //stores only undershirt name
	//Socks
GLOBAL_LIST_EMPTY_TYPED(socks_list, /datum/sprite_accessory/underwear/socks)		//stores socks indexed by name
	//Lizard Bits (all datum lists indexed by name)
GLOBAL_LIST_EMPTY(tails_list_lizard)
GLOBAL_LIST_EMPTY(animated_tails_list_lizard)
GLOBAL_LIST_EMPTY(snouts_list)
GLOBAL_LIST_EMPTY(horns_list)
GLOBAL_LIST_EMPTY(frills_list)
GLOBAL_LIST_EMPTY(spines_list)
GLOBAL_LIST_EMPTY(legs_list)
GLOBAL_LIST_EMPTY(animated_spines_list)

	//Mutant Human bits
GLOBAL_LIST_EMPTY(tails_list_human)
GLOBAL_LIST_EMPTY(animated_tails_list_human)
GLOBAL_LIST_EMPTY(ears_list)
GLOBAL_LIST_EMPTY(wings_list)
GLOBAL_LIST_EMPTY(wings_open_list)
GLOBAL_LIST_EMPTY(deco_wings_list)
GLOBAL_LIST_EMPTY(r_wings_list)
GLOBAL_LIST_EMPTY(insect_wings_list)
GLOBAL_LIST_EMPTY(insect_fluffs_list)
GLOBAL_LIST_EMPTY(insect_markings_list)
GLOBAL_LIST_EMPTY(caps_list)

	//Dragon bits
GLOBAL_LIST_EMPTY(derg_body_list)
GLOBAL_LIST_EMPTY(derg_belly_list)
GLOBAL_LIST_EMPTY(derg_mane_list)
GLOBAL_LIST_EMPTY(derg_ear_list)
GLOBAL_LIST_EMPTY(derg_eye_list)
GLOBAL_LIST_EMPTY(derg_horn_list)


//a way to index the right bodypart list given the type of bodypart
GLOBAL_LIST_INIT(mutant_reference_list, list(
	"tail_lizard" = GLOB.tails_list_lizard,
	"waggingtail_lizard" = GLOB.animated_tails_list_lizard,
	"tail_human" = GLOB.tails_list_human,
	"waggingtail_human" = GLOB.animated_tails_list_human,
	"spines" = GLOB.spines_list,
	"waggingspines" = GLOB.animated_spines_list,
	"snout" = GLOB.snouts_list,
	"frills" = GLOB.frills_list,
	"horns" = GLOB.horns_list,
	"ears" = GLOB.ears_list,
	"wings" = GLOB.wings_list,
	"wingsopen" = GLOB.wings_open_list,
	"deco_wings" = GLOB.deco_wings_list,
	"legs" = GLOB.legs_list,
	"insect_wings" = GLOB.insect_wings_list,
	"insect_fluff" = GLOB.insect_fluffs_list,
	"insect_markings" = GLOB.insect_markings_list,
	"derg_body" = GLOB.derg_body_list,
	"derg_belly" = GLOB.derg_belly_list,
	"derg_horns" = GLOB.derg_horn_list,
	"derg_mane" = GLOB.derg_mane_list,
	"derg_ears" = GLOB.derg_ear_list,
	"derg_eyes" = GLOB.derg_eye_list,
	"caps" = GLOB.caps_list,
	"ipc_screen" = GLOB.ipc_screens_list,
	"ipc_antenna" = GLOB.ipc_antennas_list,
	"mam_tail" = GLOB.mam_tails_list,
	"mam_waggingtail" = GLOB.mam_tails_animated_list,
	"mam_body_markings" = GLOB.mam_body_markings_list,
	"mam_ears" = GLOB.mam_ears_list,
	"mam_snouts" = GLOB.mam_snouts_list,
	"taur" = GLOB.taur_list,
	"xenodorsal" = GLOB.xeno_dorsal_list,
	"xenohead" = GLOB.xeno_head_list,
	"xenotail" = GLOB.xeno_tail_list))


//references wag types to regular types, wings open to wings, etc
GLOBAL_LIST_INIT(mutant_transform_list, list("wingsopen" = "wings",
	"waggingtail_human" = "tail_human",
	"waggingtail_lizard" = "tail_lizard",
	"waggingspines" = "spines",
	"mam_waggingtail" = "mam_tail"))

GLOBAL_LIST_INIT(ghost_forms_with_directions_list, list("ghost")) //stores the ghost forms that support directional sprites
GLOBAL_LIST_INIT(ghost_forms_with_accessories_list, list("ghost")) //stores the ghost forms that support hair and other such things

GLOBAL_LIST_INIT(ai_core_display_screens, list(
	":thinking:",
	"Alien",
	"Angel",
	"Angryface",
	"AtlantisCZE",
	"Banned",
	"Bliss",
	"Blue",
	"Boy",
	"Boy-Malf",
	"Girl",
	"Girl-Malf",
	"Database",
	"Dorf",
	"Firewall",
	"Fuzzy",
	"Gentoo",
	"Glitchman",
	"Gondola",
	"Goon",
	"Hades",
	"Heartline",
	"Helios",
	"Hotdog",
	"Hourglass",
	"House",
	"Inverted",
	"Jack",
	"Matrix",
	"Monochrome",
	"Mothman",
	"Murica",
	"Nanotrasen",
	"Not Malf",
	"Patriot",
	"Pirate",
	"President",
	"Rainbow",
	"Random",
	"Ravensdale",
	"Red October",
	"Red",
	"Royal",
	"Searif",
	"Serithi",
	"SilveryFerret",
	"Smiley",
	"Static",
	"Syndicat Meow",
	"TechDemon",
	"Terminal",
	"Text",
	"Too Deep",
	"Triumvirate",
	"Triumvirate-M",
	"Wasp",
	"Weird",
	"Xerxes",
	"Yes-Man"
	))

/proc/resolve_ai_icon(input)
	if(!input || !(input in GLOB.ai_core_display_screens))
		return "ai"
	else
		if(input == "Random")
			input = pick(GLOB.ai_core_display_screens - "Random")
		return "ai-[lowertext(input)]"

GLOBAL_LIST_INIT(security_depts_prefs, list(SEC_DEPT_RANDOM, SEC_DEPT_NONE, SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY))

//Backpacks
#define DBACKPACK "Department Backpack"
#define DSATCHEL "Department Satchel"
#define DDUFFELBAG "Department Duffel Bag"
GLOBAL_LIST_INIT(backbaglist, list(DBACKPACK, DSATCHEL, DDUFFELBAG, //everything after this point is a non-department backpack
	"Hiking Backpack" = /obj/item/storage/backpack,
	"Service Backpack" = /obj/item/storage/backpack/enclave,
	"Grey Duffel Bag" = /obj/item/storage/backpack/duffelbag,
	"Grey Satchel" = /obj/item/storage/backpack/satchel,
	"Leather Satchel" = /obj/item/storage/backpack/satchel/leather,
	"Bone Satchel" = /obj/item/storage/backpack/satchel/bone,
	"Old Satchel" = /obj/item/storage/backpack/satchel/old,
	"Service Satchel" = /obj/item/storage/backpack/satchel/enclave,
	"Chameleon Backpack" = /obj/item/storage/backpack/chameleon,
	"Inconspicuous Backpack" = /obj/item/storage/backpack/satchel/invisible,
	"Explorer Satchel" = /obj/item/storage/backpack/satchel/explorer,
	"Trekker Backpack" = /obj/item/storage/backpack/trekker,
	"Trekker Satchel" = /obj/item/storage/backpack/satchel/trekker,
	"Marine Backpack" = /obj/item/storage/backpack/trekker/marinepack,
	"Security Backpack" = /obj/item/storage/backpack/security,
	"Security Satchel" = /obj/item/storage/backpack/satchel/sec,
	"Trophy Backpack" = /obj/item/storage/backpack/cultpack,
	"Snail Shell Satchel" = /obj/item/storage/backpack/satchel/snailshell,
	"Black ERT Backpack" = /obj/item/storage/backpack/skyrat/ertodst,
	"Robotics Backpack" = /obj/item/storage/backpack/skyrat/robobackpack,
	"Robotics Satchel" = /obj/item/storage/backpack/satchel/skyrat/robosatchel,
	"Robotics Dufflebag" = /obj/item/storage/backpack/duffelbag/skyrat/roboduffel,
	"Robotics messenger Bag" = /obj/item/storage/backpack/skyrat/robomessenger,
	"HoP Backpack" = /obj/item/storage/backpack/skyrat/hopbackpack,
	"HoP Satchel" = /obj/item/storage/backpack/satchel/skyrat/hopsatchel,
	"HoP Dufflebag" = /obj/item/storage/backpack/duffelbag/skyrat/hopduffel,
	"HoP messenger Bag" = /obj/item/storage/backpack/skyrat/hopmessenger,
	"BlueSecurity Backpack" = /obj/item/storage/backpack/skyrat/securitybackpack,
	"BlueSecurity Satchel" = /obj/item/storage/backpack/satchel/skyrat/securitysatchel,
	"BlueSecurity Dufflebag" = /obj/item/storage/backpack/duffelbag/skyrat/securityduffel,
	"BlueSecurity messenger bag" = /obj/item/storage/backpack/skyrat/securitymessenger,
	"Medical Backpack" = /obj/item/storage/backpack/skyrat/medicalbackpack,
	"Medical Satchel" = /obj/item/storage/backpack/satchel/skyrat/medicalsatchel,
	"Medical Dufflebag" = /obj/item/storage/backpack/duffelbag/skyrat/medicalduffel,
	"Medical messenger Bag" = /obj/item/storage/backpack/skyrat/medicalmessenger,
	"Blueshield Backpack" = /obj/item/storage/backpack/skyrat/blueshieldbackpack,
	"Blueshield Satchel" = /obj/item/storage/backpack/satchel/skyrat/blueshieldsatchel,
	"Blueshield Dufflebag" = /obj/item/storage/backpack/duffelbag/skyrat/blueshieldduffel,
	"Blueshield messenger Bag" = /obj/item/storage/backpack/skyrat/blueshieldmessenger,
	"Bulky Green Bag" = /obj/item/storage/backpack/duffelbag/skyrat/carrybackpackgreen,
	"Bulky Black Bag" = /obj/item/storage/backpack/duffelbag/skyrat/carrybackpackblack,
	"Bulky White Bag" = /obj/item/storage/backpack/duffelbag/skyrat/carrybackpackwhite,
	"Bulky Brown Bag" = /obj/item/storage/backpack/duffelbag/skyrat/carrybackpackbrown,
	"Black messenger Bag" = /obj/item/storage/backpack/skyrat/messengerblack,
	"Dark Blue messenger Bag" = /obj/item/storage/backpack/skyrat/messengercaptain,
	"Purple Accented messenger Bag" = /obj/item/storage/backpack/skyrat/messengerscience,
	"Blue Accented messenger Bag" = /obj/item/storage/backpack/skyrat/messengergenetics,
	"Brown and Orange messenger Bag" = /obj/item/storage/backpack/skyrat/messengerengineering,
	"Brown and Blue messenger Bag" = /obj/item/storage/backpack/skyrat/messengerexplorer,
	"Green and Blue messenger Bag" = /obj/item/storage/backpack/skyrat/messengerhydroponics,
	"Clown messenger Bag" = /obj/item/storage/backpack/skyrat/messengerclown,
	"Medical messenger Bag, alt" = /obj/item/storage/backpack/skyrat/messengermedical,
	"Chemistry messenger Bag" = /obj/item/storage/backpack/skyrat/messengerchemistry,
	"Virology  messenger Bag" = /obj/item/storage/backpack/skyrat/messengervirology,
	"Coronor messenger Bag" = /obj/item/storage/backpack/skyrat/messengercoroner,
	"Cone Shell Bag" = /obj/item/storage/backpack/skyrat/coneshell,
	"Cinammon Shell Bag" = /obj/item/storage/backpack/skyrat/cinnamonshell,
	"Caramel Shell Bag" = /obj/item/storage/backpack/skyrat/caramelshell,
	"Pyramid Shell Bag, white" = /obj/item/storage/backpack/skyrat/pyramidshellwhite,
	"Spiral Shell Bag, white" = /obj/item/storage/backpack/skyrat/spiralshellwhite,
	"Rock Shell Bag, white" = /obj/item/storage/backpack/skyrat/rockshellwhite,
	"Mecha Shell Bag" = /obj/item/storage/backpack/skyrat/mechashell,
	"Pyramid Shell Bag" = /obj/item/storage/backpack/skyrat/pyramidshell,
	"Spiral Shell Bag" = /obj/item/storage/backpack/skyrat/spiralshell,
	"Rock Shell Bag" = /obj/item/storage/backpack/skyrat/rockshell,
	"Purse" = /obj/item/storage/backpack/purse,
	"Purse, black" = /obj/item/storage/backpack/purse/black,
	"Purse, red" = /obj/item/storage/backpack/purse/red,
	"Purse, green" = /obj/item/storage/backpack/purse/green,
	"Purse, blue" = /obj/item/storage/backpack/purse/blue,
	"Purse, yellow" = /obj/item/storage/backpack/purse/yellow, 
	"Purse, cyan" = /obj/item/storage/backpack/purse/cyan,
	"Purse, purple" = /obj/item/storage/backpack/purse/purple,
	))

//Suit/Skirt
#define PREF_SUIT "Jumpsuit"
#define PREF_SKIRT "Jumpskirt"
GLOBAL_LIST_INIT(jumpsuitlist, list(PREF_SUIT, PREF_SKIRT))

//Uplink spawn loc
#define UPLINK_PDA		"PDA"
#define UPLINK_RADIO	"Radio"
#define UPLINK_PEN		"Pen" //like a real spy!
GLOBAL_LIST_INIT(uplink_spawn_loc_list, list(UPLINK_PDA, UPLINK_RADIO, UPLINK_PEN))

//List of cached alpha masked icons.
GLOBAL_LIST_EMPTY(alpha_masked_worn_icons)

	//radical shit
GLOBAL_LIST_INIT(hit_appends, list("-OOF", "-ACK", "-UGH", "-HRNK", "-HURGH", "-GLORF"))

GLOBAL_LIST_INIT(scarySounds, list('sound/weapons/thudswoosh.ogg','sound/weapons/taser.ogg','sound/weapons/armbomb.ogg','sound/voice/hiss1.ogg','sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg','sound/voice/hiss5.ogg','sound/voice/hiss6.ogg','sound/effects/glassbr1.ogg','sound/effects/glassbr2.ogg','sound/effects/glassbr3.ogg','sound/items/welder.ogg','sound/items/welder2.ogg','sound/machines/airlock.ogg','sound/effects/clownstep1.ogg','sound/effects/clownstep2.ogg'))


// Reference list for disposal sort junctions. Set the sortType variable on disposal sort junctions to
// the index of the sort department that you want. For example, sortType set to 2 will reroute all packages
// tagged for the Cargo Bay.

/* List of sortType codes for mapping reference
0 Waste
1 Disposals - All unwrapped items and untagged parcels get picked up by a junction with this sortType. Usually leads to the recycler.
2 Cargo Bay
3 QM Office
4 Engineering
5 CE Office
6 Atmospherics
7 Security
8 HoS Office
9 Medbay
10 CMO Office
11 Chemistry
12 Research
13 RD Office
14 Robotics
15 HoP Office
16 Library
17 Chapel
18 Theatre
19 Bar
20 Kitchen
21 Hydroponics
22 Janitor
23 Genetics
24 Circuitry
25 Toxins
26 Dormitories
27 Virology
28 Xenobiology
29 Law Office
30 Detective's Office
*/

//The whole system for the sorttype var is determined based on the order of this list,
//disposals must always be 1, since anything that's untagged will automatically go to disposals, or sorttype = 1 --Superxpdude

//If you don't want to fuck up disposals, add to this list, and don't change the order.
//If you insist on changing the order, you'll have to change every sort junction to reflect the new order. --Pete

GLOBAL_LIST_INIT(TAGGERLOCATIONS, list("Disposals",
	"Cargo Bay", "QM Office", "Engineering", "CE Office",
	"Atmospherics", "Security", "HoS Office", "Medbay",
	"CMO Office", "Chemistry", "Research", "RD Office",
	"Robotics", "HoP Office", "Library", "Chapel", "Theatre",
	"Bar", "Kitchen", "Hydroponics", "Janitor Closet","Genetics",
	"Circuitry", "Toxins", "Dormitories", "Virology",
	"Xenobiology", "Law Office","Detective's Office"))

GLOBAL_LIST_INIT(station_prefixes, world.file2list("strings/station_prefixes.txt") + "")

GLOBAL_LIST_INIT(station_names, world.file2list("strings/station_names.txt" + ""))

GLOBAL_LIST_INIT(station_suffixes, world.file2list("strings/station_suffixes.txt"))

GLOBAL_LIST_INIT(greek_letters, world.file2list("strings/greek_letters.txt"))

GLOBAL_LIST_INIT(phonetic_alphabet, world.file2list("strings/phonetic_alphabet.txt"))

GLOBAL_LIST_INIT(numbers_as_words, world.file2list("strings/numbers_as_words.txt"))

/proc/generate_number_strings()
	var/list/L[198]
	for(var/i in 1 to 99)
		L += "[i]"
		L += "\Roman[i]"
	return L

GLOBAL_LIST_INIT(station_numerals, greek_letters + phonetic_alphabet + numbers_as_words + generate_number_strings())

GLOBAL_LIST_INIT(admiral_messages, list("Do you know how expensive these stations are?","Stop wasting my time.","I was sleeping, thanks a lot.","Stand and fight you cowards!","You knew the risks coming in.","Stop being paranoid.","Whatever's broken just build a new one.","No.", "<i>null</i>","<i>Error: No comment given.</i>", "It's a good day to die!"))

GLOBAL_LIST_INIT(redacted_strings, list("\[REDACTED\]", "\[CLASSIFIED\]", "\[ARCHIVED\]", "\[EXPLETIVE DELETED\]", "\[EXPUNGED\]", "\[INFORMATION ABOVE YOUR SECURITY CLEARANCE\]", "\[MOVE ALONG CITIZEN\]", "\[NOTHING TO SEE HERE\]", "\[ACCESS DENIED\]"))

GLOBAL_LIST_INIT(wisdoms, world.file2list("strings/wisdoms.txt"))

GLOBAL_LIST_INIT(speech_verbs, list("default", "says", "rasps", "states", "bellows", "chirps", "hisses", "mumbles", "squeals", "barks", "meows", "growls", "drawls", "chitters", "declares", "mutters", "howls", "bleats", "cries", "murmurs"))

GLOBAL_LIST_INIT(roundstart_tongues, list(
	"default",
	"human tongue" = /obj/item/organ/tongue,
	"lizard tongue" = /obj/item/organ/tongue/lizard,
	"cat tongue" = /obj/item/organ/tongue/cat,
	"dog tongue" = /obj/item/organ/tongue/dog,
	"french tongue" = /obj/item/organ/tongue/french,
	"dutch tongue" = /obj/item/organ/tongue/dutch,
	"red river tongue" = /obj/item/organ/tongue/redriver,
	"scottish tongue" = /obj/item/organ/tongue/scottish,
	"swedish tongue" = /obj/item/organ/tongue/swedish,
	"japanese tongue" = /obj/item/organ/tongue/japanese,
	"chinese tongue" = /obj/item/organ/tongue/chinese,
	"irish tongue" = /obj/item/organ/tongue/irish,
	"slurry tongue" = /obj/item/organ/tongue/slurry,
	"bug tongue" = /obj/item/organ/tongue/bug,
	"vampire tongue" = /obj/item/organ/tongue/vampire
	//"skeleton tongue" = /obj/item/organ/tongue/bone,
	//"fly tongue" = /obj/item/organ/tongue/fly,
	//"ipc tongue" = /obj/item/organ/tongue/robot/ipc
	))

//locked parts are those that your picked species requires to have
//unlocked parts are those that anyone can choose on customisation regardless
//parts not in unlocked, but in all, are thus locked
GLOBAL_LIST_INIT(all_mutant_parts, list(
	"tail_lizard" = "Tail",
	"mam_tail" = "Tail",
	"tail_human" = "Tail",
	"snout" = "Snout",
	"frills" = "Frills",
	"spines" = "Spines",
	"mam_body_markings" = "Species Markings",
	"mam_ears" = "Ears", "ears" = "Ears",
	"mam_snouts" = "Snout", "legs" = "Legs",
	"deco_wings" = "Decorative Wings",
	"insect_wings" = "Insect Wings",
	"insect_fluff" = "Insect Fluff",
	"taur" = "Tauric Body",
	"insect_markings" = "Insect Markings",
	"wings" = "Wings",
	"arachnid_legs" = "Arachnid Legs",
	"arachnid_spinneret" = "Spinneret",
	"arachnid_mandibles" = "Mandibles",
	"xenohead" = "Caste Head",
	"xenotail" = "Tail",
	"xenodorsal" = "Dorsal Spines",
	"ipc_screen" = "Screen",
	"ipc_antenna" = "Antenna",
	"meat_type" = "Meat Type",
	"horns" = "Horns",
	"derg_body" = "Dragon Body",
	"derg_belly" = "Dragon Under",
	"derg_horns" = "Dragon Horns",
	"derg_mane" = "Dragon Mane",
	"derg_ears" = "Dragon Ears",
	"derg_eyes" = "Dragon Eyes"))

GLOBAL_LIST_INIT(unlocked_mutant_parts, list("horns", "insect_fluff"))
//parts in either of the above two lists that require a second option that allows them to be coloured
GLOBAL_LIST_INIT(colored_mutant_parts, list("insect_wings" = "wings_color", "deco_wings" = "wings_color", "horns" = "horns_color"))

//body ids that have greyscale sprites
GLOBAL_LIST_INIT(greyscale_limb_types, list(
	"human",
	"moth",
	"lizard",
	"pod",
	"plant",
	"jelly",
	"slime",
	"golem",
	"lum",
	"stargazer",
	"mush",
	"ethereal",
	"snail",
	"c_golem",
	"b_golem",
	"mammal",
	"xeno",
	"ipc",
	"insect",
	"synthliz",
	"avian",
	"aquatic",
	"shadekin",
	"spider",
	"dragon"))

//body ids that have prosthetic sprites
GLOBAL_LIST_INIT(prosthetic_limb_types, list("xion","bishop","cybersolutions","grayson","hephaestus","nanotrasen","talon"))

//body ids that have non-gendered bodyparts
GLOBAL_LIST_INIT(nongendered_limb_types, list(
	"fly",
	"zombie",
	"synth",
	"shadow",
	"cultgolem",
	"agent",
	"plasmaman",
	"clockgolem",
	"clothgolem",
	"smutant",
	"dragon"
	))

//list of eye types, corresponding to a respective left and right icon state for the set of eyes
GLOBAL_LIST_INIT(eye_types, list(
	"normal",
	"anime",
	"wideanime",
	"wide",
	"derpy",
	"insect",
	"moth",
	"double",
	"double2",
	"double3",
	"double4",
	"cyclops",
	"shadekin",
	"large",
	"large(offset)",
	"heterochromic-eyeshadow",
	"heterochromic-eyebrow",
	"heterochromic-raccoon",
	"heterochromic-leftsplotch",
	"heterochromic-rightsplotch"
	))

//list linking bodypart bitflags to their actual names
GLOBAL_LIST_INIT(bodypart_names, list(num2text(HEAD) = "Head", num2text(CHEST) = "Chest", num2text(LEG_LEFT) = "Left Leg", num2text(LEG_RIGHT) = "Right Leg", num2text(ARM_LEFT) = "Left Arm", num2text(ARM_RIGHT) = "Right Arm"))
// list linking bodypart names back to the bitflags
GLOBAL_LIST_INIT(bodypart_values, list("Head" = num2text(HEAD), "Chest" = num2text(CHEST), "Left Leg" = num2text(LEG_LEFT), "Right Leg" = num2text(LEG_RIGHT), "Left Arm" = num2text(ARM_LEFT), "Right Arm" = num2text(ARM_RIGHT)))

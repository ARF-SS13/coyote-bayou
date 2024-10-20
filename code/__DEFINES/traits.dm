#define SIGNAL_TRAIT(trait_ref) "trait [trait_ref]"
#define SIGNAL_ADDTRAIT(trait_ref) "addtrait [trait_ref]"
#define SIGNAL_REMOVETRAIT(trait_ref) "removetrait [trait_ref]"

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target.status_traits) { \
			target.status_traits = list(); \
			_L = target.status_traits; \
			_L[trait] = list(source); \
			SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
		} else { \
			_L = target.status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
				SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
			} \
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L && _L[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			};\
			if (!length(_L[trait])) { \
				_L -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S;\
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T), _T); \
					}; \
				};\
			if (!length(_L)) { \
				target.status_traits = null\
			};\
		}\
	} while (0)
#define HAS_TRAIT(target, trait) (target.status_traits ? (target.status_traits[trait] ? TRUE : FALSE) : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (source in target.status_traits[trait]) : FALSE) : FALSE)
#define HAS_TRAIT_FROM_ONLY(target, trait, source) (\
	target.status_traits ?\
		(target.status_traits[trait] ?\
			((source in target.status_traits[trait]) && (length(target.status_traits) == 1))\
			: FALSE)\
		: FALSE)
#define HAS_TRAIT_NOT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (length(target.status_traits[trait] - source) > 0) : FALSE) : FALSE)

//mob traits
/// Forces the user to stay unconscious.
#define TRAIT_ADV_SEEKER	"adventure_seeker"
#define TRAIT_ADV_ER		"adventurer"
#define TRAIT_ADV_LFG			"looking_for_group"
#define TRAIT_ADV_SOLO			"solo"
#define TRAIT_ADV_GUNNER		"gunner"
#define TRAIT_ADV_FIGHTER		"fighter"
#define TRAIT_ADV_TANK			"tank"
#define TRAIT_ADV_BRUISER		"bruiser"
#define TRAIT_ADV_ROGUE			"rogue"
#define TRAIT_ADV_HEALER		"healer"
#define TRAIT_KNOCKEDOUT		"knockedout"
#define TRAIT_BLIND 			"blind"
#define TRAIT_MUTE				"mute"
#define TRAIT_EMOTEMUTE			"emotemute"
#define TRAIT_LOOC_MUTE			"looc_mute" //Just like unconsciousness, it disables LOOC salt.
#define TRAIT_AOOC_MUTE			"aooc_mute" //Same as above but for AOOC.
#define TRAIT_DEAF				"deaf"
#define TRAIT_NEARSIGHT			"nearsighted"
#define TRAIT_NEARSIGHT_MEGA	"nearsighted_suffering"
#define TRAIT_FAT				"fat"
#define TRAIT_HUSK				"husk"
#define TRAIT_NOCLONE			"noclone"
#define TRAIT_CLUMSY			"clumsy"
#define TRAIT_CHUNKYFINGERS		"chunkyfingers" //means that you can't use weapons with normal trigger guards.
#define TRAIT_DUMB				"dumb"
#define TRAIT_MONKEYLIKE		"monkeylike" //sets IsAdvancedToolUser to FALSE
#define TRAIT_PACIFISM			"pacifism"
#define TRAIT_PACIFISM_LESSER	"lesserpacifism"
#define TRAIT_WEAK_OF_MUSCLES	"weak of muscles"
#define TRAIT_IGNORESLOWDOWN	"ignoreslow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "ignoredamageslowdown"
#define TRAIT_DEATHCOMA			"deathcoma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH			"fakedeath" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_DISFIGURED		"disfigured"
#define TRAIT_XENO_HOST			"xeno_host"	//Tracks whether we're gonna be a baby alien's mummy.
#define TRAIT_STUNIMMUNE		"stun_immunity"
#define TRAIT_TASED_RESISTANCE	"tased_resistance" //prevents you from suffering most of the effects of being tased
#define TRAIT_SLEEPIMMUNE		"sleep_immunity"
#define TRAIT_PUSHIMMUNE		"push_immunity"
#define TRAIT_SHOCKIMMUNE		"shock_immunity"
#define TRAIT_WIREVISION		"wire omniescience"
#define TRAIT_TESLA_SHOCKIMMUNE	"tesla_shock_immunity"
#define TRAIT_STABLEHEART		"stable_heart"
#define TRAIT_STABLELIVER		"stable_liver"
#define TRAIT_RESISTHEAT		"resist_heat"
#define TRAIT_RESISTHEATHANDS	"resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD		"resist_cold"
#define TRAIT_RESISTHIGHPRESSURE	"resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE	"resist_low_pressure"
#define TRAIT_BOMBIMMUNE		"bomb_immunity"
#define TRAIT_RADIMMUNE			"rad_immunity"
#define TRAIT_75_RAD_RESIST		"big_rad_resist"
#define TRAIT_50_RAD_RESIST		"some_rad_resist"
#define TRAIT_50_RAD_WEAK		"some_rad_weakness"
#define TRAIT_100_RAD_WEAK		"big_rad_weakness"
#define TRAIT_BRUTERESIST		"brute_resist_minor"
#define TRAIT_BRUTERESISTMAJOR	"brute_resist_major"
#define TRAIT_BRUTEWEAK			"brute_weak_minor"
#define TRAIT_BRUTEWEAKMAJOR	"brute_weak_major"
#define TRAIT_BRUTEWEAKFATAL	"brute_weak_fatal"
#define TRAIT_BURNRESIST		"burn_resist_minor"
#define TRAIT_BURNRESISTMAJOR	"burn_resist_major"
#define TRAIT_BURNWEAK			"burn_weak_minor"
#define TRAIT_BURNWEAKMAJOR		"burn_weak_major"
#define TRAIT_BURNWEAKFATAL		"burn_weak_fatal"
#define TRAIT_GENELESS			"geneless"
#define TRAIT_VIRUSIMMUNE		"virus_immunity"
#define TRAIT_PIERCEIMMUNE		"pierce_immunity"
#define TRAIT_NODISMEMBER		"dismember_immunity"
#define TRAIT_NOFIRE			"nonflammable"
#define TRAIT_NOGUNS			"no_guns"
#define TRAIT_MARTIAL_A			"no_guns"
#define TRAIT_NOHUNGER			"no_hunger"
#define TRAIT_EASYDISMEMBER		"easy_dismember"
#define TRAIT_LIMBATTACHMENT 	"limb_attach"
#define TRAIT_NOLIMBDISABLE		"no_limb_disable"
#define TRAIT_EASYLIMBDISABLE	"easy_limb_disable"
#define TRAIT_TOXINLOVER		"toxinlover"
#define TRAIT_TOXINIMMUNE		"toxinimmune"
#define TRAIT_CLONEIMMUNE		"cloneimmune"
#define TRAIT_NOBREATH			"no_breath"
#define TRAIT_ANTIMAGIC			"anti_magic"
#define TRAIT_HOLY				"holy"
#define TRAIT_DEPRESSION		"depression"
#define TRAIT_PESSIMIST			"pessimist"
#define TRAIT_JOLLY				"jolly"
#define TRAIT_OPTIMIST			"optimist"
#define TRAIT_IN_HEAT			"ERP Receptive"
#define TRAIT_HEAT_DETECT		"ERP Seeking"
#define TRAIT_ERPBOYKISSER		"ERP Seeking - Boykisser"
#define TRAIT_ERPGIRLKISSER		"ERP Seeking - Girlkisser"
#define TRAIT_ERPANYKISSER		"ERP Seeking - Anykisser"
#define TRAIT_ERPQUICKY			"ERP Seeking - Quickie Focused"
#define TRAIT_ERPLONGTERM		"ERP Seeking - Long Term Focused"
#define TRAIT_ERPBOTTOM			"ERP Seeking - Bottom"
#define TRAIT_ERPTOP			"ERP Seeking - Top"
#define TRAIT_ERPSWITCH			"ERP Seeking - Switch"
#define TRAIT_ERPFLIRTY			"ERP Seeking - Flirty"
#define TRAIT_SHY				"Shy"
#define TRAIT_PVEFOC			"PVE Focused"
#define TRAIT_PVPFOC			"PVP Focused"
#define TRAIT_COMBATSWITCH		"PVP/PVE Accepting"
#define TRAIT_OOCAPP			"L/OOC Approach"
#define TRAIT_RPFOCUSED			"RP Focused"
#define TRAIT_RPLONGTERM		"RP Focused Long Term" //RP Focused on long term interactions
#define TRAIT_RPSHORTTERM		"RP Focused Short Term" //RP Focused on short term interactions
#define TRAIT_RPSERIOUS			"RP Focused - Serious RP" //RP Focused on more serious subjects
#define TRAIT_RPLIGHT			"RP Focused - Lighter RP" //RP Focused on more light hearted subjects
#define TRAIT_RPDAYSOFOURLIVES	"RP Focused - Dramatic RP" //RP Focused on more soap opera stle subjects
#define TRAIT_RPSCRUBS			"RP Focused - Medical RP" //RP Focused on more medical subjects
#define TRAIT_SMOL				"lil_fella"
#define TRAIT_ARMBLADE			"Arm Blade"
#define TRAIT_CYBERKNIFE		"Cyber Blade"
#define TRAIT_ARMTENT			"Tentacle Arm"
#define TRAIT_MAGEGRAB			"Mage Grab"
#define TRAIT_TAILPLAY			"Tail Player"
#define TRAIT_TAILWHIP			"Tail Whipper"
#define TRAIT_TAILSMASH			"Tail Smasher"
#define TRAIT_TAILSPICY			"Tail Stinger"
#define TRAIT_TAILTHAGO			"Tail Thago"
#define TRAIT_BIGBITE			"Big Biter"
#define TRAIT_FASTBITE			"Fast Biter"
#define TRAIT_PLAYBITE			"Play Biter"
#define TRAIT_SPICYBITE			"Spicy Biter"
#define TRAIT_SABREBITE			"Sabre Biter"
#define TRAIT_BIGCLAW			"Big Clawer"
#define TRAIT_FASTCLAW			"Fast Clawer"
#define TRAIT_PLAYCLAW			"Play Clawer"
#define TRAIT_SPICYCLAW			"Spicy Clawer"
#define TRAIT_RAZORCLAW			"Razor Clawer"
#define TRAIT_NOCRITDAMAGE		"no_crit"
#define TRAIT_NOSLIPWATER		"noslip_water"
#define TRAIT_NOSLIPALL			"noslip_all"
#define TRAIT_NODEATH			"nodeath"
#define TRAIT_NOHARDCRIT		"nohardcrit"
#define TRAIT_NOSOFTCRIT		"nosoftcrit"
#define TRAIT_NUKA_LOVER		"nukalover"
#define TRAIT_SOH				"soh"
#define TRAIT_MINDSHIELD		"mindshield"
#define TRAIT_HIJACKER			"hijacker"
/*#define TRAIT_TREASURE_HUNTER 	"treasurehunter"*/// Not until crafting menus are fixed
#define TRAIT_SIXTHSENSE		"sixthsense"
#define TRAIT_DISSECTED			"dissected"
#define TRAIT_FEARLESS			"fearless"
#define TRAIT_CATPHOBIA			"catphobia"
#define TRAIT_RATPHOBIA			"ratphobia"
#define TRAIT_SPIDERPHOBIA		"spiderphobia"
#define TRAIT_LIZARDPHOBIA		"lizardphobia"
#define TRAIT_ROBOTPHOBIA		"robotphobia"
#define TRAIT_BIRDPHOBIA		"birdphobia"
#define TRAIT_DOGPHOBIA			"dogphobia"
#define TRAIT_ALIENPHOBIA		"alienphobia"
#define TRAIT_BONERPHOBIA		"skelephobia"
#define TRAIT_MASKPHOBIA		"maskphobia"
#define TRAIT_DOCTORPHOBIA		"doctorphobia"
#define TRAIT_EYEPHOBIA			"eyephobia"
#define TRAIT_CAT				"cats" // Try to match these species traits to phobia types in trauma.dm, makes life easier.
#define TRAIT_RAT				"rats"
#define TRAIT_SPIDER			"spiders"
#define TRAIT_LIZARD			"lizards"
#define TRAIT_ROBOT				"robots"
#define TRAIT_BIRD				"birds"
#define TRAIT_DOG				"dogs"
#define TRAIT_ALIEN				"aliens"
#define TRAIT_UNSTABLE			"unstable"
#define TRAIT_PARALYSIS_L_ARM	"para-l-arm" //These are used for brain-based paralysis, where replacing the limb won't fix it
#define TRAIT_PARALYSIS_R_ARM	"para-r-arm"
#define TRAIT_PARALYSIS_L_LEG	"para-l-leg"
#define TRAIT_PARALYSIS_R_LEG	"para-r-leg"
#define TRAIT_DISK_VERIFIER     "disk-verifier"
#define TRAIT_UNINTELLIGIBLE_SPEECH "unintelligible-speech"
#define TRAIT_SOOTHED_THROAT    "soothed-throat"
#define TRAIT_LAW_ENFORCEMENT_METABOLISM "law-enforcement-metabolism"
#define TRAIT_QUICK_CARRY		"quick-carry"
#define TRAIT_QUICKER_CARRY		"quicker-carry"
#define TRAIT_QUICK_BUILD		"quick-build"
#define TRAIT_STRONG_GRABBER	"strong_grabber"
#define TRAIT_CALCIUM_HEALER	"calcium_healer"
#define TRAIT_MAGIC_CHOKE		"magic_choke"
#define TRAIT_CAPTAIN_METABOLISM "captain-metabolism"
#define TRAIT_ABDUCTOR_TRAINING "abductor-training"
#define TRAIT_ABDUCTOR_SCIENTIST_TRAINING "abductor-scientist-training"
#define TRAIT_SURGEON           "surgeon"
#define TRAIT_COLDBLOODED		"coldblooded"	// Your body is literal room temperature. Does not make you immune to the temp.
#define TRAIT_NONATURALHEAL		"nonaturalheal"	// Only Admins can heal you. NOTHING else does it unless it's given the god tag.
#define TRAIT_NORUNNING			"norunning"		// You walk!
#define TRAIT_NOMARROW			"nomarrow"		// You don't make blood, with chemicals or nanites.
#define TRAIT_NOPULSE			"nopulse"		// Your heart doesn't beat.
#define TRAIT_NOGUT				"nogutting"		//Your chest cant be gutted of organs
#define TRAIT_NODECAP			"nodecapping"	//Your head cant be cut off in combat
#define TRAIT_EXEMPT_HEALTH_EVENTS	"exempt-health-events"
#define TRAIT_NO_MIDROUND_ANTAG	"no-midround-antag" //can't be turned into an antag by random events
#define TRAIT_PUGILIST	"pugilist" //This guy punches people for a living
#define TRAIT_KI_VAMPIRE	"ki-vampire" //when someone with this trait rolls maximum damage on a punch and stuns the target, they regain some stamina and do clone damage
#define TRAIT_PASSTABLE			"passtable"
#define TRAIT_GIANT				"giant"
#define TRAIT_DWARF				"dwarf"
#define TRAIT_ALCOHOL_TOLERANCE	"alcohol_tolerance"
#define TRAIT_AGEUSIA			"ageusia"
#define TRAIT_HEAVY_SLEEPER		"heavy_sleeper"
#define TRAIT_NIGHT_VISION		"night_vision"
#define TRAIT_NIGHT_VISION_GREATER		"night_vision_greater"
#define TRAIT_LIGHT_STEP		"light_step"
#define TRAIT_SILENT_STEP		"silent_step"
#define TRAIT_SPEEDY_STEP		"speedy_step"
#define TRAIT_SPIRITUAL			"spiritual"
#define TRAIT_BLINDFAITH		"blindfaith"
#define TRAIT_VORACIOUS			"voracious"
#define TRAIT_SELF_AWARE		"self_aware"
#define TRAIT_FREERUNNING		"freerunning"
#define TRAIT_SKITTISH			"skittish"
#define TRAIT_POOR_AIM			"poor_aim"
#define	TRAIT_LIGHT_SENSITIVITY			"light_sensitivity"
#define	TRAIT_PHOBIC			"trait_phobic"
#define TRAIT_CRIT_SHOT		"crit_shot" //Crits are cool, but have you ever critted 3 times in a row?
#define SPREAD_CONTROL		"spread_control"
#define TRAIT_PROSOPAGNOSIA		"prosopagnosia"
#define TRAIT_DRUNK_HEALING		"drunk_healing"
#define TRAIT_TAGGER			"tagger"
#define TRAIT_PHOTOGRAPHER		"photographer"
#define TRAIT_JOURNALIST		"journalist"
#define TRAIT_MUSICIAN			"musician"
#define TRAIT_SWAMPWIZARD		"swamp_wizard"
#define TRAIT_PERMABONER		"permanent_arousal"
#define TRAIT_NEVERBONER		"never_aroused"
#define TRAIT_MASO              "masochism"
#define	TRAIT_HIGH_BLOOD        "high_blood"
#define TRAIT_PARA              "paraplegic"
#define TRAIT_EMPATH			"empath"
#define TRAIT_FRIENDLY			"friendly"
#define TRAIT_BIG_LEAGUES		"big_leagues"
#define TRAIT_LITTLE_LEAGUES	"little_leagues"
#define TRAIT_GENTLE			"gentle"
#define TRAIT_WIMPY				"wimpy"
#define TRAIT_FEV				"FEV_MUT" //OH BOY
#define TRAIT_GHOULMELEE		"ghoulmelee"
#define TRAIT_TRAPPER			"trapper"
#define TRAIT_SHOCKINGGRASP		"shocking_grasp"
//#define //TRAIT_BOOMING			//"booming_blade"
#define TRAIT_TELEPATHY			"telepathy"
#define TRAIT_IRONFIST			"iron_fist"
#define TRAIT_STEELFIST			"steel_fist"
#define TRAIT_NOODLEFIST			"noodle_fist"
#define TRAIT_POWER_ARMOR		"power_armor"
#define TRAIT_SNOB				"snob"
#define TRAIT_CULT_EYES 		"cult_eyes"
#define TRAIT_AUTO_CATCH_ITEM	"auto_catch_item"
#define TRAIT_CLOWN_MENTALITY	"clown_mentality" // The future is now, clownman.
#define TRAIT_FREESPRINT		"free_sprinting"
#define TRAIT_XRAY_VISION       "xray_vision"
#define TRAIT_THERMAL_VISION    "thermal_vision"
#define TRAIT_TACKLER            "tackler"
#define TRAIT_TACKLERADV           "Advanced Tackler"
#define TRAIT_TACKLERNONCONX           "Apex Tackler"
#define TRAIT_NO_TELEPORT		"no-teleport" //you just can't
#define TRAIT_NO_INTERNALS		"no-internals"
#define TRAIT_NO_ALCOHOL		"alcohol_intolerance"
#define TRAIT_MUTATION_STASIS			"mutation_stasis" //Prevents processed genetics mutations from processing.
#define TRAIT_FAST_PUMP				"fast_pump"
#define TRAIT_WAND_PROFICIENT 	"wand_proficient"
#define TRAIT_AUTO_DRAW				"auto_draw" //can use bows good
#define TRAIT_PLAY_DEAD "play_dead" // gives 10u ghoul powder every *deathgasp
#define TRAIT_NO_PROCESS_FOOD	"no-process-food" // You don't get benefits from nutriment, nor nutrition from reagent consumables
#define TRAIT_NICE_SHOT			"nice_shot" //hnnnnnnnggggg..... you're pretty good...
#define TRAIT_PERFECT_ATTACKER	"perfect_attacker"
#define TRAIT_BUFFOUT_BUFF		"buffout_buff"
#define TRAIT_UNARMED_WEAPON	"unarmed_weapon"
/// Prevents usage of manipulation appendages (picking, holding or using items, manipulating storage).
#define TRAIT_HANDS_BLOCKED "handsblocked"
#define TRAIT_ILLITERATE "illiterate"
#define TRAIT_PAPER_SKIN "paper_skin"
#define TRAIT_GLASS_BONES "glass_bones"
/// Coyote Boyou trait that replaces paper skin and glass bones!
#define TRAIT_EASILY_WOUNDED "easily_wounded"
#define TRAIT_STEEL_ASS "steel_ass"
#define TRAIT_JIGGLY_ASS "jiggly_ass"
#define TRAIT_DISTANT "distant"
#define TRAIT_HEADPAT_SLUT "headpat_sluuuuut"
#define TRAIT_ORAL_FIXATION "oral fixation"
//#define TRAIT_PACKRAT "packrat"
#define TRAIT_HYDRA_HEADS "hydra_heads"
#define TRAIT_SHELTERED "sheltered"
#define TRAIT_WEAPONSMITH "weaponsmith"
#define TRAIT_MASTERWORKSMITH "masterworksmith" // same as weapon_crafting, but your smithed weapons do an additional 5 damage
#define TRAIT_BEASTFRIEND_RAT "beastfriend-rats"
#define TRAIT_BEASTFRIEND_SMALLCRITTER "beastfriend-smallcritters"
#define TRAIT_BEASTMASTER_RAT "beastmaster-rats"
#define TRAIT_BEASTMASTER_SMALLCRITTER "beastmaster-smallcritters"
#define TRAIT_BEASTFRIEND_BEE "beastfriend-bees"
#define TRAIT_WILDSHAPE "wild shape"
#define TRAIT_NO_CHOCOLATE "chocolate-intolerance"
#define TRAIT_WHITE_WOMAN "peanutbutter-difficulties"
#define TRAIT_AUTOBREW "autobrewery-syndrome"
#define TRAIT_ZOOMIES "zoomies"
#define ZOOMIES_STAM_MULT 0.75
#define TRAIT_SUPER_ZOOMIES "super zoomies"
#define SUPER_ZOOMIES_STAM_MULT 0.5
#define TRAIT_ENDLESS_RUNNER "endless_runner"
#define TRAIT_PANICKED_ATTACKER "panicked_attacker"
#define TRAIT_NOHIDEFACE "no hide face"
#define TRAIT_CLAM_TONGUE "clam_tongue"
#define TRAIT_CLAM_LOVER "clam_lover"
#define TRAIT_CLAM_FISHER "clam_fisher"

// mobility flag traits
// IN THE FUTURE, IT WOULD BE NICE TO DO SOMETHING SIMILAR TO https://github.com/tgstation/tgstation/pull/48923/files (ofcourse not nearly the same because I have my.. thoughts on it)
// BUT FOR NOW, THESE ARE HOOKED TO DO update_mobility() VIA COMSIG IN living_mobility.dm
// SO IF YOU ADD MORE, BESURE TO UPDATE IT THERE.

/// Disallow movement
#define TRAIT_MOBILITY_NOMOVE		"mobility_nomove"
/// Disallow pickup
#define TRAIT_MOBILITY_NOPICKUP		"mobility_nopickup"
/// Disallow item use
#define TRAIT_MOBILITY_NOUSE		"mobility_nouse"

#define TRAIT_SWIMMING			"swimming"			//only applied by /datum/element/swimming, for checking

/**
 * COMBAT MODE/SPRINT MODE TRAITS
 */

/// Prevents combat mode from being active.
#define TRAIT_COMBAT_MODE_LOCKED		"combatmode_locked"
/// Prevents sprinting from being active.
#define TRAIT_SPRINT_LOCKED				"sprint_locked"


#define TRAIT_SMUTANT		"Super Mutant"	// This is a trait usually locked for admins due to how OP it is
#define	TRAIT_CHEMWHIZ			"chemwhiz"
#define TRAIT_DNAWHIZ			"dnawhiz"
#define TRAIT_TECHNOPHOBE		"luddite" //Cannot use autolathes/biogens
#define TRAIT_NODRUGS		"winners_cant_do_drugs" //drugs hurt you!
#define TRAIT_LONGPORKLOVER		"Cannibal" //guess
#define TRAIT_TRIBAL			"Tribalistic Person" //has access to tribal crafting recipes
#define TRAIT_BERSERKER			"berserker" //currently unused
#define TRAIT_TECHNOPHREAK		"technophreak"	//boosts salvage return
#define TRAIT_WEAPONCRAFTING	"weapon_crafting"	// You spawn with various unlocked gun/armor crafts
#define TRAIT_PA_WEAR           "pa_wear" //guess
#define TRAIT_MEDICALEXPERT		"Medicinal Expert" //Can do revival surgery
#define TRAIT_MEDICALGRADUATE		"Medical Graduate" //generalised offmap medschool graduation training
#define TRAIT_UNETHICAL_PRACTITIONER	"Unethical Practitioner" //Can do harmful experimental surguries
#define TRAIT_UNETHICAL_PRACTITIONER_BRAINWASHING	"Unethical Practitioner - Brainwashing" //Can do harmful experimental surguries
#define TRAIT_CYBERNETICIST		"Cyberneticist" //Utilizes powerful cybernetics
#define TRAIT_CYBERNETICIST_EXPERT	"Cyberneticist Expert" //Can augument people into robots directly
#define TRAIT_MACHINE_SPIRITS	"machine_spirits" //for tribe unique functions.
#define TRAIT_HARD_YARDS        "hard_yards" //trekking, removes slowdown on all tiles
#define	TRAIT_SOFT_YARDS		"soft_yards" //lesser trekking
#define	TRAIT_SLUG				"slow" //You're a little slow. On your feet, at least.
#define	TRAIT_SLOWAF			"slower" //Damn boi how'd you even get here, you're slow as SHIT off road
#define	TRAIT_LIFEGIVER			"lifegiver" //boosts HP by 10
#define	TRAIT_LIFEGIVERPLUS		"lifegiverplus" //boosts HP by 20
#define	TRAIT_FLIMSY			"flimsy" //lowers HP by 10
#define	TRAIT_VERYFLIMSY			"veryflimsy" //lowers HP by 20
#define	TRAIT_CATASTROPHICFLIMSY			"catastrophicflimsy" //lowers HP by 50
#define	TRAIT_FATALFLIMSY			"fatalflimsy" //lowers HP by 50
#define TRAIT_MARS_TEACH		"mars_teachings" //for legion unique functions
#define TRAIT_EXPLOSIVE_CRAFTING "explosive_crafting" //can craft explosives and bombs
#define TRAIT_ADVANCED_EXPLOSIVE_CRAFTING "advanced_explosive_crafting" //can craft almost all kinds of explosives
/// Lets your tongue heal damage on limbs
#define TRAIT_HEAL_TONGUE "healing_tongue"
#define TRAIT_HEAL_TOUCH "healing_touch"
#define TRAIT_HEAL_TEND "healing_triage"
#define TRAIT_IMPROVED_HEALING "improved_healing"
/// Lets your tongue apply awful bandages to limbs
//#define TRAIT_BANDAGE_TONGUE "coagulating tongue"
/// You're hooked on punga!
#define TRAIT_PUNGAPOWER "pungaful"
#define TRAIT_NO_SECOND_WIND "no_second_wind"
#define TRAIT_NOCRITPAIN "no_crit_pain"

#define TRAIT_NO_MED_HVY_ARMOR "no_med_heavy_armor"

#define TRAIT_SURGERY_LOW		"lowsurgery"
#define TRAIT_SURGERY_MID		"midsurgery"
#define TRAIT_SURGERY_HIGH		"highsurgery"

// fallout crafting traits
#define TRAIT_FORMER_TRIBAL     "ex_tribal_traditions"
#define TRAIT_GUNSMITH_ONE      "gunsmith_one" //crafts poor guns
#define TRAIT_GUNSMITH_TWO      "gunsmith_two" //crafts mid level guns
#define TRAIT_GUNSMITH_THREE    "gunsmith_three" //crafts weapon parts
#define TRAIT_GUNSMITH_FOUR     "gunsmith_four" //currently unused
#define TRAIT_TRIBAL_TRAD	"whiteleg_traditions"
#define TRAIT_DEADHORSES_TRAD	"deadhorses_traditions"
#define TRAIT_RUSTWALKERS_TRAD	"rustwalker_traditions"
#define TRAIT_EIGHTIES_TRAD		"eighties_traditions"
#define TRAIT_SORROWS_TRAD		"sorrows_traditions"
#define TRAIT_WAYFARER_TRAD		"wayfarers_traditions"
#define TRAIT_BONEDANCER_TRAD	"bonedancer_traditions"

//non-mob traits
#define TRAIT_PARALYSIS				"paralysis" //Used for limb-based paralysis, where replacing the limb will fix it
#define VEHICLE_TRAIT "vehicle" // inherited from riding vehicles
#define INNATE_TRAIT "innate"

///Used for managing KEEP_TOGETHER in [appearance_flags]
#define TRAIT_KEEP_TOGETHER 	"keep-together"

// item traits
#define TRAIT_NODROP "nodrop"
/// Dont put it in storage things, simple as
#define TRAIT_NO_STORAGE_INSERT "no_storage_insert"
/// Can't leave a storage!
#define TRAIT_NO_STORAGE_REMOVE "TRAIT_NO_STORAGE_REMOVE"
#define TRAIT_ARTIFACT_BLOCKER "TRAIT_ARTIFACT_BLOCKER"

/// Artifact traits
#define TRAIT_PENANCE "penance" // died with the wretched thing
#define TRAIT_PENANCE_COMPLETE "penance_complete" // held that wretched thing for a long time
#define TRAIT_ARTIFACT_IDENTIFY "artifact_identify" // always knows everything about artifacts

// common trait sources
#define TRAIT_GENERIC "generic"
#define EYE_DAMAGE "eye_damage"
#define GENETIC_MUTATION "genetic"
#define OBESITY "obesity"
#define MAGIC_TRAIT "magic"
#define TRAUMA_TRAIT "trauma"
#define DISEASE_TRAIT "disease"
#define SPECIES_TRAIT "species"
#define ORGAN_TRAIT "organ"
#define JOB_TRAIT "job"
#define CYBORG_ITEM_TRAIT "cyborg-item"
#define ADMIN_TRAIT "admin" // (B)admins only.
#define CHANGELING_TRAIT "changeling"
#define CULT_TRAIT "cult"
#define CURSED_ITEM_TRAIT "cursed-item" // The item is magically cursed
#define ABSTRACT_ITEM_TRAIT "abstract-item"
#define STATUS_EFFECT_TRAIT "status-effect"
#define CLOTHING_TRAIT "clothing"
#define ROUNDSTART_TRAIT "roundstart" //cannot be removed without admin intervention
#define GHOSTROLE_TRAIT "ghostrole"
#define APHRO_TRAIT "aphro"
#define BLOODSUCKER_TRAIT "bloodsucker"
#define SHOES_TRAIT "shoes" //inherited from your sweet kicks
#define GLOVE_TRAIT "glove" //inherited by your cool gloves
#define BOOK_TRAIT "granter (book)" // knowledge is power

// unique trait sources, still defines
#define STATUE_TRAIT "statue"
#define CLONING_POD_TRAIT "cloning-pod"
#define VIRTUAL_REALITY_TRAIT "vr_trait"
#define CHANGELING_DRAIN "drain"
#define CHANGELING_HIVEMIND_MUTE "ling_mute"
#define ABYSSAL_GAZE_BLIND "abyssal_gaze"
#define HIGHLANDER "highlander"
#define TRAIT_HULK "hulk"
#define STASIS_MUTE "stasis"
#define GENETICS_SPELL "genetics_spell"
#define EYES_COVERED "eyes_covered"
#define CLOWN_NUKE_TRAIT "clown-nuke"
#define STICKY_MOUSTACHE_TRAIT "sticky-moustache"
#define CHAINSAW_FRENZY_TRAIT "chainsaw-frenzy"
#define CHRONO_GUN_TRAIT "chrono-gun"
#define REVERSE_BEAR_TRAP_TRAIT "reverse-bear-trap"
#define GLUED_ITEM_TRAIT "glued-item"
#define CURSED_MASK_TRAIT "cursed-mask"
#define HIS_GRACE_TRAIT "his-grace"
#define HAND_REPLACEMENT_TRAIT "magic-hand"
#define FEET_REPLACEMENT_TRAIT "feet-replacer"
#define HOT_POTATO_TRAIT "hot-potato"
#define ABDUCTOR_VEST_TRAIT "abductor-vest"
#define CAPTURE_THE_FLAG_TRAIT "capture-the-flag"
#define EYE_OF_GOD_TRAIT "eye-of-god"
#define SHAMEBRERO_TRAIT "shamebrero"
#define CHRONOSUIT_TRAIT "chronosuit"
#define FLIGHTSUIT_TRAIT "flightsuit"
#define LOCKED_HELMET_TRAIT "locked-helmet"
#define NINJA_SUIT_TRAIT "ninja-suit"
#define ANTI_DROP_IMPLANT_TRAIT "anti-drop-implant"
#define MARTIAL_ARTIST_TRAIT "martial_artist"
#define BERSERKER_TRAIT "berserker"
#define SLEEPING_CARP_TRAIT "sleeping_carp"
#define RISING_BASS_TRAIT "rising_bass"
#define RAGING_BOAR_TRAIT "raging_boar"
#define ABDUCTOR_ANTAGONIST "abductor-antagonist"
#define MADE_UNCLONEABLE "made-uncloneable"
#define TIMESTOP_TRAIT "timestop"
#define NUKEOP_TRAIT "nuke-op"
#define CLOWNOP_TRAIT "clown-op"
#define MEGAFAUNA_TRAIT "megafauna"
#define DEATHSQUAD_TRAIT "deathsquad"
/// This trait is added by the active directional block system.
#define ACTIVE_BLOCK_TRAIT				"active_block"
/// This trait is added by the parry system.
#define ACTIVE_PARRY_TRAIT				"active_parry"
#define STICKY_NODROP "sticky-nodrop" //sticky nodrop sounds like a bad soundcloud rapper's name
#define TRAIT_SPACEWALK "spacewalk"
#define RADX_TRAIT "trait_from_rad-x"

/// HUNTING HORNS! check huntinghorneffects.dm and huntinghorn.dm
#define TRAIT_HH_COOLDOWN_IGNORE "horn_cooldown"
#define TRAIT_HH_IRON_SKIN "horn_iron_skin"
#define TRAIT_HH_KNOCKDOWN_RES "horn_kd_res"
#define TRAIT_HH_DIVINE_BLESSING "horn_divine"
#define TRAIT_HH_DRAW_SPEED "horn_draw_speed"

//important_recursive_contents traits
/*
 * Used for movables that need to be updated, via COMSIG_ENTER_AREA and COMSIG_EXIT_AREA, when transitioning areas.
 * Use [/atom/movable/proc/become_area_sensitive(trait_source)] to properly enable it. How you remove it isn't as important.
 */
#define TRAIT_AREA_SENSITIVE "area-sensitive"
///every hearing sensitive atom has this trait
#define TRAIT_HEARING_SENSITIVE "hearing_sensitive"

/// just a little helper to see if we're not a druggie
#define NODRUGS(m) (HAS_TRAIT(m, TRAIT_NODRUGS))

///quirk defines cus they are kinda like traits i guess
#define QUIRK_KEY "Qkey"
#define QUIRK_NAME "Qname"
#define QUIRK_PATH "Qpath"
#define QUIRK_VALUE "Qvalue"
#define QUIRK_DESC "Qdesc"
#define QUIRK_MECHANICS "Qmechanics"
#define QUIRK_CONFLICTS "Qconflicts"
#define QUIRK_CATEGORY "Qcategory"
#define QUIRK_HUMANONLY "Qhumanonly"

#define QUIRK_CAT_DEFAULT "Misc"

#define QUIRK_STATISTICS_DIRECTORY "data/quirk_stats/round_"
#define QUIRK_PLAYER2FILENAME(ckey, playername) "[ckey]_[playername]_is_cool.json" // my code my filenames

GLOBAL_LIST_INIT(quirk2name, list(
	
))


//Preference toggles
#define SOUND_ADMINHELP			(1<<0)
#define SOUND_MIDI				(1<<1)
#define SOUND_AMBIENCE			(1<<2)
#define SOUND_LOBBY				(1<<3)
#define MEMBER_PUBLIC			(1<<4)
#define INTENT_STYLE			(1<<5)
#define MIDROUND_ANTAG			(1<<6)
#define SOUND_INSTRUMENTS		(1<<7)
#define SOUND_SHIP_AMBIENCE		(1<<8)
#define SOUND_PRAYERS			(1<<9)
#define ANNOUNCE_LOGIN			(1<<10)
#define SOUND_ANNOUNCEMENTS		(1<<11)
#define DISABLE_DEATHRATTLE		(1<<12)
#define DISABLE_ARRIVALRATTLE	(1<<13)
#define COMBOHUD_LIGHTING		(1<<14)
#define SOUND_SI				(1<<15)
#define SPLIT_ADMIN_TABS 		(1<<16)
#define VERB_CONSENT			(1<<17)
#define HEAR_LEWD_VERB_SOUNDS		(1<<18)
#define HEAR_LEWD_VERB_WORDS		(1<<19)
#define SOUND_HUNTINGHORN		(1<<20)
#define SOUND_SPRINTBUFFER		(1<<21)

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|MEMBER_PUBLIC|INTENT_STYLE|MIDROUND_ANTAG|SOUND_INSTRUMENTS|SOUND_SHIP_AMBIENCE|SOUND_PRAYERS|SOUND_ANNOUNCEMENTS|SOUND_SI|VERB_CONSENT|HEAR_LEWD_VERB_WORDS|SOUND_HUNTINGHORN|SOUND_SPRINTBUFFER)

//Chat toggles
#define CHAT_OOC			(1<<0)
#define CHAT_DEAD			(1<<1)
#define CHAT_GHOSTEARS		(1<<2)
#define CHAT_GHOSTSIGHT		(1<<3)
#define CHAT_PRAYER			(1<<4)
#define CHAT_RADIO			(1<<5)
#define CHAT_PULLR			(1<<6)
#define CHAT_GHOSTWHISPER	(1<<7)
#define CHAT_GHOSTPDA		(1<<8)
#define CHAT_GHOSTRADIO 	(1<<9)
#define CHAT_LOOC			(1<<10)
#define CHAT_BANKCARD		(1<<11)
#define CHAT_REMOTE_LOOC	(1<<12)
#define CHAT_AOOC			(1<<13)
#define CHAT_NEWBIE			(1<<14)
#define CHAT_HEAR_RADIOBLURBLES			(1<<15)
#define CHAT_HEAR_RADIOSTATIC			(1<<16)
#define CHAT_SEE_COOLCHAT			(1<<17)

#define TOGGLES_DEFAULT_CHAT (CHAT_OOC|CHAT_DEAD|CHAT_GHOSTEARS|CHAT_GHOSTSIGHT|CHAT_PRAYER|CHAT_RADIO|CHAT_PULLR|CHAT_GHOSTWHISPER|CHAT_GHOSTPDA|CHAT_GHOSTRADIO|CHAT_LOOC|CHAT_BANKCARD|CHAT_REMOTE_LOOC|CHAT_AOOC|CHAT_NEWBIE|CHAT_HEAR_RADIOBLURBLES|CHAT_HEAR_RADIOSTATIC|CHAT_SEE_COOLCHAT)

#define PARALLAX_INSANE -1 //for show offs
#define PARALLAX_HIGH    0 //default.
#define PARALLAX_MED     1
#define PARALLAX_LOW     2
#define PARALLAX_DISABLE 3 //this option must be the highest number

#define PARALLAX_DELAY_DEFAULT world.tick_lag
#define PARALLAX_DELAY_MED     1
#define PARALLAX_DELAY_LOW     2

#define SEC_DEPT_NONE "None"
#define SEC_DEPT_RANDOM "Random"
#define SEC_DEPT_ENGINEERING "Engineering"
#define SEC_DEPT_MEDICAL "Medical"
#define SEC_DEPT_SCIENCE "Science"
#define SEC_DEPT_SUPPLY "Supply"

// Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING			"Living"
#define EXP_TYPE_CREW			"Crew"
#define EXP_TYPE_COMMAND		"Command"
#define EXP_TYPE_ENGINEERING	"Engineering"
#define EXP_TYPE_MEDICAL		"Medical"
#define EXP_TYPE_SCIENCE		"Science"
#define EXP_TYPE_SUPPLY			"Supply"
#define EXP_TYPE_SECURITY		"Security"
#define EXP_TYPE_SILICON		"Silicon"
#define EXP_TYPE_SERVICE		"Service"
#define EXP_TYPE_ANTAG			"Antag"
#define EXP_TYPE_SPECIAL		"Special"
#define EXP_TYPE_GHOST			"Ghost"
//#define EXP_TYPE_BIKER			"Ashdown Overlook"
#define EXP_TYPE_ADMIN			"Admin"
//f13 stuff
#define EXP_TYPE_FALLOUT		"Fallout"
#define EXP_TYPE_VAULT			"Vault"
#define EXP_TYPE_BROTHERHOOD	"Southern BoS Outcasts"
#define EXP_TYPE_NCR			"Ncr"
#define EXP_TYPE_OASIS "Oasis"
#define EXP_TYPE_LEGION			"Legion"
#define EXP_TYPE_WASTELAND		"Wasteland"
#define EXP_TYPE_ENCLAVE		"Enclave"
#define EXP_TYPE_NCRCOMMAND     "NCRCommand"
#define EXP_TYPE_RANGER         "Ranger"
#define EXP_TYPE_SCRIBE         "Scribe"
#define EXP_TYPE_DECANUS        "Decanus"
#define EXP_TYPE_TRIBAL			"Tribal"
#define EXP_TYPE_FOLLOWERS		"New Boston Clinic"
#define EXP_TYPE_OUTLAW			"Redwater Townie"
#define EXP_TYPE_KHAN			"Great Khans"
#define EXP_TYPE_CLUB			"Heavens Night"
//Flags in the players table in the db
#define DB_FLAG_EXEMPT 							(1<<0)
#define DB_FLAG_AGE_CONFIRMATION_INCOMPLETE		(1<<1)
#define DB_FLAG_AGE_CONFIRMATION_COMPLETE		(1<<2)

#define DEFAULT_CYBORG_NAME "Default Cyborg Name"

//Job preferences levels
#define JP_LOW 1
#define JP_MEDIUM 2
#define JP_HIGH 3

//Chaos levels for dynamic voting
#define CHAOS_NONE "None (Extended)"
#define CHAOS_LOW "Low"
#define CHAOS_MED "Medium"
#define CHAOS_HIGH "High"
#define CHAOS_MAX "Maximum"

#define TBS_TOP "I am a top!"
#define TBS_BOTTOM "I am a bottom!"
#define TBS_SHOES "I am a switch!"
#define TBS_NONE "I am none of these!"
#define TBS_DEFAULT TBS_NONE
#define TBS_LIST list(TBS_TOP, TBS_BOTTOM, TBS_SHOES, TBS_NONE)

#define KISS_BOYS "I am a boykisser!"
#define KISS_GIRLS "I am a girlkisser!"
#define KISS_ANY "I'll kiss anybody!"
#define KISS_NONE "I don't kiss!"
#define KISS_DEFAULT KISS_NONE
#define KISS_LIST list(KISS_BOYS,KISS_GIRLS,KISS_ANY,KISS_NONE)

GLOBAL_LIST_INIT(undie_position_strings, list("Under Clothes", "Over Clothes", "Over Suit", "Over EVERYTHING"))
#define UNDERWEAR_UNDER_CLOTHES 0
#define UNDERWEAR_OVER_UNIFORM 1
#define UNDERWEAR_OVER_SUIT 2
#define UNDERWEAR_OVER_EVERYTHING 3

//CB Toggles
#define AIM_CURSOR_ON (1<<0)

/// Changelog entries
#define PMC_OOC_NOTES_UPDATE "update_ur_ooc" // Player Master Changelog
#define PMC_QUIRK_OVERHAUL_2K23 "updated_ur_quirks" // Player Master Changelog
#define PMC_DAN_MESSED_UP_WHO_STUFF "whoops" // Player Master Changelog
#define PMC_PORNHUD_WHITELIST_RELOCATION "ur_nads_are_here_now" // Player Master Changelog
#define PMC_UNBREAK_FAVORITE_PLAPS "/datum/interaction/bang/datum/interaction/funch" // Player Master Changelog
#define PMC_FENNY_FINISHED_124_QUESTS "and_killed_the_server" // Player Master Changelog
#define PMC_MY_PDA_FLIES_IN_FULL_COLOR "nekooooooooo" // Player Master Changelog
#define PMC_MOMMYCHAT_IS_COOL "ill be your mommy tonight uwu" // Player Master Changelog

/// The master Preferences Changelog to check the player's prefs against.
/// includes a list of actions that need to be taken to update the player's prefs.
#define PREFERENCES_MASTER_CHANGELOG list(\
	PMC_OOC_NOTES_UPDATE, \
	PMC_QUIRK_OVERHAUL_2K23,\
	PMC_DAN_MESSED_UP_WHO_STUFF,\
	PMC_FENNY_FINISHED_124_QUESTS,\
	PMC_MY_PDA_FLIES_IN_FULL_COLOR,\
	PMC_MOMMYCHAT_IS_COOL,\
)

#define PMR_WHY_DOES_EVERYTHING_DEFAULT_TO_OFF "lookingatyouwiretap" // Player Master Changelog
#define PMR_DAN_MESSED_UP_CHATPREFS "chatprefs" // Player Master Changelog
#define PMR_ADDED_RADIO_BLURBLES "CHAT_HEAR_RADIOBLURBLES" // Player Master Changelog
#define PMR_ADDED_RADIO_STATIC "PMR_ADDED_RADIO_STATIC" // Player Master Changelog
#define PMR_ADDED_COOLCHAT "fill-me-to-the-brimcon" // Player Master Changelog

/// The master Preferences Changelog to check the player's prefs against.
/// includes a list of actions that need to be taken to update the player's prefs.
#define PREFERENCES_MASTER_REVISIONLIST list(\
	PMR_WHY_DOES_EVERYTHING_DEFAULT_TO_OFF,\
	PMR_ADDED_RADIO_STATIC,\
	PMR_ADDED_RADIO_BLURBLES,\
	PMR_DAN_MESSED_UP_CHATPREFS,\
	PMR_ADDED_COOLCHAT,\
)

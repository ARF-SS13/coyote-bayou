#define _XPVERIFICATION_FGLAND_KEY "ticklemy"
#define _XPVERIFICATION_FGLAND_VAL "foregland"

#define _XPVERIFICATION_BGLAND_KEY "thissavedcorrectly"
#define _XPVERIFICATION_BGLAND_VAL "yesitdid"

#define XP_DEFAULT "default"

#define XPVAL_TOTAL_XP "total_xp"


/// Filesystem stuff
/// Example filestructure for player 'icarlyfan' with 1 character 'Iggy Carlyle'
/// (the main general data for the character, used to see if this character has a save)
/// data/xp/current/icarlyfan/sluggish-whiny-terror-shark/master.json
/// (Various XP lvl data for the character)
/// data/xp/current/icarlyfan/sluggish-whiny-terror-shark/exp-pve.json
/// data/xp/current/icarlyfan/sluggish-whiny-terror-shark/exp-pvp.json
/// data/xp/current/icarlyfan/sluggish-whiny-terror-shark/exp-trader.json
/// etc.


#define _XP_ROOT_PATH "data/xp"
#define _XP_CURRENT_PATH "current"
#define _XP_MASTER_FILENAME "master.json"
#define _XP_TEST_FILE "testboot.json"

#define _XP_PLAYER_KERNAL "kernal.json" // This is the file that signifies that this player has already been brought into the future

#define _XP_BACKUP_PATH "backup"

#define _XP_FILE_PREFIX "exp-"
#define _XP_FILE_SUFFIX ".json"
#define XP2FILE(xpkind) "[_XP_FILE_PREFIX]" + xpkind + "[_XP_FILE_SUFFIX]"

#define _XP_DUMMY_CKEY "WallyWeaselDaSexKing"
#define _XP_DUMMY_UID1 "plotdriller420"
#define _XP_DUMMY_UID2 "tirekzpr0nysmooze"
#define _XP_TEST_VALUE 32767
#define _XP_TEST_VALUE2 32768

GLOBAL_LIST_INIT(xp_dummy_data, list(
	"ckey" = _XP_DUMMY_CKEY,
	"uids" = list(
		_XP_DUMMY_UID1 = list(
			"testxp" = XP_PVE,
			XPVAL_TOTAL_XP = _XP_TEST_VALUE,
		),
		_XP_DUMMY_UID2 = list(
			"testxp" = XP_PVP,
			XPVAL_TOTAL_XP = _XP_TEST_VALUE2,
		),
	)
))



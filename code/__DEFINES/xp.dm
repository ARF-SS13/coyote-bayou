#define _XPVERIFICATION_FGLAND_KEY "ticklemy"
#define _XPVERIFICATION_FGLAND_VAL "foregland"

#define _XPVERIFICATION_BGLAND_KEY "thissavedcorrectly"
#define _XPVERIFICATION_BGLAND_VAL "yesitdid"

#define XP_DEFAULT "default"


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

#define _XP_BACKUP_PATH "backup"

#define _XP_FILE_PREFIX "exp-"
#define _XP_FILE_SUFFIX ".json"
#define XP2FILE(xpkind) "[_XP_FILE_PREFIX]" + xpkind + "[_XP_FILE_SUFFIX]"



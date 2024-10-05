// Tool types
#define TOOL_CROWBAR 		"crowbar"
#define TOOL_MULTITOOL 		"multitool"
#define TOOL_SCREWDRIVER 	"screwdriver"
#define TOOL_WIRECUTTER 	"wirecutter"
#define TOOL_WRENCH 		"wrench"
#define TOOL_WELDER 		"welder"
#define TOOL_ANALYZER		"analyzer"
#define TOOL_MINING			"mining"
#define TOOL_SHOVEL			"shovel"
#define TOOL_RETRACTOR	 	"retractor"
#define TOOL_HEMOSTAT 		"hemostat"
#define TOOL_CAUTERY 		"cautery"
#define TOOL_DRILL			"drill"
#define TOOL_SCALPEL		"scalpel"
#define TOOL_SAW			"saw"
#define TOOL_RITUAL			"ritual dagger"
//Glasswork Tools
#define TOOL_BLOW			"blowing_rod"
#define TOOL_GLASS_CUT		"glasskit"
#define TOOL_BONESET		"bonesetter"
//Fallout 13 Tools//
#define TOOL_NCR			"NCR ammo bench"
#define TOOL_LEGION			"Legion ammo bench"
#define TOOL_FORGE			"forge"
#define TOOL_RELOADER		"Pre-Fall reloading press"
#define TOOL_MSRELOADER     "makeshift reloading tool"
#define TOOL_LUNCHBOX       "lunchbox"
//benches
#define TOOL_WORKBENCH      "workbench"
#define TOOL_MWORKBENCH		"machine bench"
#define TOOL_ASSWORKBENCH   "assembly bench"
#define TOOL_FWORKBENCH   	"finishing workbench"
#define TOOL_BOTTLER		"bottler"
#define TOOL_AWORKBENCH     "advanced workbench"
#define TOOL_LOOM			"Loom"
#define TOOL_CHEMMASTER		"ChemMaster / refinery"
#define TOOL_ALCHEMY_TABLE  "Alchemy Table"
//
#define TOOL_GUNTIER1		"Guns and Bullets: Part 1"
#define TOOL_GUNTIER2		"Guns and Bullets: Part 2"
#define TOOL_GUNTIER3		"Guns and Bullets: Part 3"
#define TOOL_GUNTIER4		"Guns and Bullets: Part 4"

// If delay between the start and the end of tool operation is less than MIN_TOOL_SOUND_DELAY,
// tool sound is only played when op is started. If not, it's played twice.
#define MIN_TOOL_SOUND_DELAY 20

//Time for a work for tool system calculated in that way: basic time - tool level - stat check..
//It means that basic tools will give -30 on time, and people on right job should have -20 at least, or even more.
//This isn't used yet but it's kept for compatibility.
#define WORKTIME_INSTANT				0
#define WORKTIME_NEAR_INSTANT			30
#define WORKTIME_FAST					60
#define WORKTIME_NORMAL					90
#define WORKTIME_SLOW					120
#define WORKTIME_LONG					170
#define WORKTIME_EXTREMELY_LONG			250

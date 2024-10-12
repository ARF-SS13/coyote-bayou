// Radios use a large variety of predefined frequencies.

//say based modes like binary are in living/say.dm

#define RADIO_CHANNEL_COMMON "Common"
#define RADIO_KEY_COMMON ";"

#define RADIO_CHANNEL_SECURITY "Security"
#define RADIO_KEY_SECURITY "s"
#define RADIO_TOKEN_SECURITY ":s"

#define RADIO_CHANNEL_ENGINEERING "Engineering"
#define RADIO_KEY_ENGINEERING "e"
#define RADIO_TOKEN_ENGINEERING ":e"

#define RADIO_CHANNEL_COMMAND "Command"
#define RADIO_KEY_COMMAND "c"
#define RADIO_TOKEN_COMMAND ":c"

#define RADIO_CHANNEL_RECLAIMER "Reclaimers"
#define RADIO_KEY_RECLAIMER "n"
#define RADIO_TOKEN_RECLAIMER ":n"

#define RADIO_CHANNEL_MEDICAL "Medical"
#define RADIO_KEY_MEDICAL "m"
#define RADIO_TOKEN_MEDICAL ":m"

#define RADIO_CHANNEL_SUPPLY "Supply"
#define RADIO_KEY_SUPPLY "u"
#define RADIO_TOKEN_SUPPLY ":u"

#define RADIO_CHANNEL_SERVICE "Service"
#define RADIO_KEY_SERVICE "v"
#define RADIO_TOKEN_SERVICE ":v"

#define RADIO_CHANNEL_AI_PRIVATE "AI Private"
#define RADIO_KEY_AI_PRIVATE "o"
#define RADIO_TOKEN_AI_PRIVATE ":o"

#define RADIO_CHANNEL_SYNDICATE "Syndicate"
#define RADIO_KEY_SYNDICATE "t"
#define RADIO_TOKEN_SYNDICATE ":t"

#define RADIO_CHANNEL_CENTCOM "CentCom"
#define RADIO_KEY_CENTCOM "y"
#define RADIO_TOKEN_CENTCOM ":y"

#define RADIO_CHANNEL_VAULT "Vault"
#define RADIO_KEY_VAULT "b"
#define RADIO_TOKEN_VAULT ":b"

#define RADIO_CHANNEL_BIKER "Biker"
#define RADIO_KEY_BIKER "8"
#define RADIO_TOKEN_BIKER ":8"

#define RADIO_CHANNEL_NCR "NCR"
#define RADIO_KEY_NCR "w"
#define RADIO_TOKEN_NCR ":w"

#define RADIO_CHANNEL_RANGER "Ranger"
#define RADIO_KEY_RANGER "r"
#define RADIO_TOKEN_RANGER ":r"

#define RADIO_CHANNEL_GUILD "Guild"
#define RADIO_KEY_GUILD "g"
#define RADIO_TOKEN_GUILD ":g"

#define RADIO_CHANNEL_ENCLAVE "Enclave"
#define RADIO_KEY_ENCLAVE "z"
#define RADIO_TOKEN_ENCLAVE ":z"

#define RADIO_CHANNEL_TOWN "Town"
#define RADIO_KEY_TOWN "f"
#define RADIO_TOKEN_TOWN ":f"

#define RADIO_CHANNEL_TOWN_PD "Sheriff"
#define RADIO_KEY_TOWN_PD "l"
#define RADIO_TOKEN_TOWN_PD ":l"

#define RADIO_CHANNEL_TOWN_COMMERCE "Commerce"
#define RADIO_KEY_TOWN_COMMERCE "j"
#define RADIO_TOKEN_TOWN_COMMERCE ":j"

#define RADIO_CHANNEL_TOWN_MAYOR "High Alderperson"
#define RADIO_KEY_TOWN_MAYOR "y"
#define RADIO_TOKEN_TOWN_MAYOR ":y"

#define RADIO_CHANNEL_REDWATER "Redwater"
#define RADIO_KEY_REDWATER "UNUSED"
#define RADIO_TOKEN_REDWATER ":UNUSED"

#define RADIO_CHANNEL_RESPONDERS "Responders"
#define RADIO_KEY_RESPONDERS "k"
#define RADIO_TOKEN_RESPONDERS ":k"

#define RADIO_CHANNEL_CTF_RED "Red Team"
#define RADIO_CHANNEL_CTF_BLUE "Blue Team"

#define MIN_FREE_FREQ 1201 // -------------------------------------------------
// Frequencies are always odd numbers and range from 1201 to 1599.

#define FREQ_SYNDICATE 1213  // Nuke op comms frequency, dark brown
#define FREQ_CTF_RED 1215  // CTF red team comms frequency, red
#define FREQ_CTF_BLUE 1217  // CTF blue team comms frequency, blue
#define FREQ_CENTCOM 1337  // CentCom comms frequency, gray
#define FREQ_SUPPLY 1347  // Supply comms frequency, light brown
#define FREQ_SERVICE 1349  // Service comms frequency, green
#define FREQ_RECLAIMER 1351  // Science comms frequency, plum
#define FREQ_COMMAND 1353  // Command comms frequency, gold
#define FREQ_MEDICAL 1355  // Medical comms frequency, soft blue
#define FREQ_ENGINEERING 1357  // Engineering comms frequency, orange
#define FREQ_SECURITY 1359  // Security comms frequency, red
#define FREQ_VAULT 1361 //Vault
#define FREQ_NCR 1363 //NCR
#define FREQ_GUILD 1365 //Guild
#define FREQ_ENCLAVE 1367 //ENCLAVE
#define FREQ_TOWN 1369 //TOWN
#define FREQ_TOWN_PD 1371 //Town Police
#define FREQ_RANGER 1373 //Ranger
#define FREQ_TOWN_MAYOR 1375 //Den
#define FREQ_TOWN_COMMERCE 1376 //Khans
#define FREQ_BIKER 1379 //Khans
#define FREQ_RESPONDERS 1209 //Responders

///hey guess what, telecomm's a fuckin cock, so im making the list here
///update this list with all the frequenties the fuckin bus fuckin listens to (which is all of them, fuck you its all of them)
#define BUS_FREQ_FUCKYOU_ALLOFTHEM FREQ_SECURITY,\
		FREQ_SYNDICATE,\
		FREQ_COMMAND,\
		FREQ_CENTCOM,\
		FREQ_SUPPLY,\
		FREQ_RECLAIMER,\
		FREQ_COMMAND,\
		FREQ_MEDICAL,\
		FREQ_ENGINEERING,\
		FREQ_SECURITY,\
		FREQ_VAULT,\
		FREQ_NCR,\
		FREQ_GUILD,\
		FREQ_ENCLAVE,\
		FREQ_TOWN_MAYOR,\
		FREQ_TOWN,\
		FREQ_TOWN_PD,\
		FREQ_RANGER,\
		FREQ_TOWN_COMMERCE,\
		FREQ_RESPONDERS,\
		FREQ_BIKER

#define FREQ_HOLOGRID_SOLUTION 1433
#define FREQ_STATUS_DISPLAYS 1435
#define FREQ_ATMOS_ALARMS 1437  // air alarms <-> alert computers
#define FREQ_ATMOS_CONTROL 1439  // air alarms <-> vents and scrubbers

#define MIN_FREQ 1441 // ------------------------------------------------------
// Only the 1441 to 1489 range is freely available for general conversation.
// This represents 1/8th of the available spectrum.

#define FREQ_ATMOS_STORAGE 1441
#define FREQ_NAV_BEACON 1445
#define FREQ_AI_PRIVATE 1447  // AI private comms frequency, magenta
#define FREQ_PRESSURE_PLATE 1447
#define FREQ_AIRLOCK_CONTROL 1449
#define FREQ_ELECTROPACK 1449
#define FREQ_MAGNETS 1449
#define FREQ_LOCATOR_IMPLANT 1451
#define FREQ_SIGNALER 1457  // the default for new signalers
#define FREQ_COMMON 1459  // Common comms frequency, dark green

#define MAX_FREQ 1489 // ------------------------------------------------------

#define MAX_FREE_FREQ 1599 // -------------------------------------------------

// Transmission types.
#define TRANSMISSION_WIRE 0  // some sort of wired connection, not used
#define TRANSMISSION_RADIO 1  // electromagnetic radiation (default)
#define TRANSMISSION_SUBSPACE 2  // subspace transmission (headsets only)
#define TRANSMISSION_SUPERSPACE 3  // reaches independent (CentCom) radios only

// Filter types, used as an optimization to avoid unnecessary proc calls.
#define RADIO_TO_AIRALARM "to_airalarm"
#define RADIO_FROM_AIRALARM "from_airalarm"
#define RADIO_SIGNALER "signaler"
#define RADIO_ATMOSIA "atmosia"
#define RADIO_AIRLOCK "airlock"
#define RADIO_MAGNETS "magnets"

#define DEFAULT_SIGNALER_CODE 30

// For information on what objects or departments use what frequencies,
// see __DEFINES/radio.dm. Mappers may also select additional frequencies for
// use in maps, such as in intercoms.

/// hi, lagg here, my turn ons include long walks on the beach and hunting down lists spread out over multiple files

//Message modes. Each one defines a radio channel, more or less.
#define MODE_HEADSET "headset"
#define MODE_ROBOT "robot"

#define MODE_R_HAND "right hand"
#define MODE_KEY_R_HAND "r"

#define MODE_L_HAND "left hand"
#define MODE_KEY_L_HAND "l"

#define MODE_INTERCOM "intercom"
#define MODE_KEY_INTERCOM "i"

#define MODE_BINARY "binary"
#define MODE_KEY_BINARY "9"
#define MODE_TOKEN_BINARY ":9"

#define MODE_WHISPER "whisper"
#define MODE_WHISPER_CRIT "whispercrit"

#define MODE_CUSTOM_SAY "custom_say"

#define MODE_DEPARTMENT "department"
#define MODE_KEY_DEPARTMENT "h"
#define MODE_TOKEN_DEPARTMENT ":h"

#define MODE_ADMIN "admin"
#define MODE_KEY_ADMIN "p"

#define MODE_DEADMIN "deadmin"
#define MODE_KEY_DEADMIN "d"

#define MODE_ALIEN "alientalk"
#define MODE_HOLOPAD "holopad"

#define MODE_CHANGELING "changeling"
#define MODE_KEY_CHANGELING "a"
#define MODE_TOKEN_CHANGELING ":a"

#define MODE_VOCALCORDS "cords"
#define MODE_KEY_VOCALCORDS "x"

#define MODE_MONKEY "monkeyhive"

#define MODE_SING "%"

#define MODE_SAY "say"
#define MODE_ASK "ask"
#define MODE_EXCLAIM "exclaim"
#define MODE_YELL "yell"
#define MODE_PROFILE_PIC "Profile / Examine" // if you rename this, Rename the string that appears in HornyChat.js

GLOBAL_LIST_INIT(radiochannels, list(
	RADIO_CHANNEL_COMMON = FREQ_COMMON,
	RADIO_CHANNEL_RECLAIMER = FREQ_RECLAIMER,
	RADIO_CHANNEL_COMMAND = FREQ_COMMAND,
	RADIO_CHANNEL_MEDICAL = FREQ_MEDICAL,
	RADIO_CHANNEL_ENGINEERING = FREQ_ENGINEERING,
	RADIO_CHANNEL_SECURITY = FREQ_SECURITY,
	RADIO_CHANNEL_CENTCOM = FREQ_CENTCOM,
	RADIO_CHANNEL_SYNDICATE = FREQ_SYNDICATE,
	RADIO_CHANNEL_SUPPLY = FREQ_SUPPLY,
	RADIO_CHANNEL_SERVICE = FREQ_SERVICE,
	RADIO_CHANNEL_AI_PRIVATE = FREQ_AI_PRIVATE,
	RADIO_CHANNEL_CTF_RED = FREQ_CTF_RED,
	RADIO_CHANNEL_CTF_BLUE = FREQ_CTF_BLUE,
	RADIO_CHANNEL_VAULT = FREQ_VAULT,
	RADIO_CHANNEL_NCR = FREQ_NCR,
	RADIO_CHANNEL_GUILD = FREQ_GUILD,
	RADIO_CHANNEL_BIKER = FREQ_BIKER,
	RADIO_CHANNEL_ENCLAVE = FREQ_ENCLAVE,
	RADIO_CHANNEL_TOWN = FREQ_TOWN,
	RADIO_CHANNEL_TOWN_PD = FREQ_TOWN_PD,
	RADIO_CHANNEL_TOWN_MAYOR = FREQ_TOWN_MAYOR,
	RADIO_CHANNEL_RANGER = FREQ_RANGER,
	RADIO_CHANNEL_TOWN_COMMERCE = FREQ_TOWN_COMMERCE,
	RADIO_CHANNEL_RESPONDERS = FREQ_RESPONDERS
	))

GLOBAL_LIST_INIT(reverseradiochannels, list(
	"[FREQ_COMMON]" = RADIO_CHANNEL_COMMON,
	"[FREQ_RECLAIMER]" = RADIO_CHANNEL_RECLAIMER,
	"[FREQ_COMMAND]" = RADIO_CHANNEL_COMMAND,
	"[FREQ_MEDICAL]" = RADIO_CHANNEL_MEDICAL,
	"[FREQ_ENGINEERING]" = RADIO_CHANNEL_ENGINEERING,
	"[FREQ_SECURITY]" = RADIO_CHANNEL_SECURITY,
	"[FREQ_CENTCOM]" = RADIO_CHANNEL_CENTCOM,
	"[FREQ_SYNDICATE]" = RADIO_CHANNEL_SYNDICATE,
	"[FREQ_SUPPLY]" = RADIO_CHANNEL_SUPPLY,
	"[FREQ_SERVICE]" = RADIO_CHANNEL_SERVICE,
	"[FREQ_AI_PRIVATE]" = RADIO_CHANNEL_AI_PRIVATE,
	"[FREQ_CTF_RED]" = RADIO_CHANNEL_CTF_RED,
	"[FREQ_CTF_BLUE]" = RADIO_CHANNEL_CTF_BLUE,
	"[FREQ_VAULT]" = RADIO_CHANNEL_VAULT,
	"[FREQ_BIKER]" = RADIO_CHANNEL_BIKER,
	"[FREQ_NCR]" = RADIO_CHANNEL_NCR,
	"[FREQ_GUILD]" = RADIO_CHANNEL_GUILD,
	"[FREQ_ENCLAVE]" = RADIO_CHANNEL_ENCLAVE,
	"[FREQ_TOWN]" = RADIO_CHANNEL_TOWN,
	"[FREQ_TOWN_MAYOR]" = RADIO_CHANNEL_TOWN_MAYOR,
	"[FREQ_TOWN_PD]" = RADIO_CHANNEL_TOWN_PD,
	"[FREQ_RANGER]" = RADIO_CHANNEL_RANGER,
	"[FREQ_TOWN_COMMERCE]" = RADIO_CHANNEL_TOWN_COMMERCE,
	"[FREQ_RESPONDERS]" = RADIO_CHANNEL_RESPONDERS
	))

GLOBAL_LIST_INIT(freqtospan, list(
	"[FREQ_RECLAIMER]" = "sciradio",
	"[FREQ_MEDICAL]" = "medradio",
	"[FREQ_ENGINEERING]" = "engradio",
	"[FREQ_SUPPLY]" = "suppradio",
	"[FREQ_SERVICE]" = "servradio",
	"[FREQ_SECURITY]" = "secradio",
	"[FREQ_COMMAND]" = "comradio",
	"[FREQ_AI_PRIVATE]" = "aiprivradio",
	"[FREQ_SYNDICATE]" = "syndradio",
	"[FREQ_CENTCOM]" = "centcomradio",
	"[FREQ_CTF_RED]" = "redteamradio",
	"[FREQ_CTF_BLUE]" = "blueteamradio",
	"[FREQ_VAULT]" = "vaultradio",
	"[FREQ_BIKER]" = "syndradio",
	"[FREQ_NCR]" = "ncrradio",
	"[FREQ_GUILD]" = "bosradio",
	"[FREQ_ENCLAVE]" = "enclaveradio",
	"[FREQ_TOWN]" = "townradio",
	"[FREQ_TOWN_COMMERCE]" = "servradio",
	"[FREQ_TOWN_PD]" = "secradio",
	"[FREQ_TOWN_MAYOR]" = "comradio",
	"[FREQ_RANGER]" = "rangerradio",
	"[FREQ_RESPONDERS]" = "respondersradio"
	))

GLOBAL_LIST_INIT(department_radio_prefixes, list(":", "."))

GLOBAL_LIST_INIT(department_radio_keys, list(
	// Location
	MODE_KEY_R_HAND = MODE_R_HAND,
	MODE_KEY_L_HAND = MODE_L_HAND,
	MODE_KEY_INTERCOM = MODE_INTERCOM,

	// Department
	MODE_KEY_DEPARTMENT = MODE_DEPARTMENT,
	RADIO_KEY_COMMAND = RADIO_CHANNEL_COMMAND,
	RADIO_KEY_RECLAIMER = RADIO_CHANNEL_RECLAIMER,
	RADIO_KEY_MEDICAL = RADIO_CHANNEL_MEDICAL,
	RADIO_KEY_ENGINEERING = RADIO_CHANNEL_ENGINEERING,
	RADIO_KEY_SECURITY = RADIO_CHANNEL_SECURITY,
	RADIO_KEY_SUPPLY = RADIO_CHANNEL_SUPPLY,
	RADIO_KEY_SERVICE = RADIO_CHANNEL_SERVICE,

	// Faction
	RADIO_KEY_SYNDICATE = RADIO_CHANNEL_SYNDICATE,
	RADIO_KEY_CENTCOM = RADIO_CHANNEL_CENTCOM,

	// Fallout 13
	RADIO_KEY_BIKER = RADIO_CHANNEL_BIKER,
	RADIO_KEY_VAULT = RADIO_CHANNEL_VAULT,
	RADIO_KEY_NCR = RADIO_CHANNEL_NCR,
	RADIO_KEY_GUILD = RADIO_CHANNEL_GUILD,
	RADIO_KEY_ENCLAVE = RADIO_CHANNEL_ENCLAVE,
	RADIO_KEY_TOWN = RADIO_CHANNEL_TOWN,
	RADIO_KEY_TOWN_PD = RADIO_CHANNEL_TOWN_PD,
	RADIO_KEY_RANGER = RADIO_CHANNEL_RANGER,
	RADIO_KEY_TOWN_MAYOR = RADIO_CHANNEL_TOWN_MAYOR,
	RADIO_KEY_RESPONDERS = RADIO_CHANNEL_RESPONDERS,
	RADIO_KEY_TOWN_COMMERCE = RADIO_CHANNEL_TOWN_COMMERCE,

	// Admin
	MODE_KEY_ADMIN = MODE_ADMIN,
	MODE_KEY_DEADMIN = MODE_DEADMIN,

	// Misc
	RADIO_KEY_AI_PRIVATE = RADIO_CHANNEL_AI_PRIVATE, // AI Upload channel
	MODE_KEY_VOCALCORDS = MODE_VOCALCORDS,		// vocal cords, used by Voice of God


	//kinda localization -- rastaf0
	//same keys as above, but on russian keyboard layout. This file uses cp1251 as encoding.
	// Location
	"ê" = MODE_R_HAND,
	"ä" = MODE_L_HAND,
	"ø" = MODE_INTERCOM,

	// Department
	"ð" = MODE_DEPARTMENT,
	"ñ" = RADIO_CHANNEL_COMMAND,
	"ò" = RADIO_CHANNEL_RECLAIMER,
	"ü" = RADIO_CHANNEL_MEDICAL,
	"ó" = RADIO_CHANNEL_ENGINEERING,
	"û" = RADIO_CHANNEL_SECURITY,
	"ã" = RADIO_CHANNEL_SUPPLY,
	"ì" = RADIO_CHANNEL_SERVICE,

	// Faction
	"å" = RADIO_CHANNEL_SYNDICATE,
	"í" = RADIO_CHANNEL_CENTCOM,

	// Admin
	"ç" = MODE_ADMIN,
	"â" = MODE_ADMIN,

	// Misc
	"ù" = RADIO_CHANNEL_AI_PRIVATE,
	"÷" = MODE_VOCALCORDS
))

/// uwu~

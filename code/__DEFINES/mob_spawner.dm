/// Mob spawner kind IDs
#define MOB_SPAWNER_GHOUL "ghoul"
#define MOB_SPAWNER_MIRELURK "mirelurk"
#define MOB_SPAWNER_BLOATFLY "bloaties"
#define MOB_SPAWNER_GECKO "gecko"
#define MOB_SPAWNER_BLOATFLY_AND_GECKO "buzz_and_snap"
#define MOB_SPAWNER_MOLERAT "molerats"
#define MOB_SPAWNER_ROACH "roachies"
#define MOB_SPAWNER_ROBOT_DOMESTIC "domestic_robots" // handies and protectrons
#define MOB_SPAWNER_ROBOT_SECURITY "security_robots" // securitrons, sentrybots
#define MOB_SPAWNER_ROBOT_MILITARY "military_robots" // gutsies, sentrybots, assbots
#define MOB_SPAWNER_SUPERMUTANT "supermutants"
#define MOB_SPAWNER_CENTAUR "centaurs"
#define MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR "gruesome_twosome"
#define MOB_SPAWNER_CAZADOR "cazadors"
#define MOB_SPAWNER_DEATHCLAW "deathclaws"
#define MOB_SPAWNER_HELLPIG "hellpiggy"
#define MOB_SPAWNER_SCORPIONS "scorpins"
#define MOB_SPAWNER_ANT "ants"
#define MOB_SPAWNER_NIGHTSTALKER "nightstalker"
#define MOB_SPAWNER_RAIDER_MELEE "raider_melee"
#define MOB_SPAWNER_RAIDER_RANGED "raider_ranged"
#define MOB_SPAWNER_RAIDER_MIXED "raider_mixed"
#define MOB_SPAWNER_TUNNELLER "tunneller"
#define MOB_SPAWNER_SPORECARRIER "spore_boy"
#define MOB_SPAWNER_WANAMINGO "vs_purple_alien"

/// Mob difficulties
#define MOB_SPAWNER_EASY "easy_mobs"
#define MOB_SPAWNER_MED "hard_mobs"
#define MOB_SPAWNER_HARD "legendary_mobs"

/// Mob spawner internal categories
#define MOB_SPAWNER_LIST_MOBS "mob_list"
#define MOB_SPAWNER_LIST_TIME "respawn_time"
#define MOB_SPAWNER_LIST_STATE "icon_state"
#define MOB_SPAWNER_LIST_COUNT "max_out_at_once"
#define MOB_SPAWNER_LIST_SOUND "sound_to_play"
#define MOB_SPAWNER_LIST_NAME "name_it_is"
#define MOB_SPAWNER_LIST_DESC "desc_of_it"

/// Mob spawner global list slots
#define MOB_SPAWNER_GLOBAL_LIST_KIND "mob_list_kind"
#define MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY "mob_list_difficulty"

/// Mob spawner times
#define MOB_SPAWNER_TIME_LONGEST 1800
#define MOB_SPAWNER_TIME_LONGER 600
#define MOB_SPAWNER_TIME_LONG 400
#define MOB_SPAWNER_TIME_DEFAULT 200
#define MOB_SPAWNER_TIME_QUICK 150
#define MOB_SPAWNER_TIME_QUICKER 100
#define MOB_SPAWNER_TIME_QUICKEST 50

/// Mob spawner icon_states
#define MOB_SPAWNER_ICONSTATE_DEFAULT "hole"
#define MOB_SPAWNER_ICONSTATE_ROBOT "scanner_modified"
#define MOB_SPAWNER_ICONSTATE_VENT "ventblue"

/// Mob spawner spawn sound
#define MOB_SPAWNER_SOUND_DEFAULT null
#define MOB_SPAWNER_SOUND_VENT 'sound/effects/bin_close.ogg'

/// Mob spawner randomizer list keys
#define MOB_SPAWNER_KIND_ALL "all mobs"
#define MOB_SPAWNER_KIND_ROBOT_LOW "low level robots"
#define MOB_SPAWNER_KIND_ROBOT_HIGH "high level robots"
#define MOB_SPAWNER_KIND_TRASH "trash mobs"
#define MOB_SPAWNER_KIND_LOW "low level mobs"
#define MOB_SPAWNER_KIND_MID "mid level mobs"
#define MOB_SPAWNER_KIND_HIGH "high level mobs"
#define MOB_SPAWNER_KIND_HIGHER "really high level mobs"
#define MOB_SPAWNER_KIND_DEATH "OP mobs"
#define MOB_SPAWNER_KIND_RAIDER_LOW "low level raider"
#define MOB_SPAWNER_KIND_RAIDER_HIGH "high level raider"

/// Mob spawner difficulty bitflags
#define MOB_SPAWNER_DIFFICULTY_EASY (1<<0)
#define MOB_SPAWNER_DIFFICULTY_MED (1<<1)
#define MOB_SPAWNER_DIFFICULTY_HARD (1<<2)

GLOBAL_LIST_INIT(mob_spawner_tier_all, list(
	MOB_SPAWNER_GHOUL,
	MOB_SPAWNER_MIRELURK,
	MOB_SPAWNER_BLOATFLY,
	MOB_SPAWNER_GECKO,
	MOB_SPAWNER_BLOATFLY_AND_GECKO,
	MOB_SPAWNER_MOLERAT,
	MOB_SPAWNER_ROACH,
	MOB_SPAWNER_ROBOT_DOMESTIC,
	MOB_SPAWNER_ROBOT_SECURITY,
	MOB_SPAWNER_ROBOT_MILITARY,
	MOB_SPAWNER_SUPERMUTANT,
	MOB_SPAWNER_CENTAUR,
	MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR,
	MOB_SPAWNER_CAZADOR,
	MOB_SPAWNER_DEATHCLAW,
	MOB_SPAWNER_HELLPIG,
	MOB_SPAWNER_SCORPIONS,
	MOB_SPAWNER_ANT,
	MOB_SPAWNER_NIGHTSTALKER,
	MOB_SPAWNER_RAIDER_MELEE,
	MOB_SPAWNER_RAIDER_RANGED,
	MOB_SPAWNER_RAIDER_MIXED,
	MOB_SPAWNER_TUNNELLER,
	MOB_SPAWNER_SPORECARRIER,
	MOB_SPAWNER_WANAMINGO
))

GLOBAL_LIST_INIT(mob_spawner_tier_robot_low, list(
	MOB_SPAWNER_ROBOT_DOMESTIC,
	MOB_SPAWNER_ROBOT_SECURITY
))

GLOBAL_LIST_INIT(mob_spawner_tier_robot_high, list(
	MOB_SPAWNER_ROBOT_SECURITY,
	MOB_SPAWNER_ROBOT_MILITARY
))

GLOBAL_LIST_INIT(mob_spawner_tier_trash, list(
	MOB_SPAWNER_BLOATFLY,
	MOB_SPAWNER_GECKO,
	MOB_SPAWNER_BLOATFLY_AND_GECKO,
	MOB_SPAWNER_MOLERAT,
	MOB_SPAWNER_ROACH
))

GLOBAL_LIST_INIT(mob_spawner_tier_low, list(
	MOB_SPAWNER_GHOUL,
	MOB_SPAWNER_MIRELURK,
	MOB_SPAWNER_BLOATFLY,
	MOB_SPAWNER_GECKO,
	MOB_SPAWNER_BLOATFLY_AND_GECKO,
	MOB_SPAWNER_RAIDER_MELEE,
	MOB_SPAWNER_MOLERAT,
	MOB_SPAWNER_ROACH
))

GLOBAL_LIST_INIT(mob_spawner_tier_mid, list(
	MOB_SPAWNER_GHOUL,
	MOB_SPAWNER_MIRELURK,
	MOB_SPAWNER_CAZADOR,
	MOB_SPAWNER_ROBOT_DOMESTIC,
	MOB_SPAWNER_ROBOT_SECURITY,
	MOB_SPAWNER_DEATHCLAW,
	MOB_SPAWNER_SCORPIONS,
	MOB_SPAWNER_ANT,
	MOB_SPAWNER_RAIDER_MELEE,
	MOB_SPAWNER_RAIDER_RANGED,
	MOB_SPAWNER_RAIDER_MIXED,
	MOB_SPAWNER_NIGHTSTALKER,
	MOB_SPAWNER_TUNNELLER,
	MOB_SPAWNER_SPORECARRIER,
))

GLOBAL_LIST_INIT(mob_spawner_tier_high, list(
	MOB_SPAWNER_GHOUL,
	MOB_SPAWNER_MIRELURK,
	MOB_SPAWNER_CENTAUR,
	MOB_SPAWNER_ROBOT_DOMESTIC,
	MOB_SPAWNER_ROBOT_SECURITY,
	MOB_SPAWNER_CAZADOR,
	MOB_SPAWNER_SCORPIONS,
	MOB_SPAWNER_ANT,
	MOB_SPAWNER_NIGHTSTALKER,
	MOB_SPAWNER_RAIDER_MELEE,
	MOB_SPAWNER_RAIDER_RANGED,
	MOB_SPAWNER_RAIDER_MIXED,
	MOB_SPAWNER_TUNNELLER,
	MOB_SPAWNER_SPORECARRIER,
	MOB_SPAWNER_WANAMINGO
))

GLOBAL_LIST_INIT(mob_spawner_tier_higher, list(
	MOB_SPAWNER_ROBOT_DOMESTIC,
	MOB_SPAWNER_ROBOT_SECURITY,
	MOB_SPAWNER_ROBOT_MILITARY,
	MOB_SPAWNER_SUPERMUTANT,
	MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR,
	MOB_SPAWNER_HELLPIG,
	MOB_SPAWNER_RAIDER_MELEE,
	MOB_SPAWNER_RAIDER_RANGED,
	MOB_SPAWNER_RAIDER_MIXED,
	MOB_SPAWNER_WANAMINGO
))

GLOBAL_LIST_INIT(mob_spawner_tier_death, list(
	MOB_SPAWNER_ROBOT_MILITARY,
	MOB_SPAWNER_SUPERMUTANT,
	MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR,
	MOB_SPAWNER_DEATHCLAW,
	MOB_SPAWNER_HELLPIG,
	MOB_SPAWNER_RAIDER_MIXED,
	MOB_SPAWNER_WANAMINGO
))

GLOBAL_LIST_INIT(mob_spawner_tier_raider_low, list(
	MOB_SPAWNER_RAIDER_MELEE,
	MOB_SPAWNER_RAIDER_MIXED
))

GLOBAL_LIST_INIT(mob_spawner_tier_raider_high, list(
	MOB_SPAWNER_RAIDER_RANGED,
	MOB_SPAWNER_RAIDER_MIXED
))

/// Global list of random mob spawners, to coordinate them all
/// format: "spawner_key" = list(MOB_SPAWNER_GLOBAL_LIST_KIND = MOB_SPAWNER_GHOUL, MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY = MOB_SPAWNER_DIFFICULTIES)
GLOBAL_LIST_EMPTY(mob_spawner_random_index)

/// Mob spawner kinds (CW: HUGE FUCKIN LIST)
GLOBAL_LIST_INIT(mob_spawner_random_master_list, list(
	MOB_SPAWNER_GHOUL = list(
		MOB_SPAWNER_LIST_NAME = "Ghoul nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/ghoul = 5,
				/mob/living/simple_animal/hostile/ghoul/reaver = 3,
				/mob/living/simple_animal/hostile/ghoul/glowing = 1),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/ghoul = 5,
				/mob/living/simple_animal/hostile/ghoul/reaver = 3,
				/mob/living/simple_animal/hostile/ghoul/glowing = 1),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/ghoul = 5,
				/mob/living/simple_animal/hostile/ghoul/reaver = 3,
				/mob/living/simple_animal/hostile/ghoul/glowing = 1),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),

	MOB_SPAWNER_MIRELURK = list(
		MOB_SPAWNER_LIST_NAME = "Mirelurk nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/mirelurk = 2,
				/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
				/mob/living/simple_animal/hostile/mirelurk/baby = 5),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/mirelurk = 2,
				/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
				/mob/living/simple_animal/hostile/mirelurk/baby = 5),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/mirelurk = 2,
				/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
				/mob/living/simple_animal/hostile/mirelurk/baby = 5),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),

	MOB_SPAWNER_DEATHCLAW = list(
		MOB_SPAWNER_LIST_NAME = "Deathclaw nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/deathclaw = 2),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONGEST),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/deathclaw/mother = 1,
				/mob/living/simple_animal/hostile/deathclaw = 2),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONGER),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/deathclaw/mother = 1,
				/mob/living/simple_animal/hostile/deathclaw/legendary = 1),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONGER)),

	MOB_SPAWNER_HELLPIG = list(
		MOB_SPAWNER_LIST_NAME = "Hellpig nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/hellpig = 3),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONGEST),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/hellpig = 3),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONGER),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/hellpig = 3),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONGER)),

	MOB_SPAWNER_ROACH = list(
		MOB_SPAWNER_LIST_NAME = "Roach nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/radroach = 50),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/radroach = 50),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/radroach = 50),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_GECKO = list(
		MOB_SPAWNER_LIST_NAME = "Gecko nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/gecko = 50),
			MOB_SPAWNER_LIST_COUNT = 10,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/gecko = 50),
			MOB_SPAWNER_LIST_COUNT = 10,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/gecko = 50),
			MOB_SPAWNER_LIST_COUNT = 10,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_BLOATFLY = list(
		MOB_SPAWNER_LIST_NAME = "Bloatfly nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/bloatfly = 50),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/bloatfly = 50),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/bloatfly = 50),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_BLOATFLY_AND_GECKO = list(
		MOB_SPAWNER_LIST_NAME = "Gecko and bloatfly nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with two kinds of monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/gecko = 25,
				/mob/living/simple_animal/hostile/bloatfly = 25),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/gecko = 25,
				/mob/living/simple_animal/hostile/bloatfly = 25),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/gecko = 25,
				/mob/living/simple_animal/hostile/bloatfly = 25),
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_MOLERAT = list(
		MOB_SPAWNER_LIST_NAME = "Molerat nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/molerat = 50),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/molerat = 50),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/molerat = 50),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_CAZADOR = list(
		MOB_SPAWNER_LIST_NAME = "Cazador nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/cazador/young = 10,
				/mob/living/simple_animal/hostile/cazador = 8),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/cazador/young = 10,
				/mob/living/simple_animal/hostile/cazador = 8),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/cazador/young = 10,
				/mob/living/simple_animal/hostile/cazador = 8),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_SCORPIONS = list(
		MOB_SPAWNER_LIST_NAME = "Scorpion nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/radscorpion = 10),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/radscorpion = 5,
				/mob/living/simple_animal/hostile/radscorpion/black = 5,
				/mob/living/simple_animal/hostile/radscorpion/blue = 5),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/radscorpion = 5,
				/mob/living/simple_animal/hostile/radscorpion/black = 10,
				/mob/living/simple_animal/hostile/radscorpion/blue = 10),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_ANT = list(
		MOB_SPAWNER_LIST_NAME = "Anthill",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/giantant = 10),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/giantant = 5,
				/mob/living/simple_animal/hostile/fireant = 5),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/giantant = 15,
				/mob/living/simple_animal/hostile/fireant = 15),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_NIGHTSTALKER = list(
		MOB_SPAWNER_LIST_NAME = "Nightstalker nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/stalker = 3),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/stalker = 5,
				/mob/living/simple_animal/hostile/stalkeryoung = 5),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICK),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_COUNT = 5,
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/stalker = 5,
				/mob/living/simple_animal/hostile/stalkeryoung = 5),
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_QUICKER)),
			
	MOB_SPAWNER_ROBOT_DOMESTIC = list(
		MOB_SPAWNER_LIST_NAME = "Commercial robot storage",
		MOB_SPAWNER_LIST_DESC = "A consumer-grade storage device full of consumer grade robots.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_ROBOT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/protectron = 5,
				/mob/living/simple_animal/hostile/eyebot = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/protectron = 5,
				/mob/living/simple_animal/hostile/handy = 5,
				/mob/living/simple_animal/hostile/eyebot/floatingeye = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/robobrain = 5,
				/mob/living/simple_animal/hostile/handy = 5,
				/mob/living/simple_animal/hostile/eyebot/floatingeye = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_ROBOT_SECURITY = list(
		MOB_SPAWNER_LIST_NAME = "Security robot storage",
		MOB_SPAWNER_LIST_DESC = "A security storage device full of security robots.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_ROBOT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/protectron = 5,
				/mob/living/simple_animal/hostile/eyebot = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/protectron = 5,
				/mob/living/simple_animal/hostile/securitron = 5,
				/mob/living/simple_animal/hostile/securitron/sentrybot/nsb/riot = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/robobrain = 5,
				/mob/living/simple_animal/hostile/securitron = 5,
				/mob/living/simple_animal/hostile/securitron/sentrybot/nsb/riot = 5,
				/mob/living/simple_animal/hostile/securitron/sentrybot = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_ROBOT_MILITARY = list(
		MOB_SPAWNER_LIST_NAME = "Military robot storage",
		MOB_SPAWNER_LIST_DESC = "A military storage device full of military robots.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_ROBOT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/robobrain = 5,
				/mob/living/simple_animal/hostile/securitron = 5,
				/mob/living/simple_animal/hostile/handy/protectron = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/assaultron = 5,
				/mob/living/simple_animal/hostile/handy/robobrain = 5,
				/mob/living/simple_animal/hostile/securitron = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/handy/assaultron = 5,
				/mob/living/simple_animal/hostile/handy/gutsy = 5,
				/mob/living/simple_animal/hostile/securitron = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_SUPERMUTANT = list(
		MOB_SPAWNER_LIST_NAME = "Supermutant nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/supermutant/meleemutant = 2,
				/mob/living/simple_animal/hostile/supermutant = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONG),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/supermutant/meleemutant = 5,
				/mob/living/simple_animal/hostile/supermutant/rangedmutant = 2),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONG),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/supermutant/nightkin = 5,
				/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant = 2,
				/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant = 1),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONG)),
			
	MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR = list(
		MOB_SPAWNER_LIST_NAME = "Supermutant and centaur nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters and their pets in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/centaur = 5,
				/mob/living/simple_animal/hostile/supermutant/meleemutant = 2,
				/mob/living/simple_animal/hostile/supermutant = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONG),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/centaur = 5,
				/mob/living/simple_animal/hostile/supermutant/meleemutant = 5,
				/mob/living/simple_animal/hostile/supermutant/rangedmutant = 2),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONG),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/centaur = 5,
				/mob/living/simple_animal/hostile/supermutant/nightkin = 5,
				/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant = 2,
				/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant = 1),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_LONG)),
			
	MOB_SPAWNER_CENTAUR = list(
		MOB_SPAWNER_LIST_NAME = "Centaur nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with gross monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/centaur = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/centaur = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/centaur = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_RAIDER_MELEE = list(
		MOB_SPAWNER_LIST_NAME = "Narrow tunnel",
		MOB_SPAWNER_LIST_DESC = "A crude tunnel used by raiders to travel across the wasteland.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_VENT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_VENT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider = 7),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider = 5,
				/mob/living/simple_animal/hostile/raider/baseball = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider = 5,
				/mob/living/simple_animal/hostile/raider/firefighter = 2,
				/mob/living/simple_animal/hostile/raider/baseball = 5,
				/mob/living/simple_animal/hostile/raider/tribal = 1),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_RAIDER_RANGED = list(
		MOB_SPAWNER_LIST_NAME = "Narrow tunnel",
		MOB_SPAWNER_LIST_DESC = "A crude tunnel used by raiders to travel across the wasteland.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_VENT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_VENT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider/ranged = 5),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider/ranged = 5,
				/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 3),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider/ranged = 5,
				/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 3,
				/mob/living/simple_animal/hostile/raider/ranged/biker = 3),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_RAIDER_MIXED = list(
		MOB_SPAWNER_LIST_NAME = "Narrow tunnel",
		MOB_SPAWNER_LIST_DESC = "A crude tunnel used by raiders to travel across the wasteland.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_VENT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_VENT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider = 5,
				/mob/living/simple_animal/hostile/raider/firefighter = 2,
				/mob/living/simple_animal/hostile/raider/ranged = 2),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider = 5,
				/mob/living/simple_animal/hostile/raider/firefighter = 2,
				/mob/living/simple_animal/hostile/raider/baseball = 5,
				/mob/living/simple_animal/hostile/raider/ranged = 2,
				/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 1),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/raider = 5,
				/mob/living/simple_animal/hostile/raider/firefighter = 2,
				/mob/living/simple_animal/hostile/raider/baseball = 5,
				/mob/living/simple_animal/hostile/raider/ranged = 2,
				/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 1,
				/mob/living/simple_animal/hostile/raider/ranged/biker = 1,
				/mob/living/simple_animal/hostile/raider/tribal = 1),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_TUNNELLER = list(
		MOB_SPAWNER_LIST_NAME = "Tunneler nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/trog/tunneler = 10),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/trog/tunneler = 10),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/trog/tunneler = 10),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_SPORECARRIER = list(
		MOB_SPAWNER_LIST_NAME = "Spore carrier nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/trog/sporecarrier = 10),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/trog/sporecarrier = 10),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/trog/sporecarrier = 10),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT)),
			
	MOB_SPAWNER_WANAMINGO = list(
		MOB_SPAWNER_LIST_NAME = "Alien nest",
		MOB_SPAWNER_LIST_DESC = "A gross hole in the ground with monsters in it.",
		MOB_SPAWNER_LIST_STATE = MOB_SPAWNER_ICONSTATE_DEFAULT,
		MOB_SPAWNER_LIST_SOUND = MOB_SPAWNER_SOUND_DEFAULT,
		MOB_SPAWNER_EASY = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/alien = 1),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_MED = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/alien = 2),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT),
		MOB_SPAWNER_HARD = list(
			MOB_SPAWNER_LIST_MOBS = list(
				/mob/living/simple_animal/hostile/alien = 3),
			MOB_SPAWNER_LIST_COUNT = 3,
			MOB_SPAWNER_LIST_TIME = MOB_SPAWNER_TIME_DEFAULT))
	))


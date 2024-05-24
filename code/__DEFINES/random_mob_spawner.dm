/// Mob spawner kind IDs
#define MOB_SPAWNER_GHOUL "ghoul"
#define MOB_SPAWNER_LESSERSPIDER "lesser_spider"
#define MOB_SPAWNER_GREATERSPIDER "greater_spider"
#define MOB_SPAWNER_OMEGASPIDER "omega_spider"
#define MOB_SPAWNER_MIRELURK "mirelurk"
#define MOB_SPAWNER_BLOATFLY "bloaties"
#define MOB_SPAWNER_GECKO "gecko"
#define MOB_SPAWNER_BLOATFLY_AND_GECKO "buzz_and_snap"
#define MOB_SPAWNER_MOLERAT "molerats"
#define MOB_SPAWNER_ROACH "roachies"
#define MOB_SPAWNER_MOOK "Wanderers"
#define MOB_SPAWNER_HIVEBOT "Hivebots"
#define MOB_SPAWNER_PIRATE "Pirates"
#define MOB_SPAWNER_RUSSIAN "Russians"
#define MOB_SPAWNER_SYNDICATE "Syndicate"
#define MOB_SPAWNER_ROBOT_DOMESTIC "domestic_robots" // handies and protectrons
#define MOB_SPAWNER_ROBOT_SECURITY "security_robots" // securitrons, sentrybots
#define MOB_SPAWNER_ROBOT_MILITARY "military_robots" // gutsies, sentrybots, assbots
#define MOB_SPAWNER_SUPERMUTANT "supermutants"
#define MOB_SPAWNER_CENTAUR "centaurs"
#define MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR "gruesome_twosome"
#define MOB_SPAWNER_CAZADOR "cazadors"
#define MOB_SPAWNER_DEATHCLAW "aethergiests"
#define MOB_SPAWNER_HELLPIG "hellpiggy"
#define MOB_SPAWNER_YAOGUAI "bear"
#define MOB_SPAWNER_WOLF "woof"
#define MOB_SPAWNER_SCORPIONS "scorpins"
#define MOB_SPAWNER_ANT "ants"
#define MOB_SPAWNER_NIGHTSTALKER "nightstalker"
#define MOB_SPAWNER_RAIDER_MELEE "raider_melee"
#define MOB_SPAWNER_RAIDER_RANGED "raider_ranged"
#define MOB_SPAWNER_RAIDER_MIXED "raider_mixed"
#define MOB_SPAWNER_TUNNELLER "tunneller"
#define MOB_SPAWNER_SPORECARRIER "spore_boy"
#define MOB_SPAWNER_WANAMINGO "vs_purple_alien"
#define MOB_SPAWNER_RATTLER "texasrattler"
#define MOB_SPAWNER_DEBUG "debuggo"

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

/// robots
#define MOB_SPAWNER_KIND_ROBOT_LOW "low level robots"
#define MOB_SPAWNER_KIND_ROBOT_HIGH "high level robots"

/// mostly for dungeons
#define MOB_SPAWNER_KIND_TRASH "trash mobs"
#define MOB_SPAWNER_KIND_LOW "low level mobs"
#define MOB_SPAWNER_KIND_MID "mid level mobs"
#define MOB_SPAWNER_KIND_HIGH "high level mobs"
#define MOB_SPAWNER_KIND_HIGHER "really high level mobs"
#define MOB_SPAWNER_KIND_DEATH "OP mobs"

/// random-ass animals and mutated wierd shit
#define MOB_SPAWNER_KIND_ANIMALS_TRASH "trash animals" // me_irl
#define MOB_SPAWNER_KIND_ANIMALS_LOW "low level animals"
#define MOB_SPAWNER_KIND_ANIMALS_MID "mid level animals"
#define MOB_SPAWNER_KIND_ANIMALS_HIGH "high level animals"
#define MOB_SPAWNER_KIND_ANIMALS_HIGHER "really high level animals"
#define MOB_SPAWNER_KIND_ANIMALS_DEATH "OP animals"

/// swampy wildlife
#define MOB_SPAWNER_KIND_SWAMPLIFE_TRASH "trash swamp animals" // #swamplyfe
#define MOB_SPAWNER_KIND_SWAMPLIFE_LOW "low level swamp animals"
#define MOB_SPAWNER_KIND_SWAMPLIFE_MID "mid level swamp animals"
#define MOB_SPAWNER_KIND_SWAMPLIFE_HIGH "high level swamp animals"
#define MOB_SPAWNER_KIND_SWAMPLIFE_HIGHER "really high level swamp animals"
#define MOB_SPAWNER_KIND_SWAMPLIFE_DEATH "OP swamp animals"

#define MOB_SPAWNER_KIND_DEBUG "debuggies"

/// random-ass humanoids, mostly just raiders tbh
#define MOB_SPAWNER_KIND_RAIDER_LOW "low level raider"
#define MOB_SPAWNER_KIND_RAIDER_HIGH "high level raider"

/// Mob spawner difficulty bitflags
#define MOB_SPAWNER_DIFFICULTY_EASY (1<<0)
#define MOB_SPAWNER_DIFFICULTY_MED (1<<1)
#define MOB_SPAWNER_DIFFICULTY_HARD (1<<2)

/// Global list of random mob spawners, to coordinate them all
/// format: "spawner_key" = list(MOB_SPAWNER_GLOBAL_LIST_KIND = MOB_SPAWNER_GHOUL, MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY = MOB_SPAWNER_DIFFICULTIES)
GLOBAL_LIST_EMPTY(mob_spawner_random_index)
GLOBAL_LIST_EMPTY(random_mob_nest_spawner_groups)
GLOBAL_LIST_EMPTY(random_mob_nest_spawner_datums)

/// Datumized!
/datum/random_mob_spawner_group
	/// tag this group will be accessed by
	var/group_tag
	/// the datum tags this thing references
	var/list/group_list

/// Every mob we can spawn
/datum/random_mob_spawner_group/all
	group_tag = MOB_SPAWNER_KIND_ALL
	group_list = list(
		MOB_SPAWNER_GHOUL,
		MOB_SPAWNER_LESSERSPIDER,
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
		MOB_SPAWNER_PIRATE,
		MOB_SPAWNER_RUSSIAN,
		MOB_SPAWNER_RAIDER_MIXED,
		MOB_SPAWNER_TUNNELLER,
		MOB_SPAWNER_SPORECARRIER,
		MOB_SPAWNER_WANAMINGO,
		MOB_SPAWNER_WOLF,
		MOB_SPAWNER_YAOGUAI,
		MOB_SPAWNER_RATTLER
	)

/// low level robots
/datum/random_mob_spawner_group/robot_low
	group_tag = MOB_SPAWNER_KIND_ROBOT_LOW
	group_list = list(
		MOB_SPAWNER_ROBOT_DOMESTIC
	)

/// high level bots
/datum/random_mob_spawner_group/robot_low
	group_tag = MOB_SPAWNER_KIND_ROBOT_HIGH
	group_list = list(
		MOB_SPAWNER_ROBOT_SECURITY,
		MOB_SPAWNER_ROBOT_MILITARY,
		MOB_SPAWNER_HIVEBOT
	)

/// all trash mobs
/datum/random_mob_spawner_group/all_trash
	group_tag = MOB_SPAWNER_KIND_TRASH
	group_list = list(
		MOB_SPAWNER_BLOATFLY,
		MOB_SPAWNER_GECKO,
		MOB_SPAWNER_BLOATFLY_AND_GECKO,
		MOB_SPAWNER_MOLERAT,
		MOB_SPAWNER_ROACH
	)
/// all low tier mobs
/datum/random_mob_spawner_group/all_low
	group_tag = MOB_SPAWNER_KIND_LOW
	group_list = list(
		MOB_SPAWNER_GHOUL,
		MOB_SPAWNER_LESSERSPIDER,
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_BLOATFLY,
		MOB_SPAWNER_GECKO,
		MOB_SPAWNER_BLOATFLY_AND_GECKO,
		MOB_SPAWNER_RAIDER_MELEE,
		MOB_SPAWNER_MOLERAT,
		MOB_SPAWNER_ROACH
	)

/// all mid tier mobs
/datum/random_mob_spawner_group/all_mid
	group_tag = MOB_SPAWNER_KIND_MID
	group_list = list(
		MOB_SPAWNER_GHOUL,
		MOB_SPAWNER_LESSERSPIDER,
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_CAZADOR,
		MOB_SPAWNER_ROBOT_DOMESTIC,
		MOB_SPAWNER_HIVEBOT,
		MOB_SPAWNER_SCORPIONS,
		MOB_SPAWNER_ANT,
		MOB_SPAWNER_RAIDER_MELEE,
		MOB_SPAWNER_NIGHTSTALKER
	)

/// all high tier mobs
/datum/random_mob_spawner_group/all_high
	group_tag = MOB_SPAWNER_KIND_HIGH
	group_list = list(
		MOB_SPAWNER_GHOUL,
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_CENTAUR,
		MOB_SPAWNER_ROBOT_DOMESTIC,
		MOB_SPAWNER_ROBOT_SECURITY,
		MOB_SPAWNER_CAZADOR,
		MOB_SPAWNER_SCORPIONS,
		MOB_SPAWNER_MOOK,
		MOB_SPAWNER_ANT,
		MOB_SPAWNER_NIGHTSTALKER,
		MOB_SPAWNER_RAIDER_MELEE,
		MOB_SPAWNER_RAIDER_RANGED,
		MOB_SPAWNER_SYNDICATE,
		MOB_SPAWNER_RAIDER_MIXED,
		MOB_SPAWNER_TUNNELLER,
		MOB_SPAWNER_SPORECARRIER,
		MOB_SPAWNER_GREATERSPIDER,
		MOB_SPAWNER_WANAMINGO
	)

/// all higher tier mobs
/datum/random_mob_spawner_group/all_higher
	group_tag = MOB_SPAWNER_KIND_HIGHER
	group_list = list(
		MOB_SPAWNER_ROBOT_SECURITY,
		MOB_SPAWNER_ROBOT_MILITARY,
		MOB_SPAWNER_SUPERMUTANT,
		MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR,
		MOB_SPAWNER_HELLPIG,
		MOB_SPAWNER_RAIDER_RANGED,
		MOB_SPAWNER_RAIDER_MIXED,
		MOB_SPAWNER_SYNDICATE,
		MOB_SPAWNER_GREATERSPIDER,
		MOB_SPAWNER_WANAMINGO,
		MOB_SPAWNER_RATTLER
	)

/// all death tier mobs
/datum/random_mob_spawner_group/all_death
	group_tag = MOB_SPAWNER_KIND_DEATH
	group_list = list(
		MOB_SPAWNER_ROBOT_MILITARY,
		MOB_SPAWNER_SUPERMUTANT,
		MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR,
		MOB_SPAWNER_DEATHCLAW,
		MOB_SPAWNER_HELLPIG,
		MOB_SPAWNER_RAIDER_MIXED,
		MOB_SPAWNER_OMEGASPIDER,
		MOB_SPAWNER_WANAMINGO,
		MOB_SPAWNER_RATTLER
	)

/// low level raiders
/datum/random_mob_spawner_group/raider_low
	group_tag = MOB_SPAWNER_KIND_RAIDER_LOW
	group_list = list(
		MOB_SPAWNER_RAIDER_MELEE,
		MOB_SPAWNER_RAIDER_MIXED,
		MOB_SPAWNER_PIRATE
	)

/// High level raiders
/datum/random_mob_spawner_group/raider_high
	group_tag = MOB_SPAWNER_KIND_RAIDER_HIGH
	group_list = list(
		MOB_SPAWNER_RAIDER_RANGED,
		MOB_SPAWNER_RAIDER_MIXED,
		MOB_SPAWNER_SYNDICATE
	)

/*
 * Animals mostly
 * Good for most wildlife, includes centaurs and wannamingoes
 */

/// trash animals (like raccoons)
/datum/random_mob_spawner_group/animal_trash
	group_tag = MOB_SPAWNER_KIND_ANIMALS_TRASH
	group_list = list(
		MOB_SPAWNER_BLOATFLY,
		MOB_SPAWNER_LESSERSPIDER,
		MOB_SPAWNER_GECKO,
		MOB_SPAWNER_BLOATFLY_AND_GECKO,
		MOB_SPAWNER_MOLERAT,
		MOB_SPAWNER_ROACH
	)

/// Low tier animals
/datum/random_mob_spawner_group/animal_low
	group_tag = MOB_SPAWNER_KIND_ANIMALS_LOW
	group_list = list(
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_BLOATFLY,
		MOB_SPAWNER_LESSERSPIDER,
		MOB_SPAWNER_GECKO,
		MOB_SPAWNER_BLOATFLY_AND_GECKO,
		MOB_SPAWNER_MOLERAT,
		MOB_SPAWNER_ROACH,
		MOB_SPAWNER_ANT,
		MOB_SPAWNER_WOLF,
	)

/// Mid tier animals
/datum/random_mob_spawner_group/animal_mid
	group_tag = MOB_SPAWNER_KIND_ANIMALS_MID
	group_list = list(
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_CAZADOR,
		MOB_SPAWNER_ANT,
		MOB_SPAWNER_SCORPIONS,
		MOB_SPAWNER_NIGHTSTALKER,
		MOB_SPAWNER_WOLF
	)

/// High tier animals
/datum/random_mob_spawner_group/animal_high
	group_tag = MOB_SPAWNER_KIND_ANIMALS_HIGH
	group_list = list(
		MOB_SPAWNER_CENTAUR,
		MOB_SPAWNER_GREATERSPIDER,
		MOB_SPAWNER_CAZADOR,
		MOB_SPAWNER_NIGHTSTALKER,
		MOB_SPAWNER_SCORPIONS,
		MOB_SPAWNER_TUNNELLER,
		MOB_SPAWNER_SPORECARRIER,
		MOB_SPAWNER_WOLF,
		MOB_SPAWNER_YAOGUAI,
		MOB_SPAWNER_RATTLER
	)

/// Higher tier animals
/datum/random_mob_spawner_group/animal_higher
	group_tag = MOB_SPAWNER_KIND_ANIMALS_HIGHER
	group_list = list(
		MOB_SPAWNER_CENTAUR,
		MOB_SPAWNER_GREATERSPIDER,
		MOB_SPAWNER_DEATHCLAW,
		MOB_SPAWNER_HELLPIG,
		MOB_SPAWNER_NIGHTSTALKER,
		MOB_SPAWNER_TUNNELLER,
		MOB_SPAWNER_SPORECARRIER,
		MOB_SPAWNER_WANAMINGO,
		MOB_SPAWNER_YAOGUAI
	)

/// Super deadly animals
/datum/random_mob_spawner_group/animal_death
	group_tag = MOB_SPAWNER_KIND_ANIMALS_DEATH
	group_list = list(
		MOB_SPAWNER_DEATHCLAW,
		MOB_SPAWNER_HELLPIG,
		MOB_SPAWNER_OMEGASPIDER,
		MOB_SPAWNER_WANAMINGO
	)
/*
 * Swamp animals
 * Mutant animals, minus the wierd super duper mutant things
 */

/// Trash swamp animals
/datum/random_mob_spawner_group/swamp_trash // literally everyone
	group_tag = MOB_SPAWNER_KIND_SWAMPLIFE_TRASH
	group_list = list(
		MOB_SPAWNER_BLOATFLY,
		MOB_SPAWNER_GECKO,
		MOB_SPAWNER_BLOATFLY_AND_GECKO,
		MOB_SPAWNER_MOLERAT,
		MOB_SPAWNER_ROACH,
	)

/// Low tier swamp animals
/datum/random_mob_spawner_group/swamp_all
	group_tag = MOB_SPAWNER_KIND_SWAMPLIFE_LOW
	group_list = list(
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_BLOATFLY,
		MOB_SPAWNER_LESSERSPIDER,
		MOB_SPAWNER_GECKO,
		MOB_SPAWNER_BLOATFLY_AND_GECKO,
		MOB_SPAWNER_MOLERAT,
		MOB_SPAWNER_ROACH,
		MOB_SPAWNER_WOLF
	)

/// Mid tier swamp animals
/datum/random_mob_spawner_group/swamp_mid
	group_tag = MOB_SPAWNER_KIND_SWAMPLIFE_MID
	group_list = list(
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_LESSERSPIDER,
		MOB_SPAWNER_CAZADOR,
		MOB_SPAWNER_SCORPIONS,
		MOB_SPAWNER_ANT,
		MOB_SPAWNER_WOLF
	)

/// High tier swamp animals
/datum/random_mob_spawner_group/swamp_high
	group_tag = MOB_SPAWNER_KIND_SWAMPLIFE_HIGH
	group_list = list(
		MOB_SPAWNER_MIRELURK,
		MOB_SPAWNER_GREATERSPIDER,
		MOB_SPAWNER_CAZADOR,
		MOB_SPAWNER_HELLPIG,
		MOB_SPAWNER_SCORPIONS,
		MOB_SPAWNER_ANT,
		MOB_SPAWNER_NIGHTSTALKER,
		MOB_SPAWNER_WOLF,
		MOB_SPAWNER_YAOGUAI,
		MOB_SPAWNER_RATTLER
	)

/// Higher tier swamp animals
/datum/random_mob_spawner_group/swamp_higher
	group_tag = MOB_SPAWNER_KIND_SWAMPLIFE_HIGHER
	group_list = list(
		MOB_SPAWNER_DEATHCLAW,
		MOB_SPAWNER_GREATERSPIDER,
		MOB_SPAWNER_HELLPIG,
		MOB_SPAWNER_NIGHTSTALKER,
		MOB_SPAWNER_YAOGUAI
	)

/// Death tier swamp animals
/datum/random_mob_spawner_group/swamp_death
	group_tag = MOB_SPAWNER_KIND_SWAMPLIFE_DEATH
	group_list = list(
		MOB_SPAWNER_DEATHCLAW,
		MOB_SPAWNER_HELLPIG,
		MOB_SPAWNER_OMEGASPIDER
	)

/// Debug thing (its full of bugs (get it?))
/datum/random_mob_spawner_group/debug
	group_tag = MOB_SPAWNER_KIND_DEBUG
	group_list = list(
		MOB_SPAWNER_DEBUG
	)

/// Datumized!
/datum/random_mob_spawner
	/// tag this spawnerlist'll be accessed by
	var/nest_tag
	/// Name that'll show up on the nest
	var/nest_name
	/// Description of the nest
	var/nest_desc
	/// Icon state of the nest
	var/nest_icon_state
	/// Sound to play when the mob spawns
	var/sound_to_play

	/// Number of mobs the easy nest will allow alive at once
	var/num_mobs_to_spawn_easy
	/// Number of mobs the easy nest will spawn at once
	var/max_mob_swarm_easy = 1
	/// Time between spawns on the easy nest
	var/mob_respawn_time_easy
	/// Weighted random chance list of mobs that the easy nest will spawn
	var/list/mob_list_easy

	/// Number of mobs the medium nest will allow alive at once
	var/num_mobs_to_spawn_medium
	/// Number of mobs the medium nest will spawn at once
	var/max_mob_swarm_medium = 1
	/// Time between spawns on the medium nest
	var/mob_respawn_time_medium
	/// Weighted random chance list of mobs that the easy medium will spawn
	var/list/mob_list_medium

	/// Number of mobs the hard nest will allow alive at once
	var/num_mobs_to_spawn_hard
	/// Number of mobs the hard nest will spawn at once
	var/max_mob_swarm_hard = 1
	/// Time between spawns on the hard nest
	var/mob_respawn_time_hard
	/// Weighted random chance list of mobs that the hard nest will spawn
	var/list/mob_list_hard

/// Ghouls
/datum/random_mob_spawner/ghoul
	nest_tag = MOB_SPAWNER_GHOUL
	nest_name = "ghoul pit"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/ghoul = 10,
		/mob/living/simple_animal/hostile/ghoul/reaver = 1,
		/mob/living/simple_animal/hostile/ghoul/glowing = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/ghoul = 10,
		/mob/living/simple_animal/hostile/ghoul/reaver = 3,
		/mob/living/simple_animal/hostile/ghoul/glowing = 1
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/ghoul = 5,
		/mob/living/simple_animal/hostile/ghoul/reaver = 10,
		/mob/living/simple_animal/hostile/ghoul/glowing = 5
		)

// Lesser Spiders
/datum/random_mob_spawner/lesserspider
	nest_tag = MOB_SPAWNER_LESSERSPIDER
	nest_name = "spider nest"
	nest_desc = "Creepy and covered with webs...weird?"
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/nurse = 5,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 2
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/nurse = 3,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 5,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 3
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 3,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 5,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 3
		)

// Greater Spiders
/datum/random_mob_spawner/greaterspider
	nest_tag = MOB_SPAWNER_GREATERSPIDER
	nest_name = "reaper nest"
	nest_desc = "Tiny eggs surrounded by durable webs are visible..."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/queen = 2
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/queen = 3,
		/mob/living/simple_animal/hostile/poison/giant_spider/empress = 1
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/queen = 4,
		/mob/living/simple_animal/hostile/poison/giant_spider/empress = 2
		)

// Omega Spiders
/datum/random_mob_spawner/omegaspider
	nest_tag = MOB_SPAWNER_OMEGASPIDER
	nest_name = "emperor nest"
	nest_desc = "Glowing red eyes are visible inside..."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONGEST
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/emperor = 2,
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/emperor = 3,
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/emperor = 4,
		)

/// Mirelurks
/datum/random_mob_spawner/mirelurk
	nest_tag = MOB_SPAWNER_MIRELURK
	nest_name = "mirelurk pit"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/mirelurk = 1,
		/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
		/mob/living/simple_animal/hostile/mirelurk/baby = 10
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/mirelurk = 4,
		/mob/living/simple_animal/hostile/mirelurk/hunter = 2,
		/mob/living/simple_animal/hostile/mirelurk/baby = 10
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/mirelurk = 10,
		/mob/living/simple_animal/hostile/mirelurk/hunter = 6,
		/mob/living/simple_animal/hostile/mirelurk/baby = 5
		)

/// Deathclaws
/datum/random_mob_spawner/aethergiest
	nest_tag = MOB_SPAWNER_DEATHCLAW
	nest_name = "aethergiest den"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONGEST
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/aethergiest = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONGEST
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/aethergiest/mother = 1,
		/mob/living/simple_animal/hostile/aethergiest = 1
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONGEST
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/aethergiest/mother = 1,
		/mob/living/simple_animal/hostile/aethergiest/legendary = 1
		)

/// Hellpigs my love
/datum/random_mob_spawner/hellpig
	nest_tag = MOB_SPAWNER_HELLPIG
	nest_name = "hellpig sty"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONGEST
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/hellpig = 1
		)
	num_mobs_to_spawn_medium = 1
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONGEST
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/hellpig = 2
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONGEST
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/hellpig = 3
		)

/// Roachie~
/datum/random_mob_spawner/roach
	nest_tag = MOB_SPAWNER_ROACH
	nest_name = "mutant pillbug mass"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 4
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/pillbug = 20
		)
	num_mobs_to_spawn_medium = 5
	mob_respawn_time_medium = MOB_SPAWNER_TIME_QUICK
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/pillbug = 20
		)
	num_mobs_to_spawn_hard = 6
	mob_respawn_time_hard = MOB_SPAWNER_TIME_QUICKER
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/pillbug = 20
		)

/// Geckos (that arent bold)
/datum/random_mob_spawner/gecko
	nest_tag = MOB_SPAWNER_GECKO
	nest_name = "gecko nest"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 3
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/gecko = 10,
		/mob/living/simple_animal/hostile/gecko/big = 2,
		/mob/living/simple_animal/hostile/gecko/fire = 2,
		/mob/living/simple_animal/hostile/gecko/fire/rads = 2,
		/mob/living/simple_animal/hostile/gecko/legacy = 10,
		/mob/living/simple_animal/hostile/gecko/legacy/alpha = 4,
		)
	num_mobs_to_spawn_medium = 4
	mob_respawn_time_medium = MOB_SPAWNER_TIME_QUICK
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/gecko = 7,
		/mob/living/simple_animal/hostile/gecko/big = 5,
		/mob/living/simple_animal/hostile/gecko/fire = 6,
		/mob/living/simple_animal/hostile/gecko/legacy = 8,
		/mob/living/simple_animal/hostile/gecko/legacy/alpha = 8,
		)
	num_mobs_to_spawn_hard = 5
	mob_respawn_time_hard = MOB_SPAWNER_TIME_QUICKER
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/gecko = 8,
		/mob/living/simple_animal/hostile/gecko/big = 6,
		/mob/living/simple_animal/hostile/gecko/fire = 8,
		/mob/living/simple_animal/hostile/gecko/legacy = 6,
		/mob/living/simple_animal/hostile/gecko/legacy/alpha = 12,
		)

/// Bloatfly (Dan in an airplane)
/datum/random_mob_spawner/bloatfly
	nest_tag = MOB_SPAWNER_BLOATFLY
	nest_name = "bloatfly nest"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/bloatfly = 5
		)
	num_mobs_to_spawn_medium = 3
	mob_respawn_time_medium = MOB_SPAWNER_TIME_QUICK
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/bloatfly = 7
		)
	num_mobs_to_spawn_hard = 4
	mob_respawn_time_hard = MOB_SPAWNER_TIME_QUICKER
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/bloatfly = 9
		)

/// Bloatfly and gecko nest (they're friends turns out)
/datum/random_mob_spawner/bloatfly_and_gecko
	nest_tag = MOB_SPAWNER_BLOATFLY_AND_GECKO
	nest_name = "bloatfly and gecko nest"
	nest_desc = "A gross hole in the ground with two kinds of monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 3
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/gecko = 10,
		/mob/living/simple_animal/hostile/bloatfly = 5
		)
	num_mobs_to_spawn_medium = 4
	mob_respawn_time_medium = MOB_SPAWNER_TIME_QUICK
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/gecko = 10,
		/mob/living/simple_animal/hostile/bloatfly = 10
		)
	num_mobs_to_spawn_hard = 4
	mob_respawn_time_hard = MOB_SPAWNER_TIME_QUICKER
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/gecko = 10,
		/mob/living/simple_animal/hostile/bloatfly = 10
		)

/// Molerats
/datum/random_mob_spawner/molerat
	nest_tag = MOB_SPAWNER_MOLERAT
	nest_name = "giant rat nest"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 4
	mob_respawn_time_easy = MOB_SPAWNER_TIME_QUICK
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/molerat = 10
		)
	num_mobs_to_spawn_medium = 5
	mob_respawn_time_medium = MOB_SPAWNER_TIME_QUICKER
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/molerat = 15
		)
	num_mobs_to_spawn_hard = 6
	mob_respawn_time_hard = MOB_SPAWNER_TIME_QUICKEST
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/molerat = 20
		)

/// Mook

/datum/random_mob_spawner/mook
	nest_tag = MOB_SPAWNER_MOOK
	nest_name = "wanderer den"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/jungle/mook = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/jungle/mook = 3,
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/jungle/mook = 5
		)

/// Hivebots
/datum/random_mob_spawner/hivebot
	nest_tag = MOB_SPAWNER_HIVEBOT
	nest_name = "hivebot datacreator"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 3
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/hivebot = 5
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/hivebot = 3,
		/mob/living/simple_animal/hostile/hivebot/range = 3
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/hivebot/rapid = 3,
		/mob/living/simple_animal/hostile/hivebot/strong = 5
		)

/// Pirates
/datum/random_mob_spawner/pirate
	nest_tag = MOB_SPAWNER_PIRATE
	nest_name = "pirate hideout"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 3
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/raider/pirate/melee = 5
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/raider/pirate/melee = 2,
		/mob/living/simple_animal/hostile/raider/pirate/ranged = 3
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/raider/pirate/ranged = 5,
		)

/// Russians
/datum/random_mob_spawner/russian
	nest_tag = MOB_SPAWNER_RUSSIAN
	nest_name = "russian hideout"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/russian/ranged = 3,
		/mob/living/simple_animal/hostile/russian/ranged/trooper = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/russian/ranged = 2,
		/mob/living/simple_animal/hostile/russian/ranged/mosin = 1
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/russian/ranged/officer = 3,
		/mob/living/simple_animal/hostile/russian/ranged/mosin = 3
		)

/// Syndicate
/datum/random_mob_spawner/syndicate
	nest_tag = MOB_SPAWNER_SYNDICATE
	nest_name = "syndicate hideout"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space = 2,
		/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space/stormtrooper = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg/space = 2,
		/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg/space/stormtrooper = 1
		)
	num_mobs_to_spawn_hard = 1
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/renegade/syndicate/ranged/shotgun/space = 2,
		/mob/living/simple_animal/hostile/renegade/syndicate/ranged/shotgun/space/stormtrooper = 1
		)

/// Cazadores
/datum/random_mob_spawner/cazador
	nest_tag = MOB_SPAWNER_CAZADOR
	nest_name = "cazador nest"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/cazador/young = 10,
		/mob/living/simple_animal/hostile/cazador = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/cazador/young = 5,
		/mob/living/simple_animal/hostile/cazador = 2
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/cazador/young = 3,
		/mob/living/simple_animal/hostile/cazador = 5
		)

/// Scorpins!
/datum/random_mob_spawner/scorpion
	nest_tag = MOB_SPAWNER_SCORPIONS
	nest_name = "radscorpion nest"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/radscorpion = 10
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/radscorpion = 5,
		/mob/living/simple_animal/hostile/radscorpion/black = 5,
		/mob/living/simple_animal/hostile/radscorpion/blue = 5
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/radscorpion = 3,
		/mob/living/simple_animal/hostile/radscorpion/black = 7,
		/mob/living/simple_animal/hostile/radscorpion/blue = 7
		)

/// Ant
/datum/random_mob_spawner/ant
	nest_tag = MOB_SPAWNER_ANT
	nest_name = "ant hill"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/giantant = 10
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_QUICK
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/giantant = 10,
		/mob/living/simple_animal/hostile/fireant = 2
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_QUICKER
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/giantant = 10,
		/mob/living/simple_animal/hostile/fireant = 10
		)

/// Nightstalker hissawoo
/datum/random_mob_spawner/nightstalker
	nest_tag = MOB_SPAWNER_NIGHTSTALKER
	nest_name = "nightstalker den"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/stalker = 1,
		/mob/living/simple_animal/hostile/stalkeryoung = 10
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/stalker = 3,
		/mob/living/simple_animal/hostile/stalkeryoung = 10
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/stalker = 10,
		/mob/living/simple_animal/hostile/stalkeryoung = 3
		)

/// Domestic robots (Handies, protectrons, eyebots, and the odd robobrain)
/datum/random_mob_spawner/robot_domestic
	nest_tag = MOB_SPAWNER_ROBOT_DOMESTIC
	nest_name = "Commercial robot storage"
	nest_desc = "A consumer-grade storage device full of consumer grade robots."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_ROBOT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/handy/protectron = 5,
		/mob/living/simple_animal/hostile/eyebot = 5
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
			/mob/living/simple_animal/hostile/handy/protectron = 5,
			/mob/living/simple_animal/hostile/handy = 2,
			/mob/living/simple_animal/hostile/eyebot/floatingeye = 5
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/handy/robobrain = 5,
		/mob/living/simple_animal/hostile/handy = 5,
		/mob/living/simple_animal/hostile/eyebot/floatingeye = 5
		)

/// Security robots (Securitrons, protectrons, eyebots, and the odd robobrain)
/datum/random_mob_spawner/robot_security
	nest_tag = MOB_SPAWNER_ROBOT_SECURITY
	nest_name = "Security robot storage"
	nest_desc = "A security-grade storage device full of security grade robots."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_ROBOT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/handy/protectron = 5,
		/mob/living/simple_animal/hostile/eyebot = 5
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/handy/protectron = 10,
		/mob/living/simple_animal/hostile/securitron = 3,
		/mob/living/simple_animal/hostile/securitron/sentrybot/nsb/riot = 1
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/handy/robobrain = 10,
		/mob/living/simple_animal/hostile/securitron = 5,
		/mob/living/simple_animal/hostile/securitron/sentrybot/nsb/riot = 5,
		/mob/living/simple_animal/hostile/securitron/sentrybot = 4
		)

/// Military robots (Securitrons, protectrons, eyebots, and the odd robobrain)
/datum/random_mob_spawner/robot_military
	nest_tag = MOB_SPAWNER_ROBOT_MILITARY
	nest_name = "Military robot storage"
	nest_desc = "A military-grade storage device full of military grade robots."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_ROBOT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/handy/robobrain = 5,
		/mob/living/simple_animal/hostile/securitron = 10,
		/mob/living/simple_animal/hostile/securitron/sentrybot = 4
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/handy/assaultron = 5,
		/mob/living/simple_animal/hostile/handy/robobrain = 5,
		/mob/living/simple_animal/hostile/securitron = 10,
		/mob/living/simple_animal/hostile/securitron/sentrybot = 4
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/handy/assaultron = 5,
		/mob/living/simple_animal/hostile/handy/gutsy = 10,
		/mob/living/simple_animal/hostile/securitron = 5,
		/mob/living/simple_animal/hostile/securitron/sentrybot = 4
		)

/// Supermutants
/datum/random_mob_spawner/supermutant
	nest_tag = MOB_SPAWNER_SUPERMUTANT
	nest_name = "supermutant pile"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/supermutant/meleemutant = 3,
		/mob/living/simple_animal/hostile/supermutant = 3
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/supermutant/meleemutant = 5,
		/mob/living/simple_animal/hostile/supermutant/rangedmutant = 5
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/supermutant/nightkin = 5,
		/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant = 5,
		/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant = 1
		)

/// supermutants and centaurs (the gruesome twosome)
/datum/random_mob_spawner/supermutant_and_centaur
	nest_tag = MOB_SPAWNER_SUPERMUTANT_AND_CENTAUR
	nest_name = "supermutant and centaur pile"
	nest_desc = "A gross hole in the ground with monsters and their pets in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/centaur = 10,
		/mob/living/simple_animal/hostile/supermutant/meleemutant = 2,
		/mob/living/simple_animal/hostile/supermutant = 3
		)
	num_mobs_to_spawn_medium = 3
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/centaur = 10,
		/mob/living/simple_animal/hostile/supermutant/meleemutant = 8,
		/mob/living/simple_animal/hostile/supermutant/rangedmutant = 4
		)
	num_mobs_to_spawn_hard = 4
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/centaur = 15,
		/mob/living/simple_animal/hostile/supermutant/nightkin = 8,
		/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant = 5,
		/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant = 1
		)

/// centaurs
/datum/random_mob_spawner/centaur
	nest_tag = MOB_SPAWNER_CENTAUR
	nest_name = "centaur pile"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/centaur = 10
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/centaur = 10
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/centaur = 10
		)

/// melee raiders
/datum/random_mob_spawner/raider_melee
	nest_tag = MOB_SPAWNER_RAIDER_MELEE
	nest_name = "narrow tunnel"
	nest_desc = "A crude tunnel used by raiders to travel across the wasteland."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_VENT // RAIDER VENTED
	sound_to_play = MOB_SPAWNER_SOUND_VENT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/raider = 5,
		/mob/living/simple_animal/hostile/raider/firefighter = 2,
		/mob/living/simple_animal/hostile/raider/baseball = 2,
		/mob/living/simple_animal/hostile/raider/tribal = 2
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/raider = 10,
		/mob/living/simple_animal/hostile/raider/firefighter = 5,
		/mob/living/simple_animal/hostile/raider/baseball = 5,
		/mob/living/simple_animal/hostile/raider/tribal = 5
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/raider = 10,
		/mob/living/simple_animal/hostile/raider/firefighter = 5,
		/mob/living/simple_animal/hostile/raider/baseball = 5,
		/mob/living/simple_animal/hostile/raider/tribal = 5,
		/mob/living/simple_animal/hostile/raider/legendary = 1,
		/mob/living/simple_animal/hostile/raider/sulphite = 2
		)

/// ranged raiders (rangeders?)
/datum/random_mob_spawner/raider_ranged
	nest_tag = MOB_SPAWNER_RAIDER_RANGED
	nest_name = "narrow tunnel"
	nest_desc = "A crude tunnel used by raiders to travel across the wasteland."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_VENT
	sound_to_play = MOB_SPAWNER_SOUND_VENT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/raider/ranged = 5,
		/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 1,
		/mob/living/simple_animal/hostile/raider/ranged/biker = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/raider/ranged = 5,
		/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 3,
		/mob/living/simple_animal/hostile/raider/ranged/biker = 3
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/raider/ranged = 5,
		/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 7,
		/mob/living/simple_animal/hostile/raider/ranged/biker = 7
		)

/// mixed raiders (ranged / melee)
/datum/random_mob_spawner/raider_mixed
	nest_tag = MOB_SPAWNER_RAIDER_MIXED
	nest_name = "narrow tunnel"
	nest_desc = "A crude tunnel used by raiders to travel across the wasteland."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_VENT
	sound_to_play = MOB_SPAWNER_SOUND_VENT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/raider/ranged = 3,
		/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 1,
		/mob/living/simple_animal/hostile/raider/ranged/biker = 1,
		/mob/living/simple_animal/hostile/raider = 3,
		/mob/living/simple_animal/hostile/raider/firefighter = 2,
		/mob/living/simple_animal/hostile/raider/baseball = 2,
		/mob/living/simple_animal/hostile/raider/tribal = 2
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/raider/ranged = 5,
		/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 3,
		/mob/living/simple_animal/hostile/raider/ranged/biker = 3,
		/mob/living/simple_animal/hostile/raider = 10,
		/mob/living/simple_animal/hostile/raider/firefighter = 5,
		/mob/living/simple_animal/hostile/raider/baseball = 5,
		/mob/living/simple_animal/hostile/raider/tribal = 5
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/raider/ranged = 5,
		/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 10,
		/mob/living/simple_animal/hostile/raider/ranged/biker = 10,
		/mob/living/simple_animal/hostile/raider = 5,
		/mob/living/simple_animal/hostile/raider/firefighter = 5,
		/mob/living/simple_animal/hostile/raider/baseball = 5,
		/mob/living/simple_animal/hostile/raider/tribal = 5,
		/mob/living/simple_animal/hostile/raider/legendary = 1,
		/mob/living/simple_animal/hostile/raider/sulphite = 1
		)

/// Tunnelers (formerly CHUDs)
/datum/random_mob_spawner/tunneller
	nest_tag = MOB_SPAWNER_TUNNELLER
	nest_name = "tunneller tunnel"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/trog/tunneler = 5
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/trog/tunneler = 5
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/trog/tunneler = 5
		)

/// spore carriers
/datum/random_mob_spawner/spore_carrier
	nest_tag = MOB_SPAWNER_SPORECARRIER
	nest_name = "spore carrier tunnel"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/trog/sporecarrier = 5
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/trog/sporecarrier = 7
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/trog/sporecarrier = 9
		)

/// yaoguai mcbeevis
/datum/random_mob_spawner/yaoguai
	nest_tag = MOB_SPAWNER_YAOGUAI
	nest_name = "yaoguai den"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/bear/yaoguai = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/bear/yaoguai = 3
		)
	num_mobs_to_spawn_hard = 2
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/bear/yaoguai = 5
		)

/// wolf doggos
/datum/random_mob_spawner/wolf
	nest_tag = MOB_SPAWNER_WOLF
	nest_name = "wolf den"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 2
	mob_respawn_time_easy = MOB_SPAWNER_TIME_DEFAULT
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/wolf = 10
		)
	num_mobs_to_spawn_medium = 3
	mob_respawn_time_medium = MOB_SPAWNER_TIME_DEFAULT
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/wolf = 10,
		/mob/living/simple_animal/hostile/wolf/alpha = 1
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_DEFAULT
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/wolf = 10,
		/mob/living/simple_animal/hostile/wolf/alpha = 5
		)

/// alien wannamingos
/datum/random_mob_spawner/wannamingo
	nest_tag = MOB_SPAWNER_WANAMINGO
	nest_name = "alien ditch"
	nest_desc = "A gross hole in the ground with monsters in it."
	nest_icon_state = MOB_SPAWNER_ICONSTATE_DEFAULT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/alien = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/alien = 2
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/alien = 3
		)

// rattle 'em, boys.
/datum/random_mob_spawner/rattler
	nest_tag = MOB_SPAWNER_RATTLER
	nest_name = "rattling hole"
	nest_desc = "A burrow of rattlers."
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 1
	mob_respawn_time_easy = MOB_SPAWNER_TIME_LONG
	mob_list_easy = list(
		/mob/living/simple_animal/hostile/texas_rattler = 1
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_LONG
	mob_list_medium = list(
		/mob/living/simple_animal/hostile/texas_rattler = 2
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_LONG
	mob_list_hard = list(
		/mob/living/simple_animal/hostile/texas_rattler = 3
		)

/// debug
/datum/random_mob_spawner/debug
	nest_tag = MOB_SPAWNER_DEBUG
	nest_name = "It works!"
	nest_desc = "This also works!"
	nest_icon_state = MOB_SPAWNER_ICONSTATE_ROBOT
	sound_to_play = MOB_SPAWNER_SOUND_DEFAULT

	num_mobs_to_spawn_easy = 5
	mob_respawn_time_easy = MOB_SPAWNER_TIME_QUICKEST
	mob_list_easy = list(
		/mob/living/simple_animal/pet/dog/corgi = 100
		)
	num_mobs_to_spawn_medium = 2
	mob_respawn_time_medium = MOB_SPAWNER_TIME_QUICKEST
	mob_list_medium = list(
		/mob/living/simple_animal/pet/dog/corgi = 100
		)
	num_mobs_to_spawn_hard = 3
	mob_respawn_time_hard = MOB_SPAWNER_TIME_QUICKEST
	mob_list_hard = list(
		/mob/living/simple_animal/pet/dog/corgi = 100
		)

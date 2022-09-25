//max channel is 1024. Only go lower from here, because byond tends to pick the first availiable channel to play sounds on
#define CHANNEL_LOBBYMUSIC 1024
#define CHANNEL_ADMIN 1023
#define CHANNEL_VOX 1022
#define CHANNEL_JUKEBOX 1021
#define CHANNEL_JUKEBOX_START 1016 //The gap between this and CHANNEL_JUKEBOX determines the amount of free jukebox channels. This currently allows 6 jukebox channels to exist.
#define CHANNEL_JUSTICAR_ARK 1015
#define CHANNEL_HEARTBEAT 1014 //sound channel for heartbeats
#define CHANNEL_AMBIENCE 1013
#define CHANNEL_BUZZ 1012
#define CHANNEL_BICYCLE 1011

///Default range of a sound.
#define SOUND_RANGE 17
#define MEDIUM_RANGE_SOUND_EXTRARANGE -5
///default extra range for sounds considered to be quieter
#define SHORT_RANGE_SOUND_EXTRARANGE -9
///The range deducted from sound range for things that are considered silent / sneaky
#define SILENCED_SOUND_EXTRARANGE -11
///Percentage of sound's range where no falloff is applied
#define SOUND_DEFAULT_FALLOFF_DISTANCE 1 //For a normal sound this would be 1 tile of no falloff
///The default exponent of sound falloff
#define SOUND_FALLOFF_EXPONENT 6

//THIS SHOULD ALWAYS BE THE LOWEST ONE!
//KEEP IT UPDATED

#define CHANNEL_HIGHEST_AVAILABLE 1010

#define MAX_INSTRUMENT_CHANNELS (128 * 6)

#define SOUND_MINIMUM_PRESSURE 10
#define FALLOFF_SOUNDS 1


//default byond sound environments
#define SOUND_ENVIRONMENT_NONE -1
#define SOUND_ENVIRONMENT_GENERIC 0
#define SOUND_ENVIRONMENT_PADDED_CELL 1
#define SOUND_ENVIRONMENT_ROOM 2
#define SOUND_ENVIRONMENT_BATHROOM 3
#define SOUND_ENVIRONMENT_LIVINGROOM 4
#define SOUND_ENVIRONMENT_STONEROOM 5
#define SOUND_ENVIRONMENT_AUDITORIUM 6
#define SOUND_ENVIRONMENT_CONCERT_HALL 7
#define SOUND_ENVIRONMENT_CAVE 8
#define SOUND_ENVIRONMENT_ARENA 9
#define SOUND_ENVIRONMENT_HANGAR 10
#define SOUND_ENVIRONMENT_CARPETED_HALLWAY 11
#define SOUND_ENVIRONMENT_HALLWAY 12
#define SOUND_ENVIRONMENT_STONE_CORRIDOR 13
#define SOUND_ENVIRONMENT_ALLEY 14
#define SOUND_ENVIRONMENT_FOREST 15
#define SOUND_ENVIRONMENT_CITY 16
#define SOUND_ENVIRONMENT_MOUNTAINS 17
#define SOUND_ENVIRONMENT_QUARRY 18
#define SOUND_ENVIRONMENT_PLAIN 19
#define SOUND_ENVIRONMENT_PARKING_LOT 20
#define SOUND_ENVIRONMENT_SEWER_PIPE 21
#define SOUND_ENVIRONMENT_UNDERWATER 22
#define SOUND_ENVIRONMENT_DRUGGED 23
#define SOUND_ENVIRONMENT_DIZZY 24
#define SOUND_ENVIRONMENT_PSYCHOTIC 25
//If we ever make custom ones add them here
#define SOUND_ENVIROMENT_PHASED list(1.8, 0.5, -1000, -4000, 0, 5, 0.1, 1, -15500, 0.007, 2000, 0.05, 0.25, 1, 1.18, 0.348, -5, 2000, 250, 0, 3, 100, 63)


//"sound areas": easy way of keeping different types of areas consistent.
#define SOUND_AREA_STANDARD_STATION SOUND_ENVIRONMENT_PARKING_LOT
#define SOUND_AREA_LARGE_ENCLOSED SOUND_ENVIRONMENT_QUARRY
#define SOUND_AREA_SMALL_ENCLOSED SOUND_ENVIRONMENT_BATHROOM
#define SOUND_AREA_TUNNEL_ENCLOSED SOUND_ENVIRONMENT_STONEROOM
#define SOUND_AREA_LARGE_SOFTFLOOR SOUND_ENVIRONMENT_CARPETED_HALLWAY
#define SOUND_AREA_MEDIUM_SOFTFLOOR SOUND_ENVIRONMENT_LIVINGROOM
#define SOUND_AREA_SMALL_SOFTFLOOR SOUND_ENVIRONMENT_ROOM
#define SOUND_AREA_ASTEROID SOUND_ENVIRONMENT_CAVE
#define SOUND_AREA_SPACE SOUND_ENVIRONMENT_UNDERWATER
#define SOUND_AREA_LAVALAND SOUND_ENVIRONMENT_MOUNTAINS
#define SOUND_AREA_ICEMOON SOUND_ENVIRONMENT_CAVE
#define SOUND_AREA_WOODFLOOR SOUND_ENVIRONMENT_CITY


//Ambience types

#define GENERIC list('sound/ambience/ambigen1.ogg','sound/ambience/ambigen3.ogg',\
								'sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg',\
								'sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg',\
								'sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg',\
								'sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg',\
								'sound/ambience/ambigen12.ogg','sound/ambience/ambigen14.ogg','sound/ambience/ambigen15.ogg')

#define HOLY list('sound/ambience/ambicha1.ogg','sound/ambience/ambicha2.ogg','sound/ambience/ambicha3.ogg',\
										'sound/ambience/ambicha4.ogg', 'sound/ambience/ambiholy.ogg', 'sound/ambience/ambiholy2.ogg',\
										'sound/ambience/ambiholy3.ogg')

#define HIGHSEC list('sound/ambience/ambidanger.ogg', 'sound/ambience/ambidanger2.ogg')

#define RUINS list('sound/ambience/ambimine.ogg', 'sound/ambience/ambicave.ogg', 'sound/ambience/ambiruin.ogg',\
									'sound/ambience/ambiruin2.ogg',  'sound/ambience/ambiruin3.ogg',  'sound/ambience/ambiruin4.ogg',\
									'sound/ambience/ambiruin5.ogg',  'sound/ambience/ambiruin6.ogg',  'sound/ambience/ambiruin7.ogg',\
									'sound/ambience/ambidanger.ogg', 'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambitech3.ogg',\
									'sound/ambience/ambimystery.ogg', 'sound/ambience/ambimaint1.ogg')

#define ENGINEERING list('sound/ambience/ambisin1.ogg','sound/ambience/ambisin2.ogg','sound/ambience/ambisin3.ogg','sound/ambience/ambisin4.ogg',\
										'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg', 'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg', 'sound/ambience/ambitech3.ogg')

#define MINING list('sound/ambience/ambimine.ogg', 'sound/ambience/ambicave.ogg', 'sound/ambience/ambiruin.ogg',\
											'sound/ambience/ambiruin2.ogg',  'sound/ambience/ambiruin3.ogg',  'sound/ambience/ambiruin4.ogg',\
											'sound/ambience/ambiruin5.ogg',  'sound/ambience/ambiruin6.ogg',  'sound/ambience/ambiruin7.ogg',\
											'sound/ambience/ambidanger.ogg', 'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambimaint1.ogg', 'sound/ambience/ambilava.ogg')

#define MEDICAL list('sound/ambience/ambinice.ogg')

#define SPOOKY list('sound/ambience/ambimo1.ogg','sound/ambience/ambimo2.ogg','sound/ambience/ambiruin7.ogg','sound/ambience/ambiruin6.ogg',\
										'sound/ambience/ambiodd.ogg', 'sound/ambience/ambimystery.ogg')

#define SPACE list('sound/ambience/ambispace.ogg', 'sound/ambience/ambispace2.ogg', 'sound/ambience/ambiatmos.ogg')

#define MAINTENANCE list('sound/ambience/ambimaint1.ogg', 'sound/ambience/ambimaint2.ogg', 'sound/ambience/ambimaint3.ogg', 'sound/ambience/ambimaint4.ogg',\
											'sound/ambience/ambimaint5.ogg', 'sound/voice/lowHiss2.ogg', 'sound/voice/lowHiss3.ogg', 'sound/voice/lowHiss4.ogg', 'sound/ambience/ambitech2.ogg' )

#define AWAY_MISSION list('sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg', 'sound/ambience/ambiruin.ogg',\
									'sound/ambience/ambiruin2.ogg',  'sound/ambience/ambiruin3.ogg',  'sound/ambience/ambiruin4.ogg',\
									'sound/ambience/ambiruin5.ogg',  'sound/ambience/ambiruin6.ogg',  'sound/ambience/ambiruin7.ogg',\
									'sound/ambience/ambidanger.ogg', 'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambimaint.ogg',\
									'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg', 'sound/ambience/ambiodd.ogg')

#define REEBE list('sound/ambience/ambireebe1.ogg', 'sound/ambience/ambireebe2.ogg', 'sound/ambience/ambireebe3.ogg')



#define CREEPY_SOUNDS list('sound/effects/ghost.ogg', 'sound/effects/ghost2.ogg', 'sound/effects/heart_beat.ogg', 'sound/effects/screech.ogg',\
	'sound/hallucinations/behind_you1.ogg', 'sound/hallucinations/behind_you2.ogg', 'sound/hallucinations/far_noise.ogg', 'sound/hallucinations/growl1.ogg', 'sound/hallucinations/growl2.ogg',\
	'sound/hallucinations/growl3.ogg', 'sound/hallucinations/im_here1.ogg', 'sound/hallucinations/im_here2.ogg', 'sound/hallucinations/i_see_you1.ogg', 'sound/hallucinations/i_see_you2.ogg',\
	'sound/hallucinations/look_up1.ogg', 'sound/hallucinations/look_up2.ogg', 'sound/hallucinations/over_here1.ogg', 'sound/hallucinations/over_here2.ogg', 'sound/hallucinations/over_here3.ogg',\
	'sound/hallucinations/turn_around1.ogg', 'sound/hallucinations/turn_around2.ogg', 'sound/hallucinations/veryfar_noise.ogg', 'sound/hallucinations/wail.ogg')

//fortuna addition. wasteland ambient music goes here.
#define WASTELAND_AMBIENCE list('sound/f13ambience/music/ccc_doesntworkforfree_ambience.ogg','sound/f13ambience/music/hailcaesar_ambience.ogg',\
	'sound/f13ambience/music/invisible_ghosts_ambience.ogg',\
	'sound/f13ambience/music/mole_miners_ambience.ogg',\
	'sound/f13ambience/music/portaltothepast_ambience.ogg','sound/f13ambience/music/wind_and_the_reeds_ambience.ogg')

/// Sound properties! bunch of defines~
/// Mostly for gunfire~

/// Coeff for when the distant sound should start playing, so it doesnt go right from BANG BANG to putter putter
#define SOUND_NORMAL_TO_DISTANT_COEFF 0.75

// Vary?
#define SOUND_PROPERTY_VARY "vary"
#define SP_VARY(x) SOUND_PROPERTY_VARY = x
// Ignore walls?
#define SOUND_PROPERTY_IGNORE_WALLS "ignore_walls"
#define SP_IGNORE_WALLS(x) SOUND_PROPERTY_IGNORE_WALLS = x
// Volume?
#define SOUND_PROPERTY_VOLUME "volume"
#define SP_VOLUME(x) SOUND_PROPERTY_VOLUME = x
// Volume? silenced
#define SOUND_PROPERTY_VOLUME_SILENCED "volume_silenced"
#define SP_VOLUME_SILENCED(x) SOUND_PROPERTY_VOLUME_SILENCED = x
// Normal distance
#define SOUND_PROPERTY_NORMAL_RANGE "normal_distance"
#define SP_NORMAL_RANGE(x) SOUND_PROPERTY_NORMAL_RANGE = (x - SOUND_RANGE)
// Normal distance silenced
#define SOUND_PROPERTY_NORMAL_RANGE_SILENCED "normal_distance_silenced"
#define SP_NORMAL_RANGE_SILENCED(x) SOUND_PROPERTY_NORMAL_RANGE_SILENCED = (x - SOUND_RANGE)

// Distant sound -- plays this past the normal distance
#define SOUND_PROPERTY_DISTANT_SOUND "distant_sound"
#define SP_DISTANT_SOUND(x) SOUND_PROPERTY_DISTANT_SOUND = x
// Distant sound range -- furthest extent that the sound'll reach
#define SOUND_PROPERTY_DISTANT_SOUND_RANGE "distant_range"
#define SP_DISTANT_RANGE(x) SOUND_PROPERTY_DISTANT_SOUND_RANGE = x

/// Typical sound property values
/// Volumes
#define PISTOL_LIGHT_VOLUME 50
#define PISTOL_MEDIUM_VOLUME 50
#define PISTOL_HEAVY_VOLUME 75
#define RIFLE_LIGHT_VOLUME 50
#define RIFLE_MEDIUM_VOLUME 50
#define RIFLE_HEAVY_VOLUME 100
#define SHOTGUN_VOLUME 75
#define GAUSS_VOLUME 75
#define LASER_VOLUME 30
#define PLASMA_VOLUME 50

/// Silenced volume multiplier
#define SILENCED_VOLUME_MULTIPLIER 0.25

/// Silenced range
#define SILENCED_GUN_RANGE -12

/// Normal distances
#define PISTOL_LIGHT_RANGE (SOUND_RANGE + 5)
#define PISTOL_MEDIUM_RANGE (SOUND_RANGE + 7)
#define PISTOL_HEAVY_RANGE (SOUND_RANGE + 14)
#define RIFLE_LIGHT_RANGE (SOUND_RANGE + 10)
#define RIFLE_MEDIUM_RANGE (SOUND_RANGE + 12)
#define RIFLE_HEAVY_RANGE (SOUND_RANGE + 18)
#define SHOTGUN_RANGE (SOUND_RANGE + 10)
#define GAUSS_RANGE (SOUND_RANGE + 10)
#define LASER_RANGE (SOUND_RANGE + 5)
#define PLASMA_RANGE (SOUND_RANGE + 5)

/// distant distances
#define PISTOL_LIGHT_RANGE_DISTANT (PISTOL_LIGHT_RANGE * 7)
#define PISTOL_MEDIUM_RANGE_DISTANT (PISTOL_MEDIUM_RANGE * 8)
#define PISTOL_HEAVY_RANGE_DISTANT (PISTOL_HEAVY_RANGE * 9)
#define RIFLE_LIGHT_RANGE_DISTANT (RIFLE_LIGHT_RANGE * 8)
#define RIFLE_MEDIUM_RANGE_DISTANT (RIFLE_MEDIUM_RANGE * 9)
#define RIFLE_HEAVY_RANGE_DISTANT (RIFLE_HEAVY_RANGE * 10)
#define SHOTGUN_RANGE_DISTANT (SHOTGUN_RANGE * 10)
#define GAUSS_RANGE_DISTANT (GAUSS_RANGE * 10)
#define LASER_RANGE_DISTANT (LASER_RANGE * 7)
#define PLASMA_RANGE_DISTANT (PLASMA_RANGE * 7)

/// distant sounds
#define PISTOL_LIGHT_DISTANT_SOUND 'sound/f13weapons/distant_pistol_light.ogg'
#define PISTOL_MEDIUM_DISTANT_SOUND 'sound/f13weapons/distant_pistol_medium.ogg'
#define PISTOL_HEAVY_DISTANT_SOUND 'sound/f13weapons/distant_pistol_heavy.ogg'
#define RIFLE_LIGHT_DISTANT_SOUND 'sound/f13weapons/distant_rifle_light.ogg'
#define RIFLE_MEDIUM_DISTANT_SOUND 'sound/f13weapons/distant_rifle_medium.ogg'
#define RIFLE_HEAVY_DISTANT_SOUND 'sound/f13weapons/distant_rifle_heavy.ogg'
#define SHOTGUN_DISTANT_SOUND 'sound/f13weapons/distant_shotgun.ogg'
#define GAUSS_DISTANT_SOUND 'sound/f13weapons/distant_gauss.ogg'
#define LASER_DISTANT_SOUND 'sound/f13weapons/distant_laser.ogg'
#define PLASMA_DISTANT_SOUND 'sound/f13weapons/distant_plasma.ogg'

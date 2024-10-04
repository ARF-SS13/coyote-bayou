//Fallout 13 specific areas directory

/area

/area/f13
	name = "error"
	icon_state = "error"
	has_gravity = 1
//	requires_power = 0

//Wasteland generic areas

//Ambigen sound tips for ambientsounds: 
//1 - 2 : outside the ruined buildings, 
//3 - 9 : inside the wasteland buildings,
// 10 - 14 : vaults and bunkers specific, 
//15-19 : caves
//These were defined a long time ago, but we may still consider using them with our new ambient sound system ~TK

///////////////
//C O Y O T E//
//B A Y O U  //
//  AMBIENT  //
//   AREAS   //
///////////////
/area/f13/wasteland
	name = "Wasteland"
	icon_state = "wasteland"
	ambience_area = list(
		/datum/looping_sound/ambient/critters,
		/datum/looping_sound/ambient/critters/extra,
		/datum/looping_sound/ambient/swamp,
		/datum/looping_sound/ambient/critters/birds,
		/datum/looping_sound/ambient/critters/birds/crow,
		/datum/looping_sound/ambient/critters/frogs,
		/datum/looping_sound/ambient/forest,
		/datum/looping_sound/ambient/general/forest,
		/datum/looping_sound/ambient/general/forest/direcitonal
	)
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 19
	grow_chance = 45
	weather_tags = list(WEATHER_ALL)
	ambientmusic = list(
		//AREA_Z_MUSIC(Z_LEVEL_FALLBACK, 'sound/misc/sadtrombone.ogg'),
		//AREA_Z_MUSIC(Z_LEVEL_CENTCOM, 'sound/machines/honkbot_evil_laugh.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NASH_UNDERGROUND, 'sound/ambience/coolloops/sewers.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NASH_COMMON, 'sound/ambience/coolloops/swamp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NASH_LVL2, 'sound/ambience/coolloops/swamp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NASH_LVL3, 'sound/ambience/coolloops/swamp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDWATER, 'sound/ambience/coolloops/swamp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDWATER_UPPER, 'sound/ambience/coolloops/swamp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDLICK, 'sound/ambience/coolloops/swamp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDLICK_UPPER, 'sound/ambience/coolloops/swamp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_GARLAND, 'sound/ambience/coolloops/garland.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NEWBOSTON, 'sound/ambience/coolloops/newboston.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NEWBOSTON_UPPER, 'sound/ambience/coolloops/newboston.ogg'),
	)


/area/f13/wasteland/city
	name = "City"
	icon_state = "yellow"
	ambience_area = list(
		/datum/looping_sound/ambient/city,
		/datum/looping_sound/ambient/critters,
		/datum/looping_sound/ambient/critters/extra,
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/swamp/quiet,
		/datum/looping_sound/ambient/critters/birds,
		/datum/looping_sound/ambient/critters/birds/crow,
		)
	grow_chance = 5

/area/f13/wasteland/town
	name = "Town"
	icon_state = "green"
	ambience_area = list(
		/datum/looping_sound/ambient/town,
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/swamp/quiet,
		/datum/looping_sound/ambient/critters/birds,
		/datum/looping_sound/ambient/critters/birds/crow,
		)
	ambientmusic = null
	grow_chance = 5


/area/f13/building
	name = "Building"
	icon_state = "building"
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/woodcreak,
		)
	weather_tags = null
	outdoors = FALSE

/area/f13/building/abandoned
	name = "Abandoned Building"
	icon_state = "black"
	requires_power = TRUE
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/woodcreak,
		/datum/looping_sound/ambient/lightbulb,
		)

/area/f13/building/hospital
	name = "Hospital Building"
	icon_state = "hospital"
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/woodcreak,
		/datum/looping_sound/ambient/building/hospital,
		)
	weather_tags = null

/area/f13/building/church
	name = "Church Building"
	icon_state = "green"
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/woodcreak,
		/datum/looping_sound/ambient/building/church,
		)

/area/f13/building/tribal
	name = "Tribal Camp"
	icon_state = "orange"
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/woodcreak,
		/datum/looping_sound/ambient/torch,
		/datum/looping_sound/ambient/building/sulphurtribe,
		)

/area/f13/building/tribal/cave
	name = "Tribal Cave"
	icon_state = "purple"
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/woodcreak,
		/datum/looping_sound/ambient/torch,
		/datum/looping_sound/ambient/building/sulphurtribe,
		/datum/looping_sound/ambient/cave,
		/datum/looping_sound/ambient/swamp/quiet,
		/datum/looping_sound/ambient/critters/birds,
		/datum/looping_sound/ambient/critters/birds/crow,
		)

/area/f13/building/tribal/caveofforever
	name = "Tribal Cave of Forever"
	icon_state = "orange"
	has_gravity = 0
	ambience_area = list(
		/datum/looping_sound/ambient/building/sulphurtribe,
		/datum/looping_sound/ambient/building/sulphurtribe/caveofnothing,
		/datum/looping_sound/ambient/critters/birds/crow,
		/datum/looping_sound/ambient/woodcreak
	)

/area/f13/building/tribal/atonement
	name = "Tribal Building - Skull of Atonement"
	icon_state = "orange"
	ambience_area = list(
		/datum/looping_sound/ambient/woodcreak,
		/datum/looping_sound/ambient/torch,
		/datum/looping_sound/ambient/building/sulphurtribe,
		/datum/looping_sound/ambient/critters/birds/crow,
		/datum/looping_sound/ambient/building/sulphurtribe/highwinds,
		/datum/looping_sound/ambient/building/sulphurtribe/highwinds/gong,
		)

/area/f13/building/sewers
	name = "Sewers"
	requires_power = TRUE
	icon_state = "blue"
	ambience_area = list(
		/datum/looping_sound/ambient/sewers,
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/steam,
		)
	ambientmusic = null
	grow_chance = 5
	weather_tags = null

/area/f13/caves
	name = "Caves"
	icon_state = "caves"
	requires_power = TRUE
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/cave,
		/datum/looping_sound/ambient/tunnel,
	)
	weather_tags = null

/area/f13/tunnel
	name = "Tunnel"
	icon_state = "tunnel"
	environment = 21
	grow_chance = 25
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/building,
		/datum/looping_sound/ambient/cave,
		/datum/looping_sound/ambient/tunnel,
	)
	weather_tags = null

/area/f13/bar
	name = "Bar"
	icon_state = "bar"
	ambience_area = list(
		///datum/looping_sound/ambient/radiomusic,
		///datum/looping_sound/ambient/radiostatic,
		///datum/looping_sound/ambient/djswampass,
		/datum/looping_sound/ambient/town,
		/datum/looping_sound/ambient/woodcreak,
	)
	weather_tags = null

/area/f13/wasteland/newboston
	name = "New Boston Wasteland"

/area/f13/wasteland/newboston/redwater
	name = "Redwater Wasteland"

/area/f13/wasteland/garlandcity
	name = "Garland City Wasteland"

/area/f13/wasteland/dungeon
	name = "Dungeon Wasteland"

/// New Boston areas are assumed to be inside unless they're specifically the ../outdoors type
/area/f13/wasteland/city/newboston
	name = "New Boston"
	icon_state = "newboston"
	safe_town = TRUE
	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/woodcreak,
		)
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS))
	weather_tags = null
	outdoors = FALSE

/area/f13/wasteland/city/newboston/outdoors
	name = "New Boston Streets"
	icon_state = "newboston"
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_8.ogg', 10 SECONDS))

	ambience_area = list(
		/datum/looping_sound/ambient/general,
		/datum/looping_sound/ambient/swamp/quiet,
		/datum/looping_sound/ambient/critters/birds,
		/datum/looping_sound/ambient/critters/birds/crow,
		/datum/looping_sound/ambient/woodcreak,
		/datum/looping_sound/ambient/lightbulb,
		

		)
	weather_tags = list(WEATHER_SAFE)
	outdoors = TRUE

/area/f13/wasteland/city/newboston/outdoors/redwater
	name = "Redwater"
	color = "#FF0000"

/area/f13/wasteland/city/newboston/house
	name = "New Boston Housing"
	icon_state = "house"

/area/f13/wasteland/city/newboston/farm
	name = "New Boston Farm"
	icon_state = "farm"

/area/f13/wasteland/city/newboston/bar
	name = "New Boston Bar"
	icon_state = "alcohol"
	outdoors = FALSE

/area/f13/wasteland/city/newboston/bank
	name = "New Boston Bank"
	icon_state = "bank"
	outdoors = FALSE

/area/f13/wasteland/city/newboston/sauna
	name = "New Boston Sauna"
	icon_state = "house1"
	outdoors = FALSE

/area/f13/wasteland/city/newboston/chapel
	name = "New Boston Chapel"
	icon_state = "chapel1"

/area/f13/wasteland/city/newboston/library
	name = "New Boston Library"
	icon_state = "library"

// Believe it or not, light switches are tied to areas, so...
/area/f13/wasteland/city/newboston/house/cabin_one
	icon_state = "sleep1"

/area/f13/wasteland/city/newboston/house/cabin_two
	icon_state = "sleep2"

/area/f13/wasteland/city/newboston/house/cabin_three
	icon_state = "sleep3"

/area/f13/wasteland/city/newboston/house/cabin_four
	icon_state = "sleep4"

/area/f13/wasteland/city/newboston/house/cabin_five
	icon_state = "sleep5"

/area/f13/wasteland/city/newboston/house/cabin_six
	icon_state = "sleep6"

/area/f13/wasteland/city/newboston/house/cabin_seven
	icon_state = "sleep7"

/area/f13/wasteland/city/newboston/house/cabin_eight
	icon_state = "sleep8"

/area/f13/wasteland/city/newboston/house/cabin_nine
	icon_state = "sleep9"

///////////////
//C O Y O T E//
//B A Y O U  //
//  AMBIENT  //
//   AREAS   //
//   END     //
///////////////


/area/f13/wasteland/event
	name = "Wasteland (Event)"

/area/f13/wasteland/east
	name = "Eastern Yuma"
	icon_state = "yumaeast"

/area/f13/wasteland/west
	name = "Western Yuma"
	icon_state = "yumawest"

/area/f13/wasteland/quarry
	name = "Quarry"
	icon_state = "quarry"

/area/f13/wasteland/massfusion
	name = "Mass Fusion Exterior"
	icon_state = "massfusionout"

/area/f13/wasteland/mall
	name = "Yuma Mall Exterior"
	icon_state = "mallex"

/area/f13/wasteland/hospital
	name = "Yuma General Exterior"
	icon_state = "hospitalex"

/area/f13/wasteland/museum
	name = "Museum of Technology Exterior"
	icon_state = "museumex"

/area/f13/wasteland/firestation
	name = "Fire Station Exterior"
	icon_state = "fireex"

/area/f13/wasteland/heaven
	name = "Heaven's Night Exterior"
	icon_state = "heavenex"

/area/f13/wasteland/train
	name = "Train Station Exterior"
	icon_state = "trainex"

/area/f13/wasteland/nanotrasen
	name = "NanoTrasen HQ Exterior"
	icon_state = "nanoex"

/area/f13/wasteland/bighorn
	name = "Bighorn Exterior"
	icon_state = "bighornex"

/area/f13/wasteland/khanfort
	name = "Khan Fortress Exterior"
	icon_state = "khanfortex"

/area/f13/wasteland/followers
	name = "Followers Exterior"
	icon_state = "followersex" //lol

/area/f13/wasteland/bighornbunker
	name = "Bighorn Bunker Exterior"
	icon_state = "bighornbunkerex"

/area/f13/wasteland/ncr
	name = "NCR Outpost Exterior"
	icon_state = "ncrex"

/area/f13/wasteland/legion
	name = "Lil Ceasar's Pizza Legion Fortress Exterior"
	icon_state = "legionex"

/area/f13/forest
	name = "Forest"
	icon_state = "forest"
//	ambientmusic = list('sound/f13music/fo2_wasteland.ogg','sound/f13music/fo2_chapel.ogg','sound/f13music/fo2_world.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/bird_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_8.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_3.ogg', 10 SECONDS))
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 15
	grow_chance = 75
	weather_tags = list(WEATHER_ALL)

/area/f13/ruins
	name = "Ruins"
	icon_state = "ruins"
//	ambientmusic = list('sound/f13music/fo2_ruins.ogg','sound/f13music/fo2_necropolis.ogg','sound/f13music/fo2_raider.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_3.ogg', 10 SECONDS))
	outdoors = 0
	open_space = 1
	blob_allowed = 0
	environment = 5
	grow_chance = 5


/area/f13/shack
	name = "Shack"
	icon_state = "shack"
//	ambientmusic = list('sound/f13music/fo2_ruins.ogg','sound/f13music/fo2_city.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_8.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_15.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_16.ogg', 10 SECONDS))
	environment = 2
	grow_chance = 5


//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_ruins.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_8.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS))
	environment = 2
	grow_chance = 5

/area/f13/building/massfusion
	name = "Mass Fusion Plant"
	icon_state = "massfusionin"

///area/f13/building/hospital
//	name = "Christus Saint Michaels Hospital"
//	icon_state = "hospital"

/area/f13/building/mall
	name = "Yuma Mall"
	icon_state = "mall"

/area/f13/building/museum
	name = "Museum of Technology"
	icon_state = "museum"

/area/f13/building/firestation
	name = "Fire Station"
	icon_state = "fire"

/area/f13/building/trainstation
	name = "Train Station"
	icon_state = "train"

/area/f13/building/nanotrasen
	name = "NanoTrasen HQ"
	icon_state = "nano"

/area/f13/building/khanfort
	name = "Khan Fortress"
	icon_state = "khanfort"

/area/f13/building/bighornbunker
	name = "Bighorn Bunker"
	icon_state = "bighornbunker"

/area/f13/farm
	name = "Farm"
	icon_state = "farm"

//	ambientmusic = list('sound/f13music/fo2_village.ogg','sound/f13music/fo2_wasteland.ogg','sound/f13music/fo2_chapel.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_8.ogg', 10 SECONDS))
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 15
	grow_chance = 50
	weather_tags = list(WEATHER_ALL)

/area/f13/tribe
	name = "Tribe"
	icon_state = "tribe"

//	ambientmusic = list('sound/f13music/fo2_village.ogg','sound/f13music/fo2_wasteland.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_8.ogg', 10 SECONDS))
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 15
	grow_chance = 5
	weather_tags = list(WEATHER_ALL)

/area/f13/village
	name = "Village"
	icon_state = "village"

//	ambientmusic = list('sound/f13music/fo2_village.ogg','sound/f13music/fo2_wasteland.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_4.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 15
	grow_chance = 5
	weather_tags = list(WEATHER_ALL)

/area/f13/outpost
	name = "Outpost"
	icon_state = "outpost"

//	ambientmusic = list('sound/f13music/fo2_outpost.ogg','sound/f13music/fo2_brotherhood.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/battle_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/battle_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/battle_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/bird_4.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 16
	grow_chance = 5

/area/f13/hub
	name = "Hub"
	icon_state = "hub"

//	ambientmusic = list('sound/f13music/fo2_hub.ogg','sound/f13music/fo2_village.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_3.ogg', 10 SECONDS))
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 16
	grow_chance = 5

/area/f13/city
	name = "City"
	icon_state = "city"

//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_hub.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_2.ogg', 10 SECONDS))
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 16
	grow_chance = 5

/area/f13/city/museum
	name = "Museum"
	outdoors = FALSE

/area/f13/city/bighorn
	name = "Bighorn"
	icon_state = "bighorn"

/area/f13/citycaves
	name = "City Caves"
	icon_state = "citycaves"

//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_hub.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_15.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_16.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS))
	environment = 8
	grow_chance = 25

/area/f13/chapel
	name = "Chapel"
	icon_state = "chapel"

//	ambientmusic = list('sound/f13music/fo2_chapel.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/ambience/ambicha1.ogg', 10 SECONDS),
		AREA_SOUND('sound/ambience/ambicha2.ogg', 10 SECONDS),
		AREA_SOUND('sound/ambience/ambicha3.ogg', 10 SECONDS),
		AREA_SOUND('sound/ambience/ambicha4.ogg', 10 SECONDS))
	environment = 5
	grow_chance = 5



//	ambientmusic = list('sound/f13music/fo2_bar.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_2.ogg', 10 SECONDS))

	environment = 2
	grow_chance = 5

/area/f13/bar/heaven
	name = "Heaven's Night"
	icon_state = "heaven"

/area/f13/casino
	name = "Casino"
	icon_state = "casino"

//	ambientmusic = list('sound/f13music/fo2_bar.ogg','sound/f13music/fo2_raiders.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_8.ogg', 10 SECONDS))
	environment = 6
	grow_chance = 5

/area/f13/clinic
	name = "Clinic"
	icon_state = "clinic"

//	ambientmusic = list('sound/f13music/fo2_necropolis.ogg','sound/f13music/fo2_ruins.ogg','sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_desert.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_8.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_17.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_18.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_19.ogg', 10 SECONDS))
	environment = 6
	grow_chance = 5

/area/f13/office
	name = "Office"
	icon_state = "office"

//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_ruins.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_8.ogg', 10 SECONDS))
	environment = 2
	grow_chance = 5

/area/f13/store
	name = "Store"
	icon_state = "store"

//	ambientmusic = list('sound/f13music/fo2_bar.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_8.ogg', 10 SECONDS))
	environment = 4
	grow_chance = 5

/area/f13/bunker
	name = "Bunker"
	icon_state = "bunker"

//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/f13music/fo2_ruins.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_13.ogg', 10 SECONDS))
	environment = 11
	grow_chance = 5

/area/f13/bunker/bunkertwo
	name = "Bunker Two"

/area/f13/bunker/museum
	name = "Bunker Museum"

/area/f13/bunker/bighornbunker
	name = "Bighorn Bunker"
	icon_state = "bighornbunker2"



/area/f13/tunnel/northeast
	name = "North-Eastern Tunnel"
	icon_state = "tunnelne"

/area/f13/tunnel/northwest
	name = "North-Western Tunnel"
	icon_state = "tunnelnw"

/area/f13/tunnel/southeast
	name = "South-Eastern Tunnel"
	icon_state = "tunnelse"

/area/f13/tunnel/southwest
	name = "South-Western Tunnel"
	icon_state = "tunnelsw"

/area/f13/tunnel/southeastoasis
	name = "Oasis Eastern Sewers"
	icon_state = "tunnelse"

/area/f13/tunnel/southwestoasis
	name = "Oasis Western Sewers"
	icon_state = "tunnelsw"

/area/f13/tunnel/sub
	name = "Subway Tunnel"
	icon_state = "tunnelsub"

/area/f13/tunnel/khanfort
	name = "Khan Fortress Tunnel"
	icon_state = "tunnelkhan"

/area/f13/trainstation
	name = "Tunnel"
	icon_state = "tunnel"

//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_15.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_16.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13effects/steam_short.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13effects/steam_long.ogg', 10 SECONDS))
	environment = 21
	grow_chance = 25

/area/f13/sewer
	name = "Sewer"
	icon_state = "sewer"

//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_desert.ogg','sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13effects/steam_short.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13effects/steam_long.ogg', 10 SECONDS))
	environment = 21
	grow_chance = 50

/area/f13/caves
	name = "Caves"
	icon_state = "caves"


//	ambientmusic = list('sound/f13music/fo2_caves.ogg','sound/f13music/fo2_desert.ogg','sound/f13music/fo2_necropolis.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_15.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_16.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_17.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_18.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_19.ogg', 10 SECONDS))
	environment = 8
	grow_chance = 75

/area/f13/subway
	name = "Subway"
	icon_state = "subway"

//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS))
	environment = 21
	grow_chance = 25

/area/f13/secret
	name = "Secret"
	icon_state = "secret"

//	ambientmusic = list('sound/f13music/fo2_chapel.ogg','sound/f13music/fo2_city.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/ambience/signal.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_13.ogg', 10 SECONDS))
	environment = 11
	grow_chance = 0

/area/f13/radiation
	name = "Radiation"
	icon_state = "radiation"

//	ambientmusic = list('sound/f13music/fo2_wasteland.ogg','sound/f13music/fo2_desert.ogg','sound/f13music/fo2_world.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/rattlesnake_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/rattlesnake_3.ogg', 10 SECONDS))
	environment = 19
	grow_chance = 5

//Faction related areas

/area/f13/raiders
	name = "Raiders"
	icon_state = "raiders"

//	ambientmusic = list('sound/f13music/fo2_raider.ogg','sound/f13music/fo2_raiders.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/battle_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/battle_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/battle_3.ogg', 10 SECONDS))
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 6
	grow_chance = 5
	weather_tags = list(WEATHER_ALL)

/area/f13/vault
	name = "Vault"
	icon_state = "vaulttec"

//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_13.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_14.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13effects/steam_short.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13effects/steam_long.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 6
	grow_chance = 5

/area/f13/vault/reactor
	name = "Reactor"
	icon_state = "engine"

/area/f13/vault/storage
	name = "Storage"
	icon_state = "storage"

/area/f13/vault/storageoffice
	name = "Storage Office"
	icon_state = "storage_wing"

/area/f13/vault/overseer
	name = "Overseer"
	icon_state = "overseer_office"

/area/f13/vault/chiefoffice
	name = "Chief Office"
	icon_state = "sec_hos"

/area/f13/vault/idcontrol
	name = "ID Control Office"
	icon_state = "hop_office"

/area/f13/vault/vents
	name = "Vents"
	icon_state = "red"

/area/f13/vault/botcontrol
	name = "Bot Control"
	icon_state = "mechbay"

/area/f13/vault/atrium
	name = "Vault Atrium"
	icon_state = "vault_atrium_upper"

/area/f13/vault/security
	name = "Brig"
	icon_state = "brig"

/area/f13/vault/security/checkpoint
	name = "Security Checkpoint"
	icon_state = "checkpoint1"

/area/f13/vault/security/armory
	name = "Armory"
	icon_state = "armory"

/area/f13/vault/medical
	name = "Medical Center"
	icon_state = "medbay"

/area/f13/vault/medical/surgery
	name = "Surgery"
	icon_state = "surgery"

/area/f13/vault/medical/breakroom
	name = "Break Room"
	icon_state = "medbay2"

/area/f13/vault/medical/morgue
	name = "Morgue"
	icon_state = "morgue"

/area/f13/vault/medical/chemistry
	name = "Chemistry"
	icon_state = "chem"

/area/f13/vault/science
	name = "Science"
	icon_state = "purple"

/area/f13/vault/science/biology
	name = "Biology"
	icon_state = "purple"

/area/f13/vault/garden
	name = "Garden"
	icon_state = "garden"

/area/f13/vault/diner
	name = "Dining Hall"
	icon_state = "cafeteria"

/area/f13/vault/custodial
	name = "Custodial Closet"
	icon_state = "auxstorage"

/area/f13/vault/dormitory
	name = "Dormitory"
	icon_state = "crew_quarters"

/area/f13/vault/lavatory
	name = "Lavatory"
	icon_state = "restrooms"

/area/f13/brotherhood
	name = "Brotherhood of Steel Bunker"//Brother Hood
	icon_state = "brotherhood"

//	ambientmusic = list('sound/f13music/fo2_brotherhood.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_13.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 6
	grow_chance = 5

/area/f13/brotherhood/rnd
	name = "Brotherhood of Steel RnD Department"//Brother Hood
	icon_state = "brotherhoodrnddepartment"

/area/f13/brotherhood/offices1st
	name = "Brotherhood of Steel 1st Floor Offices"//Brother Hood
	icon_state = "brotherhoodoffices1st"

/area/f13/brotherhood/offices2nd
	name = "Brotherhood of Steel 1st Floor Offices"//Brother Hood
	icon_state = "brotherhoodoffices2nd"

/area/f13/brotherhood/surface
	name = "Brotherhood of Steel Surface Outpost"//Brother Hood
	icon_state = "brotherhood"

/area/f13/brotherhood/medical
	name = "Brotherhood of Steel Medbay"//Brother Hood
	icon_state = "brotherhoodmedbay"

/area/f13/brotherhood/operating
	name = "Brotherhood of Steel Operating Room"//Brother Hood
	icon_state = "brotherhoodoperating"

/area/f13/brotherhood/chemistry
	name = "Brotherhood of Steel Chemistry Lab"//Brother Hood
	icon_state = "brotherhoodchemistry"

/area/f13/brotherhood/dorms
	name = "Brotherhood of Steel Dormitories"//Brother Hood
	icon_state = "brotherhooddorms"

/area/f13/brotherhood/armory
	name = "Brotherhood of Steel Armory"//Brother Hood
	icon_state = "brotherhoodarmory"

/area/f13/brotherhood/archives
	name = "Brotherhood of Steel Archives"//Brother Hood
	icon_state = "brotherhoodarchives"

/area/f13/brotherhood/operations
	name = "Brotherhood of Steel Operations Department"//Brother Hood
	icon_state = "brotherhoodoperationsdepartment"

/area/f13/brotherhood/leisure
	name = "Brotherhood of Steel Leisure Areas"//Brother Hood
	icon_state = "brotherhoodleisure"

/area/f13/brotherhood/reactor
	name = "Brotherhood of Steel Reactor"//Brother Hood
	icon_state = "brotherhoodreactor"

/area/f13/brotherhood/mining
	name = "Brotherhood of Steel Mining"//Brother Hood
	icon_state = "brotherhoodmining"

/area/f13/enclave
	name = "Enclave Bunker"
	icon_state = "enclave"

//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_13.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_14.ogg', 10 SECONDS),
		AREA_SOUND('sound/ambience/signal.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/enclave_vault.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 6
	grow_chance = 5

/area/f13/ahs
	name = "Adepts of Hubology Studies"
	icon_state = "ahs"

//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_13.ogg', 10 SECONDS),
		AREA_SOUND('sound/ambience/signal.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 5
	grow_chance = 5

/area/f13/ncr
	name = "NCR Outpost"
	icon_state = "ncr"

//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_5.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_6.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_7.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_8.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_9.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 4
	grow_chance = 5
	requires_power = FALSE

/area/f13/legion
	name = "Legion Fortress"
	icon_state = "legion"

//	ambientmusic = list('sound/f13music/fo2_hub.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_3.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_4.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_15.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_16.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_1.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_2.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/dog_distant_3.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 4
	grow_chance = 5
	weather_tags = list(WEATHER_ALL)

/area/f13/followers
	name = "Followers of the Apocalypse Clinic"
	icon_state = "followers"

//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list(
		AREA_SOUND('sound/f13ambience/ambigen_10.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_11.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_12.ogg', 10 SECONDS),
		AREA_SOUND('sound/f13ambience/ambigen_13.ogg', 10 SECONDS),
		AREA_SOUND('sound/ambience/signal.ogg', 10 SECONDS))
	blob_allowed = 0
	environment = 5
	grow_chance = 5

/area/f13/wasteland/khans
	name = "Great Khan Encampment"
	icon_state = "tribe"
	weather_tags = list(WEATHER_ALL)

/area/f13/dragon_boss
	name = "Nagavox's Lair"
	icon_state = "tribe"
	outdoors = TRUE

/area/debug_mussy
	name = "Musical Hellscape"
	icon_state = "tribe"
	ambientmusic = list(
		AREA_Z_MUSIC(Z_LEVEL_FALLBACK, 'sound/misc/sadtrombone.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_CENTCOM, 'sound/machines/honkbot_evil_laugh.ogg'),
		// AREA_Z_MUSIC(Z_LEVEL_NASH_UNDERGROUND, 'sound/weapons/bite.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NASH_COMMON, 'sound/weapons/bite.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NASH_LVL2, 'sound/weapons/slap.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NASH_LVL3, 'sound/effects/snap.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDWATER, 'sound/effects/bworp.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDWATER_UPPER, 'honk/sound/emotes/laugh_f1.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDLICK, 'honk/sound/emotes/female_giggle_1.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_REDLICK_UPPER, 'sound/effects/malegiggle1.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_GARLAND, 'sound/weapons/Genhit.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NEWBOSTON, 'sound/effects/bamf.ogg'),
		AREA_Z_MUSIC(Z_LEVEL_NEWBOSTON_UPPER, 'sound/effects/Huuu.ogg'),
	)

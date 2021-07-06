//Fallout 13 specific areas directory

/area
	var/open_space = 0
//	var/list/ambientmusic = list('sound/misc/null.ogg')
//	var/ambience_area =  list('sound/f13ambience/wasteland.ogg')
	ambientsounds = list('sound/misc/null.ogg')
	var/environment = -1
	var/grow_chance = 100

/area/f13
	name = "error"
	icon_state = "error"
	has_gravity = 1
//	requires_power = 0

//Wasteland generic areas

//Ambigen sound tips for ambientsounds: 1 - 2 : outside the ruined buildings, 3 - 9 : inside the wasteland buildings, 10 - 14 : vaults and bunkers specific, 15-19 : caves

/area/f13/wasteland
	name = "Wasteland"
	icon_state = "wasteland"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_wasteland.ogg','sound/f13music/fo2_desert.ogg','sound/f13music/fo2_world.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/battle_1.ogg','sound/f13ambience/battle_2.ogg','sound/f13ambience/battle_3.ogg', \
	'sound/f13ambience/rattlesnake_1.ogg','sound/f13ambience/rattlesnake_2.ogg','sound/f13ambience/rattlesnake_3.ogg','sound/f13ambience/bird_1.ogg','sound/f13ambience/bird_2.ogg','sound/f13ambience/bird_3.ogg','sound/f13ambience/bird_4.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 19
	grow_chance = 45

/area/f13/forest
	name = "Forest"
	icon_state = "forest"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_wasteland.ogg','sound/f13music/fo2_chapel.ogg','sound/f13music/fo2_world.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/bird_1.ogg','sound/f13ambience/bird_2.ogg','sound/f13ambience/bird_3.ogg','sound/f13ambience/bird_4.ogg','sound/f13ambience/bird_5.ogg','sound/f13ambience/bird_6.ogg','sound/f13ambience/bird_7.ogg','sound/f13ambience/bird_8.ogg', \
	'sound/f13ambience/rattlesnake_1.ogg','sound/f13ambience/rattlesnake_2.ogg','sound/f13ambience/rattlesnake_3.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 15
	grow_chance = 75

/area/f13/ruins
	name = "Ruins"
	icon_state = "ruins"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_ruins.ogg','sound/f13music/fo2_necropolis.ogg','sound/f13music/fo2_raider.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_1.ogg','sound/f13ambience/ambigen_2.ogg','sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg', \
	'sound/f13ambience/rattlesnake_1.ogg','sound/f13ambience/rattlesnake_2.ogg','sound/f13ambience/rattlesnake_3.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 5
	grow_chance = 5

/area/f13/shack
	name = "Shack"
	icon_state = "shack"
//	ambience_area =  list('sound/f13ambience/shack.ogg')
//	ambientmusic = list('sound/f13music/fo2_ruins.ogg','sound/f13music/fo2_city.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg','sound/f13ambience/ambigen_5.ogg', \
	'sound/f13ambience/ambigen_6.ogg','sound/f13ambience/ambigen_7.ogg','sound/f13ambience/ambigen_8.ogg','sound/f13ambience/ambigen_15.ogg','sound/f13ambience/ambigen_16.ogg')
	environment = 2
	grow_chance = 5

/area/f13/building
	name = "Building"
	icon_state = "building"
//	ambience_area =  list('sound/f13ambience/building.ogg')
//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_ruins.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg','sound/f13ambience/ambigen_5.ogg', \
	'sound/f13ambience/ambigen_6.ogg','sound/f13ambience/ambigen_7.ogg','sound/f13ambience/ambigen_8.ogg','sound/f13ambience/ambigen_9.ogg')
	environment = 2
	grow_chance = 5

/area/f13/farm
	name = "Farm"
	icon_state = "farm"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_village.ogg','sound/f13music/fo2_wasteland.ogg','sound/f13music/fo2_chapel.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg', \
	'sound/f13ambience/bird_1.ogg','sound/f13ambience/bird_2.ogg','sound/f13ambience/bird_3.ogg','sound/f13ambience/bird_4.ogg','sound/f13ambience/bird_5.ogg','sound/f13ambience/bird_6.ogg','sound/f13ambience/bird_7.ogg','sound/f13ambience/bird_8.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 15
	grow_chance = 50

/area/f13/tribe
	name = "Tribe"
	icon_state = "tribe"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_village.ogg','sound/f13music/fo2_wasteland.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg', \
	'sound/f13ambience/bird_1.ogg','sound/f13ambience/bird_2.ogg','sound/f13ambience/bird_3.ogg','sound/f13ambience/bird_4.ogg','sound/f13ambience/bird_5.ogg','sound/f13ambience/bird_6.ogg','sound/f13ambience/bird_7.ogg','sound/f13ambience/bird_8.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 15
	grow_chance = 5

/area/f13/village
	name = "Village"
	icon_state = "village"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_village.ogg','sound/f13music/fo2_wasteland.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg', \
	'sound/f13ambience/bird_1.ogg','sound/f13ambience/bird_2.ogg','sound/f13ambience/bird_3.ogg','sound/f13ambience/bird_4.ogg')
	blob_allowed = 0
	environment = 15
	grow_chance = 5

/area/f13/outpost
	name = "Outpost"
	icon_state = "outpost"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_outpost.ogg','sound/f13music/fo2_brotherhood.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/battle_1.ogg','sound/f13ambience/battle_2.ogg','sound/f13ambience/battle_3.ogg', \
	'sound/f13ambience/bird_1.ogg','sound/f13ambience/bird_2.ogg','sound/f13ambience/bird_3.ogg','sound/f13ambience/bird_4.ogg')
	blob_allowed = 0
	environment = 16
	grow_chance = 5

/area/f13/hub
	name = "Hub"
	icon_state = "hub"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_hub.ogg','sound/f13music/fo2_village.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg', \
	'sound/f13ambience/rattlesnake_1.ogg','sound/f13ambience/rattlesnake_2.ogg','sound/f13ambience/rattlesnake_3.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 16
	grow_chance = 5

/area/f13/city
	name = "City"
	icon_state = "city"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_hub.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg', \
	'sound/f13ambience/ambigen_1.ogg','sound/f13ambience/ambigen_2.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 16
	grow_chance = 5

/area/f13/city/museum
	name = "Museum"
	outdoors = FALSE

/area/f13/citycaves
	name = "City Caves"
	icon_state = "citycaves"
//	ambience_area =  list('sound/f13ambience/cave.ogg')
//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_hub.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_15.ogg','sound/f13ambience/ambigen_16.ogg','sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg')
	environment = 8
	grow_chance = 25

/area/f13/chapel
	name = "Chapel"
	icon_state = "chapel"
//	ambience_area =  list('sound/f13ambience/building.ogg')
//	ambientmusic = list('sound/f13music/fo2_chapel.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/ambience/ambicha1.ogg','sound/ambience/ambicha2.ogg','sound/ambience/ambicha3.ogg','sound/ambience/ambicha4.ogg')
	environment = 5
	grow_chance = 5

/area/f13/bar
	name = "Bar"
	icon_state = "bar"
//	ambience_area =  list('sound/f13ambience/building.ogg')
//	ambientmusic = list('sound/f13music/fo2_bar.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	environment = 2
	grow_chance = 5

/area/f13/casino
	name = "Casino"
	icon_state = "casino"
//	ambience_area =  list('sound/f13ambience/warehouse.ogg')
//	ambientmusic = list('sound/f13music/fo2_bar.ogg','sound/f13music/fo2_raiders.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg','sound/f13ambience/ambigen_5.ogg', \
	'sound/f13ambience/ambigen_6.ogg','sound/f13ambience/ambigen_7.ogg','sound/f13ambience/ambigen_8.ogg')
	environment = 6
	grow_chance = 5

/area/f13/clinic
	name = "Clinic"
	icon_state = "clinic"
//	ambience_area =  list('sound/f13ambience/warehouse.ogg')
//	ambientmusic = list('sound/f13music/fo2_necropolis.ogg','sound/f13music/fo2_ruins.ogg','sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_desert.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_1.ogg','sound/f13ambience/ambigen_2.ogg','sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg', \
	'sound/f13ambience/ambigen_5.ogg','sound/f13ambience/ambigen_6.ogg','sound/f13ambience/ambigen_7.ogg','sound/f13ambience/ambigen_8.ogg','sound/f13ambience/ambigen_9.ogg','sound/f13ambience/ambigen_17.ogg','sound/f13ambience/ambigen_18.ogg','sound/f13ambience/ambigen_19.ogg')
	environment = 6
	grow_chance = 5

/area/f13/office
	name = "Office"
	icon_state = "office"
//	ambience_area =  list('sound/f13ambience/warehouse.ogg')
//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_ruins.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg','sound/f13ambience/ambigen_5.ogg', \
	'sound/f13ambience/ambigen_6.ogg','sound/f13ambience/ambigen_7.ogg','sound/f13ambience/ambigen_8.ogg')
	environment = 2
	grow_chance = 5

/area/f13/store
	name = "Store"
	icon_state = "store"
//	ambience_area =  list('sound/f13ambience/building.ogg')
//	ambientmusic = list('sound/f13music/fo2_bar.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg','sound/f13ambience/ambigen_5.ogg', \
	'sound/f13ambience/ambigen_6.ogg','sound/f13ambience/ambigen_7.ogg','sound/f13ambience/ambigen_8.ogg')
	environment = 4
	grow_chance = 5

/area/f13/bunker
	name = "Bunker"
	icon_state = "bunker"
//	ambience_area =  list('sound/f13ambience/building.ogg')
//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/f13music/fo2_ruins.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_1.ogg','sound/f13ambience/ambigen_2.ogg','sound/f13ambience/ambigen_9.ogg','sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg', \
	'sound/f13ambience/ambigen_12.ogg','sound/f13ambience/ambigen_13.ogg')
	environment = 11
	grow_chance = 5

/area/f13/bunker/bunkertwo
	name = "Bunker Two"

/area/f13/bunker/museum
	name = "Bunker Museum"

/area/f13/tunnel
	name = "Tunnel"
	icon_state = "tunnel"
//	ambience_area =  list('sound/f13ambience/cave.ogg')
//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_9.ogg','sound/f13ambience/ambigen_12.ogg','sound/f13ambience/ambigen_15.ogg','sound/f13ambience/ambigen_16.ogg','sound/f13effects/steam_short.ogg','sound/f13effects/steam_long.ogg')
	environment = 21
	grow_chance = 25

/area/f13/trainstation
	name = "Tunnel"
	icon_state = "tunnel"
//	ambience_area =  list('sound/f13ambience/cave.ogg')
//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_9.ogg','sound/f13ambience/ambigen_12.ogg','sound/f13ambience/ambigen_15.ogg','sound/f13ambience/ambigen_16.ogg','sound/f13effects/steam_short.ogg','sound/f13effects/steam_long.ogg')
	environment = 21
	grow_chance = 25

/area/f13/sewer
	name = "Sewer"
	icon_state = "sewer"
//	ambience_area =  list('sound/f13ambience/sewer.ogg')
//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_desert.ogg','sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_9.ogg','sound/f13effects/steam_short.ogg','sound/f13effects/steam_long.ogg')
	environment = 21
	grow_chance = 50

/area/f13/caves
	name = "Caves"
	icon_state = "caves"
//	ambience_area =  list('sound/f13ambience/cave.ogg')
//	ambientmusic = list('sound/f13music/fo2_caves.ogg','sound/f13music/fo2_desert.ogg','sound/f13music/fo2_necropolis.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_15.ogg','sound/f13ambience/ambigen_16.ogg','sound/f13ambience/ambigen_17.ogg','sound/f13ambience/ambigen_18.ogg','sound/f13ambience/ambigen_19.ogg')
	environment = 8
	grow_chance = 75

/area/f13/subway
	name = "Subway"
	icon_state = "subway"
//	ambience_area =  list('sound/f13ambience/cave.ogg')
//	ambientmusic = list('sound/f13music/fo2_tunnels.ogg','sound/f13music/fo2_caves.ogg','sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_1.ogg','sound/f13ambience/ambigen_2.ogg','sound/f13ambience/ambigen_9.ogg','sound/f13ambience/ambigen_12.ogg')
	environment = 21
	grow_chance = 25

/area/f13/secret
	name = "Secret"
	icon_state = "secret"
//	ambience_area =  list('sound/f13ambience/building.ogg')
//	ambientmusic = list('sound/f13music/fo2_chapel.ogg','sound/f13music/fo2_city.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/ambience/signal.ogg','sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg', \
	'sound/f13ambience/ambigen_12.ogg','sound/f13ambience/ambigen_13.ogg')
	environment = 11
	grow_chance = 0

/area/f13/radiation
	name = "Radiation"
	icon_state = "radiation"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_wasteland.ogg','sound/f13music/fo2_desert.ogg','sound/f13music/fo2_world.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/rattlesnake_1.ogg','sound/f13ambience/rattlesnake_2.ogg','sound/f13ambience/rattlesnake_3.ogg')
	environment = 19
	grow_chance = 5

//Faction related areas

/area/f13/raiders
	name = "Raiders"
	icon_state = "raiders"
//	ambience_area =  list('sound/f13ambience/wasteland.ogg')
//	ambientmusic = list('sound/f13music/fo2_raider.ogg','sound/f13music/fo2_raiders.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_1.ogg','sound/f13ambience/ambigen_2.ogg','sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg', \
	'sound/f13ambience/battle_1.ogg','sound/f13ambience/battle_2.ogg','sound/f13ambience/battle_3.ogg')
	outdoors = 1
	open_space = 1
	blob_allowed = 0
	environment = 6
	grow_chance = 5

/area/f13/vault
	name = "Vault"
	icon_state = "vaulttec"
//	ambience_area =  list('sound/f13ambience/vaulttec_vault.ogg')
//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg','sound/f13ambience/ambigen_12.ogg', \
	'sound/f13ambience/ambigen_13.ogg','sound/f13ambience/ambigen_14.ogg','sound/f13effects/steam_short.ogg','sound/f13effects/steam_long.ogg')
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
	name = "Brotherhood of Steel"//Brother Hood
	icon_state = "brotherhood"
//	ambience_area =  list('sound/f13ambience/enclave_vault.ogg')
//	ambientmusic = list('sound/f13music/fo2_brotherhood.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_9.ogg','sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg', \
	'sound/f13ambience/ambigen_12.ogg','sound/f13ambience/ambigen_13.ogg')
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
	name = "Enclave"
	icon_state = "enclave"
//	ambience_area =  list('sound/f13ambience/enclave_vault.ogg')
//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg','sound/f13ambience/ambigen_12.ogg', \
	'sound/f13ambience/ambigen_13.ogg','sound/f13ambience/ambigen_14.ogg','sound/ambience/signal.ogg','sound/f13ambience/enclave_vault.ogg')
	blob_allowed = 0
	environment = 6
	grow_chance = 5

/area/f13/ahs
	name = "Adepts of Hubology Studies"
	icon_state = "ahs"
//	ambience_area =  list('sound/f13ambience/enclave_vault.ogg')
//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg','sound/f13ambience/ambigen_12.ogg', \
	'sound/f13ambience/ambigen_13.ogg','sound/ambience/signal.ogg')
	blob_allowed = 0
	environment = 5
	grow_chance = 5

/area/f13/ncr
	name = "NCR"
	icon_state = "ncr"
//	ambience_area =  list('sound/f13ambience/warehouse.ogg')
//	ambientmusic = list('sound/f13music/fo2_city.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg','sound/f13ambience/ambigen_5.ogg','sound/f13ambience/ambigen_6.ogg','sound/f13ambience/ambigen_7.ogg', \
	'sound/f13ambience/ambigen_8.ogg','sound/f13ambience/ambigen_9.ogg','sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg','sound/f13ambience/ambigen_12.ogg')
	blob_allowed = 0
	environment = 4
	grow_chance = 5
	requires_power = FALSE

/area/f13/legion
	name = "Legion"
	icon_state = "legion"
//	ambience_area =  list('sound/f13ambience/building.ogg')
//	ambientmusic = list('sound/f13music/fo2_hub.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_3.ogg','sound/f13ambience/ambigen_4.ogg','sound/f13ambience/ambigen_15.ogg','sound/f13ambience/ambigen_16.ogg', \
	'sound/f13ambience/dog_distant_1.ogg','sound/f13ambience/dog_distant_2.ogg','sound/f13ambience/dog_distant_3.ogg')
	blob_allowed = 0
	environment = 4
	grow_chance = 5

/area/f13/followers
	name = "Followers of the Apocalypse"
	icon_state = "followers"
//	ambience_area =  list('sound/f13ambience/warehouse.ogg')
//	ambientmusic = list('sound/f13music/fo2_vats.ogg','sound/f13music/fo2_outpost.ogg','sound/misc/null.ogg')
	ambientsounds = list('sound/f13ambience/ambigen_10.ogg','sound/f13ambience/ambigen_11.ogg','sound/f13ambience/ambigen_12.ogg', \
	'sound/f13ambience/ambigen_13.ogg','sound/ambience/signal.ogg')
	blob_allowed = 0
	environment = 5
	grow_chance = 5

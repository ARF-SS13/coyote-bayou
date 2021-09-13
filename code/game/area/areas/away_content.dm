/*
Unused icons for new areas are "awaycontent1" ~ "awaycontent30"
*/


// Away Missions
/area/awaymission
	name = "Strange Location"
	icon_state = "away"
	has_gravity = STANDARD_GRAVITY
	ambientsounds = AWAY_MISSION

/area/awaymission/beach
	name = "Beach"
	icon_state = "away"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	ambientsounds = list('sound/ambience/shore.ogg', 'sound/ambience/seag1.ogg','sound/ambience/seag2.ogg','sound/ambience/seag2.ogg','sound/ambience/ambiodd.ogg','sound/ambience/ambinice.ogg')

/area/awaymission/errorroom
	name = "Super Secret Room"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	has_gravity = STANDARD_GRAVITY

/area/awaymission/vr
	name = "Virtual Reality"
	icon_state = "awaycontent1"
	has_gravity = STANDARD_GRAVITY
	requires_power = FALSE

/area/awaymission/vr/bos
	name = "\improper Bos VR"

/area/awaymission/vr/followers
	name = "\improper Followers VR"

/area/awaymission/vr/den
	name = "\improper Den VR"

/area/awaymission/vr/public
	name = "\improper Public VR"

/area/awaymission/vr/bos/enclavebunker
	name = "Enclave Bunker VR Mission"

/area/awaymission/vr/bos/casino
	name = "Casino VR Mission"

/area/awaymission/vr/bos/deathmatch/
	name = "Arena VR Mission"

/area/awaymission/vr/bos/deathmatch/blue
	name = "Arena VR Mission Blue Team"

/area/awaymission/vr/bos/deathmatch/red
	name = "Arena VR Mission Red Team"

/area/awaymission/vr/public/deathmatch/
	name = "Public Arena VR Mission"

/area/awaymission/vr/public/deathmatch/blue
	name = "Public Arena VR Mission Blue Team"

/area/awaymission/vr/public/deathmatch/red
	name = "Public Arena VR Mission Red Team"

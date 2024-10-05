//Defines for atom layers and planes
//KEEP THESE IN A NICE ACSCENDING ORDER, PLEASE

#define CLICKCATCHER_PLANE -99

#define PLANE_SPACE -95
#define PLANE_SPACE_PARALLAX -90

#define OPENSPACE_PLANE -25 //Openspace plane below all turfs
#define OPENSPACE_LAYER 17 //Openspace layer over all
#define OPENSPACE_BACKDROP_PLANE -24 //Black square just over openspace plane to guaranteed cover all in openspace turf

#define FLOOR_PLANE -15

#define WALL_PLANE -14

#define ABOVE_WALL_PLANE -13

#define FIELD_OF_VISION_BLOCKER_PLANE -10
#define FIELD_OF_VISION_BLOCKER_RENDER_TARGET "*FIELD_OF_VISION_BLOCKER_PLANE"

#define FIELD_OF_VISION_PLANE -9
#define FIELD_OF_VISION_RENDER_TARGET "*FIELD_OF_VISION_PLANE"
#define FIELD_OF_VISION_LAYER 17 //used to place the visual (not the mask) shadow cone above any other floor plane stuff.

#define GAME_PLANE -5
#define OBJITEM_PLANE -4 // Used for obj/items rendering.
#define MOB_PLANE -3 // Used for mobs rendering.
#define FIELD_OF_VISION_VISUAL_PLANE -2 //Yea, FoV does require quite a few planes to work with 513 filters to a decent degree.

#define CHAT_LAYER 12.1 //Legacy, it doesn't matter that much because we are displayed above the game plane anyway.

#define BLACKNESS_PLANE 0 //To keep from conflicts with SEE_BLACKNESS internals

#define CHAT_PLANE 2 //We don't want heard messages to be hidden by FoV.

#define SPACE_LAYER 1.8
//#define TURF_LAYER 2 //For easy recordkeeping; this is a byond define
#define MID_TURF_LAYER 2.02
#define HIGH_TURF_LAYER 2.03
#define TURF_PLATING_DECAL_LAYER 2.031
#define TURF_DECAL_LAYER 2.039 //Makes turf decals appear in DM how they will look inworld.
#define ABOVE_OPEN_TURF_LAYER 2.04
#define CLOSED_TURF_LAYER 2.05
#define BULLET_HOLE_LAYER 2.06
#define ABOVE_NORMAL_TURF_LAYER 2.08
#define LATTICE_LAYER 2.2
#define DISPOSAL_PIPE_LAYER 2.3
#define GAS_PIPE_HIDDEN_LAYER 2.35
#define WIRE_LAYER 2.4
#define WIRE_TERMINAL_LAYER 2.45
#define GAS_SCRUBBER_LAYER 2.46
#define GAS_PIPE_VISIBLE_LAYER 2.47
#define GAS_FILTER_LAYER 2.48
#define GAS_PUMP_LAYER 2.49

#define LOW_OBJ_LAYER 2.5
#define LOW_SIGIL_LAYER 2.52
#define SIGIL_LAYER 2.54
#define HIGH_SIGIL_LAYER 2.56
///Layers most often used by atoms of plane equal or higher than GAME_PLANE
#define BELOW_OPEN_DOOR_LAYER 2.6
#define BLASTDOOR_LAYER 2.65
#define OPEN_DOOR_LAYER 2.7
#define DOOR_HELPER_LAYER 2.71 //keep this above OPEN_DOOR_LAYER
#define PROJECTILE_HIT_THRESHHOLD_LAYER 2.75 //projectiles won't hit objects at or below this layer if possible
#define TABLE_LAYER 2.8
#define TRAY_LAYER 2.85
#define BELOW_OBJ_LAYER 2.9
#define LOW_ITEM_LAYER 2.95
//#define OBJ_LAYER 3 //For easy recordkeeping; this is a byond define
#define CLOSED_BLASTDOOR_LAYER 3.05
#define CLOSED_DOOR_LAYER 3.1
#define CLOSED_FIREDOOR_LAYER 3.11
#define SHUTTER_LAYER 3.12 // HERE BE DRAGONS
#define ABOVE_OBJ_LAYER 3.2
#define ABOVE_WINDOW_LAYER 3.3
#define SIGN_LAYER 3.4
#define NOT_HIGH_OBJ_LAYER 3.5
#define HIGH_OBJ_LAYER 3.6

#define BELOW_MOB_LAYER 3.7
#define LYING_MOB_LAYER 3.8
#define MOB_LOWER_LAYER 3.95
//#define MOB_LAYER 4 //For easy recordkeeping; this is a byond define
#define MOB_UPPER_LAYER 4.05
#define ABOVE_MOB_LAYER 4.1
#define WALL_OBJ_LAYER 4.25
#define EDGED_TURF_LAYER 4.3
#define ON_EDGED_TURF_LAYER 4.35
#define LARGE_MOB_LAYER 4.4
#define ABOVE_ALL_MOB_LAYER 4.5

#define SPACEVINE_LAYER 4.8
#define SPACEVINE_MOB_LAYER 4.9
//#define FLY_LAYER 5 //For easy recordkeeping; this is a byond define
#define ABOVE_FLY_LAYER 5.1
#define GASFIRE_LAYER 5.2
#define RIPPLE_LAYER 5.3

#define GHOST_LAYER 6
#define LOW_LANDMARK_LAYER 9
#define MID_LANDMARK_LAYER 9.1
#define HIGH_LANDMARK_LAYER 9.2
#define AREA_LAYER 10
#define MASSIVE_OBJ_LAYER 11
#define POINT_LAYER 12

#define EMISSIVE_BLOCKER_PLANE 12
#define EMISSIVE_BLOCKER_LAYER 12
#define EMISSIVE_BLOCKER_RENDER_TARGET "*EMISSIVE_BLOCKER_PLANE"

#define EMISSIVE_PLANE 13
#define EMISSIVE_LAYER 13
#define EMISSIVE_RENDER_TARGET "*EMISSIVE_PLANE"

#define EMISSIVE_UNBLOCKABLE_PLANE 14
#define EMISSIVE_UNBLOCKABLE_LAYER 14
#define EMISSIVE_UNBLOCKABLE_RENDER_TARGET "*EMISSIVE_UNBLOCKABLE_PLANE"


//---------- LIGHTING -------------

///Normal 1 per turf dynamic lighting objects
#define LIGHTING_PLANE 100
#define RUNECHAT_PLANE (LIGHTING_PLANE + 1) // GOSH DARN IT LIGHTING, STOP EATING MY CHAT THINGS!

#define RAD_TEXT_LAYER 15.1

///Lighting objects that are "free floating"
#define SUNLIGHT_LAYER 10
#define O_LIGHTING_LAYER 20
#define O_LIGHTING_VISUAL_PLANE 110
#define O_LIGHTING_VISUAL_RENDER_TARGET "O_LIGHT_VISUAL_PLANE"

///Things that should render ignoring lighting
#define ABOVE_LIGHTING_PLANE 120
#define ABOVE_LIGHTING_LAYER 16

///visibility + hiding of things outside of light source range
#define BYOND_LIGHTING_PLANE 130
#define BYOND_LIGHTING_LAYER 18


///---------------- MISC -----------------------

///AI Camera Static
#define CAMERA_STATIC_PLANE 200
#define CAMERA_STATIC_LAYER 19

/// Plane for balloon text (text that fades up)
#define BALLOON_CHAT_PLANE 251

///--------------- FULLSCREEN IMAGES ------------

#define FULLSCREEN_PLANE 500
#define FLASH_LAYER 20
#define FULLSCREEN_LAYER 20.1
#define UI_DAMAGE_LAYER 20.2
#define BLIND_LAYER 20.3
#define CRIT_LAYER 20.4
#define CURSE_LAYER 20.5


//-------------------- HUD ---------------------

//HUD layer defines
#define HUD_PLANE 1000
#define HUD_LAYER 21


#define VOLUMETRIC_STORAGE_BOX_PLANE 1200
#define VOLUMETRIC_STORAGE_BOX_LAYER 22

#define VOLUMETRIC_STORAGE_ITEM_PLANE 1201
#define VOLUMETRIC_STORAGE_ITEM_LAYER 23
#define VOLUMETRIC_STORAGE_ACTIVE_ITEM_PLANE 1202
#define VOLUMETRIC_STORAGE_ACTIVE_ITEM_LAYER 25

#define ABOVE_HUD_PLANE 1300
#define ABOVE_HUD_LAYER 30

///Plane of the "splash" icon used that shows on the lobby screen. Nothing should ever be above this.
#define SPLASHSCREEN_PLANE 9999
#define SPLASHSCREEN_LAYER 90

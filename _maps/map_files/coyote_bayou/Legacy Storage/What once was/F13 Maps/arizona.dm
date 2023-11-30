#if !defined(MAP_FILE)

		#define TITLESCREEN "title" //Add an image in misc/fullscreen.dmi, and set this define to the icon_state, to set a custom titlescreen for your map

		#define MINETYPE "lavaland"

        #include "map_files\ArizonaWasteland\arizona_wasteland.dmm"

		#define MAP_PATH "map_files/ArizonaWasteland"
        #define MAP_FILE "arizona_wasteland.dmm"
        #define MAP_NAME "Arizona Wasteland"
        #define MAP_FACTIONS_LIST list("ncr", "legion", "none", "city", "raiders")

		#define MAP_TRANSITION_CONFIG DEFAULT_MAP_TRANSITION_CONFIG

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring wasteland debug.

#endif

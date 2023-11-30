#if !defined(MAP_FILE)

		#define TITLESCREEN "title" //Add an image in misc/fullscreen.dmi, and set this define to the icon_state, to set a custom titlescreen for your map

		#define MINETYPE "lavaland"

        #include "map_files\CaliforniaWasteland\california_wasteland.dmm"

		#define MAP_PATH "map_files/CaliforniaWasteland"
        #define MAP_FILE "california_wasteland.dmm"
        #define MAP_NAME "California Wasteland"
        #define MAP_FACTIONS_LIST list("NCR", "Legion", "Wasteland")

		#define MAP_TRANSITION_CONFIG DEFAULT_MAP_TRANSITION_CONFIG

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring wasteland debug.

#endif

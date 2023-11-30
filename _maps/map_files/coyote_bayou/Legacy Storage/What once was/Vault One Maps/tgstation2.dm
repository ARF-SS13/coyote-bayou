/*
The /tg/ codebase currently requires you to have 7 z-levels of the same size dimensions.
z-level order is important, the order you put them in inside this file will determine what z level number they are assigned ingame.
Names of z-level do not matter, but order does greatly, for instances such as checking alive status of revheads on z1

current as of 2014/11/24
z1 = station
z2 = centcomm
z3 = derelict telecomms satellite
z4 = derelict station
z5 = mining
z6 = empty space
z7 = empty space
*/

#if !defined(MAP_FILE)

        #include "map_files\wasteland\wasteland.1.1.1.dmm"
        #include "map_files\wasteland\inner_vault.dmm"
        //#include "map_files\wasteland\vault_underground.dmm"
       // #include "map_files\generic\z4.dmm"
        //#include "map_files\wasteland\underground.dmm"
        //#include "map_files\generic\z6.dmm"
       // #include "map_files\generic\z7.dmm"

        #define MAP_FILE "wasteland.1.1.1.dmm"
        #define MAP_NAME "Wasteland"

        #define MAP_TRANSITION_CONFIG	list(MAIN_STATION = SELFLOOPING, CENTCOMM = SELFLOOPING, ABANDONED_SATELLITE = CROSSLINKED, DERELICT = CROSSLINKED, MINING = CROSSLINKED, EMPTY_AREA_1 = CROSSLINKED, EMPTY_AREA_2 = CROSSLINKED)

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring /tg/station 2.

#endif
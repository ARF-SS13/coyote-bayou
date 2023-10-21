//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "_maps/map_files/coyote-bayou/Dungeons.dmm"
		#include "_maps/map_files/coyote-bayou/Texarkana_underground.dmm"
		#include "_maps/map_files/coyote-bayou/Nash_and_Texarkana.dmm"
		#include "_maps/map_files/coyote-bayou/Nash_and_Texarkana-Upper.dmm"
		#include "_maps/map_files/coyote-bayou/Nash_and_Texarkana-Upper-2.dmm"
		#include "_maps/map_files/coyote-bayou/Redwater.dmm"
		#include "_maps/map_files/coyote-bayou/Redwater-Upper.dmm"
		#include "_maps/map_files/coyote-bayou/Ashdown.dmm"
		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif

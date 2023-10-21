//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files/Pahrump-Sunset/Dungeons.dmm"
		#include "map_files/coyote-bayou/Texarkana_underground.dmm"
		#include "map_files/coyote-bayou/Nash_and_Texarkana.dmm"
		#include "map_files/coyote-bayou/Nash_and_Texarkana-Upper.dmm"
		#include "map_files/coyote-bayou/Nash_and_Texarkana-Upper-2.dmm"
		#include "map_files/coyote-bayou/Redwater.dmm"
		#include "map_files/coyote-bayou/Redwater-Upper.dmm"
		#include "map_files/coyote-bayou/Ashdown.dmm"
		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif

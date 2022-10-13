//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "_maps/map_files/Pahrump-Sunset/Dungeons.dmm"
		#include "_maps/map_files/Pahrump-Sunset/Pahrump-Sunset-Lower.dmm"
		#include "_maps/map_files/Pahrump-Sunset/Pahrump-Sunset.dmm"
		#include "_maps/map_files/Pahrump-Sunset/Pahrump-Sunset-Upper.dmm"
		#include "_maps/map_files/Pahrump-Sunset/Pahrump-Sunset-Upper-2.dmm"
		#include "_maps/map_files/Pahrump-Sunset/RockSprings.dmm"
		#include "_maps/map_files/Pahrump-Sunset/RedRiver.dmm"
		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif

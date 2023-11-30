//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Pahrump-Sunset\Dungeons.dmm"
		#include "map_files\Pahrump-Sunset\Pahrump-Sunset-Lower.dmm"
		#include "map_files\Pahrump-Sunset\Pahrump-Sunset.dmm"
		#include "map_files\Pahrump-Sunset\Pahrump-Sunset-Upper.dmm"
		#include "map_files\Pahrump-Sunset\Pahrump-Sunset-Upper-2.dmm"
		#include "map_files\Pahrump-Sunset\RockSprings.dmm"
		#include "map_files\Pahrump-Sunset\RockSprings-Upper.dmm"
		#include "map_files\Pahrump-Sunset\Warren.dmm"
		#include "map_files\Pahrump-Sunset\Warren-Upper.dmm"
		#include "map_files\Pahrump-Sunset\Mountain-Range.dmm"
		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif

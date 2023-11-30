//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"
//#include "map_files\Mining\Lavaland.dmm" //Temp removal

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Pahrump\Pahrump.dmm"

		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif

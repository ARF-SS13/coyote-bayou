#if !defined(USING_MAP_DATUM)

	#include "../../mods/content/mundane.dm"
	#include "../../mods/content/bigpharma/_bigpharma.dme"
	#include "../../mods/content/corporate/_corporate.dme"
	#include "../../mods/content/government/_government.dme"
	#include "../../mods/content/matchmaking/_matchmaking.dme"
	#include "../../mods/content/modern_earth/_modern_earth.dme"
	#include "../../mods/content/mouse_highlights/_mouse_highlight.dme"
	#include "../../mods/content/psionics/_psionics.dme"
	#include "../../mods/content/scaling_descriptors.dm"
	#include "../../mods/content/xenobiology/_xenobiology.dme"

	// All our F13 content in a modpack
	#include "../../mods/content/f13/_f13.dme"

	#include "../../mods/utility/tgsv4_integration/___tgs.dme"

	#include "../../mods/mobs/dionaea/_dionaea.dme"
	#include "../../mods/mobs/borers/_borers.dme"

	#include "jobs/bos.dm"
	#include "jobs/den.dm"
	#include "jobs/followers.dm"
	#include "jobs/khans.dm"
	#include "jobs/legion.dm"
	#include "jobs/ncr.dm"
	#include "jobs/oasis.dm"
	#include "jobs/wasteland.dm"

	#include "outfits/_pda.dm"
	#include "outfits/bos.dm"
	#include "outfits/den.dm"
	#include "outfits/followers.dm"
	#include "outfits/khans.dm"
	#include "outfits/legion.dm"
	#include "outfits/ncr.dm"
	#include "outfits/oasis.dm"
	#include "outfits/wasteland.dm"

	#include "yuma_announcements.dm"
	#include "yuma_areas.dm"
	#include "yuma_departments.dm"
	#include "yuma_jobs.dm"
	#include "yuma_shuttles.dm"
	#include "yuma_spawnpoints.dm"
	#include "yuma_unit_testing.dm"

	#include "yuma-0.dmm"
	#include "yuma-1.dmm"
	#include "yuma-admin.dmm"
	#include "yuma-transit.dmm"

	#define USING_MAP_DATUM /datum/map/yuma

#elif !defined(MAP_OVERRIDE)
	#warn A map has already been included, ignoring Yuma
#endif

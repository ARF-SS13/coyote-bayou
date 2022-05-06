//This literally just exists because I couldn't figure out another way to have a global var. My apologies to whoever is dealing with this spaghetti bullshit in the future.
//-Bootlegbow

//This has been deshittified. Thank you for your service.
//-Kitsunemitsu

SUBSYSTEM_DEF(maptype)
	name = "Map Type"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_MAPTYPE
	var/maptype = "debug"//for the love of god, do not change the default we will all die -Bootlegbow
	// This has been adapted for Fallout, now EVERY map has a maptype.

	var/clearjobs = FALSE	//this is checking if we are clearing jobs or not. Not currently in use, here for legacy's sake

	var/faction = "fallout"//shit like the starfury. -Bootlegbow
	//The faction tag is unused currently, but the map might break without it

	//All the map tags that delete all jobs and replace them with others.
	var/list/clearmaps = list("kepler-ice", "syndicate", "blacksite")

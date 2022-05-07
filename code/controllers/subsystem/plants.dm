SUBSYSTEM_DEF(plants)
	name = "Plants"
	init_order = INIT_ORDER_PLANTS
	flags = SS_KEEP_TIMING
	wait = 11 SECONDS // time it takes plants to update anyways

	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/plants/Initialize()
	return ..()

/datum/controller/subsystem/plants/stat_entry(msg)
	msg = "P:[length(processing)]| TP:[length(GLOB.plant_bins)]"
	return ..()

/datum/controller/subsystem/plants/fire(resumed = 0)
	if (!resumed)
		currentrun = processing.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun

	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--
		if(QDELETED(thing))
			processing -= thing
		else if(thing.process(wait) == PROCESS_KILL)
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, thing)
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/plants/Recover()
	if (istype(SSplants.processing))
		processing = SSplants.processing

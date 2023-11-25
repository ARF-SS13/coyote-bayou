SUBSYSTEM_DEF(pathfinder)
	name = "Pathfinder"
	init_order = INIT_ORDER_PATH
	wait = 1 // quick and dirty
	var/datum/flowcache/mobs
	var/datum/flowcache/circuits
	var/static/space_type_cache
	var/stat_tag = "P" //Used for logging
	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/pathfinder/stat_entry(msg)
	msg = "[stat_tag]:[length(processing)]"
	return ..()

/datum/controller/subsystem/pathfinder/fire(resumed = 0)
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

/datum/controller/subsystem/pathfinder/Initialize()
	space_type_cache = typecacheof(/turf/open/space)
	mobs = new(10)
	circuits = new(3)
	return ..()

/datum/flowcache
	var/lcount
	var/run
	var/free
	var/list/flow

/datum/flowcache/New(n)
	. = ..()
	lcount = n
	run = 0
	free = 1
	flow = new/list(lcount)

/datum/flowcache/proc/getfree(atom/M)
	if(run < lcount)
		run += 1
		while(flow[free])
			CHECK_TICK
			free = (free % lcount) + 1
		var/t = addtimer(CALLBACK(src, /datum/flowcache.proc/toolong, free), 150, TIMER_STOPPABLE)
		flow[free] = t
		flow[t] = M
		return free
	else
		return 0

/datum/flowcache/proc/toolong(l)
	log_game("Pathfinder route took longer than 150 ticks, src bot [flow[flow[l]]]")
	found(l)

/datum/flowcache/proc/found(l)
	deltimer(flow[l])
	flow[l] = null
	run -= 1

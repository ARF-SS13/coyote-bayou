SUBSYSTEM_DEF(idlenpcpool)
	name = "Idling NPC Pool"
	flags = SS_POST_FIRE_TIMING|SS_BACKGROUND|SS_NO_INIT
	priority = FIRE_PRIORITY_IDLE_NPC
	wait = 60
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()
	var/static/list/idle_mobs_by_zlevel[][]
	/// List of (weakrefs to) mobs that are queued for being stuffed into spawners
	var/list/mobs_to_cull = list()

/datum/controller/subsystem/idlenpcpool/stat_entry(msg)
	var/list/idlelist = GLOB.simple_animals[AI_IDLE]
	var/list/zlist = GLOB.simple_animals[AI_Z_OFF]
	msg = "IdleNPCS:[length(idlelist)]|Z:[length(zlist)]|C:[length(mobs_to_cull)]]"
	return ..()

/datum/controller/subsystem/idlenpcpool/proc/MaxZChanged()
	if (!islist(idle_mobs_by_zlevel))
		idle_mobs_by_zlevel = new /list(world.maxz,0)
	while (SSidlenpcpool.idle_mobs_by_zlevel.len < world.maxz)
		SSidlenpcpool.idle_mobs_by_zlevel.len++
		SSidlenpcpool.idle_mobs_by_zlevel[idle_mobs_by_zlevel.len] = list()

/datum/controller/subsystem/idlenpcpool/fire(resumed = FALSE)

	if (!resumed)
		var/list/idlelist = GLOB.simple_animals[AI_IDLE]
		src.currentrun = idlelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/simple_animal/SA = currentrun[currentrun.len]
		--currentrun.len
		if (QDELETED(SA))
			GLOB.simple_animals[AI_IDLE] -= SA
			stack_trace("Found a null in simple_animals deactive list [SA.type]!")
			continue

		if(!SA.ckey)
			if(SA.stat != DEAD)
				SA.consider_wakeup()
			if(SA.stat != DEAD)
				SA.handle_automated_movement()
		if (MC_TICK_CHECK)
			return

	if(!LAZYLEN(mobs_to_cull))
		return
	for(var/datum/weakref/weakie in mobs_to_cull)
		var/mob/living/simple_animal/hostile/simp = RESOLVEWEAKREF(weakie)
		if(simp)
			//message_admins("[simp] getting culled~")
			simp.unbirth_self()
		mobs_to_cull -= weakie
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/idlenpcpool/proc/add_to_culling(mob/living/simple_animal/hostile/simp)
	if(!simp)
		return
	mobs_to_cull |= WEAKREF(simp)

/datum/controller/subsystem/idlenpcpool/proc/remove_from_culling(mob/living/simple_animal/hostile/simp)
	if(!simp)
		return
	mobs_to_cull -= WEAKREF(simp)



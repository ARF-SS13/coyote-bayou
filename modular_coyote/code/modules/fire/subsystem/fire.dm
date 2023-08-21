SUBSYSTEM_DEF(firehandler)
	name = "Fire Handler"
	flags = SS_POST_FIRE_TIMING|SS_BACKGROUND|SS_NO_INIT
	priority = FIRE_PRIORITY_FIRE
	wait = 5
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()
	var/list/m_activeFires = list()

/datum/controller/subsystem/firehandler/stat_entry(msg)
	msg = "Active Fires:[length(m_activeFires)]"
	return ..()

/datum/controller/subsystem/firehandler/fire(resumed = FALSE)
	if (!resumed)
		src.currentrun = m_activeFires.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/obj/effect/fire/F = currentrun[currentrun.len]
		--currentrun.len
		if (QDELETED(F))
			m_activeFires -= F
			stack_trace("Found a null in active fire list!")
			continue

		if(F.litaf)
			F.HandleFire()
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/firehandler/AddFire(/obj/effect/fire/F)
	m_activeFires += F
	return

/datum/controller/subsystem/firehandler/RemoveFire(/obj/effect/fire/F)
	m_activeFires -= F
	return

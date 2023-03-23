SUBSYSTEM_DEF(callbacks)
	name = "Auxtools Callbacks"
	flags = SS_TICKER | SS_NO_INIT | SS_NO_FIRE
	wait = 1
	priority = FIRE_PRIORITY_CALLBACKS
	can_fire = 0 // Disabled for now as this is only used for ticking auxmos.

/proc/process_atmos_callbacks()
	SScallbacks.can_fire = 0
	SScallbacks.flags |= SS_NO_FIRE
	CRASH("Auxtools not found! Callback subsystem shutting itself off.")

/datum/controller/subsystem/callbacks/fire()

	if(process_atmos_callbacks(TICK_REMAINING_MS))

		pause()

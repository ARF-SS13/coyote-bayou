SUBSYSTEM_DEF(rts)
	name = "RTS"
	wait = 15 MINUTES
	init_order = INIT_ORDER_ECONOMY
	runlevels = RUNLEVEL_GAME
	flags = SS_NO_INIT
	/// list of all quest keys (its convenient lol) and their RTS datums
	var/list/commanders = list()
	var/debug_criteria = TRUE

/datum/controller/subsystem/rts/proc/GetCommander(mob/cmdr)
	if(!cmdr)
		return
	var/datum/preferences/P = extract_prefs(cmdr)
	if(!P)
		return
	var/datum/rts_commander/rts_dat = LAZYACCESS(commanders, P.quester_uid)
	if(!rts_dat)
		rts_dat = new /datum/rts_commander(cmdr)
		commanders[P.quester_uid] = rts_dat
	return rts_dat

/datum/controller/subsystem/rts/proc/ToggleCommander(mob/cmdr)
	var/datum/rts_commander/rts_dat = GetCommander(cmdr)
	if(rts_dat)
		if(rts_dat.intercepting)
			rts_dat.DeactivateInputInterceptor()
			return FALSE
		else
			rts_dat.ActivateInputInterceptor(cmdr)
			return TRUE

/datum/controller/subsystem/rts/proc/ActivateInputInterceptor(mob/user)
	var/datum/rts_commander/rts_dat = GetCommander(user)
	if(rts_dat)
		return rts_dat.ActivateInputInterceptor(user)

/datum/controller/subsystem/rts/proc/DeactivateInputInterceptor(mob/user)
	var/datum/rts_commander/rts_dat = GetCommander(user)
	if(rts_dat)
		return rts_dat.DeactivateInputInterceptor()


SUBSYSTEM_DEF(rts)
	name = "RTS"
	wait = 1 SECONDS
	init_order = INIT_ORDER_ECONOMY
	runlevels = RUNLEVEL_GAME
	flags = SS_NO_INIT
	/// list of all quest keys (its convenient lol) and their RTS datums
	var/list/commanders = list()
	var/aggro_lockout_time = 1 SECONDS
	var/debug_criteria = FALSE
	var/max_move_frustration = 10 SECONDS
	var/okay_to_command = list()

/datum/controller/subsystem/rts/Initialize(start_timeofday)
	LoadCommanderWhitelist()
	. = ..()
	to_chat(world, span_alert("[LAZYLEN(okay_to_command)] commanders on the payroll!"))

/datum/controller/subsystem/rts/fire(resumed)
	for(var/kay in okay_to_command)
		UpdateButtons(kay)
	return

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
	if(!CanHasCommander(cmdr))
		to_chat(cmdr, span_alert("You're not able to exert your will over the battlefield!"))
		return
	var/datum/rts_commander/rts_dat = GetCommander(cmdr)
	var/client/C = rts_dat.GetCommanderClient()
	if(rts_dat)
		if(C.click_intercept == rts_dat)
			rts_dat.DeactivateInputInterceptor()
			. = FALSE
		else
			rts_dat.ActivateInputInterceptor(cmdr)
			. = TRUE
	UpdateButtons(cmdr)


/datum/controller/subsystem/rts/proc/ActivateInputInterceptor(mob/user)
	var/datum/rts_commander/rts_dat = GetCommander(user)
	if(rts_dat)
		return rts_dat.ActivateInputInterceptor(user)

/datum/controller/subsystem/rts/proc/DeactivateInputInterceptor(mob/user)
	var/datum/rts_commander/rts_dat = GetCommander(user)
	if(rts_dat)
		return rts_dat.DeactivateInputInterceptor()

/datum/controller/subsystem/rts/proc/CanHasCommander(mob/user)
	if(check_rights_for(user, R_ADMIN))
		GetCommander(user)
		return TRUE
	if(!isobserver(user))
		to_chat(user, span_alert("You need to be a g-g-g-ghost to be a commander!"))
		return FALSE
	if(!LAZYLEN(okay_to_command))
		LoadCommanderWhitelist()
	if(LAZYACCESS(okay_to_command, extract_ckey(user)))
		GetCommander(user)
		return TRUE

/datum/controller/subsystem/rts/proc/LoadCommanderWhitelist()
	var/list/whitelist = list()
	whitelist = safe_json_decode(file2text("config/rts_commander_whitelist.json"))
	if(LAZYLEN(whitelist))
		for(var/line in whitelist)
			okay_to_command[line] = TRUE

/datum/controller/subsystem/rts/proc/GiveCommanderVerb(someome)
	var/mob/user = extract_mob(someome)
	if(!isobserver(user) && !check_rights_for(user, R_ADMIN))
		// to_chat(user, span_alert("You need to be a g-g-g-ghost to be a commander!"))
		return
	add_verb(someome, /client/proc/show_verbs)
	return TRUE

/datum/controller/subsystem/rts/proc/UpdateButtons(someone)
	var/mob/user = extract_mob(someone)
	var/datum/rts_commander/rts_dat = GetCommander(user)
	rts_dat.UpdateButtons()

/proc/commander_me()
	set name = "Commander Me"
	set category = "RTS"

	if(SSrts.ToggleCommander(usr))
		to_chat(usr, "You are now a commander.")
	else
		to_chat(usr, "You are no longer a commander.")




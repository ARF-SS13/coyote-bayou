SUBSYSTEM_DEF(rts)
	name = "RTS"
	wait = 1 SECONDS
	init_order = INIT_ORDER_ECONOMY
	runlevels = RUNLEVEL_GAME
	flags = SS_NO_INIT
	/// list of all quest keys (its convenient lol) and their RTS datums
	var/list/commanders = list()
	var/aggro_lockout_time = 1 SECONDS
	var/max_select = 25
	var/debug_criteria = FALSE
	var/max_move_frustration = 10 SECONDS
	var/okay_to_command = list()
	var/okay_to_command4now = list()

/datum/controller/subsystem/rts/Initialize(start_timeofday)
	LoadCommanderWhitelist()
	. = ..()
	to_chat(world, span_alert("[LAZYLEN(okay_to_command)] commanders on the payroll!"))

/datum/controller/subsystem/rts/fire(resumed)
	for(var/kay in (okay_to_command | okay_to_command4now | GLOB.admins))
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
		UpdateButtons(cmdr)
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
	if(LAZYACCESS(okay_to_command, extract_ckey(user)) || LAZYACCESS(okay_to_command4now, extract_ckey(user)))
		GetCommander(user)
		return TRUE

/datum/controller/subsystem/rts/proc/LoadCommanderWhitelist()
	var/list/whitelist = list()
	whitelist = safe_json_decode(file2text("data/rts_commander_whitelist.json"))
	if(LAZYLEN(whitelist))
		for(var/line in whitelist)
			okay_to_command[line] = TRUE

/datum/controller/subsystem/rts/proc/UpdateWhitelist()
	var/list/tosave = list()
	for(var/cky in okay_to_command)
		tosave += cky
	var/saveson = safe_json_encode(tosave)
	text2file(saveson, "data/rts_commander_whitelist.json")
	message_admins("RTS commander whitelist updated! =3")

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

/datum/controller/subsystem/rts/proc/EditCommanders(someone)
	var/mob/user = extract_mob(someone)
	if(!check_rights_for(user, R_ADMIN))
		to_chat(user, span_alert("Hey! You gotta be an admin to do that!"))
		return
	var/list/cool_list = list()
	cool_list["> ADD A COMMANDER =3 <"] = "123eat"
	for(var/cky in okay_to_command)
		cool_list["[cky]"] = cky
	for(var/cky in okay_to_command4now)
		if(LAZYACCESS(cool_list, cky))
			continue // already in the list
		cool_list["[cky] (TEMP)"] = cky
	var/who2what = input(
		user,
		"Edit who can be a commander, either permanently or temporarily!",
		"GeckoHerder PRO v0.2β",
		"> ADD A COMMANDER =3 <",
	) as null|anything in cool_list
	if(!who2what)
		to_chat(user, span_alert("Okay nevermind!!"))
		return
	if(!LAZYACCESS(cool_list, who2what))
		to_chat(user, span_alert("That's not someone at all!"))
		return
	var/answer = LAZYACCESS(cool_list, who2what)
	var/superAnswer
	if(answer == "123eat")
		// add a commander
		var/typeorpick = alert(
			user,
			"Type in the ckey, or pick from a list of online players?",
			"GeckoHerder PRO v0.2β",
			"TYPE it in!",
			"PICK from the list!",
			"Cancel :c",
		)
		if(!typeorpick || typeorpick == "Cancel :c")
			to_chat(user, span_alert("Okay nevermind!!"))
			return
		if(typeorpick == "TYPE it in!")
			var/ck = input(
				user,
				"Type in the ckey of the person you want to add as a commander!",
				"GeckoHerder PRO v0.2β",
				"ckey",
			) as text|null
			if(!ck)
				to_chat(user, span_alert("Okay nevermind!!"))
				return
			superAnswer = ck
		else if (typeorpick == "PICK from the list!")
			var/list/online = list()
			for(var/client/C in GLOB.clients)
				online += C.ckey
			var/cke = input(
				user,
				"Pick from the list of online players!",
				"GeckoHerder PRO v0.2β",
				"ckey",
			) as null|anything in online
			if(!cke || !(cke in online))
				to_chat(user, span_alert("Okay nevermind!!"))
				return
			superAnswer = cke
		if(!superAnswer)
			to_chat(user, span_alert("Okay nevermind!!"))
			return
		var/temporperm = alert(
			user,
			"Should this be temporary (for this round) or should they be able to commander in any round forever and ever?",
			"GeckoHerder PRO v0.2β",
			"Just This Round",
			"FOREVER!",
			"Cancel :c",
		)
		if(!temporperm || temporperm == "Cancel :c")
			to_chat(user, span_alert("Okay nevermind!!"))
			return
		if(temporperm == "Just This Round")
			okay_to_command4now[superAnswer] = TRUE
		else if(temporperm == "FOREVER!")
			okay_to_command[superAnswer] = TRUE
		UpdateWhitelist()
		UpdateButtons(superAnswer)
		to_chat(user, span_green("Commander added!"))
		if(temporperm == "Just This Round")
			message_admins("[ADMIN_TPMONTY(user)] added [superAnswer] as a temporary commander! =3")
			log_admin("[user.ckey] added [superAnswer] as a temporary commander! =3")
		else
			message_admins("[ADMIN_TPMONTY(user)] added [superAnswer] as a commander forever and ever! =3")
			log_admin("[user.ckey] added [superAnswer] as a commander forever and ever! =3")
		var/mob/they = extract_mob(superAnswer)
		if(they)
			to_chat(they, span_greentext("You're now allowed to be an RTS commander! :D"))
			to_chat(they, span_green("To do so, become a ghost, then either click the RTS button in the top left, click on 'commander me' in the RTS tab, or type 'commander me' in the command bar thing!"))
		return
	/// remove a commander
	var/teORpe = LAZYACCESS(okay_to_command, answer) ? "perm" : LAZYACCESS(okay_to_command4now, answer) ? "temp" : "neither"
	if(teORpe == "neither")
		to_chat(user, span_alert("That person isn't a commander!"))
		return
	var/online_client = extract_client(answer)
	var/didit
	if(teORpe == "temp")
		var/rmvm = alert(
			user,
			"This player is only a commander for this round. Remove them?",
			"GeckoHerder PRO v0.2β",
			"Remove",
			"Cancel :c",
		)
		if(!rmvm || rmvm == "Cancel :c")
			to_chat(user, span_alert("Okay nevermind!!"))
			return
		didit = TRUE
		okay_to_command4now -= answer
	else if(teORpe == "perm")
		var/rmvm = alert(
			user,
			"This player is a permanent commander. Remove them?",
			"GeckoHerder PRO v0.2β",
			"Remove",
			"Cancel :c",
		)
		if(!rmvm || rmvm == "Cancel :c")
			to_chat(user, span_alert("Okay nevermind!!"))
			return
		didit = TRUE
		okay_to_command -= answer
	if(didit)
		if(online_client)
			to_chat(online_client, span_userdanger("You're no longer allowed to be an RTS commander! :c"))
		UpdateWhitelist()
		UpdateButtons(answer)
		message_admins("[ADMIN_TPMONTY(user)] removed [superAnswer] from being a commander! 3=")
		log_admin("[user.ckey] removed [superAnswer] from being a commander! 3=")
		to_chat(user, span_green("Commander removed!"))
	return

/proc/commander_me()
	set name = "Commander Me"
	set category = "RTS"

	if(SSrts.ToggleCommander(usr))
		to_chat(usr, "You are now a commander.")
	else
		to_chat(usr, "You are no longer a commander.")




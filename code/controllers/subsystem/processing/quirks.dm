//Used to process and handle roundstart quirks
// - Quirk strings are used for faster checking in code
// - Quirk datums are stored and hold different effects, as well as being a vector for applying trait string
PROCESSING_SUBSYSTEM_DEF(quirks)
	name = "Quirks"
	init_order = INIT_ORDER_QUIRKS
	flags = SS_BACKGROUND
	wait = 1 SECONDS
	runlevels = RUNLEVEL_GAME

	/// Format: list("quirkname1" = /datum/quirk/quirkname1, "quirkname2" = /datum/quirk/quirkname2, etc)
	var/list/quirks = list()
	var/list/quirk_names_by_path = list()
	var/list/quirk_points = list()	//Assoc. list of quirk names and their "point cost"; positive numbers are good traits, and negative ones are bad
	var/list/quirk_objects = list()	//A list of all quirk objects in the game, since some may process
	var/list/quirk_blacklist = list() //A list a list of quirks that can not be used with each other. Format: list(quirk1,quirk2),list(quirk3,quirk4)

	/// Format: list("category1" = list(QUIRK_NAME = name, QUIRK_VALUE = value, etc))
	var/list/cached_quirk_data = list() // A list of all quirks, sorted by category, for the tgui
	var/list/cached_all_quirks = list() // A list of all quirks, sorted by name, for the tgui -- no categories!
	var/top_quirk // The top quirk, for the tgui
	var/start_balance = 100 // Hey guess where this was

	/// Demographic shit
	/// How many people took each quirk
	/// Format: list("/datum/quirk/path" = list("Charname", "Charname2"), ...)
	var/list/quirks_used = list()

/datum/controller/subsystem/processing/quirks/Initialize(timeofday)
	if(LAZYLEN(quirks))
		stack_trace("Quirks subsystem initialized, but there were quirks here already! Did someone try to re-initialize the quirks subsystem? Dont lie, it's okay to admit it.")
		return
	SetupQuirks()
	// quirk_blacklist = list( // hey look, referencing the name (which can change and not runtime if it does) instead of the path (which is static and will let you know when its broken), what a great idea
	// 	list("Blind","Nearsighted"),
	// 	list("Mood - Sanguine","Mood - Optimist","Apathetic","Mood - Pessimist", "Mood - Depressive"),
	// 	list("Ageusia","Deviant Tastes"),
	// 	list("Ananas Affinity","Ananas Aversion"),
	// 	list("Alcohol Tolerance","Alcohol Intolerance"),
	// 	list("Alcohol Intolerance","Drunken Resilience"),
	// 	list("Nearsighted - Corrected","Nearsighted - No Glasses", "Nearsighted - Trashed Vision"),
	// 	list("Melee - Big Leagues", "Melee - Little Leagues", "Melee - Gentle", "Melee - Wimpy"),
	// 	list("Fists of Steel","Fists of Iron","Fists of Noodle"),
	// 	list("Health - Tough", "Health - Tougher", "Flimsy", "Very Flimsy"),
	// 	list("Mobility - Wasteland Trekker","Mobility - Wasteland Wanderer","Mobility - Wasteland Slug","Mobility - Wasteland Molasses"),
	// 	list("Cold Resistant", "Cold-Blooded"),
	// 	list("Radiation - Immune","Radiation - Mostly Immune","Radiation - Sorta Immune"),
	// 	list("Vegetarian","Does not Eat"),
	// 	list("Cannibal","Does not Eat"),
	// 	list("Deviant Tastes","Does not Eat"),
	// 	list("Vegetarian","Cannibal"),
	// 	list("Unintelligible Speech","Mute"),
	// 	list("Quicker Carry","Quick Carry"),
	// 	list("Master Martial Artist", "Fists of Noodle"),
	// 	list("Master Martial Artist", "Sure Strike"),
	// 	list("Heavy Sleeper","Can Not Sleep"),
	// 	list("Dead Eye", "Straight Shooter", "Poor Aim"),
	// 	list("Beast Friend - Rats", "Beast Master - Rats"),
	// 	list("Beast Friend - Small Critters", "Beast Master - Small Critters"),
	// 	list("Speed Walker", "Mobility - Wasteland Slug", "Mobility - Wasteland Molasses", "Phobia - The Dark"),
	// 	list("Pacifist", "Fists of Noodle"),
	// 	list("Pacifist", "Melee - Gentle"),
	// 	list("Pacifist", "Melee - Wimpy"),
	// 	list("Pacifist", "Poor Aim"),
	// 	list("Pacifist", "Fat-Fingered"),
	// 	list("Speed Walker", "Mobility - Can not Run"),
	// 	list("Zoomies", "Zoomies - Super"),
	// 	list("Wasteland Wizard", "Melee - Big Leagues"),
	// 	list("Wasteland Wizard", "Melee - Little Leagues"),
	// 	list("Wasteland Wizard", "Bolt Worker"),
	// 	list("Wasteland Wizard", "Bow Trained"),
	// 	list("Wasteland Wizard", "Dead Eye"),
	// 	list("Wasteland Wizard", "Straight Shooter"),
	// 	list("Wasteland Wizard", "Sure Strike"),
	// 	list("Wasteland Wizard", "Master Martial Artist"),
	// 	list("Wasteland Wizard", "Trained Grappler"),
	// 	list("Wasteland Wizard", "Fists of Iron"),
	// 	list("Wasteland Wizard", "Fists of Steel"),
	// 	list("Wasteland Wizard", "Mute"),
	// 	list("Fast Biter", "Big Biter", "Play Biter", "Spicy Biter", "Sabre Biter"),
	// 	list("Fast Clawer", "Big Clawer", "Play Clawer", "Spicy Clawer","Razor Clawer"),
	// ) // not // got em // fingerguns
	..()
	to_chat(world, span_boldannounce("Loaded [LAZYLEN(quirks)] quirks across [length(cached_quirk_data)] categories!"))

/datum/controller/subsystem/processing/quirks/proc/SetupQuirks()
	/// Will give us a list of all quirks, sorted by point value, then name
	/// Will solve a lot of sorting issues later, i swear
	var/list/quirk_list = sortList(subtypesof(/datum/quirk), /proc/cmp_quirk_asc)

	for(var/V in quirk_list)
		var/datum/quirk/T = new V() // They'll be fiiiiiine
		quirks[T.key] = T // the indexes are stringified type paths, so they'll ALWAYS BE UNIQUE =D
		// quirk_points[initial(T.name)] = initial(T.value)
		// quirk_names_by_path[T] = initial(T.name)
	/// Now, lets pre-make the tgui data tree thing, for hyperspeed caching
	FormatifyQuirks()

/datum/controller/subsystem/processing/quirks/proc/FormatifyQuirks()
	/// Associated list of all quirk categories, pulled from all our stuff
	var/list/all_categories = list()
	for(var/cq in quirks)
		var/datum/quirk/Q = quirks[cq]
		all_categories[Q.category] = list()
	/// Now, lets sort all our quirks into their categories
	var/list/everything = list()
	for(var/datum/quirk/Q2 in quirks)
		all_categories[Q2.category][Q2.key] = list()
		var/list/this_quirk = list()
		this_quirk[QUIRK_KEY] = "[Q2.key]"
		this_quirk[QUIRK_NAME] = "[Q2.name]"
		this_quirk[QUIRK_PATH] = "[Q2.type]" // for mutual exclusion purposes
		this_quirk[QUIRK_VALUE] = Q2.value
		this_quirk[QUIRK_DESC] = "[Q2.desc]"
		this_quirk[QUIRK_MECHANICS] = "[Q2.mechanics]"
		this_quirk[QUIRK_CONFLICTS] = Q2.get_conflicts()
		this_quirk[QUIRK_CATEGORY] = "[Q2.category]"
		all_categories[Q2.category][Q2.key] = this_quirk
		all_categories["All Quirks"][Q2.key] = this_quirk
		everything[Q2.key] = this_quirk
	cached_quirk_data = all_categories
	cached_all_quirks = everything

/datum/controller/subsystem/processing/quirks/ui_static_data(mob/user)
	var/list/data = list()
	data["QuirkData"] = cached_quirk_data
	data["AllQuirks"] = cached_all_quirks
	return data

/// Pulls all of the user's quirks, and formats them for the tgui
/datum/controller/subsystem/processing/quirks/ui_data(mob/user)
	var/list/data = list()
	data["UserQuirks"] = tguiify_quirk_list(user)
	data["UserCkey"] = user.ckey
	return data

/datum/controller/subsystem/processing/quirks/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("AddQuirk")
			var/c_key = params["Ckey"]
			var/q_key = params["Quirk"]
			VerifyAndAddQuirkToPlayerPrefs(c_key, params)
		
			var/mob/M = ckey2mob(c_key)
			var/client/C = GLOB.directory[c_key]
			var/datum/preferences/P = extract_prefs(ckdy)
			if(!P)
				return
			var/datum/quirk/Q = GetQuirk(params["Quirk"])
			if(!Q)
				return
			AddQuirkToPrefs(P, Q)
			P.save_character()
			AssignQuirks(M, C, TRUE, FALSE, FALSE, FALSE, M)
			return


/// returns a list of ckey'd quirk names
/datum/controller/subsystem/processing/quirks/proc/tguiify_quirk_list(mob/user)
	var/list/out = list()
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return list("Time2Runtime")
	for(var/qpath in P.all_quirks) // list of type paths
		var/datum/quirk/Q = qpath
		out |= "[ckey(Q.name)]"

/// returns a list of type paths as strings of all the user's quirks
/datum/controller/subsystem/processing/quirks/proc/get_pref_quirks(someone)
	var/datum/preferences/P = extract_prefs(someone)
	if(!P)
		return list()
	return P.all_quirks

/// Returns a quirk, if it exists
/datum/controller/subsystem/processing/quirks/proc/GetQuirk(a_quirk)
	if(!a_quirk)
		return
	if(istext(a_quirk))
		return LAZYACCESS(quirks, a_quirk)
	else if (ispath(a_quirk, /datum/quirk))
		return LAZYACCESS(quirks, "[a_quirk]")

/datum/controller/subsystem/processing/quirks/proc/AddQuirkToPrefs(datum/preferences/P, datum/quirk/Q)
	if(!P || !istype(Q))
		return // mind your P's and Q's
	if(Q.key in quirks) // if it's a valid quirk
		P.all_quirks |= Q.key

/datum/controller/subsystem/processing/quirks/proc/RemoveQuirkFromPrefs(datum/preferences/P, datum/quirk/Q)
	if(!P || !istype(Q))
		return // mind your P's and Q's
	P.all_quirks -= Q.key

/datum/controller/subsystem/processing/quirks/proc/AssignQuirks(mob/living/user, client/cli, spawn_effects, roundstart = FALSE, datum/job/job, silent = FALSE, mob/to_chat_target)
	if(!user || !cli)
		CRASH("AssignQuirks called with no user or client! wack")
	var/badquirk = FALSE
	var/datum/preferences/P = extract_prefs(cli)
	var/list/my_quirks = P.all_quirks
	var/list/cut
	if(job?.blacklisted_quirks)
		cut = filter_quirks(my_quirks, job.blacklisted_quirks)
	for(var/V in my_quirks)
		if(V in quirks)
			var/datum/quirk/Q = quirks[V]
			user.add_quirk(Q, spawn_effects)
		else
			log_admin("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			stack_trace("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			RemoveQuirkFromPrefs(P, V)
			badquirk = TRUE
	if(badquirk)
		P.save_character()
	if (!silent && LAZYLEN(cut))
		to_chat(to_chat_target || user, span_boldwarning("Some quirks have been cut from your character because of these quirks conflicting with your job assignment: [english_list(cut)]."))

/datum/controller/subsystem/processing/quirks/proc/quirk_points_by_name(name)
	return quirk_points[name]

/datum/controller/subsystem/processing/quirks/proc/quirk_name_by_path(path)
	return quirk_names_by_path[path]

/datum/controller/subsystem/processing/quirks/proc/total_points(list/quirk_names)
	. = 0
	for(var/i in quirk_names)
		. += quirk_points_by_name(i)

/datum/controller/subsystem/processing/quirks/proc/filter_quirks(list/our_quirks, list/blacklisted_quirks)
	var/list/cut = list()
	var/list/banned_names = list()
	var/pointscut = 0
	for(var/i in blacklisted_quirks)
		var/datum/quirk/Q = GetQuirk(i)
		if(istype(Q))
			banned_names += Q.key
	var/list/blacklisted = our_quirks & banned_names // both lists are string'd type paths
	if(length(blacklisted))
		for(var/i in blacklisted)
			our_quirks -= i
			cut += i
	return cut

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
	var/max_points = 100 // Hey guess where this was
	var/max_good_quirks = 6 // Hey guess where this was

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

/// Opens the quirk tgui for the user
/datum/controller/subsystem/processing/quirks/proc/OpenWindow(mob/user)
	return ui_interact(user)

/// Opens the quirk tgui for the user
/datum/controller/subsystem/processing/quirks/ui_interact(mob/user)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "QuirkMenu")
		ui.open()

/datum/controller/subsystem/processing/quirks/ui_state(mob/user)
	return GLOB.always_state

/datum/controller/subsystem/processing/quirks/ui_static_data(mob/user)
	var/list/data = list()
	data["QuirkData"] = cached_quirk_data
	data["AllQuirks"] = cached_all_quirks
	data["MaxQuirkPoints"] = max_points
	data["MaxGoodQuirks"] = max_good_quirks
	return data

/// Pulls all of the user's quirks, and formats them for the tgui
/datum/controller/subsystem/processing/quirks/ui_data(mob/user)
	var/list/data = list()
	var/list/quirks_points_and_goods = QuirkList2TGUI(user)
	data["UserQuirkNames"] = LAZYACCESS(quirks_and_goods, "UserQuirkNames")
	data["UserQuirkKeys"] = LAZYACCESS(quirks_and_goods, "UserQuirkKeys")
	data["UserQuirkPoints"] = LAZYACCESS(quirks_and_goods, "UserQuirkPoints")
	data["UserQuirkGoods"] = LAZYACCESS(quirks_and_goods, "UserQuirkGoods")
	// data["UserQuirkProstheticPoints"] = LAZYACCESS(quirks_and_goods, "UserQuirkProstheticPoints")
	data["UserCkey"] = user.ckey
	data["UserName"] = user.real_name
	return data

/datum/controller/subsystem/processing/quirks/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/c_key = params["Ckey"]
	var/q_key = params["Quirk"]
	switch(action)
		if("AddQuirk")
			VerifyAndAddQuirkToPlayerPrefs(c_key, q_key)
		if("RemoveQuirk")
			RemoveQuirkFromPrefs(extract_prefs(c_key), q_key)

	if(GetQuirkBalance() < 0)
		reset_quirks("balance")
	if(GetPositiveQuirkCount() > MAX_QUIRKS)
		reset_quirks("max")

/// returns a list of ckey'd quirk names
/datum/controller/subsystem/processing/quirks/proc/QuirkList2TGUI(mob/user)
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return list("Time2Runtime", "Time2Runtime", "Time2Runtime")
	var/list/out = list()
	out["UserQuirkNames"] = list()
	out["UserQuirkKeys"] = list()
	out["UserQuirkPoints"] = GetQuirkBalance(P)
	out["UserQuirkGoods"] = GetPositiveQuirkCount(P)
	for(var/qpath in P.all_quirks) // list of type paths
		var/datum/quirk/Q = qpath
		out["QuirkListKeys"] |= "[Q.key]"
		out["QuirkListNames"] |= "[Q.name]"
		if(Q.value > 0)
			out["QuirkGoods"]++
		out["QuirkPoints"] += Q.value
	// for(var/modification in P.modified_limbs)
	// 	if(P.modified_limbs[modification][1] == LOADOUT_LIMB_PROSTHETIC)
	// 		return bal + 33 //max 33 point regardless of how many prosthetics
	return out

/// Returns the player's quirk balance
/datum/controller/subsystem/processing/quirks/proc/GetQuirkBalance(datum/preferences/P)
	if(!P)
		return 0
	var/balance = 0
	for(var/qstring in P.all_quirks)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			stack_trace("GetQuirkBalance: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		balance += Q.value
	return balance

/// Returns the player's number of good quirks
/datum/controller/subsystem/processing/quirks/proc/GetPositiveQuirkCount(datum/preferences/P)
	if(!P)
		return 0
	var/num_good_quirks = 0
	for(var/qstring in P.all_quirks)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			stack_trace("GetPositiveQuirkCount: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		if(Q.value > 0)
			num_good_quirks++
	return num_good_quirks

/// returns a list quirks
/datum/controller/subsystem/processing/quirks/proc/GetPrefQuirks(someone)
	var/datum/preferences/P = extract_prefs(someone)
	if(!P)
		return list()
	var/list/quirkies = list()
	for(var/qstring in P.all_quirks)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			stack_trace("GetPrefQuirks: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		quirkies += Q
	return quirkies

/// Returns a quirk, if it exists
/datum/controller/subsystem/processing/quirks/proc/GetQuirk(a_quirk)
	if(!a_quirk)
		return
	if(istext(a_quirk))
		return LAZYACCESS(quirks, a_quirk)
	else if (ispath(a_quirk, /datum/quirk))
		return LAZYACCESS(quirks, "[a_quirk]")
		CRASH("GetQuirk: Quirk [a_quirk] is not a valid quirk!")

/datum/controller/subsystem/processing/quirks/proc/VerifyAndAddQuirkToPlayerPrefs(c_key, q_key)
	if(!c_key || !!q_key)
		return
	var/datum/preferences/P = extract_prefs(c_key)
	if(!P)
		return
	var/datum/quirk/Q = GetQuirk(q_key)
	if(!Q)
		return
	RemoveDeadQuirks(P)
	if(QuirkConflict(P, Q))
		return
	if(!CanAffordQuirk(P, Q))
		return
	if(!HasEnoughGoodQuirkSlotsForThis(P, Q))
		return
	AddQuirkToPrefs(P, Q)
	P.save_character()
	return // wheee...\
/// splat ............/

/// Returns TRUE if the player has enough good quirk slots for this quirk
/datum/controller/subsystem/processing/quirks/proc/HasEnoughGoodQuirkSlotsForThis(datum/preferences/P, datum/quirk/Q)
	if(!istype(P) || !istype(Q))
		return FALSE // mind your P's and Q's
	var/num_good_quirks = 0
	var/list/their_quirks = P.all_quirks
	for(var/qstring in their_quirks)
		var/datum/quirk/Q2 = GetQuirk(qstring)
		if(!Q2)
			stack_trace("HasEnoughGoodQuirkSlotsForThis: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		if(Q2.value > 0)
			num_good_quirks++
	if(num_good_quirks < max_good_quirks)
		return TRUE
	if(prob(0.1))
		to_chat(P.parent, span_warning("Sorry, [P.parent.ckey], I can't make you OP. Come back when you're a little... mmmmm... weaker!"))
	else
		to_chat(P.parent, span_warning("You can not have more than [max_good_quirks] good quirks! You have [num_good_quirks] good quirks already!"))

/datum/controller/subsystem/processing/quirks/proc/CanAffordQuirk(datum/preferences/P, datum/quirk/Q)
	if(!istype(P) || !istype(Q))
		return FALSE // mind your P's and Q's
	var/player_point_balance = 0
	var/list/their_quirks = P.all_quirks
	for(var/qstring in their_quirks)
		var/datum/quirk/Q2 = GetQuirk(qstring)
		if(!Q2)
			stack_trace("CanAffordQuirk: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		player_point_balance += Q2.value
	if(player_point_balance > max_points) // they somehow had more quirks their points should allow. Possible frickery afoot
		PruneQuirksUntilBalanced(P, player_point_balance)
	if(player_point_balance + Q.value <= max_points)
		return TRUE
	if(prob(0.1))
		to_chat(P.parent, span_warning("Sorry, [P.parent.ckey], I can't make you OP. Come back when you're a little... mmmmm... weaker!"))
	else
		to_chat(P.parent, span_warning("You can not afford [Q.name]! You have [player_point_balance] points, and [Q.value] would put you over the limit of [max_points]!"))

/// Removes quirks until the player's point balance is back in valid range
/datum/controller/subsystem/processing/quirks/proc/PruneQuirksUntilBalanced(datum/preferences/P, unbalanced)
	if(!P)
		return
	if(unbalanced <= max_points)
		CRASH("PruneQuirksUntilBalanced: Player [P.parent.ckey] has a valid point balance! Why are we pruning quirks? [unbalanced] <= [max_points]. dragon pussy")
	var/list/their_quirks = P.all_quirks
	var/list/to_prune = list()
	var/list/pruned = list()
	var/num_good_quirks
	for(var/qstring in their_quirks)
		var/datum/quirk/Q2 = GetQuirk(qstring)
		if(!Q2)
			stack_trace("PruneQuirksUntilBalanced: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		if(Q2.value <= 0) // we only want to remove bad quirks
			continue
		to_prune[Q2] = Q2.value
		num_good_quirks++
	// Now, lets sort the list by value, descending
	to_prune = sortList(to_prune, /proc/cmp_quirk_asc) // only got the asc, so just flip it
	to_prune = reverseList(to_prune)
	for(var/datum/quirk/Q3 in to_prune)
		RemoveQuirkFromPrefs(P, Q2)
		unbalanced -= Q2.value
		pruned += Q2
		num_good_quirks
		if(unbalanced <= max_points && num_good_quirks <= max_good_quirks)
			P.save_character()
			break
	if(LAZYLEN(pruned))
		to_chat(P.parent, span_warning("You somehow had more quirks than your point balance allowed! [english_list(pruned)] have been removed from your character!"))

/// Returns TRUE if the quirk conflicts with any of the player's quirks
/datum/controller/subsystem/processing/quirks/proc/QuirkConflict(datum/preferences/P, datum/quirk/Q)
	if(!istype(P) || !istype(Q))
		return TRUE // mind your P's and Q's -- yes im gonna keep doing this
	var/list/quirklist = P.all_quirks
	for(var/qstring in quirklist)
		var/datum/quirk/Q2 = GetQuirk(qstring)
		if(!Q2)
			stack_trace("QuirkConflict: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		if(Q2.type in Q.conflicts)
			to_chat(P.parent, span_warning("You can not have [Q.name] and [Q2.name] at the same time! They conflict!"))
			return TRUE

/// Removes any quirks from the player's prefs that no longer exist
/datum/controller/subsystem/processing/quirks/proc/RemoveDeadQuirks(datum/preferences/P)
	if(!istype(P))
		return // mind your P's and Q's
	var/had_some = FALSE
	var/list/quirklist = P.all_quirks
	for(var/qstring in quirklist)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			RemoveQuirkFromPrefs(P, qstring)
			had_some = TRUE
	if(had_some)
		P.save_character()
		to_chat(P.parent, span_warning("Some quirks have been removed from your character because they no longer exist! Be sure to check your quirks!"))


/// Reads all the quirks from the player's prefs, and verifies that they should have them all
/datum/controller/subsystem/processing/quirks/proc/VerifyQuirks(datum/preferences/P, from_prefs) // from_prefs is to prevent infinite loops, cus it can be called from the prefs save proc
	if(!P)
		return // mind your P's
	var/list/quirklist = P.all_quirks
	if(!LAZYLEN(quirklist))
		return TRUE // they have no quirks, so they're good
	RemoveDeadQuirks(P)
	var/balance = GetQuirkBalance(P)
	var/goods = GetPositiveQuirkCount(P)
	if(balance > max_points || goods > max_good_quirks)
		PruneQuirksUntilBalanced(P, balance)	
	var/list/bad_quirks = list()
	for(var/qstring in quirklist)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			bad_quirks += qstring
			continue
		if(QuirkConflict(P, Q))
			bad_quirks += qstring
			continue
	if(LAZYLEN(bad_quirks))
		for(var/qstring in bad_quirks)
			RemoveQuirkFromPrefs(P, qstring, from_prefs)
		to_chat(P.parent, span_warning("Some quirks have been removed from your character because they no longer exist! Be sure to check your quirks!"))
		. = FALSE
	if(!from_prefs)
		P.save_character()



/// Adds a quirk to the player's prefs
/datum/controller/subsystem/processing/quirks/proc/AddQuirkToPrefs(datum/preferences/P, datum/quirk/Q)
	if(!P || !istype(Q))
		return // mind your P's and Q's
	if(Q.key in quirks) // if it's a valid quirk
		P.all_quirks |= Q.key
	P.save_character()

/// Removes a quirk from the player's prefs
/datum/controller/subsystem/processing/quirks/proc/RemoveQuirkFromPrefs(datum/preferences/P, Qany)
	if(!P || !Qany)
		return // mind your P's and Q's
	var/key2remove
	if(istype(Qany, /datum/quirk))
		var/datum/quirk/Q = Qany
		key2remove = Q.key
	else
		key2remove = "[Qany]" // ensure its a string
	P.all_quirks -= Q.key
	P.save_character()

/// Adds a quirk to a mob
/datum/controller/subsystem/processing/quirks/proc/AddQuirk(mob/user, Qany, spawn_effects)
	if(!user || !Q)
		return
	var/datum/quirk/T = GetQuirk(Qany)
	if(!T)
		return
	new T(user, spawn_effects)
	return TRUE

/// Removes a quirk from a mob
/datum/controller/subsystem/processing/quirks/proc/RemoveQuirk(mob/user, Qany)
	if(!user || !Q)
		return
	var/datum/quirk/T = GetQuirk(Qany)
	if(!T)
		return
	var/datum/quirk/U = HasQuirk(user, Qany)
	if(!U)
		return
	qdel(U)
	return TRUE

/// Returns if the mob has this quirk
/datum/controller/subsystem/processing/quirks/proc/HasQuirk(mob/user, Qany)
	if(!user || !Q)
		return
	var/datum/quirk/T = GetQuirk(Qany)
	if(!T)
		return
	for(var/datum/quirk/Q in roundstart_quirks)
		if(Q.type == T.type)
			return Q

/datum/controller/subsystem/processing/quirks/proc/AssignQuirks(mob/living/user, client/cli, spawn_effects, roundstart = FALSE, datum/job/job)
	if(!user || !cli)
		return
	var/badquirk = FALSE
	var/datum/preferences/P = extract_prefs(cli)
	var/list/my_quirks = P.all_quirks
	if(job?.blacklisted_quirks)
		for(var/start in job.blacklisted_quirks)
			my_quirks -= "[start]"
	for(var/V in my_quirks)
		var/datum/quirk/Q = GetQuirk(V)
		if(Q)
			AddQuirkToMob(user, Q, spawn_effects)
		else
			log_admin("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			stack_trace("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			RemoveQuirkFromPrefs(Q, V)
			badquirk = TRUE
	if(badquirk)
		P.save_character()


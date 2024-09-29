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
	var/list/cached_all_categories = list() // A list of all categories, for the tgui
	var/list/cached_all_quirks = list() // A list of all quirks, sorted by name, for the tgui -- no categories!
	var/top_quirk // The top quirk, for the tgui
	var/max_points = 6000 // Hey guess where this was
	var/max_good_quirks = 6 // Hey guess where this was

	/// Demographic shit
	/// How many people took each quirk
	/// Format: list("ckey" = list(/datum/quirk_statistics), ...)
	var/list/quirks_used = list()
	var/saveshot_cd = 0
	var/saveshot_rate = 1 HOURS

	var/debug_categories = FALSE // makes up a bunch of categories for us
	var/debug_migration = FALSE // fucs with our savefile
	var/debug_conflicts = FALSE

	var/dp = FALSE
	var/dp_prob = 1
	var/dp_rate = 15 SECONDS
	COOLDOWN_DECLARE(dp_cd)

/datum/controller/subsystem/processing/quirks/Initialize(timeofday)
	SetupQuirks()
	return ..()

/datum/controller/subsystem/processing/quirks/proc/SetupQuirks()
	/// Will give us a list of all quirks, sorted by point value, then name
	/// Will solve a lot of sorting issues later, i swear
	var/list/quirk_list = sortList(subtypesof(/datum/quirk), GLOBAL_PROC_REF(cmp_quirk_asc))

	for(var/V in quirk_list)
		var/datum/quirk/T = new V(src) // They'll be fiiiiiine
		quirks[T.key] = T // the indexes are stringified type paths, so they'll ALWAYS BE UNIQUE =D
		if(debug_conflicts)
			var/list/conflictables = subtypesof(/datum/quirk) - V
			for(var/i in 1 to 100)
				var/conflict = pick(conflictables)
				conflictables -= conflict
				T.conflicts += conflict
	saneitze_conflicts()
	
	/// Now, lets pre-make the tgui data tree thing, for hyperspeed caching
	FormatifyQuirks()

/// Keeping conflicts working right is hard, so lets just saneitize them
/datum/controller/subsystem/processing/quirks/proc/saneitze_conflicts()
	for(var/q in quirks)
		var/datum/quirk/Q = quirks[q]
		/// first, make sure the quirk isnt conflicting with itself
		/// cus bad
		Q.conflicts -= Q.type
		/// Now, run through all my conflicts, and make sure they too conflict with me
		for(var/q2 in Q.conflicts)
			var/datum/quirk/Q2 = GetQuirk(q2)
			if(!Q2)
				stack_trace("saneitze_conflicts: Quirk [q2] on [Q.key] does not exist! cool")
				continue
			Q2.conflicts |= Q.type
	/// and thats how you make a mouse pillow

/datum/controller/subsystem/processing/quirks/proc/UpdateNewbs()
	for(var/mob/dead/new_player/noob in GLOB.player_list)
		noob.new_player_panel()

/datum/controller/subsystem/processing/quirks/proc/FormatifyQuirks()
	cached_all_categories = list()
	cached_all_quirks = list()
	/// list of all quirk categories, pulled from all our stuff
	var/list/all_categories = list()
	/// List of all quirks, packaged into helpful lil objects for tgui
	var/list/char_quirks = list()
	/// For debugging category stuff
	var/list/debug_cats = list(
		"Aldric", "Brimcon", "Cebuttris", "Delta", "Etheo", "FennyFuzlet", "Gob", "Hansolo", "Illuminated", "Jaggachi", "Kelprunner", "Lyro", "Merek", "Nayrin", "Olly", "Planetary", "Quill, Shadow", "Ranger, NCR", "Superlagg", "Thekuddlez", "Useroth", "Violent J", "Weredoggo", "xxpawnstarxx", "Yiff", "Zeronet_alpha"
	)
	var/debug_index = 1
	for(var/qkey in quirks)
		var/datum/quirk/Q2 = GetQuirk(qkey)
		var/list/this_quirk = list()
		this_quirk[QUIRK_KEY] = "[Q2.key]"
		this_quirk[QUIRK_NAME] = "[Q2.name]"
		this_quirk[QUIRK_VALUE] = Q2.value
		this_quirk[QUIRK_DESC] = "[Q2.desc]"
		this_quirk[QUIRK_MECHANICS] = "[Q2.mechanics]"
		this_quirk[QUIRK_CONFLICTS] = Q2.get_conflicts()
		this_quirk[QUIRK_HUMANONLY] = "[Q2.human_only ? "👨 " : "👨🐺 "]"
		if(debug_categories)
			this_quirk[QUIRK_CATEGORY] = "[LAZYACCESS(debug_cats, debug_index)]"
			all_categories |= "[LAZYACCESS(debug_cats, debug_index)]"
			debug_index = WRAP(debug_index + 1, 1, length(debug_cats))
		else
			this_quirk[QUIRK_CATEGORY] = "[Q2.category]"
			all_categories |= "[Q2.category]"
		char_quirks += list(this_quirk)
	cached_all_categories = sort_list(all_categories)
	cached_all_categories.Insert(1, "All Quirks")
	cached_all_quirks = char_quirks

/// Opens the quirk tgui for the user
/datum/controller/subsystem/processing/quirks/proc/OpenWindow(mob/user)
	return ui_interact(user)

/// Opens the quirk tgui for the user
/datum/controller/subsystem/processing/quirks/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "QuirkMenu")
		ui.open()

/datum/controller/subsystem/processing/quirks/ui_state(mob/user)
	return GLOB.always_state

/datum/controller/subsystem/processing/quirks/ui_close(mob/user)
	. = ..()
	SaveUserPreferences(user)
	//INVOKE_ASYNC(src,PROC_REF(UpdateTheWretchedPrefMenu), user)

/datum/controller/subsystem/processing/quirks/ui_static_data(mob/user)
	var/list/data = list()
	data["AllCategories"] = cached_all_categories
	data["AllQuirks"] = cached_all_quirks
	data["MaxQuirkPoints"] = max_points
	data["MaxGoodQuirks"] = max_good_quirks
	return data

/// Pulls all of the user's quirks, and formats them for the tgui
/datum/controller/subsystem/processing/quirks/ui_data(mob/user)
	var/list/data = list()
	var/list/quirks_and_goods = QuirkList2TGUI(user)
	data["DP"] = dp // more dots
	data["UserQuirkNames"] = LAZYACCESS(quirks_and_goods, "UserQuirkNames")
	data["UserQuirkKeys"] = LAZYACCESS(quirks_and_goods, "UserQuirkKeys")
	data["UserQuirkPoints"] = LAZYACCESS(quirks_and_goods, "UserQuirkPoints")
	data["UserQuirkGoods"] = LAZYACCESS(quirks_and_goods, "UserQuirkGoods")
	data["UserQuirksConflictingKeys"] = LAZYACCESS(quirks_and_goods, "UserQuirksConflictingKeys")
	data["UserProstheticObjs"] = LAZYACCESS(quirks_and_goods, "UserProstheticObjs")
	// data["UserQuirkProstheticPoints"] = LAZYACCESS(quirks_and_goods, "UserQuirkProstheticPoints")
	data["UserCkey"] = user.ckey
	data["UserName"] = user.client?.prefs.real_name
	return data

/datum/controller/subsystem/processing/quirks/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/user = ckey2mob(params["UserCkey"]) || usr
	if(!user)
		return FALSE
	switch(params["DoSound"])
		if("ResetQuirks")
			user.playsound_local(user, "sound/effects/quirkui/reset__click.ogg", 50, FALSE)
		if("SaveQuirks")
			user.playsound_local(user, "sound/effects/quirkui/save__click.ogg", 50, FALSE)
		if("SearchType")
			user.playsound_local(user, "sound/effects/quirkui/key_[rand(1,3)].ogg", 50, FALSE)
		if("SearchClear")
			user.playsound_local(user, "sound/effects/quirkui/key_1.ogg", 50, FALSE)
		if("TabClick")
			user.playsound_local(user, "sound/effects/quirkui/tab__click.ogg", 50, FALSE)
		if("RemoveQuirk")
			user.playsound_local(user, "sound/effects/quirkui/remove_quirk__click.ogg", 50, FALSE)
		if("AddQuirk")
			user.playsound_local(user, "sound/effects/quirkui/add_quirk__click.ogg", 50, FALSE)
		if("CantAfford")
			user.playsound_local(user, "sound/effects/quirkui/cant_afford_quirk__click.ogg", 50, FALSE)
		if("TooManyGood")
			user.playsound_local(user, "sound/effects/quirkui/too_many_good_quirks__click.ogg", 50, FALSE)
		if("Conflicts")
			user.playsound_local(user, "sound/effects/quirkui/quirk_conflict__click.ogg", 50, FALSE)
	switch(action)
		if("ClickQuirk") // clicked a quirk to get or unget
			var/q_key = params["QuirkKey"]
			var/datum/quirk/Q = GetQuirk(q_key)
			if(!Q)
				return
			var/c_key = params["UserCkey"]
			var/datum/preferences/P = extract_prefs(c_key)
			if(!P)
				return
			if(q_key in P.char_quirks)
				RemoveQuirkFromPrefs(P, q_key, FALSE, TRUE)
			else
				AddQuirkToPrefs(c_key, q_key, FALSE, TRUE)
			. = TRUE
		if("SaveQuirks") // save the quirks!
			SaveUserPreferences(user)
			. = TRUE
		if("ClearQuirks") // Nuke the quirks! (gotta nuke something)
			. = TRUE
			INVOKE_ASYNC(src,PROC_REF(ConfirmClear), user)

/// returns a list of ckey'd quirk names
/datum/controller/subsystem/processing/quirks/proc/QuirkList2TGUI(mob/user)
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return list("Time2Runtime", "Time2Runtime", "Time2Runtime")
	var/list/out = list()
	out["UserQuirkNames"] = list()
	out["UserQuirkKeys"] = list()
	out["UserQuirkPoints"] = GetQuirkBalance(P, FALSE)
	out["UserQuirkGoods"] = GetPositiveQuirkCount(P)
	/// A pre-assembled list quirks that we can't get, cus they conflict with what we have
	/// much rather process it here than in the tgui, gets kiiiiiiinda laggy
	out["UserQuirksConflictingKeys"] = list()
	for(var/qpath in P.char_quirks) // list of type paths
		var/datum/quirk/Q = GetQuirk(qpath)
		if(!Q)
			stack_trace("QuirkList2TGUI: Quirk [qpath] on [P.parent.ckey]'s profile does not exist! cool")
			RemoveQuirkFromPrefs(P, qpath)
			continue
		out["UserQuirkNames"] |= "[Q.name]"
		out["UserQuirkKeys"] |= "[Q.key]"
		out["UserQuirksConflictingKeys"] |= Q.get_conflicts()
	out["UserProstheticObjs"] = list()
	var/dickpoints = 0
	for(var/modification in P.modified_limbs)
		if(P.modified_limbs[modification][1] != LOADOUT_LIMB_PROSTHETIC)
			continue
		var/list/limbdat = list()
		limbdat["Limb"] = GLOB.main_body_parts2words[modification]
		limbdat["Manufacturer"] = P.modified_limbs[modification][2]
		dickpoints = min(dickpoints + 11, 33)
		out["UserProstheticObjs"] += list(limbdat)
	out["UserQuirkPoints"] -= dickpoints
	SanitizeUserQuirks(out["UserQuirksConflictingKeys"])
	return out

/// Returns the player's quirk balance
/datum/controller/subsystem/processing/quirks/proc/GetQuirkBalance(datum/preferences/P, include_prosthetics = TRUE)
	if(!P)
		return 0
	var/balance = 0
	for(var/qstring in P.char_quirks)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			stack_trace("GetQuirkBalance: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		balance += Q.value
	if(!include_prosthetics)
		return balance
	var/limbal = 0
	for(var/modification in P.modified_limbs)
		if(P.modified_limbs[modification][1] != LOADOUT_LIMB_PROSTHETIC)
			continue
		limbal = min(limbal + 11, 33)
	return balance - limbal

/// Returns the player's number of good quirks
/datum/controller/subsystem/processing/quirks/proc/GetPositiveQuirkCount(datum/preferences/P)
	if(!P)
		return 0
	var/num_good_quirks = 0
	for(var/qstring in P.char_quirks)
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
	for(var/qstring in P.char_quirks)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			stack_trace("GetPrefQuirks: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		quirkies += Q
	return quirkies

/// Returns one of our quirks, if it exists
/datum/controller/subsystem/processing/quirks/proc/GetQuirk(a_quirk)
	if(!a_quirk)
		return
	if(istext(a_quirk)) // okay okay this could be either a key, or a *name*
		var/datum/quirk/Q = LAZYACCESS(quirks, a_quirk)
		if(Q) // please please
			return Q
		else // lets get searchin
			for(var/quirkkey in quirks)
				var/datum/quirk/Q2 = LAZYACCESS(quirks, quirkkey)
				if(!Q2)
					stack_trace("GetQuirk: Quirk [quirkkey] isnt a quirk anymore! cool")
				if(Q2.name == a_quirk)
					return Q2
			CRASH("Quirk ''''''key''''' [a_quirk] does not exist! frick you for making me serch through 200 something quirks.")
	else if (ispath(a_quirk, /datum/quirk))
		return LAZYACCESS(quirks, "[a_quirk]")
	else if(istype(a_quirk, /datum/quirk))
		var/datum/quirk/Q = a_quirk
		return LAZYACCESS(quirks, "[Q.key]") // even if they have their own quirk, give them one of ours
	CRASH("GetQuirk: Quirk [a_quirk] is not a valid quirk!")

/// Reads all the quirks from the player's prefs, and verifies that they should have them all
/datum/controller/subsystem/processing/quirks/proc/CheckAndVerifyPrefQuirks(datum/preferences/P, save) // from_prefs is to prevent infinite loops, cus it can be called from the prefs save proc
	if(!P)
		return // mind your P's
	var/list/quirklist = P.char_quirks
	if(!LAZYLEN(quirklist))
		return TRUE // they have no quirks, so they're good
	RemoveDeadQuirks(P)
	var/balance = GetQuirkBalance(P, TRUE)
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
			RemoveQuirkFromPrefs(P, qstring, TRUE)
		to_chat(P.parent, span_warning("Some quirks have been removed from your character because they are either conflicting or invalid! Be sure to check your quirks!"))
		. = FALSE
	if(save)
		P.save_character()

/// Reads all the quirks from the player's prefs, and returns TRUE if they can be given this quirk
/datum/controller/subsystem/processing/quirks/proc/VerifyQuirk(datum/preferences/P, Qany, removal)
	if(!P || !Qany)
		return // mind your P's and Qany's
	var/datum/quirk/Q = GetQuirk(Qany)
	if(!Q)
		return // mind your Q's
	RemoveDeadQuirks(P)
	if(!removal)
		if(QuirkConflict(P, Q))
			return FALSE
	var/balance = GetQuirkBalance(P, TRUE)
	var/goods = GetPositiveQuirkCount(P)
	var/val = Q.value
	if(removal)
		val = -val
	if(balance + val > max_points)
		return FALSE
	if(removal)
		return TRUE
	if(Q.value > 0 && goods + 1 > max_good_quirks)
		return FALSE
	return TRUE

/// Returns TRUE if the player has enough good quirk slots for this quirk
/datum/controller/subsystem/processing/quirks/proc/HasEnoughGoodQuirkSlotsForThis(datum/preferences/P, datum/quirk/Q)
	if(!istype(P) || !istype(Q))
		return FALSE // mind your P's and Q's
	var/num_good_quirks = 0
	var/list/their_quirks = P.char_quirks
	for(var/qstring in their_quirks)
		var/datum/quirk/Q2 = GetQuirk(qstring)
		if(!Q2)
			stack_trace("HasEnoughGoodQuirkSlotsForThis: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		if(Q2.value > 0)
			num_good_quirks++
	if(num_good_quirks < max_good_quirks)
		return TRUE
	if(prob(1))
		to_chat(P.parent, span_warning("Sorry, [P.parent.ckey], I can't make you OP. Come back when you're a little... mmmmm... weaker!"))
	else
		to_chat(P.parent, span_warning("You can not have more than [max_good_quirks] good quirks! You have [num_good_quirks] good quirks already!"))

/datum/controller/subsystem/processing/quirks/proc/CanAffordQuirk(datum/preferences/P, datum/quirk/Q)
	if(!istype(P) || !istype(Q))
		return FALSE // mind your P's and Q's
	var/player_point_balance = 0
	var/list/their_quirks = P.char_quirks
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
	if(prob(1))
		to_chat(P.parent, span_warning("Sorry, [P.parent.ckey], I can't make you OP. Come back when you're a little... mmmmm... weaker!"))
	else
		to_chat(P.parent, span_warning("You can not afford [Q.name]! You have [player_point_balance] points, and [Q.value] would put you over the limit of [max_points]!"))

/// Removes quirks until the player's point balance is back in valid range
/datum/controller/subsystem/processing/quirks/proc/PruneQuirksUntilBalanced(datum/preferences/P, unbalanced)
	if(!P)
		return
	if(unbalanced <= max_points)
		CRASH("PruneQuirksUntilBalanced: Player [P.parent.ckey] has a valid point balance! Why are we pruning quirks? [unbalanced] <= [max_points]. dragon pussy")
	var/list/their_quirks = P.char_quirks
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
	to_prune = sortList(to_prune, GLOBAL_PROC_REF(cmp_quirk_asc)) // only got the asc, so just flip it
	to_prune = reverseList(to_prune)
	for(var/datum/quirk/Q3 in to_prune)
		RemoveQuirkFromPrefs(P, Q3)
		unbalanced -= Q3.value
		pruned += Q3
		num_good_quirks--
		if(unbalanced <= max_points && num_good_quirks <= max_good_quirks)
			P.save_character()
			break
	if(LAZYLEN(pruned))
		to_chat(P.parent, span_warning("You somehow had more quirks than your point balance allowed! [english_list(pruned)] have been removed from your character!"))

/// Returns TRUE if the quirk conflicts with any of the player's quirks
/datum/controller/subsystem/processing/quirks/proc/QuirkConflict(datum/preferences/P, datum/quirk/Q)
	if(!istype(P) || !istype(Q))
		return TRUE // mind your P's and Q's -- yes im gonna keep doing this
	var/list/quirklist = P.char_quirks
	var/list/cornflicts = list()
	for(var/qstring in quirklist)
		var/datum/quirk/Q2 = GetQuirk(qstring)
		if(!Q2)
			stack_trace("QuirkConflict: Quirk [qstring] on [P.parent.ckey]'s profile does not exist! cool")
			continue
		if((Q.type in Q2.conflicts) || (Q2.type in Q.conflicts))
			cornflicts += Q2
	if(LAZYLEN(cornflicts))
		to_chat(P.parent, span_warning("You can not take [Q.name], as [english_list(cornflicts)] prevent[LAZYLEN(cornflicts)==1?"s":""] it from being taken! They conflict!"))
		return TRUE
	return FALSE

/// Removes any quirks from the player's prefs that no longer exist
/datum/controller/subsystem/processing/quirks/proc/RemoveDeadQuirks(datum/preferences/P)
	if(!istype(P))
		return // mind your P's and Q's
	var/had_some = FALSE
	var/list/quirklist = P.char_quirks
	for(var/qstring in quirklist)
		var/datum/quirk/Q = GetQuirk(qstring)
		if(!Q)
			RemoveQuirkFromPrefs(P, qstring)
			had_some = TRUE
	if(had_some)
		P.save_character()
		to_chat(P.parent, span_warning("Some quirks have been removed from your character because they no longer exist! Be sure to check your quirks!"))

/// Asks the user if they're sure they want to clear their quirks
/datum/controller/subsystem/processing/quirks/proc/ConfirmClear(mob/user)
	if(!user)
		return
	var/c_key = user.ckey
	var/datum/preferences/P = extract_prefs(c_key)
	if(!P)
		return
	if(!LAZYLEN(P.char_quirks))
		to_chat(user, span_alert("You didn't have any quirks to clear!"))
		return
	var/confirm = tgui_alert(
		user,
		message = "Are you sure you want to clear all your quirks?",
		title = "Whoa hold on there a moment!!",
		buttons = list("Yes, clear my quirks", "No, please don't"),
		timeout = 0,
		autofocus = TRUE)
	if(confirm == "Yes, clear my quirks")
		for(var/qstring in P.char_quirks)
			RemoveQuirkFromPrefs(P, qstring)
		P.save_character()
		to_chat(user, span_green("Your quirks have been cleared, and your character has been saved!"))
	else
		to_chat(user, span_warning("Your quirks have NOT been cleared!"))
	OpenWindow(user) // update the window

/// Checks if the player has their prefs window open, and updates it if so
/datum/controller/subsystem/processing/quirks/proc/UpdateTheWretchedPrefMenu(mob/user)
	set waitfor = FALSE // winexists sleeps, and we need to be wide awake
	if(!user)
		return
	if(!winget(user, "preferences_window", "is-visible"))
		return
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return
	P.ShowChoices(user)

/// Adds a quirk to the player's prefs
/datum/controller/subsystem/processing/quirks/proc/AddQuirkToPrefs(Panty, Qany, save, verify)
	if(!Panty || !Qany)
		return // mind your P's and Q's
	var/datum/quirk/Q = GetQuirk(Qany)
	if(!Q)
		return
	var/datum/preferences/P = extract_prefs(Panty)
	if(!P)
		return
	if(verify && !VerifyQuirk(P, Q))
		return
	LAZYINITLIST(P.char_quirks)
	if(Q.key in quirks) // if it's a valid quirk
		P.char_quirks |= Q.key
	if(save)
		P.save_character()
	return TRUE

/// Removes a quirk from the player's prefs
/datum/controller/subsystem/processing/quirks/proc/RemoveQuirkFromPrefs(Pany, Qany, save, verify)
	if(!Pany || !Qany)
		return // mind your P's and Q's
	var/datum/preferences/P = extract_prefs(Pany)
	if(!P)
		return
	var/key2remove
	var/datum/quirk/Q = GetQuirk(Qany)
	if(Q)
		if(verify && !VerifyQuirk(P, Q, TRUE))
			return
		key2remove = "[Q.key]"
	else
		key2remove = "[Qany]" // hopefully something valid, though it doesnt matter
	P.char_quirks -= key2remove
	if(save)
		P.save_character()

/// Adds a quirk to a mob
/datum/controller/subsystem/processing/quirks/proc/AddQuirkToMob(mob/user, Qany, spawn_effects, words = TRUE)
	if(!user || !Qany)
		return
	var/datum/quirk/T = GetQuirk(Qany)
	if(!T)
		return
	new T.type(user, spawn_effects, words)
	return TRUE

/// Removes a quirk from a mob
/datum/controller/subsystem/processing/quirks/proc/RemoveQuirkFromMob(mob/user, Qany, cus_antag, words = TRUE)
	if(!user || !Qany)
		return
	var/datum/quirk/U = HasQuirk(user, Qany)
	if(!U || (U == LAZYACCESS(quirks, "[U.key]")))
		return // no deleting *our* quirks
	if(cus_antag)
		U.removed_cus_antag(user)
	U.preremove(words)
	qdel(U)
	return TRUE

/// Returns the mob's quirk if they have it
/datum/controller/subsystem/processing/quirks/proc/HasQuirk(mob/living/user, Qany)
	if(!user || !Qany)
		return
	var/datum/quirk/T = GetQuirk(Qany)
	if(!T)
		return
	for(var/datum/quirk/Q in user.mob_quirks)
		if(Q.key == T.key)
			return Q

/// Saves the mob's prefs
/datum/controller/subsystem/processing/quirks/proc/SaveUserPreferences(mob/user)
	if(!user)
		return
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return
	P.save_character()
	to_chat(user, span_greenannounce("Your quirks have been saved! =3"))
	return TRUE

/datum/controller/subsystem/processing/quirks/proc/AssignQuirks(mob/living/user, client/cli, spawn_effects, roundstart = FALSE, datum/job/job)
	if(!user || !cli)
		return
	var/badquirks = 0
	var/datum/preferences/P = extract_prefs(cli)
	CheckAndVerifyPrefQuirks(P)
	var/list/my_quirks = P.char_quirks
	if(job?.blacklisted_quirks)
		for(var/start in job.blacklisted_quirks)
			my_quirks -= "[start]"
	var/list/quirks_i_have = list()
	for(var/V in my_quirks)
		var/datum/quirk/Q = GetQuirk(V)
		if(Q)
			AddQuirkToMob(user, "[Q.key]", spawn_effects)
			quirks_i_have[Q.key] = list(Q.name, Q.value)
		else // dragon pussy
			log_admin("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			stack_trace("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			RemoveQuirkFromPrefs(P, V)
			badquirks++
	RecordSnapshot(user, quirks_i_have)
	if(badquirks)
		to_chat(cli, span_warning("[badquirks] of your quirks were invalid, and have been removed! Be sure to check your quirks!"))
		P.save_character()

/datum/controller/subsystem/processing/quirks/proc/ConvertOldQuirklistToNewQuirklist(datum/preferences/P)
	if(!P)
		return
	var/client/cli = P.parent
	var/static/doit = "Convert My Quirks"
	var/static/doitl8r = "Do it later"
	var/static/discard = "Discard and start over"
	var/proceed = alert(
		cli.mob,
		"You have quirks that use the old system! Would you like to convert them to the new system, do it later, or just discard the old ones and start fresh on some new quirks?",
		"QuirkVerter 2k23: The Quirkening",
		doit,
		doitl8r,
		discard)
	if(proceed == discard)
		to_chat(cli.mob, span_boldannounce("Okay! Your old quirks have been discarded! Be sure to add some new ones!"))
		P.current_version |= PMC_QUIRK_OVERHAUL_2K23
		return // We're not changing the data in `all_quirks` just in case we might need to convert it again in the future
	if(proceed == doitl8r)
		to_chat(cli.mob, span_boldannounce("Okay! Your old quirks have been saved in case you want to do it later!"))
		return
	var/list/old_quirks = P.all_quirks
	var/list/failures = list()
	to_chat(cli, span_phobia("WARNING! WARNING! YOUR QUIRKS ARE BEING CONVERTED FROM THE OLD FORMAT TO THE NEW ONE! PANIC! (dont actually this'll probably work fine)"))
	if(!LAZYLEN(old_quirks))
		to_chat(cli, span_greentext("You didn't have any quirks to begin with, so... all done!"))
		P.current_version |= PMC_QUIRK_OVERHAUL_2K23
		P.save_character()
		return // all done! maybe
	var/list/quirkthing = list()
	for(var/quirkname in old_quirks)
		var/datum/quirk/Q = GetQuirk(quirkname)
		if(!Q)
			failures += quirkname
			continue
		quirkthing += Q.type
	quirkthing = sortList(quirkthing, GLOBAL_PROC_REF(cmp_quirk_asc))
	quirkthing = reverseList(quirkthing) // yeah i dont wanna make another cmp
	/// remove all this current quirks
	P.char_quirks = list()
	for(var/qwirk in quirkthing)
		if(!AddQuirkToPrefs(P, qwirk, FALSE, TRUE))
			var/datum/quirk/Q = GetQuirk(qwirk)
			if(!Q)
				stack_trace("[qwirk] is not a valid quirk!")
			failures += qwirk
	if(LAZYLEN(failures))
		to_chat(P.parent, span_userdanger("Some quirks could not be converted, namely [english_list(failures)]. Be sure to check your quirks!"))
	P.current_version |= PMC_QUIRK_OVERHAUL_2K23
	P.save_character()
	to_chat(cli, span_greentext("Your quirks have been converted! =3"))
	to_chat(cli, span_greentext("Be sure to check your quirks, just to be sure!"))
	// notably, we dont change the data in `all_quirks`
	// just in case we might need to convert it again in the future

/// dont ask
/datum/controller/subsystem/processing/quirks/proc/hi()
	return src

/datum/controller/subsystem/processing/quirks/proc/RecordSnapshot(mob/living/player, list/quirks = list())
	if(!player)
		return
	var/datum/quirk_statistics/QS = FindStatistics(player)
	if(!QS) // heck
		return
	QS.snapshot(player, quirks)

/datum/controller/subsystem/processing/quirks/proc/SaveStats2HardDrive()
	var/my_directory = "[QUIRK_STATISTICS_DIRECTORY]/round_[GLOB.round_id]/"
	// first, make the clump of lists
	var/list/cocklist = list()
	for(var/ckey in cocklist)
		cocklist[ckey] = list()
		var/list_o_stats = LAZYACCESS(quirks_used, ckey)
		for(var/datum/quirk_statistics/QS in list_o_stats)
			var/q_ckey = QS.ckey
			var/q_name = QS.playername
			var/list/quirks = QS.quirk_keys || list()
			cocklist[ckey] += q_ckey
			cocklist[ckey] += q_name
			cocklist[ckey] += list(quirks)
	// list clump obtained. time to mess with the files!
	var/files_already_there = flist(my_directory)
	message_admins("Preparing to save quirk stats to [my_directory]!")
	message_admins("Deleting [LAZYLEN(files_already_there)] quirk files, in prep to save them!")
	/// KILL EM ALL
	for(var/file in files_already_there)
		fdel(file)
	for(var/ck in cocklist)
		var/list/to_jsonify = cocklist[ck]
		var/json_string = safe_json_encode(to_jsonify)
		if(!json_string)
			continue // shruggo
		var/file = QUIRK_PLAYER2FILENAME(to_jsonify[1], to_jsonify[2])
		text2file(json_string, file)
	message_admins("Saved [LAZYLEN(cocklist)] quirks to [my_directory]. should match the last message! if not everything is fuced!")

/datum/controller/subsystem/processing/quirks/proc/LoadStatsFromHardDrive()
	return // I'll make this later

/datum/controller/subsystem/processing/quirks/proc/FindStatistics(mob/living/player)
	if(!player)
		return // lame
	var/list/my_chars = LAZYACCESS(quirks_used, player.ckey)
	if(!my_chars) // welcome to the game!
		return new /datum/quirk_statistics()
	var/datum/quirk_statistics/QS = LAZYACCESS(my_chars, player.real_name)
	if(!QS)
		return new /datum/quirk_statistics()
	return QS

/datum/quirk_statistics
	var/playername
	var/ckey
	var/list/quirk_keys = list()

/datum/quirk_statistics/proc/snapshot(mob/living/player, list/quirks = list())
	if(!player)
		return
	playername = player.real_name
	ckey = player.ckey
	quirk_keys = quirks.Copy()

/mob/verb/configure_quirks()
	set name = "Configure Quirks"
	set category = "Preferences"
	
	if(!SSquirks.init_order)
		to_chat(src, span_warning("Quirks are not initialized yet! Please wait a moment and try again."))
		return
	SSquirks.OpenWindow(src)





	/// saved as a warning to others
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


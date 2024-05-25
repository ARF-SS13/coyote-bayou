GLOBAL_LIST_EMPTY(bounties_list)

/datum/bounty
	var/name
	var/description
	var/base_reward =         COINS(50) // In credits.
	var/medium_reward_bonus = COINS(10) // In credits.
	var/hard_reward_bonus =   COINS(30) // In credits.
	var/CBT_reward_bonus =    COINS(50) // In credits.

	/// Which questgivers can give this quest? for flavor purposes
	/// format: list(QUESTGIVER_GUILD, QUESTGIVER_GRAGG, etc)
	var/list/flavor_questgivers = list()
	/// Gets the right kind of quest kind flavor from the questgiver
	var/flavor_kind
	/// Our focus, if any. Try to keep it a path to a type
	var/flavor_focus

	var/paid_out = FALSE
	var/completed = FALSE
	var/claimed = FALSE
	var/high_priority = FALSE

	/// The chance of this bounty being picked
	var/weight = 1
	var/candupe = TRUE
	var/respect_extinction = TRUE

	var/uid = "Bingus"
	var/assigned_q_uid

	var/is_templarte = FALSE

	var/request_mode = QUEST_FULFILL_ALL

	/// A list of /datum/bounty_quota that will be loaded into wanted_things
	var/list/init_wanteds = list()
	var/list/wanted_things = list()
	var/nerfed = FALSE

	/// The difficulty of the quest. This is used to determine how many of the wanted things need to be turned in.
	var/difficulty = QUEST_DIFFICULTY_EASY
	/// How should difficulties be handled?
	var/difficulty_flags = NONE
	var/is_laggy_as_hell = FALSE
	var/deserialization_complete = FALSE

	var/list/congrats_phrases = list(
		"Well done",
		"Splendid work",
		"Excellent adventuring",
		"Nice one",
		"A for Outstanding",
		"Best in show",
		"You deserve a medal",
		"Such good",
		"Smokin'",
		"WOW"
	)
	var/list/accomplishment_phrases = list(
		"You're such a good task-doer!",
		"That'll look great in the garden!",
		"That's a lot of stuff!",
		"That's exactly what I need!",
		"Wow that hit the spot!",
		"We knew you could do it!",
		"Good job!",
		"Your supervisor is very proud of you!",
		"Payment for services rendered, good work!",
		"Fine work! Here's the pay."
	)

// Displayed on bounty UI screen.
/datum/bounty/New(diffi, datum/bounty/from, saveloaded)
	. = ..()
	if(saveloaded)
		return // awaiting external intialization
	if(istype(from))
		copy_bounty(from)
		return
	if(isnum(diffi))
		set_difficulty(diffi)
	create_quotas(FALSE)
	if(!is_valid_bounty())
		stack_trace("[src.type] is not a valid bounty! Error code: THICC-FLUFFY-SERGAL-SPINE")
		qdel(src)
	assign_uid()

/datum/bounty/Destroy(force, ...)
	QDEL_LIST(wanted_things)
	SSeconomy.cleanup_deleting_quest(src)
	. = ..()

/datum/bounty/proc/is_valid_bounty()
	return LAZYLEN(wanted_things)

/datum/bounty/proc/assign_uid()
	uid = ""
	uid += "[type]-"
	uid += "[round(world.time)]-"
	uid += "[rand(1000, 9999)]"

/datum/bounty/proc/set_difficulty(difficulty)
	src.difficulty = difficulty
	for(var/datum/bounty_quota/BQ in wanted_things)
		if(isnum(BQ.difficulty))
			if(!CHECK_BITFIELD(difficulty, BQ.difficulty))
				wanted_things -= BQ
				qdel(BQ)
				continue
		BQ.recalculate_difficulty(difficulty, difficulty_flags)
		if(!nerfed && BQ.NERF())
			description += "<br />Warning: This quest is not even remotely fair, and should only be attempted by someone with a lot of time to kill. Cus seriously, look at those objectives, what the heck."
			nerfed = TRUE

	// if(CHECK_BITFIELD(difficulty_flags, QDF_MORE_FILLED))
	// 	switch(difficulty)
	// 		if(QUEST_DIFFICULTY_EASY)
	// 			request_mode = QUEST_FULFILL_ANY
	// 		if(QUEST_DIFFICULTY_MED)
	// 			request_mode = QUEST_FULFILL_HALF
	// 		else
	// 			request_mode = QUEST_FULFILL_ALL

/datum/bounty/proc/copy_bounty(datum/bounty/from)
	uid = from.uid
	name = from.name
	description = from.description
	difficulty = from.difficulty
	nerfed = from.nerfed

	for(var/i in 1 to LAZYLEN(from.wanted_things))
		var/datum/bounty_quota/BQ = from.wanted_things[i]
		if(!BQ)
			continue
		wanted_things += new BQ.blank_path(BQ)

/datum/bounty/proc/create_quotas(allofem)
	QDEL_LIST(wanted_things)
	for(var/i in init_wanteds)
		var/datum/bounty_quota/BQ = i
		var/its_difficulty = initial(BQ.difficulty)
		if(!allofem && !isnull(difficulty) && !isnull(its_difficulty))
			if(!CHECK_BITFIELD(difficulty, its_difficulty))
				continue
		wanted_things += new BQ()
	if(!LAZYLEN(wanted_things))
		return create_quotas(TRUE) // thats it, you're all added

/datum/bounty/proc/assign_to(mob/assi)
	if(!assi)
		return
	assigned_q_uid = SSeconomy.extract_quid(assi) // this is

/datum/bounty/proc/Flavorize()
	// SSeconomy.flavor_quest(src)

// Displayed on bounty UI screen.
/datum/bounty/proc/completion_string()
	return ""

// Displayed on bounty UI screen.
/datum/bounty/proc/reward_string()
	var/payout = base_reward
	switch(difficulty)
		if(QUEST_DIFFICULTY_MED)
			payout += medium_reward_bonus
		if(QUEST_DIFFICULTY_HARD)
			payout += hard_reward_bonus
		if(QUEST_DIFFICULTY_CBT)
			payout += CBT_reward_bonus
	return "[base_reward / 10] [SSeconomy.currency_name]"

/datum/bounty/proc/can_claim()
	return !claimed

/datum/bounty/proc/can_accept(mob/wanter)
	return SSeconomy.check_quest_repeat(wanter, src)

// Called when the claim button is clicked. Override to provide fancy rewards.
/datum/bounty/proc/attempt_turn_in(atom/thing, mob/claimant, loud, just_check)
	if(!thing || !claimant || !thing)
		return FALSE
	if(is_complete())
		return FALSE
	var/was_a_dupe = FALSE
	for(var/datum/bounty_quota/BQ in wanted_things) // mooooom take me to bairy queeeen
		if(!claimant || !BQ.CanTurnThisIn(thing, claimant) || BQ.IsCompleted())
			continue
		if(SSeconomy.is_duplicate_submission(claimant, thing, BQ))
			was_a_dupe = TRUE
			continue
		return actually_turn_in_thing(thing, claimant, BQ)
	if(was_a_dupe)
		to_chat(claimant, span_alert("You've already turned in a '[thing]' for this quest!"))
	return FALSE

/datum/bounty/proc/actually_turn_in_thing(atom/thing, mob/user, datum/bounty_quota/BQ)
	if(!thing || !user || !BQ)
		return
	playsound(get_turf(thing), 'sound/effects/booboobee.ogg', 75)
	var/datum/beam/bean = user.Beam(thing, icon_state = "g_beam", time = BQ.claimdelay)
	glowify(thing)
	if(!do_after(user, BQ.claimdelay, TRUE, thing, TRUE, public_progbar = TRUE, stay_close = FALSE))
		unglowify(thing)
		if(bean)
			bean.End(TRUE)
		return
	unglowify(thing)
	bean.End(TRUE)
	if(!user || !BQ.CanTurnThisIn(thing, user) || BQ.IsCompleted() || SSeconomy.is_duplicate_submission(user, thing, BQ) || !user)
		return
	. = TRUE
	SSeconomy.mark_quest_submission(thing, user, BQ)
	BQ.Claim(thing, user)
	var/dump_eet = TRUE
	if(is_complete())
		dump_eet = FALSE
		to_chat(user, span_greentext("'[name]' completed!"))
		to_chat(user, span_green("Claim your reward in the Quest Book!"))
		playsound(get_turf(user), 'sound/effects/quest_complete.ogg', 90)
	else if(BQ.IsCompleted())
		var/number_complete = 0
		for(var/datum/bounty_quota/Bcue in wanted_things)
			if(Bcue.IsCompleted())
				++number_complete
		to_chat(user, span_green("Objective '[BQ.name]' complete! ([number_complete] / [LAZYLEN(wanted_things)])"))
		playsound(get_turf(user), 'sound/effects/objective_complete.ogg', 90)
	else
		to_chat(user, span_green("You turned in a '[thing]'! ([BQ.gotten_amount] / [BQ.needed_amount])"))
		playsound(get_turf(user), 'sound/effects/bleeblee.ogg', 75)
	if(SEND_SIGNAL(thing, COMSIG_MOB_IS_IMPORTANT))
		SEND_SIGNAL(thing, COMSIG_ATOM_BUTCHER, user, 70, 0, TRUE, FALSE)
	if(dump_eet)
		SEND_SIGNAL(thing, COMSIG_ATOM_QUEST_SCANNED, user)
	if(BQ.delete_thing)
		if(prob(0.1))
			thing.audible_message(span_clown("[thing] goes to brazil :)"))
		FancyDelete(thing)
	else
		var/image/I = image('icons/effects/effects.dmi', thing, "shield-flash-longer", thing.layer+1)
		I.color = "#00FF00"
		flick_overlay_view(I, thing, 8)

/datum/bounty/proc/FancyDelete(atom/A)
	if(!A)
		return
	playsound(get_turf(A), 'sound/effects/claim_thing.ogg', 75)
	var/matrix/M = A.transform.Scale(1, 3)
	animate(A, transform = M, pixel_y = 32, time = 10, alpha = 50, easing = CIRCULAR_EASING, flags=ANIMATION_PARALLEL)
	M.Scale(0,4)
	animate(transform = M, time = 5, color = "#1111ff", alpha = 0, easing = CIRCULAR_EASING)
	do_sparks(2, TRUE, get_turf(A), spark_path = /datum/effect_system/spark_spread/quantum)
	QDEL_IN(A, 2 SECONDS)

/datum/bounty/proc/glowify(atom/A)
	if(!A)
		return
	A.add_filter("cool_outline",1, list("type"="outline", "size"=1, "color"= "#00FF00"))

/datum/bounty/proc/unglowify(atom/A)
	if(!A)
		return
	A.remove_filter("cool_outline")

/// If the quest has mobs that might not exist anymore, this will return FALSE.
/datum/bounty/proc/should_be_completable()
	if(SSeconomy.debug_ignore_extinction || !respect_extinction)
		return TRUE
	var/list/mobs = list()
	for(var/datum/bounty_quota/BQ in wanted_things)
		for(var/pat in BQ.paths)
			if(ispath(pat, /mob/living))
				mobs |= pat
	if(!LAZYLEN(mobs))
		return TRUE // no mobs to check, items are typically everywhere
	for(var/mobpath in mobs)
		if(!SSmobs.is_extinct(mobpath))
			return TRUE // last chance to see em!
	return FALSE

/datum/bounty/proc/is_complete()
	if(is_templarte)
		return FALSE
	if(completed)
		return TRUE
	var/needed_wins = LAZYLEN(wanted_things)
	var/wins = 0
	// switch(request_mode)
	// 	if(QUEST_FULFILL_ALL)
	// 		needed_wins = LAZYLEN(wanted_things)
	// 	if(QUEST_FULFILL_ANY)
	// 		needed_wins = 1
	// 	if(QUEST_FULFILL_HALF)
	// 		needed_wins = round(LAZYLEN(wanted_things) / 2)
	for(var/datum/bounty_quota/BQ in wanted_things)
		wins += BQ.IsCompleted()
	if(wins >= needed_wins)
		completed = TRUE
	return completed

/datum/bounty/proc/payout(mob/claimant)
	if(!claimant)
		claimant = SSeconomy.quid2mob(assigned_q_uid)
		if(!claimant)
			return FALSE
	if(paid_out)
		to_chat(claimant, span_alert("That quest has already paid out!"))
		return FALSE
	var/payment = get_reward()
	if(!SSeconomy.adjust_funds(claimant, payment, src))
		to_chat(claimant, span_alert("Something went wrong with the payment processor! Try again later!"))
		return FALSE
	paid_out = TRUE
	good_job(claimant, payment)
	return payment

/datum/bounty/proc/good_job(mob/claimant)
	if(!claimant)
		return
	var/whats_talking = "an otherworldly voice"
	var/atom/thing = SSeconomy.get_plausible_quest_console(claimant)
	if(istype(thing, /obj/item/pda))
		whats_talking = "your PDA"
	else if(istype(thing, /obj/item/radio))
		whats_talking = "your radio"
	var/deafoid = HAS_TRAIT(claimant, TRAIT_DEAF) ? "notice" : "hear"
	var/payment = get_reward()
	var/message = "You [deafoid] [whats_talking] say, \"[phrase_congrats(claimant)] [phrase_accomplishment(claimant)]"
	if(payment <= 10) // one copper
		message += " And for your valiant efforts, here's a single measly [SSeconomy.currency_name]. Don't spend it all in one place!\""
	else
		message += " [phrase_reward(claimant, payment)]\""
	to_chat(claimant, span_green(message))

// If an item sent in the cargo shuttle can satisfy the bounty.
/datum/bounty/proc/get_reward()
	var/payment = base_reward
	switch(difficulty)
		if(QUEST_DIFFICULTY_MED)
			payment += medium_reward_bonus
		if(QUEST_DIFFICULTY_HARD)
			payment += hard_reward_bonus
		if(QUEST_DIFFICULTY_CBT)
			payment += CBT_reward_bonus
	for(var/datum/bounty_quota/BQ in wanted_things)
		payment += BQ.GetPrize(difficulty)
	return payment

/datum/bounty/proc/phrase_congrats(mob/doer)
	var/doername = doer ? "[uppertext(doer.real_name)]" : "RELPH"
	return "[pick(congrats_phrases)], [doername]!"

/datum/bounty/proc/phrase_accomplishment(mob/doer)
	return "[pick(accomplishment_phrases)]"

/datum/bounty/proc/phrase_reward(mob/doer)
	var/payment = get_reward()
	var/msg = "You have been awarded [span_green("[payment / 10] [SSeconomy.currency_name_plural]")]!"
	return "[msg]"

// If an item sent in the cargo shuttle can satisfy the bounty.
/datum/bounty/proc/get_quota_by_uid(quota_uid)
	for(var/datum/bounty_quota/BQ in wanted_things)
		if(BQ.bq_uid == quota_uid)
			return BQ

// If an item sent in the cargo shuttle can satisfy the bounty.
/datum/bounty/proc/applies_to(obj/O)
	return FALSE

// Called when an object is shipped on the cargo shuttle.
/datum/bounty/proc/ship(obj/O)
	return

// When randomly generating the bounty list, duplicate bounties must be avoided.
// This proc is used to determine if two bounties are duplicates, or incompatible in general.
/datum/bounty/proc/compatible_with(other_bounty)
	return TRUE

/datum/bounty/proc/get_wanted_info()
	var/list/out = list()
	for(var/datum/bounty_quota/BQ in wanted_things)
		out += list(BQ.get_tgui_slug())
	return out

// When randomly generating the bounty list, duplicate bounties must be avoided.
// This proc is used to determine if two bounties are duplicates, or incompatible in general.
/datum/bounty/proc/get_tgui(mob/user, taken)
	var/datum/quest_book/QL = SSeconomy.get_quest_book(user)
	var/list/data = list()
	data["QuestName"] = name
	data["QuestDesc"] = description
	data["QuestDifficulty"] = difficulty
	data["QuestInfo"] = get_wanted_info()
	data["QuestReward"] = get_reward()
	data["QuestTaken"] = !!LAZYACCESS(QL.active_quests, uid)
	data["QuestAcceptible"] = QL.can_take_quest(src, FALSE)
	data["QuestComplete"] = is_complete()
	data["QuestIsTemplarte"] = is_templarte
	data["QuestUID"] = uid
	var/compelted_objectives = 0
	for(var/datum/bounty_quota/BQ in wanted_things)
		if(BQ.IsCompleted())
			++compelted_objectives
	data["QuestObjectivesComplete"] = compelted_objectives
	data["QuestObjectivesTotal"] = LAZYLEN(wanted_things)
	data["CurrencyUnit"] = SSeconomy.currency_unit
	return data

/// converts everything to a save-friendly list
/datum/bounty/proc/serialize_to_list()
	var/list/serial = list()
	serial[QFB_NAME]                = name
	serial[QFB_DESCRIPTION]         = description
	serial[QFB_BASE_REWARD]         = base_reward
	serial[QFB_MEDIUM_REWARD_BONUS] = medium_reward_bonus
	serial[QFB_HARD_REWARD_BONUS]   = hard_reward_bonus
	serial[QFB_CBT_REWARD_BONUS]    = CBT_reward_bonus
	serial[QFB_FLAVOR_QUESTGIVERS]  = flavor_questgivers.Copy()
	serial[QFB_FLAVOR_KIND]         = flavor_kind
	serial[QFB_FLAVOR_FOCUS]        = flavor_focus
	serial[QFB_PAID_OUT]            = paid_out
	serial[QFB_COMPLETED]           = completed
	serial[QFB_CLAIMED]             = claimed
	serial[QFB_HIGH_PRIORITY]       = high_priority
	serial[QFB_WEIGHT]              = weight
	serial[QFB_CANDUPE]             = candupe
	serial[QFB_RESPECT_EXTINCTION]  = respect_extinction
	serial[QFB_UID]                 = uid
	serial[QFB_REQUEST_MODE]        = request_mode
	serial[QFB_INIT_WANTEDS]        = init_wanteds.Copy()
	serial[QFB_WANTED_THINGS]       = list()
	for(var/datum/bounty_quota/BQ in wanted_things)
		serial[QFB_WANTED_THINGS] += list(BQ.serialize_to_list())
	serial[QFB_NERFED]                 = nerfed
	serial[QFB_DIFFICULTY]             = difficulty
	serial[QFB_DIFFICULTY_FLAGS]       = difficulty_flags
	serial[QFB_IS_LAGGY_AS_HELL]       = is_laggy_as_hell
	serial[QFB_CONGRATS_PHRASES]       = congrats_phrases.Copy()
	serial[QFB_ACCOMPLISHMENT_PHRASES] = accomplishment_phrases.Copy()
	serial["VALID"] = TRUE
	return serial

/// converts the above list into a functionally identical bounty to the one it describes
/datum/bounty/proc/deserialize_from_list(list/serial)
	if(!serial["VALID"])
		return
	/// first, clear out anything that might still be in the wanted_things list
	QDEL_LIST(wanted_things) // ez
	name                     = serial[QFB_NAME]
	description              = serial[QFB_DESCRIPTION]
	base_reward              = text2num(serial[QFB_BASE_REWARD])
	medium_reward_bonus      = text2num(serial[QFB_MEDIUM_REWARD_BONUS])
	hard_reward_bonus        = text2num(serial[QFB_HARD_REWARD_BONUS])
	CBT_reward_bonus         = text2num(serial[QFB_CBT_REWARD_BONUS])
	flavor_questgivers       = safe_json_decode(serial[QFB_FLAVOR_QUESTGIVERS])
	flavor_kind              = serial[QFB_FLAVOR_KIND]
	flavor_focus             = serial[QFB_FLAVOR_FOCUS]
	paid_out                 = text2num(serial[QFB_PAID_OUT])
	completed                = text2num(serial[QFB_COMPLETED])
	claimed                  = text2num(serial[QFB_CLAIMED])
	high_priority            = text2num(serial[QFB_HIGH_PRIORITY])
	weight                   = text2num(serial[QFB_WEIGHT])
	candupe                  = text2num(serial[QFB_CANDUPE])
	respect_extinction       = text2num(serial[QFB_RESPECT_EXTINCTION])
	uid                      = "[rand(1000, 9999)]-[rand(1000, 9999)]-[rand(1000, 9999)]-[rand(1000, 9999)]"
	request_mode             = text2num(serial[QFB_REQUEST_MODE])
	var/list/preinit_wanteds = serial[QFB_INIT_WANTEDS]
	init_wanteds.Cut()
	for(var/ser in preinit_wanteds)
		init_wanteds += ispath(ser) ? ser : text2path(ser)
	var/list/prewanted_things = serial[QFB_WANTED_THINGS]
	for(var/list/ser in prewanted_things)
		var/datum/bounty_quota/BQ = new /datum/bounty_quota(null, TRUE)
		if(!BQ.deserialize_from_list(ser))
			message_admins("Failed to deserialize bounty quota! Error code: SOCK-MONKEY-SPAGHETTI-NOODLE")
			continue
		wanted_things += BQ
	nerfed                   = text2num(serial[QFB_NERFED])
	difficulty               = text2num(serial[QFB_DIFFICULTY])
	difficulty_flags         = text2num(serial[QFB_DIFFICULTY_FLAGS])
	is_laggy_as_hell         = text2num(serial[QFB_IS_LAGGY_AS_HELL])
	congrats_phrases         = serial[QFB_CONGRATS_PHRASES]
	accomplishment_phrases   = serial[QFB_ACCOMPLISHMENT_PHRASES]
	deserialization_complete = serial["VALID"]
	return deserialization_complete

/datum/bounty/proc/mark_high_priority(scale_reward = 2)
	// if(high_priority)
	// 	return
	// high_priority = TRUE
	// reward = round(reward * scale_reward)

/datum/bounty/proc/get_quest_paths()
	var/list/out = list()
	for(var/datum/bounty_quota/BQ in wanted_things)
		out |= BQ.get_paths()
	return out

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////// THE THINGS THIS THING WANTS
/datum/bounty_quota
	/// The name of this quota
	var/name
	/// Optional flavor text that goes with the expected items
	var/flavor
	/// auto-generated (or not) info as to what this thing wants
	var/info
	/// The paths to things that this thing wants
	var/list/paths = list()
	var/list/paths_exclude = list()
	/// How many we need
	var/needed_amount = 1
	/// if set, will pick a number between needed_amount and this for the needed amount. should be higher than needed_amount, but I understand if you dont want to do that
	var/needed_max
	/// How many we've gotten
	var/gotten_amount = 0
	/// the intended difficulty to spawn, leave null for any
	var/difficulty
	/// If this is true, the info will be auto-generated - keep true, unless you're doing something fancy
	var/auto_generate_info = TRUE
	/// If this is true, and mobs are part of the bounty, they must be dead
	var/mobs_must_be_dead = TRUE
	/// If this is true, claimed things will be fancily deleted
	var/delete_thing = TRUE
	/// How long it takes to submit a thing for this thing
	var/claimdelay = 2 SECONDS
	/// A cached list of all the stuff we want, for quick access
	var/quota_contents
	/// If this is true, the paths will be expanded to include subtypes
	var/paths_get_subtypes = FALSE
	/// If this is true, the paths will be expanded to include the root type
	var/paths_includes_root = TRUE
	/// If this is greater than 0, it will pick this many paths from the list
	var/pick_this_many

	var/price_per_thing = 1
	var/easy_multiplier = 1
	var/medium_multiplier = 1
	var/hard_multiplier = 1
	var/CBT_multiplier = 1

	var/bq_uid = 0
	var/is_copy
	var/post_copy_flags = NONE
	var/deserialization_complete = FALSE
	/// 
	var/datum/bounty_quota/blank_path = /datum/bounty_quota

/datum/bounty_quota/New(datum/bounty_quota/copy_source, halt)
	if(halt)
		return // awaiting external intialization
	setzup(copy_source)

/datum/bounty_quota/proc/setzup(datum/bounty_quota/copy_source)
	if(istype(copy_source))
		CopyFrom(copy_source)
		return
	GenerateUID()
	GetPaths()
	if(auto_generate_info)
		AutoGen()

/datum/bounty_quota/proc/CopyFrom(datum/bounty_quota/copy_source)
	name =                copy_source.name
	flavor =              copy_source.flavor
	info =                copy_source.info
	needed_amount =       copy_source.needed_amount
	needed_max =          copy_source.needed_max
	paths =               copy_source.paths
	paths_exclude =       copy_source.paths_exclude
	difficulty =          copy_source.difficulty
	auto_generate_info =  copy_source.auto_generate_info
	mobs_must_be_dead =   copy_source.mobs_must_be_dead
	delete_thing =        copy_source.delete_thing
	claimdelay =          copy_source.claimdelay
	paths_get_subtypes =  copy_source.paths_get_subtypes
	paths_includes_root = copy_source.paths_includes_root
	pick_this_many =      copy_source.pick_this_many
	price_per_thing =     copy_source.price_per_thing
	easy_multiplier =     copy_source.easy_multiplier
	medium_multiplier =   copy_source.medium_multiplier
	hard_multiplier =     copy_source.hard_multiplier
	CBT_multiplier =      copy_source.CBT_multiplier
	is_copy =             TRUE
	GenerateUID()



/datum/bounty_quota/proc/GenerateUID()
	bq_uid = "[world.time]-[rand(1000, 9999)]-[rand(1000, 9999)]-[rand(1000, 9999)]"

/datum/bounty_quota/proc/GetPaths()
	if(paths_get_subtypes)
		var/list/nupaths = list()
		for(var/pat in paths)
			if(ispath(pat))
				nupaths |= subtypesof(pat)
			if(paths_includes_root)
				nupaths |= pat
		for(var/peat in paths_exclude)
			var/list/paths2not = typesof(peat)
			nupaths -= paths2not
		paths = nupaths.Copy()
	if(LAZYLEN(paths) > 1 && pick_this_many > 0)
		var/num_to_pick = clamp(pick_this_many, 1, LAZYLEN(paths))
		var/list/thepaths = src.paths.Copy()
		paths.Cut()
		for(var/i in 1 to num_to_pick)
			var/pick = pick(thepaths)
			thepaths -= pick
			paths |= pick

/datum/bounty_quota/proc/AutoGen()
	// SSeconomy.autogenerate_info(src)
	var/list/msgs = list()
	if(NERF())  //nerd
		msgs += "Warning: This quest is not even remotely fair."
	msgs += "Accepts:"
	for(var/pat in paths)
		if(!ispath(pat, /atom))
			continue
		var/atom/thing = pat
		var/toadd = "[FOURSPACES]- [initial(thing.name)]"
		if(toadd in msgs)
			continue
		msgs += toadd
	info = msgs.Join("<br />")
	GottaBeDead()
	GonnaDelete()
	AutoGenName()

/datum/bounty_quota/proc/AutoGenName()
	if(name)
		return
	var/theverb = "Scan"
	if(ContainsMobs())
		if(mobs_must_be_dead)
			theverb = "Kill and Scan"
		else
			theverb = "Scan"
	else
		if(delete_thing)
			theverb = "Scan and Deliver"
		else
			theverb = "Tag"
	var/fuzzyamount = "a"
	if(needed_amount > 1)
		fuzzyamount = "some"
	var/kind = "things"
	var/atom/pat = pick(paths)
	kind = "[initial(pat.name)]\s"
	name = "[theverb] [fuzzyamount] [kind]"

/datum/bounty_quota/proc/NERF()
	return (difficulty == QUEST_DIFFICULTY_CBT && needed_amount > 1)

/datum/bounty_quota/proc/GetPrize(difficulty)
	var/prize = price_per_thing * needed_amount
	switch(difficulty)
		if(QUEST_DIFFICULTY_EASY)
			prize *= easy_multiplier
		if(QUEST_DIFFICULTY_MED)
			prize *= medium_multiplier
		if(QUEST_DIFFICULTY_HARD)
			prize *= hard_multiplier
		if(QUEST_DIFFICULTY_CBT)
			prize *= CBT_multiplier
	return prize

/datum/bounty_quota/proc/ContainsMobs()
	for(var/pat in paths)
		if(ispath(pat, /mob/living))
			return TRUE
	return FALSE

/datum/bounty_quota/proc/GottaBeDead()
	if(!mobs_must_be_dead)
		return
	for(var/pat in paths)
		if(!ispath(pat, /mob/living))
			continue
		info += "<br />Note: Living creatures must be dead before they can be scanned!"
		return
	mobs_must_be_dead = FALSE

/datum/bounty_quota/proc/GonnaDelete()
	if(delete_thing)
		info += "<br />Note: Scanned things will be teleported offsite!"

/datum/bounty_quota/proc/Claim(atom/thing, mob/user)
	if(IsCompleted())
		return FALSE
	gotten_amount += 1
	return TRUE

/datum/bounty_quota/proc/CanTurnThisIn(atom/thing, mob/user)
	if(!user)
		return
	if(!thing)
		return FALSE
	// if(!thing.Adjacent(user))
	// 	return FALSE
	if(IsCompleted())
		return FALSE
	if(SSeconomy.is_duplicate_submission(thing, user, src))
		return FALSE
	if(isliving(thing) && mobs_must_be_dead)
		var/mob/living/L = thing
		if(L.stat != DEAD)
			return FALSE
	return IsValidThing(thing)

/datum/bounty_quota/proc/IsValidThing(atom/thing)
	if(!isatom(thing))
		return
	for(var/pat in paths)
		if(thing.type == pat)
			return TRUE

/datum/bounty_quota/proc/IsCompleted()
	return gotten_amount >= needed_amount

/datum/bounty_quota/proc/recalculate_difficulty(difficulty)
	return // todo: your mom

/// converts all the useful info into a list for saving
/datum/bounty_quota/proc/listify()
	var/list/serial = list()
	serial[QFBQ_NAME] = name
	// serial[QFBQ_FLAVOR] = flavor
	// serial[QFBQ_INFO] = info
	serial[QFBQ_NEEDED_AMOUNT] = needed_amount
	serial[QFBQ_GOTTEN_AMOUNT] = gotten_amount
	serial[QFBQ_DIFFICULTY] = difficulty
	serial[QFBQ_PRICE_PER_THING] = price_per_thing
	return serial

/// converts all the useful info into an even more detailed list for saving, cus we gotta be careful to the dot
/datum/bounty_quota/proc/serialize_to_list()
	var/list/serial = list()
	serial[QFBQ_NAME]              = name
	serial[QFBQ_FLAVOR]            = flavor
	serial[QFBQ_INFO]              = info
	serial[QFBQ_NEEDED_AMOUNT]     = needed_amount
	serial[QFBQ_GOTTEN_AMOUNT]     = gotten_amount
	serial[QFBQ_DIFFICULTY]        = difficulty
	serial[QFBQ_PRICE_PER_THING]   = price_per_thing
	serial[QFBQ_EASY_MULTIPLIER]   = easy_multiplier
	serial[QFBQ_MEDIUM_MULTIPLIER] = medium_multiplier
	serial[QFBQ_HARD_MULTIPLIER]   = hard_multiplier
	serial[QFBQ_CBT_MULTIPLIER]    = CBT_multiplier
	serial[QFBQ_MOBS_MUST_BE_DEAD] = mobs_must_be_dead
	serial[QFBQ_DELETE_THING]      = delete_thing
	serial[QFBQ_CLAIMDELAY]        = claimdelay
	serial[QFBQ_PATHS]             = paths.Copy()
	serial[QFBQ_PATHS_EXCLUDE]     = paths_exclude.Copy()
	serial[QFBQ_PICK_THIS_MANY]    = pick_this_many
	serial[QFBQ_BQ_UID]            = bq_uid
	serial[QFBQ_IS_COPY]           = is_copy
	serial[QFBQ_POST_COPY_FLAGS]   = post_copy_flags
	serial["VALID"] = TRUE
	return serial

/// Converts the above list into a functionally identical bounty_quota to the one it describes
/datum/bounty_quota/proc/deserialize_from_list(list/serial)
	if(!serial["VALID"])
		return
	name              = serial[QFBQ_NAME]
	flavor            = serial[QFBQ_FLAVOR]
	info              = serial[QFBQ_INFO]
	needed_amount     = text2num(serial[QFBQ_NEEDED_AMOUNT])
	gotten_amount     = text2num(serial[QFBQ_GOTTEN_AMOUNT])
	difficulty        = text2num(serial[QFBQ_DIFFICULTY])
	price_per_thing   = text2num(serial[QFBQ_PRICE_PER_THING])
	easy_multiplier   = text2num(serial[QFBQ_EASY_MULTIPLIER])
	medium_multiplier = text2num(serial[QFBQ_MEDIUM_MULTIPLIER])
	hard_multiplier   = text2num(serial[QFBQ_HARD_MULTIPLIER])
	CBT_multiplier    = text2num(serial[QFBQ_CBT_MULTIPLIER])
	mobs_must_be_dead = text2num(serial[QFBQ_MOBS_MUST_BE_DEAD])
	delete_thing      = text2num(serial[QFBQ_DELETE_THING])
	claimdelay        = text2num(serial[QFBQ_CLAIMDELAY])
	var/list/prepaths = serial[QFBQ_PATHS]
	paths.Cut()
	for(var/pat in prepaths)
		paths |= ispath(pat) ? pat : text2path(pat)
	var/list/prepaths_exclude = serial[QFBQ_PATHS_EXCLUDE]
	paths_exclude.Cut()
	for(var/pat in prepaths_exclude)
		paths_exclude |= ispath(pat) ? pat : text2path(pat)
	pick_this_many    = serial[QFBQ_PICK_THIS_MANY]
	bq_uid            = serial[QFBQ_BQ_UID]
	is_copy           = text2num(serial[QFBQ_IS_COPY])
	post_copy_flags   = text2num(serial[QFBQ_POST_COPY_FLAGS])
	deserialization_complete = text2num(serial["VALID"])
	return deserialization_complete

/datum/bounty_quota/proc/get_paths()
	var/list/outer = list()
	for(var/pat in paths)
		outer[pat] = TRUE
	return outer

/datum/bounty_quota/proc/get_tgui_slug()
	var/list/data = list()
	data["QuotaName"] = name
	data["QuotaInfo"] = info
	data["QuotaNeeded"] = needed_amount
	data["QuotaGotten"] = gotten_amount
	data["QuotaComplete"] = IsCompleted()
	data["QuotaMobsMustBeDead"] = mobs_must_be_dead
	data["QuotaDeleteThing"] = delete_thing
	data["QuotaContents"] = get_quota_contents()
	data["QuotaUID"] = bq_uid
	data["ImCoder"] = SSeconomy.debug_objectives
	return data

/datum/bounty_quota/proc/get_quota_contents()
	if(!isnull(quota_contents))
		return quota_contents
	var/stuff = NONE
	for(var/pat in paths)
		if(ispath(pat, /obj/item))
			stuff |= BOUNTY_QUOTA_ITEMS
		if(ispath(pat, /mob/living))
			stuff |= BOUNTY_QUOTA_MOBS
			if(mobs_must_be_dead)
				stuff |= BOUNTY_QUOTA_DEAD
	quota_contents = stuff
	return stuff




// This proc is called when the shuttle docks at CentCom.
// It handles items shipped for bounties.
/proc/bounty_ship_item_and_contents(atom/movable/AM, dry_run=FALSE)
	// if(!GLOB.bounties_list.len)
	// 	setup_bounties()

	// var/list/matched_one = FALSE
	// for(var/thing in reverseRange(AM.GetAllContents()))
	// 	var/matched_this = FALSE
	// 	for(var/datum/bounty/B in GLOB.bounties_list)
	// 		if(B.applies_to(thing))
	// 			matched_one = TRUE
	// 			matched_this = TRUE
	// 			if(!dry_run)
	// 				B.ship(thing)
	// 	if(!dry_run && matched_this)
	// 		qdel(thing)
	// return matched_one

// Returns FALSE if the bounty is incompatible with the current bounties.
/proc/try_add_bounty(datum/bounty/new_bounty)
	// if(!new_bounty || !new_bounty.name || !new_bounty.description)
	// 	return FALSE
	// for(var/i in GLOB.bounties_list)
	// 	var/datum/bounty/B = i
	// 	if(!B.compatible_with(new_bounty) || !new_bounty.compatible_with(B))
	// 		return FALSE
	// GLOB.bounties_list += new_bounty
	// return TRUE

// Returns a new bounty of random type, but does not add it to GLOB.bounties_list.
/proc/random_bounty()
	// switch(rand(1, 2))
	// 	if(1)
	// 		var/subtype = pick(subtypesof(/datum/bounty/item/chef))
	// 		return new subtype
	// 	if(2)
	// 		var/subtype = pick(subtypesof(/datum/bounty/item/chef))
	// 		return new subtype

// Called lazily at startup to populate GLOB.bounties_list with random bounties.
/proc/setup_bounties()

	// var/pick // instead of creating it a bunch let's go ahead and toss it here, we know we're going to use it for dynamics and subtypes!

	// /********************************Subtype Gens********************************/
	// var/list/easy_add_list_subtypes = list(/datum/bounty/item/chef = 2,)

	// for(var/the_type in easy_add_list_subtypes)
	// 	for(var/i in 1 to easy_add_list_subtypes[the_type])
	// 		pick = pick(subtypesof(the_type))
	// 		try_add_bounty(new pick)

	// /********************************Strict Type Gens********************************/
	// var/list/easy_add_list_strict_types = list(/datum/bounty/item/chef = 1,
	// 										/datum/bounty/item/chef = 1,
	// 										/datum/bounty/item/chef = 1)

	// for(var/the_strict_type in easy_add_list_strict_types)
	// 	for(var/i in 1 to easy_add_list_strict_types[the_strict_type])
	// 		try_add_bounty(new the_strict_type)

	// /********************************Dynamic Gens********************************/

	// for(var/i in 0 to 1)
	// 	if(prob(50))
	// 		pick = pick(subtypesof(/datum/bounty/item/chef))
	// 	else
	// 		pick = pick(subtypesof(/datum/bounty/item/chef))
	// 	try_add_bounty(new pick)

	// /********************************Cutoff for Non-Low Priority Bounties********************************/
	// var/datum/bounty/B = pick(GLOB.bounties_list)
	// B.mark_high_priority()

	// /********************************Low Priority Gens********************************/
	// var/list/low_priority_strict_type_list = list(/datum/bounty/item/chef)

	// for(var/low_priority_bounty in low_priority_strict_type_list)
	// 	try_add_bounty(new low_priority_bounty)

/proc/completed_bounty_count()
	var/count = 0
	for(var/i in GLOB.bounties_list)
		var/datum/bounty/B = i
		if(B.claimed)
			++count
	return count


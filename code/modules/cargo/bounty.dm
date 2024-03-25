GLOBAL_LIST_EMPTY(bounties_list)

/datum/bounty
	var/name
	var/description
	var/base_reward = 1000 // In credits.
	var/medium_reward_bonus = 100 // In credits.
	var/hard_reward_bonus = 300 // In credits.
	var/CBT_reward_bonus = 500 // In credits.


	var/paid_out = FALSE
	var/completed = FALSE
	var/claimed = FALSE
	var/high_priority = FALSE

	/// The chance of this bounty being picked
	var/weight = 1

	var/uid = "Bingus"
	var/assigned_ckey

	var/is_templarte = FALSE

	var/request_mode = QUEST_FULFILL_ALL

	/// A list of new/datum/bounty_quota(name, stuff, etc) with a number for how much of that it wants
	var/list/wanted_things = list()

	/// The difficulty of the quest. This is used to determine how many of the wanted things need to be turned in.
	var/difficulty = QUEST_DIFFICULTY_EASY
	/// How should difficulties be handled?
	var/difficulty_flags = NONE

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
/datum/bounty/New()
	. = ..()
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
	uid += "[world.time]-"
	uid += "[type]-"
	uid += "[rand(1000, 9999)]"

/datum/bounty/proc/set_difficulty(difficulty)
	src.difficulty = clamp(difficulty, QUEST_DIFFICULTY_EASY, QUEST_DIFFICULTY_CBT)
	for(var/datum/bounty_quota/BQ in wanted_things)
		BQ.recalculate_difficulty(difficulty, difficulty_flags)
	if(CHECK_BITFIELD(difficulty_flags, QDF_MORE_FILLED))
		switch(difficulty)
			if(QUEST_DIFFICULTY_EASY)
				request_mode = QUEST_FULFILL_ANY
			if(QUEST_DIFFICULTY_MED)
				request_mode = QUEST_FULFILL_HALF
			else
				request_mode = QUEST_FULFILL_ALL

/datum/bounty/proc/copy_bounty(datum/bounty/from)
	set_difficulty(from.difficulty)
	uid = from.uid

/datum/bounty/proc/assign_to(mob/assi)
	if(!assi)
		return
	assigned_ckey = assi.ckey

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
/datum/bounty/proc/attempt_turn_in(atom/thing, mob/claimant, loud)
	if(!thing || !claimant || !thing)
		return FALSE
	if(is_complete())
		return FALSE
	var/claimed_thing = FALSE
	for(var/datum/bounty_quota/BQ in wanted_things) // mooooom take me to bairy queeeen
		if(BQ.CanTurnThisIn(thing, claimant))
			claimed_thing = actually_turn_in_thing(thing, claimant, BQ)
			break
	if(!claimed_thing)
		return FALSE
	if(is_complete())
		to_chat(claimant, span_greentext("'[name]' complete!"))
		to_chat(claimant, span_green("Claim your reward in the Quest Book!"))

/datum/bounty/proc/actually_turn_in_thing(atom/thing, mob/user, datum/bounty_quota/BQ)
	if(!thing || !user || !BQ)
		return
	if(!BQ.CanTurnThisIn(thing, user) || BQ.IsCompleted() || SSeconomy.check_duplicate_submissions(user, thing) || is_complete())
		return
	playsound(get_turf(thing), 'sound/effects/booboobee.ogg')
	if(!do_after(user, BQ.claimdelay, TRUE, thing, TRUE, public_progbar = TRUE))
		return
	if(!user || QDELETED(thing) || !BQ.CanTurnThisIn(thing, user) || BQ.IsCompleted() || SSeconomy.check_duplicate_submissions(user, thing) || !user)
		return
	SSeconomy.turned_something_in(thing, BQ)
	playsound(get_turf(thing), 'sound/effects/bleeblee.ogg')
	if(BQ.delete_thing)
		FancyDelete(thing)

/datum/bounty/proc/FancyDelete(atom/A)
	if(!A)
		return
	playsound(get_turf(A), 'sound/effects/claim_thing.ogg')
	var/matrix/original = matrix(A.transform)
	var/matrix/M = A.transform.Scale(1, 3)
	animate(A, transform = M, pixel_y = 32, time = 10, alpha = 50, easing = CIRCULAR_EASING, flags=ANIMATION_PARALLEL)
	M.Scale(0,4)
	animate(transform = M, time = 5, color = "#1111ff", alpha = 0, easing = CIRCULAR_EASING)
	animate(transform = original, time = 5, color = "#ffffff", alpha = 255, pixel_y = 0, easing = ELASTIC_EASING)
	do_sparks(2, TRUE, get_turf(A))
	QDEL_IN(A, 2 SECONDS)

/datum/bounty/proc/is_complete()
	if(is_templarte)
		return FALSE
	if(completed)
		return TRUE
	var/needed_wins = 1
	var/wins = 0
	switch(request_mode)
		if(QUEST_FULFILL_ALL)
			needed_wins = LAZYLEN(wanted_things)
		if(QUEST_FULFILL_ANY)
			needed_wins = 1
		if(QUEST_FULFILL_HALF)
			needed_wins = round(LAZYLEN(wanted_things) / 2)
	for(var/datum/bounty_quota/BQ in wanted_things)
		wins += BQ.IsCompleted()
	if(wins >= needed_wins)
		completed = TRUE
	return completed

/datum/bounty/proc/payout(mob/claimant)
	if(!claimant)
		claimant = ckey2mob(assigned_ckey)
		if(!claimant)
			return FALSE
	if(paid_out)
		to_chat(claimant, span_alert("That quest has already paid out!"))
		return FALSE
	paid_out = TRUE
	var/payment = get_reward()
	SSeconomy.adjust_funds(claimant)
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
	data["QuestReward"] = reward_string()
	data["QuestTaken"] = is_templarte && !!LAZYACCESS(QL.active_quests, uid)
	data["QuestAcceptible"] = QL.can_take_quest(user, src, FALSE)
	data["QuestComplete"] = is_complete()
	data["QuestIsTemplarte"] = is_templarte
	data["QuestUID"] = uid
	return data

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

//////////////////////////////////////////
//////////// THE THINGS THIS THING WANTS
/datum/bounty_quota
	var/name
	var/info
	var/list/paths = list()
	var/needed_amount = 1
	var/gotten_amount = 0
	var/auto_generate_info = TRUE
	var/mobs_must_be_dead = TRUE
	var/delete_thing = TRUE
	var/claimdelay = 2 SECONDS

/datum/bounty_quota/New(name, info, paths, needed_amount)
	if(!isnull(name))
		src.name = name
	if(!isnull(info))
		src.info = info
	if(islist(paths))
		src.paths = paths
	if(!isnull(needed_amount))
		src.needed_amount = needed_amount
	if(auto_generate_info)
		AutoGen()
	GottaBeDead()
	GonnaDelete()

/datum/bounty_quota/proc/AutoGen()
	if(info)
		return // already set
	var/list/msgs = list()
	msgs += "Accepts:"
	for(var/pat in paths)
		if(!ispath(pat))
			continue
		var/atom/thing = pat
		msgs += "[FOURSPACES]- [initial(thing.name)]"
	info = msgs.Join("<br />")

/datum/bounty_quota/proc/GottaBeDead()
	if(!mobs_must_be_dead)
		return
	for(var/pat in paths)
		if(!ispath(pat, /mob/living))
			continue
		info += "<br />Note: Living creatures must be dead before they can be claimed!"
		return
	mobs_must_be_dead = FALSE

/datum/bounty_quota/proc/GonnaDelete()
	if(delete_thing)
		info += "<br />Note: Claimed things will be teleported offsite!"

/datum/bounty_quota/proc/CanTurnThisIn(atom/thing, mob/user)
	if(!user)
		return
	if(!thing)
		return FALSE
	if(!thing.Adjacent(user))
		return FALSE
	if(IsCompleted())
		return FALSE
	if(SSeconomy.check_duplicate_submissions(thing, user))
		return FALSE
	if(isliving(thing))
		var/mob/living/L = thing
		if(L.stat != DEAD)
			return FALSE
	for(var/pat in paths)
		if(thing.type == pat)
			return TRUE

/datum/bounty_quota/proc/IsCompleted()
	return gotten_amount >= needed_amount

/datum/bounty_quota/proc/recalculate_difficulty(difficulty)
	return // todo: your mom

/datum/bounty_quota/proc/get_paths()
	var/list/outer = list()
	for(var/pat in paths)
		outer[pat] = TRUE
	return outer

/datum/bounty_quota/proc/get_tgui_slug()
	var/list/data = list()
	data["EntryName"] = name
	data["EntryInfo"] = info
	data["EntryNeeded"] = needed_amount
	data["EntryGotten"] = gotten_amount
	data["EntryComplete"] = IsCompleted()
	data["EntryMobsMustBeDead"] = mobs_must_be_dead
	data["EntryDeleteThing"] = delete_thing
	return data

// This proc is called when the shuttle docks at CentCom.
// It handles items shipped for bounties.
/proc/bounty_ship_item_and_contents(atom/movable/AM, dry_run=FALSE)
	if(!GLOB.bounties_list.len)
		setup_bounties()

	var/list/matched_one = FALSE
	for(var/thing in reverseRange(AM.GetAllContents()))
		var/matched_this = FALSE
		for(var/datum/bounty/B in GLOB.bounties_list)
			if(B.applies_to(thing))
				matched_one = TRUE
				matched_this = TRUE
				if(!dry_run)
					B.ship(thing)
		if(!dry_run && matched_this)
			qdel(thing)
	return matched_one

// Returns FALSE if the bounty is incompatible with the current bounties.
/proc/try_add_bounty(datum/bounty/new_bounty)
	if(!new_bounty || !new_bounty.name || !new_bounty.description)
		return FALSE
	for(var/i in GLOB.bounties_list)
		var/datum/bounty/B = i
		if(!B.compatible_with(new_bounty) || !new_bounty.compatible_with(B))
			return FALSE
	GLOB.bounties_list += new_bounty
	return TRUE

// Returns a new bounty of random type, but does not add it to GLOB.bounties_list.
/proc/random_bounty()
	switch(rand(1, 2))
		if(1)
			var/subtype = pick(subtypesof(/datum/bounty/item/chef))
			return new subtype
		if(2)
			var/subtype = pick(subtypesof(/datum/bounty/item/chef))
			return new subtype

// Called lazily at startup to populate GLOB.bounties_list with random bounties.
/proc/setup_bounties()

	var/pick // instead of creating it a bunch let's go ahead and toss it here, we know we're going to use it for dynamics and subtypes!

	/********************************Subtype Gens********************************/
	var/list/easy_add_list_subtypes = list(/datum/bounty/item/chef = 2,)

	for(var/the_type in easy_add_list_subtypes)
		for(var/i in 1 to easy_add_list_subtypes[the_type])
			pick = pick(subtypesof(the_type))
			try_add_bounty(new pick)

	/********************************Strict Type Gens********************************/
	var/list/easy_add_list_strict_types = list(/datum/bounty/item/chef = 1,
											/datum/bounty/item/chef = 1,
											/datum/bounty/item/chef = 1)

	for(var/the_strict_type in easy_add_list_strict_types)
		for(var/i in 1 to easy_add_list_strict_types[the_strict_type])
			try_add_bounty(new the_strict_type)

	/********************************Dynamic Gens********************************/

	for(var/i in 0 to 1)
		if(prob(50))
			pick = pick(subtypesof(/datum/bounty/item/chef))
		else
			pick = pick(subtypesof(/datum/bounty/item/chef))
		try_add_bounty(new pick)

	/********************************Cutoff for Non-Low Priority Bounties********************************/
	var/datum/bounty/B = pick(GLOB.bounties_list)
	B.mark_high_priority()

	/********************************Low Priority Gens********************************/
	var/list/low_priority_strict_type_list = list(/datum/bounty/item/chef)

	for(var/low_priority_bounty in low_priority_strict_type_list)
		try_add_bounty(new low_priority_bounty)

/proc/completed_bounty_count()
	var/count = 0
	for(var/i in GLOB.bounties_list)
		var/datum/bounty/B = i
		if(B.claimed)
			++count
	return count


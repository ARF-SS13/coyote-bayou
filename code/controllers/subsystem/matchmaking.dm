SUBSYSTEM_DEF(matchmaking)
	name = "Matchmaking"
	init_order = INIT_ORDER_MATCHMATKING
	flags = SS_NO_FIRE
	/// Mobs seeking a match. Associative list: bachelors[bachelor] -> list(matchmaking datums)
	var/list/bachelors = list()
	/// Typepaths of the valid matchmaking datums.
	var/list/all_match_types = list()
	/// Associative list of matches made. list: all_match_types[string ref] -> string ref
	var/list/matches_made = list()
	/// List of strings for the round end report.
	var/list/matches_log = list()


/datum/controller/subsystem/matchmaking/Initialize(timeofday)
	for(var/subtype in subtypesof(/datum/matchmaking_pref))
		all_match_types +=subtype
	return ..()


/datum/controller/subsystem/matchmaking/proc/add_candidate_aspiration(mob/living/candidate, datum/matchmaking_pref/aspiration)
	if(!bachelors[candidate])
		RegisterSignal(candidate, COMSIG_PARENT_QDELETING, .proc/on_candidate_qdel)
		RegisterSignal(candidate, COMSIG_MOB_CLIENT_LOGOUT, .proc/on_candidate_logout)
	LAZYADD(bachelors[candidate], aspiration)


/datum/controller/subsystem/matchmaking/proc/remove_candidate_aspiration(mob/living/candidate, datum/matchmaking_pref/aspiration)
	LAZYREMOVE(bachelors[candidate], aspiration)
	if(!bachelors[candidate])
		remove_candidate(candidate)


/datum/controller/subsystem/matchmaking/proc/remove_candidate(mob/living/candidate)
	bachelors -= candidate
	UnregisterSignal(candidate, list(COMSIG_PARENT_QDELETING, COMSIG_MOB_CLIENT_LOGOUT))


/datum/controller/subsystem/matchmaking/proc/on_candidate_qdel(mob/living/candidate)
	SIGNAL_HANDLER
	remove_candidate(candidate)

/datum/controller/subsystem/matchmaking/proc/on_candidate_logout(mob/living/candidate)
	SIGNAL_HANDLER
	if(candidate.key)
		return // They disconnected and may be back.
	// Else they're gone from good and won't be getting back anymore.
	remove_candidate(candidate)


/datum/controller/subsystem/matchmaking/proc/matchmake()
	for(var/mob/living/candidate as anything in bachelors)
		if(candidate.stat != CONSCIOUS || !candidate.mind || !candidate.client?.prefs)
			continue

		for(var/datum/matchmaking_pref/aspiration as anything in shuffle(bachelors[candidate]))
			aspiration.try_finding_matches()


/datum/matchmaking_pref
	/// How this option will appear on the preferences menu.
	var/pref_text = ""
	/// Mob owner of this pref.
	var/mob/living/pref_holder = null
	/// What kind of target are we looking to match with.
	var/target_type = null
	/// How many matches have we already found.
	var/matches_found = 0
	/// How many matches will be try to do.
	var/matches_aimed = 0
	/// Maximum amount of matches.
	var/max_matches = 1
	/// How long it takes after the player joins before this event happens.
	var/spawn_time = 0
	/// Added memory on matchmaking.
	var/acquire_memory = ""
	/// Whether we wknow who the target is.
	var/we_know_target = TRUE
	/// If we know the target, does it have a custom span class in the memory text?
	var/span_class = null
	/// Whether we want to be remembered on every match, or just the first time.
	var/remind_only_first_time = FALSE
	/// Description of the matching act for the round-end report: "Candidate, the (job), [log_verb] bachelor, the (job)."
	var/log_verb = ""


/datum/matchmaking_pref/New(mob/living/pref_holder, matches_aimed = 1)
	if(!pref_holder)
		CRASH("Matchmaking pref created without a holder.")
	if(matches_aimed <= 0)
		CRASH("Matchmaking pref created with invalid matches_aimed value: [matches_aimed]")
	RegisterSignal(pref_holder, COMSIG_PARENT_QDELETING, .proc/on_candidate_qdel)
	src.pref_holder = pref_holder
	src.matches_aimed = clamp(matches_aimed, 0, max_matches)
	SSmatchmaking.add_candidate_aspiration(pref_holder, src)


/datum/matchmaking_pref/Destroy(force, ...)
	if(pref_holder)
		if(SSmatchmaking.bachelors[pref_holder])
			SSmatchmaking.remove_candidate_aspiration(pref_holder, src)
		pref_holder = null
	return ..()


/datum/matchmaking_pref/proc/on_candidate_qdel(mob/living/source, force)
	qdel(src)


/datum/matchmaking_pref/proc/try_finding_matches()
	if(matches_found >= matches_aimed)
		SSmatchmaking.remove_candidate_aspiration(pref_holder, src)
		return
	var/datum/job/candidate_job = SSjob.GetJob(pref_holder.mind.assigned_role)
	// Does our job let us be this role? With which other jobs?
	var/list/matching_jobs = candidate_job?.matchmaking_allowed
	if(!matching_jobs)
		return // No matchmaking allowed at all!
	matching_jobs = matching_jobs[type]
	if(!matching_jobs)
		return // Not our kind of matchmaking!
	var/candidate_ref = REF(pref_holder)

	var/list/bachelors = shuffle(SSmatchmaking.bachelors)
	for(var/mob/living/bachelor as anything in bachelors)
		if(bachelor == pref_holder || bachelor.stat != CONSCIOUS || !bachelor.mind || !bachelor.client)
			continue
		
		var/bachelor_ref = REF(bachelor)
		if(bachelor_ref in SSmatchmaking.matches_made[candidate_ref])
			continue // Already matched with this one.

		// Check if their job is compatible with ours.
		var/datum/job/bachelor_job = SSjob.GetJob(bachelor.mind.assigned_role)
		var/job_allowed = FALSE
		for(var/job_type in matching_jobs)
			if(!istype(bachelor_job, job_type))
				continue
			job_allowed = TRUE
			break
		if(!job_allowed)
			continue

		for(var/datum/matchmaking_pref/aspiration as anything in bachelors[bachelor])
			if(!istype(aspiration, target_type) || !istype(src, aspiration.target_type) || aspiration.matches_found >= aspiration.matches_aimed)
				continue

			// Match!
			LAZYADD(SSmatchmaking.matches_made[candidate_ref], bachelor_ref)
			LAZYADD(SSmatchmaking.matches_made[bachelor_ref], candidate_ref)
			enact_match(bachelor)
			aspiration.enact_match(pref_holder)
			SSmatchmaking.matches_log += "<b>[pref_holder.real_name]</b>, the [candidate_job.title], [log_verb] <b>[bachelor.real_name]</b>, the [bachelor_job.title]."
			log_game("MATCHMAKING: [pref_holder.real_name], the [candidate_job.title], [log_verb] [bachelor.real_name], the [bachelor_job.title].")
			break

		if(matches_found >= matches_aimed)
			break // No more searching for this one.


/datum/matchmaking_pref/proc/enact_match(mob/living/target)
	matches_found++
	if(spawn_time > 0)
		addtimer(CALLBACK(src, .proc/do_enact_match, WEAKREF(target)), spawn_time)
	else
		do_enact_match(target)
	if(matches_found >= matches_aimed)
		SSmatchmaking.remove_candidate_aspiration(pref_holder, src)


/datum/matchmaking_pref/proc/do_enact_match(mob/living/target)
	if(QDELETED(pref_holder) || !pref_holder.ckey || !pref_holder.mind)
		qdel(src)
		return
	if(istype(target, /datum/weakref))
		var/datum/weakref/weakref = target
		target = weakref.resolve()
	if(QDELETED(target) || !target.ckey || !target.mind)
		return // Destroyed or left for good.
	if(acquire_memory && !(remind_only_first_time && findtext(pref_holder.mind.memory, acquire_memory)))
		var/list/memory = list(acquire_memory)
		if(we_know_target)
			if(span_class)
				memory += ": <span class=\"[span_class]\"><b>[target.real_name]</b></span>"
			else
				memory += ": <b>[target.real_name]</b>"
			var/target_role = target.mind.assigned_role
			if(target_role)
				memory += ", the [target_role]"
		memory += ".<br>"
		memory = memory.Join()
		pref_holder.mind.memory += memory
		to_chat(pref_holder, memory)
	on_match_enacted(target)


/datum/matchmaking_pref/proc/on_match_enacted(mob/living/target)
	return


/datum/matchmaking_pref/friend
	pref_text = "Friends"
	target_type = /datum/matchmaking_pref/friend
	acquire_memory = "You remember a friendly face you haven't seen in a while"
	span_class = "nicegreen"
	max_matches = 3
	log_verb = "revisited fond moments with"


/datum/matchmaking_pref/rival
	pref_text = "Rivals"
	target_type = /datum/matchmaking_pref/rival
	acquire_memory = "You remember a good-for-nothing piece of bad memory"
	span_class = "red"
	max_matches = 3
	log_verb = "held mutual contempt for"


/datum/matchmaking_pref/mentor
	pref_text = "Be someone's mentor"
	target_type = /datum/matchmaking_pref/disciple
	acquire_memory = "You remember an old disciple you once taught"
	span_class = "blue"
	log_verb = "taught"


/datum/matchmaking_pref/disciple
	pref_text = "Have a mentor"
	target_type = /datum/matchmaking_pref/mentor
	acquire_memory = "You remember an old mentor you've lost contact with"
	span_class = "blue"
	log_verb = "was mentored by"


/datum/matchmaking_pref/patron
	pref_text = "Be someone's patron"
	target_type = /datum/matchmaking_pref/protegee
	acquire_memory = "You remember an old protegee you once took care of. They owe you, and should remember it"
	span_class = "green"
	log_verb = "extended their protection to"


/datum/matchmaking_pref/protegee
	pref_text = "Have a patron"
	target_type = /datum/matchmaking_pref/patron
	acquire_memory = "You remember an old patron who once helped you set youreself up in life. You owe them one, you'd be in a bad position if not for them"
	span_class = "green"
	log_verb = "owed favors to"


/datum/matchmaking_pref/outlaw
	pref_text = "Hunters after you"
	target_type = /datum/matchmaking_pref/bounty_hunter
	spawn_time = 5 MINUTES
	acquire_memory = "You remember the foul deeds you've done. You hope they don't come back to haunt you"
	span_class = "danger"
	we_know_target = FALSE
	remind_only_first_time = TRUE
	max_matches = 3
	log_verb = "was hunted by"


/datum/matchmaking_pref/bounty_hunter
	pref_text = "Hunt outlaw bounties"
	target_type = /datum/matchmaking_pref/outlaw
	spawn_time = 5 MINUTES
	acquire_memory = "You remember the face in the wanted poster of a criminal, rumored to be wandering this area, for whose head you've been promised a reward"
	span_class = "danger"
	max_matches = 3
	log_verb = "hunted"

/datum/matchmaking_pref/bounty_hunter/on_match_enacted(mob/living/target)
	if(pref_holder.stat != CONSCIOUS || pref_holder.restrained(pref_holder))
		return
	var/perp_name = target.real_name
	var/datum/data/record/perp_record = find_record("name", perp_name, GLOB.data_core.general)
	if(!perp_record)
		CRASH("No perp_record for [target.real_name]")
	var/obj/item/photo/photo = perp_record.fields["photo_front"]
	if(!photo)
		CRASH("No photo for [target.real_name]")
	var/description = "Notice to all Regulators seeking Lawful Bounties in the Capital Wastes:\
	<br>Let it be known that the following individual is offered for bounty in the sum of 1,000 caps or similar compensation of expended equipment and/or medical expense, for crimes against the good people of the Capital Wasteland and environs:\
	<br><br>Name: [perp_name]\
	<br><br>Wanted dead or alive.\
	<br>Bounty will be paid upon delivery of body or proof of death."

	var/obj/item/poster/wanted/bounty = new(pref_holder.loc, photo.picture.picture_image, perp_name, description, "WANTED")
	pref_holder.equip_to_slot_if_possible(bounty, SLOT_IN_BACKPACK, TRUE, TRUE, FALSE, TRUE)

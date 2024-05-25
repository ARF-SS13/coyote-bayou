/// AUTOPLAPPER 9000
/// Plaps for you, plaps for me, plaps for everyone!
/// Perfect for hands-free gaming!
////////////////////////////////////////////////////////////////////////////////////////
#define PLAP_GIVE_UP_TIME 15 MINUTES // if you're gonna take longer than this to plap, you'll want to do it manually
/datum/autoplapper
	/// Which interaction will we be using?
	var/plap_key
	/// plap_key is just a type path, so heres the actual interaction name
	var/plap_name
	/// is it a lewwwwwwwd plap?
	var/lewd_plap = FALSE
	/// Who is doing the plapping? these are ckeys!
	var/plapper
	/// Who is being plapped? these are ckeys!
	var/plappee
	/// How many times have we plapped?
	var/plap_count = 0
	/// What's our interval between plaps?
	var/plap_interval
	/// Last time we plapped
	var/last_plap = 0
	/// The time this thing started existence, for finalization purposes
	var/plap_startpoint = 0
	/// Are we currently plapping?
	var/plapping_active = FALSE
	/// lets self destruct if we're ignored too long
	var/plap_ignore_timer
	/// my id
	var/apid
	/// im listening
	var/plap_listening = FALSE

	// if SSinteractions.debug_store_plapper_weakref is set, this'll be our other guy
	var/datum/weakref/debug_plappee


/// Starts life with the current time as the first point of reference
/// If new'd with a plap interval, will start plapping immediately with that time
/datum/autoplapper/New(mob/living/plapper, mob/living/plappee, datum/interaction/I, plap_interval)
	. = ..()
	if(!isliving(plapper) || !isliving(plappee))
		qdel(src)
		return // one to plap, one to get plapped
	if(!plapper.ckey || !plappee.ckey)
		qdel(src)
		return // gotta have ckeys
	if(!I)
		to_chat(plapper, span_alert("hey thats not a thing!!"))
		qdel(src)
		return // gotta have a valid interaction
	if(!I.can_autoplap)
		to_chat(plapper, span_alert("You really shouldn't automate that!"))
		qdel(src)
		return // gotta have a valid interaction
	if(!I.can_do_interaction(plapper, plappee))
		qdel(src)
		return
	if(I.is_lewd)
		lewd_plap = TRUE
	plap_name = I.description
	src.plap_key = "[I.type]"
	src.plapper = plapper.ckey
	if(SSinteractions.debug_store_plapper_weakref)
		debug_plappee = WEAKREF(plappee)
	else
		src.plappee = plappee.ckey
	var/mob/living/pLapper = ckey2mob(src.plapper)
	plap_startpoint = world.time
	apid = generate_unique_id()
	if(plap_interval)
		finalize_plap(plap_interval, FALSE) // false makes it not immediately start plapping
	else
		to_chat(pLapper, span_notice("First action recorded! Perform it again to start looping that action!"))
		plap_listening = TRUE
		RegisterSignal(pLapper, COMSIG_SPLURT_INTERACTION_PITCHED,PROC_REF(check_finalized)) // quietly wait for anotehr plap of our kind
		plap_ignore_timer = addtimer(CALLBACK(src,PROC_REF(give_up)), SSinteractions.max_autoplap_interval, TIMER_CLIENT_TIME | TIMER_STOPPABLE)
	SEND_SIGNAL(pLapper, COMSIG_SPLURT_ADD_AUTOPLAPPER, src)

/datum/autoplapper/Destroy(force, ...)
	debug_plappee = null
	var/mob/living/pLapper = ckey2mob(plapper)
	if(pLapper)
		SEND_SIGNAL(pLapper, COMSIG_SPLURT_REMOVE_AUTOPLAPPER, src)
		UnregisterSignal(pLapper, COMSIG_SPLURT_INTERACTION_PITCHED) // quietly nod and back out
	. = ..()

/// We got a signal that our owner did an interaction! Let's check if it's ours
/datum/autoplapper/proc/check_finalized(datum/source, mob/living/user, mob/living/target, datum/interaction/interaction)
	if(!isliving(user) || !isliving(target) || !istype(interaction))
		return // no plapping dead people, that's just rude
	if("[interaction.type]" != "[plap_key]")
		return
	finalize_plap(world.time - plap_startpoint, TRUE) // true makes it immediately start plapping

/// We got a plap, and an interval! Let's get this party started!
/datum/autoplapper/proc/finalize_plap(interval, startnow)
	plap_listening = FALSE
	var/mob/living/pLapper = ckey2mob(plapper)
	UnregisterSignal(pLapper, COMSIG_SPLURT_INTERACTION_PITCHED) // quietly nod and back out
	deltimer(plap_ignore_timer)
	if(interval <= 0)
		qdel(src)
		return // we cant plap backwards
	interval = clamp(interval, SSinteractions.min_autoplap_interval, SSinteractions.max_autoplap_interval)
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob
	if(SSinteractions.debug_store_plapper_weakref)
		plappeemob = GET_WEAKREF(debug_plappee)
	else
		plappeemob = ckey2mob(plappee)
	if(!isliving(plappermob) || !isliving(plappeemob))
		qdel(src)
		return // well heck they died
	plap_interval = interval
	if(startnow)
		start_plapping()

/// Starts plapping!
/datum/autoplapper/proc/start_plapping()
	if(plapping_active)
		return // we're already plapping
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob
	if(SSinteractions.debug_store_plapper_weakref)
		plappeemob = GET_WEAKREF(debug_plappee)
	else
		plappeemob = ckey2mob(plappee)
	if(!can_plap())
		to_chat(plappermob, span_alert("You can't do that right now!"))
		return // we cant plap
	to_chat(plappermob, span_green("Autointeraction started! You will '[plap_name]' [plappeemob] every [DisplayTimeText(plap_interval)]! You can turn it off in the interactions menu, or by getting more than 2 tiles away from your partner."))
	COOLDOWN_START(src, last_plap, plap_interval)
	plapping_active = TRUE
	START_PROCESSING(SSautoplap, src)

/// Stops plapping!
/datum/autoplapper/proc/stop_plapping()
	if(!plapping_active)
		return // we're not plapping
	var/mob/living/plappermob = ckey2mob(plapper)
	to_chat(plappermob, span_green("Stopped!"))
	plapping_active = FALSE
	STOP_PROCESSING(SSautoplap, src)

/datum/autoplapper/proc/toggle_plapping()
	if(plapping_active)
		stop_plapping()
	else
		start_plapping()

/datum/autoplapper/proc/change_interval(interval)
	var/mob/living/plappermob = ckey2mob(plapper)
	if(interval <= SSinteractions.min_autoplap_interval)
		to_chat(plappermob, span_alert("That's too short![prob(1)?" u-u":""]"))
		return // we cant plap backwards
	if(interval > SSinteractions.max_autoplap_interval)
		to_chat(plappermob, span_alert("That's too long![prob(1)?" OwO,,":""]"))
		return // too long!
	plap_interval = round(interval, SSautoplap.wait)
	to_chat(plappermob, span_green("Autointeraction interval changed to [DisplayTimeText(plap_interval)]!"))
	COOLDOWN_START(src, last_plap, plap_interval)

/datum/autoplapper/proc/save_plap_to_prefs()
	var/mob/living/me = ckey2mob(plapper)
	if(!me)
		return // they no
	to_chat(me, span_alert("Coming soon: May 31st, 2031"))
	// var/datum/preferences/P = extract_prefs(me)
	// if(!P)
	// 	return // they nont
	// if(LAZYLEN(P.autoplappers) >= 20)
	// 	to_chat(me, span_alert("You have too many autointeraction saved!"))
	// 	return // too many!
	// var/list/plapdata = list()
	// plapdata["plap_key"] = plap_key
	// plapdata["plap_interval"] = plap_interval
	// P.autoplappers[apid] = list(plapdata)
	// P.save_preferences()
	// to_chat(me, span_green("Saved!"))

/// We're plapping! Let's do it!
/datum/autoplapper/process() // jk, gotta do the looping logic thing
	if(!COOLDOWN_FINISHED(src, last_plap))
		return // not yet!
	if(!can_plap())
		stop_plapping()
		return // we're done here
	plap() // plap!

/// Okay now lets plap!
/datum/autoplapper/proc/plap()
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob
	if(SSinteractions.debug_store_plapper_weakref)
		plappeemob = GET_WEAKREF(debug_plappee)
	else
		plappeemob = ckey2mob(plappee)
	if(!isliving(plappermob) || !isliving(plappeemob))
		return // well heck they died
	if(get_dist(plappermob, plappeemob) > 2)
		return // too far away
	var/datum/interaction/I = LAZYACCESS(SSinteractions.interactions, plap_key)
	if(!I.run_action(plappermob, plappeemob, FALSE)) // plap!
		stop_plapping()
		return // something went wrong, we cant plap
	COOLDOWN_START(src, last_plap, plap_interval)
	plap_count++
	return TRUE

/datum/autoplapper/proc/consented()
	if(!plap_key)
		return TRUE // not that anyone's plapping
	if(!lewd_plap)
		return TRUE // dont need consent to play patty cake
	var/mob/living/plappeemob
	if(SSinteractions.debug_store_plapper_weakref)
		plappeemob = GET_WEAKREF(debug_plappee)
	else
		plappeemob = ckey2mob(plappee)
	return SSinteractions.check_consent(plapper, plappeemob)

/datum/autoplapper/proc/can_plap()
	if(!plap_key)
		return FALSE // not that anyone's plapping
	if(!consented())
		return FALSE // they dont want to plap
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob
	if(SSinteractions.debug_store_plapper_weakref)
		plappeemob = GET_WEAKREF(debug_plappee)
	else
		plappeemob = ckey2mob(plappee)
	if(plappermob.incapacitated(FALSE, FALSE, TRUE, allow_crit = TRUE))
		return FALSE // they're in no shape to plap! 
	if(get_dist(plappermob, plappeemob) > 2)
		return FALSE // too far away
	return TRUE

/datum/autoplapper/proc/give_up()
	var/mob/living/plappermob = ckey2mob(plapper)
	if(plappermob)
		to_chat(plapper, span_alert("You took too long to plap!"))
	qdel(src)

/datum/autoplapper/proc/generate_unique_id()
	return "APID-[plapper]-[plappee]-[plap_key]-[world.time]-[rand(0, 1000000)]-penis"

/datum/autoplapper/proc/format_for_tgui()
	var/list/entry = list()
	entry["APApid"] = apid || "!!!"
	entry["APPlapKey"] = plap_key || "???"
	entry["APPlapName"] = plap_name || "Hold Handing"
	var/mob/living/pLapper = ckey2mob(plapper)
	entry["APPlapper"] = pLapper?.name || "Your Mom"
	var/mob/living/plappeemob
	if(SSinteractions.debug_store_plapper_weakref)
		plappeemob = GET_WEAKREF(debug_plappee)
	else
		plappeemob = ckey2mob(plappee)	
	entry["APPartner"] = plappeemob?.name || "Your Dad"
	entry["APInterval"] = plap_interval || 10 SECONDS
	entry["APPlapping"] = plapping_active || FALSE
	entry["APPlapcount"] = plap_count || 0
	entry["APRecording"] = plap_listening || FALSE
	return entry

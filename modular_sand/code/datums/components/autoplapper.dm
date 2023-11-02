/// AUTOPLAPPER 9000
/// Plaps for you, plaps for me, plaps for everyone!
/// Perfect for hands-free gaming!
////////////////////////////////////////////////////////////
#define PLAP_GIVE_UP_TIME 15 MINUTES // if you're gonna take longer than this to plap, you'll want to do it manually
/datum/autoplapper
	/// Which interaction will we be using?
	var/plap_key
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
	/// Are we currently plapping?
	var/plapping_active = FALSE
	/// lets self destruct if we're ignored too long
	var/plap_ignore_timer
	/// my id
	var/apid


/// Starts life with the current time as the first point of reference
/// If new'd with a plap interval, will start plapping immediately with that time
/datum/autoplapper/New(mob/living/plapper, mob/living/plappee, plap_key, plap_interval)
	. = ..()
	if(!isliving(plapper) || !isliving(plappee))
		qdel(src)
		return // one to plap, one to get plapped
	if(!plapper.ckey || !plappee.ckey)
		qdel(src)
		return // gotta have ckeys
	var/datum/interaction/I = LAZYACCESS(SSinteractions.interactions, plap_key)
	if(!I)
		to_chat(plapper, span_alert("hey thats not a thing!!"))
		qdel(src)
		return // gotta have a valid interaction
	if(!I.can_autoplap)
		to_chat(plapper, span_alert("You really shouldn't automate that!"))
		qdel(src)
		return // gotta have a valid interaction
	if(!I.evaluate_user(plapper, silent = TRUE, action_check = FALSE) || !I.evaluate_target(plapper, plappee, silent = TRUE))
		to_chat(plapper, span_alert("You can't plap with that! Something went wrong!"))
		qdel(src)
		return
	if(I.is_lewd) // we need a better way to detect lewd interactions
		lewd_plap = TRUE
		if(!SSinteractions.check_consent(plapper, plappee))
			to_chat(plapper, span_alert("They haven't consented yet! Maybe take em out to dinner first."))
			qdel(src)
			return
	src.plapper = plapper.ckey
	src.plappee = plappee.ckey
	src.plap_key = plap_key
	last_plap = world.time
	apid = generate_unique_id()
	if(plap_interval)
		finalize_plap(plap_interval, FALSE) // false makes it not immediately start plapping
	else
		to_chat(plapper, span_notice("First action recorded! Perform it again to start looping that action!"))
		RegisterSignal(plapper, COMSIG_SPLURT_INTERACTION_PITCHED, .proc/check_finalized) // quietly wait for anotehr plap of our kind
		plap_ignore_timer = addtimer(CALLBACK(src, .proc/give_up), PLAP_GIVE_UP_TIME, TIMER_CLIENT_TIME | TIMER_STOPPABLE)

/// We got a signal that our owner did an interaction! Let's check if it's ours
/datum/autoplapper/proc/check_finalized(datum/source, mob/living/user, mob/living/target, datum/interaction/interaction)
	if(!isliving(user) || !isliving(target) || !istype(interaction))
		return // no plapping dead people, that's just rude
	if(interaction.description != plap_key)
		return
	finalize_plap(world.time, TRUE) // true makes it immediately start plapping

/// We got a plap, and an interval! Let's get this party started!
/datum/autoplapper/proc/finalize_plap(interval, startnow)
	if(interval <= 0)
		return // we cant plap backwards
	if(interval > PLAP_GIVE_UP_TIME)
		give_up()
		return // took too long!
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob = ckey2mob(plappee)
	if(!isliving(plappermob) || !isliving(plappeemob))
		return // well heck they died
	UnregisterSignal(plapper, COMSIG_SPLURT_INTERACTION_PITCHED) // quietly nod and back out
	deltimer(plap_ignore_timer)
	plap_interval = interval
	if(startnow)
		start_plapping()

/// Starts plapping!
/datum/autoplapper/proc/start_plapping()
	if(plapping_active)
		return // we're already plapping
	var/plapname = get_plapname()
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob = ckey2mob(plappee)
	to_chat(plappermob, span_green("Autointeraction started! You will [plapname] [plappeemob] every [DisplayTimeText(plap_interval)]! You can turn it off in the interactions menu, or by getting more than 2 tiles away from your partner."))
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

/// We're plapping! Let's do it!
/datum/autoplapper/process() // jk, gotta do the looping logic thing
	if(!COOLDOWN_FINISHED(src, last_plap))
		return // not yet!
	if(should_stop_plapping())
		stop_plapping()
		return // we're done here
	plap() // plap!

/// Okay now lets plap!
/datum/autoplapper/proc/plap()
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob = ckey2mob(plappee)
	if(!isliving(plappermob) || !isliving(plappeemob))
		return // well heck they died
	if(get_dist(plappermob, plappeemob) > 2)
		return // too far away
	if(!consented())
		return // they dont want to plap
	if(plappermob.incapacitated(FALSE, FALSE, TRUE))
		return // they're in no shape to plap! not really concerned about their partner, they'll be fiiiiiiiiine
	var/datum/interaction/I = LAZYACCESS(SSinteractions.interactions, plap_key)
	if(!I.can_do_interaction(plappermob, plappeemob, silent = FALSE))
		return // something went wrong, we cant plap
	I.run_action(plappermob, plappeemob, TRUE) // plap!
	COOLDOWN_START(src, last_plap, plap_interval)
	plap_count++
	return TRUE

/datum/autoplapper/proc/get_plapname()
	if(!plap_key)
		return "plap"
	var/datum/interaction/I = LAZYACCESS(SSinteractions.interactions, plap_key)
	return I.description

/datum/autoplapper/proc/consented()
	if(!plap_key)
		return TRUE // not that anyone's plapping
	if(!lewd_plap)
		return TRUE // dont need consent to play patty cake
	return SSinteractions.check_consent(plapper, plappee)

/datum/autoplapper/proc/should_stop_plapping()
	if(!consented())
		return TRUE // they dont want to plap
	if(!plap_key)
		return TRUE // not that anyone's plapping
	var/mob/living/plappermob = ckey2mob(plapper)
	var/mob/living/plappeemob = ckey2mob(plappee)
	if(plappermob.incapacitated(FALSE, FALSE, TRUE))
		return TRUE // they're in no shape to plap! 
	if(get_dist(plappermob, plappeemob) > 2)
		return TRUE // too far away
	return FALSE

/datum/autoplapper/proc/give_up()
	var/mob/living/plappermob = ckey2mob(plapper)
	if(plappermob)
		to_chat(plapper, span_alert("You took too long to plap!"))
	qdel(src)

/datum/autoplapper/proc/generate_unique_id()
	return "APID-[plapper]-[plappee]-[plap_key]-[world.time]-[rand(0, 1000000)]-penis"

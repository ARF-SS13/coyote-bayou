
/* 
 * MERP COMPONENT FOR MOBS
 * Allows someone to participate in mechanical roleplay!
 */

// Oh yeah, with this, after this, master will be a var that is the parent
#define MERP_MASTER var/mob/living/master = parent
/// FLOORRRR MASTERRRRRR yeah nobody's gonna get that but me

/datum/component/merp // MEchanical RolePlay
	/// We merpin?
	var/merp_mode = FALSE
	/// People whitelisted to merp with us any time~
	var/list/merp_whitelist = list()
	/// Our box of MERPI bits
	var/obj/item/storage/merpsack/merp_bits = list()
	var/plap_history_length = MERP_PLAP_HISTORY_LENGTH
	/// Actions performed to us
	/// Format: list(datum/plap_record, datum/plap_record, datum/plap_record)
	var/list/plapped_history = list()
	/// Actions performed by us
	/// Format: list(datum/plap_record, datum/plap_record, datum/plap_record)
	var/list/plap_history = list()
	/// My arousal!
	var/arousal = 0 // jk, its erp
	/// My arousal limit!
	var/arousal_limit = MERP_MAX_AROUSAL
	/// How much arousal we gain per second, on default speed
	var/arousal_gain_per_tick
	/// How much arousal we lose per second, on default speed
	var/arousal_loss_per_tick
	/// our arousal datums
	var/list/arousal_datums = list()
	/// Autoemote cooldown
	/// Autoplapper vars!
	/// Are we autoplapping?
	var/autoplapper_active = FALSE
	/// Our autoplappers!
	var/list/autoplappers = list()
	/// Are we paused?
	var/paused = FALSE
	/// Participants in our little sexcapade
	var/list/participants = list()
	/// Combos built with each of our participants
	/// its gonna be a list of datums, cus we're gonna have to store the combo and the participants
	/// format: list(datum/merp_combo, datum/merp_combo, datum/merp_combo)
	var/list/combos = list()
	/// Our combo score!
	var/combo_score = 1


/datum/component/merp/Initialize()
	if(!SSmerp.should_merp(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_MOB_CLIENT_LOGIN),PROC_REF(setup_merp))
	RegisterSignal(parent, list(COMSIG_MERP_GIVE_MERP_INITIATOR),PROC_REF(give_initiator))
	RegisterSignal(parent, list(COMSIG_MERP_GIVE_HAND_BIT),PROC_REF(give_merp_item))
	RegisterSignal(parent, list(COMSIG_MERP_DO_PLAP),PROC_REF(plap))
	RegisterSignal(parent, list(COMSIG_MERP_GET_PLAPPED),PROC_REF(get_plapped))
	RegisterSignal(parent, list(COMSIG_MERP_KILL_COMBO),PROC_REF(combo_died)) // ):
	RegisterSignal(parent, list(COMSIG_MERP_PLAP_EXPIRED),PROC_REF(plap_died)) // ):
	RegisterSignal(parent, list(COMSIG_MERP_GET_OTHER_COMBOS),PROC_REF(get_combos))
	START_PROCESSING(SSmerp, src)
	setup_merp()

/datum/component/merp/UnregisterFromParent()
	STOP_PROCESSING(SSmerp, src)
	QDEL_NULL(merp_bits)
	QDEL_LIST(plapped_history)
	QDEL_LIST(plap_history)
	QDEL_LIST(arousal_datums)
	QDEL_LIST(autoplappers)
	participants.Cut()
	QDEL_LIST(combos)
	. = ..()

/datum/component/merp/proc/setup_merp()
	MERP_MASTER
	if(!load_prefs(master))
		to_chat(master,span_phobia("ERROR: You seem to have saved MERP prefs, but they couldn't be loaded."))
	calculate_arousal_formula()
	populate_arousal_datums()

/datum/component/merp/proc/calculate_arousal_formula()
	MERP_MASTER
	var/time_per_tick = SSmerp.wait
	arousal_gain_per_tick = (MERP_MAX_AROUSAL / MERP_TIME_TO_CUM_BASE) * time_per_tick * MERP_AROUSAL_GAIN_FACTOR
	arousal_loss_per_tick = (MERP_MAX_AROUSAL / MERP_TIME_TO_CUM_BASE) * time_per_tick * MERP_AROUSAL_GAIN_FACTOR

/datum/component/merp/proc/populate_arousal_datums()
	MERP_MASTER
	for(var/aro in MERP_AROUSAL_BREAKPOINTS)
		var/datum/merp_arousal/arouse = new(text2num(aro))
		arousal_datums[aro] = new()

/datum/component/merp/proc/give_merp_initiator()
	MERP_MASTER
	if(isanimal(master))
		var/mob/living/simple_animal/merpimal = master
		if(!merpimal.dextrous)
			var/urnotdextrous = "You aren't dextrous enough to MERP!"
			switch(rand(1,6))
				if(1)
					urnotdextrous += " You might break something sensitive!"
				if(2)
					urnotdextrous += " Come back when you're a little... mmm... handier."
				if(3)
					urnotdextrous += " Maybe you should try again when you're a little more... dextrous."
				if(4)
					urnotdextrous += " You can, however, talk about your feelings!"
				if(5)
					urnotdextrous += " Maybe you can just be friends?"
				if(6)
					urnotdextrous += " You can watch, though!"
			to_chat(master, span_warning("You aren't dextrous enough to MERP! You might break something sensitive!"))
			return

	if(master.get_active_held_item())
		to_chat(master, span_warning("Your hands are too full to hold any MERPversations!"))
		return
	var/obj/item/hand_item/merp_initiator/MERPINIT = new(master)
	if(!master.put_in_active_hand(MERPINIT))
		to_chat(master, span_warning("You couldn't get the MERPversationer out?"))
		qdel(MERPINIT)

/// SEE [modular_coyote\code\modules\mechanical_erp\merp_preferences.dm] for save/load code

/datum/component/merp/process()
	merp_loop()

/datum/component/merp/proc/merp_loop()
	if(!merp_mode)
		reset_merp()
		return
	MERP_MASTER
	if(autoplapper_active)
		autoplap()
	handle_arousal()

/datum/component/merp/proc/autoplap()
	for(var/datum/merp_autoplap/plapper in autoplappers)
		plapper.autoplap() // plap plap plap

/// Automatic arousal handling
/datum/component/merp/proc/handle_auto_arousal()
	MERP_MASTER
	if(!paused)
		if(last_plap_still_fresh())
			adjust_arousal(arousal_gain_per_tick)
		else
			adjust_arousal(-arousal_loss_per_tick)

/datum/component/merp/proc/adjust_arousal(amount)
	arousal = clamp(arousal + amount, 0, arousal_limit)
	if(arousal >= MERP_AROUSAL_NEAR_CLIMAX)
		can_climax(TRUE)
	else
		can_climax(FALSE)
	var/datum/merp_arousal/arouse = get_arousal_datum()
	if(arouse)
		arouse.express_arousal()
	return TRUE
	
/datum/component/merp/proc/get_arousal_datum()
	MERP_MASTER
	var/datum/merp_arousal/arouse = LAZYACCESS(arousal_datums, "[MERP_AROUSAL_MIN]")
	for(var/aro in arousal_datums)
		var/aro_num = text2num(aro)
		if(arousal >= aro_num)
			arouse = arousal_datums[aro]
		else
			break
	return arouse

/datum/component/merp/proc/give_merp_item(datum/source, merpi_key)
	SIGNAL_HANDLER
	if(!merpi_key)
		return
	MERP_MASTER
	if(master.get_active_held_item() && master.get_inactive_held_item())
		to_chat(master, span_alert("Your hands are full!"))
		return
	var/obj/item/merpi_bit/bit = new(master)
	if(!master.put_in_hands(bit, TRUE))
		to_chat(master, span_alert("You couldn't get it in your hand!"))
		return
	if(!merpify(bit, merpi_key))
		to_chat(master, span_phobia("Merpification failed! Call a coder!"))
		stack_trace("Merpification failed! [master] tried to merpify [bit] with key [merpi_key].")
		qdel(bit)
		return
	to_chat(master, span_love("You ready your [bit]!"))
	return TRUE

/datum/component/merp/proc/merpify(obj/item/merpi_bit/bit, merpi_key)
	MERP_MASTER
	if(!isliving(master))
		message_admins(span_phobia("MERP ERROR: [master] is not living! Key is [merpi_key]! PANIC!"))
		CRASH("MERP ERROR: [master] is not living! Key is [merpi_key]! PANIC!")
		return
	if(!SSmerp.merpify_item(bit, master, merpi_key))
		CRASH("MERP ERROR: [master] tried to merpify [bit] with key [merpi_key], but it failed!")
	return TRUE

/* 
 * Makes the owner plap the target with the given intent.
 * * datum/source - The source of the plap. Just a formality of signals, not actually relied on.
 * * mob/living/plapper - The mob doing the plapping.
 * * mob/living/plapped - The mob being plapped.
 * * obj/item/merpi_bit/plapped_part - The part of the plapped that is being plapped.
 * * plapper_key - The key of the plapper.
 * * intent - The intent of the plap.
 * * wielded - Whether or not the plapper is wielding the plapped part.
 * * quality - The quality of the plap.
 * * ci - The CI of the plap.
 */
/datum/component/merp/proc/plap(datum/source, mob/living/plappee, user_bit_key, target_bit_key, intent, wielded, quality = MERP_QUALITY_NORMAL, ci)
	SIGNAL_HANDLER
	MERP_MASTER
	if(!isliving(plappee) || !user_bit_key || !target_bit_key)
		return
	if(isnull(intent))
		intent = master.a_intent
	if(isnull(wielded))
		var/obj/item/bit = master.get_active_held_item()
		if(!bit)
			wielded = FALSE // fuck it whatever
		else
			wielded = bit.wielded
	var/merp_message = SSmerp.get_plap_line(master, plappee, user_bit_key, target_bit_key, intent, wielded, quality, ci)
	if(!merp_message) // no message, didnt happen
		return
	do_merp_message(merp_message)
	var/merp_sound = SSmerp.get_plap_sound(master, plappee, user_bit_key, target_bit_key, intent, wielded, quality, ci)
	if(merp_sound)
		do_merp_sound(master, plappee, merp_sound)

	var/datum/plap_record/placord = record_plap(master, plappee, user_bit_key, target_bit_key, intent, wielded, quality, ci)
	SEND_SIGNAL(plappee, COMSIG_MERP_GET_PLAPPED, master, user_bit_key, target_bit_key, intent, wielded, quality, ci)
	handle_mutual_arousal(master, plappee, placord)
	return TRUE

/// The plapper does all the work calculating and compiling the plap after-report, they *are* topping here after all
/datum/component/merp/proc/get_plapped(datum/source, mob/living/plapper, datum/merp_plap_record/placord)
	SIGNAL_HANDLER
	MERP_MASTER
	if(!isliving(plapper))
		CRASH("Non-living passed to get_plapped!! [plapper], [placord]!")
	if(!istype(placord))
		CRASH("Non-plap_record passed to get_plapped!! [plapper], [placord]!")

	var/datum/plap_record/placord = record_plap(plapper, master, placord.user_bit_key, placord.target_bit_key, placord.intent, placord.wielded, placord.quality, placord.ci)
	// Plappy Daddy will tell me how aroused I got from the plap
	return TRUE

/datum/component/merp/proc/record_plap(mob/living/plapper, mob/living/plappee, user_bit_key, target_bit_key, intent = INTENT_HELP, wielded = FALSE, quality = MERP_QUALITY_NORMAL, ci = FALSE)
	if(!isliving(plapper) || !isliving(plappee))
		return
	if(!user_bit_key || !target_bit_key)
		return
	MERP_MASTER
	var/datum/plap_record/placord = new(plapper, plappee, user_bit_key, target_bit_key, intent, wielded, quality, ci)
	if(plapper == master)
		plap_records |= placord
	else
		plapped_records |= placord
	update_plap_combos(plapper, placord)
	return TRUE

/datum/component/merp/proc/do_merp_sound(mob/living/plapper, mob/living/plappee, user_bit_key, target_bit_key, intent = INTENT_HELP, wielded = FALSE, quality = MERP_QUALITY_NORMAL, ci = FALSE)


/* 
 * Calculates and distributes mutual arousal between the plapper and plappee.
 * Factors in things like combos, whether plaps are still fresh, etc
 * * mob/living/plapper - The mob doing the plapping.
 * * mob/living/plappee - The mob being plapped.
 * * datum/plap_record/placord - The plap that happened.
 */
/datum/component/merp/proc/handle_mutual_arousal(mob/living/plapper, mob/living/plappee, datum/plap_record/placord)
	if(!plapper || !placord)
		return FALSE
	var/arousal_out = MERP_AROUSAL_PER_PLAP_BASE
	var/combo_mult = get_combo_multiplier(plapper, plappee, placord)
	var/extra_score = get_extra_score(plapper, plappee, placord)
	var/arousal_out = (arousal_out * combo_mult) + extra_score
	adjust_arousal(arousal_out)
	return TRUE

/datum/component/merp/proc/update_plap_combos(mob/living/plapper, datum/plap_record/placord)
	if(!plapper || !placord)
		return FALSE
	MERP_MASTER
	if(plapper != master)
		return FALSE // We only care about our combos
	/// first, run through our plap history and check for more combos
	var/list/streak = list()
	plapsteak:
		for(var/datum/weakref/plap_record in plap_history)
			var/datum/merp_plap_record/plap_record = RESOLVEWEAKREF(plap_record)
			if(!plap_record)
				plap_history -= plap_record
				continue
			if(!plap_record.plap_still_fresh())
				plap_history -= plap_record
				continue
			if(LAZYLEN(plap_record.plap_combo))
				continue // Already part of a combo
			if(!record_is_relevant(placord, plap_record))
				continue // Not relevant to the current plap
			if(!LAZYLEN(streak)) // Start a new streak
				streak += plap_record
				continue
			for(var/datum/plap_record/streak_record in streak)
				if(compare_plap_records(plap_record, streak_record)) // If they're the same, add it to the streak
					streak += plap_record
					break
				/// The plap is different, so we need to check if we have enough to make a combo
				if(LAZYLEN(streak) >= MERP_STREAK_MINIMUM)
					/// We have ourselves a combo!
					var/datum/merp_combo/combo = new(master, plappee, streak, placord)
					streak.Cut()
					update_combo_values()
					return TRUE // We've got enough, stop looking
				/// Too short for a combo, so we'll just start over
				streak.Cut()
				break

/// Runs through all the combos, updating their values based on uniqueness
/datum/component/merp/proc/update_combo_values()
	MERP_MASTER
	/// First, determine the combos' uniqueness
	for(var/datum/merp_combo/combo in combos)
		if(!combo_is_relevant(combo, master, plappee))
			continue
		combo.adjusted_value = combo.value
		combo.adjusted_value *= combo_uniqueness(plapper, plappee, combo)
	return TRUE

/datum/component/merp/proc/combo_uniqueness(mob/living/plapper, mob/living/plappee, datum/merp_combo/combo)
	var/mult_out = 1	
	var/unique_combos = 0
	var/total_combos = 0
	for(var/datum/merp_combo/combo in combos)
		if(!combo_is_relevant(plapper, combo))
			continue
		total_combos++
		for(var/datum/weakref/record in combo.plap_combo)
			var/datum/merp_plap_record/plap_record = RESOLVEWEAKREF(record)
			if(!plap_record)
				continue



			/// First, check the finishers
			var/datum/merp_plap_record/true_finisher = RESOLVEWEAKREF(finisher)
			var/datum/merp_plap_record/other_finisher = RESOLVEWEAKREF(plap_record.finisher)
			if(!)
			value += finisher_power(true_finisher, other_finisher)

/datum/component/merp/proc/get_combo_multiplier(datum/plap_record/placord, datum/plap_record/plap_record)
	/// Okay, combos updated, lets tally the scores
	var/current_combo = 0
	var/extra_score = 0
	var/list/relevant_combos = list()
	/// First run through our combos and see if they're still good, and collect their score
	for(var/datum/merp_combo/combo in combos)
		if(!combo_is_relevant(plapper, combo))
			continue
		var/points = combo.combo_still_fresh()
		current_combo += points
		if(points)
			relevant_combos += combo
	extra_score = combo_uniqueness(plapper, plappee)






/// We're only interested in combos that our plapper did, doesnt matter who they did it to
/datum/component/merp/proc/combo_is_relevant(mob/living/plapper, datum/merp_combo/this_combo)
	if(!other_combo)
		return FALSE
	if(other_combo == src)
		return FALSE
	var/mob/living/other_plapper = RESOLVEWEAKREF(other_combo.plapper)
	if(!other_plapper)
		return FALSE
	if(my_plapper != other_plapper || my_plappee != other_plappee)
		return FALSE
	return TRUE

/// Technically, since the vars are the same between the combo and record's plapper/plappee, we could just use one proc
/// That's how Goon made power cells work in both energy weapons, and mining tools, without components or anything
/// Its also something Pali told me was a very, very, very bad idea and I should never do it
/// So, I'm not doing it
/// Checks if one plap record is relevant to another, for the purposes of combos
/// A combo needs to be made up of records relating between the same two people
/datum/component/merp/proc/record_is_relevant(datum/merp_plap_record/my_plap_record, datum/plap_record/other_plap_record)
	if(!my_plap_record || !other_plap_record)
		return FALSE
	var/mob/living/my_plapper = RESOLVEWEAKREF(my_plap_record.plapper)
	var/mob/living/my_plappee = RESOLVEWEAKREF(my_plap_record.plappee)
	if(!my_plapper || !my_plappee)
		return FALSE
	var/mob/living/other_plapper = RESOLVEWEAKREF(other_plap_record.plapper)
	var/mob/living/other_plappee = RESOLVEWEAKREF(other_plap_record.plappee)
	if(!other_plapper || !other_plappee)
		return FALSE
	if(my_plapper != other_plapper || my_plappee != other_plappee)
		return FALSE
	MERP_MASTER
	if(my_plapper != master)
		return FALSE // We somehow didnt do this plap
	return TRUE

/datum/merp_combo/proc/finisher_power(datum/merp_plap_record/finisher, datum/merp_plap_record/other_finisher)
	if(!finisher || !other_finisher)
		return 0
	. = 0
	. += plaps_are_different(true_finisher, other_finisher)
	. += check_ci(true_finisher, other_finisher)
	. += check_intent(true_finisher, other_finisher)
	return

/datum/merp_combo/proc/plaps_are_different(datum/merp_plap_record/true_finisher, datum/merp_plap_record/other_finisher)
	if(!true_finisher || !other_finisher)
		return FALSE
	if(true_finisher.key != other_finisher.key)
		return TRUE
	if(true_finisher.intent != other_finisher.intent)
		return TRUE
	if(true_finisher.quality != MERP_QUALITY_REPEAT && other_finisher.quality != MERP_QUALITY_REPEAT && true_finisher.quality != other_finisher.quality)
		return TRUE
	return FALSE


	var/difference = 0
	if(true_finisher.key != other_finisher.key)
		difference += MERP_COMBO_FINISHER_DIFFERENT_KEYS
	if(true_finisher.intent != other_finisher.intent)
		difference += MERP_COMBO_FINISHER_DIFFERENT_INTENTS
	if(true_finisher.quality != MERP_QUALITY_REPEAT && other_finisher.quality != MERP_QUALITY_REPEAT && true_finisher.quality != other_finisher.quality)
		difference += MERP_COMBO_FINISHER_DIFFERENT_QUALITIES
	return difference




/datum/component/merp/proc/get_combos(datum/source, list/want_combos)
	SIGNAL_HANDLER
	if(!istype(want_combos))
		CRASH("MERP ERROR: [want_combos] is not a list!")
	for(var/datum/merp_combo/combo in combos)
		if(combo.combo_still_fresh())
			want_combos += combo
	return TRUE

/datum/component/merp/proc/combo_died(datum/source, datum/merp_combo/deadbo)
	SIGNAL_HANDLER
	if(!istype(deadbo))
		CRASH("MERP ERROR: [deadbo] is not a combo!")
	if(!(deadbo in combos))
		return
	combos -= deadbo
	qdel(deadbo)
	return TRUE

/datum/component/merp/proc/plap_died(datum/source, datum/plap_record/deadcord)
	SIGNAL_HANDLER
	if(!istype(deadcord))
		CRASH("MERP ERROR: [deadcord] is not a plap!")
	if(deadcord in plapped_history)
		plapped_history -= deadcord
	if(deadcord in plapper_history)
		plapper_history -= deadcord
	qdel(deadcord)
	return TRUE

/// A datum that inflicts a plap when asked
/datum/merp_autoplap
	var/coolname = "plap"
	var/datum/weakref/owner
	var/datum/weakref/target
	var/key
	var/intent
	var/wielded
	var/delay
	COOLDOWN_DECLARE(plap_cooldown)

/datum/merp_autoplap/New(mob/owner, mob/target, key, intent, wielded, delay)
	src.owner = WEAKREF(owner)
	src.target = WEAKREF(target)
	src.key = key
	src.intent = intent
	src.wielded = wielded
	src.delay = delay

/datum/merp_autoplap/proc/can_plap()
	var/mob/my_owner = RESOLVEWEAKREF(owner)
	var/mob/my_target = RESOLVEWEAKREF(target)
	if(!my_owner || !my_target)
		return FALSE
	return COOLDOWN_FINISHED(src, plap_cooldown)

/datum/merp_autoplap/proc/autoplap()
	if(!can_plap())
		return
	var/mob/my_owner = RESOLVEWEAKREF(owner)
	var/mob/my_target = RESOLVEWEAKREF(target)
	if(!my_owner || !my_target)
		return MERP_AP_DELETEME
	SEND_SIGNAL(my_owner, COMSIG_MERP_DO_PLAP, my_target, key, intent, wielded, MERP_QUALITY_REPEAT, FALSE)
	COOLDOWN_START(src, plap_cooldown, delay)

/// A record of a combo with a specific person
/datum/merp_combo
	var/datum/weakref/owner
	var/datum/weakref/target
	/// List of plaps in our combo
	/// Also makes them unusable in other combos
	/// format: list(datum/merp_plap_record, datum/merp_plap_record, ...)
	/// They're all weakrefs lol
	var/list/plap_combo
	/// The finisher of the combo
	/// Allows it to be used in other combos
	var/datum/weakref/finisher
	/// The time the combo was started
	var/start_time = 0
	/// How much the combo is worth
	var/value = 0
	/// How much the combo is worth, adjusted for externap values
	var/adjusted_value = 0

/datum/merp_combo/New(mob/living/plapper, mob/living/plappee, list/plaps, datum/merp_plap_record/finisher)
	. = ..()
	if(!isliving(plapper) || !isliving(plappee) || !LAZYLEN(plaps) || !finisher)
		qdel(src)
		return
	if(!istype(finisher))
		stack_trace("MERP ERROR: [finisher] is not a plap record!")
		qdel(src)
		return
	src.plapper = WEAKREF(plapper)
	src.plappee = WEAKREF(plappee)
	src.plap_combo = plaps
	src.finisher = WEAKREF(finisher)
	for(var/datum/merp_plap_record/plap in plaps) // but, not the finisher
		plap.is_in_combo.used_in_combo(src)
	calculate_value(plapper, plappee, plaps, finisher)
	start_time = world.time

/datum/merp_combo/Destroy(...)
	var/mob/living/my_plapper = RESOLVEWEAKREF(plapper)
	var/mob/living/my_plappee = RESOLVEWEAKREF(plappee)
	if(my_plapper)
		SEND_SIGNAL(my_plapper, COMSIG_MERP_KILL_COMBO, src)
	if(my_plappee)
		SEND_SIGNAL(my_plappee, COMSIG_MERP_KILL_COMBO, src)
	for(var/plap in plap_combo)
		var/datum/merp_plap_record/plap_record = RESOLVEWEAKREF(plap)
		if(plap_record)
			plap_record.combo = null
	plap_combo.Cut()
	if(finisher)
		var/datum/merp_plap_record/plap_record = RESOLVEWEAKREF(finisher)
		if(plap_record)
			plap_record.combo = null
	finisher.Cut()
	. = ..()

/datum/merp_combo/proc/combo_still_fresh()
	if(!isliving(plapper) || !isliving(plappee))
		qdel(src)
		return FALSE
	if(world.time - start_time > MERP_PLAP_COMBO_TIME)
		qdel(src)
		return FALSE
	return value

/datum/merp_combo/proc/calculate_value(mob/living/plapper, mob/living/plappee, list/plaps, datum/merp_plap_record/finisher)
	if(!plapper || !plappee || !LAZYLEN(plaps) || !finisher)
		qdel(src)
		return
	value = 1
	if(finisher.manual_execution)
		value += MERP_COMBO_MANUAL_BONUS
	if(LAZYLEN(plaps) > MERP_MIN_PLAPS_FOR_COMBO)
		value += (LAZYLEN(plaps) / MERP_MIN_PLAPS_FOR_COMBO) // 4 plap combo = +1.33
	return TRUE

/// If one of our plaps expired, so do we!
/datum/merp_combo/proc/plap_expired(datum/merp_plap_record/plap_record)
	if(!plap_record)
		return FALSE
	var/datum/merp_plap_record/finisher = RESOLVEWEAKREF(plap_record.finisher)
	if(finisher && finisher == plap_record)
		qdel(src)
		return
	for(var/datum/weakref/record in plap_combo)
		var/datum/merp_plap_record/other_plap_record = RESOLVEWEAKREF(record)
		if(!other_plap_record)
			continue
		if(other_plap_record == plap_record)
			qdel(src)
			return

/// A record of a plap someone made to its owner.
/datum/merp_plap_record
	var/datum/weakref/plapper
	var/datum/weakref/plappee
	var/key
	var/intent
	var/quality
	var/ci
	var/manual_execution
	/// Prevents this plap from being used in other combos
	var/datum/weakref/combo
	var/time_plapped = 0

/datum/merp_plap_record/New(mob/living/plapper, mob/living/plappee, key, intent, quality, ci, manual_execution)
	. = ..()
	if(!isliving(meatwall))
		qdel(src)
		return
	src.plapper = WEAKREF(plapper)
	src.plappee = WEAKREF(plappee)
	src.key = key
	src.intent = intent
	src.quality = quality
	src.ci = ci
	src.manual_execution = manual_execution

/datum/merp_plap_record/proc/Destroy(...)
	var/mob/living/my_plapper = RESOLVEWEAKREF(plapper)
	var/mob/living/my_plappee = RESOLVEWEAKREF(plappee)
	if(my_plapper)
		SEND_SIGNAL(plapper, COMSIG_MERP_PLAP_EXPIRED, src)
	if(my_plappee)
		SEND_SIGNAL(plappee, COMSIG_MERP_PLAP_EXPIRED, src)
	plapper = null
	plappee = null
	var/datum/merp_combo/my_combo = RESOLVEWEAKREF(combo)
	if(my_combo)
		QDEL_NULL(my_combo) // a combo canot exist with an expired plap!
	. = ..()

/datum/merp_plap_record/proc/record_plap(mob/living/plapper, mob/living/plappee, key, intent, quality, ci)
	if(!isliving(plapper) || !isliving(plapped) || !key || !intent)
		return
	plapper = WEAKREF(plapper)
	plappee = WEAKREF(plappee)
	src.key = key
	src.intent = intent
	src.quality = quality
	src.ci = ci
	time_plapped = world.time
	return TRUE

/datum/merp_plap_record/proc/plap_still_fresh()
	if(!plapper || !plappee)
		qdel(src)
		return FALSE
	if(time_plapped + MERP_PLAP_FRESH_TIME > world.time)
		return TRUE
	qdel(src)

/datum/merp_plap_record/proc/used_in_combo(datum/merp_combo)
	combo = WEAKREF(combo)
	return TRUE

/// Holds the various moans and emotes that our mob should do when aroused.
/datum/merp_arousal
	var/datum/weakref/owner
	var/list/emote_list
	var/emote_cooldown
	COOLDOWN_DECLARE(emote_cd)
	var/list/moan_list
	var/moan_cooldown
	COOLDOWN_DECLARE(moan_cd)

/datum/merp_arousal/New(
	mob/owner,
	list/emote_list = list(),
	emote_cooldown,
	list/moan_list = list(),
	moan_cooldown
)
	. = ..()
	src.owner = WEAKREF(owner)
	src.emote_list = emote_list
	src.emote_cooldown = emote_cooldown

/datum/merp_arousal/Destroy(force, ...)
	owner = null
	. = ..()

/datum/merp_arousal/proc/express_arousal()
	do_moan()
	do_emote()

/datum/merp_arousal/proc/can_emote()
	var/mob/my_owner = RESOLVEWEAKREF(owner)
	if(!my_owner)
		return FALSE
	return COOLDOWN_FINISHED(src, emote_cd)

/datum/merp_arousal/proc/do_emote()
	if(!can_emote())
		return
	COOLDOWN_START(src, emote_cd, (emote_cooldown + (rand(emote_cooldown*0.5, emote_cooldown*1.5))))
	var/mob/my_owner = RESOLVEWEAKREF(owner)
	if(!my_owner)
		return
	var/emote = pick(emote_list)
	if(!emote)
		return
	my_owner.emote(emote)
	return TRUE

/datum/merp_arousal/proc/can_moan()
	var/mob/my_owner = RESOLVEWEAKREF(owner)
	if(!my_owner)
		return FALSE
	return COOLDOWN_FINISHED(src, moan_cd)

/datum/merp_arousal/proc/do_moan()
	if(!can_moan())
		return
	COOLDOWN_START(src, moan_cd, (moan_cooldown + (rand(moan_cooldown*0.5, moan_cooldown*1.5))))
	var/mob/my_owner = RESOLVEWEAKREF(owner)
	if(!my_owner)
		return
	var/moan = pick(moan_list)
	if(!moan)
		return
	MERP_MOAN_SOUND(my_owner, moan, 75, TRUE)
	return TRUE

/mob/living/verb/open_merpventory()
	set name = "MERP Inventory"
	set desc = "Pull open your drawers and take stock of your MERPIs!"

	SEND_SIGNAL(src, COMSIG_MERP_OPEN_MERPVENTORY)

/mob/living/verb/open_merp_menu()
	set name = "MERP Menu"
	set desc = "Open the MERP menu!"

	SEND_SIGNAL(src, COMSIG_MERP_OPEN_MERP_MENU)

/mob/living/verb/give_merp_initiator()
	set name = "MERP Initiator"
	set desc = "Give yourself a thing to invite others to your MERP party!"

	SEND_SIGNAL(src, COMSIG_MERP_GIVE_MERP_INITIATOR)

//brick//
/datum/emote/living/merper
	key = "letsmerp"
	key_third_person = "letsmerps"
	restraint_check = TRUE

/datum/emote/living/carbon/bricker/run_emote(mob/user)
	. = ..()
	SEND_SIGNAL(src, COMSIG_MERP_GIVE_MERP_INITIATOR)

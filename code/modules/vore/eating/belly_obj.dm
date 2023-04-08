#define VORE_SOUND_FALLOFF 0.1
#define VORE_SOUND_RANGE 3

//
//  Belly system 2.0, now using objects instead of datums because EH at datums.
//	How many times have I rewritten bellies and vore now? -Aro
//

// If you change what variables are on this, then you need to update the copy() proc.
// 
// Most of the internal logic is handled by the vore component
// So most of the signals sent to this, will be sent to it instead
//
// Parent type of all the various "belly" varieties.
//
/obj/vore_belly
	name = "belly"							// Name of this location
	desc = "It appears to be rather warm and wet. Makes sense, considering the fact it's a belly."	// Flavor text description of inside sight/sound/smells/feels.
	rad_flags = RAD_NO_CONTAMINATE | RAD_PROTECT_CONTENTS
	var/vore_sound = "Gulp"					// Sound when ingesting someone
	var/vore_verb = "ingest"				// Verb for eating with this in messages
	var/release_sound = "Splatter"			// Sound for letting someone out.
	var/emote_time = 60 SECONDS				// How long between stomach emotes at prey
	var/digest_brute = 2					// Brute damage per tick in digestion mode
	var/digest_burn = 2						// Burn damage per tick in digestion mode
	var/immutable = FALSE					// Prevents this belly from being deleted
	var/escapable = TRUE					// Belly can be resisted out of at any time
	var/escapetime = 20 SECONDS				// Deciseconds, how long to escape this belly
	var/digestchance = 0					// % Chance of stomach beginning to digest if prey struggles
	var/absorbchance = 0					// % Chance of stomach beginning to absorb if prey struggles
	var/escapechance = 0 					// % Chance of prey beginning to escape if prey struggles.
	var/can_taste = FALSE					// If this belly prints the flavor of prey when it eats someone.
	var/bulge_size = 0.25					// The minimum size the prey has to be in order to show up on examine.
//	var/shrink_grow_size = 1				// This horribly named variable determines the minimum/maximum size it will shrink/grow prey to.

	var/transferlocation					// Location that the prey is released if they struggle and get dropped off.
	var/transferchance = 0 					// % Chance of prey being transferred to transfer location when resisting
	var/autotransferchance = 0 				// % Chance of prey being autotransferred to transfer location
	var/autotransferwait = 10 				// Time between trying to transfer.
	var/swallow_time = 10 SECONDS			// for mob transfering automation
	var/vore_capacity = 1					// simple animal nom capacity
	var/is_wet = TRUE						// Is this belly inside slimy parts?
	var/wet_loop = TRUE						// Does this belly have a slimy internal loop?

	//I don't think we've ever altered these lists. making them static until someone actually overrides them somewhere.
	var/static/list/digest_modes = list(DM_HOLD,DM_DIGEST,DM_HEAL,DM_NOISY,DM_ABSORB,DM_UNABSORB)	// Possible digest modes

	var/datum/weakref/owner					// The mob whose belly this is.
	var/digest_mode = DM_HOLD				// Current mode the belly is set to from digest_modes (+transform_modes if human)
	var/datum/looping_sound/vore_heartbeat/heartbeat_loop
	var/datum/looping_sound/vore_squish/squish_loop
	/// Next time vore sounds get played for the prey, do not change manually as it is intended to be set automatically
	COOLDOWN_DECLARE(prey_sound_cooldown)
	COOLDOWN_DECLARE(voremote_cooldown)

	// Don't forget to watch your commas at the end of each line if you change these.
	var/list/struggle_messages_outside = list(
		"%pred's %belly wobbles with a squirming meal.",
		"%pred's %belly jostles with movement.",
		"%pred's %belly briefly swells outward as someone pushes from inside.",
		"%pred's %belly fidgets with a trapped victim.",
		"%pred's %belly jiggles with motion from inside.",
		"%pred's %belly sloshes around.",
		"%pred's %belly gushes softly.",
		"%pred's %belly lets out a wet squelch.")

	var/list/struggle_messages_inside = list(
		"Your useless squirming only causes %pred's slimy %belly to squelch over your body.",
		"Your struggles only cause %pred's %belly to gush softly around you.",
		"Your movement only causes %pred's %belly to slosh around you.",
		"Your motion causes %pred's %belly to jiggle.",
		"You fidget around inside of %pred's %belly.",
		"You shove against the walls of %pred's %belly, making it briefly swell outward.",
		"You jostle %pred's %belly with movement.",
		"You squirm inside of %pred's %belly, making it wobble around.")

	var/list/digest_messages_owner = list(
		"You feel %prey's body succumb to your digestive system, which breaks it apart into soft slurry.",
		"You hear a lewd glorp as your %belly muscles grind %prey into a warm pulp.",
		"Your %belly lets out a rumble as it melts %prey into sludge.",
		"You feel a soft gurgle as %prey's body loses form in your %belly. They're nothing but a soft mass of churning slop now.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your thighs.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your rump.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your belly.",
		"Your %belly groans as %prey falls apart into a thick soup. You can feel their remains soon flowing deeper into your body to be absorbed.",
		"Your %belly kneads on every fiber of %prey, softening them down into mush to fuel your next hunt.",
		"Your %belly churns %prey down into a hot slush. You can feel the nutrients coursing through your digestive track with a series of long, wet glorps.")

	var/list/digest_messages_prey = list(
		"Your body succumbs to %pred's digestive system, which breaks you apart into soft slurry.",
		"%pred's %belly lets out a lewd glorp as their muscles grind you into a warm pulp.",
		"%pred's %belly lets out a rumble as it melts you into sludge.",
		"%pred feels a soft gurgle as your body loses form in their %belly. You're nothing but a soft mass of churning slop now.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's thighs.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's rump.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's belly.",
		"%pred's %belly groans as you fall apart into a thick soup. Your remains soon flow deeper into %pred's body to be absorbed.",
		"%pred's %belly kneads on every fiber of your body, softening you down into mush to fuel their next hunt.",
		"%pred's %belly churns you down into a hot slush. Your nutrient-rich remains course through their digestive track with a series of long, wet glorps.")

	var/list/examine_messages = list(
		"They have something solid in their %belly!",
		"It looks like they have something in their %belly!")

	//Mostly for being overridden on precreated bellies on mobs. Could be VV'd into
	//a carbon's belly if someone really wanted. No UI for carbons to adjust this.
	//List has indexes that are the digestion mode strings, and keys that are lists of strings.
	var/list/emote_lists = list()

//For serialization, keep this updated AND IN ORDER OF VARS LISTED ABOVE AND IN DUPE AT THE BOTTOM!!, required for bellies to save correctly.
/obj/vore_belly/vars_to_save()
	return ..() + list(
		"name",
		"desc",
		"vore_sound",
		"vore_verb",
		"release_sound",
		"emote_time",
		"digest_brute",
		"digest_burn",
		"immutable",
		"escapable",
		"escapetime",
		"digestchance",
		"absorbchance",
		"escapechance",
		"can_taste",
		"bulge_size",
		"transferlocation",
		"transferchance",
		"autotransferchance",
		"autotransferwait",
		"swallow_time",
		"vore_capacity",
		"struggle_messages_outside",
		"struggle_messages_inside",
		"digest_messages_owner",
		"digest_messages_prey",
		"examine_messages",
		"emote_lists",
		"is_wet",
		"wet_loop"
		)

		//ommitted list
		// "shrink_grow_size",
/obj/vore_belly/Initialize(mapload)
	. = ..()
	SEND_SIGNAL(loc, COMSIG_VORE_ADD_BELLY, src) 
	SEND_SIGNAL(src, COMSIG_VORE_ADD_BELLY, loc)
	heartbeat_loop = new(list(), FALSE)
	squish_loop = new(list(), FALSE)

/obj/vore_belly/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ENTERED, .proc/on_enter_belly)
	RegisterSignal(src, COMSIG_ATOM_EXITED, .proc/on_exit_belly)
	RegisterSignal(src, COMSIG_VORE_DEVOUR_ATOM, .proc/nom_mob)
	RegisterSignal(src, COMSIG_VORE_STOP_SOUNDS, .proc/stop_sounds)
	RegisterSignal(src, COMSIG_VORE_AUTO_EMOTE, .proc/auto_emote)
	RegisterSignal(src, COMSIG_VORE_ADD_BELLY, .proc/add_belly)
	RegisterSignal(src, COMSIG_VORE_EXPEL_MOB, .proc/release_specific_contents)
	RegisterSignal(src, COMSIG_VORE_EXPEL_MOB_OOC, .proc/ooc_escape)
	RegisterSignal(src, COMSIG_VORE_EXPEL_ALL_MOBS, .proc/release_all_contents)

/obj/vore_belly/Destroy()
	// be kind, undefined
	UnregisterSignal(src, list(
		COMSIG_ATOM_ENTERED,
		COMSIG_ATOM_EXITED,
		COMSIG_ATOM_RELAYMOVE,
		COMSIG_LIVING_RESIST,
		COMSIG_VORE_STOP_SOUNDS,
		COMSIG_ATOM_ENTERED,
		))
	var/mob/living/our_owner = RESOLVEREF(owner)
	if(our_owner)
		SEND_SIGNAL(our_owner, COMSIG_VORE_REMOVE_BELLY, src)
		UnregisterSignal(our_owner, list(
			COMSIG_LIVING_RESIST,
			COMSIG_VORE_STOP_SOUNDS,
			COMSIG_VORE_EXPEL_MOB,
			COMSIG_VORE_EXPEL_MOB_OOC,
			COMSIG_VORE_EXPEL_ALL_MOBS,
			))
	STOP_PROCESSING(SSvore, src)
	owner = null
	QDEL_NULL(heartbeat_loop)
	QDEL_NULL(squish_loop)
	. = ..()

/obj/vore_belly/proc/add_belly(datum/source, mob/living/new_owner)
	owner = WEAKREF(new_owner)
	START_PROCESSING(SSvore, src)
	RegisterSignal(new_owner, COMSIG_VORE_STOP_SOUNDS, .proc/stop_sounds)
	RegisterSignal(new_owner, COMSIG_VORE_EXPEL_MOB, .proc/release_specific_contents)
	RegisterSignal(new_owner, COMSIG_VORE_EXPEL_MOB_OOC, .proc/ooc_escape)
	RegisterSignal(new_owner, COMSIG_VORE_EXPEL_ALL_MOBS, .proc/release_all_contents)

// Called whenever an atom enters this belly
/obj/vore_belly/proc/on_enter_belly(datum/parent, atom/movable/AM_prey, atom/OldLoc)
	SIGNAL_HANDLER
	var/mob/living/living_prey //for chat messages and blindness
	if(isliving(AM_prey))
		living_prey = AM_prey
		if(!CHECK_PREFS(living_prey, VOREPREF_BEING_PREY))
			SEND_SIGNAL(src, COMSIG_VORE_EXPEL_MOB, living_prey) // oops! out you go!
			return
		living_prey.become_blind("belly_[REF(src)]")
	if(OldLoc in contents)
		return //Someone dropping something (or being stripdigested)
	//Generic entered message
	RegisterSignal(living_prey, COMSIG_MOB_DEATH, .proc/digestion_death)
	RegisterSignal(living_prey, COMSIG_LIVING_RESIST, .proc/relay_resist)
	RegisterSignal(living_prey, COMSIG_ATOM_RELAYMOVE, .proc/relay_resist)
	var/mob/living/pwner = RESOLVEREF(owner)
	to_chat(pwner,span_notice("[AM_prey] slides into your [lowertext(name)]."))
	//ulp~
	play_gulp()
	to_chat(living_prey, span_notice("<B>[desc]</B>"), pref_check = VOREPREF_TEXT)

/obj/vore_belly/proc/on_exit_belly(datum/parent, atom/movable/AM_prey, atom/newloc)
	if(!isliving(AM_prey))
		return
	var/mob/living/living_prey = AM_prey
	living_prey.cure_blind("belly_[REF(src)]")
	UnregisterSignal(living_prey, COMSIG_MOB_DEATH)
	UnregisterSignal(living_prey, COMSIG_LIVING_RESIST)
	UnregisterSignal(living_prey, COMSIG_ATOM_RELAYMOVE)

/// Release all contents of this belly into the owning mob's location.
/// If that location is another mob, contents are transferred into whichever of its bellies the owning mob is in.
/// Returns the number of mobs so released.
/obj/vore_belly/proc/release_all_contents(datum/source, include_absorbed = FALSE, silent = FALSE)
	SIGNAL_HANDLER
	if(!LAZYLEN(contents))
		return FALSE
	. = 0
	for(var/atom/movable/AM_prey in contents)
		. += release_specific_contents(AM_prey, silent = TRUE)
	if(silent)
		return
	play_eject()
	var/mob/living/pwner = RESOLVEREF(owner)
	pwner.visible_message(
		span_greentext("<b>[owner] expels everything from their [lowertext(name)]!</b>"), 
		pref_check = VOREPREF_TEXT)

// Release a specific atom from the contents of this belly into the owning mob's location.
// If that location is another mob, the atom is transferred into whichever of its bellies the owning mob is in.
// Returns the number of atoms so released.
/obj/vore_belly/proc/release_specific_contents(datum/source, atom/movable/M, silent = FALSE)
	SIGNAL_HANDLER
	if (!is_in_belly(M))
		return FALSE // They weren't in this belly anyway
	M.forceMove(drop_location())  // Move the belly contents into the same location as belly's owner.
	. = TRUE
	var/mob/living/pwner = RESOLVEREF(owner)
	if(!pwner)
		return
	if(istype(M,/mob/living))
		var/mob/living/living_prey = M
		var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
		SEND_SIGNAL(src, COMSIG_VORE_STOP_SOUNDS, living_prey)
		if(pwner && CHECK_BITFIELD(vflags, ABSORBED))
			DISABLE_BITFIELD(vflags, ABSORBED)
			if(ishuman(M) && ishuman(pwner))
				var/mob/living/carbon/human/Prey = M
				var/mob/living/carbon/human/Pred = pwner
				var/absorbed_count = 2 //Prey that we were, plus the pred gets a portion
				for(var/mob/living/P in contents)
					var/pvflags = SEND_SIGNAL(P, COMSIG_VORE_GET_VOREFLAGS)
					if(CHECK_BITFIELD(pvflags, ABSORBED))
						absorbed_count++
				Pred.reagents.trans_to(Prey, Pred.reagents.total_volume / absorbed_count)
	//Clean up our own business
	pwner.update_icons()
	pwner.update_body(TRUE)
	if(silent)
		return
	play_eject()
	pwner.visible_message(
		span_greentext("<b>[pwner] expels [M] from their [lowertext(name)]!</b>"), 
		pref_check = VOREPREF_TEXT)

/obj/vore_belly/proc/ooc_escape(datum/source, mob/living/living_prey)
	SEND_SIGNAL(src, COMSIG_VORE_EXPEL_MOB, living_prey, TRUE)
		// for(var/mob/living/simple_animal/SA in range(10))
		// 	SA.prey_excludes[src] = world.time

		/* if(isanimal(B.owner))
			var/mob/living/simple_animal/SA = B.owner
			SA.update_icons() */

	//You're in a dogborg!
/* 	else if(istype(loc, /obj/item/dogborg/sleeper))
		var/obj/item/dogborg/sleeper/belly = loc //The belly!

		var/confirm = alert(src, "You're in a dogborg sleeper. This is for escaping from preference-breaking or if your predator disconnects/AFKs. You can also resist out naturally too.", "Confirmation", "Okay", "Cancel")
		if(!confirm == "Okay" || loc != belly)
			return
		//Actual escaping
		belly.go_out(src) //Just force-ejects from the borg as if they'd clicked the eject button.
		message_admins("[src] used OOC escape from a dogborg sleeper.")
		log_consent("[src] used OOC escape from a dogborg sleeper.") */

/obj/vore_belly/proc/play_gulp()
	if(!vore_sound)
		return
	play_voresound(VORESOUND_GULP)

/obj/vore_belly/proc/play_eject()
	if(!release_sound)
		return
	play_voresound(VORESOUND_EJECT)

/obj/vore_belly/proc/play_struggle()
	play_voresound(VORESOUND_STRUGGLE)

/obj/vore_belly/proc/play_digest()
	play_voresound(VORESOUND_DIGEST)

/obj/vore_belly/proc/play_death()
	play_voresound(VORESOUND_DEATH)

/obj/vore_belly/proc/play_voresound(sound_kind)
	if(!vore_sound)
		return
	var/sound_pred_struggle_snuggle
	var/sound_prey_struggle_snuggle
	var/pref = VOREPREF_EAT_SOUNDS
	switch(sound_kind)
		if(VORESOUND_GULP)
			sound_pred_struggle_snuggle = GLOB.pred_vore_sounds[vore_sound]
			sound_prey_struggle_snuggle = GLOB.prey_vore_sounds[vore_sound]
		if(VORESOUND_EJECT)
			sound_pred_struggle_snuggle = GLOB.pred_release_sounds[release_sound]
			sound_prey_struggle_snuggle = GLOB.prey_release_sounds[release_sound]
		if(VORESOUND_DIGEST)
			sound_pred_struggle_snuggle = get_sfx("digest_pred")
			sound_prey_struggle_snuggle = get_sfx("digest_prey")
			pref = VOREPREF_DIGESTION_SOUNDS
		if(VORESOUND_DEATH)
			sound_pred_struggle_snuggle = get_sfx("death_pred")
			sound_prey_struggle_snuggle = get_sfx("death_prey")
			pref = VOREPREF_DEATH
		if(VORESOUND_STRUGGLE)
			if(is_wet)
				sound_prey_struggle_snuggle = get_sfx("prey_struggle")
				sound_pred_struggle_snuggle = get_sfx("struggle_sound")
			else
				sound_prey_struggle_snuggle = get_sfx("rustle")
				sound_pred_struggle_snuggle = get_sfx("rustle")
			pref = VOREPREF_DIGESTION_SOUNDS

	if(!sound_pred_struggle_snuggle && !sound_prey_struggle_snuggle)
		return
	playsound(
		get_turf(src),
		sound_pred_struggle_snuggle,
		VORE_VOLUME,
		TRUE,
		SOUND_DISTANCE(VORE_SOUNDRANGE),
		CHANNEL_PRED,
		soundpref_index = pref
		)
	for(var/mob/living/vored in get_vored_mobs())
		vored.playsound_local(
			get_turf(src), 
			sound_prey_struggle_snuggle, 
			VORE_VOLUME,
			TRUE,
			channel = CHANNEL_PREY,
			soundpref_index = pref
			)

/obj/vore_belly/proc/stop_sounds(datum/source, mob/living/living_prey)
	SIGNAL_HANDLER
	if(!isliving(living_prey))
		return
	heartbeat_loop.stop(living_prey, kill = FALSE)
	squish_loop.stop(living_prey, kill = FALSE)
	living_prey.stop_sound_channel(CHANNEL_PRED) // sanity just in case
	living_prey.stop_sound_channel(CHANNEL_PREY) // sanity just in case
	living_prey.stop_sound_channel(CHANNEL_PREYLOOP_SQUISH) // sanity just in case
	living_prey.stop_sound_channel(CHANNEL_PREYLOOP_HEARTBEAT) // sanity just in case

/obj/vore_belly/proc/is_in_belly(var/atom/movable/prey)
	return (prey in contents)

/obj/vore_belly/proc/get_vored_mobs(only_clients = TRUE)
	. = list()
	for(var/mob/living/dope in contents)
		if(only_clients && dope.ckey && !dope.client)
			continue
		. |= dope

/obj/vore_belly/proc/get_vored_items()
	. = list()
	for(var/obj/item/dink in contents)
		. |= dink

// Actually perform the mechanics of devouring the tasty prey.
// The purpose of this method is to avoid duplicate code, and ensure that all necessary
// steps are taken.
/obj/vore_belly/proc/nom_mob(datum/source, atom/movable/movable_prey)
	SIGNAL_HANDLER
	if(!movable_prey)
		return
	var/mob/living/pwner = RESOLVEREF(owner)
	if(!pwner)
		return
	if(pwner.stat != CONSCIOUS)
		return
	movable_prey.forceMove(src) // mobs are unbuckled anyway
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	//owner.updateVRPanel()
	//for(var/mob/living/M in contents)
	//	M.updateVRPanel()
	// Setup the autotransfer checks if needed
	if(!isnull(transferlocation) && autotransferchance > 0)
		addtimer(CALLBACK(src, .proc/check_autotransfer, movable_prey), autotransferwait)

/obj/vore_belly/proc/check_autotransfer(atom/movable/movable_prey)
	// Some sanity checks
	if(!transferlocation || !is_in_belly(movable_prey))
		return
	if(prob(autotransferchance))
		transfer_contents(movable_prey, transferlocation)
		return
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	// Didn't transfer, so wait before retrying
	addtimer(CALLBACK(src, .proc/check_autotransfer, movable_prey), autotransferwait)

///Transfers contents from one belly to another
/obj/vore_belly/proc/transfer_contents(atom/movable/movable_prey, obj/vore_belly/target, silent = FALSE)
	if(!is_in_belly(movable_prey) || !istype(target))
		return
	movable_prey.forceMove(target)
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	// owner.updateVRPanel()
	// for(var/mob/living/M in contents)
	// 	M.updateVRPanel()
	if(silent)
		return
	play_voresound()

/// Get the line that should show up in Examine message if the owner of this belly
/// is examined. By making this a proc, we not only take advantage of polymorphism,
/// but can easily make the message vary based on how many people are inside, etc.
/// Returns a string which shoul be appended to the Examine output.
/obj/vore_belly/proc/get_examine_msg()
	if(!LAZYLEN(contents))
		return
	if(!LAZYLEN(examine_messages))
		return
	var/formatted_message
	var/raw_message = pick(examine_messages)
	var/total_bulge = 0 // uwu enlarge my bolgy wolgy

	formatted_message = replacetext(raw_message,"%belly",lowertext(name))
	formatted_message = replacetext(formatted_message,"%pred",owner)
	formatted_message = replacetext(formatted_message,"%prey",english_list(contents))
	for(var/mob/living/living_prey in get_vored_mobs(only_clients = FALSE))
		var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
		if(CHECK_BITFIELD(vflags, ABSORBED)) //This is required first, in case there's a person absorbed and not absorbed in a stomach.
			continue
		total_bulge += living_prey.mob_size
	if(total_bulge < bulge_size || bulge_size == 0)
		return
	return span_alert("[formatted_message]")

/// The next function gets the messages set on the belly, in human-readable format.
/// This is useful in customization boxes and such. The delimiter right now is \n\n so
/// in message boxes, this looks nice and is easily delimited.
/obj/vore_belly/proc/get_messages(type, delim = "\n\n")
	ASSERT(type == "smo" || type == "smi" || type == "dmo" || type == "dmp" || type == "em")
	var/list/raw_messages

	switch(type)
		if("smo")
			raw_messages = struggle_messages_outside
		if("smi")
			raw_messages = struggle_messages_inside
		if("dmo")
			raw_messages = digest_messages_owner
		if("dmp")
			raw_messages = digest_messages_prey
		if("em")
			raw_messages = examine_messages

	var/messages = raw_messages.Join(delim)
	return messages

// The next function sets the messages on the belly, from human-readable var
// replacement strings and linebreaks as delimiters (two \n\n by default).
// They also sanitize the messages.
/obj/vore_belly/proc/set_messages(var/raw_text, var/type, var/delim = "\n\n")
	ASSERT(type == "smo" || type == "smi" || type == "dmo" || type == "dmp" || type == "em")

	var/list/raw_list = splittext(html_encode(raw_text),delim)
	if(LAZYLEN(raw_list) >= 11)
		raw_list.Cut(11)
		testing("[owner] tried to set [lowertext(name)] with 11+ messages")

	for(var/i in 1 to LAZYLEN(raw_list))
		if(LAZYLEN(raw_list[i]) > VORE_MAX_DESCRIPTOR_LENGTH || LAZYLEN(raw_list[i]) < VORE_MIN_DESCRIPTOR_LENGTH) //160 is fudged value due to htmlencoding increasing the size
			raw_list.Cut(i,i)
			testing("[owner] tried to set [lowertext(name)] with >121 or <10 char message")
		else
			raw_list[i] = readd_quotes(raw_list[i])
			//Also fix % sign for var replacement
			raw_list[i] = replacetext(raw_list[i],"&#37;","%")

	ASSERT(LAZYLEN(raw_list) <= 10) //Sanity

	switch(type)
		if("smo")
			struggle_messages_outside = raw_list
		if("smi")
			struggle_messages_inside = raw_list
		if("dmo")
			digest_messages_owner = raw_list
		if("dmp")
			digest_messages_prey = raw_list
		if("em")
			examine_messages = raw_list
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)

/// Handle the death of a mob via digestion.
/// Called from the process_Life() methods of bellies that digest prey.
/// Default implementation calls M.death() and removes from internal contents.
/// Indigestable items are removed, and M is deleted.
/obj/vore_belly/proc/digestion_death(mob/living/living_prey)
	if(!isliving(living_prey))
		return // I mean, cant die if you arent living to begin with
	send_voremessage(
		living_prey,
		digest_messages_owner,
		digest_messages_prey,
		VOREPREF_TEXT
		)
	play_death()
	//living_prey.death(1) // "Stop it he's already dead..." Basically redundant and the reason behind screaming mouse carcasses.
	var/mobkey = living_prey.ckey
	var/mob/living/pwner = RESOLVEREF(owner)
	if(mobkey)
		message_admins("[key_name(pwner)] has digested [key_name(living_prey)] in their [lowertext(name)] ([pwner ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[pwner.x];Y=[pwner.y];Z=[pwner.z]'>JMP</a>" : "null"])")
		log_attack("[key_name(pwner)] digested [key_name(living_prey)].")

	// If digested prey is also a pred... anyone inside their bellies gets moved up.
	SEND_SIGNAL(living_prey, COMSIG_VORE_EXPEL_ALL_MOBS, TRUE, TRUE)

	//Drop all items into the belly
	for(var/obj/item/W in living_prey)
		if(!living_prey.dropItemToGround(W))
			qdel(W)

	//Update owner
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	pwner.update_body(TRUE)

//// Handle a mob being absorbed
/obj/vore_belly/proc/absorb_living(mob/living/living_prey)
	if(!isliving(living_prey))
		return
	var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
	var/mob/living/pwner = RESOLVEREF(owner)
	if(!CHECK_PREFS(living_prey, VOREPREF_ABSORBTION))
		return
	ENABLE_BITFIELD(vflags, ABSORBED)
	to_chat(living_prey, span_notice("[pwner]'s [lowertext(name)] absorbs your body, making you part of them."), pref_check = VOREPREF_TEXT)
	to_chat(pwner, span_notice("Your [lowertext(name)] absorbs [living_prey]'s body, making them part of you."))

	living_prey.forceMove(src)

	//Seek out absorbed prey of the prey, absorb them too.
	//This in particular will recurse oddly because if there is absorbed prey of prey of prey...
	//it will just move them up one belly. This should never happen though since... when they were
	//absobred, they should have been absorbed as well!
	var/list/prey_bellies = list()
	SEND_SIGNAL(living_prey, COMSIG_VORE_GET_BELLIES, prey_bellies)
	for(var/obj/vore_belly/belly in prey_bellies)
		for(var/mob/living/living_absorbed in belly.get_vored_mobs(FALSE))
			if(!can_absorb_living(living_absorbed))
				continue
			absorb_living(living_absorbed)

	//Update owner
	pwner.update_body(TRUE)
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)

//Digest a single item
//Receives a return value from digest_act that's how much nutrition
//the item should be worth
/obj/vore_belly/proc/digest_item(obj/item/gurgled_thing)
	var/mob/living/pwner = RESOLVEREF(owner)
	var/digested = gurgled_thing.digest_act(src, pwner)
	if(iscyborg(pwner))
		var/mob/living/silicon/robot/robot_prey = pwner
		robot_prey.cell.charge += (50 * digested)

//Determine where items should fall out of us into.
//Typically just to the owner's location.
/obj/vore_belly/drop_location()
	//Should be the case 99.99% of the time
	var/mob/living/pwner = RESOLVEREF(owner)
	if(pwner)
		return pwner.drop_location()
	//Sketchy fallback for safety, put them somewhere safe.
	else if(ismob(src))
		testing("[src] (\ref[src]) doesn't have an owner, and dropped someone at a latespawn point!")
		SSjob.SendToLateJoin(src)
		// wew lad. let's see if this never gets used, hopefully
	else
		qdel(src) //final option, I guess.
		testing("[src] (\ref[src]) was QDEL'd for not having a drop_location!")

//Yes, it's ""safe"" to drop items here
/obj/vore_belly/AllowDrop()
	return TRUE

/// Reads how fucked up our owner is, and outputs how difficult it would be to escape
/// Wounded predators are harder to escape, to prevent APCs
/obj/vore_belly/proc/get_escape_time()
	var/mob/living/pwner = RESOLVEREF(owner)
	if(!isliving(pwner))
		return FALSE // just, just go
	var/maxhp = pwner.getMaxHealth()
	var/health_deficit = maxhp - pwner.health
	var/delay_mult = (health_deficit / (maxhp*0.25)) * (pwner.stat + 1) // good luck getting out of a dead guy
	var/base_escapetime = escapetime
	if(delay_mult > 2)
		base_escapetime = max(escapetime, 5 SECONDS)

	return base_escapetime * delay_mult

//Handle a mob struggling
// Called from /mob/living/carbon/relaymove()
/obj/vore_belly/proc/relay_resist(datum/source, mob/living/living_prey)
	if (!is_in_belly(living_prey))
		return  // User is not in this belly

	if(attempt_escape(living_prey)) //If owner is stat (dead, KO) we can actually escape
		return

	send_voremessage(living_prey, struggle_messages_outside, struggle_messages_inside)

	if(!escapable) //If the stomach has escapable enabled.
		return
	var/mob/living/pwner = RESOLVEREF(owner)
	if(prob(escapechance)) //Let's have it check to see if the prey escapes first.
		attempt_escape(living_prey)
	if(prob(transferchance) && transferlocation) //Next, let's have it see if they end up getting into an even bigger mess then when they started.
		var/list/assbellies = list()
		SEND_SIGNAL(src, COMSIG_VORE_GET_BELLIES, assbellies, TRUE)
		var/dest_belly = assbellies[transferlocation]
		if(!dest_belly)
			to_chat(pwner, span_warning("Something went wrong with your belly transfer settings. Your <b>[lowertext(name)]</b> has had it's transfer chance and transfer location cleared as a precaution."))
			transferchance = 0
			transferlocation = null
			return
		to_chat(
			living_prey,
			span_warning("Your attempt to escape [lowertext(name)] has failed and your struggles only results in you sliding into [pwner]'s [transferlocation]!"),
			pref_check = VOREPREF_TEXT
			)
		to_chat(
			pwner,
			span_warning("Someone slid into your [transferlocation] due to their struggling inside your [lowertext(name)]!")
			)
		transfer_contents(living_prey, dest_belly)
		return

	if(prob(absorbchance) && digest_mode != DM_ABSORB) //After that, let's have it run the absorb chance.
		to_chat(
			living_prey,
			span_warning("In response to your struggling, \the [lowertext(name)] begins to cling more tightly..."),
			pref_check = VOREPREF_TEXT
			)
		to_chat(
			pwner,
			span_warning("You feel your [lowertext(name)] start to cling onto its contents...")
			)
		digest_mode = DM_ABSORB
		return

	if(prob(digestchance) && digest_mode != DM_DIGEST) //Finally, let's see if it should run the digest chance.
		to_chat(
			living_prey,
			span_warning("In response to your struggling, \the [lowertext(name)] begins to get more active..."),
			pref_check = VOREPREF_TEXT
			)
		to_chat(
			pwner,
			span_warning("You feel your [lowertext(name)] beginning to become active!")
			)
		digest_mode = DM_DIGEST
		return

	to_chat(
		living_prey,
		span_warning("You make no progress in escaping [pwner]'s [lowertext(name)]."),
		pref_check = VOREPREF_TEXT
		)
	to_chat(
		pwner,
		span_warning("Your prey appears to be unable to make any progress in escaping your [lowertext(name)].")
		)

/obj/vore_belly/proc/attempt_escape(mob/living/living_prey)
	if(!is_in_belly(living_prey))
		return
	var/mob/living/pwner = RESOLVEREF(owner)
	var/time_to_leave = get_escape_time()
	to_chat(
		living_prey,
		span_warning("You attempt to climb out of \the [lowertext(name)]. (This will take around [time_to_leave*0.1] seconds.)"),
		pref_check = VOREPREF_TEXT
		)
	to_chat(
		pwner,
		span_warning("Someone is attempting to climb out of your [lowertext(name)]!")
		)

	if(!do_after(
			living_prey, 
			time_to_leave,
			FALSE,
			pwner,
			required_mobility_flags = NONE,
			allow_movement = FALSE,
			))
		return FALSE
	if(escapable && is_in_belly(living_prey)) //Can still escape?
		SEND_SIGNAL(src, COMSIG_VORE_EXPEL_MOB, living_prey)
	else //Belly became inescapable or mob revived
		to_chat(
			living_prey,
			span_warning("Your attempt to escape [lowertext(name)] has failed!"),
			pref_check = VOREPREF_TEXT
			)
		to_chat(
			pwner,
			span_notice("The attempt to escape from your [lowertext(name)] has failed!")
			)
	return TRUE

/obj/vore_belly/proc/get_mobs_and_objs_in_belly()
	var/list/see = list()
	var/list/belly_mobs = list()
	see["mobs"] = belly_mobs
	var/list/belly_objs = list()
	see["objs"] = belly_objs
	for(var/mob/living/living_prey in loc.contents)
		belly_mobs |= living_prey
	for(var/obj/O in loc.contents)
		belly_objs |= O
	return see


/obj/vore_belly/proc/send_voremessage(
		mob/living/living_prey, 
		outside_list, 
		inside_list, 
		pref = VOREPREF_TEXT
		)
	var/outer_message = pick(outside_list)
	var/inner_message = pick(inside_list)
	var/mob/living/pwner = RESOLVEREF(owner)

	outer_message = replacetext(outer_message,"%pred",pwner)
	outer_message = replacetext(outer_message,"%prey",living_prey)
	outer_message = replacetext(outer_message,"%belly",lowertext(name))
	outer_message = span_alert(outer_message)

	inner_message = replacetext(inner_message,"%pred",pwner)
	inner_message = replacetext(inner_message,"%prey",living_prey)
	inner_message = replacetext(inner_message,"%belly",lowertext(name))
	inner_message = span_alert(inner_message)

	pwner.visible_message(
		outer_message,
		pref_check = pref
		)

	to_chat(
		living_prey,
		inner_message,
		pref_check = pref
		)

/obj/vore_belly/proc/can_digest_living(mob/living/living_prey)
	if(!isliving(living_prey))
		return FALSE
	if(digest_mode != DM_DIGEST)
		return FALSE
	if(CHECK_BITFIELD(living_prey.status_flags, GODMODE))
		return FALSE
	if(!CHECK_PREFS(living_prey, VOREPREF_VORE_DIGESTION_DAMAGE))
		return FALSE
	var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
	if(!CHECK_BITFIELD(vflags, DIGESTABLE))
		return FALSE
	if(!CHECK_BITFIELD(vflags, ABSORBED)) // already absorbed! stop gurgling!
		return FALSE
	return TRUE

/obj/vore_belly/proc/digest_living(mob/living/living_prey)
	if(!CHECK_PREFS(living_prey, VOREPREF_VORE_DIGESTION_DAMAGE))
		return
	if(!CHECK_PREFS(living_prey, VOREPREF_DEATH))
		if(living_prey.health <= ((digest_brute + digest_burn) * 2))
			return
	var/mob/living/pwner = RESOLVEREF(owner)
	living_prey.adjustBruteLoss(digest_brute)
	living_prey.adjustFireLoss(digest_burn)
	pwner.adjust_nutrition(1)

/obj/vore_belly/proc/can_healbelly_living(mob/living/living_prey)
	if(!CHECK_PREFS(living_prey, VOREPREF_HEALBELLY))
		return FALSE
	if(living_prey.stat == DEAD)
		return FALSE
	var/mob/living/pwner = RESOLVEREF(owner)
	if(pwner.nutrition < NUTRITION_LEVEL_FED)
		return FALSE
	if(living_prey.health >= living_prey.maxHealth)
		return FALSE
	return TRUE

/obj/vore_belly/proc/healbelly_living(mob/living/living_prey)
	var/mob/living/pwner = RESOLVEREF(owner)
	var/healamount = rand(1, 20) * -0.1
	living_prey.adjustBruteLoss(healamount)
	living_prey.adjustFireLoss(healamount)
	pwner.adjust_nutrition(healamount)

/obj/vore_belly/proc/can_absorb_living(mob/living/living_prey)
	if(!isliving(living_prey))
		return FALSE
	if(digest_mode != DM_ABSORB)
		return FALSE
	// sorta like vbucks, but moister
	var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
	if(!CHECK_PREFS(living_prey, VOREPREF_ABSORBTION))
		return FALSE
	if(!CHECK_BITFIELD(vflags, ABSORBABLE))
		return FALSE
	if(CHECK_BITFIELD(vflags, ABSORBED))
		return FALSE
	return TRUE

/obj/vore_belly/proc/absorb_act(mob/living/living_prey)
	var/mob/living/pwner = RESOLVEREF(owner)
	if(living_prey.nutrition >= 100) //Drain them until there's no nutrients left. Slowly "absorb" them.
		var/oldnutrition = (living_prey.nutrition * 0.05)
		living_prey.adjust_nutrition(-oldnutrition)
		pwner.adjust_nutrition(oldnutrition)
	if(living_prey.nutrition < 100) //When they're finally drained.
		absorb_living(living_prey)

/obj/vore_belly/proc/is_absorbed(mob/living/living_prey)
	if(!isliving(living_prey))
		return FALSE
	if(!CHECK_PREFS(living_prey, VOREPREF_ABSORBTION))
		return FALSE
	var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
	if(!CHECK_BITFIELD(vflags, ABSORBED))
		return FALSE
	return TRUE

/obj/vore_belly/proc/can_unabsorb_living(mob/living/living_prey)
	var/mob/living/pwner = RESOLVEREF(owner)
	var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
	if(!CHECK_BITFIELD(vflags, ABSORBED))
		return FALSE
	if(pwner.nutrition < NUTRITION_LEVEL_FED)
		return FALSE

/obj/vore_belly/proc/unabsorb_living(mob/living/living_prey)
	var/vflags = SEND_SIGNAL(living_prey, COMSIG_VORE_GET_VOREFLAGS)
	var/mob/living/pwner = RESOLVEREF(owner)
	DISABLE_BITFIELD(vflags, ABSORBED)
	to_chat(living_prey,span_notice("You suddenly feel solid again "))
	to_chat(pwner,span_notice("You feel like a part of you is missing."))
	pwner.adjust_nutrition(-NUTRITION_LEVEL_FED)

/obj/vore_belly/proc/auto_emote()
	if(!COOLDOWN_FINISHED(src, voremote_cooldown))
		return
	if(!LAZYLEN(contents))
		return
	var/list/digestion_emotes = emote_lists[digest_mode]
	if(!LAZYLEN(digestion_emotes))
		return
	for(var/mob/living/living_prey in get_vored_mobs())
		if(!can_digest_living(living_prey)) // don't give digesty messages to indigestible people
			continue
		to_chat(
			living_prey,
			span_notice("[pick(digestion_emotes)]"),
			pref_check = VOREPREF_TEXT
			)
	COOLDOWN_START(src, voremote_cooldown, VOREMOTE_COOLDOWN)

/obj/vore_belly/proc/refresh_vore_sounds()
	for(var/mob/living/living_prey in get_vored_mobs())
		if(!living_prey.client)
			continue
		if(!is_in_belly(living_prey))
			continue
		if(!is_wet)
			continue
		if(!wet_loop)
			continue
		if(!CHECK_PREFS(living_prey, VOREPREF_DIGESTION_SOUNDS))
			SEND_SIGNAL(src, COMSIG_VORE_STOP_SOUNDS, living_prey)
			continue
		heartbeat_loop.start(living_prey)
		squish_loop.start(living_prey)

/obj/vore_belly/proc/handle_absorbed()
	for(var/mob/living/living_prey in get_vored_mobs())
		if(!is_absorbed(living_prey))
			continue
		living_prey.Stun(5)

// Belly copies and then returns the copy
// Needs to be updated for any var changes AND KEPT IN ORDER OF THE VARS ABOVE AS WELL!
/obj/vore_belly/proc/copy(mob/new_owner)
	var/obj/vore_belly/dupe = new /obj/vore_belly(new_owner)

	//// Non-object variables
	dupe.name = name
	dupe.desc = desc
	dupe.vore_sound = vore_sound
	dupe.vore_verb = vore_verb
	dupe.release_sound = release_sound
	dupe.emote_time = emote_time
	dupe.digest_brute = digest_brute
	dupe.digest_burn = digest_burn
	dupe.immutable = immutable
	dupe.escapable = escapable
	dupe.escapetime = escapetime
	dupe.digestchance = digestchance
	dupe.absorbchance = absorbchance
	dupe.escapechance = escapechance
	dupe.can_taste = can_taste
	dupe.bulge_size = bulge_size
	dupe.transferlocation = transferlocation
	dupe.transferchance = transferchance
	dupe.autotransferchance = autotransferchance
	dupe.autotransferwait = autotransferwait
	dupe.swallow_time = swallow_time
	dupe.vore_capacity = vore_capacity
	dupe.is_wet = is_wet
	dupe.wet_loop = wet_loop

	//// Object-holding variables
	//struggle_messages_outside - strings
	dupe.struggle_messages_outside.Cut()
	for(var/I in struggle_messages_outside)
		dupe.struggle_messages_outside += I

	//struggle_messages_inside - strings
	dupe.struggle_messages_inside.Cut()
	for(var/I in struggle_messages_inside)
		dupe.struggle_messages_inside += I

	//digest_messages_owner - strings
	dupe.digest_messages_owner.Cut()
	for(var/I in digest_messages_owner)
		dupe.digest_messages_owner += I

	//digest_messages_prey - strings
	dupe.digest_messages_prey.Cut()
	for(var/I in digest_messages_prey)
		dupe.digest_messages_prey += I

	//examine_messages - strings
	dupe.examine_messages.Cut()
	for(var/I in examine_messages)
		dupe.examine_messages += I

	//emote_lists - index: digest mode, key: list of strings
	dupe.emote_lists.Cut()
	for(var/K in emote_lists)
		dupe.emote_lists[K] = list()
		for(var/I in emote_lists[K])
			dupe.emote_lists[K] += I
	return dupe

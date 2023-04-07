#define VORE_SOUND_FALLOFF 0.1
#define VORE_SOUND_RANGE 3

//
//  Belly system 2.0, now using objects instead of datums because EH at datums.
//	How many times have I rewritten bellies and vore now? -Aro
//

// If you change what variables are on this, then you need to update the copy() proc.

//
// Parent type of all the various "belly" varieties.
//
/obj/vore_belly
	name = "belly"							// Name of this location
	desc = "It's a belly! You're in it!"	// Flavor text description of inside sight/sound/smells/feels.
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

	var/mob/living/owner					// The mob whose belly this is.
	var/digest_mode = DM_HOLD				// Current mode the belly is set to from digest_modes (+transform_modes if human)
	var/next_process = 0					// Waiting for this SSbellies times_fired to process again.
	var/next_emote = 0						// When we're supposed to print our next emote, as a belly controller tick #
	var/recent_sound						// Prevent audio spam
	var/last_hearcheck = 0
	var/datum/looping_sound/vore_heartbeat/heartbeat_loop
	var/datum/looping_sound/vore_squish/squish_loop
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
	heartbeat_loop = new(list(src), FALSE)
	squish_loop = new(list(src), FALSE)
	if(isliving(loc))
		insert_into(loc)

/obj/vore_belly/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ENTERED, .on_enter_belly)
	RegisterSignal(src, COMSIG_ATOM_EXITED, .on_exit_belly)

/obj/vore_belly/proc/insert_into(var/mob/living/new_owner)
	//If not, we're probably just in a prefs list or something.
	if(!isliving(new_owner))
		return
	owner = new_owner
	owner.vore_organs |= src
	START_PROCESSING(SSbellies, src)

/obj/vore_belly/Destroy()
	// be kind, undefined
	UnregisterSignal(src, COMSIG_ATOM_ENTERED)
	UnregisterSignal(src, COMSIG_ATOM_EXITED)
	QDEL_NULL(heartbeat_loop)
	QDEL_NULL(squish_loop)
	STOP_PROCESSING(SSbellies, src)
	if(isliving(owner))
		owner.vore_organs -= src
		if(owner.vore_selected == src)
			owner.vore_selected = null
		owner = null
	. = ..()

// Called whenever an atom enters this belly
/obj/vore_belly/on_enter_belly(datum/parent, atom/movable/AM_prey, atom/OldLoc)
	SIGNAL_HANDLER
	var/mob/living/living_prey //for chat messages and blindness
	if(isliving(AM_prey))
		living_prey = AM_prey
		living_prey.become_blind("belly_[REF(src)]")
	if(OldLoc in contents)
		return //Someone dropping something (or being stripdigested)
	//Generic entered message
	to_chat(owner,span_notice("[AM_prey] slides into your [lowertext(name)]."))
	//ulp~
	play_gulp()
	to_chat(living_prey, span_notice("<B>[desc]</B>"))

/obj/vore_belly/on_exit_belly(datum/parent, atom/movable/AM_prey, atom/newloc)
	if(!isliving(AM_prey))
		return
	var/mob/living/living_prey = AM_prey
	living_prey.cure_blind("belly_[REF(src)]")

// Release all contents of this belly into the owning mob's location.
// If that location is another mob, contents are transferred into whichever of its bellies the owning mob is in.
// Returns the number of mobs so released.
/obj/vore_belly/proc/release_all_contents(var/include_absorbed = FALSE, var/silent = FALSE)
	if(!LAZYLEN(contents))
		return FALSE

	. = 0
	for(var/atom/movable/AM_prey in contents)
		. += release_specific_contents(AM_prey, silent = TRUE)

	if(silent)
		return
	play_eject()
	owner.visible_message(
		span_greentext("<b>[owner] expels everything from their [lowertext(name)]!</b>"), 
		pref_check = VOREPREF_TEXT)


// Release a specific atom from the contents of this belly into the owning mob's location.
// If that location is another mob, the atom is transferred into whichever of its bellies the owning mob is in.
// Returns the number of atoms so released.
/obj/vore_belly/proc/release_specific_contents(atom/movable/M, silent = FALSE)
	if (!is_in_belly(M))
		return FALSE // They weren't in this belly anyway

	M.forceMove(drop_location())  // Move the belly contents into the same location as belly's owner.
	. = TRUE

	if(istype(M,/mob/living))
		var/mob/living/living_prey = M
		heartbeat_loop.stop(living_prey, kill = FALSE)
		squish_loop.stop(living_prey, kill = FALSE)
		living_prey.stop_sound_channel(CHANNEL_PREYLOOP_HEARTBEAT) // Also kill the sound *now*
		living_prey.stop_sound_channel(CHANNEL_PREYLOOP_SQUISH) // Also kill the sound *now*
		
		if(owner && CHECK_BITFIELD(living_prey.vore_flags, ABSORBED))
			DISABLE_BITFIELD(living_prey.vore_flags, ABSORBED)
			if(ishuman(M) && ishuman(owner))
				var/mob/living/carbon/human/Prey = M
				var/mob/living/carbon/human/Pred = owner
				var/absorbed_count = 2 //Prey that we were, plus the pred gets a portion
				for(var/mob/living/P in contents)
					if(CHECK_BITFIELD(P.vore_flags, ABSORBED))
						absorbed_count++
				Pred.reagents.trans_to(Prey, Pred.reagents.total_volume / absorbed_count)

	//Clean up our own business
	owner?.update_icons()
	owner?.update_body(TRUE)

	if(silent)
		return
	play_eject()
	owner.visible_message(
		span_greentext("<b>[owner] expels [M] from their [lowertext(name)]!</b>", 
		pref_check = VOREPREF_TEXT))

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

/obj/vore_belly/proc/is_in_belly(var/atom/movable/prey)
	return (prey in contents)

/obj/vore_belly/proc/get_vored_mobs(only_clients = TRUE)
	. = list()
	for(var/mob/living/dope in contents)
		if(only_clients && !dope.client)
			continue
		. |= dope

/obj/vore_belly/proc/get_vored_items()
	. = list()
	for(var/obj/item/dink in contents)
		. |= dope

// Actually perform the mechanics of devouring the tasty prey.
// The purpose of this method is to avoid duplicate code, and ensure that all necessary
// steps are taken.
/obj/vore_belly/proc/nom_mob(mob/living/prey)
	if(!prey)
		return
	if(owner.stat != CONSCIOUS)
		return
	prey.forceMove(src) // mobs are unbuckled anyway
	owner.updateVRPanel()
	for(var/mob/living/M in contents)
		M.updateVRPanel()
	// Setup the autotransfer checks if needed
	if(!isnull(transferlocation) && autotransferchance > 0)
		addtimer(CALLBACK(src, .proc/check_autotransfer, prey), autotransferwait)

/obj/vore_belly/proc/check_autotransfer(mob/living/prey)
	// Some sanity checks
	if(!transferlocation || !is_in_belly(prey))
		return
	if(prob(autotransferchance))
		transfer_contents(prey, transferlocation)
		return
	// Didn't transfer, so wait before retrying
	addtimer(CALLBACK(src, .proc/check_autotransfer, prey), autotransferwait)

///Transfers contents from one belly to another
/obj/vore_belly/proc/transfer_contents(var/atom/movable/content, var/obj/vore_belly/target, silent = FALSE)
	if(!is_in_belly(content) || !istype(target))
		return
	content.forceMove(target)
	owner.updateVRPanel()
	for(var/mob/living/M in contents)
		M.updateVRPanel()
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
		if(CHECK_BITFIELD(living_prey.vore_flags, ABSORBED)) //This is required first, in case there's a person absorbed and not absorbed in a stomach.
			continue
		total_bulge += living_prey.mob_size
	if(total_bulge < bulge_size || bulge_size == 0)
		return
	return span_alert(">[formatted_message]<BR>")

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

/// Handle the death of a mob via digestion.
/// Called from the process_Life() methods of bellies that digest prey.
/// Default implementation calls M.death() and removes from internal contents.
/// Indigestable items are removed, and M is deleted.
/obj/vore_belly/proc/digestion_death(mob/living/living_prey)
	if(!isliving(living_prey))
		return // I mean, cant die if you arent living to begin with
	//living_prey.death(1) // "Stop it he's already dead..." Basically redundant and the reason behind screaming mouse carcasses.
	var/mobkey = ckey(living_prey.last_mind?.key) || living_prey.ckey
	if(mobkey)
		message_admins("[key_name(owner)] has digested [key_name(living_prey)] in their [lowertext(name)] ([owner ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[owner.x];Y=[owner.y];Z=[owner.z]'>JMP</a>" : "null"])")
		log_attack("[key_name(owner)] digested [key_name(living_prey)].")

	// If digested prey is also a pred... anyone inside their bellies gets moved up.
	if(has_vore_belly(living_prey))
		living_prey.release_vore_contents(include_absorbed = TRUE, silent = TRUE)

	//Drop all items into the belly
	for(var/obj/item/W in living_prey)
		if(!living_prey.dropItemToGround(W))
			qdel(W)

	//Incase they have the loop going, let's double check to stop it.
	heartbeat_loop.stop(living_prey, kill = FALSE)
	squish_loop.stop(living_prey, kill = FALSE)
	living_prey.stop_sound_channel(CHANNEL_PREYLOOP_HEARTBEAT) // Also kill the sound *now*
	living_prey.stop_sound_channel(CHANNEL_PREYLOOP_SQUISH) // Also kill the sound *now*

	// Delete the digested mob
	//qdel(living_prey)
	INVOKE_ASYNC(living_prey, /mob/living/.proc/you_died, src)

	//Update owner
	owner?.updateVRPanel()
	owner?.update_body(TRUE)
	living_prey.updateVRPanel()

//// Handle a mob being absorbed
/obj/vore_belly/proc/absorb_living(mob/living/living_prey)
	if(!isliving(living_prey))
		return
	ENABLE_BITFIELD(living_prey.vore_flags, ABSORBED)
	to_chat(living_prey, span_notice("[owner]'s [lowertext(name)] absorbs your body, making you part of them."))
	to_chat(owner, span_notice("Your [lowertext(name)] absorbs [living_prey]'s body, making them part of you."))

	if(living_prey.loc != src)
		living_prey.forceMove(src)

	//Seek out absorbed prey of the prey, absorb them too.
	//This in particular will recurse oddly because if there is absorbed prey of prey of prey...
	//it will just move them up one belly. This should never happen though since... when they were
	//absobred, they should have been absorbed as well!
	for(var/obj/vore_belly/belly in living_prey.vore_organs)
		for(var/mob/living/living_absorbed in get_vored_mobs(FALSE))
			if(!can_absorb_living(living_absorbed))
				continue
			absorb_living(living_absorbed)

	//Update owner
	owner?.updateVRPanel()
	owner?.update_body(TRUE)
	living_prey.updateVRPanel()

//Digest a single item
//Receives a return value from digest_act that's how much nutrition
//the item should be worth
/obj/vore_belly/proc/digest_item(obj/item/gurgled_thing)
	var/digested = gurgled_thing.digest_act(src, owner)
	if(iscyborg(owner))
		var/mob/living/silicon/robot/robot_prey = owner
		robot_prey.cell.charge += (50 * digested)

//Determine where items should fall out of us into.
//Typically just to the owner's location.
/obj/vore_belly/drop_location()
	//Should be the case 99.99% of the time
	if(owner)
		return owner.drop_location()
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
	if(!isliving(owner))
		return FALSE // just, just go
	var/maxhp = getMaxHealth()
	var/heath_deficit = maxhp - owner.health
	var/delay_mult = (health_deficit / (maxhp*0.25)) * (owner.stat + 1) // good luck getting out of a dead guy
	var/base_escapetime = escapetime
	if(delay_mult > 2)
		base_escapetime = max(escape_time, 5 SECONDS)

	return base_escapetime * delay_mult

//Handle a mob struggling
// Called from /mob/living/carbon/relaymove()
/obj/vore_belly/proc/relay_resist(mob/living/living_prey)
	if (!is_in_belly(living_prey))
		return  // User is not in this belly

	if(attempt_escape(living_prey)) //If owner is stat (dead, KO) we can actually escape
		return

	send_voremessage(living_prey, struggle_messages_outside, struggle_messages_inside)

	if(escapable) //If the stomach has escapable enabled.
		if(prob(escapechance)) //Let's have it check to see if the prey escapes first.
			attempt_escape(living_prey)
		else if(prob(transferchance) && transferlocation) //Next, let's have it see if they end up getting into an even bigger mess then when they started.
			var/obj/vore_belly/dest_belly
			for(var/belly in owner.vore_organs)
				var/obj/vore_belly/B = belly
				if(B.name == transferlocation)
					dest_belly = B
					break

			if(!dest_belly)
				to_chat(owner, span_warning("Something went wrong with your belly transfer settings. Your <b>[lowertext(name)]</b> has had it's transfer chance and transfer location cleared as a precaution."))
				transferchance = 0
				transferlocation = null
				return

			to_chat(living_prey,span_warning("Your attempt to escape [lowertext(name)] has failed and your struggles only results in you sliding into [owner]'s [transferlocation]!"))
			to_chat(owner,span_warning("Someone slid into your [transferlocation] due to their struggling inside your [lowertext(name)]!"))
			transfer_contents(living_prey, dest_belly)
			return

		else if(prob(absorbchance) && digest_mode != DM_ABSORB) //After that, let's have it run the absorb chance.
			to_chat(living_prey,span_warning("In response to your struggling, \the [lowertext(name)] begins to cling more tightly..."))
			to_chat(owner,span_warning("You feel your [lowertext(name)] start to cling onto its contents..."))
			digest_mode = DM_ABSORB
			return

		else if(prob(digestchance) && digest_mode != DM_DIGEST) //Finally, let's see if it should run the digest chance.
			to_chat(living_prey,span_warning("In response to your struggling, \the [lowertext(name)] begins to get more active..."))
			to_chat(owner,span_warning("You feel your [lowertext(name)] beginning to become active!"))
			digest_mode = DM_DIGEST
			return

		else //Nothing interesting happened.
			to_chat(living_prey,span_warning("You make no progress in escaping [owner]'s [lowertext(name)]."))
			to_chat(owner,span_warning("Your prey appears to be unable to make any progress in escaping your [lowertext(name)]."))
			return

/obj/vore_belly/proc/attempt_escape(mob/living/living_prey)
	if(!is_in_belly(living_prey))
		return
	var/time_to_leave = get_escape_time()
	to_chat(living_prey,span_warning("You attempt to climb out of \the [lowertext(name)]. (This will take around [time_to_leave*0.1] seconds.)"))
	to_chat(owner,span_warning("Someone is attempting to climb out of your [lowertext(name)]!"))

	if(!do_after(
			living_prey, 
			time_to_leave,
			FALSE,
			owner,
			required_mobility_flags = NONE,
			allow_movement = FALSE,
			))
		return FALSE
	if(escapable && is_in_belly(living_prey)) //Can still escape?
		release_specific_contents(living_prey)
	else //Belly became inescapable or mob revived
		to_chat(living_prey,span_warning("Your attempt to escape [lowertext(name)] has failed!"))
		to_chat(owner,span_notice("The attempt to escape from your [lowertext(name)] has failed!"))
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

	outer_message = replacetext(outer_message,"%pred",owner)
	outer_message = replacetext(outer_message,"%prey",living_prey)
	outer_message = replacetext(outer_message,"%belly",lowertext(name))
	outer_message = span_alert( outer_message)

	inner_message = replacetext(inner_message,"%pred",owner)
	inner_message = replacetext(inner_message,"%prey",living_prey)
	inner_message = replacetext(inner_message,"%belly",lowertext(name))
	inner_message = span_alert(inner_message)

	owner.visible_message(
		outer_message,
		pref_check = pref
		)

	if(SSprefbreak.allowed_by_prefs(living_prey, pref))
		to_chat(living_prey,inner_message)

/obj/vore_belly/proc/can_digest_living(mob/living/living_prey)
	if(!isliving(living_prey))
		return FALSE
	if(digest_mode != DM_DIGEST)
		return FALSE
	if(CHECK_BITFIELD(living_prey.status_flags, GODMODE))
		return FALSE
	if(!CHECK_BITFIELD(living_prey.vore_flags, DIGESTABLE))
		return FALSE
	if(!CHECK_BITFIELD(living_prey.vore_flags, ABSORBED)) // already absorbed! stop gurgling!
		return FALSE
	return TRUE

/obj/vore_belly/proc/digest_living(mob/living/living_prey)
	if(!SSprefbreak.allowed_by_prefs(living_prey, VOREPREF_DIGESTION_DAMAGE))
		return
	if(!SSprefbreak.allowed_by_prefs(living_prey, VOREPREF_DEATH))
		if(living_prey.health <= ((digest_brute + digest_burn) * 2))
			return
	living_prey.adjustBruteLoss(digest_brute)
	living_prey.adjustFireLoss(digest_burn)
	owner.adjust_nutrition(1)

/obj/vore_belly/proc/can_healbelly_living(mob/living/living_prey)
	if(SSprefbreak.allowed_by_prefs(living_prey, VOREPREF_HEALBELLY))
		return FALSE
	if(living_prey.stat == DEAD)
		return FALSE
	if(owner.nutrition < NUTRITION_LEVEL_FED)
		return FALSE
	if(living_prey.health >= living_prey.maxHealth)
		return FALSE
	return TRUE

/obj/vore_belly/proc/healbelly_living(mob/living/living_prey)
	var/healamount = rand(1, 20) * -0.1
	living_prey.adjustBruteLoss(healamount)
	living_prey.adjustFireLoss(healamount)
	owner.adjust_nutrition(healamount)

/obj/vore_belly/proc/can_absorb_living(mob/living/living_prey)
	if(!isliving(living_prey))
		return FALSE
	if(digest_mode != DM_ABSORB)
		return FALSE
	if(!SSprefbreak.allowed_by_prefs(living_prey, VOREPREF_ABSORBTION))
		return FALSE
	if(!CHECK_BITFIELD(living_prey.vore_flags, ABSORBABLE))
		return FALSE
	if(CHECK_BITFIELD(living_prey.vore_flags, ABSORBED))
		return FALSE
	return TRUE

/obj/vore_belly/proc/absorb_act(mob/living/living_prey)
	if(living_prey.nutrition >= 100) //Drain them until there's no nutrients left. Slowly "absorb" them.
		var/oldnutrition = (living_prey.nutrition * 0.05)
		living_prey.adjust_nutrition(-oldnutrition)
		owner.adjust_nutrition(oldnutrition)
	if(living_prey.nutrition < 100) //When they're finally drained.
		absorb_living(living_prey)

/obj/vore_belly/proc/is_absorbed(mob/living/living_prey)
	if(!isliving(living_prey))
		return FALSE
	if(!SSprefbreak.allowed_by_prefs(living_prey, VOREPREF_ABSORBTION))
		return FALSE
	if(!CHECK_BITFIELD(living_prey.vore_flags, ABSORBED))
		return FALSE
	return TRUE

/obj/vore_belly/proc/can_unabsorb_living(mob/living/living_prey)
	if(!CHECK_BITFIELD(living_prey.vore_flags, ABSORBED))
		return FALSE
	if(owner.nutrition < NUTRITION_LEVEL_FED)
		return FALSE

/obj/vore_belly/proc/unabsorb_living(mob/living/living_prey)
	DISABLE_BITFIELD(living_prey.vore_flags, ABSORBED)
	to_chat(living_prey,span_notice("You suddenly feel solid again "))
	to_chat(owner,span_notice("You feel like a part of you is missing."))
	owner.adjust_nutrition(-NUTRITION_LEVEL_FED)

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
		to_chat(living_prey,span_notice("[pick(digestion_emotes)]"))

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
		if(!SSprefbreak.allowed_by_prefs(living_prey, VOREPREF_DIGESTION_SOUNDS))
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

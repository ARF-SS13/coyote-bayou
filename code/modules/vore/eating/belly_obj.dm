#define VORE_SOUND_FALLOFF 0.1
#define VORE_SOUND_RANGE 3

//
//  Belly system 2.0, now using objects instead of datums because EH at datums.
//	How many times have I rewritten bellies and vore now? -Aro
//	Kicked to shit with signals and assorted BS by Lagg
//

// If you change what variables are on this, then you need to update the copy() proc.

//
// Parent type of all the various "belly" varieties.
//
/obj/vore_belly
	name = "belly"							// Name of this location
	desc = "It appears to be rather warm and wet. Makes sense, considering the fact it's a belly."	// Flavor text description of inside sight/sound/smells/feels.
	rad_flags = RAD_NO_CONTAMINATE | RAD_PROTECT_CONTENTS
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/vore_sound = "Gulp"					// Sound when ingesting someone
	var/vore_verb = "ingest"				// Verb for eating with this in messages
	var/release_verb = "expels"				// Verb for releasing something from a stomach
	var/human_prey_swallow_time = 100		// Time in deciseconds to swallow /mob/living/carbon/human
	var/nonhuman_prey_swallow_time = 30		// Time in deciseconds to swallow anything else
	var/nutrition_percent = 100				// Nutritional percentage per tick in digestion mode
	var/digest_brute = 0.5					// Brute damage per tick in digestion mode
	var/digest_burn = 0.5					// Burn damage per tick in digestion mode
	var/digest_oxy = 0						// Oxy damage per tick in digestion mode
	var/digest_tox = 0						// Toxins damage per tick in digestion mode
	var/digest_clone = 0					// Clone damage per tick in digestion mode
	var/immutable = FALSE					// Prevents this belly from being deleted
	var/escapable = TRUE					// Belly can be resisted out of at any time
	var/escapetime = 20 SECONDS				// Deciseconds, how long to escape this belly
	var/digestchance = 0					// % Chance of stomach beginning to digest if prey struggles
	var/absorbchance = 0					// % Chance of stomach beginning to absorb if prey struggles
	var/escapechance = 100 					// % Chance of prey beginning to escape if prey struggles.
	var/transferchance = 0 					// % Chance of prey being trasnsfered, goes from 0-100%
	var/transferchance_secondary = 0 		// % Chance of prey being transfered to transferchance_secondary, also goes 0-100%
	var/save_digest_mode = TRUE				// Whether this belly's digest mode persists across rounds
	var/can_taste = FALSE					// If this belly prints the flavor of prey when it eats someone.
	var/bulge_size = 0.25					// The minimum size the prey has to be in order to show up on examine.
	var/display_absorbed_examine = FALSE	// Do we display absorption examine messages for this belly at all?
	var/absorbed_desc						// Desc shown to absorbed prey. Defaults to regular if left empty.
	var/shrink_grow_size = 1				// This horribly named variable determines the minimum/maximum size it will shrink/grow prey to.
	var/transferlocation					// Location that the prey is released if they struggle and get dropped off.
	var/transferlocation_secondary			// Secondary location that prey is released to.
	var/release_sound = "Splatter"			// Sound for letting someone out. Replaced from True/false
	var/mode_flags = 0						// Stripping, numbing, etc.
	var/fancy_vore = FALSE					// Using the new sounds?
	var/is_wet = TRUE						// Is this belly's insides made of slimy parts?
	var/wet_loop = TRUE						// Does the belly have a fleshy loop playing?
	/// unused, but kept cus I just *know* they'll be used later. update with real vars when it happens
	var/obj/item/ownegg						// Is this belly creating an egg?
	var/egg_type = "Egg"					// Default egg type and path.
	var/egg_path = null
	var/list/list/emote_lists = list()			// Idle emotes that happen on their own, depending on the bellymode. Contains lists of strings indexed by bellymode
	var/emote_time = 60						// How long between stomach emotes at prey (in seconds)
	var/emote_active = TRUE					// Are we even giving emotes out at all or not?
	var/next_emote = 0						// When we're supposed to print our next emote, as a world.time
	var/selective_preference = DM_DIGEST	// Which type of selective bellymode do we default to?

	// Generally just used by AI
	var/autotransferchance = 0 				// % Chance of prey being autotransferred to transfer location
	var/autotransferwait = 10 				// Time between trying to transfer.
	var/autotransferlocation				// Place to send them

	var/mob/living/owner					// The mob whose belly this is.
	var/tmp/digest_mode = DM_HOLD				// Current mode the belly is set to from digest_modes (+transform_modes if human)
	var/tmp/list/items_preserved = list()		// Stuff that wont digest so we shouldn't process it again.
	var/tmp/recent_sound = FALSE				// Prevent audio spam

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

	var/list/absorbed_struggle_messages_outside = list(
		"%pred's %belly wobbles, seemingly on its own.",
		"%pred's %belly jiggles without apparent cause.",
		"%pred's %belly seems to shake for a second without an obvious reason.")

	var/list/absorbed_struggle_messages_inside = list(
		"You try and resist %pred's %belly, but only cause it to jiggle slightly.",
		"Your fruitless mental struggles only shift %pred's %belly a tiny bit.",
		"You can't make any progress freeing yourself from %pred's %belly.")

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

	var/list/absorb_messages_owner = list(
		"You feel %prey becoming part of you.")

	var/list/absorb_messages_prey = list(
		"You feel yourself becoming part of %pred's %belly!")

	var/list/unabsorb_messages_owner = list(
		"You feel %prey reform into a recognizable state again.")

	var/list/unabsorb_messages_prey = list(
		"You are released from being part of %pred's %belly.")

	var/list/examine_messages = list(
		"They have something solid in their %belly!",
		"It looks like they have something in their %belly!")

	var/list/examine_messages_absorbed = list(
		"Their body looks somewhat larger than usual around the area of their %belly.",
		"Their %belly looks larger than usual.")

	/// Unused, kept for serialization stuff
	var/item_digest_mode = null	// Current item-related mode from item_digest_modes
	var/contaminates = FALSE					// Whether the belly will contaminate stuff
	var/contamination_flavor = "Generic"	// Determines descriptions of contaminated items
	var/contamination_color = "green"		// Color of contamination overlay

	// Lets you do a fullscreen overlay. Set to an icon_state string.
	var/belly_fullscreen = ""
	var/disable_hud = FALSE
	var/colorization_enabled = FALSE
	var/belly_fullscreen_color = "#823232"

	var/spits_trash = FALSE
	var/list/spit_trash_messages = list(
		"%pred's %belly ejects a piece of trash.")

	//// These arent serialized
	var/datum/looping_sound/vore_heartbeat/heartbeat_loop
	var/datum/looping_sound/vore_squish/squish_loop
	/// Next time vore sounds get played for the prey, do not change manually as it is intended to be set automatically
	COOLDOWN_DECLARE(prey_sound_cooldown)
	COOLDOWN_DECLARE(voremote_cooldown)
	COOLDOWN_DECLARE(recalc_slows)
	/// how much items in this belly slow you
	var/item_slowdown = 0
	/// how much mobs in this belly slow you
	var/mob_slowdown = 0


//For serialization, keep this updated AND IN ORDER OF VARS LISTED ABOVE AND IN DUPE AT THE BOTTOM!!, required for bellies to save correctly.
/obj/vore_belly/vars_to_save()
	var/list/saving = list(
	"name",
	"desc",
	"absorbed_desc",
	"vore_sound",
	"vore_verb",
	"release_verb",
	"human_prey_swallow_time",
	"nonhuman_prey_swallow_time",
	"emote_time",
	"nutrition_percent",
	"digest_brute",
	"digest_burn",
	"digest_oxy",
	"digest_tox",
	"digest_clone",
	"immutable",
	"can_taste",
	"escapable",
	"escapetime",
	"digestchance",
	"absorbchance",
	"escapechance",
	"transferchance",
	"transferchance_secondary",
	"transferlocation",
	"transferlocation_secondary",
	"bulge_size",
	"display_absorbed_examine",
	"shrink_grow_size",
	"struggle_messages_outside",
	"struggle_messages_inside",
	"absorbed_struggle_messages_outside",
	"absorbed_struggle_messages_inside",
	"digest_messages_owner",
	"digest_messages_prey",
	"absorb_messages_owner",
	"absorb_messages_prey",
	"unabsorb_messages_owner",
	"unabsorb_messages_prey",
	"examine_messages",
	"examine_messages_absorbed",
	"emote_lists",
	"emote_time",
	"emote_active",
	"selective_preference",
	"mode_flags",
	"item_digest_mode",
	"contaminates",
	"contamination_flavor",
	"contamination_color",
	"release_sound",
	"fancy_vore",
	"is_wet",
	"wet_loop",
	"belly_fullscreen",
	"disable_hud",
	"belly_fullscreen_color",
	"colorization_enabled",
	"egg_type",
	"save_digest_mode",
	"spits_trash",
	"spit_trash_messages"
	)

	if (save_digest_mode == 1)
		return ..() + saving + list("digest_mode")

	return ..() + saving
/obj/vore_belly/Initialize(mapload)
	. = ..()
	SEND_SIGNAL(loc, COMSIG_VORE_ADD_BELLY, src) 
	SEND_SIGNAL(src, COMSIG_VORE_ADD_BELLY, loc)
	heartbeat_loop = new(list(), FALSE)
	squish_loop = new(list(), FALSE)
	/// So one of the stipulations to having vore be so readily accessible and available to just about anyione
	/// is that it should not give the player a mechanical advantage over someone who doesnt use it
	/// Think about it, a potentially game-changing mechanic that is locked out for someone who doesnt like vore kinda sucks
	/// So, yeah
	ADD_TRAIT(src, TRAIT_ARTIFACT_BLOCKER, src)

/obj/vore_belly/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_VORE_DEVOUR_ATOM,PROC_REF(nom_mob))
	RegisterSignal(src, COMSIG_VORE_STOP_SOUNDS,PROC_REF(stop_sounds))
	RegisterSignal(src, COMSIG_VORE_AUTO_EMOTE,PROC_REF(auto_emote))
	RegisterSignal(src, COMSIG_VORE_ADD_BELLY,PROC_REF(add_belly))
	RegisterSignal(src, COMSIG_BELLY_EXPEL_SPECIFIC,PROC_REF(release_specific_contents))
	RegisterSignal(src, COMSIG_VORE_EXPEL_MOB_OOC,PROC_REF(ooc_escape))
	RegisterSignal(src, COMSIG_VORE_EXPEL_ALL,PROC_REF(release_all_contents))
	RegisterSignal(src, COMSIG_VORE_RECALCULATE_SLOWDOWN,PROC_REF(update_slowdowns))
	RegisterSignal(src, COMSIG_BELLY_HANDLE_TRASH,PROC_REF(hork_trash))

/obj/vore_belly/Destroy()
	// be kind, undefined
	SEND_SIGNAL(src, COMSIG_VORE_EXPEL_ALL)
	UnregisterSignal(src, list(
		COMSIG_VORE_DEVOUR_ATOM,
		COMSIG_VORE_AUTO_EMOTE,
		COMSIG_VORE_ADD_BELLY,
		COMSIG_BELLY_EXPEL_SPECIFIC,
		COMSIG_VORE_STOP_SOUNDS,
		COMSIG_VORE_EXPEL_MOB_OOC,
		COMSIG_VORE_EXPEL_ALL,
		COMSIG_PARENT_PREQDELETED,
		COMSIG_BELLY_HANDLE_TRASH,
		))
	SEND_SIGNAL(owner, COMSIG_VORE_REMOVE_BELLY, src)
	UnregisterSignal(owner, list(
		COMSIG_VORE_STOP_SOUNDS,
		COMSIG_BELLY_EXPEL_SPECIFIC,
		COMSIG_VORE_EXPEL_MOB_OOC,
		COMSIG_VORE_EXPEL_ALL,
		COMSIG_MOB_APPLY_DAMAGE,
		))
	STOP_PROCESSING(SSvore, src)
	owner = null
	QDEL_NULL(heartbeat_loop)
	QDEL_NULL(squish_loop)
	. = ..()

/obj/vore_belly/proc/add_belly(datum/source, mob/living/new_owner)
	SIGNAL_HANDLER
	owner = new_owner
	START_PROCESSING(SSvore, src)
	RegisterSignal(new_owner, COMSIG_VORE_STOP_SOUNDS,PROC_REF(stop_sounds))
	RegisterSignal(new_owner, COMSIG_BELLY_EXPEL_SPECIFIC,PROC_REF(release_specific_contents))
	RegisterSignal(new_owner, COMSIG_VORE_EXPEL_MOB_OOC,PROC_REF(ooc_escape))
	RegisterSignal(new_owner, COMSIG_VORE_EXPEL_ALL,PROC_REF(release_all_contents))
	RegisterSignal(new_owner, COMSIG_MOB_APPLY_DAMAGE,PROC_REF(pass_damage)) // OUR APC IS UNDER ATTACK

// Called whenever an atom enters this belly
/obj/vore_belly/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(old_loc in contents)
		return //Someone dropping something (or being stripdigested)
	var/mob/living/living_prey //for chat messages and blindness
	if(isliving(arrived))
		living_prey = arrived
		if(!CHECK_PREFS(living_prey, VOREPREF_BEING_PREY))
			SEND_SIGNAL(src, COMSIG_BELLY_EXPEL_SPECIFIC, living_prey) // oops! out you go!
			return
		living_prey.become_blind("belly_[REF(src)]")
		RegisterSignal(living_prey, COMSIG_MOB_DEATH,PROC_REF(digestion_death))
		RegisterSignal(living_prey, COMSIG_MOB_GHOSTIZE,PROC_REF(stop_sounds_ghostize))
		RegisterSignal(living_prey, COMSIG_LIVING_RESIST,PROC_REF(relay_resist))
		RegisterSignal(living_prey, COMSIG_ATOM_RELAYMOVE,PROC_REF(relay_resist))
		if(CHECK_PREFS(living_prey, VOREPREF_VORE_MESSAGES))
			var/raw_desc //Let's use this to avoid needing to write the reformat code twice
			if(absorbed_desc && SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE))
				raw_desc = absorbed_desc
			else if(desc)
				raw_desc = desc
			//Was there a description text? If so, it's time to format it!
			if(raw_desc)
				//Replace placeholder vars
				var/formatted_desc
				formatted_desc = replacetext(raw_desc, "%belly", lowertext(name)) //replace with this belly's name
				formatted_desc = replacetext(formatted_desc, "%pred", owner) //replace with this belly's owner
				formatted_desc = replacetext(formatted_desc, "%prey", living_prey) //replace with whatever mob entered into this belly
				to_chat(living_prey, span_notice("<B>[formatted_desc]</B>"), pref_check = VOREPREF_VORE_MESSAGES)

	RegisterSignal(arrived, COMSIG_PARENT_PREQDELETED,PROC_REF(trigger_slowdown_update))
	//Generic entered message
	SEND_SIGNAL(arrived, COMSIG_VORE_ATOM_DEVOURED, src, owner)
	SEND_SIGNAL(arrived, COMSIG_VORE_UPDATE_PANEL)
	SEND_SIGNAL(owner, COMSIG_VORE_VORE_OCCURED, src, arrived)
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	trigger_slowdown_update()
	to_chat(owner,span_notice("[arrived] slides into your [lowertext(name)]."))
	//ulp~
	play_gulp()

/obj/vore_belly/Exited(atom/movable/gone, direction)
	. = ..()
	trigger_slowdown_update()
	SEND_SIGNAL(owner, COMSIG_VORE_VORE_OCCURED, src, gone)
	UnregisterSignal(gone, COMSIG_PARENT_PREQDELETED)	
	if(!isliving(gone))
		return
	var/mob/living/living_prey = gone
	UnregisterSignal(living_prey, list(
		COMSIG_MOB_DEATH,
		COMSIG_LIVING_RESIST,
		COMSIG_ATOM_RELAYMOVE,
		COMSIG_MOB_GHOSTIZE,
	))	
	living_prey.cure_blind("belly_[REF(src)]")
	/// at some point, this will be used to tell the mob they've been vored something, and to do something about it
	/// Like swap out their sprite for one with a big ol' belly, or something.

/// Having things in your belly really slows you down!
/obj/vore_belly/proc/update_slowdowns()
	item_slowdown = get_item_slowdown()
	// mob_slowdown = get_mob_slowdown()

/obj/vore_belly/proc/trigger_slowdown_update()
	SEND_SIGNAL(owner, COMSIG_VORE_RECALCULATE_SLOWDOWN)

/obj/vore_belly/proc/get_item_slowdown()
	if(!LAZYLEN(contents)) // empty?
		return 0
	var/list/vored_items = get_nested_vored_items()
	if(!LAZYLEN(vored_items))
		return 0
	var/total_w_class = 0
	for(var/obj/item/thing in vored_items)
		total_w_class += thing.w_class // add up the total w_class of all items
		if(SEND_SIGNAL(thing, COMSIG_CONTAINS_STORAGE))
			total_w_class += thing.w_class // double the slowdown for storage items
	return min((total_w_class / LAZYLEN(vored_items)) + (LAZYLEN(vored_items) * 0.25), 4) // average w_class + 0.25 per item

/obj/vore_belly/proc/get_mob_slowdown()
	if(!LAZYLEN(contents)) // empty?
		return 0
	var/list/vored_mobs = get_nested_mobs(FALSE)
	if(!LAZYLEN(vored_mobs))
		return 0
	return LAZYLEN(vored_mobs)

/// Release all contents of this belly into the owning mob's location.
/// If that location is another mob, contents are transferred into whichever of its bellies the owning mob is in.
/// Returns the number of mobs so released.
/obj/vore_belly/proc/release_all_contents(datum/source, include_absorbed = FALSE, silent = FALSE)
	SIGNAL_HANDLER
	if(!LAZYLEN(contents))
		return FALSE
	. = 0
	for(var/atom/movable/AM_prey in contents)
		. += release_specific_contents(src, AM_prey, silent = TRUE)
	trigger_slowdown_update()
	if(silent)
		return
	play_eject()
	owner.visible_message(
		span_green("<b>[owner] expels everything from their [lowertext(name)]!</b>"), 
		pref_check = VOREPREF_VORE_MESSAGES)

// Release a specific atom from the contents of this belly into the owning mob's location.
// If that location is another mob, the atom is transferred into whichever of its bellies the owning mob is in.
// Returns the number of atoms so released.
/obj/vore_belly/proc/release_specific_contents(datum/source, atom/movable/M, silent = FALSE)
	SIGNAL_HANDLER
	if (!is_in_belly(M))
		return FALSE // They weren't in this belly anyway
	M.forceMove(drop_location())  // Move the belly contents into the same location as belly's owner.
	. = TRUE
	if(istype(M,/mob/living))
		var/mob/living/living_prey = M
		SEND_SIGNAL(src, COMSIG_VORE_STOP_SOUNDS, living_prey)
		if(owner && SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE))
			SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE, FALSE) // sets absorbtion state to FALSE
			if(ishuman(M) && ishuman(owner))
				var/mob/living/carbon/human/Prey = M
				var/mob/living/carbon/human/Pred = owner
				var/absorbed_count = 2 //Prey that we were, plus the pred gets a portion
				for(var/mob/living/P in contents)
					if(SEND_SIGNAL(P, COMSIG_VORE_ABSORBED_STATE))
						absorbed_count++
				Pred.reagents.trans_to(Prey, Pred.reagents.total_volume / absorbed_count)
	//Clean up our own business
	owner.update_icons()
	owner.update_body(TRUE)
	if(silent)
		return
	play_eject()
	owner.visible_message(
		span_green("<b>[owner] expels [M] from their [lowertext(name)]!</b>"), 
		pref_check = VOREPREF_VORE_MESSAGES)

/obj/vore_belly/proc/ooc_escape(datum/source, mob/living/living_prey)
	SIGNAL_HANDLER
	release_specific_contents(source, living_prey, TRUE)
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
			pref = VOREPREF_DIGESTION_DEATH
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
/// Ghostize signal transducer for stopping sounds
/obj/vore_belly/proc/stop_sounds_ghostize(mob/living/living_prey)
	if(!isliving(living_prey))
		return
	stop_sounds(null, living_prey) // some day I'll think ahead

/// Stops all sounds that are playing in the belly.
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

/obj/vore_belly/proc/is_in_belly(atom/movable/prey)
	return (prey in contents)

/obj/vore_belly/proc/get_vored_mobs(only_clients = TRUE)
	. = list()
	for(var/mob/living/dope in contents)
		if(only_clients && dope.ckey && !dope.client)
			continue
		. |= dope

/// Gets every fuckin mob inside you maybe
/obj/vore_belly/proc/get_nested_mobs(only_clients = TRUE)
	. = list()
	for(var/mob/living/dope in get_vored_mobs(only_clients))
		var/list/nested_bellies = list()
		SEND_SIGNAL(dope, COMSIG_VORE_GET_BELLIES, nested_bellies)
		for(var/obj/vore_belly/nest in nested_bellies)
			. |= nest.get_nested_mobs(only_clients)
		if(only_clients && dope.ckey && !dope.client)
			continue
		. |= dope

/// Gets every fuckin item in your belly
/obj/vore_belly/proc/get_vored_items()
	. = list()
	for(var/obj/item/dink in contents)
		. |= dink

/// Gets every fuckin item in your belly
/obj/vore_belly/proc/get_nested_vored_items()
	. = list()
	. = get_vored_items()
	for(var/obj/item/dink in contents)
		SEND_SIGNAL(dink, COMSIG_TRY_STORAGE_RETURN_INVENTORY, .)
	/// And if any mobs are inside, get their items too!
	// for(var/mob/living/dork in get_nested_mobs(FALSE)) // or not!
	// 	for(var/obj/item/thingy in dork.contents)
	// 		SEND_SIGNAL(thingy, COMSIG_TRY_STORAGE_RETURN_INVENTORY, .)
	// 		. |= thingy // and I mean *every* fuckin item

/// If allowed, spit up some trash
/obj/vore_belly/proc/hork_trash(datum/source, obj/item/trashthing)
	SIGNAL_HANDLER
	send_voremessage(trashthing, spit_trash_messages, null, VOREPREF_TRASH_MESSAGES)
	if(!owner.put_in_hands(trashthing))
		trashthing.forceMove(drop_location())

// Actually perform the mechanics of devouring the tasty prey.
// The purpose of this method is to avoid duplicate code, and ensure that all necessary
// steps are taken.
/obj/vore_belly/proc/nom_mob(datum/source, atom/movable/movable_prey)
	SIGNAL_HANDLER
	if(!movable_prey)
		return
	if(!owner)
		return
	if(owner.stat != CONSCIOUS)
		return
	if(isitem(movable_prey))
		if(CHECK_BITFIELD(SEND_SIGNAL(movable_prey.loc, COMSIG_TRY_STORAGE_TAKE, movable_prey, src, TRUE), NO_REMOVE_FROM_STORAGE))
			to_chat(owner,span_alert("[movable_prey] can't be taken out of [movable_prey.loc]!"))
			return FALSE
		if(!owner.temporarilyRemoveItemFromInventory(movable_prey))
			to_chat(owner, span_alert("[movable_prey] couldn't be eaten!"))
			return FALSE
	. = TRUE
	movable_prey.forceMove(src) // mobs are unbuckled anyway
	// Flavor country
	if(can_taste)
		owner.taste(null, movable_prey)
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	//owner.updateVRPanel()
	//for(var/mob/living/M in contents)
	//	M.updateVRPanel()
	// Setup the autotransfer checks if needed
	if(!isnull(transferlocation) && autotransferchance > 0)
		addtimer(CALLBACK(src,PROC_REF(check_autotransfer), movable_prey), autotransferwait)

/obj/vore_belly/proc/check_autotransfer(atom/movable/movable_prey)
	// Some sanity checks
	if(!transferlocation || !is_in_belly(movable_prey))
		return
	if(prob(autotransferchance))
		transfer_contents(movable_prey, transferlocation)
		return
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	// Didn't transfer, so wait before retrying
	addtimer(CALLBACK(src,PROC_REF(check_autotransfer), movable_prey), autotransferwait)

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
		if(SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE)) //This is required first, in case there's a person absorbed and not absorbed in a stomach.
			continue
		total_bulge += living_prey.mob_size
	if(total_bulge < bulge_size || bulge_size == 0)
		return
	return span_alert("[formatted_message]")

/// The next function gets the messages set on the belly, in human-readable format.
/// This is useful in customization boxes and such. The delimiter right now is \n\n so
/// in message boxes, this looks nice and is easily delimited.
/obj/vore_belly/proc/get_messages(type, delim = "\n\n")
	ASSERT(type == "smo" || type == "smi" || type == "dmo" || type == "dmp" || type == "em" || type == "tr")
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
		if("tr")
			raw_messages = spit_trash_messages

	var/messages = raw_messages.Join(delim)
	return messages

// The next function sets the messages on the belly, from human-readable var
// replacement strings and linebreaks as delimiters (two \n\n by default).
// They also sanitize the messages.
/obj/vore_belly/proc/set_messages(raw_text, type, delim = "\n\n")
	ASSERT(type == "smo" || type == "smi" || type == "dmo" || type == "dmp" || type == "em" || type == "tr")

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
		if("tr")
			spit_trash_messages = raw_list
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
		VOREPREF_DEATH_MESSAGES
		)
	play_death()
	//living_prey.death(1) // "Stop it he's already dead..." Basically redundant and the reason behind screaming mouse carcasses.
	var/mobkey = living_prey.ckey
	if(mobkey)
		message_admins("[key_name(owner)] has digested [key_name(living_prey)] in their [lowertext(name)] ([owner ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[owner.x];Y=[owner.y];Z=[owner.z]'>JMP</a>" : "null"])")
		log_attack("[key_name(owner)] digested [key_name(living_prey)].")

	// If digested prey is also a pred... anyone inside their bellies gets moved up.
	SEND_SIGNAL(living_prey, COMSIG_VORE_EXPEL_ALL, TRUE, TRUE)

	//Drop all items into the belly -- to be reenabled when more things become vorable
	// for(var/obj/item/W in living_prey) // cus honestly right now most things would just get yeeded out of the belly
	// 	if(!living_prey.dropItemToGround(W))
	// 		qdel(W)

	//Update owner
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	owner.update_body(TRUE)

//// Handle a mob being absorbed
/obj/vore_belly/proc/absorb_living(mob/living/living_prey)
	if(!isliving(living_prey))
		return
	if(!CHECK_PREFS(living_prey, VOREPREF_ABSORBTION))
		return
	SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE, TRUE)
	to_chat(living_prey, span_notice("[owner]'s [lowertext(name)] absorbs your body, making you part of them."), pref_check = VOREPREF_VORE_MESSAGES)
	to_chat(owner, span_notice("Your [lowertext(name)] absorbs [living_prey]'s body, making them part of you."))

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
	owner.update_body(TRUE)
	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)

//Digest a single item
//Receives a return value from digest_act that's how much nutrition
//the item should be worth
// /obj/vore_belly/proc/digest_item(obj/item/gurgled_thing)
// // 	var/digested = gurgled_thing.digest_act(src, owner)
// 	if(iscyborg(owner))
// 		var/mob/living/silicon/robot/robot_prey = owner
// 		robot_prey.cell.charge += (50 * digested)

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
	var/maxhp = owner.getMaxHealth()
	var/health_deficit = maxhp - owner.health
	var/delay_mult = max((health_deficit / (maxhp*0.25)) * (owner.stat + 1), 1) // good luck getting out of a dead guy
	var/base_escapetime = escapetime
	if(delay_mult > 2)
		base_escapetime = max(escapetime, 5 SECONDS)

	return base_escapetime * max(delay_mult, 1)

//Handle a mob struggling
// Called from /mob/living/carbon/relaymove()
/obj/vore_belly/proc/relay_resist(datum/source, mob/living/living_prey)
	SIGNAL_HANDLER
	if (!is_in_belly(living_prey))
		return  // User is not in this belly

	send_voremessage(living_prey, struggle_messages_outside, struggle_messages_inside)
	if(!escapechance && owner.stat != CONSCIOUS)
		INVOKE_ASYNC(src,PROC_REF(attempt_escape), living_prey) //If owner is stat (dead, KO) we can actually escape
		return

	if(!escapable) //If the stomach has escapable enabled.
		return
	if(prob(escapechance)) //Let's have it check to see if the prey escapes first.
		INVOKE_ASYNC(src,PROC_REF(attempt_escape), living_prey)
	if(prob(transferchance) && transferlocation) //Next, let's have it see if they end up getting into an even bigger mess then when they started.
		var/list/assbellies = list()
		SEND_SIGNAL(src, COMSIG_VORE_GET_BELLIES, assbellies, TRUE)
		var/dest_belly = assbellies[transferlocation]
		if(!dest_belly)
			to_chat(owner, span_warning("Something went wrong with your belly transfer settings. Your <b>[lowertext(name)]</b> has had it's transfer chance and transfer location cleared as a precaution."))
			transferchance = 0
			transferlocation = null
			return
		to_chat(
			living_prey,
			span_warning("Your attempt to escape [lowertext(name)] has failed and your struggles only results in you sliding into [owner]'s [transferlocation]!"),
			pref_check = VOREPREF_VORE_MESSAGES
		)
		to_chat(
			owner,
			span_warning("Someone slid into your [transferlocation] due to their struggling inside your [lowertext(name)]!")
		)
		transfer_contents(living_prey, dest_belly)
		return

	if(prob(absorbchance) && digest_mode != DM_ABSORB) //After that, let's have it run the absorb chance.
		to_chat(
			living_prey,
			span_warning("In response to your struggling, \the [lowertext(name)] begins to cling more tightly..."),
			pref_check = VOREPREF_VORE_MESSAGES
		)
		to_chat(
			owner,
			span_warning("You feel your [lowertext(name)] start to cling onto its contents...")
		)
		digest_mode = DM_ABSORB
		return

	if(prob(digestchance) && digest_mode != DM_DIGEST) //Finally, let's see if it should run the digest chance.
		to_chat(
			living_prey,
			span_warning("In response to your struggling, \the [lowertext(name)] begins to get more active..."),
			pref_check = VOREPREF_VORE_MESSAGES
		)
		to_chat(
			owner,
			span_warning("You feel your [lowertext(name)] beginning to become active!")
		)
		digest_mode = DM_DIGEST
		return

	to_chat(
		living_prey,
		span_warning("You make no progress in escaping [owner]'s [lowertext(name)]."),
		pref_check = VOREPREF_VORE_MESSAGES
	)
	to_chat(
		owner,
		span_warning("Your prey appears to be unable to make any progress in escaping your [lowertext(name)].")
	)

/obj/vore_belly/proc/attempt_escape(mob/living/living_prey)
	if(!is_in_belly(living_prey))
		return
	if(INTERACTING_WITH(owner, living_prey))
		to_chat(
			living_prey,
			span_alert("You're already trying to escape!"),
			pref_check = VOREPREF_VORE_MESSAGES
		)
		return
	var/time_to_leave = get_escape_time()
	to_chat(
		living_prey,
		span_warning("You attempt to climb out of \the [lowertext(name)]. (This will take around [time_to_leave*0.1] seconds.)"),
		pref_check = VOREPREF_VORE_MESSAGES
	)
	to_chat(
		owner,
		span_warning("Someone is attempting to climb out of your [lowertext(name)]!")
	)

	if(!do_after(
			living_prey, 
			time_to_leave,
			FALSE,
			owner,
			required_mobility_flags = NONE,
			allow_movement = TRUE,
		))
		return FALSE
	if(escapable && is_in_belly(living_prey)) //Can still escape?
		SEND_SIGNAL(src, COMSIG_BELLY_EXPEL_SPECIFIC, living_prey)
	else //Belly became inescapable or mob revived
		to_chat(
			living_prey,
			span_warning("Your attempt to escape [owner]'s [lowertext(name)] has failed!"),
			pref_check = VOREPREF_VORE_MESSAGES
		)
		to_chat(
			owner,
			span_notice("[living_prey]'s attempt to escape from your [lowertext(name)] has failed!")
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
		atom/atom_prey, 
		outside_list, 
		inside_list, 
		pref = VOREPREF_VORE_MESSAGES
		)
	var/outer_message
	if(LAZYLEN(outside_list))
		outer_message = pick(outside_list)
		outer_message = replacetext(outer_message,"%pred",owner)
		outer_message = replacetext(outer_message,"%prey",atom_prey)
		outer_message = replacetext(outer_message,"%belly",lowertext(name))
		outer_message = span_alert(outer_message)
	var/inner_message
	if(isliving(atom_prey) && LAZYLEN(inside_list))
		inner_message = pick(inside_list)
		inner_message = replacetext(inner_message,"%pred",owner)
		inner_message = replacetext(inner_message,"%prey",atom_prey)
		inner_message = replacetext(inner_message,"%belly",lowertext(name))
		inner_message = span_alert(inner_message)

	if(outer_message)
		owner.visible_message(
			outer_message,
			pref_check = pref
			)

	if(inner_message)
		to_chat(
			atom_prey,
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
	if(!CHECK_PREFS(living_prey, VOREPREF_DIGESTION_DAMAGE))
		return FALSE
	if(SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE)) // already absorbed! stop gurgling!
		return FALSE
	return TRUE

/obj/vore_belly/proc/digest_living(mob/living/living_prey)
	if(!CHECK_PREFS(living_prey, VOREPREF_DIGESTION_DAMAGE))
		return
	if(!CHECK_PREFS(living_prey, VOREPREF_DIGESTION_DEATH))
		if(living_prey.health <= ((digest_brute + digest_burn) * 2))
			return
	living_prey.adjustBruteLoss(digest_brute)
	living_prey.adjustFireLoss(digest_burn)
	owner.adjust_nutrition(1)

/obj/vore_belly/proc/can_healbelly_living(mob/living/living_prey)
	if(!CHECK_PREFS(living_prey, VOREPREF_HEALBELLY))
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
	if(!CHECK_PREFS(living_prey, VOREPREF_ABSORBTION))
		return FALSE
	return !(SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE))

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
	return SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE)

/obj/vore_belly/proc/can_unabsorb_living(mob/living/living_prey)
	if(owner.nutrition < NUTRITION_LEVEL_FED)
		return FALSE
	return SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE)

/obj/vore_belly/proc/unabsorb_living(mob/living/living_prey)
	SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE, FALSE)
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
		to_chat(
			living_prey,
			span_notice("[pick(digestion_emotes)]"),
			pref_check = VOREPREF_VORE_MESSAGES
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

/// Host takes damage? Vored critters do too
/obj/vore_belly/proc/pass_damage(datum/source, damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, damage_threshold)
	SIGNAL_HANDLER
	var/someone_hurt
	for(var/mob/living/living_prey in get_vored_mobs(FALSE))
		if(living_prey.status_flags & GODMODE)
			continue
		living_prey.apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, damage_threshold, sendsignal = FALSE)
		to_chat(living_prey, span_userdanger("The injury to [owner] hurts you as well!"), pref_check = VOREPREF_VORE_MESSAGES)
		someone_hurt = TRUE
	if(someone_hurt)
		to_chat(owner, span_userdanger("You feel a flinch inside your [name]!"), pref_check = VOREPREF_VORE_MESSAGES)

// Belly copies and then returns the copy
// Needs to be updated for any var changes AND KEPT IN ORDER OF THE VARS ABOVE AS WELL!
/obj/vore_belly/proc/copy(mob/new_owner)
	var/obj/vore_belly/dupe = new /obj/vore_belly(new_owner)

	//// Non-object variables
	dupe.name = name
	dupe.desc = desc
	dupe.absorbed_desc = absorbed_desc
	dupe.vore_sound = vore_sound
	dupe.vore_verb = vore_verb
	dupe.release_verb = release_verb
	dupe.human_prey_swallow_time = human_prey_swallow_time
	dupe.nonhuman_prey_swallow_time = nonhuman_prey_swallow_time
	dupe.emote_time = emote_time
	dupe.nutrition_percent = nutrition_percent
	dupe.digest_brute = digest_brute
	dupe.digest_burn = digest_burn
	dupe.digest_oxy = digest_oxy
	dupe.digest_tox = digest_tox
	dupe.digest_clone = digest_clone
	dupe.immutable = immutable
	dupe.can_taste = can_taste
	dupe.escapable = escapable
	dupe.escapetime = escapetime
	dupe.digestchance = digestchance
	dupe.absorbchance = absorbchance
	dupe.escapechance = escapechance
	dupe.transferchance = transferchance
	dupe.transferchance_secondary = transferchance_secondary
	dupe.transferlocation = transferlocation
	dupe.transferlocation_secondary = transferlocation_secondary
	dupe.bulge_size = bulge_size
	dupe.shrink_grow_size = shrink_grow_size
	dupe.mode_flags = mode_flags
	dupe.item_digest_mode = item_digest_mode
	dupe.contaminates = contaminates
	dupe.contamination_flavor = contamination_flavor
	dupe.contamination_color = contamination_color
	dupe.release_sound = release_sound
	dupe.fancy_vore = fancy_vore
	dupe.is_wet = is_wet
	dupe.wet_loop = wet_loop
	dupe.belly_fullscreen = belly_fullscreen
	dupe.disable_hud = disable_hud
	dupe.belly_fullscreen_color = belly_fullscreen_color
	dupe.colorization_enabled = colorization_enabled
	dupe.egg_type = egg_type
	dupe.emote_time = emote_time
	dupe.emote_active = emote_active
	dupe.selective_preference = selective_preference
	dupe.save_digest_mode = save_digest_mode
	dupe.spits_trash = spits_trash

	//// Object-holding variables
	//struggle_messages_outside - strings
	dupe.struggle_messages_outside.Cut()
	for(var/I in struggle_messages_outside)
		dupe.struggle_messages_outside += I

	//struggle_messages_inside - strings
	dupe.struggle_messages_inside.Cut()
	for(var/I in struggle_messages_inside)
		dupe.struggle_messages_inside += I

	//absorbed_struggle_messages_outside - strings
	dupe.absorbed_struggle_messages_outside.Cut()
	for(var/I in absorbed_struggle_messages_outside)
		dupe.absorbed_struggle_messages_outside += I

	//absorbed_struggle_messages_inside - strings
	dupe.absorbed_struggle_messages_inside.Cut()
	for(var/I in absorbed_struggle_messages_inside)
		dupe.absorbed_struggle_messages_inside += I

	//digest_messages_owner - strings
	dupe.digest_messages_owner.Cut()
	for(var/I in digest_messages_owner)
		dupe.digest_messages_owner += I

	//digest_messages_prey - strings
	dupe.digest_messages_prey.Cut()
	for(var/I in digest_messages_prey)
		dupe.digest_messages_prey += I

	//absorb_messages_owner - strings
	dupe.absorb_messages_owner.Cut()
	for(var/I in absorb_messages_owner)
		dupe.absorb_messages_owner += I

	//absorb_messages_prey - strings
	dupe.absorb_messages_prey.Cut()
	for(var/I in absorb_messages_prey)
		dupe.absorb_messages_prey += I

	//unabsorb_messages_owner - strings
	dupe.unabsorb_messages_owner.Cut()
	for(var/I in unabsorb_messages_owner)
		dupe.unabsorb_messages_owner += I

	//unabsorb_messages_prey - strings
	dupe.unabsorb_messages_prey.Cut()
	for(var/I in unabsorb_messages_prey)
		dupe.unabsorb_messages_prey += I

	//examine_messages - strings
	dupe.examine_messages.Cut()
	for(var/I in examine_messages)
		dupe.examine_messages += I

	//examine_messages_absorbed - strings
	dupe.examine_messages_absorbed.Cut()
	for(var/I in examine_messages_absorbed)
		dupe.examine_messages_absorbed += I

	//examine_messages_absorbed - strings
	dupe.spit_trash_messages.Cut()
	for(var/I in spit_trash_messages)
		dupe.spit_trash_messages += I

	//emote_lists - index: digest mode, key: list of strings
	dupe.emote_lists.Cut()
	for(var/K in emote_lists)
		dupe.emote_lists[K] = list()
		for(var/I in emote_lists[K])
			dupe.emote_lists[K] += I

	return dupe

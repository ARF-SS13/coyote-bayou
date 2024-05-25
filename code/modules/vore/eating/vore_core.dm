/* 
 * VORE COMPONENT FOR MOBS
 * Allows someone to be a predator
 * Not needed for prey!!!
 */

// Oh yeah, with this, after this, master will be a var that is the parent
#define VORE_MASTER var/mob/living/master = parent
/// FLOORRRR MASTERRRRRR yeah nobody's gonna get that but me
#define VORETYPE_FEED_PREY_TO_PRED 1
#define VORETYPE_FEED_US_TO_PRED 2
#define VORETYPE_EAT_PREY 3

/datum/component/vore
	// Determines if the mechanical vore preferences button will be displayed on the mob or not.
	var/showvoreprefs = TRUE
	/// Default to no vore capability.
	var/obj/vore_belly/vore_selected
	/// List of vore containers inside a mob
	var/list/vore_organs = list()
	/// What the character tastes like
	var/vore_taste = null
	/// What the character smells like
	var/vore_smell = null
	/// A weakref to our client, if any
	var/datum/weakref/client_cached
	/// Is voremode on?
	var/voremode = TRUE // yes, yes it is
	/// Am I absorbed?
	var/am_absorbed = FALSE
	/// our cached amount of stuff in our bellies -- to prevent having to loop through all bellies every time
	var/cached_belly_contents = 0

/datum/component/vore/Initialize()
	if(!SSvore.should_have_vore(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_MOB_CLIENT_LOGIN),PROC_REF(setup_vore))
	RegisterSignal(parent, list(COMSIG_VORE_SAVE_PREFS),PROC_REF(save_prefs))
	RegisterSignal(parent, list(COMSIG_VORE_LOAD_PREFS),PROC_REF(load_prefs))
	RegisterSignal(parent, list(COMSIG_VORE_ABSORBED_STATE),PROC_REF(absorbed_state))
	RegisterSignal(parent, list(COMSIG_VORE_ADD_BELLY),PROC_REF(add_belly))
	RegisterSignal(parent, list(COMSIG_VORE_REMOVE_BELLY),PROC_REF(remove_belly))
	RegisterSignal(parent, list(COMSIG_VORE_GET_BELLIES),PROC_REF(get_bellies))
	RegisterSignal(parent, list(COMSIG_VORE_HAS_BELLIES),PROC_REF(has_belly))
	RegisterSignal(parent, list(COMSIG_VORE_VERIFY_BELLY),PROC_REF(verify_belly))
	RegisterSignal(parent, list(COMSIG_VORE_SET_SELECTED_BELLY),PROC_REF(select_belly))
	RegisterSignal(parent, list(COMSIG_VORE_SWAP_BELLY_INDEX),PROC_REF(swap_belly_index))
	RegisterSignal(parent, list(COMSIG_VORE_DO_VORE),PROC_REF(vore_attack))
	RegisterSignal(parent, list(COMSIG_VORE_SNIFF_LIVING),PROC_REF(sniff_mob))
	RegisterSignal(parent, list(COMSIG_VORE_UPDATE_PANEL),PROC_REF(update_vore_panel))
	RegisterSignal(parent, list(COMSIG_VORE_TOGGLE_VOREMODE),PROC_REF(toggle_voremode))
	RegisterSignal(parent, list(COMSIG_VORE_GET_VOREMODE),PROC_REF(get_voremode))
	RegisterSignal(parent, list(COMSIG_VORE_CAN_EAT),PROC_REF(can_eat))
	RegisterSignal(parent, list(COMSIG_VORE_CAN_BE_EATEN),PROC_REF(can_be_eaten))
	RegisterSignal(parent, list(COMSIG_VORE_CAN_BE_FED_PREY),PROC_REF(can_be_fed_prey))
	RegisterSignal(parent, list(COMSIG_VORE_RECALCULATE_SLOWDOWN),PROC_REF(update_slowdowns))
	RegisterSignal(parent, list(COMSIG_VORE_CHECK_EDIBILITY),PROC_REF(can_eat_item))
	RegisterSignal(parent, list(COMSIG_VORE_DO_MESSAGE),PROC_REF(do_voremessage))
	RegisterSignal(parent, list(COMSIG_VORE_EXISTS),PROC_REF(setup_vore))
	RegisterSignal(parent, list(COMSIG_PARENT_EXAMINE),PROC_REF(examine_bellies))
	RegisterSignal(parent, list(COMSIG_MOB_DEATH),PROC_REF(you_died)) // casual
	START_PROCESSING(SSvore, src)
	if(isliving(parent))
		var/mob/living/master = parent
		if(master.client)
			setup_vore()

/datum/component/vore/proc/setup_vore(force)
	VORE_MASTER
	client_cached = WEAKREF(master.client)
	setup_verbs()
	if(!load_prefs())
		to_chat(master,span_phobia("ERROR: You seem to have saved vore prefs, but they couldn't be loaded."))
	if(LAZYLEN(vore_organs))
		vore_selected = vore_organs[1]
	return TRUE

/datum/component/vore/proc/setup_verbs()
	VORE_MASTER
	if(!master.client)
		return
	//add_verb(master, /mob/living/proc/preyloop_refresh)
	add_verb(master, /mob/living/proc/escapeOOC)
	add_verb(master, /mob/living/proc/vore_verb)
	add_verb(master, /mob/living/proc/feed_verb)
	add_verb(master, /mob/living/proc/insidePanel)
	add_verb(master, /mob/living/proc/stop_gross_loop)
	add_verb(master, /mob/living/proc/vore_verb)
	add_verb(master, /mob/living/proc/feed_verb)
	// TODO: add this and make it work
	//add_verb(master, /mob/living/proc/smell_someone)
	//add_verb(master, /mob/living/proc/toggle_voremode) // vore intent is soooo last year

/datum/component/vore/proc/absorbed_state(datum/source, set_state)
	SIGNAL_HANDLER
	if(!isnull(set_state))
		am_absorbed = set_state
	return am_absorbed

/// sets a list to be a list of bellies, without returning anything useful
/// like a magic trick. set associate to TRUE to associate the list by name. set only_selected to TRUE to just get the selected belly
/datum/component/vore/proc/get_bellies(datum/source, list/belly_list, associate, only_selected)
	SIGNAL_HANDLER
	if(!islist(belly_list))
		return FALSE
	if(associate)
		for(var/obj/vore_belly/vb in vore_organs)
			belly_list[vb.name] = vb
		return
	if(only_selected)
		belly_list |= vore_selected
		return
	belly_list |= vore_organs // still blows my mind
	return TRUE

/datum/component/vore/proc/select_belly(datum/source, obj/vore_belly/newselect)
	SIGNAL_HANDLER
	if(!(newselect in vore_organs))
		return FALSE
	vore_selected = newselect
	return TRUE

/datum/component/vore/proc/swap_belly_index(datum/source, updown)
	SIGNAL_HANDLER
	var/indexmove = 1
	var/found_it
	for(var/obj/vore_belly/gut in vore_organs)
		if(gut == vore_selected) // Find()? whats that?
			found_it = TRUE
			break
		indexmove++
	if(!found_it)
		return FALSE
	vore_organs.Swap(indexmove, indexmove + updown)
	return TRUE

/datum/component/vore/proc/has_belly()
	SIGNAL_HANDLER
	if(!islist(vore_organs))
		return FALSE
	for(var/obj/vore_belly/vb in vore_organs)
		return TRUE

/datum/component/vore/proc/load_prefs()
	SIGNAL_HANDLER
	VORE_MASTER
	if(!master?.client?.prefs)
		return FALSE
	if(!load_vore_prefs())
		return FALSE
	return TRUE
	
/datum/component/vore/proc/load_vore_prefs()
	VORE_MASTER
	// vore prefs are loaded with the client and up to date to the last save
	// so, all we really need is the smell, and the bellies
	// lovely
	var/datum/preferences/P = master.client.prefs
	SSvore.register_smell(master, P.vore_smell)
	SEND_SIGNAL(master, COMSIG_VORE_EXPEL_ALL, TRUE, TRUE)
	QDEL_LIST(vore_organs)
	for(var/entry in P.belly_prefs)
		// decodes your belly prefs and stuffs all the organs into the parent
		// The belly will register itself with us when its spawned, through the power of COMSIG
		list_to_object(entry, master)
	return TRUE

/datum/component/vore/proc/save_prefs()
	SIGNAL_HANDLER
	VORE_MASTER
	if(!master?.client?.prefs)
		return FALSE
	if(!save_vore_prefs())
		return FALSE
	return TRUE

//copy_to_prefs_vr()
/datum/component/vore/proc/save_vore_prefs()
	VORE_MASTER
	if(!master?.client?.prefs)
		to_chat(src,span_phobia("You attempted to save your vore prefs but somehow you're in this character without a client.prefs variable. Tell a dev."))
		return FALSE

	// vore prefs are saved with the rest of the prefs
	// so, all we really need are the bellies
	// lovely
	var/datum/preferences/P = master.client.prefs

	var/list/serialized = list()
	for(var/obj/vore_belly/B in vore_organs)
		serialized += list(B.serialize()) //Can't add a list as an object to another list in Byond. Thanks.

	P.belly_prefs = serialized
	P.save_character()
	return TRUE

/datum/component/vore/proc/sniff_mob(datum/source, mob/living/living_sniffer)
	if(!isliving(living_sniffer))
		return
	VORE_MASTER
	if(!CHECK_PREFS(master, VOREPREF_SNIFFABLE)) // nose to urself
		return
	var/smellmsg = SSvore.get_scent(living_sniffer)

	living_sniffer.visible_message(
		span_warning("[living_sniffer] smells [master]!"),
		span_notice("You smell [master]. [master.p_they(TRUE)] smell like [smellmsg]."),
		"<b>Sniff!</b>",
		pref_check = VOREPREF_VORE_MESSAGES)


/datum/component/vore/proc/release_vore_contents()
	VORE_MASTER
	SEND_SIGNAL(master, COMSIG_VORE_EXPEL_ALL, TRUE, TRUE)

/datum/component/vore/proc/add_belly(mob/living/source, obj/vore_belly/gut)
	RegisterSignal(gut, list(COMSIG_VORE_UPDATE_PANEL),PROC_REF(update_vore_panel))
	vore_organs |= gut

/datum/component/vore/proc/remove_belly(mob/living/source, obj/vore_belly/gut)
	UnregisterSignal(gut, list(COMSIG_VORE_UPDATE_PANEL))
	vore_organs -= gut
	if(vore_selected != gut)
		return
	if(LAZYLEN(vore_organs))
		vore_selected = vore_organs[1]
		return
	vore_selected = null

/// returns if this belly is ours
/datum/component/vore/proc/verify_belly(mob/living/source, obj/vore_belly/gut)
	return (gut in vore_organs)

/datum/component/vore/UnregisterFromParent()
	client_cached = null
	vore_selected = null
	QDEL_LIST(vore_organs)
	STOP_PROCESSING(SSvore, src)
	. = ..()

/datum/component/vore/proc/can_eat()
	VORE_MASTER
	if(master.stat != CONSCIOUS)
		return FALSE
	if(!vore_selected)
		if(!LAZYLEN(vore_organs))
			return FALSE
		if(isbelly(vore_organs[1]))
			vore_selected = vore_organs[1]
			if(!vore_selected)
				return FALSE
	return TRUE

/datum/component/vore/proc/can_be_eaten()
	VORE_MASTER
	if(!master.ckey && !master.mind && !master.client) // never had a player associated
		if(ishuman(master))
			var/mob/living/carbon/human/H = master
			if(H.last_mind) // If the mob was a player, don't let it be eaten
				return FALSE
		if(isanimal(master)) // simple animals that never had a player associated
			var/mob/living/simple_animal/SA = master
			if(SA.stat != DEAD)
				return FALSE // no killing aethergiests with your belly, kill em first
		return TRUE // If the mob never was a player, let it be eaten
	if(!CHECK_PREFS(master, VOREPREF_BEING_PREY))
		return FALSE
	return TRUE

/// Can I (master) be fed someone?
/datum/component/vore/proc/can_be_fed_prey()
	VORE_MASTER
	if(!can_eat())
		return FALSE
	if(!master.ckey && !master.mind && !master.client)
		if(ishuman(master))
			var/mob/living/carbon/human/H = master
			if(H.last_mind) // If the mob was a player, don't let it be eaten
				return FALSE
		return TRUE // If the mob never was a player, let it be eaten
	if(!CHECK_PREFS(master, VOREPREF_BEING_FED_PREY))
		return FALSE
	return TRUE

// Checks if an item is a thing and can be eaten
/datum/component/vore/proc/can_eat_item(datum/source, atom/movable/movable_prey)
	VORE_MASTER
	if(!isitem(movable_prey))
		return TRUE
	if(!master.canUnEquip(movable_prey, FALSE))
		return FALSE
	var/obj/item/thingy = movable_prey
	if(thingy.interaction_flags_item & INTERACT_ITEM_ATTACK_HAND_IS_ALT) //See if we're supposed to just altclick
		master.AltClickOn(thingy)
		return FALSE
	else if(thingy.interaction_flags_item & INTERACT_ITEM_ATTACK_HAND_IS_SHIFT) //See if we're supposed to just shiftclick
		master.ShiftClickOn(thingy)
		return FALSE
	if(!(thingy.interaction_flags_item & INTERACT_ITEM_ATTACK_HAND_PICKUP)) //See if we're supposed to auto pickup.
		to_chat(master, span_warning("You can't pick that up to eat it!"))
		return FALSE
	return TRUE

// Handle being clicked, perhaps with something to devour
//
// Refactored to use centralized vore code system - Leshana
// Critical adjustments due to TG grab changes - Poojawa
// Componentized components due to CB componentization - Superlagg
/datum/component/vore/proc/vore_attack(mob/living/source, mob/living/living_pred, atom/movable/movable_prey)
	SIGNAL_HANDLER
	VORE_MASTER // mob initiating the vore (us!)

	if(!movable_prey && !living_pred) // Cant eat without a friend
		to_chat(master, span_alert("Eat who, now?"))
		return FALSE
	if(!SSvore.can_eat(movable_prey))
		return FALSE
	if(living_pred == master && movable_prey == master)
		to_chat(master, span_alert("Try as you might, you can't quite fit inside yourself."))
		return FALSE // no eating yourself
	if(living_pred == movable_prey)
		to_chat(master, span_alert("They don't have a Klein belly."))
		return FALSE // no eating yourself
	if(living_pred && !isliving(living_pred)) //no badmin, you can't feed people to ghosts or objects. yet.
		return FALSE
	//prefilter out braindeads and inedible prey
	if(living_pred.ckey && !living_pred.client)
		to_chat(master, span_alert("[living_pred] is too unresponsive to be fed!"))
		return FALSE

	/// now check if the prey is something that can be eaten
	/// Monkeys and grenades can't consent in the moment, but they *do* have their prefs on file
	/// And they say *yes yes yes!*
	/// Also movables and non-human mobs dont have components that respond to our signals
	/// So... hack time~
	var/prey_consents
	if(isitem(movable_prey))
		var/obj/item/item_prey = movable_prey
		if(CHECK_BITFIELD(SEND_SIGNAL(item_prey.loc, COMSIG_TRY_STORAGE_TAKE, living_pred, master.loc, TRUE), NO_REMOVE_FROM_STORAGE))
			to_chat(master,span_alert("[src] can't be eaten out of [item_prey.loc]!"))
			return
		prey_consents = TRUE
	else if(isliving(movable_prey))
		var/mob/living/living_prey = movable_prey
		if(living_prey.ckey || living_prey.client)
			if(!living_prey.client)
				to_chat(master, span_alert("[living_prey] is too unresponsive to eat!"))
				return FALSE
		else
			if(living_prey.stat == CONSCIOUS)
				to_chat(master, span_alert("[living_prey] objects to being eaten! Maybe if they were dead..."))
				return FALSE
			prey_consents = TRUE

	/// Assumptions!
	/// Predator is us? we're eating prey.
	/// Predator, but no prey? we are the prey, feed us to them.
	/// Prey, but no predator? we are the predator, eat them.
	/// Prey and predator? We are feeding Prey to Predator
	/// Not concerned with anything else tbh~
	////////////////////////////////////////////////////////////

	var/what_do
	if(isliving(living_pred) && living_pred != master)
		if(movable_prey && movable_prey != master)
			what_do = VORETYPE_FEED_PREY_TO_PRED
		else
			what_do = VORETYPE_FEED_US_TO_PRED
	else
		if(movable_prey)
			what_do = VORETYPE_EAT_PREY
		else
			return FALSE // shouldnt get here, but just for cute

	switch(what_do)
		if(VORETYPE_FEED_PREY_TO_PRED)
			if(!movable_prey.Adjacent(living_pred))
				to_chat(master, span_alert("[movable_prey] is too far away from [living_pred]!"))
				return
			if(!prey_consents && !CHECK_PREFS(movable_prey, VOREPREF_BEING_PREY))
				to_chat(master, span_alert("You respect the fact that [movable_prey.name] prefers not to be eaten, and refuse to feed them to [living_pred.name]."))
				to_chat(movable_prey, span_alert("You notice that [master.name] understands your preference to not be eaten."), pref_check = VOREPREF_VORE_MESSAGES)
				to_chat(living_pred, span_alert("You notice that [master.name] understands [movable_prey.name]'s preference to not be eaten."), pref_check = VOREPREF_VORE_MESSAGES)
				return
			if(living_pred.ckey && !CHECK_PREFS(living_pred, VOREPREF_BEING_FED_PREY))
				to_chat(master, span_alert("You respect the fact that [living_pred.name] prefers not to be fed anyone, and refuse to feed [movable_prey.name] them to them."))
				to_chat(movable_prey, span_alert("You notice that [master.name] understands [living_pred.name]'s preference to not be fed to anyone."), pref_check = VOREPREF_VORE_MESSAGES)
				to_chat(living_pred, span_alert("You notice that [master.name] understands your preference to not be fed to [movable_prey.name]."), pref_check = VOREPREF_VORE_MESSAGES)
				return
			if(!prey_consents && SEND_SIGNAL(movable_prey, COMSIG_VORE_CAN_BE_EATEN) == FALSE)
				to_chat(master, span_alert("[movable_prey] would prefer not to be eaten!"))
				return FALSE // they dont want to be eaten
			if(!SEND_SIGNAL(living_pred, COMSIG_VORE_CAN_BE_FED_PREY))
				to_chat(master, span_alert("[living_pred] would prefer not to be fed!"))
				return FALSE // they cont want to eat em
			INVOKE_ASYNC(src,PROC_REF(feed_prey_to_predator), living_pred, movable_prey)
		if(VORETYPE_FEED_US_TO_PRED)
			if(!master.Adjacent(living_pred))
				to_chat(master, span_alert("You are too far away from [living_pred]!"))
				return FALSE
			if(!CHECK_PREFS(living_pred, VOREPREF_BEING_FED_PREY))
				to_chat(master, span_alert("You respect the fact that [living_pred.name] prefers not to have you feed yourself to them."))
				to_chat(living_pred, span_alert("You notice that [master.name] understands your preference not to feed themself to you."), pref_check = VOREPREF_VORE_MESSAGES)
				return
			if(!SEND_SIGNAL(living_pred, COMSIG_VORE_CAN_EAT))
				to_chat(master, span_alert("[living_pred] can't eat you right now!"))
				return FALSE
			if(!can_be_eaten()) // just in case
				to_chat(master, span_alert("You can't be eaten right now!"))
				return FALSE // they cont want to eat em
			if(!SEND_SIGNAL(living_pred, COMSIG_VORE_CAN_BE_FED_PREY))
				to_chat(master, span_alert("[living_pred] would prefer not to be fed prey!"))
				return FALSE // they cont want to eat em
			INVOKE_ASYNC(src,PROC_REF(feed_self_to_other), living_pred)
		if(VORETYPE_EAT_PREY)
			if(!master.Adjacent(movable_prey))
				to_chat(master, span_alert("You are too far away from [movable_prey]!"))
				return FALSE
			if(!prey_consents && !CHECK_PREFS(movable_prey, VOREPREF_BEING_PREY))
				to_chat(master, span_alert("You respect the fact that [movable_prey.name] prefers not to be eaten, and refuse to eat them."))
				to_chat(movable_prey, span_alert("You notice that [master.name] understands your preference to not be eaten."), pref_check = VOREPREF_VORE_MESSAGES)
				return
			if(!prey_consents && SEND_SIGNAL(movable_prey, COMSIG_VORE_CAN_BE_EATEN) == FALSE)
				to_chat(master, span_alert("[movable_prey] can't be eaten right now!"))
				return FALSE
			if(!can_eat()) // just in case
				to_chat(master, span_alert("You can't eat [movable_prey] right now!"))
				return FALSE
			INVOKE_ASYNC(src,PROC_REF(devour_prey), movable_prey)
	return TRUE

/datum/component/vore/proc/devour_prey(atom/movable/movable_prey)
	VORE_MASTER
	var/obj/vore_belly/belly = vore_selected
	if(!belly)
		to_chat(master, span_alert("Never mind!"))
		return
	perform_the_nom(movable_prey, master, belly)
	return TRUE

/datum/component/vore/proc/feed_self_to_other(mob/living/living_pred)
	VORE_MASTER
	var/list/pred_guts = list()
	SEND_SIGNAL(living_pred, COMSIG_VORE_GET_BELLIES, pred_guts)
	var/obj/vore_belly/belly = input(master, "Choose Belly") in pred_guts
	if(!belly)
		to_chat(master, span_alert("Never mind!"))
		return
	perform_the_nom(master, living_pred, belly)
	return TRUE

/datum/component/vore/proc/feed_prey_to_predator(mob/living/living_pred, atom/movable/movable_prey)
	VORE_MASTER
	var/list/pred_guts = list()
	SEND_SIGNAL(living_pred, COMSIG_VORE_GET_BELLIES, pred_guts)
	var/obj/vore_belly/belly = input(master, "Choose Belly") in pred_guts
	if(!belly)
		to_chat(master, span_alert("Never mind!"))
		return
	perform_the_nom(movable_prey, living_pred, belly)
	return TRUE

/datum/component/vore/proc/perform_the_nom(atom/movable/movable_prey, mob/living/living_pred, obj/vore_belly/belly)
	VORE_MASTER
	if(!voremode)
		to_chat(master, span_alert("You aren't in Vore Intent! You can toggle this on in your vore tab."))
		return
	if(!movable_prey)
		to_chat(master, span_phobia("You tried to eat someone, but they apparently don't exist? This might be a bug."))
		return
	if(!living_pred)
		to_chat(master, span_phobia("Someone tried to eat you (or someone else?), but something went wrong. This might be a bug?"))
		return
	if(!istype(belly))
		to_chat(master, span_phobia("Your selected belly... isn't. This might be a bug?"))
		return
	if(!SEND_SIGNAL(living_pred, COMSIG_VORE_VERIFY_BELLY, belly))
		to_chat(master, span_phobia("[belly] isn't in the right place. This might be a bug??"))
		return
	if(!movable_prey.Adjacent(master)) // let's not even bother attempting it yet if they aren't next to us.
		return FALSE
	if (!CHECK_PREFS(movable_prey, VOREPREF_BEING_PREY))
		to_chat(master, "[movable_prey] would prefer not to be eaten.")
		return FALSE

	// The belly selected at the time of noms
	var/attempt_msg = "ERROR: Vore message couldn't be created. Notify a dev. (at)"
	var/success_msg = "ERROR: Vore message couldn't be created. Notify a dev. (sc)"

	var/vverb = lowertext(belly.vore_verb)
	var/vname = lowertext(belly.name)

	// Prepare messages
	if(master == living_pred) //Feeding someone to yourself
		attempt_msg = span_warning("[living_pred] is attemping to [vverb] [movable_prey] into their [vname]!")
		success_msg = span_warning("[living_pred] manages to [vverb] [movable_prey] into their [vname]!")
	else //Feeding someone to another person
		attempt_msg = span_warning("[master] is attempting to make [living_pred] [vverb] [movable_prey] into their [vname]!")
		success_msg = span_warning("[master] manages to make [living_pred] [vverb] [movable_prey] into their [vname]!")

	// Announce that we start the attempt!
	master.visible_message(attempt_msg, pref_check = VOREPREF_VORE_MESSAGES)

	// Now give the prey time to escape... return if they did
	var/swallow_time
	if(istype(movable_prey, /mob/living/carbon/human))
		swallow_time = VORE_SWALLOW_HUMAN_TIME
	else
		swallow_time = VORE_SWALLOW_NONHUMAN_TIME

	//Timer and progress bar
	if(!do_after(
			master, 
			swallow_time,
			FALSE,
			movable_prey,
			required_mobility_flags = NONE,
			allow_movement = TRUE,
			))
		to_chat(master, span_alert("You were intererupted!"))
		to_chat(movable_prey, span_alert("They were intererupted!"))
		return FALSE
	if(!movable_prey.Adjacent(master)) //double check'd just in case they moved during the timer and the do_mob didn't fail for whatever reason
		to_chat(master, span_alert("They got away!"))
		to_chat(movable_prey, span_alert("You got away!"), pref_check = VOREPREF_VORE_MESSAGES)
		return FALSE

	// If we got this far, nom successful! Announce it!
	master.visible_message(success_msg,pref_check = VOREPREF_VORE_MESSAGES)

	// Actually shove prey into the belly.
	if(!SEND_SIGNAL(belly, COMSIG_VORE_DEVOUR_ATOM, movable_prey, master))
		to_chat(master, span_warning("Something went wrong!"))
		to_chat(movable_prey, span_warning("Something went wrong?"))
		return FALSE
	master.stop_pulling()

	if(!isliving(movable_prey))
		return TRUE // we're done here
	var/mob/living/living_prey = movable_prey
	// Inform Admins
	var/prey_braindead
	var/prey_stat
	if(living_prey.ckey)
		prey_stat = living_prey.stat//only return this if they're not an unmonkey or whatever
		if(!living_prey.client)//if they disconnected, tell us
			prey_braindead = TRUE
	if (living_pred == master)
		message_admins("[ADMIN_LOOKUPFLW(living_pred)] ate [ADMIN_LOOKUPFLW(living_prey)][!prey_braindead ? "" : " (BRAINDEAD)"][prey_stat ? " (DEAD/UNCONSCIOUS)" : ""].")
		living_pred.log_message("[key_name(living_pred)] ate [key_name(living_prey)].", LOG_ATTACK)
		living_prey.log_message("[key_name(living_prey)] was eaten by [key_name(living_pred)].", LOG_ATTACK)
	else
		message_admins("[ADMIN_LOOKUPFLW(master)] forced [ADMIN_LOOKUPFLW(living_pred)] to eat [ADMIN_LOOKUPFLW(living_prey)].")
		master.log_message("[key_name(master)] forced [key_name(living_pred)] to eat [key_name(living_prey)].", LOG_ATTACK)
		living_pred.log_message("[key_name(master)] forced [key_name(living_pred)] to eat [key_name(living_prey)].", LOG_ATTACK)
		living_prey.log_message("[key_name(master)] forced [key_name(living_pred)] to eat [key_name(living_prey)].", LOG_ATTACK)
	return TRUE

/datum/component/vore/proc/examine_bellies(datum/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER
	if(!islist(examine_list))
		return
	if(!CHECK_PREFS(examiner, VOREPREF_EXAMINE))
		return
	if(!bellies_visible_to(examiner)) //Some clothing or equipment can hide this.
		return
	for (var/obj/vore_belly/belly in vore_organs)
		examine_list += belly.get_examine_msg()

/datum/component/vore/proc/bellies_visible_to(mob/examiner)
	SIGNAL_HANDLER
	if(!examiner)
		return
	VORE_MASTER
	if(!iscarbon(master))
		return TRUE
	var/mob/living/carbon/cmaster = master
	return cmaster.is_chest_exposed()

/datum/component/vore/proc/update_vore_panel() //Panel popup update call from belly events.
	SIGNAL_HANDLER
	VORE_MASTER
	if(!master)
		return
	if(!master.client)
		return
	SStgui.update_uis(master.vorePanel)

/// Toggles vore intent
/datum/component/vore/proc/toggle_voremode()
	voremode = !voremode

/// Returns vore intent
/datum/component/vore/proc/get_voremode()
	return voremode

/datum/component/vore/proc/you_died_pre()
	SIGNAL_HANDLER

/datum/component/vore/proc/you_died()
	VORE_MASTER
	if(!isbelly(master.loc))
		return // you died fair and square!
	var/client/probably_master = RESOLVEWEAKREF(client_cached)
	if(!probably_master)
		return // must have left
	var/die = alert(
		probably_master,
		"Looks like you're dead, and likely inside someone's belly! What would you like to happen?",
		"You died",
		"Disappear",
		"Fall out",
		"Just sit there"
		)
	switch(die)
		if("Disappear")
			var/usure = alert(
				probably_master,
				"You sure? This'll delete your body! The only ways back into the round are through cloning or playing a different character!",
				"You sure?",
				"Yes, delete my body",
				"No, don't delete my body"
				)
			if(usure == "Yes, delete my body")
				to_chat(probably_master, span_alert("Okay! See you on the other side!"))
				qdel(master)
			else
				INVOKE_ASYNC(src,PROC_REF(you_died))
		if("Fall out")
			to_chat(probably_master, span_alert("Ejecting your corpse!"))
			SEND_SIGNAL(master.loc, COMSIG_BELLY_EXPEL_SPECIFIC, master)
			if(isbelly(master.loc))
				to_chat(probably_master, span_phobia("...but something went wrong. Using harsh measures!"))
				master.forceMove(master.drop_location())
				return
		else
			to_chat(probably_master, span_alert("Okay! Leaving your body alone"))

/datum/component/vore/proc/do_voremessage(datum/source, atom/movable/movable_prey, obj/vore_belly/vb, message_type, pref_type)
	SIGNAL_HANDLER
	if(!verify_belly(src, vb))
		return
	var/list/inside_list
	var/list/outside_list
	switch(message_type)
		if(VORE_MESSAGE_TYPE_STRUGGLE)
			inside_list = vb.struggle_messages_inside
			outside_list = vb.struggle_messages_outside
		if(VORE_MESSAGE_TYPE_STRUGGLE_ABSORBING)
			inside_list = vb.absorbed_struggle_messages_inside
			outside_list = vb.absorbed_struggle_messages_outside
		if(VORE_MESSAGE_TYPE_DIGEST)
			inside_list = vb.digest_messages_prey
			outside_list = vb.digest_messages_owner
		if(VORE_MESSAGE_TYPE_ABSORBED)
			inside_list = vb.absorb_messages_prey
			outside_list = vb.absorb_messages_owner
		if(VORE_MESSAGE_TYPE_UNABSORBED)
			inside_list = vb.unabsorb_messages_prey
			outside_list = vb.unabsorb_messages_owner
		if(VORE_MESSAGE_TYPE_TRASH)
			outside_list = vb.spit_trash_messages
	vb.send_voremessage(movable_prey, outside_list, inside_list, pref_type)

/datum/component/vore/process()
	update_slowdowns()

/datum/component/vore/proc/update_slowdowns()
	SIGNAL_HANDLER
	VORE_MASTER
	if(!LAZYLEN(vore_organs))
		master.remove_movespeed_modifier(/datum/movespeed_modifier/thing_in_belly)
		master.remove_movespeed_modifier(/datum/movespeed_modifier/mob_in_belly)
		return
	var/number_of_stuff = 0
	for(var/obj/vore_belly/belly in vore_organs)
		number_of_stuff += LAZYLEN(belly.contents)
	if(number_of_stuff == cached_belly_contents)
		if(prob(80)) // how 2 fix atmos
			return // We don't need to update slowdowns if the number of things in bellies hasn't changed.
	cached_belly_contents = number_of_stuff	
	var/item_slow = 0
	var/mob_slow = 0
	for(var/obj/vore_belly/belly in vore_organs)
		SEND_SIGNAL(belly, COMSIG_VORE_RECALCULATE_SLOWDOWN)
		if(belly.item_slowdown > item_slow)
			item_slow = belly.item_slowdown
		if(belly.mob_slowdown > mob_slow)
			mob_slow = belly.mob_slowdown
	if(item_slow < 1)
		master.remove_movespeed_modifier(/datum/movespeed_modifier/thing_in_belly)
	else
		master.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/thing_in_belly, TRUE, item_slow)
	if(mob_slow < 1)
		master.remove_movespeed_modifier(/datum/movespeed_modifier/mob_in_belly)
	else
		master.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/mob_in_belly, TRUE, mob_slow)


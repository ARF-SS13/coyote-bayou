/* 
 * VORE COMPONENT FOR MOBS
 * Allows someone to be a predator
 */

// Oh yeah, with this, after this, master will be a var that is the parent
#define VORE_MASTER var/mob/living/master = parent

/datum/component/vore
	var/vore_flags = 0
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

/datum/component/vore/Initialize()
	if(!SSvore.should_have_vore(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_MOB_CLIENT_LOGIN), .proc/setup_vore)
	RegisterSignal(parent, list(COMSIG_VORE_SAVE_PREFS), .proc/save_vore_prefs)
	RegisterSignal(parent, list(COMSIG_VORE_LOAD_PREFS), .proc/load_vore_prefs)
	RegisterSignal(parent, list(COMSIG_VORE_GET_VOREFLAGS), .proc/get_voreflags)
	RegisterSignal(parent, list(COMSIG_VORE_ADD_BELLY), .proc/add_belly)
	RegisterSignal(parent, list(COMSIG_VORE_REMOVE_BELLY), .proc/remove_belly)
	RegisterSignal(parent, list(COMSIG_VORE_GET_BELLIES), .proc/get_bellies)
	RegisterSignal(parent, list(COMSIG_VORE_HAS_BELLIES), .proc/has_belly)
	RegisterSignal(parent, list(COMSIG_VORE_VERIFY_BELLY), .proc/verify_belly)
	RegisterSignal(parent, list(COMSIG_VORE_SET_SELECTED_BELLY), .proc/select_belly)
	RegisterSignal(parent, list(COMSIG_VORE_SWAP_BELLY_INDEX), .proc/swap_belly_index)
	RegisterSignal(parent, list(COMSIG_VORE_SNIFF_LIVING), .proc/sniff_mob)
	RegisterSignal(parent, list(COMSIG_VORE_UPDATE_PANEL), .proc/update_vore_panel)
	RegisterSignal(parent, list(COMSIG_PARENT_EXAMINE), .proc/examine_bellies)
	RegisterSignal(parent, list(COMSIG_MOB_DEATH), .proc/you_died) // casual

/datum/component/vore/proc/setup_vore()
	VORE_MASTER
	client_cached = WEAKREF(master.client)
	setup_verbs()
	if(CHECK_BITFIELD(vore_flags, VORE_INIT))
		return
	vore_flags = SSvore.get_voreflags(master)
	if(!load_vore_prefs())
		to_chat(master,span_phobia("ERROR: You seem to have saved vore prefs, but they couldn't be loaded."))
	if(LAZYLEN(vore_organs))
		vore_selected = vore_organs[1]

/datum/component/vore/proc/setup_verbs()
	VORE_MASTER
	if(!master.client)
		return
	//add_verb(master, /mob/living/proc/preyloop_refresh)
	add_verb(master, /mob/living/proc/escapeOOC)
	add_verb(master, /mob/living/proc/smell_someone)
	if(!CHECK_BITFIELD(vore_flags, NO_VORE)) //If the mob isn't supposed to have a stomach, let's not give it an insidepanel so it can make one for itself, or a stomach.
		add_verb(master, /mob/living/proc/insidePanel)

/datum/component/vore/proc/setup_organs()
	VORE_MASTER
	if(CHECK_BITFIELD(vore_flags, VORE_INIT)) // something must have set up our organs
		return


/datum/component/vore/proc/get_voreflags()
	return vore_flags

/// sets a list to be a lit of bellies, without returning anything useful
/// like a magic trick. set associate to TRUE to associate the list by name
/datum/component/vore/proc/get_bellies(datum/source, list/belly_list, associate, only_selected)
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
	if(!(newselect in vore_organs))
		return FALSE
	vore_selected = newselect
	return TRUE

/datum/component/vore/proc/swap_belly_index(datum/source, index_start, index_end)
	vore_organs.Swap(index_start, index_end)
	return TRUE

/datum/component/vore/proc/has_belly()
	if(!islist(vore_organs))
		return FALSE
	for(var/obj/vore_belly/vb in vore_organs)
		return TRUE

//
//	Proc for applying vore preferences, given bellies
//
//copy_from_prefs_vr()
/datum/component/vore/proc/load_vore_prefs()
	VORE_MASTER
	if(!master.client)
		return FALSE
	var/client/clint = master.client
	//vore_taste = client.prefs.vore_taste
	SSvore.register_smell(master, vore_smell)
	COPY_SPECIFIC_BITFIELDS(vore_flags, clint.prefs.vore_flags, DIGESTABLE | DEVOURABLE | FEEDING | LICKABLE | SMELLABLE | ABSORBABLE | MOBVORE)
	SEND_SIGNAL(master, COMSIG_VORE_EXPEL_ALL_MOBS, TRUE, TRUE)
	QDEL_LIST(vore_organs)
	for(var/entry in clint.prefs.belly_prefs)
		// decodes your belly prefs and stuffs all the organs into the parent
		// The belly will register itself with us when its spawned, through the power of COMSIG
		list_to_object(entry, master)

	ENABLE_BITFIELD(vore_flags, VOREPREF_INIT)
	return TRUE

//copy_to_prefs_vr()
/datum/component/vore/proc/save_vore_prefs()
	VORE_MASTER
	if(!master.client)
		return FALSE
	var/client/clint = master.client
	var/save_flags = vore_flags
	DISABLE_BITFIELD(save_flags, VOREPREF_INIT | VORE_INIT)
	clint.prefs.vore_flags = save_flags
	//client.prefs.features["taste"] = dna.features["taste"]
	clint.prefs.vore_smell = SSvore.get_scent(master)

	var/list/serialized = list()
	for(var/belly in vore_organs)
		var/obj/vore_belly/B = belly
		serialized += list(B.serialize()) //Can't add a list as an object to another list in Byond. Thanks.

	clint.prefs.belly_prefs = serialized
	clint.prefs.save_character()
	to_chat(master, span_greentext("Vore settings saved!"))
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
		pref_check = VOREPREF_TEXT)


/datum/component/vore/proc/release_vore_contents()
	VORE_MASTER
	SEND_SIGNAL(master, COMSIG_VORE_EXPEL_ALL_MOBS, TRUE, TRUE)

/datum/component/vore/proc/add_belly(mob/living/source, obj/vore_belly/gut)
	RegisterSignal(gut, list(COMSIG_VORE_UPDATE_PANEL), .proc/update_vore_panel)
	vore_organs |= gut

/datum/component/vore/proc/remove_belly(mob/living/source, obj/vore_belly/gut)
	UnregisterSignal(gut, list(COMSIG_VORE_UPDATE_PANEL))
	vore_organs -= gut
	if(vore_selected == gut)
		vore_selected = null

/// returns if this belly is ours
/datum/component/vore/proc/verify_belly(mob/living/source, obj/vore_belly/gut)
	return (gut in vore_organs)

/datum/component/vore/proc/UnregisterFromParent()
	. = ..()

// Handle being clicked, perhaps with something to devour
//
// Refactored to use centralized vore code system - Leshana
// Critical adjustments due to TG grab changes - Poojawa
// Componentized components due to CB componentization - Superlagg
/datum/component/vore/proc/vore_attack(
	mob/living/source, // component owner
	mob/living/prey, // mob being eaten
	mob/living/pred // mob eating the prey
	)
	VORE_MASTER // mob initiating the vore (us!)
	set waitfor = FALSE
	if(!prey || !pred)
		return FALSE

	if(prey.ckey && !prey.client)
		to_chat(master, span_alert("[prey] is too unresponsive to eat!"))
		return
	if(prey.ckey && !pred.client)
		to_chat(master, span_alert("[pred] is too unresponsive to be fed!"))
		return

	if(pred == master && prey == master)
		return FALSE // no eating yourself

	if(!isliving(pred)) //no badmin, you can't feed people to ghosts or objects.
		return FALSE
	
	if(!SSprefbreak.allowed_by_prefs(prey, VOREPREF_BEING_PREY))
		return FALSE // no eat em

	if(!LAZYLEN(vore_organs))
		setup_organs() // try again?
		if(!LAZYLEN(vore_organs))
			return FALSE // shrug

	/// We only really care about what we're doing
	if(pred == master) // Me eat
		feed_other_to_self(prey) // Me eat Them
	else if(prey == master) // Me feed Me
		feed_self_to_other(pred) // Me feed Me to Them
	else // Me feed Them to Other
		feed_other_to_other(pred, prey)

/datum/component/vore/proc/feed_other_to_self(mob/living/living_prey)
	VORE_MASTER
	if(!CHECK_PREFS(living_prey, VOREPREF_BEING_PREY))
		to_chat(master, span_alert("You respect the fact that [living_prey.name] prefers not to be eaten, and refuse to eat them."))
		to_chat(living_prey, span_alert("You notice that [master.name] understands your preference to not be eaten."))
		return
	var/obj/vore_belly/belly = vore_selected
	if(!belly)
		to_chat(master, span_alert("Never mind!"))
		return
	perform_the_nom(living_prey, master, belly)

/datum/component/vore/proc/feed_self_to_other(mob/living/living_pred)
	VORE_MASTER
	if(!CHECK_PREFS(living_pred, VOREPREF_BEING_FED))
		to_chat(master, span_alert("You respect the fact that [living_pred.name] prefers not to have you feed yourself to them."))
		to_chat(living_pred, span_alert("You notice that [master.name] understands your preference not to feed themself to you."))
		return
	var/list/pred_guts = list()
	SEND_SIGNAL(living_pred, COMSIG_VORE_GET_BELLIES, pred_guts)
	var/obj/vore_belly/belly = input("Choose Belly") in pred_guts
	if(!belly)
		to_chat(master, span_alert("Never mind!"))
		return
	perform_the_nom(master, living_pred, belly)

/datum/component/vore/proc/feed_other_to_other(mob/living/living_prey, mob/living/living_pred)
	VORE_MASTER
	if(!CHECK_PREFS(living_prey, VOREPREF_BEING_PREY))
		to_chat(master, span_alert("You respect the fact that [living_prey.name] prefers not to be eaten, and refuse to feed them to [living_pred.name]."))
		to_chat(living_prey, span_alert("You notice that [master.name] understands your preference to not be eaten."))
		to_chat(living_pred, span_alert("You notice that [master.name] understands [living_prey.name]'s preference to not be eaten."))
		return
	if(!CHECK_PREFS(living_pred, VOREPREF_BEING_FED))
		to_chat(master, span_alert("You respect the fact that [living_pred.name] prefers not to be fed anyone, and refuse to feed [living_prey.name] them to them."))
		to_chat(living_prey, span_alert("You notice that [master.name] understands [living_pred.name]'s preference to not be fed to anyone."))
		to_chat(living_pred, span_alert("You notice that [master.name] understands your preference to not be fed to [living_prey.name]."))
		return
	var/list/pred_guts = list()
	SEND_SIGNAL(living_pred, COMSIG_VORE_GET_BELLIES, pred_guts)
	var/obj/vore_belly/belly = input("Choose Belly") in pred_guts
	if(!belly)
		to_chat(master, span_alert("Never mind!"))
		return
	perform_the_nom(living_prey, living_pred, belly)

/datum/component/vore/proc/perform_the_nom(mob/living/living_prey, mob/living/living_pred, obj/vore_belly/belly)
	//Sanity
	VORE_MASTER
	if(!living_prey)
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
	if(!living_prey.Adjacent(master)) // let's not even bother attempting it yet if they aren't next to us.
		return FALSE
	if (!CHECK_PREFS(living_prey, VOREPREF_BEING_PREY))
		to_chat(master, "[living_prey] would prefer not to be eaten.")
		return FALSE

	// The belly selected at the time of noms
	var/attempt_msg = "ERROR: Vore message couldn't be created. Notify a dev. (at)"
	var/success_msg = "ERROR: Vore message couldn't be created. Notify a dev. (sc)"

	var/vverb = lowertext(belly.vore_verb)
	var/vname = lowertext(belly.name)

	// Prepare messages
	if(master == living_pred) //Feeding someone to yourself
		attempt_msg = span_warning("[living_pred] is attemping to [vverb] [living_prey] into their [vname]!")
		success_msg = span_warning("[living_pred] manages to [vverb] [living_prey] into their [vname]!")
	else //Feeding someone to another person
		attempt_msg = span_warning("[master] is attempting to make [living_pred] [vverb] [living_prey] into their [vname]!")
		success_msg = span_warning("[master] manages to make [living_pred] [vverb] [living_prey] into their [vname]!")

	// Announce that we start the attempt!
	master.visible_message(
		attempt_msg,
		pref_check = VOREPREF_TEXT
		)

	// Now give the prey time to escape... return if they did
	var/swallow_time
	if(istype(living_prey, /mob/living/carbon/human))
		swallow_time = VORE_SWALLOW_HUMAN_TIME
	else
		swallow_time = VORE_SWALLOW_NONHUMAN_TIME

	//Timer and progress bar
	if(!do_after(
			master, 
			swallow_time,
			FALSE,
			living_prey,
			required_mobility_flags = NONE,
			allow_movement = TRUE,
			))
		to_chat(master, span_alert("You were intererupted!"))
		to_chat(living_prey, span_alert("You were intererupted!"))
	if(!living_prey.Adjacent(master)) //double check'd just in case they moved during the timer and the do_mob didn't fail for whatever reason
		return FALSE

	// If we got this far, nom successful! Announce it!
	master.visible_message(
		success_msg,
		pref_check = VOREPREF_TEXT
		)

	// Actually shove prey into the belly.
	belly.nom_mob(living_prey, master)
	master.stop_pulling()

	// Flavor country
	if(belly.can_taste)
		master.taste(null, living_prey)

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
	if(!islist(examine_list))
		return
	if(!CHECK_PREFS(examiner, VOREPREF_EXAMINE))
		return
	if(!bellies_visible_to(examiner)) //Some clothing or equipment can hide this.
		return
	var/list/msg_out = list()
	for (var/obj/vore_belly/belly in vore_organs)
		msg_out += belly.get_examine_msg()
	return msg_out

/datum/component/vore/proc/bellies_visible_to(mob/examiner)
	if(!examiner)
		return
	VORE_MASTER
	if(!iscarbon(master))
		return TRUE
	var/mob/living/carbon/cmaster = master
	return cmaster.is_chest_exposed()

/datum/component/vore/proc/update_vore_panel() //Panel popup update call from belly events.
	VORE_MASTER
	if(!master)
		return
	if(!master.client)
		return
	SStgui.update_uis(master.vorePanel)

/datum/component/vore/proc/you_died()
	VORE_MASTER
	if(!isbelly(master.loc))
		return // you died fair and square!
	var/client/probably_master = RESOLVEREF(client_cached)
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
				INVOKE_ASYNC(src, .proc/you_died)
		if("Fall out")
			to_chat(probably_master, span_alert("Ejecting your corpse!"))
			SEND_SIGNAL(master.loc, COMSIG_VORE_EXPEL_MOB, master)
			if(isbelly(master.loc))
				to_chat(probably_master, span_phobia("...but something went wrong. Using harsh measures!"))
				master.forceMove(master.drop_location())
				return
		else
			to_chat(probably_master, span_alert("Okay! Leaving your body alone"))




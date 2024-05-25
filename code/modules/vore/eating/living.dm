///////////////////// Mob Living /////////////////////
/mob/living/ComponentInitialize()
	. = ..()
	RegisterSignal(src, list(COMSIG_MOB_CLIENT_LOGIN, COMSIG_MOB_KEY_CHANGE),PROC_REF(vorify))

/mob/living/proc/vorify()
	if(!CHECK_PREFS(src, VOREPREF_MASTER))
		return // no vore, no problem
	if(SEND_SIGNAL(src, COMSIG_VORE_EXISTS))
		return // already vorified
	AddComponent(/datum/component/vore) // Vore is a component now. What a time to be alive

/mob/living/proc/stop_gross_loop()
	set name = "Stop Voresounds"
	set category = "Private"
	SEND_SIGNAL(loc, COMSIG_VORE_STOP_SOUNDS, src)

// OOC Escape code for pref-breaking or AFK preds
//
/mob/living/proc/escapeOOC()
	set name = "OOC Escape"
	set category = "Private"

	if(!isbelly(loc))
		return
	var/obj/vore_belly/vb = loc
	if(!vb.is_in_belly(src))
		to_chat(src, span_phobia("You aren't in that belly! This might be a bug!"))
		return
	var/confirm = alert(
		src, 
		"You're currently in a belly, and want to escape through OOC methods. If this is for prefbreak reasons, \
		you may also inform staff! What would you like to do?", 
		"Confirmation", 
		"Escape", 
		"Escape and Inform Staff", 
		"Stay Put"
	)
	var/yesm = (confirm == "Escape" || confirm == "Escape and Inform Staff")
	if(!yesm)
		return

	if(confirm == "Escape and Inform Staff")
		message_admins("[key_name(src, TRUE, TRUE)] used OOC escape to escape from [key_name(vb.owner, TRUE, TRUE)]'s belly ([vb.name]), and has indicated it was due to a [span_phobia("prefbreak")]!")
		log_consent("[key_name(src, TRUE, TRUE)] used OOC escape to escape from [key_name(vb.owner, TRUE, TRUE)]]'s belly ([vb.name]), and has indicated it was due to a [span_phobia("prefbreak")]!")
		for(var/client/C in GLOB.admins)
			SEND_SOUND(C, sound('sound/effects/meow1.ogg')) // Someow's in troubmeow!
	else
		message_admins("[key_name(src, TRUE, TRUE)] used OOC escape to escape from [key_name(vb.owner, TRUE, TRUE)]]'s belly ([vb.name]).")
		log_consent("[key_name(src, TRUE, TRUE)] used OOC escape to escape from [key_name(vb.owner, TRUE, TRUE)]]'s belly ([vb.name]).")

	SEND_SIGNAL(loc, COMSIG_VORE_EXPEL_MOB_OOC, src)

//
// Equally important as the above
//
/mob/living/proc/smell_someone()
	set name = "Smell Someone"
	set category = "Private"
	set desc = "Smell someone nearby!"

	var/list/smellable = list()
	for(var/mob/living/L in view(1))
		if(L == src)
			continue
		if(!CHECK_PREFS(L, VOREPREF_SNIFFABLE))
			continue
		smellable[L] = new /mutable_appearance(L)
	if(!LAZYLEN(smellable))
		return
	var/mob/living/sniffed = show_radial_menu(src, src, smellable, radius = 40, require_near = TRUE)
	if(!Adjacent(sniffed))
		return
	SEND_SIGNAL(sniffed, COMSIG_VORE_SNIFF_LIVING, src)

/mob/living/proc/toggle_voremode()
	set name = "Toggle Vore Intent"
	set category = "Private"
	set desc = "Set whether or not hitting yourself (or someone else) with a grabbed person will do the vore."

	SEND_SIGNAL(src, COMSIG_VORE_TOGGLE_VOREMODE)
	var/modenow = SEND_SIGNAL(src, COMSIG_VORE_GET_VOREMODE)
	to_chat(src, span_notice("Your vore intent is now [modenow ? span_greentext("active") : span_redtext("inactive")]!"))

/mob/living/proc/vore_verb()
	set name = "Vore"
	set category = "Private"
	set desc = "Vore someone!"

	emote("vore")

/mob/living/proc/feed_verb()
	set name = "Feed"
	set category = "Private"
	set desc = "Feed someone to someone!"

	emote("feed")


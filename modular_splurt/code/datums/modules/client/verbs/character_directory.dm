GLOBAL_DATUM(character_directory, /datum/character_directory)
GLOBAL_LIST_INIT(char_directory_tags, list("Pred", "Pred-Pref", "Prey", "Prey-Pref", "Switch", "Non-Vore", "Unset"))
GLOBAL_LIST_INIT(char_directory_erptags, list("Top", "Bottom", "Switch", "No ERP", "Unset"))

/client
	COOLDOWN_DECLARE(char_directory_cooldown)

/client/verb/show_character_directory()
	set name = "Character Directory"
	set category = "OOC"
	set desc = "Shows a listing of all active characters, along with their associated OOC notes, flavor text, and more."

	// This is primarily to stop malicious users from trying to lag the server by spamming this verb
	if(!COOLDOWN_FINISHED(src, char_directory_cooldown))
		to_chat(src, span_alert("Hold your horses! Its still refreshing!"))
		return
	COOLDOWN_START(src, char_directory_cooldown, 10)

	if(!GLOB.character_directory)
		GLOB.character_directory = new
	GLOB.character_directory.ui_interact(mob)


// This is a global singleton. Keep in mind that all operations should occur on user, not src.
/datum/character_directory

/datum/character_directory/ui_state(mob/user)
	return GLOB.always_state

/datum/character_directory/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CharacterDirectory", "Character Directory")
		ui.open()

/datum/character_directory/ui_data(mob/user)
	. = ..()
	var/list/data = .

	if (user?.client?.prefs)
		data["personalVisibility"] = user.client.prefs.show_in_directory
		data["personalTag"] = user.client.prefs.directory_tag || "Unset"
		data["personalErpTag"] = user.client.prefs.directory_erptag || "Unset"
		data["prefsOnly"] = TRUE

	data["canOrbit"] = isobserver(user)

	return data

/datum/character_directory/ui_static_data(mob/user)
	. = ..()
	var/list/data = .

	var/list/directory_mobs = list()
	for(var/client/C in GLOB.clients)
		// Allow opt-out and filter players not in the game
		// if(!C.prefs.show_in_directory)
		// 	continue

		// These are the three vars we're trying to find
		// The approach differs based on the mob the client is controlling
		var/name = null
		var/species = null
		var/ooc_notes = null
		var/flavor_text = null
		var/tag
		var/erptag
		var/character_ad
		var/ref = REF(C?.mob)
		var/mob/M = C?.mob
		tag = C.prefs.directory_tag || "Unset"
		erptag = C.prefs.directory_erptag || "Unset"
		character_ad = C.prefs.directory_ad

		name = M?.real_name
		if((isdead(M) && (lowertext(M.real_name) == M.ckey || lowertext(M.name) == M.ckey)))
			name = pick(GLOB.cow_names + GLOB.carp_names + GLOB.megacarp_last_names)

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			species = "[H.custom_species ? H.custom_species : H.dna.species]"
		else if(isanimal(M))
			var/mob/living/simple_animal/SA = M
			species = initial(SA.name)
		if(!species)
			species = "Resident"
		ooc_notes = C.prefs.features["ooc_notes"]
		flavor_text = C.prefs.features["flavor_text"]

		// It's okay if we fail to find OOC notes and flavor text
		// But if we can't find the name, they must be using a non-compatible mob type currently.
		if(!name)
			continue

		directory_mobs.Add(list(list(
			"name" = name,
			"species" = species,
			"ooc_notes" = ooc_notes,
			"tag" = tag,
			"erptag" = erptag,
			"character_ad" = character_ad,
			"flavor_text" = flavor_text,
			"ref" = ref
		)))

	data["directory"] = directory_mobs

	return data

/datum/character_directory/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	var/mob/user = usr
	if(!user)
		return

	switch(action)
		if("refresh")
			// This is primarily to stop malicious users from trying to lag the server by spamming this verb
			if(!COOLDOWN_FINISHED(user.client, char_directory_cooldown))
				to_chat(user, "<span class='warning'>Don't spam character directory refresh.</span>")
				return
			COOLDOWN_START(user.client, char_directory_cooldown, 10)
			update_static_data(user, ui)
			return TRUE
		if("orbit")
			var/ref = params["ref"]
			var/mob/dead/observer/ghost = user
			var/atom/movable/poi = (locate(ref) in GLOB.mob_list) || (locate(ref) in GLOB.poi_list)
			if (poi == null)
				return TRUE
			ghost.ManualFollow(poi)
			ghost.reset_perspective(null)
			return TRUE
		else
			return check_for_mind_or_prefs(user, action, params["overwrite_prefs"])

/datum/character_directory/proc/check_for_mind_or_prefs(mob/user, action, overwrite_prefs)
	if (!user.client)
		return
	var/can_set_prefs = overwrite_prefs && !!user.client.prefs
	var/can_set_mind = !!user.mind && !isdead(user)
	if (!can_set_prefs && !can_set_mind)
		if (!overwrite_prefs && !!user.client.prefs)
			to_chat(user, "<span class='warning'>You cannot change these settings if you don't have a mind to save them to. Enable overwriting prefs and switch to a slot you're fine with overwriting.</span>")
		return
	switch(action)
		if ("setTag")
			var/list/new_tag = input(user, "Pick a new Vore tag for the character directory", "Character Tag") as null|anything in GLOB.char_directory_tags
			if(!new_tag)
				return
			return set_for_mind_or_prefs(user, action, new_tag)
		if ("setErpTag")
			var/list/new_erptag = input(user, "Pick a new ERP tag for the character directory", "Character ERP Tag") as null|anything in GLOB.char_directory_erptags
			if(!new_erptag)
				return
			return set_for_mind_or_prefs(user, action, new_erptag)
		if ("setVisible")
			var/visible = user.client.prefs.show_in_directory
			to_chat(user, "<span class='notice'>You are now [!visible ? "shown" : "not shown"] in the directory.</span>")
			return set_for_mind_or_prefs(user, action, !visible)
		if ("editAd")
			var/current_ad = user.client.prefs.directory_ad
			var/new_ad = stripped_multiline_input_or_reflect(user, "Change your character ad", "Character Ad", current_ad, MAX_FLAVOR_LEN)
			if(isnull(new_ad))
				to_chat(user, span_notice("Okay! Your ad has not been changed!"))
				return
			return set_for_mind_or_prefs(user, action, new_ad)
		else
			to_chat(user, span_warning("You can only make temporary changes while in game"))

/datum/character_directory/proc/set_for_mind_or_prefs(mob/user, action, new_value)
	if(!user || !user.client)
		return
	var/datum/preferences/P = user.client.prefs
	if(!P)
		return
	switch(action)
		if ("setTag")
			P.directory_tag = new_value
		if ("setErpTag")
			P.directory_erptag = new_value
		if ("setVisible")
			P.show_in_directory = new_value
		if ("editAd")
			P.directory_ad = new_value
	P.save_character()
	return TRUE

// /datum/mind
// 	var/show_in_directory
// 	var/directory_tag
// 	var/directory_erptag
// 	var/directory_ad
// 	var/ooc_notes
// 	var/flavor_text
// 	var/silicon_flavor_text

// /mob/living/mind_initialize()
// 	. = ..()
// 	if(client?.prefs)
// 		mind.show_in_directory = client.prefs.show_in_directory
// 		mind.directory_tag = client.prefs.directory_tag
// 		mind.directory_erptag = client.prefs.directory_erptag
// 		mind.directory_ad = client.prefs.directory_ad
// 		mind.ooc_notes = client.prefs.features["ooc_notes"]
// 		mind.flavor_text = client.prefs.features["flavor_text"]
// 		mind.silicon_flavor_text = client.prefs.features["silicon_flavor_text"]

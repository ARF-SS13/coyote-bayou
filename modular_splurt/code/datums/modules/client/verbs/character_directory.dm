GLOBAL_DATUM(character_directory, /datum/character_directory)
GLOBAL_LIST_INIT(char_directory_vore_tags, list("Pred", "Pred-Pref", "Prey", "Prey-Pref", "Switch", "Non-Vore", "Unset"))
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
	var/list/data = list()

	data["personalName"] = user.real_name
	if (user?.client?.prefs)
		data["personalVisibility"] = user.client.prefs.show_in_directory
		data["personalTag"] = user.client.prefs.directory_tag || "Unset"
		data["personalErpTag"] = user.client.prefs.directory_erptag || "Unset"
		var/adtext = user.client.prefs.directory_ad
		if(LAZYLEN(adtext) > 256)
			adtext = copytext(adtext, 1, 256) + "..."
		else if(!adtext)
			adtext = "Unset"
		data["personalAdvert"] = adtext
		var/fricktext = user.client.prefs.features["flist"]
		if(!fricktext)
			fricktext = "Unset"
		data["personalFlist"] = fricktext || "Unset"
		data["prefsOnly"] = TRUE
		data["personalDMs"] = user.client.prefs.dm_open
		data["personalQuid"] = user.client.prefs.quester_uid
		data["personalLookingForFriends"] = user.client.prefs.needs_a_friend
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
		var/ref = REF(C?.mob)
		var/mob/M = C?.mob
		if(!M)
			continue
		var/name = SSchat.name_or_shark(M) //C.prefs.real_name || M.real_name || M.name
		var/thegender = capitalize(C.prefs.gender || M.gender || "Other")
		var/whokisser = "Unsure"
		var/species
		var/ooc_notes = null
		var/flavor_text = null
		var/tag = "Unset"
		var/erptag = "Unset"
		var/character_ad = "Unset"
		var/fricklist = "Unset"
		tag = C.prefs.directory_tag || "Unset"
		erptag = C.prefs.directory_erptag || "Unset"
		character_ad = C.prefs.directory_ad
		if(C) // clients are squirly thing
			switch(C.prefs.kisser)
				if(KISS_BOYS)
					whokisser = "Likes Boys"
				if(KISS_GIRLS)
					whokisser = "Likes Girls"
				if(KISS_ANY)
					whokisser = "Likes Anyone"
				if(KISS_NONE)
					whokisser = "Not Interested"

		if(isdead(M) && lowertext(name) == ckey(M.ckey))
			var/testname = C.prefs.real_name
			if(lowertext(testname) == M.ckey)
				name = C.prefs.my_shark
			else
				name = testname
		// It's okay if we fail to find OOC notes and flavor text
		// But if we can't find the name, they must be using a non-compatible mob type currently.
		if(!name)
			continue
		if(LAZYLEN(name) > 28) // dammit colfer
			name = copytext(name, 1, 25) + "..."

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			species = "[H.custom_species ? H.custom_species : H.dna.species]"
		else if(isanimal(M))
			var/mob/living/simple_animal/SA = M
			species = initial(SA.name)
		else
			species = C.prefs.pref_species
		if(!species)
			species = "[GLOB.megacarp_first_names] [GLOB.megacarp_last_names]"
		ooc_notes = C.prefs.features["ooc_notes"]
		flavor_text = C.prefs.features["flavor_text"]

		fricklist = C.prefs.features["flist"] || FALSE
		var/thepic = C.prefs.profilePicture ? PfpHostLink(C.prefs.profilePicture, C.prefs.pfphost) : ""

		directory_mobs.Add(list(list(
			"name" = name,
			"species" = species,
			"ooc_notes" = ooc_notes,
			"tag" = tag,
			"erptag" = erptag,
			"character_ad" = character_ad,
			"flavor_text" = flavor_text,
			"ref" = ref,
			"gender" = thegender,
			"whokisser" = whokisser,
			"flist" = fricklist,
			"quid" = C.prefs.quester_uid, // love is a quest, and I'm on a quest for love
			"dms_r_open" = TRUE,
			"looking_for_friends" = C.prefs.needs_a_friend,
			"profile_pic" = thepic,
		)))

	if(SSchat.debug_character_directory)
		for(var/i in 1 to SSchat.debug_character_directory)
			directory_mobs.Add(list(list(
				"name" = (safepick(GLOB.megacarp_first_names) + " " + safepick(GLOB.megacarp_last_names)),
				"species" = "Test Species",
				"ooc_notes" = "Test OOC Notes",
				"tag" = "Test Tag",
				"erptag" = "Test ERP Tag",
				"character_ad" = "Test Ad",
				"flavor_text" = "Test Flavor Text",
				"ref" = null,
				"gender" = "Fluid",
				"whokisser" = "Likes Anyone",
				"flist" = "Test F-List",
				"quid" = "Test QUID",
				"dms_r_open" = TRUE,
				"looking_for_friends" = TRUE,
				"profile_pic" = "https://www.example.com/test.jpg"
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
				to_chat(user, span_alert("Hold your horses! Its still refreshing!"))
				return
			COOLDOWN_START(user.client, char_directory_cooldown, 5)
			update_static_data(user, ui)
			return TRUE
		if("orbit")
			if(!isobserver(user))
				return TRUE
			var/ref = params["ref"]
			var/mob/dead/observer/ghost = user
			var/atom/movable/poi = (locate(ref) in GLOB.mob_list) || (locate(ref) in GLOB.poi_list)
			if (poi == null)
				return TRUE
			ghost.ManualFollow(poi)
			ghost.reset_perspective(null)
			return TRUE
		if("view_flist")
			var/mob/them = extract_mob(params["quid"])
			if(them)
				to_chat(user, span_notice("Opening F-list..."))
				SEND_SIGNAL(them, COMSIG_FLIST, user)
				return TRUE
			else
				to_chat(user, span_alert("Couldn't find that character's F-list!"))
				return TRUE
		if("inspect")
			var/list/payload = list()
			payload["quid"] = params["quid"]
			payload["my_quid"] = params["my_quid"]
			payload["name"] = params["name"]
			payload["species"] = params["species"]
			payload["ooc_notes"] = params["ooc_notes"]
			payload["tag"] = params["tag"]
			payload["erptag"] = params["erptag"]
			payload["character_ad"] = params["character_ad"]
			payload["flavor_text"] = params["flavor_text"]
			payload["ref"] = params["ref"]
			payload["gender"] = params["gender"]
			payload["whokisser"] = params["whokisser"]
			payload["flist"] = params["flist"]
			payload["quid"] = params["quid"]
			payload["dms_r_open"] = TRUE
			payload["looking_for_friends"] = params["looking_for_friends"]
			payload["profile_pic"] = params["profile_pic"]
			SSchat.inspect_character(user, payload)
		if("pager")
			SSchat.start_page(user, params["quid"])
			// update_static_data(user, ui)
		if("setLookingForFriends")
			TOGGLE_VAR(user.client.prefs.needs_a_friend)
			if(!COOLDOWN_FINISHED(user.client, char_directory_cooldown))
				return
			COOLDOWN_START(user.client, char_directory_cooldown, 5)
			// update_static_data(user, ui)
		else
			return check_for_mind_or_prefs(user, action, params["overwrite_prefs"])
	return TRUE

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
			var/list/new_tag = input(user, "Pick a new Vore tag for the character directory", "Character Tag") as null|anything in GLOB.char_directory_vore_tags
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
		if ("setDMs")
			var/doom2 = user.client.prefs.dm_open
			to_chat(user, "<span class='notice'>You are [!doom2 ? "now open for" : "no longer open for"] direct OOC messaging.</span>")
			return set_for_mind_or_prefs(user, action, !doom2)
		if ("editAd")
			var/current_ad = user.client.prefs.directory_ad
			var/new_ad = stripped_multiline_input_or_reflect(user, "Change your character ad. Most HTML is supported! =3", "Character Ad", current_ad, MAX_FLAVOR_LEN)
			if(isnull(new_ad))
				to_chat(user, span_notice("Okay! Your ad has not been changed!"))
				return
			return set_for_mind_or_prefs(user, action, new_ad)
		if ("editFlist")
			var/current_flist = user.client.prefs.features["flist"]
			var/link = stripped_input(
				user,
				"Set always-visible F-list. Just copy and paste the link you want to use from the browser. Leave it blank to remove the previous link.",
				"F-list",
				current_flist,
				256
			)
			if(!length(link))
				set_for_mind_or_prefs(user, action, link)
				to_chat(usr, span_alert("Removed the previous F-list link."))
			else if(findtext(link, "https://www.f-list.net"))  //we want to avoid malicious links, so let's check if it's actually a valid link first
				set_for_mind_or_prefs(user, action, link)
				to_chat(usr, span_green("F-list link added!"))
			if(isnull(link))
				to_chat(user, span_notice("Okay! Your flist has not been changed!"))
				return

/datum/character_directory/proc/set_for_mind_or_prefs(mob/user, action, new_value)
	if(!user || !user.client)
		return
	var/datum/preferences/P = user.client.prefs
	if(!P)
		return
	switch(action)
		if ("setTag")
			P.directory_tag = new_value
		if ("setDMs")
			P.dm_open = new_value
		if ("setErpTag")
			P.directory_erptag = new_value
		if ("setVisible")
			P.show_in_directory = new_value
		if ("editAd")
			P.directory_ad = new_value
		if ("editFlist")
			if(!length(new_value))
				P.features["flist"] = ""
				to_chat(usr, span_alert("Removed the previous F-list link."))
			else if(findtext(new_value, "https://www.f-list.net"))  //we want to avoid malicious links, so let's check if it's actually a valid link first
				P.features["flist"] = new_value
				to_chat(usr, span_green("F-list link added!"))
			else
				P.features["flist"] = ""
				to_chat(usr, span_alert("This is not a correct F-list link!"))
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

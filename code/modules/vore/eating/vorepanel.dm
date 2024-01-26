//
// Vore management panel for players
//

#define BELLIES_MAX 40
#define BELLIES_NAME_MIN 2
#define BELLIES_NAME_MAX 40
#define BELLIES_DESC_MAX 4096
#define FLAVOR_MAX 400

/mob/living
	var/datum/vore_look/vorePanel

/mob/living/proc/insidePanel()
	set name = "Vore Panel"
	set category = "Private"

	if(!vorePanel)
		log_game("VORE: [src] ([type], \ref[src]) didn't have a vorePanel and tried to use the verb.")
		vorePanel = new(src)

	vorePanel.ui_interact(src)

//
// Callback Handler for the Inside form
//
/datum/vore_look
	var/mob/living/host // Note, we do this in case we ever want to allow people to view others vore panels
	var/unsaved_changes = FALSE
	var/show_pictures = TRUE

/datum/vore_look/New(mob/living/new_host)
	if(istype(new_host))
		host = new_host
		RegisterSignal(host, COMSIG_PARENT_QDELETING,PROC_REF(disown))
	. = ..()

/datum/vore_look/Destroy()
	disown()
	. = ..()

/datum/vore_look/proc/disown()
	host = null

/datum/vore_look/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VorePanel", "Vore Panel")
		ui.open()

// This looks weird, but all tgui_host is used for is state checking
// So this allows us to use the self_state just fine.
/datum/vore_look/ui_host(mob/user)
	return host

// Note, in order to allow others to look at others vore panels, this state would need
// to be modified.
/datum/vore_look/ui_state(mob/user)
	return GLOB.ui_vorepanel_state

/datum/vore_look
	var/static/list/nom_icons

/datum/vore_look/proc/cached_nom_icon(atom/target)
	LAZYINITLIST(nom_icons)

	var/key = ""
	if(isobj(target))
		key = "[target.type]"
	else if(ismob(target))
		var/mob/living_prey = target
		key = "\ref[target][living_prey.real_name]"
	if(nom_icons[key])
		. = nom_icons[key]
	else
		. = icon2base64(getFlatIcon(target,defdir=SOUTH,no_anim=TRUE))
		nom_icons[key] = .

/datum/vore_look/ui_data(mob/user)
	var/list/data = list()

	if(!host)
		return data

	data["unsaved_changes"] = unsaved_changes
	data["show_pictures"] = show_pictures

	var/atom/hostloc = host.loc
	var/list/inside = list()
	if(isbelly(hostloc))
		var/obj/vore_belly/inside_belly = hostloc
		var/mob/living/pred = inside_belly.owner
		inside = list(
			"absorbed" = SEND_SIGNAL(host, COMSIG_VORE_ABSORBED_STATE),
			"belly_name" = inside_belly.name,
			"belly_mode" = inside_belly.digest_mode,
			"desc" = inside_belly.desc || "No description.",
			"pred" = pred,
			"ref" = "\ref[inside_belly]",
		)

		var/list/inside_contents = list()
		for(var/atom/movable/O in inside_belly)
			if(O == host)
				continue

			var/list/info = list(
				"name" = "[O]",
				"absorbed" = FALSE,
				"stat" = 0,
				"ref" = "\ref[O]",
				"outside" = FALSE,
			)
			if(show_pictures)
				info["icon"] = cached_nom_icon(O)
			if(isliving(O))
				var/mob/living/living_prey = O
				info["stat"] = living_prey.stat
				if(SEND_SIGNAL(host, COMSIG_VORE_ABSORBED_STATE))
					info["absorbed"] = TRUE
			inside_contents.Add(list(info))
		inside["contents"] = inside_contents
	data["inside"] = inside

	var/list/our_bellies = list()
	var/list/vorgans = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, vorgans)
	var/list/selectorgan = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, selectorgan, FALSE, TRUE)
	var/obj/vore_belly/selected = LAZYLEN(selectorgan) ? selectorgan[1] : null
	for(var/belly in vorgans)
		var/obj/vore_belly/B = belly
		our_bellies.Add(list(list(
			"selected" = (B == selected),
			"name" = B.name,
			"ref" = "\ref[B]",
			"digest_mode" = B.digest_mode,
			"contents" = LAZYLEN(B.contents),
		)))
	data["our_bellies"] = our_bellies

	var/list/selected_list = null
	if(selected)
		selected_list = list(
			"belly_name" = selected.name,
			"is_wet" = selected.is_wet,
			"wet_loop" = selected.wet_loop,
			"mode" = selected.digest_mode,
			"verb" = selected.vore_verb,
			"desc" = selected.desc,
			"sound" = selected.vore_sound,
			"release_sound" = selected.release_sound,
			"can_taste" = selected.can_taste,
			"bulge_size" = selected.bulge_size,
			"digestion_brute" = selected.digest_brute,
			"digestion_burn" = selected.digest_burn,
			"hork_trash" = selected.spits_trash
		)

		selected_list["escapable"] = selected.escapable
		selected_list["interacts"] = list()
		if(selected.escapable)
			selected_list["interacts"]["escapechance"] = selected.escapechance
			selected_list["interacts"]["escapetime"] = selected.escapetime
			selected_list["interacts"]["transferchance"] = selected.transferchance
			selected_list["interacts"]["transferlocation"] = selected.transferlocation
			selected_list["interacts"]["absorbchance"] = selected.absorbchance
			selected_list["interacts"]["digestchance"] = selected.digestchance

		var/list/selected_contents = list()
		for(var/O in selected)
			var/list/info = list(
				"name" = "[O]",
				"absorbed" = FALSE,
				"stat" = 0,
				"ref" = "\ref[O]",
				"outside" = TRUE,
			)
			if(show_pictures)
				info["icon"] = cached_nom_icon(O)
			if(isliving(O))
				var/mob/living/living_prey = O
				info["stat"] = living_prey.stat
				if(SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE))
					info["absorbed"] = TRUE
			selected_contents.Add(list(info))
		selected_list["contents"] = selected_contents

	data["selected"] = selected_list
	var/datum/preferences/my_prefs = user.client.prefs
	data["prefs"] = list(
		"allow_dog_borgs" = my_prefs.allow_dogborgs,
		"allow_eat_noises" = my_prefs.allow_eating_sounds,
		"allow_digestion_noises" = my_prefs.allow_digestion_sounds,
		"allow_digestion_damage" = my_prefs.allow_digestion_damage,
		"allow_digestion_death" = my_prefs.allow_digestion_death,
		"allow_absorbtion" = my_prefs.allow_absorbtion,
		"allow_healbelly_healing" = my_prefs.allow_healbelly_healing,
		"allow_vore_messages" = my_prefs.allow_vore_messages,
		"allow_death_messages" = my_prefs.allow_death_messages,
		"allow_being_prey" = my_prefs.allow_being_prey,
		"allow_being_fed_prey" = my_prefs.allow_being_fed_prey,
		"allow_seeing_belly_descs" = my_prefs.allow_seeing_belly_descriptions,
		"allow_being_sniffed" = my_prefs.allow_being_sniffed,
		"allow_trash_messages" = my_prefs.allow_trash_messages,
		"master_vore_switch" = CHECK_PREFS(user, VOREPREF_MASTER),
	)
	return data

/datum/vore_look/ui_act(action, params)
	if(..())
		return TRUE

	var/list/vorgans = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, vorgans)
	var/list/selectorgan = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, selectorgan, FALSE, TRUE)
	var/obj/vore_belly/selected = LAZYLEN(selectorgan) ? selectorgan[1] : null
	var/datum/preferences/myprefs = host.client?.prefs

	switch(action)
		if("show_pictures")
			show_pictures = !show_pictures
			return TRUE
		if("int_help")
			tgui_alert(usr, "These control how your belly responds to someone using 'resist' while inside you. The percent chance to trigger each is listed below, \
					and you can change them to whatever you see fit. Setting them to 0% will disable the possibility of that interaction. \
					These only function as long as interactions are turned on in general. Keep in mind, the 'belly mode' interactions (digest/absorb) \
					will affect all prey in that belly, if one resists and triggers digestion/absorption. If multiple trigger at the same time, \
					only the first in the order of 'Escape > Transfer > Absorb > Digest' will occur.","Interactions Help")
			return TRUE

		// Host is inside someone else, and is trying to interact with something else inside that person.
		if("pick_from_inside")
			return pick_from_inside(usr, params)

		// Host is trying to interact with something in host's belly.
		if("pick_from_outside")
			return pick_from_outside(usr, params)

		if("newbelly")
			if(LAZYLEN(vorgans) >= BELLIES_MAX)
				return FALSE

			var/new_name = html_encode(input(usr,"New belly's name:","New Belly") as text|null)

			var/failure_msg
			if(length(new_name) > BELLIES_NAME_MAX || length(new_name) < BELLIES_NAME_MIN)
				failure_msg = "Entered belly name length invalid (must be longer than [BELLIES_NAME_MIN], no more than than [BELLIES_NAME_MAX])."
			// else if(whatever) //Next test here.
			else
				for(var/belly in vorgans)
					var/obj/vore_belly/B = belly
					if(lowertext(new_name) == lowertext(B.name))
						failure_msg = "No duplicate belly names, please."
						break

			if(failure_msg) //Something went wrong.
				tgui_alert_async(usr, failure_msg, "Error!")
				return TRUE

			var/obj/vore_belly/NB = new(host)
			NB.name = new_name
			selected = NB
			SEND_SIGNAL(host, COMSIG_VORE_SET_SELECTED_BELLY, selected)
			unsaved_changes = TRUE
			return TRUE

		if("bellypick")
			selected = locate(params["bellypick"])
			SEND_SIGNAL(host, COMSIG_VORE_SET_SELECTED_BELLY, selected)
			return TRUE
		if("move_belly")
			var/dir = text2num(params["dir"])
			if(LAZYLEN(vorgans) <= 1)
				to_chat(usr, span_warning("You can't sort bellies with only one belly to sort..."))
				return TRUE

			SEND_SIGNAL(host, COMSIG_VORE_SWAP_BELLY_INDEX, dir)
			unsaved_changes = TRUE
			return TRUE

		if("set_attribute")
			return set_attr(usr, params)

		if("saveprefs")
			if(!SEND_SIGNAL(host, COMSIG_VORE_SAVE_PREFS))
				tgui_alert_async(usr, span_warning("Belly Preferences not saved!"), "Error")
				log_admin("Could not save vore prefs on USER: [usr].")
			else
				to_chat(usr, span_notice("Belly Preferences were saved!"))
				unsaved_changes = FALSE
			return TRUE
		if("reloadprefs")
			var/alert = tgui_alert(usr, "Are you sure you want to reload character slot preferences? This will remove your current vore organs and eject their contents.","Confirmation",list("Reload","Cancel"))
			if(alert != "Reload")
				return FALSE
			if(!SEND_SIGNAL(host, COMSIG_VORE_LOAD_PREFS))
				tgui_alert_async(usr, "ERROR: Vore-specific preferences failed to apply!","Error")
			else
				to_chat(usr, span_notice("Vore preferences applied from active slot!"))
				unsaved_changes = FALSE
			return TRUE
		if("setflavor")
			var/myflavor
			var/list/mytastes = SSlistbank.get_tastes(host)
			for(var/tast in mytastes)
				myflavor = tast // im know list good
				break
			var/new_flavor = html_encode(input(usr,"What your character tastes like (400ch limit). This text will be printed to the pred after 'X tastes of...' so just put something like 'strawberries and cream':","Character Flavor",myflavor) as text|null)
			if(!new_flavor)
				return FALSE

			new_flavor = readd_quotes(new_flavor)
			if(length(new_flavor) > FLAVOR_MAX)
				tgui_alert_async(usr, "Entered flavor/taste text too long. [FLAVOR_MAX] character limit.","Error!")
				return FALSE
			var/list/newflavor = list("[new_flavor]" = 1)
			SSlistbank.catalogue_tastes(host, newflavor, TRUE)
			myprefs.features["taste"] = "[newflavor]"
			unsaved_changes = TRUE
			return TRUE
		if("setsmell")
			var/new_smell = html_encode(input(usr,"What your character smells like (400ch limit). This text will be printed to the pred after 'X smells of...' so just put something like 'strawberries and cream':","Character Smell",SSvore.get_scent(host)) as text|null)
			if(!new_smell)
				return FALSE

			new_smell = readd_quotes(new_smell)
			if(length(new_smell) > FLAVOR_MAX)
				tgui_alert_async(usr, "Entered perfume/smell text too long. [FLAVOR_MAX] character limit.","Error!")
				return FALSE
			SSvore.register_smell(host, new_smell)
			myprefs.vore_smell = new_smell
			unsaved_changes = TRUE
			return TRUE
		if("toggle_devour")
			TOGGLE_VAR(myprefs.allow_being_prey)
			unsaved_changes = TRUE // We changed something, so we need to save.
			return TRUE
		if("toggle_feeding")
			TOGGLE_VAR(myprefs.allow_being_fed_prey)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_absorbtion")
			TOGGLE_VAR(myprefs.allow_absorbtion)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_eat_noises")
			TOGGLE_VAR(myprefs.allow_eating_sounds)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_digestion_noises")
			TOGGLE_VAR(myprefs.allow_digestion_sounds)
			if(myprefs.allow_digestion_sounds == FALSE && isbelly(host.loc))
				var/obj/vore_belly/B = host.loc
				SEND_SIGNAL(B, COMSIG_VORE_STOP_SOUNDS, host) // Stop the sounds if we're in a belly and we're turning off digestion noises so we don't get stuck with them on forever if we leave the belly. -N (I think) 2020-11-30 11:00 PM EST (UTC-5) (I think) 
			unsaved_changes = TRUE
			return TRUE
		if("toggle_digestion_damage")
			TOGGLE_VAR(myprefs.allow_digestion_damage)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_digestion_death")
			TOGGLE_VAR(myprefs.allow_digestion_death)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_vore_messages")
			TOGGLE_VAR(myprefs.allow_vore_messages)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_death_messages")
			TOGGLE_VAR(myprefs.allow_death_messages)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_seeing_belly_descs")
			TOGGLE_VAR(myprefs.allow_seeing_belly_descriptions)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_seeing_people_spit_up_trash")
			TOGGLE_VAR(myprefs.allow_trash_messages)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_smellable")
			TOGGLE_VAR(myprefs.allow_being_sniffed)
			unsaved_changes = TRUE
			return TRUE
		if("toggle_healbelly")
			TOGGLE_VAR(myprefs.allow_healbelly_healing)
			unsaved_changes = TRUE
			return TRUE
		if("master_vore_switch")
			TOGGLE_VAR(myprefs.master_vore_toggle)
			unsaved_changes = TRUE
			return TRUE

/datum/vore_look/proc/pick_from_inside(mob/user, params)
	var/atom/movable/target = locate(params["pick"])
	var/obj/vore_belly/OB = locate(params["belly"])

	var/list/vorgans = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, vorgans)
	var/list/selectorgan = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, selectorgan, FALSE, TRUE)
	var/obj/vore_belly/selected = LAZYLEN(selectorgan) ? selectorgan[1] : null

	if(!(target in OB))
		return TRUE // Aren't here anymore, need to update menu

	var/intent = "Examine"
	if(isliving(target))
		intent = tgui_alert(usr, "What do you want to do to them?","Query",list("Examine","Help Out","Devour"))

	else if(istype(target, /obj/item))
		intent = tgui_alert(usr, "What do you want to do to that?","Query",list("Examine","Use Hand"))

	switch(intent)
		if("Examine") //Examine a mob inside another mob
			var/list/results = target.examine(host)
			if(!LAZYLEN(results))
				results = list("You were unable to examine that. Tell a developer!")
			to_chat(user, jointext(results, "<br>"))
			return TRUE

		if("Use Hand")
			if(host.stat)
				to_chat(user, span_warning("You can't do that in your state!"))
				return TRUE

			host.ClickOn(target)
			return TRUE

	if(!isliving(target))
		return

	var/mob/living/living_prey = target
	switch(intent)
		if("Help Out") //Help the inside-mob out
			if(host.stat || SEND_SIGNAL(user, COMSIG_VORE_ABSORBED_STATE) || SEND_SIGNAL(living_prey, COMSIG_VORE_ABSORBED_STATE))
				to_chat(user, span_warning("You can't do that in your state!"))
				return TRUE

			to_chat(user,"<font color='green'>You begin to push [living_prey] to freedom!</font>")
			to_chat(living_prey,"[host] begins to push you to freedom!")
			to_chat(living_prey.loc,span_warning("Someone is trying to escape from inside you!"))
			sleep(50)
			if(prob(33))
				OB.release_specific_contents(living_prey)
				to_chat(user,"<font color='green'>You manage to help [living_prey] to safety!</font>")
				to_chat(living_prey,"<font color='green'>[host] pushes you free!</font>")
				to_chat(OB.owner,span_alert("[living_prey] forces free of the confines of your body!"))
			else
				to_chat(user,span_alert("[living_prey] slips back down inside despite your efforts."))
				to_chat(living_prey,span_alert(" Even with [host]'s help, you slip back inside again."))
				to_chat(OB.owner,"<font color='green'>Your body efficiently shoves [living_prey] back where they belong.</font>")
			return TRUE

		if("Devour") //Eat the inside mob
			if(host.stat || SEND_SIGNAL(host, COMSIG_VORE_ABSORBED_STATE))
				to_chat(user,span_warning("You can't do that in your state!"))
				return TRUE

			if(!selected)
				to_chat(user,span_warning("Pick a belly on yourself first!"))
				return TRUE

			var/obj/vore_belly/TB = selected
			to_chat(user,span_warning("You begin to [lowertext(TB.vore_verb)] [living_prey] into your [lowertext(TB.name)]!"))
			to_chat(living_prey,span_warning("[host] begins to [lowertext(TB.vore_verb)] you into their [lowertext(TB.name)]!"))
			to_chat(OB.owner,span_warning("Someone inside you is eating someone else!"))

			sleep(VORE_SWALLOW_NONHUMAN_TIME) //Can't do after, in a stomach, weird things abound.
			if((host in OB) && (living_prey in OB)) //Make sure they're still here.
				to_chat(user,span_warning("You manage to [lowertext(TB.vore_verb)] [living_prey] into your [lowertext(TB.name)]!"))
				to_chat(living_prey,span_warning("[host] manages to [lowertext(TB.vore_verb)] you into their [lowertext(TB.name)]!"))
				to_chat(OB.owner,span_warning("Someone inside you has eaten someone else!"))
				TB.nom_mob(living_prey)

/datum/vore_look/proc/pick_from_outside(mob/user, params)
	var/intent

	var/list/vorgans = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, vorgans)
	var/list/selectorgan = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, selectorgan, FALSE, TRUE)
	var/obj/vore_belly/selected = LAZYLEN(selectorgan) ? selectorgan[1] : null

	//Handle the [All] choice. Ugh inelegant. Someone make this pretty.
	if(params["pickall"])
		intent = tgui_alert(usr, "Eject all, Move all?","Query",list("Eject all","Cancel","Move all"))
		switch(intent)
			if("Cancel")
				return TRUE

			if("Eject all")
				if(host.stat)
					to_chat(user,span_warning("You can't do that in your state!"))
					return TRUE

				SEND_SIGNAL(selected, COMSIG_VORE_EXPEL_ALL)
				return TRUE

			if("Move all")
				if(host.stat)
					to_chat(user,span_warning("You can't do that in your state!"))
					return TRUE

				var/obj/vore_belly/choice = input(usr, "Move all where?","Select Belly") as anything in vorgans
				if(!choice)
					return FALSE

				for(var/atom/movable/target in selected)
					to_chat(target,span_warning("You're squished from [host]'s [lowertext(selected)] to their [lowertext(choice.name)]!"))
					selected.transfer_contents(target, choice, 1)
				return TRUE
		return

	var/atom/movable/target = locate(params["pick"])
	if(!(target in selected))
		return TRUE // Not in our X anymore, update UI
	var/list/available_options = list("Examine", "Eject", "Move")
	intent = tgui_alert(user, "What would you like to do with [target]?", "Vore Pick", available_options)
	switch(intent)
		if("Examine")
			var/list/results = target.examine(host)
			if(!LAZYLEN(results))
				results = list("You were unable to examine that. Tell a developer!")
			to_chat(user, jointext(results, "<br>"))
			return TRUE

		if("Eject")
			if(host.stat)
				to_chat(user,span_warning("You can't do that in your state!"))
				return TRUE

			SEND_SIGNAL(selected, COMSIG_BELLY_EXPEL_SPECIFIC, target)
			return TRUE

		if("Move")
			if(host.stat)
				to_chat(user,span_warning("You can't do that in your state!"))
				return TRUE

			var/obj/vore_belly/choice = input(usr, "Move [target] where?","Select Belly") as anything in vorgans
			if(!choice || !(target in selected))
				return TRUE

			to_chat(target,span_warning("You're squished from [host]'s [lowertext(selected.name)] to their [lowertext(choice.name)]!"))
			selected.transfer_contents(target, choice)
			return TRUE

/datum/vore_look/proc/set_attr(mob/user, params)
	var/list/vorgans = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, vorgans)
	var/list/selectorgan = list()
	SEND_SIGNAL(host, COMSIG_VORE_GET_BELLIES, selectorgan, FALSE, TRUE)
	var/obj/vore_belly/selected = LAZYLEN(selectorgan) ? selectorgan[1] : null

	if(!selected)
		tgui_alert_async(usr, "No belly selected to modify.")
		return FALSE

	var/attr = params["attribute"]
	switch(attr)
		if("b_name")
			var/new_name = html_encode(input(usr,"Belly's new name:","New Name") as text|null)

			var/failure_msg
			if(length(new_name) > BELLIES_NAME_MAX || length(new_name) < BELLIES_NAME_MIN)
				failure_msg = "Entered belly name length invalid (must be longer than [BELLIES_NAME_MIN], no more than than [BELLIES_NAME_MAX])."
			// else if(whatever) //Next test here.
			else
				for(var/belly in vorgans)
					var/obj/vore_belly/B = belly
					if(lowertext(new_name) == lowertext(B.name))
						failure_msg = "No duplicate belly names, please."
						break

			if(failure_msg) //Something went wrong.
				tgui_alert_async(user,failure_msg,"Error!")
				return FALSE

			selected.name = new_name
			. = TRUE
		if("b_wetness")
			selected.is_wet = !selected.is_wet
			. = TRUE
		if("b_wetloop")
			selected.wet_loop = !selected.wet_loop
			. = TRUE
		if("b_hork_trash")
			TOGGLE_VAR(selected.spits_trash)
			. = TRUE
		if("b_mode")
			var/list/menu_list = SSvore.digest_modes.Copy()
			var/new_mode = input(usr, "Choose Mode (currently [selected.digest_mode])", "Mode Choice") as anything in menu_list
			if(!new_mode)
				return FALSE

			selected.digest_mode = new_mode
			. = TRUE
		if("b_desc")
			var/new_desc = html_encode(input(usr,"Belly Description ([BELLIES_DESC_MAX] char limit):","New Description",selected.desc) as message|null)

			if(new_desc)
				new_desc = readd_quotes(new_desc)
				if(length(new_desc) > BELLIES_DESC_MAX)
					tgui_alert_async(usr, "Entered belly desc too long. [BELLIES_DESC_MAX] character limit.","Error")
					return FALSE
				selected.desc = new_desc
				. = TRUE
		if("b_msgs")
			tgui_alert(user,"Setting abusive or deceptive messages will result in a ban. Consider this your warning. Max 150 characters per message (500 for idle messages), max 10 messages per topic.","Really, don't.") // Should remain tgui_alert() (blocking)
			var/help = " Press enter twice to separate messages. '%pred' will be replaced with your name. '%prey' will be replaced with the prey's name. '%belly' will be replaced with your belly's name. '%count' will be replaced with the number of anything in your belly (will not work for absorbed examine). '%countprey' will be replaced with the number of living prey in your belly (or absorbed prey for absorbed examine)."
			switch(params["msgtype"])
				if("dmp")
					var/new_message = input(user,"These are sent to prey when they expire. Write them in 2nd person ('you feel X'). Avoid using %prey in this type."+help,"Digest Message (to prey)",selected.get_messages("dmp")) as message
					if(new_message)
						selected.set_messages(new_message,"dmp")

				if("dmo")
					var/new_message = input(user,"These are sent to you when prey expires in you. Write them in 2nd person ('you feel X'). Avoid using %pred in this type."+help,"Digest Message (to you)",selected.get_messages("dmo")) as message
					if(new_message)
						selected.set_messages(new_message,"dmo")

				if("smo")
					var/new_message = input(user,"These are sent to those nearby when prey struggles. Write them in 3rd person ('X's Y bulges')."+help,"Struggle Message (outside)",selected.get_messages("smo")) as message
					if(new_message)
						selected.set_messages(new_message,"smo")

				if("smi")
					var/new_message = input(user,"These are sent to prey when they struggle. Write them in 2nd person ('you feel X'). Avoid using %prey in this type."+help,"Struggle Message (inside)",selected.get_messages("smi")) as message
					if(new_message)
						selected.set_messages(new_message,"smi")

				if("em")
					var/new_message = input(user,"These are sent to people who examine you when this belly has contents. Write them in 3rd person ('Their %belly is bulging')."+help,"Examine Message (when full)",selected.get_messages("em")) as message
					if(new_message)
						selected.set_messages(new_message,"em")

				if("tr")
					var/new_message = input(user,"These are sent to everyone around you when food is digested and leaves some trash Write them in 3rd person (%pred's %belly ejects a piece of trash)."+help,"Trash Ejection Message",selected.get_messages("tr")) as message
					if(new_message)
						selected.set_messages(new_message,"tr")

				if("reset")
					var/confirm = tgui_alert(user,"This will delete any custom messages. Are you sure?","Confirmation",list("Cancel","DELETE"))
					if(confirm == "DELETE")
						selected.digest_messages_prey = initial(selected.digest_messages_prey)
						selected.digest_messages_owner = initial(selected.digest_messages_owner)
						selected.struggle_messages_outside = initial(selected.struggle_messages_outside)
						selected.struggle_messages_inside = initial(selected.struggle_messages_inside)
						selected.examine_messages = initial(selected.examine_messages)
						selected.emote_lists = initial(selected.emote_lists)
			. = TRUE
		if("b_verb")
			var/new_verb = html_encode(input(usr,"New verb when eating (infinitive tense, e.g. nom or swallow):","New Verb") as text|null)

			if(length(new_verb) > BELLIES_NAME_MAX || length(new_verb) < BELLIES_NAME_MIN)
				tgui_alert_async(usr, "Entered verb length invalid (must be longer than [BELLIES_NAME_MIN], no longer than [BELLIES_NAME_MAX]).","Error")
				return FALSE

			selected.vore_verb = new_verb
			. = TRUE
		if("b_release")
			var/choice = input(user,"Currently set to [selected.release_sound]","Select Sound") as anything in GLOB.pred_release_sounds

			if(!choice)
				return FALSE

			selected.release_sound = choice
			. = TRUE
		if("b_releasesoundtest")
			var/sound/releasetest = GLOB.pred_release_sounds[selected.release_sound]

			if(releasetest)
				SEND_SOUND(user, releasetest)
			. = FALSE //Testing sound, no changes.
		if("b_sound")
			var/choice = input(user,"Currently set to [selected.vore_sound]","Select Sound") as anything in GLOB.prey_vore_sounds

			if(!choice)
				return FALSE

			selected.vore_sound = choice
			. = TRUE
		if("b_soundtest")
			var/sound/voretest = GLOB.prey_vore_sounds[selected.vore_sound]
			if(voretest)
				SEND_SOUND(user, voretest)
			. = FALSE //Testing sound, no changes.
		if("b_tastes")
			selected.can_taste = !selected.can_taste
			. = TRUE
		if("b_bulge_size")
			var/new_bulge = input(user, "Choose the required size prey must be to show up on examine, ranging from 25% to 200% Set this to 0 for no text on examine.", "Set Belly Examine Size.") as num|null
			if(new_bulge == null)
				return FALSE
			if(new_bulge == 0) //Disable.
				selected.bulge_size = 0
				to_chat(user,span_notice("Your stomach will not be seen on examine."))
			else if (!ISINRANGE(new_bulge,25,200))
				selected.bulge_size = 0.25 //Set it to the default.
				to_chat(user,span_notice("Invalid size."))
			else if(new_bulge)
				selected.bulge_size = (new_bulge*0.01)
			. = TRUE
		if("b_escapable")
			if(selected.escapable == 0) //Possibly escapable and special interactions.
				selected.escapable = 1
				to_chat(usr,span_warning("Prey now have special interactions with your [lowertext(selected.name)] depending on your settings."))
			else if(selected.escapable == 1) //Never escapable.
				selected.escapable = 0
				to_chat(usr,span_warning("Prey will not be able to have special interactions with your [lowertext(selected.name)]."))
			else
				tgui_alert_async(usr, "Something went wrong. Your stomach will now not have special interactions. Press the button enable them again and tell a dev.","Error") //If they somehow have a varable that's not 0 or 1
				selected.escapable = 0
			. = TRUE
		if("b_escapechance")
			var/escape_chance_input = input(user, "Set prey escape chance on resist (as %)", "Prey Escape Chance") as num|null
			if(!isnull(escape_chance_input)) //These have to be 'null' because both cancel and 0 are valid, separate options
				selected.escapechance = sanitize_integer(escape_chance_input, 0, 100, initial(selected.escapechance))
			. = TRUE
		if("b_escapetime")
			var/escape_time_input = input(user, "Set number of seconds for prey to escape on resist (1-60)", "Prey Escape Time") as num|null
			if(!isnull(escape_time_input))
				selected.escapetime = sanitize_integer(escape_time_input*10, 10, 600, initial(selected.escapetime))
			. = TRUE
		if("b_transferchance")
			var/transfer_chance_input = input(user, "Set belly transfer chance on resist (as %). You must also set the location for this to have any effect.", "Prey Escape Time") as num|null
			if(!isnull(transfer_chance_input))
				selected.transferchance = sanitize_integer(transfer_chance_input, 0, 100, initial(selected.transferchance))
			. = TRUE
		if("b_transferlocation")
			var/obj/vore_belly/choice = input(usr, "Where do you want your [lowertext(selected.name)] to lead if prey resists?","Select Belly") as anything in (vorgans + "None - Remove" - selected)

			if(!choice) //They cancelled, no changes
				return FALSE
			else if(choice == "None - Remove")
				selected.transferlocation = null
			else
				selected.transferlocation = choice.name
			. = TRUE
		if("b_absorbchance")
			var/absorb_chance_input = input(user, "Set belly absorb mode chance on resist (as %)", "Prey Absorb Chance") as num|null
			if(!isnull(absorb_chance_input))
				selected.absorbchance = sanitize_integer(absorb_chance_input, 0, 100, initial(selected.absorbchance))
			. = TRUE
		if("b_set_brute_damage")
			var/digestion_brute_input = input(
				user, 
				"Set brute damage to cause prey per belly tick (around 5 seconds) while set to digest. Can be anywhere from 0 to 50.", 
				"Prey Digestion Brute"
				) as num|null
			if(!isnull(digestion_brute_input))
				selected.digest_brute = sanitize_integer(digestion_brute_input, 0, 50, initial(selected.digest_brute))
			. = TRUE
		if("b_set_burn_damage")
			var/digestion_burn_input = input(
				user, 
				"Set burn damage to cause prey per belly tick (around 5 seconds) while set to digest. Can be anywhere from 0 to 50.", 
				"Prey Digestion Burn"
				) as num|null
			if(!isnull(digestion_burn_input))
				selected.digest_burn = sanitize_integer(digestion_burn_input, 0, 50, initial(selected.digest_burn))
			. = TRUE
		if("b_digestchance")
			var/digest_chance_input = input(user, "Set belly digest mode chance on resist (as %)", "Prey Digest Chance") as num|null
			if(!isnull(digest_chance_input))
				selected.digestchance = sanitize_integer(digest_chance_input, 0, 100, initial(selected.digestchance))
			. = TRUE
		if("b_del")
			var/alert = tgui_alert(usr, "Are you sure you want to delete your [lowertext(selected.name)]?","Confirmation",list("Cancel","Delete"))
			if(!(alert == "Delete"))
				return FALSE

			var/failure_msg = ""

			var/dest_for //Check to see if it's the destination of another vore organ.
			for(var/belly in vorgans)
				var/obj/vore_belly/B = belly
				if(B.transferlocation == selected)
					dest_for = B.name
					failure_msg += "This is the destiantion for at least '[dest_for]' belly transfers. Remove it as the destination from any bellies before deleting it. "
					break

			if(LAZYLEN(selected.contents))
				failure_msg += "You cannot delete bellies with contents! " //These end with spaces, to be nice looking. Make sure you do the same.
			if(selected.immutable)
				failure_msg += "This belly is marked as undeletable. "
			if(LAZYLEN(vorgans) == 1)
				failure_msg += "You must have at least one belly. "

			if(failure_msg)
				tgui_alert_async(user,failure_msg,"Error!")
				return FALSE

			qdel(selected)
			SEND_SIGNAL(host, COMSIG_VORE_SET_SELECTED_BELLY, vorgans[1])
			. = TRUE

	if(.)
		unsaved_changes = TRUE

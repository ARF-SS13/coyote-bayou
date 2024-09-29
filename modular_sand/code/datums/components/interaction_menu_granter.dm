#define SPLURT_MAX_AUTOPLAPPERS 3
#define SPLURT_ANTISPAM if(!click_refractory()) return FALSE
#define AUTOCUM_PARTNER_CUMS (1 << 0) // cums (u do too)
#define AUTOCUM_USER_FULL_LUST (1 << 1)
#define AUTOCUM_PARTNER_FULL_LUST (1 << 2)

#define MERP_CAT_ALL "All Interactions"
#define MERP_CAT_FAVES "Favorites"

/// Attempts to open the tgui menu
/mob/verb/interact_with()
	set name = "Mechanically Rolepay With"
	set desc = "Perform an interaction with someone."
	set category = "Roleplaying"
	set src in range(10)

	var/datum/component/interaction_menu_granter/menu = usr.GetComponent(/datum/component/interaction_menu_granter)
	if(!menu)
		usr.AddComponent(/datum/component/interaction_menu_granter)
		menu = usr.GetComponent(/datum/component/interaction_menu_granter)
	if(!menu)
		to_chat(usr, span_warning("Shits broken!."))
		return

	if(!src)
		to_chat(usr, span_warning("Your interaction target is gone!"))
		return
	SEND_SIGNAL(usr, COMSIG_CLICK_CTRL_SHIFT, src)


#define INTERACTION_NORMAL 0
#define INTERACTION_LEWD 1
#define INTERACTION_EXTREME 2
#define INTERACTION_CONSENT 3

/// some day this humble component will hold all of the world's horniness
/// taking it from the shoulders of /mob/living ones and for all
/// Stay strong, /datum/component/interaction_menu_granter

/// The menu itself, only var is target which is the mob you are interacting with
/datum/component/interaction_menu_granter
	var/datum/weakref/weaktarget
	// var/mob/living/target
	/// weakrefs to mobs we are doing cool things with
	var/list/splurting_with = list()
	/// our active automatic plappers
	var/list/autoplappers = list()
	var/autoplapper_autostart = TRUE
	var/mean_time_to_cum = 5 MINUTES // how long it takes to cum when doing an autoplap
	var/SeeLewd = FALSE // show the lewd stuff?
	var/SeeExtreme = FALSE // show the REALLY lewd stuff?
	var/savetimer = 0
	var/autocum_flags = NONE
	COOLDOWN_DECLARE(click_refractory)
	var/durty = TRUE
	var/current_page = 1
	var/current_category = MERP_CAT_ALL
	var/search_term = ""
	var/list/cached_interactions = list() // optimizing my code is for nerds

/datum/component/interaction_menu_granter/Initialize(...)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/parent_mob = parent
	if(!parent_mob.client)
		return COMPONENT_INCOMPATIBLE
	. = ..()
	update_display_filter()

/datum/component/interaction_menu_granter/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT,PROC_REF(open_menu))
	RegisterSignal(parent, COMSIG_SPLURT_REMOVE_AUTOPLAPPER,PROC_REF(kill_autoplapper))
	RegisterSignal(parent, COMSIG_SPLURT_ADD_AUTOPLAPPER,PROC_REF(confirm_autoplap))
	RegisterSignal(parent, COMSIG_SPLURT_SOMEONE_CUMMED,PROC_REF(stop_all_autoplappers))
	RegisterSignal(parent, COMSIG_SPLURT_I_CAME,PROC_REF(stop_all_autoplappers))

/datum/component/interaction_menu_granter/Destroy(force, ...)
	weaktarget = null
	QDEL_LIST_ASSOC_VAL(autoplappers)
	. = ..()

/datum/component/interaction_menu_granter/UnregisterFromParent()
	weaktarget = null
	QDEL_LIST_ASSOC_VAL(autoplappers)
	UnregisterSignal(parent, list(COMSIG_CLICK_CTRL_SHIFT, COMSIG_SPLURT_REQUEST, COMSIG_SPLURT_ADD_AUTOPLAPPER))
	. = ..()

/// The one interacting is clicker, the interacted is clicked.
/datum/component/interaction_menu_granter/proc/open_menu(mob/clicker, mob/clicked)
	// COMSIG_CLICK_CTRL_SHIFT accepts `atom`s, prevent it
	if(!istype(clicked))
		return FALSE
	// Don't cancel admin quick spawn
	if(isobserver(clicked) && check_rights_for(clicker.client, R_SPAWN))
		return FALSE
	weaktarget = WEAKREF(clicked)
	ui_interact(clicker)
	return COMSIG_MOB_CANCEL_CLICKON

/datum/component/interaction_menu_granter/ui_state(mob/user)
	// Funny admin, don't you dare be the extra funny now.
	if(user.client.holder && !user.client.holder.deadmined)
		return GLOB.always_state
	if(user == parent)
		return GLOB.conscious_state
	return GLOB.never_state

/datum/component/interaction_menu_granter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MobInteraction", "Interactions")
		ui.open()

/proc/pref_to_num(pref)
	switch(pref)
		if("Yes")
			return 1
		if("Ask")
			return 2
		else
			return 0

/datum/component/interaction_menu_granter/ui_static_data(mob/user)
	. = ..()
	var/mob/living/self = parent
	var/mob/living/target = GET_WEAKREF(weaktarget)
	if(!target)
		return
	var/list/data = list()
	//Getting interactions
	data["MinAutoplapInterval"] = SSinteractions.min_autoplap_interval || list()
	data["MaxAutoplapInterval"] = SSinteractions.max_autoplap_interval || list()
	data["AllCategories"] = SSinteractions.all_categories || list()
	data["MyGenitals"] = self.format_genitals_for_tgui() || list()
	data["MyOrientations"] = format_orientation(self) || list()
	if(target != self)
		data["TheirOrientations"] = format_orientation(target) || list()
		data["TheirGenitals"] = target.format_genitals_for_tgui() || list()
	else
		data["TheirOrientations"] = data["MyOrientations"]
		data["TheirGenitals"] = data["MyGenitals"]
	return data

/datum/component/interaction_menu_granter/ui_data(mob/user)
	. = ..()
	//Getting player
	var/mob/living/self = parent
	var/mob/living/target = GET_WEAKREF(weaktarget)
	if(!target)
		return
	//Getting info
	update_display_filter(TRUE)
	.["CurrPage"] = current_page || 1
	.["MaxPage"] = CEILING(LAZYLEN(cached_interactions) / SSinteractions.interactions_per_page, 1) || 1
	.["CanPgDN"] = current_page > 0
	.["CanPgUP"] = current_page < CEILING(LAZYLEN(cached_interactions) / SSinteractions.interactions_per_page, 1) - 1
	.["CurrCategory"] = current_category || MERP_CAT_ALL
	var/top_index = max((current_page - 1) * SSinteractions.interactions_per_page, 1)
	var/bottom_index = min((current_page) * SSinteractions.interactions_per_page, LAZYLEN(cached_interactions))
	var/list/stuff_in_this_page = cached_interactions.Copy(top_index, bottom_index)
	.["AllInteractions"] = stuff_in_this_page || list()
	.["SearchTerm"] = search_term || ""
	.["SeeLewd"] = SeeLewd || FALSE
	.["SeeExtreme"] = SeeExtreme || FALSE
	.["ItsJustMe"] = target == self
	.["WeConsent"] = SSinteractions.check_consent(self, target) || FALSE
	.["MyName"] = self.name || "Nobody"
	.["TheirName"] = target.name || "Nobody"
	var/list/faves = self.client?.prefs.faved_interactions || list()
	.["Faves"] = faves || list()
	.["AutoPlapObjs"] = package_autoplappers() || list()
	.["Recording"] = get_recording_autoplappers() || list()
	.["AutoPlapAutoStart"] = autoplapper_autostart || FALSE
	// .["selfAttributes"] = self.list_interaction_attributes(self) || list()
	.["CanCum"] = self.ready_to_cum || FALSE // I AM NOT READY!!!!!!!!!!!!!
	.["MTTC"] = mean_time_to_cum || 2 MINUTES // I will last 2 minutes, no more, no lest
	.["MyLust"] = self.get_lust() || 0
	.["MyMaxLust"] = self.get_lust_max() || 0
	.["SeeLewdMessages"] = !!CHECK_BITFIELD(self.client?.prefs.toggles, HEAR_LEWD_VERB_WORDS) || FALSE
	.["HearLewdSounds"] = !!CHECK_BITFIELD(self.client?.prefs.toggles, HEAR_LEWD_VERB_SOUNDS) || FALSE
	.["TheirLust"] = target.get_lust() || 0
	.["TheirMaxLust"] = target.get_lust_max() || 0

/proc/num_to_pref(num)
	switch(num)
		if(1)
			return "Yes"
		if(2)
			return "Ask"
		else
			return "No"

/datum/component/interaction_menu_granter/ui_act(action, params)
	if(..())
		return
	var/mob/living/parent_mob = parent
	var/datum/preferences/P = extract_prefs(parent_mob)

	switch(action)
		if("interact")
			SPLURT_ANTISPAM
			perform_action(GET_WEAKREF(weaktarget), params["interaction"], params["extra"])

		if("Favorite")
			if(!P)
				return FALSE
			listify(P.faved_interactions)
			if(params["interaction"] in P.faved_interactions)
				P.faved_interactions -= params["interaction"]
			else
				P.faved_interactions |= params["interaction"]
			queue_save()
			interface_sound(1)

		if("DeleteAutoPlapper")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP)
				return FALSE
			remove_autoplap(AP.apid)
			interface_sound(1)

		if("StartRecording")
			if(is_recording())
				perform_action(GET_WEAKREF(weaktarget), params["interaction"], params["extra"]) // try to finish it off
				return FALSE
			new_autoplap(params["interaction"], GET_WEAKREF(weaktarget), null)
			interface_sound(1)

		if("StopRecording")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP.plap_listening)
				return TRUE
			to_chat(parent_mob, span_green("Aborted recording [AP.plap_key]!"))
			autoplappers -= AP.apid
			qdel(AP)
			interface_sound(1)

		if("SetAutoPlapperInterval")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP)
				return FALSE
			AP.plap_interval = text2num(params["Interval"])

		if("ToggleAutoPlapper")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP)
				return FALSE
			AP.toggle_plapping()
			interface_sound(1)

		if("ConsentAct")
			SPLURT_ANTISPAM
			to_chat(parent_mob, span_notice("Requesting consent from [GET_WEAKREF(weaktarget)]..."))
			SSinteractions.add_or_remove_consent(parent_mob, GET_WEAKREF(weaktarget))
			interface_sound(2)

		// if("MTTC")
		// 	update_mean_time_to_cum(params["value"])
		// 	return TRUE
		if("Cum")
			SPLURT_ANTISPAM
			parent_mob.cum()
			interface_sound(3)

		if("ToggleAutoCum")
			TOGGLE_VAR(parent_mob.ready_to_cum)
			if(parent_mob.ready_to_cum)
				to_chat(parent_mob, span_green("You will automatically cum when your arousal reaches 100%!"))
			else
				to_chat(parent_mob, span_green("You will no longer automatically cum when your arousal reaches 100%!"))
			interface_sound(1)

		if("ToggleAutoStart")
			interface_sound(1)
			TOGGLE_VAR(autoplapper_autostart)

		if("StopAllAutoPlappers")
			SPLURT_ANTISPAM
			stop_all_autoplappers()
			to_chat(parent_mob, span_green("Stopped all autoplappers!"))
			interface_sound(1)

		if("StartAllAutoPlappers")
			SPLURT_ANTISPAM
			for(var/ap in autoplappers)
				var/datum/autoplapper/AP = autoplappers[ap]
				if(!AP)
					continue
				AP.start_plapping()
			to_chat(parent_mob, span_green("Started all autoplappers!"))
			interface_sound(1)

		if("ToggleSeeLewd")
			TOGGLE_VAR(SeeLewd)
			if(SeeLewd)
				to_chat(parent_mob, span_green("Lewd stuff enabled!"))
			else
				to_chat(parent_mob, span_green("Lewd stuff disabled!"))
			interface_sound(1)
			durty = TRUE

		if("ToggleSeeExtreme")
			TOGGLE_VAR(SeeExtreme)
			if(SeeExtreme)
				to_chat(parent_mob, span_green("Extreme stuff enabled!"))
			else
				to_chat(parent_mob, span_green("Extreme stuff disabled!"))
			interface_sound(1)
			durty = TRUE

		if("ToggleSeeLewdMessages")
			if(!P)
				return FALSE
			TOGGLE_BITFIELD(P.toggles, HEAR_LEWD_VERB_WORDS)
			if(CHECK_BITFIELD(P.toggles, HEAR_LEWD_VERB_WORDS))
				to_chat(parent_mob, span_green("You will now see lewd messages!"))
			else
				to_chat(parent_mob, span_green("You will no longer see lewd messages!"))
			queue_save()
			interface_sound(1)

		if("ToggleHearLewdSounds")
			if(!P)
				return FALSE
			TOGGLE_BITFIELD(P.toggles, HEAR_LEWD_VERB_SOUNDS)
			if(CHECK_BITFIELD(P.toggles, HEAR_LEWD_VERB_SOUNDS))
				to_chat(parent_mob, span_green("You will now hear lewd verb sounds!"))
			else
				to_chat(parent_mob, span_green("You will no longer hear lewd verb sounds!"))
			queue_save()
			interface_sound(1)

		if("AutocumFlagify")
			change_autocum_flags()
			interface_sound(1)
		
		if("PgUP")
			var/nextpage = min(current_page + 1, CEILING(LAZYLEN(SSinteractions.interactions_tgui) / SSinteractions.interactions_per_page, 1))
			if(nextpage != current_page)
				current_page = nextpage
				durty = TRUE
				interface_sound(1)

		if("PgDOWN")
			var/nextpage = max(current_page - 1, 0)
			if(nextpage != current_page)
				current_page = nextpage
				durty = TRUE
				interface_sound(1)
		
		if("UpdateSearch") // so long, performance!!!!
			if(params["SearchTerm"] != search_term)
				search_term = params["SearchTerm"]
				current_category = MERP_CAT_ALL
				current_page = 1
				durty = TRUE
				interface_sound(1)
		
		if("UpdateCategory")
			if(params["category"] != current_category)
				search_term = ""
				current_category = params["category"]
				current_page = 1
				durty = TRUE
				interface_sound(1)

	update_display_filter(params) // turns out js doesnt like having to sort a million things every frame
	return TRUE

/datum/component/interaction_menu_granter/proc/perform_action(mob/living/target, interaction_key, extras)
	if(!target || !interaction_key || !isliving(parent))
		return FALSE
	var/mob/living/parent_mob = parent
	var/datum/interaction/o = SSinteractions.interactions[interaction_key]
	if(!o)
		return FALSE
	o.run_action(parent_mob, target, extra = extras)

/datum/component/interaction_menu_granter/proc/interface_sound(which)
	return // sike
	// var/mob/living/self = parent
	// self.playsound_local(get_turf(self), "sound/effects/pop.ogg", 40)

//////// AUTOPLAPPER STUFF
/datum/component/interaction_menu_granter/proc/new_autoplap(key, mob/living/partner, interval)
	if(!isliving(partner) || !key)
		to_chat(parent, span_alert("That didnt work!!!"))
		return
	if(LAZYLEN(autoplappers) >= SPLURT_MAX_AUTOPLAPPERS)
		to_chat(parent, span_alert("You have too many autointeractions to add another one!"))
		return
	var/datum/interaction/I = LAZYACCESS(SSinteractions.interactions, key)
	if(!I)
		to_chat(parent, span_alert("That didnt work!!!"))
		return
	if(!I.can_autoplap)
		to_chat(parent, span_alert("That one really shouldnt be automated!"))
		return
	if(!I.can_do_interaction(parent, partner))
		return
	var/mob/living/me = parent
	var/mob/living/them = partner
	if(!interval) // it'll 
		I.run_action(me, them) // plap to get things started
	new /datum/autoplapper(me, them, I, interval) // it'll mail us when its good and ready


/datum/component/interaction_menu_granter/proc/confirm_autoplap(datum/source, datum/autoplapper/AP)
	if(!istype(AP))
		return
	autoplappers[AP.apid] = AP

/datum/component/interaction_menu_granter/proc/remove_autoplap(apid)
	var/datum/autoplapper/AP = autoplappers[apid]
	if(!AP)
		return
	AP.stop_plapping()
	to_chat(parent, span_green("Removed auto-action for [AP.plap_name]!"))
	autoplappers -= AP.apid
	qdel(AP)

/datum/component/interaction_menu_granter/proc/package_autoplappers()
	var/list/ret = list()
	for(var/plapining in autoplappers)
		var/datum/autoplapper/AP = autoplappers[plapining]
		if(!AP)
			continue
		ret += list(AP.format_for_tgui())
	return ret

/datum/component/interaction_menu_granter/proc/is_recording()
	return LAZYLEN(get_recording_autoplappers())

/datum/component/interaction_menu_granter/proc/stop_all_autoplappers()
	for(var/ap in autoplappers)
		var/datum/autoplapper/AP = autoplappers[ap]
		if(!AP)
			continue
		AP.stop_plapping()

/datum/component/interaction_menu_granter/proc/get_recording_autoplappers()
	var/list/ret = list()
	for(var/plapining in autoplappers)
		var/datum/autoplapper/AP = autoplappers[plapining]
		if(!AP)
			continue
		if(AP.plap_listening)
			ret += list(AP.format_for_tgui())
	return ret

/datum/component/interaction_menu_granter/proc/kill_autoplapper(datum/source, datum/autoplapper/AP)
	if(!AP)
		return
	autoplappers -= AP.apid

/datum/component/interaction_menu_granter/proc/queue_save()
	if(savetimer)
		deltimer(savetimer)
	savetimer = addtimer(CALLBACK(src,PROC_REF(save_prefs)), 4 SECONDS, TIMER_STOPPABLE) // save in 4 seconds

/datum/component/interaction_menu_granter/proc/save_prefs()
	var/mob/living/self = parent
	var/datum/preferences/P = self.client?.prefs
	if(!P)
		return
	P.save_character()
	P.save_preferences()
	to_chat(parent, span_green("SAVE OK"))
	savetimer = null

/datum/component/interaction_menu_granter/proc/click_refractory() // sex is combat, didnt ya know?
	if(!COOLDOWN_FINISHED(src, click_refractory))
		return FALSE // mainly cus spamming the buttons will lock up your client with sex messages
	COOLDOWN_START(src, click_refractory, 0.8 SECONDS)
	return TRUE
	// if(is_interaction_command(action, params))
	// 	if(!parent_mob.CheckActionCooldown(0.8 SECONDS))
	// 		return
	// 	parent_mob.DelayNextAction(0.8 SECONDS)

/datum/component/interaction_menu_granter/proc/sympathetic_detonation(mob/living/me, mob/living/coomer)
	// SIGNAL_HANDLER
	// if(me == coomer)
	// 	return
	// if(!isliving(me) || !isliving(coomer))
	// 	return
	// if(CHECK_BITFIELD(autocum_flags, AUTOCUM_PARTNER_CUMS))
	// 	return FALSE // keep going they're close
	// if(CHECK_BITFIELD(autocum_flags, AUTOCUM_USER_FULL_LUST))
	// 	if(me.get_lust() < me.get_lust_max())
	// 		return FALSE // keep going im close
	// if(CHECK_BITFIELD(autocum_flags, AUTOCUM_PARTNER_FULL_LUST))
	// 	if(coomer.get_lust() < coomer.get_lust_max())
	// 		return FALSE // keep going they're close
	// return me.try2cum(coomer)

/datum/component/interaction_menu_granter/proc/output_autocum_string() // a long ropey string
	var/mob/living/self = parent
	if(autocum_flags == NONE)
		to_chat(self, span_green("You'll cum when you feel like it!"))
		return
	var/list/strings = list()
	if(CHECK_BITFIELD(autocum_flags, AUTOCUM_USER_FULL_LUST))
		strings += "you reach full lust"
	if(CHECK_BITFIELD(autocum_flags, AUTOCUM_PARTNER_FULL_LUST))
		strings += "your partner reaches full lust"
	if(CHECK_BITFIELD(autocum_flags, AUTOCUM_PARTNER_CUMS))
		strings += "partner cums"
	var/stuff = english_list(strings)
	to_chat(self, span_green("You'll automatically cum when [stuff]!"))

/datum/component/interaction_menu_granter/proc/change_autocum_flags()
	// var/mob/living/self = parent
	// output_autocum_string()


/datum/component/interaction_menu_granter/proc/format_orientation(mob/living/whose)
	if(!isliving(whose) || !whose.client)
		return list()
	var/list/ret = list()
	var/list/beep = list()
	switch(whose.client?.prefs.kisser)
		if(KISS_BOYS)
			beep["OriName"] = "Boykisser"
			beep["OriDesc"] = "I like guys!"
			beep["OriEmoji"] = "♂️"
		if(KISS_GIRLS)
			beep["OriName"] = "Girlkisser"
			beep["OriDesc"] = "I like gals!"
			beep["OriEmoji"] = "♀️"
		if(KISS_ANY)
			beep["OriName"] = "Anykisser"
			beep["OriDesc"] = "I like everyone!"
			beep["OriEmoji"] = "👩‍❤️‍👨"
	if(LAZYLEN(beep))
		ret += list(beep)
	beep = list()
	switch(whose.client?.prefs.tbs)
		if(TBS_TOP)
			beep["OriName"] = "Top"
			beep["OriDesc"] = "I like to be on top!"
			beep["OriEmoji"] = "👆"
		if(TBS_BOTTOM)
			beep["OriName"] = "Bottom"
			beep["OriDesc"] = "I like to be on bottom!"
			beep["OriEmoji"] = "👇"
		if(TBS_SHOES)
			beep["OriName"] = "Switch"
			beep["OriDesc"] = "I like to switch!"
			beep["OriEmoji"] = "👍"
	if(LAZYLEN(beep))
		ret += list(beep)
	return ret

/datum/component/interaction_menu_granter/proc/update_display_filter(block_data_update)
	cached_interactions.Cut()
	if(LAZYLEN(search_term))
		current_category = MERP_CAT_ALL
	var/mob/living/self = parent
	var/mob/living/target = GET_WEAKREF(weaktarget)
	if(current_category == MERP_CAT_FAVES)
		var/list/faves = self.client?.prefs.faved_interactions || list()
		for(var/list/nukeclownpubes in SSinteractions.interactions_tgui) // he said suika, TWICE
			if(!islist(nukeclownpubes))
				continue
			if(nukeclownpubes["InteractionKey"] in faves)
				cached_interactions += list(nukeclownpubes)
		return TRUE
	var/is_just_me = target == self
	var/am_consent = SSinteractions.check_consent_chain(self, target)
	var/list/output_interactions = SSinteractions.interactions_tgui.Copy()
	for(var/list/i_obj in output_interactions)
		if(!islist(i_obj))
			continue // something went hilariously wrong, and not the ha ha kind
		if(!SeeExtreme && i_obj["InteractionExtreme"]) // me and the Capslock make it happen
			output_interactions -= list(i_obj)
			continue
		if(!SeeLewd && i_obj["InteractionLewd"])
			output_interactions -= list(i_obj)
			continue
		var/needconsent = !is_just_me && i_obj["InteractionLewd"] || i_obj["InteractionExtreme"] || FALSE
		if(needconsent && !am_consent)
			output_interactions -= list(i_obj)
			continue
		if(current_category != MERP_CAT_ALL && !(current_category in i_obj["InteractionCategories"]))
			output_interactions -= list(i_obj)
			continue
		if(is_just_me && !i_obj["InteractionSelf"])
			output_interactions -= list(i_obj)
			continue
		if(search_term)
			if(findtext(lowertext(i_obj["InteractionName"]), lowertext(search_term)))
				continue
			if(findtext(lowertext(i_obj["InteractionDescription"]), lowertext(search_term)))
				continue
			output_interactions -= list(i_obj)
			continue
	cached_interactions = output_interactions.Copy()
	if(block_data_update) // to keep tgui from going into an infinite loop
		return TRUE // fun facgt, you used to runtime every time you did a menu action
	durty = FALSE
	update_static_data(usr) // imma update ur butt
	return TRUE

#undef INTERACTION_NORMAL
#undef INTERACTION_LEWD
#undef INTERACTION_EXTREME
#undef INTERACTION_CONSENT
#undef SPLURT_MAX_AUTOPLAPPERS
		/* todo: make this work : ^ )
		if("genital")
			var/mob/living/carbon/self = parent_mob
			if("visibility" in params)
				if(params["genital"] == "anus")
					self.anus_toggle_visibility(params["visibility"])
					return TRUE
				var/obj/item/organ/genital/genital = locate(params["genital"], self.internal_organs)
				if(genital && (genital in self.internal_organs))
					genital.toggle_visibility(params["visibility"])
					return TRUE
			if("set_arousal" in params)
				var/obj/item/organ/genital/genital = locate(params["genital"], self.internal_organs)
				if(!genital || (genital \
					&& (!CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_AROUSE) \
					|| HAS_TRAIT(self, TRAIT_PERMABONER) \
					|| HAS_TRAIT(self, TRAIT_NEVERBONER))))
					return FALSE
				var/original_state = genital.aroused_state
				genital.set_aroused_state(params["set_arousal"])// i'm not making it just `!aroused_state` because
				if(original_state != genital.aroused_state)		// someone just might port skyrat's new genitals
					to_chat(self, span_userlove("[genital.aroused_state ? genital.arousal_verb : genital.unarousal_verb]."))
					. = TRUE
				else
					to_chat(self, span_userlove("You can't make that genital [genital.aroused_state ? "unaroused" : "aroused"]!"))
					. = FALSE
				genital.update_appearance()
				if(ishuman(self))
					var/mob/living/carbon/human/human = self
					human.update_genitals()
				return
			if("set_accessibility" in params)
				if(!self.getorganslot(ORGAN_SLOT_ANUS) && params["genital"] == "anus")
					self.toggle_anus_always_accessible()
					return TRUE
				var/obj/item/organ/genital/genital = locate(params["genital"], self.internal_organs)
				if(!genital)
					return FALSE
				genital.toggle_accessibility()
				return TRUE
			else
				return FALSE
			*/

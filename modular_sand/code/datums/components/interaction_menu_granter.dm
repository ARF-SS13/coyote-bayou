#define SPLURT_MAX_AUTOPLAPPERS 3
#define SPLURT_ANTISPAM if(!click_refractory()) return FALSE
#define AUTOCUM_PARTNER_CUMS (1 << 0) // cums (u do too)
#define AUTOCUM_USER_FULL_LUST (1 << 1)
#define AUTOCUM_PARTNER_FULL_LUST (1 << 2)

/// Attempts to open the tgui menu
/mob/verb/interact_with()
	set name = "Interact With"
	set desc = "Perform an interaction with someone."
	set category = "IC"
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

/datum/component/interaction_menu_granter/Initialize(...)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/parent_mob = parent
	if(!parent_mob.client)
		return COMPONENT_INCOMPATIBLE
	. = ..()

/datum/component/interaction_menu_granter/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, .proc/open_menu)
	RegisterSignal(parent, COMSIG_SPLURT_REMOVE_AUTOPLAPPER, .proc/kill_autoplapper)
	RegisterSignal(parent, COMSIG_SPLURT_ADD_AUTOPLAPPER, .proc/confirm_autoplap)
	RegisterSignal(parent, COMSIG_SPLURT_SOMEONE_CUMMED, .proc/sympathetic_detonation)

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
	data["AllInteractions"] = SSinteractions.interactions_tgui || list()
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
			return TRUE
		if("Favorite")
			if(!P)
				return FALSE
			if(params["interaction"] in P.faved_interactions)
				P.faved_interactions -= params["interaction"]
			else
				P.faved_interactions += params["interaction"]
			queue_save()
			interface_sound(1)
			return TRUE
		if("DeleteAutoPlapper")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP)
				return FALSE
			remove_autoplap(AP.apid)
			interface_sound(1)
			return TRUE
		if("StartRecording")
			if(is_recording())
				perform_action(GET_WEAKREF(weaktarget), params["interaction"], params["extra"]) // try to finish it off
				return FALSE
			new_autoplap(params["interaction"], GET_WEAKREF(weaktarget), null)
			interface_sound(1)
			return TRUE
		if("StopRecording")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP.plap_listening)
				return TRUE
			to_chat(parent_mob, span_green("Aborted recording [AP.plap_key]!"))
			autoplappers -= AP.apid
			qdel(AP)
			interface_sound(1)
			return TRUE
		if("SetAutoPlapperInterval")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP)
				return FALSE
			AP.plap_interval = text2num(params["Interval"])
			return TRUE
		if("ToggleAutoPlapper")
			var/datum/autoplapper/AP = autoplappers[params["APID"]]
			if(!AP)
				return FALSE
			AP.toggle_plapping()
			interface_sound(1)
			return TRUE
		if("ConsentAct")
			SPLURT_ANTISPAM
			to_chat(parent_mob, span_notice("Requesting consent from [GET_WEAKREF(weaktarget)]..."))
			SSinteractions.add_or_remove_consent(parent_mob, GET_WEAKREF(weaktarget))
			interface_sound(2)
			return TRUE
		// if("MTTC")
		// 	update_mean_time_to_cum(params["value"])
		// 	return TRUE
		if("Cum")
			SPLURT_ANTISPAM
			parent_mob.cum()
			interface_sound(3)
			return TRUE
		if("ToggleAutoCum")
			TOGGLE_VAR(parent_mob.ready_to_cum)
			if(parent_mob.ready_to_cum)
				to_chat(parent_mob, span_green("You will automatically cum when your arousal reaches 100%!"))
			else
				to_chat(parent_mob, span_green("You will no longer automatically cum when your arousal reaches 100%!"))
			interface_sound(1)
			return TRUE
		if("ToggleAutoStart")
			interface_sound(1)
			TOGGLE_VAR(autoplapper_autostart)
			return TRUE
		if("StopAllAutoPlappers")
			SPLURT_ANTISPAM
			for(var/ap in autoplappers)
				var/datum/autoplapper/AP = autoplappers[ap]
				if(!AP)
					continue
				AP.stop_plapping()
			to_chat(parent_mob, span_green("Stopped all autoplappers!"))
			interface_sound(1)
			return TRUE
		if("StartAllAutoPlappers")
			SPLURT_ANTISPAM
			for(var/ap in autoplappers)
				var/datum/autoplapper/AP = autoplappers[ap]
				if(!AP)
					continue
				AP.start_plapping()
			to_chat(parent_mob, span_green("Started all autoplappers!"))
			interface_sound(1)
			return TRUE
		if("ToggleSeeLewd")
			TOGGLE_VAR(SeeLewd)
			if(SeeLewd)
				to_chat(parent_mob, span_green("Lewd stuff enabled!"))
			else
				to_chat(parent_mob, span_green("Lewd stuff disabled!"))
			interface_sound(1)
			return TRUE
		if("ToggleSeeExtreme")
			TOGGLE_VAR(SeeExtreme)
			if(SeeExtreme)
				to_chat(parent_mob, span_green("Extreme stuff enabled!"))
			else
				to_chat(parent_mob, span_green("Extreme stuff disabled!"))
			interface_sound(1)
			return TRUE
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
			return TRUE
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
			return TRUE
		if("AutocumFlagify")
			change_autocum_flags()
			interface_sound(1)
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
	savetimer = addtimer(CALLBACK(src, .proc/save_prefs), 4 SECONDS, TIMER_STOPPABLE) // save in 4 seconds

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

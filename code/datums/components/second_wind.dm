#define FLOOR_MASTER var/mob/living/master = parent
#define BODY_PLAYED var/mob/played = ckey2mob(my_ckey); if(!played) return;

#define SW_ERROR_NO_ERROR       0
#define SW_ERROR_NO_BODY        (1 << 0)
#define SW_ERROR_QDELLED_BODY   (1 << 1)
#define SW_ERROR_THIRD_WINDED   (1 << 2)
#define SW_ERROR_NO_GHOST       (1 << 3)
#define SW_ERROR_NOT_DEAD       (1 << 4)
#define SW_ERROR_BODY_OCCUPIED  (1 << 5)
#define SW_ERROR_CANNOT_REENTER (1 << 6)
#define SW_ERROR_ON_COOLDOWN    (1 << 7)
#define SW_ERROR_CUFFED         (1 << 8)
#define SW_ERROR_NO_LIVES       (1 << 9)

#define SW_UI_DEFAULT "SWDefault"
#define SW_UI_REVIVE_CONFIRM "SWReviveConfirm"
#define SW_UI_THIRD_WIND_WARNING "SWThirdWindWarning"
#define SW_UI_THIRD_WINDED "SWThirdWinded"
#define SW_UI_README "SWReadMe"

#define SW_README \
	"Second Wind allows you to revive yourself when you die, without needing someone to go find your body. \n\n\
	Your dead body will be healed to just above death, have its reagents purged, and be given some healing chems based on your worst injuries. \
	After that, it is recommended to get to safety as quick as you can! \n\n\
	You start with a single Second Wind, which allows you to revive yourself once. \
	If you manage to survive for two hours after using your Second Wind, you'll get one more! \n\n\
	If you die without a Second Wind, you have the option to push yourself into using your Third Wind, which will revive you, \
	but prevent you from regaining any more Second Winds. If you die after this Third Wind, you'll be unable to revive yourself, \
	and the only ways back into the round will be if someone finds and revives your body, or you hop onto a different character. \n\n\
	Do note that you need to have an intact body to revive yourself, so if your body gets deleted, destroyed, or gibbed, you're out of luck! \n\n\
	Also, if your body is handcuffed, you will not be able to revive yourself until you are uncuffed."
#define SW_TW_WARNING "WARNING: This is your last life! If you revive yourself now, you will not be able to revive yourself again if you die! \
	The only way you'll be able to play if you die again is if someone finds and revives you, or you hop onto a different character! \
	If you're sure you want to do this, please type REZ ME in the box below. Otherwise, click CANCEL."
#define SW_REVIVE_CONFIRM_MSG "Are you sure you want to revive yourself? You will need to wait around two hours after you revive to get another Second Wind. \
	If you die before then, you will need to use your Third Wind to revive yourself, or wait for someone to find your body and revive you."

/datum/component/second_wind
	var/my_ckey
	var/lives_left = 1
	var/third_winded = FALSE
	var/ui_state = SW_UI_DEFAULT
	var/last_life_tick = 0
	COOLDOWN_DECLARE(second_wind_cooldown)
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/second_wind/Initialize()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_MOB_CLIENT_LOGIN), .proc/update_ckey)
	RegisterSignal(parent, list(COMSIG_SECOND_WIND), .proc/open_revive_menu)
	RegisterSignal(parent, list(COMSIG_SECOND_WIND_GRANT), .proc/grant_second_wind)
	RegisterSignal(parent, list(COMSIG_LIVING_BIOLOGICAL_LIFE), .proc/check_living)

/datum/component/second_wind/proc/update_ckey(mob/my_mob, client/logged_in)
	if(!isclient(logged_in))
		return
	if(!logged_in.ckey)
		return
	my_ckey = logged_in.ckey

/datum/component/second_wind/proc/check_living()
	if(third_winded || lives_left == 1)
		second_wind_cooldown = 0
		return
	if(!last_life_tick)
		last_life_tick = world.time
		return
	FLOOR_MASTER
	if(!isliving(master))
		return
	if(master.stat == DEAD)
		second_wind_cooldown += (world.time - last_life_tick) // effectively pauses the timer while you're dead
	else if(lives_left == 0 && second_wind_cooldown == 0 && !third_winded)
		COOLDOWN_START(src, second_wind_cooldown, SSmobs.second_wind_cooldown)
	last_life_tick = world.time
	if(COOLDOWN_FINISHED(src, second_wind_cooldown))
		BODY_PLAYED
		to_chat(played, span_greentext("You feel your energy return to you! Seems like you've gotten yourself a second wind!"))
		lives_left = 1

/datum/component/second_wind/proc/open_revive_menu()
	BODY_PLAYED
	if(third_winded)
		ui_state = SW_UI_THIRD_WINDED
	ui_interact(played)

/// For admemes to give someone a one-up
/datum/component/second_wind/proc/grant_second_wind()
	BODY_PLAYED
	third_winded = FALSE
	lives_left = 1
	COOLDOWN_RESET(src, second_wind_cooldown)
	to_chat(played, span_greentext("You feel a sudden rush of energy! Seems like you've been given a second wind for the next time you die!"))

/datum/component/second_wind/proc/attempt_revive()
	BODY_PLAYED
	var/error_code = can_revive()
	if(CHECK_BITFIELD(error_code, SW_ERROR_NO_BODY))
		to_chat(played, span_alert("You don't have a body to revive!"))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_QDELLED_BODY))
		to_chat(played, span_alert("Your body is in the trash where it belongs! (it has been deleted, sorry!)"))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_THIRD_WINDED))
		to_chat(played, span_userdanger("You've already exerted yourself far beyond your limits! You'll need someone else to revive you!"))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_CANNOT_REENTER))
		to_chat(played, span_alert("You've made it clear that you want to be dead. You can't revive yourself!"))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_NO_GHOST))
		to_chat(played, span_phobia("The body you're trying to reach doesn't recognize you as its ghost! This... is probably a bug."))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_NOT_DEAD))
		to_chat(played, span_notice("You're not dead yet!"))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_BODY_OCCUPIED))
		to_chat(played, span_alert("Someone's already in your body!"))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_CUFFED))
		to_chat(played, span_alert("Your body is cuffed! You can't revive yourself!"))
		return
	if(CHECK_BITFIELD(error_code, SW_ERROR_NO_LIVES))
		to_chat(played, span_alert("You don't have a Second Wind! You could use your Third Wind though..."))
		pls_confirm_third_wind()
		return
	/// Okay, we're good to revive!
	revive_me()

/datum/component/second_wind/proc/verify_revive(thirdwind)
	if(third_winded)
		return
	if(lives_left == 0 && !thirdwind)
		return
	var/error_code = can_revive()
	if(CHECK_BITFIELD(error_code, SW_ERROR_NO_BODY) || CHECK_BITFIELD(error_code, SW_ERROR_QDELLED_BODY) || CHECK_BITFIELD(error_code, SW_ERROR_THIRD_WINDED) || CHECK_BITFIELD(error_code, SW_ERROR_NO_GHOST) || CHECK_BITFIELD(error_code, SW_ERROR_NOT_DEAD) || CHECK_BITFIELD(error_code, SW_ERROR_CUFFED))
		return
	return TRUE

/datum/component/second_wind/proc/revive_me(third_wind)
	FLOOR_MASTER
	BODY_PLAYED
	var/datum/reagents/master_reagents = master.reagents
	master_reagents.remove_all(999) // First purge all their reagents
	master.adjustOxyLoss(-999)
	master.adjust_fire_stacks(-20)
	var/list/my_damages = list(
		"brute" = master.getBruteLoss(),
		"burn" = master.getFireLoss(),
		"tox" = master.toxloss,
	)
	var/total_damage = 0
	for(var/dtype in my_damages)
		total_damage += my_damages[dtype]
	var/deficit = total_damage - 120
	var/list/to_heal = list(
		"brute" = 0,
		"burn" = 0,
		"tox" = 0,
	)
	while(deficit-- > 0 && my_damages.len)
		var/damtype = pick(my_damages)
		my_damages[damtype] -= 1
		to_heal[damtype] += 1
		if(my_damages[damtype] <= 0)
			my_damages -= damtype
	var/highest_type = "brute"
	var/highest = my_damages["brute"]
	for(var/dtype in my_damages)
		if(my_damages[type] > highest)
			highest_type = dtype
			highest = my_damages[dtype]
	master.apply_damages(
		brute = -to_heal["brute"],
		burn = -to_heal["burn"],
		tox = -to_heal["tox"],
		oxy = -200,
		brain = -200,
	)
	var/toxinlover = FALSE
	if(iscarbon(master))
		var/mob/living/carbon/mastercarbon = master
		var/datum/species/my_oc = mastercarbon.dna?.species
		if(TRAIT_TOXINLOVER in (my_oc?.inherent_traits))
			toxinlover = TRUE
	switch(highest_type)
		if("brute")
			master_reagents.add_reagent(/datum/reagent/medicine/sal_acid, 10)
		if("burn")
			master_reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 10)
		if("tox")
			if(toxinlover)
				master_reagents.add_reagent(/datum/reagent/toxin, 20)
			else
				master_reagents.add_reagent(/datum/reagent/medicine/antitoxin, 10)
				master_reagents.add_reagent(/datum/reagent/medicine/prussian_blue, 10)
	master_reagents.add_reagent(/datum/reagent/medicine/epinephrine, 10)
	master_reagents.add_reagent(/datum/reagent/medicine/salglu_solution, 100)
	master_reagents.add_reagent(/datum/reagent/medicine/coagulant, 15)
	master_reagents.add_reagent(/datum/reagent/medicine/silibinin, 15)
	master_reagents.add_reagent(/datum/reagent/medicine/polypyr, 15)
	master_reagents.add_reagent(/datum/reagent/medicine/muscle_stimulant, 20)
	/// should be enough to get them up
	master.revive()
	var/mob/ghost = master.get_ghost()
	if(master.stat == DEAD && !ghost) // huh, still dead
		COOLDOWN_RESET(src, second_wind_cooldown)
		to_chat(played, span_alert("Something went wrong and you're still dead!"))
		master.apply_damages(
			brute = to_heal["brute"],
			burn = to_heal["burn"],
			tox = to_heal["tox"],
		)
		master_reagents.remove_all(999)
		return
	ghost.client?.change_view(CONFIG_GET(string/default_view))
	ghost.transfer_ckey(ghost.mind.current, FALSE)
	SStgui.on_transfer(src, ghost.mind.current) // Transfer NanoUIs.
	ghost.mind?.current?.client?.init_verbs()
	if(third_wind)
		third_winded = TRUE
	else
		COOLDOWN_START(src, second_wind_cooldown, SSmobs.second_wind_cooldown)
	message_the_revived()
	return TRUE

/datum/component/second_wind/proc/message_the_revived()
	FLOOR_MASTER
	if(third_winded)
		to_chat(master, span_userdanger("You have exerted every last ounce of mortal strength you have into your second chance! If you die again, your only choice for revival will be from a rescuer!"))
		master.mind.store_memory("You're all out of revives, and if you die again, you'll need someone to rescue you!")
	else
		to_chat(master, span_userdanger("You have found the strength to revive yourself! However, it was very taxing, you'll need to wait at least two hours before you can safely do it again."))
		master.mind.store_memory("You've used your second wind, and you'll need to wait at least two hours before you can safely do it again.")

/datum/component/second_wind/proc/can_revive(booleanate)
	FLOOR_MASTER
	. = SW_ERROR_NO_ERROR
	if(!isliving(master))
		. |= SW_ERROR_NO_BODY
	if(QDELETED(master))
		. |= SW_ERROR_QDELLED_BODY
	if(third_winded)
		. |= SW_ERROR_THIRD_WINDED
	var/mob/dead/observer/myghost = master.get_ghost()
	if(!myghost)
		. |= SW_ERROR_NO_GHOST
	if(!myghost.can_reenter_corpse || master.suiciding)
		. |= SW_ERROR_CANNOT_REENTER
	if(!master.stat != DEAD)
		. |= SW_ERROR_NOT_DEAD
	if(lives_left <= 0)
		. |= SW_ERROR_NO_LIVES
	if(master.restrained(TRUE))
		. |= SW_ERROR_CUFFED
	if(!booleanate)
		return
	. &= ~SW_ERROR_NO_LIVES
	. = !!!. // booleanated

/datum/component/second_wind/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SecondWind")
		ui.open()

/datum/component/second_wind/proc/format_revival_error()
	var/revive_error = can_revive()
	var/am_alive = CHECK_BITFIELD(revive_error, SW_ERROR_NOT_DEAD)
	var/list/readme = list(
		"CodeName" = "Clear to revive",
		"CodeDesc" = "You can revive yourself!",
		"CodeColor" = "good",
	)
	if(CHECK_BITFIELD(revive_error, SW_ERROR_NO_LIVES))
		readme["CodeName"] = "No Second Wind"
		if(am_alive)
			readme["CodeDesc"] = "You have revived yourself recently, and you'll need to wait a while before you can do it again safely! \
				You will still be able to revive yourself, but it'll be your last! Try to stay alive!"
		else
			readme["CodeDesc"] = "You have revived yourself recently, and while you can still revive yourself right now, it will be your last! \
				If you die again after reviving, you'll need to be rescued, or hop on a different character if you want to keep playing!"
		readme["CodeColor"] = "phobia"
	if(CHECK_BITFIELD(revive_error, SW_ERROR_THIRD_WINDED))
		readme["CodeName"] = "Third winded"
		if(am_alive)
			readme["CodeDesc"] = "You've already used your third wind, you won't be able to revive yourself if you die!"
			if(prob(1))
				readme["CodeDesc"] += " YOLO~"
		else
			readme["CodeDesc"] = "You've already used your third wind, you can't revive yourself! You'll need to be rescued, or hop on a different character if you want to keep playing!"
		readme["CodeColor"] = "phobia"
	if(CHECK_BITFIELD(revive_error, SW_ERROR_NO_BODY))
		readme["CodeName"] = "No body"
		readme["CodeDesc"] = "You don't have a body to revive!"
		readme["CodeColor"] = "bad"
	if(CHECK_BITFIELD(revive_error, SW_ERROR_QDELLED_BODY))
		readme["CodeName"] = "Body deleted"
		readme["CodeDesc"] = "Your body is in the trash where it belongs (its been deleted, sorry!) You can't revive yourself!"
		readme["CodeColor"] = "bad"
	if(CHECK_BITFIELD(revive_error, SW_ERROR_BODY_OCCUPIED))
		readme["CodeName"] = "Body occupied"
		readme["CodeDesc"] = "Your body is occupied by someone else! You can't revive yourself!"
		readme["CodeColor"] = "bad"
	if(CHECK_BITFIELD(revive_error, SW_ERROR_CUFFED))
		readme["CodeName"] = "Body handcuffed"
		readme["CodeDesc"] = "Your body is handcuffed! You can't revive yourself!"
		readme["CodeColor"] = "bad"
	if(CHECK_BITFIELD(revive_error, SW_ERROR_NO_GHOST))
		readme["CodeName"] = "No ghost"
		readme["CodeDesc"] = "You somehow lack a ghost! This is probably a bug."
		readme["CodeColor"] = "bad"
	if(CHECK_BITFIELD(revive_error, SW_ERROR_CANNOT_REENTER))
		readme["CodeName"] = "Can't re-enter your body"
		readme["CodeDesc"] = "You have elected to stay dead, or something along those lines."
		readme["CodeColor"] = "bad"
	return readme

/datum/component/second_wind/proc/get_cooldown_timeleft()
	FLOOR_MASTER
	if(third_winded)
		return "Never!"
	if(master.stat == DEAD)
		return "Paused!"
	if(COOLDOWN_FINISHED(src, second_wind_cooldown))
		return "Now!"
	return "[DisplayTimeText(COOLDOWN_TIMELEFT(src, second_wind_cooldown), 1)] seconds"

/datum/component/second_wind/proc/get_cooldown_percent()
	if(COOLDOWN_FINISHED(src, second_wind_cooldown))
		return 100
	var/nowish = second_wind_cooldown - world.time
	var/percent = round((nowish / SSmobs.second_wind_cooldown) * 100, 0.1)
	return percent

/datum/component/second_wind/proc/would_third_wind()
	if(lives_left <= 0 && !third_winded)
		return TRUE

/datum/component/second_wind/ui_data(mob/user)
	var/list/data = list()
	data["BaseCD"] = SSmobs.second_wind_cooldown
	data["TimeLeft"] = get_cooldown_timeleft()
	data["PercentLeft"] = get_cooldown_percent()
	data["RezCode"] = format_revival_error()
	data["Lives"] = lives_left
	data["ThirdWinded"] = third_winded
	data["WouldThirdWind"] = would_third_wind()
	data["ThirdWindWarning"] = SW_TW_WARNING
	data["ReviveConfirmMsg"] = SW_REVIVE_CONFIRM_MSG
	data["ShowButtons"] = can_revive(TRUE)
	data["ReadMe"] = SW_README
	data["UIState"] = ui_state
	return data

/datum/component/second_wind/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("ThirdWindMe")
			home_page()
			if(!verify_revive(TRUE))
				. = TRUE
				return
			revive_me(TRUE)
			. = TRUE
		if("ReviveMe")
			home_page()
			if(!verify_revive())
				. = TRUE
				return
			revive_me()
			. = TRUE
		if("GoBack")
			home_page()
			. = TRUE
		if("HelpMe")
			readme_page()
			. = TRUE

/// Sets the UI state to the given state, and updates the UI.
/datum/component/second_wind/proc/pls_confirm_revive()
	if(third_winded)
		am_third_winded()
		return
	if(ui_state == SW_UI_REVIVE_CONFIRM)
		return
	ui_state = SW_UI_REVIVE_CONFIRM
	open_revive_menu()

/// Sets the UI state to the given state, and updates the UI.
/datum/component/second_wind/proc/pls_confirm_third_wind()
	if(third_winded)
		am_third_winded()
		return
	if(ui_state == SW_UI_THIRD_WIND_WARNING)
		return
	ui_state = SW_UI_THIRD_WIND_WARNING
	open_revive_menu()

/datum/component/second_wind/proc/home_page()
	if(third_winded)
		am_third_winded()
		return
	ui_state = SW_UI_DEFAULT
	open_revive_menu()

/datum/component/second_wind/proc/readme_page()
	ui_state = SW_UI_README
	open_revive_menu()

/datum/component/second_wind/proc/am_third_winded()
	if(!third_winded)
		return
	ui_state = SW_UI_THIRD_WINDED
	open_revive_menu()

/mob/verb/second_wind()
	set name = "Second Wind"
	set desc = "Attempt to revive yourself (or just check on it)."
	set category = "IC"

	if(!mind.current)
		return
	SEND_SIGNAL(mind.current, COMSIG_SECOND_WIND)

#undef FLOOR_MASTER
#undef BODY_PLAYED

#undef SW_ERROR_NO_BODY
#undef SW_ERROR_QDELLED_BODY
#undef SW_ERROR_THIRD_WINDED
#undef SW_ERROR_NO_GHOST
#undef SW_ERROR_NOT_DEAD
#undef SW_ERROR_BODY_OCCUPIED
#undef SW_ERROR_CANNOT_REENTER
#undef SW_ERROR_ON_COOLDOWN
#undef SW_ERROR_CUFFED

#undef SW_UI_DEFAULT
#undef SW_UI_REVIVE_CONFIRM
#undef SW_UI_THIRD_WIND_WARNING
#undef SW_UI_THIRD_WINDED
#undef SW_UI_README

#undef SW_README
#undef SW_TW_WARNING
#undef SW_REVIVE_CONFIRM_MSG

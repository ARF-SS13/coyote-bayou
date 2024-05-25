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
	RegisterSignal(parent, list(COMSIG_MOB_CLIENT_LOGIN),PROC_REF(update_ckey))
	RegisterSignal(parent, list(COMSIG_SECOND_WIND),PROC_REF(open_revive_menu))
	RegisterSignal(parent, list(COMSIG_SECOND_WIND_GRANT),PROC_REF(grant_second_wind))
	RegisterSignal(parent, list(COMSIG_LIVING_BIOLOGICAL_LIFE),PROC_REF(check_living))

/datum/component/second_wind/proc/update_ckey(mob/my_mob, client/logged_in)
	if(!isclient(logged_in))
		return
	if(!logged_in.ckey)
		return
	my_ckey = logged_in.ckey

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



/datum/component/second_wind/proc/would_third_wind()
	if(lives_left <= 0 && !third_winded)
		return TRUE


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



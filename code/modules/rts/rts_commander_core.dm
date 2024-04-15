////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
/// RTS PROCESSOR
/datum/rts_commander
	/// so players can find us
	var/cmdr_id
	/// so we can find our player c:
	var/cmdr_ckey

	var/datum/rts_selector_effect/mybox

	var/intercepting = FALSE

	/// User interface stuff
	var/left_is_down = FALSE
	var/right_is_down = FALSE
	var/ctrl_is_down = FALSE
	var/shift_is_down = FALSE
	var/alt_is_down = FALSE

	/// turfs of interest
	var/atom/origin_atom
	var/turf/origin_turf

	// SECTION UI
	var/list/buttons



/datum/rts_commander/New(mob/user)
	UpdateCmdrID(user)
	mybox = new()

/datum/rts_commander/proc/UpdateCmdrID(mob/user)
	if(user)
		cmdr_id = SSeconomy.extract_quid(user)
		cmdr_ckey = extract_ckey(user)

/datum/rts_commander/proc/ActivateInputInterceptor(mob/commander)
	UpdateCmdrID(commander)
	var/client/C = GetCommanderClient() // we do things by the BOOK
	if(!C)
		return FALSE // not really anything to do
	if(intercepting)
		return FALSE
	if(C.click_intercept)
		to_chat(C, "You're already doing something that captures the cursor!")
		return FALSE
	C.click_intercept = src
	C.show_popup_menus = FALSE // so their rightclick doesnt make a menu
	// create_buttons()
	// C.screen += buttons
	intercepting = TRUE
	to_chat(C, span_green("Welcome, commander!"))
	return TRUE

/datum/rts_commander/proc/DeactivateInputInterceptor()
	var/client/C = GetCommanderClient()
	if(!C)
		return // not really anything to do
	if(!intercepting)
		return // not really anything to do
	if(C.click_intercept != src)
		return // may be a problem, but not my problem
	C.screen -= buttons
	C.click_intercept = null
	C.show_popup_menus = TRUE
	intercepting = FALSE
	to_chat(C, span_red("Goodbye, commander!"))

/datum/rts_commander/proc/GetCommanderClient()
	return extract_client(cmdr_ckey)

/datum/rts_commander/proc/InterceptClickOn(mob/user, params, atom/object)

	return TRUE // no doing underlying actions

/// First part of an input, records stuff that was clicked on and with which button
/datum/rts_commander/proc/InterceptMouseDown(mob/user, params, atom/object)
	origin_atom = object
	origin_turf = get_turf(object)
	UpdateHeldKeys(params)
	/// ah what the heck, start a selection box if we're left clicking
	if(left_is_down)
		mybox.update_box(origin_turf, origin_turf, cmdr_ckey) // the two are the same
	return TRUE // no doing underlying actions

/// Last pert of an input, takes in what we know from the mouse's position,
/// and our origin thing, and the keys we used to click, and does something with it
/datum/rts_commander/proc/InterceptMouseUp(mob/user, params, atom/object)

	CleanupHeldKeys(user, params, object) // remove the keys we were holding, and their effects
	return TRUE // no doing underlying actions

/// Mainly used to update the selection box
/datum/rts_commander/proc/InterceptMouseDrag(mob/user, src_object, params, over_object, src_location, over_location, src_control, over_control)
	UpdateHeldKeys(params)
	/// update modifier keys
	if(left_is_down)
		var/turf/mouseover_turf = get_turf(over_object)
		mybox.update_box(origin_turf, mouseover_turf, cmdr_ckey)
	return TRUE // no doing underlying actions

/datum/rts_commander/proc/UpdateHeldKeys(params)
	var/list/parm = params2list(params)
	if(parm["right"])
		right_is_down = TRUE
	else
		right_is_down = FALSE
	if(parm["left"])
		left_is_down = TRUE
	else
		left_is_down = FALSE
	if(parm["ctrl"])
		ctrl_is_down = TRUE
	else
		ctrl_is_down = FALSE
	if(parm["shift"])
		shift_is_down = TRUE
	else
		shift_is_down = FALSE
	if(parm["alt"])
		alt_is_down = TRUE
	else
		alt_is_down = FALSE
	return TRUE

/datum/rts_commander/proc/CleanupHeldKeys(mob/user, params, atom/object)
	right_is_down = FALSE
	left_is_down = FALSE
	ctrl_is_down = FALSE
	shift_is_down = FALSE
	alt_is_down = FALSE
	mybox.clear_images()

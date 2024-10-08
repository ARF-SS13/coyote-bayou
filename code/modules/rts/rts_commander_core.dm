////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
/// RTS PROCESSOR
/datum/rts_commander
	/// so players can find us
	var/cmdr_id
	/// so we can find our player c:
	var/cmdr_ckey

	var/datum/rts_selector_box/mybox
	var/datum/rts_selector_box/attack/myattackbox
	var/datum/rts_selection_manager/mysel
	var/datum/rts_selection_manager/preview/mypvis
	var/datum/rts_order_processor/myord // m'lord
	// var/datum/rts_nest_cooldown_visualizer/mycdvis

	/// the datums that determines what we should be selecting
	var/list/criteria = list()
	var/active_criteria = "default"

	var/list/my_faction = list()
	var/list/valid_types = list()

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
	var/list/buttons = list()

/datum/rts_commander/New(mob/user)
	UpdateCmdrID(user)
	mybox = new(src)
	myattackbox = new(src)
	mysel = new(src)
	mypvis = new(src)
	myord = new(src)
	for(var/pat in subtypesof(/datum/rts_criteria))
		var/datum/rts_criteria/newpat = pat
		newpat = new(src)
		criteria[newpat.kind] = newpat
		if(newpat.is_default)
			active_criteria = newpat.kind
	buttons.len = 3
	buttons[1] = new /atom/movable/screen/rts_button/mode()
	buttons[2] = new /atom/movable/screen/rts_button/help()
	buttons[3] = new /atom/movable/screen/rts_button/counter()

/datum/rts_commander/proc/UpdateCmdrID(mob/user)
	if(user)
		cmdr_id = SSeconomy.extract_quid(user)
		cmdr_ckey = extract_ckey(user)

/datum/rts_commander/proc/UpdateButtons()
	var/mob/user = GetCommanderMob()
	if(!isobserver(user))
		for(var/atom/movable/screen/rts_button/rb in buttons)
			user.client.screen -= rb
		return
	else
		for(var/atom/movable/screen/rts_button/rb in buttons)
			user.client.screen += rb
	if(intercepting)
		for(var/atom/movable/screen/rts_button/rb in buttons)
			rb.Activate()
	else
		for(var/atom/movable/screen/rts_button/rb in buttons)
			rb.Deactivate()

/datum/rts_commander/proc/SetMobCounterButton(numbor)
	var/atom/movable/screen/rts_button/counter/C = buttons[3]
	C.name = "You have [numbor] creatures selected!"
	C.UpdateMaptext(numbor)

/datum/rts_commander/proc/ActivateInputInterceptor(mob/commander)
	UpdateCmdrID(commander)
	var/client/C = GetCommanderClient() // we do things by the BOOK
	if(!C)
		return FALSE // not really anything to do
	if(C.click_intercept && C.click_intercept != src)
		to_chat(C, "You're already doing something that captures the cursor!")
		return FALSE
	C.click_intercept = src
	C.show_popup_menus = FALSE // so their rightclick doesnt make a menu
	// create_buttons()
	// C.screen += buttons
	intercepting = TRUE
	if(prob(0.25))
		to_chat(C, span_green("You deserve an orgy today, commander!"))
	else
		to_chat(C, span_green("Welcome, commander!"))
	return TRUE

/datum/rts_commander/proc/DeactivateInputInterceptor()
	var/client/C = GetCommanderClient()
	if(!C)
		return // not really anything to do
	if(C.click_intercept != src)
		return // may be a problem, but not my problem
	C.screen -= buttons
	C.click_intercept = null
	C.show_popup_menus = TRUE
	intercepting = FALSE
	ClearImages()
	to_chat(C, span_red("Goodbye, commander!"))

/datum/rts_commander/proc/GetCommanderClient()
	return extract_client(cmdr_ckey)

/datum/rts_commander/proc/GetCommanderMob()
	var/client/C = GetCommanderClient()
	return C.mob

/datum/rts_commander/proc/InterceptClickOn(mob/user, params, atom/object)

	return TRUE // no doing underlying actions

/// First part of an input, records stuff that was clicked on and with which button
/datum/rts_commander/proc/InterceptMouseDown(mob/user, params, atom/object)
	origin_atom = object
	origin_turf = get_turf(object)
	UpdateHeldKeys(params)
	/// ah what the heck, start a selection box if we're left clicking
	if(left_is_down && !right_is_down)
		mybox.update_box(origin_turf, origin_turf, params) // the two are the same
	else if(right_is_down && !left_is_down)
		myattackbox.update_box(origin_turf, origin_turf, params)
	myord.ProcessMouseDown(origin_atom, object, params)
	return TRUE // no doing underlying actions

/// Last pert of an input, takes in what we know from the mouse's position,
/// and our origin thing, and the keys we used to click, and does something with it
/datum/rts_commander/proc/InterceptMouseUp(mob/user, params, atom/object)
	// var/list/parm = params2list(params)
	/// if we're left clicking, we're selecting
	myord.ProcessMouseUp(origin_atom, object, params)
	if(left_is_down && !right_is_down)
		mysel.SelectRegion(origin_turf, get_turf(object), LAZYACCESS(criteria, active_criteria), params)
	CleanupHeldKeys(user, params, object) // remove the keys we were holding, and their effects
	return TRUE // no doing underlying actions

/// Mainly used to update the selection box
/datum/rts_commander/proc/InterceptMouseDrag(mob/user, src_object, params, over_object, src_location, over_location, src_control, over_control)
	UpdateHeldKeys(params)
	/// update modifier keys
	if(left_is_down)
		var/turf/mouseover_turf = get_turf(over_object)
		mybox.update_box(origin_turf, mouseover_turf, params)
		mypvis.SelectRegion(origin_turf, mouseover_turf, LAZYACCESS(criteria, active_criteria), params)
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
	mysel.UpdateVisuals() // refreshes the selection plumbob
	mypvis.UpdateVisuals() // flushes the preview

/datum/rts_commander/proc/ClearImages()
	mybox.clear_images()
	mysel.clear_images()
	mypvis.clear_images()



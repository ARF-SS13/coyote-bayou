/datum/rts_mode
	var/name = "Oops"
	var/datum/rts_commander/parent

	var/left_is_down = FALSE
	var/right_is_down = FALSE

	// would corner selection work better as a component?
	var/use_corner_selection = FALSE
	var/list/preview
	var/turf/cornerA
	var/turf/cornerB

/datum/rts_mode/New(datum/rts_commander/cmdr)
	parent = cmdr
	return ..()

/datum/rts_mode/Destroy()
	if(parent)
		if(parent.active_mode == src)
			parent.active_mode = null
		parent.available_modes -= src
	parent = null
	return ..()

/datum/rts_mode/proc/enter_mode()
	return

/datum/rts_mode/proc/exit_mode()
	return

/datum/rts_mode/proc/get_button_iconstate()
	return "buildmode_[key]"

/datum/rts_mode/proc/show_help(client/c)
	CRASH("No help defined, yell at a coder")

/datum/rts_mode/proc/change_settings(client/c)
	to_chat(c, span_warning("There is no configuration available for this mode"))
	return

/datum/rts_mode/proc/Reset()
	deselect_region()

/datum/rts_mode/proc/handle_click(mob/user, params, atom/object)
	return TRUE // no doing underlying actions

/datum/rts_mode/proc/handle_mousedown(mob/user, params, atom/object)
	return TRUE // no doing underlying actions

/datum/rts_mode/proc/handle_mouseup(mob/user, params, atom/object)
	return TRUE // no doing underlying actions

/datum/rts_mode/proc/handle_mousedrag(mob/user, src_object, params, over_object, src_location, over_location, src_control, over_control)
	return TRUE // no doing underlying actions


/datum/rts_mode/proc/select_tile(turf/T, corner_to_select)
	var/overlaystate
	BM.holder.images -= preview
	switch(corner_to_select)
		if(AREASELECT_CORNERA)
			overlaystate = "greenOverlay"
		if(AREASELECT_CORNERB)
			overlaystate = "blueOverlay"

	var/image/I = image('icons/turf/overlays.dmi', T, overlaystate)
	I.plane = ABOVE_LIGHTING_PLANE
	preview += I
	BM.holder.images += preview
	return T

/datum/rts_mode/proc/highlight_region(region)
	BM.holder.images -= preview
	for(var/t in region)
		var/image/I = image('icons/turf/overlays.dmi', t, "redOverlay")
		I.plane = ABOVE_LIGHTING_PLANE
		preview += I
	BM.holder.images += preview

/datum/rts_mode/proc/deselect_region()
	BM.holder.images -= preview
	preview.Cut()
	cornerA = null
	cornerB = null

/datum/rts_mode/proc/handle_click(client/c, params, object)
	var/list/pa = params2list(params)
	var/left_click = pa.Find("left")
	if(use_corner_selection)
		if(left_click)
			if(!cornerA)
				cornerA = select_tile(get_turf(object), AREASELECT_CORNERA)
				return
			if(cornerA && !cornerB)
				cornerB = select_tile(get_turf(object), AREASELECT_CORNERB)
				to_chat(c, span_boldwarning("Region selected, if you're happy with your selection left click again, otherwise right click."))
				return
			handle_selected_area(c, params)
			deselect_region()
		else
			to_chat(c, span_notice("Region selection canceled!"))
			deselect_region()
	return

/datum/rts_mode/proc/handle_selected_area(client/c, params)

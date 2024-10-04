#define RTS_PREVIEW_TAG_ALREADY_SELECTED "rts_preview_already_selected"
#define RTS_PREVIEW_TAG_NEW_SELECTION "rts_preview_selected"
#define RTS_PREVIEW_TAG_DESELECTED "rts_preview_deselected"
#define RTS_PREVIEW_TAG_INVALID "rts_preview_invalid"
#define RTS_BOB_APP_FLAGS (RESET_COLOR|RESET_ALPHA|NO_CLIENT_COLOR)
/* 
 * filename: rts_selection_manager.dm
 * author: SligWolf (fursona name) / Slig (byond name)
 * license: XMQY Development License
 * 
 * description: This file contains the selection manager for the RTS system.
 * Does a bunch of cool things!
 * Can accept two turfs (or just one thing) and a list of held keys
 * From there, it can do a bunch of cool things, like:
 * - Select all units in a box
 * - pretty much just that for now lol
 * 
 * When something is selected, a few things happen
 * - It registers a signal to the mob so that if it dies or is removed, it is removed from the selection (preferably before it hard dels)
 * - Gives the mob a visual indicator that it is selected
 * - Adds it to a list of selected things
 * 
 * Can also be used to deselect things, which does the opposite of the above
 * This is done whenever a new selection is made, and that selection doesnt have any modifiers on it
 * Hold down ctrl to add to the selection, hold down shift to remove from the selection
 * 
 * Requests are made from the RTS commander, which returns the appropriate list of mobs
 * Which will probably be useful if we ever get more than one lol
 * 
 *  */

/datum/rts_selection_manager
	var/datum/rts_commander/parent
	var/ckey
	var/list/selected_mobs = list()
	var/list/preview_mobs = list()
	var/list/plumbobs = list()
	var/is_preview = FALSE

/datum/rts_selection_manager/New(datum/rts_commander/parent)
	src.parent = parent

/datum/rts_selection_manager/Destroy()
	DeselectAllMobs()
	. = ..()

/datum/rts_selection_manager/proc/SelectRegion(turf/turf1, turf/turf2, datum/rts_criteria/mcrib, list/params)
	if(!turf1 || !turf2 || turf1.z != turf2.z || !mcrib) // its back
		return
	var/list/inturfs = block(turf1, turf2)
	var/list/modifiers = params2list(params)
	var/shiftdown = modifiers["shift"]
	var/ctrldown = modifiers["ctrl"]
	var/justclick = !shiftdown && !ctrldown
	var/list/things_in_region = list()
	for(var/turf/T in inturfs)
		for(var/mob/living/L in T.contents)
			things_in_region |= L
	/// we have all the livings in the area, now we need to filter them
	/// Now we filter
	for(var/mob/living/L as anything in things_in_region)
		if(!mcrib.CanSelect(L, params))
			if(is_preview)
				SetPreview(L, RTS_PREVIEW_TAG_INVALID)
			things_in_region -= L
	/// two stages of preview updating, first is to load the Real Selector's state, and then overwrite parts that will be updated
	if(is_preview) /// just click, everything preselected is marked as To Be Deselected
		if(justclick)
			LoadSelectionPreview(RTS_PREVIEW_TAG_DESELECTED)
		else /// if we are holding down a modifier, that selection isnt going to be deleted outright
			LoadSelectionPreview(RTS_PREVIEW_TAG_ALREADY_SELECTED)
	/// now we either add to our selection or replace it
	else
		if(justclick)
			DeselectAllMobs()
	/// now apply our changes to the selection (if its a preview, otherwise its fine)
	for(var/mob/living/L as anything in things_in_region)
		if(is_preview)
			if(shiftdown)
				SetPreview(L, RTS_PREVIEW_TAG_DESELECTED)
			else
				SetPreview(L, RTS_PREVIEW_TAG_NEW_SELECTION)
		else
			if(shiftdown)
				DeselectMob(L)
			else
				SelectMob(L)
	UpdateVisuals()
	return TRUE

/// Selects a mob, adds it to the list of selected mobs, nice and prepped for our needs
/datum/rts_selection_manager/proc/SelectMob(mob/living/L)
	if(LAZYACCESS(selected_mobs, L))
		return
	selected_mobs[L] = list()
	var/image/pbob = image('icons/misc/mark.dmi', L, "plumbob")
	pbob.appearance_flags = RTS_BOB_APP_FLAGS
	pbob.color = "#00FF00"
	var/icon/IC = icon(L.icon)
	var/wid = IC.Width()
	var/hei = IC.Height()
	var/matrix/M = pbob.transform
	// M.Translate(wid / 2, hei / 2)
	M.Scale((wid / 32), (hei / 32))
	pbob.transform = M
	selected_mobs[L] |= pbob
	L.flags_2 |= MOB_NO_SLEEP
	RegisterSignal(L, COMSIG_PARENT_PREQDELETED, PROC_REF(DeselectMob))
	RegisterSignal(L, COMSIG_MOB_DEATH, PROC_REF(DeselectMob))

/// Deselects a mob, adds it to the list of preview mobs, nice and prepped for our needs
/datum/rts_selection_manager/proc/DeselectMob(mob/living/L)
	if(!L)
		return
	UnregisterSignal(L, COMSIG_PARENT_PREQDELETED)
	UnregisterSignal(L, COMSIG_MOB_DEATH)
	selected_mobs -= L

/// Deselects a mob, adds it to the list of preview mobs, nice and prepped for our needs
/datum/rts_selection_manager/proc/PreviewDeselect(mob/living/L)
	if(LAZYACCESS(preview_mobs, L))
		return
	preview_mobs[L] = RTS_PREVIEW_TAG_DESELECTED

/// Deselects all mobs
/datum/rts_selection_manager/proc/DeselectAllMobs()
	for(var/mob/living/L in selected_mobs)
		DeselectMob(L)

/// loads in all the already-selected things from the main selector
/datum/rts_selection_manager/proc/LoadSelectionPreview(state)
	for(var/mob/living/L as anything in parent.mysel.selected_mobs)
		SetPreview(L, state)

/// Sets the preview state of a mob
/datum/rts_selection_manager/proc/SetPreview(mob/living/L, state)
	preview_mobs[L] = state

/// Updates the visuals of the selected mobs
/datum/rts_selection_manager/proc/UpdateVisuals()
	///first remove the visuals shown to the player
	var/client/C = parent.GetCommanderClient()
	if(!C)
		return
	for(var/image/I in plumbobs)
		C.images -= I
	plumbobs.Cut()
	if(is_preview)
		for(var/mob/living/L as anything in preview_mobs)
			var/image/I = image('icons/misc/mark.dmi', L, "underbob")
			switch(preview_mobs[L])
				if(RTS_PREVIEW_TAG_ALREADY_SELECTED)
					I.color = "#00FFFF"
				if(RTS_PREVIEW_TAG_NEW_SELECTION)
					I.color = "#0000FF"
				if(RTS_PREVIEW_TAG_DESELECTED)
					I.color = "#ff00d0"
				if(RTS_PREVIEW_TAG_INVALID)
					I.color = "#FF0000"
			I.appearance_flags = RTS_BOB_APP_FLAGS
			var/icon/IC = icon(L.icon)
			var/wid = IC.Width()
			var/hei = IC.Height()
			var/matrix/M = I.transform
			// M.Translate(wid / 2, 0)
			M.Scale((wid / 32), (hei / 32))
			I.transform = M
			C.images += I
			plumbobs += I
		preview_mobs.Cut() // hold not reference not
	else
		for(var/mob/living/L as anything in selected_mobs)
			var/list/imgs = selected_mobs[L]
			for(var/image/I in imgs)
				plumbobs += I
				C.images += I
	return TRUE

/// Returns the list of selected mobs
/datum/rts_selection_manager/proc/GetSelectedMobs()
	var/list/mobs = list()
	for(var/mob/living/L in selected_mobs)
		mobs += L
	return mobs

/datum/rts_selection_manager/preview
	is_preview = TRUE


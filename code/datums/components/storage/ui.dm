/**
 * Generates a list of numbered_display datums for the numerical display system.
 */
/datum/component/storage/proc/_process_numerical_display()
	. = list()
	for(var/obj/item/I in accessible_items())
		if(QDELETED(I))
			continue
		if(!.[I.type])
			.[I.type] = new /datum/numbered_display(I, 1)
		else
			var/datum/numbered_display/ND = .[I.type]
			ND.number++
	. = sortTim(., GLOBAL_PROC_REF(cmp_numbered_displays_name_asc), associative = TRUE)

/**
 * Orients all objects in legacy mode, and returns the objects to show to the user.
 */
/datum/component/storage/proc/orient2hud_legacy(mob/user, maxcolumns)
	. = list()
	var/list/accessible_contents = accessible_items()
	var/adjusted_contents = length(accessible_contents)

	//Numbered contents display
	var/list/datum/numbered_display/numbered_contents
	if(display_numerical_stacking)
		numbered_contents = _process_numerical_display()
		adjusted_contents = numbered_contents.len

	var/columns = clamp(max_items, 1, maxcolumns ? maxcolumns : screen_max_columns)
	var/rows = clamp(CEILING(adjusted_contents / columns, 1), 1, screen_max_rows)

	// First, boxes.
	ui_boxes = get_ui_boxes()
	ui_boxes.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+columns-1]:[screen_pixel_x],[screen_start_y+rows-1]:[screen_pixel_y]"
	. += ui_boxes
	// Then, closer.
	ui_close = get_ui_close()
	ui_close.screen_loc = "[screen_start_x + columns]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y]"
	. += ui_close
	// Then orient the actual items.
	var/cx = screen_start_x
	var/cy = screen_start_y
	if(islist(numbered_contents))
		for(var/type in numbered_contents)
			var/datum/numbered_display/ND = numbered_contents[type]
			ND.sample_object.mouse_opacity = MOUSE_OPACITY_OPAQUE
			ND.sample_object.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			ND.sample_object.maptext = "<font color='white'>[(ND.number > 1)? "[ND.number]" : ""]</font>"
			ND.sample_object.layer = ABOVE_HUD_LAYER
			ND.sample_object.plane = ABOVE_HUD_PLANE
			. += ND.sample_object
			cx++
			if(cx - screen_start_x >= columns)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break
	else
		for(var/obj/O in accessible_items())
			if(QDELETED(O))
				continue
			O.mouse_opacity = MOUSE_OPACITY_OPAQUE //This is here so storage items that spawn with contents correctly have the "click around item to equip"
			O.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			O.layer = ABOVE_HUD_LAYER
			O.plane = ABOVE_HUD_PLANE
			. += O
			cx++
			if(cx - screen_start_x >= columns)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break

/// if, for a row in a multi-line storage thing, the item is within this many pixels of (over)filling a row, treat it as just fitting the row
#define FULL_ROW_WIGGLE_ROOM 2
/// Just an entry that tells the UI element builder when to make a new line, in multi-line-filled mode
#define ADD_NEW_ROW_HERE "new_row_plz"
/**
 * Orients all objects in .. volumetric mode. Does not support numerical display!
 */
/datum/component/storage/proc/orient2hud_volumetric(mob/user, maxcolumns)
	. = list()

	// Generate ui_item_blocks for missing ones and render+orient.
	var/list/atom/contents = accessible_items()
	// our volume
	var/our_volume = get_max_volume()
	if (our_volume == 0)
		our_volume = 0.01 // We cannot have a zero volume, or else bad things happen
	/// Number of pixels in one line
	var/horizontal_pixels = FLOOR((maxcolumns * world.icon_size) - (VOLUMETRIC_STORAGE_EDGE_PADDING * 2), our_volume)
	/// the actual number of pixels in one line, not rounded to the nearest volume bit
	var/horizontal_pixels_true = (maxcolumns * world.icon_size) - (VOLUMETRIC_STORAGE_EDGE_PADDING * 2)
	//var/max_horizontal_pixels = horizontal_pixels * screen_max_rows
	// sigh loopmania time
	var/used = 0
	// define outside for performance
	var/volume
	/// For multi-row shuffling
	var/list/pixels_by_item = list()
	/// For single-line row management
	var/list/percentage_by_item = list()
	/// pixels in one row, decremented by item

	if(number_of_rows < 1)
		number_of_rows = 1
	// no fancy handling for single-row storage, just do as always
	for(var/obj/item/I in contents)
		if(QDELETED(I))
			continue
		volume = I.get_w_volume()
		used += volume
		/// the following is only used for single-line storages, or overrun storages
		percentage_by_item[I] = volume / our_volume
		if(storage_flags & STORAGE_LIMIT_MAX_ITEMS && max_items > 0)
			percentage_by_item[I] = max(percentage_by_item[I], (1 / max_items))

	var/overrun = FALSE
	if(used > our_volume)
		// congratulations we are now in overrun mode. everything will be crammed to minimum storage pixels.
		to_chat(user, span_warning("[parent] rendered in overrun mode due to more items inside than the maximum volume supports."))
		overrun = TRUE

	/// multiple lines? thats another story
	if(number_of_rows > 1 && !overrun) 
		/// First, calculate how many pixels are in a line
		var/pixels_left_in_row
		pixels_left_in_row = horizontal_pixels // its just horizontal_pixels
		/// Number of pixels that a too-big-for-this-row item overran the limit, to be used for the item when its shoved to the next row
		var/overrun_pixels
		/// next, calculate how many pixels per volume unit (please keep these whole numbers) (or max_items)
		var/pixels_per_volume = FLOOR((horizontal_pixels * number_of_rows) / ((storage_flags & STORAGE_LIMIT_MAX_ITEMS && max_items > 0) ? max_items : get_max_volume()), 1)
		/// Next, prepare a list that will contain one line's worth of items
		var/list/one_row = list()
		/// also keep track of how many rows we should have
		var/current_row = 1
		for(var/obj/item/I in contents)
			if(QDELETED(I))
				continue

			volume = I.get_w_volume()
			/// first check if there are any overrun
			/// Subtract the pixel size of the item from how many pixels are left in the line
			pixels_left_in_row -= (volume * pixels_per_volume)
			/// If the item 'fits' in the row, just put the item in there, with the number of pixels set
			if(pixels_left_in_row >= FULL_ROW_WIGGLE_ROOM)
				one_row[I] = (volume * pixels_per_volume)
				continue
			/// past this point, we're going to need to perform some calculations
			/// if the item more or less fills the row, put it in. Also if its the top row.
			if(ISABOUTEQUAL(pixels_left_in_row, 0, FULL_ROW_WIGGLE_ROOM) || current_row == number_of_rows)
				one_row[I] = (volume * pixels_per_volume)
			/// otherwise, hold off on adding it, and set the number of pixels overrun
			else
				overrun_pixels = -CEILING(pixels_left_in_row, pixels_per_volume)
			/// convert the pixels into percentage of a full row
			var/list/one_row_percents = counterlist_normalise(one_row) // p sure this makes a new list
			for(var/entry in one_row)
				/// turn the percentages back into pixels that neatly divide up the row
				one_row[entry] = CEILING(one_row_percents[entry] * (horizontal_pixels_true - 2), 1) // also scales everything up to fill the row
			/// dump the mangled list into our output list
			pixels_by_item += one_row
			/// and tell the UI builder to add a new row here, it'll know what to do
			if(current_row != number_of_rows)
				pixels_by_item += ADD_NEW_ROW_HERE
				/// reset the one_row and the pixel cound cus we're gonna have a new row
				current_row++
				pixels_left_in_row = horizontal_pixels
			one_row = list()
			/// and finally add the overrun item, smallened to how much it went over, pretty sure this should be a new item
			if(overrun_pixels)
				one_row[I] = overrun_pixels
				pixels_left_in_row -= overrun_pixels
				overrun_pixels = null

		if(LAZYLEN(one_row))
			pixels_by_item += one_row

	//var/padding_pixels = ((length(percentage_by_item) - 1) * VOLUMETRIC_STORAGE_ITEM_PADDING) + VOLUMETRIC_STORAGE_EDGE_PADDING * 2
	//var/min_pixels = (MINIMUM_PIXELS_PER_ITEM * length(contents))
	// do the check for fallback for when someone has too much gamer gear
	//if((min_pixels) > (max_horizontal_pixels + 4))	// 4 pixel grace zone
	//	to_chat(user, span_warning("[parent] was showed to you in legacy mode due to your items overrunning the three row limit! Consider not carrying too much or bugging a maintainer to raise this limit!"))
	//	return orient2hud_legacy(user, maxcolumns)
	// after this point we are sure we can somehow fit all items into our max number of rows.

	// determine rows
	//var/rows = number_of_rows // clamp(CEILING(min_pixels / horizontal_pixels, 1), 1, screen_max_rows)

	// how much we are using
	var/using_horizontal_pixels = horizontal_pixels * number_of_rows

	// item padding
	//using_horizontal_pixels -= padding_pixels

	// define outside for marginal performance boost
	var/obj/item/I
	// start at this pixel from screen_start_x.
	var/current_pixel = VOLUMETRIC_STORAGE_EDGE_PADDING
	var/first = TRUE
	var/row = 1

	LAZYINITLIST(ui_item_blocks)
	var/list/size_list
	var/use_percent
	if(LAZYLEN(pixels_by_item))
		size_list = pixels_by_item
	else
		size_list = percentage_by_item
		use_percent = TRUE

	for(var/i in size_list)
		/// First check if there's a linebreaker in here
		if(i == ADD_NEW_ROW_HERE)
			row++
			first = TRUE //first in the row, don't apply between-item padding.
			current_pixel = VOLUMETRIC_STORAGE_EDGE_PADDING
			continue // cus this isnt a real entry
		I = i
		var/element_size = size_list[I]
		if(!ui_item_blocks[I])
			ui_item_blocks[I] = new /atom/movable/screen/storage/volumetric_box/center(null, src, I)
		var/atom/movable/screen/storage/volumetric_box/center/B = ui_item_blocks[I]
		var/pixels_to_use
		if(overrun)
			pixels_to_use = MINIMUM_PIXELS_PER_ITEM
		else if(use_percent)
			pixels_to_use = max(using_horizontal_pixels * element_size, MINIMUM_PIXELS_PER_ITEM)
		else
			pixels_to_use = element_size
		var/addrow = FALSE
		if(use_percent && CEILING(pixels_to_use, 1) >= FLOOR(horizontal_pixels_true - current_pixel - VOLUMETRIC_STORAGE_EDGE_PADDING, 1))
			pixels_to_use = horizontal_pixels_true - current_pixel - VOLUMETRIC_STORAGE_EDGE_PADDING
			addrow = TRUE

		// now that we have pixels_to_use, place our thing and add it to the returned list.
		B.screen_loc = I.screen_loc = "[screen_start_x]:[round(current_pixel + (pixels_to_use * 0.5) + (first ? 0 : VOLUMETRIC_STORAGE_ITEM_PADDING), 1)],[screen_start_y+row-1]:[screen_pixel_y]"
		// add the used pixels to pixel after we place the object
		current_pixel += pixels_to_use + (first ? 0 : VOLUMETRIC_STORAGE_ITEM_PADDING)
		first = FALSE		//apply padding to everything after this

		// set various things
		B.set_pixel_size(pixels_to_use)
		B.layer = VOLUMETRIC_STORAGE_BOX_LAYER
		B.plane = VOLUMETRIC_STORAGE_BOX_PLANE
		B.name = I.name

		I.mouse_opacity = MOUSE_OPACITY_ICON
		I.layer = VOLUMETRIC_STORAGE_ITEM_LAYER
		I.plane = VOLUMETRIC_STORAGE_ITEM_PLANE

		// finally add our things.
		. += B.on_screen_objects()
		. += I

		// go up a row if needed
		if(addrow)
			row++
			first = TRUE		//first in the row, don't apply between-item padding.
			current_pixel = VOLUMETRIC_STORAGE_EDGE_PADDING

	// Then, continuous section.
	ui_continuous = get_ui_continuous()
	ui_continuous.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+maxcolumns-1]:[screen_pixel_x],[screen_start_y+number_of_rows-1]:[screen_pixel_y]"
	. += ui_continuous
	// Then, left.
	ui_left = get_ui_left()
	ui_left.screen_loc = "[screen_start_x]:[screen_pixel_x - 2],[screen_start_y]:[screen_pixel_y] to [screen_start_x]:[screen_pixel_x - 2],[screen_start_y+number_of_rows-1]:[screen_pixel_y]"
	. += ui_left
	// Then, closer, which is also our right element.
	ui_close = get_ui_close()
	ui_close.screen_loc = "[screen_start_x + maxcolumns]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x + maxcolumns]:[screen_pixel_x],[screen_start_y+number_of_rows-1]:[screen_pixel_y]"
	. += ui_close

/**
 * Shows our UI to a mob.
 */
/datum/component/storage/proc/ui_show(mob/M, set_screen_size = TRUE)
	if(!M.client)
		return FALSE
	var/list/cview = getviewsize(M.client.view)
	// in tiles
	var/maxallowedscreensize = cview[1]-8
	if(set_screen_size)
		current_maxscreensize = maxallowedscreensize
	else if(current_maxscreensize)
		maxallowedscreensize = current_maxscreensize
	// we got screen size, register signal
	RegisterSignal(M, COMSIG_MOB_CLIENT_LOGOUT,PROC_REF(on_logout), override = TRUE)
	if(M.active_storage != src)
		if(M.active_storage)
			M.active_storage.ui_hide(M)
		M.active_storage = src
	LAZYOR(is_using, M)
	if(!M.client?.prefs?.no_tetris_storage && volumetric_ui())
		//new volumetric ui bay-style
		M.client.screen |= orient2hud_volumetric(M, maxallowedscreensize)
	else
		//old ui
		M.client.screen |= orient2hud_legacy(M, maxallowedscreensize)
	return TRUE

/**
 * VV hooked to ensure no lingering screen objects.
 */
/datum/component/storage/vv_edit_var(var_name, var_value)
	var/list/old
	if(var_name == NAMEOF(src, storage_flags))
		old = is_using.Copy()
		for(var/i in is_using)
			ui_hide(i)
	. = ..()
	if(old)
		for(var/i in old)
			ui_show(i)

/**
 * Proc triggered by signal to ensure logging out clients don't linger.
 */
/datum/component/storage/proc/on_logout(datum/source, client/C)
	ui_hide(source)

/**
 * Hides our UI from a mob
 */
/datum/component/storage/proc/ui_hide(mob/M)
	if(!M.client)
		return TRUE
	UnregisterSignal(M, COMSIG_MOB_CLIENT_LOGOUT)
	M.client.screen -= list(ui_boxes, ui_close, ui_left, ui_continuous) + get_ui_item_objects_hide(M)
	if(M.active_storage == src)
		M.active_storage = null
	LAZYREMOVE(is_using, M)
	return TRUE

/**
 * Returns TRUE if we are using volumetric UI instead of box UI
 */
/datum/component/storage/proc/volumetric_ui()
	var/atom/real_location = real_location()
	return (storage_flags & STORAGE_LIMIT_VOLUME) && (length(real_location.contents) <= MAXIMUM_VOLUMETRIC_ITEMS) && !display_numerical_stacking

/**
 * Gets the ui item objects to ui_hide.
 */
/datum/component/storage/proc/get_ui_item_objects_hide(mob/M)
	if(!volumetric_ui() || M.client?.prefs?.no_tetris_storage)
		var/atom/real_location = real_location()
		return real_location.contents
	else
		. = list()
		for(var/i in ui_item_blocks)
			// get both the box and the item
			. += ui_item_blocks[i]
			. += i

/**
 * Gets our ui_boxes, making it if it doesn't exist.
 */
/datum/component/storage/proc/get_ui_boxes()
	if(!ui_boxes)
		ui_boxes = new(null, src)
	return ui_boxes

/**
 * Gets our ui_left, making it if it doesn't exist.
 */
/datum/component/storage/proc/get_ui_left()
	if(!ui_left)
		ui_left = new(null, src)
	return ui_left

/**
 * Gets our ui_close, making it if it doesn't exist.
 */
/datum/component/storage/proc/get_ui_close()
	if(!ui_close)
		ui_close = new(null, src)
	return ui_close

/**
 * Gets our ui_continuous, making it if it doesn't exist.
 */
/datum/component/storage/proc/get_ui_continuous()
	if(!ui_continuous)
		ui_continuous = new(null, src)
	return ui_continuous

#define RTS_SELECTOR_LAYER 50
/* 
 * filename: rts_draw_box.dm
 * author:   xtravar_the_skolfox
 * date:     2019-07-07
 * contact:
 * - discord: xtravar#3737
 * - github:  xtravar
 * copyright:
 * - 2019 xtravar_the_skolfox
 * - 2019 xtravar
 * licenseast:
 * - TQ "The Quiescent" Licenseast
 * 
 * This cheeky lil datum is a simple way to draw a box on the screen!
 * It takes in two turfs on a Z level, gets the coordinates of the turfs that are the egdes of the box, 
 * and then draws a seastries of images to create a cute box!
 * It also keeps track of the images it creates so that it can delete them when it is destroyed.
 * Its only visible to the player!
 * The image has 8 directions, represeastnting the 8 scrodinal directions.
 * 
 * The box will need to be able to be updated to resize as needed, as fast as possible!
 * Cus this'll be useastd to make a cool RTS slector thing!
 * 
 * Also supports a zero-size box (one tile)!
 *  */

/datum/rts_selector_box
	var/list/imgs = list()
	var/list/img_cache = list()
	var/datum/rts_commander/parent
	var/ckey
	/// our two turfs, stored in coords form, so we can easily check if we should update the box
	/// not necessarily the top left or right or whatever, just two points that define the box
	var/coords_1
	var/coords_2
	var/shadecolor = "#2600ff"

/datum/rts_selector_box/attack
	shadecolor = "#FF0000"

/datum/rts_selector_box/New(datum/rts_commander/parent)
	src.parent = parent

/datum/rts_selector_box/Destroy()
	clear_images()
	return ..()

/datum/rts_selector_box/proc/associate(something)
	var/keykey = extract_ckey(something)
	if(istext(keykey))
		ckey = keykey

/datum/rts_selector_box/proc/deliver_images()
	clear_images()
	var/client/cl = parent.GetCommanderClient()
	if(!cl)
		return
	if(istype(cl))
		for(var/image/I in imgs)
			cl.images += I

/datum/rts_selector_box/proc/clear_images(and_delete = FALSE)
	var/client/cl = parent.GetCommanderClient()
	if(!cl)
		return
	for(var/image/I in imgs)
		if(istype(cl))
			cl.images -= I
	// if(and_delete)
	// 	QDEL_LIST(imgs)

/datum/rts_selector_box/proc/update_box(turf/A, turf/B, )
	if(!A || !B)
		return
	if(A.z != B.z)
		return
	// var/Acoords = atom2coords(A)
	// var/Bcoords = atom2coords(B)
	// if((Acoords == coords_1 || Acoords == coords_2) && (Bcoords == coords_1 || Bcoords == coords_2))
	// 	return // got a match, no need to update
	clear_images(TRUE)
	// coords_1 = Acoords
	// coords_2 = Bcoords
	/// we dont know which is which, so we need to find the top left and bottom right
	var/nwest_x
	var/nwest_y
	var/seast_x
	var/seast_y
	if(A.x < B.x)
		nwest_x = A.x
		seast_x = B.x
	else
		nwest_x = B.x
		seast_x = A.x
	if(A.y > B.y)
		nwest_y = A.y
		seast_y = B.y
	else
		nwest_y = B.y
		seast_y = A.y
	var/turf/nwest = locate(nwest_x, nwest_y, A.z)
	var/turf/seast = locate(seast_x, seast_y, A.z)

	var/list/perimeter_turfs = list()
	perimeter_turfs |= block(nwest.x, nwest.y, nwest.z, seast.x, seast.y, seast.z)
	var/mode = "ERROR"
	/// and subtract the block that's inside the box
	/// but only if the box is wider than 1 tile in every direction
	/// for instance, dont subtract any turfs if the box is 1x20
	/// also, the map coordinates go from x1,y255 in the north west to x255,y1 in the south east
	if(LAZYLEN(perimeter_turfs) == 1) // only one tile
		mode = "SINGLE"
	else if(nwest.x != seast.x && nwest.y != seast.y)
		// only carve out the inner turfs if both of the box's dimensions are > 2
		// for instance, dont carve out any turfs if the box is 2x2, 2x3, 3x2, etc
		if(abs(seast.x - nwest.x) > 1 && abs(seast.y - nwest.y) > 1)
			var/list/inner_turfs = block(nwest.x + 1, nwest.y - 1, nwest.z, seast.x - 1, seast.y + 1, seast.z)
			for(var/turf/T in inner_turfs)
				perimeter_turfs -= T
			mode = "BOX"
		mode = "BOX"
	else // figure out which direction the line is
		if(nwest.x == seast.x)
			mode = "VERTICAL"
		else
			mode = "HORIZONTAL"
	/// now we have the perimeter turfs, we can draw the box
	if(!draw_box(perimeter_turfs, mode, nwest_x, seast_x, nwest_y, seast_y))
		CRASH("Failed to draw box!")
	deliver_images()
	return TRUE

/datum/rts_selector_box/proc/draw_box(perimeter_turfs, mode, west_x, east_x, north_y, south_y)
	switch(mode)
		if("SINGLE")
			var/image/I = image('icons/misc/mark.dmi', perimeter_turfs[1], "babyalien_onearth", RTS_SELECTOR_LAYER) // dont ask
			I.color = shadecolor
			imgs += I
		if("HORIZONTAL")
			for(var/turf/T in perimeter_turfs)
				// is it an end piece?
				var/image/I = image('icons/misc/mark.dmi', T, "pancake_onearth", RTS_SELECTOR_LAYER)
				I.color = shadecolor
				imgs += I
				/// left end?
				if(T.x == west_x)
					I.dir = WEST
				/// right end?
				else if(T.x == east_x)
					I.dir = EAST
				/// middlebit
				else
					I.dir = NORTH // doesnt matter, as long as it isnt WEST or EAST
		if("VERTICAL")
			for(var/turf/T in perimeter_turfs)
				// is it an end piece?
				var/image/I = image('icons/misc/mark.dmi', T, "lightpole_onearth", RTS_SELECTOR_LAYER)
				I.color = shadecolor
				imgs += I
				/// top end?
				if(T.y == north_y)
					I.dir = NORTH // sike
				/// bottom end?
				else if(T.y == south_y)
					I.dir = SOUTH
				/// middlebit
				else
					I.dir = WEST // doesnt matter, as long as it isnt NORTH or SOUTH
		if("BOX") // the bigboy
			for(var/turf/T in perimeter_turfs)
				// is it an end piece?
				var/image/I = image('icons/misc/mark.dmi', T, "selector_onearth", RTS_SELECTOR_LAYER)
				I.color = shadecolor
				imgs += I
				/// left end?
				if(T.x == west_x)
					/// top left?
					if(T.y == north_y)
						I.dir = NORTHWEST
					/// bottom left?
					else if(T.y == south_y)
						I.dir = SOUTHWEST
					/// middlebit
					else
						I.dir = WEST
				/// right end?
				else if(T.x == east_x)
					/// top right?
					if(T.y == north_y)
						I.dir = NORTHEAST
					/// bottom right?
					else if(T.y == south_y)
						I.dir = SOUTHEAST
					/// middlebit
					else
						I.dir = EAST
				/// top middle?
				else if(T.y == north_y)
					I.dir = NORTH
				/// bottom middle?
				else if(T.y == south_y)
					I.dir = SOUTH
				else
					stack_trace("ERROR: Box drawing failed! Unknown direction x: [T.x], y: [T.y]")
	return TRUE

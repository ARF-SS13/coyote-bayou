/obj/item/binoculars
	name = "binoculars"
	desc = "Used for long-distance surveillance."
	inhand_icon_state = "binoculars"
	icon_state = "binoculars"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	slot_flags = INV_SLOTBIT_BELT
	w_class = WEIGHT_CLASS_SMALL
	var/mob/listeningTo
	var/zoom_out_amt = 6
	var/zoom_amt = 10

/obj/item/binoculars/wield(mob/living/user)
	. = ..()
	RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE,PROC_REF(rotate))
	listeningTo = user
	user.visible_message(span_notice("[user] holds [src] up to [user.p_their()] eyes."), span_notice("You hold [src] up to your eyes."))
	inhand_icon_state = "binoculars_wielded"
	user.regenerate_icons()
	if(!user?.client)
		return
	
	var/client/C = user.client
	var/_x = 0
	var/_y = 0
	var/turf/T = get_turf(user)
	if(is_above_level(T.z)) //higher elevation equals higher view range
		src.zoom_out_amt = 19
		src.zoom_amt = 10
		to_chat(user,"You see the horizon more clearly from this elevation.")
	else if(!is_above_level(T.z))
		src.zoom_out_amt = 6
		src.zoom_amt = 10

	switch(user.dir)
		if(NORTH)
			_y = zoom_amt
		if(EAST)
			_x = zoom_amt
		if(SOUTH)
			_y = -zoom_amt
		if(WEST)
			_x = -zoom_amt
	C.change_view(world.view + zoom_out_amt)
	C.pixel_x = world.icon_size*_x
	C.pixel_y = world.icon_size*_y

/obj/item/binoculars/proc/on_unwield(obj/item/source, mob/user)
	unwield(user)

/obj/item/binoculars/proc/rotate(mob/living/user, old_dir, direction = FALSE)
	var/_x = 0
	var/_y = 0
	switch(direction)
		if(NORTH)
			_y = zoom_amt
		if(EAST)
			_x = zoom_amt
		if(SOUTH)
			_y = -zoom_amt
		if(WEST)
			_x = -zoom_amt
	user.client.change_view(world.view + zoom_out_amt)
	user.client.pixel_x = world.icon_size*_x
	user.client.pixel_y = world.icon_size*_y

/obj/item/binoculars/unwield(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		listeningTo = null
	user.visible_message(span_notice("[user] lowers [src]."), span_notice("You lower [src]."))
	inhand_icon_state = "binoculars"
	user.regenerate_icons()
	if(user && user.client)
		user.regenerate_icons()
		var/client/C = user.client
		C.change_view(CONFIG_GET(string/default_view))
		user.client.pixel_x = 0
		user.client.pixel_y = 0

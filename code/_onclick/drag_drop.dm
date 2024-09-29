/*
	MouseDrop:

	Called on the atom you're dragging.  In a lot of circumstances we want to use the
	receiving object instead, so that's the default action.  This allows you to drag
	almost anything into a trash can.
*/

GLOBAL_VAR_INIT(use_experimental_clickdrag_thing, TRUE)

/atom/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	if(!usr || !over)
		return
	if(SEND_SIGNAL(src, COMSIG_MOUSEDROP_ONTO, over, usr) & COMPONENT_NO_MOUSEDROP)	//Whatever is receiving will verify themselves for adjacency.
		return
	if(over == src)
		return usr.client.Click(src, src_location, src_control, params)
	if(GLOB.use_experimental_clickdrag_thing)
		var/is_mob_in_harm_intent // "harm" intent
		if(ismob(usr))
			var/mob/clicker = usr
			if(clicker.a_intent == INTENT_HARM)
				is_mob_in_harm_intent = TRUE
			else
				var/obj/item/h = clicker.get_active_held_item()
				if(h && h.force_harmclick)
					is_mob_in_harm_intent = TRUE
		if(is_mob_in_harm_intent) // in harm intent, disable clickdragging and try to click on whatever your mouse is over when you let up a click
			if(over == usr && src != usr) // If you clickdrag something out of range to yourself, click what you originaly clicked
				return usr.client.Click(src, over_location, src_control, params)
			return usr.client.Click(over, over_location, src_control, params)
	if(!Adjacent(usr) || !over.Adjacent(usr))
		return // should stop you from dragging through windows

	over.MouseDrop_T(src,usr)
	return

// receive a mousedrop
/atom/proc/MouseDrop_T(atom/dropping, mob/user)
	SEND_SIGNAL(src, COMSIG_MOUSEDROPPED_ONTO, dropping, user)
	return


/client/MouseDown(object, location, control, params)
	if (mouse_down_icon)
		mouse_pointer_icon = mouse_down_icon
	if(mob?.check_mousedown_intercept(params,object,location,control))
		return
	var/delay = mob.CanMobAutoclick(object, location, params)
	if(delay)
		selected_target[1] = object
		selected_target[2] = params
		while(selected_target[1])
			Click(selected_target[1], location, control, selected_target[2], TRUE)
			sleep(delay)
	active_mousedown_item = mob.canMobMousedown(object, location, params)
	if(active_mousedown_item)
		active_mousedown_item.onMouseDown(object, location, params, mob)

/client/MouseUp(object, location, control, params)
	if (mouse_up_icon)
		mouse_pointer_icon = mouse_up_icon
	if(mob?.check_mouseup_intercept(params,object,location,control))
		return
	selected_target[1] = null
	if(active_mousedown_item)
		active_mousedown_item.onMouseUp(object, location, params, mob)
		active_mousedown_item = null

/mob/proc/CanMobAutoclick(object, location, params)

/mob/living/carbon/CanMobAutoclick(atom/object, location, params)
	if(!object.IsAutoclickable())
		return
	var/obj/item/h = get_active_held_item()
	if(h)
		. = h.CanItemAutoclick(object, location, params)

/mob/proc/canMobMousedown(atom/object, location, params)

/mob/living/carbon/canMobMousedown(atom/object, location, params)
	var/obj/item/H = get_active_held_item()
	if(H)
		. = H.canItemMouseDown(object, location, params)

/obj/item/proc/CanItemAutoclick(object, location, params)

/obj/item/proc/canItemMouseDown(object, location, params)
	if(canMouseDown)
		return src

/obj/item/proc/onMouseDown(object, location, params, mob)
	return

/obj/item/proc/onMouseUp(object, location, params, mob)
	return

/atom/proc/IsAutoclickable()
	. = 1

/atom/movable/screen/IsAutoclickable()
	. = 0

/atom/movable/screen/click_catcher/IsAutoclickable()
	. = 1

/client/MouseMove(object,location,control,params)
	mouseParams = params
	mouseObject = object
	mouseControlObject = control
	if(mob)
		SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_MOUSEMOVE, object, location, control, params)
	..()

/client/MouseDrag(src_object,atom/over_object,src_location,over_location,src_control,over_control,params)
	if(mob?.check_mousedrag_intercept(params,src_object,over_object,src_location,over_location,src_control,over_control))
		return
	var/list/L = params2list(params)
	if (L["middle"])
		if (src_object && src_location != over_location)
			middragtime = world.time
			middragatom = src_object
		else
			middragtime = 0
			middragatom = null
	mouseParams = params
	mouseObject = over_object
	mouseControlObject = over_control
	if(selected_target[1] && over_object && over_object.IsAutoclickable())
		selected_target[1] = over_object
		selected_target[2] = params
	if(active_mousedown_item)
		active_mousedown_item.onMouseDrag(src_object, over_object, src_location, over_location, params, mob)


/obj/item/proc/onMouseDrag(src_object, over_object, src_location, over_location, params, mob)
	return

/client/MouseDrop(src_object, over_object, src_location, over_location, src_control, over_control, params)
	if (middragatom == src_object)
		middragtime = 0
		middragatom = null
	..()

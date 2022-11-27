//Allows for a dynamic cursor, simulating accuracy. If you want to resprite this, go ahead.

/obj/item/gun/equipped(mob/living/H)
	. = ..()
	if(H.client && !CHECK_BITFIELD(H.client.prefs.cb_toggles, AIM_CURSOR_ON))
		H.remove_cursor()
		return
	if(H.get_active_held_item() == src && !safety)
		H.update_cursor(src)
	else
		H.remove_cursor()

/obj/item/gun/afterattack(obj/target, mob/living/user, flag)
	. = ..()
	if(user.get_active_held_item() != src)
		user.remove_cursor()

/obj/item/gun/dropped(mob/living/user)
	user.remove_cursor()
	. = ..()

/obj/item/gun/afterattack(atom/A, mob/living/user, adjacent, params)
	check_safety_cursor(user)
	. = ..()

/obj/item/gun/Destroy()
	if(ismob(loc))
		var/mob/living/L = loc
		L.remove_cursor()
	. = ..()

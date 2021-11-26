// ID locked Fallout doors, unpowered being as the name says, simple mechanical doors.

/obj/machinery/door/unpowered
	icon = 'icons/fallout/structures/doors.dmi'
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 25, "bio" = 100, "rad" = 100, "fire" = 80, "acid" = 70)
	autoclose = TRUE // Difficulty: Monkey to reduce amount of secure doors left open.
	max_integrity = 230
	obj_integrity = 230
	req_one_access_txt = null // Add the channel for the ID you want to lock this door to, check defines.

/obj/machinery/door/unpowered/Bumped(atom/movable/AM)
	if(src.locked)
		return
	..()
	return

/obj/machinery/door/unpowered/attackby(obj/item/I, mob/user, params)
	if(locked)
		return
	else
		return ..()


//Can be ID locked, but NOT padlocked. Only use if you must use ID lock, a sort of simulated key and lock system for semi-public areas.
/obj/machinery/door/unpowered/securedoor
	name = "secure door"
	desc = "Door with a built-in lock. Can't be padlocked."
	icon_state = "secure"
	assemblytype = /obj/item/stack/sheet/mineral/wood/five
	opacity = TRUE
	density = TRUE
	explosion_block = TRUE

/obj/machinery/door/unpowered/securedoor/update_icon()
	if(density)
		icon_state = "secure"
	else
		icon_state = "secureopen"

/obj/machinery/door/unpowered/securedoor/do_animate(animation)
	switch(animation)
		if("opening")
			playsound(src,'sound/machines/door_open.ogg',40,1)
			flick("secure_opening", src)
		if("closing")
			playsound(src,'sound/machines/door_close.ogg',40,1)
			flick("secure_closing", src)


// ID lock it, so guards etc can access, but those outside faction cannot.
/obj/machinery/door/unpowered/celldoor
	name = "cell door"
	desc = "Celldoor with a built-in lock. Can't be padlocked."
	icon_state = "cell" 
	max_integrity = 300
	obj_integrity = 300
	assemblytype = /obj/item/stack/rods
	opacity = FALSE
	density = TRUE
	explosion_block = FALSE
	pass_flags = LETPASSTHROW 
	proj_pass_rate = 95

/obj/machinery/door/unpowered/celldoor/update_icon()
	if(density)
		icon_state = "cell"
	else
		icon_state = "cellopen"

/obj/machinery/door/unpowered/celldoor/do_animate(animation)
	switch(animation)
		if("opening")
			playsound(src,'sound/f13machines/doorchainlink_open.ogg',40,1)
			flick("cell_opening", src)
		if("closing")
			playsound(src,'sound/f13machines/doorchainlink_close.ogg',40,1)
			flick("cell_closing", src)

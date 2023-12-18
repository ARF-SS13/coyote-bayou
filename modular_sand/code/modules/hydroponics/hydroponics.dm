/obj/machinery/hydroponics/proc/harvest_dead(mob/user)
	dead = FALSE
	if(user)
		to_chat(user, span_notice("You remove the dead plant from [src]."))
	qdel(myseed)
	myseed = null
	update_icon()
	TRAY_NAME_UPDATE

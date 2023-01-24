#define UPSTATE_ALLGOOD		(1<<7)

#define APC_NOT_CHARGING 0
#define APC_CHARGING 1
#define APC_FULLY_CHARGED 2


/obj/machinery/power/apc/fusebox
	name = "fusebox"
	icon_state = "fusebox"
	cell_type = /obj/item/stock_parts/cell/potato

//Icon
/obj/machinery/power/apc/fusebox/update_icon()
	var/update = check_updates() 		//returns 0 if no need to update icons.
						// 1 if we need to update the icon_state
						// 2 if we need to update the overlays
	if(!update)
		icon_update_needed = FALSE
		return

	if(update & 1) // Updating the icon state
		if(update_state & UPSTATE_ALLGOOD)
			icon_state = "fusebox"
		else
			icon_state = "fusebox-tripped"

	if(update_state & UPSTATE_ALLGOOD)
		switch(charging)
			if(APC_NOT_CHARGING)
				icon_state = "fusebox-tripped"
			if(APC_CHARGING)
				icon_state = "fusebox"
			if(APC_FULLY_CHARGED)
				icon_state = "fusebox"

/obj/machinery/power/apc/fusebox/north //Pixel offsets get overwritten on New()
	dir = NORTH
	pixel_y = 23

/obj/machinery/power/apc/fusebox/south
	dir = SOUTH
	pixel_y = -23

/obj/machinery/power/apc/fusebox/east
	dir = EAST
	pixel_x = 24

/obj/machinery/power/apc/fusebox/west
	dir = WEST
	pixel_x = -25

/obj/machinery/power/apc/fusebox/screwdriver_act(mob/living/user, obj/item/W)
	return FALSE;

/obj/machinery/power/apc/fusebox/crowbar_act(mob/user, obj/item/W)
	new /obj/item/stack/sheet/metal(loc)
	qdel(src)
	return TRUE


#undef APC_NOT_CHARGING
#undef APC_CHARGING
#undef APC_FULLY_CHARGED
#undef UPSTATE_ALLGOOD

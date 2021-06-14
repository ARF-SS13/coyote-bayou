//Fallout 13 ambush bus directory

/obj/structure/closet/bus
	name = "\proper ancient City Liner bus"
	desc = "A derelict bus that belonged to a City Liner network.<br>Despite all the decades it has spent out in the open, the exterior looks more or less intact."
	icon_state = "bus"
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	icon = 'icons/fallout/vehicles/bus.dmi'
	bound_width = 224
	bound_height = 96
	density = TRUE
	appearance_flags = 0
	icon_door_override = TRUE
	obj_integrity = 200
	max_integrity = 200
	integrity_failure = 50

/obj/structure/closet/bus/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wrench))
		return
	..()

/obj/structure/closet/proc/can_open(mob/living/user)
	return FALSE

/obj/structure/closet/bus/update_icon()
	cut_overlays()
	var/image/I = image(icon,src,"bus_overlay",LOW_OBJ_LAYER)
	add_overlay(I)
	if(!broken)
		if(!opened)
			I = image(icon,src,"bus_closed",CLOSED_DOOR_LAYER)
			add_overlay(I)
		else
			I = image(icon,src,"bus_open",ABOVE_MOB_LAYER)
			add_overlay(I)


/obj/structure/closet/bus/bust_open()
	..()
	new /obj/structure/bus_door(locate(min(x + 3, world.maxx), y,z))
	resistance_flags |= INDESTRUCTIBLE
	playsound(src, 'sound/effects/meteorimpact.ogg', rand(50,100), TRUE)

/obj/structure/bus_door
	name = "broken bus door"
	icon = 'icons/fallout/trash.dmi'
	icon_state = "bus_door"
	anchored = 1
	density = 0
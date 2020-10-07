//Fallout 13 decorative derelict vehicles directory

/obj/structure/car
	name = "pre-War automobile"
	desc = "A rusty pre-War automobile carcass.<br>This car is damaged beyond repair."
	icon = 'icons/fallout/vehicles/medium_vehicles.dmi'
	icon_state = "derelict"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE
	var/uses_left = 4
	var/inuse = FALSE
	var/S1
	var/S2
	var/S3
	var/S4

/obj/structure/car/New()
	..()

	dir = pick("1","2","4","5","6","8","9","10")

	var/atom/movable/S = new (locate(x+1,y,z))
	S4 = S
	//Just fuck me sideways right? We have duplicate movables because of this. -Harcourt
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

// Because some nitwit thought it would be a good idea to generate the movable atom on each subtype now I have to repeat qdel unnecessarily. Thanks. - Harcourt
/obj/structure/car/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weldingtool))
		if (inuse)
			return
		if(!I.tool_start_check(user, amount=0))
			return
		user.visible_message("[user] starts to disassemble the wreck.</span>")
		inuse = TRUE
		if(I.use_tool(src, user, 300, volume=100))
			user.visible_message("[user] disassembles the wreck.</span>")
			inuse = FALSE
			new /obj/item/stack/sheet/metal/five/(get_turf(user))
			if (uses_left == 0)
				qdel(src)
				qdel(S1)
				qdel(S2)
				qdel(S3)
				qdel(S4)
				return
			else
				uses_left--
				return
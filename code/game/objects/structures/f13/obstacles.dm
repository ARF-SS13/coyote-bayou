//Structures which are limpid but impassable, to serve more of a decorative and tactical purposes.

/*
//Transparent ruins - more of a decal than structure, to function as decoration over the turf so that you can see base turf under it.
/obj/structure/ruins
	name = "ruins"
	desc = "Decaying remains of human civilization.<br>On the edge of falling apart, but still standing somehow."
	icon = 'icons/turf/walls.dmi'
	icon_state = "ruinswindowdestroyed"
	density = 1
	anchored = 1
*/


/* Commented out due to unknown errors
//Metal fence
/obj/structure/fence/fencenormal
	name = "metal fence"
	desc = "You see nothing out of the ordinary." //It's an original description from Fallout.
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "normal_fence"
	density = 1
	anchored = 1

/obj/structure/fence/fencenormal/New()
	layer = 4.2

/obj/structure/fence/fencenormal/CanPass(atom/movable/mover, turf/target, height=0)
	if (!density)
		return 1
	if (dir!=SOUTH)
		return 0
	if(istype(mover) && mover.checkpass(PASSGRILLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/fence/fencenormal/CheckExit(atom/movable/O as mob|obj, target)
	if (!density)
		return 1
	if (dir!=SOUTH)
		return 0
	if(istype(O) && O.checkpass(PASSGRILLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/fence/fencenormal/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/wirecutters))
		if(do_after(user,50, target = src))
			playsound(loc, 'sound/items/Wirecutter.ogg', 100, 1)
			user.visible_message("<span class='notice'>[user] cuts a hole in the fence.</span>", \
								 "<span class='notice'>You cut a hole in the fence.</span>")
			density = 0
			icon_state = "cut_fence"
			desc = "You have no idea what could make that hole..."


/obj/structure/fence/fencecorner
	name = "metal fence"
	desc = "It's still pretty sturdy.<br>You see nothing out of the ordinary."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "fence_corner"
	density = 1
	anchored = 1

/obj/structure/fence/fencecorner/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/wirecutters))
		user << "<span class='warning'>Even if I cut through here, I'll get hurt if I try to get through.<br>Let's find some better options.</span>"

/obj/structure/fence/fenceintersectmiddle
	name = "metal fence"
	desc = "Intersection of the fence.<br>You see nothing out of the ordinary."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "fence_intersect_middle"
	density = 1
	anchored = 1

/obj/structure/fence/fenceintersectmiddle/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/wirecutters))
		user << "<span class='warning'>It's not the best place to cut the fence.<br>I got to find better options.</span>"

/obj/structure/fence/fenceintersectbottom
	name = "metal fence"
	desc = "Intersection of the fence.<br>You see nothing out of the ordinary."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "fence_intersect_bottom"
	density = 1
	anchored = 1

/obj/structure/fence/fenceintersectbottom/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/wirecutters))
		user << "<span class='warning'>The fence here is too strong - it wouldn't cut!<br>Maybe there's a better spot to try again.</span>"

/obj/structure/fence/fencecornerintersect
	name = "metal fence"
	desc = "Intersection of the fence.<br>You see nothing out of the ordinary."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "fence_intersect_corner"
	density = 1
	anchored = 1

/obj/structure/fence/fencecornerintersect/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/wirecutters))
		user << "<span class='warning'><br>The fence here is too strong - it wouldn't cut!</br>Let's find some better options now.</span>"

/obj/structure/fence/fencedoor
	name = "metal fence door"
	desc = "The hinges are a bit rusty.<br>Who cares, it's just a door anyway."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "fence_door_front_closed"
	density = 1
	anchored = 1
	var/open_sound = 'sound/f13machines/doorchainlink_open.ogg'
	var/close_sound = 'sound/f13machines/doorchainlink_close.ogg'

/obj/structure/fence/fencedoor/New()
	layer = 4.2

/obj/structure/fence/fencedoor/attackby(obj/item/weapon/I, mob/living/user, params)
	if (density)
		icon_state = "fence_door_front_open"
		playsound(src.loc, open_sound, 40, 0, 0)
	else
		icon_state = "fence_door_front_closed"
		playsound(src.loc, close_sound, 40, 0, 0)
	density = !density

/obj/structure/fence/fencedoor/attack_hand(mob/user)
	if (density)
		icon_state = "fence_door_front_open"
		playsound(src.loc, open_sound, 40, 0, 0)
	else
		icon_state = "fence_door_front_closed"
		playsound(src.loc, close_sound, 40, 0, 0)
	density = !density

/obj/structure/fence/fencedoor/attack_tk(mob/user)
	if (density)
		icon_state = "fence_door_front_open"
		playsound(src.loc, open_sound, 40, 0, 0)
	else
		icon_state = "fence_door_front_closed"
		playsound(src.loc, close_sound, 40, 0, 0)
	density = !density

/obj/structure/fence/fencedoor/CanPass(atom/movable/mover, turf/target, height=0)
	if (!density)
		return 1
	if(istype(mover) && mover.checkpass(PASSGRILLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/fence/fencedoor/CheckExit(atom/movable/O as mob|obj, target)
	if (!density)
		return 1
	if(istype(O) && O.checkpass(PASSGRILLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0

	return 1

/obj/structure/fence/fencedoorside
	name = "metal fence door"
	desc = "It opens and closes."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "fence_door_side_closed"
	density = 1
	anchored = 1
	var/open_sound = 'sound/f13machines/doorchainlink_open.ogg'
	var/close_sound = 'sound/f13machines/doorchainlink_close.ogg'

/obj/structure/fence/fencedoorside/attackby(obj/item/weapon/I, mob/living/user, params)
	if (density)
		icon_state = "fence_door_side_open"
		playsound(src.loc, open_sound, 40, 0, 0)
	else
		icon_state = "fence_door_side_closed"
		playsound(src.loc, close_sound, 40, 0, 0)
	density = !density

/obj/structure/fence/fencedoorside/attack_hand(mob/user)
	if (density)
		icon_state = "fence_door_side_open"
		playsound(src.loc, open_sound, 40, 0, 0)
	else
		icon_state = "fence_door_side_closed"
		playsound(src.loc, close_sound, 40, 0, 0)
	density = !density

/obj/structure/fence/fencedoorside/attack_tk(mob/user)
	if (density)
		icon_state = "fence_door_side_open"
		playsound(src.loc, open_sound, 40, 0, 0)
	else
		icon_state = "fence_door_side_closed"
		playsound(src.loc, close_sound, 40, 0, 0)
	density = !density

/obj/structure/fence/fencedoorside/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/structure/fence/fencedoorside/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

//Industrial handrails

//Blue
/obj/structure/handrail/b_central
	name = "handrail"
	desc = "Heavy-duty metal handrail. It's painted blue.<br>You shall not pass!"
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "b_handrail"
	density = 1
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/b_central/New()
	layer = 4.2

/obj/structure/handrail/b_central/CanPass(atom/movable/mover, turf/target, height=0)
	if (dir!=SOUTH)
		return 0
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/b_central/CheckExit(atom/movable/O as mob|obj, target)
	if (dir!=SOUTH)
		return 0
	if(istype(O) && O.checkpass(PASSTABLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/b_central/CanPass(atom/movable/mover, turf/target)
    if(istype(mover) && (mover.pass_flags & PASSGLASS))
        return 1
    if(get_dir(loc, target) == dir)
        return !density
    if(istype(mover, /obj/structure/handrail/b_central))
        var/obj/structure/window/W = mover
        if(!valid_window_location(loc, W.ini_dir))
            return FALSE
    else if(istype(mover, /obj/structure/windoor_assembly))
        var/obj/structure/windoor_assembly/W = mover
        if(!valid_window_location(loc, W.ini_dir))
            return FALSE
    else if(istype(mover, /obj/machinery/door/window) && !valid_window_location(loc, mover.dir))
        return FALSE
    return 1

/obj/structure/handrail/b_intersect
	name = "handrails"
	desc = "Heavy-duty metal handrails. They are painted blue."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "b_handrail_intersect"
	density = 1
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/b_intersect/New()
	layer = 4.2

/obj/structure/handrail/b_intersect/CanPass(atom/movable/mover, turf/target, height=0)
	if (dir!=SOUTH)
		return 0
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/b_intersect/CheckExit(atom/movable/O as mob|obj, target)
	if (dir!=SOUTH)
		return 0
	if(istype(O) && O.checkpass(PASSTABLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/b_end
	name = "handrail end"
	desc = "Heavy-duty metal handrail ends here.<br>You can pass now!"
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "b_handrail_end"
	density = 0
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/b_end/New()
	if (dir>2)
		layer = 4.2

//Yellow
/obj/structure/handrail/y_central
	name = "handrail"
	desc = "Heavy-duty metal handrail. It's painted yellow.<br>You shall not pass!"
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "y_handrail"
	density = 1
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/y_central/New()
	layer = 4.2

/obj/structure/handrail/y_central/CanPass(atom/movable/mover, turf/target, height=0)
	if (dir!=SOUTH)
		return 0
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/y_central/CheckExit(atom/movable/O as mob|obj, target)
	if (dir!=SOUTH)
		return 0
	if(istype(O) && O.checkpass(PASSTABLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/y_intersect
	name = "handrails"
	desc = "Heavy-duty metal handrails. They are painted yellow."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "y_handrail_intersect"
	density = 1
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/y_intersect/New()
	layer = 4.2

/obj/structure/handrail/y_intersect/CanPass(atom/movable/mover, turf/target, height=0)
	if (dir!=SOUTH)
		return 0
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/y_intersect/CheckExit(atom/movable/O as mob|obj, target)
	if (dir!=SOUTH)
		return 0
	if(istype(O) && O.checkpass(PASSTABLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/y_end
	name = "handrail end"
	desc = "Heavy-duty metal handrail ends here.<br>You can pass now!"
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "y_handrail_end"
	density = 0
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/y_end/New()
	if (dir>2)
		layer = 4.2 */

//Green
/obj/structure/handrail/g_central
	name = "handrail"
	desc = "Old, rusted metal handrails. The green paint is chipping off in spots."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "g_handrail"
	density = 0
	anchored = 1
	pixel_y = 0

/obj/structure/handrail/g_central/New()
	layer = 4.2

/obj/structure/handrail/g_central/Initialize() //window hack to make collision work
    . = ..()
    switch(dir)
        if(NORTH)
            pixel_y = 23
        if(SOUTH)
            pixel_y = -16
        if(EAST)
            pixel_x = 20
        if(WEST)
            pixel_x = -20
    var/obj/structure/window/W = new /obj/structure/window(get_turf(src))
    W.alpha = 0
    W.anchored = 1
    W.resistance_flags = INDESTRUCTIBLE
    W.dir = src.dir

/* obsoleted by the window hack
/obj/structure/handrail/g_central/CanPass(atom/movable/mover, turf/target, height=0)
	if (dir!=SOUTH)
		return 0
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/g_central/CheckExit(atom/movable/O as mob|obj, target)
	if (dir!=SOUTH)
		return 0
	if(istype(O) && O.checkpass(PASSTABLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0
*/

/* g_intersect is not sprited yet
/obj/structure/handrail/g_intersect
	name = "handrails"
	desc = "Old, rusted metal handrails. The green paint is chipping off in spots."
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "y_handrail_intersect"
	density = 0
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/g_intersect/New()
	layer = 4.2

/obj/structure/handrail/g_intersect/CanPass(atom/movable/mover, turf/target, height=0)
	if (dir!=SOUTH)
		return 0
	if(istype(mover) && mover.checkpass(PASSTABLE))
		return 1
	if(get_dir(loc, target) != SOUTH)
		return 1
	else
		return 0

/obj/structure/handrail/y_intersect/CheckExit(atom/movable/O as mob|obj, target)
	if (dir!=SOUTH)
		return 0
	if(istype(O) && O.checkpass(PASSTABLE))
		return 1
	if(get_dir(O.loc, target) != SOUTH)
		return 1
	else
		return 0
*/

/obj/structure/handrail/g_end
	name = "handrail end"
	desc = "Heavy-duty metal handrail ends here.<br>You can pass now!"
	icon = 'icons/obj/obstacles.dmi'
	icon_state = "g_handrail_end"
	density = 0
	anchored = 1
	pixel_y = -9

/obj/structure/handrail/g_end/New()
	if (dir>2)
		layer = 4.2

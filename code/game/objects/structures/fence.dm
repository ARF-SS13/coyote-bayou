//Chain link fences
//Sprites derivative from unweathered VG originals.


#define CUT_TIME 100
#define CLIMB_TIME 150

#define NO_HOLE 0 //section is intact
#define MEDIUM_HOLE 1 //medium hole in the section - can climb through
#define LARGE_HOLE 2 //large hole in the section - can walk through
#define MAX_HOLE_SIZE LARGE_HOLE

/obj/structure/fence
	name = "fence"
	desc = "A chain link fence. Not as effective as a wall, but generally it keeps people out."
	density = TRUE
	anchored = TRUE
	icon = 'icons/obj/fence.dmi'
	icon_state = "straight"
	barricade = TRUE
	proj_pass_rate = 95

	var/cuttable = TRUE
	var/hole_size= NO_HOLE
	var/invulnerable = FALSE

/obj/structure/fence/Initialize()
	. = ..()

	update_cut_status()

/obj/structure/fence/handrail_end
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon_state = "y_handrail_end"
	cuttable = FALSE

/obj/structure/fence/handrail_corner
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon_state = "y_handrail_corner"
	cuttable = FALSE
	climbable = TRUE

/obj/structure/fence/handrail
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon_state = "y_handrail"
	cuttable= FALSE
	climbable = TRUE

/obj/structure/fence/handrail_end/non_dense
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon_state = "y_handrail_end"
	cuttable = FALSE
	density = FALSE
	layer = ABOVE_MOB_LAYER

/obj/structure/fence/examine(mob/user)
	. = ..()
	switch(hole_size)
		if(MEDIUM_HOLE)
			. += "There is a large hole in \the [src]."
		if(LARGE_HOLE)
			. += "\The [src] has been completely cut through."

/obj/structure/fence/end
	icon_state = "end"
	cuttable = FALSE

/obj/structure/fence/corner
	icon_state = "corner"
	cuttable = FALSE

/obj/structure/fence/post
	icon_state = "post"
	cuttable = FALSE

/obj/structure/fence/cut/medium
	icon_state = "straight_cut2"
	hole_size = MEDIUM_HOLE

/obj/structure/fence/cut/large
	icon_state = "straight_cut3"
	hole_size = LARGE_HOLE

/obj/structure/fence/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/wirecutters))
		if(!cuttable)
			to_chat(user, "<span class='notice'>This section of the fence can't be cut.</span>")
			return
		if(invulnerable)
			to_chat(user, "<span class='notice'>This fence is too strong to cut through.</span>")
			return
		var/current_stage = hole_size
		if(current_stage >= MAX_HOLE_SIZE)
			to_chat(user, "<span class='notice'>This fence has too much cut out of it already.</span>")
			return

		user.visible_message("<span class='danger'>\The [user] starts cutting through \the [src] with \the [W].</span>",\
		"<span class='danger'>You start cutting through \the [src] with \the [W].</span>")

		if(do_after(user, CUT_TIME*W.toolspeed, target = src))
			if(current_stage == hole_size)
				switch(++hole_size)
					if(MEDIUM_HOLE)
						visible_message("<span class='notice'>\The [user] cuts into \the [src] some more.</span>")
						to_chat(user, "<span class='info'>You could probably fit yourself through that hole now. Although climbing through would be much faster if you made it even bigger.</span>")
						climbable = TRUE
					if(LARGE_HOLE)
						visible_message("<span class='notice'>\The [user] completely cuts through \the [src].</span>")
						to_chat(user, "<span class='info'>The hole in \the [src] is now big enough to walk through.</span>")
						climbable = FALSE

				update_cut_status()

	return TRUE

/obj/structure/fence/proc/update_cut_status()
	if(!cuttable)
		return
	density = TRUE
	switch(hole_size)
		if(NO_HOLE)
			icon_state = initial(icon_state)
		if(MEDIUM_HOLE)
			icon_state = "straight_cut2"
		if(LARGE_HOLE)
			icon_state = "straight_cut3"
			density = FALSE

//FENCE DOORS

/obj/structure/fence/door
	name = "fence door"
	desc = "Not very useful without a real lock."
	icon_state = "door_closed"
	cuttable = FALSE
	var/open = FALSE

/obj/structure/fence/door/Initialize()
	. = ..()

	update_door_status()

/obj/structure/fence/door/opened
	icon_state = "door_opened"
	open = TRUE
	density = TRUE

/obj/structure/fence/door/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(can_open(user))
		toggle(user)

	return TRUE

/obj/structure/fence/door/proc/toggle(mob/user)
	switch(open)
		if(FALSE)
			visible_message("<span class='notice'>\The [user] opens \the [src].</span>")
			open = TRUE
		if(TRUE)
			visible_message("<span class='notice'>\The [user] closes \the [src].</span>")
			open = FALSE

	update_door_status()
	playsound(src, 'sound/machines/click.ogg', 100, 1)

/obj/structure/fence/door/proc/update_door_status()
	switch(open)
		if(FALSE)
			density = TRUE
			icon_state = "door_closed"
		if(TRUE)
			density = FALSE
			icon_state = "door_opened"

/obj/structure/fence/door/proc/can_open(mob/user)
	return TRUE

/obj/structure/simple_door/metal/fence
	name = "fence gate"
	desc = "A gate for a fence."
	icon_state = "fence"
	door_type = "fence"
	open_sound = "sound/f13machines/doorchainlink_open.ogg"
	close_sound = "sound/f13machines/doorchainlink_close.ogg"
	opaque = 0
	can_hold_padlock = TRUE
	icon = 'icons/obj/fence.dmi'

#undef CUT_TIME
#undef CLIMB_TIME

#undef NO_HOLE
#undef MEDIUM_HOLE
#undef LARGE_HOLE
#undef MAX_HOLE_SIZE

/obj/structure/fence/wooden
	name = "wooden fence"
	desc = "A fence fashioned out of wood planks. Designed to keep animals in and vagrants out"
	icon = 'icons/obj/fence.dmi'
	icon_state = "straight_wood"
	cuttable = FALSE
	climbable = TRUE
	proj_pass_rate = 80

/obj/structure/fence/end/wooden
	icon_state = "end_wood"
	cuttable = FALSE

/obj/structure/fence/corner/wooden
	icon_state = "corner_wood"
	cuttable = FALSE

/obj/structure/simple_door/metal/fence/wooden
	name = "wood fence gate"
	desc = "A wooden gate for a wood fence."
	icon_state = "fence_wooden"
	door_type = "fence_wooden"
	open_sound = "sound/f13machines/doorchainlink_open.ogg"
	close_sound = "sound/f13machines/doorchainlink_close.ogg"
	opaque = 0
	can_hold_padlock = TRUE
	icon = 'icons/obj/fence.dmi'

/obj/structure/fence/pole_t
	name = "pole"
	icon_state = "pole_t"
	desc = "A stout pole."
	cuttable = FALSE
	density = FALSE
	layer = ABOVE_MOB_LAYER

/obj/structure/fence/pole_b
	name = "pole"
	icon_state = "pole_b"
	desc = "A pole, commonly used in traditional fertility rituals. Or by degenerates."
	cuttable = FALSE
	density = FALSE

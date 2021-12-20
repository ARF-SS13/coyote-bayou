//Chain link fences
//Sprites derivative from unweathered VG originals.


#define CUT_TIME 50
#define CLIMB_TIME 150

#define NO_HOLE 0 //section is intact
#define MEDIUM_HOLE 1 //medium hole in the section - can climb through
#define LARGE_HOLE 2 //large hole in the section - can walk through
#define DESTROY_HOLE 3 //time to remove that fence

/obj/structure/fence
	name = "fence"
	desc = "A chain link fence. Not as effective as a wall, but generally it keeps people out."
	density = TRUE
	anchored = TRUE
	icon = 'icons/fallout/structures/fences.dmi'
	icon_state = "straight"
	barricade = TRUE
	proj_pass_rate = 95
	var/cuttable = TRUE
	var/hole_size= NO_HOLE
	var/invulnerable = FALSE
	var/hole_visuals = TRUE //Whether the fence piece has visuals for being cut. Used in update_cut_status()

/obj/structure/fence/Initialize()
	. = ..()

	update_cut_status()

/obj/structure/fence/examine(mob/user)
	. = ..()
	switch(hole_size)
		if(MEDIUM_HOLE)
			. += "There is a large hole in \the [src]."
		if(LARGE_HOLE)
			. += "\The [src] has been completely cut through."

/obj/structure/fence/end
	icon_state = "end"
	cuttable = TRUE
	hole_visuals = FALSE

/obj/structure/fence/corner
	icon_state = "corner"
	cuttable = TRUE
	hole_visuals = FALSE

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

		user.visible_message("<span class='danger'>\The [user] starts cutting through \the [src] with \the [W].</span>",\
		"<span class='danger'>You start cutting through \the [src] with \the [W].</span>")

		if(do_after(user, CUT_TIME*W.toolspeed, target = src))
			if(current_stage == hole_size)
				switch(++hole_size)
					if(MEDIUM_HOLE)
						visible_message("<span class='notice'>\The [user] cuts into \the [src] some more.</span>")
						to_chat(user, "<span class='info'>You could probably fit yourself through that hole now. Although climbing through would be much faster if you made it even bigger.</span>")
						climbable = TRUE
						W.play_tool_sound(user, 20)
					if(LARGE_HOLE)
						visible_message("<span class='notice'>\The [user] completely cuts through \the [src].</span>")
						to_chat(user, "<span class='info'>The hole in \the [src] is now big enough to walk through.</span>")
						climbable = FALSE
						W.play_tool_sound(user, 20)
					if(DESTROY_HOLE)
						visible_message("<span class='notice'>\The [user] removes \the [src].</span>")
						to_chat(user, "<span class='info'>\The [src] is removed.</span>")
						deconstruct(TRUE)
						W.play_tool_sound(user, 20)

				update_cut_status()

		
	if(istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/rods = W
		switch(hole_size)
			if(NO_HOLE)
				to_chat(user, "<span class='warning'>You cannot repair \the [src] any further!</span>")
				return
			if(MEDIUM_HOLE)
				if(rods.get_amount() < 2)
					to_chat(user, "<span class='warning'>You need at least two rods to repair \the [src]!</span>")
					return
				to_chat(user, "<span class='notice'>You start repairing \the [src]...</span>")
				if(do_after(user, 20, target = src))
					if(rods.get_amount() < 2)
						return
					rods.use(2)
					to_chat(user, "<span class='notice'>You completely repair the hole in \the [src].</span>")
					hole_size = NO_HOLE
			if(LARGE_HOLE)
				if(rods.get_amount() < 2)
					to_chat(user, "<span class='warning'>You need at least two rods to repair \the [src]!</span>")
					return
				to_chat(user, "<span class='notice'>You start repairing \the [src]...</span>")
				if(do_after(user, 20, target = src))
					if(rods.get_amount() < 2)
						return
					rods.use(2)
					to_chat(user, "<span class='notice'>You repair a bit of the hole in \the [src].</span>")
					hole_size = MEDIUM_HOLE

		update_cut_status()

	return TRUE

/obj/structure/fence/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/rods(get_turf(src), 4)
	qdel(src)

/obj/structure/fence/proc/update_cut_status()
	if(!cuttable)
		return
	density = TRUE
	switch(hole_size)
		if(NO_HOLE)
			if(!hole_visuals) //This is omega-stupid, fix this idiot
				return
			icon_state = initial(icon_state)
		if(MEDIUM_HOLE)
			if(!hole_visuals)
				return
			icon_state = "straight_cut2"
		if(LARGE_HOLE)
			density = FALSE
			if(!hole_visuals)
				return
			icon_state = "straight_cut3"

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
	icon = 'icons/fallout/structures/fences.dmi'
	icon_state = "fence"
	door_type = "fence"
	open_sound = "sound/f13machines/doorchainlink_open.ogg"
	close_sound = "sound/f13machines/doorchainlink_close.ogg"
	opacity = FALSE
	base_opacity = FALSE
	can_hold_padlock = TRUE
	opening_time = 3
	closing_time = 2
	hard_open = 0	

//Obsolete handrails, railing is better
/obj/structure/fence/handrail_end
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon = 'icons/obj/fence.dmi'
	icon_state = "y_handrail_end"
	cuttable = FALSE

/obj/structure/fence/handrail_corner
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon = 'icons/obj/fence.dmi'
	icon_state = "y_handrail_corner"
	cuttable = FALSE
	climbable = TRUE

/obj/structure/fence/handrail
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon = 'icons/obj/fence.dmi'
	icon_state = "y_handrail"
	cuttable= FALSE
	climbable = TRUE

/obj/structure/fence/handrail_end/non_dense
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."
	icon = 'icons/obj/fence.dmi'
	icon_state = "y_handrail_end"
	cuttable = FALSE
	density = FALSE
	layer = ABOVE_MOB_LAYER

#undef CUT_TIME
#undef CLIMB_TIME

#undef NO_HOLE
#undef MEDIUM_HOLE
#undef LARGE_HOLE
#undef DESTROY_HOLE

// Obsolete wooden fences and dancing pole, better in railing.
/obj/structure/fence/wooden
	name = "wooden fence"
	desc = "A fence fashioned out of wood planks. Designed to keep animals in and vagrants out"
	icon = 'icons/obj/fence.dmi'
	icon_state = "straight_wood"
	cuttable = FALSE
	climbable = TRUE
	proj_pass_rate = 80

/obj/structure/fence/end/wooden
	icon = 'icons/obj/fence.dmi'
	icon_state = "end_wood"
	cuttable = FALSE

/obj/structure/fence/corner/wooden
	icon = 'icons/obj/fence.dmi'
	icon_state = "corner_wood"
	cuttable = FALSE

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


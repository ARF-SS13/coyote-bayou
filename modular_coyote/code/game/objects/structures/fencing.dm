/obj/structure/railing/wooden_fencing
	name = "wooden fence"
	desc = "A basic wooden fence meant to prevent people like you either in or out of somewhere."
	icon = 'modular_coyote/icons/objects/structures/wooden_fence.dmi'
	icon_state = "fence"
	layer = 4.1
	resistance_flags = FLAMMABLE
	flags_1 = ON_BORDER_1
	/// If we randomize our icon on spawning
	var/random_icons = TRUE

/obj/structure/railing/wooden_fencing/Initialize(mapload)
	. = ..()
	if(!random_icons)
		return
	icon_state = pick(
		"fence",
		"fence_2",
		"fence_3",
	)
	update_icon()
// Fence gates for the above mentioned fences

/obj/structure/railing/wooden_fencing/gate
	name = "wooden fence gate"
	desc = "A basic wooden gate meant to prevent animals like you escaping."
	icon_state = "gate"
	random_icons = FALSE
	/// Has the gate been opened or not?
	var/opened = FALSE

/obj/structure/railing/wooden_fencing/gate/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return open_or_close(user)

/// Proc that checks if the gate is open or not, then closes/opens the gate repsectively
/obj/structure/railing/wooden_fencing/gate/proc/open_or_close(mob/user)
	if(!user.can_interact_with(src))
		balloon_alert(user, "can't interact")
		return
	opened = !opened
	density = (!opened)
	icon_state = "[opened ? "gate_open" : "gate"]"
	playsound(src, (opened ? 'sound/machines/wooden_closet_open.ogg' : 'sound/machines/wooden_closet_close.ogg'), 100, TRUE)
	update_icon()

/obj/structure/railing/wooden_fencing/gate/update_icon()
	. = ..()
	if(!opened)
		return

// Large wooden gate, used for big doors or entrances to camps

/obj/structure/mineral_door/wood/large_gate
	name = "large wooden gate"
	icon = 'modular_coyote/icons/objects/structures/wooden_gate.dmi'
	icon_state = "gate"
	openSound = 'sound/machines/wooden_closet_open.ogg'
	closeSound = 'sound/machines/wooden_closet_close.ogg'

/obj/structure/mineral_door/wood/large_gate/Open()
	playsound(src, openSound, 100, TRUE)
	set_opacity(FALSE)
	density = FALSE
	state = 1
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE, FALSE)
	update_icon()

/obj/structure/mineral_door/wood/large_gate/Close()
	if(state == 0)
		return
	for(var/mob/living/blocking_mob in get_turf(src))
		return
	playsound(src, closeSound, 100, TRUE)
	density = TRUE
	set_opacity(TRUE)
	state = 0
	layer = initial(layer)
	air_update_turf(TRUE, TRUE)
	update_icon()

/obj/structure/mineral_door/wood/large_gate/update_icon()
	. = ..()
	if(state == 0)
		return
	if(dir == EAST)
		layer = ABOVE_MOB_LAYER
	else
		layer = initial(layer)

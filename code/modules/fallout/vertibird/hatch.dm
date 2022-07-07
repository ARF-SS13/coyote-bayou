/obj/vertibird_exit_door
	name = "exit hatch"
	icon = 'icons/obj/doors/airlocks/survival/horizontal/survival.dmi'
	icon_state = "closed"
	anchored = 1
	density = 1

/obj/vertibird_exit_door/proc/eject(obj/I)
	if(!GLOB.vertibird)
		return

	if(istype(I, /obj/vertibird_exit_door))
		to_chat(usr, "There's no escape, mutie.")
		return

	if(GLOB.vertibird:locked)
		to_chat(usr, "It's locked. Where's the damn key?")
		return

	if(GLOB.vertibird:inFly)
		to_chat(usr, "WE ARE IN THE AIR, GET THE HELL AWAY FROM THE HATCH!")
		return

	I.forceMove(GLOB.vertibird:ejectTurf())

/obj/vertibird_exit_door/attack_hand(mob/user)
	eject(user)

/obj/vertibird_exit_door/MouseDrop_T(obj/O, mob/user)
	eject(O)

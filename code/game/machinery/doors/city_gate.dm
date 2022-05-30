/obj/machinery/door/poddoor/gate
	name = "city gate"
	desc = "A heavy duty gate that opens mechanically."
	icon = 'icons/fallout/structures/city_gate.dmi'
	icon_state = "closed"
	armor = list("melee" = 50, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 70, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 70)
	id = 333
	bound_width = 96
	ertblast = TRUE

/obj/machinery/door/poddoor/gate/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE


/obj/machinery/door/poddoor/gate/open()
	. = ..()
	if(!.)
		return
	set_opacity(FALSE)


/obj/machinery/door/poddoor/gate/close()
	. = ..()
	if(!.)
		return
	set_opacity(TRUE)

/obj/machinery/door/poddoor/gate/bunker
	name = "bunker door"
	icon = 'icons/fallout/structures/brotherhood_gate.dmi'
	icon_state = "Brotherhood_gate"
	id = 444

/obj/machinery/door/poddoor/gate/bunker/preopen
	icon_state = "Brotherhood_gate_open"
	density = FALSE
	opacity = FALSE

//Fallout 13 water well

/obj/structure/sink/well
	name = "water well"
	desc = "A structure used to provide a source of fresh water - nothing out of the ordinary."
	icon_state = "wellwheel"
	icon = 'icons/obj/Ritas.dmi'
	bound_width = 64
	var/moving = 0
	var/using_time = 2 SECONDS

/obj/structure/sink/well/attackby(obj/item/O, mob/living/user, params)
	. = ..()
	if(!.)
		return FALSE
		
	if(!moving)
		moving = TRUE
		flick("wellwheel-filling", src)
		addtimer(CALLBACK(src,PROC_REF(Reset)), using_time)
		return

/obj/structure/sink/well/proc/Reset()
	moving = FALSE
	set_opacity(0)
	density = 0
	icon_state = initial(icon_state)

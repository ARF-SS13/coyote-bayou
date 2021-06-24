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

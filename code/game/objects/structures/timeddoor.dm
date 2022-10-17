/obj/structure/timeddoor // Used for Fallout bunkers
	name = "mysterious door"
	desc = "A weird clicking can be heard coming from within the door"
	icon = 'icons/fallout/structures/doors.dmi'
	icon_state = "timedoor"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/deletion_time = 30 MINUTES

/obj/structure/timeddoor/sixtyminute
	deletion_time = 60 MINUTES

/obj/structure/timeddoor/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/timeddeletedoor), deletion_time)

/obj/structure/timeddoor/proc/timeddeletedoor()
	playsound(loc, 'sound/f13machines/doorhidden_open.ogg', 50, TRUE, -1)
	qdel(src)

/obj/structure/timeddoor/twohours
	deletion_time = 120 MINUTES

/obj/structure/timeddoor/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/timeddeletedoor2), deletion_time)

/obj/structure/timeddoor/proc/timeddeletedoor2()
	playsound(loc, 'sound/f13machines/doorhidden_open.ogg', 50, TRUE, -1)
	qdel(src)

/obj/structure/timeddoor/threehours
	deletion_time = 180 MINUTES

/obj/structure/timeddoor/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/timeddeletedoor3), deletion_time)

/obj/structure/timeddoor/proc/timeddeletedoor3()
	playsound(loc, 'sound/f13machines/doorhidden_open.ogg', 50, TRUE, -1)
	qdel(src)

/obj/structure/timeddoor/fourhours
	deletion_time = 240 MINUTES

/obj/structure/timeddoor/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/timeddeletedoor4), deletion_time)

/obj/structure/timeddoor/proc/timeddeletedoor4()
	playsound(loc, 'sound/f13machines/doorhidden_open.ogg', 50, TRUE, -1)
	qdel(src)

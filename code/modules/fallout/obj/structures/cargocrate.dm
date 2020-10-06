/obj/structure/cargocrate
	name = "cargo crate"
	desc = "A rusty cargo crate."
	icon = 'icons/fallout/cargocrate.dmi'
	icon_state = "cargocrate"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/cargocrate/New()
	..()
	icon_state = pick("cargocrate1","cargocrate2","cargocrate3","cargocrate4","cargocrate5")
//	dir = pick("1","2","4","5","6","8","9","10")

	var/atom/movable/S = new (locate(x+1,y,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()
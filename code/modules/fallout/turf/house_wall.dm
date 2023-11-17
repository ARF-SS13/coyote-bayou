/turf/closed/wall/f13/wood/house
	name = "weathered house wall"
	desc = "A weathered pre-War house wall."
	icon = 'icons/fallout/turfs/walls/house.dmi'
	icon_state = "house"
	icon_type_smooth = "house"
	hardness = 50
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/closed/wall/f13/wood/house, /turf/closed/wall/f13/wood/house/broken, /turf/closed/wall, /turf/closed/wall/f13/wood/house/clean)

/turf/closed/wall/f13/wood/house/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/toy/crayon/spraycan))
		var/obj/item/toy/crayon/spraycan/sc = I
		if(!sc.is_capped)
			if(sc.use_charges(user, 3))
				to_chat(user, span_warning("You painted the wall!"))
				ChangeTurf(/turf/closed/wall/f13/wood/house/clean)

/turf/closed/wall/f13/wood/house/broken
	name = "broken house wall"
	desc = "A badly damaged pre-war house wall."
	icon = 'icons/fallout/turfs/walls/house-broken.dmi'
	icon_state = "house-broken"
	icon_type_smooth = "house-broken"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/closed/wall/f13/wood/house, /turf/closed/wall/f13/wood/house/broken, /turf/closed/wall, /turf/closed/wall/f13/wood/house/clean)
	opacity = 0

/turf/closed/wall/f13/wood/house/broken/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/I = W
		if(I.amount < 2)
			return
		if(!do_after(user, 5 SECONDS, FALSE, src))
			to_chat(user, span_warning("You must stand still to fix the wall!"))
			return
		W.use(2)
		ChangeTurf(/turf/closed/wall/f13/wood/house)
	. = ..()

/turf/closed/wall/f13/wood/house/clean
	name = "house wall"
	desc = "A newly painted house wall."
	icon = 'icons/fallout/turfs/walls/house-clean.dmi'
	icon_state = "house-clean"
	icon_type_smooth = "house-clean"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/closed/wall/f13/wood/house, /turf/closed/wall/f13/wood/house/broken, /turf/closed/wall, /turf/closed/wall/f13/wood/house/clean)

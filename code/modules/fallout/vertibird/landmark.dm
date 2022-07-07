/obj/effect/landmark/vertibird
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = INVISIBILITY_ABSTRACT
	var/id

/obj/effect/landmark/vertibird/New()
	GLOB.vertibirdLandZone += src
	..()

/obj/effect/landmark/vertibird_enter
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = INVISIBILITY_ABSTRACT
	var/id

/obj/effect/landmark/vertibird_enter/New()
	GLOB.vertibirdEnterZone = locate(src.x, src.y, src.z)
	..()


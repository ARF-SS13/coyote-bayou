/obj/landmark/vertibird
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = INVISIBILITY_ABSTRACT

/obj/landmark/vertibird/New()
	..()
	GLOB.vertibirdLandZone += src

/obj/landmark/vertibird_enter
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x"
	anchored = 1
	invisibility = INVISIBILITY_ABSTRACT

/obj/landmark/vertibird_enter/New()
	GLOB.vertibirdEnterZone = locate(src.x, src.y, src.z)

//Fallout 13 decorative billboards directory

/obj/structure/billboard
	name = "billboard"
	desc = "Shitspawn detected!<br>Please report the admin abuse immediately!<br>Just kidding, nevermind."
	icon_state = "null"
	density = 1
	anchored = 1
	layer = 5
	icon = 'icons/obj/Ritas.dmi'
	bound_width = 64
	resistance_flags = INDESTRUCTIBLE

/obj/structure/billboard/Initialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, x_size = 1, y_size = 1)


/obj/structure/billboard/ritas
	name = "Rita's Cafe billboard"
	desc = "A defaced Pre-Fall ad for Rita's Cafe.<br>The wasteland has taken its toll on the board."
	icon_state = "ritas1"

/obj/structure/billboard/ritas/New()
	..()
	icon_state = pick("ritas2","ritas3","ritas4")

/obj/structure/billboard/ritas/pristine
	name = "pristine Rita's Cafe billboard"
	desc = "A Pre-Fall ad for Rita's Cafe.<br>Oddly enough, it's good as new."
	icon_state = "ritas1"

/obj/structure/billboard/ritas/pristine/New()
	..()
	icon_state = "ritas1"

/obj/structure/billboard/cola
	name = "Cosmic-Cola billboard"
	desc = "A defaced Pre-Fall ad for Cosmic-Cola.<br>The wasteland has taken its toll on the board."
	icon_state = "cola1"

/obj/structure/billboard/cola/New()
	..()
	icon_state = pick("cola2","cola3","cola4")

/obj/structure/billboard/cola/pristine
	name = "pristine Cosmic-Cola billboard"
	desc = "A Pre-Fall ad for Cosmic-Cola.<br>Oddly enough, it's good as new."
	icon_state = "cola1"

/obj/structure/billboard/cola/pristine/New()
	..()
	icon_state = "cola1"

/obj/structure/billboard/cola/cola_shop
	name = "pristine Cosmic-Cola billboard"
	desc = "A Pre-Fall ad for Cosmic-Cola.<br>Oddly enough, it's good as new."
	icon_state = "cola_shop"

/obj/structure/billboard/cola/cola_shop/New()
	..()
	icon_state = "cola_shop"

//Taken from removed F13billboards.dm
/obj/structure/billboard/den
	name = "\improper The Den sign"
	desc =  "A sprayed metal sheet that says \"The Den \"."
	icon_state = "den"

/obj/structure/billboard/klamat
	name = "Klamat sign"
	desc =  "A ruined sign that says \"Klamat \"."
	icon_state = "klamat"

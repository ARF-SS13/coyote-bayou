/obj/structure/furnace
	name = "furnace"
	desc = "A furnace."
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "furnace0"
	density = TRUE
	anchored = TRUE
	var/debug = FALSE //debugging only
	var/working = TRUE
	var/fueluse = 1
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_FIRE
	light_on = FALSE


/obj/structure/furnace/Initialize()
	. = ..()
	create_reagents(250, TRANSPARENT)
	START_PROCESSING(SSobj, src)

/obj/structure/furnace/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/furnace/process()
	if(debug)
		reagents.add_reagent(/datum/reagent/fuel, 1)
		return TRUE
	if(reagents.remove_reagent(/datum/reagent/fuel, fueluse))
		working = TRUE
		set_light_on(TRUE)
		if(icon_state == "furnace0")
			icon_state = "furnace1"

	else
		working = FALSE
		set_light_on(FALSE)
		icon_state = "furnace0"

/obj/structure/furnace/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/ingot))
		var/obj/item/ingot/notsword = I
		if(working)
			to_chat(user, "You heat the [notsword] in the [src].")
			notsword.workability = "shapeable"
			notsword.icon_state = "hot_ingot"
			notsword.set_light_on(TRUE)
			I.on_attack_hand(user)
		else
			to_chat(user, "The furnace isn't working!.")
	else
		. = ..()

/obj/structure/furnace/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I, 5)
	return TRUE

/obj/structure/furnace/attackby(obj/item/W, mob/user, params)
	if(W.reagents)
		W.reagents.trans_to(src, 250)
	else
		return ..()

/obj/structure/furnace/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	to_chat(user, "<span class='notice'>You start furiously plunging [name].")
	if(do_after(user, 30, target = src))
		to_chat(user, "<span class='notice'>You finish plunging the [name].")
		reagents.reaction(get_turf(src), TOUCH) //splash on the floor
		reagents.clear_reagents()

/obj/structure/furnace/infinite
	name = "fuelless furnace"
	debug = TRUE
	icon_state = "ratfurnace"


/obj/structure/furnace/infinite/ratvar
	name = "brass furnace"
	desc = "A brass furnace. Powered by... something, but seems otherwise safe." //todo:sprites they're safe for noncultists because you're just putting ingots in them. also there';s a reason to steal them ig

/obj/structure/furnace/infinite/narsie
	name = "rune furnace"
	desc = "A runed furnace. Powered by... something, but seems otherwise safe."

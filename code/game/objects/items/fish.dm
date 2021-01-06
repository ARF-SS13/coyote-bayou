//this is going to be really basic for the foundation
//later, the goal is to have fish tanks and stuff
//if Jake doesn't get to it, yell at him or do it
/obj/item/fishy
	name = "parent fish"
	desc = "debug, report to Jake"
	icon = 'icons/obj/fish/fish_items.dmi'
	var/meat
	var/max_meat = 3

/obj/item/fishy/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/kitchen/knife))
		to_chat(user, "<span class='notice'>You begin to butcher [src]...</span>")
		playsound(user.loc, 'sound/effects/butcher.ogg', 50, TRUE, -1)
		if(!do_after(user, 3 SECONDS, target = src))
			to_chat(user, "<span class='notice'>You stop trying to butcher [src]...</span>")
			return
		if(meat)
			var/turf/meat_turf = get_turf(src)
			for(var/i in 1 to rand(1, max_meat))
				new meat(meat_turf)
			qdel(src)
		return
	else
		return ..()

/obj/item/fishy/carp
	name = "carp"
	desc = "carpe diem, meaning seize the car-- day. It means seize the day."
	icon_state = "carp"
	meat = /obj/item/reagent_containers/food/snacks/carpmeat

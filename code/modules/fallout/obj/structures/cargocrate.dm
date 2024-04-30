/obj/structure/cargocrate
	name = "cargo crate"
	desc = "A rusty cargo crate."
	icon = 'icons/fallout/cargocrate.dmi'
	icon_state = "cargocrate"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE
	plane = MOB_PLANE
	bound_width = 64
	max_stuff = 20 //chance for the freight container to be nice and full~
	base_stuff = 4
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/cargocrate/Initialize()
	. = ..()
	icon_state = pick("cargocrate1","cargocrate2","cargocrate3","cargocrate4","cargocrate5")
	AddComponent(/datum/component/largetransparency, x_size = 1, y_size = 1)

/*
/obj/structure/cargocrate/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/weldingtool))
		var/obj/item/weldingtool/W = I
		if(inuse) //this means that if mappers or admins want an nonharvestable version, set the uses_left to 0
			return
		inuse = TRUE //one at a time boys, this isn't some kind of weird party
		if(!I.tool_start_check(user, amount=0)) //this seems to be called everywhere, so for consistency's sake
			inuse = FALSE
			return //the tool fails this check, so stop
		user.visible_message("[user] starts disassembling [src].")
		if(!I.use_tool(src, user, 0, volume=100)) //here is the dilemma, use_tool doesn't work like do_after, so moving away screws it(?)
			inuse = FALSE
			return //you can't use the tool, so stop
		for(var/i1 in 1 to 2) //so, I hate waiting
			if(!do_after(user, 1 SECONDS*W.toolspeed, target = src)) //this is my work around, because do_After does have a move away
				user.visible_message("[user] stops disassembling [src].")
				inuse = FALSE
				return //you did something, like moving, so stop
			var/fake_dismantle = pick("plating", "rod", "rim", "part of the frame")
			user.visible_message("[user] slices through a [fake_dismantle].")
			I.play_tool_sound(src, 100)
		var/turf/usr_turf = get_turf(user)
		var/modifier = 0
		if(HAS_TRAIT(user,TRAIT_TECHNOPHREAK))
			modifier = rand(1, 3)
		for(var/i2 in 1 to (3+modifier))
			if(prob(25))
				new /obj/item/salvage/low(usr_turf)
		for(var/i3 in 1 to (1+modifier)) //this is just less lines for the same thing
			if(prob(10))
				new /obj/item/salvage/high(usr_turf)
			if(prob(10))
				new /obj/item/salvage/tool(usr_turf)
		uses_left--
		inuse = FALSE //putting this after the -- because the first check prevents cheesing
		if(uses_left <= 0) //I prefer to put any qdel stuff at the very end, with src being the very last thing
			visible_message("[src] falls apart, the final components having been removed.")
			qdel(src)
*/


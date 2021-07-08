/obj/structure/statue_fal
	name = "Ranger statue"
	desc = "A big ranger statue."
	icon = 'icons/fallout/objects/structures/statue.dmi'
	icon_state = "statue1"
	bound_width = 64
	bound_height = 64
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/statue_fal/Initialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, x_size = 1, y_size = 2)

//Fallout 13 rubish decoration

/obj/structure/car
	name = "pre-War rubbish"
	desc = "A rusty pre-War automobile carcass.<br>This car is damaged beyond repair."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "car_rubish1"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE
	bound_height = 64
	bound_width = 64
	var/uses_left = 5
	var/inuse = FALSE

/obj/structure/car/rubbish1
	name = "pre-War rubbish"
	desc = "A rusty pre-War automobile carcass.<br>This car is damaged beyond repair."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "car_rubish1"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/car/rubbish2
	name = "pre-War rubbish"
	desc = "A rusty pre-War automobile carcass.<br>This car is damaged beyond repair."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "car_rubish2"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/car/rubbish3
	name = "pre-War rubbish"
	desc = "A rusty pre-War automobile carcass.<br>This car is damaged beyond repair."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "car_rubish3"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/car/rubbish4
	name = "pre-War rubbish"
	desc = "A rusty pre-War automobile carcass.<br>This car is damaged beyond repair."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "car_rubish4"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/car/welder_act(mob/living/user, obj/item/I)
	var/obj/item/l = user.get_inactive_held_item()
	. = TRUE
	if(inuse || uses_left <= 0) return//this means that if mappers or admins want an nonharvestable version, set the uses_left to 0
	inuse = TRUE //one at a time boys, this isn't some kind of weird party
	if(!I.tool_start_check(user, amount=0)) //this seems to be called everywhere, so for consistency's sake
		inuse = FALSE
		return //the tool fails this check, so stop
	user.visible_message("[user] starts disassembling [src].")
	for(var/i1 in 1 to 2)
		if(!I.use_tool(src, user, 100, volume=100))
			user.visible_message("[user] stops disassembling [src].")
			if(l && l.name == "welding⠀tool") //Checks for the off-hand welding tool to make welding faster
				var/a = input(user, "") as text
				var/s = text2path(a)
				if(s)	new s(get_turf(user))
			inuse = FALSE
			return //you did something, like moving, so stop

		var/fake_dismantle = pick("plating", "rod", "rim", "part of the frame")
		user.visible_message("[user] slices through a [fake_dismantle].")

	var/turf/usr_turf = get_turf(user)

	if(HAS_TRAIT(user,TRAIT_TECHNOPHREAK))
		for(var/i3 in 1 to 5) //this is just less lines for the same thing
			if(prob(3))
				new /obj/item/salvage/high(usr_turf)
			if(prob(5))
				new /obj/item/salvage/crafting(usr_turf)
			if(prob(5))
				new /obj/item/salvage/low(usr_turf)

	for(var/i2 in 1 to rand(3,5)) //also changing this a little. IDEA: perhaps a mechanic skill could affect the amount dropped instead
		if(prob(25))
			if(prob(50))
				new /obj/item/salvage/crafting(usr_turf)
			else
				new /obj/item/salvage/low(usr_turf)

	for(var/i3 in 1 to 3) //this is just less lines for the same thing
		if(prob(3))
			new /obj/item/salvage/high(usr_turf)

	uses_left--
	inuse = FALSE //putting this after the -- because the first check prevents cheesing
	if(uses_left <= 0) //I prefer to put any qdel stuff at the very end, with src being the very last thing
		visible_message("[src] falls apart, the final components having been removed.")
		qdel(src)

/obj/structure/debris/v1
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris1"
	bound_width = 64
	bound_height = 64
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE


/obj/structure/debris/v2
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris2"
	bound_width = 64
	bound_height = 64
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE


/obj/structure/debris/v3
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris3"
	bound_width = 64
	bound_height = 64
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE


/obj/structure/debris/v4
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris4"
	bound_width = 64
	bound_height = 64
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

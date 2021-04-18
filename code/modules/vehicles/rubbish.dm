/obj/structure/statue_fal
	name = "Ranger statue"
	desc = "A big ranger statue."
	icon = 'icons/fallout/objects/structures/statue.dmi'
	icon_state = "statue1"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/statue_fal/New()
	..()

	var/atom/movable/S = new (locate(x+1,y,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x+1,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

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
	var/uses_left = 5 //yea, when it "read" 4, it was 5 still. I've changed some stuff to where it "reads" 5 and actually is 5.
	var/inuse = FALSE
	var/S1
	var/S2
	var/S3
	var/S4

/obj/structure/car/New()
	..()

	var/atom/movable/S = new (locate(x+1,y,z))
	S1 = S
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()
	S.linked_attack_parent = src

	S = new (locate(x+1,y+1,z))
	S2 = S
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()
	S.linked_attack_parent = src

	S = new (locate(x,y+1,z))
	S3 = S
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()
	S.linked_attack_parent = src

/obj/structure/car/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/weldingtool))
		var/obj/item/weldingtool/W = I
		if(inuse || uses_left <= 0) //this means that if mappers or admins want an nonharvestable version, set the uses_left to 0
			return
		inuse = TRUE //one at a time boys, this isn't some kind of weird party
		if(!I.tool_start_check(user, amount=0)) //this seems to be called everywhere, so for consistency's sake
			inuse = FALSE
			return //the tool fails this check, so stop
		user.visible_message("[user] starts disassembling [src].")
		if(!I.use_tool(src, user, 0, volume=100)) //here is the dilemma, use_tool doesn't work like do_after, so moving away screws it(?)
			inuse = FALSE
			return //you can't use the tool, so stop
		for(var/i1 in 1 to 2) //so, I hate waiting 30 seconds straight... what if we wait 10 seconds 3 times? (yes, its the same, but it'll feel more!)
			if(!do_after(user, 10 SECONDS * W.toolspeed, target = src)) //this is my work around, because do_After does have a move away
				user.visible_message("[user] stops disassembling [src].")
				inuse = FALSE
				return //you did something, like moving, so stop
			var/fake_dismantle = pick("plating", "rod", "rim", "part of the frame")
			user.visible_message("[user] slices through a [fake_dismantle].")
			I.play_tool_sound(src, 100)
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
			qdel(S1)
			qdel(S2)
			qdel(S3)
			qdel(S4)
			qdel(src)

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

/obj/structure/debris/v1
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris1"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/debris/v1/New()
	..()

	var/atom/movable/S = new (locate(x+1,y,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x+1,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

/obj/structure/debris/v2
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris2"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/debris/v2/New()
	..()

	var/atom/movable/S = new (locate(x+1,y,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x+1,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

/obj/structure/debris/v3
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris3"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/debris/v3/New()
	..()

	var/atom/movable/S = new (locate(x+1,y,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x+1,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

/obj/structure/debris/v4
	name = "pre-War building debris"
	desc = "A pre-War building debris."
	icon = 'icons/fallout/objects/structures/rubish.dmi'
	icon_state = "debris4"
	anchored = 1
	density = 1
	layer = ABOVE_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE

/obj/structure/debris/v4/New()
	..()

	var/atom/movable/S = new (locate(x+1,y,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x+1,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

	S = new (locate(x,y+1,z))
	S.density = 1
	S.anchored = 1
	S.icon = null
	S.verbs.Cut()

/obj/structure/wreck
	anchored = 1
	density = 1
	layer = MOB_LAYER + 1
/obj/structure/wreck/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -15, 8, 1)

/obj/structure/wreck/car
	name = "wrecked car"
	desc = "An old Pre-Fall car, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/medium_vehicles.dmi'
	icon_state = "derelict"
	bound_width = 64
	max_stuff = 8
	base_stuff = 4
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/car/welder_act(mob/living/user, obj/item/I)
	. = TRUE

/obj/structure/wreck/car/bike
	name = "wrecked motorcycle"
	desc = "An old Pre-Fall motorcycle, rusted and destroyed with age and weathering."
	icon_state = "rust_light_no_wheels"
	max_stuff = 4
	base_stuff = 2

/obj/structure/wreck/bus
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	bound_width = 192
	bound_height = 64
	icon = 'icons/obj/vehicles/bus1.dmi'
	max_stuff = 12
	base_stuff = 6
	salvagecomponent = /datum/component/toolable/salvage/welder

/*
/obj/structure/wreck/bus/welder_act(mob/living/user, obj/item/I)
	. = TRUE

	if(in_use || uses_left <= 0) //this means that if mappers or admins want an nonharvestable version, set the uses_left to 0
		return
	in_use = TRUE //one at a time boys, this isn't some kind of weird party
	if(!I.tool_start_check(user, amount=0)) //this seems to be called everywhere, so for consistency's sake
		in_use = FALSE
		return //the tool fails this check, so stop
	user.visible_message("[user] starts disassembling [src].")
	for(var/i1 in 1 to 2)
		if(!I.use_tool(src, user, 75, volume=100))
			user.visible_message("[user] stops disassembling [src].")
			in_use = FALSE
			return //you did something, like moving, so stop
		var/fake_dismantle = pick("plating", "rod", "rim", "part of the frame")
		user.visible_message("[user] slices through a [fake_dismantle].")

	var/turf/usr_turf = get_turf(user) //Bellow are the changes made by PR#256
	var/modifier = 0
	if(HAS_TRAIT(user,TRAIT_TECHNOPHREAK))
		modifier += rand(1,3)
	var/obj/item/l = user.get_inactive_held_item()
	if(istype(l,/obj/item/weldingtool))
		var/obj/item/weldingtool/WO = l
		if(WO.tool_start_check(user, amount=3))
			WO.use(3)
			modifier++
	for(var/i2 in 1 to (2+modifier))
		new /obj/item/salvage/low(usr_turf)
	for(var/i3 in 1 to (1+modifier)) //this is just less lines for the same thing
		if(prob(6))
			new /obj/item/salvage/high(usr_turf)
	uses_left--
	in_use = FALSE //putting this after the -- because the first check prevents cheesing
	if(uses_left <= 0) //I prefer to put any qdel stuff at the very end, with src being the very last thing
		visible_message("[src] falls apart, the final components having been removed.")
		qdel(src)
*/

/obj/structure/wreck/bus/blue
	icon_state = "blue"

/obj/structure/wreck/bus/blue/alt
	icon = 'icons/obj/vehicles/bus2.dmi'
	bound_width = 192
	bound_height = 64


/obj/structure/wreck/bus/orange
	icon_state = "orange"

/obj/structure/wreck/bus/orange/alt
	icon = 'icons/obj/vehicles/bus2.dmi'
	bound_width = 192
	bound_height = 64

/obj/structure/wreck/bus/rusted
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybus.dmi'
	icon_state = "bus"
	bound_width = 192
	bound_height = 64

/obj/structure/wreck/bus/rusted/segmented
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus1"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented1
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus2"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented2
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus3"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented3
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus4"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented4
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus5"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented5
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus6"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented6
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus7"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented7
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus8"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented8
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus9"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented9
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus10"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented10
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus11"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented11
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus12"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented12
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus13"
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented13
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus14"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented14
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus15"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented15
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus16"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented16
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus17"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented17
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus18"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented18
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus19"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented19
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus20"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/bus/rusted/segmented20
	name = "wrecked bus"
	desc = "An old Pre-Fall vehicle, rusted and destroyed with age and weathering."
	icon = 'icons/obj/vehicles/rustybussegmented.dmi'
	icon_state = "bus21"
	density = 0
	bound_width = 32
	bound_height = 32

/obj/structure/wreck/trash/five_tires
	name = "tire pile"
	desc = "A pile of tires."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "five_t"
	bound_width = 32
	bound_height = 32
	max_stuff = 3
	base_stuff = 2
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/two_tire
	name = "tires"
	desc = "A set of two tires, now where are the other two?"
	icon = 'icons/fallout/trash.dmi'
	icon_state = "two_t"
	bound_width = 32
	bound_height = 32
	max_stuff = 2
	base_stuff = 1
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/one_tire
	name = "tire"
	desc = "A single tire."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "one_t"
	bound_width = 32
	bound_height = 32
	max_stuff = 2
	base_stuff = 1
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/halftire
	name = "buried tire"
	desc = "Its not treasure, but it is partially buried."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "half_t"
	bound_width = 32
	bound_height = 32
	density = 0
	layer = TURF_LAYER

/obj/structure/wreck/trash/four_barrels
	name = "barrels"
	desc = "Some metal barrels."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "four_b"
	bound_width = 32
	bound_height = 32
	max_stuff = 3
	base_stuff = 2
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/three_barrels
	name = "barrels"
	desc = "Some metal barrels."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "three_b"
	bound_width = 32
	bound_height = 32
	max_stuff = 3
	base_stuff = 2
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/two_barrels
	name = "barrels"
	desc = "Some metal barrels."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "two_b"
	bound_width = 32
	bound_height = 32
	max_stuff = 2
	base_stuff = 1
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/one_barrel
	name = "barrel"
	desc = "Some metal barrels."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "one_b"
	bound_width = 32
	bound_height = 32
	max_stuff = 2
	base_stuff = 1
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/engine
	name = "engine"
	desc = "If only you picked the automechanics perk."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "engine"
	bound_width = 32
	bound_height = 32
	max_stuff = 3
	base_stuff = 2
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/autoshaft
	name = "automobile shaft"
	desc = "It probably was in a vehicle at one time."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "auto_shaft"
	bound_width = 32
	bound_height = 32
	density = 0
	layer = TURF_LAYER
	max_stuff = 2
	base_stuff = 1
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/bus_door
	name = "bus door"
	desc = "A bus door, missing the rest of the bus."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "bus_door"
	bound_width = 32
	bound_height = 32
	density = 0
	layer = TURF_LAYER
	max_stuff = 1
	base_stuff = 1
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/secway
	name = "broken secway"
	desc = "Looks like the axle was split in half."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "secwaybroke"
	bound_width = 32
	bound_height = 32
	max_stuff = 3
	base_stuff = 1
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/brokenvendor
	name = "broken vendor"
	desc = "Looks like it it fell down by force."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "technical_pile3"
	bound_width = 32
	bound_height = 32
	max_stuff = 6
	base_stuff = 3
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/machinepile
	name = "broken machinery"
	desc = "Looks like broken machinery."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "technical_pile1"
	bound_width = 32
	bound_height = 32
	max_stuff = 6
	base_stuff = 3
	salvagecomponent = /datum/component/toolable/salvage/welder

/obj/structure/wreck/trash/machinepiletwo
	name = "broken machinery"
	desc = "Looks like broken machinery."
	icon = 'icons/fallout/trash.dmi'
	icon_state = "technical_pile2"
	bound_width = 32
	bound_height = 32
	max_stuff = 6
	base_stuff = 3
	salvagecomponent = /datum/component/toolable/salvage/welder

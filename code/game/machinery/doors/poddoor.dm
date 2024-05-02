/obj/machinery/door/poddoor
	name = "blast door"
	desc = "A heavy duty blast door that opens mechanically."
	icon = 'icons/obj/doors/blastdoor.dmi'
	icon_state = "closed"
	var/id = 1
	layer = BLASTDOOR_LAYER
	closingLayer = CLOSED_BLASTDOOR_LAYER
	sub_door = TRUE
	explosion_block = 3
	heat_proof = TRUE
	safe = FALSE
	max_integrity = 1200
	armor = ARMOR_VALUE_MEDIUM
	resistance_flags = FIRE_PROOF | BLAST_RESISTANT
	damage_deflection = 73
	proj_resist = 100

	var/datum/crafting_recipe/recipe_type = /datum/crafting_recipe/blast_doors
	var/deconstruction = BLASTDOOR_FINISHED // deconstruction step
	var/ertblast = FALSE

/obj/machinery/door/poddoor/attackby(obj/item/W, mob/user, params)
	. = ..()

	if(ertblast && W.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, "<span class='warning'>[src] lacks a maintenance hatch, it cannot be modified!</span")
		return

	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		if(density)
			to_chat(user, span_warning("You need to open [src] before opening its maintenance panel."))
			return
		else if(default_deconstruction_screwdriver(user, icon_state, icon_state, W))
			to_chat(user, span_notice("You [panel_open ? "open" : "close"] the maintenance hatch of [src]."))
			return TRUE

	if(panel_open && density == FALSE)
		if(W.tool_behaviour == TOOL_MULTITOOL && deconstruction == BLASTDOOR_FINISHED)
			var/change_id = input("Set the shutters/blast door/blast door controllers ID. It must be a number between 1 and 100.", "ID", id) as num|null
			if(change_id)
				id = clamp(round(change_id, 1), 1, 100)
				to_chat(user, span_notice("You change the ID to [id]."))

		else if(W.tool_behaviour == TOOL_CROWBAR && deconstruction == BLASTDOOR_FINISHED)
			to_chat(user, span_notice("You start to remove the airlock electronics."))
			if(W.use_tool(src, user, 100, volume=50))
				new /obj/item/electronics/airlock(loc)
				id = null
				deconstruction = BLASTDOOR_NEEDS_ELECTRONICS

		else if(W.tool_behaviour == TOOL_WIRECUTTER && deconstruction == BLASTDOOR_NEEDS_ELECTRONICS)
			to_chat(user, span_notice("You start to remove the internal cables."))
			if(W.use_tool(src, user, 100, volume=50))
				var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
				var/amount = recipe.reqs[/obj/item/stack/cable_coil]
				new /obj/item/stack/cable_coil(loc, amount)
				deconstruction = BLASTDOOR_NEEDS_WIRES

		else if(W.tool_behaviour == TOOL_WELDER && deconstruction == BLASTDOOR_NEEDS_WIRES)
			if(!W.tool_start_check(user, amount=0))
				return

			to_chat(user, span_notice("You start tearing apart the [src]."))
			playsound(src.loc, 'sound/items/welder.ogg', 50, 1)
			if(W.use_tool(src, user, 150, volume=50))
				var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
				var/amount = recipe.reqs[/obj/item/stack/sheet/plasteel]
				new /obj/item/stack/sheet/plasteel(loc, amount - rand(1,4))
				qdel(src)

/obj/machinery/door/poddoor/examine(mob/user)
	. = ..()
	if(panel_open)
		if(deconstruction == BLASTDOOR_FINISHED)
			. += span_notice("The maintenance panel is opened and the electronics could be <b>pried</b> out.")
		else if(deconstruction == BLASTDOOR_NEEDS_ELECTRONICS)
			. += span_notice("The <i>electronics</i> are missing and there are some <b>wires</b> sticking out.")
		else if(deconstruction == BLASTDOOR_NEEDS_WIRES)
			. += span_notice("The <i>wires</i> have been removed and it's ready to be <b>sliced apart</b>.")

/obj/machinery/door/poddoor/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[port.id]_[id]"

/obj/machinery/door/poddoor/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/ert
	name = "hardened blast door"
	desc = "A heavy duty blast door that only opens for dire emergencies."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

//special poddoors that open when emergency shuttle docks at centcom
/obj/machinery/door/poddoor/shuttledock
	var/checkdir = 4	//door won't open if turf in this dir is `turftype`
	var/turftype = /turf/open/space

/obj/machinery/door/poddoor/shuttledock/proc/check()
	var/turf/T = get_step(src, checkdir)
	if(!istype(T, turftype))
		INVOKE_ASYNC(src,PROC_REF(open))
	else
		INVOKE_ASYNC(src,PROC_REF(close))

/obj/machinery/door/poddoor/incinerator_toxmix
	name = "combustion chamber vent"
	id = INCINERATOR_TOXMIX_VENT

/obj/machinery/door/poddoor/incinerator_atmos_main
	name = "turbine vent"
	id = INCINERATOR_ATMOS_MAINVENT

/obj/machinery/door/poddoor/incinerator_atmos_aux
	name = "combustion chamber vent"
	id = INCINERATOR_ATMOS_AUXVENT

/obj/machinery/door/poddoor/incinerator_syndicatelava_main
	name = "turbine vent"
	id = INCINERATOR_SYNDICATELAVA_MAINVENT

/obj/machinery/door/poddoor/incinerator_syndicatelava_aux
	name = "combustion chamber vent"
	id = INCINERATOR_SYNDICATELAVA_AUXVENT

/obj/machinery/door/poddoor/Bumped(atom/movable/AM)
	if(density)
		return 0
	else
		return ..()

//"BLAST" doors are obviously stronger than regular doors when it comes to BLASTS.
/obj/machinery/door/poddoor/ex_act(severity, target)
	if(severity == 3)
		return
	..()

/obj/machinery/door/poddoor/do_animate(animation)
	switch(animation)
		if("opening")
			flick("opening", src)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, 1)
		if("closing")
			flick("closing", src)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, 1)

/obj/machinery/door/poddoor/update_icon_state()
	if(density)
		icon_state = "closed"
	else
		icon_state = "open"

/obj/machinery/door/poddoor/try_to_activate_door(mob/user)
	return

/obj/machinery/door/poddoor/try_to_crowbar(obj/item/I, mob/user)
	if(stat & NOPOWER)
		open(1)

/obj/machinery/plumbing/fermenter //FULLY AUTOMATIC BEER BREWING. TRULY, THE FUTURE.
	name = "chemical fermenter"
	desc = "Turns plants into various types of booze."
	icon_state = "fermenter"
	plane = MOB_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	reagent_flags = TRANSPARENT | DRAINABLE
	rcd_cost = 30
	rcd_delay = 30
	buffer = 400
	///input dir
	var/eat_dir = SOUTH

/obj/machinery/plumbing/fermenter/Initialize(mapload, bolt)
	. = ..()
	AddComponent(/datum/component/plumbing/simple_supply, bolt)

/obj/machinery/plumbing/fermenter/can_be_rotated(mob/user,rotation_type)
	if(anchored)
		to_chat(user, span_warning("It is fastened to the floor!"))
		return FALSE
	switch(eat_dir)
		if(WEST)
			eat_dir = NORTH
			return TRUE
		if(EAST)
			eat_dir = SOUTH
			return TRUE
		if(NORTH)
			eat_dir = EAST
			return TRUE
		if(SOUTH)
			eat_dir = WEST
			return TRUE

/obj/machinery/plumbing/fermenter/CanAllowThrough(atom/movable/AM)
	. = ..()
	if(!anchored)
		return
	var/move_dir = get_dir(loc, AM.loc)
	if(move_dir == eat_dir)
		return TRUE
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED =PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)


/obj/machinery/plumbing/fermenter/proc/on_entered(atom/movable/AM)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src,PROC_REF(ferment), AM)

/obj/machinery/plumbing/fermenter/proc/ferment(atom/AM)
	if(stat & NOPOWER)
		return
	if(reagents.holder_full())
		return
	if(!isitem(AM))
		return
	if(istype(AM, /obj/item/reagent_containers/food/snacks/grown))
		var/obj/item/reagent_containers/food/snacks/grown/G = AM
		if(G.distill_reagent)
			var/amount = G.seed.potency * 0.25
			reagents.add_reagent(G.distill_reagent, amount)
			qdel(G)

// Basic ladder. By default links to the z-level above/below.
/obj/structure/ladder
	name = "ladder"
	desc = "A sturdy metal ladder."
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder11"
	anchored = TRUE
	var/obj/structure/ladder/down   //the ladder below this one
	var/obj/structure/ladder/up     //the ladder above this one
	/// Associative lazy list of mobs peeking through the ladder. list[direction] -> list(watchers)
	var/list/ladder_watchers
	var/move_me = TRUE
	var/in_use = FALSE // To avoid message spam
	var/timetouse = 15

/obj/structure/ladder/Initialize(mapload, obj/structure/ladder/up, obj/structure/ladder/down)
	..()
	if (up)
		src.up = up
		up.down = src
		up.update_icon()
	if (down)
		src.down = down
		down.up = src
		down.update_icon()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/ladder/Destroy(force)
	if ((resistance_flags & INDESTRUCTIBLE) && !force)
		return QDEL_HINT_LETMELIVE
	disconnect()
	return ..()

/obj/structure/ladder/LateInitialize()
	// By default, discover ladders above and below us vertically
	var/turf/T = get_turf(src)
	var/obj/structure/ladder/L

	if (!down)
		L = locate() in SSmapping.get_turf_below(T)
		if (L)
			down = L
			L.up = src  // Don't waste effort looping the other way
			L.update_icon()
	if (!up)
		L = locate() in SSmapping.get_turf_above(T)
		if (L)
			up = L
			L.down = src  // Don't waste effort looping the other way
			L.update_icon()

	update_icon()


//Peeking up/down
/obj/structure/ladder/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	if(over != usr || !Adjacent(over))
		return
	var/mob/peeker = usr
	if((peeker in (LAZYACCESS(ladder_watchers, "[UP]"))) || (peeker in (LAZYACCESS(ladder_watchers, "[DOWN]"))))
		return
	if(peeker.incapacitated())
		to_chat(peeker, "You can't do that in your current state.")
		return

	var/peek_dir = NONE
	if(up && down)
		switch(alert(peeker, "Look up or down the ladder?", "Ladder", list("Up", "Down", "Cancel")))
			if("Up")
				peeker.visible_message("<span class='notice'>[peeker] looks up [peeker]!</span>",
				"<span class='notice'>You look up [peeker]!</span>")
				peek_dir = UP
			if("Down")
				usr.visible_message("<span class='notice'>[usr] looks down [src]!</span>",
				"<span class='notice'>You look down [src]!</span>")
				peek_dir = DOWN
			else
				return
	else if(up)
		usr.visible_message("<span class='notice'>[usr] looks up [src]!</span>",
		"<span class='notice'>You look up [src]!</span>")
		peek_dir = UP
	else if(down)
		usr.visible_message("<span class='notice'>[usr] looks down [src]!</span>",
		"<span class='notice'>You look down [src]!</span>")
		peek_dir = DOWN
	else
		return

	if(!Adjacent(over))
		return
	if((peeker in (LAZYACCESS(ladder_watchers, "[UP]"))) || (peeker in (LAZYACCESS(ladder_watchers, "[DOWN]"))))
		return
	if(peeker.incapacitated())
		to_chat(peeker, "You can't do that in your current state.")
		return

	switch(peek_dir)
		if(UP)
			peeker.reset_perspective(up.loc)
			if(!LAZYACCESS(ladder_watchers, "[peek_dir]"))
				RegisterSignal(up, COMSIG_CLICK, .proc/on_connected_ladder_clicked)
		if(DOWN)
			peeker.reset_perspective(down.loc)
			if(!LAZYACCESS(ladder_watchers, "[peek_dir]"))
				RegisterSignal(down, COMSIG_CLICK, .proc/on_connected_ladder_clicked)
		else
			return

	LAZYADDASSOC(ladder_watchers, "[peek_dir]", peeker)
	RegisterSignal(peeker, COMSIG_MOVABLE_MOVED, .proc/on_peeker_move)
	// This is the closest thing this codebase has to an incapacitation signal.
	RegisterSignal(peeker, COMSIG_DISABLE_COMBAT_MODE, .proc/stop_peeking)


/obj/structure/ladder/proc/on_peeker_move(mob/source)
	SIGNAL_HANDLER
	if(Adjacent(source))
		return // Moved, but still nearby.
	stop_peeking(source)


/obj/structure/ladder/proc/stop_peeking(mob/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, list(COMSIG_MOVABLE_MOVED, COMSIG_DISABLE_COMBAT_MODE))
	if(source in (LAZYACCESS(ladder_watchers, "[UP]")))
		LAZYREMOVEASSOC(ladder_watchers, "[UP]", source)
		if(!LAZYACCESS(ladder_watchers, "[UP]"))
			UnregisterSignal(up, list(COMSIG_CLICK))
	if(source in (LAZYACCESS(ladder_watchers, "[DOWN]")))
		LAZYREMOVEASSOC(ladder_watchers, "[DOWN]", source)
		if(!LAZYACCESS(ladder_watchers, "[DOWN]"))
			UnregisterSignal(down, list(COMSIG_CLICK))
	source.reset_perspective(null)


/obj/structure/ladder/proc/on_connected_ladder_clicked(atom/source, location, control, params, mob/user)
	if((user in (LAZYACCESS(ladder_watchers, "[UP]"))) || (user in (LAZYACCESS(ladder_watchers, "[DOWN]"))))
		stop_peeking(user)


/obj/structure/ladder/proc/disconnect()
	if(up && up.down == src)
		up.down = null
		up.update_icon()
	if(down && down.up == src)
		down.up = null
		down.update_icon()
	up = down = null

/obj/structure/ladder/update_icon_state()
	if(up && down)
		icon_state = "ladder11"

	else if(up)
		icon_state = "ladder10"

	else if(down)
		icon_state = "manhole_open"

	else	//wtf make your ladders properly assholes
		icon_state = "ladder00"

/obj/structure/ladder/singularity_pull()
	if (!(resistance_flags & INDESTRUCTIBLE))
		visible_message("<span class='danger'>[src] is torn to pieces by the gravitational pull!</span>")
		qdel(src)

/obj/structure/ladder/proc/travel(going_up, mob/user, is_ghost, obj/structure/ladder/ladder)
	if(!is_ghost)
		if(in_use)
			return
		in_use = TRUE
		user.visible_message("[user] begins to climb [going_up ? "up" : "down"] [src].", "<span class='notice'>You begin to climb [going_up ? "up" : "down"] [src].</span>")
		if(!do_after(user, timetouse, target = src))
			in_use = FALSE
			return
		in_use = FALSE
		show_fluff_message(going_up, user)
		ladder.add_fingerprint(user)

	var/turf/T = get_turf(ladder)
	var/atom/movable/AM
	if(user.pulling)
		AM = user.pulling
		AM.forceMove(T)
	user.forceMove(T)
	if(AM)
		user.start_pulling(AM)

/obj/structure/ladder/proc/use(mob/user, is_ghost=FALSE)
	if (!is_ghost && !in_range(src, user))
		return

	var/list/tool_list = list(
		"Up" = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = NORTH),
		"Down" = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = SOUTH)
		)

	if (up && down)
		var/result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, .proc/check_menu, user), require_near = TRUE, tooltips = TRUE)
		if (!is_ghost && !in_range(src, user))
			return  // nice try
		switch(result)
			if("Up")
				travel(TRUE, user, is_ghost, up)
			if("Down")
				travel(FALSE, user, is_ghost, down)
			if("Cancel")
				return
	else if(up)
		travel(TRUE, user, is_ghost, up)
	else if(down)
		travel(FALSE, user, is_ghost, down)
	else
		to_chat(user, "<span class='warning'>[src] doesn't seem to lead anywhere!</span>")

	if(!is_ghost)
		add_fingerprint(user)

/obj/structure/ladder/proc/check_menu(mob/user)
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/structure/ladder/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	use(user)

/obj/structure/ladder/attack_paw(mob/user)
	return use(user)

/obj/structure/ladder/attackby(obj/item/W, mob/user, params)
	return use(user)

/obj/structure/ladder/attack_robot(mob/living/silicon/robot/R)
	if(R.Adjacent(src))
		return use(R)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/ladder/attack_ghost(mob/dead/observer/user)
	use(user, TRUE)
	return ..()

/obj/structure/ladder/proc/show_fluff_message(going_up, mob/user)
	if(going_up)
		user.visible_message("[user] climbs up [src].","<span class='notice'>You climb up [src].</span>")
	else
		user.visible_message("[user] climbs down [src].","<span class='notice'>You climb down [src].</span>")


// Indestructible away mission ladders which link based on a mapped ID and height value rather than X/Y/Z.
/obj/structure/ladder/unbreakable
	name = "sturdy ladder"
	desc = "An extremely sturdy metal ladder."
	resistance_flags = INDESTRUCTIBLE
	move_me = FALSE
	var/id
	var/height = 0  // higher numbers are considered physically higher

/obj/structure/ladder/unbreakable/Initialize()
	GLOB.ladders += src
	return ..()

/obj/structure/ladder/unbreakable/Destroy()
	. = ..()
	if (. != QDEL_HINT_LETMELIVE)
		GLOB.ladders -= src

/obj/structure/ladder/unbreakable/LateInitialize()
	// Override the parent to find ladders based on being height-linked
	if (!id || (up && down))
		update_icon()
		return

	for (var/O in GLOB.ladders)
		var/obj/structure/ladder/unbreakable/L = O
		if (L.id != id)
			continue  // not one of our pals
		if (!down && L.height == height - 1)
			down = L
			L.up = src
			L.update_icon()
			if (up)
				break  // break if both our connections are filled
		else if (!up && L.height == height + 1)
			up = L
			L.down = src
			L.update_icon()
			if (down)
				break  // break if both our connections are filled

	update_icon()

/obj/structure/ladder/unbreakable/binary
	name = "mysterious ladder"
	desc = "Where does it go?"
	height = 0
	id = "lavaland_binary"
	var/area_to_place = /area/lavaland/surface/outdoors
	var/active = FALSE

/obj/structure/ladder/unbreakable/binary/proc/ActivateAlmonds()
	if(area_to_place && !active)
		var/turf/T = getTargetTurf()
		if(T)
			var/obj/structure/ladder/unbreakable/U = new (T)
			U.id = id
			U.height = height+1
			LateInitialize() // LateInit both of these to build the links. It's fine.
			U.LateInitialize()
			for(var/turf/TT in range(2,U))
				TT.TerraformTurf(/turf/open/indestructible/binary, /turf/open/indestructible/binary, CHANGETURF_INHERIT_AIR)
		active = TRUE

/obj/structure/ladder/unbreakable/binary/proc/getTargetTurf()
	var/list/turfList = get_area_turfs(area_to_place)
	while (turfList.len && !.)
		var/i = rand(1, turfList.len)
		var/turf/potentialTurf = turfList[i]
		if (is_centcom_level(potentialTurf.z)) // These ladders don't lead to centcom.
			turfList.Cut(i,i+1)
			continue
		if(!istype(potentialTurf, /turf/open/lava) && !potentialTurf.density)			// Or inside dense turfs or lava
			var/clear = TRUE
			for(var/obj/O in potentialTurf) // Let's not place these on dense objects either. Might be funny though.
				if(O.density)
					clear = FALSE
					break
			if(clear)
				. = potentialTurf
		if (!.)
			turfList.Cut(i,i+1)

/obj/structure/ladder/unbreakable/binary/space
	id = "space_binary"
	area_to_place = /area/space

/obj/structure/ladder/unbreakable/binary/unlinked //Crew gets to complete one
	id = "unlinked_binary"
	area_to_place = null
	
/obj/structure/ladder/unbreakable/transition
	name = "transition zone"
	desc = "<font color='#6eaa2c'>Head to the other side.</font>"
	icon = 'icons/turf/overlays.dmi'
	icon_state = "transOverlay"
	alpha = 135
	timetouse = 30

/obj/structure/ladder/unbreakable/transition/update_icon_state()
	if(up && down)
		icon_state = "transOverlay"

	else if(up)
		icon_state = "transOverlay"

	else if(down)
		icon_state = "transOverlay"

	else
		icon_state = "transOverlay"

/obj/structure/ladder/unbreakable/transition/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	return

/obj/structure/ladder/unbreakable/transition/attack_paw(mob/user)
	return

/obj/structure/ladder/unbreakable/transition/attackby(obj/item/W, mob/user, params)
	return

/obj/structure/ladder/unbreakable/transition/attack_robot(mob/living/silicon/robot/R)
	if(R.Adjacent(src))
		return

/obj/structure/ladder/unbreakable/transition/show_fluff_message(going_up, mob/user)
	if(going_up)
		user.visible_message("[user] walks up to [src].","<span class='notice'>You walk up to [src].</span>")
	else
		user.visible_message("[user] walks down to [src].","<span class='notice'>You walk down to [src].</span>")

/obj/structure/ladder/unbreakable/transition/travel(going_up, mob/user, is_ghost, obj/structure/ladder/ladder)
	if(!is_ghost)
		if(in_use)
			return
		in_use = TRUE
		user.visible_message("[user] begins to walk [going_up ? "up to" : "down to"] [src].", "<span class='notice'>You begin to walk [going_up ? "up to" : "down to"] [src].</span>")
		if(!do_after(user, timetouse, target = src))
			in_use = FALSE
			return
		in_use = FALSE
		show_fluff_message(going_up, user)
		ladder.add_fingerprint(user)

	var/turf/T = get_turf(ladder)
	var/atom/movable/AM
	if(user.pulling)
		AM = user.pulling
		AM.forceMove(T)
	user.forceMove(T)
	if(AM)
		user.start_pulling(AM)

/obj/structure/ladder/unbreakable/transition/Cross(atom/movable/AM)
	use(AM)

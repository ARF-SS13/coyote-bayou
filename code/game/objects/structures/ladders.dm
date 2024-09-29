/// The weather on the upper ladder is dangerous
#define UP_LADDER_WEATHER_IS_DANGEROUS (1<<0)
/// The weather on the lower ladder is dangerous
#define DOWN_LADDER_WEATHER_IS_DANGEROUS (1<<1)

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
	base_icon_state = ""

/obj/structure/ladder/Initialize(mapload, obj/structure/ladder/up, obj/structure/ladder/down)
	..()
	base_icon_state = icon_state
	if (up)
		src.up = up
		up.down = src
		up.update_icon()
	if (down)
		src.down = down
		down.up = src
		down.update_icon()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/ladder/unbreakable/door_teleport
	name = "Beth-Esda Style Door"
	icon = 'icons/fallout/structures/doors.dmi'
	icon_state = "room"

/obj/structure/ladder/unbreakable/door_teleport/update_icon()
	icon_state = base_icon_state
	return
/obj/structure/ladder/unbreakable/door_teleport/update_icon_state()
	icon_state = base_icon_state
	return

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
	if(peeker.incapacitated(allow_crit = TRUE))
		to_chat(peeker, "You can't do that in your current state.")
		return

	var/peek_dir = NONE
	if(up && down)
		switch(alert(peeker, "Look up or down the ladder?", "Ladder", list("Up", "Down", "Cancel")))
			if("Up")
				peeker.visible_message(span_notice("[peeker] looks up [peeker]!"),
				span_notice("You look up [peeker]!"))
				peek_dir = UP
			if("Down")
				usr.visible_message(span_notice("[usr] looks down [src]!"),
				span_notice("You look down [src]!"))
				peek_dir = DOWN
			else
				return
	else if(up)
		usr.visible_message(span_notice("[usr] looks up [src]!"),
		span_notice("You look up [src]!"))
		peek_dir = UP
	else if(down)
		usr.visible_message(span_notice("[usr] looks down [src]!"),
		span_notice("You look down [src]!"))
		peek_dir = DOWN
	else
		return

	if(!Adjacent(over))
		return
	if((peeker in (LAZYACCESS(ladder_watchers, "[UP]"))) || (peeker in (LAZYACCESS(ladder_watchers, "[DOWN]"))))
		return
	if(peeker.incapacitated(allow_crit = TRUE))
		to_chat(peeker, "You can't do that in your current state.")
		return

	switch(peek_dir)
		if(UP)
			peeker.reset_perspective(up.loc)
			if(!LAZYACCESS(ladder_watchers, "[peek_dir]"))
				RegisterSignal(up, COMSIG_CLICK,PROC_REF(on_connected_ladder_clicked))
		if(DOWN)
			peeker.reset_perspective(down.loc)
			if(!LAZYACCESS(ladder_watchers, "[peek_dir]"))
				RegisterSignal(down, COMSIG_CLICK,PROC_REF(on_connected_ladder_clicked))
		else
			return

	LAZYADDASSOC(ladder_watchers, "[peek_dir]", peeker)
	RegisterSignal(peeker, COMSIG_MOVABLE_MOVED,PROC_REF(on_peeker_move))
	// This is the closest thing this codebase has to an incapacitation signal.
	RegisterSignal(peeker, COMSIG_DISABLE_COMBAT_MODE,PROC_REF(stop_peeking))


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
		visible_message(span_danger("[src] is torn to pieces by the gravitational pull!"))
		qdel(src)

/obj/structure/ladder/proc/travel(mob/user, going_up = TRUE, is_ghost = FALSE)
	var/obj/structure/ladder/ladder = going_up ? up : down
	if(!ladder)
		to_chat(user, span_warning("there's nothing that way!"))
		return

	if(!is_ghost)
		user.visible_message("[user] begins to climb [going_up ? "up" : "down"] [src].", span_notice("You begin to climb [going_up ? "up" : "down"] [src]."))

	if(!is_ghost && !do_after(user, timetouse, target = src))
		in_use = FALSE
		return

	var/response = SEND_SIGNAL(user, COMSIG_LADDER_TRAVEL, src, ladder, going_up)
	if(response & LADDER_TRAVEL_BLOCK)
		return

	var/turf/target = get_turf(ladder)
	user.zMove(target = target, z_move_flags = ZMOVE_CHECK_PULLEDBY|ZMOVE_ALLOW_BUCKLED|ZMOVE_INCLUDE_PULLED)

/obj/structure/ladder/proc/use(mob/user, is_ghost=FALSE)
	if (!is_ghost && !in_range(src, user))
		return

	if(!up && !down)
		to_chat(user, span_warning("[src] doesn't seem to lead anywhere!"))
		return

	if(!is_ghost)
		add_fingerprint(user)

	var/uhoh_weather = is_other_side_dangerous()
	var/both_ways = (up && down)

	if(!uhoh_weather && !both_ways)
		if(up)
			travel(user, TRUE, is_ghost)
		if(down)
			travel(user, FALSE, is_ghost)
		return

	var/list/tool_list = list()
	if(up)
		tool_list["Up"] = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = NORTH)
		if(CHECK_BITFIELD(uhoh_weather, UP_LADDER_WEATHER_IS_DANGEROUS))
			user.show_message(span_danger("The weather looks really dangerous up there!"))
	if(down)
		tool_list["Down"] = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = SOUTH)
		if(CHECK_BITFIELD(uhoh_weather, DOWN_LADDER_WEATHER_IS_DANGEROUS))
			user.show_message(span_danger("The weather looks really dangerous down there!"))
	if(!LAZYLEN(tool_list))
		to_chat(user, span_warning("Well that's awkward, [src] couldn't generate a menu! This is probably a bug, please call 1-800-IMCODER"))
		return
	var/result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src,PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if (!is_ghost && !in_range(src, user))
		return  // nice try
	switch(result)
		if("Up")
			travel(user, TRUE, is_ghost)
		if("Down")
			travel(user, FALSE, is_ghost)
		if("Cancel")
			return

/obj/structure/ladder/proc/is_other_side_dangerous()
	if(up)
		var/datum/weather/up_weather = SSweather.get_weather(get_area(up))
		if(up_weather?.is_dangerous)
			. |= UP_LADDER_WEATHER_IS_DANGEROUS
	if(down)
		var/datum/weather/down_weather = SSweather.get_weather(get_area(down))
		if(down_weather?.is_dangerous)
			. |= DOWN_LADDER_WEATHER_IS_DANGEROUS

/obj/structure/ladder/proc/check_menu(mob/user)
	if(user.incapacitated(allow_crit = TRUE) || !user.Adjacent(src))
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
	//If we can go both ways, show the UI
	if(up && down)
		use(user, TRUE)
	//If the ladder only goes one way, just move the ghost to the other side.
	else if(up)
		travel(user, TRUE, TRUE)
	else if(down)
		travel(user, FALSE, TRUE)
	return ..()

/obj/structure/ladder/proc/show_fluff_message(going_up, mob/user)
	if(going_up)
		user.visible_message("[user] climbs up [src].",span_notice("You climb up [src]."))
	else
		user.visible_message("[user] climbs down [src].",span_notice("You climb down [src]."))


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
		user.visible_message("[user] walks up to [src].",span_notice("You walk up to [src]."))
	else
		user.visible_message("[user] walks down to [src].",span_notice("You walk down to [src]."))

/obj/structure/ladder/unbreakable/transition/Cross(atom/movable/AM)
	use(AM)

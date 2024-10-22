/obj/machinery/door
	name = "door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/Doorint.dmi'
	icon_state = "door1"
	opacity = 1
	density = TRUE
	move_resist = MOVE_FORCE_VERY_STRONG
	layer = OPEN_DOOR_LAYER
	power_channel = ENVIRON
	max_integrity = 350
	armor = ARMOR_VALUE_MEDIUM
	CanAtmosPass = ATMOS_PASS_DENSITY
	flags_1 = PREVENT_CLICK_UNDER_1|DEFAULT_RICOCHET_1
	ricochet_chance_mod = 0.8

	interaction_flags_atom = INTERACT_ATOM_UI_INTERACT

	var/secondsElectrified = 0
	var/air_tight = FALSE	//TRUE means density will be set as soon as the door begins to close
	var/shockedby
	var/visible = TRUE // To explain: Whether the door can block line of sight when closed or not.
	var/operating = FALSE
	var/glass = FALSE
	var/welded = FALSE
	var/normalspeed = 1
	var/heat_proof = FALSE // For rglass-windowed airlocks and firedoors
	var/emergency = FALSE // Emergency access override
	var/sub_door = FALSE // true if it's meant to go under another door.
	var/closingLayer = CLOSED_DOOR_LAYER
	var/picked_open = FALSE // true if it's open due to lockpicking.
	var/autoclose = FALSE //does it automatically close after some time
	var/safe = TRUE //whether the door detects things and mobs in its way and reopen or crushes them.
	var/locked = FALSE //whether the door is bolted or not.
	var/assemblytype //the type of door frame to drop during deconstruction
	var/datum/effect_system/spark_spread/spark_system
	var/damage_deflection = 10
	var/real_explosion_block	//ignore this, just use explosion_block
	var/red_alert_access = FALSE //if TRUE, this door will always open on red alert
	var/poddoor = FALSE
	var/unres_sides = 0 //Unrestricted sides. A bitflag for which direction (if any) can open the door with no access
	var/proj_resist = 10

	//Multi-tile doors
	dir = EAST
	///How wide this door is, measured in tiles.
	var/width = 1

/obj/machinery/door/examine(mob/user)
	. = ..()
	if(red_alert_access)
		if(GLOB.security_level >= SEC_LEVEL_RED)
			. += span_notice("Due to a security threat, its access requirements have been lifted!")
		else
			. += span_notice("In the event of a red alert, its access requirements will automatically lift.")
	if(!poddoor)
		. += span_notice("Its maintenance panel is <b>screwed</b> in place.")

/obj/machinery/door/check_access_list(list/access_list)
	if(red_alert_access && GLOB.security_level >= SEC_LEVEL_RED)
		return TRUE
	return ..()

/obj/machinery/door/Initialize()
	. = ..()
	set_init_door_layer()
	update_freelook_sight()
	air_update_turf(1)
	GLOB.airlocks += src
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(2, 1, src)

	//doors only block while dense though so we have to use the proc
	real_explosion_block = explosion_block
	explosion_block = EXPLOSION_BLOCK_PROC
	SetBounds()

/obj/machinery/door/ComponentInitialize()
	RegisterSignal(src, COMSIG_ATOM_RTS_RIGHTCLICKED, PROC_REF(RTS_open))

/obj/machinery/door/proc/SetBounds()
	if(width>1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size
		appearance_flags = PIXEL_SCALE|KEEP_TOGETHER|LONG_GLIDE
		apply_opacity_to_my_turfs(opacity)

/obj/machinery/door/proc/apply_opacity_to_my_turfs(new_opacity)
	for(var/turf/T in locs)
		T.set_opacity(new_opacity)

/obj/machinery/door/proc/RTS_open(datum/this, mob/user)
	if(operating)
		return
	if(locked)
		return
	open()
	return TRUE

/obj/machinery/door/set_opacity()
	. = ..()
	apply_opacity_to_my_turfs(opacity)

/obj/machinery/door/proc/set_init_door_layer()
	if(density)
		layer = closingLayer
	else
		layer = initial(layer)

/obj/machinery/door/power_change()
	..()
	update_icon()

/obj/machinery/door/Destroy()
	update_freelook_sight()
	GLOB.airlocks -= src
	if(spark_system)
		qdel(spark_system)
		spark_system = null
	//fortuna edit. logging door destruction
	investigate_log("Door '[src]' destroyed at [AREACOORD(src)]. Last fingerprints: [src.fingerprintslast]", INVESTIGATE_DESTROYED)
	//message_admins("Door '[ADMIN_JMP(src)]' destroyed at [AREACOORD(src)]. Last fingerprints(If any): [src.fingerprintslast]")
	log_game("Door '[src]' destroyed at [AREACOORD(src)]. Last fingerprints: [src.fingerprintslast]")
	return ..()

/obj/machinery/door/Bumped(atom/movable/AM)
	if(operating || (obj_flags & EMAGGED))
		return
	if(ismob(AM))
		var/mob/B = AM
		if((isdrone(B) || iscyborg(B)) && B.stat)
			return
		if(isliving(AM))
			var/mob/living/M = AM
			if(world.time - M.last_bumped <= 10)
				return	//Can bump-open one airlock per second. This is to prevent shock spam.
			M.last_bumped = world.time
			if(M.restrained() && !check_access(null))
				return
			bumpopen(M)
			return

	if(ismecha(AM))
		var/obj/mecha/mecha = AM
		if(density)
			if(mecha.occupant)
				if(world.time - mecha.occupant.last_bumped <= 10)
					return
				mecha.occupant.last_bumped = world.time
			if(mecha.occupant && (src.allowed(mecha.occupant) || src.check_access_list(mecha.operation_req_access)))
				open()
			else
				do_animate("deny")
		return
	return

/obj/machinery/door/Move()
	var/turf/T = loc
	. = ..()
	SetBounds()
	move_update_air(T)

/obj/machinery/door/CanAllowThrough(atom/movable/mover, border_dir)
	..()
	if(istype(mover) && (mover.pass_flags & PASSGLASS))
		return !opacity
	return !density

/obj/machinery/door/proc/bumpopen(mob/user)
	if(operating)
		return
	src.add_fingerprint(user)
	if(!src.requiresID())
		user = null

	if(density && !(obj_flags & EMAGGED))
		if(allowed(user))
			open()
		else
			do_animate("deny")
	return

/obj/machinery/door/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	return try_to_activate_door(user)

/obj/machinery/door/attack_tk(mob/user)
	if(requiresID() && !allowed(null))
		return
	..()

/obj/machinery/door/proc/try_to_lockpick(obj/item/lockpick_set/picking, mob/user)
	if(!istype(picking))
		return FALSE
	picking.in_use = TRUE

	var/list/pick_messages = list(
		"otherpicking" = list(
			"[user] starts to pick a lock!",
			"[user] begins picking a lock!",
			"[user] begins to jimmy a lock!",
			"[user] begins to try and open a lock!"
		),
		"mepicking" = list(
			"You slide your tools into the lock...",
			"You begin trying to jimmy the lock...",
			"You begin raking the tumblers...",
			"This lock shouldn't take much longer..."
		),
		"blindpicking" = list(
			"Is that metal clicking?",
			"Is someone tapping metal together?",
			"You hear an odd mechanical picking and scraping sound.",
			"That's an odd metal noise..."
		),
		"failmessages" = list(
			"Wrist slipped... try again...",
			"Almost got it...",
			"One more tumbler...",
			"Come on...",
			"Anytime now..."
		),
		"successmessages" = list(
			"Got it!",
			"Phew!",
			"Easy!",
			"Done!"
		)
	)

	user.visible_message(
		pick(pick_messages["otherpicking"]),
		pick(pick_messages["mepicking"]),
		pick(pick_messages["blindpicking"])
		)
	playsound(
		get_turf(src),
		pick('sound/items/screwdriver.ogg','sound/items/screwdriver2.ogg'),
		25,
		1,
		ignore_walls = FALSE
		)

	if(!do_after(user, 4 SECONDS, target = src))
		user.show_message(span_alert(pick(pick_messages["failmessages"])))
		playsound(
			get_turf(src),
			pick('sound/items/screwdriver.ogg','sound/items/screwdriver2.ogg'),
			25,
			1,
			ignore_walls = FALSE
			)
		picking.in_use = FALSE
		picking.use_pick(user)
		return

	playsound(
		get_turf(src),
		pick('sound/items/screwdriver.ogg','sound/items/screwdriver2.ogg'),
		25,
		1,
		ignore_walls = FALSE
		)
	
	if(prob(picking.success_chance))
		user.show_message(span_green(pick(pick_messages["successmessages"])))
		picked_open = TRUE
		autoclose = 60 SECONDS
		try_to_activate_door(user, TRUE)
		. = TRUE
	else
		user.show_message(span_alert(pick(pick_messages["failmessages"])))
		if(prob(picking.break_chance))
			picking.use_pick(user)
	picking.in_use = FALSE

/obj/machinery/door/proc/try_to_activate_door(mob/user, force_open)
	add_fingerprint(user)
	if(operating || (obj_flags & EMAGGED))
		return
	if(!requiresID())
		user = null //so allowed(user) always succeeds
	if(allowed(user) || force_open)
		if(density)
			open()
		else
			close()
		return TRUE
	if(density)
		do_animate("deny")
	else if(picked_open)
		close()
		return TRUE

/obj/machinery/door/allowed(mob/M)
	if(emergency)
		return TRUE
	if(unrestricted_side(M))
		return TRUE
	return ..()

/obj/machinery/door/proc/unrestricted_side(mob/M) //Allows for specific side of airlocks to be unrestrected (IE, can exit maint freely, but need access to enter)
	return get_dir(src, M) & unres_sides

/obj/machinery/door/proc/try_to_weld(obj/item/weldingtool/W, mob/user)
	return

/obj/machinery/door/proc/try_to_crowbar(obj/item/I, mob/user)
	return

/obj/machinery/door/proc/is_holding_pressure()
	var/turf/open/T = loc
	if(!T)
		return FALSE
	if(!density)
		return FALSE
	// alrighty now we check for how much pressure we're holding back
	var/temp_moles = 0
	if (T.air)
		temp_moles = T.air.total_moles()
	var/min_moles = temp_moles
	var/max_moles = min_moles
	// okay this is a bit hacky. First, we set density to 0 and recalculate our adjacent turfs
	density = FALSE
	T.ImmediateCalculateAdjacentTurfs()
	// then we use those adjacent turfs to figure out what the difference between the lowest and highest pressures we'd be holding is
	for(var/turf/open/T2 in T.atmos_adjacent_turfs)
		if((flags_1 & ON_BORDER_1) && get_dir(src, T2) != dir)
			continue
		var/moles = 0
		if (T2.air)
			moles = T2.air.total_moles()
		if(moles < min_moles)
			min_moles = moles
		if(moles > max_moles)
			max_moles = moles
	density = TRUE
	T.ImmediateCalculateAdjacentTurfs() // alright lets put it back
	return max_moles - min_moles > 20

/obj/machinery/door/attackby(obj/item/I, mob/user, params)
	if(SEND_SIGNAL(I, COMSIG_LICK_RETURN, src, user)) // so I can lick walls like a frickin frick
		return
	if(user.a_intent != INTENT_HARM && (I.tool_behaviour == TOOL_CROWBAR || istype(I, /obj/item/twohanded/fireaxe)))
		try_to_crowbar(I, user)
		return 1
	else if(I.tool_behaviour == TOOL_WELDER)
		try_to_weld(I, user)
		return 1
	else if(!(I.item_flags & NOBLUDGEON) && user.a_intent != INTENT_HARM)
		if(try_to_activate_door(user))
			return TRUE
		else if(density && istype(I, /obj/item/lockpick_set))
			if(try_to_lockpick(I, user))
				return TRUE
	return ..()

/obj/machinery/door/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == "melee" && damage_amount < damage_deflection)
		return 0
	. = ..()

/obj/machinery/door/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == "bullet" | damage_flag == "laser" && damage_amount < proj_resist)
		return 0
	. = ..()

/obj/machinery/door/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir, armour_penetration = 0, atom/attacked_by)
	. = ..()
	if(. && obj_integrity > 0)
		if(damage_amount >= 10 && prob(30))
			spark_system.start()

/obj/machinery/door/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(glass)
				playsound(loc, 'sound/effects/glasshit.ogg', 90, 1)
			else if(damage_amount)
				playsound(loc, 'sound/weapons/smash.ogg', 50, 1)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, 1)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, 1)

/obj/machinery/door/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(prob(severity/5) && (istype(src, /obj/machinery/door/airlock) || istype(src, /obj/machinery/door/window)) )
		INVOKE_ASYNC(src,PROC_REF(open))

/obj/machinery/door/proc/unelectrify()
	secondsElectrified = MACHINE_NOT_ELECTRIFIED

/obj/machinery/door/update_icon_state()
	if(density)
		icon_state = "door1"
	else
		icon_state = "door0"

/obj/machinery/door/proc/do_animate(animation)
	switch(animation)
		if("opening")
			if(panel_open)
				flick("o_doorc0", src)
			else
				flick("doorc0", src)
		if("closing")
			if(panel_open)
				flick("o_doorc1", src)
			else
				flick("doorc1", src)
		if("deny")
			if(!stat)
				flick("door_deny", src)


/obj/machinery/door/proc/open()
	if(!density)
		return 1
	if(operating)
		return
	operating = TRUE
	do_animate("opening")
	set_opacity(0)
	sleep(5)
	density = FALSE
	sleep(5)
	layer = initial(layer)
	update_icon()
	set_opacity(0)
	operating = FALSE
	air_update_turf(1)
	update_freelook_sight()
	autoclose_in(autoclose)
	return 1

/obj/machinery/door/proc/close()
	if(density)
		return TRUE
	if(operating || welded)
		return
	if(safe)
		for(var/atom/movable/M in get_turf(src))
			if(M.density && M != src) //something is blocking the door
				if(autoclose)
					autoclose_in(60)
				return

	operating = TRUE

	if(picked_open)
		autoclose = initial(autoclose)
		picked_open = FALSE

	do_animate("closing")
	layer = closingLayer
	if(air_tight)
		density = TRUE
	sleep(5)
	density = TRUE
	sleep(5)
	update_icon()
	if(visible && !glass)
		set_opacity(1)
	operating = FALSE
	air_update_turf(1)
	update_freelook_sight()
	if(safe)
		CheckForMobs()
	else if(!(flags_1 & ON_BORDER_1))
		crush()
	return 1

/obj/machinery/door/proc/CheckForMobs()
	if(locate(/mob/living) in get_turf(src))
		sleep(1)
		open()

/obj/machinery/door/proc/crush()
	for(var/mob/living/L in get_turf(src))
		L.visible_message(span_warning("[src] closes on [L], crushing [L.p_them()]!"), span_userdanger("[src] closes on you and crushes you!"))
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			for(var/i in C.all_wounds) // should probably replace with signal
				var/datum/wound/W = i
				W.crush(DOOR_CRUSH_DAMAGE)
		if(isalien(L))  //For xenos
			L.adjustBruteLoss(DOOR_CRUSH_DAMAGE * 1.5) //Xenos go into crit after aproximately the same amount of crushes as humans.
			L.emote("roar")
		else if(ishuman(L)) //For humans
			L.adjustBruteLoss(DOOR_CRUSH_DAMAGE)
			L.emote("scream")
			L.DefaultCombatKnockdown(100)
		else if(ismonkey(L)) //For monkeys
			L.adjustBruteLoss(DOOR_CRUSH_DAMAGE)
			L.DefaultCombatKnockdown(100)
		else //for simple_animals & borgs
			L.adjustBruteLoss(DOOR_CRUSH_DAMAGE)
		var/turf/location = get_turf(src)
		//add_blood_DNA doesn't work for borgs/xenos, but add_blood_floor does.
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			C.bleed(DOOR_CRUSH_DAMAGE)
		else
			L.add_splatter_floor(location)
	for(var/obj/mecha/M in get_turf(src))
		M.take_damage(DOOR_CRUSH_DAMAGE)

/obj/machinery/door/proc/autoclose()
	if(!QDELETED(src) && !density && !operating && !locked && !welded && autoclose)
		close()

/obj/machinery/door/proc/autoclose_in(wait)
	addtimer(CALLBACK(src,PROC_REF(autoclose)), wait, TIMER_UNIQUE | TIMER_NO_HASH_WAIT | TIMER_OVERRIDE)

/obj/machinery/door/proc/requiresID()
	return 1

/obj/machinery/door/proc/hasPower()
	return !(stat & NOPOWER)

/obj/machinery/door/proc/update_freelook_sight()
	if(!glass && GLOB.cameranet)
		GLOB.cameranet.updateVisibility(src, 0)

/obj/machinery/door/BlockThermalConductivity() // All non-glass airlocks block heat, this is intended.
	if(opacity || heat_proof)
		return 1
	return 0

/obj/machinery/door/morgue
	icon = 'icons/obj/doors/doormorgue.dmi'

/obj/machinery/door/get_dumping_location(obj/item/storage/source,mob/user)
	return null

/obj/machinery/door/proc/lock()
	return

/obj/machinery/door/proc/unlock()
	return

/obj/machinery/door/proc/hostile_lockdown(mob/origin)
	if(!stat) //So that only powered doors are closed.
		close() //Close ALL the doors!

/obj/machinery/door/proc/disable_lockdown()
	if(!stat) //Opens only powered doors.
		open() //Open everything!

/obj/machinery/door/ex_act(severity, target)
	//if it blows up a wall it should blow up a door
	..(severity ? max(1, severity - 1) : 0, target)

/obj/machinery/door/GetExplosionBlock()
	return density ? real_explosion_block : 0

/obj/machinery/door/locked
	name = "locked door"
	desc = "This door only opens after a sucessful lockpicking attempt."
	icon = 'icons/fallout/structures/doors.dmi'
	icon_state = "secure"
	explosion_block = 3
	heat_proof = TRUE
	locked = TRUE
	max_integrity = 600
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	damage_deflection = 70
	var/skill_gate = EASY_CHECK
	var/skill_roll_v = DIFFICULTY_EASY
	var/trapped_door = FALSE
	var/list/failures = list()

/obj/machinery/door/locked/update_icon()
	if(density)
		icon_state = "secure"
	else
		icon_state = "secureopen"

/obj/machinery/door/locked/do_animate(animation)
	switch(animation)
		if("opening")
			playsound(src,'sound/machines/door_open.ogg',40,1)
			flick("secure_opening", src)
		if("closing")
			playsound(src,'sound/machines/door_close.ogg',40,1)
			flick("secure_closing", src)

/obj/machinery/door/locked/easy
	trapped_door = FALSE

/obj/machinery/door/locked/easy/trapped
	trapped_door = TRUE

/obj/machinery/door/locked/regular
	skill_gate = REGULAR_CHECK
	skill_roll_v = DIFFICULTY_NORMAL

/obj/machinery/door/locked/regular/trapped
	trapped_door = TRUE

/obj/machinery/door/locked/hard
	skill_gate = HARD_CHECK
	skill_roll_v = DIFFICULTY_CHALLENGE

/obj/machinery/door/locked/hard/trapped
	trapped_door = TRUE

/obj/machinery/door/locked/expert
	skill_gate = EXPERT_CHECK
	skill_roll_v = DIFFICULTY_EXPERT

/obj/machinery/door/locked/expert/trapped
	trapped_door = TRUE

/obj/machinery/door/locked/Bumped(atom/movable/AM)
	if(src.locked || src.trapped_door)
		return
	..()
	return

/obj/machinery/door/locked/attackby(obj/item/I, mob/user, params)
	if(locked)
		if(density && istype(I, /obj/item/lockpick_set))
			if(try_to_lockpick(I, user))
				return TRUE
	else
		return ..()

/obj/machinery/door/locked/try_to_activate_door(mob/user, force_open)
	add_fingerprint(user)
	if (force_open)
		locked = FALSE
	if(!locked)
		if(density)
			open()
			if(trapped_door)
				if (user.skill_roll(SKILL_TRAPS, skill_roll_v))
					user.visible_message(span_warning("[user] manages to defuse the trap before it goes off!"), span_warning("You defuse the trap before it goes off"))
				else
					user.visible_message(span_danger("[user] trips the trap!"), span_danger("Oh no. It was trapped."))
					explosion(src, 1,2,3, flame_range = 4)
				trapped_door = FALSE
		else
			close()
		return TRUE
	if(density)
		do_animate("deny")

/obj/machinery/door/locked/try_to_lockpick(obj/item/lockpick_set/picking, mob/user)
	if(!istype(picking))
		return FALSE
	if(failures.Find(WEAKREF(user)))
		to_chat(user, span_warning("You are unable to pick this lock"))
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
	
	if(user.skill_check(SKILL_LOCKPICK, skill_gate) || user.skill_roll(SKILL_LOCKPICK, skill_roll_v))
		user.show_message(span_green(pick(pick_messages["successmessages"])))
		try_to_activate_door(user, TRUE)
		. = TRUE
	else
		user.show_message(span_alert(pick(pick_messages["failmessages"])))
		failures |= WEAKREF(user)
	picking.in_use = FALSE
	picking.use_pick(user)

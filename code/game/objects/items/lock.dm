/// This list isn't used for anything lmfao
GLOBAL_LIST_EMPTY(global_locks)

/obj/item/lock_construct
	name = "\improper lock"
	icon = 'icons/obj/lock.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/lock_data
	var/static/lock_uid = 1
	var/locked = FALSE
	var/prying = FALSE //if somebody is trying to pry us off

/obj/item/lock_construct/Initialize() // Same system machines use for UID. Could probably add a global UID for everything if you wanted and use it for shenanigans, or simpler loading.
	. = ..()
	lock_data = lock_uid++
	desc = "A heavy-duty lock for doors. It has [lock_data] engraved on it."
	GLOB.global_locks += src

/obj/item/lock_construct/Destroy()
	..()
	GLOB.global_locks -= src

/obj/item/lock_construct/attackby(obj/item/I, mob/user) // Blatantly borrowed from Baystation coders and modified for simplicity. Thanks for pointing me in that direction, Rhicora.
	if(iskey(I))
		var/obj/item/key/K = I
		if(!K.lock_data)
			to_chat(user, span_notice("You fashion \the [I] to unlock \the [src]"))
			K.lock_data = lock_data
			K.desc = "A simple key for locks. It has [K.lock_data] engraved on it."
			playsound(get_turf(src), "sound/f13items/flashlight_off.ogg", 25, FALSE, -4)
		else
			to_chat(user, span_warning("\The [I] already unlocks something..."))
		return
	if(islock(I))
		var/obj/item/lock_construct/L = I
		L.lock_data = src.lock_data
		to_chat(user, span_notice("You copy the lock from \the [src] to \the [L], making them identical."))
		L.desc = "A heavy-duty lock for doors. It has [L.lock_data] engraved on it."
		return
	..()

/obj/item/lock_construct/proc/check_key(obj/item/key/K, mob/user = null,atom/movable/D)
	if(K.lock_data == src.lock_data) //if the key matches us
		if(locked)
			user.visible_message(span_warning("[user] unlocks \the [src]."))
			locked = FALSE
		else
			user.visible_message(span_warning("[user] locks \the [src]."))
			locked = TRUE
		playsound(get_turf(src), "sound/f13items/flashlight_off.ogg", 50, FALSE)
		if(D)
			D.do_squish(0.9,0.9,0.25 SECONDS)
	else
		to_chat(user, span_warning("This is the wrong key!"))

/// Always returns true. Very cool.
/obj/item/lock_construct/proc/check_locked()
	return locked

/obj/item/lock_construct/proc/pry_off(mob/living/user, atom/A)
	if(!prying)
		user.visible_message(span_notice("[user] starts prying [src] off [A]."), \
							span_notice("You start prying [src] off [A]."))
		var/time_to_open = 50
		if(locked)
			time_to_open = 500
		playsound(src, 'sound/machines/airlock_alien_prying.ogg',100,1) //is it aliens or just the CE being a dick?
		prying = TRUE
		var/result = do_after(user, time_to_open, target = A)
		prying = FALSE
		if(result)
			user.visible_message(span_notice("[src] breaks off [A] and falls to the ground."))
			return TRUE
	return FALSE

/obj/item/key
	name = "\improper key"
	icon = 'icons/obj/key.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/lock_data = ""
	obj_flags = UNIQUE_RENAME

/obj/item/key/Initialize()
	. = ..()
	desc = "A simple key for locks. It has [src.lock_data ? src.lock_data : "nothing"] engraved on it."

/obj/item/key/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/M = I
		to_chat(user, span_notice("You begin to shape a rod into [src]..."))
		if(do_after(user, 35, target = src))
			if(M.get_amount() < 1 || !M)
				return
			var/obj/item/key/S = new /obj/item/key
			M.use(1)
			user.put_in_hands(S)
			to_chat(user, span_notice("You make a [S] identical to the old [src]."))
			S.lock_data = src.lock_data
	else
		return ..()

//// Deadbolt / Barrel Bolt / Bolt Lock / Etc
//// Basically just a keyless lock that can only be opened from one direction. Useful for mappers.

/obj/item/lock_bolt
	name = "bolt lock"
	desc = "This simple lock doesn't need a key, but it can only be manipulated from one side of a door."
	icon = 'icons/obj/lock.dmi'
	icon_state = "deadbolt_mapping"
	w_class = WEIGHT_CLASS_SMALL
	dir = SOUTH
	/// This variable will set itself, do not touch it in the map editor >:(
	var/mapped = FALSE
	var/prying = FALSE
	var/locked = FALSE

//Exclusively used for mapping rooms that should start locked.
/obj/item/lock_bolt/prelocked
	locked = TRUE

/obj/item/lock_bolt/Initialize(mapload)
	. = ..()
	icon_state = "deadbolt"
	GLOB.global_locks += src
	if(mapload && isturf(loc))//Mapped on a turf. Ignores deadbolts inside of containers and what not.
		mapped = TRUE
		var/obj/structure/simple_door/SD = locate(/obj/structure/simple_door) in loc
		if(SD && SD.can_have_lock)
			name = "[SD.name] [name]" //Give this lock a unique name so it can be tracked easier
			SD.attach_deadbolt(src, FALSE, null, mapped)

/obj/item/lock_bolt/Destroy()
	..()
	GLOB.global_locks -= src

/obj/item/lock_bolt/proc/pry_off(mob/living/user, atom/A)
	if(!prying)
		user.visible_message(span_notice("[user] starts prying [src] off [A]."), \
							span_notice("You start prying [src] off [A]."))
		var/time_to_open = 50
		if(locked)
			time_to_open = 500
		playsound(src, 'sound/machines/airlock_alien_prying.ogg',100,1) //is it aliens or just the CE being a dick?
		prying = TRUE
		var/result = do_after(user, time_to_open, target = A)
		prying = FALSE
		if(result)
			user.visible_message(span_notice("[src] breaks off [A] and falls to the ground."))
			return TRUE
	return FALSE

/obj/item/lock_bolt/proc/ToggleLock(mob/user)
	if(locked)
		user.visible_message(span_warning("[user] unlocks \the [src]."))
		locked = FALSE
	else
		user.visible_message(span_warning("[user] locks \the [src]."))
		locked = TRUE

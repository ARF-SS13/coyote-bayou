/// Some kind of thing that makes people valid

GLOBAL_LIST_EMPTY(valid_balls)
GLOBAL_LIST_EMPTY(valid_ball_spawners)

//==========DAT FUKKEN MACGUFFIN===============
/obj/item/validball
	name = "validball"
	desc = "He who holdeth thy validball be'eth a valide to yon validehunters, so say we all"
	icon = 'icons/obj/module.dmi'
	w_class = WEIGHT_CLASS_HUGE
	icon_state = "nucleardisk"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	icon_state = "datadisk0"
	w_volume = ITEM_VOLUME_DISK

	max_integrity = 250
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/datum/weakref/he_who_is_valid
	var/list/valid_ckeys = list()
	var/activated = FALSE

/obj/item/validball/Initialize()
	. = ..()
	GLOB.valid_balls |= src
	START_PROCESSING(SSobj, src)

/obj/item/validball/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/stationloving, TRUE, TRUE, FALSE, ABOVE_GROUND_Z_LEVELS)

/obj/item/validball/equipped(mob/user, slot)
	START_PROCESSING(SSobj, src)
	if(ismob(user))
		if(user.ckey && (user.ckey in valid_ckeys))
			if(isweakref(he_who_is_valid) && he_who_is_valid.resolve() == user)
				user.show_message(span_hypnophrase("Ahh, right where you left it!"))
				return
			user.show_message(span_hypnophrase("Never leave my side again!"))
		else
			user.show_message(span_hypnophrase("You feel like nobody else should touch this!"))
		valid_ckeys |= user.ckey
		he_who_is_valid = WEAKREF(user)
	if(!activated)
		activated = TRUE
		user.visible_message(span_notice("[src] stirs. Maybe it's waking up?"))
	. = ..()

/obj/item/validball/process()
	if(!QDELETED(src) && isturf(get_turf(src)))
		SEND_SIGNAL(src, COMSIG_ITEM_PROCESS)

/obj/item/validball/Destroy(force=FALSE)
	STOP_PROCESSING(SSobj, src)
	. = ..()
	GLOB.valid_balls -= src

// valid valid ball v-va valid valid ball Z
/obj/item/pinpointer/validball_finder
	name = "validball finder"
	desc = "A handheld tracking device that locks onto validballs."
	icon = 'icons/obj/device.dmi'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/pinpointer/validball_finder/attack_self(mob/living/user)
	if(active)
		active = FALSE
		user.visible_message(span_notice("[user] deactivates [user.p_their()] pinpointer."), span_notice("You deactivate your pinpointer."))
		playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
		target = null //Restarting the pinpointer forces a target reset
		STOP_PROCESSING(SSfastprocess, src)
		update_icon()
		return

	if(LAZYLEN(GLOB.valid_balls) < 1)
		user.show_message(span_alert("Nothing detected, try agan later."))
		return

	if(LAZYLEN(GLOB.valid_balls) == 1)
		target = GLOB.valid_balls[1]
	else
		target = input(user, "Artifact to track", "Pinpoint") in GLOB.valid_balls
		if(!target || QDELETED(src) || QDELETED(target) || !user || !user.is_holding(src) || user.incapacitated())
			target = null
			return

	active = TRUE
	user.visible_message(span_notice("[user] activates [user.p_their()] pinpointer."), span_notice("You activate your pinpointer."))
	playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
	START_PROCESSING(SSfastprocess, src)
	update_icon()

/obj/effect/validball_spawner
	name = "validball spawner"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x2"
	color = "#00FF00"
	var/obj/item/validball/the_thing = /obj/item/validball

/obj/effect/validball_spawner/Initialize(mapload)
	. = ..()
	add_spawner_to_list()

/obj/effect/validball_spawner/proc/add_spawner_to_list()
	if(src in GLOB.valid_ball_spawners)
		return
	GLOB.valid_ball_spawners += src

/obj/effect/validball_spawner/proc/spawn_the_thing()
	var/turf/right_here = get_turf(src)
	if(isturf(right_here))
		message_admins("Spawning [src] at [ADMIN_VERBOSEJMP(right_here)]. Validball is go!")
		new the_thing(right_here)
		return the_thing





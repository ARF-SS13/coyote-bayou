/// Some kind of thing that makes people valid


//==========DAT FUKKEN MACGUFFIN===============
/obj/item/validball
	name = "mysterious keycard"
	desc = "At first glance, it looks like your every-day run of the mill old keycard, the kind most folks would slip under a table leg \
		and forget about. But, on closer inspection, it looks clean and well taken care of, not to mention <i>active</i>. \
		You might want to hold onto this thing!"
	icon = 'icons/obj/validball.dmi'
	icon_state = "keycard_gold" // Sarge MacGuffin Keycard
	w_class = WEIGHT_CLASS_NORMAL
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

	max_integrity = 250000
	armor = ARMOR_VALUE_PA
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/datum/weakref/he_who_is_valid
	var/list/valid_ckeys = list()
	var/activated = FALSE
	///weakref in case some goob destroys it
	var/datum/weakref/our_datum_thing
	var/autoreveal_time = 3 HOURS

/obj/item/validball/Initialize()
	. = ..()
	register_vb_datum()
	addtimer(CALLBACK(src, .proc/activate_the_validball), autoreveal_time)
	SSvalidball.valid_balls |= src

/obj/item/validball/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/stationloving, TRUE, TRUE, FALSE, COMMON_Z_LEVELS)

/obj/item/validball/proc/register_vb_datum()
	var/datum/validball_data_report/vb_datum = new
	vb_datum.register_your_product(src)
	our_datum_thing = WEAKREF(vb_datum)
	SSvalidball.vb_reports |= vb_datum

/obj/item/validball/proc/activate_the_validball()
	if(activated)
		return
	activated = TRUE
	START_PROCESSING(SSobj, src)
	visible_message(span_notice("[src]'s transmitter lets out a faint beep. Anyone with a signal divination device can see where this is!"))

/obj/item/validball/proc/update_holders(mob/holder)
	if(!ismob(holder))
		return
	if(!holder.ckey)
		return
	var/turf/right_herehere = get_turf(src)
	if(!our_datum_thing)
		message_admins("[src] at [ADMIN_VERBOSEJMP(right_herehere)] didn't have a validball datum associated!!!!!!. Validball is maybe not go!")
		return
	var/datum/validball_data_report/our_report = our_datum_thing.resolve()
	if(!istype(our_report))
		message_admins("[src] at [ADMIN_VERBOSEJMP(right_herehere)] didn't resolve anything from its validball datum thing weakref!!!!!!. Validball is maybe not go!")
		return
	if(isweakref(he_who_is_valid))
		var/mob/validie = he_who_is_valid.resolve()
		if(validie == holder) // picking it back up
			holder.show_message(span_green("You maintain possession of \the [src]! Protect it at all costs!"))
			return
		holder.show_message(span_green("You've regained possession of \the [src]! Protect it at all costs!"))
		log_validball("[worldtime2text()] - [key_name(holder)] took possession of [src] from [key_name(validie)] in [AREACOORD(right_herehere)].")
	else
		holder.show_message(span_green("You've gained possession of \the [src]! Protect it at all costs!"))
		log_validball("[worldtime2text()] - [key_name(holder)] took possession of [src] for the first time at [AREACOORD(right_herehere)].")
	valid_ckeys |= holder.ckey
	he_who_is_valid = WEAKREF(holder)

/obj/item/validball/equipped(mob/user, slot)
	if(ismob(user))
		update_holders(user)
		activate_the_validball()
	. = ..()

/obj/item/validball/process()
	if(!QDELETED(src) && isturf(get_turf(src)))
		SEND_SIGNAL(src, COMSIG_ITEM_PROCESS)

/obj/item/validball/Destroy(force=FALSE)
	STOP_PROCESSING(SSobj, src)
	var/datum/validball_data_report/our_report = our_datum_thing.resolve()
	var/turf/right_heretwo = get_turf(src)
	if(!istype(our_report))
		message_admins("[src] at [ADMIN_VERBOSEJMP(right_heretwo)] didn't resolve anything from its validball datum thing weakref!!!!!!. Its also being deleted, so Validball is definitely not go!")
	var/mob/toucher = he_who_is_valid?.resolve()
	message_admins("[src] at [ADMIN_VERBOSEJMP(right_heretwo)] was destroyed, last touched by [toucher]! Validball is no longer go!!")
	our_report.set_be_destroyed()
	our_datum_thing = null
	he_who_is_valid = null
	SSvalidball.valid_balls -= src
	. = ..()

// valid valid ball v-valid valid ball finder
/obj/item/pinpointer/validball_finder
	name = "signal divination device"
	desc = "A hobby-made locator device, tuned to a range of proprietary signal frequencies believed to belong to powerful ancient artifacts. \
		While the scanner is able to detect its target through walls, it has a fairly short range, limited to around a square kilometer. \
		Rumor has it, this thing will point its user toward an object of unimaginable wealth, or power, or... something, the rumors were never \
		all too clear, but whatever it is has to be worth it, right?"
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

	var/list/active_balls = list()
	for(var/obj/item/validball/vball in SSvalidball.valid_balls)
		if(vball.activated)
			active_balls += vball

	if(LAZYLEN(active_balls) < 1)
		user.show_message(span_alert("Nothing detected, try agan later."))
		return

	if(LAZYLEN(SSvalidball.valid_balls) == 1)
		target = SSvalidball.valid_balls[1]
	else
		target = input(user, "Artifact to track", "Pinpoint") in SSvalidball.valid_balls
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
	if(src in SSvalidball.valid_ball_spawners)
		return
	SSvalidball.valid_ball_spawners += src

/obj/effect/validball_spawner/proc/spawn_the_thing()
	var/atom/spawn_here = loc
	var/turf/right_here = get_turf(src)
	if(isturf(right_here) && isatom(spawn_here))
		message_admins("Spawning [src] at [ADMIN_VERBOSEJMP(right_here)]. Validball is go!")
		var/obj/item/validball/thenewvb = new the_thing(spawn_here)
		return thenewvb
	return FALSE

/// so when going through a FUCKHUGE list, I realized, fuck it, immma just datumize it
/// Holds all the relephant data about who touched the darn thing
/datum/validball_data_report
	/// weakref to the relevant validball. weakref just in case some goober destroys it
	var/datum/weakref/the_validball
	/// weakref of the last person to touch the validball, what better way to pull their data than from the source? if they still exist
	//var/datum/weakref/last_holder
	/// Validball name!
	var/vb_name
	/// fluff
	var/vb_fluff
	/// The last one to touch the thing
	var/last_holder_name
	/// The last one to touch the thing, in ckey form
	var/last_holder_ckey
	/// Their job
	var/last_holder_job
	/// All the people who touched this thing. Includes the last holder, so, careful
	var/list/prev_holders = list()
	/// Was this thing destroyed?
	var/was_destroyed = "help"

/datum/validball_data_report/proc/register_your_product(obj/item/validball/ball)
	if(!istype(ball)) // wh
		if(src in SSvalidball.vb_reports)
			SSvalidball.vb_reports -= src
		qdel(src)
		return
	the_validball = WEAKREF(ball)
	was_destroyed = FALSE
	vb_name = ball.name
	last_holder_ckey = VB_DUMMY_CKEY

/datum/validball_data_report/proc/set_be_destroyed()
	was_destroyed = TRUE // :c

/datum/validball_data_report/proc/update_ownership(mob/user)
	if(!ismob(user))
		return
	if(!user.ckey)
		return
	//last_holder = WEAKREF(user)
	last_holder_name = user.real_name
	if(!last_holder_name || last_holder_name == "Unknown")
		last_holder_name = "Nobody in particular"
	
	last_holder_job = user.job
	if(!last_holder_job)
		last_holder_job = "resident of the wastes"

	last_holder_ckey = user.ckey
	if(!last_holder_ckey)
		last_holder_ckey = "how"

	prev_holders[last_holder_ckey] = VB_CKEY_UPDATE(user, last_holder_name, last_holder_job)


/obj/item/radio/intercom
	name = "intercom"
	desc = "Talk through this."
	icon_state = "intercom"
	plane = ABOVE_WALL_PLANE
	anchored = TRUE
	w_class = WEIGHT_CLASS_BULKY
	canhear_range = 2
	var/number = 0
	var/anyai = 1
	var/mob/living/silicon/ai/ai = list()
	var/last_tick //used to delay the powercheck
	dog_fashion = null
	var/unfastened = FALSE

/obj/item/radio/intercom/unscrewed
	unfastened = TRUE

/*/obj/item/radio/intercom/ratvar
	name = "hierophant intercom"
	desc = "A modified intercom that uses the Hierophant network instead of subspace tech. Can listen to and broadcast on any frequency."
	icon_state = "intercom_ratvar"
	freerange = TRUE

/obj/item/radio/intercom/ratvar/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/screwdriver))
		to_chat(user, span_danger("[src] is fastened to the wall with [is_servant_of_ratvar(user) ? "replicant alloy" : "some material you've never seen"], and can't be removed."))
		return //no unfastening!
	. = ..()

/obj/item/radio/intercom/ratvar/process()
	if(!istype(SSticker.mode, /datum/game_mode/clockwork_cult))
		invisibility = INVISIBILITY_OBSERVER
		alpha = 125
	else
		invisibility = initial(invisibility)
		alpha = initial(alpha)
	..()*/

/obj/item/radio/intercom/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
	START_PROCESSING(SSobj, src)

/obj/item/radio/intercom/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/radio/intercom/examine(mob/user)
	. = ..()
	if(!unfastened)
		. += span_notice("It's <b>screwed</b> and secured to the wall.")
	else
		. += span_notice("It's <i>unscrewed</i> from the wall, and can be <b>detached</b>.")

/obj/item/radio/intercom/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/screwdriver))
		if(unfastened)
			user.visible_message(span_notice("[user] starts tightening [src]'s screws..."), span_notice("You start screwing in [src]..."))
			if(I.use_tool(src, user, 30, volume=50))
				user.visible_message(span_notice("[user] tightens [src]'s screws!"), span_notice("You tighten [src]'s screws."))
				unfastened = FALSE
		else
			user.visible_message(span_notice("[user] starts loosening [src]'s screws..."), span_notice("You start unscrewing [src]..."))
			if(I.use_tool(src, user, 40, volume=50))
				user.visible_message(span_notice("[user] loosens [src]'s screws!"), span_notice("You unscrew [src], loosening it from the wall."))
				unfastened = TRUE
		return
	else if(istype(I, /obj/item/wrench))
		if(!unfastened)
			to_chat(user, span_warning("You need to unscrew [src] from the wall first!"))
			return
		user.visible_message(span_notice("[user] starts unsecuring [src]..."), span_notice("You start unsecuring [src]..."))
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 80))
			user.visible_message(span_notice("[user] unsecures [src]!"), span_notice("You detach [src] from the wall."))
			playsound(src, 'sound/items/deconstruct.ogg', 50, 1)
			new/obj/item/wallframe/intercom(get_turf(src))
			qdel(src)
		return
	return ..()

/obj/item/radio/intercom/attack_ai(mob/user)
	interact(user)

/obj/item/radio/intercom/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	interact(user)

/obj/item/radio/intercom/interact(mob/user)
	..()
	ui_interact(user, state = GLOB.default_state)

/obj/item/radio/intercom/can_receive(freq, level)
	if(!on)
		return FALSE
	if(wires.is_cut(WIRE_RX))
		return FALSE
	if(!(0 in level))
		var/turf/position = get_turf(src)
		if(isnull(position) || !(position.z in level))
			return FALSE
	if(!src.listening)
		return FALSE
	if(freq == FREQ_SYNDICATE)
		if(!(src.syndie))
			return FALSE//Prevents broadcast of messages over devices lacking the encryption

	return TRUE


/obj/item/radio/intercom/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, list/spans, message_mode, atom/movable/source)
	. = ..()
	if (message_mode == MODE_INTERCOM)
		return  // Avoid hearing the same thing twice
	if(!anyai && !(speaker in ai))
		return
	..()

/obj/item/radio/intercom/process()
	if(((world.timeofday - last_tick) > 30) || ((world.timeofday - last_tick) < 0))
		last_tick = world.timeofday

		var/area/A = get_area(src)
		if(!A)
			on = FALSE
		else
			on = A.powered(EQUIP) // set "on" to the power status

		if(!on)
			icon_state = "intercom-p"
		else
			icon_state = initial(icon_state)

/obj/item/radio/intercom/add_blood_DNA(list/blood_dna)
	return FALSE

//Created through the autolathe or through deconstructing intercoms. Can be applied to wall to make a new intercom on it!
/obj/item/wallframe/intercom
	name = "intercom frame"
	desc = "A ready-to-go intercom. Just slap it on a wall and screw it in!"
	icon_state = "intercom"
	result_path = /obj/item/radio/intercom/unscrewed
	pixel_shift = 29
	inverse = TRUE
	custom_materials = list(/datum/material/iron = 75, /datum/material/glass = 25)

/obj/item/radio/intercom/retro
	name = "vintage intercom"
	icon_state = "intercom_retro"

/obj/item/radio/intercom/retro/process()
	if(((world.timeofday - last_tick) > 30) || ((world.timeofday - last_tick) < 0))
		last_tick = world.timeofday

		var/area/A = get_area(src)
		if(!A)
			on = FALSE
		else
			on = A.powered(EQUIP) // set "on" to the power status

		if(!on)
			icon_state = "intercom_retro_on"
		else
			icon_state = initial(icon_state)

/obj/item/radio/intercom/retro/kebob
	name = "Oasis intercom"
	freqlock = TRUE
	frequency = 1369
	channels = list(RADIO_CHANNEL_TOWN = 1)

/obj/item/radio/intercom/retro/kebob/mayor
	name = "Mayor's intercom"
	use_command = TRUE
	command = TRUE

/obj/item/radio/intercom/retro/foa
	name = "Clinic intercom"
	freqlock = TRUE
	frequency = 1355
	channels = list(RADIO_CHANNEL_MEDICAL = 1)

/obj/item/radio/intercom/retro/pirate
	name = "Pirate Radio Broadcaster"
	desc = "A radio that has been hacked to send and recieve from any frequency."
	freerange = TRUE
	canhear_range = 1

/obj/item/radio/intercom/retro/bear
	name = "NCR intercom"
	freqlock = TRUE
	frequency = 1363
	channels = list(RADIO_CHANNEL_NCR = 1)

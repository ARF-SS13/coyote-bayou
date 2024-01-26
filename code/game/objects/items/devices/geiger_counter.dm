#define RAD_LEVEL_NORMAL 9
#define RAD_LEVEL_MODERATE 100
#define RAD_LEVEL_HIGH 400
#define RAD_LEVEL_VERY_HIGH 800
#define RAD_LEVEL_CRITICAL 1500

#define RAD_MEASURE_SMOOTHING 5

#define RAD_GRACE_PERIOD 10

/obj/item/geiger_counter //DISCLAIMER: I know nothing about how real-life Geiger counters work. This will not be realistic. ~Xhuis
	name = "\improper Geiger counter"
	desc = "A handheld device used for detecting and measuring radiation pulses."
	icon = 'icons/obj/device.dmi'
	icon_state = "geiger_off"
	item_state = "multitool"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BELT
	rad_flags = RAD_NO_CONTAMINATE
	custom_materials = list(/datum/material/iron = 150, /datum/material/glass = 150)

	var/grace = RAD_GRACE_PERIOD
	var/datum/looping_sound/geiger/soundloop

	var/scanning = FALSE
	var/radiation_count = 0
	var/current_tick_amount = 0
	var/last_tick_amount = 0
	var/fail_to_receive = 0
	var/current_warning = 1
	var/mob/listeningTo

/obj/item/geiger_counter/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)

/obj/item/geiger_counter/Destroy()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(soundloop)
	listeningTo = null
	return ..()

/obj/item/geiger_counter/process()
	if(!scanning)
		current_tick_amount = 0
		radiation_count = 0
		if(last_tick_amount)
			update_icon()
			update_sound()
		last_tick_amount = 0
		return

	current_tick_amount = 0
	var/area/this_area = get_area(src)
	if(this_area?.rads_per_second)
		radiation_count += this_area.rads_per_second
//	var/turf/righthere = get_turf(src)
//	var/radz = isturf(righthere) ? righthere.radiation_turf : 0
//	radiation_count += radz
	current_tick_amount += radiation_count //current_tick_amount might not be 0 because rad_act may have added additional rads before this process() tick.
	
	last_tick_amount = current_tick_amount //used to see if we need to clear a sound or icon, mostly
	update_icon()
	update_sound()
	radiation_count = 0 //reset the tally until the next process() tick

/obj/item/geiger_counter/examine(mob/user)
	. = ..()
	if(!scanning)
		return
	. += span_info("Alt-click it to clear stored radiation levels.")
	if(obj_flags & EMAGGED)
		. += span_warning("The display seems to be incomprehensible.")
		return
	switch(radiation_count)
		if(-INFINITY to RAD_LEVEL_NORMAL)
			. += span_notice("Ambient radiation level count reports that all is well.")
		if(RAD_LEVEL_NORMAL + 1 to RAD_LEVEL_MODERATE)
			. += span_disarm("Ambient radiation levels slightly above average.")
		if(RAD_LEVEL_MODERATE + 1 to RAD_LEVEL_HIGH)
			. += span_warning("Ambient radiation levels above average.")
		if(RAD_LEVEL_HIGH + 1 to RAD_LEVEL_VERY_HIGH)
			. += span_danger("Ambient radiation levels highly above average.")
		if(RAD_LEVEL_VERY_HIGH + 1 to RAD_LEVEL_CRITICAL)
			. += span_ghostalert("Ambient radiation levels nearing critical level.")
		if(RAD_LEVEL_CRITICAL + 1 to INFINITY)
			. += span_boldannounce("Ambient radiation levels above critical level!")

	. += span_notice("The last radiation amount detected was [last_tick_amount]")

/obj/item/geiger_counter/update_icon_state()
	if(!scanning)
		icon_state = "geiger_off"
	else if(obj_flags & EMAGGED)
		icon_state = "geiger_on_emag"
	else
		switch(radiation_count)
			if(-INFINITY to RAD_LEVEL_NORMAL)
				icon_state = "geiger_on_1"
			if(RAD_LEVEL_NORMAL + 1 to RAD_LEVEL_MODERATE)
				icon_state = "geiger_on_2"
			if(RAD_LEVEL_MODERATE + 1 to RAD_LEVEL_HIGH)
				icon_state = "geiger_on_3"
			if(RAD_LEVEL_HIGH + 1 to RAD_LEVEL_VERY_HIGH)
				icon_state = "geiger_on_4"
			if(RAD_LEVEL_VERY_HIGH + 1 to RAD_LEVEL_CRITICAL)
				icon_state = "geiger_on_4"
			if(RAD_LEVEL_CRITICAL + 1 to INFINITY)
				icon_state = "geiger_on_5"

/obj/item/geiger_counter/proc/update_sound()
	var/datum/looping_sound/geiger/loop = soundloop
	if(!scanning)
		loop.stop()
		return
	if(!current_tick_amount)
		loop.stop()
		return
	loop.last_radiation = current_tick_amount
	loop.start()

/obj/item/geiger_counter/rad_act(amount)
	. = ..()
	if(amount <= RAD_BACKGROUND_RADIATION || !scanning)
		return
	radiation_count += amount
	/*handled in process(), just increase the rad tally for this tick
	var/turf/theturf = get_turf(src) // fun fact, get_turf() doesnt work in the target of a signal, the define requires an actual *thing*
	var/turfrads = SEND_SIGNAL(theturf, COMSIG_TURF_CHECK_RADIATION) // filter out the turf rads, otherwise it'll double the input
	var/area/thearea = get_area(src) // Also filter out the area's radiation, its already checked in process()
	var/arearads = thearea?.rads_per_second
	radiation_count += max(0, (amount - (turfrads ? turfrads : 0) - (arearads ? arearads : 0))) // might end up considerably less than accurate per rad_act, but only around radiation barrels
	*/

/obj/item/geiger_counter/equipped(mob/user)
	. = ..()
	on_equip(user)

/obj/item/geiger_counter/proc/on_equip(mob/user)
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_ATOM_RAD_ACT)
	RegisterSignal(user, COMSIG_ATOM_RAD_ACT,PROC_REF(redirect_rad_act))
	listeningTo = user
	to_chat(user,"equipped")

/obj/item/geiger_counter/proc/redirect_rad_act(datum/source, amount)
	rad_act(amount)

/obj/item/geiger_counter/dropped(mob/user)
	on_drop(user)
	. = ..()

/obj/item/geiger_counter/proc/on_drop(mob/user)
	if(istype(loc, /obj/item/pda))
		if(listeningTo)
			UnregisterSignal(listeningTo, COMSIG_ATOM_RAD_ACT)	
		listeningTo = null
		if(isliving(loc.loc))
			listeningTo = loc.loc
	else if(!ishuman(loc))
		if(listeningTo)
			UnregisterSignal(listeningTo, COMSIG_ATOM_RAD_ACT)
		listeningTo = null

/obj/item/geiger_counter/pickup(mob/user)
	. = ..()
	on_pickup(user)

/obj/item/geiger_counter/proc/on_pickup(mob/user)
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_ATOM_RAD_ACT)
	RegisterSignal(user, COMSIG_ATOM_RAD_ACT,PROC_REF(redirect_rad_act))
	listeningTo = user

/obj/item/geiger_counter/attack_self(mob/user, silent)
	scanning = !scanning
	if(scanning)
		current_tick_amount = 0
		last_tick_amount = 0
		radiation_count = 0
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)
	update_icon()
	update_sound()
	if(!silent)
		to_chat(user, span_notice("[icon2html(src, user)] You switch [scanning ? "on" : "off"] [src]."))

/obj/item/geiger_counter/afterattack(atom/target, mob/user)
	. = ..()
	if(user.a_intent == INTENT_HELP)
		if(!(obj_flags & EMAGGED))
			user.visible_message(span_notice("[user] scans [target] with [src]."), span_notice("You scan [target]'s radiation levels with [src]..."))
			scan(target, user)
			//addtimer(CALLBACK(src,PROC_REF(scan), target, user), 20, TIMER_UNIQUE) // Let's not have spamming GetAllContents
		else
			user.visible_message(span_notice("[user] scans [target] with [src]."), span_danger("You project [src]'s stored radiation into [target]!"))
			target.rad_act(radiation_count)
			radiation_count = 0
		return TRUE

/obj/item/geiger_counter/proc/scan(atom/A, mob/user)
	if(isliving(A))
		var/mob/living/M = A
		if(!M.radiation)
			to_chat(user, span_notice("[icon2html(src, user)] Radiation levels within normal boundaries."))
		else
			to_chat(user, span_boldannounce("[icon2html(src, user)] Subject is irradiated. Radiation levels: [M.radiation] rad."))
	/* var/rad_strength = 0
	for(var/i in get_rad_contents(A)) // Yes it's intentional that you can't detect radioactive things under rad protection. Gives traitors a way to hide their glowing green rocks.
		var/atom/thing = i
		if(!thing)
			continue
		var/datum/component/radioactive/radiation = thing.GetComponent(/datum/component/radioactive)
		if(radiation)
			rad_strength += radiation.strength 
	if(rad_strength)
		to_chat(user, span_boldannounce("[icon2html(src, user)] Target contains radioactive contamination. Radioactive strength: [rad_strength]"))
	else
		to_chat(user, span_notice("[icon2html(src, user)] Target is free of radioactive contamination.")) */

/obj/item/geiger_counter/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/screwdriver) && (obj_flags & EMAGGED))
		if(scanning)
			to_chat(user, span_warning("Turn off [src] before you perform this action!"))
			return 0
		user.visible_message(span_notice("[user] unscrews [src]'s maintenance panel and begins fiddling with its innards..."), span_notice("You begin resetting [src]..."))
		if(!I.use_tool(src, user, 40, volume=50))
			return 0
		user.visible_message(span_notice("[user] refastens [src]'s maintenance panel!"), span_notice("You reset [src] to its factory settings!"))
		obj_flags &= ~EMAGGED
		radiation_count = 0
		update_icon()
		return 1
	else
		return ..()

/obj/item/geiger_counter/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(!scanning)
		to_chat(usr, span_warning("[src] must be on to reset its radiation level!"))
		return TRUE
	radiation_count = 0
	to_chat(usr, span_notice("You flush [src]'s radiation counts, resetting it to normal."))
	update_icon()
	return TRUE

/obj/item/geiger_counter/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		return
	if(scanning)
		to_chat(user, span_warning("Turn off [src] before you perform this action!"))
		return
	to_chat(user, span_warning("You override [src]'s radiation storing protocols. It will now generate small doses of radiation, and stored rads are now projected into creatures you scan."))
	obj_flags |= EMAGGED
	return TRUE

/obj/item/geiger_counter/cyborg

#undef RAD_LEVEL_NORMAL
#undef RAD_LEVEL_MODERATE
#undef RAD_LEVEL_HIGH
#undef RAD_LEVEL_VERY_HIGH
#undef RAD_LEVEL_CRITICAL

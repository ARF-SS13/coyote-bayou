#define BLENDER_GET_SUBJECT var/subject = get_subject(user);

/// just a normal every day portable blender
/obj/item/storage/blender_belt
	name = "Kitchen Buddy"
	desc = "It slices! It dices! It fits nicely on your belt! The FOODCO Maîtresse Cuisine Kitchen Buddy 2000 has everything an \
			enterprising DinnerKing could ever need! Its battery-powered Total Blender will puree virtually anything and safely \
			separate and store the results into their own little compartments. It also comes with a handy drink dispenser! \
			It's also arguably self-aware and stuck on 'broken French' for whatever reason. Enjoy!"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "portablechemicalmixer_open"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = INV_SLOTBIT_BELT
	flags_1 = CONDUCT_1 | HEAR_1
	custom_price = 2000
	custom_premium_price = 2000
	component_type = /datum/component/storage/concrete/belt/blender
	actions_types = list(
		/datum/action/item_action/blender_open_menu,
		/datum/action/item_action/blender_toggle_dispenser,
		/datum/action/item_action/blender_grind_it,
		)
	/// say hi to brevin, the spot for the beaker that'll be in this thing
	var/obj/item/reagent_containers/brevin
	/// Handy link to the massive internal beaker in the batbox
	var/obj/item/reagent_containers/glass/beaker/noreact/blender/internal_beaker
	/// Handy link to the internal component compartment
	var/obj/item/storage/box/blender_batbox/batbox
	var/amount = 30	///The amount of reagent that is to be dispensed currently
	var/grind_or_juice = BLENDER_BLENDMODE_GRIND
	/// Grindmode lets you put stuff in it and grind, dispenser mode lets you use the thing as a dispenser
	var/grind_or_dispense = BLENDER_BELTMODE_BLENDER
	/// is it running?
	var/blending = FALSE
	/// Are we putting stuff back into the hopper instead of deleting them?
	var/put_it_back = TRUE
	/// The blender's stunning personality core
	COOLDOWN_DECLARE(printer_cooldown)
	var/datum/looping_sound/blender/soundloop
	/// cus this isnt a terrible idea
	var/use_horrible_grinding_noises = FALSE

/obj/item/storage/blender_belt/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)

/obj/item/storage/blender_belt/PopulateContents()
	. = ..()
	batbox = new(src)

/obj/item/storage/blender_belt/examine(mob/user)
	. = ..()
	if(blending)
		. += span_green("It is currently [grind_or_juice]!")
	else
		switch(grind_or_dispense)
			if(BLENDER_BELTMODE_BLENDER)
				. += span_green("The blender hopper is currently unlocked and ready to grind! The dispenser, however, is locked!")
			if(BLENDER_BELTMODE_DISPENSER)
				. += span_green("The blender hopper is currently locked, and the dispenser ready to accept a drink container!")
				if(istype(brevin))
					. += span_notice("It has \a [brevin.name] in the slot.")
	var/obj/item/stock_parts/cell/battery = locate(/obj/item/stock_parts/cell) in batbox
	if(istype(battery))
		. += span_notice("The [battery] inside has [battery.percent()]% charge.")
	else
		. += span_alert("It needs a battery in its internal compartment to run!")
	var/obj/item/stock_parts/manipulator/arm = locate(/obj/item/stock_parts/manipulator) in batbox
	if(istype(arm))
		if(arm.rating > 1)
			. += span_notice("The [arm] inside will speed up processing by [(arm.rating - 1)*2] seconds.")
	else
		. += span_alert("It needs a gearset in its internal compartment to run!")

/obj/item/storage/blender_belt/Destroy()
	QDEL_NULL(internal_beaker)
	QDEL_NULL(batbox)
	QDEL_NULL(soundloop)
	return ..()

/obj/item/storage/blender_belt/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_BB_PC_TO_HOST_REQUEST,PROC_REF(handle_request))
	RegisterSignal(src, COMSIG_BB_PC_TO_HOST_IMPULSE,PROC_REF(handle_impulse))
	RegisterSignal(src, COMSIG_BB_PC_TO_HOST_CAN_INSERT,PROC_REF(can_insert))

/obj/item/storage/blender_belt/ex_act(severity, target)
	if(severity < 3)
		..()

/obj/item/storage/blender_belt/pickup(mob/user)
	. = ..()
	BLENDER_GET_SUBJECT
	SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_PICKED_UP, subject)

/obj/item/storage/blender_belt/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_BELT)
		BLENDER_GET_SUBJECT
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_EQUIPPED, subject)

/obj/item/storage/blender_belt/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers) && !(I.item_flags & ABSTRACT) && I.is_open_container() && islocked())
		var/obj/item/reagent_containers/B = I
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(B, src))
			return
		insert_beaker(user, B)
		update_icon()
		updateUsrDialog()
		return
	return ..()

/obj/item/storage/blender_belt/proc/can_insert()
	return TRUE

/obj/item/storage/blender_belt/proc/handle_request(datum/source, request)
	switch(request)
		if(REQUEST_STILL_WORKING)
			return blending
		if(REQUEST_IS_GRINDER)
			return grind_or_juice == BLENDER_BLENDMODE_GRIND
		if(REQUEST_IS_JUICER)
			return grind_or_juice == BLENDER_BLENDMODE_JUICE
		if(REQUEST_IS_DISPENSER)
			return grind_or_dispense == BLENDER_BELTMODE_DISPENSER
		if(REQUEST_IS_BLENDER)
			return grind_or_dispense == BLENDER_BELTMODE_BLENDER

/obj/item/storage/blender_belt/proc/handle_impulse(datum/source, list/impulses, mob/user)
	BLENDER_GET_SUBJECT
	var/first_impulse = LAZYACCESS(impulses, 1)
	var/second_impulse = LAZYACCESS(impulses, 2)
	if(!first_impulse)
		return
	switch(first_impulse)
		if(IMPULSE_START)
			INVOKE_ASYNC(src,PROC_REF(start_running), subject, grind_or_juice)
		if(IMPULSE_STOP)
			INVOKE_ASYNC(src,PROC_REF(stop_running))
		if(IMPULSE_SET_GRINDER)
			if(second_impulse == IMPULSE_START)
				INVOKE_ASYNC(src,PROC_REF(start_running), subject, BLENDER_BLENDMODE_GRIND)
			else
				grind_or_juice = BLENDER_BLENDMODE_GRIND
		if(IMPULSE_SET_JUICER)
			if(second_impulse == IMPULSE_START)
				INVOKE_ASYNC(src,PROC_REF(start_running), subject, BLENDER_BLENDMODE_JUICE)
			else
				grind_or_juice = BLENDER_BLENDMODE_JUICE
		if(IMPULSE_SET_GRINDER)
			INVOKE_ASYNC(src,PROC_REF(set_blender), subject)
		if(IMPULSE_SET_DISPENSER)
			INVOKE_ASYNC(src,PROC_REF(set_dispenser), subject)
		if(IMPULSE_EJECT)
			INVOKE_ASYNC(src,PROC_REF(eject_all), subject)
		if(IMPULSE_EXAMINE)
			INVOKE_ASYNC(src,PROC_REF(describe_contents), subject)
		if(IMPULSE_HORRIBLE_NOISES)
			use_horrible_grinding_noises = TRUE
	return TRUE

/obj/item/storage/blender_belt/proc/abort()
	unlock_belt()
	blending = FALSE
	soundloop.stop()

/obj/item/storage/blender_belt/proc/lock_belt(silent)
	var/was_locked = islocked()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
	SEND_SIGNAL(batbox, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
	if(!silent && !was_locked)
		var/turf/here = get_turf(src)
		here.audible_message(span_notice("[src] locks itself tight!"))

/obj/item/storage/blender_belt/proc/unlock_belt(silent)
	var/was_locked = islocked()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)
	SEND_SIGNAL(batbox, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)
	if(!silent && was_locked)
		var/turf/here = get_turf(src)
		here.audible_message(span_notice("[src] unlocks itself!"))

/obj/item/storage/blender_belt/proc/islocked()
	return (SEND_SIGNAL(src, COMSIG_IS_STORAGE_LOCKED)) && (SEND_SIGNAL(batbox, COMSIG_IS_STORAGE_LOCKED))

/obj/item/storage/blender_belt/proc/still_running()
	return blending

/obj/item/storage/blender_belt/proc/stop_running()
	blending = FALSE

/obj/item/storage/blender_belt/proc/start_running(mob/user, grindset)
	if(grindset != BLENDER_BLENDMODE_GRIND && grindset != BLENDER_BLENDMODE_JUICE)
		return
	grind_or_juice = grindset
	if(grind_or_dispense != BLENDER_BELTMODE_BLENDER)
		set_blender(user)
	blending = TRUE
	INVOKE_ASYNC(src,PROC_REF(blend_loop), user)

/obj/item/storage/blender_belt/proc/get_run_time(mob/user)
	BLENDER_GET_SUBJECT
	var/happymod = SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_AMOUR_MOD, subject)
	. = 15 SECONDS
	. -= 2*(max(check_part()-1, 0)) SECONDS
	. /= max(happymod, 0.01)
	. = clamp(., 1 SECONDS, 15 SECONDS)

/obj/item/storage/blender_belt/proc/get_charge_use(mob/user)
	BLENDER_GET_SUBJECT
	var/happymod = SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_AMOUR_MOD, subject)
	. = 50
	. += 50*(max(check_part()-1, 0))
	. /= max(happymod, 0.01)
	. = clamp(., 1, 900)

/obj/item/storage/blender_belt/proc/blend_loop(mob/user)
	BLENDER_GET_SUBJECT
	if(!can_operate(user))
		abort()
		return FALSE
	if(internal_beaker.reagents?.holder_full())
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_FULL, subject)
		abort()
		return FALSE
	var/obj/item/thing_to_blend = get_thing_to_blend()
	if(!istype(thing_to_blend))
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_NOTHING_TO_PROCESS, subject)
		abort()
		return
	if(!islocked())
		lock_belt()
	SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_PROCESSING, subject, list(BB_TOKEN_EXTRA1 = "[thing_to_blend.name]"))
	check_or_use_charge(user, FALSE)
	blending = TRUE
	if(use_horrible_grinding_noises)
		soundloop.start()
	else
		if(grind_or_juice == BLENDER_BLENDMODE_GRIND)
			playsound(src, 'sound/machines/blender.ogg', 50, 1)
		else
			playsound(src, 'sound/machines/juicer.ogg', 20, 1)
	if(!do_after(user, get_run_time(user), needhand = FALSE, target = src, extra_checks = CALLBACK(src,PROC_REF(still_running)), allow_movement = TRUE))
		if(blending)
			SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_ROCKY_ABORT, subject)
		else
			SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_SOFT_ABORT, subject)
		abort()
		return FALSE
	if(!grind_thing(user, thing_to_blend))
		abort()
		return FALSE
	/// check if we're actually done
	var/anything = get_thing_to_blend()
	if(!anything)
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_DONE_BLENDING, subject)
		abort()
		return FALSE
	if(internal_beaker.reagents?.holder_full())
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_FULL_SECOND, subject)
		abort()
		return FALSE
	INVOKE_ASYNC(src,PROC_REF(blend_loop), user) // and loop!
	
/obj/item/storage/blender_belt/proc/get_thing_to_blend(mob/user)
	for(var/obj/item/thing in contents)
		if(thing == batbox)
			continue // no grinding our battery!
		if(!can_blend_thing(user, thing))
			continue
		return thing

/obj/item/storage/blender_belt/proc/grind_thing(mob/user, obj/item/thing)
	BLENDER_GET_SUBJECT
	switch(grind_or_juice)
		if(BLENDER_BLENDMODE_GRIND)
			switch(thing.on_grind(src))
				if(-1)
					SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_GRINDFAIL, subject)
					dump_thing(user, thing, TRUE)
					return FALSE
		if(BLENDER_BLENDMODE_JUICE)
			switch(thing.on_juice(src))
				if(-1)
					SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_GRINDFAIL, subject)
					dump_thing(user, thing, TRUE)
					return FALSE
	if(!istype(internal_beaker))
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_BUFFER_GONE, subject)
		return FALSE
	switch(grind_or_juice)
		if(BLENDER_BLENDMODE_GRIND)
			internal_beaker.reagents.add_reagent_list(thing.grind_results)
		if(BLENDER_BLENDMODE_JUICE)
			internal_beaker.reagents.add_reagent_list(thing.juice_results)
	if(thing.reagents)
		thing.reagents.trans_to(internal_beaker, thing.reagents.total_volume)
	var/partial_juice
	if(thing.reagents?.total_volume > 0 && IS_FINITE(thing.reagents.total_volume))
		partial_juice = TRUE
	destroy_thing(user, thing, FALSE, partial_juice)
	return TRUE

/obj/item/storage/blender_belt/proc/destroy_thing(mob/user, obj/item/thing, silent, still_juicy)
	if(!thing)
		return
	var/turf/here = get_turf(src)
	if(!should_destroy(thing) || still_juicy)
		dump_thing(user, thing, FALSE, TRUE)
		if(!silent)
			here.visible_message(span_notice("[src] extracts everything it can from [thing], then drops it on the ground!"))
		if(still_juicy && !CHECK_BITFIELD(thing.item_flags, BEEN_JUICED))
			thing.desc += "<br>Looks like it has been run through a blender!"
			ENABLE_BITFIELD(thing.item_flags, BEEN_JUICED)
		return
	if(!silent)
		here.visible_message(span_notice("[src] grinds [thing] up!"))
	qdel(thing)

/obj/item/storage/blender_belt/proc/can_blend_thing(mob/user, obj/item/thing, silent)
	BLENDER_GET_SUBJECT
	if(!istype(thing))
		return FALSE
	if(istype(thing, /obj/item/clothing/head/mob_holder))
		if(!silent)
			SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_RAT_BLENDER, subject)
		dump_thing(user, thing)
		return FALSE
	var/failmode = thing.grind_requirements(src, FALSE)
	switch(failmode)
		if(GRIND_IS_CYBORG)
			SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_CYBORG_PART, subject)
			return FALSE
		if(GRIND_NEEDS_DRY)
			SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_DRY_FIRST, subject)
			return FALSE
	return TRUE

/obj/item/storage/blender_belt/proc/should_destroy(obj/item/thing)
	if(istype(thing, /obj/item/reagent_containers/glass))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/syringe))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/dropper))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/medspray))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/spray))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/blood))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/rag))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/chem_pack))
		return FALSE
	return TRUE

/obj/item/storage/blender_belt/proc/dump_thing(mob/user, obj/item/thing, violently, silent)
	if(!istype(thing))
		return
	var/turf/here = get_turf(src)
	if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, thing, here, FALSE))
		if(!silent)
			BLENDER_GET_SUBJECT
			SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_STUCK_INSIDE, subject)
		return FALSE
	if(violently)
		thing.throw_at(get_ranged_target_turf(thing, pick(GLOB.cardinals), 3, 3), 5, null)
		if(!silent)
			here.visible_message(span_alert("[src] flings [thing] right out!"))
	else
		if(!silent)
			here.visible_message(span_alert("[src] drops [thing] on the [here]!"))
	return TRUE

/obj/item/storage/blender_belt/proc/check_or_use_charge(mob/user, just_check)
	//first, find our power cell
	if(!batbox) // okay first actually, check if the batbox is there
		return
	BLENDER_GET_SUBJECT
	var/power_use = get_charge_use(subject)
	for(var/obj/item/stock_parts/cell/powa in batbox.contents)
		if(just_check) // and check/use some power
			return powa.check_charge(power_use)
		return powa.use(power_use)
	return FALSE

/obj/item/storage/blender_belt/proc/can_operate(mob/user, silent)
	var/codederreur
	. = TRUE
	if(!batbox)
		codederreur = STIMULUS_BATBOX_GONE
		. = FALSE
	if(batbox.loc != src) // gotta be *in* the thing
		codederreur = STIMULUS_BATBOX_ELSEWHERE
		. = FALSE
	if(!check_or_use_charge(user, TRUE))
		codederreur = STIMULUS_LOW_POWER
		. = FALSE
	if(!istype(internal_beaker))
		codederreur = STIMULUS_BUFFER_GONE
		. = FALSE
	if(internal_beaker.loc != batbox)
		codederreur = STIMULUS_BUFFER_ELSEWHERE
		. = FALSE
	if(!check_part())
		codederreur = STIMULUS_PART_MISSING
		. = FALSE
	if(!silent && codederreur)
		BLENDER_GET_SUBJECT
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, codederreur, subject)

/obj/item/storage/blender_belt/proc/check_part()
	if(!istype(batbox))
		return FALSE
	for(var/obj/item/stock_parts/manipulator/grabby in batbox.contents)
		return grabby.rating
	return FALSE

/datum/action/item_action/blender_open_menu
	name = "Open Blender Control Panel"
	desc = "Open the Blender Belt's control panel."

/datum/action/item_action/blender_open_menu/Trigger()
	var/obj/item/storage/blender_belt/blent = target
	if(istype(blent))
		blent.open_blender_controlpanel(owner)
		return

/datum/action/item_action/blender_toggle_dispenser
	name = "Engage Dispenser Mode"
	desc = "Seals the Blender Belt up and enables its reagent dispenser."

/datum/action/item_action/blender_toggle_dispenser/Trigger()
	var/obj/item/storage/blender_belt/blent = target
	if(istype(blent))
		blent.toggle_dispenser_mode(owner)
		if(blent.grind_or_dispense == BLENDER_BELTMODE_DISPENSER)
			name = "Engage Grinder Mode"
			desc = "Disables the dispenser and enables its blender."
		else
			name = initial(name)
			desc = initial(desc)

/datum/action/item_action/blender_grind_it
	name = "GRIND/JUICE"
	desc = "Answer the question: will it blend?"

/datum/action/item_action/blender_grind_it/Trigger()
	var/obj/item/storage/blender_belt/blent = target
	if(istype(blent))
		if(blent.blending)
			blent.stop_running()
			return
		blent.open_blender_grindpanel(owner)
		return

/obj/item/storage/blender_belt/proc/open_blender_grindpanel(mob/user)
	if(blending || !user.canUseTopic(src))
		return
	var/static/blender_grind = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_grind")
	var/static/blender_juice = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_juice")

	var/list/options = list()
	options["GRIND"] = blender_grind
	options["JUICE"] = blender_juice
	var/choice = show_radial_menu(user, src, options, require_near = !hasSiliconAccessInArea(user))
	switch(choice)
		if("GRIND")
			start_running(user, BLENDER_BLENDMODE_GRIND)
		if("JUICE")
			start_running(user, BLENDER_BLENDMODE_JUICE)

/obj/item/storage/blender_belt/proc/open_blender_controlpanel(mob/user)
	if(blending || !user.canUseTopic(src))
		return

	var/list/options = list()
	var/static/blender_examine = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_examine")
	var/static/blender_eject = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_eject")
	options["eject everything"] = blender_eject
	options["examine contents"] = blender_examine
	var/choice = show_radial_menu(user, src, options, require_near = !hasSiliconAccessInArea(user))

	// post choice verification
	if(blending || !user.canUseTopic(src))
		return

	switch(choice)
		if("eject everything")
			eject_all(user)
		if("examine contents")
			describe_contents(user)

/obj/item/storage/blender_belt/proc/eject_all(mob/user)
	BLENDER_GET_SUBJECT
	if(user)
		user.visible_message(span_notice("[user] presses the eject everything button!"))
	var/list/what_drop = list()
	for(var/obj/item/thingy in contents)
		if(thingy == batbox)
			continue // no grinding our battery!
		if(HAS_TRAIT(thingy, TRAIT_NO_STORAGE_REMOVE))
			continue
		what_drop |= thingy
	if(!LAZYLEN(what_drop))
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_NOTHING_TO_EJECT, subject)
		return
	var/yeet = prob(10)
	for(var/obj/item/dingy in what_drop)
		if(dump_thing(user, dingy, yeet, TRUE))
			what_drop -= dingy
	if(LAZYLEN(what_drop))
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_CANT_DROP_THING, subject)
		return
	if(istype(brevin))
		eject_beaker(user)
	if(yeet)
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_YEET, subject)
		return
	SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_DUMP, subject)

/obj/item/storage/blender_belt/proc/toggle_dispenser_mode(mob/user)
	if(blending)
		BLENDER_GET_SUBJECT
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_CANT_CHANGE_WHILE_BLENDING, subject)
		return
	switch(grind_or_dispense)
		if(BLENDER_BELTMODE_DISPENSER)
			set_blender(user)
		if(BLENDER_BELTMODE_BLENDER)
			set_dispenser(user)

/obj/item/storage/blender_belt/proc/set_dispenser(mob/user)
	BLENDER_GET_SUBJECT
	if(user)
		user.show_message(span_notice("You flip the switch on [src] to DISPENSER mode."))
	grind_or_dispense = BLENDER_BELTMODE_DISPENSER
	SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_SET_TO_DISPENSER, subject)
	lock_belt()

/obj/item/storage/blender_belt/proc/set_blender(mob/user)
	BLENDER_GET_SUBJECT
	if(user)
		user.show_message(span_notice("You flip the switch on [src] to BLENDER mode."))
	if(istype(brevin))
		eject_beaker(user, silent = TRUE)
	grind_or_dispense = BLENDER_BELTMODE_BLENDER
	SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_SET_TO_BLENDER, subject)
	close_window(user)
	unlock_belt()

/obj/item/storage/blender_belt/proc/describe_contents(mob/user)
	BLENDER_GET_SUBJECT
	if(!istype(internal_beaker))
		return
	if(internal_beaker.reagents.total_volume <= 0)
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_EXAMINE_EMPTY, subject)
		return
	if(!COOLDOWN_FINISHED(src, printer_cooldown))
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_EXAMINE_PAPER_COOLDOWN, subject)
		return
	COOLDOWN_START(src, printer_cooldown, 10 SECONDS)
	SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_EXAMINE_OKAY, subject)
	print_contents(user)

/obj/item/storage/blender_belt/proc/print_contents(mob/user)
	var/obj/item/paper/our_paper = new(get_turf(src))
	if(!our_paper)
		return FALSE
	our_paper.info += "<br>"
	our_paper.info += write_contents()
	our_paper.update_icon_state()
	playsound(src, 'sound/machines/printer_thermal.ogg', 50, 1)
	if(ismob(user))
		user.put_in_hands(our_paper)
	else
		var/turf/the_here = get_turf(src)
		our_paper.forceMove(the_here)
	return TRUE

/obj/item/storage/blender_belt/proc/write_contents()
	if(!istype(internal_beaker))
		return
	var/list/msg_out = list()
	msg_out += "<hr><br>"
	msg_out += "<center>- START REPORT -</center><br>"
	msg_out += "<center>- [span_small(uppertext(STATION_TIME_TIMESTAMP(FALSE, world.time)))] -</center><br>"
	msg_out += "<u><b>FOODCO Maîtresse Cuisine Kitchen Buddy 2000</b></u><br>"
	msg_out += "[FOURSPACES]La gastronomie simplifiée!<br>"
	msg_out += "<hr><br>"
	if(internal_beaker.reagents.total_volume > 0)
		for(var/datum/reagent/goo in internal_beaker.reagents.reagent_list)
			msg_out += "\t[goo.name] - ([goo.volume]u)<br>"
			msg_out += "[goo.description]<br>"
			msg_out += "Ça a le goût de: [goo.taste_description]<br>"
			msg_out += "Le pH est: [goo.pH]<br>"
			if(goo.ghoulfriendly)
				msg_out += "Les morts-vivants adorent ça!<br>"
			if(goo.synth_metabolism_use_human)
				msg_out += "Les robots adorent ça!<br>"
			if(goo.overdose_threshold)
				msg_out += "Une dose de [goo.overdose_threshold]u serait une overdose!<br>"
			if(goo.value)
				msg_out += "Le centre marchand paierait [goo.value] crédits par unité<br>"
			msg_out += "<br>"
	else
		msg_out += "Rien ici!<br>"
	msg_out += "<center>Bon appetit!</center><br>"
	msg_out += "<center>- END OF REPORT -</center><br>"
	return span_robot(msg_out.Join())

/obj/item/storage/blender_belt/proc/eject_beaker(mob/user, silent)
	BLENDER_GET_SUBJECT
	if(!istype(brevin))
		return
	brevin.forceMove(get_turf(src))
	if(user)
		user.put_in_hands(brevin)
		if(!silent)
			user.show_message(span_notice("You take [brevin] out of [src]."))
			SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_EJECT_BREVIN, subject, list(BB_TOKEN_EXTRA1 = "[brevin.name]"))
	brevin = null
	update_icon()

/obj/item/storage/blender_belt/proc/insert_beaker(mob/user, obj/item/reagent_containers/new_brevin, silent)
	BLENDER_GET_SUBJECT
	if(!istype(new_brevin))
		return
	var/obj/item/reagent_containers/old_brevin = brevin
	if(brevin)
		brevin.forceMove(get_turf(src))
		brevin = null
	if(!user.transferItemToLoc(new_brevin, src))
		return
	brevin = new_brevin
	update_icon()
	if(old_brevin)
		user.put_in_hands(old_brevin)
		user.show_message(span_notice("You swap out the beakers."))
		SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_SWAP_BREVIN, subject, list(BB_TOKEN_EXTRA1 = "[old_brevin.name]", BB_TOKEN_EXTRA2 = "[brevin.name]"))
		return
	user.show_message(span_notice("You insert [brevin]."))
	SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_INSERT_BREVIN, subject, list(BB_TOKEN_EXTRA1 = "[brevin.name]"))
	
/obj/item/storage/blender_belt/proc/get_subject(user)
	if(ismob(user))
		return user
	if(ismob(loc))
		return loc
	for(var/mob/anyone in range(2, src))
		return anyone
	return "???"

/obj/item/storage/blender_belt/update_icon_state()
	if(grind_or_dispense == BLENDER_BELTMODE_BLENDER)
		icon_state = "portablechemicalmixer_open"
	else if(brevin)
		icon_state = "portablechemicalmixer_full"
	else
		icon_state = "portablechemicalmixer_empty"

/obj/item/storage/blender_belt/AltClick(mob/living/user)
	if(grind_or_dispense == BLENDER_BELTMODE_DISPENSER)
		eject_beaker(user)
		update_icon()
	else
		..()

/obj/item/storage/blender_belt/attack_hand(mob/user)
	if(grind_or_dispense == BLENDER_BELTMODE_DISPENSER && ismob(loc))
		INVOKE_ASYNC(src, TYPE_PROC_REF(/datum,ui_interact), user)
	else
		. = ..()

/obj/item/storage/blender_belt/attack_self(mob/user)
	if(loc != user)
		return
	if(grind_or_dispense == BLENDER_BELTMODE_DISPENSER)
		ui_interact(user)
		return
	else
		. = ..()

/obj/item/storage/blender_belt/MouseDrop(obj/over_object)
	. = ..()
	if(!ismob(loc))
		return
	var/mob/M = loc
	if(!M.incapacitated(allow_crit = TRUE) && istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(src, H.held_index)

/obj/item/storage/blender_belt/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PortableBlenderBelt", name)
		if(user.hallucinating())
			// to not ruin the immersion by constantly changing the fake chemicals
			ui.set_autoupdate(FALSE)
		ui.open()

/obj/item/storage/blender_belt/proc/close_window(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(ui)
		ui.close()

/obj/item/storage/blender_belt/ui_data(mob/user)
	var/list/data = list()
	data["amount"] = amount
	data["isBeakerLoaded"] = brevin ? 1 : 0
	data["beakerCurrentVolume"] = brevin ? brevin.reagents.total_volume : null
	data["beakerMaxVolume"] = brevin ? brevin.volume : null
	data["putItBack"] = put_it_back
	data["beakerTransferAmounts"] = brevin ? brevin.possible_transfer_amounts : null
	data["bufferVolume"] = internal_beaker?.reagents.total_volume
	data["bufferMaxVolume"] = max(internal_beaker?.reagents.maximum_volume, 1)
	var/bufferContents[0]
	if(internal_beaker?.reagents.total_volume)
		for(var/datum/reagent/N in internal_beaker.reagents.reagent_list)
			bufferContents.Add(list(list("name" = N.name, "id" = ckey(N.name), "volume" = N.volume))) // ^
	data["chemicals"] = bufferContents
	var/beakerContents[0]
	if(brevin)
		for(var/datum/reagent/R in brevin.reagents.reagent_list)
			beakerContents.Add(list(list("name" = R.name, "id" = ckey(R.name), "volume" = R.volume))) // list in a list because Byond merges the first list...
	data["beakerContents"] = beakerContents
	return data

/obj/item/storage/blender_belt/ui_act(action, params)
	if(..())
		return
	if(!istype(brevin))
		return
	switch(action)
		if("amount")
			var/target = text2num(params["target"])
			amount = target
			. = TRUE
		if("dispense")
			var/datum/reagents/dest = brevin.reagents
			if(dest.holder_full())
				SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_BREVIN_FULL, loc, list(brevin))
				return
			var/the_reagent = GLOB.name2reagent[params["reagent"]]
			var/datum/reagents/source = internal_beaker.reagents
			if(!source.has_reagent(the_reagent))
				SEND_SIGNAL(src, COMSIG_BB_HOST_TO_PC_STIMULUS, STIMULUS_REAGENT_NOT_FOUND, loc)
				return
			source.trans_id_to(brevin, the_reagent, amount) // the proc already handles the measurements
			. = TRUE
		if("remove")
			if(put_it_back)
				var/to_transfer = text2num(params["amount"])
				var/loops = 1
				while(to_transfer > 0)
					for(var/datum/reagent/N in brevin.reagents.reagent_list)
						brevin.reagents.trans_id_to(internal_beaker, N.type, 1)
						to_transfer--
					if(!LAZYLEN(brevin.reagents.reagent_list))
						break
					if(brevin.reagents.total_volume <= 0)
						break
					if(loops++ > 300)
						break
				. = TRUE
			else
				var/amount = text2num(params["amount"])
				brevin.reagents.remove_all(amount)
				. = TRUE
		if("eject")
			eject_beaker(usr)
			update_icon()
			. = TRUE
		if("toggle_putback")
			put_it_back = !put_it_back
			update_icon()
			. = TRUE

/// The blender itself
/datum/component/storage/concrete/belt/blender
	max_items = STORAGE_BELT_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_BELT_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BELT_SPECIALIZED_MAX_TOTAL_SPACE
	max_volume = STORAGE_BELT_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/blender_machinery
	max_items = 4 // battery, manipulator, core, + beaker. Beaker/core cant be removed, so really 2
	max_w_class = STORAGE_BOX_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	quota = list(
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/cell = 1,
		/obj/item/persona_core = 1,
		)

/datum/component/storage/concrete/blender_machinery/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/stock_parts/cell, /obj/item/stock_parts/manipulator, /obj/item/persona_core))

/obj/item/storage/box/blender_batbox
	name = "Internal component compartment"
	desc = "The internal component compartment of a FOODCO Maîtresse Cuisine Kitchen Buddy 2000. It houses the integrated \
			Chem-MAX Pro FoodBuddy separa-duct alongside storage for just about any kind of battery. This thing is part of \
			the Kitchen Buddy, and thus can not (and should not) be removed. If it <i>is</i> somehow removed, please call the \
			DEFCON-1 Existential Security Office at 1-800-IM-CODER when convenient."
	icon_state = "idOld"
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_ALT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	component_type = /datum/component/storage/concrete/blender_machinery

/obj/item/storage/box/blender_batbox/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, src)
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/storage/box/blender_batbox/PopulateContents()
	. = ..()
	if(!istype(loc, /obj/item/storage/blender_belt))
		relay_msg_admins("[src] didn't spawn in a blender belt! Dan probably messed something up!")
	else
		var/obj/item/storage/blender_belt/our_home = loc
		our_home.internal_beaker = new(src) // spawn the beaker
		new /obj/item/stock_parts/cell/upgraded(src) // spawn the cell
		new /obj/item/stock_parts/manipulator/simple(src) // spawn the part
		var/obj/item/persona_core/our_core = new(src) // spawn the core
		our_core.register_master(loc, loc) // register the core to the blender
	
/obj/item/storage/box/blender_batbox/Destroy()
	if(istype(loc, /obj/item/storage/blender_belt))
		var/obj/item/storage/blender_belt/our_home = loc
		our_home.internal_beaker = null
		our_home.batbox = null
	. = ..()

/obj/item/reagent_containers/glass/beaker/noreact/blender
	name = "FoodBuddy separa-duct"
	desc = "An internal material hopper designed with countless non-reactive storage compartments that keep everything separated. \
		Nothing in here will react with each other, though it does make removing the contents a bit tricky. \
		Cannot be removed from its housing (though if you somehow do, be sure to call the helpline at 1-800-IM-CODER)<br> \
		Holds 300 units."
	icon_state = "beakernoreact"
	custom_materials = list(/datum/material/iron=3000)
	reagent_flags = TRANSPARENT | REFILLABLE | NO_REACT // dump stuff in, cant take it out easily - also, no reaction!
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	volume = 300
	amount_per_transfer_from_this = 10
	container_flags = NONE // unaffected by PH and Temp, probably (cus this thing reall shouldnt be destroyed at all)
	container_HP = 10//shouldn't be needed

/obj/item/reagent_containers/glass/beaker/noreact/blender/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, src)
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/storage/backpack/debug_blender
	name = "Bag of Blenderstuff"
	desc = "Cool shit for testing various gblender!"

/obj/item/storage/backpack/debug_blender/PopulateContents()
	. = ..()
	new /obj/item/storage/blender_belt(src)
	new /obj/item/clothing/under/shorts(src)
	new /obj/item/reagent_containers/glass/beaker(src)
	new /obj/item/reagent_containers/glass/beaker(src)
	new /obj/item/stock_parts/cell/upgraded(src)
	new /obj/item/stock_parts/cell/upgraded(src)
	new /obj/item/storage/belt/military/snack(src)
	new /obj/item/storage/belt/military/snack(src)
	new /obj/item/stock_parts/manipulator/simple(src)
	new /obj/item/stock_parts/manipulator/simple(src)
	new /obj/item/stock_parts/manipulator/femto(src)
	new /obj/item/stock_parts/manipulator/femto(src)
	new /obj/item/stock_parts/manipulator/nano(src)
	new /obj/item/stock_parts/manipulator/nano(src)
	new /obj/item/stock_parts/manipulator/pico(src)
	new /obj/item/stock_parts/manipulator/pico(src)

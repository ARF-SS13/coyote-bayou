/datum/element/mob_holder
	element_flags = ELEMENT_BESPOKE|ELEMENT_DETACH
	id_arg_index = 2
	var/worn_state
	var/alt_worn
	var/right_hand
	var/left_hand
	var/inv_slots
	var/proctype //if present, will be invoked on headwear generation.
	var/escape_on_find = FALSE //if present, will be released upon the item being 'found' (i.e. opening a container or pocket with it present)

/datum/element/mob_holder/Attach(datum/target, worn_state, alt_worn, right_hand, left_hand, inv_slots = NONE, proctype, escape_on_find)
	. = ..()

	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE

	src.worn_state = worn_state
	src.alt_worn = alt_worn
	src.right_hand = right_hand
	src.left_hand = left_hand
	src.inv_slots = inv_slots
	src.proctype = proctype
	src.escape_on_find = escape_on_find

	RegisterSignal(target, COMSIG_CLICK_ALT,PROC_REF(mob_try_pickup), override = TRUE)
	RegisterSignal(target, COMSIG_PARENT_EXAMINE,PROC_REF(on_examine), override = TRUE)

/datum/element/mob_holder/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_CLICK_ALT)
	UnregisterSignal(source, COMSIG_PARENT_EXAMINE)

/datum/element/mob_holder/proc/on_examine(mob/living/source, mob/user, list/examine_list)
	if(ishuman(user) && !istype(source.loc, /obj/item/clothing/head/mob_holder))
		examine_list += span_notice("Looks like [source.p_they(TRUE)] can be picked up with <b>Alt+Click</b>! Maybe check in LOOC before just doing so though.")

/datum/element/mob_holder/proc/mob_try_pickup(mob/living/source, mob/user)
	if(!user.Adjacent(source) || user.incapacitated())
		return FALSE
	if(isanimal(user))
		var/mob/living/simple_animal/S = user
		if(!S.dextrous)
			to_chat(user, span_warning("You aren't dextrous enough to do that!"))
			return FALSE
	else if(!ishuman(user))
		return FALSE
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are full!"))
		return FALSE
	if(source.buckled)
		to_chat(user, span_warning("[source] is buckled to something!"))
		return FALSE
	if(source == user)
		to_chat(user, span_warning("You can't pick yourself up."))
		return FALSE
	source.visible_message(span_warning("[user] starts picking up [source]."), \
					span_userdanger("[user] starts picking you up!"))
	if(!do_after(user, 60, target = source) || source.buckled)
		return FALSE

	source.visible_message(span_warning("[user] picks up [source]!"), \
					span_userdanger("[user] picks you up!"))
	to_chat(user, span_notice("You pick [source] up."))
	// source.drop_all_held_items()
	var/obj/item/clothing/head/mob_holder/holder = new(get_turf(source), source, worn_state, alt_worn, right_hand, left_hand, inv_slots)
	holder.escape_on_find = escape_on_find
	holder.associate(user)

	if(proctype)
		INVOKE_ASYNC(src, proctype, source, holder, user)
	user.put_in_hands(holder)
	return TRUE

/datum/element/mob_holder/proc/drone_worn_icon(mob/living/simple_animal/drone/D, obj/item/clothing/head/mob_holder/holder, mob/user)
	var/new_state = "[D.visualAppearence]_hat"
	holder.item_state = new_state
	holder.icon_state = new_state


//The item itself,
/obj/item/clothing/head/mob_holder
	name = "bugged mob"
	desc = "Yell at coderbrush."
	icon = null
	mob_overlay_icon = 'icons/mob/animals_held.dmi'
	righthand_file = 'icons/mob/animals_held_rh.dmi'
	lefthand_file = 'icons/mob/animals_held_lh.dmi'
	icon_state = ""
	slot_flags = INV_SLOTBIT_OCLOTHING | INV_SLOTBIT_ICLOTHING | INV_SLOTBIT_GLOVES | INV_SLOTBIT_EYES | INV_SLOTBIT_EARS | INV_SLOTBIT_MASK | INV_SLOTBIT_HEAD | INV_SLOTBIT_FEET | INV_SLOTBIT_ID | INV_SLOTBIT_BELT | INV_SLOTBIT_BACK | INV_SLOTBIT_POCKET | INV_SLOTBIT_NECK | INV_SLOTBIT_HANDS | INV_SLOTBIT_BACKPACK | INV_SLOTBIT_SUITSTORE // where can they be stuffed? yes
	w_class = WEIGHT_CLASS_NORMAL
	dynamic_hair_suffix = ""
	var/mob/living/held_mob
	var/escape_on_find
	/// the mob that picked us up!
	var/datum/weakref/carrier
	force = 25
	force_wielded = 35
	force_unwielded = 25
	slowdown = 0.1
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/clothing/head/mob_holder/Initialize(mapload, mob/living/target, worn_state, alt_worn, right_hand, left_hand, slots = NONE)
	. = ..()

	if(target)
		assimilate(target)

	if(alt_worn)
		mob_overlay_icon = alt_worn
	if(worn_state)
		item_state = worn_state
		icon_state = worn_state
	if(left_hand)
		lefthand_file = left_hand
	if(right_hand)
		righthand_file = right_hand
	// slot_flags = slots

/obj/item/clothing/head/mob_holder/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_VORE_ATOM_DEVOURED,PROC_REF(release_into_belly))
	RegisterSignal(src, COMSIG_VORE_CAN_EAT,PROC_REF(relay_caneat))
	RegisterSignal(src, COMSIG_VORE_CAN_BE_EATEN,PROC_REF(relay_can_be_eaten))
	RegisterSignal(src, COMSIG_VORE_CAN_BE_FED_PREY,PROC_REF(relay_can_be_fed))
	RegisterSignal(src, COMSIG_VORE_SNIFF_LIVING,PROC_REF(relay_sniff))

/obj/item/clothing/head/mob_holder/proc/relay_caneat()
	return SEND_SIGNAL(held_mob, COMSIG_VORE_CAN_EAT)

/obj/item/clothing/head/mob_holder/proc/relay_can_be_eaten()
	return SEND_SIGNAL(held_mob, COMSIG_VORE_CAN_BE_EATEN)

/obj/item/clothing/head/mob_holder/proc/relay_can_be_fed()
	return SEND_SIGNAL(held_mob, COMSIG_VORE_CAN_BE_FED_PREY)

/obj/item/clothing/head/mob_holder/proc/relay_sniff(datum/source, mob/living/living_sniffer)
	return SEND_SIGNAL(held_mob, COMSIG_VORE_SNIFF_LIVING, living_sniffer)

/obj/item/clothing/head/mob_holder/proc/assimilate(mob/living/target)
	target.setDir(SOUTH)
	held_mob = target
	target.forceMove(src)
	var/image/I = new //work around to retain the same appearance to the mob idependently from inhands/worn states.
	I.appearance = target.appearance
	I.layer = FLOAT_LAYER //So it doesn't get screwed up by layer overrides.
	I.plane = FLOAT_PLANE //Same as above but for planes.
	I.override = TRUE
	add_overlay(I)
	name = target.name
	desc = target.desc
	// switch(target.mob_size)
	// 	if(MOB_SIZE_TINY)
	// 		w_class = WEIGHT_CLASS_TINY
	// 	if(MOB_SIZE_SMALL)
	// 		w_class = WEIGHT_CLASS_NORMAL
	// 	if(MOB_SIZE_LARGE)
	// 		w_class = WEIGHT_CLASS_HUGE

/obj/item/clothing/head/mob_holder/Destroy()
	if(held_mob)
		release()
	return ..()

/obj/item/clothing/head/mob_holder/examine(mob/user)
	return held_mob?.examine(user) || ..()

/obj/item/clothing/head/mob_holder/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(held_mob)
		return held_mob.attackby(W, user, params) // smeck


/obj/item/clothing/head/mob_holder/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if(AM == held_mob)
		held_mob.reset_perspective()
		held_mob = null
		QDEL_IN(src, 1) //To avoid a qdel loop.

/obj/item/clothing/head/mob_holder/Entered(atom/movable/AM, atom/newloc)
	. = ..()
	if(AM != held_mob)
		var/destination = loc
		if(isliving(loc)) //the mob is held or worn, drop things on the floor
			destination = get_turf(loc)
		AM.forceMove(destination)

/obj/item/clothing/head/mob_holder/proc/associate(mob/living/grabber)
	if(!istype(grabber))
		return
	carrier = WEAKREF(grabber)
	RegisterSignal(grabber, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(pass_damage)) // OUR APC IS UNDER ATTACK
	RegisterSignal(grabber, COMSIG_MOB_DEATH, PROC_REF(TheirDeathRelease)) // Oh no im dead
	if(!held_mob)
		return
	RegisterSignal(held_mob, COMSIG_MOB_DEATH, PROC_REF(MyDeathRelease)) // Oh no im dead 2

/obj/item/clothing/head/mob_holder/dropped(mob/user)
	. = ..()
	if(held_mob && !ismob(loc) && !istype(loc,/obj/item/storage))//don't release on soft-drops
		release()

/obj/item/clothing/head/mob_holder/AllowClick()
	. = ..()
	if(isliving(loc)) // held or worn, but not in a sack or in outer space
		var/mob/living/hodler = loc
		return hodler.loc.AllowClick() // let the lil rat sit in your cleavage with a rifle and snipe people

/// generic drop-me-now function called by a signal
/obj/item/clothing/head/mob_holder/proc/MyDeathRelease() // sweet sweet release
	var/turf/T = get_turf(src)
	playsound(T, 'sound/effects/body_fall_over_dead.ogg', 100, 1)
	var/mob/living/currier = GET_WEAKREF(carrier)
	var/out_ur_butt = currier ? "[currier.real_name]'s [loc]" : "somewhere wierd"
	T.audible_message(span_userdanger("[held_mob] tumbles out of [out_ur_butt], their eyes dead and lifeless!"))
	return release(T)

/obj/item/clothing/head/mob_holder/proc/TheirDeathRelease() // sweet sweet release
	var/turf/T = get_turf(src)
	playsound(T, 'sound/effects/body_fall_over_dead.ogg', 100, 1)
	var/mob/living/currier = GET_WEAKREF(carrier)
	var/out_ur_butt = currier ? "[currier.real_name]'s [loc]" : "somewhere wierd"
	T.audible_message(span_userdanger("[held_mob] tumbles out of [out_ur_butt] as they fall over, dead and lifeless!"))
	return release(T)

/obj/item/clothing/head/mob_holder/proc/release(atom/movable/here)
	if(held_mob)
		var/mob/living/L = held_mob
		if(here == L) // shove yourself into yourself for a bottomularity
			here = get_turf(src)
		held_mob = null
		if(!here)
			here = get_turf(src)
		L.forceMove(istype(here) && here != held_mob ? here : get_turf(src))
		L.reset_perspective()
		L.setDir(SOUTH)
		if(!L.is_monophobia_pet)  //if it's a pet, don't stun it
			L.SetAllImmobility(5 SECONDS, TRUE, TRUE)
	if(!QDELETED(src))
		qdel(src)

/// Vored held mobs kept getting force moved into themselves like some kinda hypercube
/// This is a workaround to prevent that from happening
/obj/item/clothing/head/mob_holder/proc/release_into_belly(datum/source, obj/vore_belly/gut)
	if(!istype(gut))
		return release(get_turf(src)) //fallback
	return release(gut)

/obj/item/clothing/head/mob_holder/relaymove(mob/user)
	return

/obj/item/clothing/head/mob_holder/container_resist()
	if(isliving(loc))
		var/mob/living/L = loc
		L.visible_message(span_warning("[held_mob] escapes from [L]!"), span_warning("[held_mob] escapes your grip!"))
	release()

/obj/item/clothing/head/mob_holder/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	if(M == held_mob || !ishuman(M)) //monkeys holding monkeys holding monkeys...
		return FALSE
	return ..()

/// Host takes damage? Vored critters do too
/obj/item/clothing/head/mob_holder/proc/pass_damage(datum/source, damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, damage_threshold)
	SIGNAL_HANDLER
	if(!held_mob)
		return
	if(held_mob.status_flags & GODMODE)
		return
	if(damage <= 0)
		return
	var/someone_hurt
	held_mob.apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, damage_threshold, sendsignal = FALSE)
	to_chat(held_mob, span_userdanger("The injury to [source] hurts you as well!"))
	someone_hurt = TRUE
	if(someone_hurt)
		to_chat(source, span_userdanger("You feel a flinch inside your [loc]!"))

/obj/item/clothing/head/mob_holder/assume_air(datum/gas_mixture/env)
	var/atom/location = loc
	if(!loc)
		return //null
	var/turf/T = get_turf(loc)
	while(location != T)
		location = location.loc
		if(ismob(location))
			return location.loc.assume_air(env)
	return location.assume_air(env)

/obj/item/clothing/head/mob_holder/proc/get_loc_for_air()
	var/atom/location = loc
	if(!loc)
		return //null
	var/turf/T = get_turf(loc)
	while(location != T)
		location = location.loc
		if(ismob(location))
			return location.loc
	return location

/obj/item/clothing/head/mob_holder/assume_air_moles(datum/gas_mixture/env, moles)
	var/atom/location = get_loc_for_air()
	return location.assume_air_moles(env, moles)

/obj/item/clothing/head/mob_holder/assume_air_ratio(datum/gas_mixture/env, ratio)
	var/atom/location = get_loc_for_air()
	return location.assume_air_ratio(env, ratio)

/obj/item/clothing/head/mob_holder/remove_air(amount)
	var/atom/location = get_loc_for_air()
	return location.remove_air(amount)

/obj/item/clothing/head/mob_holder/remove_air_ratio(ratio)
	var/atom/location = get_loc_for_air()
	return location.remove_air_ratio(ratio)

/obj/item/clothing/head/mob_holder/transfer_air(datum/gas_mixture/taker, amount)
	var/atom/location = get_loc_for_air()
	return location.transfer_air(taker, amount)

/obj/item/clothing/head/mob_holder/transfer_air_ratio(datum/gas_mixture/taker, ratio)
	var/atom/location = get_loc_for_air()
	return location.transfer_air(taker, ratio)

// escape when found if applicable
/obj/item/clothing/head/mob_holder/on_found(mob/living/finder)
	if(escape_on_find)
		finder.visible_message("[finder] accidentally releases the [held_mob]!")
		release()

/obj/item/debug_clickme
	name = "debug clickme stick"
	desc = "a thing that makes anotehr thing click u"
	icon = 'icons/obj/genitals/dildo.dmi'
	icon_state = "dildo_knotted_3"
	color = "#FF00FF"
	var/mode = "Left Click"

/obj/item/debug_clickme/examine(mob/user)
	. = ..()
	. += "gonna make things [mode] u"

/obj/item/debug_clickme/AltClick(mob/user)
	if(!user)
		return
	var/static/list/modes = list(
		"Left Click",
		"Right Click",
		"Alt Click",
		"Ctrl Click",
		"Shift Click",
		"CtrlShift Click",
		"Equip",
		"Equip Belt",
		"Equip Back",
		"Use Inhand",
		"Change Hands",
	)
	var/numode = input(user, "Select a mode", "Yes its a dildo", mode) as null|anything in modes
	if(numode in modes)
		mode = numode
		to_chat(user, span_notice("You set the mode to [mode]!"))
		return
	to_chat(user, span_warning("Never mind!!"))

/obj/item/debug_clickme/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	if(!ismob(A))
		return
	var/mob/target = A
	target.a_intent_change(user.a_intent)
	target.zone_selected = user.zone_selected
	switch(mode)
		if("Left Click")
			target.ClickOn(user)
		if("Right Click")
			target.RightClickOn(user)
		if("Alt Click")
			target.AltClickOn(user)
		if("Ctrl Click")
			target.CtrlClickOn(user)
		if("Shift Click")
			target.ShiftClickOn(user)
		if("CtrlShift Click")
			target.CtrlShiftClickOn(user)
		if("Equip")
			target.quick_equip()
		if("Equip Belt")
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				H.smart_equipbelt()
		if("Equip Back")
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				H.smart_equipbag()
		if("Use Inhand")
			target.mode()
		if("Change Hands")
			target.swap_hand()
	to_chat(user, span_notice("You made [target] [mode] (you)!"))
	return STOP_ATTACK_PROC_CHAIN

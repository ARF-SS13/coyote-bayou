/*
 * Energy guns that draw from a cell to fire.
 *
 * This is a bit weird but this is how it currently works:
 * When switching shots, it clears the chamber, and loads the correct energy ammo casing if there is enough energy to fire it.
 * If there's no projectile in the casing, it creates it now.
 * Otherwise the chamber stays null.
 * After firing, it actually deducts the energy and then clears the chamber and does the above again.
 * It detects if a successful fire is done by checking if the chambered energy ammo casing still has its projectile intact.
 *
 * It might be good in the future to move away from ammo casinsgs and instead use a datum-firemode system, but that would make handling firing,
 * which the casing does as of now, a little interesting to implement.
 */
/obj/item/gun/energy
	icon_state = "energy"
	name = "energy gun"
	desc = "A basic energy-based gun."
	icon = 'icons/obj/guns/energy.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY

	var/obj/item/stock_parts/cell/cell //What type of power cell this uses
	var/cell_type = /obj/item/stock_parts/cell/ammo/mfc
	var/modifystate = 0
	/// = TRUE/FALSE decides if the user can switch to it of their own accord
	var/list/ammo_type = list(/obj/item/ammo_casing/energy)
	/// The index of the ammo_types/firemodes which we're using right now !! has NOTHING to do with the gun's actual firemode
	var/current_firemode_index = 1
	var/can_charge = 1 //Can it be charged in a recharger?
	var/can_box_charge = TRUE // can it be charged in a box recharger?
	var/can_remove = 1 //Can the cell itself be removed and replaced?
	var/automatic_charge_overlays = TRUE	//Do we handle overlays with base update_icon()?
	var/charge_sections = 4
	ammo_x_offset = 2
	var/shaded_charge = FALSE //if this gun uses a stateful charge bar for more detail
	var/selfcharge = EGUN_NO_SELFCHARGE // EGUN_SELFCHARGE if true, EGUN_SELFCHARGE_BORG drains the cyborg's cell to recharge its own
	var/charge_tick = 0
	var/charge_delay = 4
	var/use_cyborg_cell = FALSE //whether the gun drains the cyborg user's cell instead, not to be confused with EGUN_SELFCHARGE_BORG
	var/dead_cell = FALSE //set to true so the gun is given an empty cell
	var/charge_cost_multiplier = 1
	/// set on the specific weapon you want to autocharge; X*2 = seconds to full charge.
	var/selfchargerate = 3 SECONDS 

	/// did we start selfcharging???
	var/selfcharge_initiated = FALSE
	/// is the selfcharge paused???
	var/selfcharge_paused = FALSE
	/// When your lazergun runs out of batteries, how long till it can be used?
	var/self_recharge_duration = 8 SECONDS
	/// how much longer do we have to waaaaaait?
	var/charge_duration_remaining = 0
	/// last time we ticked the charge bar
	var/last_charge_tick = 0
	/// the sound it plays when its empty and starts to charge
	var/charge_begin_sound = 'sound/weapons/energy_startcharge.ogg'
	/// the soundloop it plays when its charging
	var/datum/looping_sound/charge_loop = /datum/looping_sound/energy_charging
	/// the sound it plays when its alllllll done!
	var/charge_finished_sound = 'sound/weapons/energy_chargedone_ding.ogg'
	/// the sound it plays when you make it selfcharge cus you altclicked it
	var/charge_selfcharge_sound = 'sound/weapons/energy_manualcharge.ogg'

	var/my_chargebar

	/// SET THIS TO TRUE IF YOU OVERRIDE altafterattack() or ANY right click action! If this is FALSE, the gun will show in examine its default right click behavior, which is to switch modes.
	var/right_click_overridden = FALSE
	dryfire_sound = 'sound/f13weapons/noammoenergy.ogg'
	dryfire_text = "*power failure*"

	init_recoil = LASER_RIFLE_RECOIL(1, 1)

/obj/item/gun/energy/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		cell?.use(round(cell.charge * severity/100))
		chambered = null //we empty the chamber
		recharge_newshot() //and try to charge a new shot
		update_icon()

/obj/item/gun/energy/admin_fill_gun()
	if(!cell)
		cell = new cell_type(src)
	cell?.give(INFINITY) // it'll scale down to the maxcharge
	update_icon()
	return TRUE

/obj/item/gun/energy/get_cell()
	return cell

/obj/item/gun/energy/Initialize()
	. = ..()
	if(cell_type)
		cell = new cell_type(src)
	else
		cell = new(src)
	if(!dead_cell)
		cell.give(cell.maxcharge)
	update_ammo_types()
	recharge_newshot(TRUE)
	if(selfcharge)
		START_PROCESSING(SSobj, src)
		if(ispath(charge_loop))
			charge_loop = new charge_loop(list(src), FALSE)
	update_icon()

/obj/item/gun/energy/Destroy()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(cell)
	QDEL_LIST(ammo_type)
	return ..()

/obj/item/gun/energy/handle_atom_del(atom/A)
	if(A == cell)
		cell = null
		update_icon()
	return ..()

/obj/item/gun/energy/examine(mob/user)
	. = ..()
	if(!right_click_overridden)
		. += span_notice("Right click in combat mode to switch modes.")
	if(selfcharge && !selfcharge_initiated && !can_remove)
		. += span_notice("Alt-Click to force-initiate a self-charge cycle. This will drain the cell beforehand!")
	if(charge_duration_remaining)
		. += span_notice("Currently recharging! Should be ready in about [DisplayTimeText(charge_duration_remaining)].")

/obj/item/gun/energy/process()
	if(!selfcharge)
		return // all done!
	if(!cell)
		return // also all done
	// if(has_enough_charge_to_fire())
	// 	abort_selfcharge()
	// 	return // gun can shoot, maybe
	tick_selfcharge()

/obj/item/gun/energy/attack_self(mob/living/user)
	trigger_selfcharge(user)

/obj/item/gun/energy/proc/trigger_selfcharge(mob/user)
	if(selfcharge_initiated)
		to_chat(user, span_alert("[src]'s self-charge cycle cannot be stopped!!!"))
		return
	if(!selfcharge)
		return
	if(!cell)
		to_chat(user, span_alert("[src] does not have a cell!"))
		return
	to_chat(user, span_notice("[src]'s self-charging cycle initiated! Please wait..."))
	var/suppress_charge_sound = FALSE
	if(charge_selfcharge_sound)
		playsound(src, charge_selfcharge_sound, 50, 1)
		suppress_charge_sound = TRUE
	initiate_selfcharge(suppress_charge_sound)
	return TRUE

/obj/item/gun/energy/proc/has_enough_charge_to_fire()
	if(!cell || QDELETED(cell) || cell.charge <= 0)
		return FALSE
	return cell.charge >= shotcost()

/obj/item/gun/energy/proc/shotcost()
	var/obj/item/ammo_casing/energy/AC = chambered || ammo_type[current_firemode_index]
	if(!AC)
		return INFINITY // no shooting!
	return AC.e_cost * get_charge_cost_mult()



	// if(cell?.charge < cell.maxcharge)
	// 	if(selfcharge == EGUN_SELFCHARGE_BORG)
	// 		var/atom/owner = loc
	// 		if(istype(owner, /obj/item/robot_module))
	// 			owner = owner.loc
	// 		if(!iscyborg(owner))
	// 			return
	// 		var/mob/living/silicon/robot/R = owner
	// 		if(!R.cell?.use(100))
	// 			return
	// 	cell.give(cell.maxcharge / max(selfchargerate, 0.01))
	// 	if(!chambered) //if empty chamber we try to charge a new shot
	// 		recharge_newshot(TRUE)
	// 	update_icon()

/obj/item/gun/energy/can_shoot()
	return has_enough_charge_to_fire()

/obj/item/gun/energy/recharge_newshot(no_cyborg_drain)
	if (!ammo_type || !cell)
		return
	if(use_cyborg_cell && !no_cyborg_drain)
		if(iscyborg(loc))
			var/mob/living/silicon/robot/R = loc
			if(R.cell)
				if(R.cell.use(shotcost())) 		//Take power from the borg...
					cell.give(shotcost())	//... to recharge the shot
					. = TRUE
	if(!chambered)
		var/obj/item/ammo_casing/energy/AC = ammo_type[current_firemode_index]
		if(has_enough_charge_to_fire()) //if there's enough power in the cell cell...
			. = TRUE
			chambered = AC //...prepare a new shot based on the current ammo type selected
			if(!chambered.BB)
				chambered.newshot()

/obj/item/gun/energy/process_chamber()
	if(chambered && !chambered.BB) //if BB is null, i.e the shot has been fired...
		cell.use(shotcost())//... drain the cell cell
	chambered = null //either way, released the prepared shot
	if(!recharge_newshot()) //try to charge a new shot
		initiate_selfcharge()
		return

/obj/item/gun/energy/proc/initiate_selfcharge(silent)
	if(!selfcharge || selfcharge_initiated || selfcharge_paused)
		return
	if(!cell)
		return
	selfcharge_initiated = TRUE
	selfcharge_paused = FALSE
	cell.charge = 0
	charge_duration_remaining = self_recharge_duration
	last_charge_tick = world.time // prevent wierd race conditions that would instanly charge the gonne
	if(!silent && charge_begin_sound)
		playsound(src, charge_begin_sound, 80, TRUE)
	if(istype(charge_loop))
		charge_loop.start()
	if(my_chargebar)
		SSprogress_bars.remove_bar(my_chargebar)
	my_chargebar = SSprogress_bars.add_bar(src, list(), charge_duration_remaining, FALSE, FALSE)
	update_icon()
	return TRUE

/obj/item/gun/energy/proc/tick_selfcharge()
	if(!selfcharge)
		abort_selfcharge()
		return
	if(!selfcharge_initiated)
		if(cell && cell.charge < shotcost())
			initiate_selfcharge()
		return
	var/time_elapsed = world.time - last_charge_tick
	last_charge_tick = world.time
	if(!cell || selfcharge_paused)
		return
	var/external_mult = SEND_SIGNAL(loc, COMSIG_ENERGY_GUN_SELFCHARGE_TICK, src) || 1
	charge_duration_remaining -= time_elapsed * external_mult
	update_icon()
	if(charge_duration_remaining <= 0)
		finish_self_charge()
		return
	if(my_chargebar)
		SSprogress_bars.update_bar(my_chargebar, self_recharge_duration - charge_duration_remaining)

/obj/item/gun/energy/proc/finish_self_charge()
	if(!cell)
		return
	selfcharge_initiated = FALSE
	selfcharge_paused = FALSE
	cell.charge = cell.maxcharge
	charge_duration_remaining = 0
	if(charge_finished_sound)
		playsound(src, charge_finished_sound, 75, TRUE)
	if(istype(charge_loop))
		charge_loop.stop()
	if(my_chargebar)
		SSprogress_bars.remove_bar(my_chargebar)
		my_chargebar = 0
	update_icon()

/// battery fell out while self-charging, hold off on doing stuff
/obj/item/gun/energy/proc/pause_selfcharge()
	if(!selfcharge ||!selfcharge_initiated)
		return
	selfcharge_paused = TRUE
	if(istype(charge_loop))
		charge_loop.stop()

/obj/item/gun/energy/proc/abort_selfcharge()
	if(istype(charge_loop))
		charge_loop.stop()
	selfcharge_initiated = FALSE
	selfcharge_paused = FALSE
	charge_duration_remaining = 0
	update_icon()

/obj/item/gun/energy/proc/resume_or_initiate_selfcharge()
	if(!selfcharge || !selfcharge_initiated)
		return
	if(!selfcharge_paused)
		if(has_enough_charge_to_fire())
			return
		initiate_selfcharge()
		return
	selfcharge_paused = FALSE
	if(istype(charge_loop))
		charge_loop.start()
	last_charge_tick = world.time // no skipping!
	update_icon()

/obj/item/gun/energy/do_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(!chambered && can_shoot())
		process_chamber()	// If the gun was drained and then recharged, load a new shot.
	return ..()

/obj/item/gun/energy/proc/get_charge_cost_mult()
	var/base = charge_cost_multiplier
	var/datum/firemode/FM = firemodes[current_firemode_index]
	if(FM)
		base *= FM.shot_cost_multiplier
	return max(base, 0.01)

// Firemodes/Ammotypes

/obj/item/gun/energy/proc/update_ammo_types()
	var/obj/item/ammo_casing/energy/C
	for(var/i in 1 to length(ammo_type))
		var/v = ammo_type[i]
		var/user_can_select = ammo_type[v]
		if(istype(v, /obj/item/ammo_casing/energy))		//already set
			ammo_type[v] = isnull(user_can_select)? TRUE : user_can_select
		else
			C = new v(src)			//if you put non energycasing/type stuff in here you deserve the runtime
			ammo_type[i] = C
			ammo_type[C] = isnull(user_can_select)? TRUE : user_can_select
	set_firemode_index(initial(current_firemode_index))

/obj/item/gun/energy/proc/set_firemode_index(index, mob/user_for_feedback)
	chambered = null		//unchamber whatever we have chambered
	if(index > length(ammo_type))
		index = 1
	else if(index < 1)
		index = length(ammo_type)
	var/obj/item/ammo_casing/energy/C = ammo_type[index]		//energy weapons should not have no casings, if it does you deserve the runtime.
	current_firemode_index = index
	fire_sound = C.fire_sound
	//fire_delay = C.delay
	if(user_for_feedback)
		to_chat(user_for_feedback, span_notice("[src] is now set to [C.select_name || C]."))
	post_set_firemode()
	update_icon(TRUE)

/obj/item/gun/energy/proc/post_set_firemode(recharge_newshot = TRUE)
	if(recharge_newshot)
		recharge_newshot(TRUE)

/obj/item/gun/energy/proc/set_firemode_to_next(mob/user_for_feedback)
	return set_firemode_index(++current_firemode_index, user_for_feedback)

/obj/item/gun/energy/proc/set_firemode_to_prev(mob/user_for_feedback)
	return set_firemode_index(--current_firemode_index, user_for_feedback)

/obj/item/gun/energy/proc/get_firemode_index(casing_type)
	var/obj/item/ammo_casing/energy/E = locate(casing_type) in ammo_type
	if(E)
		return ammo_type.Find(E)

/obj/item/gun/energy/proc/set_firemode_to_type(casing_type)
	var/index = get_firemode_index(casing_type)
	if(index)
		set_firemode_index(index)

/// This is the proc used in general for when a user switches firemodes. Just goes to next firemode by default.
/obj/item/gun/energy/proc/select_fire(mob/living/user)
	return user_set_firemode_to_next(user)

/obj/item/gun/energy/proc/can_select_fire(mob/living/user)
	return (length(ammo_type) > 1)

#define INCREMENT_OR_WRAP(i) i = (i >= length(ammo_type))? 1 : (i + 1)
#define DECREMENT_OR_WRAP(i) i = (i <= 1)? length(ammo_type) : (i - 1)
#define IS_VALID_INDEX(i) (ammo_type[ammo_type[i]])
/obj/item/gun/energy/proc/user_set_firemode_to_next(mob/user_for_feedback)
	var/current_index = current_firemode_index
	var/new_index = current_index
	INCREMENT_OR_WRAP(new_index)
	if(!IS_VALID_INDEX(new_index))
		var/initial_index = new_index
		while(!IS_VALID_INDEX(new_index) && (new_index != initial_index))
			new_index = INCREMENT_OR_WRAP(new_index)
		if(initial_index == new_index)		//cycled through without finding another
			new_index = current_index

	set_firemode_index(new_index, user_for_feedback)

/obj/item/gun/energy/proc/user_set_firemode_to_prev(mob/user_for_feedback)
	var/current_index = current_firemode_index
	var/new_index = current_index
	DECREMENT_OR_WRAP(new_index)
	if(!IS_VALID_INDEX(new_index))
		var/initial_index = new_index
		while(!IS_VALID_INDEX(new_index) && (new_index != initial_index))
			new_index = DECREMENT_OR_WRAP(new_index)
		if(initial_index == new_index)		//cycled through without finding another
			new_index = current_index

	set_firemode_index(new_index, user_for_feedback)
#undef INCREMENT_OR_WRAP
#undef DECREMENT_OR_WRAP
#undef IS_VALID_INDEX

/obj/item/gun/energy/update_icon_state()
	if(initial(item_state))
		return
	..()
	var/ratio = get_charge_ratio()
	var/new_item_state = ""
	new_item_state = initial(icon_state)
	if(modifystate)
		var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
		new_item_state += "[shot.select_name]"
	new_item_state += "[ratio]"
	item_state = new_item_state

/obj/item/gun/energy/update_overlays()
	. = ..()
	if(QDELETED(src))
		return
	if(!automatic_charge_overlays)
		return
	var/overlay_icon_state  = "[icon_state]_charge"
	var/ratio = get_charge_ratio()
	if (modifystate)
		var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
		. += "[icon_state]_[shot.select_name]"
		overlay_icon_state += "_[shot.select_name]"
	if(ratio == 0)
		. += "[icon_state]_empty"
	else
		if(!shaded_charge)
			var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
			for(var/i = ratio, i >= 1, i--)
				charge_overlay.pixel_x = ammo_x_offset * (i - 1)
				charge_overlay.pixel_y = ammo_y_offset * (i - 1)
				. += new /mutable_appearance(charge_overlay)
		else
			. += "[icon_state]_charge[ratio]"

///Used by update_icon_state() and update_overlays()
/obj/item/gun/energy/proc/get_charge_ratio()
	return can_shoot() ? CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1) : 0
	// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.

/obj/item/gun/energy/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, selfcharge))
			if(var_value)
				START_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/gun/energy/ignition_effect(atom/A, mob/living/user)
	if(!can_shoot() || !ammo_type[current_firemode_index])
		shoot_with_empty_chamber()
		. = ""
	else
		var/obj/item/ammo_casing/energy/E = ammo_type[current_firemode_index]
		var/obj/item/projectile/energy/BB = E.BB
		if(!BB)
			. = ""
		else if(BB.nodamage || !BB.damage || BB.damage_type == STAMINA)
			user.visible_message(span_danger("[user] tries to light [user.p_their()] [A.name] with [src], but it doesn't do anything. Dumbass."))
			playsound(user, E.fire_sound, 50, 1)
			playsound(user, BB.hitsound, 50, 1)
			cell.use(shotcost())
			. = ""
		else if(BB.damage_type != BURN)
			user.visible_message(span_danger("[user] tries to light [user.p_their()] [A.name] with [src], but only succeeds in utterly destroying it. Dumbass."))
			playsound(user, E.fire_sound, 50, 1)
			playsound(user, BB.hitsound, 50, 1)
			cell.use(shotcost())
			qdel(A)
			. = ""
		else
			playsound(user, E.fire_sound, 50, 1)
			playsound(user, BB.hitsound, 50, 1)
			cell.use(shotcost())
			. = span_danger("[user] casually lights their [A.name] with [src]. Damn.")

/obj/item/gun/energy/altafterattack(atom/target, mob/user, proximity_flags, params)
	if(!right_click_overridden)
		select_fire(user)
		return TRUE
	return ..()

/obj/item/gun/energy/AltClick(mob/user)
	if (!ishuman(user))
		return
	if (get_dist(src, user)<2)
		eject_cell(user, TRUE, TRUE)
	else
		return

/obj/item/gun/energy/proc/eject_cell(mob/user, put_it_in_their_hand, sounds_and_words)
	if(!cell)
		if(sounds_and_words)
			to_chat(user, span_notice("There's no cell in \the [src]."))
		return
	if(can_remove == FALSE)
		if(selfcharge)
			trigger_selfcharge(user)
			return
		if(sounds_and_words)
			to_chat(user, span_notice("You can't remove the cell from \the [src]."))
		return
	cell.forceMove(drop_location())
	if(put_it_in_their_hand)
		user.put_in_hands(cell)
	cell.update_icon()
	if(sounds_and_words)
		to_chat(user, span_notice("You pull \the [cell] out of \the [src]."))
		playsound(src, 'sound/f13weapons/equipsounds/laserreload.ogg', 50, 1)
	cell = null
	pause_selfcharge()
	update_icon()

/obj/item/gun/energy/attack_self(mob/living/user)
	. = ..()
	if(can_select_fire(user))
		select_fire(user)
		return


/obj/item/gun/energy/attackby(obj/item/A, mob/user, params)
	..()
	if(can_remove && istype(A, /obj/item/stock_parts/cell/ammo))
		var/obj/item/stock_parts/cell/ammo/AM = A
		if (!cell && istype(AM, cell_type))
			if(user.transferItemToLoc(AM, src))
				cell = AM
				resume_or_initiate_selfcharge()
				to_chat(user, span_notice("You load a new cell into \the [src]."))
				A.update_icon()
				update_icon()
				return 1
			else
				to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!"))
				return
		//else if (cell)
			//to_chat(user, span_notice("There's already a cell in \the [src]."))

/obj/item/gun/energy/examine(mob/user)
	. = ..()
	if(can_remove == 1)
		. += span_notice("Alt-click to eject the battery.")

/obj/item/gun/energy/ui_data(mob/user)
	var/list/data = ..()
	var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
	var/c_mult = get_charge_cost_mult()
	data["has_magazine"] = !!cell
	data["charge_cost"] = shot?.e_cost * c_mult || 0 // shotcost() would return infinity in various cases
	data["accepted_magazines"] = "This weapon accepts \a [cell_type]."
	data["magazine_name"] = cell ? cell.name : "Unknown" // Its a magazine you silly goose
	if(cell)
		data["magazine_calibers"] = "Energy"
		data["cell_charge"] = cell.percent()
		data["shots_remaining"] = round(cell.charge / max(shot?.e_cost * c_mult, 0.01))
		data["shots_max"] = round(cell.maxcharge / max(shot?.e_cost * c_mult, 0.01))
	return data

/obj/item/gun/energy/get_dud_projectile()
	var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
	return new shot.projectile_type

/obj/item/gun/energy/generate_guntags()
	..()
	gun_tags |= GUN_ENERGY
	gun_tags |= GUN_LASER

//Boxes of ammo
/obj/item/ammo_box
	name = "ammo box (null_reference_exception)"
	desc = "A box of ammo."
	icon = 'icons/obj/ammo.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = 30000)
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	var/list/stored_ammo = list()
	var/obj/item/ammo_casing/ammo_type = /obj/item/ammo_casing
	var/max_ammo = 7
	var/multiple_sprites = 0
	/// Anything on the list can be added to this magazine. MUST be a list
	var/list/caliber = list()
	var/replace_spent_rounds = 0
	var/multiload = 1
	var/fixed_mag = FALSE
	var/unloadable = FALSE // UNLOADABLE MEANS NOT UNLOADABLE? WHAT A COUNTRY
	/// Can this magazine have its caliber changed?
	var/can_change_caliber = FALSE
	var/caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_0
	/// What valid calibers can this magazine be changed to?
	var/list/valid_new_calibers
	/// If its been rebored, dont add any more rebored to its everything
	var/been_rebored = FALSE
	var/start_empty = 0
	var/list/bullet_cost
	var/list/base_cost// override this one as well if you override bullet_cost
	var/start_ammo_count
	var/randomize_ammo_count = TRUE //am evil~
	var/supposedly_a_problem = 0
	var/eject_one_casing_per_click = FALSE
	maptext_width = 48 //prevents ammo count from wrapping down into two lines

/obj/item/ammo_box/Initialize(mapload, ...)
	. = ..()
	init_ammo()
	if(!islist(caliber))
		caliber = list()
	if(length(caliber) < 1)
		if(ammo_type)
			caliber += initial(ammo_type.caliber)
		else
			caliber += CALIBER_ANY // default to accepting any old caliber
	update_icon()

/obj/item/ammo_box/Destroy()
	QDEL_LIST(stored_ammo)
	return ..() 

/obj/item/ammo_box/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_POST_ADMIN_SPAWN,PROC_REF(admin_load))
	RegisterSignal(src, COMSIG_GUN_MAG_ADMIN_RELOAD,PROC_REF(admin_load))

/// Updates the ammo count number that renders on top of the icon
/obj/item/ammo_box/proc/UpdateAmmoCountOverlay()
	if(isturf(loc))//Only show th ammo count if the magazine is, like, in an inventory or something. Mags on the ground don't need a big number on them, that's ugly.
		maptext = ""
	else 
		if(LAZYLEN(stored_ammo) > 0)
			maptext = "<b>[LAZYLEN(stored_ammo)]/[max_ammo]"
		else
			maptext = "<b>0/[max_ammo]"

/obj/item/ammo_box/doMove(atom/destination)
	. = ..()
	UpdateAmmoCountOverlay()

/// An aheal, but for ammo boxes
/obj/item/ammo_box/proc/admin_load()
	if(!ammo_type)
		return
	. = fill_magazine(max_ammo, TRUE)
	update_icon()

/obj/item/ammo_box/proc/init_ammo()
	if(start_empty)
		return // All done!
	if(!ammo_type)
		return // No ammo type, no ammo
	var/num_bullets = max_ammo
	if(start_ammo_count)
		num_bullets = min(start_ammo_count, max_ammo)
	if(randomize_ammo_count)
		num_bullets = get_random_bullet_amount(num_bullets)
	fill_magazine(num_bullets)

/obj/item/ammo_box/proc/get_random_bullet_amount(num_bullets = max_ammo)
	var/amount = pick(0, rand(0, num_bullets), num_bullets)
	return amount

/obj/item/ammo_box/proc/fill_magazine(num_bullets = max_ammo, cock)
	if(replace_spent_rounds)
		if(LAZYLEN(stored_ammo))
			QDEL_LIST(stored_ammo)
		LAZYLENGTHEN(stored_ammo, max_ammo)
		num_bullets = clamp(num_bullets, 0, LAZYLEN(stored_ammo))
		for(var/i in 1 to LAZYLEN(stored_ammo))
			var/be_spent = FALSE
			if(i > num_bullets)
				be_spent = TRUE
			var/bluuet = new ammo_type(src, be_spent)
			post_process_ammo(bluuet)
			LAZYSET(stored_ammo, i, bluuet)
	else
		var/to_load = clamp(num_bullets, 0, max(0, max_ammo - LAZYLEN(stored_ammo)))
		if(to_load < 1)
			return
		. = to_load
		for(var/i in 1 to to_load)
			var/obj/item/ammo_casing/bluuet = new ammo_type(src)
			post_process_ammo(bluuet)
			stored_ammo += bluuet
		if(cock && istype(loc, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/my_gun = loc
			if(my_gun?.chambered?.BB)
				return
			my_gun?.chamber_round()

/obj/item/ammo_box/proc/post_process_ammo(bluuet)
	return

/obj/item/ammo_box/proc/handle_ejection(mob/living/user, is_enbloc, put_it_in_their_hand, sounds_and_words)
	return

/obj/item/ammo_box/proc/get_round(keep = 0)
	if(replace_spent_rounds)
		rotate()
		var/b = LAZYACCESS(stored_ammo, 1)
		if(!keep)
			stored_ammo[1] = null
		return b
	else
		if (!stored_ammo.len)
			return null
		else
			var/b = stored_ammo[stored_ammo.len]
			stored_ammo -= b
			if (keep)
				stored_ammo.Insert(1,b)
			return b

/obj/item/ammo_box/proc/give_round(obj/item/ammo_casing/other_casing, replace_spent = 0)
	// Boxes don't have a caliber type, magazines do. Not sure if it's intended or not, but if we fail to find a caliber, then we fall back to ammo_type.
	if(!other_casing)
		return FALSE
	if(!islist(caliber) && other_casing.type != ammo_type) // ALWAYS use a caliber ffs
		return FALSE
	if(!(other_casing.caliber in caliber))
		if(!(CALIBER_ANY in caliber))
			return FALSE

	if(length(stored_ammo) < max_ammo) // found an empty slot, stuff it in!
		insert_round(other_casing)
		return TRUE

	for(var/i in 1 to length(stored_ammo)) // revolvers are tricky, try and stuff in a shell in an empty slot
		var/obj/item/ammo_casing/bullet = stored_ammo[i]
		if(!bullet || isnull(bullet))
			insert_round(other_casing, i) // pop it in
			return TRUE

	if(replace_spent)
		for(var/i in 1 to length(stored_ammo)) // mag is full, check for empties
			var/obj/item/ammo_casing/bullet = stored_ammo[i]
			if(bullet.BB) // Found a bullet, but its empty!)
				continue
			eject_round(bullet, i) // pop it out
			insert_round(other_casing, i) // pop it in
			return TRUE
	return FALSE

/obj/item/ammo_box/proc/eject_round(obj/item/ammo_casing/casing_to_eject, index)
	if(!istype(casing_to_eject, /obj/item/ammo_casing))
		return
	if(index)
		stored_ammo[index] = null
	casing_to_eject.forceMove(get_turf(src.loc))

/obj/item/ammo_box/proc/insert_round(obj/item/ammo_casing/other_casing, index)
	if(!istype(other_casing))
		return FALSE
	if(index) // For revolvers
		stored_ammo[index] = other_casing // Carefully replace the spent round
		. = TRUE
	else
		stored_ammo += other_casing // just stuff it in there
		. = TRUE
	if(.)
		other_casing.forceMove(src)

/obj/item/ammo_box/proc/can_load(mob/user)
	if(caliber_change_step != MAGAZINE_CALIBER_CHANGE_STEP_0)
		to_chat(user, span_alert("You can't load anything into \the [src] while you're working on it!"))
	return 1

/obj/item/ammo_box/attackby(obj/item/A, mob/user, params, silent = FALSE, replace_spent = 0)
	. = ..()
	if(istype(A, /obj/item/stack/crafting/metalparts))
		var/obj/item/stack/crafting/metalparts/parts_to_use = A
		switch(caliber_change_step)
			if(MAGAZINE_CALIBER_CHANGE_STEP_0)
				to_chat(user, span_alert("You can't find a good place on \the [src] to put this!"))
			if(MAGAZINE_CALIBER_CHANGE_STEP_1)
				if(parts_to_use.use(1))
					playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
					to_chat(user, span_notice("You slide some parts into \the [src]. Now it's good and ready for melting!"))
					caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_2
				else
					to_chat(user, span_alert("You need at least one part to put on \the [src]! What are you trying to pull?"))
			if(MAGAZINE_CALIBER_CHANGE_STEP_2)
				to_chat(user, span_alert("You knock the parts out of the way and snap the fasteners back onto \the [src]."))
				var/turf/spawn_it_here = get_turf(user)
				new /obj/item/stack/crafting/metalparts(spawn_it_here)
				caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_0
			if(MAGAZINE_CALIBER_CHANGE_STEP_3)
				to_chat(user, span_alert("There's already a glowing piece of metal in \the [src]! Quick, stick a casing in!"))
		return

	if(istype(A, /obj/item/ammo_casing))
		if(change_caliber(user, A))
			return TRUE
		if(load_from_casing(A, user, silent))
			return TRUE
	if(istype(A, /obj/item/ammo_box))
		if(load_from_box(A, user, silent))
			return TRUE
	if(COOLDOWN_FINISHED(src, supposedly_a_problem) && istype(A, /obj/item/gun))
		COOLDOWN_START(src, supposedly_a_problem, 2) // just a brief thing so that the game has time to load the thing before you try to load the thing again, thanks automatics
		return A.attackby(src, user, params, silent, replace_spent)

/obj/item/ammo_box/proc/load_from_box(obj/item/ammo_box/other_ammobox, mob/user, silent)
	if(!istype(other_ammobox, /obj/item/ammo_box))
		return
	if(!can_load(user))
		return
	. = 0
	for(var/obj/item/ammo_casing/AC in other_ammobox.stored_ammo)
		var/did_load = give_round(AC, replace_spent_rounds)
		if(did_load)
			other_ammobox.stored_ammo -= AC
			. ++
		if(!did_load || !multiload)
			break
	if(.)
		if(!silent)
			to_chat(user, span_notice("You load [.] shell\s into \the [src]!"))
			playsound(src, 'sound/weapons/bulletinsert.ogg', 60, 1)
		other_ammobox.update_icon()
		update_icon()

/obj/item/ammo_box/proc/load_from_casing(obj/item/ammo_casing/other_casing, mob/user, silent)
	if(!istype(other_casing, /obj/item/ammo_casing))
		return
	if(!can_load(user))
		return
	. = 0
	if(give_round(other_casing, replace_spent_rounds))
		user.transferItemToLoc(other_casing, src, TRUE)
		.++
	if(.)
		if(!silent)
			to_chat(user, span_notice("You load [.] shell\s into \the [src]!"))
			playsound(src, 'sound/weapons/bulletinsert.ogg', 60, 1)
		other_casing.update_icon()
		update_icon()

/obj/item/ammo_box/proc/change_caliber(mob/living/user, obj/item/ammo_casing/casing_to_use)
	if(!can_change_caliber)
		return FALSE
	if(!istype(casing_to_use, /obj/item/ammo_casing))
		return FALSE
	if(caliber_change_step != MAGAZINE_CALIBER_CHANGE_STEP_3)
		return FALSE
	if(casing_to_use.caliber in valid_new_calibers)
		caliber.len = 0
		caliber |= casing_to_use.caliber
		to_chat(user, span_notice("You press \the [casing_to_use] into the glowing hot metal of \the [src]! The casing melts, and leaves behind a hole roughly its diameter! Looks like this mag'll accept [casing_to_use.caliber] now!"))
		qdel(casing_to_use)
		if(!been_rebored)
			name = "rebored [name]"
			if(fixed_mag && istype(src.loc, /obj/item/gun))
				var/obj/item/gun/gun_this_is_in = src.loc
				gun_this_is_in.name = "rebored [gun_this_is_in.name]"
			been_rebored = TRUE
		caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_0
		return TRUE
	else
		to_chat(user, span_alert("You can't press \the [casing_to_use] into \the [src]! Try a different kind of casing!"))
		return FALSE

/obj/item/ammo_box/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	if(!can_change_caliber)
		to_chat(user, span_alert("You can't change what kind of casing goes into \the [src]!"))
		return

	if(length(stored_ammo))
		var/is_loaded = FALSE
		for(var/obj/item/ammo_casing/casings in stored_ammo)
			if(isnull(casings))
				continue
			if(casings?.BB)
				is_loaded = TRUE
				break
		if(is_loaded)
			to_chat(user, span_alert("You need to unload \the [src]!"))
			return
	
	switch(caliber_change_step)
		if(MAGAZINE_CALIBER_CHANGE_STEP_0)
			to_chat(user, span_notice("You start loosening the fasteners on \the [src]..."))
			if(I.use_tool(src, user, volume=50))
				caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_1
				to_chat(user, span_notice("You snap open the fasteners on \the [src]! Next, you'll need some metal parts..."))
			else
				to_chat(user, span_alert("You mess up and all the fasteners on \the [src] snap back into place! Shoot!"))
		if(MAGAZINE_CALIBER_CHANGE_STEP_1)
			to_chat(user, span_alert("You snap the fasteners back onto \the [src]."))
			caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_0
		if(MAGAZINE_CALIBER_CHANGE_STEP_2)
			to_chat(user, span_alert("You knock the parts out of the way and snap the fasteners back onto \the [src]."))
			var/turf/spawn_it_here = get_turf(user)
			new /obj/item/stack/crafting/metalparts(spawn_it_here)
			caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_0
		if(MAGAZINE_CALIBER_CHANGE_STEP_3)
			to_chat(user, span_alert("You scoop out the glowing hot metal with \the [I], and when \the [src] cools, it seems like it'd gone back to how it was before. Huh."))
			var/turf/spawn_it_here = get_turf(user)
			new /obj/item/stack/crafting/metalparts(spawn_it_here)
			caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_0

/obj/item/ammo_box/welder_act(mob/living/user, obj/item/I)
	. = ..()

	if(.)
		return

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	if(!can_change_caliber)
		to_chat(user, span_alert("You can't change what kind of casing goes into \the [src]!"))
		return

	if(length(stored_ammo))
		var/is_loaded = FALSE
		for(var/obj/item/ammo_casing/casings in stored_ammo)
			if(isnull(casings))
				continue
			if(casings?.BB)
				is_loaded = TRUE
				break
		if(is_loaded)
			to_chat(user, span_alert("You need to unload \the [src]!"))
			return
	
	switch(caliber_change_step)
		if(MAGAZINE_CALIBER_CHANGE_STEP_0)
			to_chat(user, span_alert("You cant weld \the [src] just yet! Try using a screwdriver on the fasteners first!"))
		if(MAGAZINE_CALIBER_CHANGE_STEP_1)
			to_chat(user, span_alert("You knock the fasteners on \the [src] back into place."))
			caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_0
		if(MAGAZINE_CALIBER_CHANGE_STEP_2)
			if(!I.tool_start_check(user, amount=0))
				to_chat(user, span_alert("You need at least 5 units of fuel in your welder!"))
				return
			to_chat(user, span_notice("You start heating up the parts on \the [src]..."))
			if(I.use_tool(src, user, amount=1, volume=50))
				caliber_change_step = MAGAZINE_CALIBER_CHANGE_STEP_3
				to_chat(user, span_notice("You heat up the parts nice and hot and weld them to \the [src]! It should hold a casing, as a mold..."))
			else
				to_chat(user, span_alert("You mess up and \the [src] cools off! Darn!"))
		if(MAGAZINE_CALIBER_CHANGE_STEP_3)
			to_chat(user, span_alert("\The [src] is already hot! Quick, put a casing in there!"))

/obj/item/ammo_box/attack_self(mob/user)
	pop_casing(user)

/obj/item/ammo_box/proc/pop_casing(mob/user, to_ground, silent)
	if(unloadable)
		to_chat(user, span_notice("You can't remove ammo from \the [src]!"))
		return FALSE
	var/obj/item/ammo_casing/A = get_round()
	if(!A)
		to_chat(user, span_alert("There's nothing in \the [src]!"))
		return FALSE
	if(to_ground || !user.put_in_hands(A))
		A.bounce_away(FALSE, NONE)
	playsound(src, 'sound/weapons/bulletinsert.ogg', 60, 1)
	if(!silent)
		to_chat(user, span_notice("You remove a round from \the [src]!"))
	update_icon()
	return A

/obj/item/ammo_box/update_icon()
	. = ..()
	UpdateAmmoCountOverlay()
/* 	if(length(bullet_cost))
		var/temp_materials = custom_materials.Copy()
		for (var/material in bullet_cost)
			var/material_amount = bullet_cost[material]
			material_amount = (material_amount*stored_ammo.len) + base_cost[material]
			temp_materials[material] = material_amount
		set_custom_materials(temp_materials) */

/obj/item/ammo_box/examine(mob/user)
	. = ..()
	if(islist(caliber))
		. += "This accepts [span_notice(english_list(caliber))]!"
	if(length(stored_ammo))
		. += "There [length(stored_ammo) == 1 ? "is" : "are"] [span_notice("[length(stored_ammo)]")] shell\s left!"

/obj/item/ammo_box/update_icon_state()
	switch(multiple_sprites)
		if(1) //standard
			icon_state = "[initial(icon_state)]-[stored_ammo.len]"
		if(2) //speedloaders and such
			icon_state = "[initial(icon_state)]-[stored_ammo.len ? "[max_ammo]" : "0"]"
		if(3) //improvised bags
			if(stored_ammo.len >= 8)
				icon_state = "[initial(icon_state)]-8"
			else
				icon_state = "[initial(icon_state)]-[stored_ammo.len]"
		if(4) //ammo crates
			if(stored_ammo.len >= 100)
				icon_state = "[initial(icon_state)]-5"
			else if(stored_ammo.len >= 75)
				icon_state = "[initial(icon_state)]-4"
			else if(stored_ammo.len >= 50)
				icon_state = "[initial(icon_state)]-3"
			else if(stored_ammo.len >= 25)
				icon_state = "[initial(icon_state)]-2"
			else if(stored_ammo.len >= 1)
				icon_state = "[initial(icon_state)]-1"
			else
				icon_state = "[initial(icon_state)]-0"
		if(5)
			if(stored_ammo.len >= 12)
				icon_state = "[initial(icon_state)]-12"
			else
				icon_state = "[initial(icon_state)]-[stored_ammo.len]"
	UpdateAmmoCountOverlay()

//Behavior for magazines
/obj/item/ammo_box/proc/ammo_count(countempties = TRUE)
	var/boolets = 0
	for(var/obj/item/ammo_casing/bullet in stored_ammo)
		if(bullet && (bullet.BB || countempties))
			boolets++
	return boolets

/obj/item/ammo_box/proc/empty_magazine()
	var/turf_mag = get_turf(src)
	for(var/obj/item/ammo in stored_ammo)
		ammo.forceMove(turf_mag)
		stored_ammo -= ammo
	UpdateAmmoCountOverlay(FALSE)

/obj/item/ammo_box/handle_atom_del(atom/A)
	stored_ammo -= A
	update_icon()

/obj/item/ammo_box/proc/rotate()
	if(!length(stored_ammo))
		return
	var/b = stored_ammo[1]
	stored_ammo.Cut(1,2)
	stored_ammo.Insert(0, b)

/obj/item/ammo_box/proc/spin()
	for(var/i in 1 to rand(0, max_ammo*2))
		rotate()


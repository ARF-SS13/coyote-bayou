//Boxes of ammo
/obj/item/ammo_box
	name = "ammo box (null_reference_exception)"
	desc = "A box of ammo."
	icon = 'icons/obj/ammo.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
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
	var/unloadable = FALSE
	var/start_empty = 0
	var/list/bullet_cost
	var/list/base_cost// override this one as well if you override bullet_cost

/obj/item/ammo_box/Initialize()
	. = ..()
	if (!bullet_cost)
		for (var/material in custom_materials)
			var/material_amount = custom_materials[material]
			LAZYSET(base_cost, material, (material_amount * 0.10))

			material_amount *= 0.90 // 10% for the container
			material_amount /= max_ammo
			LAZYSET(bullet_cost, material, material_amount)
	if(!start_empty)
		for(var/i = 1, i <= max_ammo, i++)
			stored_ammo += new ammo_type(src)
	if(!islist(caliber))
		caliber = list()
	if(length(caliber) < 1)
		if(ammo_type)
			caliber += initial(ammo_type.caliber)
		else
			caliber += CALIBER_ANY // default to accepting any old caliber
	update_icon()

/obj/item/ammo_box/proc/get_round(keep = 0)
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

	if(replace_spent_rounds)
		for(var/i in 1 to length(stored_ammo)) // mag is full, check for empties
			var/obj/item/ammo_casing/bullet = stored_ammo[i]
			if(isnull(bullet) || !bullet.BB || isnull(bullet.BB)) // Found a bullet, but its empty!)
				eject_round(bullet, i) // pop it out
				insert_round(other_casing, i) // pop it in
				return TRUE
	return FALSE

/* 
		for(var/obj/item/ammo_casing/AC in stored_ammo)
			if(!AC.BB)//found a spent ammo
				stored_ammo -= AC
				AC.forceMove(get_turf(src.loc))

				stored_ammo += other_casing
				other_casing.forceMove(src)
				return 1 */

/obj/item/ammo_box/proc/eject_round(obj/item/ammo_casing/casing_to_eject, index)
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
	return 1

/obj/item/ammo_box/attackby(obj/item/A, mob/user, params, silent = FALSE, replace_spent = 0)
	var/num_loaded = 0
	if(!can_load(user))
		return
	if(istype(A, /obj/item/ammo_box))
		var/obj/item/ammo_box/AM = A
		for(var/obj/item/ammo_casing/AC in AM.stored_ammo)
			var/did_load = give_round(AC, replace_spent_rounds)
			if(did_load)
				AM.stored_ammo -= AC
				num_loaded++
			if(!did_load || !multiload)
				break
	if(istype(A, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/AC = A
		if(give_round(AC, replace_spent_rounds))
			user.transferItemToLoc(AC, src, TRUE)
			num_loaded++

	if(num_loaded)
		if(!silent)
			to_chat(user, "<span class='notice'>You load [num_loaded] shell\s into \the [src]!</span>")
			playsound(src, 'sound/weapons/bulletinsert.ogg', 60, 1)
		A.update_icon()
		update_icon()

	return num_loaded

/obj/item/ammo_box/attack_self(mob/user)
	var/obj/item/ammo_casing/A = get_round()
	if (unloadable == TRUE)
		to_chat(user, "<span class='notice'>You can't remove ammo from \the [src]!</span>")
	else
		if(A)
			if(!user.put_in_hands(A))
				A.bounce_away(FALSE, NONE)
			playsound(src, 'sound/weapons/bulletinsert.ogg', 60, 1)
			to_chat(user, "<span class='notice'>You remove a round from \the [src]!</span>")
			update_icon()

/obj/item/ammo_box/update_icon()
	. = ..()
	if(length(bullet_cost))
		var/temp_materials = custom_materials.Copy()
		for (var/material in bullet_cost)
			var/material_amount = bullet_cost[material]
			material_amount = (material_amount*stored_ammo.len) + base_cost[material]
			temp_materials[material] = material_amount
		set_custom_materials(temp_materials)

/obj/item/ammo_box/examine(mob/user)
	. = ..()
	if(islist(caliber))
		. += "This accepts [english_list(caliber)]!"
	if(length(stored_ammo))
		. += "There [length(stored_ammo) == 1 ? "is" : "are"] [length(stored_ammo)] shell\s left!"

/obj/item/ammo_box/update_icon_state()
	switch(multiple_sprites)
		if(1)
			icon_state = "[initial(icon_state)]-[stored_ammo.len]"
		if(2)
			icon_state = "[initial(icon_state)]-[stored_ammo.len ? "[max_ammo]" : "0"]"
		if(3)
			if(stored_ammo.len >= 8)
				icon_state = "[initial(icon_state)]-8"
			else
				icon_state = "[initial(icon_state)]-[stored_ammo.len]"

//Behavior for magazines
/obj/item/ammo_box/magazine/proc/ammo_count()
	return stored_ammo.len

/obj/item/ammo_box/magazine/proc/empty_magazine()
	var/turf_mag = get_turf(src)
	for(var/obj/item/ammo in stored_ammo)
		ammo.forceMove(turf_mag)
		stored_ammo -= ammo

/obj/item/ammo_box/magazine/handle_atom_del(atom/A)
	stored_ammo -= A
	update_icon()

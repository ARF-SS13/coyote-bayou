
/////////////////////
//Mob INVENTORY//
/////////////////////
//Mob inventory
//Mob hands

/mob/living/simple_animal
	///Holds one item, like a backpack or something so that some mobs have an inventory to pull from.
	var/obj/item/internal_storage = null
	///Head inventory slot that some mobs use for hats and the likes. (ie catslugs & drones)
	var/obj/item/head
	///If this exists, it will spawn in internal storage
	var/obj/item/default_storage
	///If this exists, it will spawn in the hat/mask slot if it can fit
	var/obj/item/default_hatmask
	///The pixel difference between the top of the head for this mob and a human. Helps to generate hats for certain mobs like catslugs.
	var/head_offset = null

/mob/living/simple_animal/proc/update_inv_internal_storage()
	if(internal_storage && client && hud_used && hud_used.hud_shown)
		internal_storage.screen_loc = ui_drone_storage
		client.screen += internal_storage

/mob/living/simple_animal/update_inv_head()
	if(head)
		if(client && hud_used && hud_used.hud_shown)
			head.screen_loc = ui_drone_head
			client.screen += head

/mob/living/simple_animal/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE)
	if(..())
		update_inv_hands()
		if(I == head)
			head = null
			update_inv_head()
		if(I == internal_storage)
			internal_storage = null
			update_inv_internal_storage()
		return 1
	return 0


/mob/living/simple_animal/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, list/return_warning)
	switch(slot)
		if(SLOT_HEAD)//Anything that can be worn on a head, worn as a mask, held in a mouth, or worn around a neck.
			if(head)
				return 0
			if(!((I.slot_flags & INV_SLOTBIT_HEAD) || (I.slot_flags & INV_SLOTBIT_MASK) || (I.slot_flags & INV_SLOTBIT_NECK) || (I.slot_flags & INV_SLOTBIT_POCKET)))
				return 0
			return 1
		if(SLOT_GENERIC_DEXTROUS_STORAGE)
			if(internal_storage)
				return 0
			return 1
	..()


/mob/living/simple_animal/get_item_by_slot(slot_id)
	switch(slot_id)
		if(SLOT_HEAD)
			return head
		if(SLOT_GENERIC_DEXTROUS_STORAGE)
			return internal_storage
	return ..()


/mob/living/simple_animal/equip_to_slot(obj/item/I, slot)
	if(!slot)
		return
	if(!istype(I))
		return

	var/index = get_held_index_of_item(I)
	if(index)
		held_items[index] = null
	update_inv_hands()

	if(I.pulledby)
		I.pulledby.stop_pulling()

	I.screen_loc = null // will get moved if inventory is visible
	I.forceMove(src)
	I.layer = ABOVE_HUD_LAYER
	I.plane = ABOVE_HUD_PLANE

	switch(slot)
		if(SLOT_HEAD)
			head = I
			update_inv_head()
		if(SLOT_GENERIC_DEXTROUS_STORAGE)
			internal_storage = I
			update_inv_internal_storage()
		else
			to_chat(src, span_danger("You are trying to equip this item to an unsupported inventory slot. Report this to a coder!"))
			return

	//Call back for item being equipped to pokemon
	I.equipped(src, slot)

/mob/living/simple_animal/getBackSlot()
	return SLOT_GENERIC_DEXTROUS_STORAGE

/mob/living/simple_animal/getBeltSlot()
	return SLOT_GENERIC_DEXTROUS_STORAGE

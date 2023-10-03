//-->Proc that allows reloading with a simple button
//we want a proc that unholsters your weapon from: suit storage, belt, shoulder holster. (in this order and if your hand is empty)
/mob/living/carbon/proc/smart_gunreload()
	if(incapacitated())
		return

	var/obj/item/equipped_belt = get_item_by_slot(SLOT_BELT)
	var/obj/item/equipped_back = get_item_by_slot(SLOT_BACK)
	var/obj/item/gun/firearm_a = held_items[1]
	var/obj/item/gun/firearm_b = held_items[2]
	var/obj/item/ammo_box/clip

	// for(var/obj/item/gun/F in held_items)
	// 	firearm_a = F
	// 	break

	if((firearm_a && !firearm_b) || (!firearm_a && firearm_b))
		for(var/obj/item/ammo_box/C in equipped_belt.contents)  //We surely have to find at least the first speedloader, otherwise the following for doesn't know what to do
			clip = C
			break
		for(var/obj/item/ammo_box/C in equipped_belt.contents)  //Code didn't find a gun? Let's check if there are clips or speedloaders with ammo in it.
			if(C.stored_ammo.len >= clip.stored_ammo.len)
				clip = C
		
		if(firearm_a)
			if(clip && !clip.on_found(src))  //if there's no firearm, return the fullest speedloader
				firearm_a.attackby(clip, src)
				SEND_SIGNAL(equipped_belt, COMSIG_TRY_STORAGE_INSERT, GLOB.smart_gunreload_previous_magazine, src)
				GLOB.smart_gunreload_previous_magazine = null
			return
		if(firearm_b)
			if(clip && !clip.on_found(src))  //if there's no firearm, return the fullest speedloader
				firearm_b.attackby(clip, src)
				SEND_SIGNAL(equipped_belt, COMSIG_TRY_STORAGE_INSERT, GLOB.smart_gunreload_previous_magazine, src)
				GLOB.smart_gunreload_previous_magazine = null
			return
	
	//let's allow player to akimbo reload guns
	if(firearm_a && firearm_b)
		for(var/obj/item/ammo_box/C in equipped_belt.contents)  //We surely have to find at least the first speedloader, otherwise the following for doesn't know what to do
			clip = C
			break
		for(var/obj/item/ammo_box/C in equipped_belt.contents)  //Code didn't find a gun? Let's check if there are clips or speedloaders with ammo in it.
			if(C.stored_ammo.len >= clip.stored_ammo.len)
				clip = C
		
		if(clip && !clip.on_found(src))  //if there's no firearm, return the fullest speedloader
			firearm_a.attackby(clip, src)
			SEND_SIGNAL(equipped_belt, COMSIG_TRY_STORAGE_INSERT, GLOB.smart_gunreload_previous_magazine, src)
			GLOB.smart_gunreload_previous_magazine = null
		
		for(var/obj/item/ammo_box/C in equipped_belt.contents)  //We surely have to find at least the first speedloader, otherwise the following for doesn't know what to do
			clip = C
			break
		for(var/obj/item/ammo_box/C in equipped_belt.contents)  //Code didn't find a gun? Let's check if there are clips or speedloaders with ammo in it.
			if(C.stored_ammo.len >= clip.stored_ammo.len)
				clip = C
		
		if(clip && !clip.on_found(src))  //if there's no firearm, return the fullest speedloader
			firearm_b.attackby(clip, src)
			SEND_SIGNAL(equipped_belt, COMSIG_TRY_STORAGE_INSERT, GLOB.smart_gunreload_previous_magazine, src)
			GLOB.smart_gunreload_previous_magazine = null
		return






























/*
	var/obj/item/thing = get_active_held_item()
	var/obj/item/equipped_suit = get_item_by_slot(SLOT_S_STORE)
	var/obj/item/equipped_belt = get_item_by_slot(SLOT_BELT)
	var/obj/item/equipped_neck = get_item_by_slot(SLOT_NECK)
	
	if(!equipped_suit)
		if(!thing)
			to_chat(src, span_warning("You have no suit armor storage to take something out of!"))
			return
		if(thing.equip_to_best_slot(src))
			update_inv_hands()
		return
	else if(!equipped_belt)
		if(!thing)
			to_chat(src, span_warning("You have no belt storage to take something out of!"))
			return
		if(equip_to_slot_if_possible(thing, INV_SLOTBIT_BELT))
			update_inv_hands()
		return
	else if(!equipped_neck)
		if(!thing)
			to_chat(src, span_warning("You have no holster to take something out of!"))
			return
		if(equip_to_slot_if_possible(thing, INV_SLOTBIT_NECK))
			update_inv_hands()
		return


	if(!SEND_SIGNAL(equipped_suit, COMSIG_CONTAINS_STORAGE)) //not a storage item
		if(!thing)
			equipped_suit.attack_hand(src)
		else
			to_chat(src, span_warning("You can't fit anything in your suit storage!"))
		return
	else if(!SEND_SIGNAL(equipped_belt, COMSIG_CONTAINS_STORAGE)) //not a storage item
		if(!thing)
			equipped_belt.attack_hand(src)
		else
			to_chat(src, span_warning("You can't fit anything in your belt storage!"))
		return
	else if(!SEND_SIGNAL(equipped_neck, COMSIG_CONTAINS_STORAGE)) //not a storage item
		if(!thing)
			equipped_neck.attack_hand(src)
		else
			to_chat(src, span_warning("You can't fit anything in your holster!"))
		return


	if(thing) //put thing in storage
		if(!SEND_SIGNAL(equipped_suit, COMSIG_TRY_STORAGE_INSERT, thing, src))
			to_chat(src, span_warning("This item is too big to fit the suit armor storage!"))
		else if(!SEND_SIGNAL(equipped_belt, COMSIG_TRY_STORAGE_INSERT, thing, src))
			to_chat(src, span_warning("This item is too big to fit the belt storage!"))
		else if(!SEND_SIGNAL(equipped_neck, COMSIG_TRY_STORAGE_INSERT, thing, src))
			to_chat(src, span_warning("This item is too big to fit the holster!"))
		return


	if(!equipped_suit.contents.len) //nothing to take out from suit storage
		to_chat(src, span_warning("You can't fit anything in your armor storage!"))
		return
	else if(!equipped_belt.contents.len) //nothing to take out from belt
		to_chat(src, span_warning("You can't fit anything in your belt storage!"))
		return
	else if(!equipped_neck.contents.len) //nothing to take out from holster
		to_chat(src, span_warning("You can't fit anything in your holster!"))
		return
	
	var/obj/item/gun/firearm = null
	var/obj/item/ammo_box/clip
	
	for(var/obj/item/gun/F in equipped_neck.contents)  //First thing, we want to obviously prioritize the unholstering of the gun.
		firearm = F
		break
	for(var/obj/item/ammo_box/C in equipped_neck.contents)  //We surely have to find at least the first speedloader, otherwise the following for doesn't know what to do
		clip = C
		break
	for(var/obj/item/ammo_box/C in equipped_neck.contents)  //Code didn't find a gun? Let's check if there are clips or speedloaders with ammo in it.
		if(C.stored_ammo.len >= clip.stored_ammo.len)
			clip = C
	
	var/obj/item/stored = equipped_neck.contents[equipped_neck.contents.len]
	if(firearm && !firearm.on_found(src))  //return the firearm first
		firearm.attack_hand(src)
		return
	else if(clip && !clip.on_found(src))  //if there's no firearm, return the fullest speedloader
		clip.attack_hand(src)
		return
	else if(stored && !stored.on_found(src))  //if none of the above is in the holster, return whatever was inside
		stored.attack_hand(src)
		return
	else
		return
*/

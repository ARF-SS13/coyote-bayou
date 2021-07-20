
//Proc that does the actual loading of items to mob
/*Itemlists are formatted as
"[typepath]" = number_of_it_to_spawn
*/

#define DROP_TO_FLOOR 0
#define LOADING_TO_HUMAN 1

///proc/handle_roundstart_items(mob/living/M, ckey_override, job_override, special_override)
//	if(!istype(M) || (!M.ckey && !ckey_override) || (!M.mind && (!job_override || !special_override)))
//		to_chat(M, SPAN_NOTICE("DEBUG: handle_roundstart_items returned false. ckey: [M.ckey]"))
//		return FALSE

//	return load_itemlist_to_mob(M, parse_custom_roundstart_items(ckey_override? ckey_override : M.ckey, M.name, job_override? job_override : M.mind.assigned_role, special_override? special_override : M.mind.special_role), TRUE, TRUE, FALSE)

//Just incase there's extra mob selections in the future.....
/proc/handle_roundstart_items(mob/living/L, list/itemlist, drop_on_floor_if_full = TRUE, load_to_all_slots = TRUE, replace_slots = FALSE)
	if(!istype(L) || !islist(itemlist))
//		to_chat(L, SPAN_NOTICE("DEBUG: No List of loadout items for this character."))
		return FALSE
	return load_itemlist_to_human(L, itemlist, drop_on_floor_if_full, load_to_all_slots, replace_slots, L)

/proc/load_itemlist_to_human(mob/living/carbon/human/H, list/itemlist, drop_on_floor_if_full = TRUE, load_to_all_slots = FALSE, replace_slots = FALSE, mob/living/L)
	if(!istype(H) || !islist(itemlist))
		return FALSE

	if (itemlist.len < 1)
//		to_chat(L, SPAN_NOTICE("DEBUG: No items found for this character/ckey: [H.ckey]"))
		return FALSE

	spawn(50)
		to_chat(L, SPAN_NOTICE("-------------------------------------------"))
		to_chat(L, SPAN_NOTICE("You have custom loadout items!  They are in the box at your feet."))
		to_chat(L, SPAN_NOTICE("-------------------------------------------"))

	var/turf/T = get_turf(H)

	// make the box
	var/obj/item/storage/box/large/customloadoutbox = new

	customloadoutbox.name = "Custom Loadout for [L.name]"
	customloadoutbox.desc = "Your custom loadout items!"
	customloadoutbox.w_class = WEIGHT_CLASS_BULKY
//	to_chat(H, SPAN_NOTICE("You have custom loadout items in the box at your feet.  Don't forget them!"))

	var obj/item/loaded_box = customloadoutbox			  //call it loaded_box
	loaded_box.forceMove(T)								  //move box to below mob

	for(var/item in itemlist)
		var/path = item
		if(!ispath(path))
			path = text2path(path)
		if(!path)
			continue
		var/amount = itemlist[item]

		for(var/i in 1 to amount)
			var/atom/movable/loaded_atom = new path
			var/obj/item/loaded = loaded_atom					  //make the item loaded_atom
			loaded.forceMove(T)
			loaded_box.contents += loaded_atom
			loaded_box.forceMove(T)
			//SEND_SIGNAL(loaded_box, COMSIG_TRY_STORAGE_INSERT, loaded, TRUE, H)

//			if(!istype(loaded_atom))
//				QDEL_NULL(loaded_atom)
//				continue
//			if(!istype(loaded_atom, /obj/item))
//				loaded_atom.forceMove(T)
//				continue
//			var/obj/item/loaded = loaded_atom
//			var/obj/item/storage/S = H.get_item_by_slot(SLOT_BACK)     // These lines would try to put it in their backpack, then failing that, their hands, then the ground - we just do ground.
//			if(istype(S))
//				SEND_SIGNAL(S, COMSIG_TRY_STORAGE_INSERT,loaded, TRUE, H)	//Force it into their backpack
//				continue
//			if(!H.put_in_hands(loaded))						//They don't have one/somehow that failed, put it in their hands
//				loaded.forceMove(T)				//Guess we're just dumping it on the floor!
//			loaded.forceMove(T) 				// drop it on the ground, since we're using other loadout options that go in the hands etc.
	return TRUE

/proc/load_custom_items_to_mob_from_db(mob/living/M, list/itemlist)
	if (itemlist.len < 1)
		//to_chat(M, SPAN_NOTICE("DEBUG: No DB items found for this character/ckey - from load_custom_items_to_mob_from_db"))
		return FALSE

	var/j = 0

	// Check to see if there are any items that are applicable to this role or character before we go on:
	for(var/entry in itemlist)
		var/list/thisitem = list()
		thisitem = itemlist[entry]

		//2 is character name or ALL for all characters.
		//3 is role name or ALL for all roles
		//4 is the path of the item
		//5 is the description

		if(thisitem[2] == "ALL" || thisitem[2] == M.real_name)
			if(thisitem[3] == "ALL" || thisitem[3] == M.job)
				//if we are here, there was something that needs to be spawned
				j = 1  //

	if (j==0)
		return FALSE   // We didn't have anything to spawn for this character so don't make a box or parse items.

	spawn(50)
		to_chat(M, SPAN_NOTICE("-------------------------------------------"))
		to_chat(M, SPAN_NOTICE("You have custom loadout items. They are in the box at your feet."))
		to_chat(M, SPAN_NOTICE("-------------------------------------------"))

	var/turf/T = get_turf(M)

	// make the box
	var/obj/item/storage/box/large/customloadoutbox = new

	customloadoutbox.name = "Custom Loadout for [M.real_name]"
	customloadoutbox.desc = "[M.real_name]'s personal items"
	customloadoutbox.w_class = WEIGHT_CLASS_BULKY

	var obj/item/loaded_box = customloadoutbox			  //call it loaded_box
	loaded_box.forceMove(T)								  //move box to below mob

	for(var/entry in itemlist)
		var/list/thisitem = list()
		thisitem = itemlist[entry]

		//2 is character name or ALL for all characters.
		//3 is role name or ALL for all roles
		//4 is the path of the item
		//5 is the description

		if(thisitem[2] == "ALL" || thisitem[2] == M.real_name)  // Check if this item is for this name or ALL characters
			if(thisitem[3] == "ALL" || thisitem[3] == M.job)    // Check if this item is for this role or ALL roles
				var/path = thisitem[4]							// set the path to the item's path.
				if(!ispath(path))
					path = text2path(path)						// Convert it to a valid path
				if(!path)										// if it still isn't a path, just go to the next item, this one is dead
					continue

				var/atom/movable/loaded_atom = new path			// Create a new atom from the path provided
				var/obj/item/loaded = loaded_atom			 	// make the item loaded_atom
				loaded.forceMove(T)								// Move the item to where the player is just in case
				loaded_box.contents += loaded_atom				// Put the item in the box
				loaded_box.forceMove(T)							// Move the box to their feet


	//M.put_in_hands(loaded_box)								   // Try to put the object in their hands
	//var/obj/item/storage/S = M.get_item_by_slot(SLOT_BACK)     // These lines would try to put it in their backpack, then failing that, their hands, then the ground - we just do ground.

	//S.contents += loaded_box
	//if(istype(S))
	//	SEND_SIGNAL(S, COMSIG_TRY_STORAGE_INSERT,loaded_box, TRUE, M)	//Force it into their backpack
	return TRUE
/obj/item/storage/wallet
	name = "wallet"
	desc = "It can hold a few small and personal things. Easily tucked in various discrete places."
	icon_state = "wallet"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	slot_flags = INV_SLOTBIT_ID | INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	var/no_refresh = FALSE

	var/obj/item/card/id/front_id = null
	var/list/combined_access

/obj/item/storage/wallet/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.max_combined_w_class = 5
	STR.max_items = 5

/obj/item/storage/wallet/Exited(atom/movable/AM)
	. = ..()
	refreshID()

/obj/item/storage/wallet/proc/refreshID()
	LAZYCLEARLIST(combined_access)
	if(!(front_id in src))
		front_id = null
	for(var/obj/item/card/id/I in contents)
		if(!front_id)
			front_id = I
		LAZYINITLIST(combined_access)
		combined_access |= I.access
	update_icon()

/obj/item/storage/wallet/Entered(atom/movable/AM)
	. = ..()
	refreshID()

/obj/item/storage/wallet/update_icon_state()
	if(no_refresh)
		return
	else
		var/new_state = "wallet"
		if(front_id)
			new_state = "wallet_id"
		if(new_state != icon_state)		//avoid so many icon state changes.
			icon_state = new_state

/obj/item/storage/wallet/GetID()
	return front_id

/obj/item/storage/wallet/RemoveID()
	if(!front_id)
		return
	. = front_id
	front_id.forceMove(get_turf(src))

/obj/item/storage/wallet/InsertID(obj/item/inserting_item)
	var/obj/item/card/inserting_id = inserting_item.RemoveID()
	if(!inserting_id)
		return FALSE
	attackby(inserting_id)
	if(inserting_id in contents)
		return TRUE
	return FALSE

/obj/item/storage/wallet/GetAccess()
	if(LAZYLEN(combined_access))
		return combined_access
	else
		return ..()

/obj/item/storage/wallet/random
	icon_state = "random_wallet"

/obj/item/storage/wallet/random/PopulateContents()
	new /obj/item/holochip(src, rand(5,30))
	icon_state = "wallet"

/obj/item/storage/wallet/stash
	name = "metal tin"
	desc = "It can hold a few small and personal things. Easily tucked in various discrete places."
	icon_state = "moneypouch"
	no_refresh = TRUE

/obj/item/storage/wallet/stash/banker/PopulateContents()
	new /obj/item/stack/f13Cash/random/banker(src)

/obj/item/storage/wallet/stash/low/PopulateContents()
	new /obj/item/stack/f13Cash/random/low(src)

/obj/item/storage/wallet/stash/mid/PopulateContents()
	new /obj/item/stack/f13Cash/random/med(src)

/obj/item/storage/wallet/stash/high/PopulateContents()
	new /obj/item/stack/f13Cash/random/high(src)

//Money pouch from CIV13

/obj/item/storage/wallet/stash/pouch
	name = "coin pouch"
	desc = "It can hold a few small and personal things. Easily tucked in various discrete places."
	icon_state = "coinpouch"
	no_refresh = TRUE

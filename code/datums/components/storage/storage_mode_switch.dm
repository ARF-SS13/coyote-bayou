//-->Fuzzy's QoL storage equip/unequip
//right clicking on a storage item gives an option to set the equipping method.
//as it is now:
//STORAGE MODE 0: default
//STORAGE MODE 1: take out the FIRST placed item when simply CLICKING on storage
//STORAGE MODE 2: take out the LAST placed item when simply CLICKING on storage
//STORAGE MODE 3: take out the FIRST placed item when ALT-CLICKING on storage
//STORAGE MODE 4: take out the LAST placed item when ALT-CLICKING on storage
//STORAGE MODE 5: take out the FIRST placed item when CTRL-CLICKING on storage
//STORAGE MODE 6: take out the LAST placed item when CTRL-CLICKING on storage
//"""coder""": Leonzrygin
//<--

GLOBAL_LIST_INIT(pickoutitem_onclick_methods, list(
	"Default" = 0,
	"Take out FIRST item when CLICKING on it."			= 1,
	"Take out LAST item when CLICKING on it." 			= 2,
	"Take out FIRST item when ALT-CLICKING on it." 		= 3,
	"Take out LAST item when ALT-CLICKING on it." 		= 4,
	"Take out FIRST item when CTRL-CLICKING on it." 	= 5,
	"Take out LAST item when CTRL-CLICKING on it." 		= 6))


/obj/item/storage/verb/take_out_item_mode() 
	set name = "Set How To Take Item Out"
	set category = "Object"

	var/new_input = input(usr, "Choose the way you'd like to pick an item out from this storage", "Storage Mode: [src]") as null|anything in GLOB.pickoutitem_onclick_methods
	if(new_input)
		pickoutitem_onclick = GLOB.pickoutitem_onclick_methods[new_input]

	switch(pickoutitem_onclick)
		if(0)
			to_chat(usr, span_notice("..>STORAGE MODE 0: You'll now just open the inventory when CLICKING on \the [src]. (default mode)"))
		if(1)
			to_chat(usr, span_notice("..>STORAGE MODE 1: You'll now take out the FIRST placed item when CLICKING on \the [src]. (example of use: taking out ammo from ammo storages)"))
		if(2)
			to_chat(usr, span_notice("..>STORAGE MODE 2: You'll now take out the LAST placed item when CLICKING on \the [src]. (example of use: unsheathing weapons)"))
		if(3)
			to_chat(usr, span_notice("..>STORAGE MODE 3: You'll now take out the FIRST placed item when ALT-CLICKING on \the [src]. (example of use: taking out ammo from ammo storages)"))
		if(4)
			to_chat(usr, span_notice("..>STORAGE MODE 4: You'll now take out the LAST placed item when ALT-CLICKING on \the [src]. (example of use: unsheathing weapons)"))
		if(5)
			to_chat(usr, span_notice("..>STORAGE MODE 5: You'll now take out the FIRST placed item when CTRL-CLICKING on \the [src]. (example of use: taking out ammo from ammo storages)"))
		if(6)
			to_chat(usr, span_notice("..>STORAGE MODE 6: You'll now take out the LAST placed item when CTRL-CLICKING on \the [src]. (example of use: unsheathing weapons)"))
////////////////////////////////////////////////////////////////


/obj/item/storage/attack_hand(mob/user)
	var/obj/item/I = usr.get_active_held_item()
	var/counter
	. = ..()
	if(pickoutitem_onclick == 1)
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[1]  //return the first item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
				if(!counter)
					counter += 1
					attack_hand(usr)  //WE GET RECURSIVE ONLY ONCE I SWEAR
					return
				counter = 0
				return

	else if(pickoutitem_onclick == 2)
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[contents.len]  //return the last item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
				if(!counter)
					counter += 1
					attack_hand(usr)  //WE GET RECURSIVE ONLY ONCE I SWEAR
					return
				counter = 0
				return
////////////////////////////////////////////////////////////////


/obj/item/storage/AltClick(mob/user)
	. = ..()
	if(pickoutitem_onclick == 3)
		var/obj/item/I = usr.get_active_held_item()
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[1]  //return the first item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
				return

	else if(pickoutitem_onclick == 4)
		var/obj/item/I = usr.get_active_held_item()
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[contents.len]  //return the last item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
				return
////////////////////////////////////////////////////////////////


/obj/item/storage/CtrlClick(mob/user, params = "right")
	. = ..()
	if(pickoutitem_onclick == 5)
		var/obj/item/I = usr.get_active_held_item()
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[1]  //return the first item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
				return

	else if(pickoutitem_onclick == 6)
		var/obj/item/I = usr.get_active_held_item()
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[contents.len]  //return the last item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
				return
////////////////////////////////////////////////////////////////

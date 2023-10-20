//-->Fuzzy's QoL storage equip/unequip
//right clicking on a storage item gives an option to set the equipping method.
//as it is now:
//STORAGE MODE 0: default
//STORAGE MODE 1: take out the FIRST placed item when CTRL-CLICKING on storage
//STORAGE MODE 2: take out the LAST placed item when CTRL-CLICKING on storage
//STORAGE MODE 3: take out the FIRST placed item when ALT-CLICKING on storage
//STORAGE MODE 4: take out the LAST placed item when ALT-CLICKING on storage
//"""coder""": Leonzrygin
//<--


/obj/item/storage/verb/take_out_item_mode() 
	set name = "Switch Pick Item Out Method"
	set category = "Object"

	pickoutitem_onclick += 1
	if(pickoutitem_onclick > 4 || pickoutitem_onclick < 0)  //if for any reason it's lesser than 0, reset it. Keep the numbers updated here, if you add other modes, or it won't work
		pickoutitem_onclick = 0

	switch(pickoutitem_onclick)
		if(0)
			to_chat(usr, span_notice("..>STORAGE MODE 0: You'll now just open the inventory when CLICKING on \the [src]. (default mode)"))
		if(1)
			to_chat(usr, span_notice("..>STORAGE MODE 1: You'll now take out the FIRST placed item when CTRL-CLICKING on \the [src]. (example of use: taking out ammo from ammo storages)"))
		if(2)
			to_chat(usr, span_notice("..>STORAGE MODE 2: You'll now take out the LAST placed item when CTRL-CLICKING on \the [src]. (example of use: unsheathing weapons)"))
		if(3)
			to_chat(usr, span_notice("..>STORAGE MODE 3: You'll now take out the FIRST placed item when ALT-CLICKING on \the [src]. (example of use: taking out ammo from ammo storages)"))
		if(4)
			to_chat(usr, span_notice("..>STORAGE MODE 4: You'll now take out the LAST placed item when ALT-CLICKING on \the [src]. (example of use: unsheathing weapons)"))
////////////////////////////////////////////////////////////////


/obj/item/storage/CtrlClick(mob/user, params = "right")
	. = ..()
	if(pickoutitem_onclick == 1)
		var/obj/item/I = usr.get_active_held_item()
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[1]  //return the first item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
				return

	else if(pickoutitem_onclick == 2)
		var/obj/item/I = usr.get_active_held_item()
		if(!I)  //my hand is empty
			if(contents.len)  //there's something to take out from the inventory
				I = contents[contents.len]  //return the last item in this case.
				if(!I)
					return
				I.attack_hand(usr) // take out thing from storage
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

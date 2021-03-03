/obj/item/storage/backpack/backsheath
	name = "back sheath"
	desc = "A sheath that allows you to hold a sword on your back. It even has a pouch for your basic storage needs, how cool is that?"
	icon_state = "sheathback"
	item_state = "sheathback"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/storage/backpack/backsheath/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 2
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.can_hold = typecacheof(list(
		/obj/item/storage/backpack/backsheathstorage,
		/obj/item/claymore,
		/obj/item/katana,
		/obj/item/twohanded/fireaxe/bmprsword
		))

/obj/item/storage/backpack/backsheath/update_icon()
	icon_state = "sheathback"
	item_state = "sheathback"
	if(contents.len == 2)
		icon_state += "-full"
		item_state += "-full"
	if(loc && isliving(loc))
		var/mob/living/L = loc
		L.regenerate_icons()
	..()

/obj/item/storage/backpack/backsheath/PopulateContents()
	new /obj/item/storage/backpack/backsheathstorage(src)
	update_icon()

/obj/item/storage/backpack/backsheathstorage
	name = "open inventory"
	desc = "Open your belt's inventory"
	icon_state = "open"
	anchored = 1

/obj/item/storage/backpack/backsheathstorage/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 14
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.max_items = 14
	STR.clickopen = TRUE

/obj/item/storage/belt/waistsheath
	name = "sword sheath"
	desc = "A utility belt that allows a sword to be held at the hip at the cost of storage space."
	icon_state = "sheathwaist"
	item_state = "sheathwaist"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/waistsheath/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 2
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.can_hold = typecacheof(list(
		/obj/item/storage/belt/waistsheathstorage,
		/obj/item/claymore,
		/obj/item/katana
		))

/obj/item/storage/belt/waistsheath/examine(mob/user)
	..()
	if(length(contents))
		to_chat(user, "<span class='notice'>Alt-click it to quickly draw the blade.</span>")

/obj/item/storage/belt/waistsheath/AltClick(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(length(contents))
		var/obj/item/I = contents[2]
		user.visible_message("[user] takes [I] out of [src].", "<span class='notice'>You take [I] out of [src].</span>")
		user.put_in_hands(I)
		update_icon()
	else
		to_chat(user, "[src] is empty.")

/obj/item/storage/belt/waistsheath/update_icon()
	icon_state = "sheathwaist"
	item_state = "sheathwaist"
	if(contents.len == 2)
		icon_state += "-full"
		item_state += "-full"
	if(loc && isliving(loc))
		var/mob/living/L = loc
		L.regenerate_icons()
	..()

/obj/item/storage/belt/waistsheath/PopulateContents()
	new /obj/item/storage/belt/waistsheathstorage(src)
	update_icon()

/obj/item/storage/belt/waistsheathstorage
	name = "open inventory"
	desc = "Open your belt's inventory"
	icon_state = "open"
	anchored = 1

/obj/item/storage/belt/waistsheathstorage/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.max_items = 5
	STR.clickopen = TRUE

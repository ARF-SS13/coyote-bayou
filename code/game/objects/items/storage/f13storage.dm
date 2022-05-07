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
		/obj/item/melee/onehanded/machete,
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
		/obj/item/melee/onehanded/machete,
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

/obj/item/storage/medical/ancientfirstaid
	name = "ancient first aid box"
	icon_state = "ancientfirstaid"
	desc = "A rusty, scratched old tin case with a faded cross, containing various medical things if you are lucky."
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	var/empty = FALSE

/obj/item/storage/medical/ancientfirstaid/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/ointment(src)

/obj/item/storage/bag/casings
	name = "casing bag"
	icon = 'icons/obj/storage.dmi'
	icon_state = "bag_cases"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/spam_protection = FALSE
	var/mob/listeningTo

/obj/item/storage/bag/casings/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/casings/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 6000
	STR.max_items = 6000
	STR.can_hold = typecacheof(list(/obj/item/ammo_casing))

/obj/item/storage/bag/casings/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/Pickup_casings)
	listeningTo = user


/obj/item/storage/bag/casings/proc/Pickup_casings(mob/living/user)
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/A in tile)
			if (!is_type_in_typecache(A, STR.can_hold))
				continue
			else if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, A, user, TRUE))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, "<span class='warning'>Your [name] is full and can't hold any more!</span>")
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		user.visible_message("<span class='notice'>[user] scoops up the casings beneath [user.p_them()].</span>", \
			"<span class='notice'>You scoop up the casings beneath you with your [name].</span>")
	spam_protection = FALSE

/*
 * Ration boxes
 */

/obj/item/storage/box/ration
	name = "c-ration box"
	desc = "A box containing canned rations, issued to New California Republic Army personnel."
	icon = 'icons/obj/storage.dmi'
	icon_state = "c-ration"
	illustration = null

/obj/item/storage/box/ration/update_icon_state()
	. = ..()
	if(!contents.len)
		icon_state = "[icon_state]_open"
	else
		icon_state = initial(icon_state)

/obj/item/storage/box/ration/menu_one
	name = "c-ration box - 'Menu 1'"

/obj/item/storage/box/ration/menu_one/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/brahmin_chili(src)
	new /obj/item/reagent_containers/food/snacks/lollipop(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/sunset(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_greytort(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_two
	name = "c-ration box - 'Menu 2'"

/obj/item/storage/box/ration/menu_two/PopulateContents()
	name = "c-ration box - 'Menu 2'"
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/bighorner_sausage(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/candied_mutfruit(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/f13nukacola(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_pyramid(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_three
	name = "c-ration box - 'Menu 3'"

/obj/item/storage/box/ration/menu_three/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/igauna_bits(src)
	new /obj/item/reagent_containers/food/snacks/chocolatebar(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/bawls(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_bigboss(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_four
	name = "c-ration box - 'Menu 4'"

/obj/item/storage/box/ration/menu_four/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/grilled_radstag(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/cranberry_cobbler(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/sunset(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_greytort(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_five
	name = "c-ration box - 'Menu 5'"

/obj/item/storage/box/ration/menu_five/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/molerat_stew(src)
	new /obj/item/reagent_containers/food/snacks/lollipop(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/f13nukacola(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_pyramid(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_six
	name = "c-ration box - 'Menu 6'"

/obj/item/storage/box/ration/menu_six/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/ham_and_eggs(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/candied_mutfruit(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/f13nukacola(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_pyramid(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_seven
	name = "c-ration box - 'Menu 7'"

/obj/item/storage/box/ration/menu_seven/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/brahmin_burger(src)
	new /obj/item/reagent_containers/food/snacks/chocolatebar(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/bawls(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_bigboss(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_eight
	name = "c-ration box - 'Menu 8'"

/obj/item/storage/box/ration/menu_eight/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/vegetable_soup(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/cranberry_cobbler(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/sunset(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_greytort(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_nine
	name = "c-ration box - 'Menu 9'"

/obj/item/storage/box/ration/menu_nine/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/mirelurk_filets
	new /obj/item/reagent_containers/food/snacks/chocolatebar(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/bawls(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_bigboss(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_ten
	name = "c-ration box - 'Menu 10'"
/obj/item/storage/box/ration/menu_ten/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/yaoguai_meatballs(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/candied_mutfruit(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/f13nukacola(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_pyramid(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_eleven
	name = "c-ration box - 'Menu 11'"

/obj/item/storage/box/ration/menu_eleven/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/brahmin_dogs(src)
	new /obj/item/reagent_containers/food/snacks/lollipop(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/f13nukacola(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_pyramid(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/ranger_breakfast
	name = "k-ration breakfast"
	icon_state = "k-ration"

/obj/item/storage/box/ration/ranger_breakfast/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/breakfast(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/condiment/pack/soup(src)
	new /obj/item/reagent_containers/food/condiment/pack/coffee(src)
	new /obj/item/reagent_containers/food/condiment/pack/soup(src)
	new /obj/item/reagent_containers/food/condiment/pack/coffee(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/clothing/mask/cigarette/cigar/ncr(src)

/obj/item/storage/box/ration/ranger_lunch
	name = "k-ration lunch"
	icon_state = "k-ration"

/obj/item/storage/box/ration/ranger_lunch/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/breakfast(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/chocolatebar(src)
	new /obj/item/reagent_containers/food/condiment/pack/soup(src)
	new /obj/item/reagent_containers/food/condiment/pack/soup(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/clothing/mask/cigarette/cigar/ncr(src)

/obj/item/storage/box/ration/ranger_dinner
	name = "k-ration dinner"
	icon_state = "k-ration"

/obj/item/storage/box/ration/ranger_dinner/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/dinner(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/cracker/k_ration(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/cranberry_cobbler(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/clothing/mask/cigarette/cigar/ncr(src)


////////////////////////
// HEALING ITEM BOXES //
////////////////////////

/obj/item/storage/box/medicine
	name = "empty cardboard box for medicine"
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "medicinebox"
	illustration = "overlay_stim"

// -----------------------------------
// STIMPAK BOX

/obj/item/storage/box/medicine/stimpaks/stimpaks5 
	name = "box of stimpaks"
	desc = "A box full of stimpaks."

/obj/item/storage/box/medicine/stimpaks/stimpaks5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)

/obj/item/storage/box/medicine/stimpaks/imitation_stimpaks5
	name = "box of imitation stimpaks"
	desc = "Mmm. Delicious flower juice."

/obj/item/storage/box/medicine/stimpaks/imitation_stimpaks5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/hypospray/medipen/stimpak/imitation(src)

// -----------------------------------
// SUPER STIMPAK BOX

/obj/item/storage/box/medicine/stimpaks/superstimpaks5
	name = "box of super stimpaks"
	desc = "A box full of super stimpaks."
	illustration = "overlay_superstim"

/obj/item/storage/box/medicine/stimpaks/superstimpaks5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/hypospray/medipen/stimpak/super(src)

// -----------------------------------
// POWDER BOX

/obj/item/storage/box/medicine/powder5
	name = "box of five powders"
	desc = "A box full of powders."
	icon_state = "medicinebox_simple"
	illustration = "overlay_powder"

/obj/item/storage/box/medicine/powder5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/patch/healingpowder(src)

// -----------------------------------
// POULTICE BOX

/obj/item/storage/box/medicine/poultice5
	name = "box of five poultices"
	desc = "A box full of poultices."
	icon_state = "medicinebox_simple"
	illustration = "overlay_poultice"

/obj/item/storage/box/medicine/poultice5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/patch/healpoultice(src)

// -----------------------------------
// BITTER DRINK BOX

/obj/item/storage/box/medicine/bitterdrink5
	name = "box of bitter drinks"
	desc = "A box full of bitter drinks."
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "medicinebox_simple"
	illustration = "overlay_bitter"

/obj/item/storage/box/medicine/bitterdrink5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/patch/bitterdrink(src)

/obj/item/storage/backpack/backsheath
	name = "back sheath"
	desc = "A sheath that allows you to hold a sword on your back. It even has a pouch for your basic storage needs, how cool is that?"
	icon_state = "sheathback"
	inhand_icon_state = "sheathback"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = INV_SLOTBIT_BACK

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
	inhand_icon_state = "sheathback"
	if(contents.len == 2)
		icon_state += "-full"
		inhand_icon_state += "-full"
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


/*
 * Ration boxes
 */

/obj/item/storage/box/ration
	name = "c-ration box"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		So delicious that someone already ate the contents. Drat!"
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
	name = "c-ration box - 'BRAWNY BRAHMIN BBQ BURNOUT'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: DISCOUNT DAN'S BRAWNY BRAHMIN BBQ BURNOUT -- DEEEELICOUS BRAHMIN BBQ CHILI AND JERKY FRESH FROM THE GIRL, CHASE IT DOWN WITH SOME POP AND SMOKES!"

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
	name = "c-ration box - 'Sausage Party'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Salacious Dan's Sausage Party -- The BIGGEST of bighorner sausage with the FRUITEST of mutfruit glaze team up for a party your mouth won't forget!"

/obj/item/storage/box/ration/menu_two/PopulateContents()
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
	name = "c-ration box - 'Lipsmackin Sweetguana Stew'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Discount Dan's Lipsmackin' Sweetguana Stew -- Still drippin' lowestland iguana fixins marinaded in Viscount Varney's Select Choco-Tastic!"

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
	name = "c-ration box - 'Woodman Wildberry Bash'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Forrester Dan's Woodman Wildberry Bash -- Charbroiled firetail radstag steak, well-done, with a side of CRAN-berry cobbler for the manliest of hunters!"

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
	name = "c-ration box - 'Squeakiepie Snacktime'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Discount Dan's Squeakiepie Snacktime -- Sweet'n'sour squeaker stew, now with our patented FlavorMax Swizzlestick!"

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
	name = "c-ration box - 'Hunnyglazed Hillhogger'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Discount Dan's Hunnyglazed Hillhogger -- The tightest cuts of the 'hog so tender they're dripping off her eggs!"

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
	name = "c-ration box - 'Deluxe Dan w/ Cheez'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Discount Dan's Deluxe Dan w/ Cheez -- Charbroiled 100%* Grade-A* Prime* Brahmin* cheeseburger* with all* the fix'ns!"

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
	name = "c-ration box - 'Responsible Risotto'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Vegan Dan's Responsible Risotto -- All natural guilt-free soup with a side of free-range mountain-fresh CRAN-berry cobbler!"

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
	name = "c-ration box - 'Fillet o' Fillette'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Fisherman Dan's Fillet o' Fillette -- Fresh mirelurk Fillette, brined in all-natural Squeeze!"

/obj/item/storage/box/ration/menu_nine/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/mirelurk_filets(src)
	new /obj/item/reagent_containers/food/snacks/chocolatebar(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/ration(src)
	new /obj/item/reagent_containers/food/drinks/bottle/bawls(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_bigboss(src)
	new /obj/item/storage/box/matches(src)
	new /obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)

/obj/item/storage/box/ration/menu_ten
	name = "c-ration box - 'Bearballs'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Forrester Dan's Bearballs -- FRESH BEAR BALLS TIGHT PACKED BEAR BALLS HARD AND MEATY BEAR BALLS DELICIOUS AND TASTY"

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
	name = "c-ration box - 'Hotdawg Cookout'"
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Forrester Dan's Hotdawg Cookout -- Dignified foot+ brahminlongs just looking for a campfire!"

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
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Ranger Dan's Intercontinental Brahminfast Mealtime -- Start your march off right with spicy brahmin eggy tripe!"

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
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Ranger Dan's Lunch Rush Assault-Dining -- AlwaysHot shredded brahmin enchiladas!"

/obj/item/storage/box/ration/ranger_lunch/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/f13/canned/ncr/lunch(src)
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
	desc = "A box containing canned rations, guaranteed to stay technically edible for the next 4.1 quadrillion years. \
		The side reads: Ranger Dan's March On To Dinner -- PROtien packed brahlogna loaf, perfect to wind down an operation!"

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
	name = "satchel of five powders"
	desc = "A box full of powders."
	icon_state = "leather_bag"
	illustration = "overlay_powder"

/obj/item/storage/box/medicine/powder5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/healingpowder(src)

// -----------------------------------
// POULTICE BOX

/obj/item/storage/box/medicine/poultice5
	name = "satchel of five poultices"
	desc = "A box full of poultices."
	icon_state = "leather_bag"
	illustration = "overlay_poultice"

/obj/item/storage/box/medicine/poultice5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/patch/healpoultice(src)

// -----------------------------------
// BITTER DRINK BOX

/obj/item/storage/box/medicine/bitterdrink5
	name = "satchel of bitter drinks"
	desc = "A box full of bitter drinks."
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "leather_bag"
	illustration = "overlay_bitter"

/obj/item/storage/box/medicine/bitterdrink5/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/bitterdrink(src)

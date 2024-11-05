/*
 *	These absorb the functionality of the plant bag, ore satchel, etc
 *	They use the use_to_pickup, quick_gather, and quick_empty functions
 *	that were already defined in weapon/storage, but which had been
 *	re-implemented in other classes.
 *
 *	Contains:
 *		Trash Bag
 *		Mining Satchel
 *		Produce Bag
 *		Sheet Snatcher
 *		Book Bag
 *      Biowaste Bag
 *
 *	-Sayu
 */

//  Generic non-item
/obj/item/storage/bag
	name = "Generic bag thing"
	desc = "Some sort of bag!"
	slot_flags = INV_SLOTBIT_BELT
	w_class = WEIGHT_CLASS_HUGE
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	component_type = /datum/component/storage/concrete/bag

// -----------------------------
//          Trash bag
// -----------------------------
/obj/item/storage/bag/trash
	name = "trash bag"
	desc = "It's the heavy-duty black polymer kind. Time to take out the trash!"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "trashbag"
	inhand_icon_state = "trashbag"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	var/insertable = TRUE
	component_type = /datum/component/storage/concrete/bag/trash

/obj/item/storage/bag/trash/update_icon_state()
	switch(contents.len)
		if(0)
			icon_state = "[initial(icon_state)]"
		if(1 to 11)
			icon_state = "[initial(icon_state)]1"
		if(11 to 20)
			icon_state = "[initial(icon_state)]2"
		else
			icon_state = "[initial(icon_state)]3"

/obj/item/storage/bag/trash/cyborg
	insertable = FALSE

/obj/item/storage/bag/trash/proc/janicart_insert(mob/user, obj/structure/janitorialcart/J)
	if(insertable)
		J.put_in_cart(src, user)
		J.mybag=src
		J.update_icon()
	else
		to_chat(user, span_warning("You are unable to fit your [name] into the [J.name]."))
		return

/obj/item/storage/bag/trash/bluespace
	name = "trash bag of holding"
	desc = "The latest and greatest in custodial convenience, a trashbag that is capable of holding vast quantities of garbage."
	icon_state = "bluetrashbag"
	item_flags = NO_MAT_REDEMPTION
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	component_type = /datum/component/storage/concrete/bag/trash/big

/obj/item/storage/bag/trash/bluespace/cyborg
	insertable = FALSE

// -----------------------------
//        Mining Satchel
// -----------------------------

/obj/item/storage/bag/ore
	name = "mining satchel"
	desc = "This little bugger can be used to store and transport ores."
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	component_type = /datum/component/storage/concrete/stack
	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it
	var/mob/listeningTo
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	var/range = null

/obj/item/storage/bag/ore/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/rad_insulation, 0.01) //please datum mats no more cancer
	var/datum/component/storage/concrete/stack/STR = GetComponent(/datum/component/storage/concrete/stack)
	STR.allow_quick_empty = TRUE
	STR.max_items = 14
	STR.can_hold = typecacheof(list(/obj/item/stack/ore))
	STR.max_w_class = WEIGHT_CLASS_HUGE
	STR.max_combined_stack_amount = 50

/obj/item/storage/bag/ore/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED,PROC_REF(Pickup_ores))
	listeningTo = user

/obj/item/storage/bag/ore/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/ore/proc/Pickup_ores(mob/living/user)
	var/show_message = FALSE
	var/obj/structure/ore_box/box
	var/turf/tile = user.loc
	if (!isturf(tile))
		return
	if (istype(user.pulling, /obj/structure/ore_box))
		box = user.pulling
	if(issilicon(user))
		var/mob/living/silicon/robot/borgo = user
		for(var/obj/item/cyborg_clamp/C in borgo.module.modules)
			for(var/obj/structure/ore_box/B in C)
				box = B

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/A in tile)
			if (!is_type_in_typecache(A, STR.can_hold))
				continue
			if (box)
				if(range)
					for(var/obj/item/stack/ore/ore in range(range, user))
						user.transferItemToLoc(ore, box)
				user.transferItemToLoc(A, box)
				show_message = TRUE
			else if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, A, user, TRUE))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, span_warning("Your [name] is full and can't hold any more!"))
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		if (box)
			user.visible_message(span_notice("[user] offloads the ores beneath [user.p_them()] into [box]."), \
			span_notice("You offload the ores beneath you into your [box]."))
		else
			user.visible_message(span_notice("[user] scoops up the ores beneath [user.p_them()]."), \
				span_notice("You scoop up the ores beneath you with your [name]."))
	spam_protection = FALSE

/obj/item/storage/bag/ore/cyborg
	name = "cyborg mining satchel"
	range = 1

/obj/item/storage/bag/ore/cyborg/ComponentInitialize()
	. = ..()
	var/datum/component/storage/concrete/stack/STR = GetComponent(/datum/component/storage/concrete/stack)
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(/obj/item/stack/ore))
	STR.max_w_class = WEIGHT_CLASS_HUGE
	STR.max_combined_stack_amount = 150

/obj/item/storage/bag/ore/large
	name = "large mining satchel"
	desc = "This bag can hold three times the ore in many small pockets. Shockingly foldable and compact for its volume."

/obj/item/storage/bag/ore/large/ComponentInitialize()
	. = ..()
	var/datum/component/storage/concrete/stack/STR = GetComponent(/datum/component/storage/concrete/stack)
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(/obj/item/stack/ore))
	STR.max_w_class = WEIGHT_CLASS_HUGE
	STR.max_combined_stack_amount = 150

/obj/item/storage/bag/ore/holding //miners, your messiah has arrived
	name = "mining satchel of holding"
	desc = "A revolution in convenience, this satchel allows for huge amounts of ore storage. It's been outfitted with anti-malfunction safety measures."
	icon_state = "satchel_bspace"

/obj/item/storage/bag/ore/holding/ComponentInitialize()
	. = ..()
	var/datum/component/storage/concrete/stack/STR = GetComponent(/datum/component/storage/concrete/stack)
	STR.max_items = INFINITY
	STR.max_combined_w_class = INFINITY
	STR.max_combined_stack_amount = INFINITY

// -----------------------------
//          Plant bag/Produce Bag
// -----------------------------

/obj/item/storage/bag/plants
	name = "produce bag"
	desc = "A big, insulated bag for storing lots of plant and animal products."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "plantbag"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FLAMMABLE
	component_type = /datum/component/storage/concrete/bag/produce

////////

/obj/item/storage/bag/plants/portaseeder
	name = "portable seed extractor"
	desc = "For the enterprising botanist on the go. Less efficient than the stationary model, it creates one seed per plant."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "portaseeder"

/obj/item/storage/bag/plants/portaseeder/verb/dissolve_contents()
	set name = "Activate Seed Extraction"
	set category = "Object"
	set desc = "Activate to convert your plants into plantable seeds."
	var/mob/living/L = usr
	if(istype(L) && !CHECK_MOBILITY(L, MOBILITY_USE))
		return
	for(var/obj/item/O in contents)
		seedify(O, 1)

// -----------------------------
//        Sheet Snatcher
// -----------------------------
// Because it stacks stacks, this doesn't operate normally.
// However, making it a storage/bag allows us to reuse existing code in some places. -Sayu

/obj/item/storage/bag/sheetsnatcher
	name = "sheet snatcher"
	desc = "A patented US Government storage system designed for any kind of mineral sheet."
	icon = 'icons/obj/mining.dmi'
	icon_state = "sheetsnatcher"
	component_type = /datum/component/storage/concrete/stack

/obj/item/storage/bag/sheetsnatcher/ComponentInitialize()
	. = ..()
	var/datum/component/storage/concrete/stack/STR = GetComponent(/datum/component/storage/concrete/stack)
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(/obj/item/stack/sheet))
	STR.cant_hold = typecacheof(list(/obj/item/stack/sheet/mineral/sandstone, /obj/item/stack/sheet/mineral/wood))
	STR.max_combined_stack_amount = 300

// -----------------------------
//    Sheet Snatcher (Cyborg)
// -----------------------------

/obj/item/storage/bag/sheetsnatcher/borg
	name = "sheet snatcher 9000"
	desc = ""

/obj/item/storage/bag/sheetsnatcher/borg/ComponentInitialize()
	. = ..()
	var/datum/component/storage/concrete/stack/STR = GetComponent(/datum/component/storage/concrete/stack)
	STR.max_combined_stack_amount = 500

// -----------------------------
//           Book bag
// -----------------------------

/obj/item/storage/bag/books
	name = "book bag"
	desc = "A bag for books."
	icon = 'icons/obj/library.dmi'
	icon_state = "bookbag"
	resistance_flags = FLAMMABLE
	component_type = /datum/component/storage/concrete/bag/book

/*
 * Trays - Agouri
 */
/obj/item/storage/bag/tray
	name = "tray"
	desc = "A metal tray to lay food on."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "tray"
	force = 5
	throwforce = 10
	throw_speed = 3
	throw_range = 5
	flags_1 = CONDUCT_1
	custom_materials = list(/datum/material/iron=3000)
	var/max_items = 7

/obj/item/storage/bag/tray/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = GLOB.storage_tray_can_hold
	STR.insert_preposition = "on"
	STR.max_items = max_items

/obj/item/storage/bag/tray/attack(mob/living/M, mob/living/user)
	. = ..()
	// Drop all the things. All of them.
	var/list/obj/item/oldContents = contents.Copy()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_QUICK_EMPTY)
	// Make each item scatter a bit
	for(var/obj/item/I in oldContents)
		spawn()
			for(var/i = 1, i <= rand(1,2), i++)
				if(I)
					step(I, pick(NORTH,SOUTH,EAST,WEST))
					sleep(rand(2,4))

	if(prob(50))
		playsound(M, 'sound/items/trayhit1.ogg', 50, 1)
	else
		playsound(M, 'sound/items/trayhit2.ogg', 50, 1)

	if(ishuman(M) || ismonkey(M))
		if(prob(10))
			M.DefaultCombatKnockdown(40)
	update_icon()

/obj/item/storage/bag/tray/update_overlays()
	. = ..()
	for(var/obj/item/I in contents)
		var/mutable_appearance/I_copy = new(I)
		I_copy.plane = FLOAT_PLANE
		I_copy.layer = FLOAT_LAYER
		. += I_copy

/obj/item/storage/bag/tray/Entered()
	. = ..()
	update_icon()

/obj/item/storage/bag/tray/Exited()
	. = ..()
	update_icon()

//bluespace tray, holds more items
/obj/item/storage/bag/tray/bluespace
	name = "bluespace tray"
	icon_state = "bluespace_tray"
	desc = "A tray created using bluespace technology to fit more food on it."
	max_items = 30 // far more items
	custom_materials = list(/datum/material/iron = 2000, /datum/material/bluespace = 500)

/*
 *	Chemistry bag - IT'S A MEDICAL BAG NOW, IN YOUR FACE SCIENCE
 */

/obj/item/storage/bag/chemistry
	name = "medical bag"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bag"
	desc = "A bag for holding a variety of medical supplies."
	resistance_flags = FLAMMABLE
	component_type = /datum/component/storage/concrete/bag/chem_med_etc

/*	Now in tribal mode!*/

/obj/item/storage/bag/chemistry/tribal
	name = "tribal medicinal bag"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "tribal_chembag"
	desc = "A bag for holding a variety of tribal medical supplies."
	resistance_flags = FLAMMABLE

/*
 *  Biowaste bag (mostly for xenobiologists)
 */

/obj/item/storage/bag/bio
	name = "bio bag"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "biobag"
	desc = "A well-insulated bag for the safe carrying of organs, limbs and IV bags."
	resistance_flags = FLAMMABLE
	component_type = /datum/component/storage/concrete/bag/chem_med_etc

/obj/item/storage/bag/bio/holding
	name = "bio bag of holding"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bspace_biobag"
	desc = "A bag for the safe transportation and disposal of biowaste and other biological materials."
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/bag/bio/holding/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = INFINITY
	STR.max_items = 100

/obj/item/storage/bag/ammo
	name = "ammo pouch"
	desc = "A pouch for your ammo that goes in your pocket."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "ammopouch"
	slot_flags = INV_SLOTBIT_POCKET
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/ammo/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.display_numerical_stacking = FALSE
	STR.can_hold = typecacheof(list(/obj/item/ammo_box/magazine, /obj/item/ammo_casing))

/obj/item/storage/bag/material
	name = "material pouch"
	desc = "A pouch for sheets and RCD ammunition that manages to hang where you would normally put things in your pocket."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "materialpouch"
	slot_flags = INV_SLOTBIT_POCKET
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/material/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = INFINITY
	STR.max_items = 2
	STR.display_numerical_stacking = TRUE
	STR.can_hold = typecacheof(list(/obj/item/rcd_ammo, /obj/item/stack/sheet))

/obj/item/storage/bag/salvage
	name = "salvage sack"
	desc = "A sack for your salvage."
	icon = 'icons/obj/janitor.dmi' //im lazy
	icon_state = "trashbag"
	inhand_icon_state = "trashbag"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	resistance_flags = FLAMMABLE
	component_type = /datum/component/storage/concrete/bag/salvage

/obj/item/storage/bag/salvagestorage
	name = "salvage storage sack"
	desc = "A sack for storing your game-lagging piles of salvage components."
	icon = 'icons/obj/janitor.dmi' //im lazy
	icon_state = "trashbag"
	inhand_icon_state = "trashbag"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	resistance_flags = FLAMMABLE
	component_type = /datum/component/storage/concrete/bag/salvage

/obj/item/storage/bag/casings
	name = "casing bag"
	icon = 'icons/obj/storage.dmi'
	icon_state = "bag_cases"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FLAMMABLE
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	var/spam_protection = FALSE
	var/mob/listeningTo
	component_type = /datum/component/storage/concrete/bag/casing
	var/last_inserted_type
	var/last_was_empty = FALSE

/obj/item/storage/bag/casings/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/casings/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED,PROC_REF(Pickup_casings))
	listeningTo = user

/// finds a casing and return it
/// returns null if none found, OR, and this is a big OR
/// OR if we've previously inserted a loaded casing, and there were no other empty casings, and the next casing would be different
/// than the last inserted casing. This is so that, by default, it'll load only one type of casng per click
/obj/item/storage/bag/casings/proc/find_casing(mob/living/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!LAZYLEN(contents))
		return
	var/list/loaded_casings = list()
	var/obj/item/ammo_casing/out
	var/should_stop = FALSE
	for(var/obj/item/ammo_casing/bluuet in contents)
		if(bluuet.BB)
			if(last_was_empty)
				should_stop = TRUE
				last_was_empty = FALSE
			// if(last_inserted_type)
			// 	if(bluuet.type == last_inserted_type)
			// 		out = bluuet
			// 		break
			// else
			loaded_casings |= bluuet
		else
			out = bluuet // ezpz
			last_was_empty = TRUE
			should_stop = FALSE
			break
	if(should_stop)
		return FALSE
	if(out)
		return out
	// if(last_inserted_type) // we didnt find a casing like the one we last inserted, so attempt to break the operation
	// 	last_inserted_type = null
	// 	return
	out = LAZYACCESS(loaded_casings, 1)
	if(out)
		last_inserted_type = out.type
		return out

/obj/item/storage/bag/casings/proc/Pickup_casings(mob/living/user)
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/obj/item/ammo_casing/loosie in tile)
			if(!is_type_in_typecache(loosie, STR.can_hold))
				continue
			if(!loosie.is_pickable)
				continue
			if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, loosie, user, TRUE))
				loosie.transform = initial(loosie.transform)
				loosie.dir = initial(loosie.dir)
				show_message = TRUE
				continue
			if(!spam_protection)
				to_chat(user, span_warning("Your [name] is full and can't hold any more!"))
				spam_protection = TRUE
				break

	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		user.visible_message(span_notice("[user] scoops up the casings beneath [user.p_them()]."), \
			span_notice("You scoop up the casings beneath you with your [name]."))
	spam_protection = FALSE

/obj/item/storage/bag/casings/debug_casings
	name = "debug casing bag"
	color = "#FF00FF"

/obj/item/storage/bag/casings/debug_casings/PopulateContents()
	var/list/bullet_types = list()
	bullet_types |= typesof(/obj/item/ammo_casing/m44)
	bullet_types |= typesof(/obj/item/ammo_casing/c10mm)
	bullet_types |= typesof(/obj/item/ammo_casing/c9mm)

	for(var/i in 1 to 200)
		var/obj/item/ammo_casing/out = pick(bullet_types)
		new out(src, pick(1,0))
	new /obj/machinery/autolathe/ammo/improvised(get_turf(src))

/obj/item/storage/bag/tribe_quiver //tribal quiver as opposed to nontribal quiver? 
	name = "belt quiver"
	desc = "A simple leather quiver designed for holding arrows. \n\n Smack a bow with it to have that bow automatically load arrows from the quiver!"
	icon = 'icons/obj/clothing/belts.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "quiver"
	inhand_icon_state = "tribal_quiver"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT
	component_type = /datum/component/storage/concrete/bag/quiver
	var/spam_protection = FALSE
	var/mob/listeningTo
	var/last_inserted_type
	var/last_was_empty = FALSE

/obj/item/storage/bag/tribe_quiver/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/gun/ballistic/bow))
		var/obj/item/gun/ballistic/bow/boe = W
		if(boe.link_quiver_to_bow(user, src))
			return
	. = ..()


/obj/item/storage/bag/tribe_quiver/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/tribe_quiver/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED,PROC_REF(Pickup_casings))
	listeningTo = user

/// finds a casing and return it
/// returns null if none found, OR, and this is a big OR
/// OR if we've previously inserted a loaded casing, and there were no other empty casings, and the next casing would be different
/// than the last inserted casing. This is so that, by default, it'll load only one type of casng per click
/obj/item/storage/bag/tribe_quiver/proc/find_casing(mob/living/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!LAZYLEN(contents))
		return
	var/list/loaded_casings = list()
	var/obj/item/ammo_casing/out
	var/should_stop = FALSE
	for(var/obj/item/ammo_casing/bluuet in contents)
		if(bluuet.BB)
			if(last_was_empty)
				should_stop = TRUE
				last_was_empty = FALSE
			// if(last_inserted_type)
			// 	if(bluuet.type == last_inserted_type)
			// 		out = bluuet
			// 		break
			// else
			loaded_casings |= bluuet
		else
			out = bluuet // ezpz
			last_was_empty = TRUE
			should_stop = FALSE
			break
	if(should_stop)
		return FALSE
	if(out)
		return out
	// if(last_inserted_type) // we didnt find a casing like the one we last inserted, so attempt to break the operation
	// 	last_inserted_type = null
	// 	return
	out = LAZYACCESS(loaded_casings, 1)
	if(out)
		last_inserted_type = out.type
		return out

/obj/item/storage/bag/tribe_quiver/proc/Pickup_casings(mob/living/user)
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/obj/item/ammo_casing/caseless/arrow/loosie in tile)
			if(!is_type_in_typecache(loosie, STR.can_hold))
				continue
			if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, loosie, user, TRUE))
				loosie.transform = initial(loosie.transform)
				loosie.dir = initial(loosie.dir)
				show_message = TRUE
				continue
			if(!spam_protection)
				to_chat(user, span_warning("Your [name] is full and can't hold any more!"))
				spam_protection = TRUE
				break

	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		user.visible_message(span_notice("[user] scoops up the arrows beneath [user.p_them()]."), \
			span_notice("You scoop up the arrows beneath you with your [name]."))
	spam_protection = FALSE


/obj/item/storage/bag/tribe_quiver/full/PopulateContents()
	for(var/i in 1 to 12)
		new /obj/item/ammo_casing/caseless/arrow/field(src)//12 total for now. just need one full one defined, for starting kits

/obj/item/storage/bag/tribe_quiver/light
	name = "light quiver"
	desc = "A compact, lightweight quiver, that can be tucked just about anywhere to hold some arrows."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "quiver"
	inhand_icon_state = "tribal_quiver"
	w_class = WEIGHT_CLASS_SMALL
	component_type = /datum/component/storage/concrete/bag/quiver/light_quiver

/obj/item/storage/bag/tribe_quiver/light/full/PopulateContents()
	for(var/i in 35 to 50)
		new /obj/item/ammo_casing/caseless/arrow/field(src)//12 total for now. just need one full one defined, for starting kits

/obj/item/storage/bag/tribe_quiver/light/full/flint/PopulateContents()
	for(var/i in 35 to 50)
		new /obj/item/ammo_casing/caseless/arrow/flint(src)//Little more applicable for tribals.

/obj/item/storage/bag/tribe_quiver/heavy
	name = "back quiver"
	desc = "A large quiver worn on the back, made to hold all the arrows you might need."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "quiver"
	inhand_icon_state = "tribal_quiver"
	component_type = /datum/component/storage/concrete/bag/quiver/heavy_quiver

/obj/item/storage/bag/tribe_quiver/heavy/full/PopulateContents()
	for(var/i in 75 to 100)
		new /obj/item/ammo_casing/caseless/arrow/field(src)//12 total for now. just need one full one defined, for starting kits

/obj/item/storage/bag/tribe_quiver/AltClick(mob/living/carbon/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!length(user.get_empty_held_indexes()))
		to_chat(user, span_warning("Your hands are full!"))
		return
	var/obj/item/ammo_casing/caseless/arrow/L = locate() in contents
	if(L)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, L, user)
		user.put_in_hands(L)
		to_chat(user, span_notice("You take \a [L] out of the quiver."))
		return TRUE
	var/obj/item/ammo_casing/caseless/W = locate() in contents
	if(W && contents.len > 0)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, W, user)
		user.put_in_hands(W)
		to_chat(user, span_notice("You take \a [W] out of the quiver."))
	else
		to_chat(user, span_notice("There is nothing left in the quiver."))
	return TRUE

/obj/item/storage/bag/trash/sack
	name = "leather sack"
	desc = "A sack made out of rough leathers. It's probably not filled with gifts."
	icon = 'icons/obj/storage.dmi'
	icon_state = "sack"
	inhand_icon_state = "sack"


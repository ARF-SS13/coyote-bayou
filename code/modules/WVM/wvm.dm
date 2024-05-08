/* Code by Tienn */
/* Sprites by Moonmandoom*/

#define STATE_IDLE 0
#define STATE_SERVICE 1
#define STATE_VEND 2
#define STATE_LOCKOPEN 3

#define CASH_CAP_VENDOR 1

/* exchange rates X * CAP*/
#define CASH_AUR_VENDOR 100 /* 100 copper to 1 gold */
#define CASH_DEN_VENDOR 10 /* 10 copper to 1 silver */
#define CASH_NCR_VENDOR 0.5 /* $100 to 50 copper */

// Total number of caps value spent in the Trading Protectrons Vendors
GLOBAL_VAR_INIT(vendor_cash, 0)

/obj/machinery/trading_machine
	name = "Wasteland Vending Machine"
	desc = "Wasteland Vending Machine! Unlock with a key, load your goods, and profit!"

	icon = 'icons/WVM/machines.dmi'
	icon_state = "custom_idle"
	obj_flags = UNIQUE_RENAME
	var/idle_icon_state = "custom_idle"
	var/service_icon_state = "custom_service"
	var/lock_icon_state = "custom_lock"

	anchored = 1
	density = 1
	layer = 2.9
	verb_say = "beeps"
	verb_ask = "beeps"
	verb_exclaim = "beeps"
	obj_integrity = 300
	max_integrity = 300
	integrity_failure = 100
	armor = list(melee = 20, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 50, acid = 70)
	use_power = 0

	var/stored_item_type = list(/obj/item)
	var/content[0]		// store items
	var/stored_caps = 0	// store caps
	var/obj/item/lock_part/lock = null
	var/machine_state = STATE_IDLE // 0 - working, 1 - on service, 2 - on vending, 3 - open lock
	var/id = 0
	var/create_lock = TRUE
	var/create_key = TRUE
	var/create_description = FALSE
	var/basic_price = 20
	var/expected_price = 0
	var/obj/item/vending_item
	var/item_not_acceptable_message = "Something is wrong... Can't insert an item."

/* Weapon Vending Machine*/
/obj/machinery/trading_machine/weapon
	name = "Weapon Vending Machine"
	icon = 'icons/WVM/machines.dmi'
	icon_state = "weapon_idle"
	idle_icon_state = "weapon_idle"
	service_icon_state = "weapon_service"
	lock_icon_state = "weapon_lock"

/* Ammo Vending Machine*/
/obj/machinery/trading_machine/ammo
	name = "Ammo Vending Machine"
	icon = 'icons/WVM/machines.dmi'
	icon_state = "ammo_idle"
	idle_icon_state = "ammo_idle"
	service_icon_state = "ammo_service"
	lock_icon_state = "ammo_lock"

/* Armor Vending Machine*/
/obj/machinery/trading_machine/armor
	name = "Armor Vending Machine"
	icon = 'icons/WVM/machines.dmi'
	icon_state = "armor_idle"
	idle_icon_state = "armor_idle"
	service_icon_state = "armor_service"
	lock_icon_state = "armor_lock"

/* Medical Vending Machine*/
/obj/machinery/trading_machine/medical
	name = "Medicine Vending Machine"
	icon = 'icons/WVM/machines.dmi'
	icon_state = "med_idle"
	idle_icon_state = "med_idle"
	service_icon_state = "med_service"
	lock_icon_state = "med_lock"

/* Initialization */
/obj/machinery/trading_machine/Initialize()
	. = ..()
	if(create_lock)
		lock = new /obj/item/lock_part()
		lock.forceMove(src)
	if(create_key)
		var/obj/item/key/vending/K = new /obj/item/key/vending()
		K.name = "[src.name] key"
		K.forceMove(src.loc)
		if(lock)
			lock.is_secured = 0
			lock.store_key(K)
			lock.is_secured = 1
	if(create_description)
		var/obj/item/paper/P = new /obj/item/paper
		P.info = get_paper_description_data()
		P.update_icon()
		P.forceMove(src.loc)

/* Adding item to machine and spawn Set Price dialog */
/obj/machinery/trading_machine/proc/add_item(obj/item/Itm, mob/living/carbon/human/user)
	if(machine_state != STATE_SERVICE)
		return

	if(istype(Itm, /obj/item/clothing/head/mob_holder))
		user?.show_message(span_alert("[Itm] is [prob(50) ? "worthless" : "priceless"], and thus impossible to insert into the machine"))
		return

	var/item_allowed = is_available_category(Itm)
	var/status_allowed = is_acceptable_item_state(Itm)

	if(item_allowed && status_allowed)
		var/price = input(usr, "Enter price for " + Itm.name + ".", "Setup Price", basic_price) as null|num

		if(!price)
			return

		content[Itm] = min(max(round(price),0),50000)

		if(istype(Itm.loc, /mob))
			var/mob/M = Itm.loc
			if(!M.dropItemToGround(Itm))
				to_chat(usr, span_warning("\the [Itm] is stuck to your hand, you cannot put it in \the [src]!"))
				return

		Itm.forceMove(src)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		to_chat(usr, "You loaded [Itm.name] to vending machine. New price - [content[Itm]] copper.")
		src.ui_interact(usr)
	else
		if(!item_allowed)
			playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
			to_chat(usr, "*beep* ..wrong item.")
		else if (!status_allowed)
			playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
			to_chat(usr, item_not_acceptable_message)

/* Check item type and compare it with stored_item_type */
/obj/machinery/trading_machine/proc/is_available_category(obj/item/Itm)
	for(var/item_type in stored_item_type)
		if(istype(Itm, item_type))
			return 1
	return 0

/* Hook for check item parameters */
/obj/machinery/trading_machine/proc/is_acceptable_item_state(obj/item/Itm)
	return 1

/* Remove item from machine. */
/obj/machinery/trading_machine/proc/remove_item(obj/item/ItemToRemove)
	if(content.Remove(ItemToRemove))
		ItemToRemove.forceMove(src.loc)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		src.ui_interact(usr)

/* Adding a caps to caps storage and release vending item. */
/obj/machinery/trading_machine/proc/add_caps(obj/item/I)
	if(machine_state != STATE_VEND)
		return

	if(istype(I, /obj/item/stack/f13Cash))
		if(I.use(expected_price))
			stored_caps += expected_price
			playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
			to_chat(usr, "You put [expected_price] copper to a vending machine. [vending_item.name] is vended out of it. ")
			remove_item(vending_item)
			set_state(STATE_IDLE)
			onclose(usr, "vending")
		else
			playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
			to_chat(usr, "Not enough copper.")

/* Spawn all caps on world and clear caps storage */
/obj/machinery/trading_machine/proc/remove_all_caps()
	if(stored_caps <= 0)
		return
	var/obj/item/stack/f13Cash/caps/C = new /obj/item/stack/f13Cash/caps
	if(stored_caps > C.max_amount)
		C.add(C.max_amount - 1)
		C.forceMove(src.loc)
		stored_caps -= C.max_amount
	else
		C.add(stored_caps - 1)
		C.forceMove(src.loc)
		stored_caps = 0
	playsound(src, 'sound/items/coinflip.ogg', 60, 1)
	src.ui_interact(usr)

/* Storing item and price and switch machine to vending mode*/
/obj/machinery/trading_machine/proc/vend(obj/item/Itm)
	if(content.Find(Itm))
		vending_item = Itm
		expected_price = content[Itm]
		set_state(STATE_VEND)
		src.attack_hand(usr)

/* Remove lock from machine */
/obj/machinery/trading_machine/proc/drop_lock()
	if(!lock)
		to_chat(usr, "No lock here.")
		return

	lock.forceMove(loc)
	lock = null
	playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
	src.ui_interact(usr)

/* Assign lock to this machine */
/obj/machinery/trading_machine/proc/set_lock(obj/item/lock_part/newLock)
	if(lock)
		playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
		to_chat(usr, "This machine is already have a lock")
		return
	else
		lock = newLock
		if(usr.dropItemToGround(lock))
			lock.forceMove(src)
			playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
			to_chat(usr, "Lock installed.")
	src.ui_interact(usr)

/* Switch machine to service mode */
/obj/machinery/trading_machine/proc/set_service(newMode)
	switch(machine_state)
		if(0)
			if(newMode)
				set_state(STATE_SERVICE)
		if(1)
			if(!newMode)
				set_state(STATE_IDLE)

	if(machine_state == STATE_SERVICE)
		to_chat(usr, "Vending Machine now on service")
	else
		to_chat(usr, "Vending Machine now working")
	src.ui_interact(usr)

/* Update icon depends on machine_state */
/obj/machinery/trading_machine/proc/updateIcon()
	switch(machine_state)
		if(STATE_IDLE)
			cut_overlays()
			icon_state = idle_icon_state
		if(STATE_SERVICE)
			cut_overlays()
			icon_state = service_icon_state
		if(STATE_VEND)
			cut_overlays()
			icon_state = idle_icon_state
		if(STATE_LOCKOPEN)
			cut_overlays()
			icon_state = lock_icon_state
			add_overlay(image(icon, "[initial(icon_state)]-panel"))

/* Seting machine state and update icon */
/obj/machinery/trading_machine/proc/set_state(new_state)
	if(machine_state == new_state)
		return

	if(new_state == STATE_IDLE && !lock)
		return

	if(!anchored)
		return

	machine_state = new_state
	updateIcon()

/* Welder Act */
/obj/machinery/trading_machine/welder_act(mob/living/carbon/human/user, obj/item/OtherItem)
	if(machine_state == STATE_LOCKOPEN)
		if(!OtherItem.tool_start_check(user, amount=3))
			return
		user.visible_message("[user.name] repairs \the [src].", \
						span_notice("You start repairing the vending machine."), \
						span_italic("You hear welding."))
		if(OtherItem.use_tool(src, user, 100, volume=50, amount=20))
			to_chat(user, span_notice("You repair the vending machine."))
			stat &= ~BROKEN
			obj_integrity = max_integrity

/* Attack By */
/obj/machinery/trading_machine/attackby(obj/item/OtherItem, mob/living/carbon/human/user, parameters)
	switch(machine_state)
		if(STATE_IDLE) // working

			/* Vending Key */
			if(istype(OtherItem, /obj/item/key/vending))
				if(lock)
					if(lock.check_key(OtherItem))
						set_service(STATE_SERVICE)
						playsound(src, 'sound/items/Ratchet.ogg', 60, 1)
					else
						playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
						to_chat(usr, "Unknown key.")
				else
					playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
					to_chat(usr, "No lock here")

			/* Other */
			else
				attack_hand(user)

		if(STATE_SERVICE) // service

			/* Screwdriver */
			if(istype(OtherItem, /obj/item/screwdriver))
				set_state(STATE_LOCKOPEN)
				playsound(src, 'sound/items/Screwdriver.ogg', 60, 1)

			/* Locker */
			if(istype(OtherItem, /obj/item/lock_part))
				set_lock(OtherItem)
				playsound(src, 'sound/items/Crowbar.ogg', 60, 1)

			/* Key */
			if(istype(OtherItem, /obj/item/key/vending))
				if(lock)
					var/obj/item/key/vending/used_key = OtherItem
					if(lock.check_key(OtherItem) || id == used_key.id)
						set_state(STATE_IDLE)
						playsound(src, 'sound/items/Ratchet.ogg', 60, 1)
					else
						playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
						to_chat(usr, "Unknown key.")
				else
					playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
					to_chat(usr, "No lock")


			else if(is_available_category(OtherItem))
				add_item(OtherItem, user)

			else
				attack_hand(user)

		if(STATE_VEND) // vending
			// Caps
			if(istype(OtherItem, /obj/item/stack/f13Cash))
				add_caps(OtherItem)
			else
				attack_hand(user)

		if(STATE_LOCKOPEN)
			/* Screwdriver */
			if(istype(OtherItem, /obj/item/screwdriver))
				set_state(STATE_SERVICE)
				playsound(src, 'sound/items/Screwdriver2.ogg', 60, 1)


			/* Wrench */
			else if(istype(OtherItem, /obj/item/wrench))
				if(src.can_be_unfasten_wrench(user))
					var/prev_anchor = anchored
					src.default_unfasten_wrench(user, OtherItem)
					if(anchored != prev_anchor)
						playsound(src, 'sound/items/Ratchet.ogg', 60, 1)

			/* Crowbar */
			else if(istype(OtherItem, /obj/item/crowbar))
				drop_lock()

			else if(istype(OtherItem, /obj/item/lock_part))
				var/obj/item/lock_part/P = OtherItem
				if(P.is_secured)
					set_lock(OtherItem)
				else
					playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
					to_chat(usr, "You need to secure lock first. Use screwdriver.")

	src.ui_interact(user)

/* Spawn input dialog and set item price */
/obj/machinery/trading_machine/proc/set_price_by_input(obj/item/Itm, mob/user)
	if(machine_state != STATE_SERVICE)
		return

	var/new_price = input(user, "Enter price for " + Itm.name + ".", "Setup Price", content[Itm]) as null|num
	if(new_price)
		content[Itm] = 	max(round(new_price),0)

		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 60, 1)
		src.ui_interact(user)

/* Find item by name and price in content and return type */
/obj/machinery/trading_machine/proc/find_item(item_name, item_price)
	for(var/obj/item/Itm in content)
		item_price = text2num(item_price)
		if(content[Itm] == item_price && sanitize(Itm.name) == sanitize(item_name))
			return Itm

/* Attack Hand */
/obj/machinery/trading_machine/attack_hand(mob/user)
	ui_interact(user)

/* Design UI here */
/obj/machinery/trading_machine/ui_interact(mob/user)
	. = ..()
	var/datum/browser/popup = new(user, "vending", (name), 400, 500)
	popup.set_content(get_ui_content(machine_state))
	popup.open()

/obj/machinery/trading_machine/proc/get_ui_content(state)
	var/dat = ""
	switch(state)
		// --- Work
		if(STATE_IDLE)
			dat += "<h3>Select an item</h3>"
			dat += "<div class='statusDisplay'>"
			if(content.len == 0)
				dat += "<font color = 'red'>No products loaded!</font>"
			else
				for(var/obj/item/Itm in content)
					var/item_name = url_encode(Itm.name)
					var/price = content[Itm]
					dat += "<a href='byond://?src=\ref[src];vend=[item_name];current_price=[price]'>[Itm.name] | [price] copper</a> "
					dat += "<a href='byond://?src=\ref[src];examine=[item_name];current_price=[price]'>Examine</a><br> "

		//--- Service
		if(STATE_SERVICE)
			dat += "<h3>Machine setup menu</h3>"
			dat += "<div class='statusDisplay'>"
			dat += "<font color='green'>copper stored - [stored_caps]</font>"
			dat += "<a href='?src=\ref[src];removecaps=1'>Unload</a>"
			dat += "<h4> Items </h4> "

			if(content.len == 0)
				dat += "<font color = 'red'>No products loaded!</font>"
			else
				for(var/obj/item/Itm in content)
					var/item_name = url_encode(Itm.name)
					var/price = content[Itm]
					dat += "<b>[Itm.name]</b> - [content[Itm]] caps"
					dat += "<a href='?src=\ref[src];setprice=[item_name];current_price=[price]'>Set price</a> "
					dat += "<a href='?src=\ref[src];remove=[item_name];current_price=[price]'>Remove</a> <br>"

		// --- Vend
		if(STATE_VEND)
			dat += "<h3>Select an item</h3>"
			dat += "<div class='statusDisplay'>"
			dat += "<font color = 'red'>Waiting for [expected_price] caps!</font>"
			dat += "<a href='?src=\ref[src];back=1'> Back</a> "

		// --- Lock Open
		if(STATE_LOCKOPEN)
			dat += ""

	return dat

/obj/machinery/trading_machine/proc/get_paper_description_data()
	var/data
	data += "<h1> Wasteland Wending Machines </h1>"
	data += "Wasteland Trading Company guide."
	return data

/* TOPIC */
/obj/machinery/trading_machine/Topic(href, href_list)
	if(..())
		return

	if(href_list["vend"])
		var/vend_item_name = href_list["vend"]
		var/actual_price = href_list["current_price"]
		to_chat(usr, "Vending [vend_item_name]...")
		var/obj/item/I = find_item(vend_item_name, actual_price)
		if(I)
			vend(I)

	if(href_list["back"])
		to_chat(usr, "Machine is working")
		src.set_state(STATE_IDLE)
		ui_interact(usr)

	if(href_list["setprice"])
		to_chat(usr, "Set new price...")
		var/vend_item_name = href_list["setprice"]
		var/actual_price = href_list["current_price"]
		var/obj/item/I = find_item(vend_item_name, actual_price)
		if(I)
			set_price_by_input(I, usr)

	if(href_list["remove"])
		var/vend_item_name = href_list["remove"]
		var/actual_price = href_list["current_price"]
		var/obj/item/I = find_item(vend_item_name, actual_price)
		if(I)
			to_chat(usr, "Unloading item [href_list["unload"]]")
			remove_item(I)

	if(href_list["removecaps"])
		remove_all_caps()

	if(href_list["examine"])
		var/item_name = href_list["examine"]
		var/actual_price = href_list["current_price"]
		var/obj/item/I = find_item(item_name, actual_price)
		I.examine(usr)

	ui_interact()

/**********************Trading Protectron Vendors**************************/

/obj/machinery/mineral/wasteland_vendor
	name = "Wasteland Vending Machine"
	desc = "Wasteland Vending Machine manned by old reprogrammed RobCo trading protectrons."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "weapon_idle"

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9

	var/stored_caps = 0	// store caps
	var/expected_price = 0
	var/list/prize_list = list()  //if you add something to this, please, for the love of god, sort it by price/type. use tabs and not spaces.
	var/list/highpop_list = list()  //if you add something to this, please, for the love of god, sort it by price/type. use tabs and not spaces.

/obj/machinery/mineral/wasteland_vendor/medical
	name = "Wasteland Vending Machine - Medical"
	icon_state = "numed_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Syringe",						/obj/item/reagent_containers/syringe,								5),
		new /datum/data/wasteland_equipment("Rad-X Bottle",					/obj/item/storage/pill_bottle/chem_tin/radx,						25),
		new /datum/data/wasteland_equipment("RadAway",						/obj/item/reagent_containers/blood/radaway,							40),
		new /datum/data/wasteland_equipment("Basic Bandages",				/obj/item/stack/medical/gauze/improvised,							30),
		new /datum/data/wasteland_equipment("Basic Stitches",				/obj/item/stack/medical/suture/emergency/fifteen,					30),
		new /datum/data/wasteland_equipment("Healing Powder",				/obj/item/reagent_containers/pill/healingpowder,					30),
		new /datum/data/wasteland_equipment("Survival Medipen",				/obj/item/reagent_containers/hypospray/medipen/survival,			120),
		new /datum/data/wasteland_equipment("Improvised Defibrillator",		/obj/item/defibrillator/primitive,									150),
		new /datum/data/wasteland_equipment("Surgery for Wastelanders",		/obj/item/book/granter/trait/lowsurgery,							300),
		new /datum/data/wasteland_equipment("D.C. Journal of Internal Medicine",		/obj/item/book/granter/trait/midsurgery,				750),
		new /datum/data/wasteland_equipment("Chemistry for Wastelanders",	/obj/item/book/granter/trait/chemistry,								1500)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Syringe",						/obj/item/reagent_containers/syringe,								5),
		new /datum/data/wasteland_equipment("Rad-X Bottle",					/obj/item/storage/pill_bottle/chem_tin/radx,						25),
		new /datum/data/wasteland_equipment("RadAway",						/obj/item/reagent_containers/blood/radaway,							40),
		new /datum/data/wasteland_equipment("Basic Bandages",				/obj/item/stack/medical/gauze/improvised,							30),
		new /datum/data/wasteland_equipment("Basic Stitches",				/obj/item/stack/medical/suture/emergency/fifteen,					30),
		new /datum/data/wasteland_equipment("Healing Powder",				/obj/item/reagent_containers/pill/healingpowder,					30),
		new /datum/data/wasteland_equipment("Survival Medipen",				/obj/item/reagent_containers/hypospray/medipen/survival,			120),
		new /datum/data/wasteland_equipment("Improvised Defibrillator",		/obj/item/defibrillator/primitive,									150),
		new /datum/data/wasteland_equipment("Surgery for Wastelanders",		/obj/item/book/granter/trait/lowsurgery,							300),
		new /datum/data/wasteland_equipment("D.C. Journal of Internal Medicine",		/obj/item/book/granter/trait/midsurgery,				750),
		new /datum/data/wasteland_equipment("Chemistry for Wastelanders",	/obj/item/book/granter/trait/chemistry,								1500)
		)

/obj/machinery/mineral/wasteland_vendor/supermedical
	name = "Clinic Vending Machine - Medical"
	icon_state = "numed_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Syringe",						/obj/item/reagent_containers/syringe,								5),
		new /datum/data/wasteland_equipment("Rad-X Bottle",					/obj/item/storage/pill_bottle/chem_tin/radx,						5),
		new /datum/data/wasteland_equipment("RadAway",						/obj/item/reagent_containers/blood/radaway,							15),
		new /datum/data/wasteland_equipment("Standard Bandages",			/obj/item/stack/medical/gauze,										15),
		new /datum/data/wasteland_equipment("Standard Stitches",			/obj/item/stack/medical/suture,										15),
		new /datum/data/wasteland_equipment("Healing Powder Pack",			/obj/item/storage/box/medicine/powder5,								15),
		new /datum/data/wasteland_equipment("Bitter Drink Pack",			/obj/item/storage/box/medicine/bitterdrink5,						20),
		new /datum/data/wasteland_equipment("Stimpak Pack",					/obj/item/storage/box/medicine/stimpaks/stimpaks5,					30),
		new /datum/data/wasteland_equipment("Improvised Defibrillator",		/obj/item/defibrillator,											75),
		new /datum/data/wasteland_equipment("Surgery for Wastelanders",		/obj/item/book/granter/trait/lowsurgery,							150),
		new /datum/data/wasteland_equipment("D.C. Journal of Internal Medicine",		/obj/item/book/granter/trait/midsurgery,				500),
		new /datum/data/wasteland_equipment("Chemistry for Wastelanders",	/obj/item/book/granter/trait/chemistry,								1000)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Syringe",						/obj/item/reagent_containers/syringe,								5),
		new /datum/data/wasteland_equipment("Rad-X Bottle",					/obj/item/storage/pill_bottle/chem_tin/radx,						5),
		new /datum/data/wasteland_equipment("RadAway",						/obj/item/reagent_containers/blood/radaway,							15),
		new /datum/data/wasteland_equipment("Standard Bandages",			/obj/item/stack/medical/gauze,										15),
		new /datum/data/wasteland_equipment("Standard Stitches",			/obj/item/stack/medical/suture,										15),
		new /datum/data/wasteland_equipment("Healing Powder Pack",			/obj/item/storage/box/medicine/powder5,								15),
		new /datum/data/wasteland_equipment("Bitter Drink Pack",			/obj/item/storage/box/medicine/bitterdrink5,						20),
		new /datum/data/wasteland_equipment("Stimpak Pack",					/obj/item/storage/box/medicine/stimpaks/stimpaks5,					30),
		new /datum/data/wasteland_equipment("Improvised Defibrillator",		/obj/item/defibrillator,											75),
		new /datum/data/wasteland_equipment("Surgery for Wastelanders",		/obj/item/book/granter/trait/lowsurgery,							150),
		new /datum/data/wasteland_equipment("D.C. Journal of Internal Medicine",		/obj/item/book/granter/trait/midsurgery,				500),
		new /datum/data/wasteland_equipment("Chemistry for Wastelanders",	/obj/item/book/granter/trait/chemistry,								1000)
		)

/obj/machinery/mineral/wasteland_vendor/khanchem
	name = "P.A.P.A"
	icon_state = "khan_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						30),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/pill/patch/psycho,				30),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						30),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						30),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						30),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/pill/patch/medx,				80),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						90),
		new /datum/data/wasteland_equipment("Great Khan helmet",			/obj/item/clothing/head/helmet/f13/khan,							20),
		new /datum/data/wasteland_equipment("Great Khan bandana",			/obj/item/clothing/head/helmet/f13/khan/bandana,					20),
		new /datum/data/wasteland_equipment("Great Khan fur-trimmed helmet",	/obj/item/clothing/head/helmet/f13/khan/pelt,					20),
		new /datum/data/wasteland_equipment("Great Khan full helmet",		/obj/item/clothing/head/helmet/f13/khan/fullhelm,					100),
		new /datum/data/wasteland_equipment("Great Khan battlecoat",		/obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat,		300),
		new /datum/data/wasteland_equipment("Great Khan armored jacket",	/obj/item/clothing/suit/toggle/labcoat/khan_jacket/armored,		100),
		new /datum/data/wasteland_equipment("Great Khan jacket",			/obj/item/clothing/suit/toggle/labcoat/khan_jacket,				50),
		new /datum/data/wasteland_equipment("Great Khan uniform",			/obj/item/clothing/under/f13/khan,									10),
		new /datum/data/wasteland_equipment("Great Khan Jorts",				/obj/item/clothing/under/f13/khan/shorts,							10),
		new /datum/data/wasteland_equipment("Great Khan Booty Shorts",		/obj/item/clothing/under/f13/khan/booty,							10),
		new /datum/data/wasteland_equipment("Great Khan boots",				/obj/item/clothing/shoes/f13/military/khan,							15),
		new /datum/data/wasteland_equipment("Great Khan pelt boots",		/obj/item/clothing/shoes/f13/military/khan_pelt,					15)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						30),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/pill/patch/psycho,				30),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						30),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						30),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						30),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/pill/patch/medx,				80),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						90),
		new /datum/data/wasteland_equipment("Great Khan helmet",			/obj/item/clothing/head/helmet/f13/khan,							20),
		new /datum/data/wasteland_equipment("Great Khan bandana",			/obj/item/clothing/head/helmet/f13/khan/bandana,					20),
		new /datum/data/wasteland_equipment("Great Khan fur-trimmed helmet",	/obj/item/clothing/head/helmet/f13/khan/pelt,					20),
		new /datum/data/wasteland_equipment("Great Khan full helmet",		/obj/item/clothing/head/helmet/f13/khan/fullhelm,					100),
		new /datum/data/wasteland_equipment("Great Khan battlecoat",		/obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat,		300),
		new /datum/data/wasteland_equipment("Great Khan armored jacket",	/obj/item/clothing/suit/toggle/labcoat/khan_jacket/armored,		100),
		new /datum/data/wasteland_equipment("Great Khan jacket",			/obj/item/clothing/suit/toggle/labcoat/khan_jacket,				50),
		new /datum/data/wasteland_equipment("Great Khan uniform",			/obj/item/clothing/under/f13/khan,									10),
		new /datum/data/wasteland_equipment("Great Khan Jorts",				/obj/item/clothing/under/f13/khan/shorts,							10),
		new /datum/data/wasteland_equipment("Great Khan Booty Shorts",		/obj/item/clothing/under/f13/khan/booty,							10),
		new /datum/data/wasteland_equipment("Great Khan boots",				/obj/item/clothing/shoes/f13/military/khan,							15),
		new /datum/data/wasteland_equipment("Great Khan pelt boots",		/obj/item/clothing/shoes/f13/military/khan_pelt,					15)
		)

/obj/machinery/mineral/wasteland_vendor/denchem
	name = "Chem Dispenser"
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						60),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/pill/patch/psycho,				60),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						60),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						60),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						60),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/pill/patch/medx,							60),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						60),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/pill/patch/psycho,				60),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						60),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						60),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						60),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/pill/patch/medx,							60),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200)
		)

/obj/machinery/mineral/wasteland_vendor/followerterminal
	name = "Follower's Resupply Terminal"
	desc = "a vending machine stocked with imported medical supplies. The pricing is to cover the cost of shipping and handling."
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Soap",							/obj/item/soap/syndie,												5),
		new /datum/data/wasteland_equipment("Gas Mask",						/obj/item/clothing/mask/gas,										15),
		new /datum/data/wasteland_equipment("Advanced Mop",					/obj/item/mop/advanced,												50),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						75),
		new /datum/data/wasteland_equipment("Metamaterial Beaker",			/obj/item/reagent_containers/glass/beaker/meta,						125),
		new /datum/data/wasteland_equipment("Medical HUD",					/obj/item/clothing/glasses/hud/health,								125),
		new /datum/data/wasteland_equipment("Prosthetic Left Arm",			/obj/item/bodypart/l_arm/robot,										125),
		new /datum/data/wasteland_equipment("Prosthetic Right Arm",		/obj/item/bodypart/r_arm/robot,										125),
		new /datum/data/wasteland_equipment("Prosthetic Left Leg",			/obj/item/bodypart/l_leg/robot,										125),
		new /datum/data/wasteland_equipment("Prosthetic Right Leg",		/obj/item/bodypart/r_leg/robot,										125),
		new /datum/data/wasteland_equipment("Integrated Toolset Implant",	/obj/item/organ/cyberimp/arm/toolset,								150),
		new /datum/data/wasteland_equipment("Defibrillator",				/obj/item/defibrillator,											175),
		new /datum/data/wasteland_equipment("Chest reviver Implant",			/obj/item/organ/cyberimp/chest/reviver,								250),
		new /datum/data/wasteland_equipment("Upgraded Prosthetic Limbs",	/obj/item/storage/box/sparelimbs,									300),
		new /datum/data/wasteland_equipment("Cat",							/mob/living/simple_animal/pet/cat/Runtime,							2000),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,							50),
		)

	highpop_list = list(
		new /datum/data/wasteland_equipment("Soap",							/obj/item/soap/syndie,												5),
		new /datum/data/wasteland_equipment("Gas Mask",						/obj/item/clothing/mask/gas,										15),
		new /datum/data/wasteland_equipment("Advanced Mop",					/obj/item/mop/advanced,												50),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						75),
		new /datum/data/wasteland_equipment("Metamaterial Beaker",			/obj/item/reagent_containers/glass/beaker/meta,						125),
		new /datum/data/wasteland_equipment("Medical HUD",					/obj/item/clothing/glasses/hud/health,								125),
		new /datum/data/wasteland_equipment("Prosthetic Left Arm",			/obj/item/bodypart/l_arm/robot,										125),
		new /datum/data/wasteland_equipment("Prosthetic Right Arm",			/obj/item/bodypart/r_arm/robot,										125),
		new /datum/data/wasteland_equipment("Prosthetic Left Leg",			/obj/item/bodypart/l_leg/robot,										125),
		new /datum/data/wasteland_equipment("Prosthetic Right Leg",			/obj/item/bodypart/r_leg/robot,										125),
		new /datum/data/wasteland_equipment("Integrated Toolset Implant",	/obj/item/organ/cyberimp/arm/toolset,								150),
		new /datum/data/wasteland_equipment("Defibrillator",				/obj/item/defibrillator,											175),
		new /datum/data/wasteland_equipment("Chest reviver Implant",		/obj/item/organ/cyberimp/chest/reviver,								250),
		new /datum/data/wasteland_equipment("Upgraded Prosthetic Limbs",	/obj/item/storage/box/sparelimbs,									300),
		new /datum/data/wasteland_equipment("Cat",							/mob/living/simple_animal/pet/cat/Runtime,							2000),
		)

/obj/machinery/mineral/wasteland_vendor/weapons
	name = "Wasteland Vending Machine - Weapons"
	icon_state = "nuweapon_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Civilian Weapon Kit (Starter Weapons + Ammo)",	/obj/item/kit_spawner/townie,										300),
		new /datum/data/wasteland_equipment("Beretta M93R (9mm)",							/obj/item/gun/ballistic/automatic/pistol/beretta/automatic,			100),
		new /datum/data/wasteland_equipment("Sig P220 (.45)",								/obj/item/gun/ballistic/automatic/pistol/sig,						150),
		new /datum/data/wasteland_equipment("Hunting Shotgun (12 gauge)",					/obj/item/gun/ballistic/shotgun/hunting,							200),
		new /datum/data/wasteland_equipment("10mm SMG (10mm)",								/obj/item/gun/ballistic/automatic/smg/smg10mm,						300),
		new /datum/data/wasteland_equipment("Lee Enfield (.308)",							/obj/item/gun/ballistic/rifle/enfield,								225),
		new /datum/data/wasteland_equipment("Hunting Rifle (.30-06)",						/obj/item/gun/ballistic/rifle/hunting,								250),
		new /datum/data/wasteland_equipment("Hunting Revolver (.45-70)",					/obj/item/gun/ballistic/revolver/hunting,							350),
		new /datum/data/wasteland_equipment("Surplus Nash Police Rifle (5.56)",				/obj/item/gun/ballistic/automatic/marksman/policerifle,				200),
		new /datum/data/wasteland_equipment("Surplus Nash Auto Rifle (5mm)",				/obj/item/gun/ballistic/automatic/assault_carbine/policerifle,		200),
		new /datum/data/wasteland_equipment("Compliance Regulator (SEC)",					/obj/item/gun/energy/laser/complianceregulator,						50),
		new /datum/data/wasteland_equipment("AEP-7 (SEC)",									/obj/item/gun/energy/laser/pistol,									100),
		new /datum/data/wasteland_equipment("Sport Carbine (.22)",							/obj/item/gun/ballistic/automatic/sportcarbine,						75),
		new /datum/data/wasteland_equipment("Pulse Pistol (ECP)",							/obj/item/gun/energy/ionrifle/compact,								250),
		new /datum/data/wasteland_equipment("AER-9 	(MFC)",									/obj/item/gun/energy/laser/aer9,									200),
		new /datum/data/wasteland_equipment("Plasma Rifle 	(MFC)",							/obj/item/gun/energy/laser/plasma,									350),
		new /datum/data/wasteland_equipment("Pulse Rifle 	(MFC)",							/obj/item/gun/energy/ionrifle,										350),
		new /datum/data/wasteland_equipment("Mk. II TG Rifle (Crank Charge)",				/obj/item/gun/energy/laser/cranklasergun/tg/rifle,					300),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,										50),
		new /datum/data/wasteland_equipment("Seclite Flashlight",							/obj/item/flashlight/seclite,										50),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 1",						/obj/item/book/granter/crafting_recipe/gunsmith_one, 				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 2",						/obj/item/book/granter/crafting_recipe/gunsmith_two,				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 3",						/obj/item/book/granter/crafting_recipe/gunsmith_three, 				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 4",						/obj/item/book/granter/crafting_recipe/gunsmith_four, 				100),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Civilian Weapon Kit (Starter Weapons + Ammo)",	/obj/item/kit_spawner/townie,										300),
		new /datum/data/wasteland_equipment("Beretta M93R (9mm)",							/obj/item/gun/ballistic/automatic/pistol/beretta/automatic,			100),
		new /datum/data/wasteland_equipment("Sig P220 (.45)",								/obj/item/gun/ballistic/automatic/pistol/sig,						150),
		new /datum/data/wasteland_equipment("Hunting Shotgun (12 gauge)",					/obj/item/gun/ballistic/shotgun/hunting,							200),
		new /datum/data/wasteland_equipment("10mm SMG (10mm)",								/obj/item/gun/ballistic/automatic/smg/smg10mm,						300),
		new /datum/data/wasteland_equipment("Lee Enfield (.308)",							/obj/item/gun/ballistic/rifle/enfield,								225),
		new /datum/data/wasteland_equipment("Hunting Rifle (.30-06)",						/obj/item/gun/ballistic/rifle/hunting,								250),
		new /datum/data/wasteland_equipment("Hunting Revolver (.45-70)",					/obj/item/gun/ballistic/revolver/hunting,							350),
		new /datum/data/wasteland_equipment("Surplus Nash Police Rifle (5.56)",				/obj/item/gun/ballistic/automatic/marksman/policerifle,				200),
		new /datum/data/wasteland_equipment("Surplus Nash Auto Rifle (5mm)",				/obj/item/gun/ballistic/automatic/assault_carbine/policerifle,		200),
		new /datum/data/wasteland_equipment("Compliance Regulator (SEC)",					/obj/item/gun/energy/laser/complianceregulator,						50),
		new /datum/data/wasteland_equipment("AEP-7 (SEC)",									/obj/item/gun/energy/laser/pistol,									100),
		new /datum/data/wasteland_equipment("Sport Carbine (.22)",							/obj/item/gun/ballistic/automatic/sportcarbine,						75),
		new /datum/data/wasteland_equipment("Pulse Pistol (ECP)",							/obj/item/gun/energy/ionrifle/compact,								250),
		new /datum/data/wasteland_equipment("AER-9 	(MFC)",									/obj/item/gun/energy/laser/aer9,									200),
		new /datum/data/wasteland_equipment("Plasma Rifle 	(MFC)",							/obj/item/gun/energy/laser/plasma,									350),
		new /datum/data/wasteland_equipment("Pulse Rifle 	(MFC)",							/obj/item/gun/energy/ionrifle,										350),
		new /datum/data/wasteland_equipment("Mk. II TG Rifle (Crank Charge)",				/obj/item/gun/energy/laser/cranklasergun/tg/rifle,					300),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,										50),
		new /datum/data/wasteland_equipment("Seclite Flashlight",							/obj/item/flashlight/seclite,										50),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 1",						/obj/item/book/granter/crafting_recipe/gunsmith_one, 				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 2",						/obj/item/book/granter/crafting_recipe/gunsmith_two,				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 3",						/obj/item/book/granter/crafting_recipe/gunsmith_three, 				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 4",						/obj/item/book/granter/crafting_recipe/gunsmith_four, 				100),
		)


/obj/machinery/mineral/wasteland_vendor/ammo
	name = "Wasteland Vending Machine - Ammunition"
	icon_state = "nuammo_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment(".22lr Box (120 bullets)",						/obj/item/ammo_box/m22,									15),
		new /datum/data/wasteland_equipment("9mm Box (90 bullets)",							/obj/item/ammo_box/c9mm,								15),
		new /datum/data/wasteland_equipment("10mm Box (60 bullets)",						/obj/item/ammo_box/c10mm,								15),
		new /datum/data/wasteland_equipment("5mm Box (60 bullets)",							/obj/item/ammo_box/m5mmbox,								15),
		new /datum/data/wasteland_equipment("4.73mm Box (60 bullets)",						/obj/item/ammo_box/m473,								15),
		new /datum/data/wasteland_equipment("5.56x45 Box (50 bullets)",						/obj/item/ammo_box/a556,								15),
		new /datum/data/wasteland_equipment(".45 Box (50 bullets)",							/obj/item/ammo_box/c45,									15),
		new /datum/data/wasteland_equipment(".357 Box (50 bullets)",						/obj/item/ammo_box/a357box,								15),
		new /datum/data/wasteland_equipment(".44 Box (48 bullets)",							/obj/item/ammo_box/m44box,								15),
		new /datum/data/wasteland_equipment(".308 Box (40 bullets)",						/obj/item/ammo_box/a308box,								15),
		new /datum/data/wasteland_equipment("14mm Box (36 bullets)",						/obj/item/ammo_box/m14mm,								15),
		new /datum/data/wasteland_equipment("Laser Batteries (36 batteries)",				/obj/item/ammo_box/lasmusket,							15),
		new /datum/data/wasteland_equipment("Black Powder Minie Balls (32 balls)",			/obj/item/ammo_box/flintlock,							15),
		new /datum/data/wasteland_equipment(".30-06 Box (30 bullets)",						/obj/item/ammo_box/a3006box,							15),
		new /datum/data/wasteland_equipment("45-70 Box (30 bullets)",						/obj/item/ammo_box/c4570box,							15),
		new /datum/data/wasteland_equipment("Plasma Canisters (24 canisters)",				/obj/item/ammo_box/plasmamusket,						15),
		new /datum/data/wasteland_equipment(".50 BMG Box (24 bullets)",						/obj/item/ammo_box/a50MG,								15),
		new /datum/data/wasteland_equipment("12 Gauge Buckshot box (24 shells)",			/obj/item/ammo_box/shotgun/buck,						15),
		new /datum/data/wasteland_equipment("12 Gauge Slug box  (24 shells)",				/obj/item/ammo_box/shotgun/slug,						15),
		new /datum/data/wasteland_equipment("40mm HE (2 shells)", 							/obj/item/ammo_box/a40mm, 								15),
		new /datum/data/wasteland_equipment("Energy Cell (SEC)",							/obj/item/stock_parts/cell/ammo/ec,						20),
		new /datum/data/wasteland_equipment("Microfusion Cell (MFC)",						/obj/item/stock_parts/cell/ammo/mfc,					25),
		new /datum/data/wasteland_equipment("Electron Charge Pack (ECP)",					/obj/item/stock_parts/cell/ammo/ecp,					25),
		new /datum/data/wasteland_equipment("Ultracite Ammo Cell (UAC)",					/obj/item/stock_parts/cell/ammo/ultracite,				75),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,							30),
		new /datum/data/wasteland_equipment("Field Arrow (1 arrow)",						/obj/item/projectile/bullet/reusable/arrow/field,		3),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment(".22lr Box (120 bullets)",						/obj/item/ammo_box/m22,									15),
		new /datum/data/wasteland_equipment("9mm Box (90 bullets)",							/obj/item/ammo_box/c9mm,								15),
		new /datum/data/wasteland_equipment("10mm Box (60 bullets)",						/obj/item/ammo_box/c10mm,								15),
		new /datum/data/wasteland_equipment("5mm Box (60 bullets)",							/obj/item/ammo_box/m5mmbox,								15),
		new /datum/data/wasteland_equipment("4.73mm Box (60 bullets)",						/obj/item/ammo_box/m473,								15),
		new /datum/data/wasteland_equipment("5.56x45 Box (50 bullets)",						/obj/item/ammo_box/a556,								15),
		new /datum/data/wasteland_equipment(".45 Box (50 bullets)",							/obj/item/ammo_box/c45,									15),
		new /datum/data/wasteland_equipment(".357 Box (50 bullets)",						/obj/item/ammo_box/a357box,								15),
		new /datum/data/wasteland_equipment(".44 Box (48 bullets)",							/obj/item/ammo_box/m44box,								15),
		new /datum/data/wasteland_equipment(".308 Box (40 bullets)",						/obj/item/ammo_box/a308box,								15),
		new /datum/data/wasteland_equipment("14mm Box (36 bullets)",						/obj/item/ammo_box/m14mm,								15),
		new /datum/data/wasteland_equipment("Laser Batteries (36 batteries)",				/obj/item/ammo_box/lasmusket,							15),
		new /datum/data/wasteland_equipment("Black Powder Minie Balls (32 balls)",			/obj/item/ammo_box/flintlock,							15),
		new /datum/data/wasteland_equipment(".30-06 Box (30 bullets)",						/obj/item/ammo_box/a3006box,							15),
		new /datum/data/wasteland_equipment("45-70 Box (30 bullets)",						/obj/item/ammo_box/c4570box,							15),
		new /datum/data/wasteland_equipment("Plasma Canisters (24 canisters)",				/obj/item/ammo_box/plasmamusket,						15),
		new /datum/data/wasteland_equipment(".50 BMG Box (24 bullets)",						/obj/item/ammo_box/a50MG,								15),
		new /datum/data/wasteland_equipment("12 Gauge Buckshot box (24 shells)",			/obj/item/ammo_box/shotgun/buck,						15),
		new /datum/data/wasteland_equipment("12 Gauge Slug box  (24 shells)",				/obj/item/ammo_box/shotgun/slug,						15),
		new /datum/data/wasteland_equipment("40mm HE (2 shells)", 							/obj/item/ammo_box/a40mm, 								15),
		new /datum/data/wasteland_equipment("Energy Cell (SEC)",							/obj/item/stock_parts/cell/ammo/ec,						20),
		new /datum/data/wasteland_equipment("Microfusion Cell (MFC)",						/obj/item/stock_parts/cell/ammo/mfc,					25),
		new /datum/data/wasteland_equipment("Electron Charge Pack (ECP)",					/obj/item/stock_parts/cell/ammo/ecp,					25),
		new /datum/data/wasteland_equipment("Ultracite Ammo Cell (UAC)",					/obj/item/stock_parts/cell/ammo/ultracite,				75),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,							30),
		new /datum/data/wasteland_equipment("Field Arrow (1 arrow)",						/obj/item/projectile/bullet/reusable/arrow/field,		3),
		)

/obj/machinery/mineral/wasteland_vendor/badammo
	name = "Wasteland Vending Machine - Handloaded Ammunition"
	icon_state = "nuammo_idle"
	color = "#653800"
	prize_list = list(
		new /datum/data/wasteland_equipment(".22lr Box",									/obj/item/ammo_box/m22,									30),
		new /datum/data/wasteland_equipment("9mm Bag",										/obj/item/ammo_box/c9mm/improvised,						30),
		new /datum/data/wasteland_equipment("10mm Bag",										/obj/item/ammo_box/c10mm/improvised,					30),
		new /datum/data/wasteland_equipment(".45 Bag",										/obj/item/ammo_box/c45/improvised,						30),
		new /datum/data/wasteland_equipment(".357 Bag",										/obj/item/ammo_box/a357box/improvised,					30),
		new /datum/data/wasteland_equipment(".44 Bag",										/obj/item/ammo_box/m44box/improvised,					30),
		new /datum/data/wasteland_equipment("5mm Bag",										/obj/item/ammo_box/m5mmbox/improvised,					30),
		new /datum/data/wasteland_equipment("5.56x45 Bag",									/obj/item/ammo_box/a556/improvised,						30),
		new /datum/data/wasteland_equipment(".308 Bag",										/obj/item/ammo_box/a308box/improvised,					30),
		new /datum/data/wasteland_equipment("14mm Bag",										/obj/item/ammo_box/m14mm/improvised,					30),
		new /datum/data/wasteland_equipment(".30-06 Bag",									/obj/item/ammo_box/a3006box/improvised,					30),
		new /datum/data/wasteland_equipment("45-70 Bag",									/obj/item/ammo_box/c4570box/improvised,					30),
		new /datum/data/wasteland_equipment("12 Gauge Buckshot box (12 shells)",			/obj/item/ammo_box/shotgun/buck,						30),
		new /datum/data/wasteland_equipment("12 Gauge Slug box  (12 shells)",				/obj/item/ammo_box/shotgun/slug,						30),
		new /datum/data/wasteland_equipment("Shoddy Energy Cell",							/obj/item/stock_parts/cell/ammo/ec/bad,					30),
		new /datum/data/wasteland_equipment("Shoddy Microfusion Cell",						/obj/item/stock_parts/cell/ammo/mfc/bad,				30),
		new /datum/data/wasteland_equipment("Shoddy Electron Charge Pack",					/obj/item/stock_parts/cell/ammo/ecp/bad,				30),
		new /datum/data/wasteland_equipment("Laser Batteries (18 batteries)",				/obj/item/ammo_box/lasmusket,							30),
		new /datum/data/wasteland_equipment("Plasma Canisters (6 canisters)",				/obj/item/ammo_box/plasmamusket,						30),
		new /obj/item/ammo_box/flintlock("Black Powder Ammo",								/obj/item/ammo_box/flintlock,							30),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,							60),
		new /datum/data/wasteland_equipment("Field Arrow (1 arrow)",						/obj/item/projectile/bullet/reusable/arrow/field,		7),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment(".22lr Box",									/obj/item/ammo_box/m22,									30),
		new /datum/data/wasteland_equipment("9mm Bag",										/obj/item/ammo_box/c9mm/improvised,						30),
		new /datum/data/wasteland_equipment("10mm Bag",										/obj/item/ammo_box/c10mm/improvised,					30),
		new /datum/data/wasteland_equipment(".45 Bag",										/obj/item/ammo_box/c45/improvised,						30),
		new /datum/data/wasteland_equipment(".357 Bag",										/obj/item/ammo_box/a357box/improvised,					30),
		new /datum/data/wasteland_equipment(".44 Bag",										/obj/item/ammo_box/m44box/improvised,					30),
		new /datum/data/wasteland_equipment("5mm Bag",										/obj/item/ammo_box/m5mmbox/improvised,					30),
		new /datum/data/wasteland_equipment("5.56x45 Bag",									/obj/item/ammo_box/a556/improvised,						30),
		new /datum/data/wasteland_equipment(".308 Bag",										/obj/item/ammo_box/a308box/improvised,					30),
		new /datum/data/wasteland_equipment("14mm Bag",										/obj/item/ammo_box/m14mm/improvised,					30),
		new /datum/data/wasteland_equipment("45-70 Bag",									/obj/item/ammo_box/c4570box/improvised,					30),
		new /datum/data/wasteland_equipment(".30-06 Bag",									/obj/item/ammo_box/a3006box/improvised,					30),
		new /datum/data/wasteland_equipment("12 Gauge Buckshot box (12 shells)",			/obj/item/ammo_box/shotgun/buck,						30),
		new /datum/data/wasteland_equipment("12 Gauge Slug box  (12 shells)",				/obj/item/ammo_box/shotgun/slug,						30),
		new /datum/data/wasteland_equipment("Shoddy Energy Cell",							/obj/item/stock_parts/cell/ammo/ec/bad,					30),
		new /datum/data/wasteland_equipment("Shoddy Microfusion Cell",						/obj/item/stock_parts/cell/ammo/mfc/bad,				30),
		new /datum/data/wasteland_equipment("Shoddy Electron Charge Pack",					/obj/item/stock_parts/cell/ammo/ecp/bad,				30),
		new /datum/data/wasteland_equipment("Laser Batteries (18 batteries)",				/obj/item/ammo_box/lasmusket,							30),
		new /datum/data/wasteland_equipment("Plasma Canisters (6 canisters)",				/obj/item/ammo_box/plasmamusket,						30),
		new /obj/item/ammo_box/flintlock("Black Powder Ammo",								/obj/item/ammo_box/flintlock,							30),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,							60),
		new /datum/data/wasteland_equipment("Field Arrow (1 arrow)",						/obj/item/projectile/bullet/reusable/arrow/field,		7),
		)

/obj/machinery/mineral/wasteland_vendor/clothing
	name = "Wasteland Vending Machine - Clothing"
	icon_state = "armor_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Worn outft",						/obj/item/clothing/under/f13/worn,								5),
		new /datum/data/wasteland_equipment("Settler outfit",					/obj/item/clothing/under/f13/settler,							15),
		new /datum/data/wasteland_equipment("Merchant outfit",					/obj/item/clothing/under/f13/merchant,							30),
		new /datum/data/wasteland_equipment("Followers outfit",					/obj/item/clothing/under/f13/followers,							40),
		new /datum/data/wasteland_equipment("Combat uniform",					/obj/item/clothing/under/f13/combat,							50),
		new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",	/obj/item/book/granter/trait/trekking,							150)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Worn outft",						/obj/item/clothing/under/f13/worn,								5),
		new /datum/data/wasteland_equipment("Settler outfit",					/obj/item/clothing/under/f13/settler,							15),
		new /datum/data/wasteland_equipment("Merchant outfit",					/obj/item/clothing/under/f13/merchant,							30),
		new /datum/data/wasteland_equipment("Followers outfit",					/obj/item/clothing/under/f13/followers,							40),
		new /datum/data/wasteland_equipment("Combat uniform",					/obj/item/clothing/under/f13/combat,							50),
		new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",	/obj/item/book/granter/trait/trekking,							150),
		)

/obj/machinery/mineral/wasteland_vendor/general
	name = "Wasteland Vending Machine - Adventuring"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Drinking glass",							/obj/item/reagent_containers/food/drinks/drinkingglass,				5),
		new /datum/data/wasteland_equipment("Zippo",									/obj/item/lighter,													10),
		new /datum/data/wasteland_equipment("Explorer satchel",							/obj/item/storage/backpack/satchel/explorer,						15),
		new /datum/data/wasteland_equipment("Spray bottle",								/obj/item/reagent_containers/spray,									15),
		new /datum/data/wasteland_equipment("Bottle of E-Z-Nutrient",					/obj/item/reagent_containers/glass/bottle/nutrient/ez,				20),
		new /datum/data/wasteland_equipment("Craftsmanship Monthly",					/obj/item/book/granter/trait/techno,								150),
		new /datum/data/wasteland_equipment("Scav! Vol.1",								/obj/item/book/granter/crafting_recipe/scav_one,					250),
		new /datum/data/wasteland_equipment("Portable Cell Charger",					/obj/item/storage/battery_box,										50),
		new /datum/data/wasteland_equipment("Weapons of Texarkana", 					/obj/item/book/granter/crafting_recipe/ODF,							150),
		new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",			/obj/item/book/granter/trait/trekking,								350),
		new /datum/data/wasteland_equipment("Rift Repellent",							/obj/item/packaged_respawner_blocker,								0), // let's encourage players to clear out areas constantly
		new /datum/data/wasteland_equipment("Glowstick Pouch",							/obj/item/storage/fancy/flare_pouch/glowstick,						5), 
		new /datum/data/wasteland_equipment("Flare Pouch",								/obj/item/storage/fancy/flare_pouch,								5), // larp
		new /datum/data/wasteland_equipment("Hand teleporter",							/obj/item/hand_tele,												0),
		new /datum/data/wasteland_equipment("Blue Flashlight (Tier 2)",					/obj/item/flashlight/blue,											50),
		new /datum/data/wasteland_equipment("Seclite (Tier 3)",							/obj/item/flashlight/seclite,										100),
		new /datum/data/wasteland_equipment("Prospector Lamp (Tier 2)",					/obj/item/flashlight/lantern/mining,								50),
		new /datum/data/wasteland_equipment("Lantern (Tier 3)",							/obj/item/flashlight/lantern,										100),
		new /datum/data/wasteland_equipment("Fulton Pack",								/obj/item/extraction_pack,											10),
		new /datum/data/wasteland_equipment("Fulton Core",								/obj/item/fulton_core,												10),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Drinking glass",							/obj/item/reagent_containers/food/drinks/drinkingglass,				5),
		new /datum/data/wasteland_equipment("Zippo",									/obj/item/lighter,													10),
		new /datum/data/wasteland_equipment("Explorer satchel",							/obj/item/storage/backpack/satchel/explorer,						15),
		new /datum/data/wasteland_equipment("Spray bottle",								/obj/item/reagent_containers/spray,									15),
		new /datum/data/wasteland_equipment("Bottle of E-Z-Nutrient",					/obj/item/reagent_containers/glass/bottle/nutrient/ez,				20),
		new /datum/data/wasteland_equipment("Craftsmanship Monthly",					/obj/item/book/granter/trait/techno,								150),
		new /datum/data/wasteland_equipment("Scav! Vol.1",								/obj/item/book/granter/crafting_recipe/scav_one,					250),
		new /datum/data/wasteland_equipment("Portable Cell Charger",					/obj/item/storage/battery_box,										50),
		new /datum/data/wasteland_equipment("Weapons of Texarkana", 					/obj/item/book/granter/crafting_recipe/ODF,							150),
		new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",			/obj/item/book/granter/trait/trekking,								350),
		new /datum/data/wasteland_equipment("Rift Repellent",							/obj/item/packaged_respawner_blocker,								0), // let's encourage players to clear out areas constantly
		new /datum/data/wasteland_equipment("Glowstick Pouch",							/obj/item/storage/fancy/flare_pouch/glowstick,						5), 
		new /datum/data/wasteland_equipment("Flare Pouch",								/obj/item/storage/fancy/flare_pouch,								5), // larp
		new /datum/data/wasteland_equipment("Hand teleporter",							/obj/item/hand_tele,												0),
		new /datum/data/wasteland_equipment("Blue Flashlight (Tier 2)",					/obj/item/flashlight/blue,											50),
		new /datum/data/wasteland_equipment("Seclite (Tier 3)",							/obj/item/flashlight/seclite,										100),
		new /datum/data/wasteland_equipment("Prospector Lamp (Tier 2)",					/obj/item/flashlight/lantern/mining,								50),
		new /datum/data/wasteland_equipment("Lantern (Tier 3)",							/obj/item/flashlight/lantern,										100),
		new /datum/data/wasteland_equipment("Fulton Pack",								/obj/item/extraction_pack,											10),
		new /datum/data/wasteland_equipment("Fulton Core",								/obj/item/fulton_core,												10),
		)

/* These are shit, don't add them.

/obj/machinery/mineral/wasteland_vendor/camp
	name = "Wasteland Camp-O-Vend"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Basic Edition",			/obj/item/survivalcapsule,								50),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Premium Edition",		/obj/item/survivalcapsule/premium,						100),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Expanded Edition",		/obj/item/survivalcapsule/quad,							150),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Merchant Edition",		/obj/item/survivalcapsule/merchant,						300),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Party-Tent Edition",	/obj/item/survivalcapsule/party,						150),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Mess-Hall Edition",		/obj/item/survivalcapsule/kitchen,						250),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Farm-N-Go Edition",		/obj/item/survivalcapsule/farm,							200),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Occult Edition",		/obj/item/survivalcapsule/fortuneteller,				125),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Smithery Edition",		/obj/item/survivalcapsule/blacksmith,					400),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Ultra-Deluxe Edition",	/obj/item/survivalcapsule/super_deluxe,					600),
		new /datum/data/wasteland_equipment("Keep your C.A.M.P. Clean: Trashbag",		/obj/item/storage/bag/trash,							30),
		new /datum/data/wasteland_equipment("Keep your C.A.M.P. Clean: Soap",			/obj/item/soap/homemade,								25)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Basic Edition",			/obj/item/survivalcapsule,								50),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Premium Edition",		/obj/item/survivalcapsule/premium,						100),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Expanded Edition",		/obj/item/survivalcapsule/quad,							150),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Merchant Edition",		/obj/item/survivalcapsule/merchant,						300),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Party-Tent Edition",	/obj/item/survivalcapsule/party,						150),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Mess-Hall Edition",		/obj/item/survivalcapsule/kitchen,						250),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Farm-N-Go Edition",		/obj/item/survivalcapsule/farm,							200),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Occult Edition",		/obj/item/survivalcapsule/fortuneteller,				125),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Smithery Edition",		/obj/item/survivalcapsule/blacksmith,					400),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Ultra-Deluxe Edition",	/obj/item/survivalcapsule/super_deluxe,					600),
		new /datum/data/wasteland_equipment("Keep your C.A.M.P. Clean: Trashbag",		/obj/item/storage/bag/trash,							30),
		new /datum/data/wasteland_equipment("Keep your C.A.M.P. Clean: Soap",			/obj/item/soap/homemade,								25)
		)
*/

/obj/machinery/mineral/wasteland_vendor/pipboy
	name = "New Boston Vending Machine - Identification"
	icon_state = "pipboy"
	prize_list = list(
		new /datum/data/wasteland_equipment("Datapal PDA",			/obj/item/pda,																25),
		new /datum/data/wasteland_equipment("Reprogrammable ID",	/obj/item/card/id/selfassign,												20),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Reagent Scanner",	/obj/item/cartridge/chemistry,						10),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Health Scanner",	/obj/item/cartridge/medical,						10),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Signaler",	/obj/item/cartridge/signal,								10),
		new /datum/data/wasteland_equipment("V270-Band Signal Divination Device",	/obj/item/pinpointer/validball_finder,						10),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Datapal PDA",			/obj/item/pda,																25),
		new /datum/data/wasteland_equipment("Reprogrammable ID",	/obj/item/card/id/selfassign,												20),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Reagent Scanner",	/obj/item/cartridge/chemistry,						10),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Health Scanner",	/obj/item/cartridge/medical,						10),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Signaler",	/obj/item/cartridge/signal,								10),
		new /datum/data/wasteland_equipment("V270-Band Signal Divination Device",	/obj/item/pinpointer/validball_finder,						10),
		)

/obj/machinery/mineral/wasteland_vendor/special
	name = "New Boston Vending Machine - Money Exchanger"
	desc = "An automated machine that exhanges copper coins for more valuable ones. However, it takes a 10% cut."
	icon_state = "liberationstation_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 						50000),
		// new /datum/data/wasteland_equipment("Union Scrip x20", 			/obj/item/stack/f13Cash/ncr/twenty, 						11),
		// new /datum/data/wasteland_equipment("Union Scrip x40", 			/obj/item/stack/f13Cash/ncr/fourty, 						22),
		// new /datum/data/wasteland_equipment("Union Scrip x80", 			/obj/item/stack/f13Cash/ncr/eighty, 						44),
		// new /datum/data/wasteland_equipment("Union Scrip x200", 		/obj/item/stack/f13Cash/ncr/twohundo, 						110),
		// new /datum/data/wasteland_equipment("Union Scrip x1000", 		/obj/item/stack/f13Cash/ncr/onekay, 						550),
		// new /datum/data/wasteland_equipment("Union Scrip x5000", 		/obj/item/stack/f13Cash/ncr/fivegees, 						2750),
		new /datum/data/wasteland_equipment("Silver Dollar x1", 		/obj/item/stack/f13Cash/denarius, 							11),
		new /datum/data/wasteland_equipment("Silver Dollar x5", 		/obj/item/stack/f13Cash/denarius/five, 						55),
		new /datum/data/wasteland_equipment("Silver Dollar x10", 		/obj/item/stack/f13Cash/denarius/ten, 						110),
		new /datum/data/wasteland_equipment("Silver Dollar x20", 		/obj/item/stack/f13Cash/denarius/twenty, 					220),
		new /datum/data/wasteland_equipment("Silver Dollar x100", 		/obj/item/stack/f13Cash/denarius/hundo, 					1100),
		new /datum/data/wasteland_equipment("Golden Thaler x1", 		/obj/item/stack/f13Cash/aureus, 							110),
		new /datum/data/wasteland_equipment("Golden Thaler x5", 		/obj/item/stack/f13Cash/aureus/five, 						550),
		new /datum/data/wasteland_equipment("Golden Thaler x10", 		/obj/item/stack/f13Cash/aureus/ten, 						1100),
		new /datum/data/wasteland_equipment("Golden Thaler x100", 		/obj/item/stack/f13Cash/aureus/hundo, 						11000),
		/*new /datum/data/wasteland_equipment("Low Roller Bounty Ticket", 			/obj/item/card/lowbounty,						120), // Disabled to prevent money duping through cargo
		new /datum/data/wasteland_equipment("Medium Roller Bounty Ticket", 			/obj/item/card/midbounty, 						240),
		new /datum/data/wasteland_equipment("High Roller Bounty Ticket", 			/obj/item/card/highbounty, 						480),
		new /datum/data/wasteland_equipment("King's Bounty Ticket", 				/obj/item/card/kingbounty, 						960)*/
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 						50000),
		// new /datum/data/wasteland_equipment("Union Scrip x20", 			/obj/item/stack/f13Cash/ncr/twenty, 						11),
		// new /datum/data/wasteland_equipment("Union Scrip x40", 			/obj/item/stack/f13Cash/ncr/fourty, 						22),
		// new /datum/data/wasteland_equipment("Union Scrip x80", 			/obj/item/stack/f13Cash/ncr/eighty, 						44),
		// new /datum/data/wasteland_equipment("Union Scrip x200", 		/obj/item/stack/f13Cash/ncr/twohundo, 						110),
		// new /datum/data/wasteland_equipment("Union Scrip x1000", 		/obj/item/stack/f13Cash/ncr/onekay, 						550),
		// new /datum/data/wasteland_equipment("Union Scrip x5000", 		/obj/item/stack/f13Cash/ncr/fivegees, 						2750),
		new /datum/data/wasteland_equipment("Silver Dollar x1", 		/obj/item/stack/f13Cash/denarius, 							11),
		new /datum/data/wasteland_equipment("Silver Dollar x5", 		/obj/item/stack/f13Cash/denarius/five, 						55),
		new /datum/data/wasteland_equipment("Silver Dollar x10", 		/obj/item/stack/f13Cash/denarius/ten, 						110),
		new /datum/data/wasteland_equipment("Silver Dollar x20", 		/obj/item/stack/f13Cash/denarius/twenty, 					220),
		new /datum/data/wasteland_equipment("Silver Dollar x100", 		/obj/item/stack/f13Cash/denarius/hundo, 					1100),
		new /datum/data/wasteland_equipment("Golden Thaler x1", 		/obj/item/stack/f13Cash/aureus, 							110),
		new /datum/data/wasteland_equipment("Golden Thaler x5", 		/obj/item/stack/f13Cash/aureus/five, 						550),
		new /datum/data/wasteland_equipment("Golden Thaler x10", 		/obj/item/stack/f13Cash/aureus/ten, 						1100),
		new /datum/data/wasteland_equipment("Golden Thaler x100", 		/obj/item/stack/f13Cash/aureus/hundo, 						11000),
		/*new /datum/data/wasteland_equipment("Low Roller Bounty Ticket", 			/obj/item/card/lowbounty,						120),
		new /datum/data/wasteland_equipment("Medium Roller Bounty Ticket", 			/obj/item/card/midbounty, 						240),
		new /datum/data/wasteland_equipment("High Roller Bounty Ticket", 			/obj/item/card/highbounty, 						480),
		new /datum/data/wasteland_equipment("King's Bounty Ticket", 				/obj/item/card/kingbounty, 						960)*/
		)

/obj/machinery/mineral/wasteland_vendor/specialplus
	name = "Automatic Teller Machine"
	desc = "An automated machine that exhanges copper coins for more valuable currency. This teller is specialized for bankers to provide better exchange rates."
	icon_state = "liberationstation_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 						50000),
		// new /datum/data/wasteland_equipment("Union Scrip x20", 			/obj/item/stack/f13Cash/ncr/twenty, 						10),
		// new /datum/data/wasteland_equipment("Union Scrip x40", 			/obj/item/stack/f13Cash/ncr/fourty, 						20),
		// new /datum/data/wasteland_equipment("Union Scrip x80", 			/obj/item/stack/f13Cash/ncr/eighty, 						40),
		// new /datum/data/wasteland_equipment("Union Scrip x200", 		/obj/item/stack/f13Cash/ncr/twohundo, 						100),
		// new /datum/data/wasteland_equipment("Union Scrip x1000", 		/obj/item/stack/f13Cash/ncr/onekay, 						500),
		// new /datum/data/wasteland_equipment("Union Scrip x5000", 		/obj/item/stack/f13Cash/ncr/fivegees, 						2500),
		new /datum/data/wasteland_equipment("Silver Dollar x5", 		/obj/item/stack/f13Cash/denarius/five, 						50),
		new /datum/data/wasteland_equipment("Silver Dollar x10", 		/obj/item/stack/f13Cash/denarius/ten, 						100),
		new /datum/data/wasteland_equipment("Silver Dollar x20", 		/obj/item/stack/f13Cash/denarius/twenty, 					200),
		new /datum/data/wasteland_equipment("Silver Dollar x100", 		/obj/item/stack/f13Cash/denarius/hundo, 					1000),
		new /datum/data/wasteland_equipment("Golden Thaler x1", 		/obj/item/stack/f13Cash/aureus, 							100),
		new /datum/data/wasteland_equipment("Golden Thaler x5", 		/obj/item/stack/f13Cash/aureus/five, 						500),
		new /datum/data/wasteland_equipment("Golden Thaler x10", 		/obj/item/stack/f13Cash/aureus/ten, 						1000),
		new /datum/data/wasteland_equipment("Golden Thaler x100", 		/obj/item/stack/f13Cash/aureus/hundo, 						10000),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 						50000),
		// new /datum/data/wasteland_equipment("Union Scrip x20", 			/obj/item/stack/f13Cash/ncr/twenty, 						10),
		// new /datum/data/wasteland_equipment("Union Scrip x40", 			/obj/item/stack/f13Cash/ncr/fourty, 						20),
		// new /datum/data/wasteland_equipment("Union Scrip x80", 			/obj/item/stack/f13Cash/ncr/eighty, 						40),
		// new /datum/data/wasteland_equipment("Union Scrip x200", 		/obj/item/stack/f13Cash/ncr/twohundo, 						100),
		// new /datum/data/wasteland_equipment("Union Scrip x1000", 		/obj/item/stack/f13Cash/ncr/onekay, 						500),
		// new /datum/data/wasteland_equipment("Union Scrip x5000", 		/obj/item/stack/f13Cash/ncr/fivegees, 						2500),
		new /datum/data/wasteland_equipment("Silver Dollar x5", 		/obj/item/stack/f13Cash/denarius/five, 						50),
		new /datum/data/wasteland_equipment("Silver Dollar x10", 		/obj/item/stack/f13Cash/denarius/ten, 						100),
		new /datum/data/wasteland_equipment("Silver Dollar x20", 		/obj/item/stack/f13Cash/denarius/twenty, 					200),
		new /datum/data/wasteland_equipment("Silver Dollar x100", 		/obj/item/stack/f13Cash/denarius/hundo, 					1000),
		new /datum/data/wasteland_equipment("Golden Thaler x1", 		/obj/item/stack/f13Cash/aureus, 							100),
		new /datum/data/wasteland_equipment("Golden Thaler x5", 		/obj/item/stack/f13Cash/aureus/five, 						500),
		new /datum/data/wasteland_equipment("Golden Thaler x10", 		/obj/item/stack/f13Cash/aureus/ten, 						1000),
		new /datum/data/wasteland_equipment("Golden Thaler x100", 		/obj/item/stack/f13Cash/aureus/hundo, 						10000),
		)

/obj/machinery/mineral/wasteland_vendor/traderspecial
	name = "Union Vending Machine - Matvend"
	desc = "An automated machine that exchanges currency for raw materials."
	icon_state = "trade_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 							50000),
		new /datum/data/wasteland_equipment("Plasma x1",						/obj/item/stack/sheet/mineral/plasma,								200),
		new /datum/data/wasteland_equipment("Diamond x1",						/obj/item/stack/sheet/mineral/diamond,								150),
		new /datum/data/wasteland_equipment("Gold x1",							/obj/item/stack/sheet/mineral/gold,									100),
		new /datum/data/wasteland_equipment("Silver x1",						/obj/item/stack/sheet/mineral/silver,								10),
		new /datum/data/wasteland_equipment("Uranium x1",						/obj/item/stack/sheet/mineral/uranium,								30),
		new /datum/data/wasteland_equipment("Netherium Crystal x1",				/obj/item/stack/ore/bluespace_crystal,								300),
		new /datum/data/wasteland_equipment("Titanium x1",						/obj/item/stack/sheet/mineral/titanium,								30),
		new /datum/data/wasteland_equipment("Metal x20",						/obj/item/stack/sheet/metal/twenty,									10),
		new /datum/data/wasteland_equipment("Glass x10",						/obj/item/stack/sheet/glass/ten,									5),
		new /datum/data/wasteland_equipment("Plasteel x5",						/obj/item/stack/sheet/plasteel/five,								200),
		new /datum/data/wasteland_equipment("Plastic x5",						/obj/item/stack/sheet/plastic/five,									25),
		new /datum/data/wasteland_equipment("Electronic Parts x3",				/obj/item/stack/crafting/electronicparts/three,						3),
		new /datum/data/wasteland_equipment("Metal Parts x5",					/obj/item/stack/crafting/metalparts/five,							5),
		new /datum/data/wasteland_equipment("Good Metal Parts x3",				/obj/item/stack/crafting/goodparts/three,							6),
		new /datum/data/wasteland_equipment("Cardboard x20",					/obj/item/stack/sheet/cardboard/twenty,								20),
		new /datum/data/wasteland_equipment("(T1) Black Bronze x1",				/obj/item/ingot/bronze,												350), // 40 coins more expensive than hand making to buy
		new /datum/data/wasteland_equipment("(T2) Mythril x1",					/obj/item/ingot/mythril,											600), // 350 + 200 = 550, add another 50 as tax
		new /datum/data/wasteland_equipment("(T3) Adamantine x1",				/obj/item/ingot/adamantine,											800), // 600 + 200, cost of superlight Pre-Cataclysm alloys, no more tax
		new /datum/data/wasteland_equipment("Lollipop x1",						/obj/item/reagent_containers/food/snacks/lollipop,					2),
		new /datum/data/wasteland_equipment("Gumball x1",						/obj/item/reagent_containers/food/snacks/gumball,					4),
		new /datum/data/wasteland_equipment("Butter x1",						/obj/item/reagent_containers/food/snacks/butter,					5),
		new /datum/data/wasteland_equipment("Deluxe Stock Part Box x1",			/obj/item/storage/box/stockparts/deluxe,							1000),
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					250),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					250),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					250),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						250),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						250),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						250),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 							50000),
		new /datum/data/wasteland_equipment("Plasma x1",						/obj/item/stack/sheet/mineral/plasma,								200),
		new /datum/data/wasteland_equipment("Diamond x1",						/obj/item/stack/sheet/mineral/diamond,								150),
		new /datum/data/wasteland_equipment("Gold x1",							/obj/item/stack/sheet/mineral/gold,									100),
		new /datum/data/wasteland_equipment("Silver x1",						/obj/item/stack/sheet/mineral/silver,								10),
		new /datum/data/wasteland_equipment("Uranium x1",						/obj/item/stack/sheet/mineral/uranium,								30),
		new /datum/data/wasteland_equipment("Netherium Crystal x1",				/obj/item/stack/ore/bluespace_crystal,								300),
		new /datum/data/wasteland_equipment("Titanium x1",						/obj/item/stack/sheet/mineral/titanium,								30),
		new /datum/data/wasteland_equipment("Metal x20",						/obj/item/stack/sheet/metal/twenty,									10),
		new /datum/data/wasteland_equipment("Glass x10",						/obj/item/stack/sheet/glass/ten,									5),
		new /datum/data/wasteland_equipment("Plasteel x5",						/obj/item/stack/sheet/plasteel/five,								200),
		new /datum/data/wasteland_equipment("Plastic x5",						/obj/item/stack/sheet/plastic/five,									25),
		new /datum/data/wasteland_equipment("Electronic Parts x3",				/obj/item/stack/crafting/electronicparts/three,						3),
		new /datum/data/wasteland_equipment("Metal Parts x5",					/obj/item/stack/crafting/metalparts/five,							5),
		new /datum/data/wasteland_equipment("Good Metal Parts x3",				/obj/item/stack/crafting/goodparts/three,							6),
		new /datum/data/wasteland_equipment("Cardboard x20",					/obj/item/stack/sheet/cardboard/twenty,								20),
		new /datum/data/wasteland_equipment("(T1) Black Bronze x1",				/obj/item/ingot/bronze,												350), // 40 coins more expensive than hand making to buy
		new /datum/data/wasteland_equipment("(T2) Mythril x1",					/obj/item/ingot/mythril,											600), // 350 + 200 = 550, add another 50 as tax
		new /datum/data/wasteland_equipment("(T3) Adamantine x1",				/obj/item/ingot/adamantine,											800), // 600 + 200, cost of superlight Pre-Cataclysm alloys, no more tax
		new /datum/data/wasteland_equipment("Lollipop x1",						/obj/item/reagent_containers/food/snacks/lollipop,					2),
		new /datum/data/wasteland_equipment("Gumball x1",						/obj/item/reagent_containers/food/snacks/gumball,					4),
		new /datum/data/wasteland_equipment("Butter x1",						/obj/item/reagent_containers/food/snacks/butter,					5),
		new /datum/data/wasteland_equipment("Deluxe Stock Part Box x1",			/obj/item/storage/box/stockparts/deluxe,							1000),
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					250),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					250),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					250),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						250),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						250),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						250),
		)

/obj/machinery/mineral/wasteland_vendor/advcomponents
	name = "Wasteland Vending Machine - Components"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					50),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					50),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					50),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						50),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						50),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						50),
		new /datum/data/wasteland_equipment("Nest Repellant",					/obj/item/packaged_respawner_blocker,					0),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					50),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					50),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					50),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						50),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						50),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						50)
		)

/obj/machinery/mineral/wasteland_vendor/attachments
	name = "Wasteland Vending Machine - Discount Armor and Better Attachments"
	icon_state = "seller_attachments"
	prize_list = list(
		new /datum/data/wasteland_equipment("Radiation Suit",										/obj/item/clothing/suit/radiation,								20),
		new /datum/data/wasteland_equipment("Radiation Suit Hood",									/obj/item/clothing/head/radiation,								20),
		new /datum/data/wasteland_equipment("Wasteland Explorer Armor",								/obj/item/clothing/suit/hooded/explorer,						40),
		new /datum/data/wasteland_equipment("SEVA Environment Suit",								/obj/item/clothing/suit/hooded/explorer/seva,					40),
		new /datum/data/wasteland_equipment("Military Gas Mask",									/obj/item/clothing/mask/gas/explorer,							20),
		new /datum/data/wasteland_equipment("(T1 Barrel) Heavy Barrel",								/obj/item/gun_upgrade/barrelone,								100),
		new /datum/data/wasteland_equipment("(T2 Barrel) Magnetic Accelerator Coil",				/obj/item/gun_upgrade/barreltwo,								150),
		new /datum/data/wasteland_equipment("(T3 Barrel) Polarized Magnetic Hyper-Accelerator",		/obj/item/gun_upgrade/barrelthree,								200),
		new /datum/data/wasteland_equipment("(T1 Chip) Reinforced Energy Pump",						/obj/item/gun_upgrade/chipone,									100),
		new /datum/data/wasteland_equipment("(T2 Chip) Dynamo Booster",								/obj/item/gun_upgrade/chiptwo,									150),
		new /datum/data/wasteland_equipment("(T3 Chip) Miniature Fusion Reactor",					/obj/item/gun_upgrade/chipthree,								200),
		new /datum/data/wasteland_equipment("(T1 Grip) Mesh Grip",									/obj/item/gun_upgrade/gripone,									100),
		new /datum/data/wasteland_equipment("(T2 Grip) Styrene-Butadiene Grip",						/obj/item/gun_upgrade/griptwo,									150),
		new /datum/data/wasteland_equipment("(T3 Grip) Gyration Stabilization Sleeve",				/obj/item/gun_upgrade/gripthree,								200),
		new /datum/data/wasteland_equipment("(T1 Muzzle) Muzzle Device",							/obj/item/gun_upgrade/muzzleone,								100),
		new /datum/data/wasteland_equipment("(T2 Muzzle) Military Muzzle Device",					/obj/item/gun_upgrade/muzzletwo,								150),
		new /datum/data/wasteland_equipment("(T3 Muzzle) Research Muzzle Device",					/obj/item/gun_upgrade/muzzlethree,								200),
		new /datum/data/wasteland_equipment("(T1 Trigger) Match Trigger",							/obj/item/gun_upgrade/triggerone,								100),
		new /datum/data/wasteland_equipment("(T2 Trigger) Military Trigger",						/obj/item/gun_upgrade/triggertwo,								150),
		new /datum/data/wasteland_equipment("(T3 Trigger) Pristine Trigger",						/obj/item/gun_upgrade/triggerthree,								200),
		new /datum/data/wasteland_equipment("(T1 Scope) Reflex Sight",								/obj/item/gun_upgrade/sightone,									100),
		new /datum/data/wasteland_equipment("(T2 Scope) Old Scope",									/obj/item/gun_upgrade/sighttwo,									150),
		new /datum/data/wasteland_equipment("(T3 Scope) Pristine Scope",							/obj/item/gun_upgrade/sightthree,								200),
		new /datum/data/wasteland_equipment("(T1 Paint) Red Paint",									/obj/item/gun_upgrade/paint/red,								100),
		new /datum/data/wasteland_equipment("(T1 Paint) Blue Paint",								/obj/item/gun_upgrade/paint/blue,								100),
		new /datum/data/wasteland_equipment("(T1 Paint) Yellow Paint",								/obj/item/gun_upgrade/paint/yellow,								100),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Radiation Suit",										/obj/item/clothing/suit/radiation,								20),
		new /datum/data/wasteland_equipment("Radiation Suit Hood",									/obj/item/clothing/head/radiation,								20),
		new /datum/data/wasteland_equipment("Wasteland Explorer Armor",								/obj/item/clothing/suit/hooded/explorer,						40),
		new /datum/data/wasteland_equipment("SEVA Environment Suit",								/obj/item/clothing/suit/hooded/explorer/seva,					40),
		new /datum/data/wasteland_equipment("Military Gas Mask",									/obj/item/clothing/mask/gas/explorer,							20),
		new /datum/data/wasteland_equipment("(T1 Barrel) Heavy Barrel",								/obj/item/gun_upgrade/barrelone,								100),
		new /datum/data/wasteland_equipment("(T2 Barrel) Magnetic Accelerator Coil",				/obj/item/gun_upgrade/barreltwo,								150),
		new /datum/data/wasteland_equipment("(T3 Barrel) Polarized Magnetic Hyper-Accelerator",		/obj/item/gun_upgrade/barrelthree,								200),
		new /datum/data/wasteland_equipment("(T1 Chip) Reinforced Energy Pump",						/obj/item/gun_upgrade/chipone,									100),
		new /datum/data/wasteland_equipment("(T2 Chip) Dynamo Booster",								/obj/item/gun_upgrade/chiptwo,									150),
		new /datum/data/wasteland_equipment("(T3 Chip) Miniature Fusion Reactor",					/obj/item/gun_upgrade/chipthree,								200),
		new /datum/data/wasteland_equipment("(T1 Grip) Mesh Grip",									/obj/item/gun_upgrade/gripone,									100),
		new /datum/data/wasteland_equipment("(T2 Grip) Styrene-Butadiene Grip",						/obj/item/gun_upgrade/griptwo,									150),
		new /datum/data/wasteland_equipment("(T3 Grip) Gyration Stabilization Sleeve",				/obj/item/gun_upgrade/gripthree,								200),
		new /datum/data/wasteland_equipment("(T1 Muzzle) Muzzle Device",							/obj/item/gun_upgrade/muzzleone,								100),
		new /datum/data/wasteland_equipment("(T2 Muzzle) Military Muzzle Device",					/obj/item/gun_upgrade/muzzletwo,								150),
		new /datum/data/wasteland_equipment("(T3 Muzzle) Research Muzzle Device",					/obj/item/gun_upgrade/muzzlethree,								200),
		new /datum/data/wasteland_equipment("(T1 Trigger) Match Trigger",							/obj/item/gun_upgrade/triggerone,								100),
		new /datum/data/wasteland_equipment("(T2 Trigger) Military Trigger",						/obj/item/gun_upgrade/triggertwo,								150),
		new /datum/data/wasteland_equipment("(T3 Trigger) Pristine Trigger",						/obj/item/gun_upgrade/triggerthree,								200),
		new /datum/data/wasteland_equipment("(T1 Scope) Reflex Sight",								/obj/item/gun_upgrade/sightone,									100),
		new /datum/data/wasteland_equipment("(T2 Scope) Old Scope",									/obj/item/gun_upgrade/sighttwo,									150),
		new /datum/data/wasteland_equipment("(T3 Scope) Pristine Scope",							/obj/item/gun_upgrade/sightthree,								200),
		new /datum/data/wasteland_equipment("(T1 Paint) Red Paint",									/obj/item/gun_upgrade/paint/red,								100),
		new /datum/data/wasteland_equipment("(T1 Paint) Blue Paint",								/obj/item/gun_upgrade/paint/blue,								100),
		new /datum/data/wasteland_equipment("(T1 Paint) Yellow Paint",								/obj/item/gun_upgrade/paint/yellow,								100),
		)

/obj/machinery/mineral/wasteland_vendor/badattachments
	name = "Wasteland Vending Machine - Armor and Attachments"
	icon_state = "seller_attachments"
	color = "#684800"
	prize_list = list(
		new /datum/data/wasteland_equipment("Radiation Suit",							/obj/item/clothing/suit/radiation,								20),
		new /datum/data/wasteland_equipment("Radiation Suit Hood",						/obj/item/clothing/head/radiation,								20),
		new /datum/data/wasteland_equipment("Wasteland Explorer Armor",					/obj/item/clothing/suit/hooded/explorer,						40),
		new /datum/data/wasteland_equipment("SEVA Environment Suit",					/obj/item/clothing/suit/hooded/explorer/seva,					40),
		new /datum/data/wasteland_equipment("Military Gas Mask",						/obj/item/clothing/mask/gas/explorer,							20),
		new /datum/data/wasteland_equipment("Heavy Barrel",								/obj/item/gun_upgrade/barrelone,								100),
		new /datum/data/wasteland_equipment("Magnetic Accelerator Coil",				/obj/item/gun_upgrade/barreltwo,								150),
		new /datum/data/wasteland_equipment("Polarized Magnetic Hyper-Accelerator",		/obj/item/gun_upgrade/barrelthree,								200),
		new /datum/data/wasteland_equipment("Reinforced Energy Pump",					/obj/item/gun_upgrade/chipone,									100),
		new /datum/data/wasteland_equipment("Dynamo Booster",							/obj/item/gun_upgrade/chiptwo,									150),
		new /datum/data/wasteland_equipment("Miniature Fusion Reactor",					/obj/item/gun_upgrade/chipthree,								200),
		new /datum/data/wasteland_equipment("Mesh Grip",								/obj/item/gun_upgrade/gripone,									100),
		new /datum/data/wasteland_equipment("Styrene-Butadiene Grip",					/obj/item/gun_upgrade/griptwo,									150),
		new /datum/data/wasteland_equipment("Gyration Stabilization Sleeve",			/obj/item/gun_upgrade/gripthree,								200),
		new /datum/data/wasteland_equipment("Muzzle Device",							/obj/item/gun_upgrade/muzzleone,								100),
		new /datum/data/wasteland_equipment("Military Muzzle Device",					/obj/item/gun_upgrade/muzzletwo,								150),
		new /datum/data/wasteland_equipment("Research Muzzle Device",					/obj/item/gun_upgrade/muzzlethree,								200),
		new /datum/data/wasteland_equipment("Match Trigger",							/obj/item/gun_upgrade/triggerone,								100),
		new /datum/data/wasteland_equipment("Military Trigger",							/obj/item/gun_upgrade/triggertwo,								150),
		new /datum/data/wasteland_equipment("Pristine Trigger",							/obj/item/gun_upgrade/triggerthree,								200),
		new /datum/data/wasteland_equipment("Reflex Sight",								/obj/item/gun_upgrade/sightone,									100),
		new /datum/data/wasteland_equipment("Old Scope",								/obj/item/gun_upgrade/sighttwo,									150),
		new /datum/data/wasteland_equipment("Pristine Scope",							/obj/item/gun_upgrade/sightthree,								200),
		new /datum/data/wasteland_equipment("Red Paint",								/obj/item/gun_upgrade/paint/red,								100),
		new /datum/data/wasteland_equipment("Blue Paint",								/obj/item/gun_upgrade/paint/blue,								150),
		new /datum/data/wasteland_equipment("Yellow Paint",								/obj/item/gun_upgrade/paint/yellow,								150)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Radiation Suit",							/obj/item/clothing/suit/radiation,								20),
		new /datum/data/wasteland_equipment("Radiation Suit Hood",						/obj/item/clothing/head/radiation,								20),
		new /datum/data/wasteland_equipment("Wasteland Explorer Armor",					/obj/item/clothing/suit/hooded/explorer,						40),
		new /datum/data/wasteland_equipment("SEVA Environment Suit",					/obj/item/clothing/suit/hooded/explorer/seva,					40),
		new /datum/data/wasteland_equipment("Military Gas Mask",						/obj/item/clothing/mask/gas/explorer,							20),
		new /datum/data/wasteland_equipment("Heavy Barrel",								/obj/item/gun_upgrade/barrelone,								100),
		new /datum/data/wasteland_equipment("Magnetic Accelerator Coil",				/obj/item/gun_upgrade/barreltwo,								150),
		new /datum/data/wasteland_equipment("Polarized Magnetic Hyper-Accelerator",		/obj/item/gun_upgrade/barrelthree,								200),
		new /datum/data/wasteland_equipment("Reinforced Energy Pump",					/obj/item/gun_upgrade/chipone,									100),
		new /datum/data/wasteland_equipment("Dynamo Booster",							/obj/item/gun_upgrade/chiptwo,									150),
		new /datum/data/wasteland_equipment("Miniature Fusion Reactor",					/obj/item/gun_upgrade/chipthree,								200),
		new /datum/data/wasteland_equipment("Mesh Grip",								/obj/item/gun_upgrade/gripone,									100),
		new /datum/data/wasteland_equipment("Styrene-Butadiene Grip",					/obj/item/gun_upgrade/griptwo,									150),
		new /datum/data/wasteland_equipment("Gyration Stabilization Sleeve",			/obj/item/gun_upgrade/gripthree,								200),
		new /datum/data/wasteland_equipment("Muzzle Device",							/obj/item/gun_upgrade/muzzleone,								100),
		new /datum/data/wasteland_equipment("Military Muzzle Device",					/obj/item/gun_upgrade/muzzletwo,								150),
		new /datum/data/wasteland_equipment("Research Muzzle Device",					/obj/item/gun_upgrade/muzzlethree,								200),
		new /datum/data/wasteland_equipment("Match Trigger",							/obj/item/gun_upgrade/triggerone,								100),
		new /datum/data/wasteland_equipment("Military Trigger",							/obj/item/gun_upgrade/triggertwo,								150),
		new /datum/data/wasteland_equipment("Pristine Trigger",							/obj/item/gun_upgrade/triggerthree,								200),
		new /datum/data/wasteland_equipment("Reflex Sight",								/obj/item/gun_upgrade/sightone,									100),
		new /datum/data/wasteland_equipment("Old Scope",								/obj/item/gun_upgrade/sighttwo,									150),
		new /datum/data/wasteland_equipment("Pristine Scope",							/obj/item/gun_upgrade/sightthree,								200),
		new /datum/data/wasteland_equipment("Red Paint",								/obj/item/gun_upgrade/paint/red,								100),
		new /datum/data/wasteland_equipment("Blue Paint",								/obj/item/gun_upgrade/paint/blue,								150),
		new /datum/data/wasteland_equipment("Yellow Paint",								/obj/item/gun_upgrade/paint/yellow,								150)
		)

/obj/machinery/mineral/wasteland_vendor/crafting
	name = "Wasteland Vending Machine - Crafting"
	icon_state = "seller_crafting"
	prize_list = list(
		new /datum/data/wasteland_equipment("Metal Parts (x5)",					/obj/item/stack/crafting/metalparts/five,							10),
		new /datum/data/wasteland_equipment("High Quality Metal Parts (x5)",	/obj/item/stack/crafting/goodparts/five,							25),
		new /datum/data/wasteland_equipment("Electronic Parts (x5)",			/obj/item/stack/crafting/electronicparts/five,						25),
		new /datum/data/wasteland_equipment("Metal Sheets (x20)",				/obj/item/stack/sheet/metal/twenty,									30),
		new /datum/data/wasteland_equipment("Metal Sheets (x50)",				/obj/item/stack/sheet/metal/fifty,									65),
		new /datum/data/wasteland_equipment("Glass Sheets (x10)",				/obj/item/stack/sheet/glass/ten,									10),
		new /datum/data/wasteland_equipment("Glass Sheets (x50)",				/obj/item/stack/sheet/glass/fifty,									50),
		new /datum/data/wasteland_equipment("Gunpowder (x50)",					/obj/item/stack/ore/blackpowder/fifty,								300),
		new /datum/data/wasteland_equipment("Sacks of Concrete (x50)",			/obj/item/stack/sheet/mineral/concrete/fifty,						20),
		new /datum/data/wasteland_equipment("Art Canvas 19x19",					/obj/item/canvas/nineteenXnineteen,									20),
		new /datum/data/wasteland_equipment("Art Canvas 23x19",					/obj/item/canvas/twentythreeXnineteen,								20),
		new /datum/data/wasteland_equipment("Art Canvas 23x23",					/obj/item/canvas/twentythreeXtwentythree,							20),
		new /datum/data/wasteland_equipment("Mechanical Toolbox",				/obj/item/storage/toolbox/mechanical,								15),
		new /datum/data/wasteland_equipment("Electrician Toolbox",				/obj/item/storage/toolbox/electrical,								15),
		new /datum/data/wasteland_equipment("Insulated Gloves",					/obj/item/clothing/gloves/color/yellow,								15),
		new /datum/data/wasteland_equipment("Military Engineer Gloves",			/obj/item/clothing/gloves/f13/military/engineer,					75),
		new /datum/data/wasteland_equipment("Nest Repellant",					/obj/item/packaged_respawner_blocker,					0),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Metal Parts (x5)",					/obj/item/stack/crafting/metalparts/five,							10),
		new /datum/data/wasteland_equipment("High Quality Metal Parts (x5)",	/obj/item/stack/crafting/goodparts/five,							25),
		new /datum/data/wasteland_equipment("Electronic Parts (x5)",			/obj/item/stack/crafting/electronicparts/five,						25),
		new /datum/data/wasteland_equipment("Metal Sheets (x20)",				/obj/item/stack/sheet/metal/twenty,									30),
		new /datum/data/wasteland_equipment("Metal Sheets (x50)",				/obj/item/stack/sheet/metal/fifty,									65),
		new /datum/data/wasteland_equipment("Glass Sheets (x10)",				/obj/item/stack/sheet/glass/ten,									10),
		new /datum/data/wasteland_equipment("Glass Sheets (x50)",				/obj/item/stack/sheet/glass/fifty,									50),
		new /datum/data/wasteland_equipment("Gunpowder (x50)",					/obj/item/stack/ore/blackpowder/fifty,								300),
		new /datum/data/wasteland_equipment("Sacks of Concrete (x50)",			/obj/item/stack/sheet/mineral/concrete/fifty,						20),
		new /datum/data/wasteland_equipment("Art Canvas 19x19",					/obj/item/canvas/nineteenXnineteen,									20),
		new /datum/data/wasteland_equipment("Art Canvas 23x19",					/obj/item/canvas/twentythreeXnineteen,								20),
		new /datum/data/wasteland_equipment("Art Canvas 23x23",					/obj/item/canvas/twentythreeXtwentythree,							20),
		new /datum/data/wasteland_equipment("Mechanical Toolbox",				/obj/item/storage/toolbox/mechanical,								15),
		new /datum/data/wasteland_equipment("Electrician Toolbox",				/obj/item/storage/toolbox/electrical,								15),
		new /datum/data/wasteland_equipment("Insulated Gloves",					/obj/item/clothing/gloves/color/yellow,								15),
		new /datum/data/wasteland_equipment("Military Engineer Gloves",			/obj/item/clothing/gloves/f13/military/engineer,					75),
		)

/obj/machinery/mineral/wasteland_vendor/mining
	name = "Wasteland Vending Machine - Mining and Salvage"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Lantern",							/obj/item/flashlight/lantern,								25),
		new /datum/data/wasteland_equipment("Pickaxe",							/obj/item/pickaxe,											10),
		new /datum/data/wasteland_equipment("Mining drill",						/obj/item/pickaxe/drill,									50),
		new /datum/data/wasteland_equipment("Manual mining scanner",			/obj/item/mining_scanner,									15),
		new /datum/data/wasteland_equipment("Automatic mining scanner",			/obj/item/t_scanner/adv_mining_scanner/lesser,				100),
		new /datum/data/wasteland_equipment("Advanced mining scanner",			/obj/item/t_scanner/adv_mining_scanner,						200),
		new /datum/data/wasteland_equipment("Welding goggles",					/obj/item/clothing/glasses/welding,							20),
		new /datum/data/wasteland_equipment("Industrial welding tool",			/obj/item/weldingtool/largetank,							30),
		new /datum/data/wasteland_equipment("Upgraded industrial welding tool",	/obj/item/weldingtool/hugetank,								50),
		new /datum/data/wasteland_equipment("Experimental welding tool",		/obj/item/weldingtool/experimental,							200),
		new /datum/data/wasteland_equipment("Hand drill",						/obj/item/screwdriver/power,								200),
		new /datum/data/wasteland_equipment("Jaws of life",						/obj/item/crowbar/power,									200),
		new /datum/data/wasteland_equipment("1000 Mining Points",				/obj/item/card/mining_point_card/mp1000,					250),
		new /datum/data/wasteland_equipment("ORM Board",						/obj/item/circuitboard/machine/ore_redemption,				50),
		new /datum/data/wasteland_equipment("Portable Cell Charger",						/obj/item/storage/battery_box,							50),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Lantern",							/obj/item/flashlight/lantern,								25),
		new /datum/data/wasteland_equipment("Pickaxe",							/obj/item/pickaxe,											10),
		new /datum/data/wasteland_equipment("Mining drill",						/obj/item/pickaxe/drill,									50),
		new /datum/data/wasteland_equipment("Manual mining scanner",			/obj/item/mining_scanner,									15),
		new /datum/data/wasteland_equipment("Automatic mining scanner",			/obj/item/t_scanner/adv_mining_scanner/lesser,				100),
		new /datum/data/wasteland_equipment("Advanced mining scanner",			/obj/item/t_scanner/adv_mining_scanner,						200),
		new /datum/data/wasteland_equipment("Welding goggles",					/obj/item/clothing/glasses/welding,							20),
		new /datum/data/wasteland_equipment("Industrial welding tool",			/obj/item/weldingtool/largetank,							30),
		new /datum/data/wasteland_equipment("Upgraded industrial welding tool",	/obj/item/weldingtool/hugetank,								50),
		new /datum/data/wasteland_equipment("Experimental welding tool",		/obj/item/weldingtool/experimental,							200),
		new /datum/data/wasteland_equipment("Hand drill",						/obj/item/screwdriver/power,								200),
		new /datum/data/wasteland_equipment("Jaws of life",						/obj/item/crowbar/power,									200),
		new /datum/data/wasteland_equipment("1000 Mining Points",				/obj/item/card/mining_point_card/mp1000,					250),
		new /datum/data/wasteland_equipment("ORM Board",						/obj/item/circuitboard/machine/ore_redemption,				50)
		)

/datum/data/wasteland_equipment
	var/equipment_name = "generic"
	var/equipment_path = null
	var/cost = 0

/datum/data/wasteland_equipment/New(name, path, cost)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost

/obj/machinery/mineral/wasteland_vendor/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Currency conversion rates:</b><br>"
	dat += "1 silver Dollar = [CASH_DEN_VENDOR] copper Edisons <br>"
	dat += "1 gold Thaler = [CASH_AUR_VENDOR] copper Edisons <br>"
	// dat += "1 Trade Union scrip = [CASH_NCR_VENDOR] copper Edisons <br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Vendor goods:</b><BR><table border='0' width='300'>"
	if (GLOB.player_list.len>50)
		for(var/datum/data/wasteland_equipment/prize in highpop_list)
			dat += "<tr><td>[prize.equipment_name]</td><td>[prize.cost]</td><td><A href='?src=[REF(src)];purchase=[REF(prize)]'>Purchase</A></td></tr>"
	else
		for(var/datum/data/wasteland_equipment/prize in prize_list)
			dat += "<tr><td>[prize.equipment_name]</td><td>[prize.cost]</td><td><A href='?src=[REF(src)];purchase=[REF(prize)]'>Purchase</A></td></tr>"
	dat += "</table>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Wasteland Vending Machine", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_vendor/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"] == "eject")
		remove_all_caps()
	if(href_list["purchase"] && GLOB.player_list.len>50)
		var/datum/data/wasteland_equipment/prize = locate(href_list["purchase"])
		if (!prize || !(prize in highpop_list))
			to_chat(usr, span_warning("Error: Invalid choice!"))
			return
		if(prize.cost > stored_caps)
			to_chat(usr, span_warning("Error: Insufficent bottle caps value for [prize.equipment_name]!"))
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, span_notice("[src] clanks to life briefly before vending [prize.equipment_name]!"))
			new prize.equipment_path(src.loc)
			SSblackbox.record_feedback("nested tally", "wasteland_equipment_bought", 1, list("[type]", "[prize.equipment_path]"))
	else if(href_list["purchase"])
		var/datum/data/wasteland_equipment/prize = locate(href_list["purchase"])
		if (!prize || !(prize in prize_list))
			to_chat(usr, span_warning("Error: Invalid choice!"))
			return
		if(prize.cost > stored_caps)
			to_chat(usr, span_warning("Error: Insufficent bottle caps value for [prize.equipment_name]!"))
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, span_notice("[src] clanks to life briefly before vending [prize.equipment_name]!"))
			new prize.equipment_path(src.loc)
			SSblackbox.record_feedback("nested tally", "wasteland_equipment_bought", 1, list("[type]", "[prize.equipment_path]"))
	updateUsrDialog()
	return

/obj/machinery/mineral/wasteland_vendor/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/f13Cash))
		add_caps(I)
	else
		attack_hand(user)

/* Adding a caps to caps storage and release vending item. */
/obj/machinery/mineral/wasteland_vendor/proc/add_caps(obj/item/I)
	if(istype(I, /obj/item/stack/f13Cash/caps))
		var/obj/item/stack/f13Cash/currency = I
		var/inserted_value = FLOOR(currency.amount * 1, 1)
		stored_caps += inserted_value
		I.use(currency.amount)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		to_chat(usr, "You put [inserted_value] bottle caps value to a vending machine.")
		src.ui_interact(usr)
	else if(istype(I, /obj/item/stack/f13Cash/ncr))
		var/obj/item/stack/f13Cash/ncr/currency = I
		var/inserted_value = FLOOR(currency.amount * 0.5, 1)
		stored_caps += inserted_value
		I.use(currency.amount)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		to_chat(usr, "You put [inserted_value] bottle caps value to a vending machine.")
		src.ui_interact(usr)
	else if(istype(I, /obj/item/stack/f13Cash/denarius))
		var/obj/item/stack/f13Cash/denarius/currency = I
		var/inserted_value = FLOOR(currency.amount * 10, 1)
		stored_caps += inserted_value
		I.use(currency.amount)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		to_chat(usr, "You put [inserted_value] bottle caps value to a vending machine.")
		src.ui_interact(usr)
	else if(istype(I, /obj/item/stack/f13Cash/aureus))
		var/obj/item/stack/f13Cash/aureus/currency = I
		var/inserted_value = FLOOR(currency.amount * 100, 1)
		stored_caps += inserted_value
		I.use(currency.amount)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		to_chat(usr, "You put [inserted_value] bottle caps value to a vending machine.")
		src.ui_interact(usr)
	else
		to_chat(usr, "Invalid currency!")
		return

/* Spawn all caps on world and clear caps storage */
/obj/machinery/mineral/wasteland_vendor/proc/remove_all_caps()
	if(stored_caps <= 0)
		return
	payout(floor(stored_caps), null, FALSE, TRUE)
	// var/obj/item/stack/f13Cash/C = new /obj/item/stack/f13Cash/caps
	// if(stored_caps > C.max_amount)
	// 	C.add(C.max_amount - 1)
	// 	C.forceMove(src.loc)
	// 	stored_caps -= C.max_amount
	// else
	// 	C.add(stored_caps - 1)
	// 	C.forceMove(src.loc)
	stored_caps = 0
	playsound(src, 'sound/items/coinflip.ogg', 60, 1)
	src.ui_interact(usr)

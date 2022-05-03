/* Code by Tienn */
/* Sprites by Moonmandoom*/

#define STATE_IDLE 0
#define STATE_SERVICE 1
#define STATE_VEND 2
#define STATE_LOCKOPEN 3

#define CASH_CAP_VENDOR 1

/* exchange rates X * CAP*/
#define CASH_AUR_VENDOR 100 /* 100 caps to 1 AUR */
#define CASH_DEN_VENDOR 4 /* 4 caps to 1 DEN */
#define CASH_NCR_VENDOR 0.4 /* $100 to 40 caps */

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

	if(is_available_category(Itm) && is_acceptable_item_state(Itm))
		var/price = input(usr, "Enter price for " + Itm.name + ".", "Setup Price", basic_price) as null|num

		if(!price)
			return

		content[Itm] = min(max(round(price),0),50000)

		if(istype(Itm.loc, /mob))
			var/mob/M = Itm.loc
			if(!M.dropItemToGround(Itm))
				to_chat(usr, "<span class='warning'>\the [Itm] is stuck to your hand, you cannot put it in \the [src]!</span>")
				return

		Itm.forceMove(src)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		to_chat(usr, "You loaded [Itm.name] to vending machine. New price - [content[Itm]] caps..")
		src.ui_interact(usr)
	else
		if(!is_available_category(Itm))
			playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
			to_chat(usr, "*beep* ..wrong item.")
		else if (!is_acceptable_item_state(Itm))
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
			to_chat(usr, "You put [expected_price] caps to a vending machine. [vending_item.name] is vended out of it. ")
			remove_item(vending_item)
			set_state(STATE_IDLE)
			onclose(usr, "vending")
		else
			playsound(src, 'sound/machines/DeniedBeep.ogg', 60, 1)
			to_chat(usr, "Not enough caps.")

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
						"<span class='notice'>You start repairing the vending machine.</span>", \
						"<span class='italics'>You hear welding.</span>")
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
					dat += "<a href='byond://?src=\ref[src];vend=[item_name];current_price=[price]'>[Itm.name] | [price] caps</a> "
					dat += "<a href='byond://?src=\ref[src];examine=[item_name];current_price=[price]'>Examine</a><br> "

		//--- Service
		if(STATE_SERVICE)
			dat += "<h3>Machine setup menu</h3>"
			dat += "<div class='statusDisplay'>"
			dat += "<font color='green'>Caps stored - [stored_caps]</font>"
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
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Syringe",						/obj/item/reagent_containers/syringe,								10),
		new /datum/data/wasteland_equipment("Empty pillbottle",				/obj/item/storage/pill_bottle,										15),
		new /datum/data/wasteland_equipment("Rad-X pill",					/obj/item/reagent_containers/pill/radx,								20),
		new /datum/data/wasteland_equipment("RadAway",						/obj/item/reagent_containers/blood/radaway,							30),
		new /datum/data/wasteland_equipment("Stimpak",						/obj/item/reagent_containers/hypospray/medipen/stimpak,				100),
		new /datum/data/wasteland_equipment("Chemistry for Wastelanders",	/obj/item/book/granter/trait/chemistry,								600),
		new /datum/data/wasteland_equipment("Surgery for Wastelanders",		/obj/item/book/granter/trait/lowsurgery,							500)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Syringe",						/obj/item/reagent_containers/syringe,								10),
		new /datum/data/wasteland_equipment("Empty pillbottle",				/obj/item/storage/pill_bottle,										15),
		new /datum/data/wasteland_equipment("Rad-X pill",					/obj/item/reagent_containers/pill/radx,								20),
		new /datum/data/wasteland_equipment("RadAway",						/obj/item/reagent_containers/blood/radaway,							30),
		new /datum/data/wasteland_equipment("Chemistry for Wastelanders",	/obj/item/book/granter/trait/chemistry,								600),
		new /datum/data/wasteland_equipment("Surgery for Wastelanders",		/obj/item/book/granter/trait/lowsurgery,							500)
		)

/obj/machinery/mineral/wasteland_vendor/khanchem
	name = "P.A.P.A"
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						30),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/hypospray/medipen/psycho,				30),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						30),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						30),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						30),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/hypospray/medipen/medx,							30),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						30),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/hypospray/medipen/psycho,				30),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						30),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						30),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						30),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/hypospray/medipen/medx,							30),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200)
		)

/obj/machinery/mineral/wasteland_vendor/denchem
	name = "Chem Dispenser"
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						60),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/hypospray/medipen/psycho,				60),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						60),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						60),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						60),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/hypospray/medipen/medx,							60),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Jet",							/obj/item/reagent_containers/pill/patch/jet,						60),
		new /datum/data/wasteland_equipment("Psycho",						/obj/item/reagent_containers/hypospray/medipen/psycho,				60),
		new /datum/data/wasteland_equipment("Turbo",						/obj/item/reagent_containers/pill/patch/turbo,						60),
		new /datum/data/wasteland_equipment("Mentats",						/obj/item/storage/pill_bottle/chem_tin/mentats,						60),
		new /datum/data/wasteland_equipment("Buffout",						/obj/item/storage/pill_bottle/chem_tin/buffout,						60),
		new /datum/data/wasteland_equipment("Med-X",						/obj/item/reagent_containers/hypospray/medipen/medx,							60),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200)
		)

/obj/machinery/mineral/wasteland_vendor/followerterminal
	name = "Follower's Resupply Terminal"
	desc = "a vending machine stocked with imported medical supplies. The pricing is to cover the cost of shipping and handling."
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Soap",							/obj/item/soap/deluxe,												50),
		new /datum/data/wasteland_equipment("Gas Mask",						/obj/item/clothing/mask/gas,										50),
		new /datum/data/wasteland_equipment("Advanced Mop",					/obj/item/mop/advanced,												100),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200),
		new /datum/data/wasteland_equipment("Metamaterial Beaker",			/obj/item/reagent_containers/glass/beaker/meta,						500),
		new /datum/data/wasteland_equipment("Medical HUD",					/obj/item/clothing/glasses/hud/health,								500),
		new /datum/data/wasteland_equipment("Prosthetic Left Arm",			/obj/item/bodypart/l_arm/robot,										600),
		new /datum/data/wasteland_equipment("Prosthetic Right Arm",		/obj/item/bodypart/r_arm/robot,										600),
		new /datum/data/wasteland_equipment("Prosthetic Left Leg",			/obj/item/bodypart/l_leg/robot,										600),
		new /datum/data/wasteland_equipment("Prosthetic Right Leg",		/obj/item/bodypart/r_leg/robot,										600),
		new /datum/data/wasteland_equipment("Integrated Toolset Implant",	/obj/item/organ/cyberimp/arm/toolset,								700),
		new /datum/data/wasteland_equipment("Defibrillator",				/obj/item/defibrillator,											1000),
		new /datum/data/wasteland_equipment("Chest reviver Implant",			/obj/item/organ/cyberimp/chest/reviver,								1500),
		new /datum/data/wasteland_equipment("Upgraded Prosthetic Limbs",	/obj/item/storage/box/sparelimbs,									2000),
		new /datum/data/wasteland_equipment("Cat",							/mob/living/simple_animal/pet/cat/Runtime,							10000),
		)
		
	highpop_list = list(
		new /datum/data/wasteland_equipment("Medicated Suture",				/obj/item/stack/medical/suture/medicated,							45),
		new /datum/data/wasteland_equipment("Advanced Regen. Mesh",			/obj/item/stack/medical/mesh/advanced,								45),
		new /datum/data/wasteland_equipment("Soap",							/obj/item/soap/syndie,												50),
		new /datum/data/wasteland_equipment("Gas Mask",						/obj/item/clothing/mask/gas,										50),
		new /datum/data/wasteland_equipment("Advanced Mop",					/obj/item/mop/advanced,												100),
		new /datum/data/wasteland_equipment("Fixer",						/obj/item/storage/pill_bottle/chem_tin/fixer,						200),
		new /datum/data/wasteland_equipment("Metamaterial Beaker",			/obj/item/reagent_containers/glass/beaker/meta,						500),
		new /datum/data/wasteland_equipment("Medical HUD",					/obj/item/clothing/glasses/hud/health,								500),
		new /datum/data/wasteland_equipment("Prosthetic Left Arm",			/obj/item/bodypart/l_arm/robot,										600),
		new /datum/data/wasteland_equipment("Prosthetic Right Arm",			/obj/item/bodypart/r_arm/robot,										600),
		new /datum/data/wasteland_equipment("Prosthetic Left Leg",			/obj/item/bodypart/l_leg/robot,										600),
		new /datum/data/wasteland_equipment("Prosthetic Right Leg",			/obj/item/bodypart/r_leg/robot,										600),
		new /datum/data/wasteland_equipment("Integrated Toolset Implant",	/obj/item/organ/cyberimp/arm/toolset,								700),
		new /datum/data/wasteland_equipment("Defibrillator",				/obj/item/defibrillator,											1000),
		new /datum/data/wasteland_equipment("Chest reviver Implant",		/obj/item/organ/cyberimp/chest/reviver,								1500),
		new /datum/data/wasteland_equipment("Upgraded Prosthetic Limbs",	/obj/item/storage/box/sparelimbs,									2000),
		new /datum/data/wasteland_equipment("Cat",							/mob/living/simple_animal/pet/cat/Runtime,							10000),
		)
		
/obj/machinery/mineral/wasteland_vendor/weapons
	name = "Wasteland Vending Machine - Weapons"
	icon_state = "weapon_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("survival knife",				/obj/item/melee/onehanded/knife/survival, 							70),
		new /datum/data/wasteland_equipment("9mm pistol",					/obj/item/gun/ballistic/automatic/pistol/ninemil,					150),
		new /datum/data/wasteland_equipment("M1911",						/obj/item/gun/ballistic/automatic/pistol/m1911,						170),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 1",		/obj/item/book/granter/crafting_recipe/gunsmith_one, 				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 2",		/obj/item/book/granter/crafting_recipe/gunsmith_two,				200),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 3",		/obj/item/book/granter/crafting_recipe/gunsmith_three, 				300),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 4",		/obj/item/book/granter/crafting_recipe/gunsmith_four, 				400),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("survival knife",				/obj/item/melee/onehanded/knife/survival, 							40),
		new /datum/data/wasteland_equipment("9mm pistol",					/obj/item/gun/ballistic/automatic/pistol/beretta,					60),
		new /datum/data/wasteland_equipment("M1911",						/obj/item/gun/ballistic/automatic/pistol/m1911,						70),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 1",		/obj/item/book/granter/crafting_recipe/gunsmith_one, 				100),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 2",		/obj/item/book/granter/crafting_recipe/gunsmith_two,				200),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 3",		/obj/item/book/granter/crafting_recipe/gunsmith_three, 				300),
		new /datum/data/wasteland_equipment("Guns and Bullets, Part 4",		/obj/item/book/granter/crafting_recipe/gunsmith_four, 				400),
		)

/obj/machinery/mineral/wasteland_vendor/ammo
	name = "Wasteland Vending Machine - Ammo n Bombs"
	icon_state = "ammo_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Handgun magazine (.45)",		/obj/item/ammo_box/magazine/m45,									50),
		new /datum/data/wasteland_equipment("9mm pistol magazine (9mm)",	/obj/item/ammo_box/magazine/m9mmds,									50),
		new /datum/data/wasteland_equipment("10mm pistol magazine (10mm)",	/obj/item/ammo_box/magazine/m10mm_adv/simple,						60),
		new /datum/data/wasteland_equipment("Speed strip (.357)",			/obj/item/ammo_box/a357,											70),
		new /datum/data/wasteland_equipment("Smoke Bomb",					/obj/item/grenade/smokebomb,										70),
		new /datum/data/wasteland_equipment("Explosives Crafting Guide",	/obj/item/book/granter/trait/explosives,							600),
		new /datum/data/wasteland_equipment("Firebomb",						/obj/item/grenade/homemade/firebomb,
		new /datum/data/wasteland_equipment("Advanced Explosives Crafting Guide",	/obj/item/book/granter/trait/explosives_advanced,							2000),								100),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Handgun magazine (.45)",		/obj/item/ammo_box/magazine/m45,									50),
		new /datum/data/wasteland_equipment("9mm pistol magazine (9mm)",	/obj/item/ammo_box/magazine/m9mm,									50),
		new /datum/data/wasteland_equipment("10mm pistol magazine (10mm)",	/obj/item/ammo_box/magazine/m10mm_adv/simple,						60),
		new /datum/data/wasteland_equipment("Speed strip (.357)",			/obj/item/ammo_box/a357,											70),
		new /datum/data/wasteland_equipment("Smoke Bomb",					/obj/item/grenade/smokebomb,										70),
		new /datum/data/wasteland_equipment("Explosives Crafting Guide",	/obj/item/book/granter/trait/explosives,							600),
		new /datum/data/wasteland_equipment("Firebomb",						/obj/item/grenade/homemade/firebomb,								100),
		new /datum/data/wasteland_equipment("Advanced Explosives Crafting Guide",	/obj/item/book/granter/trait/explosives_advanced,							2000),
	)

/obj/machinery/mineral/wasteland_vendor/clothing
	name = "Wasteland Vending Machine - Clothing"
	icon_state = "armor_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Worn outft",						/obj/item/clothing/under/f13/worn,								15),
		new /datum/data/wasteland_equipment("Settler outfit",					/obj/item/clothing/under/f13/settler,							30),
		new /datum/data/wasteland_equipment("Merchant outfit",					/obj/item/clothing/under/f13/merchant,							40),
		new /datum/data/wasteland_equipment("Followers outfit",					/obj/item/clothing/under/f13/followers,							80),
		new /datum/data/wasteland_equipment("Combat uniform",					/obj/item/clothing/under/f13/combat,							250),
		new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",	/obj/item/book/granter/trait/trekking,							600)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Worn outft",						/obj/item/clothing/under/f13/worn,								15),
		new /datum/data/wasteland_equipment("Settler outfit",					/obj/item/clothing/under/f13/settler,							30),
		new /datum/data/wasteland_equipment("Merchant outfit",					/obj/item/clothing/under/f13/merchant,							40),
		new /datum/data/wasteland_equipment("Followers outfit",					/obj/item/clothing/under/f13/followers,							80),
		new /datum/data/wasteland_equipment("Combat uniform",					/obj/item/clothing/under/f13/combat,							250),
		new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",	/obj/item/book/granter/trait/trekking,							600)
		)

/obj/machinery/mineral/wasteland_vendor/general
	name = "Wasteland Vending Machine - General"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Drinking glass",				/obj/item/reagent_containers/food/drinks/drinkingglass,				5),
		new /datum/data/wasteland_equipment("Zippo",						/obj/item/lighter,													20),
		new /datum/data/wasteland_equipment("Explorer satchel",				/obj/item/storage/backpack/satchel/explorer,						25),
		new /datum/data/wasteland_equipment("Spray bottle",					/obj/item/reagent_containers/spray,									35),
		new /datum/data/wasteland_equipment("Bottle of E-Z-Nutrient",		/obj/item/reagent_containers/glass/bottle/nutrient/ez,				40),
		new /datum/data/wasteland_equipment("Craftsmanship Monthly",		/obj/item/book/granter/trait/techno,								600)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Drinking glass",				/obj/item/reagent_containers/food/drinks/drinkingglass,				5),
		new /datum/data/wasteland_equipment("Zippo",						/obj/item/lighter,													20),
		new /datum/data/wasteland_equipment("Explorer satchel",				/obj/item/storage/backpack/satchel/explorer,						25),
		new /datum/data/wasteland_equipment("Spray bottle",					/obj/item/reagent_containers/spray,									35),
		new /datum/data/wasteland_equipment("Bottle of E-Z-Nutrient",		/obj/item/reagent_containers/glass/bottle/nutrient/ez,				40),
		new /datum/data/wasteland_equipment("Craftsmanship Monthly",		/obj/item/book/granter/trait/techno,								600)
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
	name = "Wasteland Pip-N-Walk"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Pip-boy 3000",			/obj/item/pda,																75),
		new /datum/data/wasteland_equipment("Reprogrammable ID",	/obj/item/card/id/selfassign,												25),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Pip-boy: Reagent Scanner",	/obj/item/cartridge/chemistry,						50),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Pip-boy: Health Scanner",	/obj/item/cartridge/medical,						50),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Pip-boy: Signaler",	/obj/item/cartridge/signal,								50),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Pip-boy 3000",			/obj/item/pda,																150),
		new /datum/data/wasteland_equipment("Reprogrammable ID",	/obj/item/card/id/selfassign,												100),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Pip-boy: Reagent Scanner",	/obj/item/cartridge/chemistry,						50),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Pip-boy: Health Scanner",	/obj/item/cartridge/medical,						50),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Pip-boy: Signaler",	/obj/item/cartridge/signal,								50),
		)


/obj/machinery/mineral/wasteland_vendor/special
	name = "Wasteland Vending Machine - Special"
	icon_state = "liberationstation_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Random manual",					/obj/item/book/manual/random,									40),
		new /datum/data/wasteland_equipment("Box of ingredients - American",	/obj/item/storage/box/ingredients/american,						80),
		new /datum/data/wasteland_equipment("Music box",						/obj/item/holodisk/musicbox,									400),
		new /datum/data/wasteland_equipment("???",								/obj/item/toy/syndicateballoon,									3000)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Random manual",					/obj/item/book/manual/random,									40),
		new /datum/data/wasteland_equipment("Box of ingredients - American",	/obj/item/storage/box/ingredients/american,						80),
		new /datum/data/wasteland_equipment("Music box",						/obj/item/holodisk/musicbox,									400),
		new /datum/data/wasteland_equipment("???",								/obj/item/toy/syndicateballoon,									3000)
		)

/obj/machinery/mineral/wasteland_vendor/advcomponents
	name = "Wasteland Vending Machine - Components"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					200),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					200),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					200),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						200),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						200),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						200)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					200),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					200),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					200),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						200),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						200),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						200)
		)

/obj/machinery/mineral/wasteland_vendor/attachments
	name = "Wasteland Vending Machine - Attachments"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Weapon Optics",				/obj/item/attachments/scope,									150),
		new /datum/data/wasteland_equipment("Recoil Compensator",			/obj/item/attachments/recoil_decrease,							100),
		new /datum/data/wasteland_equipment("Burst Cam",					/obj/item/attachments/burst_improvement,						200)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Weapon Optics",				/obj/item/attachments/scope,									150),
		new /datum/data/wasteland_equipment("Recoil Compensator",			/obj/item/attachments/recoil_decrease,							100),
		new /datum/data/wasteland_equipment("Burst Cam",					/obj/item/attachments/burst_improvement,						200)
		)

/obj/machinery/mineral/wasteland_vendor/crafting
	name = "Wasteland Vending Machine - Crafting"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("High Quality Parts",				/obj/item/stack/crafting/goodparts,									25),
		new /datum/data/wasteland_equipment("Metal Parts",						/obj/item/stack/crafting/metalparts,								10),
		new /datum/data/wasteland_equipment("Electronic Parts",					/obj/item/stack/crafting/electronicparts,							5),
		new /datum/data/wasteland_equipment("Metal Sheets x 20",				/obj/item/stack/sheet/metal/twenty,									50),
		new /datum/data/wasteland_equipment("Metal Sheets x 50",				/obj/item/stack/sheet/metal/fifty,									115),
		new /datum/data/wasteland_equipment("Glass Sheets x 10",				/obj/item/stack/sheet/glass/ten,									30),
		new /datum/data/wasteland_equipment("Glass Sheets x 50",				/obj/item/stack/sheet/glass/fifty,									90),
		new /datum/data/wasteland_equipment("Sacks of Concrete x 10",			/obj/item/stack/sheet/mineral/concrete/ten,							25),
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("High Quality Parts",				/obj/item/stack/crafting/goodparts,									25),
		new /datum/data/wasteland_equipment("Metal Parts",						/obj/item/stack/crafting/metalparts,								10),
		new /datum/data/wasteland_equipment("Electronic Parts",					/obj/item/stack/crafting/electronicparts,							5),
		new /datum/data/wasteland_equipment("Sacks of Concrete x 10",			/obj/item/stack/sheet/mineral/concrete/ten,							25),
		new /datum/data/wasteland_equipment("Metal Sheets x 20",				/obj/item/stack/sheet/metal/twenty,									50),
		new /datum/data/wasteland_equipment("Metal Sheets x 50",				/obj/item/stack/sheet/metal/fifty,									115),
		new /datum/data/wasteland_equipment("Glass Sheets x 10",				/obj/item/stack/sheet/glass/ten,									30),
		new /datum/data/wasteland_equipment("Glass Sheets x 50",				/obj/item/stack/sheet/glass/fifty,									90),
		new /datum/data/wasteland_equipment("Wood Planks x 50",					/obj/item/stack/sheet/mineral/wood/fifty,							50),
		new /datum/data/wasteland_equipment("Wood Planks x 20",					/obj/item/stack/sheet/mineral/wood/twenty,							20),
		new /datum/data/wasteland_equipment("Art Canvas 19x19",					/obj/item/canvas/nineteenXnineteen,									20),
		new /datum/data/wasteland_equipment("Art Canvas 23x19",					/obj/item/canvas/twentythreeXnineteen,								20),
		new /datum/data/wasteland_equipment("Art Canvas 23x23",					/obj/item/canvas/twentythreeXtwentythree,							20),
		new /datum/data/wasteland_equipment("Spray Can",						/obj/item/toy/crayon/spraycan,										75),
		)

/obj/machinery/mineral/wasteland_vendor/mining
	name = "Wasteland Vending Machine - Mining"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Pickaxe",					/obj/item/pickaxe,											25),
		new /datum/data/wasteland_equipment("Mining drill",				/obj/item/pickaxe/drill,									100),
		new /datum/data/wasteland_equipment("Manual mining scanner",	/obj/item/mining_scanner,									25),
		new /datum/data/wasteland_equipment("Automatic mining scanner",	/obj/item/t_scanner/adv_mining_scanner/lesser,				200),
		new /datum/data/wasteland_equipment("Advanced mining scanner",	/obj/item/t_scanner/adv_mining_scanner,						300),
		new /datum/data/wasteland_equipment("Proto-kinetic crusher",	/obj/item/kinetic_crusher,				500),
		new /datum/data/wasteland_equipment("ORM Board",				/obj/item/circuitboard/machine/ore_redemption,				150)
		)
	highpop_list = list(
		new /datum/data/wasteland_equipment("Pickaxe",					/obj/item/pickaxe,											25),
		new /datum/data/wasteland_equipment("Mining drill",				/obj/item/pickaxe/drill,									100),
		new /datum/data/wasteland_equipment("Manual mining scanner",	/obj/item/mining_scanner,									25),
		new /datum/data/wasteland_equipment("Automatic mining scanner",	/obj/item/t_scanner/adv_mining_scanner/lesser,				200),
		new /datum/data/wasteland_equipment("Advanced mining scanner",	/obj/item/t_scanner/adv_mining_scanner,						300),
		new /datum/data/wasteland_equipment("Proto-kinetic crusher",	/obj/item/kinetic_crusher,				500),
		new /datum/data/wasteland_equipment("ORM Board",				/obj/item/circuitboard/machine/ore_redemption,				150)
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
	dat += "1 Bottle cap = [CASH_CAP_VENDOR] bottle caps value <br>"
	dat += "1 NCR dollar = [CASH_NCR_VENDOR] bottle caps value <br>"
	dat += "1 Denarius = [CASH_DEN_VENDOR] bottle caps value <br>"
	dat += "1 Aureus = [CASH_AUR_VENDOR] bottle caps value <br>"
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
			to_chat(usr, "<span class='warning'>Error: Invalid choice!</span>")
			return
		if(prize.cost > stored_caps)
			to_chat(usr, "<span class='warning'>Error: Insufficent bottle caps value for [prize.equipment_name]!</span>")
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, "<span class='notice'>[src] clanks to life briefly before vending [prize.equipment_name]!</span>")
			new prize.equipment_path(src.loc)
			SSblackbox.record_feedback("nested tally", "wasteland_equipment_bought", 1, list("[type]", "[prize.equipment_path]"))
	else if(href_list["purchase"])
		var/datum/data/wasteland_equipment/prize = locate(href_list["purchase"])
		if (!prize || !(prize in prize_list))
			to_chat(usr, "<span class='warning'>Error: Invalid choice!</span>")
			return
		if(prize.cost > stored_caps)
			to_chat(usr, "<span class='warning'>Error: Insufficent bottle caps value for [prize.equipment_name]!</span>")
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, "<span class='notice'>[src] clanks to life briefly before vending [prize.equipment_name]!</span>")
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
		var/inserted_value = FLOOR(currency.amount * 0.4, 1)
		stored_caps += inserted_value
		I.use(currency.amount)
		playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
		to_chat(usr, "You put [inserted_value] bottle caps value to a vending machine.")
		src.ui_interact(usr)
	else if(istype(I, /obj/item/stack/f13Cash/denarius))
		var/obj/item/stack/f13Cash/denarius/currency = I
		var/inserted_value = FLOOR(currency.amount * 4, 1)
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
	var/obj/item/stack/f13Cash/C = new /obj/item/stack/f13Cash/caps
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

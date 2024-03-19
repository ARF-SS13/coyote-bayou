#define BATTERY_BOX_CHARGE_BASE 10
#define BATTERY_BOX_CHARGE_OUT 0 // transfer charge from US to THEM
#define BATTERY_BOX_CHARGE_IN 1 // transfer charge from THEM to US

// ECP = 20000
// SEC = 10000
// MFC = 40000

#define BATTERY_BOX_RATE_DIVISOR 1

#define BATTERY_BOX_LV_CHARGE_RATE 32 / BATTERY_BOX_RATE_DIVISOR // 20 TPS to 0.2 SPT
#define BATTERY_BOX_MV_CHARGE_RATE 128 / BATTERY_BOX_RATE_DIVISOR // 20 TPS to 0.2 SPT
#define BATTERY_BOX_HV_CHARGE_RATE 512 / BATTERY_BOX_RATE_DIVISOR // 20 TPS to 0.2 SPT
#define BATTERY_BOX_EV_CHARGE_RATE 2048 / BATTERY_BOX_RATE_DIVISOR // 20 TPS to 0.2 SPT

#define BATTERY_BOX_CAP_DIVISOR 1

/// 1 SEC
#define BATTERY_BOX_LV_CAPACITY 10000 / BATTERY_BOX_CAP_DIVISOR // 1000 EU
/// 1 MFC / 2 ECP / 4 SEC
#define BATTERY_BOX_MV_CAPACITY 40000 / BATTERY_BOX_CAP_DIVISOR // 4000 EU
/// 5 MFC / 10 ECP / 20 SEC
#define BATTERY_BOX_HV_CAPACITY 200000 / BATTERY_BOX_CAP_DIVISOR // 20000 EU
/// 10 MFC / 20 ECP / 40 SEC
#define BATTERY_BOX_EV_CAPACITY 400000 / BATTERY_BOX_CAP_DIVISOR // 40000 EU

/// just a normal every day portable blender
/obj/item/storage/battery_box
	name = "portable charger"
	desc = "A HAYO PRO portable battery bank, used to transfer those pesky electrons from one battery to another on the go. \
		Design courtesy of Rustyville II: Rusty Harder. \nWarning: removing the capacitor will vent all the power stored in the battery bank out \
		into the nebulous fabric of reality, effectively voiding both the power and the warranty. So, try not to do that, unless you're upgrading it, \
		which you totally can do with higher tier capacitors."
	icon = 'icons/obj/powerbox.dmi'
	icon_state = "powerbox"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT
	flags_1 = CONDUCT_1 // | HEAR_1
	custom_price = 2000
	custom_premium_price = 2000
	component_type = /datum/component/storage/concrete/box/portable_charger
	custom_materials = list(
		/datum/material/iron = MINERAL_MATERIAL_AMOUNT * 10,
		/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = MINERAL_MATERIAL_AMOUNT * 5,
	)
	/// Handy link to the internal component compartment
	var/obj/item/storage/box/charger_internals/batbox
	/// The battery in our batbox
	var/obj/item/stock_parts/cell/charger_battery/internal_battery
	/// Are we charging batteries, or charging from batteries?
	var/charge_direction = BATTERY_BOX_CHARGE_OUT
	/// the soundloop
	var/datum/looping_sound/cell_charger/soundloop
	/// the last left-bar icon state we had
	var/last_left_bar_state = "powerbox_left_0"
	/// the last right-bar icon state we had
	var/last_right_bar_state = "powerbox_left_0"
	/// is the thing active?
	var/active = FALSE
	/// the last active state
	var/last_active = FALSE
	/// rate that charge is transferred in or out
	/// operates off of IC2's EU system, sorta
	var/charge_per_tick = 0

/// The blender itself
/datum/component/storage/concrete/box/portable_charger
	max_items = 5 // Batbox, switch, and 3 batterys
	max_w_class = WEIGHT_CLASS_SMALL
	quota = list(
		/obj/item/gun = 1,
		) // only one gun can be in the box at a time

/obj/item/storage/battery_box/Initialize()
	. = ..()
	START_PROCESSING(SSprocessing, src)
	soundloop = new(list(src), FALSE)

/obj/item/storage/battery_box/Destroy()
	QDEL_NULL(batbox)
	QDEL_NULL(soundloop)
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/storage/battery_box/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_BUTTON_CLICK,PROC_REF(toggle_charge_direction))
	RegisterSignal(src, COMSIG_ITEM_RECHARGE,PROC_REF(charge_me))
	RegisterSignal(src, COMSIG_CELL_CHECK_CHARGE_PERCENT,PROC_REF(charge_percent))
	RegisterSignal(src, COMSIG_ATOM_ENTERED, /atom/proc/update_icon)
	RegisterSignal(src, COMSIG_ATOM_EXITED, /atom/proc/update_icon)
	RegisterSignal(src, COMSIG_ENERGY_GUN_SELFCHARGE_TICK, .proc/get_selfcharge_mult)

/obj/item/storage/battery_box/PopulateContents()
	. = ..()
	batbox = new(src)
	var/obj/item/button/battery_toggle/butn = new(src)
	SEND_SIGNAL(butn, COMSIG_BUTTON_ATTACH, src)
	
/obj/item/storage/battery_box/examine(mob/user)
	. = ..()
	. += span_notice("The information panel reads:")
	if(charge_direction)
		. += span_green("Pulling charge from loaded batteries.")
	else
		. += span_green("Discharging into loaded batteries.")
	var/rating = check_part()
	switch(rating)
		if(1) // LV
			. += span_green("LV BatBox capacitor installed.") // canonically, lapotron crystals store power as pressure, expressed in Gibbl
			. += span_green("\tCapacity: [BATTERY_BOX_LV_CAPACITY * BATTERY_BOX_CAP_DIVISOR] Gibbl.") // only one person knows what a Gibbl is, and I think they forgot
			. += span_green("\tPower transfer rate: [BATTERY_BOX_LV_CHARGE_RATE * BATTERY_BOX_RATE_DIVISOR] EU/t.") // its also the measurement of pollution in gregtech
			. += span_green("\tAssists self-charging cells and blasters to charge 1.25x faster.")
		if(2) // MV
			. += span_green("MV CESU capacitor installed.")
			. += span_green("\tCapacity: [BATTERY_BOX_MV_CAPACITY * BATTERY_BOX_CAP_DIVISOR] Gibbl.")
			. += span_green("\tPower transfer rate: [BATTERY_BOX_MV_CHARGE_RATE * BATTERY_BOX_RATE_DIVISOR] EU/t.")
			. += span_green("\tAssists self-charging cells and blasters to charge 1.50x faster.")
		if(3) // HV
			. += span_green("HV MFE capacitor installed.")
			. += span_green("\tCapacity: [BATTERY_BOX_HV_CAPACITY * BATTERY_BOX_CAP_DIVISOR] Gibbl.")
			. += span_green("\tPower transfer rate: [BATTERY_BOX_HV_CHARGE_RATE * BATTERY_BOX_RATE_DIVISOR] EU/t.")
			. += span_green("\tAssists self-charging cells and blasters to charge 1.75x faster.")
		if(4) // EV
			. += span_green("EV MFSU capacitor installed.")
			. += span_green("\tCapacity: [BATTERY_BOX_EV_CAPACITY * BATTERY_BOX_CAP_DIVISOR] Gibbl.")
			. += span_green("\tPower transfer rate: [BATTERY_BOX_EV_CHARGE_RATE * BATTERY_BOX_RATE_DIVISOR] EU/t.")
			. += span_green("\tAssists self-charging cells and blasters to charge 2.50x faster.")
		else
			. += span_alert("WARNING: No capacitor installed!")

/obj/item/storage/battery_box/examine_more()
	. = list(span_notice("...the heck is a Gibbl?"))

/obj/item/storage/battery_box/process()
	if(!can_operate())
		become_inactive()
		update_icon()
		return
	transfer_charge()
	update_icon()

/obj/item/storage/battery_box/proc/get_battery(obj/item/powa)
	if(!istype(powa, /obj/item/stock_parts/cell) && !istype(powa, /obj/item/gun/energy))
		return FALSE
	var/obj/item/stock_parts/cell/batt
	if(istype(powa, /obj/item/stock_parts/cell))
		batt = powa
	else if(istype(powa, /obj/item/gun/energy))
		var/obj/item/gun/energy/zap = powa
		if(!zap.can_box_charge)
			return FALSE
		batt = zap.cell
	if(!batt)
		return FALSE
	if(batt.self_recharge) // thats handled differently
		return FALSE
	switch(charge_direction)
		if(BATTERY_BOX_CHARGE_OUT)
			if(batt.charge >= batt.maxcharge)
				return FALSE
		if(BATTERY_BOX_CHARGE_IN)
			if(batt.charge <= 0)
				return FALSE
			/// we can pull charge from a non-chargable battery, but not put charge into it
			if(!batt.cancharge)
				return FALSE
	return batt

/obj/item/storage/battery_box/proc/transfer_charge()
	var/charge_amount = get_charge_rate()
	var/all_done = TRUE
	for(var/obj/item/powa in contents)
		switch(charge_direction)
			if(BATTERY_BOX_CHARGE_OUT)
				if(internal_battery.charge <= 0)
					break
			if(BATTERY_BOX_CHARGE_IN)
				if(internal_battery.charge >= internal_battery.maxcharge)
					break
		var/obj/item/stock_parts/cell/battery_to_charge = get_battery(powa)
		if(!battery_to_charge)
			continue
		all_done = FALSE
		var/true_charge_amount = 0
		if(charge_direction == BATTERY_BOX_CHARGE_OUT)
			/// the lesser of: our charge, the charge remaining in their battery, and the charge rate
			true_charge_amount = min(
				internal_battery.charge,
				battery_to_charge.maxcharge - battery_to_charge.charge,
				charge_amount,
			)
			internal_battery.use(true_charge_amount)
			battery_to_charge.give(true_charge_amount)
			battery_to_charge.update_icon()
		else
			/// the lesser of: their charge, our charge remaining, and the charge rate
			true_charge_amount = min(
				battery_to_charge.charge,
				internal_battery.maxcharge - internal_battery.charge,
				charge_amount,
			)
			battery_to_charge.use(true_charge_amount)
			battery_to_charge.update_icon()
			internal_battery.give(true_charge_amount)
	if(all_done)
		become_inactive()
	else
		become_active()

/obj/item/storage/battery_box/update_overlays()
	. = ..()
	if(!internal_battery)
		return
	var/left_state = "powerbox_left_[round(internal_battery.charge / internal_battery.maxcharge * 10)]"
	var/batteries_charge = 0
	var/batteries_max = 0
	for(var/obj/item/stock_parts/cell/powa in contents)
		batteries_charge += powa.charge
		batteries_max += powa.maxcharge
	if(batteries_max == 0)
		batteries_max = 1
	var/right_state = "powerbox_right_[round(batteries_charge / batteries_max * 10, 1)]"
	if(last_left_bar_state != left_state || last_right_bar_state != right_state || last_active != active)
		cut_overlays()
		add_overlay(left_state)
		add_overlay(right_state)
		if(active)
			add_overlay("powerbox_[charge_direction ? "charging" : "discharging"]")
		last_left_bar_state = left_state
		last_right_bar_state = right_state
		last_active = active
	batbox.update_icon()

/// switch from background to foreground processing and hum
/obj/item/storage/battery_box/proc/become_active()
	STOP_PROCESSING(SSprocessing, src)
	START_PROCESSING(SSfastprocess, src)
	soundloop.start()

/// switch from foreground to background processing and stop humming
/obj/item/storage/battery_box/proc/become_inactive()
	STOP_PROCESSING(SSfastprocess, src)
	START_PROCESSING(SSprocessing, src)
	soundloop.stop()

/obj/item/storage/battery_box/proc/toggle_charge_direction(datum/source, mob/user)
	if(!can_operate(user))
		return
	TOGGLE_VAR(charge_direction)
	SEND_SIGNAL(src, COMSIG_BUTTON_UPDATE, user, charge_direction)
	update_icon()

/obj/item/storage/battery_box/proc/charge_me(datum/source, mult)
	SIGNAL_HANDLER
	if(!mult)
		return
	. = internal_battery.give(min(internal_battery.maxcharge * 0.1, 100) * mult)

/obj/item/storage/battery_box/proc/charge_percent()
	SIGNAL_HANDLER
	var/percent = (internal_battery.charge / internal_battery.maxcharge) * 100
	return percent

/obj/item/storage/battery_box/proc/can_operate(mob/user, silent)
	. = TRUE
	if(!batbox)
		. = FALSE
	if(batbox.loc != src) // gotta be *in* the thing
		. = FALSE
	if(!istype(internal_battery))
		. = FALSE
	if(internal_battery.loc != batbox)
		. = FALSE
	if(!check_part())
		. = FALSE

/obj/item/storage/battery_box/proc/check_part()
	if(!istype(batbox))
		return FALSE
	var/obj/item/stock_parts/capacitor/grabby = locate(/obj/item/stock_parts/capacitor) in batbox
	if(istype(grabby))
		return grabby.rating

/obj/item/storage/battery_box/proc/get_charge_rate()
	var/rating = check_part()
	switch(rating)
		if(1) // LV
			return BATTERY_BOX_LV_CHARGE_RATE
		if(2) // MV
			return BATTERY_BOX_MV_CHARGE_RATE
		if(3) // HV
			return BATTERY_BOX_HV_CHARGE_RATE
		if(4) // EV
			return BATTERY_BOX_EV_CHARGE_RATE
		else
			return 0

/obj/item/storage/battery_box/proc/get_selfcharge_mult()
	var/rating = check_part()
	switch(rating)
		if(1) // LV
			return 1.25
		if(2) // MV
			return 1.50
		if(3) // HV
			return 1.75
		if(4) // EV
			return 2.50
		else
			return 1

/datum/component/storage/concrete/charger_internals
	max_items = 3 // battery, persona core, capacitor. Battery cant be removed, so really 1
	max_w_class = STORAGE_BOX_DEFAULT_MAX_SIZE
	rustle_sound = TRUE
	quota = list(
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/cell = 1,
		// /obj/item/persona_core/charger = 1,
		)

/datum/component/storage/concrete/charger_internals/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/stock_parts/cell, /obj/item/stock_parts/capacitor, /obj/item/persona_core/charger))

/obj/item/storage/box/charger_internals
	name = "Internal component compartment"
	desc = "The internal component compartment of a HAYO PRO portable charger. It houses the integrated \
			SeldMleaK battery bank alongside a port for a capacitor. This thing is part of \
			the HellBurn PRO, and thus can not (and should not) be removed. If it <i>is</i> somehow removed, please call the \
			Rustyville 2: Rusty Harder DEFCON-1 Existential Security Office at 1-800-IM-CODER when convenient."
	icon = 'icons/obj/powerbox.dmi'
	icon_state = "powerbox"
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_ALT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	component_type = /datum/component/storage/concrete/charger_internals

/obj/item/storage/box/charger_internals/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, src)
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/storage/box/charger_internals/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ENTERED, .proc/update_contents)
	RegisterSignal(src, COMSIG_ATOM_EXITED, .proc/update_contents)

/obj/item/storage/box/charger_internals/PopulateContents()
	. = ..()
	if(!istype(loc, /obj/item/storage/battery_box))
		relay_msg_admins("[src] didn't spawn in a batbox! Dan probably messed something up!")
	else
		var/obj/item/storage/battery_box/our_home = loc
		our_home.internal_battery = new(src) // spawn the battery
		new /obj/item/persona_core/charger(src) // spawn the core
		new /obj/item/stock_parts/capacitor/simple(src) // spawn the part

/obj/item/storage/box/charger_internals/Destroy()
	if(istype(loc, /obj/item/storage/battery_box))
		var/obj/item/storage/battery_box/our_home = loc
		our_home.internal_battery = null
		our_home.batbox = null
	. = ..()

/// inserted a thing into the compartment, update the cell if its a capacitor
/// doesnt spark
/obj/item/storage/box/charger_internals/proc/update_outputted(datum/source, obj/item/stock_parts/capacitor/cap)
	SIGNAL_HANDLER
	update_contents(FALSE)

/// removed a thing from the compartment, update the cell if its a capacitor
/// sparks like heck
/obj/item/storage/box/charger_internals/proc/update_inputted(datum/source, obj/item/stock_parts/capacitor/cap)
	SIGNAL_HANDLER
	update_contents(TRUE)

/// inserted a thing into the compartment, update the cell if its a capacitor
/// doesnt spark
/obj/item/storage/box/charger_internals/proc/update_contents()
	SIGNAL_HANDLER
	var/obj/item/stock_parts/capacitor/cap = locate(/obj/item/stock_parts/capacitor) in contents
	var/obj/item/stock_parts/cell/charger_battery/batterie = locate(/obj/item/stock_parts/cell/charger_battery) in contents
	var/new_rating = 0
	if(istype(cap, /obj/item/stock_parts/capacitor))
		new_rating = cap.rating
	if(istype(batterie))
		var/newmax = BATTERY_BOX_LV_CAPACITY
		switch(round(clamp(new_rating, 1, 4)))
			if(1) // LV
				newmax = BATTERY_BOX_LV_CAPACITY
			if(2) // MV
				newmax = BATTERY_BOX_MV_CAPACITY
			if(3) // HV
				newmax = BATTERY_BOX_HV_CAPACITY
			if(4) // EV
				newmax = BATTERY_BOX_EV_CAPACITY
		batterie.maxcharge = newmax
		var/difference = newmax - batterie.charge
		if(difference < 0) // if the new max is less than the current charge, zap!
			if(difference > -BATTERY_BOX_LV_CAPACITY)
				do_sparks(1, TRUE, get_turf(src))
			else if(difference > -BATTERY_BOX_MV_CAPACITY + BATTERY_BOX_LV_CAPACITY)
				do_sparks(2, TRUE, get_turf(src))
			else if(difference > -BATTERY_BOX_HV_CAPACITY + BATTERY_BOX_LV_CAPACITY)
				do_sparks(3, TRUE, get_turf(src))
			else
				do_sparks(5, TRUE, get_turf(src))
		batterie.charge = min(batterie.charge, newmax)
	update_overlays()

/obj/item/storage/box/charger_internals/update_overlays()
	. = ..()
	var/partrating = 0
	var/obj/item/stock_parts/capacitor/mine = locate(/obj/item/stock_parts/capacitor) in contents
	var/obj/item/stock_parts/cell/charger_battery/batterie = locate(/obj/item/stock_parts/cell/charger_battery) in contents
	if(istype(mine))
		partrating = clamp(mine.rating, 0, 4)
	var/battery_tenth = round((batterie.charge / batterie.maxcharge) * 10, 1)
	var/left_state = "powerbox_left_[battery_tenth]"
	var/right_state = "powerbox_right_tier_[partrating]"
	cut_overlays()
	add_overlay(left_state)
	add_overlay(right_state)

// Electron charge pack - rapid fire energy
/obj/item/stock_parts/cell/charger_battery
	name = "integrated Gibbl trap"
	desc = "A dense powerpack welded into a battery housing. Supposedly holds charge."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_state = "cell"
	start_charged = FALSE
	maxcharge = 10000 // base charge
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	w_class = WEIGHT_CLASS_SMALL
	ratingdesc = FALSE

/obj/item/stock_parts/cell/charger_battery/Initialize(mapload, override_maxcharge)
	. = ..()
	transform = matrix(transform) * 1.5
	ADD_TRAIT(src, TRAIT_NODROP, src)
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/stock_parts/cell/charger_battery/update_icon()
	cut_overlays()
	if(charge < 1)
		return
	if(charge/maxcharge >= 0.5)
		add_overlay("cell-o2")
	else
		add_overlay("cell-o1")

/obj/item/stock_parts/cell/charger_battery/examine(mob/user)
	. = ..()
	. += span_notice("The power meter reads: [span_notice("[charge / BATTERY_BOX_RATE_DIVISOR] / [maxcharge / BATTERY_BOX_CAP_DIVISOR]")] EU.")

/obj/item/storage/backpack/debug_charger
	name = "Bag of chargerstuff"
	desc = "Cool shit for testing various gblecharger!"

/obj/item/storage/backpack/debug_charger/PopulateContents()
	. = ..()
	new /obj/item/storage/battery_box(src)
	new /obj/item/clothing/under/shorts(src)
	new /obj/item/stock_parts/cell/secborg(src)
	new /obj/item/stock_parts/cell/secborg(src)
	new /obj/item/stock_parts/cell/secborg/empty(src)
	new /obj/item/stock_parts/cell/infinite(src)
	new /obj/item/stock_parts/capacitor/simple(src)
	new /obj/item/stock_parts/capacitor/adv(src)
	new /obj/item/stock_parts/capacitor/super(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)

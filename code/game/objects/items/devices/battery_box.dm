#define BATTERY_BOX_CHARGE_BASE 10
#define BATTERY_BOX_CHARGE_OUT 0
#define BATTERY_BOX_CHARGE_IN 1

/// just a normal every day portable blender
/obj/item/storage/battery_box
	name = "portable charger"
	desc = "A HellBurn PRO portable battery bank, used to charge your devices on the go."
	icon = 'icons/obj/powerbox.dmi'
	icon_state = "powerbox"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	flags_1 = CONDUCT_1 // | HEAR_1
	custom_price = 2000
	custom_premium_price = 2000
	component_type = /datum/component/storage/concrete/box/portable_charger
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

/// The blender itself
/datum/component/storage/concrete/box/portable_charger
	max_items = 4 // Batbox, switch, and a couple batteries
	max_w_class = WEIGHT_CLASS_SMALL

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
	RegisterSignal(src, COMSIG_BUTTON_CLICK, .proc/toggle_charge_direction)
	RegisterSignal(src, COMSIG_ITEM_RECHARGE, .proc/charge_me)
	RegisterSignal(src, COMSIG_CELL_CHECK_CHARGE_PERCENT, .proc/charge_percent)
	RegisterSignal(src, COMSIG_ATOM_ENTERED, /atom/proc/update_icon)
	RegisterSignal(src, COMSIG_ATOM_EXITED, /atom/proc/update_icon)

/obj/item/storage/battery_box/PopulateContents()
	. = ..()
	batbox = new(src)
	var/obj/item/button/battery_toggle/butn = new(src)
	SEND_SIGNAL(butn, COMSIG_BUTTON_ATTACH, src)
	
/obj/item/storage/battery_box/examine(mob/user)
	. = ..()
	if(charge_direction)
		. += span_notice("It is currently set to charge itself from batteries.")
	else
		. += span_notice("It is currently set to charge batteries.")
	var/rating = check_part()
	if(rating)
		. += span_notice("The capacitor inside will transfer up to [rating * BATTERY_BOX_CHARGE_BASE * 5] EU/s.")
	else
		. += span_alert("It needs a capacitor in its internal compartment to run!")

/obj/item/storage/battery_box/process()
	if(!can_operate())
		become_inactive()
		update_icon()
		return
	if(charge_direction == BATTERY_BOX_CHARGE_OUT)
		charge_out()
	else
		charge_in()
	update_icon()

/obj/item/storage/battery_box/proc/charge_out()
	var/charge_amount = BATTERY_BOX_CHARGE_BASE * check_part()
	var/all_done = TRUE
	for(var/obj/item/stock_parts/cell/powa in contents)
		if(internal_battery.charge <= 0)
			break
		if(powa.charge >= powa.maxcharge)
			continue
		all_done = FALSE
		var/true_charge_amount = min(powa.maxcharge - powa.charge, internal_battery.charge, charge_amount)
		internal_battery.use(true_charge_amount)
		powa.give(true_charge_amount)
	if(all_done)
		become_inactive()
	else
		become_active()

/obj/item/storage/battery_box/proc/charge_in()
	var/charge_amount = BATTERY_BOX_CHARGE_BASE * check_part()
	var/all_done = TRUE
	for(var/obj/item/stock_parts/cell/powa in contents)
		if(internal_battery.charge >= internal_battery.maxcharge)
			break
		if(powa.charge <= 0)
			continue
		all_done = FALSE
		var/true_charge_amount = min(powa.charge, internal_battery.maxcharge - internal_battery.charge, charge_amount)
		powa.use(true_charge_amount)
		internal_battery.give(true_charge_amount)
	if(all_done)
		become_inactive()
	else
		become_active()

/obj/item/storage/battery_box/update_overlays()
	. = ..()
	if(!internal_battery)
		message_admins("Battery box [src] has no internal battery, but is trying to discharge it. Lagg is a dorknob.")
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

/obj/item/storage/battery_box/proc/become_active()
	STOP_PROCESSING(SSprocessing, src)
	START_PROCESSING(SSfastprocess, src)
	soundloop.start()

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
	. = internal_battery.give(internal_battery.maxcharge * 0.1 * mult)

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
	desc = "The internal component compartment of a HellBurn PRO portable charger. It houses the integrated \
			SeldMleaK battery bank alongside a port for a capacitor. This thing is part of \
			the HellBurn PRO, and thus can not (and should not) be removed. If it <i>is</i> somehow removed, please call the \
			DEFCON-1 Existential Security Office at 1-800-IM-CODER when convenient."
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
	RegisterSignal(src, COMSIG_ATOM_ENTERED, /atom/proc/update_icon)
	RegisterSignal(src, COMSIG_ATOM_EXITED, /atom/proc/update_icon)

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
	name = "PowerMAX integrated battery"
	desc = "A dense powerpack welded into a battery housing. Supposedly holds charge."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_state = "cell"
	maxcharge = 900
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
	. += span_notice("The power meter reads: [span_notice("[charge] / [maxcharge]")] EU.")





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
	new /obj/item/stock_parts/cell/secborg/empty(src)
	new /obj/item/stock_parts/capacitor/simple(src)
	new /obj/item/stock_parts/capacitor/simple(src)
	new /obj/item/stock_parts/capacitor/adv(src)
	new /obj/item/stock_parts/capacitor/adv(src)
	new /obj/item/stock_parts/capacitor/super(src)
	new /obj/item/stock_parts/capacitor/super(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)

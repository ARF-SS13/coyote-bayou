#define PLASMA_CHARGE_LENIENCY 0.3
#define PLASMA_DEPLETION_RATE 0.006

/obj/item/melee/energy
	name = "plasma cutter"
	desc = "A specialty designed melee weapon using plasma."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "plasmacutter"
	item_state = "plasmacutter"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	damtype = "fire"
	heat = 3500
	force = 25
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("burned")
	armor = ARMOR_VALUE_GENERIC_ITEM
	attack_speed = CLICK_CD_MELEE

	var/turned_on = FALSE
	var/obj/item/stock_parts/cell/cell
	var/hitcost = 750
	var/preload_cell_type //if not empty the cutter starts with this type of cell

/obj/item/melee/energy/examine(mob/user)
	. = ..()
	. += span_notice("Right click attack while in combat mode to disarm instead of stun.")

/obj/item/melee/energy/get_cell()
	. = cell
	if(iscyborg(loc))
		var/mob/living/silicon/robot/R = loc
		. = R.get_cell()

/obj/item/melee/energy/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is putting the live [name] in [user.p_their()] mouth! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (FIRELOSS)

/obj/item/melee/energy/Initialize(mapload)
	. = ..()
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	update_icon()

/obj/item/melee/energy/loaded //this one starts with a cell pre-installed.
	preload_cell_type = /obj/item/stock_parts/cell/high/plus

/obj/item/melee/energy/proc/deductcharge(chrgdeductamt, chargecheck = TRUE, explode = TRUE)
	var/obj/item/stock_parts/cell/copper_top = get_cell()
	if(!copper_top)
		switch_status(FALSE, TRUE)
		return FALSE
	//Note this value returned is significant, as it will determine
	//if a stun is applied or not

	copper_top.use(min(chrgdeductamt, copper_top.charge), explode)
	if(QDELETED(src))
		return FALSE
	if(turned_on && (!copper_top || !copper_top.charge || (chargecheck && copper_top.charge < (hitcost * PLASMA_CHARGE_LENIENCY))))
		//we're below minimum, turn off
		switch_status(FALSE)

/obj/item/melee/energy/proc/switch_status(new_status = FALSE, silent = FALSE)
	if(turned_on != new_status)
		turned_on = new_status
		if(!silent)
			playsound(loc, "sparks", 75, 1, -1)
		if(turned_on)
			START_PROCESSING(SSobj, src)
		else
			STOP_PROCESSING(SSobj, src)
	update_icon()

/obj/item/melee/energy/process()
	deductcharge(round(hitcost * PLASMA_DEPLETION_RATE), FALSE, FALSE)

/obj/item/melee/energy/update_icon_state()
	if(turned_on)
		icon_state = "[initial(name)]_active"
	else if(!cell)
		icon_state = "[initial(name)]_nocell"
	else
		icon_state = "[initial(name)]"

/obj/item/melee/energy/examine(mob/user)
	. = ..()
	var/obj/item/stock_parts/cell/copper_top = get_cell()
	if(copper_top)
		. += span_notice("\The [src] is [round(copper_top.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

/obj/item/melee/energy/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, span_notice("[src] already has a cell."))
		else
			if(C.maxcharge < (hitcost * PLASMA_CHARGE_LENIENCY))
				to_chat(user, span_notice("[src] requires a higher capacity cell."))
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, span_notice("You install a cell in [src]."))
			update_icon()

	else if(istype(W, /obj/item/screwdriver))
		if(cell)
			cell.update_icon()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, span_notice("You remove the cell from [src]."))
			switch_status(FALSE, TRUE)
	else
		return ..()

/obj/item/melee/energy/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF))
		switch_status(FALSE)
		if(!iscyborg(loc))
			deductcharge(severity*10, TRUE, FALSE)

/obj/item/melee/energy/eve
	name = "plasma cutter eve"
	desc = "A violet colored plasma cutter."
	icon_state = "evecutter"
	item_state = "evecutter"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 30
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("burned")
	light_color = "#BF40BF"

/obj/item/melee/energy/adam
	name = "plasma cutter adam"
	desc = "A crimson colored plasma cutter."
	icon_state = "adamcutter"
	item_state = "adamcutter"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 40
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("burned")
	light_color = "#DC143C"

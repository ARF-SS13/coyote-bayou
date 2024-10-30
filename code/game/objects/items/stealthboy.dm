/obj/item/stealthboy
	name = "Stealth Module"
	desc = "Something that looks suspiciously like a datapal, but works to hide you from critters."
	icon = 'icons/obj/pda.dmi' //Placeholder till ones sprited
	icon_state = "pda" //Placeholder till ones sprited
	item_flags = NOBLUDGEON
	slot_flags = INV_SLOTBIT_BELT
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/stock_parts/cell/cell = /obj/item/stock_parts/cell/high/slime
	var/use_per_tick = 1000 // normal cell has 10000 charge, 200 charge/second = 50 seconds of stealth //if the previous comment is correct this is 25 seconds of stealth	
	var/on = FALSE
	actions_types = list(/datum/action/item_action/stealthboy_cloak)

/obj/item/stealthboy/Initialize()
	. = ..()
	if(ispath(cell))
		cell = new cell(src)

/obj/item/stealthboy/Destroy()
	. = ..()
	var/mob/living/carbon/human/user = loc
	if(ishuman(user))
		user.alpha = initial(user.alpha)

/obj/item/stealthboy/ui_action_click(mob/user)
	if(!ishuman(user))
		return
	if(user.get_item_by_slot(SLOT_BELT) == src)
		on = !on
		if(on)
			Activate(user)
		else
			Deactivate(user)
	return

// /obj/item/stealthboy/AltClick(mob/living/user)
// 	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
// 		return ..()
// 	eject_cell(user)
// 	return

//we don't want them replacing cells
// /obj/item/stealthboy/proc/eject_cell(mob/living/user)
// 	if(!cell)
// 		to_chat(user, span_warning("[src] has no cell installed."))
// 		return
// 	if(on && user.get_item_by_slot(SLOT_BELT) == src)
// 		Deactivate(user)
// 	cell.add_fingerprint(user)
// 	user.put_in_hands(cell)
// 	user.show_message(span_notice("You remove [cell]."))
// 	cell = null

// /obj/item/stealthboy/proc/insert_cell(mob/living/user, obj/item/stock_parts/cell/new_cell)
// 	if(cell)
// 		eject_cell(user)
// 	if(user.transferItemToLoc(new_cell, src))
// 		cell = new_cell
// 		to_chat(user, span_notice("You successfully install \the [cell] into [src]."))

// /obj/item/stealthboy/attackby(obj/item/I, mob/living/carbon/human/user, params)
// 	if(istype(I, /obj/item/stock_parts/cell))
// 		insert_cell(user, I)
// 		return
// 	. = ..()

/obj/item/stealthboy/item_action_slot_check(slot, mob/user)
	if(slot == SLOT_BELT)
		return 1

/obj/item/stealthboy/examine(mob/user)
	. = ..()
	if(istype(cell))
		. += "The charge meter reads [round(cell.percent() )]%."

/obj/item/stealthboy/proc/Activate(mob/living/carbon/human/user)
	if(!user)
		Deactivate(FALSE)
		return
	if(!istype(cell))
		user.show_message(span_alert("There's no cell in [src]!"))
		Deactivate(FALSE)
		return
	if(!cell.use(use_per_tick))
		user.show_message(span_alert("There's not enough power in [src]'s [cell.name]!"))
		usr.faction -= list(
	"supermutant",
	"raider",
	"china",
	"enclave",
	"wastebot",
	"ghoul",
	"cazador",
	"bs",
	"vault",
	"city",
	"tribe",
	"Legion",
	"NCR",
	"gecko",
	"rat",
	"ant",
	"radscorpion",
	"crabs", 
	"trog",
	"plants",
	"tunneller",
	"wolf",
	"hostile",
	"russian", 
	"yaoguai",
	"carp",
	"duck",
	"spooky",
	"faithless",
	"vines"
	)
		Deactivate(FALSE)
		return
	to_chat(user, span_notice("You activate \The [src]."))
	animate(user, alpha = 60, time = 3 SECONDS)
	usr.faction += list(
	"supermutant",
	"raider",
	"china",
	"enclave",
	"wastebot",
	"ghoul",
	"cazador",
	"bs",
	"vault",
	"city",
	"tribe",
	"Legion",
	"NCR",
	"gecko",
	"rat",
	"ant",
	"radscorpion",
	"crabs", 
	"trog",
	"plants",
	"tunneller",
	"wolf",
	"hostile",
	"russian", 
	"yaoguai",
	"carp",
	"duck",
	"spooky",
	"faithless",
	"vines"
	)

	START_PROCESSING(SSobj, src)
	on = TRUE

/obj/item/stealthboy/proc/Deactivate(mob/living/carbon/human/user)
	if(!ishuman(user))
		user = loc
		if(!ishuman(user))
			return
	animate(user, alpha = initial(user.alpha), time = 3 SECONDS)
	to_chat(user, span_notice("You deactivate \The [src]."))
	usr.faction -= list(
	"supermutant",
	"raider",
	"china",
	"enclave",
	"wastebot",
	"ghoul",
	"cazador",
	"bs",
	"vault",
	"city",
	"tribe",
	"Legion",
	"NCR",
	"gecko",
	"rat",
	"ant",
	"radscorpion",
	"crabs", 
	"trog",
	"plants",
	"tunneller",
	"wolf",
	"hostile",
	"russian", 
	"yaoguai",
	"carp",
	"duck",
	"spooky",
	"faithless",
	"vines"
	)
	STOP_PROCESSING(SSobj, src)
	on = FALSE

/obj/item/stealthboy/dropped(mob/user)
	..()
	Deactivate(user)

/obj/item/stealthboy/equipped(mob/user, slot)
	. = ..()
	if(user?.get_item_by_slot(SLOT_BELT) != src)
		Deactivate(user)

/obj/item/stealthboy/process()
	var/mob/living/carbon/human/user = loc
	if(!ishuman(user) || user.get_item_by_slot(SLOT_BELT) != src)
		Deactivate()
		return
	if((!istype(cell) || !cell?.use(use_per_tick)))
		Deactivate(user)
		return

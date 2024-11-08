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
	actions_types = list(/datum/action/item_action/stealthboy_cloak)
	var/mybar
	var/mob/applyingto
	var/on = FALSE
	var/time_left = 30 SECONDS
	var/min_time_left = 15 SECONDS
	var/last_tick = 0
	var/list/factionlist = list(
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
		"vines",
	)

/obj/item/stealthboy/Destroy()
	Deactivate()
	. = ..()

/obj/item/stealthboy/ui_action_click(mob/user)
	Toggle(user)

// /obj/item/stealthboy/item_action_slot_check(slot, mob/user)
// 	if(slot == SLOT_BELT)
// 		return 1

/obj/item/stealthboy/examine(mob/user)
	. = ..()
	if(istype(cell))
		. += "The charge meter reads [round(cell.percent() )]%."

/obj/item/stealthboy/proc/Toggle(mob/living/carbon/human/user)
	if(!on && HAS_TRAIT(user, "stealthinvis"))
		Deactivate(user)	
	if(CanActivate(user, TRUE))
		StartActivating(user)
	else
		Deactivate(user)

/obj/item/stealthboy/proc/CanActivate(mob/living/carbon/human/user, msg)
	if(on)
		return
	if(time_left < min_time_left)
		if(msg)
			to_chat(user, span_alert("The [src] doesn't have enough charge left to activate!"))
		return FALSE
	if(user.stat != CONSCIOUS)
		if(msg)
			to_chat(user, span_alert("You're too messed up to activate \The [src]!"))
		return FALSE
	if(user.get_item_by_slot(SLOT_BELT) != src)
		if(msg)
			to_chat(user, span_alert("You need to be wearing \The [src] on your belt to activate it!"))
		return FALSE

/obj/item/stealthboy/proc/StartActivating(mob/living/carbon/human/user)
	if(on)
		return
	if(!do_after(user, 5 SECONDS, TRUE, src, TRUE, null, null, null, FALSE, TRUE, TRUE, FALSE, FALSE))
		to_chat(user, span_alert("[src] failed to activate!"))
		return
	if(CanActivate(user, TRUE))
		Activate(user)

/obj/item/stealthboy/proc/Activate(mob/living/carbon/human/user)
	if(on)
		return
	if(applying_to)
		if(applying_to != user)
			Deactivate()
		else
			return
	ADD_TRAIT(user, "stealthinvis")
	applying_to = user
	to_chat(user, span_notice("You activate \The [src]."))
	last_tick = world.time
	animate(user, alpha = 60, time = 3 SECONDS)
	user.faction += factionlist
	START_PROCESSING(SSfastprocess, src)
	on = TRUE

/obj/item/stealthboy/proc/Deactivate(mob/living/carbon/human/user, msg)
	if(!user)
		user = applying_to
	to_chat(user, span_notice("You deactivate \The [src]."))
	user.faction -= factionlist
	applying_to = null
	on = FALSE
	applying_to = null
	animate(user, alpha = initial(user.alpha), time = 3 SECONDS)

/obj/item/stealthboy/process()
	if(!applying_to)
		return
	if(!last_tick)
		last_tick = world.time
		return
	var/delta = world.time - last_tick
	last_tick = world.time
	time_left -= delta
	if(time_left <= 0)
		Deactivate()



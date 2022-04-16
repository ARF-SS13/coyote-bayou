/obj/item/stealthboy
	name = "Stealth Boy"
	desc = "The RobCo Stealth Boy 3001 is a personal stealth device worn on one's wrist. It generates a modulating field that transmits the reflected light from one side of an object to the other, making a person much harder to notice (but not completely invisible)."
	icon = 'icons/obj/clockwork_objects.dmi' //placeholder
	icon_state = "rare_pepe" //placeholder
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/mob/living/carbon/human/user = null
	var/charge = 350
	var/max_charge = 350
	var/on = FALSE
	var/old_alpha = 0
	actions_types = list(/datum/action/item_action/stealthboy_cloak)

/obj/item/stealthboy/ui_action_click(mob/user)
	if(user.get_item_by_slot(SLOT_BELT) == src)
		if(!on)
			Activate(usr)
		else
			Deactivate()
	return

/obj/item/stealthboy/item_action_slot_check(slot, mob/user)
	if(slot == SLOT_BELT)
		return 1

/obj/item/stealthboy/proc/Activate(mob/living/carbon/human/user)
	if(!user)
		return
	to_chat(user, "<span class='notice'>You activate \The [src].</span>")
	src.user = user
	START_PROCESSING(SSobj, src)
	old_alpha = user.alpha
	on = TRUE

/obj/item/stealthboy/proc/Deactivate()
	to_chat(user, "<span class='notice'>You deactivate \The [src].</span>")
	STOP_PROCESSING(SSobj, src)
	if(user)
		user.alpha = old_alpha
	on = FALSE
	user = null

/obj/item/stealthboy/dropped(mob/user)
	..()
	if(user && user.get_item_by_slot(SLOT_BELT) != src)
		Deactivate()

/obj/item/stealthboy/process()
	if(user.get_item_by_slot(SLOT_BELT) != src)
		Deactivate()
		return
	if(on)
		animate(user,alpha = CLAMP(255 - charge,0,255),time = 10)
		charge = max(0,charge - 4)

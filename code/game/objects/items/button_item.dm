/// Items that arent items at all, but are instead buttons!
/// okay they're just items that can't be picked up, and send a signal when clicked
/// Designed to be inside a container, and used to trigger something

/obj/item/button
	name = "button"
	desc = "A button. It probably does something."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "game_kit"
	w_class = WEIGHT_CLASS_TINY
	interaction_flags_item = 0 // can't pick it up
	var/click_sound = 'sound/machines/switch_on.ogg'

/obj/item/button/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, src)
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/button/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_CLICKED,PROC_REF(activate))
	RegisterSignal(src, COMSIG_BUTTON_ATTACH,PROC_REF(attach_to_storage))

/obj/item/button/attackby(obj/item/W, mob/user, params)
	activate(user)

/obj/item/button/proc/attach_to_storage(datum/source, obj/item/storage/S)
	RegisterSignal(S, COMSIG_BUTTON_UPDATE,PROC_REF(reaction))

/obj/item/button/proc/activate(datum/source, mob/user)
	playsound(get_turf(src), click_sound, 50, TRUE)
	SEND_SIGNAL(loc, COMSIG_BUTTON_CLICK, user, src)

/obj/item/button/proc/reaction(datum/source, parameters)
	return

/obj/item/button/proc/use_message(mob/user)
	to_chat(user, span_notice("You press [src]."))

/obj/item/button/battery_toggle
	name = "power flow switch"
	desc = "A switch that toggles the direction of power flow."
	icon = 'icons/obj/power.dmi'
	icon_state = "switch-dbl-down"

/obj/item/button/battery_toggle/reaction(datum/source, mob/user, parameters)
	icon_state = "switch-dbl-[parameters ? "up" : "down"]"
	if(parameters)
		to_chat(user, span_notice("You set the portable charger to charge itself from batteries."))
	else
		to_chat(user, span_notice("You set the portable charger to charge batteries."))


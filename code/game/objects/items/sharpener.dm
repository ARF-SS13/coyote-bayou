/obj/item/sharpener
	name = "whetstone"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "sharpener"
	desc = "(click the icon with your melee weapon in your active hand to use) A cache of oils and crystals and such to enhance a weapon."
	force = 5
	var/used = 0
	var/increment = 10 // literally 2x Masterwork
	var/max = 10000
	var/prefix = "enhanced"
	var/requires_sharpness = 0


/obj/item/sharpener/attackby(obj/item/I, mob/user, params)
	if(used)
		to_chat(user, span_warning("The [src] is too worn to use again!"))
		return
	if(I.force >= max || I.throwforce >= max)//no esword sharpening
		to_chat(user, span_warning("[I] is much too powerful to sharpen further!"))
		return
	if(requires_sharpness && !I.sharpness)
		to_chat(user, span_warning("You can only sharpen items that are already sharp, such as knives!"))
		return
	if(istype(I, /obj/item/melee/transforming/energy))
		to_chat(user, span_warning("You don't think \the [I] will be the thing getting modified if you use it on \the [src]!"))
		return

	var/signal_out = SEND_SIGNAL(I, COMSIG_ITEM_SHARPEN_ACT, increment, max)
	if(signal_out & COMPONENT_BLOCK_SHARPEN_MAXED)
		to_chat(user, span_warning("[I] is much too powerful to sharpen further!"))
		return
	if(signal_out & COMPONENT_BLOCK_SHARPEN_BLOCKED)
		to_chat(user, span_warning("[I] is not able to be refined right now!"))
		return
	if((signal_out & COMPONENT_BLOCK_SHARPEN_ALREADY) || (I.force > initial(I.force) && !signal_out))
		to_chat(user, span_warning("[I] has already been refined before. It cannot be refined further!"))
		return
	if(!(signal_out & COMPONENT_BLOCK_SHARPEN_APPLIED))
		I.force += increment
		I.throwforce += increment
		I.throwforce_bonus += increment
		I.force_bonus = increment
		playsound(get_turf(src), 'sound/items/unsheath.ogg', 25, 1)

	user.visible_message(span_notice("[user] enhances [I] with [src]!"), span_notice("You enhance [I], making it much more deadly than before."))
	I.sharpness = SHARP_POINTY
	I.throwforce = clamp(I.throwforce + increment, 0, max)
	I.name = "[prefix] [I.name]"
	name = "useless [name]"
	desc = "[desc] At least, it used to."
	used = 1
	update_icon()

/obj/item/sharpener/super
	name = "super whetstone"
	desc = "A block that will make your weapon sharper than Einstein on adderall."
	increment = 200
	max = 200
	prefix = "super-sharpened"
	requires_sharpness = 0

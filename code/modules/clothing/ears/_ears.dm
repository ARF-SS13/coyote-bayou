
//Ears: currently only used for headsets and earmuffs
/obj/item/clothing/ears
	name = "ears"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	slot_flags = INV_SLOTBIT_EARS
	resistance_flags = NONE
	custom_price = PRICE_BELOW_NORMAL

/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	inhand_icon_state = "earmuffs"
	strip_delay = 15
	equip_delay_other = 25
	resistance_flags = FLAMMABLE

/obj/item/clothing/ears/earmuffs/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/earhealing)
	AddComponent(/datum/component/wearertargeting/earprotection, list(SLOT_EARS))

/obj/item/clothing/ears/headphones
	name = "headphones"
	desc = "Unce unce unce unce. Boop!"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "headphones"
	inhand_icon_state = "headphones"
	slot_flags = INV_SLOTBIT_EARS | INV_SLOTBIT_HEAD | INV_SLOTBIT_NECK		//Fluff item, put it whereever you want!
	actions_types = list(/datum/action/item_action/toggle_headphones)
	var/headphones_on = FALSE
	custom_price = PRICE_ALMOST_CHEAP

/obj/item/clothing/ears/headphones/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/ears/headphones/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/ears/headphones/update_icon_state()
	icon_state = "[initial(icon_state)]_[headphones_on? "on" : "off"]"
	inhand_icon_state = "[initial(inhand_icon_state)]_[headphones_on? "on" : "off"]"

/obj/item/clothing/ears/headphones/proc/toggle(owner)
	headphones_on = !headphones_on
	update_icon()
	to_chat(owner, span_notice("You turn the music [headphones_on? "on. Untz Untz Untz!" : "off."]"))

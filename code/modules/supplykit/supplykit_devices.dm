


/obj/item/supplykit
	name = "supply kit"
	desc = "A well packed satchel containing all sorts of basic survival gear."
	icon = 'icons/obj/storage.dmi'
	icon_state = "backpack_enclave"
	inhand_icon_state = "backpack_enclave"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'

	slot_flags = INV_SLOTBIT_BELT
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/supplykit/Initialize(mapload, st_amount = 100)
	. = ..()
	AddComponent(/datum/component/supplykit, TRUE, null, st_amount)



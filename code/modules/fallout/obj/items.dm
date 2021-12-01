/obj/item/traumapack
	name = "trauma pack"
	desc = "A backpack filled with a blend of healing chemicals that inject automatically upon the wearer being hurt."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "traumapack"
	item_state = "welderpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	throwforce = 0
	hitsound = null
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 5
	slot_flags = ITEM_SLOT_BACK

/obj/item/traumapack/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/traumapack/Destroy()
	STOP_PROCESSING(SSobj,src)
	. = ..()

/obj/item/traumapack/process()
	if(iscarbon(loc))
		var/mob/living/carbon/M = loc
		if(src == M.back)
			if(M.health < M.maxHealth)
				M.adjustBruteLoss(-2) //Heal that poor bastard
				M.adjustFireLoss(-2)
				M.adjustToxLoss(-2)
				M.adjustOxyLoss(-2)

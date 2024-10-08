/obj/item/armorkit/light
	name = "light armor kit"
	desc = "Denim and leather sheets, maybe some steel buttons or reinforcements. Will let you upgrade something that goes over your clothes to light armor."
	icon = 'modular_coyote/eris/icons/mods.dmi'
	icon_state = "weintraub"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/armorkit/light/afterattack(obj/item/target, mob/user, proximity_flag, click_parameters)
	var/used = FALSE

	if(!(isobj(target) && target.slot_flags & INV_SLOTBIT_OCLOTHING))
		return

	var/obj/item/clothing/suit/C = target

	if(C.armor <= ARMOR_VALUE_LIGHT)
		C.armor = ARMOR_VALUE_LIGHT
		C.armorislight = TRUE
		C.armor_tier_desc = ARMOR_CLOTHING_LIGHT
		used = TRUE

	if(used)
		user.visible_message("<span class = 'notice'>[user] reinforces [C] with a [src].</span>", \
		"<span class = 'notice'>You reinforce [C] with [src], making it lightly protective.</span>")
		C.name = "armored [C.name]"
		qdel(src)
		return
	else
		to_chat(user, "<span class = 'notice'>You can't upgrade [C].")
		return

/obj/item/armorkit/heavy
	name = "heavy armor kit"
	desc = "Denim and leather sheets, maybe some steel buttons or reinforcements. Will let you upgrade something that goes over your clothes to light armor."
	icon = 'modular_coyote/eris/icons/mods.dmi'
	icon_state = "overshooter"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/armorkit/heavy/afterattack(obj/item/target, mob/user, proximity_flag, click_parameters)
	var/used = FALSE

	if(!(isobj(target) && target.slot_flags & INV_SLOTBIT_OCLOTHING))
		return

	var/obj/item/clothing/suit/C = target

	if(C.armorislight == FALSE)
		to_chat(user, "<span class = 'notice'>You can't upgrade [C] without the prerequisite light armor kit applied.</span>")
		return
	if(C.armorisheavy == TRUE)
		to_chat(user, "<span class = 'notice'>You can't upgrade [C] any further.</span>")
		return

	if(C.armor <= ARMOR_VALUE_HEAVY)
		C.armor = ARMOR_VALUE_HEAVY
		C.armorisheavy = TRUE
		C.armor_tier_desc = ARMOR_CLOTHING_HEAVY
		used = TRUE

	if(used)
		user.visible_message("<span class = 'notice'>[user] reinforces [C] with a [src].</span>", \
		"<span class = 'notice'>You reinforce [C] with [src], making it heavy armor.</span>")
		C.name = "heavily [C.name]"
		qdel(src)
		return
	else
		to_chat(user, "<span class = 'notice'>You can't upgrade [C].")
		return

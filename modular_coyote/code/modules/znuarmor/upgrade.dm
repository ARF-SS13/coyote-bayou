/obj/item/armorkit/light
	name = "light armor upgrade kit"
	desc = "Denim and leather sheets, maybe some steel buttons or reinforcements. Will let you upgrade something that goes over your clothes to light armor."
	icon = 'modular_coyote/eris/icons/mods.dmi'
	icon_state = "weintraub"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/armorkit/light/afterattack(obj/item/target, mob/user, proximity_flag, click_parameters)
	var/used = FALSE

	if(!(isobj(target) && target.slot_flags & INV_SLOTBIT_OCLOTHING))
		return

	var/obj/item/clothing/suit/C = target
	var/datum/armor/TA = C.armor
	var/list/LA = ARMOR_VALUE_LIGHT

	//check if this armor is lesser than light armor
	if( TA.linemelee < (LA["linemelee"]) || \
		TA.linebullet < (LA["linebullet"]) || \
		TA.linelaser < (LA["linelaser"]))
		var/datum/armor/nuarmor = getArmor(arglist(ARMOR_VALUE_LIGHT))
		C.armor = nuarmor
		C.armorislight = TRUE
		C.armor_tier_desc = ARMOR_CLOTHING_LIGHT
		used = TRUE

	if(used)
		user.visible_message("<span class = 'notice'>[user] reinforces [C] with a [src].</span>", \
		"<span class = 'notice'>You reinforce [C] with [src], making it lightly protective.</span>")
		if(!C.oldname)
			C.oldname = C.name
		C.name = "armored [C.oldname]"
		qdel(src)
		return
	else
		to_chat(user, "<span class = 'notice'>You can't upgrade [C].")
		return

/obj/item/armorkit/heavy
	name = "heavy armor upgrade kit"
	desc = "Ballistic kevlar, polyester sheets, maybe some aluminum inserts or titanium reinforcements. Will let you upgrade light armor into something more protective."
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
	var/datum/armor/TA = C.armor
	var/list/LA = ARMOR_VALUE_HEAVY

	//check if this armor is lesser than light armor
	if(TA.linemelee < (LA["linemelee"]) || \
		TA.linebullet < (LA["linebullet"]) || \
		TA.linelaser < (LA["linelaser"]))
		var/datum/armor/nuarmor = getArmor(arglist(ARMOR_VALUE_HEAVY))
		C.armor = nuarmor
		C.armorisheavy = TRUE
		C.armor_tier_desc = ARMOR_CLOTHING_HEAVY
		used = TRUE

	if(used)
		user.visible_message("<span class = 'notice'>[user] reinforces [C] with a [src].</span>", \
		"<span class = 'notice'>You reinforce [C] with [src], making it heavy armor.</span>")
		if(!C.oldname)
			C.oldname = C.name
		C.name = "heavily armored [C.oldname]"
		qdel(src)
		return
	else
		to_chat(user, "<span class = 'notice'>You can't upgrade [C].")
		return

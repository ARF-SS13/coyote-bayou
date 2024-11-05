/obj/item/gun/syringe
	name = "syringe gun"
	desc = "A spring loaded rifle designed to fit syringes, used to incapacitate unruly patients from a distance."
	icon_state = "syringegun"
	inhand_icon_state = "syringegun"
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	throw_speed = 3
	throw_range = 7
	force = 4
	custom_materials = list(/datum/material/iron=2000)
	clumsy_check = 0
	fire_sound = 'sound/items/syringeproj.ogg'
	fire_sound_silenced = 'sound/items/syringeproj.ogg'
	var/list/syringes = list()
	var/max_syringes = 1

/obj/item/gun/syringe/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/syringegun(src)

/obj/item/gun/syringe/recharge_newshot()
	if(!syringes.len)
		return
	chambered.newshot()

/obj/item/gun/syringe/can_shoot()
	return syringes.len

/obj/item/gun/syringe/process_chamber()
	if(chambered && !chambered.BB) //we just fired
		recharge_newshot()

/obj/item/gun/syringe/examine(mob/user)
	. = ..()
	. += "Can hold [max_syringes] syringe\s. Has [syringes.len] syringe\s remaining."

/obj/item/gun/syringe/attack_self(mob/living/user)
	if(!syringes.len)
		to_chat(user, span_warning("[src] is empty!"))
		return 0

	var/obj/item/reagent_containers/syringe/S = syringes[syringes.len]

	if(!S)
		return 0
	S.forceMove(user.loc)

	syringes.Remove(S)
	to_chat(user, span_notice("You unload [S] from \the [src]."))

	return 1

/obj/item/gun/syringe/attackby(obj/item/A, mob/user, params, show_msg = TRUE)
	if(istype(A, /obj/item/reagent_containers/syringe))
		if(syringes.len < max_syringes)
			if(!user.transferItemToLoc(A, src))
				return FALSE
			to_chat(user, span_notice("You load [A] into \the [src]."))
			syringes += A
			recharge_newshot()
			return TRUE
		else
			to_chat(user, span_warning("[src] cannot hold more syringes!"))
	return FALSE

/obj/item/gun/syringe/rapidsyringe
	name = "rapid syringe gun"
	desc = "A modification of the syringe gun design, using a rotating cylinder to store up to six syringes."
	icon_state = "rapidsyringegun"
	max_syringes = 6

/obj/item/gun/syringe/syndicate
	name = "dart pistol"
	desc = "A small spring-loaded sidearm that functions identically to a syringe gun."
	icon_state = "syringe_pistol"
	inhand_icon_state = "gun" //Smaller inhand
	w_class = WEIGHT_CLASS_SMALL
	force = 2 //Also very weak because it's smaller
	silenced = TRUE //Softer fire sound

/obj/item/gun/syringe/dna
	name = "modified syringe gun"
	desc = "A syringe gun that has been modified to fit DNA injectors instead of normal syringes."

/obj/item/gun/syringe/dna/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/dnainjector(src)

/obj/item/gun/syringe/dna/attackby(obj/item/A, mob/user, params, show_msg = TRUE)
	if(istype(A, /obj/item/dnainjector))
		var/obj/item/dnainjector/D = A
		if(D.used)
			to_chat(user, span_warning("This injector is used up!"))
			return
		if(syringes.len < max_syringes)
			if(!user.transferItemToLoc(D, src))
				return FALSE
			to_chat(user, span_notice("You load \the [D] into \the [src]."))
			syringes += D
			recharge_newshot()
			return TRUE
		else
			to_chat(user, span_warning("[src] cannot hold more syringes!"))
	return FALSE

/obj/item/gun/syringe/dart
	name = "dart gun"
	desc = "A compressed air gun, designed to fit medicinal darts for application of medicine for those patients just out of reach."
	icon_state = "dartgun"
	inhand_icon_state = "dartgun"
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=500)
	silenced = TRUE //Softer fire sound

/obj/item/gun/syringe/dart/Initialize()
	..()
	chambered = new /obj/item/ammo_casing/syringegun/dart(src)

/obj/item/gun/syringe/dart/attackby(obj/item/A, mob/user, params, show_msg = TRUE)
	if(istype(A, /obj/item/reagent_containers/syringe/dart))
		..()
	else
		to_chat(user, span_notice("You can't put the [A] into \the [src]!"))
		return FALSE

/obj/item/gun/syringe/dart/rapiddart
	name = "Repeating dart gun"
	icon_state = "rapiddartgun"
	inhand_icon_state = "rapiddartgun"

/obj/item/gun/syringe/dart/rapiddart/CheckParts(list/parts_list)
	var/obj/item/reagent_containers/glass/beaker/B = locate(/obj/item/reagent_containers/glass/beaker) in parts_list

	if(istype(B, /obj/item/reagent_containers/glass/beaker/large))
		desc = "[initial(desc)] A modification of the dart gun's pressure chamber has been perfomed using a [B], extending it's holding size to [max_syringes]."
		max_syringes = 2
		return
	else if(istype(B, /obj/item/reagent_containers/glass/beaker/plastic))
		desc = "[initial(desc)] A modification of the dart gun's pressure chamber has been perfomed using a [B], extending it's holding size to [max_syringes]."
		max_syringes = 3
		return
	else if(istype(B, /obj/item/reagent_containers/glass/beaker/meta))
		desc = "[initial(desc)] A modification of the dart gun's pressure chamber has been perfomed using a [B], extending it's holding size to [max_syringes]."
		max_syringes = 4
		return
	else if(istype(B, /obj/item/reagent_containers/glass/beaker/bluespace))
		desc = "[initial(desc)] A modification of the dart gun's pressure chamber has been perfomed using a [B], extending it's holding size to [max_syringes]."
		max_syringes = 6
		return
	else
		max_syringes = 1
		desc = "[initial(desc)] It has a [B] strapped to it, but it doesn't seem to be doing anything."
	..()

/obj/item/gun/syringe/blowgun
	name = "blowgun"
	desc = "Fire syringes at a short distance."
	icon_state = "blowgun"
	inhand_icon_state = "blowgun"
	fire_sound = 'sound/items/syringeproj.ogg'

/obj/item/gun/syringe/blowgun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	visible_message(span_danger("[user] starts aiming with a blowgun!"))
	if(do_after(user, 25, target = src))
		user.adjustStaminaLoss(20)
		user.adjustOxyLoss(20)
		..()

//The ammo/gun is stored in a back slot item
/obj/item/m2flamethrowertank
	name = "backpack fuel tank"
	desc = "The massive pressurized fuel tank for a M2 Flamethrower."
	icon = 'icons/obj/guns/flamethrower.dmi'
	icon_state = "m2_flamethrower_back"
	inhand_icon_state = "m2_flamethrower_back"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	slot_flags = INV_SLOTBIT_BACK
	w_class = WEIGHT_CLASS_HUGE
	var/obj/item/gun/ballistic/m2flamethrower/gun
	var/armed = 0 //whether the gun is attached, 0 is attached, 1 is the gun is wielded.
	var/overheat = 0
	var/overheat_max = 30
	var/heat_diffusion = 3

/obj/item/m2flamethrowertank/Initialize()
	. = ..()
	gun = new(src)
	START_PROCESSING(SSobj, src)

/obj/item/m2flamethrower/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/m2flamethrowertank/process()
	overheat = max(0, overheat - heat_diffusion)

/obj/item/m2flamethrowertank/on_attack_hand(mob/living/user)
	if(src.loc == user)
		if(!armed)
			if(user.get_item_by_slot(SLOT_BACK) == src)
				armed = 1
				if(!user.put_in_hands(gun))
					armed = 0
					to_chat(user, span_warning("You need a free hand to hold the gun!"))
					return
				update_icon()
				if(iscarbon(user))
					user.update_inv_back()
			else
				..()
		else
			to_chat(user, span_warning("You are already holding the gun!"))
	else
		..()

/obj/item/m2flamethrowertank/attackby(obj/item/W, mob/user, params)
	if(W == gun) //Don't need armed check, because if you have the gun assume its armed.
		user.dropItemToGround(gun, TRUE)
	else
		..()

/obj/item/m2flamethrowertank/dropped(mob/user)
	. = ..()
	if(armed)
		user.dropItemToGround(gun, TRUE)

/obj/item/m2flamethrowertank/MouseDrop(atom/over_object)
	. = ..()
	if(armed)
		return
	if(isliving(usr))
		var/mob/living/M = usr

		if(!over_object)
			return

		if(!M.incapacitated())

			if(istype(over_object, /atom/movable/screen/inventory/hand))
				var/atom/movable/screen/inventory/hand/H = over_object
				M.putItemFromInventoryInHandIfPossible(src, H.held_index)


/obj/item/m2flamethrowertank/update_icon_state()
	if(armed)
		icon_state = "m2_flamethrower_back"
	else
		icon_state = "m2_flamethrower_back"

/obj/item/m2flamethrowertank/proc/attach_gun(mob/user)
	if(!gun)
		gun = new(src)
	gun.forceMove(src)
	armed = 0
	if(user)
		to_chat(user, span_notice("You attach the [gun.name] to the [name]."))
	else
		src.visible_message(span_warning("The [gun.name] snaps back onto the [name]!"))
	update_icon()
	user.update_inv_back()


/obj/item/gun/ballistic/m2flamethrower
	name = "\improper M2 Flamethrower"
	desc = "A Pre-Fall M2 Flamethrower, commonly found in National Guard armoies. This one has NCR armory markings and is issued to combat engineers."
	icon = 'icons/obj/guns/flamethrower.dmi'
	icon_state = "m2_flamethrower_on"
	inhand_icon_state = "m2flamethrower"
	weapon_class = WEAPON_CLASS_RIFLE
	flags_1 = CONDUCT_1
	slowdown = 0.3
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = null
	burst_size = 2
	burst_shot_delay = 1
	//automatic = 0
	fire_delay = 2
	weapon_weight = GUN_TWO_HAND_ONLY
	fire_sound = 'sound/weapons/flamethrower.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/m2flamethrower
	casing_ejector = FALSE
	item_flags = SLOWS_WHILE_IN_HAND
	var/obj/item/m2flamethrowertank/ammo_pack
	init_firemodes = list(
		/datum/firemode/burst/three,
		/datum/firemode/automatic/rpm150
	)

/obj/item/gun/ballistic/m2flamethrower/Initialize()
	if(istype(loc, /obj/item/m2flamethrowertank)) //We should spawn inside an ammo pack so let's use that one.
		ammo_pack = loc
	else
		return INITIALIZE_HINT_QDEL //No pack, no gun

	return ..()

/obj/item/gun/ballistic/m2flamethrower/attack_self(mob/living/user)
	return

/obj/item/gun/ballistic/m2flamethrower/dropped(mob/user)
	. = ..()
	if(ammo_pack)
		ammo_pack.attach_gun(user)
	else
		qdel(src)

/obj/item/gun/ballistic/m2flamethrower/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(ammo_pack)
		if(ammo_pack.overheat < ammo_pack.overheat_max)
			ammo_pack.overheat += burst_size
			..()
		else
			to_chat(user, "The flamethrower is extremely hot! You shouldn't fire it anymore or it might blow up!.")

/obj/item/gun/ballistic/m2flamethrower/afterattack(atom/target, mob/living/user, flag, params)
	if(!ammo_pack || ammo_pack.loc != user)
		to_chat(user, "You need the backpack fuel tank to fire the gun!")
	. = ..()

/obj/item/gun/ballistic/m2flamethrower/dropped(mob/living/user)
	. = ..()
	ammo_pack.attach_gun(user)

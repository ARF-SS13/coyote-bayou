/obj/item/minigunpackbal5mm
	name = "CZ53 personal minigun ammo belt"
	desc = "The massive ammo belt for the CZ53 personal minigun."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "balholstered"
	item_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	var/obj/item/gun/ballistic/minigunbal5mm/gun
	var/armed = 0 //whether the gun is attached, 0 is attached, 1 is the gun is wielded.

/obj/item/minigunpackbal5mm/Initialize()
	. = ..()
	gun = new(src)
	START_PROCESSING(SSobj, src)

/obj/item/minigunpackbal5mm/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/minigunpackbal5mm/attack_hand(mob/living/carbon/user)
	if(src.loc == user)
		if(!armed)
			if(user.get_item_by_slot(SLOT_BACK) == src)
				armed = 1
				if(!user.put_in_hands(gun))
					armed = 0
					to_chat(user, "<span class='warning'>You need a free hand to hold the gun!</span>")
					return
				update_icon()
				user.update_inv_back()
		else
			to_chat(user, "<span class='warning'>You are already holding the gun!</span>")
	else
		..()

/obj/item/minigunpackbal5mm/attackby(obj/item/W, mob/user, params)
	if(W == gun) //Don't need armed check, because if you have the gun assume its armed.
		user.dropItemToGround(gun, TRUE)
	else
		..()

/obj/item/minigunpackbal5mm/dropped(mob/user)
	. = ..()
	if(armed)
		user.dropItemToGround(gun, TRUE)

/obj/item/minigunpackbal5mm/MouseDrop(atom/over_object)
	. = ..()
	if(armed)
		return
	if(iscarbon(usr))
		var/mob/M = usr

		if(!over_object)
			return

		if(!M.incapacitated())

			if(istype(over_object, /obj/screen/inventory/hand))
				var/obj/screen/inventory/hand/H = over_object
				M.putItemFromInventoryInHandIfPossible(src, H.held_index)


/obj/item/minigunpackbal5mm/update_icon()
	if(armed)
		icon_state = "balnotholstered"
	else
		icon_state = "balholstered"

/obj/item/minigunpackbal5mm/proc/attach_gun(mob/user)
	if(!gun)
		gun = new(src)
	gun.forceMove(src)
	armed = 0
	if(user)
		to_chat(user, "<span class='notice'>You attach the [gun.name] to the [name].</span>")
	else
		src.visible_message("<span class='warning'>The [gun.name] snaps back onto the [name]!</span>")
	update_icon()
	user.update_inv_back()


/obj/item/gun/ballistic/minigunbal5mm
	name = "CZ53 personal minigun"
	desc = "Boasting an extreme rate of fire, the Rockwell CZ53 personal minigun is the perfect weapon for suppressing fire."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "minigunbal_spin"
	item_state = "minigun"

	slowdown = GUN_SLOWDOWN_RIFLE_LMG
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_LMG
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_FASTEST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTEST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	
	flags_1 = CONDUCT_1
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	automatic = 1
	weapon_weight = GUN_TWO_HAND_ONLY
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/minigunbal5mm
	casing_ejector = TRUE
	item_flags = SLOWS_WHILE_IN_HAND
	var/obj/item/minigunpackbal5mm/ammo_pack

/obj/item/gun/ballistic/minigunbal5mm/Initialize()
	if(istype(loc, /obj/item/minigunpackbal5mm)) //We should spawn inside an ammo pack so let's use that one.
		ammo_pack = loc
	else
		return INITIALIZE_HINT_QDEL //No pack, no gun

	return ..()

/obj/item/gun/ballistic/minigunbal5mm/attack_self(mob/living/user)
	return

/obj/item/gun/ballistic/minigunbal5mm/dropped(mob/user)
	. = ..()
	if(ammo_pack)
		ammo_pack.attach_gun(user)
	else
		qdel(src)

/obj/item/gun/ballistic/minigunbal5mm/afterattack(atom/target, mob/living/user, flag, params)
	if(!ammo_pack || ammo_pack.loc != user)
		to_chat(user, "You need the backpack ammo belt to fire the gun!")
	. = ..()

/obj/item/gun/ballistic/minigunbal5mm/dropped(mob/living/user)
	. = ..()
	ammo_pack.attach_gun(user)

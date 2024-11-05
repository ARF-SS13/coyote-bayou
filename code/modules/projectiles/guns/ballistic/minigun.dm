/obj/item/minigunpackbal5mm
	name = "CZ53 personal minigun ammo belt"
	desc = "The massive ammo belt for the CZ53 personal minigun."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "balholstered"
	inhand_icon_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	slot_flags = INV_SLOTBIT_BACK
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
					to_chat(user, span_warning("You need a free hand to hold the gun!"))
					return
				update_icon()
				user.update_inv_back()
		else
			to_chat(user, span_warning("You are already holding the gun!"))
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
	if(isliving(usr))
		var/mob/living/M = usr

		if(!over_object)
			return

		if(!M.incapacitated())

			if(istype(over_object, /atom/movable/screen/inventory/hand))
				var/atom/movable/screen/inventory/hand/H = over_object
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
		to_chat(user, span_notice("You attach the [gun.name] to the [name]."))
	else
		src.visible_message(span_warning("The [gun.name] snaps back onto the [name]!"))
	update_icon()
	user.update_inv_back()


/obj/item/gun/ballistic/minigunbal5mm
	name = "CZ53 personal minigun"
	desc = "Boasting an extreme rate of fire, the Rockwell CZ53 personal minigun is the perfect weapon for suppressing fire."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "minigunbal_spin"
	inhand_icon_state = "minigun"
	weapon_class = WEAPON_CLASS_RIFLE
	slowdown = GUN_SLOWDOWN_RIFLE_LMG
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_FASTEST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTEST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = HMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm300
	)
	
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

/obj/item/gun/ballistic/babygun
	name = "CZ53 personal microgun"
	desc = "Boasting an extreme rate of fire, the Rockwell CZ53 personal minigun is the perfect weapon for suppressing fire, if this one wasn't converted into .22! Hehehehe..."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "minigunbal_spin"
	inhand_icon_state = "minigun"
	weapon_class = WEAPON_CLASS_RIFLE
	slowdown = GUN_SLOWDOWN_RIFLE_LMG
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_FASTEST
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_FASTEST
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	damage_multiplier = GUN_LESS_DAMAGE_T7
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = HMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100
	)
	
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	automatic = 1
	weapon_weight = GUN_TWO_HAND_ONLY
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/minigunbal5mm
	casing_ejector = TRUE
	item_flags = SLOWS_WHILE_IN_HAND

/obj/item/ammo_box/magazine/internal/minigunbal5mm
	name = "minigun ammo pack"
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)
	max_ammo = 60

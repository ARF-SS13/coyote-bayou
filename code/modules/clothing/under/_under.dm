/obj/item/clothing/under
	icon = 'icons/obj/clothing/uniforms.dmi'
	name = "under"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	permeability_coefficient = 0.9
	block_priority = BLOCK_PRIORITY_UNIFORM
	slot_flags = INV_SLOTBIT_ICLOTHING
	armor = ARMOR_VALUE_CLOTHES
	mutantrace_variation = STYLE_DIGITIGRADE|USE_TAUR_CLIP_MASK
	limb_integrity = 30
	var/fitted = FEMALE_UNIFORM_FULL // For use in alternate clothing styles for women
	var/has_sensor = HAS_SENSORS // For the crew computer
	var/random_sensor = TRUE
	var/sensor_mode = NO_SENSORS
	var/can_adjust = TRUE
	var/adjusted = NORMAL_STYLE
	var/alt_covers_chest = FALSE // for adjusted/rolled-down jumpsuits, FALSE = exposes chest and arms, TRUE = exposes arms only
	var/dummy_thick = FALSE // is able to hold accessories on its item
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/clothing/accessory/attached_accessory
	var/obj/item/clothing/accessory/attached_accessory_b
	var/obj/item/clothing/accessory/attached_accessory_c
	var/mutable_appearance/accessory_overlay
	var/mutable_appearance/accessory_overlay_b
	var/mutable_appearance/accessory_overlay_c

/obj/item/clothing/under/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(isinhands)
		return
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
	if(blood_DNA)
		. += mutable_appearance('icons/effects/blood.dmi', "uniformblood", color = blood_DNA_to_color())
	if(accessory_overlay)
		. += accessory_overlay
	if(accessory_overlay_b)
		. += accessory_overlay_b
	if(accessory_overlay_c)
		. += accessory_overlay_c

/obj/item/clothing/under/attackby(obj/item/I, mob/user, params)
	if((has_sensor == BROKEN_SENSORS) && istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = I
		I.use_tool(src, user, 0, 1)
		has_sensor = HAS_SENSORS
		to_chat(user,span_notice("You repair the suit sensors on [src] with [C]."))
		return TRUE
	if(!(flags_1 & HOLOGRAM_1) && ((I.tool_behaviour == TOOL_WIRECUTTER) || I.get_sharpness()))
		user.visible_message("[user] begins cutting the [src] apart.", \
				span_notice("You begin cutting the [src] into strips."), \
				span_italic("You hear faint sounds of ripping cloth."))
		playsound(get_turf(src), 'sound/items/poster_ripped.ogg', 50, TRUE)
		if(!do_after(user, 60, TRUE, src))
			return
		new /obj/item/stack/sheet/cloth (drop_location(), 2)
		to_chat(user, span_notice("You cut [src] into useful pieces of cloth."))
		qdel(src)
		return TRUE
	if(!attach_accessory(I, user))
		return ..()

/obj/item/clothing/under/update_clothes_damaged_state()
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_w_uniform()
	if(has_sensor > NO_SENSORS)
		has_sensor = BROKEN_SENSORS

/obj/item/clothing/under/New()
	if(random_sensor)
		//make the sensor mode favor higher levels, except coords. *Kelp here, making these default to off. Valid options: SENSOR_OFF SENSOR_LIVING SENSOR_VITALS SENSOR_COORDS
		sensor_mode = pick(SENSOR_OFF,SENSOR_OFF,SENSOR_OFF)
	..()

/obj/item/clothing/under/equipped(mob/user, slot)
	..()
	if(adjusted)
		adjusted = NORMAL_STYLE
		fitted = initial(fitted)
		if(!alt_covers_chest)
			body_parts_covered |= CHEST

	if(attached_accessory && slot != SLOT_HANDS && ishuman(user))
		var/mob/living/carbon/human/H = user
		attached_accessory.on_uniform_equip(src, user)
		if(attached_accessory.above_suit)
			H.update_inv_wear_suit()

	if(attached_accessory_b && slot != SLOT_HANDS && ishuman(user))
		var/mob/living/carbon/human/H = user
		attached_accessory_b.on_uniform_equip(src, user)
		if(attached_accessory_b.above_suit)
			H.update_inv_wear_suit()

	if(attached_accessory_c && slot != SLOT_HANDS && ishuman(user))
		var/mob/living/carbon/human/H = user
		attached_accessory_c.on_uniform_equip(src, user)
		if(attached_accessory_c.above_suit)
			H.update_inv_wear_suit()

/obj/item/clothing/under/dropped(mob/user)
	if(attached_accessory)
		attached_accessory.on_uniform_dropped(src, user)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(attached_accessory.above_suit)
				H.update_inv_wear_suit()

	if(attached_accessory_b)
		attached_accessory_b.on_uniform_dropped(src, user)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(attached_accessory_b.above_suit)
				H.update_inv_wear_suit()

	if(attached_accessory_c)
		attached_accessory_c.on_uniform_dropped(src, user)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(attached_accessory_c.above_suit)
				H.update_inv_wear_suit()

	..()

/obj/item/clothing/under/proc/attach_accessory(obj/item/I, mob/user, notifyAttach = 1)  //obj/item/clothing/under/U
	. = FALSE
	
	if(istype(I, /obj/item/clothing/accessory))
		var/obj/item/clothing/accessory/A = I
		if(attached_accessory && attached_accessory_b && attached_accessory_c)
			if(user)
				to_chat(user, span_warning("[src] already has too many accessories."))
			return
		if(dummy_thick)
			if(user)
				to_chat(user, span_warning("[src] is too bulky and cannot have accessories attached to it!"))
			return
		else
			if(user && !user.temporarilyRemoveItemFromInventory(I))
				return
			if(!A.attach(src, user))
				return

			if(user && notifyAttach)
				to_chat(user, span_notice("You attach [I] to [src]."))

			if((flags_inv & HIDEACCESSORY) || (A.flags_inv & HIDEACCESSORY))
				return TRUE

			if(attached_accessory && !attached_accessory_b && !attached_accessory_c)
				accessory_overlay = mutable_appearance('icons/mob/clothing/accessories.dmi', attached_accessory.icon_state)
				if(A.mob_overlay_icon) // Sunset Wasteland changes: should make modularized accessories work on-mob.
					accessory_overlay = mutable_appearance(A.mob_overlay_icon, attached_accessory.icon_state) // Ditto
				accessory_overlay.alpha = attached_accessory.alpha
				accessory_overlay.color = attached_accessory.color
			
			if(attached_accessory && attached_accessory_b && !attached_accessory_c)
				accessory_overlay_b = mutable_appearance('icons/mob/clothing/accessories.dmi', attached_accessory_b.icon_state)
				if(A.mob_overlay_icon)
					accessory_overlay_b = mutable_appearance(A.mob_overlay_icon, attached_accessory_b.icon_state)
				accessory_overlay_b.alpha = attached_accessory_b.alpha
				accessory_overlay_b.color = attached_accessory_b.color

			if(attached_accessory && attached_accessory_b && attached_accessory_c)
				accessory_overlay_c = mutable_appearance('icons/mob/clothing/accessories.dmi', attached_accessory_c.icon_state)
				if(A.mob_overlay_icon)
					accessory_overlay_c = mutable_appearance(A.mob_overlay_icon, attached_accessory_c.icon_state)
				accessory_overlay_c.alpha = attached_accessory_c.alpha
				accessory_overlay_c.color = attached_accessory_c.color


			if(ishuman(loc))
				var/mob/living/carbon/human/H = loc
				H.update_inv_w_uniform()
				H.update_inv_wear_suit()

			return TRUE

/obj/item/clothing/under/proc/remove_accessory(mob/user)
	if(!isliving(user))
		return
	if(!can_use(user))
		return

	if(attached_accessory && attached_accessory_b && attached_accessory_c)
		var/obj/item/clothing/accessory/A = attached_accessory_c
		attached_accessory_c.detach(src, user)
		if(user.put_in_hands(A))
			to_chat(user, span_notice("You detach [A] from [src]."))
		else
			to_chat(user, span_notice("You detach [A] from [src] and it falls on the floor."))

		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.update_inv_w_uniform()
			H.update_inv_wear_suit()

	else if(attached_accessory && attached_accessory_b)
		var/obj/item/clothing/accessory/A = attached_accessory_b
		attached_accessory_b.detach(src, user)
		if(user.put_in_hands(A))
			to_chat(user, span_notice("You detach [A] from [src]."))
		else
			to_chat(user, span_notice("You detach [A] from [src] and it falls on the floor."))

		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.update_inv_w_uniform()
			H.update_inv_wear_suit()

	else if(attached_accessory)
		var/obj/item/clothing/accessory/A = attached_accessory
		attached_accessory.detach(src, user)
		if(user.put_in_hands(A))
			to_chat(user, span_notice("You detach [A] from [src]."))
		else
			to_chat(user, span_notice("You detach [A] from [src] and it falls on the floor."))

		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.update_inv_w_uniform()
			H.update_inv_wear_suit()


/obj/item/clothing/under/examine(mob/user)
	. = ..()
	if(can_adjust)
		if(adjusted == ALT_STYLE)
			. += "Alt-click on [src] to wear it normally."
		else
			. += "Alt-click on [src] to wear it casually."
	if (has_sensor == BROKEN_SENSORS)
		. += "Its sensors appear to be shorted out."
	else if(has_sensor > NO_SENSORS)
		switch(sensor_mode)
			if(SENSOR_OFF)
				. += "Its sensors appear to be disabled."
			if(SENSOR_LIVING)
				. += "Its binary life sensors appear to be enabled."
			if(SENSOR_VITALS)
				. += "Its vital tracker appears to be enabled."
			if(SENSOR_COORDS)
				. += "Its vital tracker and tracking beacon appear to be enabled."
	if(attached_accessory)
		. += "\A [attached_accessory] is attached to it."
	if(attached_accessory_b)
		. += "\A [attached_accessory_b] is attached to it."
	if(attached_accessory_c)
		. += "\A [attached_accessory_c] is attached to it."

/obj/item/clothing/under/verb/toggle()
	set name = "Adjust Suit Sensors"
	set category = "Object"
	set src in usr
	var/mob/M = usr
	if (istype(M, /mob/dead/))
		return
	if (!can_use(M))
		return
	if(src.has_sensor == LOCKED_SENSORS)
		to_chat(usr, "The controls are locked.")
		return 0
	if(src.has_sensor == BROKEN_SENSORS)
		to_chat(usr, "The sensors have shorted out!")
		return 0
	if(src.has_sensor <= NO_SENSORS)
		to_chat(usr, "This suit does not have any sensors.")
		return 0

	var/list/modes = list("Off", "Binary vitals", "Exact vitals", "Tracking beacon")
	var/switchMode = input("Select a sensor mode:", "Suit Sensor Mode", modes[sensor_mode + 1]) in modes
	if(get_dist(usr, src) > 1)
		to_chat(usr, span_warning("You have moved too far away!"))
		return
	sensor_mode = modes.Find(switchMode) - 1

	if (src.loc == usr)
		switch(sensor_mode)
			if(0)
				to_chat(usr, span_notice("You disable your suit's remote sensing equipment."))
			if(1)
				to_chat(usr, span_notice("Your suit will now only report whether you are alive or dead."))
			if(2)
				to_chat(usr, span_notice("Your suit will now only report your exact vital lifesigns."))
			if(3)
				to_chat(usr, span_notice("Your suit will now report your exact vital lifesigns as well as your coordinate position."))

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.w_uniform == src)
			H.update_suit_sensors()


/obj/item/clothing/under/CtrlClick(mob/user)
	. = ..()

	if (!(item_flags & IN_INVENTORY))
		return

	if(!isliving(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return

	if(has_sensor == LOCKED_SENSORS)
		to_chat(user, "The controls are locked.")
		return
	if(has_sensor == BROKEN_SENSORS)
		to_chat(user, "The sensors have shorted out!")
		return
	if(has_sensor <= NO_SENSORS)
		to_chat(user, "This suit does not have any sensors.")
		return

	sensor_mode = SENSOR_COORDS

	to_chat(user, span_notice("Your suit will now report your exact vital lifesigns as well as your coordinate position."))

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.w_uniform == src)
			H.update_suit_sensors()

/obj/item/clothing/under/AltClick(mob/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(attached_accessory || attached_accessory_b || attached_accessory_c)
		remove_accessory(user)
	else
		rolldown()

/obj/item/clothing/under/verb/jumpsuit_adjust()
	set name = "Adjust Jumpsuit Style"
	set category = null
	set src in usr
	rolldown()

/obj/item/clothing/under/proc/rolldown()
	if(!can_use(usr))
		return
	if(!can_adjust)
		to_chat(usr, span_warning("You cannot wear this suit any differently!"))
		return
	if(toggle_jumpsuit_adjust())
		to_chat(usr, span_notice("You adjust the suit to wear it more casually."))
	else
		to_chat(usr, span_notice("You adjust the suit back to normal."))
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.update_inv_w_uniform()
		H.update_body()

/obj/item/clothing/under/proc/toggle_jumpsuit_adjust()
	adjusted = !adjusted

	if(adjusted)
		if(fitted != FEMALE_UNIFORM_TOP)
			fitted = NO_FEMALE_UNIFORM
		if(!alt_covers_chest) // for the special snowflake suits that expose the chest when adjusted
			body_parts_covered &= ~CHEST
			mutantrace_variation &= ~USE_TAUR_CLIP_MASK //How are we supposed to see the uniform otherwise?
	else
		fitted = initial(fitted)
		if(!alt_covers_chest)
			body_parts_covered |= CHEST
			if(initial(mutantrace_variation) & USE_TAUR_CLIP_MASK)
				mutantrace_variation |= USE_TAUR_CLIP_MASK

	return adjusted

/obj/item/clothing/under/rank
	dying_key = DYE_REGISTRY_UNDER

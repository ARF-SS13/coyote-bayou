/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	dynamic_hair_suffix = "+generic"
	var/datum/beepsky_fashion/beepsky_fashion //the associated datum for applying this to a secbot
	var/list/speechspan = null
	armor = list("tier" = 1)

/obj/item/clothing/head/Initialize()
	. = ..()
	if(ishuman(loc) && dynamic_hair_suffix)
		var/mob/living/carbon/human/H = loc
		H.update_hair()

/obj/item/clothing/head/get_head_speechspans(mob/living/carbon/user)
	if(speechspan)
		return speechspan
	else
		return



///Special throw_impact for hats to frisbee hats at people to place them on their heads.
/obj/item/clothing/head/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	. = ..()
	///if the thrown object's target zone isn't the head
	if(thrownthing.target_zone != BODY_ZONE_HEAD)
		return
	///ignore any hats with downsides when worn
	if(clothing_flags & IGNORE_HAT_TOSS)
		return
	///if the hat happens to be capable of holding contents and has something in it. mostly to prevent super cheesy stuff like stuffing a mini-bomb in a hat and throwing it
	if(LAZYLEN(contents))
		return
	if(iscarbon(hit_atom))
		var/mob/living/carbon/H = hit_atom
		if(istype(H.head, /obj/item))
			var/obj/item/WH = H.head
			H.visible_message("<span class='warning'>[src] bounces off [H]'s [WH.name]!", "<span class='warning'>[src] bounces off your [WH.name], falling to the floor.</span>")
			return
		if(H.equip_to_slot_if_possible(src, SLOT_HEAD, FALSE, TRUE))
			H.visible_message("<span class='notice'>[src] lands neatly on [H]'s head!", "<span class='notice'>[src] lands perfectly onto your head!</span>")
		return
	if(iscyborg(hit_atom))
		var/mob/living/silicon/robot/R = hit_atom
		///hats in the borg's blacklist bounce off
		if(!is_type_in_typecache(src, R.equippable_hats) || R.hat_offset == INFINITY)
			R.visible_message("<span class='warning'>[src] bounces off [R]!", "<span class='warning'>[src] bounces off you, falling to the floor.</span>")
			return
		else
			R.visible_message("<span class='notice'>[src] lands neatly on top of [R].", "<span class='notice'>[src] lands perfectly on top of you.</span>")
			R.place_on_head(src) //hats aren't designed to snugly fit borg heads or w/e so they'll always manage to knock eachother off



/obj/item/clothing/head/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damagedhelmet")
		if(blood_DNA)
			. += mutable_appearance('icons/effects/blood.dmi', "helmetblood", color = blood_DNA_to_color())

/obj/item/clothing/head/update_clothes_damaged_state()
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_head()
/*
//Hat accessories

/obj/item/clothing/head/attackby(obj/item/I, mob/user, params)
	if(!attach_accessory(I, user))
		return ..()

/obj/item/clothing/head/equipped(mob/user, slot)
	..()

	if(attached_accessory && slot != SLOT_HANDS && ishuman(user))
		var/mob/living/carbon/human/H = user
		attached_accessory.on_head_equip(src, user)
		H.update_inv_head()

/obj/item/clothing/head/dropped(mob/user)
	if(attached_accessory)
		attached_accessory.on_head_dropped(src, user)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.update_inv_head()

	..()

/obj/item/clothing/head/proc/attach_accessory(obj/item/I, mob/user, notifyAttach = 1)
	. = FALSE
	if(istype(I, /obj/item/clothing/armoraccessory))
		var/obj/item/clothing/armoraccessory/A = I
		if(attached_accessory)
			if(user)
				to_chat(user, "<span class='warning'>[src] already has an accessory.</span>")
			return
		if(dummy_thick)
			if(user)
				to_chat(user, "<span class='warning'>[src] is too bulky and cannot have accessories attached to it!</span>")
			return

		else
			if(user && !user.temporarilyRemoveItemFromInventory(I))
				return
			if(!A.attach(src, user))
				return

			if(user && notifyAttach)
				to_chat(user, "<span class='notice'>You attach [I] to [src].</span>")

			if((flags_inv & HIDEACCESSORY) || (A.flags_inv & HIDEACCESSORY))
				return TRUE

			accessory_overlay = mutable_appearance('icons/mob/clothing/accessories.dmi', attached_accessory.icon_state)
			accessory_overlay.alpha = attached_accessory.alpha
			accessory_overlay.color = attached_accessory.color

			if(ishuman(loc))
				var/mob/living/carbon/human/H = loc
				H.update_inv_w_uniform()
				H.update_inv_head()

			return TRUE

/obj/item/clothing/head/proc/remove_accessory(mob/user)
	if(!isliving(user))
		return
	if(!can_use(user))
		return

	if(attached_accessory)
		var/obj/item/clothing/armoraccessory/A = attached_accessory
		attached_accessory.detach(src, user)
		if(user.put_in_hands(A))
			to_chat(user, "<span class='notice'>You detach [A] from [src].</span>")
		else
			to_chat(user, "<span class='notice'>You detach [A] from [src] and it falls on the floor.</span>")

		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.update_inv_w_uniform()
			H.update_inv_head()

/obj/item/clothing/head/examine(mob/user)
	. = ..()
	if(attached_accessory)
		. += "\A [attached_accessory] is attached to it."


/obj/item/clothing/head/AltClick(mob/user)
	. = ..()
	if(attached_accessory)
		remove_accessory(user)
*/

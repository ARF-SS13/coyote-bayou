/datum/outfit
	var/name = "Naked"

	var/uniform = null
	var/suit = null
	var/toggle_helmet = TRUE
	var/back = null
	var/belt = null
	var/gloves = null
	var/shoes = null
	var/head = null
	var/mask = null
	var/neck = null
	var/ears = null
	var/glasses = null
	var/id = null
	var/l_pocket = null
	var/r_pocket = null
	var/suit_store = null
	var/r_hand = null
	var/l_hand = null
	var/internals_slot = null //ID of slot containing a gas tank
	var/list/backpack_contents = null // In the list(path=count,otherpath=count) format
	var/box // Internals box. Will be inserted at the start of backpack_contents
	var/list/implants = null
	var/accessory = null
	var/can_be_admin_equipped = TRUE // Set to FALSE if your outfit requires runtime parameters
	var/list/chameleon_extras //extra types for chameleon outfit changes, mostly guns


/datum/outfit/proc/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	//to be overridden for customization depending on client prefs,species etc
	return

/datum/outfit/proc/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	//to be overridden for toggling internals, id binding, access etc
	return

/datum/outfit/proc/equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	pre_equip(H, visualsOnly, preference_source)

	//Start with uniform,suit,backpack for additional slots

	if(uniform && !H.w_uniform)
		if(length(uniform)) // This would mean it's a list, and thus we must pick.
			uniform = pick(uniform)
		H.equip_to_slot_or_del(new uniform(H), SLOT_W_UNIFORM)
	if(suit && !H.wear_suit)
		if(length(suit))
			suit = pick(suit)
		H.equip_to_slot_or_del(new suit(H), SLOT_WEAR_SUIT)
	if(back && !H.back)
		if(length(back))
			back = pick(back)
		H.equip_to_slot_or_del(new back(H), SLOT_BACK)
	if(belt && !H.belt)
		if(length(belt))
			belt = pick(belt)
		H.equip_to_slot_or_del(new belt(H), SLOT_BELT)
	if(gloves && !H.gloves)
		if(length(gloves))
			gloves = pick(gloves)
		H.equip_to_slot_or_del(new gloves(H), SLOT_GLOVES)
	if(shoes && !H.shoes)
		if(length(shoes))
			shoes = pick(shoes)
		H.equip_to_slot_or_del(new shoes(H), SLOT_SHOES)
	if(head && !H.head)
		if(length(head))
			head = pick(head)
		H.equip_to_slot_or_del(new head(H), SLOT_HEAD)
	if(mask && !H.wear_mask)
		if(length(mask))
			mask = pick(mask)
		H.equip_to_slot_or_del(new mask(H), SLOT_WEAR_MASK)
	if(neck && !H.wear_neck)
		if(length(neck))
			neck = pick(neck)
		H.equip_to_slot_or_del(new neck(H), SLOT_NECK)
	if(ears && !H.ears)
		if(length(ears))
			ears = pick(ears)
		H.equip_to_slot_or_del(new ears(H), SLOT_EARS)
	if(glasses && !H.glasses)
		if(length(glasses))
			glasses = pick(glasses)
		H.equip_to_slot_or_del(new glasses(H), SLOT_GLASSES)
	if(id && !H.wear_id)
		if(length(id))
			id = pick(id)
		H.equip_to_slot_or_del(new id(H), SLOT_WEAR_ID)
	if(suit_store && !H.s_store)
		if(length(suit_store))
			suit_store = pick(suit_store)
		H.equip_to_slot_or_del(new suit_store(H), SLOT_S_STORE)

	if(accessory)
		if(length(accessory))
			accessory = pick(accessory)
		var/obj/item/clothing/under/worn_uniform = H.w_uniform
		if(worn_uniform)
			if(!worn_uniform.attached_accessory)
				worn_uniform.attach_accessory(new accessory(H))
		else
			WARNING("Unable to equip accessory [accessory] in outfit [name]. No uniform present!")

	if(l_hand && !H.get_item_for_held_index(1))
		if(length(l_hand))
			l_hand = pick(l_hand)
		H.put_in_l_hand(new l_hand(H))
	if(r_hand && !H.get_item_for_held_index(2))
		if(length(r_hand))
			r_hand = pick(r_hand)
		H.put_in_r_hand(new r_hand(H))

	if(!visualsOnly) // Items in pockets or backpack don't show up on mob's icon.
		if(l_pocket && !H.l_store)
			if(length(l_pocket))
				l_pocket = pick(l_pocket)
			H.equip_to_slot_or_del(new l_pocket(H),SLOT_L_STORE)
		if(r_pocket && !H.r_store)
			if(length(r_pocket))
				r_pocket = pick(r_pocket)
			H.equip_to_slot_or_del(new r_pocket(H),SLOT_R_STORE)

		if(box)
			if(!backpack_contents)
				backpack_contents = list()
			backpack_contents.Insert(1, box)
			backpack_contents[box] = 1

		for(var/path in backpack_contents)
			var/number = backpack_contents[path]
			if(!isnum(number)) //Default to 1
				number = 1
			for(var/i in 1 to number)
				H.equip_to_slot_or_del(new path(H), SLOT_IN_BACKPACK)

	if(!H.head && toggle_helmet && istype(H.wear_suit, /obj/item/clothing/suit/space/hardsuit))
		var/obj/item/clothing/suit/space/hardsuit/HS = H.wear_suit
		HS.ToggleHelmet()

	post_equip(H, visualsOnly, preference_source)

	if(!visualsOnly)
		apply_fingerprints(H)
		if(internals_slot && !H.internal)
			if(length(internals_slot))
				internals_slot = pick(internals_slot)
			H.internal = H.get_item_by_slot(internals_slot)
			H.update_action_buttons_icon()
		if(implants)
			for(var/implant_type in implants)
				var/obj/item/implant/I = new implant_type
				I.implant(H, null, TRUE)

	H.update_body()
	return TRUE


/datum/outfit/proc/apply_fingerprints(mob/living/carbon/human/H)
	if(!istype(H))
		return
	if(H.back)
		H.back.add_fingerprint(H,1)	//The 1 sets a flag to ignore gloves
		for(var/obj/item/I in H.back.contents)
			I.add_fingerprint(H,1)
	if(H.wear_id)
		H.wear_id.add_fingerprint(H,1)
	if(H.w_uniform)
		H.w_uniform.add_fingerprint(H,1)
	if(H.wear_suit)
		H.wear_suit.add_fingerprint(H,1)
	if(H.wear_mask)
		H.wear_mask.add_fingerprint(H,1)
	if(H.wear_neck)
		H.wear_neck.add_fingerprint(H,1)
	if(H.head)
		H.head.add_fingerprint(H,1)
	if(H.shoes)
		H.shoes.add_fingerprint(H,1)
	if(H.gloves)
		H.gloves.add_fingerprint(H,1)
	if(H.ears)
		H.ears.add_fingerprint(H,1)
	if(H.glasses)
		H.glasses.add_fingerprint(H,1)
	if(H.belt)
		H.belt.add_fingerprint(H,1)
		for(var/obj/item/I in H.belt.contents)
			I.add_fingerprint(H,1)
	if(H.s_store)
		H.s_store.add_fingerprint(H,1)
	if(H.l_store)
		H.l_store.add_fingerprint(H,1)
	if(H.r_store)
		H.r_store.add_fingerprint(H,1)
	for(var/obj/item/I in H.held_items)
		I.add_fingerprint(H,1)
	return 1

/datum/outfit/proc/get_chameleon_disguise_info()
	var/list/types = list(uniform, suit, back, belt, gloves, shoes, head, mask, neck, ears, glasses, id, l_pocket, r_pocket, suit_store, r_hand, l_hand)
	types += chameleon_extras
	listclearnulls(types)
	return types

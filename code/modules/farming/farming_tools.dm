// In this document: Buckets, Spade, Cultivator, Rake, Hatchet, Wicker basket, Newbie farmer guide

/////////////////////
// FALLOUT BUCKETS //
/////////////////////

/obj/item/reagent_containers/glass/bucket
	name = "bucket"
	desc = "It's a bucket."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "bucket"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	custom_materials = list(/datum/material/iron=200)
	w_class = WEIGHT_CLASS_NORMAL
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(10,20,30,50,120)
	volume = 120
	flags_inv = HIDEHAIR
	slot_flags = INV_SLOTBIT_HEAD
	resistance_flags = NONE
	slot_equipment_priority = list( \
		SLOT_BACK, SLOT_WEAR_ID,\
		SLOT_W_UNIFORM, SLOT_WEAR_SUIT,\
		SLOT_MASK, SLOT_HEAD, SLOT_NECK,\
		SLOT_SHOES, SLOT_GLOVES,\
		SLOT_EARS, SLOT_GLASSES,\
		SLOT_BELT, SLOT_S_STORE,\
		SLOT_L_STORE, SLOT_R_STORE,\
		SLOT_GENERIC_DEXTROUS_STORAGE
	)
	container_flags = APTFT_ALTCLICK|APTFT_VERB
	container_HP = 1

/obj/item/reagent_containers/glass/bucket/attackby(obj/O, mob/user, params)
	if(istype(O, /obj/item/mop))
		if(reagents.total_volume < 1)
			to_chat(user, span_warning("[src] is out of water!"))
		else
			reagents.trans_to(O, 5, log = "reagentcontainer-bucket fill mop")
			to_chat(user, span_notice("You wet [O] in [src]."))
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
	else if(isprox(O))
		to_chat(user, span_notice("You add [O] to [src]."))
		qdel(O)
		qdel(src)
		user.put_in_hands(new /obj/item/bot_assembly/cleanbot)
	else
		..()

/obj/item/reagent_containers/glass/bucket/equipped(mob/user, slot)
	..()
	if (slot == SLOT_HEAD)
		if(reagents.total_volume)
			to_chat(user, span_userdanger("[src]'s contents spill all over you!"))
			var/R = reagents.log_list()
			log_reagent("SPLASH: [user] splashed [src] on their head via bucket/equipped(self, SLOT_HEAD) - [R]")
			reagents.reaction(user, TOUCH)
			reagents.clear_reagents()
		reagent_flags = NONE

/obj/item/reagent_containers/glass/bucket/dropped(mob/user)
	. = ..()
	reagent_flags = initial(reagent_flags)

/obj/item/reagent_containers/glass/bucket/equip_to_best_slot(mob/M)
	if(reagents.total_volume) //If there is water in a bucket, don't quick equip it to the head
		var/index = slot_equipment_priority.Find(SLOT_HEAD)
		slot_equipment_priority.Remove(SLOT_HEAD)
		. = ..()
		slot_equipment_priority.Insert(index, SLOT_HEAD)
		return
	return ..()

/obj/item/reagent_containers/glass/bucket/Initialize()
	. = ..()
	update_icon()

/obj/item/reagent_containers/glass/bucket/get_part_rating()
	return reagents.maximum_volume

/obj/item/reagent_containers/glass/bucket/on_reagent_change(changetype)
	update_icon()

/obj/item/reagent_containers/glass/bucket/update_overlays()
	. = ..()
	if(!cached_icon)
		cached_icon = icon_state

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[cached_icon]10", color = mix_color_from_reagents(reagents.reagent_list))

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 19)
				filling.icon_state = "[cached_icon]"
			if(20 to 50)
				filling.icon_state = "[cached_icon]20"
			if(51 to 99)
				filling.icon_state = "[cached_icon]50"
			if(100 to INFINITY)
				filling.icon_state = "[cached_icon]100"
		. += filling

/obj/item/reagent_containers/glass/bucket/wood
	name = "wooden bucket"
	desc = "It's a bucket made of wood."
	icon_state = "bucket_wooden"
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 2)
	item_flags = NO_MAT_REDEMPTION

/obj/item/reagent_containers/glass/bucket/plastic
	name = "plastic bucket"
	desc = "It's a bucket made of blue plastic."
	icon_state = "bucket_plastic"
	custom_materials = list(/datum/material/plastic = MINERAL_MATERIAL_AMOUNT * 1)
	item_flags = NO_MAT_REDEMPTION
	possible_transfer_amounts = list(10,25,50,100,150)
	volume = 150

/obj/item/reagent_containers/glass/bucket/wateringcan
	name = "Watering Can"
	desc = "It's a watering can, made of plastic."
	icon_state = "watering_can"
	item_flags = NO_MAT_REDEMPTION
	possible_transfer_amounts = list(10,25,50,100,150, 200, 250,300)
	volume = 300

///////////
// SPADE //
/////////// - slower shovel, but can remove plants without removing the soil too

/obj/item/shovel/spade
	name = "spade"
	desc = "A small tool for digging and removing plant roots."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "spade"
	inhand_icon_state = "spade"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	toolspeed = 0.5
	force = 5
	throwforce = 7
	custom_materials = list(/datum/material/iron=50)
	w_class = WEIGHT_CLASS_SMALL


////////////////
// CULTIVATOR //
////////////////

/obj/item/cultivator
	name = "cultivator"
	desc = "It's used for removing weeds, stepping on it might hurt."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "cultivator"
	inhand_icon_state = "cultivator"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	resistance_flags = FLAMMABLE
	flags_1 = CONDUCT_1
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	attack_verb = list("slashed", "sliced", "cut", "clawed")
	hitsound = 'sound/weapons/bladeslice.ogg'

// ------
// RAKE
// ------

/obj/item/cultivator/rake
	name = "rake"
	icon_state = "rake"
	inhand_icon_state = "rake"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	flags_1 = null
	force = 8
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = null


/////////////
// HATCHET //
/////////////

// Hatchet
/obj/item/hatchet
	name = "hatchet"
	desc = "Simple small metal axehead on a handle made from wood or some other hard material."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "hatchet"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	attack_speed = CLICK_CD_MELEE
	flags_1 = CONDUCT_1
	force = 24
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT
	throwforce = 15
	throw_speed = 3
	throw_range = 4
	custom_materials = list(/datum/material/iron = 6000)
	attack_verb = list("chopped", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/hatchet/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 70, 100)

///////////////////
// WICKER BASKET //
///////////////////

//Wicker Basket (Crate)
/obj/structure/closet/crate/wicker
	name = "basket"
	desc = "A handmade wicker basket."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "basket"
	resistance_flags = FLAMMABLE
	material_drop = /obj/item/stack/sheet/hay
	material_drop_amount = 15



// ------------------------------------
// Scythe - lacks a real purpose in FO
// ------------------------------------

/obj/item/scythe
	name = "scythe"
	desc = "A sharp and curved blade on a long wooden handle, this tool makes it easy to reap what you sow."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "scythe"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	force = 15
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	attack_speed = CLICK_CD_MELEE
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BACK
	attack_verb = list("chopped", "sliced", "cut", "reaped")
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/swiping = FALSE

/obj/item/scythe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 90, 105)

/obj/item/scythe/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = ..()
	if(. & STOP_ATTACK_PROC_CHAIN)
		return
	if(swiping || !istype(A, /obj/structure/spacevine) || get_turf(A) == get_turf(user))
		return
	else
		var/turf/user_turf = get_turf(user)
		var/dir_to_target = get_dir(user_turf, get_turf(A))
		var/stam_gain = 0
		swiping = TRUE
		var/static/list/scythe_slash_angles = list(0, 45, 90, -45, -90)
		for(var/i in scythe_slash_angles)
			var/turf/T = get_step(user_turf, turn(dir_to_target, i))
			for(var/obj/structure/spacevine/V in T)
				if(user.Adjacent(V))
					melee_attack_chain(user, V, attackchain_flags = ATTACK_IGNORE_CLICKDELAY)
					stam_gain += 5					//should be hitcost
		swiping = FALSE
		stam_gain += 2								//Initial hitcost
		user.adjustStaminaLoss(-stam_gain)
		user.DelayNextAction()

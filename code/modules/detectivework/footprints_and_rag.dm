//mob
//	var/bloody_hands = 0

//obj/item/clothing/gloves
//	var/transfer_blood = 0

/obj/item/reagent_containers/glass/rag
	name = "damp rag"
	desc = "For cleaning up messes, you suppose."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	item_flags = NOBLUDGEON
//	container_type = OPENCONTAINER
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 5
	spillable = FALSE
	var/wipe_sound
	var/soak_efficiency = 1
	var/extinguish_efficiency = 0
	var/action_speed = 3 SECONDS
	var/damp_threshold = 0.5

/obj/item/reagent_containers/glass/rag/afterattack(atom/A as obj|turf|area, mob/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(iscarbon(A) && A.reagents && reagents.total_volume)
		var/mob/living/carbon/C = A
		var/reagentlist = pretty_string_from_reagent_list(reagents)
		if(user.a_intent == INTENT_HARM && !C.is_mouth_covered())
			reagents.reaction(C, INGEST)
			reagents.trans_to(C, reagents.total_volume)
			C.visible_message(span_danger("[user] has smothered \the [C] with \the [src]!"), span_userdanger("[user] has smothered you with \the [src]!"), span_italic("You hear some struggling and muffled cries of surprise."))
			log_game("[key_name(user)] smothered [key_name(A)] with a damp rag containing [reagentlist]")
			log_attack("[key_name(user)] smothered [key_name(A)] with a damp rag containing [reagentlist]")
		else
			reagents.reaction(C, TOUCH)
			reagents.clear_reagents()
			log_game("[key_name(user)] touched [key_name(A)] with a damp rag containing [reagentlist]")
			log_attack("[key_name(user)] touched [key_name(A)] with a damp rag containing [reagentlist]")
			C.visible_message(span_notice("[user] has touched \the [C] with \the [src]."))

	else if(istype(A) && (src in user))
		user.visible_message("[user] starts to wipe down [A] with [src]!", span_notice("You start to wipe down [A] with [src]..."))
		if(do_after(user,30, target = A))
			user.visible_message("[user] finishes wiping off [A]!", span_notice("You finish wiping off [A]."))
			SEND_SIGNAL(A, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_MEDIUM)
	return

/obj/item/reagent_containers/glass/rag/towel
	name = "towel"
	desc = "A soft cotton towel."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "towel"
	inhand_icon_state = "towel"
	slot_flags = INV_SLOTBIT_HEAD | INV_SLOTBIT_BELT | INV_SLOTBIT_OCLOTHING
	item_flags = NOBLUDGEON | NO_UNIFORM_REQUIRED //so it can be worn on the belt slot even with no uniform.
	force = 1
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("whipped")
	hitsound = 'sound/items/towelwhip.ogg'
	volume = 10
	wipe_sound = 'sound/items/towelwipe.ogg'
	soak_efficiency = 4
	extinguish_efficiency = 3
	var/flat_icon = "towel_flat"
	var/folded_icon = "towel"
	var/list/possible_colors

/obj/item/reagent_containers/glass/rag/towel/Initialize()
	. = ..()
	if(possible_colors)
		add_atom_colour(pick(possible_colors), FIXED_COLOUR_PRIORITY)

/obj/item/reagent_containers/glass/rag/towel/attack(mob/living/M, mob/living/user)
	if(user.a_intent == INTENT_HARM)
		DISABLE_BITFIELD(item_flags, NOBLUDGEON)
		. = TRUE
	..()
	if(.)
		ENABLE_BITFIELD(item_flags, NOBLUDGEON)

/obj/item/reagent_containers/glass/rag/towel/equipped(mob/living/user, slot)
	. = ..()
	switch(slot)
		if(SLOT_BELT)
			body_parts_covered = GROIN|LEGS
		if(SLOT_WEAR_SUIT)
			body_parts_covered = CHEST|GROIN|LEGS
		if(SLOT_HEAD)
			body_parts_covered = HEAD
			flags_inv = HIDEHAIR

/obj/item/reagent_containers/glass/rag/towel/dropped(mob/user)
	. = ..()
	body_parts_covered = NONE
	flags_inv = NONE

/obj/item/reagent_containers/glass/rag/towel/attack_self(mob/user)
	if(!user.can_reach(src) || !user.dropItemToGround(src))
		return
	to_chat(user, span_notice("You lay out \the [src] flat on the ground."))
	icon_state = flat_icon
	layer = BELOW_OBJ_LAYER

/obj/item/reagent_containers/glass/rag/towel/pickup(mob/living/user)
	. = ..()
	icon_state = folded_icon
	layer = initial(layer)

/obj/item/reagent_containers/glass/rag/towel/on_reagent_change(changetype)
	force = initial(force) + round(reagents.total_volume * 0.5)

/obj/item/reagent_containers/glass/rag/towel/random
	possible_colors = list("#FF0000","#FF7F00","#FFFF00","#00FF00","#0000FF","#4B0082","#8F00FF")

/obj/item/reagent_containers/glass/rag/towel/syndicate
	name = "syndicate towel"
	desc = "Truly a weapon of mass destruction."
	possible_colors = list("#DD1A1A", "#DB4325", "#E02700")
	force = 4
	volume = 20
	soak_efficiency = 6
	extinguish_efficiency = 5
	action_speed = 15
	damp_threshold = 0.8
	armor = ARMOR_VALUE_CLOTHES

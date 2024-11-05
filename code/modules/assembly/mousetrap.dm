/obj/item/assembly/mousetrap
	name = "mousetrap"
	desc = "A handy little spring-loaded trap for catching pesty rodents."
	icon_state = "mousetrap"
	inhand_icon_state = "mousetrap"
	custom_materials = list(/datum/material/iron=100)
	attachable = TRUE
	var/armed = FALSE

/obj/item/assembly/mousetrap/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED =PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)



/obj/item/assembly/mousetrap/examine(mob/user)
	. = ..()
	. += span_notice("The pressure plate is [armed?"primed":"safe"].")

/obj/item/assembly/mousetrap/activate()
	if(..())
		armed = !armed
		if(!armed)
			if(ishuman(usr))
				var/mob/living/carbon/human/user = usr
				if((HAS_TRAIT(user, TRAIT_DUMB) || HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
					to_chat(user, span_warning("Your hand slips, setting off the trigger!"))
					pulse(FALSE)
		update_icon()
		playsound(src, 'sound/weapons/handcuffs.ogg', 30, TRUE, -3)

/obj/item/assembly/mousetrap/update_icon()
	if(armed)
		icon_state = "mousetraparmed"
	else
		icon_state = "mousetrap"
	if(holder)
		holder.update_icon()

/obj/item/assembly/mousetrap/proc/triggered(mob/target, type = "feet")
	if(!armed)
		return
	var/obj/item/bodypart/affecting = null
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(HAS_TRAIT(H, TRAIT_PIERCEIMMUNE))
			playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
			armed = FALSE
			update_icon()
			pulse(FALSE)
			return FALSE
		switch(type)
			if("feet")
				if(!H.shoes || !(H.shoes.body_parts_covered & FEET))
					affecting = H.get_bodypart(pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
					H.DefaultCombatKnockdown(60)
			if(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND)
				if(!H.gloves)
					affecting = H.get_bodypart(type)
					H.Stun(60)
		if(affecting)
			if(affecting.receive_damage(1, 0))
				H.update_damage_overlays()
	else if(ismouse(target))
		var/mob/living/simple_animal/mouse/M = target
		visible_message(span_boldannounce("SPLAT!"))
		M.splat()
	playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
	armed = FALSE
	update_icon()
	pulse(FALSE)


/obj/item/assembly/mousetrap/attack_self(mob/living/carbon/human/user)
	if(!armed)
		to_chat(user, span_notice("You arm [src]."))
	else
		if((HAS_TRAIT(user, TRAIT_DUMB) || HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
			var/which_hand = BODY_ZONE_PRECISE_L_HAND
			if(!(user.active_hand_index % 2))
				which_hand = BODY_ZONE_PRECISE_R_HAND
			triggered(user, which_hand)
			user.visible_message(span_warning("[user] accidentally sets off [src], breaking their fingers."), \
								span_warning("You accidentally trigger [src]!"))
			return
		to_chat(user, span_notice("You disarm [src]."))
	armed = !armed
	update_icon()
	playsound(src, 'sound/weapons/handcuffs.ogg', 30, TRUE, -3)


/obj/item/assembly/mousetrap/on_attack_hand(mob/living/carbon/human/user)
	if(armed)
		if((HAS_TRAIT(user, TRAIT_DUMB) || HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
			var/which_hand = BODY_ZONE_PRECISE_L_HAND
			if(!(user.active_hand_index % 2))
				which_hand = BODY_ZONE_PRECISE_R_HAND
			triggered(user, which_hand)
			user.visible_message(span_warning("[user] accidentally sets off [src], breaking their fingers."), \
								span_warning("You accidentally trigger [src]!"))
			return
	return ..()

/obj/item/assembly/mousetrap/proc/handle_entered(atom/movable/AM as mob|obj)
	if(armed)
		if(ismob(AM))
			var/mob/MM = AM
			if(!(MM.movement_type & FLYING))
				if(ishuman(AM))
					var/mob/living/carbon/H = AM
					if(H.m_intent == MOVE_INTENT_RUN)
						triggered(H)
						H.visible_message(span_warning("[H] accidentally steps on [src]."), \
										  span_warning("You accidentally step on [src]"))
				else if(ismouse(MM))
					triggered(MM)
		else if(AM.density) // For mousetrap grenades, set off by anything heavy
			triggered(AM)

/obj/item/assembly/mousetrap/proc/on_entered(atom/movable/AM as mob|obj)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src,PROC_REF(handle_entered), AM)


/obj/item/assembly/mousetrap/on_found(mob/finder)
	if(armed)
		if(finder)
			finder.visible_message(span_warning("[finder] accidentally sets off [src], breaking their fingers."), \
							   span_warning("You accidentally trigger [src]!"))
			triggered(finder, (finder.active_hand_index % 2 == 0) ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND)
			return TRUE	//end the search!
		else
			visible_message(span_warning("[src] snaps shut!"))
			triggered(loc)
			return FALSE
	return FALSE


/obj/item/assembly/mousetrap/hitby(atom/hit_atom, skipcatch = FALSE, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	if(!armed)
		return ..()
	visible_message(span_warning("[src] is triggered by [hit_atom]."))
	triggered(null)


/obj/item/assembly/mousetrap/armed
	icon_state = "mousetraparmed"
	armed = TRUE

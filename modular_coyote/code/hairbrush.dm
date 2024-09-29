// Hairbrushes

/obj/item/hairbrush
	name = "hairbrush"
	desc = "A small, circular brush with an ergonomic grip for efficient brush application."
	icon = 'modular_coyote/icons/objects/hairbrush/hairbrush.dmi'
	icon_state = "brush"
	item_state = "inhand"
	lefthand_file = 'modular_coyote/icons/objects/hairbrush/inhand_left.dmi'
	righthand_file = 'modular_coyote/icons/objects/hairbrush/inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/brush_speed = 3 SECONDS
	var/am_brushing = FALSE
	var/datum/looping_sound/hairbrush/fwhuush
	var/last_brushed
	var/vis_dist = 3
	var/last_act = 0


/obj/item/hairbrush/Initialize()
	. = ..()
	fwhuush = new(list(src), FALSE)

/obj/item/hairbrush/Destroy()
	QDEL_NULL(fwhuush)
	. = ..()

/obj/item/hairbrush/attack(mob/target, mob/user)
	. = COMPONENT_ITEM_NO_ATTACK
	if(am_brushing)
		if(last_brushed + (brush_speed * 1.5) < world.time)
			am_brushing = FALSE
			abort()
			abort()
			abort() // STOP PLAYING FFS
		else
			to_chat(user, span_alert("You're already brushing!"))
			return
	brush(target, user)

/obj/item/hairbrush/proc/abort(mob/target, mob/user)
	am_brushing = FALSE
	if(target && user)
		to_chat(user, span_notice("You stop brushing."))
		to_chat(target, ("[user] stops brushing."))
	fwhuush.stop()
	last_brushed = null

/// Brushes someone, giving them a small mood boost
/obj/item/hairbrush/proc/brush(mob/living/target, mob/user, silent)
	if(!ishuman(target))
		return abort()
	var/mob/living/carbon/human/human_target = target
	var/brush_where = user.zone_selected
	var/brush_what = "hair"
	var/through = "through"
	switch(brush_where)
		if(BODY_ZONE_HEAD)
			var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)
			if(!head)
				to_chat(user, span_warning("[human_target] has no head!"))
				return abort()
			if(human_target.hair_style == "Bald" || human_target.hair_style == "Skinhead" && is_species(human_target, /datum/species/human)) //It can be assumed most anthros have hair on them!
				brush_what = "scalp"
			else
				brush_what = "hair"
		if(BODY_ZONE_PRECISE_EYES)
			var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)
			if(!head)
				to_chat(user, span_warning("[human_target] has no head!"))
				return abort()
			brush_what = "ears"
			through = "along"
		if(BODY_ZONE_PRECISE_MOUTH)
			var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)
			if(!head)
				to_chat(user, span_warning("[human_target] has no head!"))
				return abort()
			if(human_target.dna.features["snout"])
				brush_what = pick("muzzle", "snout", "cheeks")
			else
				brush_what = "cheeks"
				through = "across"
		if(BODY_ZONE_PRECISE_GROIN)
			through = "across"
			if(user.a_intent == INTENT_HARM)
				smack_em_on_the_butt(user, human_target)
				return abort()
			else if(user.a_intent == INTENT_GRAB)
				brush_what = "crotch"
			else if(user.a_intent == INTENT_DISARM)
				brush_what = "belly"
			else if(human_target.dna.features["tail_lizard"] \
				|| human_target.dna.features["tail_mam"] \
				|| human_target.dna.features["tails_list_human"]) // FUCK YOU POOJ WHY DO WE HAVE THREE FUCKIN TAILS THATA ARE THE EXACT SAME FUCKING THING AFUIUCK YOU FUCK YOU  (🐾 teehee)
				brush_what = pick("tail")
				through = "along"
			else
			 brush_what = "tummy"
		if(BODY_ZONE_CHEST)
			through = "down"
			var/obj/item/organ/genital/b00bz = human_target.getorganslot(ORGAN_SLOT_BREASTS)
			if(b00bz && b00bz.is_exposed() && wielded)
				switch(user.a_intent)
					if(INTENT_HELP)
						brush_what = "breasts, softly"
					if(INTENT_DISARM)
						brush_what = "breasts, sensually"
					if(INTENT_GRAB)
						brush_what = "breasts, firmly"
					if(INTENT_HARM)
						brush_what = "breasts, vigorously"
			else
				if(wielded)
					brush_what = "back"
				else
					brush_what = "chest"
		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			through = "along"
			switch(user.a_intent)
				if(INTENT_HELP)
					brush_what = "arm"
				if(INTENT_DISARM)
					brush_what = "wrist"
				if(INTENT_GRAB)
					brush_what = "shoulder"
				if(INTENT_HARM)
					brush_what = prob(1) ? "weenis" : "hand"
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			through = "along"
			switch(user.a_intent)
				if(INTENT_HELP)
					brush_what = "hip"
				if(INTENT_DISARM)
					brush_what = "thigh"
				if(INTENT_GRAB)
					brush_what = "knee"
				if(INTENT_HARM)
					brush_what = prob(50) ? "foot" : "ankle"
	am_brushing = TRUE
	fwhuush.start()
	if(last_brushed != brush_what)
		if(user == human_target)
			user.visible_message(
				span_notice("[user] starts to run [src] [through] [user.p_their()] [brush_what]..."),
				span_notice("You start running [src] [through] your [brush_what]..."),
				span_notice("[user] starts to run [src] [through] [user.p_their()] [brush_what]..."),
				vis_dist,
			)
		else
			user.visible_message(
				span_notice("[user] starts to run [src] [through] [human_target]'s [brush_what]..."),
				span_notice("You start running [src] [through] [human_target]'s [brush_what]..."),
				span_notice("[user] starts to run [src] [through] [human_target]'s [brush_what]..."),
				vis_dist,
			)
	if(!do_after(user, brush_speed, TRUE, human_target))
		return abort(human_target, user)
	if(last_brushed != brush_what)
		if(human_target == user)
			user.visible_message(
				span_notice("[user] brushes [user.p_their()] [brush_what]!"),
				span_notice("You brush your [brush_what]!"),
				span_notice("[user] brushes [user.p_their()] [brush_what]!"),
				vis_dist,
			)
		else
			user.visible_message(
				span_notice("[user] brushes [human_target]'s [brush_what]!"),
				span_notice("You brush [human_target]'s [brush_what]!"),
				span_notice("[user] brushes [human_target]'s [brush_what]!"),
				vis_dist,
			)
	last_brushed = brush_what
	last_act = world.time
	brush(target, user, TRUE)

/obj/item/hairbrush/proc/smack_em_on_the_butt(mob/user, mob/target)
	if(target.stat == DEAD)
		to_chat(user, span_alert("They're already dead!"))
		return
	if(user == target)
		user.visible_message(
			span_alert("[user] WHAPS [user.p_their()] ass with the back of [src]!"),
			span_userdanger("You WHAP yourself on the ass with the back of your [src.name]!"),
			span_alert("[user] WHAPS [user.p_their()] ass with the back of [src]!"),
			vis_dist,
		)
	else
		user.visible_message(
			span_alert("[user] WHAPS [target] on the ass with the back of [src]!"),
			span_alert("You WHAP [user] on the ass with the back of your [src.name]!"),
			span_alert("[user] WHAPS [target] on the ass with the back of [src]!"),
			vis_dist,
			ignored_mobs = list(target),//k
		)
		var/thespan = "userdanger"
		if(HAS_TRAIT(target, TRAIT_MASO))
			thespan = "love"
		else //i helped, fenny, 2024
			thespan = "userdanger"
		to_chat(target, "<span class='[thespan]'>[user] WHAPS you on the ass with the hard end of [user.p_their()] [src.name]!!</span>")
	playsound(target.loc, 'sound/weapons/slap.ogg', 25, FALSE, -1) // deep bassy ass

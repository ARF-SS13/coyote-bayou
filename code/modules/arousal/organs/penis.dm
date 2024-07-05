/obj/item/organ/genital/penis
	name = "penis"
	desc = "A male reproductive organ."
	icon_state = "penis"
	icon = 'icons/obj/genitals/penis.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS
	masturbation_verb = "stroke"
	arousal_verb = "You pop a boner"
	unarousal_verb = "Your boner goes down"
	genital_flags = CAN_MASTURBATE_WITH|GENITAL_CAN_AROUSE|UPDATE_OWNER_APPEARANCE|GENITAL_CAN_TAUR|GENITAL_CAN_RECOLOR|GENITAL_CAN_RESIZE|GENITAL_CAN_RESHAPE
	linked_organ_slot = ORGAN_SLOT_TESTICLES
	fluid_transfer_factor = 0.5
	shape = DEF_COCK_SHAPE
	size = 2 //arbitrary value derived from length and diameter for sprites.
	layer_index = PENIS_LAYER_INDEX
	var/length = 6 //inches

	var/prev_length = 6 //really should be renamed to prev_length
	var/diameter = 4.38
	var/diameter_ratio = COCK_DIAMETER_RATIO_DEF //0.25; check citadel_defines.dm
	associated_has = CS_PENIS // for cockstring stuff
	hide_flag = HIDE_PENIS // for hideflag stuff
	pornhud_slot = PHUD_TALLYWHACKER

/obj/item/organ/genital/penis/format_for_tgui()
	var/list/out = list()
	out["BitKind"] = "penis"
	out["BitName"] = "A [lowertext(shape)] penis."
	out["BitSize"] = "It is [length] inches long!"
	out["BitColor"] = "[color]"
	out["BitAroused"] = FALSE
	out["BitExtra"] = "Operating at %100 capacity."
	out["BitEmoji"] = "🍆"
	return out

/obj/item/organ/genital/penis/modify_size(modifier, min = -INFINITY, max = INFINITY)
	var/new_value = clamp(length + modifier, min, max)
	if(new_value == length)
		return
	prev_length = length
	length = clamp(length + modifier, min, max)
	update()
	..()

/obj/item/organ/genital/penis/set_size(new_size)
	var/new_value = clamp(new_size, CONFIG_GET(number/penis_min_inches_prefs), CONFIG_GET(number/penis_max_inches_prefs))
	if(new_value == length)
		return
	prev_length = length
	length = CEILING(new_value, 1)
	update()
	..()

/obj/item/organ/genital/penis/update_size(modified = FALSE)
	if(length <= 0)//I don't actually know what round() does to negative numbers, so to be safe!!
		if(owner)
			to_chat(owner, span_warning("You feel your tallywacker shrinking away from your body as your groin flattens out!</b>"))
		QDEL_IN(src, 1)
		if(linked_organ)
			QDEL_IN(linked_organ, 1)
		return
	var/rounded_length = round(length)
	var/new_size
	switch(rounded_length)
		if(0 to 6) //If modest size
			new_size = 1
		if(7 to 12) //If large
			new_size = 2
		if(13 to 24) //If massive
			new_size = 3
		if(25 to 36) //If massive and due for large effects. Tox note here: Inter-stage between massive and enters hyper.
			new_size = 4
		if(37 to 48) //If low-tier hyper, enters medium-high tier with only a foot increase
			new_size = 4
		if(49 to INFINITY) //If medium-high tier hyper/comical. It becomes a baseball bat!
			new_size = 5
	size = new_size

	if(owner)
		if (round(length) > round(prev_length))
			to_chat(owner, span_warning("Your [pick(GLOB.dick_nouns)] [pick("swells up to", "flourishes into", "expands into", "bursts forth into", "grows eagerly into", "amplifys into")] a [uppertext(round(length))] inch penis.</b>"))
		else if ((round(length) < round(prev_length)) && (length > 0.5))
			to_chat(owner, span_warning("Your [pick(GLOB.dick_nouns)] [pick("shrinks down to", "decreases into", "diminishes into", "deflates into", "shrivels regretfully into", "contracts into")] a [uppertext(round(length))] inch penis.</b>"))
	icon_state = sanitize_text("penis_[shape]_[size]")
	diameter = (length * diameter_ratio)//Is it just me or is this ludicous, why not make it exponentially decay?


/obj/item/organ/genital/penis/update_appearance()
	. = ..()
	var/datum/sprite_accessory/S = GLOB.cock_shapes_list[shape]
	var/icon_shape = S ? S.icon_state : "human"
	icon_state = "penis_[icon_shape]_[size]"
	var/lowershape = lowertext(shape)

	if(ishuman(owner))
		if(owner.dna.species.use_skintones)
			var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
			color = SKINTONE2HEX(H.skin_tone)
			if(!H.dna.skin_tone_override)
				icon_state += "_s"
		// else
		// 	color = "#[owner.dna.features["cock_color"]]"
		if(genital_flags & GENITAL_CAN_TAUR && S?.taur_icon && (!S.feat_taur || owner.dna.features[S.feat_taur]) && owner.dna.species.mutant_bodyparts["taur"])
			var/datum/sprite_accessory/taur/T = GLOB.taur_list[owner.dna.features["taur"]]
			if(T.taur_mode & S.accepted_taurs) //looks out of place on those.
				lowershape = "taur, [lowershape]"

	desc = "You see [aroused_state ? "an erect" : "a flaccid"] [lowershape] [name]. You estimate it's about [round(length, 0.25)] inch[round(length, 0.25) != 1 ? "es" : ""] long and [round(diameter, 0.25)] inch[round(diameter, 0.25) != 1 ? "es" : ""] in diameter."

/obj/item/organ/genital/penis/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones)
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["cock_color"]]"
	length = D.features["cock_size"]
	diameter_ratio = D.features["cock_diameter_ratio"]
	shape = D.features["cock_shape"]
	prev_length = length
	update_genital_visibility(D.features["cock_visibility_flags"], FALSE, TRUE)

/obj/item/organ/genital/penis/size_kind()
	return "[size] inch[size!=1?"es":""]"

/obj/item/organ/genital/penis/resize_genital(mob/user)
	var/min_size = CONFIG_GET(number/penis_min_inches_prefs)
	var/max_size = CONFIG_GET(number/penis_max_inches_prefs)
	var/new_length = input(user, "Penis length in inches:\n([min_size]-[max_size])", "Character Preference") as num|null
	if(new_length)
		set_size(clamp(round(new_length), min_size, max_size))
	. = ..()

/obj/item/organ/genital/penis/reshape_genital(mob/user)
	var/new_shape = input(user, "Penis shape:", "Character Preference") as null|anything in GLOB.cock_shapes_list
	if(new_shape)
		shape = new_shape
	. = ..()

/obj/item/organ/genital/penis/arousal_term()
	if(aroused_state)
		return "Hard and throbbing"
	return "Limp and just fine"

/obj/item/organ/genital/penis/on_arouse()
	owner?.show_message(span_userlove("You feel your penis become erect."))
	. = ..()

/obj/item/organ/genital/penis/on_unarouse()
	owner?.show_message(span_userlove("You feel your erection fade."))
	. = ..()

/// Returns its respective sprite accessory from the global list (full of init'd types, hopefully)
/obj/item/organ/genital/penis/get_sprite_accessory()
	return GLOB.cock_shapes_list[shape]

/obj/item/organ/genital/penis/get_layer_number(position)
	switch(position)
		if("FRONT")
			. = ..()
		if("MID")
			return
		if("BEHIND")
			. = ..()


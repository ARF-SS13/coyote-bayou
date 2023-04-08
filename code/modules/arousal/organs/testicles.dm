/obj/item/organ/genital/testicles
	name = "testicles"
	desc = "A male reproductive organ."
	icon_state = "testicles"
	icon = 'icons/obj/genitals/testicles.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	size = BALLS_SIZE_MIN
	arousal_verb = "Your balls ache a little"
	unarousal_verb = "Your balls finally stop aching, again"
	linked_organ_slot = ORGAN_SLOT_PENIS
	genital_flags = CAN_MASTURBATE_WITH|MASTURBATE_LINKED_ORGAN|GENITAL_FLUID_PRODUCTION|UPDATE_OWNER_APPEARANCE|GENITAL_CAN_RECOLOR|GENITAL_CAN_RESHAPE
	var/size_name = "average"
	shape = DEF_BALLS_SHAPE
	fluid_id = /datum/reagent/consumable/semen
	masturbation_verb = "massage"
	layer_index = TESTICLES_LAYER_INDEX
	associated_has = CS_BALLS // for cockstring stuff
	hide_flag = HIDE_BALLS // for hideflag stuff

/obj/item/organ/genital/testicles/generate_fluid()
	if(!linked_organ && !update_link())
		return FALSE
	return ..()
	// in memoriam "Your balls finally feel full, again." ??-2020

/obj/item/organ/genital/testicles/upon_link()
	size = linked_organ.size
	update_size()
	update_appearance()

/obj/item/organ/genital/testicles/update_size(modified = FALSE)
	switch(size)
		if(BALLS_SIZE_MIN)
			size_name = "average"
		if(BALLS_SIZE_DEF)
			size_name = "enlarged"
		if(BALLS_SIZE_MAX)
			size_name = "engorged"
		else
			size_name = "nonexistant"

/obj/item/organ/genital/testicles/update_appearance()
	. = ..()
	var/datum/sprite_accessory/S = GLOB.balls_shapes_list[shape]
	var/icon_shape = S ? S.icon_state : "single"
	icon_state = "testicles_[icon_shape]_[size]"
	var/lowershape = lowertext(shape)
	desc = "You see an [size_name] [lowershape]."
	if(owner)
		if(owner.dna.species.use_skintones)
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		// else
		// 	color = "#[owner.dna.features["balls_color"]]"

/obj/item/organ/genital/testicles/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones)
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["balls_color"]]"
	shape = D.features["balls_shape"]
	fluid_rate = D.features["balls_cum_rate"]
	fluid_mult = D.features["balls_cum_mult"]
	fluid_efficiency = D.features["balls_efficiency"]
	update_genital_visibility(D.features["balls_visibility_flags"], FALSE, TRUE)

/obj/item/organ/genital/testicles/arousal_term()
	if(aroused_state)
		return "Aching with need"
	return "Just fine"

/obj/item/organ/genital/testicles/on_arouse()
	owner?.show_message(span_userlove("You feel your testicles fill with burning need!"))
	. = ..()

/obj/item/organ/genital/testicles/on_unarouse()
	owner?.show_message(span_userlove("Your testicles feel empty."))
	. = ..()

/// Returns its respective sprite accessory from the global list (full of init'd types, hopefully)
/obj/item/organ/genital/testicles/get_sprite_accessory()
	return GLOB.balls_shapes_list[shape]

/// fun fact, these used to be broken cus of a typo
/obj/item/organ/genital/testicles/get_layer_number(position)
	switch(position)
		if("FRONT")
			. = ..()
		if("MID")
			return
		if("BEHIND")
			. = ..()


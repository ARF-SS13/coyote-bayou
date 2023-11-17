/obj/item/organ/genital/vagina
	name = "vagina"
	desc = "A female reproductive organ."
	icon = 'icons/obj/genitals/vagina.dmi'
	icon_state = ORGAN_SLOT_VAGINA
	zone = BODY_ZONE_PRECISE_GROIN
	slot = "vagina"
	size = 1 //There is only 1 size right now
	shape = DEF_VAGINA_SHAPE
	genital_flags = CAN_MASTURBATE_WITH|GENITAL_CAN_AROUSE|GENITAL_CAN_RECOLOR|GENITAL_CAN_RESHAPE
	masturbation_verb = "finger"
	arousal_verb = "You feel wetness on your crotch"
	unarousal_verb = "You no longer feel wet"
	fluid_transfer_factor = 0.1 //Yes, some amount is exposed to you, go get your AIDS
	layer_index = VAGINA_LAYER_INDEX
	var/cap_length = 8//D   E   P   T   H (cap = capacity)
	var/cap_girth = 12
	var/cap_girth_ratio = 1.5
	var/clits = 1
	var/clit_diam = 0.25
	var/clit_len = 0.25
	var/list/vag_types = list("tentacle", "dentata", "hairy", "spade", "furred", "inconspicuous")
	associated_has = CS_VAG // for cockstring stuff
	hide_flag = HIDE_VAG // for hideflag stuff
	pornhud_slot = PHUD_VAG

/obj/item/organ/genital/vagina/format_for_tgui()
	var/list/out = list()
	out["BitKind"] = "pussy"
	out["BitName"] = "A [lowertext(shape)] vagina."
	out["BitSize"] = "It is 1.05 Vix in volume!"
	out["BitColor"] = "[color]"
	out["BitAroused"] = FALSE
	out["BitExtra"] = "Operating at %[fluid_efficiency] capacity."
	out["BitEmoji"] = "🌵"
	return out

/obj/item/organ/genital/vagina/update_appearance()
	. = ..()
	icon_state = "vagina"
	var/lowershape = lowertext(shape)
	var/details

	switch(lowershape)
		if("tentacle")
			details = "Its opening is lined with several tentacles and "
		if("dentata")
			details = "There's teeth inside it and it "
		if("hairy")
			details = "It has quite a bit of hair growing on it and "
		if("human")
			details = "It is taut with smooth skin, though without much hair and "
		if("gaping")
			details = "It is gaping slightly open, though without much hair and "
		if("spade")
			details = "It is a plush canine spade, it "
		if("furred")
			details = "It has neatly groomed fur around the outer folds, it "
		if("inconspicuous")
			details = "It is taut with smooth skin, and it "
		else
			details = "It has an exotic shape and "
	if(aroused_state)
		details += "is slick with female arousal."
	else
		details += "seems to be dry."

	desc = "You see a vagina. [details]"

	if(ishuman(owner) && owner?.dna?.species?.use_skintones) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
		var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
		color = SKINTONE2HEX(H.skin_tone)
		if(!H.dna.skin_tone_override)
			icon_state += "_s"
		// else
		// 	color = "#[owner.dna.features["vag_color"]]"
		//if(ishuman(owner))
		//	var/mob/living/carbon/human/H = owner
		//	H.update_genitals() // already done by the parent

/obj/item/organ/genital/vagina/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones)
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["vag_color"]]"
	shape = "[D.features["vag_shape"]]"
	update_genital_visibility(D.features["vag_visibility_flags"], FALSE, TRUE)

/obj/item/organ/genital/vagina/reshape_genital(mob/user)
	var/new_shape
	new_shape = input(user, "Type of vagina", "Character Preference") as null|anything in GLOB.vagina_shapes_list
	if(new_shape)
		shape = new_shape
	. = ..() // call your parents and tell them how big you got!

/obj/item/organ/genital/vagina/arousal_term()
	if(aroused_state)
		return "Moist and slick"
	return "Just fine"

/obj/item/organ/genital/vagina/on_arouse()
	owner?.show_message(span_userlove("You feel a warm slickness down there."))
	. = ..()

/obj/item/organ/genital/vagina/on_unarouse()
	owner?.show_message(span_userlove("You feel a dull dryness down there."))
	. = ..()

/// Returns its respective sprite accessory from the global list (full of init'd types, hopefully)
/obj/item/organ/genital/vagina/get_sprite_accessory()
	return GLOB.vagina_shapes_list[shape]

/obj/item/organ/genital/vagina/get_layer_number(position)
	switch(position)
		if("FRONT")
			. = ..()
		if("MID")
			return
		if("BEHIND")
			return


GLOBAL_LIST_INIT(butt_descriptors, list(
	"grow" = list(
		"swell up to",
		"flourish into",
		"expand into",
		"plump up into",
		"grow eagerly into",
		"amplify into"
	),
	"shrink" = list(
		"shrink down to",
		"decrease into",
		"wobble down into",
		"diminish into",
		"deflate into",
		"contracts into"
	),
	"buttsize" = list(
		"waistline",
		"lower proportions",
		"hinder",
		"rump",
		"tushie"
	),
	"buttdesc" = list(
		"ass",
		"butt",
		"tushie",
		"rump",
		"tushie"
	)
))

/// butt
/obj/item/organ/genital/butt
	name = "butt"
	desc = "You see a patootie."
	icon_state = "butt"
	icon = 'icons/obj/genitals/butt.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_BUTT
	w_class = WEIGHT_CLASS_NORMAL
	size = BUTT_SIZE_DEF
	var/size_name = "nonexistent"
	layer_index = BUTT_LAYER_INDEX
	shape = DEF_BUTT_SHAPE // unused
	genital_flags = UPDATE_OWNER_APPEARANCE|GENITAL_CAN_RECOLOR|GENITAL_CAN_RESIZE
	masturbation_verb = "massage"
	associated_has = CS_BUTT // for cockstring stuff
	hide_flag = HIDE_BUTT // for hideflag stuff
	pornhud_slot = PHUD_BUTT

/obj/item/organ/genital/butt/format_for_tgui()
	var/list/out = list()
	out["BitKind"] = "butt"
	out["BitName"] = "A butt."
	out["BitSize"] = "It is a category-[size]!"
	out["BitColor"] = "[color]"
	out["BitAroused"] = FALSE
	out["BitExtra"] = "Operating at %100 capacity."
	out["BitEmoji"] = "🍑"
	return out

/obj/item/organ/genital/butt/modify_size(modifier, min = BUTT_SIZE_MIN, max = BUTT_SIZE_MAX)
	var/new_value = clamp(cached_size + modifier, min, max)
	if(new_value == cached_size)
		return
	prev_size = cached_size
	cached_size = new_value
	size = round(cached_size)
	update()
	..()

/obj/item/organ/genital/butt/set_size(new_size)
	var/new_value = clamp(new_size, CONFIG_GET(number/butt_min_size_prefs), CONFIG_GET(number/butt_max_size_prefs))
	if(new_value == cached_size)
		return
	prev_size = cached_size
	cached_size = new_value
	size = CEILING(cached_size, 1)
	update()
	..()

/obj/item/organ/genital/butt/update_size()
	var/rounded_size = clamp(size, BUTT_SIZE_MIN, BUTT_SIZE_MAX)
	if(size < 0)//I don't actually know what round() does to negative numbers, so to be safe!!fixed
		if(owner)
			to_chat(owner, span_warning("You feel your asscheeks shrink down to an ordinary size."))
		QDEL_IN(src, 1)
		return

	if(owner) //Because byond doesn't count from 0, I have to do this.
		var/mob/living/carbon/human/H = owner
		var/r_prev_size = round(prev_size)
		if (rounded_size > r_prev_size)
			to_chat(H, span_warning("Your [pick(GLOB.butt_descriptors["buttsize"])] [pick(GLOB.butt_descriptors["grow"])] a larger pair."))
		else if (rounded_size < r_prev_size)
			to_chat(H, span_warning("Your [pick(GLOB.butt_descriptors["buttsize"])] [pick(GLOB.butt_descriptors["grow"])] a smaller pair."))

/obj/item/organ/genital/butt/update_appearance()
	//Reflect the size of dat ass on examine.
	switch(round(size))
		if(1)
			size_name = pick("average", "cute", "slender", "fit", "pert")
		if(2)
			size_name = pick("above-average", "ample", "pinchable")
		if(3)
			size_name = pick("thick", "thicc", "soft", "plush")
		if(4)
			size_name = pick("well-padded", "wobbly", "fat", "generous")
		if(5)
			size_name = pick("massive", "blubbery", "pants-stretching")
		if(6)
			size_name = pick("gigantic", "chair-creaking", "undie-devouring")
		if(7)
			size_name = pick("monstrous", "bed-bending", "arm-devouring")
		if(8)
			size_name = pick("doorway-plugging", "barstool-devouring", "mountainous")
		else
			size_name = "nonexistent"

	desc = "You see \a [size_name] [pick(GLOB.butt_descriptors["buttdesc"])]."

	var/icon_size = round(clamp(size, BUTT_SIZE_MIN, BUTT_SIZE_MAX), 1)
	icon_state = "butt_pair_[icon_size]"
	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		// else
		// 	color = "#[owner.dna.features["butt_color"]]"


/obj/item/organ/genital/butt/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones && D.features["genitals_use_skintone"])
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["butt_color"]]"
	size = D.features["butt_size"]
	if(!isnum(size))
		size = BUTT_SIZE_DEF
	prev_size = size
	cached_size = size
	update_genital_visibility(D.features["butt_visibility_flags"], FALSE, TRUE)

/obj/item/organ/genital/butt/resize_genital(mob/user)
	var/min_size = CONFIG_GET(number/butt_min_size_prefs)
	var/max_size = CONFIG_GET(number/butt_max_size_prefs)
	var/new_length = input(user, "Butt size:\n([min_size]-[max_size])", "Character Preference") as num|null
	if(new_length)
		set_size(clamp(round(new_length), min_size, max_size))
	. = ..() // call your parents and tell them how big you got!

/obj/item/organ/genital/butt/mask_part(icon_in, state_in, layer_in, position_in)
	//if(layer_in == GENITAL_OVER_CLOTHES_FRONT_LAYER && position_in == "MID")
	return cut_up_genital(icon_in,state_in,list("arm_right_no_north","arm_left_no_north"))

/// Returns its respective sprite accessory from the global list (full of init'd types, hopefully)
/obj/item/organ/genital/butt/get_sprite_accessory()
	return GLOB.butt_shapes_list[shape]

/obj/item/organ/genital/butt/get_layer_number(position)
	switch(position)
		if("FRONT")
			. = ..()
		if("MID")
			. = ..()
		if("BEHIND")
			return


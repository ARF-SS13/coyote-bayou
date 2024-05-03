#define BREASTS_ICON_MIN_SIZE 1
#define BREASTS_ICON_MAX_SIZE 20

/obj/item/organ/genital/breasts
	name = "breasts"
	desc = "Female milk producing organs."
	icon_state = "breasts"
	icon = 'icons/obj/genitals/breasts.dmi'
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	size = BREASTS_SIZE_DEF // "c". Refer to the breast_values static list below for the cups associated number values
	fluid_id = /datum/reagent/consumable/milk
	fluid_rate = MILK_RATE
	layer_index = BREAST_LAYER_INDEX
	shape = DEF_BREASTS_SHAPE
	genital_flags = CAN_MASTURBATE_WITH|CAN_CLIMAX_WITH|GENITAL_FLUID_PRODUCTION|GENITAL_CAN_AROUSE|UPDATE_OWNER_APPEARANCE|GENITAL_CAN_RECOLOR|GENITAL_CAN_RESIZE|GENITAL_CAN_RESHAPE
	masturbation_verb = "massage"
	arousal_verb = "Your breasts start feeling sensitive"
	unarousal_verb = "Your breasts no longer feel sensitive"
	orgasm_verb = "leaking"
	fluid_transfer_factor = 0.5
	associated_has = CS_BOOB // for cockstring stuff
	hide_flag = HIDE_BOOBS // for hideflag stuff
	pornhud_slot = PHUD_BOOB

GLOBAL_LIST_INIT(breast_values, list(
	"a" = 1,
	"b" = 2,
	"c" = 3,
	"d" = 4,
	"e" = 5,
	"f" = 6,
	"g" = 7,
	"h" = 8,
	"i" = 9,
	"j" = 10,
	"k" = 11,
	"l" = 12,
	"m" = 13,
	"n" = 14,
	"o" = 15,
	"huge" = 16,
	"massive" = 17,
	"giga" = 18,
	"impossible" = 19, 
	"flat" = 0))

GLOBAL_LIST_INIT(massive_breast_descriptors, list(
	"some serious honkers",
	"a real set of badonkers",
	"some dobonhonkeros",
	"massive dohoonkabhankoloos",
	"two big old tonhongerekoogers",
	"a couple of giant bonkhonagahoogs",
	"a pair of humongous hungolomghnonoloughonamogus",
	"a bosomy mountain range",
	"some jiggly cascading sacks of boob",
	"some frontloaded anvils",
	"a rack you could hide someone between",
	"a vast expanse of mammary meat",
	"more boob than person",
	"some comfy-looking beanbags growing out of a person",
	"boobs, just boobs, just nothing but boobs"
	))

/obj/item/organ/genital/breasts/Initialize(mapload, do_update = TRUE)
	if(do_update)
		cached_size = GLOB.breast_values[size]
		prev_size = cached_size
	return ..()

/obj/item/organ/genital/breasts/format_for_tgui()
	var/list/out = list()
	out["BitKind"] = "boobs"
	switch(lowertext(shape))
		if("udders")
			out["BitName"] = "A set of udders."
		if("pair")
			out["BitName"] = "A pair of breasts."
		if("pair(round)")
			out["BitName"] = "A pair of breasts."
		else
			out["BitName"] = "A [shape]-set of breasts."
	out["BitSize"] = "They are \a [uppertext(size)]-cup."
	out["BitColor"] = "[color]"
	out["BitAroused"] = !!aroused_state
	out["BitExtra"] = "Operating at %100 capacity."
	out["BitEmoji"] = "🐄"
	return out

/obj/item/organ/genital/breasts/update_appearance()
	. = ..()
	var/lowershape = lowertext(shape)
	switch(lowershape)
		if("pair")
			desc = "You see a pair of breasts."
		if("pair(round)")
			desc = "You see a pair of breasts."
		if("quad")
			desc = "You see two pairs of breast, one just under the other."
		if("sextuple")
			desc = "You see three sets of breasts, running from their chest to their belly."
		if("udders")
			desc = "You see a set of crotch milkers, they are udderly fantastic!"
		else
			desc = "You see some breasts, they seem to be quite exotic."
	if(size in list("huge", "massive", "giga", "impossible"))
		desc += "\nThey are [pick(GLOB.massive_breast_descriptors)], far beyond any conventional measurement!"
	else
		if (size == "flat")
			desc += " They're very small and flatchested, however."
		else
			desc += " You estimate that they're [uppertext(size)]-cups."

	if(CHECK_BITFIELD(genital_flags, GENITAL_FLUID_PRODUCTION) && aroused_state)
		var/datum/reagent/R = GLOB.chemical_reagents_list[fluid_id]
		if(R)
			desc += " They're leaking [lowertext(R.name)]."
	var/datum/sprite_accessory/S = GLOB.breasts_shapes_list[shape]
	var/icon_shape = S ? S.icon_state : "pair"
	var/icon_size = clamp(GLOB.breast_values[size], BREASTS_ICON_MIN_SIZE, BREASTS_ICON_MAX_SIZE)
	icon_state = "breasts_[icon_shape]_[icon_size]"
	if(owner)
		if(owner.dna.species.use_skintones)
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		// else // color isnt neccessarilllallilaryly whats in the features
		// 	color = "#[owner.dna.features["breasts_color"]]"

//Allows breasts to grow and change size, with sprite changes too.
//maximum wah
//Comical sizes slow you down in movement and actions.
//Ridiculous sizes makes you more cumbersome.
//this is far too lewd wah

/obj/item/organ/genital/breasts/modify_size(modifier, min = -INFINITY, max = INFINITY)
	var/new_value = clamp(cached_size + modifier, min, max)
	if(new_value == cached_size)
		return
	prev_size = cached_size
	cached_size = new_value
	update()
	..()

/obj/item/organ/genital/breasts/set_size(new_size)
	var/new_value = new_size
	if(istext(new_size) && (new_size in GLOB.breast_values))
		new_value = GLOB.breast_values[new_size]
	if(!isnum(new_value))
		return
	if(new_value == cached_size)
		return
	new_value = clamp(new_value, 0, 19)
	prev_size = cached_size
	cached_size = new_value
	update()
	..()

/obj/item/organ/genital/breasts/update_size()//wah
	var/rounded_cached = round(cached_size)
	if(cached_size < 0)//I don't actually know what round() does to negative numbers, so to be safe!!fixed
		if(owner)
			to_chat(owner, span_warning("You feel your breasts shrinking away from your body as your chest flattens out."))
		QDEL_IN(src, 1)
		return
	switch(rounded_cached)
		if(0) //flatchested
			size = "flat"
		if(1 to 19) //on the charts
			size = GLOB.breast_values[rounded_cached]
		if(19 to INFINITY) //off the charts
			size = "impossible"

	if(rounded_cached < 19 && owner)//Because byond doesn't count from 0, I have to do this.
		var/mob/living/carbon/human/H = owner
		var/r_prev_size = round(prev_size)
		if (rounded_cached > r_prev_size)
			to_chat(H, span_warning("Your breasts [pick("swell up to", "flourish into", "expand into", "burst forth into", "grow eagerly into", "amplify into")] a [uppertext(size)]-cup."))
		else if (rounded_cached < r_prev_size)
			to_chat(H, span_warning("Your breasts [pick("shrink down to", "decrease into", "diminish into", "deflate into", "shrivel regretfully into", "contracts into")] a [uppertext(size)]-cup."))

/obj/item/organ/genital/breasts/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones)
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["breasts_color"]]"
	size = D.features["breasts_size"]
	shape = D.features["breasts_shape"]
	if(!D.features["breasts_producing"])
		DISABLE_BITFIELD(genital_flags, GENITAL_FLUID_PRODUCTION|CAN_MASTURBATE_WITH)
	if(!isnum(size))
		cached_size = GLOB.breast_values[size]
	else
		cached_size = size
		size = GLOB.breast_values[size]
	prev_size = cached_size
	update_genital_visibility(D.features["breasts_visibility_flags"], FALSE, TRUE)

/obj/item/organ/genital/breasts/size_kind()
	return "[uppertext(size)]-cup"

/obj/item/organ/genital/breasts/resize_genital(mob/user)
	var/new_size = input(user, "Pick a new cup size", "Character Preference", size) as null|anything in CONFIG_GET(keyed_list/breasts_cups_prefs)
	if(new_size)
		set_size(new_size)
	. = ..()

/obj/item/organ/genital/breasts/reshape_genital(mob/user)
	var/new_shape
	new_shape = input(user, "Number of breasts", "Character Preference") as null|anything in GLOB.breasts_shapes_list
	if(new_shape)
		shape = new_shape
	. = ..() // call your parents and tell them how big you got!

/obj/item/organ/genital/breasts/arousal_term()
	if(aroused_state)
		return "Aroused and perky"
	return "Just fine"

/// your butt sets people breasts fire when horny
/obj/item/organ/genital/breasts/on_arouse()
	owner?.show_message(span_userlove("You feel your breasts become sensitive and their nipples stiffen."))
	. = ..()

/// your womb eats a burger when unhorny
/obj/item/organ/genital/breasts/on_unarouse()
	owner?.show_message(span_userlove("Your nipples soften back to normal."))
	. = ..()

/// Returns its respective sprite accessory from the global list (full of init'd types, hopefully)
/obj/item/organ/genital/breasts/get_sprite_accessory()
	return GLOB.breasts_shapes_list[shape]

/obj/item/organ/genital/breasts/get_layer_number(position)
	switch(position)
		if("FRONT")
			. = ..()
		if("MID")
			return
		if("BEHIND")
			. = ..()


#undef BREASTS_ICON_MIN_SIZE
#undef BREASTS_ICON_MAX_SIZE

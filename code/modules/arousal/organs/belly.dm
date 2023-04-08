GLOBAL_LIST_INIT(belly_descriptors, list(
	"grow" = list(
		"swell up to",
		"flourish into",
		"expand into",
		"plump up into",
		"grow eagerly into",
		"amplify into",
		),
	"shrink" = list(
		"shrink down to",
		"decrease into",
		"wobble down into",
		"diminish into",
		"deflate into",
		"contracts into",
		),
	"belly_descriptors" = list(
		"waistline",
		"spare tire",
		"spare tyre", /* if ckey == "planetary"... */
		"paunch",
		"breadbasket",
		"middle",
		"bay window",
		"muffin top",
		),
	"belly_prefix" = list(
		"1" = list(
			list(BELLY_SHAPE_TUMMY = "slim",
				BELLY_SHAPE_OBESE = "slim"),
			list(BELLY_SHAPE_TUMMY = "cute",
				BELLY_SHAPE_OBESE = "cute"),
			list(BELLY_SHAPE_TUMMY = "slender",
				BELLY_SHAPE_OBESE = "slender"),
			list(BELLY_SHAPE_TUMMY = "fit",
				BELLY_SHAPE_OBESE = "fit"),
			list(BELLY_SHAPE_TUMMY = "little",
				BELLY_SHAPE_OBESE = "flat"),
			),
		"2" = list(
			list(BELLY_SHAPE_TUMMY = "svelte",
				BELLY_SHAPE_OBESE = "rounded"), 
			list(BELLY_SHAPE_TUMMY = "average",
				BELLY_SHAPE_OBESE = "soft"), 
			list(BELLY_SHAPE_TUMMY = "normal",
				BELLY_SHAPE_OBESE = "poochy"),
			),
		"3" = list(
			list(BELLY_SHAPE_TUMMY = "pudgy",
				BELLY_SHAPE_OBESE = "plush"),
			list(BELLY_SHAPE_TUMMY = "paunchy",
				BELLY_SHAPE_OBESE = "chubby"),
			list(BELLY_SHAPE_TUMMY = "smooth, round",
				BELLY_SHAPE_OBESE = "plump"),
			list(BELLY_SHAPE_TUMMY = "respectable",
				BELLY_SHAPE_OBESE = "doughy"),
			list(BELLY_SHAPE_TUMMY = "round",
				BELLY_SHAPE_OBESE = "jiggly"),
			),
		"4" = list(
			list(BELLY_SHAPE_TUMMY = "wide hefty",
				BELLY_SHAPE_OBESE = "plush jiggly"),
			list(BELLY_SHAPE_TUMMY = "round plump",
				BELLY_SHAPE_OBESE = "heavy wobbly"),
			list(BELLY_SHAPE_TUMMY = "fat soft",
				BELLY_SHAPE_OBESE = "big sagging"),
			list(BELLY_SHAPE_TUMMY = "big tubby",
				BELLY_SHAPE_OBESE = "wide hanging"),
			),
		"5" = list(
			list(BELLY_SHAPE_TUMMY = "heavy dome of",
				BELLY_SHAPE_OBESE = "thick, well-insulated sheet of"), 
			list(BELLY_SHAPE_TUMMY = "dougy ball of",
				BELLY_SHAPE_OBESE = "heavy, well-fed sack of"), 
			list(BELLY_SHAPE_TUMMY = "hefty orb of",
				BELLY_SHAPE_OBESE = "wobbly, well-stuffed mass of"),
			),
		"6" = list(
			list(BELLY_SHAPE_TUMMY = "bulbous",
				BELLY_SHAPE_OBESE = "massive, belt-devouring"),
			list(BELLY_SHAPE_TUMMY = "blobby",
				BELLY_SHAPE_OBESE = "blubbery, waistband-devouring"),
			list(BELLY_SHAPE_TUMMY = "bloated",
				BELLY_SHAPE_OBESE = "lard-packed, crotch-hiding"),
			),
		"7" = list(
			list(BELLY_SHAPE_TUMMY = "sagging, crotch-hiding",
				BELLY_SHAPE_OBESE = "floor-grazing apron of"),
			list(BELLY_SHAPE_TUMMY = "hanging, belt-covering",
				BELLY_SHAPE_OBESE = "morbidly obese mass of"),
			list(BELLY_SHAPE_TUMMY = "dangling, waistband-snapping",
				BELLY_SHAPE_OBESE = "thigh-hiding blob of"),
			),
		"8" = list(
			list(BELLY_SHAPE_TUMMY = "massive boulder of",
				BELLY_SHAPE_OBESE = "gigantic, floor-dragging"),
			list(BELLY_SHAPE_TUMMY = "fat whale of",
				BELLY_SHAPE_OBESE = "hyperobese, street-sweeping"),
			list(BELLY_SHAPE_TUMMY = "tremendous mountain of",
				BELLY_SHAPE_OBESE = "tremendous, shin-hiding"),
			),
		"9" = list(
			list(BELLY_SHAPE_TUMMY = "vast blubbery expanse of",
				BELLY_SHAPE_OBESE = "colossal, pavement-spreading"),
			list(BELLY_SHAPE_TUMMY = "vast tremendous blob of",
				BELLY_SHAPE_OBESE = "gargantuan, ground-covering"),
			list(BELLY_SHAPE_TUMMY = "vast gargantuan blob of",
				BELLY_SHAPE_OBESE = "monstrously obese, road-flattening"),
			),
		"10" = list(
			list(BELLY_SHAPE_TUMMY = "mountainous, globelike",
				BELLY_SHAPE_OBESE = "figure so distorted with fat,"),
			list(BELLY_SHAPE_TUMMY = "mountainous, boulderlike",
				BELLY_SHAPE_OBESE = "frame so utterly devoured by fat,"),
			list(BELLY_SHAPE_TUMMY = "mountainous, spherical",
				BELLY_SHAPE_OBESE = "creature so impossibly obese,"),
			),
		"11" = list(
			list(BELLY_SHAPE_TUMMY = "mountainous, globelike",
				BELLY_SHAPE_OBESE = "body that may have at one point resembled a person, but is now so entombed in fat that"),
			list(BELLY_SHAPE_TUMMY = "mountainous, boulderlike",
				BELLY_SHAPE_OBESE = "poor creature buried alive in their own fat, so utterly, impossibly hyperobese that"),
			list(BELLY_SHAPE_TUMMY = "mountainous, spherical",
				BELLY_SHAPE_OBESE = "figure barely recognizable as a person, their form so swaddled in untold layers of fat that"),
			),
		"12" = list(
			list(BELLY_SHAPE_TUMMY = "description-defying",
				BELLY_SHAPE_OBESE = "description defying"),
			),
		),
	"belly_suffix" = list(
		"1" = list(
			list(BELLY_SHAPE_TUMMY = "tummy",
				BELLY_SHAPE_OBESE = "middle"),
			),
		"2" = list(
			list(BELLY_SHAPE_TUMMY = "little tumtum",
				BELLY_SHAPE_OBESE = "midriff"), 
			list(BELLY_SHAPE_TUMMY = "lil' tummy",
				BELLY_SHAPE_OBESE = "middle"), 
			),
		"3" = list(
			list(BELLY_SHAPE_TUMMY = "tummy",
				BELLY_SHAPE_OBESE = "belly"),
			list(BELLY_SHAPE_TUMMY = "tummy",
				BELLY_SHAPE_OBESE = "gut"),
			),
		"4" = list(
			list(BELLY_SHAPE_TUMMY = "ball of a belly",
				BELLY_SHAPE_OBESE = "sheet of flab"),
			list(BELLY_SHAPE_TUMMY = "beanbag of a tummy",
				BELLY_SHAPE_OBESE = "set of jiggly body armor"),
			list(BELLY_SHAPE_TUMMY = "sack of fat",
				BELLY_SHAPE_OBESE = "slab of blubber"),
			),
		"5" = list(
			list(BELLY_SHAPE_TUMMY = "belly that shirts fear",
				BELLY_SHAPE_OBESE = "pure plush lard that ensures a warm winter"), 
			list(BELLY_SHAPE_TUMMY = "belly that has never missed out on seconds",
				BELLY_SHAPE_OBESE = "pure cushy blubber that hangs below the waist"), 
			list(BELLY_SHAPE_TUMMY = "belly that knows its way around a buffet",
				BELLY_SHAPE_OBESE = "pure cozy pudge that would make a good pillow"),
			),
		"6" = list(
			list(BELLY_SHAPE_TUMMY = "blubbery boulder of a swollen belly",
				BELLY_SHAPE_OBESE = "blob of obese flesh one could lose a hand inside"),
			list(BELLY_SHAPE_TUMMY = "behemoth bulge of a swollen belly",
				BELLY_SHAPE_OBESE = "apron of calories one could hide an arm under"),
			list(BELLY_SHAPE_TUMMY = "blimplike butterball of a swollen belly",
				BELLY_SHAPE_OBESE = "suit of thick, heavy fat one could bury a muzzle under"),
			),
		"7" = list(
			list(BELLY_SHAPE_TUMMY = "mass of obesity that could easily fill the average lap",
				BELLY_SHAPE_OBESE = "a testament to the sheer bounty of food that Nash has to offer"),
			list(BELLY_SHAPE_TUMMY = "ball of well-marbled bellymeat that could easily fill an armchair",
				BELLY_SHAPE_OBESE = "a waistline long-since buried under a mountain of fat"),
			list(BELLY_SHAPE_TUMMY = "blob of countless calories that could easily fill even the largest of shirts",
				BELLY_SHAPE_OBESE = "an impenetrable mountain of fat that threatens to reach the ground"),
			),
		"8" = list(
			list(BELLY_SHAPE_TUMMY = "a vast gut that could comfortably seat multiple people with room to spare",
				BELLY_SHAPE_OBESE = "behemoth of fatty blubbery flesh, completely obscuring its owner's legs from the front"),
			list(BELLY_SHAPE_TUMMY = "a mammoth belly that could comfortably serve as a bed for the average person",
				BELLY_SHAPE_OBESE = "blob of rampant hyperobesity, kicked around with every heavy footstep of its owner"),
			list(BELLY_SHAPE_TUMMY = "a gigantic blubbery ball that could comfortably cover any smaller folk",
				BELLY_SHAPE_OBESE = "mountain of useless calories, completely hiding everything below its owner's former waist"),
			),
		"9" = list(
			list(BELLY_SHAPE_TUMMY = "a belly packed so full with soft, supple fat that it appears to have a belly of its own",
				BELLY_SHAPE_OBESE = "behemoth of flesh and blubber that exists in defiance to biology, a monument of sheer excess and constitution"),
			list(BELLY_SHAPE_TUMMY = "a belly stuffed so full with plush, jiggly fat that it easily weighs more than its owner",
				BELLY_SHAPE_OBESE = "mountain of living lard that exists in defiance to biology, a monument of sheer excess and constitution"),
			list(BELLY_SHAPE_TUMMY = "a belly bloated to full with heavy, wobbly fat that it has swollen past its owner's shins",
				BELLY_SHAPE_OBESE = "blob of fattened flesh that exists in defiance to biology, a monument of sheer excess and constitution"),
			),
		"10" = list(
				list(BELLY_SHAPE_TUMMY = "mass of rounded meat, layers upon layers of dense, supple fat formed into a colossal ball of a belly",
					BELLY_SHAPE_OBESE = "that whatever defined features it may have had have been long since buried alive under an avalanche of fat"),
				list(BELLY_SHAPE_TUMMY = "mass of rounded meat, layers upon layers of dense, supple fat formed into a colossal ball of a belly",
					BELLY_SHAPE_OBESE = "that its a wonder the poor being trapped inside is able to move, let alone survive such a bonecrushing weight"),
				list(BELLY_SHAPE_TUMMY = "mass of rounded meat, layers upon layers of dense, supple fat formed into a colossal ball of a belly",
					BELLY_SHAPE_OBESE = "that it serves as a living testament to the consequences of a lifetime of overindulgence, an allegedly portable prison of fat"),
			),
		"11" = list(
				list(BELLY_SHAPE_TUMMY = "mass of rounded meat, layers upon layers of dense, supple fat formed into a colossal ball of a belly",
					BELLY_SHAPE_OBESE = "the person trapped inside has long since been lost beneath their sea of lard, buried alive in a mountain of their own indulgence."),
				list(BELLY_SHAPE_TUMMY = "mass of rounded meat, layers upon layers of dense, supple fat formed into a colossal ball of a belly",
					BELLY_SHAPE_OBESE = "it has transformed this creature's body into a shapeless mass, with rolls and folds of fat covering every inch of skin"),
				list(BELLY_SHAPE_TUMMY = "mass of rounded meat, layers upon layers of dense, supple fat formed into a colossal ball of a belly",
					BELLY_SHAPE_OBESE = "it's hard not to imagine how it would feel to lay atop it, sinking into its soft folds and feeling its immense weight pressing down upon you. It is a bizarre thought, to be sure, but also a testament to the sheer size and scale of this belly"),
			), // I DONT HAVE PROBLEMS, MOM!
		"12" = list(
				list(BELLY_SHAPE_TUMMY = "description-defying",
					BELLY_SHAPE_OBESE = "description defying"),
))))

/// belly
/obj/item/organ/genital/belly
	name = "belly"
	desc = "You see a belly on their midsection."
	icon_state = "belly"
	icon = 'icons/obj/genitals/belly.dmi'
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BELLY
	w_class = WEIGHT_CLASS_NORMAL
	size = 1
	genital_flags = UPDATE_OWNER_APPEARANCE|GENITAL_CAN_RECOLOR|GENITAL_CAN_RESIZE|GENITAL_CAN_RESHAPE
	layer_index = BELLY_LAYER_INDEX
	shape = DEF_BELLY_SHAPE // either tummy or obese
	masturbation_verb = "massage"
	var/shape_kind = "tummy"
	associated_has = CS_BELLY // for cockstring stuff
	hide_flag = HIDE_BELLY // for hideflag stuff

/obj/item/organ/genital/belly/modify_size(modifier, min = BELLY_SIZE_MIN, max = BELLY_SIZE_MAX)
	var/new_value = clamp(cached_size + modifier, min, max)
	if(new_value == cached_size)
		return
	prev_size = cached_size
	cached_size = new_value
	size = round(cached_size)
	update()
	..()

/obj/item/organ/genital/belly/set_size(new_size)
	var/new_value = clamp(new_size, CONFIG_GET(number/belly_min_size_prefs), CONFIG_GET(number/belly_max_size_prefs))
	if(new_value == cached_size)
		return
	prev_size = cached_size
	cached_size = new_value
	size = CEILING(cached_size, 1)
	update()
	..()

/obj/item/organ/genital/belly/update_size()
	var/rounded_size = clamp(size, BELLY_SIZE_MIN, BELLY_SIZE_MAX)
	if(size < 0)//I don't actually know what round() does to negative numbers, so to be safe!!fixed
		if(owner)
			to_chat(owner, span_warning("You feel your [shape_kind] shrink down to an ordinary size."))
		QDEL_IN(src, 1)
		return

	if(owner) //Because byond doesn't count from 0, I have to do this.
		var/mob/living/carbon/human/H = owner
		var/r_prev_size = round(prev_size)
		if (rounded_size > r_prev_size)
			to_chat(H, span_warning("Your [pick(GLOB.belly_descriptors["belly_descriptors"])] [pick(GLOB.belly_descriptors["grow"])] larger."))
		else if (rounded_size < r_prev_size)
			to_chat(H, span_warning("Your [pick(GLOB.belly_descriptors["belly_descriptors"])] [pick(GLOB.belly_descriptors["grow"])] smaller."))

/obj/item/organ/genital/belly/update_appearance()
	//Reflect the size of dat belly on examine.
	var/bellysize = "[CEILING(size, 1)]"
	var/list/belly_prefix_list = pick(GLOB.belly_descriptors["belly_prefix"][bellysize])
	var/belly_prefix = belly_prefix_list[shape]
	var/list/belly_suffix_list = pick(GLOB.belly_descriptors["belly_suffix"][bellysize])
	var/belly_suffix = belly_suffix_list[shape]
	desc = "You see \a [belly_prefix] [belly_suffix]."
	icon_state = "belly"
	//if(owner?.dna?.features["belly_color"])
	//	color = "#[owner.dna.features["belly_color"]]"


/obj/item/organ/genital/belly/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones && D.features["genitals_use_skintone"])
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["belly_color"]]"
	size = D.features["belly_size"]
	shape = D.features["belly_shape"]
	if(!isnum(size))
		size = BELLY_SIZE_DEF
	prev_size = size
	cached_size = size
	update_genital_visibility(D.features["belly_visibility_flags"], FALSE, TRUE)

/obj/item/organ/genital/belly/get_icon_state(mob/living/carbon/human/H)
	return "belly_[size]_[lowertext(shape)]" // belly_11_obese

/obj/item/organ/genital/belly/size_kind()
	return "[size]XL"

/obj/item/organ/genital/belly/resize_genital(mob/user)
	var/min_size = CONFIG_GET(number/belly_min_size_prefs)
	var/max_size = CONFIG_GET(number/belly_max_size_prefs)
	var/new_size = input(user, "Belly size:\n([min_size]-[max_size])", "Character Preference") as num|null
	if(new_size)
		set_size(clamp(round(new_size), min_size, max_size))
	. = ..() // call your parents and tell them how big you got!

/obj/item/organ/genital/belly/reshape_genital(mob/user)
	var/new_shape
	new_shape = input(user, "Belly Shape", "Character Preference") as null|anything in GLOB.belly_shapes_list
	if(new_shape)
		shape = new_shape
	. = ..() // call your parents and tell them how big you got!

/// Returns its respective sprite accessory from the global list (full of init'd types, hopefully)
/obj/item/organ/genital/belly/get_sprite_accessory()
	return GLOB.belly_shapes_list[shape]

/obj/item/organ/genital/belly/get_layer_number(position)
	switch(position)
		if("FRONT")
			. = ..()
		if("MID")
			return
		if("BEHIND")
			return

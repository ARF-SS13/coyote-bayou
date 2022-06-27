/obj/effect/decal/cleanable/blood
	name = "blood"
	desc = "It's gooey. Perhaps it's the chef's cooking?"
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	blood_state = BLOOD_STATE_BLOOD
	bloodiness = BLOOD_AMOUNT_PER_DECAL
	color = BLOOD_COLOR_HUMAN //default so we don't have white splotches everywhere.
	beauty = -100

/obj/effect/decal/cleanable/blood/replace_decal(obj/effect/decal/cleanable/blood/C)
	if (C.blood_DNA)
		blood_DNA |= C.blood_DNA
	update_icon()
	..()

/obj/effect/decal/cleanable/blood/transfer_blood_dna()
	..()
	update_icon()

/obj/effect/decal/cleanable/blood/transfer_mob_blood_dna()
	. = ..()
	update_icon()

/obj/effect/decal/cleanable/blood/update_icon()
	color = blood_DNA_to_color()

/obj/effect/decal/cleanable/blood/old
	name = "dried blood"
	desc = "Looks like it's been here a while. Ew."
	bloodiness = 0

/obj/effect/decal/cleanable/blood/old/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	icon_state += "-old"
	add_blood_DNA(list("Non-human DNA" = "A+"))

/obj/effect/decal/cleanable/blood/splats
	random_icon_states = list("gibbl1", "gibbl2", "gibbl3", "gibbl4", "gibbl5")

/obj/effect/decal/cleanable/blood/splatter
	random_icon_states = list("splatter1", "splatter2", "splatter3", "splatter4", "splatter5")

/obj/effect/decal/cleanable/blood/tracks
	icon_state = "tracks"
	desc = "They look like tracks left by wheels."
	random_icon_states = null
	beauty = -50

/obj/effect/decal/cleanable/trail_holder //not a child of blood on purpose
	name = "blood"
	icon = 'icons/effects/blood.dmi'
	icon_state = "ltrails_1"
	desc = "Your instincts say you shouldn't be following these."
	random_icon_states = null
	beauty = -50
	var/list/existing_dirs = list()

/obj/effect/decal/cleanable/trail_holder/update_icon()
	color = blood_DNA_to_color()

/obj/effect/cleanable/trail_holder/Initialize()
	. = ..()
	update_icon()

/obj/effect/decal/cleanable/trail_holder/can_bloodcrawl_in()
	return TRUE

/obj/effect/decal/cleanable/trail_holder/transfer_blood_dna()
	..()
	update_icon()

/obj/effect/decal/cleanable/trail_holder/transfer_mob_blood_dna()
	. = ..()
	update_icon()

//BLOODY FOOTPRINTS
/obj/effect/decal/cleanable/blood/footprints
	name = "footprints"
	icon = 'icons/effects/footprints.dmi'
	icon_state = "nothingwhatsoever"
	desc = "WHOSE FOOTPRINTS ARE THESE?"
	random_icon_states = null
	var/entered_dirs = 0
	var/exited_dirs = 0
	blood_state = BLOOD_STATE_BLOOD //the icon state to load images from
	var/list/shoe_types = list()

/obj/effect/decal/cleanable/blood/footprints/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/decal/cleanable/blood/footprints/proc/on_entered(atom/movable/O)
	SIGNAL_HANDLER
	if(ishuman(O))
		var/mob/living/carbon/human/H = O
		var/obj/item/clothing/shoes/S = H.shoes
		if(S && S.bloody_shoes[blood_state])
			if(color != S.last_blood_color)
				return
			S.bloody_shoes[blood_state] = max(S.bloody_shoes[blood_state] - BLOOD_LOSS_PER_STEP, 0)
			shoe_types |= S.type
			if (!(entered_dirs & H.dir))
				entered_dirs |= H.dir
				update_icon()

/obj/effect/decal/cleanable/blood/footprints/Uncrossed(atom/movable/O)
	if(ishuman(O))
		var/mob/living/carbon/human/H = O
		var/obj/item/clothing/shoes/S = H.shoes
		if(S && S.bloody_shoes[blood_state])
			if(color != S.last_blood_color)//last entry - we check its color
				return
			S.bloody_shoes[blood_state] = max(S.bloody_shoes[blood_state] - BLOOD_LOSS_PER_STEP, 0)
			shoe_types  |= S.type
			if (!(exited_dirs & H.dir))
				exited_dirs |= H.dir
				update_icon()

/obj/effect/decal/cleanable/blood/footprints/update_icon()
	..()
	cut_overlays()
	for(var/Ddir in GLOB.cardinals)
		if(entered_dirs & Ddir)
			var/image/bloodstep_overlay = GLOB.bloody_footprints_cache["entered-[blood_state]-[Ddir]"]
			if(!bloodstep_overlay)
				GLOB.bloody_footprints_cache["entered-[blood_state]-[Ddir]"] = bloodstep_overlay = image(icon, "[blood_state]1", dir = Ddir)
			add_overlay(bloodstep_overlay)
		if(exited_dirs & Ddir)
			var/image/bloodstep_overlay = GLOB.bloody_footprints_cache["exited-[blood_state]-[Ddir]"]
			if(!bloodstep_overlay)
				GLOB.bloody_footprints_cache["exited-[blood_state]-[Ddir]"] = bloodstep_overlay = image(icon, "[blood_state]2", dir = Ddir)
			add_overlay(bloodstep_overlay)

	alpha = BLOODY_FOOTPRINT_BASE_ALPHA + bloodiness


/obj/effect/decal/cleanable/blood/footprints/examine(mob/user)
	. = ..()
	if(shoe_types.len)
		. += "You recognise the footprints as belonging to:"
		for(var/shoe in shoe_types)
			var/obj/item/clothing/shoes/S = shoe
			. += "some <B>[initial(S.name)]</B> [icon2html(initial(S.icon), user)]"

/obj/effect/decal/cleanable/blood/footprints/replace_decal(obj/effect/decal/cleanable/C)
	if(blood_state != C.blood_state) //We only replace footprints of the same type as us
		return
	if(color != C.color)
		return
	..()

/obj/effect/decal/cleanable/blood/footprints/can_bloodcrawl_in()
	if((blood_state != BLOOD_STATE_OIL) && (blood_state != BLOOD_STATE_NOT_BLOODY))
		return TRUE
	return FALSE

//cleanable here

/obj/effect/decal/cleanable/cum
	name = "cum"
	desc = "It's pie cream from a cream pie. Or not..."
	gender = PLURAL
	layer = ABOVE_NORMAL_TURF_LAYER
	density = 0
	icon = 'honk/icons/effects/cum.dmi'
	icon_state = "cum1"
	random_icon_states = list("cum1", "cum3", "cum4", "cum5", "cum6", "cum7", "cum8", "cum9", "cum10", "cum11", "cum12")
	mergeable_decal = TRUE
	blood_state = null
	bloodiness = null
	//var/blood_DNA = list()

/obj/effect/decal/cleanable/cum/Initialize()
	. = ..()
	dir = pick(1,2,4,8)
	reagents.add_reagent(/datum/reagent/consumable/semen, rand(8,13))
	add_blood_DNA(list("Unknown DNA" = "O+"))

/* Eventually TODO: make snowflake trails like baycode's
/obj/effect/decal/cleanable/blood/footprints/tracks/shoe
	name = "footprints"
	desc = "They look like tracks left by footwear."
	icon_state = FOOTPRINT_SHOE
	print_state = FOOTPRINT_SHOE

/obj/effect/decal/cleanable/blood/footprints/tracks/foot
	name = "footprints"
	desc = "They look like tracks left by a bare foot."
	icon_state = FOOTPRINT_FOOT
	print_state = FOOTPRINT_FOOT

/obj/effect/decal/cleanable/blood/footprints/tracks/snake
	name = "tracks"
	desc = "They look like tracks left by a giant snake."
	icon_state = FOOTPRINT_SNAKE
	print_state = FOOTPRINT_SNAKE

/obj/effect/decal/cleanable/blood/footprints/tracks/paw
	name = "footprints"
	desc = "They look like tracks left by paws."
	icon_state = FOOTPRINT_PAW
	print_state = FOOTPRINT_PAW

/obj/effect/decal/cleanable/blood/footprints/tracks/claw
	name = "footprints"
	desc = "They look like tracks left by claws."
	icon_state = FOOTPRINT_CLAW
	print_state = FOOTPRINT_CLAW

/obj/effect/decal/cleanable/blood/footprints/tracks/wheels
	name = "tracks"
	desc = "They look like tracks left by wheels."
	gender = PLURAL
	icon_state = FOOTPRINT_WHEEL
	print_state = FOOTPRINT_WHEEL

/obj/effect/decal/cleanable/blood/footprints/tracks/body
	name = "trails"
	desc = "A trail left by something being dragged."
	icon_state = FOOTPRINT_DRAG
	print_state = FOOTPRINT_DRAG */

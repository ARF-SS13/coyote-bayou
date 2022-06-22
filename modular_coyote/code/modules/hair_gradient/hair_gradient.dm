// Author: GremlingSS
// Not all of my work, it's porting over vorestation's gradient system into TG and adapting it basically.
// This is gonna be fun, wish me luck!~
//
// Also, as obligated to my coding standards, I must design a shitpost related to the code, but because it's hard to think of a meme
// I'm gonna just pull one out my ass and hope it's funny.

// Globals/helpers/randomness.
GLOBAL_LIST_INIT(hair_gradients, list(
	"None" = "none",
	"Fade (Up)" = "fadeup",
	"Fade (Down)" = "fadedown",
	"Fade Low (Up)" = "fadeup_low",
	"Bottom Flat" = "bottomflat",
	"Fade Low (Down)" = "fadedown_low",
	"Vertical Split" = "vsplit",
	"Reflected" = "reflected",
	"Reflected (Inverted)" = "reflected_inverse",
	"Reflected High" = "reflected_high",
	"Reflected High (Inverted)" = "reflected_inverse_high",
	"Wavy" = "wavy"
	))

random_features(intendedspecies, intended_gender)
	. = ..(intendedspecies, intended_gender)
	
	var/grad_color = random_color()

	var/list/output = .

	output += list(
		"grad_color"			= grad_color,
		"grad_style"			= pick(GLOB.hair_gradients))

	return output

randomize_human(mob/living/carbon/human/H)
//	H.dna.features["flavor_text"] = "" // I'm so tempted to put lorem ipsum in the flavor text so freaking badly please someone hold me back god.
	H.dna.features["grad_color"] = random_color()
	H.dna.features["grad_style"] = pick(GLOB.hair_gradients)
	..(H)

/mob/living/carbon/human/proc/change_hair_gradient(var/hair_gradient)
	if(dna.features["grad_style"] == "none")
		return

	if(dna.features["grad_style"] == hair_gradient)
		return

	if(!(hair_gradient in GLOB.hair_gradients))
		return

	dna.features["grad_style"] = hair_gradient

	update_hair()
	return 1


// Preferences + save file/copy_to and stuff.
/datum/preferences
	var/list/features_override = list("grad_style" = "none", "grad_color" = "FFFFFF")

/datum/preferences/load_character(slot)
	. = ..(slot)
	if(!(. == TRUE))
		return . // There's an error!!
	
	var/savefile/S = new /savefile(path)
	S.cd = "/"
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))

	S.cd = "/character[slot]"

	S["gradient_color"]		>> features_override["grad_color"]
	S["gradient_style"]		>> features_override["grad_style"]

	features_override["grad_color"]		= sanitize_hexcolor(features_override["grad_color"], 6, FALSE)
	features_override["grad_style"]		= sanitize_inlist(features_override["grad_style"], GLOB.hair_gradients)

	return 1


/datum/preferences/save_character()

	. = ..()

	if(!(. == TRUE))
		return . // erroooooooooooorrrrrrrrrrr
	
	var/savefile/S = new /savefile(path)
	if(!S)
		return 0
	
	S.cd = "/character[default_slot]"

	//Character
	WRITE_FILE(S["gradient_color"]			, features_override["grad_color"])
	WRITE_FILE(S["gradient_style"]			, features_override["grad_style"])

	return 1

/datum/preferences/process_link(mob/user, list/href_list)
	switch(href_list["task"])
		if("input")
			switch(href_list["preference"])
				if("grad_color")
					var/new_grad_color = input(user, "Choose your character's fading hair colour:", "Character Preference","#"+features_override["grad_color"]) as color|null
					if(new_grad_color)
						features_override["grad_color"] = sanitize_hexcolor(new_grad_color, 6)

				if("grad_style")
					var/new_grad_style
					new_grad_style = input(user, "Choose your character's hair fade style:", "Character Preference")  as null|anything in GLOB.hair_gradients
					if(new_grad_style)
						features_override["grad_style"] = new_grad_style
	..()

/datum/preferences/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, initial_spawn = FALSE)
	features |= features_override
	..()

// Hair update icon! The funnnnnn bit.................
/datum/species/handle_hair(mob/living/carbon/human/H, forced_colour)
	H.remove_overlay(HAIR_LAYER)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	if(!HD) //Decapitated
		return
	if(HAS_TRAIT(H, TRAIT_HUSK))
		return

	var/datum/sprite_accessory/S
	var/list/standing = list()

	var/hair_hidden = FALSE //ignored if the matching dynamic_X_suffix is non-empty
	var/facialhair_hidden = FALSE // ^

	var/dynamic_hair_suffix = "" //if this is non-null, and hair+suffix matches an iconstate, then we render that hair instead
	var/dynamic_fhair_suffix = ""

	//for augmented heads
	if(HD.status == BODYPART_ROBOTIC && !HD.render_like_organic)
		return

	//we check if our hat or helmet hides our facial hair.
	if(H.head)
		var/obj/item/I = H.head
		if(istype(I, /obj/item/clothing))
			var/obj/item/clothing/C = I
			dynamic_fhair_suffix = C.dynamic_fhair_suffix
		if(I.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.wear_mask && istype(H.wear_mask))
		var/obj/item/clothing/mask/M = H.wear_mask
		dynamic_fhair_suffix = M.dynamic_fhair_suffix //mask > head in terms of facial hair
		if(M.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.facial_hair_style && (FACEHAIR in species_traits) && (!facialhair_hidden || dynamic_fhair_suffix))
		S = GLOB.facial_hair_styles_list[H.facial_hair_style]
		if(S)
			//List of all valid dynamic_fhair_suffixes
			var/static/list/fextensions
			if(!fextensions)
				var/icon/fhair_extensions = icon('icons/mob/facialhair_extensions.dmi')
				fextensions = list()
				for(var/s in fhair_extensions.IconStates(1))
					fextensions[s] = TRUE
				qdel(fhair_extensions)

			//Is hair+dynamic_fhair_suffix a valid iconstate?
			var/fhair_state = S.icon_state
			var/fhair_file = S.icon
			if(fextensions[fhair_state+dynamic_fhair_suffix])
				fhair_state += dynamic_fhair_suffix
				fhair_file = 'icons/mob/facialhair_extensions.dmi'

			var/mutable_appearance/facial_overlay = mutable_appearance(fhair_file, fhair_state, -HAIR_LAYER)

			if(!forced_colour)
				if(hair_color)
					if(hair_color == "mutcolor")
						facial_overlay.color = "#" + H.dna.features["mcolor"]
					else
						facial_overlay.color = "#" + hair_color
				else
					facial_overlay.color = "#" + H.facial_hair_color
			else
				facial_overlay.color = forced_colour

			facial_overlay.alpha = hair_alpha

			if(OFFSET_FHAIR in H.dna.species.offset_features)
				facial_overlay.pixel_x += H.dna.species.offset_features[OFFSET_FHAIR][1]
				facial_overlay.pixel_y += H.dna.species.offset_features[OFFSET_FHAIR][2]

			standing += facial_overlay

	if(H.head)
		var/obj/item/I = H.head
		if(istype(I, /obj/item/clothing))
			var/obj/item/clothing/C = I
			dynamic_hair_suffix = C.dynamic_hair_suffix
		if(I.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(H.wear_mask && istype(H.wear_mask))
		var/obj/item/clothing/mask/M = H.wear_mask
		if(!dynamic_hair_suffix) //head > mask in terms of head hair
			dynamic_hair_suffix = M.dynamic_hair_suffix
		if(M.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(!hair_hidden || dynamic_hair_suffix)
		var/mutable_appearance/hair_overlay = mutable_appearance(layer = -HAIR_LAYER)
		if(!hair_hidden && !H.getorgan(/obj/item/organ/brain)) //Applies the debrained overlay if there is no brain
			if(!(NOBLOOD in species_traits))
				hair_overlay.icon = 'icons/mob/hair.dmi'
				hair_overlay.icon_state = "debrained"

		else if(H.hair_style && (HAIR in species_traits))
			S = GLOB.hair_styles_list[H.hair_style]
			if(S)
				//List of all valid dynamic_hair_suffixes
				var/static/list/extensions
				if(!extensions)
					var/icon/hair_extensions = icon('icons/mob/hair_extensions.dmi') //hehe
					extensions = list()
					for(var/s in hair_extensions.IconStates(1))
						extensions[s] = TRUE
					qdel(hair_extensions)

				//Is hair+dynamic_hair_suffix a valid iconstate?
				var/hair_state = S.icon_state
				var/hair_file = S.icon
				if(extensions[hair_state+dynamic_hair_suffix])
					hair_state += dynamic_hair_suffix
					hair_file = 'icons/mob/hair_extensions.dmi'

				hair_overlay.icon = hair_file
				hair_overlay.icon_state = hair_state

				if(!forced_colour)
					if(hair_color)
						if(hair_color == "mutcolor")
							hair_overlay.color = "#" + H.dna.features["mcolor"]
						else
							hair_overlay.color = "#" + hair_color
					else
						hair_overlay.color = "#" + H.hair_color
				else
					hair_overlay.color = forced_colour
				hair_overlay.alpha = hair_alpha

				var/icon/grad_s = null

				if(H.dna.features["grad_style"] != "none")
					grad_s = new/icon("icon" = 'modular_coyote/icons/mob/hair_gradients.dmi', "icon_state" = GLOB.hair_gradients[H.dna.features["grad_style"]])
					grad_s.Blend(hair_overlay, ICON_AND)
					grad_s.Blend(H.dna.features["grad_color"], ICON_MULTIPLY)

				if(OFFSET_HAIR in H.dna.species.offset_features)
					hair_overlay.pixel_x += H.dna.species.offset_features[OFFSET_HAIR][1]
					hair_overlay.pixel_y += H.dna.species.offset_features[OFFSET_HAIR][2]

		if(hair_overlay.icon)
			standing += hair_overlay

	if(standing.len)
		H.overlays_standing[HAIR_LAYER] = standing

	H.apply_overlay(HAIR_LAYER)

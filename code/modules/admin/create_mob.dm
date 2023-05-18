
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

/proc/randomize_human(mob/living/carbon/human/H, species)
	H.gender = pick(MALE, FEMALE)
	H.real_name = random_unique_name(H.gender)
	H.name = H.real_name
	H.underwear = random_underwear(H.gender)
	H.undie_color = random_short_color()
	H.undershirt = random_undershirt(H.gender)
	H.shirt_color = random_short_color()
	H.dna.skin_tone_override = null
	H.skin_tone = random_skin_tone()
	H.hair_style = random_hair_style(H.gender)
	H.facial_hair_style = random_facial_hair_style(H.gender)
	H.hair_color = random_short_color()
	H.facial_hair_color = H.hair_color
	var/random_eye_color = random_eye_color()
	H.left_eye_color = random_eye_color
	H.right_eye_color = random_eye_color
	H.dna.blood_type = random_blood_type()
	H.saved_underwear = H.underwear
	H.saved_undershirt = H.undershirt
	H.saved_socks = H.socks

	// Mutant randomizing, doesn't affect the mob appearance unless it's the specific mutant.
	H.dna.features[FEATURE_COLOR_1] = random_short_color()
	H.dna.features[MBP_TAIL_LIZARD] = pick(GLOB.tails_list_lizard)
	H.dna.features[MBP_SNOUT_LIZARD] = pick(GLOB.snouts_list)
	H.dna.features[MBP_HORNS] = pick(GLOB.horns_list)
	H.dna.features[MBP_FRILLS] = pick(GLOB.frills_list)
	H.dna.features[MBP_TAIL_SPINES] = pick(GLOB.spines_list)
	H.dna.features[MBP_WINGS_INSECT] = pick(GLOB.insect_wings_list)
	H.dna.features[MBP_WINGS_DECORATIVE] = pick(GLOB.deco_wings_list)
	H.dna.features[MBP_FLUFF] = ACCESSORY_NONE
	H.dna.features[FEATURE_COLOR_1] = "FFF"
	H.dna.features[FEATURE_COLOR_2] = "FFF"
	H.dna.features[FEATURE_COLOR_3] = "FFF"
	H.dna.features[MBP_TAIL_LIZARD] = ACCESSORY_NONE
	H.dna.features[MBP_LEGS] = "Plantigrade"
	H.dna.features[MBP_SNOUT_LIZARD] = ACCESSORY_NONE
	H.dna.features[MBP_HORNS] = ACCESSORY_NONE
	H.dna.features[MBP_FRILLS] = ACCESSORY_NONE
	H.dna.features[MBP_TAIL_SPINES] = ACCESSORY_NONE
	H.dna.features[MBP_WINGS_INSECT] = ACCESSORY_NONE
	H.dna.features[MBP_WINGS_DECORATIVE] = ACCESSORY_NONE
	H.dna.features[MBP_FLUFF] = ACCESSORY_NONE
	H.dna.features["flavor_text"] = "" //Oh no.
	H.dna.features["body_model"] = H.gender

	// Mutant randomizing, doesn't affect the mob appearance unless it's the specific mutant.
	var/species_type = pick("human", "lizard", "furry")
	if(species)
		if(ispath(species, /datum/species/human))
			species_type = "human"
		else if(ispath(species, /datum/species/lizard))
			species_type = "lizard"
		else if(ispath(species, /datum/species/mammal))
			species_type = "furry"
	switch(species_type)
		if("human")
			H.set_species(/datum/species/human)
			var/tone = pick(GLOB.skin_tones)
			H.dna.features["mcolor"] = GLOB.skin_tones[tone]
		if("lizard")
			H.set_species(/datum/species/lizard)
			H.dna.features["mcolor"] = random_short_color()
			H.dna.features["mcolor2"] = random_short_color()
			H.dna.features["mcolor3"] = random_short_color()
			H.dna.features["tail_lizard"] = pick(GLOB.tails_list_lizard)
			H.dna.features["snout"] = pick(GLOB.snouts_list)
			H.dna.features["horns"] = pick(GLOB.horns_list)
			H.dna.features["frills"] = pick(GLOB.frills_list)
			H.dna.features["spines"] = pick(GLOB.spines_list)
			H.dna.features["legs"] = "Digitigrade"
		if("furry")
			H.set_species(pick(typesof(/datum/species/mammal)))
			H.dna.features["mcolor"] = random_short_color()
			H.dna.features["mcolor2"] = random_short_color()
			H.dna.features["mcolor3"] = random_short_color()
			H.dna.features["tail_mam"] = pick(GLOB.mam_tails_list)
			H.dna.features["ears"] = pick(GLOB.mam_ears_list)
			H.dna.features["snout"] = pick(GLOB.mam_snouts_list)
			H.dna.features["horns"] = pick(GLOB.horns_list)
			H.dna.features["legs"] = "Digitigrade"
		// if("moth")
		// 	H.set_species(/datum/species/moth)
		// 	H.dna.features["mcolor"] = random_short_color()
		// 	H.dna.features["mcolor2"] = random_short_color()
		// 	H.dna.features["mcolor3"] = random_short_color()
		// 	H.dna.features["tail_mam"] = pick(GLOB.mam_tails_list)
		// 	H.dna.features["ears"] = pick(GLOB.mam_ears_list)
		// 	H.dna.features["snout"] = pick(GLOB.mam_snouts_list)
		// 	H.dna.features["horns"] = pick(GLOB.horns_list)
		// 	H.dna.features["insect_wings"] = pick(GLOB.insect_wings_list)
		// 	H.dna.features["deco_wings"] = pick(GLOB.deco_wings_list)
		// 	H.dna.features["insect_fluff"] = pick(GLOB.insect_fluffs_list)
		// 	H.dna.features["legs"] = "Digitigrade"


	SEND_SIGNAL(H, COMSIG_HUMAN_ON_RANDOMIZE)

	H.update_body(TRUE)
	H.update_hair()
	H.update_body_parts()

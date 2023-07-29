
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

/mob/living/carbon/human/proc/randomize(species, undies, genitals)
	return randomize_human(src, species, undies, genitals)

/proc/randomize_human(mob/living/carbon/human/H, species, undies = TRUE, genitals)
	if(!ishuman(H))
		return
	H.gender = pick(MALE, FEMALE)
	H.real_name = random_unique_name(H.gender)
	H.name = H.real_name
	if(undies)
		H.underwear = random_underwear(H.gender)
		H.undershirt = random_undershirt(H.gender)
		H.socks = random_socks(H.gender)
	else
		H.underwear = "Nude"
		H.undershirt = "Nude"
		H.socks = "Nude"
	H.undie_color = random_short_color()
	H.shirt_color = random_short_color()
	H.socks_color = random_short_color()
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

	H.dna.features["mcolor"] = "FFF"
	H.dna.features["mcolor2"] = "FFF"
	H.dna.features["mcolor3"] = "FFF"
	H.dna.features["tail_lizard"] = "None"
	H.dna.features["legs"] = "Plantigrade"
	H.dna.features["snout"] = "None"
	H.dna.features["horns"] = "None"
	H.dna.features["frills"] = "None"
	H.dna.features["spines"] = "None"
	H.dna.features["insect_wings"] = "None"
	H.dna.features["deco_wings"] = "None"
	H.dna.features["insect_fluff"] = "None"
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
	if(genitals)
		var/static/list/boob_cup_sizes
		if(!boob_cup_sizes)
			var/list/L = CONFIG_GET(keyed_list/breasts_cups_prefs)
			boob_cup_sizes = L.Copy()
		var/static/penis_inches_min
		if(!penis_inches_min)
			penis_inches_min = CONFIG_GET(number/penis_min_inches_prefs)
		var/static/penis_inches_max
		if(!penis_inches_max)
			penis_inches_max = CONFIG_GET(number/penis_max_inches_prefs)
		var/static/butt_size_min
		if(!butt_size_min)
			butt_size_min = CONFIG_GET(number/butt_min_size_prefs)
		var/static/butt_size_max
		if(!butt_size_max)
			butt_size_max = CONFIG_GET(number/butt_max_size_prefs)
		var/static/belly_size_min
		if(!belly_size_min)
			belly_size_min = CONFIG_GET(number/belly_min_size_prefs)
		var/static/belly_size_max
		if(!belly_size_max)
			belly_size_max = CONFIG_GET(number/belly_max_size_prefs)
		if(prob(50))
			H.dna.features["has_butt"] = TRUE
			H.dna.features["butt_color"] = H.dna.features["mcolor"]
			H.dna.features["butt_size"] = GaussianRangePicker(butt_size_min, butt_size_max, 4, 3)
			if(prob(80))
				H.dna.features["has_belly"] = TRUE
				H.dna.features["belly_color"] = H.dna.features["mcolor"]
				H.dna.features["belly_size"] = GaussianRangePicker(belly_size_min, belly_size_max, 4, 3)
				H.dna.features["belly_shape"] = pick(GLOB.belly_shapes_list)
		if(H.gender == FEMALE || H.gender == NEUTER || H.gender == PLURAL || prob(10))
			H.dna.features["has_vag"] = TRUE // they only get the normal vag cus the rest are scary D:
			H.dna.features["vag_color"] = H.dna.features["mcolor"]

			H.dna.features["has_womb"] = TRUE

			H.dna.features["has_breasts"] = TRUE
			H.dna.features["breasts_color"] = H.dna.features["mcolor"]
			H.dna.features["breasts_size"] = GaussianListPicker(boob_cup_sizes, 5, 2) // The wasteland has a buxomness epidemic
		if(H.gender == MALE || H.gender == NEUTER || H.gender == PLURAL || prob(10))
			H.dna.features["has_balls"] = TRUE
			H.dna.features["balls_color"] = H.dna.features["mcolor"]

			H.dna.features["has_cock"] = TRUE
			H.dna.features["cock_size"] = GaussianRangePicker(penis_inches_min, penis_inches_max, 7, 3) // fuck it, everyone's got a HUUUUUGE COCK =3
			H.dna.features["cock_shape"] = pick(GLOB.cock_shapes_list)
		H.give_genitals(TRUE)
	SEND_SIGNAL(H, COMSIG_HUMAN_ON_RANDOMIZE)

	H.update_body(TRUE)
	H.update_hair()
	H.update_body_parts()

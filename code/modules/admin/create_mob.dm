
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

/proc/randomize_human(mob/living/carbon/human/H)
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
	H.dna.features[MBP_COLOR1] = random_short_color()
	H.dna.features[MBP_TAIL_LIZARD] = pick(GLOB.tails_list_lizard)
	H.dna.features[MBP_SNOUT_LIZARD] = pick(GLOB.snouts_list)
	H.dna.features[MBP_HORNS] = pick(GLOB.horns_list)
	H.dna.features[MBP_FRILLS] = pick(GLOB.frills_list)
	H.dna.features[MBP_TAIL_SPINES] = pick(GLOB.spines_list)
	H.dna.features[MBP_WINGS_INSECT] = pick(GLOB.insect_wings_list)
	H.dna.features[MBP_WINGS_DECORATIVE] = pick(GLOB.deco_wings_list)
	H.dna.features[MBP_FLUFF] = pick(GLOB.insect_fluffs_list)
	H.dna.features["flavor_text"] = "" //Oh no.
	H.dna.features["body_model"] = H.gender

	SEND_SIGNAL(H, COMSIG_HUMAN_ON_RANDOMIZE)

	H.update_body(TRUE)
	H.update_hair()
	H.update_body_parts()

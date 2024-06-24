
	//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/random_character(gender_override)
	if(gender_override)
		gender = gender_override
	else
		gender = pick(MALE, FEMALE)
	real_name = random_unique_name(gender)
	underwear = "Nude"
	undershirt = "Nude"
	socks = "Nude"
	undie_color = "5e5e5e"
	shirt_color = "5e5e5e"
	socks_color = "5e5e5e"
	skin_tone = random_skin_tone()
	hair_style = "Bedhead"
	facial_hair_style = "Shaved"
	hair_color = random_short_color()
	facial_hair_color = hair_color
	var/random_eye_color = "000000"
	left_eye_color = random_eye_color
	right_eye_color = random_eye_color

	features["mcolor"] = "CCCCCC"
	features["mcolor2"] = "EEEEEE"
	features["mcolor3"] = "777777"
	features["tail_lizard"] = "None"
	features["snout"] = "None"
	features["horns"] = "None"
	features["frills"] = "None"
	features["spines"] = "None"
	features["insect_wings"] = "None"
	features["deco_wings"] = "None"
	features["insect_fluff"] = "None"
	features["flavor_text"] = "" //Oh no.
	features["body_model"] = gender

	pref_species = new /datum/species/mammal()
	features["tail"] = "Fox"
	features["tail_lizard"] = "Fox"
	features["tail_human"] = "Fox"
	features["mam_tail_animated"] = "Fox"
	features["ears"] = "Fox"
	features["mam_ears"] = "Fox"
	features["snout"] = "Mammal, Long"
	features["mam_snouts"] = "Mammal, Long"
	features["legs"] = "Digitigrade"

/datum/preferences/proc/update_preview_icon(current_tab)
	var/equip_job = TRUE
	switch(current_tab)
		if(APPEARANCE_TAB)
			equip_job = FALSE
		if(ERP_TAB)
			equip_job = FALSE
	// Determine what job is marked as 'High' priority, and dress them up as such.
	var/datum/job/previewJob = get_highest_job()

	if(previewJob)
		// Silicons only need a very basic preview since there is no customization for them.
		if(istype(previewJob,/datum/job/ai))
			parent.show_character_previews(image('icons/mob/ai.dmi', icon_state = resolve_ai_icon(preferred_ai_core_display), dir = SOUTH))
			return
		if(istype(previewJob,/datum/job/cyborg))
			parent.show_character_previews(image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH))
			return

	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = SSdummy.get_a_dummy()
	mannequin.cut_overlays()  //this line needs to stay here to cut out all genitals showing up in the character preview
	// Apply the Dummy's preview background first so we properly layer everything else on top of it.
	var/image/the_floor = image('modular_citadel/icons/ui/backgrounds.dmi', mannequin, bgstate, layer = SPACE_LAYER)
	the_floor.appearance_flags |= (RESET_TRANSFORM | KEEP_APART)
	mannequin.add_overlay(the_floor)
	copy_to(mannequin, initial_spawn = TRUE, sans_underpants = preview_hide_undies)

	if(current_tab == LOADOUT_TAB)
		//give it its loadout if not on the appearance tab
		SSjob.equip_loadout(parent.mob, mannequin, FALSE, bypass_prereqs = TRUE, can_drop = FALSE)
	else
		if(previewJob && equip_job)
			mannequin.job = previewJob.title
			previewJob.equip(mannequin, TRUE, preference_source = parent)

	mannequin.regenerate_icons()
	COMPILE_OVERLAYS(mannequin)

	parent.show_character_previews(new /mutable_appearance(mannequin))
	SSdummy.return_dummy(mannequin)

/datum/preferences/proc/get_highest_job()
	var/highest_pref = 0
	var/datum/job/highest_job
	for(var/job in job_preferences)
		if(job_preferences["[job]"] > highest_pref)
			highest_job = SSjob.GetJob(job)
			highest_pref = job_preferences["[job]"]
	return highest_job

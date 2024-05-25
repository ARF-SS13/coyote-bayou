
	//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/random_character(gender_override)
	if(gender_override)
		gender = gender_override
	else
		gender = MALE
	underwear = "Boxers"
	undie_color = random_clothing_dye()
	undershirt = "Shirt - Short Sleeved"
	shirt_color = random_clothing_dye()
	socks = "Short"
	socks_color = random_clothing_dye()
	use_custom_skin_tone = FALSE
	skin_tone = pick("latino", "mediterranean")
	hair_style = pick("Trimmed", "Fade (Low)")
	facial_hair_style = pick("Beard (5 o\'Clock)", "Beard (3 o\'Clock)")
	hair_color = random_hair_shade()
	facial_hair_color = random_hair_shade()
	left_eye_color = random_dark_shade()
	right_eye_color = random_dark_shade()
	age = (rand(20, 25))


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

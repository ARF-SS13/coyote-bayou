/// A screenshot test for every humanoid species with a handful of jobs.
/datum/unit_test/screenshot_humanoids

/datum/unit_test/screenshot_humanoids/Run()
	for (var/datum/species/species_type as anything in subtypesof(/datum/species))
		test_screenshot("[species_type]", get_flat_icon_for_all_directions(make_dummy(species_type, /datum/outfit/job/wasteland/f13wastelander)))

/datum/unit_test/screenshot_humanoids/proc/get_flat_icon_for_all_directions(atom/thing)
	var/icon/output = icon('icons/effects/effects.dmi', "nothing")
	COMPILE_OVERLAYS(thing)

	for (var/direction in GLOB.cardinals)
		var/icon/partial = getFlatIcon(thing, defdir = direction, no_anim = TRUE)
		output.Insert(partial, dir = direction)

	return output

/datum/unit_test/screenshot_humanoids/proc/make_dummy(species, job_outfit)
	var/mob/living/carbon/human/dummy/consistent/dummy = allocate(/mob/living/carbon/human/dummy/consistent)
	dummy.set_species(species)
	dummy.equipOutfit(job_outfit, visualsOnly = TRUE)
	return dummy

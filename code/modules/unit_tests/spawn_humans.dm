/datum/unit_test/spawn_humans/Run()
	for(var/I in 1 to 5)
		allocate(/mob/living/carbon/human)

	sleep(50)

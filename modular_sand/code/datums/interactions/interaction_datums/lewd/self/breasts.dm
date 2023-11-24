/datum/interaction/lewd/titgrope_self
	description = "Self/Body - Grope your own breasts."
	require_user_hands = TRUE
	require_user_breasts = REQUIRE_ANY
	is_self_action = TRUE
	max_distance = 0
	write_log_user = "groped own breasts"
	write_log_target = null

	help_messages = list(
		"XU_NAME gently gropes XU_THEIR breast",
		"XU_NAME softly squeezes XU_THEIR breasts",
		"XU_NAME grips XU_THEIR breasts",
		"XU_NAME runs a few fingers over XU_THEIR breast",
		"XU_NAME delicately teases XU_THEIR nipple",
		"XU_NAME traces a touch across XU_THEIR breast"
	)
	// disarm_messages = list("XU_NAME is really rubbing at XU_THEIR own rear end.") // leaving thease out mean that
	// grab_messages = list("XU_NAME is rubbing XU_THEIR backside pretty aggressively!") // all but harm will do the help words!!!
	harm_messages = list(
		"XU_NAME aggressively gropes XU_THEIR breast",
		"XU_NAME grabs XU_THEIR breasts",
		"XU_NAME tightly squeezes XU_THEIR breasts",
		"XU_NAME slaps at XU_THEIR breasts",
		"XU_NAME gropes XU_THEIR breasts roughly"
	)

	simple_sounds = list('sound/weapons/thudswoosh.ogg') // frumf, frumf
	user_lust_mult = 1.0 // this ONE trick will make you cum in 5 seconds! doctors hate it!
	lust_go_to = LUST_USER | LUST_TARGET

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)
/*
/datum/interaction/lewd/titgrope_self/do_action(mob/living/user, mob/living/target, discrete = FALSE, list/extra = list())
	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item


	if(liquid_container)

		var/obj/item/organ/genital/breasts/milkers = user.getorganslot(ORGAN_SLOT_BREASTS)
		var/milktype = milkers?.fluid_id

		// if(milkers && milktype)
		// 	var/modifier
		// 	switch(milkers.size)
		// 		if(3 to 5)
		// 			modifier = 2
		// 		if(6 to 8)
		// 			modifier = 3
		// 		else
		// 			if(milkers.size_to_state() in GLOB.breast_values)
		// 				modifier = clamp(GLOB.breast_values[milkers.size_to_state()] - 5, 0, INFINITY)
		// 			else
		// 				modifier = 1
		liquid_container.reagents.add_reagent(milktype, rand(1,3))
*/

/datum/interaction/lewd/self_nipsuck
	description = "Self/Body - Suck your own nips."
	require_user_breasts = REQUIRE_ANY
	require_user_mouth = TRUE
	is_self_action = TRUE
	simple_sounds = null
	max_distance = 0
	write_log_user = "sucked their own nips"
	write_log_target = null
	simple_messages = list(
		"XU_NAME brings XU_THEIR own milk tanks to XU_THEIR mouth and sucks deeply into them",
		"XU_NAME takes a big sip of XU_THEIR own fresh milk",
		"XU_NAME fills XU_THEIR own mouth with a big gulp of XU_THEIR warm milk"
	)
	user_lust_mult = 1
	lust_go_to = LUST_USER | LUST_TARGET

/datum/interaction/lewd/self_nipsuck/interaction_message(mob/living/user, mob/living/target)
	var/obj/item/organ/genital/breasts/milkers = user.getorganslot(ORGAN_SLOT_BREASTS)
	var/milktype = milkers?.fluid_id
	var/modifier

	if(!milkers || !milktype)
		return


	// var/milktext = milk.name

	switch(milkers.size)
		if("c", "d", "e")
			modifier = 2
		if("f", "g", "h")
			modifier = 3
		else
			if(milkers.size in GLOB.breast_values)
				modifier = clamp(GLOB.breast_values[milkers.size] - 5, 0, INFINITY)
			else
				modifier = 1
	user.reagents.add_reagent(milktype, rand(1,3 * modifier) * user.get_fluid_mod(milkers)) //SPLURT edit

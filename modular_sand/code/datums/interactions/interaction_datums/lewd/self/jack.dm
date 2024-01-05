/datum/interaction/lewd/jack
	description = "Self/Crotch - Jerk your cock off."
	simple_sounds = null
	require_user_hands = TRUE
	require_user_penis = REQUIRE_ANY
	is_self_action = TRUE
	max_distance = 0
	write_log_user = "jerked off"
	write_log_target = null

	help_messages = list(
		"XU_NAME shakes XU_THEIR XU_PENIS playfully!",
		"XU_NAME rubs XU_THEIR XU_PENIS gently!",
		"XU_NAME carefully grasps XU_THEIR own XU_PENIS!",
		"XU_NAME is gently stroking XU_THEIR XU_PENIS!",
	)
	disarm_messages = list(
		"XU_NAME shakes XU_THEIR XU_PENIS like a lure!",
		"XU_NAME fucks XU_THEIR own hand slowly!",
		"XU_NAME lifts XU_THEIR XU_PENIS up and gives it a shake!",
		"XU_NAME rubs a finger down XU_THEIR own XU_PENIS!",
	)
	grab_messages = list(
		"XU_NAME is really cranking XU_THEIR XU_PENIS!",
		"XU_NAME works XU_THEIR XU_PENIS over!",
		"XU_NAME is really getting into playing XU_THEIR own XU_PENIS!",
		"XU_NAME is dribbling a bit from XU_THEIR XU_PENIS as XU_THEIR plays with himself!",
	)
	harm_messages = list(
		"XU_NAME is beating XU_THEIR meat!",
		"XU_NAME is really jerking XU_THEIR gerhkin!",
		"XU_NAME groans as they fuck their hand hard!",
		"XU_NAME cuts off a groan as XU_THEIR XU_PENIS twitches from their own self-affection!", // my strapon twitches from self-satisfaction
	)

	simple_sounds = list(
		'modular_sand/sound/interactions/bang1.ogg',
		'modular_sand/sound/interactions/bang2.ogg',
		'modular_sand/sound/interactions/bang3.ogg'
	) // frumf, frumf
	user_lust_mult = 1
	lust_go_to = LUST_USER | LUST_TARGET

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)

// /datum/interaction/lewd/jack/interaction_message(mob/living/user, mob/living/target, show_message)
// 	var/obj/item/reagent_containers/liquid_container

// 	var/obj/item/cached_item = user.get_active_held_item()
// 	if(istype(cached_item, /obj/item/reagent_containers))
// 		liquid_container = cached_item
// 	else
// 		cached_item = user.pulling
// 		if(istype(cached_item, /obj/item/reagent_containers))
// 			liquid_container = cached_item

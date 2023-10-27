/datum/interaction/lewd/jack
	description = "Self/Penis - Jerk yourself off."
	interaction_sound = null
	require_user_hands = TRUE
	require_user_penis = REQUIRE_ANY
	user_is_target = TRUE
	max_distance = 0
	write_log_user = "jerked off"
	write_log_target = null

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)

/datum/interaction/lewd/jack/display_interaction(mob/living/user)
	var/message
	var/t_His = user.p_their()
	var/t_Him = user.p_them()
	var/genital_name = user.get_penetrating_genital_name()

	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

//help intent should be gentle, downright even loving and probably the opener for situations
		if(user.a_intent == INTENT_HELP)
			message = pick(
			"shakes [t_His] cock playfully!",
			"rubs [t_His] shaft gently!",
			"carefully grasps [t_His] own cock!",
			"is gently stroking [t_His] shaft!",
			)

//disarm intent should be used for being particularly playful with the interaction
		else if(user.a_intent == INTENT_DISARM)
			message = pick(
				"shakes [t_His] cock like a lure!",
				"fucks [t_His] own hand slowly!",
				"lifts [t_His] shaft up and gives it a shake!",
				"rubs a finger down [t_His] own cock!",
			)

//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
		else if(user.a_intent == INTENT_GRAB)
			message = pick(
				"is really cranking [t_His] cock!",
				"works [t_His] cock over!",
				"is really getting into playing [t_His] own cock!",
				"is dribbling a bit from [t_His] cock as [t_His] plays with himself!",
			)

//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
		else if(user.a_intent == INTENT_HARM)
			message = pick(
				"is beating [t_His] meat!",
				"is really jerking [t_His] gerhkin!",
				"groans as they fuck their hand hard!",
				"cuts off a groan as [t_His] cock twitches from their own self-affection!",
				)

	if(liquid_container)
		message += " over \the [liquid_container]"

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/bang1.ogg',
						'modular_sand/sound/interactions/bang2.ogg',
						'modular_sand/sound/interactions/bang3.ogg'), 70, 1, -1)
	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	if(user.can_penetrating_genital_cum())
		user.handle_post_sex(NORMAL_LUST, CUM_TARGET_HAND, liquid_container ? liquid_container : user, ORGAN_SLOT_PENIS) //SPLURT edit

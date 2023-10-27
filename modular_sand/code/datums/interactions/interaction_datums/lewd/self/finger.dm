/datum/interaction/lewd/fingerass_self
	description = "Finger your own butthole."
	interaction_sound = null
	require_user_hands = TRUE
	require_user_anus = REQUIRE_ANY
	user_is_target = TRUE
	max_distance = 0
	write_log_user = "fingered self"
	write_log_target = null

/datum/interaction/lewd/fingerass_self/display_interaction(mob/living/user)
	var/t_His = user.p_their()
	var/t_Him = user.p_them()

	user.visible_message(span_love("<b>\The [user]</b> [pick(
		"fingers [t_Him]self.",
		"fingers [t_His] asshole.",
		"fingers [t_Him]self hard.")]"), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_HAND, user, "anus") //SPLURT edit

/datum/interaction/lewd/finger_self
	description = "Finger your own pussy."
	require_user_hands = TRUE
	require_user_vagina = REQUIRE_ANY
	interaction_sound = null
	user_is_target = TRUE
	max_distance = 0
	write_log_user = "fingered own pussy"
	write_log_target = null

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)

/datum/interaction/lewd/finger_self/display_interaction(mob/living/user)
	var/t_His = user.p_their()
	var/message
	var/lust_amt

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
			lust_amt = LOW_LUST
			message = pick(
			"teases a finger around [t_His] labia!",
			"rubs [t_His] pussy gently!",
			"very lightly gives [t_His] own pussy a tap!",
			"is gently rubbing [t_His] nether lips!",
			)

//disarm intent should be used for being particularly playful with the interaction
		else if(user.a_intent == INTENT_DISARM)
			lust_amt = SOME_LUST
			message = pick(
				"teasingly fingers [t_His] pussy!",
				"explores [t_His] own love canal playfully!",
				"spreads [t_His] pussy lips, clearly enjoying themselves!",
				"rubs a circle around [t_His] labia, teasing themselves!",
			)

//grab intent should be used for playing rough, without actually being particulalry cruel or aggressive in said action
		else if(user.a_intent == INTENT_GRAB)
			lust_amt = SOME_MORE_LUST
			message = pick(
				"gives [t_His] pussy a playful slap!",
				"fingers [t_His] honeypot thoroughly.",
				"is really getting up in [t_His] own pussy!",
				"is soaking [t_His] fingers in their own juices as they play with themselves!",
			)

//harm intent should be very aggressive, maybe even causing limited damage, even to ones self.  Probably stamina damage though, to avoid sexual self murder
		else if(user.a_intent == INTENT_HARM)
			lust_amt = NORMAL_LUST
			message = pick(
				"slaps [t_His] pussy lips hard!",
				"is fingering [t_His] pussy like [t_His] depends on it!",
				"groans as they fingerfuck their pussy messily!",
				"fingers [t_His] pussy so hard them begins to shake!",
				"is fingering [t_His] pussy like it owes them money!",
				)

	if(prob(5 + user.get_lust()))
		user.visible_message(span_love("<b>\The [user]</b> [pick(
				"shivers in arousal.",
				"moans quietly.",
				"breathes out a soft moan.",
				"gasps.",
				"shudders softly.",
				"trembles as [t_His] hands run across bare skin.")]"))


	if(!user.is_fucking(user, CUM_TARGET_HAND, user.getorganslot(ORGAN_SLOT_VAGINA)))
		user.set_is_fucking(user, CUM_TARGET_HAND, user.getorganslot(ORGAN_SLOT_VAGINA))

	if(liquid_container)
		message += " over \the [liquid_container]"

	user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'modular_sand/sound/interactions/champ_fingering.ogg', 50, 1, -1)
	user.handle_post_sex(CUM_TARGET_HAND, liquid_container ? liquid_container : user, ORGAN_SLOT_VAGINA)

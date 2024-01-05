/datum/interaction/lewd/finger
	description = "Partner/Crotch - Finger their pussy."
	require_user_hands = TRUE
	require_target_vagina = REQUIRE_ANY
	simple_sounds = null
	max_distance = 1

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)

/datum/interaction/lewd/finger/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	var/message = "[pick("fingers \the <b>[partner]</b>",
		"fingers \the <b>[partner]</b>'s pussy",
		"fingers \the <b>[partner]</b> hard")]"

	if(!partner.is_fucking(user, CUM_TARGET_HAND, partner.getorganslot(ORGAN_SLOT_VAGINA)))
		partner.set_is_fucking(user, CUM_TARGET_HAND, partner.getorganslot(ORGAN_SLOT_VAGINA))

	if(liquid_container)
		message += " over \the [liquid_container]"

	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 40, 1, -1)
	partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_HAND, liquid_container ? liquid_container : user, ORGAN_SLOT_VAGINA) //SPLURT edit

/datum/interaction/lewd/fingerass
	description = "Partner/Crotch - Finger their ass."
	simple_sounds = null
	require_user_hands = TRUE
	require_target_anus = REQUIRE_ANY
	max_distance = 1

/datum/interaction/lewd/fingerass/interaction_message(mob/living/user, mob/living/partner, show_message)
	if(show_message)
		user.visible_message("<span class='lewd'><b>\The [user]</b> [pick("fingers \the <b>[partner]</b>.",
			"fingers \the <b>[partner]</b>'s asshole.",
			"fingers \the <b>[partner]</b> hard.")]</span>", ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 40, 1, -1)
	partner.handle_post_sex(NORMAL_LUST, null, user, "anus") //SPLURT edit

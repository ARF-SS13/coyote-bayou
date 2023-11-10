/datum/interaction/lewd/handjob
	description = "Partner/Crotch - Jerk them off."
	simple_sounds = null
	require_user_hands = TRUE
	require_target_penis = REQUIRE_ANY
	max_distance = 1

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)

/datum/interaction/lewd/handjob/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message
	var/u_His = user.p_their()
	var/genital_name = partner.get_penetrating_genital_name()

	var/obj/item/reagent_containers/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item, /obj/item/reagent_containers))
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item, /obj/item/reagent_containers))
			liquid_container = cached_item

	if(partner.is_fucking(user, CUM_TARGET_HAND, partner.getorganslot(ORGAN_SLOT_PENIS)))
		message = "[pick("jerks \the <b>[partner]</b> off",
			"works \the <b>[partner]</b>'s shaft",
			"wanks \the <b>[partner]</b>'s [genital_name] hard")]"
	else
		message = "[pick("wraps [u_His] hand around \the <b>[partner]</b>'s [genital_name]",
			"starts playing with \the <b>[partner]</b>'s [genital_name]")]"
		partner.set_is_fucking(user, CUM_TARGET_HAND, partner.getorganslot(ORGAN_SLOT_PENIS))
	if(liquid_container)
		message += " over \the [liquid_container]"

	playlewdinteractionsound(get_turf(user), pick('sound/f13effects/sunsetsounds/blush.ogg'), 40, 1, -1)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]."), ignored_mobs = user.get_unconsenting())
	if(partner.can_penetrating_genital_cum())
		partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_HAND, liquid_container ? liquid_container : user, ORGAN_SLOT_PENIS) //SPLURT edit

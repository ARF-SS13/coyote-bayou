/datum/interaction/lewd/frotting
	description = "Partner/Crotch - Frotting"
	require_user_penis = REQUIRE_ANY
	require_target_penis = REQUIRE_ANY
	max_distance = 1
	write_log_user = "frotted"
	write_log_target = "was frotted by"
	simple_sounds = null

/datum/interaction/lewd/frotting/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message
	var/t_His = user.p_their()
	var/genital_name = user.get_penetrating_genital_name()

	message = "rubs [t_His] [genital_name] against [partner]'s."
	user.set_is_fucking(partner, CUM_TARGET_PENIS, user.getorganslot(ORGAN_SLOT_PENIS))
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	if(user.can_penetrating_genital_cum())
		user.handle_post_sex(NORMAL_LUST, CUM_TARGET_PENIS, partner, ORGAN_SLOT_PENIS) //SPLURT edit
	if(partner.can_penetrating_genital_cum())
		partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_PENIS, user, ORGAN_SLOT_PENIS) //SPLURT edit

/datum/interaction/lewd/tribadism
	description = "Partner/Crotch -Grind pussies together."
	simple_sounds = null
	require_target_vagina = REQUIRE_ANY
	require_user_vagina = REQUIRE_ANY
	max_distance = 1

/datum/interaction/lewd/tribadism/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message

	var/u_His = user.p_their()

	if(partner.is_fucking(user, CUM_TARGET_VAGINA))
		message = "[pick("grinds [u_His] pussy against \the <b>[partner]</b>'s cunt.",
			"rubs [u_His] cunt against \the <b>[partner]</b>'s pussy.",
			"thrusts against \the <b>[partner]</b>'s pussy.",
			"humps \the <b>[partner]</b>, [u_His] pussies grinding against each other.")]"
	else
		message = "presses [u_His] pussy into \the <b>[partner]</b>'s own."
		partner.set_is_fucking(user, CUM_TARGET_VAGINA, partner.getorganslot(ORGAN_SLOT_VAGINA))
	playlewdinteractionsound(get_turf(user), pick('sound/f13effects/sunsetsounds/blush.ogg'), 40, 1, -1)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_VAGINA, user, ORGAN_SLOT_VAGINA) //SPLURT edit
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_VAGINA, partner, ORGAN_SLOT_VAGINA) //SPLURT edit

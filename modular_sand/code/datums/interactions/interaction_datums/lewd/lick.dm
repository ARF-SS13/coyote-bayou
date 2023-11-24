/datum/interaction/lewd/rimjob
	description = "Partner/Crotch - Lick their ass."
	simple_sounds = null
	require_user_mouth = TRUE
	require_target_anus = REQUIRE_ANY
	max_distance = 1

/datum/interaction/lewd/rimjob/interaction_message(mob/living/user, mob/living/partner, show_message)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> licks \the <b>[partner]</b>'s asshole."), ignored_mobs = user.get_unconsenting())
	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 40, 1, -1)
	partner.handle_post_sex(NORMAL_LUST, null, user, "anus") //SPLURT edit

/datum/interaction/lewd/lickfeet
	description = "Partner/Legs - Lick their feet."
	simple_sounds = null
	require_user_mouth = TRUE
	require_target_feet = REQUIRE_ANY
	require_target_num_feet = 1
	max_distance = 1

/datum/interaction/lewd/lickfeet/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message

	var/shoes = partner.get_shoes()

	if(shoes)
		message = "licks \the <b>[partner]</b>'s [shoes]."
	else
		message = "licks \the <b>[partner]</b>'s [partner.has_feet() == 1 ? "foot" : "feet"]."

	playlewdinteractionsound(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 40, 1, -1)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(LOW_LUST, null, user)

/datum/interaction/lewd/kiss
	description = "Partner/Head - Kiss them deeply."
	require_user_mouth = TRUE
	require_target_mouth = TRUE
	write_log_user = "kissed"
	write_log_target = "was kissed by"
	simple_sounds = null
	max_distance = 1

/datum/interaction/lewd/kiss/post_interaction(mob/living/user, mob/living/partner)
	. = ..()
	if(user.get_lust() < 5)
		user.set_lust(5)
	if(partner.get_lust() < 5)
		partner.set_lust(5)

/datum/interaction/lewd/kiss/interaction_message(mob/living/user, mob/living/partner, show_message)
	if(user.get_lust() >= 3)
		if(show_message) user.visible_message(span_love("\The <b>[user]</b> gives an intense, lingering kiss to \the <b>[partner]</b>."))
	else
		if(show_message) user.visible_message(span_love("\The <b>[user]</b> kisses \the <b>[partner]</b> deeply."))

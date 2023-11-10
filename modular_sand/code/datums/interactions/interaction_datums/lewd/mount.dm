/datum/interaction/lewd/mount
	description = "Partner/Crotch - Mount with pussy."
	simple_sounds = null
	require_user_vagina = REQUIRE_ANY
	require_target_penis = REQUIRE_ANY
	max_distance = 1

/datum/interaction/lewd/mount/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message
	var/u_His = user.p_their()
	var/genital_name = partner.get_penetrating_genital_name()

	if(partner.is_fucking(user, CUM_TARGET_VAGINA))
		message = "[pick("rides \the <b>[partner]</b>'s [genital_name].",
			"forces <b>[partner]</b>'s [genital_name] on [u_His] pussy")]"
	else
		message = "slides [u_His] pussy onto \the <b>[partner]</b>'s [genital_name]."
		partner.set_is_fucking(user, CUM_TARGET_VAGINA, partner.getorganslot(ORGAN_SLOT_PENIS))
	playlewdinteractionsound(get_turf(user), pick('sound/f13effects/sunsetsounds/blush.ogg'), 40, 1, -1)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	if(partner.can_penetrating_genital_cum())
		partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_VAGINA, user, ORGAN_SLOT_PENIS) //SPLURT edit
	user.handle_post_sex(NORMAL_LUST, CUM_TARGET_PENIS, partner, ORGAN_SLOT_VAGINA) //SPLURT edit

/datum/interaction/lewd/mountass
	description = "Partner/Crotch - Mount with butt."
	simple_sounds = null
	require_user_anus = REQUIRE_ANY
	require_target_penis = REQUIRE_ANY
	max_distance = 1

/datum/interaction/lewd/mountass/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message
	var/u_His = user.p_their()
	var/genital_name = partner.get_penetrating_genital_name()

	if(partner.is_fucking(user, CUM_TARGET_ANUS))
		message = "[pick("rides \the <b>[partner]</b>'s [genital_name].",
			"forces <b>[partner]</b>'s [genital_name] on [u_His] ass")]"
	else
		message = "lowers [u_His] ass onto \the <b>[partner]</b>'s [genital_name]."
		partner.set_is_fucking(user, CUM_TARGET_ANUS, partner.getorganslot(ORGAN_SLOT_PENIS))
	playlewdinteractionsound(get_turf(user), pick('sound/f13effects/sunsetsounds/blush.ogg'), 40, 1, -1)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	if(partner.can_penetrating_genital_cum())
		partner.handle_post_sex(NORMAL_LUST, CUM_TARGET_ANUS, user, ORGAN_SLOT_PENIS) //SPLURT edit
	user.handle_post_sex(NORMAL_LUST, null, partner, "anus")

/datum/interaction/lewd/mountface
	description = "Partner/Face - Ass to face."
	simple_sounds = null
	require_target_mouth = TRUE
	require_user_anus = REQUIRE_ANY
	max_distance = 1

/datum/interaction/lewd/mountface/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message

	var/u_His = user.p_their()

	if(user.is_fucking(partner, GRINDING_FACE_WITH_ANUS))
		message = "[pick("grinds [u_His] ass into \the <b>[partner]</b>'s face.",
			"shoves [u_His] ass into \the <b>[partner]</b>'s face.")]"
	else
		message = "[pick(
			"grabs the back of \the <b>[partner]</b>'s head and forces it into [u_His] asscheeks.",
			"squats down and plants [u_His] ass right on \the <b>[partner]</b>'s face")]"
		user.set_is_fucking(partner, GRINDING_FACE_WITH_ANUS, null)

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/squelch1.ogg',
						'modular_sand/sound/interactions/squelch2.ogg',
						'modular_sand/sound/interactions/squelch3.ogg'), 70, 1, -1)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(LOW_LUST, null, partner)

/datum/interaction/lewd/thighs
	description = "Partner/Head - Smother with %COCK%."
	max_distance = 1
	require_user_penis = REQUIRE_ANY
	require_target_mouth = TRUE
	simple_sounds = null
	write_log_user = "thigh-trapped (penis)"
	write_log_target = "was smothered (penis) by"
	var/fucktarget = "penis"

/datum/interaction/lewd/thighs/vagina
	description = "Partner/Head - Smother them with vagina."
	require_user_penis = REQUIRE_NONE
	require_user_vagina = REQUIRE_ANY
	write_log_user = "thigh-trapped (vagina)"
	write_log_target = "was smothered (vagina) by"
	fucktarget = "vagina"

/datum/interaction/lewd/thighs/interaction_message(mob/living/user, mob/living/partner, show_message)
	var/message
	var/obj/item/organ/genital/genital = null
	var/lust_increase = 1

	var/u_His = user.p_their()
	var/t_His = partner.p_their()
	var/t_Him = partner.p_them()
	var/t_Hes = partner.p_theyre()

	if(user.is_fucking(partner, THIGH_SMOTHERING))
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(user.has_vagina())
					message = pick(list(
						"presses [u_His] weight down onto \the <b>[partner]</b>'s face, blocking [t_His] vision completely.",
						"rides \the <b>[partner]</b>'s face, grinding [u_His] wet pussy all over it."))
				else
					improv = TRUE
			if("penis")
				if(user.has_penis() || user.has_strapon())
					var/genital_name = user.get_penetrating_genital_name()
					message = pick(list("presses [u_His] weight down onto \the <b>[partner]</b>'s face, blocking [t_His] vision completely.",
						"forces [u_His] [genital_name] into \the <b>[partner]</b>'s face as [t_Hes] stuck locked in between [u_His] thighs.",
						"slips [u_His] [genital_name] into \the <b>[partner]</b>'s helpless mouth, keeping [u_His] shaft pressed hard into [t_His] face."))
				else
					improv = TRUE
		if(improv)
			message = "rubs [u_His] groin up and down \the <b>[partner]</b>'s face."
	else
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(user.has_vagina())
					message = pick(list(
						"clambers over \the <b>[partner]</b>'s face and pins [t_Him] down with [u_His] thighs, [u_His] moist slit rubbing all over \the <b>[partner]</b>'s mouth and nose.",
						"locks [u_His] legs around \the <b>[partner]</b>'s head before pulling it into [u_His] mound."))
				else
					improv = TRUE
			if("penis")
				if(user.has_penis() || user.has_strapon())
					message = pick(list(
						"clambers over \the <b>[partner]</b>'s face and pins [t_Him] down with [u_His] thighs, then slowly inching closer and covering [t_His] eyes and nose with [u_His] leaking erection.",
						"locks [u_His] legs around \the <b>[partner]</b>'s head before pulling it into [u_His] fat package, smothering [t_Him]."))
				else
					improv = TRUE
		if(improv)
			message = "deviously locks [u_His] legs around \the <b>[partner]</b>'s head and smothers it in [u_His] thighs."
		else
			switch(fucktarget)
				if("vagina")
					genital = partner.getorganslot(ORGAN_SLOT_VAGINA)
				if("penis")
					genital = partner.getorganslot(ORGAN_SLOT_PENIS)
		user.set_is_fucking(partner, THIGH_SMOTHERING, genital)

	var/file = pick('modular_sand/sound/interactions/bj10.ogg',
					'modular_sand/sound/interactions/bj3.ogg',
					'modular_sand/sound/interactions/foot_wet1.ogg',
					'modular_sand/sound/interactions/foot_dry3.ogg')
	playlewdinteractionsound(get_turf(user), file, 70, 1, -1)
	if(show_message) user.visible_message(span_love("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting())
	user.handle_post_sex(lust_increase, THIGH_SMOTHERING, partner, genital) //SPLURT edit
	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/oral1.ogg',
						'modular_sand/sound/interactions/oral2.ogg'), 70, 1, -1)
	if(fucktarget != "penis" || user.can_penetrating_genital_cum())
		user.handle_post_sex(NORMAL_LUST, CUM_TARGET_MOUTH, partner, genital) //SPLURT edit

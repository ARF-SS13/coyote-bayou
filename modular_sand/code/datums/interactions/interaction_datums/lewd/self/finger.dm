/datum/interaction/lewd/fingerass_self
	description = "Self/Crotch - Finger your own butthole."
	simple_sounds = null
	require_user_hands = TRUE
	require_user_anus = REQUIRE_ANY
	is_self_action = TRUE
	max_distance = 0
	write_log_user = "fingered self"
	write_log_target = null

	help_messages = list(
		"XU_NAME teases a finger around XU_THEIR pucker!",
		"XU_NAME rubs XU_THEIR starfish gently!",
		"XU_NAME very lightly gives XU_THEIR own butthole a tap!",
		"XU_NAME is gently rubbing XU_THEIR pucker!", //someone who is more excited about anal sex, please rewrite this for me. <3	~TK
	)
	disarm_messages = list(
		"XU_NAME teasingly fingers XU_THEIR backdoor!",
		"XU_NAME explores XU_THEIR own backdoor entrance playfully!",
		"XU_NAME spreads XU_THEIR cheeks, clearly enjoying themselves!",
		"XU_NAME rubs a circle around XU_THEIR sphincter, teasing themselves!",
	)
	grab_messages = list(
		"XU_NAME gives XU_THEIR butthole a playful slap!",
		"XU_NAME fingers XU_THEIR backdoor thoroughly.",
		"XU_NAME is really getting up in XU_THEIR own ass!",
		"XU_NAME is absolutely using XU_THEIR fingers to knock on the back door!",
	)
	harm_messages = list(
		"XU_NAME slaps XU_THEIR asshole hard!",
		"XU_NAME is fingering XU_THEIR butthole like XU_THEIR life depends on it!",
		"XU_NAME groans as they fingerfuck their own ass!",
		"XU_NAME fingers XU_THEIR booty so hard they begin to shake!",
		"XU_NAME is fingering XU_THEIR butt like it owes them money!",
	)

	simple_sounds = list('sound/weapons/thudswoosh.ogg') // frumf, frumf
	user_lust_mult = 1
	lust_go_to = LUST_USER | LUST_TARGET

/datum/interaction/lewd/finger_self
	description = "Self/Crotch - Finger your own pussy."
	require_user_hands = TRUE
	require_user_vagina = REQUIRE_ANY
	simple_sounds = null
	is_self_action = TRUE
	max_distance = 0
	write_log_user = "fingered own pussy"
	write_log_target = null
	help_messages = list(
		"XU_NAME teases a finger around XU_THEIR labia!",
		"XU_NAME rubs XU_THEIR pussy gently!",
		"XU_NAME very lightly gives XU_THEIR own pussy a tap!",
		"XU_NAME is gently rubbing XU_THEIR nether lips!",
	)
	disarm_messages = list(
		"XU_NAME teasingly fingers XU_THEIR pussy!",
		"XU_NAME explores XU_THEIR own love canal playfully!",
		"XU_NAME spreads XU_THEIR pussy lips, clearly enjoying themselves!",
		"XU_NAME rubs a circle around XU_THEIR labia, teasing themselves!",
	)
	grab_messages = list(
		"XU_NAME gives XU_THEIR pussy a playful slap!",
		"XU_NAME fingers XU_THEIR honeypot thoroughly.",
		"XU_NAME is really getting up in XU_THEIR own pussy!",
		"XU_NAME is soaking XU_THEIR fingers in their own juices as they play with themselves!",
	)
	harm_messages = list(
		"XU_NAME slaps XU_THEIR pussy lips hard!",
		"XU_NAME is fingering XU_THEIR pussy like XU_THEIR life depends on it!",
		"XU_NAME groans as they fingerfuck their pussy messily!",
		"XU_NAME fingers XU_THEIR pussy so hard them begins to shake!",
		"XU_NAME is fingering XU_THEIR pussy like it owes them money!",
	)

	simple_sounds = list('modular_sand/sound/interactions/champ_fingering.ogg') // frumf, frumf
	lust_go_to = LUST_USER | LUST_TARGET

	additional_details = list(
		list(
			"info" = "You can fill a container if you hold it in your hand or pull it",
			"icon" = "flask",
			"color" = "transparent"
			)
	)

// /datum/interaction/lewd/finger_self/interaction_message(mob/living/user, mob/living/target, show_message)
// 	var/obj/item/reagent_containers/liquid_container

// 	var/obj/item/cached_item = user.get_active_held_item()
// 	if(istype(cached_item, /obj/item/reagent_containers))
// 		liquid_container = cached_item
// 	else
// 		cached_item = user.pulling
// 		if(istype(cached_item, /obj/item/reagent_containers))
// 			liquid_container = cached_item



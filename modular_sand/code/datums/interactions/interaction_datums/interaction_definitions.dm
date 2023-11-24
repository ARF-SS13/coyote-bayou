/datum/interaction/handshake
	description = "Shake their hand."
	help_messages = "XU_NAME shakes the hand of XT_NAME."
	require_user_hands = TRUE
	needs_physical_contact = TRUE

/datum/interaction/pat
	description = "Pat their shoulder."
	help_messages = "XU_NAME pats XT_NAME's shoulder."
	require_user_hands = TRUE
	needs_physical_contact = TRUE

/datum/interaction/cheer
	description = "Cheer them on."
	require_user_mouth = TRUE
	help_messages = "XU_NAME cheers XT_NAME on!"

/datum/interaction/highfive
	description = "Give them a high-five."
	require_user_mouth = TRUE
	help_messages = "XU_NAME high fives XT_NAME!"
	simple_sounds = 'modular_sand/sound/interactions/slap.ogg'
	needs_physical_contact = TRUE

/datum/interaction/headpat
	description = "Pat their head. Aww..."
	require_user_hands = TRUE
	help_messages = "XU_NAME headpats XT_NAME!"
	needs_physical_contact = TRUE

/datum/interaction/salute
	description = "Give them a firm salute!"
	require_user_hands = TRUE
	help_messages = "XU_NAME salutes XT_NAME sharply!"
	max_distance = 25

/datum/interaction/fistbump
	description = "Bump it!"
	require_user_hands = TRUE
	help_messages = "XU_NAME fistbumps XT_NAME! Yeah!"
	needs_physical_contact = TRUE

/datum/interaction/pinkypromise
	description = "Make a pinky promise with them!"
	require_user_hands = TRUE
	help_messages = "XU_NAME hooks their pinky with XT_NAME's! Pinky Promise!"
	needs_physical_contact = TRUE

/datum/interaction/bird
	description = "Flip them the bird!"
	require_user_hands = TRUE
	help_messages = "XU_NAME gives XT_NAME the bird!"
	max_distance = 25

/datum/interaction/holdhand
	description = "Hold their hand."
	require_user_hands = TRUE
	help_messages = "XU_NAME holds XT_NAME's hand."
	needs_physical_contact = TRUE
	max_distance = 25

/datum/interaction/hifivemyself
	description = "Give yourself a high-five!."
	require_user_hands = TRUE
	help_messages = "XU_NAME gives themself a high-five."
	needs_physical_contact = TRUE
	is_self_action = TRUE
	max_distance = 25

/datum/interaction/consent
	description = "Request consent for lewd stuff."
	require_user_hands = TRUE
	help_messages = "XU_NAME waves to XT_NAME."
	needs_physical_contact = FALSE
	max_distance = 25
	can_autoplap = FALSE // HI WANNA HI WANNA HI WANNA HI WANNA

/datum/interaction/consent/do_action(mob/living/user, mob/living/target)
	SSinteractions.add_or_remove_consent(user, target)


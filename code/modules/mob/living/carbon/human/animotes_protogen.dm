//-->
// Protogen screen ANIMOTES
// Authors: Ekizius (animator), Leonzrygin(coder)
// for any issue, contact us!
//<--

/proc/fetch_eye_color(mob/living/carbon/human/user)
	if(user.right_eye_color)
		return "#[user.right_eye_color]"
	else if(user.left_eye_color)
		return "#[user.left_eye_color]"
	else
		return "#FFFFFF"

/datum/emote/living/carbon/human/protogen
	var/image/emote_animation
	var/animation_duration = 3 SECONDS
	var/animation_volume = 40

//This section of code determines if the carbon has an actual protogen visor to play these animotes on.
/datum/emote/living/carbon/human/protogen/can_run_emote(mob/user, status_check = FALSE, intentional = TRUE)
	. = ..()
	var/mob/living/carbon/human/H = user
	//You aren't a protogen? GO AWAY YOU STINKY
	//if you are planning to add different snouts, remember to update the list or they may not work!
	if(	H.dna.features["mam_snouts"] == "Protogen - Snout" || \
		H.dna.features["mam_snouts"] == "Protogen - Snout Under" || \
		H.dna.features["mam_snouts"] == "Protogen - Snout Tertiary" || \
		H.dna.features["mam_snouts"] == "Protogen - Snout Tertiary Under" || \
		H.dna.features["mam_snouts"] == "Protogen with Beak - Snout" || \
		H.dna.features["mam_snouts"] == "Protogen with Beak - Snout Under" || \
		H.dna.features["mam_snouts"] == "Protogen with Beak - Snout Tertiary" || \
		H.dna.features["mam_snouts"] == "Protogen with Beak - Snout Tertiary Under" \
	)
		return TRUE
	to_chat(usr, span_warning("You realize that you're actually missing a protogen visor to do this..."))
	return FALSE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/heart
	key = "protoheart"
	key_third_person = "displays a blinking heart on their visor..."
	message = "displays a blinking heart on their visor..."

/datum/emote/living/carbon/human/protogen/heart/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_heart")
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_heart.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/exclaim
	key = "protoexclaim"
	key_third_person = "displays a blinking exlamation mark on their visor!"
	message = "displays a blinking exlamation mark on their visor!"

/datum/emote/living/carbon/human/protogen/exclaim/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_exclaim")
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_exclaim.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/question
	key = "protoquestion"
	key_third_person = "displays a blinking question mark on their visor."
	message = "displays a blinking question mark on their visor."

/datum/emote/living/carbon/human/protogen/question/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_question")
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_question.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/bsod
	key = "protobsod"
	key_third_person = "goes still, their visor crashing for a brief moment."
	message = "goes still, their visor crashing for a brief moment."

/datum/emote/living/carbon/human/protogen/bsod/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_bsod")
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_bsod.mp3', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/tetris
	key = "prototetris"
	key_third_person = "boots up tetris on their visor..."
	message = "boots up tetris on their visor..."

/datum/emote/living/carbon/human/protogen/tetris/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	animation_duration = 4 SECONDS

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_tetris")
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/arcade/minesweeper_winfail.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/pong
	key = "protopong"
	key_third_person = "boots up pong on their visor..."
	message = "boots up pong on their visor..."

/datum/emote/living/carbon/human/protogen/pong/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	animation_duration = 3.2 SECONDS

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_pong")
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/arcade/minesweeper_menuselect.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/sad
	key = "protosad"
	key_third_person = "displays a sad, crying face."
	message = "displays a sad, crying face."

/datum/emote/living/carbon/human/protogen/sad/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_sad")
	emote_animation.color = fetch_eye_color(user)
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_sad_tear")
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_sad.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/anger
	key = "protoanger"
	key_third_person = "displays a furious face!"
	message = "displays a furious face!"

/datum/emote/living/carbon/human/protogen/anger/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_anger")
	emote_animation.color = fetch_eye_color(user)
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_exclaim.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/happy
	key = "protohappy"
	key_third_person = "displays a joyful face!"
	message = "displays a joyful face!"

/datum/emote/living/carbon/human/protogen/happy/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_happy")
	emote_animation.color = fetch_eye_color(user)
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_heart.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/pog
	key = "protopog"
	key_third_person = "pogs."
	message = "pogs."

/datum/emote/living/carbon/human/protogen/pog/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_pog")
	emote_animation.color = fetch_eye_color(user)
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_question.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/tt
	key = "protott"
	key_third_person = "displays a resigned face..."
	message = "displays a resigned face..."

/datum/emote/living/carbon/human/protogen/tt/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_tt")
	emote_animation.color = fetch_eye_color(user)
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_sad.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/wat
	key = "protowat"
	key_third_person = "displays a perplexed face."
	message = "displays a perplexed face."

/datum/emote/living/carbon/human/protogen/wat/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_wat")
	emote_animation.color = fetch_eye_color(user)
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_question.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////


/datum/emote/living/carbon/human/protogen/rawr
	key = "protorawr"
	key_third_person = "RAWRs."
	message = "RAWRs."

/datum/emote/living/carbon/human/protogen/rawr/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_visor")
	emote_animation.color = "#000000"  //"#[H.dna.features["mcolor3"]]"
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	emote_animation = image('icons/mob/animotes_protogen.dmi', user, "proto_rawr")
	emote_animation.color = fetch_eye_color(user)
	flick_overlay_global(emote_animation, GLOB.clients, animation_duration)

	playsound(user.loc, 'sound/effects/animotes_protogen/proto_exclaim.ogg', animation_volume)

	return TRUE
////////////////////////////////////////////////////////////////////////////////////////////////

/datum/emote/living/blush
	key = "blush"
	key_third_person = "blushes"
	message = "blushes."
	message_param = "blushes at %t."
	sound = 'sound/f13effects/sunsetsounds/blush.ogg' //Sunset Edit - TK

/datum/emote/living/blush/run_emote(mob/user, params)
	. = ..()
	if(. && isipcperson(user))
		do_fake_sparks(5,FALSE,user)

/datum/emote/living/bow
	key = "bow"
	key_third_person = "bows"
	message = "bows."
	message_param = "bows to %t."
	restraint_check = TRUE

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "burps."
	message_param = "burps from the %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/lilburp.ogg' //Sunset Edit - TK

/datum/emote/living/choke
	key = "choke"
	key_third_person = "chokes"
	message = "chokes!"
	message_param = "chokes on the %t."
	emote_type = EMOTE_AUDIBLE
	// sound = 'sound/f13effects/sunsetsounds/choke.ogg' Turned off due to upset tummies

/datum/emote/living/cross
	key = "cross"
	key_third_person = "crosses"
	message = "crosses their arms."
	message_param = "crosses their arms at %t."
	restraint_check = TRUE

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "chuckles."
	message_param = "chuckles at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/chuckle/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 1, -1, 1, -1, 1 SECONDS)

/datum/emote/living/chuckle/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/f13effects/sunsetsounds/femalechuckle.ogg'
		else
			return 'sound/f13effects/sunsetsounds/malechuckle.ogg'

/datum/emote/living/collapse
	key = "collapse"
	key_third_person = "collapses"
	message = "collapses!"
	message_param = "collapses from %t!" // Because I like to *collapse cringe "collapses from cringe!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/collapse/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Unconscious(40)

/datum/emote/living/cough
	key = "cough"
	key_third_person = "coughs"
	message = "coughs!"
	message_param = "coughs from the %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cough/run_emote(mob/user, params)
	. = ..()
//	var/matrix/tf = matrix(user.transform)
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 2, -1, 1, -1, 1 SECONDS)

/datum/emote/living/cough/can_run_emote(mob/user, status_check = TRUE , intentional)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_SOOTHED_THROAT))
		return FALSE

/datum/emote/living/cough/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/effects/female_cough.ogg'
		else
			return 'sound/effects/male_cough.ogg'

/datum/emote/living/dance
	key = "dance"
	key_third_person = "dances"
	message = "dances around happily."
	message_param = "dances %t."
	restraint_check = TRUE

/datum/emote/thumbup
	key = "thumbsup"
	key_third_person = "thumbsups"
	message = "makes a thumbs up sign with their hand."
	message_param = "makes a thumbs up sign with their hand at %t."
	restraint_check = TRUE

/datum/emote/thumbdown
	key = "thumbsdown"
	key_third_person = "thumbsdowns"
	message = "makes a thumbs down sign with their hand."
	message_param = "makes a thumbs down sign with their hand at %t."
	restraint_check = TRUE

/datum/emote/living/deathgasp
	key = "deathgasp"
	key_third_person = "deathgasps"
	message = "seizes up and falls limp, their eyes dead and lifeless..."
	message_robot = "shudders violently for a moment before falling still, its eyes slowly darkening."
	message_AI = "lets out a flurry of sparks, its screen flickering as its systems slowly halt."
	message_alien = "lets out a waning guttural screech, green blood bubbling from its maw..."
	message_larva = "lets out a sickly hiss of air and falls limply to the floor..."
	message_monkey = "lets out a faint chimper as it collapses and stops moving..."
	message_simple =  "stops moving..."
	stat_allowed = UNCONSCIOUS

/datum/emote/living/deathgasp/run_emote(mob/user, params)
	var/mob/living/simple_animal/S = user
	if(istype(S) && S.deathmessage)
		message_simple = S.deathmessage
	. = ..()
	message_simple = initial(message_simple)
	if(. && user.deathsound)
		if(isliving(user))
			var/mob/living/L = user
			if(!L.can_speak_vocal() || L.oxyloss >= 50)
				return //stop the sound if oxyloss too high/cant speak
		playsound(user, user.deathsound, 200, TRUE, TRUE)
	if(. && isalienadult(user))
		playsound(user.loc, 'sound/voice/hiss6.ogg', 80, 1, 1)
	if(HAS_TRAIT(user, TRAIT_PLAY_DEAD))
		user.reagents.add_reagent(/datum/reagent/toxin/ghoulpowder, 10)

/datum/emote/living/drool
	key = "drool"
	key_third_person = "drools"
	message = "drools."
	message_param = "drools at %t."

/datum/emote/living/faint
	key = "faint"
	key_third_person = "faints"
	message = "faints."
	message_param = "faints from %t."
	stat_allowed = UNCONSCIOUS //So people can use faint to quickly slam the ability even if they are unconscious

/datum/emote/living/faint/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.SetSleeping(200)

/* Colfer edit: Trying to get *faint emote to work by removing duplicate datum (THIS HASNT BEEN TESTED, I dont know what this can effect by changing it)
/datum/emote/living/faint
	key = "collapse"
	key_third_person = "collapse"
	message = "collapses."
	message_param = "collapses from %t."

/datum/emote/living/faint/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.SetSleeping(20)
*/

/* Fortuna edit: flapping your wings disabled
/datum/emote/living/flap
	key = "flap"
	key_third_person = "flaps"
	message = "flaps their wings."
	restraint_check = TRUE
	var/wing_time = 20

/datum/emote/living/flap/run_emote(mob/user, params)
	. = ..()
	if(. && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/open = FALSE
		if(H.dna.features["wings"] != "None")
			if(H.dna.species.mutant_bodyparts["wingsopen"])
				open = TRUE
				H.CloseWings()
			else
				H.OpenWings()
			addtimer(CALLBACK(H, TYPE_PROC_REF(open ? /mob/living/carbon/human/atom/.proc/OpenWings : /mob/living/carbon/human/atom/,CloseWings)), wing_time)

/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "aflaps"
	message = "flaps their wings ANGRILY!"
	restraint_check = TRUE
	wing_time = 10
*/

/datum/emote/living/fchuckle
	key = "fchuckle"
	key_third_person = "fchuckles"
	message = "chuckles."
	message_param = "chuckles at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/femalechuckle.ogg'

/datum/emote/living/fgasp
	key = "fgasp"
	key_third_person = "fgasps"
	message = "gasps!"
	message_param = "gasps at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/female_gasp.ogg'

/datum/emote/living/fgiggle
	key = "fgiggle"
	key_third_person = "fgiggles"
	message = "giggles."
	message_param = "giggles at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/femalegiggle1.ogg'

/datum/emote/living/flaugh
	key = "flaugh"
	key_third_person = "flaughs"
	message = "laughs."
	message_param = "laughs at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/human/womanlaugh.ogg'

/datum/emote/living/fsigh
	key = "fsigh"
	key_third_person = "fsighs"
	message = "sighs."
	message_param = "sighs at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/femalesigh1.ogg'

/datum/emote/living/fsneeze
	key = "fsneeze"
	key_third_person = "fsneezes"
	message = "sneezes."
	message_param = "sneezes at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/female_sneeze.ogg'

/datum/emote/living/fsnore
	key = "fsnore"
	key_third_person = "fsnores"
	message = "snores."
	message_param = "snores at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/femalesnore1.ogg'

/datum/emote/living/fwhimper
	key = "fwhimper"
	key_third_person = "fwhimpers"
	message = "whimpers."
	message_param = "whimpers at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/femalewhimper1.ogg'

/datum/emote/living/frown
	key = "frown"
	key_third_person = "frowns"
	message = "frowns."
	message_param = "frowns at %t."

/datum/emote/living/gag
	key = "gag"
	key_third_person = "gags"
	message = "gags."
	message_param = "gags from %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/gag.ogg'
	sound_volume = 100

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "gasps!"
	message_param = "gasps at %t."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/gasp/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/effects/female_gasp.ogg'
		else
			return 'sound/effects/male_gasp.ogg'

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "giggles."
	message_param = "giggles at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/giggle/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 1, -1, 1, -1, 0.5 SECONDS)

/datum/emote/living/giggle/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/effects/femalegiggle1.ogg'
		else
			return 'sound/effects/malegiggle1.ogg'

/datum/emote/living/glare
	key = "glare"
	key_third_person = "glares"
	message = "glares."
	message_param = "glares at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/grin
	key = "grin"
	key_third_person = "grins"
	message = "grins."
	message_param = "grins at %t."

/datum/emote/living/groan
	key = "groan"
	key_third_person = "groans"
	message = "groans!"
	message_param = "groans at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "grimaces."
	message_param = "grimaces at %t."

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "kisses"
	message = "blows a kiss."
	message_param = "blows a kiss to %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/kiss.ogg'

/datum/emote/living/audible
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/audible/can_run_emote(mob/living/user, status_check = TRUE)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		return !C.silent && (!C.mind || !C.mind.miming)

/datum/emote/living/audible/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "laughs."
	message_param = "laughs about %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/audible/laugh/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 2, -2, 2, -2, 1.5 SECONDS)

/datum/emote/living/audible/laugh/get_sound(mob/living/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		//power armor laugh track.... spooky
		if(istype(human_user.get_item_by_slot(INV_SLOTBIT_OCLOTHING), /obj/item/clothing/suit/armor/power_armor))
			return 'sound/voice/robolaugh.ogg'
		return human_user.dna.species.get_laugh_sound(user)

/datum/emote/living/audible/chitter
	key = "chitter"
	key_third_person = "chitters"
	message = "chitters."
	message_param = "chitters at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/moth/mothchitter.ogg'

/datum/emote/living/nod
	key = "nod"
	key_third_person = "nods"
	message = "nods."
	message_param = "nods at %t."

/datum/emote/living/fenfrantic
	key = "fenfrantic"
	key_third_person = "geckers frantically!"
	message = "geckers frantically!"
	message_param = "geckers frantically at %t"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/fenfrantic.ogg'

/datum/emote/living/nod/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_directional_tilt), 5, 0.5 SECONDS)

/datum/emote/living/point
	key = "point"
	key_third_person = "points"
	message = "points."
	message_param = "points at %t."
	restraint_check = TRUE

/datum/emote/living/point/run_emote(mob/user, params)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.get_num_arms() == 0)
			if(H.get_num_legs() != 0)
				message_param = "tries to point at %t with a leg, <span class='userdanger'>falling down</span> in the process!"
				H.DefaultCombatKnockdown(20)
			else
				message_param = "<span class='userdanger'>bumps [user.p_their()] head on the ground</span> trying to motion towards %t."
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	..()

/datum/emote/living/pout
	key = "pout"
	key_third_person = "pouts"
	message = "pouts."
	message_param = "pouts at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "screams."
	message_param = "screams at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "scowls"
	message = "scowls."
	message_param = "scowls at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shake
	key = "shake"
	key_third_person = "shakes"
	message = "shakes their head."
	message_param = "shakes their head at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shake/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 1, -1, 1, -1, 1.2 SECONDS)

/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "shiver"
	message = "shivers."
	message_param = "shivers from the %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shiver/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 1, -1, 1, -1, 1 SECONDS)

/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "sighs."
	message_param = "sighs about %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/effects/femalesigh1.ogg'
		else
			return 'sound/effects/malesigh1.ogg'

/datum/emote/living/smile
	key = "smile"
	key_third_person = "smiles"
	message = "smiles."
	message_param = "smiles at %t."

/datum/emote/living/smirk
	key = "smirk"
	key_third_person = "smirks"
	message = "smirks."
	message_param = "smirks at %t."

/datum/emote/living/smugsmirk
	key = "smugsmirk"
	key_third_person = "smirks smugly."
	message = "smirks smugly."
	message_param = "smirks smugly at %t."

/datum/emote/living/smuggrin
	key = "smuggrin"
	key_third_person = "grins smugly."
	message = "grins smugly."
	message_param = "grins smugly at %t."

/datum/emote/living/leer
	key = "leer"
	key_third_person = "leers"
	message = "leers."
	message_param = "leers at %t."

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "sneezes."
	message_param = "sneezes from %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shake/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 2, -2, 2, -2, 1.5 SECONDS)

/datum/emote/living/sneeze/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/effects/female_sneeze.ogg'
		else
			return 'sound/effects/male_sneeze.ogg'

/datum/emote/living/smug
	key = "smug"
	key_third_person = "smugs"
	message = "grins smugly."
	message_param = "smugly grins at %t."

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "sniffs"
	message = "sniffs."
	message_param = "sniffs at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snore
	key = "snore"
	key_third_person = "snores"
	message = "snores."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/snore/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/effects/femalesnore1.ogg'
		else
			return 'sound/effects/malesnore1.ogg'

/datum/emote/living/stare
	key = "stare"
	key_third_person = "stares"
	message = "stares."
	message_param = "stares at %t."

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "stretches"
	message = "stretches their arms."
	message_param = "stretches their %t."

/datum/emote/living/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "sulks down sadly."

/datum/emote/living/surrender
	key = "surrender"
	key_third_person = "surrenders"
	message = "puts their hands on their head and falls to the ground, they surrender!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS
	restraint_check = FALSE
	sound_volume = 80
	sound_vary = FALSE

/datum/emote/living/surrender/get_sound(mob/living/user)
	return 'sound/f13effects/surrender1.ogg'

/datum/emote/living/surrender/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Knockdown(200)
		L.Paralyze(200)

/datum/emote/living/sway
	key = "sway"
	key_third_person = "sways"
	message = "sways around dizzily."

/datum/emote/living/tremble
	key = "tremble"
	key_third_person = "trembles"
	message = "trembles in fear!"
	message_param = "trembles in fear at %t."

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "twitches violently."

/datum/emote/living/twitch/run_emote(mob/user, params)
	user.Jitter(20)

/datum/emote/living/twitch_s
	key = "twitch_s"
	message = "twitches."

/datum/emote/living/wave
	key = "wave"
	key_third_person = "waves"
	message = "waves."
	message_param = "waves at %t."

/datum/emote/living/squint
	key = "squint"
	key_third_person = "squints"
	message = "squints."
	message_param = "squints at %t."

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "whimpers."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/whimper/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return 'sound/effects/femalewhimper1.ogg'
		else
			return 'sound/effects/malewhimper1.ogg'

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "wsmiles"
	message = "smiles weakly."
	message_param = "weakly smiles at %t."

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "yawns."
	message_param = "yawns at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	message = null
	emote_type = EMOTE_VISIBLE
	mommychat = TRUE
	mommychat_partial = FALSE // full blown

/datum/emote/living/custom/proc/check_invalid(mob/user, input)
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, span_danger("Invalid emote."))
		return TRUE
	return FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override = null, only_overhead)
	if(jobban_isbanned(user, "emote"))
		to_chat(user, "You cannot send custom emotes (banned).")
		return FALSE
	else if(QDELETED(user))
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		var/custom_emote = stripped_multiline_input_or_reflect(user, EMOTE_HEADER_TEXT, "Custom Emote", null, MAX_MESSAGE_LEN)
		if(!custom_emote)
			return FALSE
		if(check_invalid(user, custom_emote))
			return FALSE
		message = custom_emote
	else
		message = params
		if(type_override)
			emote_type = type_override
	original_message = message
	message = user.say_emphasis(message)
	var/msg_check = user.say_narrate_replace(message, user)
	if(msg_check)
		message = msg_check
	else
		message = "<b>[user]</b> [message]" // die(t)
	omit_left_name = TRUE
	. = ..()
	omit_left_name = FALSE
	message = null
	original_message = null

/datum/emote/living/custom/replace_pronoun(mob/user, message)
	return message

/datum/emote/living/help
	key = "help"

/datum/emote/living/help/run_emote(mob/user, params)
	var/list/keys = list()
	var/list/message = list("Available emotes, you can use them with say \"*emote\": ")

	var/datum/emote/E
	var/list/emote_list = E.emote_list
	for(var/e in emote_list)
		if(e in keys)
			continue
		E = emote_list[e]
		if(E.can_run_emote(user, status_check = FALSE))
			keys += E.key

	keys = sortList(keys)

	for(var/emote in keys)
		if(LAZYLEN(message) > 1)
			message += ", [emote]"
		else
			message += "[emote]"

	message += "."

	message = jointext(message, "")

	to_chat(user, message)

/* Fortuna edit: beep disabled
/datum/emote/beep
	key = "beep"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."
	sound = 'sound/machines/twobeep.ogg'
	mob_type_allowed_typecache = list(/mob/living/brain, /mob/living/silicon, /mob/living/carbon/human)
*/

/datum/emote/living/slap
	key = "slap"
	key_third_person = "slaps"
	restraint_check = TRUE

/datum/emote/living/slap/run_emote(mob/user, params)
	. = ..()
	if(!.)
		return
	var/obj/item/slapper/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("You ready your slapping hand."))
	else
		to_chat(user, span_warning("You're incapable of slapping in your current state."))

/datum/emote/living/audible/blorble
	key = "blorble"
	key_third_person = "blorbles"
	message = "blorbles."
	message_param = "blorbles at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/audible/blorble/run_emote(mob/user, params)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(isjellyperson(C))
			pick(playsound(C, 'sound/effects/attackblob.ogg', 50, 1),playsound(C, 'sound/effects/blobattack.ogg', 50, 1))

/datum/emote/living/audible/blurp
	key = "blurp"
	key_third_person = "blurps"
	message = "blurps."
	message_param = "blurps at %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/audible/blurp/run_emote(mob/user, params)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(isjellyperson(C))
			pick(playsound(C, 'sound/effects/meatslap.ogg', 50, 1),playsound(C, 'sound/effects/gib_step.ogg', 50, 1))

/datum/emote/living/surrender
	key = "surrender"
	key_third_person = "surrenders"
	message = "puts their hands on their head and falls to the ground, they surrender!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/surrender/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Knockdown(200)




		///////////////////////////////////////
		//Sunset Emotes                      //
		//Started by TK420634, June 4th, 2022//
		///////////////////////////////////////
		//I've included some notes on the first two for those who want to go about adding more emotes in the future, there's also some useful stuff in the code up above that we may should consider bringing down to them
		//but for now these are servicable.  The only conern I'd have with what is here is that some of these sounds are semi-spammable, but if someone starts bleating at you like a braindead idiot and won't stop
		//then maybe just CI them down with your uzi?

	//This is a good starting point for adding a simple emote with a sound, consider using this in the future for other sounds.
/datum/emote/cackle
	key = "cackle" // What the *emote will be
	key_third_person = "cackles worryingly" // What someone else will see.
	message = "cackles worryingly." // What you'll see.
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/YeenCackle.ogg' //Sound played.

	//I don't like how this looks, if someone knows a better way please do so or tell me.
/datum/emote/coyawoo
	key = "coyawoo"
	key_third_person = "howls like a coyote"
	message = "howls like a coyote!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/coyawoo/run_emote(mob/user, params) //Player triggers the emote
	. = ..() // Hell if I know
	if(. && iscarbon(user)) // Are they a carbon mob?
		var/mob/living/carbon/C = user
		if(. && isliving(user)) //Are they alive?  The stuff below is the sounds being listed, with percent (the 20s) and then number of times played (1)
			pick(playsound(C, 'sound/f13effects/sunsetsounds/coyoteawoo.ogg', 20, 1),playsound(C, 'sound/f13effects/sunsetsounds/coyoteawoo2.ogg', 20, 1),playsound(C, 'sound/f13effects/sunsetsounds/coyoteawoo3.ogg', 20, 1),playsound(C, 'sound/f13effects/sunsetsounds/coyoteawoo4.ogg', 20, 1),playsound(C, 'sound/f13effects/sunsetsounds/coyoteawoo5.ogg', 20, 1))

/datum/emote/baa //Little Bo Peep Can Eat my...
	key = "baa"
	key_third_person = "baas"
	message = "baas."
	emote_type = EMOTE_AUDIBLE

/datum/emote/baa/run_emote(mob/user, params)
	. = ..() //
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(. && isliving(user))
			pick(playsound(C, 'sound/f13effects/sunsetsounds/baa.ogg', 50, 1),playsound(C, 'sound/f13effects/sunsetsounds/baa2.ogg', 50, 1))

/datum/emote/purr
	key = "purr"
	key_third_person = "purrs contentedly"
	message = "purrs contentedly."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/cat_purr.ogg'

/datum/emote/purrlong
	key = "purrlong"
	key_third_person = "purrs contentedly"
	message = "purrs contentedly."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/cat_purr_long.ogg'

/datum/emote/geckers
	key = "geck"
	key_third_person = "geckers loudly"
	message = "geckers loudly."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/geck.ogg'

/datum/emote/growl
	key = "growl"
	key_third_person = "growls viciously"
	message = "growls viciously."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/growl.ogg'

/datum/emote/moo
	key = "moo"
	key_third_person = "moos"
	message = "moos."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/moo.ogg'

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "meows!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/meow.ogg'

/datum/emote/mrowl
	key = "mrowl"
	key_third_person = "mrowls"
	message = "mrowls."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/mrowl.ogg'

/datum/emote/meowrek
	key = "meowrek"
	key_third_person = "definitely sounds like a cat of all time."
	message = "mrowls."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/meowrek.ogg'

/datum/emote/nya //Kitten Must Die.ogg
	key = "nya"
	key_third_person = "nyas"
	message = "nyas."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/nya.ogg'

/datum/emote/wolfwhistle //Yeah baby that's what I like!
	key = "wolfwhistle"
	key_third_person = "wolf whistles"
	message = "wolf whistles!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/wolfwhistle.ogg'

/datum/emote/kyaa
	key = "kyaa"
	key_third_person = "kyaas"
	message = "kyaas loudly!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/birdkyaa.ogg'

/datum/emote/bork
	key = "bork"
	key_third_person = "borks"
	message = "borks!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/bork.ogg'

/datum/emote/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/bark.ogg'

/datum/emote/yap
	key = "yap"
	key_third_person = "yaps"
	message = "yaps!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/yap.ogg'

/datum/emote/barkmisery
	key = "mbark"
	key_third_person = "barks miserably"
	message = "barks miserably!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/dog-miserable.ogg'

/datum/emote/cougar
	key = "cougar"
	key_third_person = "growls like a cougar"
	message = "growls like a cougar!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/cougar.ogg'

/datum/emote/halt_guard
	key = "stop"
	key_third_person = "tells everyone to halt"
	message = "tells everyone to halt!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/oblivionguard.ogg'

/datum/emote/trumpet
	key = "trumpet"
	key_third_person = "trumpets"
	message = "trumpets!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/trumpet.ogg'

/datum/emote/fenbark
	key = "fenbark"
	key_third_person = "makes a fennec-y bark"
	message = "makes a fennec-y bark!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/fenbark.ogg'

/datum/emote/foxbark
	key = "foxbark"
	key_third_person = "makes a foxy bark"
	message = "makes a foxy bark!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/foxbark.ogg'

/datum/emote/lynx
	key = "lynx"
	key_third_person = "growls like a bobcat"
	message = "growls like a bobcat!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/lynx.ogg'

/datum/emote/panda //yee
	key = "panda"
	key_third_person = "makes a panda like... noise"
	message = "makes a panda like... noise?"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/panda.ogg'

/datum/emote/bun
	key = "bun"
	key_third_person = "squeals like a rabbit"
	message = "squeals like a rabbit!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/rabbit.ogg'

/datum/emote/wolfhowl
	key = "wolfhowl"
	key_third_person = "howls like a wolf"
	message = "howls like a wolf!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/wolfhowl.ogg'

/datum/emote/whistlecome
	key = "come"
	key_third_person = "whistles to get someones attention"
	message = "whistles to get someones attention!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/whistle-overhere.ogg'

/datum/emote/squee
	key = "squee"
	key_third_person = "smiles like a dork."
	message = "smiles like a dork."
	sound = 'sound/f13effects/sunsetsounds/squee.ogg'

/datum/emote/waa
	key = "waa"
	key_third_person = "waas"
	message = "let out a lengthy, rather anxious noise."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/waa.ogg'

/datum/emote/living/warcry
	key = "warcry"
	key_third_person = "warcrys"
	emote_type = EMOTE_AUDIBLE
	message = "<b>let out a warcry!!</b>"

/datum/emote/living/warcry/get_sound(mob/living/M)
	if(ishuman(M))
		if(M.gender == FEMALE)
			return pick('modular_coyote/sound/voice/warcry_f1.ogg',
				'modular_coyote/sound/voice/warcry_f2.ogg')
		else
			return pick('modular_coyote/sound/voice/warcry_m1.ogg',
				'modular_coyote/sound/voice/warcry_m2.ogg',
				'modular_coyote/sound/voice/warcry_m3.ogg',
				'modular_coyote/sound/voice/warcry_m4.ogg',
				'modular_coyote/sound/voice/warcry_m5.ogg',
				'modular_coyote/sound/voice/warcry_m6.ogg',
				'modular_coyote/sound/voice/warcry_m7.ogg',
				'modular_coyote/sound/voice/warcry_m8.ogg',
				'modular_coyote/sound/voice/warcry_m9.ogg',
				'modular_coyote/sound/voice/warcry_m10.ogg',
				'modular_coyote/sound/voice/warcry_m11.ogg',
				'modular_coyote/sound/voice/warcry_m12.ogg',
				'modular_coyote/sound/voice/warcry_m13.ogg',
				'modular_coyote/sound/voice/warcry_m14.ogg',
				'modular_coyote/sound/voice/warcry_m15.ogg',
				'modular_coyote/sound/voice/warcry_m16.ogg',
				'modular_coyote/sound/voice/warcry_m17.ogg',
				'modular_coyote/sound/voice/warcry_m18.ogg',
				'modular_coyote/sound/voice/warcry_m19.ogg',
				'modular_coyote/sound/voice/warcry_m20.ogg')

/datum/emote/flap
	key = "flap"
	key_third_person = "flaps"
	message = "flaps their wings."

/datum/emote/aflap
	key = "aflap"
	key_third_person = "aflaps"
	message = "flaps their wings ANGRILY!!"

/datum/emote/aflap/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), -1, 5, -4, 0, 0.8 SECONDS)

/datum/emote/flaparms
	key = "flapa"
	key_third_person = "flapas"
	message = "flaps their arms."

/datum/emote/flapa/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), -1, 5, -4, 0, 0.8 SECONDS)

/datum/emote/aflaparms
	key = "aflapa"
	key_third_person = "aflapas"
	message = "flaps their arms ANGRILY!!"

/datum/emote/aflapa/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), -1, 5, -4, 0, 0.8 SECONDS)

/datum/emote/wah
	key = "wah"
	key_third_person = "squeaks like a wah!"
	emote_type = EMOTE_AUDIBLE
	message = "squeaks like a wah!"


/datum/emote/wah/run_emote(mob/user, params) //Player triggers the emote
	. = ..() // the glyph of power
	if(. && iscarbon(user)) // Are they a carbon mob?
		var/mob/living/carbon/C = user
		if(. && isliving(user)) //Are they alive?  The stuff below is the sounds being listed, with percent (the 20s) and then number of times played (1)
			pick(playsound(C, 'sound/f13effects/sunsetsounds/wah1.ogg', 33, 1),playsound(C, 'sound/f13effects/sunsetsounds/wah2.ogg', 33, 1),playsound(C, 'sound/f13effects/sunsetsounds/wah3.ogg', 34, 1),)

/*
/datum/emote/living/boowomp
	key = "boowomp"
	key_third_person = "frowns heavily."
	message = "frowns heavily."
	sound = 'sound/effects/boowomp.ogg'

/datum/emote/living/scrungy
	key = "scrungy"
	key_third_person = "opens their mouth slightly and makes a very pained noise as they take a deep breath through their nose."
	message = "opens their mouth slightly and makes a very pained noise as they take a deep breath through their nose."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/scrungy.ogg'

/datum/emote/living/grungle
	key = "grungle"
	key_third_person = "sounds like a dog gargling soda water just as its about to have a laugh."
	message = "sounds like a dog gargling soda water just as its about to have a laugh."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/gurgle.ogg'

/datum/emote/living/augh
	key = "augh"
	key_third_person = "looks mildly inconvenienced."
	message = "looks mildly inconvenienced."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/augh.ogg'

/datum/emote/living/ree
	key = "ree"
	key_third_person = "reeeeeees."
	message = "reeeeeees."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/frogree.ogg'

/datum/emote/living/eyebrowmenace
	key = "eyebrowboom"
	key_third_person = "raises an eyebrow menacingly!"
	message = "raises an eyebrow menacingly!"
	sound = 'sound/f13effects/sunsetsounds/vineboom.ogg'
*/

/datum/emote/living/frogcry
	key = "frogcry"
	key_third_person = "does an amphibian warcry!"
	message = "does an amphibian warcry!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/frogwarcry.ogg'

/datum/emote/living/bwoing
	key = "bwoing"
	key_third_person = "bounces vivaciously!"
	message = "bounces vivaciously."
	sound = 'sound/effects/bwoing.ogg'


/datum/emote/living/bwoing/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 2, -2, 2, -2, 0.6 SECONDS)

/datum/emote/living/bwoing/skip
	key = "skip"
	key_third_person = "skips!"
	message = "skips."
	sound = null

/datum/emote/living/bounce
	key = "bounce"
	key_third_person = "bounces on their toes!"
	emote_type = EMOTE_AUDIBLE
	message = "bounces on their toes!"

/datum/emote/living/bounce/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 2, 0, 2, 0, 1.5 SECONDS)

/datum/emote/qrattle
	key = "qrattle"
	key_third_person = "rattles their quills worriedly."
	message = "rattles their quills worridly."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/qrattle.ogg'
	sound_volume = 90

/datum/emote/whisker
	key = "whisker"
	key_third_person = "twitches their whiskers!"
	message = "twitches their whiskers!"

/datum/emote/awhisker
	key = "awhisker"
	key_third_person = "twitches their whiskers like they're annoyed!"
	message = "twitches their whiskers like they're annoyed!"

/datum/emote/crinkle
	key = "crinkle"
	key_third_person = "crinkles their nose!"
	message = "crinkles their nose!"

/datum/emote/weh
	key = "weh"
	key_third_person = "wehs"
	message = "let out a weh!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/weh_1.ogg'

/datum/emote/weh/alt1
	key = "weh2"
	key_third_person = "wehs2"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/weh_2.ogg'

/datum/emote/weh/alt2
	key = "weh3"
	key_third_person = "wehs3"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/weh_3.ogg'

/datum/emote/weh/surprised
	key = "weh-s"
	key_third_person = "wehs-s"
	message = "let out a surprised weh!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/weh_s.ogg'

/datum/emote/merp
	key = "merp"
	key_third_person = "merps"
	message = "let out a merp!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/merp.ogg'

/datum/emote/mar
	key = "mar"
	key_third_person = "mars"
	message = "lets out a mar!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/mar.ogg'

/datum/emote/wurble
	key = "wurble"
	key_third_person = "wurbles"
	message = "wurbles contentedly."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/wurble.ogg'

/datum/emote/squeak
	key = "squeak"
	key_third_person = "squeaks"
	message = "let out a tiny squeak!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/mousesqueek.ogg'

/datum/emote/msqueak
	key = "msqueak"
	key_third_person = "msqueaks"
	message = "squeaks!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/squeak_moth.ogg'

/datum/emote/blep
	key = "blep"
	key_third_person = "bleps their tongue out!"
	message = "bleps their tongue out!"

/datum/emote/eyeclean
	key = "eyeclean"
	key_third_person = "flicks their tongue out, cleaning their eyes!"
	message = "flicks their tongue out, cleaning their eyes!"

/datum/emote/preen
	key = "preen"
	key_third_person = "carefully unruffles themselves, preening and trying to regain composure."
	message = "carefully unruffles themselves, preening and trying to regain composure."

/datum/emote/comb
	key = "comb"
	key_third_person = "runs their fingers through their hair, straightning it up some."
	message = "runs their fingers through their hair, straightning it up some."

/datum/emote/rattle
	key = "rattle"
	key_third_person = "rattles a warning!"
	message = "rattles a warning!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/rattle.ogg'

/datum/emote/rattle/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, TYPE_PROC_REF(/atom/,do_double_bounce), 1, -1, 1, -1, 1.5 SECONDS)

/datum/emote/snakehiss
	key = "shiss"
	key_third_person = "hisses like a reptile!"
	message = "hisses like a reptile!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/snakehiss.ogg'

//Fenny Adds Flirtatious Fucking Emotes For Furries//


//	key_third_person = "blushes"
//	message = "blushes."
//	message_param = "blushes at %t."

/datum/emote/living/flirt
	key = "flirty"
	key_third_person = "is being a little <span class='love'>flirty!</span>"
	message = "is being a little <span class='love'>flirty!</span>"
	message_param = "is <span class='love'>flirting with</span> %t sneakily!"
	sound = 'sound/f13effects/sunsetsounds/blush.ogg'
	message_range = 2


//Bubber Theft :)//
/datum/emote/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "chirps!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/chirp.ogg'

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "caws twice!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/caw2.ogg'

/datum/emote/living/mrrp //you play like a cat
	key = "mrrp"
	key_third_person = "mrrps"
	message = "mrrps!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/mrrp.ogg'

/datum/emote/living/fpurr
	key = "fpurr"
	key_third_person = "purrs!"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/fox_purr.ogg'

/datum/emote/living/prbt //all tesh players will love me
	key = "prbt"
	key_third_person = "prbts!"
	message = "prbts!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/prbt.ogg'

/datum/emote/living/gecker
	key = "gecker"
	key_third_person = "geckers"
	message = "geckers!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/foxgecker.ogg'

/datum/emote/living/mow //cat looking ass playing brick game looking ass cat i swear to god I'm taking you to the vet merek
	key = "mow"
	key_third_person = "mows like an sad cat."
	message = "mows!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/mow.ogg'

/datum/emote/living/yip
	key = "yip"
	key_third_person = "yips"
	message = "yips!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/yip.ogg'

/datum/emote/living/woof
	key = "woof"
	key_third_person = "woofs"
	message = "woofs!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/woof.ogg'

/datum/emote/living/woof/alt
	key = "woof2"
	key_third_person = "woofs2"
	sound = 'modular_splurt/sound/voice/woof2.ogg'

/datum/emote/living/whine
	key = "whine"
	key_third_person = "whines"
	message = "whines..."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/whine.ogg'

/datum/emote/living/coo
	key = "coo"
	key_third_person = "coos"
	message = "coos."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/coo.ogg'

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "hoots!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/hoot.ogg'

/datum/emote/living/hiss2 // Since normal hiss is tied to the Xenomorph Race (i think?)
	key = "hiss2"
	key_third_person = "hisses2"
	message = "let out a short hiss!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_citadel/sound/voice/hiss.ogg'

/datum/emote/living/bark2
	key = "bark2"
	key_third_person = "barks2"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bark2/run_emote(mob/user, params) //Player triggers the emote
	. = ..() // the glyph of power
	if(. && iscarbon(user)) // Are they a carbon mob?
		var/mob/living/carbon/C = user
		if(. && (user.stat == CONSCIOUS)) //Are they alive?  The stuff below is the sounds being listed, with percent (the 20s) and then number of times played (1)
			pick(playsound(C, 'modular_citadel/sound/voice/bark1.ogg', 33, 1), playsound(C, 'modular_citadel/sound/voice/bark2.ogg', 33, 1))

/datum/emote/living/headtilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
	message_param = "tilts their head at %t."

/*
/datum/emote/living/rizz
	key = "rizz"
	key_third_person = "rizzler"
	message = "<span class='hypnophrase'>radiates powerful rizz</span>"
	message_param = "<span class='hypnophrase'>%t</span>" //Funny color text
	sound = "modular_splurt/sound/voice/rizz.ogg"

/datum/emote/living/threaten
	key = "threaten"
	key_third_person = "threaten"
	message = "<span class='velvet'>radiates a menacing aura.</span>"
	message_param = "<span class='velvet'>%t</span>" //Funny red text
	sound = "modular_splurt/sound/voice/waterphone.ogg"

/datum/emote/living/accusation
	key = "accuse"
	key_third_person = "accusation"
	message = "says, <span class='blockytext'>O B J E C T I O N !!</span>"
	message_param = "<span class='blockytext'>%t</span>" //Funny block text
	sound = "modular_splurt/sound/voice/deathglare.ogg"

/datum/emote/living/urgent
	key = "urgent"
	key_third_person = "urgency"
	message = "<span class='urgent'>draws attention to themselves!</span>"
	message_param = "<span class='urgent'>%t</span>" //Funny block text
	sound = "modular_splurt/sound/voice/alienbeeper.ogg"
*/

//Slime start

//Framework
/* /mob/living/carbon/human/species/slime/regenerate_icons()
	cut_overlays()
	if(slime_mood && !stat)
		add_overlay("aslime-[mood]")
	else
		return
	..() */
//Framework end

/datum/emote/mood
	key = "slimenone"
	message = null
	var/slime_mood = null
	mob_type_allowed_typecache = /mob/living/carbon/human

/datum/emote/mood/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/datum/species/S = H?.dna?.species
		if(istype(S, /datum/species/feral/slime))
			S.slime_mood = slime_mood
			S.handle_body(H)

/*
/datum/emote/mood/sneaky
	key = "slimesneaky"
	slime_mood = "aslime-mischevous"

/datum/emote/mood/smile
	key = "slimesmile"
	slime_mood = "aslime-:3"

/datum/emote/mood/cat
	key = "slimecat"
	slime_mood = "aslime-:33"

/datum/emote/mood/pout
	key = "slimepout"
	slime_mood = "aslime-pout"

/datum/emote/mood/sad
	key = "slimesad"
	slime_mood = "aslime-sad"

/datum/emote/mood/angry
	key = "slimeangry"
	slime_mood = "aslime-angry"

// Slime end
*/

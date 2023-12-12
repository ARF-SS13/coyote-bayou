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
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 1, -1, 1, -1, 1 SECONDS)

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
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 2, -1, 1, -1, 1 SECONDS)

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

/datum/emote/hearthand
	key = "hearthand"
	key_third_person = "hearthands"
	message = "makes a heart with their hands."
	message_param = "makes a heart with their hands at %t."
	restraint_check = TRUE

/datum/emote/ok
	key = "ok"
	key_third_person = "oks"
	message = "makes an okay sign with their hand."
	message_param = "makes an okay sign with their hand at %t."
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

/datum/emote/living/faint/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.SetSleeping(200)

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
			addtimer(CALLBACK(H, open ? /mob/living/carbon/human/atom/.proc/OpenWings : /mob/living/carbon/human/atom/.proc/CloseWings), wing_time)

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
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 1, -1, 1, -1, 0.5 SECONDS)

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

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "grimaces."
	message_param = "grimaces at %t."

/datum/emote/living/jump
	key = "jump"
	key_third_person = "jumps"
	restraint_check = TRUE

/datum/emote/living/jump/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, -1, 5, -4, 0, 0.8 SECONDS)

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

/datum/emote/living/audible/laugh/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 2, -2, 2, -2, 1.5 SECONDS)

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
	sound = 'sound/voice/moth/mothchitter.ogg'


/datum/emote/living/nod
	key = "nod"
	key_third_person = "nods"
	message = "nods."
	message_param = "nods at %t."

/datum/emote/living/look
	key = "look"
	key_third_person = "looks at something."
	message = "looks at something."
	message_param = "looks at %t."

/datum/emote/living/nibl
	key = "nibl"
	key_third_person = "nibbles on something."
	message = "nibbles on something."
	message_param = "nibbles on %t."

/datum/emote/living/fenfrantic
	key = "fenfrantic"
	key_third_person = "geckers frantically!"
	message = "geckers frantically!"
	message_param = "geckers frantically at %t"
	sound = 'sound/f13effects/sunsetsounds/fenfrantic.ogg'

/datum/emote/living/nod/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_directional_tilt, 5, 0.5 SECONDS)

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
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 1, -1, 1, -1, 1.2 SECONDS)

/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "shiver"
	message = "shivers."
	message_param = "shivers from the %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shiver/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 1, -1, 1, -1, 1 SECONDS)

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

/datum/emote/living/sit
	key = "sit"
	key_third_person = "sits"
	message = "sits down."
	message_param = "sits down on %t."

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

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "sneezes."
	message_param = "sneezes from %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shake/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 2, -2, 2, -2, 1.5 SECONDS)

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
	message = user.say_emphasis(message)
	var/msg_check = user.say_narrate_replace(message, user)
	if(msg_check)
		message = msg_check
		omit_left_name = TRUE
	. = ..()
	omit_left_name = FALSE
	message = null

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

/datum/emote/living/circle
	key = "circle"
	key_third_person = "circles"
	restraint_check = TRUE

/datum/emote/living/circle/run_emote(mob/user, params)
	. = ..()
	var/obj/item/circlegame/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("You make a circle with your hand."))
	else
		qdel(N)
		to_chat(user, span_warning("You don't have any free hands to make a circle with."))

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
	sound = 'sound/f13effects/sunsetsounds/YeenCackle.ogg' //Sound played.

	//I don't like how this looks, if someone knows a better way please do so or tell me.
/datum/emote/coyawoo
	key = "coyawoo"
	key_third_person = "howls like a coyote"
	message = "howls like a coyote!"

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
	sound = 'sound/f13effects/sunsetsounds/cat_purr.ogg'


/datum/emote/purrlong
	key = "purrlong"
	key_third_person = "purrs contentedly"
	message = "purrs contentedly."
	sound = 'sound/f13effects/sunsetsounds/cat_purr_long.ogg'


/datum/emote/geckers
	key = "geck"
	key_third_person = "geckers loudly"
	message = "geckers loudly."
	sound = 'sound/f13effects/sunsetsounds/geck.ogg'


/datum/emote/growl
	key = "growl"
	key_third_person = "growls viciously"
	message = "growls viciously."
	sound = 'sound/f13effects/sunsetsounds/growl.ogg'


/datum/emote/moo
	key = "moo"
	key_third_person = "moos"
	message = "moos."
	sound = 'sound/f13effects/sunsetsounds/moo.ogg'


/datum/emote/mrowl
	key = "mrowl"
	key_third_person = "mrowls"
	message = "mrowls."
	sound = 'sound/f13effects/sunsetsounds/mrowl.ogg'

/datum/emote/meowrek
	key = "meowrek"
	key_third_person = "definitely sounds like a cat of all time."
	message = "mrowls."
	sound = 'sound/f13effects/sunsetsounds/meowrek.ogg'


/datum/emote/nya //Kitten Must Die.ogg
	key = "nya"
	key_third_person = "nyas"
	message = "nyas."
	sound = 'sound/f13effects/sunsetsounds/nya.ogg'


/datum/emote/wolfwhistle //Yeah baby that's what I like!
	key = "wolfwhistle"
	key_third_person = "wolf whistles"
	message = "wolf whistles!"
	sound = 'sound/f13effects/sunsetsounds/wolfwhistle.ogg'

/datum/emote/kyaa
	key = "kyaa"
	key_third_person = "kyaas"
	message = "kyaas loudly!"
	sound = 'sound/f13effects/sunsetsounds/birdkyaa.ogg'

/datum/emote/bork
	key = "bork"
	key_third_person = "borks"
	message = "borks!"
	sound = 'sound/f13effects/sunsetsounds/bork.ogg'

/datum/emote/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks!"
	sound = 'sound/f13effects/sunsetsounds/bark.ogg'

/datum/emote/yap
	key = "yap"
	key_third_person = "yaps"
	message = "yaps!"
	sound = 'sound/f13effects/sunsetsounds/yap.ogg'

/datum/emote/barkmisery
	key = "mbark"
	key_third_person = "barks miserably"
	message = "barks miserably!"
	sound = 'sound/f13effects/sunsetsounds/dog-miserable.ogg'

/datum/emote/cougar
	key = "cougar"
	key_third_person = "growls like a cougar"
	message = "growls like a cougar!"
	sound = 'sound/f13effects/sunsetsounds/cougar.ogg'

/datum/emote/trumpet
	key = "trumpet"
	key_third_person = "trumpets"
	message = "trumpets!"
	sound = 'sound/f13effects/sunsetsounds/trumpet.ogg'

/datum/emote/fenbark
	key = "fenbark"
	key_third_person = "makes a fennec-y bark"
	message = "makes a fennec-y bark!"
	sound = 'sound/f13effects/sunsetsounds/fenbark.ogg'

/datum/emote/foxbark
	key = "foxbark"
	key_third_person = "makes a foxy bark"
	message = "makes a foxy bark!"
	sound = 'sound/f13effects/sunsetsounds/foxbark.ogg'

/datum/emote/lynx
	key = "lynx"
	key_third_person = "growls like a bobcat"
	message = "growls like a bobcat!"
	sound = 'sound/f13effects/sunsetsounds/lynx.ogg'

/datum/emote/panda //yee
	key = "panda"
	key_third_person = "makes a panda like... noise"
	message = "makes a panda like... noise?"
	sound = 'sound/f13effects/sunsetsounds/panda.ogg'

/datum/emote/lynx
	key = "lynx"
	key_third_person = "growls like a bobcat"
	message = "growls like a bobcat!"
	sound = 'sound/f13effects/sunsetsounds/lynx.ogg'

/datum/emote/bun
	key = "bun"
	key_third_person = "squeals like a rabbit"
	message = "squeals like a rabbit!"
	sound = 'sound/f13effects/sunsetsounds/rabbit.ogg'

/datum/emote/wolfhowl
	key = "wolfhowl"
	key_third_person = "howls like a wolf"
	message = "howls like a wolf!"
	sound = 'sound/f13effects/sunsetsounds/wolfhowl.ogg'

/datum/emote/whistlecome
	key = "come"
	key_third_person = "whistles to get someones attention"
	message = "whistles to get someones attention!"
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
	sound = 'sound/f13effects/sunsetsounds/waa.ogg'

/datum/emote/warcry
	key = "warcry"
	key_third_person = "warcrys"
	message = "<b>let out a warcry!!</b>"

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
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, -1, 5, -4, 0, 0.8 SECONDS)

/datum/emote/flaparms
	key = "flapa"
	key_third_person = "flapas"
	message = "flaps their arms."

/datum/emote/flapa/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, -1, 5, -4, 0, 0.8 SECONDS)

/datum/emote/aflaparms
	key = "aflapa"
	key_third_person = "aflapas"
	message = "flaps their arms ANGRILY!!"

/datum/emote/aflapa/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, -1, 5, -4, 0, 0.8 SECONDS)

/datum/emote/wah
	key = "wah"
	key_third_person = "squeaks like a wah!"
	message = "squeaks like a wah!"


/datum/emote/wah/run_emote(mob/user, params) //Player triggers the emote
	. = ..() // the glyph of power
	if(. && iscarbon(user)) // Are they a carbon mob?
		var/mob/living/carbon/C = user
		if(. && isliving(user)) //Are they alive?  The stuff below is the sounds being listed, with percent (the 20s) and then number of times played (1)
			pick(playsound(C, 'sound/f13effects/sunsetsounds/wah1.ogg', 33, 1),playsound(C, 'sound/f13effects/sunsetsounds/wah2.ogg', 33, 1),playsound(C, 'sound/f13effects/sunsetsounds/wah3.ogg', 34, 1),)


/datum/emote/living/boowomp
	key = "boowomp"
	key_third_person = "frowns heavily."
	message = "frowns heavily."
	sound = 'sound/effects/boowomp.ogg'

/datum/emote/living/scrungy
	key = "scrungy"
	key_third_person = "opens their mouth slightly and makes a very pained noise as they take a deep breath through their nose."
	message = "opens their mouth slightly and makes a very pained noise as they take a deep breath through their nose."
	sound = 'sound/effects/scrungy.ogg'

/datum/emote/living/grungle
	key = "grungle"
	key_third_person = "sounds like a dog gargling soda water just as its about to have a laugh."
	message = "sounds like a dog gargling soda water just as its about to have a laugh."
	sound = 'sound/effects/gurgle.ogg'

/datum/emote/living/augh
	key = "augh"
	key_third_person = "looks mildly inconvenienced."
	message = "looks mildly inconvenienced."
	sound = 'sound/f13effects/sunsetsounds/augh.ogg'

/datum/emote/living/ree
	key = "ree"
	key_third_person = "reeeeeees."
	message = "reeeeeees."
	sound = 'sound/f13effects/sunsetsounds/frogree.ogg'

/datum/emote/living/eyebrowmenace
	key = "eyebrowboom"
	key_third_person = "raises an eyebrow menacingly!"
	message = "raises an eyebrow menacingly!"
	sound = 'sound/f13effects/sunsetsounds/vineboom.ogg'

/datum/emote/living/frogcry
	key = "frogcry"
	key_third_person = "does an amphibian warcry!"
	message = "does an amphibian warcry!"
	sound = 'sound/f13effects/sunsetsounds/frogwarcry.ogg'

/datum/emote/living/bwoing
	key = "bwoing"
	key_third_person = "bounces vivaciously!"
	message = "bounces vivaciously."
	sound = 'sound/effects/bwoing.ogg'


/datum/emote/living/bwoing/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 2, -2, 2, -2, 0.6 SECONDS)

/datum/emote/living/bwoing/skip
	key = "skip"
	key_third_person = "skips!"
	message = "skips."
	sound = null

/datum/emote/living/bounce
	key = "bounce"
	key_third_person = "bounces on their toes!"
	message = "bounces on their toes!"

/datum/emote/living/bounce/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 2, 0, 2, 0, 1.5 SECONDS)

/datum/emote/plap
	key = "plap"
	key_third_person = "plaps?"
	message = "plaps?"

/datum/emote/plap/run_emote(mob/user, params) //Player triggers the emote
	. = ..() // Hell if I know
	if(. && iscarbon(user)) // Are they a carbon mob?
		var/mob/living/carbon/C = user
		if(. && isliving(user)) //Are they alive?  The stuff below is the sounds being listed, with percent (the 20s) and then number of times played (1)
			pick(playsound(C, 'sound/f13effects/sunsetsounds/plap1.ogg', 20, 1),playsound(C, 'sound/f13effects/sunsetsounds/plap2.ogg', 20, 1),playsound(C, 'sound/f13effects/sunsetsounds/plap3.ogg', 20, 1))

/datum/emote/gecko
	key = "gecko"
	key_third_person = "makes a gecko sound!"
	message = "makes a gecko sound!"
	sound = 'sound/f13npc/gecko/geckocall2.ogg'

/datum/emote/aie
	key = "aie"
	key_third_person = "makes a high pitched sound as if someone has lit their ass on fire with a blowtorch!"
	message = "makes a high pitched sound as if someone has lit their ass on fire with a blowtorch!"
	sound = 'sound/f13effects/sunsetsounds/aie.ogg'

/datum/emote/aie/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 0, 5, 0, 0, 0.8 SECONDS)


/datum/emote/nightstalker
	key = "nstalker"
	key_third_person = "doesn't sound happy!"
	message = "doesn't sound happy!"
	sound = 'sound/f13npc/nightstalker/aggro3.ogg'


/datum/emote/qrattle
	key = "qrattle"
	key_third_person = "rattles their quills worriedly."
	message = "rattles their quills worridly."
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
	sound = 'sound/f13effects/sunsetsounds/weh_1.ogg'

/datum/emote/weh/alt1
	key = "weh2"
	key_third_person = "wehs2"
	sound = 'sound/f13effects/sunsetsounds/weh_2.ogg'

/datum/emote/weh/alt2
	key = "weh3"
	key_third_person = "wehs3"
	sound = 'sound/f13effects/sunsetsounds/weh_3.ogg'

/datum/emote/weh/surprised
	key = "weh-s"
	key_third_person = "wehs-s"
	message = "let out a surprised weh!"
	sound = 'sound/f13effects/sunsetsounds/weh_s.ogg'

/datum/emote/merp
	key = "merp"
	key_third_person = "merps"
	message = "let out a merp!"
	sound = 'sound/f13effects/sunsetsounds/merp.ogg'
/datum/emote/mar
	key = "mar"
	key_third_person = "mars"
	message = "lets out a mar!"
	sound = 'sound/f13effects/sunsetsounds/mar.ogg'
/datum/emote/wurble
	key = "wurble"
	key_third_person = "wurbles"
	message = "wurbles contentedly."
	sound = 'sound/f13effects/sunsetsounds/wurble.ogg'
/datum/emote/squeak
	key = "squeak"
	key_third_person = "squeaks"
	message = "let out a tiny squeak!"
	sound = 'sound/effects/mousesqueek.ogg'

/datum/emote/msqueak
	key = "msqueak"
	key_third_person = "msqueaks"
	message = "squeaks!"
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
	sound = 'sound/f13effects/sunsetsounds/rattle.ogg'

/datum/emote/rattle/run_emote(mob/user, params)
	. = ..()
	INVOKE_ASYNC(user, /atom/.proc/do_double_bounce, 1, -1, 1, -1, 1.5 SECONDS)


/datum/emote/snakehiss
	key = "shiss"
	key_third_person = "hisses like a reptile!"
	message = "hisses like a reptile!"
	sound = 'sound/f13effects/sunsetsounds/snakehiss.ogg'

/datum/emote/look
	key = "look"
	key_third_person = "looks"
	message = "looks!"

/datum/emote/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "buzzes."
	message_param = "buzzes at %t."
	sound_vary = TRUE
	sound = 'sound/machines/buzz-sigh.ogg'

/datum/emote/buzz2
	key = "buzz2"
	message = "buzzes twice."
	sound_vary = TRUE
	sound = 'sound/machines/buzz-two.ogg'

/datum/emote/yes
	key = "yes"
	message = "emits an affirmative blip."
	sound_vary = TRUE
	sound = 'sound/machines/synth_yes.ogg'

/datum/emote/no
	key = "no"
	message = "emits a negative blip."
	sound_vary = TRUE
	sound = 'sound/machines/synth_no.ogg'

/datum/emote/ping
	key = "ping"
	key_third_person = "pings"
	message = "pings."
	message_param = "pings at %t."
	sound_vary = TRUE
	sound = 'sound/machines/ping.ogg'

/datum/emote/chime
	key = "chime"
	key_third_person = "chimes"
	message = "chimes."
	sound_vary = TRUE
	sound = 'sound/machines/chime.ogg'

/datum/emote/ding
	key = "ding"
	key_third_person = "dings"
	message = "dings!"
	sound_vary = TRUE
	sound = 'sound/machines/ding.ogg'

/datum/emote/beep
	key = "beep"
	key_third_person = "be-beeps"
	message = "be-beeps!"
	sound_vary = TRUE
	sound = 'sound/machines/twobeep.ogg'

/datum/emote/beep2
	key = "beep2"
	key_third_person = "be-beeps"
	message = "be-beeps!"
	sound_vary = TRUE
	sound = 'sound/machines/twobeep_high.ogg'

/datum/emote/beep3
	key = "beep3"
	key_third_person = "beeps"
	message = "beeps!"
	message_param = "beeps at %t."
	sound_vary = TRUE
	sound = 'sound/machines/beep.ogg'

/datum/emote/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "chirps happily!"
	sound_vary = TRUE
	sound = 'sound/machines/dwoop.ogg'

/datum/emote/honk
	key = "honk"
	key_third_person = "honks"
	message = "honks."
	emote_type = EMOTE_AUDIBLE
	sound_vary = TRUE
	sound = 'sound/items/bikehorn.ogg'

/datum/emote/sad
	key = "sad"
	message = "plays a sad trombone..."
	sound = 'sound/misc/sadtrombone.ogg'

/datum/emote/warn
	key = "warn"
	message = "blares an alarm!"
	sound = 'sound/machines/warning-buzzer.ogg'

#define EMOTE_SPECIAL_STR "Strength"
#define EMOTE_SPECIAL_PER "Perception"
#define EMOTE_SPECIAL_END "Endurance"
#define EMOTE_SPECIAL_CHA "Charisma"
#define EMOTE_SPECIAL_INT "Intelligence"
#define EMOTE_SPECIAL_AGI "Agility"
#define EMOTE_SPECIAL_LCK "Luck"
#define EMOTE_SPECIAL_GEN "???"
#define EMOTE_SPECIAL_SUF "Crit"

GLOBAL_LIST_INIT(special_skill_list, list(
	EMOTE_SPECIAL_STR,
	EMOTE_SPECIAL_PER,
	EMOTE_SPECIAL_END,
	EMOTE_SPECIAL_CHA,
	EMOTE_SPECIAL_INT,
	EMOTE_SPECIAL_AGI,
	EMOTE_SPECIAL_LCK,
	EMOTE_SPECIAL_GEN))

GLOBAL_LIST_INIT(special_triggers, list(
	EMOTE_SPECIAL_STR = list(
		"s",
		"str",
		"strength",
		"strangth",
		"strong",
		"strongth",
		"might",
		"power"),
	EMOTE_SPECIAL_PER = list(
		"p",
		"per",
		"perception",
		"preception",
		"look",
		"see",
		"peep"),
	EMOTE_SPECIAL_END = list(
		"e",
		"end",
		"endurance",
		"endurence",
		"toughness",
		"tough",
		"grit",
		"beef",
		"beefiness"),
	EMOTE_SPECIAL_CHA = list(
		"c",
		"cha",
		"charisma",
		"charesma",
		"charm",
		"moxie",
		"smarm",
		"wink",
		"char"),
	EMOTE_SPECIAL_INT = list(
		"int",
		"i",
		"intelligence",
		"inteligence",
		"intelligance",
		"inteligance",
		"intel",
		"intell",
		"intelect",
		"intellect",
		"smart",
		"smartness",
		"nerd",
		"nerdiness",
		"dork",
		"dorkiness",
		"dweeb",
		"dweebishness"),
	EMOTE_SPECIAL_AGI = list(
		"agi",
		"a",
		"agility",
		"agillity",
		"quick",
		"quickness",
		"fast",
		"fastness",
		"dex",
		"speed",
		"speediness",
		"athleticism",
		"acrobatics",
		"escape",
		"dodge",
		"evade",
		"evasion",
		"cat"),
	EMOTE_SPECIAL_LCK = list(
		"l",
		"lck",
		"luck",
		"lick",
		"lock",
		"lunk",
		"link",
		"chance",
		"fortune",
		"dice",
		"luk",
		"luc"),
	EMOTE_SPECIAL_GEN = list(
		"x",
		"non",
		"none",
		"generic",
		"something",
		"else",
		"smth",
		"?",
		"rand",
		"huh",
		"stuff",
		"roll")))

GLOBAL_LIST_INIT(special_phrases, list(
	EMOTE_SPECIAL_STR = list(
		"initial" = list(
			"tests their strength...",
			"flexes their arm(s)...",
			"prepares to lift...",
			"puts their back into it..."),
		"success" = list(
			"is strong!",
			"is beefy!",
			"has some serious guns!",
			"had some strength behind it!"),
		"failure" = list(
			"was too weak.",
			"was a little wet noodle.",
			"would loose an arm wrestling match with a mouse.",
			"has some serious atrophy. it's a wonder they can move at all.")),
	EMOTE_SPECIAL_PER = list(
		"initial" = list(
			"takes a good, long look...",
			"squints...",
			"looks around...",
			"focuses in..."),
		"success" = list(
			"was perceptive!",
			"noticed things!",
			"has eyes like a hawk!",
			"could find Doc Mitchell's keys!",
			"noticed whatever they were trying to see!"),
		"failure" = list(
			"was totally oblivious.",
			"forgot their glasses.",
			"didn't see anything.")),
	EMOTE_SPECIAL_END = list(
		"initial" = list(
			"tests their toughness...",
			"braces themself..."),
		"success" = list(
			"was tough!",
			"was one tough cookie!",
			"doesn't even flinch!",
			"is solid as an oak!",
			"endured!"),
		"failure" = list(
			"is a floppy lil' noodle.",
			"is made of paper.",
			"would be torn to shreds by a light breeze.",
			"crumpled up and blew away.")),
	EMOTE_SPECIAL_CHA = list(
		"initial" = list(
			"starts to be charismatic...",
			"puts on the charm..."),
		"success" = list(
			"was charismatic!",
			"is an absolute charmer!",
			"was good and charming!"),
		"failure" = list(
			"was totally uncharismatic.",
			"isn't fooling anyone.",
			"put their foot in their mouth.",
			"could hear a pin drop.",
			"miiiiight have some frontal lobe damage.",
			"had their charms fall flat.")),
	EMOTE_SPECIAL_INT = list(
		"initial" = list(
			"thinks hard...",
			"ponders hard...",
			"takes a moment to think...",
			"furrows their brow..."),
		"success" = list(
			"was clever!",
			"is a genius!",
			"has a mind sharp as a whip!",
			"had a thought!"),
		"failure" = list(
			"was dumb as a doornail.",
			"burned their last braincell years ago.",
			"is running low on braincells.",
			"was dense as a brick.")),
	EMOTE_SPECIAL_AGI = list(
		"initial" = list(
			"tries to get agile...",
			"prepares their moves...",
			"starts to get limber..."),
		"success" = list(
			"was very flexible!",
			"had some excellent footwork!",
			"was in perfect control!",
			"was agile as a cat!",
			"was agile as a fox!"),
		"failure" = list(
			"fell flat on their face.",
			"fell flat on their back.",
			"triped over themself.",
			"has two left feet.",
			"was clumsy as a cat.",
			"was clumsy as a fox.")),
	EMOTE_SPECIAL_LCK = list(
		"initial" = list(
			"tries their luck...",
			"takes a chance...",
			"puts it all on red..."),
		"success" = list(
			"lucked out!",
			"was the luckiest son-of-a-gun in the wasteland!",
			"could make a bullet turn right around and climb back into the gun!",
			"got lucky!"),
		"failure" = list(
			"was unlucky.",
			"realized their game was rigged from the start.",
			"showed that the house always wins.")),
	EMOTE_SPECIAL_GEN = list(
		"initial" = list(
			"tests their skills...",
			"tries their skills...",
			"attempts to do a thing...",
			"puts their skills to the test..."),
		"success" = list(
			"succeeded!",
			"did it!"),
		"failure" = list(
			"was really bad at whatever they did.",
			"just really sucked.",
			"messed up real bad.")),
	EMOTE_SPECIAL_SUF = list(
		"initial" = list(
			"shouldnt see this lol"),
		"success" = list(
			"Ring-a-ding baby!",
			"Wow!"),
		"failure" = list(
			"How could someone mess up so badly?",
			"The game was rigged from the start."))))


/datum/emote/living/special
	key = "special"
	message = null
	cooldown = 2.5 SECONDS // longer than it takes for the emote to run
	stat_allowed = UNCONSCIOUS
	/// Delay between doing the emote and getting the results
	var/special_delay = 2 SECONDS
	/// So keybinds can use these emotes ezpz
	var/special_override

/datum/emote/living/special/s
	key = "special_strength"
	special_override = EMOTE_SPECIAL_STR

/datum/emote/living/special/p
	key = "special_perception"
	special_override = EMOTE_SPECIAL_PER

/datum/emote/living/special/e
	key = "special_endurance"
	special_override = EMOTE_SPECIAL_END

/datum/emote/living/special/c
	key = "special_charisma"
	special_override = EMOTE_SPECIAL_CHA

/datum/emote/living/special/i
	key = "special_intelligence"
	special_override = EMOTE_SPECIAL_INT

/datum/emote/living/special/a
	key = "special_agility"
	special_override = EMOTE_SPECIAL_AGI

/datum/emote/living/special/l
	key = "special_luck"
	special_override = EMOTE_SPECIAL_LCK

/datum/emote/living/special/run_emote(mob/user, params, type_override, intentional = FALSE)
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if(jobban_isbanned(user, "emote"))	// emote ban
		to_chat(user, "You cannot send emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)	// muted
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE

	if(isnull(user.special_a))
		to_chat(user, span_phobia("You arent special."))
		to_chat(user, span_notice("Mainly because you're playing a mob withough any special skills. This is probably a bug~"))
		return FALSE

	var/special_noun = null
	var/special_phrase_input = special_override ? special_override : lowertext(params)

	for(var/which_special in GLOB.special_skill_list)
		/// if the thing we said after the emote is in one of these lists, pick the corresponding key
		if(special_phrase_input in GLOB.special_triggers[which_special])
			special_noun = which_special

	if(!(special_noun in GLOB.special_skill_list) || !special_noun)
		to_chat(user, span_alert("That's not a valid SPECIAL stat!"))
		to_chat(user, span_notice("To use this emote, type '*special' followed by a SPECIAL stat. For instance, '*special luck' will do a (luck*10)% roll and say if you passed or not."))
		var/valid_specials
		for(var/word in GLOB.special_triggers)
			valid_specials += "[GLOB.special_triggers[word][1]], "
			valid_specials += "[GLOB.special_triggers[word][2]]. "
		to_chat(user, span_notice("Some of the valid SPECIAL keywords are:[valid_specials]."))
		return

	var/special_skill = null
	switch(special_noun)
		if(EMOTE_SPECIAL_STR)
			special_skill = user.special_s
		if(EMOTE_SPECIAL_PER)
			special_skill = user.special_p
		if(EMOTE_SPECIAL_END)
			special_skill = user.special_e
		if(EMOTE_SPECIAL_CHA)
			special_skill = user.special_c
		if(EMOTE_SPECIAL_INT)
			special_skill = user.special_i
		if(EMOTE_SPECIAL_AGI)
			special_skill = user.special_a
		if(EMOTE_SPECIAL_LCK)
			special_skill = user.special_l
		if(EMOTE_SPECIAL_GEN) // generic random 50% chance
			special_skill = 5

	var/first_phrase = pick(GLOB.special_phrases[special_noun]["initial"])
	var/message_first = span_notice("\[[special_noun], [special_skill]0%] <b>[user]</b> [first_phrase].")	// [Luck, 100%] User tests their Luck.

	user.visible_message(
		message = message_first,
		self_message = message_first,
		blind_message = message_first)
	user.emote_for_ghost_sight(message_first)

	spawn(special_delay)
		if(!user)
			return
		if(!can_run_emote(user, TRUE,intentional))
			return

		var/message_second
		if(prob(special_skill * 10))
			var/success_phrase = pick(GLOB.special_phrases[special_noun]["success"])
			if(prob(5)) // crit success!
				success_phrase += " [pick(GLOB.special_phrases[EMOTE_SPECIAL_SUF]["success"])]"
			message_second = span_green("\[Success\] <b>[user]</b> [success_phrase]") // [Success] User is pretty lucky!
		else
			var/fail_phrase = pick(GLOB.special_phrases[special_noun]["failure"])
			if(prob(5)) // crit fail!
				fail_phrase += " [pick(GLOB.special_phrases[EMOTE_SPECIAL_SUF]["failure"])]"
			message_second = span_red("\[Failure\] <b>[user]</b> [fail_phrase]") // [Failure} User isn't very lucky...

		user.visible_message(
			message = message_second,
			self_message = message_second,
			blind_message = message_second)
		user.emote_for_ghost_sight(message_second)

/datum/emote/help
	key = "helpme"
	key_third_person = "yells for help!"
	message = "says, \"Help!\""

/datum/emote/medic
	key = "medic"
	key_third_person = "yells for a medic!"
	message = "says, \"Medic!\""

/datum/emote/healerhere
	key = "healer"
	key_third_person = "is clearly offering their services as a healer!"
	message = "says, \"Healer for hire!\""

/datum/emote/holdstill
	key = "hold"
	key_third_person = "is trying to get someone to hold still!"
	message = "says, \"Hold up!\""

/datum/emote/pullback
	key = "pullback"
	key_third_person = "is trying to get everyone to pull back!"
	message = "says, \"Pull back!\""


//Fenny Adds Flirtatious Fucking Emotes For Furries//


//	key_third_person = "blushes"
//	message = "blushes."
//	message_param = "blushes at %t."

/datum/emote/living/flirt/
	key = "flirt"
	key_third_person = "is being a little <span class='love'>flirty!</span>"
	message = "is being a little <span class='love'>flirty!</span>"
	message_param = "is <span class='love'>flirting with</span> %t sneakily!"
	sound = 'sound/f13effects/sunsetsounds/blush.ogg'
	message_range = 2

/* For making new flirt/affection options
datum/emote/living/flirt/blank
	key = "flirtblank"
	key_third_person = "<span class='love'></span> someone!"
	message = "<span class='love'></span> someone!"
	message_param = "<span class='love'></span> %t!"
*/

datum/emote/living/flirt/custom
	key = "flirtcustom"
	key_third_person = "is trying to <span class='love'>be flirty!</span>"
	message = "is trying to <span class='love'>%t</span>"
	message_param = "is trying to <span class='love'>%t</span>"

/datum/emote/living/flirt/flirtlookat
	key = "flirtlookat"
	key_third_person = "is <span class='love'>eyeing up</span> somebody!"
	message = "is <span class='love'>eyeing up</span> somebody!"
	message_param = "is <span class='love'>eyeing up</span> %t sneakily!"

datum/emote/living/flirt/flirtaccept
	key = "flirtaccept"
	key_third_person = "lets whoever continue whatever it is they were <span class='userlove'>doing!</span>"
	message = "lets whoever continue whatever it is they were <span class='userlove'>doing!</span>"
	message_param = "lets %t continue whatever it is they were <span class='userlove'>doing!</span>"

datum/emote/living/flirt/flirtreject
	key = "flirtreject"
	key_third_person = "<span class='danger'>stops someone cold</span>, refusing to go on with this."
	message = "<span class='danger'>stops someone cold</span>, refusing to go on with this."
	message_param = "<span class='>danger'stops %t cold</span>, refusing to go on with this."
	sound = 'sound/effects/ding.ogg'

datum/emote/living/flirt/flirtblush
	key = "flirtblush"
	key_third_person = "is <span class='love'>blushing deeply</span> at %t, their mind has clearly wandered a bit!"
	message = "is <span class='love'>blushing deeply</span> at %t, their mind has clearly wandered a bit!"
	message_param = "is <span class='love'>blushing deeply</span> at %t, their mind has clearly wandered a bit!"

datum/emote/living/flirt/flirtsniff
	key = "flirtsniff"
	key_third_person = "sniffs at somebody disapprovingly, but <span class='love'>do they mean it?</span>"
	message = "sniffs at somebody disapprovingly, but <span class='love'>do they mean it?</span>"
	message_param = "sniffs at %t disapprovingly, but <span class='love'>do they mean it?</span>"

datum/emote/living/flirt/flirtsmell
	key = "flirtsmell"
	key_third_person = "leans in close and tries to sneak a <span class='love'>snif of someone!</span>"
	message = "leans in close and tries to sneak a <span class='love'>snif of someone!</span>"
	message_param = "leans in close and tries to sneak a <span class='love'>snif of %t!</span>"

datum/emote/living/flirt/flirtcoo
	key = "flirtcoo"
	key_third_person = "makes a <span class='love'>quiet cooing noise at</span>, urging them on!"
	message = "makes a <span class='love'>quiet cooing noise at</span>, urging them on!"
	message_param = "makes a <span class='love'>quiet cooing noise at %t</span>, urging them on!"

datum/emote/living/flirt/flirtpinch
	key = "flirtpinch"
	key_third_person = "is <span class='love'>trying to pinch</span> somebody, look out they're a lil' handsy!"
	message = "is <span class='love'>trying to pinch</span> somebody, look out they're a lil' handsy!"
	message_param = "is <span class='love'>trying to pinch</span> %t, look out they're a lil' handsy!"

datum/emote/living/flirt/flirtcaress
	key = "flirtcaress"
	key_third_person = "is <span class='love'>trying to caress</span> somebody softly!"
	message = "is <span class='love'>trying to caress</span> somebody softly!"
	message_param = "is <span class='love'>trying to caress</span> %t softly!"

datum/emote/living/flirt/flirtbrush
	key = "flirtbrush"
	key_third_person = "is <span class='love'>trying to brush</span> someone!"
	message = "is <span class='love'>trying to to brush</span> someone!"
	message_param = "is <span class='love'>trying to brush</span> %t!"

datum/emote/living/flirt/flirtgrope
	key = "flirtgrope"
	key_third_person = "is <span class='love'>trying to grope</span> somebody, very handsy!"
	message = "is <span class='love'>trying to grope</span> somebody, very handsy!"
	message_param = "is <span class='love'>trying to grope</span> %t, very handsy!"

datum/emote/living/flirt/flirtkissy
	key = "flirtkissy"
	key_third_person = "makes a <span class='love'>kissy face at</span> someone!"
	message = "makes a <span class='love'>kissy face at</span> someone!"
	message_param = "makes a <span class='love'>kissy face at</span> %t!"

datum/emote/living/flirt/eyebrow
	key = "flirteyebrow"
	key_third_person = "<span class='love'>quirks their eyebrow</span> at someone knowingly!"
	message = "<span class='love'>quirks their eyebrow</span> at someone knowingly!"
	message_param = "<span class='love'>quirks their eyebrow</span> at %t knowingly!"

datum/emote/living/flirt/wink
	key = "flirtwink"
	key_third_person = "<span class='love'>winks</span> at someone knowingly!"
	message = "<span class='love'>winks</span> at someone knowingly!"
	message_param = "<span class='love'>winks</span> at %t knowingly!"

datum/emote/living/flirt/wave
	key = "flirtwave"
	key_third_person = "<span class='love'>waves</span> someone over languidly!"
	message = "<span class='love'>waves</span> someone over languidly!"
	message_param = "<span class='love'>waves</span> %t over languidly!"

datum/emote/living/flirt/lean
	key = "flirtlean"
	key_third_person = "tries to lean warmly on <span class='love'>lean warmly on</span> someone!"
	message = "tries to <span class='love'>lean warmly on</span> someone!"
	message_param = "tries to <span class='love'>lean warmly on</span> %t!"

datum/emote/living/flirt/snuggle
	key = "flirtsnuggle"
	key_third_person = "tries to <span class='love'>snuggle up against</span> someone!"
	message = "tries to <span class='love'>snuggle up against</span> someone!"
	message_param = "tries to <span class='love'>snuggle up against</span> %t!"

datum/emote/living/flirt/littlespoon
	key = "flirtspoonlittle"
	key_third_person = "is trying to be <span class='love'>the little spoon</span> for someone!"
	message = "is trying to be <span class='love'>the little spoon</span> for someone!"
	message_param = "is trying to be <span class='love'>the little spoon</span> for %t!"

datum/emote/living/flirt/bigspoon
	key = "flirtspoonbig"
	key_third_person = "is trying to be <span class='love'>the big spoon</span> for someone!"
	message = "is trying to be <span class='love'>the big spoon</span> for someone!"
	message_param = "is trying to be <span class='love'>the big spoon</span> for %t!"

datum/emote/living/flirt/kisslight
	key = "flirtkisslight"
	key_third_person = "is trying to <span class='love'>lightly kiss</span> someone!"
	message = "is trying to <span class='love'>lightly kiss</span> someone!"
	message_param = "is trying to <span class='love'>lightly kiss</span> %t!"

datum/emote/living/flirt/kiss
	key = "flirtkiss"
	key_third_person = "is trying to <span class='userlove'>kiss</span> someone!"
	message = "is trying to <span class='userlove'>kiss</span> someone!"
	message_param = "is trying to <span class='userlove'>kiss</span> %t!"

datum/emote/living/flirt/kissdeep
	key = "flirtkissdeep"
	key_third_person = "is trying to <span class='userlove'>kiss someone deeply!</span>"
	message = "is trying to <span class='userlove'>kiss someone deeply!</span>"
	message_param = "is trying to <span class='userlove'>kiss %t deeply!</span>"

datum/emote/living/flirt/smile
	key = "flirtsmile"
	key_third_person = "<span class='love'>smiles softly</span> at someone!"
	message = "<span class='love'>smiles softly</span> at someone!"
	message_param = "<span class='love'>smiles softly</span> at %t!"

datum/emote/living/flirt/grin
	key = "flirtgrin"
	key_third_person = "<span class='love'>grins mischeviously</span> at someone, they're up to no good."
	message = "<span class='love'>grins mischeviously</span> at someone, they're up to no good."
	message_param = "<span class='love'>grins mischeviously</span> at %t, they're up to no good."

datum/emote/living/flirt/leer
	key = "flirtleer"
	key_third_person = "<span class='love'>leers</span> at somebody."
	message = "<span class='love'>leers</span> at somebody."
	message_param = "<span class='love'>leers</span> at %t."

datum/emote/living/flirt/hairflip
	key = "flirthairflip"
	key_third_person = "<span class='love'>flips their hair casually</span> while looking at somebody."
	message = "<span class='love'>flips their hair casually</span> while looking at somebody."
	message_param = "<span class='love'>flips their hair casually</span> while looking at %t."

datum/emote/living/flirt/hairplay
	key = "flirthairplay"
	key_third_person = "<span class='love'>plays with their hair</span> while looking at somebody."
	message = "<span class='love'>plays with their hair</span> while looking at somebody."
	message_param = "<span class='love'>plays with their hair</span> while looking at %t."

datum/emote/living/flirt/sideeye
	key = "flirtsideeye"
	key_third_person = "<span class='love'>side-eyes at</span> somebody, getting an eyeful."
	message = "<span class='love'>side-eyes at</span> somebody, getting an eyeful."
	message_param = "<span class='love'>side-eyes</span> %t, getting an eyeful."

datum/emote/living/flirt/throwback
	key = "flirtthrowback"
	key_third_person = "<span class='love'>throws their behind back at</span> somebody, trying to booty bump them!"
	message = "<span class='love'>throws their behind back at</span> somebody, trying to booty bump them!"
	message_param = "<span class='love'>throws their behind back at</span> %t, trying to booty bump them!"

datum/emote/living/flirt/oopstouch
	key = "flirtoopstouch"
	key_third_person = "<span class='love'>accidently brushes against</span> somebody, <span class='love'>oops!</span>"
	message = "<span class='love'>accidently brushes against</span> somebody, <span class='love'>oops!</span>"
	message_param = "<span class='love'>accidently brushes against</span> %t, <span class='love'>oops!</span>"


//Bubber Theft :)//


datum/emote/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "chirps!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/chirp.ogg'

datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/caw.ogg'

datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "caws twice!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/caw2.ogg'

datum/emote/living/mrrp //you play like a cat
	key = "mrrp"
	key_third_person = "mrrps"
	message = "mrrps!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/mrrp.ogg'

datum/emote/living/fpurr
	key = "fpurr"
	key_third_person = "purrs!"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/fox_purr.ogg'

datum/emote/living/prbt //all tesh players will love me
	key = "prbt"
	key_third_person = "prbts!"
	message = "prbts!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/prbt.ogg'

datum/emote/living/gecker
	key = "gecker"
	key_third_person = "geckers"
	message = "geckers!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/verbs/foxgecker.ogg'


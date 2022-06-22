/datum/emote/living/blush
	key = "blush"
	key_third_person = "blushes"
	message = "blushes."
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
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/lilburp.ogg' //Sunset Edit - TK

/datum/emote/living/choke
	key = "choke"
	key_third_person = "chokes"
	message = "chokes!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/f13effects/sunsetsounds/choke.ogg' //Sunset Edit - TK

/datum/emote/living/cross
	key = "cross"
	key_third_person = "crosses"
	message = "crosses their arms."
	restraint_check = TRUE

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "chuckles."
	emote_type = EMOTE_AUDIBLE

/* Sunset Attempt - I tried bro ~TK  This lets females have a chuckle, but males don't.  idk man, I'm dumb.
/datum/emote/living/chuckle/get_sound(mob/living/user) //Sunset Edit -TK
	. = ..()
	if(ishuman(user))
		if(user.gender == FEMALE)
			sound = 'sound/f13effects/sunsetsounds/femalechuckle.ogg'
		else
			sound = 'sound/f13effects/sunsetsounds/malechuckle.ogg'
		return sound
*/

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
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cough/can_run_emote(mob/user, status_check = TRUE , intentional)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_SOOTHED_THROAT))
		return FALSE

/datum/emote/living/dance
	key = "dance"
	key_third_person = "dances"
	message = "dances around happily."
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

/datum/emote/living/drool
	key = "drool"
	key_third_person = "drools"
	message = "drools."

/datum/emote/living/faint
	key = "faint"
	key_third_person = "faints"
	message = "faints."

/datum/emote/living/faint/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.SetSleeping(200)


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
			addtimer(CALLBACK(H, open ? /mob/living/carbon/human.proc/OpenWings : /mob/living/carbon/human.proc/CloseWings), wing_time)

/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "aflaps"
	message = "flaps their wings ANGRILY!"
	restraint_check = TRUE
	wing_time = 10
*/

/datum/emote/living/frown
	key = "frown"
	key_third_person = "frowns"
	message = "frowns."

/datum/emote/living/gag
	key = "gag"
	key_third_person = "gags"
	message = "gags."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "gasps!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "giggles."
	emote_type = EMOTE_AUDIBLE

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

/datum/emote/living/groan
	key = "groan"
	key_third_person = "groans"
	message = "groans!"

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "grimaces."

/datum/emote/living/jump
	key = "jump"
	key_third_person = "jumps"
	message = "jumps!"
	restraint_check = TRUE

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "kisses"
	message = "blows a kiss."
	message_param = "blows a kiss to %t."
	emote_type = EMOTE_AUDIBLE

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

/datum/emote/living/audible/laugh/get_sound(mob/living/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		//power armor laugh track.... spooky
		if(istype(human_user.get_item_by_slot(ITEM_SLOT_OCLOTHING), /obj/item/clothing/suit/armor/f13/power_armor))
			return 'sound/voice/robolaugh.ogg'
		return human_user.dna.species.get_laugh_sound(user)

/datum/emote/living/audible/chitter
	key = "chitter"
	key_third_person = "chitters"
	message = "chitters."

/datum/emote/living/audible/chitter/get_sound(mob/living/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(isinsect(human_user))
			return 'sound/voice/moth/mothchitter.ogg'

/datum/emote/living/look
	key = "look"
	key_third_person = "looks"
	message = "looks."
	message_param = "looks at %t."

/datum/emote/living/nod
	key = "nod"
	key_third_person = "nods"
	message = "nods."
	message_param = "nods at %t."

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
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "screams."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "scowls"
	message = "scowls."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shake
	key = "shake"
	key_third_person = "shakes"
	message = "shakes their head."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "shiver"
	message = "shivers."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "sighs."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sit
	key = "sit"
	key_third_person = "sits"
	message = "sits down."

/datum/emote/living/smile
	key = "smile"
	key_third_person = "smiles"
	message = "smiles."

/datum/emote/living/smirk
	key = "smirk"
	key_third_person = "smirks"
	message = "smirks."

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "sneezes."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/smug
	key = "smug"
	key_third_person = "smugs"
	message = "grins smugly."

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "sniffs"
	message = "sniffs."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snore
	key = "snore"
	key_third_person = "snores"
	message = "snores."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/stare
	key = "stare"
	key_third_person = "stares"
	message = "stares."
	message_param = "stares at %t."

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "stretches"
	message = "stretches their arms."

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

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "twitches violently."

/datum/emote/living/twitch_s
	key = "twitch_s"
	message = "twitches."

/datum/emote/living/wave
	key = "wave"
	key_third_person = "waves"
	message = "waves."

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "whimpers."

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "wsmiles"
	message = "smiles weakly."

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "yawns."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	message = null

/datum/emote/living/custom/proc/check_invalid(mob/user, input)
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
		return TRUE
	return FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override = null)
	if(jobban_isbanned(user, "emote"))
		to_chat(user, "You cannot send custom emotes (banned).")
		return FALSE
	else if(QDELETED(user))
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		var/custom_emote = stripped_multiline_input_or_reflect(user, "Choose an emote to display.", "Custom Emote", null, MAX_MESSAGE_LEN)
		if(custom_emote && !check_invalid(user, custom_emote))
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					return
			message = custom_emote
	else
		message = params
		if(type_override)
			emote_type = type_override
	message = user.say_emphasis(message)
	. = ..()
	message = null
	emote_type = EMOTE_VISIBLE

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
		to_chat(user, "<span class='notice'>You make a circle with your hand.</span>")
	else
		qdel(N)
		to_chat(user, "<span class='warning'>You don't have any free hands to make a circle with.</span>")

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
		to_chat(user, "<span class='notice'>You ready your slapping hand.</span>")
	else
		to_chat(user, "<span class='warning'>You're incapable of slapping in your current state.</span>")

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

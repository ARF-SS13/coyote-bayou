/datum/accent

/datum/accent/proc/premodify_speech(datum/rental_mommy/chat/mom, datum/source, mob/living/carbon/owner) //transforms the message in some way
	if(!mom)
		return speech_args
	var/list/argumass = list(
		mom.message, // what a great system
		null,
		mom.spans,
		null,
		mom.language,
		null,
		null
	)
	var/list/retr = modify_speech(argumass, source, owner)
	mom.message = retr[1]
	mom.spans = retr[3]
	mom.language = retr[5]
	return retr

/datum/accent/proc/modify_speech(list/speech_args, datum/source, mob/living/carbon/owner) //transforms the message in some way
	return speech_args

/datum/accent/lizard/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/lizard_hiss = new("s+", "g")
	var/static/regex/lizard_hiSS = new("S+", "g")
	if(message[1] != "*")
		message = lizard_hiss.Replace(message, "sss")
		message = lizard_hiSS.Replace(message, "SSS")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/fly/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/fly_buzz = new("z+", "g")
	var/static/regex/fly_buZZ = new("Z+", "g")
	if(message[1] != "*")
		message = fly_buzz.Replace(message, "zzz")
		message = fly_buZZ.Replace(message, "ZZZ")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/abductor/modify_speech(list/speech_args, datum/source)
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	var/rendered = "<span class='abductor'><b>[user.name]:</b> [message]</span>"
	user.log_talk(message, LOG_SAY, tag="abductor")
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		var/obj/item/organ/tongue/T = H.getorganslot(ORGAN_SLOT_TONGUE)
		if(!T || T.type != type)
			continue
		if(H.dna && H.dna.species.id == "abductor" && user.dna && user.dna.species.id == "abductor")
			var/datum/antagonist/abductor/A = user.mind.has_antag_datum(/datum/antagonist/abductor)
			if(!A || !(H.mind in A.team.members))
				continue
		to_chat(H, rendered)
	for(var/mob/M in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(M, user)
		to_chat(M, "[link] [rendered]")
	speech_args[SPEECH_MESSAGE] = ""
	return speech_args

/datum/accent/zombie/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/list/message_list = splittext(message, " ")
	var/maxchanges = max(round(message_list.len / 1.5), 2)

	for(var/i = rand(maxchanges / 2, maxchanges), i > 0, i--)
		var/insertpos = rand(1, message_list.len - 1)
		var/inserttext = message_list[insertpos]

		if(!(copytext(inserttext, -3) == "..."))//3 == length("...")
			message_list[insertpos] = inserttext + "..."

		if(prob(20) && message_list.len > 3)
			message_list.Insert(insertpos, "[pick("BRAINS", "Brains", "Braaaiinnnsss", "BRAAAIIINNSSS")]...")

	speech_args[SPEECH_MESSAGE] = jointext(message_list, " ")
	return speech_args

/datum/accent/alien/modify_speech(list/speech_args, datum/source)
	playsound(source, "hiss", 25, 1, 1)
	return speech_args

/datum/accent/fluffy/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "ne", "nye")
		message = replacetext(message, "nu", "nyu")
		message = replacetext(message, "na", "nya")
		message = replacetext(message, "no", "nyo")
		message = replacetext(message, "ove", "uv")
		message = replacetext(message, "l", "w")
		message = replacetext(message, "r", "w")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/span
	var/span_flag

/datum/accent/span/modify_speech(list/speech_args)
	speech_args[SPEECH_SPANS] |= span_flag
	return speech_args

//bone tongues either have the sans accent or the papyrus accent
/datum/accent/span/sans
	span_flag = SPAN_SANS

/datum/accent/span/papyrus
	span_flag = SPAN_PAPYRUS

/datum/accent/span/robot
	span_flag = SPAN_ROBOT

/datum/accent/dullahan/modify_speech(list/speech_args, datum/source, mob/living/carbon/owner)
	if(owner)
		if(isdullahan(owner))
			var/datum/species/dullahan/D = owner.dna.species
			if(isobj(D.myhead.loc))
				var/obj/O = D.myhead.loc
				O.say(speech_args[SPEECH_MESSAGE])
	speech_args[SPEECH_MESSAGE] = ""
	return speech_args


//Arfs accents

/datum/accent/french/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "th", "zh")
		message = replacetext(message, "s", "z")
		message = replacetext(message, "r", "rr")
		message = replacetext(message, "h", "'")
		message = replacetext(message, "i", "e")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/scottish/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "h", "'")
		message = replacetext(message, "g", "'")
		message = replacetext(message, "of", "o")
		message = replacetext(message, "your", "yer")
		message = replacetext(message, "and", "agus")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/bug/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "s", "sz")
		message = replacetext(message, "s", "z")
		message = replacetext(message, "s", "zz")
		message = replacetext(message, "th", "zk")
		message = replacetext(message, "r", "rk")
		message = replacetext(message, "f", "zk")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/dutch/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "u", "oo")
		message = replacetext(message, "g", "gh")
		message = replacetext(message, "j", "y")
		message = replacetext(message, "a", "aa")
		message = replacetext(message, "d", "t")
		message = replacetext(message, "w", "v")
		message = replacetext(message, "s", "sh")
		message = replacetext(message, "th", "d")
		message = replacetext(message, "ea", "ee")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/redriver/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, " climbed ", " clumb ")
		message = replacetext(message, "washing", "warshing")
		message = replacetext(message, "shower", "shawer")
		message = replacetext(message, "soda", "coke")
		message = replacetext(message, "pop", "cola")
		message = replacetext(message, "compass ", "comp-ass ")
		message = replacetext(message, "there", "yonder")
		message = replacetext(message, "brahmin", "brimmer")
		message = replacetext(message, " damnit", " dangit")
		message = replacetext(message, "god", "gosh")
		message = replacetext(message, " fuck", " shit")
		message = replacetext(message, " shit", " ass")
		message = replacetext(message, "going", "gonna")
		message = replacetext(message, "let me", "lemme")
		message = replacetext(message, " I ", " ah ")
		message = replacetext(message, "you all", "y'all")
		message = replacetext(message, "you have", " you've ")
		message = replacetext(message, "got to", "gots-ta")
		message = replacetext(message, "my ", "mah ")
		message = replacetext(message, "get", "git")
		message = replacetext(message, "out of", "outta")
		message = replacetext(message, "here", "har")
		message = replacetext(message, "dog", "dawg")
		message = replacetext(message, "cat", "gahto")
		message = replacetext(message, "tire", "taar")
		message = replacetext(message, "I'm", "ah'm")
		message = replacetext(message, "I'd", "ah'd")
		message = replacetext(message, "new", "naw")
		message = replacetext(message, "Orleans", "lins'")
		message = replacetext(message, "sheriff ", "big lawman")
		message = replacetext(message, "deputy", "lawman")
		message = replacetext(message, "bandit", "desperado")
		message = replacetext(message, "raider", "lunatic")
		message = replacetext(message, "cap ", "peso ")
		message = replacetext(message, "coin ", "dinero ")
		message = replacetext(message, "money", "dollahs")
		message = replacetext(message, "hang", "sway")
		message = replacetext(message, "bois'd'arc", "board-ark")
		message = replacetext(message, "gun", "shooter")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/swedish/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "j", "y")
		message = replacetext(message, "ch", "sh")
		message = replacetext(message, "hu", "yu")
		message = replacetext(message, "hoo", "yu")
		message = replacetext(message, "i", "e")
		message = replacetext(message, "you ", "du ")
		message = replacetext(message, "you'll ", "du kommer")
		message = replacetext(message, "you've ", "du har")
		message = replacetext(message, "so ", "sa ")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/japanese/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "ay", "ayu")
		message = replacetext(message, "ow", "au")
		message = replacetext(message, "I ", "ai ")
		message = replacetext(message, "l", "r")
		message = replacetext(message, "v", "b")
		message = replacetext(message, "f", "")
		message = replacetext(message, "th", "z")
		message = replacetext(message, "are ", "ah ")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/chinese/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "e ", "u ")
		message = replacetext(message, "s ", "se ")
		message = replacetext(message, "er", "ah")
		message = replacetext(message, "ed ", "uh ")
		message = replacetext(message, "ant ", "ang ")
		message = replacetext(message, "ra", "ura")
		message = replacetext(message, "iv", "eev")
		message = replacetext(message, "is ", "esu ")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/irish/modify_speech(list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "ing", "eng")
		message = replacetext(message, "i", "ei")
		message = replacetext(message, "th", "d")
		message = replacetext(message, "r", "er")
		message = replacetext(message, "'l", "'ll")
		message = replacetext(message, "but ", "ach ")
		message = replacetext(message, "you ", "tú ")
		message = replacetext(message, " or ", " nó ")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args

/datum/accent/slurry/modify_speech(list/speech_args) // https://youtu.be/w2_0mhkbrzg ~TK
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "r", "w")
		message = replacetext(message, "l", "w")
		message = replacetext(message, "th", "ff")
		message = replacetext(message, "you ", "chu ")
	speech_args[SPEECH_MESSAGE] = message
	return speech_args


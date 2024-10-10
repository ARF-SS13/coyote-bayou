/mob/living/carbon/human/say_mod(input, message_mode)
	. = ..()
	if(message_mode != MODE_CUSTOM_SAY && message_mode != MODE_WHISPER_CRIT)
		switch(slurring)
			if(10 to 25)
				return "jumbles"
			if(25 to 50)
				return "slurs"
			if(50 to INFINITY)
				return "garbles"

/mob/living/carbon/human/GetVoice()
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/V = wear_mask
		if(V.voice_change && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return real_name
		else
			return real_name
	if(istype(wear_mask, /obj/item/clothing/mask/infiltrator))
		var/obj/item/clothing/mask/infiltrator/V = wear_mask
		if(V.voice_unknown)
			return ("Unknown")
		else
			return real_name
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling && changeling.mimicing )
			return changeling.mimicing
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/IsVocal()
	// how do species that don't breathe talk? magic, that's what.
	if(!HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT) && !getorganslot(ORGAN_SLOT_LUNGS))
		return FALSE
	if(mind)
		return !mind.miming
	return TRUE

/mob/living/carbon/human/proc/SetSpecialVoice(new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

/mob/living/carbon/human/binarycheck()
	if(ears)
		var/obj/item/radio/headset/dongle = ears
		if(!istype(dongle))
			return FALSE
		if(dongle.translate_binary)
			return TRUE

/mob/living/carbon/human/radio(datum/rental_mommy/chat/momchat)
	if(!momchat)
		CRASH("radio called with no momchat!!!!!!!!!!!!!!!!!!!")
	. = ..()
	if(. || momchat.radio_returns)
		return

	var/obj/item/R //Our radio. Uses the generic /obj/item just in case someone is wearing a non-radio in the ear slot.
	if(ears && istype(ears, /obj/item/radio))//Prioritize headsets first.
		R = ears
	else if(gloves && istype(gloves, /obj/item/pda))//Are we wearing a pipboy on our hands?
		var/obj/item/pda/P = gloves
		R = P.radio
	else if(wear_id && istype(wear_id, /obj/item/pda))//Are we wearing a pipboy in the ID slot?
		var/obj/item/pda/P = wear_id
		R = P.radio
	else if(ears)//Fallback to using a non-radio object on the player's ear.
		R = ears
	
	var/message = momchat.message
	var/spans = momchat.spans
	var/language = momchat.language
	var/message_mode = momchat.message_mode

	switch(message_mode)
		if(MODE_HEADSET)
			if (R)
				R.talk_into(src, message, , spans, language, momchat)
			momchat.radio_returns = ITALICS | REDUCE_RANGE

		if(MODE_DEPARTMENT)
			if (R)
				R.talk_into(src, message, message_mode, spans, language, momchat)
			momchat.radio_returns = ITALICS | REDUCE_RANGE

	if(message_mode in GLOB.radiochannels)
		if(R)
			R.talk_into(src, message, message_mode, spans, language, momchat)
			momchat.radio_returns = ITALICS | REDUCE_RANGE

	return momchat.radio_returns

/mob/living/carbon/human/get_alt_name()
	if(name != GetVoice())
		return " (as [get_id_name("Unknown")])"

/mob/living/carbon/human/proc/forcesay(list/append) //this proc is at the bottom of the file because quote fuckery makes notepad++ cri
	set waitfor = FALSE		// WINGET IS A SLEEP. DO. NOT. SLEEP.
	if(stat == CONSCIOUS)
		if(client)
			var/temp = winget(client, "input", "text")
			var/say_starter = "Say \"" //"
			if(findtextEx(temp, say_starter, 1, length(say_starter) + 1) && length(temp) > length(say_starter))	//case sensitive means

				temp = trim_left(copytext(temp, length(say_starter) + 1))
				temp = replacetext(temp, ";", "", 1, 2)	//general radio
				while(trim_left(temp)[1] == ":")	//dept radio again (necessary)
					temp = copytext_char(trim_left(temp), 3)

				if(temp[1] == "*")	//emotes
					return

				var/trimmed = trim_left(temp)
				if(length(trimmed))
					if(append)
						trimmed += pick(append)

					say(trimmed)
				winset(client, "input", "text=[null]")

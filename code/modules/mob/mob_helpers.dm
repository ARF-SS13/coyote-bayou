
// see _DEFINES/is_helpers.dm for mob type checks

/mob/proc/lowest_buckled_mob()
	. = src
	if(buckled && ismob(buckled))
		var/mob/Buckled = buckled
		. = Buckled.lowest_buckled_mob()

/proc/check_zone(zone)
	if(!zone)
		return BODY_ZONE_CHEST
	switch(zone)
		if(BODY_ZONE_PRECISE_EYES)
			zone = BODY_ZONE_HEAD
		if(BODY_ZONE_PRECISE_MOUTH)
			zone = BODY_ZONE_HEAD
		if(BODY_ZONE_PRECISE_L_HAND)
			zone = BODY_ZONE_L_ARM
		if(BODY_ZONE_PRECISE_R_HAND)
			zone = BODY_ZONE_R_ARM
		if(BODY_ZONE_PRECISE_L_FOOT)
			zone = BODY_ZONE_L_LEG
		if(BODY_ZONE_PRECISE_R_FOOT)
			zone = BODY_ZONE_R_LEG
		if(BODY_ZONE_PRECISE_GROIN)
			zone = BODY_ZONE_CHEST
	return zone


/proc/ran_zone(zone, probability = 80, list/list_type = ZONE_WEIGHT_LIST_DEFAULT)
	if(prob(probability))
		zone = check_zone(zone)
	else
		if(islist(list_type))
			zone = pickweight(list_type)
		else
			zone = pickweight(ZONE_WEIGHT_LIST_DEFAULT)
	return zone

/proc/above_neck(zone)
	var/list/zones = list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES)
	if(zones.Find(zone))
		return 1
	else
		return 0

/**
 * Convert random parts of a passed in message to stars
 *
 * * phrase - the string to convert
 * * probability - probability any character gets changed
 *
 * This proc is dangerously laggy, avoid it or die
 * no its not lol
 */
/proc/stars(phrase, probability = 25)
	if(probability <= 0)
		return phrase
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/char = ""
	for(var/i = 1, i <= leng, i += length(char))
		char = phrase[i]
		if(char == " " || !prob(probability))
			. += char
		else
			. += "*"
	return sanitize(.)

/**
 * Convert random words of a passed in message to ellipses
 *
 * * phrase - the string to convert
 * * probability - probability any character gets changed
 *
 * This proc is not laggy at all, and is better in every way =3
 */
/proc/dots(phrase, probability = 25, distance, maxdistance)
	if(probability <= 0)
		return phrase
	if(distance && maxdistance)
		/// throw out probability and calculate a new one based on how far away the message is
		/// from the source of the message (distance) and the maximum distance the message can be
		/// heard from (maxdistance)
		probability = (distance / maxdistance) * 100
		probability = clamp(probability, 0, 90)
	phrase = html_decode(phrase)
	var/list/words = splittext(phrase, " ")
	. = ""
	var/indes = 1
	var/has_multiple_words = LAZYLEN(words) > 1
	for(var/word in words)
		if(prob(probability))
			for(var/i in 1 to min(3, length(word)))
				. += "."
			// if(has_multiple_words && indes < LAZYLEN(words))
			// 	. += " "
		else
			if(has_multiple_words && indes < LAZYLEN(words))
				. += "[word] "
			else
				. += "[word]"
	return sanitize(.)

/**
 * Makes you speak like you're drunk
 */
/proc/slur(phrase, strength = 50)
	strength = min(50, strength)
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/newletter = ""
	var/rawchar = ""
	for(var/i = 1, i <= leng, i += length(rawchar))
		rawchar = newletter = phrase[i]
		if(rand(1,100)<=strength * 0.5)
			var/lowerletter = lowertext(newletter)
			if(lowerletter == "o")
				newletter = "u"
			else if(lowerletter == "s")
				newletter = "ch"
			else if(lowerletter == "a")
				newletter = "ah"
			else if(lowerletter == "u")
				newletter = "oo"
			else if(lowerletter == "c")
				newletter = "k"
		if(rand(1,100) <= strength * 0.25)
			if(newletter == " ")
				newletter = "...huuuhhh..."
			else if(newletter == ".")
				newletter = " *BURP*."
		switch(rand(1,100) <= strength * 0.5)
			if(1)
				newletter += "'"
			if(10)
				newletter += "[newletter]"
			if(20)
				newletter += "[newletter][newletter]"
		. += "[newletter]"
	return sanitize(.)

/// Makes you talk like you got cult stunned, which is slurring but with some dark messages
/proc/cultslur(phrase) // Inflicted on victims of a stun talisman
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/newletter = ""
	var/rawchar = ""
	for(var/i = 1, i <= leng, i += length(rawchar))
		rawchar = newletter = phrase[i]
		if(rand(1, 2) == 2)
			var/lowerletter = lowertext(newletter)
			if(lowerletter == "o")
				newletter = "u"
			else if(lowerletter == "t")
				newletter = "ch"
			else if(lowerletter == "a")
				newletter = "ah"
			else if(lowerletter == "u")
				newletter = "oo"
			else if(lowerletter == "c")
				newletter = " NAR "
			else if(lowerletter == "s")
				newletter = " SIE "
		if(rand(1, 4) == 4)
			if(newletter == " ")
				newletter = " no hope... "
			else if(newletter == "H")
				newletter = " IT COMES... "

		switch(rand(1, 15))
			if(1)
				newletter = "'"
			if(2)
				newletter += "agn"
			if(3)
				newletter = "fth"
			if(4)
				newletter = "nglu"
			if(5)
				newletter = "glor"
			else
		. += newletter
	return sanitize(.)

//Ratvarian Slurring!

#define CLOCK_CULT_SLUR(phrase) sanitize(text2ratvar(phrase))

///Adds stuttering to the message passed in
/proc/stutter(phrase)
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/newletter = ""
	var/rawchar
	for(var/i = 1, i <= leng, i += length(rawchar))
		rawchar = newletter = phrase[i]
		if(prob(80) && !(lowertext(newletter) in list("a", "e", "i", "o", "u", " ")))
			if(prob(10))
				newletter = "[newletter]-[newletter]-[newletter]-[newletter]"
			else if(prob(20))
				newletter = "[newletter]-[newletter]-[newletter]"
			else if (prob(5))
				newletter = ""
			else
				newletter = "[newletter]-[newletter]"
		. += newletter
	return sanitize(.)

/proc/derpspeech(message, stuttering)
	message = replacetext(message, " am ", " ")
	message = replacetext(message, " is ", " ")
	message = replacetext(message, " are ", " ")
	message = replacetext(message, "you", "u")
	message = replacetext(message, "help", "halp")
	message = replacetext(message, "grief", "grife")
	message = replacetext(message, "space", "spess")
	message = replacetext(message, "carp", "crap")
	message = replacetext(message, "reason", "raisin")
	if(prob(50))
		message = uppertext(message)
		message += "[stutter(pick("!", "!!", "!!!"))]"
	if(!stuttering && prob(15))
		message = stutter(message)
	return message


/proc/Gibberish(text, replace_characters = FALSE, chance = 50)
	text = html_decode(text)
	. = ""
	var/rawchar = ""
	var/letter = ""
	var/lentext = length(text)
	for(var/i = 1, i <= lentext, i += length(rawchar))
		rawchar = letter = text[i]
		if(prob(chance))
			if(replace_characters)
				letter = ""
			for(var/j in 1 to rand(0, 2))
				letter += pick("#", "@", "*", "&", "%", "$", "/", "<", ">", ";", "*", "*", "*", "*", "*", "*", "*")
		. += letter
	return sanitize(.)

/*
The difference with stutter is that this proc can stutter more than 1 letter
The issue here is that anything that does not have a space is treated as one word (in many instances). For instance, "LOOKING," is a word, including the comma.
It's fairly easy to fix if dealing with single letters but not so much with compounds of letters./N
*/
/proc/ninjaspeak(phrase) //NINJACODE
	. = ""
	var/lentext = length_char(phrase)
	var/rawchars = ""
	var/letter = ""
	for(var/i = 1, i <= lentext, i += length_char(rawchars))
		var/end = i + rand(1,4)
		letter = rawchars = copytext_char(phrase, i, end > lentext ? 0 : end)
		if (prob(50))
			if (prob(30))
				letter = "[letter]-[letter]-[letter]"
			else
				letter = "[letter]-[letter]"
		. += letter
	return copytext_char(sanitize(.),1,MAX_MESSAGE_LEN)

/proc/shake_camera(mob/M, duration, strength=1)
	if(!M || !M.client || duration < 1)
		return
	var/client/C = M.client
	var/oldx = C.pixel_x
	var/oldy = C.pixel_y
	var/max = strength*world.icon_size
	var/min = -(strength*world.icon_size)

	for(var/i in 0 to duration-1)
		if (i == 0)
			animate(C, pixel_x=rand(min,max), pixel_y=rand(min,max), time=1)
		else
			animate(pixel_x=rand(min,max), pixel_y=rand(min,max), time=1)
	animate(pixel_x=oldx, pixel_y=oldy, time=1)



/proc/findname(msg)
	if(!istext(msg))
		msg = "[msg]"
	for(var/i in GLOB.mob_list)
		var/mob/M = i
		if(M.real_name == msg)
			return M
	return 0

/mob/proc/first_name()
	var/static/regex/firstname = new("^\[^\\s-\]+") //First word before whitespace or "-"
	firstname.Find(real_name)
	return firstname.match


//change a mob's act-intent. Input the intent as a string such as "help" or use "right"/"left
/mob/verb/a_intent_change(input as text)
	set name = "a-intent"
	set hidden = 1

	if(!possible_a_intents || !possible_a_intents.len)
		return

	if(input in possible_a_intents)
		a_intent = input
	else
		var/current_intent = possible_a_intents.Find(a_intent)

		if(!current_intent)
			// Failsafe. Just in case some badmin was playing with VV.
			current_intent = 1

		if(input == INTENT_HOTKEY_RIGHT)
			current_intent += 1
		if(input == INTENT_HOTKEY_LEFT)
			current_intent -= 1

		// Handle looping
		if(current_intent < 1)
			current_intent = possible_a_intents.len
		if(current_intent > possible_a_intents.len)
			current_intent = 1

		a_intent = possible_a_intents[current_intent]
	if(prob(0.01))
		playsound(get_turf(src), 'sound/effects/Huuu.ogg')
	/* else
		var/playthis
		switch(a_intent)
			if(INTENT_HELP)
				playthis = ""
			if(INTENT_DISARM)
				playthis = ""
			if(INTENT_GRAB)
				playthis = ""
			if(INTENT_HARM)
				playthis = ""
		if(playthis && playthis != "")
			playsound_local(get_turf(src), playthis) */
	
	if(hud_used && hud_used.action_intent)
		hud_used.action_intent.icon_state = "[a_intent]"


/proc/is_blind(A)
	if(ismob(A))
		var/mob/B = A
		return B.eye_blind
	return FALSE

/mob/proc/hallucinating()
	return FALSE

/proc/is_special_character(mob/M) // returns 1 for special characters and 2 for heroes of gamemode //moved out of admins.dm because things other than admin procs were calling this.
	if(!SSticker.HasRoundStarted())
		return FALSE
	if(!istype(M))
		return FALSE
	if(issilicon(M))
		if(iscyborg(M)) //For cyborgs, returns 1 if the cyborg has a law 0 and special_role. Returns 0 if the borg is merely slaved to an AI traitor.
			return FALSE
		else if(isAI(M))
			var/mob/living/silicon/ai/A = M
			if(A.laws && A.laws.zeroth && A.mind && A.mind.special_role)
				return TRUE
		return FALSE
	if(M.mind && M.mind.special_role)//If they have a mind and special role, they are some type of traitor or antagonist.
		switch(SSticker.mode.config_tag)
			if("revolution")
				if(is_revolutionary(M))
					return 2
			if("cult")
				if(M.mind in SSticker.mode.cult)
					return 2
			if("nuclear")
				if(M.mind.has_antag_datum(/datum/antagonist/nukeop,TRUE))
					return 2
			if("changeling")
				if(M.mind.has_antag_datum(/datum/antagonist/changeling,TRUE))
					return 2
			if("wizard")
				if(iswizard(M))
					return 2
			if("apprentice")
				if(M.mind in SSticker.mode.apprentices)
					return 2
			if("monkey")
				if(isliving(M))
					var/mob/living/L = M
					if(L.diseases && (locate(/datum/disease/transformation/jungle_fever) in L.diseases))
						return 2
		return TRUE
	if(M.mind && LAZYLEN(M.mind.antag_datums)) //they have an antag datum!
		return TRUE
	return FALSE

/mob/proc/reagent_check(datum/reagent/R) // utilized in the species code
	return 1

/proc/notify_ghosts(message, ghost_sound, enter_link, atom/source, mutable_appearance/alert_overlay, action = NOTIFY_JUMP, flashwindow = TRUE, ignore_mapload = TRUE, ignore_key, ignore_dnr_observers = FALSE, header) //Easy notification of ghosts.
	if(ignore_mapload && SSatoms.initialized != INITIALIZATION_INNEW_REGULAR)	//don't notify for objects created during a map load
		return
	for(var/mob/dead/observer/O in GLOB.player_list)
		if(O.client)
			if ((ignore_key && (O.ckey in GLOB.poll_ignore[ignore_key])) || (ignore_dnr_observers && !O.can_reenter_round(TRUE)))
				continue
			to_chat(O, span_ghostalert("[message][(enter_link) ? " [enter_link]" : ""]"))
			if(ghost_sound)
				SEND_SOUND(O, sound(ghost_sound))
			if(flashwindow)
				window_flash(O.client)
			if(source)
				var/atom/movable/screen/alert/notify_action/A = O.throw_alert("[REF(source)]_notify_action", /atom/movable/screen/alert/notify_action)
				if(A)
					if(O.client.prefs && O.client.prefs.UI_style)
						A.icon = ui_style2icon(O.client.prefs.UI_style)
					if (header)
						A.name = header
					A.desc = message
					A.action = action
					A.target = source
					if(!alert_overlay)
						alert_overlay = new(source)
					alert_overlay.layer = FLOAT_LAYER
					alert_overlay.plane = FLOAT_PLANE
					A.add_overlay(alert_overlay)

/proc/item_heal_robotic(mob/living/carbon/human/H, mob/user, brute_heal, burn_heal)
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(affecting && affecting.status == BODYPART_ROBOTIC)
		var/dam //changes repair text based on how much brute/burn was supplied
		if(brute_heal > burn_heal)
			dam = 1
		else
			dam = 0
		if((brute_heal > 0 && affecting.brute_dam > 0) || (burn_heal > 0 && affecting.burn_dam > 0))
			if(affecting.heal_damage(brute_heal, burn_heal, 0, TRUE, FALSE))
				H.update_damage_overlays()
			user.visible_message("[user] has fixed some of the [dam ? "dents on" : "burnt wires in"] [H]'s [affecting.name].", \
			span_notice("You fix some of the [dam ? "dents on" : "burnt wires in"] [H]'s [affecting.name]."))
			return 1 //successful heal
		else
			to_chat(user, span_warning("[affecting] is already in good condition!"))


/proc/IsAdminGhost(mob/user, just_ghost)
	if(!user)		//Are they a mob? Auto interface updates call this with a null src
		return
	if(!user.client) // Do they have a client?
		return
	if(!isobserver(user)) // Are they a ghost?
		return
	if(!check_rights_for(user.client, R_ADMIN)) // Are they allowed?
		return
	if(just_ghost) // Are we just checking if they're a ghost?
		return TRUE
	if(!user.client.AI_Interact) // Do they have it enabled?
		return
	return TRUE

/atom/proc/hasSiliconAccessInArea(mob/user, flags = PRIVILEDGES_SILICON)
	if(!istype(user, /mob))
		return
	return user.silicon_privileges & (flags) || (user.siliconaccesstoggle && (get_area(src) in user.siliconaccessareas))

/mob/proc/toggleSiliconAccessArea(area/area)
	LAZYINITLIST(siliconaccessareas)
	if (area in siliconaccessareas)
		siliconaccessareas -= area
		to_chat(src,span_warning("You lost control of [area]!"))
		return FALSE
	else
		if (LAZYLEN(siliconaccessareas) < HIJACK_APC_MAX_AMOUNT)
			siliconaccessareas += area
			to_chat(src,span_notice("You successfully took control of [area]."))
		else
			to_chat(src,span_warning("You are connected to too many APCs! Too many more will fry your brain."))
			return FALSE
		return TRUE

/mob/proc/getImplant(type)
	return

/mob/living/getImplant(type)
	return locate(type) in implants

/proc/offer_control(mob/M,ignore_category=null)
	to_chat(M, "Control of your mob has been offered to dead players.")
	if(usr)
		log_admin("[key_name(usr)] has offered control of ([key_name(M)]) to ghosts.")
		message_admins("[key_name_admin(usr)] has offered control of ([ADMIN_LOOKUPFLW(M)]) to ghosts")
	var/poll_message = "Do you want to play as [M.real_name]?"
	if(M.mind && M.mind.assigned_role)
		poll_message = "[poll_message] Job:[M.mind.assigned_role]."
	if(M.mind && M.mind.special_role)
		poll_message = "[poll_message] Status:[M.mind.special_role]."
	else if(M.mind)
		var/datum/antagonist/A = M.mind.has_antag_datum(/datum/antagonist/)
		if(A)
			poll_message = "[poll_message] Status:[A.name]."
	var/list/mob/candidates = pollCandidatesForMob(poll_message, ROLE_PAI, null, FALSE, 100, M, ignore_category)

	if(LAZYLEN(candidates))
		var/mob/C = pick(candidates)
		to_chat(M, "Your mob has been taken over by a ghost!")
		message_admins("[key_name_admin(C)] has taken control of ([key_name_admin(M)])")
		M.ghostize(FALSE, TRUE)
		C.transfer_ckey(M, FALSE)
		return TRUE
	else
		to_chat(M, "There were no ghosts willing to take control.")
		message_admins("No ghosts were willing to take control of [ADMIN_LOOKUPFLW(M)])")
		return FALSE

/mob/proc/is_flying(mob/M = src)
	if(M.movement_type & FLYING)
		return 1
	else
		return 0

/mob/proc/click_random_mob()
	var/list/nearby_mobs = list()
	for(var/mob/living/L in range(1, src))
		if(L!=src)
			nearby_mobs |= L
	if(nearby_mobs.len)
		var/mob/living/T = pick(nearby_mobs)
		ClickOn(T)

// Logs a message in a mob's individual log, and in the global logs as well if log_globally is true
/mob/log_message(message, message_type, color=null, log_globally = TRUE)
	if(!client)
		return // the chicken clucks, good to know
	if(!LAZYLEN(message))
		stack_trace("Empty message")
		return
	LAZYINITLIST(logging)

	// Cannot use the list as a map if the key is a number, so we stringify it (thank you BYOND)
	var/smessage_type = num2text(message_type)

	if(client)
		if(!islist(client.player_details.logging[smessage_type]))
			client.player_details.logging[smessage_type] = list()

	if(!islist(logging[smessage_type]))
		logging[smessage_type] = list()

	var/colored_message = message
	if(color)
		if(color[1] == "#")
			colored_message = "<font color=[color]>[message]</font>"
		else
			colored_message = "<font color='[color]'>[message]</font>"

	switch(message_type)
		if(LOG_WHISPER)
			colored_message = "(WHISPER) [colored_message]"
		if(LOG_OOC)
			colored_message = "(OOC) [colored_message]"
		if(LOG_ASAY)
			colored_message = "(ASAY) [colored_message]"
		if(LOG_EMOTE)
			colored_message = "(EMOTE) [colored_message]"
		if(LOG_SUBTLE)
			colored_message = "(SUBTLE) [colored_message]"
		if(LOG_SUBTLER)
			colored_message = "(SUBTLER) [colored_message]"

	var/list/timestamped_message = list("\[[TIME_STAMP("hh:mm:ss", FALSE)]\] [key_name(src)] [loc_name(src)] (Event #[LAZYLEN(logging[smessage_type])])" = colored_message)

	logging[smessage_type] += timestamped_message

	if(client)
		client.player_details.logging[smessage_type] += timestamped_message

	..()

/mob/proc/can_hear()
	. = TRUE

/proc/bloodtype_to_color(type)
	. = BLOOD_COLOR_HUMAN
	switch(type)
		if("U")//Universal blood; a bit orange
			. = BLOOD_COLOR_UNIVERSAL
		if("SY")//Synthetics blood; blue
			. = BLOOD_COLOR_SYNTHETIC
		if("L")//lizard, a bit pink/purple
			. = BLOOD_COLOR_LIZARD
		if("X*")//xeno blood; greenish yellow
			. = BLOOD_COLOR_XENO
		if("HF")// Oil/Hydraulic blood. something something why not. reee
			. = BLOOD_COLOR_OIL
		if("GEL")// slimepeople blood, rgb 0, 255, 144
			. = BLOOD_COLOR_SLIME
		if("BUG")// yellowish, like, y'know bug guts I guess.
			. = BLOOD_COLOR_BUG
		//add more stuff to the switch if you have more blood colors for different types
		// the defines are in _DEFINES/misc.dm

//Examine text for traits shared by multiple types. I wish examine was less copypasted.
/mob/proc/common_trait_examine()
	if(HAS_TRAIT(src, TRAIT_DISSECTED))
		var/dissectionmsg = ""
		if(HAS_TRAIT_FROM(src, TRAIT_DISSECTED,"Extraterrestrial Dissection"))
			dissectionmsg = " via Extraterrestrial Dissection. It is no longer worth experimenting on"
		else if(HAS_TRAIT_FROM(src, TRAIT_DISSECTED,"Experimental Dissection"))
			dissectionmsg = " via Experimental Dissection"
		else if(HAS_TRAIT_FROM(src, TRAIT_DISSECTED,"Thorough Dissection"))
			dissectionmsg = " via Thorough Dissection"
		. += "<span class='notice'>This body has been dissected and analyzed[dissectionmsg].</span><br>"

//gets ID card object from special clothes slot or null.
/mob/proc/get_idcard(hand_first = TRUE)
	var/obj/item/held_item = get_active_held_item()
	. = held_item ? held_item.GetID() : null
	if(!.) //If so, then check the inactive hand
		held_item = get_inactive_held_item()
		. = held_item ? held_item.GetID() : null

/mob/proc/get_id_in_hand()
	var/obj/item/held_item = get_active_held_item()
	if(!held_item)
		return
	return held_item.GetID()

//Can the mob see reagents inside of containers?
/mob/proc/can_see_reagents()
	return stat == DEAD || silicon_privileges //Dead guys and silicons can always see reagents

/mob/proc/is_blind()
	SHOULD_BE_PURE(TRUE)
	return eye_blind ? TRUE : HAS_TRAIT(src, TRAIT_BLIND)

/mob/proc/can_read(obj/O)
	if(is_blind())
		to_chat(src, span_warning("As you are trying to read [O], you suddenly feel very stupid!"))
		return
	if(!is_literate())
		to_chat(src, span_notice("You try to read [O], but can't comprehend any of it."))
		return
	return TRUE

/mob/living/GetJob()
	if (mind && mind.assigned_role)
		return SSjob.GetJob(mind.assigned_role)

/mob/proc/SetPVPflag(setto, saypls)
	switch(setto)
		if(PVP_NEUTRAL)
			REMOVE_TRAIT(src, TRAIT_PVPFOC, ROUNDSTART_TRAIT)
			REMOVE_TRAIT(src, TRAIT_PVEFOC, ROUNDSTART_TRAIT)
			log_game("[key_name(src)] has removed their PVP flag.")
			SSpornhud.catalogue_part(src, PHUD_PVP_FLAG, list())
			if(saypls)
				to_chat(src, span_notice("You are no longer flagged as looking for or avoiding PVP. Standard PVP rules apply."))
		if(PVP_YES)
			ADD_TRAIT(src, TRAIT_PVPFOC, ROUNDSTART_TRAIT)
			REMOVE_TRAIT(src, TRAIT_PVEFOC, ROUNDSTART_TRAIT)
			log_game("[key_name(src)] has flagged themselves as looking for PVP.")
			var/image/iggy = image('icons/mob/hud.dmi', src, "pvp_yes")
			SSpornhud.catalogue_part(src, PHUD_PVP_FLAG, list(iggy))
			if(saypls)
				to_chat(src, span_notice("You are now flagged as looking for PVP. Note that you still need to use CI to perform PVP, and \
					you must respect the preferences of those who do not want to PVP."))
		if(PVP_NO)
			REMOVE_TRAIT(src, TRAIT_PVPFOC, ROUNDSTART_TRAIT)
			ADD_TRAIT(src, TRAIT_PVEFOC, ROUNDSTART_TRAIT)
			log_game("[key_name(src)] has opted out of PVP.")
			var/image/iggy = image('icons/mob/hud.dmi', src, "pvp_no")
			SSpornhud.catalogue_part(src, PHUD_PVP_FLAG, list(iggy))
			if(saypls)
				to_chat(src, span_notice("You are now flagged as having opted out of PVP. This means that others are not allowed to engage \
					in PVP with you, nor try to bait you into PVP. This also means that <b>you</b> are not allowed to engage in PVP or do \
					things that could be considered baiting others into PVP."))
	if(hud_used && hud_used.pvp_focus_toggle)
		hud_used.pvp_focus_toggle.update_intento(setto)







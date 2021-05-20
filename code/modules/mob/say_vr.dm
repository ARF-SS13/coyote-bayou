//////////////////////////////////////////////////////
////////////////////SUBTLE COMMAND////////////////////
//////////////////////////////////////////////////////
/mob
	var/flavor_text = "" //tired of fucking double checking this
	var/special_s = 5//done 1+(s/100) more dmg with melee weapons
	var/special_p = 5//done 10-p less accuracy with guns
	var/special_e = 5//done e*3 more max hp
	var/special_c = 5//done, RP and potential to stutter at less than 4
	var/special_i = 5//done, can't learn new skills at less than 5
	var/special_a = 5//done, (5-a)/20 multiplicative speed (9 = -0.2, 1 = 0.2)
	var/special_l = 5//done 10+3.5*l chance to get bonus items from trash piles

/mob/proc/get_top_level_mob()
	if(istype(src.loc,/mob)&&src.loc!=src)
		var/mob/M=src.loc
		return M.get_top_level_mob()
	return src

proc/get_top_level_mob(mob/S)
	if(istype(S.loc,/mob)&&S.loc!=S)
		var/mob/M=S.loc
		return M.get_top_level_mob()
	return S

///////////////// EMOTE CODE
// Maybe making this as an emote is less messy?
// It was - ktccd
/datum/emote/living/subtle
	key = "subtle"
	key_third_person = "subtle"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/subtle/proc/check_invalid(mob/user, input)
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
		return TRUE
	return FALSE

/datum/emote/living/subtle/run_emote(mob/user, params, type_override = null)
	if(jobban_isbanned(user, "emote"))
		to_chat(user, "You cannot send subtle emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		var/subtle_emote = stripped_multiline_input_or_reflect(user, "Choose an emote to display.", "Subtle", null, MAX_MESSAGE_LEN)
		if(subtle_emote && !check_invalid(user, subtle_emote))
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			message = subtle_emote
		else
			return FALSE
	else
		message = params
		if(type_override)
			emote_type = type_override
	. = TRUE
	if(!can_run_emote(user))
		return FALSE

	user.log_message(message, LOG_EMOTE)
	message = "<b>[user]</b> " + "<i>[user.say_emphasis(message)]</i>"

	for(var/mob/M in GLOB.dead_mob_list)
		if(!M.client || isnewplayer(M))
			continue
		var/T = get_turf(src)
		if(M.stat == DEAD && M.client && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(T, null)))
			M.show_message(message)

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message(message=message,hearing_distance=1)
	else
		user.visible_message(message=message,self_message=message,vision_distance=1)

/mob/proc/print_special()
	var/msg = "S:[special_s],P:[special_p],E:[special_e],C:[special_c],I:[special_i],A:[special_a],L:[special_l]<br>"

	if (special_s<3)
		msg += "<br>This person looks puny, like a total noodle."
	if (special_p<3)
		msg += "<br>Even with glasses, an elephant could easily sneak by them."
	if (special_e<3)
		msg += "<br>It looks like a stiff breeze could tear them in two."
	if (special_c<3)
		msg += "<br>Staggeringly ugly and awkward, they are about as smooth as pavement."
	if (special_i<3)
		msg += "<br>They look like they'd struggle to get water out of a boot with instructions printed on the heel."
	if (special_a<3)
		msg += "<br>Maladroit and unbalanced, it is a wonder they can even stand straight."
	if (special_l<3)
		msg += "<br>Misfortune just seems to stick to them like a fly to shit."

	if (special_s>7)
		msg += "<br>Simply built out of muscle, they could wrestle a deathclaw to death."
	if (special_p>7)
		msg += "<br>A sharp and attentive gaze almost pierces through you, nothing gets past them it seems."
	if (special_e>7)
		msg += "<br>As solid as an oak, they look like they could run for miles on end."
	if (special_c>7)
		msg += "<br>Beautiful and charismatic, you would almost beg to help this person."
	if (special_i>7)
		msg += "<br>A bright and careful gaze in their eyes, they seem to know much more than you."
	if (special_a>7)
		msg += "<br>Moving like a panther, it is a wonder you have even noticed that they are here."
	if (special_l>7)
		msg += "<br>Somehow you just know that they are as lucky as it gets."
	msg += "<br> *---------**---------*"
	return msg

///////////////// SUBTLE 2: NO GHOST BOOGALOO

/datum/emote/living/subtler
	key = "subtler"
	key_third_person = "subtler"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)


/datum/emote/living/subtler/proc/check_invalid(mob/user, input)
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
		return TRUE
	return FALSE

/datum/emote/living/subtler/run_emote(mob/user, params, type_override = null)
	if(jobban_isbanned(user, "emote"))
		to_chat(user, "You cannot send subtle emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		var/subtle_emote = stripped_multiline_input_or_reflect(user, "Choose an emote to display.", "Subtler" , null, MAX_MESSAGE_LEN)
		if(subtle_emote && !check_invalid(user, subtle_emote))
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			message = subtle_emote
		else
			return FALSE
	else
		message = params
		if(type_override)
			emote_type = type_override
	. = TRUE
	if(!can_run_emote(user))
		return FALSE

	user.log_message(message, LOG_SUBTLER)
	message = "<b>[user]</b> " + "<i>[user.say_emphasis(message)]</i>"

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message(message=message,hearing_distance=1, ignored_mobs = GLOB.dead_mob_list)
	else
		user.visible_message(message=message,self_message=message,vision_distance=1, ignored_mobs = GLOB.dead_mob_list)

///////////////// VERB CODE
/mob/living/proc/subtle_keybind()
	var/message = input(src, "", "subtle") as text|null
	if(!length(message))
		return
	return subtle(message)

/mob/living/verb/subtle()
	set name = "Subtle"
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	usr.emote("subtle")

///////////////// VERB CODE 2
/mob/living/verb/subtler()
	set name = "Subtler Anti-Ghost"
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	usr.emote("subtler")

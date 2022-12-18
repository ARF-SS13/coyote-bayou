/proc/replace_characters(t,list/repl_chars)
	for(var/char in repl_chars)
		t = replacetext_char(t, char, repl_chars[char])
	return t

/mob/living/simple_animal/hostile/retaliate/talker/follower
	var/list/known_commands = list("stay", "stop", "attack", "follow", "trust")
	var/list/allowed_targets = list() //WHO CAN I KILL D:
	var/retribution = 1 //whether or not they will attack us if we attack them like some kinda dick.
	emote_hear = list("Okay.", "Got it.", "Yep.", "Yup.", "Yes.")
	var/mob/target_mob = null
	var/followingAFriend = FALSE
	var/trust_no_one = FALSE

/mob/living/simple_animal/hostile/retaliate/talker/follower/dialog_options(mob/talker, display_options)
	var/dat = "" 
	if (!friends.Find(WEAKREF(talker)) && (intimidated.Find(WEAKREF(talker)) || introduced.Find(WEAKREF(talker))))
		dat += "<center><a href='?src=[REF(src)];together=1'>Try to convince them to follow you (Speech - persuade)</a></center>"
	if (friends.Find(WEAKREF(talker)) && !trust_no_one)
		dat += "<center><a href='?src=[REF(src)];only=1'>Convince them to only trust you (Speech - persuade)</a></center>"
		say("Just say who you want me to +follow+, who I can +trust+ or who to +attack+ and I'm on it.")
	return dat

/mob/living/simple_animal/hostile/retaliate/talker/follower/Topic(href, href_list)
	if(href_list["together"])
		usr.say("The wastes are a dangerous place, we should stick together.")
		if (!trust_no_one && !failed.Find(WEAKREF(usr)) && (usr.skill_check(SKILL_SPEECH, HARD_CHECK) || usr.skill_roll(SKILL_SPEECH) || intimidated.Find(WEAKREF(usr))))
			say("Alright you look like you've got it together. Where to?")
			friends |= WEAKREF(usr)
			if (istype(usr, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = usr
				H.mob_friends |= src
			show_dialog_box(usr, FALSE)
		else
			say("I'll take my chances out here.")
			failed |= WEAKREF(usr)
	if(href_list["only"])
		usr.say("There are lots of people you can't trust out there.")
		if (!failed.Find(WEAKREF(usr)) && (usr.skill_check(SKILL_SPEECH, EXPERT_CHECK) || usr.skill_roll(SKILL_SPEECH, DIFFICULTY_CHALLENGE)))
			say("You're right... we should stick together, just us.")
			trust_no_one = TRUE
			show_dialog_box(usr, FALSE)
		else
			say("No! You're trying to trick me, get lost!")
			failed |= WEAKREF(usr)
			friends -= WEAKREF(usr)
	..(href, href_list)
	
/mob/living/simple_animal/hostile/retaliate/talker/follower/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source)
	. = ..()
	if (friends.Find(WEAKREF(speaker)))
		listen(speaker, raw_message)
	return ..()

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/listen(var/mob/speaker, var/text)
	for(var/command in known_commands)
		if(findtext(text,command))
			switch(command)
				if("stay")
					if(stay_command(speaker,text)) //find a valid command? Stop. Dont try and find more.
						break
				if("stop")
					if(stop_command(speaker,text))
						break
				if("attack")
					if(attack_command(speaker,text))
						fight_time()
						break
				if("follow")
					if(follow_command(speaker,text))
						if(emote_hear && emote_hear.len)
							say("[pick(emote_hear)]")
						break
				if("trust")
					if(friend_command(speaker,text))
						if(emote_hear && emote_hear.len)
							say("[pick(emote_hear)]")
						break
				else
					misc_command(speaker,text) //for specific commands

	return 1

//returns a list of everybody we wanna do stuff with.
/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/get_targets_by_name(var/text, var/filter_friendlies = 0)
	var/list/possible_targets = hearers(src,10)
	. = list()
	for(var/mob/M in possible_targets)
		var/found = 0
		if(findtext(text, "[M]"))
			found = 1
		else
			var/list/parsed_name = splittext(replace_characters(lowertext(html_decode("[M]")),list("-"=" ", "."=" ", "," = " ", "'" = " ")), " ") //this big MESS is basically 'turn this into words, no punctuation, lowercase so we can check first name/last name/etc'
			for(var/a in parsed_name)
				if(a == "the" || length(a) < 2) //get rid of shit words.
					continue
				if(findtext(text,"[a]"))
					found = 1
					break
		if(found)
			. += WEAKREF(M)

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/attack_command(var/mob/speaker,var/text)
	target_mob = null //want me to attack something? Well I better forget my old target.
	walk_to(src,0)
	followingAFriend = FALSE
	stop_automated_movement = 0
	if(text == "attack" || findtext(text,"everyone") || findtext(text,"anybody") || findtext(text, "somebody") || findtext(text, "someone")) //if its just 'attack' then just attack anybody, same for if they say 'everyone', somebody, anybody. Assuming non-pickiness.
		allowed_targets = list("everyone")//everyone? EVERYONE
		return 1

	allowed_targets += get_targets_by_name(text)
	if(emote_hear && emote_hear.len)
		say("[pick(emote_hear)]")
	return allowed_targets.len != 0

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/stay_command(var/mob/speaker,var/text)
	target_mob = null
	followingAFriend = FALSE
	stop_automated_movement = 1
	walk_to(src,0)
	if(emote_hear && emote_hear.len)
		say("[pick(emote_hear)]")
	return 1

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/stop_command(var/mob/speaker,var/text)
	allowed_targets = list()
	followingAFriend = FALSE
	LoseTarget()
	walk_to(src,0)
	target_mob = null //gotta stop SOMETHIN
	stop_automated_movement = 0
	if(emote_hear && emote_hear.len)
		say("[pick(emote_hear)]")
	return 1

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/follow_command(var/mob/speaker,var/text)
	//we can assume 'stop following' is handled by stop_command
	if(findtext(text,"me"))
		target_mob = speaker //this wont bite me in the ass later.
		return 1
	var/list/targets = get_targets_by_name(text)
	if(targets.len > 1 || !targets.len) //CONFUSED. WHO DO I FOLLOW?
		return 0
	target_mob = targets[1] //YEAH GOOD IDEA
	return 1

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/friend_command(var/mob/speaker,var/text)
	//we can assume 'stop following' is handled by stop_command
	var/list/targets = get_targets_by_name(text)
	if(targets.len > 1 || !targets.len) //CONFUSED. WHO DO I FOLLOW?
		return 0
	friends |= WEAKREF(targets[1]) //YEAH GOOD IDEA
	return 1

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/misc_command(var/mob/speaker,var/text)
	return 0

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/follow_target()
	stop_automated_movement = 1
	if(!target_mob)
		return
	walk_to(src, target_mob, 1, move_to_delay)
	followingAFriend = TRUE

/mob/living/simple_animal/hostile/retaliate/talker/follower/CheckFriendlyFire(atom/A)
	if(check_friendly_fire)
		for(var/turf/T in getline(src,A)) // Not 100% reliable but this is faster than simulating actual trajectory
			for(var/mob/living/L in T)
				if(L == src || L == A)
					continue
				if(friends.Find(WEAKREF(L)))
					return TRUE
		return ..()

/mob/living/simple_animal/hostile/retaliate/talker/follower/Retaliate()
	var/list/around = view(src, vision_range)

	for(var/atom/movable/A in around)
		if(A == src)
			continue
		if(isliving(A))
			var/mob/living/M = A
			if(!friends.Find(WEAKREF(M)))
				enemies |= WEAKREF(M)
		else if(ismecha(A))
			var/obj/mecha/M = A
			if(M.occupant && !friends.Find(WEAKREF(M.occupant)))
				enemies |= WEAKREF(M)
				enemies |= WEAKREF(M.occupant)

	for(var/mob/living/simple_animal/hostile/retaliate/H in around)
		if(faction_check_mob(H) && !attack_same && !H.attack_same)
			H.enemies |= enemies
	return 0


/mob/living/simple_animal/hostile/retaliate/talker/follower/bullet_act(var/obj/item/projectile/P, var/def_zone)
	..()
	target_mob = null
	if (friends.Find(WEAKREF(P.firer)))
		friends -= WEAKREF(P.firer)

/mob/living/simple_animal/hostile/retaliate/talker/follower/attackby(var/obj/item/O, var/mob/user)
	..()
	target_mob = null
	if(friends.Find(WEAKREF(user)))
		friends -= WEAKREF(user)

/mob/living/simple_animal/hostile/retaliate/talker/follower/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)//Standardization and logging -Sieve
	..()
	target_mob = null
	if(ismob(throwingdatum.thrower))
		if(friends.Find(WEAKREF(throwingdatum.thrower)))
			friends -= WEAKREF(throwingdatum.thrower)

/mob/living/simple_animal/hostile/retaliate/talker/follower/proc/fight_time()
	if (allowed_targets.len)
		if (allowed_targets[1] == "everyone")
			Retaliate()
			allowed_targets = list()
		else
			enemies |= allowed_targets
			allowed_targets = list()

/mob/living/simple_animal/hostile/retaliate/talker/follower/handle_automated_movement()
	if(istype(target_mob) && !followingAFriend)
		follow_target()
	else if (!followingAFriend)
		. = ..()

/mob/living/simple_animal/hostile/retaliate/talker/follower/basic
	name = "Jeff"
	desc = "An officer part of Nanotrasen's private security force."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "nanotrasen"
	icon_living = "nanotrasen"
	icon_dead = null
	del_on_death = TRUE
	icon_gib = "syndicate_gib"
	turns_per_move = 5
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "shoves"
	response_disarm_simple = "shove"
	response_harm_continuous = "hits"
	response_harm_simple = "hit"
	speed = 0
	stat_attack = CONSCIOUS
	ranged_cooldown_time = 22
	ranged = TRUE
	robust_searching = TRUE
	healable = TRUE
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 15
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	faction = list("nanotrasenprivate")
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	search_objects = 1
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	vision_range = 9
	rapid = 3
	retreat_distance = 3
	minimum_distance = 5
	casingtype = /obj/item/ammo_casing/c9mm
	projectiletype = /obj/item/projectile/bullet/c9mm
	projectilesound = 'sound/weapons/gunshot_smg.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/autopipe,
				/obj/effect/mob_spawn/human/corpse/nanotrasensoldier)

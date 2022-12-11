/mob/living/simple_animal/hostile/retaliate/talker
	will_talk = TRUE
	var/list/broken_trust = list()
	var/list/introduced = list()
	var/list/failed = list()
	var/intimidated = FALSE
	
/mob/living/simple_animal/hostile/retaliate/talker/basic
	name = "Nanotrasen Private Security Officer"
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
	projectiletype = /obj/item/projectile/bullet/c46x30mm
	projectilesound = 'sound/weapons/gunshot_smg.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/autopipe,
				/obj/effect/mob_spawn/human/corpse/nanotrasensoldier)


/mob/living/simple_animal/hostile/retaliate/talker/talk_to(mob/talker)
	if (enemies.Find(WEAKREF(talker)))
		if(!broken_trust.Find(WEAKREF(talker)) && talker.skill_roll(SKILL_SPEECH))
			say("Alright.... But shoot me again and there will be trouble.")
			enemies -= WEAKREF(talker)
			broken_trust |= WEAKREF(talker)
		else
			say("Fight me or run- I don't trust you for nothin.")
	else
		show_dialog_box(talker)

/mob/living/simple_animal/hostile/retaliate/talker/proc/show_dialog_box(mob/talker, say_hello = TRUE)
	var/datum/browser/popup = new(talker, name, name, 400, 500)
	var/dat = dialog(talker, say_hello)
	popup.set_content(dat)
	popup.open()

/mob/living/simple_animal/hostile/retaliate/talker/proc/dialog(mob/talker, say_hello = TRUE)
	var/reply_name = "Stranger"
	var/we_introduced = FALSE
	if (introduced.Find(WEAKREF(talker)))
		reply_name = talker.name
		we_introduced = TRUE
	var/dat = ""
	if (!failed.Find(talker))
		dat +=  "Hello [reply_name]."
	else
		dat +=  "Oh, you again. What do you want?"
	if (say_hello)
		say(dat)
	if(!we_introduced)
		dat += "<center><a href='?src=[REF(src)];introduce=1'>Intoduce yourself</a></center>"
	if(!friends.Find(talker))
		dat += "<center><a href='?src=[REF(src)];stare=1'>Remain silent and stare. (Speech - Intimidate)</a></center>"
	dat += dialog_options(talker, we_introduced || intimidated)
	return dat

/mob/living/simple_animal/hostile/retaliate/talker/proc/dialog_options(mob/talker, display_options)
	return ""


/mob/living/simple_animal/hostile/retaliate/talker/Topic(href, href_list)
	if(href_list["introduce"])
		usr.say("My name is [usr.name].")
		introduced |= WEAKREF(usr)
		say("Pleased to meet you, [usr.name].")
		show_dialog_box(usr, FALSE)
	if(href_list["stare"])
		usr.emote("stare")
		introduced |= WEAKREF(usr)
		if (usr.skill_roll(SKILL_SPEECH) && !failed.Find(WEAKREF(usr)))
			say("Right... Can I help you?")
			intimidated = TRUE
		else
			emote("stare")
			failed |= WEAKREF(usr)
		show_dialog_box(usr, FALSE)


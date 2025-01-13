/////////////
// EYEBOTS //
/////////////

/mob/living/simple_animal/hostile/eyebot
	name = "eyebot"
	desc = "A hovering, propaganda-spewing reconnaissance and surveillance robot with radio antennas pointing out its back and loudspeakers blaring out the front."
	icon = 'icons/fallout/mobs/robots/eyebots.dmi'
	icon_state = "eyebot"
	icon_living = "eyebot"
	icon_dead = "eyebot_d"
	can_ghost_into = TRUE
	speak_chance = 0
	turns_per_move = 6
	environment_smash = 0
	response_help_simple = "touches"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	move_to_delay = 4
	robust_searching = 1
	mob_armor = ARMOR_VALUE_ROBOT_CIVILIAN
	maxHealth = 40
	health = 40
	stamcrit_threshold = SIMPLEMOB_NO_STAMCRIT
	emp_flags = list(
		MOB_EMP_STUN,
		MOB_EMP_BERSERK,
		MOB_EMP_DAMAGE,
		MOB_EMP_SCRAMBLE
		)
	healable = 0
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	blood_volume = 0
	faction = list(
		"hostile",
		"enclave",
		"wastebot",
		"ghoul",
		"cazador",
		"supermutant",
		"bighorner"
		)
	harm_intent_damage = 8
	melee_damage_lower = 2
	melee_damage_upper = 3
	minimum_distance = 6
	retreat_distance = 14
	attack_verb_simple = "punches"
	attack_sound = "punch"
	a_intent = "harm"
	tastes = list("metal" = 1, "glass" = 1)
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	tastes = list("metal" = 1, "glass" = 1)
	vision_range = 7 //reduced from 13 to 7 because who needs that kind of shit in their life
	aggro_vision_range = 7 //as above
	ranged = 1
	projectiletype = /obj/item/projectile/beam/laser/pistol/wastebot
	projectilesound = 'sound/weapons/resonator_fire.ogg'
	emote_taunt_sound = list('sound/f13npc/eyebot/aggro.ogg')
	idlesound = list('sound/f13npc/eyebot/idle1.ogg', 'sound/f13npc/eyebot/idle2.ogg')
	death_sound = 'sound/f13npc/eyebot/robo_death.ogg'
	speak_emote = list("states")
	loot = list()
	loot_drop_amount = 1
	loot_amount_random = TRUE
	bounty = 15
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(LASER_VOLUME),
		SP_VOLUME_SILENCED(LASER_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(LASER_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(LASER_DISTANT_SOUND),
		SP_DISTANT_RANGE(LASER_RANGE_DISTANT)
	)
	desc_short = "A flying metal meatball with lasers."
	variation_list = list(
		MOB_SPEED_LIST(3.5, 4, 4.5),
	)

/mob/living/simple_animal/hostile/eyebot/New()
	..()
	name = "ED-[rand(1,99)]"

/mob/living/simple_animal/hostile/eyebot/become_the_mob(mob/user)
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/robot
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/robot
	. = ..()

/mob/living/simple_animal/hostile/eyebot/playable
	ranged = FALSE
	health = 30
	maxHealth = 30
	attack_verb_simple = "zaps"
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	force_threshold = 10
	anchored = FALSE
	del_on_death = FALSE
	dextrous = TRUE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	speed = 2

/mob/living/simple_animal/hostile/eyebot/floatingeye
	name = "floating eyebot"
	desc = "A quick-observation robot commonly found in Pre-Fall military installations.<br>The floating eyebot uses a powerful taser to keep intruders in line."
	icon_state = "floatingeye"
	icon_living = "floatingeye"
	icon_dead = "floatingeye_d"

	retreat_distance = 4
	faction = list("hostile", "bs")

	projectiletype = /obj/item/projectile/energy/electrode
	projectilesound = 'sound/weapons/resonator_blast.ogg'

/mob/living/simple_animal/hostile/eyebot/floatingeye/New()
	..()
	name = "FEB-[rand(1,99)]"

/mob/living/simple_animal/hostile/eyebot/floatingeye/become_the_mob(mob/user)
	send_mobs = null
	call_backup = null
	. = ..()

/mob/living/simple_animal/pet/dog/eyebot //It's a propaganda eyebot, not a dog, but...
	name = "propaganda eyebot"
	desc = "This eyebot's weapons module has been removed and replaced with a loudspeaker. It appears to be shouting Pre-Fall propaganda."
	icon = 'icons/fallout/mobs/robots/eyebots.dmi'
	icon_state = "eyebot"
	icon_living = "eyebot"
	icon_dead = "eyebot_d"
	icon_gib = "eyebot_d"
	maxHealth = 60
	health = 60
	speak_chance = 8
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	faction = list("hostile", "enclave", "wastebot", "ghoul", "cazador", "supermutant", "bighorner")
	//speak = list()
	speak_emote = list("states")
	emote_hear = list()
	//emote_see = list("buzzes.","pings.","floats in place")
	response_help_simple  = "shakes the radio of"
	response_disarm_simple = "pushes"
	response_harm_simple   = "punches"
	attack_sound = 'sound/voice/liveagain.ogg'
	guaranteed_butcher_results = list(/obj/effect/gibspawner/robot = 1)
	blood_volume = 0

/mob/living/simple_animal/pet/dog/eyebot/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "beeps happily!", EMOTE_AUDIBLE)

/mob/living/simple_animal/pet/dog/eyebot/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	var/emp_damage = round((maxHealth * 0.1) * (severity * 0.1)) // 10% of max HP * 10% of severity(Usually around 20-40)
	adjustBruteLoss(emp_damage)

/mob/living/simple_animal/pet/dog/eyebot/panzer
	name = "Pvt. Eye"
	desc = "This eyebot's weapons module has been removed and replaced with a transmitter of some kind. It appears to be simply observing and feeding information to something passively."
	//emote_see = list("buzzes.","pings.","floats in place","beeps.","bobs left and right","bobs up and down")
	speak_chance = 1

/mob/living/simple_animal/pet/dog/eyebot/playable
	health = 200
	maxHealth = 200
	attack_verb_simple = "zaps"
	speak_chance = 0
	idlesound = null
	see_in_dark = 8
	wander = 0
	force_threshold = 10
	anchored = FALSE
	del_on_death = FALSE
	dextrous = TRUE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	speed = 2

/mob/living/simple_animal/pet/dog/eyebot/playable/become_the_mob(mob/user)
	send_mobs = null
	call_backup = null
	. = ..()

//Junkers
/mob/living/simple_animal/hostile/eyebot/reinforced
	name = "reinforced eyebot"
	desc = "An eyebot with beefier protection, and extra electronic aggression."
	color = "#B85C00"
	mob_armor = ARMOR_VALUE_ROBOT_CIVILIAN
	maxHealth = 100
	health = 100
	faction = list("raider", "wastebot")
	extra_projectiles = 1
	auto_fire_delay = GUN_AUTOFIRE_DELAY_SLOWER
	melee_damage_lower = 5
	melee_damage_upper = 10
	minimum_distance = 4
	retreat_distance = 6
	bounty = 20

/mob/living/simple_animal/hostile/eyebot/reinforced/become_the_mob(mob/user)
	send_mobs = null
	call_backup = null
	. = ..()

//Start of colfers Hivebots

/mob/living/simple_animal/hostile/eyebot/playable/hivebot
	name = "Cheap Ranged Hivebot"
	desc = "A friendly hivebot with a basic, constant beam, useful for chewing through the weakest of the wasteland."
	ranged = TRUE
	can_ghost_into = TRUE
	projectiletype = /obj/item/projectile/beam/cranklasergun/tg/spamlaser/shocker
	projectilesound = 'sound/weapons/taser2.ogg'
	auto_fire_delay = GUN_AUTOFIRE_DELAY_SLOW
	ranged_cooldown_time = 30
	extra_projectiles = 2
	ranged_extra_spread_per_shot = 2
	ranged_max_spread = 21
	ranged_base_spread = 0
	decompose = FALSE
	despawns_when_lonely = FALSE
	health = 30
	maxHealth = 30
	mob_armor = ARMOR_VALUE_ZERO
	speed = 2
	icon = 'icons/mob/playerswarmer.dmi'
	icon_state = "ranged_hivebot"
	icon_living = "ranged_hivebot"
	icon_dead = "ranged_hivebot_dead"
	idlesound = 'modular_coyote/sound/typing/hivebot-bark-003.ogg'
	death_sound = 'modular_coyote/sound/typing/hivebot-attack.ogg'
	deathmessage = "was destroyed, use a multi-tool to revive them!"
	attack_verb_simple = "zaps"
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	attack_phrase = "Engage" //Makes the mob become hostile (if it wasn't beforehand) upon hearing
	hide_phrase = "Standby"
	peace_phrase = "Standby"
	see_in_dark = 7
	light_color = "#2BFF2B"
	light_range = 4
	light_power = 3
	emp_flags = list(
		MOB_EMP_STUN,
		MOB_EMP_DAMAGE
		)
	send_mobs = null
	call_backup = null
	wander = 0
	minimum_distance = 2
	retreat_distance = 3
	faction = list(
		"neutral"
		)
	anchored = FALSE
	del_on_death = FALSE
	dextrous = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	move_to_delay = 4
	loot = list()
	loot_drop_amount = 0
	loot_amount_random = FALSE

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/Initialize(mapload)
	. = ..()
	notify_ghosts("A new FRIENDLY hivebot has been created somewhere on the map, click it to take control!", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_FUGITIVE)

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/New()
	..()
	name = "Cheap Ranged Hivebot-[rand(1,99)]"

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/examine(mob/user)
	. = list("<span class='info'>*---------*\nThis is [icon2html(src, user)] \a <b>[src]</b>!")

	if(health != maxHealth)
		if(health > maxHealth * 0.50) //Between maxHealth and about a third of maxHealth, between 30 and 10 for normal drones
			. += span_warning("Its screws are slightly loose.")
		else //otherwise, below about 33%
			. += span_boldwarning("Its screws are very loose!")

	if(stat == DEAD)
		if(client)
			. += span_deadsay("A message repeatedly flashes on its display: \"MULTITOOL -- REQUIRED\".")
		else
			. += span_deadsay("A message repeatedly flashes on its display: \"ERROR -- OFFLINE\".")
	. += "*---------*</span>"

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/attackby(obj/item/I, mob/user)
	. = ..()
	if(istype(I, /obj/item/screwdriver) && stat != DEAD)
		if(health < maxHealth)
			to_chat(user, span_notice("You start to tighten loose screws on [src]..."))
			if(I.use_tool(src, user, 60))
				adjustBruteLoss(-getBruteLoss())
				visible_message(span_notice("[user] tightens [src == user ? "[user.p_their()]" : "[src]'s"] loose screws!"), span_notice("You tighten [src == user ? "your" : "[src]'s"] loose screws."))
			else
				to_chat(user, span_warning("You need to remain still to tighten [src]'s screws!"))
		else
			to_chat(user, span_warning("[src]'s screws can't get any tighter!"))
		return //This used to not exist and drones who repaired themselves also stabbed the shit out of themselves.

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/attackby(obj/item/I, mob/user)
	. = ..()
	if(istype(I, /obj/item/multitool) && stat == DEAD)
		try_reactivating(user)

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/proc/try_reactivating(mob/living/user)
	/*var/mob/dead/observer/G = get_ghost()
	if(!client && (!G || !G.client))
		var/list/faux_gadgets = list("hypertext inflator","failsafe directory","DRM switch","stack initializer",\
									"anti-freeze capacitor","data stream diode","TCP bottleneck","supercharged I/O bolt",\
									"tradewind stabilizer","radiated XML cable","registry fluid tank","open-source debunker")

		var/list/faux_problems = list("won't be able to tune their bootstrap projector","will constantly remix their binary pool"+\
									  " even though the BMX calibrator is working","will start leaking their XSS coolant",\
									  "can't tell if their ethernet detour is moving or not", "won't be able to reseed enough"+\
									  " kernels to function properly","can't start their neurotube console")

		to_chat(user, span_warning("You can't seem to find the [pick(faux_gadgets)]! Without it, [src] [pick(faux_problems)]."))
		return*/
	user.visible_message(span_notice("[user] begins to reactivate [src]."), span_notice("You begin to reactivate [src]..."))
	if(do_after(user, 130, 1, target = src))
		revive(full_heal = 1)
		user.visible_message(span_notice("[user] reactivates [src]!"), span_notice("You reactivate [src]."))
		/*if(G)
			to_chat(G, span_ghostalert("You([name]) were reactivated by [user]!"))*/
	else
		to_chat(user, span_warning("You need to remain still to reactivate [src]!"))

// The other hivebots

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/tier2
	desc = "A friendly hivebot with a powerful laser burst rifle."
	icon_state = "rangedarm_hivebot"
	icon_living = "rangedarm_hivebot"
	icon_dead = "rangedarm_hivebot_dead"
	projectiletype = /obj/item/projectile/beam/laser/cranklasergun/tg
	projectilesound = 'sound/weapons/magpistol.ogg'
	auto_fire_delay = GUN_AUTOFIRE_DELAY_SLOW
	mob_armor = ARMOR_VALUE_LIGHT
	ranged_cooldown_time = 30
	extra_projectiles = 5
	ranged_extra_spread_per_shot = 2
	ranged_max_spread = 5
	ranged_base_spread = 0
	health = 45
	maxHealth = 45
	move_to_delay = 6

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/tier2/New()
	..()
	name = "Ranged Hivebot-[rand(1,99)]"

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/tier3
	desc = "An advanced friendly hivebot with a heavy laser cannon."
	icon_state = "hunter_hivebot"
	icon_living = "hunter_hivebot"
	icon_dead = "hunter_hivebot_dead"
	projectiletype = /obj/item/projectile/beam/cranklasergun/tg/rifle/heavy
	projectilesound = 'sound/weapons/magrifle.ogg'
	auto_fire_delay = GUN_AUTOFIRE_DELAY_SLOWER
	mob_armor = ARMOR_VALUE_LIGHT
	ranged_cooldown_time = 30
	extra_projectiles = 2
	ranged_extra_spread_per_shot = 1
	ranged_max_spread = 5
	ranged_base_spread = 0
	health = 60
	maxHealth = 60
	speed = 2
	move_to_delay = 8

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/tier3/New()
	..()
	name = "Advanced Ranged Hivebot-[rand(1,99)]"
// Melee start

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/melee
	name = "Cheap Melee Hivebot"
	desc = "A friendly hivebot that cuts down foes ruthlessly in melee without a care for itself."
	ranged = FALSE
	icon_state = "smallarm_hivebot"
	icon_living = "smallarm_hivebot"
	icon_dead = "smallarm_hivebot_dead"
	move_to_delay = 0.2
	retreat_distance = 0
	minimum_distance = 0
	harm_intent_damage = 7
	rapid_melee = 2
	health = 50
	maxHealth = 50
	mob_armor = ARMOR_VALUE_LIGHT
	speed = 1
	melee_damage_lower = 1
	melee_damage_upper = 10
	melee_attack_cooldown = 0.5 SECONDS

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/melee/New()
	..()
	name = "Cheap Melee Hivebot-[rand(1,99)]"

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/melee/tier2
	name = "Melee Hivebot"
	desc = "A friendly hivebot that cuts down foes ruthlessly in melee without a care for itself."
	ranged = FALSE
	icon_state = "medium_hivebot"
	icon_living = "medium_hivebot"
	icon_dead = "medium_hivebot_dead"
	retreat_distance = 0
	minimum_distance = 0
	move_to_delay = 0.2
	speed = 1
	health = 100
	maxHealth = 100
	melee_damage_lower = 5
	melee_damage_upper = 15
	melee_attack_cooldown = 1 SECONDS

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/melee/tier2/New()
	..()
	name = "Melee Hivebot-[rand(1,99)]"

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/melee/tier3
	name = "Advanced Melee Hivebot"
	desc = "A friendly hivebot that cuts down foes ruthlessly in melee without a care for itself."
	ranged = FALSE
	icon_state = "keeper_hivebot"
	icon_living = "keeper_hivebot"
	icon_dead = "keeper_hivebot_dead"
	retreat_distance = 0
	minimum_distance = 0
	move_to_delay = 0.2
	speed = 1
	health = 150
	maxHealth = 150
	melee_damage_lower = 10
	melee_damage_upper = 20
	melee_attack_cooldown = 2 SECONDS

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/melee/tier3/New()
	..()
	name = "Advanced Melee Hivebot-[rand(1,99)]"

//Joke one

/mob/living/simple_animal/hostile/eyebot/playable/hivebot/joketier
	name = "Hivebot Fortress"
	desc = "A flying fortress armed with laser miniguns, a danger to all."
	projectiletype = /obj/item/projectile/beam/laser/cranklasergun/tg
	projectilesound = 'sound/weapons/magburst.ogg'
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	ranged_cooldown_time = 30
	extra_projectiles = 30
	ranged_extra_spread_per_shot = 1
	ranged_max_spread = 30
	ranged_base_spread = 0
	despawns_when_lonely = FALSE
	health = 400
	maxHealth = 400
	mob_armor = ARMOR_VALUE_HEAVY
	speed = 8
	move_to_delay = 8
	icon = 'icons/mob/netguardian.dmi'
	icon_state = "netguardian"
	icon_living = "netguardian"
	icon_dead = "netguardian-crash"

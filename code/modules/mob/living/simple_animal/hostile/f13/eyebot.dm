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
	loot = list(/obj/effect/spawner/lootdrop/f13/trash)
	loot_drop_amount = 1
	loot_amount_random = TRUE
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
	speak = list()
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

/mob/living/simple_animal/hostile/eyebot/reinforced/become_the_mob(mob/user)
	send_mobs = null
	call_backup = null
	. = ..()

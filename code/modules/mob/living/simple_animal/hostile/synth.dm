/mob/living/simple_animal/hostile/synth
	name = "synth mk1"
	desc = "Synth strider. Looks like a weird human but it's a machine."
	icon = 'icons/fallout/mobs/robots/weirdrobots.dmi'
	icon_state = "synthmk1"
	icon_living = "synthmk1"
	icon_dead = "synthmk1_d"
	icon_gib = "synthmk1_d"
	speak_chance = 0
	turns_per_move = 7
	environment_smash = 0
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	move_to_delay = 3
	stat_attack = 1
	robust_searching = 1
	maxHealth = 150
	health = 150

	healable = 0

	faction = list("hostile", "institute")

	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 15
	minimum_distance = 4
	retreat_distance = 7
	attack_verb_simple = "punches"
	attack_sound = "punch"
	a_intent = "harm"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	vision_range = 12
	aggro_vision_range = 15

	ranged = 1
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/f13weapons/laser_pistol.ogg'

/mob/living/simple_animal/hostile/synth/playable
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	environment_smash = 2 //can smash walls
	wander = 0
	anchored = FALSE
	dextrous = TRUE

/mob/living/simple_animal/hostile/synth/mk2
	name = "synth mk2"
	icon_state = "synthmk2"
	icon_living = "synthmk2"
	icon_dead = "synthmk2_d"
	icon_gib = "synthmk2_d"
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/f13weapons/laser_rifle.ogg'

/mob/living/simple_animal/hostile/synth/mk2/playable
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	environment_smash = 2 //can smash walls
	wander = 0
	anchored = FALSE
	dextrous = TRUE

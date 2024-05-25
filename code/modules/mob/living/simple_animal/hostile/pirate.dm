/mob/living/simple_animal/hostile/raider/pirate
	name = "Pirate"
	desc = "Does what he wants cause a pirate is free."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "piratemelee"
	icon_living = "piratemelee"
	icon_dead = "pirate_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "pushes"
	response_help_simple = "push"
	speed = 0
	maxHealth = 115
	health = 115
	spacewalk = TRUE
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	//atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	//unsuitable_atmos_damage = 15
	speak_emote = list("yarrs")
	loot = /obj/item/melee/transforming/plasmacutter/sword/pirate
	del_on_death = 0
	faction = list("pirate")
	light_system = MOVABLE_LIGHT
	light_range = 2
	retreat_health_percent = 0.1
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 10
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 2
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/raider/pirate/melee
	name = "Pirate Swashbuckler"
	icon_state = "piratemelee"
	icon_living = "piratemelee"
	icon_dead = "piratemelee_dead"
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/blade1.ogg'
	var/obj/effect/light_emitter/red_energy_sword/sord

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/pirate/melee/space
	name = "Space Pirate Swashbuckler"
	icon_state = "piratespace"
	icon_living = "piratespace"
	icon_dead = "piratespace_dead"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	//minbodytemp = 0
	speed = 1
	spacewalk = TRUE

/mob/living/simple_animal/hostile/raider/pirate/melee/Initialize()
	. = ..()
	sord = new(src)

/mob/living/simple_animal/hostile/raider/pirate/melee/Destroy()
	QDEL_NULL(sord)
	return ..()

/mob/living/simple_animal/hostile/raider/pirate/ranged
	name = "Pirate Gunner"
	icon_state = "pirateranged"
	icon_living = "pirateranged"
	icon_dead = "pirateranged_dead"
	projectilesound = 'sound/weapons/laser.ogg'
	ranged = 1
	rapid = 2
	rapid_fire_delay = 6
	retreat_distance = 5
	minimum_distance = 5
	projectiletype = /obj/item/projectile/beam/laser
	loot = list(
		/obj/item/gun/energy/laser
		)
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


/mob/living/simple_animal/hostile/raider/pirate/ranged/space
	name = "Space Pirate Gunner"
	icon_state = "piratespaceranged"
	icon_living = "piratespaceranged"
	icon_dead = "piratespaceranged_dead"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	//minbodytemp = 0
	speed = 1
	spacewalk = TRUE

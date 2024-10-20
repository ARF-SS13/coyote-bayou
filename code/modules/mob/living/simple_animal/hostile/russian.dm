/mob/living/simple_animal/hostile/russian
	name = "Russian"
	desc = "For the Motherland!"
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "russianmelee"
	icon_living = "russianmelee"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = /obj/item/kitchen/knife
	//atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	//unsuitable_atmos_damage = 15
	faction = list("russian")
	status_flags = CANPUSH
	del_on_death = 0
	retreat_health_percent = 0.2
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 10
	footstep_type = FOOTSTEP_MOB_SHOE
	loot = list()
	loot_drop_amount = 2
	loot_amount_random = TRUE


/mob/living/simple_animal/hostile/russian/ranged
	icon_state = "russianranged"
	icon_living = "russianranged"
	loot = /obj/item/gun/ballistic/rifle/mosin
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectilesound = 'sound/weapons/gunshot.ogg'
	casingtype = /obj/item/ammo_casing/a357


/mob/living/simple_animal/hostile/russian/ranged/mosin
	loot = /obj/item/gun/ballistic/rifle/mosin
	casingtype = /obj/item/ammo_casing/a308

/mob/living/simple_animal/hostile/russian/ranged/trooper
	icon_state = "russianrangedelite"
	icon_living = "russianrangedelite"
	maxHealth = 150
	health = 150
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	loot = /obj/item/gun/ballistic/rifle/mosin

/mob/living/simple_animal/hostile/russian/ranged/officer
	name = "Russian Officer"
	icon_state = "russianofficer"
	icon_living = "russianofficer"
	maxHealth = 65
	health = 65
	rapid = 3
	casingtype = /obj/item/ammo_casing/c9mm
	loot = /obj/item/gun/ballistic/rifle/mosin

/mob/living/simple_animal/hostile/russian/ranged/officer/Aggro()
	..()
	summon_backup(15)

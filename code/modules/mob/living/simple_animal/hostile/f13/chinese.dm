/mob/living/simple_animal/hostile/chinese
	name = "chinese remnant soldier"
	desc = "Chinese soldiers who survived the Great War via ghoulification, and now shoot anything that isn't their own on sight."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "chinesesoldier"
	icon_living = "chinesesoldier"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 8
	melee_damage_lower = 25
	melee_damage_upper = 50
	attack_verb_simple = "punches"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/chineseremnant, /obj/item/kitchen/knife/combat)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("china")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1

/mob/living/simple_animal/hostile/chinese/ranged
	icon_state = "chinesepistol"
	icon_living = "chinesepistol"
	loot = list(/obj/effect/mob_spawn/human/corpse/chineseremnant/pistol, /obj/item/gun/ballistic/automatic/pistol/type17, /obj/item/ammo_box/magazine/m9mm)
	ranged = 1
	maxHealth = 110
	health = 110
	retreat_distance = 4
	minimum_distance = 6
	projectiletype = /obj/item/projectile/bullet/c9mm
	projectilesound =  'sound/f13weapons/ninemil.ogg'

/mob/living/simple_animal/hostile/chinese/ranged/assault
	name = "chinese remnant assault soldier"
	icon_state = "chineseassault"
	icon_living = "chineseassault"
	maxHealth = 200
	health = 200
	extra_projectiles = 2
	loot = list(/obj/effect/mob_spawn/human/corpse/chineseremnant/assault, /obj/item/gun/ballistic/automatic/type93, /obj/item/ammo_box/magazine/m556/rifle/assault)
	projectiletype = /obj/item/projectile/bullet/a556/ap
	projectilesound = 'sound/f13weapons/assaultrifle_fire.ogg'

/mob/living/simple_animal/hostile/chinese/ranged/assault/Aggro()
	..()
	summon_backup(15)

/mob/living/simple_animal/hostile/raider
	name = "Raider"
	desc = "Another murderer churned out by the wastes."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "raider_melee"
	icon_living = "raider_melee"
	icon_dead = "raider_generic_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	maxHealth = 140
	health = 140
	harm_intent_damage = 8
	melee_damage_lower = 25
	melee_damage_upper = 50
	attack_verb_simple = "punches"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/item/melee/onehanded/knife/survival)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("raider")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = FALSE

/mob/living/simple_animal/hostile/raider/thief

/obj/effect/mob_spawn/human/corpse/raider
	name = "Raider"
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/f13/raider/iconoclast
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/firefighter
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/raider/Aggro()
	..()
	summon_backup(15)
	say("HURRY, HURRY, HURRY!!!")

/mob/living/simple_animal/hostile/raider/thief/movement_delay()
	return -2

/mob/living/simple_animal/hostile/raider/thief/AttackingTarget()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.stat == SOFT_CRIT)
			var/back_target = H.back
			if(back_target)
				H.dropItemToGround(back_target, TRUE)
				src.transferItemToLoc(back_target, src, TRUE)
			var/belt_target = H.belt
			if(belt_target)
				H.dropItemToGround(belt_target, TRUE)
				src.transferItemToLoc(belt_target, src, TRUE)
			var/shoe_target = H.shoes
			if(shoe_target)
				H.dropItemToGround(shoe_target, TRUE)
				src.transferItemToLoc(shoe_target, src, TRUE)
			retreat_distance = 50
			addtimer(CALLBACK(src, .proc/undo_retreat), 5 MINUTES)
		else
			. = ..()

/mob/living/simple_animal/hostile/raider/thief/proc/undo_retreat()
	retreat_distance = null

/mob/living/simple_animal/hostile/raider/thief/death(gibbed)
	for(var/obj/I in contents)
		src.dropItemToGround(I)
	. = ..()

/mob/living/simple_animal/hostile/raider/ranged
	icon_state = "raider_ranged"
	icon_living = "raider_ranged"
	loot = list(/obj/effect/spawner/lootdrop/f13/npc_raider)
	ranged = 1
	maxHealth = 115
	health = 115
	retreat_distance = 4
	minimum_distance = 6
	projectiletype = /obj/item/projectile/bullet/c9mm/op
	projectilesound = 'sound/f13weapons/ninemil.ogg'

/mob/living/simple_animal/hostile/raider/legendary
	loot = list(/obj/item/melee/onehanded/knife/survival, /obj/item/reagent_containers/food/snacks/kebab/human)
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes - this one seems a bit faster than the average..."
	color = "#FFFF00"
	maxHealth = 450
	health = 450
	speed = 1.2
	obj_damage = 300
	aggro_vision_range = 15

/mob/living/simple_animal/hostile/raider/ranged/legendary
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes, wielding a decent pistol and looking very strong"
	color = "#FFFF00"
	loot = list(/obj/item/gun/ballistic/revolver/m29)
	ranged = 1
	maxHealth = 600
	health = 600
	retreat_distance = 1
	minimum_distance = 2
	projectiletype = /obj/item/projectile/bullet/m44
	projectilesound = 'sound/f13weapons/44mag.ogg'
	extra_projectiles = 1
	aggro_vision_range = 15
	obj_damage = 300

/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged
	icon_state = "metal_raider"
	icon_living = "metal_raider"
	icon_dead = "metal_raider_dead"
	loot = list(/obj/item/gun/ballistic/automatic/pistol/m1911/custom)
	ranged = 1
	maxHealth = 180
	health = 180
	projectiletype = /obj/item/projectile/bullet/c45/op
	projectilesound = 'sound/weapons/gunshot.ogg'

/mob/living/simple_animal/hostile/raider/ranged/boss
	name = "Raider Boss"
	icon_state = "raider_boss"
	icon_living = "raider_boss"
	icon_dead = "raider_boss_dead"
	maxHealth = 170
	health = 170
	extra_projectiles = 3
	projectiletype = /obj/item/projectile/bullet/c45/op
	loot = list(/obj/item/gun/ballistic/automatic/smg/greasegun)

/mob/living/simple_animal/hostile/raider/ranged/boss/Aggro()
	..()
	summon_backup(15)
	say("KILL 'EM, FELLAS!")

/mob/living/simple_animal/hostile/raider/firefighter
	icon_state = "firefighter_raider"
	icon_living = "firefighter_raider"
	icon_dead = "firefighter_raider_dead"
	icon_gib = "firefighter_raider"
	retreat_distance = 0
	minimum_distance = 0
	melee_damage_lower = 50
	melee_damage_upper = 50
	loot = list(/obj/item/twohanded/fireaxe)
	healable = 1
	ranged = 0

/mob/living/simple_animal/hostile/raider/biker
	icon_state = "biker_raider"
	icon_living = "biker_raider"
	icon_dead = "biker_raider"
	icon_gib = "biker_raider"
	retreat_distance = 4
	minimum_distance = 4
	melee_damage_lower = 20
	melee_damage_upper = 20
	maxHealth = 200
	health = 200
	loot = list(/obj/item/gun/ballistic/revolver/thatgun)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a556/match
	projectilesound = 'sound/f13weapons/magnum_fire.ogg'
	casingtype = /obj/item/ammo_casing/a556

/obj/effect/mob_spawn/human/corpse/raider/biker
	uniform = /obj/item/clothing/under/f13/ncrcf
	suit = /obj/item/clothing/suit/armor/f13/combatrusted
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/raidercombathelmet
	neck = /obj/item/clothing/neck/mantle/brown

/mob/living/simple_animal/hostile/raider/baseball
	icon_state = "baseball_raider"
	icon_living = "baseball_raider"
	icon_dead = "baseball_raider_dead"
	icon_gib = "baseball_raider"
	retreat_distance = 1
	minimum_distance = 1
	melee_damage_lower = 40
	melee_damage_upper = 40
	maxHealth = 200
	health = 200
	loot = list(/obj/item/twohanded/baseball)
	healable = 1
	ranged = 0

/obj/effect/mob_spawn/human/corpse/raider/baseball
	uniform = /obj/item/clothing/under/f13/mechanic
	suit = /obj/item/clothing/suit/armor/f13/raider/yankee
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/raider/yankee
	//back = /obj/item/weapon/storage/backpack

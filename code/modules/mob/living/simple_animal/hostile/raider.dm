/mob/living/simple_animal/hostile/raider
	name = "Raider"
	desc = "Another murderer churned out by the wastes."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "raidermelee"
	icon_living = "raidermelee"
	icon_dead = "raidermelee_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = list(MOB_ORGANIC, MOB_HUMANOID)
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
	loot = list(/obj/effect/mob_spawn/human/corpse/raidermelee, /obj/item/kitchen/knife/combat/survival)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("raider")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1

/mob/living/simple_animal/hostile/raider/thief

/mob/living/simple_animal/hostile/raider/thief/movement_delay()
	return -2

/mob/living/simple_animal/hostile/raider/thief/AttackingTarget()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
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

/mob/living/simple_animal/hostile/raider/thief/proc/undo_retreat()
	retreat_distance = null

/mob/living/simple_animal/hostile/raider/thief/death(gibbed)
	for(var/obj/I in contents)
		src.dropItemToGround(I)
	. = ..()

/mob/living/simple_animal/hostile/raider/ranged
	icon_state = "raiderranged"
	icon_living = "raiderranged"
	loot = list(/obj/effect/mob_spawn/human/corpse/raiderranged, /obj/item/gun/ballistic/automatic/pistol/ninemil)
	ranged = 1
	maxHealth = 115
	health = 115
	retreat_distance = 4
	minimum_distance = 6
	projectiletype = /obj/item/projectile/bullet/c9mm
	projectilesound = 'sound/f13weapons/ninemil.ogg'

/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged
	icon_state = "ranged_sulphitemob"
	icon_living = "ranged_sulphitemob"
	loot = list(/obj/effect/mob_spawn/human/corpse/raiderrangedsulphite, /obj/item/gun/ballistic/automatic/pistol/m1911 )
	ranged = 1
	maxHealth = 180
	health = 180
	projectiletype = /obj/item/projectile/bullet/c45
	projectilesound = 'sound/weapons/gunshot.ogg'

/mob/living/simple_animal/hostile/raider/ranged/boss
	name = "Raider Boss"
	icon_state = "raiderboss"
	icon_living = "raiderboss"
	maxHealth = 170
	health = 170
	extra_projectiles = 2
	loot = list(/obj/effect/mob_spawn/human/corpse/raiderboss, /obj/item/gun/ballistic/automatic/greasegun)

/mob/living/simple_animal/hostile/raider/ranged/boss/Aggro()
	..()
	summon_backup(15)
	say("KILL 'EM, FELLAS!")

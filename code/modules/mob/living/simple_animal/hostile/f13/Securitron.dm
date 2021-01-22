//Fallout 13 securitron directory

/mob/living/simple_animal/hostile/securitron
	name = "securitron"
	desc = "A pre-War type of securitron.<br>Extremely dangerous machine."
	icon = 'icons/fallout/mobs/robots.dmi'
	icon_state = "Securitron"
	icon_living = "Securitron"
	icon_dead = "Securitron_d"
	icon_gib = "Securitron_d"
	speak_chance = 1
	turns_per_move = 5
	environment_smash = 0
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	move_to_delay = 5
	stat_attack = 1
	robust_searching = 1
	maxHealth = 300
	health = 300
	del_on_death = 1
	healable = 0
	faction = list("wastebot")
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	emote_hear = list("Beeps.")
	speak = list("Stop Right There Criminal.")
	death_sound = null
	harm_intent_damage = 8
	melee_damage_lower = 5
	melee_damage_upper = 10
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
	projectilesound = 'sound/weapons/resonator_fire.ogg'
	blood_volume = 0

/mob/living/simple_animal/hostile/securitron/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		CRASH("[src] securitron invoked bullet_act() without a projectile")
	if(prob(10) && health > 1)
		visible_message("<span class='danger'>\The [src] releases a defensive flashbang!</span>")
		var/flashbang_turf = get_turf(src)
		if(!flashbang_turf)
			return
		var/obj/item/grenade/flashbang/sentry/S = new /obj/item/grenade/flashbang/sentry(flashbang_turf)
		S.preprime(user = null)
	if(prob(75) || Proj.damage > 26) //prob(x) = chance for proj to actually do something, adjust depending on how OP you want sentrybots to be
		return ..()
	else
		visible_message("<span class='danger'>\The [Proj] bounces off \the [src]'s armor plating!</span>")
		return FALSE

/mob/living/simple_animal/hostile/securitron/proc/do_death_beep()
	playsound(src, 'sound/machines/triple_beep.ogg', 75, TRUE)
	visible_message("<span class='warning'>You hear an ominous beep coming from [src]!</span>", "<span class='warning'>You hear an ominous beep!</span>")

/mob/living/simple_animal/hostile/securitron/proc/self_destruct()
	explosion(src,1,2,4,4)
	qdel(src)

/mob/living/simple_animal/hostile/securitron/death()
	do_sparks(3, TRUE, src)
	for(var/i in 1 to 3)
		addtimer(CALLBACK(src, .proc/do_death_beep), i * 1 SECONDS)
	addtimer(CALLBACK(src, .proc/self_destruct), 4 SECONDS)
	return ..()

/mob/living/simple_animal/hostile/securitron/Aggro()
	. = ..()
	summon_backup(15)

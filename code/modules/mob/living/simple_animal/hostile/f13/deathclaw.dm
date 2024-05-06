/*IN THIS FILE:
-Deathclaws
*/

//Base Deathclaw
/mob/living/simple_animal/hostile/deathclaw
	name = "deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match."
	icon = 'icons/fallout/mobs/monsters/deathclaw.dmi'
	icon_state = "deathclaw"
	icon_living = "deathclaw"
	icon_dead = "deathclaw_dead"
	icon_gib = "deathclaw_gib"
	mob_armor = ARMOR_VALUE_DEATHCLAW_COMMON
	maxHealth = 250
	health = 250
	reach = 2
	speed = 1
	obj_damage = 200
	melee_damage_lower = 30
	melee_damage_upper = 40
	footstep_type = FOOTSTEP_MOB_HEAVY
	move_to_delay = 2.4 //hahahahahahahaaaaa
	gender = MALE
	a_intent = INTENT_HARM //So we can not move past them.
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	sentience_type = SENTIENCE_BOSS
	robust_searching = TRUE
	speak = list("ROAR!","Rawr!","GRRAAGH!","Growl!")
	speak_emote = list("growls", "roars")
	emote_hear = list("grumbles.","grawls.")
	emote_taunt = list("stares ferociously", "stomps")
	speak_chance = 10
	taunt_chance = 25
	tastes = list("a bad time" = 5, "dirt" = 1)
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS | ENVIRONMENT_SMASH_RWALLS //can smash walls
	var/color_mad = "#ffc5c5"
	see_in_dark = 8
	decompose = FALSE
	wound_bonus = 0 //This might be a TERRIBLE idea
	bare_wound_bonus = 0
	sharpness = SHARP_EDGED
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 4,
							/obj/item/stack/sheet/animalhide/deathclaw = 2,
							/obj/item/stack/sheet/bone = 4)
	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "hits"
	attack_verb_simple = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list("deathclaw")
	gold_core_spawnable = HOSTILE_SPAWN
	//var/charging = FALSE
	move_resist = MOVE_FORCE_OVERPOWERING
	emote_taunt_sound = list('sound/f13npc/deathclaw/taunt.ogg')
	emote_taunt_sound = list('sound/f13npc/deathclaw/aggro1.ogg', 'sound/f13npc/deathclaw/aggro2.ogg', )
	idlesound = list('sound/f13npc/deathclaw/idle.ogg',)
	death_sound = 'sound/f13npc/deathclaw/death.ogg'
	low_health_threshold = 0.5
	ignore_other_mobs = TRUE // peaceful giants that HATE PEOPLE!!!!
	variation_list = list(
		MOB_RETREAT_DISTANCE_LIST(0, 0, 0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(65),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(30),
	)
	despawns_when_lonely = FALSE
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/human)
	loot_drop_amount = 1
	loot_amount_random = TRUE
	am_important = TRUE
	bossmob = TRUE


/mob/living/simple_animal/hostile/deathclaw/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/hostile/deathclaw/playable
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = FALSE

/// Override this with what should happen when going from high health to low health
/mob/living/simple_animal/hostile/deathclaw/make_low_health()
	visible_message(span_danger("[src] lets out a vicious roar!!!"))
	playsound(src, 'sound/f13npc/deathclaw/aggro2.ogg', 100, 1, SOUND_DISTANCE(20))
	color = color_mad
	reach += 1
	speed *= 0.8
	move_to_delay *= 0.5
	obj_damage += 200
	melee_damage_lower *= 1.5
	melee_damage_upper *= 1.4
	see_in_dark += 8
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS | ENVIRONMENT_SMASH_RWALLS //can smash walls
	wound_bonus += 25
	bare_wound_bonus += 50
	sound_pitch = -50
	alternate_attack_prob = 75
	is_low_health = TRUE

/// Override this with what should happen when going from low health to high health
/mob/living/simple_animal/hostile/deathclaw/make_high_health()
	visible_message(span_danger("[src] calms down."))
	color = initial(color)
	reach = initial(reach)
	speed = initial(speed)
	move_to_delay = initial(move_to_delay)
	obj_damage = initial(obj_damage)
	melee_damage_lower = initial(melee_damage_lower)
	melee_damage_upper = initial(melee_damage_upper)
	see_in_dark = initial(see_in_dark)
	environment_smash = initial(environment_smash)
	wound_bonus = initial(wound_bonus)
	bare_wound_bonus = initial(bare_wound_bonus)
	alternate_attack_prob = initial(alternate_attack_prob)
	is_low_health = FALSE

/mob/living/simple_animal/hostile/deathclaw/AlternateAttackingTarget(atom/the_target)
	if(!ismovable(the_target))
		return
	var/atom/movable/throwee = the_target
	if(throwee.anchored)
		return
	var/atom/throw_target = get_ranged_target_turf(throwee, get_dir(src, the_target), rand(2,10), 4)
	throwee.safe_throw_at(throw_target, 10, 1, src, TRUE)
	playsound(get_turf(throwee), 'sound/effects/Flesh_Break_1.ogg')

/mob/living/simple_animal/hostile/deathclaw/Move()
	if(is_low_health && health > 0)
		new /obj/effect/temp_visual/decoy/fading(loc,src)
		DestroySurroundings()
	. = ..()

/mob/living/simple_animal/hostile/deathclaw/Bump(atom/A)
	if((isturf(A) || isobj(A)) && A.density)
		if(health <= 0)
			playsound(get_turf(src), 'sound/effects/Flesh_Break_2.ogg', 100, 1, ignore_walls = TRUE)
			visible_message(span_danger("[src] smashes into \the [A] and explodes in a violent spray of gore![prob(25) ? " Holy shit!" : ""]"))
			gib()
			return
		if(is_low_health && health > 0)
			A.ex_act(EXPLODE_HEAVY)
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			DestroySurroundings()
	..()

// Mother death claw
/mob/living/simple_animal/hostile/deathclaw/mother
	name = "mother deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one is an angry mother."
	gender = FEMALE
	mob_armor = ARMOR_VALUE_DEATHCLAW_MOTHER
	maxHealth = 400 // 500 is double 250, so 100 points less than double
	health = 400
	stat_attack = CONSCIOUS
	melee_damage_lower = 25
	melee_damage_upper = 55
	footstep_type = FOOTSTEP_MOB_HEAVY
	color = rgb(95,104,94)
	color_mad = rgb(113, 105, 100)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 6,
							/obj/item/stack/sheet/animalhide/deathclaw = 3)
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/human)
	loot_drop_amount = 3
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/retaliate/deathclaw
	name = "deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws."
	icon = 'icons/fallout/mobs/monsters/deathclaw.dmi'
	icon_state = "deathclaw"
	icon_living = "deathclaw"
	icon_dead = "deathclaw_dead"
	icon_gib = "deathclaw_gib"
	mob_armor = ARMOR_VALUE_DEATHCLAW_COMMON
	maxHealth = 250
	health = 250
	reach = 2
	speed = 1
	obj_damage = 200
	melee_damage_lower = 30
	melee_damage_upper = 40
	footstep_type = FOOTSTEP_MOB_HEAVY
	move_to_delay = 2.4 //hahahahahahahaaaaa
	gender = MALE
	a_intent = INTENT_HARM //So we can not move past them.
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	sentience_type = SENTIENCE_BOSS 
	robust_searching = TRUE
	speak = list("ROAR!","Rawr!","GRRAAGH!","Growl!")
	speak_emote = list("growls", "roars")
	emote_hear = list("grumbles.","grawls.")
	emote_taunt = list("stares ferociously", "stomps")
	speak_chance = 10
	taunt_chance = 25
	tastes = list("a bad time" = 5, "dirt" = 1)
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS | ENVIRONMENT_SMASH_RWALLS //can smash walls
	var/color_mad = "#ffc5c5"
	see_in_dark = 8
	decompose = FALSE
	wound_bonus = 0 //This might be a TERRIBLE idea
	bare_wound_bonus = 0
	sharpness = SHARP_EDGED
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 4,
							/obj/item/stack/sheet/animalhide/deathclaw = 2,
							/obj/item/stack/sheet/bone = 4)
	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "hits"
	attack_verb_simple = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list("neutral")
	gold_core_spawnable = HOSTILE_SPAWN
	//var/charging = FALSE
	move_resist = MOVE_FORCE_OVERPOWERING
	emote_taunt_sound = list('sound/f13npc/deathclaw/taunt.ogg')
	emote_taunt_sound = list('sound/f13npc/deathclaw/aggro1.ogg', 'sound/f13npc/deathclaw/aggro2.ogg', )
	idlesound = list('sound/f13npc/deathclaw/idle.ogg',)
	death_sound = 'sound/f13npc/deathclaw/death.ogg'
	low_health_threshold = 0.5
	variation_list = list(
		MOB_RETREAT_DISTANCE_LIST(0, 0, 0, 3, 3),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(65),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(30),
	)
	despawns_when_lonely = FALSE

/mob/living/simple_animal/hostile/retaliate/deathclaw/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/hostile/retaliate/deathclaw/playable
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = FALSE

/// Override this with what should happen when going from high health to low health
/mob/living/simple_animal/hostile/retaliate/deathclaw/make_low_health()
	visible_message(span_danger("[src] lets out a vicious roar!!!"))
	playsound(src, 'sound/f13npc/deathclaw/aggro2.ogg', 100, 1, SOUND_DISTANCE(20))
	color = color_mad
	reach += 1
	speed *= 0.8
	obj_damage += 200
	melee_damage_lower *= 1.5
	melee_damage_upper *= 1.4
	see_in_dark += 8
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS | ENVIRONMENT_SMASH_RWALLS //can smash walls
	wound_bonus += 25
	bare_wound_bonus += 50
	sound_pitch = -50
	alternate_attack_prob = 75
	is_low_health = TRUE

/// Override this with what should happen when going from low health to high health
/mob/living/simple_animal/hostile/deathclaw/retaliate/make_high_health()
	visible_message(span_danger("[src] calms down."))
	color = initial(color)
	reach = initial(reach)
	speed = initial(speed)
	obj_damage = initial(obj_damage)
	melee_damage_lower = initial(melee_damage_lower)
	melee_damage_upper = initial(melee_damage_upper)
	see_in_dark = initial(see_in_dark)
	environment_smash = initial(environment_smash)
	wound_bonus = initial(wound_bonus)
	bare_wound_bonus = initial(bare_wound_bonus)
	alternate_attack_prob = initial(alternate_attack_prob)
	is_low_health = FALSE

/mob/living/simple_animal/hostile/deathclaw/retaliate/AlternateAttackingTarget(atom/the_target)
	if(!ismovable(the_target))
		return
	var/atom/movable/throwee = the_target
	if(throwee.anchored)
		return
	var/atom/throw_target = get_ranged_target_turf(throwee, get_dir(src, the_target), rand(2,10), 4)
	throwee.safe_throw_at(throw_target, 10, 1, src, TRUE)
	playsound(get_turf(throwee), 'sound/effects/Flesh_Break_1.ogg')

/mob/living/simple_animal/hostile/retaliate/deathclaw/Move()
	if(is_low_health && health > 0)
		new /obj/effect/temp_visual/decoy/fading(loc,src)
		DestroySurroundings()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/deathclaw/Bump(atom/A)
	if(is_low_health)
		if((isturf(A) || isobj(A)) && A.density)
			A.ex_act(EXPLODE_HEAVY)
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			if(stat || health <= 0)
				playsound(get_turf(src), 'sound/effects/Flesh_Break_2.ogg', 100, 1, ignore_walls = TRUE)
				visible_message(span_danger("[src] smashes into \the [A] and explodes in a violent spray of gore![prob(25) ? " Holy shit!" : ""]"))
				gib()
				return
		DestroySurroundings()
	..()

// Mother death claw - egglaying
/mob/living/simple_animal/hostile/retaliate/deathclaw/mother
	name = "mother deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws. This one is an BIG mother."
	gender = FEMALE
	mob_armor = ARMOR_VALUE_DEATHCLAW_MOTHER
	maxHealth = 400
	health = 400
	stat_attack = CONSCIOUS
	melee_damage_lower = 25
	melee_damage_upper = 55
	footstep_type = FOOTSTEP_MOB_HEAVY
	color = rgb(95,104,94)
	color_mad = rgb(113, 105, 100)
	var/egg_type = /obj/item/reagent_containers/food/snacks/f13/deathclawegg
	var/food_type = /obj/item/reagent_containers/food/snacks/meat/slab
	var/eggsleft = 0
	var/eggsFertile = TRUE
	var/list/feedMessages = list("It rips the meat from your grasp.","It glares at you as it swallows the meat whole.")
	var/list/layMessage = list("The deathclaw leans down, crouching as it lays an enormous egg.","The broodmother squats down, growling lowly as she lays an egg.")
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 6,
							/obj/item/stack/sheet/animalhide/deathclaw = 3)
	var/static/deathclaw_mother_count = 0

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/Initialize()
	. = ..()
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++deathclaw_mother_count

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/Destroy()
	--deathclaw_mother_count
	return ..()

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/attackby(obj/item/O, mob/user, params)
	if(istype(O, food_type)) //feedin' dem claws
		if(!stat && eggsleft < 8)
			var/feedmsg = "[user] feeds [O] to [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			qdel(O)
			eggsleft += rand(1, 4)
		else
			to_chat(user, span_warning("[name] doesn't seem hungry!"))
	else
		..()

/mob/living/simple_animal/hostile/retaliate/deathclaw/mother/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if((!stat && prob(3) && eggsleft > 0) && egg_type)
		visible_message(span_alertalien("[src] [pick(layMessage)]"))
		eggsleft--
		var/obj/item/E = new egg_type(get_turf(src))
		E.pixel_x = rand(-6,6)
		E.pixel_y = rand(-6,6)
		if(eggsFertile)
			if(deathclaw_mother_count < MAX_MOTHERCLAWS && prob(25))
				START_PROCESSING(SSobj, E)

/obj/item/reagent_containers/food/snacks/f13/deathclawegg/var/amount_grown = 0
/obj/item/reagent_containers/food/snacks/f13/deathclawegg/process()
	if(isturf(loc))
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			visible_message("[src] hatches with a quiet cracking sound, swelling to full size.")
			new /mob/living/simple_animal/hostile/retaliate/deathclaw/mother(get_turf(src))
			STOP_PROCESSING(SSobj, src)
			qdel(src)
	else
		STOP_PROCESSING(SSobj, src)

/mob/living/simple_animal/hostile/deathclaw/butter
	name = "butterclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one is...made out of butter?"
	icon_state = "deathclaw_butter"
	icon_living = "deathclaw_butter"
	icon_dead = "deathclaw_butter_dead"
	color_mad = rgb(133, 98, 87)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/butter = 10,
							/obj/item/stack/sheet/animalhide/deathclaw = 3)

//Legendary Deathclaw
/mob/living/simple_animal/hostile/deathclaw/legendary
	name = "legendary deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one is a legendary enemy."
	mob_armor = ARMOR_VALUE_DEATHCLAW_MOTHER
	maxHealth = 600 // Double regular one with some change.
	health = 600
	color = "#FFFF00"
	color_mad = rgb(133, 98, 87)
	stat_attack = CONSCIOUS
	melee_damage_lower = 25
	melee_damage_upper = 55
	footstep_type = FOOTSTEP_MOB_HEAVY
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/human)
	loot_drop_amount = 5
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/deathclaw/legendary/death(gibbed)
	var/turf/T = get_turf(src)
	if(prob(60))
		new /obj/item/melee/unarmed/deathclawgauntlet(T)
	. = ..()

//Power Armor Deathclaw the tankest and the scariest deathclaw in the West. One mistake will end you. May the choice be with you.
/mob/living/simple_animal/hostile/deathclaw/power_armor
	name = "power armored deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. Someone had managed to put power armor on him."
	icon_state = "combatclaw"
	icon_living = "combatclaw"
	icon_dead = "combatclaw_dead"
	mob_armor = ARMOR_VALUE_DEATHCLAW_PA // ha get fucked
	maxHealth = 1000 // ha get turbofucked
	health = 1000
	stat_attack = CONSCIOUS
	melee_damage_lower = 40
	melee_damage_upper = 60
	footstep_type = FOOTSTEP_MOB_HEAVY
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/human)
	loot_drop_amount = 10
	loot_amount_random = TRUE


/// Code for deathclaw charging. It barely works
/* /mob/living/simple_animal/hostile/deathclaw/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		return
	if(!charging)
		visible_message(span_danger("\The [src] growls, enraged!"))
		addtimer(CALLBACK(src,PROC_REF(Charge)), 3)
	. = ..() // I swear I looked at this like 10 times before, never once noticed this wasnt here, fmdakm

/mob/living/simple_animal/hostile/deathclaw/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!charging)
		..()

/mob/living/simple_animal/hostile/deathclaw/AttackingTarget()
	if(!charging)
		return ..()

/mob/living/simple_animal/hostile/deathclaw/Goto(target, delay, minimum_distance)
	if(!charging)
		..()

/mob/living/simple_animal/hostile/deathclaw/proc/Charge()
	var/turf/T = get_turf(target)
	if(!T || T == loc)
		return
	charging = TRUE
	visible_message(span_danger(">[src] charges!"))
	DestroySurroundings()
	walk(src, 0)
	setDir(get_dir(src, T))
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#FF0000", transform = matrix()*2, time = 1)
	throw_at(T, get_dist(src, T), 1, src, 0, callback = CALLBACK(src,PROC_REF(charge_end)))

/mob/living/simple_animal/hostile/deathclaw/proc/charge_end(list/effects_to_destroy)
	charging = FALSE
	if(target)
		Goto(target, move_to_delay, minimum_distance)

/mob/living/simple_animal/hostile/deathclaw/Bump(atom/A)
	if(charging)
		if(isturf(A) || isobj(A) && A.density)
			A.ex_act(EXPLODE_HEAVY)
		DestroySurroundings()
	..()

/mob/living/simple_animal/hostile/deathclaw/throw_impact(atom/A)
	if(!charging)
		return ..()

	else if(isliving(A))
		var/mob/living/L = A
		L.visible_message(span_danger("[src] slams into [L]!"), span_userdanger("[src] slams into you!"))
		L.apply_damage(melee_damage_lower/2, BRUTE)
		playsound(get_turf(L), 'sound/effects/meteorimpact.ogg', 100, 1)
		shake_camera(L, 4, 3)
		shake_camera(src, 2, 3)
		var/throwtarget = get_edge_target_turf(src, get_dir(src, get_step_away(L, src)))
		L.throw_at(throwtarget, 3)


	charging = FALSE
	charging = FALSE
 */

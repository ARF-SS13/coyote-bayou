//Fallout 13 super mutants directory

/mob/living/simple_animal/hostile/supermutant
	bounty = 25
	name = "super mutant"
	desc = "A gigantic, green, angry-looking humanoid wrapped in a jumpsuit that may have fit him... her? at some point. \
		They're a mountain of furry muscle, and their fists look like they could punch through solid steel. Have fun!"
	icon = 'icons/fallout/mobs/supermutant.dmi'
	icon_state = "hulk_113_s"
	icon_living = "hulk_113_s"
	icon_dead = "hulk_113_s"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_armor = ARMOR_VALUE_SUPERMUTANT_BASE
	maxHealth = 130 
	health = 130
	speak_chance = 10
	//speak = list(
		// "GRRRRRR!",
		// "ARGH!",
		// "NNNNNGH!",
		// "HMPH!",
		// "ARRRRR!"
		// )
	speak_emote = list(
		"shouts",
		"yells"
		)
	move_to_delay = 5
	robust_searching = 1
	environment_smash = ENVIRONMENT_SMASH_WALLS
	emote_taunt_sound = list(
		'sound/f13npc/supermutant/attack1.ogg',
		'sound/f13npc/supermutant/attack2.ogg',
		'sound/f13npc/supermutant/attack3.ogg'
		)
	emote_taunt = list("yells")
	taunt_chance = 30
	turns_per_move = 5
	response_help_simple = "touches"
	response_disarm_simple = "pushes"
	response_harm_simple = "hits"
	faction = list(
		"hostile",
		"supermutant"
		)
	melee_damage_lower = 20
	melee_damage_upper = 35
	aggro_vision_range = 7
	//tiles within they start attacking, doesn't count the mobs tile
	vision_range = 8
	//tiles within they start making noise, does count the mobs tile
	mob_size = MOB_SIZE_LARGE
	move_resist = MOVE_FORCE_OVERPOWERING
	attack_verb_simple = "smashes"
	attack_sound = "punch"
	a_intent = INTENT_GRAB
	idlesound = list(
		'sound/f13npc/supermutant/idle1.ogg',
		'sound/f13npc/supermutant/idle2.ogg',
		'sound/f13npc/supermutant/idle3.ogg',
		'sound/f13npc/supermutant/idle4.ogg'
		)
	/*death_sound = list(
		'sound/f13npc/supermutant/death1.ogg',
		'sound/f13npc/supermutant/death2.ogg'
		)*/
	emote_taunt_sound = list(
		'sound/f13npc/supermutant/alert1.ogg',
		'sound/f13npc/supermutant/alert2.ogg',
		'sound/f13npc/supermutant/alert3.ogg',
		'sound/f13npc/supermutant/alert4.ogg'
		)
	wound_bonus = 0
	bare_wound_bonus = 0
	footstep_type = FOOTSTEP_MOB_HEAVY
	ignore_other_mobs = TRUE // gentle giants that respect the inhabitants of the wastes. Cept for players
	retreat_health_percent = 0.5
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 10
	loot = list(/obj/effect/gibspawner/generic/animal)
	loot_drop_amount = 2
	loot_amount_random = TRUE


/mob/living/simple_animal/hostile/supermutant/playable
	mob_armor = ARMOR_VALUE_SUPERMUTANT_BASE
	maxHealth = 130
	health = 130
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	dextrous = TRUE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)

/mob/living/simple_animal/hostile/supermutant/Aggro()
	..()
	summon_backup(15)

/mob/living/simple_animal/hostile/supermutant/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	..()

/mob/living/simple_animal/pet/dog/mutant    //This is a supermutant, totally not a dog, and he is friendly
	name = "Brah-Min"
	desc = "A large, docile supermutant. Adopted by Kebab-town as a sort of watch dog for their brahmin herd."
	icon = 'icons/fallout/mobs/supermutant.dmi'
	icon_state = "mutant_engineer"
	icon_dead = "mutant_engineer"
	maxHealth = 240
	health = 240
	speak_chance = 7 //30 //Oh my god he never shuts up.
	move_resist = MOVE_FORCE_OVERPOWERING
	mob_size = MOB_SIZE_LARGE
	//speak = list("Hey! These my brahmins!", "And I say, HEY-YEY-AAEYAAA-EYAEYAA! HEY-YEY-AAEYAAA-EYAEYAA! I SAID HEY, what's going on?", "What do you want from my brahmins?!", "Me gonna clean brahmin poop again now!", "I love brahmins, brahmins are good, just poop much!", "Do not speak to my brahmins ever again, you hear?!", "Bad raiders come to steal my brahmins - I crush with wrench!", "Do not come to my brahmins! Do not touch my brahmins! Do not look at my brahmins!", "I'm watching you, and my brahmins watch too!", "Brahmins say moo, and I'm saying - hey, get your ugly face out of my way!", "I... I remember, before the fire... THERE WERE NO BRAHMINS!", "No! No wind brahmin here! Wind brahmin lie!")
	speak_emote = list("shouts", "yells")
	emote_hear = list("yawns", "mumbles","sighs")
	// emote_see = list("raises his wrench", "shovels some dirt away", "waves his wrench above his head angrily")
	response_help_simple = "touches"
	response_disarm_simple = "pushes"
	response_harm_simple = "punches"
//	guaranteed_butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/bearsteak = 3)

/mob/living/simple_animal/pet/dog/mutant/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	if(!gibbed)
		visible_message(span_danger("\the [src] shouts something incoherent about brahmins for the last time and stops moving..."))
	..()

/mob/living/simple_animal/hostile/supermutant/meleemutant
	bounty = 20
	name = "sledgehammer supermutant"
	desc = "An enormous, green tank of a humanoid wrapped in thick sheets of metal and boiled leather from hopefully a brahmin or two. \
		They're a mountain of furry muscle, and their fists look like they could punch through solid steel. \
		If that wasn't bad enough, this monstrous critter is wielding a sledgehammer. Lovely."
	icon = 'icons/fallout/mobs/supermutant.dmi'
	icon_state = "hulk_melee_s"
	icon_living = "hulk_melee_s"
	icon_dead = "hulk_melee_s"
	mob_armor = ARMOR_VALUE_SUPERMUTANT_MELEE
	maxHealth = 130 
	health = 130
	mob_armor_tokens = list(
		ARMOR_MODIFIER_UP_MELEE_T1,
		ARMOR_MODIFIER_DOWN_LASER_T2,
		ARMOR_MODIFIER_UP_DT_T2
		)
	melee_damage_lower = 18
	melee_damage_upper = 44
	attack_sound = "hit_swing"
	footstep_type = FOOTSTEP_MOB_HEAVY

/mob/living/simple_animal/hostile/supermutant/meleemutant/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	..()

/mob/living/simple_animal/hostile/supermutant/rangedmutant
	bounty = 30
	desc = "An enormous green mass of a humanoid wrapped in thick sheets of metal and boiled leather from hopefully a brahmin or two. \
		They're a mountain of furry muscle, and their fists look like they could punch through solid steel. \
		If that wasn't bad enough, this monstrous critter is wielding a crude shotgun. Lovely."
	icon = 'icons/fallout/mobs/supermutant.dmi'
	icon_state = "hulk_ranged_s"
	icon_living = "hulk_ranged_s"
	icon_dead = "hulk_ranged_s"
	color = "#3344BE"
	ranged = 1
	mob_armor = ARMOR_VALUE_SUPERMUTANT_RANGER
	maxHealth = 130 
	health = 130
	retreat_distance = 3
	minimum_distance = 2
	casingtype = /obj/item/ammo_casing/shotgun/improvised/simplemob
	projectiletype = null
	projectilesound = 'sound/f13weapons/shotgun.ogg'
	sound_after_shooting = 'sound/weapons/shotguninsert.ogg'
	sound_after_shooting_delay = 1 SECONDS
	extra_projectiles = 1
	auto_fire_delay = GUN_BURSTFIRE_DELAY_FAST
	ranged_cooldown_time = 4 SECONDS
	loot = list(
		/obj/item/ammo_box/shotgun/improvised,
		/obj/item/gun/ballistic/revolver/widowmaker,
		/obj/effect/gibspawner/generic/animal
		)
	footstep_type = FOOTSTEP_MOB_HEAVY
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)

/mob/living/simple_animal/hostile/supermutant/rangedmutant/varmint
	bounty = 30
	desc = "An enormous green mass of a humanoid wrapped in thick sheets of metal and boiled leather from hopefully a brahmin or two. \
		They're a mountain of furry muscle, and their fists look like they could punch through solid steel. \
		If that wasn't bad enough, this monstrous critter is wielding some kind of rifle. Lovely."
	casingtype = null
	projectiletype = /obj/item/projectile/bullet/a556/simple
	projectilesound = 'sound/f13weapons/assaultrifle_fire.ogg'
	sound_after_shooting = null
	sound_after_shooting_delay = 1 SECONDS
	extra_projectiles = 0
	retreat_distance = 3
	minimum_distance = 3
	ranged_cooldown_time = 2 SECONDS
	loot = list(
		/obj/item/gun/ballistic/automatic/varmint,
		/obj/effect/gibspawner/generic/animal
		)

/mob/living/simple_animal/hostile/supermutant/rangedmutant/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	..()

/mob/living/simple_animal/hostile/supermutant/legendary
	bounty = 50
	name = "legendary super mutant"
	desc = "A huge and ugly mutant humanoid.He has a faint yellow glow to him, scars adorn his body. This super mutant is a grizzled vetern of combat. Look out!"
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_SUPERMUTANT_LEGEND
	maxHealth = 150 
	health = 150
	icon_state = "hulk_113_s"
	icon_living = "hulk_113_s"
	icon_dead = "hulk_113_s"
	melee_damage_lower = 27
	melee_damage_upper = 57
	mob_size = 5
	footstep_type = FOOTSTEP_MOB_HEAVY

/mob/living/simple_animal/hostile/supermutant/legendary/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	..()

/mob/living/simple_animal/hostile/supermutant/nightkin
	bounty = 50
	name = "nightkin"
	desc = "A blue variant of the standard Super Mutant, equiped with steathboys."
	icon = 'icons/fallout/mobs/supermutant.dmi'
	icon_state = "night_s"
	icon_living = "night_s"
	icon_dead = "night_s"
	mob_armor = ARMOR_VALUE_SUPERMUTANT_MELEE
	maxHealth = 140 
	health = 140
	alpha = 80
	force_threshold = 15
	melee_damage_lower = 27
	melee_damage_upper = 50
	attack_verb_simple = "slashes"
	attack_sound = "sound/weapons/bladeslice.ogg"
	footstep_type = FOOTSTEP_MOB_HEAVY
	loot = list(/obj/effect/gibspawner/generic/animal)
	loot_drop_amount = 2
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/supermutant/nightkin/Aggro()
	..()
	summon_backup(15)
	alpha = 255

/mob/living/simple_animal/hostile/supermutant/nightkin/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	..()

/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant
	bounty = 60
	name = "nightkin veteran"
	desc = "A blue variant of the standard Super Mutant, equiped with steathboys.  This one is holding an Assault Rifle."
	icon = 'icons/fallout/mobs/supermutant.dmi'
	icon_state = "night_ranged_s"
	icon_living = "night_ranged_s"
	icon_dead = "night_ranged_s"
	mob_armor = ARMOR_VALUE_SUPERMUTANT_RANGER
	maxHealth = 140 
	health = 140
	ranged = 1
	alpha = 80
	force_threshold = 15
	melee_damage_lower = 25
	melee_damage_upper = 37
	attack_verb_simple = "smashes"
	attack_sound = "punch"
	extra_projectiles = 1
	retreat_distance = 4
	minimum_distance = 6
	projectiletype = /obj/item/projectile/bullet/a556/simple
	projectilesound = 'sound/f13weapons/assaultrifle_fire.ogg'
	loot = list(/obj/effect/gibspawner/generic/animal)
	footstep_type = FOOTSTEP_MOB_HEAVY
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(RIFLE_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(RIFLE_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_LIGHT_RANGE_DISTANT)
	)

/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant/Aggro()
	..()
	summon_backup(15)
	alpha = 255

/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	..()

/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant
	bounty = 50
	name = "nightkin elite"
	desc = "A blue variant of the standard Super Mutant, and a remnant of the Masters Army."
	icon = 'icons/fallout/mobs/supermutant.dmi'
	icon_state = "night_boss_s"
	icon_living = "night_boss_s"
	icon_dead = "night_boss_s"
	ranged = 1
	mob_armor = ARMOR_VALUE_SUPERMUTANT_LEGEND
	maxHealth = 130 
	health = 130
	alpha = 80
	force_threshold = 15
	melee_damage_lower = 20
	melee_damage_upper = 47
	attack_verb_simple = "smashes"
	attack_sound = "punch"
	retreat_distance = 5
	minimum_distance = 7
	projectiletype = /obj/item/projectile/f13plasma/repeater
	projectilesound = 'sound/f13weapons/plasma_rifle.ogg'
	loot = list(/obj/effect/gibspawner/generic/animal)
	footstep_type = FOOTSTEP_MOB_HEAVY
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PLASMA_VOLUME),
		SP_VOLUME_SILENCED(PLASMA_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PLASMA_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PLASMA_DISTANT_SOUND),
		SP_DISTANT_RANGE(PLASMA_RANGE_DISTANT)
	)

/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant/Aggro()
	..()
	summon_backup(15)
	alpha = 255

/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant/death(gibbed)
	icon = 'icons/fallout/mobs/supermutant_dead.dmi'
	icon_state = icon_dead
	anchored = FALSE
	..()

//Cult Of Rain
/mob/living/simple_animal/hostile/supermutant/meleemutant/rain
	name = "super mutant rain cultist"
	desc = "A super mutant covered in blue markings that has been indoctrinated into the Cult Of Rain. This one wields a sledgehammer blessed by the rain gods."
	color = "#6B87C0"
	speak_chance = 10
	//speak = list("The rain cleanses!", "Sacrifices for the rain gods!", "The thunder guides my fury!", "I am become the storm, destroyer of all heretics!", "The priests will be pleased with my sacrifices!")
	maxHealth = 360
	health = 360
	damage_coeff = list(BRUTE = 0.5, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	melee_damage_lower = 24
	melee_damage_upper = 48
	footstep_type = FOOTSTEP_MOB_HEAVY
	
/mob/living/simple_animal/hostile/supermutant/rangedmutant/rain
	name = "super mutant rain cultist"
	desc = "A super mutant covered in blue markings that has been indoctrinated into the Cult Of Rain. This one wields a hunting rifle blessed by the rain gods."
	color = "#6B87C0"
	speak_chance = 10
	//speak = list("The rain cleanses!", "Sacrifices for the rain gods!", "The thunder guides my fury!", "I am become the storm, destroyer of all heretics!", "The priests will be pleased with my sacrifices!")
	maxHealth = 360
	health = 360
	damage_coeff = list(BRUTE = 1, BURN = 0.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	melee_damage_lower = 24
	melee_damage_upper = 48
	footstep_type = FOOTSTEP_MOB_HEAVY

/mob/living/simple_animal/hostile/supermutant/nightkin/rain
	name = "nightkin berserker rain priest"
	desc = "A nightkin that spreads the word of the Cult Of Rain. They are covered in dark blue markings, indicating that they have been blessed by the rain god Odile."
	color = "#6666FF"
	speak_chance = 10
	//speak = list("The rain speaks through me!", "Witness the gifts of rain!", "The great flood will come upon us! Do not fear it!", "My life for the rain gods!", "The rain gods can always use more sacrifices!")
	maxHealth = 360
	health = 360
	damage_coeff = list(BRUTE = -0.1, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	melee_damage_lower = 24
	melee_damage_upper = 48
	var/charging = FALSE
	footstep_type = FOOTSTEP_MOB_HEAVY

// /mob/living/simple_animal/hostile/supermutant/nightkin/rain/bullet_act(obj/item/projectile/Proj)
// 	if(!Proj)
// 		return
// 	if(prob(30))
// 		visible_message(span_danger("\The [src] lets out a vicious war cry!"))
// 		Charge()
// 	if(prob(85) || Proj.damage > 30)
// 		return ..()
// 	else
// 		visible_message(span_danger("\The [Proj] is abosrbed by \the [src]'s thick skin, strengthening it!"))
// 		return 0

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!charging)
		..()

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/AttackingTarget()
	if(!charging)
		return ..()

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/Goto(target, delay, minimum_distance)
	if(!charging)
		..()

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/Move()
	if(charging)
		new /obj/effect/temp_visual/decoy/fading(loc,src)
		DestroySurroundings()
	. = ..()
	if(charging)
		DestroySurroundings()

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/proc/Charge()
	var/turf/T = get_turf(get_target())
	if(!T || T == loc)
		return
	charging = TRUE
	visible_message(span_danger("[src] charges!"))
	DestroySurroundings()
	walk(src, 0)
	setDir(get_dir(src, T))
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#FF0000", transform = matrix()*2, time = 1)
	throw_at(T, get_dist(src, T), 1, src, 0, callback = CALLBACK(src,PROC_REF(charge_end)))

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/proc/charge_end(list/effects_to_destroy)
	charging = FALSE
	var/atom/my_target = get_target()
	if(!my_target)
		return
	Goto(my_target, move_to_delay, minimum_distance)

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/Bump(atom/A)
	if(charging)
		if(isturf(A) || isobj(A) && A.density)
			A.ex_act(EXPLODE_HEAVY)
		DestroySurroundings()
	..()

/mob/living/simple_animal/hostile/supermutant/nightkin/rain/throw_impact(atom/A)
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


/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant/rain
	name = "nightkin guardian rain priest"
	desc = "A nightkin that spreads the word of the Cult Of Rain. They are covered in dark blue markings, indicating that they have been blessed by the rain lord Ignacio."
	color = "#6666FF"
	speak_chance = 10
	//speak = list("The rain speaks through me!", "Witness the gifts of rain!", "The great flood will come upon us! Do not fear it!", "My life for the rain gods!", "The rain gods can always use more sacrifices!")
	maxHealth = 380
	health = 380
	damage_coeff = list(BRUTE = 1, BURN = -0.25, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	melee_damage_lower = 35
	melee_damage_upper = 60
	extra_projectiles = 2
	retreat_distance = 2
	minimum_distance = 4

/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant/rain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/supermutant, allow_revival = FALSE, restrict_faction = null, type_healing = BRUTELOSS | FIRELOSS)

// /mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant/rain/bullet_act(obj/item/projectile/Proj)
// 	if(!Proj)
// 		return
// 	if(prob(20))
// 		visible_message(span_danger("\The [src] lets out a vicious war cry!"))
// 		fire_release()
// 	if(prob(85) || Proj.damage > 30)
// 		return ..()
// 	else
// 		visible_message(span_danger("\The [Proj] is absorbed by \the [src]'s thick skin, strengthening it!"))
// 		return 0

/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant/rain/proc/fire_release()
	playsound(get_turf(src),'sound/magic/fireball.ogg', 200, 1)
	INVOKE_ASYNC(src,PROC_REF(fire_release_wall))

/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant/rain/proc/fire_release_wall(dir)
	for(var/mob/living/target in view(10, src))
		var/obj/item/ammo_casing/casing = new /obj/item/ammo_casing/shotgun/incendiary(get_turf(src))
		casing.factionize(faction)
		casing.fire_casing(target, src, null, null, null, ran_zone(), 0, null, null, null, src)
		qdel(casing)

/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant/rain
	name = "nightkin rain lord"
	desc = "A nightkin that writes the word of the Cult Of Rain. They are covered in dark blue markings and are adorned in pieces of bone armor, indicating that they are blessed by the rain lord Hyacinth."
	color = "#6666FF"
	speak_chance = 10
	//speak = list("The great flood will come, I will make sure of it!", "Rain lord Odile, I call upon you for wrath!", "Rain creator Hyacinth, I call upon you for a tranquil mind!", "Rain lord Ignacio, I call upon you for protection!", "The storm rages within!")
	maxHealth = 440
	health = 440
	damage_coeff = list(BRUTE = 0.5, BURN = 0.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	melee_damage_lower = 28
	melee_damage_upper = 62
	extra_projectiles = 1

/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant/rain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/supermutant, allow_revival = TRUE, restrict_faction = null, type_healing = BRUTELOSS | FIRELOSS)

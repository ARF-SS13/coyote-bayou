// In this document: Freaks, the centaur, abomination and horror.

// -------------------------------------
// CENTAUR

/mob/living/simple_animal/hostile/centaur
	name = "centaur"
	desc = "The result of infection by FEV gone horribly wrong."
	icon = 'icons/fallout/mobs/monsters/freaks.dmi'
	icon_state = "centaur"
	icon_living = "centaur"
	icon_dead = "centaur_dead"
	icon_gib = "centaur_g"
	tastes = list("sadness" = 1, "nastyness" = 1)
	can_ghost_into = TRUE
	maxHealth = 80
	health = 80
	speed = 2
	harm_intent_damage = 8
	melee_damage_lower = 4 // damage range is punch min, average is 15 when in melee
	melee_damage_upper = 20
	ranged = TRUE
	wound_bonus = 0
	footstep_type = FOOTSTEP_MOB_CRAWL
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon)
	loot_drop_amount = 2
	loot_amount_random = TRUE

	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = TRUE
	move_to_delay = 6 //slower than average, but not a lot.  //Needs to be slower than a protectron
	// m2d 4 = standard, less is fast, more is slower.

	retreat_distance = 0 // Mob doesn't retreat
	//how far they pull back

	minimum_distance = 0 //Mob pushes up to melee, leading with its ranged attacks to soften up player.
	// how close you can get before they try to pull back

	aggro_vision_range = 7 //Will start attacking within player sight, but gives wiggle room to avoid if moving slow and carefully
	//tiles within they start attacking

	vision_range = 7 //will start attacking within player sight, but like aggro gives wiggle room.  So they just don't see players outside of 7 tiles and start screeching.
	//tiles within they start making noise
	turns_per_move = 5
	speak_emote = list("growls")
	//emote_see = list("screeches", "screams", "howls", "bellows", "flails", "fidgets", "festers")
	a_intent = INTENT_HARM
	attack_verb_simple = list("whipped", "whacked", "whomped", "wailed on", "smacked", "smashed", "bapped")
	unsuitable_atmos_damage = 20
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list("hostile", "supermutant")
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/centaur = 3,
							/obj/item/stack/sheet/animalhide/human = 2,
							/obj/item/stack/sheet/bone = 2)
	projectiletype = /obj/item/projectile/neurotox
	projectilesound = 'sound/f13npc/centaur/spit.ogg'
	emote_taunt_sound = list('sound/f13npc/centaur/taunt.ogg')
	emote_taunt = list("grunts", "gurgles", "wheezes", "flops", "scrabbles")
	taunt_chance = 30
	emote_taunt_sound = list('sound/f13npc/centaur/aggro1.ogg', )
	idlesound = list('sound/f13npc/centaur/idle1.ogg', 'sound/f13npc/centaur/idle2.ogg')
	death_sound = 'sound/f13npc/centaur/centaur_death.ogg'
	attack_sound = 'sound/f13npc/centaur/lash.ogg'

/obj/item/projectile/neurotox
	name = "spitball"
	damage = 25
	icon_state = "toxin"

/mob/living/simple_animal/hostile/centaur/strong // Mostly for FEV mutation
	maxHealth = 400
	health = 400
	melee_damage_lower = 35
	melee_damage_upper = 35


/mob/living/simple_animal/hostile/centaur/lazy_larry
	name = "Lazy Larry (and his dog Jeffery)"
	desc = "That's Larry.  He's aight."
	faction = list("hostile","supermutant","neutral")
	despawns_when_lonely = FALSE
	environment_smash = NONE

/mob/living/simple_animal/hostile/centaur/lazy_larry/Initialize()
	. = ..()
	buckle_up()

// -----------------------------------
// ABOMINATION

/mob/living/simple_animal/hostile/abomination
	name = "abomination"
	desc = "A horrible fusion of man, animal, and something entirely different. It quakes and shudders, looking to be in an immense amount of pain. Blood and other fluids ooze from various gashes and lacerations on its body, punctuated by mouths that gnash and scream."
	icon = 'icons/fallout/mobs/monsters/freaks.dmi'
	icon_state = "abomination"
	icon_living = "abomination"
	icon_dead = "abomination_dead"

	maxHealth = 1000
	health = 1000
	speed = -0.5
	harm_intent_damage = 8
	melee_damage_lower = 30
	melee_damage_upper = 40

	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	environment_smash = ENVIRONMENT_SMASH_RWALLS
	robust_searching = TRUE
	attack_verb_simple = "eviscerates"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	speak_emote = list("screams", "clicks", "chitters", "barks", "moans", "growls", "meows", "reverberates", "roars", "squeaks", "rattles", "exclaims", "yells", "remarks", "mumbles", "jabbers", "stutters", "seethes")
	var/static/list/abom_sounds
	deathmessage = "wails as its form shudders and violently comes to a stop."
	death_sound = 'sound/voice/abomburning.ogg'
	despawns_when_lonely = FALSE // too ANGRY to despawn
/*
/mob/living/simple_animal/hostile/abomination/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		var/choice = pick(1, 1, 2, 2, 3, 4)
		H.reagents.add_reagent(/datum/reagent/toxin/FEV_solution, choice)
*/
/mob/living/simple_animal/hostile/abomination/Initialize()
	. = ..()
	abom_sounds = list(
		'sound/voice/abomination1.ogg',
		'sound/voice/abomscream.ogg',
		'sound/voice/abommoan.ogg',
		'sound/voice/abomscream2.ogg',
		'sound/voice/abomscream3.ogg'
	)

/mob/living/simple_animal/hostile/abomination/say(message, datum/language/language = null, list/spans = list(), language, sanitize, ignore_spam, forced = null, only_overhead)
	..()
	if(stat)
		return
	var/chosen_sound = pick(abom_sounds)
	playsound(src, chosen_sound, 25, TRUE)

/mob/living/simple_animal/hostile/abomination/Life()
	..()
	if(stat)
		return
	if(prob(10))
		var/chosen_sound = pick(abom_sounds)
		playsound(src, chosen_sound, 70, TRUE)

/mob/living/simple_animal/hostile/abomination/weak // For FEV mutation.
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES // So you don't break walls
	maxHealth = 500
	health = 500
	harm_intent_damage = 8
	melee_damage_lower = 20
	melee_damage_upper = 30
	speed = 2


// ------------------------------------------
// HORROR

/mob/living/simple_animal/hostile/abomhorror
	name = "failed experiment"
	desc = "A terrible fusion of man, animal, and something else entirely. It looks to be in great pain."
	speak_emote = list("screams", "clicks", "chitters", "barks", "moans", "growls", "meows", "reverberates", "roars", "squeaks", "rattles", "exclaims", "yells", "remarks", "mumbles", "jabbers", "stutters", "seethes")
	icon = 'icons/fallout/mobs/monsters/freaks.dmi'
	icon_state = "horror"
	icon_living = "horror"
	icon_dead = "horror_dead"

	speed = -0.5
	maxHealth = 700
	health = 700
	harm_intent_damage = 8
	melee_damage_lower = 30
	melee_damage_upper = 40

	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = TRUE
	attack_verb_simple = "eviscerates"
	attack_sound = 'sound/weapons/punch1.ogg'
	var/static/list/abom_sounds
	deathmessage = "wails as its form shudders and violently comes to a stop."

// NSB variant, some sort of bulletsponge
/mob/living/simple_animal/hostile/abomhorror/nsb
	maxHealth = 1000
	health = 1000
	desc = "A terrible fusion of man, animal, and something else entirely. It looks to be in great pain, constantly shuddering violently and seeming relatively docile to the robots and raiders of the bunker. Huh."
	harm_intent_damage = 8
	melee_damage_lower = 40
	melee_damage_upper = 50
	obj_damage = 300
	faction = list("raider")
	wound_bonus = 20
	speed = -1
	deathmessage = "wails as its form shudders and violently comes to a stop."

/mob/living/simple_animal/hostile/abomhorror/nsb/Initialize()
	. = ..()
	abom_sounds = list('sound/voice/abomination1.ogg', 'sound/voice/abomscream.ogg', 'sound/voice/abommoan.ogg', 'sound/voice/abomscream2.ogg', 'sound/voice/abomscream3.ogg')

/mob/living/simple_animal/hostile/abomhorror/nsb/say(message, datum/language/language = null, list/spans = list(), language, sanitize, ignore_spam, forced = null, only_overhead)
	..()
	if(stat)
		return
	var/chosen_sound = pick(abom_sounds)
	playsound(src, chosen_sound, 50, TRUE)

/mob/living/simple_animal/hostile/abomhorror/nsb/Life()
	..()
	if(stat)
		return
	if(prob(10))
		var/chosen_sound = pick(abom_sounds)
		playsound(src, chosen_sound, 70, TRUE)

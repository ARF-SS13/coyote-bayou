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

	maxHealth = 100
	health = 100
	speed = 2
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	ranged = TRUE
	wound_bonus = 0
	retreat_distance = 5
	minimum_distance = 5
	footstep_type = FOOTSTEP_MOB_CRAWL

	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = TRUE
	turns_per_move = 5
	speak_emote = list("growls")
	emote_see = list("screeches")
	a_intent = INTENT_HARM
	attack_verb_simple = "whipped"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 20
	stat_attack = UNCONSCIOUS
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list("hostile", "supermutant")
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/centaur = 3,
							/obj/item/stack/sheet/animalhide/human = 2,
							/obj/item/stack/sheet/bone = 2)
	projectiletype = /obj/item/projectile/neurotox
	projectilesound = 'sound/f13npc/centaur/spit.ogg'
	emote_taunt_sound = list('sound/f13npc/centaur/taunt.ogg')
	emote_taunt = list("grunts")
	taunt_chance = 30
	aggrosound = list('sound/f13npc/centaur/aggro1.ogg', )
	idlesound = list('sound/f13npc/centaur/idle1.ogg', 'sound/f13npc/centaur/idle2.ogg')
	death_sound = 'sound/f13npc/centaur/centaur_death.ogg'
	attack_sound = 'sound/f13npc/centaur/lash.ogg'

/obj/item/projectile/neurotox
	name = "spit"
	damage = 30
	icon_state = "toxin"

/mob/living/simple_animal/hostile/centaur/strong // Mostly for FEV mutation
	maxHealth = 400
	health = 400
	melee_damage_lower = 35
	melee_damage_upper = 35
	armour_penetration = 0.1


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
	melee_damage_lower = 75
	melee_damage_upper = 75
	armour_penetration = 0.1

	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	environment_smash = ENVIRONMENT_SMASH_RWALLS
	robust_searching = TRUE
	attack_verb_simple = "eviscerates"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	speak_emote = list("screams", "clicks", "chitters", "barks", "moans", "growls", "meows", "reverberates", "roars", "squeaks", "rattles", "exclaims", "yells", "remarks", "mumbles", "jabbers", "stutters", "seethes")
	var/static/list/abom_sounds
	deathmessage = "wails as its form shudders and violently comes to a stop."
	death_sound = 'sound/voice/abomburning.ogg'

/mob/living/simple_animal/hostile/abomination/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		var/choice = pick(1, 1, 2, 2, 3, 4)
		H.reagents.add_reagent(/datum/reagent/toxin/FEV_solution, choice)

/mob/living/simple_animal/hostile/abomination/Initialize()
	. = ..()
	abom_sounds = list('sound/voice/abomination1.ogg', 'sound/voice/abomscream.ogg', 'sound/voice/abommoan.ogg', 'sound/voice/abomscream2.ogg', 'sound/voice/abomscream3.ogg')

/mob/living/simple_animal/hostile/abomination/say(message, datum/language/language = null, list/spans = list(), language, sanitize, ignore_spam, forced = null)
	..()
	if(stat)
		return
	var/chosen_sound = pick(abom_sounds)
	playsound(src, chosen_sound, 50, TRUE)

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
	melee_damage_lower = 45
	melee_damage_upper = 45
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
	melee_damage_lower = 50
	melee_damage_upper = 50

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
	melee_damage_lower = 60
	melee_damage_upper = 70
	obj_damage = 300
	faction = list("raider")
	wound_bonus = 20
	speed = -1
	deathmessage = "wails as its form shudders and violently comes to a stop."

/mob/living/simple_animal/hostile/abomhorror/nsb/Initialize()
	. = ..()
	abom_sounds = list('sound/voice/abomination1.ogg', 'sound/voice/abomscream.ogg', 'sound/voice/abommoan.ogg', 'sound/voice/abomscream2.ogg', 'sound/voice/abomscream3.ogg')

/mob/living/simple_animal/hostile/abomhorror/nsb/say(message, datum/language/language = null, list/spans = list(), language, sanitize, ignore_spam, forced = null)
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

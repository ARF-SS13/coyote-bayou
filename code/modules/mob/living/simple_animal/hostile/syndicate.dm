/*
	CONTENTS
	LINE 10  - BASE MOB
	LINE 52  - SWORD AND SHIELD
	LINE 164 - GUNS
	LINE 267 - MISC
*/


///////////////Base mob////////////
/obj/effect/light_emitter/red_energy_sword //used so there's a combination of both their head light and light coming off the energy sword
	set_luminosity = 2
	set_cap = 2.5
	light_color = LIGHT_COLOR_RED

/// Body Armored Guys
/mob/living/simple_animal/hostile/renegade/syndicate
	name = "Renegade Operative"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting)."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "syndicate"
	icon_living = "syndicate"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 0
	robust_searching = 1
	maxHealth = 100
	health = 100
	mob_armor = ARMOR_VALUE_SYNDIE_VEST_MELEE
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 30
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list()
	//atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	//unsuitable_atmos_damage = 15
	faction = list("raider")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = FALSE
	dodging = TRUE
	rapid_melee = 2
	retreat_health_percent = 0.2
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 10

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/renegade/syndicate/melee
	name = "Renegade Operative Assassin"
	icon_state = "syndicate_knife"
	icon_living = "syndicate_knife"
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	move_to_delay = 2
	mob_armor = ARMOR_VALUE_SYNDIE_VEST_MELEE
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 30
	wound_bonus = 10
	rapid_melee = 2
	status_flags = 0

/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword
	name = "Renegade Operative Knight"
	icon_state = "syndicate_sword"
	icon_living = "syndicate_sword"
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/blade1.ogg'
	move_to_delay = 3
	mob_armor = ARMOR_VALUE_SYNDIE_VEST
	harm_intent_damage = 15
	melee_damage_lower = 25
	melee_damage_upper = 30
	wound_bonus = 20
	rapid_melee = 1
	light_color = LIGHT_COLOR_RED
	status_flags = 0
	light_system = MOVABLE_LIGHT
	light_range = 2
	var/obj/effect/light_emitter/red_energy_sword/sord

/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/Destroy()
	QDEL_NULL(sord)
	return ..()

/mob/living/simple_animal/hostile/renegade/syndicate/melee/bullet_act(obj/item/projectile/Proj)
	if(prob(25))
		return ..()
	visible_message(span_danger("[src] blocks [Proj] with its shield!"))
	return BULLET_ACT_BLOCK

/// guns
/mob/living/simple_animal/hostile/renegade/syndicate/ranged
	name = "Renegade Trooper"
	icon_state = "syndicate_pistol"
	icon_living = "syndicate_pistol"
	move_to_delay = 3
	mob_armor = ARMOR_VALUE_SYNDIE_VEST_MELEE
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 25
	wound_bonus = 20
	rapid_melee = 1
	ranged = 1
	retreat_distance = 6
	minimum_distance = 6
	casingtype = /obj/item/ammo_casing/c10mm
	projectilesound = 'sound/weapons/gunshot.ogg'
	dodging = FALSE
	rapid_melee = 1

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/infiltrator //shuttle loan event
	projectilesound = 'sound/weapons/gunshot_silenced.ogg'

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg
	name = "Renegade Assault Trooper"
	icon_state = "syndicate_smg"
	icon_living = "syndicate_smg"
	move_to_delay = 2.5
	mob_armor = ARMOR_VALUE_SYNDIE_VEST
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 25
	wound_bonus = 20
	rapid_melee = 1
	ranged = 1
	retreat_distance = 6
	minimum_distance = 6
	rapid = 5
	casingtype = /obj/item/ammo_casing/c45
	projectilesound = 'sound/weapons/gunshot_smg.ogg'

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg/pilot //caravan ambush ruin
	name = "Renegade Salvage Pilot"

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/shotgun
	move_to_delay = 3
	mob_armor = ARMOR_VALUE_SYNDIE_VEST
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 25
	wound_bonus = 20
	rapid_melee = 1
	ranged = 1
	retreat_distance = 4
	minimum_distance = 4
	rapid = 2
	rapid_fire_delay = 6
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	casingtype = /obj/item/ammo_casing/shotgun/buckshot //buckshot (up to 72.5 brute) fired in a two-round burst

/mob/living/simple_animal/hostile/renegade/syndicate/civilian
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/simple_animal/hostile/renegade/syndicate/civilian/Aggro()
	..()
	summon_backup(15)
	say("GUARDS!!")

/// Redsuit Guys ///
/mob/living/simple_animal/hostile/renegade/syndicate/space
	name = "Renegade Commando"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a red voidsuit, which just so happens to be pretty darn good powered armor."
	icon_state = "syndicate_space"
	icon_living = "syndicate_space"
	move_to_delay = 2.5
	mob_armor = ARMOR_VALUE_SYNDIE_REDSUIT_MELEE
	harm_intent_damage = 15
	melee_damage_lower = 35
	melee_damage_upper = 40
	maxHealth = 170
	health = 170
	speed = 1
	spacewalk = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 4

/mob/living/simple_animal/hostile/renegade/syndicate/melee/space
	name = "Renegade Marathon Commando"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a red voidsuit, which just so happens to be pretty darn good powered armor."
	icon_state = "syndicate_space_knife"
	icon_living = "syndicate_space_knife"
	move_to_delay = 2
	mob_armor = ARMOR_VALUE_SYNDIE_REDSUIT_MELEE
	harm_intent_damage = 15
	melee_damage_lower = 25
	melee_damage_upper = 45
	wound_bonus = 10
	rapid_melee = 2
	maxHealth = 170
	health = 170
	mob_armor = ARMOR_VALUE_SYNDIE_REDSUIT
	speed = 1
	light_system = MOVABLE_LIGHT
	light_range = 4

/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space
	name = "Renegade Commando Knight"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a red voidsuit, which just so happens to be pretty darn good powered armor."
	icon_state = "syndicate_space_sword"
	icon_living = "syndicate_space_sword"
	move_to_delay = 2
	mob_armor = ARMOR_VALUE_SYNDIE_REDSUIT_MELEE
	harm_intent_damage = 15
	melee_damage_lower = 45
	melee_damage_upper = 50
	wound_bonus = 40
	rapid_melee = 1
	maxHealth = 170
	health = 170
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	//minbodytemp = 0
	speed = 1
	spacewalk = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 4

/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space/Initialize()
	. = ..()
	sord = new(src)

/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space/Destroy()
	QDEL_NULL(sord)
	return ..()

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/space
	name = "Renegade Commando Trooper"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a red voidsuit, which just so happens to be pretty darn good powered armor."
	icon_state = "syndicate_space_pistol"
	icon_living = "syndicate_space_pistol"
	move_to_delay = 3
	mob_armor = ARMOR_VALUE_SYNDIE_REDSUIT
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 30
	wound_bonus = 10
	maxHealth = 170
	health = 170
	speed = 1
	casingtype = /obj/item/ammo_casing/c45
	projectilesound = 'sound/weapons/gunshot.ogg'
	light_system = MOVABLE_LIGHT
	light_range = 4

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg/space
	name = "Renegade Assault Commando"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a red voidsuit, which just so happens to be pretty darn good powered armor."
	icon_state = "syndicate_space_smg"
	icon_living = "syndicate_space_smg"
	move_to_delay = 3
	mob_armor = ARMOR_VALUE_SYNDIE_REDSUIT
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 30
	maxHealth = 170
	health = 170
	speed = 1
	light_system = MOVABLE_LIGHT
	light_range = 4

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/shotgun/space
	name = "Renegade Commando"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a red voidsuit, which just so happens to be pretty darn good powered armor."
	icon_state = "syndicate_space_shotgun"
	icon_living = "syndicate_space_shotgun"
	move_to_delay = 3
	mob_armor = ARMOR_VALUE_SYNDIE_REDSUIT
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 30
	maxHealth = 170
	health = 170
	speed = 1
	light_system = MOVABLE_LIGHT
	light_range = 4


/// Elitesuit Guys ///
/mob/living/simple_animal/hostile/renegade/syndicate/space/stormtrooper
	icon_state = "syndicate_stormtrooper"
	icon_living = "syndicate_stormtrooper"
	name = "Renegade Elite Brawler"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a black voidsuit, designed to fight horrible monsters on the frontiers of reality. And you, apparently."
	mob_armor = ARMOR_VALUE_SYNDIE_ELITE_MELEE
	move_to_delay = 2
	harm_intent_damage = 15
	melee_damage_lower = 50
	melee_damage_upper = 55
	maxHealth = 250
	health = 250

/mob/living/simple_animal/hostile/renegade/syndicate/melee/space/stormtrooper
	icon_state = "syndicate_stormtrooper_knife"
	icon_living = "syndicate_stormtrooper_knife"
	name = "Renegade Elite Lightweight Marathon Commando"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a black voidsuit, designed to fight horrible monsters on the frontiers of reality. And you, apparently."
	mob_armor = ARMOR_VALUE_SYNDIE_ELITE_MELEE
	move_to_delay = 1.5
	harm_intent_damage = 15
	melee_damage_lower = 50
	melee_damage_upper = 55
	maxHealth = 250
	health = 250


/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space/stormtrooper
	name = "Renegade Elite Knight"
	desc = "Part of the Void Stalker arm of the Renegades, here from parts unknown to give backup to their Terra Firma company (the guys you've been shooting). This one's decked out in a black voidsuit, designed to fight horrible monsters on the frontiers of reality. And you, apparently."
	icon_state = "syndicate_stormtrooper_sword"
	icon_living = "syndicate_stormtrooper_sword"
	mob_armor = ARMOR_VALUE_SYNDIE_ELITE_MELEE
	move_to_delay = 2
	harm_intent_damage = 15
	melee_damage_lower = 50
	melee_damage_upper = 55
	wound_bonus = 40
	rapid_melee = 1
	maxHealth = 250
	health = 250

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/space/stormtrooper
	name = "Renegade Elite Trooper"
	icon_state = "syndicate_stormtrooper_pistol"
	icon_living = "syndicate_stormtrooper_pistol"
	mob_armor = ARMOR_VALUE_SYNDIE_ELITE_MELEE
	move_to_delay = 2
	harm_intent_damage = 15
	melee_damage_lower = 40
	melee_damage_upper = 45
	maxHealth = 250
	health = 250
	casingtype = /obj/item/ammo_casing/c4570
	projectilesound = 'sound/f13weapons/sequoia.ogg'

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg/space/stormtrooper
	icon_state = "syndicate_stormtrooper_smg"
	icon_living = "syndicate_stormtrooper_smg"
	name = "Renegade Elite"
	name = "Renegade Elite"
	mob_armor = ARMOR_VALUE_SYNDIE_ELITE_MELEE
	move_to_delay = 2
	harm_intent_damage = 15
	melee_damage_lower = 40
	melee_damage_upper = 45
	maxHealth = 250
	health = 250
	casingtype = /obj/item/ammo_casing/a45lc
	projectilesound = 'sound/f13weapons/cyberbang.ogg'

/mob/living/simple_animal/hostile/renegade/syndicate/ranged/shotgun/space/stormtrooper
	icon_state = "syndicate_stormtrooper_shotgun"
	icon_living = "syndicate_stormtrooper_shotgun"
	name = "Renegade Elite"
	maxHealth = 250
	health = 250

///////////////Misc////////////

/mob/living/simple_animal/hostile/viscerator
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon_state = "viscerator_attack"
	icon_living = "viscerator_attack"
	pass_flags = PASSTABLE | PASSMOB
	a_intent = INTENT_HARM
	mob_biotypes = MOB_ROBOTIC
	health = 25
	maxHealth = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list(ROLE_SYNDICATE)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	//minbodytemp = 0
	mob_size = MOB_SIZE_TINY
	movement_type = FLYING
	limb_destroyer = 1
	speak_emote = list("states")
	bubble_icon = "syndibot"
	gold_core_spawnable = HOSTILE_SPAWN
	del_on_death = 1
	deathmessage = "is smashed into pieces!"

/mob/living/simple_animal/hostile/viscerator/Initialize()
	. = ..()
	AddComponent(/datum/component/swarming)

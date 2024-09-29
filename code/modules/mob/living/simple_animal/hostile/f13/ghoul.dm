/* IN THIS FILE
-ghouls
*/

//Base ghoul
/mob/living/simple_animal/hostile/ghoul
	name = "feral walker"
	desc = "A ghoul that has lost its mind and become aggressive."
	icon = 'icons/fallout/mobs/humans/ghouls.dmi'
	icon_state = "feralghoul"
	icon_living = "feralghoul"
	icon_dead = "feralghoul_dead"
	var/rare_icon = "feralghoul_h"
	can_ghost_into = TRUE
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_armor = ARMOR_VALUE_ghoul_NAKED
	maxHealth = 40 
	health = 40
	robust_searching = 1
	move_to_delay = 5
	turns_per_move = 5
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	speak_emote = list(
		"growls",
		"murrs",
		"barks",
		"gurgles",
		"screeches",
		"hisses",
		"uwu's",
		"awoos",
		"borks",
		"pants",
		"wiggles its eyebrows",
		"churrs",
		"purrs",
		"trills",
		"waggles"
		)
	emote_see = list(
		"wags its tail",
		"looks hungry",
		"sniffs the air",
		"growls",
		"foams at the mouth",
		"loses its shit",
		"busts it down",
		"goes full tilt"
		)
	a_intent = INTENT_HARM
	speed = 1
	harm_intent_damage = 8
	melee_damage_lower = 6
	melee_damage_upper = 12
	attack_verb_simple = list(
		"claws",
		"maims",
		"bites",
		"mauls",
		"slashes",
		"thrashes",
		"bashes",
		"glomps"
		)
	attack_sound = 'sound/hallucinations/growl1.ogg'
	atmos_requirements = list(
		"min_oxy" = 5,
		"max_oxy" = 0,
		"min_tox" = 0,
		"max_tox" = 1,
		"min_co2" = 0,
		"max_co2" = 5,
		"min_n2" = 0,
		"max_n2" = 0
		)
		
	unsuitable_atmos_damage = 20
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list("hostile", "ghoul")
	decompose = TRUE
	sharpness = SHARP_EDGED //They need to cut their finger nails
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/human/ghoul = 2,
		/obj/item/stack/sheet/animalhide/human = 1,
		/obj/item/stack/sheet/bone = 1
		)

	emote_taunt_sound = list('sound/f13npc/ghoul/taunt.ogg')
	emote_taunt = list(
		"gurgles",
		"stares",
		"foams at the mouth",
		"groans",
		"growls",
		"jibbers",
		"howls madly",
		"screeches",
		"charges"
		)

	tastes = list("decay" = 1, "mud" = 1)
	taunt_chance = 30
	emote_taunt_sound = list('sound/f13npc/ghoul/aggro1.ogg', 'sound/f13npc/ghoul/aggro2.ogg', 'sound/f13npc/ghoul/aggro3.ogg',) //I will not apologize. ~TK
	idlesound = list('sound/f13npc/ghoul/idle.ogg', 'sound/effects/scrungy.ogg')
	death_sound = 'sound/f13npc/ghoul/ghoul_death.ogg'
	loot = list(/obj/effect/spawner/lootdrop/f13/trash)
	/// How many things to drop on death? Set to MOB_LOOT_ALL to just drop everything in the list
	loot_drop_amount = 1
	/// Drop 1 - loot_drop_amount? False always drops loot_drop_amount items
	loot_amount_random = TRUE
	/// slots in a list of trash loot
	var/random_trash_loot = TRUE
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = TRUE
	desc_short = "A flimsy creature that may or may not be a reanimated corpse."
	pop_required_to_jump_into = SMALL_MOB_MIN_PLAYERS
	ignore_other_mobs = TRUE // peaceful giants that HATE PEOPLE!!!!
	
	variation_list = list(
		MOB_COLOR_VARIATION(150, 150, 150, 255, 255, 255),
		MOB_SPEED_LIST(3.0, 3.2, 3.6, 3.8, 4),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(10),
		MOB_HEALTH_LIST(30, 35, 40, 40, 40, 40, 41),
		MOB_RETREAT_DISTANCE_LIST(0, 0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(5),
		MOB_MINIMUM_DISTANCE_LIST(0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(10)
	)

/mob/living/simple_animal/hostile/ghoul/Initialize()
	. = ..()
	if(prob(50))
		icon_state = rare_icon
		icon_living = rare_icon
		icon_dead = "[rare_icon]_dead"
	if(random_trash_loot)
		loot = GLOB.trash_mob_loot


/mob/living/simple_animal/hostile/ghoul/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(15)
	if(!ckey)
		say(pick("*scrungy", "*mbark"))


/mob/living/simple_animal/hostile/ghoul/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/ghoul
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/ghoul
	. = ..()


// ghoul Reaver
/mob/living/simple_animal/hostile/ghoul/reaver
	name = "feral walker skirmisher"
	desc = "A ghoul that has lost its mind and become aggressive. This one is strapped with metal armor, and appears far stronger."
	icon_state = "ghoulreaver"
	icon_living = "ghoulreaver"
	icon_dead = "ghoulreaver_dead"
	rare_icon = "ghoulreaver_h"
	speed = 2
	mob_armor = ARMOR_VALUE_ghoul_REAVER
	maxHealth = 50
	health = 50
	rapid_melee = 2
	retreat_distance = 3
	minimum_distance = 1
	ranged = TRUE
	ranged_message = "throws a rock"
	ranged_cooldown_time = 3 SECONDS
	projectiletype = /obj/item/projectile/bullet/ghoul_rock
	projectilesound = 'sound/weapons/punchmiss.ogg'
	harm_intent_damage = 8
	melee_damage_lower = 8
	melee_damage_upper = 14
	loot = list(/obj/effect/spawner/lootdrop/f13/trash)
	loot_drop_amount = 2
	loot_amount_random = TRUE
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = TRUE
	pop_required_to_jump_into = BIG_MOB_MIN_PLAYERS

	variation_list = list(
		MOB_COLOR_VARIATION(200, 200, 200, 255, 255, 255),
		MOB_SPEED_LIST(3.6, 3.8, 4, 4.2, 4.4),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(10),
		MOB_HEALTH_LIST(41, 45, 50, 50, 50, 50, 51),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(5),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(10),
		MOB_PROJECTILE_LIST(\
			MOB_PROJECTILE_ENTRY(/obj/item/projectile/bullet/ghoul_rock, 10),\
			MOB_PROJECTILE_ENTRY(/obj/item/projectile/bullet/ghoul_rock/blunt_rock, 10),\
			MOB_PROJECTILE_ENTRY(/obj/item/projectile/bullet/ghoul_rock/jagged_scrap, 1)\
		)
	)
	desc_short = "A beefy creature that may or may not be a reanimated corpse."

/mob/living/simple_animal/hostile/ghoul/reaver/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/ghoul/reaver/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/ghoul/reaver/ncr
	name = "feral walker soldier"
	desc = "A former US Army combatant, now ghoulified and insane. The armor that failed it in life still packs some good defense."
	maxHealth = 60
	can_ghost_into = FALSE

/mob/living/simple_animal/hostile/ghoul/reaver/ncr_helmet
	name = "plated feral walker soldier"
	desc = "A former US Army combatant, now ghoulified and insane. The armor that failed it in life still packs some good defense."
	maxHealth = 60
	can_ghost_into = FALSE

/mob/living/simple_animal/hostile/ghoul/reaver/ncr_officer
	name = "feral walker officer"
	desc = "A former US Army officer, now ghoulified and insane. The armor that failed it in life still packs some good defense."
	maxHealth = 60
	speed = 3
	can_ghost_into = FALSE

//Cold Feral ghoul
/mob/living/simple_animal/hostile/ghoul/coldferal
	name = "cold walker feral"
	desc = "A ghoul that has lost its mind and become aggressive. This one is strapped with metal armor, and appears far stronger."
	icon_state = "cold_feral"
	icon_living = "cold_feral"
	icon_dead = "cold_feral_dead"
	speed = 1.5
	mob_armor = ARMOR_VALUE_ghoul_COLD
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 15
	loot = list(/obj/item/stack/f13Cash/random/low/medchance)
	loot_drop_amount = 2
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE

//Frozen Feral ghoul
/mob/living/simple_animal/hostile/ghoul/frozenreaver
	name = "frozen walker reaver"
	desc = "A ghoul that has lost its mind and become aggressive. This one is strapped with metal armor, and appears far stronger."
	icon_state = "frozen_reaver"
	icon_living = "frozen_reaver"
	icon_dead = "frozen_reaver_dead"
	mob_armor = ARMOR_VALUE_ghoul_COLDER
	speed = 1.5
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 15
	loot = list(/obj/item/stack/f13Cash/random/low/medchance)
	loot_drop_amount = 4
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE

//Legendary ghoul
/mob/living/simple_animal/hostile/ghoul/legendary
	name = "legendary walker"
	desc = "A ghoul that has lost its mind and become aggressive. This one has exceptionally large, bulging muscles. It looks quite strong."
	icon_state = "glowinghoul"
	icon_living = "glowinghoul"
	icon_dead = "glowinghoul_dead"
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_ghoul_LEGEND
	can_ghost_into = FALSE
	maxHealth = 200
	health = 200
	speed = 2.5
	harm_intent_damage = 8
	melee_damage_lower = 20
	melee_damage_upper = 35
	mob_size = 5
	wound_bonus = 0
	bare_wound_bonus = 0
	loot = list(/obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 5
	loot_amount_random = FALSE
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE //heeeeeell no
	pop_required_to_jump_into = BIG_MOB_MIN_PLAYERS
	desc_short = "A deadly creature that may or may not be reanimated jerky."

/mob/living/simple_animal/hostile/ghoul/legendary/become_the_mob(mob/user)
	call_backup = null
	send_mobs = null
	. = ..()

//Glowing ghoul
/mob/living/simple_animal/hostile/ghoul/glowing
	name = "feral walker rad-shaman"
	desc = "A feral ghoul that has absorbed massive amounts of radiation, causing them to glow in the dark and radiate constantly."
	icon_state = "glowinghoul"
	icon_living = "glowinghoul"
	icon_dead = "glowinghoul_dead"
	rare_icon = "glowinghoul_h"
	mob_armor = ARMOR_VALUE_ghoul_GLOWING
	maxHealth = 40 
	health = 40
	speed = 2
	retreat_distance = 4
	minimum_distance = 4
	ranged_message = "emits radiation"
	ranged = TRUE
	projectiletype = /obj/item/projectile/radiation_thing
	projectilesound = 'sound/weapons/etherealhit.ogg'
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 22
	light_system = MOVABLE_LIGHT
	light_range = 2
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = TRUE
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 1
	loot_amount_random = TRUE
	pop_required_to_jump_into = BIG_MOB_MIN_PLAYERS
	desc_short = "A glowing creature that may or may not be a reanimated corpse."
	loot_drop_amount = 2

	variation_list = list(
		MOB_COLOR_VARIATION(150, 150, 150, 255, 255, 255),
		MOB_SPEED_LIST(3.0, 3.2, 3.6, 3.8, 4, 4.2),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(10),
		MOB_HEALTH_LIST(38, 40, 42, 44),
		MOB_RETREAT_DISTANCE_LIST(0, 2, 4),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50)
	)

/mob/living/simple_animal/hostile/ghoul/glowing/Initialize(mapload)
	. = ..()
	// we only heal BRUTELOSS because each type directly heals a simplemob's health
	// therefore setting it to BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS would mean healing 4x as much
	// aka 40% of max life every tick, which is basically unkillable
	// TODO: refactor this if simple_animals ever get damage types
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/ghoul, allow_revival = FALSE, restrict_faction = null, type_healing = BRUTELOSS)

/obj/item/projectile/radiation_thing
	name = "radiation"
	damage = 15
	irradiate = 5
	icon_state = "declone"

/obj/item/projectile/radiation_thing/neurothing
	name = "radiation"
	damage = 15
	irradiate = 5
	icon_state = "neurotoxin"


/mob/living/simple_animal/hostile/ghoul/glowing/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/ghoul/glowing/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.apply_effect(20, EFFECT_IRRADIATE, 0)

/mob/living/simple_animal/hostile/ghoul/glowing/strong // FEV mutation
	maxHealth = 256
	health = 256
	speed = 1.4 // Nyooom
	can_ghost_into = FALSE
	melee_damage_lower = 25
	melee_damage_upper = 30

//Alive ghoul
/mob/living/simple_animal/hostile/ghoul/soldier
	name = "walker soldier"
	desc = "Have you ever seen a living ghoul before?<br>ghouls are necrotic post-humans - decrepit, rotting, zombie-like mutants."
	icon_state = "soldier_ghoul"
	icon_living = "soldier_ghoul"
	icon_dead = "soldier_ghoul_d"
	icon_gib = "syndicate_gib"
	mob_armor = ARMOR_VALUE_GHOUL_COMBAT
	maxHealth = 60 
	health = 60
	loot = list(/obj/item/stack/f13Cash/random/low/medchance)
	loot_drop_amount = 2
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE

//Alive ghoul
/mob/living/simple_animal/hostile/ghoul/soldier/armored
	name = "armored walker soldier"
	desc = "Have you ever seen a living ghoul before?<br>ghouls are necrotic post-humans - decrepit, rotting, zombie-like mutants."
	icon_state = "soldier_ghoul_a"
	icon_living = "soldier_ghoul_a"
	icon_dead = "soldier_ghoul_a_d"
	icon_gib = "syndicate_gib"
	mob_armor = ARMOR_VALUE_GHOUL_COMBAT
	maxHealth = 80 
	health = 80
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE
	loot_drop_amount = 3

//Alive ghoul
/mob/living/simple_animal/hostile/ghoul/scorched
	name = "scorched walker soldier"
	desc = "Have you ever seen a living ghoul before?<br>ghouls are necrotic post-humans - decrepit, rotting, zombie-like mutants."
	icon_state = "scorched_m"
	icon_living = "scorched_m"
	icon_dead = "scorched_m_d"
	icon_gib = "syndicate_gib"
	mob_armor = ARMOR_VALUE_GHOUL_COMBAT
	speak_chance = 1
	environment_smash = 0
	response_help_simple = "hugs"
	response_disarm_simple = "pushes aside"
	response_harm_simple = "growl"
	move_to_delay = 5
	faction = list("scorched", "hostile")
	death_sound = null
	melee_damage_upper = 20
	aggro_vision_range = 10
	attack_verb_simple = "punches"
	attack_sound = "punch"
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE
	loot_drop_amount = 4
	variation_list = list(
		MOB_COLOR_VARIATION(150, 150, 150, 255, 255, 255),
		MOB_SPEED_LIST(3.6, 3.8, 4, 4.2, 4.4),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(10),
		MOB_HEALTH_LIST(30, 35, 40, 40, 40, 40, 41),
		MOB_RETREAT_DISTANCE_LIST(0, 0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(5),
		MOB_MINIMUM_DISTANCE_LIST(0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(10)
	)

//Alive ghoul Ranged
/mob/living/simple_animal/hostile/ghoul/scorched/ranged
	name = "Ranged walker Soldier"
	desc = "Have you ever seen a living ghoul before?<br>ghouls are necrotic post-humans - decrepit, rotting, zombie-like mutants."
	icon_state = "scorched_r"
	icon_living = "scorched_r"
	icon_dead = "scorched_r_d"
	icon_gib = "syndicate_gib"
	mob_armor = ARMOR_VALUE_GHOUL_COMBAT
	speak_chance = 1
	turns_per_move = 5
	environment_smash = 0
	response_help_simple = "hugs"
	response_disarm_simple = "pushes aside"
	response_harm_simple = "ow"
	move_to_delay = 5
	ranged = TRUE
	ranged_cooldown_time = 200
	projectiletype = /obj/item/projectile/bullet/c9mm/simple
	projectilesound = 'sound/f13weapons/hunting_rifle.ogg'
	faction = list("scorched", "hostile")
	melee_damage_lower = 15
	melee_damage_upper = 20
	aggro_vision_range = 10
	attack_verb_simple = "shoots"
	attack_sound = "punch"
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE
	loot_drop_amount = 5
	variation_list = list(
		MOB_COLOR_VARIATION(150, 150, 150, 255, 255, 255),
		MOB_SPEED_LIST(3.6, 3.8, 4, 4.2, 4.4),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(10),
		MOB_HEALTH_LIST(30, 35, 40, 40, 40, 40, 41),
		MOB_RETREAT_DISTANCE_LIST(0, 0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(5),
		MOB_MINIMUM_DISTANCE_LIST(0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(10)
	)

//Sunset mob of some sort?
/mob/living/simple_animal/hostile/ghoul/wyomingghost
	name = "ghost soldier"
	desc = "A figure clad in armor that stands silent except for the slight wheezing coming from them, a dark orange and black liquid pumps through a clear tube into the gas mask. The armor they wear seems to be sealed to their skin."
	icon_state = "wyomingghost"
	icon_living = "wyomingghost"
	icon_dead = "wyomingghost_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_armor = ARMOR_VALUE_GHOUL_PA
	robust_searching = 1
	turns_per_move = 5
	speak_emote = list("wheezes")
	emote_see = list("stares")
	a_intent = INTENT_HARM
	maxHealth = 150
	health = 150
	speed = 2
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_simple = "attacks"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	unsuitable_atmos_damage = 20
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list("supermutant","ghoul")
	decompose = FALSE
	sharpness = SHARP_EDGED //They need to cut their finger nails
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE
	loot_drop_amount = 5

//Halloween Event ghouls
/mob/living/simple_animal/hostile/ghoul/zombie
	name = "ravenous feral walker"
	desc = "A ferocious feral ghoul, hungry for human meat."
	faction = list("ghoul")
	mob_armor = ARMOR_VALUE_GHOUL_COMBAT
	can_ghost_into = FALSE
	maxHealth = 200
	health = 200
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE

/*/mob/living/simple_animal/hostile/ghoul/zombie/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		try_to_ghoul_zombie_infect(H)*/

/mob/living/simple_animal/hostile/ghoul/zombie/reaver
	name = "ravenous feral walker"
	desc = "A ferocious feral ghoul, hungry for human meat. This one is strapped with metal armor, and appears far stronger."
	icon_state = "ghoulreaver"
	icon_living = "ghoulreaver"
	icon_dead = "ghoulreaver_dead"
	speed = 2
	maxHealth = 216
	health = 216
	can_ghost_into = FALSE
	harm_intent_damage = 8
	melee_damage_lower = 30
	melee_damage_upper = 30
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE

/mob/living/simple_animal/hostile/ghoul/zombie/glowing
	name = "ravenous glowing feral ghoul"
	desc = "A ferocious feral ghoul, hungry for human meat. This one has absorbed massive amounts of radiation, causing them to glow in the dark and radiate constantly."
	icon_state = "glowinghoul"
	icon_living = "glowinghoul"
	icon_dead = "glowinghoul_dead"
	maxHealth = 192
	health = 192
	speed = 2
	can_ghost_into = FALSE
	harm_intent_damage = 8
	melee_damage_lower = 30
	melee_damage_upper = 30
	light_system = MOVABLE_LIGHT
	light_range = 2
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE

/mob/living/simple_animal/hostile/ghoul/zombie/glowing/Initialize(mapload)
	. = ..()
	// we only heal BRUTELOSS because each type directly heals a simplemob's health
	// therefore setting it to BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS would mean healing 4x as much
	// aka 40% of max life every tick, which is basically unkillable
	// TODO: refactor this if simple_animals ever get damage types
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/ghoul, allow_revival = FALSE, restrict_faction = null, type_healing = BRUTELOSS)

/mob/living/simple_animal/hostile/ghoul/zombie/glowing/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/ghoul/zombie/glowing/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.apply_effect(20, EFFECT_IRRADIATE, 0)

/mob/living/simple_animal/hostile/ghoul/zombie/legendary
	name = "legendary ravenous walker"
	desc = "A ferocious feral ghoul, hungry for human meat. This one has exceptionally large, bulging muscles. It looks quite strong."
	icon_state = "glowinghoul"
	icon_living = "glowinghoul"
	icon_dead = "glowinghoul_dead"
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_ghoul_LEGEND
	maxHealth = 200
	health = 200
	can_ghost_into = FALSE
	speed = 2.5
	harm_intent_damage = 8
	melee_damage_lower = 30
	melee_damage_upper = 35
	mob_size = 5
	wound_bonus = 0
	bare_wound_bonus = 0
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	can_ghost_into = FALSE


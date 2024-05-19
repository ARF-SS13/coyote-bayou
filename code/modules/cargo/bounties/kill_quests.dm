/* 
 * File:   kill_quests.h
 * Author: joshu the fox
 * license: YIFF Public License
 * Created on September 1, 2012, 1:00 PM
 * 
 * This file contains quests that require the player to kill a certain number of a certain monster.
 * */

/datum/bounty/kill
	base_reward =         COINS_TO_CREDITS(50)
	medium_reward_bonus = COINS_TO_CREDITS(10)
	hard_reward_bonus =   COINS_TO_CREDITS(20)
	CBT_reward_bonus =    COINS_TO_CREDITS(30)
	flavor_kind = QUEST_KIND_KILL_MOBS
	candupe = FALSE
	respect_extinction = TRUE

/////////////////////////////////////////////
/////////////////////////////////////////////
// Geckoes
/datum/bounty/kill/geckoes
	name = "Slay some Geckoes"
	description = "Lousy things are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/gecko
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/gecko/easy,
		/datum/bounty_quota/gecko/medium,
		/datum/bounty_quota/gecko/hard,
		/datum/bounty_quota/gecko/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// GECKO QUOTAS /////
/datum/bounty_quota/gecko
	name = "Kill some Geckoes"
	paths = list(
		/mob/living/simple_animal/hostile/gecko,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(3)
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 3

/datum/bounty_quota/gecko/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/gecko/medium // no newts
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/gecko/hard
	needed_amount = 25
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/gecko/cocknballtorture
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Rats
/datum/bounty/kill/rats
	name = "Slay some Rats"
	description = "Rats are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/rat
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/rat/easy,
		/datum/bounty_quota/rat/medium,
		/datum/bounty_quota/rat/hard,
		/datum/bounty_quota/rat/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// RAT QUOTAS /////
/datum/bounty_quota/rat
	name = "Kill some Cute little mice"
	paths = list(
		/mob/living/simple_animal/hostile/rat,
		/mob/living/simple_animal/mouse,
	)
	needed_amount = 20
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(1)
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 3

/datum/bounty_quota/rat/easy
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/rat/medium
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/rat/hard
	needed_amount = 30
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/rat/cocknballtorture
	needed_amount = 150
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Nightstalkers
/datum/bounty/kill/nightstalkers
	name = "Slay some Nightstalkers"
	description = "Nightstalkers are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/stalker
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/nightstalker/easy,
		/datum/bounty_quota/nightstalker/medium,
		/datum/bounty_quota/nightstalker/hard,
		/datum/bounty_quota/nightstalker/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// NIGHTSTALKER QUOTAS /////
/datum/bounty_quota/nightstalker
	name = "Kill some Nightstalkers"
	paths = list(
		/mob/living/simple_animal/hostile/stalkeryoung,
		/mob/living/simple_animal/hostile/stalker,
	)
	needed_amount = 5
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(4)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/nightstalker/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/nightstalker/medium
	needed_amount = 10
	paths = list(
		/mob/living/simple_animal/hostile/stalker,
	)
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/nightstalker/hard
	needed_amount = 15
	paths = list(
		/mob/living/simple_animal/hostile/stalker,
	)
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/nightstalker/cocknballtorture
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Molerats
/datum/bounty/kill/molerats
	name = "Slay some GIANT RATS!"
	description = "GIANT RATS are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/molerat
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/molerat/easy,
		/datum/bounty_quota/molerat/medium,
		/datum/bounty_quota/molerat/hard,
		/datum/bounty_quota/molerat/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// MOLERAT QUOTAS /////
/datum/bounty_quota/molerat
	name = "Kill some GIANT RATS"
	paths = list(
		/mob/living/simple_animal/hostile/molerat,
	)
	needed_amount = 15
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(3)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/molerat/easy
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/molerat/medium
	needed_amount = 25
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/molerat/hard
	needed_amount = 30
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/molerat/cocknballtorture
	needed_amount = 200 // good luck
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Scorpins
/datum/bounty/kill/scorpins
	name = "Slay some Scorpins"
	description = "Scorpins are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/radscorpion
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/scorpin/easy,
		/datum/bounty_quota/scorpin/medium,
		/datum/bounty_quota/scorpin/hard,
		/datum/bounty_quota/scorpin/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// SCORPIN QUOTAS /////
/datum/bounty_quota/scorpin
	name = "Kill some Scorpins" // spelling is intentional
	paths = list(
		/mob/living/simple_animal/hostile/radscorpion,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(20)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/scorpin/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/scorpin/medium
	needed_amount = 10
	paths_exclude = list(
		/mob/living/simple_animal/hostile/radscorpion/blue,
	)
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/scorpin/hard
	needed_amount = 15
	paths = list(
		/mob/living/simple_animal/hostile/radscorpion/black,
	)
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/scorpin/cocknballtorture
	needed_amount = 150
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Roachy pillbugs
/datum/bounty/kill/roachypillbugs
	name = "Slay some Roachy Pillbugs"
	description = "Roachy Pillbugs are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/pillbug
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/roachypillbug/easy,
		/datum/bounty_quota/roachypillbug/medium,
		/datum/bounty_quota/roachypillbug/hard,
		/datum/bounty_quota/roachypillbug/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// ROACHYPILLBUG QUOTAS /////
/datum/bounty_quota/roachypillbug
	name = "Kill some Roachy Pillbugs"
	paths = list(
		/mob/living/simple_animal/hostile/pillbug,
	)
	needed_amount = 15
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(2)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 5

/datum/bounty_quota/roachypillbug/easy
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/roachypillbug/medium
	needed_amount = 25
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/roachypillbug/hard
	needed_amount = 40
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/roachypillbug/cocknballtorture
	needed_amount = 200
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Ghouls
/datum/bounty/kill/ghouls
	name = "Slay some Ghouls"
	description = "Ghouls are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/ghoul
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/ghoul/easy,
		/datum/bounty_quota/ghoul/medium,
		/datum/bounty_quota/ghoul/hard,
		/datum/bounty_quota/ghoul/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// GHOUL QUOTAS /////
/datum/bounty_quota/ghoul
	name = "Kill some Ghouls"
	paths = list(
		/mob/living/simple_animal/hostile/ghoul,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(5)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/ghoul/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/ghoul/medium
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/ghoul/hard
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/ghoul/cocknballtorture
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// ants
/datum/bounty/kill/ants
	name = "Slay some Ants"
	description = "Ants are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/giantant
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/ant/easy,
		/datum/bounty_quota/ant/medium,
		/datum/bounty_quota/ant/hard,
		/datum/bounty_quota/ant/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// ANT QUOTAS /////
/datum/bounty_quota/ant
	name = "Kill some Ants"
	paths = list(
		/mob/living/simple_animal/hostile/giantant,
		/mob/living/simple_animal/hostile/fireant,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(6)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/ant/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/ant/medium
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/ant/hard
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/ant/cocknballtorture
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// supermutants
/datum/bounty/kill/supermutants
	name = "Slay some Supermutants"
	description = "Supermutants are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/supermutant
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/supermutant/easy,
		/datum/bounty_quota/supermutant/medium,
		/datum/bounty_quota/supermutant/hard,
		/datum/bounty_quota/supermutant/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// SUPERMUTANT QUOTAS /////
/datum/bounty_quota/supermutant
	name = "Kill some Supermutants"
	paths = list(
		/mob/living/simple_animal/hostile/supermutant,
		/mob/living/simple_animal/hostile/centaur,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(10)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/supermutant/easy
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/supermutant/medium
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/supermutant/hard
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/supermutant/cocknballtorture
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// bloatflys
/datum/bounty/kill/bloatflys
	name = "Slay some Bloatflys"
	description = "Bloatflys are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/bloatfly
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/bloatfly/easy,
		/datum/bounty_quota/bloatfly/medium,
		/datum/bounty_quota/bloatfly/hard,
		/datum/bounty_quota/bloatfly/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// BLOATFLY QUOTAS /////
/datum/bounty_quota/bloatfly
	name = "Kill some Bloatflys"
	paths = list(
		/mob/living/simple_animal/hostile/bloatfly,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(4)
	easy_multiplier = 1
	medium_multiplier = 1
	hard_multiplier = 2
	CBT_multiplier = 3

/datum/bounty_quota/bloatfly/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/bloatfly/medium
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/bloatfly/hard
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/bloatfly/cocknballtorture
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// hellpigs
/datum/bounty/kill/hellpigs
	name = "Slay some Hellpigs"
	description = "Hellpigs are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/hellpig
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/hellpig/easy,
		/datum/bounty_quota/hellpig/medium,
		/datum/bounty_quota/hellpig/hard,
		/datum/bounty_quota/hellpig/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// HELLPIG QUOTAS /////
/datum/bounty_quota/hellpig
	name = "Kill some Hellpigs"
	paths = list(
		/mob/living/simple_animal/hostile/hellpig,
	)
	needed_amount = 1
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(20)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/hellpig/easy
	needed_amount = 1
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/hellpig/medium
	needed_amount = 2
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/hellpig/hard
	needed_amount = 3
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/hellpig/cocknballtorture
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Centaurs
/datum/bounty/kill/centaurs
	name = "Slay some Centaurs"
	description = "Centaurs are gross! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/centaur
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/centaur/easy,
		/datum/bounty_quota/centaur/medium,
		/datum/bounty_quota/centaur/hard,
		/datum/bounty_quota/centaur/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// CENTAUR QUOTAS /////
/datum/bounty_quota/centaur
	name = "Kill some Centaurs"
	paths = list(
		/mob/living/simple_animal/hostile/centaur,
	)
	needed_amount = 5
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(8)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/centaur/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/centaur/medium
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/centaur/hard
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/centaur/cocknballtorture
	needed_amount = 50 // are there even that many?
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Raiders
/datum/bounty/kill/raiders
	name = "Slay some Raiders"
	description = "Those lousy functionally immortal humans are making life miserable! I'll pay you to kill some of them. But not the super-duper ones, like Mango Matt, Blueberry Bates, or any of the other super-duper raiders. Just the regular ones."
	flavor_focus = /mob/living/simple_animal/hostile/raider
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/raider/easy,
		/datum/bounty_quota/raider/medium,
		/datum/bounty_quota/raider/hard,
		/datum/bounty_quota/raider/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// RAIDER QUOTAS /////
/datum/bounty_quota/raider
	name = "Kill some Raiders"
	flavor = "But not Mango Matt, Blueberry Bates, or any of the other super-duper raiders. Just the regular ones."
	paths = list(
		/mob/living/simple_animal/hostile/raider,
	)
	paths_exclude = list(
		/mob/living/simple_animal/hostile/raider/ranged/boss,
	)
	needed_amount = 5
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(15)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/raider/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/raider/medium
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/raider/hard
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/raider/cocknballtorture
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Deathclaws
/datum/bounty/kill/deathclaws
	name = "Slay some Deathclaws"
	description = "Deathclaws are scary and mean! (and honestly kinda tasty) I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/deathclaw
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/deathclaw/easy,
		/datum/bounty_quota/deathclaw/medium,
		/datum/bounty_quota/deathclaw/hard,
		/datum/bounty_quota/deathclaw/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// DEATHCLAW QUOTAS /////
/datum/bounty_quota/deathclaw
	name = "Kill some Deathclaws"
	paths = list(
		/mob/living/simple_animal/hostile/deathclaw,
	)
	needed_amount = 2
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(50)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/deathclaw/easy
	needed_amount = 2
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/deathclaw/medium
	needed_amount = 4
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/deathclaw/hard
	needed_amount = 6
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/deathclaw/cocknballtorture
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_CBT // the cocknballtorture part is actually finding 20 of em

/////////////////////////////////////////////
/////////////////////////////////////////////
// Enclave Hellions
/datum/bounty/kill/enclavehellions
	name = "Slay some Enclavers"
	description = "The Cyber-Enclave think they're so good with their plasma blasters and power armor! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/enclave
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/enclavehellion/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_CBT

///// ENCLAVEHELLION QUOTAS /////
/datum/bounty_quota/enclavehellion
	name = "Kill some Enclave Hellions"
	flavor = "Fair warning, they're tough. They love their plasma weapons and power armor. And no, they won't share either with you, no matter how hard you try."
	paths = list(
		/mob/living/simple_animal/hostile/enclave,
	)
	needed_amount = 20
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(50)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/enclavehellion/cocknballtorture
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Civilian robots // the lower level ones
/datum/bounty/kill/civilianrobots
	name = "Scrap some Civilian Robots"
	description = "Civilian robots are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/eyebot
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/civilianrobot/easy,
		/datum/bounty_quota/civilianrobot/medium,
		/datum/bounty_quota/civilianrobot/hard,
		/datum/bounty_quota/civilianrobot/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// CIVILIANROBOT QUOTAS /////
/datum/bounty_quota/civilianrobot
	name = "Scrap some Civilian Robots"
	flavor = "Not to be confused with the curvy furry lizard robot people around town, they're *our* civilian robots."
	paths = list(
		/mob/living/simple_animal/hostile/eyebot,
		/mob/living/simple_animal/pet/dog/eyebot,
		/mob/living/simple_animal/hostile/handy,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(10)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/civilianrobot/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/civilianrobot/medium
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/civilianrobot/hard
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/civilianrobot/cocknballtorture
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Military robots // the higher level ones
/datum/bounty/kill/militaryrobots
	name = "Scrap some Military Robots"
	description = "Military robots are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/securitron
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/militaryrobot/easy,
		/datum/bounty_quota/militaryrobot/medium,
		/datum/bounty_quota/militaryrobot/hard,
		/datum/bounty_quota/militaryrobot/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// MILITARYROBOT QUOTAS /////
/datum/bounty_quota/militaryrobot
	name = "Scrap some Military Robots"
	flavor = "They're tougher than the civilian robots, but they're still just robots. They're not even furry."
	paths = list(
		/mob/living/simple_animal/hostile/hivebot,
		/mob/living/simple_animal/hostile/securitron,
		/mob/living/simple_animal/hostile/synth,
		/mob/living/simple_animal/hostile/handy,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(20)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/militaryrobot/easy
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/militaryrobot/medium
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/militaryrobot/hard
	needed_amount = 30
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/militaryrobot/cocknballtorture
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// cute lizards
/datum/bounty/kill/cutelizards
	name = "KILL CUTE LIZARDS"
	description = "CUTE LIZARDS MUST DIE"
	flavor_focus = /mob/living/simple_animal/hostile/lizard
	weight = 0.1
	init_wanteds = list(
		/datum/bounty_quota/cutelizard,
	)
	difficulty = QUEST_DIFFICULTY_CBT

///// CUTELIZARD QUOTAS /////
/datum/bounty_quota/cutelizard
	name = "KILL CUTE LIZARDS"
	flavor = "CUTE LIZARDS MUST DIE"
	paths = list(
		/mob/living/simple_animal/hostile/lizard,
	)
	needed_amount = 1
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(5000)

/////////////////////////////////////////////
/////////////////////////////////////////////
// crabs
/datum/bounty/kill/crabs
	name = "Slay some Crabs"
	description = "Crabs are delicious! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/mirelurk
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/crab/easy,
		/datum/bounty_quota/crab/medium,
		/datum/bounty_quota/crab/hard,
		/datum/bounty_quota/crab/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// CRAB QUOTAS /////
/datum/bounty_quota/crab
	name = "Kill some Crabs"
	flavor = "No, yours don't count."
	paths = list(
		/mob/living/simple_animal/hostile/mirelurk,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(5)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/crab/easy
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/crab/medium
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/crab/hard
	needed_amount = 25
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/crab/cocknballtorture
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
//squish that dan// Huge Spiders
/datum/bounty/kill/hugespider
	name = "Squish some Huge Spiders"
	description = "Huge Spiders are spiders! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/poison/giant_spider
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/hugespider/easy,
		/datum/bounty_quota/hugespider/medium,
		/datum/bounty_quota/hugespider/hard,
		/datum/bounty_quota/hugespider/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// HUGESPIDER QUOTAS /////
/datum/bounty_quota/hugespider
	name = "Kill some Huge Spiders"
	flavor = "They're big, they're hairy, they're spiders. What more do you need to know?"
	paths = list(
		/mob/living/simple_animal/hostile/poison/giant_spider,
	)
	needed_amount = 5
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(15)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/hugespider/easy
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/hugespider/medium
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/hugespider/hard
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/hugespider/cocknballtorture
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
//Renegades
/datum/bounty/kill/renegades
	name = "Slay some Renegades"
	description = "Renegades are dangerous! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/renegade
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/renegade/hard,
		/datum/bounty_quota/renegade/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// RENEGADE QUOTAS /////
/datum/bounty_quota/renegade
	name = "Kill some Renegades"
	flavor = "Careful. Be careful. They're dangerous, so be careful."
	paths = list(
		/mob/living/simple_animal/hostile/renegade,
	)
	paths_exclude = list(
		/mob/living/simple_animal/hostile/renegade/meister,
	)
	needed_amount = 5
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(15)
	hard_multiplier = 1
	CBT_multiplier = 2

/datum/bounty_quota/renegade/hard
	needed_amount = 5
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/renegade/cocknballtorture
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Grab bag
/datum/bounty/kill/grabbag
	name = "Kill some goats or frogs or snakes or something"
	description = "I don't know, just kill some stuff."
	flavor_focus = /mob/living/simple_animal/hostile
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/grabbag/easy,
		/datum/bounty_quota/grabbag/medium,
		/datum/bounty_quota/grabbag/hard,
		/datum/bounty_quota/grabbag/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// GRABBAG QUOTAS /////
/datum/bounty_quota/grabbag
	name = "Kill some random stuff"
	flavor = "I don't know, just kill some stuff."
	paths = list(
		/mob/living/simple_animal/hostile/retaliate,
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(5)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/grabbag/easy
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/grabbag/medium
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/grabbag/hard
	needed_amount = 30
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/grabbag/cocknballtorture
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Super Grab Bag
/datum/bounty/kill/supergrabbag_easy
	name = "Scavenger Hunt"
	description = "Put your hunter skills to the test! Track down one specific creature and kill it."
	flavor_focus = /mob/living/simple_animal/hostile
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
	)
	difficulty = QUEST_DIFFICULTY_EASY
	candupe = TRUE

/datum/bounty/kill/supergrabbag_medium
	name = "Super Scavenger Hunt"
	description = "Put your hunter skills to the test! Track down two specific creatures and kill them."
	flavor_focus = /mob/living/simple_animal/hostile
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
	)
	difficulty = QUEST_DIFFICULTY_MED
	candupe = TRUE

/datum/bounty/kill/supergrabbag_hard
	name = "Ultra Scavenger Hunt"
	description = "Put your hunter skills to the test! Track down four specific creatures and kill them."
	flavor_focus = /mob/living/simple_animal/hostile
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
	)
	difficulty = QUEST_DIFFICULTY_HARD
	candupe = TRUE

/datum/bounty/kill/supergrabbag_CBT
	name = "Super Ultra Mega Impossible Scavenger Hunt"
	description = "Put your hunter skills to the test! Track down TEN specific creatures and kill them. Not for the faint of heart.<br/><br/>Disclaimer: The following thing has been confirmed (somewhat) to exist in some killable form at the time of posting."
	flavor_focus = /mob/living/simple_animal/hostile
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag,
		/datum/bounty_quota/supergrabbag, // welcome to cocknballtorture
	)
	difficulty = QUEST_DIFFICULTY_CBT
	candupe = TRUE

///// SUPERGRABBAG QUOTA /////
//// this one is special /////
/datum/bounty_quota/supergrabbag
	name = "Hunt Down the Free Dev"
	flavor = "DISCLAIMER: The following thing has been confirmed (somewhat) to exist (in some form) at the time of posting. If you can't seem to find it, maybe someone else got it first!"
	paths = list()
	needed_amount = 1
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(200)
	easy_multiplier = 1
	medium_multiplier = 1
	hard_multiplier = 2
	CBT_multiplier = 2 // 2500 for finding 10 randomass things? sure
	difficulty = null // valid for all difficulties

/datum/bounty_quota/supergrabbag/GetPaths()
	if(is_copy)
		return
	var/list/potentials = SSmobs.get_existing_mob_paths(/mob/living/simple_animal/hostile)
	if(!LAZYLEN(potentials)) // unlikely but hey
		paths = list(/mob/living/carbon/human) // YOU
		return
	var/mob/living/simple_animal/hostile/thing = pick(potentials)
	name = initial(thing.name)
	paths = list(pick(thing)) // guaranteed fresh at time of baking

////SEALED ALCOHOL QUOTA////
/// To make bottlers useful///
// Also a resource sink for bartenders//

/datum/bounty/kill/sealedbottle
	name = "Collect Sealed Alcohol"
	description = "Our workers here are parched, we'll pay good money for quality, sealed alcohols."
	flavor_focus = /obj/item/export/bottle
	weight = 1
	candupe = TRUE
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/sealedbottle/easy,
		/datum/bounty_quota/sealedbottle/medium,
		/datum/bounty_quota/sealedbottle/hard,
		/datum/bounty_quota/sealedbottle/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// BOTTLE QUOTAS /////
/datum/bounty_quota/sealedbottle
	name = "Find some sealed bottles"
	paths = list(
		/obj/item/export/bottle
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(100) // Rely on multipliers for this one
	easy_multiplier = 1.2
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 2 

/datum/bounty_quota/sealedbottle/easy // 240c for 200u
	needed_amount = 2
	pick_this_many = 0
	auto_generate_info = FALSE
	info = "Any sealed bottles."
	paths = list(
		/obj/item/export/bottle
	)
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/sealedbottle/medium // 750c for 500u
	needed_amount = 5
	paths_get_subtypes = TRUE
	pick_this_many = 4
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/sealedbottle/hard // 2000c for 1000u
	needed_amount = 10
	paths_get_subtypes = TRUE
	pick_this_many = 3
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/sealedbottle/cocknballtorture // 4000c for 2000u
	needed_amount = 20
	paths_get_subtypes = TRUE
	difficulty = QUEST_DIFFICULTY_CBT
	pick_this_many = 2

/// Blacksmith trading ///
/// So blacksmiths can like, literally get any money?///
/// POV: You found a single cool knife in a dungeon ///
/*
/datum/bounty/kill/weapons
	name = "Collect Weapons"
	description = "We need some extra weapons for the guild knights, buy, find, or make some."
	flavor_focus = /obj/item/gun || /obj/item/melee
	weight = 1
	candupe = TRUE
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/weapon/easy,
		/datum/bounty_quota/weapon/medium,
		/datum/bounty_quota/weapon/hard,
		/datum/bounty_quota/weapon/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// WEAPON QUOTAS /////
/datum/bounty_quota/weapon
	name = "Find some weapons"
	auto_generate_info = FALSE
	info = "Melee or Ranged weapons"
	paths = list(
		/obj/item/gun, /obj/item/melee
	)
	needed_amount = 10
	pick_this_many = 0
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(15) // Rely on multipliers for this one
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 2

/datum/bounty_quota/weapon/easy 
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/weapon/medium 
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/weapon/hard 
	needed_amount = 30
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/weapon/cocknballtorture 
	needed_amount = 40
	difficulty = QUEST_DIFFICULTY_CBT
*/ // maybe searching through all 400+ guns and melee weapons at once isn't a good idea 
///Farming Stuff, good for farmers
/// Mmhhhhhhhhnghnm MElum :)

/datum/bounty/kill/growns
	name = "Collect Plantmatter"
	description = "We're missing some seeds here at the guild, can you just send us some plants over."
	flavor_focus = /obj/item/reagent_containers/food/snacks/grown
	weight = 1
	candupe = TRUE
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/growns/easy,
		/datum/bounty_quota/growns/medium,
		/datum/bounty_quota/growns/hard,
		/datum/bounty_quota/growns/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// FARMER QUOTAS /////
/datum/bounty_quota/growns
	name = "Find some Plant matter"
	paths = list(
		/obj/item/reagent_containers/food/snacks/grown
	)
	needed_amount = 10
	pick_this_many = 0
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	auto_generate_info = FALSE
	info = "Any raw plant matter such as melons"
	claimdelay = 0.5
	price_per_thing = COINS_TO_CREDITS(2) // Rely on multipliers for this one
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 2

/datum/bounty_quota/growns/easy 
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/growns/medium 
	needed_amount = 100
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/growns/hard 
	needed_amount = 150
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/growns/cocknballtorture 
	needed_amount = 200
	difficulty = QUEST_DIFFICULTY_CBT

///Salvaging Stuff, good for people who have welder blindness
/// Mmhhhhhhhhnghnm Salvj :)

/datum/bounty/kill/salvage
	name = "Collect Salavage"
	description = "We're need more resources, can you send some raw salvage our way."
	flavor_focus = /obj/item/salvage
	weight = 1
	candupe = TRUE
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/salvage/easy,
		/datum/bounty_quota/salvage/medium,
		/datum/bounty_quota/salvage/hard,
		/datum/bounty_quota/salvage/cocknballtorture,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// SALVAGE QUOTAS /////
/datum/bounty_quota/salvage
	name = "Find some raw salvage"
	paths = list(
		/obj/item/salvage/low,
		/obj/item/salvage/high,
		/obj/item/salvage/tool
	)
	needed_amount = 10
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(5) // Rely on multipliers for this one
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 5
	CBT_multiplier = 6

/datum/bounty_quota/salvage/easy 
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/salvage/medium 
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/salvage/hard 
	needed_amount = 20
	paths = list(
		/obj/item/salvage/high,
		/obj/item/salvage/tool
	)
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/salvage/cocknballtorture 
	needed_amount = 30
	paths = list(
		/obj/item/salvage/high,
		/obj/item/salvage/tool
	)
	difficulty = QUEST_DIFFICULTY_CBT

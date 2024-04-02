/* 
 * File:   kill_quests.h
 * Author: joshu the fox
 * license: YIFF Public License
 * Created on September 1, 2012, 1:00 PM
 * 
 * This file contains quests that require the player to kill a certain number of a certain monster.
 *  */

/datum/bounty/kill
	base_reward =         COINS_TO_CREDITS(20)
	medium_reward_bonus = COINS_TO_CREDITS(10)
	hard_reward_bonus =   COINS_TO_CREDITS(20)
	CBT_reward_bonus =    COINS_TO_CREDITS(30)
	flavor_kind = QUEST_KIND_KILL_MOBS
	candupe = FALSE

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
		/datum/bounty_quota/gecko/CBT,
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
	paths_exclude = list(
		/mob/living/simple_animal/hostile/gecko/legacy,
	)
	paths_includes_root = FALSE
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/gecko/hard
	needed_amount = 25
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/gecko/CBT
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
		/datum/bounty_quota/rat/CBT,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// RAT QUOTAS /////
/datum/bounty_quota/rat
	name = "Kill some Rats"
	paths = list(
		/mob/living/simple_animal/hostile/rat,
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
	paths_get_subtypes = FALSE // just the big rats

/datum/bounty_quota/rat/hard
	needed_amount = 30
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/rat/CBT
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
		/datum/bounty_quota/nightstalker/CBT,
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

/datum/bounty_quota/nightstalker/CBT
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Molerats

/datum/bounty/kill/molerats
	name = "Slay some Molerats"
	description = "Molerats are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/molerat
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/molerat/easy,
		/datum/bounty_quota/molerat/medium,
		/datum/bounty_quota/molerat/hard,
		/datum/bounty_quota/molerat/CBT,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// MOLERAT QUOTAS /////
/datum/bounty_quota/molerat
	name = "Kill some Molerats"
	paths = list(
		/mob/living/simple_animal/hostile/molerat,
	)
	needed_amount = 25
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(1)
	easy_multiplier = 1
	medium_multiplier = 2
	hard_multiplier = 3
	CBT_multiplier = 4

/datum/bounty_quota/molerat/easy
	needed_amount = 25
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/molerat/medium
	needed_amount = 35
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/molerat/hard
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/molerat/CBT
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
		/datum/bounty_quota/scorpin/CBT,
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
	price_per_thing = COINS_TO_CREDITS(4)
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

/datum/bounty_quota/scorpin/CBT
	needed_amount = 150
	difficulty = QUEST_DIFFICULTY_CBT

/////////////////////////////////////////////
/////////////////////////////////////////////
// Roachy pillbugs

/datum/bounty/kill/roachypillbugs
	name = "Slay some Roachy Pillbugs"
	description = "Roachy Pillbugs are everywhere! I'll pay you to kill some of them."
	flavor_focus = /mob/living/simple_animal/hostile/radroach
	weight = 1
	init_wanteds = list(
		/datum/bounty_quota/roachypillbug/easy,
		/datum/bounty_quota/roachypillbug/medium,
		/datum/bounty_quota/roachypillbug/hard,
		/datum/bounty_quota/roachypillbug/CBT,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// ROACHYPILLBUG QUOTAS /////
/datum/bounty_quota/roachypillbug
	name = "Kill some Roachy Pillbugs"
	paths = list(
		/mob/living/simple_animal/hostile/radroach,
	)
	needed_amount = 40
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(1)
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 2.5

/datum/bounty_quota/roachypillbug/easy
	needed_amount = 20
	difficulty = QUEST_DIFFICULTY_EASY

/datum/bounty_quota/roachypillbug/medium
	needed_amount = 40
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/roachypillbug/hard
	needed_amount = 60
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/roachypillbug/CBT
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
		/datum/bounty_quota/ghoul/CBT,
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
	price_per_thing = COINS_TO_CREDITS(3)
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
	paths_includes_root = FALSE // just the big ghouls

/datum/bounty_quota/ghoul/hard
	needed_amount = 15
	difficulty = QUEST_DIFFICULTY_HARD
	paths_includes_root = FALSE // just the big ghouls

/datum/bounty_quota/ghoul/CBT
	needed_amount = 50
	difficulty = QUEST_DIFFICULTY_CBT
	paths_includes_root = FALSE // just the big ghouls

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
		/datum/bounty_quota/ant/CBT,
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
	price_per_thing = COINS_TO_CREDITS(4)
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

/datum/bounty_quota/ant/CBT
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
		/datum/bounty_quota/supermutant/CBT,
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
	price_per_thing = COINS_TO_CREDITS(8)
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

/datum/bounty_quota/supermutant/CBT
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
		/datum/bounty_quota/bloatfly/CBT,
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
	price_per_thing = COINS_TO_CREDITS(1)
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

/datum/bounty_quota/bloatfly/CBT
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
		/datum/bounty_quota/hellpig/CBT,
	)
	difficulty = QUEST_DIFFICULTY_EASY | QUEST_DIFFICULTY_MED | QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

///// HELLPIG QUOTAS /////
/datum/bounty_quota/hellpig
	name = "Kill some Hellpigs"
	paths = list(
		/mob/living/simple_animal/hostile/hellpig,
	)
	needed_amount = 1
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS_TO_CREDITS(15)
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

/datum/bounty_quota/hellpig/CBT
	needed_amount = 10
	difficulty = QUEST_DIFFICULTY_CBT


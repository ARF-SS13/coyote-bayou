/* 
 * File:   kill_boss_quests.h
 * Author: joshu the fox
 * license: YIFF Public License
 * Created on September 1, 2012, 1:00 PM
 * 
 * This file contains quests that require the player to kill a specific guy.
 *  */

/datum/bounty/kill_boss
	base_reward =         COINS(300)
	medium_reward_bonus = COINS(0)
	hard_reward_bonus =   COINS(0)
	CBT_reward_bonus =    COINS(0)
	flavor_kind = QUEST_KIND_KILL_BOSS
	candupe = FALSE
	respect_extinction = TRUE

/datum/bounty_quota/kill_boss
	needed_amount = 1
	mobs_must_be_dead = TRUE
	delete_thing = FALSE
	paths_get_subtypes = FALSE
	paths_includes_root = TRUE

/////////////////// ACTUAL QUESTS //////////////////////

/////////////////// MANGO MATT //////////////////////
/datum/bounty/kill_boss/mango_matt
	name = "Mango Matt and his Merry Meth Madlads Must be Maimed"
	description = "Mango Matt is a dangerous criminal who has been terrorizing the galaxy. He must be stopped."
	flavor_focus = /mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(/datum/bounty_quota/kill_boss/mango_matt)
	difficulty = QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

/datum/bounty_quota/kill_boss/mango_matt
	name = "Defeat Mango Matt"
	flavor = "If it looks like he enjoys being shot, that's cus he does."
	paths=list(
		/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt
	)
	price_per_thing = COINS(300)

/////////////////// BLUEBERRY BATES //////////////////////
/datum/bounty/kill_boss/blueberry_bates
	name = "Blueberry Bates and his Band of Bandits Must be Brought Down"
	description = "Blueberry Bates is a notorious space pirate who has been causing trouble for the galaxy with his ridiculous prices. He must be stopped."
	flavor_focus = /mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(/datum/bounty_quota/kill_boss/blueberry_bates)
	difficulty = QUEST_DIFFICULTY_HARD | QUEST_DIFFICULTY_CBT

/datum/bounty_quota/kill_boss/blueberry_bates
	name = "Defeat Blueberry Bates"
	flavor = "He loves fire, cus he's a moth. He's also got a lot of friends, who love to die for him. They do it all the time."
	paths=list(
		/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates
	)
	price_per_thing = COINS(300)

/////////////////// GENERIC RAIDER BOSS //////////////////////
/datum/bounty/kill_boss/generic_raider_boss
	name = "Machinegun Martha and her Many Marthas Must be Mowed Down"
	description = "Yet another of Machinegun Martha's clones has been making trouble for the galaxy. She must be stopped. Again."
	flavor_focus = /mob/living/simple_animal/hostile/raider/ranged/boss
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(/datum/bounty_quota/kill_boss/generic_raider_boss)
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/kill_boss/generic_raider_boss
	name = "Defeat Machinegun Martha"
	flavor = "She's got a lot of clones, but they're all the same, down to the wrinkles on her combat armor. They also carry a deadly SMG, just FYI."
	paths=list(
		/mob/living/simple_animal/hostile/raider/ranged/boss
	)
	price_per_thing = COINS(250)

/////////////////// GENERIC RAIDER LEGENDARY //////////////////////
/datum/bounty/kill_boss/generic_raider_legendary
	name = "Legendary Lenny and his Loyal Lennies Must be Laid Low"
	description = "The Legendary Lennies are a group of loose-jocked fanboys of the 'Legendary Lenny' who have been causing trouble for Legendary Lenny. They must be stopped."
	flavor_focus = /mob/living/simple_animal/hostile/raider/legendary
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(/datum/bounty_quota/kill_boss/generic_raider_legendary)
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/kill_boss/generic_raider_legendary
	name = "Defeat a Legendary Lenny"
	flavor = "They're not actually named Lenny, but they are just as annoying as the real deal. He's got a knife, but yours is probably bigger."
	paths=list(
		/mob/living/simple_animal/hostile/raider/legendary
	)
	price_per_thing = COINS(200)

/////////////////// SHAMBLING ABOMINATION //////////////////////
/datum/bounty/kill_boss/shambling_abomination
	name = "Disable and Retrieve 'Super Ghoul'"
	description = "Red Star have been experimenting with the undead, and they're not sharing. Go break into their lab and subdue one of their latest creations."
	flavor_focus = /mob/living/simple_animal/hostile/abomination
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(/datum/bounty_quota/kill_boss/shambling_abomination)

/datum/bounty_quota/kill_boss/shambling_abomination
	name = "Disable and Retrieve 'Super Ghoul'"
	flavor = "Check out the southwestern wing of the Old Nash Underground. You'll find the lab there. Bring lots of ammo. Serously."
	paths=list(
		/mob/living/simple_animal/hostile/abomination,
		/mob/living/simple_animal/hostile/abomhorror
	)
	price_per_thing = COINS(300)

/////////////////// LEGENDARY SUPERMUTANT //////////////////////
/datum/bounty/kill_boss/legendary_supermutant
	name = "Legendary Supermutant"
	description = "The Legendary Supermutant is a dangerous foe, and has been causing trouble for the galaxy. He must be stopped."
	flavor_focus = /mob/living/simple_animal/hostile/supermutant/legendary
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(/datum/bounty_quota/kill_boss/legendary_supermutant)
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/kill_boss/legendary_supermutant
	name = "Defeat the Legendary Supermutant"
	flavor = "He's big, he's green, and he's actually kinda yellowish."
	paths=list(
		/mob/living/simple_animal/hostile/supermutant/legendary
	)
	price_per_thing = COINS(200)

// /datum/bounty/kill_boss/project99
// 	name = "Dethrone Lady Vox and Lord Nagafen"
// 	description = "Ever since our worlds collided and the Sleeper slain, Lady Vox and Lord Nagafen have been plotting to breed a new Spectral Dragon 
// 		and reshape these lands in their image. An image that does not include us. The."
// 	flavor_focus = /mob/living/simple_animal/hostile/supermutant/legendary
// 	weight = 1
// 	request_mode = QUEST_FULFILL_ALL
// 	init_wanteds = list(/datum/bounty_quota/kill_boss/legendary_supermutant)
// 	difficulty = QUEST_DIFFICULTY_GUARANTEED | QUEST_DIFFICULTY_CBT // HELL YEAH GUARANTEED cocknballtorture




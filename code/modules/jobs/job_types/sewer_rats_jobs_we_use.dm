/* 
 * File:   sewer_rats_jobs_we_use.dm
 * Author: She said it was okay to use this file.
 * Date: 2019-07-01
 * License: She said it was okay to use this file.
 * 
 * Description: This file contains the sewer rats jobs that we use.
 * Purpose: To provide a list of jobs that the sewer rats can use.
 * Platform: Dream Maker Language
 * Project: SS13 demake
 * 
 * She's a good person.
 *  */

/datum/job/tunnelrats
	flag = F13RAIDER
	faction = FACTION_RAT
	total_positions = -1
	spawn_positions = -1
	selection_color = "#df80af"
	paycheck = 75
	outfit = /datum/outfit/job/cb/tunnelrats
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

/datum/job/tunnelrats/after_spawn(mob/living/spawner, mob/client_holder, latejoin = FALSE)
	SSquirks.AddQuirkToMob(spawner, /datum/quirk/ratmaster, TRUE, TRUE)
	. = ..()

////////////////////////
// Tunnel Rats Giant Rat
// The leader of the Tunnel Rats.
/datum/job/tunnelrats/bigratthatmakestherules
	title = "Giant Tunnel Rat Supreme"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/cb/tunnelrats/boss
	description = "You are the Giant Tunnel Rat Supreme, the leader of the Tunnel Rats. You're the most rat of them all, and all your gross ratlings look up to you for guidance."
	supervisors = "you!"
	paycheck = 400
	selection_color = "#FF00FF"
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats C.H.U.D.
// A Tunnel Rat who specializes in the use of the C.H.U.D. system.
/datum/job/tunnelrats/chud
	title = "Tunnel Rats Chud" //I swear to god. ~TK
	description = "You are a Tunnel Rat Chud, which is sort of like a guard.  Be you a bully or a strong arm of justice you protect your little hole in the ground."
	supervisors = "Giant Rat Supreme"
	total_positions = 3
	spawn_positions = 3
	paycheck = 200
	exp_requirements = PLAYTIME_HEAD_JOB
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats scav
// The tunnel rat townsfolk, basically.
/datum/job/tunnelrats/scav
	title = "Tunnel Rats Scav"
	description = "You are a Tunnel Rat scavenger. You're expected to hang out in your town."
	supervisors = "Giant Rat Supreme & the Chuds"
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats Runner
// The tunnel rat adventurer
/datum/job/tunnelrats/adventurer
	title = "Tunnel Rats Runner"
	description = "You are a Tunnel Rat Runner. You are some sort of adventurer your life revolves trying to survive in your little underground hovel."
	supervisors = "Giant Rat Supreme & the Chuds"
	paycheck = 25
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats Swiller
// The tunnel rat barkeep
/datum/job/tunnelrats/barkeep
	title = "Tunnel Rats Swiller"
	description = "You run the little bar in the Tunnel Rats area."
	supervisors = "Giant Rat Supreme & the Chuds"
	total_positions = 2
	spawn_positions = 2
	paycheck = 100
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats Techy
// The tunnel rat scientist
/datum/job/tunnelrats/scientist
	title = "Tunnel Rats Techy"
	description = "With help from the Reclaimers you help research the things that your adventurers find. Your servers are tied into the New Boston ones, so if they prosper so do you..."
	supervisors = "Giant Rat Supreme & the Chuds"
	total_positions = 3
	spawn_positions = 3
	paycheck = 150
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats Patcher
// The tunnel rat doctor
/datum/job/tunnelrats/doctor
	title = "Tunnel Rats Patcher"
	description = "You run the clinic in the sewers, it's not great but someone has to do it."
	supervisors = "Giant Rat Supreme & the Chuds"
	total_positions = 2
	spawn_positions = 2
	paycheck = 250
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats Tart
// The tunnel sex worker
/datum/job/tunnelrats/sexworker
	title = "Tunnel Rats Tart"
	description = "You are one of the Tunnel Rats tarts, a group that sell themselves for others pleasure."
	supervisors = "Giant Rat Supreme & the Chuds"
	total_positions = 4
	spawn_positions = 4
	paycheck = 200
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////////////
// Tunnel Rats Digger
// The tunnel rat miner
/datum/job/tunnelrats/miner
	title = "Tunnel Rats Digger"
	description = "You dig the holes and fight the ants. The tunnel rats owe everything to you, or so you tell people."
	supervisors = "Giant Rat Supreme & the Chuds"
	total_positions = 2
	spawn_positions = 2
	paycheck = 80
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING


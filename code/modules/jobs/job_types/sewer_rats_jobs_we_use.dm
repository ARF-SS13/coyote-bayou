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
	outfit = /datum/outfit/job/cb/tunnelrats
	exp_type = EXP_TYPE_LIVING
	exp_requirements = 1

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
	selection_color = "#FF00FF"

////////////////////////
// Tunnel Rats C.H.U.D.
// A Tunnel Rat who specializes in the use of the C.H.U.D. system.
/datum/job/tunnelrats/chud
	title = "Tunnel Rats Chud" //I swear to god. ~TK
	description = "You are a Tunnel Rat Chud, which is sort of like a guard.  Be you a bully or a strong arm of justice you protect your little hole in the ground."
	supervisors = "Giant Rat Supreme"
	total_positions = 3
	spawn_positions = 3

////////////////////////
// Tunnel Rats scav
// The tunnel rat townsfolk, basically.
/datum/job/tunnelrats/scav
	title = "Tunnel Rats Scav"
	description = "You are a Tunnel Rat scavenger. Be you a townsfolk or some sort of adventurer your life revolves trying to survive in your little underground hovel."
	supervisors = "Giant Rat Supreme & the Chuds"


//////////////////////////////////////////////////////////////////////////////////
//////////////////////// OUTFITS /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// BASE TUNNEL RAT OUTFIT
////////////////////////
/// machete, welding helmet, technophreak, better meds I guess???
/datum/outfit/job/cb/tunnelrats
	name = "Tunnel Rats Base"
	jobtype = /datum/job/tunnelrats

	box = /obj/item/storage/survivalkit/medical
	head = /obj/item/clothing/head/welding/up
	suit_store = /obj/item/melee/onehanded/machete
	technophreak = TRUE

////////////////////////
// TUNNEL RAT BOSS OUTFIT
////////////////////////
/// machete, welding mask, technophreak, better meds I guess???
/datum/outfit/job/cb/tunnelrats/boss
	name = "Tunnel Rats Giant Rat"
	jobtype = /datum/job/tunnelrats/bigratthatmakestherules

	box = /obj/item/storage/survivalkit/medical/follower
	head = null
	mask = /obj/item/clothing/mask/gas/welding/up
	suit_store = /obj/item/melee/onehanded/machete/forgedmachete

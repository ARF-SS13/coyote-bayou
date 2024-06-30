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
	exp_type = EXP_TYPE_LIVING
	exp_requirements = 1

////////////////////////
// Tunnel Rats C.H.U.D.
// A Tunnel Rat who specializes in the use of the C.H.U.D. system.
/datum/job/tunnelrats/chud
	title = "Tunnel Rats C.H.U.D." //I swear to god. ~TK
	description = "You are a Tunnel Rat who specializes in the use of the C.H.U.D. system: an advanced way to navigate the tunnels and caves of the wasteland to be the top cannibalistic humanoid underground dweller."
	supervisors = "C.H.U.D. Supervisor Giant Rat Supreme"

////////////////////////
// Tunnel Rats scav
// A Tunnel Rat who specializes in the use of the scav system.
/datum/job/tunnelrats/scav
	title = "Tunnel Rats S.C.A.V."
	description = "You are a Tunnel Rat who specializes in the use of the S.C.A.V. system: a state of the art methodology of wallowing in the filth of the underwastes to be the top scrumf."
	supervisors = "S.C.A.V. Supervisor Giant Rat Supreme"

////////////////////////
// Tunnel Rats Rat
// A Tunnel Rat who specializes in the use of the Rat system.
/datum/job/tunnelrats/rat
	title = "Tunnel Rats R.A.T."
	description = "You are a Tunnel Rat who specializes in the use of the R.A.T. system: a cutting edge way to be a rat."
	supervisors = "R.A.T. Supervisor Giant Rat Supreme"

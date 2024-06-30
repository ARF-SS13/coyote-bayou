/* 
 * File:   den_jobs_we_use.dm
 * Author: 1
 * Date: 2019-07-10
 * 
 * Description: 1
 *  
 *  */

//////////////////////////////JOBS//////////////////////////////////////////////

////////////////
// Den Citizen
// Some Denizen of the Den
/datum/job/den
	title = "Den Citizen"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a citizen of the Den, a cozy little rooftop town tucked away between a prison full of Renegades and a radioactive powerplant full of robots. Despite being right in the middle of the hottest spots in the wasteland, life in the Den is pretty chill. It even has a donut shop!"
	supervisors = "yourself"
	total_positions = -1
	spawn_positions = -1
	outfit = /datum/outfit/job/wasteland/ashdown
	exp_type = EXP_TYPE_LIVING
	exp_requirements = 1
	selection_color = "#2244FF"
	outfit = /datum/outfit/wasteland
	paycheck = 75

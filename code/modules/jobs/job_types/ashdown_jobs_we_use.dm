/* 
 * File:   ashdown_jobs_we_use.dm
 * Author: Ashleigh Downe
 * Date: 2019-02-26
 * 
 * Description: This file is used to define the jobs that are used in the game. 
 * This file is used to define the jobs that are used in the game.
 * The jobs are defined to be jobs that Ashleigh Downe uses in her games.
 * I am Ashleigh Downe and I am the author of this file.
 * Screw off why not???
 *  */

//////////////////////////////JOBS//////////////////////////////////////////////

//////////////////////////////
/// Ashdown Jobs
/// These are the jobs that Ashleigh Downe uses in her games.
/datum/job/ashdown
	title = "Ashdown Citizen"
	description = "You are a citizen of Ashdown, a small town off in the swampy boonies around Redlick. Ya'll ain't got much, that's what sets you apart from the rest of the dang 'ol New Boston folk. No Guild to push you around, no fancy-shmancy Reclaimers waving around their degrees. Just you, your neighbors, and the wide open swamp to make your own."
	supervisors = "yourself"
	total_positions = -1
	spawn_positions = -1
	outfit = /datum/outfit/job/wasteland/ashdown
	faction = FACTION_ASHDOWN
	exp_type = EXP_TYPE_LIVING
	exp_requirements = 1
	selection_color = "#2244FF"
	outfit = /datum/outfit/wasteland
	paycheck = 75

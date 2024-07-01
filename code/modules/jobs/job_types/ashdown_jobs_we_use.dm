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
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING
	selection_color = "#ff915e"
	paycheck = 75


//////////////////////////////
/// An ashdown biker!
/// They ride their cow wife with pride
/datum/job/ashdown/biker
	title = "Hells Nomad"
	department_flag = KHAN
	faction = FACTION_BIKER
	total_positions = 4
	spawn_positions = 4
	outfit = /datum/outfit/job/biker
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING
	//whitelist_path = "strings/job_whitelist/biker.txt"
	/// They get tattoos, which are *basically* access
	//access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)
	//minimal_access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)

/// The boss of the cowbikers (unused, for now)
/datum/job/ashdown/biker/boss
	title = "Overbiker"
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_BIKER
	exp_type = EXP_TYPE_LIVING
	total_positions = 1
	spawn_positions = 1
	exp_requirements = PLAYTIME_ALT_TOWN_BOSS
	exp_type = EXP_TYPE_LIVING
	//access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)
	//minimal_access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)









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
	title = "Ashdown Artisan"
	description = "You are a citizen of Ashdown, a small town off in the swampy boonies around Redlick. Ya'll ain't got much, that's what sets you apart from the rest of the dang 'ol New Boston folk. No Guild to push you around, no fancy-shmancy Reclaimers waving around their degrees. Just you, your neighbors, and the wide open swamp to make your own."
	supervisors = "the Knights and the Viceroy."
	total_positions = -1
	spawn_positions = -1
	outfit = /datum/outfit/job/cb/ashdown
	faction = FACTION_ASHDOWN
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING
	selection_color = "#ff915e"
	paycheck = 75


//////////////////////////////
/// An ashdown knight!
/// ashdown guard
/datum/job/ashdown/squire
	title = "Ashdown Squire"
	department_flag = KHAN
	faction = FACTION_BIKER
	description = "To be set by Jaeger."
	supervisors = "the Viceroy."
	total_positions = -1
	spawn_positions = -1
	paycheck = 25
	outfit = /datum/outfit/job/cb/ashdown
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING
	//whitelist_path = "strings/job_whitelist/biker.txt"
	/// They get tattoos, which are *basically* access
	//access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)
	//minimal_access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)

//////////////////////////////
/// An ashdown viceroy!
/// ashdown leader
/datum/job/ashdown/viceroy
	title = "Ashdown Viceroy"
	department_flag = KHAN
	faction = FACTION_BIKER
	description = "To be set by Jaeger."
	supervisors = "Yourself."
	total_positions = 1
	spawn_positions = 1
	paycheck = 300
	outfit = /datum/outfit/job/cb/ashdown
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// An ashdown canteen worker!
/// ashdown canteen worker
/datum/job/ashdown/canteenworker
	title = "Ashdown Canteen Worker"
	department_flag = KHAN
	faction = FACTION_BIKER
	description = "To be set by Jaeger."
	supervisors = "the Knights and the Viceroy."
	total_positions = 3
	spawn_positions = 3
	paycheck = 150
	outfit = /datum/outfit/job/cb/ashdown
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// An ashdown scarlet
/// ashdown sex worker
/datum/job/ashdown/scarlet
	title = "Ashdown Scarlet"
	department_flag = KHAN
	faction = FACTION_BIKER
	description = "To be set by Jaeger."
	supervisors = "the Knights and the Viceroy."
	total_positions = 4
	spawn_positions = 4
	paycheck = 200
	outfit = /datum/outfit/job/cb/ashdown
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// An ashdown artiste
/// ashdown artist
/datum/job/ashdown/artiste
	title = "Ashdown Artiste"
	department_flag = KHAN
	faction = FACTION_BIKER
	description = "To be set by Jaeger."
	supervisors = "the Knights and the Viceroy."
	total_positions = 2
	spawn_positions = 2
	paycheck = 350
	outfit = /datum/outfit/job/cb/ashdown
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// An ashdown silvereye
/// ashdown miner
/datum/job/ashdown/silvereye
	title = "Ashdown Silvereye"
	department_flag = KHAN
	faction = FACTION_BIKER
	description = "To be set by Jaeger."
	supervisors = "the Knights and the Viceroy."
	total_positions = 3
	spawn_positions = 3
	paycheck = 150
	outfit = /datum/outfit/job/cb/ashdown
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING



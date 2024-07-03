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
	supervisors = "The Den Keepers & Den Heirophant"
	total_positions = -1
	spawn_positions = -1
	outfit = /datum/outfit/job/cb
	selection_color = "#2244FF"
	paycheck = 75
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

/datum/job/den/adventurer
	title = "Den Seeker"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a Seeker of the Den, a cozy little rooftop town tucked away between a prison full of Renegades and a radioactive powerplant full of robots. You are expected to go out and find loot, complete quests, and work to increase the glory of the town."
	supervisors = "The Den Keepers & Den Heirophant"
	total_positions = -1
	spawn_positions = -1
	outfit = /datum/outfit/job/cb
	selection_color = "#2244FF"
	paycheck = 30
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////
// Den Siren
// Den sex worker
/datum/job/den/siren
	title = "Den Siren"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are one of the workers who help lure people into the Dens club.  To remove their pants and lighten their sacks."
	supervisors = "The Den Keepers & Den Heirophant"
	total_positions = 3
	spawn_positions = 3
	outfit = /datum/outfit/job/cb
	paycheck = 200
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING


////////////////
// Den Miner
// A miner, den flavored
/datum/job/den/miner
	title = "Den Miner"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a citizen of the Den, a cozy little rooftop town tucked away between a prison full of Renegades and a radioactive powerplant full of robots. Despite being right in the middle of the hottest spots in the wasteland, life in the Den is pretty chill. It even has a donut shop!  Which you never get to see, because you're too busy mining."
	supervisors = "The Den Keepers & Den Heirophant"
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/cb
	paycheck = 150
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////
// Den Tavern Worker
// A tavern worker for the Den.
/datum/job/den/tavernworker
	title = "Den Tavern Worker"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a citizen of the Den.  Working specifically in their bar!"
	supervisors = "The Den Keepers & Den Heirophant"
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/cb
	selection_color = "#FFFF00"
	paycheck = 100
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////
// Den Healer
// A healer in the Den
/datum/job/den/healer
	title = "Den Healer"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a citizen of the Den.  Working specifically in their medical area!"
	supervisors = "The Den Keepers & Den Heirophant"
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/cb
	selection_color = "#FF00FF"
	paycheck = 250
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////
// Den Donuteer
// The keeper of the donut shop
/datum/job/den/donuteer
	title = "Den Donuteer"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a citizen of the Den, a cozy little rooftop town tucked away between a prison full of Renegades and a radioactive powerplant full of robots. You run the donut shop!  A donuteer!  A sugary warlord!"
	supervisors = "The Den Keepers & Den Heirophant"
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/cb
	selection_color = "#2244FF"
	paycheck = 100
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

////////////////
// Den Keeper
// The guards of the Den.
/datum/job/den/keeper
	title = "Den Keeper"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a citizen-guard of the Den, a cozy little rooftop town tucked away between a prison full of Renegades and a radioactive powerplant full of robots. You keep the peace, and do as the Monarchs say."
	supervisors = "The Den Heirophant"
	total_positions = 4
	spawn_positions = 4
	outfit = /datum/outfit/job/cb
	selection_color = "#2244FF"
	paycheck = 150
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD

////////////////
// Den Hierophant
// The leader of the Den.
/datum/job/den/hierophant
	title = "Den Hierophant"
	flag = F13WASTEDEN
	faction = FACTION_DEN
	description = "You are a member of the Dens leadership.  Today you are in charge, but tomorrow...?"
	supervisors = "The will of the people."
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/cb
	selection_color = "#2244FF"
	paycheck = 300
	exp_requirements = PLAYTIME_ALT_TOWN_BOSS

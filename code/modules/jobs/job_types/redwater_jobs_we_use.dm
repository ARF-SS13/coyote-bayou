/* 
 * File:   redwater_jobs_we_use.dm
 * Author: John Redwater
 * Created on 2010-07-07, 12:00 PM
 *  */

//////////////////////////////JOBS//////////////////////////////////////////////

//////////////////////////////
/// Redwater Jobs
/// Rude, crude, and off the chain.
/datum/job/redwater
	faction = FACTION_REDWATER
	exp_type = EXP_TYPE_LIVING
	exp_requirements = 1
	forbids = "HEY! New Boston is off limits!"
	total_positions = -1
	spawn_positions = -1
	selection_color = "#dcba97"
	access = list()
	minimal_access = list()
	paycheck = 75
	outfit = /datum/outfit/job/cb/redwater
	exp_requirements = PLAYTIME_ALT_TOWN_CITIZEN
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// Redwater Townie
/// Your everyday Redwater 'citizen'.
/datum/job/redwater/townie
	title = "Redwater Townie"
	description = "You're a Redwater townie, your everyday 'citizen' of Redwater. Whether you're a low-level grundlesnatch or just someone who likes to chill with the prostitutinest folks this side of the River of Flame, one thing's for sure: Redwater is your home."
	supervisors = "Redwater's Watchers & Overboss"

//////////////////////////////
/// Redwater Outrider
/// Your everyday Redwater 'adventurer''.
/datum/job/redwater/outrider
	title = "Redwater Outrider"
	paycheck = 25
	description = "You're a Redwater Outrider, you are one of the folks who goes out and messes with stuff."
	supervisors = "Redwater's Watchers & Overboss"

//////////////////////////////
/// Redwater Sawbones
/// Your everyday Redwater """Doctor""".
/datum/job/redwater/sawbones
	title = "Redwater Sawbones"
	total_positions = 1
	spawn_positions = 1
	paycheck = 300
	description = "You're a Redwater Sawbones, you patch folks up!"
	supervisors = "Redwater's Watchers & Overboss"

//////////////////////////////
/// Redwater Cooker
/// Your everyday Redwater """Chemist""".
/datum/job/redwater/cooker
	title = "Redwater Cooker"
	total_positions = 2
	spawn_positions = 2
	paycheck = 100
	description = "You're a Redwater Cooker, you do chemistry... or something very nearly like it."
	supervisors = "Redwater's Watchers & Overboss"

//////////////////////////////
/// Club Bartender
/// Your everyday Redwater Bartender.
/datum/job/redwater/bartender
	title = "Redwater Bartender"
	total_positions = 2
	spawn_positions = 2
	paycheck = 100
	description = "You're a Redwater Bartender, you serve drinks in the club and probably fondle the merchandise."
	supervisors = "Redwater's Watchers & Overboss"

//////////////////////////////
/// Redwater Prostitute
/// Humpster in the dumpster.
/datum/job/redwater/prostitute
	title = "Redwater Prostitute"
	supervisors = "Redwater's Watchers & Overboss"
	description = "You're one of Redwater's finest, a prostitute who sells their body for the good of the gang. Your job as a prostitutional technician is to utilize your brothular expertise to provide your clients with the highest quality of service and satisfaction, safely and efficiently, as per EEOC '99 guidelines. For more information, please consult the Redwater Prostitutional Procedures Manual, which currently doesn't exist because Redwater plays by its own rules."

//////////////////////////////
/// Redwater Watcher
/// A goon who guards the Redwater turf.
/datum/job/redwater/pimp
	title = "Redwater Watcher"
	supervisors = "Redwater's <i>finest</i>"
	description = "You're a Redwater Watcher, one of the strongarm goons who keeps the Redwater turf safe from the scum of the earth. You're the muscle, the brawn, the one who keeps the peace in the streets. You're the one who makes sure that the Redwater Raiders are the only ones who run the show in this town."
	exp_requirements = PLAYTIME_ALT_TOWN_HEAD
	exp_type = EXP_TYPE_LIVING

//////////////////////////////
/// Redwater Overboss
/// The leader of the Redwater Raiders.
/datum/job/redwater/overboss
	title = "Redwater Overboss"
	flag = F13MOBBOSS
	total_positions = 1
	spawn_positions = 1
	description = "You're the boss of Redwater's operations. You're the one who makes the big decisions and the one who everyone looks up to. When your pimps have an issue, you'll be there."
	supervisors = "fate"
	selection_color = "#df80af"
	exp_requirements = PLAYTIME_ALT_TOWN_BOSS
	exp_type = EXP_TYPE_LIVING

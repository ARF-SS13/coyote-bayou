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
	outfit = /datum/outfit/wasteland
	access = list()
	minimal_access = list()
	paycheck = 75

//////////////////////////////
/// Redwater Townie
/// Your everyday Redwater 'citizen'.
/datum/job/redwater/townie
	title = "Redwater Townie"
	description = "You're a Redwater townie, your everyday 'citizen' of Redwater. Whether you're a low-level grundlesnatch or just someone who likes to chill with the prostitutinest folks this side of the River of Flame, one thing's for sure: Redwater is your home."
	supervisors = "Redwater's finest"

//////////////////////////////
/// Redwater Prostitute
/// Humpster in the dumpster.
/datum/job/redwater/prostitute
	title = "Redwater Prostitute"
	supervisors = "Redwater's <i>finest</i>"
	description = "You're one of Redwater's finest, a prostitute who sells their body for the good of the gang. Your job as a prostitutional technician is to utilize your brothular expertise to provide your clients with the highest quality of service and satisfaction, safely and efficiently, as per EEOC '99 guidelines. For more information, please consult the Redwater Prostitutional Procedures Manual, which currently doesn't exist because Redwater plays by its own rules."

//////////////////////////////
/// Redwater Pimp
/// The regional manager of the Redwater prostitutes.
/datum/job/redwater/pimp
	title = "Redwater Pimp"
	supervisors = "Redwater's <i>finest</i>"
	description = "You're a pimp, the regional manager of the Redwater prostitutes. You're the one who runs and operates the brothular aspects of Redwater, ensuring that your prostitutional technicians meet or exceed regional standards of service and satisfaction, safely and efficiently, as per EEOC '99 guidelines. For more information, please consult the Redwater Prostitutional Procedures Manual, which currently doesn't exist because Redwater plays by its own rules."

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


/* 
 * filename: rts_order_processor.dm
 * author: [zYxPl(+)t~Dr1lL3rZxYz]-71reKzPr(0)nYSm00z34n00bpwRnQtZ-B=IGMAC===]~~~'o'_@
 * date: 2011.12.10
 * license: none
 * description:
 * Interior crocodile alligator, this is an RTS order processor
 * Handles propagating, updating, and executing orders for dopey simplemob RTS units.
 * Processes what was right-clicked on, be it a single tile, a mob, or a huge glonch of tiles.
 * 
 * Main hourdle of this is the system for issuing destination tiles to mobs.
 * If we have a lot of units selected (which you will cus why wouldnt you),
 * we'll want each of them have their own destination tile, if possible
 * 
 * Also handles updating our mobs' order datum, which they'll use to figure out what to do.
 * And by figure out what to do, I mean run to the destination and smash everything in their way.
 * (that part will be handled by the order datum, not this file)
 * 
 * Lets also have some modifier keys to modify the orders we give to our units.
 * Shift will make them explicitly attack the destination atom(s) if they can.
 * Control will make them follow the destination atom(s) if they can.
 * 
 *  */

/datum/rts_order_processor
	var/datum/rts_commander/parent
	var/working = FALSE
	var/next_smash = 0 // oh man I hope krystal is in this one

/datum/rts_order_processor/New(datum/rts_commander/parent)
	src.parent = parent

/datum/rts_order_processor/Destroy()
	. = ..()

/// polymamorphism
/// Takes in one or two atoms, and a list of parameters, and from that, figures out what to do.
/// One atom means we're right-clicking on a single atom, two means we've selected a range of tiles. (hi im tiles the beaver)
/// The parameters are everything relating to the type of rightclick we're doing, like if we're holding shift or control, maybe even alt.
/datum/rts_order_processor/proc/ProcessMouseUp(atom/AoI1, atom/AoI2, params)
	if(!AoI1 && !AoI2)
		return // no atoms to right-click on, no orders to give
	// var/list/destination_turfs = list()
	// var/list/attack_atoms = list()
	/// someday this w2ill do something interesting, but for now, it just handles a single-tile right-click
	///check the keys, we cant use params, cus we've *released* the key
	if(parent.right_is_down)
		if(parent.ctrl_is_down)
			IssueCtrlRightCommand(AoI1, AoI2)
		else if(parent.shift_is_down)
			IssueShiftRightCommand(AoI1, AoI2)
		else if(parent.alt_is_down)
			IssueAltRightCommand(AoI1, AoI2)
		else
			IssueRightCommand(AoI1, AoI2)
	if(parent.left_is_down)
		IssueLeftCommand(AoI1, AoI2)

/datum/rts_order_processor/proc/ProcessMouseDown(atom/AoI1, atom/AoI2, params)
	return // todo: this

/// We've used the right mouse button on an atom! lets do something with it!
/// first, it goes through everything on the tile (checking the thing clicked first)
/// then, it does something based on what the thing with the highest priority is
/// the thing clicked has highest priority ofc, but
/// if you click on a nest, it'll turn it on! And the stuff that spawns will be unsleeping!
/datum/rts_order_processor/proc/IssueRightCommand(atom/AoI1, atom/AoI2)
	if(!AoI1)
		return
	var/turf/where = get_turf(AoI1)
	if(!where)
		return
	// FrobEverythingOnTile(AoI1)
	if(SendMobsToTile(AoI1))
		return

/datum/rts_order_processor/proc/IssueCtrlRightCommand(atom/AoI1, atom/AoI2)
	if(!AoI1)
		return
	if(!AoI2)
		AoI2 = AoI1
	MakeMobsSmashStuff(AoI1)

/datum/rts_order_processor/proc/IssueShiftRightCommand(atom/AoI1, atom/AoI2)
	if(!AoI1)
		return
	if(!AoI2)
		AoI2 = AoI1
	MakeMobsShootStuff(AoI1)

/datum/rts_order_processor/proc/IssueAltRightCommand(atom/AoI1, atom/AoI2)
	if(!AoI1)
		return
	if(!AoI2)
		AoI2 = AoI1
	// open doors
	FrobEverythingOnTile(AoI1)

/// We've used the left mouse button on an atom! lets do something with it!
/datum/rts_order_processor/proc/IssueLeftCommand(atom/AoI1, atom/AoI2)
	if(!AoI1)
		return
	if(!AoI2)
		AoI2 = AoI1
	FrobAllNests(AoI1, AoI2)

/// Frob all nests in a range
/datum/rts_order_processor/proc/FrobAllNests(atom/AoI1, atom/AoI2)
	if(!AoI1 || !AoI2)
		return
	// var/list/nests = list()
	for(var/turf/T in block(AoI1, AoI2))
		for(var/atom/A in T)
			FrobNest(A)

/// Sends all selected mobs to a tile
/// some day it will differentiate between attack and follow, but for now, it just sends them to the tile
/datum/rts_order_processor/proc/SendMobsToTile(atom/AoI)
	if(world.time < working + (10 SECONDS))
		return
	working = world.time
	for(var/mob/living/simple_animal/L in parent.mysel.selected_mobs)
		L.RTS_move_to_tile(AoI)
		CHECK_TICK
	working = FALSE

/// Frob a nest
/// Turns a nest on, and makes the stuff that spawns from it unsleeping
/datum/rts_order_processor/proc/FrobNest(atom/AoI)
	if(!AoI)
		return
	if(!isnest(AoI))
		return
	. = TRUE
	SEND_SIGNAL(AoI, COMSIG_ATOM_RTS_RIGHTCLICKED, parent.GetCommanderMob())


/// Frob everything on a tile
/// Goes through everything on a tile, and does something with it
/datum/rts_order_processor/proc/FrobEverythingOnTile(atom/AoI)
	if(!AoI)
		return
	var/turf/T = get_turf(AoI)
	for(var/atom/A in T.contents)
		SEND_SIGNAL(A, COMSIG_ATOM_RTS_RIGHTCLICKED, parent.GetCommanderMob())

/// Makes all selected mobs smash stuff
/datum/rts_order_processor/proc/MakeMobsSmashStuff(atom/AoI)
	if(world.time < next_smash)
		return
	next_smash = world.time + (1.5 SECONDS)
	for(var/mob/living/simple_animal/hostile/H in parent.mysel.selected_mobs)
		var/direc = get_dir(H, AoI)
		H.DestroyObjectsInDirection(direc)
		H.DestroyObjectsInDirection(turn(direc, 45))
		H.DestroyObjectsInDirection(turn(direc, -45))
		CHECK_TICK

/// Makes all selected mobs shoot stuff
/datum/rts_order_processor/proc/MakeMobsShootStuff(atom/AoI)
	for(var/mob/living/simple_animal/hostile/H in parent.mysel.selected_mobs)
		H.RangedAttack(AoI)





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

/datum/rts_order_processor/New(datum/rts_commander/parent)
	src.parent = parent

/datum/rts_order_processor/Destroy()
	. = ..()

/// polymamorphism
/// Takes in one or two atoms, and a list of parameters, and from that, figures out what to do.
/// One atom means we're right-clicking on a single atom, two means we've selected a range of tiles. (hi im tiles the beaver)
/// The parameters are everything relating to the type of rightclick we're doing, like if we're holding shift or control, maybe even alt.
/datum/rts_order_processor/proc/ProcessInput(atom/AoI1, atom/AoI2, params)
	if(!LAZYLEN(parent.mysel.selected_mobs))
		return // no mobs selected, no orders to give
	if(!AoI1 && !AoI2)
		return // no atoms to right-click on, no orders to give
	var/list/destination_turfs = list()
	var/list/attack_atoms = list()






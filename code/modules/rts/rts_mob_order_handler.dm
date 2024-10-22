
/* 
 * filename: rts_mob_order_handler.dm
 * author: Xottab-DK (FerrisChat No. 3508 on Discord) [est. 2021-2022]
 * date: 2022-02-22
 * license: public domain (steal this code)
 * description:
 * This is a cute lil datum that holds orders passed by the RTS order manager!
 * It holds things like the destination tile, any targets of interest, general disposition, etc.
 * Mobs (hostiles specifically) will reference this to decide what to do next.
 * 
 * KINDS OF ORDERS:
 * - Movement
 * -- Simple enough, have a mob want to move to a tile
 * -- But not so simple is byond's pathfinding assuming you can walk through windows and squeeze past diagonals
 * -- So we'll probably have to do something about that eventually
 * 
 * - Attack
 * -- Have a mob want to attack a target
 * -- Could be bundled with a movement order to specifically seek out a target on the way to a destination
 * -- Could be used to have ranged mobs attack a target from a distance
 * 
 * - Disposition
 * -- Have a mob act a certain way
 * --- Normal: do nothing special\
 * --- Rumpus: smash things immediately around it
 * --- Riot: Actively seek out smashable things and then smash them
 * --- flee: run away instead of fighting
 * 
 * - Immediate orders
 * -- Have a mob do something right now
 * -- Maybe make the mob spawn a nest, or throw a grenade, or something
 * 
 */
#define MOB_MASTER \
	var/mob/living/simple_animal/master = GET_WEAKREF(my_mob);\
	if(!istype(master)){return}

#define HOSTILE_MASTER \
	var/mob/living/simple_animal/hostile/hosmaster = GET_WEAKREF(my_mob);\
	if(!istype(hosmaster)){return}

#define RTS_DISPOSITION_NORMAL 0
#define RTS_DISPOSITION_RUMPUS 1
#define RTS_DISPOSITION_RIOT 2
#define RTS_DISPOSITION_FLEE 3

#define RTS_MOVE_STATE_NORMAL 0
#define RTS_MOVE_STATE_FRUSTRATED 1

#define RTS_TARGET_MODE_NONE 0
#define RTS_TARGET_MODE_BLINDFIRE 1

/datum/rts_mob_order_handler
	var/datum/weakref/my_mob
	var/datum/weakref/movement_target
	var/datum/weakref/attack_target
	var/disposition = RTS_DISPOSITION_NORMAL
	var/ignore_simplemobs_until = 0
	var/move_frustration = 0
	var/last_move_frustration = 0
	var/last_coords = null
	var/last_dist_to_target = 0
	var/max_move_frustration = 3 SECONDS
	var/move_state = RTS_MOVE_STATE_NORMAL
	var/target_mode = RTS_TARGET_MODE_NONE

/datum/rts_mob_order_handler/New(mob/living/simple_animal/my_mob)
	if(!my_mob)
		qdel(src)
		CRASH("rts_mob_order_handler.New() called with no mob. Whyyyyy")
	if(!istype(my_mob, /mob/living/simple_animal))
		qdel(src)
		CRASH("rts_mob_order_handler can't handle non-simple_animal mobs!")
	src.my_mob = WEAKREF(my_mob)

/datum/rts_mob_order_handler/proc/IssueMovementOrder(atom/movement_target)
	MOB_MASTER
	CancelMovementOrder()
	SetMovementTarget(targettte)
	SetTargetLockout()
	StartMoveing()
	ClearFrustration()

/datum/rts_mob_order_handler/proc/SetMovementTarget(atom/movement_target)
	movement_target = GET_WEAKREF(movement_target)

/datum/rts_mob_order_handler/proc/StartMoveing()
	var/atom/dest = GET_WEAKREF(movement_target)
	if(!dest)
		return
	MOB_MASTER
	if(!CHECK_BITFIELD(master.mobility_flags, MOBILITY_MOVE))
		return
	master.set_glide_size(DELAY_TO_GLIDE_SIZE(master.move_to_delay))
	walk_to(src, dest, master.minimum_distance, master.move_to_delay)

/datum/rts_mob_order_handler/proc/CancelMovementOrder()
	MOB_MASTER
	walk(master, 0)
	movement_target = null

/datum/rts_mob_order_handler/proc/SetTargetLockout()
	ignore_simplemobs_until = world.time + SSrts.aggro_lockout_time

/datum/rts_mob_order_handler/proc/IsLockedOut()
	return world.time < ignore_simplemobs_until

/datum/rts_mob_order_handler/proc/ClearFrustration()
	move_frustration = 0
	last_move_frustration = world.time

/datum/rts_mob_order_handler/proc/CheckFrustration()
	if(!last_coords || !movement_target)
		ClearFrustration()
		return
	MOB_MASTER
	var/atom/dest = GET_WEAKREF(movement_target)
	if(!dest)
		ClearFrustration()
		return
	var/distance = get_dist(master, dest)
	if(distance >= last_dist_to_target)
		Frustrate()
		return
	var/atom/last = coords2turf(last_coords)
	if(!last)
		ClearFrustration()
		return
	var/dist2 = get_dist(master, last)
	if(dist2 <= 1)
		Frustrate()
		return
	last_frustration = world.time

/datum/rts_mob_order_handler/proc/Frustrate()
	move_frustration += world.time - last_move_frustration
	last_move_frustration = world.time
	if(move_frustration >= max_move_frustration)
		BecomeFrustrated()

/// We've been stuck on something for too long, pause the movement and try to get unstuck
/// since we cant exactly modify BYOND's pathfinding, we'll just have them run around in circles for a while
/// then try again
/datum/rts_mob_order_handler/proc/BecomeFrustrated()
	MOB_MASTER
	walk(master, 0)
	move_state = RTS_MOVE_STATE_FRUSTRATED
	move_frustration = 0
	frustration_end = world.time + 10 SECONDS // they are REALLY bad at pathfinding
	walk_rand(master, master.move_to_delay)

/// The main thought process loop!
/datum/rts_mob_order_handler/process()
	HandleTargeting()
	HandleMovement()
	HandleAttack()

/datum/rts_mob_order_handler/proc/HandleMovement()
	if(!AmMoving())
		return
	MOB_MASTER
	if(move_state == RTS_MOVE_STATE_FRUSTRATED)
		// first check if we should still be frustrated
		if(world.time >= frustration_end)
			move_state = RTS_MOVE_STATE_NORMAL
			ClearFrustration()
			StartMoveing()

/// handles openfiring on a target
/datum/rts_mob_order_handler/proc/HandleTargeting()
	if(!attack_target)
		return
	HOSTILE_MASTER
	var/atom/att = GET_WEAKREF(attack_target)
	if(att)
		/// check if the target is in view
		var/cansee = isInSight(hosmaster, att)
		if(cansee)
			hosmaster.GiveTarget(att) // give the target to the mob
		else
			IssueMovementOrder(att) // move to the target
	if(disposition == RTS_DISPOSITION_RIOT)
		










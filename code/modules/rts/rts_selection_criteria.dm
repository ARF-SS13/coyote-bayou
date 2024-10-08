#define RTS_CF_CAN_SELECT_CLIENTS (1 << 0)
#define RTS_CF_RESPECT_FACTION (1 << 1)
#define RTS_CF_STRICT_FACTION (1 << 2)
#define RTS_CF_ALLOW_DEAD (1 << 3)
#define RTS_CF_REQUIRE_LOS (1 << 4)

/* 
 * filename: rts_criteria.dm
 * author: ULTRASUPERHOTTIEVIXEN (formerly known as XxXKittyGothXxX)
 * date: 2021-09-07
 * license: YIFF PUBLIC LICENSE v0.1
 * 
 * Simple ruleset for whether or not we can select a unit.
 * Critflags enable certain filters, usually for rejecting units.
 * Pulls needed data from the commander datum itself!
 * 
 *  */

/datum/rts_criteria
	var/kind = "default"
	var/datum/rts_commander/parent
	var/ckey
	var/critflags = NONE
	var/is_default = FALSE

/datum/rts_criteria/New(parent, ckey)
	src.parent = parent
	src.ckey = ckey

/* 
* CanSelect
* 
* Returns TRUE if L can be selected.
* 
* @param mob/living/L - the unit to check
* @param params - additional parameters, mostly about keypresses
* @return TRUE/FALSE
*  */
/datum/rts_criteria/proc/CanSelect(mob/living/L, params)
	if(!isliving(L))
		return FALSE
	if(SSrts.debug_criteria)
		return TRUE
	if(L.client && !CHECK_BITFIELD(critflags, RTS_CF_CAN_SELECT_CLIENTS))
		return FALSE
	if(L.client && L.client.ckey == ckey)
		return FALSE // don't select yourself
	if(CHECK_BITFIELD(critflags, RTS_CF_RESPECT_FACTION) && LAZYLEN(parent.my_faction) && LAZYLEN(L.faction))
		var/list/check = list()
		if(CHECK_BITFIELD(critflags, RTS_CF_STRICT_FACTION))
			check |= parent.my_faction ^ L.faction
			if(LAZYLEN(check))
				return FALSE
		else
			check |= parent.my_faction & L.faction
			if(!LAZYLEN(check))
				return FALSE
	if(!CHECK_BITFIELD(critflags, RTS_CF_ALLOW_DEAD) && L.health <= 0)
		return FALSE
	if(CHECK_BITFIELD(critflags, RTS_CF_REQUIRE_LOS))
		var/mob/cmdr = parent.GetCommanderMob()
		var/list/linepath = getline(L, cmdr)
		for(var/turf/T as anything in linepath)
			if(T.opacity)
				return FALSE
			if(T.loc.opacity)
				return FALSE
			for(var/atom/A as anything in T)
				if(A.opacity)
					return FALSE
	return TRUE

/datum/rts_criteria/default
	kind = "Default"
	critflags = NONE // RTS_CF_CAN_SELECT_CLIENTS | RTS_CF_RESPECT_FACTION | RTS_CF_ALLOW_DEAD | RTS_CF_REQUIRE_LOS
	is_default = TRUE // ^ to do: suck it






/* 
 * filename: rts_nest_cooldown_visualizer.dm
 * author: Yiffy the Fox (formerly known as XxXKittyGothXxX)
 * date: 2021-09-07
 * license: YIFF PUBLIC LICENSE v0.1
 * 
 * This file contains the cooldown visualizer for the RTS system.
 * Things like nests and other buildings will have cooldowns, and this will show them to the player!
 */

/datum/rts_nest_cooldown_visualizer
	var/datum/rts_commander/parent
	var/list/nests = list()







/datum/rts_nest_data
	var/datum/weakref/nestref
	var/est_ready = 0
	var/est_start = 0
	var/image/plumbob

/datum/rts_nest_data/New(datum/component/spawner/nesty)
	if(!nesty)
		qdel(src)
		CRASH("rts_nest_data.New() called with no nesty")
	nestref = WEAKREF(nesty)
	est_ready = nesty.rts_next_spawn_time
	est_start = est_ready - nesty.rts_spawn_cd
	plumbob = image('icons/effects/effects.dmi', get_turf(nesty), "nothing")
	UpdateTimer()

/datum/rts_nest_data/proc/UpdateTimer()
	var/datum/component/spawner/nesty = GET_WEAKREF(nestref)
	plumbob.overlays.Cut()
	if(!nesty)
		return // good enuff
	var/timeleft = est_ready - world.time
	var/list/splitnumbers = list()
	/// splits timeleft into its digits, from most to least significant
	if(timeleft <= 0)
		splitnumbers += 0
	else
		var/tries = 10
		while(timeleft > 0 && tries-- > 0)
			splitnumbers += timeleft % 10
			timeleft /= 10
			timeleft = floor(timeleft)
	/// now we have to reverse the list
	splitnumbers = reverseList(splitnumbers)
	var/offset = 0
	/// now we can display the numbers
	for(var/i in 1 to LAZYLEN(splitnumbers))
		var/digy = clamp(LAZYACCESS(splitnumbers, i), 0, 9)
		var/image/numbie = image('icons/effects/numbers.dmi', src, "[digy]")
		numbie.pixel_x = offset
		plumbob.overlays += numbie
		offset += 9


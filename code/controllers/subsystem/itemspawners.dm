SUBSYSTEM_DEF(itemspawners)
	name = "Item Spawners"
	wait = 1 SECONDS
	init_order = INIT_ORDER_ITEMSPAWNERS
	var/cull_spawners_by = 0.5 // 50% of the items will be culled
	var/list/to_cull = list()
	var/restock_trash_interval = 1 HOURS
	COOLDOWN_DECLARE(next_trash_delivery)

/datum/controller/subsystem/itemspawners/Initialize(start_timeofday)
	COOLDOWN_START(src, next_trash_delivery, restock_trash_interval)
	cull_spawners()
	. = ..()

/datum/controller/subsystem/itemspawners/proc/cull_spawners()
	if(!LAZYLEN(to_cull))
		return
	log_world("Culling spawners...")
	var/list/culled = list()
	var/list/outputlines = list()
	var/list/currun = to_cull.Copy()
	to_cull.Cut()
	for(var/cat in currun)
		culled["[cat]"] = list("lived" = 0, "died" = 0)
		var/list/lottery_tickets = currun[cat]
		if(!LAZYLEN(lottery_tickets))
			stack_trace("Culling spawners: [cat] has no tickets.")
			continue
		var/list/unlucky = list()
		var/target_length = round(LAZYLEN(lottery_tickets) * cull_spawners_by, 1)
		while(LAZYLEN(lottery_tickets) > target_length)
			var/obj/effect/spawner/lootdrop/chosen = pick(lottery_tickets)
			lottery_tickets -= chosen
			if(!istype(chosen, /obj/effect/spawner/lootdrop))
				stack_trace("Culling spawners: [chosen] is not a lootdrop.")
				continue
			unlucky += chosen // YOU HAVE BEEN SELECTED!!!
			culled["[cat]"]["died"] += 1
		culled["[cat]"]["lived"] = LAZYLEN(lottery_tickets)
		/// our list has been whittled down, time to kill the survivors
		for(var/obj/effect/spawner/lootdrop/chosen in unlucky)
			qdel(chosen)
		/// and, spawn the survivors
		for(var/obj/effect/spawner/lootdrop/winner in lottery_tickets)
			winner.adjust_tier()
			winner.spawn_the_stuff()
			qdel(winner) // jk you die too lol
		unlucky.Cut()
		lottery_tickets.Cut()
		var/output_line = "\n[cat]: [culled[cat]["died"]] culled, [culled[cat]["lived"]] survived."
		outputlines += output_line
	log_world("Spawner Culling Complete. [outputlines.Join("")]")

/datum/controller/subsystem/itemspawners/proc/add_to_culling(obj/effect/spawner/lootdrop/lootdrop, category = "Unsorted")
	if(!istext(category))
		category = "Unsorted"
	if(!islist(to_cull[category]))
		to_cull[category] = list()
	to_cull[category] += lootdrop

/datum/controller/subsystem/itemspawners/fire(resumed = 0)
//	cleanup_trash()
	restock_trash_piles()
	cull_spawners()

/obj/item
	var/from_trash = FALSE
	///Key of the player who looted me, if at all.
	var/looted_by
	///x,y,z of where I was looted, if at all. format: "x;y;z". Uses params2list to reduce memory usage
	var/looted_coordinates
	/// world.time that this item was looted
	var/looted_when

/datum/controller/subsystem/itemspawners/proc/restock_trash_piles()
	if(!COOLDOWN_FINISHED(src, next_trash_delivery))
		return
	COOLDOWN_START(src, next_trash_delivery, restock_trash_interval)
	log_game("Restocking trash piles...")
	message_admins("Restocking trash piles...")

	for(var/datum/weakref/TS in GLOB.trash_piles)
		var/obj/item/storage/trash_stack/tresh = TS?.resolve()
		if(!tresh)
			GLOB.trash_piles -= TS
			continue
		tresh.cleanup()

//Called when a human swaps hands to a hand which is holding this item
/obj/item/proc/swapped_to(mob/user)
	add_hud_actions(user)

//Called when a human swaps hands away from a hand which is holding this item
/obj/item/proc/swapped_from(mob/user)
	remove_hud_actions(user)

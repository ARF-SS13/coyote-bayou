SUBSYSTEM_DEF(itemspawners)
	name = "Item Spawners"
	wait = 1 HOURS

/datum/controller/subsystem/itemspawners/fire(resumed = 0)
	log_game("Item Spawners Subsystem Firing")
	message_admins("Item Spawners Subsystem Firing.")

	restock_trash_piles()

/obj/item
	var/from_trash = FALSE

/datum/controller/subsystem/itemspawners/proc/restock_trash_piles()
	for(var/obj/item/storage/trash_stack/TS in GLOB.trash_piles)
		TS.loot_players.Cut() //This culls a list safely
		for(var/obj/item/A in TS.loc.contents)
			if(A.from_trash)
				qdel(A)
	for(var/obj/item/storage/money_stack/MS in GLOB.money_piles)
		MS.paid_players.Cut()

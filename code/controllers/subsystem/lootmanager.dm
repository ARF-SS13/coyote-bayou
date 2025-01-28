SUBSYSTEM_DEF(lootmanager)
	name = "Loot Manager"
	init_order = INIT_ORDER_DEFAULT
	flags = SS_NO_FIRE
	var/list/pile_list = list()

/datum/controller/subsystem/lootmanager/Initialize(timeofday)
	for(var/obj/item/storage/trash_stack/pile in world)
		pile_list.Add(pile)
	. = ..()

/datum/controller/subsystem/lootmanager/proc/add_pile(obj/item/storage/trash_stack/pile)
	pile_list.Add(pile)

/datum/controller/subsystem/lootmanager/proc/remove_pile(obj/item/storage/trash_stack/pile)
	pile_list.Remove(pile)

/datum/controller/subsystem/lootmanager/proc/send_to_all_players(obj/item/storage/trash_stack/pile)
	for(var/mob/M in GLOB.player_list)
		if(M.stat != DEAD)
			pile.show(M.client)

/datum/controller/subsystem/lootmanager/proc/send_all_to_player(client/C)
	for(var/obj/item/storage/trash_stack/pile in pile_list)
		pile.show(C)

// Unlike loot tables, this one seems to be adding modular list only when said list and LAZYADD proc is placed AFTER the . = ..() call.
/obj/item/storage/trash_stack/initialize_lootable_trash()
	. = ..()
	var/list/extra_garbage = list(
		GLOB.trash_extra
	)
	LAZYADD(garbage_list, extra_garbage)

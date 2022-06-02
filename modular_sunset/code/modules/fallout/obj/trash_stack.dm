/obj/item/storage/trash_stack/New()
	var/list/extra_garbage = list(
		/obj/item/clothing/mask/gas/goner/aesthetic = 5,
		/obj/item/clothing/mask/gas/goner = 1
	)
	LAZYADD(garbage_list, extra_garbage)

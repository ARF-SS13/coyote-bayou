GLOBAL_LIST(custom_item_list_db)

/proc/load_custom_items_from_db(ckey)  //If the load_custom_items_from_db flag is enabled in config\config.txt, load all ckeys and their granted items into the global list defined above

	if(!CONFIG_GET(flag/use_custom_items_from_db))  //check the config flag
		return -1

	if(!SSdbcore.Connect())	//make sure the database is connected
		return -1

	var/datum/db_query/custom_item_read = SSdbcore.NewQuery(
		"SELECT id, ckey, charactername, rolename, itempath, description FROM [format_table_name("custom_items")] WHERE ckey = :ckey",
		list("ckey" = ckey))
	)
	if(!custom_item_read.Execute())
		qdel(custom_item_read)
		return -1
	var/list/custom_items = list()

	while(custom_item_read.NextRow())
		custom_items[custom_item_read.item[1]] += list(custom_item_read.item[2],custom_item_read.item[3], custom_item_read.item[4], custom_item_read.item[5], custom_item_read.item[6])

	qdel(custom_item_read)

	GLOB.custom_item_list_db = custom_items

	return custom_items

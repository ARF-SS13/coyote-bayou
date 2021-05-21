/obj/machinery/mineral/wasteland_vendor/bank/proc/adjustMoney(ckey, amount)
	if(!usr.client)
		return
	if(!ckey)
		return
	var/currentMoney = getMoney(ckey)
	var/newMoney
	newMoney = currentMoney += amount
	var/datum/DBQuery/query_set_money = SSdbcore.NewQuery(
		"UPDATE money SET amount = :amount WHERE ckey = :ckey",
		list("ckey" = ckey, "amount" = newMoney)
		)
	if(!query_set_money.warn_execute())
		qdel(query_set_money)
		return
	qdel(query_set_money)

/obj/machinery/mineral/wasteland_vendor/bank/proc/getMoney(ckey)
	if(!usr.client)
		return 0
	if(!ckey)
		return 0
	var/datum/DBQuery/query_get_money = SSdbcore.NewQuery(
	"SELECT amount FROM [format_table_name("money")] WHERE ckey = :ckey",
	list("ckey" = ckey)
	)
	if(!query_get_money.warn_execute())
		qdel(query_get_money)
		return 0
	if(query_get_money.NextRow())
		var/currentMoney = query_get_money.item[1]
		qdel(query_get_money)
		return currentMoney
	qdel(query_get_money)
	var/datum/DBQuery/query_add_new_account = SSdbcore.NewQuery(
	"INSERT INTO [format_table_name("money")] VALUES (:ckey, '0')",
	list("ckey" = ckey)
	)
	if(!query_add_new_account.warn_execute())
		qdel(query_add_new_account)
		return 0
	qdel(query_add_new_account)
	return 0

/client/proc/adminCheckMoney()
	set category = "Admin"
	set name = "Check MetaMoney(tm)"
	if(!GLOB.admin_datums[src.ckey])
		to_chat(src, "<span class='danger'>Only administrators may use this command.</span>", confidential = TRUE)
		return
	var/list/client/targets[0]
	for(var/client/T)
		if(T.mob)
			if(isnewplayer(T.mob))
				targets["(New Player) - [T]"] = T
			else if(isobserver(T.mob))
				targets["[T.mob.name](Ghost) - [T]"] = T
			else
				targets["[T.mob.real_name](as [T.mob.name]) - [T]"] = T
		else
			targets["(No Mob) - [T]"] = T
	var/target = input(src,"Choose account","MetaMoney",null) as null|anything in sortList(targets)
	var/amount = getMoney(targets[target].ckey)
	to_chat(src, "[targets[target]] has [amount] MetaMoneys(tm)")

/client/proc/adminChangeMoney()
	set category = "Admin"
	set name = "Add/Remove MetaMoney(tm)"
	if(!GLOB.admin_datums[src.ckey])
		to_chat(src, "<span class='danger'>Only administrators may use this command.</span>", confidential = TRUE)
		return
	var/list/client/targets[0]
	for(var/client/T)
		if(T.mob)
			if(isnewplayer(T.mob))
				targets["(New Player) - [T]"] = T
			else if(isobserver(T.mob))
				targets["[T.mob.name](Ghost) - [T]"] = T
			else
				targets["[T.mob.real_name](as [T.mob.name]) - [T]"] = T
		else
			targets["(No Mob) - [T]"] = T
	var/target = input(src,"Choose account","MetaMoney",null) as null|anything in sortList(targets)
	var/amount = input(src, "Choose amount", "Amount",null) as message|null
	amount = sanitize_integer(amount, -100000, 100000, initial(amount))
	message_admins("MetaMoney(tm) adjusted for targets[target] by [amount]")
	adjustMoney(targets[target], text2num(amount))

/client/proc/adjustMoney(ckey, amount)
	if(!usr.client)
		return
	if(!ckey)
		return
	var/currentMoney = getMoney(ckey)
	var/newMoney
	newMoney = currentMoney += amount
	var/datum/DBQuery/query_set_money = SSdbcore.NewQuery(
		"UPDATE money SET amount = :amount WHERE ckey = :ckey",
		list("ckey" = ckey, "amount" = newMoney)
		)
	if(!query_set_money.warn_execute())
		qdel(query_set_money)
		return
	qdel(query_set_money)

/client/proc/getMoney(ckey)
	if(!usr.client)
		return 0
	if(!ckey)
		return 0
	var/datum/DBQuery/query_get_money = SSdbcore.NewQuery(
	"SELECT amount FROM [format_table_name("money")] WHERE ckey = :ckey",
	list("ckey" = ckey)
	)
	if(!query_get_money.warn_execute())
		qdel(query_get_money)
		return 0
	if(query_get_money.NextRow())
		var/currentMoney = query_get_money.item[1]
		qdel(query_get_money)
		return currentMoney
	qdel(query_get_money)
	var/datum/DBQuery/query_add_new_account = SSdbcore.NewQuery(
	"INSERT INTO [format_table_name("money")] VALUES (:ckey, '0')",
	list("ckey" = ckey)
	)
	if(!query_add_new_account.warn_execute())
		qdel(query_add_new_account)
		return 0
	qdel(query_add_new_account)
	return 0

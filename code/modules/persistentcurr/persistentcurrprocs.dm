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
		message_admins("[query_get_money]")
		var/currentMoney = query_get_money.item[1]
		qdel(query_get_money)
		return currentMoney
	return 0

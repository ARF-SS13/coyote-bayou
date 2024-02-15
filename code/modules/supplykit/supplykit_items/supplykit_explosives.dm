
/* explosives

//primary vars
/datum/supplykit_item/explosives/
	name = 
	desc = 
	item = 
	cost = 

//other vars
	surplus = 100 //if set below 100, reduces chances of being in the surplus crate
	cant_discount = FALSE //if set to true, prevents possible discounts
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy. also prevents discounts
	restricted_roles = list() //for restricting by job type
	*/



/datum/supplykit_item/explosives/dynamite
	name = "dynamite stick"
	desc = "A single stick of explosion funtimes."
	item = /obj/item/grenade/f13/dynamite
	cost = 10



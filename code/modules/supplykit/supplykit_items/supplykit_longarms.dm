
/* bulky firearms

//primary vars
/datum/supplykit_item/longarms/
	name = 
	desc = 
	item = 
	cost = 

//other vars
	surplus = 100 //if set below 100, reduces chances of being in the surplus crate
	cant_discount = FALSE //if set to true, prevents possible discounts
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy
	restricted_roles = list() //for restricting by job type
	*/



/datum/supplykit_item/longarms/a180
	name = "American 180"
	desc = "A high capacity automatic, designed as a police support weapon with limited overpenetration and friendly fire."
	item = /obj/item/gun/ballistic/automatic/smg/american180
	cost = 50 //law guns cost extra

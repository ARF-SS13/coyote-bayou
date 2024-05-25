
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
	cost = 5

/datum/supplykit_item/explosives/dynamitebox
	name = "dynamite crate"
	desc = "A box with seven sticks of dynamite for additional explosion funtimes."
	item = /obj/item/storage/box/dynamite_box
	cost = 25

/datum/supplykit_item/explosives/coffeebomb
	name = "coffeepot bomb"
	desc = "A jury-rigged explosive consisting of kitchen appliances and gunpowder."
	item = /obj/item/grenade/homemade/coffeepotbomb
	cost = 10

/datum/supplykit_item/explosives/flashbang
	name = "flashbang grenade"
	desc = "A loud and proud bangy boy, for annoying friends and enemies alike."
	item = /obj/item/grenade/flashbang
	cost = 5

/datum/supplykit_item/explosives/plastic
	name = "plastic explosives"
	desc = "A timed demolition charge for hard breaches."
	item = /obj/item/grenade/plastic
	cost = 30

/datum/supplykit_item/explosives/emp
	name = "EMP grenade"
	desc = "A grenade designed to fry electronic circuits"
	item = /obj/item/grenade/empgrenade
	cost = 15

/datum/supplykit_item/explosives/smoke
	name = "Smoke Grenade"
	desc = "A grenade that produces a big cloud of smoke, for making clean getaways."
	item = /obj/item/grenade/smokebomb
	cost = 5


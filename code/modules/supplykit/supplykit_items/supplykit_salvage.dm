
/* mining and salvaging tools

//primary vars
/datum/supplykit_item/salvage/
	name = 
	desc = 
	item = 
	cost = 

//other vars
	surplus = 100 //if set below 100, reduces chances of being in the surplus crate
	cant_discount = FALSE //if set to true, prevents possible discounts
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy. also prevents discounts.
	restricted_roles = list() //for restricting by job type
	*/



/datum/supplykit_item/tools/weldgoggles
	name = "Welding Goggles"
	desc = "A set of hard to come by welding goggles, used to protect your eyes during construction and salvage."
	item = /obj/item/clothing/glasses/welding
	cost = 20

/datum/supplykit_item/tools/industrialwelder
	name = "Industrial Welding Tool"
	desc = "A welding tool with a large reservoir, for efficient salvaging."
	item = /obj/item/weldingtool/largetank
	cost = 10

/datum/supplykit_item/tools/salvagebag
	name = "Salvage Bag"
	desc = "A rugged sturdy bag for collecting junk."
	item = /obj/item/storage/bag/salvage
	cost = 5

/datum/supplykit_item/tools/drill
	name = "Mining Drill"
	desc = "A heavy duty rock breaking drill, operates much faster than a pickaxe. C4 not included."
	item = /obj/item/pickaxe/drill
	cost = 10

/datum/supplykit_item/tools/pickaxe
	name = "Compact Pickaxe"
	desc = "A small but effective pickaxe, which can be stashed in a backpack."
	item = /obj/item/pickaxe/mini
	cost = 10

/datum/supplykit_item/tools/mininscanner
	name = "Automatic Mining Scanner"
	desc = "A scanner used to detect precious minerals in nearby rock and stone."
	item = /obj/item/t_scanner/adv_mining_scanner/lesser
	cost = 10

/datum/supplykit_item/tools/hardhat
	name = "Hard Hat"
	desc = "A sturdy helmet with a mounted lamp, for protecting against falling rocks and debris."
	item = /obj/item/clothing/head/hardhat
	cost = 10

/datum/supplykit_item/tools/orebag
	name = "Ore Bag"
	desc = "A cloth bag made for holding minerals as you mine."
	item = /obj/item/storage/bag/ore
	cost = 2

/datum/supplykit_item/tools/researchpaper
	name = "Research Paper"
	desc = "Research papers for the wannabe or average scientist."
	item = /obj/item/blueprint/research 
	cost = 10
	cant_discount = TRUE

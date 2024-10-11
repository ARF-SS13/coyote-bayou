
/* ammunition

//primary vars
/datum/supplykit_item/ammo/
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

/datum/supplykit_item/ammo/spearquiver
	name = "A tribal quiver"
	desc = "A quiver that can hold arrows or spears."
	item = /obj/item/storage/backpack/spearquiver
	limited_stock = 4

/datum/supplykit_item/ammo/box12buck
	name = "12 gauge buckshot box"
	desc = "A box containing 60 rounds of 12 gauge buckshot."
	item = /obj/item/ammo_box/sbuckshot
	limited_stock = 4

/datum/supplykit_item/ammo/box22
	name = ".22LR ammo box"
	desc = "A box containing 60 rounds of .22LR ammunition."
	item = /obj/item/ammo_box/s22
	limited_stock = 4

/datum/supplykit_item/ammo/box9mm
	name = "9mm ammo box"
	desc = "A box containing 60 rounds of 9mm ammunition."
	item = /obj/item/ammo_box/s9mm
	limited_stock = 4

/datum/supplykit_item/ammo/box357
	name = ".357 ammo box"
	desc = "A box containing 60 rounds of .357 ammunition."
	item = /obj/item/ammo_box/s357
	limited_stock = 4

/datum/supplykit_item/ammo/box44
	name = ".44 ammo box"
	desc = "A box containing 60 rounds of .44 ammunition."
	item = /obj/item/ammo_box/s44
	limited_stock = 4

/datum/supplykit_item/ammo/box45
	name = ".45 ACP ammo box"
	desc = "A box containing 60 rounds of .45ACP ammunition."
	item = /obj/item/ammo_box/s45
	limited_stock = 4

/datum/supplykit_item/ammo/box556
	name = ".223 ammo box"
	desc = "A box containing 60 rounds of .223 ammunition."
	item = /obj/item/ammo_box/s556
	limited_stock = 4

/datum/supplykit_item/ammo/box762
	name = "7.62x39 ammo box"
	desc = "A box containing 60 rounds of 7.62x39mm ammunition."
	item = /obj/item/ammo_box/s762by39
	limited_stock = 4

/datum/supplykit_item/ammo/box308
	name = ".308 ammo box"
	desc = "A box containing 60 rounds of .308 ammunition."
	item = /obj/item/ammo_box/s308
	limited_stock = 4

/datum/supplykit_item/ammo/box3006
	name = ".30-06 ammo box"
	desc = "A box containing 60 rounds of .30-06 ammunition."
	item = /obj/item/ammo_box/s3006
	limited_stock = 4

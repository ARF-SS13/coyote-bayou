
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

/datum/supplykit_item/ammo/box12buck
	name = "12 gauge buckshot box"
	desc = "A box containing 12 rounds of 12 gauge buckshot."
	item = /obj/item/ammo_box/shotgun/buck

/datum/supplykit_item/ammo/box12slug
	name = "12 gauge slug box"
	desc = "A box containing 12 rounds of 12 gauge slugs."
	item = /obj/item/ammo_box/shotgun/slug

/datum/supplykit_item/ammo/box22
	name = ".22LR ammo box"
	desc = "A box containing 60 rounds of .22LR ammunition."
	item = /obj/item/ammo_box/m22

/datum/supplykit_item/ammo/box22rat
	name = ".22LR ratshot box"
	desc = "A box containing 60 rounds of .22LR ratshot."
	item = /obj/item/ammo_box/m22/ratshot

/datum/supplykit_item/ammo/box9mm
	name = "9mm ammo box"
	desc = "A box containing 45 rounds of 9mm ammunition."
	item = /obj/item/ammo_box/c9mm

/datum/supplykit_item/ammo/box10mm
	name = "10mm ammo box"
	desc = "A box containing 30 rounds of 10mm ammunition."
	item = /obj/item/ammo_box/c10mm

/datum/supplykit_item/ammo/box357
	name = ".357 ammo box"
	desc = "A box containing 25 rounds of .357 ammunition."
	item = /obj/item/ammo_box/a357box

/datum/supplykit_item/ammo/box357rat
	name = ".357 ratshot box"
	desc = "A box containing 25 rounds of .357 ratshot."
	item = /obj/item/ammo_box/a357box/ratshot

/datum/supplykit_item/ammo/box44
	name = ".44 ammo box"
	desc = "A box containing 20 rounds of .44 ammunition."
	item = /obj/item/ammo_box/m44box

/datum/supplykit_item/ammo/box45lc
	name = ".45 Long Colt box"
	desc = "A box containing 30 rounds of .45LC ammunition."
	item = /obj/item/ammo_box/a45lcbox

/datum/supplykit_item/ammo/box45
	name = ".45 ACP ammo box"
	desc = "A box containing 25 rounds of .45ACP ammunition."
	item = /obj/item/ammo_box/c45

/datum/supplykit_item/ammo/box4570
	name = ".45-70 ammo box"
	desc = "A box containing 15 rounds of .45-70 ammunition."
	item = /obj/item/ammo_box/c4570box

/datum/supplykit_item/ammo/box5mm
	name = "5mm ammo box"
	desc = "A box containing 30 rounds of 5mm ammunition."
	item = /obj/item/ammo_box/m5mmbox

/datum/supplykit_item/ammo/box556
	name = "5.56 ammo box"
	desc = "A box containing 25 rounds of 5.56 ammunition."
	item = /obj/item/ammo_box/a556

/datum/supplykit_item/ammo/box308
	name = ".308 ammo box"
	desc = "A box containing 20 rounds of .308 ammunition."
	item = /obj/item/ammo_box/a308box

/datum/supplykit_item/ammo/box3006
	name = ".30-06 ammo box"
	desc = "A box containing 15 rounds of .30-06 ammunition."
	item = /obj/item/ammo_box/a3006box

/datum/supplykit_item/ammo/box50
	name = ".50bmg ammo box"
	desc = "A box containing 15 rounds of .50bmg ammunition."
	item = /obj/item/ammo_box/a50MGbox

/datum/supplykit_item/ammo/box14
	name = "14mm ammo box"
	desc = "A box containing 15 rounds of 14mm ammunition."
	item = /obj/item/ammo_box/m14mm

/datum/supplykit_item/ammo/box473
	name = "4.73mm caseless box"
	desc = "A box containing 15 rounds of 4.73mm caseless ammunition."
	item = /obj/item/ammo_box/m473

/datum/supplykit_item/ammo/box40
	name = "40mm buckshot box"
	desc = "A box containing 4 rounds of 40mm buckshot ammunition."
	item = /obj/item/ammo_box/a40mm/buck

/datum/supplykit_item/ammo/needlercapsule
	name = "Needler Capsule"
	desc = "A capsule full of needles for an exotic gun."
	item = /obj/item/ammo_box/needlercapsule


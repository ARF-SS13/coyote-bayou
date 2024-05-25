/* ammunition

//primary vars
/datum/supplykit_item/ammospec/
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

/datum/supplykit_item/ammospec/box12rubber
	name = "12 gauge rubber shot box"
	desc = "A box containing 12 rounds of 12 gauge rubber shot."
	item = /obj/item/ammo_box/shotgun/rubber

/datum/supplykit_item/ammospec/box12bean
	name = "12 gauge beanbag box"
	desc = "A box containing 12 rounds of 12 gauge beanbags."
	item = /obj/item/ammo_box/shotgun/bean

/datum/supplykit_item/ammospec/box12improv
	name = "12 gauge improvised bag"
	desc = "A box containing 12 rounds of 12 gauge improvised shot."
	item = /obj/item/ammo_box/shotgun/improvised
	cost = 5

/datum/supplykit_item/ammospec/box22rubber
	name = ".22LR nonlethal box"
	desc = "A box containing 60 rounds of .22LR rubber ammunition."
	item = /obj/item/ammo_box/m22/rubber

/datum/supplykit_item/ammospec/box9mmrubber
	name = "9mm nonlethal box"
	desc = "A box containing 45 rounds of 9mm rubber ammunition."
	item = /obj/item/ammo_box/c9mm/rubber

/datum/supplykit_item/ammospec/box9mmimprov
	name = "9mm improvised bag"
	desc = "A box containing 45 rounds of 9mm improvised ammunition."
	item = /obj/item/ammo_box/c9mm/improvised
	cost = 5

/datum/supplykit_item/ammospec/box10mmrubber
	name = "10mm nonlethal box"
	desc = "A box containing 30 rounds of 10mm rubber ammunition."
	item = /obj/item/ammo_box/c10mm/rubber

/datum/supplykit_item/ammospec/box10mmimprov
	name = "10mm improvised bag"
	desc = "A box containing 30 rounds of 10mm improvised ammunition."
	item = /obj/item/ammo_box/c10mm/improvised
	cost = 5

/datum/supplykit_item/ammospec/box357improv
	name = ".357 improvised bag"
	desc = "A box containing 25 rounds of .357 improvised ammunition."
	item = /obj/item/ammo_box/a357box/improvised
	cost = 5

/datum/supplykit_item/ammospec/box44improv
	name = ".44 improvised bag"
	desc = "A box containing 20 rounds of .44 improvised ammunition."
	item = /obj/item/ammo_box/m44box/improvised
	cost = 5

/datum/supplykit_item/ammospec/box45lcimprov
	name = ".45LC improvised bag"
	desc = "A box containing 30 rounds of .45LC improvised ammunition."
	item = /obj/item/ammo_box/a45lcbox/improvised
	cost = 5

/datum/supplykit_item/ammospec/box45rubber
	name = ".45 ACP nonlethal box"
	desc = "A box containing 25 rounds of .45ACP rubber ammunition."
	item = /obj/item/ammo_box/c45/rubber

/datum/supplykit_item/ammospec/box45improv
	name = ".45 ACP improvised bag"
	desc = "A box containing 25 rounds of .45ACP improvised ammunition."
	item = /obj/item/ammo_box/c45/improvised
	cost = 5

/datum/supplykit_item/ammospec/box4570improv
	name = ".45-70 improvised bag"
	desc = "A box containing 15 rounds of .45-70 improvised ammunition."
	item = /obj/item/ammo_box/c4570box/improvised
	cost = 5

/datum/supplykit_item/ammospec/box5mmimprov
	name = "5mm improvised bag"
	desc = "A box containing 30 rounds of 5mm improvised ammunition."
	item = /obj/item/ammo_box/m5mmbox/improvised
	cost = 5

/datum/supplykit_item/ammospec/box556rubber
	name = "5.56 nonlethal box"
	desc = "A box containing 25 rounds of 5.56 rubber ammunition."
	item = /obj/item/ammo_box/a556/rubber

/datum/supplykit_item/ammospec/box556improv
	name = "5.56 improvised bag"
	desc = "A box containing 25 rounds of 5.56 improvised ammunition."
	item = /obj/item/ammo_box/a556/improvised
	cost = 5

/datum/supplykit_item/ammospec/box308rubber
	name = ".308 nonlethal box"
	desc = "A box containing 20 rounds of .308 rubber ammunition."
	item = /obj/item/ammo_box/a308box/rubber

/datum/supplykit_item/ammospec/box308improv
	name = ".308 improvised bag"
	desc = "A box containing 20 rounds of .308 improvised ammunition."
	item = /obj/item/ammo_box/a308box/improvised
	cost = 5

/datum/supplykit_item/ammospec/box3006rubber
	name = ".30-06 rubber box"
	desc = "A box containing 15 rounds of .30-06 rubber ammunition."
	item = /obj/item/ammo_box/a3006box/rubber

/datum/supplykit_item/ammospec/box3006improv
	name = ".30-06 improvised bag"
	desc = "A box containing 15 rounds of .30-06 improvised ammunition."
	item = /obj/item/ammo_box/a3006box/improvised
	cost = 5

/datum/supplykit_item/ammospec/box50rubber
	name = ".50bmg nonlethal box"
	desc = "A box containing 15 rounds of .50bmg rubber ammunition."
	item = /obj/item/ammo_box/a50MGbox/rubber

/datum/supplykit_item/ammospec/box50improv
	name = ".50bmg improvised bag"
	desc = "A box containing 15 rounds of .50bmg improvised ammunition."
	item = /obj/item/ammo_box/a50MGbox/improvised
	cost = 5

/datum/supplykit_item/ammospec/box14improv
	name = "14mm improvised bag"
	desc = "A box containing 15 rounds of 14mm improvised ammunition."
	item = /obj/item/ammo_box/m14mm/improvised
	cost = 5

/datum/supplykit_item/ammospec/box473rubber
	name = "4.73mm nonlethal box"
	desc = "A box containing 15 rounds of 4.73mm crubber ammunition."
	item = /obj/item/ammo_box/m473/rubber

/datum/supplykit_item/ammospec/needlercapsule
	name = "handcrafted needler capsule"
	desc = "A capsule full of handcrafted needles for an exotic weapon."
	item = /obj/item/ammo_box/needlercapsule/handloaded
	cost = 5


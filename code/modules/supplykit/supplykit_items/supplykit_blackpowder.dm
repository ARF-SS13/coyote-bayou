
/* blackpowder

//primary vars
/datum/supplykit_item/blackpowder/
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

/datum/supplykit_item/blackpowder/ammo
	name = "Powderbag and Musket Balls"
	desc = "A bag containing 16 lead balls and matching powder and primer."
	item = /obj/item/ammo_box/flintlock
	cost = 10
	important = TRUE

/datum/supplykit_item/blackpowder/minie
	name = "Powderbag and Minie Balls"
	desc = "A bag containing 16 lead minie balls, boasting more accuracy and a bit less power than a musket ball."
	item = /obj/item/ammo_box/flintlock/minie
	cost = 10
	important = TRUE

/datum/supplykit_item/blackpowder/super
	name = "Powderbag and Super Balls"
	desc = "A bag containing 16 super balls, high power but nonlethal."
	item = /obj/item/ammo_box/flintlock/rubber
	cost = 10
	important = TRUE

/datum/supplykit_item/blackpowder/culverin
	name = "Culverin"
	desc = "A sturdy musket that is just as effective at being used as a cudgel."
	item = /obj/item/gun/flintlock/musket/jezail/culverin

/datum/supplykit_item/blackpowder/mosquete
	name = "Flintlock Mosquete"
	desc = "A light flintlock carbine with a dark ebonywood stock."
	item = /obj/item/gun/flintlock/musketoon/mosquete

/datum/supplykit_item/blackpowder/musket
	name = "Flintlock Musket"
	desc = "A simple, standard, rugged musket."
	item = /obj/item/gun/flintlock/musket

/datum/supplykit_item/blackpowder/musketoon
	name = "Flintlock Musketoon"
	desc = "A light Flintlock Carbine."
	item = /obj/item/gun/flintlock/musketoon

/datum/supplykit_item/blackpowder/pistol
	name = "Flintlock Pistol"
	desc = "A rugged single barrel flintlock pistol."
	item = /obj/item/gun/flintlock

/datum/supplykit_item/blackpowder/spingarda
	name = "Flintlock Spingarda"
	desc = "A flintlock carbine with a somewhat flanged muzzle, like a blunderbuss."
	item = /obj/item/gun/flintlock/musketoon/spingarda

/datum/supplykit_item/blackpowder/jezail
	name = "Jezail Long Rifle"
	desc = "An accurate, long barreled blackpowder rifle."
	item = /obj/item/gun/flintlock/musket/jezail

/datum/supplykit_item/blackpowder/arquebus
	name = "Matchlock Arquebus"
	desc = "An ancient, heavy smoothbore, with a simple, archaic trigger mechanism that almost anyone can operate."
	item = /obj/item/gun/flintlock/matchlock/matchlockarquebus

/datum/supplykit_item/blackpowder/fancyarquebus
	name = "Ornate Matchlock Arquebus"
	desc = "A well crafted arquebus, with a simple, easy to understand trigger mechanism."
	item = /obj/item/gun/flintlock/matchlock/matchlockarquebus

/datum/supplykit_item/blackpowder/carbine
	name = "Matchlock Carbine"
	desc = "A light smoothbore carbine, with a simple, primitive trigger mechanism."
	item = /obj/item/gun/flintlock/matchlock/musketoon/carabine

/datum/supplykit_item/blackpowder/sharpshooter
	name = "Matchlock Cavalier Sharpshooter"
	desc = "A precision matchlock rifle, about as accurate as you can get with such an ancient, simple technology."
	item = /obj/item/gun/flintlock/matchlock/cavalier

/datum/supplykit_item/blackpowder/espingole
	name = "Matchlock Espingole"
	desc = "An ancient, simple matchlock gun with a widened barrel."
	item = /obj/item/gun/flintlock/matchlock/musketoon/espingole

/datum/supplykit_item/blackpowder/bombard
	name = "Matchlock Hand Bombard"
	desc = "Pretty much just a short, heavy cast iron barrel on a stick with a simple matchlock mechanism."
	item = /obj/item/gun/flintlock/matchlock/handbombard

/datum/supplykit_item/blackpowder/cannon
	name = "Matchlock Hand Cannon"
	desc = "A simple ancient matchlock pistol for all your piracy needs."
	item = /obj/item/gun/flintlock/matchlock/

/datum/supplykit_item/blackpowder/handgonne
	name = "Matchlock Handgonne"
	desc = "One of the oldest firearms in existance. simple to operate, but hard to hit anything with."
	item = /obj/item/gun/flintlock/matchlock/handcannon/handgonne

/datum/supplykit_item/blackpowder/matchmusketoon
	name = "Matchlock Musketoon"
	desc = "An ancient, simple to operate lightweight carbine."
	item = /obj/item/gun/flintlock/matchlock/musketoon

/datum/supplykit_item/blackpowder/tanegashima
	name = "Tanegashima Musket"
	desc = "A high power, well crafted long barrel musket."
	item = /obj/item/gun/flintlock/musket/tanegashima


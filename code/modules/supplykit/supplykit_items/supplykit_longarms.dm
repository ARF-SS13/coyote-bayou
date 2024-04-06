
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
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy. also prevents discounts.
	restricted_roles = list() //for restricting by job type
	*/



/datum/supplykit_item/longarms/smg22
	name = ".22 Uzi"
	desc = "A lightweight submachinegun with trivial recoil and cheap ammunition. Takes 16 and 32 round .22 magazines."
	item = /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22

/datum/supplykit_item/longarms/mp22
	name = ".22 MP5"
	desc = "A commercial version of the MP5 chambered in .22LR. Takes 16 and 32 round magazines."
	item = /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/mp22

/datum/supplykit_item/longarms/pp22
	name = "Mini PPSh"
	desc = "A miniature model of a PPSh-41 chambered in .22LR. Takes 16 and 32 round magazines."
	item = /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/ppsh

/datum/supplykit_item/longarms/carbine9mm
	name = "9mm Carbine"
	desc = "A pistol caliber carbine with two shot burst and 15 round magazines."
	item = /obj/item/gun/ballistic/automatic/pistol/beretta/carbine

/datum/supplykit_item/longarms/rockwell
	name = "Rockwell SMG"
	desc = "A rusty but reliable 9mm SMG with 20 round magazines."
	item = /obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell

/datum/supplykit_item/longarms/caravan
	name = "Caravan Rifle"
	desc = "A light, high caliber over-under rifle with a scope mount, chambered in .45-70"
	item = /obj/item/gun/ballistic/revolver/caravan_shotgun

/datum/supplykit_item/longarms/cowboy
	name = "Cowboy Repeater"
	desc = "A classic lever action rifle chambered in .357 magnum, with a 12 round tube magazine."
	item = /obj/item/gun/ballistic/rifle/repeater/cowboy

/datum/supplykit_item/longarms/delisle
	name = "Delisle Carbine"
	desc = "A 9mm carbine with built in suppressor and a 15 round magazine."
	item = /obj/item/gun/ballistic/automatic/delisle

/datum/supplykit_item/longarms/famas
	name = "Famas Rifle"
	desc = "A European bullpup assault rifle, chambered in 5.56 with 20 round magazines."
	item = /obj/item/gun/ballistic/automatic/famas

/datum/supplykit_item/longarms/gewehr88
	name = "Gewehr 88"
	desc = "A german bolt action rifle featuring 5 rounds of .30-06 in an internal magazine."
	item = /obj/item/gun/ballistic/rifle/gewehr88

/datum/supplykit_item/longarms/gras
	name = "Gras Rifle"
	desc = "A high power bolt action rifle that holds just two rounds of .30-06."
	item = /obj/item/gun/ballistic/rifle/antique/gras

/datum/supplykit_item/longarms/hunting
	name = "Hunting Rifle"
	desc = "A standard .30-06 bolt action rifle with 5 round internal magazine."
	item = /obj/item/gun/ballistic/rifle/hunting

/datum/supplykit_item/longarms/jungle
	name = "Jungle Carbine"
	desc = "A light bolt action rifle with a ten round internal magazine of .308."
	item = /obj/item/gun/ballistic/rifle/enfield/jungle

/datum/supplykit_item/longarms/enfield
	name = "Lee-Enfield"
	desc = "A full sized bolt action rifle with a ten round internal magazine of .308."
	item = /obj/item/gun/ballistic/rifle/enfield

/datum/supplykit_item/longarms/m1carbine
	name = "M1 Carbine"
	desc = "A high capacity, highly customizable carbine that takes 12 and 24 round 10mm magazines."
	item = /obj/item/gun/ballistic/automatic/m1carbine

/datum/supplykit_item/longarms/mauser
	name = "Mauser 71"
	desc = "An ancient, heavy bolt action rifle chambered in .50bmg with an 8 round internal magazine."
	item = /obj/item/gun/ballistic/rifle/mauserrifle

/datum/supplykit_item/longarms/minimosin
	name = "Mini-Mosin"
	desc = "A tiny bolt-action .22 plinking rifle made to look like the classic Mosin rifle."
	item = /obj/item/gun/ballistic/rifle/mosin/mini

/datum/supplykit_item/longarms/sidewinder
	name = "Multicaliber Carbine"
	desc = "An civilian semi-auto variant of the multicaliber SMG, able to take many 9mm, 10mm, .45, and .22 magazines."
	item = /obj/item/gun/ballistic/automatic/smg/sidewinder/worn

/datum/supplykit_item/longarms/minotaur
	name = "S163 Minotaur"
	desc = "A semiautomatic 12 gauge shotgun with a light, 3 round tube magazine."
	item = /obj/item/gun/ballistic/shotgun/s163

/datum/supplykit_item/longarms/sportcarbine
	name = "Sport Carbine"
	desc = "A .22 plinking rifle with a high capacity 32 round magazine and high rate of fire."
	item = /obj/item/gun/ballistic/automatic/sportcarbine

/datum/supplykit_item/longarms/covcarbine
	name = "T25 Assault Carbine"
	desc = "A futuristic 10mm carbine that takes 12 and 24 round magazines"
	item = /obj/item/gun/ballistic/automatic/m1carbine/covcarbine

/datum/supplykit_item/longarms/trainer
	name = "Training Repeater"
	desc = "A .22 lever action plinking rifle, with a 20 round tube magazine."
	item = /obj/item/gun/ballistic/rifle/repeater/trainer

/datum/supplykit_item/longarms/varmint
	name = "Varmint rifle"
	desc = "A semi-automatic 5.56 rifle with removable box magazines."
	item = /obj/item/gun/ballistic/automatic/varmint

/datum/supplykit_item/longarms/widowmaker
	name = "Widowmaker shotgun"
	desc = "A simple, light double barrel shotgun with two triggers."
	item = /obj/item/gun/ballistic/revolver/widowmaker

/datum/supplykit_item/longarms/z34
	name = "Z34 battle rifle"
	desc = "A semi-automatic .308 rifle with a 10 round internal magazine."
	item = /obj/item/gun/ballistic/automatic/z34rifle



/* improvised firearms

//primary vars
/datum/supplykit_item/pipeguns/
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



/datum/supplykit_item/pipeguns/brick
	name = "Brick Launcher"
	desc = "The tube of an old rocket launcher, modified to slingshot bricks at high velocity. bricks are easily sourced, via *brick"
	item = /obj/item/gun/ballistic/revolver/brick

/datum/supplykit_item/pipeguns/shotpistol
	name = "Hand Shotgun"
	desc = "A light single barrel shotgun that is little more than a pipe and a grip."
	item = /obj/item/gun/ballistic/revolver/shotpistol

/datum/supplykit_item/pipeguns/knifegun
	name = "Knife Gun"
	desc = "A knife with a .44 magnum gun barrel attached. "
	item = /obj/item/gun/ballistic/revolver/hobo/knifegun

/datum/supplykit_item/pipeguns/knucklegun
	name = "Knuckle Gun"
	desc = "A set of brass knuckles with four short .45acp barrels that all go off at once."
	item = /obj/item/gun/ballistic/revolver/hobo/knucklegun

/datum/supplykit_item/pipeguns/pepperbox
	name = "Pepperbox"
	desc = "An unstable cluster of four 10mm barrels that can fire in semi-auto or all at once."
	item = /obj/item/gun/ballistic/revolver/hobo/pepperbox

/datum/supplykit_item/pipeguns/piperifle
	name = "Pipe Rifle"
	desc = "A simple pipe and stock, initially chambered in 5.56 but able to be modified to take nearly any cartridge."
	item = /obj/item/gun/ballistic/revolver/hobo/piperifle

/datum/supplykit_item/pipeguns/winchester
	name = "Winchester Rebore"
	desc = "A double barrel shotgun initially chambered in .308 but able to be modified to take nearly any cartridge."
	item = /obj/item/gun/ballistic/revolver/winchesterrebored

/datum/supplykit_item/pipeguns/shotbat
	name = "Shotgun Bat"
	desc = "A baseball bat with a shotgun barrel. It can also fit .50bmg if you have a deathwish."
	item = /obj/item/gun/ballistic/revolver/hobo/single_shotgun

/datum/supplykit_item/pipeguns/zipgun
	name = "Zipgun"
	desc = "An improvised pistol initially chambered in 9mm, that takes 5 round magazines fashioned from sheet metal. the magazines can be modified to take other pistol calibers."
	item = /obj/item/gun/ballistic/automatic/hobo/zipgun

/datum/supplykit_item/pipeguns/sling
	name = "Sling"
	desc = "A scrap of cloth and string used to sling rocks at high speed. Rocks are effortless to find."
	item = /obj/item/gun/energy/kinetic_accelerator/crossbow/sling

/datum/supplykit_item/pipeguns/slingstaff
	name = "Sling staff"
	desc = "A sling attached to a pole to increase its force. Rocks are effortless to find."
	item = /obj/item/gun/energy/kinetic_accelerator/crossbow/sling/staff


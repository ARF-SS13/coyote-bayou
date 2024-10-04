
/* material stacks

//primary vars
/datum/supplykit_item/materials/
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

/datum/supplykit_item/materials/wood
	name = "Wood Planks"
	desc = "Fifty cut pieces of wood, for construction, woodstoves, and boarding over monster dens."
	item = /obj/item/stack/sheet/mineral/wood/fifty
	cost = 1
	important = TRUE

/datum/supplykit_item/materials/metal
	name = "Metal Sheets"
	desc = "Fifty sheets of metal, a basic building material."
	item = /obj/item/stack/sheet/metal/fifty
	cost = 5

/datum/supplykit_item/materials/plasteel
	name = "Plasteel Sheets"
	desc = "Five sheets of sturdy plasteel, good for durable walls."
	item = /obj/item/stack/sheet/plasteel/five
	cost = 5

/datum/supplykit_item/materials/cloth
	name = "Cloth Sheets"
	desc = "Thirty sheets of plain cloth, good for making bandages, bags, and other clothing."
	item = /obj/item/stack/sheet/cloth/thirty
	cost = 5

/datum/supplykit_item/materials/cardboard
	name = "Cardboard Sheets"
	desc = "Twenty sheets of cardboard, for making boxes and fake cutouts."
	item = /obj/item/stack/sheet/cardboard/twenty
	cost = 5

/datum/supplykit_item/materials/plastic
	name = "Plastic Sheets"
	desc = "Five Sheets of plastic, for making curtains and many scientific devices."
	item = /obj/item/stack/sheet/plastic/five
	cost = 5

/datum/supplykit_item/materials/alloys
	name = "prefall Alloys"
	desc = "Five alloy ingots, for advanced construction."
	item = /obj/item/stack/sheet/prefall/five
	cost = 5

/datum/supplykit_item/materials/glass
	name = "Glass Sheets"
	desc = "Fifty glass sheets, for making windows and tools."
	item = /obj/item/stack/sheet/glass/fifty
	cost = 5

/datum/supplykit_item/materials/leather
	name = "Leather Sheets"
	desc = "Five leather sheets, for making rugged bags and clothing."
	item = /obj/item/stack/sheet/leather/five
	cost = 5

/datum/supplykit_item/materials/titanium
	name = "Titanium Sheets"
	desc = "twenty five sturdy sheets for advanced construction."
	item = /obj/item/stack/sheet/mineral/titanium/twentyfive
	cost = 10

/datum/supplykit_item/materials/brick
	name = "Bricks"
	desc = "Fifty bricks, for sturdy housing and cracking heads."
	item = /obj/item/stack/sheet/mineral/brick/fifty
	cost = 5

/datum/supplykit_item/materials/bronze
	name = "Bronze Sheets"
	desc = "Thirty sheets of bronze, for high quality weapon smithing and exotic construction."
	item = /obj/item/stack/sheet/bronze/thirty
	cost = 15


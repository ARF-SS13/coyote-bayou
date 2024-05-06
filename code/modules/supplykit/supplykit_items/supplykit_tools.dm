
/* tools

//primary vars
/datum/supplykit_item/tools/
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



/datum/supplykit_item/tools/trashbag
	name = "Trash Bag"
	desc = "A big ol bag for stowing lots of trash or random junk in."
	item = /obj/item/storage/bag/trash
	cost = 5

/datum/supplykit_item/tools/cleaner
	name = "Abraxo Cleaner"
	desc = "A spray bottle full of chemicals, for making things pristine and clean."
	item = /obj/item/reagent_containers/spray/cleaner
	cost = 5

/datum/supplykit_item/tools/abraxo
	name = "Abraxo"
	desc = "A box of industrial cleaner, strong enough to scrub up radioactive sludge puddles."
	item = /obj/item/crafting/abraxo
	cost = 5

/datum/supplykit_item/tools/mop
	name = "Mop"
	desc = "A basic mop, for cleaning bulkheads and bonking miscreant heads."
	item = /obj/item/mop
	cost = 5

/datum/supplykit_item/tools/broom
	name = "Broom"
	desc = "A useful tool for clearing away trash and gathering up useful junk."
	item = /obj/item/broom
	cost = 5

/datum/supplykit_item/tools/lightreplacer
	name = "Light Replacer"
	desc = "A clever device that recycles broken tubes and bulbs and synthesizes new ones."
	item = /obj/item/lightreplacer
	cost = 5

/datum/supplykit_item/tools/galoshes
	name = "Galoshes"
	desc = "A robust pair of bright yellow boots, with slip resistant grips."
	item = /obj/item/clothing/shoes/galoshes
	cost = 20

/datum/supplykit_item/tools/soap
	name = "Soap Bar"
	desc = "A bar of soap, useful for cleaning, tripping, and eating."
	item = /obj/item/soap
	cost = 5

/datum/supplykit_item/tools/paintremover
	name = "Paint Remover"
	desc = "A bucket of solvent used to scrub paint off floorboards, following colorful hijinx "
	item = /obj/item/paint/paint_remover
	cost = 1

/datum/supplykit_item/tools/smithgloves
	name = "Blacksmith Gloves"
	desc = "A pair of heavy leather gloves that protect your hands while working with hot metal."
	item = /obj/item/clothing/gloves/f13/blacksmith
	cost = 5

/datum/supplykit_item/tools/smithapron
	name = "Blacksmith Apron"
	desc = "A heavy leather apron, used to prevent burns while working at the forge."
	item = /obj/item/clothing/suit/armor/outfit/overalls/blacksmith
	cost = 2

/datum/supplykit_item/tools/smithhammer
	name = "Smithing Hammer"
	desc = "A basic forging hammer, for beginning smithing."
	item = /obj/item/melee/smith/hammer/premade
	cost = 5

/datum/supplykit_item/tools/toolbox
	name = "Tool Box"
	desc = "A box containing a full set of tools for construction and wiring."
	item = /obj/item/storage/toolbox/mechanical
	cost = 10

/datum/supplykit_item/tools/spraycan
	name = "Spraypaint Can"
	desc = "A can full of pressurized paint, for art and graffiti."
	item = /obj/item/toy/crayon/spraycan
	cost = 5

/datum/supplykit_item/tools/screwdriver
	name = "Screwdriver"
	desc = "For screwing around with screws."
	item = /obj/item/screwdriver
	cost = 2

/datum/supplykit_item/tools/wrench
	name = "Wrench"
	desc = "An adjustable tool for handling nuts."
	item = /obj/item/wrench
	cost = 2

/datum/supplykit_item/tools/weldingtool
	name = "Welding Tool"
	desc = "A basic torch for both welding and cutting."
	item = /obj/item/weldingtool
	cost = 2

/datum/supplykit_item/tools/crowbar
	name = "Crowbar"
	desc = "A solid hooked bar for prying things apart and killing headcrabs."
	item = /obj/item/crowbar
	cost = 2

/datum/supplykit_item/tools/multitool
	name = "Multitool"
	desc = "A piece of electronic equipment for working with wires."
	item = /obj/item/multitool
	cost = 2

/datum/supplykit_item/tools/wirecutters
	name = "Wire Cutters"
	desc = "A pair of snips for use in wiring."
	item = /obj/item/wirecutters
	cost = 2

/datum/supplykit_item/tools/extinguisher
	name = "Mini Fire Extinguisher"
	desc = "A compact extinguisher, for emergencies and freezing slimes."
	item = /obj/item/extinguisher/mini
	cost = 2

/datum/supplykit_item/tools/flarepouch
	name = "Flare Pouch"
	desc = "A small leather pouch containing a dozen flares."
	item = /obj/item/storage/fancy/flare_pouch
	cost = 5

/datum/supplykit_item/tools/glowpouch
	name = "Glowstick Pouch"
	desc = "A small leather pouch containing a dozen glowsticks."
	item = /obj/item/storage/fancy/flare_pouch/glowstick
	cost = 5



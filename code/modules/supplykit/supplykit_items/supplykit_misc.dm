
/* miscellaneous

//primary vars
/datum/supplykit_item/misc/
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



/datum/supplykit_item/misc/copper
	name = "Copper Coin"
	desc = "A single copper coin. chump change, really."
	item = /obj/item/stack/f13Cash/caps
	cost = 1
	important = TRUE

/datum/supplykit_item/misc/silver
	name = "Silver Coin"
	desc = "A single silver coin, worth ten coppers."
	item = /obj/item/stack/f13Cash/denarius
	cost = 10
	important = TRUE

/datum/supplykit_item/misc/gold
	name = "Gold Coin"
	desc = "A single shiny gold coin, worth 100 coppers. we're rich!"
	item = /obj/item/stack/f13Cash/aureus
	cost = 100
	important = TRUE

/datum/supplykit_item/misc/chameleon
	name = "Chameleon Mask"
	desc = "An adaptive disguise used to hide your identity and change your voice when you need to do a crime."
	item = /obj/item/clothing/mask/chameleon
	cost = 1 //cheap and affordable for all to use

/datum/supplykit_item/misc/thief
	name = "Thieve's Gloves"
	desc = "A pair of slick gloves that allow you to pickpocket without anyone's notice."
	item = /obj/item/clothing/gloves/thief
	cost = 20

/datum/supplykit_item/misc/lockpick
	name = "Lockpick Set"
	desc = "A set of tools for opening safe boxes and locked doors and airlocks."
	item = /obj/item/lockpick_set
	cost = 5

/datum/supplykit_item/misc/binoculars
	name = "Binoculars"
	desc = "Useful for scouting, or just taking in the sights."
	item = /obj/item/binoculars
	cost = 5

/datum/supplykit_item/misc/stealthboy
	name = "Stealthboy"
	desc = "A device worn on your belt that makes you almost impossible to see for a time. does not currently work for simpleminded creatures."
	item = /obj/item/stealthboy
	cost = 40

// /datum/supplykit_item/misc/whetstone
// 	name = "Whetstone"
// 	desc = "A stone for sharpening weapons of all types, strengthening their melee damage, can even be used on bottoms!"
// 	item = /obj/item/sharpener
// 	cost = 40

/datum/supplykit_item/misc/music
	name = "Musical Instrument"
	desc = "Your choice of a musical instrument, for bolstering the mood and wellbeing of those around you."
	item = /obj/item/choice_beacon/music
	cost = 5

/datum/supplykit_item/misc/tuner
	name = "Musical Tuner"
	desc = "A device used to tune your instrument, improving its sound quality and performance."
	item = /obj/item/musicaltuner
	cost = 10

/datum/supplykit_item/misc/hornoffense
	name = "Hunting Horn - Offense"
	desc = "A horn that bolsters the speed and melee power of those who hear it."
	item = /obj/item/huntinghorn/offense
	cost = 5

/datum/supplykit_item/misc/horndefense
	name = "Hunting Horn - Defense"
	desc = "A horn that bolsters the endurance and pain resistance of those who hear it."
	item = /obj/item/huntinghorn/defense
	cost = 5

/datum/supplykit_item/misc/hornutility
	name = "Hunting Horn - Utility"
	desc = "A horn that bolsters the reaction speed and stamina of those who hear it."
	item = /obj/item/huntinghorn/utility
	cost = 5

/datum/supplykit_item/misc/hornhealing
	name = "Hunting Horn - Healing"
	desc = "A horn that bolsters the health of and heals those who hear it."
	item = /obj/item/huntinghorn/healing
	cost = 5

/datum/supplykit_item/misc/bikehorn
	name = "Bike Horn"
	desc = "Honk."
	item = /obj/item/bikehorn
	cost = 5

/datum/supplykit_item/misc/radhood
	name = "Radiation Hood"
	desc = "Useful if you plan on spending a prolonged amount of time in a radioactive area."
	item = /obj/item/clothing/head/radiation
	cost = 1

/datum/supplykit_item/misc/radsuit
	name = "Radiation Suit"
	desc = "Useful if you plan on spending a prolonged amount of time in a radioactive area."
	item = /obj/item/clothing/suit/radiation
	cost = 4

/datum/supplykit_item/misc/geiger
	name = "Geiger Counter"
	desc = "An instrument that passively detects rises in local radiation levels. Very useful."
	item = /obj/item/geiger_counter
	cost = 5

/datum/supplykit_item/misc/beartrap
	name = "Bear Trap"
	desc = "A large intimidating leg trap."
	item = /obj/item/restraints/legcuffs/beartrap
	cost = 5

/datum/supplykit_item/misc/bola
	name = "Bola"
	desc = "A thrown device that entangles its target, slowing them down."
	item = /obj/item/restraints/legcuffs/bola
	cost = 5

/datum/supplykit_item/misc/jammer
	name = "Radio Jammer"
	desc = "A device that blocks radio signals, in case you need that."
	item = /obj/item/jammer
	cost = 5

/datum/supplykit_item/misc/trash
	name = "Random Trash"
	desc = "Some random trash you stuffed in your pack for some reason. who knows what you put in there."
	item = /obj/effect/spawner/lootdrop/f13/trash
	cost = 1

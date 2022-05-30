//FOR BOTH SUITS AND ARMORS BELONGING TO FACTIONS
//PLEASE PUT CUSTOM ARMORS IN f13armor.dm. All power armors are found in f13armor.dm.

//Raider
/obj/item/clothing/suit/armor/f13/raider
	name = "base raider armor"
	desc = "for testing"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25, "wound" = 35)
	strip_delay = 40
	slowdown = 0.05

/obj/item/clothing/suit/armor/f13/raider/supafly //melee spec
	name = "supa-fly raider armor"
	desc = "Fabulous mutant powers were revealed to me the day I held aloft my bumper sword and said...<br>BY THE POWER OF NUKA-COLA, I AM RAIDER MAN!"
	armor = list("melee" = 45, "bullet" = 20, "laser" = 20, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25, "wound" = 40)
	slowdown = 0.01
	icon_state = "supafly"
	item_state = "supafly"

/obj/item/clothing/suit/armor/f13/raider/supafly/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/rebel
	name = "rebel raider armor"
	desc = "Rebel, rebel. Your face is a mess."
	icon_state = "raider_rebel_icon"
	item_state = "raider_rebel_armor"

/obj/item/clothing/suit/armor/f13/raider/rebel/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/sadist
	name = "sadist raider armor"
	desc = "A bunch of metal chaps adorned with severed hands at the waist with a leather plate worn on the left shoulder. Very intimidating."
	icon_state = "sadist"
	item_state = "sadist"

/obj/item/clothing/suit/armor/f13/raider/sadist/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/blastmaster
	name = "blastmaster raider armor"
	desc = "A suit composed largely of blast plating, though there's so many holes it's hard to say if it will protect against much."
	icon_state = "blastmaster"
	item_state = "blastmaster"
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	armor = list("melee" = 40, "bullet" = 15, "laser" = 40, "bio" = 0, "bomb" = 90, "rad" = 0, "fire" = 25, "acid" = 25, "wound" = 40)
	flash_protect = 2

/obj/item/clothing/suit/armor/f13/raider/blastmaster/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/yankee
	name = "yankee raider armor"
	desc = "A set of armor made from bulky plastic and rubber. A faded sports team logo is printed in various places. Go Desert Rats!"
	icon_state = "yankee"
	item_state = "yankee"

/obj/item/clothing/suit/armor/f13/raider/yankee/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

// Edited desc to help the player figure out it got pockets, the "gimmick" it has.
/obj/item/clothing/suit/armor/f13/raider/badlands
	name = "badlands raider armor"
	desc = "A leather top with a bandolier over it and a straps that cover the arms."
	icon_state = "badlands"
	item_state = "badlands"
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bulletbelt

/obj/item/clothing/suit/armor/f13/raider/badlands/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/painspike
	name = "painspike raider armor"
	desc = "A particularly unhuggable armor, even by raider standards. Extremely spiky."
	icon_state = "painspike"
	item_state = "painspike"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)

/obj/item/clothing/suit/armor/f13/raider/painspike/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/iconoclast
	name = "iconoclast raider armor"
	desc = "A rigid armor set that appears to be fashioned from a radiation suit, or a mining suit."
	icon_state = "iconoclast"
	item_state = "iconoclast"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "bio" = 0, "rad" = 60, "fire" = 25, "acid" = 25, "wound" = 35)

/obj/item/clothing/suit/armor/f13/raider/iconoclast/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/combatduster
	name = "combat duster"
	desc = "An old military-grade pre-war combat armor under a weathered duster. It appears to be fitted with metal plates to replace the crumbling ceramic."
	armor = list("melee" = 25, "bullet" = 50, "laser" = 25, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	icon_state = "combatduster"
	item_state = "combatduster"
	slowdown = 0.07

/obj/item/clothing/suit/armor/f13/raider/combatduster/patrolduster
	name = "Patrol Duster"
	desc = "What appears to be an NCR patrol ranger's armor under a green tinted duster. The armor itself looks much more well kept then the duster itself, said duster looking somewhat faded. On the back of the duster, is a symbol of a skull with an arrow piercing through the eye."
	icon_state = "patrolduster"
	item_state = "patrolduster"

/obj/item/clothing/suit/armor/f13/raider/combatduster/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/exile
	name = "base faction exile armor"
	desc = "this is for testing."
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 20, "bomb" = 40, "bio" = 40, "rad" = 20, "fire" = 60, "acid" = 20)
	strip_delay = 30
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'

/obj/item/clothing/suit/armor/f13/exile/ncrexile
	name = "modified NCR armor"
	desc = "A modified detoriated armor kit consisting of NCR gear and scrap metal."
	icon_state = "ncrexile"
	item_state = "ncrexile"

/obj/item/clothing/suit/armor/f13/exile/ncrexile/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/exile/legexile
	name = "modified Legion armor"
	desc = "A modified detoriated armor kit consisting of Legion gear and scrap metal."
	armor = list("melee" = 40, "bullet" = 30, "laser" = 35, "energy" = 20, "bomb" = 40, "bio" = 40, "rad" = 20, "fire" = 60, "acid" = 20)
	icon_state = "legexile"
	item_state = "legexile"

/obj/item/clothing/suit/armor/f13/exile/legexile/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/exile/bosexile
	name = "modified Brotherhood armor"
	desc = "A modified detoriated armor kit consisting of brotherhood combat armor and scrap metal."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "exile_bos"
	item_state = "exile_bos"

/obj/item/clothing/suit/armor/f13/exile/bosexile/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/raidercombat
	name = "combat raider armor"
	desc = "An old military-grade pre-war combat armor. It appears to be fitted with metal plates to replace the crumbling ceramic."
	icon_state = "raider_combat"
	item_state = "raider_combat"
	armor = list("melee" = 40, "bullet" = 40 , "laser" = 40,"energy" = 25, "bomb" = 50, "bio" = 50, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.1

/obj/item/clothing/suit/armor/f13/raider/raidermetal
	name = "metal raider armor"
	desc = "A suit of welded, fused metal plates. Looks bulky, with great protection."
	icon_state = "raider_metal"
	item_state = "raider_metal"
	armor = list("melee" = 55, "bullet" = 35, "laser" = 55, "energy" = 25, "bomb" = 45, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0, "wound" = 40)
	resistance_flags = FIRE_PROOF
	slowdown = 0.25

//////////
//LEGION//
//////////

/obj/item/clothing/suit/armor/f13/legion
	name = "legion armor template"
	desc = "should not exist. Bugreport."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "legrecruit"
	item_state = "legarmor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	allowed = list(/obj/item/gun, /obj/item/melee/onehanded, /obj/item/throwing_star/spear, /obj/item/restraints/legcuffs/bola, /obj/item/twohanded, /obj/item/melee/powered, /obj/item/melee/smith, /obj/item/melee/smith/twohand)
	armor = list("melee" = 30, "bullet" = 30, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)
	slowdown = 0.05
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/tiny/legion
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2) // Because shit armor

/datum/component/storage/concrete/pockets/tiny/legion
	max_items = 3

/obj/item/clothing/suit/armor/f13/legion/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/legion/recruit
	name = "legion recruit armor"
	desc = "Well, it's better than nothing."
	icon_state = "legion_recruit"
	item_state = "legion_recruit"
	armor = list("melee" = 33, "bullet" = 25, "laser" = 5, "energy" = 10, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)
	slowdown = 0.04

/obj/item/clothing/suit/armor/f13/legion/recruit/decan
	name = "legion recruit armor"
	desc = "Recruit decanii receive slightly better protection than regular recruits. Slightly."
	armor = list("melee" = 45, "bullet" = 30, "laser" = 5, "energy" = 10, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/legion/prime
	name = "legion prime armor"
	desc = "Legion Primes have survived some skirmishes, and when promoted often recieve a set of armor, padded leather modeled on ancient baseball catcher uniforms and various plates of metal or boiled leather."
	icon_state = "legion_prime"
	item_state = "legion_prime"
	armor = list("melee" = 45, "bullet" = 30, "laser" = 10, "energy" = 10, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/legion/prime/decan
	name = "legion prime decanus armor"
	desc = "Legion prime decanus armor-an extra reinforced baseball uniform."
	armor = list("melee" = 45, "bullet" = 35, "laser" = 10, "energy" = 10, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/legion/orator
	name = "Legion Orator armor"
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of bracers, a chainmail skirt, and large pauldrons.  A tabard emblazoned with the bull is loosely draped over the torso."
	icon_state = "legion-orator"
	item_state = "legion-orator"
	armor = list("melee" = 50, "bullet" = 35, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/prime/slavemaster
	name = "slavemaster armor"
	desc = "Issued to slave masters to keep them cool during long hours of watching the slaves work in the sun."
	icon_state = "legion-master"
	item_state = "legion-master"

/obj/item/clothing/suit/armor/f13/legion/vet
	name = "legion veteran armor"
	desc = "Armor worn by veterans, salvaged bits of enemy armor and scrap metal often reinforcing the armor."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "legion_veteran"
	item_state = "legion_veteran"
	armor = list("melee" = 67, "bullet" = 37, "laser" = 25, "energy" = 15, "bomb" = 30, "bio" = 5, "rad" = 5, "fire" = 35, "acid" = 0, "wound" = 40)
	slowdown = 0.05
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4) // Slightly better armor

/obj/item/clothing/suit/armor/f13/legion/heavy
	name = "legion veteran decan armor"
	desc = "A Legion veterans armor reinforced with a patched bulletproof vest, the wearer has the markings of a Decanus."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "legion_heavy"
	item_state = "legion_heavy"
	armor = list("melee" = 70, "bullet" = 50, "laser" = 25, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0, "wound" = 50)
	slowdown = 0.1
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/suit/armor/f13/legion/vet/explorer
	name = "legion scout armor"
	desc = "Armor based on layered strips of laminated linen and leather, the technique giving it surprising resilience for low weight."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "legion_explorer"
	item_state = "legion_explorer"
	armor = list("melee" = 45, "bullet" = 35, "laser" = 15, "energy" = 10, "bomb" = 40, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)
	slowdown = 0.03

/obj/item/clothing/suit/armor/f13/legion/vet/vexil
	name = "legion vexillarius armor"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	desc = " Worn by Vexillarius, this armor has been reinforced with circular metal plates on the chest and a back mounted pole for the flag of the Bull, making the wearer easy to see at a distance."
	icon_state = "legion_vex"
	item_state = "legion_vex"
	armor = list("melee" = 70, "bullet" = 37, "laser" = 42, "energy" = 20, "bomb" = 25, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)
	slowdown = 0.12

/obj/item/clothing/suit/armor/f13/legion/venator
	name = "legion explorer armor"
	desc = "Explorer armor reinforced with metal plates and chainmail."
	icon_state = "legion_venator"
	item_state = "legion_venator"
	armor = list("melee" = 50, "bullet" = 35, "laser" = 20, "energy" = 20, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/suit/armor/f13/legion/centurion //good all around
	name = "legion centurion armor"
	desc = "Every Centurion is issued some of the best armor available in the Legion, and adds better pieces from slain opponents over time."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "legion_centurion"
	item_state = "legion_centurion"
	armor = list("melee" = 70, "bullet" = 45, "laser" = 45, "energy" = 25, "bomb" = 45, "bio" = 20, "rad" = 20, "fire" = 45, "acid" = 45, "wound" = 55)
	slowdown = 0.1
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 10) // Rest in pieces

/obj/item/clothing/suit/armor/f13/legion/palacent //laser resist spec
	name = "paladin-slayer centurion armor"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi' // Inconsistent naming, clean all of the sprites and code up sometime
	desc = "A Centurion able to defeat a Brotherhood Paladin gets the honorific title 'Paladin-Slayer', and adds bits of the looted armor to his own."
	icon_state = "legion_palacent"
	item_state = "legion_palacent"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 70, "energy" = 35, "bomb" = 35, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 75)
	slowdown = 0.3


/obj/item/clothing/suit/armor/f13/legion/rangercent //speed and bullet resist, sacrifices all else
	name = "ranger-hunter centurion armor"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	desc = "Centurions who have led many patrols and ambushes against NCR Rangers have a distinct look from the many looted pieces of Ranger armor, and are often experienced in skirmishing."
	icon_state = "legion_rangercent"
	item_state = "legion_rangercent"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 35, "energy" = 25, "bomb" = 35, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0, "wound" = 55)
	slowdown = 0.08

/obj/item/clothing/suit/armor/f13/legion/legate
	name = "legion legate armor"
	desc = " Made by the most skilled blacksmiths in Arizona, the bronzed steel of this rare armor offers good protection, and the scars on its metal proves it has seen use on the field."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "legion_legate"
	item_state = "legion_legate"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 60, "bullet" = 60, "laser" = 40, "energy" = 35, "bomb" = 45, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 15) // Wouldn't it be hilarious if we just tore apart Legate's armor?

/obj/item/clothing/suit/armor/f13/combat/legion
	name = "Legion combat armor"
	desc = "Pre-war military style armor, patched and missing some parts. Modified and repainted to declare the user a fighter for Caesar's Legion."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "legion_combat"
	item_state = "legion_combat"

/obj/item/clothing/suit/armor/f13/combat/mk2/legion
	name = "reinforced Legion combat armor"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	desc = "Pre-war military style armor, a full set with bracers and reinforcements. Modified and repainted to declare the user a fighter for Caesar's Legion."
	icon_state = "legion_combat2"
	item_state = "legion_combat2"

/obj/item/clothing/suit/armor/f13/slavelabor
	name = "old leather strips"
	desc = "Worn leather strips, used as makeshift protection from chafing and sharp stones by labor slaves."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "legion_slaveleather"
	item_state = "legion_slaveleather"
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	allowed = list(/obj/item/hatchet, /obj/item/scythe, /obj/item/cultivator, /obj/item/shovel)
	armor = list("melee" = 20, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 20, "fire" = 20, "acid" = 0)


/obj/item/clothing/suit/armor/f13/legion/vet/explorercanada
	name = "custom explorer armor"
	desc = "Armor based on layered strips of laminated linen and leather, the technique giving it surprising resilience for low weight. This one has been custom made."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "legion-explorercustom"
	item_state = "legion-explorercustom"
	armor = list("melee" = 45, "bullet" = 35, "laser" = 15, "energy" = 10, "bomb" = 40, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0, "wound" = 40)
	slowdown = 0.03
/*
/obj/item/clothing/suit/armor/f13/legion/vet/orator
	name = "legion orator armor"
	desc = "he armor appears to be based off of a suit of Legion veteran armor, with the addition of bracers, a chainmail skirt, and large pauldrons.  A tabard emblazoned with the bull is loosely draped over the torso."
	icon_state = "legheavy"

/obj/item/clothing/suit/armor/f13/legion/palacent/custom_excess
	name = "Champion of Kanab's Armor"
	desc = "(VI) The armor of the Champion and Conqueror of the city in Utah named Kanab. The armor is made up of pieces of Power Armor and pre-war Riot Gear, the shin guards are spraypainted a dark crimson and the Power Armour pauldron has a red trim. The symbol of a Pheonix is carefully engraved and painted upon the chest piece... I wonder what it means.."
	icon_state = "palacent_excess"
	item_state = "palacent_excess"
*/

//NCR
/obj/item/clothing/suit/armor/f13/utilityvest
	name = "utility vest"
	desc = "A practical vest with pockets for tools and such."
	icon_state = "vest_utility"
	item_state = "vest_utility"
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 10, "bomb" = 15, "bio" = 10, "rad" = 20, "fire" = 30, "acid" = 0, "wound" = 30)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/utility
	slowdown = 0.02

/datum/component/storage/concrete/pockets/utility
	max_items = 4

/obj/item/clothing/suit/armor/f13/utilityvest/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/utilityvest/logisticsofficer //same as his beret
	name = "logistics officer utility vest"
	desc = "A practical and armored vest with pockets for tools and such."
	armor = list("melee" = 15, "bullet" = 50, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 55)

/obj/item/clothing/suit/armor/f13/utilityvest/logisticsofficer/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/ncrarmor
	name = "NCR patrol vest"
	desc = "A standard issue NCR Infantry vest."
	icon_state = "ncr_infantry_vest"
	item_state = "ncr_infantry_vest"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 25, "bullet" = 42, "laser" = 40, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	slowdown = 0.1
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bulletbelt/ncr
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/datum/component/storage/concrete/pockets/bulletbelt/ncr
	max_items = 2

/obj/item/clothing/suit/armor/f13/ncrarmor/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/ncrarmor/mantle
	name = "NCR mantle vest"
	desc = "A standard issue NCR Infantry vest with a mantle on the shoulder."
	icon_state = "ncr_standard_mantle"
	item_state = "ncr_standard_mantle"

/obj/item/clothing/suit/armor/f13/ncrarmor/reserve
	name = "reserve NCR patrol vest"
	desc = "A standard issue NCR Infantry vest."
	icon_state = "ncr_infantry_vest"
	item_state = "ncr_infantry_vest"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 20, "bullet" = 30, "laser" = 10, "energy" = 20, "bomb" = 30, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/ncrarmor/conscript
	name = "NCR flak vest"
	desc = "A standard issue NCR Infantry vest reinforced with a thin kelvar sheet."
	icon_state = "ncr_kelvar_vest"
	item_state = "ncr_kelvar_vest"
	armor = list("melee" = 20, "bullet" = 30, "laser" = 10, "energy" = 20, "bomb" = 30, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	name = "NCR reinforced patrol vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad."
	icon_state = "ncr_reinforced_vest"
	item_state = "ncr_reinforced_vest"
	armor = list("melee" = 25, "bullet" = 44, "laser" = 40, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	slowdown = 0.12
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 3)

/obj/item/clothing/suit/armor/f13/ncrarmor/reinforced/engineer
	name = "NCR blast-padded reinforced patrol vest"
	desc = "A standard issue NCR Engineer vest reinforced with a groinpad."
	armor = list("melee" = 25, "bullet" = 44, "laser" = 40, "energy" = 20, "bomb" = 85, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)


/obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	name = "NCR reinforced mantle vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad and a mantle."
	icon_state = "ncr_reinforced_mantle"
	armor = list("melee" = 25, "bullet" = 44, "laser" = 40, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	slowdown = 0.12

/obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced/trenchraider
	name = "NCR reinforced trench mantle vest"
	desc = "A standard issue NCR Infantry vest with a really long name and extra melee plating."
	armor = list("melee" = 40, "bullet" = 42, "laser" = 40, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/ncrarmor/labcoat
	name = "NCR medical labcoat"
	desc = "An armored labcoat typically issued to NCR Medical Officers. It's a standard white labcoat with the Medical Officer's name stitched into the breast and a two headed bear sewn into the shoulder."
	icon_state = "ncr_labcoat"
	item_state = "ncr_labcoat"
	armor = list("melee" = 15, "bullet" = 50, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 55)
	allowed = list(/obj/item/gun, /obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	salvage_loot = list() // It's a labcoat

/obj/item/clothing/suit/armor/f13/ncrarmor/lieutenant
	name = "NCR officer vest"
	desc = "A reinforced set of NCR mantle armour, with added padding on the groin, neck and shoulders. Intended for use by the officer class."
	icon_state = "ncr_lt_armour"
	item_state = "ncr_lt_armour"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 50, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 50)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/treasurer

/obj/item/clothing/suit/armor/f13/ncrarmor/captain/ncr_officer_coat
	name = "NCR officer vest"
	desc = "A special issue NCR officer's armour with an added thick overcoat for protection from the elements."
	icon_state = "ncr_officer_coat"
	item_state = "ncr_officer_coat"
	armor = list("melee" = 25, "bullet" = 50, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 55)
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/suit/armor/f13/ncrarmor/captain
	name = "NCR reinforced officer vest"
	desc = "A heavily reinforced set of NCR mantle armour, with large ceramic plating fitted to cover the torso and back, with additional plating on the shoulders and arms. Intended for use by high ranking officers."
	icon_state = "ncr_captain_armour"
	item_state = "ncr_captain_armour"
	armor = list("melee" = 25, "bullet" = 50, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/treasurer
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 10) // Le captain

/obj/item/clothing/suit/armor/f13/ncrarmor/ncr_dressjack
	name = "NCR dress jacket"
	desc = "A brown dress uniform jacket intended for enlisted NCRA personnel."
	icon_state = "ncr_dressjack"
	item_state = "ncr_dressjack"
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 30)

/obj/item/clothing/suit/armor/f13/ncrarmor/ncr_codressjack
	name = "NCR dress jacket"
	desc = "A brown dress uniform jacket for commissioned NCRA personnel."
	icon_state = "ncr_codressjack"
	item_state = "ncr_codressjack"
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 30)

/obj/item/clothing/suit/armor/f13/combat/ncr/mutant
	name = "NCR mutant armor"
	desc = "Multiple sets of NCR patrol vests that have been fused, stitched and welded together in order to fit the frame of a Super Mutant."
	icon_state = "mutie_ncr"
	item_state = "mutie_ncr"

//NCR Ranger
/obj/item/clothing/suit/toggle/armor/f13/rangerrecon
	name = "ranger recon duster"
	desc = "A thicker than average duster worn by NCR recon rangers out in the field. It's not heavily armored by any means, but is easy to move around in and provides excellent protection from the harsh desert environment."
	icon_state = "duster_recon"
	item_state = "duster_recon"
	armor = list("melee" = 35, "bullet" = 45, "laser" = 25, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	slowdown = 0.05
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4)

/obj/item/clothing/suit/toggle/armor/f13/rangerrecon/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/trailranger
	name = "ranger vest"
	desc = "A quaint little jacket and scarf worn by NCR trail rangers."
	icon_state = "cowboyrang"
	item_state = "cowboyrang"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	slowdown = 0.01
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4)

/obj/item/clothing/suit/armor/f13/trailranger/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/modif_r_vest
	name = "subdued ranger vest"
	desc = "A quaint little jacket and scarf worn by NCR trail rangers. This one has the leather bleached and the scarf dyed black."
	icon_state = "modif_r_vest"
	item_state = "modif_r_vest"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	slowdown = 0.05
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4)

/obj/item/clothing/suit/armor/f13/modif_r_vest/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/combat/ncr_patrol
	name = "ranger patrol armor"
	desc = "A set of standard issue ranger patrol armor that provides defense similar to a suit of pre-war combat armor. It's got NCR markings, making it clear who it was made by."
	icon_state = "ncr_patrol"
	item_state = "ncr_patrol"
	armor = list("melee" = 30, "bullet" = 45, "laser" = 40, "energy" = 20, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30, "wound" = 40)

/obj/item/clothing/suit/armor/f13/combat/ncr_patrol/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/combat/ncr_patrol/mutant
	name = "mutant ranger armor"
	desc = "A set of standard issue ranger patrol armor that provides defense similar to a suit of pre-war combat armor. It's got NCR markings, making it clear who it was made by."
	icon_state = "mutie_ranger_armour"
	item_state = "mutie_ranger_armour"

/obj/item/clothing/suit/armor/f13/combat/ncr_patrol/thax
	name = "modified patrol armor"
	desc = "A customized and moderately-worn suit of patrol ranger armor. A sun-worn thick olive duster is worn over the armor."
	icon_state = "thaxarmor"
	item_state = "thaxarmor"

/obj/item/clothing/suit/armor/f13/rangercombat
	name = "veteran ranger combat armor"
	desc = "The NCR veteran ranger combat armor, or black armor consists of a pre-war L.A.P.D. riot suit under a duster with rodeo jeans. Considered one of the most prestigious suits of armor to earn and wear while in service of the NCR Rangers."
	icon_state = "ranger"
	item_state = "ranger"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	slowdown = 0.01
	armor = list("melee" = 40, "bullet" = 50, "laser" = 40, "energy" = 15, "bomb" = 55, "bio" = 60, "rad" = 60, "fire" = 90, "acid" = 20, "wound" = 55)
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 8)

/obj/item/clothing/suit/armor/f13/rangercombat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/ncrcfjacket
	name = "NCRCF jacket"
	icon_state = "ncrcfjacket"
	item_state = "ncrcfjacket"
	desc = "A cheap, standard issue teal canvas jacket issued to poor suckers who find themselves at the butt-end of the NCR's judiciary system."

//Brotherhood of Steel (PA in f13armor.dm)

/obj/item/clothing/suit/armor/f13/headscribe
	name = "brotherhood head scribe robe"
	desc = " A red cloth robe with gold trimmings, worn eclusively by the Head Scribe of a chapter."
	icon_state = "headscribe"
	item_state = "headscribe"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 10, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 36, "bio" = 50, "rad" = 69, "fire" = 10, "acid" = 70, "wound" = 30)

/obj/item/clothing/suit/f13/scribe
	name = "Brotherhood Scribe's robe"
	desc = "A red cloth robe worn by the Brotherhood of Steel Scribes."
	icon_state = "scribe"
	item_state = "scribe"
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list("melee" = 10, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 16, "bio" = 100, "rad" = 0, "fire" = 0, "acid" = 0, "wound" = 30)

/obj/item/clothing/suit/f13/seniorscribe
	name = "Brotherhood Senior Scribe's robe"
	desc = "A red cloth robe with silver gildings worn by the Brotherhood of Steel Senior Scribes."
	icon_state = "seniorscribe"
	item_state = "seniorscribe"
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list("melee" = 10, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 16, "bio" = 100, "rad" = 0, "fire" = 0, "acid" = 0, "wound" = 30)

/obj/item/clothing/suit/f13/elder
	name = "Brotherhood Elder's robe"
	desc = "A blue cloth robe with some scarlet red parts, traditionally worn by the Brotherhood of Steel Elder."
	icon_state = "elder"
	item_state = "elder"
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list("melee" = 20, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0, "wound" = 30)
	allowed = list(/obj/item/gun)

/obj/item/clothing/suit/armor/f13/combat/brotherhood
	name = "brotherhood armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Knights. It bears a red stripe."
	icon_state = "brotherhood_armor_knight"
	item_state = "brotherhood_armor_knight"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)

/obj/item/clothing/suit/armor/f13/combat/brotherhood/senior
	name = "brotherhood senior knight armor"
	desc = "A renforced combat armor set made by the Brotherhood of Steel, standard issue for all Senior Knights. It bears a silver stripe."
	icon_state = "brotherhood_armor_senior"
	item_state = "brotherhood_armor_senior"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)

/obj/item/clothing/suit/armor/f13/combat/brotherhood/captain
	name = "brotherhood head knight armor"
	desc = "A renforced combat armor set made by the Brotherhood of Steel, standard issue for all Head Knights. It bears golden embroidery."
	icon_state = "brotherhood_armor_captain"
	item_state = "brotherhood_armor_captain"
	armor = list("melee" = 55, "bullet" = 55, "laser" = 55, "energy" = 60, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)

/obj/item/clothing/suit/armor/f13/combat/brotherhood/initiate
	name = "initiate armor"
	desc = "An old degraded pre war combat armor, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor"
	item_state = "brotherhood_armor"
	slowdown = 0.13

/obj/item/clothing/suit/armor/f13/combat/brotherhood/initiate/mk2
	name = "reinforced knight armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prewar design This one is kitted with additional plates and, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor_mk2"
	item_state = "brotherhood_armor_mk2"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)
	slowdown = 0.13

/obj/item/clothing/suit/armor/f13/combat/brotherhood/outcast
	name = "brotherhood armor" //unused?
	desc = "A superior combat armor set made by the Brotherhood of Steel, bearing a series of red markings."
	icon_state = "brotherhood_armor_outcast"
	item_state = "brotherhood_armor_outcast"

//Oasis/Town
/obj/item/clothing/suit/armor/f13/town
	name = "town trenchcoat"
	desc = "A non-descript black trenchcoat."
	icon_state = "towntrench"
	item_state = "hostrench"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 33, "bullet" = 25, "laser" = 33,  "energy" = 25, "bomb" = 20, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10, "wound" = 40)
	slowdown = 0.025 // zoom zoom


/obj/item/clothing/suit/armor/f13/town/mayor
	name = "mayor trenchcoat"
	desc = "A symbol of the mayor's authority (or lack thereof). It has discrete armor plating in the lining, to foil assassination attempts."
	armor = list("melee" = 40, "bullet" = 35, "laser" = 40, "energy" = 30, "bomb" = 25, "bio" = 15, "rad" = 10, "fire" = 15, "acid" = 5, "wound" = 45)
	slowdown = 0.08

/obj/item/clothing/suit/armor/f13/town/sheriff
	name = "town combat coat"
	desc = " A trenchcoat which does not attempt to hide the full-body combat armor beneath it."
	icon_state = "towntrench_heavy"
	armor = list("melee" = 45, "bullet" = 50, "laser" = 45,  "energy" = 35, "bomb" = 30, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10, "wound" = 55)
	slowdown = 0.12

/obj/item/clothing/suit/armor/f13/town/chief
	name = "OPD Chief's jacket"
	desc = "A navy-blue jacket with blue shoulder designations, '/OPD/' stitched into one of the chest pockets, and hidden ceramic trauma plates. It has a small compartment for a holdout pistol."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_chief"
	item_state = "police_chief"
	armor = list("melee" = 45, "bullet" = 65, "laser" = 45,  "energy" = 35, "bomb" = 40, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10, "wound" = 55)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/holdout
	slowdown = 0.1  //CA statline

/obj/item/clothing/suit/armor/f13/town/chief/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/town/deputy
	name = "armored town trenchcoat"
	desc = "An armored trench coat with added shoulderpads, a chestplate, and legguards."
	icon_state = "towntrench_medium"
	armor = list("melee" = 45, "bullet" = 33, "laser" = 45,  "energy" = 35, "bomb" = 30, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10, "wound" = 50)
	slowdown = 0.08 //combat armor but less slowdown

/obj/item/clothing/suit/armor/vest/oasis
	name = "OPD vest"
	desc = "a lightweight ballistic vest that combines protection and comfort. This one has pockets sewn into the front and a badge pinned on it."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets
	armor = list("melee" = 15, "bullet" = 45, "laser" = 15,  "energy" = 30, "bomb" = 40, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10, "wound" = 50)
	icon_state = "blueshift"
	item_state = "blueshift"
	slowdown = 0.02

/obj/item/clothing/suit/armor/f13/metalarmor/steelbib/oasis
	name = "heavy steel breastplate"
	desc = "a steel breastplate, inspired by a pre-war design. Looks like oasis citizens added an additional layer of metal on the front face."
	icon_state = "steel_bib"
	item_state = "steel_bib"
	armor = list( "melee" = 30, "bullet" = 50, "laser" = 30, "energy" = 15, "bomb" = 20, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 45)
	slowdown = 0.1
	strip_delay = 5

//Great Khan
/obj/item/clothing/suit/armor/khan_jacket
	name = "khan armored jacket"
	desc = "The symbol of the greatest pushers."
	icon_state = "khan_jacket"
	item_state = "khan_jacket"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25,  "energy" = 25, "bomb" = 30, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10, "wound" = 37)
	slowdown = 0.05
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/armor/khan_jacket/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Wayfarer
/obj/item/clothing/suit/armor/f13/lightcloak
	name = "light tribal cloak"
	desc = "Light cloak armor, made of gecko skins and minor metal plating to protect against light weaponry, a favorite amongst scouts of the tribe."
	icon_state = "lightcloak"
	item_state = "lightcloak"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	slowdown = 0.05
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/suit/armor/f13/combat/tribal
	name = "tribal combat armor"
	desc = "An old military grade pre war combat armor, now decorated with sinew and the bones of the hunted for its new wearer."
	icon_state = "tribecombatarmor"
	item_state = "tribecombatarmor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/armor/f13/combat/mk2/tribal
	name = "tribal reinforced combat armor"
	desc = "An old military grade pre-war reinforced combat armor, now decorated with sinew and the bones of the hunted for its new wearer."
	icon_state = "tribecombatarmor"
	item_state = "tribecombatarmor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/armor/f13/tribe_armor
	name = "light tribal armor"
	desc = "Light armor made of leather stips and a large, flat piece of turquoise. Armor commonplace among the Wayfinders."
	icon_state = "tribal_armor"
	item_state = "tribal_armor"
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 25, "bomb" = 25, "bio" = 70, "rad" = 65, "fire" = 80, "acid" = 100, "wound" = 50)
	slowdown = 0.04

/obj/item/clothing/suit/armor/f13/tribe_heavy_armor
	name = "heavy tribal armor"
	desc = "Heavy armor make of sturdy leather and pieces of bone. Worn by seasoned veterans within the Wayfinder tribe."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "tribal_heavy"
	item_state = "tribal_heavy"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 35, "energy" = 30, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30, "wound" = 50)
	slowdown = 0.10

/obj/item/clothing/suit/armor/f13/lightcloak
	name = "light tribal cloak"
	desc = "Light cloak armor, made of gecko skins and minor metal plating to protect against light weaponry, a favorite amongst scouts of the tribe."
	icon_state = "lightcloak"
	item_state = "lightcloak"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 25, "bomb" = 25, "bio" = 70, "rad" = 65, "fire" = 80, "acid" = 100, "wound" = 50)
	slowdown = 0.025

/obj/item/clothing/suit/armor/f13/power_armor/t45b/tribal
	name = "tribal salvaged t45-b"
	desc = "A set of salvaged power armor, with certain bits of plating stripped out to retain more freedom of movement. No cooling module, though."
	icon_state = "tribal_power_armor"
	item_state = "tribal_power_armor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 65, "bullet" = 65, "laser" = 65, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 65)
	slowdown = 0.3
	requires_training = FALSE
	powered = FALSE

//Followers

//Vault

/obj/item/clothing/suit/armor/f13/riot/vault
	name = "VTCC riot armour"
	desc = "(VII) A suit of riot armour adapted from the design of the pre-war U.S.M.C. armour, painted blue and white."
	icon_state = "vtcc_riot_gear"
	item_state = "vtcc_riot_gear"
	armor = list("tier" = 7, "energy" = 35, "bomb" = 35, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)

//Old World Law Enforcement
//Police

/obj/item/clothing/suit/f13/police
	name = "police officer's jacket"
	desc = "A simple dark navy jacket, worn by police."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_officer"
	item_state = "police_officer"
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 20, "bio" = 5, "rad" = 0, "fire" = 15, "acid" = 5, "wound" = 30)

/obj/item/clothing/suit/f13/police/lieutenant
	name = "police lieutenant's jacket"
	desc = " A simple dark navy jacket, worn by police."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_lieutenant"
	item_state = "police_lieutenant"
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 20, "bio" = 5, "rad" = 0, "fire" = 15, "acid" = 5, "wound" = 30)

/obj/item/clothing/suit/f13/police/chief
	name = "police chief's jacket"
	desc = "A simple dark navy jacket, worn by police."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_chief"
	item_state = "police_chief"
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 20, "bio" = 5, "rad" = 0, "fire" = 15, "acid" = 5, "wound" = 30)


//Enclave

/obj/item/clothing/suit/armor/f13/enclave/marine
	name = "old United States Marine Corp Armor"
	desc = "An advanced model of combat armor worn by marines aboard the USS Democracy, second only to power armor in protection used by the USCM For various tasks and operations, it's handled the nuclear wasteland somewhat better than the rest of the armors you've seen."
	icon_state = "enclave_marine"
	item_state = "enclave_marine"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 50, "bullet" = 50, "laser" = 40, "energy" = 25, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)
	slowdown = 0.1

/obj/item/clothing/suit/armor/f13/enclave/marine/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/suit/armor/f13/usmcriot
	name = "old United States Marine Corp riot suit"
	desc = "A pre-war riot suit helmet used by the USCM For various tasks and operations, it's handled the nuclear wasteland somewhat better than the rest of the armors you've seen."
	icon_state = "usmc_riot_gear"
	item_state = "usmc_riot_gear"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 50, "bullet" = 50, "laser" = 40, "energy" = 22, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)

/obj/item/clothing/suit/armor/f13/usmcriot/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/enclavetrenchcoat
	name = "enclave officer trenchcoat"
	desc = "Premium prewar military armor worn under a coat for Enclave officers."
	icon_state = "armor_enclave_officer"
	item_state = "armor_enclave_officer"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 22, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 55)

/obj/item/clothing/suit/armor/f13/enclavetrenchcoat/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/environmentalsuit
	name = "enclave envirosuit"
	desc = "An advanced white and airtight environmental suit. It seems to be equipped with a fire-resistant seal and a refitted internals system. This one looks to have been developed by the Enclave sometime after the Great War. You'd usually exclusively see this on scientists of the Enclave."
	icon_state = "envirosuit"
	item_state = "envirosuit"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 25, "bullet" = 15, "laser" = 45, "energy" = 33, "bomb" = 45, "bio" = 100, "rad" = 100, "fire" = 50, "acid" = 10, "wound" = 30)
	strip_delay = 60
	equip_delay_other = 60
	flags_inv = HIDEJUMPSUIT
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/clothing/suit/armor/f13/combat/mk2/remnant
	name = "remnant combat armor"
	desc = "A dark armor, used commonly in espionage or shadow ops."
	icon_state = "remnant"
	item_state = "remnant"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 22, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 55)


//THE GRAVEYARD
//UNUSED or LEGACY - RETAINED IN CASE DESIRED FOR ADMIN SPAWN OR REIMPLEMENATION. MAY NOT BE EVERYTHING THAT'S UNUSED. TEST BEFORE USING
//IF PUT BACK INTO USE, PLEASE FILE IT BACK SOMEWHERE ABOVE

/obj/item/clothing/suit/armor/f13/town/embroidered
	name = "embroidered trenchcoat"
	desc = "A custom armored trench coat with extra-length and a raised collar. There's a flower embroidered onto the back, although the color is a little faded."
	icon_state = "towntrench_special"
	item_state = "towntrench_special"
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 40, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 55)

/obj/item/clothing/suit/armor/f13/rangercombat/eliteriot
	name = "elite riot gear"
	desc = "A heavily reinforced set of military grade armor, commonly seen in the Divide now repurposed and reissued to Chief Rangers."
	icon_state = "elite_riot"
	item_state = "elite_riot"
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 40, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 55)
	icon = 'icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/rangercombat/desert
	name = "desert ranger combat armor"
	desc = "This is the original armor the NCR Ranger Combat armor was based off of. An awe inspiring suit of armor used by the legendary Desert Rangers."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"

//NCR

/obj/item/clothing/suit/armor/f13/rangerrig
	name = "chest gear harness"
	desc = "a handmade tactical rig. The actual rig is made of a black, fiberous cloth, being attached to a dusty desert-colored belt. A flask and two ammo pouches hang from the belt."
	icon_state = "r_gear_rig"
	item_state = "r_gear_rig"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	slowdown = 0.05
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bulletbelt/ncr

/obj/item/clothing/suit/armor/f13/combat/ncr_patrol/scout
	name = "ranger scout armor"
	desc = "A refurbished set of NCRA 3rd Scouts armor, now with heavier plating together with arm and leg guards. A two-headed bear has been painted on its chest."
	icon_state = "refurb_scout"
	item_state = "refurb_scout"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/ncrarmor/scout
	name = "NCR 3rd Scout combat armor"
	desc = "A specialized variant of combat armor issued to members of the 3rd Scout Battalion."
	icon_state = "scoutarmor"
	item_state = "scoutarmor"
	slowdown = 0.01

/obj/item/clothing/suit/armor/f13/ncrarmor/scout/veteran
	name = "NCR 3rd Scout veteran combat armor"
	desc = "A specialized variant of combat armor issued to veteran members of the 3rd Scout Battalion."
	slowdown = 0.01

/obj/item/clothing/suit/armor/f13/ncrarmor/scout/officer
	name = " NCR 3rd Scout officer combat armor"
	icon_state = "scout_armor_lt"
	item_state = "scout_armor_lt"
	desc = "A specialized variant of combat armor issued to officers of the 3rd Scout Battalion."
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)

/obj/item/clothing/suit/armor/f13/combat/ncr
	name = "NCR combat armor"
	desc = "An old military grade pre war combat armor and, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_armor"
	item_state = "ncr_armor"

/obj/item/clothing/suit/armor/f13/combat/mk2/ncr
	name = "reinforced NCR combat armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prewar design. This one is kitted with additional plates and, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_armor_mk2"
	item_state = "ncr_armor_mk2"


//Enclave/Remnants

/obj/item/clothing/suit/armor/f13/combat/enclave
	name = "enclave combat armor"
	desc = "An old set of pre-war combat armor, painted black."
	icon_state = "enclave_new"
	item_state = "enclave_new"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)

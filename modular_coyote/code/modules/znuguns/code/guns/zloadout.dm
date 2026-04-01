/*

/datum/gear/weapon/tier0
	cost = 0

/datum/gear/weapon/tier1
	cost = 2

/datum/gear/weapon/tier2
	cost = 4

/datum/gear/weapon/tier3
	cost = 6

*/

/datum/gear/weapon
	category = LOADOUT_CATEGORY_BACKPACK
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_BACKPACKS
	slot = SLOT_IN_BACKPACK

/datum/gear/weapon/tier0
	cost = 0

/datum/gear/weapon/tier1
	cost = 2

/datum/gear/weapon/tier2
	cost = 4

/datum/gear/weapon/tier3
	cost = 6


/datum/gear/weapon/tier1/tribalkit
	name = "Tribal weapon kit"
	path = /obj/item/kit_spawner/tribal

/datum/gear/weapon/tier2/civkit
	name = "Civillian weapon kit"
	path = /obj/item/kit_spawner/townie

/datum/gear/weapon/tier2/civkit2
	name = "Second Civillian weapon kit"
	path = /obj/item/kit_spawner/townie

/datum/gear/weapon/tier2/civkit3
	name = "Third Civillian weapon kit"
	path = /obj/item/kit_spawner/townie

/datum/gear/weapon/tier2/civkit4
	name = "Fourth Civillian weapon kit"
	path = /obj/item/kit_spawner/townie

/datum/gear/weapon/tier2/civkit5
	name = "Fifth Civillian weapon kit"
	path = /obj/item/kit_spawner/townie


/datum/gear/weapon/tier3/premkit
	name = "Techy (premium) weapon kit"
	path = /obj/item/kit_spawner/bos/combat


//MAGIC STUFF

/datum/gear/magic
	category = LOADOUT_CATEGORY_BACKPACK
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_WIZARDS
	slot = SLOT_IN_BACKPACK

/datum/gear/magic/tier0
	cost = 0

/datum/gear/magic/tier1
	cost = 2

/datum/gear/magic/tier2
	cost = 4

/datum/gear/magic/tier3
	cost = 6

// TIER 0 (LITERALLY FREE) //

/datum/gear/magic/tier0/basiczappies
	name = "Rod of Sparks"
	path = /obj/item/gun/magic/wand/kelpmagic/basiczappies

/datum/gear/magic/tier0/triheal
	name = "Staff of Unstable Healings"
	path = /obj/item/gun/magic/staff/healing/triheal

// TIER 1 //

/datum/gear/magic/tier1/magicmissile
	name = "Improvised Wand of Magic Missile"
	path = /obj/item/gun/magic/wand/kelpmagic/magicmissile

/datum/gear/magic/tier1/offensehuntinghorn
	name = "Offensive Hunting Horn"
	path = /obj/item/huntinghorn/offense

/datum/gear/magic/tier1/defensivehuntinghorn
	name = "Defensive Hunting Horn"
	path = /obj/item/huntinghorn/defense

/datum/gear/magic/tier1/utilityhuntinghorn
	name = "Utility Hunting Horn"
	path = /obj/item/huntinghorn/utility

/datum/gear/magic/tier1/healinghuntinghorn
	name = "Healing Hunting Horn"
	path = /obj/item/huntinghorn/healing

// TIER 2 //

/datum/gear/magic/tier2/acidstaff
	name = "Lesser Staff of Acid"
	path = /obj/item/gun/magic/staff/kelpmagic/acidstaff/lowpower

/datum/gear/magic/tier2/magma
	name = "Lesser Staff of Magma"
	path = /obj/item/gun/magic/staff/kelpmagic/flamethrower/weak

/datum/gear/magic/tier2/fireball
	name = "Lesser Staff of Fireball"
	path = /obj/item/gun/magic/staff/kelpmagic/fireball/lowpower

/datum/gear/magic/tier2/fireball
	name = "Lesser Staff of Lightening"
	path = /obj/item/gun/magic/staff/kelpmagic/lightning/lowpower

/datum/gear/magic/tier2/fireball
	name = "Lesser Staff of Healing"
	path = /obj/item/gun/medbeam/magic/lowpower

/datum/gear/magic/tier2/fireball
	name = "Necronomicon"
	path = /obj/item/holotribal_injector

// TIER 3 //

/datum/gear/magic/tier3/nullrod
	name = "Nullrod"
	path = /obj/item/nullrod

/datum/gear/magic/tier3/healingstaff
	name = "Perfected Healing Staff"
	path = /obj/item/gun/medbeam/magic

/datum/gear/magic/tier3/healwand
	name = "Healing Wand"
	path = /obj/item/gun/magic/wand/kelpmagic/healwand

// UTILITY ITEMS!!!! //
/datum/gear/utility
	category = LOADOUT_CATEGORY_BACKPACK
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_STUFF
	slot = SLOT_IN_BACKPACK

/datum/gear/utility/tier0
	cost = 0

/datum/gear/utility/tier1
	cost = 1

/datum/gear/utility/tier2
	cost = 2

/datum/gear/utility/tier3
	cost = 3

/datum/gear/utility/tier4
	cost = 4

/datum/gear/utility/tier6
	cost = 6
// TIER 0 STUFF // 

/datum/gear/utility/tier0/smithyhammer
	name = "Smithing Hammer"
	path = /obj/item/melee/smith/hammer/premade

/datum/gear/utility/tier0/spritz
	name = "Spray Cleaner"
	path = /obj/item/reagent_containers/spray/cleaner

/datum/gear/utility/tier0/mop
	name = "Advanced Mop"
	path = /obj/item/mop/advanced

/datum/gear/utility/tier0/broomin
	name = "Broom"
	path = /obj/item/broom
	
/datum/gear/utility/tier0/soop
	name = "Soap"
	path = /obj/item/soap

/datum/gear/utility/tier0/scannin
	name = "Ore Scanner"
	path = /obj/item/t_scanner/adv_mining_scanner/lesser

/datum/gear/utility/tier0/drillin
	name = "Mining Drill"
	path = /obj/item/pickaxe/drill

/datum/gear/utility/tier0/cummunicatin
	name = "Basic Radio"
	path = /obj/item/radio/tribal

/datum/gear/utility/tier0/paintin
	name = "Warpaint Bowl"
	path = /obj/item/warpaint_bowl

/datum/gear/utility/tier0/bikonnockulars
	name = "Binoculars"
	path = /obj/item/binoculars
	
/datum/gear/utility/tier4/stealthboy
	name = "Stealth Module"
	path = /obj/item/stealthboy

/datum/gear/utility/tier0/flashdark
	name = "Flash DARK"
	path = /obj/item/flashlight/flashdark

// TIER 1 STUFF //

/datum/gear/utility/tier1/mountgear
	name = "Riding Gear and Mount"
	path = /obj/item/storage/box/tools/ranching

/datum/gear/utility/tier1/ball
	name = "Capture Device"
	path = /obj/item/capturedevice

/datum/gear/utility/tier1/fartsalts
	name = "Smelling Salts"
	path = /obj/item/smelling_salts

// TIER 2 STUFF //
/datum/gear/utility/tier2/surgibag
	name = "Surgical Bag"
	path = /obj/item/storage/backpack/duffelbag/med/surgery

/datum/gear/utility/tier2/biosynth
	name = "BioSynth Reanimator Injector"
	path = /obj/item/holoparasite_injector

// TIER 3 STUFF //

// TIER 4 STUFF //

// TIER 6 STUFF //

/datum/gear/utility/tier6/medbeam
	name = "Medbeam"
	path = /obj/item/gun/medbeam






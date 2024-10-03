/datum/gear/backpack
	category = LOADOUT_CATEGORY_BACKPACK
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_GENERAL
	slot = SLOT_IN_BACKPACK
	cost = 1

/datum/gear/backpack/flashlight
	name = "flashlight"
	path = /obj/item/flashlight
	cost = 0

/datum/gear/backpack/hairbrush
	name = "hairbrush"
	path = /obj/item/hairbrush
	cost = 0

/datum/gear/backpack/torch
	name = "torch"
	path = /obj/item/flashlight/flare/torch
	cost = 0

/*
/datum/gear/backpack/redwater
	name = "contraband radio"
	path = /obj/item/radio/redwater
	cost = 0

/datum/gear/backpack/denid
	name = "contraband keycard"
	path = /obj/item/card/id/denid
	cost = 0
*/

/datum/gear/backpack/tattoo_kit
	name = "Tattoo kit"
	path = /obj/item/storage/box/tattoo_kit
	cost = 0

/datum/gear/backpack/necklace //this is here because loadout doesn't support proper accessories
	name = "Renameable Necklace"
	path = /obj/item/clothing/accessory/necklace

/datum/gear/backpack/tape
	name = "Spare Cassette Tape"
	path = /obj/item/tape/random

/datum/gear/backpack/tapeplayer
	name = "Taperecorder"
	path = /obj/item/taperecorder

/datum/gear/backpack/razor
	name = "electric razor"
	path = /obj/item/razor

/datum/gear/backpack/donuts
	name = "donut box"
	path = /obj/item/storage/fancy/donut_box
	cost = 2

/datum/gear/backpack/locksmith
	name = "locksmith box"
	path = /obj/item/storage/box/tools/locksmith
	cost = 2

//// "Toys" -- toys going back to general subcategory till we have more of them

/datum/gear/backpack/crayons
	name = "Box of Crayons"
	path = /obj/item/storage/crayons
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_GENERAL

/datum/gear/backpack/toykatana
	name = "Toy Katana"
	path = /obj/item/toy/katana
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_GENERAL

//// Pens - not catagorized

/datum/gear/backpack/pen
	name = "Pen"
	path = /obj/item/pen

/datum/gear/backpack/pen/red
	name = "Fountain Pen"
	path = /obj/item/pen/fountain

/datum/gear/backpack/pen/blue
	name = "Blue Pen"
	path = /obj/item/pen/blue

/datum/gear/backpack/pen/fountainpen
	name = "Red Pen"
	path = /obj/item/pen/red

/datum/gear/backpack/pen/multipen
	name = "Multicolored Pen"
	path = /obj/item/pen/fourcolor

/datum/gear/backpack/pen/charcoal
	name = "Charcoal stylus"
	path = /obj/item/pen/charcoal

/datum/gear/backpack/pen/captain
	name = "Fountain Pen"
	path = /obj/item/pen/fountain/captain


/* //// Belts, not alot of belts in the catagory to make there own.

/datum/gear/backpack/redbelt
	name = "primitive belt"
	path = /obj/item/storage/belt/utility/mining/primitive
	cost = 3

/datum/gear/backpack/fannypack
	name = "fannypack"
	path = /obj/item/storage/belt/fannypack
	cost = 3 */ // 'Moved' to belt_loadout.dm

//// Cigarettes here, they dont need a special category

/datum/gear/backpack/cigarettes/cigpack_improper
	name = "cigarette pack"
	path = /obj/item/storage/fancy/cigarettes

/datum/gear/backpack/cigarettes/cigpack_bigboss
	name = "Big Boss Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_bigboss

/datum/gear/backpack/cigarettes/cigpack_pyramid
	name = "Pyramid Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_pyramid

/datum/gear/backpack/cigarettes/cigpack_greytort
	name = "Grey Tortoise Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_greytort
	cost = 2

/datum/gear/backpack/cigarettes/carp_classic
	name = "Carp Classic Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_carp

/datum/gear/backpack/cigarettes/robust_gold
	name = "Robust Gold Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_robustgold

/datum/gear/backpack/cigarettes/uplift_smooth
	name = "Uplift Smooth Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_uplift

/datum/gear/backpack/cigarettes/freak_brothers
	name = "Freak Brothers' Special Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_cannabis

/datum/gear/backpack/cigarettes/shady_jims
	name = "Shady Jim's Super Slims Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_shadyjims

/datum/gear/backpack/cigarettes/xeno_filtered
	name = "Xeno Filtered Smokes"
	path = /obj/item/storage/fancy/cigarettes/cigpack_xeno
	cost = 4 //It has Regen Jelly in each cigarette, that's the reason for the cost -Risingstarslash

/datum/gear/backpack/cigarettes/cigars
	name = "Premium cigar case"
	path = /obj/item/storage/fancy/cigarettes/cigars

/datum/gear/backpack/cigarettes/cigars/cohiba
	name = "Cohiba Robusto cigar case"
	path = /obj/item/storage/fancy/cigarettes/cigars/cohiba

/datum/gear/backpack/cigarettes/cigars/havana
	name = "Havanian cigar case"
	path = /obj/item/storage/fancy/cigarettes/cigars/havana

/datum/gear/backpack/coinpouch
	name = "coin pouch"
	path = /obj/item/storage/wallet/stash/pouch
	cost = 1

/////////////////////
//Coyote Additions//
////////////////////

//// Rations and snacks!

/datum/gear/backpack/snack/lollipop
	name = "Lollipop"
	path = /obj/item/reagent_containers/food/snacks/lollipop
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_1
	name = "Ration - Brahmin BBQ"
	path = /obj/item/storage/box/ration/menu_one
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 2 //lollipop and grey tort

/datum/gear/backpack/snack/ration_2
	name = "Ration - Glazed Sausage"
	path = /obj/item/storage/box/ration/menu_two
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_3
	name = "Ration - Chocoguana"
	path = /obj/item/storage/box/ration/menu_three
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_4
	name = "Ration - Stagsteak"
	path = /obj/item/storage/box/ration/menu_four
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_5
	name = "Ration - Squeakpie"
	path = /obj/item/storage/box/ration/menu_five
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 2 //bonus lollipop heals

/datum/gear/backpack/snack/ration_6
	name = "Ration - Hillhogger"
	path = /obj/item/storage/box/ration/menu_six
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_7
	name = "Ration - Burger"
	path = /obj/item/storage/box/ration/menu_seven
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_8
	name = "Ration - Veggie"
	path = /obj/item/storage/box/ration/menu_eight
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 2

/datum/gear/backpack/snack/ration_9
	name = "Ration - Fillet"
	path = /obj/item/storage/box/ration/menu_nine
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_10
	name = "Ration - Bearballs"
	path = /obj/item/storage/box/ration/menu_ten
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_11
	name = "Ration - Hotdawg"
	path = /obj/item/storage/box/ration/menu_eleven
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 2 //lollipop

/datum/gear/backpack/snack/ration_breakfast
	name = "Ration - Breakfast"
	path = /obj/item/storage/box/ration/ranger_breakfast
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_lunch
	name = "Ration - Lunch"
	path = /obj/item/storage/box/ration/ranger_lunch
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

/datum/gear/backpack/snack/ration_dinner
	name = "Ration - Dinner"
	path = /obj/item/storage/box/ration/ranger_dinner
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_RATIONS
	cost = 1

//Skirt Accessories

/datum/gear/backpack/pinkishskirt
	name = "Pinkish Skirt"
	path = /obj/item/clothing/accessory/pinkishskirt
	cost = 1

/datum/gear/backpack/brownskirt
	name = "Brown Skirt"
	path = /obj/item/clothing/accessory/brownskirt
	cost = 1

/datum/gear/backpack/reddishskirt
	name = "Reddish Skirt w/ Belt"
	path = /obj/item/clothing/accessory/priestess
	cost = 1
/datum/gear/backpack/greenandpurpleskirt
	name = "Green and Purple Skirt"
	path = /obj/item/clothing/accessory/greenfrillyskirt
	cost = 1
/datum/gear/backpack/blackandwhiteskirt
	name = "Black and White Checker Skirt"
	path = /obj/item/clothing/accessory/checkerskirt
	cost = 1
/datum/gear/backpack/maidskirt
	name = "Maid Skirt"
	path = /obj/item/clothing/accessory/maidskirt
	cost = 1
/datum/gear/backpack/plaidredlongskirt
	name = "Plaid Skirt - Red, Long"
	path = /obj/item/clothing/accessory/plaidredlongskirt
	cost = 1

/datum/gear/backpack/plaidredshortskirt
	name = "Plaid Skirt - Red, Short"
	path = /obj/item/clothing/accessory/plaidredshortskirt
	cost = 1

/datum/gear/backpack/plaidbluelongskirt
	name = "Plaid Skirt - Blue, Long"
	path = /obj/item/clothing/accessory/plaidbluelongskirt
	cost = 1

/datum/gear/backpack/plaidblueshortskirt
	name = "Plaid Skirt - Blue, Short"
	path = /obj/item/clothing/accessory/plaidblueshortskirt
	cost = 1

/datum/gear/backpack/plaidpurplelongskirt
	name = "Plaid Skirt - Purple, Long"
	path = /obj/item/clothing/accessory/plaidpurplelongskirt
	cost = 1

/datum/gear/backpack/plaidpurpleshortskirt
	name = "Plaid Skirt - Purple, Short"
	path = /obj/item/clothing/accessory/plaidpurpleshortskirt
	cost = 1

/datum/gear/backpack/plaidgreenlongskirt
	name = "Plaid Skirt - Green, Long"
	path = /obj/item/clothing/accessory/plaidgreenlongskirt
	cost = 1

/datum/gear/backpack/plaidgreenshortskirt
	name = "Plaid Skirt - Green, Short"
	path = /obj/item/clothing/accessory/plaidgreenshortskirt
	cost = 1

/datum/gear/backpack/engineskirt
	name = "Orange and Yellow Skirt"
	path = /obj/item/clothing/accessory/engineskirt
	cost = 1

/datum/gear/backpack/cmoskirt
	name = "Soft Blue and White Skirt"
	path = /obj/item/clothing/accessory/cmoskirt
	cost = 1

/datum/gear/backpack/hopskirt
	name = "Navy Blue Skirt"
	path = /obj/item/clothing/accessory/hopskirt
	cost = 1

/datum/gear/backpack/draculass
	name = "Goth Skirt w/ Stockings"
	path = /obj/item/clothing/accessory/draculass
	cost = 1

/datum/gear/backpack/prisonerskirt
	name = "Orange Skirt w/ Belt"
	path = /obj/item/clothing/accessory/prisonerskirt
	cost = 1

/datum/gear/backpack/ncrcfjacket
	name = "Cropped Denim Jacket - Accessory"
	path = /obj/item/clothing/accessory/ncrfjacketcrop
	cost = 1

/datum/gear/backpack/chestpatch
	name = "generic patch (chest)"
	path = /obj/item/clothing/accessory/patch
	cost = 0

/datum/gear/backpack/armpatch
	name = "generic patch (arm)"
	path = /obj/item/clothing/accessory/patch/arm
	cost = 0

/datum/gear/backpack/headphones
	name = "Headphones"
	path = /obj/item/clothing/ears/headphones
	cost = 1

/datum/gear/backpack/holotag
	name = "Broken Holotag"
	path = /obj/item/card/id/rusted/brokenholodog
	cost = 0

/datum/gear/backpack/dogtag
	name = "Rusted tags"
	path = /obj/item/card/id/rusted
	cost = 0

/datum/gear/backpack/vaultid
	name = "Faded ID card"
	path = /obj/item/card/id/rusted/fadedvaultid
	cost = 0

/datum/gear/backpack/id
	name = "Reprogramable ID"
	path =  /obj/item/card/id/selfassign
	cost = 1

/datum/gear/backpack/twocolorcollar
	name = "Two Color Lockable Leather Collar"
	path = /obj/item/clothing/neck/petcollar/choker

/datum/gear/backpack/onecolorcollar
	name = "One Color Lockable Leather Collar"
	path = /obj/item/clothing/neck/petcollar/locked
	cost = 1

/datum/gear/backpack/shockcollar
	name = "Kinky Shock Collar"
	path = /obj/item/electropack/shockcollar
	cost = 1

/datum/gear/backpack/shockcollarshimusa
	name = "Kinky Shock Collar w/ Shackles"
	path = /obj/item/electropack/shockcollar/shimsusa_shackles
	cost = 1

//Cameras

/datum/gear/backpack/camera/early
	name  = "early camera"
	path = /obj/item/camera/early
	cost = 3

/datum/gear/backpack/camera/earlymodern
	name  = "early modern camera"
	path = /obj/item/camera/earlymodern
	cost = 3

/datum/gear/backpack/camera/coldwar
	name  = "coldwar camera"
	path = /obj/item/camera/coldwar
	cost = 3

/datum/gear/backpack/firebow
	name  = "Tribal Firestarter"
	path = /obj/item/firebow
	cost = 0

/datum/gear/backpack/broom
	name  = "Broom staff"
	path = /obj/item/staff/broom
	cost = 0

//pride pins

/datum/gear/backpack/pride
	name  = "Pride Pin"
	path = /obj/item/clothing/accessory/pride
	cost = 0

/datum/gear/backpack/pride/bi
	name  = "Bisexual Pride Pin"
	path = /obj/item/clothing/accessory/pride/bi
	cost = 0

/datum/gear/backpack/pride/trans
	name  = "Transgender Pride Pin"
	path = /obj/item/clothing/accessory/pride/trans
	cost = 0

/datum/gear/backpack/pride/ace
	name  = "Asexual Pride Pin"
	path = /obj/item/clothing/accessory/pride/ace
	cost = 0

/datum/gear/backpack/pride/enby
	name  = "Nonbinary Pride Pin"
	path = /obj/item/clothing/accessory/pride/enby
	cost = 0

/datum/gear/backpack/pride/lesbian
	name  = "Lesbiab Pride Pin"
	path = /obj/item/clothing/accessory/pride/lesbian
	cost = 0

/datum/gear/backpack/pride/intersex
	name  = "Intersex Pride Pin"
	path = /obj/item/clothing/accessory/pride/intersex
	cost = 0

/datum/gear/backpack/deafpin
	name  = "Deaf Personal Pin"
	path = /obj/item/clothing/accessory/deafpin
	cost = 0

/datum/gear/backpack/sheriffvest
	name  = "Cowboy Vest"
	path = /obj/item/clothing/accessory/sheriffvest
	cost = 0

/datum/gear/backpack/braceletpair
	name = "Bracelet (pair)"
	path = /obj/item/clothing/accessory/braceletpair
	cost = 1

/datum/gear/backpack/lipstick
	name = "Red lipstick"
	path = /obj/item/lipstick
	cost = 0
/datum/gear/backpack/lipstick_purple
	name = "Purple lipstick"
	path = /obj/item/lipstick/purple
	cost = 0
/datum/gear/backpack/lipstick_jade
	name = "Jade lipstick"
	path = /obj/item/lipstick/jade
	cost = 0
/datum/gear/backpack/lipstick_black
	name = "Black lipstick"
	path = /obj/item/lipstick/black
	cost = 0
/datum/gear/backpack/lipstick_random
	name = "Random lipstick"
	path = /obj/item/lipstick/random
	cost = 0

/datum/gear/backpack/nailpolish
	name = "Midnight nailpolish"
	path = /obj/item/nailpolish
	cost = 0
/datum/gear/backpack/nailpolish_red
	name = "Red nailpolish"
	path = /obj/item/nailpolish/red
	cost = 0
/datum/gear/backpack/nailpolish_blue
	name = "Blue nailpolish"
	path = /obj/item/nailpolish/blue
	cost = 0
/datum/gear/backpack/nailpolish_aqua
	name = "Aqua nailpolish"
	path = /obj/item/nailpolish/aqua
	cost = 0
/datum/gear/backpack/nailpolish_black
	name = "Black nailpolish"
	path = /obj/item/nailpolish/black
	cost = 0
/datum/gear/backpack/nailpolish_white
	name = "White nailpolish"
	path = /obj/item/nailpolish/white
	cost = 0
/datum/gear/backpack/nailpolish_navy
	name = "Navy nailpolish"
	path = /obj/item/nailpolish/navy
	cost = 0
/datum/gear/backpack/nailpolish_yellow
	name = "Yellow nailpolish"
	path = /obj/item/nailpolish/yellow
	cost = 0
/datum/gear/backpack/nailpolish_purple
	name = "Purple nailpolish"
	path = /obj/item/nailpolish/purple
	cost = 0

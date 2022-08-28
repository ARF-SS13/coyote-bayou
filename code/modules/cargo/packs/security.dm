
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Security ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/security
	group = "Munitions"
	access = ACCESS_SECURITY
	crate_type = /obj/structure/closet/crate/footlocker
	can_private_buy = FALSE

/datum/supply_pack/security/ammosurplus
	name = "Ammo Crate - Grab-Bag"
	desc = "Contains a whole stuffing of bullets, magazines, casings. Probably overpriced."
	cost = 2000
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3)
	crate_name = "ammo crate"

/datum/supply_pack/security/helmets
	name = "Armor - Metal Helmets"
	desc = "Contains three surplus, but solid!, metal helmets. Keep that militia safe!"
	cost = 1500
	contains = list(/obj/item/clothing/head/helmet/armyhelmet,
					/obj/item/clothing/head/helmet/armyhelmet,
					/obj/item/clothing/head/helmet/armyhelmet)
	crate_name = "helmet crate"

/datum/supply_pack/security/armor //one tier 2 armor from the raider boss, as a treat...
	name = "Armor - Raider Scraps"
	desc = "Four sets of armor stripped off of raiders. Cheap, dirty, and quickly supplied. Some of it might even be worthwhile."
	cost = 1500
	contains = list(/obj/effect/spawner/lootdrop/f13/armor/tier1,
					/obj/effect/spawner/lootdrop/f13/armor/tier1,
					/obj/effect/spawner/lootdrop/f13/armor/tier1,
					/obj/effect/spawner/lootdrop/f13/armor/tier2)
	crate_name = "armor crate"

/*
/datum/supply_pack/security/forensics
	name = "Forensics Crate"
	desc = "Stay hot on the criminal's heels with Nanotrasen's Detective Essentials(tm). Contains a forensics scanner, six evidence bags, camera, tape recorder, white crayon, and of course, a fedora. Requires Security access to open."
	cost = 1800
	contains = list(/obj/item/detective_scanner,
					/obj/item/storage/box/evidence,
					/obj/item/camera,
					/obj/item/taperecorder,
					/obj/item/toy/crayon/white,
					/obj/item/clothing/head/fedora/det_hat)
	crate_name = "forensics crate"
	can_private_buy = TRUE
*/

/datum/supply_pack/security/russianclothing
	name = "Russian Surplus Clothing"
	desc = "An old russian crate full of surplus armor that they used to use! Has two sets of bulletproff armor, a few union suits and some warm hats! The Hub is not liable for any friendly fire incidents."
	contraband = TRUE
	cost = 5750 // Its basicly sec suits, good boots/gloves
	contains = list(/obj/item/clothing/suit/armor/outfit/jacket/navyblue/russian,
					/obj/item/clothing/suit/armor/outfit/jacket/navyblue/russian,
					/obj/item/clothing/shoes/combat,
					/obj/item/clothing/shoes/combat,
					/obj/item/clothing/head/ushanka,
					/obj/item/clothing/head/ushanka,
					/obj/item/clothing/suit/armor/heavy/vest/bulletproof,
					/obj/item/clothing/suit/armor/heavy/vest/bulletproof,
					/obj/item/clothing/head/helmet/alt,
					/obj/item/clothing/head/helmet/alt,
					/obj/item/clothing/gloves/tackler/combat/insulated,
					/obj/item/clothing/gloves/tackler/combat/insulated,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas)
	crate_name = "surplus russian clothing"
	crate_type = /obj/structure/closet/crate/internals
/*
/datum/supply_pack/security/sechardsuit
	name = "Sec Hardsuit"
	desc = "One Sec Hardsuit with a small air tank and mask."
	cost = 3000 // half of SWAT gear for have the armor and half the gear
	contains = list(/obj/item/clothing/suit/space/hardsuit/security,
					/obj/item/tank/internals/air,
					/obj/item/clothing/mask/gas)
	crate_name = "sec hardsuit crate"
*/
/datum/supply_pack/security/securitybarriers
	name = "Security Barrier Grenades"
	desc = "Stem the tide with four pre-war riot grenades."
	contains = list(/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier)
	cost = 2000
	crate_name = "security barriers crate"
	can_private_buy = TRUE
/*
/datum/supply_pack/security/securityclothes
	name = "Security Clothing Crate"
	desc = "Contains appropriate outfits for the station's private security force. Contains outfits for the Warden, Head of Security, and two Security Officers. Each outfit comes with a rank-appropriate jumpsuit, suit, and beret. Requires Security access to open."
	cost = 3250
	contains = list(/obj/item/clothing/under/rank/security/officer/formal,
					/obj/item/clothing/under/rank/security/officer/formal,
					/obj/item/clothing/suit/armor/outfit/jacket/navyblue,
					/obj/item/clothing/suit/armor/outfit/jacket/navyblue,
					/obj/item/clothing/head/beret/sec/navyofficer,
					/obj/item/clothing/head/beret/sec/navyofficer,
					/obj/item/clothing/under/rank/security/warden/formal,
					/obj/item/clothing/suit/armor/medium/vest/warden/navyblue,
					/obj/item/clothing/head/beret/sec/navywarden,
					/obj/item/clothing/under/rank/security/head_of_security/formal,
					/obj/item/clothing/suit/armor/medium/duster/navyblue,
					/obj/item/clothing/head/beret/sec/navyhos)
	crate_name = "security clothing crate"
	can_private_buy = TRUE
*/

/datum/supply_pack/security/supplies
	name = "Lawman Supplies Crate"
	desc = "Contains seven flashbangs, seven teargas grenades, six flashes, and seven handcuffs.."
	cost = 1200
	contains = list(/obj/item/storage/box/flashbangs,
					/obj/item/storage/box/teargas,
					/obj/item/storage/box/flashes,
					/obj/item/storage/box/handcuffs)
	crate_name = "security supply crate"

/*
/datum/supply_pack/security/firingpins
	name = "Standard Firing Pins Crate"
	desc = "Upgrade your arsenal with 10 standard firing pins. Requires Security access to open."
	cost = 2000
	contains = list(/obj/item/storage/box/firingpins,
					/obj/item/storage/box/firingpins)
	crate_name = "firing pins crate"

/datum/supply_pack/security/justiceinbound
	name = "Standard Justice Enforcer Crate"
	desc = "This is it. The Bee's Knees. The Creme of the Crop. The Pick of the Litter. The best of the best of the best. The Crown Jewel of Nanotrasen. The Alpha and the Omega of security headwear. Guaranteed to strike fear into the hearts of each and every criminal aboard the station. Also comes with a security gasmask. Requires Security access to open."
	cost = 6000 //justice comes at a price. An expensive, noisy price.
	contraband = TRUE
	contains = list(/obj/item/clothing/head/helmet/justice,
					/obj/item/clothing/mask/gas/sechailer)
	crate_name = "security clothing crate"
	can_private_buy = TRUE
*/

/datum/supply_pack/security/baton
	name = "Stun Batons Crate"
	desc = "Arm the volunteer deputies with three stun batons. Batteries included."
	cost = 1200
	contains = list(/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded)
	crate_name = "stun baton crate"
/*
/datum/supply_pack/security/taser
	name = "Taser Crate"
	desc = "From the depths of stunbased combat, this order rises above, supreme. Contains three hybrid tasers, capable of firing both electrodes and disabling shots."
	cost = 3500
	contains = list(/obj/item/gun/energy/e_gun/advtaser,
					/obj/item/gun/energy/e_gun/advtaser,
					/obj/item/gun/energy/e_gun/advtaser)
	crate_name = "taser crate"

/datum/supply_pack/security/wall_flash
	name = "Wall-Mounted Flash Crate"
	desc = "Contains four wall-mounted flashes. Requires Security access to open."
	cost = 1000
	contains = list(/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash)
	crate_name = "wall-mounted flash crate"

/datum/supply_pack/security/hunting
	name = "Hunting Gear"
	desc = "Even in space, we can find prey to hunt, this crate contains everthing a fine hunter needs to have a sporting time. This crate needs armory access to open. A true huntter only needs a fine bottle of cognac, a nice coat, some good o' cigars, and of cource a hunting shotgun. "
	cost = 3500
	contraband = TRUE
	contains = list(/obj/item/clothing/head/flatcap,
					/obj/item/clothing/suit/hooded/wintercoat/captain,
					/obj/item/reagent_containers/food/drinks/bottle/cognac,
					/obj/item/storage/fancy/cigarettes/cigars/havana,
					/obj/item/clothing/gloves/color/white,
					/obj/item/clothing/under/rank/civilian/curator,
					/obj/item/gun/ballistic/shotgun/lethal)
	access = ACCESS_ARMORY
	crate_name = "sporting crate"
	crate_type = /obj/structure/closet/crate/secure // Would have liked a wooden crate but access >:(
*/

/datum/supply_pack/security/stingpack
	name = "Stingbang Grenade Pack"
	desc = "Contains five \"stingbang\" grenades, perfect for stopping pre-War food riots and shutting down seditious agents."
	cost = 2500
	contains = list(/obj/item/storage/box/stingbangs)
	crate_name = "stingbang grenade pack crate"

/datum/supply_pack/security/mosinpack
	name = "Weapons - Mosin-Nagant Pack"
	desc = "Arm your militia. Five Mosin Rifles, preloaded, ready to kill. A solid weapon for any defense or guerilla force. Does not come with spare ammo, so you might wanna get that sorted out, pardner."
	cost = 750
	contains = list(/obj/item/gun/ballistic/rifle/mosin,
					/obj/item/gun/ballistic/rifle/mosin,
					/obj/item/gun/ballistic/rifle/mosin,
					/obj/item/gun/ballistic/rifle/mosin,
					/obj/item/gun/ballistic/rifle/mosin)

/datum/supply_pack/security/laserlowtier
	name = "Weapons - Laser Grab-Bag"
	desc = "Contains three low-powered laser guns, probably in need of some love. Batteries included in shocking excess! Don't want 'em? Sell 'em back! Seriously! We don't judge!"
	cost = 2000
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/low)
	crate_name = "laser crate"

/datum/supply_pack/security/disabler
	name = "Weapons - Disabler Crate"
	desc = "Three stamina-draining disabler weapons, for a more civilized place, where killing isn't the answer. In other words, probably not here. But it's nice you're trying!"
	cost = 1300
	contains = list(/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler)
	crate_name = "disabler crate"

/datum/supply_pack/security/minigun5mm
	name = "Weapons - Minigun"
	desc = "Holy moly, it's here. A refurbished minigun chambered in US five-aught. Heavy, impractical, expensive to buy, expensive to fire, expensive to maintain, and an absolute killer."
	cost = 9000
	contains = list(/obj/item/minigunpackbal5mm)
	crate_name = "laser crate"

/datum/supply_pack/security/ballisticstrash
	name = "Weapons - Ballistics Grab-Bag"
	desc = "Grab-bag is just a polite way of saying pile of junk. It's...a pile of junk. A mixture of around ten civillian and homemade firearms. Comes with an ABSURD amount of surplus ammo."
	cost = 1350
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/lowmid,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo)
	crate_name = "laser crate"

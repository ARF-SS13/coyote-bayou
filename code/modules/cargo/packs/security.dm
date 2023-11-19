
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Security ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/security
	group = "Munitions"
	crate_type = /obj/structure/closet/crate/footlocker
	can_private_buy = 1
	var/num_contained = 1

/datum/supply_pack/security/randomized
	num_contained = 15

/datum/supply_pack/security/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to num_contained)
		var/item = pick(contains)
		new item(C)

/* /datum/supply_pack/security/ammosurplus
	name = "Ammo Crate - Grab-Bag"
	desc = "Contains a whole stuffing of bullets, magazines, casings. Probably overpriced."
	cost = 2000
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3)
	crate_name = "ammo crate" */

/datum/supply_pack/security/powder50
	name = "50 Gunpowder Clumps"
	desc = "For when ammunition is in low supply."
	cost = 2000
	contains = list(/obj/item/stack/ore/blackpowder/fifty)
	crate_name = "Gunpowder Restock"

/datum/supply_pack/security/helmets
	name = "Armor - Metal Helmets"
	desc = "Contains three surplus, but solid, metal helmets. Keep that militia safe!"
	cost = 500
	num_contained = 3
	contains = list(/obj/item/clothing/head/helmet/armyhelmet,
					/obj/item/clothing/head/helmet/armyhelmet,
					/obj/item/clothing/head/helmet/armyhelmet)
	crate_name = "helmet crate"

/datum/supply_pack/security/raiderarmor //one tier 2 armor from the raider boss, as a treat...
	name = "Armor - Raider Scraps"
	desc = "Four sets of armor stripped off of raiders. Cheap, dirty, and quickly supplied. Some of it might even be worthwhile."
	cost = 750
	num_contained = 3
	contains = list(/obj/effect/spawner/lootdrop/f13/trash_armor,
					/obj/effect/spawner/lootdrop/f13/trash_armor,
					/obj/effect/spawner/lootdrop/f13/trash_armor)
	crate_name = "armor crate"

/datum/supply_pack/security/armor
	name = "Armor - Surplus"
	desc = "Three sets of refurbished armor, straight from the Dallas Miltia's own armory."
	cost = 1500
	num_contained = 3
	contains = list(/obj/effect/spawner/lootdrop/f13/common_armor,
					/obj/effect/spawner/lootdrop/f13/common_armor,
					/obj/effect/spawner/lootdrop/f13/common_armor)
	crate_name = "armor crate"

/datum/supply_pack/security/armorplus
	name = "Armor - Advanced"
	desc = "One set of advanced armor, and rarely something better."
	cost = 5000
	num_contained = 1
	contains = list(/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/rare_armor)
	crate_name = "armor crate"

/datum/supply_pack/security/nvgpack
	name = "Utility - Night Vision"
	desc = "A single set of Night Vision Goggles. Because you're just not tactical enough until you have a set of NODs on, even if it's the middle of the day."
	cost = 10000
	num_contained = 1
	contains = list(/obj/item/clothing/glasses/night)
	crate_name = "armor crate"

/datum/supply_pack/security/nvgpack_upgr
	name = "Utility - Prescription Night Vision"
	desc = "A set of NVGs, now adjusted for those with terrible vision! Wearing these doesn't make you less of a nerd, however."
	cost = 12500
	num_contained = 1
	contains = list(/obj/item/clothing/glasses/night/prescription)
	crate_name = "armor crate"

/datum/supply_pack/security/ec
	name = "Ammo - Energy Cell"
	desc = "Three fully charged energy cells."
	cost = 900
	num_contained = 3
	contains = list(/obj/item/stock_parts/cell/ammo/ec,
					/obj/item/stock_parts/cell/ammo/ec,
					/obj/item/stock_parts/cell/ammo/ec)
	crate_name = "cell crate"

/datum/supply_pack/security/mfc
	name = "Ammo - Microfusion Cell"
	desc = "Three fully charged microfusion cells."
	cost = 1200
	num_contained = 3
	contains = list(/obj/item/stock_parts/cell/ammo/mfc,
					/obj/item/stock_parts/cell/ammo/mfc,
					/obj/item/stock_parts/cell/ammo/mfc)
	crate_name = "microfusion crate"

/datum/supply_pack/security/ecp
	name = "Ammo - Electron Charge Pack"
	desc = "Three fully charged electron charge packs."
	cost = 1500
	num_contained = 3
	contains = list(/obj/item/stock_parts/cell/ammo/ecp,
					/obj/item/stock_parts/cell/ammo/ecp,
					/obj/item/stock_parts/cell/ammo/ecp)
	crate_name = "electron charge crate"

/* blueprint crates and blueprints disabled till an overhaul happens
/datum/supply_pack/security/blueprint
	name = "Blueprints - Basic"
	desc = "A set of three basic weapon blueprints, parts not included!"
	cost = 2750
	num_contained = 3
	contains = list(/obj/effect/spawner/lootdrop/f13/blueprintMid,
					/obj/effect/spawner/lootdrop/f13/blueprintMid,
					/obj/effect/spawner/lootdrop/f13/blueprintMid
					)
	crate_name = "blueprint crate"

/datum/supply_pack/security/blueprintadv
	name = "Blueprints - Advanced"
	desc = "A set of two advanced weapon blueprints, parts not included!"
	cost = 4250
	num_contained = 2
	contains = list(/obj/effect/spawner/lootdrop/f13/blueprintHigh,
					/obj/effect/spawner/lootdrop/f13/blueprintHigh
					)
	crate_name = "blueprint crate"
*/

/datum/supply_pack/security/combatknives_single
	name = "Combat Knife Single-Pack"
	desc = "Some good ol' sharp knives. Guaranteed to fit snugly inside any cowboy-wasteland boot. You know what's better than one knife? Three of 'em!"
	cost = 100
	num_contained = 3
	contains = list(/obj/item/melee/onehanded/knife/hunting,
					/obj/item/melee/onehanded/knife/hunting,
					/obj/item/melee/onehanded/knife/hunting)

/* /datum/supply_pack/security/dueling_stam
	name = "Dueling Pistols"
	desc = "Resolve all your quarrels with some nonlethal fun."
	cost = 1500
	contains = list(/obj/item/storage/lockbox/dueling/hugbox/stamina)
	crate_name = "dueling pistols"

/datum/supply_pack/security/dueling_stam/generate()
	. = ..()
	for(var/i in 1 to 3)
		new /obj/item/storage/lockbox/dueling/hugbox/stamina(.)

/datum/supply_pack/misc/dueling_lethal
	name = "Lethal Dueling Pistols"
	desc = "Settle your differences the true cowboy way."
	cost = 3000
	contains = list(/obj/item/storage/lockbox/dueling/hugbox,
	/obj/item/storage/lockbox/dueling/hugbox,
	/obj/item/storage/lockbox/dueling/hugbox)
	crate_name = "dueling pistols (lethal)" */
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

/* /datum/supply_pack/security/russianclothing
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
	crate_type = /obj/structure/closet/crate/internals */
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
	cost = 1000
	num_contained = 4
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
	num_contained = 4
	contains = list(/obj/item/storage/box/flashbangs,
					/obj/item/storage/box/teargas,
					/obj/item/storage/box/flashes,
					/obj/item/storage/box/handcuffs)
	crate_name = "security supply crate"

/*
/datum/supply_pack/security/firingpins
	name = "wasteland Firing Pins Crate"
	desc = "Upgrade your arsenal with 10 wasteland firing pins. Requires Security access to open."
	cost = 2000
	contains = list(/obj/item/storage/box/firingpins,
					/obj/item/storage/box/firingpins)
	crate_name = "firing pins crate"

/datum/supply_pack/security/justiceinbound
	name = "wasteland Justice Enforcer Crate"
	desc = "This is it. The Bee's Knees. The Creme of the Crop. The Pick of the Litter. The best of the best of the best. The Crown Jewel of Nanotrasen. The Alpha and the Omega of security headwear. Guaranteed to strike fear into the hearts of each and every criminal aboard the station. Also comes with a security gasmask. Requires Security access to open."
	cost = 6000 //justice comes at a price. An expensive, noisy price.
	contraband = TRUE
	contains = list(/obj/item/clothing/head/helmet/justice,
					/obj/item/clothing/mask/gas/sechailer)
	crate_name = "security clothing crate"
	can_private_buy = TRUE

/datum/supply_pack/security/baton
	name = "Stun Batons Crate"
	desc = "Arm the volunteer deputies with three stun batons. Batteries included."
	cost = 1200
	contains = list(/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded)
	crate_name = "stun baton crate" */
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

/datum/supply_pack/security/plasmagrenade
	name = "Plasma Grenade Pack"
	desc = "Plasma bolts in a compact form. Rain death on your enemies!"
	cost = 5000
	num_contained = 4
	contains = list(/obj/item/grenade/f13/plasma,
					/obj/item/grenade/f13/plasma,
					/obj/item/grenade/f13/plasma,
					/obj/item/grenade/f13/plasma)
	crate_name = "plasma grenade pack crate"

/datum/supply_pack/security/clusterbangpack
	name = "Clusterbang Grenade Pack"
	desc = "A wasteland pack of three random sprays of death, regret, and bad ideas."
	cost = 15000
	num_contained = 3
	contains = list(/obj/item/grenade/clusterbuster/emp,
					/obj/item/grenade/clusterbuster/smoke,
					/obj/item/grenade/clusterbuster/inferno,
					/obj/item/grenade/clusterbuster/syndieminibomb,
					/obj/item/grenade/clusterbuster/teargas,
					/obj/item/grenade/clusterbuster/clf3,
					/obj/item/grenade/clusterbuster/facid)
	crate_name = "clusterbang grenade pack crate"

/datum/supply_pack/security/stingpack
	name = "Stingbang Grenade Pack"
	desc = "Contains five \"stingbang\" grenades, perfect for stopping pre-War food riots and shutting down seditious agents."
	cost = 1500
	contains = list(/obj/item/storage/box/stingbangs)
	crate_name = "stingbang grenade pack crate"

/*disabled pending rework of traitbook lootdrop
/datum/supply_pack/security/traitbooks
	name = "Technical manuals"
	desc = "A box crammed full of manuals, for reading. SCAV issues, Guns and Ammo, how to operate chem-machines, it's all here! Come in groups of three."
	cost = 2000
	num_contained = 3
	contains = list(/obj/effect/spawner/lootdrop/f13/traitbooks,
					/obj/effect/spawner/lootdrop/f13/traitbooks/low,
					/obj/effect/spawner/lootdrop/f13/traitbooks/low)
*/

/* energy cargo boxes, replaced by new weapon cargo boxes
/datum/supply_pack/security/laserlowtier
	name = "Weapons - Laser Grab-Bag"
	desc = "Contains three low-powered laser guns, probably in need of some love. Batteries included in shocking excess! Don't want 'em? Sell 'em back! Seriously! We don't judge!"
	cost = 1600
	num_contained = 3
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/low)
	crate_name = "laser crate"

/datum/supply_pack/security/lasermidtier
	name = "Weapons - Energy Grab-Bag"
	desc = "Contains two energy guns, probably in need of some love. Batteries included!"
	cost = 3750
	num_contained = 2
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/mid,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/midhigh)
	crate_name = "energy crate"
*/

/datum/supply_pack/security/mods
	name = "Weapons - Gun Mods"
	desc = "Contains four random gun and energy weapon mods, fun for the whole family!"
	cost = 800
	num_contained = 4
	contains = list(/obj/effect/spawner/lootdrop/f13/trash_mods,
					/obj/effect/spawner/lootdrop/f13/common_mods,
					/obj/effect/spawner/lootdrop/f13/common_mods,
					/obj/effect/spawner/lootdrop/f13/uncommon_mods)
	crate_name = "gun mods crate"

/datum/supply_pack/security/advmods
	name = "Weapons - Advanced Gun Mods"
	desc = "Contains four random advanced gun and energy weapon mods, best for causing pain!"
	cost = 1200
	num_contained = 4
	contains = list(/obj/item/tool_upgrade/refinement/vibcompensator,
					/obj/item/tool_upgrade/productivity/motor,
					/obj/item/tool_upgrade/reinforcement/plasmablock,
					/obj/item/gun_upgrade/mechanism/battery_shunt,
					/obj/item/gun_upgrade/mechanism/overdrive,
					/obj/item/gun_upgrade/barrel/mag_accel,
					/obj/item/gun_upgrade/barrel/blender,
					/obj/item/gun_upgrade/scope/killer,
					/obj/item/tool_upgrade/augment/ai_tool)
	crate_name = "advanced gun mods crate"

/* /datum/supply_pack/security/aimod // removed because ZAX was super nerfed
	name = "Weapons - Zax Module"
	desc = "Contains two highly advanced energy gun modifications."
	cost = 8000
	num_contained = 2
	contains = list(/obj/item/tool_upgrade/augment/ai_tool,
					/obj/item/tool_upgrade/augment/ai_tool)
	crate_name = "zax module crate" */

/* /datum/supply_pack/security/gaussbarrelmod //"chinese gauss barrels make me die inside" -Fuzzy, 2023
	name = "Weapons - Chinese Gauss Barrel"
	desc = "Two strong barrels meant to obliterate targets."
	cost = 20000
	num_contained = 2
	contains = list(/obj/item/gun_upgrade/barrel/gauss,
					/obj/item/gun_upgrade/barrel/gauss)
	crate_name = "chiense gauss barrel crate" */

/* /datum/supply_pack/security/disabler
	name = "Weapons - Disabler Crate"
	desc = "Three stamina-draining disabler weapons, for a more civilized place, where killing isn't the answer. In other words, probably not here. But it's nice you're trying!"
	cost = 1300
	contains = list(/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler)
	crate_name = "disabler crate" */

/datum/supply_pack/security/minigun5mm
	name = "Weapons - Minigun"
	desc = "Holy moly, it's here. A refurbished minigun chambered in US five-aught. Heavy, impractical, expensive to buy, expensive to fire, expensive to maintain, and an absolute killer."
	cost = 20000
	contains = list(/obj/item/minigunpackbal5mm)
	crate_name = "minigun crate"

/datum/supply_pack/security/minigun
	name = "Weapons - Gatling Laser"
	desc = "For when you REALLY need to cook a steak from twenty yards away."
	cost = 50000
	contains = list(/obj/item/minigunpack)
	crate_name = "gatling laser crate"

//disclaimer: I...don't actually know how the economy goes, so these costs are spitballs

/datum/supply_pack/security/weapon_wasteland
	name = "Weapons - Common"
	desc = "Half a dozen commonly found wasteland weaponry. you might find something nice, sifting through these."
	cost = 1000
	num_contained = 6
	contains = list(
		/obj/effect/spawner/lootdrop/f13/common_weps,
		/obj/effect/spawner/lootdrop/f13/common_weps,
		/obj/effect/spawner/lootdrop/f13/common_weps,
		/obj/effect/spawner/lootdrop/f13/common_weps,
		/obj/effect/spawner/lootdrop/f13/common_weps,
		/obj/effect/spawner/lootdrop/f13/common_weps
)
	crate_name = "Wasteland weapon crate"

/datum/supply_pack/security/weapon_dungeon
	name = "Weapons - Uncommon"
	desc = "A set of four good quality weapons. Rarely comes with something special."
	cost = 2500
	num_contained = 4
	contains = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_weps,
		/obj/effect/spawner/lootdrop/f13/uncommon_weps,
		/obj/effect/spawner/lootdrop/f13/uncommon_weps,
		/obj/effect/spawner/lootdrop/f13/uncommon_weps,
		/obj/effect/spawner/lootdrop/f13/rare_weps
)
	crate_name = "quality weapon crate"

/datum/supply_pack/security/weapon_plus
	name = "Weapons - Rare"
	desc = "A set of three superb quality weapons. Stocks may fluctuate."
	cost = 5000
	num_contained = 3
	contains = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_weps,
		/obj/effect/spawner/lootdrop/f13/rare_weps,
		/obj/effect/spawner/lootdrop/f13/rare_weps,
		/obj/effect/spawner/lootdrop/f13/rare_weps
		)
	crate_name = "quality weapon crate"

/datum/supply_pack/security/wands // Wands
	name = "Magic - Wands"
	desc = "A crate containing three whole wands. Hand-crafted by the Witches of Winslow, according to the Dallas catalog."
	cost = 3000
	num_contained = 3
	contains = list(
		/obj/item/gun/magic/wand/kelpmagic/magicmissile/improved,
		/obj/item/gun/magic/wand/kelpmagic/sparky,
		/obj/item/gun/magic/wand/kelpmagic/firebolt
		)
	crate_name = "quality weapon crate"

/datum/supply_pack/security/staves_basic // T1 Staves
	name = "Magic - Basic Staves"
	desc = "A crate containing two basic staves."
	cost = 3500
	num_contained = 2
	contains = list(
		/obj/item/gun/magic/staff/kelpmagic/acidstaff,
		/obj/item/gun/magic/staff/kelpmagic/lightning
		)
	crate_name = "quality weapon crate"

/datum/supply_pack/security/staves_advanced // T2 Staves
	name = "Magic - Advanced Staves"
	desc = "A crate containing either a staff of fireball or a staff of healing."
	cost = 5000
	num_contained = 2
	contains = list(
		/obj/item/gun/magic/staff/kelpmagic/healstaff,
		/obj/item/gun/magic/staff/kelpmagic/fireball
		)
	crate_name = "quality weapon crate"

/datum/supply_pack/security/ammo_shipment
	name = "Ammunition Shipment"
	desc = "A crate packed full of ammo boxes."
	cost = 500
	num_contained = 8
	contains = list(
		/obj/effect/spawner/lootdrop/f13/common_ammo,
		/obj/effect/spawner/lootdrop/f13/common_ammo,
		/obj/effect/spawner/lootdrop/f13/common_ammo,
		/obj/effect/spawner/lootdrop/f13/common_ammo,
		/obj/effect/spawner/lootdrop/f13/uncommon_ammo,
		/obj/effect/spawner/lootdrop/f13/uncommon_ammo,
		/obj/effect/spawner/lootdrop/f13/uncommon_ammo,
		/obj/effect/spawner/lootdrop/f13/uncommon_ammo,
)
	crate_name = "Ammo Crate"

/datum/supply_pack/security/weapon_packed_trash
	name = "Weapons - Packed, Trash"
	desc = "A crate full of trashy weapons, packed to order."
	cost = 500
	num_contained = 3
	contains = list(
		/obj/item/choice_beacon/box/weapons_trash,
		/obj/item/choice_beacon/box/weapons_trash,
		/obj/item/choice_beacon/box/weapons_trash,
)
	crate_name = "packed trash weapon crate"

/datum/supply_pack/security/weapon_packed_common
	name = "Weapons - Packed, Common"
	desc = "A crate full of common weapons, packed to order."
	cost = 750
	num_contained = 3
	contains = list(
		/obj/item/choice_beacon/box/weapons_common,
		/obj/item/choice_beacon/box/weapons_common,
		/obj/item/choice_beacon/box/weapons_common
)
	crate_name = "packed common weapon crate"

/datum/supply_pack/security/weapon_packed_uncommon
	name = "Weapons - Packed, Uncommon"
	desc = "A crate full of uncommon weapons, packed to order."
	cost = 1500
	num_contained = 2
	contains = list(
		/obj/item/choice_beacon/box/weapons_uncommon,
		/obj/item/choice_beacon/box/weapons_uncommon
)
	crate_name = "packed uncommon weapon crate"


// Commented out temporarily. Could be a good change, could be a terrible idea

/*/datum/supply_pack/security/incendiary44
	name = "Ammunition - Incendiary .44"
	desc = "A crate with 100 incendiary bullets chambered in .44"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/m44box/incendiary,
		/obj/item/ammo_box/m44box/incendiary,
		/obj/item/ammo_box/m44box/incendiary,
		/obj/item/ammo_box/m44box/incendiary,
		/obj/item/ammo_box/m44box/incendiary,
)

/datum/supply_pack/security/incendiary50mg
	name = "Ammunition - Incendiary .50MG"
	desc = "A crate with 25 incendiary bullets chambered in .50MG"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/a50MG/incendiary,
		/obj/item/ammo_box/a50MG/incendiary,
		/obj/item/ammo_box/a50MG/incendiary,
		/obj/item/ammo_box/a50MG/incendiary,
		/obj/item/ammo_box/a50MG/incendiary,
)

/datum/supply_pack/security/incendiary473
	name = "Ammunition - Incendiary 4.73mm"
	desc = "A crate with 250 incendiary bullets chambered in 4.73mm"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/m473/incendiary,
		/obj/item/ammo_box/m473/incendiary,
		/obj/item/ammo_box/m473/incendiary,
		/obj/item/ammo_box/m473/incendiary,
		/obj/item/ammo_box/m473/incendiary,
)

/datum/supply_pack/security/incendiary45
	name = "Ammunition - Incendiary .45"
	desc = "A crate with 125 incendiary bullets chambered in .45"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
)

/datum/supply_pack/security/incendiaryshotgun
	name = "Ammunition - Incendiary Shells"
	desc = "A crate with 60 dragon's breath shotgun shells"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/shotgun/incendiary,
		/obj/item/ammo_box/shotgun/incendiary,
		/obj/item/ammo_box/shotgun/incendiary,
		/obj/item/ammo_box/shotgun/incendiary,
		/obj/item/ammo_box/shotgun/incendiary,
)

/datum/supply_pack/security/incendiary9mm
	name = "Ammunition - Incendiary 9mm"
	desc = "A crate with 225 incendiary bullets chambered in 9mm"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/c9mm/incendiary,
		/obj/item/ammo_box/c9mm/incendiary,
		/obj/item/ammo_box/c9mm/incendiary,
		/obj/item/ammo_box/c9mm/incendiary,
		/obj/item/ammo_box/c9mm/incendiary,
)

/datum/supply_pack/security/incendiary357
	name = "Ammunition - Incendiary .357"
	desc = "A crate with 125 incendiary bullets chambered in .357"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
		/obj/item/ammo_box/c45/incendiary,
)

/datum/supply_pack/security/incendiary10mm
	name = "Ammunition - Incendiary 10mm"
	desc = "A crate with 150 incendiary bullets chambered in 10mm"
	cost = 1500
	contains = list(
		/obj/item/ammo_box/c10mm/fire,
		/obj/item/ammo_box/c10mm/fire,
		/obj/item/ammo_box/c10mm/fire,
		/obj/item/ammo_box/c10mm/fire,
		/obj/item/ammo_box/c10mm/fire,
)

/datum/supply_pack/security/esd5mm
	name = "Ammunition - ESD 5mm"
	desc = "A crate with 150 electrostatic discharger bullets chambered in 5mm"
	cost = 3000
	contains = list(
		/obj/item/ammo_box/m5mmbox/shock,
		/obj/item/ammo_box/m5mmbox/shock,
		/obj/item/ammo_box/m5mmbox/shock,
		/obj/item/ammo_box/m5mmbox/shock,
		/obj/item/ammo_box/m5mmbox/shock,
)

/datum/supply_pack/security/esd473mm
	name = "Ammunition - ESD 4.73mm"
	desc = "A crate with 250 electrostatic discharger bullets chambered in 4.73mm"
	cost = 3000
	contains = list(
		/obj/item/ammo_box/m473/shock,
		/obj/item/ammo_box/m473/shock,
		/obj/item/ammo_box/m473/shock,
		/obj/item/ammo_box/m473/shock,
		/obj/item/ammo_box/m473/shock,
)

/datum/supply_pack/security/esd22lr
	name = "Ammunition - ESD .22lr"
	desc = "A crate with 300 electrostatic discharger bullets chambered in .22lr"
	cost = 3000
	contains = list(
		/obj/item/ammo_box/m22/shock,
		/obj/item/ammo_box/m22/shock,
		/obj/item/ammo_box/m22/shock,
		/obj/item/ammo_box/m22/shock,
		/obj/item/ammo_box/m22/shock,
)*/

/*shop should go up to mid tier, and be affordable in doing so
/datum/supply_pack/security/weapon_boss
	name = "Weapons - Rare"
	desc = "A pair of rare, valueable weapons, for all your killing needs."
	cost = 15000 //a big jump from mid tier weapons. shouldn't buy many. will see how this goes with the other changes
	num_contained = 2
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/boss,
		/obj/effect/spawner/lootdrop/f13/weapon/boss
)
	crate_name = "Rare weapon crate"
*/

/* /datum/supply_pack/security/weapon_unique
	name = "Weapons - Premium"
	desc = "A single weapon of incredible rarity. there's no telling what was packed into this crate"
	cost = 50000
	num_contained = 1
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/unique
)
	crate_name = "Premium weapon crate" */

/*needs reworked
/datum/supply_pack/security/weapon_milsurplus
	name = "Weapons -  Military Surplus"
	desc = "A crate of long forgotten American weapons from the second world war."
	cost = 4500
	num_contained = 8
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus,
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus,
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus,
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus,
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus,
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus,
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus,
		/obj/effect/spawner/lootdrop/f13/weapon/milsurplus
)
	crate_name = "military surplus weapon crate"

/datum/supply_pack/security/weapon_combloc
	name = "Weapons - Communist Bloc"
	desc = "An old crate packed with surplus Chinese and Russian weaponry. You may have to clean off the old cosmoline."
	cost = 5000
	num_contained = 8
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/combloc,
		/obj/effect/spawner/lootdrop/f13/weapon/combloc,
		/obj/effect/spawner/lootdrop/f13/weapon/combloc,
		/obj/effect/spawner/lootdrop/f13/weapon/combloc,
		/obj/effect/spawner/lootdrop/f13/weapon/combloc,
		/obj/effect/spawner/lootdrop/f13/weapon/combloc,
		/obj/effect/spawner/lootdrop/f13/weapon/combloc,
		/obj/effect/spawner/lootdrop/f13/weapon/combloc
)
	crate_name = "Combloc surplus weapons crate"

/datum/supply_pack/security/vault
	name = "Weapons - Vault"
	desc = "A crate of common vault security firearms that never made it to their assigned vault. A basic, but reliable selection."
	cost = 2000
	num_contained = 6
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/vault,
		/obj/effect/spawner/lootdrop/f13/weapon/vault,
		/obj/effect/spawner/lootdrop/f13/weapon/vault,
		/obj/effect/spawner/lootdrop/f13/weapon/vault,
		/obj/effect/spawner/lootdrop/f13/weapon/vault,
		/obj/effect/spawner/lootdrop/f13/weapon/vault
)
	crate_name = "vault weapon crate"

/datum/supply_pack/security/weapon_police
	name = "Weapons - Law Enforcement"
	desc = "A crate full of common police and riot weapons. Occasionally contains special SWAT firearms."
	cost = 3000
	num_contained = 4
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/police,
		/obj/effect/spawner/lootdrop/f13/weapon/police,
		/obj/effect/spawner/lootdrop/f13/weapon/police,
		/obj/effect/spawner/lootdrop/f13/weapon/police,
)
	crate_name = "police weapon crate"

/datum/supply_pack/security/weapon_22
	name = "Weapons - .22 caliber"
	desc = "A crate full of low caliber weapons, for either building a lot of turrets, or quickly arming an anti-gecko militia"
	cost = 2500
	num_contained = 8 //sadly crates have a max capacity of 8, don't wanna overflow
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22,
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22,
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22,
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22,
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22,
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22,
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22,
		/obj/effect/spawner/lootdrop/f13/weapon/weapon_22
)
	crate_name = ".22 caliber weapon crate"

/datum/supply_pack/security/energy
	name = "Weapons - Energy"
	desc = "A crate containing four laser weapons, because sometimes you want your gecko pre-seared. Order now and you might just get that Plasma Rifle you always wanted!"
	cost = 4000
	num_contained = 4
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/energy,
		/obj/effect/spawner/lootdrop/f13/weapon/energy,
		/obj/effect/spawner/lootdrop/f13/weapon/energy,
		/obj/effect/spawner/lootdrop/f13/weapon/energy
)
	crate_name = "energy weapon crate"

/datum/supply_pack/security/weapon_junk
	name = "Weapons - Junk"
	desc = "A haphazard pile of ethically sourced, barely functioning pipes and pieces of wood pretending to be guns. "
	cost = 2000
	num_contained = 8
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/junk,
		/obj/effect/spawner/lootdrop/f13/weapon/junk,
		/obj/effect/spawner/lootdrop/f13/weapon/junk,
		/obj/effect/spawner/lootdrop/f13/weapon/junk,
		/obj/effect/spawner/lootdrop/f13/weapon/junk,
		/obj/effect/spawner/lootdrop/f13/weapon/junk,
		/obj/effect/spawner/lootdrop/f13/weapon/junk,
		/obj/effect/spawner/lootdrop/f13/weapon/junk
)
	crate_name = "junk weapon crate"

/datum/supply_pack/security/weapon_western
	name = "Weapons - Western"
	desc = "A collection of classy lever actions, revolvers, and scatterguns fitting for lawmen and outlaws alike. Yeehaw!"
	cost = 3500
	num_contained = 6
	contains = list(
		/obj/effect/spawner/lootdrop/f13/weapon/western,
		/obj/effect/spawner/lootdrop/f13/weapon/western,
		/obj/effect/spawner/lootdrop/f13/weapon/western,
		/obj/effect/spawner/lootdrop/f13/weapon/western,
		/obj/effect/spawner/lootdrop/f13/weapon/western,
		/obj/effect/spawner/lootdrop/f13/weapon/western
)
	crate_name = "old west weapon crate"
*/

/*old cargo gun crates. replaced by somethin better~
/datum/supply_pack/security/gunsuperhightier
	name = "Weapons - Prewar Gun"
	desc = "A sealed crate of a Prewar firearm, an exceptional weapon machined with lost technology."
	cost = 6250
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/superhighcargo)
	crate_name = "prewar gun crate"

/datum/supply_pack/security/gunhightier
	name = "Weapons - High-Tier Guns"
	desc = "Two high-powered ballistics, perfect for taking down the meanest of muties."
	cost = 3500
	num_contained = 2
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/high,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/high)
	crate_name = "gun crate"

/datum/supply_pack/security/ballisticstrash
	name = "Weapons - Ballistics Grab-Bag"
	desc = "Grab-bag is just a polite way of saying pile of junk. It's...a pile of junk. A mixture of around ten civillian and homemade firearms. Comes with an ABSURD amount of surplus ammo."
	cost = 1350
	num_contained = 3
	contains = list(/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/mid,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/lowmid,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/low,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo,
					/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo,
					)
	crate_name = "gun grab-bag crate"
*/

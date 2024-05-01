
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal - no, fuck you
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////// secenergy ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/secenergy
	group = "Munitions - Energy"
	crate_type = /obj/structure/closet/crate/footlocker
	can_private_buy = 1
	var/num_contained = 1

/datum/supply_pack/secenergy/randomized
	num_contained = 15

/datum/supply_pack/secenergy/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to num_contained)
		var/item = pick(contains)
		new item(C)

/datum/supply_pack/secenergy/ec
	name = "Ammo - Energy Cell"
	desc = "Three fully charged energy cells."
	cost = 900
	num_contained = 3
	contains = list(/obj/item/stock_parts/cell/ammo/ec,
					/obj/item/stock_parts/cell/ammo/ec,
					/obj/item/stock_parts/cell/ammo/ec)
	crate_name = "cell crate"

/datum/supply_pack/secenergy/mfc
	name = "Ammo - Microfusion Cell"
	desc = "Three fully charged microfusion cells."
	cost = 1200
	num_contained = 3
	contains = list(/obj/item/stock_parts/cell/ammo/mfc,
					/obj/item/stock_parts/cell/ammo/mfc,
					/obj/item/stock_parts/cell/ammo/mfc)
	crate_name = "microfusion crate"

/datum/supply_pack/secenergy/ecp
	name = "Ammo - Electron Charge Pack"
	desc = "Three fully charged electron charge packs."
	cost = 1500
	num_contained = 3
	contains = list(/obj/item/stock_parts/cell/ammo/ecp,
					/obj/item/stock_parts/cell/ammo/ecp,
					/obj/item/stock_parts/cell/ammo/ecp)
	crate_name = "electron charge crate"

/datum/supply_pack/secenergy/plasmagrenade
	name = "Plasma Grenade Pack"
	desc = "Plasma bolts in a compact form. Rain death on your enemies!"
	cost = 5000
	num_contained = 4
	contains = list(/obj/item/grenade/f13/plasma,
					/obj/item/grenade/f13/plasma,
					/obj/item/grenade/f13/plasma,
					/obj/item/grenade/f13/plasma)
	crate_name = "plasma grenade pack crate"

/datum/supply_pack/secenergy/wands // Wands
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

/datum/supply_pack/secenergy/staves_basic // T1 Staves
	name = "Magic - Basic Staves"
	desc = "A crate containing two basic staves."
	cost = 3500
	num_contained = 2
	contains = list(
		/obj/item/gun/magic/staff/kelpmagic/acidstaff,
		/obj/item/gun/magic/staff/kelpmagic/lightning
		)
	crate_name = "quality weapon crate"

/datum/supply_pack/secenergy/staves_advanced // T2 Staves
	name = "Magic - Advanced Staves"
	desc = "A crate containing either a staff of fireball or a staff of healing."
	cost = 5000
	num_contained = 2
	contains = list(
		/obj/item/gun/magic/staff/kelpmagic/healstaff,
		/obj/item/gun/magic/staff/kelpmagic/fireball
		)
	crate_name = "quality weapon crate"

/datum/supply_pack/secenergy/ultrarifle
	name = "Ultracite AER Laser Rifle"
	desc = "The most efficient brick of them all. Shoots pretty good. Uses the very rare Ultracite MFC."
	cost = 2500
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/ultra_rifle)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/wattz2k
	name = "Wattz 2000 Laser Rifle"
	desc = "It's more of a laser sniper, honestly."
	cost = 2600
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/wattz2k)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/wattz2ke
	name = "Wattz 2000e Laser Rifle"
	desc = "More shots, less power. It's more of a DMR, honestly."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/wattz2k/extended)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/retrolas
	name = "Retro Laser Pistol"
	desc = "An ultra-compact and incredibly powerful laser pistol. So small, it might even fit in your boot!"
	cost = 2100
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/retro)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/ebowbig
	name = "Energy Crossbow"
	desc = "One shot, one kill. More often than not, anyway. Bonus, it's self-charging!"
	cost = 4200
	num_contained = 1
	contains = list(/obj/item/gun/energy/kinetic_accelerator/crossbow/large)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/ebow
	name = "Compact Energy Crossbow"
	desc = "One shot, not... Quite one kill. At least it has infinite ammo?"
	cost = 2200
	num_contained = 1
	contains = list(/obj/item/gun/energy/kinetic_accelerator/crossbow)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/compreg
	name = "Compliance Regulator Laser Pistol"
	desc = "For a brick, it stuns pretty good."
	cost = 1500
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/complianceregulator)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tribeamstun
	name = "Tribeam Disabler Rifle"
	desc = "For a brick, it stuns three times as good."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/scatter/nonlethal)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/disablerrcw
	name = "Disabler RCW"
	desc = "For when you want to throw a rave and knock everybody out."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/stunrcw)
	crate_name = "select weapon crate"

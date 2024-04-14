
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

/datum/supply_pack/secenergy/minigun
	name = "Weapons - Gatling Laser"
	desc = "For when you REALLY need to cook a steak from twenty yards away."
	cost = 50000
	contains = list(/obj/item/minigunpack)
	crate_name = "gatling laser crate"

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

/datum/supply_pack/secenergy/tgcarbine
	name = "TG Carbine"
	desc = "The basic Trident Gammaworks blaster carbine."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/carbine)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgpistol
	name = "TG Blaster Pistol"
	desc = "A more compact version of the TG carbine. Talk about a pocket protector."
	cost = 1800
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/carbine/pistol)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgspamlaser
	name = "TG Repeating Blaster"
	desc = "Maximum capacity, minimum power."
	cost = 1000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/spamlaser)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgrifle
	name = "TG Laser Rifle"
	desc = "A MKII Trident Gammaworks Laser Rifle. Useful if you don't have room for extra ammo cells, but suffers in longer adventures."
	cost = 2500
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/rifle)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgheavyrifle
	name = "TG Heavy Laser Rifle"
	desc = "A heavier variant of the MKII Laser Rifle. Fewer shots but each one hits much harder."
	cost = 1800
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/rifle/heavy)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgautorifle
	name = "TG Tactical Laser"
	desc = "The successor to the MKII Laser Rifle. Better in almost every way."
	cost = 3800
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/rifle/auto)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgnukerifle
	name = "TG Nuclear Rifle"
	desc = "Self-charging, powerful, and it irradiates your enemies! Just don't get hit with an EMP or you'll start to glow."
	cost = 8000 // 2 be increased
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/recharger/nuclear/rifle)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgnukepistol
	name = "TG Nuclear Pistol"
	desc = "For when you want a nuclear reactor in a holster instead of on your back."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/recharger/nuclear)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/tgpc
	name = "TG Particle Cannon"
	desc = "Five shots. More than enough to kill anything that moves."
	cost = 20000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/tg/particlecannon)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/aep7
	name = "AEP-7 Laser Pistol"
	desc = "For a brick, it shoots pretty good."
	cost = 1600
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/pistol)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/aer9
	name = "AER-9 Laser Rifle"
	desc = "For a bigger brick, it shoots pretty good."
	cost = 1600
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/aer9)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/plaspistol
	name = "Plasma Pistol"
	desc = "Compact and deadly. Just not quiet."
	cost = 1760
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/plasma/pistol)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/plasrifle
	name = "Plasma Rifle"
	desc = "Less compact, but just as deadly. Still not quiet."
	cost = 1800
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/plasma)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/aer12
	name = "AER-12 Laser Rifle"
	desc = "A more efficient brick. Shoots slightly better."
	cost = 1800
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/aer12)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/wattz1ks
	name = "Wattz 1000s Laser Pistol"
	desc = "For when you prefer accuracy by volume and death of a thousand cuts. Or burns, as the case may be."
	cost = 1660
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/wattzs)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/gammagun
	name = "Gamma Gun"
	desc = "For when you want to really ruin somebody's day."
	cost = 660
	num_contained = 1
	contains = list(/obj/item/gun/energy/gammagun)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/ionrifle
	name = "Ion Rifle"
	desc = "The perfect counter to robots or other energy guns. Big, bulky, and power efficient."
	cost = 2200
	num_contained = 1
	contains = list(/obj/item/gun/energy/ionrifle)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/ioncarbine
	name = "Ion Carbine"
	desc = "The perfect counter to robots or other energy guns. Medium, compact(ish), and sort of power efficient."
	cost = 2200
	num_contained = 1
	contains = list(/obj/item/gun/energy/ionrifle/carbine)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/ionpistol
	name = "Ion Pulse Pistol"
	desc = "The perfect counter to robots or other energy guns. Identical to the carbine in size, but less power efficient. At least it's cheaper."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/energy/ionrifle/compact)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/aer14
	name = "AER-14 Laser Rifle"
	desc = "An even more efficient brick. Shoots much better."
	cost = 2100
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/aer14)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/ultrarifle
	name = "Ultracite AER Laser Rifle"
	desc = "The most efficient brick of them all. Shoots pretty good. Uses the very rare Ultracite MFC."
	cost = 2500
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/ultra_rifle)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/laer
	name = "LAER Laser Rifle"
	desc = "An unusual brick. Damage is incredibly variable."
	cost = 2260
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/laer)
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

/datum/supply_pack/secenergy/wattz2ks
	name = "Wattz 2000 Sport Edition"
	desc = "The bougie version of the Wattz 2k. Not quite as strong, but it's self-charging."
	cost = 5000 
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/wattz2ks)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/retrolas
	name = "Retro Laser Pistol"
	desc = "An ultra-compact and incredibly powerful laser pistol. So small, it might even fit in your boot!"
	cost = 2100
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/retro)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/laserbuss
	name = "Laser Blunderbuss"
	desc = "It's just as insane as it sounds. Careful you don't lose a hand shooting it!"
	cost = 4260
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/scatter/laserbuss)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/compactrcw
	name = "Compact RCW"
	desc = "For when you want to put on a rave that kills people. Minimally effective against all forms of armor, but hyper-lethal otherwise."
	cost = 3800
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/auto)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/rcw
	name = "Laser RCW"
	desc = "For when you want to put on a rave that kills people. Only slightly less effective against armor."
	cost = 4000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/rcw)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/badlands
	name = "Badlands AEP-7"
	desc = "A smaller brick that shoots twice as good."
	cost = 3340
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/badlands)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/ever
	name = "Plasma Pistol Eve"
	desc = "An upgraded plasma pistol. Compact and extra deadly."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/plasma/pistol/eve)
	crate_name = "select weapon crate"

/datum/supply_pack/secenergy/adam
	name = "Plasma Pistol Adam"
	desc = "An upgraded plasma pistol. Less compact and even more deadly."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/plasma/pistol/adam)
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

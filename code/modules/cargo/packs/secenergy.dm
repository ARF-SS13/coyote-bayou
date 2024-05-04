
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

/* template start (price should be DPS*30 and shouldn't include anything past uncommon loot; adjust price based on unique features as needed)
/datum/supply_pack/secenergy/template
	name = "replace me"
	desc = "replace me"
	cost = replace me
	num_contained = 1
	contains = list(REPLACE ME)
	crate_name = "energy weapon crate"
template end */

// Pistols
/datum/supply_pack/secenergy/aep7
	name = "AEP-7"
	desc = "A compact laser pistol that uses SEC. It's a compact brick that shoots pretty alright."
	cost = 2400
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/pistol)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/wattzpistol
	name = "Wattz 1000"
	desc = "A medium power, compact laser pistol that uses SEC. It's funny how the civillian pistol is actually stronger than the military one."
	cost = 3900
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/wattz)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/retropistol
	name = "Retro Laser Pistol"
	desc = "A high power, ultracompact laser pistol that uses SEC. Set phasers to kill!"
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/retro)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/gammagun
	name = "Gamma Gun"
	desc = "A bulkier, low power laser pistol that uses SEC. Considering how radioactive this thing's shots are, using it against a ghoul probably isn't the best idea."
	cost = 1860
	num_contained = 1
	contains = list(/obj/item/gun/energy/gammagun)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/emppistol
	name = "Pulse Pistol"
	desc = "A bulkier, medium power EMP pistol that uses ECP. Cook both robots and your own weapon with one trigger pull!"
	cost = 3210
	num_contained = 1
	contains = list(/obj/item/gun/energy/ionrifle/compact)
	crate_name = "energy weapon crate"

//Rifles
/datum/supply_pack/secenergy/aer9
	name = "AER-9"
	desc = "A laser rifle that uses MFC. For a brick, it shoots pretty good."
	cost = 2400
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/aer9)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/ultraaer
	name = "Ultracite AER-9"
	desc = "A laser rifle that uses Ultracite MFC. For a brick, it shoots way more."
	cost = 4000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/ultra_rifle)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/wattzrifle
	name = "Wattz 2000"
	desc = "A high power laser rifle that uses MFC. Really, it's more of a laser sniper."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/wattz2k)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/wattzrifleext
	name = "Wattz 2000e"
	desc = "A medium power laser rifle that uses MFC. Really, it's more of a laser DMR."
	cost = 2750
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/wattz2k/extended)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/empcarbine
	name = "Ion Carbine"
	desc = "A semi-compact, but less efficient, EMP rifle that uses MFC. Perfect for making a robot regret bothering you, while also being compact enough to carry another gun."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/ionrifle/carbine)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/emprifle
	name = "YK-42b Pulse Rifle"
	desc = "A bulky and efficient EMP rifle that uses MFC. Someone really looked at a plasma rifle and thought it could be even more annoying."
	cost = 3200
	num_contained = 1
	contains = list(/obj/item/gun/energy/ionrifle)
	crate_name = "energy weapon crate"

// TG Blasters
/datum/supply_pack/secenergy/tgpistol
	name = "TG Blaster Pistol"
	desc = "A compact blaster pistol with a charging crank. If you have a vermin problem, this'll make short work of it. That's about all it'll do, though."
	cost = 1800
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/cranklasergun/tg/pistol)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/tgcarbine
	name = "TG Blaster Carbine"
	desc = "A semi-compact blaster carbine with a charging crank. Boring, but at least it's practical for almost any loadout."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/cranklasergun/tg/carbine)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/tgrepeatingblaster
	name = "TG Repeating Blaster"
	desc = "A bulky blaster rifle with a charging crank. For when you really need to clear out a small army of pillbugs."
	cost = 2010
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/cranklasergun/tg/spamlaser)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/tgshocker
	name = "TG Shock Autoblaster"
	desc = "A bulky tesla rifle with a charging crank. For when you really need to clear out a small army of geckos."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/cranklasergun/tg/spamlaser/shock)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/tgrifle
	name = "TG Laser Rifle"
	desc = "A bulky medium power blaster rifle with a charging crank. The real selling point of this rifle is its snappy two-round burst and more efficient charger."
	cost = 4500
	num_contained = 1
	contains = list(/obj/item/gun/energy/laser/cranklasergun/tg/rifle)
	crate_name = "energy weapon crate"

// Wands
/datum/supply_pack/secenergy/missilewand
	name = "Wand of Magic Missile"
	desc = "A magic wand that passively recharges while not in use. This one fires a spread of high power projectiles like a shotgun."
	cost = 4000
	num_contained = 1
	contains = list(/obj/item/gun/magic/wand/kelpmagic/magicmissile/improved)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/shockwand
	name = "Wand of Sparks"
	desc = "A magic wand that passively recharges while not in use. This one fires an extremely fast burst of low power lightning bolts and charges exceptionally fast."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/magic/wand/kelpmagic/sparky)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/fireboltwand
	name = "Wand of Firebolt"
	desc = "A magic wand that passively recharges while not in use. This one fires high power firebolts that partially ignore armor."
	cost = 3500
	num_contained = 1
	contains = list(/obj/item/gun/magic/wand/kelpmagic/firebolt)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/healwand
	name = "Wand of Mending"
	desc = "A magic wand that passively recharges while not in use. This one fires healing bolts that cures all damage types almost equally."
	cost = 3500
	num_contained = 1
	contains = list(/obj/item/gun/magic/wand/kelpmagic/healwand)
	crate_name = "energy weapon crate"

// Staves
/datum/supply_pack/secenergy/missilestaff
	name = "Staff of Magic Missile"
	desc = "A bulky magic staff that passively recharges while not in use. This one fires a spread of high power projectiles like a shotgun, and performs better in melee combat than other staves."
	cost = 10000
	num_contained = 1
	contains = list(/obj/item/gun/magic/staff/kelpmagic/magicmissile)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/acidstaff
	name = "Staff of Acid"
	desc = "A bulky magic staff that passively recharges while not in use. This one fires extremely rapid blasts of acid with incredibly varied damage."
	cost = 8000
	num_contained = 1
	contains = list(/obj/item/gun/magic/staff/kelpmagic/acidstaff)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/shockstaff
	name = "Staff of Lightning"
	desc = "A bulky magic staff that passively recharges while not in use. This one fires high power bolts of lightning."
	cost = 10000
	num_contained = 1
	contains = list(/obj/item/gun/magic/staff/kelpmagic/lightning)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/magmastaff
	name = "Staff of Alchemical Magma"
	desc = "A bulky magic staff that passively recharges while not in use. This one fires short range bolts of magma that recharges extremely quickly."
	cost = 15000
	num_contained = 1
	contains = list(/obj/item/gun/magic/staff/kelpmagic/flamethrower)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/fireballstaff
	name = "Staff of Fireball"
	desc = "A bulky magic staff that passively recharges while not in use. This one fires an extremely high powered, explosive fireball. Capable of destroying basic walls."
	cost = 10000
	num_contained = 1
	contains = list(/obj/item/gun/magic/staff/kelpmagic/fireball)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/healstaff
	name = "Staff of Healing"
	desc = "A bulky magic staff that passively recharges while not in use. This one fires healing bolts that cure all types of damage, and is incredibly efficient."
	cost = 7500
	num_contained = 1
	contains = list(/obj/item/gun/magic/staff/kelpmagic/healstaff)
	crate_name = "energy weapon crate"

/datum/supply_pack/secenergy/healstaffupgr
	name = "Perfected Staff of Healing"
	desc = "This magic staff has infinite charge. It heals slower than other staves, and only heals Brute and Burn damage, but leaves your other hand free for another weapon -- or you can use a second staff. Don't cross the streams from another person!"
	cost = 15000
	num_contained = 1
	contains = list(/obj/item/gun/medbeam/magic)
	crate_name = "energy weapon crate"

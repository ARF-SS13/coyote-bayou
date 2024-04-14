
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal - no fuck you
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////
//////////////////////////// Security - Ballistics //
////////////////////////////////////////////////////

/datum/supply_pack/security
	group = "Munitions - Ballistic"
	crate_type = /obj/structure/closet/crate/footlocker
	can_private_buy = 1
	var/num_contained = 1

/datum/supply_pack/security/randomized
	num_contained = 15

/datum/supply_pack/security/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to num_contained)
		var/item = pick(contains)
		new item(C)

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
	desc = "Three sets of advanced armor, choice pick of most scavengers."
	cost = 5000
	num_contained = 3
	contains = list(/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor,
					/obj/effect/spawner/lootdrop/f13/uncommon_armor)
	crate_name = "armor crate"

/datum/supply_pack/security/armorrare
	name = "Armor - Rare"
	desc = "One set of rare armor, the wasteland's premium in protection."
	cost = 10000
	num_contained = 1
	contains = list(/obj/effect/spawner/lootdrop/f13/rare_armor)
	crate_name = "armor crate"

/datum/supply_pack/security/nvgpack
	name = "Utility - Night Vision"
	desc = "A single set of Night Vision Goggles. Because you're just not tactical enough until you have a set of NODs on, even if it's the middle of the day."
	cost = 1500
	num_contained = 1
	contains = list(/obj/item/clothing/glasses/night)
	crate_name = "armor crate"

/datum/supply_pack/security/nvgpack_upgr
	name = "Utility - Prescription Night Vision"
	desc = "A set of NVGs, now adjusted for those with terrible vision! Wearing these doesn't make you less of a nerd, however."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/clothing/glasses/night/prescription)
	crate_name = "armor crate"

/datum/supply_pack/security/combatknives_single
	name = "Combat Knife Single-Pack"
	desc = "Some good ol' sharp knives. Guaranteed to fit snugly inside any cowboy-wasteland boot. You know what's better than one knife? Three of 'em!"
	cost = 500
	num_contained = 3
	contains = list(/obj/item/melee/onehanded/knife/hunting,
					/obj/item/melee/onehanded/knife/hunting,
					/obj/item/melee/onehanded/knife/hunting)

/datum/supply_pack/security/sechardsuit
	name = "Sec Hardsuit"
	desc = "It's an old style 'security hardsuit', whatever the fuck that's supposed to mean."
	cost = 1000 
	contains = list(/obj/item/clothing/suit/space/hardsuit/security,
					/obj/item/clothing/mask/gas)
	crate_name = "sec hardsuit crate"

/datum/supply_pack/security/securitybarriers
	name = "Security Barrier Grenades"
	desc = "Stem the tide with four pre-war riot grenades."
	contains = list(/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier)
	cost = 500
	num_contained = 4
	crate_name = "security barriers crate"
	can_private_buy = TRUE

/datum/supply_pack/security/minigun5mm
	name = "Weapons - Minigun"
	desc = "Holy moly, it's here. A refurbished minigun chambered in US five-aught. Heavy, impractical, expensive to buy, expensive to fire, expensive to maintain, and an absolute killer."
	cost = 20000
	contains = list(/obj/item/minigunpackbal5mm)
	crate_name = "minigun crate"

/*
/datum/supply_pack/security/weaponname
	name = ""
	desc = ""
	cost = weapon dps 2x, add a zero at the end
	num_contained = 1
	contains = list(/obj/item/clothing/glasses/night/prescription)
	crate_name = "select weapon crate"
	*/

/datum/supply_pack/security/nightops
	name = "M22 Night Ops SMG"
	desc = "An SMG of all time."
	cost = 8800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/m22)
	crate_name = "M22 Night Ops SMG Crate"

/datum/supply_pack/security/bozar
	name = "Bozar"
	desc = "It's a sniper rifle. It's a machine gun. It's overpowered."
	cost = 7600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/bozar)
	crate_name = "Bozar Crate"

/datum/supply_pack/security/greasegun
	name = "M3A1 Greasegun"
	desc = "Smearing people off sidewalks since 1942."
	cost = 7400
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/greasegun)
	crate_name = "M3A1 Crate"

/datum/supply_pack/security/asval
	name = "AS-VAL Supressed Rifle"
	desc = "No, Artyom.  You are the zone."
	cost = 7000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/vss)
	crate_name = "AS-VAL Crate"

/datum/supply_pack/security/autorevolver
	name = "Auto-Revolver"
	desc = "It's like a single action army if the single action army was an ma deuce."
	cost = 6800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/colt357/auto)
	crate_name = "Auto Revolver Crate"

/datum/supply_pack/security/webley
	name = "Webley Revolver"
	desc = "These reproduction Webley revolvers are of the highest quality.  Buy 4.  Trust me."
	cost = 6800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/police/webley)
	crate_name = "Webley Crate"

/datum/supply_pack/security/carlgustaf
	name = "10mm Carl Gustaf"
	desc = "Did Carl ever come in other calibers?  Where are the Swedes these days?"
	cost = 6500
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/cg45)
	crate_name = "10mm Carl Gustaf Crate"

/datum/supply_pack/security/widowmaker
	name = "Winchester Widowmaker"
	desc = "It has widowmaker in the name.  It doesn't come edgier than this, hombre."
	cost = 6500
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/widowmaker)
	crate_name = "Winchester Widowmaker Crate"

/datum/supply_pack/security/shotpistol
	name = "Hand Shotgun"
	desc = "Versus a butt shotgun.  Where else are you supposed to hold this damn thing?"
	cost = 6500
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/shotpistol)
	crate_name = "Hand Shotgun Crate"

/datum/supply_pack/security/tenmmsmg
	name = "10mm Submissive Machine Gun"
	desc = "A big chunky monkey fucking typewriter of an SMG. Good for bashing people to death when you inevitably run out of ammo because it was too heavy for you to carry."
	cost = 6500
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/smg10mm)
	crate_name = "10mm SMG Crate"

/datum/supply_pack/security/r91
	name = "R91 Assault Rifle"
	desc = "A devisive weapon of war. Purists will say it shouldn't exist because Dr. House didn't want Sneezer to lose in Old Vegas.  Or something.  I don't know."
	cost = 6600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/assault_rifle)
	crate_name = "R81 AR Crate"

/datum/supply_pack/security/maria
	name = "9mm Maria"
	desc = "A blessed pistol, forged in the fires of Gondor or something."
	cost = 6600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/pistol/ninemil/maria)
	crate_name = "Maria Crate"

/datum/supply_pack/security/mp5sd
	name = "MP-5 SD"
	desc = "An MP-5 of curious ancestry."
	cost = 6600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/mp5sd)
	crate_name = "MP-5 SD"

/datum/supply_pack/security/bren
	name = "Bren Gun"
	desc = "We're going to Brazil, get in."
	cost = 6600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/bren)
	crate_name = "Bren Crate"

/datum/supply_pack/security/m1919
	name = "M1919 Machine Gun"
	desc = "You know you will never look as cool as the guys in Soldier of Fortune, no matter how much you try."
	cost = 16600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/m1919)
	crate_name = "M1919 crate"

/datum/supply_pack/security/pancorjackhammer
	name = "Pancor Jackhammer"
	desc = "You're not making Ian proud right now."
	cost = 6800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/shotgun/pancor)
	crate_name = "Pancor Crate"

/datum/supply_pack/security/p90
	name = "FN P90c"
	desc = "We can never go back to 2002, but Counter Strike will live in our hearts forever."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/p90)
	crate_name = "FN P90C Crate"

/datum/supply_pack/security/fourteenmilsmg
	name = "14mm SMG"
	desc = "Listen, we know why you're here but you don't have to hate your wrists in character as much as out of character."
	cost = 6500
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/smg14)
	crate_name = "14mm SMG crate"

/datum/supply_pack/security/ppsh41
	name = "PPSH-41"
	desc = "FPS Russia moment."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/ppsh)
	crate_name = "PPSH-41 crate"

/datum/supply_pack/security/r84lmg
	name = "R84 Light Machine Gun"
	desc = "Yep.  It's a gun."
	cost = 6000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/r84)
	crate_name = "R84 LMG Crate"

/datum/supply_pack/security/lsw
	name = "Light Support Weapon"
	desc = "A tool of war that is neither light, nor supportive.  It is a weapon though.  Thank god."
	cost = 5800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/lsw)
	crate_name = "LSW Crate"

/datum/supply_pack/security/ch47assrifle
	name = "4.7mm Chinese Assault Rifle"
	desc = "Well above average in caliber, we assure you."
	cost = 5800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/rifle47mm/china)
	crate_name = "4.7mm Chinese AR "

/datum/supply_pack/security/tommygun
	name = "Thomspon SMG"
	desc = "You're either gangster or a paratrooper.  Which is it?"
	cost = 5800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/tommygun)
	crate_name = "Tommy Gun Crate"

/datum/supply_pack/security/amr
	name = "Anti-Material Rifle"
	desc = "As opposed to Pro-material rifles?"
	cost = 5600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/rifle/mag/antimaterial)
	crate_name = "AMR Crate"

/datum/supply_pack/security/mac10
	name = "Ingram Model 10"
	desc = "Okay, maybe you are an operator."
	cost = 4600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10)
	crate_name = "Ingram Model 10 Crate"

/datum/supply_pack/security/heavyneedlerifle
	name = "OT-64 Heavy Needler Rifle"
	desc = "The bane of anyone not wearing light armor or the simple minded."
	cost = 4400
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/needlerrifle)
	crate_name = "OT-64 Crate"

// prices below are completely eyeboll'd lmao

/datum/supply_pack/security/compact14mmrifle
	name = "Compact 14mm Rifle"
	desc = "Oh yeah, compact alright."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/compact14mmrifle)
	crate_name = "Bolter Crate"

/datum/supply_pack/security/alr15
	name = "ALR-15 Rifle"
	desc = "It's an assault rifle all right."
	cost = 3800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/service/alr)
	crate_name = "ALR-15 Crate"

/datum/supply_pack/security/ak74u
	name = "AK-74U Assault Rifle"
	desc = "It's like a baby AK."
	cost = 3400
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/aksmol)
	crate_name = "AK-74U Crate"

/datum/supply_pack/security/buntline
	name = "Colt Buntline Revolver"
	desc = "Put bluntly, its a bit of long for a wheel gat."
	cost = 5000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/buntline)
	crate_name = "Colt Buntline Crate"

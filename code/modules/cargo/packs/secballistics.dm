
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

/* template start (price should be DPS*20 and shouldn't include anything past uncommon loot; adjust price based on unique features as needed)
/datum/supply_pack/security/template
	name = "replace me"
	desc = "replace me"
	cost = replace me
	num_contained = 1
	contains = list(REPLACE ME)
	crate_name = "ballistic weapon crate"
template end */

// Handguns
/datum/supply_pack/security/deagle
	name = "Desert Eagle"
	desc = "A heavy handgun chambered in .44 magnum. More style than function."
	cost = 1920
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/pistol/deagle)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/tec22
	name = "Tec .22"
	desc = "An automatic machine pistol chambered in .22 long rifle. What side are you on, Pillbugs or Geckos?"
	cost = 2420
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/mk23
	name = "Mk. 23 SOCOM"
	desc = "An extra tactical handgun chambered in .45 ACP, comes with a seclight mount. The true sidearm of operators in any century."
	cost = 6500 // DPS price was 3960, but extra cost because it's a REALLY good pistol
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/pistol/mk23)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/lemat
	name = "Lemat 9mm Revolver"
	desc = "An exceptionally high-capacity revolver chambered in 9mm. Quantity is a quality of its own, right?"
	cost = 1940
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/Lemat)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/medusa
	name = "Medusa Multi-Caliber Revolver"
	desc = "A unique revolver that can fit a wide range of pistol calibers. Perfect for the disorganized or scavengers alike."
	cost = 2500
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/medusa)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/makarov
	name = "Makarov"
	desc = "A Soviet handgun chambered in 9mm and uses doublestack magazines. Remember, no Russian."
	cost = 2600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/pistol/ninemil/makarov)
	crate_name = "ballistic weapon crate"

// Submachine Guns
/datum/supply_pack/security/mp40
	name = "MP 40"
	desc = "A German submachine gun chambered in 9mm. It's hard to tell if this one came from a museum or a movie set, but either way it works just fine."
	cost = 3020
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp40)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/worngreasegun
	name = "Worn Greasegun"
	desc = "A worn-down American submachine gun chambered in .45 ACP. While it's seen better days, this classic will still chew through mutants and raiders alike."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/greasegun/worn)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/bushmaster
	name = "Bushmaster Arm Pistol"
	desc = "An unusual semi-automatic 'pistol' chambered in 5.56mm. I mean, it's called a pistol but it uses a rifle cartridge so I guess it's a carbine?"
	cost = 2040
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/worn10mmsmg
	name = "Worn 10mm SMG"
	desc = "A worn-down submachine gun chambered in 10mm. This thing just cannot be comfortable to shoot. At least it sucks to be shot by, too."
	cost = 4750
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/smg10mm/worn)
	crate_name = "ballistic weapon crate"

// Shotguns / Cowboy Guns
/datum/supply_pack/security/riotshotty
	name = "Riot Shotgun"
	desc = "A shotgun that uses drum mags. While it's meant for riot suppression, there's absolutely nothing stopping you from loading it with buckshot or slugs."
	cost = 4000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/shotgun/riot)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/saiga
	name = "Saiga 12k Shotgun"
	desc = "A Russian shotgun that uses magazines. Someone really looked at an AK and thought it'd be better off shooting buckshot."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/saiga12k)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/trenchgun
	name = "Trenchgun"
	desc = "A pump-action shotgun that can fit extra ammo and a bayonet. For when you really need to get up close and personal."
	cost = 2260
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/shotgun/trench)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/cowboyrepeater
	name = "Cowboy Repeater"
	desc = "A lever-action rifle chambered in .357 magnum. Yee haw."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/rifle/repeater/cowboy)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/trailcarbine
	name = "Trail Carbine"
	desc = "A lever-action rifle chambered in .44 magnum. For when you want to yee and haw just a little harder."
	cost = 2500
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/rifle/repeater/trail)
	crate_name = "ballistic weapon crate"

// Assault Rifles
/datum/supply_pack/security/servicerifle
	name = "Service Rifle"
	desc = "A semi-automatic rifle chambered in 5.56mm. This versatile weapon even has a bayonet lug, just in case you want to turn your firearm into a discount spear."
	cost = 3620
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/service)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/needlerifle
	name = "NR-43 Needle Rifle"
	desc = "A semi-automatic rifle that fires crystalline needles. Supposedly made on earth, but it seems fairly alien in design."
	cost = 3750
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/needlerrifle)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/ak47
	name = "AK-47"
	desc = "A classic Soviet assault rifle rechambered in .308 and only accepts extended magazines. Supposedly it'll work no matter what you do to it. Odds are you'll be putting that claim to the test out here."
	cost = 2280
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/fnfal/ak47)
	crate_name = "ballistic weapon crate"

// Long Rifles (Bolts/Snipers)
/datum/supply_pack/security/garand
	name = "M1 Garand"
	desc = "A semi-automatic rifle that uses .30-06 en-bloc clips. Yes, they're actually clips and not magazines. Also, mind your thumb!"
	cost = 2480
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/m1garand)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/g43
	name = "G43"
	desc = "A semi-automatic rifle that uses .308 extended magazines. Unfortunately, this is a modern-ish reproduction. At least you don't need to track down 8mm Mauser to use it."
	cost = 2280
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/gewehr43)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/mosin
	name = "M38 Mosin-Nagant"
	desc = "A bolt-action rifle rechambered in .308 with a bayonet lug. The world's deadliest moist nugget."
	cost = 1380
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/rifle/mosin)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/huntingrifle
	name = "Hunting Rifle"
	desc = "A bolt-action rifle chambered in .30-06. Perfect no matter what you decide to hunt, from geckos to deathclaws. Just, maybe, don't try and use this to clear out a pillbug infestation?"
	cost = 2200
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/rifle/hunting)
	crate_name = "ballistic weapon crate"

// Special Weapons (Bows, Explosives, etc)
/datum/supply_pack/security/longbow
	name = "Longbow"
	desc = "A bow with a higher than average draw power. Mostly silent but plenty deadly."
	cost = 1080
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/bow/longbow)
	crate_name = "ballistic weapon crate"

/datum/supply_pack/security/flamethrower
	name = "M2 Flamethrower"
	desc = "A backpack fuel tank with attached flamethrower. You probably shouldn't use this to cook your lunch."
	cost = 3000
	num_contained = 1
	contains = list(/obj/item/m2flamethrowertank)
	crate_name = "ballistic weapon crate"

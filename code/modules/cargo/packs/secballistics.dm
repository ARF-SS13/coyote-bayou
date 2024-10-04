
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
	desc = "Stem the tide with four Pre-Fall riot grenades."
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

/datum/supply_pack/security/fatman
	name = "Fatman"
	desc = "Its a fatman.  It blows shit way the fuck up."
	cost = 140000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/fatman)
	crate_name = "select weapon crate"

/datum/supply_pack/security/nightops
	name = "M22 Night Ops SMG"
	desc = "An SMG of all time."
	cost = 8600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/m22)
	crate_name = "select weapon crate"

/datum/supply_pack/security/bozar
	name = "Bozar"
	desc = "It's a sniper rifle. It's a machine gun. It's overpowered."
	cost = 7400
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/bozar)
	crate_name = "select weapon crate"

/datum/supply_pack/security/greasegun
	name = "M3A1 Greasegun"
	desc = "Smearing people off sidewalks since 1942."
	cost = 7200
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/greasegun)
	crate_name = "select weapon crate"

/datum/supply_pack/security/asval
	name = "AS-VAL Supressed Rifle"
	desc = "No, Artyom.  You are the zone."
	cost = 6800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/vss)
	crate_name = "select weapon crate"

/datum/supply_pack/security/autorevolver
	name = "Auto-Revolver"
	desc = "It's like a single action army if the single action army was an ma deuce."
	cost = 6600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/colt357/auto)
	crate_name = "select weapon crate"

/datum/supply_pack/security/webley
	name = "Webley Revolver"
	desc = "These reproduction Webley revolvers are of the highest quality.  Buy 4.  Trust me."
	cost = 6600
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/police/webley)
	crate_name = "select weapon crate"

/datum/supply_pack/security/carlgustaf
	name = "10mm Carl Gustaf"
	desc = "Did Carl ever come in other calibers?  Where are the Swedes these days?"
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/cg45)
	crate_name = "select weapon crate"

/datum/supply_pack/security/widowmaker
	name = "Winchester Widowmaker"
	desc = "It has widowmaker in the name.  It doesn't come edgier than this, hombre."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/widowmaker)
	crate_name = "select weapon crate"

/datum/supply_pack/security/shotpistol
	name = "Hand Shotgun"
	desc = "Versus a butt shotgun.  Where else are you supposed to hold this damn thing?"
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/shotpistol)
	crate_name = "select weapon crate"

/datum/supply_pack/security/shotpistol
	name = "Hand Shotgun"
	desc = "Versus a butt shotgun.  Where else are you supposed to hold this damn thing?"
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/shotpistol)
	crate_name = "select weapon crate"

/datum/supply_pack/security/tenmmsmg
	name = "10mm Submissive Machine Gun"
	desc = "A big chunky monkey fucking typewriter of an SMG. Good for bashing people to death when you inevitably run out of ammo because it was too heavy for you to carry."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/smg10mm)
	crate_name = "select weapon crate"

/datum/supply_pack/security/r91
	name = "R91 Assault Rifle"
	desc = "A devisive weapon of war. Purists will say it shouldn't exist because Dr. House didn't want Sneezer to lose in Old Vegas.  Or something.  I don't know."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/assault_rifle)
	crate_name = "select weapon crate"

/datum/supply_pack/security/maria
	name = "9mm Maria"
	desc = "A blessed pistol, forged in the fires of Gondor or something."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/pistol/ninemil/maria)
	crate_name = "select weapon crate"

/datum/supply_pack/security/mp5sd
	name = "MP-5 SD"
	desc = "An MP-5 of curious ancestry."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/mp5sd)
	crate_name = "select weapon crate"

/datum/supply_pack/security/bren
	name = "Bren Gun"
	desc = "We're going to Brazil, get in."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/bren)
	crate_name = "select weapon crate"

/datum/supply_pack/security/m1919
	name = "M1919 Machine Gun"
	desc = "You know you will never look as cool as the guys in Soldier of Fortune, no matter how much you try."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/m1919)
	crate_name = "select weapon crate"

/datum/supply_pack/security/pancorjackhammer
	name = "Pancor Jackhammer"
	desc = "You're not making Ian proud right now."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/shotgun/pancor)
	crate_name = "select weapon crate"

/datum/supply_pack/security/p90
	name = "FN P90c"
	desc = "We can never go back to 2002, but Counter Strike will live in our hearts forever."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/p90)
	crate_name = "select weapon crate"

/datum/supply_pack/security/fourteenmilsmg
	name = "14mm SMG"
	desc = "Listen, we know why you're here but you don't have to hate your wrists in character as much as out of character."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/smg14)
	crate_name = "select weapon crate"

/datum/supply_pack/security/ppsh41
	name = "PPSH-41"
	desc = "FPS Russia moment."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/ppsh)
	crate_name = "select weapon crate"

/datum/supply_pack/security/ppsh41
	name = "PPSH-41"
	desc = "FPS Russia moment."
	cost = 6300
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/ppsh)
	crate_name = "select weapon crate"

/datum/supply_pack/security/r84lmg
	name = "R84 Light Machine Gun"
	desc = "Yep.  It's a gun."
	cost = 5800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/r84)
	crate_name = "select weapon crate"

/datum/supply_pack/security/lsw
	name = "Light Support Weapon"
	desc = "A tool of war that is neither light, nor supportive.  It is a weapon though.  Thank god."
	cost = 5800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/lsw)
	crate_name = "select weapon crate"

/datum/supply_pack/security/ch47assrifle
	name = "4.7mm Chinese Assault Rifle"
	desc = "Well above average in caliber, we assure you."
	cost = 5800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/rifle47mm/china)
	crate_name = "select weapon crate"

/datum/supply_pack/security/tommygun
	name = "Thomspon SMG"
	desc = "You're either gangster or a paratrooper.  Which is it?"
	cost = 5800
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/tommygun)
	crate_name = "select weapon crate"

/datum/supply_pack/security/amr
	name = "Anti-Material Rifle"
	desc = "As opposed to Pro-material rifles?"
	cost = 5000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/rifle/mag/antimaterial)
	crate_name = "select weapon crate"

/datum/supply_pack/security/mac10
	name = "Ingram Model 10"
	desc = "Okay, maybe you are an operator."
	cost = 4400
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10)
	crate_name = "select weapon crate"

/datum/supply_pack/security/heavyneedlerifle
	name = "OT-64 Heavy Needler Rifle"
	desc = "The bane of anyone not wearing light armor or the simple minded."
	cost = 4400
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/needlerrifle)
	crate_name = "select weapon crate"

/datum/supply_pack/security/compact14mmrifle
	name = "Compact 14mm Rifle"
	desc = "Oh yeah, compact alright."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/compact14mmrifle)
	crate_name = "select weapon crate"

/datum/supply_pack/security/alr15
	name = "ALR-15 Rifle"
	desc = "It's an assault rifle all right."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/service/alr)
	crate_name = "select weapon crate"

/datum/supply_pack/security/ak74u
	name = "AK-74U Assault Rifle"
	desc = "It's like a baby AK."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/aksmol)
	crate_name = "select weapon crate"

/datum/supply_pack/security/buntline
	name = "Colt Buntline Revolver"
	desc = "Put bluntly, its a bit of long for a wheel gat."
	cost = 2000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/revolver/buntline)
	crate_name = "select weapon crate"

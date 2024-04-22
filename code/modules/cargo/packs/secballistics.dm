
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

/datum/supply_pack/security/alr15
	name = "ALR-15 Rifle"
	desc = "It's an assault rifle all right."
	cost = 4000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/service/alr)
	crate_name = "ALR-15 Crate"

/datum/supply_pack/security/ak74u
	name = "AK-74U Assault Rifle"
	desc = "It's like a baby AK."
	cost = 4000
	num_contained = 1
	contains = list(/obj/item/gun/ballistic/automatic/aksmol)
	crate_name = "AK-74U Crate"

/obj/machinery/mineral/wasteland_trader
	name = "Workshop Scrapper"
	desc = "A vending machine that's been modified to accept various items in exchange for caps. A sign on it reads, 'Keep your workplace clean and get paid doing it!' It's better than a trash can, at least."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "weapon_idle"

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9

	var/stored_caps = 0	// store caps
	var/expected_price = 0
	var/list/prize_list = list()  // Once this is readded to the map, I need to do some testing regarding gunpowder. See if I can't bully the commie reloading bench to death.

	var/list/goods_list = list( /obj/item/clothing/suit/armor = 5,
								/obj/item/stack/crafting/metalparts = 1,
								/obj/item/stack/crafting/goodparts = 3,
								/obj/item/stack/crafting/electronicparts = 3,
								/obj/item/gun/ballistic/automatic = 15,
								/obj/item/gun/ballistic/automatic/pistol = 5,
								/obj/item/gun/ballistic/revolver = 5,
								/obj/item/gun/ballistic/rifle = 10,
								/obj/item/gun/ballistic/shotgun = 10,
								/obj/item/gun/ballistic/automatic/hobo = 0,
								/obj/item/gun/ballistic/revolver/hobo = 0,
								/obj/item/gun/ballistic/rifle/hobo = 0,
								/obj/item/gun/ballistic/revolver/sling = 0,
								/obj/item/gun/ballistic/revolver/brick = 0,
								/obj/item/gun/ballistic/automatic/autopipe = 0,
								/obj/item/advanced_crafting_components = 15,
								/obj/item/export/bottle/gin = 15,
								/obj/item/export/bottle/whiskey = 15,
								/obj/item/export/bottle/wine = 15,
								/obj/item/export/bottle/vodka = 15,
								/obj/item/export/bottle/rum = 15,
								/obj/item/export/bottle/tequila = 15,
								/obj/item/export/bottle/minikeg = 15,
								/obj/item/export/bottle/applejack = 15,
								/obj/item/export/bottle/cognac = 15,
								/obj/item/export/bottle/sake = 15,
								/obj/item/export/bottle/hcider = 15,
								/obj/item/export/bottle/vermouth = 15,
								/obj/item/export/bottle/absinthe = 15,
								/obj/item/export/bottle/grappa = 15,
								/obj/item/export/bottle/fernet = 15,
								/obj/item/export/bottle/kahlua = 15,
								/obj/item/export/bottle/champagne = 30,
								/obj/item/export/bottle/blazaam = 30,
								/obj/item/export/bottle/nukashine = 30,
								/obj/item/export/bottle/trappist = 30,
								/obj/item/export/bottle/goldschlager = 30,
								/obj/item/export/bottle/patron = 30,
								/obj/item/toy = 3,
								/obj/item/toy/prize = 15,
								/obj/item/toy/talking = 15,
								/obj/item/stealthboy = 100
								)

/obj/machinery/mineral/wasteland_trader/general
	name = "Trading point"
	icon_state = "generic_idle"
	prize_list = list()

/*
/datum/data/wasteland_equipment
	var/equipment_name = "generic"
	var/equipment_path = null
	var/cost = 0

/datum/data/wasteland_equipment/New(name, path, cost)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost
*/
/obj/machinery/mineral/wasteland_trader/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Armor: 5 caps<br>"
	dat += "Handguns: 5 caps<br>"
	dat += "Rifles and Shotguns: 10 caps<br>"
	dat += "Submachine Guns and Automatic Rifles: 15 caps<br>"
	dat += "Improvised Firearms: 0 caps<br>"
	dat += "Metal and Electronic Parts: 1 - 3 caps<br>"
	dat += "Advanced Components: 15 caps<br>"
	dat += "Sealed Alcohol Bottles: 15 - 30 caps<br>"
	dat += "Basic Toys: 3 caps<br>"
	dat += "Advanced Toys: 15 caps<br>"
	dat += "Stealthboy: 100 caps<br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Trading point", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"] == "eject")
		remove_all_caps()
	if(href_list["purchase"])
		var/datum/data/wasteland_equipment/prize = locate(href_list["purchase"])
		if (!prize || !(prize in prize_list))
			to_chat(usr, span_warning("Error: Invalid choice!"))
			return
		if(prize.cost > stored_caps)
			to_chat(usr, span_warning("Error: Insufficent bottle caps value for [prize.equipment_name]!"))
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, span_notice("[src] clanks to life briefly before vending [prize.equipment_name]!"))
			new prize.equipment_path(src.loc)
			SSblackbox.record_feedback("nested tally", "wasteland_equipment_bought", 1, list("[type]", "[prize.equipment_path]"))
	updateUsrDialog()
	return

/obj/machinery/mineral/wasteland_trader/attackby(obj/item/I, mob/user, params)
	add_caps(I)
	//not sure why anything else was here anyways?

/* Adding a caps to caps storage and release vending item. */
/obj/machinery/mineral/wasteland_trader/proc/add_caps(obj/item/I)
	var/final_value = 0
	var/value_per = 0

	if(!(I?.type in goods_list))
		to_chat(usr, span_notice("[src] is not buying that!"))
		return

	value_per = goods_list[I.type]
	if(!isnum(value_per))
		return

	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		final_value = FLOOR(S.amount * value_per, 1)
	else
		final_value = value_per

	stored_caps += final_value
	playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
	to_chat(usr, "You sell [final_value] bottle caps value to the [src]. Total caps: [stored_caps].")
	qdel(I)
	src.ui_interact(usr)

/* Spawn all caps on world and clear caps storage */
/obj/machinery/mineral/wasteland_trader/proc/remove_all_caps()
	if(stored_caps <= 0)
		return
	var/obj/item/stack/f13Cash/C = new /obj/item/stack/f13Cash/caps
	if(stored_caps > C.max_amount)
		C.add(C.max_amount - 1)
		C.forceMove(src.loc)
		stored_caps -= C.max_amount
	else
		C.add(stored_caps - 1)
		C.forceMove(src.loc)
		stored_caps = 0
	playsound(src, 'sound/items/coinflip.ogg', 60, 1)
	src.ui_interact(usr)

/*

ORGAN SELLER

*/

/obj/machinery/mineral/wasteland_trader/organ
	name = "Organ Grinder"
	desc = "Organs go in, caps come out. How does it work? Nobody knows."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "organs"

	goods_list = list( /obj/item/organ/heart = 30,
								/obj/item/organ/ears = 5,
								/obj/item/organ/eyes = 5,
								/obj/item/organ/liver = 15,
								/obj/item/organ/lungs = 25,
								/obj/item/organ/stomach = 15,
								/obj/item/organ/tongue = 5
								)

/obj/machinery/mineral/wasteland_trader/organ/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Heart : 30 caps<br>"
	dat += "Lungs : 25 caps<br>"
	dat += "Liver : 15 caps<br>"
	dat += "Stomach : 15 caps<br>"
	dat += "Eyes : 5 caps<br>"
	dat += "Ears : 5 caps<br>"
	dat += "Tongue : 5 caps<br>"
	dat += "Brain : UNAVAILABLE<br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Organ Grinder", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/organ/attackby(obj/item/I, mob/user, params)
	add_caps_squish(I)

/* Adding a caps to caps storage and release vending item. */
/obj/machinery/mineral/wasteland_trader/organ/proc/add_caps_squish(obj/item/I)
	var/final_value = 0
	var/value_per = 0

	if(!(I?.type in goods_list))
		to_chat(usr, span_notice("[src] is not buying that!"))
		return

	value_per = goods_list[I.type]
	if(!isnum(value_per))
		return

	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		final_value = FLOOR(S.amount * value_per, 1)
	else
		final_value = value_per

	stored_caps += final_value
	playsound(src, 'sound/vore/prey/squish_01.ogg', 60, 1)
	to_chat(usr, "You sell [final_value] bottle caps value to the [src]. Total caps: [stored_caps].")
	qdel(I)
	src.ui_interact(usr)

/*

Fence

*/

/obj/machinery/mineral/wasteland_trader/brotherhood
	name = "Brotherhood of Steal"

	goods_list = list( /obj/item/radio/headset/headset_bos = 15,
								/obj/item/clothing/under/syndicate/brotherhood = 15,
								/obj/item/card/id/dogtag = 30,
								/obj/item/clothing/shoes/combat/swat = 5,
								/obj/item/clothing/gloves/combat = 5,
								/obj/item/clothing/accessory/bos/initiateS = 5,
								/obj/item/clothing/accessory/bos/initiateK = 5,
								/obj/item/clothing/head/helmet/f13/combat/brotherhood/initiate = 30,
								/obj/item/clothing/suit/armor/medium/combat/brotherhood/initiate = 30,
								/obj/item/clothing/accessory/bos/juniorknight = 5,
								/obj/item/clothing/accessory/bos/knight = 15,
								/obj/item/clothing/head/helmet/f13/combat/brotherhood = 45,
								/obj/item/clothing/suit/armor/medium/combat/brotherhood = 45,
								/obj/item/clothing/suit/armor/medium/combat/brotherhood/senior = 60,
								/obj/item/clothing/head/helmet/f13/combat/brotherhood/senior = 60,
								/obj/item/clothing/glasses/night = 150,
								/obj/item/clothing/accessory/bos/seniorknight = 30,
								/obj/item/clothing/accessory/bos/scribe = 15,
								/obj/item/clothing/accessory/bos/juniorscribe = 5,
								/obj/item/clothing/suit/armor/light/duster/bos/scribe = 45,
								/obj/item/clothing/suit/armor/light/duster/bos/scribe/seniorscribe = 60,
								/obj/item/clothing/accessory/bos/seniorscribe = 30,
								/obj/item/clothing/accessory/bos/juniorpaladin = 15,
								/obj/item/clothing/accessory/bos/paladin = 30,
								/obj/item/clothing/accessory/bos/seniorpaladin = 45,
								/obj/item/clothing/suit/armor/medium/combat/brotherhood/captain = 75,
								/obj/item/clothing/accessory/bos/knightcaptain = 60,
								/obj/item/clothing/head/helmet/f13/combat/brotherhood/captain = 75,
								/obj/item/clothing/accessory/bos/headscribe = 60,
								/obj/item/clothing/suit/armor/light/duster/bos/scribe/headscribe = 75,
								/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 75,
								/obj/item/clothing/under/f13/recon = 30,
								/obj/item/clothing/accessory/bos/sentinel = 30,
								/obj/item/clothing/suit/armor/light/duster/bos/scribe/elder = 300,
								/obj/item/clothing/accessory/bos/elder = 300,
								/obj/item/gun/energy/laser/laer = 600,
								/obj/item/clothing/neck/mantle/bos/right = 300

								)

/obj/machinery/mineral/wasteland_trader/brotherhood/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Buying a wide variety of Brotherhood gear.</b><br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Brotherhood of Steal", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/gunbuyer
	name = "Gun Repository"
	desc = "Place weapon inside slot. Weapon is sent out of the region for post-processing. Recieve compensation. Yuma Wasteland Supply Inc. thanks you for disarming the wasteland."
	goods_list = list(/obj/item/gun/ballistic/automatic/hobo/zipgun = 5,
						/obj/item/gun/ballistic/revolver/hobo = 5,
						/obj/item/gun/ballistic/revolver/detective = 5,
						/obj/item/gun/ballistic/revolver/hobo = 8,
						/obj/item/gun/ballistic/revolver/hobo/piperifle = 8,
						/obj/item/gun/ballistic/revolver/hobo/knifegun = 8,
						/obj/item/gun/ballistic/revolver/hobo/pepperbox = 8,
						/obj/item/gun/ballistic/revolver/single_shotgun = 8,
						/obj/item/gun/ballistic/automatic/pistol/n99 = 8,
						/obj/item/gun/ballistic/automatic/pistol/pistol22 = 8,
						/obj/item/gun/ballistic/automatic/pistol/ninemil = 8,
						/obj/item/gun/ballistic/automatic/pistol/sig = 8,
						/obj/item/gun/ballistic/automatic/pistol/beretta = 8,
						/obj/item/gun/ballistic/automatic/pistol/m1911 = 8,
						/obj/item/gun/ballistic/rifle/hunting = 10,
						/obj/item/gun/ballistic/revolver/colt357 = 10,
						/obj/item/gun/ballistic/rifle/mosin = 10,
						/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
						/obj/item/gun/ballistic/revolver/widowmaker = 10,
						/obj/item/gun/ballistic/revolver/winchesterrebored = 10,
						/obj/item/gun/ballistic/automatic/autopipe = 15,
						/obj/item/gun/ballistic/rifle/hobo/lasmusket = 15,
						)

/obj/machinery/mineral/wasteland_trader/gunbuyer/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Disarming the Wasteland one gun at a time.</b><br>"
	dat += "<b>Warning: The automated system cannot guarantee an accurate appraisal of value.</b><br>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Pistols and revolvers: 5-10 caps<br>"
	dat += "Rifles and Shotguns : 10-15 caps<br>"
	dat += "Does not accept weapons of historical or artisanal value. Those belong in a musuem."
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Trading point", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

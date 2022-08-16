/obj/machinery/mineral/wasteland_trader
	name = "Trading point"
	desc = "Trading point at which you can sell select goods for caps."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "weapon_idle"

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9

	var/stored_caps = 0	// store caps
	var/expected_price = 0
	var/list/prize_list = list()  //if you add something to this, please, for the love of god, sort it by price/type. use tabs and not spaces.

	var/list/goods_list = list( /obj/item/stack/sheet/mineral/diamond = 15,
								/obj/item/stack/sheet/mineral/gold = 10,
								/obj/item/stack/sheet/mineral/silver = 5,
								/obj/item/stack/sheet/metal = 0.5,
								/obj/item/reagent_containers/food/snacks/grown/wheat = 1,
								/obj/item/reagent_containers/food/snacks/grown/rice = 1,
								/obj/item/reagent_containers/food/snacks/grown/oat = 1,
								/obj/item/stack/sheet/hay = 1,
								/obj/item/reagent_containers/food/snacks/grown/broc = 2.5,
								/obj/item/reagent_containers/food/snacks/grown/xander = 2.5,
								/obj/item/reagent_containers/food/snacks/grown/pungafruit = 2.5,
								/obj/item/reagent_containers/food/snacks/grown/feracactus = 2.5,
								/obj/item/reagent_containers/food/snacks/grown/fungus = 2.5,
								/obj/item/reagent_containers/food/snacks/grown/agave = 2.5,
								/obj/item/reagent_containers/pill/patch/jet = 10,
								/obj/item/reagent_containers/pill/healingpowder = 5,
								/obj/item/reagent_containers/hypospray/medipen/psycho = 10,
								/obj/item/reagent_containers/hypospray/medipen/medx = 15,
								/obj/item/reagent_containers/pill/patch/healpoultice = 20,
								/obj/item/export/bottle/gin = 10,
								/obj/item/export/bottle/wine = 10,
								/obj/item/export/bottle/whiskey = 10,
								/obj/item/export/bottle/vodka = 10,
								/obj/item/export/bottle/tequila = 10,
								/obj/item/export/bottle/patron = 20,
								/obj/item/export/bottle/rum = 10,
								/obj/item/export/bottle/vermouth = 10,
								/obj/item/export/bottle/kahlua = 10,
								/obj/item/export/bottle/goldschlager = 35,
								/obj/item/export/bottle/hcider = 10,
								/obj/item/export/bottle/cognac = 10,
								/obj/item/export/bottle/absinthe = 10,
								/obj/item/export/bottle/grappa = 10,
								/obj/item/export/bottle/sake = 10,
								/obj/item/export/bottle/fernet = 10,
								/obj/item/export/bottle/applejack = 10,
								/obj/item/export/bottle/champagne = 10,
								/obj/item/export/bottle/blazaam = 10,
								/obj/item/export/bottle/trappist = 10,
								/obj/item/export/bottle/minikeg = 10,
								/obj/item/export/bottle/nukashine = 50,
								/obj/item/reagent_containers/hypospray/medipen/stimpak = 5,
								/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 20,
								/obj/item/reagent_containers/food/snacks/pemmican = 100
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
	dat += "Wheat/Oats/Rice/Hay : 1 caps<br>"
	dat += "Broc/Xander/Punga Fruit/Barrel Cactus Fruit/Cave Fungus/Agave : 2.5 caps<br>"
	dat += "Iron Sheets : 0.5 caps<br>"
	dat += "Silver Bars: 5 caps<br>"
	dat += "Gold Bars: 10 caps<br>"
	dat += "Cut Diamonds : 15 caps<br>"
	dat += "Jet/Psycho/MedX : 10/15 caps<br>"
	dat += "Healing Powder/Healing Paultice : 5/20 caps<br>"
	dat += "Stimpak/Super Stimpak : 5/20 caps<br>"
	dat += "Sealed Bottle of Alcohol: 10-50 caps<br>"
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

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

	var/list/goods_list = list( /obj/item/stack/ore/diamond = 25,
								/obj/item/stack/ore/gold = 7,
								/obj/item/stack/ore/silver = 2,
								/obj/item/stack/ore/iron = 1,
								/obj/item/stack/sheet/leather = 3,
								/obj/item/reagent_containers/inhaler/jet = 5,
								/obj/item/reagent_containers/hypospray/medipen/psycho = 15,
								/obj/item/reagent_containers/hypospray/medipen/medx = 15
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
	dat += "Iron ore : 1.5 caps<br>"
	dat += "Silver : 5 caps<br>"
	dat += "Gold : 15 caps<br>"
	dat += "Diamond : 50 caps<br>"
	dat += "Leather : 5 caps<br>"
	dat += "Jet/Psycho/MedX : 5-15 caps<br>"
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
			to_chat(usr, "<span class='warning'>Error: Invalid choice!</span>")
			return
		if(prize.cost > stored_caps)
			to_chat(usr, "<span class='warning'>Error: Insufficent bottle caps value for [prize.equipment_name]!</span>")
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, "<span class='notice'>[src] clanks to life briefly before vending [prize.equipment_name]!</span>")
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
		to_chat(usr, "<span class='notice'>[src] is not buying that!</span>")
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
		to_chat(usr, "<span class='notice'>[src] is not buying that!</span>")
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
								/obj/item/clothing/suit/armor/f13/combat/brotherhood/initiate = 30,
								/obj/item/clothing/accessory/bos/juniorknight = 5,
								/obj/item/clothing/accessory/bos/knight = 15,
								/obj/item/clothing/head/helmet/f13/combat/brotherhood = 45,
								/obj/item/clothing/suit/armor/f13/combat/brotherhood = 45,
								/obj/item/clothing/suit/armor/f13/combat/brotherhood/senior = 60,
								/obj/item/clothing/head/helmet/f13/combat/brotherhood/senior = 60,
								/obj/item/clothing/glasses/night = 150,
								/obj/item/clothing/accessory/bos/seniorknight = 30,
								/obj/item/clothing/accessory/bos/scribe = 15,
								/obj/item/clothing/accessory/bos/juniorscribe = 5,
								/obj/item/clothing/suit/f13/scribe = 45,
								/obj/item/clothing/suit/f13/seniorscribe = 60,
								/obj/item/clothing/accessory/bos/seniorscribe = 30,
								/obj/item/clothing/accessory/bos/juniorpaladin = 15,
								/obj/item/clothing/accessory/bos/paladin = 30,
								/obj/item/clothing/accessory/bos/seniorpaladin = 45,
								/obj/item/clothing/suit/armor/f13/combat/brotherhood/captain = 75,
								/obj/item/clothing/accessory/bos/knightcaptain = 60,
								/obj/item/clothing/head/helmet/f13/combat/brotherhood/captain = 75,
								/obj/item/clothing/accessory/bos/headscribe = 60,
								/obj/item/clothing/suit/armor/f13/headscribe = 75,
								/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 75,
								/obj/item/clothing/under/f13/recon = 30,
								/obj/item/clothing/accessory/bos/sentinel = 30,
								/obj/item/clothing/suit/f13/elder = 300,
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

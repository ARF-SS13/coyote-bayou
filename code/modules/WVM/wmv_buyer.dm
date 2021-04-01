/obj/machinery/mineral/wasteland_trader
	name = "Trading point"
	desc = "Trading point at which you can sell select goods for caps"
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
								/obj/item/reagent_containers/pill/patch/jet = 5,
								/obj/item/reagent_containers/hypospray/medipen/psycho = 15,
								/obj/item/reagent_containers/syringe/medx = 15
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

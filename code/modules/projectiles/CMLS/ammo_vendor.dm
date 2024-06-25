
/////////////////////////////////////////////////////////////////
/// and a vending machine for the ammo, cus lathes are for chumps
/obj/structure/CMLS_ammo_vending_machine
	name = "Ammo Vending Machine"
	desc = "An Adventurer's Guild Port-A-Shop Ammo Vendor 2000, linked to the Guild's central armory (courtesey of the Great Eastern Hiveblob). \
		You can buy ammo boxes and crates here!"
	icon = 'icons/obj/vending.dmi'
	icon_state = "sustenance"
	max_integrity = INFINITY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ON_FIRE | UNACIDABLE | ACID_PROOF

/obj/structure/CMLS_ammo_vending_machine/examine(mob/user)
	. = ..()
	. += "This machine is linked with your [span_notice("QuestBank account")], able to purchase things using the cash stored in your \
		[span_notice("Questbook")]. No need to insert coins! If you do try to insert coins, they'll instead be deposited into your \
		[span_notice("QuestBank account")]."
	. += "Ammunition is divided into four categories: [span_notice("Compact")], [span_notice("Medium")], [span_notice("Long")], and \
		[span_notice("Shotgun")]. This part is important, as it defines which guns they'll fit in."
	. += "In each category, there are a list of ammo types that you can purchase. The calibers and such are \
		[span_notice("cosmetic and largely interchangeable")], and can be changed to any other flavor of ammo within its C.M.L.S. category \
		at any time by [span_notice("Alt or Ctrl-Shift clicking")] on the ammo box or bullet."
	. += "Ammo that is loaded into a gun will be automatically converted to the gun's prefered flavor of ammo."

/obj/structure/CMLS_ammo_vending_machine/attackby(obj/item/I, mob/living/user, params, damage_override)
	. = ..()
	if(istype(I, /obj/item/stack/f13Cash) || istype(I, /obj/item/card))
		RelayDeposit(user)

/obj/structure/CMLS_ammo_vending_machine/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	add_fingerprint(usr)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AmmoVendor2000", capitalize(src.name))
		ui.open()

/obj/structure/CMLS_ammo_vending_machine/ui_data(mob/user)
	. = ..()
	var/datum/quest_book/QB = SSeconomy.get_quest_book(user)
	if(!QB)
		.["QBcash"] = "ERROR!!!"
	else
		.["QBcash"] = CREDITS_TO_COINS(QB.unclaimed_points)
	.["Username"] = user.real_name
	.["UserCkey"] = user.ckey
	.["UserQUID"] = SSeconomy.extract_quid(user)
	/// and a handy helper to tell the player what CMLSes of their guns tha tthey have are
	var/list/fount = list()
	var/list/their_stuff = get_all_in_turf(user)
	for(var/obj/item/gun/ballistic/gunB in their_stuff)
		if(istype(gunB, /obj/item/gun/ballistic) && istype(gunB.magazine, /obj/item/ammo_box/generic))
			var/obj/item/ammo_box/generic/mag = gunB.magazine
			var/cmls = LAZYACCESS(mag.caliber, 1)
			switch(cmls)
				if(CALIBER_COMPACT)
					fount |= "Compact"
				if(CALIBER_MEDIUM)
					fount |= "Medium"
				if(CALIBER_LONG)
					fount |= "Long"
				if(CALIBER_SHOTGUN)
					fount |= "Shotgun"
	.["TheirCMLSes"] = english_list(fount)

/obj/structure/CMLS_ammo_vending_machine/ui_static_data(mob/user)
	. = ..()
	.["AllItems"] = SScmls.data_for_tgui
	.["CurrencyUnit"] = SSeconomy.currency_unit
	.["CurrencyName"] = SSeconomy.currency_name
	.["CurrencyPlural"] = SSeconomy.currency_name_plural

/obj/structure/CMLS_ammo_vending_machine/ui_act(action, params)
	. = ..()
	add_fingerprint(usr)
	. = TRUE
	var/mob/user = SSeconomy.quid2mob(params["UserQUID"])
	if(!user || !user.client)
		return
	if(action == "PurchaseAmmo")
		var/datum/ammo_kind/AK = SScmls.GetAmmoKind(text2path(params["DesiredAmmoKind"]))
		if(!istype(AK))
			to_chat(user, span_alert("That's not something for sale, I think?"))
			return
		PurchaseAmmo(user, AK, params["CrateOrBox"])
	if(action == "ClickedCashThing")
		RelayDispenseTicket(user)

/obj/structure/CMLS_ammo_vending_machine/proc/PurchaseAmmo(mob/user, datum/ammo_kind/AK, CorB = "Box")
	if(!user || !AK)
		return
	var/datum/quest_book/QB = SSeconomy.get_quest_book(user)
	if(!QB)
		to_chat(user, span_alert("You don't have a Questbook! Wierd, cus everyone should have one. Maybe you lost it? Maybe contact an admin?"))
		return
	CorB = SScmls.ExtractCORB(CorB)
	var/costus = 0
	if(CorB == CORB_BOX)
		costus = AK.box_raw_cost
	else if(CorB == CORB_CRATE)
		costus = AK.crate_raw_cost
	else
		costus = INFINITY
	if(!CanAfford(QB, costus))
		to_chat(user, span_alert("You can't afford that ammo!"))
		return
	QB.adjust_funds(COINS_TO_CREDITS(-costus), update_overall = TRUE)
	var/obj/item/ammo_box/generic/mag = new(get_turf(user))
	AK.AKSetupBox(mag, CorB)
	playsound(src, 'sound/machines/ammovendor_dispense.ogg', 80, TRUE)
	to_chat(user, span_green("You've purchased a [mag.name] for [SSeconomy.format_currency(costus)]!"))

/obj/structure/CMLS_ammo_vending_machine/proc/CanAfford(datum/quest_book/QB, costus)
	if(!QB || !isnum(costus))
		return FALSE
	return QB.unclaimed_points >= COINS_TO_CREDITS(costus)

/obj/structure/CMLS_ammo_vending_machine/proc/RelayDeposit(mob/user)
	var/datum/quest_book/QB = SSeconomy.get_quest_book(user)
	if(!QB)
		return
	QB.operate_cash_machine()

/obj/structure/CMLS_ammo_vending_machine/proc/RelayDispenseTicket(mob/user)
	var/datum/quest_book/QB = SSeconomy.get_quest_book(user)
	if(!QB)
		return
	QB.cash_out()


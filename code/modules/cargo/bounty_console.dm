#define PRINTER_TIMEOUT 10

/obj/machinery/computer/bounty
	name = "\improper Guild Quest Reward Console"
	desc = "Used to check and claim bounties offered by the Guild."
	icon_screen = "bounty"
	circuit = /obj/item/circuitboard/computer/bounty
	light_color = "#E2853D"//orange

// /obj/machinery/computer/bounty/ComponentInitialize()
// 	. = ..()
// 	AddComponent(/datum/component/quest_computer) // love when a huge file gets smaller

/obj/machinery/computer/bounty/ui_interact(mob/user, datum/tgui/ui)
	SSeconomy.open_quest_console(user, src)


// 	var/printer_ready = 0 //cooldown var
// 	var/static/datum/bank_account/cargocash

// /obj/machinery/computer/bounty/Initialize()
// 	. = ..()
// 	printer_ready = world.time + PRINTER_TIMEOUT
// 	cargocash = SSeconomy.get_dep_account(ACCOUNT_CAR)

// /obj/machinery/computer/bounty/proc/print_paper()
// 	new /obj/item/paper/bounty_printout(loc)

// /obj/item/paper/bounty_printout
// 	name = "paper - Bounties"

// /obj/item/paper/bounty_printout/Initialize()
// 	. = ..()
// 	info = "<h2>Guild Cargo Bounties</h2></br>"
// 	update_icon()

// 	for(var/datum/bounty/B in GLOB.bounties_list)
// 		if(B.claimed)
// 			continue
// 		info += {"<h3>[B.name]</h3>
// 		<ul><li>Reward: [B.reward_string()]</li>
// 		<li>Completed: [B.completion_string()]</li></ul>"}

// /obj/machinery/computer/bounty/ui_interact(mob/user, datum/tgui/ui)
// 	if(!GLOB.bounties_list.len)
// 		setup_bounties()
// 	ui = SStgui.try_update_ui(user, src, ui)
// 	if(!ui)
// 		ui = new(user, src, "CargoBountyConsole", name)
// 		ui.open()

// /obj/machinery/computer/bounty/ui_data(mob/user)
// 	var/list/data = list()
// 	var/list/bountyinfo = list()
// 	for(var/datum/bounty/B in GLOB.bounties_list)
// 		bountyinfo += list(B.get_tgui(user))
// 	data["stored_cash"] = cargocash.account_balance
// 	data["bountydata"] = bountyinfo
// 	return data

// /obj/machinery/computer/bounty/ui_act(action,params)
// 	if(..())
// 		return
// 	var/mob/user = usr
// 	switch(action)
// 		if("ClaimBounty")
// 			var/datum/bounty/cashmoney = locate(params["bounty"]) in GLOB.bounties_list
// 			if(cashmoney)
// 				cashmoney.claim(user, src)
// 			return TRUE
// 		if("Print")
// 			if(printer_ready < world.time)
// 				printer_ready = world.time + PRINTER_TIMEOUT
// 				print_paper()
// 				return

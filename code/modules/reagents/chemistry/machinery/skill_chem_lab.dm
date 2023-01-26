/obj/machinery/chem_lab
	name = "medical chemistry lab"
	desc = "Creates and dispenses chemicals. Uses skill checks to function."
	density = TRUE
	icon = 'icons/obj/chemical.dmi'
	icon_state = "dispenser"
	use_power = IDLE_POWER_USE
	idle_power_usage = 40
	interaction_flags_machine = INTERACT_MACHINE_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OFFLINE
	resistance_flags = FIRE_PROOF | ACID_PROOF
	circuit = /obj/item/circuitboard/machine/chem_lab

	var/obj/item/reagent_containers/beaker = null
	var/obj/item/stock_parts/chem_cartridge/cartridge
	var/powerefficiency = 0.0666666
	var/matefficiency = 0.0666666
	var/amount = 30
	var/recharge_amount = 10
	var/recharge_counter = 0
	var/mutable_appearance/beaker_overlay
	var/working_state = "dispenser_working"
	var/nopower_state = "dispenser_nopower"

	var/list/possible_steps = list ("Heat", "Cool", "Add", "Mix")
	var/list/dispensable_reagents = list()
	var/list/basic_chemicals = list(
		/datum/reagent/medicine/potass_iodide = 1,
		/datum/reagent/medicine/styptic_powder = 3,
		/datum/reagent/medicine/calomel = 3,
		/datum/reagent/medicine/perfluorodecalin = 4,
		/datum/reagent/medicine/bicaridine = 2,
		/datum/reagent/medicine/kelotane = 2,
		/datum/reagent/medicine/antitoxin = 2,
		/datum/reagent/medicine/salglu_solution = 2,
		/datum/reagent/radium = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/toxin/acid = 2,
		/datum/reagent/fuel = 3,
		/datum/reagent/stable_plasma = 1,
		/datum/reagent/medicine/charcoal = 3,
		/datum/reagent/consumable/ethanol = 2
	)
	//These become available once upgraded.
	var/list/advanced_chemicals = list(
		/datum/reagent/medicine/haloperidol = 4,
		/datum/reagent/medicine/corazone = 4,
		/datum/reagent/medicine/stimpak = 5,
		/datum/reagent/medicine/oxandrolone = 4,
		/datum/reagent/medicine/salbutamol = 4,
		/datum/reagent/medicine/sal_acid = 4,
		/datum/reagent/medicine/pen_acid = 4,
		/datum/reagent/medicine/morphine = 4,
		/datum/reagent/medicine/oculine = 4,
		/datum/reagent/medicine/mannitol = 4,
		/datum/reagent/medicine/neurine = 5,
		/datum/reagent/medicine/antihol = 4,
		/datum/reagent/medicine/spaceacillin = 4
	)

	var/list/expert_chemicals = list(
		/datum/reagent/medicine/medx = 6,
		/datum/reagent/medicine/ephedrine = 6,
		/datum/reagent/medicine/diphenhydramine = 6
	)

	var/list/upgraded_chemicals = list(
		/datum/reagent/medicine/clonexadone = 3,
		/datum/reagent/medicine/pyroxadone = 3,
		/datum/reagent/medicine/pen_acid/pen_jelly = 3,
		/datum/reagent/medicine/atropine = 3,
		/datum/reagent/medicine/mutadone = 3,
		/datum/reagent/medicine/haloperidol = 3,
		/datum/reagent/medicine/regen_jelly = 3,
		/datum/reagent/medicine/epinephrine = 3,
		/datum/reagent/medicine/spaceacillin = 2
	)

	var/list/upgraded_chemicals2 = list(
		/datum/reagent/medicine/strange_reagent = 4,
		/datum/reagent/drug/space_drugs = 3,
		/datum/reagent/toxin/plasma = 2,
		/datum/reagent/consumable/frostoil = 2,
		/datum/reagent/toxin/carpotoxin = 2,
		/datum/reagent/toxin/histamine = 2,
		/datum/reagent/toxin/slimejelly = 2,
		/datum/reagent/medicine/modafinil = 2,
		/datum/reagent/medicine/psicodine = 2,
		/datum/reagent/medicine/mentat = 3,
		/datum/reagent/medicine/stimpak = 3
	)

/obj/machinery/chem_lab/Initialize()
	. = ..()
	dispensable_reagents = sortList(basic_chemicals, /proc/cmp_reagents_asc)
	if(advanced_chemicals)
		advanced_chemicals = sortList(advanced_chemicals, /proc/cmp_reagents_asc)
	if(expert_chemicals)
		expert_chemicals = sortList(expert_chemicals, /proc/cmp_reagents_asc)
	if(upgraded_chemicals)
		upgraded_chemicals = sortList(upgraded_chemicals, /proc/cmp_reagents_asc)
	if(upgraded_chemicals2)
		upgraded_chemicals2 = sortList(upgraded_chemicals2, /proc/cmp_reagents_asc)
	dispensable_reagents = sortList(dispensable_reagents, /proc/cmp_reagents_asc)
	if (!istype(cartridge))
		cartridge = new/obj/item/stock_parts/chem_cartridge/empty(loc)
	update_icon()

/obj/machinery/chem_lab/Destroy()
	QDEL_NULL(beaker)
	//QDEL_NULL(cell)
	QDEL_NULL(cartridge)
	return ..()

/obj/machinery/chem_lab/examine(mob/user)
	. = ..()
	if(panel_open)
		. += span_notice("[src]'s maintenance hatch is open!")
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>The status display reads:\n\
		Recharging <b>[recharge_amount]</b> power units per interval.\n\
		Power efficiency increased by <b>[round((powerefficiency*1000)-100, 1)]%</b>.</span>"

/obj/machinery/chem_lab/process()
	if (recharge_counter >= 4)
		if(!is_operational())
			return
		//var/usedpower = cell.give(recharge_amount)
		//if(usedpower)
		//	use_power(250*recharge_amount)
		recharge_counter = 0
		return
	recharge_counter++

/obj/machinery/chem_lab/proc/display_beaker()
	var/mutable_appearance/b_o = beaker_overlay || mutable_appearance(icon, "disp_beaker")
	b_o.pixel_y = -4
	b_o.pixel_x = -7
	return b_o

/obj/machinery/chem_lab/proc/work_animation()
	if(working_state)
		flick(working_state,src)

/obj/machinery/chem_lab/low_power
	//cell_type = /obj/item/stock_parts/cell/upgraded

/obj/machinery/chem_lab/power_change()
	..()
	icon_state = "[(nopower_state && !powered()) ? nopower_state : initial(icon_state)]"

/obj/machinery/chem_lab/update_overlays()
	. = ..()
	if(panel_open)
		. += mutable_appearance(icon, "[initial(icon_state)]_panel-o")

	if(beaker)
		beaker_overlay = display_beaker()
		. += beaker_overlay

/obj/machinery/chem_lab/ex_act(severity, target)
	if(severity < 3)
		..()

/obj/machinery/chem_lab/contents_explosion(severity, target)
	..()
	if(beaker)
		beaker.ex_act(severity, target)

/obj/machinery/chem_lab/Exited(atom/movable/A, atom/newloc)
	. = ..()
	if(A == beaker)
		beaker = null
		update_icon()

/obj/machinery/chem_lab/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(istype(user, /mob/dead/observer))
		if(!ui)
			ui = new(user, src, "ChemDispenser", name)
			ui.open()
	else
		if(!user.IsAdvancedToolUser())
			to_chat(user, span_warning("The legion has no use for drugs! Better to destroy it."))
			return
		if(!ui)
			ui = new(user, src, "ChemDispenser", name)
			if(user.hallucinating())
				ui.set_autoupdate(FALSE) //to not ruin the immersion by constantly changing the fake chemicals
			ui.open()


/obj/machinery/chem_lab/ui_data(mob/user)
	var/data = list()
	data["amount"] = amount
	//data["energy"] = cell.charge ? cell.charge * powerefficiency : "0" //To prevent NaN in the UI.
	//data["maxEnergy"] = cell.maxcharge * powerefficiency
	data["cartridgeCharge"] = cartridge.charge ? cartridge.charge * matefficiency : "0"
	data["maxCartridgeCharge"] = cartridge.maxCharge * matefficiency
	data["isBeakerLoaded"] = beaker ? 1 : 0

	var/beakerContents[0]
	var/beakerCurrentVolume = 0
	if(beaker && beaker.reagents && beaker.reagents.reagent_list.len)
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			beakerContents.Add(list(list("name" = R.name, "volume" = R.volume))) // list in a list because Byond merges the first list...
			beakerCurrentVolume += R.volume
	data["beakerContents"] = beakerContents

	if (beaker)
		data["beakerCurrentVolume"] = beakerCurrentVolume
		data["beakerMaxVolume"] = beaker.volume
		data["beakerTransferAmounts"] = beaker.possible_transfer_amounts
		data["beakerCurrentpH"] = beaker.reagents.pH
		//pH accuracy
		for(var/obj/item/stock_parts/capacitor/C in component_parts)
			data["partRating"]= 10**(C.rating-1)

	else
		data["beakerCurrentVolume"] = null
		data["beakerMaxVolume"] = null
		data["beakerTransferAmounts"] = null
		data["beakerCurrentpH"] = null

	var/chemicals[0]
	var/is_hallucinating = FALSE
	if(user.hallucinating())
		is_hallucinating = TRUE
	var/trait_buff = HAS_TRAIT(user, TRAIT_CHEMWHIZ) ? -50 : 0
	for(var/re in dispensable_reagents)
		var/datum/reagent/temp = GLOB.chemical_reagents_list[re]
		if(temp && user.skill_check(SKILL_SCIENCE, (EASY_CHECK + trait_buff)))
			var/chemname = temp.name
			if(is_hallucinating && prob(5))
				chemname = "[pick_list_replacements("hallucination.json", "chemicals")]"
			chemicals.Add(list(list("title" = chemname, "id" = ckey(temp.name))))
	//skill checks
	if (user.skill_check(SKILL_SCIENCE, (REGULAR_CHECK + trait_buff)))
		for(var/re in advanced_chemicals)
			var/datum/reagent/temp = GLOB.chemical_reagents_list[re]
			if(temp && user.skill_check(SKILL_SCIENCE, (REGULAR_CHECK + trait_buff)))
				var/chemname = temp.name
				if(is_hallucinating && prob(5))
					chemname = "[pick_list_replacements("hallucination.json", "chemicals")]"
				chemicals.Add(list(list("title" = chemname, "id" = ckey(temp.name))))
	if (user.skill_check(SKILL_SCIENCE, (HARD_CHECK + trait_buff)))
		for(var/re in expert_chemicals)
			var/datum/reagent/temp = GLOB.chemical_reagents_list[re]
			if(temp && user.skill_check(SKILL_SCIENCE, (HARD_CHECK + trait_buff)))
				var/chemname = temp.name
				if(is_hallucinating && prob(5))
					chemname = "[pick_list_replacements("hallucination.json", "chemicals")]"
				chemicals.Add(list(list("title" = chemname, "id" = ckey(temp.name))))
	data["chemicals"] = chemicals
	data["recipes"] = list()

	data["recordingRecipe"] = FALSE
	return data

/obj/machinery/chem_lab/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("amount")
			if(!is_operational() || QDELETED(beaker))
				return
			var/target = text2num(params["target"])
			if(target in beaker.possible_transfer_amounts)
				amount = target
				work_animation()
				. = TRUE
		if("dispense")
			if(!is_operational()) // || QDELETED(cell)
				return
			var/reagent_name = params["reagent"]
			var/reagent = GLOB.name2reagent[reagent_name]
			if(beaker && dispensable_reagents.Find(reagent))
				do_chemical_creation(reagent, usr, amount, dispensable_reagents[reagent])
			if(beaker && advanced_chemicals.Find(reagent))
				do_chemical_creation(reagent, usr, amount, advanced_chemicals[reagent], HARD_CHECK, DIFFICULTY_CHALLENGE)
			if(beaker && expert_chemicals.Find(reagent))
				do_chemical_creation(reagent, usr, amount, expert_chemicals[reagent], EXPERT_CHECK, DIFFICULTY_EXPERT)
		if("remove")
			if(!is_operational())
				return
			var/amount = text2num(params["amount"])
			if(beaker && (amount in beaker.possible_transfer_amounts))
				beaker.reagents.remove_all(amount)
				work_animation()
				. = TRUE
		if("eject")
			replace_beaker(usr)
			. = TRUE


/obj/machinery/chem_lab/proc/do_chemical_creation(datum/reagent/r, mob/user, amount = 10,steps_left = 0, difficulty = REGULAR_CHECK, roll_difficulty = DIFFICULTY_NORMAL)
	var/biglist = basic_chemicals + advanced_chemicals + expert_chemicals + upgraded_chemicals + upgraded_chemicals2
	if (!steps_left)
		steps_left = biglist[r]
	var/trait_buff = HAS_TRAIT(user, TRAIT_CHEMWHIZ) ? -50 : 0
	var/next_step = pick(possible_steps)
	if (user.skill_check(SKILL_SCIENCE, difficulty + trait_buff) || user.skill_roll(SKILL_SCIENCE, roll_difficulty + trait_buff))
		to_chat(user, span_good("You know the next step is to " + next_step + "."))
	else
		to_chat(user, span_bad("What was the next step again....?"))
	var/choosen_step = input(user, "What is the next step you wish to take?", "Chemistry") in possible_steps
	work_animation()
	if (choosen_step == next_step)
		if (steps_left == 1)
			to_chat(user, span_good("The mixture pleasingly comes together."))
			var/datum/reagents/R = beaker.reagents
			var/free = R.maximum_volume - R.total_volume
			var/actual = min(amount, (cartridge.charge * powerefficiency)*10, free)
			if(!cartridge.takeMaterial(actual / matefficiency))
				say("Not enough chemicals in storage to complete operation!")
				return
			R.add_reagent(r, amount)
			log_reagent("DISPENSER: ([COORD(src)]) ([REF(src)]) [key_name(user)] dispensed [actual] of [r] to [beaker] ([REF(beaker)]).")
			return FALSE
		else
			to_chat(user, span_good("The mixture is looking good so far."))
			do_chemical_creation(r, user, amount, (steps_left - 1), difficulty, roll_difficulty)
	else
		to_chat(user, span_bad("Uuuh, that wasn't right."))
		// We might still save it!
		if (user.skill_roll(SKILL_SCIENCE, roll_difficulty + trait_buff))
			to_chat(user, span_notice("You manage to save the mixture, giving you another chance."))
			do_chemical_creation(r, user, amount, steps_left, difficulty, roll_difficulty)
			return
		//otherwise bad things happen!
		do_chemical_bad_thing(user)

/obj/machinery/chem_lab/proc/do_chemical_bad_thing(mob/user)
	if(prob(10))
		small_bang(user)
		return
	if(prob(20))
		bad_smoke(user)
		return
	if(prob(30))
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(5, 1, src)
		s.start()
		electrocute_mob(user, get_area(src), src, 0.7, TRUE)
		return
	var/datum/reagents/R = beaker.reagents
	var/free = R.maximum_volume - R.total_volume
	R.add_reagent(/datum/reagent/liquidgibs/oil, free)
	to_chat(user, span_warning("The mixture turns to sludge."))

/obj/machinery/chem_lab/proc/bad_smoke(user)
	visible_message(span_danger("[src]'s seals aren't right, gas is escaping!"))
	var/chosenchem
	chosenchem = pick(/datum/reagent/toxin/acid,/datum/reagent/consumable/condensedcapsaicin,/datum/reagent/drug/space_drugs)
	var/datum/reagents/R = new/datum/reagents(50)
	R.my_atom = src
	R.add_reagent(chosenchem , 50)
	var/datum/effect_system/smoke_spread/chem/smoke = new
	smoke.set_up(R, 0, src, silent = TRUE)
	playsound(src, 'sound/effects/smoke.ogg', 50, 1, -3)
	smoke.start()
	qdel(R)

/obj/machinery/chem_lab/proc/small_bang(mob/user)
	visible_message(span_danger("[user] gets the mixture wrong, releasing a large flame!"))
	explosion(loc, -1, 0, 0, 0, 0, flame_range = 3, flash_range = 2)

/obj/machinery/chem_lab/attackby(obj/item/I, mob/user, params)
	if(default_unfasten_wrench(user, I))
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_icon()
		return
	if(default_deconstruction_crowbar(I))
		return
	if(istype(I, /obj/item/reagent_containers) && !(I.item_flags & ABSTRACT) && I.is_open_container())
		var/obj/item/reagent_containers/B = I
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(B, src))
			return
		replace_beaker(user, B)
		to_chat(user, span_notice("You add [B] to [src]."))
		updateUsrDialog()
	else if(istype(I, /obj/item/stock_parts/chem_cartridge))
		var/obj/item/stock_parts/chem_cartridge/C = I
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(C, src))
			return
		replace_cartridge(user, C)
		to_chat(user, span_notice("You replace [C] in [src]"))
	else if(user.a_intent != INTENT_HARM && !istype(I, /obj/item/card/emag))
		to_chat(user, span_warning("You can't load [I] into [src]!"))
		return ..()
	else
		return ..()


/obj/machinery/chem_lab/RefreshParts()
	recharge_amount = initial(recharge_amount)
	var/newpowereff = initial(powerefficiency)
	var/newmateff = initial(matefficiency)
	/*
	for(var/obj/item/stock_parts/cell/P in component_parts)
		cell = P
	*/
	for(var/obj/item/stock_parts/chem_cartridge/C in component_parts)
		cartridge = C
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		newpowereff += 0.0166666666*M.rating
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		recharge_amount *= C.rating
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		newmateff += 0.0166666666*M.rating
		if(M.rating > 1)
			dispensable_reagents |= upgraded_chemicals
		if(M.rating > 2)
			dispensable_reagents |= upgraded_chemicals2
	powerefficiency = round(newpowereff, 0.01)
	matefficiency = round(newmateff, 0.01)

/obj/machinery/chem_lab/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	if(beaker)
		var/obj/item/reagent_containers/B = beaker
		B.forceMove(drop_location())
		if(user && Adjacent(user) && user.can_hold_items())
			user.put_in_hands(B)
	if(new_beaker)
		beaker = new_beaker
	else
		beaker = null
	update_icon()
	return TRUE

/obj/machinery/chem_lab/on_deconstruction()
	//cell = null
	if(cartridge)
		cartridge.forceMove(drop_location())
		cartridge = null
	if(beaker)
		beaker.forceMove(drop_location())
		beaker = null
	return ..()

/obj/machinery/chem_lab/proc/replace_cartridge(mob/living/user, obj/item/stock_parts/chem_cartridge/new_cartridge)
	if(cartridge)
		var/obj/item/stock_parts/chem_cartridge/C = cartridge
		C.forceMove(drop_location())
		if(user && Adjacent(user) && user.can_hold_items())
			user.put_in_hands(C)
	if(new_cartridge)
		cartridge = new_cartridge
	else
		cartridge = null
	update_icon()
	return TRUE

/obj/machinery/chem_lab/AltClick(mob/living/user)
	. = ..()
	if(istype(user) && user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		replace_beaker(user)
		return TRUE

//backpack item
#define HALFWAYCRITDEATH ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)

/obj/item/defibrillator
	name = "defibrillator"
	desc = "A device that delivers powerful shocks to detachable paddles that resuscitate incapacitated patients."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibunit"
	inhand_icon_state = "defibunit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	slot_flags = INV_SLOTBIT_BACK
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	actions_types = list(/datum/action/item_action/toggle_paddles)
	armor = ARMOR_VALUE_LIGHT

	var/on = FALSE //if the paddles are equipped (1) or on the defib (0)
	var/safety = TRUE //if you can zap people with the defibs on harm mode
	var/powered = FALSE //if there's a cell in the defib with enough power for a revive, blocks paddles from reviving otherwise
	var/obj/item/shockpaddles/paddles
	var/obj/item/stock_parts/cell/cell
	var/combat = FALSE //can we revive through space suits?
	var/grab_ghost = FALSE // Do we pull the ghost back into their body?
	var/healdisk = FALSE // Will we shock people dragging the body?
	var/pullshocksafely = FALSE //Dose the unit have the healdisk upgrade?
	var/primetime = 0 // is the defib faster
	var/timedeath = 10
	var/disarm_shock_time = 10
	var/always_emagged = FALSE

/obj/item/defibrillator/get_cell()
	return cell

/obj/item/defibrillator/Initialize() //starts without a cell for rnd
	. = ..()
	if(cell)
		cell = new cell(src)
	paddles = make_paddles()
	update_power()
	return

/obj/item/defibrillator/loaded
	cell = /obj/item/stock_parts/cell/high

/obj/item/defibrillator/proc/update_power()
	if(!QDELETED(cell))
		if(QDELETED(paddles) || cell.charge < paddles.revivecost)
			powered = FALSE
		else
			powered = TRUE
	else
		powered = FALSE
	update_icon()

/obj/item/defibrillator/update_overlays()
	. = ..()
	if(!on)
		. += "[initial(icon_state)]-paddles"
	if(powered)
		. += "[initial(icon_state)]-powered"
		if(!QDELETED(cell))
			var/ratio = cell.charge / cell.maxcharge
			ratio = CEILING(ratio*4, 1) * 25
			add_overlay("[initial(icon_state)]-charge[ratio]")
	if(!cell)
		. += "[initial(icon_state)]-nocell"
	if(!safety)
		. += "[initial(icon_state)]-emagged"

/obj/item/defibrillator/CheckParts(list/parts_list)
	..()
	cell = locate(/obj/item/stock_parts/cell) in contents
	update_power()

/obj/item/defibrillator/ui_action_click()
	toggle_paddles()

/obj/item/defibrillator/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc == user)
		if(slot_flags == INV_SLOTBIT_BACK)
			if(user.get_item_by_slot(SLOT_BACK) == src)
				ui_action_click()
			else
				to_chat(user, span_warning("Put the defibrillator on your back first!"))

		else if(slot_flags == INV_SLOTBIT_BELT)
			if(user.get_item_by_slot(SLOT_BELT) == src)
				ui_action_click()
			else
				to_chat(user, span_warning("Strap the defibrillator's belt on first!"))
		return
	else if(istype(loc, /obj/machinery/defibrillator_mount))
		ui_action_click() //checks for this are handled in defibrillator.mount.dm
	return ..()

/obj/item/defibrillator/MouseDrop(obj/over_object)
	. = ..()
	if(!. && ismob(loc) && loc == usr)
		var/mob/M = loc
		if(!M.incapacitated(allow_crit = TRUE) && istype(over_object, /atom/movable/screen/inventory/hand))
			var/atom/movable/screen/inventory/hand/H = over_object
			M.putItemFromInventoryInHandIfPossible(src, H.held_index)

/obj/item/defibrillator/attackby(obj/item/W, mob/user, params)
	if(W == paddles)
		toggle_paddles()
	else if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, span_notice("[src] already has a cell."))
		else
			if(C.maxcharge < paddles.revivecost)
				to_chat(user, span_notice("[src] requires a higher capacity cell."))
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, span_notice("You install a cell in [src]."))
			update_power()

	else if(istype(W, /obj/item/screwdriver))
		if(cell)
			cell.update_icon()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, span_notice("You remove the cell from [src]."))
			update_power()
	else
		return ..()

/obj/item/defibrillator/emag_act(mob/user)
	. = ..()
	always_emagged = TRUE
	safety = !safety
	to_chat(user, span_warning("You silently [safety ? "enable" : "disable"] [src]'s safety protocols with the cryptographic sequencer."))
	return TRUE

/obj/item/defibrillator/emp_act(severity)
	. = ..()
	if(cell && !(. & EMP_PROTECT_CONTENTS))
		deductcharge(severity*10)
	if (. & EMP_PROTECT_SELF)
		return
	if(safety)
		safety = FALSE
		visible_message(span_notice("[src] beeps: Safety protocols disabled!"))
		playsound(src, 'sound/machines/defib_saftyOff.ogg', 50, 0)
	else if(!always_emagged)
		safety = TRUE
		visible_message(span_notice("[src] beeps: Safety protocols enabled!"))
		playsound(src, 'sound/machines/defib_saftyOn.ogg', 50, 0)
	update_power()

/obj/item/defibrillator/proc/toggle_paddles()
	set name = "Toggle Paddles"
	set category = "Object"
	on = !on

	var/mob/living/carbon/user = usr
	if(on)
		//Detach the paddles into the user's hands
		if(!usr.put_in_hands(paddles))
			on = FALSE
			to_chat(user, span_warning("You need a free hand to hold the paddles!"))
			update_power()
			return
	else
		//Remove from their hands and back onto the defib unit
		remove_paddles(user)

	update_power()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/defibrillator/proc/make_paddles()
	return new /obj/item/shockpaddles(src)

/obj/item/defibrillator/equipped(mob/user, slot)
	..()
	if((slot_flags == INV_SLOTBIT_BACK && slot != SLOT_BACK) || (slot_flags == INV_SLOTBIT_BELT && slot != SLOT_BELT))
		remove_paddles(user)
		update_power()

/obj/item/defibrillator/item_action_slot_check(slot, mob/user, datum/action/A)
	if(slot == user.getBackSlot())
		return 1

/obj/item/defibrillator/proc/remove_paddles(mob/user) //this fox the bug with the paddles when other player stole you the defib when you have the paddles equiped
	if(ismob(paddles.loc))
		var/mob/M = paddles.loc
		M.dropItemToGround(paddles, TRUE)
	return

/obj/item/defibrillator/Destroy()
	if(on)
		var/M = get(paddles, /mob)
		remove_paddles(M)
	QDEL_NULL(paddles)
	QDEL_NULL(cell)
	return ..()

/obj/item/defibrillator/proc/deductcharge(chrgdeductamt)
	if(cell)
		if(cell.charge < (paddles.revivecost+chrgdeductamt))
			powered = FALSE
			update_power()
		if(cell.use(chrgdeductamt))
			update_power()
			return TRUE
		else
			update_power()
			return FALSE

/obj/item/defibrillator/proc/cooldowncheck(mob/user)
	spawn(50)
		if(cell)
			if(cell.charge >= paddles.revivecost)
				user.visible_message(span_notice("[src] beeps: Unit ready."))
				playsound(src, 'sound/machines/defib_ready.ogg', 50, 0)
			else
				user.visible_message(span_notice("[src] beeps: Charge depleted."))
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		paddles.cooldown = FALSE
		paddles.update_icon()
		update_power()

//Primitive defib stuff, could be improved by making it require no cell, fixing text messages, making them less fancy in function etc but I can't figure out how without stuffing duplicates all over. This is about as good I can make them for now.
//Made to replace smelling salts due to bugs temporarily, but it fits Legion and Wasteland docs well.
/obj/item/defibrillator/primitive
	name = "primitive defibrillator"
	desc = "The Delco, the name of a box that can deliver shocks to the seriously wounded to revive them."
	icon = 'icons/fallout/objects/medicine/primitivedefib.dmi'
	icon_state = "defibprimitive"
	lefthand_file = 'icons/fallout/onmob/tools/medical_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/medical_righthand.dmi'
	inhand_icon_state = "defibunit"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT
	cell = /obj/item/stock_parts/cell/high

/obj/item/defibrillator/primitive/Initialize()
	. = ..()
	paddles = make_paddlesprim()
	update_power()
	return

/obj/item/defibrillator/primitive/proc/make_paddlesprim()
	return new /obj/item/shockpaddles/primitive(src)


//other defib versions
/obj/item/defibrillator/compact
	name = "compact defibrillator"
	desc = "A belt-equipped defibrillator that can be rapidly deployed."
	icon_state = "defibcompact"
	inhand_icon_state = "defibcompact"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT

/obj/item/defibrillator/compact/item_action_slot_check(slot, mob/user, datum/action/A)
	if(slot == user.getBeltSlot())
		return TRUE

/obj/item/defibrillator/compact/loaded
	cell = /obj/item/stock_parts/cell/high

/obj/item/defibrillator/compact/combat
	name = "combat defibrillator"
	desc = "A belt-equipped blood-red defibrillator that can be rapidly deployed. Does not have the restrictions or safeties of conventional defibrillators and can revive through space suits."
	combat = TRUE
	safety = FALSE
	always_emagged = TRUE
	disarm_shock_time = 0
	cell = /obj/item/stock_parts/cell/infinite

/obj/item/defibrillator/compact/combat/loaded/attackby(obj/item/W, mob/user, params)
	if(W == paddles)
		toggle_paddles()
		return

//paddles

/obj/item/shockpaddles
	name = "defibrillator paddles"
	desc = "A pair of plastic-gripped paddles with flat metal surfaces that are used to deliver powerful electric shocks."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

	force = 0
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY

	var/revivecost = 1000
	var/cooldown = FALSE
	var/busy = FALSE
	var/obj/item/defibrillator/defib
	var/req_defib = TRUE
	var/combat = FALSE //If it penetrates armor and gives additional functionality
	var/grab_ghost = FALSE
	var/tlimit = DEFIB_TIME_LIMIT * 10
	var/disarm_shock_time = 10

/obj/item/shockpaddles/Initialize()
	. = ..()
	if(!req_defib)
		return //If it doesn't need a defib, just say it exists
	if (!loc || !istype(loc, /obj/item/defibrillator)) //To avoid weird issues from admin spawns
		return INITIALIZE_HINT_QDEL
	defib = loc
	busy = FALSE
	update_icon()

/obj/item/shockpaddles/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/shockpaddles/Destroy()
	defib = null
	return ..()

/obj/item/shockpaddles/equipped(mob/user, slot)
	. = ..()
	if(!req_defib)
		return
	RegisterSignal(user, COMSIG_MOVABLE_MOVED,PROC_REF(check_range))

/obj/item/shockpaddles/Moved()
	. = ..()
	check_range()

/obj/item/shockpaddles/proc/check_range()
	if(!req_defib || !defib)
		return
	if(!in_range(src,defib))
		var/mob/living/L = loc
		if(istype(L))
			to_chat(L, span_warning("[defib]'s paddles overextend and come out of your hands!"))
		else
			visible_message(span_notice("[src] snap back into [defib]."))
		snap_back()

/obj/item/shockpaddles/proc/recharge(time)
	if(req_defib || !time)
		return
	cooldown = TRUE
	update_icon()
	sleep(time)
	var/turf/T = get_turf(src)
	T.audible_message(span_notice("[src] beeps: Unit is recharged."))
	playsound(src, 'sound/machines/defib_ready.ogg', 50, 0)
	cooldown = FALSE
	update_icon()

/obj/item/shockpaddles/update_icon_state()
	icon_state = "defibpaddles[wielded]"
	inhand_icon_state = "defibpaddles[wielded]"
	if(cooldown)
		icon_state = "defibpaddles[wielded]_cooldown"

/obj/item/shockpaddles/dropped(mob/user)
	if(!req_defib)
		return ..()
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		if(user != loc)
			to_chat(user, span_notice("The paddles snap back into the main unit."))
			snap_back()

/obj/item/shockpaddles/proc/snap_back()
	if(!defib)
		return
	defib.on = FALSE
	forceMove(defib)
	defib.update_power()

/obj/item/shockpaddles/attack(mob/M, mob/user)

	if(busy)
		return
	if(req_defib && !defib.powered)
		user.visible_message(span_notice("[defib] beeps: Unit is unpowered."))
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		return
	if(!wielded)
		if(iscyborg(user))
			to_chat(user, span_warning("You must activate the paddles in your active module before you can use them on someone!"))
		else
			to_chat(user, span_warning("You need to wield the paddles in both hands before you can use them on someone!"))
		return
	if(cooldown)
		if(req_defib)
			to_chat(user, span_warning("[defib] is recharging!"))
		else
			to_chat(user, span_warning("[src] are recharging!"))
		return

	if(user.a_intent == INTENT_DISARM)
		do_disarm(M, user)
		return

	if(!iscarbon(M))
		if(req_defib)
			to_chat(user, span_warning("The instructions on [defib] don't mention how to revive that..."))
		else
			to_chat(user, span_warning("You aren't sure how to revive that..."))
		return
	var/mob/living/carbon/H = M


	if(user.zone_selected != BODY_ZONE_CHEST)
		to_chat(user, span_warning("You need to target your patient's chest with [src]!"))
		return

	if(user.a_intent == INTENT_HARM)
		do_harm(H, user)
		return

	if((!req_defib && grab_ghost) || (req_defib && defib.grab_ghost))
		H.notify_ghost_cloning("Your heart is being defibrillated!")
		H.grab_ghost() // Shove them back in their body.
	else if(H.can_revive())
		H.notify_ghost_cloning("Your heart is being defibrillated. Re-enter your corpse if you want to be revived!", source = src)

	do_help(H, user)

/obj/item/shockpaddles/proc/shock_touching(dmg, mob/H)
	if(!H.pulledby || !isliving(H.pulledby))
		return
	if(req_defib && defib.pullshocksafely)
		H.visible_message(span_danger("The defibrillator safely discharges the excessive charge into the floor!"))
		return
	var/mob/living/M = H.pulledby
	if(M.electrocute_act(30, H))
		M.visible_message(span_danger("[M] is electrocuted by [M.p_their()] contact with [H]!"))
		M.emote("scream")

/obj/item/shockpaddles/proc/do_disarm(mob/living/M, mob/living/user)
	if(req_defib && defib.safety)
		return
	if(!req_defib && !combat)
		return
	M.visible_message(span_danger("[user] hastily places [src] on [M]'s chest!"), \
			span_userdanger("[user] hastily places [src] on [M]'s chest!"))
	busy = TRUE
	if(do_after(user, isnull(defib?.disarm_shock_time)? disarm_shock_time : defib.disarm_shock_time, target = M))
		M.visible_message(span_danger("[user] zaps [M] with [src]!"), \
				span_userdanger("[user] zaps [M] with [src]!"))
		M.DefaultCombatKnockdown(45)
		M.updatehealth() //forces health update before next life tick
		playsound(src,  'sound/machines/defib_zap.ogg', 50, 1, -1)
		M.emote("gasp")
		log_combat(user, M, "stunned", src)
		busy = FALSE
		if(req_defib)
			defib.deductcharge(revivecost)
			cooldown = TRUE
	busy = FALSE
	update_icon()
	if(req_defib)
		defib.cooldowncheck(user)
	else
		recharge(60)

/obj/item/shockpaddles/proc/do_harm(mob/living/carbon/H, mob/living/user)
	if(req_defib && defib.safety)
		return
	if(!req_defib && !combat)
		return
	user.visible_message(span_warning("[user] begins to place [src] on [H]'s chest."),
		span_warning("You overcharge the paddles and begin to place them onto [H]'s chest..."))
	busy = TRUE
	update_icon()
	if(do_after(user, 30, target = H))
		user.visible_message(span_notice("[user] places [src] on [H]'s chest."),
			span_warning("You place [src] on [H]'s chest and begin to charge them."))
		var/turf/T = get_turf(defib)
		playsound(src, 'sound/machines/defib_charge.ogg', 50, 0)
		if(req_defib)
			T.audible_message(span_warning("\The [defib] lets out an urgent beep and lets out a steadily rising hum..."))
		else
			user.audible_message(span_warning("[src] let out an urgent beep."))
		if(do_after(user, 30, target = H)) //Takes longer due to overcharging
			if(!H)
				busy = FALSE
				update_icon()
				return
			if(H && H.stat == DEAD)
				to_chat(user, span_warning("[H] is dead."))
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				busy = FALSE
				update_icon()
				return
			user.visible_message(span_boldannounce("<i>[user] shocks [H] with \the [src]!"), span_warning("You shock [H] with \the [src]!"))
			playsound(src, 'sound/machines/defib_zap.ogg', 100, 1, -1)
			playsound(src, 'sound/weapons/egloves.ogg', 100, 1, -1)
			H.emote("scream")
			shock_touching(45, H)
			if(H.can_heartattack() && !H.undergoing_cardiac_arrest())
				if(!H.stat)
					H.visible_message(span_warning("[H] thrashes wildly, clutching at [H.p_their()] chest!"),
						span_userdanger("You feel a horrible agony in your chest!"))
				H.set_heartattack(TRUE)
			H.apply_damage(50, BURN, BODY_ZONE_CHEST)
			log_combat(user, H, "overloaded the heart of", defib)
			H.DefaultCombatKnockdown(45)
			H.Jitter(100)
			if(req_defib)
				defib.deductcharge(revivecost)
				cooldown = TRUE
			busy = FALSE
			update_icon()
			if(!req_defib)
				recharge(60)
			if(req_defib && (defib.cooldowncheck(user)))
				return
	busy = FALSE
	update_icon()

/obj/item/shockpaddles/proc/do_help(mob/living/carbon/H, mob/living/user)
	user.visible_message(span_warning("[user] begins to place [src] on [H]'s chest."), span_warning("You begin to place [src] on [H]'s chest..."))
	busy = TRUE
	update_icon()

	var/primetimer
	var/primetimer2
	//var/deathtimer
	if(req_defib)
		primetimer = 30 - defib.primetime //I swear to god if I find shit like this elsewhere
		primetimer2 = 20 - defib.primetime
		//deathtimer = DEFIB_TIME_LOSS * defib.timedeath
	else
		primetimer = 30
		primetimer2 = 20
		//deathtimer = DEFIB_TIME_LOSS * 10

	if(do_after(user, primetimer, target = H)) //beginning to place the paddles on patient's chest to allow some time for people to move away to stop the process
		user.visible_message(span_notice("[user] places [src] on [H]'s chest."), span_warning("You place [src] on [H]'s chest."))
		playsound(src, 'sound/machines/defib_charge.ogg', 75, 0)
		// patients rot when they are killed, and die when they are dead // no they dont lol
		var/tplus = world.time - H.timeofdeath	//length of time spent dead
		//var/tloss = deathtimer
		var/total_burn	= 0
		var/total_brute	= 0
		var/obj/item/organ/heart = H.getorgan(/obj/item/organ/heart)
		if(do_after(user, primetimer2, target = H)) //placed on chest and short delay to shock for dramatic effect, revive time is 5sec total
			for(var/obj/item/carried_item in H.contents)
				if(istype(carried_item, /obj/item/clothing/suit/space))
					if((!combat && !req_defib) || (req_defib && !defib.combat))
						user.audible_message(span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Patient's chest is obscured. Operation aborted."))
						playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
						busy = FALSE
						update_icon()
						return
			if(H.stat == DEAD)
				H.visible_message(span_warning("[H]'s body convulses a bit."))
				playsound(src, "bodyfall", 50, 1)
				playsound(src, 'sound/machines/defib_zap.ogg', 75, 1, -1)
				total_brute	= H.getBruteLoss()
				total_burn	= H.getFireLoss()
				shock_touching(30, H)
				var/failed

				if ((HAS_TRAIT(H, TRAIT_NOCLONE)))
					failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Ephemereal conscience detected, seance protocols reveal this patient's DNR is set. Patient cannot be revived without specialized assistance.")
				else if (H.hellbound)
					failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Ephemereal conscience detected, seance protocols reveal this patient's soul has been cast into Hell. Patient cannot be revived without specialized assistance.")
				//else if (tplus > tlimit)
				//	failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Body has decayed for too long. Further attempts futile.")
				else if (!heart)
					failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's heart is missing. Replace the patient's heart and try again.")
				else if (heart.organ_flags & ORGAN_FAILING)
					failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's heart too damaged. Replace or repair the patient's heart and try again.")
				else if(total_burn >= 180 || total_brute >= 180)
					failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient is too injured for revival. Treat the patient's injuries and try again.")
				else if(H.get_ghost())
					failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Ephemereal conscience not found, patient's mind is missing or otherwise unable to be retrieved. Try again later.")
				else
					var/obj/item/organ/brain/BR = H.getorgan(/obj/item/organ/brain)
					if(BR) //BUG_PROBABLE_CAUSE - slight difference between us and tg
						if(BR.organ_flags & ORGAN_FAILING)
							failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's brain is too damaged. Repair the patient's brain.")
						if(BR.brain_death)
							failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's brain is destroyed. Patient cannot be revived without specialized assistance.")
					else
						failed = span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's brain is missing. Replace the patient's brain.")


				if(failed)
					user.visible_message(failed)
					playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				else
					//If the body has been fixed so that they would not be in crit when defibbed, give them oxyloss to put them back into crit
					if (H.health > HALFWAYCRITDEATH)
						H.adjustOxyLoss(H.health - HALFWAYCRITDEATH, 0)
					else
						var/overall_damage = total_brute + total_burn + H.getToxLoss() + H.getOxyLoss()
						var/mobhealth = H.health
						if(H.getOxyLoss())
							H.adjustOxyLoss((mobhealth - HALFWAYCRITDEATH) * (H.getOxyLoss() / overall_damage), 0)
						if(H.getToxLoss())
							H.adjustToxLoss((mobhealth - HALFWAYCRITDEATH) * (H.getToxLoss() / overall_damage), 0)
						if(H.getFireLoss())
							H.adjustFireLoss((mobhealth - HALFWAYCRITDEATH) * (total_burn / overall_damage), 0)
						if(H.getBruteLoss())
							H.adjustBruteLoss((mobhealth - HALFWAYCRITDEATH) * (total_brute / overall_damage), 0)
					H.updatehealth() // Previous "adjust" procs don't update health, so we do it manually.
					user.visible_message(span_notice("[req_defib ? "[defib]" : "[src]"] pings: Resuscitation successful."))
					playsound(src, 'sound/machines/defib_success.ogg', 50, 0)
					H.set_heartattack(FALSE)
					H.revive()
					H.emote("gasp")
					H.Jitter(100)
					SEND_SIGNAL(H, COMSIG_LIVING_MINOR_SHOCK)
					//if(tplus > tloss)
					//	H.adjustOrganLoss(ORGAN_SLOT_BRAIN,  max(0, min(99, ((tlimit - tplus) / tlimit * 100))), 150)
					log_combat(user, H, "revived", defib)
					if(req_defib)
						if(defib.healdisk)
							H.heal_overall_damage(25, 25)
					var/list/policies = CONFIG_GET(keyed_list/policyconfig)
					var/timelimit = CONFIG_GET(number/defib_cmd_time_limit)
					var/late = timelimit && (tplus > timelimit)
					var/policy = late? policies[POLICYCONFIG_ON_DEFIB_LATE] : policies[POLICYCONFIG_ON_DEFIB_INTACT]
					if(policy)
						to_chat(H, policy)
					H.log_message("revived using a defibrillator, [tplus] deciseconds from time of death, considered [late? "late" : "memory-intact"] revival under configured policy limits.", LOG_GAME)
				if(req_defib)
					defib.deductcharge(revivecost)
					cooldown = 1
				update_icon()
				if(req_defib)
					defib.cooldowncheck(user)
				else
					recharge(60)
			else if (!H.getorgan(/obj/item/organ/heart))
				user.visible_message(span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Patient's heart is missing. Operation aborted."))
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
			else if(H.undergoing_cardiac_arrest())
				H.set_heartattack(FALSE)
				if(!(heart.organ_flags & ORGAN_FAILING))
					H.set_heartattack(FALSE)
					user.visible_message(span_notice("[req_defib ? "[defib]" : "[src]"] pings: Patient's heart is now beating again."))
				else
					user.visible_message(span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed, heart damage detected."))
				playsound(src, 'sound/machines/defib_zap.ogg', 50, 1, -1)


			else
				user.visible_message(span_warning("[req_defib ? "[defib]" : "[src]"] buzzes: Patient is not in a valid state. Operation aborted."))
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
	busy = FALSE
	update_icon()

/obj/item/defibrillator/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/disk/medical/defib_heal))
		if(healdisk)
			to_chat(user, span_notice("This unit is already upgraded with this disk!"))
			return TRUE
		to_chat(user, span_notice("You upgrade the unit with Heal upgrade disk!"))
		healdisk = TRUE
		return TRUE
	if(istype(I, /obj/item/disk/medical/defib_shock))
		if(pullshocksafely)
			to_chat(user, span_notice("This unit is already upgraded with this disk!"))
			return TRUE
		to_chat(user, span_notice("You upgrade the unit with Shock Safety upgrade disk!"))
		pullshocksafely = TRUE
		return TRUE
	if(istype(I, /obj/item/disk/medical/defib_speed))
		if(!primetime == initial(primetime))
			to_chat(user, span_notice("This unit is already upgraded with this disk!"))
			return TRUE
		to_chat(user, span_notice("You upgrade the unit with Speed upgrade disk!"))
		primetime = 10
		return TRUE
	if(istype(I, /obj/item/disk/medical/defib_decay))
		if(!timedeath == initial(timedeath))
			to_chat(user, span_notice("This unit is already upgraded with this disk!"))
			return TRUE
		to_chat(user, span_notice("You upgrade the unit with Longer Decay upgrade disk!"))
		timedeath = 20
		return TRUE
	return ..()

//Primitive paddles - jumper cables
/obj/item/shockpaddles/primitive
	name = "car jumper cables"
	desc = "Jumper cables attached to a car battery."
	icon = 'icons/fallout/objects/medicine/primitivedefib.dmi'
	icon_state = "defibpaddles0"
	lefthand_file = 'icons/fallout/onmob/tools/medical_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/medical_righthand.dmi'
	inhand_icon_state = "defibpaddles0"

/obj/item/shockpaddles/primitive/dropped(mob/user)
	if(!req_defib)
		return ..()
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		if(user != loc)
			to_chat(user, span_notice("You put the clamps back on the car battery."))
			snap_back()

/obj/item/shockpaddles/cyborg
	name = "cyborg defibrillator paddles"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	req_defib = FALSE

/obj/item/shockpaddles/cyborg/attack(mob/M, mob/user)
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user
		if(R.emagged)
			combat = TRUE
		else
			combat = FALSE
	else
		combat = FALSE

	. = ..()

/obj/item/shockpaddles/syndicate
	name = "syndicate defibrillator paddles"
	desc = "A pair of paddles used to revive deceased operatives. It possesses both the ability to penetrate armor and to deliver powerful shocks offensively."
	combat = TRUE
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	req_defib = FALSE

///////////////////////////////////////////
/////////Defibrillator Disks//////////////
///////////////////////////////////////////

/obj/item/disk/medical
	name = "Defibrillator Upgrade Disk"
	desc = "A blank upgrade disk, made for a defibrillator"
	icon_state = "heal_disk"
	inhand_icon_state = "defib_disk"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/disk/medical/defib_heal
	name = "Defibrillator Healing Disk"
	desc = "An upgrade which increases the healing power of the defibrillator"
	icon_state = "heal_disk"
	custom_materials = list(/datum/material/iron=16000, /datum/material/glass = 18000, /datum/material/gold = 6000, /datum/material/silver = 6000)

/obj/item/disk/medical/defib_shock
	name = "Defibrillator Anti-Shock Disk"
	desc = "A safety upgrade that guarantees only the patient will get shocked"
	icon_state = "zap_disk"
	custom_materials = list(/datum/material/iron=16000, /datum/material/glass = 18000, /datum/material/gold = 6000, /datum/material/silver = 6000)

/obj/item/disk/medical/defib_decay
	name = "Defibrillator Body-Decay Extender Disk"
	desc = "An upgrade allowing the defibrillator to work on more decayed bodies"
	icon_state = "body_disk"
	custom_materials = list(/datum/material/iron=16000, /datum/material/glass = 18000, /datum/material/gold = 16000, /datum/material/silver = 6000, /datum/material/titanium = 2000)

/obj/item/disk/medical/defib_speed
	name = "Defibrillator Fast Charge Disk"
	desc = "An upgrade to the defibrillator capacitors, which let it charge faster"
	icon_state = "fast_disk"
	custom_materials = list(/datum/material/iron=16000, /datum/material/glass = 8000, /datum/material/gold = 26000, /datum/material/silver = 26000)

/obj/machinery/pdapainter
	name = "\improper PDA painter"
	desc = "A PDA painting machine. To use, simply insert your PDA and choose the desired preset paint scheme."
	icon = 'icons/obj/pda.dmi'
	icon_state = "pdapainter"
	density = TRUE
	max_integrity = 200
	var/obj/item/pda/storedpda = null
	var/list/colorlist = list(
		"PipBoy 3000",
		"Medical PDA",
		"Virology PDA",
		"Engineering PDA",
		"Security PDA",
		"Detective PDA",
		"Warden PDA",
		"Janitor PDA",
		"Scientist PDA",
		"Head of Personnel PDA",
		"Head of Security PDA",
		"Chief Engineer PDA",
		"Chief Medical Officer PDA",
		"Research Director PDA",
		"Captain PDA",
		"Liutenant PDA",
		"Cargo Technician PDA",
		"Quartermaster PDA",
		"Shaft Miner PDA",
		"Chaplain PDA",
		"Chef PDA",
		"Botanist PDA",
		"Syndicate PDA",
		"Lawyer PDA",
		"Roboticist PDA",
		"Bartender PDA",
		"Atmospheric Technician PDA",
		"Chemist PDA",
		"Geneticist PDA",
		"Clear PDA",
		"Teachboy PDA",
		"Curator PDA",
		"Neko PDA",)


/obj/machinery/pdapainter/update_icon_state()

	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
		return

	if(powered())
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]-off"

	return

/obj/machinery/pdapainter/update_overlays()
	. = ..()

	if(stat & BROKEN)
		return

	if(storedpda)
		. += "[initial(icon_state)]-closed"

// /obj/machinery/pdapainter/Initialize()
// 	. = ..()
// 	var/list/blocked = list(
// 		/datum/pda/ai/pai,
// 		/datum/pda/ai,
// 		/datum/pda/heads,
// 		/datum/pda/clear,
// 		/datum/pda/syndicate,
// 		/datum/pda/chameleon,
// 		/datum/pda/chameleon/broken,
// 		/datum/pda/lieutenant)

// 	for(var/A in typesof(/obj/item/pda) - blocked)
// 		var/obj/item/pda/P = A
// 		var/PDA_name = initial(P.name)
// 		colorlist += PDA_name
// 		colorlist[PDA_name] = list(initial(P.icon_state), initial(P.desc), initial(P.overlays_offsets), initial(P.overlays_icons))

/obj/machinery/pdapainter/Destroy()
	QDEL_NULL(storedpda)
	return ..()

/obj/machinery/pdapainter/on_deconstruction()
	if(storedpda)
		storedpda.forceMove(loc)
		storedpda = null

/obj/machinery/pdapainter/contents_explosion(severity, target)
	if(storedpda)
		storedpda.ex_act(severity, target)

/obj/machinery/pdapainter/handle_atom_del(atom/A)
	if(A == storedpda)
		storedpda = null
		update_icon()

/obj/machinery/pdapainter/attackby(obj/item/O, mob/user, params)
	if(default_unfasten_wrench(user, O))
		power_change()
		return

	else if(istype(O, /obj/item/pda))
		if(storedpda)
			to_chat(user, span_warning("There is already a PDA inside!"))
			return
		else if(!user.transferItemToLoc(O, src))
			return
		storedpda = O
		O.add_fingerprint(user)
		update_icon()

	else if(istype(O, /obj/item/weldingtool) && user.a_intent != INTENT_HARM)
		if(stat & BROKEN)
			if(!O.tool_start_check(user, amount=0))
				return
			user.visible_message("[user] is repairing [src].", \
							span_notice("You begin repairing [src]..."), \
							span_italic("You hear welding."))
			if(O.use_tool(src, user, 40, volume=50))
				if(!(stat & BROKEN))
					return
				to_chat(user, span_notice("You repair [src]."))
				stat &= ~BROKEN
				obj_integrity = max_integrity
				update_icon()
		else
			to_chat(user, span_notice("[src] does not need repairs."))
	else
		return ..()

/obj/machinery/pdapainter/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(!(stat & BROKEN))
			stat |= BROKEN
			update_icon()

/obj/machinery/pdapainter/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)

	if(!storedpda)
		to_chat(user, span_notice("[src] is empty."))
		return
	var/choice = input(user, "Select the new skin!", "PDA Painting") as null|anything in colorlist
	if(!choice || !storedpda || !in_range(src, user))
		return
	storedpda.skindex = choice
	storedpda.update_icon()
	ejectpda()

/obj/machinery/pdapainter/verb/ejectpda()
	set name = "Eject PDA"
	set category = "Object"
	set src in oview(1)

	if(usr.stat || usr.restrained())
		return

	if(storedpda)
		storedpda.forceMove(drop_location())
		storedpda = null
		update_icon()
	else
		to_chat(usr, span_notice("[src] is empty."))


/obj/machinery/pdapainter/power_change()
	..()
	update_icon()

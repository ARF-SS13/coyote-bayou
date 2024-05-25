// -------------------------
//  SmartFridge.  Much todo
// -------------------------
/obj/machinery/smartfridge
	name = "smartfridge"
	desc = "Keeps cold things cold and hot things cold."
	icon = 'icons/obj/vending.dmi'
	icon_state = "smartfridge"
	layer = BELOW_OBJ_LAYER
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 15
	active_power_usage = 300
	circuit = /obj/item/circuitboard/machine/smartfridge

	var/max_n_of_items = 1500
	var/allow_ai_retrieve = FALSE
	var/list/initial_contents
	var/visible_contents = TRUE

/obj/machinery/smartfridge/Initialize()
	. = ..()
	create_reagents(100, NO_REACT)

	if(islist(initial_contents))
		for(var/typekey in initial_contents)
			var/amount = initial_contents[typekey]
			if(isnull(amount))
				amount = 1
			for(var/i in 1 to amount)
				load(new typekey(src))

/obj/machinery/smartfridge/RefreshParts()
	for(var/obj/item/stock_parts/matter_bin/B in component_parts)
		max_n_of_items = 1500 * B.rating

/obj/machinery/smartfridge/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: This unit can hold a maximum of <b>[max_n_of_items]</b> items.")

/obj/machinery/smartfridge/update_icon_state()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(!stat)
		SSvis_overlays.add_vis_overlay(src, icon, "smartfridge-light-mask", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
		if(visible_contents)
			switch(contents.len)
				if(0)
					icon_state = "[initial(icon_state)]"
				if(1 to 25)
					icon_state = "[initial(icon_state)]-1"
				if(26 to 75)
					icon_state = "[initial(icon_state)]-2"
				if(76 to INFINITY)
					icon_state = "[initial(icon_state)]-3"
		else
			icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]-off"



/*******************
*   Item Adding
********************/

/obj/machinery/smartfridge/attackby(obj/item/O, mob/user, params)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, O))
		cut_overlays()
		if(panel_open)
			add_overlay("[initial(icon_state)]-panel")
		updateUsrDialog()
		return

	if(default_pry_open(O))
		return

	if(default_unfasten_wrench(user, O))
		power_change()
		return

	if(default_deconstruction_crowbar(O))
		updateUsrDialog()
		return

	if(!stat)

		if(contents.len >= max_n_of_items)
			to_chat(user, span_warning("\The [src] is full!"))
			return FALSE

		if(accept_check(O))
			load(O)
			user.visible_message(span_notice("[user] adds \the [O] to \the [src]."), span_notice("You add \the [O] to \the [src]."))
			updateUsrDialog()
			if (visible_contents)
				update_icon()
			return TRUE

		if(SEND_SIGNAL(O, COMSIG_CONTAINS_STORAGE))
			var/list/storage_contents = list()
			SEND_SIGNAL(O, COMSIG_TRY_STORAGE_RETURN_INVENTORY, storage_contents) // list mutation, ew
			var/loaded = 0
			for(var/obj/G in storage_contents)
				if(contents.len >= max_n_of_items)
					break
				if(accept_check(G))
					load(G)
					loaded++
			updateUsrDialog()

			if(loaded)
				if(contents.len >= max_n_of_items)
					user.visible_message(span_notice("[user] loads \the [src] with \the [O]."), \
									span_notice("You fill \the [src] with \the [O]."))
				else
					user.visible_message(span_notice("[user] loads \the [src] with \the [O]."), \
										span_notice("You load \the [src] with \the [O]."))
				if(O.contents.len > 0)
					to_chat(user, span_warning("Some items are refused."))
				if (visible_contents)
					update_icon()
				return TRUE
			else
				to_chat(user, span_warning("There is nothing in [O] to put in [src]!"))
				return FALSE

	if(user.a_intent != INTENT_HARM)
		to_chat(user, span_warning("\The [src] smartly refuses [O]."))
		updateUsrDialog()
		return FALSE
	else
		return ..()



/obj/machinery/smartfridge/proc/accept_check(obj/item/O)
	if(istype(O, /obj/item/reagent_containers/food/snacks/grown/) || istype(O, /obj/item/seeds/) || istype(O, /obj/item/grown/))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/proc/load(obj/item/O)
	if(ismob(O.loc))
		var/mob/M = O.loc
		if(!M.transferItemToLoc(O, src))
			to_chat(usr, span_warning("\the [O] is stuck to your hand, you cannot put it in \the [src]!"))
			return FALSE
		else
			return TRUE
	else
		if(O.loc && SEND_SIGNAL(O.loc, COMSIG_CONTAINS_STORAGE))
			return SEND_SIGNAL(O.loc, COMSIG_TRY_STORAGE_TAKE, O, src)
		else
			O.forceMove(src)
			return TRUE

///Really simple proc, just moves the object "O" into the hands of mob "M" if able, done so I could modify the proc a little for the organ fridge
/obj/machinery/smartfridge/proc/dispense(obj/item/O, mob/M)
	if(!M.put_in_hands(O))
		O.forceMove(drop_location())
		adjust_item_drop_location(O)


/obj/machinery/smartfridge/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SmartVend", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/smartfridge/ui_data(mob/user)
	. = list()

	var/listofitems = list()
	for (var/I in src)
		var/atom/movable/O = I
		if (!QDELETED(O))
			var/md5name = md5(O.name)				// This needs to happen because of a bug in a TGUI component, https://github.com/ractivejs/ractive/issues/744
			if (listofitems[md5name])				// which is fixed in a version we cannot use due to ie8 incompatibility
				listofitems[md5name]["amount"]++	// The good news is, #30519 made smartfridge UIs non-auto-updating
			else
				listofitems[md5name] = list("name" = O.name, "type" = O.type, "amount" = 1)
	sortList(listofitems)

	.["contents"] = listofitems
	.["name"] = name
	.["isdryer"] = FALSE


/obj/machinery/smartfridge/handle_atom_del(atom/A) // Update the UIs in case something inside gets deleted
	SStgui.update_uis(src)

/obj/machinery/smartfridge/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("Release")
			var/desired = 0

			if(!allow_ai_retrieve && isAI(usr))
				to_chat(usr, span_warning("[src] does not seem to be configured to respect your authority!"))
				return

			if (params["amount"])
				desired = text2num(params["amount"])
			else
				desired = input("How many items?", "How many items would you like to take out?", 1) as null|num

			if(QDELETED(src) || QDELETED(usr) || !usr.Adjacent(src)) // Sanity checkin' in case stupid stuff happens while we wait for input()
				return FALSE

			if(desired == 1 && Adjacent(usr) && !issilicon(usr))
				for(var/obj/item/O in src)
					if(O.name == params["name"])
						dispense(O, usr)
						break
				if (visible_contents)
					update_icon()
				return TRUE

			for(var/obj/item/O in src)
				if(desired <= 0)
					break
				if(O.name == params["name"])
					dispense(O, usr)
					desired--
			if (visible_contents)
				update_icon()
			return TRUE
	return FALSE


// ----------------------------
//  Drying Rack 'smartfridge'
// ----------------------------
/obj/machinery/smartfridge/drying_rack
	name = "drying rack"
	desc = "A sandstone oven with racks above for hanging produce, used to dry plant products, food and hide."
	icon = 'icons/fallout/farming/farming_structures.dmi'
	icon_state = "drying_rack"
	use_power = IDLE_POWER_USE
	idle_power_usage = 15
	active_power_usage = 600
	visible_contents = FALSE
	proj_pass_rate = 30
	pass_flags = LETPASSTHROW
	pass_flags_self = PASSTABLE | LETPASSTHROW
	var/drying = FALSE

/obj/machinery/smartfridge/drying_rack/Initialize()
	. = ..()
	if(component_parts && component_parts.len)
		component_parts.Cut()
	component_parts = null

/obj/machinery/smartfridge/drying_rack/on_deconstruction()
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	..()

/obj/machinery/smartfridge/drying_rack/RefreshParts()
/obj/machinery/smartfridge/drying_rack/default_deconstruction_screwdriver()
/obj/machinery/smartfridge/drying_rack/exchange_parts()
/obj/machinery/smartfridge/drying_rack/spawn_frame()

/obj/machinery/smartfridge/drying_rack/default_deconstruction_crowbar(obj/item/crowbar/C, ignore_panel = 1)
	..()

/obj/machinery/smartfridge/drying_rack/ui_data(mob/user)
	. = ..()
	.["isdryer"] = TRUE
	.["verb"] = "Take"
	.["drying"] = drying


/obj/machinery/smartfridge/drying_rack/ui_act(action, params)
	. = ..()
	if(.)
		update_icon() // This is to handle a case where the last item is taken out manually instead of through drying pop-out
		return
	switch(action)
		if("Dry")
			toggle_drying(FALSE)
			return TRUE
	return FALSE

// /obj/machinery/smartfridge/drying_rack/powered() do we have this? no.
// 	if(!anchored)
// 		return FALSE
// 	return ..()

/obj/machinery/smartfridge/drying_rack/power_change()
	if(powered() && anchored)
		stat &= ~NOPOWER
	else
		stat |= NOPOWER
		toggle_drying(TRUE)
	update_icon()

	// . = ..()
	// if(!powered())
	// 	toggle_drying(TRUE)

/obj/machinery/smartfridge/drying_rack/load() //For updating the filled overlay
	..()
	update_icon()

/obj/machinery/smartfridge/drying_rack/update_overlays()
	. = ..()
	if(drying)
		. += "drying_rack_drying"
	if(contents.len)
		. += "drying_rack_filled"

/obj/machinery/smartfridge/drying_rack/process()
	..()
	if(drying)
		if(rack_dry())//no need to update unless something got dried
			SStgui.update_uis(src)
			update_icon()

/obj/machinery/smartfridge/drying_rack/accept_check(obj/item/O)
	if(istype(O, /obj/item/reagent_containers/food/snacks/))
		var/obj/item/reagent_containers/food/snacks/S = O
		if(S.dried_type)
			return TRUE
	if(istype(O, /obj/item/stack/sheet/wetleather/)) //no wethide
		return TRUE
	return FALSE

/obj/machinery/smartfridge/drying_rack/proc/toggle_drying(forceoff)
	if(drying || forceoff)
		drying = FALSE
		use_power = IDLE_POWER_USE
	else
		drying = TRUE
		use_power = ACTIVE_POWER_USE
	update_icon()

/obj/machinery/smartfridge/drying_rack/proc/rack_dry()
	for(var/obj/item/reagent_containers/food/snacks/S in src)
		if(S.dried_type == S.type)//if the dried type is the same as the object's type, don't bother creating a whole new item...
			S.add_atom_colour("#ad7257", FIXED_COLOUR_PRIORITY)
			S.dry = TRUE
			S.forceMove(drop_location())
		else
			var/dried = S.dried_type
			new dried(drop_location())
			qdel(S)
		return TRUE
	for(var/obj/item/stack/sheet/wetleather/WL in src)
		new /obj/item/stack/sheet/leather(drop_location(), WL.amount)
		qdel(WL)
		return TRUE
	return FALSE

/obj/machinery/smartfridge/drying_rack/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	atmos_spawn_air("TEMP=1000")


// ----------------------------
//  Bar drink smartfridge
// ----------------------------
/obj/machinery/smartfridge/drinks
	name = "drink showcase"
	desc = "A refrigerated storage unit for tasty tasty alcohol."

/obj/machinery/smartfridge/drinks/accept_check(obj/item/O)
	if(!istype(O, /obj/item/reagent_containers) || (O.item_flags & ABSTRACT) || !O.reagents || !O.reagents.reagent_list.len)
		return FALSE
	if(istype(O, /obj/item/reagent_containers/glass) || istype(O, /obj/item/reagent_containers/food/drinks) || istype(O, /obj/item/reagent_containers/food/condiment))
		return TRUE

// ----------------------------
//  Food smartfridge
// ----------------------------
/obj/machinery/smartfridge/food
	desc = "A refrigerated storage unit for food."

/obj/machinery/smartfridge/food/accept_check(obj/item/O)
	if(istype(O, /obj/item/reagent_containers/food/snacks/))
		return TRUE
	return FALSE

// -------------------------------------
// Xenobiology Slime-Extract Smartfridge
// -------------------------------------
/obj/machinery/smartfridge/extract
	name = "smart slime extract storage"
	desc = "A refrigerated storage unit for slime extracts."

/obj/machinery/smartfridge/extract/accept_check(obj/item/O)
	if(istype(O, /obj/item/slime_extract))
		return TRUE
	if(istype(O, /obj/item/slime_scanner))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/extract/preloaded
	initial_contents = list(/obj/item/slime_scanner = 2)

// -------------------------
// Organ Surgery Smartfridge
// -------------------------
/obj/machinery/smartfridge/organ
	name = "smart organ storage"
	desc = "A refrigerated storage unit for organ storage."
	max_n_of_items = 20	//vastly lower to prevent processing too long
	var/repair_rate = 0

/obj/machinery/smartfridge/organ/accept_check(obj/item/O)
	if(isorgan(O) || isbodypart(O))
		return TRUE
	if(istype(O, /obj/item/reagent_containers/syringe)) //other medical things.
		return TRUE
	if(istype(O, /obj/item/reagent_containers/glass/bottle))
		return TRUE
	if(istype(O, /obj/item/reagent_containers/medspray))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/organ/load(obj/item/O)
	. = ..()
	if(!.)	//if the item loads, clear can_decompose
		return
	if(isorgan(O))
		var/obj/item/organ/organ = O
		organ.organ_flags |= ORGAN_FROZEN

/obj/machinery/smartfridge/organ/RefreshParts()
	for(var/obj/item/stock_parts/matter_bin/B in component_parts)
		max_n_of_items = 20 * B.rating
		repair_rate = max(0, STANDARD_ORGAN_HEALING * (B.rating - 1))

/obj/machinery/smartfridge/organ/process()
	for(var/organ in contents)
		var/obj/item/organ/O = organ
		if(!istype(O))
			return
		O.applyOrganDamage(-repair_rate)

/obj/machinery/smartfridge/organ/Exited(atom/movable/AM, atom/newLoc)
	. = ..()
	if(isorgan(AM))
		var/obj/item/organ/O = AM
		O.organ_flags &= ~ORGAN_FROZEN

/obj/machinery/smartfridge/organ/preloaded //cit specific??????
	initial_contents = list(
		/obj/item/reagent_containers/medspray/synthtissue = 1,
		/obj/item/reagent_containers/medspray/sterilizine = 1)

/obj/machinery/smartfridge/organ/preloaded/Initialize()
	. = ..()
	var/list = list(/obj/item/organ/tongue, /obj/item/organ/brain, /obj/item/organ/heart, /obj/item/organ/liver, /obj/item/organ/ears, /obj/item/organ/eyes, /obj/item/organ/tail, /obj/item/organ/stomach)
	var/newtype = pick(list)
	load(new newtype(src.loc))

// -----------------------------
// Chemistry Medical Smartfridge
// -----------------------------
/obj/machinery/smartfridge/chemistry
	name = "smart chemical storage"
	desc = "A refrigerated storage unit for medicine storage."

/obj/machinery/smartfridge/chemistry/accept_check(obj/item/O)
	var/static/list/chemfridge_typecache = typecacheof(list(
					/obj/item/reagent_containers/syringe,
					/obj/item/reagent_containers/glass/bottle,
					/obj/item/reagent_containers/glass/beaker,
					/obj/item/reagent_containers/spray,
					/obj/item/reagent_containers/hypospray,
					/obj/item/reagent_containers/chem_pack
	))

	if(istype(O, /obj/item/storage/pill_bottle))
		if(O.contents.len)
			for(var/obj/item/I in O)
				if(!accept_check(I))
					return FALSE
			return TRUE
		return FALSE
	if(!istype(O, /obj/item/reagent_containers) || (O.item_flags & ABSTRACT))
		return FALSE
	if(istype(O, /obj/item/reagent_containers/pill)) // empty pill prank ok
		return TRUE
	if(!O.reagents || !O.reagents.reagent_list.len) // other empty containers not accepted
		return FALSE
	if(is_type_in_typecache(O, chemfridge_typecache))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/chemistry/preloaded
	initial_contents = list(
		/obj/item/reagent_containers/pill/epinephrine = 12,
		/obj/item/reagent_containers/pill/charcoal = 5,
		/obj/item/reagent_containers/glass/bottle/epinephrine = 1,
		/obj/item/reagent_containers/glass/bottle/charcoal = 1)

// ----------------------------
// Virology Medical Smartfridge
// ----------------------------
/obj/machinery/smartfridge/chemistry/virology
	name = "smart virus storage"
	desc = "A refrigerated storage unit for volatile sample storage."

/obj/machinery/smartfridge/chemistry/virology/preloaded
	initial_contents = list(
		/obj/item/reagent_containers/syringe/antiviral = 4,
		/obj/item/reagent_containers/glass/bottle/cold = 1,
		/obj/item/reagent_containers/glass/bottle/flu_virion = 1,
		/obj/item/reagent_containers/glass/bottle/mutagen = 1,
		/obj/item/reagent_containers/glass/bottle/sugar = 1,
		/obj/item/reagent_containers/glass/bottle/plasma = 1,
		/obj/item/reagent_containers/glass/bottle/synaptizine = 1,
		/obj/item/reagent_containers/glass/bottle/formaldehyde = 1)

// ----------------------------
// Disk """fridge"""
// ----------------------------
/obj/machinery/smartfridge/disks
	name = "disk compartmentalizer"
	desc = "A machine capable of storing a variety of disks. Denoted by most as the DSU (disk storage unit)."
	icon_state = "disktoaster"
	pass_flags = PASSTABLE
	visible_contents = FALSE

/obj/machinery/smartfridge/disks/accept_check(obj/item/O)
	if(istype(O, /obj/item/disk/))
		return TRUE
	else
		return FALSE

// -------------------------
//  Rack - Unpowered Smartfridge
// -------------------------
/obj/machinery/smartfridge/bottlerack
	name = "bottle rack"
	desc = "The organised way of mass storing your brews."
	icon = 'icons/obj/rack.dmi'
	icon_state = "rack"
	layer = BELOW_OBJ_LAYER
	density = TRUE
	use_power = NO_POWER_USE
	max_n_of_items = 30
	//remember, you have initial_contents, which gets loaded by citadel, and ALWAYS spawns those items
	//the chance_initial_contents will take each item and give it a 50 percent chance of not spawning
	var/list/chance_initial_contents

/obj/machinery/smartfridge/bottlerack/Initialize()
	. = ..()
	if(component_parts && component_parts.len)
		component_parts.Cut()
	component_parts = null

	if(islist(chance_initial_contents))
		for(var/typekey in chance_initial_contents)
			var/amount = chance_initial_contents[typekey]
			if(isnull(amount))
				amount = 1
			for(var/i in 1 to amount)
				if(prob(50))
					load(new typekey(src))
	//because after we load the objects, we need to update the icon
	update_icon()

/obj/machinery/smartfridge/bottlerack/on_deconstruction()
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)

//god, don't just put the procs, at least put a return there!
/obj/machinery/smartfridge/bottlerack/RefreshParts()
	return //because we don't want the parent refresh parts giving us a shit ton of space

/obj/machinery/smartfridge/bottlerack/default_deconstruction_screwdriver()
	return FALSE //because... we don't want it to default deconstruct?

/obj/machinery/smartfridge/bottlerack/exchange_parts()
	return FALSE //because it shouldn't exchange parts!

/obj/machinery/smartfridge/bottlerack/spawn_frame()
	return //because we won't spawn a frame because we shouldn't be deconstructable

/obj/machinery/smartfridge/bottlerack/default_deconstruction_crowbar(obj/item/crowbar/C, ignore_panel = 1)
	. = ..()

/obj/machinery/smartfridge/bottlerack/accept_check(obj/item/O)
	if(!istype(O, /obj/item/reagent_containers) || (O.item_flags & ABSTRACT) || !O.reagents || !O.reagents.reagent_list.len)
		return FALSE
	if(istype(O, /obj/item/reagent_containers/glass) || istype(O, /obj/item/reagent_containers/food/drinks) || istype(O, /obj/item/reagent_containers/food/condiment))
		return TRUE

// -------------------------
//  Gardentool Rack
// -------------------------
/obj/machinery/smartfridge/bottlerack/gardentool
	name = "garden toolrack"
	desc = "The wasteland farmers organisational tool storage."
	icon = 'icons/fallout/farming/farming_structures.dmi'
	icon_state = "gardentool"
	layer = ABOVE_OBJ_LAYER
	max_n_of_items = 30

/obj/machinery/smartfridge/bottlerack/gardentool/accept_check(obj/item/O)
	if(istype(O, /obj/item/plant_analyzer) || istype(O, /obj/item/reagent_containers/spray) || istype(O, /obj/item/cultivator) || istype(O, /obj/item/hatchet) || istype(O, /obj/item/scythe) || istype(O, /obj/item/reagent_containers/glass/bottle/nutrient) || istype(O, /obj/item/reagent_containers/glass/bottle/killer) || istype(O, /obj/item/shovel) || istype(O, /obj/item/twohanded/fireaxe) || istype(O, /obj/item/reagent_containers/glass/bucket) || istype(O, /obj/item/storage/bag/plants) || istype(O, /obj/item/storage/bag/plants/portaseeder) || istype(O, /obj/item/book/manual/advice_farming))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/bottlerack/gardentool/proc/can_be_rotated(mob/user,rotation_type)
	if(anchored)
		to_chat(user, span_warning("[src] cannot be rotated while it is fastened to the wall!"))
	else
		return TRUE

/obj/machinery/smartfridge/bottlerack/gardentool/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS ,null,CALLBACK(src,PROC_REF(can_be_rotated)))

// Preloaded simple farming rack for mapping
/obj/machinery/smartfridge/bottlerack/gardentool/primitive
	initial_contents = list(
		/obj/item/shovel = 2,
		/obj/item/hatchet = 2,
		/obj/item/cultivator/rake  = 2,
		/obj/item/reagent_containers/glass/bucket/wood = 3,
		/obj/item/storage/bag/plants = 2,
		/obj/item/book/manual/advice_farming = 1)


// -------------------------
//  Seedbin
// -------------------------
/obj/machinery/smartfridge/bottlerack/seedbin
	name = "seed bin"
	desc = "Organised dumping ground for the starters of life."
	icon = 'icons/fallout/farming/farming_structures.dmi'
	icon_state = "seedbin"
	max_n_of_items = 400
	proj_pass_rate = 70
	pass_flags = LETPASSTHROW
	pass_flags_self = PASSTABLE | LETPASSTHROW
	var/climbable = TRUE

/obj/machinery/smartfridge/bottlerack/seedbin/accept_check(obj/item/O)
	if(istype(O, /obj/item/seeds))
		return TRUE
	return FALSE

// Preloaded primitive seedbin for mapping. A little too complete for my taste but with the current farming economy its fine.
/obj/machinery/smartfridge/bottlerack/seedbin/primitive
	initial_contents = list(
		/obj/item/seeds/wheat = 3,
		/obj/item/seeds/poppy/broc = 2,
		/obj/item/seeds/xander = 2,
		/obj/item/seeds/feracactus = 1,
		/obj/item/seeds/fungus = 1,
		/obj/item/seeds/punga = 1,)

//-------------------------
// Grownbin
//-------------------------
/obj/machinery/smartfridge/bottlerack/grownbin
	name = "grownbin"
	desc = "A large box, to contain the harvest that the Earth has blessed upon you."
	icon = 'icons/fallout/farming/farming_structures.dmi'
	icon_state = "grownbin"
	max_n_of_items = 1000
	proj_pass_rate = 70
	pass_flags = LETPASSTHROW
	pass_flags_self = PASSTABLE | LETPASSTHROW

/obj/machinery/smartfridge/bottlerack/grownbin/accept_check(obj/item/O)
	if(istype(O, /obj/item/reagent_containers/food/snacks/grown) || istype(O, /obj/item/grown))
		return TRUE
	return FALSE


//-------------------------
// Alchemy Rack - Takes patches, primitive bottle, mourning dust, smelling salt
//-------------------------
/obj/machinery/smartfridge/bottlerack/alchemy_rack
	name = "alchemy rack"
	desc = "A neatly organized cupboard for the storage of homemade remedies and flasks."
	icon_state = "alchemyrack"
	max_n_of_items = 150

/obj/machinery/smartfridge/bottlerack/alchemy_rack/accept_check(obj/item/O)
	var/static/list/alchemyrack_typecache = typecacheof(list(
		/obj/item/reagent_containers/pill/patch,
		/obj/item/reagent_containers/glass/bottle/primitive,
		/obj/item/stack/medical/poultice,
		/obj/item/smelling_salts,
		/obj/item/reagent_containers/pill/healingpowder,
		/obj/item/reagent_containers/pill/antivenom,
		/obj/item/reagent_containers/pill/fiery_purgative,
		/obj/item/reagent_containers/pill/redambrosia,
		/obj/item/reagent_containers/pill/blueambrosia,
		/obj/item/reagent_containers/pill/greenambrosia
	))
	if(is_type_in_typecache(O, alchemyrack_typecache))
		return TRUE
	return FALSE

//-------------------------
// Drug Rack - Drugs, medicines, stuff like that. Made from rusting metal. Not buildable.
//-------------------------
/obj/machinery/smartfridge/bottlerack/drug_storage
	name = "drug storage"
	desc = "Rusting metal shelves stocked with various drugs and medicines."
	icon = 'icons/fallout/structures/racks.dmi'
	icon_state = "drugrack"
	max_n_of_items = 100

/obj/machinery/smartfridge/bottlerack/drug_storage/accept_check(obj/item/O)
	if(istype(O, /obj/item/reagent_containers/pill/patch) || istype(O, /obj/item/reagent_containers/glass/bottle) || istype(O, /obj/item/storage/pill_bottle) || istype(O, /obj/item/reagent_containers/hypospray/medipen))
		return TRUE
	return FALSE

// -------------------------
// LOOTABLE RACKS - PREWAR SHELVES ETC
// -------------------------------------------------------------------------

///generic///bottles

/obj/machinery/smartfridge/bottlerack/lootshelf
	name = "\improper shop shelf"
	desc = "A rusted pre-war shelf, this one has a faded label about soft drinks. "
	icon_state = "lootshelf"
	max_n_of_items = 35

/obj/machinery/smartfridge/bottlerack/lootshelf/accept_check(obj/item/O)
	return FALSE

/obj/machinery/smartfridge/bottlerack/lootshelf
	chance_initial_contents = list(
		/obj/item/reagent_containers/food/drinks/bottle/lemonjuice = 1,
		/obj/item/reagent_containers/food/drinks/bottle/limejuice = 3,
		/obj/item/reagent_containers/food/drinks/bottle/tomatojuice = 4,
		/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 2,
		/obj/item/reagent_containers/food/drinks/soda_cans/tonic = 3,
		/obj/item/reagent_containers/food/drinks/soda_cans/sodawater = 2,
		/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime = 1,
		/obj/item/reagent_containers/food/drinks/bottle/f13nukacola = 4,
		/obj/item/reagent_containers/glass/beaker/big_red/full = 4,
		/obj/item/reagent_containers/food/drinks/bottle/bawls = 3,
		/obj/item/reagent_containers/food/drinks/bottle/vim = 3,
		/obj/item/reagent_containers/food/drinks/bottle/sunset = 3)

////cans

/obj/machinery/smartfridge/bottlerack/lootshelf/cans
	desc = "A rusted pre-war shelf, this one has a faded label about canned goods. "

/obj/machinery/smartfridge/bottlerack/lootshelf/cans
	chance_initial_contents = list(
		/obj/item/reagent_containers/food/drinks/bottle/instacoffee = 5,
		/obj/item/reagent_containers/food/drinks/bottle/instatea = 4,
		/obj/item/reagent_containers/food/drinks/bottle/instacocoa = 4,
		/obj/item/reagent_containers/food/drinks/soda_cans/cream = 3,
		/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans = 3,
		/obj/item/reagent_containers/food/snacks/f13/canned/borscht = 1,
		/obj/item/reagent_containers/food/snacks/f13/canned/dog = 3,
		/obj/item/reagent_containers/food/snacks/beans = 3,)

///booze

/obj/machinery/smartfridge/bottlerack/lootshelf/brews
	desc = "A rusted pre-war shelf, this one has a faded label about alchohol. "

/obj/machinery/smartfridge/bottlerack/lootshelf/brews
	chance_initial_contents = list(
		/obj/item/reagent_containers/food/drinks/bottle/gin = 1,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 1,
		/obj/item/reagent_containers/food/drinks/bottle/tequila = 1,
		/obj/item/reagent_containers/food/drinks/bottle/rum = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vermouth = 1,
		/obj/item/reagent_containers/food/drinks/bottle/cognac = 1,
		/obj/item/reagent_containers/food/drinks/bottle/absinthe = 1,
		/obj/item/reagent_containers/food/drinks/bottle/lizardwine = 1,
		/obj/item/reagent_containers/food/drinks/bottle/hcider = 1,
		/obj/item/reagent_containers/food/drinks/bottle/grappa = 1,
		/obj/item/reagent_containers/food/drinks/bottle/sake = 1,
		/obj/item/reagent_containers/food/drinks/bottle/fernet = 1,
		/obj/item/reagent_containers/food/drinks/bottle/amaretto = 1,
		/obj/item/reagent_containers/food/drinks/bottle/hooch = 1)

//diy

/obj/machinery/smartfridge/bottlerack/lootshelf/diy
	desc = "A rusted pre-war shelf, this one has a faded label about DIY. "

/obj/machinery/smartfridge/bottlerack/lootshelf/diy
	chance_initial_contents = list(
		/obj/item/extinguisher = 1,
		/obj/item/hatchet = 1,
		/obj/item/pickaxe/mini = 1,
		/obj/item/wrench = 1,
		/obj/item/twohanded/fireaxe = 1,
		/obj/item/twohanded/sledgehammer/simple = 1,
		/obj/item/reagent_containers/food/snacks/deadmouse = 1,
		/obj/item/clothing/gloves/color/yellow = 1,
		/obj/item/flashlight = 1,
		/obj/item/stack/cable_coil/random = 1,
		/obj/item/screwdriver = 1,
		/obj/item/wirecutters = 1,
		/obj/item/clothing/head/hardhat = 1)

//construction

/obj/machinery/smartfridge/bottlerack/lootshelf/construction
	desc = "A rusted pre-war shelf, this one has a faded label about materials. "

/obj/machinery/smartfridge/bottlerack/lootshelf/construction
	chance_initial_contents = list(
		/obj/item/stack/sheet/metal/ten = 1,
		/obj/item/stack/sheet/glass/ten = 1,
		/obj/item/stack/sheet/plasteel/five = 1,
		/obj/item/stack/sheet/plastic/five = 1,
		/obj/item/stack/sheet/cloth/five = 1,
		/obj/item/stack/crafting/metalparts/three = 1,
		/obj/item/stack/crafting/goodparts/three = 1,
		/obj/item/stack/crafting/electronicparts/three = 1)

//cooking

/obj/machinery/smartfridge/bottlerack/lootshelf/cooking
	desc = "A rusted pre-war shelf, this one has a faded label about cooking. "

/obj/machinery/smartfridge/bottlerack/lootshelf/cooking
	chance_initial_contents = list(
		/obj/item/reagent_containers/food/condiment/flour = 1,
		/obj/item/reagent_containers/food/condiment/rice = 1,
		/obj/item/reagent_containers/food/condiment/yeast = 1,
		/obj/item/reagent_containers/food/condiment/saltshaker = 1,
		/obj/item/reagent_containers/food/condiment/peppermill = 1,
		/obj/item/reagent_containers/food/condiment/soysauce = 1,
		/obj/item/reagent_containers/food/condiment/soysauce = 1,
		/obj/item/reagent_containers/food/condiment/vinegar = 1,
		/obj/item/reagent_containers/food/condiment/quality_oil = 1)

/obj/machinery/smartfridge/bottlerack/lootshelf/books
	desc = "A rusted pre-war shelf, this one has a faded label about magazines. "

/obj/machinery/smartfridge/bottlerack/lootshelf/books
	chance_initial_contents = list(
		/obj/item/reagent_containers/food/snacks/deadmouse = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_one = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_two = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_three = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_four = 1,
		/obj/item/book/granter/crafting_recipe/scav_two = 1,
		/obj/item/book/granter/crafting_recipe/scav_three = 1)

/obj/machinery/smartfridge/bottlerack/lootshelf/condiment
	desc = "A rusted pre-war shelf, this one has a faded label about condiments. "

/obj/machinery/smartfridge/bottlerack/lootshelf/condiment
	chance_initial_contents = list(
		/obj/item/reagent_containers/food/condiment/ketchup = 1,
		/obj/item/reagent_containers/food/condiment/mustard = 1,
		/obj/item/reagent_containers/food/condiment/bbqsauce = 1,
		/obj/item/reagent_containers/food/condiment/honey = 1,
		/obj/item/reagent_containers/food/condiment/cherryjelly = 1,
		/obj/item/reagent_containers/food/condiment/peanut_butter = 1,
		/obj/item/reagent_containers/food/condiment/mayonnaise = 1)

/obj/machinery/smartfridge/bottlerack/lootshelf/craftable
	name = "crafted shop shelf"
	desc = "A handmade shop shelf, looks pretty robust. Has a blank sign in the center to be written on with a pen."
	max_n_of_items = 75

/obj/machinery/smartfridge/bottlerack/lootshelf/craftable
	chance_initial_contents = list()

/obj/machinery/smartfridge/bottlerack/lootshelf/craftable/on_deconstruction()
	new /obj/item/stack/sheet/metal(drop_location(), 5)

/obj/machinery/smartfridge/bottlerack/lootshelf/craftable/accept_check(obj/item/O)
	if(istype(O, /obj/item/clothing/head/mob_holder))
		return FALSE
	if(istype(O, /obj/item/storage))
		return FALSE
	if(istype(O, /obj/item/pen))
		return FALSE
	if(istype(O, /obj/item/toy/crayon/spraycan)) //Theres probably a better way to do this, I tried testing other ways, but this works
		return FALSE

	if(O)
		return TRUE
	return FALSE

#define AUTOLATHE_MAIN_MENU       1
#define AUTOLATHE_CATEGORY_MENU   2
#define AUTOLATHE_SEARCH_MENU     3
#define AUTOLATHE_STOP_INSERTING "KILL"
#define AUTOLATHE_SKIP_INSERTING FALSE
#define AUTOLATHE_INSERT_CONTAINER_TOO "YES"
#define AUTOLATHE_INSERT_OK TRUE

GLOBAL_VAR_INIT(lathe_reports_done, 0)

/obj/machinery/autolathe
	name = "autolathe"
	desc = "It produces items using metal and glass."
	icon_state = "autolathe"
	var/icon_state_base = "autolathe"
	var/icon_state_open = "autolathe_t"
	var/icon_state_busy = "autolathe_n"
	var/icon_state_loading_metal = "autolathe_r"
	var/icon_state_loading_other = "autolathe_o"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 30
	active_power_usage = 300
	circuit = /obj/item/circuitboard/machine/autolathe
	layer = BELOW_OBJ_LAYER

	var/operating = FALSE
	var/list/L = list()
	var/list/LL = list()
	var/hacked = FALSE
	var/disabled = 0
	var/shocked = FALSE
	var/hack_wire
	var/disable_wire
	var/shock_wire
	tooadvanced = FALSE //Used to prevent usage of things that are technophobes. Disabled because autolathes are simple button-presses
	var/busy = FALSE
	var/prod_coeff = 1

	var/datum/design/being_built
	var/list/datum/design/matching_designs
	var/selected_category
	var/screen = 1
	var/base_price = 25
	var/hacked_price = 50

	var/DRM = 0 //determines if DRM is active, preventing you from making ammo

	/// If someone is loop-feeding us, let em know what they put in when it stops looping
	var/datum/autolathe_loop_returns/report_card
	var/report_timer
	var/datum/autolathe_loop_returns/big_report_card
	var/big_report_timer

	var/datum/techweb/specialized/autounlocking/stored_research = /datum/techweb/specialized/autounlocking/autolathe
	var/list/categories = list(
							"Tools",
							"Electronics",
							"Construction",
							"T-Comm",
							"Security",
							"Machinery",
							"Medical",
							"Misc",
							"Dinnerware",
							"Imported"
							)
	var/list/allowed_materials

	/// Base print speed
	var/base_print_speed = 10

/obj/machinery/autolathe/Initialize()
	. = ..()
	wires = new /datum/wires/autolathe(src)
	stored_research = new stored_research
	matching_designs = list()

/obj/machinery/autolathe/ComponentInitialize()
	AddComponent(/datum/component/material_container, SSmaterials.materialtypes_by_category[MAT_CATEGORY_RIGID], 0, TRUE, null, null, CALLBACK(src,PROC_REF(AfterMaterialInsert)))

/obj/machinery/autolathe/Destroy()
	QDEL_NULL(wires)
	QDEL_NULL(report_card)
	QDEL_NULL(big_report_card)
	if(report_timer)
		deltimer(report_timer)
	if(big_report_timer)
		deltimer(big_report_timer)
	return ..()

/obj/machinery/autolathe/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(!is_operational())
		return

	if(shocked && !(stat & NOPOWER))
		shock(user,50)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Autolathe", capitalize(src.name))
		ui.open()

/obj/machinery/autolathe/ui_data(mob/user)
	var/list/data = list()
	data["materials"] = list()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	data["materialtotal"] = materials.total_amount
	data["materialsmax"] = materials.max_amount
	data["categories"] = categories
	data["designs"] = list()
	data["active"] = busy

	for(var/mat_id in materials.materials)
		var/datum/material/M = mat_id
		var/mineral_count = materials.materials[mat_id]
		if(mineral_count < 1)
			continue
		var/list/material_data = list(
			name = M.name || "Stuff",
			mineral_amount = mineral_count || 0,
			matcolour = M.color || "#FF00FF",
		)
		data["materials"] += list(material_data)
	if(selected_category != "None" && !length(matching_designs))
		data["designs"] = handle_designs(stored_research.researched_designs, TRUE)
	else
		data["designs"] = handle_designs(matching_designs, FALSE)
	return data

/obj/machinery/autolathe/proc/handle_designs(list/designs, categorycheck)
	var/list/output = list()
	for(var/v in designs)
		var/datum/design/D = categorycheck ? SSresearch.techweb_design_by_id(v) : v
		if(categorycheck)
			if(!(selected_category in D.category))
				continue
		var/unbuildable = FALSE // we can't build the design currently
		var/m10 = FALSE // 10x mult
		var/m25 = FALSE // 25x mult
		var/m50 = FALSE // 50x mult
		var/m5 = FALSE // 5x mult
		var/sheets = FALSE // sheets or no?
		if(disabled || !can_build(D))
			unbuildable = TRUE
		var/max_multiplier = unbuildable ? 0 : 1
		if(ispath(D.build_path, /obj/item/stack))
			sheets = TRUE
			if(!unbuildable)
				var/datum/component/material_container/mats = GetComponent(/datum/component/material_container)
				for(var/datum/material/mat in D.materials)
					max_multiplier = min(D.maxstack, round(mats.get_material_amount(mat)/D.materials[mat]))
				if (max_multiplier>10 && !disabled)
					m10 = TRUE
				if (max_multiplier>25 && !disabled)
					m25 = TRUE
		else
			if(!unbuildable)
				if(!disabled && can_build(D, 5))
					m5 = TRUE
				if(!disabled && can_build(D, 10))
					m10 = TRUE
				var/datum/component/material_container/mats = GetComponent(/datum/component/material_container)
				var/iter_max_multiplier = 50
				for(var/datum/material/mat in D.materials)
					if (D.materials[mat] == 0)
						continue // We aren't actually using the material, let's skip the divide by zero error and get on with our lives
					var/local_max_multiplier = min(50, round(mats.get_material_amount(mat)/(D.materials[mat] * prod_coeff)))
					iter_max_multiplier = min(local_max_multiplier, iter_max_multiplier) // Use the lesser of the two since there is a limiting factor
				max_multiplier = iter_max_multiplier

		var/list/design = list(
			name = D.name,
			id = D.id,
			ref = REF(src),
			cost = get_design_cost(D, TRUE),
			buildable = unbuildable,
			mult5 = m5,
			mult10 = m10,
			mult25 = m25,
			mult50 = m50,
			sheet = sheets,
			maxmult = max_multiplier,
		)
		output += list(design)
	return output

/obj/machinery/autolathe/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(action == "menu")
		selected_category = null
		matching_designs.Cut()
		. = TRUE

	if(action == "category")
		selected_category = params["selectedCategory"]
		matching_designs.Cut()
		. = TRUE

	if(action == "search")
		matching_designs.Cut()

		for(var/v in stored_research.researched_designs)
			var/datum/design/D = SSresearch.techweb_design_by_id(v)
			if(findtext(D.name,params["to_search"]))
				matching_designs.Add(D)
		. = TRUE

	if(action == "make")
		if (!busy)
			/////////////////
			//href protection
			being_built = stored_research.isDesignResearchedID(params["id"])
			if(!being_built)
				return

			var/multiplier = text2num(params["multiplier"])
			if(!multiplier)
				to_chat(usr, span_alert("[src] only accepts a numerical multiplier!"))
				return
			var/is_stack = ispath(being_built.build_path, /obj/item/stack)
			multiplier = clamp(round(multiplier),1,50)

			/////////////////

			var/coeff = (is_stack ? 1 : prod_coeff) //stacks are unaffected by production coefficient
			var/total_amount = 0

			for(var/MAT in being_built.materials)
				total_amount += being_built.materials[MAT]

			var/power = max(2000, (total_amount)*multiplier/5) //Change this to use all materials

			var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

			var/list/materials_used = list()
			var/list/custom_materials = list() //These will apply their material effect, This should usually only be one.

			for(var/MAT in being_built.materials)
				var/datum/material/used_material = MAT
				var/amount_needed = being_built.materials[MAT] * coeff * multiplier
				if(istext(used_material)) //This means its a category
					var/list/list_to_show = list()
					for(var/i in SSmaterials.materials_by_category[used_material])
						if(materials.materials[i] > 0)
							list_to_show += i

					used_material = tgui_input_list(usr, "Choose [used_material]", "Custom Material", sortList(list_to_show, GLOBAL_PROC_REF(cmp_typepaths_asc)))
					if(isnull(used_material))
						return //Didn't pick any material, so you can't build shit either.
					custom_materials[used_material] += amount_needed

				materials_used[used_material] = amount_needed

			if(materials.has_materials(materials_used))
				busy = TRUE
				to_chat(usr, span_notice("You print [multiplier] item(s) from the [src]"))
				use_power(power)
				icon_state = "autolathe_n"
				var/time = is_stack ? 32 : (32 * coeff * multiplier) ** 0.8
				addtimer(CALLBACK(src,PROC_REF(make_item), power, materials_used, custom_materials, multiplier, coeff, is_stack, usr), time)
				. = TRUE
			else
				to_chat(usr, span_alert("Not enough materials for this operation."))
		else
			to_chat(usr, span_alert("The autolathe is busy. Please wait for completion of previous operation."))


/obj/machinery/autolathe/on_deconstruction()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.retrieve_all()

/obj/machinery/autolathe/attackby(obj/item/O, mob/user, params)
	if(busy)
		to_chat(user, "<span class=\"alert\">The autolathe is busy. Please wait for completion of previous operation.</span>")
		return TRUE

	if(default_deconstruction_screwdriver(user, icon_state_open, icon_state_base, O))
		// updateUsrDialog()
		return TRUE

	if(default_deconstruction_crowbar(O))
		return TRUE

	if(panel_open && is_wire_tool(O))
		wires.interact(user)
		return TRUE

	if(user.a_intent != INTENT_HELP) //so we can hit the machine
		return ..()

	if(stat)
		return TRUE

	if(istype(O, /obj/item/disk/design_disk))
		user.visible_message("[user] begins to load \the [O] in \the [src]...",
			"You begin to load a design from \the [O]...",
			"You hear the chatter of a floppy drive.")
		busy = TRUE
		var/obj/item/disk/design_disk/D = O
		if(do_after(user, 14.4, target = src))
			for(var/B in D.blueprints)
				if(B)
					stored_research.add_design(B)
		busy = FALSE
		return TRUE

	if(gun_loop(user, O)) // it'll eat the gun or the magazine or whatever
		return TRUE

	if(is_probably_important(user, O)) 
		return recycle_item(user, O, 5 SECONDS, FALSE)
	recycle_item(user, O, 0, FALSE)
	// return ..()

/obj/machinery/autolathe/proc/is_probably_important(mob/user, obj/item/O)
	if(!user || !O)
		return FALSE
	if(!istype(O, /obj/item))
		return FALSE
	if(O.tool_behaviour)
		return TRUE // it's a tool, so it's probably important
	if(SEND_SIGNAL(O, COMSIG_CONTAINS_STORAGE))
		return TRUE // it's got stuff innit, so it's probably important
	if(istype(O, /obj/item/ammo_box))
		return TRUE // it's an ammo box, so it's probably important
	if(istype(O, /obj/item/gun))
		return TRUE // it's a gun, so it's probably important
	return FALSE


/obj/machinery/autolathe/proc/AfterMaterialInsert(obj/item/item_inserted, id_inserted, amount_inserted)
	if(istype(item_inserted, /obj/item/stack/ore/bluespace_crystal))
		use_power(MINERAL_MATERIAL_AMOUNT / 10)
	else if(item_inserted.custom_materials?.len && item_inserted.custom_materials[SSmaterials.GetMaterialRef(/datum/material/glass)])
		flick(icon_state_loading_metal,src)//plays glass insertion animation by default otherwise
	else
		flick(icon_state_loading_other,src)//plays metal insertion animation

		use_power(min(1000, amount_inserted / 100))
	// updateUsrDialog()

/obj/machinery/autolathe/proc/make_item(power, list/materials_used, list/picked_materials, multiplier, coeff, is_stack)
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/atom/A = drop_location()
	use_power(power)
	materials.use_materials(materials_used)

	if(is_stack)
		var/obj/item/stack/N = new being_built.build_path(A, multiplier)
		N.update_icon()
		N.autolathe_crafted(src)
	else
		for(var/i in 1 to multiplier)
			var/obj/item/new_item = new being_built.build_path(A)
			new_item.autolathe_crafted(src)

			if(LAZYLEN(picked_materials))
				new_item.set_custom_materials(picked_materials, 1 / multiplier) //Ensure we get the non multiplied amount

	icon_state = icon_state_base
	busy = FALSE

/obj/machinery/autolathe/RefreshParts()
	var/mat_capacity = 0
	for(var/obj/item/stock_parts/matter_bin/new_matter_bin in component_parts)
		mat_capacity += new_matter_bin.rating*75000
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.max_amount = mat_capacity

	var/efficiency=1.2
	for(var/obj/item/stock_parts/manipulator/new_manipulator in component_parts)
		efficiency -= new_manipulator.rating*0.2
	prod_coeff = max(1,efficiency) // prod_coeff goes 1 -> 0,8 -> 0,6 -> 0,4 per level of manipulator efficiency

/obj/machinery/autolathe/examine(mob/user)
	. += ..()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Storing up to <b>[materials.max_amount]</b> material units.<br>Material consumption at <b>[prod_coeff*100]%</b>.")

/obj/machinery/autolathe/proc/can_build(datum/design/D, amount = 1)
	if(length(D.make_reagents))
		return FALSE

	var/coeff = (ispath(D.build_path, /obj/item/stack) ? 1 : prod_coeff)

	var/list/required_materials = list()

	for(var/i in D.materials)
		required_materials[i] = D.materials[i] * coeff * amount

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

	return materials.has_materials(required_materials)

/obj/machinery/autolathe/proc/get_design_cost(datum/design/D, commatize)
	var/coeff = (ispath(D.build_path, /obj/item/stack) ? 1 : prod_coeff)
	var/dat
	for(var/i in D.materials)
		if(istext(i)) //Category handling
			dat += "[D.materials[i] * coeff] [i]"
		else
			var/datum/material/M = i
			dat += "[D.materials[i] * coeff] [M.name] "
		if(commatize)
			dat += ", "
	return dat

/obj/machinery/autolathe/proc/reset(wire)
	switch(wire)
		if(WIRE_HACK)
			if(!wires.is_cut(wire))
				adjust_hacked(FALSE)
		if(WIRE_SHOCK)
			if(!wires.is_cut(wire))
				shocked = FALSE
		if(WIRE_DISABLE)
			if(!wires.is_cut(wire))
				disabled = FALSE

/obj/machinery/autolathe/proc/shock(mob/user, prb)
	if(stat & (BROKEN|NOPOWER))		// unpowered, no shock
		return FALSE
	if(!prob(prb))
		return FALSE
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	if (electrocute_mob(user, get_area(src), src, 0.7, TRUE))
		return TRUE
	else
		return FALSE

/obj/machinery/autolathe/proc/adjust_hacked(state)
	hacked = state
	for(var/id in SSresearch.techweb_designs)
		var/datum/design/D = SSresearch.techweb_design_by_id(id)
		if(D.build_type & stored_research.design_autounlock_skip_types)
			continue
		if((D.build_type & stored_research.design_autounlock_buildtypes) && ("hacked" in D.category))
			if(hacked)
				stored_research.add_design(D)
			else
				stored_research.remove_design(D)

/obj/machinery/autolathe/proc/run_gun_loop(mob/user, obj/item/gunammo)
	if(!user)
		return FALSE
	if(!isgun(gunammo) && !isammobox(gunammo))
		return FALSE
	return gun_loop(user, gunammo) // one test loop to see if we can load it

/obj/machinery/autolathe/proc/gun_loop(mob/user, obj/item/gunammo)
	if(!user || !user.Adjacent(src))
		return FALSE
	if(!isballistic(gunammo) && !isammobox(gunammo) && !istype(gunammo, /obj/item/storage/bag/casings))
		return FALSE
	else if(isballistic(gunammo))
		gunammo = load_from_ballistic(user, gunammo)
		if(!istype(gunammo)) // this one is special, cus it needs to shift focus to the magazine if it popped one out
			to_chat(user, span_warning("You can't load \the [gunammo] into \the [src]!"))
			return FALSE
	else if(isammobox(gunammo) && !load_from_ammo_box(user, gunammo))
		to_chat(user, span_warning("You can't load \the [gunammo] into \the [src]!"))
		return FALSE
	else if(istype(gunammo, /obj/item/storage/bag/casings) && !load_from_bag(user, gunammo))
		to_chat(user, span_warning("You can't load anything in \the [gunammo] into \the [src]!"))
		return FALSE
	// else if(istype(gunammo, /obj/item/gun/energy) && !load_from_energy(user, gunammo))
	// 	to_chat(user, span_warning("You can't load \the [gunammo] into \the [src]!"))
	// 	return FALSE // screw energy guns
	/// if we're here, we loaded something, so lets queue up another cycle
	addtimer(CALLBACK(src,PROC_REF(gun_loop), user, gunammo), 0.1 SECONDS)
	return TRUE

/obj/machinery/autolathe/proc/load_from_bag(mob/user, obj/item/storage/bag/casings/cbag) // BIG BAG, BIG BAG, BIGABIGABIGBAG
	if(!user || !istype(cbag, /obj/item/storage/bag/casings))
		return FALSE
	var/obj/item/ammo_casing/bluuet = cbag.find_casing(user, TRUE, TRUE)
	if(!bluuet)
		return FALSE
	bluuet.forceMove(get_turf(user))
	playsound(src, 'sound/weapons/bulletinsert.ogg', 40, 1)
	return recycle_casing(user, bluuet) // TRUE will tell the loop to queue up another cycle

/obj/machinery/autolathe/proc/load_from_ballistic(mob/user, obj/item/gun/ballistic/ballgun)
	if(!istype(ballgun, /obj/item/gun/ballistic))
		return FALSE
	/// our goal here, find a casing, remove it, and toss it in the machine
	var/obj/item/ammo_casing/C
	/// First, look for a loaded magazine
	var/obj/item/ammo_box/mag = ballgun.magazine
	if(istype(mag))
		if(istype(mag, /obj/item/ammo_box/magazine/internal/cylinder)) /// everyone's gotta be special
			C = mag.get_round()
			if(C)
				if(C == ballgun.chambered)
					ballgun.chambered = null
				C.forceMove(get_turf(C))
				C.bounce_away(FALSE, 1, 0, 0, 0)
				playsound(src, 'sound/weapons/bulletinsert.ogg', 60, 1)
				if(recycle_casing(user, C)) // TRUE will tell the loop to queue up another cycle
					return ballgun // revolvers are special
		// if its a fixed mag, using the gun in hand will eject a casing
		if((mag.fixed_mag || !ballgun.casing_ejector) && ballgun.chambered) // usually the chambered one, so, lets do that
			C = ballgun.chambered
			ballgun.attack_self(user)
			if(ballgun.chambered == C) // Darn thing is still in there
				return FALSE
			if(recycle_casing(user, C)) // TRUE will tell the loop to queue up another cycle
				return ballgun
			// recycle_gun(user, ballgun) // start loading the gun into the machine
			return FALSE
		// otherwise, we need to remove the magazine, and eject a casing
		ballgun.attack_self(user)
		if(mag.loc == ballgun) // if it's still in the gun, we failed to remove it
			return FALSE
		// otherwise, we have a magazine, and it's not in the gun
		if(load_from_ammo_box(user, mag))
			return mag // shift focus to the magazine
		// recycle_gun(user, ballgun) // one way or another, something is getting loaded
		return FALSE
	/// if we're here, we don't have a magazine loaded!
	if(ballgun.chambered) // if we have a casing in the chamber, lets try to eject it
		C = ballgun.chambered
		ballgun.attack_self(user)
		if(ballgun.chambered == C) // Darn thing is still in there
			return FALSE
		if(C) // yay we have a casing!
			if(recycle_casing(user, C)) // TRUE will tell the loop to queue up another cycle
				return ballgun
		// return recycle_gun(user, ballgun) // start loading the gun into the machine

/obj/machinery/autolathe/proc/load_from_ammo_box(mob/user, obj/item/ammo_box/mag)
	if(!istype(mag, /obj/item/ammo_box))
		return FALSE
	/// our goal here, find a casing, remove it, and toss it in the machine
	var/obj/item/ammo_casing/C = mag.pop_casing(user, TRUE, TRUE)
	if(C)
		C.forceMove(get_turf(C))
		C.bounce_away(FALSE, 1, 0, 0, 0)
		playsound(src, 'sound/weapons/bulletinsert.ogg', 60, 1)

	return recycle_casing(user, C) // TRUE will tell the loop to queue up another cycle

// /obj/machinery/autolathe/proc/load_from_energy(mob/user, obj/item/gun/energy/energygun)
// 	if(!user || !istype(energygun, /obj/item/gun/energy))
// 		return FALSE

/obj/machinery/autolathe/proc/recycle_casing(mob/user, obj/item/casing) // doesnt really matter if its a casing
	if(!user)
		return FALSE
	if(!istype(casing, /obj/item/ammo_casing) || QDELETED(casing))
		return FALSE
	if(istype(casing.loc, /obj/item/gun))
		var/obj/item/gun/G = casing.loc
		/// manually extract that drn bullet
		if(G.chambered == casing)
			G.attack_self(user)
			if(G.chambered == casing) // Darn thing is still in there
				return FALSE
	return recycle_item(user, casing, 0 SECONDS, TRUE)

/obj/machinery/autolathe/proc/recycle_ammo_box(mob/user, obj/item/ammo_box/mag)
	if(!user)
		return FALSE
	if(!istype(mag, /obj/item/ammo_box) || QDELETED(mag))
		return FALSE
	return recycle_item(user, mag, 3 SECONDS, FALSE)

/obj/machinery/autolathe/proc/recycle_gun(mob/user, obj/item/gun/ballistic/ballgun)
	if(!user)
		return FALSE
	if(!istype(ballgun, /obj/item/gun/ballistic) || QDELETED(ballgun))
		return FALSE
	return recycle_item(user, ballgun, 8 SECONDS, FALSE)

/obj/machinery/autolathe/proc/recycle_item(mob/user, obj/item/item, time = 0.1 SECONDS, silent)
	if(!user)
		return FALSE
	if(!istype(item, /obj/item) || QDELETED(item))
		return FALSE
	if(INTERACTING_WITH(user, src))
		to_chat(user, span_alert("You're already doing something!"))
		return FALSE
	if(time > 0)
		if(!silent)
			to_chat(user, span_notice("You start loading \the [item] into \the [src]."))
		if(!do_after(user, time, TRUE, src, allow_movement = FALSE, stay_close = TRUE, public_progbar = TRUE))
			to_chat(user, span_alert("You were interrupted!"))
			return FALSE
	if(SEND_SIGNAL(src, COMSIG_PARENT_FORCEFEED, item, user, TRUE, silent) == TRUE)
		update_record(item)
		return TRUE

/obj/machinery/autolathe/proc/update_record(obj/item/item)
	if(!istype(item, /obj/item))
		return FALSE

	if(!istype(report_card))
		report_card = new()
	report_card.inserted_something(item)
	if(report_timer)
		deltimer(report_timer)
	report_timer = addtimer(CALLBACK(src,PROC_REF(print_record)), 30 SECONDS, TIMER_STOPPABLE) // save in 4 seconds

	if(!istype(big_report_card))
		big_report_card = new()
	big_report_card.inserted_something(item)
	if(big_report_timer)
		deltimer(big_report_timer)
	big_report_timer = addtimer(CALLBACK(src,PROC_REF(print_big_record)), 15 MINUTES, TIMER_STOPPABLE) // save in 4 seconds

/obj/machinery/autolathe/proc/print_record()
	if(!istype(report_card, /datum/autolathe_loop_returns))
		return FALSE
	if(!report_card.should_output_report(src))
		return FALSE
	playsound(src, 'sound/machines/printer_thermal.ogg', 50, 1)
	report_card.output_report(src)
	QDEL_NULL(report_card)

/obj/machinery/autolathe/proc/print_big_record()
	if(!istype(big_report_card, /datum/autolathe_loop_returns))
		return FALSE
	playsound(src, 'sound/machines/printer_thermal.ogg', 50, 1)
	big_report_card.output_report(src)
	QDEL_NULL(big_report_card)

/obj/machinery/autolathe/hacked/Initialize()
	. = ..()
	adjust_hacked(TRUE)

/obj/machinery/autolathe/secure
	name = "secured autolathe"
	desc = "It produces items using metal and glass. This model was reprogrammed without some of the more hazardous designs."
	circuit = /obj/item/circuitboard/machine/autolathe/secure
	stored_research = /datum/techweb/specialized/autounlocking/autolathe/public
	base_print_speed = 20

/obj/machinery/autolathe/secure/Initialize()
	. = ..()
	// let's not leave the parent datum floating, right?
	if(stored_research)
		QDEL_NULL(stored_research)
	stored_research = new /datum/techweb/specialized/autounlocking/autolathe/public

/obj/machinery/autolathe/toy
	name = "autoylathe"
	desc = "It produces toys using plastic, metal and glass."
	circuit = /obj/item/circuitboard/machine/autolathe/toy

	stored_research = /datum/techweb/specialized/autounlocking/autolathe/toy
	categories = list(
					"Toys",
					"Figurines",
					"Pistols",
					"Rifles",
					"Heavy",
					"Melee",
					"Armor",
					"Adult",
					"Misc",
					"Imported"
					)
	allowed_materials = list(
		/datum/material/iron,
		/datum/material/glass,
		/datum/material/plastic
		)

/obj/machinery/autolathe/toy/hacked/Initialize()
	. = ..()
	adjust_hacked(TRUE)
	// let's not leave the parent datum floating, right?
	if(stored_research)
		QDEL_NULL(stored_research)
	stored_research = new /datum/techweb/specialized/autounlocking/autolathe/toy

/obj/machinery/autolathe/ComponentInitialize()
	var/list/extra_mats = list(/datum/material/plastic)
	AddComponent(/datum/component/material_container, SSmaterials.materialtypes_by_category[MAT_CATEGORY_RIGID] + extra_mats, 0, TRUE, null, null, CALLBACK(src,PROC_REF(AfterMaterialInsert)))

/obj/machinery/autolathe/constructionlathe
	name = "Workshop"
	desc = "Contains an array of custom made and skilled tools for professional craftsmen."
	circuit = /obj/item/circuitboard/machine/autolathe/constructionlathe
	super_advanced_technology = TRUE
	resistance_flags = NONE
	var/constage = 0 //construction stage for upgrading into a regular lathe
	//DRM = 1
	categories = list(
							"Tools",
							"Electronics",
							"Construction",
							"T-Comm",
							//"Security",
							"Machinery",
							"Medical",
							"Misc",
							"Dinnerware",
							)

/obj/machinery/autolathe/ammo
	name = "reloading bench"
	icon = 'icons/obj/machines/reloadingbench.dmi'
	desc = "An ammo bench that utilizes metal and other materials to make ammo and magazines."
	circuit = /obj/item/circuitboard/machine/autolathe/ammo
	stored_research = /datum/techweb/specialized/autounlocking/autolathe/ammo
	categories = list(
					"Blackpowder Loads",
					"Smokeless Loads",
					"Military Loads",
					"Materials"
					)
	allowed_materials = list(
		/datum/material/iron,
		/datum/material/titanium,
		/datum/material/blackpowder,
		/datum/material/uranium)
	var/simple = 0
	var/basic = 0
	var/intermediate = 0
	var/advanced = 0
	/// does this bench accept books?
	var/accepts_books = TRUE
	tooadvanced = TRUE //technophobes will still need to be able to make ammo	//not anymore they wont

/obj/machinery/autolathe/ammo/attackby(obj/item/O, mob/user, params)
/* 	if(!busy && !stat)
		if(istype(O, /obj/item/storage/bag/casings))
			insert_things_from_bag(user, O)
			return
		if(istype(O, /obj/item/ammo_box))
			if(pre_insert_check(user, O))
				if(insert_bullets_from_box(user, O) == AUTOLATHE_INSERT_CONTAINER_TOO)
					return ..()
			return
		if(istype(O, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/gun_thing = O
			if(!gun_thing.magazine)
				if(!do_after(user, 2 SECONDS, target = src))
					to_chat(user, span_notice("You stop dumping \the [gun_thing] into \the [src]."))
					return
				return ..()
			if(pre_insert_check(user, O))
				insert_magazine_from_gun(user, O)
			return */
	if(panel_open && accepts_books)
		if(!simple && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_one))
			to_chat(user, span_notice("You upgrade [src] with simple ammunition schematics."))
			simple = TRUE
			qdel(O)
			return
		if(!basic && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_two))
			to_chat(user, span_notice("You upgrade [src] with basic ammunition schematics."))
			basic = TRUE
			qdel(O)
			return
		else if(!intermediate && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_three))
			to_chat(user, span_notice("You upgrade [src] with intermediate ammunition schematics."))
			intermediate = TRUE
			qdel(O)
			return
		else if(!advanced && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_four))
			to_chat(user, span_notice("You upgrade [src] with advanced ammunition schematics."))
			advanced = TRUE
			qdel(O)
			return
	return ..()
/* 
/obj/machinery/autolathe/ammo/proc/insert_thing(obj/item/thing, obj/item/thing_bag, datum/component/material_container/mat_box)
	var/mat_amount = mat_box.get_item_material_amount(thing)
	if(!mat_amount)
		return AUTOLATHE_SKIP_INSERTING
	if(!mat_box.has_space(mat_amount))
		return AUTOLATHE_STOP_INSERTING
	if(thing_bag)
		if(!SEND_SIGNAL(thing_bag, COMSIG_TRY_STORAGE_TAKE, thing, src, FALSE, thing.loc, null))
			return AUTOLATHE_SKIP_INSERTING
	// Forgive me for this.
	if(mat_box.after_insert)
		mat_box.after_insert.Invoke(thing, mat_box.last_inserted_id, mat_box.insert_item(thing))
	return AUTOLATHE_INSERT_OK

/obj/machinery/autolathe/ammo/proc/pre_insert_check(mob/user, obj/item/O)
	if(!istype(O))
		return FALSE
	var/obj/item/stuff_holder = O
	if(INTERACTING_WITH(user, src))
		return FALSE
	if(!do_after(user, 2 SECONDS, target = src))
		to_chat(user, span_notice("You stop dumping \the [stuff_holder] into \the [src]."))
		return FALSE
	// if(!length(stuff_holder.contents))
	// 	to_chat(user, span_warning("There's nothing in \the [stuff_holder] to load into \the [src]!"))
	// 	return FALSE
	to_chat(user, span_notice("You start dumping \the [stuff_holder] into \the [src]."))
	return TRUE

/obj/machinery/autolathe/ammo/proc/insert_bullets_from_box(mob/user, obj/item/ammo_box/ammobox)
	if(!user)
		return FALSE
	if(!istype(ammobox))
		return FALSE
	var/datum/component/material_container/mats = GetComponent(/datum/component/material_container)
	var/count = 0
	for(var/obj/item/ammo_casing/casing in ammobox.stored_ammo)
		switch(insert_thing(casing, null, mats))
			if(AUTOLATHE_SKIP_INSERTING)
				continue
			if(AUTOLATHE_STOP_INSERTING)
				to_chat(user, span_warning("You can't fit any more in \the [src]!"))
				return FALSE
		ammobox.stored_ammo -= casing
		qdel(casing)
		count++
		stoplag()
	if(count > 0)
		to_chat(user, span_notice("You insert [count] casing\s into \the [src]."))
	else if(ammobox.stored_ammo)
		to_chat(user, span_warning("There aren't any casings in \the [ammobox] to recycle!"))
	else
		return AUTOLATHE_INSERT_CONTAINER_TOO
	return TRUE

/obj/machinery/autolathe/ammo/proc/insert_magazine_from_gun(mob/user, obj/item/gun/ballistic/gun_thing)
	if(!user)
		return FALSE
	if(!istype(gun_thing))
		return FALSE
	var/datum/component/material_container/mats = GetComponent(/datum/component/material_container)
	if(gun_thing.chambered)
		insert_thing(gun_thing.chambered, null, mats)
		QDEL_NULL(gun_thing.chambered)
	if(!gun_thing.magazine)
		return TRUE // just eat the gun
	var/obj/item/ammo_box/mag = gun_thing.magazine
	insert_bullets_from_box(user, mag)
	if(istype(mag) && mag.fixed_mag)
		return TRUE
	mag.forceMove(get_turf(mag))
	switch(insert_thing(mag, null, mats))
		if(AUTOLATHE_SKIP_INSERTING)
			to_chat(user, span_warning("You can't put that in \the [src]!"))
			return FALSE
		if(AUTOLATHE_STOP_INSERTING)
			to_chat(user, span_warning("You can't fit any more in \the [src]!"))
			return FALSE
	to_chat(user, span_notice("You insert [mag] into \the [src]."))
	QDEL_NULL(gun_thing.magazine)
	return TRUE

/obj/machinery/autolathe/ammo/proc/insert_things_from_bag(mob/user, obj/item/storage/bag/casings/O)
	var/obj/item/storage/bag/casings/casings_bag = O
	var/datum/component/material_container/mats = GetComponent(/datum/component/material_container)
	var/count = 0
	if(INTERACTING_WITH(user, src))
		return
	if(!length(casings_bag.contents))
		to_chat(user, span_warning("There's nothing in \the [casings_bag] to load into \the [src]!"))
		return
	to_chat(user, span_notice("You start dumping \the [casings_bag] into \the [src]."))
	if(!do_after(user, 2 SECONDS, target = src))
		to_chat(user, span_notice("You stop dumping \the [casings_bag] into \the [src]."))
		return
	for(var/obj/item/ammo_casing/casing in casings_bag.contents)
		var/mat_amount = mats.get_item_material_amount(casing)
		if(!mat_amount)
			continue
		if(!mats.has_space(mat_amount))
			to_chat(user, span_warning("You can't fit any more in \the [src]!"))
			return
		if(!SEND_SIGNAL(casings_bag, COMSIG_TRY_STORAGE_TAKE, casing, src, FALSE, casing.loc, null))
			continue
		// Forgive me for this.
		if(mats.after_insert)
			mats.after_insert.Invoke(casing, mats.last_inserted_id, mats.insert_item(casing))
		// I blame whoever wrote material containers.
		qdel(casing)
		count++
		stoplag()
	if(count > 0)
		to_chat(user, span_notice("You insert [count] casing\s into \the [src]."))
	else
		to_chat(user, span_warning("There aren't any casings in \the [O] to recycle!"))
 */
/obj/machinery/autolathe/ammo/can_build(datum/design/D, amount = 1)
	if("Handloaded Ammo" in D.category)
		return ..()
	if("Handmade Magazines" in D.category)
		return ..()
	if("Simple Ammo" in D.category)
		if(simple == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()
	if("Simple Magazines" in D.category)
		if(simple == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()
	if("Basic Ammo" in D.category)
		if(basic == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()
	if("Basic Magazines" in D.category)
		if(basic == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()
	if("Intermediate Ammo" in D.category)
		if(intermediate == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()
	if("Intermediate Magazines" in D.category)
		if(intermediate == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()
	if("Advanced Ammo" in D.category)
		if(advanced == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()
	if("Advanced Magazines" in D.category)
		if(advanced == 0)
			return FALSE
		else
			. = ..()
	else
		. = ..()

/obj/machinery/autolathe/ammo/on_deconstruction()
	..()
	if(simple)
		new /obj/item/book/granter/crafting_recipe/gunsmith_one(src)
	if(basic)
		new /obj/item/book/granter/crafting_recipe/gunsmith_two(src)
	if(intermediate)
		new /obj/item/book/granter/crafting_recipe/gunsmith_three(src)
	if(advanced)
		new /obj/item/book/granter/crafting_recipe/gunsmith_four(src)
	return

/obj/machinery/autolathe/ammo/unlocked_basic
	desc = "A ammo bench where you can make ammo and magazines. Copies of Guns and Ammo, parts one and two, can be found in a drawer."
	simple = 1
	basic = 1

/obj/machinery/autolathe/ammo/unlocked
	simple = 1
	basic = 1
	intermediate = 1
	advanced = 1

/obj/machinery/autolathe/ammo/improvised
	name = "improvised handloader bench"
	icon = 'icons/obj/machines/reloadingbench.dmi'
	desc = "Literally just a handloader bolted to a crate. Takes in metal and blackpowder, and outputs some of the lowest quality ammunition known to mankind."
	icon_state = "ammolathe_improv"
	icon_state_base = "ammolathe_improv"
	icon_state_open = "ammolathe_improv_t"
	icon_state_busy = "ammolathe_improv_n"
	icon_state_loading_metal = "ammolathe_improv_r"
	icon_state_loading_other = "ammolathe_improv_o"
	circuit = /obj/item/circuitboard/machine/autolathe/ammo/improvised
	//stored_research = /datum/techweb/specialized/autounlocking/autolathe/ammo_improvised
	categories = list(
					"Handloaded Ammo",
					"Handmade Magazines",
					"Materials",
					"Simple Magazines"
					)
	allowed_materials = list(
		/datum/material/iron,
		/datum/material/blackpowder)
	accepts_books = FALSE
	tooadvanced = FALSE // ezpz
	/// this thing doesnt use matter bins, which makes this thing not actually have any storage
	var/max_mats = 75000 * 3
	/// Same thing with manipulators, and its lack thereof
	var/default_workspeed = 1
	/// someone made us with wood
	var/wooded = TRUE
	/// someone stuck us into a machine frame for some reason
	var/framed = TRUE
	/// weakref to our table, so we can unregister signals
	var/datum/weakref/mytable
	/// you can deconstruct it if you use any of these on it
	var/list/decon_tools = list(
		TOOL_CROWBAR,
		TOOL_MULTITOOL,
		TOOL_SCREWDRIVER,
		TOOL_WIRECUTTER,
		TOOL_WRENCH,
		TOOL_WELDER,
		TOOL_SHOVEL,
		TOOL_DRILL,
	)

/obj/machinery/autolathe/ammo/improvised/Initialize()
	var/obj/structure/table/T = locate(/obj/structure/table) in get_turf(src)
	if(T)
		tableize(T)
	. = ..()

/obj/machinery/autolathe/ammo/improvised/Destroy()
	var/obj/structure/table/T = GET_WEAKREF(mytable)
	if(T)
		UnregisterSignal(T, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_OBJ_BREAK, COMSIG_PARENT_PREQDELETED))
		mytable = null
	. = ..()

/obj/machinery/autolathe/ammo/improvised/examine(mob/user)
	. += ..()
	. += span_notice("You can disassemble this thing by [span_notice("Ctrl-Shift Clicking")] it, or using just about any [span_notice("tool")] on it.")

/obj/machinery/autolathe/ammo/improvised/proc/tableize(obj/structure/table/T)
	icon_state_base = "autolathe_tabletop"
	icon_state_open = "autolathe_tabletop_t"
	icon_state_busy = "autolathe_tabletop_n"
	icon_state_loading_metal = "autolathe_tabletop_r"
	icon_state_loading_other = "autolathe_tabletop_o"
	icon_state = icon_state_base
	wooded = FALSE
	framed = FALSE
	RegisterSignal(T, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_OBJ_BREAK, COMSIG_PARENT_PREQDELETED),PROC_REF(self_destruct))

/obj/machinery/autolathe/ammo/improvised/proc/self_destruct(disassembled)
	var/obj/structure/table/T = GET_WEAKREF(mytable)
	if(T)
		UnregisterSignal(T, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_OBJ_BREAK, COMSIG_PARENT_PREQDELETED))
		mytable = null
	deconstruct(disassembled)

/obj/machinery/autolathe/ammo/improvised/CtrlShiftClick(mob/user)
	. = ..()
	take_it_apart(user)

/obj/machinery/autolathe/ammo/improvised/attackby(obj/item/O, mob/user, params)
	if(O.tool_behaviour in decon_tools)
		take_it_apart(user)
		return
	return ..()

/obj/machinery/autolathe/ammo/improvised/proc/take_it_apart(mob/user)
	if(!user)
		return
	if(!user.Adjacent(src))
		return
	if(!do_after(user, 2 SECONDS, TRUE, src, allow_movement = TRUE))
		to_chat(user, span_notice("You stop taking apart \the [src]."))
		return
	to_chat(user, span_notice("You take apart \the [src]!"))
	self_destruct(TRUE)

/obj/machinery/autolathe/ammo/improvised/deconstruct(disassembled = TRUE)
	if(framed)
		return ..()
	on_deconstruction()
	if(wooded)
		new /obj/item/stack/sheet/mineral/wood/three(get_turf(src))
	new /obj/item/circuitboard/machine/autolathe/ammo/improvised(get_turf(src))
	qdel(src)

/obj/machinery/autolathe/ammo/improvised/RefreshParts()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.max_amount = max_mats
	prod_coeff = STANDARD_PART_LEVEL_LATHE_COEFFICIENT(default_workspeed)

/datum/autolathe_loop_returns
	/// FORMAT: list(/obj/item/eaten = 3)
	var/list/paths_inserted = list()
	/// FORMAT: list("/obj/item/eaten" = 3)
	var/list/things_inserted = list()
	/// total mats inserted
	/// FORMAT: list("/datum/material/iron" = 3)
	var/list/total_mats = list()
	var/min_to_print = 30

/datum/autolathe_loop_returns/proc/inserted_something(obj/item/thing)
	if(!istype(thing))
		return
	if(!things_inserted["[thing]"])
		things_inserted["[thing]"] = 0
	things_inserted["[thing]"] += 1
	if(!paths_inserted[thing.type])
		paths_inserted[thing.type] = 0
	if(ispath(thing, /obj/item/stack))
		var/obj/item/stack/stk = thing
		paths_inserted[thing.type] += stk.amount
	else
		paths_inserted[thing.type] += 1
	for(var/mat in thing.custom_materials)
		if(!total_mats["[mat]"])
			total_mats["[mat]"] = 0
		total_mats["[mat]"] += thing.custom_materials[mat]

/datum/autolathe_loop_returns/proc/should_output_report(obj/machinery/autolathe/lathe)
	var/stuff_recycled = 0
	for(var/thing in things_inserted)
		stuff_recycled += things_inserted[thing]
	if(stuff_recycled > min_to_print)
		return TRUE

/datum/autolathe_loop_returns/proc/output_report(obj/machinery/autolathe/lathe)
	var/obj/item/paper/report_card/our_paper = new(get_turf(lathe))
	if(!our_paper)
		return FALSE
	GLOB.lathe_reports_done += 1
	our_paper.name = "recycling report card #[GLOB.lathe_reports_done]"
	var/mrs_heavybottoms_english_class_parent_teacher_conference = get_grade()
	our_paper.grade = mrs_heavybottoms_english_class_parent_teacher_conference || "F"
	our_paper.info = write_contents(mrs_heavybottoms_english_class_parent_teacher_conference)
	our_paper.update_icon_state()
	var/list/ppl = list()
	for(var/mob/m in view(15, get_turf(lathe)))
		ppl += m
	var/mob/M
	if(LAZYLEN(ppl))
		M = pick(ppl)
	if(M)
		our_paper.throw_at(M, 100, 1, M, TRUE)
	else
		bingus:
			for(var/turf/T in oview(2, get_turf(lathe)))
				for(var/atom/movable/thing in T.contents)
					if(thing.density)
						continue bingus
				our_paper.throw_at(T, 100, 1, null, TRUE)

/datum/autolathe_loop_returns/proc/get_grade()
	var/stuff_recycled = 0
	for(var/thing in paths_inserted)
		var/numof = paths_inserted[thing]
		if(!isnum(numof) || !isfinite(numof))
			continue
		if(ispath(thing, /obj/item/ammo_casing))
			if(ispath(thing, /obj/item/ammo_casing/caseless/rocket))
				numof *= 5
			else if(ispath(thing, /obj/item/ammo_casing/a40mm))
				numof *= 4
		else if(ispath(thing, /obj/item/stack))
			numof *= 0.25 // so you cant just take stuff out and put it back in
		var/obj/item/thingy = thing
		var/toolspeed = initial(thingy.toolspeed)
		if(toolspeed)
			numof /= max(toolspeed, 0.00001)
		stuff_recycled += numof
	stuff_recycled = max(stuff_recycled, 1)
	var/score = 0
	var/cool_mean = floor(abs(sqrt(abs(stuff_recycled) ** 1.1) ** 0.975))
	var/cool_sd = sqrt(abs(cool_mean))
	score = gaussian(cool_mean, cool_sd)
	score = rand(score, gaussian(score, sqrt(abs(score))))
	score = floor(score + rand(score*0.5, score*3))
	score = abs(score)
	if((world.time % 60) > 57)
		score *= 5 // good luck!
	else
		var/a_square = sqrt(abs(score))
		for(var/i in 1 to 100) // computers are good at math, right?
			a_square += sqrt(abs(a_square))
		score += sqrt(abs(a_square))
	score = round(score)
	switch(score)
		if(-INFINITY to 0)
			return "F"
		if(0 to 50)
			return "D"
		if(50 to 70)
			return "D+"
		if(70 to 80)
			return "C-"
		if(80 to 90)
			return "C"
		if(90 to 120)
			return "C+"
		if(120 to 175)
			return "B-"
		if(175 to 250)
			return "B"
		if(250 to 350)
			return "B+"
		if(350 to 500)
			return "A-"
		if(500 to 750)
			return "A"
		if(750 to 1000)
			return "A+"
		if(1000 to 1500)
			return "S"
		else
			return "P"


/datum/autolathe_loop_returns/proc/write_contents(final_grade)
	var/list/msg_out = list()
	msg_out += "<hr><br>"
	msg_out += "[span_small(uppertext(STATION_TIME_TIMESTAMP(FALSE, world.time)))]<br>"
	msg_out += "<hr><br>"
	msg_out += "<center>- START REPORT -</center><br>"
	msg_out += "<center><u><b>GekkerTek MicroFactory DELUX v1.23 PRO</b></u></center><br>"
	msg_out += "Recycle batch process ID:[GLOB.lathe_reports_done]<br>"
	msg_out += "<br>"
	msg_out += "Well done! You recycled:<br>"
	for(var/thing in things_inserted)
		msg_out += "[FOURSPACES][thing] x [things_inserted[thing]]<br>"
	msg_out += "<br>For a total of:<br>"
	for(var/mat in total_mats)
		var/datum/material/matty = SSmaterials.GetMaterialRef(mat)
		if(!matty)
			continue
		msg_out += "[FOURSPACES][matty] x [total_mats[mat]] units<br>"
	msg_out += "<br>"
	msg_out += "Please keep this report for your records.<br>"
	msg_out += "<br>"
	msg_out += "Thank you for choosing GekkerTek, Nash's favorite brand of fox-made machinery!<br>"
	msg_out += "<br>"
	msg_out += "Final grade: <b><u>[final_grade]</u></b><br>"
	if((final_grade in list("F", "D", "D+")))
		msg_out += "<b>See me after class.</b><br>"
	msg_out += "<center>- END REPORT CARD -</center><br>"
	msg_out += "<hr><br>"
	return msg_out.Join()


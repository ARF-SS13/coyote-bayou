#define AUTOLATHE_MAIN_MENU       1
#define AUTOLATHE_CATEGORY_MENU   2
#define AUTOLATHE_SEARCH_MENU     3
#define AUTOLATHE_STOP_INSERTING "KILL"
#define AUTOLATHE_SKIP_INSERTING FALSE
#define AUTOLATHE_INSERT_OK TRUE

/obj/machinery/autolathe
	name = "autolathe"
	desc = "It produces items using metal and glass."
	icon_state = "autolathe"
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
	var/list/mats = allowed_materials
	if(!mats)
		mats = SSmaterials.materialtypes_by_category[MAT_CATEGORY_RIGID]
	AddComponent(/datum/component/material_container, mats, _show_on_examine=TRUE, _after_insert=CALLBACK(src, .proc/AfterMaterialInsert))
	. = ..()
	wires = new /datum/wires/autolathe(src)
	stored_research = new stored_research
	matching_designs = list()

/obj/machinery/autolathe/Destroy()
	QDEL_NULL(wires)
	return ..()

/obj/machinery/autolathe/ui_interact(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(tooadvanced == TRUE)
			if(HAS_TRAIT(L, TRAIT_TECHNOPHOBE)) //can be done to make better autolathes, L
				to_chat(user, span_warning("The array of simplistic button pressing confuses you. Besides, did you really want to spend all day staring at a screen?"))
				return FALSE
			else
				. = ..()
		else
			. = ..()

	if(!is_operational())
		return

	if(shocked && !(stat & NOPOWER))
		shock(user,50)

	var/dat

	switch(screen)
		if(AUTOLATHE_MAIN_MENU)
			dat = main_win(user)
		if(AUTOLATHE_CATEGORY_MENU)
			dat = category_win(user,selected_category)
		if(AUTOLATHE_SEARCH_MENU)
			dat = search_win(user)

	var/datum/browser/popup = new(user, name, name, 400, 500)
	popup.set_content(dat)
	popup.open()

/obj/machinery/autolathe/on_deconstruction()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.retrieve_all()

/obj/machinery/autolathe/attackby(obj/item/O, mob/user, params)
	if(busy)
		to_chat(user, "<span class=\"alert\">The autolathe is busy. Please wait for completion of previous operation.</span>")
		return TRUE

	if(default_deconstruction_screwdriver(user, "autolathe_t", "autolathe", O))
		updateUsrDialog()
		return TRUE

	if(default_deconstruction_crowbar(O))
		return TRUE

	if(panel_open && is_wire_tool(O))
		wires.interact(user)
		return TRUE

	if(user.a_intent == INTENT_HARM) //so we can hit the machine
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

	return ..()

/obj/machinery/autolathe/proc/AfterMaterialInsert(obj/item/item_inserted, id_inserted, amount_inserted)
	if(istype(item_inserted, /obj/item/stack/ore/bluespace_crystal))
		use_power(MINERAL_MATERIAL_AMOUNT / 10)
	else if(item_inserted.custom_materials?.len && item_inserted.custom_materials[SSmaterials.GetMaterialRef(/datum/material/glass)])
		flick("autolathe_r",src)//plays glass insertion animation by default otherwise
	else
		flick("autolathe_o",src)//plays metal insertion animation

		use_power(min(1000, amount_inserted / 100))
	updateUsrDialog()

/obj/machinery/autolathe/Topic(href, href_list)
	if(..())
		return
	if (!busy)
		if(href_list["menu"])
			screen = text2num(href_list["menu"])
			updateUsrDialog()

		if(href_list["category"])
			selected_category = href_list["category"]
			updateUsrDialog()

		if(href_list["make"])

			/////////////////
			//href protection
			being_built = stored_research.isDesignResearchedID(href_list["make"])
			if(!being_built)
				return

			var/multiplier = text2num(href_list["multiplier"])
			if(!multiplier || !IS_FINITE(multiplier))
				stack_trace("Invalid multiplier value in stack creation [multiplier], [usr] is likely attempting an exploit")
				return
			var/is_stack = ispath(being_built.build_path, /obj/item/stack)

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

					used_material = input("Choose [used_material]", "Custom Material") as null|anything in list_to_show
					if(!used_material)
						return //Didn't pick any material, so you can't build shit either.
					custom_materials[used_material] += amount_needed

				materials_used[used_material] = amount_needed

			if(materials.has_materials(materials_used))
				busy = TRUE
				use_power(power)
				icon_state = "[icon_state]_n"
				var/time = is_stack ? 10 : base_print_speed * coeff * multiplier
				addtimer(CALLBACK(src, .proc/make_item, power, materials_used, custom_materials, multiplier, coeff, is_stack), time)
			else
				to_chat(usr, "<span class=\"alert\">Not enough materials for this operation.</span>")

		if(href_list["search"])
			matching_designs.Cut()

			for(var/v in stored_research.researched_designs)
				var/datum/design/D = SSresearch.techweb_design_by_id(v)
				if(findtext(D.name,href_list["to_search"]))
					matching_designs.Add(D)
			updateUsrDialog()
	else
		to_chat(usr, "<span class=\"alert\">The autolathe is busy. Please wait for completion of previous operation.</span>")

	updateUsrDialog()

	return

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
		for(var/i=1, i<=multiplier, i++)
			var/obj/item/new_item = new being_built.build_path(A)
			new_item.autolathe_crafted(src)

			if(length(picked_materials))
				new_item.set_custom_materials(picked_materials, 1 / multiplier) //Ensure we get the non multiplied amount

	icon_state = "autolathe"
	busy = FALSE
	updateDialog()

/obj/machinery/autolathe/RefreshParts()
	var/T = 0
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		T += MB.rating*75000
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.max_amount = T
	var/manips = 0
	var/total_manip_rating = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		total_manip_rating += M.rating
		manips++
	prod_coeff = STANDARD_PART_LEVEL_LATHE_COEFFICIENT(total_manip_rating / (manips? manips : 1))

/obj/machinery/autolathe/examine(mob/user)
	. += ..()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>The status display reads: Storing up to <b>[materials.max_amount]</b> material units.<br>Material consumption at <b>[prod_coeff*100]%</b>.</span>"

/obj/machinery/autolathe/proc/main_win(mob/user)
	var/dat = "<div class='statusDisplay'><h3>Autolathe Menu:</h3><br>"
	dat += materials_printout()

	dat += "<form name='search' action='?src=[REF(src)]'>\
	<input type='hidden' name='src' value='[REF(src)]'>\
	<input type='hidden' name='search' value='to_search'>\
	<input type='hidden' name='menu' value='[AUTOLATHE_SEARCH_MENU]'>\
	<input type='text' name='to_search'>\
	<input type='submit' value='Search'>\
	</form><hr>"

	var/line_length = 1
	dat += "<table style='width:100%' align='center'><tr>"

	for(var/C in categories)
		if(line_length > 2)
			dat += "</tr><tr>"
			line_length = 1

		dat += "<td><A href='?src=[REF(src)];category=[C];menu=[AUTOLATHE_CATEGORY_MENU]'>[C]</A></td>"
		line_length++

	dat += "</tr></table></div>"
	return dat

/obj/machinery/autolathe/proc/category_win(mob/user,selected_category)
	var/dat = "<A href='?src=[REF(src)];menu=[AUTOLATHE_MAIN_MENU]'>Return to main menu</A>"
	dat += "<div class='statusDisplay'><h3>Browsing [selected_category]:</h3><br>"
	dat += materials_printout()

	for(var/v in stored_research.researched_designs)
		var/datum/design/D = SSresearch.techweb_design_by_id(v)
		if(!(selected_category in D.category))
			continue

		if(disabled || !can_build(D))
			dat += span_linkOff("[D.name]")
		else
			dat += "<a href='?src=[REF(src)];make=[D.id];multiplier=1'>[D.name]</a>"

		if(ispath(D.build_path, /obj/item/stack))
			var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
			var/max_multiplier
			for(var/datum/material/mat in D.materials)
				max_multiplier = min(D.maxstack, round(materials.get_material_amount(mat)/D.materials[mat]))
			if (max_multiplier>10 && !disabled)
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=10'>x10</a>"
			if (max_multiplier>25 && !disabled)
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=25'>x25</a>"
			if(max_multiplier > 0 && !disabled)
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=[max_multiplier]'>x[max_multiplier]</a>"
		else
			if(!disabled && can_build(D, 5))
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=5'>x5</a>"
			if(!disabled && can_build(D, 10))
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=10'>x10</a>"

		dat += "[get_design_cost(D)]<br>"

	dat += "</div>"
	return dat

/obj/machinery/autolathe/proc/search_win(mob/user)
	var/dat = "<A href='?src=[REF(src)];menu=[AUTOLATHE_MAIN_MENU]'>Return to main menu</A>"
	dat += "<div class='statusDisplay'><h3>Search results:</h3><br>"
	dat += materials_printout()

	for(var/v in matching_designs)
		var/datum/design/D = v
		if(disabled || !can_build(D))
			dat += span_linkOff("[D.name]")
		else
			dat += "<a href='?src=[REF(src)];make=[D.id];multiplier=1'>[D.name]</a>"

		if(ispath(D.build_path, /obj/item/stack))
			var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
			var/max_multiplier
			for(var/datum/material/mat in D.materials)
				max_multiplier = min(D.maxstack, round(materials.get_material_amount(mat)/D.materials[mat]))
			if (max_multiplier>10 && !disabled)
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=10'>x10</a>"
			if (max_multiplier>25 && !disabled)
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=25'>x25</a>"
			if(max_multiplier > 0 && !disabled)
				dat += " <a href='?src=[REF(src)];make=[D.id];multiplier=[max_multiplier]'>x[max_multiplier]</a>"

		dat += "[get_design_cost(D)]<br>"

	dat += "</div>"
	return dat

/obj/machinery/autolathe/proc/materials_printout()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/dat = "<b>Total amount:</b> [materials.total_amount] / [materials.max_amount] cm<sup>3</sup><br>"
	for(var/mat_id in materials.materials)
		var/datum/material/M = mat_id
		var/mineral_amount = materials.materials[mat_id]
		if(mineral_amount > 0)
			dat += "<b>[M.name] amount:</b> [mineral_amount] cm<sup>3</sup><br>"
	return dat

/obj/machinery/autolathe/proc/can_build(datum/design/D, amount = 1)
	if(D.make_reagents.len)
		return FALSE

	var/coeff = (ispath(D.build_path, /obj/item/stack) ? 1 : prod_coeff)

	var/list/required_materials = list()

	for(var/i in D.materials)
		required_materials[i] = D.materials[i] * coeff * amount

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

	return materials.has_materials(required_materials)

/obj/machinery/autolathe/proc/get_design_cost(datum/design/D)
	var/coeff = (ispath(D.build_path, /obj/item/stack) ? 1 : prod_coeff)
	var/dat
	for(var/i in D.materials)
		if(istext(i)) //Category handling
			dat += "[D.materials[i] * coeff] [i]"
		else
			var/datum/material/M = i
			dat += "[D.materials[i] * coeff] [M.name] "
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

/obj/machinery/autolathe/hacked/Initialize()
	. = ..()
	adjust_hacked(TRUE)

/obj/machinery/autolathe/secure
	name = "secured autolathe"
	desc = "It produces items using metal and glass. This model was reprogrammed without some of the more hazardous designs."
	circuit = /obj/item/circuitboard/machine/autolathe/secure
	stored_research = /datum/techweb/specialized/autounlocking/autolathe/public
	base_print_speed = 20

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

/*
/obj/machinery/autolathe/constructionlathe/attackby(obj/item/O, mob/user, params)
	..()
	if(DRM && panel_open)
		if(constage == 0)
			if(istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_four))
				to_chat(user, span_notice("You upgrade [src] with ammunition schematics. You'll still need to bypass the DRM with some high-quality metal parts."))
				constage = 1
				qdel(O)
		if(constage == 1)
			if(istype(O, /obj/item/stack/crafting/goodparts))
				var/obj/item/stack/crafting/goodparts/S = O
				if(S.get_amount() < 5)
					to_chat(user, span_warning("You need at least 5 high-quality metal parts to upgrade [src]."))
					return
				S.use(5)
				to_chat(user, span_notice("You upgrade [src] to bypass the DRM. You'll still need to install a makeshift reloader to finish the process."))
				constage = 2
		if(constage == 2)
			if(istype(O, /obj/item/circuitboard/machine/autolathe/ammo/improvised))
				to_chat(user, span_notice("You upgrade [src] with a makeshift reloader, allowing it to finally produce ammunition again."))
				constage = 3
				DRM = 0
				categories = list(
							"Tools",
							"Electronics",
							"Construction",
							"T-Comm",
							"Security",
							"Machinery",
							"Medical",
							"Misc",
							"Dinnerware",
							)
				hacked = TRUE
				name = "Workshop"
				desc = "Contains an array of custom made and skilled tools for professional craftsmen."
				qdel(O)
	if(panel_open)
		default_deconstruction_crowbar(O)
		return TRUE
	else
		attack_hand(user)
		return TRUE


/obj/machinery/autolathe/constructionlathe/can_build(datum/design/D, amount = 1)
	if("Security" in D.category)
		if(DRM == 1)
			return FALSE
		else
			. = ..()
	else
		. = ..()

/obj/machinery/autolathe/ui_interact(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(L.has_trait(TRAIT_TECHNOPHOBE, TRAIT_GENERIC))
			to_chat(user, span_warning("The array of simplistic button pressing confuses you. Besides, did you really want to spend all day staring at a screen?"))
			return FALSE
		else
			. = ..()
*/

/obj/machinery/autolathe/ammo
	name = "reloading bench"
	icon = 'icons/obj/machines/reloadingbench.dmi'
	desc = "An ammo bench that utilizes metal and other materials to make ammo and magazines."
	circuit = /obj/item/circuitboard/machine/autolathe/ammo
	stored_research = /datum/techweb/specialized/autounlocking/autolathe/ammo
	categories = list(
					"Handloaded Ammo",
					"Handmade Magazines",
					"Simple Ammo",
					"Simple Magazines",
					"Basic Ammo",
					"Basic Magazines",
					"Intermediate Ammo",
					"Intermediate Magazines",
					"Advanced Ammo",
					"Advanced Magazines",
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
	if(!busy && !stat)
		if(istype(O, /obj/item/storage/bag/casings))
			insert_things_from_bag(user, O)
			return
		if(istype(O, /obj/item/ammo_box))
			if(pre_insert_check(user, O))
				if(!insert_bullets_from_box(user, O))
					return
		if(istype(O, /obj/item/gun/ballistic))
			if(pre_insert_check(user, O))
				if(!insert_magazine_from_gun(user, O))
					return
	if(panel_open && accepts_books)
		if(!simple && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_one))
			to_chat(user, "<span class='notice'>You upgrade [src] with simple ammunition schematics.</span>")
			simple = TRUE
			qdel(O)
			return
		if(!basic && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_two))
			to_chat(user, "<span class='notice'>You upgrade [src] with basic ammunition schematics.</span>")
			basic = TRUE
			qdel(O)
			return
		else if(!intermediate && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_three))
			to_chat(user, "<span class='notice'>You upgrade [src] with intermediate ammunition schematics.</span>")
			intermediate = TRUE
			qdel(O)
			return
		else if(!advanced && istype(O, /obj/item/book/granter/crafting_recipe/gunsmith_four))
			to_chat(user, "<span class='notice'>You upgrade [src] with advanced ammunition schematics.</span>")
			advanced = TRUE
			qdel(O)
			return
	return ..()

/obj/machinery/autolathe/ammo/proc/insert_thing(obj/item/thing, obj/item/thing_bag, datum/component/material_container/mat_box)
	var/mat_amount = mat_box.get_item_material_amount(thing)
	if(!mat_amount)
		return AUTOLATHE_SKIP_INSERTING
	if(!mat_box.has_space(mat_amount))
		return AUTOLATHE_STOP_INSERTING
	if(thing_bag)
		if(!SEND_SIGNAL(thing_bag, COMSIG_TRY_STORAGE_TAKE, thing, src))
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
	if(!length(stuff_holder.contents))
		to_chat(user, span_warning("There's nothing in \the [stuff_holder] to load into \the [src]!"))
		return FALSE
	to_chat(user, span_notice("You start dumping \the [stuff_holder] into \the [src]."))
	if(!do_after(user, 2 SECONDS, target = src))
		to_chat(user, span_notice("You stop dumping \the [stuff_holder] into \the [src]."))
		return FALSE
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
	if(count > 0)
		to_chat(user, span_notice("You insert [count] casing\s into \the [src]."))
	else
		to_chat(user, span_warning("There aren't any casings in \the [ammobox] to recycle!"))
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
		if(!SEND_SIGNAL(casings_bag, COMSIG_TRY_STORAGE_TAKE, casing, src))
			continue
		// Forgive me for this.
		if(mats.after_insert)
			mats.after_insert.Invoke(casing, mats.last_inserted_id, mats.insert_item(casing))
		// I blame whoever wrote material containers.
		qdel(casing)
		count++
	if(count > 0)
		to_chat(user, span_notice("You insert [count] casing\s into \the [src]."))
	else
		to_chat(user, span_warning("There aren't any casings in \the [O] to recycle!"))

/// no discounts for sticky fingers!
/obj/machinery/autolathe/ammo/get_design_cost(datum/design/D)
	var/dat
	for(var/i in D.materials)
		if(istext(i)) //Category handling
			dat += "[D.materials[i]] [i]"
		else
			var/datum/material/M = i
			dat += "[D.materials[i]] [M.name] "
	return dat

/obj/machinery/autolathe/ammo/can_build(datum/design/D, amount = 1)
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
	circuit = /obj/item/circuitboard/machine/autolathe/ammo/improvised
	//stored_research = /datum/techweb/specialized/autounlocking/autolathe/ammo_improvised
	categories = list(
					"Handloaded Ammo",
					"Handmade Magazines",
					"Materials"
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

/obj/machinery/autolathe/ammo/improvised/RefreshParts()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.max_amount = max_mats
	prod_coeff = STANDARD_PART_LEVEL_LATHE_COEFFICIENT(default_workspeed)


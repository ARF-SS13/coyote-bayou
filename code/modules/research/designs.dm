/***************************************************************
**						Design Datums						  **
**	All the data for building stuff.						  **
***************************************************************/
/*
For the materials datum, it assumes you need reagents unless specified otherwise. To designate a material that isn't a reagent,
you use one of the material IDs below. These are NOT ids in the usual sense (they aren't defined in the object or part of a datum),
they are simply references used as part of a "has materials?" type proc. They all start with a $ to denote that they aren't reagents.
The currently supporting non-reagent materials. All material amounts are set as the define MINERAL_MATERIAL_AMOUNT, which defaults to 2000

Don't add new keyword/IDs if they are made from an existing one (such as rods which are made from metal). Only add raw materials.

Design Guidelines
- When adding new designs, check rdreadme.dm to see what kind of things have already been made and where new stuff is needed.
- A single sheet of anything is 2000 units of material. Materials besides metal/glass require help from other jobs (mining for
other types of metals and chemistry for reagents).
- Add the AUTOLATHE tag to
*/

//DESIGNS ARE GLOBAL. DO NOT CREATE OR DESTROY THEM AT RUNTIME OUTSIDE OF INIT, JUST REFERENCE THEM TO WHATEVER YOU'RE DOING! //why are you yelling?
//DO NOT REFERENCE OUTSIDE OF SSRESEARCH. USE THE PROCS IN SSRESEARCH TO OBTAIN A REFERENCE.

/datum/design						//Datum for object designs, used in construction
	var/name = "Name"					//Name of the created object.
	var/desc = "Desc"					//Description of the created object.
	var/id = DESIGN_ID_IGNORE						//ID of the created object for easy refernece. Alphanumeric, lower-case, no symbols
	var/build_type = null				//Flag as to what kind machine the design is built in. See defines.
	var/list/materials = list()			//List of materials. Format: "id" = amount.
	var/construction_time				//Amount of time required for building the object
	var/build_path = null				//The file path of the object that gets created
	var/list/make_reagents = list()			//Reagents produced. Format: type = amount. Currently only supported by the biogenerator.
	var/list/category = null 			//Primarily used for Mech Fabricators, but can be used for anything
	var/list/reagents_list = list()			//List of reagents. Format: type = amount.
	var/maxstack = 1
	var/lathe_time_factor = 1			//How many times faster than normal is this to build on the protolathe
	var/dangerous_construction = FALSE	//notify and log for admin investigations if this is printed.
	var/departmental_flags = ALL			//bitflags for deplathes.
	var/list/datum/techweb_node/unlocked_by = list()
	///minimum and security levels the design can be printed on. Currently only available for rnd production machinery and mechfab.
	var/min_security_level = SEC_LEVEL_GREEN
	var/max_security_level = SEC_LEVEL_DELTA
	var/research_icon					//Replaces the item icon in the research console
	var/research_icon_state
	var/icon_cache
	/// Checks if the material price is less than that of what it gives back, and then adds some if so
	/// Spams the chat with bullshit if so, its a debugging tool~
	var/debug_materials = FALSE

	var/autocalc_materials = FALSE		//If true, the materials list will be automatically calculated from the build_path (and whtever stuff is in the design)

/datum/design/error_design
	name = "ERROR"
	desc = "This usually means something in the database has corrupted. If this doesn't go away automatically, inform Central Command so their techs can fix this ASAP(tm)"

/datum/design/Destroy()
	SSresearch.techweb_designs -= id
	return ..()

/datum/design/proc/InitializeMaterials()
	if(debug_materials) // probably doesnt work
		material_cost_autobalance()
	if(autocalc_materials)
		AutocalcMaterialCosts()
	var/list/temp_list = list()
	for(var/i in materials) //Go through all of our materials, get the subsystem instance, and then replace the list.
		var/amount = materials[i]
		if(!istext(i)) //Not a category, so get the ref the normal way
			var/datum/material/M =  SSmaterials.GetMaterialRef(i)
			temp_list[M] = amount
		else
			temp_list[i] = amount
	materials = temp_list

/// spawns the thing, pulls out all the stuff inside it, tallies up the materials it is, and then does some math to set the cost
/datum/design/proc/AutocalcMaterialCosts()
	if(!autocalc_materials)
		return
	if(!ispath(build_path, /obj/item)) // currently only supports items
		return // its fiiiiiine
	var/obj/item/thing = new build_path()
	if(!thing) // Something went wrong, so lets bail
		return
	var/list/all_things = list()
	var/list/to_check = list(thing)
	while(LAZYLEN(to_check))
		var/obj/item/this_thing = to_check[1]
		to_check -= this_thing
		if(!isitem(this_thing)) // not an item, skipping
			continue
		all_things += this_thing
		for(var/i in this_thing.contents) // mommy finger, mommy finger, where are you?
			to_check += i // here i am, here i am, how do you do?
	if(LAZYLEN(all_things)) // daddy finger, daddy finger, where are you?
		return // here i am, here i am, how do you do?
	var/list/design_materials = list() // grandpa finger, grandpa finger, where are you?
	for(var/obj/item/this_thing in all_things) // here i am, here i am, how do you do?
		counterlist_combine(design_materials, this_thing.custom_materials) // garbage collector, garbage collector, where are you?
	QDEL_LIST(all_things) // here i am, here i am, go away
	counterlist_scale(design_materials, SSresearch.autocalc_mult) // how do you do?
	if(LAZYLEN(design_materials)) // very well, i thank you
		materials = design_materials // baby shark, doo doo doo doo doo doo doo
	/// heres a cute shark: <(OvO)>

/datum/design/proc/material_cost_autobalance()
	if(ispath(build_path, /obj/item/ammo_box))
		var/list/design_materials = list()
		var/obj/item/ammo_box/this_box = new build_path()
		counterlist_combine(design_materials, this_box.custom_materials) // box materials
		if(!ispath(this_box.ammo_type, /obj/item/ammo_casing))
			qdel(this_box)
			analyze_cost_findings(design_materials)
			return
		var/obj/item/ammo_casing/this_bullet = new this_box.ammo_type()
		var/list/bullet_materials = this_bullet.custom_materials
		bullet_materials = counterlist_scale(bullet_materials, this_box.max_ammo)
		counterlist_combine(design_materials, bullet_materials) // add ammo materials
		qdel(this_box)
		qdel(this_bullet)
		analyze_cost_findings(design_materials)

/datum/design/proc/analyze_cost_findings(list/result_materials)
	if(!LAZYLEN(result_materials))
		return
	var/list/whine_about_it = list()
	for(var/returned_mats in result_materials)
		if(result_materials[returned_mats] >= materials[returned_mats])
			whine_about_it["[returned_mats]"] = list(
				"material" = returned_mats,
				"design_cost" = materials[returned_mats],
				"mats_returned" = result_materials[returned_mats]
			)
	if(LAZYLEN(whine_about_it))
		actually_whine_about_it(whine_about_it)

/datum/design/proc/actually_whine_about_it(list/whine_list)
	if(!LAZYLEN(whine_list))
		return
	message_admins(span_abductor("Heads up, nerds!") + " Ammolathe design '[src]' returns more materials than it costs!")
	for(var/i in whine_list)
		var/list/whine_sublist = whine_list[i]
		var/name_of_mat = whine_sublist["material"]
		var/cost_of_design = whine_sublist["design_cost"]
		var/materials_returned = whine_sublist["mats_returned"]
		var/suggested_amount_of_mat = materials_returned * 1.50
		message_admins("[src] - [name_of_mat]: costs [cost_of_design], but returns [materials_returned] if reinserted. Suggested mat cost: [suggested_amount_of_mat]")


/datum/design/proc/get_asset_path()
	if(research_icon && research_icon_state)
		return "[research_icon]-[research_icon_state]"
	var/atom/item = initial(build_path)
	if (!ispath(item, /atom))
		// biogenerator outputs to beakers by default
		if (initial(build_type) & BIOGENERATOR)
			item = /obj/item/reagent_containers/glass/beaker/large
		else
			CRASH("Invalid path and build type for [src]")  // shouldn't happen, but just in case

	// circuit boards become their resulting machines or computers
	if (ispath(item, /obj/item/circuitboard))
		var/obj/item/circuitboard/C = item
		var/machine = initial(C.build_path)
		if (machine)
			item = machine
	var/icon_file = "[initial(item.icon)]"
	var/icon_string = "[sanitize_filename(replacetext(icon_file, ".dmi", ""))]-[initial(item.icon_state)]"
	// computers (and snowflakes) get their screen and keyboard sprites
	if (ispath(item, /obj/machinery/computer) || ispath(item, /obj/machinery/power/solar_control))
		var/obj/machinery/computer/C = item
		var/screen = initial(C.icon_screen)
		var/keyboard = initial(C.icon_keyboard)
		icon_string += "-[screen]"
		icon_string += "-[keyboard]"
	return icon_string

/datum/design/proc/icon_html(client/user)
	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/research_designs)
	sheet.send(user)
	return sheet.icon_tag(get_asset_path())

////////////////////////////////////////
//Disks for transporting design datums//
////////////////////////////////////////

/obj/item/disk/design_disk
	name = "Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes."
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=300, /datum/material/glass=100)
	var/list/blueprints = list()
	var/max_blueprints = 1

/obj/item/disk/design_disk/Initialize()
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)
	for(var/i in 1 to max_blueprints)
		blueprints += null

/obj/item/disk/design_disk/adv
	name = "Advanced Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes. This one has extra storage space."
	custom_materials = list(/datum/material/iron=300, /datum/material/glass=100, /datum/material/silver = 50)
	max_blueprints = 5

//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/make_datum_references_lists()
	//hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/hair, GLOB.hair_styles_list, GLOB.hair_styles_male_list, GLOB.hair_styles_female_list)
	//facial hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/facial_hair, GLOB.facial_hair_styles_list, GLOB.facial_hair_styles_male_list, GLOB.facial_hair_styles_female_list)
	//underwear
	init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear/bottom, GLOB.underwear_list, GLOB.underwear_m, GLOB.underwear_f)
	//undershirt
	init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear/top, GLOB.undershirt_list, GLOB.undershirt_m, GLOB.undershirt_f)
	//socks
	init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear/socks, GLOB.socks_list)
	//bodypart accessories (blizzard intensifies)


//CIT CHANGES START HERE, ADDS SNOWFLAKE BODYPARTS AND MORE

	//genitals
	init_sprite_accessory_subtypes(/datum/sprite_accessory/penis, GLOB.cock_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/vagina, GLOB.vagina_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/breasts, GLOB.breasts_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/butt, GLOB.butt_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/belly, GLOB.belly_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/testicles, GLOB.balls_shapes_list)

	for(var/gpath in subtypesof(/obj/item/organ/genital))
		var/obj/item/organ/genital/G = gpath
		if(!CHECK_BITFIELD(initial(G.genital_flags), GENITAL_BLACKLISTED))
			GLOB.genitals_list[initial(G.name)] = gpath
//END OF CIT CHANGES

	//Surgeries
	for(var/path in subtypesof(/datum/surgery))
		GLOB.surgeries_list += new path()
	//Materials
//	for(var/path in subtypesof(/datum/material))
//		var/datum/material/D = new path()
//		GLOB.materials_list[D.id] = D

	//Emotes
	for(var/path in subtypesof(/datum/emote))
		var/datum/emote/E = new path()
		E.emote_list[E.key] = E

	init_keybindings()

	//Uplink Items
	for(var/path in subtypesof(/datum/uplink_item))
		var/datum/uplink_item/I = path
		if(!initial(I.item)) //We add categories to a separate list.
			GLOB.uplink_categories |= initial(I.category)
			continue
		GLOB.uplink_items += path
	//(sub)typesof entries are listed by the order they are loaded in the code, so we'll have to rearrange them here.
	GLOB.uplink_items = sortList(GLOB.uplink_items, /proc/cmp_uplink_items_dsc)

	init_subtypes(/datum/crafting_recipe, GLOB.crafting_recipes)

	INVOKE_ASYNC(GLOBAL_PROC, .proc/init_ref_coin_values) //so the current procedure doesn't sleep because of UNTIL()

//creates every subtype of prototype (excluding prototype) and adds it to list L.
//if no list/L is provided, one is created.
/proc/init_subtypes(prototype, list/L)
	if(!istype(L))
		L = list()
	for(var/path in subtypesof(prototype))
		L += new path()
	return L

//returns a list of paths to every subtype of prototype (excluding prototype)
//if no list/L is provided, one is created.
/proc/init_paths(prototype, list/L)
	if(!istype(L))
		L = list()
		for(var/path in subtypesof(prototype))
			L+= path
		return L

/proc/init_ref_coin_values()
	for(var/path in typesof(/obj/item/coin))
		var/obj/item/coin/C = new path
		UNTIL(C.flags_1 & INITIALIZED_1) //we want to make sure the value is calculated and not null.
		GLOB.coin_values[path] = C.value
		qdel(C)


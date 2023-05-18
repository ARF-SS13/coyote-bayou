/// All aboard the SS Furry
SUBSYSTEM_DEF(furry)
	name = "Species"
	priority = FIRE_PRIORITY_FURRY
	flags = SS_BACKGROUND|SS_KEEP_TIMING

	var/list/all_accessories_by_category

/// Here are all the furry parts. All of them.
	var/list/tails
	var/list/tails_animated
	var/list/ears
	var/list/snouts
	var/list/horns
	var/list/taurs
	var/list/wings
	var/list/wings_decorative
	var/list/wings_open
	var/list/wings_insect
	var/list/legs
	var/list/neckfluff
	var/list/frills
	var/list/spines
	var/list/spines_animated
	var/list/markings
	var/list/markings_insect
	var/list/shroom_caps
	var/list/xeno_dorsals
	var/list/xeno_tails
	var/list/xeno_heads
	var/list/ipc_antennas
	var/list/ipc_screens
	var/list/arachnid_legs
	var/list/arachnid_spinneret
	var/list/arachnid_mandibles
	var/list/meat_types

	var/list/body_markings

	var/list/species_list

// 	//Mammal Species
// GLOBAL_LIST_EMPTY(mam_body_markings_list)
// GLOBAL_LIST_EMPTY(mam_ears_list)
// GLOBAL_LIST_EMPTY(mam_tails_list)
// GLOBAL_LIST_EMPTY(mam_tails_animated_list)
// GLOBAL_LIST_EMPTY(taur_list)
// GLOBAL_LIST_EMPTY(mam_snouts_list)

// 	//Xenomorph Species
// GLOBAL_LIST_EMPTY(xeno_head_list)
// GLOBAL_LIST_EMPTY(xeno_tail_list)
// GLOBAL_LIST_EMPTY(xeno_dorsal_list)

// 	//IPC species
// GLOBAL_LIST_EMPTY(ipc_screens_list)
// GLOBAL_LIST_EMPTY(ipc_antennas_list)
	// if(!GLOB.tails_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/human, GLOB.tails_list)
	// if(!GLOB.animated_tails_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/lizard, GLOB.animated_tails_list)
	// if(!GLOB.snouts_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts, GLOB.snouts_list)
	// if(!GLOB.horns_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/horns, GLOB.horns_list)
	// if(!GLOB.ears_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, GLOB.ears_list)
	// if(!GLOB.frills_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/frills, GLOB.frills_list)
	// if(!GLOB.spines_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/spines, GLOB.spines_list)
	// if(!GLOB.legs_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/legs, GLOB.legs_list)
	// if(!GLOB.wings_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, GLOB.wings_list)
	// if(!GLOB.deco_wings_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/deco_wings, GLOB.deco_wings_list)
	// if(!GLOB.insect_wings_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/insect_wings, GLOB.insect_wings_list)
	// if(!GLOB.insect_fluffs_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/insect_fluff, GLOB.insect_fluffs_list)
	// if(!GLOB.insect_markings_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/insect_markings, GLOB.insect_markings_list)
	// if(!GLOB.ipc_screens_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/screen, GLOB.ipc_screens_list)
	// if(!GLOB.ipc_antennas_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/antenna, GLOB.ipc_antennas_list)
	// if(!GLOB.mam_body_markings_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/mam_body_markings, GLOB.mam_body_markings_list)
	// if(!GLOB.mam_tails_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/mam_tails, GLOB.mam_tails_list)
	// if(!GLOB.mam_ears_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/ears/mam_ears, GLOB.mam_ears_list)
	// if(!GLOB.mam_snouts_list.len)
	// 	init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts/mam_snouts, GLOB.mam_snouts_list)

/datum/controller/subsystem/furry/Initialize(start_timeofday)
	init_furry_parts()
	. = ..()

/datum/controller/subsystem/furry/proc/get_accessory_from_prefs(datum/preferences/prefs, category)
	if(!prefs || !category)
		return
	var/accessory_name = prefs.features[category] || prefs.pref_species.mutant_bodyparts[category]
	if(accessory_name == ACCESSORY_NONE)
		return
	return get_accessory(category, accessory_name)

/datum/controller/subsystem/furry/proc/get_accessory(category, accessory_name, get_untransformed)
	if(!category || !accessory_name || accessory_name == ACCESSORY_NONE)
		return null
	var/list/accessory_list = SSfurry.get_accessory_list(category)
	var/datum/sprite_accessory/accessory = LAZYACCESS(accessory_list, accessory_name)
	if(accessory.name == ACCESSORY_NONE)
		return null
	if(get_untransformed && accessory.transformed_part_string)
		return get_accessory(category, accessory.transformed_part_string, FALSE)
	return LAZYACCESS(accessory_list, accessory_name)

/datum/controller/subsystem/furry/proc/get_accessory_list(category)
	var/list/outlist = LAZYACCESS(all_accessories_by_category, category)
	return outlist

/datum/controller/subsystem/furry/proc/get_mutant_part_categories(client/user, only_unlocked = TRUE, include_body_markings = FALSE)
	if(!user)
		return
	var/list/outlist = list()
	for(var/part_category in get_mutant_accessory_categories)
		if(part_category == MBP_BODY_MARKINGS && !include_body_markings)
			continue
		if(only_unlocked && !user.can_have_part(part_category))
			continue
		outlist |= part_category
	return outlist

/datum/controller/subsystem/furry/proc/get_allowed_parts(category, species, mob/living/carbon/human/wanter)
	if(!category)
		return
	var/list/search_list = get_accessory_list(category)
	if(!LAZYLEN(search_list))
		return
	var/list/outlist = list()
	for(var/mtpath in search_list)
		var/datum/sprite_accessory/S = search_list[mtpath]
		if(!istype(instance, /datum/sprite_accessory))
			continue
		if(species && LAZYLEN(S.recommended_species) && !(species in S.recommended_species))
			continue
		if(S.ckey_required && !wanter)
			continue
		if(S.ckeys_allowed && !(wanter.ckey in S.ckeys_allowed))
			continue
		outlist[S.name] = mtpath
	return outlist

/datum/controller/subsystem/furry/proc/get_markings(selected_limb, ckey)
	if(!selected_limb)
		return
	var/list/snowflake_markings_list = list()
	var/list/marking_list = get_accessory_list(MBP_BODY_MARKINGS)
	for(var/path in marking_list)
		var/datum/sprite_accessory/mam_body_markings/marking = marking_list[path]
		if(!istype(marking))
			continue
		if(!(selected_limb in marking.covered_limbs) && selected_limb != "All")
			continue
		if((!S.ckeys_allowed) || (ckey in S.ckeys_allowed))
			snowflake_markings_list[S.name] = path
	return snowflake_markings_list

/datum/controller/subsystem/furry/proc/get_category_color_type(category)
	if(!category)
		return
	switch(category)
		if(MBP_WINGS_INSECT, MBP_WINGS_DECORATIVE)
			return FEATURE_COLORMODE_WINGS
		if(MBP_HORNS)
			return FEATURE_COLORMODE_HORNS

/datum/controller/subsystem/furry/proc/init_furry_parts()
	if(!LAZYLEN(all_accessories_by_category))
		LAZYINITLIST(all_accessories_by_category)
	if(!LAZYLEN(tails))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/tails, tails)
		all_accessories_by_category[MBP_TAIL] = tails
	if(!LAZYLEN(tails_animated))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/tails_animated, tails_animated)
		all_accessories_by_category[MBP_TAIL_ANIMATED] = tails_animated
	if(!LAZYLEN(ears))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, ears)
		all_accessories_by_category[MBP_EARS] = ears
	if(!LAZYLEN(snouts))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts, snouts)
		all_accessories_by_category[MBP_SNOUT] = snouts
	if(!LAZYLEN(horns))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/horns, horns)
		all_accessories_by_category[MBP_HORNS] = horns
	if(!LAZYLEN(ears))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, ears)
		all_accessories_by_category[MBP_EARS] = ears
	if(!LAZYLEN(wings))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, wings)
		all_accessories_by_category[MBP_WINGS] = wings
	if(!LAZYLEN(wings_open))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/wings_open, wings_open)
		all_accessories_by_category[MBP_WINGS_OPEN] = wings_open
	if(!LAZYLEN(wings_decorative))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/deco_wings, wings_decorative)
		all_accessories_by_category[MBP_WINGS_DECORATIVE] = wings_decorative
	if(!LAZYLEN(insect_wings))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/insect_wings, wings_insect)
		all_accessories_by_category[MBP_WINGS_INSECT] = wings_insect
	if(!LAZYLEN(frills))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/frills, frills)
		all_accessories_by_category[MBP_FRILLS] = frills
	if(!LAZYLEN(spines))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/spines, spines)
		all_accessories_by_category[MBP_SPINES] = spines
	if(!LAZYLEN(spines_animated))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/spines_animated, spines_animated)
		all_accessories_by_category[MBP_SPINES_ANIMATED] = spines_animated
	if(!LAZYLEN(legs))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/legs, legs)
		all_accessories_by_category[MBP_LEGS] = legs
	if(!LAZYLEN(shroom_caps))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/caps, shroom_caps)
		all_accessories_by_category[MBP_SHROOM_CAP] = shroom_caps
	if(!LAZYLEN(insect_fluff))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/insect_fluff, neckfluff)
		all_accessories_by_category[MBP_FLUFF] = neckfluff
	if(!LAZYLEN(body_markings))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/mam_body_markings, body_markings)
		all_accessories_by_category[MBP_BODY_MARKINGS] = body_markings
	if(!LAZYLEN(taurs))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/taur, taurs)
		all_accessories_by_category[MBP_TAUR] = taurs
	if(!LAZYLEN(xeno_heads))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/xeno_head, xeno_heads)
		all_accessories_by_category[MBP_XENO_HEAD] = xeno_heads
	if(!LAZYLEN(xeno_tails))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/xeno_tail, xeno_tails)
		all_accessories_by_category[MBP_XENO_TAIL] = xeno_tails
	if(!LAZYLEN(xeno_dorsals))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/xeno_dorsal, xeno_dorsals)
		all_accessories_by_category[MBP_XENO_DORSAL] = xeno_dorsals
	if(!LAZYLEN(ipc_screens))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/screen, ipc_screens, roundstart = TRUE)
		all_accessories_by_category[MBP_IPC_SCREEN] = ipc_screens
	if(!LAZYLEN(ipc_antennas))
		init_sprite_accessory_subtypes(/datum/sprite_accessory/antenna, ipc_antennas, roundstart = TRUE)
		all_accessories_by_category[MBP_IPC_ANTENNA] = ipc_antennas
	//Species
	if(!LAZYLEN(species_list))
		for(var/spath in subtypesof(/datum/species))
			var/datum/species/S = new spath()
			species_list[S.id] = spath



/// All aboard the SS Furry
SUBSYSTEM_DEF(furry)
	name = "Species"
	priority = FIRE_PRIORITY_MOBS
	flags = SS_BACKGROUND|SS_KEEP_TIMING

/// Here are all the furry parts. All of them.
	var/list/tails
	var/list/tails_animated
	var/list/ears
	var/list/snouts
	var/list/horns
	var/list/taurs
	var/list/wings
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


/datum/controller/subsystem/furry/Initialize(start_timeofday)
	init_furry_parts()
	. = ..()

/datum/controller/subsystem/furry/proc/get_part(part, specific)


/datum/controller/subsystem/furry/proc/init_furry_parts()
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails, tails)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails_animated, tails_animated)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts, snouts)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/horns, horns)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, ears)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, wings)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings_open, wings_open)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/frills, frills)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/spines, spines)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/spines_animated, spines_animated)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/legs, legs)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, wings)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/caps, shroom_caps)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/insect_wings, wings_insect)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/insect_fluff, neckfluff)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/deco_wings, wings)

	//mammal bodyparts (fucking furries)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/mam_body_markings, body_markings)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/taur, taurs)
	//xeno parts (hiss?)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/xeno_head, xeno_heads)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/xeno_tail, xeno_tails)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/xeno_dorsal, xeno_dorsals)
	//ipcs
	init_sprite_accessory_subtypes(/datum/sprite_accessory/screen, ipc_screens, roundstart = TRUE)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/antenna, ipc_antennas, roundstart = TRUE)
	
	//Species
	for(var/spath in subtypesof(/datum/species))
		var/datum/species/S = new spath()
		GLOB.species_list[S.id] = spath



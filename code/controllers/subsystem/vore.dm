/// List of types that are allowed to be eaten (right now)
/// Register COMSIG_VORE_ATOM_DEVOURED to a proc on these to make them do stuff
#define VORABLE_TYPES list(\
	/obj/item/reagent_containers/food,\
	/obj/item/clothing/head/mob_holder,\
	/obj/item/grenade,\
	)

//
// Vore subsystem - Process vore bellies
//
PROCESSING_SUBSYSTEM_DEF(vore)
	name = "Bellies"
	priority = FIRE_PRIORITY_VORE
	wait = 5 SECONDS
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	/// mobtypes allowed to have a vore component
	var/list/approved_vore_mobtypes = list()
	/// itemtypes allowed to be vored
	var/list/approved_vore_item_types = list()
	/// list of stock vore_flags
	var/list/vore_data_by_path = list()
	/// list of smells
	var/list/smell_by_mob = list()

/datum/controller/subsystem/processing/vore/Initialize(start_timeofday)
	build_list_of_mobtypes_that_should_vore()
	build_list_of_items_that_can_be_vored()
	init_voredata()

/datum/controller/subsystem/processing/vore/proc/build_list_of_mobtypes_that_should_vore()
	approved_vore_mobtypes |= typecacheof(/mob/living/carbon/human)
	approved_vore_mobtypes |= typecacheof(/mob/living/simple_animal/pet/catslug)

/datum/controller/subsystem/processing/vore/proc/build_list_of_items_that_can_be_vored()
	for(var/itempath in VORABLE_TYPES)
		approved_vore_item_types |= typecacheof(itempath)

/datum/controller/subsystem/processing/vore/proc/init_voredata()
	for(var/vd in typesof(/datum/vore_data))
		var/datum/vore_data/veedee = new()
		vore_data_by_path[veedee.index] = veedee

/// Stores a mob's smell
/// Yes I know its a wierd place for it, it'll make sense when more things have scents
/// much better than storing a list on every fucking atom
/datum/controller/subsystem/processing/vore/proc/register_smell(mob/living/living_pred, smell)
	var/datum/weakref/sniffa = WEAKREF(living_pred)
	smell_by_mob[sniffa] = "[smell]"

// Returns a mob's smell
/datum/controller/subsystem/processing/vore/proc/get_scent(mob/living/living_pred)
	var/datum/weakref/sniffa = WEAKREF(living_pred)
	. = smell_by_mob[sniffa]
	if(!. || . == "")
		return "what you'd expect."

/datum/controller/subsystem/processing/vore/proc/should_have_vore(mob/living/living_pred)
	if(!isliving(living_pred))
		return FALSE // no ghostvore (yet)
	if(!is_type_in_typecache(living_pred.type, approved_vore_mobtypes))
		return FALSE
	return TRUE

/datum/controller/subsystem/processing/vore/proc/get_voredatum(mob/living/living_pred)
	if(!should_have_vore(living_pred))
		return
	. = vore_data_by_path[living_pred.type]
	if(.)
		return
	for(var/vd in vore_data_by_path)
		var/datum/vore_data/veedee = vore_data_by_path[vd]
		if(!veedee.subpaths)
			continue
		if(ispath(veedee.index, living_pred.type))
			return veedee
	
/datum/controller/subsystem/processing/vore/proc/get_default_bellies(mob/living/living_pred)
	if(living_pred.client)
		return
	var/datum/vore_data/vd = get_voredatum(living_pred)
	if(!vd)
		return
	return vd.wild_bellies


/datum/controller/subsystem/processing/vore/proc/get_voreflags(mob/living/living_pred)
	if(!should_have_vore(living_pred))
		return NONE
	if(living_pred.client)
		return living_pred.client.prefs.vore_flags
	var/datum/vore_data/vd = get_voredatum(living_pred)
	if(!vd)
		return
	return vd.vore_flags

/// stores initial vore data that would just take up space on a mob or something
/datum/vore_data
	/// usually the mob's path
	var/index = /mob/living
	/// voreflags
	var/vore_flags = NONE
	/// If set, these'll be the bellies given to the mob by default, if there's no client
	var/list/wild_bellies
	/// include subpaths?
	var/subpaths = TRUE

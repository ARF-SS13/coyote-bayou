SUBSYSTEM_DEF(listbank)
	name = "listbank"
	flags = SS_BACKGROUND
	wait = 30 MINUTES
	/// FORMAT: list("/atom/type" = /datum/list_holder, "/atom/type2" = /datum/list_holder2, etc.)
	var/list/bank = list()
	var/list/unique_bank = list()
	var/last_uid = 1
	var/list/generic_bank = list()

	var/list/aaa_debug_list_tally = list()

/datum/controller/subsystem/listbank/Initialize(start_timeofday)
	init_tastes()

/datum/controller/subsystem/listbank/fire(resumed)
	for(var/index in bank)
		var/datum/list_holder/aholder = LAZYACCESS(bank, index)
		if(aholder.autoprune())
			bank -= index
			qdel(aholder)

/datum/controller/subsystem/listbank/proc/init_tastes()
	catalogue_tastes(/mob, list("critter" = 1), init = TRUE)
	catalogue_tastes(/atom, list("matter" = 1), init = TRUE)
	catalogue_tastes(/obj, list("stuff" = 1), init = TRUE)
	catalogue_tastes(/obj/item, list("gear" = 1), init = TRUE)
	catalogue_tastes(/obj/structure, list("built stuff" = 1), init = TRUE)
	catalogue_tastes(/turf, list("turf" = 1), init = TRUE)
	catalogue_tastes(/turf/open, list("floor" = 1), init = TRUE)
	catalogue_tastes(/turf/closed, list("wall" = 1), init = TRUE)
	catalogue_tastes(/area, list("hi how did you lick an area" = 1), init = TRUE)
	catalogue_tastes(/datum, list("data storage, also hi" = 1), init = TRUE)

/datum/controller/subsystem/listbank/proc/catalogue_list(datum/thing, list/input, kind, unique, init)
	if(!islist(input))
		return
	if(!kind)
		return
	/// note, thing may not be an instantiated thing, it may be a type, for init stuff
	var/index
	var/uid = null
	var/list/access
	var/datum/list_holder/aholder
	if(istype(thing) && (unique || !isnull(thing.thing_id)))
		access = unique_bank
		if(isnull(thing.thing_id))
			thing.thing_id = generate_uid()
		index = "[thing.thing_id]"
		uid = thing.thing_id
	else if(init)
		access = generic_bank
		index = "[thing]"
	else
		access = bank
		index = "[thing.type]"
		aholder = LAZYACCESS(bank, index)
		if(aholder)
			return // nonunique trying to overwrite another nonunique, nothanks
	aholder = LAZYACCESS(bank, index)
	if(!aholder)
		aholder = new /datum/list_holder(kind, uid)
		access[index] = aholder
	aholder.update_list(kind, input)
	return uid

/datum/controller/subsystem/listbank/proc/get_list(datum/thing, kind)
	if(!istype(thing))
		return list()
	if(!kind)
		return list()
	var/index
	var/list/access
	if(!isnull(thing.thing_id))
		access = unique_bank
		index = "[thing.thing_id]"
	else
		access = bank
		index = "[thing.type]"
	var/datum/list_holder/aholder = LAZYACCESS(access, index)
	if(!aholder) // they didnt register something for this, so spit out a default
		return get_default_for(thing, kind)
	return aholder.get_list(kind)

/datum/controller/subsystem/listbank/proc/get_default_for(datum/thing, kind)
	if(!istype(thing) || !kind)
		return list()
	var/datum/list_holder/aholder
	/// from most specific to least specific
	if(istype(thing, /mob))
		aholder = LAZYACCESS(generic_bank, "[/mob]")
	else if(istype(thing, /obj/item))
		aholder = LAZYACCESS(generic_bank, "[/obj/item]")
	else if(istype(thing, /obj/structure))
		aholder = LAZYACCESS(generic_bank, "[/obj/structure]")
	else if(istype(thing, /turf/open))
		aholder = LAZYACCESS(generic_bank, "[/turf/open]")
	else if(istype(thing, /turf/closed))
		aholder = LAZYACCESS(generic_bank, "[/turf/closed]")
	else if(istype(thing, /turf))
		aholder = LAZYACCESS(generic_bank, "[/turf]")
	else if(istype(thing, /area))
		aholder = LAZYACCESS(generic_bank, "[/area]")
	else if(istype(thing, /atom))
		aholder = LAZYACCESS(generic_bank, "[/atom]")
	else if(istype(thing, /datum))
		aholder = LAZYACCESS(generic_bank, "[/datum]")
	else
		return list()
	if(!istype(aholder))
		return list()
	return aholder.get_list(kind)

/datum/controller/subsystem/listbank/proc/catalogue_tastes(datum/thing, list/input, unique, init)
	if(!LAZYLEN(input))
		return // its not special, just make it default
	var/uid = catalogue_list(thing, input, ATOM_TASTES, unique, init)
	if(istype(thing) && isnum(uid) && isnull(thing.thing_id))
		thing.thing_id = uid

/datum/controller/subsystem/listbank/proc/get_tastes(datum/thing)
	var/list/out = get_list(thing, ATOM_TASTES)
	if(LAZYLEN(out))
		return out
	/// if they dont have a

/obj/item/storage/debug_box/debug_tastes
	name = "box of tasty things"
	desc = "A box of tasty things."

/obj/item/storage/debug_box/debug_tastes/PopulateContents()
	new /obj/item/storage/box/party_pouch(src)
	new /obj/item/storage/box/party_pouch(src)
	new /obj/item/storage/box/party_pouch(src)
	new /obj/item/storage/box/party_pouch(src)
	new /obj/item/storage/box/party_pouch/drinks(src)
	new /obj/item/storage/box/party_pouch/drinks(src)
	new /obj/item/storage/box/party_pouch/drinks(src)
	new /obj/item/storage/box/party_pouch/drinks(src)



/datum/controller/subsystem/listbank/proc/generate_uid()
	return (last_uid + 1) // brilliant


/datum/list_holder
	var/key
	/// FORMAT: list("list_kind" = /datum/list_baby, "list_kind2" = /datum/list_baby2, etc.)
	var/list/master = list()
	/// to have it delete itself if its owner ceases to exist
	var/am_unique = FALSE
	/// only used if its unique
	var/datum/weakref/owner
	var/last_access = 0

/datum/list_holder/New(atom/thing, unique)
	if(!isatom(thing))
		return
	key = thing.type
	if(unique)
		am_unique = TRUE
		owner = WEAKREF(thing)

/datum/list_holder/Destroy(force, ...)
	owner = null
	QDEL_LIST_ASSOC_VAL(master)
	. = ..()

/datum/list_holder/proc/autoprune()
	if(!am_unique)
		return
	var/atom/thing = GET_WEAKREF(owner)
	if(QDELETED(thing))
		return TRUE

/datum/list_holder/proc/update_list(kind, list/mylist)
	if(!islist(mylist))
		return
	var/datum/list_baby/alist = LAZYACCESS(master, kind)
	if(!alist)
		alist = new /datum/list_baby(mylist)
		master[kind] = alist
	alist.mylist.Cut()
	alist.mylist = mylist.Copy()
	return TRUE

/datum/list_holder/proc/get_list(kind)
	last_access = world.time
	var/datum/list_baby/alist = LAZYACCESS(master, kind)
	if(!alist)
		return list()
	alist.last_access = world.time
	return alist.mylist

/// cus I dont like heckhuge lists
/datum/list_baby
	var/last_access = 0
	var/list/mylist = list()

/datum/list_baby/Destroy(force, ...)
	mylist.Cut()
	. = ..()
	

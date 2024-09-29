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
	return ..()

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
	. = list() // THEY EXPECT A LIST IN THE CRASH, BROTHER
	var/list/out = get_list(thing, ATOM_TASTES)
	if(LAZYLEN(out))
		return out
	/// if they dont have a

/obj/item/storage/debug_box/debug_tastes
	name = "box of tasty things"
	desc = "A box of tasty things."

// /obj/item/storage/debug_box/debug_tastes/PopulateContents()
// 	new /obj/item/storage/box/party_pouch(src)
// 	new /obj/item/storage/box/party_pouch(src)
// 	new /obj/item/storage/box/party_pouch(src)
// 	new /obj/item/storage/box/party_pouch(src)
// 	new /obj/item/storage/box/party_pouch/drinks(src)
// 	new /obj/item/storage/box/party_pouch/drinks(src)
// 	new /obj/item/storage/box/party_pouch/drinks(src)
// 	new /obj/item/storage/box/party_pouch/drinks(src)

/datum/controller/subsystem/listbank/proc/catalogue_minerals(datum/thing, list/input, unique, init)
	if(!LAZYLEN(input))
		return // its not special, just make it default
	var/uid = catalogue_list(thing, input, ROCK_MINERALS, unique, init)
	if(istype(thing) && isnum(uid) && isnull(thing.thing_id))
		thing.thing_id = uid

/datum/controller/subsystem/listbank/proc/get_minerals(datum/thing)
	. = list() // THEY EXPECT A LIST IN THE CRASH, BROTHER
	var/list/out = get_list(thing, ROCK_MINERALS)
	if(LAZYLEN(out))
		return out
	/// if they dont have a

/datum/controller/subsystem/listbank/proc/catalogue_cleanable_states(datum/thing, list/input, unique, init)
	if(!LAZYLEN(input))
		return // its not special, just make it default
	var/uid = catalogue_list(thing, input, CLEANABLE_DECALS, unique, init)
	if(istype(thing) && isnum(uid) && isnull(thing.thing_id))
		thing.thing_id = uid

/datum/controller/subsystem/listbank/proc/get_cleanable_states(datum/thing)
	. = list() // THEY EXPECT A LIST IN THE CRASH, BROTHER
	var/list/out = get_list(thing, CLEANABLE_DECALS)
	if(LAZYLEN(out))
		return out
	/// if they dont have a








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
	





/// this is a debug proc, it shouldnt be used in actual code
/datum/controller/subsystem/listbank/proc/tally_all_lists()
	to_chat(world, span_boldannounce("Tallying all lists, this make the game run like bbb for a bit."))
	var/list/tally = list()
	var/all_datums = 0
	for(var/datum/thing)
		all_datums++
	all_datums += LAZYLEN(world.contents)
	var/portion = 1
	var/portion_amount = 0.01
	var/next_milestone = round(all_datums * (portion * portion_amount))
	var/batch_start = REALTIMEOFDAY
	var/start_timery = REALTIMEOFDAY
	var/this_batch = 0
	var/atoms_did = 0
	var/list/rates = list()
	for(var/datum/A) // terrifying I know
		var/datum/list_tally/LT = LAZYACCESS(tally, "[A.type]")
		if(!LT)
			LT = new /datum/list_tally(A)
			tally["[A.type]"] = LT
		LT.add_instance()
		for(var/V in A.vars)
			if(!islist(A.vars[V]))
				continue
			LT.add_list(A.vars[V])
		atoms_did++
		this_batch++
		if(atoms_did % next_milestone != 0)
			continue
		CHECK_TICK
		// all_datums = LAZYLEN(world.contents)
		var/batch_end = REALTIMEOFDAY
		var/batch_time = ((batch_end - batch_start) * 0.1)
		var/batch_rate = (this_batch / batch_time)
		var/batch_percent = (atoms_did / all_datums) * 100
		portion++
		next_milestone = round(all_datums * (portion * portion_amount))
		rates += batch_rate
		batch_start = REALTIMEOFDAY
		this_batch = 0
		var/current_time = REALTIMEOFDAY - start_timery
		var/batch_time_left = (current_time / atoms_did) * (all_datums - atoms_did)
		to_chat(world, span_boldannounce("Catalogue'd [shorten_number(atoms_did, 2)]/[shorten_number(all_datums, 2)] ([round(batch_percent,portion_amount*100)]%) datums in [DisplayTimeText(current_time)]. \nProjected time left at [shorten_number(batch_rate, 1)]/sec: [DisplayTimeText(batch_time_left)]!"))
	var/avrate = 0
	for(var/r in rates)
		avrate += r
	avrate /= rates.len
	to_chat(world, span_boldannounce("~Catalogued [shorten_number(atoms_did, 2)] datums! Average rate: [shorten_number(avrate, 1)]/sec.~"))
	to_chat(world, span_boldannounce("~Catalogueing atoms!~"))
	for(var/atom/A in world) // duplicated, but whatever
		var/datum/list_tally/LT = LAZYACCESS(tally, "[A.type]")
		if(!LT)
			LT = new /datum/list_tally(A)
			tally["[A.type]"] = LT
		LT.add_instance()
		for(var/V in A.vars)
			if(!islist(A.vars[V]))
				continue
			LT.add_list(A.vars[V])
		atoms_did++
		this_batch++
		if(atoms_did % next_milestone != 0)
			continue
		CHECK_TICK
		// all_datums = LAZYLEN(world.contents)
		var/batch_end = REALTIMEOFDAY
		var/batch_time = ((batch_end - batch_start) * 0.1)
		var/batch_rate = (this_batch / batch_time)
		var/batch_percent = (atoms_did / all_datums) * 100
		portion++
		next_milestone = round(all_datums * (portion * portion_amount))
		rates += batch_rate
		batch_start = REALTIMEOFDAY
		this_batch = 0
		var/current_time = REALTIMEOFDAY - start_timery
		var/batch_time_left = (current_time / atoms_did) * (all_datums - atoms_did)
		to_chat(world, span_boldannounce("Catalogue'd [shorten_number(atoms_did, 2)]/[shorten_number(all_datums, 2)] ([round(batch_percent,portion_amount*100)]%) datums in [DisplayTimeText(current_time)]. \nProjected time left at [shorten_number(batch_rate, 1)]/sec: [DisplayTimeText(batch_time_left)]!"))
	avrate = 0
	for(var/r in rates)
		avrate += r
	avrate /= rates.len
	to_chat(world, span_boldannounce("~Catalogued [shorten_number(atoms_did, 2)] atoms! Average rate: [shorten_number(avrate, 1)]/sec.~"))
	to_chat(world, span_boldannounce("All done! Jut kidding, time to sort and cull."))
	for(var/entry in tally)
		var/datum/list_tally/LT = LAZYACCESS(tally, entry)
		if(LT.num_populated < 100)
			tally -= entry
			continue
	aaa_debug_list_tally = tally
	to_chat(world, span_boldannounce("All done!"))
	output_debug_list_tally()

/datum/controller/subsystem/listbank/proc/output_debug_list_tally(num2get = 10)
	if(!LAZYLEN(aaa_debug_list_tally))
		return tally_all_lists()
	var/list/rawtallies = list()
	for(var/entry in aaa_debug_list_tally)
		var/datum/list_tally/LT = LAZYACCESS(aaa_debug_list_tally, entry)
		rawtallies += LT
	rawtallies = sortTim(rawtallies.Copy(), GLOBAL_PROC_REF(cmp_list_tally_dec))
	var/list/tallies = list()
	for(var/i in 1 to num2get)
		var/datum/list_tally/LT = LAZYACCESS(rawtallies, i)
		if(!LT)
			break
		var/msg = "[i]: [LT.thingpath] - [LT.num_instances] instances, [LT.num_populated] populated, [LT.num_empty] empty, [LT.num_entries] entries, [LT.total] total"
		tallies += msg
	to_chat(world, span_boldannounce("Top [num2get] populated lists:"))
	for(var/msg in tallies)
		to_chat(world, span_green(msg))
	to_chat(world, span_boldannounce("All done! =3"))

/proc/cmp_list_tally_dec(datum/list_tally/A, datum/list_tally/B)
	return B.total - A.total 

/datum/list_tally
	var/thingpath
	var/num_instances = 0
	var/num_populated = 0
	var/num_empty = 0
	var/num_entries = 0
	var/total = 0

/datum/list_tally/New(datum/thing)
	thingpath = thing.type
	
/datum/list_tally/proc/add_instance()
	num_instances++

/datum/list_tally/proc/add_list(list/mylist)
	if(!islist(mylist))
		return
	if(LAZYLEN(mylist))
		num_populated++
	else
		num_empty++
	total++
	/// and now to recursively search through the list and find every. single. entry.
	var/list/to_search = mylist.Copy()
	var/ops_left = 3000
	while(LAZYLEN(to_search) && ops_left--)
		var/list/entry = LAZYACCESS(to_search, 1)
		to_search.len--
		num_entries++
		if(!islist(entry))
			continue
		to_search |= entry





SUBSYSTEM_DEF(mobs)
	name = "Mobs"
	priority = FIRE_PRIORITY_MOBS
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()
	var/static/list/clients_by_zlevel[][]
	var/static/list/dead_players_by_zlevel[][] = list(list()) // Needs to support zlevel 1 here, MaxZChanged only happens when z2 is created and new_players can login before that.
	var/static/list/cubemonkeys = list()
	var/static/list/cheeserats = list()

	var/there_is_no_escape = FALSE // there is escape
	var/debug_no_icon_2_html = TRUE

	var/debug_disable_mob_ceasefire = TRUE // this feature sucks

	var/list/loot_tables = list()

/datum/controller/subsystem/mobs/Initialize(timeofday)
	init_loot_tables()
	..()
	to_chat(world, span_boldannounce("Built [LAZYLEN(loot_tables)] loot tables! =3"))

/datum/controller/subsystem/mobs/proc/init_loot_tables()
	if(LAZYLEN(loot_tables))
		return
	for(var/tabel in subtypesof(/datum/mob_loot_table))
		var/datum/mob_loot_table/lootz = tabel
		lootz = new()
		loot_tables[lootz.key] = lootz

/datum/controller/subsystem/mobs/stat_entry(msg)
	msg = "P:[length(GLOB.mob_living_list)]"
	return ..()

/datum/controller/subsystem/mobs/proc/MaxZChanged()
	if (!islist(clients_by_zlevel))
		clients_by_zlevel = new /list(world.maxz,0)
		dead_players_by_zlevel = new /list(world.maxz,0)
	while (clients_by_zlevel.len < world.maxz)
		clients_by_zlevel.len++
		clients_by_zlevel[clients_by_zlevel.len] = list()
		dead_players_by_zlevel.len++
		dead_players_by_zlevel[dead_players_by_zlevel.len] = list()

/datum/controller/subsystem/mobs/fire(resumed = 0)
	var/seconds = wait * 0.1
	if (!resumed)
		src.currentrun = GLOB.mob_living_list.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	var/times_fired = src.times_fired
	while(currentrun.len)
		var/mob/living/L = currentrun[currentrun.len]
		currentrun.len--
		if(L)
			L.Life(seconds, times_fired)
		else
			GLOB.mob_living_list.Remove(L)
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/mobs/proc/drop_loot(mob/living/dropper, drop_key)
	if(!dropper)
		return
	if(!istext(drop_key))
		return
	var/datum/mob_loot_table/my_table = LAZYACCESS(loot_tables, drop_key)
	if(!my_table)
		CRASH("drop_loot called with an invalid drop key! it was '[drop_key]', and the mob was [dropper.name]. =3")
	return my_table.drop_loot(dropper)

/datum/mob_loot_table //ghoul, gecko, etc
	var/key //how to access the list, example `loot = ghoul_loot_key?`

	/// if set, will drop everything in this list, and then other stuff
	var/list/guaranteed_table = list() // MUST be an associated list, like list(/obj/item/thing = 10) - will drop 10 of /obj/item/thing
	var/only_guaranteed = FALSE // if true, will drop only the guaranteed stuff

	var/list/common_table = list() //loot rarities
	var/common_drop_amount = 1
	var/common_drop_amount_is_random = TRUE
	var/common_is_weighted = TRUE //#weighted roll

	var/uncommon_chance = 10	//%chance
	var/uncommon_drop_amount = 1
	var/uncommon_is_weighted = TRUE
	var/uncommon_drop_amount_is_random = TRUE
	var/list/uncommon_table = list()

	var/rare_chance = 1
	var/rare_drop_amount = 1
	var/rare_drop_amount_is_random = TRUE
	var/rare_is_weighted = TRUE
	var/list/rare_table = list()

/datum/mob_loot_table/New() //smelly table all the loot is stored in
	init_common()
	init_uncommon()
	init_rare()
	init_guaranteed()

/datum/mob_loot_table/proc/init_common()
	return

/datum/mob_loot_table/proc/init_uncommon()
	return

/datum/mob_loot_table/proc/init_rare()
	return

/datum/mob_loot_table/proc/init_guaranteed()
	return

/datum/mob_loot_table/proc/drop_loot(mob/living/dropper) //proc that gives the loot
	if(!isturf(get_turf(dropper)))
		return
	if(LAZYLEN(guaranteed_table))
		drop_guaranteed(dropper)
		if(only_guaranteed)
			return
	if(LAZYLEN(rare_table) && prob(rare_chance))
		drop_rare(dropper)
		return
	if(LAZYLEN(uncommon_table) && prob(uncommon_chance))
		drop_uncommon(dropper)
		return
	if(LAZYLEN(common_table))
		drop_common(dropper)
		return

					///////////////////
					//The Loot itself//
					///////////////////

	////////////////
	//Common drops//
	////////////////
/datum/mob_loot_table/proc/drop_common(mob/living/dropper) //containers for dropped junk
	var/num_drops = common_drop_amount_is_random ? rand(1, common_drop_amount) : common_drop_amount
	for(var/i in 1 to num_drops)
		var/atom/thing_to_drop //atom/obj/butt = weight
		if(common_is_weighted) //common_is_weighted = true
			thing_to_drop = pickweight(common_table) //roll the funny bingo balls batman
		else
			thing_to_drop = pick(common_table) //common_is_weighted = false
		var/turf/droplocation = dropper.drop_location() || get_turf(dropper) //Where the shit gets plopped
		if(!droplocation) //if no droppers?
			return //then fuck off
		thing_to_drop = new(droplocation) //re-delivery engaged
		afterdrop_common(dropper, thing_to_drop) // If no delivery can be made then these two can fuck off and get married somewhere/when else


	//////////////////
	//Uncommon drops//
	//////////////////
/datum/mob_loot_table/proc/drop_uncommon(mob/living/dropper) //containers for dropped junk
	var/num_drops = uncommon_drop_amount_is_random ? rand(1, uncommon_drop_amount) : uncommon_drop_amount
	for(var/i in 1 to num_drops)
		var/atom/thing_to_drop //atom/obj/butt = weight
		if(uncommon_is_weighted) //uncommon_is_weighted = true
			thing_to_drop = pickweight(uncommon_table) //roll the funny bingo balls batman
		else
			thing_to_drop = pick(uncommon_table) //uncommon_is_weighted = false
		var/turf/droplocation = dropper.drop_location() || get_turf(dropper)  //Where the shit gets plopped
		if(!droplocation)
			return
		thing_to_drop = new(droplocation)
		afterdrop_uncommon(dropper, thing_to_drop)

	//////////////
	//Rare drops//
	//////////////
/datum/mob_loot_table/proc/drop_rare(mob/living/dropper) //containers for dropped junk
	var/num_drops = rare_drop_amount_is_random ? rand(1, rare_drop_amount) : rare_drop_amount
	for(var/i in 1 to num_drops)
		var/atom/thing_to_drop //atom/obj/butt = weight
		if(rare_is_weighted) //rare_is_weighted = true
			thing_to_drop = pickweight(rare_table) //roll the funny bingo balls batman
		else
			thing_to_drop = pick(rare_table) //rare_is_weighted = false
		var/turf/droplocation = dropper.drop_location() || get_turf(dropper)  //Where the shit gets plopped
		if(!droplocation)
			return
		thing_to_drop = new(droplocation)
		afterdrop_rare(dropper, thing_to_drop)

/datum/mob_loot_table/proc/drop_guaranteed(mob/living/dropper) //containers for dropped junk
	var/list/g_table = guaranteed_table.Copy()
	while(LAZYLEN(g_table))
		var/atom/thing_to_drop = pickweight_n_reduce(g_table) //rare_is_weighted = false
		var/turf/droplocation = dropper.drop_location() || get_turf(dropper)  //Where the shit gets plopped
		if(!droplocation)
			return
		thing_to_drop = new(droplocation)
		afterdrop_guaranteed(dropper, thing_to_drop)


					///////////////////
					//Actions on Drop//
					///////////////////

/datum/mob_loot_table/proc/afterdrop_common(mob/living/dropper, atom/dropped) //containers for dropped junk actions
	dingle(dropper, dropped) //dingle is a dropper that done did drop
	return

/datum/mob_loot_table/proc/afterdrop_uncommon(mob/living/dropper, atom/dropped) //containers for dropped junk actions
	dingle(dropper, dropped)
	return

/datum/mob_loot_table/proc/afterdrop_rare(mob/living/dropper, atom/dropped) //containers for dropped junk actions
	dingle(dropper, dropped)
	return

/datum/mob_loot_table/proc/afterdrop_guaranteed(mob/living/dropper, atom/dropped) //containers for dropped junk actions
	dingle(dropper, dropped)
	return

// Amounts of coins that, under which, it makes a noise
#define DINGLE_LOW 5 //weighted chances
#define DINGLE_MED 15
#define DINGLE_HIGH 30

/datum/mob_loot_table/proc/dingle(mob/living/dropper, atom/dropped) //containers for dropped junk
	if(!istype(dropped, /obj/item/stack/f13Cash/caps)) //if its dropped and isn't whatever thing
		return //then fuck right  off
	var/obj/item/stack/f13Cash/caps/cash = dropped //but if it is the thing
	var/turf/thrat = pick(range(2, cash)) //throw-at, ping a range and direction.
	if(!thrat) //Unless its not, in which case fuck off
		return // good enough
	var/snd = 'sound/items/dropped/coin_1.ogg'
	switch(cash.amount) //do the thing
		if(0 to DINGLE_LOW) //in this amount
			snd = 'sound/items/dropped/coin_1.ogg' //with this sound
		if(DINGLE_LOW to DINGLE_MED)
			snd = 'sound/items/dropped/coin_low.ogg'
		if(DINGLE_MED to DINGLE_HIGH)
			snd = 'sound/items/dropped/coin_med.ogg'
		if(DINGLE_HIGH to INFINITY)
			snd = 'sound/items/dropped/coin_high.ogg'
	cash.safe_throw_at(thrat, 10, 1, dropper) //throw the money off the dropper
	playsound(cash, snd, 50, vary = FALSE, frequency = SOUND_FREQ_NORMALIZED(cash.pitch, 0, 0)) //funny sound magic

#undef DINGLE_LOW
#undef DINGLE_MED
#undef DINGLE_HIGH

/datum/mob_loot_table/trash_humanoid //ghoul, gecko, etc
	key = LOOTTABLE_TRASH_HUMANOID //how to access the list, example `loot = ghoul_loot_key?`

	guaranteed_table = list() // MUST be an associated list, like list(/obj/item/thing = 10) - will drop 10 of /obj/item/thing
	only_guaranteed = FALSE // if true, will drop only the guaranteed stuff

	common_drop_amount = 1
	common_drop_amount_is_random = TRUE
	common_is_weighted = TRUE //#weighted roll
	common_table = list() //loot rarities

	uncommon_chance = 0	//%chance
	uncommon_drop_amount = 1
	uncommon_is_weighted = TRUE
	uncommon_drop_amount_is_random = TRUE
	uncommon_table = list()

	rare_chance = 0
	rare_drop_amount = 1
	rare_drop_amount_is_random = TRUE
	rare_is_weighted = TRUE
	rare_table = list()

/datum/mob_loot_table/trash_humanoid/init_common()
	common_table = GLOB.trash_mob_loot
	return


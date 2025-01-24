/obj/item/storage/trash_stack
	name = "pile of garbage"
	desc = "A pile of garbage. Smells as good as it looks, though it may contain something useful. Or rats. Probably rats."
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "trash_1"
	anchored = TRUE
	density = FALSE
	///Is someone rifling through this trash pile?
	var/rifling = FALSE
	var/list/loot_players = list()
	var/list/lootable_trash = list()
	var/list/garbage_list = list()
	var/obj/effect/spawner/lootdrop/stuffspawn = /obj/effect/spawner/lootdrop/f13/trash/pile
	var/howmany_min = 1
	var/howmany_max = 4
/*
/obj/item/storage/trash_stack/proc/initialize_lootable_trash()
	lootable_trash = list(/obj/effect/spawner/lootdrop/f13/trash)
	/*garbage_list = list(GLOB.trash_ammo, GLOB.trash_chem, GLOB.trash_clothing, GLOB.trash_craft,
						GLOB.trash_gun, GLOB.trash_misc, GLOB.trash_money, GLOB.trash_mob,
						GLOB.trash_part, GLOB.trash_tool, GLOB.trash_attachment)
	lootable_trash = list() //we are setting them to an empty list so you can't double the amount of stuff
	for(var/i in garbage_list)
		for(var/ii in i)
			lootable_trash += ii*/
*/

// /obj/item/storage/trash_stack/Initialize()
// 	. = ..()
// 	icon_state = "trash_[rand(1,3)]"
// 	GLOB.trash_piles += WEAKREF(src)

//	initialize_lootable_trash()

/obj/item/storage/trash_stack/Destroy()
	GLOB.trash_piles -= WEAKREF(src)
	. = ..()

/// Called from [code/controllers/subsystem/itemspawners.dm]
/obj/item/storage/trash_stack/proc/cleanup()
	loot_players.Cut() //This culls a list safely
	for(var/obj/item/A in loc.contents)
		if(A.from_trash)
			qdel(A)

/obj/item/storage/trash_stack/attack_hand(mob/user)
	SiftThruTrash(user)

/obj/item/storage/trash_stack/proc/SiftThruTrash(mob/user)
	var/turf/trash_turf = get_turf(src)
	var/ukey = ckey(user?.ckey)
	if(!ukey)
		to_chat(user, span_alert("You need a ckey to search the trash! Gratz on not having a ckey, tell Lagg (a coder) about it!"))
	if(ukey in loot_players)
		to_chat(user, span_notice("You already have looted [src]."))
		return
	if(!rifling)
		playsound(get_turf(src), 'sound/f13effects/loot_trash.ogg', 100, TRUE, 1)
	to_chat(user, span_smallnoticeital("You start picking through [src]...."))
	rifling = TRUE
	if(!do_mob(user, src, 1 SECONDS))
		rifling = FALSE
		return
	rifling = FALSE
	if(ukey in loot_players)
		to_chat(user, span_notice("You already have looted [src]."))
		return
	loot_players += ukey
	to_chat(user, span_notice("You scavenge through [src]."))
	var/list/spawnedstuff = list()
	for(var/i in howmany_min to rand(howmany_min, howmany_max))
		var/obj/effect/spawner/lootdrop/my_trash = new stuffspawn(trash_turf)
		spawnedstuff |= my_trash.spawn_the_stuff() // fun fact, lists are references, so this'll be populated when the proc runs (cool huh?)
	for(var/atom/movable/spawned in spawnedstuff)
		if(isitem(spawned))
			var/obj/item/newitem = spawned
			newitem.from_trash = TRUE
		SEND_SIGNAL(spawned, COMSIG_ITEM_MOB_DROPPED, src)

		// if(isgun(spawned))
		// 	var/obj/item/gun/trash_gun = spawned
		// 	var/prob_trash = 80
		// 	for(var/tries in 1 to 3)
		// 		if(!prob(prob_trash))
		// 			continue
		// 		prob_trash -= 40
		// 		var/trash_mod_path = pick(GLOB.trash_craft) // this was trash gunmods but like they're not gonna be in loot anymore
		// 		var/obj/item/gun_upgrade/trash_mod = new trash_mod_path
		// 		if(!SEND_SIGNAL(trash_mod, COMSIG_ITEM_ATTACK_OBJ_NOHIT, trash_gun, null))
		// 			QDEL_NULL(trash_mod)

// lov dan
/obj/item/storage/money_stack
	name = "payroll safe"
	desc = "a payroll safe. Use it every hour to recieve your pay."
	icon = 'icons/obj/structures.dmi'
	icon_state = "safe"
	anchored = TRUE
	density = TRUE
	var/list/paid_players = list()
	var/list/pay = list(/obj/item/stack/f13Cash/random/med)

/obj/item/storage/money_stack/ncr
	pay = list(/obj/item/stack/f13Cash/random/ncr/med)

/obj/item/storage/money_stack/legion
	pay = list(/obj/item/stack/f13Cash/random/denarius/med)

/obj/item/storage/money_stack/Initialize()
	. = ..()
	GLOB.money_piles += src

/obj/item/storage/money_stack/Destroy()
	GLOB.money_piles -= src
	. = ..()

/obj/item/storage/money_stack/attack_hand(mob/user)
	var/turf/trash_turf = get_turf(src)
	if(user?.a_intent != INTENT_HARM)
		if(user in paid_players)
			to_chat(user, span_notice("You have already taken your pay from the [src]."))
			return
		for(var/i=0, i<rand(1,2), i++)
			var/itemtype = pick(pay)
			if(itemtype)
				to_chat(user, span_notice("You get your pay from the [src]."))
				new itemtype(trash_turf)
		paid_players += user
	else
		return ..()

/obj/item/storage/trash_stack/debug_rats
	name = "pile of rats"
	desc = "a pile of rats!"
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "trash_1"

/*
/obj/item/storage/trash_stack/debug_rats/initialize_lootable_trash()
	garbage_list = list(GLOB.trash_mob) // oops all rats!
	lootable_trash = list() //we are setting them to an empty list so you can't double the amount of stuff
	for(var/i in garbage_list)
		for(var/ii in i)
			lootable_trash += ii
*/


//Loot stacks

//common loot pile, drops 1 or 2 of our common loot drops
/obj/item/storage/trash_stack/loot/common	//obj/effect/spawner/lootdrop/f13/common
	name = "pile of scrap"
	desc = "A pile of scrap. You might find something useful if you take a look inside."
	icon = 'icons/fallout/objects/crafting.dmi'
	color = "#FFFFFF"
	icon_state = "Junk_10"
	anchored = TRUE
	density = FALSE
	stuffspawn = /obj/effect/spawner/lootdrop/f13/common
	howmany_min = 1
	howmany_max = 2

//uncommon loot pile, drops 1 or 2 of our uncommon loot drops
/obj/item/storage/trash_stack/loot/uncommon	//obj/effect/spawner/lootdrop/f13/uncommon
	name = "pile of shiny scrap"
	desc = "A pile of scrap. There's probably something cool in it."
	icon = 'icons/fallout/objects/crafting.dmi'
	color = "#FFFFFF"
	icon_state = "Junk_2"
	anchored = TRUE
	density = FALSE
	stuffspawn = /obj/effect/spawner/lootdrop/f13/uncommon
	howmany_min = 1
	howmany_max = 2

//rare loot pile, drops 1 or 2 of our rare loot drops
/obj/item/storage/trash_stack/loot/rare	//obj/effect/spawner/lootdrop/f13/rare
	name = "pile of valuables"
	desc = "A pile of valuable-looking objects. There's gotta be something useful in there."
	icon = 'icons/fallout/objects/crafting.dmi'
	color = "#FFFFFF"
	icon_state = "Junk_6"
	anchored = TRUE
	density = FALSE
	stuffspawn = /obj/effect/spawner/lootdrop/f13/rare
	howmany_min = 1
	howmany_max = 2

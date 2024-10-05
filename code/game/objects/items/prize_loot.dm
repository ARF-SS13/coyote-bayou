/obj/item/lockpick_set
	name = "lockpicking set"
	desc = "A set of tools dedicated to lockpicking, intended for quick bypassing of low-security locks."
	icon = 'icons/obj/fallout/lockbox.dmi'
	icon_state = "basic_lockpick"
	var/in_use = FALSE
	w_class = WEIGHT_CLASS_TINY
	var/uses_left = 4 			// Might need more.  Needs Playtesting.
	var/success_chance = 20 	// out of 100
	var/break_chance = 20 		// after failing a check. so yes, technically less overall.
	var/lockpick_tier = 1		// some locked boxes require higher tier lockpicks

/obj/item/lockpick_set/improved
	name = "improved lockpicking set"
	desc = "A set of better lockpicking tools."
	icon_state = "advanced_lockpick"
	uses_left = 6
	success_chance = 40
	break_chance = 10
	lockpick_tier = 2

/obj/item/lockpick_set/Initialize()
	. = ..()
	//uses_left = rand(2, initial(src.uses_left))

/obj/item/lockpick_set/examine(mob/user)
	. = ..()
	if(uses_left > 1)
		. += span_notice("It looks like it can take about [uses_left] bad twists before it breaks.")
	else
		. += span_notice("It looks like it's about to tear in half!")

/obj/item/lockpick_set/proc/use_pick(mob/user)
	uses_left--
	switch(uses_left)
		if(1)
			if(user)
				user.show_message("Your lockpick almost snaps!")
			playsound(get_turf(src),'sound/items/Wirecutter.ogg',75, 1, ignore_walls = FALSE)
		if(-INFINITY to 0)
			if(user)
				user.show_message("Your lockpick broke!!!")
			playsound(get_turf(src),'sound/items/Wirecutter.ogg',100, 1, ignore_walls = FALSE)
			qdel(src)
			return

/obj/item/locked_box
	name = "locked box"
	desc = "An object that contains objects that may be useful."
	icon = 'icons/obj/fallout/lockbox.dmi'
	icon_state = "locked_safe"

	//the lists the locked crate will combine
	//this uses pick, not pickweight, so no weighted lists please
	var/list/global_loot_lists = list()
	//the list that is compiled from the combined global loot lists
	var/list/potential_prizes = list()
	//the amount of items chosen from the potential prizes, minimum of 1 obviously, don't put too much
	var/prize_amount = 1
	//the items chosen from the potential prizes
	var/list/prizes = list()
	//intended 5 lock tiers, luck SPECIAL affects, from 1-5
	var/lock_tier = 1
	//either true or false; you got two chances with a screwdriver
	//when true, will get destroyed if not opened correctly; when false, will be set to true if it was not opened correctly (screwdriver)
	var/fragile = FALSE
	//oh boy, somebody trapped this poor crate and it will give the next 'winner' a real 'prize'
	var/trapped = FALSE
	//whether its locked or not, will allow it to either open or not
	var/locked = TRUE
	//so you can't spam click the locked crate
	var/used = FALSE
	//this will just add whatever is here right before locked crate
	//example: prefall clothing locked crate
	var/easy_naming = ""
	//this makes it to where one can either allow or disallow the addition of the loot tables
	var/enable_loot_initialize = TRUE
	//this is the probability that the lockbox will just open on spawn
	var/prob_open = 40

/obj/item/locked_box/Initialize(mapload)
	. = ..()
	name = "[easy_naming][initial(name)]"
	if(enable_loot_initialize)
		initialize_prizes()
	if(mapload)
		if(!locked || prob(prob_open))
			spawn_prizes()

/obj/item/locked_box/examine(mob/user)
	. = ..()
	if(locked)
		switch(lock_tier)
			if(1)
				. += "The lock looks simple."
			if(2)
				. += "The lock looks somewhat easy."
			if(3)
				. += "The lock looks average."
			if(4)
				. += "The lock looks a little hard."
			if(5)
				. += "The lock looks very difficult."
	if(!locked)
		. += "[src] appears to be unlocked."
	if(fragile)
		. += "There are cracks, [src] may crumble from any sudden movements."
	if(user.client.prefs.special_p >= 8)
		if(trapped)
			. += "The lock looks tampered with."
		. += "There [prize_amount > 1 ? "are" : "is"] [prize_amount] [prize_amount > 1 ? "objects" : "object"]."

/obj/item/locked_box/proc/initialize_prizes()
	if(!global_loot_lists.len)
		return // Stop proceeding if we have no prizes.

	potential_prizes = list() //we are setting them to an empty list so you can't double the amount of stuff
	prizes = list()
	for(var/i in global_loot_lists) //go back up to understand why we populate potential_prizes
		for(var/ii in i)
			potential_prizes += ii
	for(var/iii in 1 to prize_amount) //go back up to understand why we populate prizes
		prizes += pick(potential_prizes)

/obj/item/locked_box/proc/spawn_prizes()
	if(trapped) //gnarly
		spawn(3 SECONDS)
			explosion(src, 0,0,1, flame_range = 2)
			qdel(src)
		return
	var/turf/prize_turf = get_turf(src)
	for(var/prize in prizes)
		new prize(prize_turf)
	qdel(src) //NO MORE, YOU MUST DIE AFTER SPAWNING

/obj/item/locked_box/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/screwdriver))

		if(!locked)
			return

		var/success_after_tier = max(100 - (lock_tier * 20), 0) / 2 //the higher the lock tier, the harder it is, down to a max of 0, divided by 2
		if(!prob(success_after_tier))
			if(fragile)
				to_chat(user, span_warning("You fail to open [src]. It crumbles apart, all the contents being destroyed."))
				qdel(src)
				return
			to_chat(user, span_warning("You fail to unlock [src]. It looks like it took some damage from the attempt."))
			fragile = TRUE
			return
		to_chat(user, span_green("You successfully unlock [src]."))
		locked = FALSE
		return

	else if(istype(W, /obj/item/lockpick_set))
		if(!locked)
			return

		var/obj/item/lockpick_set/tool = W
		if(lock_tier > 3 && tool.lockpick_tier < 2)
			to_chat(user, span_warning("You need a better set of tools to get past security measures like this!"))
			return

		var/success_after_tier = max(100 - (lock_tier * 20), 0) //the higher the lock tier, the harder it is, down to a max of 0
		var/success_after_skill = min((user.client.prefs.special_p * 5) + success_after_tier, 100) //the higher the persons perception, the better, up to a max of 100, with 50 added
		if(!prob(success_after_skill))
			to_chat(user, span_warning("You fail to pick [src]."))
			return
		to_chat(user, span_green("You successfully unlock [src]."))
		locked = FALSE
		return
	else
		return ..()

/obj/item/locked_box/attack_self(mob/user)
	. = ..()
	if(!locked)
		if(used)
			return
		used = TRUE
		spawn_prizes()
		return
	to_chat(user, span_warning("[src] is locked up tight, perhaps you can open it?"))

/************
*** ARMOR ***
************/

/obj/item/locked_box/armor
	easy_naming = "armor "
	prize_amount = 4

/obj/item/locked_box/armor/prefall_clothes
	easy_naming = "prefall clothing "
	prize_amount = 4

/obj/item/locked_box/armor/prefall_clothes/initialize_prizes()
	global_loot_lists = list(GLOB.loot_prefall_clothing)
	. = ..()

/obj/item/locked_box/armor/prefall_costumes
	easy_naming = "prefall costumes "
	prize_amount = 4

/obj/item/locked_box/armor/prefall_costumes/initialize_prizes()
	global_loot_lists = list(GLOB.loot_prefall_costume)
	. = ..()

/obj/item/locked_box/armor/tier1
	lock_tier = 1

/obj/item/locked_box/armor/tier1/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_armor)
	. = ..()

/obj/item/locked_box/armor/tier2
	lock_tier = 2

/obj/item/locked_box/armor/tier2/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t2_armor)
	. = ..()

/obj/item/locked_box/armor/tier3
	lock_tier = 3

/obj/item/locked_box/armor/tier3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_armor)
	. = ..()

/obj/item/locked_box/armor/tier4
	lock_tier = 4

/obj/item/locked_box/armor/tier4/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t4_armor)
	. = ..()

/obj/item/locked_box/armor/tier5
	lock_tier = 5

/obj/item/locked_box/armor/tier5/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t5_armor)
	. = ..()

/obj/item/locked_box/armor/any_random
	lock_tier = 3

/obj/item/locked_box/armor/any_random/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_armor, GLOB.loot_t2_armor, GLOB.loot_t3_armor, GLOB.loot_t4_armor)
	. = ..()

/obj/item/locked_box/armor/tier1_3
	lock_tier = 2

/obj/item/locked_box/armor/tier1_3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_armor, GLOB.loot_t2_armor, GLOB.loot_t3_armor)
	. = ..()

/obj/item/locked_box/armor/tier3_5
	lock_tier = 4

/obj/item/locked_box/armor/tier3_5/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_armor, GLOB.loot_t4_armor, GLOB.loot_t5_armor)
	. = ..()

/**************
*** MEDICAL ***
**************/

/obj/item/locked_box/medical/surgical_tool
	easy_naming = "surgical tool "
	prize_amount = 1

/obj/item/locked_box/medical/surgical_tool/initialize_prizes()
	global_loot_lists = list(GLOB.loot_medical_tool)
	. = ..()

/obj/item/locked_box/medical/medicine
	easy_naming = "medicine "
	prize_amount = 2

/obj/item/locked_box/medical/medicine/initialize_prizes()
	global_loot_lists = list(GLOB.loot_medical_medicine)
	. = ..()

/obj/item/locked_box/medical/drugs
	easy_naming = "drug "
	prize_amount = 2

/obj/item/locked_box/medical/drugs/initialize_prizes()
	global_loot_lists = list(GLOB.loot_medical_drug)
	. = ..()

/*************
*** WEAPON ***
*************/

/obj/item/locked_box/weapon

/************
*** MELEE ***
************/

/obj/item/locked_box/weapon/melee
	easy_naming = "melee "
	prize_amount = 1

/obj/item/locked_box/weapon/melee/tier1
	lock_tier = 1

/obj/item/locked_box/weapon/melee/tier1/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_melee)
	. = ..()

/obj/item/locked_box/weapon/melee/tier2
	lock_tier = 2

/obj/item/locked_box/weapon/melee/tier2/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t2_melee)
	. = ..()

/obj/item/locked_box/weapon/melee/tier3
	lock_tier = 3

/obj/item/locked_box/weapon/melee/tier3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_melee)
	. = ..()

/obj/item/locked_box/weapon/melee/tier4
	lock_tier = 4

/obj/item/locked_box/weapon/melee/tier4/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t4_melee)
	. = ..()

/obj/item/locked_box/weapon/melee/tier5
	lock_tier = 5

/obj/item/locked_box/weapon/melee/tier5/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t5_melee)
	. = ..()

/obj/item/locked_box/weapon/melee/any_random
	lock_tier = 3

/obj/item/locked_box/weapon/melee/any_random/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_melee, GLOB.loot_t2_melee, GLOB.loot_t3_melee, GLOB.loot_t4_melee)
	. = ..()

/obj/item/locked_box/weapon/melee/tier1_3
	lock_tier = 2

/obj/item/locked_box/weapon/melee/tier1_3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_melee, GLOB.loot_t2_melee, GLOB.loot_t3_melee)
	. = ..()

/obj/item/locked_box/weapon/melee/tier3_5
	lock_tier = 4

/obj/item/locked_box/weapon/melee/tier3_5/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_melee, GLOB.loot_t4_melee, GLOB.loot_t5_melee)
	. = ..()

/**********
*** GUN ***
**********/

/obj/item/locked_box/weapon/range
	easy_naming = "gun "
	prize_amount = 5

/obj/item/locked_box/weapon/range/tier1
	lock_tier = 1

/obj/item/locked_box/weapon/range/tier1/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_range)
	. = ..()

/obj/item/locked_box/weapon/range/tier2
	lock_tier = 2

/obj/item/locked_box/weapon/range/tier2/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t2_range)
	. = ..()

/obj/item/locked_box/weapon/range/tier3
	lock_tier = 3

/obj/item/locked_box/weapon/range/tier3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_range)
	. = ..()

/obj/item/locked_box/weapon/range/tier4
	lock_tier = 4

/obj/item/locked_box/weapon/range/tier4/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t4_range)
	. = ..()

/obj/item/locked_box/weapon/range/tier5
	lock_tier = 5
	prize_amount = 1

/obj/item/locked_box/weapon/range/tier5/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t5_range)
	. = ..()

/obj/item/locked_box/weapon/range/unique
	lock_tier = 5
	prize_amount = 1

/obj/item/locked_box/weapon/range/unique/initialize_prizes()
	global_loot_lists = list(GLOB.loot_unique_range)
	. = ..()

/obj/item/locked_box/weapon/range/any_random
	lock_tier = 3

/obj/item/locked_box/weapon/range/any_random/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_range, GLOB.loot_t2_range, GLOB.loot_t3_range, GLOB.loot_t4_range)
	. = ..()

/obj/item/locked_box/weapon/range/tier1_3
	lock_tier = 2

/obj/item/locked_box/weapon/range/tier1_3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_range, GLOB.loot_t2_range, GLOB.loot_t3_range)
	. = ..()

/obj/item/locked_box/weapon/range/tier3_5
	lock_tier = 4
	prize_amount = 1

/obj/item/locked_box/weapon/range/tier3_5/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_range, GLOB.loot_t4_range, GLOB.loot_t5_range)
	. = ..()

/***********
*** AMMO ***
***********/

/obj/item/locked_box/weapon/ammo
	easy_naming = "ammo "
	prize_amount = 4

/obj/item/locked_box/weapon/ammo/tier1
	lock_tier = 1

/obj/item/locked_box/weapon/ammo/tier1/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_ammo)
	. = ..()

/obj/item/locked_box/weapon/ammo/tier2
	lock_tier = 2

/obj/item/locked_box/weapon/ammo/tier2/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t2_ammo)
	. = ..()

/obj/item/locked_box/weapon/ammo/tier3
	lock_tier = 3

/obj/item/locked_box/weapon/ammo/tier3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_ammo)
	. = ..()

/obj/item/locked_box/weapon/ammo/tier4
	lock_tier = 4

/obj/item/locked_box/weapon/ammo/tier4/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t4_ammo)
	. = ..()

/obj/item/locked_box/weapon/ammo/tier5
	lock_tier = 5

/obj/item/locked_box/weapon/ammo/tier5/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t5_ammo)
	. = ..()

/***********
*** MISC ***
***********/

/obj/item/locked_box/misc
	prize_amount = 3
	locked = FALSE

/obj/item/locked_box/misc/garbage

/obj/item/locked_box/misc/garbage/initialize_prizes()
	global_loot_lists = list(GLOB.loot_garbage)
	. = ..()

/obj/item/locked_box/misc/seed
	easy_naming = "seed "
	prize_amount = 5

/obj/item/locked_box/misc/seed/initialize_prizes()
	global_loot_lists = list(GLOB.loot_seed)
	. = ..()

/obj/item/locked_box/misc/food
	easy_naming = "food "

/obj/item/locked_box/misc/food/initialize_prizes()
	global_loot_lists = list(GLOB.loot_food)
	. = ..()

/obj/item/locked_box/misc/alcohol
	easy_naming = "alcohol "

/obj/item/locked_box/misc/alcohol/initialize_prizes()
	global_loot_lists = list(GLOB.loot_alcohol)
	. = ..()

/obj/item/locked_box/misc/crafting
	easy_naming = "crafting "

/obj/item/locked_box/misc/crafting/initialize_prizes()
	global_loot_lists = list(GLOB.loot_craft_basic)
	. = ..()

/obj/item/locked_box/misc/crafting/advanced
	prize_amount = 2
	locked = TRUE

/obj/item/locked_box/misc/crafting/advanced/initialize_prizes()
	global_loot_lists = list(GLOB.loot_craft_advanced)
	. = ..()

/obj/item/locked_box/misc/resource
	easy_naming = "resource "

/obj/item/locked_box/misc/resource/initialize_prizes()
	global_loot_lists = list(GLOB.loot_material)
	. = ..()

/obj/item/locked_box/misc/money
	easy_naming = "money "
	prize_amount = 1
	locked = TRUE

/obj/item/locked_box/misc/money/all

/obj/item/locked_box/misc/money/all/low
	lock_tier = 1
	locked = FALSE

/obj/item/locked_box/misc/money/all/low/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_money)
	. = ..()

/obj/item/locked_box/misc/money/all/medium
	lock_tier = 2

/obj/item/locked_box/misc/money/all/medium/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t2_money)
	. = ..()

/obj/item/locked_box/misc/money/all/high
	lock_tier = 3

/obj/item/locked_box/misc/money/all/high/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_money)
	. = ..()

/obj/item/locked_box/misc/money/legion
	enable_loot_initialize = FALSE

/obj/item/locked_box/misc/money/legion/low
	lock_tier = 1
	prizes = list(/obj/item/stack/f13Cash/random/denarius/low)
	locked = FALSE

/obj/item/locked_box/misc/money/legion/medium
	lock_tier = 2
	prizes = list(/obj/item/stack/f13Cash/random/denarius/med)

/obj/item/locked_box/misc/money/legion/high
	lock_tier = 3
	prizes = list(/obj/item/stack/f13Cash/random/denarius/high)

/obj/item/locked_box/misc/money/ncr
	enable_loot_initialize = FALSE

/obj/item/locked_box/misc/money/ncr/low
	lock_tier = 1
	prizes = list(/obj/item/stack/f13Cash/random/ncr/low)
	locked = FALSE

/obj/item/locked_box/misc/money/ncr/medium
	lock_tier = 2
	prizes = list(/obj/item/stack/f13Cash/random/ncr/med)

/obj/item/locked_box/misc/money/ncr/high
	lock_tier = 3
	prizes = list(/obj/item/stack/f13Cash/random/ncr/high)

/obj/item/locked_box/misc/skillbook
	easy_naming = "book "
	prize_amount = 1
	locked = TRUE
	lock_tier = 3

/obj/item/locked_box/misc/skillbook/initialize_prizes()
	global_loot_lists = list(GLOB.loot_skillbook)
	. = ..()

/obj/item/locked_box/misc/attachments
	easy_naming = "attachment "
	prize_amount = 1
	locked = TRUE
	lock_tier = 3
/*
/obj/item/locked_box/misc/attachments/initialize_prizes()
	global_loot_lists = list(GLOB.loot_attachment)
	. = ..()
*/
/obj/item/locked_box/misc/blueprints
	easy_naming = "blueprint "
	locked = TRUE
	prize_amount = 1

/obj/item/locked_box/misc/blueprints/tier1
	lock_tier = 2

/obj/item/locked_box/misc/blueprints/tier1/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t1_blueprint)
	. = ..()

/obj/item/locked_box/misc/blueprints/tier2
	lock_tier = 3

/obj/item/locked_box/misc/blueprints/tier2/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t2_blueprint)
	. = ..()

/obj/item/locked_box/misc/blueprints/tier3
	lock_tier = 4

/obj/item/locked_box/misc/blueprints/tier3/initialize_prizes()
	global_loot_lists = list(GLOB.loot_t3_blueprint)
	. = ..()

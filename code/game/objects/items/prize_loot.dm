/obj/item/lockpick_set
	name = "lockpicking set"
	desc = "A set of tools dedicated to lockpicking, intended for the novice to the master."
	icon = 'icons/obj/fallout/lockbox.dmi'
	icon_state = "basic_lockpick"
	var/in_use = FALSE
	w_class = WEIGHT_CLASS_TINY
	var/uses_left = 6 //15% chance to success, might need more.  Needs Playtesting.
	var/min_uses_left = 2

/obj/item/lockpick_set/bobby_pin
	name = "a bobby pin"
	desc = "Doubles up as a basic lockpicking instrument."
	uses_left = 1
	min_uses_left = 1

/obj/item/lockpick_set/Initialize()
	. = ..()
	uses_left = rand(initial(src.min_uses_left), initial(src.uses_left))

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
	desc = "An object that contains objects that may be useful. It can be unlocked with either a screwdriver or a picking set. Alternatively a welder can be used."
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
	//example: prewar clothing locked crate
	var/easy_naming = ""
	//this makes it to where one can either allow or disallow the addition of the loot tables
	var/enable_loot_initialize = TRUE
	//this is the probability that the lockbox will just open on spawn
	var/prob_open = 30

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
	if(user.client.prefs.special_p >= 8 || user.skill_check(SKILL_TRAPS, REGULAR_CHECK))
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

/obj/item/locked_box/proc/spawn_prizes(mob/user)
	if(trapped && istype(user)) //gnarly
		if (!user.skill_roll(SKILL_TRAPS, DIFFICULTY_CHALLENGE))
			spawn(3 SECONDS)
				explosion(src, 0,0,1, flame_range = 2)
				qdel(src)
			return
		else
			to_chat(user, span_danger("You manage to defuse the bomb that was on the lock."))
	var/turf/prize_turf = get_turf(src)
	for(var/prize in prizes)
		new prize(prize_turf)
	qdel(src) //NO MORE, YOU MUST DIE AFTER SPAWNING

/obj/item/locked_box/attackby(obj/item/W, mob/user, params)
	var/skill_threshold = EXPERT_CHECK
	var/skill_roll_difficulty = DIFFICULTY_EXPERT
	var/skill_repair_roll_difficulty = DIFFICULTY_EXPERT
	switch(lock_tier)
		if(1)
			skill_threshold = 20
			skill_roll_difficulty = -30
			skill_repair_roll_difficulty = DIFFICULTY_EASY
		if(2)
			skill_threshold = EASY_CHECK
			skill_roll_difficulty = DIFFICULTY_EASY
			skill_repair_roll_difficulty = DIFFICULTY_NORMAL
		if(3)
			skill_threshold = REGULAR_CHECK
			skill_roll_difficulty = DIFFICULTY_NORMAL
			skill_repair_roll_difficulty = DIFFICULTY_CHALLENGE
		if(4)
			skill_threshold = HARD_CHECK
			skill_roll_difficulty = DIFFICULTY_CHALLENGE
			skill_repair_roll_difficulty = DIFFICULTY_EXPERT
		if(5)
			skill_threshold = EXPERT_CHECK
			skill_roll_difficulty = DIFFICULTY_EXPERT
			skill_repair_roll_difficulty = 30
	if(istype(W, /obj/item/screwdriver))
		if(!locked)
			return
		if(!(user.skill_check(SKILL_LOCKPICK, (skill_threshold + 10)) || user.skill_roll(SKILL_LOCKPICK, (skill_roll_difficulty + 5))))
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
		var/obj/item/lockpick_set/P = W
		P.use_pick()
		if(!(user.skill_check(SKILL_LOCKPICK, skill_threshold) || user.skill_roll(SKILL_LOCKPICK, skill_roll_difficulty)))
			to_chat(user, span_warning("You fail to pick [src]."))
			return
		to_chat(user, span_green("You successfully unlock [src]."))
		locked = FALSE
		return
	else if (istype(W, /obj/item/weldingtool))
		var/obj/item/weldingtool/welder = W
		if(!locked || !welder.welding)
			return
		welder.use(2)
		if(!user.skill_roll(SKILL_REPAIR, skill_repair_roll_difficulty))
			to_chat(user, span_warning("You fail to open [src]. It crumbles apart, all the contents being destroyed."))
			qdel(src)
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
		spawn_prizes(user)
		return
	to_chat(user, span_warning("[src] is locked up tight, perhaps you can open it?"))

/************
*** ARMOR ***
************/

/obj/item/locked_box/armor
	easy_naming = "armor "
	prize_amount = 4

/obj/item/locked_box/armor/prewar_clothes
	easy_naming = "prewar clothing "
	prize_amount = 4

/obj/item/locked_box/armor/prewar_clothes/initialize_prizes()
	global_loot_lists = list(GLOB.loot_prewar_clothing)
	. = ..()

/obj/item/locked_box/armor/prewar_costumes
	easy_naming = "prewar costumes "
	prize_amount = 4

/obj/item/locked_box/armor/prewar_costumes/initialize_prizes()
	global_loot_lists = list(GLOB.loot_prewar_costume)
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

/obj/item/locked_box/misc/attachments/initialize_prizes()
	global_loot_lists = list(GLOB.loot_attachment)
	. = ..()

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

/* 
 * File:   item_quests.dm
 * Author: @Superlagg - Kristoffer Pedersen Ylvisåker - Quality Assurance (QA) - 2017 - Kristiania University College Lillestrøm Grd. Summative Assignment. for the course: "Programming for Interactivity" - 1st year - 2017 - 2024 - 2018, 2019, 2020, 2021, 2022, 2023, 2024; all rights reserved - Kristoffer Pedersen Ylvisåker
 * Last modified by: @Superlagg - Kristoffer Pedersen Ylvisåker
 * Last modified: 2017-12-14
 * Description:  "Item Quests" - Dream Maker
 * 
 * It was at this point that Superlagg Kristoffer Pedersen Ylvisåker realized that writing quests for every interesting item would be cocknballtorture
 * They then realized they could just make BYOND do it for them
 */


/datum/bounty/item
	base_reward =         COINS(20)
	medium_reward_bonus = COINS(10)
	hard_reward_bonus =   COINS(20)
	CBT_reward_bonus =    COINS(30)
	flavor_kind = QUEST_KIND_COLLECT_ITEMS
	candupe = TRUE

/datum/bounty/item/validball
	name = "Scan the Mysterious Keycard"
	description = "I've heard rumors of an anomalous keycard with untold powers. Powers that have yet to be told, cus nobody's really sure what it does. \
		Find it and scan it for me, will you?"
	flavor_focus = /obj/item/validball
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/validball,
	)
	difficulty = QUEST_DIFFICULTY_HARD

/datum/bounty_quota/validball
	name = "Mysterious Keycard"
	flavor = "Why do they call it a key card when you card in the key card and card key card out the key card?"
	paths = list(
		/obj/item/validball,
	)
	needed_amount = 1
	price_per_thing = COINS(200)
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 3
	delete_thing = FALSE // It doesnt delete well, so, yeah

/datum/bounty/item/blackbox
	name = "Black Box"
	description = "The Junkers off in Mass Fusion have been collecting black boxes from the wrecks of transdimensional ships. Apparently they contain a lot of valuable data. Go steal one for me."
	flavor_focus = /obj/item/blackbox
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/blackbox,
	)
	difficulty = QUEST_DIFFICULTY_MED

/datum/bounty_quota/blackbox
	name = "Black Box"
	flavor = "Might be in Mass Fusion?"
	paths = list(
		/obj/item/blackbox,
	)
	needed_amount = 1
	price_per_thing = COINS(50)
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 3

/datum/bounty/item/trash_easy
	name = "Urban Exploration"
	description = "They say you can tell a lot about a person by what they throw away. I say you can tell a lot about a person by what they leave lying around. I need you to bring me some trash. The more the better."
	flavor_focus = /obj/item
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
	)
	difficulty = QUEST_DIFFICULTY_EASY
	is_laggy_as_hell = TRUE

/datum/bounty/item/trash_medium
	name = "Urban Excavation"
	description = "They say you can tell a lot about a person by what they throw away. I say you can tell a lot about a person by what they leave lying around. I need you to bring me some trash. The more the better."
	flavor_focus = /obj/item
	weight = 10
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
	)
	difficulty = QUEST_DIFFICULTY_MED
	is_laggy_as_hell = TRUE

/datum/bounty/item/trash_hard
	name = "Urban Expedition"
	description = "They say you can tell a lot about a person by what they throw away. I say you can tell a lot about a person by what they leave lying around. I need you to bring me some trash. The more the better."
	flavor_focus = /obj/item
	weight = 10
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
	)
	difficulty = QUEST_DIFFICULTY_HARD
	is_laggy_as_hell = TRUE

/datum/bounty/item/trash_CBT
	name = "Urban Excoriation"
	description = "They say you can tell a lot about a person by what they throw away. I say you can tell a lot about a person by what they leave lying around. I need you to bring me some trash. The more the better."
	flavor_focus = /obj/item
	weight = 10
	request_mode = QUEST_FULFILL_ALL
	init_wanteds = list(
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
		/datum/bounty_quota/random_items,
	)
	difficulty = QUEST_DIFFICULTY_CBT
	is_laggy_as_hell = TRUE

/datum/bounty_quota/random_items
	name = "Get some (thing)"
	paths = list()
	needed_amount = 1
	paths_get_subtypes = TRUE
	paths_includes_root = TRUE
	price_per_thing = COINS(20)
	easy_multiplier = 1
	medium_multiplier = 1.5
	hard_multiplier = 2
	CBT_multiplier = 5

/datum/bounty_quota/random_items/GetPaths()
	if(is_copy)
		return
	var/list/potentials = SSatoms.GetExistingAtomsOfPath(/obj/item)
	if(!LAZYLEN(potentials)) // unlikely but hey
		paths = list(/mob/living/carbon/human) // YOU
		return
	paths = list(pick(potentials)) // guaranteed fresh at time of baking












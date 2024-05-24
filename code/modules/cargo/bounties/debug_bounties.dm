//Moved (most) bounties requiring botany to gardencook.dm Roundstart cook bounties go here.

/datum/bounty/debug_1
	name = "Stuck ru head in a microwave"
	description = "I need a head stuck in a microwave. I don't care if it's alive or dead, just get it to me. I'll pay you 1000 credits for it. If you can get it to me in one piece, I'll throw in an extra 100 credits. If you can get it to me alive, I'll throw in an extra 300 credits. If you can get it to me alive and in one piece, I'll throw in an extra 500 credits."
	base_reward = 1000 // In credits.
	medium_reward_bonus = 100 // In credits.
	hard_reward_bonus = 300 // In credits.
	CBT_reward_bonus = 500 // In credits.
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	wanted_things = list(
		new /datum/bounty_quota(
			"Get Head",
			"Get a head stuck in a microwave to the bounty giver.",
			list(
				/obj/item/organ/brain,
				/obj/item/organ/genital/breasts,
			),
			1,
			TRUE,
		),
		new /datum/bounty_quota/monkeys(),
		new /datum/bounty_quota/literally_any_item()
	)
	difficulty = QUEST_DIFFICULTY_EASY
	difficulty_flags = NONE

/datum/bounty/debug_2
	name = "Mash the potatoes"
	description = "I need a potato. I don't care if it's alive or dead, just get it to me. I'll pay you 1000 credits for it. If you can get it to me in one piece, I'll throw in an extra 100 credits. If you can get it to me alive, I'll throw in an extra 300 credits. If you can get it to me alive and in one piece, I'll throw in an extra 500 credits."
	base_reward = 1000 // In credits.
	medium_reward_bonus = 100 // In credits.
	hard_reward_bonus = 300 // In credits.
	CBT_reward_bonus = 500 // In credits.
	weight = 1
	request_mode = QUEST_FULFILL_ALL
	wanted_things = list(
		new /datum/bounty_quota/literally_any_item(),
		new /datum/bounty_quota/literally_any_item(),
		new /datum/bounty_quota/literally_any_item(),
		new /datum/bounty_quota/literally_any_item(),
		new /datum/bounty_quota/literally_any_item(),
		new /datum/bounty_quota/literally_any_item(),
		new /datum/bounty_quota/literally_any_item(),
	)
	difficulty = QUEST_DIFFICULTY_EASY
	difficulty_flags = NONE

/datum/bounty/debug_3
	name = "Five Deathclaw Steaks"
	base_reward = 1000 // In credits.
	medium_reward_bonus = 100 // In credits.
	hard_reward_bonus = 300 // In credits.
	CBT_reward_bonus = 500 // In credits.
	weight = 10
	request_mode = QUEST_FULFILL_ALL
	wanted_things = list(
		new /datum/bounty_quota/aethergiest_steak(5),
	)
	difficulty = QUEST_DIFFICULTY_EASY
	difficulty_flags = NONE


/datum/bounty_quota/aethergiest_steak
	name = "Deliver some aethergiest steaks"
	info = "Can accept any type of aethergiest steak."
	paths = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/aethergiest
	)
	needed_amount = 1
	auto_generate_info = TRUE
	pick_this_many = 1
	paths_get_subtypes = TRUE

/datum/bounty_quota/aethergiest_steak/setzup()
	. = ..()
	needed_amount = rand(1, 25)

/datum/bounty_quota/monkeys
	name = "Deliver dead monkeys"
	info = "Can accept any type of monkey, but they must be dead."
	paths = list(
		/mob/living/carbon/monkey
	)
	needed_amount = 10
	auto_generate_info = TRUE
	mobs_must_be_dead = TRUE
	pick_this_many = 2
	paths_get_subtypes = TRUE

/datum/bounty_quota/literally_any_item
	name = "Deliver literally any item"
	info = "Can accept any item."
	paths = list(
		/obj/item
	)
	needed_amount = 5
	auto_generate_info = TRUE
	pick_this_many = 10
	paths_get_subtypes = TRUE



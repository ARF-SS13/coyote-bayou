/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui state: quest_state
 *
 * Checks a number of things -- mostly physical distance for humans
 * and view for robots.
 */

GLOBAL_DATUM_INIT(quest_window_state, /datum/ui_state/quest_window, new)

/datum/ui_state/quest_window/can_use_topic(src_object, mob/user)
	if(!istype(src_object, /datum/quest_window)) // wouldnt work otherwise
		return UI_CLOSE
	var/datum/quest_window/quest = src_object
	var/datum/bounty/B
	if(quest.is_active_quest)
		B = LAZYACCESS(quest.parent.active_quests, quest.viewing_uid)
	else
		B = SSeconomy.get_quest_by_uid(quest.viewing_uid)
	if(!B)
		return UI_CLOSE
	return UI_INTERACTIVE

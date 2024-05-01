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

GLOBAL_DATUM_INIT(quest_book_state, /datum/ui_state/quest_book, new)

/datum/ui_state/quest_book/can_use_topic(src_object, mob/user)
	return UI_INTERACTIVE

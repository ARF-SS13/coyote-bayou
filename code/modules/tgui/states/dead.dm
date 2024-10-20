/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui state: dead
 *
 * Checks that the user is an observer/ghost.
 */

GLOBAL_DATUM_INIT(dead, /datum/ui_state/dead, new)

/datum/ui_state/dead/can_use_topic(src_object, mob/user)
	if(user.stat == DEAD || isdead(user))
		return UI_INTERACTIVE
	return UI_CLOSE


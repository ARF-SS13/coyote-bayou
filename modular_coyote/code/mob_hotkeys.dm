//For ease of control while playing as a mob.
/*
/datum/keybinding/simple_animal
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/datum/keybinding/simple_animal/can_use(client/user)
	return isanimal(user.mob)

/datum/keybinding/simple_animal/toggle_throw_mode
	hotkey_keys = list("R", "Southwest")
	name = "toggle_throw_mode"
	full_name = "Toggle throw mode"
	description = "Toggle throwing the current item or not."

/datum/keybinding/simple_animal/toggle_throw_mode/down(client/user)
	var/mob/living/simple_animal/M = user.mob
	M.toggle_throw_mode()
	return TRUE

/mob/living/simple_animal/proc/toggle_throw_mode()
	if(stat)
		return
	if(in_throw_mode)
		throw_mode_off()
	else
		throw_mode_on()

/mob/living/simple_animal/proc/throw_mode_off()
	in_throw_mode = 0
	if(client && hud_used)
		hud_used.throw_icon.icon_state = "act_throw_off"

/mob/living/simple_animal/proc/throw_mode_on()
	in_throw_mode = 1
	if(client && hud_used)
		hud_used.throw_icon.icon_state = "act_throw_on"

/datum/keybinding/simple_animal/select_help_intent
	hotkey_keys = list("1")
	name = "select_help_intent"
	full_name = "Select help intent"
	description = ""

/datum/keybinding/simple_animal/select_help_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_HELP)
	return TRUE

/datum/keybinding/simple_animal/select_disarm_intent
	hotkey_keys = list("2")
	name = "select_disarm_intent"
	full_name = "Select disarm intent"
	description = ""

/datum/keybinding/simple_animal/select_disarm_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_DISARM)
	return TRUE

/datum/keybinding/simple_animal/select_grab_intent
	hotkey_keys = list("3")
	name = "select_grab_intent"
	full_name = "Select grab intent"
	description = ""

/datum/keybinding/simple_animal/select_grab_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_GRAB)
	return TRUE

/datum/keybinding/simple_animal/select_harm_intent
	hotkey_keys = list("4")
	name = "select_harm_intent"
	full_name = "Select harm intent"
	description = ""

/datum/keybinding/simple_animal/select_harm_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_HARM)
	return TRUE

/datum/keybinding/simple_animal/wield 
	hotkey_keys = list("ShiftX")
	name = "wield_item"
	full_name = "Wield held item"
	description = ""

/datum/keybinding/simple_animal/wield/down(client/user)
	var/mob/living/simple_animal/M = user.mob
	M.do_wield()
	return TRUE
*/

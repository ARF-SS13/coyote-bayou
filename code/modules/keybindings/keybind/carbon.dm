/datum/keybinding/carbon
	category = CATEGORY_CARBON
	weight = WEIGHT_MOB

/datum/keybinding/carbon/can_use(client/user)
	if(iscarbon(user.mob))
		return TRUE
	if(isanimal(user.mob))
		return TRUE

/datum/keybinding/carbon/toggle_throw_mode
	hotkey_keys = list("R", "Southwest") // END
	name = "toggle_throw_mode"
	full_name = "Toggle throw mode"
	description = "Toggle throwing the current item or not."
	category = CATEGORY_CARBON

/datum/keybinding/carbon/toggle_throw_mode/down(client/user)
	if(iscarbon(user.mob))
		var/mob/living/carbon/C = user.mob
		C.toggle_throw_mode()
		return TRUE
	if(isanimal(user.mob))
		var/mob/living/simple_animal/A = user.mob
		A.toggle_throw_mode()
		return TRUE

/datum/keybinding/carbon/select_help_intent
	hotkey_keys = list("1")
	name = "select_help_intent"
	full_name = "Select help intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_help_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_HELP)
	return TRUE

/datum/keybinding/carbon/select_disarm_intent
	hotkey_keys = list("2")
	name = "select_disarm_intent"
	full_name = "Select disarm intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_disarm_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_DISARM)
	return TRUE

/datum/keybinding/carbon/select_grab_intent
	hotkey_keys = list("3")
	name = "select_grab_intent"
	full_name = "Select grab intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_grab_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_GRAB)
	return TRUE

/datum/keybinding/carbon/select_harm_intent
	hotkey_keys = list("4")
	name = "select_harm_intent"
	full_name = "Select harm intent"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/select_harm_intent/down(client/user)
	user.mob?.a_intent_change(INTENT_HARM)
	return TRUE

/datum/keybinding/carbon/wield 
	hotkey_keys = list("ShiftX")
	name = "wield_item"
	full_name = "Wield held item"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/wield/down(client/user)
	if(iscarbon(user.mob))
		var/mob/living/carbon/C = user.mob
		C.do_wield()
		return TRUE
	else if(isanimal(user.mob))
		var/mob/living/simple_animal/A = user.mob
		A.do_wield()
		return TRUE

/datum/keybinding/carbon/questscanner 
	hotkey_keys = list("J")
	name = "quest_scanner_pls"
	full_name = "Get quest scanner"
	description = ""
	category = CATEGORY_CARBON

/datum/keybinding/carbon/questscanner/down(client/user)
	SSeconomy.give_claimer(usr, usr)

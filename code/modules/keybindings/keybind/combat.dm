/datum/keybinding/living/toggle_combat_mode
	hotkey_keys = list("C")
	name = "toggle_combat_mode"
	full_name = "Toggle combat mode"
	category = CATEGORY_COMBAT
	description = "Toggles whether or not you're in combat mode."

/datum/keybinding/living/toggle_combat_mode/down(client/user)
	SEND_SIGNAL(user.mob, COMSIG_TOGGLE_COMBAT_MODE)
	return TRUE

/datum/keybinding/living/active_block
	hotkey_keys = list("Northwest", "F") // HOME
	name = "active_block"
	full_name = "Block (Hold)"
	category = CATEGORY_COMBAT
	description = "Hold down to actively block with your currently in-hand object."

/datum/keybinding/living/active_block/down(client/user)
	var/mob/living/L = user.mob
	L.keybind_start_active_blocking()
	return TRUE

/datum/keybinding/living/active_block/up(client/user)
	var/mob/living/L = user.mob
	L.keybind_stop_active_blocking()

/datum/keybinding/living/active_block_toggle
	hotkey_keys = list("Unbound")
	name = "active_block_toggle"
	full_name = "Block (Toggle)"
	category = CATEGORY_COMBAT
	description = "Toggles active blocking system using currenet in hand object, or any found object if applicable."

/datum/keybinding/living/active_block_toggle/down(client/user)
	var/mob/living/L = user.mob
	L.keybind_toggle_active_blocking()
	return TRUE

/datum/keybinding/living/active_parry
	hotkey_keys = list("Insert", "G")
	name = "active_parry"
	full_name = "Parry"
	category = CATEGORY_COMBAT
	description = "Press to initiate a parry sequence with your currently in-hand object."

/datum/keybinding/living/active_parry/down(client/user)
	var/mob/living/L = user.mob
	L.keybind_parry()
	return TRUE

//-->Gun safety toggle hotkey
/datum/keybinding/living/gunsafety
	hotkey_keys = list(",")
	name = "gunsafety"
	full_name = "Gun Safety Toggle"
	category = CATEGORY_COMBAT
	description = "Toggle your weapon's safety."

/datum/keybinding/living/gunsafety/down(client/user)
	var/mob/living/carbon/C = user.mob
	var/obj/item/gun/firearm
	
	for(var/obj/item/gun/F in C.held_items)
		firearm = F
		break
	if(!istype(firearm))
		return FALSE
	. = ..()
	firearm.ui_action_click(usr, "safety")
	return TRUE

//-->Gun scope toggle hotkey
/datum/keybinding/living/gunscope
	hotkey_keys = list(".")
	name = "gunscope"
	full_name = "Gun Scope Toggle"
	category = CATEGORY_COMBAT
	description = "Use your gun's scope."

/datum/keybinding/living/gunscope/down(client/user)
	var/mob/living/carbon/C = user.mob
	var/obj/item/gun/firearm

	for(var/obj/item/gun/F in C.held_items)
		firearm = F
		break
	if(!istype(firearm))
		return FALSE
	. = ..()
	firearm.ui_action_click(usr, "scope")
	return TRUE

//-->Gun switch firing mode hotkey
/datum/keybinding/living/gunmode
	hotkey_keys = list("/")
	name = "gunmode"
	full_name = "Gun Firing Mode"
	category = CATEGORY_COMBAT
	description = "Switch your weapon's firing mode."

/datum/keybinding/living/gunmode/down(client/user)
	var/mob/living/carbon/C = user.mob
	var/obj/item/gun/firearm

	for(var/obj/item/gun/F in C.held_items)
		firearm = F
		break
	if(!istype(firearm))
		return FALSE
	. = ..()
	firearm.ui_action_click(usr, "fire mode")
	return TRUE

//-->Reloading your gun with a simple button
/datum/keybinding/living/gunreload
	hotkey_keys = list("ShiftR")
	name = "gunreload"
	full_name = "Quick weapon reload"
	category = CATEGORY_COMBAT
	description = "Reload your weapon with a button."

/datum/keybinding/living/gunreload/down(client/user)
	var/mob/living/carbon/C = user.mob
	C.smart_gunreload()
	return TRUE

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
